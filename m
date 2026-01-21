Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067B1C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicSd-0006Nc-Nv; Wed, 21 Jan 2026 12:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSM-0005hB-Us; Wed, 21 Jan 2026 12:57:26 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSK-00022I-KC; Wed, 21 Jan 2026 12:57:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXKiTla62kvT1fzFQULHta95N+We/C8cfSSoDxOT7K8745pD3rdsMXATLcSSaCtYk46PTwqmplrHPz1WvvLl+a+SSkUGv7m5M1+nJMFmZNCiVhOr4pAXvjAE8R864YUUCX5zcoY4nzaUIBWyo+G1w5F178pSDeV6XoIjF8iIwxonrwXtaKoGMr3wJ7cT0O/89IBVmn6GAJ4SK0/QZz1faN83bTeyQ4Kg7GGDUjJwRWZUBeI5QrRirasGFp5ExOJAMwSYOfFveymvln+vHQTH8bxkZoBiysYYVNt5Gdko5hasSnjPJseue7VYXUOdHPbdjOAGXb+By0kGFwFbUiHwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S2YabeeZo3+GE/L5e9ZiNn70KgxEa2AlHPuQK2Ckfg=;
 b=SditZegvdKtwN4RDApS9BltxNzk/XjgT5SiygkCgmxZVZDDZE5tPACtj70U0iS7719ktDjyg8azQVklexeU74iF1//E95QWYUF0ptP8z0/EYIZBo1AbVd2dMQ0HIDvNBmsiF1UKcy88nGJy7hukAxUX5Ct1UyVGijIukTgb9XhFPkZO0WkCk5EFuGyzbpARbIMGwGom4J94ohkyiucAs24L/L4Bw7nyR4Iu1ymU/fpABZstn2g8TnYC6n29HAg+SqzIkXMXItd/Pp2aI45RgydPmdmbRQYMj+L/EOfIPpPO5EFTMiJAuIjTV6MOgvFtPh07dY7JpmZVHNGeifvxhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S2YabeeZo3+GE/L5e9ZiNn70KgxEa2AlHPuQK2Ckfg=;
 b=nB7Lk3etm8g8l61fo2B8yv/Nj2RYwo6SsoIwAQygVcEUaVlW3O2mVo36W9c5AVg6wfXxMLKRz0f6avWpNfF8gBxxvZ5ZueLvkMmvHn7qYgVdxhqn42Bx4h9YUurecp9u+/54Hugt1EX4eS9JkumWO2YCDnnBs/qubTHIr4KS/kWK12C7ko+11ZjJNQXT51OrymNiZY9IYxUECzzBh4WL2zW+umagoehrJb1oTU6Q01TcNuCJRAnnAQLBBkRalvRv77QS0Y8n7zE7jNlWxyew+Pktvek2krq9ag4ed8TykDOqLsV9dE/ZqDHLhlliuZRM4BWN17HbUjIDSjaJlGoL+Q==
