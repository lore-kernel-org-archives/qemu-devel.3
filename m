Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E3FEB597C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 08:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq5hK-0006kE-HM; Wed, 11 Feb 2026 03:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5hE-0006dB-T9; Wed, 11 Feb 2026 03:35:40 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vq5hD-0002li-3y; Wed, 11 Feb 2026 03:35:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3dy4RRzcf4tA5ZyWYftkmOsS82iilZnBPp2SuQWp0u6O0yUf1DeqVvZVnqhI2GVbpkZDj09Oa3SYm/QyfLVkFLNL6s0sI+JOcN6KhUE1HEQGOT8zxKJksHzyZgmgCdc8XBaq45pbCBzhrLheqg6alXfY3J2sdLUMph0CqhYe8WXDrSuar9FLGxFjV8r2miJmTGPG92Faec7veljtbPLXpbV9d9nqqGA5K7ZRhRk6T22pCkLMLVmAqQphTQSHYfx2YlJZb9yALJmvrx0t4Wwn9aWcfZp35ZM3Tdxn6mOqodg8FvU9FdOrb06eIliVHm7FIU3MzCUI2M4puYJKLONng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9sZEVKa71d6M5XUl4QD93Mzpa5rjKkK1CXJKd5ijFY=;
 b=HIXJgcW1moz7bWVkjhqz5PrW+Xy+jISsrmf4fX1rUDfw5HKSlpcrgvqyKOfcYUFegv4JnXO7cuGfx9TOXTHV92e4+QW0NmXuGzBlYOt1NwLdq+7SR01Tx5BmIvhhiPTobs+/gWj5FSmNK/sxNauMcHHdcSKRhevz2hDKYmwmIAGpLgIsdW3+F565oTPplHCoMxQMPuIQe9hjjWmfLDVlmhXWliQ3BJftebH2gskjBwMMj0JHQGXFNNoBjQtOKx7Tqx1bszm384ke34O1X7gj+Eq1CWHk4fYVPvds2Qbp7fs7GT/ZELm4SzxJXwmzDZrEGktmwW//tQlIPCiSoiz6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9sZEVKa71d6M5XUl4QD93Mzpa5rjKkK1CXJKd5ijFY=;
 b=UoPZAgXRkj51TIoxhQyUz+usa6kO9aci7AjtBLZG8irm/Y2a/hQlOOpkbvU7D4Zi3+LpLiuDuP9xk2pWbONbjnCKHSncl/RIAxlIsX+o1cLZPy4aNza3k/tRGgtppf1AjEMmy9zr13g+n8rviYJX79zvssv6uZe39FEe/gZmaDhxTpGVTPNXieYuK3kq8P6G+oLHTV/RKaSCaR79lslvkVLLA7rbovO6K6KiiAHHfH6XruZZAPsE5UnhYijNHlphNxzK41i6UPqXKJHY2LMO8j8VzBQO+jRb2P8borLr0U2uLnRCgypVofq/3uLpDMlQvp/IQcrHAjAOHOndmlWICg==
