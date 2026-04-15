Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9165AF4198E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxwQ-0000yr-E7; Wed, 15 Apr 2026 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwN-0000uh-KM; Wed, 15 Apr 2026 06:57:51 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwK-00043H-Ey; Wed, 15 Apr 2026 06:57:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Obc0UiP/O9S9sYegchhpwAyuTfKFx9v8ww7Mj8BrVk0jLUNtNYzuPATx6n1LGTgSQIsdMV38wR5VMeIs6Xt4yJvdS2ODWKZmWYlDOS9gneWnU65hAG2pHzuoULbr/fc68JhSEijOXwm4Pl2545HyQUBIGfkmfEprg0jRlxbmrLKki+zhSFIyfjQXnjrlb7FbWHstTeKsG2cIiQn2xWJRrHC9J8alOhgf0egxrw3LPvFQPRhQiY9NSvnbhT15WI5HclWsMcqx7J8Rjgm9Qs3Yvm/vmYhUWSfFvgjcTqXC0/owmtkZvbFiw7myBOEYx0aDEhAwC8Z2KNe8x9/RxNtsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8hpDUC/mUt28ZsxpoBuTIwe6CsauedZ2sBpq+nJs1c=;
 b=yYz+9jW8CFJKQ++sjwtBGaF1sFWEBnvCc2bHsB6AH2sMxhSyZX7AH/ltH5Gd0zhL4B2F9IKXvT67pEomRverff9RitgMASrtnLwmPuQcjzREiZl/pcCieJGbYkB2syxsmjWuitq/3o8kTBRKlzpkUOLXrAwi9ZwAtKW9UFChPIxVJhHysKR62LE0ZiVkaqUSePSeZOV5GqwjnOSIwk3DDvKRtYB5vMNgt6Vx31pqpUncPq9dYOVjOUypcqtIF/L1NI1jkfn1qDPHmO3KcytI06wMKpE4F+/eI6Gjm0LVmEzNFEBOJAhA0ib03jMzdzQxxeud/OrqRHVGElAB3gLLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8hpDUC/mUt28ZsxpoBuTIwe6CsauedZ2sBpq+nJs1c=;
 b=d7vFT15nENJEQYxyiIr8W6GclOVAN6UUB5b6BN2vepfaAOV4iAjlw2LMkyvOfh6Qa/ncH3AvjngY7yXjhn2CXYbYB/MpSbEVU8lJaCArqfhJXuHzW3vNqF3vOOi/wrpq2C1ycQb7q6zSc2Ae7P8qYytMADZNvgwtpIvewfKvv6hViPefhPe84kx4r/UawSfOiPaNfjTErI9h37ssud0A/q1/NHZkcmEJTJMICoV5E+JG2C7v/yFuN2SyHIW1B/7p3FdvgrIldyNHE19AxbpwaNoSIHxe1NxHNmaZV/99s84f4SRczGBNdf3WX3MDoW74O+26v6OO/jZ3ehbQj7QZKg==
Received: from CY5PR15CA0227.namprd15.prod.outlook.com (2603:10b6:930:88::25)
 by CY1PR12MB9652.namprd12.prod.outlook.com (2603:10b6:930:106::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:34 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::75) by CY5PR15CA0227.outlook.office365.com
 (2603:10b6:930:88::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:17 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:14 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 12/31] hw/arm/virt: Link SMMUv3 CMDQV resources to platform
 bus
Date: Wed, 15 Apr 2026 11:55:33 +0100
Message-ID: <20260415105552.622421-13-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CY1PR12MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: 9524b77b-d5b6-45c5-a7a1-08de9addcc83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XBRhaXAOC1dk6fb7lc6u7+9GT5BaeM1CF3olA7PDmI8uwngNccgMvF0LEjWnqNrdrbC+FpHXDaCVVg5vA1YJ8aJNwcLsZadD1JARgtndt7JetxLWwNx+xaTX+E3CybrokN4i70tlsiqX0uFRkEgoqTGoFzLPYFOSSPd7quBkN7Fcxj0eMZDqOgKzmmT3eY0+OxhCF/7gKy6jWswtQmxTZj8CB1YGwLiJmjuXNMWVUNxltf1Vho4IQJp223AT+Bv0pr42qGwlXQiRK75nTQ8bFs25oUzY5Zq0Y1ramX+ILXS/zwSk6r8MZAStiTVOhckY1NtNxLDpiavdrBm3ANW7x1zI4olxAkujW2ida14BFHxgfGH/2DoQUX7CDAXXrej59BhK+o2gO46y3vsFvkMmK5RhKRtV8vTc7REYK4iQh7BOReQ6wmR3IPmrVRO88xbm2nlmxpZ6MNJ2TvbEk13x2tvZNlqqEmUTZmmjF1MMKVX3LQqaYXMzOu1ItxmpkgIQ4f6fZgnjZTtaZquQzMcGYp7/bH+wJBwACw8Lwvo5Bvt1uvChK/PxmtxcGsfUaAhjlvItK8YaY6Gjvxq7rdAiAivYHDaB77ePXZOEL+8QnCVKHLrJkzKts5MXC1pLFulrrqmBr+Hg1UFYo13cVKmnJar7SBi94fZlwgbhEy/5w2ZkHkucMUDdA6CveSAiFxmn+CNnWFok75heD/IxsWZAlZjkdZMTWUwapH8h6GTLDAeY0JS2wNq9StYMpCf1nAz4KCZJQItKMB2pGyfNBdG6qQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KbhUrOyTIy7i0fuTt3WoXnTClFuYTcv/nqmKidMFWx+pLQgfOv8Lhs1UDzLgvweqj02GzqkYbpP/rnXFgciJcqknT2LxjI1fyQYN4KaBBIjImMiLtczBUmHmMiAdVC3N3eNF8Lrkqh/P9P1wRb0TF6ZqAOWK2fC7tj1OD7zPs+M5GM/5WBKh5UKeJ3X6y94AeZ3wzbK9YJXYJdtIed23/D3DtZ7Y2t4sKLiXpP/sHWPes18UdqBUv7tMV22olN8xDIt6dtE6pM/5knNAA14j0GZrd2DIhvna70wU2iYcuxTHdVv7ft5A9R6cok273u+qpElXQQa5IuI3uhvfZURElcJG50Ca3Sq0qoI8PQv/p7Ld6qhF7O4UaM38CHON9YpxaTNuJrwWrPMTY9PQOpnR3+2QrzpCb4HSz69uPvlwLULZOB9ZIT60WLvfU5Q7GqUW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:34.1360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9524b77b-d5b6-45c5-a7a1-08de9addcc83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9652
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 68464ceb14..6c5e51af37 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1832,6 +1832,25 @@ static void virt_build_smbios(VirtMachineState *vms)
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
+
+        platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
+                                 SYS_BUS_DEVICE(dev));
+    }
+}
+
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
@@ -1848,6 +1867,9 @@ void virt_machine_done(Notifier *notifier, void *data)
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


