Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541A6D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Z3-0000Hv-CD; Sun, 11 Jan 2026 14:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Z0-0000EC-Qk; Sun, 11 Jan 2026 14:57:26 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Yz-0003ws-9V; Sun, 11 Jan 2026 14:57:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAjKfOtJjJWUInM4JhlVhIggFqXotM2QRwZtnWxmQ46DWiU3eHzoFBqzMw+OS+S7i4caWFf6vUCF1cc89f8y5bbWwjWTFoUzmPgznRG0BdDpDmCJX97tBJ5YP65yWwaq10o8YK+M639hgddlGm8qLSwrK/qriPXAq20bq8LltAINFq4l0ZQ8vCktQXAMf8XE1Hd7SJdph4u18epCAJpAeXbElx6TyotLrLTQGxV50wfDfHZ2YuwFeyOJBFVYPtcYJJrE8wOFp7gWu8PrHZdPJGQZZxkp8bLue4y64/UfnXSFGQDPDO39P0voGX+cizZ7BmgVUImm9MX7plEv4kjzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjzPTOyyBy2lp/Eu2xDXytkioUUv+aLfsnPwof2ejBY=;
 b=xPEF4zcFJ9gHNDsj9k/hyeaDBSmLN16yrjCtw6fxObDH+McLmUj9HEAIrLh/NfWurHReH5bg3pHeLhXNCv95EQ6NL4cttWhu8tLk4YG1utgoAI5p9rypk9r+o+i1aQ3MepkNv69IkBy5ir4qNilI0mPnC5Fk4Plb9U8GJcH5D7JOLyYHbgZQV6Ts5sQRpN8fJ9CLygTfkRfFhIBJ92RFEi1OUGDlCXyM9TSkPZimRHe6g3OLBQibbQ7djUxpGnF+hWHcUG6UNYVNRf8g3TxOpLXwK33l60mtM6KIw/1DAkh0uCtj3IzDvz7DFNQgXVHhIOOP5rULqjIuART0PCb5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjzPTOyyBy2lp/Eu2xDXytkioUUv+aLfsnPwof2ejBY=;
 b=OKUqR/nRIfuZ6BQhPquh//Ll76ApXhKShjlqkmzvBmt1bwNSMlhCA/gy0BHaQf2SRqUp37jnmH+bVmB9/gDbsj5Gfgf2TFISJDtAeZXC9JWm6P1WV1R4czjZ1PB9J6TvSAGagbP6soKJ+ThKK/u9Cw0R1SM3Ii5gCAjtQtRmdU2ki8KP8+0pKLFLRG7JA9fen94iWMAuF6Fa3nyPQmAl0wuSvGAZnM5qz7E1MPmBrWlgcbqIEh1Tsr91YmGZt/H3LCKyxfU22ZVm1OoFJuvYRVa2ycEgexEzpMrWm53IXSotOhukO+jzyh3XBHWfocU3Eos2z5ISEGP4zjjtEmPGuw==
Received: from SA1PR02CA0011.namprd02.prod.outlook.com (2603:10b6:806:2cf::28)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:19 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::1a) by SA1PR02CA0011.outlook.office365.com
 (2603:10b6:806:2cf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:09 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:05 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 16/36] hw/arm/smmuv3-accel: Implement get_msi_direct_gpa
 callback