Received: from BN9PR03CA0792.namprd03.prod.outlook.com (2603:10b6:408:13f::17)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 08:35:31 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::18) by BN9PR03CA0792.outlook.office365.com
 (2603:10b6:408:13f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 08:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Wed, 11 Feb 2026 08:35:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:14 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:35:11 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Wed, 11 Feb 2026 08:34:13 +0000
Message-ID: <20260211083415.133534-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211083415.133534-1-skolothumtho@nvidia.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: d45c7737-5e2a-40f7-742d-08de6948844f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?quklAGjI6oYXTTz0tNq3KrPuizTfi/LjbeXdDSV/agJTQpwDiUCWMCV++qa7?=
 =?us-ascii?Q?/M/1qwFXAoRE3bB2RM/J5FRS3iA50xhLng/GFyB6g5xkPYmj3bE8vKi30EOJ?=
 =?us-ascii?Q?JAodE9MOaKstI71x7eRKp9hVCwW0VBnqy+zP/ZSTqWGqRPEstEOFNubqMRvA?=
 =?us-ascii?Q?N92YDj8mrq15se9vu+EO9EISyRsANGBoAZYUAlG/bSUB+ex8WT/2QBEug/RC?=
 =?us-ascii?Q?zijQ29Y/Kb8hPJLxwdrr2JMGSY7rl5yoAXl5wycz26SMfRjySg2GtEh9Wbns?=
 =?us-ascii?Q?Wjxa/FeW58bVw5jMoIU0zdqXrXMeosv71NSeKGYNqHqaJ1IunM4Yyf1sM+l7?=
 =?us-ascii?Q?y8hwrXAPYFYzxU5LWGB23ddA3ABLVN8HEY0JfvebudMDOcb5fMC4jGlYjOVk?=
 =?us-ascii?Q?MZnKfHZJdcZohua7Ca76FeegAu2v7slMwrVf2z1dgibF4f5+rF5nos9xFayA?=
 =?us-ascii?Q?F2T/0tR1V1zz1Cx3McyjhO7ajhrkpg+Mkty0DfGM25njmAqaVPr1HLYeyZQO?=
 =?us-ascii?Q?ioYR2bzGKrT93sWz0zv0w3XfIkvxIVcqCRgL0VMAgWKvu1VB3zgPU85+sicA?=
 =?us-ascii?Q?lb6bdVN+gj1Z/0GPRLG/MaU7RRsHT8/f1ZBY2x7Rr0vYmt+b7rDHT8tj3QKq?=
 =?us-ascii?Q?w+hcaKkLK7qakUWWJaD3NrJB8z2VRoObd5DS6NDl7Hfe5SWDdFnSBrBGZEMI?=
 =?us-ascii?Q?InlS84awDZx8t5jfRhNzpYdNcBJvBC2GmW0GOI58Os6TJwtBmXbvcBACkYj7?=
 =?us-ascii?Q?RuXFfhxq62VIJWALYjbsP+YnMV2p2rHSSeCFJe5nejuctEsjOne7bRCmSZ9g?=
 =?us-ascii?Q?+D6qMeOX0kOTLGoppTn/CVbsr5CmULSfwKZfgo1386JsWB7CCXh7gQn291Xq?=
 =?us-ascii?Q?DAGNGTq06SmXQ1/+hvTTqkxyRLdPlKT2PVHk5jRotjtJHT99ka4/Q8mz7ywx?=
 =?us-ascii?Q?3DSNsPtG5cPUrE04lhIZt9M4g1J2RUiBJ0aEwIMyxee3NQiHsp3fMl3bIOTk?=
 =?us-ascii?Q?be1LooXTdjEgmRmbh7X+vFarrNEp80+UxKmVtbZ27skZBuvb5yjI8fNBT4fr?=
 =?us-ascii?Q?+kkifb7hN5/BfCTHvAiBUM/FSdTT06pwXFkCWKaKePEebowAPyBrLSlcP9ag?=
 =?us-ascii?Q?WSlvGHKQqGxPLY4lAIKEdynFIjVGlC0IgAZdlQ8uy9JCniwn2057yKbPZPvM?=
 =?us-ascii?Q?X9MHiE76nFQiCqlWPRNRR1aSlahGsQZasLok3yr0J7P+RuMJyBtqISx9VsKt?=
 =?us-ascii?Q?qE18NKykUxs/vc1xldu0SOUiJnXYVGAksdjp7ny5m8QIwA5HrTRr1cTl0Lun?=
 =?us-ascii?Q?TSzDnQF/NqWN8CUqqwiae3xjUcgbjl6QrIN2QQqaqvHYjZt8/5GVLWqTT4/j?=
 =?us-ascii?Q?25fGpoFv9HF75cgi3vezn3IXql5bxpIiFgsdpmfaqUHzfl/Ya/BydBgNog6o?=
 =?us-ascii?Q?887DTUYhMXfOdAJjJdNAtR3ODpHJ6b7auPjiV8EG7LgJVA2ZaY+1QBS4h6b4?=
 =?us-ascii?Q?6UpJth4X9ZPiK4/qzx0vvNwM/nRfcBaKFn0P9cipYyfdoQ0avWScUZI4BPl+?=
 =?us-ascii?Q?590CuEFHFlz1E2c/Wrf3yf81arB3O3NMRC4YA3JRIDf81AtYsbBBkLIbBXP/?=
 =?us-ascii?Q?r+dseoJ3708mgMocy9NFxv9pJE7HiLoGfqIlxKlphninr2EZz9iSO9x81Wtw?=
 =?us-ascii?Q?Je+Vmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bg1n6QJ6ywGFesXJVu+JhHTjnD42tU3jYP3f7poknL1kEqsQ7Fg/wCpymY1C/VKKCan1F7d1yLFy6STRW6GbTDc8FQzvDgC59P+yW8jxv5Y1O/vpgn7kjf2XmVbXhPUfAT7v4GdeArHWSR2dYPKAQfdFcuj4sVYXFU5AzRU1qpOaw3ueGDqtWR/JlKHdu4O6mevZ0QKHtE8vHQ8h5ZQ0qOW1cgfRV1UVRZahpLlVEy6bHOVP7t36QtlZiy+xCb0nfnbP3aQwSAndqkOQ/Q0fUkqH5PfHDDWmBxHEku4uuduDReNJPU1AfAXj5/gRn5+XUJeJ4RmmNYMDQx2uK8mgEOamtTYpkMYBKVQLjFBYSjY4mKTIRObai1/oQIYRUWw7YYSrgodVMYmumjtX8jh+DCUT1tEEBRCrlJiqbbJyX4QpinxJqBLk8QsLmXduxh5Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:35:30.9705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45c7737-5e2a-40f7-742d-08de6948844f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

When the guest enables the Event Queue and a vIOMMU is present, allocate a
vEVENTQ object so that host-side events related to the vIOMMU can be
received and propagated back to the guest.

For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is created
before the guest boots. In this case, the vEVENTQ is allocated when the
guest writes to SMMU_CR0 and sets EVENTQEN = 1.

If no cold-plugged device exists at boot (i.e. no vIOMMU initially), the
vEVENTQ is allocated when a vIOMMU is created, i.e. during the first
device hot-plug.

Event read and propagation will be added in a later patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3-accel.h |  6 +++++
 hw/arm/smmuv3.c       |  4 +++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c19c526fca..d92fcb1a89 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,19 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
+{
+    IOMMUFDVeventq *veventq = accel->veventq;
+
+    if (!veventq) {
+        return;
+    }
+    close(veventq->veventq_fd);
+    iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
+    g_free(veventq);
+    accel->veventq = NULL;
+}
+
 static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
 {
     IOMMUFDViommu *viommu = accel->viommu;
@@ -397,6 +410,7 @@ static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
     if (!viommu) {
         return;
     }
+    smmuv3_accel_free_veventq(accel);
     iommufd_backend_free_id(viommu->iommufd, accel->bypass_hwpt_id);
     iommufd_backend_free_id(viommu->iommufd, accel->abort_hwpt_id);
     iommufd_backend_free_id(viommu->iommufd, accel->viommu->viommu_id);
@@ -404,6 +418,41 @@ static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
     accel->viommu = NULL;
 }
 
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDVeventq *veventq;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    if (accel->veventq) {
+        return true;
+    }
+
+    if (!smmuv3_eventq_enabled(s)) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_veventq(accel->viommu->iommufd,
+                                       accel->viommu->viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
+                                       1 << s->eventq.log2size, &veventq_id,
+                                       &veventq_fd, errp)) {
+        return false;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = accel->viommu;
+    accel->veventq = veventq;
+    return true;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -429,6 +478,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     viommu->viommu_id = viommu_id;
     viommu->s2_hwpt_id = s2_hwpt_id;
     viommu->iommufd = idev->iommufd;
+    accel->viommu = viommu;
 
     /*
      * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
@@ -448,14 +498,20 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_abort_hwpt;
     }
 
+    /* Allocate a vEVENTQ if guest has enabled event queue */
+    if (!smmuv3_accel_alloc_veventq(s, errp)) {
+        goto free_bypass_hwpt;
+    }
+
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
-        goto free_bypass_hwpt;
+        goto free_veventq;
     }
-    accel->viommu = viommu;
     return true;
 
+free_veventq:
+    smmuv3_accel_free_veventq(accel);
 free_bypass_hwpt:
     iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
 free_abort_hwpt:
@@ -463,6 +519,7 @@ free_abort_hwpt:
 free_viommu:
     iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
     g_free(viommu);
+    accel->viommu = NULL;
     return false;
 }
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index a8a64802ec..dba6c71de5 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -22,6 +22,7 @@
  */
 typedef struct SMMUv3AccelState {
     IOMMUFDViommu *viommu;
+    IOMMUFDVeventq *veventq;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
@@ -50,6 +51,7 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -80,6 +82,10 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 static inline void smmuv3_accel_idr_override(SMMUv3State *s)
 {
 }
+static inline bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c08d58c579..210ac038fe 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1605,6 +1605,10 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
+        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available */
+        if (local_err == NULL) {
+            smmuv3_accel_alloc_veventq(s, &local_err);
+        }
         break;
     case A_CR1:
         s->cr[1] = data;
-- 
2.43.0


