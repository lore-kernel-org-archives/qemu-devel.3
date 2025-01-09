Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52ADE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 04:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVkR7-0002Td-2v; Wed, 08 Jan 2025 23:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tVkR5-0002TP-Qp; Wed, 08 Jan 2025 23:46:23 -0500
Received: from mail-dm6nam11on20603.outbound.protection.outlook.com
 ([2a01:111:f403:2415::603]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tVkR3-0005of-Pv; Wed, 08 Jan 2025 23:46:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaHeDuGSoHWQbBpOCMCOpbWpb0pJn297QhChwQzJr2enoVb1WyDt1x7Owl5lP3Hnn8urBjjwcqEqlEZgH9lEL8FT2QCWqTWiIhd/6VAtkXNRxzTGuMVMyd7MU49f/SQCuIaCtV528Zw28tvg8M6CX8Yt3WQ0WzyA/laEgfUsNtzg0/vFbpr6iZOQ3gu00Vgc2Hnnf6yQyFF3RKgL6HlqhYuA7WZVOK9NMPnR/zEKHAtyHes2pLYRjDlLAPK+Fw3fuXSFGDHSbT2ro1QIZRFoQCCWv/dp45Jt+wZUfvQGq4XpjUv+54Mwip/xnusyAvnmTVMxpCTz2XwX3x5y8rxd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VKugY0r9/UYwcd1ONcANQwZQVI6z9tEu6xMvbAWScQ=;
 b=XPxkQLV1aBm/T8F4t+u1/TdDI5xPvJYwnefvYnntIhHKgmBv2do59QxADmQacqOiNCZ0fnr7jz8iJQb4gK0ufbXrf6pcZXF8PAebuzFXXjBjAVsQLlDqu5TiMQxBmShcoPF2OnUZKBORfUohnVEeZymS/GEhxTDhz0MojHg+3BIEOUoOEWkHI2CmrKXy7xp/R4g3yI0K6lHeKiNtuUejNNtYnn7JGT1W07wupU+F6ZEAw7HAqusOwKTDB+MiAXw7+cD+QRsxsu2oX8FZlI2ffv5P7ouMrlS0R0S7PtKurbytJGAcfn0FZPcryciljj6Qc6hETT1t/rbqM4X3mZ+5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VKugY0r9/UYwcd1ONcANQwZQVI6z9tEu6xMvbAWScQ=;
 b=cJU85qbUzZvYsvevtJcHGAkdW5DWtM7pU2/ci3VYpAnb2xC3o8nfFIJJjN6wfQDOxJaqkho2K2UwR97CvI1RYwTx1cDHS670OVmXbRDrEZlNQdZjZs5fp4vBgV8EZyxZ70XONmq232Gw+s7AeduWPhyJjEkVailsGt5qRuDuVyC3gXFEDi/teRygxMqWBU0R3WU7ko4eCDINTgQ1w3LK0+fNyQg4vHinY0s9sRPuFDi9ZKluuIyT7hquQyCZsAJ41BG5yE5A02uRoDAXogTfBJI6ulIELKtuU2gkSxi9fN4h1H/S/mYl4uyto8jDSNueEDJATxvLJvNgfC8+PqGkEw==
Received: from DM6PR07CA0121.namprd07.prod.outlook.com (2603:10b6:5:330::33)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 04:46:09 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::9a) by DM6PR07CA0121.outlook.office365.com
 (2603:10b6:5:330::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 04:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 04:46:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 20:45:58 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 20:45:58 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 8 Jan 2025 20:45:57 -0800
Date: Wed, 8 Jan 2025 20:45:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <329445b2f68a47269292aefb34584375@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f99379-54b2-41fb-c900-08dd30688886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aGBfACMxi1UlEuYErIouiT8FnjeoMqnys9iigdF27gdsiGX+RKZ4hUwKdP9u?=
 =?us-ascii?Q?Pxh5KJevjmQ3f0plp8Kwo1zSSV8yjURJclxd6i0TCHmrOA4v7jdc+9W6NYRp?=
 =?us-ascii?Q?JARGcl1ZwU4u1KdRDWsUoBnzzxpZXiGt+xe0UfYGHmnsW5d36xObdEwGjZt8?=
 =?us-ascii?Q?23ARkyUnsduVbuL5Tf0W5OItzMoI0EnIb7K2nSJUtWsCyaRZA2vtnUzOWH8c?=
 =?us-ascii?Q?9GqtNDp89rHznL1BC1gsBHLYAeLIpqmTfb93CLznePU9fyoNZdxN86hHUVCz?=
 =?us-ascii?Q?v7V7qrW1dYIIWfXigLbtgR3zpqCcLbEbuV9k+Vtr3//ErrdvEc1xtVM/iJ47?=
 =?us-ascii?Q?Cw6bLPAh4qcqt4RAdlkQowzeSD9XRi+KhbB0jo5Ip6gs0UfZPa89TeUFL+Fz?=
 =?us-ascii?Q?ShV0ocIW7Rh8oKUUCljo8dbaIfhCsd6zyDILibDBdMv9zBhuBcaYdWq0MABz?=
 =?us-ascii?Q?UM/h9jqM4D40+ic6JusM65NW9aJvba6KEQICnMGfZICx75VHlZWva2MYM0rN?=
 =?us-ascii?Q?EEOHIjnemqk0DkrOwU8/J3OhSLJQYPY5Z9pIG367Lm+DqFghrBfIMZB2ebOk?=
 =?us-ascii?Q?oOqC7xjMmSB1zxnDaDlr5Au8oko/BMSe0BEEfghxILTbOj9FRIYPPDW2VAIQ?=
 =?us-ascii?Q?LWmR/SsAMCGwGqA29202BnXUtehs7ToOZG6l5xR1gzClhnV8s8InyyPxCP2z?=
 =?us-ascii?Q?VC4SZJhrqBx03CTUdVfr4Hs03ZqPWpjCc2hlr3ssPOVXQg0yzwtNa6ezNk7d?=
 =?us-ascii?Q?tT528gwejDvAxHeeGt4PiBdb/hx56r/nYIfe8FFzddBGXX8hQeuRjCcDRdGh?=
 =?us-ascii?Q?ynCam1xKFjBlZIuYTizERRoVpu76yat+1tXCToRZjf6QXlhtTzFO/bNRTje0?=
 =?us-ascii?Q?p8zweVwrhi75cjiI7tzmcFlsMW3+PyyOSlFQJSIKmAfO72RwLhHtuTGvmWB2?=
 =?us-ascii?Q?NtviiNMTBCGqAKEmQOoauRvHloMVjU7xaO8jvYPNBz+LGRlYGyCpxmfdHUnO?=
 =?us-ascii?Q?I96PGnzzI4kuyJAKeUuHiuOI3YhJiz1zUGdlBNfYovQ56MglNKgOjpFiaL46?=
 =?us-ascii?Q?xaI1tLhhqMqrsV6UJLagOJqTR7T3JM9jy3W8UJSEVfI6BEjXyb8yM7ZkO75x?=
 =?us-ascii?Q?5iFucqYbMhn+qzEOr1Xi2VEnPjfbwJKyuP/CeDQP2WbpjU8zc7xU0MZhh3xO?=
 =?us-ascii?Q?1zRrVo7MlSaLSSBklnCIneWwbaxPWCrgNKxW7hRJ3sINdbgvBvAbQ55pWeIH?=
 =?us-ascii?Q?1LEBj1iQ1VjWNDoBmiV0u+PurzxydMY+XSm1NKtTVEUfp4AVvrFxHgBGoa4m?=
 =?us-ascii?Q?ADRdGZvF6vcueJIzcmphtMAMk6XSphwlsGJe9jBCZFdLQfznsUz/cd+Dw7Ar?=
 =?us-ascii?Q?KIzBkoownJke03tYAf0o1jZp+d/gv+QbDoqg+O8OAZ0CD7tVwz9XNFvtbVO2?=
 =?us-ascii?Q?WP5Mei/NERwRNdj8/YqVfFb45pv7oBw7mJdcVgAuLi/PGgGjFutkP/vurUN5?=
 =?us-ascii?Q?QG26lIfzsS3hCqg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 04:46:08.0182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f99379-54b2-41fb-c900-08dd30688886
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
Received-SPF: softfail client-ip=2a01:111:f403:2415::603;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi wrote:
> And patches prior to this commit adds that support: 
> 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for arm
> SMMUv3")
> 
> Nicolin is soon going to send out those for review. Or I can include
> those in this series so that it gives a complete picture. Nicolin?

Just found that I forgot to reply this one...sorry

I asked Don/Eric to take over that vSMMU series:
https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
(The majority of my effort has been still on the kernel side:
 previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)

Don/Eric, is there any update from your side?

I think it's also a good time to align with each other so we
can take our next step in the new year :)

Thanks
Nicolin

