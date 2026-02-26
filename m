Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572DBFC592C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzc-0006FY-Sh; Thu, 26 Feb 2026 05:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYza-00065Q-T2; Thu, 26 Feb 2026 05:53:14 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzZ-0000wl-8V; Thu, 26 Feb 2026 05:53:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIg7bXMVcNCF7x0Pa0EkQWivlqmXZMAakFMIp2yDYVuDeoi4H3m99xNVut4DcoTM3AOBcRToq5T1wZccK5DFrtLVxPkXtFMZ1xfN/hZMelYbyHOSOGxi7/0iLLtZvS0FmcGfOLWgz4S4kMKnc3yciCbe0oa2Y6fXg8UltfVUcW+3PUMgmv966gUSbJPYdvZbYesXIeuaELW5ArXmEg7yPOMxmak+hltlkVIwMsWQvzPKnM4k9DpbUOscdCZjvvTv2M/SLH/Sev1YgEPn19zcuYcb3yTnXjNZiIR80quNfY2pu2srOGcOxLL1xdNz6qSMTR2Zwrz9NGLl1tPSk2nHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtdlVXQ+Ar62xpkD5o9kVA6sZGzHZiJzZI/a6YWBCkU=;
 b=b4pi5/brJHOqADyFuRCttRLjhBBhJvokdWFVnroxh4gXWxQ/xIb4DA9aJaLqr0nWXpl45FJqHguAS0RVkL/xB27NSvyGJgE4FaC+pfvgkkwRnoLcpaGf9/MVsAJ9Bx/R9XhZHJxidBeDoFksmsUIAaUXBNzbv6/tBJh9dVxcSZ2EUZvZPXku0XCW6jtcyxKiUtM0INBfFLXNrjQ0d5HI1MyZ0onpM+x6c0gXPdvHibzFbXKH2aEQC8MKHk/4jTReJ+4QUPkY+tavQy7PMMW8YpYG5xe74kCtAFVxXaCSo0QnOFyGHtrmHud1bguMTQRlIGp2/TeTbYJ+Ok+zsddyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtdlVXQ+Ar62xpkD5o9kVA6sZGzHZiJzZI/a6YWBCkU=;
 b=OxbyFv1qGzqC20w5H5boal2an/W9+0OL25keRpdTUxidcTuDkXjSXfo8ZNd5VXI8cMkeMCmaedicGegqE4vv2ecZi2TT+5g78sydab6exDszMn8dYCSZ+11FXXVjmUOfzKXtU1/E1Sk41RcDwlnGt36s/tzkqk6FvyjE/aFzfueNPnBRX/+jWqe6lM9agsBdo/2F9OwhHG43R8688MmVAV1ePQ3umSCiCrJeP49VMfkojhUTOBoXlXSvVGZz8+Zefvn3BY98RPd/imtyQISepKBn8z39SYqhCwoLdSijnESRi9GrMWTvbloo6ZaRinbQjITJc67vS8hWZoCkw0J8Ng==
Received: from PH8P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::28)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 10:52:47 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::f4) by PH8P220CA0018.outlook.office365.com
 (2603:10b6:510:345::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:28 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:25 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 16/32] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register writes
