Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9158CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8w-00040j-QP; Mon, 29 Sep 2025 09:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8D-00039a-NE; Mon, 29 Sep 2025 09:41:35 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7x-0003rL-9e; Mon, 29 Sep 2025 09:41:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa7nTy2IGz0KCcEZ8/OB46deR8gyj6mB/LjxGsUPEsSKelknMLxSurHQ45dZq8pl2refw5VLJbXZNcyIJyze9SVr8r9BZH/uOF6nJeQ9+Caq+T06Zd4ww8HKi7yxhW+PyN4rzd+I5G6FQmlCUXVq4FQovqpMDjxZ8ONLXWo+KATZoHLx5jKApL9zxpOiKAt7Zb1iOrWTVUCFwtCpcx+rDD4jQ6NtrfQBihpAoyg6ODkri+FikE7sLMhtbZV770epedKxeieQFAns0BKLjvPon/4PEXXQGluZseJTesrrUcEWNflnoGg5l5mtcHmUtBdRKzK7bUQSKPk4Gu+38hB0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHtfu6bwIbIk8vzEZDtw9Itc8PxW/UrGu95N0de83FU=;
 b=Kpi96+kwlfBSgNSnuu7LDxEydLnHejM/MivHVdrx4eoERw4mwMJb3fdUZULXP+ZqgGOe2fBCuSvoGGdqrlK7ZzRaBnGKPQUQCkrqYsZzcGxuK/pAQnUCcKuiSq/Xn9lcb7/jwPrU16tsliBV4sHBBV4qcgcH3uC2iYuOTiMMVsgPvKA+H4Z/pxgApLj4aUmrGvQdEqCk28AGE2iOXC1eUvks16WcMjx0y6X8AVDqwoY66s8Mk0l4c3E0wFEcG6xjOesBl+9rUXofRfbScXK5aOHQhXjKCFZL9R7jLrjJGT3FcDhCiKK/DqcSQ0cuhtTlPCCUH8KbwXSkm9Yz6Wy2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHtfu6bwIbIk8vzEZDtw9Itc8PxW/UrGu95N0de83FU=;
 b=V7fC4iyzbNrxySJi840y6aCLa+qjGld4ysDxD/o8hGFJRtOReDQpoHnx3N6iwQKS8/qcrtu3xRKKqtzdP2HkQV4/wW36IvKEUE+gBfe09LXIDjLkbe9JoTpvHwX4fRb63o441eXChBxf4wuHV1wxYwpvceQH7Gqy6++PrFC1bpcqwmLuoLxXVKWslsKbjR/W3ywENTN7666BLyW8mxS+mtgpsqtJxvxNaLfTjIQmlZnvhilmJIHUAgUiYqD9pGD6GmU7tLMlg8iUauK3Zg9VXLQ4JN7Z7zRmnz2BABuD6QEorLfW0S+42jBUcjd4zXZl7pwE7n0jYZmP0D7AwgrObQ==
