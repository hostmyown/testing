#!/bin/bash

# Check if the module name argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <module_name>"
    exit 1
fi

# Define the module name and script root
MODULE_NAME=$1
SCRIPT_ROOT=$(dirname "$0")

TEMPLATE_ROOT_DIR="$SCRIPT_ROOT/CProjectTemplate"

# Define paths for template and target files
TEMPLATE_INCLUDE_DIR="$TEMPLATE_ROOT_DIR/include"
TEMPLATE_SRC_DIR="$TEMPLATE_ROOT_DIR/src"
TEMPLATE_TEST_ROOT_DIR="$TEMPLATE_ROOT_DIR/tests"
TEMPLATE_TEST_DIR="$TEMPLATE_ROOT_DIR/tests/init"
TEMPLATE_MAKEFILE="$TEMPLATE_ROOT_DIR/Makefile"

TARGET_INCLUDE_DIR="$MODULE_NAME/include"
TARGET_SRC_DIR="$MODULE_NAME/src"
TARGET_TEST_ROOT_DIR="$MODULE_NAME/tests"
TARGET_TEST_DIR="$MODULE_NAME/tests/init"
TARGET_MAKEFILE="$MODULE_NAME/Makefile"

MODULE_NAME_UPPER=$(echo "$MODULE_NAME" | tr '[:lower:]' '[:upper:]')

# Create target directories
mkdir -p "$TARGET_INCLUDE_DIR" "$TARGET_SRC_DIR" "$TARGET_TEST_DIR" "$TARGET_TEST_ROOT_DIR"

# Function to replace placeholders in a file and copy it to the target location
# Usage: replace_and_copy <template_file> <target_file>
replace_and_copy() {
    local template_file="$1"
    local target_file="$2"

    # Replace placeholders in the template file and copy to the target file
    sed -e "s/ModuleNameUpper/${MODULE_NAME_UPPER}/g" \
        -e "s/ModuleName/${MODULE_NAME}/g" \
        "$template_file" > "$target_file"

    if [ $? -eq 0 ]; then
        echo "Created $target_file"
    else
        echo "Error: Failed to create $target_file"
        exit 1
    fi
}

# Create the target header file
replace_and_copy "$TEMPLATE_INCLUDE_DIR/ModuleName.h" "$TARGET_INCLUDE_DIR/$MODULE_NAME.h"

# Create the target source file
replace_and_copy "$TEMPLATE_SRC_DIR/ModuleName.c" "$TARGET_SRC_DIR/$MODULE_NAME.c"

# Copy the main test file (AllTests.cpp)
cp "$TEMPLATE_TEST_ROOT_DIR/AllTests.cpp" "$TARGET_TEST_ROOT_DIR/AllTests.cpp"
if [ $? -eq 0 ]; then
    echo "Created $TARGET_TEST_ROOT_DIR/AllTests.cpp"
else
    echo "Error: Failed to copy $TEMPLATE_TEST_ROOT_DIR/AllTests.cpp"
    exit 1
fi

# Create the target init test file
replace_and_copy "$TEMPLATE_TEST_DIR/ModuleName_test.cpp" "$TARGET_TEST_DIR/${MODULE_NAME}_test.cpp"

# Create the target Makefile
replace_and_copy "$TEMPLATE_MAKEFILE" "$TARGET_MAKEFILE"

echo "Project setup completed successfully."
