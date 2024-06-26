Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62FBC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 03:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMIzc-00075m-KG; Tue, 25 Jun 2024 23:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMIzW-00072O-Q7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 23:06:39 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMIzT-00066r-E6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 23:06:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSOQBWG8cydKIM+s8uVGF3Mm0RSPVQ+LbzRiRZJ0yVz7xIyI9twF8sLc5e9LMglwoIVmcszl5ovTOK5yhLht4q91b3eW/RszCCDVUIBpekJpo9NGNpbsEtWYjY41T4WUEElzcf+bx7iEBTNEEvMsy/BresQFyta9oVn1hiP1Y/nwflG1O1eXQoNvryvytepvwWKu/RebKV3AU04qROH7z72Xgioz0dTCtcAAdWLAQY7fpn1UQf0hBgwQPoC4jykD4768TQLzmoir876woW2KnOFovH4TnZSQngkUmM5ygTJYsEgNLRnk91SCrTPZU+/4Q1h2KxMGp5p0+1dVJ6g+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaHMImhxlWXm6Nuj2oc4xDABEku0w2bEwu1Lqy+/6xI=;
 b=Io6AAjwdIGjwa7E8hgjYK1v24lHYgi3+M9XWjuRjqfudFLSpYzvViVInFXswzPyHfXlstD2i9lBBo9nD16G3fhuN3LFgD3zOtzwnT41di1ec4x8hpNL6V3rIY+sUu7bzKlxYb8odW0x+S+E/juS1qyJ1oveh+N7UORfgCKgEUw3VtMExZgxULMBvr7XQStzTZfpSLeMS5aQajj1nT0lAhRkBXME2XSlNpkUsd5chJ3onYBZYpsevKUnnisRYe+COoNVcBCRFzJYLjREeqJYT7ecWEeU54jgrc5yAcjrCx6cHJNlbXL/GXs1uu+Hodm+DXjbNIVYPk5zSTUKroLMNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaHMImhxlWXm6Nuj2oc4xDABEku0w2bEwu1Lqy+/6xI=;
 b=mGAseaWH4r5AiVFJmRI70gcrT4jvVyN19Od8cqJ85fQ/7fJllCsmYxp1hKtLQzwzXmQFwBq6QykcFIqmjz7IiN8qwm6WRD8efXAoAQwtMITsROnea6Eel7wkpxKJUftuluoNXGShbnBkBykEGjtuPr9oLurADs8n34/AsAgNqmN1ggUWz9rqyUojY7AsrGGvoTmnF93/8lqt4bhWRFTs82HaCfuKXYZQglgv5dkg6eUE3P0xnrTD0Xfl8syVBeX5Ev0LhzeQoEIbxCfIwa8e+p1OYZFUNiDWfWewlKJ2pdWNiBfIO4qCy3keJzscgJX7EgY8kB2jnbyrzpUZS20RbA==
Received: from BN0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:408:141::34)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 00:29:25 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::8c) by BN0PR07CA0012.outlook.office365.com
 (2603:10b6:408:141::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 00/10] hw/arm/virt: Add multiple nested SMMUs
