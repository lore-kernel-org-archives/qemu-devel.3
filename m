Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE57C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRJ-0000MK-Ph; Wed, 21 Jan 2026 12:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQl-0008IG-6e; Wed, 21 Jan 2026 12:55:57 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQj-00013O-2R; Wed, 21 Jan 2026 12:55:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaMc+nzSG6hFyCi6ABkwYPx7Yr+gLtwhensjm3M6NlHU09hQbzWL/E43owGTcvAwr7Mp2/jTvQG50AzMX/JKnI1n4GqzVOZvILuBMAxd/hLpiav5RBc8FWCn2G4KGHLlM06Z1KLUhfEOHTeJaKhzSfhWtgueoR+gJxMPBUN5W++l0CmqO0BpG2B30XaD1YYkv6jXhEyVx6DAFZz1ZpCuWZ0ia49WKN/z6KEalqEK3qXcLkAbi4QS+tUjcDwOfImM5D+FMrBxrsi2cXUA2t46k8vLh4D4QgCG5HBxOcjBXixxCah5Ptm0E+eOhPvHuwGkJoLdBa3op9upZYoTgSqDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sLTdlTkQkI82nizZ9ZBHUwEpMDenQNMu4zTFpytN3M=;
 b=WCSrBe2MnYC7rcRY181XNS1N5XbjTtrJt3mQ+StEitcxAPz5WMVlrYQj/9RqyO2qveO6edvxBZyUxGJZUqmWd35TyXqWOrn2hT3yz1XfNtraud177F5szcIQiZeI8xb6NKCoSteOkqA45kWz3up2D+f0kx+/rs6WKXyY5kMXPQBJQmGlguqIb4Ia30Fbt4rDAh8sPt99jIC0TN+BWC2wzwl1jgTU3frdpKgafHyT5u653qR7szmDfLBlc52IVG9tlLkCoPA0o5XmaJCkGXep3gGM5JK/v+LmVlmz26Dadq9hikS1Du2a/SAUzNJ3V4J1ieSAxTFt0khfotlynsDjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sLTdlTkQkI82nizZ9ZBHUwEpMDenQNMu4zTFpytN3M=;
 b=oG+9hzeESwFdAaHA4MkcD1kAMAhg6BcnnKhkpMrdhTnqEODFzq0eQ1P2w32KVSlCHv/aQA5zJLEbBlhHzMbowyth6yFDYW8nJaF+rb4USTADsCMQJk85NtE1AR1QHo4oN1vcULiBiS0JRT+Itl9uCJvXmkdMTPMbFS1nVEEAO2FjC4AYia2winbhKo2kl4memGnccRvsZDARK2BBqNAzapz97yJJw3HJbPgm6NjIKEKv8VERU7ec29AFs0BC9g6mOebD56m8DZNcZpDkGBKZXarDvP8Lda5t4jFhzXjH47+2e9/6KAdzIthBGEMM2jVH/BlGE1BxeC4HNEgfpv1ijQ==
Received: from BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:55:38 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::7d) by BN1PR13CA0023.outlook.office365.com
 (2603:10b6:408:e2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 17:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:55:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:14 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:08 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 04/37] hw/arm/smmu-common: Make iommu ops part of SMMUState
