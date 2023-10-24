--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-08-06 17:01:03

SET statement_timeout = 0;
SET lock_timeout=0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3408 (class 1262 OID 49203)
-- Name: Booking2; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Booking2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';


ALTER DATABASE "Booking2" OWNER TO postgres;

\connect "Booking2"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 54282)
-- Name: attivita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attivita (
    id_attivita integer NOT NULL,
    nome character varying(30) NOT NULL,
    prezzo integer NOT NULL,
    voto smallint,
    hotel integer NOT NULL,
    affiliata boolean NOT NULL,
    sconto double precision
);


ALTER TABLE public.attivita OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 54216)
-- Name: camera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.camera (
    id_camera integer NOT NULL,
    costo_giornaliero integer NOT NULL,
    num_max_ospiti integer NOT NULL,
    suite boolean NOT NULL,
    hotel integer NOT NULL
);


ALTER TABLE public.camera OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 54195)
-- Name: carta_di_debito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carta_di_debito (
    numero_carta bigint NOT NULL,
    cvc smallint NOT NULL,
    intestatario character varying(40) NOT NULL,
    data_di_scadenza date NOT NULL
);


ALTER TABLE public.carta_di_debito OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 54211)
-- Name: hotel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel (
    id_hotel integer NOT NULL,
    nome character varying(30) NOT NULL,
    email character varying(30) NOT NULL,
    telefono character varying(16) NOT NULL,
    cap character(5) NOT NULL,
    via character varying(50) NOT NULL,
    n_civico character varying(10) NOT NULL,
    "città" character varying(50) NOT NULL,
    stato character varying(20) NOT NULL
);


ALTER TABLE public.hotel OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 54267)
-- Name: hotelservizi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotelservizi (
    id_hotel integer NOT NULL,
    id_servizio integer NOT NULL
);


ALTER TABLE public.hotelservizi OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 54242)
-- Name: omaggi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.omaggi (
    id_omaggio integer NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.omaggi OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 54247)
-- Name: omaggisuite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.omaggisuite (
    id_omaggio integer NOT NULL,
    id_suite integer NOT NULL
);


ALTER TABLE public.omaggisuite OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 54226)
-- Name: prenotazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prenotazione (
    id_prenotazione integer NOT NULL,
    numero_di_ospiti smallint NOT NULL,
    rimborsabile boolean NOT NULL,
    dataorainizio timestamp without time zone NOT NULL,
    dataorafine timestamp without time zone NOT NULL,
    utente integer NOT NULL,
    camera integer NOT NULL,
    CONSTRAINT prenotazione_check CHECK ((dataorainizio < dataorafine))
);


ALTER TABLE public.prenotazione OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 54292)
-- Name: recensione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recensione (
    commento character varying(200),
    hotel integer NOT NULL,
    attivita integer NOT NULL,
    prenotazione integer NOT NULL,
    punteggio_hotel smallint NOT NULL,
    punteggio_attivita smallint,
    CONSTRAINT recensione_punteggio_attivita_check CHECK (((punteggio_attivita >= 1) AND (punteggio_attivita <= 10))),
    CONSTRAINT recensione_punteggio_hotel_check CHECK (((punteggio_hotel >= 1) AND (punteggio_hotel <= 10)))
);


ALTER TABLE public.recensione OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 54262)
-- Name: servizi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servizi (
    id_servizio integer NOT NULL,
    nome character varying(40) NOT NULL
);


ALTER TABLE public.servizi OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 54200)
-- Name: utente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utente (
    id_utente integer NOT NULL,
    nome character varying(20) NOT NULL,
    cognome character varying(20) NOT NULL,
    email character varying(30) NOT NULL,
    password character varying(50) NOT NULL,
    telefono character varying(16) NOT NULL,
    premium boolean NOT NULL,
    sconto double precision,
    carta_debito bigint NOT NULL,
    CONSTRAINT utente_check CHECK ((((premium = true) AND (sconto > (0)::double precision) AND (sconto < (1)::double precision)) OR ((premium = false) AND (sconto IS NULL))))
);


ALTER TABLE public.utente OWNER TO postgres;

