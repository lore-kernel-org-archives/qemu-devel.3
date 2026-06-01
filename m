Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E081CCD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU19N-0006dl-2l; Mon, 01 Jun 2026 07:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19K-0006Mk-3J; Mon, 01 Jun 2026 07:49:42 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19I-00057m-0p; Mon, 01 Jun 2026 07:49:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW29qNAj1epnbTjxLpq7wwMyyONhZdfzQ9pi4jgRdlnDEGjWfSR2fA8svt0GkwL8Le/d1ry4lW8aHh+xIedhJtPs7vmURQ46VVPguyyrxI5zFKmzvphrZWhJzGk0FEDrBeSaBvlBe/Wp7rutNsqw22Yacoms3U7leqWDsXKhtcUEK9jB+sXdZdSGR5Wuo2ZadAdr6iZeuTzJzQr23+xzBw6ZYdnCeGaeOVij0wSFk01hVGe86YOoWfv5sF3xYKSfuQFsvZw/ZV9p5MJTMZwXLstaquSa3xO0dZLh+XQVyzvipVPQkd70v+lLKAPAI3ip5Q2WIVjBFXj+XM2RrC3Dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAjVbwfBF2GlViac5sZ6doAYL7+hDnLSW/+pRtAfTZc=;
 b=lVFSAp0uI2neYQyUUaKZc8cMVUTwbwoF2gJ+7MmJ79Sa04d6WubGOPE9igOG4Vdr6uta0OcWmWpAvIG4RjO/HAtn360rHLsBl5+kJ2TGkou++KEbANKQG2UpJx8Hzk61tvOTZSy9Py2KKOwEph4lQKIBf7I+Xk1rfueJt55IRx5yWtlk4N3WoZeHWQk6VNJHb5BhzfBVz7LiWzcTNiHgVSBhkcFRoZ0dTd0cPK02LucuzzlDT41jS1XxoVj1XHGY5w0LgrRJNGNYLMxV7s4ftjCZBMvzC0RoPoFt86sBmnzMz7XADgTwCtik6ms4udaYhfeQJRR0lacCDQXazi/onA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAjVbwfBF2GlViac5sZ6doAYL7+hDnLSW/+pRtAfTZc=;
 b=Pl7XCqm4bYeY4KOwfzohvtRqjSx6Syi4sIWEiP5qFGE0Iwt3GnjswhH6nbwPYJ3V3SgOSr6u3oM1C0wsMR8SdAwU3OHPhI5sVfROGeWfjG+IEMqK+Rq6WNP3ukswE+bBkssjdjLa82lwh6ZOBD06CBaMAWU7gleHv0OCwGnW9f0O8qOMI1UkuHccL9uw80+GYd69YHQt8xsa1xYycD/MIuv0uR5sHrKaBchQhniovaw163MaRHoL//LqUcCUM7SGyj3xt0RTZkXPncAys5teEDWNY1tkMGd7yCvLCVnE502pVBg8qhgkCG43IJPYqHj2D2G8yDL1MMpR7H1whBlHVQ==
Received: from BL1PR13CA0236.namprd13.prod.outlook.com (2603:10b6:208:2bf::31)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Mon, 1 Jun 2026
 11:49:30 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::5d) by BL1PR13CA0236.outlook.office365.com
 (2603:10b6:208:2bf::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 11:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:49:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:20 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:16 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 19/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Date: Mon, 1 Jun 2026 12:42:09 +0100
Message-ID: <20260601114221.457995-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: a424abf3-d792-4a70-f54e-08debfd3d6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099006|11063799006|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: lNE6/RIOnBw+Il9m7CXuvJXFpQE00XDiwomjneScfZToca8wRj5GBQRxXxZ72PThaPJlz5rBa3oZWtK9zryrQmEyaqOViEaU3XMynGH7rY+4WLCc4whBlipjHdFHATVo4Kp+TibBqR+Svu1pHapvWVK3cieUrwpVBFBZtCCpgIAeDTKdngjtvly/Q1Y59Tua5ywak+kYK2nLt05vi6x7VmOH59PBki2XPnrikkzO6vixYseqCsQMpmAboTeA06CD1XSzQnkNN5K32HazdK8QdF0cyEpEhngO05vpjS4tvgGv/RYRW4j+OXA22O4cPOUuHmd2EVMf6cQny6b5tUmvnFLc2NzLJB4ORtoLIjWmLiwgsLuOsSf+jhfjVpgiBOiTdjhZ1HzPTnYXstTkHUJgB9MlyOAVMz05AFOfaTBah5Pa69654r3x1EJCZQgB1hO4OIxc05yz5uy4CYzS6dkc8MtBRK8MbzxC8KO0hoEiQf5bEOWLHjLpHkD3Afwp0TRmJrCEJgkOEVVPKwcVCmNABNUeFa64M4IO8JKDmthHswLrNmldDd7CTtByifJmiRnIR+dO2UpJdTD9dW+yuWtTGiM+xeqIz955p/X7fIVSW5o7nct4tO+1LMM+CibhXRoKrSoumKJVErFRZ7O9h9GfG6s7qJ4Ussck2mJ+G4BGHa86n+Ba/Ens+KPfxzInVY+C5nKDPSNRUAppGtvw5jsm1lNAu/KF8MgO8x63NspLTWo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099006)(11063799006)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w0tqA13BpW6JxmyvkVgjhxM3GbqPJJgdM4RreCLu2kiyxEoVD35v1UoTPmY8Bthb0sE1pah7ZvfPZuLJ9Cku+JLmypZEsBfbRRp7DdQ+sFu6J6463Ojhx28YqYBVOugboo44yQ5jqevSI0RYMeVgiqYtCwCY0oHGNJk7w/2Mt6bXpB+IWh+5HW4wPheebo6lzDf0nFJS6Z1p1EyHuhtjtYDw4OxMj6CBh2N+LMU7AufJL1lTzkvnOD8SnwKIUKs2a+orNE/80SZnpkxr1mwmDzlfD7pez/vp5GWn4Ekk3XPFFgTisBu2OLwLyloyKQ1WFeJHDBZnjrIRuBiiXWfdAeNUVeMM3JnAqoK0JePWFirjHn/Iq8iDsDx0ZEXRFh/uWM1WLnEN30HNFU5DoG8eIOBPwzd45rObvUf4ExI8LERph0oIhjZ/vSW71PyFiWcS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:29.6730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a424abf3-d792-4a70-f54e-08debfd3d6f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

