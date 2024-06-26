Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7667EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGaf-00032T-W7; Tue, 25 Jun 2024 20:32:54 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGaP-0002ym-PW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:32:41 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGZR-0005AS-Rf
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:32:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwinHG9r4rMTlQxLRH8Sm8vskCZmMm4jLFhL/1iKVI15q3Jjvk/+V/GKr4OMGiOSfBkNJ0StZPzcw6WShQbbBa1P8NknEI4+TU4D6m4uM4L0I+o+Nr3vm2um82Y3BGetGyO/BMUrgP4P5Rgcy+FZsnFoXJ4CdZ++IIT8SlSOmgqVY8VrcwwhQICJy94BO/3ZfhekqNGPCUBXMVMktXytANv8UjzjE0qxTWHJ+sSUFq/Rh1myAhWeWVHiXjpA/5V2Dzq/z99Q4XfxE/rR3e7X8prTsKdggev021eEsRkpiEVGk55jpGgUsw22+QQKkp2ciomfnXJGfuUe7Vz120mR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st6cXlXTtG4KWRzuy7Kgk9SpM3l4nRJKRVnsNJCtIGs=;
 b=kgSpCjH0pusS3lw3AfxGladS1eKmOfbO+RNuqsIdV5rrTLeHeTP+2NK1sub1l1gLS0pQkIkY6/DtxcQu43gvr5NeGA3bMR8rYrybUSMhDeihWNOgjbuYBszIpco3hAzyp2MKIIWiMUH7w+WGFeJUhjUsJkopn898fVf256U8BUK75pLGKJ7wdiDGijqO+cj6HP07EmPMWYLi3iFWKIdDoPEjb8az3AVWM9SfpyUzcMrAS6NfGd1NboWdrHOIMfgsHYTfHIHe+asqtZ86I8dv7Ka3LAzK68HnIy+ZgQ4GcV7hJ+0XasstL3E0zOyobkyzH5sBl4K51+CmjECNl2c8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st6cXlXTtG4KWRzuy7Kgk9SpM3l4nRJKRVnsNJCtIGs=;
 b=Tv4PpvP6ahFkQSMl7YXS34j50mQ+f7J3AdFf0k0a/h8cfnT7aKkXUkhLFFZdxaiozVINyXfJhhMFDsPYteVkOKAktSVO92lP2xQj3AWFQ/56kWdSbZqyeRjZw3rwcDFKJ84BHymWGxyqRF53BL7XYw15NgxDDu/aDTFF+DWMtniL713RnBS7V19Ij86fSpEnW+4h1f477JjQwmMQKu6dFM1CUI7gMq8DGm8n2+W6ZbaeS5z2fsM+muj6bF6VssjohKv4vbVqiaesTytJh7BQV2YHkEpxLhR2HjWgjMa5mfKStpjJFAxlxj5oNdbIh8abFInfCwt+zYBLYXvA2+YkvQ==
Received: from BN9PR03CA0949.namprd03.prod.outlook.com (2603:10b6:408:108::24)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 00:29:40 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::c5) by BN9PR03CA0949.outlook.office365.com
 (2603:10b6:408:108::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 07/10] hw/arm/virt: Bypass iommu for default PCI bus
