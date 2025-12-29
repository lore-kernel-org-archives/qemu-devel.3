Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C1E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ9P-0006Se-7w; Mon, 29 Dec 2025 14:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJ9N-0006SO-A5; Mon, 29 Dec 2025 14:43:29 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJ9L-0001A8-LB; Mon, 29 Dec 2025 14:43:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqqzXz/EQxrWAizP7gH7nRny9WA8RKClCE3Q/X7U5eKrAws+75SMtKvbJvn0IRmMnGPQASSZs36yqlQS2Gya74KNzK+xNNROHCxmR0Gwfs0Q70vFqYbnQotd0/pkDOwpNjaaRiXToAUOOX5BhE9NpN8lSZMqLRhIWnPMmvn6hI8lv1SHh0zq+aw8djCO8Wz9YTf4loHu6zLcSAyWZonoK25tWVLHOjhT4SppoXswmSjF/MTuOQObHCD0SqBfC7t15z+nu1mw2KOfhXOqAHgvvDwsGNhDhY4PajiRhYGsxa8D6cpyyEUymrUnMm40OECnRnYORj8X4l5/41DY9z78ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2cnWc27lA4cJRHnTGYZGnXTcj0AtAXQJK2fmQ/dJtU=;
 b=aBdef7Izg+fG3Vp95V5T39hUe4OXF4/Jdhjc3xqZ3VCcg27muGUBk0TDTCuiVd+C3RWBI5RIC0b2jj5sH8c4fHeEAa76hxx+WRQJH8ipvKCoAAyGVBOuFosPTWYQUfNJcGlxpRnEwXlYzp5wJgQAtO6fYWlfCLz5qN2gI3HIXnO3UOX7tx8Bd/x/17hYiQ9/EODDRxIarbN5YQTlzi1kOhxwEpDiFefUlIb50LVHTvT1tqASvp2yo5j8r0Y0QweW1JHDyCz+xLfYfY+hrRFFxoo57GpyZGoUQpVQQicad1M5QkAHMVLju7v2DZNwQSFKHhNIDesvNfq9uBX0FH3n3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2cnWc27lA4cJRHnTGYZGnXTcj0AtAXQJK2fmQ/dJtU=;
 b=OXpsn0gfUX4XfMd4miHogjW3uXOkWBXn426mn/yS7h5EJrUZSUOpj+jLWNnpQN5oUVDTNQ2s9n2o7/b/Uc5eFWlu5xXTryhVMQLrz9twSwQ3oXswqlMMFeahLAM7uPqgiu++Vbo9upxgvqLCcD4FG+JUiJuQEk8AYaSUKFcnU/OLbDlwtWpEM+6MC7c7p09qKFmRh9x3pxrDoR0wi875uDQntWOCuYVPJn/VQ2rv70uPWv89poT4Hiwjmx2qjYwIC9NTTLpLy8oxymVesBTEREQd3fvDX9lyXFzJB2roiKE9k1ei7BJUsXYh/sSkcl0E5ef/2sd3a4d8CB9m3Zhs7Q==
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Mon, 29 Dec
 2025 19:43:15 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::8) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 19:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 19:43:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:43:05 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:42:57 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 11:42:56 -0800
Date: Mon, 29 Dec 2025 11:42:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 07/16] hw/arm/tegra241-cmdqv: Add read emulation
 support for registers
