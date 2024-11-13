Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63742D637A3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHkd-00079O-Nv; Wed, 13 Nov 2024 13:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tBHkb-00078b-N5; Wed, 13 Nov 2024 13:05:57 -0500
Received: from mail-dm3nam02on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2405::613]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tBHkZ-0000ei-Ev; Wed, 13 Nov 2024 13:05:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdEwpBsQLh4XiJ2oiIwDYKxvY9MQD0IAA0UCIPAwzzQNI4k3Hfi8d4zQ+QeOZ+R8z4xwhPLlJz7HnXtVO2Yg6s2wvPdotpdOMtwJEf7j41I1OGvtK2xG86xzteVyHPYbPeNS6q50YTmjqWeXut4MIftfz+OUWLZukSdtOqe30pF+roBi5QE3gM3g9Zx2S2fnap0oyPlK0qHD/pMtt1Y05fHtx6AnZyNNPFrzslNtlCNJPVaVOEERgPOAWx7X02kE24V9Upk9u4dXnQXLBLgFQZmxKaq2vaQM455RVK/qsqcjUCAkSD45KMXH+wY10lFh7BomGkj4NNUNZ17G5U5k7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2SKCnrOCfLE7+Ng6CpN5RyOzm5Lde+Arkzq8Mo21J4=;
 b=DsNqRJldDORpfNF7h9RfpTQomJkGuwzFIijDAVmwhyM8RfGfqF44/J/hv4OFrsbwHTqSJcC4K47toS6H5EMTkJLMzPDO30OgRf7tMfDO9nQ1GZglpKhZrfLr6Cx+NO9g+nIJGRpRD4uef68USpIoLLyqYBLAyr1j2pnVvXwXJ6p4crNlX21ppp5OKoYuVQDIR3QmPNp5p9aUziqELuaEIRfDMvgB2+svx5dtFHv5KEcjySfWZ8SzqZxZODBuLV8Vm5u1EF/yRE6blN+aMN9PD0A1I6eZzmy/QYgmtdkx3aQSF0FPiaB8/a0cAg/ZxdjcotC8Ft48Y/EGWkbhybEYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2SKCnrOCfLE7+Ng6CpN5RyOzm5Lde+Arkzq8Mo21J4=;
 b=cnbmQet+08wCUhFccsWx9t7y3bwxnxlGtWoSFBnKO1ywSH89eB9E/NLFRf3fOjseYwvsjAtba///hz0k/eH1r0RcT9g4J6WrdN7H0vQLZHN1vax2W28AmsVv3ECqPCshoQ2ggZNH1VWxYHFjSoqus5yMcc4TJaF/Q3eBqBGrYg0pFf2V2AZ6BnNT2GsVBvl2flzjkdOqAd5IX9uwNzrZQJuuM3XLbjOQGr7US1iedyV7j0Wj1c8pRM0mQfXp0epDjc4jSylRh63tdNkiEyoW39FfX0WKYLUK8wR8kaHFN73OfOz1/f0TPhl6DQgjXauVic3OyILjeNPVP4Iz5ZfkKA==
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 18:05:46 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:33e::4) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 18:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Wed, 13 Nov 2024 18:05:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 10:05:19 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 10:05:18 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 10:05:17 -0800
Date: Wed, 13 Nov 2024 10:05:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Message-ID: <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 275e0605-80db-4d99-00ee-08dd040dcc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QJh+UgdG7foyRfXfYtBhCZOVieQPIvpsKJDcF16i59rBF3kdW1l7FMLTkXVp?=
 =?us-ascii?Q?Sxoqu7l0BOaEI37QP8l7khD5z3Dr8lMs3j6V5MP0pppKxqNXHyj8Z95oPZ3N?=
 =?us-ascii?Q?WXOjL/k4y3DtHakmzHi+vf0C0K3zzmb0V6VuLpVbLch19uV8fbAR7Ds9TmMy?=
 =?us-ascii?Q?gLKe80yEby7LW6jGnGpKveDB9eNgEU0P9bZrqTUevyPw/jczt8K5tOmHSo42?=
 =?us-ascii?Q?Yk/EfakOg8LH22FiE+YmqeAfQvjTAbilQFMNjqCrhdEkP8yAAFMjZAZhRMEc?=
 =?us-ascii?Q?jtCw6InrztOPC7Q1YHJrDAQZqknMSfdponyagGtguEo3Y3dfMLLL4VkrixPE?=
 =?us-ascii?Q?NbksfXJDA4ack8YyO5PhF8aSbfgPqBYYlvVVVnYU/UTdTbpCEbsNohboHCeV?=
 =?us-ascii?Q?WG6XDZsDZLMUazLSbAQvM6YeUSAJ8BdRfEVPaB/JyXO5NEonUX271hLo2IwN?=
 =?us-ascii?Q?zp9J+ps4yBpRPCoLq40wIAUOKU4ugZvJcEQwH5ggcaOaVk+61Hhuo3s5f+/b?=
 =?us-ascii?Q?2/LcrSNa3XbzTpH5ZZS0QsDCOHWARO2hJrFF+BCZaYYtBGMr+Zrr0HqEmS+j?=
 =?us-ascii?Q?uiw9TDnR5p9WRMvCuCdw/FRS0Is+Yn5/7Z66dDK9YXce6pRP6GKMseXA2QSn?=
 =?us-ascii?Q?JmA2goH9FvodGMyDaJxMER5jH/QaikKj3rUVWZi2C5Fs6+QcDZGI28y1SR68?=
 =?us-ascii?Q?chUoPk06SPXr6yr65ugSsRvy+EMv35/lGKLQz09qx5Ub1mVb37+OarLoB53Z?=
 =?us-ascii?Q?FtW9a7j5VMeVXRf0mX7AI99/JOekZg9COMkwxXcZ3A4OuwRR9/gjEsdGA1xt?=
 =?us-ascii?Q?i6HNR7/NM2t1vzNhbsq+AD4CNrGTJpuNdYoIobjubq7sfow8DBZUr/zXPUQ/?=
 =?us-ascii?Q?nEpV55PAB3lSnqkHMVWnEL1jciIq1NWB8xWkgaN497hbzmpRjkqG/tnl/XxJ?=
 =?us-ascii?Q?tc16S6shREaWx+a0pw8hplor4CXZt0DChiX2l6T0QdxXRxY/Aseoezkl89da?=
 =?us-ascii?Q?FYTCQGUDc/z1n5OWbLTwdQKI0Um6Sj8utI5DSi9caHrKtnQyERfxRaZpCa2a?=
 =?us-ascii?Q?ohB+dOUYLi7y+YBmWm46uCgTwARPN8MTxtMjA1wrtTIbTHlrbmk9+wSnx/uE?=
 =?us-ascii?Q?L1lTOogCS0FNbIJHcj/wty9P6/XRe3pBRJvLYhWuAIIkOszV8JoTWXSx3PcA?=
 =?us-ascii?Q?VCJLxnJOE4lNLpz5o5aUKN/bLu95hyZF+fwiQUAWIWe0N/+XlaQ/evo8HiFG?=
 =?us-ascii?Q?JrsxcDYdVWMAjqniPVSRFpYOTiCE+FptqLRqA+FCyRK3WeRw5LpnQFtGitCb?=
 =?us-ascii?Q?/2bZN7RwwwDWlvDsnPsSuPwlbbNekh13FgYyjCt6oZOH2SM5Z/5884FRjrc6?=
 =?us-ascii?Q?cbESKEpSPjW8jEpfZpHodJXl7SGw3vQ5ehq8Zwqsvm7wxHe2AQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:05:46.1911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275e0605-80db-4d99-00ee-08dd040dcc38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806
