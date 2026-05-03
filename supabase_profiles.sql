-- =====================================================
--  Prajwalika Get Together — Profiles Table
--  Run this in: Supabase Dashboard > SQL Editor
-- =====================================================

CREATE TABLE profiles (
  id                        uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  mobile_number             text UNIQUE NOT NULL,

  -- Personal Details
  full_name                 text,
  date_of_birth             date,
  gender                    text,
  native_district           text,
  native_village            text,
  marital_status            text,         -- Married / Unmarried / Divorced / Widowed
  no_of_kids                integer DEFAULT 0,
  marriage_anniversary      date,

  -- Family Details
  father_name               text,
  mother_name               text,
  spouse_name               text,
  kids_names                text,         -- free text listing kids' names

  -- Family Background (Professions)
  father_profession         text,
  mother_profession         text,
  spouse_profession         text,

  -- Education
  school_10th               text,
  school_10th_year          integer,
  intermediate_college      text,
  intermediate_year         integer,
  graduation_degree         text,         -- BSc/BCom/BA/BTech/BBA/Polytechnic/Others
  graduation_specialization text,
  graduation_year           integer,
  pg_degree                 text,         -- MSc/MTech/MCom/MBA/MCA/Others
  pg_specialization         text,
  pg_year                   integer,
  other_higher_studies      text,
  other_higher_studies_year integer,

  -- Professional
  is_employed               text,         -- Yes / No
  employment_type           text,         -- Self Employed / Private Employment / Govt Job-State / Govt Job-Central
  self_employment_details   text,
  company_name              text,
  private_designation       text,
  govt_department           text,
  govt_designation          text,

  -- Address
  current_address           text,

  -- Prajwalika Community
  support_needed            text,
  service_can_give          text,

  created_at                timestamptz DEFAULT now(),
  updated_at                timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Allow all operations via anon key
CREATE POLICY "allow_read"   ON profiles FOR SELECT USING (true);
CREATE POLICY "allow_insert" ON profiles FOR INSERT WITH CHECK (true);
CREATE POLICY "allow_update" ON profiles FOR UPDATE USING (true) WITH CHECK (true);

-- Auto-update updated_at on every update
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
