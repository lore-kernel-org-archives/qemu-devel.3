Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9601CD3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPn-0007Z3-Qv; Wed, 10 Dec 2025 08:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPc-0007TU-4L; Wed, 10 Dec 2025 08:39:24 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPY-0001Oe-VH; Wed, 10 Dec 2025 08:39:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgaG01yfjWuqd/UjTBm4pf9oE0ZE+MiUmiDQjc4gw7HFbyEpWGX92aDAScwk5X4pbR2IkHmTUZ0bM4Z1dayHWBWmxU2U865IWOnxvQrHR+uHLppIhucdtYGSemg7mnGcPIulMtlLoY2c0WHKr85I/boJXtleSKr4rrklyG1zi9XykC2Ta9JGjTOa2rxIn1IG68GE+28u0n70Rmi9R6NKuAmP4mWJ1rjEJVG/x5ZIHuq9NWVjYezv5l6Z/L7PdlFE8bhiodzFy6PnVldlrie248t8wmsgAsuofm6nD9AxvtfSnndiTsmERn7YFSaKt8NpurheQru29GPR4XfGKfE31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7KZS2To6kx0ux/yeXWW7tzj+BWBQnClDBLh6RHFfQQ=;
 b=LkdztXU4WJ/0PuMPHjv+6SF3b7McqjgH27PVVpmCSRiarzNygFd25ZnTzE++MDd31rAoYZlm7FPoLqTU5UcGSr3x27pibtA1yeH47d3ZY1oTZLy8dLpQQCC0uyCXu2MwsXpuU9GslTnrItxw5Y8QlFOF3YbHXlysjyHddRRBovGC4gKL95VEojWc8oLKFhr5QUWFvzyKrLMYf158BOdNSpdaVUnYFXdkP8CpGvWhN2XlHrmsUo9iVBm4Rdd1h5ElQOSO6DkpHBVR2v5vVEOsUOCAVCZKTvE4MnhtYZ9lCJXB3ymp6yqZh25OMd7d4gKm7ONPUIyV0OljMLF4fcYhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7KZS2To6kx0ux/yeXWW7tzj+BWBQnClDBLh6RHFfQQ=;
 b=pw3aGquswpOn2DwrCvdovW8aYBPzu2qFufKkzbsCx4qnWKz5A302ep5K2a2mvj5rT3A8SYiq49WgGYFx8AhoL6ltLiBaWWUt57+D3CtQuRanTQaRocsBZU11oBY03lOyetWGF5da6pHblvM5F0sp/lN0lxsfHPodstCl+yV1sT7304ZznjnaWxpXmhXFtpNf/1FsQP+KQIFTsv4z4gW6oM/9AuBGbaFuuN+q3goMvzgv1AV+C3n+uVdndSZr4ZmE+iUkir75JjRvKYVYqWImc2XvMRBXd7Dfbu8azSUL2Lr0i023szS6hOLRn6aSpbZEwD/eXirLpVwe5LAWWV/McA==
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.9; Wed, 10 Dec 2025 13:39:08 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::e1) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 13:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 13:39:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:42 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:39 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 07/16] hw/arm/tegra241-cmdqv: Add read emulation support
 for registers
