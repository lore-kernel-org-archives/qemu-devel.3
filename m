Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82026EE20AC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNCb-0005Iq-Sb; Fri, 06 Feb 2026 09:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAY-00012H-Tk; Fri, 06 Feb 2026 09:50:52 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAX-0007Uy-Fr; Fri, 06 Feb 2026 09:50:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtiezwBvPsg8AAGLM+BL5Yp85QtJba5Fhbj6hp3RVaR5v3RhrNBg8qbhQgTWiT4yLBrOdbFpeB2XHli1Ng1xnO6FRcDaQfOEibO2JPjS/X8dq+sqznlLe2gblsPNx342AaLed270aW6DkRBfWvwt46exnYZ+Rf4yMVJQDZjSUkiioD7dfGlDDoJbzmJfLC+hPrwW7ibFGCtK/Ba+reZTqzVz9cqzf2aV+rdYo9VbefW00V3095CqMr6Zc/hbGvvvYb9TIFx4VsiR+z8dZVn4oQpNbpPvUY3BUfO0LSqxrJ8lJEYN7q5eYPEdzA2rMCBMEoCUXkCK8LRqaKSTeeRtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ep4jLPMKaanTRecNylm8YuzEyG72wHhD9/S30/jVtE=;
 b=gjtOs8sZ0wMxtMuZy2Z8ift803sS6UsDzN5H61yuCskmG4Tg4NTFqCOCdpFSXcBteMC7TqAteLoARcgGzTLCUSDEOFmUE1EL98pomoYhGXX7yoi5ZdHc6sEOSKcq8K7WBrCgJ4sPz1csIuSIpqZni2oi5kEfXuOc1XwzVgHnFsT7/aMe8eWmTZS3TsOsmTgmIcc8LHq0d43/ymF7U6tlp2rBtJDfbxdgCwbBfkRBMI7ET1ufLVQr8KHwRurdevC3rjaPTLWOK9r3qCN+nq+eHSKGhxOZ38fjgxysFA3PJpTN6ghHP2oeCuedgVfoYrkBYDVK/vg/AxHBaaEyNvHlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ep4jLPMKaanTRecNylm8YuzEyG72wHhD9/S30/jVtE=;
 b=WbHZIarUheitdtoNM0Jt9DdRu0aRYoeepjE71YJt+ugkpsAAT8E18t4MUxSHW0pVyypzTMHYJb8KHosQcZLlDYDgzb7zCXMvn8tgg17GH7aLsI5r1hUpqqDB7LEqkugSgtVFunQyoo430LESP4lpnbr0oyKTb+/IxR7uVMNwPVers0rcZRtAVSB/w5LvjXFOKLWB9neKcUs3ihgPKPqkl87oKrsPXg80+qedhTydMtLIoHFDqOlaQ7W8u3CUKVIcTy9zQOceNx+AWRZuiuto8/DGSok37DNJju7MNjxSh0jHB5wcW8J//cG6ZNAvbpvnEwy1Bzw/LF1F/d0R8SCKrQ==
Received: from CY5PR14CA0023.namprd14.prod.outlook.com (2603:10b6:930:2::33)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 14:50:42 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::2f) by CY5PR14CA0023.outlook.office365.com
 (2603:10b6:930:2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:14 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:10 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 17/24] hw/arm/tegra241-cmdqv: Add vEVENTQ allocation and
 free
