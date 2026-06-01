Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3386DCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1Am-0001CQ-01; Mon, 01 Jun 2026 07:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19s-0007Tm-4C; Mon, 01 Jun 2026 07:50:17 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19q-0005G7-D1; Mon, 01 Jun 2026 07:50:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9QjpcjrhtWZ+ktuF/YSx3sINr8UFlpTZi5picYnjLawsaLadUmkqy76P9HMYmOrFc9Ok84/wTjQ9TwVAFIB4KDpbsDv2WDPxtlHUbCurUpu87hCBZbnIuaPKhzk10XuIjpiQtHyIiCX+pmUPUsjgk1cnqbhuuaxO62uJYVh4S1NdYpZLeEPjLxT1fY+p5S4l6+inmVXWsKCbFgmAwqNNceZYtmbN3W6O/Wx9roc5kw8uCfxaFPotKQ7zzBdflHF6uWpLznwVMplh9DSmCCmpM2T4V0vBTJBUn4X8o8jXs3VbtviV17ltmmIgLU3k4yMXPQTD/Fg8HmdrUiVdEjuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agj4bIOMCHDWcO3Nemp93fjYkOm5nkrg3/JH5lDXxJQ=;
 b=a6d9MGlm33hcVbgS1D8KzMNdrclYjM8DGd9F/s/wyjFBkHqvFF1Ug1oyiMJLoeUBWxR5fmhreTdUhzZOA98+TiyuY2a7b3VFiD5vcBKYh/sg03YnbVVeL+ygSu4Ei7d+1/iwCjomtiWhvm7EdxPvNTcF3EpFxVrFJAcQ4FBjzAjw1FN9ah6sSVK/7rVsGyW4oo6UPijwtBoafEOvf4PAhFqwbm8/wvIAUInvOjT/GyJoFvTOjyFnyXPhIziP5jeh4PmaUvwc6ycFRUfLlhi3stRxn+YZU2fZ22c1YteoBwxsFej51My6tywnna1y/qYqZZLM/2QQde0erPyMNhPlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agj4bIOMCHDWcO3Nemp93fjYkOm5nkrg3/JH5lDXxJQ=;
 b=W07D8jKz3RCjdYQ6CaywD4FKCzNdYwYdf0jfm5cYs9dVdFhkvTH+p0Z86kkxFon3RphOzfoi0k4gXzq5It/f7AwzzI5EEDSEaELUH+83HdIxOyru5qxwnUeVZpWWEgqz90J7sUPEm7u3SyM4pd5dv6/TSEAgIMOvmZ3+6lSZYloQ+sxAItZXeTXys0TCBHll8ARjdcRwWga1PECc8wWR/ay5HVKWPm1+nPWMZPaD28DXTrh7d/dGJ4WlIO+Pk+f660soMef8eKeneWUl0chY/TdDC6enA+vLXVTd2Mn/wr4uZkcspEncuU7e79+ejTIeGlRGxBOPbxIE/x62f6nqig==
Received: from IA1P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::11)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:50:07 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::67) by IA1P220CA0006.outlook.office365.com
 (2603:10b6:208:461::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 11:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:50:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:56 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:52 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 27/31] hw/arm/smmuv3-accel: Introduce helper to query CMDQV
 type
