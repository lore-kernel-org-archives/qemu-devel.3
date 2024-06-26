Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB05C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGbd-0003ik-8B; Tue, 25 Jun 2024 20:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGbR-0003ZU-Nc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:33:39 -0400
Received: from mail-mw2nam10on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2412::631]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGaD-00059n-IG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:33:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDU4wccu7At/2lnzehvUoVYpReiKnL02oaPQWXs/n4PohA7BLeGf04g4U9AePm95le0Lp+0JRAa4XtDBdOqt+pfjzHvuEmzL4EqeNurTO5dEsmA+whC4VfkyrSdnLFeJOQ/8ChSIN/nlyqN98ZYOGJndQ170M1CTTTGLpT5HFi0AKXUk4RzDd2Z2T436htmOz9DtoopPs5yAEaDYFM/KFU6VystRxiL1g/ro1mjp4K70N1faO9zBNVYLwZGQ49otPRMC7uHz3ZW81UYrHz8bSlAWsabxcHb334fgNFmz2Db6fK8rZayV5oTRKp5YAlIy8jF3HRGIc0Z0NJ2c46FMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQBTV5apUoNhqJeQQWMFVr+h9r6HSkwkDNEkif0DRXY=;
 b=cpEslryKheOKIGgZZefgLgoL0rfK5KUtn4+ynFMXfTGcE5sNni2DA67GoIdZOJBCBW47vYpHOv3fUErzwOLSiYhVHDKAZ//edjKC1lb+3dwPspqfv1DTow45/he/1fpYKUJ3bfTQX5F10CLca3dD+X6VPTTI9yHUwsLTdySr8Thc/jT4bILioe+Tr3SyqmMwspzoTiSThoquGvDwSUkCS12sdfk+q7ZjAshMLVp2tNBAVOc6dCmALeTcOeiaBUgfNlWrWAsIM7+fyH0v7Siczu2mDeSXUN/uC3+FHemHjksQT8PgJFybGhKQMFhg7N4EOkYJdfibieACw60Qkljfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQBTV5apUoNhqJeQQWMFVr+h9r6HSkwkDNEkif0DRXY=;
 b=coQt8T86xJULk3p5KKiPONL+l14W/vuZODnI8tcz0N4nAe5T0AyYLlvKuVUaevT0xwi9vAwkk4Ygv/3FDQji6UnL0GDCatNcIt3U4x58zWkcjfvlgNczD/kAd+bIYs+xXEqtCiLQiikQppuXqRQ8wj6OGm3ELuF05RdwQKNopYvXZIiWWAgM1ijbmEfjnnhH5Q6prBsaAX0S8Nvifa9Ogb+RGDEFGCa0lJr2CPcUigPZhQuzA9yI/x0Rsyl8a+X3Kn+58pvt2yLLyrZy+3J0qjferZHuXPOcMF9uDv2I8nSVYs3RoDdY97Ovx+g6kpDKMLElDl2OTisrS8HeOL9utw==
Received: from CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 00:29:35 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::f2) by CH2PR20CA0012.outlook.office365.com
 (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 02/10] hw/arm/virt: Add iommufd link to virt-machine
