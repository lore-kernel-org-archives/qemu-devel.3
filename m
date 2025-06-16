Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAA8C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2iF-0002xx-DP; Mon, 16 Jun 2025 01:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2hm-0002sP-T8
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:48:26 -0400
Received: from mail-dm6nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2413::614]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2hk-00087l-Js
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:48:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnFZ2RqsypsV90lvzzVdfo1GuTXVGkmCrgPozs3TLTre4gwrsvWDRR4eshGCP/w0yOxK09HjLja0ZLMR+/BkcHGAH1iTG5U4uJd6Sz7f2nBpiVRRlQAOJFcXZNIEgO5eZAijFImmpkg+5XIgiMN+5BLbPgUjQqG25QlURHNQqnTrYULE9oh6KCMCs8S2U1z5JvDPmCSPUvkKNeAX6WHfScdPC13X4ynVc/bcNf3mK/5WCj7ZKhE445pogMS9vON/kp4lcjk46mI1YJ8Ooatehcw6YFl23czKc3VIdCQVQHaDhZjBHuZ1IO+aYkY6aL/M6QXWujQ0430jn9Tzy/FVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56wanNgIwSD/zv+9okakFb5eY50M0MwdTyYIHoaQXMs=;
 b=ejPyRwIcA/OBO9rnPm+z5aMWmnYSBftNddkK/nsxZK9K2RhVVOVR3JSzG+rlcAXmvEqkG50JN3/o1Q8RPrQb7BypVaZevGyhWw2SSeB/+lErqN5zSZHnxplZYoWCUIvnANtEjZSIFCFx+ge00NHbX0kIQmVgCir7sX4TEGwMcfWosZLQ8iOxo0giAGluNr9WzA4hOue+2JVUL5s0nZg2T3/xGMzlQgp+RPZsGCTloHfHUP2g7uUb9N0/Bf6RR0iQpxoTVlCElQHXQZbpUef/X/eaDFjLpLnZ4LXVQvll1J8GOkP6kt8NzqduOC+BOSk76U45D8ZG2HquFO71smy4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56wanNgIwSD/zv+9okakFb5eY50M0MwdTyYIHoaQXMs=;
 b=e49YXAxbcwPkLFhRb8f18XH0NTpG0Skyik53DjW3a5XYs0AoxYZJ83Uy8N1SM3xC6EOQFmDIYqiN16jENfVCh8482r8rQYNoKuXasGvYv+Qx4tRUNxbhj6/rJ2I+UJBeUsKhREVG2AVXGpr2at4Aj7evF+7twndtPCCv2bucG8xDvlp1/dY273dxzINkSi5PvL4HM2aYwOeUM0KEBlnl2LO5q/a3MZbm4juI9n6Oj28cfPT/SEw4oeQLRet3xY5BXnhLFevqIKtwwK1IcG5EGvjZfhhiUdnME0XkjkDlxFuE2ldYSC9BbTV503fyBX425FJODaJoIJFpndQlQ5q2dg==
