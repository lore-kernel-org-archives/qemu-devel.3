Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812CDD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ZY-0001dw-FI; Sun, 11 Jan 2026 14:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ZN-0001PJ-NX; Sun, 11 Jan 2026 14:57:49 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ZL-00045o-R5; Sun, 11 Jan 2026 14:57:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOG36lZrVXqUd1LDBfiadU0pq60k6HhaEg5gN4erlCL7M3PTJOKt8gzlC+PgIIga6pwApF7I4ioQs8YzHS7PDnIi95zZ5Ju3YwHyoVAJ1Wv0z6xDTXUxTW/dX258dWbFJWBDfSX5zEOu/ISZTCIn306ayWJVjt95GPBM4A90ls1iPzsfuBpkhokrAojDy8iq5ZaP8M+286vjVopnqBIMQYk3QhlJpnopoZdAVpaVVC3ciT5ln35FRW3FHMzFnd6TJDZn+ArKtyAr0oXzVhIuBkzWGhCwHgeNnJqVgRDjiHUe7TWDOQe1ZFwGyhYEz+WM8uYMcr66RnBXmBOVAd1Ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0KWJXP2hcQhI7FugoOTlBQpxzQ5ZU6oUNqLjlVCCmA=;
 b=aQ8QE+ARg/loYCVFIrOmGsfxznODfm7MrbXIxD6Kw7GI7+i0Aous48BUlUa1RT1qyqR2fm/V1R1DAvcYTAlDtu9aO4jPqDTRduyKHIb8HtkQpYuPqkHIRD0GUtX2ytEpq2RBOPEhvxr+pj1wm9lmGux98EKvH8HyROO+L+i545DBqEQXWZlx5g8oXD4yNtVxX/qG+okpnQ+BN6Gb/1uyMDfhRXwV4vFz2cCyipZj0QJs18P0JUiVj/KfjCsqMpz8pFVh7tH6kiwNqxa+W/ulUgTQokEHtKFKQJGj1woBB6j3vdSlT2YZhiptQcZm1r5RYLU7rVja/2HsbH+29ua5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0KWJXP2hcQhI7FugoOTlBQpxzQ5ZU6oUNqLjlVCCmA=;
 b=IaIoqFy4E0ItgqFPr1D5PFIbxl6wCcP2KoVG+zak2szL42oyzg1znfAb1lNbZq9k2SuGPO/u3eW8Uhvh/yKcPEUgNE0hMJcthS+axK/dvDpyTbPxcSDIy4x8cJBBjK7QVreIidUBg4YcaC9+ysdtC9+aBVWrAsQKEydIm+Rw2SuGedzVnhL7NOUgGeprD5V9Lq9Der0QQ6JleLP5SSUjEg07eztP1yzXqe9J9gki3E203ee9RQNhTMUz9I3zfCGRHX88AvwPnSGKYS37aybCflEdECmymOAViDjQBK01DCE+ZQGy+tT0YbS0H5TyW8OHC/DDkZ2eBO41K298sd5yeg==
Received: from SN7PR04CA0022.namprd04.prod.outlook.com (2603:10b6:806:f2::27)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:41 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::2e) by SN7PR04CA0022.outlook.office365.com
 (2603:10b6:806:f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:31 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 21/36] hw/pci-host/gpex: Allow to generate preserve boot
 config DSM #5
