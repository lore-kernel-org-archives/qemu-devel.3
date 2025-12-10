Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBC7D3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPh-0007Wv-S3; Wed, 10 Dec 2025 08:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPe-0007Tq-AJ; Wed, 10 Dec 2025 08:39:26 -0500
Received: from mail-northcentralusazon11012025.outbound.protection.outlook.com
 ([40.107.200.25] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPc-0001PT-5K; Wed, 10 Dec 2025 08:39:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFdRUrxUT0iQsCRjIF4V6hJQshsZWbas0S2rEmwKIrmx0W1I2fimmu4fH/SlDxLeBppN+l2fMAZUCByQ+DyqQbMU0n6NNjsGOEfGi7VUXSrFaNMaS7SkgZ0u6vPKSCcd+C6h4qAZn2OnlD4x6jJG4RrFs7XQT9Pk4c/+t3bAS1ZxZUHkcaPnGQmrKdjbj/20IhYTIPvGgrifDX14jdVcTZk7r8iI6UXjscybmVWo9BxyvljG50Z6q4NNc5Sb3Gv3Am0ENJNkfl9SJFj88HIs6lVR36Xj6iQ7btw4ktu2C2DhYxExne3x4VOfuGM8RdrprjzArmekWB2DyMiPjVtRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFXZ5rWw85DynK9GclXZqTxM5rpvhGYOKAP6oOxZzAI=;
 b=Aod/Z4IWkW+480ON2jBmNmeNS6mvvuNLsVvmou3JIVla9318JnT7r/VhBwBz0mrq/BwIgcKOHNDPXIJA6ipuI8Bm50/b3hDTY92xJZzCOXP0P3ZaZZrNpL1kcM+O9075CApr2X3yX90N/qNj30PGgXE7chxMNOPE1Ts5WJ9pEr4Qy2zbX0v0O1SgVuIbqYIHYFmO5ZajZNpV3ECzbzwJHShlaWZDhwO5OfOelH1I9ZXAAXpIetWzf64tM9TLktYtsXpoguucui//mS3HrfvjOqSJaItqqKMNRoiBgSuiLOGDKmoSYq6b3YWyfFB0t77YKkVod5TzOdrlBcF7kkQBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFXZ5rWw85DynK9GclXZqTxM5rpvhGYOKAP6oOxZzAI=;
 b=jhDg4WYt+Q5Fqh7w9LB2kc3hwWH72DpC6hmcAMCAR4B8YuBVSSGtX9ui7CXOuzy28ir+FOmuglQ9pbmeVJKUzZgB96uanPO6tA276paVdfBvx20SrZi5pi8PwQRN8MBn6uRls7ANhRrMQuPzoX/K+xYFxWkinP84lN2bPTTH/f9a37y+T5qre1o6V4cweea7s9qXcRPCKMRzsdF3qVUitRWlyZ+I0GHR4Rx8fdkLftzPUJ+M3Rk0cdlJCW4pE6k9AtHaVZ2uRcc4v8bhueVrCcrZK3mUvbClLNA1pZV01st2Kj3Nbwccd68Ejk4LiSMl13Ukp4h6ySB9a027IDaAOA==
Received: from SJ2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:a03:505::7)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 13:39:04 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::24) by SJ2PR07CA0014.outlook.office365.com
 (2603:10b6:a03:505::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:39:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:46 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:43 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 08/16] system/physmem: Add helper to check whether a guest
 PA maps to RAM
