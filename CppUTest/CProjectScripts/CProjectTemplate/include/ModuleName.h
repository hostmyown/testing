#ifndef ModuleNameUpper_H__
#define ModuleNameUpper_H__

/**********************************************************************
 *
 * ModuleName is responsible for ...
 *
 **********************************************************************/

typedef struct ModuleName_s * ModuleName_handle_t;

typedef struct ModuleName_config_s {

} ModuleName_config_t;

typedef enum {
    ModuleNameUpper_OK,
    ModuleNameUpper_INVALID_CONFIG,
    ModuleNameUpper_OUT_OF_MEMORY,
    // Add more error codes as needed
} ModuleName_err_t;

ModuleName_err_t ModuleName_create(ModuleName_config_t *config, ModuleName_handle_t *handle);
void ModuleName_destroy(ModuleName_handle_t handle);

#endif  /* ModuleNameUpper_H__ */
