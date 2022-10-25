# jupyterhub_config.py
c = get_config()

# Change from Jupyter Notebook to JupyterLab
c.Spawner.default_url = '/lab'
c.Spawner.debug = True

# Administrators - set of users who can administer the Hub itself
c.Authenticator.admin_users = {'admin'}

# Set add user command to script supplied
c.LocalAuthenticator.create_system_users = True
c.LocalAuthenticator.add_user_cmd = ['python3','./create-new-user.py','USERNAME']
