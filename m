Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC467CAC5BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E9K-0004Gj-AL; Mon, 29 Sep 2025 09:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8Q-0003Pr-Eo; Mon, 29 Sep 2025 09:41:46 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7y-0003s4-9t; Mon, 29 Sep 2025 09:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN5puIpLy8g5W5bnee4DcSw9rF0HPaHGaLXmV6cbY4/6i1UZakGyhNSkyOHP+DNiMGPyQHvcbbL9Stgbw8KANFl/18kls4Rq75V36ZMVqRK4pjcpwNczGHMtRLq/vZsz30Cse7sNioSncOPnSeWT8xH48mFkYh1cgzHy8fh67Ydglk0MPCpQaxkG2TbMgisfgNRnCyTmcAc26kG2Dhvjol8uWAUUSjdZUa1fW/gR3PCr7vxhftxIaFibF5kUiENBqMVp+TRKcMdKGQ1DC7d6oXTJT4f+HFfFqEc5VeKnxMWvjEDMiYBbwGXG3g0TMY/RbXJOjneiHtCSfVT0Gx04Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK2M+KUJTcRWBJuy6aCnq5F6iY2uVRyaY/JHvsYxTFc=;
 b=wuf+uy4terB0FIF5a9eDslKz6T+/ReJaezWaT+OE7Z9bl7vyxgyL3A3UzfP7ZuARUbRQk2pYEOAhKJIYGVrcsieXdJ7e1lCAsAZrUXdAfTJF7jBJoeKK0TH4fBtMbVz3gvR3ONxXhr12Cs0UsMTWewXpNjCSLaqSF+j4tmZj0KbPsLvmBK2wLn+CIO/B4mzq+0w6/gkPB+rwYcspWDbPJBfi5hWvy+e8DXT8q1CWaS83Trsy5qb6QCmktKKuXlJmFzhf0waNS44okGMXeahJHoQTgAmkNx9khDNCsZcZvpWc/DiJXG/5PSANH/mmgLqzrUSoabotZYcOB1AwWnPwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK2M+KUJTcRWBJuy6aCnq5F6iY2uVRyaY/JHvsYxTFc=;
 b=lyU0JOU5vEPr6o22VrTSUzCwCXo6TUgO2eWZkps08W7+TPhuxcluPzkKwN2l4BjsDIq/DK3yP1JWkKIjchVB1Wmrl8kMJKIZmbTAhTmwWsX3JHbpbSOvGBN+xo4LUAbsne/6PuZ5LKAy+Ki6ZQlHwPJ3NW1/azAWfxMtyZczKT41bsSzniKfq3USDeI3FRplJTUI9KmGWhD1GWa9MOh9gFuBN485nKtlLNxHb1XfNn7nLMjZsCKYp4wT2Qj1afWk+sfuTc6ayZJfbEFkv0gVZeIMsi6FdcIQbvBKk6d12sn7dN0U/pZ+gqWjabUB0kDZ4igJj/QOWn+DiW3BHoIr7Q==
