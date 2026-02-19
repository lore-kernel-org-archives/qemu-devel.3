Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A621BE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszvM-00054M-Ry; Thu, 19 Feb 2026 04:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszv8-00050F-Kp; Thu, 19 Feb 2026 04:02:05 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vszv6-0002Q2-Rb; Thu, 19 Feb 2026 04:02:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M62FlZV0yooL6JVlM5yDA5NPP255y84GNxRNsZhMFaPeU+jafHV1UYxoI8XewtGlhUEUZ8gl1fvHthElyapIKDX05EyfVJIdTJCVjP8WTLb7NwU6HL9pMuL9tbVFgWm0TmuFcy5+LBM1ovoeDOpYNz8OwuKR+7hJAv4pF3s5xL9+lwdL3SeP9uV9kP/aY6MjiaOUSwPh2Lqf/EEr4n8D3Pr10Qhpfrz97UJoqEo59fxCBfTxT29YZLanRc1XwAO5+S70JQcU2oUToclPxarOflulCuhmGeNkChnYWHmIzCwYFCJjC4ikeJt1ylYgDAmxb1ZjRQnjW26MM7vqo3DJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyELYqKJdIN5mjDNbwno1Ot9cJLyCKRbpeGg1F1XUdg=;
 b=Ttq3HTkrVQCfQp/waEJ2i6Hy26mQ1czzR40RJcxbuGaBvp5uL2ghbB+c+eBHlK8qIPw+tr5azaA205DqTmbi+00D2MapRRhlBnD4BoIU7q7MdckYe3CrtT3I5/SL7mdLLnVvFjSXo61zP0JoRVsE4zIBwRhPTeotntBOnhnBdah6VvceVnJjYxKScESN2QvTcMTsQVKjuA3TWUboCQPqeyUIT/QqeW4fKSjF4uQXdTELO7fuXMKInhq/zNZssUsjwEJfwAbNfGsyEVGz0KAw8mpAJLmGQHRte4SRNnqZp2MnD7K2wrlODbaiiMmGL9ZfBJdxbrIfM069GOKKjWxSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyELYqKJdIN5mjDNbwno1Ot9cJLyCKRbpeGg1F1XUdg=;
 b=NKo52WTo9aaNwSJtbT1FGzbLh3RigCjf+uEiR/b0DDriLQPw6XYGKwCuBiQgqdn2+v+3ghhY70sdyzfd/Lhe9Ly9BgN5qDtOsfep/xn4qN6ADOYmK/XgEiIJVuU8k9qIYXswmWsdecoTjaG3Q0KzDMDLugZuZLKCRjTRsrhno+Aao9AVOnSZDNSDNFLxvL7MHJ4k54Bj6VXILJ+IXoB8mCRHENM6Ct24lPmcY1cYIA7TzzoCtoel0YVf0QYFRPoWApxN2cicmm/57+NCOkDl2lbpHSoWTBxiGtjSyscl/DS4Mz4MZL6oVWUG7YmNtP9pArxXpJOcxZW24+RNAu0y9A==
