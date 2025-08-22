Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B94DCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 23:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upawM-0003Yv-AD; Fri, 22 Aug 2025 19:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upawK-0003YQ-9h
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 19:12:56 -0400
Received: from mail-co1nam11on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2416::621]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upawH-0006kk-HM
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 19:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pY2BWByR4uAwilm4ytOzOGrfeFlDYK9bV1t3nqiug6fb1V+Pt/gPWvk/pmat0YY6L9Z81ghoeb8roGDsDyqCybp2G3w6EFo1uHv6E9hzL18ROIvFxNaLneS/eSAq3dkpnlNJ85HQPU2NaNOTOgazJmSNrPKtWLx7VBBpjdv7ge9Taoaqz/biMEx2W/jx7bSOHbt7q1IYjJymurcpG07D/lC7yBEwdvmIrHyFCqaBwiwg2NcFDbk7j4U4QfKGVXS/WlMlynpYCQ7Y6W97b7dXHzcOCTmKfauBUK/OKkPIGOQIlafIsFZ1zDMnlfyXSNuyG206l7bfnVz1F0qL07WD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WK5DlyodJ8s/wG9sRwbT9ywkWlEjHOFOnepoevnWO48=;
 b=rZ/7owNR8THs+mFHjuKpo8McgKhLIubr2tVUJbbzBvIOC6fgH+XrxeEKNGWethnre7eIeYqwYV8ZNNP8UFXbBOEFNG6XOavCo3LQdVsce+w7W6Jt8J/l8CL2byCuYeL/ibVgyfLv2JhWbpQhBLf4ZGQtfUMwdkMcW7Z7ZpUxT67hypM8jrYBajMgkXX22jwrwxMLMDtjcUro6s7kmyhT9zEV3ibwayZDfwJIOiu2xF5T6wuvMUQN0UncrDc4n156V2d6h2B+UgO9FyMiELHHZ/X6fLJQa0warowZixD8+NxVFT8Up/RDnwbXB1p9G+RsGuG55nAaUSiydOED6namqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK5DlyodJ8s/wG9sRwbT9ywkWlEjHOFOnepoevnWO48=;
 b=m76TBaMBbFl/bZlHWTLFABe9dsmOuzaHwoyoeh2KRcijfkDbicN5jk+BZ7zhKlBj5dG0xdFv1quAcJAOVL5r8WBUNFYwtSQc+teJfURL+vcdBb929qZ7Upd0sZh78ezygdvK0QDBHmfU7PvLwZjZKeNek3itrX9MAOkYZ1fPtKgE/3MgAtSOfcZg+y53HUES7HMwQJafk3f2QAzNokbxRJTu10KaQToPNyAtjHJbd26WBFJX1AitvAB4nvquUxDfwZ275SU+I7uVhZ9pZ+v4bhgV0K+URQxu7I4UpfLX5udPr88sj6zktu97e8lB5cDcE2g9d5gZd3BecJVqxj2fyA==
