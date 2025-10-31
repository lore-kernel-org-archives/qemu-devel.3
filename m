Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB3CCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmb-0006hq-QW; Fri, 31 Oct 2025 06:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlt-0004bO-Bp; Fri, 31 Oct 2025 06:54:22 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmli-0002yi-FW; Fri, 31 Oct 2025 06:54:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVsSzQKn2QU/m7dWDC+hHyJBxf/v1w1mFpNBjUvEyw7cbOf5QHmLQUdadEghjCEyEo3yRYViqMGDBiTFbUwaP56Qdr4QPxLjpF8Q3SEIRFeF881jPNMWUIp7K/EHFyZs2DKSNC4a3iyKdg4wlCMwx1THZfyt3vn+4UsaITsRHDdl34nPh4LUzbI3U0ol46DOaC+a4pXlu388qwdDTCxHIrSkrrp4FBrNXY9SuL1lRvNzgucxnxn7JwCkS12Z4ezIkl2aJmWYGJAb0ngmHFtSANn+JJCdm8MaLZVZVOCjJQjpsofRtMgbwCdL1DIHyfqwFOQpYf0pm7RssWwS3louxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBshBLrBLQ7PW3X9kfcNX2QLfyNZMDHiUhVg0U9w3J8=;
 b=l7XXwyZYht5al1f8TiJpyDIsVDDMhaFy/3CqNWKvdjaOOr7h0DchGFj8vlwXYz0ZlhkKjiEljeE80hNk2hUVl+ejT3ggCvVHcqHaWiYC3ztQ187lhafUaljVcuM8K49IQPXZC74XhWpgAxLan7RWyDsXMiVTfgBamwVsoeU+iYr/e5g1kprVY/Htbtp1pWRT6SEpkILCyuEpWkKAU6SmbHKzsf1q2czZdWrRHHNWNd/lskJxAvdEsLj1cmf0HNQ4sUzR3ZP/8FHy9Dfxhle4CQirxYFzwIKiibnhkXyCEdoBp0d8Q+Qa/eAmNexbNgGgD5z7gpVRSLylBdXjRqZ5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBshBLrBLQ7PW3X9kfcNX2QLfyNZMDHiUhVg0U9w3J8=;
 b=ZDPeYoy7OsHV0puV5SPl1QQgH/+okTDYP6WBJ++/7RZX98a4duCQjHoTOlS4OLnybE96cagOCUEXvfK6QJj3/xV/4qFQDk60pgdbkzQ2QJJHtXO4TLPGIyr12TYldpguCpwqhEIpb5kfQfQu+rYgO2xA5AKVMAdSmUZU7gi2C0kJV2XQNkSv6DlvIrfZ5QT900vxfj2ptz6cvYY7ql/tNRAWYyehzgTOMenZe6J4wAt4y9oVavDUTQjoudtdKCNujRmq2kn9R26h1gndaVgHcWzPUf0jMQIpjjgdsZCLhX7DdUVwGjGTCJLgbhvKbaIWPlhyGIHt+72+VHCwqMSDIw==
Received: from CYXPR02CA0027.namprd02.prod.outlook.com (2603:10b6:930:cc::17)
 by DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:53:49 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:cc:cafe::ca) by CYXPR02CA0027.outlook.office365.com
 (2603:10b6:930:cc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:40 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:36 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 14/32] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