Date: Tue, 25 Jun 2024 17:28:34 -0700
Message-ID: <27c5765e7a945de1c10269f05ca3347b5d62eedb.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 6453cc0c-adfa-4dab-a3e4-08dc9577111c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8onOuZJcVof3n1G/tZBkqCJMvQgpMjjfp7FIQRJ7wGK8HRFqk7eXLE5fPCu?=
 =?us-ascii?Q?gKZAC4daPDnX0tIiRqru8pHjyq+WtV5X2DMapd90QreDmIWMErGM+XD1fLA9?=
 =?us-ascii?Q?F4iee9rfddq3ryZoiIPW+FdPWVW4X5xNnzWaOdIBTzs2idYkI+tM7go6QmqR?=
 =?us-ascii?Q?dz9W+cZt9kXsJMwApqAVDCBK632RdPqJtrY7Flxbx+dU2ASjKtj1QuHvdX71?=
 =?us-ascii?Q?FSr/uUkVlAM7Fz0tvuiVnCResHdh8rkoMrCF75j/zhQ2kdXDaApnmS+n8CSP?=
 =?us-ascii?Q?WZOWkKwy9UxH2VFtanoQ8u3yBLjqfmB5VQbwW0NeA4ColQXzOxgPLAYqa3nY?=
 =?us-ascii?Q?DAB4ScckUWtuw0Ow8SY6txCahRtYgPyqN6NXrrIpEKsZNAeNBBtF1W5viKg1?=
 =?us-ascii?Q?aWjhcW9lTiwOCXjUICfjD3xvsgzKlb70Ms83gsWMymuowIKRwgvjkeGqAZYC?=
 =?us-ascii?Q?/Wpd3En0efJ7Qfm+zjTZfZRFsyBJkqrbj74AZAE0rv3dKLL3x5j/NNmWMC6S?=
 =?us-ascii?Q?RI/qSqIHSqOwVmwgGEprJ0VNs9IJCrrPQR+ju67xVlNZkF0dH/w0meX5vONZ?=
 =?us-ascii?Q?44UHClVcXOeO3WUj7y6Mi1AlSJFfgCR4sFTwhxKYIfPS71dfAQ007g3+beZB?=
 =?us-ascii?Q?cBYZEHGEzenk9Mp/4E34IcABT37QelCN7VG32l4kIe7vtaQ53G3f06UQNkqg?=
 =?us-ascii?Q?1NXM1iOuZYdwkI6wJUAGSmnHZgn/tt6M2JskbHJ12yMwutsRIId15H2cP1qt?=
 =?us-ascii?Q?2lJwFpyVdZYhgyebvx0CSlocspzK++T2+6aRTfiEu6lSYH4m/IsJLL1RSafa?=
 =?us-ascii?Q?DBqtP1En/GU4aaaXrqZMxD9Ih8f3yZRNHI4/OWL6ADnCO+pcoNGU6D1byDSy?=
 =?us-ascii?Q?Qxj1GYdDikJz5UHwC0AlJYTQb/S84CXeaMiZWofinMiQQ7UiyFj9btUFKpaI?=
 =?us-ascii?Q?GhRlo7fMBbKN9W4BcVMiOeyYlAn1VcrRPDapV5KvgYUh9qEeyhXzrEa/iitl?=
 =?us-ascii?Q?eF1V6nzfyqVnKY2gevZyfVJ8QoZD7Oes0ws+9/v5Pn9U5KT4p9TPF+htr9lf?=
 =?us-ascii?Q?CU0K0DCc6ifcfnuqjev0+15dSWmH9YAhsVNpw8uiTQLMlLheEAqaQeMoMm1N?=
 =?us-ascii?Q?wAjQ/c1QcuFu+8zdLYHoC755+ilEVeiB7U4MGa/EQbsJyJjKcFpz4f9HhCRo?=
 =?us-ascii?Q?tJ9bircNto2PtwtXW6vBMqzb8HpsyjuhpPIdYNTZ+UrZVbEqchrJPODDv0st?=
 =?us-ascii?Q?sEVn9jl7rQu+Z9WO9mkYdooY0ekGpj95yJ91Ip7S3d5Udv5ox5nFEW8u5x/c?=
 =?us-ascii?Q?9h2l8tye4S//PQ6KdCrGpwgM/uJ62ZiGjfUeVte2LVqP1rf7IBhWx17TtEtw?=
 =?us-ascii?Q?s0+pS5SdSIIAqGZRzCjIf0DfHtkI/2DXLr7LpulXKgHUe4xjcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:39.8316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6453cc0c-adfa-4dab-a3e4-08dc9577111c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.4, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Now, all passthrough devices that should benefit from the nested SMMUv3
feature are assigned to dedicated pxb buses. So, the default PCI bus can
be only used by emulated devices.

In theory, these emualted devices can be still attached to an emualted
SMMUv3 instance, yet there is no gain doing that. Set the default PCI bus
to bypass iommu, for the maximum performance.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3610f53304..5e91dc8c3d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1708,7 +1708,8 @@ static void create_pcie(VirtMachineState *vms)
     }
 
     pci = PCI_HOST_BRIDGE(dev);
-    pci->bypass_iommu = vms->default_bus_bypass_iommu;
+    /* Default bus used by emulated devices does not go through nested SMMUs */
+    pci->bypass_iommu = vms->default_bus_bypass_iommu || vms->num_nested_smmus;
     vms->bus = pci->bus;
     if (vms->bus) {
         pci_init_nic_devices(pci->bus, mc->default_nic);
-- 
2.43.0


