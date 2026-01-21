Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6157FC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicS3-00037y-Ts; Wed, 21 Jan 2026 12:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicS1-0002rz-Lf; Wed, 21 Jan 2026 12:57:05 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicS0-0001gy-37; Wed, 21 Jan 2026 12:57:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIZeRbTywBDV1ZM5jYl2CLGJHZgphQAU/NAwuKLZQ8qn/Dg/iWI9ygj/3efaYYglBcejzakiizMMKY/yca1blrtLpOpkqzAt3wlAIXGbXXcMrQQ4DIWnuiSmxRSntCdDKmup2GPsPZDR/oH8xXZ4npSPrYtUbH66lO3SxS6LLtRMmRNy+eKBU9kc9zldwY0X7zGV7jSlnr98ypjaF7yZB/bLgUfKodZwjuzQ0zovDkVW2z7RgiIx5mM3pMKMTG21S91WAL6ameASpWJrcg5B40M0t6RY6bxM7Pm4zorZb3un8uFIice11f049FH6uDiyIdvxpoyPBHswNaJzTLRvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CglsgpnZaOVNBGgvHhfnxCdjPiuab7FEthzJYhTMBv0=;
 b=tOC2Z67WsFnIuz3LlfjTrFSLDZveHZ49GeRkF1+adrAJCosJkpqsdwMw/MtxOe6PI6OQCQ2CNpUZg7aKj5KBXBekexNy6e0M7y/PEhUpQHCUjKm8vBF0wXOFalBEBPEFHSq0eeM1RNHiUMBWZzGkeFfz7ShZXGECmo7KocXvl1C2buU7s3xfoJwXM5vprJQ0bXWZzmI5LU2psThv0pXgIpH2tBEyg27UkTesWtOoQRLsMwDNFVbvXIGtV2V3UB0CLxUPn598O38QKG/8uMBxeVQJ4AdB9/SszJ60EydQrb0MJHBupd3z2Iic6yEIKsD7lbGdkn9EzaZs82iTlKl3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CglsgpnZaOVNBGgvHhfnxCdjPiuab7FEthzJYhTMBv0=;
 b=r80QOqpPl2cKxE2lv8w+0IDIB28Bq15qSOJtULteMJh9RjuF/tk54VDJnTDutNsdPlxJyQ/ngPZiJn71cL+4w6ZdwWyUVxUdWKHzOus8ZR/5yvnkz/RqpwY7i1BbY1zL7VGVahTL5+9sU1eltzKj89NiFd/rEzC+2EPCvUjgNjmhEaa87Js1Sjeh/myj3S3fm7Um7Nhm3zWJF2M0IL4P33yIb4cYiK/xMBRJujoeo4KWzNNro3UO0R6B+nGimIbinCcekNWQQV+Z+9WYibm4vTiJCbd9aebw9h2R2eMk7tTmn1rz9tYHzHntrvpLWCqDpuuYy7cH1bTbTFJRl6OFTg==
Received: from BN9PR03CA0456.namprd03.prod.outlook.com (2603:10b6:408:139::11)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:56:55 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::39) by BN9PR03CA0456.outlook.office365.com
 (2603:10b6:408:139::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:29 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:24 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 17/37] hw/arm/smmuv3-accel: Implement get_msi_direct_gpa
 callback
