Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10A1CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7Q-0000zy-Nl; Mon, 26 Jan 2026 05:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7A-0000h1-De; Mon, 26 Jan 2026 05:46:37 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK78-0005fg-ID; Mon, 26 Jan 2026 05:46:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miyi0WCUo6zCerbtegQP2TAHp3g5zAUfQoyaYEdv5SVL6BLJVrglR402ODe9J2QYT2RkFWYJeeBXPEnhLCDOFA+f2rrDaZjFoe3Z3oqs54AMzDxjAbd2GbGO76bYZbanx5usaf8pBlTssKqvVqankI2xMSKGRqqTNCPZB+Mc7YOsnyEywilxlglpR6ut3G/jz7eb2U8yyw7aQl5Htr7ruQ4YThV7zzAKnepD1RKN8eM/NZEXqKPWxtDVj3C6IbSXopfhPRm0qRYtTHcQ4j2gY/tXCrgk8xp3w19dC/CvzVNd4zcYddKmWbFZyw6c7JNkxjJXfprlZ/j/i2IvYpOK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr17xfYvG8GllODuWFtLwMWj4+SdmkHQWfMv/dYea7U=;
 b=NZIMvQcrb8+t7VPO0zt1/2egJEgPVZYu29KmLrfwEQgGhonrku/2mRtUwe61dH4ftNQT1TjHTnxDyu3bqG0YOimsUrPsoCsqYRnCJZQ9r5djwbVZF/m5pCQiDEwXDmrQqTf4R+LWMh6tLyVU0f2104ePO4eKrXDa91T1gqe0Lc501nkcAidi3FJnAte2WXeINfo47GXyeXiPryl8pBTTUevAy2Aak6p6iKbVb2g2gjwTMgpDc+c5nQMhGA/dIXvwkMjDP33GcALsPxB2BAlVhycl7llRYg5mmZwY8x+xHyWAaVlayngRFQXH7WzW5tGbsfuYV8pClWV7XORTbpbn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr17xfYvG8GllODuWFtLwMWj4+SdmkHQWfMv/dYea7U=;
 b=A1hEHcEFz80wGEb/8mM0nV8dg7ZsNGv9dd/TWJGIdWgVLTnHmrBe+vHsiSdiTRVYEAncfi9OXtzohe9Jzynp4u/UC+7bYomeduN9pcb+bYq2sdNw1JDl2Osg3NONxOX2TZd9sCRs5eu3XXy89wkjaNQgqnd7GcA+6J+Ztz8ErK3tMN2PtBgFm/lQXiC6DwAmRoBmDzw9417L40blICv0MTTHf/YlXsxMnmNI2a617Ds7/gGpY6jsmGEuBmgPZLd1zH8aBO2PuGkOBADYejPGgi9+fo7BMnFucZx9Z34wSwUAVSMQxn/s3TgkBSDGeL75pwaBbz99JQJd0ztH207gMw==
Received: from MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::19)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:46:28 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::34) by MN0P220CA0026.outlook.office365.com
 (2603:10b6:208:52e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:46:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:14 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:10 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 21/37] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Date: Mon, 26 Jan 2026 10:43:18 +0000
