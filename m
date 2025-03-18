Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61BCC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 19:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tucOb-0002uP-Jc; Tue, 18 Mar 2025 15:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tucOP-0002rx-Id; Tue, 18 Mar 2025 15:14:25 -0400
Received: from mail-dm6nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2413::623]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tucOK-0000wb-JP; Tue, 18 Mar 2025 15:14:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQBrgDvZ+YXRit6x1L37SbaEWsXRhsN7M/m5nbrHVlkzOETdPL9HDPIuKZHQ59Fqv0yLaqnH/dh2TlgJxU+XpQqV1m+yV66dGlluGYrnAL13mSkrRlO5mXOgCxeX/xRU8dQ8ChPx9f9jVOBMjbeaJbgQpbXpppT4+DNuHn77GU5gvjukaz1UUrL6iVX2EGoNWR8KfuFzOpy2cEJE7QfaVS6480BqXqWqZ/trRCN3uXXMfiaS9StVvVXwzTQqVunN6WyA1X3p4ijdmDwUI3P0JZK5YmreuR4QbavjWMDaEkGJD87mCra4kz+DLwwoTDJGZ8sF0opi9+17oWNyhUDwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUHh68qf+xW2jR0LICn5q9xA7k5KGaAR3BeA2WXD+EM=;
 b=AxefxjRm3PYqTJoPJYSqU5p5TIcW03FY9XnXMENsgwY8f4IFwz4Pk7JF1ON0w2HXb/EJkopfZpcSVIzdqKd/CDpRzXHM5XR9YjUbIJ5zuAvzJ+yCHVLPDzL0ApHs0ZidAeC+X5CT8XsJqO6IHSJy3N6MugLWBhIUyrvbPWLgzH1csitQUWYUpMOl7mrm0H2VBMAI0ExOQN/5yqQkD5UP/TDyIDwNA3ZQTVN5YmSkucG4Sdwp29ILETuS5snq5zkbESaM+O5resfq9HVuvY3iVlyv6JY8aNAH5KikNAYKcARR4cnXqEJ46f+wc6rxIfAwAf6b9pRV2ubDEMEjz7ueWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUHh68qf+xW2jR0LICn5q9xA7k5KGaAR3BeA2WXD+EM=;
 b=fwlTmO6QA0yvP+oZoLDcuWc+EkY/vO3ZN0OOQ4yDxGmzrLhW9hUfPoGdhJ7huKqeGmFn2pfpYNZO3dNeMMEiu4lKe0wNS2DU6W7jRzKqLkuGbtp3IF/AyAOxCC7qMzGDYPryLhFSSoL+V1NnGELZKT69sS3NnTuIK1Dde+pUwNStQHLl6U1DR+VOVRR+/521JKm4UqpH75+AtVcMg7IEzA1at37A6jxj1uDknFmumDCz/5DYjVdXIkWl83ja83EVxlWdJTE73aU8zoQiEEUOvk4U1OrbrfOFKmIK50Y5HLntW26QncEhNR2UijJw2cZBDG2MPGubBRuF6zAdrYYG9A==
