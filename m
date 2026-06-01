Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48529CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 03:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTt9A-0000F5-IA; Sun, 31 May 2026 23:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wTt98-0000Ei-Nv; Sun, 31 May 2026 23:16:58 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wTt96-0007td-Ln; Sun, 31 May 2026 23:16:58 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gTJz065H4z5B13X;
 Mon, 01 Jun 2026 11:16:44 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
 by mse-fl2.zte.com.cn with SMTP id 6513GacE027226;
 Mon, 1 Jun 2026 11:16:36 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp05[null]) by mapi (Zmail) with MAPI id mid32;
 Mon, 1 Jun 2026 11:16:37 +0800 (CST)
X-Zmail-TransId: 2afc6a1cf99574e-03679
X-Mailer: Zmail v1.0
Message-ID: <20260601111637608gw-0SX_SUzpTzaHRaZftH@zte.com.cn>
Date: Mon, 1 Jun 2026 11:16:37 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIXSBody9pbnRjOiBGaXggS1ZNIFZNIHN0YXJ0IGZhaWx1cmUgd2hlbiBBSUEgaXMgY29uZmlndXJlZCBhcyBhcGxpYy1pbXNpYw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6513GacE027226
X-TLS: YES
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 01 Jun 2026 11:16:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1CF99C.000/4gTJz065H4z5B13X
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Since commits 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
and 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC"), when KVM
acceleration is used and AIA is configured as aplic-imsic, the APLIC and
IMSIC devices are not emulated (they are handled in-kernel). In such
cases, the realize functions do not allocate memory for their internal
register state, leaving the corresponding pointers NULL.

The reset functions riscv_aplic_reset_enter() and riscv_imsic_reset_enter()
subsequently attempt to access these NULL pointers (e.g., via memset),
causing a segmentation fault and VM start failure.

Fix this by guarding the reset operations with condition checks that
skip the emulated‑specific logic when the in‑kernel mode is active:
- For APLIC, check riscv_use_emulated_aplic(aplic->msimode).
- For IMSIC, check !kvm_irqchip_in_kernel().

Fixes: 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
Fixes: 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC")

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 hw/intc/riscv_aplic.c | 52 ++++++++++++++++++++++---------------------
 hw/intc/riscv_imsic.c | 16 +++++++------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index c2c67c29e6..0f61b67fc5 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -910,35 +910,37 @@ static void riscv_aplic_reset_enter(Object *obj, ResetType type)
     RISCVAPLICState *aplic = RISCV_APLIC(obj);
     int i;

-    aplic->domaincfg = 0;
-    memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
-    memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
-    if (!aplic->msimode) {
-        for (i = 0; i < aplic->num_irqs; i++) {
-            aplic->target[i] = 1;
+    if (riscv_use_emulated_aplic(aplic->msimode)) {
+        aplic->domaincfg = 0;
+        memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
+        memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
+        if (!aplic->msimode) {
+            for (i = 0; i < aplic->num_irqs; i++) {
+                aplic->target[i] = 1;
+            }
         }
-    }

-    for (i = 0; i < aplic->num_irqs ; i++) {
-        riscv_aplic_set_enabled_raw(aplic, i, false);
-    }
-
-    /* Need to unlock [ms]msicfgaddrh.L */
-    aplic->mmsicfgaddr = 0;
-    aplic->mmsicfgaddrH = 0;
-    aplic->smsicfgaddr = 0;
-    aplic->smsicfgaddrH = 0;
-
-    if (!aplic->msimode) {
-        /* Reset IDC registers only in non-MSI mode */
-        for (i = 0; i < aplic->num_harts; i++) {
-            aplic->idelivery[i] = 0;
-            aplic->iforce[i] = 0;
-            aplic->ithreshold[i] = 0;
+        for (i = 0; i < aplic->num_irqs ; i++) {
+            riscv_aplic_set_enabled_raw(aplic, i, false);
         }

-        for (i = 0; i < aplic->num_harts; i++) {
-            qemu_irq_lower(aplic->external_irqs[i]);
+        /* Need to unlock [ms]msicfgaddrh.L */
+        aplic->mmsicfgaddr = 0;
+        aplic->mmsicfgaddrH = 0;
+        aplic->smsicfgaddr = 0;
+        aplic->smsicfgaddrH = 0;
+
+        if (!aplic->msimode) {
+            /* Reset IDC registers only in non-MSI mode */
+            for (i = 0; i < aplic->num_harts; i++) {
+                aplic->idelivery[i] = 0;
+                aplic->iforce[i] = 0;
+                aplic->ithreshold[i] = 0;
+            }
+
+            for (i = 0; i < aplic->num_harts; i++) {
+                qemu_irq_lower(aplic->external_irqs[i]);
+            }
         }
     }
 }
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index ac59496c22..6dbbc152a2 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -347,15 +347,17 @@ static void riscv_imsic_reset_enter(Object *obj, ResetType type)
     RISCVIMSICState *imsic = RISCV_IMSIC(obj);
     int i;

-    memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
-    memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
+    if (!kvm_irqchip_in_kernel()) {
+        memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
+        memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);

-    for (i = 0; i < imsic->num_eistate; i++) {
-        imsic->eistate[i] &= ~IMSIC_EISTATE_ENABLED;
-    }
+        for (i = 0; i < imsic->num_eistate; i++) {
+            imsic->eistate[i] &= ~IMSIC_EISTATE_ENABLED;
+        }

-    for (i = 0; i < imsic->num_pages; i++) {
-        qemu_irq_lower(imsic->external_irqs[i]);
+        for (i = 0; i < imsic->num_pages; i++) {
+            qemu_irq_lower(imsic->external_irqs[i]);
+        }
     }
 }

-- 
2.27.0

