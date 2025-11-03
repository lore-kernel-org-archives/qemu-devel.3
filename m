Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21A4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFySw-0007lz-3w; Mon, 03 Nov 2025 12:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vFySt-0007lS-3n; Mon, 03 Nov 2025 12:35:35 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vFySo-0006qc-D8; Mon, 03 Nov 2025 12:35:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLiILwW+AvqxpXS6kfWGdmrcjVvwJZFXwSD8+eyxdaO3E2Ji0uYog//5s1SLdmnVNc3W2zrvotERIfz2g6f5KoMexQzkedRwWALH4170B4BqUCuFP52fiBq9oXhnejsohP6DVCOJF1ueOTWrq8Cov4iXI9Tx1+iZ7uVqu87er+tJQHeDjK8Xz8OQX9AoYTpTf4WqDxmXsMCCQ+vpkEqA+yGiQnFai83wqPh/v7hLDASQF0ArLgXF0f60aU/7bGaDqx3sErGhHW9HkQowIMz/EFmxuf81F0yQxM4Yv0PP9JOWN1O+plN5us1zVcVuqtpMbeU0G+xenqyuaLY+4Q6KCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do3DNyred4NEehDPu4sypzGEPA8dk7pL5fAwYSIEjVk=;
 b=NiaGDPvXw344l0yelDNT8RYWuPK3SGgusn102cOYPRc/u7hDYjIrsmyLQXxmq12LpYGZrhUPL4LwgSwH4BIHg1ierxUB8ZYFJPZXY+TWJw7ViSkiJhku4rBJFuBRgJOpOQhY5Z1C6xs8M9yZiGmrASqwgAXVLkxi41k6yx4vPy+UsOf4Uwf0rwXbrDE+/mz3trHvSrdVsQFUYK0Ia4M8fsscMJXjMgDwWCpD0JdLRqgBE3MYcpSMY9BghAHxz2GZd2o6/S+BxWmFS3ZoyqOTgpIa0qvoEiQ2sI8xxp8yMiWEDZcX62+8jTM4RSrTUvt5HaYYeh/WvrGamCV170qIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do3DNyred4NEehDPu4sypzGEPA8dk7pL5fAwYSIEjVk=;
 b=ovVxiSw0URHtamntOpABAdSTDuggpqkjYhp7moG7Epe1iJuqW0hx6IiqnILw8oQf4UhXucH27apU3o4F8hdFKXH+9uwmc40ljcE60aLsbnYV6GyNyvtQl4O+Kotxb4iwEnv+RUhLwoZKR7EANv/uDw5jAKS5Qt+tM4BITsOgKz9cDFogmUwSjABnuBZ7x8XjSSSP264UxeBcviqxwcRggWIjGg5vT9EaMdhpAifb5JN9BpCsofmnm6OJtMI52wE3NNVKaT4yb7N74Pr4RAZYi002sOyTMoC/9769p8GFwZ6E9bQYiOPAmLFqoilsu+GhyHNq2q7UWF2b05T02pOB0Q==
