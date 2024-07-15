Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7232C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEjS-0005Co-OY; Mon, 15 Jul 2024 01:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTEjQ-00054O-Pj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:58:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTEjO-0008VG-UJ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:58:40 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ca4649ad49so2423112a91.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721023117; x=1721627917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeM+PyZIgZuwJtOyeBwiQLcZE1Nzm+KGAI4nD2vg1aw=;
 b=PIizPCKQmIeN0doaiFJvzde2dR5ZhX2i2Epib/lJk6xHjczJqux+drG1YoyTSQzo0R
 tt6kY6/YWTpX4eDAmYhoXf7ojY62HqHSTDHFcokjCPCiBlg5VBX7n/cXBxaH11KSxcvX
 Ki7Cz6mURM1j2JjSm4mEU6i6X1YYkJflnmVVlA302NyNcbaFnof9CSOrYWNdLZpQrWrI
 3T0iYM8Fz3RZ5rMbRu+bfszog0DcMRf/vJ/v5EjqJlCFGxXJiyo0ZU2J73vW98nBjwCj
 uYAOLAKMEfXA+I0KmRwRimFI/YRz45xggTzqTcWkIS9/x+E4+SjO6jqVX87/37Y2zYaM
 OrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721023117; x=1721627917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeM+PyZIgZuwJtOyeBwiQLcZE1Nzm+KGAI4nD2vg1aw=;
 b=ODoTbYtKfAWC0zamLZkEQudRX72BO2knM3wdH0VpAczEmWWseZIQIEhwM80zGBEJiT
 ZyyYKjFTEjBzOL8uCjkt8H3fzD6Xk63owSYUtvKhaLdgDnHQK0Ro9hq4EuCaAQ3dmeyD
 uawQRlTYWICws/XHFpV5yj0wAJX403jwaQARDsKnHbxCeKhHVUTY7sjWnSYDSZGcgMkm
 JttWfQRFXwsXh9+9sHbqOqQFYLI6Jx7968NMy+syEJYflF/mDlQJ9UaR1tbqQDEexG85
 KXe0HvDSGfNIer075o1BegbgudzOOurs2do+jVyYrrbwDL0TzIHJjKvtZ++NlPCZu4Om
 6huw==
X-Gm-Message-State: AOJu0YwYQu6cGrIbX4yiYpTwRQ1wKpK+WRdWQDAmKNwEjcl0Xlq/IQrI
 Gkw7VJ3RkWvvEF+qOSqShKtj4dpu+k2xLIekZ5oZLLo6BAH39tWYRDHljpwdiSEWYR4MkWARTyy
 pkHnWRg==
X-Google-Smtp-Source: AGHT+IHx1hOpKlv/sKh63LvXVfxvqzsbg6YmdsEYFqjze+rw1LrGDUeJwAnTUVfXkaF9CZ7kxlTppA==
X-Received: by 2002:a17:90a:c684:b0:2c9:616a:6a46 with SMTP id
 98e67ed59e1d1-2ca35c29460mr11836719a91.17.1721023117255; 
 Sun, 14 Jul 2024 22:58:37 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd419af7sm5463589a91.25.2024.07.14.22.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 22:58:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: danikhan632@git.sr.ht, qemu-arm@nongnu.org,
 Daniyal Khan <danikhan632@gmail.com>
Subject: [PATCH 3/3] tests/tcg/aarch64: Add test cases for SME FMOPA (widening)
Date: Mon, 15 Jul 2024 15:58:20 +1000
Message-ID: <20240715055820.319035-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715055820.319035-1-richard.henderson@linaro.org>
References: <20240715055820.319035-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Daniyal Khan <danikhan632@gmail.com>

