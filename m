Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1885BFCA17E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgQY-00056t-1g; Mon, 09 Mar 2026 15:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzgQW-00055n-Iq; Mon, 09 Mar 2026 15:38:04 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzgQU-0006W9-J9; Mon, 09 Mar 2026 15:38:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1ZebZujCKTEdRr/spgcCenvJ/kPWkinGV08LHhOj2Np9ikGbwazczhIAYZ179dzhcw/DsAdJGZSP1u+JcbaF6ZPTvFbqQwVWhjDsv+lzuTtdFO8RH3JZLYwyfr49IST5jdlP5FySQewu4sQ8UGyz90PKFPKR2k+OR9lAMO5Od01nZsWFvBET9044Xa3LDwqdv1B/NAyHq6wExlszmw0F+9Jpqdh/riBcXLMnsEe7Yw5r7p5GyEYyZsjdQEYCykCEpox3lTgWI7pxM7kg9hYwNpYkN5/p7VsTmSXojDrL1h+5cx/OagiHTAnCfGOpEmIugahYYwSspQYs50B7A99Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD9YPqRGoptIK1b2hXF0OVDeQ7NmwZzpxuijGAwT5+M=;
 b=w5Qxv+yiLyouAMr4MtQRJwwi3AYhKp/3al/SD5mdNp6mUhrTnoLEOkwXcX4CS/DX4/8B7hKraCRB6QOEOjWJ98fCC7ono1BAgzLLo5wHoMXI1f8Cl/f7qN3Ipj8+IK+4glM2GMYIy2fESlqy1ZqaqjaTh2I5bGpYRNU2MacJYJ8UZcIU1DXxnu4T3TD8k1hWDmtcGWmeiC6C++T64rZnZFgUKapXAZxqh/GVF/63ZPFsVwgVV2lkOcSnR3yFqZ+oJVCWfhlmNnwhBaip1mGWOHu4lx20MWyjFqc1yA1Rw7w1cRh1KAMoodAhInWzZfovbKeeqaemr6paumqZe+1sKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD9YPqRGoptIK1b2hXF0OVDeQ7NmwZzpxuijGAwT5+M=;
 b=o+gvwyb08I5OfzM072fBCCg7L5IWVhhquGqR5FaIlcJXxPAjJZXUS500Mdn1LWzFeWuZLF3auP8inal6J1TPknOiO4cWcAfxzCgDkKjDib/losHAm3pr9und47OHpXRSqU+jYV3lXqVQNHQvh8fh1+vx2aJ8WLBwoBv6nfTPme8qRwOWkJXaV7YWoxWv32OE6wLIMds5D5lCQ3U/WExh6uluwrIU2Jue2Je2JAfX3LWljEeBB4gTrKtBdBnCr2sa0wzivyLNi4scyclvzsgiwzpPfsbeHUyaAKRyYTybtMeSmK+2ZJwLp/ZemMSbGfE02++d7YmMnl0uPO0P+GstOQ==
Received: from DS7P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::19) by
 CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:37:50 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::d4) by DS7P220CA0027.outlook.office365.com
 (2603:10b6:8:223::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend
 Transport; Mon, 9 Mar 2026 19:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 19:37:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 12:37:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 12:37:25 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 12:37:24 -0700
Date: Mon, 9 Mar 2026 12:37:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v3 22/32] hw/arm/tegra241-cmdqv: Add vEVENTQ allocation
 and free
Message-ID: <aa8hc62w4m13Gww0@Asurada-Nvidia>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-23-skolothumtho@nvidia.com>
 <aa8CRT0gv3tr5GkV@Asurada-Nvidia>
 <CH3PR12MB75489D97EEC973AADC0B4244AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75489D97EEC973AADC0B4244AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 240622c7-4bb2-49b0-1a8e-08de7e135925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|7053199007; 
