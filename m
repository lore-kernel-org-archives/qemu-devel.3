Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AE0E6749F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 04:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6iyl-0006e2-GQ; Fri, 01 Nov 2024 00:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1t6iyh-0006cp-LN; Fri, 01 Nov 2024 00:09:41 -0400
Received: from mail-bn7nam10on20603.outbound.protection.outlook.com
 ([2a01:111:f403:2009::603]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1t6iyd-0007Nf-5a; Fri, 01 Nov 2024 00:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6cvCN34v9e/O6Yd+RABVs122AyEUVhnxPJKWqxxbVSAtI8pD8egJKshSWjQOrVqimawYbFzO7bNHPkcbmEGgitk0X5eyWTRC2IQOXQNeDSlSNp62jOZDQYP0Ufs1MT5r8lVn/8go83pRzQbol7BP66teQKsZlLJn9PmPM+quvWe8Nh5ZYY0yR+2mmbaHHKNXThaXdNjOFmhF89K+HmHNLyIUzybVanrc6uTlin5eOpaAkvPJbeHib+Tvf260Glb6x9kPEe7gUQDmXbOqOfp27LwY3o31Bz5T+eNFI3bAIu1iVbu8iS2zBS3kze5hpirvdkAmtptREdAJpn+Z0FCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om/05SEztcF8F/Re1/Pb/8FkpHxe63jpwzb3Ys2pCnc=;
 b=BPu1XR4rGoSm8XhLi3JN/7MwaH47kzVCJdsaGwdwf2tyWPa65FJP4D7MQJFbWP3yNFbqyH3Ic9etlYu5ZyT+N/7vhSK4jDft/6zjCiftv5oPoMbNhgRBVcri7AGe+9muMDWZKe5B0wrJ/AFdKbaYyJ3NyEx75mjqs4U6AJqlnToyEZPNDV9u6bL+8EfJWlDmIDSR1OoDjhI/VvGAYSPgLda+7rj7SZCp3CFoz8Q46gxUBcVgbtrhqco1/aHMD0q2L0aA0uNAt3t8UxeE+YjFn5KCqmBd/OiFnS3vx7HUsGXZyXHspVBMQYAZRICQeM+WozwG8SbPhgq4EFqGNbzPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om/05SEztcF8F/Re1/Pb/8FkpHxe63jpwzb3Ys2pCnc=;
 b=lZyLTDTy20KoH8H42giNsmEWXUfx0SbBl2KCLgL3d1NMLxE7MLjKKKUGShw9zkJfnPDQTT8ieSNadG5m//tfyrvka/17pNbeRpipuT7gACe2UOifZj6976lVywRMfs4zze0I4yo/Zlf4+u2avzjzUyMcU7hEjaVZxA7AP5u99az+tsm0IpJhUmWYHWY8nDvEQTUadIKHxdnJw8RWBYKA072x7ge4Ql4BT4E1EFYZrbbhZLPauDtUDIC1af8qoiSPREl56E9EVz2EUDEo75Dr90TjH0SEXSwq0EC01KLPNsgiO2PNp16I17BvtJKIujupIPXoHSAF1sAtbXRzfHE6rw==
Received: from DM6PR07CA0112.namprd07.prod.outlook.com (2603:10b6:5:330::27)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 04:09:27 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::1d) by DM6PR07CA0112.outlook.office365.com
 (2603:10b6:5:330::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Fri, 1 Nov 2024 04:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 04:09:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 21:09:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 21:09:22 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 21:09:21 -0700
Date: Thu, 31 Oct 2024 21:09:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael Shavit
 <mshavit@google.com>, "Andrea Bolognani" <abologna@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>, <nathanc@nvidia.com>, <arighi@nvidia.com>,
 <ianm@nvidia.com>, <jan@nvidia.com>, <mochs@nvidia.com>
Subject: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Message-ID: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dcc4ad-fab1-4a5f-34cd-08dcfa2af9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d1MrKDnzgOIFQXeOAI2oqrPx2rffCc6wkdstcptZIk+m/La4nHh/3OE8LWP3?=
 =?us-ascii?Q?ep2UAu0YBsX3JnI70S/FrhCGc3q9RW0qH9uQYk9TpIvUhXaXtBf8dTZRNA63?=
 =?us-ascii?Q?LlqDp6WEjIa4GwChyJ3NZQa43ZvCn7jMZv+4c/HKeMZt3FDE+WwkZsXf3oTQ?=
 =?us-ascii?Q?UsEn/x9ouJ+dR1v5BjpBxd06ELcQoJGDa3R0OUFqQzfOx7ul9qzozalBnt4b?=
 =?us-ascii?Q?9L9XzsF2/pqFtN3bsVFgGNvUwVb9h1FcVjo0EY9CSqw50btPGZFQEtmUTaJH?=
 =?us-ascii?Q?hbKXQDG0WIOR4v1/vnME8jFppJDno3ze+tfOcQRo7w+b0SRbH/69l+sZxXvt?=
 =?us-ascii?Q?ygfPrxSEx5whIbTE/Rr4P22VE7/DDZRIoeeKadSNBvAR9ppCD0ktDshjeZPp?=
 =?us-ascii?Q?gQi5ZMfl0tDAyLCqThfYm0ZGOnLmQx/OR5u5+6CWWKhO6mNh8Dx5AMUABaH1?=
 =?us-ascii?Q?261ZeSZCbahkzVKqrBkVb/ETvGhtJTF28WTH+HfAxrKyQLeIk59hnP00P0/o?=
 =?us-ascii?Q?6RNMt5O0c0WKYxRrlcPr8yYBEdP30ORH+2jKsE4ZPUq5y31KXDuQvtxzYBd3?=
 =?us-ascii?Q?H7fLgEJBmykloMjLYF1TqLUGK+AffkbUtme3Wb5RdgUbsmdFFAzhEBvTGpjM?=
 =?us-ascii?Q?3UVyBMuRRIVDQTm+/U+NvMZ6cu0G3wbLFsSh8k5aDm+V0o1Aw2VwizthQp0h?=
 =?us-ascii?Q?0cQiYxdeKoDzlwQOddfBLBOIbqDPXgyVbLRT4Y1ylKVIZtmBIYi3poCrsOqx?=
 =?us-ascii?Q?ZXJypCnAo7u/EmOOdjGpMafVp+3o2ekg1lPytiSN004T08q5nkgrXwHGR7wR?=
 =?us-ascii?Q?VAmMOskwlkSe9KsSDoj/UZ+76tUrvDmViW0jv10M0ct2JdCb0LwDagBc+624?=
 =?us-ascii?Q?GWqjBaYSJgNEiP7SHyAye51HZ9IrlzIl4Eq10TdHxnTw2hBlMqE32D/Ax2wn?=
 =?us-ascii?Q?eDoluSC20CxYvjznrtLqnOth+629iPBK1v+wrqu23KWG7DGOP4auPZ+peSMZ?=
 =?us-ascii?Q?oDFKJPpovH7MQOSDXs434uXB6dR5Posycr9VTXTH1SkOVDNcZgIrFp4nm+e4?=
 =?us-ascii?Q?Oys0TVsu5aGZ0HaMwD+B2pmWZPtI8BOLojuu5e0905kySm4RhMl2GrAAzn18?=
 =?us-ascii?Q?uT5P4qvX/tV9DNjgpEG9c7I4/ppZ4v08QjetBjYKzzlna0Wc2xG3tu+3DwwI?=
 =?us-ascii?Q?H9/Or6sz0hR0ZTy2oXikbzr+kcaR7Ow0wZAlMUaAsfhD6Gn2MsQLa2hHK7pZ?=
 =?us-ascii?Q?/tn/E1LwuTabeyPP42xF+waDXIx7vARY+pIFdw5HJujxtsZlvZXkYoMUC1KX?=
 =?us-ascii?Q?GMTcclI1/DRLtdMxvW8G4zA4tOjtd5N8w114V3kZfnX3LoDd6ntxxAHqemiq?=
 =?us-ascii?Q?AVGMiSljdrGlN5OyDRv3DReQ1vbNePkYw5BNarCDQgRlGGeOCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 04:09:26.8183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dcc4ad-fab1-4a5f-34cd-08dcfa2af9ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
Received-SPF: softfail client-ip=2a01:111:f403:2009::603;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

Hi,

This is a continued discussion following previous month's:
https://lore.kernel.org/qemu-devel/Zvr%2Fbf7KgLN1cjOl@Asurada-Nvidia/

Kernel changes are getting closer to merge, as Jason's planning to
take vIOMMU series and smmuv3_nesting series into the iommufd tree:
https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
https://lore.kernel.org/all/0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com/

So, I think it's probably a good time to align with each others and
talk about kicking off some QEMU upstream work in the month ahead.

@Shameer,
Do you have some update on the pluggable smmuv3 module?

Updates on my side:
1) I have kept uAPI updated to the latest version and verified too.
   There should be some polishing changes depending on how the basic
   nesting infrastructure would look like from Intel/Duan's work.
2) I got some help from NVIDIA folks for the libvirt task. And they
   have done some drafting and are now verifying the PCI topology
   with "iommu=none".

Once the pluggable smmuv3 module is ready to test, we will make some
change to libvirt for that and drop the auto-assigning patches from
the VIRT code, so as to converge for a libvirt+QEMU test.

FWIW, Robin requested a different solution for MSI mapping [1], v.s.
the RMR one that we have been using since Eric's work. I drafted a
few VFIO/IOMMUFD patches for that, yet paused for getting the vIOMMU
series merged to this kernel cycle. I plan to continue in Nov/Dec.
So, for the near term we will continue with the RMR solution, until
we have something solid later.

[1] https://lore.kernel.org/linux-iommu/ZrVN05VylFq8lK4q@Asurada-Nvidia/

Thanks
Nicolin

