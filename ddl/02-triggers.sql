-- automatically handle updating updated_at column on any updates
-- Create the trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger for all tables that have an updated_at column
DO $$ 
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN 
        SELECT table_schema, table_name
        FROM information_schema.columns
        WHERE column_name = 'updated_at' 
          AND table_schema = 'twisted_spur'  -- Adjust schema if necessary
    LOOP
        EXECUTE format('
            CREATE TRIGGER set_updated_at_%I
            BEFORE UPDATE ON %I.%I
            FOR EACH ROW
            EXECUTE FUNCTION update_updated_at_column();',
            rec.table_name, rec.table_schema, rec.table_name);
    END LOOP;
END $$;