Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25400CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGjDr-00037n-Ob; Wed, 05 Nov 2025 14:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGjDe-00034h-Fq; Wed, 05 Nov 2025 14:31:00 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGjDc-0001Kb-Mh; Wed, 05 Nov 2025 14:30:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cnz3jcVqZEDfFW9utK/Je5MeJkWXAYDMYCvwbV1TluZv99pUBOFRWozpgG6ZckGdoQjTEdzRz1v3NrHT6BPqc28LRZ6Rr0vDF6pffj5qu4Bh/rEzktSDoa5LQnrTlG91I/5dFXDUCkx35/7hlnDxLfkwLTSn3k4kzMO8OdI5x+LvwhrsApvbK9cTiXdVi0NcFd4tyGLuZqW4uFqIC1NJSDShmx5cdBimt+F8iMWEDEp1n0xZFVBGptwDfMvCLCfyaNBjTMn9sgssJpkGqv/u8GpyIvMyrtA820vG6Cv4ZsnOmP/aAKgRC/3S5gTVI8m5KjtPA3IphxQjV9+P76VBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GUvWOZZXl1v9kKg3NxrZmh5ZzUr72APmx1dV3m7S+w=;
 b=u8s2kZRTd3+ZGHOf2LJjBsmV+B1h1XDcNHRU2Q8ZpaJL7yEToniDIuxowAqkBMA/xO79QRbQaeEy3bxiYnQARZBGmpQeSf9UODqSNFqHBNxVahgJB3Uut5366veCJU2WB5vhFkLYt1lCJJF4RoE7KfWRYtUbFXqR4V8bC8V6ihhsjXpwjPyAc721CkuGlHmfOxULs2rSMUZmu39RuahfAoPivEnF6HvgMCblEaWpUPVoXSe1+q0PhsF1MCpnNFO+vV1BEjLgl40Uf9f66kbxrj6hL/LJ/ORNWMGxRO2DO7nLc4Y9SVua76iJsQJoyoozvAoTBxNw7+2gw7RCOKy45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GUvWOZZXl1v9kKg3NxrZmh5ZzUr72APmx1dV3m7S+w=;
 b=LT96+tTeta3qnPgN4ERERv3xtu0mvBVOriB01rsEuEEJ4l1NsHWQPCHq/Af0LGqVEsyahwH4eMoMmljzvKRDqLw8HBHKy/LmfP6ScOB1lgleaCZeFR6FByxs1rpRVGPVXdN2PuYOdE/eirDq7T2axwdvVDFNZuIrkSo6wXQgMUxLU8O1M64lJbJRSkzAnRFAtfKVHzd4kHo+SDGDOYqfYss59nx7GkhxoZBXCQAv7oKGhFMz9xuER2BXZ0E+hAuDjuXaCrMTnP1+2jt+0ZOjwVUa47cQFQ4YU6tq1RZ68N6UYHraXPZmt2HbWZuNWvjJgW4fOK3AfmAFDrOgrjVLCg==
