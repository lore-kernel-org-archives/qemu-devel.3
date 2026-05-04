Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FEFFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJyC0-0007AF-EE; Mon, 04 May 2026 14:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJyBz-00079p-0o; Mon, 04 May 2026 14:38:55 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJyBx-0006hz-E9; Mon, 04 May 2026 14:38:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6g1mivbrDY9KX4RelqkNywd5QQhf7jVR8jO1U9Wm0AhG35pMAHQPxaYOq2YmgVPETTy0nN0jeCX6DCm6z2NLMKp3iESWAd+J0z7Jqr42MmrGZZ7fn+062iw7MUuTg4dAODd8j0Uwmi+8xKe/1GtJIC2vg/YxGGiuHkPGmWvuYkd3o3OCTI4kE/ErDSnhoSkYLuwFmQ0Yw77aj90PJLIWA75ipWvSpGtjj3x/MhwcHhFVutdJURElZKTSJFuyy5PLHlTmUKLn6d8VR7FSPVIM+cb4nlGTaGv1+OdhsXgvXheQVUF3VvZVPoRvp2B5Wm3j6HNViqxsPjycN13RNynqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFbpqUBS7JcpfBR4vcAQpPtj0qgagHtoT46zuJcxCK8=;
 b=T0CVypB8DLLBIYvFD78/gtUrktGgP+Md6KxfQvbYSqNrMy9/ZSue9O2UO0/jvVe6Ub4atkgB/iznwskRzi+TVd8XPZ0gtfrm1iJFvqi/ITDZ63CYcPjij5gd5J4ZPHvCSQoCPMQtj7YqyyBcDc/3LAtSGMBrpCQooM/t525ZuO79FU4Au5RlfgZD8VDo0+EWNbw3dC8FAprFB2p4WbrAdrGIcIKVuAek1hhqKj1zEV/iF6Jpnydskf1iBwbryEkNhjTWvI5xnSyGdevaVX4SiQEuE5oTXypfDT7jyI4mwntBy2sj1ugLWR8BpRQRdTlRtERJBPsTFK7Hxk1Jlh1VkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFbpqUBS7JcpfBR4vcAQpPtj0qgagHtoT46zuJcxCK8=;
 b=fuI61XXP/+cLmMbQlBscJ/GfB8RjpzdYLHO1ca+/RkgkS0C/E5NCewCYuTjNMI3/adwOLBoIR7g8iJ8xaX8cgS0JZZokTKci1e3XmY6VizAJCa6/rNRveGLuChZ44kQprv6AIO9sOTgyhFdLWmHq4c8JzeOJsJHUXheD6GTc5M7CL3jT5MpmbOYTtWO75+g/iIBe0Soks/R4JM31+eXxYdU2LpragArTOXKwQDYK+34EauMeIbA9rIHYKmExyLgGxmg+zY5ydABTsegEDXveRt9UoQ9DAKnBykH3jDbvKQ5evcZmyFfwMyuAyuG87sO1FH3ltjcOlWinWRfdf3331w==
Received: from CH2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:52::17)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:38:44 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::38) by CH2PR04CA0007.outlook.office365.com
 (2603:10b6:610:52::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:38:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:38:24 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:38:24 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:38:21 -0700
Date: Mon, 4 May 2026 11:38:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 08/31] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Message-ID: <afjnm7XE1wAsBIJo@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-9-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-9-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: db201a73-8482-4474-f67f-08deaa0c5ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: RDVrZHRPtOUyinrDxYowY87i1o9QWYd5pGbu4bVOMjcvd8zJUOX3VfZtdx9/DkHazOhTXhv93AXl3ahg5j7wREdAdaNeBP/XgHQyp22H+5Emao8mWnSM71Wr1Ng4zrDlEzMaKU4mRXMr6067fVAsxPaHXU1mIFq5xexSlGSsVHZwRgLcLOMzl45GnvB/uDlciCbVOLYoUa0ZZRo7I7D0EulSmzBn9NLBneHQYTu6JpiEn9nOQvpsInn1eD9rwiRjtl2hIoe7NZQPI4B0rbpi5mu0ifxtdaKMl+CLZ2F/z0L4JZVqpvVsxwRbzrKMh96jafqRVDM06/KNlFo6O09Ct6/Qb2RLrmkizjjoexLBfLiRaQ3sgymKR6kTAjcdx862K8D5xTaS2WK8xAeGafZif5jLFwDw2ENQliHu44ITIi3R12W4a0TpkCfIw84nsc/Suf0hqxOZtfbyLAj/WTqrEVDmeFOwyh/cbu9FSHmAGpXwNeg7p1XKoF4u9qSh6tMM02u5rSL7zN9I2Pt0dekga+4B5brheZOfe2+EzbSL8B5Do55thLDau6Rkq/b6SrGVLTVCWb4QFqrjW5RrqowxD3/dQL2RcCVHRlEYYhioU6tWdQ5Kpa80cNxqnLhdubphbGgHXgclt4v8tpSZI3/FKR4CSqSWrGuBPDuyqlIl9VSXA7QF9YJjfyXVa/yReJnoEcYRm1Mv4Ct2jIpPmeYJUhNf5Tg1hIqbMnkaJQvfr6Q=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VIkK5yEjKmuOuvXv4XNeok+HNnuJCCCL1BSMslG0oxMlPnGqEK+9XRbHOwI3oE0buxMbjY28B89538+4Q1/97cl0FFCi0Y0v7g8/AVT9Fs3FyDmlIz2VfYnjf4+CyPWj3b5UOCJvXNSe6SjulFkxQ39WdoViDTnzB4qwWDrSX9chYU2B0Q/JEufk+dVrc494DhY46eqdYUkuFDoNs8J/2PThBxDNai7yl+++H39+dkw4Q7ednA1ZdMw0foXOsRNkm4wrU2P/sAFiRe6JapnM+/ux6vxznZy+XYAtQqqBUSlB4tiWpzDmSSp8YGy+KaJQFFuiXpf20hbsf/IzX4tHA7BRyvkq/Mmpxe0ukfKBnzzvMbcRvUbDk6zIKBGDwPfsGr/FWNDB6nMhEXCaRfUZVQu/jOhRqXOfSH65u1OHShgG8DYAXiNKQg57JvU3+Otg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:38:44.1114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db201a73-8482-4474-f67f-08deaa0c5ef4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

On Wed, Apr 15, 2026 at 11:55:29AM +0100, Shameer Kolothum wrote:
> Add support for selecting and initializing a CMDQV backend based on the
> cmdqv OnOffAuto property.
> 
> If set to OFF, CMDQV is not used and the default IOMMUFD-backed allocation
> path is taken.
> 
> If set to AUTO, QEMU attempts to probe a CMDQV backend during device setup.
> If probing succeeds, the selected ops are stored in the accelerated SMMUv3
> state and used. If probing fails, QEMU silently falls back to the default
> path.
> 
> If set to ON, QEMU requires CMDQV support. Probing is performed during
> setup and failure results in an error.
> 
> When a CMDQV backend is active, its callbacks are used for vIOMMU
> allocation, free, and reset handling. Otherwise, the base implementation
> is used.
> 
> The current implementation wires up the Tegra241 CMDQV backend through the
> generic ops interface. Functional CMDQV behaviour is added in subsequent
> patches.
> 
> No functional change.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

With Eric's comments addressed,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

