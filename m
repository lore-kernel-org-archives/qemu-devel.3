Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC30EC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2S4-0006MM-FU; Mon, 16 Jun 2025 01:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2Ro-0006K4-M2; Mon, 16 Jun 2025 01:31:59 -0400
Received: from mail-bn8nam04on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2408::617]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2Rl-0006c1-2u; Mon, 16 Jun 2025 01:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk5v6DIwU71Bph93cKSWtvyaE4ihQAEf1bapLHaauAfgSS/mFKF5pjBDU1g58a4Pn3hmets55AR44VSNSo6ZAG4cuJhwOMwcY90Uv+qjOsX1iEVNnCS3IHz/s7296zbxJeu8I0w4GJSO72z+NMkaea/pL7SZgWvKPQi1vLUaX/vb07kVy7XWAEb8luLVvhdo+DAMOd/x3Sj0PJ7vXw0NgqzaQsdKLrvY9vZhjY7FUCfXHNgVovKm0lMkkBFXeQYrj6o+X9PzGRn4gsxoroOyCDYr7Na49GkGeFTfSaeWu2ikgMiCXT6n/IhGKypk1PWZa5nF+Z7pZ0kjdxpG47gxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98moeTqAnn59cFwaC70Uh9aLjJtp3WCJWkxqhNyO++M=;
 b=tScGexY0GQDYbL/X/F4+pSxwq0hAOABm6kZ3TakKrasRUSCPgRhl4lSPRrrha3R3PXcfu1sgUech9qOKYDNgJYfPx2PhEwGw5IyK6uSfHM/tpOD+m9JnG/e4YrVoJAn6dKwqy0YYN1rLe++7zwgkd86olEiZdBhArbBCUctmS0lJXUBosXJ/okBdb9uKBuGCC91rGuFV1t6BsKngc0wIJq1GFp7nGgHGTruj+0aH9tHwDvJUR6w3LCR4u27PkFdqBWJO/BrItWB8XtpYtjJFVtHIIC5GTgJCxvS7w/VEpoBSkG7F62Ua8etvDj82nFfEWRg8gbq8Z43RRhhkW2RimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98moeTqAnn59cFwaC70Uh9aLjJtp3WCJWkxqhNyO++M=;
 b=ORjEO3tOYrMwy2gH2VsUS9bXQLLQFEfN6Wb486q+g/nCTtJyETmuOHMdf2jJn4zdTwNMtDnDf5ap91bnIrMJxbhbQOW5ZnT+PSdmmt5jJV9v/U8cRMM0T8L0HvK06xI4OKQ8qr3EpDbz8J8BHqMHq6ChVhiMBPk+QF7skZ43K3Gb8r89d7UGEls692Qt9+VhWLWeYSMaCk7Gi2t2EJRfxH540S1f4Q+8/CDQusWd2pwefBCLmwLrV8k2SKvVlBGPM3JbNCYdi8ooHeOlikBJ/SUkmn+O34MY7QnBa39XqnT94u3lJjSN4TnJN4Bn35GCmq69VYaBgg2YjjzqvzFN7g==