Date: Wed, 10 Dec 2025 13:37:28 +0000
Message-ID: <20251210133737.78257-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d53fef3-9663-4e10-09cb-08de37f17dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oGqPY7zXWbx5uZlfZkVYBYi6O+w5Iw49q1V3bydK5MKaChfro7MmKM+fKTJy?=
 =?us-ascii?Q?1t05OsJOyRqH6m5exjLDAamM4PBhlFx3jpcLQ30zH8SGulk7r/rY7NCkQeML?=
 =?us-ascii?Q?bAgBoj3YH3AFJxywb7VVnRG3j7/c3iupdyhQOjij7OTgoTg1dpAxzDZPtdCZ?=
 =?us-ascii?Q?CxBOxZtwrSgIQ7g3JH31LnQvXKUnv3JDdAtkY+3qA1Q+6es+AsGTUyht89xK?=
 =?us-ascii?Q?DygtMLzaniEmxyGwse+4HM/ALI1uuJ3szP/bZ+djk3Vc0fkyeI+Yt0KcJPfN?=
 =?us-ascii?Q?sxzIvJDni1gQUhpNd7tApCmpbWbQzSBuyvuk4vcEhyMAh1NXEgTSYENWHvi/?=
 =?us-ascii?Q?X0fh+70KLui2spmKmZmM7IynDxbIetLmXGMGRyexmrL5OkYiuKMZcvRfxrni?=
 =?us-ascii?Q?SsdqaSrUTVY4ZRMrm12ijDA5afiVk4LMJ+nv3AxlY//Fvj/1vcFUu3t8IBhs?=
 =?us-ascii?Q?Ke1jOjYL8d7u5YglBxU0yAWtAlKubS2oOJFTSiQgllgwogeWnz/XaQbFZbKA?=
 =?us-ascii?Q?BoBF3Z2BNyq3usaxLMk4t4LEydocUzw6TjdHeHtaKV9+LOv7zoRz9R8s7RwD?=
 =?us-ascii?Q?aNfcMZ4AqaEKellSzRxSr60yQrrM92waiPhQuDuf3Mr5ayWU7JvJOZWWrRlH?=
 =?us-ascii?Q?V0W4OIq5OZ20tYp/Cru6cBgD+aMzIgyoCxEBGrf7+MgrMOCwdOA6ygEqgqU7?=
 =?us-ascii?Q?Pm/qUDQDR1/Yl4Axr1Vth1H+EM92fx5yqYJly3CK1agsThoxHaQdbQTT0zXk?=
 =?us-ascii?Q?10wtnTs7rneOIXt4NBzBw0AQRMOo92k93T6r7BgWaEN8K2Pg2ERYgbJoVb/O?=
 =?us-ascii?Q?b3YRhR/UEe+krDVOHawQmpGlbAsZieoNMNbGFnEfe7uytVbVjHYe5lVpyqBN?=
 =?us-ascii?Q?q9D+1GCR7L31VCNRcYj+joVpVY1lX3rexxzZdDwQ+3pYfDa0naW4UGcu8+xM?=
 =?us-ascii?Q?E/6nnjyHTBQ3HqzAYSwi/NF6tQgDK85jNdc2UaC8r0OrIeVrs1Ih3/8gNUiN?=
 =?us-ascii?Q?GEaS4lxFR8GuB/XPwd6817LiUBhmTd1yx3KABFJ71hwdzRl8ZH7ELfTP39GG?=
 =?us-ascii?Q?Ck4aAZjVrM6LE8vjkLPd6DlpN/atyE6KwjMWHY8E8CdDnI7u5YCWluHk8UOu?=
 =?us-ascii?Q?R4pcMh3h7aW+jPwxY5QYI4UpHmQi+Sx3bco3KtLtLIvsp4RCCfTLaCAZWtdi?=
 =?us-ascii?Q?0Q/A+MStf78BmtQhjRV8kU5IiuEpdeBRZ8M3mWvD+oqQ+VSer22MwGu3Z1NM?=
 =?us-ascii?Q?4qXxk0ZfobCReUIUNmc2/TZ/kKQZO0H+IlVqsqaN2zMXSO3S/gGziIE/QMdV?=
 =?us-ascii?Q?vvLI33Y++SBL9vDeEEEvgVEFNpVulg0eH2CbfGso9pbwxT6cRMCgO5hykFIy?=
 =?us-ascii?Q?PJYitdPJm8XqrcYdQDjvqlQAayd077YRzoD6GImtgzQimuIFvML/q+eCoDQP?=
 =?us-ascii?Q?iQ6GPe8XAf33tWV8SMNFcGeh7VfKW4Gd+ze9rBYaD9lyMd8jS5hetbii0wmU?=
 =?us-ascii?Q?y6Q57gFAEXQxlnW8BHSKJ2Lxhh37bYMBIVARcP8jnNlDE24xT0+8pQkEw7GF?=
 =?us-ascii?Q?E8qMtES9PjAy3wVASx4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:06.8519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d53fef3-9663-4e10-09cb-08de37f17dc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
