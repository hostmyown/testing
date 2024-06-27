#include "ModuleName.h"
#include <stdlib.h>
#include <memory.h>

typedef struct ModuleName_s
{
    ModuleName_config_t config;
} ModuleName_t;

ModuleName_err_t ModuleName_create(ModuleName_config_t *config, ModuleName_handle_t *handle)
{
     ModuleName_handle_t self = calloc(1, sizeof(ModuleName_t));

     if (self == NULL)
     {
        return ModuleName_OUT_OF_MEMORY;
     }

     self->config = *config;

     *handle = self;

     return ModuleName_OK;
}

void ModuleName_destroy(ModuleName_handle_t handle)
{
    free(handle);
}


