Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3BCCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTyq-0002k7-T3; Wed, 22 Oct 2025 04:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBTym-0002jd-Dj
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:13:57 -0400
Received: from mail-westus3azon11011054.outbound.protection.outlook.com
 ([40.107.208.54] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBTyi-0002kQ-Ns
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:13:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1mvce93ZFqNhRwbAOzsaHev8QX1608kqgj5AGgbgbi8fuQh6hTH3RuQZeiNx0FP9vgq5jHGin6uAS/tFIjuaFGmvbyIatuVgd75RCBQMwxh+kKVKMXbHhS+yfMvqvKMTRTDwp6Rn86nGEhxKNfnNV1I5OXx/yV//bZ7mXw4RenwLOfDmXNWFgdDun1PRmQ3xhRw/Pj49EgjcaeTnqNFUQYRaW5w+rgL4/4UvMzPmR7FOF9jCLLCNjj7RMqKMz/0nIMr8Mv2+64c/28RiC2nLTaiTziaWTWI5WYAGrsPVuODgzq8pdMWCZYpV1lxmfC+Nw2wPUP+RpKft6GjrNVuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7tzOQravkjJlNWi03wt0jDdrkilIc7VTWH8MCWf0+M=;
 b=a9rt3Djy1v7LsEkNLFjRSWJVQJlvHMYTTey0/XihYdFsKnIWO9/4r8YM8GLCzIMCEW088RKFX2HsouW+gyKlja3WePs86BQNPvxWj9MGeGkMjXvrvQlXndb+FishvE+2HhGxUa8kZEuyl1tC3vXli8uYPtbvXHduJwYo6YEtcT9A8QONh1G7bnFY1CZDFYVF9WEGe+kaoUSa3Mvsv1y9eybafgbtOZ0VKLE1TxjgUrQSglTHQ9qdBlA1B5okNix+G56Z40bcnmOItJoBtj3mBfBSBDGuiKPx4SjgW8cOYNrPBQB3XXgkZHdoBfrWyv9S3j1O9n2nCYVfagiTH1IwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7tzOQravkjJlNWi03wt0jDdrkilIc7VTWH8MCWf0+M=;
 b=GUrv2XX6ckwfpoFNng+aR2RxgOwKLvhqIX7rAjZ8AHNlYq3ySAzYsfCZufJ9D4HdIJcDd+OxQndv+M+Jv1eRD7wS5OcyufvJwRxLGuypEHldrE8kG3SbND4asvIyGeUsYa3BiHTkXplm2MWkjTIYp7d1j5bIpzbDo3yH5r4Y3L8QV0sVgU9C0cckXIr+wbpGEDC8XEWZv7X/b7c1KjcOEJwsMNw/m/x2Z7yc9M4QboUHoF5I3utv8288M2x1sZf9I1wZ75hFQXfXiFemFlB1lqgpzH1AGW+ati4I+NAaXGDKZnEiNF0W6HLK0Z8Yy8JN1L1nz4bxYYoU/9Onwpe2aw==
Received: from MN2PR22CA0030.namprd22.prod.outlook.com (2603:10b6:208:238::35)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 08:08:45 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::e9) by MN2PR22CA0030.outlook.office365.com
 (2603:10b6:208:238::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 08:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 08:08:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 01:08:25 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 01:08:23 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <imammedo@redhat.com>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH 0/3] hw/pci-host/gpex-acpi: Fix _DSM function 0 support and
 update BIOS table tests 
