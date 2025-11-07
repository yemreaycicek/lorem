/**
 * @ Author: Yunus Emre AYÇİÇEK
 * @ Create Time: 2025-11-07 01:42:13
 * @ Modified by: Yunus Emre AYÇİÇEK
 * @ Modified time: 2025-11-07 03:14:49
 */

#include "lorem.h"

/**
 * The main function checks the return value of the lorem function and returns EXIT_FAILURE if it is
 * -1, otherwise it returns EXIT_SUCCESS.
 * 
 * @return The main function is returning either `EXIT_FAILURE` or `EXIT_SUCCESS` based on the result
 * of the `lorem()` function. If `lorem()` returns -1, then `EXIT_FAILURE` is returned. Otherwise,
 * `EXIT_SUCCESS` is returned.
 */
int
main(void)
{
    if (lorem() == -1)
        return (EXIT_FAILURE);
    return (EXIT_SUCCESS);
}
