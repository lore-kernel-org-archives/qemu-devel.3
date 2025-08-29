Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDE5CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBf-0006gz-N9; Sat, 30 Aug 2025 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUk-00033i-8b; Fri, 29 Aug 2025 04:30:02 -0400
Received: from mail-bn8nam12on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2418::609]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUf-0006U5-9z; Fri, 29 Aug 2025 04:30:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul61eHd2qxGhCG578vYbIfWMz2UeAlzAnycJvtZRRFS0mq2fenEimYJB03ANy7TrzC2li3gZrzLSgQgfMNa0Fkm8ZEhEzzDrEA6HzwhNr/BwrvYknB6vOGqlqEtaDZ1cEsriFUHe/i/WrqdZIFeAqbCcmWy3BxiigAo1u+YjDJal/JhrmW/2fn4HpdcnUOz5CAjRwCwx+FuxiDOCNZx8ybbZVJs9ufV0+jOeNQT5OSJ5roM/fGQ2KtaK+ZIIg85cvPttFImBRO4iPM5nabeISKYnoqLbaGok5ziSfNNPQGL95ZnNbbBXEjEzrsrlnppdLwKLuM1JCWuZqEo717dWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCajHsD8mmTAQQeGxMLDakf622kreyGPv/zR5mzQ1q4=;
 b=Uv+HJdMLXPW1OIiVrm8rYS/kEj/QNS2AILh6f1ifuEhWaT3sQrEa+fd0/ObS2BueJT0Qfk0GfPkYk95o6b9gDRWJ7ulUzHxP3fXX8LXeNinCzI9ytERZ6F5YSC9VPrO21OV4DcxtenzLzh/la0Dqwk7rdwEw0KDEaDDJuhzk2OfG5LK4Mzpz/2cVZHm0Wc7MdIc7qzwsdqu/9ovARmjZM1hhrmMQd3jCCj6qHhPIL3ortPid6E+7j6k61o0oYQBwh6axbKCnNglcV5Zt/dZqJnXWsbLBT+GZfG4IhcMReR+mkXOciWO0qLYdr2jyVSu3cRCum0bCtb2C41ed3hEtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=nongnu.org
 smtp.mailfrom=nvidia.com; 
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCajHsD8mmTAQQeGxMLDakf622kreyGPv/zR5mzQ1q4=;
 b=nCQB/1+7CLxGL1FmGDqyBncSG77xhyidluVP31k45R9Aky3Waqlr6ZHFdT6H5LZFaaVPxMLjTDY8bXChOC8ssxxiVzzLhKNRvdCWj4CGBuOhrdWywtU+nnj8xvt2CR+n6rFrxGixUj72AWC1nRQz4KfXDbBmOm4EaC7N+1H2B+ohUcvXL+zqmUGiXIWDkrGTjZaPNPN0oPLN6mnc3CMykDu+9UZ1MrFLnrI5acU462VVz6biJMjdRQ6qg9NaD5B6JQSAnB8fzQr+OnFRda8JMZnvWQvb4xit08SXjLuN0WyNZt2k4tsoypTjs/0PhcCyG9kn+GDTuQLMRhMU1w/7xg==
Received: from DS7PR03CA0315.namprd03.prod.outlook.com (2603:10b6:8:2b::10) by
 IA0PPFB6B4D32F9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 29 Aug
 2025 08:29:44 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::c9) by DS7PR03CA0315.outlook.office365.com
 (2603:10b6:8:2b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Fri,
 29 Aug 2025 08:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:32 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:28 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 10/11] qtest/bios-tables-test: Add tests for legacy smmuv3
 and smmuv3 device
