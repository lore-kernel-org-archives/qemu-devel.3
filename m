Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943CACA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 22:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzMgJ-0006tN-68; Thu, 18 Sep 2025 18:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uzMg0-0006eq-Iq; Thu, 18 Sep 2025 18:00:38 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uzMfx-0004sB-Rv; Thu, 18 Sep 2025 18:00:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4VOqJvcVkVfmaj9YZnRRiKUNx8JvI4coh/iAFtLgjUgBOrdkrtODW2ecIq6RDA4qtQmww0VyZ1qKr2ICp9u7y4HqKM4d/Zs1VSrLzrD/o/lDBDqSXambKUa3/01pW/7kvYSvwi2pJliNKGrr5FMSjYEcs2qmWpq2DluCrEI2sm87sa5gJNUR/42y2IZeHxXGBIKu3W8q7ZBDEE1yVJT9UGIQTB9EKy7KquqhvyRrtnpmqdUiIV+H4KU/F0g1/Pgq6hRlJL3rx55ppHk6Q1VegHIraM9/kpyjyMZanGxVKXJKKJUF+GxYLJnwu21uvxxORm37rp6wsuTHjdO2pPJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfoa6UYot7IAja5JWxbzVltZoTi4uWeQKi/awou/DeA=;
 b=u9dEm/G0dwmYQfEKS266VdPLReb9zmbt1Nuk6fbjDOvjfw4V0CzTL8h1eIfuaXPPAVQJ5vlvaNuVYYR80zsVl8lqtt0zS8oltgOT8UHA7PohEx5k6OyRfywcXvh3BBS9C89JSgzem+bZPmVa8IInIMrG8eWf8NvzPQCfkj6k0GsJDVHBw1fitn1izRXXRAPeFSENunH+fxgR9G7/Y+/VWW2JWGmJqTDyf+A+YthSIK8M0U6MWTfjwYmodrMLvkBc7sPLFWoVNk2UHN9HHEl42nkgJVjJyXd2eE0O/phxFhHzgoeg30KVZnSo0zstrc6wvUVtUkQ5lFiAbi8I4VYLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfoa6UYot7IAja5JWxbzVltZoTi4uWeQKi/awou/DeA=;
 b=T+a+KWKCrgfd8Oi4riPWH3OKImeAfcsfJEKaMgPW0vqcPlnnl4u/d3JYRvvk7w0SWoGhvsIwm2KIM5AQoOTEZR8ic3+3xdeo/GhmU9z/hWaGi1Vd84AToATM1wwQwY92s0dnfyk1MHb6H/9TC636REe/U2u7C7LhUijMypztsZm3EfncTcvK/zFpIrMasffTKXQcP079H48ukOD8CIBd7elVvbyJCl9SMHi4xjzcKoUKMpLMaaPh7QOllbl7JSEiQWx0Cm85n9h8eQJquoKATpe9FL0Ux6E9SJPgEzJidHrEKlQwZUin9QgVzXUsbA2FoAr3PLVfTr7T0naTyNr9nQ==
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 22:00:16 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:e7:cafe::76) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 22:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 22:00:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 15:00:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 15:00:02 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 18 Sep 2025 15:00:02 -0700
Date: Thu, 18 Sep 2025 15:00:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: Shameer Kolothum <shameerkolothum@gmail.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aMyA4AHf7pqnOzSV@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <aJKn650gOGQh2whD@Asurada-Nvidia>
 <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
 <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
 <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548B6A98B640192579078EBAB16A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548B6A98B640192579078EBAB16A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: df3efb43-7005-43ca-9c5a-08ddf6febf37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QvixQQ6laxYMyv9SQvch7UPmZClZMn932+wfDEcy7lurPRUbGYiaxn9NmT3U?=
 =?us-ascii?Q?qTFBd2oYSz1/u3q/qBhGcd4UqzP7/+6QjPxv/QPAHBveyehPipZyf/FPoEG9?=
 =?us-ascii?Q?9oKE1OoGk/1KCTMLiP+7Ezv5Z5XxwTtcJiPho4VLeergN29hmEWvAvUbI1YL?=
 =?us-ascii?Q?g82/CRb0pulzgXwt8/5zOAah3Q80vH5dufhBN0OWbP3wkYlJSPi6ghU8rwTe?=
 =?us-ascii?Q?cbDDE//Kh0w7IX04RGVBuLLw8BGl51nHUC87n/Qs1wuAWmecSxPg8mTLguiR?=
 =?us-ascii?Q?nEaCyYyD123ge+uXx3fKsW86417so+qq/1hZFwuOnsxWNzCvRQu07CGVxCj/?=
 =?us-ascii?Q?hO92eUShz60fesjSDX0zuoiXxUI/fiSLt4ET3ipi6cwOSsj0ewAmNJhJO719?=
 =?us-ascii?Q?Z1I7iKu1+Wcvvgmrm7m4ZYz5m8dl7332ZY0m9zaiJ3/iD7FcS4vtjeIvgyjs?=
 =?us-ascii?Q?GJQovIHGoiTm2CDKLiewNYjqQJVbOiCRHkRdoVKeQkhsW6R0T1D39PqO0P0D?=
 =?us-ascii?Q?+NTx9eY68kBGwJyY/JQhGTi05bWcn0gHFncWgmLQkzsLyhcIhQHA5NWVkj0H?=
 =?us-ascii?Q?6N9qS7d2759B//rEzsZ4q5K5++DKfjLpzJZcjFIVyQjwzELk5OC1To2sDFOH?=
 =?us-ascii?Q?r0vLSKjPVROeY9URs4CunqK/6ii5zTe780201lsmufvBPS5jTMHFnSRadSII?=
 =?us-ascii?Q?+yVugh0ZqpFthMHWiGJXEPZF8kPECzzGw2cVpQfgomq33wSk/OVJqQodoZnp?=
 =?us-ascii?Q?zwPxhryccy/cuLOgZI5zbxPryoON02pPy/cuyNgqijVgnYjSZGaRIdhLXeIR?=
 =?us-ascii?Q?V1SQVlbOibQCWkCDX6HNWo7YUu9uKZVF5AYttWS0mY0ulP4WObj9PeChNRt+?=
 =?us-ascii?Q?GFBuVmBpZ4hD5xPEb6LWpozIaZrmHIdCaXgUKr/0q2gxfvnf9U5Yi3RU0oCr?=
 =?us-ascii?Q?T5Xz5xjlvEieQRdS5TuVb1eqWOKio1thaZ/RA+sZ8My8ji18ECRKTv5HjTXM?=
 =?us-ascii?Q?6+jtQ9QF48c3l5aOEa8nzUCFx2H95nieSC/ckr6p0Ti3V84ZzCr/xf3a9MZp?=
 =?us-ascii?Q?inB8R7BH07TRF5lxvGvG/pJhIvPWi6gL0/n43x7DvBTlWWRZGUIKaAeGw2LV?=
 =?us-ascii?Q?4Su1ZIcGXk5VOL1Q5vGfqv+5csataiDCxM6x0aqnhp8yn38/hUsXhVPbEA0+?=
 =?us-ascii?Q?nEaNVwoMW5EyelVWUKMZCUk56KLyOVBqq0ktN+N2EYMoxcLxa8oA/mvgkC4o?=
 =?us-ascii?Q?kfSS/0Ya4uI4UjzN63sVzt5G+RBF+gdJ9siPDFX49kr6CKI347B9lmth6C+M?=
 =?us-ascii?Q?AoyBKTsCC3AOOLEYDO0owuggscaR1m1huaYkOUTDAG4/rpNnZ/r3mwTgZe6E?=
 =?us-ascii?Q?WoJvPl4F+BmCxLurzw4DvzQ6nwNwgHHWxpbAhOuBz8RX5+VayAEDHT5BBXxP?=
 =?us-ascii?Q?/k4HI/eK8f1goBt9lvIJKYx0yT8QeO0IRpG1MBD8Kf0Uqz1tCtZwNE+5NxAd?=
 =?us-ascii?Q?OW4r4jsFZ1FG+66x0VLdAgCgmFcAFzZkVjrT?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 22:00:14.4765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df3efb43-7005-43ca-9c5a-08ddf6febf37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 18, 2025 at 06:31:43AM -0700, Shameer Kolothum wrote:
