Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A8FFC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzf-0006Qo-Bu; Thu, 26 Feb 2026 05:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzd-0006GS-0K; Thu, 26 Feb 2026 05:53:17 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzb-0000wv-Fn; Thu, 26 Feb 2026 05:53:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgDk2CmUIsayL9vUNY17Ol6fClmF68fcJOymD3oqL0Jb3DBeOCb9TPof17i9zN/BQuIOd8DMOZee8WR0hkkr0XO06Q7ZQKbcNjso2xYQwi9Ix3NUwY7Z5yyyIqaWG2yMA1T9h5DcVa2agJbcxEHeO1ofu2yjlZs6noOFmi0rdY5msw1gvWBE+gldg4eRqkr7PUg5xvPcAHhLzHH+wXeu3gPrgWOvEucD84d1MseBSMqaRCTnb7scR9Z+lQHh7YLlkNHUEHaInltFefMOQDOLhAq/8D0VXOtLeq5m6sVT1203VxEquqA/MRFVNLTzUO9W85EW3nTkxL2rdrJUUy7wXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yp8P7Ylbz3ytWK2EoUZQGTemxRt5gkJftSGzBDQSTM8=;
 b=aF89obXH6QpquzK0hHnJyD5zbsgNW/EGxX7sCguvZ+XjCokdV15AVbyvLZDDJZ9YabJ6TwNm87pGXTeYt2IkvjwBkFv5zjpyZMHgCN51i3njrAp8g0ZnmKu1nsFGe3VwWaewGhD+aXtInnYSjc4wRCJu5FCTQ4cYpWpzqrxLkxoMPzvnCQxRXesBa+851a0RpOo6LsVvNSeeuj7Ps0XhXIEl9kcQ7YYlXsdEpIeEYgRgQKcZe8zxFcsxg8LXL1eFMbl2tf6m8U1lkxc7JbhtgjY4VzLfm1vuZbbwWyXmqim5xYwpuTLweZML7GV94wMu55DAMmYwYSI0As+IkMr/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yp8P7Ylbz3ytWK2EoUZQGTemxRt5gkJftSGzBDQSTM8=;
 b=MPZ8Yb5aAmxrW2gV822i12HAdVcZCid53HD15lWwZW8+eSIXFabKGcgd31lFviKqkoGxtqkygG6FlnmMdt+v/beraI9YaZYWCwQ6kvD0QhASM4PG5zo2sZTn0XslufekHwxDIPMJ+pNlrOhVCPe/V+aOGFRROLEdybGKTjq+AIoaS/P8JF0LKGWnpnyDXlT40wfpAusVmb5b+046fHCboDroCuOqjPQYZpy6dM84v3STQmSo5l+OByvhovXRiUWBTp0C8ZQQOM57JDvGf/3HKm/IOrLEPlZeq0mdPgNmVuH/EKCOelxXMYAJb7EKU0nes05WRRP+EVgTy/FZ8Eup1Q==
Received: from SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 10:53:07 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::3f) by SA9P223CA0029.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:44 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:41 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 20/32] hw/arm/tegra241-cmdqv: Use mmap'ed VINTF page0 as
 VCMDQ backing
