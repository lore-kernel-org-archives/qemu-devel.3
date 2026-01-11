Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA3CD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Yo-0008C6-C1; Sun, 11 Jan 2026 14:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Yl-0007uJ-Ox; Sun, 11 Jan 2026 14:57:11 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Yi-0003vF-Up; Sun, 11 Jan 2026 14:57:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjMafYOdAkWYr7dmNtb+4ACgO8DWkFTLkQSfo1vKwkGgz4VPbpDmgUz8xE1ZvhxbhZI/jj8ut33i302hdzJP2G2aD5AAx7kgxTJCkNNeI8ZEmqj9oh9GwJCU5DfpOQPf+lTQnFL89BcI6zXbmIru0MyQlxKS04O8duBUC5dHFdV7OpObsJ4byodiw4eSFA4US2JbKEZiD2ofy3Ntna5LjC7d0DsHWQvdmT9m7RZ94LpnRRBc0M/x0vxHgw+VJCp98L4UaLD18QFX0wls5/PAhNiRRZrBjL7rVfDOK3XQl1ws/gPgVRSLb94JezxsHKZB8QM+DzEvYTty0Gtg/2/UeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+rBkQPpvked2WHBc/9ooXp7YHKIm4ZkagobjPWhe1Y=;
 b=ekhj0LlvTkvphNWQiTAag9g4/iBO4VU0RkfkJWenJ0+zlAz5b50FHhBtXEe/BUNFkaoH/dDmmNQKjWbCQDPhZl4jdzVMjpxTWZ9NxD13noo/Txfsz/gAR4KOFefPcIZrGx5jbPWdin6cj2qZVT7H2WI0lZ2Vnz22GoVuVy3JRMBuhpElbPJGKDzjLC3aZUkfSH/lOBxWeDgSVHWFJ6PiXGGaxouu3z3D9fhUKwqeF2aaekzUbdTxYuzuPt1ony9ce591YACZ/CBDITzmrdm7oy8rIh1X7BCgTAEtWM2ctUrQgG+IEkhpXiHLe+3ByOWWL7WnDJpB+4CyQowyyl3/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+rBkQPpvked2WHBc/9ooXp7YHKIm4ZkagobjPWhe1Y=;
 b=laJt58eOLMeaz0R4UYVk3L1w/4YIj544QYl2n1wly5l5jqMHktmpzDzXZFrGURnmlHMmxsK45l4Auutptd3ZiLyYujlGMNjMJ9Y1E8LR1aBPgj2G2J88Tn6g++Zn4KJGRznYtzhDZ3gZVkhlqosC0C6ClWVD6mU2o02/1W5X1Hj0yrHx4kpAtofZO38In3HV6QUK5a6Rrr6Z3hDyQqZKEW1wOa2pnmJxNQ9zE3Mo9xor4N1tu21iOizKfUUU6GIvqslC+lFSYo0BnaygyOKIclUPgr2vFza/4H7/jyyP07GjX/hgkgjFROQUkn0N53d4KpLJ6WE/3lJtETOCbaZoLA==
Received: from SN6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:805:66::45)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:03 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::6) by SN6PR08CA0032.outlook.office365.com
 (2603:10b6:805:66::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sun,
 11 Jan 2026 19:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:58 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 14/36] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
