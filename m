Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDD6C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBcg-00008w-JG; Thu, 22 May 2025 15:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uIBcd-00007B-HI
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:30:31 -0400
Received: from mail-co1nam11on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2416::609]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uIBcW-0002dK-VC
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:30:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl/Om+k7tD9Mf7x2gNx/641RTa9NEbcuMQh4Y976tspV34UhLj3WV1Gp2so8P2sWyur+yJbe7MvJDplWs73BfvN6U66cMvHIEUjt64BUCfEX6tmaApdoJXuAdSrlOgClfkwSSCTPc3S8p5oGYEZq7O6hbOYrBmPkhCTjh5uV5hJzoTgqZE5gBdfUywd+5ZPhVMM6ADLrX86BPcGraovLi8kaPwSUxonWbIddPo6gqMEI1cL6IBHomgX3jtQDu8Tvh+BFVMEKS3ixs73rHJBC0hGqCqSzPYWpUpyH/NUjUqW6KdQrUlUw3L3mSm2G0x35iHJHmq6q87xMH70268btDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH6oTjTA/KJOW6ky/t4R1jGLguW2CcMOKxl4aBiHxqY=;
 b=RgxUKuV2wqrBHoRQCWx9RI2cj59vieG5cYho2/RTWiDVMTub4wJJdMg3dZqUT4nlFTdswNPmErD0GHf/xv2qfGUhwZr+F2vtNc4p7yi/I5Hs2llSFtetUOQN3Eovx1zAXXA0kKg8H2Nf7vc4fSlysjvN4NtX6NaB7N19YKv6ZmmS8zI6LTfU1JJWHWZyzPgkFyAtsvRE+c3Ytr59ZDfd0YalMNWMH/M/LlJpmlwqLuZKFUiafb6c69ULiRvE/cmYfhNE2kVXeeMHYU6PQXRpEysJC0ahOPk9QUUIMG+2Ke2Ad6YVeODqmtZQzRLNEJ9PJGtSDnykFuPTB1Eo1e6E7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH6oTjTA/KJOW6ky/t4R1jGLguW2CcMOKxl4aBiHxqY=;
 b=cWVEKQB+5tfhpVlZUhdiqz+5muMnbHJ60g1LtUuiDRxKipV0dfwEOAlgo5FH/nXcU69euM0Sf6IqgSQDNlWrUUNTFNyoldyaYFc2DGha4/XR+LvPvNsvweaiBJ8l0T32/HuSMmhZvjUtELwerEH16XI5miAoleSrImLEPL6LHAB30HnZeCnbpMGH0Aw9XmhECbG9Txcw2eFsAfdPdsRWrCPvb1le7BOEmsQxg/JsAPGe6JoTSM1FddGWJzH2BsBNmxFtJd7VhY9uPh1ebBVoPgokDFr63fWxqxh9WtRygWyXqImXlOGMWID4VT3R5UkdNTGKxwzSfovs1EeZStk7gw==
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 19:30:05 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::7c) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 19:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 19:30:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 12:29:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 12:29:49 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 22 May 2025 12:29:48 -0700
Date: Thu, 22 May 2025 12:29:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <aC97Kn+M5/9/naY0@Asurada-Nvidia>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <SJ0PR11MB67446AF2F48F35D64E98B3D69299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB67446AF2F48F35D64E98B3D69299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 05046b8c-0f7e-4775-152d-08dd99670d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qWjzLqtG4fJPB/GIXO17merzA5KZjLpmfaUBa0Q5Q1NX2/Cw2eevA1tAFriS?=
 =?us-ascii?Q?wv41G9nBlD50nrNKg6oUDzW8zwNCFhBwgYZbmv6rlrzgZYVZTep5jSO9yLSu?=
 =?us-ascii?Q?AKz1ZJEu8VHn/lKMVEDSP4q+CulcdPay40HpodKBWtO6yKL1oTyKZ6XPLW5k?=
 =?us-ascii?Q?J/w6ZaPsSQ1tVpRUwjFVfs0MRrxTLkdyXZ+OwPAbqvI+q/im4db1nEQXtHvy?=
 =?us-ascii?Q?E52sJBGb+GoTqk30Aydb24QbTehCGvkMlGhilV1zv9bdapdC+iWL+hksNJel?=
 =?us-ascii?Q?o2CegizQtCHSZrjV9+PNjSWBnJb620bfqgC1jQVtOVfrASJ/bayI/4NCuiHT?=
 =?us-ascii?Q?qN5uF47gTGvyicBeHq4KH7Q72HJBUQ0T2IT6Bxb88vhrRGz7xugLOySrvpJI?=
 =?us-ascii?Q?a9Lr1MnvH1AJrZcb9+iG1axHvgRc/QVb1f45OhTf2Blnc8LLJO+cL/hc5qjW?=
 =?us-ascii?Q?DldzX7Ari2KEzxHL1KGNp/aKsucYPIhpSxsMCveQKPIBkALUs5mBizwcHnob?=
 =?us-ascii?Q?oQ9w511vJRRjaDFp358dAVgz7js0dp0fgeWWyp6b89yEofQv5GHrNnDrKxk/?=
 =?us-ascii?Q?EKQiwP+KyFDkRqFUkW0YsCcMsEkI5BWplP84MFq9Z7tcMQL0P9ZgSAuu584J?=
 =?us-ascii?Q?Op86J19trwJaJWOw2g5HKtyWiQJmWsw6KpRyMDSB3xSgREwE7yIprIwlv6m/?=
 =?us-ascii?Q?ptrtQwNBz0hlL8fOBquRmo0Ya9fZO9zc/Ut6vFtdsdoIXT9T0pPDP/I1KhV+?=
 =?us-ascii?Q?Y0ohSDALonWghqIjNkfX1/HJq/QRpI1UhXCJBTKw69+rFvSq0Se5rq2tZzFK?=
 =?us-ascii?Q?ntmKa5rEad9hUaUAJcaq5FayQbJ72qiE2m3vpPGsZi1WeuFWDHjxuTh5gGb0?=
 =?us-ascii?Q?kB9tYutWktc76RaHhJsolQh+mB55iOA5gTFrrK4/EqUYmqp4p8LjTzgSA2Y2?=
 =?us-ascii?Q?CHarLzb1HpipiLBs3aXMt6EQ/mhL0zyYfkdRHwk5zXkGOOb7+v+YhNIg6S0a?=
 =?us-ascii?Q?VyYlyfIMEJHC0ed9Db5j56WxCv5nj9e+oxpfDZbhWZendYd1IA+oIpaeVtwJ?=
 =?us-ascii?Q?SyIjdt+1T3CsbyOKEncNruALpLxva1zMi0FL8LnLgvjhQhk7z2K7NzNqsb7r?=
 =?us-ascii?Q?B/kdBOz9lNIvDz4Fk3kWkS94L7bBP6lCZoIJLi0Xz7tg1EheveYmPWmjGPGp?=
 =?us-ascii?Q?wUuGlwVDDRKetjS0hneuIv3BCubkkWUXZobVSvyhjNFadEV5mkTbmhMU6dkM?=
 =?us-ascii?Q?c0UiVt1bglAVqDbpSO9txFaFZBp1Bw9f56HqIY182Mk4v4I6KQZLFTBvvC+W?=
 =?us-ascii?Q?ey/NtOp9CcDYL5xTiYwap2iWaNUS4V3+XHbjuZdYNBR5F8N7uAZ4fx3cxViV?=
 =?us-ascii?Q?vTlxFtkRta28HPqrMQGKSiJ/Zqd+BaDKJaFdnEoy47Np/ve6p6EYhE+pBMwc?=
 =?us-ascii?Q?Y6sKF4eI/ZcHIrcKoaCfJvke/lLSkJ5OmANpwE1QJukmcapqxKLN4IXaqW2W?=
 =?us-ascii?Q?P2opG2Ro6oYxqwsZKOLQsbYMNDCCVz6Czzl50ZTCtH4Qua/gv2jTiiBuqQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:30:03.9791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05046b8c-0f7e-4775-152d-08dd99670d5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