hw/arm/tegra241-cmdqv: Use mmap'd VINTF Page 0 as VCMDQ backing

Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ Page 0 register
accesses through the mmap'd VINTF Page 0 backing once a hardware
queue has been allocated for the VCMDQ.

The two QEMU-trapped Page 0 apertures (direct at 0x10000, VINTF at
0x30000) are hardware aliases of the same underlying registers. A
subsequent patch installs the VINTF aperture as a RAM-device into
guest MMIO; in this patch both remain QEMU-trapped.

The direct VCMDQ aperture stays QEMU-trapped (rather than aliased
to the VINTF mmap) so that writes to an unallocated VCMDQ remain
well-defined. The CMDQV architecture allows software to program a
VCMDQ through the direct aperture without first allocating it to a
VINTF; aliasing to the VINTF mmap would route those writes into
unallocated logical slots where the hardware silently drops them.

A VCMDQ Page 0 access is served from one of two sources:

  - Cache-backed: no hw_queue is allocated for the VCMDQ
    (HW_QUEUE_ALLOC has not yet succeeded). Both apertures use
    QEMU's register cache.

  - HW-backed: HW_QUEUE_ALLOC has succeeded. Both apertures access
    the registers directly through the mmap'd VINTF Page 0.

tegra241_cmdqv_sync_vcmdq() copies any cached writes (CONS_INDX,
PROD_INDX, CONFIG, GERRORN) into the mmap'd page on the cache-to-HW
transition so the guest's earlier register state survives.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 73 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 54d95f4e4e..dce7089697 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -39,6 +39,47 @@ static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
     }
 }
 
+/*
+ * Return a pointer into the mmap'd VINTF page0 for the VCMDQ Page 0
+ * register at @offset0 in VCMDQ slot @index, or NULL when the VCMDQ
+ * has no hw_queue allocated or the VINTF page0 is not mmap'd.
+ */
+static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
+                                                 int index, hwaddr offset0)
+{
+    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
+        return NULL;
+    }
+    return (uint32_t *)(cmdqv->vintf_page0 +
+                        (index * CMDQV_VCMDQ_STRIDE) +
+                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
+}
+
+/*
+ * Flush cached register writes into the mmap'd VINTF page0 after a
+ * successful HW_QUEUE_ALLOC, so the guest's earlier writes survive
+ * the cache-to-hardware transition.
+ */
+static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
+{
+    uint32_t *ptr;
+
+    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONS_INDX);
+    if (!ptr) {
+        return;
+    }
+    *ptr = cmdqv->vcmdq_cons_indx[index];
+
+    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_PROD_INDX);
+    *ptr = cmdqv->vcmdq_prod_indx[index];
+
+    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
+    *ptr = cmdqv->vcmdq_config[index];
+
+    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
+    *ptr = cmdqv->vcmdq_gerrorn[index];
+}
+
 /*
  * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
  *
@@ -95,6 +136,9 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     cmdqv->vcmdq_gerror[index] &= ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
     cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
 
+    /* Pre-alloc cached writes survive the cache-to-hardware transition. */
+    tegra241_cmdqv_sync_vcmdq(cmdqv, index);
+
     return true;
 }
 
@@ -113,13 +157,22 @@ static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * If the VCMDQ is allocated and VINTF page0 is mmap'd, read directly
+ * from the VINTF page0 backing. Otherwise, fall back to the cache.
  */
 static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
                                                 hwaddr offset0, int index,
                                                 bool direct)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
     uint64_t val = 0;
 
+    if (ptr) {
+        val = *ptr;
+        goto out;
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         val = cmdqv->vcmdq_cons_indx[index];
@@ -144,6 +197,7 @@ static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
                       "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset0);
     }
+out:
     trace_tegra241_cmdqv_read_vcmdq_page0(index, direct ? "direct" : "vi",
                                           offset0, val);
     return val;
@@ -220,11 +274,29 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
  *
  * Page 0 registers are all 32-bit; this helper is only called for 4-byte
  * writes.
+ *
+ * If the VCMDQ is allocated and VINTF page0 is mmap'd, write directly
+ * to the VINTF page0 backing. Otherwise, update the cache.
  */
 static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
                                              hwaddr offset0, int index,
                                              uint32_t value, bool direct)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
+
+    if (ptr) {
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_GERRORN:
+            *ptr = value;
+            goto out;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         cmdqv->vcmdq_cons_indx[index] = value;
@@ -255,6 +327,7 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
                       "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset0);
     }
+out:
     trace_tegra241_cmdqv_write_vcmdq_page0(index, direct ? "direct" : "vi",
                                            offset0, value);
 }
-- 
2.43.0


