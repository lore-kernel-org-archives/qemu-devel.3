Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF75C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 06:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2tA-0006l5-Rz; Mon, 16 Jun 2025 02:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2sp-0006dP-7g
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:59:51 -0400
Received: from mail-bn8nam12on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2418::616]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2sm-0000tW-N0
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioUTHIVCNgiFuYW/8fTIiV95X7bUwYhQhIaTTAjLCaGpsQ3OoEuCRNieiqRk8gLWOwuuCbmOJH6AhoQJv0MBmmf79TMWOtyK+rf1MlMnONdBRtP1Za0WP18nKcX5eZ+pdEwTHnGDwxOy6P365ofHJNhSIhI229RSxznhcVsLEp4+BkMWanjMsbqlKRvKAzoACxfcZ6lef2R+ORiqTHegV9dXMufpCdhtonbAvhnOCTEBGRaqqu/S3PPdwEUKcyDjMc5y54uk7cnWxs2YPG+JAUA38FRkIPSeOglKlOLWUFotwVZlkFK26myZP2WAgy4yUHYZTR/jy3SVN0u9hshagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oo20qxqSy072qUarQa4j8BS4FAxPqM9Y+KQSvnzmt8=;
 b=dHOALMymvwsxuni4yQ6xJ1hnIJDc3NtGRqrtFed0/hOkX6Uws2c+gJWPKEY6B+tWu1dSG7zmXBW1tfqW7luoX5H0cgwO+8mLA4r6unNtnY7Lqk8dHHD2oPppBSf0FhvXXTXagNbpHBlL3Ji+ZOxeOGcoEUusb51REiurCY7Ptbos6Xfn1vFPWOtAIlqkTXzvebXr/eTle/aVznN++ug601+L9B3RjfZ7Vi2Q3xwdBk/grXg2tudp32SHSGWWWgvsKO98JzAQh1T69TQWhKZRdfEXL60iSe4WdJE/N80PH1MJCPRo11/DuVoTOQ7sVHLCxeQxuJ77Fyko1LDhXrbFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oo20qxqSy072qUarQa4j8BS4FAxPqM9Y+KQSvnzmt8=;
 b=ePslmX+56ueXuuE6Vype0XOuN3tJzH43kwBLVl7BujOjpg3ueo21DCc7tHmmyJYlG3fyT8f0ADw5Ccw+3f1f2RnuyV5bVBiy4d31vH3hwBET/vGzEOxWil4G8UAcqa+A9OZipQ/Rq1WfQ30/3qNRbgYQqsb1ssCWX/tGfgsrQ2m3LSYhSI3ZFjnKPMgsTusGlbuCr9qT2Q6yWEtK6WDjtO2tTnjPw/myFN8d7aCbRyya+RyyDKTqmylO7G4hUQvoKjxnzISf4kTQ1UhQKLGcTdeB49U7HFm0c7sOoyfd5jPVeKz9T6eHaytJp+ydR284Hn8awfIEsjkxUKFPGinlKw==
