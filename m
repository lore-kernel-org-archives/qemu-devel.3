Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FC1CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudg-0001cC-H9; Tue, 09 Jun 2026 07:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuda-00010I-7V; Tue, 09 Jun 2026 07:28:54 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudY-0003fR-Fl; Tue, 09 Jun 2026 07:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8rgx1j23yJI0g09PJD1SGpzLYuSgnAuWCZjI8rZJf7HSFZHOFnAKSiYPtgD7SjbcfFPZv8rpRW1D9OgJg0J7Ouyc/zPnJyWJ66u57ebL32yVeN2mMmpHMPn87ELuqMBREt+eWVTnp/HpoxKbd4VoIo2sKPfwtjpddRCIgceDrpagLyrTnY8EWYovilVYIy49fkhAM2n3Lrab2DB7o6/JyHXzjuJ7qpD2QwIWf6/QAk0KDjZ0WvefgZYDohvbJnShHOPH1pEBbjjMoY/a4nwJfg+GLgrjkeXEPCoZ4nLWfukrOWoUs5x93SYX1RM3cdJ3RoDz3KkRwxlp1zrQAS8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL+codZZFMg4vzL3FaI+pXKXBaHKVLtDIHRobM5HpFI=;
 b=hYYgBuEaAHo1fISdT1JPaSCHNV4PyD5e2c9m84TrwLXrxRC3L6vaL5gO1NZb7VVJSiA74n499gttMZMkGBI0Kz4POakY2oqP+ntTQDOlQ91PoswjUywtX9trKKKI28XjS/5U1S24WjxnjQQpYJf4bGg/5k2AqQhStDsJJiZTQbogclk4hMe6+ooTTtJCK+sToa16dLAg/p33HLSIOfHT9WqBeJMOs7KJ6dZ1gDp1eWj1aBtkgrOmmbcL9dh4kV4k8s933U5/Hf/0BC+azDPSAyMq+7bOz0mmOCl64vAOvvzR1kkHpA0rxJ/RD6zay3pzt5FC8OUihKeRewogfLT0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL+codZZFMg4vzL3FaI+pXKXBaHKVLtDIHRobM5HpFI=;
 b=ucpK7n8V5SLe5eiMOOF+pvJJUTvHpmyKtzJFMRB/phm/hQK6+pIOGGlFRIA9bQbkap7hw1I1rkfiOFFpbKmDDn+5ZAnTV70IjLr0lH6tDRHO5KEWf2dFF9Zh8zmP1OAyILgBeobEsoFI5L+in+f+FRvdYe4VutTvB7nJXs36/Elu2WOIzDye/d9EFaqA55Q8TSUxOUfz0X+216ZjhxiTFUSpSUSClvbRViXnDlieCyFY0Tfx1QQXq+EJo3KN4oZcmgYQO4zcFhNq/WgbevOiwGH5820P/BYxrpobdhYk73ZmQLhLGap9YjffUKvmSrMZ3h6DF0FjVZ+wwr/kURD8yA==
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:28:43 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::3e) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:21 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 25/31] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Date: Tue, 9 Jun 2026 12:25:46 +0100
Message-ID: <20260609112552.378999-26-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c91ef78-b520-4bbb-9b98-08dec61a4351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZM9YpmUrQp6BXnrvf5NkliNXkPLX/2rbednO4pVT41XJI/GzYN8TolTUsKn0p6AoRRhZqe94DKYSYjHxZzLhsp4BBp8Pdqaq3p/xAmnsyy2EHP28rwcThxi1c120HlT8ceBQszxLMH27NZN+aVhVKqJKKT5y3fwh2JTH8nQcnZX+Rq/wvCpeztFehvmMnlfQzRdUrtcBH9nm6G1Ozku4YC7lbqOOlD7oF7ed+oDVhDT3VGkBtsHQzK93r202FGQraZBt8NdDEvDJ+yG4VZAR65Hq8gQPjtcNQoc8tnlDkd4dhIrlH+wHOHzQkA8pcx4R6WmmQqrI3lADi3V+5e8ibCD5oP6K6wtY6usgKVVXUwKN3tELSpo4jzkIHkdlkUitBqhmdDhxZcPE+0vTczab7PxppXzN1JSLkqcGd4X42yvOl841nEXG+7nsImdd8cTZgYLYhnfF4ONCSUOx4yCd+O5EeMEyxkaEIy4SP5X/CC6bxQCnwDhd4zBlhQdDtUiMBFiypBoXvEY7IgusFT7xllipfq53vYMpCAzfZEf84IzdGDgJNKzBkmClng2rjHOQtCpx+UOKeDa8tEFRbyGtSTPH07igOT/khbYeuYBBbHssDmD8kMHm7gyIV58GFSfADHuudL0X2FRsA770GRHee5Bu26qEYDAi6OK4+bK/ztHtNA2JW0r9C/4VpDx1c8lynwFpRaaOdozjrm5UmBsCPyHvpFReurMhXpIy7BWfdtA=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vv7hDXA8IN4Zbp6Ds4km8CRHUvK9US7Yz7nuY4nLWFoiqLRj6FNo32O9Y/sPwkBtfvzArVf8qyLSGT0G4+POpsUwFlNny9FKoHUVbCFleWU1MTaT/ecxurIk8e3jYdDtZtia7IJRqwxH+RlQgIilhjEUDuglGrePUb8bGk3pTlpedZkpm1K7dugIjjyhTsdVWsx8H1aP9GEwoWofy1/GjX5cd1FvRClJOCYfZC+xx6wCsEomsrJlUGGvhGpCFfug7GrBMtTPWwb4edhs4kYm5iwKSBaUE/wyf2mZddOIGB7nDHFw+UvS7rfuF00Ptpj5EoFmZNZjK60aaAOgkbGP9BlK6ynPb6Nf+GIsAnzBStG4uSqRXpic7JC5q1xmBBeQDrCrDCxnxZP+A7HG2VObK/y5VSunjaXJ/rjlLBZYCUF4ziW/OyB1CeJUDUmXR9T1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:43.2608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c91ef78-b520-4bbb-9b98-08dec61a4351
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

