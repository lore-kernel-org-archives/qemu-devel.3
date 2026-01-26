Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E046CF65DC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7s-0001hT-Sg; Mon, 26 Jan 2026 05:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7B-0000iT-Gq; Mon, 26 Jan 2026 05:46:37 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK79-0005fr-2N; Mon, 26 Jan 2026 05:46:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8GyN9Tfi4Z1gX17r8ASmWjz5/0zRtHihepYVh42tlyMaq2vPQoJ9BViWu0hidDzfoe1Yrwilp1owrRSFbeYj/XGFY+cPfPkjRT2WixImzFfiWzu+HEI+FhTO4OVMk0UtknNu5SRjwIDJmkA4pfFniCo3zb8GHKtzjf8NjX2b0lswNBVfZM2EgHELM9auOrFohMXpxuTQd9MPacJFMSWmGwqXoh4YL1uTn6kRB5NzAZuXLtiO96TXvhWkG60jw1ihjyT7YvI91AIMwOTGcd6YmGAAo2oI4/cgqVdSiDNZMJpGspU6YlK4HsyjaZdr1ZmGyas2rUWC/SWOm4/6wM+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S2YabeeZo3+GE/L5e9ZiNn70KgxEa2AlHPuQK2Ckfg=;
 b=jnfkcbqtJ9ZYJALOveSDQ6221ENHKVXIPVjQwKtWzrw2jReKnIY2nrOJPxMKDrtOZdhhNXz4jKAxLX7fKHYG0WidhbkDTccfAPpWQZng868wyJIrNQdms1NGGnQESAKgJePg0bLrQFPGvIuavgDXLzQzxB20uAV9UrF4oqbLp8sJqR/OoJN+61ueF9Ze8dpYmR2dwHh0+qe2wXW1lT6rWG8HcHS1DXNo4a5/BXm3FIiqYrmSSae4UaPffoHvzcMCAqTjlxnpMWz+4wKk9KhYt3yVxbriC20UBBkEp5wiqjWlAZUq1/LzwdZU9XYpd01qzGcX3eu42HrBYLmJXULCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S2YabeeZo3+GE/L5e9ZiNn70KgxEa2AlHPuQK2Ckfg=;
 b=mXRSaKdZJbM2kYtIy+4ANsJQcLqJUtRSfZyJp7zrl9Br5+1tpLM+UzoK/YtASJ+S1u4MhE+BBd/bHzHRc3nCEfLlMQ47HmaLyKSbSf1OfAKXt/kZ38PSJ/GtsP57xF4WRYhBaKu+4NS9T1GDQbJFW3SiZYaJWzHCmjg1oI3Kyatktv6Snz7XI2MWV4HST/Lx95pv5PTjQsGnoChu2z7D0K6ZuXAgp51LNMxDieMkUr4zT57WDbNnnq5QHrDryXa5az1ZwjPsZtW6AkBbWtdIY+aCksuwegQqCsxZ9dVVVvRcPI01z5GP2QMV4Hznaw7AdRJyQJWSR5Lfp2wKKd7fLg==
