Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2360CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE312-0004E9-Ex; Wed, 29 Oct 2025 06:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE30z-0004DZ-8N
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:02:49 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE30u-00048n-AP
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7bLVeOou366nKLQXcHl1AIryIivC5gsXVh+BOdK9iaq626NpQ2HeZo1jI28F7R7512OITFZgWHIDNy5kFoDArtCSfwvsfrE9qSANVjIKdHvf2Z0TpTThhNUDbPkVKhEBHo+yPyEcP2qVqWF2XlbSTNN4F3XhlZPBg/gTrxEhLKyDWeRSNiSGIExRwMcKjuoY0ny8cvrClgZtaXeQ8lsLx6zSFxjxpjku7PGUfdl76PbtQXnzIHrwhv9fDohWNJE5AXaNuHmaD25G2CHU6duhVmMmpAr58vP1L3fkyQq/ov7pZjNbZKQ7DAfmtxBd/+9BMENn2uGMsG13EADIIE/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgkmyKArScFBowqUrKV9b3FmN3VGP6LazUpfo4O6z5s=;
 b=li8ET1eL3lrq0W+0owEsTLWDYegz2LZsTzx4BTOsw3Dq8o1g1qZuS0xFJesn5oyOT+B4SKO4y9DQZ6j4pXuIalcM+xMHbOh/zI9ajvm5Nn0J+uqfPEy4Zoq1/Y9YG4J9LP1af0GaJ0eJ40V2UhW1uppWResOOZ50iVzP588oZo8OCkUfPTv4Km9yhQOUoUUbIZzDxA8YGlrrVIH1jIxkDrao0E4KdnZPEBFuQLqyjPBzAHKNBqb2xKHgD112/vzqmPY2hiX1SLvCiadr5UOy8dq/7HBW2or4LciD6bV2XkRUdXj7wzd9rZ9ZAr/Pn5VAn5Mcou4RODvXUdTMieOkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgkmyKArScFBowqUrKV9b3FmN3VGP6LazUpfo4O6z5s=;
 b=21K2pT2wcxiFxB7XLV8173chorsxtygBvKj9Wbui89dYHoSlZLRxTrPoRcYIIstck7Qc1g0Vygo3QnjiHs/r+s2q+9KjChHBq01peH9roGtiO2utsFHgsNZrJlWHV+AnktOk1JICC8aHqNZqTxdufKkBDyu0Z2NxucbqGZBd/Ws=
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:02:33 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::7c) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 10:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:02:32 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:02:27 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <yi.l.liu@intel.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>, <cohuck@redhat.com>,
 <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH 1/5] [DO NOT MERGE] linux-headers: Introduce struct
 iommu_hw_info_amd