--
-- TOC entry 3401 (class 0 OID 54282)
-- Dependencies: 223
-- Data for Name: attivita; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.attivita VALUES (1, 'Escursione in Montagna', 50, 4, 1, false, NULL);
INSERT INTO public.attivita VALUES (2, 'Tour delle Città', 30, 8, 1, true, 0.05);
INSERT INTO public.attivita VALUES (3, 'Cena Romantica', 80, 2, 1, false, NULL);
INSERT INTO public.attivita VALUES (4, 'Corso di Cucina', 40, 4, 2, false, NULL);
INSERT INTO public.attivita VALUES (5, 'Spa e Massaggio', 60, 3, 2, true, 0.1);
INSERT INTO public.attivita VALUES (6, 'Tour in Bicicletta', 25, 5, 2, false, NULL);
INSERT INTO public.attivita VALUES (7, 'Gita in Barca', 70, 1, 3, false, NULL);
INSERT INTO public.attivita VALUES (8, 'Lezione di Surf', 45, 3, 3, true, 0.07);
INSERT INTO public.attivita VALUES (9, 'Visita ai Musei', 20, 4, 3, false, NULL);
INSERT INTO public.attivita VALUES (10, 'Tour Enogastronomico', 55, 10, 4, true, 0.01);
INSERT INTO public.attivita VALUES (11, 'Escursione in Jeep', 65, 4, 4, false, NULL);
INSERT INTO public.attivita VALUES (12, 'Attività Sportive', 35, 7, 4, false, NULL);
INSERT INTO public.attivita VALUES (13, 'Yoga e Meditazione', 40, 6, 5, true, 0.15);
INSERT INTO public.attivita VALUES (14, 'Laboratorio di Pittura', 30, 5, 5, false, NULL);
INSERT INTO public.attivita VALUES (15, 'Giardino Botanico', 25, 8, 5, true, 0.2);
INSERT INTO public.attivita VALUES (16, 'Tour in Elicottero', 120, 5, 6, false, NULL);
INSERT INTO public.attivita VALUES (17, 'Parco Divertimenti', 60, 4, 6, true, 0.09);
INSERT INTO public.attivita VALUES (18, 'Caccia al Tesoro', 40, 1, 6, false, NULL);
INSERT INTO public.attivita VALUES (19, 'Percorso di Arrampicata', 50, 4, 7, true, 0.4);
INSERT INTO public.attivita VALUES (20, 'Cinema all Aperto', 20, 3, 7, true, 0.6);
INSERT INTO public.attivita VALUES (21, 'Tour in Barca a Vela', 70, 2, 8, false, NULL);
INSERT INTO public.attivita VALUES (22, 'Degustazione di Vini', 40, 4, 8, true, 0.05);
INSERT INTO public.attivita VALUES (23, 'Tour di Paddle Board', 30, 7, 8, false, NULL);
INSERT INTO public.attivita VALUES (24, 'Spettacolo di Cabaret', 55, 9, 9, false, NULL);
INSERT INTO public.attivita VALUES (25, 'Visita a Parchi Naturali', 25, 4, 9, false, NULL);
INSERT INTO public.attivita VALUES (26, 'Caccia al Tesoro', 40, 7, 9, true, 0.5);
INSERT INTO public.attivita VALUES (27, 'Gita in Bicicletta', 35, 4, 10, false, NULL);
INSERT INTO public.attivita VALUES (28, 'Esplorazione Sotterranea', 60, 6, 13, true, 0.2);
INSERT INTO public.attivita VALUES (29, 'Tour della Città Antica', 30, 5, 11, false, NULL);
INSERT INTO public.attivita VALUES (30, 'Escursione in Montagna', 50, 8, 12, true, 0.2);


--
-- TOC entry 3395 (class 0 OID 54216)
-- Dependencies: 217
-- Data for Name: camera; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.camera VALUES (1, 100, 2, false, 4);
INSERT INTO public.camera VALUES (2, 150, 2, true, 4);
INSERT INTO public.camera VALUES (3, 120, 3, false, 5);
INSERT INTO public.camera VALUES (4, 180, 4, true, 5);
INSERT INTO public.camera VALUES (5, 200, 2, false, 6);
INSERT INTO public.camera VALUES (6, 250, 3, true, 6);
INSERT INTO public.camera VALUES (7, 80, 1, false, 7);
INSERT INTO public.camera VALUES (8, 120, 2, false, 7);
INSERT INTO public.camera VALUES (9, 180, 4, true, 8);
INSERT INTO public.camera VALUES (10, 100, 2, false, 8);
INSERT INTO public.camera VALUES (11, 250, 3, true, 9);
INSERT INTO public.camera VALUES (12, 150, 2, false, 9);
INSERT INTO public.camera VALUES (13, 120, 3, false, 10);
INSERT INTO public.camera VALUES (14, 180, 4, true, 10);
INSERT INTO public.camera VALUES (15, 200, 2, false, 11);
INSERT INTO public.camera VALUES (16, 250, 3, true, 11);
INSERT INTO public.camera VALUES (17, 80, 1, false, 12);
INSERT INTO public.camera VALUES (18, 120, 2, false, 12);
INSERT INTO public.camera VALUES (19, 180, 4, true, 13);
INSERT INTO public.camera VALUES (20, 100, 2, false, 13);
INSERT INTO public.camera VALUES (21, 150, 2, false, 1);
INSERT INTO public.camera VALUES (22, 180, 3, true, 1);
INSERT INTO public.camera VALUES (23, 100, 2, false, 2);
INSERT INTO public.camera VALUES (24, 200, 4, true, 2);
INSERT INTO public.camera VALUES (25, 120, 2, false, 3);
INSERT INTO public.camera VALUES (26, 250, 3, true, 1);
INSERT INTO public.camera VALUES (27, 240, 3, true, 1);


--
-- TOC entry 3392 (class 0 OID 54195)
-- Dependencies: 214
-- Data for Name: carta_di_debito; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.carta_di_debito VALUES (1234567890123456, 123, 'Mario Rossi', '2023-12-31');
INSERT INTO public.carta_di_debito VALUES (2345678901234567, 234, 'Laura Bianchi', '2024-06-30');
INSERT INTO public.carta_di_debito VALUES (6958878901234567, 345, 'Luca Verdi', '2023-09-30');
INSERT INTO public.carta_di_debito VALUES (1111222233334444, 456, 'Giulia Neri', '2024-03-31');
INSERT INTO public.carta_di_debito VALUES (5555666677778888, 567, 'Alessio Gialli', '2023-11-30');
INSERT INTO public.carta_di_debito VALUES (9876543210987654, 678, 'Elena Rosa', '2025-01-31');
INSERT INTO public.carta_di_debito VALUES (4444333322221111, 789, 'Davide Marroni', '2024-08-31');
INSERT INTO public.carta_di_debito VALUES (9999111122223333, 890, 'Sara Blu', '2023-10-31');
INSERT INTO public.carta_di_debito VALUES (2345656901234568, 901, 'Francesca Viola', '2025-05-31');
INSERT INTO public.carta_di_debito VALUES (4442555566667747, 123, 'Roberto Robertini', '2024-02-28');
INSERT INTO public.carta_di_debito VALUES (6661777587832919, 234, 'Anna Bianchi', '2023-11-30');
INSERT INTO public.carta_di_debito VALUES (4443555966677778, 789, 'Daniele Marroni', '2024-07-31');
INSERT INTO public.carta_di_debito VALUES (6666777788889999, 890, 'Elisa Blu', '2025-02-28');
INSERT INTO public.carta_di_debito VALUES (1234566850123456, 901, 'Antonio Viola', '2023-09-30');
INSERT INTO public.carta_di_debito VALUES (8888999900001111, 12, 'Giorgia Gialli', '2024-05-31');


