Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC971CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmX-0006RV-Or; Fri, 31 Oct 2025 06:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmm9-0004oJ-D2; Fri, 31 Oct 2025 06:54:37 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmm3-00031G-8f; Fri, 31 Oct 2025 06:54:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHJ5jObU8DgS4UK1ybfW9KYCwMS1aAZse6CvzdjU/1/vD4DcH3OBHNbFKAZg0oQEo+EoAIgtiRaFMuhs8/SbMaIBNb4wGPV/kOl2Ybx5Xrcp6MyFjPi/6BxK0mlKEUfUQEM0kVy2+2to7e+uTC2I9zlnW0zL22Qz3J3La+MMiJjIVugskewDnEQH2mzT7sPVDtcoM4pSfqwLmDT9ip61ZO1+xpcsHwLkzEQs6czi1+lOHwblYOaAyllp8lRlUMNSCZBvFXl04FRlyqGmkidCy9zwnFAoQ7L+2L3qT6w5JZvVeTsP8v0c3iGpqtye+NfP5JS1uK3IbbdXHKWi4QfejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xx7t1bIM6tzdozXR3/ut9c9HKLMHGPRjcrZna1gvaM=;
 b=zQQSLnPPXXcmnBCFcM7xNjKsuBZiR/aZ2jDx0a6G8XvGqsWuvG/B04bN+U38DObHdFCPy0l5+M5AcoaUdSzaCKD8zwMgjdOvoSL4pzz+ijjDDpnInXfB0MIWqfJMYA46KFhigFSrHbpgyC/pQjTCWLTyENo6fZs+oITxk+Y3ZpQ3p7kBftm3LaK9cFuwoSeyu0tP8LxB1Qv4VnK8bQUXmrIew8V7cLJH7fHaZuJnYwd5+T5edEJa55V6xtC8l6RHo+uFRDTEetYlaECNeEetdtiRxJym4MwJGkFgzhkf6Bpf2cx92px1iFhbrE9lKdmtZA8T1iQXJDXQZFlUCDe/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xx7t1bIM6tzdozXR3/ut9c9HKLMHGPRjcrZna1gvaM=;
 b=WvK9wQw9c5tAKAP1hQENHREdt33hkRiB2pUbaulv6Q9SSrPNB/qQx/PIEwxG/LPCVzPU4+HfbSHN1LimoxTl8ZEa4ZXTuh9D2dAgDxlr837FBj12JM5wVN0FLj1VSgFWg9m7bALu1zRG5e6GksGkjoO7OI68pCRB3dB46S22AjCEKEZiPdFdCohiP92pYggtgcTEnCiCNDwMRQAaa9ILJR5sWFx1YhgPL/sCiWkHcGsEGBn6QAgAV1zPeN4FkPe1glNV2JGnm6rweNWCektk8WK4bdBXBwhhaQJhz1s0O9enyiE6VcmW1XqULBW5KZnONZSUHQsW2ALrLZicM2+TlQ==
Received: from MN2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:208:a8::33)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Fri, 31 Oct
 2025 10:54:17 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:a8:cafe::e1) by MN2PR12CA0020.outlook.office365.com
 (2603:10b6:208:a8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:54:07 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:03 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 20/32] hw/pci-host/gpex: Allow to generate preserve boot
 config DSM #5
