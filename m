Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C039CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 23:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUCMR-0003Vr-A0; Mon, 01 Jun 2026 19:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wUCMN-0003VU-5o; Mon, 01 Jun 2026 19:47:55 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wUCML-0004a5-BW; Mon, 01 Jun 2026 19:47:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G70lbpTUKcdbGFwTz7ASyrChotEXj1m0eOmZXszhHCClPfpzF6qQ0iRC+/3GhigZxCrdKpuXI6h6rsY1WZIBTtkQNk9xyITYj+ivPPybqmpC1yXpoOA6ZSdAATRSKGXW56xJaXt55LyBD1EjFuImqCzSmNRJkVF5F884olE5lmR1JxIVbd+FUOCIOtoymtkN3bjnbUPfWcCEfikIukQ+pHn8EFABR2XhaSP6sP92PWK5rkjd1NhOd4NRMCQroArgvsajPyfAHuXLI/YMkBTC7bnX1K74BSoCB/6LDhXOaeT46mVr0wknwqVLpyJu2fLYT9AqxX9V0KuBoB9cdgSmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F+P9lLKRoQP1AQa87DVT49eVqAP6poYrQULuDsXMvQ=;
 b=aFzvgI4IYjA4BtbGTGMFuQTzPzt3g7v3v2g6/NuN1nAA56HDnemNDC1zfZHfzOA751TvNQOipfauEJCXsVkRE79CSK2xwe456BFenLgqTpkKDvLfMQ+pOhF7MY9c9ccs0hA65UCjU4pUAruCo5PAGY0yn9zwTVNzhi7/3wE/j6sZExqPn+eYvb0CK+4lkbQeU7lPs8MehM7TyVeYIvLABxlzOoSZXaNYUac865IFK6JIEvvQT90CTfwa3T6rZ4k5r20YaBwMuWcYTFHupJ3+V0R3SX9DODAbJDrIVwBwBq23bOBqy4/L0eAbqbhvbJWHkGQAuB2gl3huAz+jfNVJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F+P9lLKRoQP1AQa87DVT49eVqAP6poYrQULuDsXMvQ=;
 b=A3a/8xpSltdnVrGdzdIPgbSf1XwZ1QoDFAVabi2rhl0NTG9Clu1hET64suzRHkQlCyz/ieFOnU4x8aNuTVSA8NnBMtlgrIO8y91fdT7aZw5xUnNR8Dm4vSiR+Kx52ojMqVarTB4DXmFOIwoygsoWyjcPTBE3o/bjkkbOmH9IFQaJqJHg/6pClVwBegD2X60Tgn8iezWaopY/8AtpYUesSKZCN3AJONflOI+Ugzj4KP/I+3mIdgLhq6fSyToe1ZLyR89c6fG9Rd/JtR8SjqscNdAaMQoCEPIaa7F8zZGpr4CJmDKYQZn1KPtXZDCd/eAl5C4jadJeaw06ApFkjxz76g==
Received: from SJ0PR13CA0147.namprd13.prod.outlook.com (2603:10b6:a03:2c6::32)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 23:47:44 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::9f) by SJ0PR13CA0147.outlook.office365.com
 (2603:10b6:a03:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 23:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 23:47:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 16:47:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 16:47:22 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 16:47:17 -0700
Date: Mon, 1 Jun 2026 16:47:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v6 30/31] hw/arm/tegra241-cmdqv: Document the CMDQV
 design and lifecycle
