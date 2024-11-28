Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B805DD70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGj9j-0002JJ-U7; Thu, 28 Nov 2024 13:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tGj9h-0002Io-Eu; Thu, 28 Nov 2024 13:22:21 -0500
Received: from mail-bn8nam11on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2414::627]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tGj9f-0004TW-IQ; Thu, 28 Nov 2024 13:22:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYYBPMM3Cdkhy0hHNXRBT+YA4XLoTMx2YcIDACiVpbs7jP9ZeD0CVQnOK6YzoH2H5UcoLsjyuqz/b6LwuOphU0RrOLZHDlaVFKPVbRksrZKyz4yWj8smEr4J+YUTWcNZFdvbpHiZoUA7vycOsM8jgEBzBL2iXj06215m/W4/ktOEwC8SXlgdhx2Va2200Wwa5zA1sQqH+xM2K5DZIcUlMCIWhVQFORQySWC4GxwNoHVpvOLkOVeA1z1bNFNu8kEa+ehr9O1HY4+rC+6Yk57RfFZtUcb4a9YvR4yU9tBV3Km37ZK4doRVhFUy0ZasXi1KQmmd2vVWP7ceWZBw8UzF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+GYn7tgyQiYGOT4naAs16XTwn6CLmhJTdcl9s2il50=;
 b=fjT2BkOPj4SMOlX/Qo6VrL+mW9K2Ew7roDlaUFDJd2c7xktZoVsiO7qHv6mbPeNHiZViOMWOgOy733Nb2fTVnU0fw6Pxndzo9Pl2TSokuIwnBSo+/sNCfabcD/KxgcWgvCUHQ1TxH+v9R/UdjFdWupsSdV/6KJCg2e5B7RhCKi2z3DKeGazNMShl+QOCObF/uNkhdgbAh5cq+L2ND+6IEyRf/S4r+q8aDzw+6MEo0A8DvshhrrpSV8zNB2VVN0aSp/WOztPhzNBKfDi0maOeRMVZEwaC4yA2C+h2Y7fdo6gBYiFAZBdp1l8VW9Y3HOQRzTNRHK++8kyTp5XZmLLqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+GYn7tgyQiYGOT4naAs16XTwn6CLmhJTdcl9s2il50=;
 b=RqwrhK74xizyOt8iMyApehL6MwdjtuQ/enTh/H4ZVWS/Uv4rP1zBpS0WadnudIp8E5qTq8cCOdo2AcWTSJumJnDMiI1Xf9hQZYnnQdRsYkO7Ypy3aZSLRoojJ2D5n6bMbIuXqW7fKbkHxTKO2lW/LyrEub4a9qtJAmvb2jbXKQUofWIYEoS9KXS3wXjTP3f5ml+11Pa6/Keqc+wi9aRC45wChGQNmtOP9ST0QbdND42nlNteg6nF+taM/fu39lDlLtRA22drvNODQyf43AXXmqMwRx87/y6Jg9bbiDxrbZ5DEihLT6e2JOqT719zQyClFRZXC+5zIl6Al+4nNW+U2Q==
