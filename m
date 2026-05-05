Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C058CD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 00:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK3qk-0005LZ-PX; Mon, 04 May 2026 20:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK3qb-0005L2-9X; Mon, 04 May 2026 20:41:16 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK3qZ-0001ng-65; Mon, 04 May 2026 20:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXYexkprIO6Flk4HfQKwbV6zCCBMpEGGDza+boJ3U7LUNlDw1VNyW3Lf5sqH0pmcRyHsuskF9ptpF5MM2PpAnIkejzDiSTWfoRobMDKEd1IPmoFnWS+qWcChr9rrBxel2oLlOHajRP2Wwo84ScxxH6NPcfT6MCTen8uktzSKcW7vClfZj0XPKK1zQg1sgIGWklkZ/0XLRPrKUTbEJQt4UsgQP1U3uRjQSG02rE7mRB4qo3znLxdYFferOWeZ97Qj58YVfKISyASGmtXOwJDuXZWjWY1w8KyXiwyXkUqvLV72ncL5Z4Iw9ASvIdL2rfS8VhK50yG3FAdyKmXeQw/zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udmp+/gS1iaOrW3dbJ+j9DCall71fEvwZvxJnZaoeq8=;
 b=MJs0vNgsyJidIdpmbk1Ax2zkSVIVR3qG0PCWRs//RnjUrHuFm133lZLxHztsKTDq//03AvutUWSI/CENkSEKLklc4bMszylEb/QWwW//oF59orpxPMHT3pxNO5pITDPPYGHavpEXf2OCxoqbNs27FbM1dTmQxznKJuI6szdyPH2pHQz0B1tHm2hhMDT/GP753pZ0aYQrGefyJp0vPeD/ssMXkTUNAHcGU+qNfq3tMGYQV0daAD4ekkn+Zy55Ntw9D/48DMgzaLyBQ9ZAlCVqDLlKGnbAUiGTrLztwx/NoyZGLgWAqtjZ7c/HuYUjg0QivcPXBRU6tYmcGbhSInb10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udmp+/gS1iaOrW3dbJ+j9DCall71fEvwZvxJnZaoeq8=;
 b=jydFsgDq1MLwkLkx+U8FrKKELwP9sQ9PYBSx5/aOrni47g73MStga7vzdvxKtI94r0CnUrjbFnlUzJBMPjASq+AjbsAPVhHRb97hoQo2yOpyWoB9R3MEM9KOuHPkg4NXEIDUl/LirbkiatuEP6cf2VFSq1GIRXHUxdUKDllsij9k2bV1VWFbPz5il0KLX3XJ4AhBansqKiCqAKztuMXG6mNf0Uinfewpd2eytvWeDfUZ/DoTfH+YiSwmbgaXy+4dq8pe4yZOaBk9fls2v08mjSo07BiY0u2Gi+qoE9CXLbIDZhJw7Al3HsxZtvA3oH7sw+uZv8X3bKFDwydlk++QiA==
