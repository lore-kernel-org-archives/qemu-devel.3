Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0EAE92FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJOG-0003GH-33; Mon, 29 Dec 2025 14:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJNS-0003CW-8P; Mon, 29 Dec 2025 14:58:02 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJNP-00033f-EJ; Mon, 29 Dec 2025 14:58:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWpC2cQIvSl8L9ZuQhDHxqDADwyhGmtisfeSUrlcR5heFFhvy4PdATxdwcz68Pvo+hcDnPuWMaLYaynar2JJzf6dmfm4zXULrdmHGj0CObpTI1cma0NLIbT95mS44y4uKEKFMGri3tPnPWj7eOiDc4lihvq15KQK/zebQDrFq1Q4qj7RqQXf5Q17p7qfgO5zNbo1GiinJVYDjyymEntI5SIk6MMF6NHCC3itEh0h/64qjR6yLZJh9X+e+o4bDcwZrO++BLHza1QJXjbT+5WWEGop8QDrj5R0WSU/SJ+wpV/orPUiX5lOfVk54CRQz46teYLTw9vVohHt/qRYeuO4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sl/umNwqePCuJsZiAqEF6xfjmBlSD75f4jE6SFexSc=;
 b=QHV2tsCzpiyoyoIkYCMZqcMA915kmHcdKV1i60R71zLhYW+px5AtWQJ6OxNUiXgpjTvIu/GXlR9MQ9ned2kgfKGIpg1QjUOnW94hg3wYgvUOe2IxF0bRN5nk2aagKlN+EvjWlVi++VZroYIUfE1i4qt/9dIa+2SO2hXrh4q7uID4dSkYOFTnM8sCFUwwYwChjSMJPz0WCrbv4jDwo3hIUO8JBD8K5N72vxD+x6QPumUnuHrLyK8S/5LTL1lIurwICvxJ3oI8srxv007W6x/qgqa1Gop4PBV68SmkBXRuaB12pZm5xX+GOvgQbtlkPffTv63g22PRWMit5JwheviZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sl/umNwqePCuJsZiAqEF6xfjmBlSD75f4jE6SFexSc=;
 b=NZ4FLYHEzmdhIJgXviafhU9/D7uMIQbbxEVvqkWct9k81fd8btxBKQAsl6uOPHUonGT67aX7/LDU3qaUHIuTFeCxXEzb0b/cTx7GtHkIu2y2H/cS8su1rhZn5XUMVpJ7SOc709zy7Y7xQ8gsyLITZbNhOJMf5gTvUQyhvgO93b8jT6p53rAX9xCWULCvwCGmSK9ImSwtGud2bWX8W9XpHLbqe0wTJuK7BgjGcvUtjYGGXL7hGcEPXl51eINA6eZFZJYiyHuebSdiOIEa1BRz6puYMVXglg3ZWdAGo10gG4FBXt8o4QRFj3MKDWiPkDhD4n1ag3m+zM2eVz16iIrW2Q==
Received: from PH7PR17CA0010.namprd17.prod.outlook.com (2603:10b6:510:324::10)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 19:57:50 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::34) by PH7PR17CA0010.outlook.office365.com
 (2603:10b6:510:324::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 19:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 19:57:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:57:31 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:57:30 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 11:57:30 -0800
Date: Mon, 29 Dec 2025 11:57:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 13/16] hw/arm/tegra241-cmdqv: Limit queue size based
 on backend page size
