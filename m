Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1056C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicUF-0001IT-7x; Wed, 21 Jan 2026 12:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicT4-0007ZL-GG; Wed, 21 Jan 2026 12:58:12 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicT2-0002AF-Ss; Wed, 21 Jan 2026 12:58:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk3vIZEmOr0yYny71mjMmKWLbROZ7Zx1YnfqX4f0PjwRsIbTMJcbZp464CmPgGiVldjeCdruUnMkGt/5hoR2+AfxVeHtQD/Epmv7OA145szqD+Gct7ITwSzM6vexC1lDOCUg9jtvu6Vc1+tZ6Ea+odNAY976Lv2WEX57hvi9XxihZWJXqc/BTrWCwySzUmXkHMIC6y0PkSf2ESwzBwL/oTtIqCD79Y67d9IhUbNqWDA89P2omMHfxoDaPYpS8TykVdu0K0/3M5Pce5qcHvA4sOOjlvrIWIEoqV3bQnMVen1Caht0VWUflO0MBOtpX6PHqpjsInlVUjG85MCxqcwRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uvEMLfnPpjfI4pRy/79USmx/OL3kyxZUOgMXAAK7Bg=;
 b=TJrJPAi8RQ9IC4jOpQitjd8mGEyeLDYD/pdR/VKnTKoKjdoZ4zCAYc8ccbII1Lycs9sXBnPRH6lPFYj55rv8JA/S5WKaOjWrQ2XmnEciPSyfx7kf+axAeWPtjJiLo8IqoXltNorTJVFa0JLJf1DykrseXhf5s3gpuZiT2/xKLHTl+zJSi4sXnlA+5VQmm+1IfISLuW63CEJyfgN4PCBvTazMIhJdnjIIRTgQhkAC+8mz35/aZPjXJfnKhQM8HjdfPXvUuMonyhBFXPcbplqo66dcNVQ1zhKX74O8b4oFk68Lb3lFRygL3izQojKOoK77rOWG3IuPo1ln9xOBcNHovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uvEMLfnPpjfI4pRy/79USmx/OL3kyxZUOgMXAAK7Bg=;
 b=CFU5d8lArWTZMVNF3lljlekcfdw/64qY4Cp6b6aFF8ELWcbHT1NyFN+lWb5mDQpkH4whsnx9/V9mqYW83mfz88p+ToWIy8zNl2mxNHlU8L0HwlRBkOk3tBzblNoIyzbiN9ilIfXPD2NgQ559QcZ10KAXK3i7ww++q+8JeHWkKhpdao8MTO3Q19y9dFGiEkp6HacxG0UoN41DYlO87pUBZfSZRp+M9hXjeunfBdL2ImqiDF9SD+2hwwvFZg+qL+Lnyx6q5rj99vCIJIZX55oTsnjy0oAv6hGA38DfOUhEQInf0tNP/UVau9jnu4nwGCGZdk+4Xe+ZPZtVAvTFnBLoVQ==
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 17:57:52 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::bc) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 17:57:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:26 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 27/37] hw/arm/smmuv3: Block migration when accel is enabled
Date: Wed, 21 Jan 2026 17:52:32 +0000
Message-ID: <20260121175248.87649-28-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb4bf7f-521d-469c-bef0-08de5916989c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IjPq7DbWTly7twHnKF2DcFhu7IjHwjRODDp9kyholupTCHL/dbnK6SCUQtHn?=
 =?us-ascii?Q?nzlydiJ3oqImryP7CL52SbIlj7osHrw5ygvAuWFhhKVOBB7UUAZmei6PCaW8?=
 =?us-ascii?Q?jzR84OdEneJ2hC8vJ8j6d9Udjr0329/4nwYxmGug7fkhMJbqXTEtizkXOJ6H?=
 =?us-ascii?Q?xYIVbBMWfo1Uzepc8BRpNsHB6QxY+6jw4grtkS1xfLkjTT//+v2ZlUIs6OZw?=
 =?us-ascii?Q?S+UvcQz+0vRelPx/0fODLOxF/or98fnCpuKb2B80+eikTG/21fl/r+DxCdSp?=
 =?us-ascii?Q?wY6RMH5U9cNygNK545U693FJilB0H2c5iKhzFb2/sRXRydp0AWlSPJQ3TjlX?=
 =?us-ascii?Q?//qhjmul8lL0/gIvzPRrqQDz/uOPlp6bJoYYjbeBD+k2TBvEZKQ53jWV9Ls+?=
 =?us-ascii?Q?0TiRdZE9JZ6qhYNP0aZsCiFTsryo5X5Hj43/UTDYMkm54ddCHqMbn7QS+b01?=
 =?us-ascii?Q?cNa03FbR/Fcenhp2UOJfsajo7VoE/GtyPYKuMjfHCM9hHc6/lx8egslK/KSa?=
 =?us-ascii?Q?Uk7VF4t8CncVg83WWo4yLNzlVaM9JSm3ZsJs5trsCz+ys/scGjuvcnCF45m3?=
 =?us-ascii?Q?CNvTTy+6MoVyLu1lgg01eaYyQOWhIWtm4smm9yJglGtEIfLo54ho8zN28okl?=
 =?us-ascii?Q?B7pkGX7ZJ4p+5IeUAL6Vyw/mDLtWDtvMIHbp8R1oED0aZgYn8Lv3wLEfm6Zt?=
 =?us-ascii?Q?9gJG27qAngr5JfJ2E3ycRs2ntczj2bMA2BY8VhD3SDTk3Yi0/GRhZDnd1kVY?=
 =?us-ascii?Q?jEr3i2uwWX6lVQrCUitQYV/7jSZPjSYJh2zBfJpl4VSfn7Aa3ia/9gIyFIta?=
 =?us-ascii?Q?JWTgTUlaqxfGBMOi1j5fV8rLHKKy2KQDGe7X7YBhmEixoFtBHt14f4YGEXld?=
 =?us-ascii?Q?xV2tkIZQvhqdTrneUQNXOHJeC2VOTKixIhjHYZZ8CECnd9CPTUvKz+FlhImE?=
 =?us-ascii?Q?bMT+reGE03afZuYGGeh2GEuecTwKpZpqveq3a4Anxc04gvTQw0qgJVHjWDxs?=
 =?us-ascii?Q?seORP4WJyvcDgXEKtolvyXmNxQlz8Vo0tKB/b6boabTpnw6+SvJhT08J3vKc?=
 =?us-ascii?Q?BhnI31+2j7DLKLMd22DtbD1qW3qeT6WFKUNhlpsLXjSCHTES/UugI2bP9rEq?=
 =?us-ascii?Q?Uje6K0rybO4rLIfzQxSXz7fqE8j8mTW1CFnuR0Y7ojw78EpY4sjmwiAjEI1I?=
 =?us-ascii?Q?Ks656g6cKeB4F9xhGjOfbuMNgO24PYU4zGViVTtLNzK1Kk3qg4xAN11lEJcC?=
 =?us-ascii?Q?NrngY+1DoupX7EbHrONeI3hToQ0TBGy+kLNw4bFKKWaSGovFGVboJLIg22mo?=
 =?us-ascii?Q?p+Vmd8zko5zSOBqmXo1GbujDidSgiofNyhx1WkbMki8gEw//n48dWeskxd3n?=
 =?us-ascii?Q?YpTZe5YI/dCKSLPgSpzaLngYRTQim1TiFYb0JxZJPUaCxrIbnoioVx9JbPGQ?=
 =?us-ascii?Q?pwDC0LVtdCbOWE/2byb9BUE7lSWX6KvBIb8pVYFP1Z7ww0lxpT7B2wwG1pHe?=
 =?us-ascii?Q?AiZgZfKhaG4CJUx2QXtd6DTvn2UKizqFbYe07g2LyU+BJ30kP/QcldgTEzIS?=
 =?us-ascii?Q?uaH1NMlhXQeOU30Cjt9lVbmlp+DeGqe2uGtjGk18clXkUTDRfb8shKUtBWWv?=
 =?us-ascii?Q?GGbctwb4ZhxRxqSPekKU+9D2xKeszUoxba2+IgVb8G70+M9w5JCEbtXWrYou?=
 =?us-ascii?Q?Pn0MJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:51.5792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb4bf7f-521d-469c-bef0-08de5916989c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Live migration is not supported when the SMMUv3 accelerator mode is
enabled. Add a migration blocker to prevent migration in this
configuration.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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


