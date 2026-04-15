Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227ABF4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxw9-0000ih-7x; Wed, 15 Apr 2026 06:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxw4-0000e9-US; Wed, 15 Apr 2026 06:57:34 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxw3-00040A-Ay; Wed, 15 Apr 2026 06:57:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijx5vyzoNceTX5LoTbVwRgJoUFmaqQsJzTO1bYBKAvcFPnad6RUh6sqaVplipemxUmY+22B8qbwSShVfxHwUB6sEO3FCeGwQRYlVb2gC9hm3h4G/m19dYK6DTkzO6iMnkWI/Bqtc9F0+PY/Ym31WdryIkUgAKnZXE9Ea9LVPzr3ROjQ2h7OTRptdKtf4DkDT4yKIXg0TsxtTuF9qm6648WN6uPwysVnsMgZ1WgJPMiQpfQYPxQVC1V9QWoBY0fdxXFJCqFUZ+XbsYOA1x5KOm7MKLcKCSZIyWwMDcm7Q3BDoyxqFzWrTpl8gqHaoS2D1DMbP1P+xcpm/JMFh6eoYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjpQnXPo4LdSdXh8sJqXnrzL2Wmsj90/E8cS11UdggU=;
 b=atuFzJzfpE8Mde7Ozv4titGLR+qKNQWeDZK62Obvah8blXj27y5AIXyRdUWrIhMIIHFf6BjXkSZpqDSdlTer3pqRGS8WjPzebIZ5p6iCsHRwGvRADd/jwLvnjUMn3MNnFQJLNBDuwFgT88bnTeaMQGBEvMR3S1IcaLQ5DACPQBzzFGi5M+kXbsYnnCLiAjUw5oXsODpNJoGIVJzyI6sW2RMKFZ8zbi4aCYekDmOWILmyKTuYMPT9xl6BEm6fZbpm32dXxwn5FCAfEWisCFGxjpGbs3qhKYYWtB7oQdKab3kK0U9F0nH1flSuWTu5Q42rsLJFUAnlqfUWDgpGweUjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjpQnXPo4LdSdXh8sJqXnrzL2Wmsj90/E8cS11UdggU=;
 b=c969BvcMQwMtsVkwnIETG5nVV/BOtOw1Rlzc8H4ybBHE/JuP3MkibVZyCnI7xV9gALzbZf0k5T3lTNd/0XjTjlf34/nViCdNt33l9epgbcGRP1nfKakYxEF0h3BV2KXiVcKjqaxqFJjm9Eog3caqXq9m6b2/pi3hl4tiydO6E3/s4dGO4tkRaq3G8GdikkYMUkXq7CLfnj78BDiblLy+qQSWq1WDmuDCKvWbxxkeJvsKS4NdbWF/QsJsR8x2surYjbCXSoBnISFT/N9zX3AYToa8uFcmyuLS8i16UjoA8BHpwh29xGPhAHPTnMQD8ctvhFyKizKw1veDYADHG0RX/A==
Received: from DM6PR01CA0010.prod.exchangelabs.com (2603:10b6:5:296::15) by
 PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 10:57:19 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::bd) by DM6PR01CA0010.outlook.office365.com
 (2603:10b6:5:296::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:54 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:51 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 06/31] hw/arm/smmuv3-accel: Introduce CMDQV ops interface