Date: Sun, 11 Jan 2026 19:53:07 +0000
Message-ID: <20260111195508.106943-22-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 575bbfba-18ef-4287-75e6-08de514baddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0RLcmw3ZVVWd21RY3lEMENCOTVMZTdkUURRWVBiZ2pQREIzSnZTc2ZQY3Bw?=
 =?utf-8?B?ZzR0UEwvNTVEbzVpZGw0cXNlenZjUndiRmhIWUQvVTZ3M0R1V0F5bDlDc21s?=
 =?utf-8?B?VFBEeDZ5YVVZR0JsRlNyQXhENGcwNE9pbldndWg1V21COXgxL0VPdGxRMTUy?=
 =?utf-8?B?bVpubmtiMjFZZXBoZFlES25xcnU2eHdadUY5V2FqUWNDeUNSNEJqNnRKUEIx?=
 =?utf-8?B?N09MbHNvMmdaalY0MmRmWndxSXBRclpFa2RERHR6eHRVa09teTM3YUNzZXJn?=
 =?utf-8?B?YkVucDlUc3ZRaUpGaDZrRmJRMEZEdTYybmcwK3JleTZ3cVBuMm1rSGJETUhC?=
 =?utf-8?B?U05LdGtBazZQRGthcllFamdwYXRIMGU5cFFhbENtY2c4bWdkeEp3QUlVTTJV?=
 =?utf-8?B?QUNQNmdsbW4ySzJhMVZXOFhCT0dESVdKTW9lYXFKUjZ0dnJhbWt0Qjg3bC90?=
 =?utf-8?B?eDd1YWVjNVQvSkRhWVRocTI4M1RvU2RKMnpiY0l2dXJFWlFpQkRkWkVSTkNm?=
 =?utf-8?B?Yko4cldoS3MwNVJRaGFWVUpGOGJ0WmdCclZZNVU5cDBucHhGL1B3WTdyUUVV?=
 =?utf-8?B?N3dpUUxZb1J4b3QzeXdsdVk3NU1ZaVdlNEJJNUVESHlJNW9ZSytHaTgyS1ZY?=
 =?utf-8?B?LzJqT1l0RnlITDJKZStVWEx6UGFneTBuVkhxWjdjTUI4K2pzT3ZSTEY3dUUz?=
 =?utf-8?B?TDd3czFwYm5CVzMvZE1SRGNaMGpzVW1CY3RrdHJydVQwbEVKQndjcTAvOVR5?=
 =?utf-8?B?bnBFb3Bxa3dpTmlJYWJsZzNTUmJZWk5neFdnM255M1hLcE10WSt1WnhhYUpu?=
 =?utf-8?B?cDVUZUw2VU80OW5OS2ZDRDJPS25HTGk4a3JUU3ZUTFBGSjJHUnVlN0xXNmk5?=
 =?utf-8?B?UG9CaEpkMjZ5TTl1NG1qS3dXU25YVVMveVlyYmhGRjNoZDZScHJxa3IySUU5?=
 =?utf-8?B?M0wzaFVMVUpxemZ5c09SdFY2SVU2Y2RyMGNCNDkvcXh6SmY1cXlwejdwNnpD?=
 =?utf-8?B?MW9zS08ybkg2MHB2cW50VklFdVJOODdMMEJISjRzUDV4Z2MzbUhZdSt0UGhJ?=
 =?utf-8?B?M0xESFlTWTFQZDZGcUZUVEJrZW5vZGVjK0JFTWtJc25OenJXTDhjR05nVTR5?=
 =?utf-8?B?eVZOOVVPN01YcHFheWFRaXhScW40ODNJYjZsdnhrVXROdHNteEM1VVpLaVQz?=
 =?utf-8?B?VEorRk1OVTdxUFRaYm14WjZPWGxLS0pYQ1pTeFdkcm5JYy83aC92My92TGVi?=
 =?utf-8?B?Y1pOM3dTOHVUYWV6T2hSdUI0Ky9uWE15TjB1cnhyWkxlYWk0SlBxd2dycFNl?=
 =?utf-8?B?QnpGYXZOR0hxMyszK0hOK1JsZnZwb296WHB0c0xndXBPd3FYOE1HTVZxK1dW?=
 =?utf-8?B?QWtrRlFMZE05aFRIYzE5QS9WM201d2FiR2taaXNSV25MYk9IUmh4NlFCUDEv?=
 =?utf-8?B?ZFEwSkV5L1dwdGZMRVZWLzRqb3MwUE5QdlBZY0JWMEd4NWs5LzdidGxyWGRq?=
 =?utf-8?B?YUdpOUlPbFlibXNCdWVsWmFvR01HK2VrRENTZDNEUzFXd1hvZ21tc0I0a0Vl?=
 =?utf-8?B?ajdRcTNsWjdXVVNIenh4SkNNZ3RMVVpXTWdQSHNaT0Z4NTQvU2dqOXJaa0Rs?=
 =?utf-8?B?cHBZOFhPMGJOWEtEcXIvTTdHaU9RdWU1QUxsNE9vM3FrcUltVXRRR3ZtVCtD?=
 =?utf-8?B?QkNqNEpaMHNaUWJzRDdkR1ZzZCtYcllIelI3YW1kY1N2Tm1rRS9OSWcvVGhX?=
 =?utf-8?B?bGcxaWNtZU1MczhuRmhPaWJQREliMXZCOFFxbGwxcndEU1NMUFc2c0pmNFNr?=
 =?utf-8?B?RlNIR05mMktNNlF4aFpoTXBDWG1QVHFYZFRTM0dVcEJRWllmWjBINWg4aUVq?=
 =?utf-8?B?Z2JEZlVnVFdPYnVES1pwZGdmL2ZJWWFUOHU0L1pxWnhqM2k0ZlFDTTJTc3Na?=
 =?utf-8?B?QUoySEN2c3p6NE1ZRUdSNkRBUTNycVIxSjl2T1dOQy8xZGNBZ2hwVHZ3UEVC?=
 =?utf-8?B?Z0oyaWxORiszQUpBMkpzVksrU0k4NlY5OE1iUWtmYnpZNWxRbklhNTRSRmlp?=
 =?utf-8?B?U1dGczRvblNXa2hKbVg4UzVabVVtSXliV1F2WHMxbUdBWVFRendnSDVGUzc1?=
 =?utf-8?Q?TZMA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:41.3792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575bbfba-18ef-4287-75e6-08de514baddf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
index 695886dedd..1da9c85bce 100644
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