Date: Thu, 26 Feb 2026 10:50:40 +0000
Message-ID: <20260226105056.897-17-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 81746200-4b4c-4435-3204-08de75252dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: hZO5gsWpyGAIqZWWL1nKF8L7ynMSZpO7X5BaTvldjtxFC/Ni/dLrm16JmRhLJugOKF79KWZ6DZIoNxS0baRM9oklmE55cxrJZhVV37abZQSG8jBzR9iWGrrunskozkep60n9iVFOtWS0ePLuJZ3Rr+MXTaU69FrFs40wXui0a+qAT4mOqBOk7Vm7t2JvGgxTH9sUPU43j7tRX0VbqCWdw/0z6I7jZAIMbjaj/MONj64KiER9W1rcJmog3JKrnUCpXKVxd7yC6PjvLd1z913aguE54+oTkjAveSXVOy1nUMgq8xU9lIJR1/q8dLlwp7l1uWyQb0khh4/v05g/FTf6W+xX7WR5ZTr+v6z1AB+7fW6BqRC5Majejq9co+WZoTyhG+Xwh28FMb7GDaQmc1DN0EWahE1qjrPD5wU4sj1RF56ybKgz0Ody081CGmExDhFGV3DlWbWYExh6cvp8+LqouSW1ZUp6XWaSuBy4B51UiSgppXU1VRSDTLdvkMddRg+lw2dG2naiMFZMIfm5SQo3m0C+jo/LtOYR7aRIRJALDnOfA2pW94lIsqsZVxOjlqaV5zpDsZFsq/vXuR0HgY7Go31swSKddnotxG1EDI6XDoTI/v27bOsc+sG74o04SvWK+MpCz7tDQMwbNidrm3sZ/r5stoE3ZvU4+DeEFI1kYovbJcV8aWSEJQhBKuyt0gpmVq+g+InZJDCNu+rmhC2SQTe5a7CW8/zTqDw4nSU6fqPNrmHOaeZlPrnm7JLlWvtaAEvmMmp16yVsCrD/V8PQxvgm7IoHo20ZnErIMp4gFGXm1L4qdlkAgpc2g8qPhFcJ34RvtLukWHfxtgJvgCxzaA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UFs2WNcrVhXyGNl2h/IYdGWrNUGJBtzaVE/D2ppYRd1o5sO/jbvVsMPjbjo+VKQdBJOLYaSOQwb+l6zb2WvlwjmwuRcYIPSk1Aco14iBW2yHWmFY9zAmOZczDOKl41pgphph3uFnFMT2hAQ7CrtxDvo6SDboufxkYWf9oC9LF6AcqQM4hv2vDapC0jOQUgdGV1J5s+0jt6uCfT4n8mmWeWF7MNpp0CycZ672/QIaB2WTi+3i73aDkBbYQ2zKLPfsYRvLzfpAlCObnhA9tjD2DypwIrKsixrNh/vrEFEiPaYPv1UuNIRNXw80WF+H0yHVG/K0CAzab46yxGDrIZQ7ZNtcsLs4ZmxOvMfyaTrBuyUg2x/w/Or7eWgXG/eoXQ0UZMTpWRWMogiLnTH/IePR2DCfD/3CWGT9Q6gsnz8qWQwwbXiVB+qqLdZ9G1dhVH3v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:47.1897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81746200-4b4c-4435-3204-08de75252dcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

This is the write side counterpart of the VCMDQ read emulation.

Add write handling for global VCMDQ and VI_VCMDQ register windows.
Per-VCMDQ accesses are decoded into a VCMDQ index and normalized to
VCMDQ0_* offsets, reusing the same layout assumptions as the read path.

VI_VCMDQ registers are treated as a logical alias of the global VCMDQ
registers and share the same decoding logic.

Writes are backed by cached register state only; no hardware queue
mapping is performed yet.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 83 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index d2e6938e44..e1f1562c44 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -151,6 +151,70 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
     }
 }
 
+/*
+ * Write a VCMDQ register using VCMDQ0_* offsets.
+ *
+ * The caller normalizes the MMIO offset such that @offset0 always refers
+ * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ */
+static void
+tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
+                           uint64_t value, unsigned size)
+{
+    switch (offset0) {
+    case A_VCMDQ0_CONS_INDX:
+        cmdqv->vcmdq_cons_indx[index] = value;
+        return;
+    case A_VCMDQ0_PROD_INDX:
+        cmdqv->vcmdq_prod_indx[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_CONFIG:
+        if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
+            cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        } else {
+            cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        }
+        cmdqv->vcmdq_config[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_GERRORN:
+        cmdqv->vcmdq_gerrorn[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_BASE_L:
+        if (size == 8) {
+            cmdqv->vcmdq_base[index] = value;
+        } else if (size == 4) {
+            cmdqv->vcmdq_base[index] =
+                (cmdqv->vcmdq_base[index] & 0xffffffff00000000ULL) |
+                (value & 0xffffffffULL);
+        }
+        return;
+    case A_VCMDQ0_BASE_H:
+        cmdqv->vcmdq_base[index] =
+            (cmdqv->vcmdq_base[index] & 0xffffffffULL) |
+            ((uint64_t)value << 32);
+        return;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        if (size == 8) {
+            cmdqv->vcmdq_cons_indx_base[index] = value;
+        } else if (size == 4) {
+            cmdqv->vcmdq_cons_indx_base[index] =
+                (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffff00000000ULL) |
+                (value & 0xffffffffULL);
+        }
+        return;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        cmdqv->vcmdq_cons_indx_base[index] =
+            (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffffULL) |
+            ((uint64_t)value << 32);
+        return;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+        return;
+    }
+}
+
 static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
                                        uint64_t value)
 {
@@ -187,6 +251,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
                                  unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    int index;
 
     if (offset >= TEGRA241_CMDQV_IO_LEN) {
         qemu_log_mask(LOG_UNIMP,
@@ -213,6 +278,24 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         tegra241_cmdqv_write_vintf(cmdqv, offset, value);
         break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
+        /* Same decoding as read() case: See comments above */
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
+        index = (offset - 0x10000) / 0x80;
+        tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
+                                   size);
+        break;
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same decoding as read() case: See comments above */
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - 0x20000) / 0x80;
+        tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
+                                   size);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
-- 
2.43.0


