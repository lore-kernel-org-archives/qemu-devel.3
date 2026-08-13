Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9497C5DF66
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuV9r-0006K8-PI; Thu, 13 Aug 2026 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9d-0006Ji-De; Thu, 13 Aug 2026 09:07:30 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9a-0005F3-B8; Thu, 13 Aug 2026 09:07:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VovlAFgDaoyUgFbeVznnxh31MfpnHyNjdG4gbigVUcGNDFJXjrrDDkiZ0BxcbMDX/ithfDV17iUJe1fJd1rGYMd8kCxM0KiWkRdgRwOng0T4gSDYT9rNpn8qfXT2wul/K2GK7HI+CaOQvO7VZ4JmrlfmOcx3XDvZPDg3DpvY2P6O/XvMGJh3Zpi4J7ukL6aUFo770mK1ZzyrOIyh2sawXLYDam8M9wUfXTJ7XjBgB7P5zNKUblCRkCcRhPYlpjQF/Qw9DtRAdtf2C5UZjKD5wLe40V+ZAqiewTa0imJbXG/8/5/RF5Wn8Si4kpyh8ELb1dfX3gpSP4ZHgDIEbmCsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZZtbEB7F5TZsDCRBUKxcst8CtHvtk1q2iU4Jd8gXak=;
 b=NqU5Oah/nWKntr0ZdB0JNAqoxQlOViFJkVhfHCcC1FjdFu2SxR1ADxUToikA2MiTs7+IOeJTgIjCUnd8kxQgJguZBzTgRLzB/LlE5hlwL5XVbPTnfWXvIapvTHb1aTOfbUNpYRBWb2AyeTIo9zS2v9Wl8Wacf+OCG+3a66LYP3eor4DZM1bLcf6vDdExr+z+/R0jrIitxRrxN8pjx4yHMCPkWnIi9uWvLI9VOCZ0pH4DpgasloDg4Hq6JMVpq6bPCcKqk5EZSfFtyN7jVI/hIBpsC+28BGIdO4hdHDzhvN0Ek/k1qnlNmm3hG94NfiVyuECFls/UFqkEOHGQeEOh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZZtbEB7F5TZsDCRBUKxcst8CtHvtk1q2iU4Jd8gXak=;
 b=h3Sd4jccGRUhuHPbnDAMm4Fuj4/a8N/IOyuLBiyhrdAGSUeWHErmDsFPMGcwkLSo3BKrMZbd1gOOjYMQxpwty8C5z1XPobZSyMiSTnfCbQ43AEyN1RmoM4wYDRppFjDQqRJsxb5dFRHAY2euO5X3UXth0KN5SDM0kE0tLJtO9jQbkf9PeqHubsKo1mXZU6soQoTGMZ4vO6knykJghsZl1AqzE2E7stI5gDbEH9WbmaJO6H46yzHyaZ3QPelB0rhDVbcXDUAuz8P6PKw5NHAvNTeY2EiAxsjeSv/oBfEdAQKFwLcDzVo/jwcWo7aOq4t98KamDz2I8b+bI2HPbC/ruQ==
