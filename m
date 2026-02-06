Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852BEEE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNBj-0002gg-TE; Fri, 06 Feb 2026 09:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAt-0001LQ-8r; Fri, 06 Feb 2026 09:51:12 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAp-0007XG-HR; Fri, 06 Feb 2026 09:51:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6qNDoi0VLpR0pawgu7Js6wW2DRCQaryZW5n3+BpDLzmL5cpO///GPqbSAJRN8VNnobRLjgLcyc1CcqezhfP8tGqndZHe2EcrTEV3SxQVH0wfQOseHhBdPACcAq+uNP3u4O3AY0sIYx+9jpRXpKOhtGXvGyIbJ+8xGUZ8Tb/oc5ffzYXRJzm2HAmfeU1cB0VIcOP7zhIIXRbugulbH9UWC6JMeK7LWZiPcEg7YUWHI5vubWse5gb7cSHTDTyjGlKQIZA4i2DyW5WX/9/AI0xtdIeP8seAYAx1mD/ShFRwCvvntqpBY6jsoPSu1UQ8E4H8uypqfcvcqa6OxTzKCryqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kvOHHgxsPw3mt6+oHnMV0HY4bZyu22BMCc0lkdPvRE=;
 b=Df+g9oGM6qb1Qih288IJFE7mvIr3qoQclAOM1Z/QzZCxeAeyZn1e8OwNVImnJcFqhU/r4LvNXmLTq4A4GvGAVAT3ivtEYIgPJFA7BT/grjeaf2NquoZHEU3a2rBXBtgeepKXWWEsYKllKEXsXLeM7VEHBnF+qhhR/0QBuCwf7dg8QxwE0ThpN56c2fgM4GXviYPF6riYKvXWnbx13a1q54BBK0igm7T0pyhs0SeQRn01J+BrmNkOcDylBUhYiWdsswc/2ynKtno4gU65qJTM1Lq42eY24OU+r3RGW+nokt0bHVOHF3KGvN4eXdaOn3NdEDlPEGBONg7Hv+fqPPLxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kvOHHgxsPw3mt6+oHnMV0HY4bZyu22BMCc0lkdPvRE=;
 b=Z5cPgySoYFmI/V0KYQcgrGMNbuAZVmVGSKR3YFx8Sw5OENF6MVLgWuO7KGQIDYtBKDkRl6DtRXSnYhPOCe6OMm+sd6+iStowgnwfk5nxn4Sc95/kl1vA6Ug+CIGyX+xtXVLtcrFB24+zo2fSi3Ge+63N0m3Iq19aUGa8bB7YRqxSZzv7BdtOdNA3H+ARQ6CdJROlepx0vVofiOQEJm59hGIgxvh8u0kUtb+pTu+MQ7VGi8paEG7EfmrqJs7IhuF8zIlghLwzMiKkgF6Y0Lgnx2brhbZCbyzpji114dNXGXk3x1SzC9qOY9HTAd8Rpq8atNP2AOy30+MJhSyjRmtaRA==
Received: from PH8P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::7)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 14:50:57 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::84) by PH8P223CA0008.outlook.office365.com
 (2603:10b6:510:2db::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:26 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:22 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 20/24] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Date: Fri, 6 Feb 2026 14:48:19 +0000
