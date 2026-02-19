Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604B6E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mm-0007Nh-6L; Thu, 19 Feb 2026 05:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mj-0007LZ-DH
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mf-00068J-IL
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso6917145e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497270; x=1772102070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vt5oT7ghhA4hiP2MKIWnryipV1YbDZfQDKUwm/lTTPo=;
 b=aEjsLIPANUa9Z1asA6Q6ZBFZlvYYt+kSUashl3UCidSqI+GxXPmq1xHHXO7/xtSP1L
 g20gC2B8jm28DKklZJ1nZc5typY3aSf1lSytv8tckYc1XSxuuljapGQGYLwF74Z3nUK7
 grUYs7gPXTZZey/WhiFsVd4apB2HTExNOtLUDiK7pmkIzVB/U15HE2Le2SYFkP2SA+vU
 OQGmbLLpHEVX0IJI7vOxlXWboR2jNYhobstlPfEqodl0y7/HS11BwKsvYREEbbRcbxpg
 jL65welF0/F9U0cfP24twFkGbibx1DbPIv2S+kRScvH7IQ31aVeWHAEh4OOIKGg+/bzA
 pUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497270; x=1772102070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vt5oT7ghhA4hiP2MKIWnryipV1YbDZfQDKUwm/lTTPo=;
 b=JfBbNfoZa6uN1mPjPHNxPKT9CAUmTLu5jE0d040ZLCXfW9yVJV1v4/IX3J33uQ3XIV
 1SWhO0m6B2L12ERu2jj9RCoq+Ho/T3EcK1vWnv0C1ZdS8kvnE8a6PnPyXZbSJGzvVEi7
 BGeyJFhpGrUTzGFFNMJhIl5079+seDHqchMVRiHwTD7i6BmJ/hcJEvuRmaiZNaQu9Sh4
 JLg9qDXd0391yhy9r93rEG0MXReO39I+L3lzLL1ni4NS/q8lCBokGZUzSI8/rCRVOCb2
 q+j8kcPCxGr8rvpp3lLjaTchMq7nPqb2VcmCyat+ja6id9kh++ty2T5oopD0ngEHJIls
 cwPQ==
X-Gm-Message-State: AOJu0YzJbSdkmKqtxx4czY/lvY8ytauQYFTiOtLYzOzHTHiiTPHlW2J9
 mFL0Rm9gm401Fgr3rk6ZUNBcxqKrLkoIiqPToA/BOowJHkBIhevrOnrJhI8UcEkXAqlbMT+6lIX
 vVTTt
X-Gm-Gg: AZuq6aLOFVO9m5a+QwJKUQxcl2s+y8vPAMfpfBMmu/Dk61Zl3nH4DdUow3gUP8qWlKN
 jeXb9swAKwLoODmTpReZhX1LFZJP2Ff8ANOFcsko7/vWAyEnYadlgrwGx8manWigstUuS+d1WT6
 aS6Slao8xH37X4COlHl/LdnvTY39wemRnaLtwY2aWhwMSOdARv4a7tOnsZR5SuvIV3MS9EjizSP
 /9wYak861+uFw3muv+MwsYZFiEUTDIagvl5f+atbviTqtZl6xClxVmnN55/MOgWB7pXzvhsCz3k
 nsmCPSsTT51bxCTWg+em350aA7mH60go66xj8Xalby3sjdl5n3gfuRMSFnhY9C8CQiG7Tb1RDoC
 nPerYnPQOt10qZbB2FF4OKWVfbly4qh0bLYkMnv0EmlWK7MNAE6Tvu3sjzdEnShKHwzb6CewJXN
 +Dy0pWvtTtSkhL4XHVv5l5z5S/DOcrrHD46aV7vreWXGkQpEOhzZ2wnuxZtyxPrCa5MkyaGrAsN
 nT4zsQCaoI4FeDopKJLublzdag7kxw=
X-Received: by 2002:a05:600c:c176:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-48398a4267dmr85656165e9.1.1771497270217; 
 Thu, 19 Feb 2026 02:34:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] target/arm: move exec/helper-* plumbery to helper.h
