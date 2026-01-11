Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C44ED25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Xo-0006Jo-0B; Sun, 11 Jan 2026 14:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xi-0006GQ-Rp; Sun, 11 Jan 2026 14:56:07 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xh-0003qD-Eg; Sun, 11 Jan 2026 14:56:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS1jhGdVFOO6As0DNBq8yKjAKIK6YZJp3tKHtOvAYXtMAvhPx6hNhPSbGfyBfXHYkVKTw0idwkbjI4hrUl5S3m73Od8dOvQKDHUvUqVMbOpg4RXx5vPPSwYnIy1xcMGQHyLU6l0UU58QW2nncAWjKj/aXDy+/Z1ZrL3NsvvJqEc7BF7fQZuS7ViqcDXZY4KoRMFptrTn590KVQRg3kt7vIJaQZOVAH2BMRUzCgjpf9WwPztBMNNmHsyHQJpV5p2EUk7cTQ8wDYkaC8QJAAeeY/raZ6LAADIFj+oryXxCDNDqdm1iHvve94GZL/t1KAjETpsEaKDE0xYxGqy8Dl5zQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+iOCan5hZR4PtKpH8Lk+3XW2AYxUQ0fHRyPOP2c6hA=;
 b=h9PH4XcpCEzljM45V6UyuiRmo7d7XkXXuNb0cWvut845EId4ar4cw3QeoX2JpNDJrpkp3txRar3xF+rg9/0kQNbolp6Z0FcPYDoR9gxoPArfsCzrKWIqX17BN0ENUhE9z5WGg5Yo98G5cZlKh1ipHq7S67tCokPw+IwsbLXMQXuLVz17Pwrz5dB0yY6pYere229+XqgiLjikhNBgqLKkgGP3s41DGprPZBXzOjZzkCyC8B44hBfYIeovRwKM3dInelY94NqxAQCr8eflx521mw9Us337IhbcQLEyVjieQUMfQ3QBRozRegifmrM1fcyaHDmndKN0mey/2EcbsS3NtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=nongnu.org
 smtp.mailfrom=nvidia.com; 
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+iOCan5hZR4PtKpH8Lk+3XW2AYxUQ0fHRyPOP2c6hA=;
 b=HcvjLSMzoS9Y+CboEZnNL2W9m8fUF6Aw9Cx/5BNFGY/VMdDpRzO5wcEQF3AyVsNvZl1N4z4/YawoM3CHZjYlneuhmeD57RB8A/9OUduTpYhdj9tODQ0gcSgVLRrxcDPWn3xOMXnT/G2EgMNHxXKr41k6vm6BodK9nTmOG/WGMd9IcxYFyqLUSeJZUyNPR/4MXeyqIjF7rbDr9SjKSl/sicR9P9Usbw5rKBHwX6qgkFiFX+0MZsE+U193arOQLzsmv6ROT3yrKhr9EhoD/lQrOU+ejvS6szrVihRX4EtMO8nRavLcRPwXGwCUxxZSQ22M5IwnreUTABs9AaIxgZgQ4g==
Received: from SN7PR04CA0153.namprd04.prod.outlook.com (2603:10b6:806:125::8)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:55:59 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::59) by SN7PR04CA0153.outlook.office365.com
 (2603:10b6:806:125::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sun,
 11 Jan 2026 19:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:55:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:52 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 03/36] hw/arm/smmu-common: Make iommu ops part of SMMUState
