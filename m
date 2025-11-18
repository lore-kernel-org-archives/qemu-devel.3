Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5CECED24E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIlS-0007GN-8j; Tue, 18 Nov 2025 05:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLIlN-0007Bl-I5
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:16:43 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLIlC-0007se-51
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:16:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNMRh4SeKzMwCG7QZ3xCzwlYTuax0eJRB7eIxvRXxWalxPUgroxxsb/d4ZIvzrv65+40LfZIungVKcmOeINiHbcbrITnsrJzdZx7T3GlEO77Dahpg2qHvgqPUlqBHaOTym7WJRYoSu0mPkbhLdU/ekshiV+/pT0LzArkp0Q2ePYFA40vCpWohZP1VxO58ogXNCLeZ8Y77wIzGOOKOKp3POzvJNGI3XsXvxWwKuN3GjotiQFDczWAp/7TStjQwGgvnvS0U4OwFhQ+n0CSki8JJG7oZEbrpbBupwvVWizcjd6GDlX/kTI2ndJo6zfWG6e/nJJSsc5oMseax3faBAtZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgkmyKArScFBowqUrKV9b3FmN3VGP6LazUpfo4O6z5s=;
 b=RUTJM5xJAqWMuFG37hiSZU1UC3elXNFWPyFtUJvff4io207RnT6NKGHd82kpyfVu6C3ll1sXBm2/TJgBR3WdFjQjdTTekDnPEh4XRnvebnLxkFuNM6kNDQPhUfuxWyGV/j0Ofus+Z+niFdXaurrOHnBZCCNF8pCzhcB4n7DyPT+m71B4n3qnVsBAZdPyKtnW28kF5OUeM/XSYkk++wVvpsieOG69UlzNFcoL0DOLK9tzXCp77MSYS9Sswmne6QC/jvO4Ev1q/C8J+WQ1h+2SKzz2LUjWkutDFpgTx1UqTVQffS8QPzWYGivVWtj53YKwoDoHtCQ7vsbLYjeTr0f4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgkmyKArScFBowqUrKV9b3FmN3VGP6LazUpfo4O6z5s=;
 b=z+PD2PiZSwAQqa89TjmZxQZ5pUQpc78Ph4Tfkl+AadT7ldgU8T1HpVPmnbGuP8XBIx4ffwEpFdudoczC+Y9imXdAtCBqX+r96veMzIwGi2wXCt1m8iXKj5QNmanLz1JKGURKEePR0zyteiu3gXzKvWnAMwrhCdoTCKAYDto7egI=
Received: from SJ0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:33a::29)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 10:16:11 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::23) by SJ0PR03CA0024.outlook.office365.com
 (2603:10b6:a03:33a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Tue,
 18 Nov 2025 10:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 10:16:10 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 02:16:04 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>
CC: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <yi.l.liu@intel.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>, <cohuck@redhat.com>,
 <seanjc@google.com>, <iommu@lists.linux.dev>, <kevin.tian@intel.com>,
 <joro@8bytes.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH RESEND 1/5] [DO NOT MERGE] linux-headers: Introduce struct
 iommu_hw_info_amd
