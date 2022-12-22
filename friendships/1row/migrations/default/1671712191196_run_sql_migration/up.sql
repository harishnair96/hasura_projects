CREATE FUNCTION add_friendship(user1_id integer, user2_id integer) RETURNS users AS
$$
BEGIN
    IF user1_id < user2_id THEN
      INSERT INTO friendships VALUES (user1_id, user2_id);
    ELSE
      INSERT INTO friendships VALUES (user2_id, user1_id);
    END IF;
END
$$ LANGUAGE 'plpgsql';
