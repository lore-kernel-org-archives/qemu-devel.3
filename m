Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAF8FED2C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wj5-0006DO-JG; Wed, 11 Mar 2026 23:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1w0Wj3-0006Cx-O7; Wed, 11 Mar 2026 23:28:41 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1w0Wj0-0004DI-Sg; Wed, 11 Mar 2026 23:28:41 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fWY426h20z8Xs6q;
 Thu, 12 Mar 2026 11:28:34 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
 by mse-fl1.zte.com.cn with SMTP id 62C3STxr026977;
 Thu, 12 Mar 2026 11:28:29 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 12 Mar 2026 11:28:30 +0800 (CST)
X-Zmail-TransId: 2afb69b232de218-5d116
X-Mailer: Zmail v1.0
Message-ID: <20260312112830420e-E8vebes6HO8SlHNs5mY@zte.com.cn>
In-Reply-To: <20260312112336983jY95IEDTtzVrPbyk-taP3@zte.com.cn>
References: 20260312112336983jY95IEDTtzVrPbyk-taP3@zte.com.cn
Date: Thu, 12 Mar 2026 11:28:30 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <peterx@redhat.com>, <farosas@suse.de>, <chao.liu.zevorn@gmail.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIDIvM10gaHcvaW50Yy9yaXNjdl9hcGxpYzogQWRkIGluLWtlcm5lbCBhcGxpYyBzYXZlIGFuZCByZXN0b3JlIGZ1bmN0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 62C3STxr026977
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Mar 2026 11:28:34 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69B232E2.001/4fWY426h20z8Xs6q
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Add save and restore function if riscv_use_emulated_aplic return
false, it is to get and set APLIC irqchip state from KVM kernel.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 hw/intc/riscv_aplic.c         | 200 ++++++++++++++++++++++++++++------
 include/hw/intc/riscv_aplic.h |   4 +
 2 files changed, 173 insertions(+), 31 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8f70043111..88b79e9ab2 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -922,14 +922,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         }

         aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
-        aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
-        aplic->target = g_new0(uint32_t, aplic->num_irqs);
-        if (!aplic->msimode) {
-            for (i = 0; i < aplic->num_irqs; i++) {
-                aplic->target[i] = 1;
-            }
-        }
         aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
         aplic->iforce = g_new0(uint32_t, aplic->num_harts);
         aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
@@ -941,6 +934,19 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         if (kvm_enabled()) {
             aplic->kvm_splitmode = true;
         }
