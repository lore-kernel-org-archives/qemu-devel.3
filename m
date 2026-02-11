Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1C0ECD6D2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqEDc-00018V-D1; Wed, 11 Feb 2026 12:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqEDY-00017v-37
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:41:36 -0500
Received: from mail-northcentralusazon11012002.outbound.protection.outlook.com
 ([40.107.200.2] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqEDW-0004r2-1Y
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:41:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adorZiqgQVw6CZNPrrCCka7QLXte7sObViysILnTsetQemh6dWAhYR6X7/BcaATNS7qm/bXQxGKvaBOU4Pvcm9ZkKY7Ib3wgrZ+7D/lPt38abZGlZICe2PiTJkwtdcpMWD6QoQYK13zyGkZl1wDOdTpPSCVMWbRgQLqPTj5RvmK736HcKag9ohn8sJMY8Xbzs6o4+ylgu9B+qHxVtbC3qx30xk8h/5QSmpHBm2ZnlprRFX84GD6hHl/99Wg5v7kFfhK9lwoIRLMK451XW37c3ZBTniQef0WFldhmwPGa7pf+Af3WN0eVmPmJYoaMLikeHtCmLDCuG7SNNRKYqFftSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8t3sYdp8gkVSfnWZLmLGJlAuq1JCBBO9JCCrmM5GKw=;
 b=SFERHan5BMcu8QUxC1sLY8pffdlff61Fb7gAahKyLrgszfUHRqFkV9lKJtQ697TsE041RojvATb44zqNXI4SkO91eWrF8dwZEAbC5ca4563zw2B09Nfwzm9MCubOz90GOIoT/gNSVj1vXz+gcMdVjeNqPg/ow7tkYeVDYWjEaBKiVQjc/RhV3iP9O/KT55UEb/8eIVRkJm8u5eWPmVbJtirinPghp67U7cUFtBt+dU32Up+kJYNT2Yir07oMwZAQAz/i41oJYnbG+q40lD3is3VVnXhkRu8Bph5GI9JFFC7UXlKKK47bpEGQViw22sCWKt4pZBZi5FStSB077NeZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8t3sYdp8gkVSfnWZLmLGJlAuq1JCBBO9JCCrmM5GKw=;
 b=i1Zqtvvc8gl6/twqPyq3m9EB+VN6Q6bXtxPUrt+qjW1tQODr3WhAoKNQepCcGeoBSVZX5/fz5o+Knzj0Lz1RwJ/BEY/9QFnoiNw2l1THTasps2zf8xEmr67U6i0qdmmah5WZFSaFSR5uHjAWqSQlttnRbnHw5ZU5arOM6Vi249hjMYoiYNguOHxTZ0RXJar+4lHT/7l3UXDxcG0pFkwnopAZmCmhkjw5sSGv05vK5cWa0kuy407rnlhmigFRe8tVyZYeTPNGkmpp/CRAdwx8vYQlwuxDj8/YVvV0y9Gc2KuUFxv7F3Drx3l25zPtrUt6E1prJZcWENmjMhO4/069nw==
Received: from BL1PR13CA0282.namprd13.prod.outlook.com (2603:10b6:208:2bc::17)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 17:36:25 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::b0) by BL1PR13CA0282.outlook.office365.com
 (2603:10b6:208:2bc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 17:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 17:36:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 09:36:03 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 09:36:02 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 09:36:01 -0800
Date: Wed, 11 Feb 2026 09:36:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex@shazbot.org" <alex@shazbot.org>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>
Subject: Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Message-ID: <aYy+AENRSGdWh0Ij@Asurada-Nvidia>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-2-zhenzhong.duan@intel.com>
 <CH3PR12MB754856C12CAD98891555C791AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB91367D6A321018EE989FA1899263A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75482AF23DD73B2D37742AFDAB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75482AF23DD73B2D37742AFDAB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: d64d4c68-40bb-4611-a76b-08de699414c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E7esXxpnOXpV2D2ndyGizcpSDhpg+Zmu7zXOVwM+tPXGB1wGHJmmqdTKVML4?=
 =?us-ascii?Q?O4GKuq5ujCzKuDJ4EGmjh2PtX5hs96FuqAVJOAtSfyW1ItYdG/GaUSKkKiay?=
 =?us-ascii?Q?M7/BWoSPSUOTuxOdux5CTn8yOC8czz7vnBt6ABpkbV01f/G2vrn94EWMwUOu?=
 =?us-ascii?Q?YMsjpddwXIsGNl4XEelk0QPGWV9Gm0rL6wEXIe0UNhBUndRa3ovAVe9wV/2n?=
 =?us-ascii?Q?Mf319kJvOIDMJcgGQa9V5C0H04LuaGCZiaGkuKEuS49tY2hcx2BaQWDzrR/Y?=
 =?us-ascii?Q?Mr/omuKJY5rp3enufK+SOLrDH4lI2L4s5Vks5oagrTPYr0pQghcdNntY/tFi?=
 =?us-ascii?Q?v7b60eRnoxAh1sYs63RNhY+Oq6lSdTRzYAhyl544zix2/+DDE05HXTckYm3h?=
 =?us-ascii?Q?r1vX21hiZW1KytCr03lS+W51tLbpuaspQkDtsZNad/tpc8i1pDyMg/e3y4ku?=
 =?us-ascii?Q?n4jxGhFGwApgLe09HKWOGcT6EIonmzqulcOY4I785NK2Mc4dmWKYUZ5Vbt0v?=
 =?us-ascii?Q?JGzuPy1v1kjUpTKv/zW77j8BWn8rJ2RB7yC+J04VULmbBl3JHvHRxRI0NYpO?=
 =?us-ascii?Q?1wSl38iyanddQn94XkHC133T35qgY6J5SEONX6nKON7LjQLHueRnR+s5pFlU?=
 =?us-ascii?Q?HH4kgVFKl/6IHN25fGHpHCpy+lhD8Z37iVHtkaYZuVCJOdPwSBdaEUGy9x1J?=
 =?us-ascii?Q?qZ8lGmRi6/wZteOnSmtpFjrxyWUhLgKYgqwBIw/Tr7Z740LjXpUAEFShHoBp?=
 =?us-ascii?Q?qZww9eKzO0RWfg4yXsL0DKQS5UkkfENa+skhAZGaYUCgrG3ZYlv03OTGo6/8?=
 =?us-ascii?Q?U4h1hq34cxdEkTv5iZNRsJu6geYXOMY5FYajHEZy43iQHhpam2pUIEWeHPYR?=
 =?us-ascii?Q?W+Omh7DE3js9J3VnGoUyoIINPbPk+d433UrJGVW13s1oeen6uIa76HhgFLFo?=
 =?us-ascii?Q?NhjrKUMm5qLKRIbs96T2Kczu4OrwWZbtzEnN80MnjJ0CYdetkC/nr0FFNkbM?=
 =?us-ascii?Q?akvoWdTWcdigoHOFJa4uC9p1kD2zke3xk4LNSfiiyXg9JHtNTavc71c+Iu9k?=
 =?us-ascii?Q?PYFXR64eGHTXzSdy/oSeMnVW0M4nmUx4PsuSukEkX+LiO2OcbDN+GxovEDy1?=
 =?us-ascii?Q?FAIhb+b+i3XElOLme8DX3K4fjavw2SwZzScCX2piUY9J/LuHQyFhM4BjBn9j?=
 =?us-ascii?Q?c9dgAgax5HmH/TBJqxkSMvDbMArE9K96vIayl0aUMpcFgCp2zhvptevwg4w3?=
 =?us-ascii?Q?xaVZ9HsVYMXUzpQay1dZDLm8GTxWy68JQGGw+vOGt3e3zWsaJPEaNSEp+otn?=
 =?us-ascii?Q?5wzolaP5kkuw+G5kp7Ib9MU0aGux+p1h4lM//88BKU93qiQR/+hjwmBkl74J?=
 =?us-ascii?Q?v4xV6py7qezNLPDmw7mV6bMPy5sXHP+CzjZkUpxL0W2wJxR0eGx1Qo0qneSp?=
 =?us-ascii?Q?gT6uO+X/6gXHpz6j6bMZUe0wxjD0ud5TllJJ/8x0DqSt1Bro5gZdDI9lb7ur?=
 =?us-ascii?Q?aSMAq1wtGu3mI0DmWQKk/6Yh9e8d0Hho6kUo89QmJ9jy0/bbLz7ofRJSgq3e?=
 =?us-ascii?Q?SRCP4elRBa9PtS4Hpkzck6CG7ru3XU91R0amrVgnpHGjmUkVqlpBoRshSq/i?=
 =?us-ascii?Q?0LfWq2rs8n44wjrfmufLKarEnIsnmusodEwhK38vKB5ksSZbmex2LKDgTHDo?=
 =?us-ascii?Q?OmNlsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RE3xGCuPTXO2eJ/ENAEDa3T1F9S51ydbnrbZbkRQyzf5clhHqdlCcFNBSywfAKs3l0SP74MOtxbe+WUg46ohF/C50niuMU0SKNFUbJn4KRnoM33+LX9it2lTzX0AfYuP4fFeefuRxHUMmFp7PetvYa+m2cOZJ4o1xQwMqDSJeeTRVz0upSv8m7fnRc/7jQUXkBQ0bv0idm7eBtJqA78Yt5kGABiZKc7k6NVsPtq/tdHccV+a7n6QxIjexYmEjH4/tdrpOSf33TlQcU8j8qu7d4DF4AW3k9nmt+y/b+MEb3OWa+/BbEosSD6MZkOd+gZkPKCsGGX9Zy3lmZ+w17tLsM4KRc3VlYRWDk9m1bjja13cEISHtroebjye8hYF8cHld7uEUY3P9HmB+Avd8ls+b6xJD0rNGqk+VMTsfSZMSk5P75gA6mT/F22mmb7jXgYg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:36:25.6135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64d4c68-40bb-4611-a76b-08de699414c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
Received-SPF: permerror client-ip=40.107.200.2;
 envelope-from=nicolinc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 11, 2026 at 09:14:33AM -0800, Shameer Kolothum Thodi wrote:
> > > Have you considered extending attach_hwpt() to
> > >take a PASID instead of introducing a separate callback?
> > 
> > Yes, I did. To extending attach/detach_hwpt(), we need to add two
> > parameters, "bool has_pasid, uint32_t pasid". E.g.,
> > 
> >     bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev,
> >                                          bool has_pasid, uint32_t pasid,
> >                                          uint32_t hwpt_id, Error **errp);

The RID attach/detach could be just pasid=IOMMU_NO_PASID without
that "has_pasid"?

> > and refactor iommufd_cdev_attach/detach_ioas_hwpt() a bit.
> > 
> > I'm fine either way, two separate callbacks just look cleaner for me.
> > Let me know if extending is preferred.
> 
> Since PASID attach/detach is essentially an extension of the existing
> attach/detach flow, I would prefer extending the current callbacks.
> I think that keeps the interface simpler and avoids code duplication.

+1

Nicolin