Date: Thu, 19 Feb 2026 10:33:59 +0000
Message-ID: <20260219103405.3793357-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Since we cleaned helper.h, we can continue further and remove
all exec/helper-* inclusion. This way, all helpers use the same pattern,
and helper include details are limited to those headers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-9-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h                        | 13 ++++++++++++-
 target/arm/tcg/arith_helper.c              |  4 +---
 target/arm/tcg/crypto_helper.c             |  4 +---
 target/arm/tcg/debug.c                     |  4 +---
 target/arm/tcg/helper-a64.c                |  2 +-
 target/arm/tcg/{helper.h => helper-defs.h} |  0
 target/arm/tcg/hflags.c                    |  4 +---
 target/arm/tcg/m_helper.c                  |  2 +-
 target/arm/tcg/mte_helper.c                |  2 +-
 target/arm/tcg/mve_helper.c                |  2 +-
 target/arm/tcg/neon_helper.c               |  4 +---
 target/arm/tcg/op_helper.c                 |  2 +-
 target/arm/tcg/pauth_helper.c              |  2 +-
 target/arm/tcg/psci.c                      |  2 +-
 target/arm/tcg/sme_helper.c                |  2 +-
 target/arm/tcg/sve_helper.c                |  2 +-
 target/arm/tcg/tlb_helper.c                |  4 +---
 target/arm/tcg/translate.c                 |  9 ++++-----
 target/arm/tcg/translate.h                 |  2 +-
 target/arm/tcg/vec_helper.c                |  2 +-
 target/arm/tcg/vfp_helper.c                |  4 +---
 21 files changed, 34 insertions(+), 38 deletions(-)
 rename target/arm/tcg/{helper.h => helper-defs.h} (100%)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b1e83196b3..b1c26c180e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,3 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-#include "tcg/helper.h"
+#ifndef HELPER__H
+#define HELPER__H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER__H */
diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
index 97c6362992..cc081c8f96 100644
--- a/target/arm/tcg/arith_helper.c
+++ b/target/arm/tcg/arith_helper.c
@@ -8,11 +8,9 @@
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
 #include "qemu/crc32c.h"
+#include "helper.h"
 #include <zlib.h> /* for crc32 */
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 /*
  * Note that signed overflow is undefined in C.  The following routines are
  * careful to use unsigned types where modulo arithmetic is required.
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 3428bd1bf0..11977cb772 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -15,11 +15,9 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
+#include "helper.h"
 #include "vec_internal.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 7dfb291a9b..5214e3c08a 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -8,15 +8,13 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
 {
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 07ddfb895d..2dec587d38 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -21,7 +21,7 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "gdbstub/helpers.h"
-#include "exec/helper-proto.h"
+#include "helper.h"
 #include "helper-a64.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper-defs.h
similarity index 100%
rename from target/arm/tcg/helper.h
rename to target/arm/tcg/helper-defs.h
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 5c9b9bec3b..7e6f8d3647 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -7,15 +7,13 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
 #include "cpregs.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 static inline bool fgt_svc(CPUARMState *env, int el)
 {
     /*
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 0c3832a47f..a0cb8cb021 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -8,10 +8,10 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "gdbstub/helpers.h"
-#include "exec/helper-proto.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 01b7f099f4..a9fb979f63 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "exec/target_page.h"
 #include "exec/page-protection.h"
@@ -32,7 +33,6 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "helper-a64.h"
-#include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
 #include "qapi/error.h"
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index f33642df1f..a67d90d6c7 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -19,10 +19,10 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "helper-mve.h"
 #include "internals.h"
 #include "vec_internal.h"
-#include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 8d288f3a70..69147969b2 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,13 +9,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c7ab462d1d..4d70863506 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "exec/target_page.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 5a20117ae8..67c0d59d9e 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -19,11 +19,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "helper-a64.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "qemu/xxhash.h"
 
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 2d40930157..bca6058e41 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -18,7 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
+#include "helper.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
 #include "system/runstate.h"
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 7729732369..ab5999c592 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "exec/helper-proto.h"
+#include "helper.h"
 #include "helper-sme.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/helper-retaddr.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 16e528e41a..062d8881bd 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -21,9 +21,9 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/page-protection.h"
-#include "exec/helper-proto.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
+#include "helper.h"
 #include "helper-a64.h"
 #include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 5c689d3b69..565954269f 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -7,12 +7,10 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 /*
  * Returns true if the stage 1 translation regime is using LPAE format page
  * tables. Used when raising alignment exceptions, whose FSR changes depending
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 580ec86c68..3f57006f9d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -26,14 +26,10 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
-#include "exec/helper-proto.h"
 #include "exec/target_page.h"
+#include "helper.h"
 #include "helper-mve.h"
 
-#define HELPER_H "helper.h"
-#include "exec/helper-info.c.inc"
-#undef  HELPER_H
-
 #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
 /* currently all emulated v5 cores are also v5TE, so don't bother */
@@ -45,6 +41,9 @@
 #define ENABLE_ARCH_7     arm_dc_feature(s, ARM_FEATURE_V7)
 #define ENABLE_ARCH_8     arm_dc_feature(s, ARM_FEATURE_V8)
 
+#define HELPER_H "tcg/helper-defs.h"
+#include "exec/helper-info.c.inc"
+
 /* These are TCG globals which alias CPUARMState fields */
 static TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1e30d7c77c..027769271c 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -6,7 +6,7 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
-#include "exec/helper-gen.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index a070ac9057..1223b843bf 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
+#include "helper.h"
 #include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index e156e3774a..45f2eb0930 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -19,14 +19,12 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
 #include "qemu/log.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 /*
  * Set the float_status behaviour to match the Arm defaults:
  *  * tininess-before-rounding
-- 
2.43.0


