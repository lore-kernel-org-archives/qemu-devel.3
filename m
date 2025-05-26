Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220A0C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 17:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJbp1-0007Dx-9G; Mon, 26 May 2025 13:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uJboy-0007Dc-0h
 for qemu-devel@nongnu.org; Mon, 26 May 2025 13:41:08 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com
 ([40.107.236.51] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uJbot-0001nQ-8c
 for qemu-devel@nongnu.org; Mon, 26 May 2025 13:41:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aourH0rdgiMfheSF39nluBMcUl/Sp9ZvxiCtVqjPzLt+f6lf/gks252ISlNhblIFv111AING20+v0UjGqPkGSVWTCf5z2xL9S3J86PXrX6c77nWsQh3XuTtd8WztP771dKz8rrVjaWkdWVx16bloTKlOM33rFzztlQ8TErEqh0vnnOIZkdt1XGw5n1i9cWRFfpKIn4Hm/tDKyk9dXHl9/apnZ5MABU0N7/9BmBlgQujPKAgTpUNTQRGL6BFyO8Cd/7E5BdZ481YeayGBBsCLh+g4YJN36Zngi3OI9mSMIdkZj3rHYC2iu/MEQ09hv0VaFakTHGYUlQg/AIybtKWEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EtPDFek8wGIVBPXmgVoQMF3aJBTHyzWdqoLalYFq0I=;
 b=TanFLO3dGOpCRguIwu+gQq4siV1OG1fFTXB5ohoA+23JSg2tB0eRM1VvBKbztbymRHGK3MTjXmrX+lKX74tHVkvnc0cCJAdrFzW3D3sEItH6jucUwPxMFo1ey1vAy213KuHqwIk5sJmHOnZERsvLyETzR5dfHdi9+gjE/gYdR7cagK9xCpMMU1HAHevAnJwkoaHVq/r9WO5cLzXl/NYLtoEtHG1Sdx65rC+gKYgoDFhuCBk7teD6C1EUvzNQn8yMvl8n56J6PHYUSr+/xLO5fYvnXKVZF8vSR7uHIBqwkQgE1zIv6MdWLKmx0EIwxGozZScpJnqudwwtfQYz6bH+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EtPDFek8wGIVBPXmgVoQMF3aJBTHyzWdqoLalYFq0I=;
 b=Dw4/Io5nCf3BmEuDJbP2HJOn4ZO/XoxzK3L5ICog1Zz/+x3pc+0L7TFNChUGcOWamvXqf/rJN/rjAUAjHjrUfLbR/HI9LTksHmOr23XevypcN9keQkShL9tsFQlePpPh4pLGixTsEYz+FvpNEx40N7xjzUum7iT+TX/l9umDTFofVRCtsrC0OAaWPaKgE8iXe97YDEXJS3GFFIEvlsekuBgknuNxU+1ixKNig5foaHSCX7xhcCvxVs0D8dlvkX6wXrMM/RXCeczM/4YjNQlS8AyTOIoUwpMEqqQ422/pFWwBJGkfhPC/lRcubhsvAmkHfKQGkZSqdrMHXugk/lfe1Q==
Received: from BYAPR08CA0052.namprd08.prod.outlook.com (2603:10b6:a03:117::29)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 26 May
 2025 17:35:56 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::d5) by BYAPR08CA0052.outlook.office365.com
 (2603:10b6:a03:117::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 26 May 2025 17:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Mon, 26 May 2025 17:35:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 May
 2025 10:35:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 26 May 2025 10:35:49 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 26 May 2025 10:35:48 -0700
Date: Mon, 26 May 2025 10:35:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: Peter Xu <peterx@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <aDSmcvZ08jNOSr05@Asurada-Nvidia>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a4f45b-3e18-487f-6a1a-08dd9c7bc501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RP6O8eHKbQVn9i9le/g6gRvYEiVQJ1XtVbzhLTuEzy1b8Su9FLlJ89nCL9cj?=
 =?us-ascii?Q?FpXHdj9/zAKHdhirL2TBxY6aN00NJHTzA8letMd3dIg3utqf787ehhP9ak7k?=
 =?us-ascii?Q?Y3x8ZD2MaYWRBy39IohLyMgTYJ/S3uPqK0HZkBw8UluXrZ+bKjIMzAm2zTTy?=
 =?us-ascii?Q?dxYpT8y+jhLQfQAc4ZCGkcUuwfd4dpdCfLxLbV7dcbPyXw1JLcQ15CQZkxo3?=
 =?us-ascii?Q?s57RykpJd8ZrJvVLuwum0RmcMP7lwjB+uGZBZLHaxuGWs57VxpKTePPSDO/s?=
 =?us-ascii?Q?ID1CP2PCqzvDXEuIwn8hoNO54sDhHriV+8ipTq0zDXkSoI00wS5AFm+wCYlq?=
 =?us-ascii?Q?qtM7LQn6hVQuwa+wxFGuDR5PozpBUZEJmdTQ6pL8H4V5yP8IWpPQOMjxZy5B?=
 =?us-ascii?Q?lBzVvwfjSik0KQgFJppuOoEQEqeMBBUl3Kjfw9y8yaxGqwpF82+qVBBNwzl0?=
 =?us-ascii?Q?ypgHy7ctKouMV2vMNoyrtKLd5XUT4di4UPYsLzY3hDqHtBAqFgRgmQCNsPd7?=
 =?us-ascii?Q?Gokj+JV1YvhYXcxBc/yh8MnZaP5zjp7yWWNhiRVYfbqYCGv3LJ5RCQ83/Kqa?=
 =?us-ascii?Q?+2JbEwmrw2jwsXj/UMgGF7Syggb3kxA8EjWXtIt1KkSeEbYVLKskQhR8RemS?=
 =?us-ascii?Q?7smsZl7R0A4d1Vw7E2ld00UN7t1yOPGsooVq73EWGVNCHJd3Kk9fgCJRvVg/?=
 =?us-ascii?Q?DYKLsNPUfs+8zoQfI1sh1Fd3upFryaH+7+IaftXBxsd8PDW32b4KEJx6hslT?=
 =?us-ascii?Q?S8/qSsQ3zOSjZHApg3PaFTLEirRZaNy2Tl6QkiNttc85RWf0WDAT+gVpZWSn?=
 =?us-ascii?Q?Kxa+uSWgjcZy0c9j0eO3JGp4S26B2fx6Sfpp5YcpZq8mCNR+/eBQAyfii9Oq?=
 =?us-ascii?Q?NnMPzUSTA8h9GX4wwiTPSZq6bIYF3oTteYsRjL4hnUj6/0ERtyJat8ZOmpvf?=
 =?us-ascii?Q?8GKHol0Va0UShTK/vuoM3b+R0pc+Tsw1eQaTYj6HPqBo4e69b/BdM1KlfF0h?=
 =?us-ascii?Q?bCnzv2u9rLP2M0/mKIda3oVmLOPSYhEGJEgPtdNL2lrCcIOF4LAlg+0q1hXO?=
 =?us-ascii?Q?lP0tan2kRBi5z3LVsK3pP+3C2yGuiQ08ra2FrLRC1DUOUcl/XTxAlRVVuh1j?=
 =?us-ascii?Q?31wQ7+JBhu0QiVATxshyuFfNJnARsTeRITpBqrDhbrcekb4tmJpnth9DE5yI?=
 =?us-ascii?Q?OmhRU8xxe9nCZHGndtxsESlFehS9EUZff+ms3QFe4lM5ITSzHoqxzyVryLwB?=
 =?us-ascii?Q?Asq1aTM24+nzrg9+Png0WxzXc0RErHr/06zXFY10Lzd4mEJl1lDyZOoetPMT?=
 =?us-ascii?Q?J4j8Uv3xbbSdplIREQ64FHWT3RLUVhngHxXVxpGx3dN7cYeb0ac4pLmMU+Ef?=
 =?us-ascii?Q?aT9MtM31toF+YPyxrx9V42RQ6idrQU0vIIxbIEjGeiK/5eK5jlRQX39yyFHV?=
 =?us-ascii?Q?R94D02tJf3NjSQr8kW9tztOLnXveoBhS2BO8odhwi/y32wJvZRitvV8k1GRD?=
 =?us-ascii?Q?Y5ttkJpDkPRM0iB+UH/v446usefiix9PZHgE?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 17:35:55.5139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a4f45b-3e18-487f-6a1a-08dd9c7bc501
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
Received-SPF: permerror client-ip=40.107.236.51;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

OK. Let me clarify this at the top as I see the gap here now:

First, the vSMMU model is based on Zhenzhong's older series that
keeps an ioas_id in the HostIOMMUDeviceIOMMUFD structure, which
now it only keeps an hwpt_id in this RFCv3 series. This ioas_id
is allocated when a passthrough cdev attaches to a VFIO container.

Second, the vSMMU model reuses the default IOAS via that ioas_id.
Since the VFIO container doesn't allocate a nesting parent S2 HWPT
(maybe it could?), so the vSMMU allocates another S2 HWPT in the
vIOMMU code.

Third, the vSMMU model, for invalidation efficiency and HW Queue
support, isolates all emulated devices out of the nesting-enabled
vSMMU instance, suggested by Jason. So, only passthrough devices
would use the nesting-enabled vSMMU instance, meaning there is no
need of IOMMU_NOTIFIER_IOTLB_EVENTS:
 - MAP is not needed as there is no shadow page table. QEMU only
   traps the page table pointer and forwards it to host kernel.
 - UNMAP is not needed as QEMU only traps invalidation requests
   and forwards them to host kernel.

(let's forget about the "address space switch" for MSI for now.)

So, in the vSMMU model, there is actually no need for the iommu
AS. And there is only one IOAS in the VM instance allocated by the
VFIO container. And this IOAS manages the GPA->PA mappings. So,
get_address_space() returns the system AS for passthrough devices.

On the other hand, the VT-d model is a bit different. It's a giant
vIOMMU for all devices (either passthrough or emualted). For all
emulated devices, it needs IOMMU_NOTIFIER_IOTLB_EVENTS, i.e. the
iommu address space returned via get_address_space().

That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
for passthrough devices, right?

IIUIC, in the VT-d model, a passthrough device also gets attached
to the VFIO container via iommufd_cdev_attach, allocating an IOAS.
But it returns the iommu address space, treating them like those
emulated devices, although the underlying MR of the returned IOMMU
AS is backed by a nodmar MR (that is essentially a system AS).

This seems to completely ignore the default IOAS owned by the VFIO
container, because it needs to bypass those RO mappings(?)

Then for passthrough devices, the VT-d model allocates an internal
IOAS that further requires an internal S2 listener, which seems an
large duplication of what the VFIO container already does..

So, here are things that I want us to conclude:
 1) Since the VFIO container already has an IOAS for a passthrough
    device, and IOMMU_NOTIFIER_IOTLB_EVENTS isn't seemingly needed,
    why not setup this default IOAS to manage gPA=>PA mappings by
    returning the system AS via get_address_space() for passthrough
    devices?

    I got that the VT-d model might have some concern against this,
    as the default listener would map those RO regions. Yet, maybe
    the right approach is to figure out a way to bypass RO regions
    in the core v.s. duplicating another ioas_alloc()/map() and S2
    listener?

 2) If (1) makes sense, I think we can further simplify the routine
    by allocating a nesting parent HWPT in iommufd_cdev_attach(),
    as long as the attaching device is identified as "passthrough"
    and there is "iommufd" in its "-device" string?

    After all, IOMMU_HWPT_ALLOC_NEST_PARENT is a common flag.