Date: Wed, 21 Jan 2026 17:52:09 +0000
Message-ID: <20260121175248.87649-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 874b356d-36df-4b32-5347-08de5916490f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekw1SUErNTVjRUllZFVKNUFoK1ZrMXlHYjR5QmFnYTRTR0prN1g5WVhKSEhG?=
 =?utf-8?B?Zk9vQ05YbmxSeGdwSW1vYVZPSFZHbkkxNVorbFBrb2hnZmFmWDJaSU8zZGF3?=
 =?utf-8?B?eFV1WlNXMHh2SzlQTnFWY0ZMblYyTEZLNVAvRzlmRThRdm9TcldTQnNwSFZJ?=
 =?utf-8?B?TU1oUld0Tks2b09paFVmZjk5MDhCRGNCeG0welVCT0svUmd2WW5KR2t1dE1z?=
 =?utf-8?B?MFdqcU9qM1QvRzdWUlFwTW8wZ1VFeklFbCszL3hlN2J4WGZlV0oydks4RWhs?=
 =?utf-8?B?WXdjN2hVLzFRYmR6cm5KSU1ocHB2eTE5Tm40bVJFRDk3V3dOUTdmZWRxRjFC?=
 =?utf-8?B?KzlhRnNqRjIvblQrMys1Yk92Z1BwOEF6cWtpNFh0QThwVWx0bEZLVG1KQTJs?=
 =?utf-8?B?K2RIVnlQNWtXQnhaYVgrdVZEbGdCTDNUK0xuQXJjblBrVFpwelkxK1N4SXQ4?=
 =?utf-8?B?UjdkWFF4UkJ6UUZUY0JnMWxPaWZ1d3FEQnF6MWgvR3RuTVg0VGlkM1JWSTNY?=
 =?utf-8?B?TGVwTk0yMktlbzRQRHgyZ1V5K2M2Vm93RXRHV05iSkNFdS90Rm9YN09UTFNV?=
 =?utf-8?B?ckQvVjlHOWdqQmlISno4N2NQendSQ294Wm1HbHkvM09PeEQ2MUJtajYwbHk2?=
 =?utf-8?B?THNKVlkwOG10ZXA2OUx3SHduS3JRWnc3V1QrTmdSelpTOVZWNUZ5ZEMvZlNx?=
 =?utf-8?B?ZTFGait3anR6SzBPYms2dm9aZmJzZmpJWlJzSHk4bUVwTXVjYnBiRFQzaGtG?=
 =?utf-8?B?dzNOTDFHNHNZaHdUalJqTVFVaWI2S1RUb3pnUGRHUks0bkgrOE02YmlaOGRP?=
 =?utf-8?B?eDk0c0gzYkVTd1FsREsrUVVjQXpKTVZmamxyeW9vZHdZMlRvbStzMXlEMzJP?=
 =?utf-8?B?bUxzN09uS01GWDhkU21DWEVJeGszc0l1MjRmdUxZcEhEU3p3Z25lekNwUzVC?=
 =?utf-8?B?VWVJaG9KaGY4UFo3d2N3SGJ2SmJsdStIajVtcnpXeEFLdG82VFp4TWdERzY5?=
 =?utf-8?B?Rk9TaFZnQndGZWlDWWpTNk5wTkFBYXFrV2hNSlc0YUpFRXhVbEhxQ3VuSjRW?=
 =?utf-8?B?MEEwYTZvcTNzWXVLQUtuT3NDSElHUlVmSkRRSjVjaTEvWVZRY2Zvcmt2RzR3?=
 =?utf-8?B?MHZ1bTFtcEJQQVlXbWR1Z0FxekNrbFM2ZVl4TEd4eXB6clR0NWVvU2VyWjEv?=
 =?utf-8?B?WVM4ZHBMa1IrZlphWXdqNmdpeHdQUlV6cXVMOHZYL0lKQWRCL045YzdhMVNa?=
 =?utf-8?B?UHREbnkzT1ZFTTFMdzNJQjZhdGg0QXEwVlRlZXR5bk1LS0xNVnRaRlRUWE1s?=
 =?utf-8?B?UVpNMmZRQ2VqOFk2OHZjMVBHblh6VHp2OUlXNDlOakVoRi9qUS9rVjgvY1pI?=
 =?utf-8?B?T0VtREMzNlBOU01tclQ3QXU5eG14TG5IQVFXc0ZwT3ZPa0Q4R2crYlRncDBB?=
 =?utf-8?B?eWlSVmNvL21ZUWtRanhtTXp5bmU4YjdVZCtuUUZLNE9BbVVLeXRVbnFiRjNl?=
 =?utf-8?B?WWsyRTVHb1luWGhSS1paTVhWSmZuZVo3ajB5dnVmYUdQT3lwQWJQTWQweW1L?=
 =?utf-8?B?MzVDZmFEQ29oK3RzZktpU3ZheVd1c1QzRHpxOHZFNDNuY1hTMy9YYVNsZ3Jj?=
 =?utf-8?B?SURPUDZiRk5JanhSUjRoVy8zTllwMDMrNjZIOXNrcXFDMmZ1SE10dkJmZDZF?=
 =?utf-8?B?THVLYUR6Rks1UXdFbHB1aUVqYVNtU2lxOHZQNXVkVDd1Vk55UGROK1Y0Y3Zr?=
 =?utf-8?B?d3EwOE1TRk16eVRSYWN4elZmTmJFZDJrd0lIVTVraE9NSXh6TkJZWWlzWUwr?=
 =?utf-8?B?YkJZSzEwcjhEK2gzKzBWb3habytFb3I2L2k3dU5CZzYyaGNZV2hDenB0MmJz?=
 =?utf-8?B?cU4zZnpDZ0NxUElxVXVUV05WV3RaUHVKdDhhdVdIeG50ZTI5d1hma0RTQmRN?=
 =?utf-8?B?RndwbldIU3ZYckJTZTZpdXhpU05sSExxbCtMb3MxdjVieHhIWGt5NXJIcTRM?=
 =?utf-8?B?SmNWRFRjREhKa2NWb2FIc2JoTmI2N0M0dktnZjRGQllwTXJraE96U1hvWWxI?=
 =?utf-8?B?QUtRUVZHODNCQVphOVFCSFVDMytVZmxUN0wzL1VEYkdpZCtDN3pYWmE3cEhz?=
 =?utf-8?B?ajRSa3hEZmxaMDBOa05xMnpLa2I1b0EwNG12ZCtoeiswUXA4NlNwU1pZOS8y?=
 =?utf-8?B?aWg5VDF6UWRCQytxdFlWcnlNWnR5UjFBK25rWk14RENpQjBrRDVtRkM2YnZU?=
 =?utf-8?B?UlRmaHZlNmMrL0FkQXdUa29ZQUFBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:55:38.1158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874b356d-36df-4b32-5347-08de5916490f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

Make iommu ops part of SMMUState and set to the current default smmu_ops.
No functional change intended. This will allow SMMUv3 accel implementation
to set a different iommu ops later.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 7 +++++--
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 1492d7dd95..58c4452b1f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -959,6 +959,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                            "smmu-secure-memory-view");
     }
 
+    if (!s->iommu_ops) {
+        s->iommu_ops = &smmu_ops;
+    }
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -978,9 +981,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
         } else {
-            pci_setup_iommu(pci_bus, &smmu_ops, s);
+            pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
         return;
     }
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index f5060cf36f..7b975abc25 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -166,6 +166,7 @@ struct SMMUState {
     AddressSpace memory_as;
     MemoryRegion *secure_memory;
     AddressSpace secure_memory_as;
+    const PCIIOMMUOps *iommu_ops;
 };
 
 struct SMMUBaseClass {
-- 
2.43.0


