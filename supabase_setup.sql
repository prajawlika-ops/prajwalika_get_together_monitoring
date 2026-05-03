-- =====================================================
--  Prajwalika Get Together — Supabase Setup SQL
--  Run this in: Supabase Dashboard > SQL Editor
-- =====================================================

-- 1. Create the attendees table
CREATE TABLE attendees (
  id                  uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  full_name           text NOT NULL,
  intermediate_batch  text,
  college_name        text,
  native_place        text,
  current_residence   text,
  mobile_number       text UNIQUE,
  attending           text,           -- RSVP status from Google Form
  current_designation text,
  organization        text,
  attended            boolean DEFAULT false,          -- actual attendance on event day
  attended_at         timestamptz,                    -- timestamp when they marked
  created_at          timestamptz DEFAULT now()
);

-- 2. Enable Row Level Security
ALTER TABLE attendees ENABLE ROW LEVEL SECURITY;

-- 3. Allow read + write for anonymous users
--    (the page is only shared with your attendees, so anon key is fine)
CREATE POLICY "allow_read"   ON attendees FOR SELECT USING (true);
CREATE POLICY "allow_insert" ON attendees FOR INSERT WITH CHECK (true);
CREATE POLICY "allow_update" ON attendees FOR UPDATE USING (true) WITH CHECK (true);

-- =====================================================
--  Useful queries to run after the event
-- =====================================================

-- Count who attended
-- SELECT COUNT(*) FROM attendees WHERE attended = true;

-- List attendees who marked attendance
-- SELECT full_name, mobile_number, intermediate_batch, attended_at
-- FROM attendees
-- WHERE attended = true
-- ORDER BY attended_at;

-- People who said "Yes I'm Coming" but didn't attend
-- SELECT full_name, mobile_number
-- FROM attendees
-- WHERE attending = 'Yes I''m Coming' AND attended = false;