Received-SPF: permerror client-ip=2a01:111:f403:2416::609;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

On Thu, May 22, 2025 at 06:50:42AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Nicolin Chen <nicolinc@nvidia.com>
> >Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
> >host
> >
> >On Wed, May 21, 2025 at 07:14:45PM +0800, Zhenzhong Duan wrote:
> >> +static const MemoryListener iommufd_s2domain_memory_listener = {
> >> +    .name = "iommufd_s2domain",
> >> +    .priority = 1000,
> >> +    .region_add = iommufd_listener_region_add_s2domain,
> >> +    .region_del = iommufd_listener_region_del_s2domain,
> >> +};
> >
> >Would you mind elaborating When and how vtd does all S2 mappings?
> 
> When guest trigger pasid cache invalidation, vIOMMU will attach device
> to stage2 page table if guest's PGTT=PT or nested page table if PGTT=Stage1.
> All these page tables are dynamically created during attach. We don't use
> VFIO's shadow page table. The S2 mappings are also created during attach.

OK. That I can understand.

Next question: what does VTD actually map onto the S2 page table?
The entire guest RAM? Or just a part of that?

On ARM, the VFIO listener would capture the entire RAM, and map it
on S2 page table. I wonder if VTD would do the same.

> >On ARM, the default vfio_memory_listener could capture the entire
> >guest RAM and add to the address space. So what we do is basically
> >reusing the vfio_memory_listener:
> >https://lore.kernel.org/qemu-devel/20250311141045.66620-13-
> >shameerali.kolothum.thodi@huawei.com/
> >
> >The thing is that when a VFIO device is attached to the container
> >upon a nesting configuration, the ->get_address_space op should
> >return the system address space as S1 nested HWPT isn't allocated
> >yet. Then all the iommu as routines in vfio_listener_region_add()
> >would be skipped, ending up with mapping the guest RAM in S2 HWPT
> >correctly. Not until the S1 nested HWPT is allocated by the guest
> >OS (after guest boots), can the ->get_address_space op return the
> >iommu address space.
> 
> When S1 hwpt is allocated by guest, who will notify VFIO to call
> ->get_address_space op() again to get iommu address space?