Date: Wed, 15 Apr 2026 11:55:27 +0100
Message-ID: <20260415105552.622421-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bfcf2f-22e5-480d-5010-08de9addc317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0TcicCWRcKWF0iaqSf6UfoAKzWU+Il9mrtn+3OIjDTFkQgzLNVrK1ETaoEbsFXnpaPP8nuGE3KthSdqk/hnrrES7Q2Szb7RbWD2jitIM0S6VqdkdqVEo6kDYSO4MWrLPu5KdPDZl7T2WFadOMExzK6ccDh/blE7LHRdWYejczFE4pr8EocHJ22zNs0yF2CUt4SG++Tq1AbTC1Q3G53EIp4OZXmdwat94cH6vaC5iobtQeicBCZlvrfcL6VRdj0b8Yr6TRr4c9ag8XcPRzR73Ahk5mZBjA3TEAkURdwenUJU+jKYSNLGsI4FXl4YoT51IF0rF87S+jznFmWntqxhHZuu8IuDPWLDHhNGiWDnJHrILa9Ht0pn+R6bnI6XcJPsFaze65jaRMf1MznUv5lqJZguXgVzSuE/j2z37wYZwQPnM+aVICFUhNPo6ojzYhtvZtY8im2NLm0HR5dtGsbdqa0Gf7nemlymUbSNlqwBLZWUmN1Ek/+CmQh0B4P6XROtFbQYiQxdWZ6wicoZ5pbjxzocA7DFUoqLB/qe+TmLn1+WCZIGP16fFr5pm4jAmVeawSKzGdZdpEGH21UL1ZMA18KqpIr1Cf82EG1jTqw35Pf1Y5I53mEctJfMKYmbhsDb67zI3WSswCwlgavjBgb6hUdKZkM1k7v4ylzbkmFzi48VBM9Gfby6DMsBC6HSmjuAMzKsAd0GDAOVWNUhnHXS5ERXuQu337Ur8TrNQ9hEui5NOnR+27Tx6p3DFnWN92nzbQbe+LYjom4r2j3N7MBVtdQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ewPaKXa79OvNlad/l2gu8IWpmC5vaRuVMKEihEy007r0t0QIUD2WccNFKzZJ4XnAqfBSZ4LQE84Hgo+10guJSiHJaxQuMV20Z1AhYTy5PLMJmF+Ydc2KBaUaw6QGbnCPli97mitAVMQUm4bdWhNEzaOefKnvhVMiMHrGohWHiI+5mloD5XN09PtPsr+6AzO1ihUki0OQnVnyF1e1hKC2Gdrv2iP9+gf9aLFyJnyDSQ94bFOPs+XoUukt5sR9XH4ZcSKRlajJi4B/qLZDribg9xkCrmMHgIjcQIxCG6fFtbPzmYEQkpkWTu8qvo9lOAVgwzUCQj1lOiFLJ0vkDHnIuWfDnnDYHRLZSY+lU50NJbzYpkkQf9gAA5Qf7tVvGLsv/94TDpe3Ds/8hKFnvOjo0VcZ3yQNkZezG/NbPZbQvZ4V9P9G0/WYxlBOHIiQ8tla
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:18.3389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bfcf2f-22e5-480d-5010-08de9addc317
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Command Queue Virtualization (CMDQV) is a hardware extension available
on certain platforms that allows the SMMUv3 command queue to be
virtualized and passed through to a VM, improving performance.

For example, NVIDIA Tegra241 implements CMDQV to support virtualization
of multiple command queues (VCMDQs).

The term CMDQV is used here generically to refer to any platform that
provides hardware support to virtualize the SMMUv3 command queue.

CMDQV support is a specialization of the IOMMUFD-backed accelerated
SMMUv3 path. Introduce an ops interface to factor out CMDQV-specific
probe, initialization, and vIOMMU allocation logic from the base
implementation. The ops pointer and associated state are stored in
the accelerated SMMUv3 state.

This provides an extensible design to support future vendor-specific
CMDQV implementations.

No functional change.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 7b4a0be000..86301afcb4 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -10,11 +10,28 @@
 #define HW_ARM_SMMUV3_ACCEL_H
 
 #include "hw/arm/smmu-common.h"
+#include "hw/arm/smmuv3.h"
 #include "system/iommufd.h"
 #ifdef CONFIG_LINUX
 #include <linux/iommufd.h>
 #endif
 
+/*
+ * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
+ * support multiple VCMDQs with virtualization capabilities.
+ * CMDQV specific behavior is factored behind this ops interface.
+ */
+typedef struct SMMUv3AccelCmdqvOps {
+    bool (*probe)(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+    bool (*init)(SMMUv3State *s, Error **errp);
+    bool (*alloc_viommu)(SMMUv3State *s,
+                         HostIOMMUDeviceIOMMUFD *idev,
+                         uint32_t *out_viommu_id,
+                         Error **errp);
+    void (*free_viommu)(SMMUv3State *s);
+    void (*reset)(SMMUv3State *s);
+} SMMUv3AccelCmdqvOps;
+
 /*
  * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
  * Holds bypass and abort proxy HWPT IDs used for device attachment.
@@ -27,6 +44,7 @@ typedef struct SMMUv3AccelState {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
     bool auto_mode;
     bool auto_finalised;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
-- 
2.43.0


