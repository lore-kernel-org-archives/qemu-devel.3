Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF983C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAuhK-0000w7-9s; Fri, 02 May 2025 14:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uAuhH-0000vJ-OQ; Fri, 02 May 2025 14:01:15 -0400
Received: from mail-sn1nam02on20603.outbound.protection.outlook.com
 ([2a01:111:f403:2406::603]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uAuhF-0001S1-KY; Fri, 02 May 2025 14:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKqmqeiltqfQucBhqnYosc66qRgEFjTT/TEKK3NYSo9dFxMnkrcNmlLAJWv/+BW6+nr+dVAECful9JTtVaDJWKmG79iP07PO5zsP7eMyXMWD+Q7TPG2g0QmdSulB9Vq3CBy2H328D4vcf2nwpBp0/SxBnyEHFXa4qcMoNDsaL+Qdun5znUKdcFxnTkpQJHwte8BqRgHkCEOsrxBkZkBZJCKRe/ioaLrkA0IAU4pBS2HfmF/yTqlm4sqpjUoIXeLGD6mCGJNXz0N4SWM9bgjZUeVrAiUiOFvdL+P4cYkP8Yt0J6r+XhW1EG734xNvsEIBcMl2udKhzpeKRd97awW/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EccdNvbRZOOqkdfXyN2qI1RVoVQ5iLqmy6fhWFbOQo=;
 b=dpKdtR+O/YxOC8cmLbY2dwGvVr+erS52lWp86ZprShUOIHXQGvrAMuX1oasXFx8+/ay2kDvuLOlNk7ih2dUP8FPgqJF0VMNC/AbbYVv9V6gzaWtxcSWuqgZruyXU4+StUVLAsQy/rVooZ1bLVCo6E9hRz7p0fxD7z3litqbbs29IwQO4JzxkAhc7RjluHLymDJvehogJpxobl+Lfd7DS04lhzxv/WBR6KYebPqOw7AS2s1m9FQ//FYr04HQ2MU+5yKGoL5ecnPOvS29MxoOY7CPFEwY5V+kzH7ePBtVF7jhLBBNnNEOARfpM6d0/2wu9jyhRTAL61MSCAjsgtHuLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EccdNvbRZOOqkdfXyN2qI1RVoVQ5iLqmy6fhWFbOQo=;
 b=GVXpV/rM5mAygnSS0tP0FDFdV3zaD0idR/l0NaL7ug4fIa5XxXsc5I5AB2EHIjDbV/hScxxpOpKAWYWx3Nw36HFD2a1WS1OI/XdvOsRlZo8JyGaQnIQyfdLG4kT6aYAcZmcdDLyyobDbc1kSBK3GDrs9fvfdumWOsyG5vipaD9okaCT4Wyv0M7kLHDB94M0d/+gtk6YxcbOi0ROiV3rrstDyzFd9t7RR9HEfJTCbisLHYilnTsfme0DHJZBc69Yiwfd4ip3chMgpRDmnm5Xzi9B5mJUPqsO1SZMJkDLqnOq96MZNJTBQ115TJkw2QB1PXFXiDq9x3LkttDoIMxd/cw==
Received: from SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) by PH7PR12MB5783.namprd12.prod.outlook.com
 (2603:10b6:510:1d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 18:01:03 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::b9) by SN4PR0501CA0057.outlook.office365.com
 (2603:10b6:803:41::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Fri,
 2 May 2025 18:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 18:01:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 May 2025
 11:00:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 2 May
 2025 11:00:45 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 2 May 2025 11:00:43 -0700
Date: Fri, 2 May 2025 11:00:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2 6/6] hw/arm/smmuv3: Enable smmuv3 device creation
Message-ID: <aBUHLWY1Qdapgl+Y@Asurada-Nvidia>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502102707.110516-7-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: c78d3a44-c9f7-4d06-2283-08dd89a34d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0TnXoZds72hEaBOy17IBFl3fDDDY5ehqu7sDgxqhGoucw+odx3RNnRl7Yqw4?=
 =?us-ascii?Q?7c/LSYc9tHYkEhDKJKjIcmUs61Wy5s33nfdUQPBuQZ8ZyipllwtRT7VsNB0y?=
 =?us-ascii?Q?pRQRLFnlz5I9/1zfqItC/zZHUUVLCFoB83nWR0Mlir3g3fOP2syrhXGw+JBU?=
 =?us-ascii?Q?6IxvdqdMQNcGp1PWrK5ngG9ka5y3pTd7ntreFdlnNqV5TEdsV/2s5TNauXsU?=
 =?us-ascii?Q?+f/Bh6G2fjxx466Kk+uFMicxD4VLib9Trkngm4MyBasmpa1ZPr18oOnKIg6O?=
 =?us-ascii?Q?vaaXi64KzvVvDBMu9bhRhBxajdTYndEJZ64wHsOCqbL43JRo0pwTnIJ9e1BV?=
 =?us-ascii?Q?W2OCReAmJobKKwsjIKh139QUFBn47f9JoRaED8+k2MP6cKu/mGtUgcUTZR46?=
 =?us-ascii?Q?ovkJAjuPmA7zv/OotziuXct8aEpKAGWqQ/j6pGvzWMHMCnpBSiJ/LN+QNo47?=
 =?us-ascii?Q?vYcPIKjXF3Qfte/pAiLcoYLQBe7lBb7QL28V7j2cMfI0xxCU/oKnPkNTcl6x?=
 =?us-ascii?Q?8kc/Gh1PE6112UgCcrj6yjIqEUu/+vLyt/S8PsApRlaCMmQ6GjKB33Co2ksC?=
 =?us-ascii?Q?dko9FclUrtfLTcN+u5inGbUMb4WAL3N9D3oQyRLhhlN5+vtpVi9Z0kBMxEuj?=
 =?us-ascii?Q?cI2DmMD7DIJ1Gqb7rQi5cNRM+5uhjdHhehvTAkzxAhj28XQxfBe9pmMmOp1a?=
 =?us-ascii?Q?peeovuNnZzAzClyaiS8vep4o4P1pe+qyqj+DnCqQ+LG1GokhhCQF+p062Qnn?=
 =?us-ascii?Q?lNZg/667PmFy1pYNzRGRUuwFrVNYHi8q1Uhfwo5u0yW9lgidnQU/c4zaEeHx?=
 =?us-ascii?Q?8l5hMkY0SgzjoosZzJ9Mq+PLmXg7THkTc+gagsvZkligwRHIw/KRrN+LZVXg?=
 =?us-ascii?Q?OCED1zRpA0W+VY6krUh1VjnuBo7C3P5MM1BWH2kC0ajtYXKkh+9iH5e7CsgW?=
 =?us-ascii?Q?iRqCv9WFLWwavyZqGdpQLjQnP4lxaRUjh6v/SQfnx704gz2Eozv0iAucYxMK?=
 =?us-ascii?Q?KHv+SLJmlDdiO+jAG43/eL1iGOqTYaqiP0KQsZsXY8br2xvGwxdYJSz8FLqZ?=
 =?us-ascii?Q?2C0Mp3Kpz8BdPebttzXedEciKF1TcdW2i1WKmbYkln0yBvAdSBDOvQCHrml8?=
 =?us-ascii?Q?dMC+RgH19gya9TCeBHBjNFEKdUXxQIvTzjR0BsOcy3oYtWCNVhwDxZWS60Ev?=
 =?us-ascii?Q?E+imK5xYlQpZFhHwDyKIDa2k/JN/BWT08CYx+E96hAeJqjft2OhSWG4//eBs?=
 =?us-ascii?Q?lX0O0CN/NDqRMtZnTDQF/8NpcRjSfdrcYMKdKp2eujGBi1rtRlE0yPc8BXYB?=
 =?us-ascii?Q?2J7ZTzdv+Vm8xZCWjd4ULDbXfB5ADlyPrlBTQdrA+oyk22CtVQIed1br6lBx?=
 =?us-ascii?Q?duXKhHWpK+P9oVUF/H0uoqd7PSW1rkKMkfQr4w1w3DJMch2u+dFIpJvvZ8AQ?=
 =?us-ascii?Q?+phKkn93i9E5Pb28JogBwjbDEq+sZL+mAiCDbyEGZqafObMUMvPahP0S2jBk?=
 =?us-ascii?Q?+KznUAEXwpdZfDjyOA08sOsCEjKe6dLogzIX?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 18:01:02.9808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78d3a44-c9f7-4d06-2283-08dd89a34d9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
Received-SPF: permerror client-ip=2a01:111:f403:2406::603;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On Fri, May 02, 2025 at 11:27:07AM +0100, Shameer Kolothum wrote:
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Though I think the commit log shouldn't be empty,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

