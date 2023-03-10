// Copyright (c) the JPEG XL Project Authors. All rights reserved.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#ifndef LIB_JPEGLI_DCT_H_
#define LIB_JPEGLI_DCT_H_

/* clang-format off */
#include <stdio.h>
#include <jpeglib.h>
/* clang-format on */

#include <vector>

#include "lib/jpegli/encode_internal.h"

namespace jpegli {

void ComputeCoefficientBlock(const float* JXL_RESTRICT pixels, size_t stride,
                             const float* JXL_RESTRICT qmc, float aq_strength,
                             float zero_bias_mul, float* JXL_RESTRICT tmp,
                             JCOEF* block);

void ComputeDCTCoefficients(j_compress_ptr cinfo);

}  // namespace jpegli

#endif  // LIB_JPEGLI_DCT_H_