Message-ID: <aVLdKDmjSmbDuRzw@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-14-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-14-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 127e7ad8-3053-4117-59fc-08de47148b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2UgZYqpvC4fzWA5wptsT2JrW/+r1VjUwqnegJeaKHV6WG4lSwe9LPLkQ+XWX?=
 =?us-ascii?Q?NkJRL6VaXlALNu6o1Nkx2WOGTqlOYfN8+h4dP0apXVbhixSOLCW5c3yw2k/s?=
 =?us-ascii?Q?iZBT/zJZ4VcdNvVKR9wptIX44WOq7+u0L5+JeiQ8EVJUyfsGicBEe+XZY4n6?=
 =?us-ascii?Q?XX3BExrnxw5mtSfeGi6uaDRCXr0H/gRXZKOcaLLTF1C2sH4sW+1Hy2Lwv/F7?=
 =?us-ascii?Q?+mgDjkRajbTkkO9s9MYAUVzgA2Zd1+bFZhSL/miOYfjwZToEOrY37jEmiz8f?=
 =?us-ascii?Q?kO/0UOrV3KVBU+iCND22djN6Ej1TVp2lfFH4G51AWTeHCZ+sT2/dOCxmGaKb?=
 =?us-ascii?Q?pKKWi7wXwgSVbuIPVugUyYlxIde9NcJqUH72MnP0QpY4Kppmrg/X55cP3xZU?=
 =?us-ascii?Q?p6tUVf5kCyobraPRmOWTE7OQrZryS77xXfKP60uPW4CWtqhThGWgweRp7ZQ6?=
 =?us-ascii?Q?QZbIP6bxvQ3s8mGkN2442FRu8uNOi+JM5XU1ggNo+50TqEHN5u72Lli20Oon?=
 =?us-ascii?Q?PKLIwmnjgLWMRn06zz0uq5Ixt9WH+uBAm6gYPuZ9FbIJVc3uejM9RTi4y1z3?=
 =?us-ascii?Q?b/FYec64pqKkQ41HsJcyOa5juohbk9jAsR7AESqbGviNZ7kW6Rb/azR084Vp?=
 =?us-ascii?Q?hSe+KEu8g6npYibEwVuft9wnGxuvOpnhW21qR0lByT79bri4IqCOLelATCQo?=
 =?us-ascii?Q?kD4QDV1sQNYiKJ50YkpU9pNUVTnCZr4JGgqJj9er42q34OUPrW7/CLBToQdF?=
 =?us-ascii?Q?gnT86/lcPQ9rsphfCgkfr/PSnYgR8WTmMxK5C/xmq7PMjOnPn5HZkELSQU8O?=
 =?us-ascii?Q?m4F0/Iyrl9TBjp2E0IccsYtMwfNwXgQdvq8uZ3c9OKGTL4UD6dKXqqV60RZR?=
 =?us-ascii?Q?hMYa8G5Y3z1kf/qStgO+1lmjz58oNPxuZ9sBevPUvNtHZXYzq0oUj2Fhjj+A?=
 =?us-ascii?Q?Thw5iPQgB0NOyoTqAbc7EL0Aee3PIxQXhWfGRlVE1vVIAf718jByHYZDgM47?=
 =?us-ascii?Q?adcoTpba7gID1CIPlknHX8APoJY6tePcMALLFSfIooweOVUmzE42vIkows9h?=
 =?us-ascii?Q?rrdSBEHGp69REfK4W5t5MHTgQxmX8/c65oYJw7PKyejdYwCnSc+682LKsbYO?=
 =?us-ascii?Q?L6OygghC0fj0sCj/6S0yPT4SXuc/KjJy/TRG354ZpxAwn2+OuCFEGqPd969D?=
 =?us-ascii?Q?8f8+D8FT/O+rq4d4FComuca9fCO2BBBSG+xb+bbtt2ssd6kZGg9qagcNqhOU?=
 =?us-ascii?Q?BfKmcH7RGGvOlzn5F5Ia5yRt3dPFErYKhrnDEYj/jqteeQn9UhXj7op0/dL1?=
 =?us-ascii?Q?YaV5zJr5h4qpu+NZZuiRR4YdKJgM2vBzgHT3pyRGG0Isew9DtpGxUXZSk37Z?=
 =?us-ascii?Q?toBV26tWQvdBnlo2N+n5cTgLlgn7OVDLC/eLqws7KvaTQAxlrHBuzQNT4xC+?=
 =?us-ascii?Q?ICDkJ3kqOoIZ21RFJ6uMD2vmWOrg5N45b+2JsEHeFanhH/zhjsTV7WGSv2qc?=
 =?us-ascii?Q?/3zx/Kp+Jy9jfNyQUl8tPWwPWROuG14dwmk1Gt58NicUq68klscm6QZT3STg?=
 =?us-ascii?Q?Zv9GoILVeeoNCrcU9po=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 19:57:49.5971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127e7ad8-3053-4117-59fc-08de47148b70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 10, 2025 at 01:37:34PM +0000, Shameer Kolothum wrote:
> +    /*
> +     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
> +     * queue fits entirely within the smallest backend page size.
> +     * FIXME: Migration support requires this to be taken care.
> +     */
> +    pgsize = tegra241_cmdqv_min_ram_pagesize();
> +    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
> +    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(log2(pgsize) - 4, val));

Let's mention it is for the physical contiguity of the Q memory.

Nicolin