Received-SPF: softfail client-ip=2a01:111:f403:2405::613;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
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

Hi Eric,

On Wed, Nov 13, 2024 at 06:12:15PM +0100, Eric Auger wrote:
> On 11/8/24 13:52, Shameer Kolothum wrote:
> > @@ -181,6 +181,7 @@ static const MemMapEntry base_memmap[] = {
> >      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
> >      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
> >      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
> > +    [VIRT_SMMU_NESTED] =        { 0x0b000000, 0x01000000 },

> I agree with Mostafa that the _NESTED terminology may not be the best
> choice.
> The motivation behind that multi-instance attempt, as introduced in
> https://lore.kernel.org/all/ZEcT%2F7erkhHDaNvD@Asurada-Nvidia/
> was:
> - SMMUs with different feature bits
> - support of VCMDQ HW extension for SMMU CMDQ
> - need for separate S1 invalidation paths
> 
> If I understand correctly this is mostly wanted for VCMDQ handling? if
> this is correct we may indicate that somehow in the terminology.
> 
> If I understand correctly VCMDQ terminology is NVidia specific while
> ECMDQ is the baseline (?).

VCMDQ makes a multi-vSMMU-instance design a hard requirement, yet
the point (3) for separate invalidation paths also matters. Jason
suggested VMM in base case to create multi vSMMU instances as the
kernel doc mentioned here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/userspace-api/iommufd.rst#n84

W.r.t naming, maybe something related to "hardware-accelerated"?

Thanks
Nicolin

