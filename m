Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56632C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 01:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMHb5-0004ZS-19; Tue, 25 Jun 2024 21:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMHYV-00041s-Ix
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 21:36:57 -0400
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2409::601]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMH8O-0005DY-Il
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 21:08:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENT7zgplO1Ji/Fh4HXy0ggtPEaraClBUVwBuTNh3MpDBYtsPodE16DeEfYGaE3NpekW/JvSJO81Xl+titNfD3TEUc/T3zwzHhDnrL6KRvYP9lR4uPHkI8qTklLjYMtD9pt5014bYQP+4TztlBUnCVvERwXJcn6Rnj9geUdSGvXvnb/sNlzJNaPSS8TV9bXzInP+Pe44uESm4prNah8cyT7IhrHARc033Qk3gSjSO6QxuEgNnHxjfq+kTTNnovblEZ89VyEnuv4gtxr+TAsh+5fUyO6UWsFXEsTe0uY+HR3/BsDgwW5GXVtbyIOFfRTnwI2y4tVy75bwZk5inESnevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pejh5GTymrIgruXb5nqDuJ1Mr+SdU80MfVDak+pNDGc=;
 b=C8prnXspoBg5aln9P9109iO2e2oV7fatsq8eoREE9m/D/j//Nf2ioQyj1JCroobgEdSGU+U5AqWd5veV/ED+venboR22FJeWjFraBq7q2uheIt2+wPa1cX2NMyqAUhNyax8UKFHrWNoB5nHa61wA0mE07RK/EQBJ1BTM15bjm+6DlOo8nmthJYfW5d9MjRvPu7EuPZbhjh9tkmLXiEW39j65jkWW0121yZWqYPzOcgPncJ+6SFVFAly867c6KRs3P5v9T8u0nAfN7zmquCnCcOgU1/lMOdJW/a2pT5N3vGRSqZWqwM1aI0QkzWelvCYptVwK5+VVSHTXjU28XFekMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pejh5GTymrIgruXb5nqDuJ1Mr+SdU80MfVDak+pNDGc=;
 b=qPDMGD83W9wXBLs51nGkMyxPdjBgBFlORjCBfEQ0u6+4T3HUZ+KU8ZtNx9CY/qBmFVNLwutHgTnhzOHVvgqBlmUmXVYz2BjeWcBmtrfytlXVbqxGGEIMAH5SngDBiOQN1LNyCp8XCNufPE0ugE+X7wfH0EkzfsGKflNEX7ZDHaxpvb9sKQhQgi1CX96/3bJNOD3UBgHyCj1BK7h2yc0VoGyGsn5gVZOuWRf5r8seeb5tuJT9eg8xKdsV/4qIKaGTSeHJOXjJZ1ywLLJxA/rxC27UcU6Eod7bKRVLcMIjUfJq+7gMJL/6RpqVV0aNXlDRXesfHY52Eo9kJ+mCAKatCg==
Received: from CH2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:610:51::35)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 00:29:43 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::a2) by CH2PR15CA0025.outlook.office365.com
 (2603:10b6:610:51::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 10/10] hw/arm/virt-acpi-build: Enable ATS for nested
 SMMUv3
