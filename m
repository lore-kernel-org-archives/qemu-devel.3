Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF5EA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni8M-0004Wd-9B; Wed, 04 Feb 2026 14:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni8E-0004TR-6s; Wed, 04 Feb 2026 14:01:42 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni83-0007Sg-4s; Wed, 04 Feb 2026 14:01:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DygKiYEz81IKw8Gv0oQgSeznyiNR+qksMXOLpIHRbjfLb/FOIbtehIPV4xfs+otdsgpUUog4nkM/Jcle7VAz6d/UJK/8vXtdNbrV3qsQtvIWwVjdpYXxDxloD6c97EEjmJAtjVpVEgemQY/XNMgv8zIOw9KuzMzj3xxbkyNrwoWTkx/1d7v7nBh5RO/K3Wyf5Nvkm+pr1Ojl42+Dr8/Rpokl0E2BlenGNLkPdr6XGFHhYWIqdl0UHEvBTMF8m+aRqSI6ZXAZ81BYTXn/TL+RfPrQojjTYQO3GkVaLSn+W6nZwZnj3u3qPCKrdBVOuNqaCp2E03Iz3b/PpIsrHBnHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67X6kcNn7UEF1VTBXV+plfYz3bXKWpMeM3IDli+tOqI=;
 b=nkA1Uf/ajAqS6aNWA17Nr/H43e7bBSMVKC5CO5OKVVOQyqDQnwLhf2vPiVPUPQu1rOcCFS05qhqGQhTN7RQc8c5IFZy8vlQFPa9cfvcFmzpwkoAWspFYo24c2OYHm49Wiykwbcqb3Ctk3YNxst20aOsteRpKI2pKwP64Mr8cJOoq/aMKyLWtFscH5Ktag7j2BsLu0A1ExilJthKKVCBYQdfQD31pl1BDxBoD8dky7KE5bvQE/7lgkgGpT3Jc4IkqHXpgk/o3U/G+Abzmf/cWwmpZlRKfTNUOOjg2aHmzTECdLIuRIxGSFFVhpu3WZsEN5nEtg0Iwn5KMnnZ1DCykSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67X6kcNn7UEF1VTBXV+plfYz3bXKWpMeM3IDli+tOqI=;
 b=KQFOzi2w8K43eYphoYpQ8YXgOYRUFrUpZkTlCqp92oOtaDAYKSGAE7lRAjch3TIN3j0rAujvDzZJ+Qo9aoYaCsltfUwvsssdHomnkLOK4Uk6CRTp6XdSvye9gPAnqZThFBUtWBtM9EOvJH71nndaKaO7g7hRojYCdBsvTXsFms1qQAHO4EVnpToUeB6tY4LUHeXdRqnTDR1o92fAjklD7ss/9JYbzn5MDnLiZiTRzexw6CZmPTDPqAIlbExd/lPU21/3x7IN2+Cj83Wi8SFcAxJD2LdqN2em+kh12sZ8qIdPO7JZEzYnPTZ+qEWtwRUgfvm5fyPmC/IlQH/r/hpBQQ==
