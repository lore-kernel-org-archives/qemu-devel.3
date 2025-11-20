Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EDECF8549
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 17:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8CB-0001o4-Ju; Thu, 20 Nov 2025 12:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vM8C9-0001nk-IX; Thu, 20 Nov 2025 12:11:45 -0500
Received: from mail-eastusazon11012008.outbound.protection.outlook.com
 ([52.101.53.8] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vM8C7-0004xl-OI; Thu, 20 Nov 2025 12:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMmwqK9oZeGtzEXfRD0+oOWbMKFIKceTLBw37lwEago+Gqc1GSF3x5Rio6AITtAZjCMGQ2s5sjrPN3OlNJjp7Lf9RIXOXOgvWkaeuz7QRnPk2DpdjrGOtY+eJ48dgky6RAsY8AiDrz3qCj21L78onMyXUl+pvTMJU8/wFsZU19xd0rOfyl0Af4YpljpFswIFgWl6JW8vdFAVkpVS6ZjMBB1r5NJSrQD7A+/jJiO6Nw4r8ofM/eQ+C6V+pufs06RZJE5P9KSqmJ9BPG5jtoDfmo13b441GD/fjm2sVzIyDQueyl7xihvbBaBl2PQnGjC65iQ93yr1SBbX9EYAj6NASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvrVZJuyK5VObaGc9Rn5bO5Ec49+3N2iDflj+P6BGGk=;
 b=q/4IGRPPASPTswC8ZxcU5JHxMo9nUYYdhNGnU2W17v7WpQVx9BzckJgsRxLX/lejipVD3NMk1mBcWmE8jss4mjvLUqppga65dgsAQ/NHSyebKTxdZl8tuqvgCn5bLz8vl5Ym6but7BamUNuHu31IOMX9qR1v4HTB0VafmSvsIaeNAH3SyzSyA9dbantVSFq0tdYmf6a22Yqd+PzLVcDkX9TY5lw9kHwX40o8c2xjwp49WQ42/tR4qGz2p+jz8+XwD7mCioXEkPif58buypVWfkf1gQw2a7/3rb/ALGT967eWQyIVQB5MwGgylqmzBi/8svrdLRupOzzNsTsAL9TuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvrVZJuyK5VObaGc9Rn5bO5Ec49+3N2iDflj+P6BGGk=;
 b=g5eVXu5CoLX6DYXhV+hLYGqhLqXNij0rONVKmkuqxbKUdobl0qdYFON1nJMcfs3Yh23BNuLlRQGHSi3RKeauXOpTW00iqn51d8pC7ElX4Nf/j4L+zl6i17e3Q3Pg9MtULAL1gPOYd51pJ9M2y4VLvPGseYOavbp036Qg+mLNJi95VRWrWb96hbvKgpTIyuTWJuqbCJriMu2yQrj1brU+086QKXKuv1M3sX8qXp71S0Aa/AITFXBzHvBlJg+o6ag0k613I6uZR7InDUH44bK0NwjPotFPUBhGHoQ1Mq1SM8rAD2IDKnA+CGEIk2gu/HUa51pjEiPpg79d2F5OxgSVPQ==
Received: from CH2PR14CA0053.namprd14.prod.outlook.com (2603:10b6:610:56::33)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 17:06:36 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:56:cafe::22) by CH2PR14CA0053.outlook.office365.com
 (2603:10b6:610:56::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 17:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Thu, 20 Nov 2025 17:06:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 09:06:15 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 09:06:15 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 09:06:13 -0800
Date: Thu, 20 Nov 2025 09:06:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Message-ID: <aR9KhE9/ahl372xE@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0dd82f-02d4-4e92-a0ac-08de285729b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?527enM3HfRB84xxHRs//zNEoWWWKY432D2r12toAM5ZYgePQDGIcLMoZOYn/?=
 =?us-ascii?Q?YphJmu1znl2qMGxoZZ1cK7S0PnDwP0IA/kOzwe8P2RzlOU/WYRkx1N7wueHZ?=
 =?us-ascii?Q?5gbRZ19POqZNVdM9lyPwXPQLnNmwFi6EAqgRYgwPeHmOFTywude746DH+IxY?=
 =?us-ascii?Q?aIIDpxnhLCR2dCdAMs6iRqKsH1MBwWBs+XIQ/PLeJ7BmPUAOvaXcYal2j4jL?=
 =?us-ascii?Q?xkFgWW2IfdmNwlbvIoUJQU/1rfIaW5dVPFXSKvVJHYLrpKQ0pTnbXrtXYS7d?=
 =?us-ascii?Q?jaDdL7nvOVlxEniE7T5hnB6sgD/MNVGCBXtJ7CIHiG72q8sqz5XuPy92dyx7?=
 =?us-ascii?Q?XnYITlg98sqIQ93cxqcl3jXOPwg/zpLr3Re/Y7eoF8ut+hPNf3cuYD0IQVqw?=
 =?us-ascii?Q?Xk0HUnq8iHpxAdI3olDzCdDfsfDLJIYMhPHqxmFUZYxO25QSz3nGxW6y95dW?=
 =?us-ascii?Q?EiSAhRmR10ufXrbg4RUSyKmJGGPBkkR5oTxeYCcFotJe/BNVqD+c4FOe6FaK?=
 =?us-ascii?Q?Tvo9p77y1OrKe45fpZyWkH83XIv96yNKqzWDMcfqJjhmAhuz6NNB/Mv7UHQ1?=
 =?us-ascii?Q?GM7Wqwg9PRT3MX1dw4pTbcENRAGmcemQ1L2va9kHEmtI/m9qEfPICTIOPXvH?=
 =?us-ascii?Q?P2QtX/VjSX/OA5qW0ddEGuGLid/utKosiAuxKVIA07NjrMLCHVspKwwoga+6?=
 =?us-ascii?Q?cRqYG7nJgH8x7puQSb5QaIOx4CAPBeOPRLwXOBP/5K3WgTjA0juDsdGLe7LY?=
 =?us-ascii?Q?Rwzn3EaWJfZbNvcnfX311xd6oUrHNn2eHOESRnrpmqUKdDtRhcTmVzyj/yNS?=
 =?us-ascii?Q?vcjRUhD+KgowUlD4r/Hj/7cMYXD4kgNksqxZtCDlcTa4bchVt9aI4BzFUrzu?=
 =?us-ascii?Q?87N2YPUDiKVmcy9GorW0gBtfm5RycQHGpQt7FPDDl+ZfjFQvUIPJiHCC0wSK?=
 =?us-ascii?Q?tEkWM68m659lEL0gm34s12XO6HENliyvpaa72qcthSCyS1i/IBHm/TphAam1?=
 =?us-ascii?Q?c9Yd0aueCMI4cvURp4P0T9UTHo3ztlcUsTYx6zT1eWm6beoIFcvmfcAxzBs9?=
 =?us-ascii?Q?tJ9HqAanB649DGQk3iEOl0nota2owHK9QLB/J+kzMmeH5fMvB5WV/iCTH4c5?=
 =?us-ascii?Q?EwpOL+aB/K2LbPQadw0rzHTtq85f4VTk1NSQxs27Zm6pYDex+f2C2N7mOGsU?=
 =?us-ascii?Q?NQC2LdDDym7qM9z03MDAnynm9oq3WhuC+pQVDJpzvank5MprfcNEmBd/pbqK?=
 =?us-ascii?Q?AyqzBmHPZoclrbY+levRztzvwEfXFTuM9fNKPnEut+rYThpsR+ZywwY0wNH6?=
 =?us-ascii?Q?u7z1t0JDivaYNSr2cOMP2DB9oedmRWsHZobPkL9Q86gZcFFZanuKYcmavTt0?=
 =?us-ascii?Q?dtvv073AAM5JgJq1qbrNOmZULNbcsoHjuG0gMVztllV7KfVSYAojvoZTFq+A?=
 =?us-ascii?Q?QagIo5NSJD1JEPxTMW++qIs0GLTkxPEuCUT02MUOd5iPiU7PAGhnvgXQ4mzD?=
 =?us-ascii?Q?mLsnYeF2I57fe7LLZyJPBB0h4u/OgyfWCkCWxOy0LzH9g2Jx8QbEYmh3xcC2?=
 =?us-ascii?Q?KJ8GvBZsyAftl+jdF57u/4bL1RCu3kqu+lK5p2Ca?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 17:06:35.8106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0dd82f-02d4-4e92-a0ac-08de285729b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
Received-SPF: permerror client-ip=52.101.53.8;
 envelope-from=nicolinc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 20, 2025 at 01:21:40PM +0000, Shameer Kolothum wrote:
> https://github.com/shamiali2008/qemu-master master-smmuv3-accel-v6

I did a quick sanity with two of my VM setups passing through GPU
and MLX on NVIDIA Grace. Everything looks normal to me except:

>  - GBPA-based vSTE update depends on Nicolin's kernel patch [1].

This now becomes a hard requirement that would error out when the
kernel doesn't have this change v.s. v5 just giving a warning. So
make sure to apply that to the kernel tree for testing.
b4 am https://lore.kernel.org/linux-iommu/20251103172755.2026145-1-nicolinc@nvidia.com/

Not sure if we should put a hard requirement on the kernel change
that isn't merged..

With that,

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

