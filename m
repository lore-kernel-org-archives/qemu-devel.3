Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB73FCA170
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzf4O-0000p9-Gl; Mon, 09 Mar 2026 14:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzf3w-0000Er-Fz; Mon, 09 Mar 2026 14:10:45 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzf3u-0007de-GR; Mon, 09 Mar 2026 14:10:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIdRC8NrtALOalz3vL9BDq7G1xOnjoLNHLQdOWCkqMk3LhoZ9pJdQC3oCalllZz0mEUhC6Kf/+5xT2BbEK7yInIghCAOASxtXX2PAFGAkfMOcvP55tvVnBEjVlNcv+Llokoo1xhSxmbmyFKRSHUu6Rnv6NKklt76l6wPnS9BdDMRoyU/+i6Neg7nKFtYpA0gUUArHNk4NeGoZRxgXG2ZfUvqNQvuBrKMkbot7UHyEZLLUL+zYLbr8NjYXnCTccHkS7VFeT+yrRAojsgCFhPUjZBClBY8abY6PWQ1kxysj3cMRYnIOdGMssjfFzkqVe+xJhQXXwzwIIB+EO4ZewHEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbU7/Flk1+5P564OgMdcWbY/EMD8FxPv+RQ6GKn9f6s=;
 b=y2zMJdyamyuI8uX2hwoD7UrmFfq5j7ODqSNKm2rj26jdz1v5vaQzpCLSWdT7RnRLMyug/k7lTRyUj+WnhnswHYJn8lOq0OhR6FGmaIhKnDfxFexp0rxzqzkTLq8OQDJIxRWP3zehRXXIiABeMQFoHUzK7xZqSZxIv187Tk+bLca6rFiUDsySwvcxZL7FIlD67lMWew7E6+wNVCscryu0/NXa9+PynYrpOSmFWCnpwiZMat0UPgwGPuTDRJePCxMS2wzdYIGrU/dAXyUSBbS+xDJciUDPl3FXWuaPoFkSMeKVWewL5nts57Om/VuIpTJGQ8w3uYNepvGmNEqrpk0dJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbU7/Flk1+5P564OgMdcWbY/EMD8FxPv+RQ6GKn9f6s=;
 b=nCY3sGzAN4AMWGbvM6Ol5ZR/pvwtlrC6emwiNLhk3b9onp6Ves5XP/O7C9MOWZ5FyieQel19kj/mxJdbHjAg0p2tbydY/Cg0P80p5HbT5wID+Hnp0KH9tI24r6bW3bcFzdySsokP+fWNmcczNJ5MHSpujMWtjOT6ysBTb/0CqyOVyz6IwTVPXqQMl7Jz5lrcAOxx251ekhGWQUob3WKT/KoNbf8yEJYn/GsgySuqfKkzS4VV/3KB7XX5KC5aTjsPJARo38h9/yDF91AVB0HiKmUoCjJV+rbg3BxDKrEsL6nOSd5cqGnNbV2LE2+v750B8i2C7OSHWCblc6xAUsNJmQ==