X-Microsoft-Antispam-Message-Info: jFDhdYYX6wB4waiyoFuhwzIY1yzeBYfaeze9mysQyeexclX1j7B0ZYVqxbWooUfm0igHDTxYoqQuJZUqCUpCVab29/7BgwTAMq5zQ42/OuFogFowguHVi5oDVcEh+3TX6hhQUBYwO0CQ9/LSEKtp8IAWo+6+CwcvwsSsYJ7a0lxfna8JUZ7b8K30LNyOiZ+r7UnUH4fbXvvXlPGJE2fFSWnR5ttVIopnRqhWLcI3i0QBbO+miwJwbW/r1DHAkcYiqrakR4Sgq4euwmYy6FAlV2d4EXk6PVwmeRPhXwxHkWvH9zxQ6NiFCkEU+33WRaiA9EdJE4q63RxoJKQ6iVeI8u4yU4OyLbt6RwgPjaVpNi12SVbCbZS6CO2fjjBzADLqPEOhdPLJ0WLxrQUl6dyULTJeMZbRwetGBl1CGrztOz/o+tbqI4KUOCj6tY9FaR988OaEKccmdmsc7o2qOJ90rO/Us5+PI8+3/BkZQ/dzmkbos/nznkACOgGGiNTWiVvMT3sXELuv13kYmUWaSoo0+XDoELHYnnQ6qIq+MB+cGb4nRmIgwmJVVYkZ2Wj26OXKl8/I9vo8V+WQBddFEcHIIxLYFw9a0PCCJDYl7KFxVIxMsy8J2fh3OaPUVH1XjVBlKpjb4yCmoA3ig3OiI5wdaFr06pF17oIAHmXfECgBtjUqWeMrZ4ShlsWamrj91+hS32uYRzIDV3vVRB6uZiyQDL+nfPXs2pT0GZltoI362RjjnIbMyozWZaugZvQdIqsfe0ImOzZtxBIwAEsSQ3UAhg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7o8SYgCQ77yasOTfXDG1KrP8CJMDghYo/eaAEIV2ORom2wU2r69mdv4lQqsGU2MpsFRSdtIGVhn0vNPYGAUjTKCqBwfkIZ2wlsNPJ94Xep+AtEsNFJBaoZ4ivgXBgca8mP8ckr31np72xq5pxZ0zy20PhQLGRxcWdVsN5iGHcl0+C9Jo8772ATXGf6s46KpeqpkLCYCgZko5kLgEohSgEsGiayBd8YbRTjrS5Yr0qnzYYGbFc536tbMEj8Yg67v7hqKZxc26gLkwHd0Q/d7UNePQdcR80gkBdoqCen0jwgKXoqw7rr2npAbWmwUnYmK9d8/EkbgI0xgLCpaDgKEvDpaBSiu96U08EJJuMrbX7c3xdf+oanxT5bP56Zu7pgSefIwLcgtV6WmpNK/nkbL2vRDHQ6IyOZSAOYR5AucfbE5BsMTHbgI+sc7bQfBvtlzH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:37:49.6772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 240622c7-4bb2-49b0-1a8e-08de7e135925
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 10:41:24AM -0700, Shameer Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: 09 March 2026 17:24
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> > alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>; phrdina@redhat.com
> > Subject: Re: [PATCH v3 22/32] hw/arm/tegra241-cmdqv: Add vEVENTQ
> > allocation and free
> > 
> > On Thu, Feb 26, 2026 at 10:50:46AM +0000, Shameer Kolothum wrote:
> > > Allocate a CMDQV specific vEVENTQ via IOMMUFD, and add the
> > > corresponding teardown path to free the vEVENTQ during cleanup.
> > >
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > > ---
> > >  hw/arm/smmuv3-accel.h   |  2 ++
> > >  hw/arm/tegra241-cmdqv.h |  1 +
> > >  hw/arm/smmuv3-accel.c   | 10 ++++++++-
> > >  hw/arm/tegra241-cmdqv.c | 47
> > +++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 59 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> > > index 7d6e4c6b76..4bff90e2c1 100644
> > > --- a/hw/arm/smmuv3-accel.h
> > > +++ b/hw/arm/smmuv3-accel.h
> > > @@ -28,6 +28,8 @@ typedef struct SMMUv3AccelCmdqvOps {
> > >                           uint32_t *out_viommu_id,
> > >                           Error **errp);
> > >      void (*free_viommu)(SMMUv3State *s);
> > > +    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
> > > +    void (*free_veventq)(SMMUv3State *s);
> > 
> > As I replied in v2, this should really depend on viommu and should
> > be simply added to tegra241_cmdqv_alloc/free_viommu().
> 
> Yes, I remember that. That was actually my initial plan, which is why
> this was not part of the original callbacks in the ops struct.
> 
> However, I then realised that we are storing the viommu pointer
> in veventq,
> 
> veventq->viommu = accel->viommu;
> 
> And that struct viommu is only allocated after alloc_viommu() returns.
> 
> I didn't find an easy way to resolve that.  Need to take another look.

Looks like we only needed iommufd pointer v.s. accel->viommu? This
should allow us to merge alloc_veventq into alloc_viommu.

Alternatively, as we discussed on the other side, we could drop the
alloc/free_viommu. Then, have a pair of viommu_init/destroy to have
the veventq part (and any viommu specific routine in the future).

I feel okay with either approach. So, pick one that works the best.

Nicolin