Received: from CH0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:610:cc::27)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 19:30:50 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::1e) by CH0PR03CA0082.outlook.office365.com
 (2603:10b6:610:cc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 19:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 19:30:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 11:30:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 11:30:27 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 11:30:26 -0800
Date: Wed, 5 Nov 2025 11:30:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <aQul0f6HyiH/zmyg@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <3c9e00f5-de9e-4e5c-8312-75eb4fcef81b@redhat.com>
 <aQo8MPCrr82wh3LI@Asurada-Nvidia>
 <413ca488-1301-4f0c-90bf-ab3ef5a0791e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <413ca488-1301-4f0c-90bf-ab3ef5a0791e@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: bc858c3c-0985-4750-b3ec-08de1ca1d3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?coDgo1yWjnP4HRZ3if0HGq+/rZuugsY36yAHMO05fGxVEIKhQphtCiAFq/jY?=
 =?us-ascii?Q?/uJtWOtpU4vSqrrKB1cDRovl74IumTY4YBsKI8ladtVtzeGaL2fOuUHRs97M?=
 =?us-ascii?Q?6TKhof36sboPneS92GvtterD1ge6nJCmBHPlo5/YdcO+t2/87sSwbOoK6lRo?=
 =?us-ascii?Q?PTO8lUFwZcJV99o0rIy8R+q9nI8rxJa70EHtarpth6+WyLh1DkN7io0OzFaT?=
 =?us-ascii?Q?zLWsi//MybyCrwLGHz+eeK/HC8UuEQ2ySiaW3wY/qZxDqkL50p5HpEFOKr0X?=
 =?us-ascii?Q?7zxW80dOPk92j8ywEYLFkdny5YcOgi9MeY+V70l52Yy4PR1tqFuVIsbeYfiE?=
 =?us-ascii?Q?EmFqubgjd9bfIttUFWvsEkXVk0ZxKtjNIki7qDlc7Ahhll4oZFAhTr7pj2jz?=
 =?us-ascii?Q?arrqaifGmoiKikGf+Vlb09HotK69YDOqtic2SDE61mAwI8AelWI2x0izbCdP?=
 =?us-ascii?Q?HxN1Nmhj3lvoSw15DqST/tqpXY6MNw9h9dJZBOL4Ep7n31xIC8zd+D9RNWLo?=
 =?us-ascii?Q?f80S5ZS4rAg3DhU3EGvOgjLH6nE1mOTkaogW/Ug7lDfNpovtKeg3ViJNuTdg?=
 =?us-ascii?Q?7XdsEwNJOau2xUJuOjgyinH+n6ZCCKK3R9LH9WR6bJLQfI/hWTf/uJVo8PIC?=
 =?us-ascii?Q?YQQD3RdsnVlmdetZnMwYTDBxcMu43/j6CYfGjQWmZb5nm9WL6UhrvKmKDLaR?=
 =?us-ascii?Q?4gyZpRTUlGv3fyZ56yAqBwtJD+zz6iCz7hbgTMyB7d9CgtQQ62P3jOPn/IG4?=
 =?us-ascii?Q?A91yAx0+9X84PS2D1/gWaJwu0rN4vK6jY+sg72l+yBQoPARHOSTJxvEp36lJ?=
 =?us-ascii?Q?uNC2tK1fyP+g5N/MbgLF36wE83gsSGXIKjbVc4IVBeCez3OEk/Z4nObnZwT7?=
 =?us-ascii?Q?526OcHoxhq4zYaCMhOdddZ4vk/XxTQeaevpvPTuzJu8PPn++EIjNp+xRe5cD?=
 =?us-ascii?Q?3EjBWiLI81KGMJwUV4eWUpAv9DJ3DTGxW5Vk2jkH9y71w4OCte45cwxBKY4Q?=
 =?us-ascii?Q?LuopiULX4GVsrOB/WWvs+oAYifbPfA+iFzM8/ltZNymEtzIA4iORtzvLhmpf?=
 =?us-ascii?Q?56Rfn7UaDC/a5ROuEBHPSTK+HhNqULm5WBe3l3qGyJdW2pZvTLMx8DAlvvQT?=
 =?us-ascii?Q?2v/ixp5T8QBLfswvZbkJQHnb5bp2Wo5gP/tZpPinfWiaMA6XsjEFKkPSR8bT?=
 =?us-ascii?Q?zgJkJ41cjLHb+29QiQsqKjACI2yZu/AL9Tjlqf9fa4Hr8a6p1lLKUreS9yV1?=
 =?us-ascii?Q?A81l56UkYr9Ncdh29FD+GV4bpV4JGc8n0HK9GMVcSIT8ErB8Zsr9E1XQI1x/?=
 =?us-ascii?Q?LhMfE4d1j2Aio37M1UatmWgaIl4BWd4YEs7yH2xhce0YKKEk4W4D0xPusrzI?=
 =?us-ascii?Q?gFuf20PWMlKdoZSVZBqyGPZl47Oc4pOMuxDVOCFC1j/Vfd4m7EyXYq3MUv3Y?=
 =?us-ascii?Q?QfKh9t/HUak614q8D/h7SVAtp3UD8MOVAwtSVYOafjtQZhY8ZqvaWA/ol+i7?=
 =?us-ascii?Q?iXaYHuDojxpdpOn9FFGucWSHkPxOOq+2aZ4D+79H8ZafZaIoy4fzoGTv/m6V?=
 =?us-ascii?Q?/dEmNunAfPyp0bRH6SA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:30:50.3350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc858c3c-0985-4750-b3ec-08de1ca1d3fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

Hi Eric,

On Wed, Nov 05, 2025 at 08:47:56AM +0100, Eric Auger wrote:
> > We aligned with Intel previously about this system address space.
> > You might know these very well, yet here are the breakdowns:
> >
> > 1. VFIO core has a container that manages an HWPT. By default, it
> >    allocates a stage-1 normal HWPT, unless vIOMMU requests for a

> You may precise this stage-1 normal HWPT is used to map GPA to HPA (so
> eventually implements stage 2).

Functional-wise, that would work. But not as clean as we create
an S2 parent hwpt from the beginning, right?

> >    nesting parent HWPT for accelerated cases.
> > 2. VFIO core adds a listener for that HWPT and sets up a handler
> >    vfio_container_region_add() where it checks the memory region
> >    whether it is iommu or not.
> >    a. In case of !IOMMU as (i.e. system address space), it treats
> >       the address space as a RAM region, and handles all stage-2
> >       mappings for the core allocated nesting parent HWPT.
> >    b. In case of IOMMU as (i.e. a translation type) it sets up
> >       the IOTLB notifier and translation replay while bypassing
> >       the listener for RAM region.

> yes S1+S2 are combined through vfio_iommu_map_notify()

But that map/unmap notifier is useless in the accelerated mode:
we don't need those translation code in the emulated mode (MSI
is likely to bypass translation as well); and we don't need the
emulated IOTLB either since no page table walk through.

