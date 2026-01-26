Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1FFCF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7B-0000iV-Sq; Mon, 26 Jan 2026 05:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6J-0007Ns-RW; Mon, 26 Jan 2026 05:45:50 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6I-0005Z5-0Y; Mon, 26 Jan 2026 05:45:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+RAU81iR2/nh4af7Y0TfC7sEHkRnsr+lXFkRroqgZRL9HCmb34GxrHtQLwcIb4b3fXRxhfiv7MT8tA6eQPNE4k2rPD+o2Fyj7iJ/msT2qloHwkfRL0uw2DtH2zIacDRJKWHE6ZIXzJLPz/Ne41vsklfdukcqO+iBl9hwlhVy1jUaxOCutExTJU5QXneApqMUKsqrkoz2wT+tx+9phG1kZvyhFt45MbVkA1lOlZ8WNkub245exQxi1vmjWV1HCpvGscazRk0DbbNt5Khy5vcgi8JXeLPn31CixiS37JCzUWp+wIWYzQl72yiR01rC3qddYZUwYiN/brVg8qyVg8G5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bhp2dmPHJ0YgWIRTcoQHpWneYWyVs7+X8bO0sf7bS0=;
 b=MeppukrndZQB+F8jXldB1itZaRVnHisixL2ECA3aWAKIFyJgae3uCTEIYatBSwy715OvSF7KtqX6vxigWZbyT7Ck3z7gVzvR0GxSB+4Nab3idUOR+uED4EVCmhKH8lO8f51QHGQCOc1ja62YG/m+8PFGl+0UkmI+J9edUVajbr8d3X06f8epJFZqcCu/hdTONV7bgVbXOeEAnEBsTb7qOIy49gmnS4V+WwCIdYuHA++PV+FUGPqhwMvZ/yyD8u48c2p8I+QF6cxfkZH2xmN8eW9dvEYSI9gLiUmPnqfLLX1bbf/Qrf/fukrtln5TUhDCcL2V8Uzf5IzXbKRFWy1TdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bhp2dmPHJ0YgWIRTcoQHpWneYWyVs7+X8bO0sf7bS0=;
 b=qD+cSN8Y12lt+cLPuydGHDLiBwXfldwDXOPu3xLnfTp0jmQ9NZCrYKOmD2C5fz04p/saKWiWyUsUeDUPX2b+0TrR2sQvcK0++tDMURvahsS3jvukGjLpqXzSm+dpzCRSZb50OAYqAQZYAMlxYpnnfM2S0g8UR09Rs+hL9pyo7EVK6w3SRO0M6bHutBp7BebIqDNPRH/Aboorygulwu+6cFPsUlK7EoEQzOEt1ZJznLQLdGWCCYfjIb/D0B1BCOqzMbVB+De0U85IPFIITzdv3IzpDXo83y25Q92aaRkFea7FWLXpJ9p0wuT9TPzwFcQawordQTCw26jZo54YYmmt2A==
Received: from BL0PR01CA0004.prod.exchangelabs.com (2603:10b6:208:71::17) by
 SJ5PPF09E5F035B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::988) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:45:34 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::25) by BL0PR01CA0004.outlook.office365.com
 (2603:10b6:208:71::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:45:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:16 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:11 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 10/37] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to
 vfio-pci endpoints with iommufd
