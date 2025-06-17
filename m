Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1AFC71159
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 03:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRMv2-0002gb-KP; Mon, 16 Jun 2025 23:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uRMv0-0002gL-JY
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 23:23:26 -0400
Received: from mail-co1nam11on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61d]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uRMuy-0006nw-2G
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 23:23:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Av7JO9yXN1DpdDWozqxeAJv1NLYVwoJ72WcWABL6qNaOnQV13fHIfWGT3BV9hXJ9jwCdcLhWzdp6VEUeo7hyK9vvFWemqT1G4pDGL9E/YJgcm40D6N3KfTlUkCSvAh9uVLk15Uo5L/09ZcV+j1RjVlU7Q8wnJ/Bw+sKb132Wx/Sszbt3LdQWXNBkBa9yyesn53UHNudLC8dIuXEnPK0RbrQNlvNNL1ye7anEHdeE4y7MXXkEmKsDHTzTfkh5FUVYpael83m35vYKgxNH+5ZFZ4Admgj3g5vG8ainU/nrHPq4VK/U5mybsof2d4r7jad6Of8bS69L+tSVjz3IzZo+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztSwtwwL8jkkZtgH0zZ6v6OFTPH4Tc/Q78656KJFIj4=;
 b=bHgKCQo2zNd+/Gp+xKnvaRIY9w2AW0kBkFQQ6DVcdFmjLHRzRWZ/NmyMXECbYfABUXE6lzdCxL3RTJfvwlfADzSEaHDeLNw4U76MbCasBLpvaVbwVB2AaMv8cCjHYKxHgvanJWihm1B2dg5nmxL3WByXT/QvPmIiS0ZXdSGqp3ACsxh7rsHu4oao4EiDt3BSJuxKltXWoPMgjW5wqT7SOwy82lNHWWEuOXr4zcp5ddUWOPhJMppSK9va3yNSzyPnBLMiiGCYCHUcKCGVIC+God9WbeqRHPwIITvXBI6fI1QKYJtxJ1b1PXshZvJ27u6ahcEpmq/kGQ57P+hGYP/WxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztSwtwwL8jkkZtgH0zZ6v6OFTPH4Tc/Q78656KJFIj4=;
 b=r4TSDDx4x+RXftzXxcC8FnF0TviqK1FdOTPIHiyiJp/WQmrBDjGrir4qmjNv8tskebOWCkzwvph+msP7ilSFxn/M/x9TNtpqGsXRV0tVmQMIKmnJ8h6jCrAubE5h+3GVHt2+XzBbX65aditpIRnMxuneFZ27kXyUdVGUbi10jA7f0tEi+p5pc4KPKxVma9BTq8SSugfBSceoFw2rPqdJRU+yQSls1yf6bQQfegoR+4QmRFx8wvDVEp4tbHl9PfiySZgmfBZ20mc+UdkjewCdbm8WSP7JD3hsNfnlcUNqq/zDxNbvzUAVmA57C7UBd5hkpV7DqpNSUf3JzgYsOtujhw==
