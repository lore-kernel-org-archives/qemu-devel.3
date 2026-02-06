Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7FEEE20AC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNC8-0003DZ-HH; Fri, 06 Feb 2026 09:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAD-0000lp-Dl; Fri, 06 Feb 2026 09:50:31 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAA-0007PD-2d; Fri, 06 Feb 2026 09:50:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax8ijNN/ya0GqMXut3A+q1wJqanIKDHvSqtRLmi3UeuazaxA5Fr2faMWAOAuOZrjdZgrs0QOv5FqgPlPh3niPtYebdf5RjXP5XSp4iyhb0ZEnjjFwb2pXjbKsKLC6kjvoVs5CbY+mnIV5CjB7hZpoFDTWEbgKwGZ1OMWprVPo0Kz54lO/zoDwH2HfB7zC8FOL1TiTu+Lc12FxHUSL5AukGN4ZOqR2zhkHvIGJ4spvGK4FnuANCdTce/J1r126wwZNHyy8wcNkXnVyF0/n/wrcy4YOUbpivrhdDlMSgmMe0fkea3FzBcW81nLiNxkuaNVBrFuy5RyUEy71oFMnlD1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX/fn9XwOaZrkz0i4/LBZlykgUdgYiMzqMzOrxgLEyM=;
 b=qtGGhw6AT/Bc3rn7UUzcRe1c9jlYurjefside0VepGv2w8dJoynnvBWp4ChmWAwe9wjUemLJ7qj6axnToT76OZozfadjkTjsHuZf6xxFsqCFE7t106T1G5PNsxjGHZheGvJsuOmK1iKqOLq8YVA+AcTjKC/6Jja0EtXXZ/Kaw4JT2aYpU4dRXsViGn0FhV+7/yR6mnv8QBHK5ZW/uj5jkFkvS/zMKW3rRi1s7CLt4qwXSprt0pDD0yJywQSLmlC44Vtx5akj0EBld/UPK6hdatv6LnZOgd+bF8EPww1zGNW6b4XGuyeJZWR70DQQpPcfzkRUOJ8CAoqFPVONApijqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX/fn9XwOaZrkz0i4/LBZlykgUdgYiMzqMzOrxgLEyM=;
 b=QEERSAcmRsbaqbBFLa87GocSQ5w93NxYHTg1u/DhHv81AxIMBFdNk9xFCYthRbW3cUFOFXfzE4+6xmrkG4exQUM5rm2aS/Oln60Vr4C4Cc2mHguyW7DZXgGg0nU8Pveuu6ZRIAJssVM+7Vkzm3tUxw8WgAVUD6RIfSHVn/RGqXUxoH9GQxEX6MrGJmpRL4+5N4//Ukn4EGJksyxbaMXEzaTVl3fjSCOq32YmnRdeYRsRDXDdSt1rwvwgyB7aC8pq5jZuGWx/cwAsSzMFmctPC9dr66ksrH+POnGocPxCIRdUOgq8ksYu6aQVBm4uQVoD9+uQpBi5uJ3NDUlN/wi5pQ==
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:50:10 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::ca) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:44 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:41 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 10/24] hw/arm/tegra241-cmdqv: Emulate global CMDQV registers
Date: Fri, 6 Feb 2026 14:48:09 +0000
Message-ID: <20260206144823.80655-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: e96101e7-8982-4862-403d-08de658f05fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P1nTE9WEJCCP7/B6vduy34WWBFokvPYvHbt6napuJ+NF5SHzKeHNubEypcg+?=
 =?us-ascii?Q?naqePj4i6c3dBwU8cxmrMJjLvqJA04fl4+R1heKL2ysf6q7wTzoiiXquoKew?=
 =?us-ascii?Q?l3F/Ok+V67J9tSKP/lSJ7wtKFlYh7cYDtKeF9CGAS4FZ8+B4HXX0Rki9nf+3?=
 =?us-ascii?Q?F55g5DAKx6m2dESM5NKnogTy6jERcCsHpaMhBE3Vif7IBaX2n1i16VP/sAWN?=
 =?us-ascii?Q?Lx3tQYht4qpkMDN06cxRizlTOrihcFufdtYPmSXKJkLY7VDkhGO7ZBlmsPBC?=
 =?us-ascii?Q?/wTpXtutOcHMWtR3sYJkYQG/AoMGyo71oqSfmqjpjMASOzJ9/h40n3TG+tNq?=
 =?us-ascii?Q?jukbUbsnXdsRqHIaJ9PcMpd7z+oY8QIR1RcYx84tNrI77mZkGY5a5F0dNPv5?=
 =?us-ascii?Q?pkjwv9ZqQfE87ynigMHJayB7bTPG+YEpTtwafV/55vXlBFsLehrHZdzZLmL2?=
 =?us-ascii?Q?Ez1RSAGXTCY27AUEdY3dS0q9/fqMVqvE+/ZexaNa9z8zQSehf9A7d4Iy6DcP?=
 =?us-ascii?Q?FReUUkMbtJYV0R0sgB2vYs2v2HeKu94heW6WE1juCOahCJMP/NRAgrwWgDgL?=
 =?us-ascii?Q?JM1vvmsj1qy0x4VR9wyWiBe/5dESHsQDLcFMNglc2wq0P8p+hYLWfualh3f1?=
 =?us-ascii?Q?8DUO023MRuYzHxJOK1fTcoEvDWWPx91Cv641HliipYESCrv/fVBmo4nC3UR4?=
 =?us-ascii?Q?G3tJ/ct6duiMzbWM5H8rCK/Sc3Hdk+fFz2Ue/qja2YMQ/GZzQRInJ7m/aOIl?=
 =?us-ascii?Q?s2LrJ2LMNLae8ZOuC2uGXC1XZAUedYDJ7IYl19luTqDoMHwyH2obxR0n2Hs1?=
 =?us-ascii?Q?p4SFWJd0qwafRaXkNNn/yNqmaFQisbIgdgHt2JepMKaRXGl4zJBdz2DT8hf7?=
 =?us-ascii?Q?wNZ2csvj2iwcqSDyU1GV+k96mLjhS0avez1Pi7QHxNm/3t09hMuTkXhvn9s1?=
 =?us-ascii?Q?aTbtk6dWKMjBMrIckAWdO3IpoglsN0fpCvtnxjRuQQvzrCvlC5wCz00wHgoZ?=
 =?us-ascii?Q?q80FH7J7rGUT1aHUMN36fnFbn66wsgMJ69bsuyNcJ+/98oBqufYLLgPzgD8A?=
 =?us-ascii?Q?7RbsOZ9o6lpE9n2E1Kn/q1xBz0K1shPjenj3lm+pUH/7AXbySD2QV7XxYE0s?=
 =?us-ascii?Q?cL+GeBDbnLlQ+lCOTJZjY06UM32cCUIZM5nkjd7lZKivQC13hemfLB11Nkty?=
 =?us-ascii?Q?AIiogan0GAdxcFBRnMRddUycj5+N6Rq1K65AXnST6hpVX3g5gV/McJmUdabU?=
 =?us-ascii?Q?Z8BtAvSwhCKOeRxdi1cI8mLWFYo8tN/G+wnMNjAhxfSQyq07ENX2YFAev9rW?=
 =?us-ascii?Q?K2cVPuHqhDmpQHCWGzM6bVTIlCRgJqYHxEyJNroUpZjoWUqAyxqsSJ0LOTUH?=
 =?us-ascii?Q?7RtVQCMfjU/Jz5X5WfmNlDznvQY/wwo05qRWPhOgeRNJCR7BqW3wzVGBHryF?=
 =?us-ascii?Q?gTQtISMT8G7/MKjxYe8SLc2V5QEY7Fov2LP/wI0MXKL8edORXyFglJ0kmaog?=
 =?us-ascii?Q?LkCMUBDu343bwnnaCzKGTI4knVrqWDS6Bfizbm2+ejp+kvTSBca0YyaerKvw?=
 =?us-ascii?Q?niRxrWHUxx6A5m/YqWo66deeLY1A8N1h+AeU519RnQsdJ0pztZyJmqt3fVQ2?=
 =?us-ascii?Q?CyxI8W/NQwuI8O5WLC4/ld6v8tOE1jUK1jSg/HXbz1yU3Yo+FPXJZR8F6rOI?=
 =?us-ascii?Q?gFuYQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: skz9511NCoML+OLqYhXthgyrxW3OG8+ib9Iu+sm9z6JLzAVC8etoAWK3Y60Sh3ouwLbJxQQKVYbw3W6NPV0vJEaISIVlrj5HHIDcuk7+XrH+7Vn3jn35KKb0WDn8w49nClJc7THZVC/WTRwWgWw9wBWoxum+X30S5N92SJx9fBlIIUTaVFAak02cD8lgLpQXrcnpnRz7NRj3QIkUBXOlMDC6VEvbazVPsBK5uQqheJjZzFB8fSN/9ZHSuxIW61MKrUHFpO4XmThZ+bQ1oCeUOcTpVNohSOtO1J9YPzyBUzouobW4XfokpRv87MkkMU+S1EE+PgCkNIz9ndckAs/XFWHhEcuG8xFBi6KJlwsyKnX9qRMwjhW9g+QMyZg/EZk65jaTfiPmPBJGmTlgEp6GtLEXmabSWiWviB9T8Dnar8PLtisKBZ9Ow0+Lkbe9vqON
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:08.6968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96101e7-8982-4862-403d-08de658f05fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Tegra241 CMDQV defines a set of global control and status registers
used to configure virtual command queue allocation and interrupt
behavior.

