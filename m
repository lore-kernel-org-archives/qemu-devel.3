Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F494EDF152
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqdz-00087i-0a; Fri, 13 Feb 2026 05:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqdw-00086r-Rh; Fri, 13 Feb 2026 05:43:24 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqdv-0006Xp-0Q; Fri, 13 Feb 2026 05:43:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/aSryUBa51W7aKJuKpcAU2qyj0UUDjsH67tjUvu6iFioGG+ayXHcz2SZEDpjz+IrOG1QUPBIvTqpiiY0obRBhuF5B6iD7fNTt25gGDwR3Z7VX/6iM+T3CQa//I/kGf92yj5a2GSf0Fdn3U6h+oLjr4oBuUA7inRrrV9Cj/p7o8B3k89YEfyrikjc84F89FuwutvGXBgdSQKRA/u6BGb/rRsPGTwPsrEVMMs88PQY7Q8Jmd/dmpN3+TsGkni1+1MIQ4EQEpfSdeWr8RXJl8WBSKuep5FQlH83XW2T8meFcDt8A1SHSVWcc17ZQJ3qBUXPtSROqkpJuKt2rfQw9K1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQqZ+dPQZapFThe2osR0f6IPTDtvq+hAOoI7ZZOijGU=;
 b=Sgh86yHq32QS1TCLo9CPqu6E3sidceiHfIOj4gWSoDy+H9U40J9TCPr+54SXZI2veL3M4GkFRjWeO8RG3NYS0sydzOgkBGZKLBR/8q3uwTpMew3hW2VQFzedpqx/n2jiMYDiBbmBgn1uGJSvCoOtWFhuXpYLpEeskumC/Bb5oAfOHTq1Je0v5kOdAsKkfdbxiZ5w346Iy57fNVmRDkty3x2/6PfBSQbf/t4nkvKBYDZDAED5Vwi2LTdzgxlzj0632aeHMOsBY233ivzBW4kXjx/ip8LOgzqStnbly5Q0oH3bd1Ur8vWlIp9mc6ThwBGsVFYVn3FXcWuMc74D7xDx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQqZ+dPQZapFThe2osR0f6IPTDtvq+hAOoI7ZZOijGU=;
 b=YwvC0ITSDQRhbtMRXdUhuF4Be6ot7EGUQqhiVxRfx8o4lQEFduRX7SQnMWeiFBOv3JjSCA/LWc8MptJu9+HifkOJrpk62ji5IuzF++XHDpwlL8rJpZ2hRd0BlsqM2RTNxZ5TbAf6N7hqWThjlzO0e07p4cJ8bD0hsU4mxiL8GOubRoYy8WHOzcuU15hI3jbhavw9jIRUQh39HU+7HZ1W/xh8IREcNBIcqvdBk9bIlhX57d8HRPorqdbzk9/DaljMboQUG7MbmP/kAG3iMxUos/Mreakegq7OlEOCB9PyYTrWYs0p6Lj6uqwZc4IlmanEpelzoKW5ZitYSgWTF+9c6w==
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 10:43:15 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::50) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.14 via Frontend Transport; Fri,
 13 Feb 2026 10:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 10:43:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:43:02 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:42:59 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Fri, 13 Feb 2026 10:39:40 +0000
