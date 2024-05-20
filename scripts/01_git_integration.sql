-----------------------------------------------------
--- Step 1-3 should be run as ACCOUNTADMIN

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE compute_wh;

USE SCHEMA DEMO_DB.DEMO_SCHEMA;


-----------------------------------------------------
--- Step #1 Create a Secret to store the Github PAT



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

