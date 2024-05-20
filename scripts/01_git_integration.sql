-----------------------------------------------------
--- Step 1-3 should be run as ACCOUNTADMIN

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE compute_wh;

USE SCHEMA DEMO_DB.DEMO_SCHEMA;


-----------------------------------------------------
--- Step #1 Create a Secret to store the Github PAT
CREATE OR REPLACE SECRET MMALODEMF_GITHUB_SECRET
    TYPE = PASSWORD
    USERNAME = ''
    PASSWORD = ''
;
-----------------------------------------------------
--- Step #2 Create a GIT API Integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = GIT_HTTPS_API
  API_ALLOWED_PREFIXES = ('https://github.com/mmalodemf')
  ALLOWED_AUTHENTICATION_SECRETS = (MMALODEMF_GITHUB_SECRET)
  ENABLED = TRUE;


-----------------------------------------------------
--- Step #3 Create Repository
CREATE OR REPLACE GIT REPOSITORY DEMO_REPO
    API_INTEGRATION = git_api_integration
    GIT_CREDENTIALS = MMALODEMF_GITHUB_SECRET
    ORIGIN = 'https://github.com/mmalodemf/devops-sf.git'
;


SHOW GIT REPOSITORIES;
DESCRIBE GIT REPOSITORY DEMO_REPO;

GRANT READ ON GIT REPOSITORY DEMO_REPO TO ROLE ACCOUNTADMIN;

--USE ROLE DEMO_ROLE;

-----------------------------------------------------
--- Step #4 Working with a Git repository
-----------------------------------------------------
--- when using LIST: "Files paths in git repositories must specify a scope.
--- For example: a branch name, a tag name, or a valid commit hash
--- Commit hashes are between 6 and 40 characters long."

LIST @DEMO_REPO/branches/main;
LIST @DEMO_REPO/tags/tag_name;
LIST @DEMO_REPO/commits/commit_hash;

--- Related SHOW commands
SHOW GIT BRANCHES IN DEMO_REPO;
SHOW GIT TAGS IN DEMO_REPO;

--- Fetch new changes
ALTER GIT REPOSITORY DEMO_REPO FETCH;

