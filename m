Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B94CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3I3J-0001LT-Ez; Mon, 29 Sep 2025 13:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v3I3H-0001LA-2Q; Mon, 29 Sep 2025 13:52:43 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v3I3A-0005JE-Nc; Mon, 29 Sep 2025 13:52:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6U+vmx31UnaXM4RAfxGZaSMjZsjBjWuVWyUSh+c9EjSroGaAXsFQDC5ScjUO+bkv/fBedeiwQEkRqG4yoZd9lC3KgGQZrC9sg5ImHpPu0UHUjcfpy3cYwKid0XDUeRFA0e4U8lg5XlWRPMF53ASx2qerXcLcekELy2kWVdLEdQUECGnYHR0459cvAPIQ0YdQ9Q33miz4xKNwAAgpggaoIIPMh4mxHVco36uuhHf5hKCwI4dCQopwJsAYe0qW5ZvUloAy83kgB5jdtjx/tbFeglZng1s52llQpzUUHljVqA4PYXyzASE04KWn6vyEXX5HRUgIy6XE9asygt/FCKdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBIKNPfNWosu71MxCN7ZpqLg17cpmvgHu+G+Vt5DPe4=;
 b=aCQc1qTEXHi/Co1avaUB1Sx9CXriOQQcO9RsHPkcffZQ0CwRAaAzEz18XAij7AqtflhC4lFvKILWxrlk72pCNLPd5jFZ7Ba+GTKD4yzuc2EKzocJLQ6of9z40x+HNbRb2yfaWyqBxVTPK1BTAcVuarhcw4aTEkIRvQTKlHkjrDhpH8RpLPURFK6Emri57zDaIywXpncDrCjfCqhI6Nk30EWq2lVglWBRwzFSwQAtvA1J6mXryBBVWNjrGyoOGA/2unWvEV0Uwsz78hwp17uYocVSZkhomEMRhfN9NR1UUD2lx7UPS0eZl+6eYlX2j+GmlE32pLK8A1NAAcjLp+Mk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBIKNPfNWosu71MxCN7ZpqLg17cpmvgHu+G+Vt5DPe4=;
 b=ZJcgFTg+Y97VsOVh8bUDPt40bOh4N3pFoxnhUZ7rBz1+4BW4pD1iS+gBVp/c+x7NgmWiBsQUFdfRZBPy1QzEM/TynMSJTUytkkDwfQVlhp+2bBZdnXyyMlWmI2rRXnCHydNKVNnvGyJNVm3mzpKxQ6gyNqwyTgsr9/1/NlDUQC/DXDHyCNvvVJqho6vczXiezc9bvgX8PjVIas8stONWKcvwAVLBS1iyktA8j2wqwAe4hWZ8har+LjDex+gux4rjDRl4/GrwXYDtU6sYPeiJGbthzA2XrGBoLnWNVBZROOG+xThLrDRzjONQdrU+MJyr2Yo3taqgqfBlVT8+BtBkZw==