Received: from IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:07:18 +0000
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:07:13 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::95) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 13:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:07:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:06:50 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:06:43 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 01/10] linux-headers: Update vfio.h for CXL Type-2 passthrough
Date: Thu, 13 Aug 2026 18:36:14 +0530
Message-ID: <20260813130623.2499506-2-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|IA1PR12MB6332:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 500c7a61-168e-43fa-d316-08def93bca94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|56012099006|18002099003|22082099003|10067099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: UNLj35yTS21LKBunvRble1Ygx+kSFxerEf1kyB9KWC4gyKYjmf6dBWiZ0ZT7RcpFno7XbavW4cvkSXYSAFCoMcZjTR+zZXJpF387IimkHsmEyorozVLw8Wbw2OjvLxrk2O82NwT6ts52EJSQiUtCZUdeNUFIqQHKR+QuZgafOH/Jz91UeMIskmw2Mjfpi5EMGQYD4YFUQg8xQkTlZTgTTG4kAdJueYmJQiTi7zy+zEA4G/ba1Ngsg9s7U96aGhbQHfEPuhPU0nC96N4zTxvFI4lV1ydyOQPH8dkSjGnzLcSxngyTHV7/qmUHxxk6bfpLIW7LrdS/IQCkUofrF/nvpmtaE62TnzRj6OYyW2FQtRvVFSlLd+zjugzFgmwpOcEFVinNAJjB4/dz2iApj0Xq34lRWviXPxgY2vE7a6wA+5cGqD0D4n2yKXYsCd9ETGewi7cv8He0NWiUYDoA7P3R8nvtrQ3QixvcgixdQ+GbEdZ9crZYEDZHsDI2iHZu5tJ+4Q1uMYmhg9T0A01ntodP+Qanli3+Ko7P9f67upTzHYNEsq4456YFNDzFoax+0cyGXDvqBHRqG8J0dqrha5NB1fMkf7sWEzTA8A0MMTLC8p8vBDC6rdB3bP9uQcxMKvzsLPww8mXVR1McZ43vx6JZvF+7b8jlMsDJyxVtCYpAjNr6pDsPISZgUe+4ljoqhs9F1svWy5RYuLclUG1ONKH3/wzeWjPq/tEa9txt+0vfkS8WkJouwetxdNX75n/ip+v7
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(56012099006)(18002099003)(22082099003)(10067099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6/+WaJcDfltzyFs/u1XwyDu4eNR8qp7OSQJpM9Cg0t53bMDVimHSjSB++zpAoN/GyCfp8ytdpgfBKsx8T62sGhT7RZSkRvyqSkUcxJCDGWztAFJc8O5tNRR7wCXZTvaoLyiPGClJkAeXxCwbY0fK3QgucSC3u5cRJLdTTYr2RuXuCdbj+nZvmkfycwBocA5Hb/R437oAzUyoETNV2kzKllatuCM/5ZFFnDOd9uShsU6WAXRTIJV7zlLOs2eOGZR8pK6m3JjDvY7rxzKPrfq+EL7MLRzW71j3/+cTy/Kq6IXAWVCgEH+Di3AT31Yw9bTqeu53FTn+SBy2eGvklKnX7fVgEs0eRrqelBKu1TJ+TjOWt3ewPnup38FfbxgEHb/Zhddnvhd8/1kKCeLhmx6vQexz9bTDt55qB+ohZjoyQF2G+QvK4y04tLp68DWGqjqW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:12.8951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500c7a61-168e-43fa-d316-08def93bca94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=mhonap@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Manish Honap <mhonap@nvidia.com>

Sync the vfio.h additions from the kernel vfio-cxl series: the
VFIO_DEVICE_FLAGS_CXL device flag, the VFIO_REGION_TYPE_CXL region type
with the HDM memory and component-register sub-types, and the
component-register geometry capability that reports the BAR and offset of
the trapped HDM decoder block.

The capability ID is provisional until the kernel series lands, at which
point this becomes a scripted linux-headers update.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 linux-headers/linux/vfio.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index f3282b8e86..f3e6c94b00 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -215,6 +215,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
 #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
 #define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
+#define VFIO_DEVICE_FLAGS_CXL	(1 << 9)	/* vfio-cxl device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
@@ -345,6 +346,7 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_TYPE_CCW			(2)
 #define VFIO_REGION_TYPE_MIGRATION_DEPRECATED   (3)
+#define VFIO_REGION_TYPE_CXL			(4)
 
 /* sub-types for VFIO_REGION_TYPE_PCI_* */
 
@@ -373,6 +375,12 @@ struct vfio_region_info_cap_type {
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
+/* sub-types for VFIO_REGION_TYPE_CXL */
+/* CXL.mem HDM memory window of a Type-2 device, mmap-able */
+#define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
+/* CXL HDM decoder registers, trapped so the guest programs a GPA it never owns */
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS	(2)
+
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
  *
@@ -497,6 +505,20 @@ struct vfio_region_info_cap_nvlink2_lnkspd {
 	__u32 __pad;
 };
 
+/*
+ * Geometry of a CXL Type-2 device's HDM decoder registers, so a VMM can place
+ * the trapped component register window where the guest expects it. The cap ID
+ * is provisional pending an upstream allocation.
+ */
+#define VFIO_REGION_INFO_CAP_CXL_COMP_REGS	6
+
+struct vfio_region_info_cap_cxl_comp_regs {
+	struct vfio_info_cap_header header;
+	__u32 bar;
+	__u32 __resv;
+	__aligned_u64 offset;
+};
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
-- 
2.25.1


