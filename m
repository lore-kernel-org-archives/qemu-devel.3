Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79041C87FD2
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 00:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujSRi-000183-1O; Tue, 05 Aug 2025 20:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ujSRO-0000Jz-Nu; Tue, 05 Aug 2025 20:55:40 -0400
Received: from mail-dm3nam02on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2405::623]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ujSRL-0003Ux-B3; Tue, 05 Aug 2025 20:55:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYyyhNu8lJc2tobEYn18+/wSfXpizGo7xRHtdyzPaEMbov4WoyKN2Kfb35Yua6UKAm55qTPkq+QS7zJBEvRH0KP+3oskPnj6xmsU0vll2zogumVJlYUxBNZgkZu344Pdapl7KoF7tJJylHhH5jggvhhkhOkfSyUt3JLIhB8ekrTSdUAEP+HJOIOxRWiWau12jZWmTTdqd2Znse07qU7O5jEGJp3w2lJ6HJeO1/N/MqozA0CcEqHAgTKf2r2xyy7I84esHb4YYeqtENpOzERFVuTck2HRTmKYTV7sWZiwQ/PwjWt3RYUrIAlm4hrsv2XEqZ0ALX15wmheHLeUF1dC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tJIYm48GMrcS8PvehnSyZT09/FaJuCIlqlrlSawUeY=;
 b=CuGBuK8a/q8TyKcAypoMdCKt9UctTTcv4XckP7sIWEzVP+fXm8fZQ0In1gRUDCR1jEVSUHW0cTKrjjDwnczZgrnR5LKTbi3yVCIvEWCGB9FlJjAA5RTyw8ZLllUso8sSMAod77lRt7g6p0C3ehr0hE25twX4qTi280//DSDicbtVi1c7ZoDrunH0fdbI9U+58L1VUm1lSzq3blVL3IdA9e6kZLFf2Ssq2Farz8apOEEmLPfC9X5xVWouNgVbT8VJcxGGR3MQ6miR4s9PJai+nixjcpFasZI9g8cy3o6FKyB7OPMIW60QKyNQDkRrDyZRycDbJ9AIZanUJpTxEGHE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tJIYm48GMrcS8PvehnSyZT09/FaJuCIlqlrlSawUeY=;
 b=sk6t/eJ6l+43OK0w3nlDoIEj2BBy7JvMcgNck1nCoGgSr3/O/UBlAPgTdRKLh4BKl19xk16qWHKc7Af46Daz7ObGMYSkA7e5cnjNMOyE/Y0urfWRdpMmnYiPzh87i5qQgpR+V/G+SxChgxkdZ/HtcmD7B/Tpfie9+SEc8sd9xk4gSoKrKF32tURA3gdUyocPorD+HSyi4/hjkkvLS/hzzz06Y/AORqqLw2HQodDerAmAnnile6HQDJcJaNX9iMMnLYLnKTY/4FT/njeORIenWDbvdzZTKXDzcgjYYa/kYoFy3sEDx0IuTdEA3AOvKHI64CDJkUpYiRUW+oQtGGPgiw==
