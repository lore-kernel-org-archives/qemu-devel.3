Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0381ECD6D6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 18:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqEde-0006jw-Ir; Wed, 11 Feb 2026 13:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqEdb-0006gY-My; Wed, 11 Feb 2026 13:08:31 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vqEda-00027Y-3y; Wed, 11 Feb 2026 13:08:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhEVXZYrZxOK/QTrA03Bq7QZUAJ8bHQSqRet0fx4eE6E/6H73ExCEy8N26Q81BBkG9C4ItBuNz54Z+Cv04BcpHq6rmLrIMiytvC/7XsQ1lwVCDkSVMPVq1T6+4NRCVUXTRmQA+YtH/VgAPrUn4FTvO7TTRE26wXwW+M864jx8+ZEgS1k7AiGmSyXqrWE7SAK6t3AoAM0bl/KAFgQcWXzXWlX/HcDWO93LNilDnE6mRYOa364zgPxOFHHGs5h/0eVBGqNQn0Jh4oI1o9lpBElLRsCKpX4lDwqS1LvyniN9BND62NbTNCi1nqzjVFTpmtxmwf4QOwbtw1BjZcHsh6eBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjPHmehr1lh+gejSwSGar9MM5hW0KwDjTvhklMJnV6Y=;
 b=bZ+4iHXyDxGDVwRinv8VdC0Vb08SS/xy0mZsc4/p2NN/k66yDZXfsJLuKokJg08+zWoRaduO1TQ2gKxvjaCyqrMFbqL3wSI8iut0Ra39a/piAWVPqVpgsmYnSBhy7oPnZZkZAiMD9KqPoAS/c2eikGrJCWTWnpqs9LDPnTCFppaSOS29CUmF/0YtNfpecZZ83IzR0DwqET4tjhDLprAjXPKmNOEIGV0BLCIIpeCG6yddZwFyYiwdPoZJ6sPewHlLIlN8Aq1njIJbyVA9UC7uMQHvUZlWQZa9vKHP6cZEhb9XN0hB8iXV2vo4eiRStQuG67rGSlUdAO167UY81BMbvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjPHmehr1lh+gejSwSGar9MM5hW0KwDjTvhklMJnV6Y=;
 b=HJhcoBCiyUp3FlIhAtqu4/ejKSlRkfUftkoCsSH3FaKFsyv+o6ixt5g8/Av176TVNKC58caZzOoSUrz5f/ucofFPTUFP3+h/NclPbD8u1b3lNwknHvdODQaAWhIgxL1K58Br6qRwskhfg8vdEfcXwuTplGq4u/xeNHLo9l3XX4D6zDhInnX6n+5TOo0C/A+GFPN0osJCaUvjRmWIIlhzg9USWh92senreHygzTLPvqDh4NO+EKEV2WgqDtmBHzbS9rUJqpeUWlAjQiZtVhBlYg3Y2dpQQbb0qbs+WAi42TMmOhBVsWjcxDVXYpaKNEJkKOaCNu2c6iFKndhm5KigFQ==
