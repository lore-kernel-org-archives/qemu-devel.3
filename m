Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655F1C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYj-0004bb-G4; Fri, 24 Jan 2025 11:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMY7-0003ai-J8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMXz-0005Lf-P3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso16639895e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736121; x=1738340921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cIp/ry/DGiFODjiThDZlgJEFjr5yBLQ4629/fR6TMgU=;
 b=eyt0uoBfDPexOTWkAA62YwpBXmkPpUJse9P0JcMVngJSYcrbdVjlt3s3DlxlxS2coM
 L8lNUilQ191LUpPCl035Fq1Avpm6jdm6qJFbe63rdG3BgG3pdDxJ23KGGbuBdB55twrV
 Zr7Z+CaaY2knhoCS1uW1XIk8YE8tZtse6e0V7DKxiDWNewez3KyJ/uEBSD5KgIkxmuk+
 lgS6kpbkxIqR6RksmbNOm0K04fkiQCfAg5vwH4XuQIs9DIy8LViKExN4LevSIiAo44Ic
 3CPDkGPW5KMhZpbvPXm06SZjYcE+wKGUWtOcDXiZRxQvRvupAtV4P4JE/ZhbRzI25iv+
 qlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736121; x=1738340921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIp/ry/DGiFODjiThDZlgJEFjr5yBLQ4629/fR6TMgU=;
 b=s6fOhMEAavupJ/W6nHiFvSTGSYK+IJmOqbEbpg1vxk5N/MlP7PxIZpR4lJuHz/x1Nc
 OHuXUUSelcd9gk25fshouBpZo7F2FvoQeXLSPll1nrQBbGjG1raojoxZ+1/IGoBvYmNk
 oy6J5okPZLLbQzPthOW7DZUtJGoCAfjU17GOdeKVFrOing807zseIEKX8nZQTyJnnHbQ
 4hv5iJyN1opiiD6Pq+Yxsy22iF5QeDXoub/xhefKo75i6qUFN2a/Ve/qcUqB4WeyNDiC
 OnbDAqzhzVwsxvtv8g1hO5/w2hOgjMLTtVLo9iZiujFgHac8BdbqcPZ1OkYoVKaSL+iK
 q3qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsRYG2Bd2sYfSHEVky2ZgoNqpLhL2A3TRM/u9rJ5R0wEvzSaVXnKmg/6dPbPxsqIKVQ41/IsKopwfG@nongnu.org
X-Gm-Message-State: AOJu0YzCcOVBlKEkQJoNWQYwOSTKwv3TqVZL9mVJDTmMtt5EMCwcbXGf
 XeNCVL0hUFl3tpAUxcSn0qlp9mC1KAl+UbdGY1hfZ/0e5ztxD4sbinGCUx+lwSk=
X-Gm-Gg: ASbGncvxm0GIKKeqrgiQzVQ9R+e4xRsD5exQkDyP5rKkNmY1cBNeyikB15QGhFp104e
 Z+9oZ3u2Yj1GYJ99xzo0sHm2ZwnOtujrc54x9iK7SELfH1GEiUImXsDDD/dYt07MZgdL0NMzuD2
 /0lfRIiRwZR38ClWHb0qV25yXQ6Y2FAvO4VcW9wQ5UgKrGObvULHoJdxvNy+J5lR08Z7ZYoZExl
 rsG6ldLKUOcuZ76rBAy9SC/pDtk4a5RO+DpmOASKCg5t45zL23Njlqm3i/azP3laURPog38LWq6
 ox4I4UNfU/IFr8TnMe/peg==
X-Google-Smtp-Source: AGHT+IGhJP26rmZ+8qOjGIA71hRZDyGCg1aN4M13lOymGNE2lWMHW3w028YQnU1mD0OMlozuKydv6A==
X-Received: by 2002:a05:600c:1f0d:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-4389143923bmr262859175e9.24.1737736120992; 
 Fri, 24 Jan 2025 08:28:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/76] tests/tcg/x86_64/fma: Test some x86 fused-multiply-add
 cases
Date: Fri, 24 Jan 2025 16:27:22 +0000
Message-Id: <20250124162836.2332150-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a test case which tests some corner case behaviour of
fused-multiply-add on x86:
 * 0 * Inf + SNaN should raise Invalid
 * 0 * Inf + QNaN shouldh not raise Invalid
 * tininess should be detected after rounding

There is also one currently-disabled test case:
 * flush-to-zero should be done after rounding

This is disabled because QEMU's emulation currently does this
incorrectly (and so would fail the test).  The test case is kept in
but disabled, as the justification for why the test running harness
has support for testing both with and without FTZ set.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/x86_64/fma.c           | 109 +++++++++++++++++++++++++++++++
 tests/tcg/x86_64/Makefile.target |   1 +
 2 files changed, 110 insertions(+)
 create mode 100644 tests/tcg/x86_64/fma.c

diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
new file mode 100644
index 00000000000..09c622ebc00
--- /dev/null
+++ b/tests/tcg/x86_64/fma.c
@@ -0,0 +1,109 @@
+/*
+ * Test some fused multiply add corner cases.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <inttypes.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+/*
+ * Perform one "n * m + a" operation using the vfmadd insn and return
+ * the result; on return *mxcsr_p is set to the bottom 6 bits of MXCSR
+ * (the Flag bits). If ftz is true then we set MXCSR.FTZ while doing
+ * the operation.
+ * We print the operation and its results to stdout.
+ */
+static uint64_t do_fmadd(uint64_t n, uint64_t m, uint64_t a,
+                         bool ftz, uint32_t *mxcsr_p)
+{
+    uint64_t r;
+    uint32_t mxcsr = 0;
+    uint32_t ftz_bit = ftz ? (1 << 15) : 0;
+    uint32_t saved_mxcsr = 0;
+
+    asm volatile("stmxcsr %[saved_mxcsr]\n"
+                 "stmxcsr %[mxcsr]\n"
+                 "andl $0xffff7fc0, %[mxcsr]\n"
+                 "orl %[ftz_bit], %[mxcsr]\n"
+                 "ldmxcsr %[mxcsr]\n"
+                 "movq %[a], %%xmm0\n"
+                 "movq %[m], %%xmm1\n"
+                 "movq %[n], %%xmm2\n"
+                 /* xmm0 = xmm0 + xmm2 * xmm1 */
+                 "vfmadd231sd %%xmm1, %%xmm2, %%xmm0\n"
+                 "movq %%xmm0, %[r]\n"
+                 "stmxcsr %[mxcsr]\n"
+                 "ldmxcsr %[saved_mxcsr]\n"
+                 : [r] "=r" (r), [mxcsr] "=m" (mxcsr),
+                   [saved_mxcsr] "=m" (saved_mxcsr)
+                 : [n] "r" (n), [m] "r" (m), [a] "r" (a),
+                   [ftz_bit] "r" (ftz_bit)
+                 : "xmm0", "xmm1", "xmm2");
+    *mxcsr_p = mxcsr & 0x3f;
+    printf("vfmadd132sd 0x%" PRIx64 " 0x%" PRIx64 " 0x%" PRIx64
+           " = 0x%" PRIx64 " MXCSR flags 0x%" PRIx32 "\n",
+           n, m, a, r, *mxcsr_p);
+    return r;
+}
+
+typedef struct testdata {
+    /* Input n, m, a */
+    uint64_t n;
+    uint64_t m;
+    uint64_t a;
+    bool ftz;
+    /* Expected result */
+    uint64_t expected_r;
+    /* Expected low 6 bits of MXCSR (the Flag bits) */
+    uint32_t expected_mxcsr;
+} testdata;
+
+static testdata tests[] = {
+    { 0, 0x7ff0000000000000, 0x7ff000000000aaaa, false, /* 0 * Inf + SNaN */
+      0x7ff800000000aaaa, 1 }, /* Should be QNaN and does raise Invalid */
+    { 0, 0x7ff0000000000000, 0x7ff800000000aaaa, false, /* 0 * Inf + QNaN */
+      0x7ff800000000aaaa, 0 }, /* Should be QNaN and does *not* raise Invalid */
+    /*
+     * These inputs give a result which is tiny before rounding but which
+     * becomes non-tiny after rounding. x86 is a "detect tininess after
+     * rounding" architecture, so it should give a non-denormal result and
+     * not set the Underflow flag (only the Precision flag for an inexact
+     * result).
+     */
+    { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, false,
+      0x8010000000000000, 0x20 },
+    /*
+     * Flushing of denormal outputs to zero should also happen after
+     * rounding, so setting FTZ should not affect the result or the flags.
+     * QEMU currently does not emulate this correctly because we do the
+     * flush-to-zero check before rounding, so we incorrectly produce a
+     * zero result and set Underflow as well as Precision.
+     */
+#ifdef ENABLE_FAILING_TESTS
+    { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
+      0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
+#endif
+};
+
+int main(void)
+{
+    bool passed = true;
+    for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+        uint32_t mxcsr;
+        uint64_t r = do_fmadd(tests[i].n, tests[i].m, tests[i].a,
+                              tests[i].ftz, &mxcsr);
+        if (r != tests[i].expected_r) {
+            printf("expected result 0x%" PRIx64 "\n", tests[i].expected_r);
+            passed = false;
+        }
+        if (mxcsr != tests[i].expected_mxcsr) {
+            printf("expected MXCSR flags 0x%x\n", tests[i].expected_mxcsr);
+            passed = false;
+        }
+    }
+    return passed ? 0 : 1;
+}
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index d6dff559c7d..be20fc64e88 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -18,6 +18,7 @@ X86_64_TESTS += adox
 X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
 X86_64_TESTS += cross-modifying-code
+X86_64_TESTS += fma
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
-- 
2.34.1


