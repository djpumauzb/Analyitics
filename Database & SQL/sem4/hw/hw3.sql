-- Имеется база данных – социальная сеть.

-- База данных содержит сущности:
-- users – пользователи;
-- messages – сообщения;
-- friend_requests – заявки на дружбу;
-- communities – сообщества;
-- users_communities – пользователи сообществ;
-- media_types – типы медиа;
-- media – медиа;
-- likes – лайки;
-- profiles – профили пользователя.
-- У сущности «пользователи» имеются следующие поля(атрибуты):
-- id – идентификатор;
-- firstname – имя;
-- lastname - фамилия;
-- email - адрес электронной почты.

-- У сущности «сообщения» имеются следующие поля(атрибуты):
-- id – идентификатор;
-- from_user_id – отправитель;
-- to_user_id – получатель;
-- body - содержимое;
-- created_at - дата отправки.

-- Выведите идентификаторы пользователей, которые не отправляли ни одного сообщения.
SELECT users.id
FROM users
LEFT JOIN messages ON users.id = messages.from_user_id
WHERE messages.from_user_id IS NULL;