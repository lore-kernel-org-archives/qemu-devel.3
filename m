Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F259C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8dD-0004qE-74; Thu, 06 Mar 2025 05:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tq8d9-0004os-3y; Thu, 06 Mar 2025 05:39:07 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tq8d4-0000TZ-52; Thu, 06 Mar 2025 05:39:06 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 6 Mar
 2025 18:38:47 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 6 Mar 2025 18:38:47 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v5 02/29] hw/intc/aspeed: Rename status_addr and addr to
 status_reg and reg for clarity
Date: Thu, 6 Mar 2025 18:38:10 +0800
Message-ID: <20250306103846.429221-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
References: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename the variables "status_addr" to "status_reg" and "addr" to "reg" because
they are used as register index. This change makes the code more appropriate
and improves readability.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/intc/aspeed_intc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 033b574c1e..465f41e4fd 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -60,7 +60,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
 {
     AspeedINTCState *s = (AspeedINTCState *)opaque;
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
-    uint32_t status_addr = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
+    uint32_t status_reg = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
     uint32_t select = 0;
     uint32_t enable;
     int i;
@@ -92,7 +92,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
 
     trace_aspeed_intc_select(select);
 
-    if (s->mask[irq] || s->regs[status_addr]) {
+    if (s->mask[irq] || s->regs[status_reg]) {
         /*
          * a. mask is not 0 means in ISR mode
          * sources interrupt routine are executing.
@@ -108,8 +108,8 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
          * notify firmware which source interrupt are coming
          * by setting status register
          */
-        s->regs[status_addr] = select;
-        trace_aspeed_intc_trigger_irq(irq, s->regs[status_addr]);
+        s->regs[status_reg] = select;
+        trace_aspeed_intc_trigger_irq(irq, s->regs[status_reg]);
         aspeed_intc_update(s, irq, 1);
     }
 }
@@ -117,17 +117,17 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
 static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
 {
     AspeedINTCState *s = ASPEED_INTC(opaque);
-    uint32_t addr = offset >> 2;
+    uint32_t reg = offset >> 2;
     uint32_t value = 0;
 
-    if (addr >= ASPEED_INTC_NR_REGS) {
+    if (reg >= ASPEED_INTC_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
         return 0;
     }
 
-    value = s->regs[addr];
+    value = s->regs[reg];
     trace_aspeed_intc_read(offset, size, value);
 
     return value;
@@ -138,12 +138,12 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
 {
     AspeedINTCState *s = ASPEED_INTC(opaque);
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
-    uint32_t addr = offset >> 2;
+    uint32_t reg = offset >> 2;
     uint32_t old_enable;
     uint32_t change;
     uint32_t irq;
 
-    if (addr >= ASPEED_INTC_NR_REGS) {
+    if (reg >= ASPEED_INTC_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
@@ -152,7 +152,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
 
     trace_aspeed_intc_write(offset, size, data);
 
-    switch (addr) {
+    switch (reg) {
     case R_GICINT128_EN:
     case R_GICINT129_EN:
     case R_GICINT130_EN:
@@ -177,7 +177,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
 
         /* disable all source interrupt */
         if (!data && !s->enable[irq]) {
-            s->regs[addr] = data;
+            s->regs[reg] = data;
             return;
         }
 
@@ -187,12 +187,12 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
         /* enable new source interrupt */
         if (old_enable != s->enable[irq]) {
             trace_aspeed_intc_enable(s->enable[irq]);
-            s->regs[addr] = data;
+            s->regs[reg] = data;
             return;
         }
 
         /* mask and unmask source interrupt */
-        change = s->regs[addr] ^ data;
+        change = s->regs[reg] ^ data;
         if (change & data) {
             s->mask[irq] &= ~change;
             trace_aspeed_intc_unmask(change, s->mask[irq]);
@@ -200,7 +200,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
             s->mask[irq] |= change;
             trace_aspeed_intc_mask(change, s->mask[irq]);
         }
-        s->regs[addr] = data;
+        s->regs[reg] = data;
         break;
     case R_GICINT128_STATUS:
     case R_GICINT129_STATUS:
@@ -220,7 +220,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
         }
 
         /* clear status */
-        s->regs[addr] &= ~data;
+        s->regs[reg] &= ~data;
 
         /*
          * These status registers are used for notify sources ISR are executed.
@@ -233,7 +233,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
         }
 
         /* All source ISR execution are done */
-        if (!s->regs[addr]) {
+        if (!s->regs[reg]) {
             trace_aspeed_intc_all_isr_done(irq);
             if (s->pending[irq]) {
                 /*
@@ -241,9 +241,9 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
                  * notify firmware which source interrupt are pending
                  * by setting status register
                  */
-                s->regs[addr] = s->pending[irq];
+                s->regs[reg] = s->pending[irq];
                 s->pending[irq] = 0;
-                trace_aspeed_intc_trigger_irq(irq, s->regs[addr]);
+                trace_aspeed_intc_trigger_irq(irq, s->regs[reg]);
                 aspeed_intc_update(s, irq, 1);
             } else {
                 /* clear irq */
@@ -253,7 +253,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
         }
         break;
     default:
-        s->regs[addr] = data;
+        s->regs[reg] = data;
         break;
     }
 
-- 
2.43.0