Date: Tue, 25 Jun 2024 17:28:29 -0700
Message-ID: <df22fcd43e201fea97da8862b61614a2986ffa5e.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ef3f70-9a0b-4f64-499c-08dc95770e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BsAadwv4wnk9OBj4NwcyATi69CGgqHuAB9GSorgTpuPwfgxdV5pifkpLzxR0?=
 =?us-ascii?Q?XzluHinqdAS5/g0gqe4+f3H2A2IuvknIO/lgRSU7tlTaFnkPo6AStXPwYy5j?=
 =?us-ascii?Q?lKJSAFpmTxfM/Hz2M8Kb6qeBqUkuAdoEdYDtfaWOVVAz3zp2PQNt5qAAxNpX?=
 =?us-ascii?Q?bBuCa6HyOBy1vTMuxpFPPmY5naVBTy2qkXIfTVW+9kyE6PmbylylkIoIsY/r?=
 =?us-ascii?Q?IaAtanhhT8jabJkXDXpDyaJQ5ku0QGj0YdHGXTUxOAfMxnr2YycWTKEdwsK4?=
 =?us-ascii?Q?14xXuTb2lT67P6tvBEvSTidWrhIKGB2mYF6XuLQrgnbOtHwJf89YNrvdxbiu?=
 =?us-ascii?Q?h+zTRJAVtMeMv51vG0A0HYUPpCFAIc+Mato90LGsc/M2nANlHn4qr8V5TNG8?=
 =?us-ascii?Q?eDfaDXysXsU+8blYi3iuT37MAUKRX9MnIO776HMGQvLdwj4qbEjakZUNvTGj?=
 =?us-ascii?Q?5Pxeu5AQmVV58PsiU8YpRv5MdBGmnk6/sXNJXgHd5VLcp5n31BAMX96KE0IE?=
 =?us-ascii?Q?KSOSFfQGv617DuUymSIZalxmNl3y9srjGENrvyovPGUsu5TQHg34utsRjT96?=
 =?us-ascii?Q?NBX8XP68nevy2+hMABFBOCY2/nSQYERVu5LJKylY/FQagM1kuCwuuUgN3t2K?=
 =?us-ascii?Q?9L8DbABonR2znPI1jTyrjUtoawnSBK4MNq/ZzSCrgAXqAdXxtqFTjcE3rqAP?=
 =?us-ascii?Q?SO3xeq2aGQHASenqEBmoTp7VpqK4TJ++5iRuVMKHpBfsogj3xHvix9hGiB3N?=
 =?us-ascii?Q?nBSC2Mrs+LTygVJx4o2uuctf4erlaesDWOH35TXz+eTMu0qinPwijIuCfUH7?=
 =?us-ascii?Q?KxfJw+scI7H+vRpraZPaEoDdJGchkAf9t9uvIrK0u7V5sQMG2eh0ctY7d87u?=
 =?us-ascii?Q?jsZ4lrjFQm8YIYjk3XRXK+Zle/rwfPxDFNYk7+bEPwcSY+XHvmA0jeIIFIPG?=
 =?us-ascii?Q?oiABh6YRHtk2pPuHXnRaU7cAipKuz02yvlNTtF1dLklQLfsMCXHovckhbBNu?=
 =?us-ascii?Q?Zf3cmn3dLTBg89wvB8LXaHO55prF8OOP+e6Mi1HBCDAf8ERarvS/kwdOwv87?=
 =?us-ascii?Q?P+LAyv6ESRl/uRyjqKcz9qZjKMb8FSPh+o8hqOG5Swg5Hy3R9l5npTef/qEb?=
 =?us-ascii?Q?oYN7NHvkoScvoCcoK6i5XiZS818/a6EfJx3RlNv7mS23kfrbF8bn2es1xqb/?=
 =?us-ascii?Q?3Sk0NP1RjyGWZa4MgqLGzSA6WsRGCibyoZkgl0zp6TP2CEiyb9OgMXYTAjZd?=
 =?us-ascii?Q?o0ceAqxLZa5vnehT4a06ZaTZmVfoQ+VoedxjiOwp0v6P9bPE/l7K/3iHO0bA?=
 =?us-ascii?Q?vKkKHyUy+0Kup0ADtANHLTtbnVnWrHucAMzk+3MkUwI4aK0mr8DLR9WKTiwj?=
 =?us-ascii?Q?rD/BDmvSw7LdZV5hfZc53w+bQPhSuHPc4zx1KOD9EtDURoZf/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:34.8234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ef3f70-9a0b-4f64-499c-08dc95770e19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
Received-SPF: softfail client-ip=2a01:111:f403:2412::631;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

A nested SMMU must use iommufd ioctls to communicate with the host-level
SMMU instance for 2-stage translation support. Add an iommufd link to the
ARM virt-machine, allowing QEMU command to pass in an iommufd object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt.c         | 14 ++++++++++++++
 include/hw/arm/virt.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 78af2d2195..71093d7c60 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1404,6 +1404,13 @@ static void create_smmu(const VirtMachineState *vms,
 
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+
+    if (vms->iommu == VIRT_IOMMU_NESTED_SMMUV3) {
+        g_assert(vms->iommufd);
+        object_property_set_link(OBJECT(dev), "iommufd", OBJECT(vms->iommufd),
+                                 &error_abort);
+        object_property_set_bool(OBJECT(dev), "nested", true, &error_abort);
+    }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -3114,6 +3121,13 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set GIC version. "
                                           "Valid values are 2, 3, 4, host and max");
 
+    object_class_property_add_link(oc, "iommufd", TYPE_IOMMUFD_BACKEND,
+                                   offsetof(VirtMachineState, iommufd),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_set_description(oc, "iommufd",
+                                          "Set the IOMMUFD handler from \"-iommufd\"");
+
     object_class_property_add_str(oc, "iommu", virt_get_iommu, virt_set_iommu);
     object_class_property_set_description(oc, "iommu",
                                           "Set the IOMMU type. "
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 7df0813e28..d5cbce1a30 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -36,6 +36,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
+#include "sysemu/iommufd.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
@@ -154,6 +155,7 @@ struct VirtMachineState {
     bool dtb_randomness;
     OnOffAuto acpi;
     VirtGICType gic_version;
+    IOMMUFDBackend *iommufd;
     VirtIOMMUType iommu;
     bool default_bus_bypass_iommu;
     VirtMSIControllerType msi_controller;
-- 
2.43.0