Received: from CH0PR03CA0421.namprd03.prod.outlook.com (2603:10b6:610:10e::26)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:50 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::3) by CH0PR03CA0421.outlook.office365.com
 (2603:10b6:610:10e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:40:32 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:29 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to specify RIL
 support
Date: Mon, 29 Sep 2025 14:36:37 +0100
Message-ID: <20250929133643.38961-22-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f79c67-3281-4f99-d59d-08ddff5dcda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjFNMFEyQllPUjRSZFZxWEJ4NDlDZm1jNGRnUFN6a3BROGRVb2RnSUk0TE5z?=
 =?utf-8?B?bUFsdXk0KzNKY2oyVUFiUitNTmMrVnp3UzcrMHBjN0JmKzJMbEVXUHR3b0Yz?=
 =?utf-8?B?TmYzbzRDa2hkNDBJeEt4d3hHU1pTMmpzcXVkRmNqMXdKNGlaWkxuUGFUSGxr?=
 =?utf-8?B?bHhETEpOdGFsNjJCN3o1NWMveU40UHRjK1o2T1BCdjc0UXdqQm5FRW91YWFR?=
 =?utf-8?B?UGtGUHN5Um9oVDRtN3RETkIwZjVWcFEvOEFmbGw4N1VCNmpJWnhqRlMwcDFR?=
 =?utf-8?B?cmVGNlh5QnZQZ2duNllQRkxTVzB6RmlWNE9FYkRXNjdQUzhkTWpEdlFpb3BP?=
 =?utf-8?B?QkZ5cUtmY3M3YUw4V2JReWYxdU90YUhDSU42YUR4RVo2bjNOYk1pd3hocWk1?=
 =?utf-8?B?MXE1M21qQUhSV2tydVFmaGxkMlFpbkN6anZEcUtMc2dXLzZZbWVIVFAzWWJB?=
 =?utf-8?B?YTdjTG01alIxRFdyNjFWdHA4emlNWkcwSTZaUG1aS295Z2l1TDY5MmdSRFZ3?=
 =?utf-8?B?ZWdoWEtQRnh2bkVOZkR2SmtxVzhDR2VJRUpXVmpENm9TVXV3NjVWN3hmZDkw?=
 =?utf-8?B?OXdUQkZQYW5hWTQ1T3puUWdBaXhuUm9mN21ST0tSNHZUeHpia2UybE5GSnNC?=
 =?utf-8?B?a0Z3Sk9rbEtZWW1OVm8yd0JaZk9UQmJEMHo0RmwwRC9wclBRVFFMZ0h4QjJH?=
 =?utf-8?B?RXlaNmlkUDFQQzc1SmhzSkVRVlhVaU9Nb2xFc0xyNlVXTWU0QTVqOTUwRmRj?=
 =?utf-8?B?QS9mMngrOVE4VnhPYXc4Y3hFbFFWTjVXVlJueUg4c0k4R1pDeDdMMXJKRHk4?=
 =?utf-8?B?WXgyZFJUdFN0VGQ2eU5nclNIT1VSMGl5UXFoSFR5TGQ4UHYvdDQ5NlVqWWZl?=
 =?utf-8?B?YVk4dUR1Qk9vSWxCZXcveFg1bHNKejhqQm5hVHNVc3RwLzNTSGcrR3BXR3Zr?=
 =?utf-8?B?Vktybi8wcVpXNVUrTUN2ZGtBbEEydHo4NnYxME9wbXhrSXMwRDBTcGxGNDJB?=
 =?utf-8?B?Wkx2Qnl4clF4SEpZZUZnSE8zclQxdmtRS1M3bkFuT2gydzFvcmlNeG50TUxk?=
 =?utf-8?B?SkIwNlJ1aWtKRWg1TnJ5bGNJcjNDNU1lQnEvdXpSN0tla0lkS1pZRkY1bkJa?=
 =?utf-8?B?Rm1zWXhXRVFrb2RFT1cweWZBMDIyZXlVV0U1a0FWbkw1dENKckM1aytlRzN0?=
 =?utf-8?B?QWRWQ3RoN3BCaHd6ZzhKc05WVXU2aTU2Y3VnYmppVjA4b1lLM1hLNGNUMkRJ?=
 =?utf-8?B?dkhEZG5tQm9zYTRRbG1BQmhnd1puOWs4N3ZPbkF5YXhOQ0NRU3QvSW1FK0NM?=
 =?utf-8?B?aU9rUGUvTjVvN0hDVXF2cUQ1Zmh1M3Zlc25peUYrd1RDK0hPVVc4S05PUjQ5?=
 =?utf-8?B?OEZTejBXWGZUbmhrdHc4SVltL3BqOGNHTFRoRkdVRW9idFR1Wklncm05NjdK?=
 =?utf-8?B?QVNoN2JPbFJaRjMrWGxGWEN2RlBUcUFSM2JzOEJwMWliNWZOakZkK1FBTnVJ?=
 =?utf-8?B?KzNyMFNDNEVDaXBXMENweVdFaWd2dzlyMnBMUVYzT1FLVEdTcVVaSk9RcWJ2?=
 =?utf-8?B?NXpqemY3ZEVPNlErbjhwYkptL29vWE10SjFUenpuZ2dpUmhFRDl0Z3lERHp2?=
 =?utf-8?B?OU1TbmROY1o2RTZ1dzdyZWwvZTI4R0NSRS9PQ2Qvb2RRNkpQcTNEZFhTL2Jm?=
 =?utf-8?B?cWFHdjBRUm9vTGNYKzFWM0lGQjVPRkt3aytjdWswdWlxTElGeEd2aS9iaDly?=
 =?utf-8?B?NFJiTis4RDdxWkJQV3VkZU1QVHQ1bWhxUU5CSElBdnp6R0QyQS90bHhCa3NB?=
 =?utf-8?B?MHNNQUFZczhrbGlKL0FoVmVFNWdicExZUlFoOEs1ZXY5bDgyUlZkN2xJTnVP?=
 =?utf-8?B?S1FRRVUzck4zZzQzZS9PalE0OUV0S3FBdzFya2ZjcllRajJvZUg4RERzVGxG?=
 =?utf-8?B?WDJjS1dyS2ZHZW9zYjJiUDhXVWZYMHMvSVprdnJScjRXSXlWcGFtQ2drTUxz?=
 =?utf-8?B?Ymw5eFVYRGRGOWozTGp6WnJPTGw5QW5nZE1JenFpeFJiNE56SmM4cVp5TXU5?=
 =?utf-8?B?cVRyb1lkMVFEUnVrK0RxT3ltMklHdWhiQ04wc1Z1N0c4TGFZYmdaeG1MbkRq?=
 =?utf-8?Q?pLVU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:50.1881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f79c67-3281-4f99-d59d-08ddff5dcda1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
is enabled, RIL has to be compatible with host SMMUv3 support.

Add a property so that the user can specify this.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 16 ++++++++++++++--
 hw/arm/smmuv3-accel.h   |  4 ++++
 hw/arm/smmuv3.c         | 13 +++++++++++++
 include/hw/arm/smmuv3.h |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 8396053a6c..e8607b253e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -79,10 +79,10 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
-    /* QEMU SMMUv3 supports Range Invalidation by default */
+    /* User can override QEMU SMMUv3 Range Invalidation support */
     val = FIELD_EX32(info->idr[3], IDR3, RIL);
     if (val != FIELD_EX32(s->idr[3], IDR3, RIL)) {
-        error_setg(errp, "Host SUMMUv3 deosn't support Range Invalidation");
+        error_setg(errp, "Host SUMMUv3 differs in Range Invalidation support");
         return false;
     }
 
@@ -634,6 +634,18 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_address_space = smmuv3_accel_find_msi_as,
 };
 