Date: Sun, 11 Jan 2026 19:53:02 +0000
Message-ID: <20260111195508.106943-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acafe0f-e8cd-4626-3807-08de514ba0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HHwhkC8MhrvCfZlA/2nqg18NLXMNpMrr20F9FP7N7//hFuU5IsdcVTdwiiZA?=
 =?us-ascii?Q?UiXrB5iKY6PDxi7JDIj961eUH56k5Dkc3mZ0N4FnAsPK+Ec9qYjGrXoVw3s1?=
 =?us-ascii?Q?6xllT8CfriuXas4xtGVad95QbvAVvpVy4HBGCRpa0sYqlJEAcIGW+KJm0/lU?=
 =?us-ascii?Q?dojakuwB4N+VJMKkwgvYk6+dKsbz6RKHyQvXgTOVAEZGR8mxt3ceD5C0YaGw?=
 =?us-ascii?Q?2VWCeRhyOppAm/neEfIFMc+nGTaXvhf+gQ8f13kZ+F4U06jpzfP/zy5gzWxN?=
 =?us-ascii?Q?g67ob34KKrT5CNrj9vDrtRvBhwoalHPCTr+tg9lLG8IJUFGww5/HgjI9Cguz?=
 =?us-ascii?Q?/g9wiief2yQKMgen40XA4j5cyRUs2ZoVYf9WmJ057MnmKib9+NRoHfSheAHA?=
 =?us-ascii?Q?25Q8OSXgQwNSdpWJnzRHdRcHd3mmfO7b0DiYFsNaDAB+LPPpgRIM4AG+8YfX?=
 =?us-ascii?Q?DEw9hryS3Wrdt1r6ZnQQTHneC6JVowXFu7815T9Iv1zIywszFvJ8tx1dtvkV?=
 =?us-ascii?Q?c4ehPyvBgI5m3fw4DkUq/NaZYc9AsWhykBpPsiooGv9GD2BQj5pByp+ck70A?=
 =?us-ascii?Q?PCJhgdIUPXwa1STUtqkq7e0kpOrTq2Dpb7Pr8zhRrJ5FsMKDofDrKEMdptBr?=
 =?us-ascii?Q?FVgHm9lIOulxnHjvt875iNqLWqAESjUTr2BkfyqQfTe8L5sM2or1kZupLb5q?=
 =?us-ascii?Q?OyV1EqAo3J/aGxwglu1yhG+cQM2nkPBtj16UT2P66jGX1DYgsNfpHTPzIV9M?=
 =?us-ascii?Q?tJ8gIdpBM4DktafZfv5ZoewOXEYBE72pRaBlvbJMB74WM6aZ3XgU8y/qJysb?=
 =?us-ascii?Q?0OXLlslwiCNk/D6j3TVInfhyjGsWhYvbVIew7sIB72cRmbAf7fZ/LJ3mZGkV?=
 =?us-ascii?Q?u/RCdWqxveLDo22qgqd1c36KdrUuhpiWkacW9ZIF0SIdvRi1vtfAzxjlGH2I?=
 =?us-ascii?Q?YzANpcov7CF9IaO3I1bYVFDfateByEGSKX/ew8GHtaYyley77r+x0yQlngDz?=
 =?us-ascii?Q?lW3TkpAonN61FWOm/hzpuFRrGNOgijSAFtMXfb4iJYr8w+2SvrIIkAk6lGH7?=
 =?us-ascii?Q?l1U20mJYdHlIPK2FnqGSwJvirVkUAa6rMVsEorQVqxsB+66iTkpGwD1479tN?=
 =?us-ascii?Q?ftOeAgVuwhdx4Ex78HhPk1YjGDSLZIKXzKNkJyuuuvvrE3MqRCLPe7Cv8XSh?=
 =?us-ascii?Q?NjKDsFQw+R0kdxJc66W/MgvhAezOBJ9cHlt/tpABiSXkE57h8OTRtaJz2mQr?=
 =?us-ascii?Q?44HawcxmqoHTlpzdIMLPAZ7hYaeLQc9kKzNABDl07snLxwp8jokSp3p+UuuC?=
 =?us-ascii?Q?K6oGw1/CPBVGzI/xK8yL6CskJnkYv18S8ydwzJGSgKj18CA8/vU+7R9rGXV/?=
 =?us-ascii?Q?2XD6t6BzUcyJGio2WIC73nAUj2blHHv0uWttjhcEFEkHTGH5Gd1WtsnzEdwM?=
 =?us-ascii?Q?eKHx6QOmRJ59hmJE2JO1s8MfG54Q2DBXiOuzSs/9ZOVgxPeJ/PGnpCx7LdDW?=
 =?us-ascii?Q?XoephpKf+qX61EhaKyzjyj0UxSKw4OtwskhYk+sjl4bPVjehdwZ6wLMV8SSK?=
 =?us-ascii?Q?WnFPk4VwUNFoXF1g0P0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:19.4381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acafe0f-e8cd-4626-3807-08de514ba0d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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