Date: Fri, 31 Oct 2025 10:49:53 +0000
Message-ID: <20251031105005.24618-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a271f2-9182-4ab8-3243-08de186bd649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjhNSHdVYU1VR1Fkb3dEdldOTzlaMUpQMnV2UDBZNFovQUJRNnVla3dmUndG?=
 =?utf-8?B?Vld1c0xMbkRNSWFuemcrV1NPZnBoNzZKQzJhWHNJZWcyS29tTTMvblNsalFy?=
 =?utf-8?B?azc5ZDlJU1VjclowTU1uYVVUbnFabEoxM3d3QmZHeHJGeVpud2xJNjF4NjNh?=
 =?utf-8?B?a3NlN0IwdzY5a296a3FtV08zY1dlZHBWY2FjcWtITDJ1ZDZvbWliWXNEOWND?=
 =?utf-8?B?UnFZNjFqRzRwSzdUZTVqT1lXTGRxdWRlbWtLcmVkZTNqQUFIYUo0aXYxeTg1?=
 =?utf-8?B?SVB5Tm00R1hYaW8wTXd0d0VNTUZMK1haWTdQMndYS1hSblFQcGplZUtBTlJH?=
 =?utf-8?B?d2N6NUV0ai9pcVhVdHhKQUU4MXQ1cy9yNUdtRFhIQkJQR3hBUXRmeHZTYm5F?=
 =?utf-8?B?M1VIN3oyNlJpOUwvKzJVQzlUeU5UNmdmMHpacVV1Mm5icXhBOCtPelhjQ28z?=
 =?utf-8?B?bGhNaEtYUkcyN2NYS2V2UldKMWJxUjJaeHRwQjBzSVp2eW5VclNvSjdCa2wz?=
 =?utf-8?B?RjZGRi9KRzNQMzhRZGl2ZWRtRFIwc3dyZktXSVRmamtRUDVxaEx3bldKU0tH?=
 =?utf-8?B?QnBvUk9LWExjM2EwWFJ5OWJEeGlmek5WaE5tVCtZZjcrdXY5OFZaYVNCd1Q0?=
 =?utf-8?B?ZDNqK1dUeFlZUmMya0ZNV2gra0FZSTVJMG1jZHFXRjdSS1ZsOEwvVjJ3SjlL?=
 =?utf-8?B?TmdJQy9MTGthbWV5aFNjOXNubG05WFNCdVJFckNoMXpSVXR6Z0RxZjZ5RG12?=
 =?utf-8?B?Z3FoSG5Fcml4L01qTjkxT2p3NWRUZ0RMZHZaSmZlZXRjM3ZOYlM0enFva01a?=
 =?utf-8?B?S1R0NDVUOUZ0YUV2VDE3Q054TlQvS3YrbllnUmx4dTduMEYwNXdITjV3TWJr?=
 =?utf-8?B?U1JTZ0NIVWhMckFUOG1NRFhyaGVhN1NOVHFCMHpkSFBrRzNGN2ZkUmdNa3hR?=
 =?utf-8?B?bjZFNlF3L0FGUHM3c0hZUVRSNWRtT1VNNmR2dGNCMW1rTEpHcjhTZEpUUXBJ?=
 =?utf-8?B?dkFVcjQybWNEN0Q5dVE3alpMdVlwUVFXSkgxWHlpM2VhY1Y1QkRRRDdsdHNI?=
 =?utf-8?B?UjM0cXJRelhCc0pwK1BINTNkMFhYRHRVU2I2bFFBSDNkakpPclpPUlNhVkpZ?=
 =?utf-8?B?dGg0Y3hlZHAyeUNBTGQvOUxqMi85UFczRTJmSWcxRWMwQ3Uya0hnc3lRL0lt?=
 =?utf-8?B?Tnlnc0hubTU3c2JPZEhrQnBxMjdVaVhaQjFtZnUyZEErUm50TEFDekFBdFJm?=
 =?utf-8?B?SDRZQzJBSjdqTUREZS9vWGtMY21Ua2NnR3VueHRaWnJoc0JCalNXM1Rld2RD?=
 =?utf-8?B?S2pZRFhJREVnVWhic1lDZ0d0akVzZ1ZGRFZ6d2xwTFN5K2dhYm9CZzlkVitv?=
 =?utf-8?B?aTBhaTdrTVhBQnpFSENBejYxUU1EM3p4NnE4d3NBZjk0Z1hSRnVVS2FlUkEr?=
 =?utf-8?B?ZWJkcW5WRkNvdVQ1QjlnSUpEMFhlOG55OUpGakhTZ0FZT015eTlQRWthTllH?=
 =?utf-8?B?YTh6NzRLaVNYcUg1dVhGVEFGWUthaXBmUG1JVmp1M2ZaRk1DVVphWjJRTkZH?=
 =?utf-8?B?YStLQUdBRzhCWXEzM0VYOG5nUkxteEVhQW94WEJqN0ZkeEJlM1JDTXhjTFNK?=
 =?utf-8?B?VnhiYzRHVUxXTkp2WlRkWWJRQnRkZzNNYjV4OGFhVDRFdmdiVjMzbkNqeE50?=
 =?utf-8?B?MTR0aG9qM1dHMjdKUHc1ZTQrd3MwKytxZDluQlFuc3gxYXFiazg0VS9kS2pR?=
 =?utf-8?B?SW9GLytOeWxLVmhLRDJsN3E5Vk80ZmR3UzFoMThZVDcyVzVvclFDTFhNNjBs?=
 =?utf-8?B?ZVpZSk9hRVM1MTBYZnJDamZPZ0ltVEhvSnZ2c1JKOTQ2ZmNRQjdZQkJvMUZP?=
 =?utf-8?B?Qjg0OTQySDdEWGVDS21nS1RuRFFmRGZ0VUVKb2crUE0xVEI2RlpJdkp5dkd0?=
 =?utf-8?B?dlRJa3VZUDhTbjNIU1NwZm1VVllvN3FsUGwvcUhMYkl3cEpRTzkxcXpVSmJj?=
 =?utf-8?B?akpaVURhaklzcEpBS1RNWWpXY1ZyUGxWVis5WmVIYzlsNjl5bFBqVUVoVURY?=
 =?utf-8?B?QXMzU2F6d2IxQk8wSjhOREtnb3BERVlvZVJIdVRYdFpDNFZHWXJkWGFSbkRq?=
 =?utf-8?Q?YLNM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:16.7083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a271f2-9182-4ab8-3243-08de186bd649
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


