CREATE OR REPLACE FUNCTION public.add_friendship(user1_id integer, user2_id integer)
 RETURNS users
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF user1_id < user2_id THEN
      INSERT INTO friendships VALUES (user1_id, user2_id);
      RETURN (user1_id, user2_id);
    ELSE
      INSERT INTO friendships VALUES (user2_id, user1_id);
      RETURN (user2_id, user1_id);
    END IF;
END
$function$;
