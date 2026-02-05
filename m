Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CF9ECD983
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1zn-0001Wo-P6; Thu, 05 Feb 2026 11:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vo1zl-0001W7-Tc; Thu, 05 Feb 2026 11:14:18 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vo1zk-0003Jg-Dn; Thu, 05 Feb 2026 11:14:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y59+S8BvXl++MRlAKZlOWGXUX6R+nPZR38tAB9f5GYwm+s3Ja/79Q8By0Uk8jED7dZUPLAMf1SaUZ5Lh1KYihhtQxEaHKmHsF46ypG+1xGe5y/qVbFhR8ZZ81LgZQbgWfJn3xYvTCDnL/4OyEY/nxYGJtn70RneSLR54hIrnGSrs3x74EhF5J9YiyZkgAfzhebzLTvf0i1niP9E1g3vCuPoUm24hF78qeudoCh6ONetGBAmLtEwKaR9KUK43OIerOFl+DWNcatTxmOwpMa/Rcl1v4WGt3H1PJtdu7WwEgyw296edSk8nBVIpjCHKpB6Zz6ZFUrbcHNHkrZlt935ApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMSIXiOfZPc4Zo9hZKVuu4mEOo15tj5AeWurmwoqW8Y=;
 b=KvSIXdk4i/tatb7ntih3tFkA0nmGBz6vPgNFR5yUCsxgLo/ZJfMlFQj6Bo+IToC6y/bvjOh/Yfm23El8jfs0yakWKWstp1qfKUwFMrrLqBYBOuH4cFXzmgDtFGalzAiVELHt3L/Tu/UnUfso/OIzBMTzxmJV/SPT/2e37ypAPzs2yKi2ZEgMh6Zd2Am7E2o2rkD/UFsd/XtrfYXRFvbcV6uqjaw3KZnwe8FmdZTsIqi5YtVeYRhC0Wg1dCZmI0Chopv9Gj1Gx51lX6cNfAnJo9vIZpWIZf3JrsmZqQgNEUbaWYcOeYQ5lvTYqTU/AeNTlwz5SlDuMFnU/PfAIn/CQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMSIXiOfZPc4Zo9hZKVuu4mEOo15tj5AeWurmwoqW8Y=;
 b=Z2v2GW7CoCdDrgMnUTRKmkFubgDpW5Wxlv5bAeQmjssy37JBXBsUBKlL6jutBeay4MsZdTrvQvBnwjQpx+3ZAmSZfKwxpGGkR9XNw+2GVz9/926zw/ZzuPlQzLvUBDcZBA4vF5NNv6AGlFOsuwqJdsHH2gyZI7vtjkP+91DR+1irO8F6kDdtL/DBDhIKmeEBFFnzYfZuQ0UB0xh+DMIvIhO21ztj6pclQiFzq6CGQUX2xrY766+7Z/J4pfh/QjT2ICs4W7hLCrw0sXKNVSxVmjMHkTFsZ2txNnhhNalCRsiuMI9RrRag9kyG9EjRyU7WNweChxs3HfFXZDJF+cSjHA==
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 16:14:10 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::43) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 16:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 16:14:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 08:13:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 08:13:44 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 08:13:43 -0800
Date: Thu, 5 Feb 2026 08:13:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Message-ID: <aYTBteJW/jZ2ikcj@Asurada-Nvidia>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
 <20260204190008.20070-4-skolothumtho@nvidia.com>
 <aYOkBm5Ghih0Uxzf@Asurada-Nvidia>
 <CH3PR12MB7548F2E4B90928FDC2A0EFC7AB99A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548F2E4B90928FDC2A0EFC7AB99A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcd1bb3-5099-4791-a2f9-08de64d1983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AW0tHD9BoQjX2lD4bFKsp3cyyGVBR9iI14o1/lRWfL1PwVPNpcA6B5YrXa1f?=
 =?us-ascii?Q?9rQdZalPOz6aITU8UPpmJRgjfq1B+fRNna5/UtBIUiG7a5XT4rueUWzBGSnG?=
 =?us-ascii?Q?PzaIkHJpKVhpQqtLZyxeVdilkA70S/owxyF4hWQjBhkhGEwE4D/2z+c56EdN?=
 =?us-ascii?Q?CjlUNUMDfJuUOFGTiyeiHU5fhNq9Soq2kw/cChdcubzhgO9TAonj02fpBfux?=
 =?us-ascii?Q?3L7hiM85M4HU9bB9ePiSewQGFAzITAzxB8aNTmoua4Bonyn1B9n/GCOr4pmG?=
 =?us-ascii?Q?iOgYPhNVhz5CAx9SBngrcEZwKciZMFx9R2VVUyA74RARQgqIRO7Appo2YaZ0?=
 =?us-ascii?Q?NO8K0idZkB8ZkEk4qy3apJ9ZSmoPtzzMtNT6v7uP2xE/07EFuPmapbndpJbM?=
 =?us-ascii?Q?aKN6U8qghkdzBbRAw3jWaIvaWCu3mLf5d1+JnfgZQMhsGS7ZWCbX8F7jrBx5?=
 =?us-ascii?Q?Snd7xlHHT0221seWik2ad+cc3+r5eSPMyuPGhh5ZZCRaJ+7cPbgLH+SYMGHT?=
 =?us-ascii?Q?qQ/rLjaD8+KleDhWprlljWK8gZtQAgIxgav06VmXqqI+6oPujKfZHmx5I1JF?=
 =?us-ascii?Q?Lij3RIVJQDad3rTo5uyD+ohHAhb0g8EY2OuiT/xr9TnebUF7yxsU2Gvl4/6q?=
 =?us-ascii?Q?DpoTEwPxge5qiZQ86AaU1I5LaW4cZ3He+MDkaZLiFEwoLf0TH99DqbzwxfK5?=
 =?us-ascii?Q?KEMQZN0LRspCauUbMajCRX1AnbV0Vmujb/SxWP1w+hojqwsxXsD9kPSpljzW?=
 =?us-ascii?Q?mJWyv1fPPWJtWMnsShUrrB3a3gYDtk4nebbRGqtYVhlkzimx2yonbZQ2sRa0?=
 =?us-ascii?Q?PA0GgoPJ1M6jCCBs91nmYxFOrBTUPdpYcQDWaiv6c6khMQc5sr1TyXMx0CDL?=
 =?us-ascii?Q?bpbrESVC/+uvK2/jp7NX9PETfZnKEPdqwrKy0Alg9wtiZveT7cEjUGPTNvrX?=
 =?us-ascii?Q?Ls6kKuESX9WCpa+ZDyZa0BdikXtdgTIVPjW6VORF0t49TbdoVGMh/gin9isd?=
 =?us-ascii?Q?QsUSJ1t4gKAE8kE0AoQEHwjZJPFCHvDgEHjkm2CdktKr99KfkAA8ELtDrEx4?=
 =?us-ascii?Q?lZMEaGyz20PJHaEuSbuDHyKKQecrCuCqzxq1B57aLJ31IOhe/atJ4BuWpCv+?=
 =?us-ascii?Q?J/K6W9uK4ECXdZAMTZ8nhnGW2nhVBQgpYSCldQwISJbEdnqnGNiqurlf9Iln?=
 =?us-ascii?Q?k4wLArpE/K2b7l2CAqQKG1RJAmajGHY+s6YE2w9V+DHof/XWtqhNQYb3QFit?=
 =?us-ascii?Q?BSh5a1TRGH9mIgqYZ4Mx69nJasxORqYDSOwNA0cX86Ge/8rFwitECd+83Axu?=
 =?us-ascii?Q?n1KWYd6ifrj3M4RE+lJx+XrF83dJ1AiSkixImroZnXf2bJvPLjoOG5GQyJRl?=
 =?us-ascii?Q?L/hUZEQNxQBOzGq5XTdBUTN4beG1QF/unleGw8xl0l/4q11mC/BbKGTc4HCV?=
 =?us-ascii?Q?56RXAp/ikovX7e9TWUaHSRROUa1ZYsPv3LuN6XUfRyMWe7VWSdypGepzNx8K?=
 =?us-ascii?Q?fdaBHlHxCveUxt4miX7PRpAcVf9gjm0+ho1V/cm9AMa4SVglWPzlhPjBzV5G?=
 =?us-ascii?Q?Dw2o+3/VoB3n9jMPo43VNmrEgBtT2bPCw5B6Vfxo3wVaRuV2meedYO7TrAMw?=
 =?us-ascii?Q?RqVO4QJ4CaxSHwySpmOzVG3fuRWInzrQ+UuDTve7FFAPBt4cqWk0ZdTVEhsP?=
 =?us-ascii?Q?Ygt4iw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 20+Rij2hXZXDuF4t5rFdqgYEuC4i1c/Hw4awpg4cLUuYXaZrCq5RA0oCFDE86kmc5Svyezwtr3rwAoNDwrlp5pN/fdqO+0Kvxrw4DwwiJKxNoPrssfZCCn6dwzKPz1IdbKYHVmjiECNBuvSFJpGyeuHqP4DDV2LwX/ZkN61WsORGnLT4zG87m5a0+w0a7sL6Ztw/Qk0KQB7hnWXPdx6pvzBcB0M7IxaNkRVzyjrouHROz6z5zTfTK1ncMy1of6BNfLx35oV6KoiDNaiFJ6TbRPhb8kScPFqSUjPAJTUg+gRYehXXYUVc70haUf6vVs6YaQ5Wvxaf3ByULMoBvnE260P9hSwIvOMoVEPgd1HrmzhgSCvMQVKn02ZWBoE1ztKdGwXhyXXokXzgv0D30qw9qX396U5tP9ZYuVYGXBRUqJNPumheoDqTXCeyLQ+cPpDt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:14:09.6581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcd1bb3-5099-4791-a2f9-08de64d1983e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

On Thu, Feb 05, 2026 at 12:26:40AM -0800, Shameer Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: 04 February 2026 19:55
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>
> > Subject: Re: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> > accelerated SMMUv3 devices
> > 
> > On Wed, Feb 04, 2026 at 07:00:06PM +0000, Shameer Kolothum wrote:
> > > +bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp) {
> > > +    SMMUv3AccelState *accel = s->s_accel;
> > > +    IOMMUFDVeventq *veventq;
> > > +    uint32_t veventq_id;
> > > +    uint32_t veventq_fd;
> > > +
> > > +    if (!accel->viommu) {
> > > +        return true;
> > > +    }
> > 
> > This seems meaningless or should be an assert?
> 
> Hmm.. We need this check because, if there are no cold-plugged devices,
> when the guest boots and enables EventQ, the vIOMMU may not exist yet.
> 
> Isn't it?

Oh, you are right. I missed the other call in smmu_writel().

Nicolin

