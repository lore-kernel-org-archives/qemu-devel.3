Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C16C1098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYZ-0002yl-Qv; Fri, 20 Mar 2026 09:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYY-0002wH-9L
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYU-00064H-Eh
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:25 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so101102066b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011981; x=1774616781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRX6bSLNd7JglBnF8oTUHMvUmVbVrp85pY+kXHoaidI=;
 b=jCOjyp6KS+VIbddUTvGRRnN5kV7xxXEQnwzwrkS5kPbRnTOsFNac05+HYFkrRRg4Co
 4zcZecwcDkrd/YOMXXvpMglqLGVIU3njCLQuZyX0Ov+r+zMqK942dfVV6twRl1I1cREu
 V/5pUCS4MAVDLcbB8gFDyBoOac20jVuSavLUaRK/eKl2dTn/YA0WhL7Bq5ad+TnoGTDn
 BnWSpCmvZgJMjpqo9+0wBfC41kCyAQCD7N2iHVEcPAp+4flxNXgMaArU3qxBq3NxmuEt
 H+U26ZzTzgNdQT4sS2SFchUws3vkhx4C5KUJJtmaWjkLw6aDHkAb7+GqnbBrMnlcvZcD
 RySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011981; x=1774616781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KRX6bSLNd7JglBnF8oTUHMvUmVbVrp85pY+kXHoaidI=;
 b=GVpsj4KZ0qOhDMMM4CTiSBQe+GwVxPMBqOQb0mCcggDpKDJCg9tDBz4ReI1qYvcWyg
 oX/wIYseLH1rG1l/Y/vyzMCF2WkEc1ujF5qCi4eThCbvdUYQ57kuS781aj0K6itC//fx
 W9JXJE8Lu0MRYsFoVkPRD18h+gc5plJTTnm+aAX8Biq35yXO6k6GDks+BJ9sZilsqusl
 Ryl502WVUiDbSJI0qnzmEj89dOdeWkhxJes3MRRcM1W9Q+r6EYJM82mkGhoo958H6MiA
 HSzMJgmdKfJRcK665DceC3LlxLFvJhymgoDuA08oE/dX9fFgWigNaJ4WX9OxCfpLcXe3
 vxKw==
X-Gm-Message-State: AOJu0YwsgqNINodGE5bGtRyl1G/DCcMUb8GSLy4xg9n7xH1P19fccJ0r
 yv0mhLt4Ns2F11gidbTMDpWUTYzNxIfN8wTb4Nzs0D/eOY8H8BMMVaMdiqcten/dl+Q=
X-Gm-Gg: ATEYQzxz4L3a6rnK9Qgq0YS9gm8E0bkH8y8g8Ic/EzNwjierUfcwV1OJZsowI4dJPob
 HfBxS2PB2AqleYnnEdvbUq6V3YESutEwUdzJHAm48AgJr5jtuO/b3xSHlI4cPbzRmxtQhAXdJKD
 +R0dtjW7rC6YZB68B67GTDDK+tc59zVB+xa+KBmn5/6OzurXSkhFPtaeWDU8cJ8QyCbjydaWupn
 2+t5GV6BNXIcze7LC0giIbyrOin0l2XfVXRhpK24q+f2qSbaHcBwpOJyB6bv6x+dj84pG8YJpMF
 oDkwufU57A0v0kVh8rF9vsMubWK+0XlAIZEr/b3dtHTS5pG+FrpdSsNkijM8Tct9I9iMsCeG0xt
 hiep7rjIktOo4FjHR5ZaXPaD8UAEAxJ1/p5itd4qn/G69RRLKBjAb3Cl0nbiVj8y5sAYZFpudSG
 MTWVAoSHx003xonbZ+wDwYe18=
X-Received: by 2002:a17:906:2099:b0:b8a:f2cb:8088 with SMTP id
 a640c23a62f3a-b982f37d13fmr133976766b.33.1774011980711; 
 Fri, 20 Mar 2026 06:06:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98335de3casm158540866b.35.2026.03.20.06.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D39035FAFB;
 Fri, 20 Mar 2026 13:06:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 35/35] tests/tcg: add basic test for aarch64 wf[ie][t]
 insns
Date: Fri, 20 Mar 2026 13:06:06 +0000
Message-ID: <20260320130607.2071996-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/wfx.c            | 126 ++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |   8 ++
 tests/tcg/aarch64/system/boot.S           |  12 ++-
 3 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/system/wfx.c

