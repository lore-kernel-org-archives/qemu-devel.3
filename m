Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152E8C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMy9-00058s-UO; Mon, 14 Jul 2025 13:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubLxm-0008KO-2J; Mon, 14 Jul 2025 12:23:34 -0400
Received: from mail-bn1nam02on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2407::618]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubLxg-0002tq-U5; Mon, 14 Jul 2025 12:23:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqjCvKptpACbHCtqHhN4VPASzyzAjSEk/kl0Sxq7SHoQOYbb/ErvqpHMEy9lA1OtIhMWIWGgl2EpzyNwAcpu6pk/+m3tfW3mChYLiuQWWJUQW1eXSroCSLZuNrkJu1QicRaxsWi/3yXMXhJ0KDDWH4p8PTwv96MQ8yVvJOzP6l5KH2GNyyQzaza0K4dZLRUBQDpNDNjkAJc6aueju4JNHntlJjU/GUqBEp1ulwiPt8ZWaDIu69NwdpHZ8Wwx1mUQ2fS99WSG5mpzpR/fFFjfoKmKPDwF/LRvdUGf+prNg2/7AXkAjTh7FRsUldbtCHXYsPRFFXtl7mLaQflJhxNJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHkJouFUGBPHOf5hh1yuYWXHBwMxImZSlxbu4sNeAD8=;
 b=g+j9OVTMGrENSsnRhC3QIx7pQMQlNaffdvTiLvdHmPMJVIBgRfxKvqQ3JX17esiXuY219kmezgn1Z0XBL8I2AfdhYngjqPYJGRYYRcWCzNapNNvFr8ynYDb/UJPcxNcadenUpY3DYrv/+NIwu/wYx/e/bd4dbtjsfhN98qPvktu1yXi+Z2KS/lcUkWRRQZlZ9kGcHTU/I60H5WksI02rmo9YebxhQP/bFPyKqFGa/O2sO+RJ8M9CYAkwg71tRZqlggsZKO8ItzuuUWnDDFvLyaxtwgd39/zwgRt5y/bS0uJdSdDQ6tFGPBygkpUhmJamywfW0eMSoYoAdBph7FuqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHkJouFUGBPHOf5hh1yuYWXHBwMxImZSlxbu4sNeAD8=;
 b=KMyL6FZHFDdmiyRGh/xvPByTd7nFuszyUWrQ7dsFsG0xmSZ6ltniqhhqzin/Z2txuwqfTPjUaZiWCxJJW4ByymGEYYahA0s4W/6mb4oTYf26DPieWRUDjCeIQRwcX8A1m+PhdujmfJR4EN+ksgKL9fS4o70nbpHR3e04SXeR9Emcu4efamcR6EGiKlaYxXYiscwb2y3kOqKAC0cs2MhGEhFIENJeBt+y7asw+5lQ86Kf0+MGFY5asofhF9aIjDMZgn5Gk2/dtjFN8HijzK99N9t4mGZmV+qhbI+8h9N+vSaacGDCsKGRXI19aStJiIS/6Gq8MHI9mQmgHlN2VRU2+g==
Received: from DM6PR01CA0026.prod.exchangelabs.com (2603:10b6:5:296::31) by
 MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.33; Mon, 14 Jul 2025 16:23:17 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::7f) by DM6PR01CA0026.outlook.office365.com
 (2603:10b6:5:296::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 16:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 16:23:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 09:23:01 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 09:23:00 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 09:22:59 -0700
Date: Mon, 14 Jul 2025 09:22:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 01/15] backends/iommufd: Introduce
 iommufd_backend_alloc_viommu