Hmm, would you please elaborate why VFIO needs to call that again?

I can see VFIO create the MAP/UNMAP notifiers for an iommu address
space. However, the device operating in the nested translation mode
should go through IOMMU HW for these two:
 - S1 page table (MAP) will be created by the guest OS
 - S1 invalidation (UNMAP) will be issued by the guest OS, and then
   trapped by QEMU to forward to the HWPT uAPI to the host kernel.

As you mentioned, there is no need of a shadow page table in this
mode. What else does VT-d need from an iommu address space?

On ARM, the only reason that we shift address space, is for KVM to
inject MSI, as it only has the gIOVA and requires the iommu address
space to translate that to gPA. Refer to kvm_arch_fixup_msi_route()
in target/arm/kvm.c where it calls pci_device_iommu_address_space.

> >With this address space shift, S2 mappings can be simply captured
> >and done by vfio_memory_listener. Then, such an s2domain listener
> >would be largely redundant.
> 
> I didn't get how arm smmu supports switching address space, will VFIO call
> ->get_address_space() twice, once to get system address space and the other
> for iommu address space?

The set_iommu_device() attaches the device to an stage2 page table
by default, indicating that the device works in the S1 passthrough
mode (for VTD, that's PGTT=PT) at VM creation. And this is where
the system address space should be returned by get_address_space().

If the guest kernel sets an S1 Translate mode for the device (for
VTD, that's PGTT=Stage1), QEMU would trap that and allocate an S1
HWPT for device to attach. Starting from here, get_address_space()
can return the iommu address space -- on ARM, we only need it for
KVM to translate MSI.

If the guest kernel sets an S1 Bypass mode for the device (for VTD,
that's PGTT=PT), the device would continue stay in the system AS,
i.e. get_address_space() wouldn't need to switch.

> >> +static int vtd_create_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> >> +                              VTDS2Hwpt *s2_hwpt, VTDHwpt *hwpt,
> >> +                              VTDPASIDEntry *pe, Error **errp)
> >> +{
> >> +    struct iommu_hwpt_vtd_s1 vtd;
> >> +    uint32_t hwpt_id, s2_hwpt_id = s2_hwpt->hwpt_id;
> >> +
> >> +    vtd_init_s1_hwpt_data(&vtd, pe);
> >> +
> >> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> >> +                                    s2_hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> >> +                                    sizeof(vtd), &vtd, &hwpt_id, errp)) {
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    hwpt->hwpt_id = hwpt_id;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static void vtd_destroy_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> >VTDHwpt *hwpt)
> >> +{
> >> +    iommufd_backend_free_id(idev->iommufd, hwpt->hwpt_id);
> >> +}
> >
> >I think you did some substantial work to isolate the get_hw_info
> >part inside the iommufd backend code, which looks nice and clean
> >as the vIOMMU code simply does iodc->get_cap().
> >
> >However, that then makes these direct raw backend function calls
> >very awkward :-/
> >
> >In my view, the way to make sense is either:
> >* We don't do any isolation, but just call raw backend functions
> >  in vIOMMU code
> >* We do every isolation, and never call raw backend functions in
> >  vIOMMU code
> 
> Iommufd backend functions are general for all modules usage including
> vIOMMU. I think we are not blocking vIOMMU calling raw backend functions.

Well, I am not against doing that. Calling the raw iommufd APIs is
easier :)

> We just provide a general interface for querying capabilities, not all capabilities
> are from iommufd get_hw_info result, e.g., aw_bits.

Question is why we need a general interface for get_hw_info(), yet
not for other iommufd APIs.

IIRC, Cedirc's suggested a general interface for get_hw_info so the
vIOMMU code can be unaware of the underlying source (doesn't matter
if it's from iommufd or from vfio).

I see aw_bits from QEMU command line. Mind elaborating?

Thanks
Nicolin

