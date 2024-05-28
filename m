Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CA9C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqD2-00087q-VH; Tue, 28 May 2024 02:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBqCs-000837-AB; Tue, 28 May 2024 02:21:12 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBqCo-0005D5-SK; Tue, 28 May 2024 02:21:10 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d1bc1e5d14so247019b6e.1; 
 Mon, 27 May 2024 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716877261; x=1717482061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yh4cAOFdJM4vPO38/aZsEZ8c2y3Xpg4N5nLTC+wWOo=;
 b=DrHuqVAvGeTOjf/3A46FhYRhkHxu4qYwCtA0DBi+AcgCUoDbbM42bUO/qci8u1Lfw1
 rfb/wVk7B7dXcxGryA6RoVX4FNagvtID45OR73YkOW2yTndT0OrYaDLhXVA68pOxsGSA
 /fT4GkFh4V2MosKdcSw2/Fo+uU5bUPIEevVMWyQvLBMu9u4zDWnhnVgHjqdhDMp7qHHz
 hK+O0AzjDcq1iSZqwx4v4q81ipuj7jT4usmiZe15f7nr/VEcD0pnEuja9Duv0AeCnSSd
 VxLQkwW+BCpmLFCiyHdaDMZ2mnimhMf/Sk9rM1TeMIt2XQ+7o2mSn/Rv1P5TOImmEcYw
 SJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716877261; x=1717482061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yh4cAOFdJM4vPO38/aZsEZ8c2y3Xpg4N5nLTC+wWOo=;
 b=j9BWEmlh+zDjdrXQDV3ZQnfa4NSDDJBqYY1DtlXjtIE57iF+NyivrQnyp5DBwu0TcQ
 kyWwah0AyisUIpIGxTANU0tqWRfz9JbpTKPlm+InZ4M3ihiROnQ0Emkka1WRTAxDbHqg
 25W3tRdaUJ+0JfmcQFDT8ik6Ldcxjs3w3Y4EeQbzRrxP/zFzfeC5WNVhcgny6Cg63HJa
 +EDsExzqUz2dK7+D94LlBOfpEe8ySbb/Pzcs8Sfaa6lAdV76xB85ErhDUn4fxcSnmphi
 WS94Dj5cxOoRnTz+yOHFSlfMZ4rUqVP3g/27bOZgavxSGwZuX927EfjGCnAgVD7KAmxZ
 m+jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHTuKObIaEW/h6XdUlEOWMbyz2WEUo+eMyGPJ+v5rJYPfV12YXg0hvpoLdUE9eC01QTFFdDA9ro6IjkjCO5fLDcLpkXrM=
X-Gm-Message-State: AOJu0YzUrrQUB80gqHwNMbdNhe5duDQER5AuZm5Gtg8mhPOqcxEHXnij
 MjI+fmcABOqesDPg68xhIvDHBiQuDZHHzSur8We8G/xqUAYldthEWuvl/Q==
X-Google-Smtp-Source: AGHT+IE0hVcfuuihGUbACebTsDjxJ5xshd5WeDLAy5gOMENXNVfosCZHoPsKSypMWCVG5g3+/I9oEA==
X-Received: by 2002:a05:6870:d62c:b0:24f:c95b:acd with SMTP id
 586e51a60fabf-24fc95b3793mr9243187fac.43.1716877260959; 
 Mon, 27 May 2024 23:21:00 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbdesm5969779b3a.18.2024.05.27.23.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 23:21:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] ppc/pnv: Implement POWER9 LPC PSI serirq outputs and
 auto-clear function
Date: Tue, 28 May 2024 16:20:45 +1000
Message-ID: <20240528062045.624906-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528062045.624906-1-npiggin@gmail.com>
References: <20240528062045.624906-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The POWER8 LPC ISA device irqs all get combined and reported to the line
connected the PSI LPCHC irq. POWER9 changed this so only internal LPC
host controller irqs use that line, and the device irqs get routed to
4 new lines connected to PSI SERIRQ0-3.

POWER9 also introduced a new feature that automatically clears the irq
status in the LPC host controller when EOI'ed, so software does not have
to.

The powernv OPAL (skiboot) firmware managed to work because the LPCHC
irq handler scanned all LPC irqs and handled those including clearing
status even on POWER9 systems. So LPC irqs worked despite OPAL thinking
it was running in POWER9 mode. After this change, UART interrupts show
up on serirq1 which is where OPAL routes them to:

 cat /proc/interrupts
 ...
 20:          0  XIVE-IRQ 1048563 Level     opal-psi#0:lpchc
 ...
 25:         34  XIVE-IRQ 1048568 Level     opal-psi#0:lpc_serirq_mux1