Date: Mon, 26 Jan 2026 10:43:07 +0000
Message-ID: <20260126104342.253965-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: e81615af-7c5a-40ef-5395-08de5cc808df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2RKalVFUkdNVHlDU2lka0dXSzhFL3Vpb0tBOUhiaTBrVXI2SG11NFVlbkQx?=
 =?utf-8?B?NUpCK3I4ZjFOTGlxdHIrZDd5czQvdVppejRqTmxaZnRudjBCN1hlUEJscDVN?=
 =?utf-8?B?M1Fod2Zsd0twYnRGL0xtaVBCd3B2YXFmOGlYT3VLcDNxSnB2K01YcjliSFRH?=
 =?utf-8?B?UFlkRW56aGRKVVdhNWlKSGswVkpFQnZ2L2IzY0F5U3JWeHF5YjJwN0FWdEdW?=
 =?utf-8?B?R2NRV3gzY3FsdjVpa081Mm9IdmVZZzY0L1QwWUg4dHlKYUUxc3RJZ2UrWllC?=
 =?utf-8?B?ZUI5OUd6a2FLSkxKTjZibzcrQ2R4S0pWdHpySHNOTkhlSUhGdUlXMlBES3Zv?=
 =?utf-8?B?WUtqcnA4Wm0xK2hCa3pLelVoTUduVHhTb1N2bE1aekw5NFVjaUhnN1JhNkNZ?=
 =?utf-8?B?QXJ2UkZBVnpmeWx4L3NKYjlmWTBnZnRxTTJVQ2x3Vk92cE5HNEJiZndwVG9O?=
 =?utf-8?B?U1ZLN3dSYzRTQ3JiRmtHRlJWOG9sdXYzOFhmM2lwMWFoWHg2WGZ4SkhuRlhE?=
 =?utf-8?B?WGcvZVkyQzNkWU9QcXVSS2lrMDBTQmVKRDJVK1RmbTl4Y1dyK21Lb0JrZUkz?=
 =?utf-8?B?RkZlOXE5Ri9Yb3F4dTd2ck9nRFhhTTJDREJhL3FwL2g3WDE1VzFjdnU1dlBy?=
 =?utf-8?B?a1Q2R1lsQjQzMW5RdGgrdTFRd1Jza1oxb0JDS24yS0VIb0F5bFVTbzJlZlQx?=
 =?utf-8?B?YkhzZjlSaGVQcERyZ3VmMWhVS1pxY0N5UUtKMlJjR1NXODhraHB0RE84QlZT?=
 =?utf-8?B?cDUzM3pib2ZaMlpKYjRHK2RSYmhLODR5K0JnYzZaT3E5NFNNWDFIUmlwUEVO?=
 =?utf-8?B?YlBVVzNSOWtuUEI5QU5zVFgzOXFJcmp2WjRqSXFFNU9qUUdzM1M0YlJ3TGFY?=
 =?utf-8?B?bjUwOFg5LzdHV0h2VUIzSlVJc2ZiQ3hSb0RwTnVNZ1RaeEU2dDNiOEZjSFFP?=
 =?utf-8?B?TW1DRHZ1VXR1bnlJRWVrTjFGN1c3WXdaZm9FOTBwYkZIYWhWblRsSHBhRGtn?=
 =?utf-8?B?SnUya285S3FvK2kvNjZlTXdqVXZoOHF5c2hqOVJSS1hienlTelVDbkRwWkNu?=
 =?utf-8?B?S3BFYlM4VmdhWHVEUEVIM3ZKT2FMUkJ2cHUrczVOVU9WRHdJT1Q1K29ld1Y1?=
 =?utf-8?B?dXIrNWlEQlZqOC91U0U5ZGxHaWpWRTVzdTN2YWd3UlFIZGJOdGRlRjgxNTMv?=
 =?utf-8?B?MStCNkJ5V0VoK0oyUWc0VTNLWHlPcHJHdjhyYVdrSzkzZ0pJQWFvb29hTHBR?=
 =?utf-8?B?ZEpodU5DT0NWSzg1aU13SXVWOUJGNFpNa3BBb3B0T0dCN3Y3bDFmKzg2c0sr?=
 =?utf-8?B?cWJBZzNVb2ZtbFEvbTk5R0NzYVJ0NmUrQlp1WDhwNDhNZDQrRm5qQXl4SUgw?=
 =?utf-8?B?QkRsUERoSmR1MW8zWC9EQzFpbC9xRkhiSTBYVnQwa0ZJa2IycmxIRHp6eWEv?=
 =?utf-8?B?RlRkWG5QbXlqbVpGV3BrM3lEUUpEN1BNYmdLelZqdDdlaVppRVJ2OGptNEVr?=
 =?utf-8?B?ZTdadUhjeGFPVncyeFgybHRrejlqNXhvdHhPcEdjLzZySEF4UW5ZU2dKUVhH?=
 =?utf-8?B?MmdHbittWXRMYWlLK1ZLeitUY3FCdTBkV1ZVNnFwcXF2TlFNVThuWDlpN3Fj?=
 =?utf-8?B?UTNXOVRhWExiY1NhWkxaaXUwUVhYVzUzU2I1MEFIS0JSMklKeFlvQnltSWRX?=
 =?utf-8?B?Z0RodTZVOWZORWxpRHJtUjE2ZkdNRzlUQWUweWJXKzl3Y1FCaE4wNkpOODNh?=
 =?utf-8?B?YmkvekZHQ09ERDBmeXlIdHdQdldRSzlndHdjWk5OcFY4Y3o3bVhGQWJNNUJ5?=
 =?utf-8?B?TUFzb2dPYms4RFplVEdHa0xTd1dhWEx6YVFUY3l2bzEvWkNXWkZCMmJSVGY5?=
 =?utf-8?B?QjZZeU01djZteVREN1dKNUkyZ3V0NC9JWFJIZzN0aVVXWHlhMHdGbi9hcTNX?=
 =?utf-8?B?WDZTMFBSM1dENGxxd05FNk9hM1pYd3hwQ3dwczNJK0UyaERTUGkydXpaeEc0?=
 =?utf-8?B?bjVqTzVUR1pPVW1yamUvNUhGL1B2T3o2azR2dXI4eEYrVHN4dEdyQ1BFRC9Y?=
 =?utf-8?B?TDNlb2FQRGxXMXJQaFZ1QzJML2l0S2c3ajlxaEZmYmVvSmsvaHZQbmdFMkFO?=
 =?utf-8?B?U0ovcUcrMVFzUEtVUnMvWmYyYnhJMHFWLzFrRmVpRXFUeXcyUzU3NitiOHlB?=
 =?utf-8?B?aDVyMWFueU01OWZwRmFnVUhIUVZsYnhTaGF0Q3N6Z2dQRXNORTF4RHFxbURY?=
 =?utf-8?B?dXpmWXVhU0Rld2xFUzVJREdxMjNnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:34.2813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e81615af-7c5a-40ef-5395-08de5cc808df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Accelerated SMMUv3 is only meaningful when a device can leverage the host
