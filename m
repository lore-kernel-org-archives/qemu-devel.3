Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF26C982E1
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8G8f-0006Wx-6v; Sun, 20 Sep 2026 07:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x8G8c-0006Vl-OR; Sun, 20 Sep 2026 07:55:18 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x8G8a-0001bh-S7; Sun, 20 Sep 2026 07:55:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 663701A002E;
 Sun, 20 Sep 2026 13:55:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E9131A0018;
 Sun, 20 Sep 2026 13:55:15 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 402BA18000BA;
 Sun, 20 Sep 2026 19:55:13 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv3 07/10] hw/arm: Rename FSL_IMX8MP_NUM_CPUS to
 FSL_IMX8MP_NUM_A53
Date: Sun, 20 Sep 2026 17:24:55 +0530
Message-Id: <20260920115458.481605-8-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Cortex-M7 is not an A53 and is not part of the cpu[] array.
Rename the constant to make the A53-only scope explicit, introduce
FSL_IMX8MP_NUM_M7 for the single Cortex-M7 core, and remove the
redundant local IMX8MP_NUM_A53 define from fsl-imx8mp.c

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 hw/arm/fsl-imx8mp.c         | 19 +++++++++----------
 hw/arm/imx8mp-evk.c         |  5 +++--
 include/hw/arm/fsl-imx8mp.h |  5 +++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index cea8be7b71..e7dafa2403 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -25,7 +25,6 @@
 #include "qobject/qlist.h"
 #include "target/arm/arm-powerctl.h"
 
-#define IMX8MP_NUM_A53 4
 
 static const struct {
     hwaddr addr;
@@ -289,15 +288,15 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
-    for (i = 0; i < IMX8MP_NUM_A53; i++) {
+    for (i = 0; i < FSL_IMX8MP_NUM_A53; i++) {
         g_autofree char *name = g_strdup_printf("cpu%d", i);
         object_initialize_child(OBJECT(dev), name, &s->cpu[i], cpu_type);
     }
 
     /* CPUs */
-    for (i = 0; i < IMX8MP_NUM_A53; i++) {
+    for (i = 0; i < FSL_IMX8MP_NUM_A53; i++) {
         /* On uniprocessor, the CBAR is set to 0 */
-        if (IMX8MP_NUM_A53 > 1 &&
+        if (FSL_IMX8MP_NUM_A53 > 1 &&
                 object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) {
             object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                     fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr,
@@ -340,11 +339,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         QList *redist_region_count;
         bool pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
 
-        qdev_prop_set_uint32(gicdev, "num-cpu", IMX8MP_NUM_A53);
+        qdev_prop_set_uint32(gicdev, "num-cpu", FSL_IMX8MP_NUM_A53);
         qdev_prop_set_uint32(gicdev, "num-irq",
                              FSL_IMX8MP_NUM_IRQS + GIC_INTERNAL);
         redist_region_count = qlist_new();
-        qlist_append_int(redist_region_count, IMX8MP_NUM_A53);
+        qlist_append_int(redist_region_count, FSL_IMX8MP_NUM_A53);
         qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
         object_property_set_link(OBJECT(&s->gic), "sysmem",
                                  OBJECT(get_system_memory()), &error_fatal);
@@ -359,7 +358,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
          * maintenance interrupt signal to the appropriate GIC PPI inputs, and
          * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
          */
-        for (i = 0; i < IMX8MP_NUM_A53; i++) {
+        for (i = 0; i < FSL_IMX8MP_NUM_A53; i++) {
             DeviceState *cpudev = DEVICE(&s->cpu[i]);
             int intidbase = FSL_IMX8MP_NUM_IRQS + i * GIC_INTERNAL;
             qemu_irq irq;
@@ -389,11 +388,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
             sysbus_connect_irq(gicsbd, i,
                                qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-            sysbus_connect_irq(gicsbd, i + IMX8MP_NUM_A53,
+            sysbus_connect_irq(gicsbd, i + FSL_IMX8MP_NUM_A53,
                                qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-            sysbus_connect_irq(gicsbd, i + 2 * IMX8MP_NUM_A53,
+            sysbus_connect_irq(gicsbd, i + 2 * FSL_IMX8MP_NUM_A53,
                                qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-            sysbus_connect_irq(gicsbd, i + 3 * IMX8MP_NUM_A53,
+            sysbus_connect_irq(gicsbd, i + 3 * FSL_IMX8MP_NUM_A53,
                                qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
 
             if (kvm_enabled()) {
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 3f376f86d9..432a146efd 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -147,8 +147,9 @@ static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
-    mc->default_cpus = 4;
-    mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
+    mc->default_cpus = FSL_IMX8MP_NUM_A53 + FSL_IMX8MP_NUM_M7;
+    mc->min_cpus = FSL_IMX8MP_NUM_A53 + FSL_IMX8MP_NUM_M7;
+    mc->max_cpus = FSL_IMX8MP_NUM_A53 + FSL_IMX8MP_NUM_M7;
     mc->default_ram_id = "imx8mp-evk.ram";
     mc->default_ram_size = 6 * GiB;
     mc->get_default_cpu_type = imx8mp_evk_get_default_cpu_type;
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 317e6a4576..e8d84f82b5 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -46,7 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CANS         = 2,
-    FSL_IMX8MP_NUM_CPUS         = 4,
+    FSL_IMX8MP_NUM_A53          = 4,
+    FSL_IMX8MP_NUM_M7           = 1,
     FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
     FSL_IMX8MP_NUM_GPTS         = 6,
@@ -67,7 +68,7 @@ typedef struct IMX8MPMUPair {
 struct FslImx8mpState {
     SysBusDevice   parent_obj;
 
-    ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
+    ARMCPU             cpu[FSL_IMX8MP_NUM_A53];
     ARMv7MState        cm7;
     bool               enable_cm7;
     uint32_t           cm7_vector_base;
-- 
2.34.1


