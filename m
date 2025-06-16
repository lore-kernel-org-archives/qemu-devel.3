Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253B9C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 06:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2xf-0007yO-U6; Mon, 16 Jun 2025 02:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2xV-0007wj-N5
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 02:04:42 -0400
Received: from mail-bn8nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62d]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uR2xR-0001Kq-BR
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 02:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odeC5jqVbLP3kS0wl6Jl0zvs82chxaoMKdbbyU0mR2JTNGJV3tlsDQKmbKcCHlZIYrKzGRBTpBqQIFvVVcG0Xbhwlry7qGTFaqWYmPqvVtIY+/vXHI+HHEANzihwxI0Q3XGGr525BR4A5rX7h/cRaVQlSLsHUntZYwram18VN2ITrs0LxyX+6VqIj/otwJkmOoMQ2A82841Lmt2X2wEN0pP/UjXcNCEtA56rOblVpPM1PtZWJ3WH9ZpGuVdFl83/psmkA06VcfJN73sVZ9p91ibv/GnSclNfK3wt4SwGggZHpuHGFJXxLUG55f1Sxz7z66h5VvTmB6c1gq//mN41cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+4lRxSCTM/pRdrR79TXJkJu5ZCtnvhbGK0bXiaDjSg=;
 b=Mb7J+HFop9Ch9dOwR7QChdjXuRN/pgVEi4lz1GZivzcAcyn+zTTHcW1wl0zEWp+9yCXeosd1dK8ITQ00Ch6xXRBnSMasSgXNlSEknuqTN8aa+3bWzGvit/IQ7AhIxFV/Ojrlz87u2Qmpy8Q3rAoHa6VkoGtO+NsWwtQNnT+NTnV8DMBomk59bjZ0xhnK+5usmVifPrQ/u/kI8xcekbGdtAuNxWektmTU4iDd9p/lHLTJXQWtIyZfgG5D/g1aOjNoFXzVhIv7lY8jrFtZBw6cTBENXkkxxk6ZUVIC5RSwc/t4QQp6e++Xk4SaN9+5DLTWJLl1AI0+xXVCwaqQRtVPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+4lRxSCTM/pRdrR79TXJkJu5ZCtnvhbGK0bXiaDjSg=;
 b=qkfb56Fsdbhf2dKTcl9ybq+s9xRGF8hko0RxD/C2hN/OoLW3fKH8PNQwg+ZR8mbTCKv//Go9y7K/VGhL7AfEDMPuGLixuvQlienh8+Lzkt5CmceWIP/1c/Bl1fy2yRCHE0tReSAWETptWfhxtn0RjZOHsNAQpx2xDkpUDHqOza5gP9DB34jemAFGErrP6rxx/CXUQReKdAtKDgxkAB2ZBwFZIPaJafU3WlsU61u8KuO0TOpwuxeg9CmIRcxAvgOMkEj4xSO5jR0ADeTSzrjk/xClQqhKOytuBiYQiF0Pgsw3/ynysQbhYdeoNdUpO5yLTpefDu3FOwRW1wWsNY2JKg==