Date: Wed, 21 Jan 2026 17:52:22 +0000
Message-ID: <20260121175248.87649-18-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a00c82-f940-4aa4-c904-08de59167652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SvwcbmKda3fQb/MFB66tOp7aKLsxG0+V6afQU1R8qb+FHTs9RHquZxvKP2Zm?=
 =?us-ascii?Q?0gqR5UNndd4qbuK/1c8/CXTR37TwtEGEUeI1Rj1wYPeLzjH0FKV40uSGCu6b?=
 =?us-ascii?Q?bqkeMp5vG9oc8q9Gf7ouyRZndy+kqd2YB8Y9lgf/q/t1sEm0MciZ4VQDGdav?=
 =?us-ascii?Q?S33xAi6ls1oS6sFXDaJ5E+e1PkbK5aJbW6xqk+z+lBeHzjYlGGkl9oQ7IeNX?=
 =?us-ascii?Q?A5UEPiCyzNOlfsq7XDFaNTX4DFjCJbf2u/Z37uwRfAbxh+YzujuOkVRa7DDb?=
 =?us-ascii?Q?kzQxJizk8AMJZd931UO3XF+jtFwiNIBogeenl//BtY2/rjJAoLfjsyXZS+yA?=
 =?us-ascii?Q?HSD2cwlL+Abg53gmbQMiBqs0Ix4QdTyflzcLTEyuJDobsuOQq4ZS25cEnWJ2?=
 =?us-ascii?Q?x0h0WUXHaeyM6fzf3C6M3uH3kEWK08lIvYOPRkv/XQqMzdk4OfaopVmOUisA?=
 =?us-ascii?Q?Pb9RRuDTNgbYxQAqB7HnPVLCcbW+JOVd0n2LKF+sibPB6SFOckX1uSHzfeec?=
 =?us-ascii?Q?ONpiu/3MQMJrIHLu5ozr32kLWI4BUBd7fknMHGPpalbkFE9VppSdditC1KU2?=
 =?us-ascii?Q?Y/0c3uooFfvx4ryADhZa3IO1jwDNq0Xp1gljVnT/u00sSEdMyEohSG+aUC5U?=
 =?us-ascii?Q?S/xkwoJmqWf8hXtKRGuPUL+GxUkKRTfOWnr496jLqD/J5uaC5ZKKMekNw44o?=
 =?us-ascii?Q?oP8ARCUtNgrJn9w1ouOvj6GEzehVxF3DTPyuZJDvqN4dJa+lZ2cwXNzPBMd0?=
 =?us-ascii?Q?bpAkqUmJwv9IUDcPkwOFZGz5uwTTr/mYaxhnN20cBHRn87g3ey7ox1OoI9Fa?=
 =?us-ascii?Q?DmdwBpSvxj/c9WTOSEYRYaJMF3U0/h8PfwnEZ3ItKtUTsidVdDBu2WV4FTMO?=
 =?us-ascii?Q?O0Y9DzOpf0XqnxngkGdByQ/zNB89Mn7qyON0Jy5VCgHKxv1hLqrr5brxvbU5?=
 =?us-ascii?Q?OkXoTjeL1VsyGXscBM1SyQdv4biLMNR2oaMA9bj4Os4xaFmh4Qbkl0WazSI3?=
 =?us-ascii?Q?dgzztiuezjDaFsyTENM3BS+/QTe5N+yvT9Gnq6878nUFWDcZAbCanpvONTj/?=
 =?us-ascii?Q?i/M4xMiuhjYicNeCiVac1bOk2s82AmIJDlincTtO4MTQ9x8gbdyYPT0QLPdI?=
 =?us-ascii?Q?EgTH7MDXCRKiIYofdnRExGITguRk0u6Av5OWlIiSVG04P0rISIpiHD00KWMz?=
 =?us-ascii?Q?PMFEVUS+NuyvRTenbq2VxhcqJ/a1N0XK0Yoc2mFOdH+bB4bKa7XXui7oUImY?=
 =?us-ascii?Q?2n+EOiTPkdn2RQEuaSw+1Dihm8f0tRn6vKYcV1grA/dOnS89JMI9dUupd2BY?=
 =?us-ascii?Q?SQ8zpHQ5fqiwNiQf0pt4L02Oxt34laI5jpfUByZFCeYfMx403X+o8mfPtrZ9?=
 =?us-ascii?Q?OBGXCqPkmzchfXElyZHSGU0MoUrHSdvT2s0dd/75dAi6+eP4qvw8tLd9kM/2?=
 =?us-ascii?Q?lMLZGgLrzpULdmJli4Uo5vohudiuOkcSOOJQdv5v9IrsfE+Qst7E5G83ViLK?=
 =?us-ascii?Q?IQzht0nnepWfiEu5z51Ra6hbqRmrlx1BVwOWeCaUNyODe67MgL8BOzb4JIQo?=
 =?us-ascii?Q?uvglsckZVR+FoN/8jl4b81IKB9F06jroddssnzfqeNBHhk5vo5JtO7wOVTr8?=
 =?us-ascii?Q?7X7Oil64kQGvI1iXW+E9LthWtrvNIk6BzpinQgeB4cATORl0QbtHR2wXO/np?=
 =?us-ascii?Q?MmPPfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:54.0724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a00c82-f940-4aa4-c904-08de59167652
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
translation (guest Stage-1, host Stage-2). In this mode, the guest Stage-1
tables are programmed directly into hardware, and QEMU must not attempt to
walk them for translation, as doing so is not reliably safe. For vfio-pci
endpoints behind such a vSMMU, the only translation QEMU needs to perform
is for the MSI doorbell used during KVM MSI setup.

Implement the callback so that kvm_arch_fixup_msi_route() can retrieve the
MSI doorbell GPA directly, instead of attempting a software walk of the
guest translation tables.

Also introduce an SMMUv3 device property to carry the MSI doorbell GPA.
This property will be set by the virt machine in a subsequent patch.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 10 ++++++++++
 hw/arm/smmuv3.c         |  2 ++
 include/hw/arm/smmuv3.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c125974d12..c6ee123cdf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -393,6 +393,15 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 }
 
+static uint64_t smmuv3_accel_get_msi_gpa(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    g_assert(s->msi_gpa);
+    return s->msi_gpa;
+}
+
 /*
  * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
  * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
@@ -497,6 +506,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
     .set_iommu_device = smmuv3_accel_set_iommu_device,
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
+    .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7a32afd800..6ed9914b1e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1998,6 +1998,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /* GPA of MSI doorbell, for SMMUv3 accel use. */
+    DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index e54ece2d38..5616a8a2be 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -67,6 +67,7 @@ struct SMMUv3State {
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
     struct SMMUv3AccelState *s_accel;
+    uint64_t msi_gpa;
 };
 
 typedef enum {
-- 
2.43.0


