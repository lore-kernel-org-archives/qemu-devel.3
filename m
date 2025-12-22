Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6CDE674B9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXljU-0006ep-89; Mon, 22 Dec 2025 14:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vXljO-0006e9-R8; Mon, 22 Dec 2025 14:38:10 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vXljN-0002Ke-Ba; Mon, 22 Dec 2025 14:38:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYnUopcU765+CIm8dwJ+sa3DlbI8+kn0oejugSdiCXsNdUeWnEhH3VWO0ElaPzSlfeiKJONJq2Ev3caeuw8P0Au75ha5mkBbxmmoh0dfJSRTHWDwu0nn5qwcAXISoPvl5lzQizC8by0LciewrTJqccvWGpCi2vwGcgBjUNx1LJib3Ay5f7yXevnHxE8e35TehXokt7SMixHavBqBngj5g2xbg23LQhrYY/1HJDj3sseIkepWf+4SEd8MBA290ouVs781GppVhEj7M5PbvVEFwb5dy/MDsKSrDX8HE3fAStBWSqs84S3r89zw9pNENvbLJi/eYI+JbwXnUysmsBiCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7dfb/tmjK/iiQQPea8ocuXsejUE09aD13J8zWTWE0o=;
 b=mG/tXIHBGV9BtsRdu+Tdd4fAF1HFYoykAow23wxLrI8y1pN2RaT74ppHC1SdwF9UbkC7rHSLt41VVC7y1XCevyasL6Wc2Ou/YEckjAscai538Ebhn+Vof2zYEz51kbO2YtKE2a0hK3akJBY4LlHDKMhvPsxWYVXaxup2+ercjGRvkvQsWRyO8Ua4Wh3RizrzqiFFXRSEKyfHWRL5sCn5NzWzzeUkig5JLwhMdBM524T+ahvcMMdMDMYb+nAV+Qg5LDAY5f+a5yj2fBgUqE9YUTwRI9yv/EO20c5z6V/PuQM4H1FR/Bqwg1b7Kcyb4tx/Z/Qxvzw3v3gDeUlXrWeWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7dfb/tmjK/iiQQPea8ocuXsejUE09aD13J8zWTWE0o=;
 b=t4qMZuV28fg1YZFsZw5/cxplH7Dn/UOU7jEwQK2ILfn+dsQ1upbgRcN0WEacC2A+Cb0GKBcb0DRvSqeCy6c5SZ4fISyoi/Iy+aLO0MI1r7NzYTh5+8LQ5lmHHvxnF1l5BOWgsiK0C9zpOgT7i3vXm1NFrEU0VFVHfRbx6l3UUNfOPORh2qUcJrPaL/BxamK7rsLCCcGuI08sWG+CoqoEnZnsq/oPtisPvbtMgeGuazFc9mTdv35eLJSG2IIbD4SiJeMNbX+CBmg1GLgttrDv+urB9Uv2AH6pFm6iEjz4xyyhoDn40k4MzBoiembY+zvJpuz53OZ3y861L/6g+LrwNg==