Received: from BL0PR0102CA0005.prod.exchangelabs.com (2603:10b6:207:18::18) by
 SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 05:31:44 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:207:18:cafe::ce) by BL0PR0102CA0005.outlook.office365.com
 (2603:10b6:207:18::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Mon,
 16 Jun 2025 05:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.0 via Frontend Transport; Mon, 16 Jun 2025 05:31:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:31:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:31:29 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:31:25 -0700
Date: Sun, 15 Jun 2025 22:31:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 6/7] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Message-ID: <aE+sLJ+LfvIIngKI@nvidia.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250613144449.60156-7-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 5988ccf6-b480-4d80-c0f3-08ddac9713f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukSpZJ9157JNJxMuiRRGLvO3mFd/bkHo5hEllqFEhKEXCJfh8y415ark669X?=
 =?us-ascii?Q?zGd0riA1hvBSZvvdepwDASPsSTkZDlE/NrjyAQaXMiqIVTLOhfixdNQ9Brzx?=
 =?us-ascii?Q?DmlnLZmFVzkj4s4N+BCB7EBsDv9SyOYF9MWKjqaSHDt/uhT6dx/wti8NQ2Tc?=
 =?us-ascii?Q?pEw14oYV+4Cpfqyw3IWFyORhUSC/dP/rq56TvKIG7iXH8bleeMYkUUW0DPOl?=
 =?us-ascii?Q?yDHz0gWnlIsKXETETD7uzydPlcD6ajq7UqClxkynDHVdJ68hQ1lbZPeBKBkU?=
 =?us-ascii?Q?W+TLUCJN+D5sW2xjiv2Ct6mfK2Q7LukEAWjy4bJPB8AeUVmB2DPdN65Y9WX/?=
 =?us-ascii?Q?bAd3VRQKsM0Sof6m2NvV2onoJuGaECrvTAv/PhzNFnWn2lteDyA18E9sWzq3?=
 =?us-ascii?Q?8wJPRXMXzxAjX6YzvqbfYXy/yAQxY2EimEpsBXmMkcw0BQhPMUk3BEGpYlGB?=
 =?us-ascii?Q?VK0hw/ckzpRIAAcf3bshgMW2xw8JuqQTLaqsa/rtZTuRK7OnRmwXQRJFTlvu?=
 =?us-ascii?Q?Hp1YdVzxbtEYIJ1Afm6hbdJUB8wb9eQplHwMQZ/li3vZ3OTadY3EPR+XrnxV?=
 =?us-ascii?Q?CM4Xyz1sBOM9NInSyJ+ootsSRYBosVLWDnveWKbSPkcuHlV19cVOIK1rh/AX?=
 =?us-ascii?Q?dugc+w0mgazPb2PaBqnv8kjzzhdq4Gf7JBO3PNRXEK+h3vgjrME54+W8BW7J?=
 =?us-ascii?Q?X+E9c/VmYYwWgD0AUf4WG3KZ8YQ8nf/MZBr6K0DrZNvDcNYkwEWE5RHX1asF?=
 =?us-ascii?Q?SCb0ENZ2ebeUMuyIVeeq01Jmsbt/geu+OX5NqJx7QAjpetFtfo7yXRByPJTK?=
 =?us-ascii?Q?vNQSpg8R/Egr6vlSfxyKvQ1PfQALZt+0YHjHzFVb57ZxUWWBXngl9ead8fI4?=
 =?us-ascii?Q?Ft5AmVSULP/qg9qbOzyD4q+XcaqxSkscrjEYd7T3IHnfMieSHt3YxSGRH7hr?=
 =?us-ascii?Q?ZwpCuZHpszASAaDafIem3yIrkQf/yNgvo05tiv/Lr/p3d6JOHzWUjScCk5FI?=
 =?us-ascii?Q?9SLp53Bu9/ZCOfL+4Lf8BAAfVqMDB7uGRs0nGfTuhFhO6GhGGZW2MCbhMp1g?=
 =?us-ascii?Q?ggqqsbIbhM5++/Cat+Fi+sths3j7wtLZMwufxX5W+1caIwYBc5nMNNKe/QOC?=
 =?us-ascii?Q?PxIPJDmW9xUpp3NJflsT5k0fwYTew7D2PPTcSXFQxydvBvB7OTwT/biCD8xZ?=
 =?us-ascii?Q?WAEmUMfU6zaiweofxiqmyp/9yEqKO/5dYKt5Z3cTebXuJOklwB9dU4VsJfgs?=
 =?us-ascii?Q?P+FmeBMBYtwrhswAKdgTQvADC5/3qOQ+vbYbSawes26UWzlxDWS2U1UG9RHs?=
 =?us-ascii?Q?dEwcTwFmoFC4na682sLIGbQ4t38lNXGbBsHYWzBJZG5MNSfJvFPZzEzlAkW9?=
 =?us-ascii?Q?ITBkSatd8KxxjYxuBHmzgLmSInqU5DxzIc4wUUoqszgvaLaBuDqt6QeMwekV?=
 =?us-ascii?Q?vARP84hG5erdrwFmCMV2JNK+d5iKOKaicTtXcU35dryNcp+i5w5omnLz4TG7?=
 =?us-ascii?Q?IlxmsF6+0OFHoacEixdUPdNaWFF1iYHU9Ohx?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:31:42.9209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5988ccf6-b480-4d80-c0f3-08ddac9713f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
Received-SPF: permerror client-ip=2a01:111:f403:2408::617;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 13, 2025 at 03:44:48PM +0100, Shameer Kolothum wrote:
> Allow cold-plug of smmuv3 device to virt if there is no machine
> wide legacy smmuv3 or a virtio-iommu is specified.
> 
> Device tree support for new smmuv3 dev is limited to the case where
> it is associated with the default pcie.0 RC.

I forgot the detail for this limitation. Maybe spare a few more
words briefly describing why?

> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