--
-- TOC entry 3394 (class 0 OID 54211)
-- Dependencies: 216
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hotel VALUES (1, 'Hotel Milano', 'milano@example.com', '3934949942', '20121', 'Via Roma', '10', 'Milano', 'Italia');
INSERT INTO public.hotel VALUES (2, 'Hotel Roma', 'roma@example.com', '3838231281', '00118', 'Via Venezia', '25', 'Roma', 'Italia');
INSERT INTO public.hotel VALUES (3, 'Hotel Paris', 'paris@example.com', '3133456389', '75008', 'Rue de la Paix', '45', 'Parigi', 'Francia');
INSERT INTO public.hotel VALUES (4, 'Grand Hotel', 'grandhotel@example.com', '4445556666', '12345', 'Main Street', '100', 'New York', 'USA');
INSERT INTO public.hotel VALUES (5, 'Hotel de Ville', 'hoteldeville@example.com', '7778889999', '75001', 'Rue de Rivoli', '50', 'Pargi', 'Francia');
INSERT INTO public.hotel VALUES (6, 'Beach Resort', 'beachresort@example.com', '1112223333', '34256', 'Coastal Road', '78', 'Miami', 'USA');
INSERT INTO public.hotel VALUES (7, 'Alpine Lodge', 'alpinelodge@example.com', '5556667777', '12345', 'Mountain View', '15', 'Zermatt', 'Switzerland');
INSERT INTO public.hotel VALUES (8, 'Seaside Inn', 'seasideinn@example.com', '8889990000', '90210', 'Beach Boulevard', '200', 'Los Angeles', 'USA');
INSERT INTO public.hotel VALUES (9, 'Mountain Retreat', 'mountainretreat@example.com', '2223334444', '54321', 'Pine Street', '10', 'Aspen', 'USA');
INSERT INTO public.hotel VALUES (10, 'City Center Hotel', 'citycenterhotel@example.com', '6667778888', '10001', 'Central Avenue', '123', 'London', 'UK');
INSERT INTO public.hotel VALUES (11, 'Tropical Paradise Resort', 'tropicalresort@example.com', '4445556666', '80001', 'Palm Beach', '50', 'Bali', 'Indonesia');
INSERT INTO public.hotel VALUES (12, 'Historic Mansion', 'historicmansion@example.com', '7778889999', '12345', 'Historic Street', '100', 'Vienna', 'Austria');
INSERT INTO public.hotel VALUES (13, 'Seaview Hotel', 'seaviewhotel@example.com', '2223334444', '50001', 'Ocean Drive', '25', 'Sydney', 'Australia');


--
-- TOC entry 3400 (class 0 OID 54267)
-- Dependencies: 222
-- Data for Name: hotelservizi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hotelservizi VALUES (1, 3);
INSERT INTO public.hotelservizi VALUES (1, 5);
INSERT INTO public.hotelservizi VALUES (2, 2);
INSERT INTO public.hotelservizi VALUES (2, 4);
INSERT INTO public.hotelservizi VALUES (2, 6);
INSERT INTO public.hotelservizi VALUES (3, 1);
INSERT INTO public.hotelservizi VALUES (3, 3);
INSERT INTO public.hotelservizi VALUES (3, 7);
INSERT INTO public.hotelservizi VALUES (4, 8);
INSERT INTO public.hotelservizi VALUES (4, 10);
INSERT INTO public.hotelservizi VALUES (4, 12);
INSERT INTO public.hotelservizi VALUES (5, 1);
INSERT INTO public.hotelservizi VALUES (5, 4);
INSERT INTO public.hotelservizi VALUES (5, 13);
INSERT INTO public.hotelservizi VALUES (6, 7);
INSERT INTO public.hotelservizi VALUES (6, 11);
INSERT INTO public.hotelservizi VALUES (6, 15);
INSERT INTO public.hotelservizi VALUES (7, 5);
INSERT INTO public.hotelservizi VALUES (7, 9);
INSERT INTO public.hotelservizi VALUES (7, 17);
INSERT INTO public.hotelservizi VALUES (8, 18);
INSERT INTO public.hotelservizi VALUES (8, 21);
INSERT INTO public.hotelservizi VALUES (8, 24);
INSERT INTO public.hotelservizi VALUES (9, 8);
INSERT INTO public.hotelservizi VALUES (9, 14);
INSERT INTO public.hotelservizi VALUES (9, 20);
INSERT INTO public.hotelservizi VALUES (10, 2);
INSERT INTO public.hotelservizi VALUES (10, 6);
INSERT INTO public.hotelservizi VALUES (10, 22);
INSERT INTO public.hotelservizi VALUES (11, 3);
INSERT INTO public.hotelservizi VALUES (11, 6);
INSERT INTO public.hotelservizi VALUES (11, 12);
INSERT INTO public.hotelservizi VALUES (12, 1);
INSERT INTO public.hotelservizi VALUES (12, 5);
INSERT INTO public.hotelservizi VALUES (12, 17);
INSERT INTO public.hotelservizi VALUES (13, 2);
INSERT INTO public.hotelservizi VALUES (13, 9);
INSERT INTO public.hotelservizi VALUES (13, 23);
INSERT INTO public.hotelservizi VALUES (13, 24);