Received: from SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 17:52:17 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::d6) by SJ0PR13CA0013.outlook.office365.com
 (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.13 via Frontend Transport; Mon,
 29 Sep 2025 17:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 17:52:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 10:52:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Sep 2025 10:52:03 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 10:52:02 -0700
Date: Mon, 29 Sep 2025 10:52:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 02/27] backends/iommufd: Introduce iommufd_vdev_alloc
Message-ID: <aNrHQT5+WITaKV3m@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-3-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250929133643.38961-3-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: 5121d944-9bdc-476f-6f3c-08ddff80ee05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?voiKNvaxfidAdSTAcZD6jPvQCfbsRfAilql92EJvXf5eV9AacmFvzwtnn93m?=
 =?us-ascii?Q?Ug7JloERRT/mgnk3WiagZIYHN9GMIrmaQlCSg1NdpXkxKxR55YJK9pIJG70A?=
 =?us-ascii?Q?W5NOHU9u8qyH0C1GLkP3SIMValSSrbvkt44xVseV8Y92sTBs5XpXUBjBfl3A?=
 =?us-ascii?Q?K1is/Q0OEvqm3GK7+RFq6NEM0Abp7H/9NK7PaNBwIGtie45LufP7LwS+qBwo?=
 =?us-ascii?Q?UkZ5JmLNr4F7b26CT8geEeWs5A5fLESF4wBEXZUpxYUj318mjxGeTkNukzkg?=
 =?us-ascii?Q?I4PpLh4y6ScK/zGp/6k6RbtaaCmXTZTbV3i0HXT6NQ4dn5jEuSzLAK0hMb2+?=
 =?us-ascii?Q?tbfFmGywy05QTWNBgTGmkr1eZ2PEJp/V44tGf+oVjMJCxuBZQBCIs4oE0DS0?=
 =?us-ascii?Q?o2kjrxHUvDqtFb1PAqWRPFGuU4VEMpfjrh3G90sk01rSF4fkYugAwZYRb9f1?=
 =?us-ascii?Q?F7Ery8JEh/o4JJ4XAi0ktq4wqykHnRwOyyw44alOiSbrpDzxbKI9qxgWQOd3?=
 =?us-ascii?Q?aGSsRvwynRpJZVBhvmySQ0qJ6zk4bXABtmQ9bzD05YlTorcLBl8aAnRPicjm?=
 =?us-ascii?Q?PfOFkff761SrVDk6V/wTV5RrjT04SlvUnXSBDw6toetSw8eMmpjWQNZkX7Se?=
 =?us-ascii?Q?pp86Udkcv6h/TaLDw7JvWKCflDiSzNA/gOky0ZToyI55t6a8nhirY3a/kC5n?=
 =?us-ascii?Q?/aPYGraRm0AhILw+N3ECQXxbyIXY5BXdTj4F8xCzVIAEjn9ceJpLWDVdI9j7?=
 =?us-ascii?Q?q/DWLJKjIx17xMlpTeh6Pol6xRDT9zG+319z29VZHI0XZixVwJ6NGaNVbR3h?=
 =?us-ascii?Q?tpp1OsdXv3rhfGwT0LIwIRBETg7Y/r+sM99RI0FijzfK8CLY/htUF4T540Ys?=
 =?us-ascii?Q?mTcvNHUxraom6Q6V/UWlfBCwmwOwwzfJn1eJA1B34cpzCOGFmMVAxxwdCIPY?=
 =?us-ascii?Q?PSlVueD8KFMackslLG0xpDSpoJCS6d+GC7xKfxA3jbWiHkK5hcdTmd6wGqor?=
 =?us-ascii?Q?Gx/Zv/QCb08hf2Y86eLF7v8owHYSuawhEEH+C++JVJRbEV0pLfP2LI6Mi299?=
 =?us-ascii?Q?MdPjBLOLlHMlZMbKYCrX78MkPixV3Urve0v7JK4FxeO/MqlecTPsq2HhZvLG?=
 =?us-ascii?Q?NmAqRfUyC/SKJM2qas7FxlCRy815AQ/HL5Rxll1nTZoyRizzVbdUckTz/Xth?=
 =?us-ascii?Q?EqU7A1+b260WcsYqlBTwUZi9RsUV37pn8LmqtwJJaCVZM6UPaSbcYzdg99KV?=
 =?us-ascii?Q?gMk1Ogc3IdM+TNPEKf/pkSWx/at3HMqIG96nQVIbZD7D6/+J+J7qwqTtg91O?=
 =?us-ascii?Q?DqVB22LliSPQaT/rV9wCm6WohZ6ZRDUmJFAyKgLDVYwgUkb7jP4BxctGpCL+?=
 =?us-ascii?Q?E89bD8OQGtqLO3qJzbB8mq5onDn58RXTfEElS4tAEPp4jmNRg6R4rh7mcEsS?=
 =?us-ascii?Q?qtp918bObNGWTG9I+agd+VZ0CH9Eqb7O6pD6jVw1pbS0P3f0piceA9lteO+O?=
 =?us-ascii?Q?hQRdtFfc2e2TFuHH6I+EvpA5vNmRCmYh8T0jS0bOxZj6m61Ajm4HjsMD0/Tv?=
 =?us-ascii?Q?NC/y9t2ESsEHvycQZtQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 17:52:17.0417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5121d944-9bdc-476f-6f3c-08ddff80ee05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 02:36:18PM +0100, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Add a helper to allocate an iommufd device's virtual device (in the user
> space) per a viommu instance.
> 
> While at it, introduce a struct IOMMUFDVdev for later use by vendor
> IOMMU implementations.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c       | 27 +++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  include/system/iommufd.h | 12 ++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 7b2e5ace2d..d3029d4658 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -472,6 +472,33 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>      return true;
>  }
>  
> +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t viommu_id, uint64_t virt_id,
> +                                uint32_t *out_vdev_id, Error **errp)

The function name in the subject is now mismatched and should be
updated.

Nicolin

