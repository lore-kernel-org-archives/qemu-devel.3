Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31471CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3q-000202-5G; Sat, 30 Aug 2025 11:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urpqp-0003w7-NT
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 23:32:32 -0400
Received: from mail-mw2nam04on2088.outbound.protection.outlook.com
 ([40.107.101.88] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urpqe-000849-Km
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 23:32:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM+6NGiHOnLyvxMwvUkKw7kH5ZpSB/gTWY9oCkOPk9gBa4FtyPSc6LJyVPi+ov8/vqBnO8Ugi5thbNZFxL/G3zKIYFiiSRTh7fYCtPOFoCugr9qAz9Wi8s22ce2aKDMf0c6GrzLSbCUDePOLlpmMN9pILUxT0GpIa2P9RmskTrNgIvzDXTofbtlDVkK5bPmeL3QRhIgpa9SoFy81kNZk6ERnGmXpZedSuVdWBvft8GGlvdOnHd09yPJOQZAHAPP6kuE+iS5RJJfzOQ4KYzgwlD5gv8YcMauVdAvCFyxkrsZfZ7ZMqGcLDwHUw60N3IG8neH82xrsVT/jC/0b7CFa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0xOmS5HR9Ur/LFM5GEFJ8gU7GqiOkbOEzvX+xDrt0I=;
 b=Sji3JiyWofZXhZfDG4ePwoIWXR8I3tzdELl0/rSH8pPoJrtBeVaTCKY400TWYb8Kr5po/eDqadY+G3W2QY86XifEIXIaaNWfaD3bMi0CHM1wMBLvNi/OJSF/FnV9yUpoxiBNdVJHrPzFuTmkCNMW1iy9J7dlYsd/vh5bx0VrXRSropvYQVkhOAgqjoW2v4R38cJaZj1WvWfM//1xANYM549q/SlEW8eaZFQQ8G/Oix2Xl80qe7C4zYVds2QHd/Po9EjwehQJ1fsC1j7ph/i+hmvSybK/ayh3L0YTcJW8Joo01iMVtw0jlSbPq19HDj7BalblgEEWe5SGD4GANhTquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0xOmS5HR9Ur/LFM5GEFJ8gU7GqiOkbOEzvX+xDrt0I=;
 b=Jsv2pv1Z2LBBSLOIU9r6vWsZGLHX7NKzM3ItCXT3qjncuTuxyDkxQ9kDLtV6f8O2K7jaosRLReKmKiRVXVwTY5u/eEyiC9mWCzxtSRVHjpnq6EBwa5AfOVabST9tbrJ5QZb7qBhXm9pdkkEgSi77IHSPayN/QnkXzoMJkGw5uOGn1lR23S4HWR8xLSBEcsX9OP46chxWfTj9JjcJP0i2hiFEQmZ7EPUmx3NZfiCijvhMWRZFgu06iY8xT45vAVvBRFn7wVw1bPRIidTpFS3fys1KSmC8SmVE4FO/3M3oCQ+3N8u0G+X3AqBuoyW7ZT9hMJX6e6f8wHEoQ7h9wFXnWQ==
Received: from SN6PR05CA0008.namprd05.prod.outlook.com (2603:10b6:805:de::21)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 03:27:05 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::bf) by SN6PR05CA0008.outlook.office365.com
 (2603:10b6:805:de::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.6 via Frontend Transport; Fri,
 29 Aug 2025 03:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 03:27:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 28 Aug
 2025 20:26:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 28 Aug 2025 20:26:55 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 28 Aug 2025 20:26:54 -0700
Date: Thu, 28 Aug 2025 20:26:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aLEd/YAwfhXD2Lro@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
 <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
 <aK8kqQOV28V36wtM@Asurada-Nvidia>
 <ecd95fc6-ce8f-484e-b685-d78a382f1705@intel.com>
 <IA3PR11MB913632FB83D138289BB718C2923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136978139DB0DA6A2A06C82923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136978139DB0DA6A2A06C82923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cc6f6d-e383-4813-9451-08dde6abed67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+6VPeWXsJqoFsqDMG0r7A1fnLoWbB//G5bS0/TRkvcoKexh+2LUuuRwL1WMq?=
 =?us-ascii?Q?0IbO2a9dlCGBEf+WdeHuXr4/qgtgZztE6gFaOTT88iGPqN38db5i8n/OXC94?=
 =?us-ascii?Q?ROXMyHXX+9gMv2x84Ksv267HoAcHCYMaA6rfHxIFGGfpNN35UHqiWz8n5iPc?=
 =?us-ascii?Q?Rgmtcibo3VmWi7VEu+fOu2Sd5tJXF3gZlP9ewmDIyFCJS1PxOjjQjJ6PZWeE?=
 =?us-ascii?Q?JKxycJmTpR28nAdu9uYtj0jiKF51JiBvhm6hKelwJlZwOn8WS3NcaWPWVes1?=
 =?us-ascii?Q?mQ+9DnreVqpRoB7muWZJ+WdScndznxzlKIdEaNUfSW3588fgh66LmlcCfjlC?=
 =?us-ascii?Q?AAJY18yooobO4gntzM29A1/48h98rc2aWJ31s2qzcIN+TsCrKbMShUUCpqDP?=
 =?us-ascii?Q?Kjhk1XCzuhCyIYSo1cBJxytW3Y4Jy6NwMdRQx69zLtjgMgrmdeGDjzE1PhDs?=
 =?us-ascii?Q?k5z4dx+BFo6ls5mhyHjteB5mYTwsRZtm5Z8vr0Xwc6nCmw0fbI+Ikq8KuzQF?=
 =?us-ascii?Q?jLPjGPqdzQ0SMnlPj8YAS7rXgOLHi7kC0dLTl+dsSK4sbp0jXQEgUlecVG9U?=
 =?us-ascii?Q?r4gl2696vxH/v7CEpUKgdk6JVbm0fhS+FhwXnl+g2LlDJ03svznMCxpDGD+O?=
 =?us-ascii?Q?xGE9nCB3Ni1BaWG1E6z6AfUOHUpQULakMoTdUt9sJZkTuyTefwmH7Vog2CL6?=
 =?us-ascii?Q?DzVX3vpsKVvF84MQtg7BsxLe24t46T/zWrDcOzX0R279HTQ9jFEgSc70pZii?=
 =?us-ascii?Q?4WGOa5SXNn4XRmfIwEhfQtDHt1hx67Q5oB6sop7LJI9KPaHy91zHQ557w/Gi?=
 =?us-ascii?Q?8mv1CbhL4MVFUazL2K4CMokVt0FRo674MTg7qkHLzry1mh6cvTrQiTPgp0ek?=
 =?us-ascii?Q?UZHBA7LQZ6WdEsXi80bfMoLm/hhmu3FaOtPxcAGp5bxw3hvgqvymNdvbQSU8?=
 =?us-ascii?Q?Pk2buzQsUFo2Uq+Mvv3env8sYY7btUgZRVZocfRdopT5wj+F8w8o+IXJcMjJ?=
 =?us-ascii?Q?zBcDTS/hV8MhjyYOlFg4cJAjoTiUHKyOeRzMjZzDdZrbW2qdakmnzj6CAejv?=
 =?us-ascii?Q?cfqKrQgrsv3QEPXvLhmWcXK5Nuk21Jsjoj/kPztlY6Wyt8cpNay+iHje6DOG?=
 =?us-ascii?Q?ej4ficqt4O22ajACUaiVUOhFTc2ie1mAaMQqN4q5E5JMZ5feTY3bt0JtIFrn?=
 =?us-ascii?Q?9EJJCqPzsOTxtaX3hDpWTocLIG0esnN7BNnvnm0TLFwWxwSid7OBMntds7sf?=
 =?us-ascii?Q?BYJbmfaJyT6UglpGguc90UufB29ByvwOhbRsrXtj9j21kVYJ/stUuzqKZ2qB?=
 =?us-ascii?Q?0nb2cpfjmPNc0HTxLkqe+FfvQ3WVMBrL/DEggM+Hd02oCy8oWe9hxjtFtJEu?=
 =?us-ascii?Q?XxSOvhIf+fuMd6oANxAC2H0irdqh6ICBBOEn6d1NeaI97h0EwsKkc5w3Ib6T?=
 =?us-ascii?Q?JnVyxOaIYeaAkc1i6VIlfu4dL/6+Mlt8+9My3z9xPqrlp1hxsZ+bv06VqSmz?=
 =?us-ascii?Q?L/4Udqp7eJL+OBecVP3LM4nVo+5eJltChzW1?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 03:27:05.1924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cc6f6d-e383-4813-9451-08dde6abed67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
Received-SPF: permerror client-ip=40.107.101.88;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Fri, Aug 29, 2025 at 01:54:50AM +0000, Duan, Zhenzhong wrote:
> >>On 2025/8/27 23:30, Nicolin Chen wrote:
> >>> On Wed, Aug 27, 2025 at 02:32:42PM +0200, Eric Auger wrote:
> >>>> On 8/27/25 2:30 PM, Yi Liu wrote:
> >>>>> On 2025/8/27 19:22, Eric Auger wrote:
> >>>>>>> TBH. I'm hesitating to name it as get_viommu_cap. The scope is a
> >little
> >>>>>>> larger than what we want so far. So I'm wondering if it can be done
> >>>>>>> in a
> >>>>>>> more straightforward way. e.g. just a bool op named
> >>>>>>> iommu_nested_wanted(). Just an example, maybe better naming. We
> >>can
> >>>>>>> extend the op to be returning a u64 value in the future when we see
> >>>>>>> another request on VFIO from vIOMMU.
> >>>>>> personnally I am fine with the bitmask which looks more future proof.
> >>>>>
> >>>>> not quite sure if there is another info that needs to be checked in
> >>>>> this "VFIO asks vIOMMU" manner. Have you seen one beside this
> >>>>> nested hwpt requirement by vIOMMU?
> >>>>
> >>>> I don't remember any at this point. But I guess with ARM CCA device
> >>>> passthrough we might have other needs
> >>>
> >>> Yea. A Realm vSMMU instance won't allocate IOAS/HWPT. So it will
> >>> ask the core to bypass those allocations, via the same op.
> >>>
> >>> I don't know: does "get_viommu_flags" sound more fitting to have
> >>> a clear meaning of "want"?
> >>>
> >>>    VIOMMU_FLAG_WANT_NESTING_PARENT
> >>>    VIOMMU_FLAG_WANT_NO_IOAS
> >>>
> >>> At least, the 2nd one being a "cap" wouldn't sound nice to me..
> >>
> >>this looks good to me.
> >
> >OK, will do s/get_viommu_cap/get_viommu_flags and
> >s/VIOMMU_CAP_HW_NESTED/ VIOMMU_FLAG_WANT_NESTING_PARENT if
> >no more suggestions.
> 
> I just noticed this change will conflict with your suggestion of using HW_NESTED terminology.
> Let me know if you agree with this change or not?

It wouldn't necessarily conflict. VIOMMU_FLAG_WANT_NESTING_PARENT
is a request, interchangeable with VIOMMU_FLAG_SUPPORT_HW_NESTED,
i.e. a cap.

At the end of the day, they are fundamentally the same thing that
is to tell the core to allocate a nesting parent HWPT. The former
one is just more straightforward, avoiding confusing terms such as
"stage-1" and "nested".

IMHO, you wouldn't even need the comments in the other thread, as
the flag explains clearly what it wants and what the core is doing.

Also, once you use the "want" one, the "HW_NESTED" terminology will
not exist in the code.

Nicolin

