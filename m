Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132A4CD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsK-0002ic-NF; Tue, 19 May 2026 06:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsE-0002EG-Qc; Tue, 19 May 2026 06:40:30 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsC-0006rg-Qk; Tue, 19 May 2026 06:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5VFTn0LdUAU1fX66NO+hIUZ7cClayaL4bFTJMCOUOBkV2rpKFgsZD2dhhVUFaNx43CJh8nN0MoQ6994jLxU3g8Dgrb7roZBkQNiotso4BeQmk+UlkKimFJEHJK7RkVCpkCnx/qjFPvK+6gwHRzDlwtZz+G7R4Hw8R0FPtYq08wBE2hGwDBlESDNNSGCLJwOpwOAqNYW16UwXkQJwFCSoUEQOly6Tk42SfWTcEv8F2e/6yHERLhf19cwc0Rqw+8p85nP0uEkya3J4cOT7IAGfmYNREz3hC4o6Xst4RDWV6eZfB7k1qZA1ivP89thjo+UFkSKl3aTwFHdenr3stMMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyy6Xt3WmzNihqPvcBrs0beIQDu+ENLonfXJsLABu/U=;
 b=WJwQcrXoYxaV1vw+EVbGDZ/FAi3W4VUjh1Y+N90KjAMSZq0yqIKDUlhsaB1WPbRF1h19yLQEdiY2eJJtz5UvP46p1/WuCZjWGGePbCmAIU3dfKjY3eDnRG6U6ZPOA+2UxIKxPKlFmwP74TxAM3NRFwEj7gpIgrWQVwy2viXVq2WbP8nbOcIOuUzCTfUwdJMNnPNsHrGIoZKTlsxBpL8TQMOXZvYUoOtT+KI37JjAIETgczUBO+2/jCieQq7QY+bRcpr+VgldKPkM7y6bY93IqowtEWITFHAXzckvcQTfjxCRUO/GaVv9DFngKNJp5i6p02d3gJVvXew26nz70IfQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyy6Xt3WmzNihqPvcBrs0beIQDu+ENLonfXJsLABu/U=;
 b=ShcqTWZVeqPi0vXLmHC6iJk/ddp6IpLH3YzN5SKJqBtDmGaRfePjMH7qGOL2d5yrw6rg8jRnSZoXHzWR3xMia5WEJkaur6B7FYRfDOkxQP6QVZ0aZaW7RGbC9+07w7cb0uWvg5ehTxlmYpegP+3GcwZooYB2ZPfIADGddfZFKD9+9ezQAYsvRq/1vf2Keg0t18rAgebGOAZE7tm3bnTducy17jIEip9RCIDO5hlD7fcqmu6842fMZjKCl/9VrorP+NLE9uaJmWA6pxR42HHPgUl0endbTVMy7uL9H1NeAm1MvR1Mzrt/lkly8cJQL0wHACFH8BLt7T4fgS2x4l3e3g==
Received: from PH7PR02CA0016.namprd02.prod.outlook.com (2603:10b6:510:33d::15)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 19 May
 2026 10:40:17 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::fd) by PH7PR02CA0016.outlook.office365.com
 (2603:10b6:510:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:03 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:59 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 26/32] system/physmem: Add qemu_ram_backend_pagesize_min()
 helper