Received-SPF: softfail client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Implement read support for Tegra241 CMDQV register blocks, including VINTF
and per VCMDQ register regions. The patch decodes offsets, extracts queue
indices, and returns the corresponding cached register state.

Subsequent patch will add write support.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 144 +++++++++++++++++++-
 hw/arm/tegra241-cmdqv.h | 282 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 425 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index d8858322dc..185ef957bc 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-accel.h"
@@ -52,10 +53,94 @@ static bool tegra241_cmdqv_init_vcmdq_page0(Tegra241CMDQV *cmdqv, Error **errp)
     return true;
 }
 
+/* Note that offset aligns down to 0x1000 */
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
+/* Note that offset aligns down to 0x10000 */
+static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset,
+                                          int index)
+{
+    uint32_t *ptr = NULL;
+    uint64_t off;
+
+    /*
+     * Each VCMDQ instance occupies a 128 byte region (0x80).
+     * The hardware layout is:
+     *   vcmdq_page0 + (index * 0x80) + (offset - 0x10000)
+     */
+    if (cmdqv->vcmdq_page0) {
+        off = (0x80 * index) + (offset - 0x10000);
+        ptr = (uint32_t *)(cmdqv->vcmdq_page0 + off);
+    }
+
+    switch (offset) {
+    case A_VCMDQ0_CONS_INDX:
+        if (ptr) {
+            cmdqv->vcmdq_cons_indx[index] = *ptr;
+        }
+        return cmdqv->vcmdq_cons_indx[index];
+    case A_VCMDQ0_PROD_INDX:
+        if (ptr) {
+            cmdqv->vcmdq_prod_indx[index] = *ptr;
+        }
+        return cmdqv->vcmdq_prod_indx[index];
+    case A_VCMDQ0_CONFIG:
+        if (ptr) {
+            cmdqv->vcmdq_config[index] = *ptr;
+        }
+        return cmdqv->vcmdq_config[index];
+    case A_VCMDQ0_STATUS:
+        if (ptr) {
+            cmdqv->vcmdq_status[index] = *ptr;
+        }
+        return cmdqv->vcmdq_status[index];
+    case A_VCMDQ0_GERROR:
+        if (ptr) {
+            cmdqv->vcmdq_gerror[index] = *ptr;
+        }
+        return cmdqv->vcmdq_gerror[index];
+    case A_VCMDQ0_GERRORN:
+        if (ptr) {
+            cmdqv->vcmdq_gerrorn[index] = *ptr;
+        }
+        return cmdqv->vcmdq_gerrorn[index];
+    case A_VCMDQ0_BASE_L:
+        return cmdqv->vcmdq_base[index];
+    case A_VCMDQ0_BASE_H:
+        return cmdqv->vcmdq_base[index] >> 32;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        return cmdqv->vcmdq_cons_indx_base[index];
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        return cmdqv->vcmdq_cons_indx_base[index] >> 32;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
 static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
     Error *local_err = NULL;
+    int index;
 
     if (!cmdqv->vcmdq_page0) {
         tegra241_cmdqv_init_vcmdq_page0(cmdqv, &local_err);
@@ -65,7 +150,64 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
         }
     }
 
-    return 0;
+    if (offset > TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
+                      offset);
+        return 0;
+    }
+
+    /* Fallback to cached register values */
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
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ127_GERRORN:
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN:
+        /*
+         * Align offset down to 0x10000 while extracting the index:
+         *   VCMDQ0_CONS_INDX  (0x10000) => 0x10000, 0
+         *   VCMDQ1_CONS_INDX  (0x10080) => 0x10000, 1
+         *   VCMDQ2_CONS_INDX  (0x10100) => 0x10000, 2
+         *   ...
+         *   VCMDQ127_CONS_INDX (0x13f80) => 0x10000, 127
+         */
+        index = (offset - 0x10000) / 0x80;
+        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - 0x80 * index, index);
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ127_CONS_INDX_BASE_DRAM_H:
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ127_CONS_INDX_BASE_DRAM_H:
+        /*
+         * Align offset down to 0x20000 while extracting the index:
+         *   VCMDQ0_BASE_L  (0x20000) => 0x20000, 0
+         *   VCMDQ1_BASE_L  (0x20080) => 0x20000, 1
+         *   VCMDQ2_BASE_L  (0x20100) => 0x20000, 2
+         *   ...
+         *   VCMDQ127_BASE_L (0x23f80) => 0x20000, 127
+         */
+        index = (offset - 0x20000) / 0x80;
+        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - 0x80 * index, index);
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return 0;
+    }
 }
 
 static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index ccdf0651be..4972e367f6 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,6 +10,7 @@
 #ifndef HW_TEGRA241_CMDQV_H
 #define HW_TEGRA241_CMDQV_H
 