Message-ID: <20260126104342.253965-22-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: 98647f4d-d95b-4967-38f2-08de5cc82920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZRQUQNPp+sPj4dF4a7/Lh7WP1B6WHeijUJXpGgdGY21ZboHFoe8aU9qlUS6Q?=
 =?us-ascii?Q?KxGPvwEVtkMCYnzheIi4Vp2Q/Z8Bi5alSqCyjuHQCZ5O4dio8FxMjstIIv4/?=
 =?us-ascii?Q?AUfekfmStlWZtkpVFFmdRmW41gddNUXC1z9wCmXPC2F2JcrlVSzsd7jum0W2?=
 =?us-ascii?Q?KahDbcprBbDwsfZaMhXD/GfN+7VBa6KGps9hUzKZlY5L+F5KfWjqNLKjt4sy?=
 =?us-ascii?Q?SXa5XD5KDqJ5/dU6ReRaYSqpSvj2pYr2dI2KbEK/9G59Gd2WzMi4vOVuxPFR?=
 =?us-ascii?Q?0LD1Pl6XTzloahRWMayC5JvdXNeauee6vAtr+FSG792UCyIYcm8dzTjE5c7S?=
 =?us-ascii?Q?zGXVHr4ntlGv8b1mtHiwOfbQSZXdizUBkv8J+yLTlAH9gZzfQirE9FwHb7dC?=
 =?us-ascii?Q?g9ohc7kzUd8eCjWbbC3xlK+qRonp8JLvHZiG/8cYea0Dahyx1Ss5jsZmMhQd?=
 =?us-ascii?Q?k52dzJB+xgTzxsfQAjl/7QoKP80LykFY+oMM3osL+wRkJ/Q5ZcmF1T4CmoBR?=
 =?us-ascii?Q?5u9ndJUUJy+v3sHxpHzsVbX5Z2ojcAaLEBMT4Gb99nXZTZWU5um++1SbtZ8x?=
 =?us-ascii?Q?WC8FMj67QnUq7PMWwxszA2bmZpRR0Kjor00Eje1O6ONbrDA0/pGgkpU6qwVH?=
 =?us-ascii?Q?uDDsOE3HB4fuuQKf9LPcdV3z25nsGuFVDEnMyVYvHbh7yUYC6iIFf6gzZ2i8?=
 =?us-ascii?Q?b0zXnF6QRceMzFGAnQawsq9U1dedAd8FG64dM/ETyhsVCYKRuD9nkwchtCzk?=
 =?us-ascii?Q?qrrpgs87Jf57MlCjcXWZppeQECPHgiJk97AVuyKJs6tmUQwkPOfENbij78JL?=
 =?us-ascii?Q?Jk7ZwJU6fwsXeO+AvRV0Re+RtPldKKBDBbfU8ZvBCj8EOn4jBcjuIkBRslu3?=
 =?us-ascii?Q?DTPH+KKg/tX04exbh8AnsXv/rzhMx5cDbufrl98zaub+VKfb4KF1xaRKgzRw?=
 =?us-ascii?Q?UHuqtqukVqacjc3z6I0ftv/oFgMY8iN8GKkq66SBObCkbXXjFnUb4KWH0bgR?=
 =?us-ascii?Q?JMnS/jSjBJ8yc1esbtaiaDm3bOYOBP8eu3cn/ww92ighxSxUjtn3Zz7PHFPA?=
 =?us-ascii?Q?G9VyIDgibyy1ZfPeOARmdUGf1nmiWwsM6GxM5232aFo+nTr8hs38mWzN6/+8?=
 =?us-ascii?Q?NS2soWZfrNIkuBIJjGvMIsVlE3S+c4I5OHd/5ZWELQ5f+IAacDRnKupeN4H5?=
 =?us-ascii?Q?y+rJNZe9Aj2i3QLebBz/KNuH/1GOKiFlDQco5rGDReM2TVMCSTbp13oErhW2?=
 =?us-ascii?Q?PW8Oau9hQDoc09L25yaUpRvQJItT/sNnBhIyTGnFhp/N7rd3y8zP62o5VfjO?=
 =?us-ascii?Q?GlALpIraZ9ii6wzOOpo2L87+bQCYIkDL85Ldlkjas/cYEZvr5AlsUfbUT9C0?=
 =?us-ascii?Q?wjbhkRzAN5mAvRE94fVnLzDIAqJiIplhuuUQt7WMz7EtKIl73JUO1QwEYDCR?=
 =?us-ascii?Q?WPLb22i5BkQz+rPm2fK6TLlxyqPn6MVsuzrh+oCSrKib9rFfA0lPaEkP/F/Y?=
 =?us-ascii?Q?SsQe+QAf1eStsRpR7OXZDm0znEha+s4839IbgEwHG0OsXE0b9SQmBgoAhE8h?=
 =?us-ascii?Q?SU/KcaqXLhSN9bXUzsZXxnT+5iAQN1nDBqs4CuOG+aqJPEKpHyWDw+rF3i/8?=
 =?us-ascii?Q?8Ge8mcO8jlxiaOSTqS9bBYsdjv9H12IfmibRoEnTK/OSuv8CzYNtVTtxP5by?=
 =?us-ascii?Q?v2f25Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:28.4432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98647f4d-d95b-4967-38f2-08de5cc82920
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
features are compatible with the host SMMUv3.

Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
Only the following fields can be used:

  - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
  - IDR1: SIDSIZE, SSIDSIZE
  - IDR3: BBML, RIL
  - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K

For now, the check is to make sure the features are in sync to enable
basic accelerated SMMUv3 support. AIDR is not checked, as hardware
implementations often provide a mix of architecture features regardless
of the revision reported in AIDR.

Note that SSIDSIZE check will be added later when support for PASID is
introduced.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 89dc6f991c..33011962e3 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,99 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static bool
+smmuv3_accel_check_hw_compatible(SMMUv3State *s,
+                                 struct iommu_hw_info_arm_smmuv3 *info,
+                                 Error **errp)
+{
+    /* QEMU SMMUv3 supports both linear and 2-level stream tables */
+    if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
+                FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
+        error_setg(errp, "Host SMMUv3 Stream Table format mismatch "
+                   "(host STLEVEL=%u, QEMU STLEVEL=%u)",
+                   FIELD_EX32(info->idr[0], IDR0, STLEVEL),
+                   FIELD_EX32(s->idr[0], IDR0, STLEVEL));
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only little-endian translation table walks */
+    if (FIELD_EX32(info->idr[0], IDR0, TTENDIAN) >
+                FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Little-endian "
+                   "translation table");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only AArch64 translation table format */
+    if (FIELD_EX32(info->idr[0], IDR0, TTF) <
+                FIELD_EX32(s->idr[0], IDR0, TTF)) {
+        error_setg(errp, "Host SMMUv3 doesn't support AArch64 translation "
+                   "table format");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports SIDSIZE 16 */
+    if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
+                FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
+        error_setg(errp, "Host SMMUv3 SIDSIZE not compatible "
+                   "(host=%u, QEMU=%u)",
+                   FIELD_EX32(info->idr[1], IDR1, SIDSIZE),
+                   FIELD_EX32(s->idr[1], IDR1, SIDSIZE));
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports Range Invalidation by default */
+    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
+                FIELD_EX32(s->idr[3], IDR3, RIL)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 4K translation granule");
+        return false;
+    }
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN16K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
+        return false;
+    }
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN64K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                           Error **errp)
+{
+    struct iommu_hw_info_arm_smmuv3 info;
+    uint32_t data_type;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
+                                         &info, sizeof(info), &caps, errp)) {
+        return false;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
+                     data_type);
+        return false;
+    }
+
+    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
+        return false;
+    }
+    return true;
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -353,6 +446,14 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return true;
     }
 
+    /*
+     * Check the host SMMUv3 associated with the dev is compatible with the
+     * QEMU SMMUv3 accel.
+     */
+    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
+        return false;
+    }
+
     if (s->s_accel->viommu) {
         goto done;
     }
-- 
2.43.0


