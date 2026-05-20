Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDF5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkYw-0001Jo-Ad; Wed, 20 May 2026 13:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYs-0001JA-QB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:26 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYq-0001sI-9y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:26 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36a35e4eefeso421924a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297502; x=1779902302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3gId/LKzXO/d5yiA5P9hPtHz0hbXIRm3UDXfLWl60Js=;
 b=tDPqprA8hDaKOeqJTMu2i8QBA61Xi7irvXUp0see4+9YH8qXu31Im8kwceLiQjN5Mc
 d5Uj1Ipeh7L/aGHApTcGhJ1H0cFXUXqewBrhorblNlcm7IrBqgV4m5ymK2WlRs3RM9NI
 5nXRp/xchP8ero9/Y0CXWiUcU0O9ItHajkY0rxGVAJrdsDFj6HEJpMrdz4zo5A9YW3cf
 q8gx/IdQ8i2RKpfjH2LW3OV9X5BjGSfn3n+PhpYdUKdZqCoPgiB+Vwe+Dp5FNGwbQVaV
 ZwuJmiFc4yAJ2oll/XzO/HLyjJFSXrBBb0JP4fmkP0ckVhzjePU05QPkaltVc+WYInb4
 3Hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297502; x=1779902302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gId/LKzXO/d5yiA5P9hPtHz0hbXIRm3UDXfLWl60Js=;
 b=lveOp9EuBz4e7m/j1JsrRWU1C3SabZVlnhMH6O/UdSRNQRCNeotucwV1+PPpeL9EVw
 qs6F2qbhhQaVUes4a8BF8owHYBO966h4nKEq/K6AntzT3TbsEp79Xw91MIGVpmliDgRt
 tld7G3cvX2ei9q8HOugqgtiC0aZ1Blq28OgAWms96CENsNGRLa1E4QFjGX0VqqJpQR/3
 zxfFRChp2180CKJfBVH1ARt+y3oocwUPYrc5uaKdlQhSmEkcZs8pjI+FGuoevgwNY5OI
 YLXm+GR8gN1KA9NVCPb81MXP2TWfN2A3aXeBqIHpt3LIhV8Rs5HUzXtAJvYA4H92q6KY
 Xz3w==
X-Gm-Message-State: AOJu0YzyQMjt7xTiqnSHSFpkrFknOdz38L6n+H98xJnbZ7HqdSDBqiuT
 /+oGqA1K7o4gwXYAQBeG/Qp/W+efIQFFOosLg0tvsjo0LeKYy4DCwtFgpEj/xQi4sG0DSM36KIO
 rmDaom2Y=
X-Gm-Gg: Acq92OEeTJ9wBdDdk5GGxGuAQLPpwqT8yMUlNzkbUn1tRAG8RF/h2Gl8duFEdpH6Okt
 BaDqZbhUbTiScsA9rI4+PjRPP4WwSPJtJ5ynQ2SX0j0m6VL2iyQoBaA3ej73F8Zq6ifN+06LWXh
 hkgCD31ZrYoXOWqcDPVa3iBodExYyeDNraXiFCmkAj2gI1eWcIS3xGWVjkacZFhaw2FX0RnTD1Q
 F+i0AI5RBcFdOKnyuBUrDFsZXSUrNIq6KG7jbAPxlFG0KlqI1aJ9MDTd1VScRRHJeRqxpoxobyR
 N0iFih0biZJA+9+bwRdEzejMVr3axlBKjwH5rJnL8R4mrtT+JoXHxsnG5NpeSCQLng3VttxxA7m
 ZBqem7M18bx5BahH2qv+G+V09TQpPkMglnWhyEA8TeVBpJgN0KiQ8K1Z2h2eecSj/Pn3h+V1rL9
 kFEaOdyVUWMDewYQxCFNpcHYqhRKsl
X-Received: by 2002:a17:90b:1d83:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-36951889fe9mr21815788a91.1.1779297501950; 
 Wed, 20 May 2026 10:18:21 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 00/30] fpu: Export some internals for targets