Date: Mon, 1 Jun 2026 12:42:17 +0100
Message-ID: <20260601114221.457995-28-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d19e731-8864-4196-dac6-08debfd3ed0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: lRNghs6HOnNHAwOJ+Vf7WzD0aIHApvzCPOVL5wfvSgwOH6vUhP89L7A8jMnAwmTYnHKuzzSHOeG7mJ2v4iCMOROrFrDcG9O6jIOEBOmelxDYGnaYtCHZfZNSGz3okh9b8TcscPQTMNqRD3KbA636SdLSWXE3Q9tQEdrYS1SVb3o1qARTut43AQnz5sY9W1lyGR7F4+h1CfHr+qK4/LEQw6vOROQmy2/Xk3pf3eDwARL4RyDOi7aJKEMOBZvq9XEUDwf670zfB0coKsDNeNycKC6+oqrXg8nkiBJUfsVTp3PgGE+6Y9yjEUvxt+RyV3JrJtR7L3TrpplZjaxyi1WOu16G3eo/tCAsdbkMycOtMnrw64xn5gSpIhUcTvgqS9g5WQIeeRclIsB6D+TO9RNer03M89T0WLDsCRTBX+b2yxtQlWgquKy2H+/dCb3EMZlSFrDF10ZNY8C+9Aenr4lb+I+gKcO19lND7ya2WaMZ6owSOnP9ddTVK+5muiJ3n1hOjlusHb7cmjzuzjfDoFyJ/W2KI333gxojYc3HD6NuzszDhoAfJLbBsNmZSfLoZpUJ4aan4BvUGb8ilPAuRkjS+tKZ3phpXDulMgiuGq9cQtgUx+b9a8oSgcVSquf0H675Q6Z+t9Rt/9+0BPw6Wqrj5WJg3rLzUSARAM7qXtWFvZUpslAB2Q97P5SmRj4EI8J/g53MY72rcGGzhfHfxtp4EQpB4xiJf5ZsJCSibb9akVw=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bDPDXZ3NjmeemnRVfGu+5PUG2Odk5wOicb/rI7jG2m/05C2e+/sTNGaRb9WbRunFMc77wpleSjK2uYsqXGo83Cj3NMa1Pr1So/wUJGtGCjCjO87eG/t4U4H2BBu9may9l1e8IHHWuNSl+5oV+kTIdssQLE2eKOR6h1tWUhuJpmC59sVrcNO+yh/S4MftDKTswKI9707neq8XPiga5iVGuW2RVocswL1Vlg3INFFhI+Gn+VLQKLtn1sFhFp4TANmHWhl/pHNF9aDiQdhAM7mDw8oRkLOGUbHPYW9HY4ATU58BTtQ9KfAGUOOHQSqWaIT+/lYJGacr31dHl7gOCDdbea8nJnk50D1+p1vokgPO/yS3gfTWiTzIn29zWKQJ1J3+0DEBnkjID7ZO/uaAcdZXlExLqx0JqOtT0vV/Mu9y1NJccYVsU3L6i/SDAUcRAMRc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:50:06.7311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d19e731-8864-4196-dac6-08debfd3ed0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Introduce a SMMUv3AccelCmdqvType enum and a helper to query the
CMDQV implementation type associated with an accelerated SMMUv3
instance.

A subsequent patch will use this helper when generating the
Tegra241 CMDQV DSDT.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h       | 10 ++++++++++
 hw/arm/smmuv3-accel-stubs.c |  5 +++++
 hw/arm/smmuv3-accel.c       | 12 ++++++++++++
 hw/arm/tegra241-cmdqv.c     |  6 ++++++
 4 files changed, 33 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 8d0f636338..5fc85fb89d 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -16,6 +16,11 @@
 #include <linux/iommufd.h>
 #endif
 
+typedef enum SMMUv3AccelCmdqvType {
+    SMMUV3_CMDQV_NONE = 0,
+    SMMUV3_CMDQV_TEGRA241,
+} SMMUv3AccelCmdqvType;
+
 /*
  * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
  * support multiple VCMDQs with virtualization capabilities.
@@ -42,6 +47,10 @@ typedef struct SMMUv3AccelCmdqvOps {
      * If NULL, the viommu_id is freed directly via iommufd_backend_free_id().
      */
     void (*free_viommu)(SMMUv3State *s);
+    /**
+     * @get_type: Optional callback. Return the CMDQV implementation type.
+     */
+    SMMUv3AccelCmdqvType (*get_type)(void);
     /**
      * @reset: Optional callback. Reset CMDQV state.
      */
@@ -90,5 +99,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
                                       void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 9e6c44a282..147ae06163 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -57,3 +57,8 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
+
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    return SMMUV3_CMDQV_NONE;
+}
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c1c2a67c97..9c3bd4413d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -1060,6 +1060,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    SMMUv3State *s = ARM_SMMUV3(obj);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!accel || !accel->cmdqv_ops || !accel->cmdqv_ops->get_type) {
+        return SMMUV3_CMDQV_NONE;
+    }
+
+    return accel->cmdqv_ops->get_type();
+}
+
 static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
 {
     SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 661c46e3d9..4dba1783fa 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -974,6 +974,11 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
     return true;
 }
 
+static SMMUv3AccelCmdqvType tegra241_cmdqv_get_type(void)
+{
+    return SMMUV3_CMDQV_TEGRA241;
+}
+
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  Error **errp)
 {
@@ -1014,6 +1019,7 @@ static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
     .init = tegra241_cmdqv_init,
     .alloc_viommu = tegra241_cmdqv_alloc_viommu,
     .free_viommu = tegra241_cmdqv_free_viommu,
+    .get_type = tegra241_cmdqv_get_type,
     .reset = tegra241_cmdqv_reset,
 };
 
-- 
2.43.0


