Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F67CC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 17:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvJIn-00005s-1e; Thu, 20 Mar 2025 13:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tvJIX-0008Tv-Uc; Thu, 20 Mar 2025 13:03:21 -0400
Received: from mail-mw2nam12on20609.outbound.protection.outlook.com
 ([2a01:111:f403:200a::609]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tvJIV-0003LW-6d; Thu, 20 Mar 2025 13:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYHHKY3Xfb54tYL8Xw7Z3pLKveYbckKfHKGcX/shEVUPI+/a2GtVxBCxjOS8fKIfcQv+b4apLfTJER050HVp8yiCxcpgw0yhdkBl7RXzlUvUOt2XEwdG7+R6SyRkrsu3UzQJQoSwgQ8E+4NaUtKEN89LTr3O/AGdKCwMBOlHR3cmCKHGmen2CeHE2PWHE6hF0EhTJAsgCeXVs34yZ9VpUjz45xFkmE7NJuS3YATGbBev9vxnOx83Nn2l0Hg4J8cwiwcG/26TjD/wQi9bSMiPirUQyFSUfFnDMmYAvzkFJET/LUX3K5RyMGEtIFKty2tQcrknyiXIFWbtbhBiMCcK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOakNFCAb+qlhrqK2lylawBsbNykN+K4Q9Zdf36OjPE=;
 b=dNvtMFP5D1ur4Gd/XIijqCYuL9a1kB2HOUGSSiRqzLmXiJMye2w9BAqMcbfZU9ycHaXnLhlLToTrmqaqqIKt4gvopbMljpJcRVjHzcrUaXgwrWV9oUO51dKvliKqB5fdzuQ39BFHbXrmfN/t0FfIDtl4a7ylE+76wFXN8WPLpwSBuFHt05e4DQoS1V1ZAK6bw45KQXzpeKmFIulkvCV3XPB95x+mqT8ilZDA9ffdJAE9j+206+WvGlz8LMxcJQB0xaQAdyyjxEdMhK5EYT9r7Brya5WlpeRrSiiMYhrGsQdIyGmnKyUi0rQ/OjECDh48blFF6zXqaBaPvFdeIamrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOakNFCAb+qlhrqK2lylawBsbNykN+K4Q9Zdf36OjPE=;
 b=HZKKu3stZidN7MMLO2SNrs2Mfs6ts68kbnu4u7aBwo0UNnDH0cu/FsouwCC9bbOTGlOwi4OA1KIRT2SFwbdHCMSDBXOWtNObppNPBp0apqaW7J1+otA7U2EclzTUW0EGQSkXo3i9YY4a9LhoDqaA/COg8Uzdv8spcuAzCQCMl6ogQfH/e+9G3V2W8/wq4YLcM+VCKouEJZDGROQF2G6iqm1L6oAl+YwtsQYT3rnFUSHeWKfVaoZndkDePjuCHwI2v8dATNW3UAw24PeDf+gBS1Y6sddvrYX+QUL9mUlA8op74MaUSftyYn7NY2XeRtourC9q21Tn8pB9qg3DEvC62A==
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:03:02 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::86) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 17:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 17:03:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 10:02:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 10:02:43 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 10:02:41 -0700
Date: Thu, 20 Mar 2025 10:02:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Message-ID: <Z9xKL49nOenvQIsW@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d1312b411f04121a3be90879a915982@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 161f6f62-972a-4577-d235-08dd67d11224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sHIx8/ViBlcOLQ/JdZR6EVYptCNsJ8fYAqX3OHQVy5inxAvuZMrDY1bOcitq?=
 =?us-ascii?Q?mqA+9EnXJABRu7ztSZt7gFXOPN3jPDLu5qFhoewwNN3Lt5+cHRAGjiTDg1VT?=
 =?us-ascii?Q?dNXdlMIi8vExKdC19sSopDTk7khQgAR3lhrPQz5kxImGIHExTKWIqK/s/B2t?=
 =?us-ascii?Q?1LT0iVBoQPQfHaFB6nDRkJr7HPQszfWId7pJnsN+yB77vLUrE4haV3GZBeFo?=
 =?us-ascii?Q?jf6n2hBwz6Ypt0maLkpyQ5RJGhi6Uq831J8dust45AkAJhrmUrsS7o/ECJXx?=
 =?us-ascii?Q?7j1D5Y7UX13YVJUdggrVzktgA5ggTzQJ4H58khEi8CJBWTeoWCOttjf0sCzZ?=
 =?us-ascii?Q?oh/deTaRPmWeQzlJWE2ZTt0/1Wp6+AkdVBoaAUkJXBZj/caRevcPeEmjUrep?=
 =?us-ascii?Q?nBeJ4Tgt8MirddkPch2Dkr+EMf5Uk67r5BFUphDfcdNEgqk//iz89LgIAwI8?=
 =?us-ascii?Q?IHWjcMz6BzPeT93jvBZw8oodKM7kJm7coE8uHd3ew1fzqDX60r116voaUHY4?=
 =?us-ascii?Q?5PWQjJv4OHtqRmCSUDW2ZpNIzSLoxqnu7HiSiqQljalOgOQUDUT3ivtdK+Zh?=
 =?us-ascii?Q?8cJ7amaUL6mkthyEq04IyGySPmz3U2wXVdExWCpdaXrGStw6iwQuUUQyl/pV?=
 =?us-ascii?Q?06lO/QSUVoDaV2Qv90t7ePjjC4skQ37Ew6Zf7NVInOCsndxf0AqfD8CjGECM?=
 =?us-ascii?Q?cUrs+A+cb3QVNe1bNbbewA3HkZpqL7PIDSTDjwiUNKmcK0riVzsd3zvRB9Zg?=
 =?us-ascii?Q?nasTDWiaUcVAfFFvksCneZXFJQwkeE2H6yZtjLZ4X0+X2v+0/WnwDDkh+3n3?=
 =?us-ascii?Q?/Ai96+mH7F9LUvgec6bYfQl+0EHAZ9jrzu0Vrfv94ssuLIlvGxNo2uvdaEy7?=
 =?us-ascii?Q?PA0/Sz9KUB6mcLv/0HLi6vL/lSizoxr6xIcplcbozExVvQZxJCNV/X0lQjb6?=
 =?us-ascii?Q?c7e8iyrfrDJTOGZ8o3IeyimIvYpn/nfV/bB4GQZ5zTFoJB/L1+Y5CDRtTsVz?=
 =?us-ascii?Q?bHYyEFYsJgM9t0kIRvuzxM6bKdvFM/9v3XySMS5+aRTnv7kHYtk5nz/LRz3A?=
 =?us-ascii?Q?f+/uqetOijB2GaqqKBeRpxkMnG1XmEyP99OEUgEaW2cgGLI9U1Jz0ovtVQzA?=
 =?us-ascii?Q?zWf/RBffwmh/khLD37VJwTAhuC35eIZMyV8BHiMpV9EDZ5K4hgR3PTwVrZ0b?=
 =?us-ascii?Q?u/ASpoAIXEL8EHOH0HpFfd3nZEklpxhEYP/KxVOBzl8rIuETTCBdSA/ad76M?=
 =?us-ascii?Q?OEFFyIbkyeeUNRkyrjpxh5Y44BM8Fajsyg87qmvuKiAMTg5vfB2TpJrmwUIy?=
 =?us-ascii?Q?8Vgr3TxI4RXZrxgeogTl5gOMswKe3AJVIrSGxuOls7aUYGiGHFsjBQZaeIzk?=
 =?us-ascii?Q?6qzYfJ709ixDypAi0frRy2R66I+S2nhWahrlczCISNseOHfydXTx/YQoSIs9?=
 =?us-ascii?Q?xBUKUWkgGwWu76G6uTy4Tpvold5nlSZEChvmdLywEyMk7H9uCx9xSdo6QDGt?=
 =?us-ascii?Q?3FTTvqqFTV+oY54=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:03:00.4832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 161f6f62-972a-4577-d235-08dd67d11224
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
Received-SPF: permerror client-ip=2a01:111:f403:200a::609;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Wed, Mar 19, 2025 at 09:26:29AM +0000, Shameerali Kolothum Thodi wrote:
> Having said that,  current code only allows pxb-pcie root complexes avoiding
> the pcie.0. The idea behind this was, user can use pcie.0 with a non accel SMMUv3
> for any emulated devices avoiding the performance bottlenecks we are
> discussing for emulated dev+smmuv3-accel cases. But based on the feedback from
> Eric and Daniel I will relax that restriction and will allow association with pcie.0.

Just want a clarification here..

If VM has a passthrough device only:
 attach it to PCIE.0 <=> vSMMU0 (accel=on)
If VM has an emulated device and a passthrough device:
 attach the emulated device to PCIE.0 <=> vSMMU bypass (or accel=off?)
 attach the passthrough device to pxb-pcie <=> vSMMU0 (accel=on)
?

Thanks
Nicolin

