Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7206606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJ0H-0007Eh-Gr; Thu, 29 Oct 2026 01:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzl-00073H-SO; Thu, 29 Oct 2026 01:48:14 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzh-0000eV-Tq; Thu, 29 Oct 2026 01:48:13 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYDR174mz8Xrkn;
 Thu, 29 Oct 2026 13:48:07 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 69T5lxsu079346;
 Thu, 29 Oct 2026 13:47:59 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 29 Oct 2026 13:48:00 +0800
X-Zmail-TransId: 3e816ae2de10027-e63e9
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Qingye Zhao <zhao.qingye@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 14/14] hw/riscv/riscv-iommu-accel: Add accel property
 for iommu device
Date: Thu, 29 Oct 2026 13:47:51 +0800
Message-ID: <20261029054751.563493-15-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
References: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69T5lxsu079346
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 13:48:07 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2DE17.000/4jFYDR174mz8Xrkn
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wu Fei <wu.fei9@sanechips.com.cn>

Add an "accel" property to enable the RISC-V IOMMU accelerator
mode, following the ARM SMMUv3 accel device.

Migration is not supported in accel mode, as the host-side vIOMMU
and HWPT state cannot be migrated; a migration blocker is
registered.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/riscv-iommu.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h |  1 +
 2 files changed, 58 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 7fa6490888..4926a361f5 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -23,6 +23,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
@@ -2731,12 +2732,63 @@ static void riscv_iommu_instance_finalize(Object *obj)
     qemu_mutex_destroy(&s->iot_lock);
 }
 
+static bool riscv_iommu_validate_property(RISCVIOMMUState *s, Error **errp)
+{
+#ifndef CONFIG_RISCV_IOMMU_ACCEL
+    if (s->accel) {
+        error_setg(errp, "accel=on support not compiled in");
+        return false;
+    }
+#endif
+
+    if (!s->accel) {
+        return true;
+    }
+
+    if (!s->enable_s_stage) {
+        error_setg(errp,
+                   "Only stage-1 is supported for RISC-V IOMMU with accel=on");
+        return false;
+    }
+
+    return true;
+}
+
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    if (!riscv_iommu_validate_property(s, errp)) {
+        return;
+    }
+
     if (s->accel) {
         riscv_iommu_accel_init(s);
+        /*
+        * With accel=on, MSI remapping is done by the host IOMMU. Disable
+        * the emulated MSI capability so the guest's MSI message address
+        * is a plain GPA translated on the host side; the guest then sees
+        * no MSI capability bits and uses the base device context format.
+        */
+        s->enable_msi = false;
+        /* G-stage is managed by the host (VFIO) in accel mode */
+        s->enable_g_stage = false;
+        /*
+         * No ATS.INVAL path exists for the vIOMMU in accel mode now,
+         * vfio-pci devices are not notifiers of the emulated IOMMU and
+         * guest ATS.INVAL commands are not forwarded to the host, so hide
+         * ATS/PRI capabilities.
+         */
+        s->enable_ats = false;
+        /*
+         * Per-PASID contexts and PDT inval for vIOMMU are unimplemented,
+         * hide the process-directory capabilities.
+         */
+        s->cap &= ~(RISCV_IOMMU_CAP_PD8 | RISCV_IOMMU_CAP_PD17 |
+                    RISCV_IOMMU_CAP_PD20);
+        error_setg(&s->migration_blocker, "Migration not supported with "
+                   "RISC-V IOMMU accel=on");
+        migrate_add_blocker(&s->migration_blocker, errp);
     }
 
     /* Report QEMU target physical address space limits. */
@@ -2860,6 +2912,10 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    if (s->migration_blocker) {
+        migrate_del_blocker(&s->migration_blocker);
+    }
+
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
         g_hash_table_unref(s->hpm_event_ctr_map);
         timer_free(s->hpm_timer);
@@ -2920,6 +2976,7 @@ static const Property riscv_iommu_properties[] = {
         TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_UINT8("hpm-counters", RISCVIOMMUState, hpm_cntrs,
                       RISCV_IOMMU_IOCOUNT_NUM),
+    DEFINE_PROP_BOOL("accel", RISCVIOMMUState, accel, FALSE),
 };
 
 static void riscv_iommu_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index ddd339aed1..cffff83411 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -115,6 +115,7 @@ struct RISCVIOMMUState {
     /* nested iommu support */
     bool accel;
     struct RISCVIOMMUAccelState *accel_state;
+    Error *migration_blocker;
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
-- 
2.53.0