Date: Wed, 29 Oct 2025 15:31:48 +0530
Message-ID: <20251029100152.4807-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029100152.4807-1-sarunkod@amd.com>
References: <20251029100152.4807-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 974a08e2-5266-409a-0360-08de16d24705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hO8yE13V4HH0vE7j+nw/2a9spuBOlgjCi/EMqcZajlphlkKJfeFad++Ee9cj?=
 =?us-ascii?Q?MPSdGDVe+pES7CU/71NeYgUpTXIySY/RYdOl3H48HmQS3SJk4xJPWlbvdPSf?=
 =?us-ascii?Q?lly9FpZun+tiiLP4oaV6hSsjNOQL0iq4XYujr7DtHjcmKmnBfUI+9olLpk23?=
 =?us-ascii?Q?dQCqLdFletTrt570E7KPWDiXrL/Saf/JV17q244ca95DMvaGt1zwrpVodpUN?=
 =?us-ascii?Q?SBNM7pynZcXlH+CJ60NcwCyhXJ3jNKIVofuLYGdfOV05f37K8JaVQvGKREDw?=
 =?us-ascii?Q?YrwmV8EiQtdgCMslgPpFIgn0a+3STcQwUwFXk9OAw0SoPnq6elGmA/jPto7L?=
 =?us-ascii?Q?wOBaB1k5ASzLbGN43qU+UhiEgo64zcvEyr0wEZG7simpiDGor4TigM8GeRID?=
 =?us-ascii?Q?b5RRZnekvpaQA9OufvnXFAodtdkdNLaqwC/bd0VpNq+EwwXsJuynWIQ2exJe?=
 =?us-ascii?Q?PeqOgvzt2D4/URqlp7wtUcwfpBcqKYeXu7Xo69wQEzT/TLqENSn/r3FjIY7T?=
 =?us-ascii?Q?FNEDsl1huSKzOz4+xZOAJQV1ldsT07Bqt80P9smOE2rHH97xTlSSfGjsTPuc?=
 =?us-ascii?Q?JSkCYv14KD27m6Lt5cm9eBrBsylwnaTlUzwNXDYWYvuclAwhGtUya7O2qCRQ?=
 =?us-ascii?Q?EKuyWVOzQWDSnnP+/Xv4oK7P0CtpEvzBME8w+lRDno67dhoRextk1c9DIwgN?=
 =?us-ascii?Q?VqXRZRp+mKG/e6yuzCl7D08E1ToYwces1zw+QOZ2AQwfi6RAOFQUfZre8rYk?=
 =?us-ascii?Q?4kCFSNCtP44eXEUdDVU//5UwsPXSQfk82EYhogL/q43A4N4zzbYbDGY3hXvj?=
 =?us-ascii?Q?zACQTgIf/kqXdeBxLyo0Igqd5KWpwMCkojgYchxTWl+rujFPfSyrPhVxuecr?=
 =?us-ascii?Q?c41Nz/F+GPB6OavmrgHSYVQRGETad7p6KceoOQ8vO2QR6YiF1cAvT2MMI/aa?=
 =?us-ascii?Q?sBkLZ42GUA+mjnXafcyudK14MQUb47jBfFxlQ4eQ46QUmzv9Try0wQ4StfLX?=
 =?us-ascii?Q?toqPUfb4fzCj6BGyESTgcfumpcD+rzrn7SOiPgdFlFGp9jqLimYvg7r4SDSb?=
 =?us-ascii?Q?Au/39fGWegTo8l1CBwLTd5PdEO+JaTHSNTgsXDFseq/hKqYoZqTlpq6vKsln?=
 =?us-ascii?Q?TR2SPqts92gF976IbXEgftiJ9tG79sNuSVYOqGeABfxp6SF0PN3PMktNELLC?=
 =?us-ascii?Q?Kp7ncYp984QRhEE+7BJsb0UqXx4kypXoKBjd+r0jjaJyQ6gMskYXYGSJEET2?=
 =?us-ascii?Q?vyPVZP6Mnu8xYNhIu1+BhIa1GtcL8+mF8hqsi6R5QkAVyncxdo2N/TSX1EWb?=
 =?us-ascii?Q?XO2u1hnR4H/D0fw+mwTTDkLuBwDXnoyDcr9CmEM6aiNGAGH1K/019Z/3sXcd?=
 =?us-ascii?Q?yRgrDRm+dJocR5zmPK8HMkJ/7kyVGvDdwefvHFal4dy/HCpa0/JLWz2QyIw0?=
 =?us-ascii?Q?eoG8NmnEB6BINzomCDuD00i+AbrU15acwJNRFghpgDckSXpGHdUT0jUx3tra?=
 =?us-ascii?Q?FD6Gw4kWMVXGxJCgmposWMDomzSY9zm7Nzfo0EMHKQou8JE58d3rsUFHgki0?=
 =?us-ascii?Q?skDR9EeKki4Hh+/dW3ksw8M7rzz9BWbFwm+HA7co?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:02:32.3209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974a08e2-5266-409a-0360-08de16d24705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 linux-headers/linux/iommufd.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 2105a039551e..c5fcb0396a38 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -613,6 +613,24 @@ struct iommu_hw_info_tegra241_cmdqv {
 	__u8 __reserved;
 };
 
+/* struct iommu_hw_info_amd - AMD IOMMU device info
+ *
+ * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
+ * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
+ *
+ * Please See description of these registers in the following sections of
+ * the AMD I/O Virtualization Technology (IOMMU) Specification.
+ * (https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
+ *
+ * - MMIO Offset 0030h IOMMU Extended Feature Register
+ * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
+ */
+struct iommu_hw_info_amd {
+	__aligned_u64 efr;
+	__aligned_u64 efr2;
+	__aligned_u64 control_register;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -622,6 +640,7 @@ struct iommu_hw_info_tegra241_cmdqv {
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
+ * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -629,6 +648,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
+	IOMMU_HW_INFO_TYPE_AMD = 4,
 };
 
 /**
-- 
2.34.1


