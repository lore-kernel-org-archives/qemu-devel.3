Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D091DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQr1-0005ND-3A; Mon, 14 Jul 2025 17:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPCm-0001yn-BN; Mon, 14 Jul 2025 15:51:16 -0400
Received: from mail-bn7nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2009::618]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPCj-0003kb-MU; Mon, 14 Jul 2025 15:51:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4lXAolVQRQvsFsqY+oEbEpiaZawG+X80znPYOiPFGJSumR9KeXMqfb6hTX1K+7MTA42jChSA0asmV1bjxqasLNMORcsljHJe23GlMRPQB5yiZqoYu38J4EX9CfRBYuaTAUhqrpMplU4Vx1wTslOGVvq3xV3QCtTllCQLicZScyRpYxCgs1X80tyV8DXPFHg6io87wMGtMD1FdxbvBgkZvjm/RC73XUoPxjMd325mi1FvBe0ovqF0G0QHdYMVM7x+t/JMlcVXyAyygV1ERkvwmEjXpR7ac5pqwQdKG6+KaITO+ZBDa1sCNMncUcnrLwqwwN69J0JhwrRJlC0cmeBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlZPqiwvjukYIPRsTgVgluy9sTqg3jh63PGw6mwyHtg=;
 b=dN5jKUgfteGvuFmEVak7wZHKVV5FW/R6geo+3ehksafIHBmCoIydSVbVcImjvc7MdmyEmjIDJ5zsvnDyVpW5e9pQyuR3m/Pwuiif+IM3yT9wowQCHO9Pg3GKuYEI6uS1C9Jmtg/I/skIVIM4qqdb2o66xW1OEBEPQ79UdCe1r0AdJ5igzGenJxVxa67S0uVAD0Jq+gmHHoH7+kQ1UPJ2uZoW0uDuVjpDLi8iAIu5BBifsk/RkMki4ahfidolpP2n22g4koI+Odh2I2UCwsmXPaiuw1CVhHl2CMYB9y42Lw9NRLpPar7TXro3Cq+UQ7Ryp+2E/GWPepEmD7OAyenx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlZPqiwvjukYIPRsTgVgluy9sTqg3jh63PGw6mwyHtg=;
 b=hnmfKfKbcHMR1/zeT6cPo/Ir9bvS2M5QVEg8EsOeuAEJYUKYZa6hoJskrrUCjM0RoWZ1sYrjJt5zOrSoBNMr1kpsLiM/N8jaMv+Gm82mw8UzWkKY+IEbU+fnEMIo44vfz0WWnNzf5WCFW5GQsojL7oXuB+59QCEof6EBF5KzS5C/9l23PjU//SDRVX6mY2S8SpcCxOTD115LHXWVP8hZz6iWL5UExRQd4XSaE/2Jm/nH9toNSuaIyWLCl/RFWdfqBlF2rHEdv9q/6UIZjQLfPlSNqL33mN/6l2Ri2wygut5cG3L75OlHYNg9JF7QTpsiv8+7NoSmCHcPNXuSRbXviA==
Received: from MN0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:208:52d::16)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 19:51:06 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::3e) by MN0PR04CA0027.outlook.office365.com
 (2603:10b6:208:52d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 19:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 19:51:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 12:50:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Jul 2025 12:50:47 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 12:50:46 -0700
Date: Mon, 14 Jul 2025 12:50:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 11/15] hw/pci/pci: Introduce optional
 get_msi_address_space() callback.