Received: from SN6PR01CA0007.prod.exchangelabs.com (2603:10b6:805:b6::20) by
 BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 17:35:16 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::6d) by SN6PR01CA0007.outlook.office365.com
 (2603:10b6:805:b6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 17:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 17:35:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:34:54 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 09:34:54 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 09:34:53 -0800
Date: Mon, 3 Nov 2025 09:34:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 16/32] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Message-ID: <aQjnvFLfI17WoQkv@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-17-skolothumtho@nvidia.com>
 <aQVM7egZ43UaUODf@Asurada-Nvidia>
 <CH3PR12MB7548F44E394F3A1C93B02518ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548F44E394F3A1C93B02518ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: db9df72d-f68e-43c7-d5d3-08de1aff5803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PDWdNPidS4OlFw+jhFbPqc0pPgVsbeKqN//odeqmUGuwWbGv6ODGihp33A/u?=
 =?us-ascii?Q?kAAg7lPURGDBadEEj2s/cq2yJelwr3xCJyVTrUjeYN1tvzBkgyIsNquVEVb3?=
 =?us-ascii?Q?O8M6XnVn4ou5oGrOFsBz/l1RTC2BEsjrGAzh2wOZBeCXCgvLgLcNqYuwbLQX?=
 =?us-ascii?Q?B331YM93AMvE5z904fnW4PlMGHF3xRBmST76om+Y/Eo+rh1/PPyDgQOtDOKS?=
 =?us-ascii?Q?rjwTL/oh2Z4Ey2/hibHiaE7Jwl3F5wgZJ+bZdip2Tfrp9eQWFtOP2COjlov3?=
 =?us-ascii?Q?wMeLJ2LY+h1lzMndRVrBKCA+lSHITZTBbxk0KffEHbpLPgulqeQe72Ex2FCT?=
 =?us-ascii?Q?1k5iXoYRxfWiwwNafs9MI4qzoJni/mAptF0LDDX8GlP0HouiV4xzhixXNGp6?=
 =?us-ascii?Q?vACXs2+Dz/KyUjRvUjqJnGBspyVHYK8ujjuwmpGjGHRByzcbH0hg/QcBtS/2?=
 =?us-ascii?Q?0qsIpa5QzNaruloqXErqoVOUK4W0es2V2ehYItsuU/dvM10fKNBPAu6FSdMG?=
 =?us-ascii?Q?boq9Iya6xARYXUTZ02NBl/vIVCufhcoxMjAwvP/HQa1rpyOujNgrdzsKKKs2?=
 =?us-ascii?Q?0rO1AUoF+H9BpzvEmqba+kCfG+mvWkXXfHLp6o0fS6TS25JT3Ed0JxXG27qU?=
 =?us-ascii?Q?sQIUk7KBcB6xl5Fch3GBZOF2cpwUjG4D+LwUK9tACd8D/ir/cMPvMUlyt9xZ?=
 =?us-ascii?Q?+lhn08fhOG6YBMhqpHW0WswsTec/jL3XurTqW8L7amYY/ze6WWrtzpS2G9jj?=
 =?us-ascii?Q?qAwUWF3s3RV4O9IAr+3Yxz64Rr1YSPSFPAQMUsLNC2sQXXlIGM+iiLTX9dRX?=
 =?us-ascii?Q?v0i1PAon0dH6/wOtEIkWaM10uZVcUp5IQEBdImHD/2W0IydUnDxqNF5gueJN?=
 =?us-ascii?Q?YesKCdByPufleujM/Ke3TCXkc9Jcxvx4YcxXZkCC7TGFTcc5R60JJWxSVlGz?=
 =?us-ascii?Q?iCwh1Un8uK9+18nurMhV4uS1Vd7NjS9Gh2Z+V8ewHb7aLd9hlsJG3qy6y5/P?=
 =?us-ascii?Q?ebjb67yvatzSSAEiqS0q7LnvgDTotF3xf8J+N30ydvMFXEiOT/wHSdhJ5rYE?=
 =?us-ascii?Q?gqUfMFp60rihtsUjOHs2xGhG4SlmLi6bfhbUXbp9WI2G+k3WgaBcXQG4qqrn?=
 =?us-ascii?Q?toaK2fCgt31J3jfEw2UR+Kzd78RGSgPpaaDepglqR6E+lktu7FD+cYw8A1AV?=
 =?us-ascii?Q?AuO+c2/uHWgz0st6GEkKVisy3UOQxGU1SloxdFYC5b8z/em6U3q0b2GU2PWf?=
 =?us-ascii?Q?6NoMrkTnnx+8L7NSp4rW1JalwTQT+MNvks6cy9Hkk8fsPneVsgrmXIewCVY4?=
 =?us-ascii?Q?OD3mT1a535xxBC6EdSwrWf711vVRkbtztUgjQG2dSfwuX/Ypcs3jkbSVlA4Z?=
 =?us-ascii?Q?mbPFkhq1kiP8RSxmzPN9Kuf28lsSQuLgncIIZA5s+/SviIwdHL78qu8Vswr8?=
 =?us-ascii?Q?sOcM1aoIPNmNcpMFg2CeHdr0VEWBxFsOnCDKoaB40cgdkFSScckyMoJNCKGS?=
 =?us-ascii?Q?NLKoFYsrBQdlb5U1vPAv2Zr5gXpFg9Yb76C598yvkwdM7J2KuKo5DurGgg8v?=
 =?us-ascii?Q?G34CK+hMJFao1Fhi7pM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:35:12.7345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db9df72d-f68e-43c7-d5d3-08de1aff5803
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

On Mon, Nov 03, 2025 at 07:19:08AM -0800, Shameer Kolothum wrote:
> I like the current approach. Possibly can update the doc for get_msi_address_space()
> In previous patch to make it clear that "&address_space_memory" should be 
> returned if no msi translation is required.

Yea. That'd be clearer.

Nicolin