+    } else {
+        aplic->nr_words = BITS_TO_U32S(aplic->num_irqs);
+        aplic->setip = g_new0(uint32_t, aplic->nr_words);
+        aplic->clrip = g_new0(uint32_t, aplic->nr_words);
+        aplic->setie = g_new0(uint32_t, aplic->nr_words);
+    }
+
+    aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
+    aplic->target = g_new0(uint32_t, aplic->num_irqs);
+    if (!aplic->msimode) {
+        for (i = 0; i < aplic->num_irqs; i++) {
+            aplic->target[i] = 1;
+        }
     }

     /*
@@ -968,47 +974,179 @@ static const Property riscv_aplic_properties[] = {
     DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
 };

-static bool riscv_aplic_state_needed(void *opaque)
+static bool riscv_aplic_emul_state_needed(void *opaque)
 {
     RISCVAPLICState *aplic = opaque;

     return riscv_use_emulated_aplic(aplic->msimode);
 }

+static const VMStateDescription vmstate_riscv_aplic_emul = {
+    .name = "riscv_aplic_emul",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = riscv_aplic_emul_state_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
+                              num_irqs, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
+        VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
+        VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
+        VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
+        VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
+        VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
+        VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
+                              num_harts, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
+                              num_harts, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
+                              num_harts, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool riscv_aplic_in_kernel_state_needed(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    return !riscv_use_emulated_aplic(aplic->msimode);
+}
+
+static int riscv_aplic_in_kernel_pre_save(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    if (!riscv_use_emulated_aplic(aplic->msimode)) {
+        for (uint32_t i = 0; i < aplic->nr_words; i++) {
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_SETIP_BASE + i * 4,
+                                     aplic->setip + i, false);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_CLRIP_BASE + i * 4,
+                                     aplic->clrip + i, false);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_SETIE_BASE + i * 4,
+                                     aplic->setie + i, false);
+        }
+    }
+
+    return 0;
+}
+
+static int riscv_aplic_in_kernel_post_load(void *opaque, int version_id)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    if (!riscv_use_emulated_aplic(aplic->msimode)) {
+        for (uint32_t i = 0; i < aplic->nr_words; i++) {
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_SETIP_BASE + i * 4,
+                                     aplic->setip + i, true);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_CLRIP_BASE + i * 4,
+                                     aplic->clrip + i, true);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_SETIE_BASE + i * 4,
+                                     aplic->setie + i, true);
+        }
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_riscv_aplic_in_kernel = {
+    .name = "riscv_aplic_in_kernel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = riscv_aplic_in_kernel_state_needed,
+    .pre_save = riscv_aplic_in_kernel_pre_save,
+    .post_load = riscv_aplic_in_kernel_post_load,
+    .fields = (const VMStateField[]) {
+            VMSTATE_VARRAY_UINT32(setip, RISCVAPLICState,
+                                  nr_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(clrip, RISCVAPLICState,
+                                  nr_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(setie, RISCVAPLICState,
+                                  nr_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_END_OF_LIST()
+    }
+};
+
+static int riscv_aplic_pre_save(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    if (!riscv_use_emulated_aplic(aplic->msimode)) {
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
+                                 &aplic->domaincfg, false);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
+                                 &aplic->genmsi, false);
+
+        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
+                                     aplic->sourcecfg + i, false);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_TARGET_BASE + (i - 1) * 4,
+                                     aplic->target + i, false);
+        }
+    }
+
+    return 0;
+}
+
+static int riscv_aplic_post_load(void *opaque, int version_id)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    if (!riscv_use_emulated_aplic(aplic->msimode)) {
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
+                                 &aplic->domaincfg, true);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
+                                 &aplic->genmsi, true);
+
+        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
+                                     aplic->sourcecfg + i, true);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_TARGET_BASE + (i - 1) * 4,
+                                     aplic->target + i, true);
+        }
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
-    .version_id = 3,
-    .minimum_version_id = 3,
-    .needed = riscv_aplic_state_needed,
+    .version_id = 4,
+    .minimum_version_id = 4,
+    .pre_save = riscv_aplic_pre_save,
+    .post_load = riscv_aplic_post_load,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
-            VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
-            VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
-            VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
-            VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
             VMSTATE_UINT32(genmsi, RISCVAPLICState),
-            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
-            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
-            VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
-                                  num_irqs, 0,
-                                  vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
+            VMSTATE_VARRAY_UINT32(sourcecfg , RISCVAPLICState,
                                   num_irqs, 0,
                                   vmstate_info_uint32, uint32_t),
             VMSTATE_VARRAY_UINT32(target, RISCVAPLICState,
                                   num_irqs, 0,
                                   vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
-                                  num_harts, 0,
-                                  vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
-                                  num_harts, 0,
-                                  vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
-                                  num_harts, 0,
-                                  vmstate_info_uint32, uint32_t),
             VMSTATE_END_OF_LIST()
-        }
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_riscv_aplic_emul,
+        &vmstate_riscv_aplic_in_kernel,
+        NULL
+    }
 };

 static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index c7a4d4ad01..1976bea68c 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -53,6 +53,9 @@ struct RISCVAPLICState {
     uint32_t *idelivery;
     uint32_t *iforce;
     uint32_t *ithreshold;
+    uint32_t *setip;
+    uint32_t *clrip;
+    uint32_t *setie;

     /* topology */
 #define QEMU_APLIC_MAX_CHILDREN        16
@@ -66,6 +69,7 @@ struct RISCVAPLICState {
     uint32_t num_harts;
     uint32_t iprio_mask;
     uint32_t num_irqs;
+    uint32_t nr_words;
     bool msimode;
     bool mmode;

-- 
2.27.0