Message-ID: <20260213103942.142823-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213103942.142823-1-skolothumtho@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: eb10c562-1f94-4456-5b1f-08de6aecb17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N3zqDgeltrDpZRtN+Cu+BDjyRWGizg4hf3hdFPMFwlG3K4yPJzftWCYlTe5D?=
 =?us-ascii?Q?Yo5sxpxuRPZuODWITBHFxueePVVFnZ8s3c6EXFetXx+rXy2jejLOvLwsfzJV?=
 =?us-ascii?Q?fWnJMfuXOnM+MoYu/qrlEzgEPC5YSsZbI8BSaPKd3vEZhSuj9weOPZLhaTeN?=
 =?us-ascii?Q?NgWIp+dtj8L1IfCfEp01HArqSwr4N9NGmPaC9JriqEGA5BxBujlz7ppvgh5/?=
 =?us-ascii?Q?y4cpGyYtgUNfaFDNfLVU/kj1T3a1rNejyB7HOTjPfXqt3lrHBkwveTqGLGwZ?=
 =?us-ascii?Q?hLsphgV83rb8oLtZzjp0K9oo4e/JSkLyPcW2HdEnkA3leTQqPAsech9yU9x8?=
 =?us-ascii?Q?DDYs4hjoFNVyr9e3fxg9iCkvRuJj0k02QY2GkCp9w/H3i4KoWePH5QYS+YUo?=
 =?us-ascii?Q?fQkIENCPBqTAppsWpg9djHCIw8JmkLeql2hpOqV5VlpIAHu5JI4Cq1+Lvl1F?=
 =?us-ascii?Q?HpfW3TU8HB9WdhoZGx30/lmBiqo0yXCV+LNxcKy84IWpHkng6XK3XuJ7VZBE?=
 =?us-ascii?Q?e9S2T4vcjs4OEVYnQBLjkFPYGjGW1SlGORqyREYYRObZk00rUbUewUy8pBoF?=
 =?us-ascii?Q?ZCYHb+JJlgELSBMIu0xiMV1hARPMPtimrgIMqDta7WCsLTFa/3wONgGhm2lb?=
 =?us-ascii?Q?lLugoDteb//xz+0Gilsa+1yySpeNmgETDTUleN1gtDHyPpByyJGg9G37T325?=
 =?us-ascii?Q?xMVwWIKr2UYQj4ncsAQycp54V2DMAE2w2XMUePpIRF9tZq7XrN1iMoYrHEuR?=
 =?us-ascii?Q?3oD05hEbgaPzLf2sQ8QWrRwppYA/+0982KvCwzht3TpLEj/xPRIcUNRUk3pa?=
 =?us-ascii?Q?mzpfLAsS+cBWhPwqMMHnkU6pxduQbxNV6cCyuz15DyYZFm+vcW2Sn3OT2IZQ?=
 =?us-ascii?Q?yoFVQPLP3mlAWql7beIA/ezq12VqNLt0vSPCMZbl+IL0LJ52Ok/3KllBKyji?=
 =?us-ascii?Q?RFAa+rObEnAUkC1Nkl0qKGH6R9/ht4T47FEK8pAv31UN+jPWC8RlWzij9mtP?=
 =?us-ascii?Q?TiG3yv3EkVDZ9KCW9wJEIgafN+qMcN7VIOA5+GbAnfkNeAlde+zr5WdQUXrh?=
 =?us-ascii?Q?6h8DcwgFiFHBFr+a2EjmSjKShTjPi+3X3wvW90hjr098lWVVNvNf/hmbucKU?=
 =?us-ascii?Q?pQeYYxzRWEWxOiqURcS7dlwyMJ7nEN+6TcRdjea4GzNUj2fzFRfozqHBZw2V?=
 =?us-ascii?Q?Vb3pNNTqluoBj5Aw4/fwOohO/ts3n7lJiG5eDDx7fAwe0LYDO5W3OJpmPzsT?=
 =?us-ascii?Q?jU7LIHj7pm5AYGaEE8DjoFSy5xibGoOSx1euzovzakfQZxT8/7Kq0Z7L276x?=
 =?us-ascii?Q?hBCdxUBJzJnropgZJFRKrYAa0qpl5/Tsu4PyDSRKt69ipl14k0KhvVTbEQ6o?=
 =?us-ascii?Q?TtIugk//f602VlrmN/4ZqEOwR3xKnLoHzsVLoRn3+CX9lbxxZRclkEbYiJaG?=
 =?us-ascii?Q?kLb1mDm7wx9MTxWzQqgzfrpxNnBK0XcK68Y9iWdIxawq2ALuKbdwoeXTh+37?=
 =?us-ascii?Q?yZHGOaMXbjg0dkA5ACSfvMTznnT69IUcfoz6xEwH3eztFCvMmKDM/9MFvLa7?=
 =?us-ascii?Q?iyPyte8fdSR2jAaacJyxZsN7XHbOnrGJNA1GK8AXurE8dW4f+EhgNyO3wHYm?=
 =?us-ascii?Q?poCCmaS/jRlYsSZWB3syeawgiJrlWkdvH+3nG8tBrroyYIBb6uUjWhIDCPsE?=
 =?us-ascii?Q?6D4kqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UeyRz8vPUcRRrDeNd7YC6/RTMQG5seVQSFY2wGkOSg1MFl1eT4zv7rGDYQPfIzGVnH763/H1yY5/TWbj5uHviZIDRGQ0dlKA1H6SxlaWhhD6YBTEYUicXyTrtwxi7L+dzQjZJ3xm+sh7deZRDqDUkZKU6lNfFRWDkRRkrmTKlUqZZGUbZI2+IV4lBQ+RX936g5Ip25EMxs+jv6H9blDCJJ5muVl/1lhEVzin6hzGJAuGbXAeLP9fSssN749qaNbOwiNv4ZeKp1hDgahVze846x3B3hIPAo4ecHanWK09nOeJJESy+kGla0kdzZ12grAew1fVFk5EiISAbvOUiO4lelQ526eGzpPaiI8vmiCPuDvxePjCCGqDI6zPwhjiL5I2vda4jqzgFT6btBRnDAR2mLbElV/6/NbffvFTB0sXeUETanLW6ktyZHNo4hnF4kum
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:43:15.3358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb10c562-1f94-4456-5b1f-08de6aecb17b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Also, rename the local error variable and refactor smmu_writel() to use
a single error accumulator with error_propagate().