--
-- TOC entry 3397 (class 0 OID 54242)
-- Dependencies: 219
-- Data for Name: omaggi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.omaggi VALUES (1, 'Cesto di Frutta');
INSERT INTO public.omaggi VALUES (2, 'Bottiglia di Vino');
INSERT INTO public.omaggi VALUES (3, 'Set di Prodotti da Bagno');
INSERT INTO public.omaggi VALUES (4, 'Colazione Gratuita');
INSERT INTO public.omaggi VALUES (5, 'Buono Sconto per il Ristorante');
INSERT INTO public.omaggi VALUES (6, 'Pantofole e Accappatoio');
INSERT INTO public.omaggi VALUES (7, 'Cestino di Benvenuto');
INSERT INTO public.omaggi VALUES (8, 'Pacchetto Spa');
INSERT INTO public.omaggi VALUES (9, 'Accesso Gratuito alla Palestra');
INSERT INTO public.omaggi VALUES (10, 'Aperitivo di Benvenuto');
INSERT INTO public.omaggi VALUES (11, 'Pacchetto Romantico');
INSERT INTO public.omaggi VALUES (12, 'Tour Guidato della Città');
INSERT INTO public.omaggi VALUES (13, 'Buono Sconto per il Centro Benessere');
INSERT INTO public.omaggi VALUES (14, 'Pacchetto Relax');
INSERT INTO public.omaggi VALUES (15, 'Bottiglia di Champagne');
INSERT INTO public.omaggi VALUES (16, 'Massaggio Rilassante');
INSERT INTO public.omaggi VALUES (17, 'Gita in Barca a Vela');
INSERT INTO public.omaggi VALUES (18, 'Pacchetto Avventura');
INSERT INTO public.omaggi VALUES (19, 'Gita in Jeep');


--
-- TOC entry 3398 (class 0 OID 54247)
-- Dependencies: 220
-- Data for Name: omaggisuite; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.omaggisuite VALUES (1, 2);
INSERT INTO public.omaggisuite VALUES (2, 4);
INSERT INTO public.omaggisuite VALUES (3, 6);
INSERT INTO public.omaggisuite VALUES (4, 9);
INSERT INTO public.omaggisuite VALUES (5, 11);
INSERT INTO public.omaggisuite VALUES (6, 14);
INSERT INTO public.omaggisuite VALUES (7, 16);
INSERT INTO public.omaggisuite VALUES (8, 19);
INSERT INTO public.omaggisuite VALUES (9, 22);
INSERT INTO public.omaggisuite VALUES (10, 24);
INSERT INTO public.omaggisuite VALUES (11, 26);
INSERT INTO public.omaggisuite VALUES (12, 2);
INSERT INTO public.omaggisuite VALUES (13, 4);
INSERT INTO public.omaggisuite VALUES (14, 6);
INSERT INTO public.omaggisuite VALUES (15, 9);
INSERT INTO public.omaggisuite VALUES (16, 11);
INSERT INTO public.omaggisuite VALUES (17, 14);
INSERT INTO public.omaggisuite VALUES (18, 16);
INSERT INTO public.omaggisuite VALUES (19, 19);
INSERT INTO public.omaggisuite VALUES (1, 4);
INSERT INTO public.omaggisuite VALUES (2, 6);
INSERT INTO public.omaggisuite VALUES (2, 9);
INSERT INTO public.omaggisuite VALUES (3, 11);
INSERT INTO public.omaggisuite VALUES (3, 14);
INSERT INTO public.omaggisuite VALUES (4, 16);
INSERT INTO public.omaggisuite VALUES (4, 19);
INSERT INTO public.omaggisuite VALUES (5, 22);
INSERT INTO public.omaggisuite VALUES (5, 24);
INSERT INTO public.omaggisuite VALUES (6, 26);
INSERT INTO public.omaggisuite VALUES (7, 2);
INSERT INTO public.omaggisuite VALUES (7, 4);
INSERT INTO public.omaggisuite VALUES (8, 6);
INSERT INTO public.omaggisuite VALUES (8, 9);
INSERT INTO public.omaggisuite VALUES (9, 11);
INSERT INTO public.omaggisuite VALUES (9, 14);
INSERT INTO public.omaggisuite VALUES (10, 16);
INSERT INTO public.omaggisuite VALUES (10, 19);
INSERT INTO public.omaggisuite VALUES (11, 22);
INSERT INTO public.omaggisuite VALUES (11, 24);
INSERT INTO public.omaggisuite VALUES (12, 26);
INSERT INTO public.omaggisuite VALUES (13, 2);
INSERT INTO public.omaggisuite VALUES (14, 9);
INSERT INTO public.omaggisuite VALUES (15, 11);
INSERT INTO public.omaggisuite VALUES (15, 14);
INSERT INTO public.omaggisuite VALUES (16, 16);
INSERT INTO public.omaggisuite VALUES (16, 19);
INSERT INTO public.omaggisuite VALUES (16, 27);