Date: Tue, 19 May 2026 11:37:04 +0100
Message-ID: <20260519103727.899332-27-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f37f408-9eec-4e52-eb46-08deb593045d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|22082099003|56012099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: fkhKHeo8GGbihgb1Y+baU+9yL9zhFH84DkxeWueyKAKyjFlghk9Ksy6Dk7L8qPdcIqDUpL2i41/G1wkd5iOWgMdRcGGvZlJyJHuu7g1XJJ3HlJBSqbQKUKHXI+KR3iXKvATheZIX+PXVxpA9bLPwlgQEpzH87vB1y2d/IpmS+PAFeoJyTgZV0H79hminS+iqcSEMCa75IiFKNO9OET5RJMFPV/DuaMzfYEaMS4QLnN3QEjMWejoTdypRHrrWzZVWIHjKq2+ktwAB9wUqxN4X530nu0vFYStxA/xJywXnZrOGKKpxI62KVjkTrSkL6iRt6xhj7zyF2iYTv1Joj/eXWfqcYupSLNM196pkgC6HaxSYBigFeftupB7ZKDZnuFuoS6YXXYeaXTcCWClzaMstfFfLwAvu8wKZnfHboUEVBhGwcw+cOR1lb7dm1vhhj6cwUA8PB1Td5lzZoY1sjBwgrFZ9YCkveJiadcFJB+6DEq7ImatlAnlO2nQlLQIvOpqPIEl/gIBRooy2+rAK3mW++02w0vWCf8UuvtSMXdcs/NxbEXTwecSJaMfc0kMpceR5QLVdPvXErkNHWfVoVbmWNcYbyt4zUzWEHV2CkjrDpHp1pDL4qNdh8IPQru/5d8LNC6QBJYYZDEhwCMa0EHI0Ec1aat1tgLkIJy7uE/vh7anLG3epi/LWUmkDIQWykeKpPNO62MK5+4QyjVqDdGa/Cx34W2K6fjrTdmREv5Y2spM=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(22082099003)(56012099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4NGoBM4IK+LFeA/qA60mD1RYqEjTjnunX/HAn+5bYcto1A9Y8V3et5ox3TLypLxuTMLctVw61S8S5iuPHVVf8Bq20JFimEODTDUkQilvN76XTvM2MMuuI/To3fJoigd8t73idGIbnq1YcehgVi56UgpznqnndIkeAojsLDPUmqhPZKhjqc1dUjiMcq/mcjY9lVrbLTB9xuxUpgZTv+OLZ2/t8tPeY6BCVaL1JmEYOtvN7lV7+pweyYXCmDsSuolSC4k4w/Bhpzw4/nz8erul5Bxnq2OUK4zkS/f92vda31d5T8Y46zd1KIUq6W2XzbDYZ07WpBhElcKelvHYZ3ObxAQ5pa8Hf6QhkBZK9Qoeiov+6sR8j3qwFoG5ec8t78LJDd9WxG05jH4wrZ3RNLIV7QrIKxu2KzO7HhdHPNVMEu5kb01v94a43LJ++NxADV7J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:17.0346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f37f408-9eec-4e52-eb46-08deb593045d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Some hardware accelerators DMA directly to the host physical address
of a guest-resident buffer (e.g. set up via IOMMUFD). The HPA is
contiguous only within a single host backing page; a buffer larger
than the smallest backing page in use may span non-contiguous host
pages and fault.

Introduce qemu_ram_backend_pagesize_min(), which returns the smallest
page size among RAM regions backed by a memory-backend object. Falls
back to qemu_real_host_page_size() if no memory-backend RAM blocks
are found. Callers can use this to bound the size of buffers that
must remain host-physically contiguous.

A subsequent Tegra241 CMDQV support patch will use this to bound the
command queue size exposed to the guest.

Cc: Peter Xu <peterx@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/ramblock.h |  1 +
 system/physmem.c          | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 4435f8d55f..7f7ea53557 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -175,6 +175,7 @@ int qemu_ram_get_fd(const RAMBlock *rb);
 
 size_t qemu_ram_pagesize(const RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
+size_t qemu_ram_backend_pagesize_min(void);
 #include "exec/target_page.h"
 #include "exec/hwaddr.h"
 
diff --git a/system/physmem.c b/system/physmem.c
index 46b36c7b10..7ccec52aa2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1999,6 +1999,35 @@ size_t qemu_ram_pagesize_largest(void)
     return largest;
 }
 
+/*
+ * Returns the smallest page size among RAM regions backed by a
+ * memory-backend object. Falls back to qemu_real_host_page_size() if no
+ * memory-backend RAM blocks are found.
+ */
+size_t qemu_ram_backend_pagesize_min(void)
+{
+    RAMBlock *rb;
+    size_t pg, min_pg = SIZE_MAX;
+
+    RAMBLOCK_FOREACH(rb) {
+        MemoryRegion *mr = rb->mr;
+
+        if (!mr || !memory_region_is_ram(mr)) {
+            continue;
+        }
+        if (!object_dynamic_cast(mr->owner, TYPE_MEMORY_BACKEND)) {
+            continue;
+        }
+
+        pg = qemu_ram_pagesize(rb);
+        if (pg && pg < min_pg) {
+            min_pg = pg;
+        }
+    }
+
+    return (min_pg == SIZE_MAX) ? qemu_real_host_page_size() : min_pg;
+}
+
 static int memory_try_enable_merging(void *addr, size_t len)
 {
     if (!machine_mem_merge(current_machine)) {
-- 
2.43.0


