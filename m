Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9682C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 18:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRF8A-000184-AO; Tue, 09 Jul 2024 13:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sRF88-000157-Ds; Tue, 09 Jul 2024 13:59:56 -0400
Received: from mail-bn8nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61b]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sRF82-0000bf-Bc; Tue, 09 Jul 2024 13:59:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+zBuDbCJY8LlCMnnLN7v6zxcVHyak+cnJwUzftMUrRbknppdCCCCWXkOrpFDmoKa3p6o0h3GWUJlnagtsATKBDB3dnKgBNKUpH8tThUq3IjTD9ixkZLQfqxdq0o8pRGXVx/GwiCmGoJFJ/8yAbaSN1Ew1W02zcw4TbCN6+CgpOfbgIYaSizOmACaz71C1wQSAYNnbYVrHvFy1fyjwU5VBNduTm4OgAG+D5svN7yTWpNZ9SElXHxesrhg+0h1RIQI0vZO5DVpWF3g5WAq9XuTz+cdtk2wdtM3cqvo7GyUPYo4wMPXd4/HV0OZa+NyOJWRBt73Sw5WlxIV2gGlHZF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7/daZJv+gQfeJ7MR2/rLBt0VrgV41fBxSzwM2BHv8M=;
 b=cRhSUEdR8H6My+FynLOov58Wlk9VkD943lXw7E8XM8J5SHuUlraj4GXedAxLviS78Y0Su0GDr+A17yffR1Kop9zhCww5F0CpF/EVPOZSeTBsmPQFxPsrL/NFcCqb5rmrV1jC00FPFbnCudbRqAGoAX4v910Nh+qJ+yMOm5mJ8vA0iaV05fvW9CnJ/lOc9IUZ3nZdfzxxwuwod0GEF0CVNAf/uDjSx+sG/tYwkTRu1jJcxcC3USkslbTkXy3ysAy5zoINCq+i1B9/8FAUedKUHRx5h7Ry8eBRUOdUPXMef7jRifc6BA/0enAqQXt+ePW7MY/9T+nOenY9Nx4r38f6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7/daZJv+gQfeJ7MR2/rLBt0VrgV41fBxSzwM2BHv8M=;
 b=rHH/dl+2DjCZ74Te0xKBFjj3mWvZijZ1LgCqTNIYB5EKBJW1P+H8q0Spj1BDcsL4terKkkNik0+lS54LZCKKsELPJcCXhY/N1J/Aemsc1CU4//A3X4WvdARxPvg3DVsPrHiwvcLT6nrn8GE1wE42fxaFj63tSyjGHPSjizXRpXjP0rDPGT6CDJn88Wrzw0rjWsjXeQKYYk90JvnIfoKgjESkZViJeO5Y0G7LUqZp4/g1zvLeqUTfk8nWZ7V0ZRNz06eV7GRbSinCa+DnVLqZeVRGNLfVJyu3SyZntVGst0d1V5C03RXw4kGKCcGU7wRaGIIRT1R0aSywsfnMkcgalw==
