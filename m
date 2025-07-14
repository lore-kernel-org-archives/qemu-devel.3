Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D42C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 19:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubP1S-0008HY-M6; Mon, 14 Jul 2025 15:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubNm4-0003HJ-S7; Mon, 14 Jul 2025 14:19:43 -0400
Received: from mail-co1nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2416::623]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubNm2-00039m-2R; Mon, 14 Jul 2025 14:19:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0U7GW5S49fNF2qtoK03rtCxQkx57XYjJRgEAyCycsB8SVwVnk1l2gWKeI4ldQe72dlRsGckDi4zK1BHlYfUAqYnZbUHkv+5iXyMklQI6T8TbvxfcKf19UXLA1dKxz239QJtS9y9yp2Qgtk4B5On3cIiKi8MRJeiv+xGAkZjWh8M97Eq6L7kPRsjAQtNi0IV4lkxRycdhE93pOM/JvRDThZ7BDu/SsCRMMU/jLX7XhlnZPjJv+Ful5eiNWBcztb+F49+hoWLYz1OYtMtOmUZz03qSjD03SgUKrgu24YRsmPrALbU4kDuJQHT1RVereelzUELj4/dtf5iGZ4K/WjSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUtZHClWZBqsJYuFhrMqemmWz8opNuhqknzHjzfeMyc=;
 b=V01Uk95ffzBRp83S9IvNInB/fKooffI4jcx0Nkyy16PZtmAaPAd3B5rahxG0Oqh2l3l4XlxBk5tyoPJWj2/GnoYxDO49WwFhJFtBtlAhUgv6ignXr8dZsuLHAr/MZlDtfYzh1vzjlASJ3SZJ7IZ9VE1KJeF87S3TuBzKsleftiohht544uib9nxU70U5h2pCkmO/b1pq49LYRWsMs/4SBoQDuZagbWUnp9TPVQE4y1U8+fF18cbd1Lu0/ae06wRqC9555aQFesNPIw5tPK8BOYQclovbSm34VbsZPCpvouc/Y+a0zUyKAniF6GIge3QfRi8T0oYlN6NUbiaLM/0BBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUtZHClWZBqsJYuFhrMqemmWz8opNuhqknzHjzfeMyc=;
 b=FsHldOWQ5xyPEuy3VoO8vfLXS8lSZ7YN9udgB57LZazXIEoXN4pTLfrTI9RlhoUV6NZH41ALpyQLgcIAhCE0mMF5rCHvcWt3G3r3vQhYR1rHzYoSkTBtRhxYoD3nVzz3XDcyJ1LZEUpbAYpX01re3xColn3pqd+h4+pR2oCbxTr24pGhGMuM3PipGZlEnGpLYL14TiRENGuA+ejEkhIU8Cd33h2qwxGdSgmSEpWRW8LlWdQDaqUSGJSKWSQWrHWNpJ0UXOImeOgW3FwYXN1Op/n/LZcHi+WZ4+bWcmeqCUui11JK6Et0k644nlO8wSIJGbkl1BqmmhfG/8cpwqKKDQ==
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Mon, 14 Jul
 2025 18:19:19 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::8b) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 18:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 18:19:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 11:19:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 11:19:00 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 11:18:59 -0700