Received: from BN9PR03CA0531.namprd03.prod.outlook.com (2603:10b6:408:131::26)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:57:18 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::b5) by BN9PR03CA0531.outlook.office365.com
 (2603:10b6:408:131::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 17:57:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:52 -0800
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
Subject: [PATCH v8 22/37] hw/pci-host/gpex: Allow to generate preserve boot
 config DSM #5
Date: Wed, 21 Jan 2026 17:52:27 +0000
Message-ID: <20260121175248.87649-23-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6a9954-b137-4639-9579-08de5916846f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGNrdHZobFhScCtTbmJtSkZwVkJMb1ExbU9PVDVjcmVpUHhKeWF5NWJLK0xF?=
 =?utf-8?B?RDVHR1pkUzN4dmxFT3BaNk9nR2prWkdPeTNUQWM4ak15WW5jTG05QlZ0N2lR?=
 =?utf-8?B?S1V4TG9LS2w5TG9zNnhZUXFQb1ozd0I0cEh2YlFCdng1RitQN3prTjNnYXRP?=
 =?utf-8?B?UXc3VnlmRlZHZDFGck5XS0VEWDIvM1lZM0MyOGo5ck13YzQ0MVJrTFpEMHdu?=
 =?utf-8?B?cVE4cWNHd20zM3VQSVB0S24xd2hFdlNLdm1lZEExbnlwaWhPeGxRM1lpbjI0?=
 =?utf-8?B?YktCZkFJZHJDRUJVQlAyUXBxeXU1QjhPV2QvcE5mOHpDcHpsZ1pHYVdxUmF1?=
 =?utf-8?B?Rm5udlg2OVY3Sm41RzhXRnZiNmtMNlZ2RkNRbVRZVFA0Q0YzcFFlTzlvSkda?=
 =?utf-8?B?YUhacUVuOUVQYkNGSmVJTXBxMjZsQ3NWVFJnaWI0ODdoVE43TzhmbkR3WnRW?=
 =?utf-8?B?WGFBTnpiVTFVTG8xMUo3MHorcTI5S2JLUEtBT1RrT2tvcTFhZGV0RDRxSnd0?=
 =?utf-8?B?SXpqM0o4U2Zsd0dKNUJjTFJ0dzNQZ0duWElSZ2tQMjI2eXZhRXFLS21wbmpY?=
 =?utf-8?B?Umt6M0lvRmRPVExOWEMyeEQ4ZkJDVktKZ2psbWMzbldtem9PYkRXUzVmclhK?=
 =?utf-8?B?aStsWURhL3EzcEIxV1QxOXZpNzdjRWR0S2s1d2pBaE5IVU81RUdtM0l0OTQ3?=
 =?utf-8?B?UExGckpuOHorUGpVbm95R3VPc1BKYzNBTm83TDhrellBZWh1V2MxRXNUZmQ1?=
 =?utf-8?B?OGRsY0hHV1A4MDdid0lyVW8vSTdZOGNhTlduRmJheUZvT3NpUy9IUzJIdFV2?=
 =?utf-8?B?QVNBc09lNG9sVEZXdnNrY2tGWkNPNGYySEx3YW03NE54NUs2UTVlN09aR0FJ?=
 =?utf-8?B?OFdmMEdmUThwYkQxcFpuejFhUWFXK1kzNlV3b1lOdVJuL3poeW5KVmVDdnFa?=
 =?utf-8?B?T1FZdGdCUER3UnVQUk9MbktNLzZ0ejV5bUQ2WlZlb1IwaGxkZG83bXp6T2lC?=
 =?utf-8?B?TEZPT2xaMjlCSFFEMm4rbGtENXdlLzQxNS9tSmdhaFdMcW5Bc1R4L0Q4cWlu?=
 =?utf-8?B?WUVKSXlNYVROcVZtQkVrN0FuWnZZM1dwMlQ0bkdjL2FuaDYvaURwYXpXS2Fa?=
 =?utf-8?B?OVpPeDlXZTVjSDJOdUtqMmNrUlpROGQ5UHpKU2ZLb2tzSTRVN1E4RjlDeFNW?=
 =?utf-8?B?ZnBsMWNLanF3bXZUMHhoakNmV1RYU1ZhayswUWZQa1JpcjhMSllXTG5qdjho?=
 =?utf-8?B?dWlaSHJCMkRocUhaL1NqU1pxZStGVkhWRWN2SExVc2ZIL3NDcWhnWVpCQ1Zx?=
 =?utf-8?B?SjRtY0dBQ1lLTjNEem8xNW5UNHlta3AybUVjbytDaHppRTNmUEJDTzBYeC9E?=
 =?utf-8?B?MHpIK1N6ZFFKSjdweHBTTzFZTUtGYXk0a3UwaUdSdmgwMDBsNmFZUXBVNEVu?=
 =?utf-8?B?YThyQTBmbTljV0FCVTZGMWRxTFdCd08rOXpvU25VcWdSVEZrS1pFOVdWWFhs?=
 =?utf-8?B?NDZ4dERrSGVWVFhGa0RjMm1DYnVsMW5CMzcwV2dZVzJJY1BSVlFzbk9NblZh?=
 =?utf-8?B?eGhMSitobWxRbXdhSmFoR0MrWHIvSXJES2U4NUdFTjRXWG1KczZ4Y3hBbVQz?=
 =?utf-8?B?ZURYQUEyZmVSYlF1NVdrZG1nN1FRMVMvVE1lemtGMmdYQ0t2MHRjeW1JQkJm?=
 =?utf-8?B?QlZRMUh2SWZ0cHZSaG13UnEzSmpYRmtpUmx4ZWRJc0RtdEZMeFZ4U1RWd3l5?=
 =?utf-8?B?Ykx2RndpaGpLOGtrZVc1eDVpOXhXMWRjWmNJMWR0ZWxaaTJCYnJSUGdxbzJW?=
 =?utf-8?B?R21tK0VPRHdNQ1lnVTc4dEd4eU5pUVlPaGcyditNeXhaYmpyVFZuVThLUUNy?=
 =?utf-8?B?bkRzSXltZGFjYlkwNjl3OEZqUmFTNEYvL3lqSGJVWXBZQ3JUQVV5M0dIaVgv?=
 =?utf-8?B?TVQ2QlBrdWVlN0FOcWhSQ2RtbGVGd2pJOXZVUXd5OTZBbjFabUdiNjJyWTQv?=
 =?utf-8?B?bkZGZ1JyallYQ0srWWZrTXBmYkFJcE9hMkc3RVlkN2pHUldGaDhIOGlIOG5K?=
 =?utf-8?B?WHdHcTFRb0FhQlVTd21sbHQyTVhoNmU2TldNZHZuSzJPMWFEVW5SSlpQUzMv?=
 =?utf-8?B?RG00Y3I4QnBBRDNHd0Z4a0RIN05BdCtDT0tuNjZVSElKYy8zT0RHT0hZa2ZH?=
 =?utf-8?B?ci95ZGFTQ3NYRU8zSE9tRy9JSHB1TVp3MjNRZUViT3d5WFloaDZoSDRVMjFh?=
 =?utf-8?B?OVZyWkdhOEJrcTVyR1F2K3oyTFd3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:17.7483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6a9954-b137-4639-9579-08de5916846f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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


