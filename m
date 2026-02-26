Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B74FC592E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYz5-0004gg-72; Thu, 26 Feb 2026 05:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYz1-0004cJ-DU; Thu, 26 Feb 2026 05:52:39 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYz0-0000mU-3n; Thu, 26 Feb 2026 05:52:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTvPLC/4rhRMb8fuvQnpp9tpTdfBcDfyjMorIZXAOGiehfGwc4ndqraxCnjxdVoAKl814QxFW9YvicASYYx8WsuETOqrKSNYAjv2xvcgpd5stLT9c55uC3mX0ZMGFm58twSTVSTcdRinsHYHVFIKgv9y3RhwcnvIpFKFpeQlHK2aaNxK5TNM9bXs7OgCSvJ9J5f+OtB3ra+MPMehXLTtPcP5fIQF8jFsuz6vgyJ9u6gPr7ezqrmBfV+DzmjizjUm2PkvbEhcuOdxhNhRrSqq6eWfFZm91RnzJgBSFwJOBar/waTr0vF+tCKshm1wm3Ehe0RUU6+6gHYAewN0RhQuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH1RaeibYDkJ5ZRNRJpc87DXVbALmF1hyEOhxcJ9AOI=;
 b=R/5otNqgqaRiZe2wQYRnOngGxZxF4Lok84UeVcCRER27pM9S73ly5t9plwc309gYDHcCeBe2+UOHllMU4UEZgB5HbfSwqiI/2t8Cpr7F1pPPIE3Jeh7BS1f63pLeEjmCEIZG4VEnIbsVuTHs6968pht2VgDfaJo1fO6Iso/iesYmOmFEphzjFigiqNspVpBErh3XG8CnQZYIMzr38dmBocUhcLn1m41cr7H3K4/Nyn8J6KGMu4KaLlqP/T0gmiV1RXDGAG8oAS9Xby3/8m9LWPRnkNMhH69TWU6QCfnj8i5NENvJR0ZczhJ4jFHgZ48jKZ9K192d5pq3Qijr06BAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qH1RaeibYDkJ5ZRNRJpc87DXVbALmF1hyEOhxcJ9AOI=;
 b=bHnxZWroswFFplWjmwf384kq9LgEoZcj3OiwpZZDeQXDyaeBEtFAaSCaz23Wb/LmUfJtidEIvKgQugohaFbeNn2sE8WTB/XjFkTsc0IyaL53qLrrtreIfQoFuuT2ummfoxr6aJKI/KM/VFDZYl2AXnzENZL/GIioMO6dGjCV9olVDgqGcvArBKfA5cenxMjoDC72iTdFm+6gTjkhl+jQjegAB+1tVFesukDcNJlBGgdcPgLlpx+0gX6m+H7Yw0rprPqgdDOqTcbXKhxAdARQcGceOwtJasTV4TXN5cqkMHnqwpBiItaMoyszsvXIRyd+iz+HMdDfQUgQVEhM4uaujQ==
Received: from SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::19)
 by LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 10:52:30 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::75) by SA1P222CA0125.outlook.office365.com
 (2603:10b6:806:3c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:52:30 +0000
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
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:11 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:08 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 12/32] hw/arm/virt: Link SMMUv3 CMDQV resources to platform
 bus
