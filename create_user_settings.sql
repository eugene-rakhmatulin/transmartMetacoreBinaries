create table SEARCHAPP.SEARCH_USER_SETTINGS
(
  ID number,
  USER_ID number,
  SETTING_NAME varchar(255),
  SETTING_VALUE varchar(1024),
  UNIQUE(USER_ID, SETTING_NAME, SETTING_VALUE)
);

GRANT select, delete, update, insert ON searchapp.search_user_settings to biomart;