SMMUv3 in nested mode (S1+S2 translation). To keep the model consistent
and correct, this mode is restricted to vfio-pci endpoint devices using
the iommufd backend.

Non-endpoint emulated devices such as PCIe root ports and bridges are also
permitted so that vfio-pci devices can be attached downstream. All other
device types are unsupported in accelerated mode.

Implement supports_address_space() callback to reject all such unsupported
devices.

This restriction also avoids complications with IOTLB invalidations. Some
TLBI commands (e.g. CMD_TLBI_NH_ASID) lack an associated SID, making it
difficult to trace the originating device. Allowing emulated endpoints
would require invalidating both QEMU’s software IOTLB and the host’s
hardware IOTLB, which can significantly degrade performance.

A key design choice is the address space returned for accelerated vfio-pci
endpoints. VFIO core has a container that manages an HWPT. By default, it
allocates a stage-1 normal HWPT, unless vIOMMU requests for a nesting
parent HWPT for accelerated cases.

VFIO core adds a listener for that HWPT and sets up a handler
vfio_container_region_add() where it checks the memory region.

 -If the region is a non-IOMMU translated one (system address space), VFIO
  treats it as RAM and handles all stage-2 mappings for the core allocated
  nesting parent HWPT.

 -If the region is an IOMMU address space, VFIO instead enables IOTLB
  notifier handling and translation replay, skipping the RAM listener and
  therefore not installing stage-2 mappings.

For accelerated SMMUv3, correct operation requires the S1+S2 nesting
model, and therefore VFIO must take the "system address space" path so
that stage-2 mappings are properly built. Returning an alias of the
system address space ensures this happens. Returning the IOMMU address
space would omit stage-2 mapping and break nested translation.

Another option considered was forcing a pre-registration path using
vfio_prereg_listener() to set up stage-2 mappings, but this requires
changes in VFIO core and was not adopted. Returning an alias of the
system address space keeps the design aligned with existing VFIO/iommufd
nesting flows and avoids the need for cross-subsystem changes.

In summary:
 - vfio-pci devices(with iommufd as backend) return an address space
   aliased to system address space.
 - bridges and root ports return the IOMMU address space.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index b2eded743e..2fcd301322 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -7,8 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/vfio/pci.h"
+
 #include "smmuv3-accel.h"
 
 /*
@@ -37,6 +42,48 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+/*
+ * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
+ * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
+ * endpoint using the iommufd backend; all other device types are rejected.
+ * This avoids supporting emulated endpoints, which would complicate IOTLB
+ * invalidation and hurt performance.
+ */
+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
+{
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_PXB_PCIE_DEV) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_GPEX_ROOT_DEVICE)) {
+        return true;
+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI))) {
+        *vfio_pci = true;
+        if (object_property_get_link(OBJECT(pdev), "iommufd", NULL)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool smmuv3_accel_supports_as(PCIBus *bus, void *opaque, int devfn,
+                                     Error **errp)
+{
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+    bool vfio_pci = false;
+
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        if (vfio_pci) {
+            error_setg(errp, "vfio-pci endpoint devices without an iommufd "
+                       "backend not allowed when using arm-smmuv3,accel=on");
+
+        } else {
+            error_setg(errp, "Emulated endpoint devices are not allowed when "
+                       "using arm-smmuv3,accel=on");
+        }
+        return false;
+    }
+    return true;
+}
 /*
  * Find or add an address space for the given PCI device.
  *
@@ -47,15 +94,43 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
 static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
     SMMUState *bs = opaque;
     SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
     SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
     SMMUDevice *sdev = &accel_dev->sdev;
+    bool vfio_pci = false;
 
-    return &sdev->as;
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        /* Should never be here: supports_address_space() filters these out */
+        g_assert_not_reached();
+    }
+
+    /*
+     * In the accelerated mode, a vfio-pci device attached via the iommufd
+     * backend must remain in the system address space. Such a device is
+     * always translated by its physical SMMU (using either a stage-2-only
+     * STE or a nested STE), where the parent stage-2 page table is allocated
+     * by the VFIO core to back the system address space.
+     *
+     * Return the shared_as_sysmem aliased to the global system memory in this
+     * case. Sharing address_space_memory also allows devices under different
+     * vSMMU instances in the same VM to reuse a single nesting parent HWPT in
+     * the VFIO core.
+     *
+     * For non-endpoint emulated devices such as PCIe root ports and bridges,
+     * which may use the normal emulated translation path and software IOTLBs,
+     * return the SMMU's IOMMU address space.
+     */
+    if (vfio_pci) {
+        return shared_as_sysmem;
+    } else {
+        return &sdev->as;
+    }
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
+    .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
 };
 
-- 
2.43.0