Received: from BL1P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::17)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Wed, 4 Feb
 2026 19:01:20 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::56) by BL1P221CA0039.outlook.office365.com
 (2603:10b6:208:5b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 19:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:01:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:52 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:49 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Wed, 4 Feb 2026 19:00:06 +0000
Message-ID: <20260204190008.20070-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204190008.20070-1-skolothumtho@nvidia.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: f392f039-42f3-42ce-40fd-08de641fc830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7lwJ0hsu67DtpO8sFwVAWGsZ6/7VJzw5fUycEfQB4cv0tGQ9SuPRlKKyTU74?=
 =?us-ascii?Q?88q2LzqM38QIFzFIV3IYS18bNA1vJzsFAHb6RC5HPTZVoUiloNBoRuvhux6t?=
 =?us-ascii?Q?W+qcVCta6f7T2Lk+56iuiCDuNKkkpABdWEQPAC7MfZ15P3VkKbErUwhzGXrf?=
 =?us-ascii?Q?GBkfiL96Hyi2CqbbsAdJ7dt8gq6NrRP+qFTjKiw617ET2TsthdsGFYNYPOu2?=
 =?us-ascii?Q?TI9c5/mM8raK12JDoWpy5ejZzZSSGFTROrLxURmqo0kKgxIRGeNPcRjzFREz?=
 =?us-ascii?Q?72QE7vdtrMjW1R7BlRVl98j1DRHhYFbiF5DOuNdmF7m/2DQOKHBhwEpAxHZh?=
 =?us-ascii?Q?c9ZlUQEwREFQiKfk8OBYyUAnj+s+nmEAlnJc5Tw+4XPArEnIn2rfvN9aSUWE?=
 =?us-ascii?Q?SYwuz7NVHOdbpstOziw4EkdC5sz4GTMEuT2zm1+AjM4tmaUrFGzBVEjJYdrI?=
 =?us-ascii?Q?kYUT2igsrXAimxG5ghca0/Kf7TQ/kf0S+Rpj6x3Dgvb+qNhkHbXWHQO7Uo2h?=
 =?us-ascii?Q?Hc9a9JmzHYcP1ukBdpUgqXw8RD7/axCzntQl2b153kuJpu0nTaTxtvqSPfjW?=
 =?us-ascii?Q?l1CzwB7fzXe2K+MTysxeI0A8ihqOuPAHAIFDz2diwKx/9prM5cVtXhr9fGp0?=
 =?us-ascii?Q?lI/gmmun7jMZatKK41ft7zzZ3mGgs9eruJIhRu7QXy2uXbKaqjH3/RerZbC5?=
 =?us-ascii?Q?jUCIkUSkCPv3OQ9Sbl1UwCnuWolBcMtk0MESaLXKh7k1INO1CdROREsFzIBi?=
 =?us-ascii?Q?oQTUhE9hk6mAvQu5nKQW5qIQ1G1y4r2i3RCcbJCJ1YA9Rjuu2lquzjHoh4Ff?=
 =?us-ascii?Q?QIgTCIpugSvuEZCcGMFlv5BZb+NeaDiXk+ipVvElMmddIxtVDo+zLvCkOtO9?=
 =?us-ascii?Q?2UyG1C34+sW2cmhNezwH75s8KzPoIPPUlY5VPq86SuNQR9DmFg4rYIifkp79?=
 =?us-ascii?Q?NDaTKePS0gaUIxPBhOA1qA/NsNNaelFTKGwiMN1QNudTz+b9H7xUHdSCYnFB?=
 =?us-ascii?Q?jzFcJ7S+WANjZmt2OwA48HBcXAVGeqKX46QDE/Rcu5s6k1Y55f6l7jHRTmas?=
 =?us-ascii?Q?uZ6Jxi75pmS/a25sSCcncev/HuXBZ3LnDF4b+WW/9kzVbZxiQ9DTqEa+aIcw?=
 =?us-ascii?Q?yYKmYe6LMr4nWreNkoBbB0QgUIbGZh+nrQHBXh5U+e2F8BXC0Zqs0ypWNw+D?=
 =?us-ascii?Q?MClhyTfU2EN5qUCLp4XMbgHWo/2ocuF/IzXnKoa3obvWkiv0ZyQXaHNtntI7?=
 =?us-ascii?Q?FLh/GA+zTowu5UCTYxsP1g0o5BIQFrduNEnX+/0fgu9lCGi2e7BguwGUMNwm?=
 =?us-ascii?Q?DH6VoEjU3O30XSygBnNFiHEYUeZLZGlkqQz2oTxJr/EZVbN3laV9+EbTs+7h?=
 =?us-ascii?Q?1BhyFRpyuK9qnedWh7XixSlOBoipsXUSbnsbISWVId+8Kx9SP8xgukUfBY5v?=
 =?us-ascii?Q?CT/YFh7Cz/d5KU1OIGaHVymzgC5Hh3AIEr6ZwVKi2QcpkP6KzP09VhNuHaoq?=
 =?us-ascii?Q?Sj4IZ64LV2f6/T9SD+1odhKazvMX63H/YsRqh3j8ru/uB2I2+f6tYydukrOD?=
 =?us-ascii?Q?fKbkRNm5OERKhhnmXMnV4mC+lPPjpq7COr04KJfoicAZurQHOGC3pbFP2wUT?=
 =?us-ascii?Q?YMJGW3LIwkZfE3xKS14QspMcJf+3xlaUTgOp0MwutPH+HcOmzL3xrZaAMeKw?=
 =?us-ascii?Q?TPdVig=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7TF+7J92O8L71BEpU0Bfk5SawY2KCczrnQbyeNHipT/P6jGXn36Wx56ZVhADUKSzQxgyeO78CX7n2963KLMioUOUCgrUPZPPpobK2Iaa5pZ2RXfF/xLq6AFuIZL+/csZX/ghjv5uXtESSzUZ2Uf8dDwxhWL1mhHaeO1I9pBsKp2/LLUH6i7Wu1M264JM4Z1hzGwafBTTPxHb1qYdNVRBpGQYItTh6ZtzAXSSUDWH139IQrJaLfOKQETuBiXQiLzrmDXFm1yRmslJNZXrVNzvQKwrdOGNWg82ohYitlgzjoKp+48lWEdnELXT2rtNNTy9QpUkAagWYJRjBrJCBiAmqYPH6NOFfBoXM1MLdImgQOvj8DlvvaR/eUEDfTFcAg4wHOyUtBG8EZqeufW+JVP/I0CQwJemtCd0haxp5pjx8rYmNMLP1utyVZPgbSSYwMUU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:01:19.6747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f392f039-42f3-42ce-40fd-08de641fc830
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
index c19c526fca..2ca0d1deac 100644
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
+    if (!accel->viommu) {
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


