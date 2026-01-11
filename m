Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4750AD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1aq-0004Lz-78; Sun, 11 Jan 2026 14:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Zt-0002bf-Ry; Sun, 11 Jan 2026 14:58:25 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Zq-0004Ad-6v; Sun, 11 Jan 2026 14:58:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5g6N0u7xxCsdVAiMpR/k0XDGztXgsmdkiMsUznwfsxBlxtNia/C9X248LOzu1JmAZYWIAn47bLbgRnZfdFO8fPUBbl/5a1AJSb5CtPuLKAr/zHc99gTt0tZFJziAL6iSKyP4/G+5X8pcfLdvbxX5Z9oeWA1hsmMF4tyy+GPA6ZV1W8kRNLxJmTBDq29I4t1/2VXwxANvXNNyqJDW0J8rqdcT63ce2oNkq0YPJf/jfb8LwUG//ADug1aWQYV0EeAO0PuTivkbWuZFsvNGPgy1XKVP+PhDMZoljaKmYC37mJU9xdWCs9J/w1bJlvOh44+4kwONyQ4ww1ASBsZyIoavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbvPX5oSakvB/cajksIu8TmHgw5bMCwFJt4XimrlHSE=;
 b=qqznYDDzTCb0R2Dq5fJYz2vQ7/lABPggLgwDU8M2jBwCRbA+F9p0XhVWa9xhCDUgx2jIG6ITBlJjDUAkqnN91sG0O40Ac+6KkN6MGqzujjZW9NuwNrRcjpNGdmD+gz8dCLvUt0EI9cvkbpZVR80oyWjk2fzFJoG4r7SPxblIrtYSYZSoDdMlDuvHyxbyp6xb5DCvCsB5dNLtevZ8WcoDDR6jBeC6l2DPF+AqmyfzakW2kKxAwZ+9ZZvXjkvRVNPyYuX2NsYTiPN47Q3z9kYx3eCVtr+v4/b9xVZQXQKZhCFIjSEALRCORqKsJ1Uhvt4jCIjBiFWHnEvCiomGaFjsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbvPX5oSakvB/cajksIu8TmHgw5bMCwFJt4XimrlHSE=;
 b=X4N0kKAztU2e07mCLAv11KEnlsrbtLYAFWIQTkqx6Nmmzo/vLqD6gZ2nSqtNVZxJNLJfE3JcrWs4DBnZFmdT0RatCAKju0zukj5ufvKMD0UP8TtzpaCERSMDLfl7nd+FFb1wApHINLbLRdsPvqgzgkEIEZybp9bkgx5BwC1xUAL9mqJ+BWfthMcev/aG1n7NpKIKyFs7ZYQscaDAOc1QJ+P4GtI2WtjrN60RCUrG8z0VtGyIb8SuV84965ciLBQlijO8xEFYM1V15JnSP2q9Ug7Sbh+Wwvle1B18HyIz815Un3ikqVPpEBFImwr7gddRlOErxop+3T1zDvGTo2lO0g==
Received: from SN7PR04CA0230.namprd04.prod.outlook.com (2603:10b6:806:127::25)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:13 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::c7) by SN7PR04CA0230.outlook.office365.com
 (2603:10b6:806:127::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:03 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:59 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 26/36] hw/arm/smmuv3: Block migration when accel is enabled
