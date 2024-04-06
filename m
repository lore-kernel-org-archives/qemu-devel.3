Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85465CD128A
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 05:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsykN-0002ra-5v; Sat, 06 Apr 2024 01:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykK-0002qu-Vg
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsykJ-0006Ij-6y
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 01:37:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e252f2bf23so25175915ad.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 22:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712381862; x=1712986662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjltTyIUkG4oE0AcOsKz1SbiNuo1Csm0+1nsuSZO9Hk=;
 b=NaAr0+NwTByfYhqBOyloW5DMn5UhJc3ScKGtDmmxIBVQ1i340BsT26oD4NU2pYyUlx
 a5xaVm/ZYPWmza7MkjVTheD/CBsOxWewUK+zixpDGgif3LcUjn4i904Ssk0+GHSuJ0rf
 MXPT6+lFvFfh0jGzjgL16U2/0qzZNiHwFYsytxQwH+z8Ouv7rUMZ4CT1wmjNpmWLyGxw
 HjYJJKiLo5B6fVk6gQCOW2+UcDFQsUhuJT4OkRH/VCF6oT4bnfl1Rp6FaQ7gGs0068ev
 0aMNF4SrxgIl34NqV6GvZlIyK5u2s99o+TfoDh6oxKHJJ0s9jlWxmcvZu60zIhVXMMgK
 7Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712381862; x=1712986662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjltTyIUkG4oE0AcOsKz1SbiNuo1Csm0+1nsuSZO9Hk=;
 b=ZGW4ZHkNA1TiSq+bLlvPezVFwIxK2CPRG+byfNdUOEtF0LR4bdQxCaLzMbZhvLxfbS
 wxCr4+Hh4G4Byr1DZRcMAzM/uTkKbqx88zF95Ri3oHvp6Pgd90FkFwbKVYTumiJqdLu/
 kQW6bu8gItRoB1Z9JJKKhM9BKoZQ7qFE2l8G1ZRua6849hbD06HhtGSyjRYBx0aFgwUJ
 aAW3smQFair08NVPNMPUDiAO8nsPfdMOlzDhoyFks6G3vF3qT4rJCRPOrwWV0EA18zgZ
 OXDlbs5y2PBFVxr9qk8r9UTkjzYg77e2MJdRmAuuM7EeyQ35wP+mH93PkaHtD9/6Lk3d
 mA/A==
X-Gm-Message-State: AOJu0YyPnHkAu3CWKjWhiDQ/J3urfVSEegPb9KMpuMt4W4+4iXYH9g+u
 iO9V9mRrSh/AkbMCvWIRitCgPHILBSQccEuiejn91EIU9nzFMdSMt9Qdxratz7kcTOoUMQVBJA+
 V
X-Google-Smtp-Source: AGHT+IGk218OB+DX0aFez9eZ86FSRtWmOirsEfj4leLTjJD/W36pNmmm1BBxLBWsfS2TlZAhj0YCXg==
X-Received: by 2002:a17:902:e542:b0:1e0:cdbf:24c2 with SMTP id
 n2-20020a170902e54200b001e0cdbf24c2mr3895820plf.29.1712381861942; 
 Fri, 05 Apr 2024 22:37:41 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001dc05535632sm2589378plh.170.2024.04.05.22.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 22:37:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zack@buhman.org,
	peter.maydell@linaro.org,
	ysato@users.sourceforge.jp
Subject: [PATCH v3 4/4] target/sh4: Fix mac.w with saturation enabled
Date: Fri,  5 Apr 2024 19:37:32 -1000
Message-Id: <20240406053732.191398-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406053732.191398-1-richard.henderson@linaro.org>
References: <20240406053732.191398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The saturation arithmetic logic in helper_macw is not correct.
I tested and verified this behavior on a SH7091.

