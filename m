Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C8ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 22:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upaS2-0002cw-QF; Fri, 22 Aug 2025 18:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upaRy-0002cB-O3
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 18:41:35 -0400
Received: from mail-dm6nam10on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2413::62b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upaRW-0002J9-6Z
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 18:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf/FTl/dwSMTU7xX9iF9Hd+u0WAL0KChVXJLVre3opCK1XjqgGwQ15BDnJGWgwcdtcjlz2VlK1MpPgFKTtkwlRZPosHnl60DkowxT279Ki0BUFnQKuLuQtZPcOcg97z3HW2SBUpt/8GlGR3HEA5oN3m+aNpG/QV9VH1oqQfAgV0uVozXwz1x+0jfT+MnvGnpIY1PtLi995t7hnl1WjlW/jG6yVtbQzyDqAfoj5UC8+VU1R0NFE4o1735GRin6d43HxJDzWHN6YOsY2G1pjdI+xowDLfNYJZwpnLh7H8z4sZslho4PJ8hVMJ12Q6KejsBjX99RmZMOR8H0F97xYgtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwlUVlSJSJKioi1oxgFe9is9y4pThKn1XRFCrfCEkhU=;
 b=RVx4exRfsFmRPt8kXIK9AxbstjDxVaJ2UvpAT8dvOof64cfrY8EGGWUeR1spF7eOfvz82j2ch4F47aNFTLv3iySe3Lf97UE5BjAIvmChBHjHpD/hrkpuP56uToDr0VA213EF2WbNYyJQ+WGpz6N9eAOiIUJZVrrwU8QHCFCPZTIt+EjLtWCGkh2f0i5/qXOITpqTX4Uihd2nGMVuBF7hIBGdeOfLjbxNnNSsjuKrs7qGnKWeCIcQxgyb/xbh7Ft41n/PRheRBIoeGijCtLHp7NsUdsNwop1It8+9FW1vAqhgcOoQgGw/1VrIn+VkgG7Q4R348/Ik0AxAXW5gyxIH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwlUVlSJSJKioi1oxgFe9is9y4pThKn1XRFCrfCEkhU=;
 b=B09adaAaoCpvpNpI8kOEp0CxHEt3KrBMXNcqiP5KghD8OFwdqVEh47EKF8IVHU/pxIK19uXU7fUs9EEAEjZjF+7DmrE+tF9Jb8hYd+6/dtFq+utmfTaG1ZbZGN5+SeWoD0L5d4iZC2ei6e5OeqCiYFgbFDJXPjvB3MLKTnzSjMLIjaXd1QMWHDHUfjajGvHSE3rGsOxCP/V1Z4t7eFbRFDQoyP1lLi+VhdrJWwdrqgNDRFXXDWA0U2Hb2kj+9V83eznYx2acgebHzmCeFUb/KeQ8x4cttA0rCbNr59qjKBiZkrVUlAZ/WYqkllz/BNIQk8FaQ5PpfsimDtaxGTSaQw==
Received: from CH2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:610:54::16)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 22:40:43 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:54:cafe::98) by CH2PR11CA0006.outlook.office365.com
 (2603:10b6:610:54::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 22:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.0 via Frontend Transport; Fri, 22 Aug 2025 22:40:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 15:40:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 22 Aug 2025 15:40:28 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 15:40:28 -0700
Date: Fri, 22 Aug 2025 15:40:26 -0700
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 04/21] vfio: Introduce helper
 vfio_pci_from_vfio_device()
