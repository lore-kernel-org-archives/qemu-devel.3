Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE6EC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkGq-0002aa-EE; Mon, 24 Mar 2025 12:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1twkFi-0001hO-Nv; Mon, 24 Mar 2025 12:02:21 -0400
Received: from mail-sn1nam02on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2406::613]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1twkFf-0003kY-NI; Mon, 24 Mar 2025 12:02:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDECDNNkETlcbxd/SLCb0jxoq0Z8g4pphtBLv4kq3dtalf15x1glLmnDcCjrmbrmQIqEctSvkQF2+P7ENUwvrz9R+zIB/NVqfzw7NibO6btrRks9IbSCHvpUfUY/Lr1L54e66+eSdbV1kMjqRbYMpdaknwzzeN/s4zQnvcOvDk2fHtkNvkID8vn+0r5JotGb+qwPJ4hD1GrZMg5Yhxw7d26ocXwwqzSPBIXgcUDZV8yRL5/n7p0DHYItV1lrKBZlTGtVkrue1KLvVCPhmJkmaNYmpdn1gFe6f0v3fRzbGXCLnjW1BqVRLv2YYTi6paDMumDN1fXkf6Iy8oDZvCknDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgX91C/fHMxSiQgY+6TPHJyXNSORIznbHVDTnMXutVs=;
 b=foY56bg3KiaCBDjZ36+GTKlfzOW8cvCoFEajQoHBm9Fi0GlXPlwlyGNUS+OplDkiwJtDONEvDM5MTV9BLfXvBdGQQi6U6+UGC3GKABJYEZccJYM9HJhlTBBDzAfBlRF6ysoUOmwG+TPVuKsLQOdOqC23mCmnZaArX5iSEdT1EePvueJU3V7MBwkXGWz+3JlfHaUHnB9adNvgtDXw+1WrIS4bZ/ADyJmGSXLAcaIKNlvH5zwD+Go6F94SGb6tv3uOqvebRKdFgFIbKa2MaUhB60tYHJFmeeZhC6kc1OVT+ldggSoux5C/2RehghE/8JeIKMjeI26xbP00YWKU5xa2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgX91C/fHMxSiQgY+6TPHJyXNSORIznbHVDTnMXutVs=;
 b=aob2YkB6F4dHoPWalC41ReqiUyWIoRtR2aVoB0JC5X4JPSmSDsjYcPt94zalULs3s8/p1NiKM8EYbBeXLDVG3fdqSkUhxM4xVbyvMVLWI+7fUvZTBW/R/yfDKrooJPj9XoM34DiHMQ1VAbMh3spMt/l5JgzjxyBD2R/aQKJi/TohBfkhthEI6vPNKz4nFYYv0Hul6e6020Bxelx4a6o6AYZFiqoJYMBxjMp+8s1xQghe6HbEpbCnFPzGWpXYupM4Rh13jjEFM2Mw8nsTeiavLAyyW/iRNlNR0ASXNQYNeCyDcLmXGHKigIjo2l7AJEQhXeKCAKf5zLmjKdITbOFFQA==