Message-ID: <aVLZv+nwUB7+ohuw@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-8-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-8-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: a4102fdd-2e55-40cd-3961-08de471281a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OV5xTxuaT7l/tuvzNQfrde6B2AXmZcLz6RbIenZ/IQhrUSX31dQZ6R9PUcJs?=
 =?us-ascii?Q?uUUKieTSKlNX6fTKPIuBvdtCzNDiTkHSdbY/dpbrp+c8j2YnoVrZRpTPc8HS?=
 =?us-ascii?Q?TBJ1NtECeTzkgiUNpRxPmheXUwt53xjt5/yvywXSu++nxHHkzdIU3ru1J2lj?=
 =?us-ascii?Q?GpUkPiKS4nYhK6dNDz8otZn2bd4JbGnYCowFGOzrNZUSXagUywt+uP/Hw6XP?=
 =?us-ascii?Q?Wq88Drxpkn/F+43kbFhzwBJn770k0/VwrgnY5tEUymnRnb8yo0RCR+zFuqqU?=
 =?us-ascii?Q?/No4+++86D15tZfHMy8euTg/QphG/ZO4rzOHeJhnxCTTKKWR1NQo5D0Hof6c?=
 =?us-ascii?Q?tEsH/DpwkUcV+9SkRPNaVKVZRgCzoj69c+RCqHPKTq43NNto0FoygC6WBOOk?=
 =?us-ascii?Q?EzfaD8oquqttpwXJ49Y0lzkXbiMlq6n6c5Gpfl0JzubYFssODIMvrLYWdJkX?=
 =?us-ascii?Q?qsCf1LS+7QACAL3B2B4k5XagzybHUKR+twHRP/3vVzGDI92BDya5Ve8Zt/T0?=
 =?us-ascii?Q?OywSStj4R+cRXyo7BdAAifh+ImKGtG1gxW40MnIgR3k7hluwvPDEs4MZMvpB?=
 =?us-ascii?Q?fngUDrDnfUjhmYGvmaymHbS/huLLL6ENsS4cS6pi669NzXOaBs2s0VrqrA4P?=
 =?us-ascii?Q?4O9hQ5eFyw1f1du60Looiz9JXwRErkOL05WnISPh4ka51SopFlzca4G5ZUwQ?=
 =?us-ascii?Q?7Iu4wP8fVVx8VgAmioH9MM1bIikbYdy0sDl3d6FL5yHKj/LUShbho+V6Kk/s?=
 =?us-ascii?Q?e5mQOF9RUfcRpEoD/Bw4mWuJzw5BvgTgQPQ5Z65QpLy5fUVqRyKcpeE3VEel?=
 =?us-ascii?Q?on3ChVRU/bNPNtIzJw5KQjWQgIyMugCzFzm3tTpVcSohNQ9Yt5xttB4y0a9O?=
 =?us-ascii?Q?A+EK6xk5h5e6A+izB9J/ShrNaHclB6AZFykkCzBuVDGlRzhcl4ccXUb3lzcY?=
 =?us-ascii?Q?0TOa98mNYizooL+zAe1Ejx37SG3N8ZetWbGKUHjA9GCtleMO0QrIM2XpZLGm?=
 =?us-ascii?Q?wDBv6Payd93V1nTw8wkrINPwe9i2xcvNSmxMYEMWIOopjC63EzvPqyV8IF9Y?=
 =?us-ascii?Q?IBJl2h4Pt4EYgur95Vdd27yLAjYF7wVFfRwdlOhCCwmKH9BQH31DcpL6QKuf?=
 =?us-ascii?Q?wpPPl0FimvMSshXgDa+TSsJjSLwVry766+k8N9Tw0F6ZNy8WeNezxMZCBb8C?=
 =?us-ascii?Q?Xxp9bdpfAvBQQxAoAaxFQg5z1HDD40lSQAykQX2b3xn/q/rSA1hp6XmeIJhd?=
 =?us-ascii?Q?b5P8EJC2jWuMN0frvHYLLrMVf4bBRkRXcEb4CWteYqpR8MDt5uXFZks5m1/W?=
 =?us-ascii?Q?B4MSxecR2Df08RluXbHoodZ26Ip9DfCoqUDwX1/trWO3VUIeBL7ywG7SCgpY?=
 =?us-ascii?Q?ro0K1ntz/WQvmNEsf027caejl01VUAbry5HF0ijti0pyYV6KmvoyPTNYfKma?=
 =?us-ascii?Q?iJ5uds6iQlJD/NEkOZdbS09izOvQYnizgTNuWRrrI8/H8k2ZaSboYiMMVx3F?=
 =?us-ascii?Q?9S4l2lfuR0dAee0BfwcEiirQNHK7pv60D/MekQkPRLTrg2MWaAHYL5XBLq+9?=
 =?us-ascii?Q?dLdMOKdcV/WPl/ICG/s=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 19:43:14.1681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4102fdd-2e55-40cd-3961-08de471281a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Wed, Dec 10, 2025 at 01:37:28PM +0000, Shameer Kolothum wrote:
> +/* Note that offset aligns down to 0x10000 */
> +static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset,
> +                                          int index)
> +{
> +    uint32_t *ptr = NULL;
> +    uint64_t off;
> +
> +    /*
> +     * Each VCMDQ instance occupies a 128 byte region (0x80).
> +     * The hardware layout is:
> +     *   vcmdq_page0 + (index * 0x80) + (offset - 0x10000)
> +     */
> +    if (cmdqv->vcmdq_page0) {
> +        off = (0x80 * index) + (offset - 0x10000);
> +        ptr = (uint32_t *)(cmdqv->vcmdq_page0 + off);
> +    }
> +
> +    switch (offset) {
> +    case A_VCMDQ0_CONS_INDX:
> +        if (ptr) {
> +            cmdqv->vcmdq_cons_indx[index] = *ptr;
> +        }
> +        return cmdqv->vcmdq_cons_indx[index];

I forgot the details. But this seems a deadcode:
+        if (ptr) {
+            cmdqv->vcmdq_cons_indx[index] = *ptr;
+        }
?

> +/* i = [0, 0], j = [0, 3] */
> +#define A_VINTFi_LVCMDQ_ERR_MAP_(i, j)                               \
> +    REG32(VINTF##i##_LVCMDQ_ERR_MAP_##j, 0x10c0 + j * 4 + i * 0x100) \
> +    FIELD(VINTF##i##_LVCMDQ_ERR_MAP_##j, LVCMDQ_ERR_MAP, 0, 32)
> +
> +        A_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
> +    /* Omitting [0][1~2] as not being directly called */
> +    A_VINTFi_LVCMDQ_ERR_MAP_(0, 3)

The indentations at 0 is odd related to 3. And should fix all the
following macros too.

Nicolin

