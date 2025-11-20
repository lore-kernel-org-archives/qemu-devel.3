Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BDCCFA447
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMBrQ-0005S8-I2; Thu, 20 Nov 2025 16:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBrM-0005Ru-17; Thu, 20 Nov 2025 16:06:32 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBrF-0004Ia-JS; Thu, 20 Nov 2025 16:06:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrOma/bv3Dp8b3B+nKx1uP0j+nje5OmSsdR6bV9FGsxdtWpGDwN+lUUyz6AM/ubZnJJNGRo85nXp/5mXTK/z1sYSYbjmPcH2b3da3/K670kkX/RnKgAtGMpkV2AOJiSEX57M8UKU1aRyTOFkMJZOtCIY17PU19Nndc+YLJ8W6cpEUmAhlpN987dEnUWxzSHA4beeCeNQjEtgXphFNfxI9al8LoWACrJQin51VepvQo+e47sa5oJ7vMIafx4o/mtzeVA+Sk8oiDzbOBzdk/moSMDxZhYURHGMZh2PpwRzMbIlkUeh+OliWLfjqCT+61fPCSRxIUv3rxqd9ObFSo+DsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY5sLkrIhVli9sNuvduA6ytJ+MMrmIHZcCgPIuAu9ss=;
 b=Dn0SPn9DNLWBeWRsdf1Vq8aM4gHtLdUR6zUTIraYblI7Sl68VXIEvHYq88+wNpDsfFLYt8UH1wn98/mi7AfsNJ3uPO0ZUkNQA0y5w6KzhLdbgYoUrdWaK49sr63VoG/q1CRHIFtAphSCYdDzsTvUNtZrrfMsartzx/Flh7mLc/TAxE+ZKxOe8E9oE4zqCWzNoMt78XL6+k7dB+fW9Ub3L8ZsoA7YobJ7WwWNSV9XiSJY1kXADTCjeziVd+51h4AMck98xHLBvXd69sxES8VQ+nFd+ZvmYxMMV1GLAi1u4ZTRlNX084BaiqsNaNUMYEMXsuLZ4hRm4zqQOzpxgCeUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY5sLkrIhVli9sNuvduA6ytJ+MMrmIHZcCgPIuAu9ss=;
 b=mb+Nc01EYuKAIKACWbWTSZeDBR9unb0QBsBK7s0J0PCHuebjY7hL3Pqq7aLnPViLsr8LymYauqy3BAeynjFuoYe+AwpFWqGwu2a0a41oInqQOfwJz+3hf6tOektk9z03ExyJKNungifOtPODS/Yd04hGytoSlFqzGu5H7FMRS3b5vXmla+zetIB80XEJ5XOOdABdJD4tyqmcG3Cara4K3AwJwrjLyTofAomXnh2kU1ZZ2673Ohg1qReRhsEpGLqxlwVaglwO8lhMNNvfIM6B152vygcS8eoUU7xTemiuObgS/hL0W7dX6xHUjbFX9L5fg55+H9DMlQS34jbfvX7bkQ==
Received: from CH0PR04CA0048.namprd04.prod.outlook.com (2603:10b6:610:77::23)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 21:06:16 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::f7) by CH0PR04CA0048.outlook.office365.com
 (2603:10b6:610:77::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 21:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:06:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:05:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 20 Nov 2025 13:05:57 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:05:56 -0800
Date: Thu, 20 Nov 2025 13:05:54 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 16/33] hw/pci/pci: Introduce a callback to retrieve
 the MSI doorbell GPA directly