Date: Wed, 20 May 2026 10:17:50 -0700
Message-ID: <20260520171820.848839-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Changes for v5:
  - Drop target/arm changes as non-essential;
    will be moved to another patch set.
  - Incorporate "Export floatN_minmax" from the FEAT_FP8 patch set.
  - Incorporate "fpu: Compress float_status", to avoid conflicts with...
  - Introduce float_status.e4m3_nan_is_snan
  - Fix NaN encoding for E4M3 in parts64_uncanon


r~


Richard Henderson (30):
  fpu: Return struct from parts{64,128}_scalbn
  fpu: Reorganize partsN(muladd)
  fpu: Return struct from parts{64,128}_muladd
  fpu: Hoist nan check in partsN_addsub
  fpu: Simplify 0 +/- N case in parts_addsub
  fpu: Use parts64_round_to_int in parts_s390_divide_to_integer
  target/s390x: Move float{32,64}_s390_divide_to_integer
  fpu: Introduce exp_scalbn
  target/alpha: Remove CONFIG_SOFTFLOAT_INLINE
  fpu: Introduce FloatExceptionFlags
  target/alpha: Use FloatExceptionFlags
  fpu: Introduce frac_msb_is_snan
  fpu: Introduce FloatSNaNRule
  fpu: Use {get,set}_float_rounding_mode everywhere
  fpu: Use of {get,set}_floatx80_rounding_precision everywhere
  fpu: Use get_floatx80_behaviour everywhere
  fpu: Use get_float_2nan_prop_rule in partsN_pick_nan
  fpu: Use get_float_3nan_prop_rule in partsN_pick_nan_muladd
  fpu: Use get_float_infzeronan_rule in partsN_pick_nan_muladd
  fpu: Use accessors for tininess_before_rounding
  fpu: Use {get,set}_flush_to_zero everywhere
  fpu: Use accessors for ftz_before_rounding
  fpu: Use {get,set}_flush_inputs_to_zero everywhere
  fpu: Use get_default_nan_mode everywhere
  fpu: Use get_float_default_nan_pattern in partsN_default_nan
  fpu: Add accessors for rebias_{underflow,overflow}
  fpu: Reorg float_status
  fpu: Introduce float_status.e4m3_nan_is_snan
  fpu: Fix NaN encoding for E4M3 in parts64_uncanon
  fpu: Export floatN_minmax

 include/fpu/softfloat-helpers.h |  37 +--
 include/fpu/softfloat-parts.h   |  12 +
 include/fpu/softfloat-types.h   |  89 ++++---
 include/fpu/softfloat.h         | 112 +++++----
 target/i386/ops_sse.h           |  24 +-
 target/mips/fpu_helper.h        |   3 +-
 fpu/softfloat.c                 | 422 +++++++++++---------------------
 target/alpha/fpu_helper.c       |   8 +-
 target/alpha/helper.c           |   3 +-
 target/alpha/translate.c        |  18 +-
 target/arm/tcg/helper-a64.c     |  12 +-
 target/arm/tcg/vfp_helper.c     |  38 +--
 target/hexagon/fma_emu.c        |   6 +-
 target/hppa/fpu_helper.c        |   2 +-
 target/i386/tcg/fpu_helper.c    |  65 ++---
 target/m68k/softfloat.c         | 380 ++++++++++++++--------------
 target/mips/msa.c               |   4 +-
 target/ppc/cpu.c                |   4 +-
 target/ppc/fpu_helper.c         |  14 +-
 target/riscv/vector_helper.c    |   6 +-
 target/s390x/tcg/fpu_helper.c   | 139 ++++++++++-
 target/sh4/cpu.c                |   2 +-
 target/xtensa/cpu.c             |   3 +-
 tests/fp/fp-bench.c             |   6 +-
 tests/fp/fp-test.c              |   6 +-
 fpu/softfloat-parts.c.inc       | 313 ++++++++++++-----------
 fpu/softfloat-specialize.c.inc  | 117 +++++----
 tests/fp/wrap.c.inc             |  12 +-
 28 files changed, 936 insertions(+), 921 deletions(-)

-- 
2.43.0