Received: from BY5PR20CA0031.namprd20.prod.outlook.com (2603:10b6:a03:1f4::44)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 05:48:19 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::1a) by BY5PR20CA0031.outlook.office365.com
 (2603:10b6:a03:1f4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Mon,
 16 Jun 2025 05:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:48:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:47:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:47:58 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:47:54 -0700
Date: Sun, 15 Jun 2025 22:47:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <aE+wCIG8KHb3u1lV@nvidia.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 24487a43-30af-45aa-27f2-08ddac996593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NdAYiMsjHD2JYAe5JO5l7ghGb7nZohWrtdewCJyp7YKKzZ1n3/TRZwun/lxa?=
 =?us-ascii?Q?u8XkZUQORSmgHroaiCNQQBZGob7jFqjw0MuK8sraqFxxuMHTFt96gKH7S1Jr?=
 =?us-ascii?Q?ibmyntL5fMr4hLMhdNLqFlBYxKpMQq8OGW2g5xRcub0lZ3Cm+Xz0OSkaYUFk?=
 =?us-ascii?Q?aXyvtTXcEd5KoM/KrD7UHIuCZJ+lS0ASU091Y9REC85BxHw1S423eVoJlYgw?=
 =?us-ascii?Q?jybVY/5auRppvpxt6O5Npu4DFmwfOdjOEf45DKT9w5l2DnAaFPYfEbHoWxUR?=
 =?us-ascii?Q?PqOaiTlL7LUSHsUVPCdpcmuDKk5BoOiSveYOZrykug1TlLQB5fai/Uv+lcum?=
 =?us-ascii?Q?UC5i9GH5Y0ow7aVeDC6fvnXbIkQ2WAJbtmpuv67oekJnL3jv0+e3LvWXGRNH?=
 =?us-ascii?Q?4CUZXNN5Kr/tBRN4odToOkmbDhJcFoUC1oL5rQoa2p4M/uM5TopG3O4pIDKV?=
 =?us-ascii?Q?84xNw6SzQmZjg2SJqHuRUUD+vCFC9WDNpj2dQx4LvQ6RUHKG5NlV+gJJQ1Js?=
 =?us-ascii?Q?K1kpofx3QE3YkJr4DO0W7o0crLtJ7xYqxQ1dI+EHFeiKp+1ClR5vXLlR5Q5Z?=
 =?us-ascii?Q?kDtpYhZwwFoDt13E5zw+Sg8rzWNYAW1qTnCpM9LwWNg8S0c27LlYV6yOg3QJ?=
 =?us-ascii?Q?u8ArTNOD5hsT2OinjK65sS/y23Xfq6DCiqqWxkT9qskzLcbr1srhtZftmooV?=
 =?us-ascii?Q?wnpiRc3TinxNzLN2gs3xEz7dHz3NkTxYV3eXnTDev4QE7v5CW6C16ygya+X/?=
 =?us-ascii?Q?qdkqi71qF4/ee/2XZtBSpJQFAdfLOXLhHw2A6tX6AkJKoJpt8Y1peVEJViab?=
 =?us-ascii?Q?qjwOhun5WkPoD1RRUO6WMuG2oDFgnfLaF82kNrRUEOH24DqB28NBI/fWDnPD?=
 =?us-ascii?Q?mYkZMVVnoAIFDIyWxPNL3dj6TDnP2wpCMDdwpolY3WIZujZ5O26ZK/q1AT9Q?=
 =?us-ascii?Q?OzWaN1IcnZltO0RcfpHd94JMV4vC9F3e09iIUiC7hXy5uOe9JhyMZJg8Bc5n?=
 =?us-ascii?Q?5DA1D3qjUG48YDdDtUgkdBoEgiF/0ku3lXPRZ3LMzISy1hgkuEMKdDf6c9kE?=
 =?us-ascii?Q?Ex+R1tjKDC5kuM5Sx4NcZze+OC/1rkpvTV7glmYyEDAh74HkICi+ULW5sMi+?=
 =?us-ascii?Q?dn6Pr16X4qw9Go/kTno9VE8bxj+NTUQcC8Nq/tqWFSDWB34h4gWU1bXiWipV?=
 =?us-ascii?Q?7pTe/B9wE6x7rxvDDoZxHJCNBjv9x6bSEo+O6buZG2ZTJpLD6i91tTLVcqA8?=
 =?us-ascii?Q?c/gy0s2LUrf0CbPIb4147b6hDMAXVk4jEDIxgAc2C941CGjQ3b0aZCQuyO/n?=
 =?us-ascii?Q?ogE89CwVyEPqof9iyicRPZJB1Jsh/xAzLmL+cfA7WyEA9prji1cjCO4AkZp+?=
 =?us-ascii?Q?iummRjyrBczMTaosAR1YGwwGc2pHXQaQMHk9nQoMdqkwSWTp7demCyB3DS//?=
 =?us-ascii?Q?Pg4mVUTKvlxhlVJw0omPGTUHQLHYVwMeJRNjZd9qBu6S38JZgUzhLYIGtn6N?=
 =?us-ascii?Q?R+JyZ69t9f3ZYXGsEsl3dGo7InXI2dBGhebz?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:48:18.9691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24487a43-30af-45aa-27f2-08ddac996593
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
Received-SPF: permerror client-ip=2a01:111:f403:2413::614;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Sorry for a late reply.

On Wed, May 28, 2025 at 07:12:25AM +0000, Duan, Zhenzhong wrote:
> >Third, the vSMMU model, for invalidation efficiency and HW Queue
> >support, isolates all emulated devices out of the nesting-enabled
> >vSMMU instance, suggested by Jason. So, only passthrough devices
> >would use the nesting-enabled vSMMU instance, meaning there is no
> >need of IOMMU_NOTIFIER_IOTLB_EVENTS:
> 
> I see, then you need to check if there is emulated device under nesting-enabled vSMMU and fail if there is.

Shameer is working on a multi-vSMMU model in the QEMU. This gives
each VM different instances to attach devices. And we do not plan
to support emulated devices on an nesting enabled vSMMU instance,
which is a bit different than the VT-d model.

> >On the other hand, the VT-d model is a bit different. It's a giant
> >vIOMMU for all devices (either passthrough or emualted). For all
> >emulated devices, it needs IOMMU_NOTIFIER_IOTLB_EVENTS, i.e. the
> >iommu address space returned via get_address_space().
> >
> >That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
> >for passthrough devices, right?
> 
> No, even if x-flts=on is configured in QEMU cmdline, that only mean virtual vtd
> supports stage-1 translation, guest still can choose to run in legacy mode(stage2),
> e.g., with kernel cmdline intel_iommu=on,sm_off
> 
> So before guest run, we don't know which kind of page table either stage1 or stage2
> for this VFIO device by guest. So we have to use iommu AS to catch stage2's MAP event
> if guest choose stage2.

IIUIC, the guest kernel cmdline can switch the mode between the
stage1 (nesting) and stage2 (legacy/emulated VT-d), right?

Thanks
Nicolin

