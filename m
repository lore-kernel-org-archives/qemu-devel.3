Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFBAC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc635-0002sg-1A; Wed, 16 Jul 2025 13:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc62w-0002oq-Kj; Wed, 16 Jul 2025 13:35:59 -0400
Received: from mail-bn7nam10on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2009::610]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc62t-0001ZT-Vm; Wed, 16 Jul 2025 13:35:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWkvnZHARoz/358MjcN+l7Rrmzpcjrug1ld7kHEaarpQoMXVQ7YA7IYkupLthsIjzmR7oqUUJHM+3STVAbuQo/EXPgbFh4WTZ5hRd4gizcYkieRTBUvFCY8/qTavsgFQ/31/Av+qh20hG+IXxFNXX6pUskwNd29ZGZkvZn12zYHcKqAhxGwAdzCg3DJDdPbrAEHPHMfpb3Td9OKBrHeb5YN71r/KDLGzAFs1HbFidVIPXdpfoPIcrHq5HCeOhld3nJQXMiMJVvwxR9lmwxJ3ueaFny6vglB9YUny5ObxziXRRBQuKxMxo5hpo6KtIfwewJJ+ChHSeBB7iEgPT25Tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vujDJIApw8enOuBFqZ8iZea8ZK3iDCf6acsyxE468TQ=;
 b=ajH9wFq5TAlM0+5AOUF9tBc8hB2Pgr8Hl/zEEhRRN3SCQsU601LAMBCESPp0XkOlJpDlfB9buV3/A+VkW5QDVM/lS1Vdq55Cz7dD1H9H3WjMA5aV0I0PG4FR6WYPQN/zO/7Xjb4lwFE0Ky52wXM99m39gq9wAzN/GtytIA2s23BRTMDBE/CtK9DBaph7j/w1KjNAcFWtyDuDzlapgZi39irb2n4N3g4JKLqC+d1anJQEIOwrL3qpdD82FaeV9XX0wuAMtnxpzADLbV/WlgWlaRe25CL9CyrvXd/ewhZU3u3y89MTi4hLiyfZLH7SF4QzKyvv6pI2e1jyVTsgpZQHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vujDJIApw8enOuBFqZ8iZea8ZK3iDCf6acsyxE468TQ=;
 b=WCw0oqaGOy3OBCZ8geF8wvXw9m87MWqr5DR31gjxXGMDeWKuSHSw/Sdl6DNv+y3xgEZMhuuoSeycvG6rSEStl9MJCG9BW6NNouK5NnOd1oOdg6cd30xzjSSdbqbdpPDladJo8nBU1IZ+38dVmS4MPYybqh6Z4lR/yooi/ICu0xqyoZtUgwY7bWBajEahKvUqKoAcL2Loq0IUo162MS7a2+q/otjJUGx6uZh0r8IKnjN2MKyw5lZiZ6xmO4pFKzaFK6kdChW4E77DR9jjVp4/6GG8XmfeRMjSTpoTUrIO/nl9uQsa8dJG+EJxggBIlEKim1gByrG0ysSmL140SWrCWA==
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 17:35:47 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::78) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 17:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 17:35:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 10:35:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 10:35:27 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 10:35:27 -0700
Date: Wed, 16 Jul 2025 10:35:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <aHfi3SS/V6qlx77H@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
 <20250716115123.GW2067380@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716115123.GW2067380@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: e59f7662-2547-45a3-28e9-08ddc48f332a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V4EU8stTaLyhp3m86eD6yr4X8MbKVlJIsMo+J7/icdiDLZ3tpt/aIL6CpaVr?=
 =?us-ascii?Q?FfrZ+KIueyFnz5nq2Z2qtR0I8O09+IrbqmNVEqbuG//djzliZsgq5aJJm/Ml?=
 =?us-ascii?Q?LHI6TmY8SC+TkHA6PEASzu9mGjA3bhN1nd6+IT8b7rpEUHjqt+632AAnXWJG?=
 =?us-ascii?Q?KRA9rWVD5DYtwrnNxDVDpCSs2mBXepUnH5pOi9Mo+kYbSlAK+WNA1IhpvhpE?=
 =?us-ascii?Q?3yG7+ZFTov2+GBvXIMOWiR2YQ9N8bt467sbr62i9fjiZRif7PEHMUXVDgCGJ?=
 =?us-ascii?Q?CInO5rgiwCwcx9mA2ISW1ovNXZSolZCbeX+IMhmBZHxDa3nTQgfx1I3zbsiT?=
 =?us-ascii?Q?RqDpAouUA+IB+PIRAgO4pu96U+z4AldVCKzaJQZuo+vnm5YQrVm8ifuikaaj?=
 =?us-ascii?Q?RdtqwtJobq8yg7w1sGUEZEkqzV59+PjZTrsOIcUmrSeK53uMFs6+wU75RCFJ?=
 =?us-ascii?Q?8L/slWAzAAKvgh47b/zZauXFFdCOhonHxxig+xsMozveVE5WOapWjOUe/g/T?=
 =?us-ascii?Q?7DP2uwQjVosvDGyQl8uMMP+Xrpmxn6XdQ4RhOycGnw2jEgXAdekozsha/oB9?=
 =?us-ascii?Q?ZD6bof+q6tLlqWw87ggIYfrhE+UomNhh29JesKxDyheGN32S6+MSvdMJG1U4?=
 =?us-ascii?Q?E2MGem6VHn269UT1ECRvJVhyQwIvOutEtxxh0cgiJGszF82WZ3VajsJ2G4lJ?=
 =?us-ascii?Q?MDbug8q1B6AYhHQ/o7NT+RD+FlLbTcWTnObmTCEc86cbUlFMPGKjN16xB7FS?=
 =?us-ascii?Q?gnvdXZNRJ7l3VotwEddNaMiIz7xOT789pkcULofQIQs9b9Bcb9OvatJOxAtI?=
 =?us-ascii?Q?RUOnWNsB6EU874PtFRfSSjpWWy8pYQAAvNcheEmQSN5E3WsJKDSxhmMIvqlJ?=
 =?us-ascii?Q?yHNO12OhQ2f0ejiHOKuUyioZVPkgYNlTzuCQkpxbzXWsAgyMfBjt8jPs78x/?=
 =?us-ascii?Q?foUynsH6c4hdKIHyNl+40Mzck5FxB7ee//Fc+OGOu0FE8bwaq9T/6/xXzB3B?=
 =?us-ascii?Q?sPAWONDos5HcI9XEo9U8kd3wtPRAwLP0Zx8vv6K4gcjEK7E3KDexxoNZy2WL?=
 =?us-ascii?Q?RArKAYfapG4FRqJl4WDzlxXn6SytQ7vp9IOOYdu3BZCQ+fNqnKGSnL3DfQ6a?=
 =?us-ascii?Q?tR/sCMuAY63gzD76klPhNyiQXnVxaGP9R4PCzftQT3CyovA5dojXZTiTElDn?=
 =?us-ascii?Q?9fvAWil3rIFDuFRNWocLXlSv5zC+n668mEmbctIdz0BlNN8XymQVFo6v9622?=
 =?us-ascii?Q?05R1RsZdTCDMRur/L8pyPOmGrLn01jW7Xr5jnXQOi19lzvREUZct9fjBqcvy?=
 =?us-ascii?Q?H0iWFrKeCqE0nhHYliAsif64d62ln+No8AVD/dl2vlN+T9/Cazw9gRXYF9lg?=
 =?us-ascii?Q?+87oJmMEQufIWyeKZaYbT1nGrnoU9wdGoI6tygb9S0zmbTCLghYtqzBGJlo6?=
 =?us-ascii?Q?unYmGhfx1cP13K6NuGqzNMDTRLA6sH+3xCupoH0xa2PahRS/OadpSUziZT9j?=
 =?us-ascii?Q?N3tQht9brmrHHr4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:35:47.2291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59f7662-2547-45a3-28e9-08ddc48f332a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
Received-SPF: permerror client-ip=2a01:111:f403:2009::610;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 08:51:23AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 15, 2025 at 07:57:57PM -0700, Nicolin Chen wrote:
> > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN4K);
> > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
> > > +    }
> > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN16K);
> > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
> > > +    }
> > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN64K);
> > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
> > 
> > Unless there is some conflicts between the QEMU emulation and the
> > SMMU HW, I think we should probably just override these fields to
> > the HW values,
> 
> The qemu model should be fully independent of the underlying HW, it
> should not override from HW.
> 
> It should check if the underlying supports the model and fail if it
> doesn't.

For every bit? If there is a conflict at a certain field (e.g.
VMM only supports little endian while HW supports big endian),
it must fail.

But here, I mean for these specific fields such as GRANxK and
RIL (range-based invalidation), we should override them with
the HW values. Otherwise, the guest OS seeing RIL for example
will issue TLBI commands that the host can't support. Right?

Thanks
Nicolin