On Mon, May 26, 2025 at 03:24:50PM +0800, Yi Liu wrote:
> vfio_listener_region_add, section->mr->name: pc.bios, iova: fffc0000, size:
> 40000, vaddr: 7fb314200000, RO
> vfio_listener_region_add, section->mr->name: pc.rom, iova: c0000, size:
> 20000, vaddr: 7fb206c00000, RO
..
> vfio_listener_region_add, section->mr->name: pc.ram, iova: ce000, size:
> 1a000, vaddr: 7fb207ece000, RO

OK. They look like memory carveouts for FWs. "iova" is gPA right?

And they can be in the range of a guest RAM..

Mind elaborating why they shouldn't be mapped onto nesting parent
S2?

> IMHO. At least for vfio devices, I can see only one get_address_space()
> call. So even there are two ASs, how should the vfio be notified when the
> AS changed? Since vIOMMU is the source of map/umap requests, it looks fine
> to always return iommu AS and handle the AS switch by switching the enabled
> subregions according to the guest vIOMMU translation types.

No, VFIO doesn't get notified when the AS changes.

The vSMMU model wants VFIO to stay in the system AS since the VFIO
container manages the S2 mappings for guest PA.

The "switch" in vSMMU model is only needed by KVM for MSI doorbell
translation. By thinking it carefully, maybe it shouldn't switch AS
because VFIO might be confused if it somehow does get_address_space
again in the future..

Thanks
Nic