Received: from MN2PR12CA0035.namprd12.prod.outlook.com (2603:10b6:208:a8::48)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 18:10:18 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::8d) by MN2PR12CA0035.outlook.office365.com
 (2603:10b6:208:a8::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 18:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 18:10:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 11:10:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 11:10:01 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 11:10:00 -0700
Date: Mon, 9 Mar 2026 11:09:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Message-ID: <aa8M96GLFbPiMNUo@Asurada-Nvidia>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-14-skolothumtho@nvidia.com>
 <ed5ca420-94e5-4e9e-a2c3-f59eb6ea8ada@redhat.com>
 <CH3PR12MB7548F5610D7F339C5DAD0E41AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548F5610D7F339C5DAD0E41AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: aabf5888-90c6-4c52-f20a-08de7e071f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: N3Q4tzOI747fqDCzL5oKGzeQKcTEBGv7oMLknwzohYUfabWV3fx+G4QrGFf9SFb3zQgYmiJ06srkJwBB0jcbk+OocY+A2tRSbrqUx4tZQHtTgY5lDl9oMOGybKM/nVUWLEyYwQ2MI4jRuq4YxVo99T1cA1jMqe5zrhxwY7fML3cxd6jfrnlamSWHs5pqRocWdI01yPr83MwMf3infufQiJ+qSFxKfWUWmqfsZbhBbfSbJ+Q3gF6HLVi/B5E7gVrXVMw4HS9de67AE8VfHZyM1kxQv/ZvvgF/uEIJ7QsGA2Av2e2EfXKQPcioMbXJWbEPiEEmle9ddRhBDeeYSCNs/cNiA/HJ3N0/OiisbO68wg5Tu9NFl7HTrHxZ3cjYidVjLh4Ob5JxdHzqC8awyA49bdLEkyHm1fmzIufOOKHkSb/kcDky9XS9BySwcRGEL5gjo7ODZOrLgdwXXU8HO3e7Eto1qCuL3wZ+CsGDIBafsbJABXiLBTLgvj8zHnlhYObhmIscSsYsdXDSor+ZCjXUn/85kh0DmTMriXOJ5ZZphlteILha4aUmESZ5CSSykZ9RlV2aLx9hZKpFLbPtIOrXVjOaVzg0n6lxYXdKq/DqXgn3OQ7V3bLT63QGwTARoN54NxlcdJGLmToLZlurx8muxQ/rJg0ixxuaq3/UExbY2h/G+vRF08baTEGw1rh7dswonKMGVkjoGyMwFRQyP6v9y9LIF7JTxgl31TFA2dUl4TaJw5w2RooUTyyY8ZCT3myGxKIfiB1Y/ZHB2yiX+nTN5Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNqjoD3i9eY/1ZfwGrVUjkImSlxETw8VNJpf/DJ1WN3It8tfxM0eFlZqcu6g2A6r+tWH7vOjFX5y/TTR85/Kx0E0SCXeOChL235EUv9nf7HigWoR3WdO8FHkrANv/ZgfCny0O2WpmB6JJPNuX9ULL/HfPPA/RB2c18zQ87Y34b89anGdMpDv/2OekW+4CMBP75C1l1MGDEGghwnNTa+kgMxA71OnZ8MDzIZpRWEolD5h7GSYLPn49C8xvc8PtyAMYtM+FKru2wKLK4xayliw3WO1VlwEZKrtDCXyvne7AjwGCsD6a0PMZWmMLRwI2+FzefPzUoBeHbvutmlWdonXd3hwLJVdM1bvQl60Xux93Ip+VVufJJvJqvTjPegOcW78sN8LUYlbE1mehUZgLd7Uk0puE0zTKTZK5OcPLdh5tQLGpqnAEujoh2dm+ZubRRj1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 18:10:18.2580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aabf5888-90c6-4c52-f20a-08de7e071f12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 04:31:22AM -0700, Shameer Kolothum Thodi wrote:
> > > -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> > > -    return false;
> > > +    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
> > > +
> > > +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> > > +
> > > + IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> > if the only think that differs compared to no cmdq is the type, ie.
> > 
> > IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV vs
> > IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV
> > 
> > + passing true args, maybe you can just record the type of the cmdqv
> > + that is being used in the smmu_accel device. Then you can get rid of
> > + alloc and free
> 
> It is not just the type. Based on the type we also need to pass,
> 
>  * @data_len: Length of the type specific data
>  * @__reserved: Must be 0
>  * @data_uptr: User pointer to a driver-specific virtual IOMMU data
>  *
> 
> And the above is implementation specific.
> 
> If our idea of the "ops" is to allow easier support for different 
> implementations in future, it probably makes sense to keep this.

Any future "cmdqv" will likely have a different viommu type. So,
essentially this is just a viommu type override, as Eric pointed
out above.

What we actually need to expose per viommu is type/data_len. The
data_uptr can be a union viommu_data in the accel structure?

Nicolin 

