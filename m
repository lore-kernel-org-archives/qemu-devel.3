Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EB8CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4f0-0008Hw-Sl; Thu, 20 Nov 2025 08:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ex-00083T-97; Thu, 20 Nov 2025 08:25:15 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ev-0002au-0W; Thu, 20 Nov 2025 08:25:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAzraJg2Okrbi/4+G2boGBAaC481v1sxT+tVDE+SQbeMBuYyIp4hPKYJ1mclUbCeWZk9/kHimX5SFSP2/rrp/F4tdezPjTSquczwrneqIP/5+A7vUpAdWQnBfGMGOgtN7lQYFw9eNHOb42Vjum5OhIQ9T2tpkZv6QaKzoDj7jx5Cw/ASQJu1ZfF8pjWTOGZcd7+W6NM3subOneYrQXetXhON+Um7IRG0vH9WjrYV0Vgtn/vCfSr2BO62LzyrVtCzQImRgA8S9A1wH+01cphvbYzmvZlS5NXuwzGR0p3YhWI4+hJN3g3ude8gm4RsGbDTXQpr6Yu5wh8Vybh945DNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/baq1oUz9mdY3GT5WiqTs5IvqnYWpke+vTBYgeUBBk=;
 b=yKaXFQ3T/MlMz0Z5rBkyL4IDeE9jrUKdTMwh+9QXnxUJ+3FyM3LiTnnnMhczUP1SFFfsjwwpDQCsZFiQYz5/KEEw8hj67ueulLJd4mPaBCOC0H8oVDE7Vwb1n2B9BHpV1+Yh3E6bp+WTXq4VJsYKLIF6735buhkSE8/Sip7aI/DrdTL4DTB79C5S46l0mGsgEzlG727krek0NvMM+vz3fRJTcE2WbkSibYwSNKIf6InW097cn1svONZtEsF5V9jUsqud/ap6WPGndqT1zIlFJ4pdfj9VvyaqZYmZw35ID7HhlRlj/UM2YOkoeWUdlIShOcnpPxuWSls9Ej5Om2q22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/baq1oUz9mdY3GT5WiqTs5IvqnYWpke+vTBYgeUBBk=;
 b=cTQ4UFyjyoA0YyoshmLJoKwsTs/is5Jr42ZREl0UjTcrYPUCCV5yXY0MBjwryIlhbzmRpOoKoAhVnCkOZAhPdREs+yIgwMcCsBfOlt4k2ZOntSXfsZy9ucn7Ht3MVac/uEEra6sfN2IBXondnLPpPHeftAajHJQ2F4DnIA7hBsLoQCkA9iUYfD0STeDiEU+NnPvtlASgX2U+McylEoiMQUaIhkClxjgDuLIFcXSuG5KnIHia4oztVPh82uEYNh6XtFpuSojbGJ0FXLOZIKLFUo0dCkJtbd1WxR+siP3MOQtP2k3Kt2tObnZFRwRfjZOrjsUvPUDb2ztGHY+ImkiZdg==
Received: from BYAPR08CA0037.namprd08.prod.outlook.com (2603:10b6:a03:117::14)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:08 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::10) by BYAPR08CA0037.outlook.office365.com
 (2603:10b6:a03:117::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:49 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:45 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 21/33] hw/pci-host/gpex: Allow to generate preserve boot
 config DSM #5