--
-- TOC entry 3396 (class 0 OID 54226)
-- Dependencies: 218
-- Data for Name: prenotazione; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.prenotazione VALUES (1, 2, true, '2023-07-23 14:00:00', '2023-07-25 12:00:00', 1, 1);
INSERT INTO public.prenotazione VALUES (2, 3, true, '2023-08-10 15:30:00', '2023-08-15 10:00:00', 2, 2);
INSERT INTO public.prenotazione VALUES (3, 1, false, '2023-09-05 12:00:00', '2023-09-07 09:00:00', 3, 3);
INSERT INTO public.prenotazione VALUES (4, 2, true, '2023-08-28 10:00:00', '2023-09-02 16:00:00', 4, 4);
INSERT INTO public.prenotazione VALUES (5, 1, false, '2023-10-12 18:00:00', '2023-10-15 11:30:00', 5, 5);
INSERT INTO public.prenotazione VALUES (6, 4, true, '2023-11-08 14:00:00', '2023-11-12 12:00:00', 6, 6);
INSERT INTO public.prenotazione VALUES (7, 2, false, '2023-12-05 12:30:00', '2023-12-09 10:00:00', 7, 7);
INSERT INTO public.prenotazione VALUES (8, 1, true, '2023-08-20 08:00:00', '2023-08-23 16:00:00', 8, 8);
INSERT INTO public.prenotazione VALUES (9, 3, true, '2023-09-15 10:00:00', '2023-09-20 11:00:00', 9, 9);
INSERT INTO public.prenotazione VALUES (10, 2, false, '2023-11-01 14:30:00', '2023-11-04 09:00:00', 10, 10);
INSERT INTO public.prenotazione VALUES (11, 1, true, '2023-10-05 12:00:00', '2023-10-07 10:00:00', 11, 11);
INSERT INTO public.prenotazione VALUES (12, 2, true, '2023-10-18 15:00:00', '2023-10-22 12:00:00', 12, 12);
INSERT INTO public.prenotazione VALUES (13, 1, false, '2023-12-02 10:00:00', '2023-12-04 09:00:00', 13, 13);
INSERT INTO public.prenotazione VALUES (14, 4, true, '2023-05-25 12:00:00', '2023-05-30 11:00:00', 14, 14);
INSERT INTO public.prenotazione VALUES (15, 2, false, '2023-11-15 14:30:00', '2023-11-20 10:00:00', 15, 15);
INSERT INTO public.prenotazione VALUES (16, 3, true, '2019-12-10 15:00:00', '2019-12-15 11:00:00', 9, 1);
INSERT INTO public.prenotazione VALUES (17, 1, false, '2021-11-28 12:00:00', '2021-11-30 09:00:00', 3, 19);
INSERT INTO public.prenotazione VALUES (18, 2, true, '2021-10-22 10:00:00', '2021-10-25 18:00:00', 8, 22);
INSERT INTO public.prenotazione VALUES (19, 1, false, '2023-09-18 18:00:00', '2023-09-20 10:30:00', 11, 7);
INSERT INTO public.prenotazione VALUES (20, 2, true, '2022-08-28 14:00:00', '2022-09-01 12:00:00', 7, 20);
INSERT INTO public.prenotazione VALUES (21, 3, true, '2021-11-15 11:30:00', '2021-11-20 10:00:00', 2, 4);
INSERT INTO public.prenotazione VALUES (22, 1, false, '2020-12-18 12:00:00', '2020-12-20 09:00:00', 12, 6);
INSERT INTO public.prenotazione VALUES (23, 2, true, '2023-09-25 10:00:00', '2023-09-30 16:00:00', 14, 11);
INSERT INTO public.prenotazione VALUES (24, 1, false, '2020-10-10 18:00:00', '2020-10-12 11:30:00', 10, 24);
INSERT INTO public.prenotazione VALUES (25, 4, true, '2022-11-28 14:00:00', '2022-12-03 12:00:00', 6, 25);
INSERT INTO public.prenotazione VALUES (26, 2, true, '2021-10-15 12:30:00', '2021-10-20 10:00:00', 5, 8);
INSERT INTO public.prenotazione VALUES (27, 1, false, '2023-04-05 12:00:00', '2023-04-07 09:00:00', 4, 20);
INSERT INTO public.prenotazione VALUES (28, 3, true, '2020-08-25 15:00:00', '2020-08-30 11:00:00', 15, 13);
INSERT INTO public.prenotazione VALUES (29, 1, false, '2020-12-02 12:00:00', '2020-12-04 09:00:00', 1, 25);
INSERT INTO public.prenotazione VALUES (30, 2, true, '2021-09-18 10:00:00', '2021-09-22 18:00:00', 13, 26);
INSERT INTO public.prenotazione VALUES (31, 1, false, '2021-10-10 18:00:00', '2021-10-12 11:30:00', 10, 21);
INSERT INTO public.prenotazione VALUES (32, 4, true, '2022-12-28 14:00:00', '2022-12-30 12:00:00', 6, 22);
INSERT INTO public.prenotazione VALUES (33, 2, true, '2023-10-15 12:30:00', '2023-10-20 10:00:00', 5, 18);
INSERT INTO public.prenotazione VALUES (34, 1, false, '2021-09-05 12:00:00', '2021-09-07 09:00:00', 4, 16);
INSERT INTO public.prenotazione VALUES (35, 3, true, '2022-08-25 15:00:00', '2022-08-30 11:00:00', 15, 17);
INSERT INTO public.prenotazione VALUES (36, 1, false, '2021-12-02 12:00:00', '2021-12-04 09:00:00', 1, 23);