Add read/write emulation for the global CMDQV register page
(offset 0x00000), backed by a simple register cache. This includes
CONFIG, PARAM, STATUS, VI error and interrupt maps, CMDQ allocation
map and the VINTF0 related registers defined in the global CMDQV
register space.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 102 +++++++++++++++++++++++++++++++++++++++-
 hw/arm/tegra241-cmdqv.h |  86 +++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 97c9b9c8dc..49fca9d536 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-accel.h"
@@ -32,6 +33,25 @@ static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
     return true;
 }
 
+static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
+{
+    int i;
+
+    switch (offset) {
+    case A_VINTF0_CONFIG:
+        return cmdqv->vintf_config;
+    case A_VINTF0_STATUS:
+        return cmdqv->vintf_status;
+    case A_VINTF0_LVCMDQ_ERR_MAP_0 ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        i = (offset - A_VINTF0_LVCMDQ_ERR_MAP_0) / 4;
+        return cmdqv->vintf_cmdq_err_map[i];
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
 static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
@@ -44,7 +64,57 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
         }
     }
 
-    return 0;
+    if (offset >= TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
+                      offset);
+        return 0;
+    }
+
+    switch (offset) {
+    case A_CONFIG:
+        return cmdqv->config;
+    case A_PARAM:
+        return cmdqv->param;
+    case A_STATUS:
+        return cmdqv->status;
+    case A_VI_ERR_MAP ... A_VI_ERR_MAP_1:
+        return cmdqv->vi_err_map[(offset - A_VI_ERR_MAP) / 4];
+    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
+        return cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4];
+    case A_CMDQ_ERR_MAP ... A_CMDQ_ERR_MAP_3:
+        return cmdqv->cmdq_err_map[(offset - A_CMDQ_ERR_MAP) / 4];
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_127:
+        return cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
+    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        return tegra241_cmdqv_read_vintf(cmdqv, offset);
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
+                                       uint64_t value)
+{
+    switch (offset) {
+    case A_VINTF0_CONFIG:
+        /* Strip off HYP_OWN setting from guest kernel */
+        value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
+
+        cmdqv->vintf_config = value;
+        if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
+            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+        } else {
+            cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return;
+    }
 }
 
 static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
