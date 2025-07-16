Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EEAC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6K1-0001zl-Mz; Wed, 16 Jul 2025 13:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc6IN-0000P7-Ec; Wed, 16 Jul 2025 13:51:56 -0400
Received: from mail-dm6nam10on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc6IK-0004GZ-EU; Wed, 16 Jul 2025 13:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZMdnaW/GAcBAY7oRx5wRT7hlGoDxYBEF+gtM9B0LOvCov3zRloKgGXXhavHn9oarElX8TS+yRJI2bqdZYo+i1Vfgi7w0X9dSAAxZa0VQKFouRe8lPHg4IkDVmKa5HVPXfV3TrBxnTEk1On428kxboAO6U5NveYadwOwrc6FmRaGgv3SvqDdxhahagQ474E3+nqu9nQal3u2WLCl1aNzzn4pLfdo6F2+Q3v4RMPDyaUVIGLjqwrt2HaDRQ94mRUK8+HjjGGGRuMmwpbOTRGcOtljXSUjMyJbQ3SCHgodqPP2wbxvVZ2jkbiF61NkdpFVxFjs7MVx2Lngwki5r+kJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOM2aOs1cAzteKmfJ7RBX4TIL9Ktr3Cz4eYGy4q9Uv8=;
 b=dZ+VUjP8sBkM0JRtKdopnTDsaZjgWCmS7kL2EwEH4Z32HGAazf0qUtP67s4ANtwQrTsCSwU9tR5dIvgWEsIHJGSUXyb/BlZfDduSS50VRTmUzR0jqqt6cHN/SEqAuaMmIIshwpejDpJjZHd3TZW43pFY6gw2F7RpqpB1dajMo/DrWqPqA4q3uMkvygl3bBKlWfCwrV3yfMLIlyblagOMSbDgtbMsMDPw/WQDLMnEHCbivaEq2Iop5opAwkfWkx5CIeMeg971dneWQeYZmdPfI8Bxzgm/Oxr6b9Ab2APMREQetrH9eFhhcQlynolzYGLdknjrm66Gqytw+TIS2WEedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOM2aOs1cAzteKmfJ7RBX4TIL9Ktr3Cz4eYGy4q9Uv8=;
 b=Gc1qEaYv46JXiC1rRvbUH3Vf/bsk7HDwocOilrv2ctOKDQa5ltkIT05RVFcXA2A4agWXybRZ3K6Ux0db777WQdKyu1vl1NJiYjKmAIx589xBW8vtaa5ejPy/eFkPvAlXFkFnkYFk+qOjWyEPBEUaNLGOLAQ5S/ATsK2ZamnzunHnaKHpCzdlbzBZ5lMN64lrpPQBH0vKacJj67fQ0Gv3gXOe3Uijs2gzwpPp53jjCiVqyby+9xej8YYIdS8S6HB/AwmyNRvLCEGSVyMpTRFFzW9pHnve8Xso4ljpnAXCvMlWhtL1Aiq1yXx3HdLV+vZD9G49Hl0qWxmCjNkX8FjBAg==
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Wed, 16 Jul
 2025 17:51:41 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::3b) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Wed,
 16 Jul 2025 17:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 17:51:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 10:51:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 10:51:23 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 10:51:22 -0700