Message-ID: <ah4aAZR29tw5/pV5@Asurada-Nvidia>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-31-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601114221.457995-31-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: ad617092-3d85-492d-1fb2-08dec0382d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|4143699003|18002099003|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: ydHeuu4Q9A4Okku7hXK3+0I1kev3EUjDwme6N+QEs8k/h2d0e23pwxIdo+Ru3wuFQjrV/ZPdgGh4tP5v5MlIFKLLfCASKYq0zNvtMyg7Mz6j6mNZTtr9AK4IlwbbHCZO1uzi8Mzo5/Y+LivB4rCPUKCu6nMH5J3KqhhXPQ9y9HBZxLBbYSOsZia4fdTi9oLnld5D7AHPzGlQRi18m/cQjS4b0GogWN3urYit9FbQirqvptkxxu+0asIddJGxs46KXLDnwhdpLQpSE1jpJAUmBp3whSN5VHpyGk21ud4rK8OxQx7yGeXar0ZtYmG1Go25s0YPj71uePO5fIHNYeJhskb3MayUsQdHySwqymvsaGZ6h1PoEqRA1j2F2t5I5wkxnPoat6KbyWRBiaAgeJjXLzB7UZlkNFHxjQ5CQK5NTV+gH04iCDQL6EUIUTmG0T/fjl64ON4muCwOG4yq6ym5RVYiotBAcaAjOy8X6qNYG5/dcFqEee0W25UR0mC1qDRbnCL4/rIxoSMz7OOt4AsWtrzsUCIB2Li+n9o5y6B1lrRPZ5he5p7QKBJM90ZHuVODH+5ONvhOsKrv8eGevuFoY2mXuTAXk7rndzKccIe2DLfxWnfhTPRkYVRQFYMTiWJc+EgkFf+iWfp4tZGu3KCLZlOUeD5S7n4O45V2floyQVyAs5W1TBHH2hThFfNOCr0EQaHjFHq9CWNzu2DWlKHegCmWP+Hqt+F5ZjQf3/kNNDw=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(4143699003)(18002099003)(11063799006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zvNWWoWs/XG02xDJ0pi5w1X92qfnGTKrQ1BVlUXINIsXOxCIA+2XuJwGAO1laq22EPBmviPXkYoGCLd6lKllQAMQ+hetuFSwp9W5GGeaR0q6YtHjHfpCQQA9h5kxtVG4vs9+VtLq46FhWMFP7HEsnqIJWzge4nSBvNjk4sf0Czs2J1D9JzTd+r+9VC4WXX1giCCsMmOFQTyM/l1CsIATYNtcBat9lcjNCAeW/+tZBj3xzw0trhqg4XCKlnF4CLyzOCIAkhAbxgBL4Jjs9u4jZX+4qQ+0hv54ofVTjzEKEm4oTxcCNnX4zh+wnnOI9pVOxwPHh2EpXctLA2B5gmxYUVvU+d2jbC9vr0R6YZT+oKZ66qmK/gZOUp0i1pdMPSvoOq4AR/+vhOCDXRkd2fT9Hy7+CSfz3M0zJNdhurXXNjEbkTy64CCMJzmOqUFfDGD0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 23:47:43.8739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad617092-3d85-492d-1fb2-08dec0382d0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Mon, Jun 01, 2026 at 12:42:20PM +0100, Shameer Kolothum wrote:
> + * Lifecycle (driven by guest events)
> + * ----------------------------------
> + * 1. First vfio-pci device attach (.set_iommu_device) triggers:
> + *    - tegra241_cmdqv_probe(): IOMMU_GET_HW_INFO confirms host CMDQV support.
> + *    - IOMMU_VIOMMU_ALLOC: the kernel allocates a VINTF for this VM,
> + *      configures the VM's VMID (from its stage-2 HWPT) in VINTF_CONFIG,
> + *      forces HYP_OWN=0, and returns the mmap offset/length for VINTF Page 0.
> + *
> + * 2. Guest writes VINTF_CONFIG.ENABLE = 1:
> + *    QEMU mmap()s the offset from step 1 into its address space and reports
> + *    STATUS.ENABLE_OK = 1. The host VINTF was already enabled by
> + *    IOMMU_VIOMMU_ALLOC; QEMU only acks back.

I wonder this mmap should be done after the CMDQV_CONFIG.CMDQV_EN=1
rather than VINTF_CONFIG.ENABLE=1.

Spec says that:
 "Program the CMDQV_CMDQ_ALLOC_MAP_X register(s) to map the Virtual
  CMDQ(s) to the logical CMDQs on Virtual Interface following the
  CMDQ allocation rules. This again is an optional step and the CMDQ
  allocation can be done after the Virtual Interface is initialized."

This means the LVCMDQ mapping can happen before VINTF_CONFIG.ENABLE=1.

And the mmap info is returned with IOMMU_VIOMMU_ALLOC. So, this is
doable?

FWIW, kernel finalizes a LVCMDQ mapping when handling HW_QUEUE_ALLOC.

> + * 3. Guest completes vCMDQ setup (BASE, CMDQ_ALLOC_MAP.ALLOC, CMDQV_EN,
> + *    VINTF.ENABLE, in any order; each precondition write retries the
> + *    allocation):
> + *    IOMMU_HW_QUEUE_ALLOC binds the guest BASE GPA (translated through
> + *    stage-2 and pinned by the kernel) to a host vCMDQ in this VM's VINTF.
> + *
> + * 4. After the first successful HW_QUEUE_ALLOC, the mmap'd VINTF Page 0 is
> + *    installed into guest MMIO as a RAM-device subregion. Guest VINTF Page 0
> + *    accesses (CMDQ_EN, PROD/CONS_INDX, STATUS, GERROR/GERRORN) thereafter
> + *    go straight to host hardware, bypassing QEMU.
> + *
> + * 5. Guest SMMU driver programs a Stream Table Entry for a passthrough
> + *    device: IOMMU_VDEVICE_ALLOC programs SID_MATCH/SID_REPLACE in this

Ideally, the VDEVICE_ALLOC should happen right after the device gets
plugged *and* its vSID is available; similarly the vdevice should be
only freed when the device gets unplugged. So, its lifecycle should
stay with the plugged state.

We do VDEVICE_ALLOC when guest programming STE is because that's the
only place we found in the existing functions. We could (or arguably
maybe we should) find a better place to allocate VDEVICE. E.g., vfio
code can call qemu_add_vm_change_state_handler_prio() to register a
callback function, where vSID (vBDF) should be available once the VM
start to be "running".

I think your narrative fits the current design. But we might need to
be more accurate here, since this is about "lifecycle".

> + *    VM's VINTF so the device's guest vSID translates to its host pSID.

Nit: so that the HW translates the guest vSID into host pSID.

> + * Limits exposed to the guest
> + * ---------------------------
> + * One VINTF per emulated SMMUv3 and two vCMDQs per VINTF. Maximum vCMDQ
> + * size is 8MiB. The queue must be physically contiguous (the HW reads it
> + * via host PA), so QEMU caps it to the host memory-backend page size. Use
> + * hugepage backing large enough to keep CMDQS at the HW maximum.

The "physically contiguous" limit is handled by QEMU, not exposed to
the guest at all; guest is unaware of this.

Nicolin

