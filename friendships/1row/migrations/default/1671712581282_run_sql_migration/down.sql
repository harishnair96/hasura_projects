-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION public.add_friendship(user1_id integer, user2_id integer)
--  RETURNS users
--  LANGUAGE plpgsql
-- AS $function$
-- BEGIN
--     IF user1_id < user2_id THEN
--       INSERT INTO friendships VALUES (user1_id, user2_id) RETURNING friendships.user1_id, friendships.user2_id;
--     ELSE
--       INSERT INTO friendships VALUES (user2_id, user1_id) RETURNING friendships.user1_id, friendships.user2_id;
--     END IF;
-- END
-- $function$;