--
-- TOC entry 3402 (class 0 OID 54292)
-- Dependencies: 224
-- Data for Name: recensione; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recensione VALUES ('Hotel poco accogliente e personale non molto gentile', 1, 5, 10, 1, 7);
INSERT INTO public.recensione VALUES ('Molto soddisfatto del soggiorno', 2, 12, 15, 8, 9);
INSERT INTO public.recensione VALUES ('Attività emozionante e divertente', 3, 25, 12, 7, 8);
INSERT INTO public.recensione VALUES ('Un hotel con vista mozzafiato', 4, 8, 11, 10, 7);
INSERT INTO public.recensione VALUES ('Ottima cucina nel ristorante dell''hotel', 5, 15, 1, 9, 8);
INSERT INTO public.recensione VALUES ('Escursione interessante e ben organizzata', 6, 22, 4, 8, 9);
INSERT INTO public.recensione VALUES ('Personale cordiale e disponibile', 7, 3, 3, 9, 8);
INSERT INTO public.recensione VALUES ('Servizio in camera efficiente e veloce', 8, 18, 1, 7, 9);
INSERT INTO public.recensione VALUES ('Bella esperienza di benessere al centro spa', 9, 29, 4, 8, 10);
INSERT INTO public.recensione VALUES ('Un soggiorno rilassante e piacevole', 10, 11, 7, 9, 8);
INSERT INTO public.recensione VALUES ('Staff cortese e professionale', 11, 4, 10, 9, 7);
INSERT INTO public.recensione VALUES ('Attività adrenalinica e avventurosa', 12, 19, 13, 8, 9);
INSERT INTO public.recensione VALUES ('Un hotel di charme con atmosfera romantica', 13, 20, 14, 10, 8);
INSERT INTO public.recensione VALUES ('Una piacevole esperienza culinaria', 1, 9, 6, 9, 8);
INSERT INTO public.recensione VALUES ('Escursione tra la natura incontaminata', 2, 26, 7, 8, 9);
INSERT INTO public.recensione VALUES ('Personale sempre disponibile e attento', 3, 1, 8, 9, 8);
INSERT INTO public.recensione VALUES ('Servizio navetta molto comodo', 4, 13, 9, 7, 9);
INSERT INTO public.recensione VALUES ('Un soggiorno da ricordare', 5, 23, 2, 9, 8);
INSERT INTO public.recensione VALUES ('Attività divertente per tutta la famiglia', 6, 10, 5, 8, 9);
INSERT INTO public.recensione VALUES ('Bellissima piscina con vista panoramica', 7, 7, 8, 10, 8);


--
-- TOC entry 3399 (class 0 OID 54262)
-- Dependencies: 221
-- Data for Name: servizi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.servizi VALUES (1, 'Piscina');
INSERT INTO public.servizi VALUES (2, 'Palestra');
INSERT INTO public.servizi VALUES (3, 'Centro Benessere');
INSERT INTO public.servizi VALUES (4, 'Ristorante');
INSERT INTO public.servizi VALUES (5, 'Servizio in Camera');
INSERT INTO public.servizi VALUES (6, 'Connessione Wi-Fi');
INSERT INTO public.servizi VALUES (7, 'Navetta Aeroportuale');
INSERT INTO public.servizi VALUES (8, 'Servizio di Pulizia');
INSERT INTO public.servizi VALUES (9, 'Reception 24 ore');
INSERT INTO public.servizi VALUES (10, 'Bar');
INSERT INTO public.servizi VALUES (11, 'Lavanderia');
INSERT INTO public.servizi VALUES (12, 'Area Giochi per Bambini');
INSERT INTO public.servizi VALUES (13, 'Centro Congressi');
INSERT INTO public.servizi VALUES (14, 'Servizio Navetta');
INSERT INTO public.servizi VALUES (15, 'Parcheggio Gratuito');
INSERT INTO public.servizi VALUES (16, 'Servizio in Spiaggia');
INSERT INTO public.servizi VALUES (17, 'Servizio Noleggio Biciclette');
INSERT INTO public.servizi VALUES (18, 'Campo da Tennis');
INSERT INTO public.servizi VALUES (19, 'Mini Club per Bambini');
INSERT INTO public.servizi VALUES (20, 'Ristorante Gourmet');
INSERT INTO public.servizi VALUES (21, 'Servizio Navetta per il Centro');
INSERT INTO public.servizi VALUES (22, 'Sauna e Bagno Turco');
INSERT INTO public.servizi VALUES (23, 'Servizio in Camera 24 ore');
INSERT INTO public.servizi VALUES (24, 'Ristorante Panoramico');


