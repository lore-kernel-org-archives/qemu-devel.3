Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF9C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGQ2-0004kU-A8; Tue, 08 Jul 2025 18:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZFpz-0005GC-PE; Tue, 08 Jul 2025 17:26:51 -0400
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2408::601]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZFpx-0008Ou-0o; Tue, 08 Jul 2025 17:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouh05AT03DARXnjEIedUziFyi2R2JBkdjk8hjrT3sGw3QvgBxHxKNOPB123badLGHaD+ZDXfnLOru5jnDRpeWYAODXRJnqRZnjQwK47YdE3fxV5WDwaJtDDGWtznpdglwh0Xlf3PblqRM+gCoJrUN+2ftjfoEnwCLxPf5HNP4M6RItS8jdyXTN0fzViwN5SXdQNCxHJu4+lY1WOOig/DqDKFPpYePT4asZ9B5Bz8aYQ3Y8pJvc18SEhC5/TRniEF+7JKK0vP11TAq5FaVDY1BhMa+FEI2i1mxqExn8k3+hjhU07D2Jzd1I/nujJ3IigmhfSnJzFXI76NqTrf8ZTxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Pg6LjP/2g7rGqJwHvywcggiQkjPoifmrsanuVl7cbQ=;
 b=IXHLNhCfuA2nx2ue5/ZvgzCDfHU9jy5SOoYJfn1g96tpy1BXKFXuty5Gk5v/CDR8wcvw2ZmcnlYKdUSNL9q8rzF9R+I7JLucsVmajeCj7N6ghhyEexjO9TulwcOQD1qSw2UiUHEA+GTDytiQSTARo8cOmeGZo1EZUeQrcxVa7Dq72dXkhoE+4x6lfyqFcELCzohbWIR6WPHOmHxl4p/pS499jLBQlRDSuOgY4zE5DauDWSm9NLDneHJCCJ06fyw+DchqkNvCBsmkbCasdNmHlIaJivzHr7TZ/GpbMHrm72CAh89SAQlJ+TaK0wRwj0nWRo4ZuSEJ7xkE13PaWY/aRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Pg6LjP/2g7rGqJwHvywcggiQkjPoifmrsanuVl7cbQ=;
 b=H+lEkTwPzGScKf7nC4zcMyS+SjxsAj9qwTocCWHMO58JuFfJB4n7GfFfzR5kq8tRNi91vfO4EKAa4s6EIK4GC+QWtq5Wbh3T9Tv/W4DeEfytXJauCFLIhKJIBIQRlTZKqOnEDpIa7+PrypcPFeHtABbq/6pyW1j680zrqDoIP5pwkky9cmS7SrHiHjQ1kQZpyihAouA77Jkyv0BkA70cMQR3f/9mm95tz7Mof2PqG7xFV1ZT0NBeSaeHTDDFMEFRgSsq2GbeBVB69CJBDxqW5we1puJT+KDyhgIxAhXbhEjqE4lsJH62rCzHnNb+5Qclkx7RR45MTt5SQyHwNR+6Fg==
