Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA62D19511
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 00:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkXA8-0001SB-JF; Mon, 26 Jan 2026 19:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vkXA7-0001PP-8L; Mon, 26 Jan 2026 19:42:31 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vkXA5-0003x3-Jn; Mon, 26 Jan 2026 19:42:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecVa3zVEgHdk9VScR+JH0k0VDmkzL2CRtpt396XPs13f+jbhto1FuAJgh2XHK92UbhHC1c/8GdHdHYIv9iksiEkSnnq8alOvTZbr7EvOjIC6JhbxyLeMJgTXot/e/uAsYWfdv58Ej1GlITYb7YNRdk65Cy73Wg74g3h36EEWeSuT9IlFnQyeANaBvIvcnTd5b4Erf3OjUYkEc4Jsdb2g4f4QVzLKo7M/HRcZ1NH9za/87sCxOb4+e7Nvt8xaUBKtD4fjXBmurO+rYeGvwXk4El94z7/5kQgHJioCehFY1foRV2cvcU32dRNjon3NjvUH9zGZV8e02QuP4hVuIRbCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLQPUClTgiOVAhXxtGJlBcNgw7imB45pjWX3Xqq60MA=;
 b=v1V0A43CezNzRicvEda6B6tyVnzY5MO2sTN0Svi28TL3Hb/jWtQVHohC5AZ9ou2uaL/EnUFwGHDQzHR1lPlGr2L3wXdl3QXLD3vzbSP9Ei1WKKJ1Q3Ziq12f9EGsbE/JR4F9Mod4rywW3BLf0gXk9J1LJRioK7I+znvC6ggeKOJtSpZGTe8uUb1LAxO2scSWYkwYJHYkc40Vvt++2aTnMQnLaxoVjyR7GeDNueWORZdh8N3H9zfrBjSBU8ghqAUnQnU/4/cuM4+N4+AtUsoiQ5XkwEBsFaVUVDdBbo1ewemzUZ29c9rcJLfol/cYmfll/moSu0hTPjIxscJcMJmgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLQPUClTgiOVAhXxtGJlBcNgw7imB45pjWX3Xqq60MA=;
 b=V4hBe03p8slR2P2jovp83lcoRVtPTW+e6vrBlW6yqymGZ4C5vbrOdFrzM1GNpll9aUCno259XYZIcw9ClS+NurSuBRBC2+gfFnodZhmb6Tvhoa35ljEzpUVKfiqQPj28ISkdJcXffFN7WPH8Jo5f2wBPV7Bgy9jDljGbd2fTbpWgVJJu8qdKdjU69GQBfxSTkHePfCOzN8HoxromQCHJEU0KsgZv+GLbS37uVxWYp/3el1bqgxH173FatQ1NdDGHpa/7zqnpci56Z67cpJbiKgkICtygVxRQglJ3+1udDb4k44xWWk7ZuqAXptl5Wg1/0DPQbLxYoRVV06N1cZ6nJw==
