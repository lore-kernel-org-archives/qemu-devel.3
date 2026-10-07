Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39035CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOcd-0004Tp-BM; Wed, 07 Oct 2026 06:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcH-00043C-1d; Wed, 07 Oct 2026 06:11:18 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcF-0004Og-Gg; Wed, 07 Oct 2026 06:11:16 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 194C61A00A3;
 Wed,  7 Oct 2026 12:11:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D920A1A00A0;
 Wed,  7 Oct 2026 12:11:13 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E3C88180023B;
 Wed,  7 Oct 2026 18:11:11 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 02/11] hw/arm: Rename FSL_IMX8MP_NUM_CPUS to
 FSL_IMX8MP_NUM_A53
Date: Wed,  7 Oct 2026 15:40:56 +0530
Message-Id: <20261007101105.3917771-3-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
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

This is a mechanical rename with no functional change.
The existing CPU count and cpu array describe only the
Cortex-A53 cores.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 hw/arm/fsl-imx8mp.c         | 4 ++--
 hw/arm/imx8mp-evk.c         | 2 +-
 include/hw/arm/fsl-imx8mp.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index bcd91739d9..f599e5e0a2 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -266,9 +266,9 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
-    if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
+    if (ms->smp.cpus > FSL_IMX8MP_NUM_A53) {
         error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
-                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp.cpus);
+                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_A53, ms->smp.cpus);
         return;
     }
 
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 3f376f86d9..f19d80b796 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -148,7 +148,7 @@ static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
     mc->default_cpus = 4;
-    mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
+    mc->max_cpus = FSL_IMX8MP_NUM_A53;
     mc->default_ram_id = "imx8mp-evk.ram";
     mc->default_ram_size = 6 * GiB;
     mc->get_default_cpu_type = imx8mp_evk_get_default_cpu_type;
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 2be3c51af5..6f9bd8d2ce 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -39,7 +39,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CANS         = 2,
-    FSL_IMX8MP_NUM_CPUS         = 4,
+    FSL_IMX8MP_NUM_A53          = 4,
     FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
     FSL_IMX8MP_NUM_GPTS         = 6,
@@ -54,7 +54,7 @@ enum FslImx8mpConfiguration {
 struct FslImx8mpState {
     SysBusDevice   parent_obj;
 
-    ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
+    ARMCPU             cpu[FSL_IMX8MP_NUM_A53];
     GICv3State         gic;
     IMXGPTState        gpt[FSL_IMX8MP_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX8MP_NUM_GPIOS];
-- 
2.34.1


