Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF82D43350
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 03:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTtQP-0002d0-71; Thu, 11 Dec 2025 22:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vTtQM-0002b3-Mc
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 22:02:30 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vTtQK-00087L-G7
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 22:02:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilnE5Xc4Y+PbgdG5+dj0nf7PxjNZkzEK5mtKFa34aMgCEh9pBRElzAH4pvrH4JEr1JLi5hS6OVXQoJhOvzsHgokJ5VgtFehIsHG6x9auf67dX1EdfQ3InkBot5JmeR76JeedAENqyjCj5dObtBL3xhR/S1mv3FgSGWUSo8dFnL+am8X7slNdVQTwEvdXu9UE7X5d0X3ZoDtLvZmlq0DTQkc06NLNK+Bsc4lgryzYSD1q6WjC+KITIPKzUWLd8icTK8+THCCBvNfch+TD6QMpl1C0TVIj9V2wmJCGlFlGFBnGFgnx/b5nnD/3BddtpVr2fTq5atghXCgSaJvYRCCGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucoV+M+VpgtCiZ10/g6s2WpKQCAEy4WhUNChNaWgm+E=;
 b=LmHonOP//codiVAUT8Irmac2YqqkmrQGK/sayjkJLFadcVbDBl2ThCagLjdxzb5fTLMDhy6hbnPO//7DgJPU5jfY2FoF8PVvcK1uoFqyQViMv+5pscVO/mnsb85p7HqoapqY0t0EwoJFIJCAjN/FqPa4CJez+VXSK9k5Oe5nkDBDtbq5uCt8NvMyJcIJLBqZc0o71Njh/SjhzHNfyvtuGAcUy2mbZ88LlEUFLFIhocZ/q7UuZIXwLUEJdirmFcOCGACkNROPHWJPopQUSaWhGGb/mbnSS1xv7/L7AVpFPi2eQBqWmlHjmgRCmK/+cIVojaDK/mEs5OdgAyRfO0Va+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucoV+M+VpgtCiZ10/g6s2WpKQCAEy4WhUNChNaWgm+E=;
 b=ajJ0lCXsIcaAvd9cdjrFx0eGkDIjT2dl8c966PGC0Ebnme2qMtDOHUoG7PwJL15XPu3j+8OY2HL5Bk+5NUHsx/FyICE/vJsqnk/B0eecdUg/RmfDqjNT2TB43rFlOa5G297O9/7c1700lmtLUjO26j0pffWWwybHbO7zVoX3dU758vbSqIY41oBn+g/3VgSv1cNsKP27uYyGTRt/fK/O8bl8Ych/YFP3kMHi3hozQaVWD3iblivx/VzbyUTN52oCUAYWlIf1hiZI3n3DPqjl1pfEiccAsYxwuZ9zumdj9kq2HRxWs/blD9ux7XjYMXZC4QKsFq0USaNzVD93dhnrcw==