Date: Thu, 26 Feb 2026 10:50:36 +0000
Message-ID: <20260226105056.897-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 911d4a6d-3e1b-4f69-b197-08de75252338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: 0REvlEKX4QgNpC/Utg+7ZWUKzk+6o2Dy6V3T+/XzhoLuuMT5Hr21xRXn8R+WjPfkoCZ0VIAT89m5sYzAwho+V/8GGcMvvuCQtUE/g/vsfH05F46tyxkDsu5/MWD1mz2L7p3uTM30vzCVSbdRyr1VmhEj2L19g8xdk3HHHkoKTSFxRj/bwm18Ozz/zm9Y68k0dhnaccFQhplwKVLVnvxZm2IjIDjedWCM7+fRkau8e/omgkb2sMrO0RL3qSK/ncEPty0GuHkBg7GxBPWZXkByO8GZ+MAsbbB+TETIAbaBPCOzsJ2dUykmDfVp0zWgv7sIU80gqFX5SWZbWTZSBpsqjz2hEdjQdT7jc2TKlwdd7I8fCQvdAwjcuocTt5gbw9u6mgH3/AcRJS7Vaiav8Vv7MJg8bMTo9U+TwysKh0HWI7kABq25mBeIJoKmeYuhDZs/MZqxjFu1PoZ1ps4+RBUMSRUDlQgQtgeYsZSqeATzknNjnEw2IXlh5d3tS5y+2XAV4y2Fa9xfXmufoCJXjkMNEgUhWDHsoaHyX9fq4Cgk91fjvfKXc9oj1bQHMM1HxHzXO3ab7lVIPZYfd7NQNK8OvFAhCBK3dZVlY1KY+9JBSApOekv29rowQa04pUyu4jevq2UJEnapGUd1TpGMxq9mtvqRmr5+pAxCu0Vn0o2diLNaPj9So8UTbPZEsZnDZF0Ptt9kP1JAn93TWmuDXVvCwJJVxLMcvQ9u+ZorviR1uEwCUteSB09tJuJutlSsVe4Hapuv1MI9hPeMgTe5/gyB9CPDDxdwenmTgcwj74V28z5Ne/LIWFipiolcXaNkZJ5yeuyMlj0iWJPvgyjpBp/vsg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hptKTS08k6UndM+tLXwOUtj59jJq7reCS6PYWYT3I76+aavWyjm9/Zej81Hr0PrAUICewLBu1dtRoUoup0+atvHLndyw3AXmHEfuw++N53Mv6ZcgsnxYsR/s/Cbt012iTFt9DvGEotnYI945MiRVBumYDKa+Km2YU7SRFKKr1BzFpQukFAYIt54G8hy2A4nH2v5rqAVmXN1pgCS99qGhTy5J2IaaOHHAiVzeNs1aGaz26/w8ygN1Pr70u462LrJLj2geJGwImELTDgCbtVrokQh8s+6oKkmz1ytzGv7HkWajKyQsP7i7QndQTd5DguoPGdm+VdbANtKaoGxB/X5f1rjTmIKHN/zoQyyy1Mtip8t64L1YTK6TEvgrefem6cXn+/brE96/oT51eocVab5OXcMFIPruH3jmNh9newFBhfGnIV2RWaOGks8RFz/TNZ0a
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:29.5818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 911d4a6d-3e1b-4f69-b197-08de75252338
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

SMMUv3 devices with acceleration may enable CMDQV extensions
after device realize. In that case, additional MMIO regions and
IRQ lines may be registered but not yet mapped to the platform bus.

Ensure SMMUv3 device resources are linked to the platform bus
during machine_done().

This is safe to do unconditionally since the platform bus helpers
skip resources that are already mapped.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 292e523664..c75a8d6e9e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1833,6 +1833,24 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 }
 
+/*
+ * SMMUv3 devices with acceleration may enable CMDQV extensions
+ * after device realize. In that case, additional MMIO regions and
+ * IRQ lines may be registered but not yet mapped to the platform bus.
+ *
+ * Ensure all resources are linked to the platform bus before final
+ * machine setup.
+ */
+
+static void virt_smmuv3_dev_link_cmdqv(VirtMachineState *vms)
+{
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        DeviceState *dev = g_ptr_array_index(vms->smmuv3_devices, i);
+        platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
+                                 SYS_BUS_DEVICE(dev));
+    }
+}
+
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
@@ -1849,6 +1867,9 @@ void virt_machine_done(Notifier *notifier, void *data)
     if (vms->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
     }
+
+    virt_smmuv3_dev_link_cmdqv(vms);
+
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
-- 
2.43.0


