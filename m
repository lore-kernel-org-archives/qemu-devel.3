Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC6ACF887F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCeA-000404-Qr; Thu, 20 Nov 2025 16:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCe9-0003zj-7y; Thu, 20 Nov 2025 16:56:57 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMCe7-0007j5-Hy; Thu, 20 Nov 2025 16:56:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2R2m7fQWNNOAGoI9avKbo/P4JrD3BRDTPV8Q5i4e6IUQqgzxQJP65V+3DxVC98VMGTM7qlYIy2K4NmjZ8d3GrcG1F02tGBbEAisSEKqksa3teiP9iYJaRzQuKuujS1B/ufftIIGukY6T06mUK4vfIMTE5DQEBN2MkxIPwU3hEfRawoM+OlPP6Xpa6cEIKxRZAYaA1dZLYHXuC26ETcnp8W8Vhz7hVy7Hmr8tOTERw0hrjKZ3RliTGshskqbWQkHtrYhG+JmKTgPPo4lzb/YAZmmOmN0OedPVQgmCpgRVj65PD7EeGuTjeS9O1/5KFU1ZS7xZV816CltSODL8kQNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lWHgnivIrNwBBAPJlieUdD07qIsZPvH9B1fAV2hOQ4=;
 b=lpAYBCbWsD7EEUt4MnPKA9G3mDOVkYXil3AsjZofkRtrbAYyGjiFY431rRxqtwosZJ8wGzszvPUkQjt9Jr2zUmFAtC7Q5wAn7MUVBcWn1MJ/d2p9Sc97tOIfi9oOesgfwxh8mQ4bXrXKnm3lAeDUhrb38RcjOkwKz2x1ohNVDFfNP8hVLRTHLwDfn3c3CguSRHBpzzNxju70wY2nDqqn2/3opc0y/DHCMNPcrtUYuzEKdvR3L6Qd+0ldnLkWSwrfkd6JzLoomOrvhCjKdWHstXtS9uOY/Sh+I0Fbn6GAFNgf92KZq/jLJuDR3pud5+Zh44suc7XCCe30/vkq2xTFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lWHgnivIrNwBBAPJlieUdD07qIsZPvH9B1fAV2hOQ4=;
 b=bYT2PU40VrEOrIN8woUWRYY9fIZlE0Oty5TDpbagTbscZCirdid7ZZ2BDhQX/KOjkpEgv5aVQKH+rcgQAnvUKhvW8iu+HAqTC/P4YDcNnjDuC6URFy3G3I3HkbEKt9/IGB8Um4ajP8+mFTuJnDvFJBMoRumLp+8ReCgLGLJdb7tZt4JwQ5TMOr5QIIvookX7QbRdc2Hi+HajxzS0lZyNowPFemIS5GCfxNsnVkvX2hf3K8RFKwpd8yH8GkjGLzSaM6+6grv8XAtmG1tncahCEFLa+0zS3SljkPLTiD/DCHDqcIH9jLVz3SuH8Dtt58tVVAMPcYneA1oglxd1lNt55w==