Date: Mon, 14 Jul 2025 11:18:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aHVKEhvaWK7E55Gw@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ecb917-dc48-49d9-7d20-08ddc302f300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NirUbhn29Owg6A3Ci7Kt/FCxskpqyyPlU6pxnh+u5ItGGeR9d6I/Hn2p6Yp7?=
 =?us-ascii?Q?2TMsbd3Bg3dUOWJEIR4tbqOCeROOyGEcL4kpaNMeIr6jYRf/uiqNMh03BerG?=
 =?us-ascii?Q?BMLIMdSzcTbkQrS/VOZOQoigM7MF6Bcq7a6Xu2wYu1wSiuPIozcTDLrBW0B1?=
 =?us-ascii?Q?YQNYNECM4Ch5PWW/44tyCytPeKZMuXyiaKxxEP2e5qdtT2HCFDZYNc9rgcHe?=
 =?us-ascii?Q?mnc4RNUT1AInxXx3lmO2TJ+FMKVM7fdVjtD7tQWDUvef6ArHCxxey3L8KRgI?=
 =?us-ascii?Q?UctNOAAI8T+8sesdFLiWgmOHc5sV5Wp3uV2x+Q2lxzcG9812/ZKindDVkLLU?=
 =?us-ascii?Q?JGMh104tGDQ6V7+aMfV8JzGjD8lwjTHolyaccYWXWv5GZeWmhvlkFiM+8lqj?=
 =?us-ascii?Q?QzvKufmWcYsOg0MNkj/aZ7VNtMoOZuufvzlEePr0W6/BXdRP0pwgHeHqQHXQ?=
 =?us-ascii?Q?8BIuJI5Xn1hcmRlWOkDaMiZqEUZbQp8kgKnCKiIg3x5Vxbo3ed4hL90DN5oh?=
 =?us-ascii?Q?vSI+5tV5VYKMnwLiE32mBynjrfjrCzijpgfCzrNksaHUg4CAmp5hORUqglHE?=
 =?us-ascii?Q?qFkofDZ7GdKTKTIUGA6oo4Q4+KfiisEEi60nkRf5pv4TNf6knfj9Gshlc9hR?=
 =?us-ascii?Q?q+A1fYRteHPNJnf02EG+qib7LTDbyGKIAI/w6VyEaNO7VmeOdlTu9SEsqLyU?=
 =?us-ascii?Q?46IUSN/dQ6LDOeHyeoM18T5NkRMY4qj7BakHKB1ipP2aq3Gh0FPCj/w3x68C?=
 =?us-ascii?Q?j587crvcvBOhU/t+QbJAeDGubxIpEKQ6+1k10KAMCIx+a1kQfbhutp4Njtrq?=
 =?us-ascii?Q?CKnq7M1JYPQpQEWuaM6yBhycf64G+X/THsUH2GGIi2zev4V7ks0uZ5ohEPNB?=
 =?us-ascii?Q?l2HT8E9x0Y5oPlUOzNlzKGAi4ummAdAswMCe8BezeLG6zkZbv/aIsg7OpLFe?=
 =?us-ascii?Q?pcpG1IyvlL4iwoePZVGZo2w6SW8XUOxrWKz66LxTFFTTL3sHsd+w2bPCT5or?=
 =?us-ascii?Q?gIx3pNwgfnWR66gcX/XLN1g3LpFNqgHlQZt9n8EXK1CO74huIo7eP4iYWiqQ?=
 =?us-ascii?Q?39K9xZ5UXTsvZzErx733wSGUCQ9U61qhFthbpOZnQvGjFKHfkrl/MkRHNlEL?=
 =?us-ascii?Q?zkLEdMIGCEFRFcsf/kwYJ1IyQH2ceZSd4J890dzJB3L14LXuK/HZn1Lw6MCl?=
 =?us-ascii?Q?y3s3RF0Q4K4CHDz9PwVZGMVUWPUocC+hPlA05X8jjNbfcgcUhOx22//ax2Sc?=
 =?us-ascii?Q?jterfww0Km9tP7N2rG6JTfLAhESZRppBtMddxmgiM0nZeKNs1/gQOyZzLHy2?=
 =?us-ascii?Q?lK6MKaynOs77q29+XZXa0DFzyoRRQrHyN6T2+QvmsYOcJUHtNOOG0EEdLwIK?=
 =?us-ascii?Q?esoSZH3GzgmyY1CxeKngd9P6CbYd8Dt8juOSCuVZb6V+quLvjpFpZgloH19V?=
 =?us-ascii?Q?Ikd2HZkQJdADA7ZAMLDmuKi4Y0MfwOYu8UK9Vv4NEcLccxiFngy/w9pfuZxJ?=
 =?us-ascii?Q?Y+nBxxV/7aKNTPD4xrVyhkg3F5oktKfFh3cH?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 18:19:18.9236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ecb917-dc48-49d9-7d20-08ddc302f300
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
Received-SPF: permerror client-ip=2a01:111:f403:2416::623;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Mon, Jul 14, 2025 at 04:59:32PM +0100, Shameer Kolothum wrote:
> Accelerated SMMUv3 is only useful when the device can take advantage of
> the host's SMMUv3 in nested mode. To keep things simple and correct, we
> only allow this feature for vfio-pci endpoint devices that use the iommufd
> backend. We also allow non-endpoint emulated devices like PCI bridges and
> root ports, so that users can plug in these vfio-pci devices.
> 
> Another reason for this limit is to avoid problems with IOTLB
> invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an associated
> SID, making it difficult to trace the originating device. If we allowed
> emulated endpoint devices, QEMU would have to invalidate both its own
> software IOTLB and the host's hardware IOTLB, which could slow things
> down.

Change looks good to me,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Some nits:

> Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
> translation (S1+S2), their get_address_space() callback must return the
> system address space to enable correct S2 mappings of guest RAM.
>
> So in short:
>  - vfio-pci devices return the system address space
>  - bridges and root ports return the IOMMU address space

I think we can spare a few more words here and in the code too:
(a) A vfio-pci device in an accelerated mode doesn't need any of
    the features from the iommu address space, since translation
    and IOTLB maintenance will be handled by the real hardware.
(b) In the HW accelerated mode, the VFIO core will allocate the
    S2 nesting parent HWPT on top of a core-managed IOAS for S2
    mappings. So, returning the system address space allows to
    take advantage of that.
(c) The reason why bridges and root ports can't use the system
    address space.

Feel free to organize these in your preferred words.

> Note: On ARM, MSI doorbell addresses are also translated via SMMUv3.
> Hence, if a vfio-pci device is behind the SMMuv3 with translation enabled,

s/SMMuv3/SMMUv3
  
> +static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
> +{
> +
> +    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
> +        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||

"TYPE_PXB_PCIE_DEV" since we moved it to the header in this patch.

