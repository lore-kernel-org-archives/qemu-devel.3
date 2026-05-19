Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58103CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHrM-0000B6-KU; Tue, 19 May 2026 06:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrJ-0008UN-PV; Tue, 19 May 2026 06:39:33 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrI-0006Tp-5F; Tue, 19 May 2026 06:39:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqi4T5a+EeSCIrGTQC0cRrADd7dluBg0KukYDMLfW3YpTbGkueNq80ZGHBSVIVrS6tkvN/gbXLDGNZp/NvLeww/q8Zm+y4g2BaSciyXuZi9m5AkhnCyFn0KeByD+4XXMRyPCrAj4fxodr2f6LLr8reAtec+mAq8a2dlg+gty912/d90N8Z2QFSub9Hi+qiM21csUcSnu2pPwXBnpcYUjtM6RLDjlUtT5syvRzsAXJB8SismJZSPgwyyTpfwrQUvE1pCTcBrlt4f+3AvytH3R9rGhc0EjPZGpkCRm3U35AyP9nxgYIpQ6YmwZaiMOUM4i8qkbIamItOo0b4qFfSbOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/89rafBFmrGVNq+LSE0RCDjpUAewpVShKXNpokral3g=;
 b=aNuSPCKC2BHMj4pDogcxoStQ3HY++xS2KRbTqmaDenKFKok/sSszCAJrpiBVUMsrLy510+tXNIyOfqdm75ClrnzLa5cuVTCouBBgSIjB0MumCtTGLSzlFcrszGsg0CZLfCz/qqvZ7qS3Rf1hWBLHlTdlI0UyR1TmxCdQOjNZ5P+5pov7kUq4Zrotwih7OGFtKbjbdlh4RhsIujKnAcw6jGL2xz9bSQPfJh3Qll4wcf4fmVuR5FzGcy99v5qWohlrWGSctxIr9oKzZeEDb9MMdH/F0WIh55DKiEocXToV0IZ/lhkK6oO5/8D+KP+Omhu5OOZcVrKwSjfDmOXdAjgpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/89rafBFmrGVNq+LSE0RCDjpUAewpVShKXNpokral3g=;
 b=MJJuGCgGPePdIsYr3/ZhxBdpCGD933yZNot45aAKL+9dwrvY6dSPYZiSZKzZ6b2/o1RwJc445Qf88mXLuXgE2MsH17WsqvDJOQEpye8QEFJnrpmdMrB3r3yP4oX6e8+C4AofQixHEGUv+VmvqpuPIN1lyUlgf6xugMXdi3wfVHp0EQnYfpMty3f5tlvtE7GsD4y65suqwLbL/BhptKXvT7t02VU7kPpc/QEsNiNYzEI+3rxtGNMHfABUqm0uCR+hkMbDFHTImGWBGqmkCsYbJh4sle/0uYzS22H5/InzpHSetyJ179+/qm/gzf9LRIkaSvwlKOIqfPCmJVSo082oQQ==
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 10:39:24 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::e1) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:06 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:03 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Date: Tue, 19 May 2026 11:36:51 +0100
Message-ID: <20260519103727.899332-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3534f6-ac7f-435d-79e2-08deb592e50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BVT7sEYhi3YroWSgzJw2B7myhu9kQzG2PKuhKep9WBOrwIS1JvJ9+8DS/p0nOknkkDfiFNSgxG1TcUVerx8SmVyC+kvIaZNWXjOlhm/STGqvarrali9qAt+RLpV4nUXSpFCwdyzmrigO0+t7nWJ2ptK26E8039UHRP93nqn+6nyhWboJZzsPM1HBktQB7ET7tUUsdcE9RHocwlvVLVLEtkSimhKua04heRdxNc8vXlKGMF7eH87hUAjlJp8udRAsCtZ10c1Olc/Yv16vHNk2afkVVPYHA5VM12Y7/ppD/CgQltyF/BIafN+ZBlQjCdZELvyNHrciGw4RAzH/Xp5zE2tZ61Hr4R1M5HQqxxF88muT1OHGwQmSzQiqJgM02vQtMAqA4c3oQcpjFIdePxew5cwo7gTBBKlFuRGVO/6RNaMy4FXEkdAlxANyV/LL2mzL7Jb9usb83sqbe5aMchJQarhod89T3E+9wJE7KxUdqdTJbtETUSgtAOH1ACg8K4WW3DshnrVRwaHgTNf+NGrc3McXLyobU4feThLSLZ6tmkOwwRbD5k7hKMpXXeLFeKZVrFnKcgIJXF52LOIwvB5+5vRLtfPOO0z5hB3Hm46ZXoLtTqrGbuFRRuoyxJOqjz2uyTPuzomWWSmXxL/qF0Th5hifARM9p/f+F0R0UcOPPZkTLGNzmtic42jj9fMeXHibBZySvXGXqfD49bPK0deks9MqkXLA+dtk0o/5oYmJ1Qk=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y+Kg2JStNiC+hnEYgPJSQTJgvR0RJsgUZfjgu89xa7eeriSB3qw5oPhnm1yea/bkkcMj0Wpgnp7dorfZrZIw7Rs+N5Hr98KyfuoAtLkrgjFax8GjmqeOpydOPNgqmXkQcwCskVecKNos7zlbQKtQ8Xg+OVrbFvXynbWu1wsltrstlUgi+GwcdHVTAGCmnoMJ+39F1GmXXtTt5xygA9/8aoc9eX5+VIw0ihLyCWzyKTE71esG8oAW5sR3O7vm3/BiCmfujMVfuODQByZZksErO2VNXWfEM13TwbNIV7yE9SNUgMzPsnc3/jVuk1s+7Fz9IZRAMfkdkdBb+x5MLbrrsznTS4koZROsiuiLzG3qwUTFE6oJQtHOsqXnOF17INV6aGpvf+OrliIoKhY9r8oupU/bTe5c0Xue/eOsDshHBypFfMQk7JZislD6OGuxSXbN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:24.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3534f6-ac7f-435d-79e2-08deb592e50f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335
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

