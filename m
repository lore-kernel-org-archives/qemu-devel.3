Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0BCC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnRE-0002sZ-Lj; Mon, 06 Jul 2026 13:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wgnRA-0002nl-Q8; Mon, 06 Jul 2026 13:48:56 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wgnR8-00071T-SM; Mon, 06 Jul 2026 13:48:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdtbVKAHoD5YMqo1gIUfsdYOIy5g3ftI9CVeIP5wfXirhttvr7cTNCeY2UpkF4fuIeDzFoEhhy24ZO3/HeXyyQj3ia40Enkojpqr2Hh01wu3MXV9jKRcwq01gsS5lUBdHajRPqbG3d2pYt54w5KUhTPnVBC1dodnT4FHkU9Ilrh0ohaFDAdYp2rudXFw74pjSM7aBYgIUVXMNRjlcrhwweqrOzaTJheNUgsOVtlHOsORchKS/JPZnwM1oe+wkNHl3v56Y6IwgMwsZAJrNBTgre65s36lZKMCRjHqgmxnapqOgkO50C2F7zXKldKl1ad8fO8h54s83oWUQ46nQk9e8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQt2aKZWFhuqu4BjrKyiEv+qpClc4hn2K6Ghc9loGH0=;
 b=fC9llC8C0KQNRkIiAqG1mDkkLcpzavbNAC/1URdJJNDxByinSUaj2xabDpNjnVp7/r6F9tgvn4v6bF88Ery0q+RscZEGRvoQJkBYuRCtPJvS+u3nD9zuIqukoVXpN0D1CGT3mbjNG36trHJwpb0tVVGyyGc3VaIPsIBEMbwANbOcmW2gmjKkR1+G9n4jMg1f6EbvR0bFXWzApyX/YDm6n4Vb4t1IlCdHGojQGylxnS0WGF2I2KulxXOjOZU6Nmj4/FXArcHF5PfvxKuR+1HKboimUFsF08845LKhCNUJAiFkrJHRttM/XgIFneZIv9bwZ1lAVSX7TsmrqZuoOnf/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQt2aKZWFhuqu4BjrKyiEv+qpClc4hn2K6Ghc9loGH0=;
 b=J/urSKZtQ8FKuTjCSmzZ7Scf2f+UN2klSkwHwtB0G5ab/aeopMRxzopVYJOr7o1RA+TSZNqzaqzb+bTbhQX9nKjXu/+AGx43Yq0/jaBKZ9MeaYyT0ZFQtAzvxwS6GWa/7wOm8zKxULpOEcHmCEpeEkcX2Yrfp+nHwjSwzMKbRIIdRQR6pMUY6bY3j8Q9e3+B92DhDTtjOoo2a1UQRTwU+Mk7xWDoiZMJx3LCfsn+ZiXbRJ5iWXG+f5cjR8iSetSt4t9eYeoXGJ9Aw8w6+p5IKRyotamtGRSVzpW+Z6lxBAAAY4VuZKJom/RvfLpNVYNiN6YeJg3O5y5B56LrDpGU1Q==
Received: from SA1PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:2ce::20)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 17:48:44 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::55) by SA1PR04CA0014.outlook.office365.com
 (2603:10b6:806:2ce::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 17:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 17:48:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 10:48:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Jul 2026 10:48:25 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 10:48:25 -0700
Date: Mon, 6 Jul 2026 10:48:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>
Subject: Re: [PATCH] backends/iommufd: Fix dev_id and type order in viommu
 trace
Message-ID: <akvqZ92ADt1biIZY@Asurada-Nvidia>
References: <20260706103653.84243-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260706103653.84243-1-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 863469a9-0968-42a9-543f-08dedb86d2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LYkNmw3YXy50gsFgvV3MNFGg7U2Q5Bfg2YdE/bqMhXDN7mK2tB0QVKGYpXPQvsGWrzyr6ExtvNbU+iVS6/7WoN4B8ox8RiZhw7tbPiahPGk6rWKuJBZii3xVjjyUXEdCvmJYXMxSgUUfRZbiugh/fn0nQXFvuTUVey3oDqOTxeAfQUWNYgOPxs4XQEIMDUI/lvOdQuDhVAupaD9T8a9T94jcOuDrGXEDaBs3mDbIUNJNrF4RTRRk7gjq5EqUTDDRCU55a3iLCb/O5M4lHCrUyqq/O3mgKaYrNhw/pbL+z4BKPoBrKqB06ZE6UxOBHTd3atpEtBoilrLJO11Rc2Y8nsX6a+EQ8mWqf2M9e5PBbTj6WwzSR46EkXQ/NP/npPjHklogWMS7zwyDmTkUCcB54EoMV5pB8X2scwQV8CGjhoAGmzRtxsFH4wy6zPICdzODYDVSE8C0T9JTZAbnwoW3BfLpklapud4ZjOLKRZ1B+mjiLt6901i6p76DLrOC5fFDlNapl8ARQ+V798w24cGmJP5a0quNl5XJvNknfm9fU+whXpCALBtyfyHUyRd3QAMDgSksaglpTqHe/Pba8DzyAoVKlWFW7ZG3nUarMD0ZYYIoUSXCMFYQ657i3ZX/n/0di1BAG3i36ZmjwQNuKGvMX236Wta1jCIFjGopMbo5Aupeza3Ni/ry64oPMwkiFJcg
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IJU3md5lg2jwTmAu69nWfQ4CzUsnP9JlPVocQgNyVNVhQrMiuFnp96N/Q4FmGgG5n9MncpOz41JIuknXm+vq8QF4cPf1/RBJa4bnaqXfBbIjKmcb4rHYBhYPBi3VbF4+mVzdRXUBSnMk0ojx2CxkrkG6SDFu/aM2dgkIJER5hMnjzS5eJ3sVsM/C5YHuloR2A1NnMTf5fu/xEOm5iFqtZolanXwnn5hEvFCL8jyBFSymc5XJI1p4pQCYghLryeJnlrnQNw6i8SerjmNWVz4CSeT/63rE96xyPXoiSpv0jyYJPVu+5C/yWaLjh4EvOQ0rIfr87u4jMX56AZjn14gjzftHXCwypE7IH5j7psd4zIP7hqdXsRzzemC3EtpcbQi+8aGc+TaAd3VSJaZgZLJYy9eDkNJZLTU+qgMuvTEK55dTwxYlw5CkLEOiut05lYF7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 17:48:44.2638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 863469a9-0968-42a9-543f-08dedb86d2e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Mon, Jul 06, 2026 at 11:36:52AM +0100, Shameer Kolothum wrote:
> The trace event receives dev_id before type, but its format string prints
> them in the wrong order. Correct the order.
> 
> Fixes: f2d31df0d925 ("backends/iommufd: Introduce iommufd_backend_alloc_viommu")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