Signed-off-by: Daniyal Khan <danikhan632@gmail.com>
Message-Id: 172090222034.13953.16888708708822922098-1@git.sr.ht
[rth: Split test cases to separate patch, tidy assembly.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/sme-fmopa-1.c   | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/sme-fmopa-2.c   | 51 +++++++++++++++++++++++++
 tests/tcg/aarch64/sme-fmopa-3.c   | 58 ++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  5 ++-
 4 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme-fmopa-1.c
 create mode 100644 tests/tcg/aarch64/sme-fmopa-2.c
 create mode 100644 tests/tcg/aarch64/sme-fmopa-3.c

diff --git a/tests/tcg/aarch64/sme-fmopa-1.c b/tests/tcg/aarch64/sme-fmopa-1.c
new file mode 100644
index 0000000000..652c4ea090
--- /dev/null
+++ b/tests/tcg/aarch64/sme-fmopa-1.c
@@ -0,0 +1,63 @@
+/*
+ * SME outer product, 1 x 1.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+
+static void foo(float *dst)
+{
+    asm(".arch_extension sme\n\t"
+        "smstart\n\t"
+        "ptrue p0.s, vl4\n\t"
+        "fmov z0.s, #1.0\n\t"
+        /*
+         * An outer product of a vector of 1.0 by itself should be a matrix of 1.0.
+         * Note that we are using tile 1 here (za1.s) rather than tile 0.
+         */
+        "zero {za}\n\t"
+        "fmopa za1.s, p0/m, p0/m, z0.s, z0.s\n\t"
+        /*
+         * Read the first 4x4 sub-matrix of elements from tile 1:
+         * Note that za1h should be interchangeable here.
+         */
+        "mov w12, #0\n\t"
+        "mova z0.s, p0/m, za1v.s[w12, #0]\n\t"
+        "mova z1.s, p0/m, za1v.s[w12, #1]\n\t"
+        "mova z2.s, p0/m, za1v.s[w12, #2]\n\t"
+        "mova z3.s, p0/m, za1v.s[w12, #3]\n\t"
+        /*
+         * And store them to the input pointer (dst in the C code):
+         */
+        "st1w {z0.s}, p0, [%0]\n\t"
+        "add x0, x0, #16\n\t"
+        "st1w {z1.s}, p0, [x0]\n\t"
+        "add x0, x0, #16\n\t"
+        "st1w {z2.s}, p0, [x0]\n\t"
+        "add x0, x0, #16\n\t"
+        "st1w {z3.s}, p0, [x0]\n\t"
+        "smstop"
+        : : "r"(dst)
+        : "x12", "d0", "d1", "d2", "d3", "memory");
+}
+
+int main()
+{
+    float dst[16] = { };
+
+    foo(dst);
+
+    for (int i = 0; i < 16; i++) {
+        if (dst[i] != 1.0f) {
+            goto failure;
+        }
+    }
+    /* success */
+    return 0;
+
+ failure:
+    for (int i = 0; i < 16; i++) {
+        printf("%f%c", dst[i], i % 4 == 3 ? '\n' : ' ');
+    }
+    return 1;
+}
diff --git a/tests/tcg/aarch64/sme-fmopa-2.c b/tests/tcg/aarch64/sme-fmopa-2.c
new file mode 100644
index 0000000000..198cc31528
--- /dev/null
+++ b/tests/tcg/aarch64/sme-fmopa-2.c
@@ -0,0 +1,51 @@
+#include <stdint.h>
+#include <stdio.h>
+
+static void test_fmopa(uint32_t *result)
+{
+    asm(".arch_extension sme\n\t"
+        "smstart\n\t"               /* Z*, P* and ZArray cleared */
+        "ptrue p2.b, vl16\n\t"      /* Limit vector length to 16 */
+        "ptrue p5.b, vl16\n\t"
+        "movi d0, #0x00ff\n\t"      /* fp16 denormal */
+        "movi d16, #0x00ff\n\t"
+        "mov w15, #0x0001000000\n\t" /* FZ=1, FZ16=0 */
+        "msr fpcr, x15\n\t"
+        "fmopa za3.s, p2/m, p5/m, z16.h, z0.h\n\t"
+        "mov w15, #0\n\t"
+        "st1w {za3h.s[w15, 0]}, p2, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 1]}, p2, [%0]\n\t"
+        "mov w15, #2\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 0]}, p2, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 1]}, p2, [%0]\n\t"
+        "smstop"
+        : "+r"(result) :
+        : "x15", "x16", "p2", "p5", "d0", "d16", "memory");
+}
+
+int main(void)
+{
+    uint32_t result[4 * 4] = { };
+
+    test_fmopa(result);
+
+    if (result[0] != 0x2f7e0100) {
+        printf("Test failed: Incorrect output in first 4 bytes\n"
+               "Expected: %08x\n"
+               "Got:      %08x\n",
+               0x2f7e0100, result[0]);
+        return 1;
+    }
+
+    for (int i = 1; i < 16; ++i) {
+        if (result[i] != 0) {
+            printf("Test failed: Non-zero word at position %d\n", i);
+            return 1;
+        }
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/sme-fmopa-3.c b/tests/tcg/aarch64/sme-fmopa-3.c
new file mode 100644
index 0000000000..6617355c9d
--- /dev/null
+++ b/tests/tcg/aarch64/sme-fmopa-3.c
@@ -0,0 +1,58 @@
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <math.h>
+
+static const float i_1234[4] = {
+    1.0f, 2.0f, 3.0f, 4.0f
+};
+
+static const float expected[4] = {
+    4.515625f, 5.750000f, 6.984375f, 8.218750f
+};
+
+static void test_fmopa(float *result)
+{
+    asm(".arch_extension sme\n\t"
+        "smstart\n\t"               /* ZArray cleared */
+        "ptrue p2.b, vl16\n\t"      /* Limit vector length to 16 */
+        "ld1w {z0.s}, p2/z, [%1]\n\t"
+        "mov w15, #0\n\t"
+        "mov za3h.s[w15, 0], p2/m, z0.s\n\t"
+        "mov za3h.s[w15, 1], p2/m, z0.s\n\t"
+        "mov w15, #2\n\t"
+        "mov za3h.s[w15, 0], p2/m, z0.s\n\t"
+        "mov za3h.s[w15, 1], p2/m, z0.s\n\t"
+        "msr fpcr, xzr\n\t"
+        "fmopa za3.s, p2/m, p2/m, z0.h, z0.h\n\t"
+        "mov w15, #0\n\t"
+        "st1w {za3h.s[w15, 0]}, p2, [%0]\n"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 1]}, p2, [%0]\n\t"
+        "mov w15, #2\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 0]}, p2, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 1]}, p2, [%0]\n\t"
+        "smstop"
+        : "+r"(result) : "r"(i_1234)
+        : "x15", "x16", "p2", "d0", "memory");
+}
+
+int main(void)
+{
+    float result[4 * 4] = { };
+    int ret = 0;
+
+    test_fmopa(result);
+
+    for (int i = 0; i < 4; i++) {
+        float actual = result[i];
+        if (fabsf(actual - expected[i]) > 0.001f) {
+            printf("Test failed at element %d: Expected %f, got %f\n",
+                   i, expected[i], actual);
+            ret = 1;
+        }
+    }
+    return ret;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index b53218e115..8cc62eb456 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -70,8 +70,9 @@ endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
-sme-outprod1 sme-smopa-1 sme-smopa-2: CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
+SME_TESTS = sme-outprod1 sme-smopa-1 sme-smopa-2 sme-fmopa-1 sme-fmopa-2 sme-fmopa-3
+AARCH64_TESTS += $(SME_TESTS)
+$(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # System Registers Tests
-- 
2.43.0