Message-ID: <aHVflRCJM+pcsP2S@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-12-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-12-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 7374e5cc-c5dd-4670-1496-08ddc30fc4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n9NpKj9FtYsdh7+ZuRU2KWxXzAQUJonKmBmAmP3PmZnJTh1L900HVyXPt1DL?=
 =?us-ascii?Q?CQ+aqmVPT7e8j4aDZ2WYmTlAH8iEOU3DS3WB4R3vrsVKxCPHDh0adpqWQAbe?=
 =?us-ascii?Q?6EOZGkcuQRlYpaA7QFnHviWAOtRERM0roSz1fHjE87f+7TqhKq8O179SunVW?=
 =?us-ascii?Q?wCzysdhhDRoCTSLe2IduIYWJ6OIjDzN4wJDk77voj1tEUkPMIzQwTkq2Osf8?=
 =?us-ascii?Q?AtpLszZuCCZoSRf1Ko0Ax2UotZh2Jx6vo04jx8m53jidKDs7pGpZZYTcTF2A?=
 =?us-ascii?Q?XofsHzLes8B+HJ5MB1nI8vLdbLaOgbaQY5hArKLBHkLKmxOPP5Ryp1yQ0+ld?=
 =?us-ascii?Q?S3Ux/x3cNsxf2ichd8QLBF0nPEvW9IVupNLzFr5Tz0gBIyBTuWMjVlCsiYQR?=
 =?us-ascii?Q?iThu5Oe16gMJJbegkV42e6/q7KaJkhBCnP3U5xbxg69veMrp8StaCMuxPZpj?=
 =?us-ascii?Q?fWLaeV5QI8ngv4vw3lvc2YCz5WzqCIzUeDZ8Du4rp/+9fz8BqjrfmTNj8jn/?=
 =?us-ascii?Q?smCmR7raInkywaC7/ObDXwCwvm4B9To8L/VKUOT/3IaL95dc6ix6iNEj4eE8?=
 =?us-ascii?Q?U4Y+t1lymlErZlqhjEqlRcOcFJkXQ6evBIsVaEhzgLLY+j8NejPUcRbPSpsZ?=
 =?us-ascii?Q?f5auvqpIEMajQJDUYHGKQgqmWtyz9PNNs4HVDjRVaLpZzM4tVBdUljMDlZVq?=
 =?us-ascii?Q?3wp8RTvXmEpWVhC8TrIdJiaEfz/1ZKcV4f5GOHOqBMPkmkDfmFurWL9qeMlG?=
 =?us-ascii?Q?fwVwo5EpVEfT9jgB8mDBYIwyKlqN7kXzhbQBUSTfMO60kdf8pYi2BSSmFtvA?=
 =?us-ascii?Q?xF/xTrQx+KHB795jiuc87tjgV47g33LHFnCBaeBB5hubc0v1+Y8uyTFtfaXF?=
 =?us-ascii?Q?/Vp/iih8TAxHavp4H/L195BshcYFaK149wmuONchAg+qjMip7XqARB+KCgvz?=
 =?us-ascii?Q?5oVf4C40/U3nuCbomnR5dHlGqPNg/vFN4zVkpgRNJts7ygONCg8mkOo0EqUq?=
 =?us-ascii?Q?vW8jFWB+I90KOdmIdGMZWiwCaTlbx6BVhjnlLsYGjy6ELQ4XhdRdFbHMXjmW?=
 =?us-ascii?Q?B3jYKxvgp2kjapBamqp5U5J1zQ54K/O5b8D0qvEH1HeTJ7dChCbbA56K5z+w?=
 =?us-ascii?Q?cA7wCL4M36+R7Y42jN+LEHa/8OAVWI0gzGoeNUb3F9rXxfUq7GN9swWPb+rr?=
 =?us-ascii?Q?Hhv1IJRoD9klwlzHpS+8aAuPTqu6XEN9Olr5jL4xJwKfULGKeFHZ2eYxBdAW?=
 =?us-ascii?Q?P5WdJo2mp7wQmGD/j38iE/Grz3XvWtpyl+XgIDggXfKNQnwgpitCmeIDN01r?=
 =?us-ascii?Q?puCY2xwQHNOjtt4NjdAhuChyxDdnIZZZkR6iHUiL0qhk+HPrzk+/9ez9oguO?=
 =?us-ascii?Q?D0xmobkP/thStfewjE+NMes4Yr7yEI2LfbKnLAduE1f3KG/uA4JDVPF5vMaD?=
 =?us-ascii?Q?3mlE8OWgXhjInaZzD++ANCTn2bBT+S96QXplHzQUXMyByNKkO6ysk7VFcnN4?=
 =?us-ascii?Q?LK7wtSi920Me8nUOjE0L6MWvY6bZof1ICoBl?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:51:04.6767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7374e5cc-c5dd-4670-1496-08ddc30fc4b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
Received-SPF: permerror client-ip=2a01:111:f403:2009::618;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 14, 2025 at 04:59:37PM +0100, Shameer Kolothum wrote:
> On ARM, when a device is behind an IOMMU, its MSI doorbell address is
> subject to translation by the IOMMU. This behavior affects vfio-pci
> passthrough devices assigned to guests using an accelerated SMMUv3.
> 
> In this setup, we configure the host SMMUv3 in nested mode, where
> VFIO sets up the Stage-2 (S2) mappings for guest RAM, while the guest
> controls Stage-1 (S1). To allow VFIO to correctly configure S2 mappings,
> we currently return the system address space via the get_address_space()
> callback for vfio-pci devices.
> 
> However, QEMU/KVM also uses this same callback path when resolving the
> address space for MSI doorbells:
> 
> kvm_irqchip_add_msi_route()
>   kvm_arch_fixup_msi_route()
>     pci_device_iommu_address_space()
> 
> This leads to problems when MSI doorbells need to be translated.
> 
> To fix this, introduce an optional get_msi_address_space() callback.
> In the SMMUv3 accelerated case, this callback returns the IOMMU address
> space if the guest has set up S1 translations for the vfio-pci device.
> Otherwise, it returns the system address space.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c | 25 +++++++++++++++++++++++++
>  hw/pci/pci.c          | 19 +++++++++++++++++++
>  include/hw/pci/pci.h  | 16 ++++++++++++++++
>  target/arm/kvm.c      |  2 +-

I think we need to separate core changes and smmu changes, like how
pci_device_set/unset_iommu_device were introduced.

Thanks
Nicolin

