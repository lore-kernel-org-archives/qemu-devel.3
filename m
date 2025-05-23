Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F74C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 21:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIZmU-0003Yl-46; Fri, 23 May 2025 17:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uIZmR-0003SU-Jf
 for qemu-devel@nongnu.org; Fri, 23 May 2025 17:18:15 -0400
Received: from mail-bn1nam02on2076.outbound.protection.outlook.com
 ([40.107.212.76] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uIZmO-0003jd-U0
 for qemu-devel@nongnu.org; Fri, 23 May 2025 17:18:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj3h6o4NtIPFBdlYi2YTkf0/RgC2Lb4w0lqeSpbwFdYEz7jsYfZP/D7TW0niFWBwZQChiBFutwa3LPkbC1whedIT01FmvD5u0pWo3HhXOE223zBttGCsFBz0NA18+D4XtUS9QoGuHZ5jUt6HOxHJsXlhetIfDHsMcRmQhAgaQtIRZOAGLmZQqHUWFv7qRaz/aFlKXYQvm/SjYLFzhgCh/t2e7xaq61PJ01H05zbfk5YxT6r5GQBFaTvmEC4yvASI4uv/1/4zrzy1Ws7F45TMZoaRL4OfyRjpBEbzG4vMZb62pO8V4KIcwhML+EIhtNrt8YhrYfCjmpISyc3KkWdgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df00A6GgyX+NsPMkG3dbAvRYWQsX4s0KTOQzkVI1eoA=;
 b=RvZAgIs938mY4nhGF4RDh8SnLczGMvagwjz1uQNfjVSpMBCkYhuPTRx5gUWBIkRHw8xhtAo2pIgNkNreokxpqGGcnWqmgM7ElZNS2ypSeuCmqT7wObDd0hqXrEOtMhZKkAdfwtomCnP2J4rvHCVXH2DEAusrJtXO4YuE8M0d4GmJTMKg1mv9uOgv/aUabxrF4zaER6TCcDI+J0LUF2kCsc6xn9R86wMgAM16/HQSR9RA1ZQxjLKLPqrPwjLxsX9UZkw8XKnnIhvFKwsvsYz26YJHpTvchHJhXziLO84G3jUgBTA6nI+1+6YsWKhcByWqcS7IGGN12ORG2JYvDx3GYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df00A6GgyX+NsPMkG3dbAvRYWQsX4s0KTOQzkVI1eoA=;
 b=mvCXiTCC0yMTCVeWAOqIO8BAvl2UviNL+3oQt1DdRwzi5H31PdP0C8AM3085NSNEZJbeFSzAsyQq7ysq7yuM2EGStZ/HHqTGxz3xpDywGZSOMqM06IvooKAE8Y8CHey8JFRpgb8PCjxX3SLAo3eNYK11eJM/K8ni/xXr0aAEemH3t/uD3w41Fap+sGFF+0O0FJnB7vaVabPoMEOj/aLSxs4kHtEEfwhrZ8jP4+kO6dLWM6IKsAtDKKQBFe4pYIglM7o/xST56fFHHKEGWAUvIMHMCRD36G5hlH4lXO6ViMmn15EjMEBHqgKCwgXKFBK7v0pOBryvS9K5cBxqAVs3Cw==
Received: from BL1PR13CA0092.namprd13.prod.outlook.com (2603:10b6:208:2b9::7)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 21:13:04 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::9c) by BL1PR13CA0092.outlook.office365.com
 (2603:10b6:208:2b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 23 May 2025 21:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 21:13:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 May
 2025 14:12:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 23 May 2025 14:12:54 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 23 May 2025 14:12:53 -0700
Date: Fri, 23 May 2025 14:12:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 7885871a-b579-479d-6157-08dd9a3e9af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n1eE7GrIgKibW9jXBxH/GR8OLIfTCzTd2n57pidFOpzTCrej+jCk7XYhTkxH?=
 =?us-ascii?Q?86sZrXbWMd0bHxtySjPh81fRf+pHgGbE1x+Al3SIwQEmFj7qvlKR8I297VuI?=
 =?us-ascii?Q?FsSvBCp4lfllTkA0T7UbwNtqQDWSfWPmLdDK5PTKZ4mpN4NT5fx7k/rgvZua?=
 =?us-ascii?Q?0VvaYDshKnCHgBS8iA/wlgWq8BeiL1qljOEGn4VnnQ/wP6CAwaVrQkF4v7Dl?=
 =?us-ascii?Q?R5COczUkYagGA+k/fMG3byjE7fMSe0RRUF3g01gIqwuQGtieReJgfclNtpk3?=
 =?us-ascii?Q?Fry7mfyCdoH33tYtLi7XbpPr4WzvXZ9IwtfgPrkqXketrdna6G28u9fF71rB?=
 =?us-ascii?Q?RVz9eNs99niMsezswOL+s7ADBwe0Wvb9N3/np/4YbOfmZk30GN8UZrDTWyBo?=
 =?us-ascii?Q?0Hs8a7klAsDzoXbGd4N0f8/K/zl/aYx3uAw3iEZ3tujauHE6TBnOtrHXC/Bu?=
 =?us-ascii?Q?kw5wNFGz+queZj2hA/gVbaDZ982+3ftEDaX4Xu3gdHxOwTVvB5z5sNATm/P7?=
 =?us-ascii?Q?aCWgOTJk83FVKyxHLn+UKjF8ysjtM8Yq6dx7JHoQo3TvqiXhNOPJQQH6YprE?=
 =?us-ascii?Q?7N8wwWPq8IwDkLf/dLBPhwjYlDcaCKeUGYWNvLoQXtRlKqnDRfWW5FcJ56A9?=
 =?us-ascii?Q?mm/wmXYyKFI/8qCSmiya2f2bvy23McK3dPI4rKPFGE2qnP/ZUNuqvwOHjZCT?=
 =?us-ascii?Q?ZSpa0p1qwKRj4skGjuj1n0SH4iz2Aw7f0B3tsEuvv9Bn3GuYWVjr7mk/AHoy?=
 =?us-ascii?Q?Y6yVbWCh0cMPkysShHiKDSqV4sTsgOHeaOTAdhVwEtesdhu31BYwl5fAbgEA?=
 =?us-ascii?Q?uXB08y+84X9iaonqdvoSP1zRyPoQ0zluFRTEBecZI8lzgUPKamR6U91uEUXV?=
 =?us-ascii?Q?tANu8y9vOjIHQ4pU+LRF/KyQgEpZcyCr2GSwNSBNUlqYc8KdOrwB0nsAXD8C?=
 =?us-ascii?Q?uD+EWxNoW0Tuuiow+tD/JZgnnYpX9Qv01L2FiGXMGiB/0Zo6Wje19A/7x5Nq?=
 =?us-ascii?Q?XPXi+v8zK6VdjcNiqDVxWyZuL6hvVZkumy3xI6UC5SU5wJa5tYoURIkw8h52?=
 =?us-ascii?Q?7XeJID6zD0ZunNBhPQl4aOy4VsJD+7JiNg+mLwvkJVYH61xSWD6cjm4bYN9g?=
 =?us-ascii?Q?PQsTydlkVrb6cmNpWt5X7sBevhHzeFuNShujRaQPQR/Q0s9f5a0j6rIeAcVY?=
 =?us-ascii?Q?5ulq/ui+dTtirJBdjTiFJm6YpxhrmDzLaFwNsAT1Y7aALkCRZLq/je1PRkWZ?=
 =?us-ascii?Q?U++cKtwxmOllHRbJOM09n4YPRZqdQ3gBEU1ZCcfkZdhtBa2GMRlOwt4zFN2h?=
 =?us-ascii?Q?jBrzJ6l6JclfPJrrg7NUc8g6xMuGe2iIRk6qRLp1Giq3tXfaDSYpK94qY/Bk?=
 =?us-ascii?Q?+dsXbD4TQxEZtocFXR/ojR+p+kAZmdFsR3/hgyW2kxqg1j7+cSznpHW7KP3S?=
 =?us-ascii?Q?tTrMsI4SsIOr5bPb9HDEc/ueWisPI6I115gb8LceywIGZutbq5p39Hifa1Qx?=
 =?us-ascii?Q?pxLmpzpUjfqUWpw8/Ih5D/CAvrMMOcZgJgja?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 21:13:03.3027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7885871a-b579-479d-6157-08dd9a3e9af7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
Received-SPF: permerror client-ip=40.107.212.76;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hey,

Thanks for the reply.

Just want to say that I am asking a lot to understand why VT-d is
different than ARM, so as to decide whether ARM should follow VT-d
implementing a separate listener or just use the VFIO listener.

On Fri, May 23, 2025 at 02:22:15PM +0800, Yi Liu wrote:
> Hey Nic,
> 
> On 2025/5/22 06:49, Nicolin Chen wrote:
> > On Wed, May 21, 2025 at 07:14:45PM +0800, Zhenzhong Duan wrote:
> > > +static const MemoryListener iommufd_s2domain_memory_listener = {
> > > +    .name = "iommufd_s2domain",
> > > +    .priority = 1000,
> > > +    .region_add = iommufd_listener_region_add_s2domain,
> > > +    .region_del = iommufd_listener_region_del_s2domain,
> > > +};
> > 
> > Would you mind elaborating When and how vtd does all S2 mappings?
> > 
> > On ARM, the default vfio_memory_listener could capture the entire
> > guest RAM and add to the address space. So what we do is basically
> > reusing the vfio_memory_listener:
> > https://lore.kernel.org/qemu-devel/20250311141045.66620-13-shameerali.kolothum.thodi@huawei.com/
> 
> in concept yes, all the guest ram. but due to an errata, we need
> to skip the RO mappings.

Mind elaborating what are RO mappings? Can those be possible within
the range of the RAM?

> > The thing is that when a VFIO device is attached to the container
> > upon a nesting configuration, the ->get_address_space op should
> > return the system address space as S1 nested HWPT isn't allocated
> > yet. Then all the iommu as routines in vfio_listener_region_add()
> > would be skipped, ending up with mapping the guest RAM in S2 HWPT
> > correctly. Not until the S1 nested HWPT is allocated by the guest
> > OS (after guest boots), can the ->get_address_space op return the
> > iommu address space.
> 
> This seems a bit different between ARM and VT-d emulation. The VT-d
> emulation code returns the iommu address space regardless of what
> translation mode guest configured. But the MR of the address space
> has two overlapped subregions, one is nodmar, another one is iommu.
> As the naming shows, the nodmar is aliased to the system MR.

OK. But why two overlapped subregions v.s. two separate two ASs?

> And before
> the guest enables iommu and set PGTT to a non-PT mode (e.g. S1 or S2),
> the effective MR alias is the nodmar, hence the mapping this address
> space holds are the GPA mappings in the beginning.

I think this is same on ARM, where get_address_space() may return
system address space. And for VT-d, it actually returns the range
of the system address space (just though a sub MR of an iommu AS),
right? 

> If guest set PGTT to S2,
> then the iommu MR is enabled, hence the mapping is gIOVA mappings
> accordingly. So in VT-d emulation, the address space switch is more the MR
> alias switching.

Zhenzhong said that there is no shadow page table for the nesting
setup, i.e. gIOVA=>gPA mappings are entirely done by the guest OS.

Then, why does VT-d need to switch to the iommu MR here?

> In this series, we mainly want to support S1 translation type for guest.
> And it is based on nested translation, which needs a S2 domain that holds
> the GPA mappings. Besides S1 translation type, PT is also supported. Both
> the two types need a S2 domain which already holds GPA mappings. So we have
> this internal listener.

Hmm, the reasoning to the last "so" doesn't sound enough. The VFIO
listener could do the same...

> Also, we want to skip RO mappings on S2, so that's
> another reason for it.  @Zhenzhong, perhaps, it can be described in the
> commit message why an internal listener is introduced.

OK. I think that can be a good reason to have an internal listener,
only if VFIO can't skip the RO mappings.

> > So the second question is:
> > Does vtd have to own this iommufd_s2domain_memory_listener? IOW,
> 
> yes based on the current design. when guest GPTT==PT, attach device
> to S2 hwpt, when it goes to S1, then attach it to a S1 hwpt whose
> parent is the aforementioned S2 hwpt. This S2 hwpt is always there
> for use.

ARM is doing the same thing. And the exact point "this S2 hwpt is
always there for use" has been telling me that the device can just
stay at the S2 address space (system), since the guest kernel will
take care of the S1 address space (iommu).

Overall, the questions here have been two-fold:

1.Why does VT-d need an internal listener?

  I can see the (only) reason is for the RO mappings.

  Yet, Is there anything that we can do to the VFIO listener to
  bypass these RO mappings?

2.Why not return the system AS all the time when nesting is on?
  Why switch to the iommu AS when device attaches to S1 HWPT?

  For ARM, MSI requires a translation so it has to; but MSI on
  VT-d doesn't. So, I couldn't see why VT-d needs to return the
  iommu AS via get_address_space().

  However, combining the question-1, my gut feeling is that, VT-d
  needs to skip RO mappings for errata, while the VFIO listener
  can't do that. So, VT-d has to create its own listener. And to
  avoid duplicated mappings on the same address space, it has to
  bypass the VFIO listener by working it around with an IOMMU AS.
  Is this correct?

Thanks
Nic

