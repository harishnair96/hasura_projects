CREATE FUNCTION get_friends(user_row users)
RETURNS SETOF friendships AS $$
  SELECT user1_id, user2_id FROM friendships WHERE user1_id = user_row.id 
  UNION ALL 
  SELECT user2_id, user1_id FROM friendships WHERE user2_id = user_row.id;
$$ LANGUAGE sql STABLE;