Received: from PH7P220CA0069.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::18)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 00:40:59 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::3d) by PH7P220CA0069.outlook.office365.com
 (2603:10b6:510:32c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 00:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 00:40:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 17:40:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 17:40:36 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 17:40:33 -0700
Date: Mon, 4 May 2026 17:40:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Message-ID: <afk8f6BNAN2J/9f2@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-20-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-20-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: fd127b63-6f4b-4178-682d-08deaa3ef992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: A6By++LMr2WOihWQr0DDCB3MsY+qfndwEPMkloYy5Lk2ZEkgVQYzzvOCJtsOc/Ou7fJeofm5TQRL3oeLgvcy00Fs8ES/TvHqdt/ejywcCqacs6da/5ppDlgfWpghDgdGCji6cBXS/gAcKRTrM+q4aDd8wY7OTUJq9qvDUqjDfF2vA95eMm1tdWj55/nBji+VXnMr1YCoJN4twzN+zqsQoX9iKKUz3xix5H+gwX+UsNRDAcchgbgFUE1l6jPv/c4qGCBOsQgnAavjE8A5ARmCoKE4RkONOASlyQHuxF8OepUkmNFaw5jsSTOIDAp4kGxPPa6AWzj2s1E0KSKuHE401KBWDDBlN+/ABk0dYZgAGATguaIrTQL2GT5qaM81i5+mARiO1R97NApbPNyRAlGkKUrCyCGw1hPbqcfzQhCCaa06qLBlY9K5KfHK+/08CPqNqmvggjlIhr1+FAiB3BPtcCam9w3Q6Ht9S4QWlXoPpu8/5rQvuVMvddLbpRCYlDJoX760KgahvzlYHdxFrZHqE+9TvPyn1RzH2pp8PtrFTtOLHDzhl5eGaCr2ME5ORocLMzWk9sMAJteayLGJrbO2v+KrDlufnjtjfRRvEwpcuMEdBwWBtuXrekwJYMBb/ZeBwQQhk1vBT33BLbvMYgI+PC766USe38tg0OfMT0OpOY7lw3fjSxlowmRnwOWDG58HZ5Pp+MXq0yvdPTPcQUihE2zIn5xTvXfogj2PLEi+0X0=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PXiU8/fwHs9pHBh6RToFGX8TpaFeCZIEYQeDGA0cII6CDyfsIsEEBsrUy8J5rcM4b2N6En7e3LNHvWcHZN7Vu12sOFR4zA4g5np7iaURIpnCmbrm5FVvPBKJ/02eKAjlRlAEJnfySWYQBIw6y6Q9OkF8oMjhOi76yaKcoviXxweOiS6UGlyA5B/8Nxv6zVbLqMxsjw3Cw9R4stPxcaj3L1PrFc7hittfi2CPy2pL8nyIlVvgaGdJXE4XsDSYtOaAvG9fYmTmG1ue2iHoC6loa2dU7aZ6X7IrH7opr4MM+raw1dBodJTrtLH3VKZ0OH6KbtbBCQeDJO1Q/905iqqSuzs2qEEz7lz5n/PP9U+U+FosfVHm+0I0KXVlgQlp6gPFkOxGSCwMwM76XgOUNCp1Et8vw6igNYWL47uTD4vTdDbpoO3i0YToLgxliUISae4w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 00:40:58.3892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd127b63-6f4b-4178-682d-08deaa3ef992
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Wed, Apr 15, 2026 at 11:55:40AM +0100, Shameer Kolothum wrote:
> +static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> +                                       Error **errp)
> +{
> +    SMMUv3AccelState *accel = cmdqv->s_accel;
> +    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
> +                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
> +    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
> +    uint64_t log2 = cmdqv->vcmdq_base[index] & R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
> +    uint64_t size = 1ULL << (log2 + 4);
> +    IOMMUFDViommu *viommu = accel->viommu;
> +    IOMMUFDHWqueue *hw_queue;
> +    uint32_t hw_queue_id;
> +
> +    /* Ignore any invalid address. This may come as part of reset etc. */
> +    if (!address_space_is_ram(&address_space_memory, addr) ||
> +        !address_space_is_ram(&address_space_memory, addr + size - 1)) {

Overflow prevention:
size - 1 + addr

> +    if (!tegra241_cmdq_enabled(cmdqv) || !tegra241_vintf_enabled(cmdqv)) {
> +        return true;
> +    }

It's good to have these two checks. But if vcmdq setup is skipped
for vintf=disabled, we need to call this setup() again upon vintf
gets enabled?

Also, do we fence against unassigned vcmdq? Corner case is that a
guest might write base address registers via direct (global) MMIO
space.

> @@ -363,7 +427,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
>           */
>          index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
>          tegra241_cmdqv_write_vcmdq(cmdqv, offset - index * CMDQV_VCMDQ_STRIDE,
> -                                   index, value, size);
> +                                   index, value, size, &local_err);
>          break;
>      case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
>          /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above */
> @@ -373,7 +437,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
>          /* Same decode logic as VCMDQ Page0 case above */
>          index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
>          tegra241_cmdqv_write_vcmdq(cmdqv, offset - index * CMDQV_VCMDQ_STRIDE,
> -                                   index, value, size);
> +                                   index, value, size, &local_err);

Should these two be squashed into an earlier patch?

Nicolin

