Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8926C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRRo-0007ge-La; Mon, 14 Jul 2025 18:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPjs-0002eb-Cu; Mon, 14 Jul 2025 16:25:32 -0400
Received: from mail-bn8nam04on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2408::619]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPjp-0002mb-7l; Mon, 14 Jul 2025 16:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tygP1nDroHSCSNSzS2kvu/TV2ZEPOhIt5oU20dIruejrO9qb5O1uhDQGP5wrH/6WOJyWWuSCMKe8Kjaq/VkXxNTgP5t6BB4te02fkeG3ro3cwx/iOTCwj7BIesduYY81WizoiR3eSXUj1ngJsbLZPLnQKviEmdQEMisFOaHHlNUm1QlNMsTsdpO6I9T2TZSLjZsBBCpKlYTcRTDImovOIbSd4u7mXqupa4RCAZBYn8hXHy1rbkCD3+O9hP6SWSY0wO4mNPX5sclXVknlcrFC8ilDAiLQ2XkgCsT3cRuSaZHt6HRDx67Pbm2OIs9zAmlFZPJzvQPtz0AIN5Kcx95Srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF0YDyHkkpkt2xZRb9EBuCBd4Kn4QPWnFyGjr0Hqzi8=;
 b=CjIpIwyAR288BCFe+RTyN/wwCf4u4PoGTDHHgaw7fRuYXLyJWrhgvUCFg5ONsW5ec2Fa8R1LbR1X4YhhCkqoiiA+/f4oG8Sczlg/qaDdq8DGQo5tUxNgZbMLlYVSKVK536vCFBI5nCmbJ+L36IWgH7UMsPNeWRFaVrC95PcHJXYSqdY82BuKf7yyplLT/eMwSMcyaMTXVmZGzU6LbGzwHj/IQ2MGPWiUHNmpI0tSnYMGqE4kWpbOf8l59USgB/NAyUHJsyiH+V7BLLoNsp1+4V5jm0VjxUDbMdKtl63BriXBG42Q6YiERGw3taCqosPOTsyVExa08YJDDEdLwLPedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF0YDyHkkpkt2xZRb9EBuCBd4Kn4QPWnFyGjr0Hqzi8=;
 b=puWtkV9EDCMRO+oi8/D/dcZnDAwCuqrE1Mqrdkuoq8mZ7gRQCXAvQE8n65qB00VVq7em+oV7Q6LIE83uSYB0NsHsaunbzRrSAaxqTjOc4g//S2OFDmcSNow4oJ7RVb3mLYLEp5CCJg56/0jV/v0cwHmPucRj38L8wcaLcwigSSiQHA26CkkiUC23nzIrB3csbKK0X/praNaS6YyaYR/yqolPIok38zUKpgVqdAM+REcyEn8Qs8hqY3Rfnu70wZ0hJa1aP7aVNFdk4Dtqs016UsMlCoiSl2a7IyAx9+TYXkl1CIX5SqmZ15upSW7bm7Q7zvQcQjSybpmTKUyuvaWaxQ==
