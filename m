Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CD1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgF-0007J5-Dr; Mon, 29 Jun 2026 08:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfm-0006yF-7M
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfi-0007UA-Of
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:09 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493b0fe95feso4828335e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734465; x=1783339265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ppLpIKgj1iYNeAkqUQhnvLVdqr6JLUnnYruG7BwRYA0=;
 b=rkfbJi2/uQEsUBxK96WAXcWtFghoRlqIkTrjMlR9xt+Drc33CfZtRJmkPVqWB3izUa
 XNIPmgfGOzd6emYEn6NrPZwPPpto31fNMSElkOvX1OjFoubOVvdLUIA+IJNZAfMnqDvQ
 LcNYQSqvBi53JB1j7iAe1PrDzBqBrXM1ojS6FxhNWRZgmRXfeyB+u5W0H3gnpZneceR/
 axIB2RutFmNpsEEIACkgbBbR6P/VPO12rmeetGcsOKPs5Og8IvQW4z5abGMlGzHbqpEu
 dfyA5LBSA4BYBT2nMb28lC7g7r9fyT77rc5ZxGYpmhCOBmWU5S11x7BW64S18UAJu4Ir
 nPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734465; x=1783339265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ppLpIKgj1iYNeAkqUQhnvLVdqr6JLUnnYruG7BwRYA0=;
 b=bDdnV6H5trZ53sv6P0TOCwhhpDrJJwEsAkbQXe9jxme5X3M2VvL4JJov3e0y20/1HG
 4T/CDjw2U39NfRhYGTkFiCSa6P1FMy4dBQad8QmwWDTfiSCou7fgbjHlk+6Q9CMRy+eE
 yfOQuXuS80g4xv6GgJGaqF8REx3DopNHASn0jwhyd8C55nfPnWi3NdQlNUCmQWBlzbfl
 wSO9/i/3T2YEg4DBzW3BhMXqFDOTP+OdJbt2FpUdkP1to6u/oqJvnZCXA0t7V3ucmKI2
 FN391P7XeJNBCSkpf8FENUpuwWTbBDprUoPkXbSCPpN7Tbh7p2OagoekgnXKpT+fFXHF
 t8ow==
X-Gm-Message-State: AOJu0YxvJWloi66CHQe8g4kQRFuqcXImXhVC/Cu8rgyYRI3bJ0eqRQp0
 eRujvTCKbDBBnLiAzt4kSSOjx+mPMhMvHk5EIGPy24Ul6d3/wrdqTtCHKFundX1qlYMhUf4zMuV
 xmSg3
X-Gm-Gg: AfdE7cnVw9uFNqHmxn0fqk7g2xJcr2+zGjEJTUUdaoe17SAanHtLT3Zr0Tg0AMhF68c
 7RvbAx/O7LfG90J5+yQ9qzOmO+doHHfhclxta2Xq0zPR9GzVqwGafM5+O+RCigr0qZ8dCeTuCUt
 VUJi+dRtsTZ4EYvcJrxa458/wNufzilGtdp2NfiSfm61Q0zgfEB3+gyZmgNRd1yZ1KZTHwrDBHZ
 LdRXnX0dbcWYKamBUJ1lJCJzP8w8sXlfWFvaPkQV3wYrb+LvZEHGiDy4n36H1buKd345puTUDZA
 EDnHmRj1limp4h8Rknwf98niPEtEEkJ8L+T8vjHkn9wE5tBcKJxrK4evCOvazzO78EcsNgoPnRP
 eJmtUH9qgZyalF2qd4Orz5z9DBWlC/T8bYn0Y1zLAN9WIuZjm+v0ygwo8E6z1J5XmNduxehNo2E
 aQD4xyNWIWWBq3pUqh0QU5640rXUpT4MgIMakbTi6Ds0SNicmV3iiBUMtrscfVC4h81ybsCREHI
 6sv8UGoBu/S6z191BbWJw==
X-Received: by 2002:a05:600c:3052:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493b6e4fbdemr6655885e9.25.1782734465092; 
 Mon, 29 Jun 2026 05:01:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/54] tests/tcg/aarch64/system/gpc-test.c: Basic test for
 granule protection check
