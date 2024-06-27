extern "C"
{
#include "ModuleName.h"
}

#include "CppUTest/TestHarness.h"

TEST_GROUP(ModuleName_init)
{
    ModuleName_handle_t sensor;

    void setup()
    {
        ModuleName_config_t config;

        ModuleName_create(&config, &sensor);
    }

    void teardown()
    {
        ModuleName_destroy(sensor);
    }
};

TEST(ModuleName_init, Create)
{
    FAIL("Start here");
}