Message-ID: <20260206144823.80655-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 1579cfdb-c31d-4a06-fa7e-08de658f21da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHFHekVPMUpDSkh2ank5TzdkdEhuZGFFR2F5VktxWEdJeTltOHJTSkxxZUdB?=
 =?utf-8?B?dzh0aUxpblN5WEZJd0YwdTFsVnRzL1FhK3pwZ3lGWFIvWHlSNTJ1ZVpwUlM0?=
 =?utf-8?B?clI5bEo5ZlloM2R6eDRMdWFLN0wzeWE1L1k5V3ZlYjVCekFQU0phVGtkSVdW?=
 =?utf-8?B?M2t0cG1CNmFZV3BuVTR5WDcwYTJucVgyNE5nSkpoMjlOQnB2cjB0RFJLZ1ZV?=
 =?utf-8?B?bkx6QVBzUTExKzRjWi9YUXdZdkxsemQ4bkFqUFNVcWJhQjBnL0J0aUFpWmxv?=
 =?utf-8?B?ZHU3dnFDMzl4VkxCT2pjVXppQ3RKWmVpcy93OVk4K3NtMmxZOHV5bW93c2gr?=
 =?utf-8?B?cHJJcy9UeklXU3dNL1ZBOXozdC81elpkNlNRblY1UVlzRjgrdzlkRW9sWXZG?=
 =?utf-8?B?WnptT0xVR2lQSVFqeXNjK2tBR3ZVWWx4Z1hhcFVPMDM0RG0zQ1FSZ0VQYjNV?=
 =?utf-8?B?dGFSMTlpeXpWcSt6c2JIZFJabVNwWUNGYU93a1RScW1qdlVvVGhSZFQyckVa?=
 =?utf-8?B?NUdwNktySStWb0U0aTY3SnBRVHdndFNpaU8xUHZVbWhLa21LSmhZQmRMWFlB?=
 =?utf-8?B?YUxZMUJiTktSK0FLV1B1aWNMQnUrMFhiZU96U29hbUVHRVRFM1pIVHc3Zi9C?=
 =?utf-8?B?ZUQ4N0FoVUNqbXJISEgvM1M2QzhWMVp3Zy80aUc4aTdnVVM5ekh6NTcvVm96?=
 =?utf-8?B?YkZZcG4yNVF1WXRoSk9CUnZqUzFWajJ3R0hyR3lwVzJqRjRxdnBlZmJVMTRu?=
 =?utf-8?B?UXRwd2NnYm9Zb2kxUmxQSWVNRCtTL2c1dDNOUlBWYXpNbm9BMUIzaGNRZm5E?=
 =?utf-8?B?Y3RUcHJ3MWxWNGhQcTRKb1Zkc1ROYi9id1YrT25KamV0dzBSVDlxcTdpc2tI?=
 =?utf-8?B?bDNSb0phRnM0VkMzcFZNUklBRWdiUGxPdDNVT0hMM0l0b1VMT2tqVmdRS0Ur?=
 =?utf-8?B?SzJwbjFzbVdHNDRKbERQMlBEUUtoWVRUR241YlB5VzA2WE02SmRaVXh5VzBS?=
 =?utf-8?B?a3RJTWlaZGRRaUsyNzJhblZ6NGhkaitxQmtBdEdwbHNVMUxlN3p4S2NQVnRP?=
 =?utf-8?B?ajVYWFVMNkNScUtEeEUrN280L2ZTVm9Ic05NVUxwam96MTM3MVpXMm1RUVZy?=
 =?utf-8?B?Ym11QUh2Mm5tMzVFenBzcGh0VTh2L1pVTHFOT3ZMOHVQOVh0WHZvdm1kNWc5?=
 =?utf-8?B?bEVnekVjWi9ZZXlOR0VBR29aT0I0R01heDA4UkE0WTRrejdLRDFiTnh3a3l1?=
 =?utf-8?B?azZha2p6VEpjS00xYlpmYTMwdWhZRVl4aEZFOWlQVHZLNWdkbmhzT1h2N20x?=
 =?utf-8?B?V0lqY2NyS09yaVpnMDg1QXZ3OGVRaS81NE9WUGpFWURDc1Z4QUh5QzFvbFgz?=
 =?utf-8?B?TzJRdGVmZGNia3hiU0xpdjNLTlowVGlLWWNKK21SRmo2dG05UWpnSDF0dFU4?=
 =?utf-8?B?MCtwMEI1WDNrL1V3bTZhdWtqb1dGSGRzWDY2UHpSSXJNckZOL0ZaSU5lMzdi?=
 =?utf-8?B?M01wdGlZWjFvdVFnWTdMK3pNbzM0a25FOW5MRm1hMUhjekxWUGJkNVM2Kytk?=
 =?utf-8?B?ci9RSkFabmlzL3NJcElEUUMxb2lVRFVyNWsrTjR6ZDI4UWEyWm1VU2JrVUZk?=
 =?utf-8?B?anp0Zk4zMnBQL0lINEM3M3FQelVFZHZ3djBMcjM4TzlPd0N5VXVadVlDNnZ0?=
 =?utf-8?B?d0JVMjVEQXVtcUpqdSt4Z0ZyN29HeUdZYTIwcm1TM2QvNGNOcjNIUnlwbUR2?=
 =?utf-8?B?M2NlNWhLZStTVm1PQlp3V1J3MDAvakwxN0JDa1N2Q2lJZUJWZDAwTVdaa25P?=
 =?utf-8?B?enROM0lqN1pOWFUvc3VYbmF1UXA5ZytVL1RXU3p2K0tuNzVCTWhDVHNGbnlw?=
 =?utf-8?B?czZOMnJMRXhYTklNVU5wSnpNQ0h6SDJacThheE1QMUdra1NMYmYzREgxb1px?=
 =?utf-8?B?TXZJaXZKNEl5djNLcktzeFdQMXhaTjhydzc1NmtQcElUdmNTMDhyNVZ1QXFz?=
 =?utf-8?B?dzhoMlRhYzZFVFN0dGJBOGhYR2xPK0JFMmVKMVdYSzJIMllDSHdybXlHK2dO?=
 =?utf-8?B?cVQwVzFiZEh2YzBoN2c2cDFUU3dKeGdGUU12eWR4NVlmbHR3QVk4N0VmTW95?=
 =?utf-8?B?NHh0c2hMSGhaSzRVNFNBcFNaS1hOTGc5REVuR1RuV20xaGc5Vng4aFhVSGxu?=
 =?utf-8?B?T0loQ3NGYzFrMEwwQW03TStvL0poUU1aYVp1eVFrN3VLeHo5MEtrc1VodlZ4?=
 =?utf-8?B?VmJEaXNwMGhaVW5vUWloSWJuTkJ3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EpuxqF4b3TDiay8gHa0RmDKtJlsMkHL1B0nSfg7UuNOYLegT1Lf5I7yXKp4kjuD7WTJb+yTwAUNXmjV5ZqfkD1aTp0FA6eN3YpE4EEh02Esuc2E2eRAQAQ0vpwoAkWX/pRnuL4UPIx7AECcyMqf6EKjdcBMTnpKbIZw/6bcOvPN+pElaQUlVsgTWDVvttGXVZvNi6DUYAYLhZHeFkCAPR30K9MCeXUhyQMYY9vvX05ZOCi4yWCQc3038rRbyJfk6kCoQydXQaahk3l/DmkibcCgpXHDhIwZtZaFQsaNHfUBvM6If4AndtIsedY7AFKhtjn1Fo2GyhTpI4FWXsbILPViSarhWKk4lkVa1qyDBfxkPXPLqvQ3fqHENwFwSifeYXwYOy1Qoe+zxMSkZEP1EhLBVxxu1Y3OvQP2qaSpgaIXqaljUQ0AYhPsx7K1sSHgL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:55.4723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1579cfdb-c31d-4a06-fa7e-08de658f21da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

