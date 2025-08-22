Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24070CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 23:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upbbm-0000fq-7G; Fri, 22 Aug 2025 19:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upbbi-0000fM-Kb
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 19:55:42 -0400
Received: from mail-bn8nam11on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62f]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upbbg-0003I6-8z
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 19:55:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDqm88KyT0e3bR7lFcAI7KYoRySlw1Fk6GBUdWyO7sn+AEI2MScNwJr7BvzRrn4NOkJuwHS2ItXzGucHKLP26QHA+Z9tkJo46vbnPr4Alo2KOsG5QG0QlZxGyi5MQEMY4ztMPQPWI+q3fVLuj1ClCNTjlx/FcM4izVCmRZXsnsEpAIjjBM+nW1N3YHffxv/rw8THsWVec2E1Me8FFNLaVyQVlwb5n7UycCbF8I676tZzX47eSq4gEf6cq+B6cJAjoltPTdrzSi+qVKXREM+OKoM4UTr9pSFEyvb1Th8o/4Q30qIntCfU9ADWJV9eCk45OEGVnvoS9m0WESmXHb5ApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In+zZpN1rqMR2NwyzOfWY2LCY9TDqwtGdQBmPYGcxgM=;
 b=H8/8lgphEOTWTXe6xC8IXLvynieh1zp7G3lExd2jQ+WV2rmCSqODDlhtMKrvholjYBSHp4a+2l0uDhcoBoro54DrYI8dTlHB1mHRsx6+UlutNkdOC3IzIwLo/TmAcBTKjbMRaAqYSsNtfZp3vaSxkg0u6l//hjvlnBoGt4B+7F9+laJd9+EQ4bZvUO6EjDixWKfGx/HJ2Z5dnYPZfi9TcWkftfq2nfsZwVKjX2pvF7FQmfzpLxv/HFCaU3d4plHhvNYciY4RkXQGOWuyL3G19ZK1grsgpscNblE4I/55u8FweqaaF93Bs6aCPAtl3nd10+9038TT0HWSITffzIWVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In+zZpN1rqMR2NwyzOfWY2LCY9TDqwtGdQBmPYGcxgM=;
 b=JnGSP0N7JjUZs6fkfn0zSE/Y5EBnreuFTLZqfYGJJUQenLG8SjhZwIIzb+NGWdvt+vDmxZUjn6Am1V54LagiqqTBk8qohs05TJAlvPFVaCcSF85u9c3tllcsoLC9Gsr5Fq0OaRxwvjLz4L4waJLEEV3yguPS5r0BuX/w2nWIkPmufmHYtDv0MOUasIUDBjh9G+Qbt956wTSkDU5eCp8YXZzU30BXOW3eBBTuKK6akHyemz62qPZtUJCn56emSUDa9aQQ7vKPKvtLIKI00+Dq/0MCE75FL8VzD0o26SeW+ednTikWZGaQSGRWWpUoddQFlmZ5Qqydz1DQC8vGIT61AQ==
