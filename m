Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2793CD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 00:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK3MV-0001iC-N9; Mon, 04 May 2026 20:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK3MS-0001h9-Ma; Mon, 04 May 2026 20:10:04 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK3MQ-00027N-Pd; Mon, 04 May 2026 20:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZoWAnQzHS2CBCVkZRY1WV/n+EHN62V0OL69EP/9C1Xm6STxoiJVIo9nfw3nRuFW8sVlSwfN5/+nhK1OStTgi1u8HJ+ZsCKUVheMUzeBN521N9yGLiD58cJaaxgeF1KgQGzEGGU33cxR14fyeVXBJ/W68mgZVzdvxknYkmjIwroPsKJQTV2c7K9bOQ6hkohTPhMfpOijR/y7pMKlrAyaIXU1n6a3hdlmPCOIjiNU8CqV6Gv6/6xjnswH5AmFWOZBzE+trF4uONflg1CrJA8uYQyhq0vdJx8bQKbJTU3wSZnxU5t4D0kCBYWpP+RZNgkESgCoyIJ2PCtlqoQ1kT10Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQt+wEcS4uTyxT/bkf9UuS+MkpuOilWbpe0Fl9z5LA4=;
 b=kog5ytoLvhpbymKr4pB6B74+PaCLawnhpa4XIBC4UxxBaxyXp7A8fd3cIzKAY8Acf3DTheadkRhSCoV7MXWQ29/k5gOx6+b+0ts5HVcpCysTg4Nb3O4KjCdlSeREhKngsThTBnZUfXjlbpH4vP8aBu5a43HXRXAiP78dfgMtpFMMxQr0HjlTKCd5a9EENYXtJq3GIaxTrCI3PzD/sGjXh492bjG8C31B32Y3+L6Q7jaUMWI592qZToO/ZF99gvxuny340fjOggmXtAhZ0oFZtDI3zzCGEWjsK8eoRbzEk8vqTF0ISB3Zgg/6ix4KpQBb18O7tOYqsaxBM+k0YvQvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQt+wEcS4uTyxT/bkf9UuS+MkpuOilWbpe0Fl9z5LA4=;
 b=noOenXkeJ9vDMZs0KQipsmFZzKK4c2rCmdh3YRDB3E/bslzIFLsiNEt0IoStHsBJVbWZEL8+dT8ybHMurXrc5lBIM4KL1/Xt/Y8msaM9hLTl1FUsFJzCTM1NCESGSDN8sjmORtgyO7sLnSNFWp/dEZQpA68lKuNHZaNft52V7JtCjkDbvGDPiIzbNyxGcff1mB3+M+Lgo2s6fz+hRvb+dmb0D4nuahGMSOHCygAFildmTKzrN9YxKO/d8fcmIv+PNeFq+j6/Wxn8oCLFtiCYQquY5amnf0PN9NB8euR61Upwg1nFguybEboVM1w88OE0J1tDs1IsPq7V1489YvwCVw==
Received: from CH2PR18CA0060.namprd18.prod.outlook.com (2603:10b6:610:55::40)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 00:09:54 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::72) by CH2PR18CA0060.outlook.office365.com
 (2603:10b6:610:55::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 00:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 00:09:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 17:09:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 17:09:37 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 17:09:35 -0700
Date: Mon, 4 May 2026 17:09:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 14/31] hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config
 region