Date: Wed, 10 Dec 2025 13:37:29 +0000
Message-ID: <20251210133737.78257-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: ba937d05-31d3-49e4-db8b-08de37f17bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AiVx6Kgknttyc4nGOQbEqUcSlvynbnu4kZ7HUlj+5knNY1aLtLPWPYJ4zXy2?=
 =?us-ascii?Q?1oZV0hNL0gHsKqsCzazzrsoLntK/8GVN1HyTalJ08TK4Jo8IM38GUUHhQpbp?=
 =?us-ascii?Q?ujh9nF7vCctY97lZyGbrWbryf8kjTSb4amAln7aon+RlByVulql6az0hqzOA?=
 =?us-ascii?Q?Z1k5MPkL0Xnl7Is6mzU/vca3hEi1a/Ar7+ifoXrODUaXt/EfWLA0ruaVoqAQ?=
 =?us-ascii?Q?F7hs3/WQC+QYPsuHHqXsV9HTLpUGg2BEYCJvVEvskVIHK345TBl/E/5Ip8V9?=
 =?us-ascii?Q?0pY7WmAMg1tRUKNZkOdxFSR+oxnzydTFKUG+rXJasQxDUC6MmXwRW6dUJT9q?=
 =?us-ascii?Q?DU80ZxOUICWxwB0ULf97w72buKPdyuIqmKaUz+4ZtBi7OD0nG0QURokPI6Tr?=
 =?us-ascii?Q?Mp5uviqSNu40l/rD2En7qqEi3KjN6AJHdItFOAfVYRKt7OjoNnHwZNE5KPp9?=
 =?us-ascii?Q?UqEEtMIldwXRMdvQV6advRhxkdFp0QqTFM21fTcthgbXEqLvzOyWLcAQnQDN?=
 =?us-ascii?Q?Y5GYxCxXFC4GqF1VWqm3IDgtUkjc9UqMkqOtOpY9JvA/+0KCLaGk/SUF+jxz?=
 =?us-ascii?Q?srUMOVUfzoxVB/actWsLXf0rFs9ugcBuWBf88PKkH4dttp8qSnLXmpYn+90F?=
 =?us-ascii?Q?ZxS4fSdXR8NtvjU/N4B9btMBuZ5C7ghvNBAn973Z2S9BWHOD7Msl5Bsuds3r?=
 =?us-ascii?Q?1wzMZOyyj6smuP9dboNVFGrC3OTe6HmCjRvD0V7qTdDfttFXCca9BRH7EV0U?=
 =?us-ascii?Q?nL0sHfiuURit3+t4JUQSCAuKSU8ai1rrHc3+43WYrNLk7oYWRd0Z2PGrgqtu?=
 =?us-ascii?Q?pTDjo4PWsZfyDfVJ6f20TMnLafurV2SBYIZnzyjc1/wUQOaRMhGQRkEAuoIt?=
 =?us-ascii?Q?Fb9KEi1RPIY1mqh+H7IZ+3pKMZPbyIqYEtUYUHMgrOJMEuIaGUHJFGNOXxOY?=
 =?us-ascii?Q?pH4QJFx6RCitJ6Qb8j/JioqZF3S+hnf0P09NC4TOgua8c24Voy9b83YDio/i?=
 =?us-ascii?Q?Hx5xSwNjtj6N9U3lrzWoFL76BIW4V5gbJWEegQ2UvIak1GU2sTI9GjE6JxEC?=
 =?us-ascii?Q?5KeGW9e4UA7ZvOVkKH5k4l+rpPYGVJHdoJqMCp9W4ooMAtNj+CtqoS+rBdnU?=
 =?us-ascii?Q?W9+H15nkm37UQ5WBDB9tbDYKy4u1kH6wkKeYEy6CQAkJFv845y6PmJ74Ceiw?=
 =?us-ascii?Q?oxtNERr4myVrSiCLn+BAc6q413wqRFgsBBMAuaTXh4oOKoi1TxFTsdQorzgi?=
 =?us-ascii?Q?s8oMWzTL4+tN+Fpg/J/WRCKgf6Eaij0mv9tZPZHPcviMxXSkOxndBJEIuNwM?=
 =?us-ascii?Q?liubtHzSrhYyGwfBnntQjjGThjCs7m/MoSfsmDZ606R0lAMYj5/YMJrzKPvz?=
 =?us-ascii?Q?jNLXlquu98bol7Sahl4HBTTDIDveKKM6+ZkffYRJ7oTaoLlpscd8GIEcPR/v?=
 =?us-ascii?Q?ubrRgzbL9PmZtrzSmetx3zQ2aXFitx43XLPI8pXDYBANe8EiFpIBEjgfRMcd?=
 =?us-ascii?Q?ryNqYLe4+jDUZkYvQllMuq8Zg4GeYL4RNdaJWN3O+aAOK8PAKoyOKALJruEw?=
 =?us-ascii?Q?alXsXA2hYqQyTW0lW5Y=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:03.8179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba937d05-31d3-49e4-db8b-08de37f17bef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
Received-SPF: softfail client-ip=40.107.200.25;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Introduce cpu_physical_memory_is_ram(), a helper that performs an
address_space translation and returns whether the resolved MemoryRegion is
backed by RAM.

This will be used by the upcoming Tegra241 CMDQV support to validate
guest provided VCMDQ buffer addresses.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/exec/cpu-common.h |  2 ++
 system/physmem.c          | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e0be4ee2b8..76b91d1b9b 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -148,6 +148,8 @@ void qemu_flush_coalesced_mmio_buffer(void);
 
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
+bool cpu_physical_memory_is_ram(hwaddr phys_addr);
+
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 
 /* vl.c */
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..1f6c821a0e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4068,6 +4068,18 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     return 0;
 }
 
+bool cpu_physical_memory_is_ram(hwaddr phys_addr)
+{
+    MemoryRegion *mr;
+    hwaddr l = 1;
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(&address_space_memory, phys_addr, &phys_addr,
+                                 &l, false, MEMTXATTRS_UNSPECIFIED);
+
+    return memory_region_is_ram(mr);
+}
+
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
 {
     RAMBlock *block;
-- 
2.43.0