Received: from BL1PR13CA0402.namprd13.prod.outlook.com (2603:10b6:208:2c2::17)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 20:25:17 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::31) by BL1PR13CA0402.outlook.office365.com
 (2603:10b6:208:2c2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.15 via Frontend Transport; Mon,
 14 Jul 2025 20:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 20:25:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 13:25:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 13:25:01 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 13:24:59 -0700
Date: Mon, 14 Jul 2025 13:24:58 -0700
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <aHVnmrIDhtPBSQuG@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHVisDScCht0sW8B@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHVisDScCht0sW8B@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 214d7766-6a31-4558-eaa5-08ddc3148b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8MOwER3PFItzA43tHGoQjEtVS8WLTKi2naOYeiu+/Gh16KNdYrxBmiwU+3?=
 =?iso-8859-1?Q?HVbHSwsJ6TceNekr3P+9te669Zwy+l+e9fnqfyzMvbnsW276pieytV2uXp?=
 =?iso-8859-1?Q?AP1xju9EhbaFUyjkZs0BK1ItvkULWTuAxxoEUx4ulmwYs3ZemrqxCjiv0K?=
 =?iso-8859-1?Q?5XACcnom8bl0tdkHfYEIUY8i935gvy51ttxPgE3qo53KJUMKLZjNpRnSvg?=
 =?iso-8859-1?Q?x0+41onmo5gYnmEu1q+KDWoxE66jofuJ3BAVMv215toU0kzm6JXIo6eXxj?=
 =?iso-8859-1?Q?V/kIOl0NpTth2CD+EvVqqrgBJEJPxFKhKBUuXohk5xo+LDGZsLKYgiSCij?=
 =?iso-8859-1?Q?tvCeevQvgziugkVMs0SPTUpK3+GIZbLAe70wiu4tOLM/NR5y6ubO0RQe+A?=
 =?iso-8859-1?Q?eQ3n48zaaNRQTkTPY4h/ZVvGUjBKYn62Z0ZRx7JFTLCx4qPerICEX7yYh9?=
 =?iso-8859-1?Q?G8/6MANomsdl2Bp33r6eWrhOYawb7c7FlIDHnWiB5aS97cmlSQVnbBkFQX?=
 =?iso-8859-1?Q?sskWB7VDoj4OY7P0G6YONCOUCse/MJZdcyuhtwz5jEOHebUkbVJbmpNDCM?=
 =?iso-8859-1?Q?41EMGBYW4md0LSKx2Atbrcvj3E7V+gT7EcdrOeT9LIzy3XK/WAz9fq21MO?=
 =?iso-8859-1?Q?VxrXUI0PxDYwmD64rOE8uM37OKIQb7PEIF3D1NVUvC8j1/jxoPLtHWpXS8?=
 =?iso-8859-1?Q?sKm9PZkTqdnFytTDAY12Ul+17SSeW3MU51ZO6idMcjY5ehOnSq0sL0e8e+?=
 =?iso-8859-1?Q?VibmLWH9IIJyEU9lxXQJXbgoMC/raOQ+v//rF1h8vU3wHAYc55xncfUS7J?=
 =?iso-8859-1?Q?kpyw0PrGGxcQnO79/KT+o5MNRc7Tc6ZUriY9pynWWpvUFn8fivD0g0psFx?=
 =?iso-8859-1?Q?xtWvqS/uDgGgDi0XyLsjiHk4uHC9sV+ej0daRoUL1dFuCaHTNA17i0Avq3?=
 =?iso-8859-1?Q?h/Khs4HRL8TohXRyIaczCe3WdEvtUy3/gDrt9UU8vUR0FtCvFub30wG/zr?=
 =?iso-8859-1?Q?MIr0+oUEolbXLQacuVmHM223hr9ZzqBQJZEgu8lFa8gJ1z3lKKdegN1VpR?=
 =?iso-8859-1?Q?r7ZqxkVdHGlJmpkbJH2GZqBe5/GHaBuVnZCOfp/o7byTSGsSCXOUCWFlAZ?=
 =?iso-8859-1?Q?nsVCfl/sQ0EXeyrcvmZSOYrmhpqzkhm0JH3jkp6r19Sd4ay68jyufx0HuZ?=
 =?iso-8859-1?Q?oCZ1Nr4BQTbSYysJ8Hj+LlVNPmt2Mtbg7wy+IOQ1KudLmTVfschZ6pjD7Y?=
 =?iso-8859-1?Q?9vlfkMA2ziZsXxoUls6Tz3Pa84LeO9pyDLseZ0aufPMWnIoef9W8QUBp+7?=
 =?iso-8859-1?Q?7eyhd7XXviUfCQgRXqBnPe2SU4e9LfIl5yHWbtEGPBMaxGUlc0SwI5pcFV?=
 =?iso-8859-1?Q?I0un8z4QOticBuBLZ713VhmIB9wubWJVzZSCV9/x+aHqD2w9uhFzLbkkke?=
 =?iso-8859-1?Q?vsqwuC0mh79nF/Rk5KvYVXFM38UOTb56JG9VWau2/2VbYSgq9o6Pw3rnxn?=
 =?iso-8859-1?Q?E2ZEEGJXGirXWO4UGNPrwoCaYoG+12U1/Ea3kyZuGjc6r5igxhj3J7d5/J?=
 =?iso-8859-1?Q?tUftxt1tqpWkvB3MjwvF2hAaiUFy?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:25:16.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214d7766-6a31-4558-eaa5-08ddc3148b8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
Received-SPF: permerror client-ip=2a01:111:f403:2408::619;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 14, 2025 at 01:04:02PM -0700, Nicolin Chen wrote:
> On Mon, Jul 14, 2025 at 04:59:40PM +0100, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Not all fields in the SMMU IDR registers are meaningful for userspace.
> > Only the following fields can be used:
> > 
> >   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF  
> >   - IDR1: SIDSIZE, SSIDSIZE  
> >   - IDR3: BBML, RIL  
> >   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
> > 
> > Use the relevant fields from these to check whether the host and emulated
> > SMMUv3 features are sufficiently aligned to enable accelerated SMMUv3
> > support.
> > 
> > To retrieve this information from the host, at least one vfio-pci device
> > must be assigned with "arm-smmuv3,accel=on" usage. Add a check to enforce
> > this.
> > 
> > Note:
> > 
> > ATS, PASID, and PRI features are currently not supported. Only devices
> > that do not require or make use of these features are expected to work.
> 
> Can we support ATS/PASID at least? I need to double check intel's
> series, but I somehow recall that there is a PASID cap support in
> the VFIO level, so VM could actually report ATS/PASID caps?
> 
> The invalidation part could forward ATC_INV command too, as kernel
> supports that.

Also, the Subject is missing prefix "hw/arm/smmuv3-accel:".

Nicolin