Date: Fri, 29 Aug 2025 09:25:32 +0100
Message-ID: <20250829082543.7680-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA0PPFB6B4D32F9:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b00b22-6010-47e7-2a6e-08dde6d63494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDVzS1huMU9LcXE3OG1QR1ZOa0I1bVdNWTdMNTZXMkxmTWNyYjBia2Z1cU1W?=
 =?utf-8?B?K3A0cVNkUGRpOGsyaTdUWTZJY0wvUC92RHF5dW1wejN0R0QzYjJPSkxKUTRo?=
 =?utf-8?B?b0dqT0JxQzRCbFhydWZTbW5sTmFkZHpSLy8xd2RKL1JYU1hQQ1pLRmloU1Rv?=
 =?utf-8?B?VDlDOTdzKzhvNnkwTk84ekxBeW1FTEg1N05aWEhzRUxhZ2E4Q21uSWE0TjBp?=
 =?utf-8?B?dzVzaVYzWlNGRTJQeFJKUlozeitkUThZV01qYTBaNkt2aDdNb1U1a2lTVnFu?=
 =?utf-8?B?R2NIZDdWSjBzRjRiZ08zdUxZdU5jaHp4dllwUkhHNXJLNDRqeTVZZTBZZ1hE?=
 =?utf-8?B?STVMWmVLSEVBdk50T0ZxVTgyZFk2SU4zNTJtajE1cWd0aytFQkNNZEhxNGtq?=
 =?utf-8?B?K0ppQ05QVTlLd3grSWxVY2NXUXpZWUZoMm51V1oyUGswQnB6Z3RpOWt6RFRl?=
 =?utf-8?B?Ty9oVmxmenRRYUMxcVUxVjl1RlpJZlAwblpNaGVLd2hEUy9iR3ZsMG41bjdo?=
 =?utf-8?B?Ly94SldNYlJnMEczTVNzd0pybVkxV2o5UHc0YlFiTVFIVWw1U1FQTHp5WnVB?=
 =?utf-8?B?U1BHd05hYUkwenVLOWZTT3lRcjdxcGQ0NkNjYWhyRTJRaThGYzd6Mnkvd3FB?=
 =?utf-8?B?SXgzQ2R6VGY0QXNpYUdmVnpMd3E3M3R5SksyV3VzVFhFNitYTEsyaU1lYStS?=
 =?utf-8?B?Q3AvcUJCZHU1bmdXZlpZdS93Rkp4YXVBeE5MM2dMWEZQdkJGaWNBb2piM2RL?=
 =?utf-8?B?RDdIMjR5L2hadUlZSklLd2tCUTRGbFFNMzZjQy9Cc1M5NnFVYWwrejZhL2Fx?=
 =?utf-8?B?UGF6M2tqVllaeXVYeWw1RldsdlJjc2w1Wm94cnI1VHdTanRkU0FjSXZQZzUz?=
 =?utf-8?B?OFZIUlZWUmZrSitkUXk5aVkwdE5CdTc0M2V5MGdUZXFvQ1k2dkZOS0pnQnFT?=
 =?utf-8?B?aGZpdUNvZ2xNdkxOTFp2RWxFTnI5REoyTm40ODVDSkY1M2c5WTgzUDlvK3ph?=
 =?utf-8?B?YXNUc1h1NnZaMXQ2SzMxL0tRSUxGaVd2YitRQ0wrVmV0WUFUK2NFS1ByeHlt?=
 =?utf-8?B?dzFBWlNLUkFnSXdpeEM2ZlhlSmRFeDFHY1FkTmJMRzQ4aitlc3NDRW8yUUk5?=
 =?utf-8?B?L2ZXbzE5QWxHZFZKaEYrc01sTE5HKy9MK3NyL1VwZ0M5U1NuNnlXbFFBZHpj?=
 =?utf-8?B?OUhQSnBEWTFJdkdNNjNsL2hNR1dBRVBmYWZHUm1zSUdSWWFlUzkxM2h0MmRL?=
 =?utf-8?B?bnc1S1VxTGwzVUhIVkRJM0FDSDVvTURJaUlFR096NndUQkVNa0RSWVNZTTdK?=
 =?utf-8?B?bnBJaDRVeXY1NU5kdHJ3Njg3UEl1MHQ1dTFJQWNuRmFLTXFSRm5LRTNXcE9p?=
 =?utf-8?B?Mjl3UWF0VUR3angyYlVFV0FGWkpIaWlManRsOFNYZWJBYlc0ZnVlWVRHb3h2?=
 =?utf-8?B?KzNjSzFuZTdkN3RGUE92bEk0c25Zckh4cnFzeWJjcmdlbHlJQ2FxVlRUcFRG?=
 =?utf-8?B?SG1NQUdvYXppaWcwVXMxYXgvWDNaRURQS2VpZE9wb3lPU1ZlUWNzbEhTbWhL?=
 =?utf-8?B?RnQyUHNhajY0ZGYzK1BqU0NuajFaTmEyTGNnZ2c4ay9yMEdmL3pxU05HRlNh?=
 =?utf-8?B?TVZLT0RLS3R2ZXAwbmxiZGo4YWFwM0NyYjVUR01relBucDZJc3U4K2Rkbm1L?=
 =?utf-8?B?b1kzdy94RXlMYUVrbmRHZm9xbE0zRGZIOGQ4bnRZTFlvUWt4RmhpM1BzelUw?=
 =?utf-8?B?MEljQVNTNEZYQUppb2hZZmE4aGJXWW1ybUNCMDgxZ0pkNnBxNGhiRFRJUEtL?=
 =?utf-8?B?UUxVaFJDTXNzR0NuWFJDemJmN1RvcWVBV3QzejVwbzU4K0dCRG5OVnE4ejA0?=
 =?utf-8?B?MDRvL0M0RWxwRFFBWGRnT210TG5xMU9KVUJUSXdTK1pORFFpNXVESXFHajBj?=
 =?utf-8?B?b1FMWDVOTmprQmVaY1JaK3lpWFhKZU15VDhuL1N5MTNEUGt4My9VVUdQa3dx?=
 =?utf-8?B?SlFldHo1a2E1cmZoNERTOTBvNWlZT2xwVjlndi9XRmxwcE5aYzZXaWV4VXRO?=
 =?utf-8?Q?HphpPy?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:43.5393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b00b22-6010-47e7-2a6e-08dde6d63494
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9
Received-SPF: permerror client-ip=2a01:111:f403:2418::609;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 09:59:54 -0400
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