Received: from BL0PR02CA0122.namprd02.prod.outlook.com (2603:10b6:208:35::27)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 18:22:12 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::99) by BL0PR02CA0122.outlook.office365.com
 (2603:10b6:208:35::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Thu,
 28 Nov 2024 18:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 18:22:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 28 Nov
 2024 10:22:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 28 Nov
 2024 10:22:05 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 28 Nov 2024 10:22:04 -0800
Date: Thu, 28 Nov 2024 10:22:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Donald Dutile <ddutile@redhat.com>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Message-ID: <Z0i0ytKDroF0zx+Y@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <04c73d87-35ce-4e11-a906-17c1e2961387@redhat.com>
 <Z0f1P/Tie2Yhe1dv@Asurada-Nvidia>
 <20241128125426.GD1253388@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241128125426.GD1253388@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbbce65-2781-40bd-b38b-08dd0fd99466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iBarN6PP1u5wxpW9by7PrbJfGrnp/qAulyFKthHx8AofrDvZF4ClSaMXNtrC?=
 =?us-ascii?Q?4rvtubpnSGroFalL2HjjCZv8K6kltCkL5ib3HejzE2hOQI5xBZfSG9VwLt2v?=
 =?us-ascii?Q?lpKtRnT4p4z0gLvqAOXgjh9oQVejzKFIQh3H7XZsMEgPk2zteMV21la5eL/d?=
 =?us-ascii?Q?2e2EqV9V8+gp0MFoWmFB8xrMJekpHP+hsyOMvwalel2fkmxGYBKo7mlbmE2J?=
 =?us-ascii?Q?osVJucydYaYH1h89mivtZKTcXFwUwcZ6w4B7y9DbgqGKVzuq+ovjAXhMbdKb?=
 =?us-ascii?Q?kmzakGxv4RYX4VgUKeTXZ7A4pBLz0r6t7l5w9iSWTto0cjQLRxfFNblBmWlQ?=
 =?us-ascii?Q?L8wLWxcu/HjAdVuKMrvplxZYUS4U/X/QjF07FUNdRi28rf+wRK+Gwu0lZPAk?=
 =?us-ascii?Q?sE9IEUJFgwbnM9tUGsHdRYPfIqpSQAJ81P2XuuCuZ/JSeZLnhzp3WH6RH7Ym?=
 =?us-ascii?Q?nra0WhZd5vq/OWgA3EUqTOYSHxRk3x7bHzDt2NMF0iLAvmjxaGHD7itP9O1h?=
 =?us-ascii?Q?UNG/agXoDefkLm4ZD6p4n96uI7YievZvQm1iF5fSrgcpH2yZAOqxmtLLzmoQ?=
 =?us-ascii?Q?C0F8F5cBujtd1n9/eYRUAz32u8gjSV7pSXAN7Q2HeJo2pzyn6pHw6RFcKvjf?=
 =?us-ascii?Q?4mLTnREzSbGypdg6dRdyd1vhHQvxFLEIkpawTEDECsuUALDn4ptvw+4vil0J?=
 =?us-ascii?Q?aaTk3cilw88pdoBjT1gSVdZ7XkOlpWcpN3LSxoutHualrzgxHViBQDZhQOHh?=
 =?us-ascii?Q?I3/L1eplJSuptPtB6bXF/jCyQU1Qsa9iRxTk7LxlTDiesVZ+0UpHnFM4rCW8?=
 =?us-ascii?Q?6CarloN/vJ47ssMpM+rYtewXJWBmexyoXeXrDXuA5ZgviGnc4CwaOdLY9X0V?=
 =?us-ascii?Q?Q15Va55oFsrW5amBvvoHPFDgmnvGma0Jahi01WfppLX44xLXZbvamxC89ylE?=
 =?us-ascii?Q?dHU3pAQZbPOCKRXQGt2X63kg4x/9Fp0rrKedn/K8IqfFj6rnclBDPr1ezdOp?=
 =?us-ascii?Q?xg5XdMEqGCIyQyyIrqm8KGE0xq4ARFpzuUVK459L7ibcKpjna44WABQ3R7FK?=
 =?us-ascii?Q?efiRyeTyQ91sjoGFgjoGIhk2Lo1OdeaMoEH2vuNkVcZN/q5Wf3nxjh2NZCab?=
 =?us-ascii?Q?Mj6a1UjM88rzd1/EB7vcVVXqwNOpK/gMdNan+CNfG2spO/U3LcUBB53OnEjU?=
 =?us-ascii?Q?ZtOSShawoQW70ws0Ypkw41hfMD+VYm4LHqA6Rs6xJjuPAGzn8EoqaIifrsK/?=
 =?us-ascii?Q?4kUk0Tu/GDJgH5+hX2QFe1uet37pwJ6oI2P9SJ2pAbcydMQrDw5lIPcrIjzm?=
 =?us-ascii?Q?OCThoyqpQ2PZtK5VbhqK7iEzTahQWnw1ImR7xu9oBl9/4t9LsXpJMRmm4+qE?=
 =?us-ascii?Q?PcJ6pEQRk97lm+rOFnZuiYkQU0nubODfxkGi84buhIAXaAYwjY1OX/KO8vp1?=
 =?us-ascii?Q?t4F4tc/b/B4TlI83qjrbKSfMtXzq/6zl?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:22:12.6525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbbce65-2781-40bd-b38b-08dd0fd99466
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
Received-SPF: softfail client-ip=2a01:111:f403:2414::627;
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

On Thu, Nov 28, 2024 at 08:54:26AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 27, 2024 at 08:44:47PM -0800, Nicolin Chen wrote:
> > On Wed, Nov 27, 2024 at 11:29:06PM -0500, Donald Dutile wrote:
> > > On 11/27/24 5:21 AM, Shameerali Kolothum Thodi wrote:
> > > > > > W.r.t naming, maybe something related to "hardware-accelerated"?
> > > > > > 
> > > > > Given that 'accel' has been used for hw-acceleration elsewhere, that seems
> > > > > like a reasonable 'mode'.
> > > > > But, it needs a paramater to state was is being accelerated.
> > > > > i.e., the more global 'accel=kvm' has 'kvm'.
> > > > 
> > > > I was thinking more like calling this hw accelerated nested SMMUv3 emulation
> > > > as 'smmuv3-accel'.  This avoids confusion with the already existing
> > > > 'iommu=smmuv3' that also has a nested emulation support.
> > > > 
> > > > ie,
> > > > -device arm-smmuv3-accel,id=smmuv1,bus=pcie.1 \
> > > > 
> > ..
> > > I -think- you are saying below, that we have to think a bit more about this
> > > device tagging.  I'm thinking more like
> > >  - device arm-smmuv3,accel=<vcmdq>,id=smmu1,bus=pcie.1 \
> > 
> > I wonder if we really need a "vcmdq" enabling/disabling option?
> > 
> > Jason's suggested approach for a vIOMMU allocation is to retry-
> > on-failure, so my draft patches allocate a TEGRA241_CMDQV type
> > of vIOMMU first, and then fall back to a regular SMMUV3 type if
> > it fails. So, a host that doesn't have a VCMDQ capability could
> > still work with the fallback/default pathway.
> 
> It needs to be configurable so the VM can be configured in a
> consistent way across nodes
> 
> autodetection of host features is nice for experimenting but scale
> deployments should precisely specify every detail about the VM and not
> rely on host detection. Otherwise the VM instance type will be ill
> defined..

In that case, we'd need to expose a vcmdq capability somewhere.
We do for vIOMMU via hw_info. Should we keep the consistency?

Otherwise, some sysfs nodes (easier for libvirt) could do the
job too: num_available_vintfs, max_vcmdqs_per_vintf, and etc.

Thanks
Nicolin