Date: Sun, 11 Jan 2026 19:53:12 +0000
Message-ID: <20260111195508.106943-27-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 163bd0f5-37cd-4510-21dc-08de514bc0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OZXlb8wXuDf9itCnz43XEzAzqFUCZVBxp6Oy/TIzKm/nH8SGUHZOtn3UAFRf?=
 =?us-ascii?Q?gjzd2IT4mLWGLSs16ebPi0Z3oeJZswDJ8ornY45e6FVl2saFWQe6xlHlsOTB?=
 =?us-ascii?Q?bgPdJEjTu5s3kt07R+t3JyHfsnviBCRLnHpajAEXQFKdy5yZz1szqc8JN00y?=
 =?us-ascii?Q?K4bUFPbwznL07eE8kukVkR1S/T4kYMSB1tdK7qMqoGw2e+Qv419oZLvkhnmH?=
 =?us-ascii?Q?enGXFStQa8qnLZV0rZZjaF9bmg6Ktx9P+qi0q3bzHuQUOXmf/NsbXN1saagN?=
 =?us-ascii?Q?nz8O7lrFb5tSAwj8vJXt1w15CNZ4hHkwpSZbNQmSSxCcBGD1v+g/aLM167au?=
 =?us-ascii?Q?5KcGzPepyWrcZdjChLiV9pIkWKq6k6IcRfUqF6r3Jt1jXU5W0jKCOEp90ynq?=
 =?us-ascii?Q?W9TyjRxzGVlduMe6jhXzJvZap/YmsIzRGKNcVKSrZtaHiJFY/heCQaWoPnit?=
 =?us-ascii?Q?5svpfiON6vXldV/VJdJ1yt1iErpjjUZ2ApXE2aNlVIVNAQ+UIQhlxzUx6mFY?=
 =?us-ascii?Q?tehd5RqcCzAzbBOwHO2o0c2DuOlSSxLz2LZ5vzd8eknfW2ZyAnjq0nsdIERN?=
 =?us-ascii?Q?uRz/uwQGooLea8WrGPpBlDC6oIfGXqkqO6CgUoQNVOx6pRHUo1nLERDtYaTx?=
 =?us-ascii?Q?Et8nfSQwFJaiacgUR/EE0axVI9uUAg4rixdmlcONJZp21wXhP4PpzGZY1y35?=
 =?us-ascii?Q?+doYAP9qKzv+gZjktma+oDKP34YhFYBuBK/Q4s88MynrdqvgoHBccaGQop+B?=
 =?us-ascii?Q?2m7aiKPL+dAQ9wochhpOOQ/lUtyXiQXGYlreIlA4iNZi9EfRvkPFcIbkoc5z?=
 =?us-ascii?Q?sdxZFiE9DDasI7CtSakW+409IjsnZx9DBvkocx21HQL/itsgWNCX7As8hGfj?=
 =?us-ascii?Q?v0ThsBSFzyWSBArD/Q52xBNQuYIlDEEs/lHim8g2dab1XbV4M8LGppOcPcWa?=
 =?us-ascii?Q?H0C0aBWT25pyasewhKAu2C10pkm38BPlVE3pLrnK1HOiyQ2tD+qsmq2vL38j?=
 =?us-ascii?Q?7Z+eRqQRHAbZJO/o1tLAa7xgLA+LWtU7mm6KgNj11+dmKM90pn3oboYib62j?=
 =?us-ascii?Q?TQU0g6U5CQj9ZudxvfGKI4U8nUobVojztYDW97FYUtyNt5gKbfjMSUunc2LS?=
 =?us-ascii?Q?lxggDreLfzTNeiXH+5QFdUwWkl6LaAbOrQsYGkAv5BsegOncFBP4NOTl6UG3?=
 =?us-ascii?Q?Adf1YbRq7vrblIHYHGDFxiyLYVi5vaMskCAIJoi6cPfgcMYfmPOu9PvUBZkR?=
 =?us-ascii?Q?pyfFhW+pXDd66VdPvnEkkQUG/vGCF4R0GcWNq0l9p7AspsFYuob1ycsUVhak?=
 =?us-ascii?Q?1bYE+Qz9dJCJ27RYOFwFcFXc6wSJZ2/9vELUbDF+bjW1dl8t25OICYHXSpQL?=
 =?us-ascii?Q?5fnkoX/8ppCxEU8Nu4kc+tAL7e+TrEPO+z2nWs5ZlFLH/NCVUmDe2/7Eir50?=
 =?us-ascii?Q?mcGmM+j6oAgMfLYLxGhgYGMyrlITZLkNmBth5L0WaKDPriZqyMjjh/dTw81D?=
 =?us-ascii?Q?QOQq2Ql1nZEP7U3E4x2ExZgrt2mBMc26DocotF2KTpVJ9vzHU3D+rtIasAz3?=
 =?us-ascii?Q?4qx+0/ZhhDIytWcPthc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:12.9901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 163bd0f5-37cd-4510-21dc-08de514bc0bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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

Live migration is not supported when the SMMUv3 accelerator mode is
enabled. Add a migration blocker to prevent migration in this
configuration.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c         | 6 ++++++
 include/hw/arm/smmuv3.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e301bb467d..2be056d792 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev.h"
@@ -1925,6 +1926,11 @@ static void smmu_realize(DeviceState *d, Error **errp)
 
     if (s->accel) {
         smmuv3_accel_init(s);
+        error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
+                   "accelerator mode enabled");
+        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+            return;
+        }
     }
 
     c->parent_realize(d, &local_err);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 5616a8a2be..9c39acd5ca 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -68,6 +68,7 @@ struct SMMUv3State {
     bool accel;
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
+    Error *migration_blocker;
 };
 
 typedef enum {
-- 
2.43.0