Message-ID: <aKjx2mckGYSD6bK0@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-5-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822064101.123526-5-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 7048a57c-a9ab-4de4-8ffd-08dde1ccedb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zJ/Yb7j2QDDpCx0ITfD+ZOv+cFf4uICQoKnJ3sXm/kkVC+SjyIo8Sm7e9R?=
 =?iso-8859-1?Q?pMxGCmoP90ttbUAut+IoAR8Bi7XXIsjrrQSxOD6biIgMg6PKuPAscRtO5R?=
 =?iso-8859-1?Q?3vJt0SnBOJt8DDUgiPyBA5fBIIOZ5KOKqTdzCexYv6WHZFYflcIcNhHzA6?=
 =?iso-8859-1?Q?w8NCgYkdiwUWU6tfoeT8xexwf2MYqCKoZN4R0qDd+VeFKyTowt/apdX0g9?=
 =?iso-8859-1?Q?FGI9HE+GnvgPaLk6hqa2weVTJIWPQE3BRwSegMhc7/Ep+24FffEDFY4G5+?=
 =?iso-8859-1?Q?tc2f+2FTcYtAdzCcKMvrZ6OJ+5lP9eCNiprKpca7duF+hvSA0lRwISpB1L?=
 =?iso-8859-1?Q?PW78RidPo+7WV2fwQYN5MFdnJ4Qh/68YTslP8drwSdXuJezbOsVT2XMR8h?=
 =?iso-8859-1?Q?1DvjifkcS54x1n1uZeAAWmsX14MUUFXq0pIdUhIsFsxYDFU5oeDJPEiT+U?=
 =?iso-8859-1?Q?cE8ic884cg6E1qktiPBaRzMFf0zeVNTvwDJOjUTXujEaPKXzfL4OCp0tcE?=
 =?iso-8859-1?Q?2HB8bcQmsZsLpcHxvYroLwvWzhfRDuNqxrMTBa68iNj3KS0qbc7ZDwXaRf?=
 =?iso-8859-1?Q?luyiz9hN/S2UsP2qBOqPeSWidzzlp7c4DU/cHt8epGWkzrKqPJllS+gjLZ?=
 =?iso-8859-1?Q?4sG9QobwGEAU4OEqfBXoG1s61Hb8JKx18YoZHM2eMW+F1cNFdaycVSbKoc?=
 =?iso-8859-1?Q?N9EVD/L2+dor45WfRo4akXNUyjbJOlEvT6gHFM/2/JTR64qgS1Sj09JUNa?=
 =?iso-8859-1?Q?/jy5nqE3iKqfXAvXmztDuEREQf+zwR3s3Mf8DuTYb9pRWUuXW0YmE/say0?=
 =?iso-8859-1?Q?iMhizcQBeVhQfepP44R5KToA+UR5gVKLc2bfezOKapX73WN8lL+0Pc0T/j?=
 =?iso-8859-1?Q?jm/rafh1LNB5GYyIVmPrF/4y9wRgXdL5FmKYSZ59L4v3Br2SeOSt7RvyFe?=
 =?iso-8859-1?Q?rwRDypIeRpZOJ6tfw6PI6sXMeHUf+/NiRPcjxO+q2/sx6xZp7Yrwf/o620?=
 =?iso-8859-1?Q?Hne7/3vpVOKmytD8vL7uSEnxE/Gv9p1gbcUI0Di0sEUKJm8MkrsdQOukCX?=
 =?iso-8859-1?Q?UVVHrqmBXzWvF6KpaO80xBAPlsEPDY+pSe1Fpz+6MCKegdVop66UI6DUb2?=
 =?iso-8859-1?Q?1FCR4PQGbf814HISi99Rkj9laN3ugh/guHB+mi0MP4nGibry7GN7fesJK/?=
 =?iso-8859-1?Q?8ahQF/HWDI5jxM+ztdUAKKk3ZUyJh2+NPnZjmWWQiNJZrC7+F6A7KtLfRE?=
 =?iso-8859-1?Q?M9L/KEfomB8+5stnU2W13ofQrCZK2/w4k4WAxHml913tbaZ4O2Amq/n6U0?=
 =?iso-8859-1?Q?cHrDAOp5gS+F2Z6bGih8RzuVvVT/uEIt7DegSksQuwZA5f3/EBDWfU46UL?=
 =?iso-8859-1?Q?XlfG5Nw4OgY7KNLhyQBZ4qZpeY9IjijRhcbsWu02BA9MN2VLt0HxkmDzJT?=
 =?iso-8859-1?Q?sKpJ78frUn2b5a1XPQMOgDllVzk3AJyjlbaBRWgIf2onJOEydoBGLBC/O5?=
 =?iso-8859-1?Q?B5NVyq3C6xWcPfPJ8x3MHhJLyUQ4Vg127E8ZQwqFa+OLLpE5CaVbau8Y8K?=
 =?iso-8859-1?Q?td/aHAWQrNuTHH9ghRLpJmUxaaDdBxuPhBDG1EPXpxutAWV4DA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:40:43.2709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7048a57c-a9ab-4de4-8ffd-08dde1ccedb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949
Received-SPF: permerror client-ip=2a01:111:f403:2413::62b;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.399,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 22, 2025 at 02:40:42AM -0400, Zhenzhong Duan wrote:
> Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
> to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250801023533.1458644-1-zhenzhong.duan@intel.com
> [ clg: Added documentation ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

I think we should drop the link? The link points to the v3 that
is not the officially accepted one now, as this PATCH-04 would
be? IOW, the commit should probably have a link to this patch
instead.

Also, in general, your "Signed-off-by" should be the last line,
when you submit a patch.

With that,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 810a842f4a..beb8fb9ee7 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -221,6 +221,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
>  uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
>  void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
>  
> +/**
> + * vfio_pci_from_vfio_device: Transform from VFIODevice to
> + * VFIOPCIDevice

Nit: this could fit into one line.