diff --git a/tests/tcg/aarch64/system/wfx.c b/tests/tcg/aarch64/system/wfx.c
new file mode 100644
index 00000000000..567d9e59c70
--- /dev/null
+++ b/tests/tcg/aarch64/system/wfx.c
@@ -0,0 +1,126 @@
+/*
+ * WFX Instructions Test (WFI, WFE, WFIT, WFET)
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+#include "gicv3.h"
+
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+#define isb() asm volatile("isb" : : : "memory")
+#define sev() asm volatile("sev" : : : "memory")
+#define wfi() asm volatile("wfi" : : : "memory")
+#define wfe() asm volatile("wfe" : : : "memory")
+#define wfit(reg) asm volatile("wfit %0" : : "r" (reg) : "memory")
+#define wfet(reg) asm volatile("wfet %0" : : "r" (reg) : "memory")
+
+#define enable_irq()  asm volatile("msr daifclr, #2" : : : "memory")
+#define disable_irq() asm volatile("msr daifset, #2" : : : "memory")
+
+static void wait_ticks(uint64_t ticks)
+{
+    uint64_t start = read_sysreg(cntvct_el0);
+    while ((read_sysreg(cntvct_el0) - start) < ticks) {
+        /* spin */
+    }
+}
+
+int main(void)
+{
+    uint64_t start, end, elapsed;
+    uint64_t timeout;
+
+    gicv3_init();
+    gicv3_enable_irq(27); /* Virtual Timer PPI */
+
+    ml_printf("WFX Test\n");
+
+    /* 1. Test WFI with timer interrupt */
+    ml_printf("Testing WFI...");
+    /* Setup virtual timer to fire in 100000 ticks (~2ms at 50MHz) */
+    start = read_sysreg(cntvct_el0);
+    write_sysreg(cntv_tval_el0, 100000);
+    write_sysreg(cntv_ctl_el0, 1); /* Enable timer, no mask */
+    isb();
+
+    /*
+     * We don't have a full interrupt handler, but WFI should wake up
+     * when the interrupt is pending even if we have it masked at the CPU.
+     * PSTATE.I is set by boot code.
+     *
+     * We unmask interrupts here to ensure the CPU can take the minimal
+     * exception handler defined in boot.S.
+     */
+    enable_irq();
+    wfi();
+    disable_irq();
+    end = read_sysreg(cntvct_el0);
+    elapsed = end - start;
+    if (elapsed < 100000) {
+        ml_printf("FAILED: WFI woke too early (%ld ticks)\n", elapsed);
+        return 1;
+    }
+    ml_printf("PASSED (elapsed %ld ticks)\n", elapsed);
+    write_sysreg(cntv_ctl_el0, 0); /* Disable timer */
+
+    /* 2. Test WFE and SEV */
+    ml_printf("Testing WFE/SEV...");
+    sev(); /* Set event register */
+    start = read_sysreg(cntvct_el0);
+    wfe(); /* Should return immediately */
+    end = read_sysreg(cntvct_el0);
+    elapsed = end - start;
+    /* while this should be fast there is some overhead from TCG */
+    if (elapsed > 20000) {
+        ml_printf("FAILED: WFE slept despite SEV (%ld ticks)\n", elapsed);
+        return 1;
+    }
+    ml_printf("PASSED (%ld ticks)\n", elapsed);
+
+    /* 3. Test WFIT */
+    ml_printf("Testing WFIT...");
+    start = read_sysreg(cntvct_el0);
+    timeout = start + 200000;
+    wfit(timeout);
+    end = read_sysreg(cntvct_el0);
+    elapsed = end - start;
+    if (elapsed < 200000) {
+        ml_printf("FAILED: WFIT woke too early (%ld ticks)\n", elapsed);
+        return 1;
+    }
+    ml_printf("PASSED (elapsed %ld ticks)\n", elapsed);
+
+    /* 4. Test WFET */
+    ml_printf("Testing WFET...");
+    start = read_sysreg(cntvct_el0);
+    timeout = start + 200000;
+    wfet(timeout);
+    end = read_sysreg(cntvct_el0);
+    elapsed = end - start;
+    if (elapsed < 200000) {
+        ml_printf("FAILED: WFET woke too early (%ld ticks)\n", elapsed);
+        return 1;
+    }
+    ml_printf("PASSED (elapsed %ld ticks)\n", elapsed);
+
+    ml_printf("ALL WFX TESTS PASSED\n");
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index c0939a0eeca..9a5b95de621 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -105,6 +105,14 @@ endif
 
 gicv3.o: gicv3.c gicv3.h
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+
+wfx: CFLAGS += -march=armv8.7-a
+wfx: LDFLAGS += gicv3.o
+wfx: gicv3.o
+
+QEMU_GICV3_MACHINE=-M virt,gic-version=3 -cpu max -display none
+run-wfx: QEMU_OPTS=$(QEMU_GICV3_MACHINE) $(QEMU_BASE_ARGS) -kernel
+
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
 QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
 QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 03a5bad2ab0..6a71fc0da5a 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -60,7 +60,6 @@ curr_sp0_irq:
 curr_sp0_fiq:
 curr_sp0_serror:
 curr_spx_sync:
-curr_spx_irq:
 curr_spx_fiq:
 curr_spx_serror:
 lower_a64_sync:
@@ -379,6 +378,17 @@ _exit:
 	semihosting_call
 	/* never returns */
 
+	/*
+	 * IRQ handler
+	 */
+	.global curr_spx_irq
+curr_spx_irq:
+	/* Minimal IRQ handler: just mask the timer and return */
+	mrs	x0, cntv_ctl_el0
+	orr	x0, x0, #2		/* IMASK=1 */
+	msr	cntv_ctl_el0, x0
+	eret
+
 	/*
 	 * Helper Functions
 	*/
-- 
2.47.3


