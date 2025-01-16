Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04E9C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYO0W-0004vR-Fm; Thu, 16 Jan 2025 06:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYO0P-0004tF-4S
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:25:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYO0M-00048F-AX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:25:44 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so458302f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 03:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737026740; x=1737631540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIp/ry/DGiFODjiThDZlgJEFjr5yBLQ4629/fR6TMgU=;
 b=PiOlrDZ2gyTdTlZV9P1/C9kjwJ8UaYEek80dq8G+vVhERfav8L1ceaPaQxzBVgpIJ6
 sstDnLoApOw7aG5IgJcFj8W+Da+SyZ4cy3lIJKF9Fl0yjSDoP1W6XJO4HIuezNFjPnwH
 bfmKIbDKY2na2KnuoVyKxteIodH5aQTf3R6pvEruwDxEoj6JSMpv3adHdgypeXfb+dc9
 gvTGuPR6jSRKGDjb9uoCDQlmLx2DBLU0c2bZAXCgO2LJQZHLZcBOoX07IwRmPPSXURsp
 KVKDxQuJymtDMQC1LA9gE3bIOw0qr78/I9zkFA8TifM9wG7kdM3wl6QUvOCgHIB8fGaR
 OAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737026740; x=1737631540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIp/ry/DGiFODjiThDZlgJEFjr5yBLQ4629/fR6TMgU=;
 b=V7NVLokdnKnZr+pK0pDCj5bc0NkD8NH9iaCs1Gx/0zLJE1G4fXFxb1jRJb/cyoyiTH
 IgEkPDX8qYKScUhEvLd1En/GjZ/9FSkkNSQVha1LREGswrqzPX5dkhpEXnIdzPFDI193
 60lNeg38Q+6/M6ex6V78koTIZ/nhEWhUbuqQ5oKk1kUy58rjDBh109hbOBSTURQSsnjQ
 ug/F5j8A03JxfVHJvjbyNVBcmBRTEfoby/96Gd8U3gG27KgC5CxAr/HHmmLk6MEN9Ar3
 eJ8qRyeKCx4DACBEiElU0QhmlN3OkMXEA606l8HgxmXOyB5mrpSzpz6NeVy/h+bVG1bZ
 QP2g==
X-Gm-Message-State: AOJu0Yyc94Ie9P84fW5mq82Ox5TYmU2vDet95TC4552i1U/H1ZfPxmfW
 nPO7NtKB+KiyOqLwlY0j5Vh0NtOARd9NYmLmHElU6BARILJUnINPO6yMA39hXCTh6LXABCbw5u6
 L
X-Gm-Gg: ASbGncup88VtpH8P4MuwpnCMgIfDGkbsGAmY4dcc3DVWWSSAZKSrv7ipE4HBHYTPWc3
 Y2GDECU/oVZZHqMfOW+aY10lwXSYOkKHwNE0zskuNRgo7ZEILIcP1fhNXyJGTGdTlH9noaB+bcY
 yhRtnParHCi/T2QC7RmmwWHR3BSeyIaFKbv00sJfQFaUKSyStHPlHBFAdy79nYymVnOeKLW1BHp
 7Q9U9Ihyx3vpj7Zef/nCF0eNWsH+tauCQUHFML9rTkC4dBjDqOsj5a6djbSGe0=
X-Google-Smtp-Source: AGHT+IH0nGxYnA5tv29ZKxwqekh2BVt+jreovrVLqjjltp+eV3wXoz0PasPageY7SofVXG5jXrdkmw==
X-Received: by 2002:a5d:6c66:0:b0:38a:4184:151a with SMTP id
 ffacd0b85a97d-38a87336d7emr27638438f8f.37.1737026740345; 
 Thu, 16 Jan 2025 03:25:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm20636654f8f.10.2025.01.16.03.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:25:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] tests/tcg/x86_64/fma: Test some x86 fused-multiply-add
 cases
Date: Thu, 16 Jan 2025 11:25:36 +0000
Message-Id: <20250116112536.4117889-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116112536.4117889-1-peter.maydell@linaro.org>
References: <20250116112536.4117889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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


