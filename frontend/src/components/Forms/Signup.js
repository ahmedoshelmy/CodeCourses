import React from "react";

import { signupInitialValues, SignupSchema } from "../../formsConfig";

import FormResource from "../FormResource";
import EmailField from "../Fields/EmailField";
import PasswordField from "../Fields/PasswordField";
import TextField from "../Fields/TextField";
import api from '../../api'
import { useNavigate } from 'react-router-dom'
export default function Signup() {
  const navigate = useNavigate()
  return (
    <div>
      <h2>Create an Account</h2>
      <FormResource
        url={api.signup}
        initialValues={signupInitialValues}
        validationSchema={SignupSchema}
        submitBtnText="sign up"
        isSaveToken={false}
        afterIt={() => navigate(0)}
      >
        <div className="form-group">
          <TextField name="firstName" label="first name" placeholder="Joe" />
          <TextField name="lastName" label="last name" placeholder="Doe" />
        </div>
        <TextField name="username" label="username" placeholder="JoeDoe" />
        <EmailField />
        <PasswordField name="password" label="password" />
        <PasswordField name="confirmPassword" label="confirm password" />
      </FormResource>
    </div>
  );
}