Received: from BL1PR13CA0195.namprd13.prod.outlook.com (2603:10b6:208:2be::20)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 00:55:22 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::15) by BL1PR13CA0195.outlook.office365.com
 (2603:10b6:208:2be::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Wed,
 6 Aug 2025 00:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 00:55:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 5 Aug
 2025 17:55:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 5 Aug 2025 17:55:09 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 5 Aug 2025 17:55:08 -0700
Date: Tue, 5 Aug 2025 17:55:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aJKn650gOGQh2whD@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 030723e5-9d72-4308-b50e-08ddd483eb64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rcDgVFRdXssd41EyG+6+2qbng3FjXcGSfwxh9pupWzPZaEbhHSGSIner0oB9?=
 =?us-ascii?Q?M4voyTKeatt94RL3yI+85u3PhLFdZEuqN4UeFdNrLu145M2hRytGJlojGTCO?=
 =?us-ascii?Q?+xVv94QcMY3vIr0X4p2Gz1zdfvW60/3QLd+9W2Kgd2kpRVq431ICZqxRKa5X?=
 =?us-ascii?Q?iJZD6zDP+0dUvFH3Cx1nJkodHx8RPkInvnj4REF6Bd8NBembQN0IEuGx0wt4?=
 =?us-ascii?Q?b6XViMwYtP8lGeWw4H4/kYHtuurcBR34PENrOSHp5n8hV1QvpUuwiE/9WtKN?=
 =?us-ascii?Q?bkxWBcDyoAY2ql0xTjJxiIfWKoFh3O3PtEJPOOrPK9lX1Le2k153BR4SsCSr?=
 =?us-ascii?Q?2zNtaPT3TcPtVPHWetEEGJRkK1ITxkXP4XxUSCzY14DDff4e583a8Wh9yiKW?=
 =?us-ascii?Q?SnLrS5Pvy3Hshsdf4i/fae25EUv3Qc/cN+rY0s9WoVH7CSgUHNb3arxCSCQp?=
 =?us-ascii?Q?Oh/2hUTWb3RsY1Iy504mZ9pjVH8fdexKzMyrmLOr81eVsxLmXPT3ZSW7KyJQ?=
 =?us-ascii?Q?TL0QSqi3aCL0AEpzB0VA6ozKdnAMHgapdS8IxAXA+G/l47qdK3iRryxxCEOP?=
 =?us-ascii?Q?9TeirrtWlEjo8OzqmoGAWkjDHBpOY75nmrVo2X70g93iCj08ITZ+vvHj9psc?=
 =?us-ascii?Q?8IPxuy0QCoFEkDZuOegRh++8Nd5y3RDRpCh/zQeGpwWRAt92cTL9wu9l2W9w?=
 =?us-ascii?Q?V8KLqHusreRuQrlPW4AU8Be7Vh5XD/ZviXBe2Ho3YF4EuF4u70DPQEHbRSaH?=
 =?us-ascii?Q?HDPNbdPKiZtEYH3MHjPCuQL8qZpkT8SmLZupfRnnP5T/4PYQdUmadMo1/crk?=
 =?us-ascii?Q?O6ENjfhyOjIqhHd6meU1Cxw/zvHjqZ1PQSQOtcr4MNdj4k8e/xuBAEb/SQeZ?=
 =?us-ascii?Q?pTS/3JjPfwb5IL1Jap6CQxEOhQgVLynDU8wS+2xPA1YIC+aIePnVWbbVPljH?=
 =?us-ascii?Q?vnjxJBEco020/elcU8leb43gsQleLqzHq0BtKK2o7t116d9iNl+eCQedr4GE?=
 =?us-ascii?Q?7tR9RfjOG8lNohPApsFBZoh5p6LUcJzSHt1bghjYgQIfYYbWXBbS8WUODOxd?=
 =?us-ascii?Q?038nXGAvGpX5P4xjbLBGUMBusjKg9nS5UPCfq2sWkKYsErpf+ELSCzgkAkNa?=
 =?us-ascii?Q?JaEbOL1qFPo0vqmVKRQsqNq1f4W2Qd5nQs/82tRhJ/rnSEfB1rfjP2Juf7L5?=
 =?us-ascii?Q?2ACeGNZKSSnEIgAWsmHllA+W9UWfdQUZ7aGP3NMYyLi5gKPxouOF6y4oj1dd?=
 =?us-ascii?Q?gwOJuwKm9e/m17lTbmOTc4xZge3CB2g1Pm5eiDm8Di2PdlY1wUzylnwhmNRu?=
 =?us-ascii?Q?ro/ax2jcH4w+Tymai8OpE4t00EOC430JboVeJ1zhI3VqSg/mM2Ab3ph5Eth8?=
 =?us-ascii?Q?IfZbPDhjxMT5XyNtV15V3oUdhey16G6OAWovH//8EY6J2wcEIUkdm9DpLPeV?=
 =?us-ascii?Q?DlEqSPKbqbvxho6zPsYeGDugaoOpXMJa/06A5Hdtr1ZYDMuJw+FLOrBOJE+K?=
 =?us-ascii?Q?rfQBJ09WCun/vwZe9/HJ9z3sVcg+tdpTFeXj?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 00:55:20.9785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030723e5-9d72-4308-b50e-08ddd483eb64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
Received-SPF: permerror client-ip=2a01:111:f403:2405::623;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Hi Shameer,

On Mon, Jul 14, 2025 at 04:59:32PM +0100, Shameer Kolothum wrote:
> @@ -25,30 +31,72 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>  
>          sbus->pbdev[devfn] = sdev;
>          smmu_init_sdev(bs, sdev, bus, devfn);
> +        address_space_init(&accel_dev->as_sysmem, &s->s_accel->root,
> +                           "smmuv3-accel-sysmem");
>      }
>  
>      return accel_dev;
>  }
[..]
>  static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>                                                int devfn)
>  {
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>      SMMUState *bs = opaque;
> +    bool vfio_pci = false;
>      SMMUPciBus *sbus;
>      SMMUv3AccelDevice *accel_dev;
>      SMMUDevice *sdev;
>  
> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> +        error_report("Device(%s) not allowed. Only PCIe root complex devices "
> +                     "or PCI bridge devices or vfio-pci endpoint devices with "
> +                     "iommufd as backend is allowed with arm-smmuv3,accel=on",
> +                     pdev->name);
> +        exit(1);
> +    }
>      sbus = smmu_get_sbus(bs, bus);
>      accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>      sdev = &accel_dev->sdev;
>  
> -    return &sdev->as;
> +    if (vfio_pci) {
> +        return &accel_dev->as_sysmem;

I found a new problem here that we initialize new as_sysmem per
VFIO device. So, sdevs would return own individual AS pointers
here at this get_address_space function, although they point to
the same system address space.

Since address space pointers are returned differently for VFIO
devices, this fails to reuse ioas_id in iommufd_cdev_attach(),
and ends up with allocating a new ioas for each device.

I think we can try the following change to make sure all accel
linked VFIO devices would share the same ioas_id, though I am
not sure if SMMUBaseClass is the right place to go. Please take
a look.

Then, once kernel is patched to share S2 hwpt across vSMMUs,
iommufd_cdev_attach() will go further to reuse the S2 HWPT in
the same container.

Thanks
Nicolin

---
 hw/arm/smmuv3-accel.c        | 14 ++++++++++----
 hw/arm/smmuv3-accel.h        |  2 +-
 include/hw/arm/smmu-common.h |  2 ++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c6dc50cf45..405b72095f 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -370,13 +370,19 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     if (sdev) {
         accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
     } else {
+        SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(s);
+
         accel_dev = g_new0(SMMUv3AccelDevice, 1);
         sdev = &accel_dev->sdev;
 
         sbus->pbdev[devfn] = sdev;
         smmu_init_sdev(bs, sdev, bus, devfn);
-        address_space_init(&accel_dev->as_sysmem, &s->s_accel->root,
-                           "smmuv3-accel-sysmem");
+        if (!sbc->as_sysmem) {
+            sbc->as_sysmem = g_new0(AddressSpace, 1);
+            address_space_init(sbc->as_sysmem, &s->s_accel->root,
+                               "smmuv3-accel-sysmem");
+        }
+        accel_dev->as_sysmem = sbc->as_sysmem;
     }
 
     return accel_dev;
@@ -558,7 +564,7 @@ static AddressSpace *smmuv3_accel_find_msi_as(PCIBus *bus, void *opaque,
     if (accel_dev->s1_hwpt) {
         return &sdev->as;
     } else {
-        return &accel_dev->as_sysmem;
+        return accel_dev->as_sysmem;
     }
 }
 
@@ -599,7 +605,7 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     sdev = &accel_dev->sdev;
 
     if (vfio_pci) {
-        return &accel_dev->as_sysmem;
+        return accel_dev->as_sysmem;
     } else {
         return &sdev->as;
     }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index e1e99598b4..9faa0818d7 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -37,7 +37,7 @@ typedef struct SMMUS1Hwpt {
 
 typedef struct SMMUv3AccelDevice {
     SMMUDevice  sdev;
-    AddressSpace as_sysmem;
+    AddressSpace *as_sysmem;
     HostIOMMUDeviceIOMMUFD *idev;
     SMMUS1Hwpt  *s1_hwpt;
     SMMUViommu *viommu;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index c459d24427..9bb9554435 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -168,6 +168,8 @@ struct SMMUState {
 struct SMMUBaseClass {
     /* <private> */
     SysBusDeviceClass parent_class;
+    /* FIXME is there any better shared place for different vSMMU instances? */
+    AddressSpace *as_sysmem;
 
     /*< public >*/
 
-- 