Received: from CH2PR07CA0036.namprd07.prod.outlook.com (2603:10b6:610:20::49)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 22 Dec
 2025 19:38:01 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::4e) by CH2PR07CA0036.outlook.office365.com
 (2603:10b6:610:20::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 19:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 19:38:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 11:37:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Dec 2025 11:37:47 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 11:37:47 -0800
Date: Mon, 22 Dec 2025 11:37:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <alex@shazbot.org>, <clg@redhat.com>, <cohuck@redhat.com>, <mst@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
Subject: Re: [PATCH 0/3] vfio: Add DMABUF support for PCI BAR regions
Message-ID: <aUmeCbgQLPK/bKQK@Asurada-Nvidia>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251222135357.143339-1-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: f37ba970-30b8-498a-20d1-08de41919dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZS9R0IYKnWzyoeuUnZ4HDe8gzcDFKe7YKiLnEv67pSnoz9hw1yL2j7QoMmhH?=
 =?us-ascii?Q?Ve8+/pWZvdKafjaHkQolr233MlOb5pKc/khE0fjZpdFO6ru16T+Aao85bU8L?=
 =?us-ascii?Q?HnrFGlFEy1jeMwsmIcGahqZFS28fLrohHiCqooQhFUMipIIZhJl9vqFcx5cu?=
 =?us-ascii?Q?CAla1BqpzxVh/2stL63iGmMeQCEx8OuKFeeVv1037nqmX39Vqmwn3uZXTyHG?=
 =?us-ascii?Q?1+BgdyjFMkMK7cir/DEWsFYr1ZbMaxlJ4sRraoFyfohq8ymZ7qoG6XqsHWjv?=
 =?us-ascii?Q?Kj/5P4KsApQlGErWS6qYh8nh7n/PRchr2k0NXWhMuPL3MUx8f3JrfPlqygMX?=
 =?us-ascii?Q?bfYxE2xkKBPUMzfF1PH5nQb2bUpodZhHzs+NNUWuaF8PlTAdF9a1gyC1PYoV?=
 =?us-ascii?Q?U0L76E0bOSN8FAWbw/d/OBpk46iUNcYs7yRkjJ6GSmzpr60U9o1aHRtdal5w?=
 =?us-ascii?Q?jE/IuCXnwAf33eviLOBpJDcDkpwYUXditBazih/lvmSnPr3fwoH7HAcQXT2g?=
 =?us-ascii?Q?MlDSDL6KT4Si2FaxVLxmc4Vj6eHjSryzGtPilKKZmUEFcu+ehDNqdrTWetbP?=
 =?us-ascii?Q?k/UXGRlXDfjIYa5fRUnWkIWE9qFV+Wmkk1n5VOlsGZfRDlkr8OsoEJut+Ss1?=
 =?us-ascii?Q?8WVn6M4SRbOoHlc69wQdmVEWZIGGw6vm/nhbeAhHTMLvlEdwgH+JfSRU4qfE?=
 =?us-ascii?Q?riPFcrCa0dYYJQuTd0P4MWtJTJ/soAg7ppwsW3Zr1WWU+zwBmNxkzB4M3rh9?=
 =?us-ascii?Q?rylaXzQe92mf7j/tMeZSXkchbAQ7/xUpWNJbRpuP/Ggw7jDm6Y8BKFy+vNMb?=
 =?us-ascii?Q?ie5ulp9JA/jd7tITCfOG3OFVYsbIY35/yHvmnHsskjONJU5BXYbiIX/Faxj0?=
 =?us-ascii?Q?unVo7JnvJ7sY02JSJMWKna6bIwB83zn/MGyqYrGmHtQ1hBH79QrXPoFo52Mc?=
 =?us-ascii?Q?PB1hDJjol04mwgHlD09JrIy4rUP+7BHyicxYEgTxH5H9SThv5+RmOMfSO4k1?=
 =?us-ascii?Q?i03G0dyYw5qoL5AXtZsI6luChpRmKskGhcbOLDDvxhi+BgwuEwFuNxwbkBs2?=
 =?us-ascii?Q?WSOMx8Wg5S9eyMWt0clQwHV5SDodnACia4MVEOSEWy65FYvKBH9pMmPEkb79?=
 =?us-ascii?Q?pYu/3meC9k2LuBKAXPmWNIa/g0XZXIFBETvhrqS1c2G0G6pbWOs3iNu+oGwy?=
 =?us-ascii?Q?qmGspRsk6s7b/Gg/vpby6rSNv2mVafliHV0NGsw7HPIT5xMOVP9W13iKsYLC?=
 =?us-ascii?Q?uwrr4GQHdx2RvbtDd7i9o8bPgymCsjyni6PON6fnbKefvv5jBw9HvXhHayxL?=
 =?us-ascii?Q?fjEOr47DcFefXJSOnQNiFaPWn4j6O+c5KiEPKHWZ0xsTs21V4no9Hz2k5+hW?=
 =?us-ascii?Q?6y4TSvYKkCZ2mEg8Karcew6R/m9oOmvx7Yco7jncaUNIsR+PEBWkgR7gPA5Z?=
 =?us-ascii?Q?ggqjaZNWUZRGk+/63DpX8rc3oLfjQ6L7MgY61Hs5NZm+WYnlLHNXx1q2P/w+?=
 =?us-ascii?Q?qjNJ39Jpo0hCfYuKfUumUkSWeuDbqk1pdry8uN8j1LZjKwWUVLnoD99h4tPf?=
 =?us-ascii?Q?nvLlCQHRpCo4LdCdLIE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 19:38:00.4766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37ba970-30b8-498a-20d1-08de41919dc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
Received-SPF: softfail client-ip=2a01:111:f403:c001::2;
 envelope-from=nicolinc@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

On Mon, Dec 22, 2025 at 01:53:54PM +0000, Shameer Kolothum wrote:
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. This adds support for vfio devices to create a dmabuf for
> each mapped BAR region.
> 
> Requires linux-headers update to 6.19-rc1(patch #1). That update
> introduces a virtio-net build issue, which is addressed by patch #2.
> 
> The dmabuf support was sanity tested on an NVIDIA grace paltform.
> 
> Please take a look and let me know.
 
Tested-by: Nicolin Chen <nicolinc@nvidia.com>

