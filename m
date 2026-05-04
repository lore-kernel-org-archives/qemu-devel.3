Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D570DCD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxxs-0002pw-Sm; Mon, 04 May 2026 14:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJxxn-0002pC-7Y; Mon, 04 May 2026 14:24:15 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJxxl-0001BS-9V; Mon, 04 May 2026 14:24:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9jCAXfdAY5qoMME323emnubQ+fDVVAygth1Pe5AUISc7kAekGc2tbzRqFgm2T82KOI6x0/58+F7x6chyzqrVGjnnt3UYQcsk7qk09+xUhD/3Q1ht2P+v+Bxjf51Gr7+Ums7DFrgPTOboJQg9ppb3dbYD26nuzhFgwNsAfUxY466Z0WBqzTZnvTsaIz+ur7KxvmbKmBSloe/0SDrJJeHIP+vrhwqJy9TR3HAvrcZFE6fz2SbWWMqmuZuKtG8UbqN6e1l8NVfj0GC4I2AnqY0n/lCJ8ZU5u4N+vWjQ8AQUD4TX2Dfy+2k8ZEe5ITNfD027yB36BR/zBBUeM2vTOQQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUAXxi3VCoX2+e8TEPHxEYD8jir2z/jjI3HIMbqF1g8=;
 b=n8h0UZRcwCXb49M5a8iCiTqaIqyekBUJ3U62RpDKvoVkAruDuv2VonF8ew8gPGoy7xMety16c0SmvkIKnYDVcl8XPEcigNBgKMzfLYuNxwF/pRKFNQeq8Bdx68tiBWWgpAMwL7Z2flp8FVsfCXHjfyR1cZk1Osib3P90591WcrhdiwYKQJNFYOANoiYNDq71SLMo5o86mWnRilZzpI9O9Cb4deQgJRW2hy0d/Lrg+6o527X2N2qHwaLLUQLKs5vtLENQdUWsIGo1/Mdf9tQSA7uc010TyTUp5OEiCZPAeFg6i9gV0HXecK+gdW1U3d4bqAlIkAy3shUNyMHN3EHH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUAXxi3VCoX2+e8TEPHxEYD8jir2z/jjI3HIMbqF1g8=;
 b=gZRGLzVrAxO7+QT5QHV7x8l4qW4/dQKPROaQ6vyfGq/rOP3cb2WoE5flgSipLANMxUlfR3JxiKcyzNoyqJJFoDXo41wuRClq7rU2hDcJH/OX0PuT+eC3RUUtyhRDzeMmcOkZPKGTzWq6jy3MUunEH8eSapWV9fzO/aXFwLxl6wDoys9n+RqRTy38nUvQ9lxLO7IqVfgIgpaOJiNULa6a/EGEIOrAM6Z7XG1BsnRNN/kt+cmpNj+C0bMtZRUEXO5/7pCO7G7woV5euOxhUWNWXYt41ADv2XKCvH5P/z1KjiXr15v/i49slFKkzKe1yZgrh7g4VaZaboQknAHiLiNovw==
Received: from PH7PR17CA0033.namprd17.prod.outlook.com (2603:10b6:510:323::7)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:24:07 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::42) by PH7PR17CA0033.outlook.office365.com
 (2603:10b6:510:323::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:24:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:23:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:23:41 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:23:39 -0700
Date: Mon, 4 May 2026 11:23:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 07/31] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops
 backend stub
Message-ID: <afjkKQcWFYIVV+7t@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-8-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-8-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 384fff90-8bd9-4d2a-a936-08deaa0a53b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: tqIT1iAvTO6iG8ymfiinB70oBWgXdwd1RwP7g0T9AbAxyi9co0pqMAaO7jhYdHzVibpcQ1SgBryPYxPiRr7LWyljHr+iZkQzndBX4r7fO+a9t/NGYz9QW9Ilyfx+qmc8hJONsJSE/HPY/nGFGb8B08bcjFAaxtLGXSiwiG/ZXriI1xTxXtZu/zBTpUBNizFmjXNiq953rcnoMcJ3AyB51acGeK0oTTi1AiSSNZXJkG5jyKHbKxYXTYozqPJVnmGjEJ6N+97k55EHUdFZ5EulUJC+iD/aDQUrEyXNlfeObYF26tMQ69Fd4mYU4UuJP/MhQbsMlDAuh81PS/dcBVaxdfo49VPEx0DGtWTMNe0Dd4GMtk2mWzUSbjRUQhdEILRlBGwGTU8/SVLqqF9OAGIrRvJ9dwmCOndKqao0x5GbV/SXu+mVNycL1WVhPIB+bPSbjRXxcQsdxoMqL5vU6YrR46mn0g2lF7CA17t3/XqoUVja+sYw0oHp9DEbgNc+yNsNzSsHUaGn9Uivj5YRegZpBUQt3cZ4W5fROx9mIIeaU4yAuTD0nX0QBPf/Dm0SbUM5vpe6uXam7iqX2vNKzMm1mFDILD9Qlx1ADmNqEjHuHZtH/hvLcBfg42LNgxOCULQCpgdJxFXkirvHNZ+4LpRdEC0NtX3MS1LZ0MHPn3L/MKFKctPSMaSbVOuEir2ZsYcZHyYnzjtyY3Mi4+lewEPtqfIcS7ToFCjyapgCXDsuZXM=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Belt9mfcy6S+dU246Yo5ukXue4IKxy4QvIgF/HW69R+HLZNMtlqYGJyRseQWBhdIgulbhtPL9FehUiPtTJnPAbZZfdDCdRTJwQdjv6aVTR5YZSwaNflMErocaIFnJP3CKL9fSv6SNkS9AU5Ti+fFf0xLnYLFTqqcmnx0hhPc4eCom9HCHQGhNFgzLwc7869i+siY02XvBlxRDsYKVumofwCd8FressrNa3jkeuZsWt84ckKu0jHyrBEUXwDm9mlXh2Vp9S3errORVUFGn08ZY+Gc/VvsAkj2EFcU2SOalL8OlI+mii+SNsZchN8jDkNEm5KG9pnX9VB5rhXaU0qQHxP+PShjI7nZqJu4ZDEvUWDYs/HguJW7GYHjAd0hPe/sxWI4gkAja43WAqL5MU8pISoqg9xFvXD+1OR7xE/ntfIlikyMsBptn58pyM0KrME
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:24:06.2847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384fff90-8bd9-4d2a-a936-08deaa0a53b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

On Wed, Apr 15, 2026 at 11:55:28AM +0100, Shameer Kolothum wrote:
> Introduce a Tegra241 CMDQV backend that plugs into the SMMUv3 accelerated
> CMDQV ops interface.
> 
> This patch wires up the Tegra241 CMDQV backend and provides a stub
> implementation for CMDQV probe, initialization, vIOMMU allocation
> and reset handling.
> 
> Functional CMDQV support is added in follow-up patches.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