Whereas they previously turn up on lpchc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Fix and test power8
- Rebase onto Glenn's fix
- Move irq_to_serirq_route from global into PnvLpcController
- Don't have SERIRQ irqs latch the OPB irq status register, docs don't
  suggest they do and skiboot does not clear that bit for SERIRQ path.
- Have the SERIRQ path use the LPCHC IRQ mask (missed in previous
  patch).

 include/hw/ppc/pnv_lpc.h |  14 ++++-
 hw/ppc/pnv.c             |  36 +++++++++--
 hw/ppc/pnv_lpc.c         | 128 ++++++++++++++++++++++++++++++++-------
 3 files changed, 148 insertions(+), 30 deletions(-)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 97c6872c3f..e0fd5e4130 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -23,6 +23,7 @@
 #include "exec/memory.h"
 #include "hw/ppc/pnv.h"
 #include "hw/qdev-core.h"
+#include "hw/isa/isa.h" /* For ISA_NUM_IRQS */
 
 #define TYPE_PNV_LPC "pnv-lpc"
 typedef struct PnvLpcClass PnvLpcClass;
@@ -87,8 +88,19 @@ struct PnvLpcController {
     /* XSCOM registers */
     MemoryRegion xscom_regs;
 
+    /*
+     * In P8, ISA irqs are combined with internal sources to drive the
+     * LPCHC interrupt output. P9 ISA irqs raise one of 4 lines that
+     * drive PSI SERIRQ irqs, routing according to OPB routing registers.
+     */
+    bool psi_has_serirq;
+
     /* PSI to generate interrupts */
-    qemu_irq psi_irq;
+    qemu_irq psi_irq_lpchc;
+
+    /* P9 serirq lines and irq routing table */
+    qemu_irq psi_irq_serirq[4];
+    int irq_to_serirq_route[ISA_NUM_IRQS];
 };
 
 struct PnvLpcClass {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec..f6c3e91b3a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -728,7 +728,8 @@ static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
     Pnv8Chip *chip8 = PNV8_CHIP(chip);
     qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip8->psi), PSIHB_IRQ_EXTERNAL);
 
-    qdev_connect_gpio_out(DEVICE(&chip8->lpc), 0, irq);
+    qdev_connect_gpio_out_named(DEVICE(&chip8->lpc), "LPCHC", 0, irq);
+
     return pnv_lpc_isa_create(&chip8->lpc, true, errp);
 }
 
@@ -737,25 +738,48 @@ static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **errp)
     Pnv8Chip *chip8 = PNV8_CHIP(chip);
     qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip8->psi), PSIHB_IRQ_LPC_I2C);
 
-    qdev_connect_gpio_out(DEVICE(&chip8->lpc), 0, irq);
+    qdev_connect_gpio_out_named(DEVICE(&chip8->lpc), "LPCHC", 0, irq);
+
     return pnv_lpc_isa_create(&chip8->lpc, false, errp);
 }
 
 static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
-    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_LPCHC);
+    qemu_irq irq;
+
+    irq = qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_LPCHC);
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "LPCHC", 0, irq);
+
+    irq = qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_LPC_SIRQ0);
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 0, irq);
+    irq = qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_LPC_SIRQ1);
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 1, irq);
+    irq = qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_LPC_SIRQ2);
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 2, irq);
+    irq = qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_LPC_SIRQ3);
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 3, irq);
 
-    qdev_connect_gpio_out(DEVICE(&chip9->lpc), 0, irq);
     return pnv_lpc_isa_create(&chip9->lpc, false, errp);
 }
 
 static ISABus *pnv_chip_power10_isa_create(PnvChip *chip, Error **errp)
 {
     Pnv10Chip *chip10 = PNV10_CHIP(chip);
-    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ_LPCHC);
+    qemu_irq irq;
+
+    irq = qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ_LPCHC);
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "LPCHC", 0, irq);
+
+    irq = qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ_LPC_SIRQ0);
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 0, irq);
+    irq = qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ_LPC_SIRQ1);
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 1, irq);
+    irq = qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ_LPC_SIRQ2);
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 2, irq);
+    irq = qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ_LPC_SIRQ3);
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 3, irq);
 