Date: Thu, 26 Feb 2026 10:50:44 +0000
Message-ID: <20260226105056.897-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1c2047-7978-4414-1b03-08de7525394f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: m1DNFF4HzQdUhK8jcfMKOQC5e3KS5LVszG7kQX3o5mZ752muw8qCrI+s+/2zQSXlRVCCGYLXoN7ICf91yQ3+O3lL7YPF+5rfZpeqt8LSwHy65bNCKhsPP0xP80+DstnPbzkWY8PN/L+3zJGzCl1HHeX0Za7v5Yv60i0Ur38Es6GFEmA1567u8gcM9awGzhl+BaWXz+3SIqOVDjSSk4XBfpAMn63RR9ncdObfdSlnlw1yzube5+g4x3njHQkQLjVMCRAaqe1avtgKF/L4kVnonhWi7a95rbWFe0+nh//GjL7h1tpc4T2J4AXh9iJggqzbRK4MDJxCSfiphm39J6+zw+cAXymgDoGVA+kDDzRVyu1IKOmk0dPwwhmY9UYQyGCAudGE2MvkV9ZDwh7262jDkDYgCYmmTKJBHaqqLJNuulkNiFLUzJ8biuqe2Csq1wFfkm8eNMIt6zPOyy1Z/CFG9jbmBREz4ss20hlpi8zOLLHArdTyPbWGsfCfuP+Blr1uNGTm2E5mBtsK4HAHk89KIM7LmzhveKfeCxLOEjDkjKGwHh9uonvRUbmbTzjWJLPysZb3TQXDTcntOKJWi8vLQro/C8dkYj3/NrpsDw6zDezdinL4MvTPYKr5lB/Y2O3G+ytBGJ8vf5yVpl7WRR8cP1GLhrp55QEtbbhfmVoC00EAsuMnHyanqujB4seMhcrbStfi/u7+jXQHvvB1pIwwq0DIqUpAiwbaex/YzC7YE8OQHpBiZaUm0hz3AvzJo/r6nhR59mlI2W8bNeXvq5VA4XirYNYFY6+f2TmhRuUP6eTQ+2O1uUAcahHDma+gNF9rv3F+fjbWNvRfJtkXnpvnuQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dd5R0rKrgqUi6lmNgHL5FSVEWxqhx1mGTqCykLeJl+ZL9+puxeUMnRsGVffmDGkCM27t7WBM5uPPb3pECOwK9IAvTnrQpeisTaTKxYPAXuLXaUJ2dmDAYTX0VVsrmMA+Ch35IDPJLJBnoxphOcLz/Ra74qZaALy0VihPjfGh45S7lfUumKfIcqkwMxZBFa2cU3TNpJLHMLlhN9vxjKAKnqnfGks8Yz+nm459R5rAu9P2UZbaIJoIbCMIWVoamIForoao8ZUB2XzNlgLp+I260Kc5AkUXt8d4IFoFfrx/98PKB24o3i1Xa2pqTciwzZablxU7VI8U3FVOEFy7RkDSkAXmh7oO2nXkX/F1/mOlJh3Ogaki4qsrF5vSYgY3JSfa0FL9YM62+TS4NwgyiBICnQEH2lh8DlDAKEJi/N72b+5A2lHgoA/Uu1vIqixnMVWD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:06.5943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1c2047-7978-4414-1b03-08de7525394f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

When a VCMDQ is allocated and VINTF page0 has been mmap'ed from the
kernel, access the VCMDQ registers directly through the VINTF page0
backing instead of using QEMU's cached register state.

VINTF page0 provides the backing memory region for VCMDQ registers
once a hardware queue is created. In that case, reads and writes
should reflect the live backing state.

If a VCMDQ is not allocated, or if VINTF page0 is not available,
continue to use the cached register values maintained by QEMU.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 47 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 002dde50fc..17b9552906 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -14,17 +14,44 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
+                                                 int index, hwaddr offset0)
+{
+    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
+        return NULL;
+    }
+
+    return (uint32_t *)(cmdqv->vintf_page0 + (index * 0x80) +
+                        (offset0 - 0x10000));
+}
 /*
  * Read a VCMDQ register using VCMDQ0_* offsets.
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
  *
- * All VCMDQ accesses return cached registers.
+ * If the VCMDQ is allocated and VINTF page0 is mmap'ed, read directly
+ * from the VINTF page0 backing. Otherwise, fall back to cached state.
  */
 static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
                                           int index)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
+
+    if (ptr) {
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_STATUS:
+        case A_VCMDQ0_GERROR:
+        case A_VCMDQ0_GERRORN:
+            return *ptr;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         return cmdqv->vcmdq_cons_indx[index];
@@ -250,11 +277,29 @@ static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * If the VCMDQ is allocated and VINTF page0 is mmap'ed, write directly
+ * to the VINTF page0 backing. Otherwise, update cached state.
  */
 static void
 tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
                            uint64_t value, unsigned size, Error **errp)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
+
+    if (ptr) {
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_GERRORN:
+            *ptr = (uint32_t)value;
+            return;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         cmdqv->vcmdq_cons_indx[index] = value;
-- 
2.43.0


