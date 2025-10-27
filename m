Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ECACCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRPi-00081C-U2; Mon, 27 Oct 2025 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vDRPh-00080Q-3m; Mon, 27 Oct 2025 13:53:49 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vDRPb-0000nx-2t; Mon, 27 Oct 2025 13:53:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+OaMfYSCHgGwlDImZAljU0yrYireko6aTHujJ48e/V8YWh4v5NMooSt1R+hdosq2K1QG54DugN3PlmSLziGgMwVa7l58ow2deRkAh2sq4H9htq/q7Mq11YsW9zn+5/GJ0Eum+r3ss+VT/tqlNTDCkoqeCcH0Nc7ZoRATXSTF/0HsHhBrHL0fp/LSDYmgXddMSSZdEmYSSpfcFkJ9Uyx6giOH6CzyoHZugdUV+9vK1T6zNQWu4iC0iiqAJEvvf5tqzZHnsf8Bg+1qKxYfr7xXvnvEzafHPkNCZeuLaTuULy06u970KY3+YgoYZFR9byr0LPP/boFpeDPJH3VRSlNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJirw9ACbMXsM730WGXd2DfiMWIUmxNlT3Rg1CTB+ZM=;
 b=BU6flg6p+BkmlKXGRpJqwdUQuzUvXtEhtzJ6CzZRQAkSHBMCiobzdRH1NIbeG0vaoM+B0TT0wsQsxcez5wCmT7IGJ/7qmT1qFM7ZBzeDL3+DpQ+Rf3jdnLFhdahfqXBxh4ATCSEmeMEUkeBdVw7KM94WCtO4HuUYHjSxQNFOZOpPYuJIw8aea06ObwZb3UJudNni+keJjQShMbJx0wCx/LBd4/X1g/H+EATQ0j5gS2e4DJihH3rTEh2EL9dGWcsk9YGxVA4niGm0aJG8+VB9zx8TKpyAlTmNtWuWSbj+CshsEnaGvtqmVh0/S1jrP7DHOQ+Xkh9A3KVJLo+diPjAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJirw9ACbMXsM730WGXd2DfiMWIUmxNlT3Rg1CTB+ZM=;
 b=Cr8euD2L7/jaAYJrbmV7HqwoXs7Eqq/v/BS4uMIVr5l9INVTpeXccqxs9GvBNLQ39rh3oTydWcGSsi+zkuJSWB9OlJvaBVNyYux2fbLs1Anw7LC2BsNhMAjMNjV1t8oaw0a9CEL+47WV3+b1Ko5WzgMBmHVHhIPg0mTxivIyXWZZ9SzW4Ylbj4S6I7XdvQT6TAOE1qVF/8Jd7cM2t64nB+ISEIZl5eFhUkC47OZ6c6rIA6irfYjYzXS4br7B+K3/kBUi75/UdZwFQZo5RCdpHtCmIQ2pTtzdzAgGhjEkjNqesNXzpObN9yn4mcEV2jsAAGvxiulXdPzl3ZkxWpVe7A==