Date: Thu, 20 Nov 2025 13:22:01 +0000
Message-ID: <20251120132213.56581-22-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 711bc148-397a-485f-974f-08de2838389c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGhmT3M4K01aQi9qaHAzV1hweWJ0bHd4NHk0VmVYUTBwV0V0NmVOVXBzTzVx?=
 =?utf-8?B?WVdsc3hwN3BPUGdUdUM4a29aNCtYM2ZrbnlQeUpKZmFKYUtuTit3azh6YU9q?=
 =?utf-8?B?RUhkckdBb3JEVjQzN0RmNXFDMWs5aDBnSmw3VStaRTZKZFNOQ2R6QnpacVAr?=
 =?utf-8?B?TUhFV2hJa3UrbFhRUkE4RjhlZmxlTzczSGlDbGlwVGozd00rVmx1U3ZCZXd5?=
 =?utf-8?B?cEhqdkNxK2w5QmdLNDNDNnpjcUgxb1JReE52Tkg4Q3dSZUpVZ1JNYWZiMC9q?=
 =?utf-8?B?OXNTWkdKREdxT3VUbE16dkY3VGk4bWtzYjdON29pNW0rSzlwRy8ydTl1MHpG?=
 =?utf-8?B?VHo3bUtHd1pNb1NkYmZFZVpYcWhSNytlTjFDbGRaeUtvZVVPeUNScm5qcE5y?=
 =?utf-8?B?S3MyaDV6RWpQWDkxQ0VtZk5NNjAyR2p2QkhuYWNwamNuVWMxNmdRSFpGZnBJ?=
 =?utf-8?B?WXlsWGpuWmdmdXJ2RW5neE5aZHBjNWxLUURmTnFlYkJwNy9aNUpwbnhKV3dq?=
 =?utf-8?B?RHU5NjVxYjY3d2FqeGt2N0c5OFNxalczVlcvY3ZlRUttN1pJd0czdEMvOWZC?=
 =?utf-8?B?aVlONVVSZE1Kc21aTXRxaHZjYVhWa3RvK3Axd2pKS3ZrYVBSTkg4ZDhyMjEv?=
 =?utf-8?B?MVZlS1JrdTZjN2g1SHJ3Vm9jaVU3TmE3WktEY3JHUjB1Zk1QUzZPbUVtaUla?=
 =?utf-8?B?d1JhWGJiZWNHZnIvcElEUGwwSm1zYXlHUVcvT3JjakpDcVBLK2Z2UCtKemJY?=
 =?utf-8?B?ZTRHc3RlT2lUTkprbjllZjdNL1pvWjVaUG1HUHl4WWxDREZrM1BJN2tTSXpl?=
 =?utf-8?B?STZuREdNbDdoUnh1UUtYSzRQZ0FPTk5oYWFxdGgzQ3FjK1pSQ0R2TGlodk9h?=
 =?utf-8?B?WWxlQWozRG42OURjMktFeG5KMXcvQ3l3RUo0dGU0TDJmUEpyM0U1TS9sMGNM?=
 =?utf-8?B?TVFYWkk4RHBsU0tkWWZpRDlXV1dteXZyUEpDUEpwR2todm5wVmtWSVIrWW9O?=
 =?utf-8?B?ejAwYTF3amdjVDYrUFdRZXd1dDhleXpWVWN3b3hBUjFBRThKNSt6YlVDbTJj?=
 =?utf-8?B?QjN6S28rQzdVM0NpWEx3azJScG1yYmluZGhlZC9rdnkyMGp3RmhGeW9OdEhm?=
 =?utf-8?B?SFJIczNTVk9tYm5VUTlheThKSGc2R29LR096dmNhTVFjQXRsVUlsN1dRNkt6?=
 =?utf-8?B?UVVOQlNVYkNzdWVxTVVyUDJmMnpnMzBRQm9MemZPdXNBNi9ZaTUyU2E0dFAv?=
 =?utf-8?B?SS9NTEFIOEdLLzEzYUFTT3htREpPUU9hVUpvdHhCWWhJZ3QxY0txQW96TlMz?=
 =?utf-8?B?dXdKY3k4L0FOczE5Zmp1NVBGVytwKy9NcURiT3laS0xkbHRCQU92WjNFdGJK?=
 =?utf-8?B?a0JIL015SlRkVGlUMUpZTmo4ZEtkZ0NJdzMyUnpmdzI2cVJJbWJWSldlQU9z?=
 =?utf-8?B?emMvUEpHbzJGYWpNSDZyR2taVkhMRWlIaGJPcnNpSEFMazBXVUJIZFdEMWJB?=
 =?utf-8?B?TWRoNHl5VE5FbEI3em16aE0vOHpiSkxEZFpBMDBpWkxveGg0aTMxajc2a2xh?=
 =?utf-8?B?Y2o3ZDJ0S3RFSVg1TlA0eXNZV2xHT1I4aGtTcjRTNFFocVRkQmpySldVTXFF?=
 =?utf-8?B?citvSU9PcU9sZ0E0R3RqT1ZrVjR0U2Zta3JpYlZGaUtKSCtDSUoyZEN4MVh2?=
 =?utf-8?B?Tnh4VFM2OGIyTUcyYVRRZWQrNlk5L3hNSjhxSlhtcEJ1ME5TL3RvZkxQOEsy?=
 =?utf-8?B?aFpKTk1UaGxBNEk3dFFoQ1h3dS9PWlZIM21OVmNGV0tEZ3JzQy9IdHZOY2N1?=
 =?utf-8?B?TTU4eGtqOS9QbmdiZzlCcW1BbU9QTU5mSExab2lCYUhQVENDUXFZaXlDYWQ0?=
 =?utf-8?B?YVp6RDRWN25XYWliNGlOVmw1cVpyK0FqMWlnaVdTY25CVkFZOVk4c3FUT2ZT?=
 =?utf-8?B?VXgxNC9WdjRlaUJFcUVRaGVNZUZWSzdJQThBYWZXalUzaEdSemk5eDNmajlq?=
 =?utf-8?B?WmlMMkZ5Y1VxSHhCZmJwQ0JvUUZmUWZ2Mm81bXVST1lHQk5ydHFwTEl4WHVy?=
 =?utf-8?B?VlE4dXdUQzJVRU12RzhJQjAxZmhNVzZxbjFqd0dHeDRKdTI4THFzbzBqajM1?=
 =?utf-8?Q?20Bg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:06.5332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711bc148-397a-485f-974f-08de2838389c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Add a 'preserve_config' field in struct GPEXConfig and, if set, generate