> > > > @@ -37,7 +37,6 @@ typedef struct SMMUS1Hwpt {
> > > >
> > > >  typedef struct SMMUv3AccelDevice {
> > > >      SMMUDevice  sdev;
> > > > -    AddressSpace as_sysmem;
> > > >      HostIOMMUDeviceIOMMUFD *idev;
> > > >      SMMUS1Hwpt  *s1_hwpt;
> > > >      SMMUViommu *viommu;
> > > > @@ -48,6 +47,7 @@ typedef struct SMMUv3AccelDevice {  typedef struct
> > > > SMMUv3AccelState {
> > > >      MemoryRegion root;
> > > >      MemoryRegion sysmem;
> > > > +    AddressSpace as_sysmem;
> > > >      SMMUViommu *viommu;
> > > >      struct iommu_hw_info_arm_smmuv3 info;  } SMMUv3AccelState;
> > >
> > > That's changing from an ioas_id per VFIO device to an ioas_id per
> > > vSMMU instance, right? I think it's still not enough.
> > >
> > > All vSMMU instances could share the same ioas_id. That is why I put in
> > > the SMMUBaseClass as it's shared structure across vSMMUs.
> > 
> > Ah..you mean it is basically per VM then. Got it.
> 
> Regarding using SMMUBaseClass for this, it looks like ObjectClass normally holds
> function pointers. Eric has made a similar observation elsewhere in this series.
> 
>  @Eric, any suggestions?
> 
> Is use of &address_space_memory directly in smmuv3_accel_find_add_as() a complete
> no-go, given we are talking about having the system address space for all the SMMUv3 
> accelerated devices here?

smmuv3_accel_find_add_as() is per instance. So, it wouldn't share.

Even smmuv3_accel_init() wouldn't work.

If SMMUBaseClass isn't a good place, (I haven't tested but..) can
we do address_space_init() in the VMS? I see virt.c calling the
memory_region_init(), so perhaps we could init the as_sysmem there
and pass it in to each vSMMU instance.

Nicolin

