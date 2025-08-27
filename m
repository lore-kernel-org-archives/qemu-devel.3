Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1684FCA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEKo-00065R-Lp; Wed, 27 Aug 2025 07:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urBka-00032f-TE
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:43:25 -0400
Received: from mail-bn7nam10on20603.outbound.protection.outlook.com
 ([2a01:111:f403:2009::603]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urBkW-0000ro-Gj
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:43:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezn7eZDFNUPSmSiCJTMJIuiahOMLT3/uKLsOlKnMefa3TsZn2NPfvAYgN0YQmA3TvwBz91GRVM6Zjj71I5yxqW5F49Otqc85mLMXWi2XJwri3gVBuPjThpxtSIuL/m+0NftpQ8flTSwNoY2+i5UljTDGDzDECCsYU0jQbPw1jbAY8LS8CX0oGCPqXlGqEc+Qc/Gp0bwyIhrz1ffRg1MUWfN0ufWdANUaI5WSV79xvJQHGlX9oov01Bu6CpNoh6hxITJdmU+RV/1r9fAz8Fle/08SlaCVG3O4hS8XT7KilUHURq6XyieJLaxmC4AXVqyUI/Uiedoc8sz11Q6PByX2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39Ajd7xeIUl50EV2W033KiR/ZNzxgWn7KwjSYIuGDi4=;
 b=qG35aT6rw1lH7icLrEOxNOS7ImA6MSS50xwtp5DRQMxq7cFzj/nwbadE5aYcUg3ywx84kS5ski6L2UCeA+31lddujJtC30PG3Uzeam88NLB25xYDW45BDrpp8x+xvHKWrbPU+LvtYiVDSAHrdg0NGiRhsM4mS1QYm6bAnKccVG5YitJ6s2RGFNiRSar71z7UX2VnlZXc8iwRfOPjkVzp5wmKi1FX8307d/d+I1x+3tmfI5emOi1rsy54Mw2gUdMhEOq3jMxM+xGBTlncTcC2lxo6I9tZ0ynYgeuxfMwPDiCNJj1uBgRsTQfkTLa11QEq2IJ9hMWKeGODtig9N2zQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39Ajd7xeIUl50EV2W033KiR/ZNzxgWn7KwjSYIuGDi4=;
 b=QegvwXBBRjhTItmype9r9M6dvF6FSn+XN+eLhVXN2a3zL8ngBbYIhG9RKAjYKGnRjtnYDAc5+IN4EQJHZf/jExgAX3tZW+WfRuMob/xXuSUfBxe/igoPWSfUy00rPH5xeLn6dy6W5r1kdVUh8zZqytg97tS8tgIQFnlxXXPzQxFUL8KbiH4pu6rA3H3IA8lCLpJaV50iW1m6vTYs4QUg5TZpowdrjDA9gv0kceAZ8sThgPJtwVd+tYXds87nqYvrjy5wBpNbVO6bSsLDOCXSUd8fKNk0WRPd28Yyv4XHeQFu05AVglfP+rf1muNpg6QJkJpztqyxLUMPwg6yBg/Nmg==
Received: from PH8PR02CA0042.namprd02.prod.outlook.com (2603:10b6:510:2da::31)
 by DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 08:43:10 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:510:2da:cafe::63) by PH8PR02CA0042.outlook.office365.com
 (2603:10b6:510:2da::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.24 via Frontend Transport; Wed,
 27 Aug 2025 08:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 08:43:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 01:42:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 01:42:52 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 01:42:51 -0700
Date: Wed, 27 Aug 2025 01:42:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
Message-ID: <aK7FCqdjVKWtZQmX@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
 <aKkDXiSwWGgio0dM@Asurada-Nvidia>
 <IA3PR11MB913633DE25AD6CF07BF26F8E923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aKyWQ6inC+F7idd0@Asurada-Nvidia>
 <IA3PR11MB913677EF729CF0BD2E3902FF9238A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB913677EF729CF0BD2E3902FF9238A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b68a10b-6269-4d49-6b94-08dde545c091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N6/eMjQ4gTBPrJgmyRdG5VgnJw/5rUWUKMEl9ziwbd/yvW+9jJli8N91akVr?=
 =?us-ascii?Q?WM/jibc39gsw5G6F4BxsRHXwI+7tcItm3GX6xCPnYpROGdc1BNNgULKru2Lk?=
 =?us-ascii?Q?kB8QLm6eL9bjpOaO5oAVnpgfh6IGg0WWnDH+rbGjrNOwxruQJ2f+nwDw1qvs?=
 =?us-ascii?Q?4ksbMpVZzNSjFfIhqHWfbSfB7JqkBomx3it57Gay1T2U5ayHCMaQS9kS6ydi?=
 =?us-ascii?Q?E3EBtQsLGKfZaOPPhwOv/Kkj7u/QIS39h4A917hXq4eQlefeOsva2xYYPKse?=
 =?us-ascii?Q?4Boutp8EgF/pf7RLzFqtDp5BbTnVpGUJp5ocjeP9Ujrgz1hYDr871un58Q6q?=
 =?us-ascii?Q?9cEYu615D7SxEkx0RZnNpKfQeslMPVD3y8N/zlhbs+Wvd5lkYX0mXaVekd9u?=
 =?us-ascii?Q?XTMqk0qTzxem0gEYoo+8y2eAG8zx9nxGvRv0DFBC2m4d5CWlpeqgAgXziJCY?=
 =?us-ascii?Q?mEIL/PN8zV2DUgBEYgndAd0QziDIe+0p+BejuZVw7rx+nMSF+qAnKU4j3uVt?=
 =?us-ascii?Q?62XfnLXFQJGHAcgfTfMyiPOwqKCYXjUNKtcEspyqY7IDAwiQxD20AhQdlu+9?=
 =?us-ascii?Q?OVxjWWbTR7sdAU8lviVkIP9n+YJ0eJa0RDlghlFhcyiVrOLCLKtZlh44BDSl?=
 =?us-ascii?Q?C0zW5nnXrEaQ9Bp4GorjnsWOcGgAozuHrHuTKx9MDj3f6SrrZOl0ot3zcRj8?=
 =?us-ascii?Q?ac1cCCcB8syPPbRMrDrzFlpfYtCLWBu9M+cBH7uwLFgg6rWMXbowJ0Y37Vxf?=
 =?us-ascii?Q?lJ3u7Xhofvq9/CIkkGeT7Crq3iXMTi87JWAoW/CmumJTF0tgTlcgPFQVsqMF?=
 =?us-ascii?Q?VX+GfMfalMBQF1tXpJa/YNRtATiE70UN2+8GzeE0lE8nmyALi2Y1T5PDESvv?=
 =?us-ascii?Q?YulQ4MZBsYQx347V0kRbZyWxShWOUT1ZeQeQBMl2hL1kiM8adnYcq4u0vuOa?=
 =?us-ascii?Q?eUTm8hOzSirCGB4Cpc373GcLXery4xi/iLPhLXisAAWtcEEAfYMyU3IV89ve?=
 =?us-ascii?Q?JjTz9Io87xVgEhiWufw7R9+IokvixYTlXttXk85UolhTxyOGc8lmyZd5ZWPM?=
 =?us-ascii?Q?hWVSZ9MYuYp7LU/4wQy1eKe+nvSUxGDlA+xsPxXXLC0hKYQBiuFAVi4Krdcv?=
 =?us-ascii?Q?JugbhJRAvR5Le8asSe4MsWnXPHjcHel0wAWhZtrz2oP17fDV7yU5awDj4NaE?=
 =?us-ascii?Q?P82OFxxNdA/G7PSwS3ZKAl49x0sJYlOSYK03msS+BolPYeU8/4i7G4j8pwbF?=
 =?us-ascii?Q?0vpBl/5iN/rxSzGE/utU0NgQwO7l8AKSHdyWg65/4ud5A4Ef2Ky96xGuiZ9d?=
 =?us-ascii?Q?I4tYrP8PM+n+5CdTS5dOLLHBvvzTedc0Cg6oF32PFXoppmrXHCI0DLhUStNH?=
 =?us-ascii?Q?nwGEbsRzgHEv7JXZ8GdlBF9ndcoW0BL3nLvnKoEcIuL9TqjhI+RXaQrN4MSO?=
 =?us-ascii?Q?F6ARJcdyM6JyTEXA7IwJ296EbRlqGHHnrEnhPhLdaiVf2TApzXi/6xJj5Neb?=
 =?us-ascii?Q?1B88QLFfs90meYF5fNEa9YbbSvHH1b2XWfPs?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 08:43:10.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b68a10b-6269-4d49-6b94-08dde545c091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
Received-SPF: permerror client-ip=2a01:111:f403:2009::603;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Aug 2025 07:28:55 -0400
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

On Wed, Aug 27, 2025 at 07:11:54AM +0000, Duan, Zhenzhong wrote:
> >> >> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
> >> >> +        container->bcontainer.bypass_ro = true;
> >> >
> >> >This circled back to checking a vendor specific flag in the core..
> >>
> >> I'm not sure if VendorCaps struct wrapper is overprogramming as this
> >> ERRARA is only VTD specific. We still need to check VendorCaps.vtd.flags
> >bit.
> >
> >Look, the HW_INFO call is done by the core.
> >
> >Then, the core needs:
> >  1 HW caps for dirty tracking and PASID
> >  2 IOMMU_HWPT_ALLOC_NEST_PARENT (vIOMMU cap)
> >  3 bcontainer.bypass_ro (vIOMMU workaround)
> 
> Why vIOMMU workaround? ERRATA is from host IOMMU.
> In a heterogeneous environment, some host IOMMUs can have
> this ERRATA while other newer IOMMUs not.

To be fair, the subject of your patch is "Workaround". Though it
might be inaccurate to call it "vIOMMU Workaround", the idea was
to let vendor code decode vendor bits and flags.

Arguably, when a host IOMMU has an erratum while requiring a HW
acceleration like nesting, vIOMMU can be a partner to help apply
the workaround.

> IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 may only exist on old IOMMUs
> with nesting capability, vIOMMU doesn't support nesting emulation yet,
> it's also no sense to emulate an ERRATA in vIOMMU.

Certainly, I never suggest to "emulate an ERRATA".

> >Both 2 and 3 need to get from vIOMMU, while 3 needs VendorCaps.
> >Arguably 2 could do a bit validation using the VendorCaps too.
> >
> >> >Perhaps we could upgrade the get_viommu_cap op and its API:
> >> >
> >> >enum viommu_flags {
> >> >    VIOMMU_FLAG_HW_NESTED = BIT_ULL(0),
> >> >    VIOMMU_FLAG_BYPASS_RO = BIT_ULL(1),
> >> >};
> >> >
> >> >bool vfio_device_get_viommu_flags(VFIODevice *vbasedev, VendorCaps
> >> >*vendor_caps,
> >> >                                  uint64_t *viommu_flags);
> >> >
> >> >Then:
> >> >    if (viommu_flags & VIOMMU_FLAG_BYPASS_RO) {
> >> >        container->bcontainer.bypass_ro = true;
> >> >    }
> >> >...
> >> >    if (viommu_flags & VIOMMU_FLAG_HW_NESTED) {
> >> >        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> >> >    }
> >>
> >> IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 is a VTD specific flag bit
> >> from host IOMMU, we have defined get_viommu_cap() to return pure
> >> vIOMMU capability bits, so no host IOMMU flag bit can be returned
> >> here. See patch2 commit log for the reason.
> >
> >VIOMMU_FLAG_BYPASS_RO is a "pure" vIOMMU flag, not confined to
> >VTD. IOW, if some other vIOMMU has a similar issue, they can use
> >it as well. Since we define a "bypass_ro" in the core bcontainer
> >structure, it makes sense to have a core-level flag for it, v.s.
> >checking the vendor flag in the core.
> 
> It's not a vIOMMU flag but host IOMMU flag except vIOMMU want to emulate that ERRATA.

Again, the idea here is not to blame vIOMMU for every flag, nor
to emulate the erratum, but to use vIOMMU as a vendor specific
place to translate a vendor specific flag (either host IOMMU or
vIOMMU) to something that QEMU core code can understand.

The rule of thumb is to avoid checking vendor flags in the core,
which both Eric and I have noted for a couple of times..

It's okay that you don't like the way of grouping the host flag
with vIOMMU cap. Please find some other place in the vendor zone
to load the vendor flag? Maybe add another op/API to decode the
host IOMMU flags/caps exclusively?

Nicolin