Received: from BY3PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:39b::17)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 03:02:21 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::79) by BY3PR05CA0042.outlook.office365.com
 (2603:10b6:a03:39b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.5 via Frontend Transport; Fri,
 12 Dec 2025 03:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 12 Dec 2025 03:02:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 19:02:07 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 19:02:06 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Dec 2025 19:02:03 -0800
Date: Thu, 11 Dec 2025 19:02:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>
Subject: Re: [PATCH v8 13/23] intel_iommu_accel: Bind/unbind guest page table
 to host
Message-ID: <aTuFqNlluD5fQw4A@nvidia.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-14-zhenzhong.duan@intel.com>
 <52703428-96c5-4b18-b7e8-ccc3c38e2cd2@redhat.com>
 <IA3PR11MB9136F90FE5C93257ABB0772392A1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB913644ED17D8B3698A1CF39992AEA@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB913644ED17D8B3698A1CF39992AEA@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 33448158-e077-43f5-cb37-08de392ade52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oqpTdLIM+lkdzczbeDDXjF4EyGwUQl0nrMYy473Zb8zNMHMpXFQjiluSWydX?=
 =?us-ascii?Q?pNbau/9jFK/Boi2Y28aque6VY3K0Bzo3eFGwMJ7M41n5zQS9DxxI49QbIrAV?=
 =?us-ascii?Q?8XeYDrrBYqLV0DFIGCQxXhn2GkTEMFCrmh2qjA2noaVRRneBMc83rsqbenX4?=
 =?us-ascii?Q?UPuqOxWinCYgq+N95MfZSjt+BSIONmx0jBgVR+dplmyDHizgdFD9yS4WdbdJ?=
 =?us-ascii?Q?NvaxG5HCIe9Eqd23UKtR/BonG4Q0xt3L+qiIaCNqfLwh2Iw3S+X9eqr0uTNC?=
 =?us-ascii?Q?691aIyyDuJOH1OLpfhD7fFjHv3dlLXHBaRQHM1JPHHq3L/isvaqxS5l3GLvZ?=
 =?us-ascii?Q?rKYkj3rNP0j34OPLNAMSE+/PSoXtk62oHRJe9zgD2lC6e4oSDMjg2Pzk4kQV?=
 =?us-ascii?Q?wmwZctymBNuHVk0uzflrdkHMMkDeP8qspoqmvVwQP2Vdxw7DZHSabYpK5Z3g?=
 =?us-ascii?Q?eMiXc6xH5QU9d3fu23d0IyobP00Bb71GBq0CFREgch8L4Lmc3s5LMvJOmc08?=
 =?us-ascii?Q?fRf8/h0iH7qMpjNCfL2qC5FnVforXjp7qc2yR8qs9YUfLDdtv9zWg1SGWpTy?=
 =?us-ascii?Q?WlAu2VGrcq8+bEFjF6+OMjos8vwM2bL1hbCwERUlK1+Y/r3E3i05AjZzeAoA?=
 =?us-ascii?Q?Uop3YL7bGKGw7gT+l9+YxOynGHGrY/SeqtXbaiI6WvH7wVKIEfP166qgjCOq?=
 =?us-ascii?Q?ZI51KqPacbQZOzjXfLP0DGvVLR7TmTdVCwK8vZDtTGa70s9mt8uC3wOnahmw?=
 =?us-ascii?Q?SbE0/zWMmuJ302FVNJgmQUf5BcrFHVtJvvpW/MHCTWkv9zznMrnS3rW7EInX?=
 =?us-ascii?Q?JjVcwkTU0bcK1Mwa+d0zKlwbXmqlExS39pq1niYEutmix9p/x0DYCAxBvf6G?=
 =?us-ascii?Q?fnOBIVLmZqa22Kc2xNU0qFoAYjFIKUTEryQlOf3hXbqbowZ75LPjTtT9eIch?=
 =?us-ascii?Q?AatdXjx7dnVUPGTm9xtcIE+aU3sj/t8oLGlFXSpQkyNQocsdXIfm0BnV/EBy?=
 =?us-ascii?Q?c0KjaPVCPMLi+OfFg+E2P0dNBxiqBYqOSd46yWo7Fm4kGefCAtWdNSxNSuXo?=
 =?us-ascii?Q?7eYctGHZNheKowmq2Oo1dp7R7mWtnbyoll89ojG280HUCmS1WYjUEf5h2c0I?=
 =?us-ascii?Q?2GH34GPdODsyC0q9z2oMWYiOyxLH8cIJMXyrrbmaDHCJIGttEoieFfBYIsZe?=
 =?us-ascii?Q?bHYI45b1h15tpTDFPrqhTGOIFU1r72+TiqFsSPEMT5LshvgE1PeGwtZsIM3C?=
 =?us-ascii?Q?o7Dc/TS5uq0w1GBPDiVBAEmR0N/DFxqreFe1KeWX8axqsechAnhGxNjesBXk?=
 =?us-ascii?Q?2cEeBg5HyVvpxbJrqbwJPtm1sJHm+s9p0sFLk3J1WIv4pgfMg6Rg+kmv21Uw?=
 =?us-ascii?Q?i0vl30crlCgrOEp7x/Nw/Q7i+TZO1X0d3XHo3plzHERFQbe0aU9A0AIQe9vt?=
 =?us-ascii?Q?X63G2W1tiUBF60UXSoTQWZw2IIylRvgX9daxuyN+y3DtF2mLFgt2VOcHwiHB?=
 =?us-ascii?Q?ZiQJ4vq7pAQYLqoNCOdhZyLdlkHsFSDAmQZY5G26SrQdZa9uL7qMSV7dIlF+?=
 =?us-ascii?Q?F/4QEvXBNxLHh+pEceU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 03:02:21.3150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33448158-e077-43f5-cb37-08de392ade52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
Received-SPF: softfail client-ip=2a01:111:f403:c10d::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

On Fri, Dec 12, 2025 at 02:12:09AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >>> +static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD
> >*idev,
> >>> +                                    VTDAddressSpace *vtd_as)
> >>> +{
> >>> +    if (!vtd_as->fs_hwpt) {
> >>> +        return;
> >>> +    }
> >>> +    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt);
> >>> +    vtd_as->fs_hwpt = 0;
> >>is it a valid assumption a valid ID cannot be null? Is it documented
> >>somewhere?
> >
> >I didn't find it in uAPI doc, but it's hard coded in kernel:
> >
> >xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
> >
> >Hi @jasowang@redhat.com, @nicolinc@nvidia.com do you have a guideline
> >on this?
> >Could I take zero id reserved?
> 
> Sorry, typo error, I meant to @Jason Gunthorpe

It is not documented in uAPI but there is some implication that
ID=0 is restricted from being an actual object ID:
 297 /**
 298  * enum iommufd_option - ioctl(IOMMU_OPTION_RLIMIT_MODE) and
 299  *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
 300  * @IOMMU_OPTION_RLIMIT_MODE:
 301  *    Change how RLIMIT_MEMLOCK accounting works. The caller must have privilege
 302  *    to invoke this. Value 0 (default) is user based accounting, 1 uses process
 303  *    based accounting. Global option, object_id must be 0

So, I think that it'd be easier for user space to follow, if we
add a line of statement:
-----------------------------------------------------------------
diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index f1c4d21e5c5e..c250a9eafdd5 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -135,6 +135,8 @@ Following IOMMUFD objects are exposed to userspace:
   HW QUEUE, the VMM must request a pair of mmap info (offset/length) and pass in
   exactly to an mmap syscall via its offset and length arguments.
 
+Each object must be allocated via uAPI and returned with a non-zero ID.
+
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
 The diagrams below show relationships between user-visible objects and kernel
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ce775fbbae94..4410f0561034 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -311,6 +311,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	}
 
 	init_rwsem(&ictx->ioas_creation_lock);
+	/* ID=0 is reserved for global use in uAPI */
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
 	ictx->file = filp;
-----------------------------------------------------------------

Jason?

Thanks
Nicolin