Received: from MN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:52d::33)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 23:12:46 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::3) by MN0PR04CA0019.outlook.office365.com
 (2603:10b6:208:52d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 23:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 23:12:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 16:12:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 22 Aug 2025 16:12:31 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 16:12:30 -0700
Date: Fri, 22 Aug 2025 16:12:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Message-ID: <aKj5Xcg4476do8Cs@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-6-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822064101.123526-6-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e06894-618c-4572-adca-08dde1d167a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tNGwIkZIvvqWWRtEvVaSMH4Zrh9vL1CtOY+aJnNuChw6EU5sfiToZukSJJg4?=
 =?us-ascii?Q?zSTg5Acyixl4BBdIma51nlwH0uZlJzH05Z+oIioNEw6RDbVJl2sPbKkU1cFE?=
 =?us-ascii?Q?P05X33MII+8j0wn53Z5zYw5r7no405rNCu6LdYdQq18TX5E8war1ftNK6oGx?=
 =?us-ascii?Q?tP13j2ztmyz1ZQl0S3BFm8ZCMl+dZgO4VMHP7MLcCotGoz/OnrjEZtXWoLaZ?=
 =?us-ascii?Q?js7wq4mQ2vRZsy9xvQPnNvvaurCmDuN4Fta1MuNSerbshnyT+wsonNwoI6zS?=
 =?us-ascii?Q?9jUiKSm5A9wxfxvNoEpWG8+cHCrXVPilMdz+6mhr8mRSXRGT0EKMaZGsXXlv?=
 =?us-ascii?Q?SXnzzgVhGmfjcJ8ZxBUReWpbJw0rOZATFxBTRmgHeRiFbR9oleVPKnEv+X7O?=
 =?us-ascii?Q?3VhfSORmVpY7LKJrcsNsSy678wvVVT9Aqp+ruTJguA+wztpH1yxj0w8GVM81?=
 =?us-ascii?Q?6RJQIsCbwW0bG7mit113pSZiqX7C5uqKmYC1/+1qE6hd+UPZPKg1znLfMpsa?=
 =?us-ascii?Q?UQuTY67JMhrCXyo0GU4WVkuwmulH2XfTbpILSwAa1gSOmtJVgQdpyYTtgm7+?=
 =?us-ascii?Q?nwpJLcjfDa2uGJXkTdhgCdPm6vgoBZt/K5Ft8W7snPR35d2Z85niowguL/R5?=
 =?us-ascii?Q?SYxYxRKehGjpNJwwbfSGXpVlUQu19L3PLx9mgwyDJOx0i5MmObPWNknHKoAJ?=
 =?us-ascii?Q?9diX2XbAJJ/ofkPgrlfP0giX2yz4an85iQsybfexqT7CzvknkdusVhedApLg?=
 =?us-ascii?Q?5V3UdF/VoZvb+hnmrE+dPG9bQdwmqdL0+/lx41qYWZANsfkEAvHXCW2fpjR5?=
 =?us-ascii?Q?fE5t7XykRErhplQIA9Cvi+v2ItfBUanTPLcU4kddaXXzxf33nULKOXMKddh5?=
 =?us-ascii?Q?8njnJy5ZeW22/tH7bbQnW9UZ9YI/F+OOB9PjOhZaj1uFhmJtSbBYG4VTYKAs?=
 =?us-ascii?Q?vfsOfaLWMvpTGcci99e2FK5zDtWPOjKWhTFccgyRVUictA9ReKKEENpzZ3Su?=
 =?us-ascii?Q?30wA7+euIMnSpBoKfxhkKsqRPjRI0OVg/wsoOhyEgi5uvdoJOeyUq4b/Rxst?=
 =?us-ascii?Q?XKGLSEsmW9Hxr+RjAahGRnzunt1lWWLSUT6rBc2J+mRIKRDKK6tmg8r+n8z3?=
 =?us-ascii?Q?ltw39P8OvOpGzAb3L1tsVvkjZBhiohWy16hW8/buFB8t24nUHUdc5i/yJxrp?=
 =?us-ascii?Q?70ulR/SWntG5eZq0jYkFGyewvcoVLkLCaz9j2QdDH89FfW4SEH0SYFFTaoBO?=
 =?us-ascii?Q?eABWv91BTBVI5BmMhRS0LDsrV8mGpfWIj2gK7f5GRwiBQR+b8kT0M9YZQhLs?=
 =?us-ascii?Q?tIKxnwb7dKPsz7Erj8KdEltPXcbqfQ4me7/BblrlEqADLQRR3HUgBu7EP4oz?=
 =?us-ascii?Q?cILpkeN9YgTISPpgc9XPNbIC4lJFv7Jq6wkmvSFOAL1a9hIWdbx/YpZ9ETSZ?=
 =?us-ascii?Q?ba68ZFtA9EI49lu7J6vhTzRr493fCLhNqE5//MJgY/EbQRNe1wVeKf2csX5C?=
 =?us-ascii?Q?sUDEQyhqz4BqwkNHH6MZMKLK07Yos/UGd0fs?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 23:12:45.7610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e06894-618c-4572-adca-08dde1d167a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
Received-SPF: permerror client-ip=2a01:111:f403:2416::621;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Fri, Aug 22, 2025 at 02:40:43AM -0400, Zhenzhong Duan wrote:
> Call pci_device_get_viommu_cap() to get if vIOMMU supports VIOMMU_CAP_HW_NESTED,
> if yes, create nested parent domain which could be reused by vIOMMU to create
> nested domain.
>
> Introduce helper vfio_device_viommu_get_nested to facilitate this
> implementation.

It'd be nicer to slightly mention the benefit of having it. Assuming
that QEMU commit message can be as long as 80 characters:

-------------------------
Call pci_device_get_viommu_cap() to get if vIOMMU supports VIOMMU_CAP_HW_NESTED.

If yes, create a nesting parent domain and add it to the container's hwpt_list,
letting this parent domain cover the entire stage-2 mappings (gPA=>PA).

This allows a VFIO passthrough device to directly attach to this default domain
and then to use the system address space and its listener.

Introduce a vfio_device_viommu_get_nested() helper to facilitate this
implementation.
-------------------------
 
> It is safe because even if VIOMMU_CAP_HW_NESTED is returned, s->flts is
> forbidden and VFIO device fails in set_iommu_device() call, until we support
> passthrough device with x-flts=on.

I think this is too vendor specific to be mentioned here. Likely
the previous VTD patch is the place to have this.

Or you could say:

--------------------------
It is safe to do so because a vIOMMU will be able to fail in set_iommu_device()
call, if something else related to the VFIO device or vIOMMU isn't compatible.
--------------------------

> +bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_cap(&vdev->pdev) &
> +                  VIOMMU_CAP_HW_NESTED);

"get_nested" feels too general. Here it particularly means the cap:

bool vfio_device_get_viommu_cap_hw_nested(VFIODevice *vbasedev)

> @@ -379,6 +379,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  
> +    /*
> +     * If vIOMMU supports stage-1 translation, force to create nested parent

"nested parent" is a contradictory phrase. Parent is a container
holding some nested items. A nested parent sounds like a "parent"
item that lives inside another parent container.

In kernel kdoc/uAPI, we use:
 - "nesting parent" for stage-2 object
 - "nested hwpt", "nested domain" for stage-1 object

> +     * domain which could be reused by vIOMMU to create nested domain.
> +     */
> +    if (vfio_device_viommu_get_nested(vbasedev)) {

With these addressed,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

