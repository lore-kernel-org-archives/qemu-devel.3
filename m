Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0EFD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ZF-0000pq-Rw; Sun, 11 Jan 2026 14:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ZD-0000km-OX; Sun, 11 Jan 2026 14:57:39 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ZB-00044a-HJ; Sun, 11 Jan 2026 14:57:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHTTqpps9lbVokRzk09tgxjB3SUn/Vz4w63Htf9ENF2hoAfItNA6kaOw6PQLe+Nkxn5b+jhb6vxmGGDYV1Z2KDODNInxxwj3TfEg0ltUQkCT0f6Foma6ugTreBUG1xueHwmt/z8ffr4ubVC17QfV80KsPzn3iPnDF7PtebuioBje+xZuND77QsRSm2wi7WKOLW+7ucPT7yGWSyc8f+ePNzeRJZg1RxyNRCd6ui8Od1KK5CxYL+bJD2qrr6mbbJfsFphAM0EQ5hmAhC9ykyupLuqKvQXLXbFg09ouqql/7sDBe+ax1jyynvU9YtUcTdGwkj+nvAYngEQgGK6gszYysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/szJ2Uvxd9/AQlGTiNMp1iKu6hRASrHNpBqOZrF+3k=;
 b=ra9/dkQXuJ4Ym/GGPFvTOUeT//EVtSXSsqKEMiy9MPNUpqzl/Fg0wEETK+n4R1aeyaa8PCxVrQ2ue4+27SE5l2n30pxYwB7jnPk1QxSLMN7CU/XISuDcS47Z5WD4UnezWV7tU4RXca0bamfBiqBcdiDy2DFsnX8q/Y60hOUGMf1MXkU1blDI9Sno7XU26JQ6S0LThyBlYhSTuWqv5GPpZcdTW9o5NeyM3CWTp6LB0Ey4BU3gr2EHkbfXHelgG0UW4gXK88yhLU9wyPbBsOTTNbCw1k7zXo3Uj028jEsdk1K4gmsbWCjQTvpwAiUrCuYviOG1L7Oa6F2lxZOdJXgi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/szJ2Uvxd9/AQlGTiNMp1iKu6hRASrHNpBqOZrF+3k=;
 b=Fa5bBB/EoTrPz61s4USuGpszGvJeflZIELXnvyGRriw3nnyUZDCZCGLAp15CAr7kO+6+J0XqNtcpfFZAjiG8ETmkNa2hgWF01c7jpktPkUKiUlhpcdoHvcXbb97xV80d6PDiVi1falfcZGsAvm0qNSSezijau391umbm3fPXqsrOpFBSgqpcUkE97WVpQVAzlAzg6E9v33Z15zwRYt9+bziPF49KqN72+gHQltajJQNy1U4KTpAkTZKtXhoHNwJkYpb37bVqjJW+RHvfOOKORXkQOargHeUkqGqf+57Ke9OYgx2jxDAoGxDiaNIiNI9Zo1JrdXcac/9HaR7S6zt08w==
Received: from SA0PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:d3::33)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:32 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::25) by SA0PR11CA0028.outlook.office365.com
 (2603:10b6:806:d3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:31 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:26 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 20/36] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Date: Sun, 11 Jan 2026 19:53:06 +0000
