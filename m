Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D819CC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 04:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZM2N-0006pd-Tk; Wed, 09 Jul 2025 00:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZM2K-0006oZ-Te
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 00:04:01 -0400
Received: from mail-bn8nam11on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60b]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZM2I-0008Iu-60
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 00:04:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcJaLCdLuiwK3BaQ9+jb/7Pe8IMTp3iEw4DxHDOjOJ7e+yZfnOCmoxC7XCQ6iHRQ4WAjwjsicpvLVudxBpmFv4MGmGehbUNwwg4NcnlF0BS674qtOxhye5GvFvMFR+G9nKoawKFPleRBxr8JQkmaBE/lPihvLInVAiUBMaEL/jfwFmdpx2XvHP26JzrKODRx2V0oMrOzU3+KVyo07hdsDGuCTA0qLOefgwXcnSl683QCttRw+tKqvpQeuCu6T5gMQhxntKza+ipHxBPcfg8Zw9hB8BcT4tbNE842mQeyWNsWTrf58FA7rikhp/02Q0DEM7IgaK+qvzBGL895Un6ixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF6qIA4WZSxPhNSGTU2114jFMjm08Thqz5IxYJTDLNU=;
 b=DvJ312zC73r+WwyLmC3/md5XxtG+EoW+m+kls1mwnSE1NAIQEzO24xKtEtk8s0u5m3WBJP7gTVv7tIXKF6r9Z64MidJ8WrWYYrI15pfk/54blvWyOC83g5C+bG0s65JZoQ8NEBJPXJuCoch0HftoIm4lAMvYjM39A6y9DAFIky8RynBldE9bg4Z5nKpCXY8o/KTNXbnDSKPZvll3Q1MTXVYgEE3RnSU2odnSI/4Y7auxsvGipNMTGB1tMluGG5owbrHG0uwJCw0LqllkN5yQSvXR4/XDwhjvCX0pIvCKDYkqqzW2kg5uDOD8MUagjnylMVDgL5D0swsJP9W+r3jGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF6qIA4WZSxPhNSGTU2114jFMjm08Thqz5IxYJTDLNU=;
 b=Kb+AkLiqOvJZXut0lDoIonAU7F1ZFfrbqPSRi0z/iPfDXpVwyLaNqUJbAcl4LXBsUweCbEsIAXdwTqJ3Z08ZtARhnlQjYpoS+z4WZvotQRO6AUTb4oBo4K7SYJrWYCuw8zunA1BGK49Naknf/ntPop2WcKT37cla6YpcPtcWaxPqpVGNTyah/U1owxM64P/AZQSw9ZRagOGSFSScXqYVRQINE6oGTKGhK6T3ycgKnOu//jkSBaSep8+aBLMB0k4g+CVuW4tHgyHGm+Z18555d2dSHV1d2zDcndoFzLHFWsOm/AtMu8Dp+gDZb25gYr+g9wYXxzvn9vEJJAx/O0vaqg==
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 04:03:45 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::52) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 04:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 04:03:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 21:03:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Jul
 2025 21:03:25 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 21:03:24 -0700