Date: Wed, 22 Oct 2025 09:06:36 +0100
Message-ID: <20251022080639.243965-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ceed1c0-c401-4791-d30b-08de114238af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVMvQmxCdXEwM2x0MWJ1ekN0aVJSMWZkVTV1WGdPUGVURzIzL3BQZHBmd3Bi?=
 =?utf-8?B?YVNrZDA3dWFNMWNnR1lzdmt4dS96cVR6KzRuSVpuREZYZHdxblRRN3lPZXZh?=
 =?utf-8?B?andBcWZkd1kxK3RUNkNaK3U5NE9xQW9xQkg0N1hDNE9QQXBNdmN5eS9ZTDla?=
 =?utf-8?B?YW9uU01BL2gwUWYzd3lHeEtwUk96WjExSWJQMzdsWEpWeFNaM1VnKzZXSU8v?=
 =?utf-8?B?d2syZ3lqU0lINmc5M29YS2d1NFFqZmRuSEJrU1FETU1RZWhxVFJ0M3UwZSs5?=
 =?utf-8?B?a1Qxc1k3SnFINjRMZ1c2Y2JoeGZJVzJFVlIrbWx6dXZrMWduTUQwK05sMkN6?=
 =?utf-8?B?TmxzNVFld3RwTEVOUkIreWZYdmNuYkJSQ21iUTg1aTRGbmVuNytCc2pleEtU?=
 =?utf-8?B?RU9TcDVjOXdVYXlRTENDaEdUZlBYd3NUQi9FV2R1WC93R1YrVkZRaEluUy93?=
 =?utf-8?B?ZzU5bnBKSFFHTFl2WUlBS0NUaU96VzM5WGlxRmFVZjhnSGlnaGJzVm9LYmZJ?=
 =?utf-8?B?QTZjVC9INFJIenVZZjNyOFNTeFFvOWZjQ3o5VjFlbHpka00yZ2dKV2gyTnlp?=
 =?utf-8?B?U0ljMHB0SnFoY3VpT3Vkb3lISldMYmU4bHQ1ZEVGV2ovOUllTEFaMFVmUkJv?=
 =?utf-8?B?dlpPc3A4R2wrZzQwL3djcGdUbXFnRDBncmpjVXJHSXVjUEVlZm9MUlRvb0Yr?=
 =?utf-8?B?V1NzTnF3ZWYremthNHdKeEZxTUd6MFpMV3JOZTNma0lWdStjUFpEejJQMlBy?=
 =?utf-8?B?WUtMdTU2a3BKdDl0NnRrZkdZZE5kV1lKWisrVE9xUDVMc1VncFpBcnVBVDd1?=
 =?utf-8?B?ajhuZWczbnVwTGFrYk9BOXJURDlVdk1UUzloQWl1Y0VIUEZXL1pFSDhnd0Fk?=
 =?utf-8?B?TDZTWWxoVGVTREVtbkFDN3FMeTFBYVg3Mm5tUFZXeFI2MXZEM3hsOThVbTkr?=
 =?utf-8?B?ZTYybUh6SDhKbEdhdWVWSklYQWFCSDlWK0RPcWxRbm1sd3FuTUZTNDAvRnNy?=
 =?utf-8?B?bStZNVJMdjhTYlJrdnc3UFJtem1zNFZ5WG1lUnVXNTN4TkRVaXVucHFpb1JZ?=
 =?utf-8?B?WUQzN2RFVk9mdlhpWmRxV1Y4bXYzUXp6K0lVMG9LQUQzNmR2Zll5RnpZRnZY?=
 =?utf-8?B?SEJzZ2JDQjIxY1JvOXYvVlJkRUU5Y0pKT1BCMVRhMU9iOUtFaW5TNVdSekZD?=
 =?utf-8?B?TFp3a21SZWFQRkJmRFpweVFrMjZMNTFIcVIvZ0dLOStaWVdjWllQeFJsK1pM?=
 =?utf-8?B?KzAxeTFPYWFIdUpPNjI0MVlFamhPSDQyQWVjRjlOUk1Ha2J4dERtMGcrZUV3?=
 =?utf-8?B?VEEyNGx5R2JtdFh1cE5LSWYyS0RMTWFYR0hxNEsyL0RoVGlJOTkraFZrRHdj?=
 =?utf-8?B?K1pRcmV6Rk1mT2Y5d25BdWc4Y2tRQ0dzbGxZRG1SNGN5REtHUlUxZmd6Nk1x?=
 =?utf-8?B?RmZCNHR2VHRDcG1vWW1QQ05mcHVsdVBscWx0Umg0TDlCd0JyNE4wY296bTJy?=
 =?utf-8?B?KzJXWklPbEtyREhuMXhVdW5CajRlcHFUNjZWZ3JvZHJ6a2xLS21oZkd0dzha?=
 =?utf-8?B?QzJ0TnNvaFpQcW8ySGF1cTBqK0FJaG4zOXFoOWNuOE5pOC9uamM2Y21wUUV1?=
 =?utf-8?B?ZHRBWGJZZVNsT2tITlBaQ2ZVVlZTZ1NDcTdqTi94QUZhQ0ozWjR0R0h5Y2xK?=
 =?utf-8?B?ZXYveGNEa2ErY2hhajc4RGwweERSVmx1ZFF4aWdicGhTem5OVlV4QktqVTg0?=
 =?utf-8?B?RTlXRldpMEJRMUVlbnpQM3pBWDBHeFM3STFGckZnN2NDQXU0L1prQ3RjQnRG?=
 =?utf-8?B?bXdWSlRuRitXZzVqbThCVGs3enhNMTNZbkJDaTJuajBvZUp2Sk5PTUEvM29H?=
 =?utf-8?B?bHVXMzUyNTJNK0hFaUkvM1U4UlRhbS9mNFBPa0pINnBlOGNKQ0Q2TDFubWJU?=
 =?utf-8?B?ZHRMTFl3Z3BhazdGYUF0SUxhTjEzMXdhZmxiOE5TZXdFNE9sb0llTTRFWklv?=
 =?utf-8?B?cGwrcGpIZldTRyt0bTQvT09kYzg3STl5NE01djluNjVVNlAwRDc2dDQzR1cy?=
 =?utf-8?B?a1dRUlVQR3lJZDdESXluNkRVYkE3NVlieGRtdWNuTTNKZ1JuS3llV0N4Q0tD?=
 =?utf-8?Q?g2vY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 08:08:44.7938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceed1c0-c401-4791-d30b-08de114238af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
Received-SPF: permerror client-ip=40.107.208.54;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

This small series fixes a compliance issue in the _DSM (Device Specific
Method) implementation for the GPEX host bridge ACPI tables and updates
the corresponding BIOS-table test refrence blobs.

This patch was originally part of the "Add support for user-creatable
accelerated SMMUv3" series [0]. Based on feedback received and as it is a
common standalone fix, it is now being sent as a separate series.

Please take a look.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20250929133643.38961-16-skolothumtho@nvidia.com/

Eric Auger (1):
  hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value

Shameer Kolothum (2):
  tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT
    table
  tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM change

 hw/pci-host/gpex-acpi.c                       |   2 +-
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5337 -> 5337 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5423 -> 5423 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6246 -> 6246 bytes
 .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5391 -> 5391 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6698 -> 6698 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7812 -> 7812 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 10274 -> 10274 bytes
 .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 10274 -> 10274 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5539 -> 5539 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5354 -> 5354 bytes
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
 tests/data/acpi/riscv64/virt/DSDT             | Bin 3538 -> 3538 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2985 bytes
 17 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


