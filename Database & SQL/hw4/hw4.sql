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

-- У сущности «заявки на дружбу» имеются следующие поля(атрибуты):
-- initiator_user_id – инициатор;
-- target_user_id – получатель;
-- status - статус;
-- requested_at - дата создания;
-- updated_at - дата последнего обновления.

-- У сущности «пользователи» имеются следующие поля(атрибуты):
-- id – идентификатор;
-- firstname – имя;
-- lastname - фамилия;
-- email - адрес электронной почты.

-- Друзья — это пользователи у которых имеется соответствующая запись (заявка) в сущности 
-- «заявки на дружбу» и в атрибуте status данной сущности указано значение 'approved'.

-- Найдите количество друзей у каждого пользователя. Выведите для каждого пользователя 
-- идентификатор пользователя, имя, фамилию и количество друзей cnt. Сортировка выводимых записей в 
-- порядке возрастания идентификатора пользователя.


-- GPT varsion:
SELECT 
    u.id,
    u.firstname,
    u.lastname,
    (COALESCE(fr1.cnt, 0) + COALESCE(fr2.cnt, 0)) AS total_friends
FROM users u
LEFT JOIN (
    SELECT initiator_user_id, COUNT(*) AS cnt
    FROM friend_requests
    WHERE status = 'approved'
    GROUP BY initiator_user_id
) fr1 ON u.id = fr1.initiator_user_id
LEFT JOIN (
    SELECT target_user_id, COUNT(*) AS cnt
    FROM friend_requests
    WHERE status = 'approved'
    GROUP BY target_user_id
) fr2 ON u.id = fr2.target_user_id
ORDER BY u.id;

-- TRAINER VERSION
SELECT 
    u.id, 
    u.firstname, 
    u.lastname, 
    COUNT(fr.status) AS cnt 
FROM users u
LEFT JOIN friend_requests fr ON (u.id = fr.initiator_user_id or u.id = fr.target_user_id) AND fr.status = 'approved'
GROUP BY u.id
ORDER BY u.id;

-- LEFT JOIN объединяет таблицу users с таблицей friend_requests так, что учитываются записи, 
-- где пользователь является либо инициатором (initiator_user_id), либо целью (target_user_id) заявки на дружбу, и при этом статус заявки равен 'approved'.

-- В условии соединения указано, что u.id = fr.initiator_user_id OR u.id = fr.target_user_id и 
-- при этом fr.status = 'approved', что позволяет учесть все одобренные заявки, связанные с каждым пользователем.

-- COUNT(fr.status) подсчитывает количество одобренных заявок на дружбу для каждого пользователя. 
-- Использование COUNT на fr.status обеспечивает подсчет только тех строк, где есть соответствующие заявки 
-- (т.е., игнорируются случаи, когда после LEFT JOIN в строках оказываются NULL значения из-за отсутствия заявок на дружбу).

-- GROUP BY u.id группирует результаты по идентификатору пользователя, что необходимо для 
-- корректного подсчета количества друзей для каждого пользователя.

-- ORDER BY u.id сортирует результаты запроса по возрастанию идентификатора пользователя.