Received: from SN6PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:805:106::22) by DS0PR12MB8414.namprd12.prod.outlook.com
 (2603:10b6:8:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 23:55:31 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::34) by SN6PR2101CA0012.outlook.office365.com
 (2603:10b6:805:106::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.10 via Frontend Transport; Fri,
 22 Aug 2025 23:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 23:55:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 16:55:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 22 Aug 2025 16:55:12 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 16:55:12 -0700
Date: Fri, 22 Aug 2025 16:55:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
Message-ID: <aKkDXiSwWGgio0dM@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822064101.123526-21-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f61d2a-08c1-4e48-80ef-08dde1d76060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ObfEFwcB810q4U8Ek0haShVRFVbZqiwwJHoCBYosqhEvzyMTxSde4sH0YtH8?=
 =?us-ascii?Q?mQbDTMUt2cZMPi0WqoamIUk+hblH4A7pYYD0cFb9XIyrHXH0ywAKX8udh1fY?=
 =?us-ascii?Q?s/8fhhwZRHQE13VPJ8nabVgyII8WXrs0y9gv5a96CxPsu32LoIQzowGiE3kF?=
 =?us-ascii?Q?99wYTHp/xjmd43/aMdNGo1LaGmEBW6mp7jGew/7SmCjeXObxBmv/Wl3MzxC/?=
 =?us-ascii?Q?AD8b7ap6tn98T+nY2J5B/ZSjBh2q6CYbhlGg3tIokS+2mhMmKH9tdxlLJjAj?=
 =?us-ascii?Q?v6ufpgLfrwPxkIMaKyMkGT4iJ1z9/kJU4J2OW1zeGD5GBrycuuJo4BqjIIG/?=
 =?us-ascii?Q?0dmbaOgsvfaOl35VwitOFKNJaPEK8Bz0MixGupCHB8pZ6JF/DWMQKFMMZTrH?=
 =?us-ascii?Q?wA+6G5KrmmJ7sAjuiN+2qFjNYwTfQRBFWV+gLOc49Qvwuv14iop2CDxi5dXm?=
 =?us-ascii?Q?FOFxt6l86GF2GlX5RyvMwzUSSQnRqsa3/xljbtibMwnVfRp4O7tOlKgSuJ2v?=
 =?us-ascii?Q?qDSgo7FOrYx3KPVDCebuqjqZYxRDeiRDKNiZvoIVGFXoZR6npH4iK63JEsvS?=
 =?us-ascii?Q?0DLVt7JNzETN51YPJSIOShlWWHhIniu3ydBZtBy1UuzWpNXH5sMM5AuoKqc/?=
 =?us-ascii?Q?I9sC/yoyBlNV2uXw/9ofcNEocwmeufrra+1+dqfTQqKNb7xO8nQ6UxhLZQEB?=
 =?us-ascii?Q?82F4smGz+AD1dRKyKtcdHwmDKohNaznAIjrGHpNJEYgrRZuS5UUK78P7byTR?=
 =?us-ascii?Q?2iHN5rCThvXobAK6DY8x25OuSJBxflqWxQ5nphf5YyceqdGmGg7c6FkTXSXV?=
 =?us-ascii?Q?NxQMq3p0b+o47jqt7aeoMTBZIkvk2Y+tNd1OlsENWYMbtomojYmcnSfnUSjk?=
 =?us-ascii?Q?t0AdHjtnw+jNrgYXZ95Nf+ACbo9uGGdGLkaHV26cpkAWIWQ6YXHwTEKO2zqV?=
 =?us-ascii?Q?sIfAJE6BYhlI9Zp6Lw3012Ta25Rb/ItDuvsWie2mjS26DS3iTO4gX7dMlKvu?=
 =?us-ascii?Q?FRA0WbR3TqyC4V3VfOOqj6SOgQVdpZgBu5MLWyXQN5OOclxYfY4ZhHkhPVgO?=
 =?us-ascii?Q?zAOGAI/pcwQJnOV5v5usJUAXV3T9fyiJAU7dhkEjefM0DzdpnSEfIbDVfIjC?=
 =?us-ascii?Q?8N3YIANYmPlNRrOOM9S+zqx+mg5q+sQkazxGbHSdWQHaZKcLElvEzfhK12B8?=
 =?us-ascii?Q?tlippsSbF8p2jk8WrIUfv2z7FbpsCJ3M99yLgd4EbTgyUjBWR71sY9UUq8tf?=
 =?us-ascii?Q?S8nxS+KGkKwcuWg3VS+gYC6g6IxQpz/CAd6tpYq3NJG/x1iYKN+QvJ3VJhS0?=
 =?us-ascii?Q?pKzWi6FZGDUzGAXFEAaOoZW5bS+ZVY8qif57LeH8xU4a+zHCJgVeJ3vl3CI+?=
 =?us-ascii?Q?87yqBw+hqoANKRoFHxFuO8tD/vTxLz03ovdB+VP+j8nnxGfO6jUzdlDbRohr?=
 =?us-ascii?Q?KNRSXRGMSTVimQC94oCxWmJZkU2iRDMtXn5L/9U94uz1vNTStoiuMhUNHD6Q?=
 =?us-ascii?Q?7Q/Bay46Lwn8j4Qk7b0G+HZWhLOJOW7ClnRw?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 23:55:30.6286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f61d2a-08c1-4e48-80ef-08dde1d76060
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
Received-SPF: permerror client-ip=2a01:111:f403:2414::62f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Fri, Aug 22, 2025 at 02:40:58AM -0400, Zhenzhong Duan wrote:
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index e503c232e1..59735e878c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -324,6 +324,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>  {
>      ERRP_GUARD();
>      IOMMUFDBackend *iommufd = vbasedev->iommufd;
> +    struct iommu_hw_info_vtd vtd;

VendorCaps vendor_caps;

>      uint32_t type, flags = 0;
>      uint64_t hw_caps;
>      VFIOIOASHwpt *hwpt;
> @@ -371,10 +372,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       * instead.
>       */
>      if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> -                                         &type, NULL, 0, &hw_caps, errp)) {
> +                                         &type, &vtd, sizeof(vtd), &hw_caps,

s/vtd/vendor_caps/g

> +                                         errp)) {
>          return false;
>      }
>  
> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
> +        container->bcontainer.bypass_ro = true;

This circled back to checking a vendor specific flag in the core..

Perhaps we could upgrade the get_viommu_cap op and its API:

enum viommu_flags {
    VIOMMU_FLAG_HW_NESTED = BIT_ULL(0),
    VIOMMU_FLAG_BYPASS_RO = BIT_ULL(1),
};

bool vfio_device_get_viommu_flags(VFIODevice *vbasedev, VendorCaps *vendor_caps,
                                  uint64_t *viommu_flags);

Then:
    if (viommu_flags & VIOMMU_FLAG_BYPASS_RO) {
        container->bcontainer.bypass_ro = true;
    }
...
    if (viommu_flags & VIOMMU_FLAG_HW_NESTED) {
        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
    }

Nicolin

