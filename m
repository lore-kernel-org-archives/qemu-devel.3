Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711E7F41990
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxx3-0002ED-K5; Wed, 15 Apr 2026 06:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwp-0001eY-SJ; Wed, 15 Apr 2026 06:58:20 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwo-00049s-Am; Wed, 15 Apr 2026 06:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1ULgGy20FiVY5alygj2LN2qmtSIE6yWVfQVPB4fay1wdPP5P0EdcWprA84r5ZIHmaH/Y3PUkXs/2IRkBtF/j6fFbW51P3fgWy6G+HP1iY2ynztV7WBexHjN1ODt7G1IL0h3tDTbVRtxFa6p3/BpM6Es+8vZzPSggzX8ULfbntYI9V9a+81bYD9ZiT754yVT8kdzvOvsi5NnbFlo7f6cbuoiFs1fWf4N72PXl1JNI2DnzyqzjPlRC2bCwD6akIbWZCm+vpx+0EEr2J+NkThjEqM9hSv6FauHJqS81Jxk8RSAimUIGVuelhLRl9yiyLEqaCJkX0syeIcjXc+8YTSung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3VeqfGDgkOQOFuH3B59I29I/8mq/NnPZ8c9N2s0DMk=;
 b=llFvKsiNllZrUD5t+gie5NmQYV0Xmo+zmqNS0+WryvJdpmse7KylxOHw14sLeKF1N3HVMTSARMDZKq2hnftqkfKVPNlKKE6cYN7wVkB75d5hMCgDLN6DM8FyGSq2/MC8DskSen9MuK0Qzl+cJ6VNEN503jBIwsy1TwKE/h4UnAUEK8PMHgh/k06JSAj9aAUnFpFC1h89ZBw57Y/ijKJVbuzsthzuk0LxUyZlhzEUZCJllDaezxEhGTfyo6ubb7AEEJEyf/wHHmmT7Py8T+vj4z3mQB7D99udZepchPEXMNyMyMKmqeSsKVzv5L3z+ni+KQS+v3lbVT32SvVbg6zSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3VeqfGDgkOQOFuH3B59I29I/8mq/NnPZ8c9N2s0DMk=;
 b=IkASJrhLg0KJkjjpqOmC3naCyVcKkgN1KjIklZJLPNEPogBe4Gn9xZ9p7D+38G5cIDhomqNZ+WOBymPLtTVSmkevJa+6aM4X856KaPt/OuTfUJ19pNx8JPoRPLEqEIEQrLBI1JwzMKJI46vD1iSyv65bsEED4PsI1LHoaW2BvVa1PeMY/a3umaJ3EGaxK7JT9jyoJvj1YF8N9QU3L6FbA0ukM1oL8sYvAuzdhdTjOPhTuKovJdk742oGwQcJb/vQhnNBo6eRg4s2omAzhXGZwhe79foNXQGvd2x6EwG6AEsufQvOIXx+59vzv1Pw9tG55ODyaamaUz/h2S9JPExFLQ==
Received: from PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::27)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 10:58:08 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::f5) by PH0P220CA0029.outlook.office365.com
 (2603:10b6:510:d3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 10:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:52 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:49 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 21/31] memory: Allow RAM device regions to skip IOMMU
 mapping