+#include "hw/registerfields.h"
 #include CONFIG_DEVICES
 
 #define TEGRA241_CMDQV_IO_LEN 0x50000
@@ -22,10 +23,291 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_vcmdq_page;
     MemoryRegion mmio_vintf_page;
     void *vcmdq_page0;
+    IOMMUFDHWqueue *vcmdq[128];
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
+    uint32_t vcmdq_cons_indx[128];
+    uint32_t vcmdq_prod_indx[128];
+    uint32_t vcmdq_config[128];
+    uint32_t vcmdq_status[128];
+    uint32_t vcmdq_gerror[128];
+    uint32_t vcmdq_gerrorn[128];
+    uint64_t vcmdq_base[128];
+    uint64_t vcmdq_cons_indx_base[128];
 } Tegra241CMDQV;
 
+/* MMIO Registers */
+REG32(CONFIG, 0x0)
+FIELD(CONFIG, CMDQV_EN, 0, 1)
+FIELD(CONFIG, CMDQV_PER_CMD_OFFSET, 1, 3)
+FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
+FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
+FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
+
+#define V_CONFIG_RESET 0x00020403
+
+REG32(PARAM, 0x4)
+FIELD(PARAM, CMDQV_VER, 0, 4)
+FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
+FIELD(PARAM, CMDQV_NUM_VM_LOG2, 8, 4)
+FIELD(PARAM, CMDQV_NUM_SID_PER_VM_LOG2, 12, 4)
+
+#define V_PARAM_RESET 0x00004011
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
+    A_VINTFi_STATUS(0)
+
+#define V_VINTF_STATUS_NO_ERROR (0 << 1)
+#define V_VINTF_STATUS_VCMDQ_EROR (1 << 1)
+
+/* i = [0, 0], j = [0, 3] */
+#define A_VINTFi_LVCMDQ_ERR_MAP_(i, j)                               \
+    REG32(VINTF##i##_LVCMDQ_ERR_MAP_##j, 0x10c0 + j * 4 + i * 0x100) \
+    FIELD(VINTF##i##_LVCMDQ_ERR_MAP_##j, LVCMDQ_ERR_MAP, 0, 32)
+
+        A_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
+    /* Omitting [0][1~2] as not being directly called */
+    A_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
+
+/* VCMDQ registers -- starting from 0x10000 with size 64KB * 2 (0x20000) */
+#define VCMDQ_REG_OFFSET 0x10000
 #define VCMDQ_REG_PAGE_SIZE 0x10000
 
+#define A_VCMDQi_CONS_INDX(i)                       \
+    REG32(VCMDQ##i##_CONS_INDX, 0x10000 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
+    FIELD(VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+        A_VCMDQi_CONS_INDX(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_CONS_INDX(127)
+
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_NONE 0
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_OPCODE 1
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ABT 2
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ATC_INV_SYNC 3
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_ACCESS 4
+
+#define A_VCMDQi_PROD_INDX(i)                             \
+    REG32(VCMDQ##i##_PROD_INDX, 0x10000 + 0x4 + i * 0x80) \
+    FIELD(VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+        A_VCMDQi_PROD_INDX(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_PROD_INDX(127)
+
+#define A_VCMDQi_CONFIG(i)                             \
+    REG32(VCMDQ##i##_CONFIG, 0x10000 + 0x8 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+        A_VCMDQi_CONFIG(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_CONFIG(127)
+
+#define A_VCMDQi_STATUS(i)                             \
+    REG32(VCMDQ##i##_STATUS, 0x10000 + 0xc + i * 0x80) \
+    FIELD(VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+        A_VCMDQi_STATUS(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_STATUS(127)
+
+#define A_VCMDQi_GERROR(i)                               \
+    REG32(VCMDQ##i##_GERROR, 0x10000 + 0x10 + i * 0x80)  \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
+    FIELD(VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+        A_VCMDQi_GERROR(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_GERROR(127)
+
+#define A_VCMDQi_GERRORN(i)                               \
+    REG32(VCMDQ##i##_GERRORN, 0x10000 + 0x14 + i * 0x80)  \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
+    FIELD(VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+        A_VCMDQi_GERRORN(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_GERRORN(127)
+
+#define A_VCMDQi_BASE_L(i)                       \
+    REG32(VCMDQ##i##_BASE_L, 0x20000 + i * 0x80) \
+    FIELD(VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
+    FIELD(VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+        A_VCMDQi_BASE_L(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_BASE_L(127)
+
+#define A_VCMDQi_BASE_H(i)                             \
+    REG32(VCMDQ##i##_BASE_H, 0x20000 + 0x4 + i * 0x80) \
+    FIELD(VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+        A_VCMDQi_BASE_H(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_BASE_H(127)
+
+#define A_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x20000 + 0x8 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+        A_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_CONS_INDX_BASE_DRAM_L(127)
+
+#define A_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x20000 + 0xc + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+        A_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VCMDQi_CONS_INDX_BASE_DRAM_H(127)
+
+/*
+ * VINTF VI_VCMDQ registers -- starting from 0x30000 with size 64KB * 2
+ * (0x20000)
+ */
+#define A_VI_VCMDQi_CONS_INDX(i)                       \
+    REG32(VI_VCMDQ##i##_CONS_INDX, 0x30000 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+        A_VI_VCMDQi_CONS_INDX(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_CONS_INDX(127)
+
+#define A_VI_VCMDQi_PROD_INDX(i)                             \
+    REG32(VI_VCMDQ##i##_PROD_INDX, 0x30000 + 0x4 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+        A_VI_VCMDQi_PROD_INDX(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_PROD_INDX(127)
+
+#define A_VI_VCMDQi_CONFIG(i)                             \
+    REG32(VI_VCMDQ##i##_CONFIG, 0x30000 + 0x8 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+        A_VI_VCMDQi_CONFIG(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_CONFIG(127)
+
+#define A_VI_VCMDQi_STATUS(i)                             \
+    REG32(VI_VCMDQ##i##_STATUS, 0x30000 + 0xc + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+        A_VI_VCMDQi_STATUS(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_STATUS(127)
+
+#define A_VI_VCMDQi_GERROR(i)                               \
+    REG32(VI_VCMDQ##i##_GERROR, 0x30000 + 0x10 + i * 0x80)  \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
+    FIELD(VI_VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+        A_VI_VCMDQi_GERROR(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_GERROR(127)
+
+#define A_VI_VCMDQi_GERRORN(i)                               \
+    REG32(VI_VCMDQ##i##_GERRORN, 0x30000 + 0x14 + i * 0x80)  \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
+    FIELD(VI_VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+        A_VI_VCMDQi_GERRORN(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_GERRORN(127)
+
+#define A_VI_VCMDQi_BASE_L(i)                       \
+    REG32(VI_VCMDQ##i##_BASE_L, 0x40000 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
+    FIELD(VI_VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+        A_VI_VCMDQi_BASE_L(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_BASE_L(127)
+
+#define A_VI_VCMDQi_BASE_H(i)                             \
+    REG32(VI_VCMDQ##i##_BASE_H, 0x40000 + 0x4 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+        A_VI_VCMDQi_BASE_H(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_BASE_H(127)
+
+#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x40000 + 0x8 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+        A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(127)
+
+#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x40000 + 0xc + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+        A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
+    /* Omitting [1~126] as not being directly called */
+    A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(127)
+
 #ifdef CONFIG_TEGRA241_CMDQV
 bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  uint32_t *out_viommu_id, Error **errp);
-- 
2.43.0


