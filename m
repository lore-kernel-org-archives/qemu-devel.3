Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5925CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 19:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqHF6-0006b7-De; Thu, 06 Mar 2025 14:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tqHF3-0006aM-BD
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 14:50:50 -0500
Received: from mail-dm6nam04on2083.outbound.protection.outlook.com
 ([40.107.102.83] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tqHF0-0003X3-8N
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 14:50:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKapjLoFINXxKnIXq1ICxXwUNZYjhCEZkvCDNiheSmLsIj+KgpuTbK+ivlNpJVnQoPkqDndseTszVRcCya/9AT/FJ2ZJnS2wWOWnCfe9Y0tpbbqFid0n9jcrolUb1Q8vckKXAn1QDyC/G22tjfuKl78u+20nIkJqpVTdgIknerOwJnpoVQNO+jtNNy7DrLrJH2664wwIlbfno+fHdXq0wJ4P9M7tXEC+RfmNaU6T74Urx1Rd0l0/5gFyFnkc1n4BGF11US1T/ABrNdQ4o0nVhU66nG8mOWFAJCRCarX4dF+b5tApdrm9m5b+Lix1o9Kb7JhBPUw7hu1Ddim022lRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzhXS+ouWVbtFIMyA75K5Zk/B6kA0381AqrIQTw1CWw=;
 b=DKcm9z0xdTXkrHPc90AzdAyZuJS2z3Kka5buKPao/DDkl6dYmKZSBD51B4KkihXNsCePk+Gb45hFNyjHeD/i+kTde00ENtJz9NRyzBFVvqJqf7On3inhVx9n0KTwsHuX/vQYou1huWoNPucY7YIEmpHmpTaq6jaQT4w6M/RiKV29L5qzfVWNYykd8QhsuoDUt/p256QahVSPWDMUUjRVYMj0dVW2AAhCFpBjfupApEM4EPc01CoMcNkQNvXDL1hWm2ImiuZC4vI8BVLSMFTx7eFKf55rJwyhJIma98iB+dpfu9z+DcwkiJU4rwfu39HmybsN0jCEEMMeHG6FkKxWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzhXS+ouWVbtFIMyA75K5Zk/B6kA0381AqrIQTw1CWw=;
 b=tV8d99fkY10FEKVbJkRb73DvRWN4XkzKBar+5CD48M5arbFsnez+OjT0IfYy++6U7mjUgAVBCIzPTco9EGWb8BhXfAuP+dtV10qvvYanCwJxk/VSL3F8BBgNUiqWF3uXiOuJURDZSCNRtDhp4f0a/fbS3/s/FosgJ+FQDTCt5xORkJ+RieYFd5+HpymLBaI+NvWG5gEg4N5aD0j39JISr3my2jJEFIIeT3v33impa5q008+smloCxK5H9Mc0KTsl2kmaNhbG1i0XeB9ilQZt5iCqTm3pbS1INgrqH3nVjQEgZlOAAY4OAkLhdbRNY07a+NZ1atg98kB66uvMUrDnFA==
Received: from CH0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:610:74::15)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 19:45:35 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::ef) by CH0PR04CA0070.outlook.office365.com
 (2603:10b6:610:74::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 19:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 19:45:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 11:45:22 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 11:45:21 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Mar 2025 11:45:20 -0800
Date: Thu, 6 Mar 2025 11:45:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH rfcv2 06/20] host_iommu_device: Define two new
 capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Message-ID: <Z8n7TwzKoLvl5XGF@Asurada-Nvidia>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-7-zhenzhong.duan@intel.com>
 <4f13004c-a6d9-4f45-938e-3fc8d49183d7@redhat.com>
 <SJ0PR11MB6744FAC917F2DF9A7BF9FF9992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <0ccbf699-e6be-4936-89f7-b4f69672516f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ccbf699-e6be-4936-89f7-b4f69672516f@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: a707e251-0063-4339-880a-08dd5ce77690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?joU/gCPX36KZcYK6VossADIixLTSD9/rBSS+0D/ie+9Je72OqCHVoji1RoZn?=
 =?us-ascii?Q?rCxzTm3EQoMPdimr22ajbom0yoXiHjXbEVphGE1Ed9bOsgppPHIQGVTT0l4T?=
 =?us-ascii?Q?uBnb/iwFK/nlzFFegcMx5SppRqFAx5ancUjdZA4JUe9jI0vbhi0SUwNYHQLO?=
 =?us-ascii?Q?HgmcotvHGTu6XMSDJ6C1m7IBHUCn1gQp8hLZ1pWLWe218JTbTfkUep4fmi8B?=
 =?us-ascii?Q?/u9ERPGvG+demZmf1h/c2Efx8ZL4OiuxNJagzyhx55N/eZH27nUvMayngshy?=
 =?us-ascii?Q?Bexohu4nRC3suC5vEt55AJyaEoK0vJGyTFQgRhIAjxYGka6gG9h0sBp2lyls?=
 =?us-ascii?Q?CS5e6pJgHvBeYHK5FxD/K3qBk19Y2yiI5E2mIgwUvyTck4Fty7iGLliBwxPf?=
 =?us-ascii?Q?iLTCn4MSV8kq9mu/zmARMpQG5skxhbmBA0gvU3qn9a0RsNiUd01x8JaNcAQU?=
 =?us-ascii?Q?1MCTZ1Ui7se8ShBvVd6tq2NqFLfOV7e1EEIztxM2+WhXU8iMp66xcFA+1v97?=
 =?us-ascii?Q?G4KNXrIiDxFhoPMsGV0klFoKzq/gb6NZDpJIJQ0CtPMUG5rkSYWqnNSwIqwj?=
 =?us-ascii?Q?6EqwFHqrUB4vskb1bQVHN2qhY2PHKqshPptb1Co0sY0bx3R9vCvN2pqZouQH?=
 =?us-ascii?Q?TNNnjXXkv2OKfA55nXcCA/g2Yf/aN+pH3el6hbyUifN5F/lAWr1sM9Ig20wp?=
 =?us-ascii?Q?2x9mes41uOPyTlbEX9G94p9dUrUTNIgf7Je2xm9/s6ZY5/6d7E/f+zPOPNl5?=
 =?us-ascii?Q?Osb5cZxSalee+OGpuVEcBMZ1w6yhbkhJPYkTAx9iYXkQFPGuU/6ED0mymGfT?=
 =?us-ascii?Q?q8IVvf6ZEHkdE9wP19qQlBJQS9QuJc0hxzypnFloxIZu6AKDQYTKi65TZ+Nb?=
 =?us-ascii?Q?1vgERISpBDRFkTVBrS89UMDJSXqzDDJgWRmvoPrBeLB9aMegVCAiqmZf4god?=
 =?us-ascii?Q?6TAv+pXU5HRUTGe7bCyITIGAev7DxMulF5aqdSU2dwa6BwJe8jak6rlpErn7?=
 =?us-ascii?Q?n0NxVqVdxQD/h9LHQooTjCLiZKzVz/w7QiIA4s9JfulArMGpkM/CX1WuIaJu?=
 =?us-ascii?Q?ZZVxNg2OQUzjuQnwo+IjKTut6u8dJH1ZGkX6XGzdx8UwgnWDBat0lnD0eJlY?=
 =?us-ascii?Q?VaKgbIYjWvdgbHmHSTt6HEdj1dw4LPT7o+jd22QuuYygx9okuZTLoeZ2/KMo?=
 =?us-ascii?Q?dE32O5TMicCBUs+7YWHaqs3o8WNxYoV4tQ5gfezE2PtBud6l71FGBad1oGFt?=
 =?us-ascii?Q?yX7opkYayjrQNE24N1tvduES+OiKeiqrCRMFjM+LP0wkGTuarOdDLTO0en4p?=
 =?us-ascii?Q?XH8phkQm+QxwMinLkLHJjFCUKUBzPXAzqZygrObLCGcy5JlDhO9pGaZmEftP?=
 =?us-ascii?Q?hkOtKT1yovg98S2aukisDGxzDs69K25orGNzGjBs9FU22npKobNY+Fk6Mu5N?=
 =?us-ascii?Q?doJr8tGbNrOgz3yYrjONOk9n5Nfknqzhp/xSViYKat7Uc+ipPrtpjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:45:35.1144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a707e251-0063-4339-880a-08dd5ce77690
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
Received-SPF: softfail client-ip=40.107.102.83;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 06, 2025 at 04:59:39PM +0100, Eric Auger wrote:
> >>> +++ b/include/system/host_iommu_device.h
> >>> @@ -22,10 +22,16 @@
> >>>   *
> >>>   * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this
> >> represents
> >>>   *           the @out_capabilities value returned from IOMMU_GET_HW_INFO
> >> ioctl)
> >>> + *
> >>> + * @nesting: nesting page table support.
> >>> + *
> >>> + * @fs1gp: first stage(a.k.a, Stage-1) 1GB huge page support.
> >>>   */
> >>>  typedef struct HostIOMMUDeviceCaps {
> >>>      uint32_t type;
> >>>      uint64_t hw_caps;
> >>> +    bool nesting;
> >>> +    bool fs1gp;
> >> this looks quite vtd specific, isn't it? Shouldn't we hide this is a
> >> vendor specific cap struct?
> > Yes? I guess ARM hw could also provide nesting support at least
> > There are some reasons I perfer a flatten struct even if some
> > Elements may be vendor specific.
> > 1. If a vendor doesn't support an capability for other vendor,
> > corresponding element should be zero by default.
> > 2. An element vendor specific may become generic in future
> > and we don't need to update the structure when that happens.
> > 3. vIOMMU calls get_cap() to query if a capability is supported,
> > so a vIOMMU never query a vendor specific capability it doesn't
> > recognize. Even if that happens, zero is returned hinting no support.
> I will let others comment but in general this is frown upon and unions
> are prefered at least.

Yea, it feels odd to me that we stuff vendor specific thing in
the public structure.

It's okay if we want to store in HostIOMMUDeviceCaps the vendor
specific data pointer (opaque), just for convenience.

I think we can have another PCIIOMMUOps op for vendor code to
run iommufd_backend_get_device_info() that returns the hw_caps
for the core code to read.

Or perhaps the vendor code can just return a HWPT directly? If
IOMMU_HW_CAP_DIRTY_TRACKING is set in the hw_caps, the vendor
code can allocate a HWPT for that. And if vendor code detects
the "nesting" cap in vendor struct, then return a nest_parent
HWPT. And returning NULL can let core code allocate a default
HWPT (or just attach the device to IOAS for auto domain/hwpt).

I am also hoping that this can handle a shared S2 nest_parent
HWPT case. Could the core container structure or so store the
HWPT?

Thanks
Nicolin

