Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB98FFC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzB-0004l1-6Q; Thu, 26 Feb 2026 05:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYz5-0004gm-DE; Thu, 26 Feb 2026 05:52:43 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYz4-0000n2-2b; Thu, 26 Feb 2026 05:52:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZiOPZwmNzkngIWHc6+0VuQ6cfsYOAA1NQAwKebcT+72BqSlbCc2wA1stUsNNDkKfvLQjW8UDir3e/he2kR8PCkAsdO83zQ2hIFcsWXhaquzs3Ngm0ICaNAhUgvxkp0vncURvRvM2ruAHIGPw0dbGjDR3wZjL1rLDrfxxxERTSntzGeNLBteYqPbDRrK8fMGt5PC4tJV2dK7/buTazS0Kzc3OCAxi+rE+DHf8i7TmdXa6HfaQ4hmEkMefGJ2Vh1sh71dLCt3jJMDOyYnpq1jyONrxagZcKxnvY7oqI67gKub3VgRB07M+C6GOoxC+LGWq3rIxWuPTeRnf2/NTJ/sng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twt2FCstt9zRAElw66KM2A9VTF6lMrPed16vyZoTctY=;
 b=ft4cgyTmBydU0LHNTRCNRZL6BodxB3LX5c9j5stoaDYEpB5I1ukk7FMf/TIRwEFHN5uZs85goA22XpsUzN1tWzoSOZUJN0QKAoW7GvVHnwdhnDzZyKdjxokR1FWM8xwBnVfVGiNk1m9duXV87jRmdFSAeVbbNG+mXrOQkfuSXHxaQDh8lGHpniz94PpVY+z5pl4b7rphprVYsoR4w3bSSzi7fLKHNlPD6KYqZbcTpZpfH/eRG4qiXs1mTnVaJhstRaRXdmU018ftVUeXgIxw1Gk6GaLxX5wGV/Q8ZlPqAPR5sdJpvc+YO1+eUbXrrpRYfdFDHyJG0TMK4xwo0SvaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twt2FCstt9zRAElw66KM2A9VTF6lMrPed16vyZoTctY=;
 b=nGoolFR1WWvlHStUTf5vSL5iyirEfSt7Bcmu8gyqiWStroAV/futCaKFXrdQZSPWKIukYsdzk9whTFUWeN9Q63gL79HCu0KZ48rxml6/cjg4KmOtTkpxaa0k1k+7d5Cr0kSz8/MCbdfvcOvvNoU8q8d/3Jg9hlaUjA0rQ1JzlnYEFBEEmBi6Ax257eO8/b3HffatCkoboM5ktCOALO+DmRirrMiwd1CjL4pFbuTaX7DHilExGsy0nGwfnm5NgH1Fpid+JdkMzicyZZPl3H/RqXdhqflq1O0yjzqfH3oizSxvkbVG99c1QN0RxF6ZK1VxpNMLBcLBUIQT6Ogu95it4Q==
Received: from CH5PR02CA0004.namprd02.prod.outlook.com (2603:10b6:610:1ed::21)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:52:35 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::a3) by CH5PR02CA0004.outlook.office365.com
 (2603:10b6:610:1ed::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:15 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Date: Thu, 26 Feb 2026 10:50:37 +0000
Message-ID: <20260226105056.897-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e44c23e-d06e-4f97-ca38-08de75252630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: teRPgF7LVDhs2COU1902HNoOaImQyRyAyVHN+3QaBOsAKBNeFD0SjqvA5Bk6E99It8y2wcnAjlBK1BrtO9MnZ+U8dZPfDXK6xX+UNkI8EW1cYM3+V8lfmM0UDn7WOP0D5NZTVctsQWuoLDUGmgn/foZz5cYhY26ZtfO2/OUnHlXN/v3pIYpEroO8EWTYhLZOCxaujZtozy2T9W4g3vZgjAZvnVKmrJYkXrPi1YLt04koHTiEM299h2Ww6CWK0qLjlugwx6ph/rfl+st86gHziqWd0xTB10uZ/rJCL9JoAZxAmOseaDfaWTaAeOUdFBXhqeslWVkCc+Dngh/t+ot3sqgoXfBRRDDKO2qqyIQ6E49ld1LTuzSWSjZXw+UdzHi55tc+IDsnXh9ZYDbhIK3jdUVZtRgPKYy3jbu8MZZgYShEc0QD27lii/+vGbnPJ/XVykzUivIHANd9TShgSb9mHF5WydfpkotFHiFQ6Tr91Kc8MejDimkbmfmLVE0lqL/dbDm7MEtu+SNZ+KDMiOIy0IEDDaqmXytADVHGIgcUSGS//Pk2l4qbVXpe1A3iQD/EGb8P5eHFnzjWfFj0az4tBG2msp3TMC/ijkxAZnUShOSH1AgXwpOk0lkB6IacUU6+2NzlJuiFpAkl0cPalP/7qR1aCB+/yukNnjsGkDJ1oMPaBxTwlaUH3Eu0R62cvVce/dZVHREn6maDygmcOqeAi/PnGpg3QkVRIBqweOv3Tdr4LICv9GnCQtKiYLnMMDKs33MUobIlt4kJJNcn4jnssVeWFq8l8mRbuDGOjTNGjY9JBxch0MQZt9sth1J6qeSDpoZIDDq8HDwwgduSCpZ/pQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 85gI15D70bDJzsoBBF0JOTn5r7FP2fSypbVLRwv9t8Tr43gdpIfjuu/7VisAK5iOdOAHMpZPuIth8iwdB+6oN591A04dcnVpAGhSIcOQvbQbLrD0iqKtObtToFwAXlm1lTd1jIoE3HP7Ubop91AYcN7M3yWjiiqAtte9IxTDPdY/k+JHA4/Jg79nEE0S4cOhEgtm8jCf61X3FyazH9Qv3XPystKzPkzFx+cKkrS8xGAPHW3pVxjopZvfpqVXbtGfNQZAqZo1+s0QIn3HtrYiNac6WrlLUnYrdIDWuIPe/oBgeTxjHI8MLpzAS3YJCgeuF5ZQKmIwL9jg5cIYWIzCjjvmnL/7o6jlUhVGvv+K14rPB3eOcIgr2i93tJ9ZUKjpeFyQEmOPatkWsBP6NYpVGLGS2SyDUJTZy5rpQ/r4PlG8EY5N8u7vwZoB9hKeSEu7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:34.4811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e44c23e-d06e-4f97-ca38-08de75252630
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Replace the stub implementation with real vIOMMU allocation for
Tegra241 CMDQV.

Free the vIOMMU ID on teardown.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 6959766129..d487612ba2 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -25,14 +25,29 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
+
+    if (!viommu) {
+        return;
+    }
+    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
 }
 
 static bool
 tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+                                      idev->hwpt_id, &cmdqv->cmdqv_data,
+                                      sizeof(cmdqv->cmdqv_data), out_viommu_id,
+                                      errp)) {
+        return false;
+    }
+    return true;
 }
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
-- 
2.43.0


