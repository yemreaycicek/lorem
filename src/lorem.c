/**
 * @ Author: Yunus Emre AYÇİÇEK
 * @ Create Time: 2025-11-07 01:51:50
 * @ Modified by: Yunus Emre AYÇİÇEK
 * @ Modified time: 2025-11-07 02:26:28
 */

#include "lorem.h"

/**
 * The "lorem" function writes the string "Lorem ipsum dolor sit amet" to the standard output and
 * returns 0.
 * 
 * @return The function `lorem` is returning an integer value of 0.
 */
int
lorem(void)
{
    ssize_t ret;

    ret = write(STDOUT_FILENO, "Lorem ipsum dolor sit amet\n", 27);
    if (ret == -1)
        return (-1);
    return (0);
}