@@ -59,6 +129,36 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
             local_err = NULL;
         }
     }
+
+    if (offset >= TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
+                      offset);
+        return;
+    }
+
+    switch (offset) {
+    case A_CONFIG:
+        cmdqv->config = value;
+        if (value & R_CONFIG_CMDQV_EN_MASK) {
+            cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
+        } else {
+            cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
+        }
+        break;
+    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
+        cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4] = value;
+        break;
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_127:
+        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
+        break;
+    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        tegra241_cmdqv_write_vintf(cmdqv, offset, value);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+    }
 }
 
 static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 94bef8c978..f157c8fd24 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,6 +10,7 @@
 #ifndef HW_TEGRA241_CMDQV_H
 #define HW_TEGRA241_CMDQV_H
 
+#include "hw/core/registerfields.h"
 #include "smmuv3-accel.h"
 #include CONFIG_DEVICES
 
@@ -30,8 +31,93 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     void *vintf_page0;
+
+    /* Register Cache */
+    uint32_t config;
+    uint32_t param;
+    uint32_t status;
+    uint32_t vi_err_map[2];
+    uint32_t vi_int_mask[2];
+    uint32_t cmdq_err_map[4];
+    uint32_t cmdq_alloc_map[128];
+    uint32_t vintf_config;
+    uint32_t vintf_status;
+    uint32_t vintf_cmdq_err_map[4];
 } Tegra241CMDQV;
 