Received: from PH7P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::6)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:46:29 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::1d) by PH7P220CA0047.outlook.office365.com
 (2603:10b6:510:32b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:46:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:19 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
Subject: [PATCH v9 22/37] hw/pci-host/gpex: Allow to generate preserve boot
 config DSM #5
Date: Mon, 26 Jan 2026 10:43:19 +0000
Message-ID: <20260126104342.253965-23-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8707b570-7fc5-491c-e480-08de5cc82974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXhSVE9YMEovOTN3VXl1bWJlTUs1V2FxTWhtcHlwSVZJakxZaDdVdGtha1My?=
 =?utf-8?B?bkw1S09XdmFkOTJvdksrQ1FBN0Z5L2ErS2hnZnFyTXJnNzVxMDNhZnNWVWRi?=
 =?utf-8?B?K1BsQzFKOUdkdjYxUHl2Tm13dWhvVHk4KzM5VGs0bFF3SFM0NjRFMkRlbDRk?=
 =?utf-8?B?U3hYWHRzbEQ4S3RzN0VwVzZ0T1p2QmVDcVJ6OEQvYmtWR2tiNFBUQVQ1T25L?=
 =?utf-8?B?S09pM1RHbWJNR0Z1NE5JWldINStOcW15VXBFakRDdFYwNHN3VkpLeXpCUTVn?=
 =?utf-8?B?WmtQTDhoYkVlN2htUkpoc3hMZ05CQ2orODVjT09FQ0tmbzJoSXREREt1b2VB?=
 =?utf-8?B?bXJDL2x0aXpHeEdCTnpvYWNiNXhEajRtUVI3MUhSZGRrZnJZNmJja0xhY0hE?=
 =?utf-8?B?dTZTeGZrZEJaMEJuUXdYQ3VmM0VOdllQakx3bmVnendweDhwWHBubjN0RnVY?=
 =?utf-8?B?TDFTaG00ZndLS2I3UnZzZzhsS3NHY3dvUmRzSFc2ZzhtMzhpclpFMHdNSjVW?=
 =?utf-8?B?OUdYWU9mODVJWTYxM2lyMFN4TlViQjI0TElPeVBZb1hrWVlYVndMRWgzamhD?=
 =?utf-8?B?RHExODlpMHB3QzRlRmxrdkxUY1F5ZEV4VjBOQmFsQzRoTVBsaWkwTFRDVmw3?=
 =?utf-8?B?ZXkrUDl2UlZaSUg0aFhTeGJHQ1BTYnRoQkUzWWROWCtoWFprVk5mY1hQbXBp?=
 =?utf-8?B?bVlab3lWWWREZ2UvZms0QTFPSzhEMlRtc3QxekNUOG1iblVPeHJCdFErMmw3?=
 =?utf-8?B?OUZ6eHRtL1RSR1F6OEFDZXp4Q1BkekMydlJZRjlWN3hWV0VFY1ZvMTZmL2xL?=
 =?utf-8?B?THdyZnJIN0ZQUThjRzNVMVZyS0FxaHR2OXRTT0J2OUZXS0ZlZ1ZJcGF4RFNR?=
 =?utf-8?B?Vm54V0F1emVMejdxVjFLS3hhVUw0eGxRZThhZGNrYWZ1RnRKN0NHaE5ncE5S?=
 =?utf-8?B?WUdKSGViM09wNjFEc0pDOHN6b2ZJUU00dVU0Unl2ZC93VThxbXBQRHVMRG5y?=
 =?utf-8?B?dVVQSVN2YVkrbXFVWmF1Sm1wK3pBV3hFMzk5T1Q2eDg4TFJWWm5UbFZIMWcw?=
 =?utf-8?B?KzBWS0U0OGhwRXM0KzQ2VW1jMGZRWDVLenF6aTBmbDB6ZHJadFZ4b1g1Q0Q5?=
 =?utf-8?B?bDB6UkhrR045N3NIdXNwYVdCWWJPOVlBcHVPNHcxeTJQdURzQkpsdElIU2xZ?=
 =?utf-8?B?cWxsNlRWUGlYaU9FSFJPemVXeFhNQUwvZ3VOb0RWNVV1RzRRUmYzblBDV1lY?=
 =?utf-8?B?SjZkcWN0S0JxU2xkNUFxaWQxdmUrb0FaNElvbTRoZEZvdDZ6clRHYmNaQ3Zp?=
 =?utf-8?B?alJnOURBRytKSmN6MDQ5bzBYL1hyR1hoZWdoWlBYZUZka0pGTy9LYUdEaFBG?=
 =?utf-8?B?ZndqT1ZzR0s2cWdUOWU0YWxKNHBmdmEwMHllSnRDUWNBZGJPWGZOb3h1MXVv?=
 =?utf-8?B?bDZpVDhSZTJOeDlYWXhKT3NTSU0zZElDdDRpaCtoZzI0SHVOZWtqTHBhOGNr?=
 =?utf-8?B?SmRseVYxQ2dPRGJXcTlaaXM5a1BFZzV2aEVZSTBCUE53WUYrSVdNZnF3eWVy?=
 =?utf-8?B?c3ZyQnNkT1gvazFQcG1scU9GMTcrSXc4bjF3VDNhOVEvWHpVd1QzT1VsVGtO?=
 =?utf-8?B?YS9wU00vSnFuUjRCckdvaVEzMExZOWNWQm83UjdjdTQ5R1lvcGNtcmg3SzZw?=
 =?utf-8?B?blVLc0phQy9pbHFzVmxDOXFlMTFYLytZa0gyUHZVUTg4SExSbkc2Nmx3SjRk?=
 =?utf-8?B?SVJLQndDaGdUaU1IckliU0ZxVTdoVTNtY2VONzRqVTRYbFg5TlNoWjlzNDRX?=
 =?utf-8?B?V1czUkpDZCtHQUFTWWlUMEk1Vzg1dWJ1UTk3MHlmN0ZoRDdLZG92dG9MRVU1?=
 =?utf-8?B?Q2ZESU9OblluZEU4QVl0L3NUS1A3bkVXUW1RWkFoc3ZsMjV0LzJ2WjhrK3pQ?=
 =?utf-8?B?VDVQaW0xbzBBdm5KZjloV1UrcGhqRFNBVmtrcUJzUmw2U1EzRG9tbFZjSGRK?=
 =?utf-8?B?Ukc1RUphRDQzUmMwTjArVTlLMXRES2IxMGZEYW5iNDlOd2dRY3ZCVEx3T0ZN?=
 =?utf-8?B?Z1A4QVhUS2g2Z1JHVHoxUmVZWUJabXV3UUFjWE81SVppaUcxV0J3S0VFYVZH?=
 =?utf-8?B?K2ZHM05KUEVRdElud1Qvcm5mYzhySWw5OTBQdXYxNUdsdzAwdWZqMEJDVTNJ?=
 =?utf-8?B?dUVqRmM1emJSWlN0NkRCWDU5bzhaNll6OWJuMUF0TEUxYTVMeXFFSEdRYUhy?=
 =?utf-8?B?VFhLM1N6enZzY1pOaWhWb2YrODNnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:29.1656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8707b570-7fc5-491c-e480-08de5cc82974
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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