Date: Tue, 25 Jun 2024 17:28:27 -0700
Message-ID: <cover.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: b05662db-20bd-4c17-13fc-08dc95770865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|1800799022|82310400024|7416012|376012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g/s4G66lj8IbNu/jNdusEZL1OC5zr2O2EekhHkBOdfeWCMaWm6uVU3gVG6Y6?=
 =?us-ascii?Q?4M/r37O5QyHTQnqBbW8PQ6HzY+wHxCBSxY+/sEFC/Tc8oIoXJoXtbANkG/EP?=
 =?us-ascii?Q?4eXS1vFijeQCrZwB217qc4GDRIqOm66BRox55ZwkUdmUX3rWNgHc6oDzHLL6?=
 =?us-ascii?Q?FRBKsbdTtV+WTaDF7WzmlRDA74IySNDSEyMFQrA5NPHe7L8cCWsaRn80GdQo?=
 =?us-ascii?Q?CG5m98Aw2XR3PtZm1XPI4M8/VLMjnJLiuKM4xgu/mEEozEbP/u0QSeNPxZjC?=
 =?us-ascii?Q?6SRIHesVx0UmSGrso4FEzO/HsfokSA+7XBl3Ai88boKPbmGTOjZy4kAb23qu?=
 =?us-ascii?Q?OaFxMwLIZ7AzouLQGt3itqFriPYsqAZyEgLy3eNMLM1CiHyez6x+IYePh/Ew?=
 =?us-ascii?Q?zM/VDnia51MZS2fdEvwhwqSBVz/4z0QzN6xWw/8qs0nO+ZK28SYrlkcLAuf/?=
 =?us-ascii?Q?UWrnCZkxhWMac+RYgCaSmjlZgbIX8E1tpQtXGHZ3oSwsgULB/19xr2sgYuk3?=
 =?us-ascii?Q?NeZD4So09Te57PKDg8ln90eDQXuhbD3PnINSnl1Fn+oMYyUgEAh8VYE1WI8F?=
 =?us-ascii?Q?U34Lbdx0uAYPccazWQXB2lxdwOwThd6UFWUfN9P8gs5n3iMgGvPk9roRaVjf?=
 =?us-ascii?Q?C2EYiN+Hyq8N/QeGw7xMIEYQWiX0pEW8YVF7xLL0wyY7b5yb67ZlrZSR2IPG?=
 =?us-ascii?Q?oRHMMPFargE+xcBg4gH+QIYT317Jmhejjk7a9Yc+hmMBGaGyooXnlW0ve1ei?=
 =?us-ascii?Q?TAnd8zEUvY1cvGEkRwF70co68qlynCpiDZjf6RUj++0I4MSx72boUhrB6WRx?=
 =?us-ascii?Q?OAw7hIxRMnxdZn0Mfmy2Z5FF5t9HUO9wOAhRrVEjPw4sOoFParg5SuS2TeIP?=
 =?us-ascii?Q?+hn4E9ZGzctdheTtq3pCmJ5+z3osNX8XhcS1RUx+SrotU9aZmpB5HmFHMvLn?=
 =?us-ascii?Q?XruZjEJ5Cuts04wFnnSQOOqj2bHtmD0EOb6ZcRW+i03VbHA5AUqXUM5sELGE?=
 =?us-ascii?Q?s2j/mKh0y+7INLm9FshB1VrmWdQk4kOGmHaOw3SxAmmv72yTFCnFoyu7I0fn?=
 =?us-ascii?Q?Lc85770pua/3bqQJtVQOKskLNy9/xUtNPwtHhWagEzXdTVAzkUysZCmR7S8M?=
 =?us-ascii?Q?8SIjenvwjsjcZIE3XmzklXox6gsoCpynxeVMUnIbirQkWf9cUM2yu5RU6QD/?=
 =?us-ascii?Q?EgQDQFeXs9dg+WXWrfsfCInfRi/Q4Zs2V4Umid6uAaD2qAkDicXPKrohrDbK?=
 =?us-ascii?Q?PuXcUH+LWBPp+lNzskvdS+G9QrQUVi/CFfJ3f3RJ1wu+ghqYr7yv+leD6frC?=
 =?us-ascii?Q?CzUMYwIjI2SVhAPcULN+Fv+Jmex/LqSfn8OdkjwUPF9NNr2ZpbOoGIRRHO/7?=
 =?us-ascii?Q?BpIXFAqb7xYnbME2ohKfEdQZDqwlxRrXGjD/3tDDZoujsotwHZaYbNNIzGI2?=
 =?us-ascii?Q?iExiCkq7PB8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(1800799022)(82310400024)(7416012)(376012); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:25.2225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05662db-20bd-4c17-13fc-08dc95770865
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

This is a draft solution adding multiple nested SMMU instances to VM.
The main goal of the series is to collect opinions, to figure out a
reasonable solution that would fit our needs.

I understood that there are concerns regarding this support, from our
previous discussion:
https://lore.kernel.org/all/ZEcT%2F7erkhHDaNvD@Asurada-Nvidia/

Yet, some followup discussion in the kernel maillist has shifted the
direction of regular SMMU nesting to potentially having multiple vSMMU
instances as well:
https://lore.kernel.org/all/20240611121756.GT19897@nvidia.com/

I will summerize all the dots in the following paragraphs:

[ Why do we need multiple nested SMMUs? ]
1, This is a must feature for NVIDIA's Grace SoC to support its CMDQV
   (an extension HW for SMMU). It allows to assgin a Command Queue HW
   dedicatedly to a VM. Then VM controls it via an mmap'd MMIO page:
   https://lore.kernel.org/all/f00da8df12a154204e53b343b2439bf31517241f.1712978213.git.nicolinc@nvidia.com/
   Each Grace SoC has 5 SMMUs (i.e. 5 CMDQVs), meaning there can be 5
   MMIO pages. If QEMU only supports one vSMMU and all passthrough
   devices attach to one shared vSMMU, it technically cannot mmap 5
   MMIO pages, nor assign devices to use corresponding pages.
2, This is optional for nested SMMU, and essentially a design choice
   between a single vSMMU design and a multiple-vSMMU design. Here're
   the pros and cons:
   + Pros for single vSMMU design
     a) It is easy and clean, by all means.
   - Cons for single vSMMU design
     b) It can have complications if underlying pSMMUs are different.
     c) Emulated devices might have to be added to the nested SMMU,
        since "iommu=nested-smmuv3" enables for the whole VM. This
        means the vSMMU instance has to act at the same time as both
        a nested SMMU and a para-virt SMMU.
     d) IOTLB inefficiency. Since devices behind different pSMMUs are
        attached to a single vSMMU, the vSMMU code traps invalidation
        commands in a shared guest CMDQ, meaning it needs to dispatch
        those commands correctly to pSMMUs, by either a broadcast or
        walking through a lookup table. Note that if a command is not
        tied to any hwpt or device, it still has to be broadcasted.
   + Pros for multiple vSMMU design
     e) Emulated devices can be isolated from any nested SMMU.
     f) Cache invalidation commands will always be forwarded to the
        corresponding pSMMU, reducing the overhead from vSMMU walking
        through a lookup table or broadcasting.
     g) It will adapt CMDQV very easily.
   - Cons for multiple vSMMU diesgn
     h) Complications in VIRT and IORT design
     i) Difficulty to support device hotplugs
     j) Potential of running out of PCI bus number, as QEMU doesn't
        support multiple PCI domains.