--
-- TOC entry 3393 (class 0 OID 54200)
-- Dependencies: 215
-- Data for Name: utente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.utente VALUES (1, 'Mario', 'Rossi', 'marior@email.com', 'password123', '+61298765432', false, NULL, 1234567890123456);
INSERT INTO public.utente VALUES (2, 'Laura', 'Bianchi', 'laurab@email.com', 'securepass', '+14165557890', true, 0.1, 2345678901234567);
INSERT INTO public.utente VALUES (3, 'Luca', 'Verdi', 'lucav@email.com', 'secretword', '+442071238901', false, NULL, 6958878901234567);
INSERT INTO public.utente VALUES (4, 'Giulia', 'Neri', 'giuliablacks@email.com', 'confidential', '+14155556789', true, 0.05, 1111222233334444);
INSERT INTO public.utente VALUES (5, 'Alessio', 'Gialli', 'alessioyellows@email.com', 'topsecret', '+12029182132', false, NULL, 5555666677778888);
INSERT INTO public.utente VALUES (6, 'Linda', 'Marrone', 'linda@email.com', 'classified', '+376604447', true, 0.3, 9876543210987654);
INSERT INTO public.utente VALUES (7, 'Davide', 'Marrons', 'davidonem@gmail.com', 'hiddenpass', '+376669004', false, NULL, 4444333322221111);
INSERT INTO public.utente VALUES (8, 'Sara', 'Blu', 'willitbeblue@email.com', 'mypassphrase', '+43 697632013535', true, 0.2, 9999111122223333);
INSERT INTO public.utente VALUES (9, 'Francesca', 'Viola', 'Franciii@email.com', 'hiddenpassword', '+43653184217', false, NULL, 2345656901234568);
INSERT INTO public.utente VALUES (10, 'Anna', 'Bianchi', 'paolo@email.com', 'mysecret', '+43653184217', true, 0.15, 6661777587832919);
INSERT INTO public.utente VALUES (11, 'Daniele', ' Marroni', 'Danielbroown@email.com', 'hiddenkey', '+2977701368', true, 0.1, 4443555966677778);
INSERT INTO public.utente VALUES (12, 'Roberto', 'Robertini', 'roberto@email.com', 'safepassword', '+35943989485', false, NULL, 4442555566667747);
INSERT INTO public.utente VALUES (13, 'Elisa', ' Blu', 'elisssa@email.com', 'privatepass', '+359999032066', false, NULL, 6666777788889999);
INSERT INTO public.utente VALUES (14, 'Antonio', ' Viola', 'antopurple@email.com', 'myconfidentialpass', '+393324114643', true, 0.05, 1234566850123456);
INSERT INTO public.utente VALUES (15, 'Giorgia', ' Gialli', 'giogialli@email.com', 'newpassword', '+39335864215', false, NULL, 8888999900001111);


--
-- TOC entry 3237 (class 2606 OID 54286)
-- Name: attivita attivita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attivita
    ADD CONSTRAINT attivita_pkey PRIMARY KEY (id_attivita);


--
-- TOC entry 3224 (class 2606 OID 54220)
-- Name: camera camera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.camera
    ADD CONSTRAINT camera_pkey PRIMARY KEY (id_camera);


--
-- TOC entry 3217 (class 2606 OID 54199)
-- Name: carta_di_debito carta_di_debito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carta_di_debito
    ADD CONSTRAINT carta_di_debito_pkey PRIMARY KEY (numero_carta);


--
-- TOC entry 3222 (class 2606 OID 54215)
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (id_hotel);


--
-- TOC entry 3235 (class 2606 OID 54271)
-- Name: hotelservizi hotelservizi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotelservizi
    ADD CONSTRAINT hotelservizi_pkey PRIMARY KEY (id_hotel, id_servizio);


--
-- TOC entry 3229 (class 2606 OID 54246)
-- Name: omaggi omaggi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.omaggi
    ADD CONSTRAINT omaggi_pkey PRIMARY KEY (id_omaggio);


--
-- TOC entry 3231 (class 2606 OID 54251)
-- Name: omaggisuite omaggisuite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.omaggisuite
    ADD CONSTRAINT omaggisuite_pkey PRIMARY KEY (id_omaggio, id_suite);


--
-- TOC entry 3227 (class 2606 OID 54231)
-- Name: prenotazione prenotazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_pkey PRIMARY KEY (id_prenotazione);


--
-- TOC entry 3233 (class 2606 OID 54266)
-- Name: servizi servizi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servizi
    ADD CONSTRAINT servizi_pkey PRIMARY KEY (id_servizio);


--
-- TOC entry 3219 (class 2606 OID 54205)
-- Name: utente utente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (id_utente);


--
-- TOC entry 3225 (class 1259 OID 54312)
-- Name: camere; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX camere ON public.camera USING btree (id_camera);


--
-- TOC entry 3220 (class 1259 OID 54313)
-- Name: hotel_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hotel_index ON public.hotel USING btree (id_hotel);


--
-- TOC entry 3246 (class 2606 OID 54287)
-- Name: attivita attivita_hotel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attivita
    ADD CONSTRAINT attivita_hotel_fkey FOREIGN KEY (hotel) REFERENCES public.hotel(id_hotel) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3239 (class 2606 OID 54221)
-- Name: camera camera_hotel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.camera
    ADD CONSTRAINT camera_hotel_fkey FOREIGN KEY (hotel) REFERENCES public.hotel(id_hotel) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3244 (class 2606 OID 54272)
-- Name: hotelservizi hotelservizi_id_hotel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotelservizi
    ADD CONSTRAINT hotelservizi_id_hotel_fkey FOREIGN KEY (id_hotel) REFERENCES public.hotel(id_hotel) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3245 (class 2606 OID 54277)
-- Name: hotelservizi hotelservizi_id_servizio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotelservizi
    ADD CONSTRAINT hotelservizi_id_servizio_fkey FOREIGN KEY (id_servizio) REFERENCES public.servizi(id_servizio) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3242 (class 2606 OID 54252)
-- Name: omaggisuite omaggisuite_id_omaggio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.omaggisuite
    ADD CONSTRAINT omaggisuite_id_omaggio_fkey FOREIGN KEY (id_omaggio) REFERENCES public.omaggi(id_omaggio) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3243 (class 2606 OID 54257)
-- Name: omaggisuite omaggisuite_id_suite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.omaggisuite
    ADD CONSTRAINT omaggisuite_id_suite_fkey FOREIGN KEY (id_suite) REFERENCES public.camera(id_camera) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3240 (class 2606 OID 54237)
