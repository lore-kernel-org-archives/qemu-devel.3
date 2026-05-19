Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F08CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsQ-0003L8-OS; Tue, 19 May 2026 06:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsO-00035b-64; Tue, 19 May 2026 06:40:40 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsK-0006zp-Bd; Tue, 19 May 2026 06:40:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jU4O7ocqfVVFRCeIdT7o1FG43IDyDfSb71S8d33QqueY0X8FFtB/GcfSSmhegEkLa53s9oya5PbkSLEgkNbw07ipzK15Riq6VIjEiGBiVXKVE4C6TR6SNDdvA9kvC/dGgLvBp4htfRyTn797Vb6qX2h/SR3a7MIzNpGv3MDU1Rd2g4cm2v/g0kvi9C2/HteMIzPaunaOKkq19Cf+Gsk2X6J6id04SksB5Le9dlf30moRZrwQsfC/rMbFAlY9AS7TM5Wp65adyq/Y3OUvYlioa77spI099CRgSia/OPfwS1ALvvtMLbQLCTkgWhE20DFqxH9OO6rmoGUpPom1jONhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSaGvrM8fYfRhbGGYEAfBvuAcXdrUP/9EQaZx+Shsdk=;
 b=FSWxoYjoXYmaU1w38/FVnET5/ibPBGJYBsbWu2f8a9ZLs9t8ttB+5m37ACA37qOUkBmpTTmDCDbLUyvT08cgjWOAJLL7D3YJpqY1nSuCU2zNJ5rM5AWKT5xbeZLPyLFuGiuREeSWBY/7qE1O+/CGiXYT0sO4p43/3xpRgeltjzlb+KS6M/5gN4FFPM54NIctpXoLwt1MletntC4LFpwD/Qa4tIL+8DnzyjoFIfOI62sUF8ZFl/pDABya4JIsfkHXSNrHk4DPT46vJ6dcQuxE5Sg6KW1k5BvE8WW4z3DVfjqfvQjhYSp+AZX1KDJJQdolzR8yyXxcLDHmDqxYA2CLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSaGvrM8fYfRhbGGYEAfBvuAcXdrUP/9EQaZx+Shsdk=;
 b=Gh6Wsmc6XSPb9WgsqJ0L2YHLeUpXxGq0fNvgkdtNBeA9b7Rfg1uzRtMizK8EPZrFjCYT8UWv7SImY3qit0ne6I7JaY3yWeMU98zcnFHDt8InpKiHwZFHwwbSnjLOL6uqBx1NN22wJ1Zm1ABgGdYjCuVwYTAyvjcZkgWKzn53BCk+DOIKREoER61rKk6uNleiB/9P0k+cKjQRhKJ/7KHeSMJ4hNFkmNTlgR25+YhMtKt0iuU6M4uz+/fuvGpzyApY4m+XGIOeKNoqOHHdM3uNPgI9/w1qk+vHvVot/37Pequ+iQsVDz+m7qY7icuSDU7XYDXFf/yFqZRQKezmreBuYA==
Received: from BL1PR13CA0412.namprd13.prod.outlook.com (2603:10b6:208:2c2::27)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 10:40:28 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::5e) by BL1PR13CA0412.outlook.office365.com
 (2603:10b6:208:2c2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 10:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:12 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:09 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 27/32] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Date: Tue, 19 May 2026 11:37:05 +0100
Message-ID: <20260519103727.899332-28-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f6fd75-66e3-4069-722c-08deb5930b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: fcXT46zhGDRp5e1gtcDajozqesB+wzx0w5Pugmw2aBq4IUctl+e1rwbreUMtTQ6ZUDdgi+6EtH/mD/4RPIPjy+iolNUfHMxbKsnHYRu6DazvjGsW+FRHgrvxC3bOfYjH529QShok99LcmjosMh5kh14zabB7VRbCN8NnXz6eaHHeYeGlUwAsrVBqf6NKy6YQTByj/kr1oHbAyuwHveyNfsyCU4t8Yo5aRwZux7/8pmsreADLPtJZAntzZHoX9Jo4bZ6WC0vim2SkaZuw49DonnXPGYph3T2wvKak+CNTATwaqO6sbEpED+1f81/izFtSGAxMk+5Rh24NcEhrIU0Qiu8yJFiGF9LqmpfcnfSfl4HaLa+LqPK21YVDLk1VFAJTIMErzI0ulRweZfr7rwk48GHxhkLMnlPsFjN3AZxtWRfghviid3blL3djeOicQMKCxUdOu2HomIfMNIMXOSm8QvDqI13C+BJqzODE28FmabyQ4mvL9h/0Y564k706eKXRoSS/TGU/x5QaeIFYzJnLctOh/pbSXY5d9vD/EK1vypcKrCqU2oggjdVD9ub2VGXpauN5Yuphvco1VU9RkLWLMYN5Hlud9ilTsW1GogYwOxkYSESIx827kpDf6JBiPbPWznN13HPRVqrqFgl5rpGBFTGnxaZtE4sljLEQXThUMAMD98JM+BPYj8aRi3CV+LYbFkU3sVjBCFFt2IRdyVbFyxPw6IEF6kgUFlRsH/zpjWo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o+4EIp69DlnSKepy6LWH3LHNSKTObhsxhcVSksPOfgRrHqlCZ6Bf2h6WFOwGWDD4LNiAqOIIeli1wmFUJ/hdfSKYcDq1ni/pxlkWyvYBX83hBzgTs+4Wll8HfjPjcvIkhMr7uduDW8mvasWtosXXr6e4yFEV5yCeZvkc1EMjNiyy//nUh12HwjiTsTL89Q+s84TJtK6QHJPQ7mkLG4mx+OqBKkidTbUt7KNnmEy/BAuz3XHh60gPsbndXyAF/sQydMI/3D9rstUEUkHenWbgqJ6jp8sD9Jf4OeMXRY4yvphxBdEPnRJ0FOGNvn3g/p/6deo/pnalv0HF1XKo6E/0nlKwjRxUeEKkfhD/leDb2JHhEhyrXqrjoxlvdKGUPunGvVhVpTeec2C+5Tp21KdPA/FKyu2Yhdt1pFHB10Yl+raf2SqAkXpRk/t4/BP3vpjQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:28.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f6fd75-66e3-4069-722c-08deb5930b18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

CMDQV HW reads guest queue memory by its host physical address set
up via IOMMUFD. This requires the guest queue to be contiguous in
both guest PA and host PA space. With Tegra241 CMDQV enabled, we
must only advertise a command queue size (CMDQS) that the host can
safely back with physically contiguous memory. Allowing a queue size
larger than the host page size could cause the hardware to DMA across
page boundaries, leading to faults.

Use qemu_ram_backend_pagesize_min() to find the smallest memory-
backend page size in use, then cap IDR1.CMDQS so the guest cannot
configure a command queue that exceeds that contiguous backing.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ad64f06260..7f617bcc97 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,8 @@
 #include "hw/arm/smmuv3-common.h"
 #include "hw/core/irq.h"
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
+#include "system/ramblock.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
@@ -856,6 +858,8 @@ free_viommu:
 static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
 {
     int i;
+    size_t pgsize;
+    uint32_t val;
 
     cmdqv->config = V_CONFIG_RESET;
     cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
@@ -887,6 +891,19 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
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
+    pgsize = qemu_ram_backend_pagesize_min();
+    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));
 }
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
-- 
2.43.0