Received: from SA9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::25)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 21:56:49 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::a7) by SA9P223CA0020.outlook.office365.com
 (2603:10b6:806:26::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 21:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:56:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:56:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:56:30 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 13:56:28 -0800
Date: Thu, 20 Nov 2025 13:56:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 31/33] Extend get_cap() callback to support PASID
Message-ID: <aR+OizGnyU3od4cp@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-32-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-32-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9ec2cd-7f0d-4b02-1a8a-08de287fb496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JlZa77jQUmk9ib5L5Geis31Z/REyNCH5uTv7buQbNNhkEhd37bccuUchLZ8i?=
 =?us-ascii?Q?xqyDj34IOaCVw3nN39KXhRoxq70Rw6ZK4jQ6kz+2SGErU0ethWgqFOarQ7/R?=
 =?us-ascii?Q?3r199fkx7SWU7xUSutpci/5L1PQ6AqlGAeq5/Gpkv1HVGhyrukGQmYAzSTv5?=
 =?us-ascii?Q?EZlR4rdS4xQBN1M7Zsogx5WNEzREwV2tqPvfTyzTkt4Wfo38K51VUn6uHOut?=
 =?us-ascii?Q?LMu8EwQvN7kDtqd0ennWq+XQJb+sy7lrbCgQZ+tdsExenNzYU+LXDyCpcPVS?=
 =?us-ascii?Q?7CqpTfgLtCUUXeHzBDIhAtupwJl/A4ubM71VO04lPbw+U+RHdG6XsT6FQiTk?=
 =?us-ascii?Q?iw06EUhidman2AbYLVWPOPENK1GcyfkMXv10Y8b8TTMftjN5MXdKwBIVuMCo?=
 =?us-ascii?Q?lDH9xKtJJTP8oDihw1hmYm/Hh6l13PWbPkaropMr7Om7oBrmlWf1SOxEDwWD?=
 =?us-ascii?Q?jGXUnaWdzsA66rAShsPa/KgSAz3LuEs4kdFSD09VxhnerwyOt+G53eEn0o8O?=
 =?us-ascii?Q?QB4zy1sPSPeIJqIldPbnojRZfLVWdi7X++aSxXGLrkpOMoCyPIkK6heC28eH?=
 =?us-ascii?Q?DJdC9BLXmn7bBtN5YnQ3YW6b0Zh5qZEDvi48ApqDWEXUWEajsVQrTlRHimt5?=
 =?us-ascii?Q?4Sv6vO6uLp4v4DDogXMen7Fnw0MnyuTq1afk2Zkj25SpM/gy+7FHSIOq5y7m?=
 =?us-ascii?Q?C+U8l7FLInEseKI7zh5ACjZmOordw3oRb2yNR+IyEP00XijBcK3n1CJnzSDU?=
 =?us-ascii?Q?wk79WxQKqAJjv2OUT3/rmOv7Xhow5BR49s025jiaAk44DmjQr7rP8v8HZRHf?=
 =?us-ascii?Q?DC7Id+5Eg5Y1JqnipDSonmfpMHh5pyCH9oGEBmYFnN8hsoWfMfIzhso90yfz?=
 =?us-ascii?Q?IJxXLUbsvUknZeflGckgPvtsVPYrvAUA2AvXmtluAEqxTtb4pntKS9F8opoX?=
 =?us-ascii?Q?2ItDwmjAL+cszsX1NhvFdR3NVBgoIJ2pY8Wr22eAQ1LuHL5jz5w3aDhIjezH?=
 =?us-ascii?Q?TjSKDqY1DSqKrf+wz1HCfPArHDY/OkChKJLFFxsJQ6p/1x5NDLqVTcJeyci9?=
 =?us-ascii?Q?AKmUTH98/zgV5Te8m45YlKS3qnu9SDxzWPdqmwoFV/P+jiXhc8kdQS7uBsdw?=
 =?us-ascii?Q?BE2LSgz6WaKyz2vlsKCqU7AZVxaCVeNwGP5XjjEYQ7yCUgk1YU3ERDOD/yH8?=
 =?us-ascii?Q?Bp+FjMEBD67SkhlFUeQq992UBuDwshs8p4WZovY5hEKeqhmbj9Ruy4oM9Hvs?=
 =?us-ascii?Q?QQUqVeWXWUfrTCEvYFKVY4N0lrtkhxuwg090d6QbbaHZkxaySElOEUQYbjHL?=
 =?us-ascii?Q?EincfF9GeD+8fslF2XtD2ZYMtNM+EQumwYqXme512cTMDxmktAMvyrObsZXC?=
 =?us-ascii?Q?GCYGDDKXm3x4eslxIrIyMmjdHF4+lUZhCqo5p/YWAkb744MDN6h1S0wuhurx?=
 =?us-ascii?Q?MEg2k6kH28A1GIMa5neoC/tu/UwwRseWGXaYRSOAcV6aKNi1q/tRDtdORExe?=
 =?us-ascii?Q?yNSdLwtzviYOxY5DLf4LwjUq+SRjj/lFZMZf5SJD3brfKPxcCwPGcqVsDxMS?=
 =?us-ascii?Q?sOeokW4VcHl+BWdrv1Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:56:48.7448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9ec2cd-7f0d-4b02-1a8a-08de287fb496
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

On Thu, Nov 20, 2025 at 01:22:11PM +0000, Shameer Kolothum wrote:
> Modify get_cap() callback so that it can return cap via an output
> uint64_t param. And add support for generic iommu hw capability
> info and max_pasid_log2(pasid width).
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

