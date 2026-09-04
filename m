Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF78C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YK8-0004G1-Te; Fri, 04 Sep 2026 14:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YK6-00041g-EL; Fri, 04 Sep 2026 14:07:34 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2YK4-0001rT-OA; Fri, 04 Sep 2026 14:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfTVMNTUzvkRTMinfCSYCH36CX1bEkPnj/LM2nsOcP28XAqg9h9hm2uQNR0naIQt1rmN+n6oGA0M4/mgSyWhuOhREkM4OXiOZG8MZ/ikLnIm4LmiNpIqinaq7FXgXC+DReUlJjOFSKyKv18oD60VyONdD3n+Jv4oIl6s6rDqKEWx++ib9Z0bCt0dMnyXEr/fEH2WIfXebg+aa2zCzmff7+PdtkXXxXBiqiOX3kdNLWnfiTG+/QPYx2jkQ7rpFYCkkMTiZnqvAX2/faPGv9xvwZIpqOJz6+dTCYCGUCIj359h5zgP4NUEgdqAyf4OLEElsHxxzog/AQaqPXiJH7V9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya3kmp1TAJeHUwJEYs7QrgY3lu0eCVB3cVXL7VZ9ycM=;
 b=tJHAOLGNdKiKAsFyeMAn+hQA7AnwaWYNRkYchTGU7gmaq+fYzoMWOwE4PSdybrqMAfAVbZdK5Gc2MLWeC9FopxuFaI6aMf0zOowgeiXgTKCyRBogRClUDmfPmMWbhLGyTEjEvDce5h9kw1GTPMVOCqdLFOzXcEMGYm0+QHswVNPQETjmm6FEoDT5ZvRoqTOsdFgT/jTI1zr0jxCSrQ2EpUkTD6iP+NZIYxZ2jpA7yqi4M4PW0s2SVwKicAcjvOHZMZnVQOn8lUEwmhEUYpgs06QypXofW7OpzwMOdU4jpwrsk5CX2Ci9YRTUp4GsSJMSQq2hYNVZGTnY9pyfiQ447w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya3kmp1TAJeHUwJEYs7QrgY3lu0eCVB3cVXL7VZ9ycM=;
 b=JCrOatvcsjnSssCKeqt6hHrfz8DyWzkFmqfBKwu+e5hat8usoi+d9SAKjyRrQgaas85fD32JlCIjCX8hAdJgP5e5O/zxrLa8EpLrYfmn1M814pcXjxFbdZD7g5nvzGraxOXHv8LWbndBcDdV/sfK6z5EyeDnaGzsD4+BI2w7sbqkisOHOH+Z6qlIhjltp72bwPdIH/dmRy10CvPTe8gNUx1EGCiMAZvEbhfuj3Z95WY+5L/0eFCFcLhXUNSJIouT+RuH2MzZA8oJ7yfrYe77N2pgheKRfTpX+L6fXiyVsIiw7+1ExUEZA72hGMn1tw5oxgLdH2TKHmDNkv9Z3mzLqQ==