Received: from BN0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:e4::33)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 19:14:11 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::16) by BN0PR02CA0028.outlook.office365.com
 (2603:10b6:408:e4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Tue,
 18 Mar 2025 19:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 19:14:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 12:13:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 12:13:47 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 12:13:46 -0700
Date: Tue, 18 Mar 2025 12:13:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <Z9nF6FaIU37BNg4B@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a41d43-f88d-4dce-7974-08dd66511053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FV+HOwNd6F9KnZilAlYMMkBEPD/gINW191Pn3rgtNmuTX9KgyNRruB50UVpe?=
 =?us-ascii?Q?+VNzgtMiGZwdgrh4QtqE7pzWpuFR4ujXBADC5fRUPgd09Mct9StmJHCy2pQ+?=
 =?us-ascii?Q?1yVfuvGodOWemHf8xq1Ep1pzeoFiLqlgq0K/dNZtRxZBL8at5Ljc5tYT/0a7?=
 =?us-ascii?Q?8HLTVQduB2HhJ9wzuslNstulQN8kDGIMpF0AR5KrL8XtXmwSlLkbvDhIn7vD?=
 =?us-ascii?Q?oYVktZqnEV/gNS/r6iJXUSuoacl53RwRvlg02CZni/O1xkhdnUqYvyKOYwBi?=
 =?us-ascii?Q?p84lTHVtx/QewMcataCz7oXFySQMIkHwbYM0cweh2wOvhupMqRmSrgkFL/J0?=
 =?us-ascii?Q?fBF3XJbmu9jMep0WRr2pm+ROQP0NyVSJaF6gJfKCmKIYB4BQ+tGlF9i9HB/H?=
 =?us-ascii?Q?DGwBM8FH5DGwyBNua2J//GSiemE7+AonAtvt1wYrBv7m8h2nmo7uiUrqmom4?=
 =?us-ascii?Q?pZd9If7cnkF2UD5EYtSaZlKBkdy7GvObjQlf41hzAoIWA6+uX78bNVmZxTGP?=
 =?us-ascii?Q?P/xOIeavSfgLylHJMzbc4N0a1/F+Wq2gptG0e4+6ux8g1yM3ACBMCuOaEGvN?=
 =?us-ascii?Q?SN2OlWy/Fhl3oZGzA6M0+cXJbXpGljNSZI1cyACi7Kq0ATViqWaA46RbdJ3I?=
 =?us-ascii?Q?8RS79IGlecok0VvK8QaXn6ZzGyeRJfhpTDSPzKg8X3OAv6/jDyms23Rmw3Ot?=
 =?us-ascii?Q?hjPGeP2MGHGyUMpJSxjK8SWAcCWhrGFSWYm2FdikJRhgVCMPS4WLcuiTgzQm?=
 =?us-ascii?Q?miztMUZpTHXKOyhG1K/1j8k1eZX3kUW4BOwyRuFJPLm4jpX0MDGF0x58Xwce?=
 =?us-ascii?Q?+HvjbiNSeXMhBGeIRXMIPm1paTTkb43Z/e8HVhvMeocOvjVacTEnShaTNyjv?=
 =?us-ascii?Q?mzylHJk5Ir+Eu28BfSyRzgow1Zh88wH5xL1ckYQenzM+wp31C6Bvkv+wP6fj?=
 =?us-ascii?Q?2jQm2SVU0LbiN4H+KMyEGFfYBnPp3DuTWARbtRGOBrflN6M4NwYWfnz/9Kx9?=
 =?us-ascii?Q?lEZQFYw35JuiTS4ClDh+8gQbAbFqZrMDUXYr7I+itzEQZ/3GzQBlA67kZJk7?=
 =?us-ascii?Q?kXTm5vrt0mTJqRqs+lzVr3IgcaoNfeB0BZdys06QD9rAEFn2VfehW3YaTD8G?=
 =?us-ascii?Q?FvlddWh6xqRdn8yQiihu0vxWKzdTHJl0BrS64hgBsQYrUULF5EpXS7d/KBBh?=
 =?us-ascii?Q?W6zsVLF/Nk46XfivwvIlM3muGZvTunTUZBcTt9w03G25uPpkwEeH36fC8OX3?=
 =?us-ascii?Q?NuA2yaQUq7IerYXZbI9q/LrZH05L/f7bvY4L3r2zny8USrIRcwqCj15Hc5LP?=
 =?us-ascii?Q?bD3vZEAd9KB24lA/y79/m3u5gjjdrmbqdE8Jg5MebR1FmozVQQKRwAx8+BVc?=
 =?us-ascii?Q?hL+Xo69dqkJM3QbaVH8v4SXnO/FeVITTs8H7xschCl5TR4SFSxQU+F/s18du?=
 =?us-ascii?Q?tIbAZ9i0PQEnSeEWYZiHJBJ44VE26bqgvNJ/glX1p9/bz5RUx6CDfKMPoJsJ?=
 =?us-ascii?Q?VRLk+FvDxD4qGE4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:14:10.7049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a41d43-f88d-4dce-7974-08dd66511053
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
Received-SPF: permerror client-ip=2a01:111:f403:2413::623;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Tue, Mar 18, 2025 at 07:31:36PM +0100, Eric Auger wrote:
> On 3/17/25 9:19 PM, Nicolin Chen wrote:
> > On Mon, Mar 17, 2025 at 04:24:53PM -0300, Jason Gunthorpe wrote:
> >> On Mon, Mar 17, 2025 at 12:10:19PM -0700, Nicolin Chen wrote:
> >>> Another question: how does an emulated device work with a vSMMUv3?
> >>> I could imagine that all the accel steps would be bypassed since
> >>> !sdev->idev. Yet, the emulated iotlb should cache its translation
> >>> so we will need to flush the iotlb, which will increase complexity
> >>> as the TLBI command dispatching function will need to be aware what
> >>> ASID is for emulated device and what is for vfio device..
> >> I think you should block it. We already expect different vSMMU's
> >> depending on the physical SMMU under the PCI device, it makes sense
> >> that a SW VFIO device would have it's own, non-accelerated, vSMMU
> >> model in the guest.
> > Yea, I agree and it'd be cleaner for an implementation separating
> > them.
> >
> > In my mind, the general idea of "accel=on" is also to keep things
> > in a more efficient way: passthrough devices go to HW-accelerated
> > vSMMUs (separated PCIE buses), while emulated ones go to a vSMMU-
> > bypassed (PCIE0).

> Originally a specific SMMU device was needed to opt in for MSI reserved
> region ACPI IORT description which are not needed if you don't rely on
> S1+S2. However if we don't rely on this trick this was not even needed
> with legacy integration
> (https://patchwork.kernel.org/project/qemu-devel/cover/20180921081819.9203-1-eric.auger@redhat.com/).
> 
> Nevertheless I don't think anything prevents the acceleration granted
> device from also working with virtio/vhost devices for instance unless
> you unplug the existing infra. The translation and invalidation just
> should use different control paths (explicit translation requests,
> invalidation notifications towards vhost, ...).

smmuv3_translate() is per sdev, so it's easy.

Invalidation is done via commands, which could be tricky:
a) Broadcast command
b) ASID validation -- we'll need to keep track of a list of ASIDs
   for vfio device to compare the ASID in each per-ASID command,
   potentially by trapping all CFGI_CD(_ALL) commands? Note that
   each vfio device may have multiple ASIDs (for multiple CDs).
Either a or b above will have some validation efficiency impact.

> Again, what does legitimate to have different qemu devices for the same
> IP? I understand that it simplifies the implementation but I am not sure
> this is a good reason. Nevertheless it worth challenging. What is the
> plan for intel iommu? Will we have 2 devices, the legacy device and one
> for nested?

Hmm, it seems that there are two different topics:
1. Use one SMMU device model (source code file; "iommu=" string)
   for both an emulated vSMMU and an HW-accelerated vSMMU.
2. Allow one vSMMU instance to work with both an emulated device
   and a passthrough device.
And I get that you want both 1 and 2.

I'm totally okay with 1, yet see no compelling benefit from 2 for
the increased complexity in the invalidation routine.

And another question about the mixed device attachment. Let's say
we have in the host:
  VFIO passthrough dev0 -> pSMMU0
  VFIO passthrough dev1 -> pSMMU1
Should we allow emulated devices to be flexibly plugged?
  dev0 -> vSMMU0 /* Hard requirement */
  dev1 -> vSMMU1 /* Hard requirement */
  emu0 -> vSMMU0 /* Soft requirement; can be vSMMU1 also */
  emu1 -> vSMMU1 /* Soft requirement; can be vSMMU0 also */

Thanks
Nicolin