Also, S1 and S2 are separated following iommufd design. In this
regard, letting the core manage the S2 hwpt and mappings while
vIOMMU handling the S1 hwpt allocation/attach/invalidation can
look much cleaner.

> > In an accelerated case, we need stage-2 mappings to match with the
> > nesting parent HWPT. So, returning system address space or an alias
> > of that notifies the vfio core to take the 2.a path.
> >
> > If we take 2.b path by returning IOMMU as in smmu_find_add_as, the
> > VFIO core would no longer listen to the RAM region for us, i.e. no
> > stage-2 HWPT nor mappings. vIOMMU would have to allocate a nesting

> except if you change the VFIO common.c as I did the past to force the S2
> mapping in the nested config.
> See
> https://lore.kernel.org/all/20210411120912.15770-16-eric.auger@redhat.com/
> and vfio_prereg_listener()

Yea, I remember that. But that's somewhat duplicated IMHO. The
VFIO core already registers a listener on guest RAM for system
address space. Having another set of vfio_prereg_listener does
not feel optimal.

> Again I do not say this is the right way to do but using system address
> space is not the "only" implementation choice I think

Oh, neither do I mean that's the "only" way. Sorry I did not
make this clear.

I had studied your vfio_prereg_listener approach and studied
Intel's approach using the system address space, and concluded
this "cleaner" way that works for both architectures.

> and it needs to be
> properly justified, especially has it has at least 2 side effects:
> - somehow abusing the semantic of returned address space and pretends
> there is no IOMMU translation in place and

Perhaps we shall say "there is no emulated translation" :)

> - also impacting the way MSIs are handled (introduction of a new
> PCIIOMMUOps).

That is a solid point. Yet I think it's less confusing now per
Jason's remarks -- we will bypass the translation pathway for
MSI in accelerated mode.

> This kind of explanation you wrote is absolutely needed in the commit
> msg for reviewers to understand the design choice I think.

Sure. My bad that I didn't explain it well in the first place.

Thanks
Nicolin