-    qdev_connect_gpio_out(DEVICE(&chip10->lpc), 0, irq);
     return pnv_lpc_isa_create(&chip10->lpc, false, errp);
 }
 
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 252690dcaa..8d0895e6e8 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -64,6 +64,7 @@ enum {
 #define   LPC_HC_IRQSER_START_4CLK      0x00000000
 #define   LPC_HC_IRQSER_START_6CLK      0x01000000
 #define   LPC_HC_IRQSER_START_8CLK      0x02000000
+#define   LPC_HC_IRQSER_AUTO_CLEAR      0x00800000
 #define LPC_HC_IRQMASK          0x34    /* same bit defs as LPC_HC_IRQSTAT */
 #define LPC_HC_IRQSTAT          0x38
 #define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down to ... */
@@ -420,32 +421,90 @@ static const MemoryRegionOps pnv_lpc_mmio_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
+/* Program the POWER9 LPC irq to PSI serirq routing table */
+static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
 {
-    bool lpc_to_opb_irq = false;
+    int irq;
 
-    /* Update LPC controller to OPB line */
-    if (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN) {
-        uint32_t irqs;
+    if (!lpc->psi_has_serirq) {
+        if ((lpc->opb_irq_route0 & PPC_BITMASK(8, 13)) ||
+            (lpc->opb_irq_route1 & PPC_BITMASK(4, 31))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "OPB: setting serirq routing on POWER8 system, ignoring.\n");
+        }
+        return;
+    }
 
-        irqs = lpc->lpc_hc_irqstat & lpc->lpc_hc_irqmask;
-        lpc_to_opb_irq = (irqs != 0);
+    for (irq = 0; irq <= 13; irq++) {
+        int serirq = (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) & 0x3;
+        lpc->irq_to_serirq_route[irq] = serirq;
     }
 
-    /* We don't honor the polarity register, it's pointless and unused
-     * anyway
-     */
-    if (lpc_to_opb_irq) {
-        lpc->opb_irq_input |= OPB_MASTER_IRQ_LPC;
-    } else {
-        lpc->opb_irq_input &= ~OPB_MASTER_IRQ_LPC;
+    for (irq = 14; irq < ISA_NUM_IRQS; irq++) {
+        int serirq = (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) & 0x3;
+        lpc->irq_to_serirq_route[irq] = serirq;
     }
+}
 
-    /* Update OPB internal latch */
-    lpc->opb_irq_stat |= lpc->opb_irq_input & lpc->opb_irq_mask;
+static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
+{
+    uint32_t active_irqs = 0;
+
+    if (lpc->lpc_hc_irqstat & PPC_BITMASK32(16, 31)) {
+        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented irqs in IRQSTAT: "
+                                 "0x%08"PRIx32"\n", lpc->lpc_hc_irqstat);
+    }
+
+    if (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN) {
+        active_irqs = lpc->lpc_hc_irqstat & lpc->lpc_hc_irqmask;
+    }
 
     /* Reflect the interrupt */
-    qemu_set_irq(lpc->psi_irq, lpc->opb_irq_stat != 0);
+    if (!lpc->psi_has_serirq) {
+        /*
+         * POWER8 ORs all irqs together (also with LPCHC internal interrupt
+         * sources) and outputs a single line that raises the PSI LPCHC irq
+         * which then latches an OPB IRQ status register that sends the irq
+         * to PSI.
+         */
+        /* We don't honor the polarity register, it's pointless and unused
+         * anyway
+         */
+        if (active_irqs) {
+            lpc->opb_irq_input |= OPB_MASTER_IRQ_LPC;
+        } else {
+            lpc->opb_irq_input &= ~OPB_MASTER_IRQ_LPC;
+        }
+
+        /* Update OPB internal latch */
+        lpc->opb_irq_stat |= lpc->opb_irq_input & lpc->opb_irq_mask;
+
+        qemu_set_irq(lpc->psi_irq_lpchc, lpc->opb_irq_stat != 0);
+    } else {
+        /*
+         * POWER9 and POWER10 have routing fields in OPB master registers that
+         * send LPC irqs to 4 output lines that raise the PSI SERIRQ irqs.
+         * These don't appear to get latched into an OPB register like the
+         * LPCHC irqs.
+         *
+         * POWER9 LPC controller internal irqs still go via the OPB
+         * and LPCHC PSI irqs like P8, but we have no such internal sources
+         * modelled yet.
+         */
+        bool serirq_out[4] = { false, false, false, false };
+        int irq;
+
+        for (irq = 0; irq < ISA_NUM_IRQS; irq++) {
+            if (active_irqs & (LPC_HC_IRQ_SERIRQ0 >> irq)) {
+                serirq_out[lpc->irq_to_serirq_route[irq]] = true;
+            }
+        }
+
+        qemu_set_irq(lpc->psi_irq_serirq[0], serirq_out[0]);
+        qemu_set_irq(lpc->psi_irq_serirq[1], serirq_out[1]);
+        qemu_set_irq(lpc->psi_irq_serirq[2], serirq_out[2]);
+        qemu_set_irq(lpc->psi_irq_serirq[3], serirq_out[3]);
+    }
 }
 
 static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
@@ -543,10 +602,10 @@ static uint64_t opb_master_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t val = 0xfffffffffffffffful;
 
     switch (addr) {
-    case OPB_MASTER_LS_ROUTE0: /* TODO */
+    case OPB_MASTER_LS_ROUTE0:
         val = lpc->opb_irq_route0;
         break;
-    case OPB_MASTER_LS_ROUTE1: /* TODO */
+    case OPB_MASTER_LS_ROUTE1:
         val = lpc->opb_irq_route1;
         break;
     case OPB_MASTER_LS_IRQ_STAT:
@@ -575,11 +634,15 @@ static void opb_master_write(void *opaque, hwaddr addr,
     PnvLpcController *lpc = opaque;
 
     switch (addr) {
-    case OPB_MASTER_LS_ROUTE0: /* TODO */
+    case OPB_MASTER_LS_ROUTE0:
         lpc->opb_irq_route0 = val;
+        pnv_lpc_eval_serirq_routes(lpc);
+        pnv_lpc_eval_irqs(lpc);
         break;
-    case OPB_MASTER_LS_ROUTE1: /* TODO */
+    case OPB_MASTER_LS_ROUTE1:
         lpc->opb_irq_route1 = val;
+        pnv_lpc_eval_serirq_routes(lpc);
+        pnv_lpc_eval_irqs(lpc);
         break;
     case OPB_MASTER_LS_IRQ_STAT:
         lpc->opb_irq_stat &= ~val;
@@ -664,6 +727,8 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
     PnvLpcClass *plc = PNV_LPC_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    object_property_set_bool(OBJECT(lpc), "psi-serirq", true, &error_abort);
+
     plc->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -673,6 +738,9 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
     /* P9 uses a MMIO region */
     memory_region_init_io(&lpc->xscom_regs, OBJECT(lpc), &pnv_lpc_mmio_ops,
                           lpc, "lpcm", PNV9_LPCM_SIZE);
+
+    /* P9 LPC routes ISA irqs to 4 PSI SERIRQ lines */
+    qdev_init_gpio_out_named(dev, lpc->psi_irq_serirq, "SERIRQ", 4);
 }
 
 static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
@@ -751,13 +819,19 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
                                 &lpc->lpc_hc_regs);
 
-    qdev_init_gpio_out(dev, &lpc->psi_irq, 1);
+    qdev_init_gpio_out_named(dev, &lpc->psi_irq_lpchc, "LPCHC", 1);
 }
 
+static Property pnv_lpc_properties[] = {
+    DEFINE_PROP_BOOL("psi-serirq", PnvLpcController, psi_has_serirq, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    device_class_set_props(dc, pnv_lpc_properties);
     dc->realize = pnv_lpc_realize;
     dc->desc = "PowerNV LPC Controller";
     dc->user_creatable = false;
@@ -803,7 +877,7 @@ static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
     }
 
     if (pnv->cpld_irqstate != old_state) {
-        qemu_set_irq(lpc->psi_irq, pnv->cpld_irqstate != 0);
+        qemu_set_irq(lpc->psi_irq_lpchc, pnv->cpld_irqstate != 0);
     }
 }
 
@@ -824,6 +898,13 @@ static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
         pnv_lpc_eval_irqs(lpc);
     } else {
         lpc->lpc_hc_irq_inputs &= ~irq_bit;
+
+        /* POWER9 adds an auto-clear mode that clears IRQSTAT bits on EOI */
+        if (lpc->psi_has_serirq &&
+            (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_AUTO_CLEAR)) {
+            lpc->lpc_hc_irqstat &= ~irq_bit;
+            pnv_lpc_eval_irqs(lpc);
+        }
     }
 }
 
@@ -854,6 +935,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp)
         handler = pnv_lpc_isa_irq_handler;
     }
 
+    /* POWER has a 17th irq, QEMU only implements the 16 regular device irqs */
     irqs = qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
 
     isa_bus_register_input_irqs(isa_bus, irqs);
-- 
2.43.0