Date: Wed, 15 Apr 2026 11:55:42 +0100
Message-ID: <20260415105552.622421-22-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: b71456dd-bb34-49b1-f251-08de9adde0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TJCW36R5Ngw3/pwQvsMUqHmb/XMIdUeTQo5XJ7q3sjr1FY1GdAdjRASfVpAAgXJNlJldjDvbjJ7lWz+v2wB0Ydd1AOMJyjeZ3PNNZe/t+n1IZ46rAl5i7Gnj0AbPQ9baCxMwXtd2G3PpSAHAD0Gsw9GnUBEHBF0inU9CTZO260Mvioi9lDJLWblgFy3DXRTfI78CFcQ7aXBgbqXop2lA4yLVsoeOP8mZe5Oxr6je0GU50ZxImsoAPF0yMHK8WmMCxi+Ve0571pZavchjQrSb57NDOFjhtjOaI5iyJNqamrRGgtJshczwa+auuV3DHYqPmut0y+zho+QvoiAfHlxUHZBoqiNPhj7LH9efi7TB4MkYFeuJd52irUhtNqyX5Gkf+TaOqUHROG5JF1DmxthJ+lnyBN1y5m0hnLzN5Gp63BHQVvQ3I/MM/uX4XcS/W8aWN1bG/gYF0x8jqXkVHof+WTa6LyV8B3coADjmflPVQwtbXaubppy0yrdJKk7939xKL9a2FiIwRDBeCCYHC9t8IJUliV+jiBTm+5WYlBe1BKr8QXS3IKaZ3rboUzolND6FaOYAyhzUM9Os6rdsL0K44EYJnLNeB49f1mznaAjjFDg+v83DrFxQRg9DXfGuKM/IOIAL4QABSe+Tzawh4CdaxkxKexTUdfIrk8lBesnvTlULQIArexga3QcN7YtFpErSOyAXWYWvx3XhakM3GRPefy3Sff4L4gw7U6PFYJeltphpsmyqV/KSwoxql0kyJud8vFYmBnbafB5/yVYLnysaSw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kkt6evQLyQpfWApkRFAbGpfj0aml2Wu87rpFX0FHQJHbdIBwmMVKGLED5AZbF916mDQwFu63P94q0DTReUR6o0gi7TMRi2X9RmK5NM8AASF3uSq7T0lveyJtVPJIkHhrIeT50/BdQZK1vYiPsXNeLMDjCH8j54oVYpcHIxBCx/Bkgz8EKOgI5CwLO4Su3skx2Q7t4U5V3pIGs+rAS+tRG/0hoSby6Ccdd+L6oFTDxVJzt/OTTHuF34kaXvkVUFVj+YKIxRAyUkmgKx/ce7ZQsy5L/Dz9VVbqXQ0D9ZByfaUTzntQE2NypbcxVa60b/NjNyKEUIRjpaY7/I9iEUtXhL1tK9r3tCLK/tO0bM0k9hrmWUiV626hwdsWI4viWIiwOGPj+xpzIfnqE4CaumarlodBztsvR+P3ZyzNAWSR+bIMADL/BJT74MrJnM31L06Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:07.9757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71456dd-bb34-49b1-f251-08de9adde0a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Some RAM device regions created with memory_region_init_ram_device_ptr()
are not intended to be P2P DMA targets.

The VFIO listener currently treats all RAM device regions as DMA
capable and attempts to map them into the IOMMU. For regions without
dma-buf backing this fails and prints warnings such as:

  IOMMU_IOAS_MAP failed: Bad address, PCI BAR?

Introduce a MemoryRegion flag (ram_device_skip_iommu_map) to mark RAM
device regions that should not be IOMMU mapped. When set, the VFIO
listener skips DMA mapping for that region.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/memory.h | 2 ++
 hw/vfio/listener.c      | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 7aed255e81..9df15e833a 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -864,6 +864,8 @@ struct MemoryRegion {
 
     /* For devices designed to perform re-entrant IO into their own IO MRs */
     bool disable_reentrancy_guard;
+    /* RAM device region that does not require IOMMU mapping for P2P */
+    bool ram_device_skip_iommu_map;
 };
 
 struct IOMMUMemoryRegion {
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 960da9e0a9..32d33a740a 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -614,6 +614,11 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
         }
     }
 
+    if (memory_region_is_ram_device(section->mr) &&
+        section->mr->ram_device_skip_iommu_map) {
+        return;
+    }
+
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
                                  vaddr, section->readonly, section->mr);
     if (ret) {
-- 
2.43.0