Message-ID: <afk1PaaAgEoRg3z3@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-15-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-15-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9707cf-ae3a-4dd7-9dc4-08deaa3aa27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: k/t6G2c21V2HUuz4lMuOnykyGMv0UOYaMsjZJ2NB2avCa4aYnG9MOGgN2eNrvDeW4vpJqnylB1rQZuIAYnuYDJif4a+uuqKLqpSt1g3fKrGD0FW6hJCtFjgrNYZnwmtYRoUsPXAHRu6aZ3YRpPw6PxnOlpXENvyn5XudZ8k0bMxspYoRRfBvOGj4sTms9efyC2Pqoz6N1NFBp76VQ4/8+UXfTVVBVfpcap7lPeYpCPCONZhZ90/4l2u6pMqENoABrn7mJYKzc2d4gc+tbEX7KMSsPP5wMLg0TKMu9OD1i7QMf0XDgp/ue7xSupaUeD1HoDrB6WXUoYJa6aOQmxIkwHeEKT2KOYX4WmTQ6vcp+MuaEEdY/nBv/1KnS7S3g5sN0YWwvh8Rjen4C7n02BCNpr+K8emYEXE5IXnauzEU3PF9idOu7s5IaClhpFRpdBaVyodkNFzcyCiK3D/bnDsl27EpXWCj1p69yVrDc+O8b82b420NU/7YNMcxueRaGzAlBpa10TZrPGL9oOzjMhVyeV/AO+8eWF5RsE3EhDoDjGMHEBsULXOHp5TpeIMB2gCOMvJDPSrvQ91mCavsB7pc4Fssh+ykxtcVN3Pt6htiQ1US+nzB70pGti6Kk+2nkKkVjDfLf9VjX/5cQQ9TcWeuL27wJOVsCY3Wi/2yf8HKSHKCJ1LStIxgxUqEMwt8Zfhx7YFudSUbm0/EgbCPr7h9HrDnEEpgK9PVqK8eRSOuEVA=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DzPUeqQoVNsRYpM7SHlpNA50TEfHaObiZzEsVJUW/+V1r0UDWXfNDhtK8aVhAohy2CbuD7h115+Wbe0c1wUxpgp1qzpMm63MmWCFUy8ZmzIL+aSr6gf3VcB9EywHp9C9HZBAvjf7EIsp2W1PxmjJpwGmkZoJMWc7zBtEtB6YTHH5iwadVbMNwO0oR3d98bRrneJd+DA0iLf6DBTJweUxzOghkquF/2Euh5fzkqS/uvqtoEuDjpsETEFyDQmi9SMIX/AUMQlOdlFdoBknJiv5qJF9IdlUCLlY+VSAmvbC1QTQjGcD/7UlL6d8lKhn8+JBmksEvkxtEuq1BmnFEVd8vFDrprpRlg4RW/eu/cOUc+HIb/RQJjL/3yfjRbP/bTDKJJ+L5acqTzX5JZSn8LV8WzU4enDFtVL8vP9RsO4syTo8reLt4QxYCsI4e1RKlVYh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 00:09:54.2558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9707cf-ae3a-4dd7-9dc4-08deaa3aa27b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 15, 2026 at 11:55:35AM +0100, Shameer Kolothum wrote:

LGTM. Some nits:

> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index fa0aa3ab04..965670066d 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -10,10 +10,14 @@
>  #ifndef HW_ARM_TEGRA241_CMDQV_H
>  #define HW_ARM_TEGRA241_CMDQV_H
>  
> +#include "hw/core/registerfields.h"
> +
>  #define CMDQV_VER                 1
>  #define CMDQV_NUM_CMDQ_LOG2       1
>  #define CMDQV_NUM_SID_PER_VI_LOG2 4
>  
> +#define TEGRA241_CMDQV_MAX_CMDQ   (1U << CMDQV_NUM_CMDQ_LOG2)

Maybe add:
#define TEGRA241_CMDQV_MAX_NUM_SID   (1U << CMDQV_NUM_SID_PER_VI_LOG2)

>  /*
>   * Tegra241 CMDQV MMIO layout (64KB pages)
>   *
> @@ -31,8 +35,131 @@ typedef struct Tegra241CMDQV {
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
>      IOMMUFDVeventq *veventq;
> +
> +    /* Register Cache */
> +    uint32_t config;
> +    uint32_t param;
> +    uint32_t status;
> +    uint32_t vi_err_map[2];
> +    uint32_t vi_int_mask[2];
> +    uint32_t cmdq_err_map[4];
> +    uint32_t cmdq_alloc_map[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint32_t vintf_config;
> +    uint32_t vintf_status;
[...]
> +    uint32_t vintf_sid_match[16];
> +    uint32_t vintf_sid_replace[16];

Then s/16/TEGRA241_CMDQV_MAX_NUM_SID

> +#define SMMU_CMDQV_CMDQ_ALLOC_MAP_(i)        \
> +    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4) \
> +    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)   \
> +    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)  \
> +    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
> +
> +SMMU_CMDQV_CMDQ_ALLOC_MAP_(0)
> +SMMU_CMDQV_CMDQ_ALLOC_MAP_(1)
> +
> +

Can drop the extra line.

>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
> @@ -84,8 +235,8 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
>  }
>  
>  static const MemoryRegionOps mmio_cmdqv_ops = {
> -    .read = tegra241_cmdqv_read,
> -    .write = tegra241_cmdqv_write,
> +    .read = tegra241_cmdqv_read_mmio,
> +    .write = tegra241_cmdqv_write_mmio,
>      .endianness = DEVICE_LITTLE_ENDIAN,

This could squash to PATCH-11.

Nicolin

