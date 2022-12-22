alter table "public"."friendships" add constraint "ordering" check (user1_id < user2_id);