Message-ID: <aHUu4rIBd0U0T+jp@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-2-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d035a0-f5f2-43a7-03de-08ddc2f2bcda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RlS7bMCV6Cy/Outhe8z/XxWa0wqj3a1PjkQfhducnkUANwxwShOJJBiwfkDy?=
 =?us-ascii?Q?BasuDyXAcIqoFW9ICDVNNWr0koH29Y/f2aE8ExA7gzGysaFW8cENHfoMzpX4?=
 =?us-ascii?Q?flCQqwVbpi5aHXmYx+pEFbYE67uPfyUIFB6VIp0xrMUCYKb2yZTTnl+xiljc?=
 =?us-ascii?Q?uFLLNCJjalqRCUiG/61G+iUjW49h3t8OnIUW9KcvAzdp9O8Jn4iA22Va5Wca?=
 =?us-ascii?Q?sG6PQc2+ECMEY5WvUaindLdv+ckoY9tZzlBqeMK2lgEnYZITm3CLhhaiXSYn?=
 =?us-ascii?Q?XHz1JngEg2gCatEzkv7DE+iiNoFUnLqNgWJpTR2tkhOGr+WblZktRUURpiCn?=
 =?us-ascii?Q?kPJWLj0OY0eeafwyuLkdcXQBvTvPPkNDX8O6OlHwb1HWGCzcyVAMCsyVQ9aE?=
 =?us-ascii?Q?+NsEqz11bv1oQzGrHgrplnaf2FXYragLRBQ364awmV265Wz3jyPQ3StSXJep?=
 =?us-ascii?Q?eAp+/1qx5+0A18Z01lQO+Gns064cGMs2vRLg74ppDSvmexudq/oaEf4P7gJD?=
 =?us-ascii?Q?4oJcQ9MF+XpAcIXq+FBcsJgotNv4vCxMWIaTN6G6MudFC8DYMF41SYkU5pck?=
 =?us-ascii?Q?6tfisNXi2OyTw+4DothLZCyEydUeu23ITdSPTtWHezP2nVj3SzBNN4j5D8Fa?=
 =?us-ascii?Q?0L7pItNfRzKRPV02pGQA4NvRWRW89bsXmYsqU206kF3WmlcP4/gfZJpp6mKF?=
 =?us-ascii?Q?detkMieX2YIVpz1YTpT34TSLk+Hk2fSxzV7/xljKW764PpNM/jngXA62rEtY?=
 =?us-ascii?Q?c2iX20Hvbeo41USl74fX8UWLMy3tukBKsrksnv7AMyjoZFLtK9B1PauTRoyB?=
 =?us-ascii?Q?3aXcFLiayCNjyGTLYRPT0JqLpA2pKmazyp2bV7vh0bg7IyCpYqv7jkcrvysJ?=
 =?us-ascii?Q?Rx5ilHYndd0CL743KUk1anKSz5xw+v1dnEA0GICdtifEZBeNC8urXqh0+DI4?=
 =?us-ascii?Q?jrO7lQvRNCodUxnoE18jufLilVEm6y3ocp2kanHIIpC0lYdL0YwBq3vkm1f9?=
 =?us-ascii?Q?HpIbk/7y/u2l4zNGky8bKNVd1Q+Ihv1fi+Jhc5V10J4511C0Wb/K9uDE0Q7g?=
 =?us-ascii?Q?BrYN038EeaLcTaDc5PJAwH3x5L0Nu1D4bvPqCl+lQL352dCb0xX1zOPMwJWC?=
 =?us-ascii?Q?YD1IJq+T5GSjaLYPaKLbYSv/A10SnKmSqeVUby+CeFOJ3FdlgUDKku/yQgAC?=
 =?us-ascii?Q?OxJIZ/O1PQJqAdmuolDewTmG7YhDhn0aPzguNWbNh+G/ZDbKUud7zbKCgZ5l?=
 =?us-ascii?Q?gmv0dSumwDYsPmEtrRHX4v3ymw79U9fWB1dU7W38ZgwZ1m1f8SU7xpTJZqce?=
 =?us-ascii?Q?ozYwlQKQByz7ws0ZiQZ3+E/xUr7CrFhOeXkZvZXQOQo9yzL4TDUy6z1hzRW8?=
 =?us-ascii?Q?gcF/nWzcMSPvQ4tRayKgsXFZ6fWF52DUkbuVYFTZrmrLMSppgOINeA6VJbMk?=
 =?us-ascii?Q?YQv4dJDy5OtLB40guojwEkD71StJmH3QeqqkEyoF7a/5cdpkF/ywyW2H53O2?=
 =?us-ascii?Q?l+G++3h0Io5Af4pVWtqEtRH0CjX54hbA2Va0?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:23:16.1127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d035a0-f5f2-43a7-03de-08ddc2f2bcda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
Received-SPF: permerror client-ip=2a01:111:f403:2407::618;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:27PM +0100, Shameer Kolothum wrote:
> +bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
> +                                  uint32_t viommu_type, uint32_t hwpt_id,
> +                                  uint32_t *out_viommu_id, Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_viommu_alloc alloc_viommu = {
> +        .size = sizeof(alloc_viommu),
> +        .type = viommu_type,
> +        .dev_id = dev_id,
> +        .hwpt_id = hwpt_id,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
> +
> +    trace_iommufd_backend_alloc_viommu(fd, viommu_type, dev_id, hwpt_id,
> +                                       alloc_viommu.out_viommu_id, ret);

Let's do "dev_id, viommu_type, hwpt_id, ..." following the sequence
of the inputs from the function.

> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
> +        return false;
> +    }
> +
> +    *out_viommu_id = alloc_viommu.out_viommu_id;

Let's add a g_assert(out_viommu_id) in front of this line.

Thanks
Nicolin