Date: Wed, 16 Jul 2025 10:51:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "shameerkolothum@gmail.com"
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aHfmmdXXKcFDnJLP@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
 <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <798f739303f74fbca49a09a623a0a118@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <798f739303f74fbca49a09a623a0a118@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dada4e-ee41-453c-d547-08ddc4916b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?URy/xUq2QYdlvKUZWrCY6QhULXqhQAHMHNdieKi5F4LQjzO1DMvyeDBvaaiC?=
 =?us-ascii?Q?yYvAf4qmH0mrSn1xyV1MFF7KWcTirikyyQcMyklK/5fx552gpetLIzoCcBov?=
 =?us-ascii?Q?NauUKTfBpp3F+E8/UQcaoisn6AJh/E5CW2zM/cIVLo50Q1T33Mz8/MDzooWt?=
 =?us-ascii?Q?1R6aeFYlbEL4xNRy1kl72JYE1K23IJWsgClIwoUKwdhMtlQUUAHfhiHSfzhb?=
 =?us-ascii?Q?m/vvZK1VD06lyXRsZalGEP5ZNn73oGs0J/h3S6eQ3TDPj9dWVPGOGb12OOJM?=
 =?us-ascii?Q?uUoC6k4VfDY2mbpnTY614GMPs3tLQVVyYEuVYxvUmkI3E70cZw5soX1RNBms?=
 =?us-ascii?Q?HY3pflSyFN8o6ettEirh8wDQWkIZk0MKtUm+RObi6I8G9YuvtH07ceh1hp09?=
 =?us-ascii?Q?42/mXVDLAMASMqK2rQkjzKAUNEu3PjZ3Ions+y5Bns+vbqiTc4bcLOMUWdMt?=
 =?us-ascii?Q?fHDJfKCKMrCGats9YOmi9zW5lkxsfMsC0+hjxixVHzNPBjRlOllLV11z84g9?=
 =?us-ascii?Q?mmqheUFOTInXMtrAuIlG+UeqO9tOFQcN9Q6WgYY6ReXVf/7XBX/u6KJBBurs?=
 =?us-ascii?Q?OfhcC08y6A8I463wXYEo8N0MTOEXmnkCvCjLzNlnyhlnjkq0m1GCEp0GuRqz?=
 =?us-ascii?Q?j3O+KQC7/MpViY7KzomhjPjIq/STb1kwDypWKOVrjALe+75UNqm4p9C/jy9+?=
 =?us-ascii?Q?ZXNKxOAzw4JSSqk97F9BeEBBSd5rNd25P2SvoQIu9/aha6Z9QAmXeIOUPlHE?=
 =?us-ascii?Q?+kcHv+oPMHzVXNtuRTvlWMIKLsO6sjS5AX9cFWuSVIZyWiiGniAt1ReJYUEe?=
 =?us-ascii?Q?e6a+B6+oMpQbH9o7SSOLsO7sYR1jpB65kWz+Z6VjrzvMV6oLLBbrD/9qWHcF?=
 =?us-ascii?Q?MnUNzpv+UlQwUrrMfijdThxcmgUUCkRXUZRB/HncGjhquhMBAvEzaeEqfDOS?=
 =?us-ascii?Q?Cbvl57ssxVQUaVLpSGp9Uje8pIz83xCZu633l05Ij+p9FuPfyH8dXG3ooeKi?=
 =?us-ascii?Q?FeIwazAMpbWQyV/9uBmDflpmKsQdPv74y2qWYoMm4xMwSQ+NWEpLeNDL/D5t?=
 =?us-ascii?Q?F8IOVYrKa6LZ+1xFtAvQW24XPIgoTB7ZsfNvJEnajTFjiH81aBwbGA+3D48b?=
 =?us-ascii?Q?GWn8NtO9Rvy50rkVCJVOmxzwc1UeFMtrTO/YDG06QrotrV3Cbn0KADY1s8k9?=
 =?us-ascii?Q?68aeWhfyRsXdaaBYHZXl1QzPk0PbwOwS941TvKJaWwIKmxVdqWyI0F3ziiEr?=
 =?us-ascii?Q?mM/5eGFkNVZR1LJV+EBbj5ep7bWrZzYGTo9W06jeBRl0bEOop5/lSbauM/j1?=
 =?us-ascii?Q?Y3Kpm3E8gM6Dw3xv/JuG7Pbh5ZtdxuvFXk9z5zAdJr3Vwl1oLmEwZd2Lubsl?=
 =?us-ascii?Q?rLq5f55Gbu2syWUS1YQHhwWjq1atWsFg5pcMbr9MTdOUqPFHUzz2ApyCrHxi?=
 =?us-ascii?Q?gaKZiBe86Pi5tA/UgZKMmGN2pPlvNeJdXoyfqSTUkf+7U/dHSwLMoOwqhhEP?=
 =?us-ascii?Q?6hi2W4G8uTRoZt//4jb5MuKBfGDjESb7LHS9?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:51:40.2585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dada4e-ee41-453c-d547-08ddc4916b34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607
Received-SPF: permerror client-ip=2a01:111:f403:2413::60b;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 09:34:04AM +0000, Shameerali Kolothum Thodi wrote:
> > >> Seems aggressive for a hotplug, could we fail hotplug instead of kill
> > QEMU?
> > >
> > >Hotplug will unlikely be supported well, as it would introduce
> > >too much complication.
> > >
> > >With iommufd, a vIOMMU object is allocated per device (vfio). If
> > >the device fd (cdev) is not yet given to the QEMU. It isn't able
> > >to allocate a vIOMMU object when creating a VM.
> > >
> > >While a vIOMMU object can be allocated at a later stage once the
> > >device is hotplugged. But things like IORT mappings aren't able
> > >to get refreshed since the OS is likely already booted. Even an
> > >IOMMU capability sync via the hw_info ioctl will be difficult to
> > >do at the runtime post the guest iommu driver's initialization.
> > >
> > >I am not 100% sure. But I think Intel model could have a similar
> > >problem if the guest boots with zero cold-plugged device and then
> > >hot-plugs a PASID-capable device at the runtime, when the guest-
> > >level IOMMU driver is already inited?
> > 
> > For vtd we define a property for each capability we care about.
> > When hotplug a device, we get hw_info through ioctl and compare
> > host's capability with virtual vtd's property setting, if incompatible,
> > we fail the hotplug.
> > 
> > In old implementation we sync host iommu caps into virtual vtd's cap,
> > but that's Naked by maintainer. The suggested way is to define property
> > for each capability we care and do compatibility check.
> > 
> > There is a "pasid" property in virtual vtd, only when it's true, the PASID-
> > capable
> > device can work with pasid.
> 
> Thanks for this information. I think probably we need to take a look at this as
> this doesn't have a dependency on cold-plug device to be present for SMMUv3.
> Will go through intel vtd implementation.

I see. A compatibility test sounds promising.

It still feels tricky when dealing with multi vSMMU instances, if
some instances don't have a cold-plug device to poll hw_info. We
would need to pre-define all the feature bits. Then, run the test
on every hotplug device attached later to the vSMMU instance.

Maybe we could do something wise:
The sysfs node provides all the IOMMU nodes. So, we could compare
the node names to see if they are likely symmetric or not. Nodes
sharing the same naming pattern are more likely created by the
same IOMMU driver. So, as a speculation, a vSMMU instance with no
coldplug device could borrow the bits from a vSMMU instance with
a device?

Sure, individual IOMMU instances could differ in specific fields
despite using the same node name. This would unfortunately lead
to hotplug failure upon the compatibility check.

Thanks
Nicolin

