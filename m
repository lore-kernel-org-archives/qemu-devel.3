Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA57C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 21:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL6qQ-00061s-VD; Fri, 30 May 2025 17:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uL6qL-00061S-T4
 for qemu-devel@nongnu.org; Fri, 30 May 2025 17:00:46 -0400
Received: from mail-dm6nam12on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2417::611]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uL6qJ-0000IK-29
 for qemu-devel@nongnu.org; Fri, 30 May 2025 17:00:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve2PCG9oU9WdvSd/+Famz9KeDar0KzoC1n0pv7FzSHMYGgkMojCdIYREb0IzoE219h8X5CH3Ck5dvXf0rowFM5bI7ttbzdxwUNeDXf2XnhGN9qvkFZ//LzCBRv4QBTGuIEVqhU43Nw+g5N7T5oe6fTjkNQ1euhiINP9jqx72sHTDEh6mUg0s347g368YbQhX7kEVk/VvW+TFmfVP14Y6OK9cFXzhpt+fQ2DmpZ8dzrdW4FwoXdUyuO9VKTwv3bThAoLyv+7yF8WCZAWPQCXqmizePkK/nVPOuRwWiOzlBO+5j27K+F+6LzZAv4nM9I0T+XJlp3cA7ZWz/4ExWGW2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW7nJalUhm2BCT31aCy7B6AShuLxbndGCzmQsEWh2pw=;
 b=Kmmd1MppWUWP9c4+avj1aU4IA5r783woLfZxIsHi3aMVZo4VrX8Wh8Fo410CL3Wv0rl8Zleoa+rQ4hFXfbBCfjmRdPzpD/eSD5l8zAMBSr0nkvB5xRGylk9LQQkusUQI6gaADktlGqLLH6AMy6FrsXlWmqrydDXR/880V8SqK6u9u2hjeIw/iYw8AmGzE6G9cKGyQ2MZ/ARP/gQr4uwH3M8vtUYRpnvv4weQVq6//gp4Nsn5YEZoryrtrXRiUgF9KEJG2pDFLBnUdR5B5tXjSzbenDf4M7jYCd66FOXyW/GOyU3B12LHh1tvu4anltFoeei6ARD4YeP/XDcCZ3ocbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW7nJalUhm2BCT31aCy7B6AShuLxbndGCzmQsEWh2pw=;
 b=FxVN7bR3MPFK+G3FMam/XSGlXr4g29xBh/581rrbkNDXy3qArDNcECdd5g2dxF2wQ9GwlKjAWC6RUBltrkjfwMFjcOnkW234I5MSlPWzaQXJPj5ZJ89eb8Frtf5W2Mt+jqb4v0+kxiYt7m/1puWYOU6IEkVY4EsLB9xQ4jqN/FTyvY0RGMpuoUBSMb4BoFtF2nijQ0W7zhN6uihe3i656gD1aUo3Xa3sLIiTKfJxpXEcJQ40GINkmEIYlJLTYaG1ra3Xq2YxzyE2McN1q6os9HO5k2ziJz1HzCsHzWPDfDQfmk2OUS9gf5lYHcVhbtcSsxk7uJOHU33gEBkZNKsGFA==
