Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B12CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 17:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqacU-0007vE-MO; Mon, 25 Aug 2025 13:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uqacR-0007uQ-PQ
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 13:04:32 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com
 ([40.107.223.60] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uqacK-00045u-8P
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 13:04:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlB9z2c1Rm/YB7jp6tWHD/ryTA37iD5hdfF7aVMYerSwvzM5TzS3MUjJDudMmr0rK5/ku0XzLPlQNMHNC/hb5X6RZ7bk/wdvx+OeaLMIYQ+P7aqUsUZLBZxL1xuKyIM0UDGPEhK33PY3KxDZvWVDTKxxx4zGskqdJksDajTMxRk2FeVO3bYqNu3aYTbXEcvxI8eOqRRVgKQQ0sOIpMKUFeqJdxreviisWG+eJdgEjLrxc7pnpV4iuoyz0cP9LdV1RO938z2yabhW/eE6fAPchict7oLyx4IAC/rJ31cktPnACo8RqZ6MJnw3uydDhJxHgW/MgfsvPg5arnhI7mSGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7jrFwe3T4IHVFp3jDf0jONavnIgcVtjGsdwg3Nhg6g=;
 b=epMhEU7urRhXFXO4/Yf4OTf8u2MgCQi0l7/Ip4gLdNwZE6UKNWYgqBEddOejB8PYKBRxitjr80S0g3BtbvNJouBLYn4gUz4PrTP5o71JH4hNPsWocHHHlBPZr5XnRSQoeVIvNsAEtbCfq42fldg5jK+3mI4bQ8hxIzoPUV4J+K6gJRWMkoV37SVEbCHe5tJ1JF0Ryes+p3nZIigANuWZJ/EkNGKhE91LztHD6bvjw+pTIVbix07/BHsg4A4KpoXh4pA4J1fjWe8S4c6XVdhMiELi5t/jY9WQkgywypU8wCicmBFCDIQqipq7CZJjSKHZ7+dHkIr86nQ+DJU3wBtdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7jrFwe3T4IHVFp3jDf0jONavnIgcVtjGsdwg3Nhg6g=;
 b=fBVTDtXH0ezdUnvVmj+E4coq9S+R9m/m9gsHgWiH9xWyGLf0u9SCK0vxFDUZoNh0RUcv8CFv9TBjyKQzAs2fmBrUCxbBIEUSdMHFvZSz4mYdQSKfFXaQxQ5umGMZQCE/4KYJm6AG/+4fyO9/QlYbMvQYE/j/3174u+HdSiMeAEx/ml/ghXfWo0Zye67nu7hHtAKt6TkYX/QFYB8CqUbWsk0w3xSQBS44uPcjYfxl5DJAqZBGbOJnmQljFiS7TvGeEe9Nj67z4QBk5btLnU7wlxxFQ968CkvJG3u+o3Hbl61f40ies7bV6fFeKLibuw4nTJ8HQofFVcwyRCiB8fe4Hw==
Received: from BYAPR08CA0001.namprd08.prod.outlook.com (2603:10b6:a03:100::14)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 16:59:05 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::8a) by BYAPR08CA0001.outlook.office365.com
 (2603:10b6:a03:100::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 16:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 16:59:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 09:58:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 09:58:46 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 09:58:45 -0700
Date: Mon, 25 Aug 2025 09:58:43 -0700
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
Message-ID: <aKyWQ6inC+F7idd0@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
 <aKkDXiSwWGgio0dM@Asurada-Nvidia>
 <IA3PR11MB913633DE25AD6CF07BF26F8E923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB913633DE25AD6CF07BF26F8E923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d1ad33-5cdc-4afc-f6bf-08dde3f8b31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0w3YDId4mY16TKIunlVVl5hPYK7lx1fREItVFP3LVt+owU8ecoaNhY2iXita?=
 =?us-ascii?Q?ymbvZyQiWg93mK61TNexHFDxA5R4hAzdeKkZDQuxX79wqYOPMNppKuluM/6s?=
 =?us-ascii?Q?eJYD5SDY3bURn2fea2qtTZ+ebyIynNaV06UEKR+p0DLzo4BMxPX5Bebjhr7f?=
 =?us-ascii?Q?/JG+xSRXAfMxzYs5voF4rWzFx+DTeafG9LeNUD4vMUs272//gknwUgSmk4CU?=
 =?us-ascii?Q?7NhIzyjKjtqauw7PwfenAmtoeKp3fNrZ55gtGSLhdEe2f2qYfysek+/BKWTl?=
 =?us-ascii?Q?xMLRvg2nKfzyT736IqE7SBI0a8uomxgZA6xw/6Ozm1VMIYeqOaMjowrkW+kq?=
 =?us-ascii?Q?V6xImP6D9szbzaPnVn0cFUOBtDLFRR/7J4JH6KHGMPJ8VQvgh8Cut9Yupvl6?=
 =?us-ascii?Q?5i2mrwK/0SnltWmNeLcxG2QxLe9VZL5inWpjV6ZvEHfFtsFQoFV3SdvpeAsA?=
 =?us-ascii?Q?h8/ILZ9dXipRQqS9zamP4rfz7WrM4KmwNsECuk2AQUvvDlpBUyOrq3BWWf3C?=
 =?us-ascii?Q?Gvgjbxz2twElysfHz5JML2kuBPB4Ovat4YlpFb+4rxIXxPt5sab20ot/mYqg?=
 =?us-ascii?Q?ZID6jr09Y46yHFOBQn23GrXNsR9p4ag8R6LW1lp9B7qdbx1Qic4XRix5Ysk7?=
 =?us-ascii?Q?4LdMo4blX0c8mkNpCFzUar5qItZ9rJt/CQXyMCp6ivo6PcxDFDVIs615dLBE?=
 =?us-ascii?Q?hoRHUN2Fkdn9ZFKLbWB+G3470TEIn4YQ3uDFZYTIuDI0iQEDZccMJqTFYEy+?=
 =?us-ascii?Q?/IWX31JOeuV9H/DhgiRm3V0SpdH47CqL8J5JNNLUkVl99wtXe6K9mwaIsWid?=
 =?us-ascii?Q?QepkfL8bhoqfSEBpQqDdIhZ3/UVf/NLv0r8JL/anI/HBsyU+2M9fy6kqMmHb?=
 =?us-ascii?Q?uPsX1NYU+TUZsEj4eFF9fsscELeEuf4uibRn5lykfKJPVnFQO8TPacJiio+D?=
 =?us-ascii?Q?Gywn7kC5DIwoE1yHQ8bgFl9ySkt50gTBz/SXX4yukgSjFVCcrT/usPdfuXdz?=
 =?us-ascii?Q?qU8n9iDLYMa5d/GHCew0TjMyb2kN0HwFKfXnOnB+7HwKNIHTYucKLe6vZeSY?=
 =?us-ascii?Q?yjFMJNX1a3qPWbFbwr9diQt77xkEflm636eNoBHjN/0ZK0vE05FYArj7xbok?=
 =?us-ascii?Q?SpyU+hVjlYPhLgx+AgD9EQstEh8I7/8VhJKCeT3IiNsL3XJDELP2Ze+jZUdh?=
 =?us-ascii?Q?YPHo5wpyHrtn7wv6cV5ndd0hnS7346L0bjCfsJKna61VYZN4yI3YoZC4we4k?=
 =?us-ascii?Q?V2ZeIOKk4U7iUmJwoc5edhhmadlgt3LYBf28fDwNK4sQZHdFnqg5yUzHDuqF?=
 =?us-ascii?Q?VWa5uxOE+5l0tvGrNPwHx0TYRsY6Oq2X6ypwKmK9PUPURAZuTKwt63DSPi0d?=
 =?us-ascii?Q?SGhZqWz91OuTgiT3Ve01U2tkGW4sNbNIdgpcIWsDHU9bzufEgFcOgZSi/ihZ?=
 =?us-ascii?Q?hVmxZeCxaWOEwy4z3NF7IcMbbXbgy72IEjPj5Y5VCErs6afoEJ3e5rN/6x/W?=
 =?us-ascii?Q?PAS+9k4sxZdLVbw2NzRfU5y1wpf028xIWqFS?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 16:59:05.2684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d1ad33-5cdc-4afc-f6bf-08dde3f8b31d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
Received-SPF: permerror client-ip=40.107.223.60;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 25, 2025 at 09:21:48AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Nicolin Chen <nicolinc@nvidia.com>
> >Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
> >
> >On Fri, Aug 22, 2025 at 02:40:58AM -0400, Zhenzhong Duan wrote:
> >> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> >> index e503c232e1..59735e878c 100644
> >> --- a/hw/vfio/iommufd.c
> >> +++ b/hw/vfio/iommufd.c
> >> @@ -324,6 +324,7 @@ static bool
> >iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
> >>  {
> >>      ERRP_GUARD();
> >>      IOMMUFDBackend *iommufd = vbasedev->iommufd;
> >> +    struct iommu_hw_info_vtd vtd;
> >
> >VendorCaps vendor_caps;
> >
> >>      uint32_t type, flags = 0;
> >>      uint64_t hw_caps;
> >>      VFIOIOASHwpt *hwpt;
> >> @@ -371,10 +372,15 @@ static bool
> >iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
> >>       * instead.
> >>       */
> >>      if (!iommufd_backend_get_device_info(vbasedev->iommufd,
> >vbasedev->devid,
> >> -                                         &type, NULL, 0,
> >&hw_caps, errp)) {
> >> +                                         &type, &vtd, sizeof(vtd),
> >&hw_caps,
> >
> >s/vtd/vendor_caps/g
> >
> >> +                                         errp)) {
> >>          return false;
> >>      }
> >>
> >> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
> >> +        container->bcontainer.bypass_ro = true;
> >
> >This circled back to checking a vendor specific flag in the core..
> 
> I'm not sure if VendorCaps struct wrapper is overprogramming as this
> ERRARA is only VTD specific. We still need to check VendorCaps.vtd.flags bit.

Look, the HW_INFO call is done by the core.

Then, the core needs:
  1 HW caps for dirty tracking and PASID
  2 IOMMU_HWPT_ALLOC_NEST_PARENT (vIOMMU cap)
  3 bcontainer.bypass_ro (vIOMMU workaround)

Both 2 and 3 need to get from vIOMMU, while 3 needs VendorCaps.
Arguably 2 could do a bit validation using the VendorCaps too.

> >Perhaps we could upgrade the get_viommu_cap op and its API:
> >
> >enum viommu_flags {
> >    VIOMMU_FLAG_HW_NESTED = BIT_ULL(0),
> >    VIOMMU_FLAG_BYPASS_RO = BIT_ULL(1),
> >};
> >
> >bool vfio_device_get_viommu_flags(VFIODevice *vbasedev, VendorCaps
> >*vendor_caps,
> >                                  uint64_t *viommu_flags);
> >
> >Then:
> >    if (viommu_flags & VIOMMU_FLAG_BYPASS_RO) {
> >        container->bcontainer.bypass_ro = true;
> >    }
> >...
> >    if (viommu_flags & VIOMMU_FLAG_HW_NESTED) {
> >        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> >    }
> 
> IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 is a VTD specific flag bit
> from host IOMMU, we have defined get_viommu_cap() to return pure
> vIOMMU capability bits, so no host IOMMU flag bit can be returned
> here. See patch2 commit log for the reason.

VIOMMU_FLAG_BYPASS_RO is a "pure" vIOMMU flag, not confined to
VTD. IOW, if some other vIOMMU has a similar issue, they can use
it as well. Since we define a "bypass_ro" in the core bcontainer
structure, it makes sense to have a core-level flag for it, v.s.
checking the vendor flag in the core.

My sample code is turning this get_viommu_cap to something like
get_viommu_flags, which could include both "cap" and "errata".

Nicolin

