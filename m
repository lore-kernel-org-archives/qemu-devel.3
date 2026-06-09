Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE10DCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWue1-0003mN-AE; Tue, 09 Jun 2026 07:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudx-0003S3-Gr; Tue, 09 Jun 2026 07:29:17 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudv-0004fx-HE; Tue, 09 Jun 2026 07:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX9OnOXwGYpYfQWy5vfXi9RSrbiASEDThwZ0GMJVqpk6mkfqINy+6aACHkjQf7b9ZhfYix8XOiAfsHmf9/7Qy8NfOOpbnAvydoHzEb9PNbILpb4A4PxP+SqLZ2nKLodhbH+pYsdZuPbU+WDZJby8fzU7EbClrDqpGAJ4G3BUSVjvaWJWwKD3UmNUhyZbgXdVQl2gyQv4cPhaFui751Q+CGCIxmZV2YQ/jOxRNuwsPutbUXZED2Z5hEYtcm9HxSaDh2AG0ssTtW8lMihDIsVImjLLzPUuAHowALWcskP7mmnrvaGu0l0n79wqTTBlxKuAg11jra1weU6XkWx1BocI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc6XLx0I1jKe8N1XTxZKs3JzUpGhFvCBx7IjkO/V/xc=;
 b=PTVHk0OZQGV67Sg88F7ZFhOuR9lmnfkIHlbwzsimZUTQe1h2uJMsEsXYxNlRS7Vn5tfF9HmXm/dNvj2bOGssaa+vwGbowOvnppK8AvJT5Z36SCO1a5WtOiCijAlycGfS8DNdWwjGFUGVhBcrmNiTv2LXPJrazKHlhv4uUlpfgyEB1fp/Ohv2YmzMTqQGNNttVPtDdI/EeEKmUpI0n0/XeJ8SjCTwd3k0Cfk5FRjLgFtKhlzpuFL3R37raZpERtTeLRVhxiktSkWbdrytNRwuiDw+b6EwUY2Kk2TsdNJdmcJ0aml1wudktVNrzxs6MX8WwheJgrNd/ww+a70B5Vybiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc6XLx0I1jKe8N1XTxZKs3JzUpGhFvCBx7IjkO/V/xc=;
 b=kJzYsTmySAercdUrmL79DvpSZy3jMPnekJhevuUwzFyZCLqpZJyz1U/9M03v1328ahfjsH59lOPt2Mr1RczxaLGLSQm+dlxdRJt+9EoFNHWzIjv8wUp+R2bzQY6PNnhLwl+XFR8HNhWMQ2GOECJ76OHGkAW3g2+qP2DX3n4q7iYvar+nSIT/PbG0D5nGT9tCU5460D3OOfH+Ow4ZXJb/e7OEBzonFTNb3CR+mRiAr5oHpzEeKSb0FXjzlY0MFc/FIC23POz9d8G6LHDCfI5xwUADXPnC980gQVOl4OxX2CTFuuui9LFLKbhb3kRddOxHTlpFvC1rfIJIQ+01FGZ5yg==
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 11:28:55 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::54) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:41 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 29/31] hw/arm/smmuv3-accel: Enforce viommu association when
 CMDQV is active