+void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+    if (!s->accel) {
+        return;
+    }
+
+    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
+    if (!s->ril) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
+    }
+}
+
 /*
  * If the guest reboots and devices are configured for S1+S2, Stage1 must
  * be switched to bypass. Otherwise, QEMU/UEFI may fail when accessing a
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 75f858e34a..357d8352c5 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -49,6 +49,7 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s);
+void smmuv3_accel_idr_override(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -74,6 +75,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 static inline void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)
 {
 }
+static inline void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a0f704fc35..0f3a61646a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -300,6 +300,8 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
 
+    smmuv3_accel_idr_override(s);
+
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
     s->cmdq.prod = 0;
     s->cmdq.cons = 0;
@@ -1925,6 +1927,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 #endif
+    if (s->accel) {
+        return true;
+    }
+    if (!s->ril) {
+        error_setg(errp, "ril can only be disabled if accel=on");
+        return false;
+    }
     return true;
 }
 
@@ -2047,6 +2056,8 @@ static const Property smmuv3_properties[] = {
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
+    /* RIL can be turned off for accel cases */
+    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2074,6 +2085,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
                                           "Enable SMMUv3 accelerator support."
                                           "Allows host SMMUv3 to be configured "
                                           "in nested mode for vfio-pci dev assignment");
+    object_class_property_set_description(klass, "ril",
+        "Enable/disable range invalidation support");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 874cbaaf32..c555ea684e 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -68,6 +68,7 @@ struct SMMUv3State {
     bool accel;
     struct SMMUv3AccelState  *s_accel;
     Error  *migration_blocker;
+    bool ril;
 };
 
 typedef enum {
-- 
2.43.0