Received: from DS7PR06CA0033.namprd06.prod.outlook.com (2603:10b6:8:54::15) by
 PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:02:04 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::e3) by DS7PR06CA0033.outlook.office365.com
 (2603:10b6:8:54::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 16:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 16:02:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 09:01:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 09:01:50 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 09:01:50 -0700
Date: Mon, 24 Mar 2025 09:01:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Donald
 Dutile" <ddutile@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Message-ID: <Z+GB7c0ME//DhS3R@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
 <Z9xKL49nOenvQIsW@Asurada-Nvidia>
 <2f84490d309440a4a2ac56fd893ddab8@huawei.com>
 <ad0b5fac-2a7f-4978-9f6b-0f7b1df14a35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad0b5fac-2a7f-4978-9f6b-0f7b1df14a35@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 9401514f-b2bf-4ca0-4436-08dd6aed38a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6pC1Ab/gl2mBqxLeg6Wjo6nOKuAXZ2Wu65019ArqOy5V3RpIgJwFPEES6BXd?=
 =?us-ascii?Q?HoPfXib7Oj5QwvWVMCZM/v0yJC2ycW+1Aonpb3I3yBNTFllB86jSZT3uq2/A?=
 =?us-ascii?Q?FE9hzF977BQrtRqbZT+JzVfRUuj0dYJA/kzyE15J/h90oAQ4HJ3zffodhacK?=
 =?us-ascii?Q?wuKcYp3y9clMRP1pi1sWhsC3j5WDXF0qDwdEnCZ+uCYXYtG75ViQw+RkaPCN?=
 =?us-ascii?Q?1VY1fT9GvLqSYO+13fUp2nzS1hlM1TOGOpkeicAHYAnKp4WI6qhMy9JyhftT?=
 =?us-ascii?Q?KVaAD6/B18GbDKvKvanAl46XrBBZ7niAGXxmuwjcnmn/uZn0jmaIyhCQpoGa?=
 =?us-ascii?Q?d+XZ5mtBAXIyprvKdz/syglmvurO4mC+PUMFjkUUzG5W27mjW6Tt7qajZTxs?=
 =?us-ascii?Q?DAm/gFA5xMGtjzRjOYb8nNalKebr1NNZS8RsxZ54kmjxEx19f+Mtr8eA6hrs?=
 =?us-ascii?Q?rZYEfd7RdeMq2fFVDn/rk4iXatDwyIQwN0/DnvwWmlRQnNF2vO41jzk7D6Hs?=
 =?us-ascii?Q?A/4vmxo60bCYhMqbew8LXL8I0RXLD8GoUl5RzCagNhAVSHzyvO0bZ0d2cE+l?=
 =?us-ascii?Q?XbMfrMjJ/F2oOY08Hs1qQJqnYgpzZ/Pl2+eFA39J49YsGstXlmAX+vyLQipy?=
 =?us-ascii?Q?xfT0glc8wXC81dBT5oYdIftXmksJNOgvvzt2WUQqPffx01QRW57JpXKJwS3m?=
 =?us-ascii?Q?cF2nsc2P/Aj1Td7f11IQ77HunAz39rhYYQDeIcnGcr/K/0ocSRJ7ZQdyB/Fw?=
 =?us-ascii?Q?QdIIcYdmeuAMVeEB1hRQzf0snzuPD14PN5cdz1k6TAdUdujEh0mbFuBYZ0ac?=
 =?us-ascii?Q?ZB0iPUVruUXgfXRvD060sLdJHJclzebkjjh9ksmdK+52V7vNPVMxBhEmevCI?=
 =?us-ascii?Q?Vxg1zoX5ULHrmBia4yYfptwr6OOtBURZfkHdm5Q4ECQn7S92U9MWpjwBb5Fa?=
 =?us-ascii?Q?MgH3hpZQYBXBHXj4wnxoHnJesez6+K6FPwaKZ2uUtXMCNca8P59tz8rOsS1s?=
 =?us-ascii?Q?69axSwUalr/yfBsJxgOcy9NrUTKrnhzqA4+bdsY7FXpABIzhmraEhC622Gg4?=
 =?us-ascii?Q?Ixm/1YV+58VrTvw8Pu4ZgBYh8f+zQ/iM0tX4PxhNL3BpyvVZdri4Z/RjuC4O?=
 =?us-ascii?Q?Y9mejqg2ekmnAO026xcxclolIaGp28UuujZ8Yf58zujONx+jzqjqtqxkw8kO?=
 =?us-ascii?Q?KJf68wjuk9oUlFGFgbAann0+O6isJnIoaN/LS1AZ5F562ETzym98YB5w8LPM?=
 =?us-ascii?Q?i+sylkF+OX9cZqFgqNIbkaLBuY+1ypEO0M0WZewOZVuYUioHkWz/y+3n5nog?=
 =?us-ascii?Q?aCVhwDner/5uxfcoKwIOi1OLPUbv9z75kWArapKPCzm3NWDNJRc2EWVGzik2?=
 =?us-ascii?Q?DraT83gMg9ymgCSCjeFHNtP5OSi/U8g1oYoJ63GueCEHtuocjaxGjp1LVjV7?=
 =?us-ascii?Q?8ShwE07FMSRLsHsoSFOaECLZQy0uL2/yjI7qtYzqZhWCm77StsNnV0JHlO/c?=
 =?us-ascii?Q?takGEvGebtgFfaI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:02:04.4333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9401514f-b2bf-4ca0-4436-08dd6aed38a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
Received-SPF: permerror client-ip=2a01:111:f403:2406::613;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

On Mon, Mar 24, 2025 at 02:13:20PM +0100, Eric Auger wrote:
> >> If VM has an emulated device and a passthrough device:
> >>  attach the emulated device to PCIE.0 <=> vSMMU bypass (or accel=off?)
> >>  attach the passthrough device to pxb-pcie <=> vSMMU0 (accel=on)
> > This can be other way around as well:
> > ie, 
> > pass-through to pcie.0(accel=on) and emulated to any other pxb-pcie with accel = off.
> +1
> >
> > I think the way bus numbers are allocated in Qemu for pcie.0 and pxb-pcie allows
> > us to support this in IORT ID maps.
> One trouble we may get into is possible bus reordering by the guest. I
> don't know the details but I remember that in certain conditions the
> guest can reorder the bus numbers.

Hmm, that sounds troublesome. IORT mappings are done using the bus
number, which is fixed to a vSMMU. Can we disable that reordering?

> Besides what I don't get in the above discussion, related to whether the
> accelerated mode can also sipport emulated devices, is that if you use
> the originally suggested hierarchy (pxb-pcie + root port + VFIO device)
> you eventually get on guest side 2 devices protected by the SMMU
> instance: the root port and the VFIO device. They end up in different
> iommu groups. So there is already a mix of emulated and VFIO device.

Strictly speaking, yes, that's a mix. Maybe we should say emulated
endpoints and passthrough endpoints?

Thanks
Nicolin