Date: Tue, 18 Nov 2025 15:45:28 +0530
Message-ID: <20251118101532.4315-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118101532.4315-1-sarunkod@amd.com>
References: <20251118101532.4315-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b173a87-744b-44f9-534c-08de268b7f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bxKU+pdFA85/bUpIRrIm5oFzDkKF675rrMKVSpbGPZtPnv7irx0X6v8V/G6t?=
 =?us-ascii?Q?veAIsku2q3Q4V/aFhDZfENkigOIUBPHMj+VzxfHBAp2/MPRiYOJfNNmsgLHH?=
 =?us-ascii?Q?CDlP/y2b6J+7NM91afqxSe30u579BOzJntiyvf4TOttKLv/zGzza+kS7LGVW?=
 =?us-ascii?Q?pP5Ozdwzez7HfjlwoIGrAGXiV+80YQDSQ/fsj56dtARemZJLAraWoE3uCp3r?=
 =?us-ascii?Q?Vr0jAKa0s0lwScpDk8aU8ZZVU8n+iu/JNsafU2M8FayNBm5Xx/1JV7lVQuQ8?=
 =?us-ascii?Q?hfBhHUsgasaBIjaD6vEmD8UDmempJ7ceN7QJhSicAtZChOAiv/64ukmEXtiP?=
 =?us-ascii?Q?Fiv9c3HJyiy2d7ZxDJ+mSxNN2qb3aGbrSrItyBgSKvS1EELSbSvhnRG7TtPi?=
 =?us-ascii?Q?fp4YaGr+i+ff4KphIA8NwTroY/nUIlavLA62rrZQL9onT0ECpjDhNqQWrh1G?=
 =?us-ascii?Q?nl+EWICQkIbiHln/2a3nf+Xbh7e+paQIYIxlTdoh5dQmh2T8RCuufLsZ0upn?=
 =?us-ascii?Q?PumHnKUTD39Ybng93tVonsjeAEwcJKGkwuhOje/7nH2MPvcsiEDV5O14x55B?=
 =?us-ascii?Q?hfY09zsZ9CqmPdCpoMeJH4EWbe2HU60Axc1qQc/6YrwLpyMHXw20sU8+fAT6?=
 =?us-ascii?Q?PceOEGRBdwUwzpwUc11SglGSh69qybCnW1ZmfseKXp4yEnPcVSmOpnoCM44Y?=
 =?us-ascii?Q?cZIslgnzWH9nnNUdchLtkzPlodOxBKPc20pLAH3Ay8SwRDN6RiWF9cY8kIJo?=
 =?us-ascii?Q?ANmWIBt7q5f4iy5dt2aHxbcFcn6seysvevew1tBFWNCDnZ+9okhMF+fb1kZs?=
 =?us-ascii?Q?Hfh9oVVdI4S1xQ02ucDla1VCNyTEqNIxIirfu+GHq2oDdTr0m7jxfd0BcL17?=
 =?us-ascii?Q?ghkX6VmQ8F37fNc5xHuPVLDgNKJaCUtSQyVAP8ylDNg36NQyFsDRtkAAZh9u?=
 =?us-ascii?Q?a+mbyJj/v27OUuP2M0e//o9HErIo4E3O+7wb22DsoYZUm5UrhYkOjjsYgvz9?=
 =?us-ascii?Q?sIyhmkPSVa0D9hlh+yvllI6cryoAyOd0/QQX4ZKAab62eGRQkr64xO5MmDwy?=
 =?us-ascii?Q?iAePc2OdXO6ktpmcO5aKTkGPAt9L4HqZlkqgZNz+9inaJcV8prxNEqfKQ35w?=
 =?us-ascii?Q?BvRFTGlJshelrQZe9YSlXLdcVgQj6i0Sg764f30MSLQrKlyW69PQxqPxIMg8?=
 =?us-ascii?Q?W3RQhhpF0tGlqm+wwIk6W8FWnhOGQp9ZTPpOfFUXkWj7XgjuaNuM8V2Nb4M1?=
 =?us-ascii?Q?hF8u+97YuApZglOrbotOLGu3G0IDBXOc6hV9eTXdDgu3Y4/rNUQcH8h3dcmg?=
 =?us-ascii?Q?9wzM8N9GNRhLdrVH+i0Tnz2u5hd46V179TNoks0uglbs0XO8SrsSFsptOe+s?=
 =?us-ascii?Q?WBuOR0sfEa9pnzs/r5zahi3UcdvU9QPnQHxH1hlUMmUW28s8vWIoDzeATLgD?=
 =?us-ascii?Q?K5OgQt6D1wfa8y7Rh1STlUddKQm2DBOKm8xIwzY0w1w2N+ypJ03A6mbYItvN?=
 =?us-ascii?Q?LnyiBe2ruzemAsj1ZkKM8LNhY38ftv9ffObHQeRmQNG1TQtjXGr8CV63zWA7?=
 =?us-ascii?Q?434ZEScLMWBRrpWtq70=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:16:10.8394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b173a87-744b-44f9-534c-08de268b7f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