Received: from PH7P221CA0051.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::21)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:53:27 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::b8) by PH7P221CA0051.outlook.office365.com
 (2603:10b6:510:33c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:53:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:53:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 10:53:12 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 10:53:11 -0700
Date: Mon, 27 Oct 2025 10:53:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Message-ID: <aP+xhmLCRu6y0eQm@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 04241af7-d162-4758-0f04-08de1581bba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ka5kdGofJorDzK65MOXy0zpIwPjd3xs66zkx08ZQA5/jpT3wn/poRFvPsIds?=
 =?us-ascii?Q?WVKdPB1PzqDynKRIFCmwAvvLqYUcKa/o1NMRNzIY/99B9HAplR3aPHzKsLOz?=
 =?us-ascii?Q?mlelzUZAvgDG0gZ9YBOjXucUB9DuXfwYE8ExIA7rgclmqd18LYS+nbFpPWaD?=
 =?us-ascii?Q?QkSMserJy0m+W/j9pSOldOrpPMDaKZWFbOk8ZeUKOg7il/KGBUNd7P0FTK6M?=
 =?us-ascii?Q?aeZCr6EHuia/fU/ixYRuz1JWpGTwQRDBYyHZAsMmGGcXLtXu+9BMBYpC3+7l?=
 =?us-ascii?Q?T10lzfi8pUprQpw4rz4hZ+cEXUv7uyq8m1fdHeUuNzt2koyZeHhfsEJILWt6?=
 =?us-ascii?Q?tgOFhYlifK2uUmPaT3dS1R8ogpLCZw4ZFCujim0tVzpaBs5F23tV90YxVBjy?=
 =?us-ascii?Q?XxZj7qO5wXynzhvP539MUrp2gg6Lxqnv+dE7RPtLSrFsdMKEU+hmFgAQIYgB?=
 =?us-ascii?Q?15VNTDMWumTTHRs5tb76WfqKJWW2gOHED3I9tAjT2+6L2tUdyK7vrOtBQrDe?=
 =?us-ascii?Q?e9KtR7Iw+DeM99vq1b2bu/jeA8tcHb5pRG32fUIAZxy+LNOO58pUPI341GEJ?=
 =?us-ascii?Q?JgsSuHwb2p/f11KG4HsrQElFEezAzd5YYHo/yPij8/hu66nWCtsV0NGN8GaT?=
 =?us-ascii?Q?5zYUfSw2wu52EU7aKMQGJnUSo/EaPvKxlI4mS3yCIdVMDD3zgaQmPMctinM1?=
 =?us-ascii?Q?C10fCSUDS9ZTozsch9VkIByjhWRUh77bwj3yqe8p/96YgwZZ5BAdoXc4Nfug?=
 =?us-ascii?Q?NPyKhsCLoDuUDyzI1Q11uxP6iR6RB59NW489AG3jR4ovWEYNA5lnuS8vkNZU?=
 =?us-ascii?Q?NrQ0yLfsdcdrYX4TAKlL0lvaal9It60K+fZMHY+8fg3W5/MB5uck8+3ql3SU?=
 =?us-ascii?Q?tWk4nk5tQl14A2XV2UmMZgdci4dGUo2e0jCFBpV0zsxWjx/Cw63Smpwd0BYl?=
 =?us-ascii?Q?DMKV5/yTo0rkRhjVuHFfjJNsjj1g6sdiT1Hpgbrvotqov2iBUj7nTNfHv1s7?=
 =?us-ascii?Q?2BCYZyYlPQF2mS9BpjiCqKlLP/pwqOWJwqkv7GBs2UXkENztttRh3xEbEla9?=
 =?us-ascii?Q?+0em44gxKb4blcdTTu2IFk3on6rVMHRlN8p9t6e4f0NRXryOs28fQSM+DVr5?=
 =?us-ascii?Q?Bh2zO3jnGtguZQW9cNY/aXH0Chu0dqv004u8hB3zxptqF1GphYrEHk8uGu1O?=
 =?us-ascii?Q?Wj1We23RC4b3sNXRgBAZ+HoGSGzwHC5fFW5R33xMFqYwl+NEmeoTW2sTHP/S?=
 =?us-ascii?Q?cMR3vW/3APhquvfJquptMlKlE7IjmCrvazAQdPSlfA6hxzrg338roFDKB4Ke?=
 =?us-ascii?Q?2zx3VDPSqS032coaC6lpFEgZCfzCiqL1oY02HskVBSyMGvGXrL6eHr15tb8e?=
 =?us-ascii?Q?11z3NtTm2CAsLDjAqK+JjLfEyqJuTQac5m/3VWBUh1ySk2Hgjo4PKsLOv9Ew?=
 =?us-ascii?Q?ZZDGX+qa6Jb4xe8YYb2maulX6HjbN7HNes0CM/2aRsNajgWAZBT+TkiWPOsi?=
 =?us-ascii?Q?frKYhDe6o0PGEvRQV5XQvoCg5I1kvu1IMIUmxYK0J+ySooccAuPodErS05gg?=
 =?us-ascii?Q?pF5Uw+4IhoR21t+UDRQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:53:27.4927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04241af7-d162-4758-0f04-08de1581bba5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=nicolinc@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 27, 2025 at 06:38:08PM +0100, Eric Auger wrote:
> 
> 
> On 10/27/25 6:13 PM, Nicolin Chen wrote:
> > Hi Eric,
> >
> > On Mon, Oct 27, 2025 at 05:59:13PM +0100, Eric Auger wrote:
> >> On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> >>> QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
> >>> When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
> >>> be useful to report ATS capability to the guest so it can take advantage
> >>> of it if the device also supports ATS.
> >>>
> >>> Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
> >>> registers alone, as firmware ACPI IORT tables may override them. The
> >>> user must therefore ensure the support before enabling it.
> >> This looks incomplete to me. ATS is a big topic in itself. I would
> >> prefer we do not advertise it until we do not have full support for it
> >> (including emulation). Comparing to
> >> c049bf5bb9dd ("intel_iommu: Add support for ATS") which was recently
> >> contributed we miss at least translation request implementations
> >> (PCIIOMMUOps ats_request_translation callback implementation).
> >>
> >> See:
> >> https://lore.kernel.org/all/20250628180226.133285-11-clement.mathieu--drif@eviden.com/#r
> > In accelerated SMMUv3 case, ATS translation and invalidation are
> > done by the physical SMMU. Wondering why do we need this?
> 
> in 06/27 you still can have emulated EPs hotplugged in the loop, no?
> 
> I remember some discussions with Peter who was also reluctant in general
> to introduce some partial feature support. I think in general this is a
> good policy to have features emulated and then accelerated. That's also
> good for testing in case we can bring up some test env.

Hmm, that sounds a legit reason, though adding the ATS support to
the emulated SMMUv3 isn't seemingly a small effort...

Also, do we have any emulated EP to test out ATS translation and
invalidation from the emulated SMMUv3?

Thanks
Nicolin