Date: Sun, 11 Jan 2026 19:53:00 +0000
Message-ID: <20260111195508.106943-15-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 2608bd3d-e22d-46cd-cfa5-08de514b9726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q53pq5yJRy/e02gwBdjqInbPBtHTaT83Ca3HB2qeFj94QTVLyOA5Lpwvuou3?=
 =?us-ascii?Q?54DIc3YqTD6ZuxiaMX9XjOqxA/7R6gDoQD7QrGjwyaeezdl1YEewmyniMFvF?=
 =?us-ascii?Q?Fbpc5cMW8N/UTFj2DezqlYVaylOQVRdnmrBiUVT9OSTe7aaUjZycUhPa7WTD?=
 =?us-ascii?Q?HHa+emi+9HQ68T3U8P0GhI1e57Sxkhzxq0NAezSlmJ1yd9Qtq25ycdhzTCDe?=
 =?us-ascii?Q?kCguJBXS/3R617bZxORxoqkImiLNwWly+ou47MmNRIDcfRMC6UzW4rC4D8Z6?=
 =?us-ascii?Q?SbIaf8vYTwDk7JVQTd35/OVrPAi80lazBxvjtYhh1D0tEilDU50nlofTeAVK?=
 =?us-ascii?Q?E1cq4QNQwYAgBAZMcirbBicSVXyt8gFzsfyytcICgfNzMCt+umcEO/Fpt7aT?=
 =?us-ascii?Q?DtzVQo2ZTxrnhAGWsv6sXpHrB1UaxVsWALVHDiZa2gkCAxpb039YxJccaNJu?=
 =?us-ascii?Q?+ddQ3ugKrFV81sNUQ9tTwCvT5H7TMd8eeLyhnQhLfH9IffqpOhxl7NNPJvQp?=
 =?us-ascii?Q?f9MaxlHu6RNq2nvXcOLMdK28TOTc2Y1+DW9kHwdXU/NSosz6urKU5lopqFqi?=
 =?us-ascii?Q?zAAK5D7BTIxwpXt41GCU7tZvB4lOfGoM9zjvaLGY+B+5JWNnnx9BIjGuhfdg?=
 =?us-ascii?Q?ZIwgQvo+iG0haicqOADMUEJK42iZ+qQ4sSw0/uGLEc5GOJIyciGZJ4hEp2WA?=
 =?us-ascii?Q?jDDor3s92a2FvIOPCxLc0sugoceEIovTfOpdjxtJJ+xnZD+pyR+iK19yb7tY?=
 =?us-ascii?Q?CsUf0AoIW4OSwIY9Ct5jFXm06dWkfrzcO2StTuAat/MCjoZ04KN1W2veoIMB?=
 =?us-ascii?Q?K/k3HUkwcKHwYys91M3PCoJRZduVfbhzZA+sZgL246WZTx9qlYR0KGMVPjLs?=
 =?us-ascii?Q?DZVVaZgdAdxTxX9vI/gF5VNm8GCCNK7Xu4KnInwQYQNjqsJoWImUuPqMBEkv?=
 =?us-ascii?Q?WuGLwEJyPeXPmkV1G7C2tUMWkW6AzNZGTgwlc4JtmvGzhs8+uFADC1VgAyv5?=
 =?us-ascii?Q?sq8rBioCKuptrEO15ublscM4fEd2hv+cTufEEB4QC81B2qG84/1nYjIJJ1iF?=
 =?us-ascii?Q?hrx+PX6SsyzXIWHaXOg2rBZ/BWooHxlTh5ryHL8l8+Zjvug/qR9H/sVgMUvy?=
 =?us-ascii?Q?A52qXoa57iWc8YMj01jLle5pdIvLno1NoxQ5Cp9fThP4WdE5LsEvsP8px47s?=
 =?us-ascii?Q?EDyAZhce2YRDhL0TJqZfkP4IRtWj5yKZuWFRO0ZvUkvJ6Gk1zuouPX2RFg0W?=
 =?us-ascii?Q?spZlBt6DByvFSjHtOk2Om4l9MKsKQKGJkmraV8ePPhg9oFYqQsiNYEEY7jBf?=
 =?us-ascii?Q?epelZwDlT3OyJKx+WTZNDxwm67JPokfz2NDzQQ9qTJP7FMbl2MxqJ3E+fUcI?=
 =?us-ascii?Q?27SyLIE747w1hk4nbr/7MU2MGol1AgtuWF4lQalKCoZ6M0ttiT1TImrGW2jU?=
 =?us-ascii?Q?r/KyhevzPzcYo/KMONr4fLJK95fVRx1OP8FLXFIdIipUz2mvCuXx69pHyd3C?=
 =?us-ascii?Q?K/el0RA3QoxJCH1WiRzEGeJ7Spt058KOd+JNar391mjbOEc8bfyzaWlac2SX?=
 =?us-ascii?Q?zm4G9OjaFcJG93OVpzQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:03.1935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2608bd3d-e22d-46cd-cfa5-08de514b9726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On guest reboot or on GBPA update, attach a nested HWPT based on the
GPBA.ABORT bit which either aborts all incoming transactions or bypasses
them.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  9 +++++++++
 hw/arm/smmuv3.c       |  2 ++
 3 files changed, 47 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 877b7e0e17..c125974d12 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -499,6 +499,42 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
+/* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+    uint32_t hwpt_id;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
+                                                   &local_err)) {
+            error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
+                              "idev devid %u", hwpt_id, accel_dev->idev->devid);
+            error_report_err(local_err);
+            local_err = NULL;
+            all_ok = false;
+        }
+    }
+    if (!all_ok) {
+        error_setg(errp, "Failed to attach all GBPA based HWPTs properly");
+    }
+    return all_ok;
+}
+
+void smmuv3_accel_reset(SMMUv3State *s)
+{
+     /* Attach a HWPT based on GBPA reset value */
+     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+}
+
 static void smmuv3_accel_as_init(SMMUv3State *s)
 {
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 4e20b646dc..c7ed4dce3a 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -46,6 +46,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -62,6 +64,13 @@ smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 {
     return true;
 }
+static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+static inline void smmuv3_accel_reset(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7e29284267..7a32afd800 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1600,6 +1600,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
+            smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
         }
         break;
     case A_STRTAB_BASE: /* 64b */
@@ -1887,6 +1888,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     }
 
     smmuv3_init_regs(s);
+    smmuv3_accel_reset(s);
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
-- 
2.43.0


