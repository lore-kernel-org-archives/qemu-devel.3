Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0995CD1292
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 05:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsykK-0002qt-Hp; Sat, 06 Apr 2024 01:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykJ-0002qf-Jn
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:43 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykH-0006IY-Rj
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso19519865ad.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 22:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712381860; x=1712986660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNDwqVcutDiIERmHFyRHN/ZgN4CmsTKIxQUGe7pIcjw=;
 b=yRlIYthNpN79MdYRCo2XKjSOzYr/8QIVeMD0zQuOWjiA0HKdcnzxcdej6vPA+q7idh
 W/ple7ODrlrKxNFI5HCjU91A+s17s8XAQC+27AldXFSFuEQdeA4RZe1lfUGZQmB7JoQ1
 s2AjoyPpkbZzUXPYGxxLd+LdhbHjE0RjmFAsMKHU494Aic0iw1nkwcmULvh+yK/i+aBh
 MkbTm2anYyvolVOAp20Pg/XoYT9VUuBgTulXUpR5to4KFOmFKM6D+TRbwmB3QIlkjroW
 Ee8YJEOZAOFwmMbk6GOKbBgt7fuRlXnz8Ot91r57oFuuID/nYxp/LMQ/+NpBP4qYJO/p
 kCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712381860; x=1712986660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNDwqVcutDiIERmHFyRHN/ZgN4CmsTKIxQUGe7pIcjw=;
 b=YRjf8LInQxAlA/Kdc28Wb8tblrJtgc8hFcNdHKTcOJoERhoC06bHEP4NzM4iLVPkxf
 xV0MFbs0PMZMTdkY8bp5ps49l9I8pOAOpZmlIrCTMDsk5BIpHfigQO1q4+X+HMHd8wUZ
 iUFXP6UD2pQENon7OEvVdS4kXULHnY90kW+9CntVJ8DGLEn9q7cCqiQENu+bGfeML68z
 4UEM5EQC5IaT+YNV0lEuwanbRjnSI03+8Sb+0N30kH3I+XOS0CP888R4YL/GazKw7Ifr
 rDOKUg0Qib/HSLBdF8p2B8exDMOq83nLNMRtJYfxaOchO1+M912+AiJqm1ameGCjayyG
 Miuw==
X-Gm-Message-State: AOJu0YwjRGkiXZ+TkSBit9pu3OFCUIWdcJfo+u9a1Ao1k3Ur8hv15gEo
 hZSFR/3UkLt7r05QkWfUJ5T/oqxtXHDLftwj9l7zgF39PezN7lxEkmUrOHW/D+Lv6Qg9Gr6koBd
 I
X-Google-Smtp-Source: AGHT+IHnqjAFKupO/j+BXCydilO81rLvgIr5jftNW/sTUjjZ3H4JtseEja7Ji0dBrT9cYnuJ7MS1tQ==
X-Received: by 2002:a17:902:a387:b0:1e0:d631:5563 with SMTP id
 x7-20020a170902a38700b001e0d6315563mr3201583pla.66.1712381860408; 
 Fri, 05 Apr 2024 22:37:40 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001dc05535632sm2589378plh.170.2024.04.05.22.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 22:37:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zack@buhman.org,
	peter.maydell@linaro.org,
	ysato@users.sourceforge.jp
Subject: [PATCH v3 3/4] target/sh4: Fix mac.l with saturation enabled
Date: Fri,  5 Apr 2024 19:37:31 -1000
Message-Id: <20240406053732.191398-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406053732.191398-1-richard.henderson@linaro.org>
References: <20240406053732.191398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Zack Buhman <zack@buhman.org>

The saturation arithmetic logic in helper_macl is not correct.
I tested and verified this behavior on a SH7091.

Signed-off-by: Zack Buhman <zack@buhman.org>
Message-Id: <20240404162641.27528-2-zack@buhman.org>
[rth: Reformat helper_macl, add a test case.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/helper.h           |  2 +-
 target/sh4/op_helper.c        | 23 ++++++------
 tests/tcg/sh4/test-macl.c     | 67 +++++++++++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  5 +++
 4 files changed, 86 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/sh4/test-macl.c

diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index 8d792f6b55..64056e4a39 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -11,7 +11,7 @@ DEF_HELPER_3(movcal, void, env, i32, i32)
 DEF_HELPER_1(discard_movcal_backup, void, env)
 DEF_HELPER_2(ocbi, void, env, i32)
 
-DEF_HELPER_3(macl, void, env, i32, i32)
+DEF_HELPER_3(macl, void, env, s32, s32)
 DEF_HELPER_3(macw, void, env, i32, i32)
 
 DEF_HELPER_2(ld_fpscr, void, env, i32)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4559d0d376..d0bae0cc00 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -158,20 +158,23 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
     }
 }
 
