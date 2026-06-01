Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498CECD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU9y7-0007ID-BV; Mon, 01 Jun 2026 17:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wU9y6-0007I0-A3; Mon, 01 Jun 2026 17:14:42 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wU9y4-0002GA-SY; Mon, 01 Jun 2026 17:14:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlfDOrJco06lgL/ZXqpC8ZFuD7o2v3OPs5WvlH5G4aTiOoRL8GyWi5ovuTT7B7p/EhSHSjQl3Aiy41vT/gjeh7RK4fuQZKj71ilYfgUdCZZC2t2hiL3Pj7x3L70PNP1UNzYIchn26Rfa79XBx4OBGD0ZFeP2jWOWIpZyriXy7z/XR0F3I/Tzb2qjLwKX1yQs5O0Nxz78n+yrsizRyDr7NlHeK+Tw8AESbbfV6+2unjcTxDCccvdPK8SiwUXVOe0FGdFiBPe83s2MpBGW3J01MUusNzR+jhxMG0SyxENQjvP0B9pxpC4W0xxgVqLi5edNl0QOLBkVPr/ZpPuyyyCnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mafMxyiuhaXDv79QJhMPHugQ2epYYflmsPADIwma9Y=;
 b=ckKpn/qRecGs34MKXlQ58BjLTOz0jCfLsd1G+ibtY0ZHkjdURTHgiWAg8LfGtoG7MMZgj0a2+OMuXZ2PN7gfm9HFrNHVzlzAyUBtUhXMG0jOSlLMnpv5xh5nda9s+RMKyq0VwEnB3cDhSRxIs9C3wbLAeEIgA/Ik2XL4Q3LFZyNu1w78n7gFJUcwkjqbFXa4XNvqprtX818eIZJUSYByEJq3lB0RFYWn6ITUoASUlTz7mf5kJHGFD3WvbC2NR3ZgSoJMnhVEoISPVxjA7t6gE+6pxBztJDxcmsO54lPpC2bMMYB6bjnGpQYQEUlbvYpCgv6xG8xyRJzej0iVtkK3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mafMxyiuhaXDv79QJhMPHugQ2epYYflmsPADIwma9Y=;
 b=EPPSRAhg/7vMgSnRG8ypqmUV3uMorqoINR2eLD4vEqwAtqQwdgJBFL9eMpX3c1wPdJDTMaDfI32QBFcjH2at601FgTDvVrfYAxkN1ZPh8RiLNMg32nVBqeA6Cd4qbu9estll+efXKwQfljYVNbgyF4AjizLRWX6EOWpbhS7KJvpF9+lSsWm3/KsS0xTF6yQKfId3Votsp2RIvcHTAkcedP7QXACRjqTPW9sTvTxWytw9sdF98fcck0c6hSttjkXcuT5jMk09omueUHQv2pnGvq91gzakCnLLgwxfdBqoHXWZu2gtiGJ534PM5fj0C3NuIlW5J/3mpb0LzTsYWFxTXQ==
Received: from BYAPR21CA0013.namprd21.prod.outlook.com (2603:10b6:a03:114::23)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 21:14:31 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::1e) by BYAPR21CA0013.outlook.office365.com
 (2603:10b6:a03:114::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 21:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 21:14:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 14:14:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 14:14:08 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 14:14:08 -0700
Date: Mon, 1 Jun 2026 14:14:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v6 00/31] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Message-ID: <ah32HoKvjVfnWyQ5@Asurada-Nvidia>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6224c4-cd3f-4360-f71a-08dec022c58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZTY60JJ6aqz2fbA6GeuhRDE8/YQXpLDmz62jO1Qnrc0WTLI3c/GzjlmINOwG+sknTKVTxAenCLYSNayKUzIWhZLPfiwAuCW+RB0xCqlCKLGFw5+VYp/RMbWmxx/n/rn7ix1gEY7DzMlYf/SWt5ksBP7TDkcSUsaIiROMDURugnKho+mIjxo9kj394izVagmo3XH6EfCwnsUXKU3dhqlYNi1OpO/Jtg4HE3iwzkuVHmoIfh0SIcWk3My+Xwtk5aW+9akgn2eYH/C8ExTYQGkkJKxWKtfJcgOZ+SqMhd6h9qcxneQkSBPCLgNZwr8iSfyYke4lyLzpPQLAIgh/oPXzd3/GaBaIALXOHOda4FUQSii58vlZOAbwyRgmumeKDGkZomRJV4C0ZF3jwn2wDafrnz3/nx5gTHGzzQG2gA5fYU7DyKhRu8bDlPgyZafARTpXukAVmgjBy5lpxuMcain0YVlYKkV3Ar/BV9ZCQfmjR9C0ffyyO0BEgyqTwDDrcOP0cCadL0cXa1uSHfrfa8yVud47S7LYN/3C1aQlPpCGLsL+dYdfsOKUoThfPAevuCJIFQl/yteahgtHdzAu0Jr7RCPBuPkKWHJ3muMsOC/Y2G+H1zInmAq7qM8XvTNs9f+vRlJ6lGPHJyWyHh2SDUiwIaKNRLRPidSoAGYNtm/1EiFJcbzjgJc6Ldjy/vTJEwR/GM8iy3f33oOw9mpaSghGycpRIp63bPAi9C1XR6ThIII=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w6mKCn/wIDycQIkgWa1XXZ5+YJ4+fPibWjXPUdQqT3hYB7z8NGz0UnuKFOn4sMVwM140EZc0yRCM62BseXW8dtekUOydMlJ7KRZZwuiEpynLKNj4CcrnijCO8ZynEYFdQ6XVMUjwZl/lKb5J1tVQ4a2Prx7AR4tftHcKK/PDprKXIxX6hws4MvK9E68j3mHswFcKAy8n2E0Xyi8rbtDTSCa+07EHI/wTO11OSjCqle/QIDWAwdNeslGRIVKCtMbtfUViqPv0Z1l2soE8oQCZohB3ByDLR5CcC1qeFXXafOGfQ6puza8//xlgG9wraSgo0+ypvL8CWhWMLzTN9OoXh/IIIvCbswKJ9ox4nnFLrE1ogVkoj8+TVjUtlhDNRbVCQgnTRwxdZ29Vx7/l4bOdndMgvDmLzvprHFDn+6q6lUSA+fx71iQ/+T8I0ikj5Xz3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 21:14:30.8158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6224c4-cd3f-4360-f71a-08dec022c58d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

On Mon, Jun 01, 2026 at 12:41:50PM +0100, Shameer Kolothum wrote:
> Please find the complete branch here:
> https://github.com/shamiali2008/qemu-master/tree/master-vcmdq-v6-ext

Sanity on my side looks good:

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