From: Nicolin Chen <nicolinc@nvidia.com>

Replace the stub implementation with real vIOMMU allocation for
Tegra241 CMDQV.

Allocate a matching vEVENTQ together with the vIOMMU, since it is
specific to the Tegra241 CMDQV vIOMMU and used to receive CMDQV
events.

Free both objects on teardown.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  1 +
 hw/arm/tegra241-cmdqv.c | 48 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 030f5758d5..54854421f2 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -30,6 +30,7 @@ typedef struct Tegra241CMDQV {
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
+    IOMMUFDVeventq *veventq;
 } Tegra241CMDQV;
 
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 298671e0ce..6a6cfc2f71 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/arm/smmuv3-common.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
@@ -25,13 +26,58 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset, uint64_t valu
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+
+    if (!viommu) {
+        return;
+    }
+    if (veventq) {
+        close(veventq->veventq_fd);
+        iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
+        g_free(veventq);
+        cmdqv->veventq = NULL;
+    }
+    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
 }
 
 static bool
 tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+    uint32_t viommu_id, veventq_id, veventq_fd;
+    IOMMUFDVeventq *veventq;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+                                      idev->hwpt_id, &cmdqv->cmdqv_data,
+                                      sizeof(cmdqv->cmdqv_data), &viommu_id,
+                                      errp)) {
+        return false;
+    }
+
+    if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                       1 << SMMU_EVENTQS, &veventq_id,
+                                       &veventq_fd,
+                                       errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
+        goto free_viommu;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    cmdqv->veventq = veventq;
+
+    *out_viommu_id = viommu_id;
+    return true;
+
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu_id);
     return false;
 }
 
-- 
2.43.0