[ How is it implemented with this series? ]
 * As an experimental series, this is all done in VIRT and ACPI code.
 * Scan iommu sysfs nodes and build an SMMU node list (PATCH-03).
 * Create one PCIe Expander Bridge (+ one vSMMU) from the top of bus
   number (0xFF) with intervals for root-ports (PATCH-05). E.g. host
   system with three pSMMUs:
   [ pcie.0 bus ]
   -----------------------------------------------------------------------------
           |                  |                   |                  |
   -----------------  ------------------  ------------------  ------------------
   | emulated devs |  | smmu_bridge.e5 |  | smmu_bridge.ee |  | smmu_bridge.f7 |
   -----------------  ------------------  ------------------  ------------------
 * Loop vfio-pci devices against the SMMU node list and assign them
   automatically in the VIRT code to the corresponding smmu_bridges,
   and then attach them by creating a root port (PATCH-06):
   [ pcie.0 bus ]
   -----------------------------------------------------------------------------
           |                  |                   |                  |
   -----------------  ------------------  ------------------  ------------------
   | emulated devs |  | smmu_bridge.e5 |  | smmu_bridge.ee |  | smmu_bridge.f7 |
   -----------------  ------------------  ------------------  ------------------
                                                  |
                                          ----------------   -----------
                                          | root_port.ef |---| PCI dev |
                                          ----------------   -----------
 * Set the "pcie.0" root bus to iommu bypass, so its entire ID space
   will be directed to ITS in IORT. If a vfio-pci device chooses to
   bypass 2-stage translation, it can be added to "pcie.0" (PATCH-07):
     --------------build_iort: its_idmaps
     build_iort_id_mapping: input_base=0x0, id_count=0xe4ff, out_ref=0x30
 * Map IDs of smmu_bridges to corresponding vSMMUs (PATCH-09):
     --------------build_iort: smmu_idmaps
     build_iort_id_mapping: input_base=0xe500, id_count=0x8ff, out_ref=0x48
     build_iort_id_mapping: input_base=0xee00, id_count=0x8ff, out_ref=0xa0
     build_iort_id_mapping: input_base=0xf700, id_count=0x8ff, out_ref=0xf8
 * Finally, "lspci -tv" in the guest looks like this:
     -+-[0000:ee]---00.0-[ef]----00.0  [vfio-pci passthrough]
      \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
                  +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
                  +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
                  +-03.0  Red Hat, Inc. QEMU PCIe Expander bridge
                  +-04.0  Red Hat, Inc. QEMU NVM Express Controller [emulated]
                  \-05.0  Intel Corporation 82540EM Gigabit Ethernet [emulated]

[ Topics for discussion ]
 * Some of the bits can be moved to backends/iommufd.c, e.g.
     -object iommufd,id=iommufd0,[nesting=smmu3,[max-hotplugs=1]]
   And I was hoping that the vfio-pci device could take the iommufd
   BE pointer so it can redirect the PCI bus. Yet, seems to be more
   complicated than I thought...
 * Possiblity of adding nesting support for vfio-pci-nohotplug only?
   The kernel uAPI (even for nesting cap detection) requires a dev
   handler. If a VM boots without a vfio-pci and then gets a hotplug
   after boot-to-console, a vSMMU that has already finished a reset
   cycle will need to sync the idr/idrr bits and will have to reset
   again?

This series is on Github:
https://github.com/nicolinc/qemu/commits/iommufd_multi_vsmmu-rfcv1

Thanks!
Nicolin

Eric Auger (1):
  hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested
    binding

Nicolin Chen (9):
  hw/arm/virt: Add iommufd link to virt-machine
  hw/arm/virt: Get the number of host-level SMMUv3 instances
  hw/arm/virt: Add an SMMU_IO_LEN macro
  hw/arm/virt: Add VIRT_NESTED_SMMU
  hw/arm/virt: Assign vfio-pci devices to nested SMMUs
  hw/arm/virt: Bypass iommu for default PCI bus
  hw/arm/virt-acpi-build: Handle reserved bus number of pxb buses
  hw/arm/virt-acpi-build: Build IORT with multiple SMMU nodes
  hw/arm/virt-acpi-build: Enable ATS for nested SMMUv3

 hw/arm/virt-acpi-build.c | 144 ++++++++++++++++----
 hw/arm/virt.c            | 277 +++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h    |  63 +++++++++
 3 files changed, 449 insertions(+), 35 deletions(-)

-- 
2.43.0