the _DSM function #5 for preserving PCI boot configurations.

This will be used for SMMUv3 accel=on support in subsequent patch. When
SMMUv3 acceleration (accel=on) is enabled, QEMU exposes IORT Reserved
Memory Region (RMR) nodes to support MSI doorbell translations. As per
the Arm IORT specification, using IORT RMRs mandates the presence of
_DSM function #5 so that the OS retains the firmware-assigned PCI
configuration. Hence, this patch adds conditional support for generating
_DSM #5.

According to the ACPI Specification, Revision 6.6, Section 9.1.1 -
“_DSM (Device Specific Method)”,

"
If Function Index is zero, the return is a buffer containing one bit for
each function index, starting with zero. Bit 0 indicates whether there
is support for any functions other than function 0 for the specified
UUID and Revision ID. If set to zero, no functions are supported (other
than function zero) for the specified UUID and Revision ID. If set to
one, at least one additional function is supported. For all other bits
in the buffer, a bit is set to zero to indicate if that function index
is not supported for the specific UUID and Revision ID. (For example,
bit 1 set to 0 indicates that function index 1 is not supported for the
specific UUID and Revision ID.)
"

Please refer PCI Firmware Specification, Revision 3.3, Section 4.6.5 —
"_DSM for Preserving PCI Boot Configurations" for Function 5 of _DSM
method.

Also, while at it, move the byte_list declaration to the top of the
function for clarity.

At the moment, DSM generation is not yet enabled.

The resulting AML when preserve_config=true is:

    Method (_DSM, 4, NotSerialized)
        {
            If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d")))
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x21
                        })
                    }

                    If ((Arg2 == 0x05))
                    {
                        Return (Zero)
                    }
                }
         ...
      }

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
[Shameer: Removed possible duplicate _DSM creations]
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
Previously, QEMU reverted an attempt to enable DSM #5 because it caused a
regression,
https://lore.kernel.org/all/20210724185234.GA2265457@roeck-us.net/.

However, in this series, we enable it selectively, only when SMMUv3 is in
accelerator mode. The devices involved in the earlier regression are not
expected in accelerated SMMUv3 use cases.
---
 hw/pci-host/gpex-acpi.c    | 29 +++++++++++++++++++++++------
 include/hw/pci-host/gpex.h |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 4587baeb78..d9820f9b41 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -51,10 +51,11 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static Aml *build_pci_host_bridge_dsm_method(void)
+static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
 {
     Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
     Aml *UUID, *ifctx, *ifctx1, *buf;
+    uint8_t byte_list[1] = {0};
 
     /* PCI Firmware Specification 3.0
      * 4.6.1. _DSM for PCI Express Slot Information
@@ -64,10 +65,23 @@ static Aml *build_pci_host_bridge_dsm_method(void)
     UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
     ifctx = aml_if(aml_equal(aml_arg(0), UUID));
     ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    uint8_t byte_list[1] = {0};
+    if (preserve_config) {
+        /* support functions other than 0, specifically function 5 */
+        byte_list[0] = 0x21;
+    }
     buf = aml_buffer(1, byte_list);
     aml_append(ifctx1, aml_return(buf));
     aml_append(ifctx, ifctx1);
+    if (preserve_config) {
+        Aml *ifctx2 = aml_if(aml_equal(aml_arg(2), aml_int(5)));
+        /*
+         * 0 - The operating system must not ignore the PCI configuration that
+         *     firmware has done at boot time.
+         */
+        aml_append(ifctx2, aml_return(aml_int(0)));
+        aml_append(ifctx, ifctx2);
+    }
+
     aml_append(method, ifctx);
 
     byte_list[0] = 0;
@@ -77,12 +91,13 @@ static Aml *build_pci_host_bridge_dsm_method(void)
 }
 
 static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
-                                              bool enable_native_pcie_hotplug)
+                                              bool enable_native_pcie_hotplug,
+                                              bool preserve_config)
 {
     /* Declare an _OSC (OS Control Handoff) method */
     aml_append(dev,
                build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
-    aml_append(dev, build_pci_host_bridge_dsm_method());
+    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
 }
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
@@ -152,7 +167,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 build_cxl_osc_method(dev);
             } else {
                 /* pxb bridges do not have ACPI PCI Hot-plug enabled */
-                acpi_dsdt_add_host_bridge_methods(dev, true);
+                acpi_dsdt_add_host_bridge_methods(dev, true,
+                                                  cfg->preserve_config);
             }
 
             aml_append(scope, dev);
@@ -227,7 +243,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
+    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug,
+                                      cfg->preserve_config);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index feaf827474..7eea16e728 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -46,6 +46,7 @@ struct GPEXConfig {
     int         irq;
     PCIBus      *bus;
     bool        pci_native_hotplug;
+    bool        preserve_config;
 };
 
 typedef struct GPEXIrq GPEXIrq;
-- 
2.43.0