CMDQV HW reads guest queue memory in its host physical address setup via
IOMUUFD. This requires the guest queue memory isn't only contiguous in
guest PA space but also in host PA space. With Tegra241 CMDQV enabled, we
must only advertise a CMDQV size that the host can safely back with
physically contiguous memory. Allowing a CMDQV larger than the host page
size could cause the hardware to DMA across page boundaries leading to
faults.

Limit IDR1.CMDQS so the guest cannot configure a CMDQV that exceeds the
host’s contiguous backing.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 678e53d23e..19fcc5b68d 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -11,10 +11,14 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include <math.h>
 
 #include "hw/arm/smmuv3.h"
 #include "hw/core/irq.h"
 #include "smmuv3-accel.h"
+#include "smmuv3-internal.h"
+#include "system/ramblock.h"
+#include "system/ramlist.h"
 #include "tegra241-cmdqv.h"
 
 static void tegra241_cmdqv_event_read(void *opaque)
@@ -582,6 +586,33 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     return true;
 }
 
+static size_t tegra241_cmdqv_min_ram_pagesize(void)
+{
+    RAMBlock *rb;
+    size_t pg, min_pg = SIZE_MAX;
+
+    RAMBLOCK_FOREACH(rb) {
+        MemoryRegion *mr = rb->mr;
+
+        /* Only consider real RAM regions */
+        if (!mr || !memory_region_is_ram(mr)) {
+            continue;
+        }
+
+        /* Skip RAM regions that are not backed by a memory-backend */
+        if (!object_dynamic_cast(mr->owner, TYPE_MEMORY_BACKEND)) {
+            continue;
+        }
+
+        pg = qemu_ram_pagesize(rb);
+        if (pg && pg < min_pg) {
+            min_pg = pg;
+        }
+    }
+
+    return (min_pg == SIZE_MAX) ? qemu_real_host_page_size() : min_pg;
+}
+
 static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
 {
     SMMUv3AccelState *s_accel = s->s_accel;
@@ -589,7 +620,9 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
     struct iommu_hw_info_tegra241_cmdqv cmdqv_info;
     SMMUv3AccelDevice *accel_dev;
     Error *local_err = NULL;
+    size_t pgsize;
     uint64_t caps;
+    uint32_t val;
     int i;
 
     if (QLIST_EMPTY(&s_accel->device_list)) {
@@ -660,6 +693,16 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
         cmdqv->vcmdq_base[i] = 0;
         cmdqv->vcmdq_cons_indx_base[i] = 0;
     }
+
+   /*
+    * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
+    * queue fits entirely within the smallest backend page size, ensuring
+    * the command queue is physically contiguous in host memory.
+    */
+    pgsize = tegra241_cmdqv_min_ram_pagesize();
+    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(log2(pgsize) - 4, val));
+
     return;
 
 out_err:
-- 
2.43.0