+/* Global CMDQV MMIO registers (offset 0x00000) */
+REG32(CONFIG, 0x0)
+FIELD(CONFIG, CMDQV_EN, 0, 1)
+FIELD(CONFIG, CMDQV_PER_CMD_OFFSET, 1, 3)
+FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
+FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
+FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
+
+REG32(PARAM, 0x4)
+FIELD(PARAM, CMDQV_VER, 0, 4)
+FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
+FIELD(PARAM, CMDQV_NUM_VM_LOG2, 8, 4)
+FIELD(PARAM, CMDQV_NUM_SID_PER_VM_LOG2, 12, 4)
+
+REG32(STATUS, 0x8)
+FIELD(STATUS, CMDQV_ENABLED, 0, 1)
+
+#define A_VI_ERR_MAP 0x14
+#define A_VI_ERR_MAP_1 0x18
+#define V_VI_ERR_MAP_NO_ERROR (0)
+#define V_VI_ERR_MAP_ERROR (1)
+
+#define A_VI_INT_MASK 0x1c
+#define A_VI_INT_MASK_1 0x20
+#define V_VI_INT_MASK_NOT_MASKED (0)
+#define V_VI_INT_MASK_MASKED (1)
+
+#define A_CMDQ_ERR_MAP 0x24
+#define A_CMDQ_ERR_MAP_1 0x28
+#define A_CMDQ_ERR_MAP_2 0x2c
+#define A_CMDQ_ERR_MAP_3 0x30
+
+/* i = [0, 127] */
+#define A_CMDQ_ALLOC_MAP_(i)                 \
+    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4) \
+    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)   \
+    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)  \
+    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
+
+A_CMDQ_ALLOC_MAP_(0)
+/* Omitting 1~126 as not being directly called */
+A_CMDQ_ALLOC_MAP_(127)
+
+
+/* i = [0, 0] */
+#define A_VINTFi_CONFIG(i)                       \
+    REG32(VINTF##i##_CONFIG, 0x1000 + i * 0x100) \
+    FIELD(VINTF##i##_CONFIG, ENABLE, 0, 1)       \
+    FIELD(VINTF##i##_CONFIG, VMID, 1, 16)        \
+    FIELD(VINTF##i##_CONFIG, HYP_OWN, 17, 1)
+
+A_VINTFi_CONFIG(0)
+
+#define A_VINTFi_STATUS(i)                       \
+    REG32(VINTF##i##_STATUS, 0x1004 + i * 0x100) \
+    FIELD(VINTF##i##_STATUS, ENABLE_OK, 0, 1)    \
+    FIELD(VINTF##i##_STATUS, STATUS, 1, 3)       \
+    FIELD(VINTF##i##_STATUS, VI_NUM_LVCMDQ, 16, 8)
+
+A_VINTFi_STATUS(0)
+
+#define V_VINTF_STATUS_NO_ERROR (0 << 1)
+#define V_VINTF_STATUS_VCMDQ_EROR (1 << 1)
+
+/* i = [0, 0], j = [0, 3] */
+#define A_VINTFi_LVCMDQ_ERR_MAP_(i, j)                               \
+    REG32(VINTF##i##_LVCMDQ_ERR_MAP_##j, 0x10c0 + j * 4 + i * 0x100) \
+    FIELD(VINTF##i##_LVCMDQ_ERR_MAP_##j, LVCMDQ_ERR_MAP, 0, 32)
+
+A_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
+/* Omitting [0][1~2] as not being directly called */
+A_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
+
 #define VINTF_REG_PAGE_SIZE 0x10000
 
 #ifdef CONFIG_TEGRA241_CMDQV
-- 
2.43.0


