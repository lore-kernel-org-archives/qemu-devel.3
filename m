Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D868AEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNAf-00012G-Oh; Fri, 06 Feb 2026 09:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNA6-0000du-19; Fri, 06 Feb 2026 09:50:22 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNA3-0007OD-Ik; Fri, 06 Feb 2026 09:50:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bktfbV09XjTUpn4QiUpzw59UcWbfVLGKMrCXg3BHojmbTuDe3hk4FzYhMCHpDmsq2oIwKvm0pXxfPGJ3zEOnxmyYIsaQId2PKrTuAQyQi3kVEgeedCwpp2coXQ7u8ORMTnTfEQNP+xuZZVa3D/sOkCScmXT00RN69DwHOoAwFi9bjmaMycxRWpMyE7c/gM8y5um+7LArNnjCWIZhkCl04/NNZtN0Z9imkGrC5xTxYjz5H1Pa3GFhNBxeQ14DCZKvieyUqsja9Xc8I9wLJvp2l3UGPLR5nopTHN/tiM5ymnuHB8Zq67CPk6gsn9mkpa8XqB2nLjYsYPpLmlk8e8SStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h5lEECsl2DUU1+JjLdSCZ9vzMUtUDFqe8JbWtVDL8A=;
 b=FvoFIJUeXBzwcHEa7epwp+7uFxzlFLtpeGELguOPnYs5wnLu71QNrigIdf61DRFKgv61rK5A3mI0iPXcbakyyBHfVY1BJLzaqnuOb8wAWZ/yUiV/xK9GS/DEnWUpGFpHVpRKzO3FnPHsQjY2GQvlz+pyboM0C8+iRB8wpZgT7Lzm6+GWkZ3DYuk786qBCGGB8dgcORaj0wLCX7Tx8emg7x7v/Kp3/g0Kq4/P/nqZS5fMfz7RmLyde8jR42M2zsD3/6PQsHB7bZZss4eF4PmQfc6fh7LvFOA2SUG849wRWEUJF3v5U8ILSYad6a5BtidMFCnvdLViLwm5ZOhdgO1Xdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h5lEECsl2DUU1+JjLdSCZ9vzMUtUDFqe8JbWtVDL8A=;
 b=uJ00TPFAth0yTSbGIy5o5+JZP2alXywFzr53gFeANZ1JIn6Fk7DwRfllY07owk83VoEG6eFcdoGTO0CeDq267vTiJR/DoFzzT7EGnIR1p9Sz6MbjaJKVw3mdtw24P+NduVg5kfaY1n0kPJ5N03ILB19Tj7Md38gJZBSTvPx7+Cl7Q3MkV5RePhjHjxSg2dIVwfqZLtHAPCG0d8y4cne/hOoB+cGXdsNVs0a6TYrIU6TcNjIoAbs8krAwCYCf5c1WSMYKeqV2DAxhig0KzFFWU90BOprbRDnPWNf9Sl3cMFtexyEfGM+w8TQyYhcc0H1eQ5P8PWrsvAEaxpTw1GxSlA==
Received: from BYAPR11CA0104.namprd11.prod.outlook.com (2603:10b6:a03:f4::45)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:50:14 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::8d) by BYAPR11CA0104.outlook.office365.com
 (2603:10b6:a03:f4::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 14:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:50 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 12/24] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register writes
