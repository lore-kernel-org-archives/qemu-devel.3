Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A434EC35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwbh-0007A3-4i; Wed, 19 Mar 2025 12:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuwbb-0006zU-9c; Wed, 19 Mar 2025 12:49:23 -0400
Received: from mail-co1nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuwbY-0003IP-Qa; Wed, 19 Mar 2025 12:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK9itKkWKmWeu2dBk7HHFQ7aYqBQ5FW5ptM5gzNT8kVZ7bFSNA8tCA1WeV636Q+0oTuIUZUZ0vIrF7Dp1Ec55CWoEGIuyV87d/6r99ptesZxSv9mKw8TyFfNSkk8I7KU0wHWRyd0icdkH7zP8wWW7B8J6QESgfRjFhIfQvYVqpoaP3Zw4GeVkxlw69GE5ObCbPgemIVv1UTQh+kkTEG2tpR7yGrm9aRTyeJYX+7D0RTXG4V3xgBk2WKUfttEJOF6sJEor7atT1m1a5MJn9t+7gN/nep4FAbQC46j58ybq2cm8nYG8i3p3SxdijaGmJ6U3IexNQ+70czo1NNoNJC6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZrHM1FdzzN0lCOvDvdYIhcTaDVaPpt2rTPVKt8yzMg=;
 b=oMIRiYbfQ5aTKzUxDsmHMJ9YCXytIK60ZZvTfqkb6Hary31IZjO5Vbi7eWfi7PBiCkOyH6IN3+A5mASH/KVKtN91cTvGl2I8NcP/nH8B2SRI9C9k/tkO+jvyF5bqjtioPRrKZKWlpWwMYKnfdVPQFEQcK/aseOHa7t7jsuxCUaPETmPH4twv4wAZtT/Cz/8a8UnrUXCwzzl+0asUkcMbs9OFdIDrvfEw+HbXu91LI10s10+kG1HskKOl2omVTYg/sEoQqKGZRm0Pe6aKDGXBscihRy+kCVYa15EmSmZQSnGuzkQxXG5a4KXiyd6qLn3mjGojXpYGawqV8rNUPfDjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZrHM1FdzzN0lCOvDvdYIhcTaDVaPpt2rTPVKt8yzMg=;
 b=humA3glSCiLnkJBQ2gU9IVDQ5vK8wJej3kG2UgNU3bDHvSAYzHjNQ8qeQGFwT7bvUiEPAdSKhs5XWo++MXUlTFu8Iy7ASjk5PiRWnqDQHe6tb3Dw9xvF0QXW1ZE003Gd343JkwN6Bv0GIANQ7zpvLCYC2HN2qSBDW9ipCCRmlbTUovUjN3D6CHvJElu258JABh5VKzMSsK7uTwjKOD2v6Y2ji8Z0ZZsirGFFMSg/MLnFMCIWhXpUxRQBpcooAnz1TghGRpZyWo1rsdEtTobkQ1sdyNKJHwGVoIJhDaMHExRVxn9OmzLVnck9bvfoYewHt1kVyUS2A0u0usI4SK22dA==
