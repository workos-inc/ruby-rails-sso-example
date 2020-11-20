# rails-sso-example

An example Ruby on Rails application demonstrating how SSO works with WorkOS and Rails.
The application is built with Rails 6 and Bootstrap with Webpack, and also uses Devise.

## Get Started

### Requirements

- Ruby 2.6
- Rails 6
- Foreman gem

### Clone, install and migrate the database

```bash
git clone https://github.com/workos-inc/rails-sso-example.git
cd rails-sso-example
bundle install
yarn install --check-files
rails db:migrate
gem install foreman
```

## Set up SSO Connection with WorkOS

Use the [WorkOS documentation](https://workos.com/docs/sso/guide/introduction) to set up an SSO connection with your identity provider of choice.

### Setup in the WorkOS Dashboard

You'll need to create an [SSO Connection](https://dashboard.workos.com/sso/connections). Additionally, add a [Redirect URI](https://dashboard.workos.com/sso/configuration) with the value `http://localhost:3000/sso/callback`.

### Setup environment variables with the Figaro gem

```bash
bundle exec figaro install
```

Update `config/application.yml` with your [API Key](https://dashboard.workos.com/api-keys) and [Project ID](https://dashboard.workos.com/sso/configuration):

```yaml
workos_api_key: $YOUR_WORKOS_API_KEY
workos_project_id: $YOUR_PROJECT_ID
```

## Run the application and sign in using SSO

Start the rails server:
```bash
rails server
```

Start the webpack server:
```bash
foreman start -f Procfile.dev
```

### Application Flow

- Head to `http://localhost:3000`
- If you're not authenticated, the site will re-direct to `http://localhost:3000/users/sign_in`
- Here you can authenticate with Username/Password, or with the SSO you set up with WorkOS
- To authenticate with SSO, input the domain you used to set up your WorkOS connection, and select the `Sign in with SSO` button
- After successfully authenticating, you should see a JSON print out of your user information

For more information, see the [WorkOS Ruby SDK documentation](https://docs.workos.com/sdk/ruby).
