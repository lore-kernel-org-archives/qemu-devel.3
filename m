Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6290FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJyUQ-0004nN-SV; Mon, 04 May 2026 14:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJyUO-0004n7-N3; Mon, 04 May 2026 14:57:56 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJyUM-0004y0-SK; Mon, 04 May 2026 14:57:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz40HjiTDsZ4PQ69FcYEgnJXdySokDtFd1agoxQQ4HNqMR5G1Cfx32Axf2r5IjNcLO4+OErM7+5kGh6kJiVAQL+LgzlIXnr4/xAduvfPev68Ud7KJOwEHf+GanIZpI3kgLjY63TNnGQwY3Jl0axJ2xSuSHigTgMkR2BB4lwyF8P1RlDcQ0fK0MciXCbSUHMY3KRda6xAqIjPHojmIOeyzGG0LNf5B2QV8Q8yGWmEZaE3JJ6Y1210+e9Vxe0I/yabPS7PbU6TRMgU7qYp9PgyktuTFUvyN9EiNZ45kE20tFQFTFv55NPOJSfdoYQuD+jqCRG4/uXWSstDezhp1gaeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kit0SJcYTq0Wiw7ElLRGCjBCVhQ+CTIeBUBQm2EYeEI=;
 b=o76uWuIEuqCgWsj6JN7/WKolla8bFVlM7/LnLd7LnVIqq1Kt/8zzzOU8KUzlfUF863sEVPlUEArpsMkmU2F+BNxgK68M1+NOleM0gjN8tG74cjfa42b2zC3PgnOnpq4LY3tPs+zIVY+dkhFY0PgTsVRFCnYaAFfUlSVhXUFpPV8iaQNr8TpOkiW7JQmTsX9WvP6ZsJZmL+BEWXTQm8cwe0pMV1wijK8ErkqIJBEamTvOtl7LbwjVgaXVqvtFBfw3zgU1oqGLdq4UlAX9txYbWdjFfq6+SQFedOCGQJViaHHGO1VisMCj4dYNK+Hfw9MgN0kwr/mKnUBVuHex6cWVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kit0SJcYTq0Wiw7ElLRGCjBCVhQ+CTIeBUBQm2EYeEI=;
 b=qXJwRy5m9ZxqWAwCdeRe6VdTf/Qiae2TY2vL7UTTVA5INR94ITGYE0yUS28jQpI5Co3XJNcAD/JqcWagdSYMO5boAMljDLJxbVLrBibu1Cv/YRR9HDBp56+bgpY1spHMPe+i3+HNykJDS+JPPcjsJo9sBQ3OcXWAXccNLCetTRZYtzpkPMNkIVexQIHC60+w7XFk8wcVE94xFuJwWjMQ4ZUY6TKo8WKanKohg2qba5B4ZfDWcERKZWPVpNnin8ojtry3TW7+xPavqZmX4UhPfU0fCfinoOByQbonR3PcOp39Zsv+Md3kfan93RtqkjKBxzF3FuBgAV6+aFE/ivz9jg==
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:57:43 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::ef) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:57:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:57:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:57:23 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:57:21 -0700
Date: Mon, 4 May 2026 11:57:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 12/31] hw/arm/virt: Link SMMUv3 CMDQV resources to
 platform bus
Message-ID: <afjsDmCrDD/9BLjZ@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-13-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-13-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 285a740b-c055-410f-b93c-08deaa0f05e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9SugDBrg3XG+3sr1nURR/uVlE0OzFtth40L95UoBihAgqePiEu7L+gMv1QXkulFAy4YTlo8waeVEPIWPMrmaXcLTuEGOqzt2w5c0fTRRcLETpNHm305jL1WLHoPjp6489zGkUx28HJAKIabga1XbP21oo4ZAVuqQk3V9qeRCdL8xeYmvuUaLRU6Q0BG5nxWRcE5SXhPVAypqLTzyGoPZwMraFTEuq/RQ8aePPcEvcQ4eBE5hmJ36dNk7aTP/VpKJDyVVOiyLqexXXl4OtVw5WDyjfa2kUjfL4TUeBCAAPA8JAtFRx9iyghcG6xxAJzHvUqQlqkYnLrq84ZLzmNLf02jpMLLzUMF2v/sASZp6l+0bWxBC+9lD2jJEY33CEe6U+eAe9bn3XMjCoWj99HZE5XcVFtoSwKGNdZbgqLqUuYj4ymzbgLnX/iLtFvhEr8GrLFRX+5jGsijk0G6LJGs+rQgxorW60mijjmhfGO9ev2a79YMVLyDQvg8IRdvREfxpAA96Dmv0T1CdTxz6M+L8hYv/SXvlV9YNVyDLm9psHZD9wHUO9xiUjCAZdfKvuQUeuJqTNUmmJPsR/uf7rpaRh2XOccAg4tj5FzhjlMKVOOMqM1SKOxRM3JG2OEVveNazXm2ZdMrYgaD5tqQN04FaUhAHZ0BVe+VZFDCps/3TC9PZUv0ZGTjFGt4naUq5xPEUrU9Rn/8z8qdu/7ZSupOB5oOjuxva7kIKMpjrQ9h4T/E=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y2jYW4XGOtAgXnSceMuc54N6WEdAcdOADHXf3Vy46vknnBWYybfm88vkPvOFffgPvWi7wLpLB2n1FBGpdcPCYRhk4w7GgaP8rr9xzlbCNz9/n898sVBBVtM8J63RkSmzgOeFF0cpJlnASBbcYUzOjrSnnkwwjuCDyvEQxlY0LXzIiAHFoCmkL62V7+CD9A4x+usW7qDBhlAE6K8rRFG4n457WcDsW/0ptRsHqkBLhy0Jj5tmARFd9/nw8YR1BnTGMMt/1Jqz1+9OL/rVRTFhiYWojNbn0gtsP12fJ0i0QvrAPF1T/ppLVVbIvckqFSnL0SnuhFLTO3IO5paRGwx34KhCsb1PVXfOHvBK8AZvhQUTA79o0qQihUacWs5BgYZTWsx2YL+BjQqR91EeM5uHzCuxnPlr6lnbR+3h4sksI8ZZEjfwEoe15JbnoDGpF2h5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:57:43.1487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 285a740b-c055-410f-b93c-08deaa0f05e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Wed, Apr 15, 2026 at 11:55:33AM +0100, Shameer Kolothum wrote:
> SMMUv3 devices with acceleration may enable CMDQV extensions
> after device realize. In that case, additional MMIO regions and
> IRQ lines may be registered but not yet mapped to the platform bus.
> 
> Ensure SMMUv3 device resources are linked to the platform bus
> during machine_done().
> 
> This is safe to do unconditionally since the platform bus helpers
> skip resources that are already mapped.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

