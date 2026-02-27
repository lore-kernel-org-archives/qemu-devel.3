Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8261BFD5335
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvun7-0003kH-VQ; Fri, 27 Feb 2026 05:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vvun6-0003jx-9D; Fri, 27 Feb 2026 05:09:48 -0500
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vvun2-0006ny-St; Fri, 27 Feb 2026 05:09:47 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4fMkZm0mkwz51Sl8;
 Fri, 27 Feb 2026 18:09:36 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
 by mse-fl2.zte.com.cn with SMTP id 61RA9YO1093381;
 Fri, 27 Feb 2026 18:09:35 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Fri, 27 Feb 2026 18:09:37 +0800 (CST)
X-Zmail-TransId: 2afa69a16d6104f-6baf7
X-Mailer: Zmail v1.0
Message-ID: <20260227180937387Xf5-8a9sUNkRZnzDB99ay@zte.com.cn>
In-Reply-To: <20260227180104794YvW9Rb2I_kAGzUruZL11Q@zte.com.cn>
References: 20260227180104794YvW9Rb2I_kAGzUruZL11Q@zte.com.cn
Date: Fri, 27 Feb 2026 18:09:37 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDMvM10gaHcvaW50Yy9pbXNpYzogQWRkIGluLWtlcm5lbCBpbXNpYyBzYXZlIGFuZCByZXN0b3JlCgogZnVuY3Rpb24=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 61RA9YO1093381
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 27 Feb 2026 18:09:36 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69A16D60.000/4fMkZm0mkwz51Sl8
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add save and store funtction if kvm_irqchip_in_kernel() return
true, it is to get and set IMSIC irqchip state from KVM kernel.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 hw/intc/riscv_imsic.c         | 171 +++++++++++++++++++++++++++++++---
 include/hw/intc/riscv_imsic.h |   2 +
 2 files changed, 159 insertions(+), 14 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 7c9a012033..c0b07de0fc 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -34,6 +34,7 @@
 #include "system/system.h"
 #include "system/kvm.h"
 #include "migration/vmstate.h"
+#include "kvm/kvm_riscv.h"

 #define IMSIC_MMIO_PAGE_LE             0x00
 #define IMSIC_MMIO_PAGE_BE             0x04
@@ -363,11 +364,12 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
         qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);

         imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
-        imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
-        imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
         imsic->eistate = g_new0(uint32_t, imsic->num_eistate);
     }

+    imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
+    imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
+
     memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
                           imsic, TYPE_RISCV_IMSIC,
                           IMSIC_MMIO_SIZE(imsic->num_pages));
@@ -398,23 +400,17 @@ static const Property riscv_imsic_properties[] = {
     DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
 };

-static bool riscv_imsic_state_needed(void *opaque)
+static bool riscv_imsic_emul_state_needed(void *opaque)
 {
     return !kvm_irqchip_in_kernel();
 }

-static const VMStateDescription vmstate_riscv_imsic = {
-    .name = "riscv_imsic",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .needed = riscv_imsic_state_needed,
+static const VMStateDescription vmstate_riscv_imsic_emul = {
+    .name = "riscv_imsic_emul",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = riscv_imsic_emul_state_needed,
     .fields = (const VMStateField[]) {
-            VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
-                                  num_pages, 0,
-                                  vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
-                                  num_pages, 0,
-                                  vmstate_info_uint32, uint32_t),
             VMSTATE_VARRAY_UINT32(eistate, RISCVIMSICState,
                                   num_eistate, 0,
                                   vmstate_info_uint32, uint32_t),
@@ -422,6 +418,153 @@ static const VMStateDescription vmstate_riscv_imsic = {
         }
 };

+static bool riscv_imsic_in_kernel_state_needed(void *opaque)
+{
+    return kvm_irqchip_in_kernel();
+}
+
+static int riscv_imsic_in_kernel_pre_save(void *opaque)
+{
+    RISCVIMSICState *imsic = opaque;
+    uint64_t attr;
+
+    if (kvm_irqchip_in_kernel()) {
+        for (uint32_t i = 0; i < BITS_TO_LONGS(imsic->num_irqs); i++) {
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIE0 + i * 2);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eie + i * 2 , false);
+
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIP0 + i * 2);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eip + i * 2, false);
+#ifdef CONFIG_32BIT
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIE0 + i * 2 + 1);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eie + i * 2 + 1, false);
+
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIP0 + i * 2 + 1);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eip + i * 2 + 1, false);
+#endif
+        }
+    }
+
+    return 0;
+}
+
+static int riscv_imsic_in_kernel_post_load(void *opaque, int version_id)
+{
+    RISCVIMSICState *imsic = opaque;
+    uint64_t attr;
+
+    if (kvm_irqchip_in_kernel()) {
+        for (uint32_t i = 0; i < BITS_TO_LONGS(imsic->num_irqs); i++) {
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIE0 + i * 2);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eie + i * 2, true);
+
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIP0 + i * 2);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eip + i * 2, true);
+#ifdef CONFIG_32BIT
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIE0 + i * 2 + 1);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eie + i * 2 + 1, true);
+
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIP0 + i * 2 + 1);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eip + i * 2 + 1, true);
+#endif
+        }
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_riscv_imsic_in_kernel = {
+    .name = "riscv_imsic_in_kernel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = riscv_imsic_in_kernel_state_needed,
+    .pre_save = riscv_imsic_in_kernel_pre_save,
+    .post_load = riscv_imsic_in_kernel_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(eie, RISCVIMSICState, 64),
+        VMSTATE_UINT64_ARRAY(eip, RISCVIMSICState, 64),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int riscv_imsic_pre_save(void *opaque)
+{
+    RISCVIMSICState *imsic = opaque;
+    uint64_t attr;
+
+    if (kvm_irqchip_in_kernel()) {
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EIDELIVERY);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eidelivery, false);
+
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EITHRESHOLD);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eithreshold, false);
+   }
+
+    return 0;
+}
+
+static int riscv_imsic_post_load(void *opaque, int version_id)
+{
+    RISCVIMSICState *imsic = opaque;
+    uint64_t attr;
+
+    if (kvm_irqchip_in_kernel()) {
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EIDELIVERY);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eidelivery, true);
+
+        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                              ISELECT_IMSIC_EITHRESHOLD);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                 imsic->eithreshold, true);
+   }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_riscv_imsic = {
+    .name = "riscv_imsic",
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .pre_save = riscv_imsic_pre_save,
+    .post_load = riscv_imsic_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
+                              num_pages, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
+                              num_pages, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_riscv_imsic_emul,
+        &vmstate_riscv_imsic_in_kernel,
+        NULL
+    }
+};
+
 static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index fae999731d..af7a7ba4f1 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -54,6 +54,8 @@ struct RISCVIMSICState {
     uint32_t *eidelivery;
     uint32_t *eithreshold;
     uint32_t *eistate;
+    uint64_t eip[64];
+    uint64_t eie[64];

     /* config */
     bool mmode;
-- 
2.27.0

