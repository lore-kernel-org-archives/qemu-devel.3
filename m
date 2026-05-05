Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DAEFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 01:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK4Yv-0002kW-0Z; Mon, 04 May 2026 21:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4Yi-0002k9-8A; Mon, 04 May 2026 21:26:49 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4Yd-0006uu-42; Mon, 04 May 2026 21:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6Isat/VeVm2Facq4cW0GPHfMB7n6w6B4N8DoydSjO8yjO/oQ9nluujvpGwbljtGhMOamBjJDrrg0rv1mrNKZ2nHM9kYsrgmxMpYKJGb4iJ0OrQ4czQ/GdaB2Ni7gAEdRaRIgl2IC/8u0wx61voG0B7iy0OUYM2AEm0Fk+n/rykrNU/0TF3Yh0ra2jJT/Z1Plf3TTkI1MTWd7jVWCOb5f+H2qKNLZZ0XqnumCh9a/g0ojfQ7L2mro0qWP3MvX3gPkBccUL/n/XdCSeSVxDpdmdOdcreWWTz+Hxh4Ui3lEAegeGG7/CjIgr3O0pwkGTsmNr0h9Hs9ERQlmX1doxUq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC9gK6sVK4SQcFHNXdoLht4Hk0T61JMmiQSDUl2UOWI=;
 b=sUBngt9J4h+8yC/F7ow+CeVME0Sag6jk5nDbtu2rbA82A9RPH1r5Q0fR7ncyZscSIGvHiAoljqx8DI+bErXPFUHGvGkbPycOzzCS5Zzv3rXZO+F0L4yOLB20SDN/rd/lq3ptkRkCuHrdqEQHhBF2LlPNgnkmrka3nWlYFPzIe6pZjQvnrnwFnbfwlL6Z1gfoCMyyIoXVpaZNF55/7t34jT3DmnQJjDedcxQIyb7pEGYm6Gx3ec3emhiBz9ax9wv79a/ZgJzzjHNm9N/k7BQC12iZzrHsuFYwQmywAqHb1CjdS7AwD2czq+WJjLWI1gf7n/OMlzrQQlAEb884FrW9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC9gK6sVK4SQcFHNXdoLht4Hk0T61JMmiQSDUl2UOWI=;
 b=YkVrVK8n+lABzo0ZHWIlTn3G2xTelmn1QYWJNYUMOM4d3ctsZzlTsiT0jQFRgXzOJx+Qv8b8HqNZV7/x5U/q4RiWEfBIE00NzScn68aiaUDSNFHx2EHhuXeGFrN+3s/+bUJHcdmJr9UneDOgJ5vx8+FAQP43x3qvxIVkkqJX3X6fUnqO8vY9FLbDTnQX8wsqAQzyLe/tZArchdN0yO5AVBiLXHJdxQiDCnmXwk15pc1ubgBZahv9ygqbTvHiop4dwcu+Fzodq9iBWx4pV+GKq6Pif9IkFMrQrt6VqdPYPg4NZfK8Xvy1OxwQ/VG4ziMssRCq5JGdRBpB/92L3hnuUg==
Received: from SJ2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:a03:505::15)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 01:26:28 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::63) by SJ2PR07CA0013.outlook.office365.com
 (2603:10b6:a03:505::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 01:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 01:26:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 18:26:23 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 18:26:22 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 18:26:20 -0700
Date: Mon, 4 May 2026 18:26:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 26/31] hw/arm/tegra241-cmdqv: Limit queue size based
 on backend page size
Message-ID: <aflHOokSSsavR1A6@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-27-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-27-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c54e6d-cb8f-4c18-0eae-08deaa4554af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /dgRM86m44qWDetQPN2uP03Buh3D4FYJyhDfX66NcdygWRdg4o2cVQUQsDnpLjvPumTccwrmX1gIZsbiMef3Vas0LyfY7zlQCWPWxVuDVnoddNSo8eStB5oIQnL85v6hXY23CgV+5Iz0taBRS9Aw+Zk4djI/xh4xi9quc5Jf6yoylp2yyTWcuceLnDpN5fZneel2xnKIwqATd+Aco6zN19EvcfrA8r0uF06HvgAGq4MzgGYFWanE4cwN5lisNt4Cj9we9QkRJtqmpBEJPn7ULJsayVqKOTRe/hkZGTBJTgG26vUZBDX7QV7cOv2+6Vik16GLvB/I1KXjXZu4a5KW6AyXoWxwTQGEQQ9RSkeudrsw61yoY4ASTES4MfuRAakFZ6+Moi1HeilwPW80XQ2JMcYoLiQGTEdBLfy9IQbkmniM0T8RVj8WqQ89cC6OGHhJgkLNwsnA15TZSreLI9ukICUCa7GGknlUHMQnnYBB+UW3W4Rpmp47gbq640keh4T6Xgr6QQX7ErcP1SNHKt9zkejo/eaxjaJf2A8oekaJGpxmKw5zwmNlDU+2oOGfHUEUkAfbDckaLXOZKMAFt3CWBeu7a9CM7fJw/TA1BqMuurkBBhc3TN9rgMFeCq7EPzvx8L/6syKpYekDjm9CoapruwBbuOaU5O25mc5fUgtO++I3fnub0g5CQCyVkUUJ9mHK2azz9gCI3xFXyeMJFYKqPVGoubvS2cs0lCiycz9O9es=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kqw57JiMUljVU2Or6CDjA03hslHFT/ZycEqWmFCuDszrNKxBwxdoSfsmMyQ0rlJ5ep+tsL9zCkri4pfGSyLYz1DDmowmDpIR6oU9wvLBj0PVuXgWnxgqIlXAw/KATRldIWaQ+vTz+RhbjqRYfX8s7GdGOhm98n6kaPbbzIokZfAB/2256ZbDtv6KYUXutjnu36rkJNfFF1Rz35K9+joHkO0R5AdGkJm/07gSVAqQ37uLf144E42ap5AR5FsUu4pOzxL5cGXzPpBuVKoIkY5N/KX0BKI3LSI5olhD18XxT/L+WhCp1zHrqvWLtNHq81B++4OSC5Pp49yzDW2i10m1elwb8LRWhZYsGlxwLcqePkjXWTCllwhczGoohRjwBtc8vImPV8ZbySIMWcOcEsYxXrZUm9ciVPleCaNO2nfgGpoCosGjDqKX38kl07rfY/5H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 01:26:28.3204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c54e6d-cb8f-4c18-0eae-08deaa4554af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

On Wed, Apr 15, 2026 at 11:55:47AM +0100, Shameer Kolothum wrote:
> +    /*
> +     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
> +     * queue fits entirely within the smallest backend page size, ensuring
> +     * the command queue is physically contiguous in host memory.
> +     */
> +    pgsize = tegra241_cmdqv_min_ram_pagesize();
> +    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
> +    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));

Might be helpful to add in the note:
   idr1.cmdqs = log2(max_qsz) - entry shift

Otherwise, lgtm.

Nicolin