Received: from CH5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:1f4::14)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 18:07:21 +0000
Received: from BN5PEPF0004698E.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::8e) by CH5PR04CA0021.outlook.office365.com
 (2603:10b6:610:1f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 18:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN5PEPF0004698E.mail.protection.outlook.com (10.167.245.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 18:07:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:50 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:06:47 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@ziepe.ca>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <skolothumtho@nvidia.com>
Subject: [RFC PATCH 7/7] hw/arm/smmuv3: Support migration with accel=on
Date: Fri, 4 Sep 2026 19:05:13 +0100
Message-ID: <20260904180513.248396-8-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904180513.248396-1-skolothumtho@nvidia.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698E:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c5b356-e1bc-488d-a46c-08df0aaf5c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: FzfwyqpzwjwD73Ezg9P0QPhVcKqWZX2J+kB1WX2GSPhBH2vpHDcsRv2NeE2SNUDXoJG5IHtWSqVFOFapukA+yFbM7rFy9JGkuV43Xkr93f2c3TSOtSvP02gQG4PJnt7PTwkvP62GMDEgF/GBvdEAS965ZWYWPza5k9si8TEgnQniYAKATKWqGQYndQrz9taqj3Rf9IN61PY1894zOk0wHDfqbCD2L7EPvJRAYobTt4YQouHJerxBIi8T1M9Ml69nR1I0XKjBCLzk1+Zh1DolxIiwlGdXt9q+aNpBYGuRC89F8sntcBAE2NJjbl0MAjjQNQ8z0Ko4x4lHYLLh79fh1iDJa15kvDVJ0kxcWb1CU+fWSWM2MoODY/o0dz+TiyN3CImPqbF4ZwCksuSaoE/CNO6e+SabKh65nIWaoubrMBRO5dZlK7bJdJvfyHURJ2092nlKrVeixkxYwbLYkYiaEbb2augWCLM3Fgq74XTple1yvaLyNWUQgcYIwXdTT4PCZi56K7oJ6ukhb13/Fy4op+84ME9thAQVKvhOEP9w1O/mraSY040PPnH6CUZdc44+FEbNoijUWDqh/H13U+9j19tBWGwin5mFhNy0wQrn0L4YAdoEq8IYcAMAGeny5bRuevXCkmgdAq/chhoExbwZ65fTCxIbopv2ZVHt1SpUnH3+xIhzUlreY6ILNznIVBJdA4uTSebiTn7MPoXQ3xWIpg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uWYpHxhweOR22Y7N613lpmq3q5nAOHaVYsACYvG6G8EWUKHt4pS/L1B+Nm0PS8wsgL2sIgFx+ScUGrIjXPiZZ8gdH9cTKSmgtngAeZNtnaxMeiHa/zeHveIRx9of9Ni7xDnE2ZX2/CQtiHfR0EH2xhEiocHkMLGRifYdPQCFgs3DyBZ8Z7aMm2pEJiF8+rZIVSxCOjrZrb61EKRzxHpvIOIlyA6Sb2mqTLAvvw52bGXTqeC6AKh6jWfP/z+8klgTsNwPGc+KVQxckr0dm3KNd+y55MiOJuD1NhSM3tM0+nvIOgAYFNICOQvV+DzklSHTaVowSVL3mqDJmGGE8m2479LupSFp0kLSatYHk1wLiVqXfy5/9PrBJ679DKIO0400ABdSaLV88ev+a6gM1CABS4hSlOn+M6MInn3+KGgTq1IVv99RFjni4w/Zr/eLnVFF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:07:19.2561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c5b356-e1bc-488d-a46c-08df0aaf5c55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

With the restore path in place, allow migration of an accelerated SMMUv3.

Replace the blocker installed unconditionally at realize with one scoped to
CMDQV, installed where CMDQV is actually selected.

CMDQV migration support is not enabled now.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 11 +++++++++++
 hw/arm/smmuv3.c       |  5 -----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 3f83b505d0..5456fd0ae2 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -801,6 +802,16 @@ smmuv3_accel_select_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         return false;
     }
     s->s_accel->cmdqv_ops = ops;
+
+    /* No support for CMDQV migration for now */
+    if (ops) {
+        error_setg(&s->migration_blocker,
+                   "Migration is not supported with SMMUv3 CMDQV enabled");
+        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+            return false;
+        }
+    }
+
     return true;
 }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 66d95e1076..8e8ca341c9 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2047,11 +2047,6 @@ static void smmu_realize(DeviceState *d, Error **errp)
         if (!smmuv3_accel_init(s, errp)) {
             return;
         }
-        error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
-                   "accelerator mode enabled");
-        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
-            return;
-        }
     }
 
     c->parent_realize(d, &local_err);
-- 
2.43.0


