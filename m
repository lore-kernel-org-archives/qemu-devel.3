Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B0DC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZy-0002aS-5z; Mon, 01 Jul 2024 12:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ6-0000g0-En
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ2-0005QP-Fz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-424acfff613so29038325e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850054; x=1720454854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NhncFmRxTCqHeeAjQL/H7qSFcoMoI/tEsiuUH4prtHE=;
 b=MnVHK/8i71eFjzLn7SWXn/ArTniqv0ai07leHFpYw7YNWeYJrgDfByvkdygD4UF0dx
 jtUiyyYNmDXkZU7b1eP5KyKc6vIGVxEfb/RlLlGpZfbCwZZ9kak++xVi1m+WRbcqtkuu
 BZXYZ2OJWwEpL4V8WnAChkv3JjamhppR5nZE5jPIGn/ionNkyQYS/+Hrmgh0njWLc0f4
 txwc1YsH5e4pRTQJhtHlhT0ebPvndu4G6teGnstbyCh9/Lj8XqmvI1a5pyns4tqMzw+z
 ZvMVI1gJpX9c5AWYBAYtDy5oxhnuMowDq/+B16qKDkQuASiqRgok30YwKIYMf1zgTPSm
 UZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850054; x=1720454854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhncFmRxTCqHeeAjQL/H7qSFcoMoI/tEsiuUH4prtHE=;
 b=P4/Yv3p9DY5qpAOfHH+TzJ0s3P5LhhGXDqQcucsByzuZpCLJ6tMv9zaFLo0J9tMVGq
 LSmpJwol8lbHjkXhfkPZ/RaxazZyh8bUXfFVFupPV8jXVF1JU3FU2Ir8+uJkcXWevFTf
 glJJerCv3YbeAUFvnEt8GyCFYrZngy4DWQZXTUbsLze3BB7iVoRaqEwq0T9+G/zZZnkK
 fZMZou87AGI93TxFZvEwP6HqYZFQibsJ41XQDgQruzOF5ZiqbTc15BK+F9xljZ+5NNo/
 GEqE4nn/CEX/+iIQY/kv3eCf1v6N0G0ek1k19lqj6+c51DpPo9fFcvb+7Fw8ufaS5esk
 U4Ig==
X-Gm-Message-State: AOJu0YxkNEaqWbWi4r12HejTQ9fLOmMbZkRa/bK1SZ+vt6Vjz8J97LHh
 CbuSzF3uKOs93Irqdl5AtsWJcyqF9PoC8MARj8mwIz9T0itIg/7/X9W5r2JZmbGKO0qmjMru0sJ
 zccw=
X-Google-Smtp-Source: AGHT+IHdDgcR9Keoa85RZ1mNRTSBk4IzmP+n5u1qvRlEsPT5DloEBLAzd/F41jCsQpzQaPv88XLdYg==
X-Received: by 2002:a05:600c:3552:b0:424:aa35:9fb9 with SMTP id
 5b1f17b1804b1-42579ffcc91mr52436785e9.2.1719850054359; 
 Mon, 01 Jul 2024 09:07:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/29] target/arm: Fix FJCVTZS vs flush-to-zero
Date: Mon,  1 Jul 2024 17:07:09 +0100
Message-Id: <20240701160729.1910763-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Input denormals cause the Javascript inexact bit
(output to Z) to be set.

Cc: qemu-stable@nongnu.org
Fixes: 6c1f6f2733a ("target/arm: Implement ARMv8.3-JSConv")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2375
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-4-richard.henderson@linaro.org
[PMM: fixed hardcoded tab in test case]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c           | 18 +++++++++---------
 tests/tcg/aarch64/test-2375.c     | 21 +++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  3 ++-
 3 files changed, 32 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2375.c

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ce26b8a71a1..50d7042fa9e 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1091,8 +1091,8 @@ const FloatRoundMode arm_rmode_to_sf_map[] = {
 uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
 {
     float_status *status = vstatus;
-    uint32_t inexact, frac;
-    uint32_t e_old, e_new;
+    uint32_t frac, e_old, e_new;
+    bool inexact;
 
     e_old = get_float_exception_flags(status);
     set_float_exception_flags(0, status);
@@ -1100,13 +1100,13 @@ uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
     e_new = get_float_exception_flags(status);
     set_float_exception_flags(e_old | e_new, status);
 
-    if (value == float64_chs(float64_zero)) {
-        /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript. */
-        inexact = 1;
-    } else {
-        /* Normal inexact or overflow or NaN */
-        inexact = e_new & (float_flag_inexact | float_flag_invalid);
-    }
+    /* Normal inexact, denormal with flush-to-zero, or overflow or NaN */
+    inexact = e_new & (float_flag_inexact |
+                       float_flag_input_denormal |
+                       float_flag_invalid);
+
+    /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript. */
+    inexact |= value == float64_chs(float64_zero);
 
     /* Pack the result and the env->ZF representation of Z together.  */
     return deposit64(frac, 32, 32, inexact);
diff --git a/tests/tcg/aarch64/test-2375.c b/tests/tcg/aarch64/test-2375.c
new file mode 100644
index 00000000000..84c7e7de716
--- /dev/null
+++ b/tests/tcg/aarch64/test-2375.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) 2024 Linaro Ltd */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2375 */
+
+#include <assert.h>
+
+int main(void)
+{
+   int r, z;
+
+   asm("msr fpcr, %2\n\t"
+       "fjcvtzs %w0, %d3\n\t"
+       "cset %1, eq"
+       : "=r"(r), "=r"(z)
+       : "r"(0x01000000L),      /* FZ = 1 */
+         "w"(0xfcff00L));       /* denormal */
+
+    assert(r == 0);
+    assert(z == 0);
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9af..4ecbca6a416 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -41,8 +41,9 @@ endif
 
 # Pauth Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
+AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5 test-2375
 pauth-%: CFLAGS += -march=armv8.3-a
+test-2375: CFLAGS += -march=armv8.3-a
 run-pauth-1: QEMU_OPTS += -cpu max
 run-pauth-2: QEMU_OPTS += -cpu max
 # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
-- 
2.34.1