Received: from BY5PR16CA0032.namprd16.prod.outlook.com (2603:10b6:a03:1a0::45)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 16:49:14 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::5d) by BY5PR16CA0032.outlook.office365.com
 (2603:10b6:a03:1a0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 16:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:49:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 09:48:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 09:48:57 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 09:48:56 -0700
Date: Wed, 19 Mar 2025 09:48:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Donald Dutile <ddutile@redhat.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Message-ID: <Z9r1dsYyMNnElpbG@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
 <28452954-7be2-4114-8d37-a208250b6f83@redhat.com>
 <42f9953fc7dd40d9bcd4919914530b89@huawei.com>
 <16998464-b8d8-459b-80c4-69da2cafa477@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16998464-b8d8-459b-80c4-69da2cafa477@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: c5208a53-e5fb-473c-e1df-08dd6705faf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3qH16RUqPti5EALVOjNRlmsbk6MgHYns+5a0yWaSOOjjvBcZ9OpR/WiViJXB?=
 =?us-ascii?Q?6jZNYp6mN6Plcv/HtshXi6Hh9vMOVOeKLUCaEQiD2j/BXviKXVWDhvR4f8Y+?=
 =?us-ascii?Q?wXxWMZRJFSnR8ZP0W43ebvdlEduR2NkL7M9VEVTg6BjzHAkxY/gJsFMwpFAT?=
 =?us-ascii?Q?r19pP7g3ziLGBUfQo0BB3Vm74d7WQTBmwLy6N3HkjgtyLWOJgeO6RKUxcQRS?=
 =?us-ascii?Q?i+ZLyzOz2N0YVUKJuZw/5pPu0+pZ/KOF6ojHHu9+haUUmIsX0LqGdVL+4nhk?=
 =?us-ascii?Q?LchC1K99aQNq9PDTa+YrkMzVH1eCq3HNmzsSKQl9EaU1e1upv6xAsFrPp8YO?=
 =?us-ascii?Q?r/UJUsFYD2vUuUTqq84BlmArbs5WCXNaF0D77TTJXaZK2Kew/kSTjneGXQ7G?=
 =?us-ascii?Q?cLt6NaD+NpDXcqKzcLWk1nKqgteu83U3c97lH9iLTRAX/XjcALUoyUn8XcCb?=
 =?us-ascii?Q?9yyB4FhrygSKJENWmqKoo8HbNuion6+HQTR7Hjz3GOskZCZO4bpLNxR8QHKZ?=
 =?us-ascii?Q?ETvdzUXACtm1SX6BF33Yvf0DFn9ZRGNoCAdaOijUJR7qRs/PXCrnpmu9aSHa?=
 =?us-ascii?Q?Rqh6ckuAXzKIXXH9egsrT6iD9yHjrAR7CicSQp017AcTMc5ZBmlbZnTM2o5C?=
 =?us-ascii?Q?jpL0wckfpQbeeZfGxAnT9Aq0ad/kwN/ii4KK827oKakx3NZ6I2ylDiJTIxa+?=
 =?us-ascii?Q?Snw1UKP6i3N3I3aAKeyHWlNtA/DXaB8wizGCAuLXtR9c5gxa8DLPahxpu75J?=
 =?us-ascii?Q?+A6UP6xedF0eet/Lch+/UEr7QMturKJBKY13t1Jhd1TxNlrENoAr90Yav7cT?=
 =?us-ascii?Q?EqE7Clq8/61bDbJs5CdQ2zVWXBUQekqTyoRWtKxpe+OX4SZWjMcXugTfSl68?=
 =?us-ascii?Q?SggYaysb5bWwgERfUzhxVkVPssu4Hw1rWDKgh4yGrWqVQ7rWh+VAnkN8+Hfc?=
 =?us-ascii?Q?2gp/yTCNw7pImoK7l8E7EjxA9S+/yv7RrVcKeKRU7oMdWjSCVD42GihMECtR?=
 =?us-ascii?Q?xhUznAKrXfL8HOvuuKkPGrS2G8uIz+rgLzsdkAVzSo9nFXY1JmOa/wK98Azx?=
 =?us-ascii?Q?EQGS8qas6ia1xXN6r2GMm6ufVyd4AVFyhp8zw31JGcQ94nhi4S2sp2/QgIXE?=
 =?us-ascii?Q?TfT84bpFATgwOGON9h8RWteGAqtskFIQDdWIvFLNitfwRFK71TWYLNsu0qRy?=
 =?us-ascii?Q?LSPmHp4uQBXODTVlUNcEswn2VftqKnc9xX2okMIaRKwZ5b+y5hQj9UNPRujT?=
 =?us-ascii?Q?+uHnj2s2ISi5BbQ7296RJ8QCplJsop2t6mlT3HNWNRf4DWp6hQSYXLOaqe4b?=
 =?us-ascii?Q?ccXUT8RcMnNzcwXSpuqcqlUauUDi77yKKAdbM/D6Zqi+rFQsdk4CYl8nixiz?=
 =?us-ascii?Q?groEyYRm270iy7vKwrhZPZOi2AiY/m7UVA88l81H4uxRXxAuofH0RelHr1yq?=
 =?us-ascii?Q?6mA7WBpQ9K8AIAK0+uE5AwBZwZdjdxK0tHhXCNNN49niR0CXR4ZdyoWD8XT3?=
 =?us-ascii?Q?Dl9RJGH+y76506k=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:49:13.9343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5208a53-e5fb-473c-e1df-08dd6705faf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152
Received-SPF: permerror client-ip=2a01:111:f403:2416::61e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

On Wed, Mar 19, 2025 at 12:24:32PM -0400, Donald Dutile wrote:
> > > On 3/11/25 10:10 AM, Shameer Kolothum wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > 
> > > > Inroduce an SMMUCommandBatch and some helpers to batch and issue
> > > the
> > >     ^^^^^^^^ Introduce
> > > > commands.  Currently separate out TLBI commands and device cache
> > > > commands to avoid some errata on certain versions of SMMUs. Later it
> > > > should check IIDR register to detect if underlying SMMU hw has such an
> > > erratum.
> > > Where is all this info about 'certain versions of SMMUs' and 'check IIDR
> > > register' has something to do with 'underlying SMMU hw such an erratum',
> > > -- which IIDR (& bits)? or are we talking about rsvd SMMU_IDR<> registers?
> > 
> > I guess the batching has constraints on some platforms, IIRC, this was discussed
> > somewhere in a kernel thread.
> > 
> > Nicolin, could you please provide some background on this.
> > 
> A lore link if it's discussed upstream, thanks.

https://lore.kernel.org/all/696da78d32bb4491f898f11b0bb4d850a8aa7c6a.1683731256.git.robin.murphy@arm.com/

IIRC, some of them forbid command issuing like mixing leaf TLBI
commands with non-leaf TLBI commands or mixing device commands
with TLBI commands.

Currently, kernel masks away the ARM_SMMU_FEAT_NESTING from the
affected SMMU versions/subversions. So, I think we are fine for
now, though probably doesn't hurt to check IIDR?

Thanks
Nicolin

