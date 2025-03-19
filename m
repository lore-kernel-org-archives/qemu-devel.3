Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E29C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tux0R-0004us-OX; Wed, 19 Mar 2025 13:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tux0J-0004pj-C8; Wed, 19 Mar 2025 13:14:56 -0400
Received: from mail-dm6nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2413::615]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tux0F-0003Q7-My; Wed, 19 Mar 2025 13:14:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtpnBKWM6ypoKkOpY0DRN3pt/scxpdzm78RuG0MeuGNZgqGac/3bii+bwi4eSY8EAh1IcEoePwo1y51ci6CImAcOFLSeEmXfeHQgHgQdbQkVspKFh3Cj+L1XleWKdVOP9LrsuujLMLYadGc6JmFt5tSAQYn1Xi8A6OdLd+nLF9hpzWqKbYuuMb3CiIPGDOljNnXZxHsDxmWHA2ylHLMQ5Ss12OzDtvREDYl5i1fKw2MOW5KhX8dSGxZVD2w0JllOMrykATBhIPpFYGfvTjWA6HqFovaUZlUL3Y8B3FhQWLhn/q3uqp6/jh7P2fQ+3uk7CVUVfLhBiurpa9PZ1Ac/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q4kQUfdXArHGjxZmpVL2Ey7d9tl6n38Y58j/1KcCr8=;
 b=hq7ErZgvw91wnFX5ew23Rd08W+KAWSm0fH7oECDLSS6GwcXUOuxcfIDrdFXB7GOZ6QhMZ72QL7d3p/BtHR6xdnt7TyfFpJgfoxUOCTyuxtBnmKhJmDVTOUzTzuPw/XgdFWQ4wfo/UwvKrPoI7hTrLBbjhX2eTQJngeSh7SsVcGUTC8LVuWKRPzeFzaSCGw7QNVN5+q3LXxlrGsJXD/FVxnk/vrAwSxO8W/LQjry4ZJvmN7BaxOZ+QMjUrjOgoGa8kZAjAf8PtaGb7QagjABRnopOCDv7hVuWABXKzlpkRT//jUhcHv3G7KSG0W5KPfslj3H602Xl+xdJTa4HXiHV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q4kQUfdXArHGjxZmpVL2Ey7d9tl6n38Y58j/1KcCr8=;
 b=bUjpXWq7IREeQNlOtrXWC/CrVnQpqv+QIJJw5EbyH+LjK4fTsr14+R6Gm5uoybe+mzn/kbaT0n67QdApzT+caKJofMd5g9zdJ0QQTMS8d082L3Mj2oaPxlUbQr8V16VkGZ0atTw3cJfOZPX/5B3tkBXennkdqDu7Ai/TVz65gMF/rpov+ItmpGAOaq/B1ypaMebuA+nn920Imu7n2CZI4K6tXMtHz02hOvVb8vwukqSkML2RkGI7KnZoT6RIcC1nRzcUhxzOb798mWEJ5eT+iDqqpZg30atinwLnw22oWrhExzFZxciyYQYJhrkcYsz32rUEXqEpAYwHbIWZnFmFCQ==