Message-ID: <20260111195508.106943-21-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: ebeca5c7-91bd-4f10-8f94-08de514ba834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cIHB2pM+8r9FdX5ws8JSa7VyiU3qY0ohwWMnXIiKTRvpz3qZeGVjp80xFLjO?=
 =?us-ascii?Q?HOTO34j9JiYzGVSOpc36mdp4e6n1Sp/BtGO/1O3CAG8sY5c2bilAkbykYuF6?=
 =?us-ascii?Q?sIgkYI7Y7Y/ssu91K/zk3QuNbTF2G4RlkGlrL68hr/whi/yxFmVEXGjxW4wc?=
 =?us-ascii?Q?8Jm2M8kjlhk39VBWGdoHbuJA0ACK55gKIV+jRUvt/N5z2bRUmiCJQNidO0Or?=
 =?us-ascii?Q?b+ClNZaAQDyoxKwM/N3UO2gdJBH/Ov/lMoZ2dRtv2sD9BWCgxnY3+bKbuccJ?=
 =?us-ascii?Q?rAUvawAf9X9cXL43J2cuQTrhyi/NjqtNZ/7kCioENaEbQPLsdo6UteMXs5j1?=
 =?us-ascii?Q?WvmHBxs+DnJ6RsYmsKptYyOtzf0z3wRk2yD77O6EmkTp3fiKfUmHA7R7IQb2?=
 =?us-ascii?Q?6Khjs5NjfbYPhTN2py282dnv9W3ojvX+hQwTdxCnNMZN4Rr8o6qR86K4Fdho?=
 =?us-ascii?Q?xdmwQZ9np2Bped/CPBiWhMMbV/0PjaWfTfHqO1ZWZurOaKz/+4dlzXtBTdc2?=
 =?us-ascii?Q?+tnJV/P3FXrLIgN/jlKNlVMDkYwewnLRWDzv1k647LRVAPikBuJMMmFSw6Oo?=
 =?us-ascii?Q?zA5DpjY0HmZDHSDhoTE5yNM6LnZeyifPlRa04GtCq5EDvPM/OL6/8pHak+ZW?=
 =?us-ascii?Q?+A8HE0FLTLgCNmMe9WUT3np57spxWWRF+h7LxM2RnWhl9BKg7R6fUfbrGfhW?=
 =?us-ascii?Q?6gC/RN+WL2rZbsx1q8kF5H5dmYLjIvRebAeX9kvwlAoEOYPn03mEqvyAjWub?=
 =?us-ascii?Q?ZEhGq0EyfcFnIodDlNAqZ5g5cC1NF4+fh1l1oZbYjPgIX6g9lyzrV9qKPrFx?=
 =?us-ascii?Q?cdhNjaSe5ZJXdFQ//SYzRQutHTtR9MOScebKeKJoLgg1LyiH9fNOHRk70EDS?=
 =?us-ascii?Q?ma58oTmgzVghOp5QwEv7XzIv0/31AWS1M9MNWB07xgqGnJXC6hKpkhHJdqtr?=
 =?us-ascii?Q?ftrOLf1inkbrTwbV3Vh/kyCW9tlvC8CRX87NUZ4BZR9qYZIVIKfDfzmcFfT5?=
 =?us-ascii?Q?bCQnKuobegrv+U0PHN3xtyBwmUhnUaU/539EHecHTsAjcl78yzr1MPF3FqQb?=
 =?us-ascii?Q?gNN9+K3N9sQLWk6PohKqOwyTMHWyCTYaj9dx80/2IwRbFulxEgfqbcuKYQ4r?=
 =?us-ascii?Q?7Uv/KIoWCjO4kqNpmfY8+/TgRGcWnPAIQBe6SeuTTYfXYOQuYsraTyg9xJUl?=
 =?us-ascii?Q?t8aKMlxd+uSZsqW+/T1E2Cg6dKe7gVWKLG4iZ0bBQm/Wq4nY9ihiiSQzJ4xE?=
 =?us-ascii?Q?1aBqjRQen1GNW+LQAE+3EMzgQuQdFcpemq3tpTxmayHmxZYMEgi+Lmw70f5S?=
 =?us-ascii?Q?eOXWNmvl+z1wAhHq0PMowPPMpu1m3kYogli8b0mFR9ReK2moX5VRwsQ7eOfO?=
 =?us-ascii?Q?YzVMu3q7xTOw5kolnMM0beAxfP10d2Y6c5fXZWYb3PkB84/y25kOixpi+Lcr?=
 =?us-ascii?Q?IJrhh9A8RUzvwr9Mv6CrMtlWBRnNAL8qTy9rrYORFt5+szNsoGZoLj5aEYtH?=
 =?us-ascii?Q?ErK1D7RIrzO1E+Bp8/flpJapw0K0RwuBaeOu+bWesxg7UGrdypKZBX+rQyiW?=
 =?us-ascii?Q?YnmDeR6MKIW9F3vbBtQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:31.7991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeca5c7-91bd-4f10-8f94-08de514ba834
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
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