Event read and propagation will be added in a later patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3-accel.h |  6 +++++
 hw/arm/smmuv3.c       | 17 +++++++-----
 3 files changed, 75 insertions(+), 9 deletions(-)

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
index c08d58c579..f804d3af25 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1597,14 +1597,17 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
                                uint64_t data, MemTxAttrs attrs)
 {
-    Error *local_err = NULL;
+    Error *err = NULL, *local_err = NULL;
 
     switch (offset) {
     case A_CR0:
         s->cr[0] = data;
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
-        smmuv3_cmdq_consume(s, &local_err);
+        smmuv3_cmdq_consume(s, &err);
+        /* Allocate vEVENTQ if EVENTQ is enabled and a vIOMMU is available */
+        smmuv3_accel_alloc_veventq(s, &local_err);
+        error_propagate(&err, local_err);
         break;
     case A_CR1:
         s->cr[1] = data;
@@ -1621,7 +1624,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
          */
-        smmuv3_cmdq_consume(s, &local_err);
+        smmuv3_cmdq_consume(s, &err);
         break;
     case A_GERROR_IRQ_CFG0: /* 64b */
         s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 0, 32, data);
@@ -1643,7 +1646,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
-            smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
+            smmuv3_accel_attach_gbpa_hwpt(s, &err);
         }
         break;
     case A_STRTAB_BASE: /* 64b */
@@ -1671,7 +1674,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         break;
     case A_CMDQ_PROD:
         s->cmdq.prod = data;
-        smmuv3_cmdq_consume(s, &local_err);
+        smmuv3_cmdq_consume(s, &err);
         break;
     case A_CMDQ_CONS:
         s->cmdq.cons = data;
@@ -1711,8 +1714,8 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         break;
     }
 
-    if (local_err) {
-        error_report_err(local_err);
+    if (err) {
+        error_report_err(err);
     }
     return MEMTX_OK;
 }
-- 
2.43.0


