CREATE TABLE boardgames (
    game_id BIGINT PRIMARY KEY,
	thumbnail TEXT,
	image TEXT,
    primary_name TEXT NOT NULL,
	description TEXT,
	year_published INT,
    min_players INT,
    max_players INT,
    playing_time INT,
	min_playing_time INT,
	max_playing_time INT,
    min_age INT
);

CREATE TABLE alternate_names (
    game_id BIGINT,
    alternate_name TEXT NOT NULL,
    PRIMARY KEY (game_id, alternate_name),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id)
);

CREATE TABLE boardgame_stats (
	game_id BIGINT PRIMARY KEY,
	users_rated INT, 
	average DOUBLE PRECISION,
	bayes_average DOUBLE PRECISION,
	stddev DOUBLE PRECISION,
	median DOUBLE PRECISION,
	owned INT,
	trading INT,
	wanting INT, 
	wishing INT, 
	num_comments INT,
	num_weights INT,
	average_weight DOUBLE PRECISION,
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id)
);

CREATE TABLE boardgame_ranks (
    game_id BIGINT REFERENCES boardgames(game_id),
    rank_type TEXT,
    rank_id BIGINT,
    name TEXT,
    friendly_name TEXT,
    value TEXT,
    bayes_average DOUBLE PRECISION,
    PRIMARY KEY (game_id, rank_id)
);

CREATE TABLE polls (
    poll_id SERIAL PRIMARY KEY,
    game_id BIGINT REFERENCES boardgames(game_id),
    name TEXT NOT NULL,
    title TEXT,
    total_votes INT,
	bestwith TEXT,        -- from the summary results for the corresponding poll
	recommendedwith TEXT  -- from the summary results for the corresponding poll
);

CREATE TABLE poll_options (
    poll_id INT REFERENCES polls(poll_id) ON DELETE CASCADE,
    target TEXT NOT NULL,         -- e.g., "2 players", "No necessary text"
    category TEXT,                -- e.g., "Best", "Recommended", or NULL for single-valued polls
    value TEXT,                   -- e.g., number of votes or summary text
    PRIMARY KEY (poll_id, target, category)
);

CREATE TABLE user_comments (
    comment_id SERIAL PRIMARY KEY,
    game_id BIGINT REFERENCES boardgames(game_id),
    username TEXT,
    rating DOUBLE PRECISION,
    comment TEXT
);

-- possible links 
CREATE TABLE publishers (
    publisher_id BIGINT PRIMARY KEY,
    publisher_name TEXT NOT NULL
);

CREATE TABLE designers (
    designer_id BIGINT PRIMARY KEY,
    designer_name TEXT NOT NULL
);

CREATE TABLE artists (
    artist_id BIGINT PRIMARY KEY,
    artist_name TEXT NOT NULL
);

CREATE TABLE categories (
    category_id BIGINT PRIMARY KEY,
    category_name TEXT NOT NULL
);

CREATE TABLE mechanics (
    mechanic_id BIGINT PRIMARY KEY,
    mechanic_name TEXT NOT NULL
);

CREATE TABLE families (
    family_id BIGINT PRIMARY KEY,
    family_name TEXT NOT NULL
);

CREATE TABLE expansions (
    expansion_id BIGINT PRIMARY KEY,
    expansion_name TEXT NOT NULL
);

CREATE TABLE implementations (
    implementation_id BIGINT PRIMARY KEY,
    implementation_name TEXT NOT NULL
);

CREATE TABLE integrations (
    integration_id BIGINT PRIMARY KEY,
    integration_name TEXT NOT NULL
);

CREATE TABLE accessories (
    accessory_id BIGINT PRIMARY KEY,
    accessory_name TEXT NOT NULL
);

CREATE TABLE compilations (
    compilation_id BIGINT PRIMARY KEY,
    compilation_name TEXT NOT NULL
);


-- Bridge tables 
CREATE TABLE boardgame_publishers (
    game_id BIGINT,
    publisher_id BIGINT,
    PRIMARY KEY (game_id, publisher_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

CREATE TABLE boardgame_designers (
    game_id BIGINT,
    designer_id BIGINT,
    PRIMARY KEY (game_id, designer_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (designer_id) REFERENCES designers(designer_id)
);

CREATE TABLE boardgame_artists (
    game_id BIGINT,
    artist_id BIGINT,
    PRIMARY KEY (game_id, artist_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE boardgame_categories (
    game_id BIGINT,
    category_id BIGINT,
    PRIMARY KEY (game_id, category_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE boardgame_mechanics (
    game_id BIGINT,
    mechanic_id BIGINT,
    PRIMARY KEY (game_id, mechanic_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (mechanic_id) REFERENCES mechanics(mechanic_id)
);

CREATE TABLE boardgame_families (
    game_id BIGINT,
    family_id BIGINT,
    PRIMARY KEY (game_id, family_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (family_id) REFERENCES families(family_id)
);

CREATE TABLE boardgame_expansions (
    game_id BIGINT,
    expansion_id BIGINT,
    PRIMARY KEY (game_id, expansion_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (expansion_id) REFERENCES expansions(expansion_id)
);

CREATE TABLE boardgame_implementations (
    game_id BIGINT,
    implementation_id BIGINT,
    PRIMARY KEY (game_id, implementation_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (implementation_id) REFERENCES implementations(implementation_id)
);

CREATE TABLE boardgame_integrations (
    game_id BIGINT,
    integration_id BIGINT,
    PRIMARY KEY (game_id, integration_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (integration_id) REFERENCES integrations(integration_id)
);

CREATE TABLE boardgame_accessories (
    game_id BIGINT,
    accessory_id BIGINT,
    PRIMARY KEY (game_id, accessory_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (accessory_id) REFERENCES accessories(accessory_id)
);

CREATE TABLE boardgame_compilations (
    game_id BIGINT,
    compilation_id BIGINT,
    PRIMARY KEY (game_id, compilation_id),
	FOREIGN KEY (game_id) REFERENCES boardgames(game_id),
	FOREIGN KEY (compilation_id) REFERENCES compilations(compilation_id)
);