Date: Tue, 8 Jul 2025 21:03:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aG3qCpUB8/Y7r9hT@Asurada-Nvidia>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <IA3PR11MB91367A742FD1F22D591D52069249A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB91367A742FD1F22D591D52069249A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec2d8d9-3781-4c3c-6847-08ddbe9d99dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Js78trDVERyJzFgb267/IfOcbKP+oAcKzYlGWd7e5iNuXimoJnB6S/dnZMxL?=
 =?us-ascii?Q?EeATQsC2MlWU1MANww5K2gRAEecQ599vl/MElTmQ5x0W2YgomwOYC4rJImJ3?=
 =?us-ascii?Q?R1HO7vICR8NwCazfsvpuYgWrz6Kayyl+hvKorQ//+to1MckTDDywMzvFQ7W4?=
 =?us-ascii?Q?JPAW7pCjRREtCSt16d9kiVIyUnglk4yWjWLj8sSs84cm4spAeuTnO6AiFl4/?=
 =?us-ascii?Q?ck6nVoRrn+qjLsAjz2x+WjTBmjWatZfwKvLBfUnn4RkIPs5k2NyWnJFLb7G+?=
 =?us-ascii?Q?BqQORZtDCBPpNT47R2FWVi15JIjuDpWIKNz/izjjQ+8+mnjzlNO0S5RbiMN2?=
 =?us-ascii?Q?YscsyjahAk1uHiQ/CUQBEcGBbANhK0QO9eBE7JihQ3U3mcLy3j5wuNg2dqPJ?=
 =?us-ascii?Q?nfu3RfwHcgxYoGWRJjdgOOvtwCB0ZOlooN0r3QMw/p/MXaTp+7F9/EpvKPtv?=
 =?us-ascii?Q?cFfeynibBGQIyOYFeYI4tLfHHWAVcInLwhhpLN1gYPid7JWDlPsPcMWM4AfQ?=
 =?us-ascii?Q?vkoecXA7frnt75H72zR+fZtdJI+8WmaOUhzk+TNBTIffPiInYRmER6/4Z1Fw?=
 =?us-ascii?Q?8SVsdbuYBoA0y5Oaifi4XWfNPK6jCs0FbdCDVdyw/pK43RVIJ4AO4BZcikHq?=
 =?us-ascii?Q?GQzRXZlN1iz+5/pLV1dUNIH8fOFhH3y7YL+ZxvhoeThDDXG5odz5tVtnWTSj?=
 =?us-ascii?Q?GvcwPwV9mt504DgEuIr0U66T7jSDVgXJM+oVmBDN44+pUUo95vhhv4/0RdID?=
 =?us-ascii?Q?wTaM2P9T8n8Eu/kpxW3sYztp9IQk49+118tJqr8b+DsUzWA9Xx1pEX4ntDTa?=
 =?us-ascii?Q?vf9+gGDxqz9s5XM3Da7ZE4lvRtW3JRxHkoizcF2QYL4xK9jy7qF+Q72TjgZj?=
 =?us-ascii?Q?LDwkslcexVrgVHacpz87aoeDVsijB2ao8GU/jW1Y7rlRyDTQ6UeqFNT3gz+J?=
 =?us-ascii?Q?QtggnrV01XBI5h9KnyIMPxLHybSIjrLA9/6+sRbu6/EDu+LWEHuywPZl/UlE?=
 =?us-ascii?Q?505UhJ3toR189bZ671Z8OZKrLTWILTIsWlfOllJF9pGo4i34xAPq3VxmrqQ5?=
 =?us-ascii?Q?u2DYbk+nYM5QB6jzjNNTZBAPV0kYGWvYTntVHoVQGbGDSzLRLKVOiz+DYPiI?=
 =?us-ascii?Q?swh3tkdXon55juCAzYnYNS0BEdG2YdHHUjW+mt2vKbCmORq1TZfD26JdQK6w?=
 =?us-ascii?Q?BMH/Q7dRvXIrA8g4WbKsjMnLbtquzgKOtwJA/clRl4CWf8IvzDmyCkuYGDgm?=
 =?us-ascii?Q?Ppma+NhOf6Um7AqxhtyPXdp1EcrK62cDI2D9aWMZpECkU0kx8Oq/Oj10nlB3?=
 =?us-ascii?Q?0nZ4aXCSchu2N/OcOwphooQwBH0R2Mc9eDD7Ypcvb7+7qbTzFjWsIyijgpHt?=
 =?us-ascii?Q?um7kEWV0I3BuluOWjEIiVDaMI6O9PvfONY1vU9lHM3iPK1buhOzwE508LGMs?=
 =?us-ascii?Q?gq7kTEZlYiMTMObPgtM8iIqrn3sHjcoo50Qi3K+58V6JNPte2gVKQuBmLGr6?=
 =?us-ascii?Q?rYGs21dIYLtLqlT3OU/qyvCTO5XjWKtk1CNj?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 04:03:45.5397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec2d8d9-3781-4c3c-6847-08ddbe9d99dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
Received-SPF: permerror client-ip=2a01:111:f403:2414::60b;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Wed, Jul 09, 2025 at 03:38:49AM +0000, Duan, Zhenzhong wrote:
> >> +enum {
> >> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table
> >supported */
> >> +};
> >
> >Thanks for this work. I am happy to see that we can share the
> >common code that allocates a NESTING_PARENT in the core using
> >this flag.
> >
> >Yet on ARM, a STAGE1 page table isn't always a nested S1, the
> >hardware accelerated one. More often, it can be just a regular
> >1-stage translation table via emulated translation code and an
> >emulated iotlb.
> 
> What to return for an emulated device, VIOMMU_CAP_NESTED_S1 or 0?

It would be ideally 0, since the get_viommu_cap is a per VFIO/PCI
device op. But I see the caller of pci_device_get_viommu_cap() in
this series has already done the identification between "emulated"
and "passthrough" devices?

That being said, it doesn't hurt to run it again in the callback
function.

> >I think this flag should indicate that the vIOMMU supports a
> >HW-accelerated nested S1 HWPT allocation/invalidation.
> 
> I'm OK to use VIOMMU_CAP_NESTED_S1 name. But still unclear which
> checks should we have in .get_viommu_cap() callback to determine
> returning VIOMMU_CAP_NESTED_S1 or not,
> as we know nesting support is determined by host IOMMU not vIOMMU.

I would say it's determined by both the host and vIOMMU.

This is a common API that may return other caps too: eventually
there can be a case where vIOMMU has its get_viommu_cap callback
function but doesn't implement HW nesting via iommufd, even if
the host IOMMU driver supports nesting.

Thanks
Nicolin