Received: from MN0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:52f::31)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:14:45 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::55) by MN0PR03CA0002.outlook.office365.com
 (2603:10b6:208:52f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 17:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:14:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 10:14:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 10:14:32 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 10:14:31 -0700
Date: Wed, 19 Mar 2025 10:14:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <Z9r7dT/5E+YToqc9@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcd1838-4a5f-43df-0428-08dd67098b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ev0wXOlORkt09qDf9X47KsStZ48Id4MqQMSfPFD+Av7nn0PlLRIz/+hthmPZ?=
 =?us-ascii?Q?oKJq52s6uztL8vgYTvmBqQL9EOZ5EURN2oXVn9l/b8R52iqxtNSqdzl5pNxa?=
 =?us-ascii?Q?NGazkJM3bIe7Cih8b0yG6+sqWtNUIhhqoQP1ozOZtyA567pZ38aO1Fce71xm?=
 =?us-ascii?Q?bj+B9+s+TqFUGaxLhZfdlEly6C67WkfXoTjO3QDHf/d+kxqSFWfSdocvcA0N?=
 =?us-ascii?Q?M4+oA5lKR8tNFnXUD66Omc1NgKUT4CmdHP4QCHoniv9CFpmALCFeji9o3kjA?=
 =?us-ascii?Q?a8iN60qhqyLK+YhT9o6baY/6b3yJK6BLMbpZNF/EqqG5FVsIZV4JVgS4B/8H?=
 =?us-ascii?Q?ZDs2DdvYVtdaLEY2zEbD/ibHLlIKJIkBLVxLnx2jnSudq0wapqG1zsoFTokB?=
 =?us-ascii?Q?dhs4nGTskeFzOx3HxLyo5QpUL5+Ur8BvlLYn0c5E8AO4JZcEF2jiD0UkOILz?=
 =?us-ascii?Q?T/x27NPFsIqg35mpmOPo3NqRgUzVXWx9Ow4Jf/wYthD10HmgEu79i6m0F5nQ?=
 =?us-ascii?Q?KjhCedZu59/X0o6fmMtlUdGCNaQnsz/G7ehnJliUqRmlJgcXwIs6+ZgQ4CZ+?=
 =?us-ascii?Q?vJgIt1dcDK7SXBX3QwO3aH2ufbtAJf7277gKS5yH+JZKpmmLLxlS3f7U0sBm?=
 =?us-ascii?Q?HhLa7LANB2RaDfQox1kGJKDBtsVTsqeEqw2aUbYYgq6leX0uNv3xIbH13LV+?=
 =?us-ascii?Q?DoHJO/KSD7WxaN6iVDii6M9s9ysmpq81GLe1Wn72eXcct03H8IkkbjbL7U8Q?=
 =?us-ascii?Q?kqgd7rEdZ7gD0N9KSWE2gsBZkbrgyZPd+lobFzb5r/wxNIFqieMEOknXlTh8?=
 =?us-ascii?Q?1k9nuwScHIAqr6lqqqeze9sJs9JqA1Ra9iiMcSeNR0TX3HcxvGEb9yrRb6PT?=
 =?us-ascii?Q?L2bmzSN5VxhZTzNmhGz4y6CEqSLvKfBPxENd/QM3Sj8C3qvwTrdlugg3fAIx?=
 =?us-ascii?Q?5erZHxGTfYIlIIzBjTKpGCyppeMs2u5I6JtOadimBkwjXadMwDqx1fziFhi8?=
 =?us-ascii?Q?HCGvYhc3QDnh855WGNCyH5fH3UApjH9NDdud0tk1MGR8MEBFRykc/0At0jgJ?=
 =?us-ascii?Q?/6/GXXJ0AlD56lwwOBRv8s1gpk5lrSA/Jspy+mSejZXlZhMDjM7CpP1XZlyy?=
 =?us-ascii?Q?idQVO2oAb/6QmXb2GwTlKKwP1n44NbrqJhMa5KbUjJkeAJnTBoxRbG72YoEz?=
 =?us-ascii?Q?K0oH6ZRoYhdZxX4IVZPalw6ukAxqB8Hyb3WlXfSQmCkhNm9/GRtK28l88lBy?=
 =?us-ascii?Q?c0qRTWdFz6noRfH93ZLx0kTPud46qVAK2A6LrcDtHNK9acQsF+tLj9oWvBHu?=
 =?us-ascii?Q?aXbiAL93kvHpyOdYQAkCV+3bCSYa1/LnCIAAZhPOIlIWezA5+jc01cRxaR0O?=
 =?us-ascii?Q?ZIYkqy4iGGAX7q9R6WBLly7lIR8k6i2j1ZoQxA6YPfQrFTZ7Q+JnTFUIJ48g?=
 =?us-ascii?Q?TN+9ePCo/rHlv8cY5C80IGZOGndohjOfEWKqPsV5kwT80LuFu4KaqXZGdKCR?=
 =?us-ascii?Q?vseI1Slt4IdrWkk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:14:44.7458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcd1838-4a5f-43df-0428-08dd67098b81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
Received-SPF: permerror client-ip=2a01:111:f403:2413::615;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Wed, Mar 19, 2025 at 05:45:51PM +0100, Eric Auger wrote:
> 
> 
> 
> On 3/17/25 8:10 PM, Nicolin Chen wrote:
> > On Mon, Mar 17, 2025 at 07:07:52PM +0100, Eric Auger wrote:
> >> On 3/17/25 6:54 PM, Nicolin Chen wrote:
> >>> On Wed, Mar 12, 2025 at 04:15:10PM +0100, Eric Auger wrote:
> >>>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> >>>>> Based on SMMUv3 as a parent device, add a user-creatable smmuv3-accel
> >>>>> device. In order to support vfio-pci dev assignment with a Guest
> >>>> guest
> >>>>> SMMUv3, the physical SMMUv3 has to be configured in nested(S1+s2)
> >>>> nested (s1+s2)
> >>>>> mode, with Guest owning the S1 page tables. Subsequent patches will
> >>>> the guest
> >>>>> add support for smmuv3-accel to provide this.
> >>>> Can't this -accel smmu also works with emulated devices? Do we want an
> >>>> exclusive usage?
> >>> Is there any benefit from emulated devices working in the HW-
> >>> accelerated nested translation mode?
> >> Not really but do we have any justification for using different device
> >> name in accel mode? I am not even sure that accel option is really
> >> needed. Ideally the qemu device should be able to detect it is
> >> protecting a VFIO device, in which case it shall check whether nested is
> >> supported by host SMMU and then automatically turn accel mode?
> >>
> >> I gave the example of the vfio device which has different class
> >> implementration depending on the iommufd option being set or not.
> > Do you mean that we should just create a regular smmuv3 device and
> > let a VFIO device to turn on this smmuv3's accel mode depending on
> > its LEGACY/IOMMUFD class?
> 
> no this is not what I meant. I gave an example where depending on an
> option passed to thye VFIO device you choose one class implement or the
> other.

Option means something like this:
	-device smmuv3,accel=on
instead of
	-device "smmuv3-accel"
?

Yea, I think that's good.

> > Another question: how does an emulated device work with a vSMMUv3?

> I don't get your question. vSMMUv3 currently only works with emulated
> devices. Did you mean accelerated SMMUv3?

Yea. If "accel=on", how does an emulated device work with that?

> > I could imagine that all the accel steps would be bypassed since
> > !sdev->idev. Yet, the emulated iotlb should cache its translation
> > so we will need to flush the iotlb, which will increase complexity
> > as the TLBI command dispatching function will need to be aware what
> > ASID is for emulated device and what is for vfio device..

> I don't get the issue. For emulated device you go through the usual
> translate path which indeed caches configs and translations. In case the
> guest invalidates something, you know the SID and you find the entries
> in the cache that are tagged by this SID.
> 
> In case you have an accelerated device (indeed if sdev->idev) you don't
> exercise that path. On invalidation you detect the SID matches a VFIO
> devoce, propagate the invalidations to the host instead. on the
> invalidation you should be able to detect pretty easily if you need to
> flush the emulated caches or propagate the invalidations. Do I miss some
> extra problematic?
> 
> I do not say we should support emulated devices and VFIO devices in the
> same guest iommu group. But I don't see why we couldn't easily plug the
> accelerated logic in the current logical for emulation/vhost and do not
> require a different qemu device.

Hmm, feels like I fundamentally misunderstood your point.
 a) We implement the device model with the same piece of code but
    only provide an option "accel=on/off" to switch mode. And both
    passthrough devices and emulated devices can attach to the same
    "accel=on" device.
 b) We implement the device model with the same piece of code but
    only provide an option "accel=on/off" to switch mode. Then, an
    passthrough device can attach to an "accel=on" device, but an
    emulated device can only attach to an "accel=off" SMMU device.

I was thinking that you want case (a). But actually you were just
talking about case (b)? I think (b) is totally fine.

We certainly can't do case (a): not all TLBI commands gives an "SID"
field (so would have to broadcast, i.e. underlying SMMU HW would run
commands that were supposed for emulated devices only); in case of
vCMDQ, commands for emulated devices would be issued to real HW and
trigger HW errors.

Thanks
Nicolin