Date: Fri, 6 Feb 2026 14:48:16 +0000
Message-ID: <20260206144823.80655-18-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: c37e0d5f-e160-4d5b-9c07-08de658f1a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jk4DiNsYgbx94dI52Wi2mbstA+ndNQ1bYevuyPiBsVzA3lY3ncfOojSPBZRC?=
 =?us-ascii?Q?fZo3ecIFV6WjiOxnTMWtgRLw4nGRFvv8IyZiOLeMyBcRM8OnsfO4mBK77tZ6?=
 =?us-ascii?Q?6wzZwn0MkHph6hWLrXbgpWSGh7O8W0CzEbIQbOrPjqh9v1+h0TLnYTt4LXhQ?=
 =?us-ascii?Q?QKQCu+6aDQhrxZtk8TEmVxiUjovJKVqu8nAhSV3k/eKJ+zdd0AejyTaI3Hh5?=
 =?us-ascii?Q?HaK7kasIVYCtXSgiHarlC3DWnKtMA0kGUFkN35pPvPVmtffTDzLEWemoRoux?=
 =?us-ascii?Q?RpYdkKRAj4M3pY+J5TfYfQ607xO8ZHGhgUrPL/+ADhEj+KrpneXb5Hkf9ine?=
 =?us-ascii?Q?c8xna8zLU2RZPzQx7JI4tNy5sGjdBlqF1QfcCZMMzk+/xsJz7l8aOkQQ8pBZ?=
 =?us-ascii?Q?CjLF7gV5qytryrIMhoZILjqUATD+B1oab0JvKbS/3/803U0sen3B0ooqGTVa?=
 =?us-ascii?Q?y/c6UCLPI9CvKRdrtbRYyDJ9aIh+rmVydfu8pWADj89ivKgKVopOwixeDip0?=
 =?us-ascii?Q?6Uv4M3vX/pQvgTNSQpUXdiWhos7TVFkCn5GLL5SJPwNGGZ1oH+FPL43DJmzi?=
 =?us-ascii?Q?kT6Y2DHJ5rJs1G9PgLJYNnurtksOpsDSxIkt6V2oxzzYN8T3S2BR0sdhbLwY?=
 =?us-ascii?Q?LHLmxdmOujnKwHEnFgSTl5jvEL9+rp/eUB8DJ2pjhYm7BdcZyb7gNj4DnBAo?=
 =?us-ascii?Q?7iS60TCkqSaACoBHZMGnCzMiq3YIddudLK7MAHgFhZ6MKErAi4td/nukXD2h?=
 =?us-ascii?Q?1oLLaCIblIi7peTJ2dVBDyrBPbNpEdFN6K/NTkbs5bTIsH/feMZWje6D/Lr/?=
 =?us-ascii?Q?SY1FUv4hxkQmd8siP2ZqmSOeCMbeOznbBciVwQjtQ4Bv652dlhp7pDZ8Rr5N?=
 =?us-ascii?Q?El6kpTNgly0PBxr71Vkp73cQrXQJPAit2id7r4FPencugMeJtgoNTZHC0aiz?=
 =?us-ascii?Q?TCpkHrLk/+MY7kJWpUrhpjNlxPzuRgLsOI8+JEgDEDZF/LA2xD68yd8EdIev?=
 =?us-ascii?Q?+h6kVO3nRhZPz8VBQmAmdppdD8UqQzfSM0mTJ76lzRnNVtYbTvi4P7FVMMuR?=
 =?us-ascii?Q?Ngb5cJ8oeXjkdYukmigAODlXb15LN/FlF0/FsJSSgkzM+wuvU0jKPchJj4Ch?=
 =?us-ascii?Q?/SyB+HBcXt4Dc2R6LSw2XWqTQWvQ0HeaXYlGFDlA0Knbb6o9JVhushZynS+f?=
 =?us-ascii?Q?NfDtAPEG/fh5rqdvn/h2SH60IYOMIgKz5GVlnLHZApamCg+Neu5aOQmY1o8N?=
 =?us-ascii?Q?t3ia6gxIs0osMc2okt2bweZQcNKy0g3j0JT6iU/hIdtm1FWeU9VW2jqbsURi?=
 =?us-ascii?Q?fPV1wgpBWJCkB4c3VB87JlIH5z67UxCdN2I2gPx9tKmiq1eJXcIxKB+DWAfr?=
 =?us-ascii?Q?5q9dp74XjyzwdSA1lBHYG0oPo9R9/YCkAxnZG5MlD9U6K/Rk2hp0jVpzY8fx?=
 =?us-ascii?Q?ANbrb0z72mhZnQXv5nqhBGiZn87ZDfCslYbf3ORYDdXTulhSsoivq0Y2RC9B?=
 =?us-ascii?Q?sgKRGPpgRajpHK0MxiGmAzVb/9PMxXFQ4XVy9AYNd/l1+PNPN2yVybOjXX38?=
 =?us-ascii?Q?g5dktFc4V8HL5EwSCpwXE0y5zceDyo4jdqPnMtrUPrvxvKCn5yCQmYWJhA/a?=
 =?us-ascii?Q?d2V5eZqBnlay51OPva3H76ppyQU+XVAnyu6K08sQGngPqRj+V4wUe8TCwkYU?=
 =?us-ascii?Q?XTf39w=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a/rAaszP7xvM4CiOPOvsJ3fXVVeRZlbOqW3S1M+wpqzB4zsjby154O/JvZJGNY4Nmj92kEaRoNN2HA2ip6VWpchSx6i+889L0C8Vm6KpQwNeGnvai4ZKAprDGghNhEH9hzpC18aF5dlwWUGX5CFkvyX0o0MrkVvqN/jEJSa82mRhyH+GMWEPF4Q8W8ScHZAeHUtRCzHE364jwhG8Yv/yPUp3EMror0iMnxfus8en44IqiqkGOqTvrvpW5v4GykJA1R7DJGev8xgcNlFudrOQfAqtiS5DvV8P9l2zUFnPeEqB1hmLap+RzuXgCp3PCTOoTHFbbw2VC6+MwSf5uPHef6edy/x0xRWBT/nd2Yh806hVXqay0HnmEunrq51XPf3hU86eKQ/sqYNz4OAoRAtd7jSqPkbLOUwyl1LWDP/V3yWP9IdciORkjOW9fNUaK3um
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:42.3910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37e0d5f-e160-4d5b-9c07-08de658f1a0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Allocate a CMDQV specific vEVENTQ via IOMMUFD, and add the
corresponding teardown path to free the vEVENTQ during cleanup.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 39 +++++++++++++++++++++++++++++++++++++--
 hw/arm/tegra241-cmdqv.h |  1 +
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index c7e70d8e1d..9e0e07e85e 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -428,12 +428,47 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
 
 static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+
+    if (!veventq) {
+        return;
+    }
+    close(veventq->veventq_fd);
+    iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
+    g_free(veventq);
+    cmdqv->veventq = NULL;
 }
 
 static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    IOMMUFDVeventq *veventq;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (cmdqv->veventq) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_veventq(viommu->iommufd, viommu->viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                       1 << 16, &veventq_id, &veventq_fd,
+                                       errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
+        return false;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = viommu;
+    cmdqv->veventq = veventq;
+
+    return true;
 }
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index b92c34e1d7..a3a1621e3a 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -34,6 +34,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_vintf_page0;
     bool vintf_page0_mapped;
     IOMMUFDHWqueue *vcmdq[128];
+    IOMMUFDVeventq *veventq;
 
     /* Register Cache */
     uint32_t config;
-- 
2.43.0


