CREATE OR REPLACE FUNCTION public.add_friendship(user1_id integer, user2_id integer)
 RETURNS friendships
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO friendships VALUES (user1_id, user2_id);
    INSERT INTO friendships VALUES (user2_id, user1_id);
    RETURN (user1_id, user2_id);
END
$function$;