CMDQV HW performs DMA accesses to guest queue memory by its host
physical address set up via IOMMUFD. This requires the guest queue
to be contiguous in both guest PA and host PA space. With Tegra241
CMDQV enabled, we must only advertise a command queue size (CMDQS)
that the host can safely back with physically contiguous memory.
Allowing a queue size larger than the host page size could cause
the hardware to DMA across page boundaries, leading to faults.

Use qemu_minrampagesize() to find the smallest memory-backend page
size in use, then cap IDR1.CMDQS so the guest cannot configure a
command queue that exceeds that contiguous backing.

Note this is done at SMMUv3 init, before any guest queue GPA is
known, so the cap is conservative. Maximum queue size is 8MiB;
it is recommended to back the VM with hugepage sizes large enough
so CMDQS stays at the HW maximum. Smaller backing pages reduce
CMDQS accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 0ed2a03612..4b8f8b15c7 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -14,6 +14,8 @@
 #include "hw/arm/smmuv3-common.h"
 #include "hw/core/irq.h"
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
+#include "system/hostmem.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
@@ -866,6 +868,8 @@ free_viommu:
 static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
 {
     int i;
+    long pgsize;
+    uint32_t val;
 
     cmdqv->config = V_CONFIG_RESET;
     cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
@@ -897,6 +901,22 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
         cmdqv->vcmdq_base[i] = 0;
         cmdqv->vcmdq_cons_indx_base[i] = 0;
     }
+
+    /*
+     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
+     * queue fits entirely within the smallest backend page size, ensuring
+     * the command queue is physically contiguous in host memory.
+     *
+     *   IDR1.CMDQS = log2(max_qsz) - entry_shift
+     *
+     * where entry_shift = 4 (each CMDQ entry is 16 bytes = 2^4).
+     */
+    pgsize = qemu_minrampagesize();
+    if (pgsize == LONG_MAX) {
+        pgsize = qemu_real_host_page_size();
+    }
+    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));
 }
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
-- 
2.43.0