Date: Sun, 11 Jan 2026 19:52:49 +0000
Message-ID: <20260111195508.106943-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4a7bfc-2077-4ede-a45f-08de514b7086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXV4ckRSUHR3blU5cmdHWVJZb0FNUzF4TEtHc3JlcWZHRzlzQXF4bVNkbmg0?=
 =?utf-8?B?RFV6ZEFmL1E5b0E2eWtxRWNKWFgrYmErVDQrU3AzaTBRNVdNanU3UVJ5VW9C?=
 =?utf-8?B?b0twSTBxLzQyMnNQSXpmWmhsaS80eW54Q0tCNHRHZXUrMDVFL2hxSEgwam1x?=
 =?utf-8?B?ZGtrb3VEbWZ5ZmdJV0RYZTh4YnJSRTV5MVNmNU95M2NRZkt6WEs1bWt4SHRH?=
 =?utf-8?B?TEJzeUQzaFdyOUJQTkFjOG5WOGN1Mk5PTHJsczFMM0xieklaNnlLa2R4cWJL?=
 =?utf-8?B?SFdtR2oxTkh6U25mRTA3Nis4WXdCb2ZUY1lVL2E0MzQ0WTJkbEU0RFVXV0dG?=
 =?utf-8?B?TU5PSHpqMVJJNVV6YUtoc2UyaHk5UVY2L3E1Z2tEdHlEVjI1eUZKM3JUMXgz?=
 =?utf-8?B?UGx0bGp4R3NiMGNsUFdyb29KN2lLVUdha1N2SlBFRVZrcVFPdHBmaE5QS1dG?=
 =?utf-8?B?YUxtZXpTT01ZdnZBUHpYNW5CWXJJQTJ2cEJYYVJUaUdRbENVbWduMVpISERx?=
 =?utf-8?B?a3EzNHJlR2g2UGNtQzIwMzVaU1Bxd3VvTXY3YjBrY2lYZkV3ajZFaE85VWY3?=
 =?utf-8?B?SGJ5NDdSM1oxYkFCWTFsTmN6OEFEM2wrU1ZtZlZnRWNjUFV3UUFYd2RvMXFH?=
 =?utf-8?B?MEpEK3pwc0k3K01MTUxleHlzVkZxQ0JHSFJkbjF2RjFyNDIvby94RE5MalBo?=
 =?utf-8?B?SjlCQW8xbVlZOFJvNWZnSVVrT05JSkNwZ21RWCt5Y1lDOGEvTlFhSUV3SThr?=
 =?utf-8?B?S0k0d3N6OWRJVk5BYnc5WUhOc0NGTjA0K0xBa251dGFWWWRDSmpLR0ptdVpv?=
 =?utf-8?B?TGRQUkVCU3MwMG11ZlB4U05VdUVnRWplZGtIZUVLY09TZWliRldkZXRFR2U0?=
 =?utf-8?B?ZTI1cUR4b01Bamw4RUlqVjFmK0V2bDdFM3JHLzdRcXZCblo4MytyZFFlSU8v?=
 =?utf-8?B?NkpEQUluYUo4c3V5MkJsMWpSSDk1VkhyVU9DazlMcjBPb2NWSlN3ejQrTS9x?=
 =?utf-8?B?VWNxUUM3ZE5BS0g1YVNQajI5K0lGcCtqSUhTR29PN0ZrMVFOY3p1dkxoOWxZ?=
 =?utf-8?B?eCswTFdEdVFma3JVZ2JjZjFaSnlCSmtDbVQ4S21EUW9Vam1XWlJWMDhub1Er?=
 =?utf-8?B?bVNacUVXSDZmeCtJRUZLUklFME1rdlMyQUQza3I3cHF4UGY3QlQwNWEyVXE5?=
 =?utf-8?B?ZUQyeStXY3RwUi9nbGJwK293RDRXS3dlQm9leUhublJaTE1oWEpEbUdNMjJi?=
 =?utf-8?B?aFJWMjhLZXg1Z3FUMEQ1aVN1VW1jcGJIdWxSVnhDREROUFNtb0tZTXl0aHFs?=
 =?utf-8?B?ZkhVOU9GUSttaXl6MlhaR0hrOVVLc2NkODJFM01PR2k0aXVMbkxNWURTQUlD?=
 =?utf-8?B?UTlaWHJhbGp5UXNaRjlpdStzQmFEZkdwVFpkMU1hN2RIR2x4STFoY1o3a0FN?=
 =?utf-8?B?ZjF4Wmo0TE0xeDNhU1EyTlJHa0FqZk9Na1FiVEg2aGJLZXhqMCtUaGxMVVJ5?=
 =?utf-8?B?V0NzeTl4VG5acWtrLzh2UWgzN0N3RE5GaVhmdWgrTDdIWlRZOXBsTzBKTkkr?=
 =?utf-8?B?QjBXUUI0ZHJLVWtYQ0JKdE1TZElIVmZjVStCK0U5ZjJBaGt3SERNUUFoQ1Jk?=
 =?utf-8?B?cFhoSGQwUWZyeS9xWllCVWhHQXFUbFpKaWZRb1NlVzhVQ3lLS2Q5YmRkZFNl?=
 =?utf-8?B?c0pHNlF1Z1JiY2tqcEw1dEhucHJLK0grTWF3NUtDdjhSbW4vZjhtYUlDbHhk?=
 =?utf-8?B?YmZEMlpxQjFET0src2JhMmNBaFpvbXBuRkJHTitDTkE3SGNrK0g4a3MvYjZE?=
 =?utf-8?B?UVZnY0lpcVF5V3dNbTlMMnVhS1I3cFA5TCt0WllCMXAraUtQWlFuU0ZuSGhw?=
 =?utf-8?B?L29iMFF3Z0tIZWEwcXpkUlR0ZnlSaHZtVjlzN2pyejFrT1ViUGVyOHZuc2N1?=
 =?utf-8?B?L2kxZksxRWJOZXZEdjRTTnVWMFJjQkliNkxUaXVFYlZtVWN2c2xUTENmemVt?=
 =?utf-8?B?RnV0K3NYQU5jY0dEaDBIdUxVWS9Qb2hUaXlONFlWWFh4b1VLb3NubXVxTm5a?=
 =?utf-8?B?K3JJek5hTWFjMUhmb0RsMUlpZTRCZllrNzBEU2pVSjNidUpaN3ZLRWlJQk5q?=
 =?utf-8?Q?HqKk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:55:58.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4a7bfc-2077-4ede-a45f-08de514b7086
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 7 +++++--
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8ae120c11e..6d7945343d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -952,6 +952,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!s->iommu_ops) {
+        s->iommu_ops = &smmu_ops;
+    }
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -971,9 +974,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
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
index ed8c085538..e9e20d8f90 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,7 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *primary_bus;
     bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    const PCIIOMMUOps *iommu_ops;
 };
 
 struct SMMUBaseClass {
-- 
2.43.0