Received: from MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 17:59:44 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::e4) by MN2PR11CA0022.outlook.office365.com
 (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 17:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 17:59:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 10:59:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Jul 2024 10:59:32 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 10:59:31 -0700
Date: Tue, 9 Jul 2024 10:59:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <peterx@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>, "Andrea
 Bolognani" <abologna@redhat.com>
Subject: Re: [PATCH RFCv1 05/10] hw/arm/virt: Add VIRT_NESTED_SMMU
Message-ID: <Zo16gnKKxXFg4LLE@Asurada-Nvidia>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <bc7a57311ac4976699789ceca329edfdfe823c2d.1719361174.git.nicolinc@nvidia.com>
 <9c3e95c2-1035-4a55-89a3-97165ef32f18@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9c3e95c2-1035-4a55-89a3-97165ef32f18@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f73bec6-292e-4b88-b10b-08dca040e9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fLl/PErT0vlAaD89LFk14q4BlMwsEmqWo/178ceP3kHWOJj3Vk/2TnMe+oIk?=
 =?us-ascii?Q?Qad6z2T4eASfSVR0lh0L09Uho9VaX3OtThqgFNcmiDqwzARTUMRG1zWS9Vtn?=
 =?us-ascii?Q?Cyl1S/QXzs/BxNtQQyFaBsd10yi+ZRqHDrRWfJduHe13ou5FpDYAs1b7bEaJ?=
 =?us-ascii?Q?ClzmAl+eD5n6jTXZm8B9EB9EYb3txl/j95wpJZpIP1L+pnx9cLYD5IsSshgC?=
 =?us-ascii?Q?S1XoBtTz6iI4AVID5bZ2QkTUHY5rRBQ+XblvZ6mbS4CPFLVVEWFrRWIlv+wv?=
 =?us-ascii?Q?izAR53Q90Fdfh++XEaWPZgeDjciVkv49hOaqNyof9BDKWXcgxAxzg/ViPA9m?=
 =?us-ascii?Q?RNnrXtxzaj6Gg1dwr0XPqU2+4ZeyFNDA0eBG/aHzk0Rohl3SkcT/bX7L/bTX?=
 =?us-ascii?Q?+6KqCbEBCwZkSwHPRxl9qJPMW9WPXWhqV74Pq3AXpMRDouAdMsPlh+qcvTvM?=
 =?us-ascii?Q?9kKU4zFe8vQHvfwd8ONg5BicEPYKD2WW/QlXUUU4wtMsS78+TN1TDRny1Y68?=
 =?us-ascii?Q?3wddzGtC+khPETCjJw37Qwral9O23ebv4UcNiNCejPFH3FN8xWb6AMHQVc0i?=
 =?us-ascii?Q?p7NcJAZ02MKLCBQTJRfjQBZ2ZN55yYLNDTf15VDLUVonexbw5GznFOONo9fm?=
 =?us-ascii?Q?2feP66NkUQJyxItypQkbj4bk3WCs446YYutWdx7gIhUwdRHWjV9CR6e0Y94F?=
 =?us-ascii?Q?bqzOXr1lGaIvAbCvIAEzQAvNiMONARF3br3LfA5GR2ttdEIPZtf1HOpy3W52?=
 =?us-ascii?Q?V5dCbUVZVedjVdnwMfSL4GPQq8pt88NBVYxr5O2iwrkeMAP/0nU1JzLGZOVL?=
 =?us-ascii?Q?TReA2aHSjNosoetiH2vQt8bsLc0S1+dPCvpHdVEk89IQEn+10gNvm4G8zlrT?=
 =?us-ascii?Q?uWHjCa8PZda6eY+HNwhvqcM2S5PSVK7m1GpM77BPigPWL5CzFU2FDw9RBnuN?=
 =?us-ascii?Q?qeLzMsGNn5nFRLcvnd0YiF91LI+HFjePnO7sV6ZsxFpMxZeZcqyeLhoYKlym?=
 =?us-ascii?Q?0lwhuwXUdrpYWrrt7JaOoKkTBgn/tE+2sV3MRVLkabhCsT740zdk6yexlS8i?=
 =?us-ascii?Q?kR67HD7CQ63mLqg3ktM9gx29WTPYjGkWmMPxKvlDKX+Z3q0ooUHeL9Hpd8lc?=
 =?us-ascii?Q?7LNI4K1IFTat0r4b8l7syBT/kVZi4bIb+w4JFBtyZ4TMdCWEZkTeBQNZht11?=
 =?us-ascii?Q?QJTP0WtACsCd4/rjjZekN4UpP/475lnz5w5CDfcXXrFEvxQqlrlULGDa2NKi?=
 =?us-ascii?Q?j1nCrPOq3iSIPB00K6S5+69dxzEOnS4y9z2cHuB5Wsnxd0uE297z/Qp5m/oB?=
 =?us-ascii?Q?AV7tIfG3rQTHJeC3imibzw/ISNKTLZ2EOiooLHb4a39HD3jmwyyB2XxGFHG+?=
 =?us-ascii?Q?sLpGW+cbldAbogY2zhLRsjlU2ujNvnSjp2etDM7HXt+zUjHKgc3sJSkde376?=
 =?us-ascii?Q?tioWc2+UrWyw5rjuexVJU9OD5H+76sz/?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:59:44.0398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f73bec6-292e-4b88-b10b-08dca040e9de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
Received-SPF: softfail client-ip=2a01:111:f403:2418::61b;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, Jul 09, 2024 at 03:26:58PM +0200, Eric Auger wrote:

> > @@ -1580,12 +1647,33 @@ static void create_pcie(VirtMachineState *vms)
> >      qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
> >      create_pcie_irq_map(ms, vms->gic_phandle, irq, nodename);
> >
> > -    if (vms->iommu) {
> > +    /* Build PCI Expander Bridge + Root Port from the top of PCI_BUS_MAX */
> > +    if (vms->num_nested_smmus) {
> > +        /* VIRT_NESTED_SMMU must hold all vSMMUs */
> > +        g_assert(vms->num_nested_smmus <=
> > +                 vms->memmap[VIRT_NESTED_SMMU].size / SMMU_IO_LEN);
> > +
> > +        vms->nested_smmu_phandle = g_new0(uint32_t, vms->num_nested_smmus);
> > +
> > +        for (i = 0; i < vms->num_nested_smmus; i++) {
> > +            DeviceState *smmu_dev;
> > +            PCIBus *pxb_bus;
> > +
> > +            pxb_bus = create_pcie_expander_bridge(vms, i);
> > +            g_assert(pxb_bus);
> > +
> > +            vms->nested_smmu_phandle[i] = qemu_fdt_alloc_phandle(ms->fdt);
> > +            smmu_dev = create_nested_smmu(vms, pxb_bus, i);
> > +            g_assert(smmu_dev);
> > +
> > +            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map", 0x0,
> > +                                   vms->nested_smmu_phandle[i], 0x0, 0x10000);
> I think libvirt is supposed to create the pcie bus topology instead and
> it shall not be created by qemu behind the scene.
> The pcie elements you create here are not visible to libvirt and I guess
> they may collide with elements explicitly created by libvirt at a given
> pci bdf.

Yea, the bdf conflict is a concern. So I allocated the bdf list
from the top of the bus number... one of the reasons of doing
this is to ease users so they don't need to deal with the over-
complicated topology. I will try libvirt and see how it goes.

> I think it would make more sense to be able to attach an smmu instance
> to a given pci root or pxb either by adding an iommu id to a given
> pxb-pcie option
> 
> -device
> pxb-pcie,bus_nr=100,id=pci.12,numa_node=0,bus=pcie.0,addr=0x3,iommu=<id>
> or
> adding a list of pxb ids to the iommu option. It is unfortunate the
> iommu option is a machine option. 

Yes. I had thought about that too, but the virt-machine code
creates all the instance at this moment...

> platform bus framework could be considered to dynamically allocate them
> using the -device option. This has been used along with dt generation
> but with ACPI this would need to be studied. However at the time the
> smmu was integrated the machine option was prefered.
> 
> Maybe using the 1st option would allow to infer that if there are
> different iommu ids this implies that several IOMMU instances need to be
> created.

Yea, I like the idea of creating iommu instance with a "-device"
string.

One more question. Let's say we have 2 smmus/pxb-buses:
  [ pxb0] <---> vSMMU0/pSMMU0 [ devA, devB, devC ]
  [ pxb1] <---> vSMMU1/pSMMU1 [ devD, devE, devF ]
How would a user know that devA/devB should be attached to pxb0
without doing like devA->pxb0 and devB->pxb1? Should QEMU just
error out until the user associate them correctly? Or they may
rely on libvirt to figure that out, i.e. moving the iommu node
matching from QEMU to libvirt?

Thanks
Nicolin