Received: from MW2PR2101CA0032.namprd21.prod.outlook.com (2603:10b6:302:1::45)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 21:00:32 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::38) by MW2PR2101CA0032.outlook.office365.com
 (2603:10b6:302:1::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.8 via Frontend Transport; Fri,
 30 May 2025 21:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 21:00:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 14:00:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 30 May 2025 14:00:13 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 14:00:13 -0700
Date: Fri, 30 May 2025 14:00:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v2 2/4] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Message-ID: <aDocW24Pz5o0fBeu@Asurada-Nvidia>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530093512.3959484-3-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ea190a-d08d-437c-8d67-08dd9fbd036d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XHrclvNKWACcEPNtS+di6dN93nDg9c+EUxdMepg1dK/cFWSbA8zGCn7xs6De?=
 =?us-ascii?Q?Dtr3qInoCqaL89QWtx6/+QfpoOW6DwMGXh9Wz5GMTxoQ8Pd6X9QtsnXKDcN+?=
 =?us-ascii?Q?PzZakRrQofc7UM5k3P66Uu1zpIFFafl2VLXrrqL2RepWkLZFGXAJ3yCxYYrJ?=
 =?us-ascii?Q?o+FAWDFOd+EjX7fN78Z07T1ktyCi5NFFeB8aqqux2c7bzVeMK+FRRW/QgC6R?=
 =?us-ascii?Q?0bY+dVBd4ag2btBEkIC9T+ElXGJRnOnt+tO1+E8qOQDCWdyP23wY5a4vp7fU?=
 =?us-ascii?Q?LgD8dEdHiQ49vLLBAGQajVBD5gqqFh49lrcxwe9TtcMAj9rlHICbZ65cwxFk?=
 =?us-ascii?Q?hfD15JS2sDcwBrfyi9GtLmeizt6YrnEk9yulIjzMO2hg07l2bB2Wc/O28X+9?=
 =?us-ascii?Q?sItjS3SgRnZr0nJ7XMP7thOA99B7GPklqtYHigP0tzGlhPZDY66dx192OKGe?=
 =?us-ascii?Q?BYFf0bPxsujOqUyKpzKoVg9jY4GtUQIqrFYCgViQYSS87nCrzKmMIVt6bVKV?=
 =?us-ascii?Q?fyI5/wHdshSmiH/yKF8vzSkgtcdPzj3nDllx4+oA1QTJvZIMZztpYu+EvlVD?=
 =?us-ascii?Q?CehyJ5XMuPyggZrCUqUnj/foIk6a04KA4j8aAlb1fCjCjyySKj65J0ooELGC?=
 =?us-ascii?Q?xzh8g11u1AXYCRJyMMnrcbtC+Z8/ojEA5EK66H/Ngqz1ccXi6XlJ90LXiZos?=
 =?us-ascii?Q?YU/Pqoj0gH+Qi92tBpLoydmZJSqP/8jH30Zc1sUmeg2Zf2NexzQkOZzfrdZo?=
 =?us-ascii?Q?xsscW5l4D+FudYEyfBLU5ix1lZgR7gD07RCbC8X2gI1VimQd2F3lZtSzp3VR?=
 =?us-ascii?Q?nSbw7CNatd/nNkx0mxb45YzGTnbhAqyh/w7Y5D4VYjiSxihqcSSjAtqdfhOA?=
 =?us-ascii?Q?PbRmLCg/mJzB4MyxJ7Mf/1pCHLP63dV/HqMl+x2FI/iby/GJPDczMBxb9u75?=
 =?us-ascii?Q?2Mn+92hdPF/mfHKwxyoxuRKzzg1dyPuq2lbBsztaszp2pExfTeY2YphCBdmf?=
 =?us-ascii?Q?fV1CSiPAqSCmDA6QRLcKEIuOYnQ5HqL0CHhCZDsu5PFNW3j1ciWcwOM4UGp6?=
 =?us-ascii?Q?PCZL5sNcfadpF6Cp+kOreqS0gKX/rdwGp+X1/Q5JXQwshBln4gHlYZ7vXi4q?=
 =?us-ascii?Q?m/7MugWKph7iARd5PzTTtJtLnKo+eMnDkM24rFhqatQycMOIIUw0EtMYyQXU?=
 =?us-ascii?Q?UkQ4Ta3CYDv+2VZF3dWv9TyEjgTPojHCQ8rKJqDeeyHNNfirnLVCcTBOr957?=
 =?us-ascii?Q?7iO2Q6tGZjnakcxPowmqNKfmOqc5H1H0Hpi3tV156mqgTrvcynWrY8EDSIox?=
 =?us-ascii?Q?KqDwEnobtTb4SjfKUmqmrU9yt/xzcU3zYpo+D6FR0t0joF+ebv1E9wUeMzNc?=
 =?us-ascii?Q?yZSgP/HGXrY/H4P8S4hLFFqSTelPlmHn2soN6WzuqWAT9TCwXxgKUttl89Ew?=
 =?us-ascii?Q?dWEiDqd+iR640Uidz/vRmpg17SBimoXVZfyNzfV2hNEhBQ+U8hJxNO8Rzn66?=
 =?us-ascii?Q?becNqyLEjBHjds8eFjF4I3jfw03v7ecgyapN?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 21:00:31.0732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ea190a-d08d-437c-8d67-08dd9fbd036d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
Received-SPF: permerror client-ip=2a01:111:f403:2417::611;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Fri, May 30, 2025 at 05:35:10PM +0800, Zhenzhong Duan wrote:
> Enhance HostIOMMUDeviceIOMMUFD object with 3 new members, specific
> to the iommufd BE + 2 new class functions.
> 
> IOMMUFD BE includes IOMMUFD handle, devid and hwpt_id. IOMMUFD handle
> and devid are used to allocate/free ioas and hwpt. hwpt_id is used to
> re-attach IOMMUFD backed device to its default VFIO sub-system created
> hwpt, i.e., when vIOMMU is disabled by guest. These properties are
> initialized in hiod::realize() after attachment.
>
> 2 new class functions are [at|de]tach_hwpt(). They are used to
> attach/detach hwpt. VFIO and VDPA can have different implementions,
> so implementation will be in sub-class instead of HostIOMMUDeviceIOMMUFD,
> e.g., in HostIOMMUDeviceIOMMUFDVFIO.

You mean HostIOMMUDeviceVFIO and HostIOMMUDeviceVDPA?

I wonder what are the difference between their implementations.

Main reason for asking this is that we have alloc_hwpt (and will
have alloc_viommu soon) too, and should that/those be a part of
the Class op(s) too?

> @@ -833,6 +834,11 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      caps->type = type;
>      caps->hw_caps = hw_caps;
>  
> +    idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    idev->iommufd = vdev->iommufd;
> +    idev->devid = vdev->devid;
> +    idev->hwpt_id = vdev->hwpt->hwpt_id;

Since it's the default hwpt that VFIO contain allocated, perhaps
it's better to call it default_hwpt_id, indicating that won't be
changed by further HWPT attachment.

Thanks
Nicolin