Received: from SA9PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:6e::31)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 19 Feb
 2026 09:01:52 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::78) by SA9PR11CA0026.outlook.office365.com
 (2603:10b6:806:6e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 09:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 09:01:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:39 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 01:01:36 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Thu, 19 Feb 2026 09:01:01 +0000
Message-ID: <20260219090103.33697-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219090103.33697-1-skolothumtho@nvidia.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: e9be039e-f279-4f64-0aff-08de6f9585eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vWtdXeQizz7xn/t8ci+cdTBTJxvyHZ+94zsPfAspGXamiCjfRu8P2FtwanTj?=
 =?us-ascii?Q?W9Zam5quqqYq91pWU5izU28NPUjFCm/wFuDO2mFloR4qQ4UNd2NoQXoB6Axu?=
 =?us-ascii?Q?V4vM7oupoN88hektORKuCK8klOMDWT+Dd0O4CgXLHGHY2N5g0/j5YwJewYkA?=
 =?us-ascii?Q?bNIED8EpaeLWdEKMUvmoKQM3jRnsOLfoJls55xNFtT8RK2zNfe1946V3bsAw?=
 =?us-ascii?Q?qIEfL97clG2ggFPcXeu3YGYLgJ/FzwvOl0/SKO3rsShK3dHGsz3Io3t8XcaY?=
 =?us-ascii?Q?adzkNlzwGjfnW8fZ6m8f5Ds6McNWI/7iS1tWfwkpjq7rIivqIqls3AjFHzhk?=
 =?us-ascii?Q?RCqIBL1rwTAJm7zC5D1tNsF8OliY17CQjhm4QV4kJOPMNyJU3a7/fqlA2fqL?=
 =?us-ascii?Q?pTz9zWMh8NzPzy0Sq1oYdmsqV+FYH4yJcJBOLb1+mFk0voBFu25Xhtegl12Y?=
 =?us-ascii?Q?kZ0bv1DDfM166fh2iMy4uL0Cp8qDNzJ1zjPLKSAzFDjFiME7wGDLmBxMYAJq?=
 =?us-ascii?Q?JvNJrHBBxkYTa4R7bh4yULULyOT95/pcFi/fYoY4HgPu1FM+LujRkvsgSmWw?=
 =?us-ascii?Q?hPGn4yoAN28XYM0L6qjcFLI/xmUpA9FaW7fu6oXHwAzZRsVMncq3UQ7Hab/z?=
 =?us-ascii?Q?NrDz3rVcAmA/bYl+xWd8C4QECbVZxTPT1TAf4JcHlT1wRl6Z33KHg9Rn5OAe?=
 =?us-ascii?Q?Y+Jmyh+eLW6K3+lEzBMV4ce/+8weEl+j2NeqBCe3Ba0CZ1X8GCC6kZSc3hPV?=
 =?us-ascii?Q?+D5n9KwiWlURT8PXrlw/vD21IJYL3aC8iyLxRb50qp07x9gVheiv7dQuVCzJ?=
 =?us-ascii?Q?JtdWl1LS6eYtTSIXarRJI6vLq0CAih11OQcn1mDtNQoX/C0qIAzz3UJi86yf?=
 =?us-ascii?Q?pEaPf4pggVAy6ko2OCD18UFqpBJT7WsnNE5MqjdgtEkW/WFb6NLBel7r+wWH?=
 =?us-ascii?Q?UVW4pkKabMbM/idtRV/83lZUCnygZMF15q8/hcOA56RO53dEAx8oDOJLKZqP?=
 =?us-ascii?Q?FWTlM0iue0dcdEKIrVuSPPZcuRBIqNt3bKVXApoyqLa+h7g3Kkq9KjU1rWpZ?=
 =?us-ascii?Q?NT38D9Cgm+nAqYh8I7boR5gDfh6n0hkcSbsaf1iOa8aot8Urvg6Aqq3AHvR6?=
 =?us-ascii?Q?I2MjfY3JalFQaIAAYYTWF9n8BFvRSt/QnLDAYxJZseW6Myb/m+9P7d30PcOs?=
 =?us-ascii?Q?8PzoL3zBEpkyhRxSDDtkaR8ETcli0kSwlHxafGEokxbLxdMNwgjLGaPNZ2A3?=
 =?us-ascii?Q?9HByi1Yj7ZZDNaCGi7f+47/4PEMeWIj2MgrIOyUb82YRi1FCJFtkS4XjoHc9?=
 =?us-ascii?Q?Jg04ooxf0yQ5LTJLJBXr5Ae2wvlPyR3MmJ1h/1oTiQH52ZvSgZhRobEuOy5y?=
 =?us-ascii?Q?r7iprvrrr5fKwxFf8IiGzjg8ivJHPJzef1FFhT92vqGRuv5nLwVW4Ousob4h?=
 =?us-ascii?Q?4E8qT0ioUkEDsJ+0uNYEl8fjotj6gPdW2G6Tjy0wUM05znpmOLESMWXQYeg+?=
 =?us-ascii?Q?zaP/xkWFvopWAkc3Q+2GSFfpNeHqkQuYsEVv3JQ7DHzecgVvyjNX4KNsgLQX?=
 =?us-ascii?Q?e+ftMLI7xN0o1m5opZN/tqKavOp55BCAO6AV35VWqzhdLm3jCAECuFlWDXAJ?=
 =?us-ascii?Q?apR5L9mKK31wu7OL7f2xwqP3BmdF3CdDdwuzhEqHZdtJqcL+vOnUy1RnXa8V?=
 =?us-ascii?Q?m7WU3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fKj/aaTVNXLCqvENnWIkxl64vLqaPQ0EOg8yH7a5hsKIkScptHiVZ9gJv+Y2SR45NMIq1/PM9x80sc2fMLsEl3EUEPqs4cZkpHR1p21mmnSDSp2LWZFN9HYjlMaC8+PCyP1yiVNLCtnrfW5gk6ALP+B1sNq5lFxZLJ1tUUeedaKm3yyy+yfqDyfqszLirsd7xsHvZZ1r7tJ70M5Ts/BMJUl1jGd/GIAGzCC6FV7fDwP05Z1dKX9GOikjNNVfSULV88PDb3yuYkeSdD0eGyjPjZZPF/1kGazumr4Y09b0sdhMNAwEln/SMc8dCwMRHu/QKrOnXbTmM5nwubIojqrqxQyIcVjIQglHmlu/BdlEp2GZf50T1VmRIFJkiu06f/e0T7+MNMDpshIQvn//LTlxWu/afeydvi8gYxDGUS5u2HnqeJAdBsoT78nyRTsVFRBP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:01:51.9331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9be039e-f279-4f64-0aff-08de6f9585eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
Received-SPF: softfail client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

Errors from command queue consumption and vEVENTQ allocation are reported
independently as the two operations are unrelated.

Event read and propagation will be added in a later patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h |  6 +++++
 hw/arm/smmuv3-accel.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3.c       |  6 +++++
 3 files changed, 71 insertions(+), 2 deletions(-)

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
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c19c526fca..f703ea1aac 100644
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
+    veventq = g_new0(IOMMUFDVeventq, 1);
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
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c08d58c579..5d718da764 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1605,6 +1605,12 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+        /* Allocate vEVENTQ if EVENTQ is enabled and a vIOMMU is available */
+        smmuv3_accel_alloc_veventq(s, &local_err);
         break;
     case A_CR1:
         s->cr[1] = data;
-- 
2.43.0