Date: Fri, 6 Feb 2026 14:48:11 +0000
Message-ID: <20260206144823.80655-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: afb8d0a2-9b64-4c2b-c903-08de658f094d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hf16gK9fzry82P7CY990rUPbUPOiDTJHw8HIaGXJjRUsVY0Ucmor5cPW/ElL?=
 =?us-ascii?Q?PAOyDu3IfSXc10wu4ZeIftRKHSdM5/y62v71nNdQiAa45JDcBwR2JwUdXy47?=
 =?us-ascii?Q?MLVlCaqHS63o6VQuT0j2YlYkbtwfajE68teOViYp+WK9p5UlVslwpDUI3M6M?=
 =?us-ascii?Q?40mcfzYffOfdgth4C4O5sLvga9JP9zXQ0+bsN1Z/jdpGhFWvaQq3ZwarTGMq?=
 =?us-ascii?Q?W2GeqcOjAdmWN3GdEGkAPy77fFEWGHFeT+vhZVUJeTl9VIUZnSCs0j3yFvDj?=
 =?us-ascii?Q?TtVyWL4xWfeQXEpjfYnBfOs1eCNmMkxqlEyutKNTY3uGPNHrQgAwPJjbRppa?=
 =?us-ascii?Q?5Ifhooj/iYT7WXIhnHF6sMLbYriRiHEdndznp0HXuy7e/rwHhA91UuYoPtPQ?=
 =?us-ascii?Q?ULpIxHBOmFP0t9DeID8K/p0GZE5ATShn6vqb2RAHkoWCLpcCUsldcPfo49YN?=
 =?us-ascii?Q?jM38PumZaNdIALyZBZKvFjtOdZxfSq6x3m7/8EyFyq1u5KW3H5cxpejUiP04?=
 =?us-ascii?Q?5zeF0t4VFfAqzosAEmmxshnD/BSDy3SFrXceVmoj2UQ4RfAEK725I+GkQQ7R?=
 =?us-ascii?Q?+VXaFAoA8H8T3Tmxz3zCtylNeMVUt+7uirGKPQswSUay/I736OJw0B2gM/xQ?=
 =?us-ascii?Q?5orCr3Fg+IlvYTHUzoOZKbGQdJf4bLlBeWaggBZUB2PaxWNVS4/sfRt1R1gY?=
 =?us-ascii?Q?EDnCXdPC3EY1CMLseMuprguJ0ml/b+9Ou5+CEv/B+p08uOpKnuHH1egGQQXg?=
 =?us-ascii?Q?WdZaYvFJVjeQD/ZwHAHT0fUpNjCwYl9oKFQYo9Fz4RVaJTdnBOEzqg0czJ4d?=
 =?us-ascii?Q?p7oQGLeFQS5u98S9rnDe8A2HdINbVLyORs8/XddYHo21IyebnL1Ub94ouDkw?=
 =?us-ascii?Q?y8Eqqqhej4hfHGn/dkgNLDeRfD4l9UfXTa5p5Q0sU4NpmFeE396NfLb9JxMo?=
 =?us-ascii?Q?n6+dHIvWEDgZ+l3d9h013zprAYQYA+hDiIGmfCEMebWH5NpkzDgDEjI+4jQN?=
 =?us-ascii?Q?7TvC1j6Xt1Tlt6hgkvG+IQ6ozrHvv+I10suPpa6Wu1qccNr+NI5f6oE8pMwv?=
 =?us-ascii?Q?wCQjJjLjPRfFc1D93PxdLl7RQmLfMbYx2RwDmm1t5A+PbzxFbW2DVkYTB1jS?=
 =?us-ascii?Q?NL/znhgdnM3Tn1M+ZxB9NNKAzOsVLMmTpg//jebQ/2JwEfrB/aM4I8behSGG?=
 =?us-ascii?Q?KbpeR2kfukbs5yEdF79Jz6WonfiVI9WZQP32ixnyzplfdG6/E11W/YclFmQp?=
 =?us-ascii?Q?zcNyT4u79y8UB9zU+8RAl1JDA+fezjzNrHdMQnS8lJBbbuw2I35MuJCThJBZ?=
 =?us-ascii?Q?Xc4MDdma3X1S+/1VBOr9LVK9kztuMG5y5Dw/iBDrebUVU3rxRx5naRsBaW/S?=
 =?us-ascii?Q?+jQzgbmNkrFiMw5/TZ0AMvoX6pMSlhUxGS82wvQDFSBZNHEyGLcCkkzspDn0?=
 =?us-ascii?Q?+BS7tUni2q1cl+EYx7cJiD1oqfQAjSJA2imnYGDBJ3ngCNWloWuEj+eBMKq6?=
 =?us-ascii?Q?JfAMSi+8IbkEFfLaLcAoIhvkimwX2m5DximbBspfq9FnwU4FCFFYD3f8bM4f?=
 =?us-ascii?Q?qO5OVykbWRY3QYjKex/QbF2h5GqU3jdBoQa01LhCL6vPDSiU/YZfA7hchjrO?=
 =?us-ascii?Q?5+lgir+hGFXyFa98UaMl+jpGUriNFHEZ7U0ohwpS0OJfi5SesVMBrhXskAhb?=
 =?us-ascii?Q?bY41UQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZO2JpjrsFQ+6v6K18RSyoWTip8umBTLVuUNjU4Hvn+liHP6zGoRN27u6qX+k9AyL0yLz/Ds2fF+k/r8GzkKh/cxP+S2K24Rh/Xy8XZy9Dmqdraq8LbQmTGc/eOBQZT5xA2UxX3DaXe1KPo7otOnjdtfmeEVNDNuw/AjaSqZkJlUwN5ZcmJFDSrRtpOFoOM0GFpKHpeX4x9n1D4cmVIDSywnSIDXgiC6yb0OYfQyIyKoEk8vhDmTepfyGjarlXq3krfvdmyCzzlD30GBry6dmq8RxJJqvVPNSYBjJSFb8U65FEdc5lTU1DxgUlaxiTlHJL5OUuqnDeOMyOamDdYMi1s53ru61cvSRyvaLSaK08Zmmh54a9k0A6zUvsZtBhaQfsSHlVIEicDunBQa7oYuyu5XEE3wTLOVqZb/bDdlgcKU/FY0ol+NRweLzhrDKkjsB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:14.3074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb8d0a2-9b64-4c2b-c903-08de658f094d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
 hw/arm/tegra241-cmdqv.c | 84 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 4d447718d0..71f9a43bce 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -170,6 +170,71 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
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
+
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
@@ -197,6 +262,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
     Error *local_err = NULL;
+    int index;
 
     if (!cmdqv->vintf_page0) {
         if (!tegra241_cmdqv_mmap_vintf_page0(cmdqv, &local_err)) {
@@ -230,6 +296,24 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         tegra241_cmdqv_write_vintf(cmdqv, offset, value);
         break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ127_GERRORN:
+        /* Same decoding as read() case: See comments above */
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN:
+        index = (offset - 0x10000) / 0x80;
+        tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
+                                   size);
+        break;
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ127_CONS_INDX_BASE_DRAM_H:
+        /* Same decoding as read() case: See comments above */
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ127_CONS_INDX_BASE_DRAM_H:
+        index = (offset - 0x20000) / 0x80;
+        tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
+                                   size);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
-- 
2.43.0