Received: from BL1PR13CA0393.namprd13.prod.outlook.com (2603:10b6:208:2c2::8)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 16 Jun
 2025 05:59:42 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::34) by BL1PR13CA0393.outlook.office365.com
 (2603:10b6:208:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 05:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:59:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:59:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:59:30 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:59:26 -0700
Date: Sun, 15 Jun 2025 22:59:24 -0700
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
Message-ID: <aE+yvI2clKEZyoyz@nvidia.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: b89783dc-4e31-47a3-0be3-08ddac9afcce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mDVmHsteu5YnXtBp6iMuUPZ7cfiCObt1le/PZm3Dvr5yGWnPoo+0d+MUXWQ6?=
 =?us-ascii?Q?oK/vUQD7E4fxv+tLKvGsfbGB34dtJiyWaiBA7b+Hfu3Vh23bkk8Cz6/Lem+T?=
 =?us-ascii?Q?kO7yWwjZxyYPImPzTpBtduD9aH7us3GfGoFRpMAfGrPlVIXIUxbKbPTUDo0k?=
 =?us-ascii?Q?0WPYIZXYgRX9kLmTTa7fIVLgbujnoBJ2AJBbcgKiltR5tSaEGs8pdNCUSXPd?=
 =?us-ascii?Q?txsj61jxdNua55uGg0T+tLYJhy3Njj3EJsOAo2vxdi8XzYghO04PLiGUsFrZ?=
 =?us-ascii?Q?bkStcZtGk2SRbAfI8i2GtoorYCyU0OpfNV4/zSrZyrdgrPG840dOTWy5alaH?=
 =?us-ascii?Q?9VbIXo+zEYHkD5Ldf4eLYaWv7w9f3i7NCXqQMmPqjh3+WvdW1EypGmCwLgB0?=
 =?us-ascii?Q?F+9IW1c17ISE5DBLtK3xJMAdPgL2A5sdHSAnKIYultfocODw1GDe5slxQymh?=
 =?us-ascii?Q?SWm6o/mF+cmJXtfUdCVhhBhAXwxztonxh3d8MQaqGap4bn9VCgtrZTHA6S16?=
 =?us-ascii?Q?jMXZvc3UADdtun2eSt3HBOA6YO3/fMEro4lMwOIGloV9Pwni7WByqGXJeQhP?=
 =?us-ascii?Q?L+o0PWB/G671uBQCYp8ywFYGwjHBGOY61u7etANvaw/h59dm4ImjhqhZwKkx?=
 =?us-ascii?Q?I4FMw73Mjuoj2vPUeGcWkGRlq841t13alH8sQRNa3bmsJsak6j2bLxHkgfwU?=
 =?us-ascii?Q?W+YKzdGtwqzQknMsmTzYz6Kogc/aogsPqflc+eMDox6VIUZYcV9bHgFD1yiK?=
 =?us-ascii?Q?xd0ZY5qghv3h5LCJMIG6UVib/AfOM3vdO/CAo/zONLF9roOsyxBR7usG/nRA?=
 =?us-ascii?Q?mHTaUebieSiB0DfQBQ14M42HErl7vX/FoVIVPQl2RcJAP6n/CIixY2qLyY2q?=
 =?us-ascii?Q?kT026/c9OXz4/GkdB7tc0VY7no3/ULtkRWgF7yGD8OQL6XuBzsc6xiWbfeOm?=
 =?us-ascii?Q?d7NDNP9uhjwfdsE8abVTIfm0HsCXAjLahf0tSW8o/cRy7Q/RhelQctXRu0Fi?=
 =?us-ascii?Q?m9iAXys7TQdfghUlZ6LWXaZ0hFSNN4bITwk0HQr0Loq19pkCzYBrsJAPn/mt?=
 =?us-ascii?Q?7famgSNkNxevCm5iNUQuCCE1nuqg62joYjeKse6DTqnfXeVAEaQ2cX4W2zRz?=
 =?us-ascii?Q?DhXxxhHUMl/5W267ROo6PKHGuqbXxvx69jVZQnctM33HKdEJci5gLrG/Zw2W?=
 =?us-ascii?Q?ulLOsLengDvY9zHp+E5yHyyXEyQBqslxRmSBN9UASJ393iqUfgXvbIkPEJEy?=
 =?us-ascii?Q?HgkVWUHWS53qnSBTYhCWsngdUS4ZrqrcMDmmA6ptsN/CykbQ5Y33Enmd4+La?=
 =?us-ascii?Q?HwYsN923L0YWWUjqtwBJrE10wFYSrYdAS9DByI2W/uXUtb/tkG6mLcKowZOC?=
 =?us-ascii?Q?ZHqb+daAYUb/mmzViJbsG2AIO4ELNcUsgnd0PJ3JIkWvEnRIjJEpuLmkriHF?=
 =?us-ascii?Q?vQ/RrINb89UbLzuFsWiqwluR/5BmKc2VGESOJ7U+oYRaJbWVU5BIBqaJQsP0?=
 =?us-ascii?Q?qDq0uQqiac8rvBALq/bINqtlWTuCbHv4g9XY?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:59:42.0834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89783dc-4e31-47a3-0be3-08ddac9afcce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A
Received-SPF: permerror client-ip=2a01:111:f403:2418::616;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Thu, Jun 12, 2025 at 08:53:40PM +0800, Yi Liu wrote:
> > > That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
> > > for passthrough devices, right?
> > 
> > No, even if x-flts=on is configured in QEMU cmdline, that only mean virtual vtd
> > supports stage-1 translation, guest still can choose to run in legacy mode(stage2),
> > e.g., with kernel cmdline intel_iommu=on,sm_off
> > 
> > So before guest run, we don't know which kind of page table either stage1 or stage2
> > for this VFIO device by guest. So we have to use iommu AS to catch stage2's MAP event
> > if guest choose stage2.
> 
> @Zheznzhong, if guest decides to use legacy mode then vIOMMU should switch
> the MRs of the device's AS, hence the IOAS created by VFIO container would
> be switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
> switched to IOMMU MR. So it should be able to support shadowing the guest
> IO page table. Hence, this should not be a problem.
> 
> @Nicolin, I think your major point is making the VFIO container IOAS as a
> GPA IOAS (always return system AS in get_address_space op) and reusing it
> when setting nested translation. Is it? I think it should work if:
> 1) we can let the vfio memory listener filter out the RO pages per vIOMMU's
>    request.

Yes.

> But I don't want the get_address_space op always return system
>    AS as the reason mentioned by Zhenzhong above.

So, you mean the VT-d model would need a runtime notification to
switch the address space of the VFIO ioas?

TBH, I am still unclear how many cases the VT-d model would need
support here :-/

> 2) we can disallow emulated/passthru devices behind the same pcie-pci
>    bridge[1]. For emulated devices, AS should switch to iommu MR, while for
>    passthru devices, it needs the AS stick with the system MR hence be able
>    to keep the VFIO container IOAS as a GPA IOAS. To support this, let AS
>    switch to iommu MR and have a separate GPA IOAS is needed. This separate
>    GPA IOAS can be shared by all the passthru devices.

Yea, ARM is doing in a similar way.

> So basically, we are ok with your idea. But we should decide if it is
> necessary to support the topology in 2). I think this is a general
> question. TBH. I don't have much information to judge if it is valuable.
> Perhaps, let's hear from more people.

I would be okay if VT-d decides to move on with its own listener,
if it turns out to be the relatively better case. But for ARM, I'd
like to see we can reuse the VFIO container IOAS.

Thanks
Nicolin

