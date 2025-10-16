Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0060DCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9XGf-0002EJ-Pd; Thu, 16 Oct 2025 19:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9XGd-0002Dw-BK; Thu, 16 Oct 2025 19:20:19 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9XGa-0000Em-0B; Thu, 16 Oct 2025 19:20:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqalGdRhjGMxSYjmi2EfsUGlsdi9Wk+/MYM4rwvtLwUnpwGLogGwBc870ZwUkUr2+3UTcbnOlqoUjpgwqIGJW2gSdzUwtODmilDPLRBEoyg3YldXjKP1Oblk0nQkx6adWcOgylYEMpxWMadVhqELGAYYY9wvJGEOCVFnuGpMm3nN8cyNPBNPnEBx+5OzTk1/NMhQTNMyoWq/8aX63M7GNGdV4ZJQsOXUad4yFpSCCuVccPlhMXTnXDyOEuX9Oy41g7RRIu2DNSKJHvnGt+6z4jFexZbzzvmm5ySPulpB0AaXkm2uB0JRg0c4cjTIHTTlrnCAqalFHGC/7/gaaRLIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/697P2g33FE8WQuTWasnK05wv+cqCjG4IbizRYQcLgs=;
 b=ZORAcdDVl/7TKmM/JDVmWObu9UXUhc9DAB4xW827D92zl0og9sCYZUyOB/y5+AKA3K3lVYnG6QyarzRFgu0rj11eE1Xn8LdCpaEYFvKbaPb248JHz6CEDqryrnDxkZBF7idgXrXjj3WB+t/9PeBLDiWHIg8bA8yVTf4JEUzBbcerkJXNwz8QNrfocUXXhnlfYfIw/m2Z8vnKP55LVZqgx+encQoEljlr9+DLRsjXJySo7JsJSwfVyP02l8GSvaIF6p5bGUNt2pkq9uE/mBv/5oVJr1yR5tGf6+9RXuYdAqqxSfS1L4Qs0SrAroSvIpCfNdAIuhBoCKdH5Ju/3KDgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/697P2g33FE8WQuTWasnK05wv+cqCjG4IbizRYQcLgs=;
 b=rBARkTN537CdOT3wAZo8ikZEl/QiSDFeaYbcc/TmDBtEAED7hvm83JD735GrTOWgKUAtjBvIzEnVGrPjSBKw3QG8oeKwyCsaJKobLGoFgyq2h9UnVbohj5cLYo67BGOb0saA5C3PFpnbOOcwmabNKgL+5J3qsn3lsMedpjDe47ZrUgeyFIglfe9hMQgTPmso5CWDdbbmCY/qqPf6cg3PJH33inygtxardejNESWoe/ipUL17WTk/07oPPkAuDdSSPTiaFo8AMJR8JsAXvjjnMgFBzmW+Ovz4N4S4tnRCl2N/1VIPmgHKHfMN0ewt3OqVMAaI03YrJInYl2mI/NvADQ==
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 23:20:06 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::d8) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 23:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 23:20:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 16:19:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 16:19:53 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 16:19:52 -0700
Date: Thu, 16 Oct 2025 16:19:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Message-ID: <aPF9l5GwctGN0tqT@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250929133643.38961-20-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edaa16d-f9d3-46c5-2475-08de0d0a8a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l1wb3TszJwugdP0AhrgdRrLUfik8p4J3/hT2oMuORlMq/weG2PDdgnIMcz6D?=
 =?us-ascii?Q?cLK7ccvvd8HDkzkT1mnMNwXWW8RouH+l9uvEQSxZ0X3K4iEwOXVNFFoFfogI?=
 =?us-ascii?Q?5uSubg9kDASzrCL06g0qUWt9SSYNweCKOecmRhT1sEuzzVi9JLRmCjura4W2?=
 =?us-ascii?Q?HXjaSDA+aAmUShyCIfkPTSv28f9KL11l3Cr8jd59qb8eMrhiWwTMkneib6ZA?=
 =?us-ascii?Q?/hQMWttbzl2+/Ti5oX3YQoT3vKpX5TVOMd8lgTvla8ky29sn2GZFfTwGFfXv?=
 =?us-ascii?Q?C4aIJ6rRrUCppv2MLZktRHVwXQHi1Lops67biic61CYOx0E/TVTkbJVvbH3L?=
 =?us-ascii?Q?Cmls4RV+Gyg5B3ZqUjI9K1u55z3L7hYWXgRPTLTuTs0c56n0md2vT5NVtsAf?=
 =?us-ascii?Q?n3LNzjpFlRkuScVT+5N/r+Fkh2BtcvqvsOeF9jfWsuSEeXxVl7c8+lrVpskq?=
 =?us-ascii?Q?h6l5FM9M4yvNGBnFCY7Wj8sq7yxdrBH4f/aDNR6D1HSDnL/RSUJHSeqAKUn6?=
 =?us-ascii?Q?hSvGpIs659ZQkoUpbeydRXnIac8KKkur33IzEYSzJUxg9C3HpLpceTuukNN0?=
 =?us-ascii?Q?ulWtmgA2ef4TBAYRdujXQM34HoBbEN1XKGWxsvlgWqRkjBNK+T5CIV0ClUJC?=
 =?us-ascii?Q?K4VJbMMQGEdSwul3Nd2gI4rq5mKXCZZctBiIs6MUvBDWugVG/5PvzrjWULGn?=
 =?us-ascii?Q?Mc5MeqvMaZ4/RkL24HD29fqpVjKimuXUkaOTlTbr0yNrA1ce8kKO0/Z5kg/o?=
 =?us-ascii?Q?tcG14ftafxhjuB8czzEFHMEtZBHAhbpfrxOPai3Hb7kh7eKF7MW3mP/y/P5X?=
 =?us-ascii?Q?yfl4iLrNA6xYufT0maBR+2GfJeUC3F8RsQoqffaDZZc1CzfnAlYIToYCC47O?=
 =?us-ascii?Q?+LK3RGo708VBZSqx3NoTN2CStQbWdE4MG7zm+pHlxbXqtTLS3C3hJu73gwW3?=
 =?us-ascii?Q?ORM1nnLF2gq2xnyMXGnHb/BX56kGPma0VzOZMI/hZ17OC0ZgJQEA7ah+rWPw?=
 =?us-ascii?Q?zhjHZWu0iKMctB7at0Udggdr1/EzO4ULnVel1MFIycFP1GitrJEecl1GWq9b?=
 =?us-ascii?Q?FvTRGTcopA5mQ5nymiokwoa+1YuNfIzXNG1DLa6sd58Tw5Y0G8lYd0S4jTB+?=
 =?us-ascii?Q?mPUYwW5uB9JA1Yn0f0Nduk11zzqnHCLRymFuQZAFt0R+Z8YszM5U95Obj+fH?=
 =?us-ascii?Q?JMMrhEYonT2MmlaetWeH0mY9Zqxm9W+rwYUeh5VQiBaxMXzIRzr1iLseCaRK?=
 =?us-ascii?Q?V2aUY6mcrzcFfLxthz7rSaQ3P4f6Qjl3F/pN0kMzvlDZYKHR4/Qnj/Q/SJjg?=
 =?us-ascii?Q?YiTxmo4jPDFiISgsGUXBKc5UBKOUgrCKNzzOVkk3kR9WjKvy143I5zhnOVN0?=
 =?us-ascii?Q?bCG2aT+5aL1ngR52hDmkWnV6d2Sq7V37nghileQdHrrIRvQxDqvG/+TwXVyp?=
 =?us-ascii?Q?ySx6NptEEZhADfZ59T4QPKFJBtKQfx6GMJ9agqqwQQ0vg/Doh5ivHTiG+SKL?=
 =?us-ascii?Q?bAZS9xa4sVxk7ymh2iqCqS6GK146HEYoE3C8qBLYQz0R36YMsPCOoepsyMQJ?=
 =?us-ascii?Q?r32m1yGNkkkXs9ckWjs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 23:20:05.5698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edaa16d-f9d3-46c5-2475-08de0d0a8a67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

On Mon, Sep 29, 2025 at 02:36:35PM +0100, Shameer Kolothum wrote:
> When the guest reboots with devices in nested mode (S1 + S2), any QEMU/UEFI
> access to those devices can fail because S1 translation is not valid during
> the reboot. For example, a passthrough NVMe device may hold GRUB boot info
> that UEFI tries to read during the reboot.
> 
> Set S1 to bypass mode during reset to avoid such failures.

GBPA is set to bypass on reset so I think it's fine. Yet, maybe the
code should check that.

> Reported-by: Matthew R. Ochs <mochs@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 29 +++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  4 ++++
>  hw/arm/smmuv3.c       |  1 +
>  3 files changed, 34 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index defeddbd8c..8396053a6c 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -634,6 +634,35 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_msi_address_space = smmuv3_accel_find_msi_as,
>  };
>  
> +/*
> + * If the guest reboots and devices are configured for S1+S2, Stage1 must
> + * be switched to bypass. Otherwise, QEMU/UEFI may fail when accessing a
> + * device, e.g. when UEFI retrieves boot partition information from an
> + * assigned vfio-pci NVMe device.
> + */
> +void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)

We could rename it to something like smmuv3_accel_reset().

Nicolin

