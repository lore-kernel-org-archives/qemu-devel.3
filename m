Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E14AC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 22:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua0Co-0008NK-3H; Thu, 10 Jul 2025 18:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ua0Cl-0008LP-TE; Thu, 10 Jul 2025 18:57:27 -0400
Received: from mail-bn8nam04on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2408::619]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ua0Cj-000588-Cz; Thu, 10 Jul 2025 18:57:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyvQ6or3ebTmEPS6VeVxUVLUUGfqj/hVmjOMAko3UGZTjIPflgeLMlzt0G9Crwylpa/AV/lxjBzDPktci2WsWx4hovCYwXs5ir1by2OJVied8ZayMlyojxtvfMMvhKP5AoTfKIRlA+AR5csoe60Aegjwh98eq8SeEtgd1ceDKCoOfNBxYXyw0lhMjrsvbkVDGfFjle4G1z9fHRi87KHvcgOJr24qR6awB2/H0ZTzMqCXm8fOV101QYwaO23Kns1+LBtE1eIi+66rxX0prEiKFLzkmqYRamVckqK9L42/28jVfJ4AEKg/tl2g7NdoEV7GQ89qdDdeIT/6ik16S5hLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIBpcaS39SxUTnjLFZ/rA2qFFAfOMymAI9k3uFz2ySM=;
 b=wiPkxqik//HHD2L1yWzhLtHlNhXSp+HZPn1cEWnHbS98DJs9jNVks6a6l3ze1Qwm0Ui9vMaj7b1LSpv22BtChPTAMQ0C1stN5jSecEoctfrKPsl1DjEc7/jpM7VPFr5zI/NXafbPUJpmpptp7wEGXnzEmehjiyzFsXyCJwAo/oRZmy099wvSXcJYxEcQ/jaAiXKlL+0WalSM4qUyfERIkQ2Yyu3Av7w4UcKQmLrtiRPC5hqeXZXn1VJ4GXLXcZSaRNE7zEwMXvsqoGGpEnkMmhzSCtCK/129nXfnYBMdNAlw7llXv+TJEKMps6pxNva15mJGCCT8aPtlwxOAPA5upw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIBpcaS39SxUTnjLFZ/rA2qFFAfOMymAI9k3uFz2ySM=;
 b=n5fn6jj6sOPgU44iJIZGV8LuCB2FYo+KqbyO5YjXK+GCXxl4ZfhY+0CdRpfa6h+lWj1BjQd+5XtaCumPQ5bq3JxI3mJfgv81uqMLqYMh4pVQC6Kt32Cm5iYgAyV6Fw+srS+tQMNoXZjj2AZz/SHFuc0cV1HHSgiiVc2udd/R6APw78wuzJ2KZbdxccj1UHRedwcFq8u7i23Crj/9RX1ZZ9zZnFQpB5KWS4CKlyibUCLEaV/VsRhmYdWJepqioS9JYg679Cb8fZWYPs6e7oEsv8CgySrNeXhmwCbpPvnW767iFHqKvhhsmT73/QnnI+6GAncCGTaPHOrX6Q6P5wku/A==
