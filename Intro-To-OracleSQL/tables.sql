create table users_schema(
    username VARCHAR2(50) NOT NULL,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    passwords VARCHAR2(255) NOT NULL,
    age NUMBER(*, 0) NOT NULL,
    CONSTRAINT pk_username PRIMARY KEY(username)
);

create table groups_schema(
    group_id NUMBER(*, 0) NOT NULL,
    name VARCHAR2(50) NOT NULL,
    description VARCHAR2(50) NOT NULL,
    min_age NUMBER(*, 0),
    max_age NUMBER(*, 0),
    CONSTRAINT pk_group_id PRIMARY KEY(group_id)
);

create table posts_schema(
    post_id NUMBER(*, 0) NOT NULL,
    username VARCHAR2(50) NOT NULL,
    visibility VARCHAR2(1) NOT NULL,
    texts VARCHAR2(140) NOT NULL,
    group_id NUMBER(*, 0),
    CONSTRAINT pk_post_id PRIMARY KEY(post_id),
    CONSTRAINT fk_username
      FOREIGN KEY(username) 
      REFERENCES users_schema(username),
    CONSTRAINT fk_group_id
      FOREIGN KEY(group_id) 
      REFERENCES groups_schema(group_id)
);

create table reactions_schema(
    username VARCHAR2(50) NOT NULL,
    post_id NUMBER(*, 0) NOT NULL,
    type VARCHAR2(1) NOT NULL,
    PRIMARY KEY(username, post_id),
    CONSTRAINT fk_username2
      FOREIGN KEY(username) 
      REFERENCES users_schema(username),
    CONSTRAINT fk_post_id
      FOREIGN KEY(post_id) 
      REFERENCES posts_schema(post_id),
    UNIQUE(type)
);

create table relationships_schema(
    username VARCHAR2(50) NOT NULL,
    other_user VARCHAR2(50) NOT NULL,
    type VARCHAR2(1) NOT NULL,
    PRIMARY KEY(username, other_user, type),
    CONSTRAINT fk_username3
      FOREIGN KEY(username) 
      REFERENCES users_schema(username),
    CONSTRAINT fk_type
      FOREIGN KEY(type) 
      REFERENCES reactions_schema(type)
);

ALTER TABLE relationships_schema 
ADD CONSTRAINT MyUniqueConstraint CHECK(LENGTH(other_user)=LENGTH(username));