Received: from DM6PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:40::41) by
 DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Tue, 27 Jan 2026 00:42:23 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::a7) by DM6PR03CA0028.outlook.office365.com
 (2603:10b6:5:40::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 00:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 00:42:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 16:42:15 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 16:42:15 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 16:42:14 -0800
Date: Mon, 26 Jan 2026 16:42:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV
 nodes in DSDT
Message-ID: <aXgJ5Qx2N3O5c4sW@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-16-skolothumtho@nvidia.com>
 <053a0274-653e-43d3-8803-f9a97d70166c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <053a0274-653e-43d3-8803-f9a97d70166c@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 34491ab6-2f75-4b2d-b6b5-08de5d3cef98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dZ1r+YW9U9D735irGnYODwyC2pk0p3Lml8y6cIThulyClKTl4BGSw18oDmvy?=
 =?us-ascii?Q?Lxr0N+2f+IbunVqGyY1E9e2h/cQP+06poU7yV2Ds1WXlomB0aDYFgL++mxP6?=
 =?us-ascii?Q?BfwYxwhOQaAVHEZjnZ1wBjHwDntigaZWzqofNUH1zWi9MOZ6Io9cz8H6DUlv?=
 =?us-ascii?Q?ZuD1LflbXAKZ3K+4EQc2bzGAGGEtB8Xq4nzYUyT0YWPuvrEIRso1760iB/mf?=
 =?us-ascii?Q?7c9pV2MxW5FO5Af6gKixcy3bi5sEcrdTLsHWWj83GisDdJS5AjEXPq6+sQyp?=
 =?us-ascii?Q?IzdGkNK6OFjBJEedap8UaYWt+j46upr9pDG1nO1v2XNKiA8sYrK/9cJ/Aqf+?=
 =?us-ascii?Q?qu/G0ZMBTlgVhNaks/MeWVGNgHT0ERLR4wNql2fxMj7OUm2gG5Nw43I5RRLW?=
 =?us-ascii?Q?GCB2kKAIRQnSZPHT6ZjrgWoIpVMN+w4stF9LNHACpIpqKYD5lC7PvZH08f7w?=
 =?us-ascii?Q?eAx8JHXKjhZdjR73JJbkuxwH0nO0I1cmSrwTIB4AzrmAeyeRmoA2GYQw80mX?=
 =?us-ascii?Q?wEE0an7gRzL6OYdn38xHkNg+i/vEW38rA/kaB87b6d8bHkofxt4CWFD8FS6d?=
 =?us-ascii?Q?AMjW7UBrRnwoRCq+g9Z9mWWVfvy1FivQqfOOGGXC2hX3HqXrmhNVp1SFduU2?=
 =?us-ascii?Q?vz/2K9qZC9Ux3gIkLfiSHcWz9brQ6N06yTCbhS3GdTHyIfIqRMk8dd5JUz5U?=
 =?us-ascii?Q?7IaxdjofVmixpDGstyYhj7+pC/WPogdu4vbeTpFOOmS20q4Y271h2Hmd2k6j?=
 =?us-ascii?Q?gcjU0uiN6ZWnksvtvm5RbcOX4IW3+ngc/yOULTdt63vQ73ZXmiLatISO9iZD?=
 =?us-ascii?Q?B6FxgaUTF2pOK1vZhQlOUTfiymVGQpbJzVLJa9RLjRtjC2Ebd7+NNjzbsCqZ?=
 =?us-ascii?Q?WDaG7PIojY0NVJVlrCGVouWO5TV7XweMgzkcE9aA4w+tpqerc7A0Y5Kng0vt?=
 =?us-ascii?Q?3DG62HF/1H/9hNFgOVZtJr8QcuyXgjZNBGz9sXJGC+o0SFygkxM8FuSsDVy/?=
 =?us-ascii?Q?u8r+f5f6ry+BxMJddEeLTM8eZQ2c2L1KfPF0y19mqqpWv4BHjnXePaUGnGAF?=
 =?us-ascii?Q?/TMLP+M68H3XzImtm4eNYeOAaAGWbGuG0xHYdRxwduUCJdXXrFJZM4JPe9S9?=
 =?us-ascii?Q?Tpcwd76a/KfZc1CpRvSvQ7IDPX5DZSDLBHyfrvUv3mO3bb+gZTUezqoOnXSU?=
 =?us-ascii?Q?WPBCGLDUHw95CHY4aQM/rSBICIcgY0mOYXxwGI+/Sag5IjpN241ab/bc4uWQ?=
 =?us-ascii?Q?PmRbMDt5ybDMljsKABc7g2RDCwZhWTBCqwKD3DgzTX1FTPXI4C12L/SGC6An?=
 =?us-ascii?Q?0i4IkVMiSVVQWG5yVhb4VW3IWdIc4vuSSgaMqC+wj18dVJ2syS8axvZyGSJV?=
 =?us-ascii?Q?WqGyuDVT2Tt0h1OBxQ7cz9HOWB8/wJTx7aPMzc/9Q26cBqcFVj1/kPuXLR94?=
 =?us-ascii?Q?Af8Tg689trucwqIw6LvDD930isI/Rj57luwjN315M8Qnoc/vqzPB49ObFW1n?=
 =?us-ascii?Q?GObOmWWSR+P85AXEflCzG8Sx4mJnP6BsriY4ccdgj+OakIXoDAJ8BD3B4Luo?=
 =?us-ascii?Q?PQrEhQ226zT3HX3ugrrbMwMDYadS3XaIpoF8mXi2FEEjUwPe/WEMK9vX0oHT?=
 =?us-ascii?Q?/3su/3vfS/dUZWvHi4sVaoey+5qH5wNkL5qjcZkWHZWPFdFH5hH2LCeTIV/4?=
 =?us-ascii?Q?L4l3avQA+p/RUo+Cg/eCFJnDbeE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 00:42:23.0133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34491ab6-2f75-4b2d-b6b5-08de5d3cef98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

On Mon, Jan 26, 2026 at 04:28:24PM +0100, Eric Auger wrote:
> On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
> > created with tegra241-cmdqv=on.
> 
> Pls can you give a point to the DSDT spec to understand why this is
> needed and what needs to be added.

This was an implementation decision by ARM that CMDQV node resides
in DSDT v.s. IORT.

Kernel driver scans DSDT unconditionally:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#n4572

NVIDIA also has a public DSDT:
https://github.com/NVIDIA/edk2-nvidia/blob/main/Silicon/NVIDIA/Drivers/ConfigurationManagerData/AcpiTableList/PlatformASLTablesLib/Dsdt_TH500.asl#L1005

I don't think there is a DSDT spec though...

Nicolin