Received: from PH7P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::30)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:08:20 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::aa) by PH7P223CA0029.outlook.office365.com
 (2603:10b6:510:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 18:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 18:08:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 10:07:55 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 10:07:55 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 10:07:54 -0800
Date: Wed, 11 Feb 2026 10:07:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Message-ID: <aYzFeMh1szhJlJJk@Asurada-Nvidia>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260211083415.133534-4-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1c7988-5de4-469d-6e2b-08de699889a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zQ5w9UqHEEfhVDGxKJ8H6GH/jiAtCIaqI2thOmO0ty0kuITjEDWCRjVl5JaP?=
 =?us-ascii?Q?u5/6Q7TavxDlxVuYXjD5f77+/SYkqxFenvPQ0klcdXAawvCdLwCYxs5Pcd1h?=
 =?us-ascii?Q?jWC9O56/ioIikL/BXi6+OIW37XsoeekmDkJAeRvlZ6g3U5Xx0cAKTCEmk9dJ?=
 =?us-ascii?Q?7s1A/gj3cyeGAfR59uwD/XsEmEWeHFhuz+YUlWTtU5RkRzSC0aF9YnofucU8?=
 =?us-ascii?Q?Pk8E2zEihk0uRJhvnUdtHxtw2m2WCbMIoJTxw0ONrfvAS57NMFGbsv/ZLJT5?=
 =?us-ascii?Q?EmLXzfYxXms12kbGr36cy+XjwH+2itUI0TduQvGkWlh9FyeLOr8jCirkDedK?=
 =?us-ascii?Q?hpbI32EfDBH/UQAVOGA15Yz4y9NQE/LHN802NhrIcgXxIySK+YAAV8Y7OxPT?=
 =?us-ascii?Q?K+6et5IkIIbCpl31Y5JA5t35MozG9QMq5Tc0mnvao9ouyfeH+qJeqOGRf4Dw?=
 =?us-ascii?Q?hepVzz2QETt9LmMWingQ+y8ugqoMQxLsKkmBmCFvpfuKQS2H+sfI9n9rqyOm?=
 =?us-ascii?Q?em4YR3GQWZBQSDki5O1gL6Gc/XIZmHzWvAD5WmvdCi55Kp9jO2WiILn23fY+?=
 =?us-ascii?Q?C8ys5y2LtaapxkgPsZZ53/B5doxgEVLNFmc5JE+L3ZsofpY8UTIX1BDoeJTl?=
 =?us-ascii?Q?nIOr4MUYikaM68ybckGVHkqKzmuyAZbDS2ghvbchYG+fOHr+YV4oJ8gEr7Di?=
 =?us-ascii?Q?Edg3Xxsae7E+nBcy8X6TgSU3G8tfcOD7Hvou4U5WkcuGNjKxpkttZNMIGr6m?=
 =?us-ascii?Q?NG+DD8llPasvqbAanhGbeeA1lGMXu5xafMD34qAkZzm6KoXnNjgrmWM8Uym2?=
 =?us-ascii?Q?pqBfi49s5+6E5SldiSplcVMIYtSVkuPm5L8jmkAOJLH/vebCzCOpE1EoO8QB?=
 =?us-ascii?Q?vy3RQxzIotlsrbNSx94KUveBbWlcr3+DmX4AquO/TOwgtO/dcULpu8tMVaKY?=
 =?us-ascii?Q?tKhI+ukMBiybX6yotB6P2mLmma5LfYbFqf2xfnLNeHS+88V6OBB5Os+vmy7G?=
 =?us-ascii?Q?6t3EimiMHIn14AsAStnejCnX1wp8xdlQCnFVhFHcV28EkBa51F+98hQ/Wx8r?=
 =?us-ascii?Q?wohyPf4AEMRU3BUjw/r+CNKVtaqNU5Yg5boH4RW9lNGh4UzAhY2ssaoIvBvQ?=
 =?us-ascii?Q?COfwhMGEHRpUVmyIUGeGxUfAc/vtxLAssjaY4kkQGU3NgOmKyIfi4V0fAjhL?=
 =?us-ascii?Q?vrEH5kF82i8/C+Ln26p/AcI3HJQnxVPUhZoDZDs3BCYfh1uQ+OZtm8fa191b?=
 =?us-ascii?Q?g9ad9gOLQ3ZqHx/qL7meQADDazOfDa+Y6Wly4+vuTMh+ArtpveDpXTLtgFs4?=
 =?us-ascii?Q?xo59/ESI2ezIjEitS7JRXl/15RfKFBuwFMqGKEOocm5CoOmmCAx0FiPICMau?=
 =?us-ascii?Q?gtFcRxz6qzDROWN2Yeby1b7zLoFN2Bjr1/tWRXZUhL0FbRq+eea6a2G+g4SP?=
 =?us-ascii?Q?U/acky4PP3US0fzc/8lX3mZDwGvJjyYUK4Kka/ScakjoNMtjA6mJP5bWcdRq?=
 =?us-ascii?Q?FCw/K+w/7iDywsObpp1TZ8tQln/1RsPe0IMjWraryRR/yO6xd4LI/Ko5yE70?=
 =?us-ascii?Q?sR++KKb1GKnmto8ePb6rU5+6fScr1uQkoYXE5zentc7NDvwkCW1+lmIZyaAB?=
 =?us-ascii?Q?nMOEA/s39v0S1YPDJ2ZEocRGBFEqaPNukSninCClekYHC0tB6eyUt1EXkvJU?=
 =?us-ascii?Q?ey7Row=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TJHJLrL7Q/lDTO1m5Y/m1DDDzrRzFryQ8/IDPQmvtL1Ndb8adZX6MG7krWa51pfqhS3hA/+aATz80Fss/Kq5Fc5+ZQFo08k7BuybDTiNcPzlRgSlPxsktUhESajTmEj4KiejWvTh6T1vOwNYitwVj3UMsPTiBwZHqHSz28Y8H0R272rxqHAyvl2bqDbmvhbA/oIv6gvmYUnPZxZavbsY02Z5St/Jb5JNNvGxMUgdpBxK1m78e4Z8fxr0ubzHYbA/gfL5fVYUUbXKG+bjKlGESfjVx47LigK5/EbSFKiL6xpRqeA2e+c1L5mmh+CUPXdpsRZRvtBt6iHPWtZDDWlUk0XZgmFRWO1oBEHUs4tMC/TD49eHHWb4A5cqno/2lgdieDNug1ZJF3X46rc84jHhbTfPD+Pr0mui6gk8WKtZTIbbGqio2fQ3vL8+1Q3VVtUY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:08:19.7170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1c7988-5de4-469d-6e2b-08de699889a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

On Wed, Feb 11, 2026 at 08:34:13AM +0000, Shameer Kolothum wrote:
> For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is created
> before the guest boots. In this case, the vEVENTQ is allocated when the
> guest writes to SMMU_CR0 and sets EVENTQEN = 1.
[...]
> @@ -1605,6 +1605,10 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          s->cr0ack = data & ~SMMU_CR0_RESERVED;
>          /* in case the command queue has been enabled */
>          smmuv3_cmdq_consume(s, &local_err);
> +        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available */

Nit: though it is just following smmuv3_cmdq_consume(), it'd be
likely clearer to verify the EVENTQEN in the callers.

> +        if (local_err == NULL) {

Does eventq need to rely on !local_err from cmdq?

> +            smmuv3_accel_alloc_veventq(s, &local_err);
> +        }

Should probably validate s->accel before calling it?

Nicolin