Received: from SJ0PR05CA0176.namprd05.prod.outlook.com (2603:10b6:a03:339::31)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:23:17 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::f2) by SJ0PR05CA0176.outlook.office365.com
 (2603:10b6:a03:339::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 03:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:23:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 20:23:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 20:23:08 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 20:22:51 -0700
Date: Mon, 16 Jun 2025 20:22:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Peter Xu
 <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <aFDfhI0zScBhy01j@nvidia.com>
References: <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <aE+yvI2clKEZyoyz@nvidia.com>
 <6f0cb11d-ab12-4ae1-98d0-eb44bb0a7f4f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6f0cb11d-ab12-4ae1-98d0-eb44bb0a7f4f@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c7dfdf-36e4-4bf4-d8c5-08ddad4e4cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Av06UDdZc3BczPmn/HU/fWKZZnxEbMPrxDg1KwWXvQYLTpTa+7RbZCRLDg2m?=
 =?us-ascii?Q?TsfleNDeezF92kn4pXby5F9iLWQJ6MykvC5x0wcGDL2a6bCGw+mC+JhzDSiN?=
 =?us-ascii?Q?qVRiMwGilBTQHc5V+Qs15VhQK50pq9FG+uVf0We9kQzmo28qU7qYzL9qoRK2?=
 =?us-ascii?Q?u8d5Lesf1aMrZoHLzZ8wptVbltC0MciSwyU3Htx6+nXSpWoqGC7KLAZCkbvr?=
 =?us-ascii?Q?YvZt79UiAHj1XlHwOP2tFwbUTToyBtpeGhaxKZyxEDCWMnUOet8Ec3MxKF4X?=
 =?us-ascii?Q?ywrq03VENShkgsziB/q7t7uNsxWMbcD3sjfqqKtAP8KesCvtBBQhJnrmX1uv?=
 =?us-ascii?Q?o1z+MbzscgUzpap3KJjdJ+QjepSwBSEWKxX4geWpIvwP2Vajpe9btXV4Vvx/?=
 =?us-ascii?Q?TrIaNrnUyTipCbpPh1W0wEKdlzo71kAn+wIptGzWKvTUsnbHVMIvJeeNv/W5?=
 =?us-ascii?Q?K+pXRU52g3hG+7FzCgcHABwJER7WsboSm/5ADDsWdzU4W9xvffGyTfYFQ31G?=
 =?us-ascii?Q?dZtuFzkOgabG6V2xHfvoOPjrcx9nkg4FF9zv0H/dWwUWCQc1XKcS5HPIWFGH?=
 =?us-ascii?Q?ySbvuP9ipGT+0ynS8jgZqAi7HhRuBh0fO4+4t/IH50rsTUeNWNTpPsBO46K/?=
 =?us-ascii?Q?FWmZ7OU/z5I3K5BUjb22I/ULgwtIAsPYeA9bIPbPUccBj0TbP9d9IhMIOU2V?=
 =?us-ascii?Q?X1K1XMFzWRgTLq+02byXZiMuPj1RpGr1Sd9GHYaDYiT5njPYLMJKG1USiERH?=
 =?us-ascii?Q?7PJuScqRHLSjWsGRbsToYnmQTKwyXsA4Jz7Jix5PMWhX2l/d3g8/RGbtsPVC?=
 =?us-ascii?Q?UC55Vg2tfr8p7I4iZAk4ARKaQmzCQH+cKw2wVVXVcYos6JAr93CJYbXoqZkC?=
 =?us-ascii?Q?G90Nghix96I+EAQUkuBYx71UutE9aJIPKkmv5e3YEt7LwF/xplkwhK13C2xl?=
 =?us-ascii?Q?6ehAyfMX4Wck1wUhfeJ/dNBs54xb/6+p1T0Whbv3JJVsv3MtLn3g1UKRAAM1?=
 =?us-ascii?Q?JUbgcm9NJj0DBF3k8ApjlAIqmclBM4Nngznd3I8zLrZJJvF9bAAOEz49juE+?=
 =?us-ascii?Q?7r8C55pzsePkAwUR6w0of5Pehhttdz/rzUD75KqvjP/JOM54QvgLdlr97JUF?=
 =?us-ascii?Q?6hxtZGY7/sE4kG8XpTqY3zsMlgh4WEt8vNhOxByONW9I/Umkv4KCj/8gRe5S?=
 =?us-ascii?Q?iHHpW0tOqK7WCEPBskERRrNFugxikHDSvM+Q6wxQ92TYlsmT25E6HyUAiIAu?=
 =?us-ascii?Q?FHo2mpkJmBfYCj+91paYqVg5k9iPgubV4KCI/1YWx/qE/blJFx5h5fBCfusB?=
 =?us-ascii?Q?QelICxUhJATyfux/cFLYDodsRfl7R5Z1Ds9/yvGWMfsv1FyuaHwktmbHQ8Ld?=
 =?us-ascii?Q?li+n28qMP4uB+lfuQfagUvPbL44x40ErqkJXA6ozfWLAW6XPdwxRufgMdfme?=
 =?us-ascii?Q?66bMM9XDpcl9k473Vdf4Y0EK7ZQntxe0uCgm/mXTv9O6VZpLlo08wiCGfSI6?=
 =?us-ascii?Q?J4q+h+ACtljPgU+UoHCuH+qURoAOoiREBoJb?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:23:16.6980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c7dfdf-36e4-4bf4-d8c5-08ddad4e4cff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478
Received-SPF: permerror client-ip=2a01:111:f403:2416::61d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

On Mon, Jun 16, 2025 at 03:38:26PM +0800, Yi Liu wrote:
> On 2025/6/16 13:59, Nicolin Chen wrote:
> > On Thu, Jun 12, 2025 at 08:53:40PM +0800, Yi Liu wrote:
> > > > > That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
> > > > > for passthrough devices, right?
> > > > 
> > > > No, even if x-flts=on is configured in QEMU cmdline, that only mean virtual vtd
> > > > supports stage-1 translation, guest still can choose to run in legacy mode(stage2),
> > > > e.g., with kernel cmdline intel_iommu=on,sm_off
> > > > 
> > > > So before guest run, we don't know which kind of page table either stage1 or stage2
> > > > for this VFIO device by guest. So we have to use iommu AS to catch stage2's MAP event
> > > > if guest choose stage2.
> > > 
> > > @Zheznzhong, if guest decides to use legacy mode then vIOMMU should switch
> > > the MRs of the device's AS, hence the IOAS created by VFIO container would
> > > be switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
> > > switched to IOMMU MR. So it should be able to support shadowing the guest
> > > IO page table. Hence, this should not be a problem.
> > > 
> > > @Nicolin, I think your major point is making the VFIO container IOAS as a
> > > GPA IOAS (always return system AS in get_address_space op) and reusing it
> > > when setting nested translation. Is it? I think it should work if:
> > > 1) we can let the vfio memory listener filter out the RO pages per vIOMMU's
> > >     request.
> > 
> > Yes.
> > 
> > > But I don't want the get_address_space op always return system
> > >     AS as the reason mentioned by Zhenzhong above.
> > 
> > So, you mean the VT-d model would need a runtime notification to
> > switch the address space of the VFIO ioas?
> 
> It's not a notification. It's done by switching AS. Detail can be found
> in vtd_switch_address_space().