Signed-off-by: Zack Buhman <zack@buhman.org>
Message-Id: <20240405233802.29128-3-zack@buhman.org>
[rth: Reformat helper_macw, add a test case.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/helper.h           |  2 +-
 target/sh4/op_helper.c        | 28 +++++++++-------
 tests/tcg/sh4/test-macw.c     | 61 +++++++++++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  3 ++
 4 files changed, 82 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/sh4/test-macw.c

diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index 64056e4a39..29011d3dbb 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -12,7 +12,7 @@ DEF_HELPER_1(discard_movcal_backup, void, env)
 DEF_HELPER_2(ocbi, void, env, i32)
 
 DEF_HELPER_3(macl, void, env, s32, s32)
-DEF_HELPER_3(macw, void, env, i32, i32)
+DEF_HELPER_3(macw, void, env, s32, s32)
 
 DEF_HELPER_2(ld_fpscr, void, env, i32)
 
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index d0bae0cc00..99394b714c 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -177,22 +177,28 @@ void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
     env->mac = res;
 }
 
-void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
+void helper_macw(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
-    int64_t res;
+    /* Inputs are already sign-extended from 16 bits. */
+    int32_t mul = arg0 * arg1;
 
-    res = ((uint64_t) env->mach << 32) | env->macl;
-    res += (int64_t) (int16_t) arg0 *(int64_t) (int16_t) arg1;
-    env->mach = (res >> 32) & 0xffffffff;
-    env->macl = res & 0xffffffff;
     if (env->sr & (1u << SR_S)) {
-        if (res < -0x80000000) {
+        /*
+         * In saturation arithmetic mode, the accumulator is 32-bit
+         * with carry. MACH is not considered during the addition
+         * operation nor the 32-bit saturation logic.
+         */
+        int32_t res, macl = env->macl;
+
+        if (sadd32_overflow(macl, mul, &res)) {
+            res = macl < 0 ? INT32_MIN : INT32_MAX;
+            /* If overflow occurs, the MACH register is set to 1. */
             env->mach = 1;
-            env->macl = 0x80000000;
-        } else if (res > 0x000000007fffffff) {
-            env->mach = 1;
-            env->macl = 0x7fffffff;
         }
+        env->macl = res;
+    } else {
+        /* In non-saturation arithmetic mode, the accumulator is 64-bit */
+        env->mac += mul;
     }
 }
 
diff --git a/tests/tcg/sh4/test-macw.c b/tests/tcg/sh4/test-macw.c
new file mode 100644
index 0000000000..4eceec8634
--- /dev/null
+++ b/tests/tcg/sh4/test-macw.c
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+int64_t mac_w(int64_t mac, const int16_t *a, const int16_t *b)
+{
+    register uint32_t macl __asm__("macl") = mac;
+    register uint32_t mach __asm__("mach") = mac >> 32;
+
+    asm volatile("mac.w @%0+,@%1+"
+                 : "+r"(a), "+r"(b), "+x"(macl), "+x"(mach));
+
+    return ((uint64_t)mach << 32) | macl;
+}
+
+typedef struct {
+    int64_t mac;
+    int16_t a, b;
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
+    res = mac_w(t->mac, &t->a, &t->b);
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
+        { 0, 2, 3, { 6, 6 } },
+        { 0x123456787ffffffell, 2, -3,
+          { 0x123456787ffffff8ll, 0x123456787ffffff8ll } },
+        { 0xabcdef127ffffffall, 2, 3,
+          { 0xabcdef1280000000ll, 0x000000017fffffffll } },
+        { 0xfffffffffll, INT16_MAX, INT16_MAX,
+          { 0x103fff0000ll, 0xf3fff0000ll } },
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
index 9a11c10924..4d09291c0c 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -14,3 +14,6 @@ VPATH += $(SRC_PATH)/tests/tcg/sh4
 
 test-macl: CFLAGS += -O -g
 TESTS += test-macl
+
+test-macw: CFLAGS += -O -g
+TESTS += test-macw
-- 
2.34.1