-void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
+void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
+    const int64_t min = -(1ll << 47);
+    const int64_t max = (1ll << 47) - 1;
+    int64_t mul = (int64_t)arg0 * arg1;
+    int64_t mac = env->mac;
     int64_t res;
 
-    res = ((uint64_t) env->mach << 32) | env->macl;
-    res += (int64_t) (int32_t) arg0 *(int64_t) (int32_t) arg1;
-    env->mach = (res >> 32) & 0xffffffff;
-    env->macl = res & 0xffffffff;
-    if (env->sr & (1u << SR_S)) {
-        if (res < 0)
-            env->mach |= 0xffff0000;
-        else
-            env->mach &= 0x00007fff;
+    if (!(env->sr & (1u << SR_S))) {
+        res = mac + mul;
+    } else if (sadd64_overflow(mac, mul, &res)) {
+        res = mac < 0 ? min : max;
+    } else {
+        res = MIN(MAX(res, min), max);
     }
+
+    env->mac = res;
 }
 
 void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
diff --git a/tests/tcg/sh4/test-macl.c b/tests/tcg/sh4/test-macl.c
new file mode 100644
index 0000000000..b66c854365
--- /dev/null
+++ b/tests/tcg/sh4/test-macl.c
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#define MACL_S_MIN  (-(1ll << 47))
+#define MACL_S_MAX  ((1ll << 47) - 1)
+
+int64_t mac_l(int64_t mac, const int32_t *a, const int32_t *b)
+{
+    register uint32_t macl __asm__("macl") = mac;
+    register uint32_t mach __asm__("mach") = mac >> 32;
+
+    asm volatile("mac.l @%0+,@%1+"
+                 : "+r"(a), "+r"(b), "+x"(macl), "+x"(mach));
+
+    return ((uint64_t)mach << 32) | macl;
+}
+
+typedef struct {
+    int64_t mac;
+    int32_t a, b;
+    int64_t res[2];
+} Test;
+
+__attribute__((noinline))
+void test(const Test *t, int sat)
+{
+    int64_t res;
+
+    if (sat) {
+        asm volatile("sets");
+    } else {
+        asm volatile("clrs");
+    }
+    res = mac_l(t->mac, &t->a, &t->b);
+
+    if (res != t->res[sat]) {
+        fprintf(stderr, "%#llx + (%#x * %#x) = %#llx -- got %#llx\n",
+                t->mac, t->a, t->b, t->res[sat], res);
+        abort();
+    }
+}
+
+int main()
+{
+    static const Test tests[] = {
+        { 0x00007fff12345678ll, INT32_MAX, INT32_MAX,
+          { 0x40007ffe12345679ll, MACL_S_MAX } },
+        { MACL_S_MIN, -1, 1,
+          { 0xffff7fffffffffffll, MACL_S_MIN } },
+        { INT64_MIN, -1, 1,
+          { INT64_MAX, MACL_S_MIN } },
+        { 0x00007fff00000000ll, INT32_MAX, INT32_MAX,
+          { 0x40007ffe00000001ll, MACL_S_MAX } },
+        { 4, 1, 2, { 6, 6 } },
+        { -4, -1, -2, { -2, -2 } },
+    };
+
+    for (int i = 0; i < sizeof(tests) / sizeof(tests[0]); ++i) {
+        for (int j = 0; j < 2; ++j) {
+            test(&tests[i], j);
+        }
+    }
+    return 0;
+}
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 16eaa850a8..9a11c10924 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -9,3 +9,8 @@ run-signals: signals
 	$(call skip-test, $<, "BROKEN")
 run-plugin-signals-with-%:
 	$(call skip-test, $<, "BROKEN")
+
+VPATH += $(SRC_PATH)/tests/tcg/sh4
+
+test-macl: CFLAGS += -O -g
+TESTS += test-macl
-- 
2.34.1


