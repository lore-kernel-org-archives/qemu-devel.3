Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C4DCD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIhG-0005X7-JN; Tue, 02 Jun 2026 02:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wUIhE-0005WI-9V; Tue, 02 Jun 2026 02:33:52 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wUIhB-0004Xc-BC; Tue, 02 Jun 2026 02:33:52 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4gV1Hp0mGlz55y1s;
 Tue, 02 Jun 2026 14:33:42 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
 by mse-fl1.zte.com.cn with SMTP id 6526XXEK075103;
 Tue, 2 Jun 2026 14:33:33 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null]) by mapi (Zmail) with MAPI id mid32;
 Tue, 2 Jun 2026 14:33:35 +0800 (CST)
X-Zmail-TransId: 2afb6a1e793fbfd-903a2
X-Mailer: Zmail v1.0
Message-ID: <20260602143335139vSrlCbb4GSWlGSnOMETFs@zte.com.cn>
In-Reply-To: <20260602142709086IsQxEt0LYI9ygtpFnj-XN@zte.com.cn>
References: 20260602142709086IsQxEt0LYI9ygtpFnj-XN@zte.com.cn
Date: Tue, 2 Jun 2026 14:33:35 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>, <peterx@redhat.com>, <farosas@suse.de>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIFJFU0VORCAzLzNdIGh3L2ludGMvaW1zaWM6IEFkZCBpbi1rZXJuZWwgaW1zaWMgc2F2ZSBhbmQgcmVzdG9yZSBmdW5jdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6526XXEK075103
X-TLS: YES
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 02 Jun 2026 14:33:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1E7946.000/4gV1Hp0mGlz55y1s
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Add save and restore funtction if kvm_irqchip_in_kernel() return
true, it is to get and set IMSIC irqchip state from KVM kernel.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 hw/intc/riscv_imsic.c         | 171 +++++++++++++++++++++++++++++++---
 include/hw/intc/riscv_imsic.h |   3 +
 include/qemu/bitops.h         |   1 +
 migration/vmstate-types.c     |   1 -
 4 files changed, 161 insertions(+), 15 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 6dbbc152a2..bfce181af9 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -34,6 +34,7 @@
 #include "system/system.h"
 #include "system/kvm.h"
 #include "migration/vmstate.h"
+#include "kvm/kvm_riscv.h"

 #define IMSIC_MMIO_PAGE_LE             0x00
 #define IMSIC_MMIO_PAGE_BE             0x04
@@ -382,11 +383,16 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
         qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);

         imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
-        imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
-        imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
         imsic->eistate = g_new0(uint32_t, imsic->num_eistate);
+    } else {
+        imsic->nr_eix = 2 * BITS_TO_U64S(imsic->num_irqs);
+        imsic->eie = g_new0(uint32_t, imsic->nr_eix);
+        imsic->eip = g_new0(uint32_t, imsic->nr_eix);
     }

+    imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
+    imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
+
     memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
                           imsic, TYPE_RISCV_IMSIC,
                           IMSIC_MMIO_SIZE(imsic->num_pages));
@@ -417,23 +423,17 @@ static const Property riscv_imsic_properties[] = {
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
@@ -441,6 +441,149 @@ static const VMStateDescription vmstate_riscv_imsic = {
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
+    RISCVCPU *rcpu = RISCV_CPU(cpu_by_arch_id(imsic->hartid));
+    bool is_32bit = riscv_cpu_is_32bit(rcpu);
+    uint32_t inc = 2;
+    uint64_t attr;
+
+    if (is_32bit) {
+        inc = 1;
+    }
+
+    if (kvm_irqchip_in_kernel()) {
+        for (uint32_t i = 0; i < imsic->nr_eix; i += inc) {
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIE0 + i);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eie + i, false);
+
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIP0 + i);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eip + i, false);
+        }
+    }
+
+    return 0;
+}
+
+static int riscv_imsic_in_kernel_post_load(void *opaque, int version_id)
+{
+    RISCVIMSICState *imsic = opaque;
+    RISCVCPU *rcpu = RISCV_CPU(cpu_by_arch_id(imsic->hartid));
+    bool is_32bit = riscv_cpu_is_32bit(rcpu);
+    uint32_t inc = 2;
+    uint64_t attr;
+
+    if (is_32bit) {
+        inc = 1;
+    }
+
+    if (kvm_irqchip_in_kernel()) {
+        for (uint32_t i = 0; i < imsic->nr_eix; i += inc) {
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIE0 + i);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eie + i, true);
+
+            attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
+                                                  ISELECT_IMSIC_EIP0 + i);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
+                                     imsic->eip + i, true);
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
+        VMSTATE_VARRAY_UINT32(eie, RISCVIMSICState,
+                              nr_eix, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(eip, RISCVIMSICState,
+                              nr_eix, 0,
+                              vmstate_info_uint32, uint32_t),
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
index fae999731d..2206d82e0c 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -54,12 +54,15 @@ struct RISCVIMSICState {
     uint32_t *eidelivery;
     uint32_t *eithreshold;
     uint32_t *eistate;
+    uint32_t *eip;
+    uint32_t *eie;

     /* config */
     bool mmode;
     uint32_t hartid;
     uint32_t num_pages;
     uint32_t num_irqs;
+    uint32_t nr_eix;
 };

 DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index c7b838a628..a7f86f2ee0 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -20,6 +20,7 @@
 #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #define BITS_TO_U32S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint32_t))
+#define BITS_TO_U64S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint64_t))

 #define BIT(nr)                 (1UL << (nr))
 #define BIT_ULL(nr)             (1ULL << (nr))
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index ae465c5c2c..7e6f37f8c4 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -597,7 +597,6 @@ const VMStateInfo vmstate_info_tmp = {
  * is an array of 'unsigned long', which may be either 32 or 64 bits.
  */
 /* This is the number of 64 bit words sent over the wire */
-#define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
 static bool load_bitmap(QEMUFile *f, void *pv, size_t size,
                         const VMStateField *field, Error **errp)
 {
-- 
2.27.0