For the legacy SMMUv3 test, the setup includes three PCIe Root Complexes,
one of which has bypass_iommu enabled. The generated IORT table contains
a single SMMUv3 node, a Root Complex(RC) node and 1 ITS node.
RC node features 4 ID mappings, of which 2 points to SMMU node and the
remaining ones points to ITS.

       pcie.0 -> {SMMU0} -> {ITS}
{RC}   pcie.1 -> {SMMU0} -> {ITS}
       pcie.2            -> {ITS}
       [all other ids]   -> {ITS}

For the -device arm-smmuv3,... test, the configuration also includes three
Root Complexes, with two connected to separate SMMUv3 devices.
The resulting IORT table contains 1 RC node, 2 SMMU nodes and 1 ITS node.
RC node features 4 ID mappings. 2 of them target the 2 SMMU nodes while
the others targets the ITS.

        pcie.0 -> {SMMU0} -> {ITS}
{RC}    pcie.1 -> {SMMU1} -> {ITS}
        pcie.2            -> {ITS}
        [all other ids]   -> {ITS}

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test.c | 86 ++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e7e6926c81..4fa8ac5096 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2337,6 +2337,86 @@ static void test_acpi_aarch64_virt_viot(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_smmuv3_legacy(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    /*
+     * cdrom is plugged into scsi controller to avoid conflict
+     * with pxb-pcie. See comments in test_acpi_aarch64_virt_tcg_pxb() for
+     * details.
+     *
+     * The setup includes three PCIe root complexes, one of which has
+     * bypass_iommu enabled. The generated IORT table contains a single
+     * SMMUv3 node and a Root Complex node with three ID mappings. Two
+     * of the ID mappings have output references pointing to the SMMUv3
+     * node and the remaining one points to ITS.
+     */
+    data.variant = ".smmuv3-legacy";
+    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                  " -drive file="
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
+                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                  " -cpu cortex-a57"
+                  " -M iommu=smmuv3"
+                  " -device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x10"
+                  " -device pxb-pcie,id=pcie.2,bus=pcie.0,bus_nr=0x20,bypass_iommu=on",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_aarch64_virt_smmuv3_dev(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    /*
+     * cdrom is plugged into scsi controller to avoid conflict
+     * with pxb-pcie. See comments in test_acpi_aarch64_virt_tcg_pxb()
+     * for details.
+     *
+     * The setup includes three PCie root complexes, two of which are
+     * connected to separate SMMUv3 devices. The resulting IORT table
+     * contains two SMMUv3 nodes and a Root Complex node with ID mappings
+     * of which two of the ID mappings have output references pointing
+     * to two different SMMUv3 nodes and the remaining ones pointing to
+     * ITS.
+     */
+    data.variant = ".smmuv3-dev";
+    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                  " -drive file="
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
+                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                  " -cpu cortex-a57"
+                  " -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0"
+                  " -device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x10"
+                  " -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1"
+                  " -device pxb-pcie,id=pcie.2,bus=pcie.0,bus_nr=0x20",
+                  &data);
+    free_test_data(&data);
+}
+
 #ifndef _WIN32
 # define DEV_NULL "/dev/null"
 #else
@@ -2768,6 +2848,12 @@ int main(int argc, char *argv[])
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
+            qtest_add_func("acpi/virt/smmuv3-legacy",
+                           test_acpi_aarch64_virt_smmuv3_legacy);
+            if (qtest_has_device("arm-smmuv3")) {
+                qtest_add_func("acpi/virt/smmuv3-dev",
+                               test_acpi_aarch64_virt_smmuv3_dev);
+            }
         }
     } else if (strcmp(arch, "riscv64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
-- 
2.43.0