Message-ID: <aR+CsjbmTbc0CqI0@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-17-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-17-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f22bc2-0096-42e3-5068-08de2878a469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O7bo4pI5XgYMExRkoDXt8+8+xMwv2LMMhBAsxciGHA6PPza6a26Rmf7o60em?=
 =?us-ascii?Q?MpUZCTI0jAnzJ7ugP+8Ml/YW88DNN2aRci1Aw0DeDqvO79hma6ZPstymRPs5?=
 =?us-ascii?Q?D2/NXw7ROkRjmnXNKp7tfwoP9onocXBEPbsyYqHI7DsCj+masve4HxrZhLvU?=
 =?us-ascii?Q?LFxWRX76n8fmmuM9Nnyjfd9FrMgPE7Kqj7M7c44N2uYa/nbwx/8EwmahNTyn?=
 =?us-ascii?Q?rpdULEKUFj+S2jPEKxGewAOUvnZaAvTQNh0kvmYVGa10+cTzqFf7TbyoIltj?=
 =?us-ascii?Q?ThH+IqGmgX+bGepzU0NcssLj2yXzJNsL7Umz+wFgcEeYfsUk1nK58ZkzYzhc?=
 =?us-ascii?Q?dPyLpb7zWHkitc13d6Pz0beMozDIMzJnj1nh0QkMHEvVLQc0j8x6ytK0kmBu?=
 =?us-ascii?Q?W18NFHKmCXbpfOnJ9kwOBNNElRyBhFa6dXQBoj9NFavNv/BRxwIEpJ5D0Y+N?=
 =?us-ascii?Q?kLSyrRNmoaAfEP/16koD5zsXmewOEx1pIbIL4VEWEUQ5BAEOOmmUlhrG7cwL?=
 =?us-ascii?Q?a+8dCpcEnMNJTGQ2Gle8UwqMt7Gx3ZMNKvEoDjB1YSPnFgV6iRX1pSFmXwYT?=
 =?us-ascii?Q?8Dnq2Gz0mF66qh3wjK8QW36phRVtWEEy21IEIG2jRroZI/7jedCZLmOxkFxx?=
 =?us-ascii?Q?gYaMJYWorTDtrfhX7Uvvsfr1QKE71g5oTwrdodaEvfM+dYaIxSpZZgSE9lQg?=
 =?us-ascii?Q?FoOoMawnpCDXSunH7ydSHg/1L5N2w+fQEbuIvZoLRAa5itixkecPT0J58Tbg?=
 =?us-ascii?Q?mwedfpemd3iqU7v6Iq1+BK/jFdHdI0wAL4hvxC06PrsYIUhAaQJC9HOkGNRZ?=
 =?us-ascii?Q?DVH4bJrDsAnHVywLpS4K1/IXv+l0Ked8/KUP1+Cn0wYaPy0Kabu7j+cwCpwd?=
 =?us-ascii?Q?9YmMp9AiGnmrjciNDptdH0LyCpfz3roeibWStJBopZNyZ4w9gDbKyeXTudks?=
 =?us-ascii?Q?MwsVbJimjmg3B78TEIWj09oUtHufiJTeLFQcIZZahRLaS7ReiwsHHWTBPMJg?=
 =?us-ascii?Q?5KeKCUNYMtuhLnIoL2HYFIX2U9Q0y8MH7SKU3QrzPXEVIGyUxAO8kw36NCxY?=
 =?us-ascii?Q?mgyGZ94krTFGcMJ/vc3vemp72l3hvZEIGoiYwCmb1/LWOAsISTXdyI+VqdeX?=
 =?us-ascii?Q?OJ3jcoy445zcXH2e6R+DsjQ9GD1cYFryjMCbS5QimWZe6UBpdYphsWABlbsT?=
 =?us-ascii?Q?PcHxRtVg00vCFH4cIl1RLQR8HbemrMshmAOwNZrhc24AVHAFR6ouFLflvHrK?=
 =?us-ascii?Q?vNuoQXBEUJHxlEkMzyVrnZK7Y6MnyaZ5EWqGJF7CReICysM478AKQiqkaaCf?=
 =?us-ascii?Q?aErEg+O8c0wVSS2kCXvrm2ERFfjQd02IahDqyhxnx4DHy25Un88h1meVxScD?=
 =?us-ascii?Q?z9WGpBY4JA/B6ZR4Xc0JxpULXSYSKIPQKIktQFaZduz4EqeLNS5Tv6PNFb8q?=
 =?us-ascii?Q?Jf/WBmOYDrZmILC0f/c5KDf16xjdm/OYsSUuxt+YNkc3aOr7CV4gJfGzO/mR?=
 =?us-ascii?Q?tpKQ9Lgq23Vuf9LydyWHt/hFJJMCSbNFA7kFQBHADltOn4kq47UuTECjn3vY?=
 =?us-ascii?Q?dRAtY/NobywvT/AkOWo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:06:15.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f22bc2-0096-42e3-5068-08de2878a469
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 20, 2025 at 01:21:56PM +0000, Shameer Kolothum wrote:
> For certain vIOMMU implementations, such as SMMUv3 in accelerated mode,
> the translation tables are programmed directly into the physical SMMUv3
> in a nested configuration. While QEMU knows where the guest tables live,
> safely walking them in software would require trapping and ordering all
> guest invalidations on every command queue. Without this, QEMU could race
> with guest updates and walk stale or freed page tables.
> 
> This constraint is fundamental to the design of HW-accelerated vSMMU when
> used with downstream vfio-pci endpoint devices, where QEMU must never walk
> guest translation tables and must rely on the physical SMMU for
> translation. Future accelerated vSMMU features, such as virtual CMDQ, will
> also prevent trapping invalidations, reinforcing this restriction.
> 
> For vfio-pci endpoints behind such a vSMMU, the only translation QEMU
> needs is for the MSI doorbell used when setting up KVM MSI route tables.
> Instead of attempting a software walk, introduce an optional vIOMMU
> callback that returns the MSI doorbell GPA directly.
> 
> kvm_arch_fixup_msi_route() uses this callback when available and ignores
> the guest provided IOVA in that case.
> 
> If the vIOMMU does not implement the callback, we fall back to the
> existing IOMMU based address space translation path.
> 
> This ensures correct MSI routing for accelerated SMMUv3 + VFIO passthrough
> while avoiding unsafe software walks of guest translation tables.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