Received: from BL1PR13CA0117.namprd13.prod.outlook.com (2603:10b6:208:2b9::32)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 06:04:31 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::60) by BL1PR13CA0117.outlook.office365.com
 (2603:10b6:208:2b9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 06:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 06:04:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 23:04:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 23:04:15 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 23:04:11 -0700
Date: Sun, 15 Jun 2025 23:04:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
 Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <aE+z2gGLcxNUuODW@nvidia.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <7b684d1b8454496f9a302c66298daf37@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b684d1b8454496f9a302c66298daf37@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 11014934-04dc-4213-8487-08ddac9ba7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kp4BFz0KF8shlBQ0+gHznv+7IBX7n3tg/9Ga1mqXyvGmaUJMATrJoR/AiGz2?=
 =?us-ascii?Q?N63DsCXkIT36CvIvEd8+FtVMBPqWYAxO3g8VbHd+kAVjGaR8PY9U3Bez32Bh?=
 =?us-ascii?Q?5u+tfpjBU6BxOB0/1NstB1UTJvohKvj+3OHlye0OTydB2VK58T5rm25fFfxy?=
 =?us-ascii?Q?i2Rrv7EzB6/+N/kuviAdFOcSWguXJQjcOQw44DHYaoukKbRB7Pf2B1Sg5Fts?=
 =?us-ascii?Q?/kMoarpCc/u4tMMXZX2tu5COCGAF8CVTLrAgfgXqWtDNdZertZhWXkF0Xnup?=
 =?us-ascii?Q?d4I3WkfyLj/qJX/kIMk9dbDzWT5YOk687ofRnUzT4D1e5fFQ74uAv2XHpPc5?=
 =?us-ascii?Q?GBqO5skueDuZUCYbOsCWFCjVilLYFXxmbBB6wWR1Dq6lY7IiqV1L3772zXdV?=
 =?us-ascii?Q?dz9OKRkSlh7CbxSwgVw5yBTQTCVM91DBE9YJh3EfnYfz7dXeEsZYPPXFVCoR?=
 =?us-ascii?Q?TyI/M198AHRIPg25hINF/ng4PXo8WwYnp/04/pbFi93ELd1kFKGVYuErFttQ?=
 =?us-ascii?Q?PfuzF7Ay3d7k/oGt0Gwd6JUEOW5AKp2uAUQUA2auyZ45we1PXy92pCreJZTP?=
 =?us-ascii?Q?/AiYP7aCQbpfYGmfp1hMepfUTJHEgkKTCCsDoLfBZlFKx99435tdvZ02wido?=
 =?us-ascii?Q?rFbgh1xoNIzALl/xjYWUeE5Cgr8+/nHwnWxChGip7AnFEZes1JMFtZ6YHX4y?=
 =?us-ascii?Q?ttp1lV3jxNJTIW4gEWCHTWPgG63u+Xp/ZozxR+WLpX1nvUCIK4Dd5Aqjv3uA?=
 =?us-ascii?Q?1lwOpBxeYcImCHDnSxya1k2NIc+VcQoWFXQnpgo6UO/xTRwcPWe21l+mTECp?=
 =?us-ascii?Q?IEJoF9s7EE1YaSX+0WElFENtPmTjA/XLISF5GNaaD8yfZBJFDhQ18jqr7D7N?=
 =?us-ascii?Q?J+djOb0RnJYBLDBllXiyPWIFArzueGczD33SFdcNhK1aG2NkCqQjh4v05871?=
 =?us-ascii?Q?iSxZnoJwjqWflHdeeb9z0nb4dUpyoHuF23OEo3BMoFJbVJl7/SMGp8+4hec9?=
 =?us-ascii?Q?3SDX6XITER+48Ev8keY1Bx4ameQyuBEk17sgJtCABL4GkT21zpZegSJjMQfI?=
 =?us-ascii?Q?r+DAkFXIfIoM64kYUyyh9RuPxPkYimJ0Qm8Be0qQzcGzySLIJi7T4XNQsvIC?=
 =?us-ascii?Q?XGCdOlcRR/chW6QNpHVkI6BnoUfpv6Kb7s8IMyg8NVu7LAe4tULikpKrsvdP?=
 =?us-ascii?Q?0n5mzX02+mx5Q3uk1xgvPihqe+72vzxBAr9wd9r6Yxvs1D3lKRUuylrotz9s?=
 =?us-ascii?Q?8BHvTRTUAfCnLZiPQzCCYsa5kWeQNIkot1I6TprZiDvAIEgm3fIV5cFlobjX?=
 =?us-ascii?Q?ZpcaCbvLgvs68PmgXZCQV/6DVAjYxmXvUef1oTT+PrhufA1arrPqgLiEeh0q?=
 =?us-ascii?Q?TPeJqAvqWG5OqQzO2fK09leuf2rHXvxuna0w2toYBNdDdrLYTQdbMR51oRd4?=
 =?us-ascii?Q?D+vSz8jZA0ydGqTU/N2opeS9UNtQnlH8pCiNRQlMsHnKLIPWHM3yVmqi6eeP?=
 =?us-ascii?Q?FE96luDNpeMNkvAqblJN1r/VM0D8FgIIXtK2?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 06:04:29.3479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11014934-04dc-4213-8487-08ddac9ba7ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
Received-SPF: permerror client-ip=2a01:111:f403:2418::62d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Thu, Jun 12, 2025 at 02:06:15PM +0000, Shameerali Kolothum Thodi wrote:
> > >> The "switch" in vSMMU model is only needed by KVM for MSI doorbell
> > >> translation. By thinking it carefully, maybe it shouldn't switch AS
> > >> because VFIO might be confused if it somehow does get_address_space
> > >> again in the future..
> > 
> > @Nicolin, not quite get the detailed logic for the MSI stuff on SMMU. But I
> > agree with the last sentence. get_address_space should return a consistent
> > AS.
> 
> I think it is because, in ARM world the MSI doorbell address is translated by
> an IOMMU. Hence, if the Guest device is behind IOMMU, it needs to return
> the IOMMU AS in,
> 
> kvm_irqchip_add_msi_route()
>  kvm_arch_fixup_msi_route()
>    pci_device_iommu_address_space()  --> .get_address_space()  -->At this point we now return IOMMU AS.
> 
> If not the device will be configured with a  wrong MSI doorbell address.

Yes. The KVM code on ARM needs to translate the MSI location from
gIOVA to gPA, because MSI on ARM is behind IOMMU.

> Nicolin, you seems to suggest we could avoid this switching and always return
> System AS. Does that mean we handle this KVM/MSI case separately?
> Could you please detail out the idea?

We could add one of following ops:
    get_msi_address_space
    get_msi_address/translate_msi_iova

Thanks
Nicolin