Received: from BN9PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:fb::8)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 22:57:17 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::fd) by BN9PR03CA0033.outlook.office365.com
 (2603:10b6:408:fb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 22:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 22:57:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 15:56:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 15:56:57 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 15:56:56 -0700
Date: Thu, 10 Jul 2025 15:56:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Message-ID: <aHBFNxLERkwcbL7d@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
 <aG2M/BI3UAYxKCD3@Asurada-Nvidia>
 <741503f8f96148b389b875e6b6812c1a@huawei.com>
 <aG8ECVeOYXPzBEVB@Asurada-Nvidia>
 <3a51c0e0f3ce4c2580ff596008615439@huawei.com>
 <aef834e0-d6dc-40d0-a6aa-24ed44b77325@redhat.com>
 <f3bfc4cdb0ca47da8f3e4bc38b58d3b6@huawei.com>
 <aG/whNETIoHGnI5O@Asurada-Nvidia>
 <0ef59c7f11454954814501e41724f4fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ef59c7f11454954814501e41724f4fe@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef26521-2880-4ab3-3fe3-08ddc0051e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G21ay8bERZ8Or6LL73zUePJZkkC4ErAQR8yDNn67Ebhaho709l2S+IYs0ARO?=
 =?us-ascii?Q?7Piy3VblYBp0FAiSdKpTKkKlQCGokk4Hfdo4YYZ8TvD1X5dRcdTR9wOxWccr?=
 =?us-ascii?Q?xJvYvneDKuO4GK3d7/Cc0yA9t20aQ92+3fMfdrS84nixqSe22H0n6IgaxW7S?=
 =?us-ascii?Q?NUignsLDdEPJJB3Dm4EBYOR/ShSiqCk4R568UBLnmX1yrpHr+trVhQoKgxOL?=
 =?us-ascii?Q?i3Gg6TPfPPVu1rhIjvH0atmA035PNH9mDOfdNyOvZJwBpeerNjRNx07nMVgM?=
 =?us-ascii?Q?ib+nDrNRuTy0H0QflYh65cGzCK/yUryJLIJOLWTgZs3p8N2JPIgOI5dSas4u?=
 =?us-ascii?Q?4abVJuNTw/yiHrjZznQi8L0WeF97AAWo6BtdwDfq5g5haFja+fYu0JEUlb7T?=
 =?us-ascii?Q?9B5dl+AW4yPJcBbI8I6NY2anmTXoUYGBP0JLTopoy5Lu0AMOO6eC2VoLBnY3?=
 =?us-ascii?Q?vjFWjx6/1dw9HHbOB0Xn7HVl4Z6/7++LNAnrNxDgX+NrDlddmHfHYv14g8hu?=
 =?us-ascii?Q?Rn25JD/pViP3lhPUvejMqnkoDdUsUC6KvtImYg/IsrFQBBkVpJ9mRrseTy93?=
 =?us-ascii?Q?QGXB/q9yu5y7TTASSOqhz4AnKAT2xdsVuuFjcjYOA4A3rf0zQKY2ZZC3PAev?=
 =?us-ascii?Q?H40Wu+LDffLQUfvpC9CdEjqfhzszfRrDON8Kvx9LCKKrCk7EmnEE7672Upf4?=
 =?us-ascii?Q?dET4HMW2teWbu6UIQ1xNPXj2X7DfGw4EjaEzo5UwN8AGHGxq79hmKtxHuGMk?=
 =?us-ascii?Q?Ol0AyMDx3EbxlJjqSFR8Mo0PrvmiYrdrKeQPOJ8f2swi5v2Wnuk0qTfmnkbx?=
 =?us-ascii?Q?xAgO0v/c0In7aD0UTrKzeAK2flG9o91vAEGwyXXrcrfVXQ9xstIz4PBDmCRk?=
 =?us-ascii?Q?RYN3bss+1obezTJdNI8fIN/g/upMgacCp8AZllSq53hMZTYuKO+A1U0Wz2rl?=
 =?us-ascii?Q?qHNu9v5l3jx5ZzgH0PWcNBzZg8uDi/3lEFtQOYP7tAJ/sp0a2VVnDjuHu+Ce?=
 =?us-ascii?Q?cvoSo7vxIwBAytUIaNUTdOUZnM46YuSEAk1Ezf7sqUP7g6YuFUs5ZM1uFhND?=
 =?us-ascii?Q?ULQbK32VL3jcMNXTAOqWONGv5JpKT7LFme6JW+8gwc7F1AtpWaVYy+haeQrO?=
 =?us-ascii?Q?+7+ypX99cUJNx8RkDS/Tfra6aG98KnZgphqOSiQxKzgS003m3lP/TLlL7MgV?=
 =?us-ascii?Q?2hqilCvt8bIVHObXZI5dGCCVRSeyCgA8swqDNSIx7Il8PuNIMn0tbI9ZnB5a?=
 =?us-ascii?Q?qWPKdEbV4nj0+/JJnIgQZZHtOhL3R/y3DbSawZhP/+i52Y5tUI14i6NBOYKy?=
 =?us-ascii?Q?tOSUnvdl17pJ2oMmJs8sc7/Dd7zkGpyx0RQJXiLDAIwbxRwUvJRGWyT5v6qg?=
 =?us-ascii?Q?LiLxjBJQFKye/nC7q6sgAiV52uBoP9sKfrkBTJ3Gww4fEwHrSHAirNQ6i6lQ?=
 =?us-ascii?Q?swGwv2AMG8MqR6NMy2ksKoUMVoXfwnvY5kKvnOSSfcCHP6l2hNXzJUpsQ27c?=
 =?us-ascii?Q?IczIkwSQSUH41j56i8SPRbJX31lQ0Y3YXhkZ?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 22:57:16.7075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef26521-2880-4ab3-3fe3-08ddc0051e1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026
Received-SPF: permerror client-ip=2a01:111:f403:2408::619;
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

On Thu, Jul 10, 2025 at 09:40:28PM +0000, Shameerali Kolothum Thodi wrote:
> > So, the logic is trying to avoid:
> >         "iommu_bus = parent_bus;"
> > for a case that parent_bus (pcie.0) having its own IOMMU.
> > 
> > But shouldn't it be just "if (parent_bus->iommu_per_bus)"?
> > 
> > Why does the current iommu_bus->iommu_per_bus has to be unset?
> 
> I think that !iommu_bus->iommu_per_bus check will be always true as 
> it enters the while loop only if !iommu_bus->iommu_ops case,
> 
> while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
> 
> }

Yea, that makses sense. "!iommu_bus->iommu_ops" should imply that
"iommu_bus->iommu_per_bus" is unset.

> > I think "iommu_bus = parent_bus" should be avoided too even if
> > the current iommu_bus has its own IOMMU, i.e. iommu_per_bus is
> > set?
> 
> Why? Not clear to me. It only enters the loop if the current iommu_bus
> doesn't have Iommu_ops set which in turn means iommu_per_bus is not set. 
> Isn't it?

Yea. I missed that condition. But what I said still stays correct:
if iommu_bus (pcie.1) has its own IOMMU, it shouldn't take the ops
from the parent_bus. The thing is that this logic is inside a while
condition that has already excluded such a case.

Thanks
Nicolin