Received: from CH2PR14CA0047.namprd14.prod.outlook.com (2603:10b6:610:56::27)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:56 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::99) by CH2PR14CA0047.outlook.office365.com
 (2603:10b6:610:56::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:40:37 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:33 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Date: Mon, 29 Sep 2025 14:36:38 +0100
Message-ID: <20250929133643.38961-23-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd6e2d3-7584-4e26-2b05-08ddff5dd122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6hiOCoQCalwEtMZKQ3izsyDmClMyQITrwZCf2MpImcSrnT7Q/CEru7exPPQr?=
 =?us-ascii?Q?/lnaU8y2F6CaYpgyv0PMzIpZr/zPwlk9NMDoASH5sD46XS2sqRez3Ponwz1a?=
 =?us-ascii?Q?mqu81E02UeuY8GXB+IZYMk9a9rTHyKpoAihx2wAD6SR6vQzNAFEWL9hIpInt?=
 =?us-ascii?Q?6lHKayRBW9ySTHEBdOvlJi5WlsSpgBT4DHrPKJs3+nJRGyttguocIqZ44kft?=
 =?us-ascii?Q?+YaBBv2J2G4CitwK2NmlzN+pgPZZzLkrSQVQt9xkp941LrvgER3bBLYxFtIE?=
 =?us-ascii?Q?0hSR19pIWNCzo0hpBZxmsD0jwMrdPlBEvB44QBs4MhmJEzF4FKCOutYPix8p?=
 =?us-ascii?Q?7zM/b/czo6yn6Zf6qHfLR+/+KagDS/qhdo9U86ruHZkTuwLJXWvScytqK5Y5?=
 =?us-ascii?Q?QEHW/I0jnTWyl57YRb+CtHehYvTXCThukkHu7jcoUM0ZAHLb2NyKu8fUYSF2?=
 =?us-ascii?Q?TvunVKUJS2lu0Z/zg7/r76p7LmAGKREGlSAAkbvwVgypQUOy8zscrE/I1bZb?=
 =?us-ascii?Q?JiJME7Tgj8Zegh9BDppJXqZYqkmt4nOhiVFMax3QLMP4TU30wmWeCiWvj0dw?=
 =?us-ascii?Q?Q/SsOnwHOvyxqCgcmN4f/yrESNU8kH9XpKgau0IBqRpVLk+sFM5Hm4Bw02V9?=
 =?us-ascii?Q?zwI8OdLqctKiT8v41LpKZqIwbUisbMlOTANQCLdgejFWV1ir8AqQ4db21Lok?=
 =?us-ascii?Q?jwhtlW4xnNj1ceA3BY0BvW9hT8cPXHajsVtC4afSoxKW3Fi5A1ivjgDBiBf+?=
 =?us-ascii?Q?Siw2MPH5m5Nk/TT84dhb0cPNoroIqBFC79BChs5Nz6i0pS7L8K2BpSMpRHLQ?=
 =?us-ascii?Q?PaQF7vJVOG9NT1VOipPBGGUx7D8WrQk1SywbDMATORwCJLHUU9qnLXP8a7TW?=
 =?us-ascii?Q?3i7PbtUvQ1u7iGQmw00y2BTBAy4KLxH0P9zcpHbh8pHrtz0ZaL7VuPCDzjek?=
 =?us-ascii?Q?w4lUJP0K0d8kRQhC4COk8ByigQMUD2ht58ZM0Q5SGg4tZ7QTt78kRuhG4LQ8?=
 =?us-ascii?Q?X4O7ERV+lbY+0hKjCaHw/eLSfjcfyAkfgptcgl5cmfQqpiXPgTe+zM012Enu?=
 =?us-ascii?Q?12jv9OIqX1p1swqpPMR8wA36EdkNPHyAxHLdXeDe0/pAGZLxmDpfTb6hPe+x?=
 =?us-ascii?Q?IgHAc9cUvl9UyZrTnheq9qik4dDYSuKt4e8gXFBPzgkI0mgZ5XHOOe/NJNmK?=
 =?us-ascii?Q?jS0gOQ5k4tNSoYUz9MOTgJ4tHZIBpz7ifDhVfedeNnhT43Org7JinUsDGAfz?=
 =?us-ascii?Q?Fbj4ghCO22J6DtNp9PkiRx/Kvb8a0HZl/kxVBo2mobLorDeblNeEubN7UqUn?=
 =?us-ascii?Q?D0kXNCDPnqJ3x5QcKLo4BDQbONk2eqRXKcIr175tKGewsHFjzCRmygZYivG6?=
 =?us-ascii?Q?gSv3TWMRJGw0qCeivAajksDtxb1lK/RZw2g+k7NuvaCPisFGiblEQh8SBUlU?=
 =?us-ascii?Q?W67AFFbrQFPKI4nRQZN8O7llaATDHhGbR9AK8ZtdyJlL1GXsC9RVx1uBHFA5?=
 =?us-ascii?Q?d2yNJemb9wSh++0Cj7jb/xOyPMp7OZkJhFJTZgZI2FToruZ0DR4VvX1JG7wO?=
 =?us-ascii?Q?dLSo7huCEc/AS7yd0f4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:56.0638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd6e2d3-7584-4e26-2b05-08ddff5dd122
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
be useful to report ATS capability to the guest so it can take advantage
of it if the device also supports ATS.

Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
registers alone, as firmware ACPI IORT tables may override them. The
user must therefore ensure the support before enabling it.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    |  4 ++++
 hw/arm/smmuv3.c          | 25 ++++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c | 10 ++++++++--
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index e8607b253e..eee54316bf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -644,6 +644,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     if (!s->ril) {
         s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
     }
+    /* QEMU SMMUv3 has no ATS. Update IDR0 if user has enabled it */
+    if (s->ats) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1); /* ATS */
+    }
 }
 
 /*
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0f3a61646a..77d46a9cd6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1510,13 +1510,28 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
              */
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
             break;
+        case SMMU_CMD_ATC_INV:
+        {
+            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
+            Error *local_err = NULL;
+
+            if (!sdev) {
+                break;
+            }
+
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            break;
+        }
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
         case SMMU_CMD_TLBI_EL2_ASID:
         case SMMU_CMD_TLBI_EL2_VA:
         case SMMU_CMD_TLBI_EL2_VAA:
-        case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
         case SMMU_CMD_RESUME:
         case SMMU_CMD_STALL_TERM:
@@ -1934,6 +1949,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ril can only be disabled if accel=on");
         return false;
     }
+    if (s->ats) {
+        error_setg(errp, "ats can only be enabled if accel=on");
+        return false;
+    }
     return true;
 }
 
@@ -2058,6 +2077,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2087,6 +2107,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
                                           "in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
         "Enable/disable range invalidation support");
+    object_class_property_set_description(klass, "ats",
+        "Enable/disable ATS support. Please ensure host platform has ATS "
+        "support before enabling this");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index d0c1e10019..a53f0229b8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -322,6 +322,7 @@ typedef struct AcpiIortSMMUv3Dev {
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
     bool accel;
+    bool ats;
 } AcpiIortSMMUv3Dev;
 
 /*
@@ -377,6 +378,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
+    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -511,6 +513,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, nb_nodes, rc_mapping_count;
     AcpiIortSMMUv3Dev *sdev;
     size_t node_size;
+    bool ats_needed = false;
     int num_smmus = 0;
     uint32_t id = 0;
     int rc_smmu_idmaps_len = 0;
@@ -546,6 +549,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
         for (i = 0; i < num_smmus; i++) {
             sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            if (sdev->ats) {
+                ats_needed = true;
+            }
             if (sdev->accel) {
                 nb_nodes++;
             }
@@ -645,8 +651,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 2); /* Reserved */
     /* Table 15 Memory Access Flags */
     build_append_int_noprefix(table_data, 0x3 /* CCA = CPM = DACS = 1 */, 1);
-
-    build_append_int_noprefix(table_data, 0, 4); /* ATS Attribute */
+    /* ATS Attribute */
+    build_append_int_noprefix(table_data, (ats_needed ? 1 : 0), 4);
     /* MCFG pci_segment */
     build_append_int_noprefix(table_data, 0, 4); /* PCI Segment number */
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index c555ea684e..6f07baa144 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,6 +69,7 @@ struct SMMUv3State {
     struct SMMUv3AccelState  *s_accel;
     Error  *migration_blocker;
     bool ril;
+    bool ats;
 };
 
 typedef enum {
-- 
2.43.0