Received: from BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::6)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 21:26:41 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::56) by BL1P223CA0031.outlook.office365.com
 (2603:10b6:208:5b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 21:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 21:26:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 14:26:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Jul
 2025 14:26:23 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 14:26:22 -0700
Date: Tue, 8 Jul 2025 14:26:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <gustavo.romero@linaro.org>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Message-ID: <aG2M/BI3UAYxKCD3@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbdcbd4-b925-4ea9-fcbb-08ddbe6620bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/Pez7zaQ2HiUNrMyI8uhaiU4Vm6tFhUc3p4ComV3GaW6Q5LFHXPobLcb9QG?=
 =?us-ascii?Q?vwwZtbOFS+lcfbyRWrd6sZc4+31zbUpInJPkfjrehCZNVLN86yXoQD+AVAKd?=
 =?us-ascii?Q?dPEf93ZNE3iJEvrtdsWlFOBN+Bu2ngd0S/tIVZG7GfBa5SOshGBqcGV7LH1E?=
 =?us-ascii?Q?p3oSuI0HY/7E2DAQvtTbtOG4BHXTz+tBS97twGKTHCsqzja821Ji8mgbrV5a?=
 =?us-ascii?Q?xoQCYEUQhMsdWqa1OTvj3XnMYDl6Kyrtp4Evs7UY2ZSUAQpAVK4TiDcObeF1?=
 =?us-ascii?Q?2fDKOEbAFGsWtN+4WMaB2fShL4VxvGWwNQYA+PaGcQrCSrtqZ+dBrj/FwpH+?=
 =?us-ascii?Q?fRgIIbhy7DEIlQqHBfoSIFmUBNnOCaF+5jKzwiF0o1KJZjdxSJ8evK2qfDXu?=
 =?us-ascii?Q?QYmP7pn35bhjZ1VDUpjIFB4N78F3WmJvYeXjEZC8YGECG5EGcmWbckBasSOe?=
 =?us-ascii?Q?87lKiS8Q8A9jmUu69ax5oMHU9cjYMlCTDX1BhNLW2oX9IW2NU0Fk81bDmeL4?=
 =?us-ascii?Q?XdlV5AaAwtescU5v2j9amVscJkT49KsFopRAYZ+5xQ9FRLOiQu5jK4gPtvGH?=
 =?us-ascii?Q?NXSBHfhMXciw4+cXoh7wTiZJLSS/efBgAUYAtUfNTf2wz7wIJENB1b3GAIDt?=
 =?us-ascii?Q?uOjdTnYr3FzLut2sualh4SUzdXuAE/uODdg9h6KO6rWZgVClvTSxj2CetiGH?=
 =?us-ascii?Q?7/cuLJLTKQIZkWLS5T7A+GoLnmp38mGnLtPKxXVs0aZaHNK7+zAVbS/gQP/6?=
 =?us-ascii?Q?gEaWPTJNtCBgV+TM1PA0C/7kGfsVcgmuk8L6yxu5AyYRHAGHOyIxrH3z4wka?=
 =?us-ascii?Q?qZWSLaT63in/lqCOzPaJsUVaucddV2XiDt/ugdjvHvCuyMr006ZWv5s1t9Qd?=
 =?us-ascii?Q?BT7o1xHWKMtggpMvbg7gS5fj9ppQiHVOBpjDSlt44iF2RYzbGSAPg89OwZaG?=
 =?us-ascii?Q?gFofnt0s3/IFHbTklQGN71oikW02diW8Qrj2xFRUIPVnJZLIQLe8R8M+nVUf?=
 =?us-ascii?Q?DITuMKigsvC8KHluHYNkmbBsN1BBErVbs3KLg5adtgEEyUvfPMWXNfZSc3LN?=
 =?us-ascii?Q?1W7hD5rkJL6ydNfVRj1RaHZkLVP7zooazADgc+HwK+Z+1bdW0SlDTSVNWh9u?=
 =?us-ascii?Q?diXcL4/XeNI+0DeLYixVZUQJvGvMnOBhLYeTEink2gpeGVZEZm+MTYV2Bs4g?=
 =?us-ascii?Q?4QXzLbvayBdh5gdgWucN8YxKDgTmcrIb9HOqcs1C/wSzmU2NUQ5FL1kYOTfj?=
 =?us-ascii?Q?fKo/8x4QGdN/y1lCkh4illdY+uwB4eY3CICu6fw3Joe+bj9AVbPxRTfoy/SV?=
 =?us-ascii?Q?v6sX+h1du+OtXYtVJhZqoCa2ZeCanF6ro1L3VlUAVXu61OLcJXE3Rtm0fCwj?=
 =?us-ascii?Q?NM1tUR5G1/ngBJMUR4QWIRcWOByFBs2Fg80LZtzXXiOw1e7Q/zwxj0sYWGSM?=
 =?us-ascii?Q?bPzy6t9LqG50qIindaYSwlByLKD32qQ+AJwPkDXFCRSxYWa8V+eu0NtImxTO?=
 =?us-ascii?Q?BUnraJpUErHo6cf7eU2OEqM2inxD2QV5MVxJ?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:26:39.9729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbdcbd4-b925-4ea9-fcbb-08ddbe6620bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
Received-SPF: permerror client-ip=2a01:111:f403:2408::601;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

On Tue, Jul 08, 2025 at 04:40:50PM +0100, Shameer Kolothum wrote:
> @@ -2909,6 +2909,19 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
>              }
>          }
>  
> +        /*
> +         * When multiple PCI Express Root Buses are defined using pxb-pcie,
> +         * the IOMMU configuration may be specific to each root bus. However,
> +         * pxb-pcie acts as a special root complex whose parent is effectively
> +         * the default root complex(pcie.0). Ensure that we retrieve the
> +         * correct IOMMU ops(if any) in such cases.
> +         */
> +        if (pci_bus_is_express(iommu_bus) && pci_bus_is_root(iommu_bus)) {
> +            if (!iommu_bus->iommu_per_bus && parent_bus->iommu_per_bus) {
> +                break;
 
Mind elaborating why the current bus must unset iommu_per_bus while
its parent sets iommu_per_bus?

My understanding is that for a pxb-pcie we should set iommu_per_bus
but for its parent (the default root complex) we should unset its
iommu_per_bus?

Thanks
Nicolin

