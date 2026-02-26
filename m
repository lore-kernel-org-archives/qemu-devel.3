Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221ADFC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYym-0004IA-NQ; Thu, 26 Feb 2026 05:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyl-0004HO-3j; Thu, 26 Feb 2026 05:52:23 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyj-0000js-LG; Thu, 26 Feb 2026 05:52:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXMGGF4qMutcjExqB/yxhi9scMD2P4KzhKV/xjlwZhOME5TfNGk5fOkdg0sbANZXbTZC1cdW/2Cn0FvmCWwzrcBY1mFs6hF9oWi8PEZjAGMNDNs8UWy9oS0WYXrZ9D+gGfxGw0QW3ady7IpmSuSWtS9ffxM+khvWDtHehyf6626dDzYIzIXfRBJ281zQxJSnnFTMlm/WMorc3iwWu+ZGux+aeeD/ZWE26wLZxb6nRcbk2CzJDtfzzff33Me01jVXE+JDcOcq6xFPpVLRowmOJbEC9m+xNHEAkZ5IxL6Pm9d5vRGeUOuPaB47OPxP4kpQbH4V7M0uf1u6Yj/Jdgi+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj8Q14XcCmzWE31d+zXAJH4H2Osd0l8DlJG3ja3Zmng=;
 b=ST+uf87oGMqdCVUdU0wJIatYtsuSYTmqB69F1jB3pwcpAfg6+S04Ydniqb6yv8fyk9XPdmukTd1dvQL8EEYm0/wc63VRG/+nAWU+p1s2PzKNYO6QYfZCQx3b39eY5UC9D1rf9JgFJg8kQtAYZT1qPvFlHRVZmj3ybMvzftTqCIiqFJvKDNACzCxKMKrmeDItSCJPsP+G22m2nhIpe3gGsi9kBHANKm36/NQ75kvPhItYsBru0G0kiEHftZjowqZH8LZAcsoeN30r8vW9/wBqv9+wdvhj82BYQBSxF2Mul1aem7/iW14jD/tSIAK2U7Vqt+NepEUzJdpU/F43FrVqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj8Q14XcCmzWE31d+zXAJH4H2Osd0l8DlJG3ja3Zmng=;
 b=Y2fmkUkzVoURDohG2hutFjsRvlI9Q8Lw5P+YJ7UA5AnkXj8iWDr+BhvlBbi3r730ZcHpxp5fWGNQo6zcHIyRqDolR78jtHITPG1+ojPfQd4XQYUtxZMyiV8ke3f1YVeQa1nRgMTehs2KnztluzzLetLqDKtqpvqhCbVfeF91j55/bsrshBHrMqTLJ6UY8tDeDcPcB9Y38s6pjRv2oUm85PI0rNegEi5jg/k19Fu/vFEtaW3tAqgMSFYrdh6rRceUEErkQzDII50SmHhBJ3vlzWYOZp6MPfGWMZel2WZTDdiVaJ+gD3zQMQYBXW3aoUegcOdDOoPl5AthRe6AVBXe3g==
Received: from DS7PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:3b5::20)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Thu, 26 Feb
 2026 10:52:10 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::33) by DS7PR03CA0045.outlook.office365.com
 (2603:10b6:5:3b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 10:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:55 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:52 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 08/32] hw/arm/virt: Store SMMUv3 device objects in
 VirtMachineState.
Date: Thu, 26 Feb 2026 10:50:32 +0000
Message-ID: <20260226105056.897-9-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e667f59-f3d1-427a-980f-08de752517e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: JjyrxOFGGPqrrWKwrq0lMWGHe2QVTKEVH9HinPLRA/WrKWkK/23ntKzL27IPTh9HOv/Z1y+yC8FW99j1uNxaM+P3mwv7kBx1V1s9HrcTwz6w5Bx8ArP6qV82FVhGl1pzWXM12ia7x4CUUUd1efsS2OkO94mhr/3jgwxKdrYTl+NrfY3qxwuVeKvXeL0mGc6r5Wq4sDYwDeKOiWHPP5kNoaVlrI0Qcw+7jFijPJYsDRv/OFGgUiqs0L0iMjjKF8iPhj8xFEE4x4qHvF7w+WNkCkqbrTb6FW/mN/DPHq/b2delD/kd2hmV93OalaTvtlZLxwluWOoEOZ1QA50yjlJuN2h7jKse1vnjzK4lssKpKOJMpd9ubtD7pr/sbZW3rYIyMRxiNoX7pN4aP/v845yxKd5EWV5bD/gp/hfNylTBx98j4oG5pU5wjgCeScpZ050D62eO5Q3UeWy1Dle2JH4aeSC/oVKuqc0az1wFeG+ROYrF/R7nrE2bja1/xoyUdWnESENL3/eutPy1K0ABF4nrtOFZ6YBYO8iGp3VODJlu3E8A5S02pckySWJubmdVDaMne5AjY57zpG62yT/U7p0JrGy1uWtuVrFgJ6YTuTR1ecMd+fbp/eMfRtMXm/saoHKjUsJy3xkVObMyqF7uOtofiyraJ195Isaqq3SvCWs7halRkli3wXVt7LNx0TsA7ZenhFdP8edEZTlD9Q+Fdrgn561R2lwaMd2SBDE4nt+jJiroTXsP6e6eLK0tX8/SQV6QxdNkNvvJ8Jjd9BN7cyLmTYYR91z42+VgxOdLBRorvPrCtxe2v2n+rh5YmYpjfGEVGIsGc4TybLkIhdKjJpg7ew==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ApAzrbHBV/O9TZAYYmQxonpSuYJmsBfapurhcgCmGfRmEsgogC5CiLZb9ljfUvU5IdEGWjaCz3zrVccLial35wSQgtQnM29/rdrv45GQHY2lzP8GsKjz4a1VlbrnMoSbSstzupiiCta6mVZP7n1h24/g53lP6oxt7uvUVltapHeDz4+YCaRe2koymrVXkYEPR0kQ/swhu4qr1iZYCG9n0yaCUMCs/83H/HhlU5eKzUAk+QhOSjE9b9fPFaukdrZ53aDGpTLGUnh0yUhKIJKBhwZw8HHZnVTT0dYmdLU4sZrBM/zgaGYH79LIMRcjN/jGIMu5OyiP1igr4XH594Xooyt+5AstxfQ+xeoi0aGj10ZKXtZTHUIcjdBap+6pzFgtMRHdtBKAkzrraaS5wupjqOAckLSeIRwHpb15YtGwfvqTL3kcOpScWjsi9Epzrgoc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:10.5759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e667f59-f3d1-427a-980f-08de752517e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
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

Introduce a GPtrArray in VirtMachineState to keep track of all
SMMUv3 devices created on the virt machine.

This will avoid relying on object_child_foreach_recursive() walks
of the object tree when accessing SMMUv3 instances. Subsequent
patches will use this list during ACPI IORT table generation and
for CMDQV-related handling.

No functional change.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/virt.h | 1 +
 hw/arm/virt.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 8069422769..f9437e6410 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -186,6 +186,7 @@ struct VirtMachineState {
     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem;
     bool pci_preserve_config;
+    GPtrArray *smmuv3_devices;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 50865e8115..292e523664 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3232,6 +3232,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
             }
 
             create_smmuv3_dev_dtb(vms, dev, bus, errp);
+            g_ptr_array_add(vms->smmuv3_devices, dev);
         }
     }
 
@@ -3659,6 +3660,8 @@ static void virt_instance_init(Object *obj)
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
+
+    vms->smmuv3_devices = g_ptr_array_new_with_free_func(NULL);
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.43.0