Date: Tue, 9 Jun 2026 12:25:50 +0100
Message-ID: <20260609112552.378999-30-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: d00feefe-e7fe-4a25-1626-08dec61a4a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|3023799007|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: c2Oytbix7tCFI4AK2Kwv1RhT8EpliAvamuZ8OQZ1SWDXe59R9+rKGih0YgWiIp4xpBMdG9X7GzgArULHBztHwknmnE6pItlVTrL7QRRioMyi18xqrmytKCes1ZOiE4csQuXzaf7cZ1c+D6LOfpBM9cOq4pVZL6nhUhdNzS697vaY2R5CfkpqeFmFduvau6elqzultEL9UDZiaGZ9JN96uBAd4GQGxYK6RVN9AFnNwR4+3ZwsDXzWqZLGXvaO3KmguzI/ZORsbkU+HM4EyhkU+odkwLH5/SSk00Ib/aZtP5Y7yQGraMtonLG4pYltg4GwBHRLWVydZ0Fhi2Go9ExJSym03I9VKDQpMx8/K5UTLjyIPZmOnsIr8lHsl8hT94HwZqGGWcnJveTgEc+ulLrZzWmvg2qN7GrVB349v/q6EM7EXB5fOa3nqVkh3DDOsT3czR4dc2jjycf6C2wKDOE5faWJZzZD/sU/KePy16FSspHvDUyHnc0PmWbBSziwnOV8DGbYb+2g4JZGWEOldSHGVKYOvmageFYIV3a5cBnyKdnJAezV0Xd8lNpFhYoadZv5JpO9OOtxOv1sb5CvClxUSJptbdjm/B+V8YAaVvA3yXdTexM3gw/J3Ant0RZuaK5wikvSZisOfucT1K2Xtw40+xBazcm7GPgB5n04NmsWOUTXnR6YkCNlhFCvxbNG8WGWnPGCyuTZWE5qX2Poyp3YIxQvOLcFjxtNutqBMOZLXSc=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(3023799007)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +OnAsXXeUh7e7eqfXjB8xXCo38Qpj+b4WOGdGFuWxdQh5GgOdzbZkob98wTE9hNXPFdo3suUlGyFnZEFLobO6IoIX6cIhOkOXlL/hP7O/yU10MEyJWqejOvkCTDVChmgiv1msLFibknBA47S8NlIHnBNRyFuXpEc2iQu75Z8ZyEdIt75yDUQalmjYzh6W/Zhfe4p+ktwhJzenV60sszrO4wvZcF+m1dcul3Wryg7misRTnDyvoyv23UmMxiVk9bH8KANbCnkolI4Pd9GM3V3CM6E0PLc08psB09CICJT1r36RlAq7+xKS4FCXZFH95JaRPi0IWOeoghiZVvkvwKgXIV4vAIPV3hSRV0hYOqMHoEe7HJPLuSb15RVa0Sc113p6wM5HdOYAY4oUl51ZeB61xpjiBn/HYwnGSCLO73FouTIUwFatnF/lODi+9MWoPq6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:54.7721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d00feefe-e7fe-4a25-1626-08dec61a4a30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
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

When CMDQV is active, the first cold-plugged VFIO device establishes
the viommu to host SMMUv3 association, and the guest's boot-time CMDQV
configuration (VINTFs, VCMDQs) is built on top of that association.

Hot-unplugging that device would release the viommu and tear down all
CMDQV state. Hot-plugging another device behind a different host
SMMUv3+CMDQV would then re-bind the same vSMMUv3 to new host hardware,
while the guest keeps using its boot-time configuration and ends up
issuing commands to the wrong host. Block hot-unplug of the
establishing device to avoid this; retaining the binding across unplug
is non-trivial and not required by any current use case.

Also abort at machine_done if cmdqv=on is requested but no cold-plugged
VFIO device was present to initialize it.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h |  1 +
 hw/arm/smmuv3-accel.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 5fc85fb89d..dd755c394d 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -84,6 +84,7 @@ typedef struct SMMUv3AccelDevice {
     IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
     SMMUv3AccelState *s_accel;
+    Error *unplug_blocker; /* set when CMDQV is active to block hot-unplug */
 } SMMUv3AccelDevice;
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9c3bd4413d..80900c2521 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -759,6 +759,18 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    /*
+     * CMDQV is active: block hot-unplug of the device that established the
+     * viommu association. Removing it would cause the vIOMMU to host SMMUv3
+     * association be changed via device hot-plug.
+     */
+    if (s->s_accel->cmdqv_ops) {
+        PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+        error_setg(&accel_dev->unplug_blocker,
+                   "CMDQV is active: removing the device that established the "
+                   "viommu association would break the guest CMDQV");
+        qdev_add_unplug_blocker(DEVICE(pdev), accel_dev->unplug_blocker);
+    }
 done:
     accel_dev->hiodi = hiodi;
     accel_dev->s_accel = s->s_accel;
@@ -1082,6 +1094,12 @@ static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
                      "at least one cold-plugged VFIO device");
         exit(1);
     }
+
+    if (s->cmdqv == ON_OFF_AUTO_ON && !accel->cmdqv) {
+        error_report("arm-smmuv3 cmdqv=on requires at least one cold-plugged "
+                     "VFIO device");
+        exit(1);
+    }
 }
 
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
-- 
2.43.0


