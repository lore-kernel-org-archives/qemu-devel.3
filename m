Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4779CD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 00:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK40H-0006RH-Vh; Mon, 04 May 2026 20:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK405-0006QY-Vv; Mon, 04 May 2026 20:51:03 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK404-0004JA-Fq; Mon, 04 May 2026 20:51:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReGNm/DOu+dHjTvr0I1SgfZG+L5iMl7Xt5P89W7pKjMIpKS562ZVfdhvVJ4bAe72uBBHutg09iUNJLKr3xH0D+PkEryIetxK2AmluJRf5E+8l2rgb+oWx2dba+u545wo243CRgHSjBlVuPKewmCelSEnhlkLOZQsccbODtK4+1RideW7nVcACl592rWX8ejJeYh7nwaOa1vmdnWPdFTCTB5hJ+09jHEVCbpkDmeIKB1s5WeBO9dgP6z7d6sv1Je/wP49qqIVKx2HH4J6WSO0Dz/GZvPNLbpXnYIKlGPX7G3cwozxPd4ZGQ+OTXlwAmOLmLDq4XHRU/DAwJQoa+lagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+FVtx02aTfJHYRTwb7LvjPLi2g/tUZLYNFa769vl/g=;
 b=HQgx3YRCWNjBF51thOTRpYhOlKUb/Y/5mgXAMZ/Bi827ZM7pXD3VJWoXWfL9oT3AsOBwMyanEfMck4Tr/kbV0jeaGvrENlA8wGftrMyzu0YCX+Yh71VSVYQ4f4AB2KZzXScm1es12SBIFwRpsBRIcxwnLYPJ3g7Z3L4fciVtyqvXzBoV3hqOHL9pX2i986FEEL7tlTaQautr4TX7upwt+HeXk4ABYPlDEJSXTgqIFOlA2Lp6txYLpS88jdW6Xxx/Z6FGxS+XXzsgCN7yqihbhvVaNXTzsB8LPTfuMDur4FNsuttNJhSuOeOrOio8aM5LRi9C29tCC3gTGFf7tt5j/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+FVtx02aTfJHYRTwb7LvjPLi2g/tUZLYNFa769vl/g=;
 b=IWDBgBuXH+sllI1OMps8pnSLEKoS0HEKrTbIxRQruNmOQt0GAsm1OGHX1hVs+lvyMqv4pCzLosH2KomxI1PHJxYnpBLH46y0gPSzfHfpKuoHc1G+KeLfOuwdZXL2fd/lKS6NaNFtFzKMxNbCQAI/aGuxQ2AHdG3xoT4avh9JHk8o6M26kwNpqMf7uUOkwWGhP08qR8FBu+f/cEhHjiQF2NYTam8qXtw2oyVvP/odOJjnjjOH6PSJ5SWfj/AFiwhAV4fLlrwTZLQDR4wyK4osMrx0sNPkU0YxJ1Ol4PWewo0Xy8B7amUP0dIiF/VtveonWhST5BKIFOsqLHBM4UyiJA==
Received: from PH0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:510:5::32)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 00:50:52 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::d8) by PH0PR07CA0027.outlook.office365.com
 (2603:10b6:510:5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Tue,
 5 May 2026 00:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 00:50:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 17:50:26 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 17:50:25 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 17:50:23 -0700
Date: Mon, 4 May 2026 17:50:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Message-ID: <afk+zBZLQx+x+ODl@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-21-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-21-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: f618f1b8-b1dc-4b50-33e3-08deaa405b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /LgKSa0uiw0dKNkt6Mb3c7XYu/acnJvVjeLKUmjsyBevb9Z4oHEKbNLJcXBgmWT5alwXwRk50dLRj76c/I7Uy5U4WoRGJ0n5eeezZIUPKxsH9304o4JzMKz05upwlOJu+DRtZ6omDH5jnYgHOxhY6fAxOQwhFbdSU4t/4ncv2VgWt8CIXnmm3bzCTzVCjwVxMqV18+3JOQxisS+6/KYQf1StUGAuX5Onso5vNIsZ5VPo780w2ZSTHUBQyUfmEudOFIoJFrqudFroUmHRu0pEJGcAFcRl3KFhCyBBBgaRcbj85dQgp+eVxFhELKI2PaSD2/eFiO3pqJYqpYIn24ALSHnGatG1pDWTfnjBE/DJIurhMKEiHQoC4lOwB6tj/dB9Mhi9M9qK+tubVz/zfsMqEuxl8ExKOIbkKAbyM8IxnqfWbNPAVsgtfISm/59aPiIx/RODX7uulciG0jkBwKmarXvnwxPe09Kp2oONgoJnX4XSYQbrki5oD8PCizoeurJ1DfHB2G4S/8mqbhFfLe3MlfmRWlZ8js7H+PBfoCWukZYqI208m9tAWQGsGhzbqdHuXc+9ghLtsdXuUXXEdNC5GzPSR7DbDGR8wmiB9A0AWmC3HnKyIoFu5XFblHaxsQH1Ci0rJuxrjiRQiLIm1/Cxok33JfTOKraDs/Mi9r0zLh0aoiWZHGw3FMIS8I7Ks7XlwoeCUwRYybfCWzDTUR9h7LPOuVmyw0emKZZwYrHZLYg=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wnhl5wiVyI+qeE06+/EbqW+Edd/j1kMcWN3HejcD/S3hPnj2SiwubuiRaKKW3e1kBTwvk7xCbTlxGVelIrTzR94mXvqVERUkRswM2jZKmkO9fDKxLlE83aGqAe0H+J+Qagu1I0Jz84Mb1iOrjdE9GkLNd4ZgN6vwyrCPJaE3vbO5H/DajxaAOkFEFB8yBgNCqu9okducxnI4MAcBUEnJLMbLRErZ6LNKS+Qnk3UjXlmAxSpJWrIPjXjLGgDjHgUrpCzQc0I/IoMy1S/VMfR5jQ2rSgfVir8TSO1oa47QyQo+htwPK+qz8MOipOZhhGX4wK5utV1iT+h9ThpodJUOhyFXGbHwUa40bkn+SECsfETE3w7lfyyPaEj6qCTYEfXwzM/xsKIkHkmzsVaHcOoN4EGUsfulbUzVdHzMqszyZ+ZnwEOCzdnEy6upE0o2820c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 00:50:52.1548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f618f1b8-b1dc-4b50-33e3-08deaa405b81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

On Wed, Apr 15, 2026 at 11:55:41AM +0100, Shameer Kolothum wrote:
> The pre-to-post-alloc transition is triggered by the BASE register write
> that initiates IOMMU_HW_QUEUE_ALLOC. No cache-to-hardware synchronisation
> is needed at transition time. The hardware mandated init sequence requires
> BASE to be written first; PROD_INDX, CONS_INDX and CONFIG.CMDQ_EN are
> programmed only after BASE and are therefore always post-alloc.
> 
> Any pre-alloc writes to those registers update only the register cache,
> which is discarded at the transition.

Is "discard" the correct action?

Guest OS might expect HW (VM) to retain what it writes to those
page0 registers?

Nicolin