OK. I got confused about the "switch", thinking that was about
the get_address_space() call.

> > TBH, I am still unclear how many cases the VT-d model would need
> > support here :-/
> >
> > > 2) we can disallow emulated/passthru devices behind the same pcie-pci
> > >     bridge[1]. For emulated devices, AS should switch to iommu MR, while for
> > >     passthru devices, it needs the AS stick with the system MR hence be able
> > >     to keep the VFIO container IOAS as a GPA IOAS. To support this, let AS
> > >     switch to iommu MR and have a separate GPA IOAS is needed. This separate
> > >     GPA IOAS can be shared by all the passthru devices.
> > 
> > Yea, ARM is doing in a similar way.
> > 
> > > So basically, we are ok with your idea. But we should decide if it is
> > > necessary to support the topology in 2). I think this is a general
> > > question. TBH. I don't have much information to judge if it is valuable.
> > > Perhaps, let's hear from more people.
> > 
> > I would be okay if VT-d decides to move on with its own listener,
> > if it turns out to be the relatively better case. But for ARM, I'd
> > like to see we can reuse the VFIO container IOAS.
> 
> I didn't see a problem so far on this part. Have you seen any?

Probably no functional problem with that internal listener. ARM
could work using one like that as well. The only problem is code
duplication. It's not ideal for everybody to have an internal S2
listener while wasting the VFIO one.

But given that VT-d has more complicated use cases like runtime
guest-level configuration that switches between nesting and non-
nesting modes, perhaps having an internal listener is a better
idea?

Thanks
Nicolin