Date: Tue, 25 Jun 2024 17:28:37 -0700
Message-ID: <228a33507c1dc46862f61e32a6482aa0b05b4ce8.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0403e9-c344-47a3-a10c-08dc95771313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H0A3BzAy9bv2UWqdV6V9YIfANFD8UPtAVw6wCzGT6LZYlsk/mULwGXOuADEK?=
 =?us-ascii?Q?2Vk4RFcGdJfIZQyQ8lgdQgyY1K6TZezWS2emJIOPtcZBu16CJNNkTC+O0gSm?=
 =?us-ascii?Q?Tq1Y0SShsBpXWQ6CN+FzpazPOs+HnkxcQS+k6Wk7nkXMVVrHX+kXQshfMVgL?=
 =?us-ascii?Q?K42an1/DEM+ex6Cf9xNJts8OfYgpN7I+/nmVaMuhV293CQW9Quw12DYzdGlw?=
 =?us-ascii?Q?I0HBSHSzoFPEbNclTFK0gKrKk6+vlU428jHKteC1DkI7flDdX5qqeExJ9ec+?=
 =?us-ascii?Q?AQMyD6Jm55uznsEzqH6QuogiHLc8sFmn0WOBTLwK02yenq3pjZAzfRoBqJqr?=
 =?us-ascii?Q?/IU+nkEeoPfKI/WZAu2WkH2hyhLttDVNl3vxndx1ifyQNZIG8HAIaom6vXwU?=
 =?us-ascii?Q?yrrhxT72fg60InwWx8vWdC83NWIVC7+uis3jN8MqYD5+Zp7tmQ3/TCj4J4xy?=
 =?us-ascii?Q?uSM2ikVIjZ6BU9r6O3USrUY/TKmOFK6booD5og9bYG15p5KiBtDPuLcITxn+?=
 =?us-ascii?Q?uWGynmODpLinaAMCO1JQ3jxdDBVudJezYCsZqjItetkkz+S7JunJDFcM6+Ld?=
 =?us-ascii?Q?tm+oSVNsSxPAOumuwRrvPM+uG6Wk5PsU9oZ7svR3X1lUReJ/uPbQYro9NkY7?=
 =?us-ascii?Q?XdFzn1Ovd/IxPJbbO20C7ScRzdrkEcOLWth9K9EcOYjZizvbrjuV3jNyE4/L?=
 =?us-ascii?Q?K2m84P4xf68n8sMIfrinZc1DZaIjf8Sr1/RVCYb4hnopVGz9YAHfqHaVncaP?=
 =?us-ascii?Q?YCSX64nWgE0+DOZZAfsyUfC/E1n1fQor2KjCQigETZeGMn7vb/IUSsIdDhrE?=
 =?us-ascii?Q?YMBzpOGC5piqL8vCIBeQYaEXaTJqv/QGDZZZf5om2X0wKO65QDcLgLKvM/5o?=
 =?us-ascii?Q?K5hDes/Cf5pFiJeKYmaQV0/W5HMfhAY/XhTUyL+w3OjpIJDRDIW4metmfMFp?=
 =?us-ascii?Q?BrfY4tp8M0xH4cQcAbodXmWKB6nT/ONyoh1j0/YzzTtSd3HYTzYbD8YrclL+?=
 =?us-ascii?Q?asYwit9qjFVZ3ontA1Z0oGlBhhd2NJ8/SBTXY4g8nLmKvwS31zkPlRy7gHRm?=
 =?us-ascii?Q?Bz1olCuLuC/zJqCQzoisnR6JyIsUrE4PG22NtLCGmEoZhLjyrGVH844Rsw0a?=
 =?us-ascii?Q?sgKLl5r2kPuvOUR84dAcS4SYyx+y17jRIACcfwVSZpSNUN6x2APIy9crQd3a?=
 =?us-ascii?Q?WoAWzviqGp92mG0Ezp4lWCpi9E7oMt5169PAwQ70lB5eiRhhvKxzapgzvp/T?=
 =?us-ascii?Q?dquWcYuJVhF9+oiQLLQJWNvHEALnF7pxP5/tf0ocVqjPrk4wLhwUQ+L+I9Y9?=
 =?us-ascii?Q?nlGLyjCwPT6XVWPLtKPwUjEIZ1yz2AnMDQAaiiqn5w9qfR5eZdJbZ71B4NIU?=
 =?us-ascii?Q?Fmov0CVJdkou8dESofLizl8NrNwsYCZx4CIZ7EGVcxHJ0MrV8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:43.1905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0403e9-c344-47a3-a10c-08dc95771313
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
Received-SPF: softfail client-ip=2a01:111:f403:2409::601;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.4, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

For a nested SMMUv3, the ATS capaiblity is decided by the underlying HW,
and then reflected in the IDR0 register of the vSMMU.

The IORT on the other hand could allow it to be always enabled, relying
on the guest-level SMMU kernel driver to disable ATS feature if the ATS
bit isn't set in IDR0.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6d8b9aea42..c4cf1caf22 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -485,7 +485,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* Table 15 Memory Access Flags */
     build_append_int_noprefix(table_data, 0x3 /* CCA = CPM = DACS = 1 */, 1);
 
-    build_append_int_noprefix(table_data, 0, 4); /* ATS Attribute */
+    if (vms->iommu == VIRT_IOMMU_NESTED_SMMUV3) {
+        build_append_int_noprefix(table_data, 1, 4); /* ATS Attribute */
+    } else {
+        build_append_int_noprefix(table_data, 0, 4); /* ATS Attribute */
+    }
     /* MCFG pci_segment */
     build_append_int_noprefix(table_data, 0, 4); /* PCI Segment number */
 
-- 
2.43.0