Date: Fri, 31 Oct 2025 10:49:47 +0000
Message-ID: <20251031105005.24618-15-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS2PR12MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 240fb212-9f89-40fc-f6c8-08de186bc5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uvxLQ7ChOugwktSvc3DuvSg1dp8/8nMR66hu97MN7wGgOe4JitlrF+d88rd+?=
 =?us-ascii?Q?qFvdrBxqUUrTvaN3Uup2gGHpA52zTI9NblG8ltVbohz5WXdvULDwJHemb98G?=
 =?us-ascii?Q?miitZI1OMgAMRc+fl1J0gxaQg9wQd9ADfngCWh/7cxRkhwJu5wShkVJxTyiw?=
 =?us-ascii?Q?Aadl7jC1xPsgXmb55pDwybijccL+KTuQVxzM7xGwvWTG9xXGAp8FMdEvpk2j?=
 =?us-ascii?Q?kN9cAJYlbTtdUtxMgnpIqZohN9rtGLypPRdVBUcOA/wtIGh3CWZyDjl2eXbJ?=
 =?us-ascii?Q?rlblSi8FK6RNQLUSc/x9jicZmeE3kJxmZ7UcFSgm+/Y58wOtXMHzxbQRPh8v?=
 =?us-ascii?Q?2fuWfloqSWdvZuEXPdDbAJLAR4zisd39TP+JhLCjXxwLjyJUO+b1+O61UJ0X?=
 =?us-ascii?Q?TwTDeITArfUP0FGR0PYOz2GfjnqqleMUe30qt6N2693jywPDWihc7U1d84Oh?=
 =?us-ascii?Q?0R09kyvqgonnyVUQwsLyWams1UevnRoKDHly08GMt3PWbN6xIV1wmGq7APC4?=
 =?us-ascii?Q?CXLKf2014d2lrKp4WKost62yLmh1gQRUhj5AfglGFO/m/le6g6suXqq5xx+P?=
 =?us-ascii?Q?0YbBpeNLHRWS/02K+Ow0U9q2VI6FQekmkQ9NKaJow30xVtIQYlPbM5SZ9YFz?=
 =?us-ascii?Q?j9qUh9LqF4XizcFOARnhC0FB75yoHE09ZGhQzeL5VB/0vuwMHgKGePW5dS/V?=
 =?us-ascii?Q?MBU3u/QL5NeAiGDwXYNBS9aO29UKJwqfg8af3RbUi/gXIOjcTi2ljUqGuM7x?=
 =?us-ascii?Q?KuDMmi8bJSuYRY/DMqJP3evDGSQ787SZlhE+ssPEBKxKvPvN4JBi6+e+Aw4J?=
 =?us-ascii?Q?MBN04DkQNBrWHwinff7T2pgkkCfDHXuS2abzym7sxTs6fXN17IHF9U45S5Jb?=
 =?us-ascii?Q?OnFGsVNDPG6ofIaH0XVm93zaJLt0qgk8skgV2bDqPcVVl3AkaWUKFMeZ46sv?=
 =?us-ascii?Q?mfIm0pRdyEwPp4hvmt1OvobhYzsklTUKzbdmfnEOtbc2ZpCLmsbGrTeJQgLr?=
 =?us-ascii?Q?MpAI4zEniqxLdNtFhv6dc0Xc5/ByU6bRLaO+w4VwZbLZUL7uX62FAAELRmWE?=
 =?us-ascii?Q?aNwoez5iK5c+Ym3/CEvfxHl33chsiU6wPqWl3lt2dMno8ks9RCG+R5RG9AEL?=
 =?us-ascii?Q?FPktuPH4xWW0Qw7lH8cr3ZtXqchvkbJihg1EHey72AAKaC6wtgdiPvLC21WC?=
 =?us-ascii?Q?esv0sN96Xr8dJkMFkyrgShFt81TFgBlFMd+onagG2TYZH98MWNQbDwmcsQqS?=
 =?us-ascii?Q?nxxVnE9jUflKxHixBTe7RixM7Ng34WQA9d8u0I5weBV4Tm02+4Pk1xjC/PPy?=
 =?us-ascii?Q?sq6RKyNktE43OpAvAyWJJWmDfEwsnOiwFoo6C4iXyr1ejXUKlbCq22erkclH?=
 =?us-ascii?Q?zRtWetFP+ITcOgTYWe3P5DlHDELPgw8ziHWK53TQigc43WQqtaNbWdxu3ntB?=
 =?us-ascii?Q?JIiiXIeDN6arosYqeLenCW/FAxxrdPc+rbQogUMRn6MQMgBFHdNA/3uROlw3?=
 =?us-ascii?Q?gVFlryZ2He7yMJbyJxqO1n1S4/wRt9yRMhgVZAH305yq2LEljCA9pMaCzFlO?=
 =?us-ascii?Q?gtjpHX2FLkmXhQhKZyY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:49.4483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 240fb212-9f89-40fc-f6c8-08de186bc5fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

When the Guest reboots or updates the GBPA we need to attach a nested HWPT
based on the GBPA register values.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  8 ++++++++
 hw/arm/smmuv3.c       |  2 ++
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c74e95a0ea..0573ae3772 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -479,6 +479,48 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
+
+/* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
+void smmuv3_accel_gbpa_update(SMMUv3State *s)
+{
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    SMMUViommu *vsmmu;
+    uint32_t hwpt_id;
+
+    if (!s->accel || !s->s_accel->vsmmu) {
+        return;
+    }
+
+    vsmmu = s->s_accel->vsmmu;
+    /*
+     * The Linux kernel does not allow configuring GBPA MemAttr, MTCFG,
+     * ALLOCCFG, SHCFG, PRIVCFG, or INSTCFG fields for a vSTE. Host kernel
+     * has final control over these parameters. Hence, use one of the
+     * pre-allocated HWPTs depending on GBPA.ABORT value.
+     */
+    if (s->gbpa & SMMU_GBPA_ABORT) {
+        hwpt_id = vsmmu->abort_hwpt_id;
+    } else {
+        hwpt_id = vsmmu->bypass_hwpt_id;
+    }
+
+    QLIST_FOREACH(accel_dev, &vsmmu->device_list, next) {
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
+                                                   &local_err)) {
+            error_append_hint(&local_err, "Failed to attach GBPA hwpt id %u "
+                              "for dev id %u", hwpt_id, accel_dev->idev->devid);
+            error_report_err(local_err);
+        }
+    }
+}
+
+void smmuv3_accel_reset(SMMUv3State *s)
+{
+     /* Attach a HWPT based on GBPA reset value */
+     smmuv3_accel_gbpa_update(s);
+}
+
 static void smmuv3_accel_as_init(SMMUv3State *s)
 {
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 73b44cd7be..8931e83dc5 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -51,6 +51,8 @@ bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                                      Error **errp);
 bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                            Error **errp);
+void smmuv3_accel_gbpa_update(SMMUv3State *s);
+void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -67,6 +69,12 @@ smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 {
     return true;
 }
+static inline void smmuv3_accel_gbpa_update(SMMUv3State *s)
+{
+}
+static inline void smmuv3_accel_reset(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 1fd8aaa0c7..cc32b618ed 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1603,6 +1603,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
+            smmuv3_accel_gbpa_update(s);
         }
         return MEMTX_OK;
     case A_STRTAB_BASE: /* 64b */
@@ -1885,6 +1886,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     }
 
     smmuv3_init_regs(s);
+    smmuv3_accel_reset(s);
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
-- 
2.43.0