Date: Mon, 29 Jun 2026 13:00:08 +0100
Message-ID: <20260629120032.1645265-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

* Sets up granule protection tables
* Enables GPC and bypass windows
* Performs memory accesses in the protected region to
  check for allowed and disallowed reads.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260618-jmac-gpc3b-v3-6-353e546067e7@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target |  11 +-
 tests/tcg/aarch64/system/gpc-test.c       | 165 ++++++++++++++++++++++
 2 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/system/gpc-test.c

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index c353b7f8d6..3f30be6c5d 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -53,7 +53,10 @@ memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 
 memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
 
-TESTS+=memory-sve
+gpc-test: gpc-test.c $(LINK_SCRIPT) vector_log_boot.o $(MINILIB_OBJS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) vector_log_boot.o
+
+TESTS+=memory-sve gpc-test
 
 # Running
 QEMU_BASE_MACHINE=-M virt -cpu max -display none
@@ -74,6 +77,12 @@ QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -
 QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
 run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
 
+# gpc tests need EL3 and RME
+QEMU_EL3_MACHINE=-machine virt,virtualization=on,secure=on,gic-version=3 -cpu max,x-rme=on
+QEMU_EL3_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="3"
+run-gpc-test:  QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
+run-gpc3-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
+
 # Simple Record/Replay Test
 .PHONY: memory-record
 run-memory-record: memory-record memory
diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
new file mode 100644
index 0000000000..f26b23efaf
--- /dev/null
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <minilib.h>
+#include "boot.h"
+
+#define ID_AA64PFR0_EL1 "S3_0_C0_C4_0"
+
+#define GPTBR_EL3 "S3_6_C2_C1_4"
+#define GPCBW_EL3 "S3_6_C2_C1_5"
+#define GPCCR_EL3 "S3_6_C2_C1_6"
+#define VBAR_EL3 "S3_6_C12_C0_0"
+
+#define get_sys_reg(register_name, dest) \
+        asm("mrs %[reg], " register_name "\n\t" : [reg] "=r" (dest))
+#define set_sys_reg(register_name, value) \
+        asm("msr " register_name ", %[reg]\n\r" : : [reg] "r" (value))
+
+const uint32_t gpc_granule_size = 4096;
+const uint32_t gpis_per_64_bits = 16;
+
+int main(uint64_t sp)
+{
+    uint64_t out;
+    uint64_t pfr0;
+    uint64_t gpt_base;
+    uint64_t rme_status;
+    uint64_t currentel_raw;
+    uint64_t currentel;
+    uint64_t gpcbw;
+    uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
+    uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
+
+    /* Mask is FNG1, FNG0, and A2 */
+    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
+    const uint64_t in = feature_mask;
+
+    get_sys_reg("CurrentEL", currentel_raw);
+    currentel = (currentel_raw >> 2) & 0x3;
+
+    if (currentel < 3) {
+        ml_printf("FAIL: Test must be run at EL3 (it is %d)\n", currentel);
+        return 1;
+    }
+
+    get_sys_reg(ID_AA64PFR0_EL1, pfr0);
+
+    /* rme_status is 1 for RME, 2 for RME + GPC2, 3 for RME+GPC3 */
+    rme_status = (pfr0 >> 52) & 0xF;
+    if (rme_status < 2) {
+        ml_printf("SKIP: System does not support RME (RME=%ld)\n", rme_status);
+        return 0;
+    }
+
+    /* Configure the level 0 table for the first 4GB of memory */
+    realms_gpt0[0] = gpt_table1_addr | 0x3; /* Covers GB 0; table descriptor */
+    realms_gpt0[1] = 0xf1; /* Covers GB 1; full access */
+    realms_gpt0[2] = 0xf1; /* Covers GB 2; full access */
+    realms_gpt0[3] = 0xf1; /* Covers GB 3; full access */
+
+    /* Pick an artibtrary location to read inside the first 1GB. */
+    uint64_t fault_location = 0x10202008;
+    uint32_t gpi_index = fault_location / gpc_granule_size;
+    realms_gpt1[gpi_index / gpis_per_64_bits] = 0;
+
+    gpt_base = gpt_table0_addr >> 12;
+    set_sys_reg(GPTBR_EL3, gpt_base);
+
+    /*
+     * Default values:
+     * PPS=0:     GPC table 0 protects 4GB.
+     * RLPAD=0:   Realm physical address spaces are normal
+     * NSPAD=0:   Non-secure physical address spaces are normal
+     * SPAD=0:    Secure physical address spaces are normal
+     * IRGN=0:    Inner non-cacheable
+     * ORGN=0:    Outer non-cacheable
+     * PGS=0:     Physical granule size is 4KB.
+     * GPCP=0:    All GPC faults reported
+     * TBGPCP=0:  Trace buffer rejects trace
+     * L0GPTSZ=0: Each entry in table 0 protects 1GB.
+     * APPSAA=0:  Accesses above 4GB must be to Non-secure PAs
+     * GPCBW=0:   Bypass windows disabled.
+     * NA6, NA7, NSP, SA, NSO are all reserved values for GPI.
+     */
+    uint64_t gpccr = 0;
+
+    /* Switch on granule protection check */
+    gpccr |= 1 << 16; /* GPC enabled. */
+    gpccr |= 0b10 << 12; /* SH = Outer shareable */
+    set_sys_reg(GPCCR_EL3, gpccr);
+
+    /* Access some memory outside the GPC forbidden region */
+    uint64_t x = *(unsigned int *) (fault_location + 4096 * 16);
+    ml_printf("Fault address: %lx\n", exception_fault_address);
+    if (exception_fault_address != 0) {
+        ml_printf("FAIL: Memory access was blocked by GPC, "
+                  "and should not have been\n");
+        return 1;
+    }
+
+    /* Access the GPC forbidden region */
+    x = *(unsigned int *) fault_location;
+
+    ml_printf("Fault address: %lx\n", exception_fault_address);
+    if (exception_fault_address != fault_location) {
+        ml_printf("FAIL: Memory access was not blocked by GPC, "
+                  "and should have been\n");
+        return 1;
+    }
+
+    rme_status = (pfr0 >> 52) & 0xF;
+    if (rme_status < 3) {
+        ml_printf("SKIP: System does not support GPC3 (RME=%ld)\n", rme_status);
+        return 0;
+    }
+
+    /* Clear the exception record */
+    exception_fault_address = 0;
+
+    /* Enable bypass windows */
+    gpccr |= 1 << 29; /* GPC Bypass windows enabled */
+    set_sys_reg(GPCCR_EL3, gpccr);
+
+    gpcbw = 0; /* Base 0GB, Size 1GB, Stride 1TB */
+    set_sys_reg(GPCBW_EL3, gpcbw);
+    ml_printf("GPCBW configured\n");
+
+    /* Access the GPC forbidden region again */
+    x = *(unsigned int *) fault_location;
+
+    ml_printf("Fault address: %lx\n", exception_fault_address);
+    if (exception_fault_address != 0) {
+        ml_printf("FAIL: Memory access was blocked by GPC, "
+                  "and should have been allowed by bypass window. code=%lx\n",
+                  exception_type_code);
+        return 1;
+    }
+
+    /* Clear the exception record */
+    exception_fault_address = 0;
+    /* Reconfigure GPCBW to 1GB start */
+    gpcbw = 1; /* Base 1GB, Size 1GB, Stride 1TB */
+    set_sys_reg(GPCBW_EL3, gpcbw);
+    ml_printf("GPCBW reconfigured for 1GB start\n");
+
+    /* Access the GPC forbidden region again */
+    x = *(unsigned int *) fault_location;
+
+    ml_printf("Fault address: %lx\n", exception_fault_address);
+    if (exception_fault_address != fault_location) {
+        ml_printf("FAIL: Memory access was allowed by GPC, "
+                  "and should not have been allowed by bypass window. code=%lx\n",
+                  exception_type_code);
+        return 1;
+    }
+
+    return 0;
+}
-- 
2.43.0


