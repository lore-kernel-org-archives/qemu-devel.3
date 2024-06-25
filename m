Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9DCC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 20:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBzh-00008T-O4; Tue, 25 Jun 2024 15:38:31 -0400
Received: from [209.51.188.92] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMByk-0008LY-HE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:37:34 -0400
Received: from [2607:f8b0:4864:20::732] (helo=mail-qk1-x732.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMBxX-0004tL-Tm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:37:03 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-79c06169e9cso62234785a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719344067; x=1719948867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkIsJKtZUJAkO/lpIvhYyVEDLS6NoChogP/TAxQnzSI=;
 b=SxSuKEZwRMXu2kbEvW26ggPvNXdMFcRCq7CuSriR1Abw4y/jNJ7p8Ze/Z3fFZrFpcp
 iwfWt1nOtZbvkTJ+szvaHiEvel0Erypweiy9U+HnIgfjSL/Kw3pxCa1WtHOvR5wtd/a3
 2dS03xOmapIjOB6Sov6txjp+SWfSzlxFA5hBOUF/9K3h4wHMmTY2BxVbx9uChemit4Yt
 MQht/wT2KmPCcrTTkKx7mcWlhXhTJl8RCy9BnCouEBlPtf7lrxi2Vd1lv11c87jz88bV
 UvS/d7EUFjmFONla3yNHhEZo84aRZnIuGzIIQ6FmA3ZHPZOOmSXlrwAD2f8MOLlkol8k
 YMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719344067; x=1719948867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkIsJKtZUJAkO/lpIvhYyVEDLS6NoChogP/TAxQnzSI=;
 b=DCUol/iK+/H68pRMpWG8dvMjgCs5V03jUuvm0jZy9z1+GbA5mmrxut2d3D/ZtG1gLp
 frXLYxylogzxK80likp0wVKjq60WfmEF+pkOicsvj6wI7KgTOaQ1XVDlrjV4RyObUfwm
 QxEK9JMSGn+rjmT4ZsY4WTNqbmWJsC1Xm8r6HZqBnHoHeGF20WKsIQu7mcHOwKk6g1mZ
 eBVyGITeOvLlw6ESOEKYPzIYDOo0eOXBc6OOCIsHRMUm/36GKFKCOc6QjMAMW6efeEr3
 PStzU0tNth9Kmbu9/E6kp/2rZexE1Zhbvg6wLXbpJRVMbccKAwV9fK2QdWArKTttlRUW
 UduA==
X-Gm-Message-State: AOJu0YzsMaB8r84hgS9pUv8A6pm4vMN5V1shGvKHl4Jl6yVEhNiHAY8b
 lGEcs5OcnHf28nCmQJRBOcvFt5VSnGTCbGjwcL4ulACRLat/6/z9gCLUnIl5mAe659mDpj/RMv4
 j
X-Google-Smtp-Source: AGHT+IG8cDeIeGAqVeoAwVRJanfKxbGCJH+qaOB7AgBHfa/WfcALNcSgLJ/6CwYprQsIuweEFaMJXw==
X-Received: by 2002:a17:902:c40e:b0:1fa:2568:5895 with SMTP id
 d9443c01a7336-1fa256858femr93716095ad.63.1719340540561; 
 Tue, 25 Jun 2024 11:35:40 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 03/13] target/arm: Fix FJCVTZS vs flush-to-zero
Date: Tue, 25 Jun 2024 11:35:26 -0700
Message-Id: <20240625183536.1672454-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::732
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x732.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, PDS_HP_HELO_NORDNS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Input denormals cause the Javascript inexact bit
(output to Z) to be set.

Cc: qemu-stable@nongnu.org
Fixes: 6c1f6f2733a ("target/arm: Implement ARMv8.3-JSConv")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2375
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c           | 18 +++++++++---------
 tests/tcg/aarch64/test-2375.c     | 21 +++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  3 ++-
 3 files changed, 32 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2375.c

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ce26b8a71a..50d7042fa9 100644
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
index 0000000000..163eba422b
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
+       : "r"(0x01000000L),	/* FZ = 1 */
+         "w"(0xfcff00L));       /* denormal */
+
+    assert(r == 0);
+    assert(z == 0);
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9a..4ecbca6a41 100644
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