-- Name: prenotazione prenotazione_camera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_camera_fkey FOREIGN KEY (camera) REFERENCES public.camera(id_camera) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3241 (class 2606 OID 54232)
-- Name: prenotazione prenotazione_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(id_utente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3247 (class 2606 OID 54302)
-- Name: recensione recensione_attivita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recensione
    ADD CONSTRAINT recensione_attivita_fkey FOREIGN KEY (attivita) REFERENCES public.attivita(id_attivita) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3248 (class 2606 OID 54297)
-- Name: recensione recensione_hotel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recensione
    ADD CONSTRAINT recensione_hotel_fkey FOREIGN KEY (hotel) REFERENCES public.hotel(id_hotel) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3249 (class 2606 OID 54307)
-- Name: recensione recensione_prenotazione_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recensione
    ADD CONSTRAINT recensione_prenotazione_fkey FOREIGN KEY (prenotazione) REFERENCES public.prenotazione(id_prenotazione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3238 (class 2606 OID 54206)
-- Name: utente utente_carta_debito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_carta_debito_fkey FOREIGN KEY (carta_debito) REFERENCES public.carta_di_debito(numero_carta) ON UPDATE CASCADE ON DELETE CASCADE;
--query

--query1 Group by: contare gli hotel presenti in uno stesso stato;

SELECT Stato, COUNT(*) AS NumeroHotel
FROM Hotel
GROUP BY Stato
ORDER BY Stato;

--query2
SELECT H.Id_Hotel, H.Nome AS Nome_Hotel, COUNT(Cam.Id_Camera) AS Numero_Suite, MIN(OS.Num_Omaggi) AS Min_Numero_Omaggi
FROM Hotel H
LEFT JOIN Camera Cam ON H.Id_Hotel = Cam.Hotel AND Cam.Suite = true
LEFT JOIN (
    SELECT Id_Suite, COUNT(Id_Omaggio) AS Num_Omaggi
    FROM OmaggiSuite
    GROUP BY Id_Suite
) AS OS ON Cam.Id_Camera = OS.Id_Suite
GROUP BY H.Id_Hotel, H.Nome
ORDER BY H.Id_Hotel;



--query3 Group by e Having: mostrare il numero di attività affiliate presenti in hotel  
--in cui il costo di è maggiore di un valore x, che nell'esempio è 15;
SELECT h.Id_Hotel, h.Nome AS NomeHotel, COUNT(a.Id_Attivita) AS NumeroAttivitaAffiliate
FROM Hotel h
JOIN Attivita a ON h.Id_Hotel = a.Hotel
WHERE a.Affiliata = true AND a.Prezzo > 15
GROUP BY h.Id_Hotel, h.Nome
HAVING COUNT(a.Id_Attivita) >= 2;


--query4
SELECT U.Id_Utente, U.Nome, U.Cognome,COUNT(P.Id_Prenotazione) AS Numero_Prenotazioni,
    Round( SUM(C.Costo_giornaliero * EXTRACT(EPOCH FROM (P.DataOraFine - P.DataOraInizio)) / (60 * 60 * 24))) AS Importo_Totale
FROM    Utente U
JOIN Prenotazione P ON U.Id_Utente = P.Utente
JOIN Camera C ON P.Camera = C.Id_Camera
GROUP BY U.Id_Utente, U.Nome, U.Cognome
ORDER BY Numero_Prenotazioni DESC
LIMIT 1;

--query5
SELECT P.Id_Prenotazione, U.Nome AS Nome_Utente, U.Cognome AS Cognome_Utente, P.DataOraInizio, P.DataOraFine,
    ROUND(EXTRACT(EPOCH FROM (P.DataOraFine - P.DataOraInizio)) / (60 * 60 * 24)) AS Durata_Giorni
FROM Prenotazione P
JOIN Utente U ON P.Utente = U.Id_Utente
WHERE P.DataOraInizio >= '2022-01-01' AND P.DataOraFine <= '2022-12-31'
ORDER BY Durata_Giorni DESC
LIMIT 3;

--query6
SELECT h.Id_Hotel, h.Nome, COUNT(hs.Id_Servizio) AS NumeroServizi, r.Punteggio_Hotel, r.Commento
FROM Hotel h
LEFT JOIN HotelServizi hs ON h.Id_Hotel = hs.Id_Hotel
LEFT JOIN Recensione r ON h.Id_Hotel = r.Hotel
GROUP BY h.Id_Hotel, h.Nome, r.Punteggio_Hotel, r.Commento
HAVING COUNT(hs.Id_Servizio) = (
    SELECT MIN(ServiziCount)
    FROM (
        SELECT hs.Id_Hotel, COUNT(hs.Id_Servizio) AS ServiziCount
        FROM HotelServizi hs
        GROUP BY hs.Id_Hotel
    ) AS MinServizi
)
ORDER BY NumeroServizi ASC;

--query7
SELECT A.Id_Attivita, A.Nome AS Nome_Attivita,
    A.Prezzo * (1 - A.Sconto) AS Prezzo_Scontato, A.Voto, H.Nome AS Nome_Hotel
FROM Attivita A
JOIN Hotel H ON A.Hotel = H.Id_Hotel
WHERE A.Affiliata = TRUE
ORDER BY A.Voto DESC
LIMIT 3;

CREATE INDEX Camere on Camera(Id_Camera);
CREATE INDEX Hotel_index on Hotel(Id_Hotel);


-- Completed on 2023-08-06 17:01:03

--
-- PostgreSQL database dump complete
--


    