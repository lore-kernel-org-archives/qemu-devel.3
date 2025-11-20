Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8B7CF8856
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4dN-0005cM-C5; Thu, 20 Nov 2025 08:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dI-0005ap-2L; Thu, 20 Nov 2025 08:23:32 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dG-0001yi-J4; Thu, 20 Nov 2025 08:23:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvMwMSHV5BD64mhtOJFwDXLidw3uk94SaxYCvVGNB+uI2zwgbVNAaeiO+OO3/+Hi+pX+gfBITgdr+4Pf+S4+paJtq/bD/eZ3XPJpBSI4eS9Ay26GG7qh+C196p5jLig8Q8OmbEx0Z6KHWcK/LSX07rq9td5w8bLEFB7jFoFvbBDpRzGOCqhyG5JEuLErp8UCEFVyp1j+IkJrf2upyj5l++v1YfcSlQizb2YQNZdCSxrMc6rULP7NA8XpFS6VsOHOVm3S5Sg88fIm/uAu1MFWYgGnaiM69QbLTJWX32AH2OAbFz7ScT0VrD/eosM+QKK1bIb+SQ3eUtteVsspeWRoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClVGz80L8jUr8B2zYHZ1WY8NHWbShRbNSEA7lCu0ZzU=;
 b=l6x2MgrEEGajVnr7kD4dspnMuxZHgIueicSK4/K3bHD8vSGSdH2Psxv2Bl79UZlmiWKJTjDH7ZeqU6AUZfHGBHZgXcl6M6u5XkQuXcjCqTZToh1VUvUTVWJqHHEfPDYtGqwJJ6Pm5U4Z33+Jp7jW2X+K/3nJHD3f4nGvi4lkZ09v0Gv4mHBrEkSwi02PBdmUBtPL6JohLsvSgj/vOEJIlNiG67pRViklbLrrrPZvYNpVMt0vp3UUGdJ6cn0jFbc6lg10vYQ/AyIQJr5/RrK8SlEXqd9QqBJqUt8p+mcpe9cOCqKuYoaLaz9EgXu/1qR0LxSl5VR82Ugh/vdhywhiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClVGz80L8jUr8B2zYHZ1WY8NHWbShRbNSEA7lCu0ZzU=;
 b=IWFWeQ1yfwju6NNNs5XRh87FnDjSGJF/UspCj5wfUf+vzNTcvy2Zf5j7lx1pp08zu7ihvLVsX7q+hgC6a13iZdEPnw72a+WSyRHgfIJSvhpfw0iGzw8ocNLKNVybewXPlH+szJ6fdRpBIbKHnmjC7txhMfV++E/ig8OOEWBe1yimZclOstmioBe0BE+r8gbwSSFaxPlAcUvgpP13+pyKiv4w+uj/toJKRL+9FxjrC2WZVJYvmhQ3kDYF0Fw09bpCJOKN75eIzLnE0PgiB4LUScZSMaI9+Y8HxTuupFBcSIRS8sRvfFHrCrl7V23cRTzvIIDKRJPHmUj+WPIzgEySyw==
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:23:22 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::85) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:06 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:03 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 03/33] hw/arm/smmu-common: Factor out common helper
 functions and export
Date: Thu, 20 Nov 2025 13:21:43 +0000
Message-ID: <20251120132213.56581-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH3PR12MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: 225d085e-e4e2-40c0-81e9-08de2837fa74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lyxHuHo/BjWWD8p9IWUS4RxRFNUIVkPwI+9pcMQhIeLC93KTRlAXiTbZogWz?=
 =?us-ascii?Q?BXM9BtywoCgmZl9e2ziC758FC0AB+yDKPcvmpEhlSEZxwAmnjf/g9qsRPha4?=
 =?us-ascii?Q?2GKOKYAs0jixf0PoSypwBUK0Z5IQZo+KLInV5N8p5RBUApGKDN0X5wLzYBj1?=
 =?us-ascii?Q?1BLcodhm8r7Xagc3xmcStTPCwjvk1DXdYKgI7Rgv/0MrPt8U0FUYXcr+CjEE?=
 =?us-ascii?Q?IbNinP8dKeGV0uZT/XEcwSNEyzDG+iWCVLmS73HLQY1PuVZmu1bemFReqFR3?=
 =?us-ascii?Q?iV4r0ev/5XLzdXc+bpb9/6HlLAClQcaAHR2DMW8TzJUNi8Cc/cgh3Iak00t4?=
 =?us-ascii?Q?qvsgfZGyg6raY7THVFnehzz/XWWduF36IB2kGGc/Jdm6KH1YOS/p72uifZqn?=
 =?us-ascii?Q?tohmMxkoRhQgvTEVgBeZjzjbTu3wC/6tIUKmSEipFOqTPMNT6GIPhszltVoX?=
 =?us-ascii?Q?60cGz/16AceePZ1E2nOd/Y0Kvf66KunJHvz+t/EsFSqv+t7bFn3L97E+U6cl?=
 =?us-ascii?Q?pQhnOm3XhO4obqb5xXTYaW+Zp1jfEgVTg6w+OgFaUmmMTTfyq9C/+YVZlZfG?=
 =?us-ascii?Q?agHMMIyUYay1BgsBuCobFuMEtwPTAR27mlAOX2HKU+PNw18K9ZbajErVyj77?=
 =?us-ascii?Q?6M0A4ioulUJ5qHucw6TJyS6zosz0xg6b6u3PhbVln9OiDyIAWXihzyPScx8o?=
 =?us-ascii?Q?o37ENrqZ7UV9xBs2VpH2MCAao1M1A0Aqmotjp/dNDO7GsilR76HolBwvz91H?=
 =?us-ascii?Q?0D4Y5lMuxRq5sFJYX2uQqCwvIlR3rUOj6ABOCBC9DQBILRopCDV7A/uS4Ydz?=
 =?us-ascii?Q?Pkj9X0qa58qClpFygcu3YSvH8kAYfVILXM/+hN9Fzje/D+puHkl3uDgO1gN8?=
 =?us-ascii?Q?0n1/CIabB6FOeb5Si46peLks3sTe3T+E1zlOQcThEIcrw9OmOsSnl8rm0vAr?=
 =?us-ascii?Q?knny5EobJFvb0bmrrXG5I3urJBE2CE7VixToyP094O4dDjnLTzqsNpt5sD5/?=
 =?us-ascii?Q?gs/puzxSYVJbKgR0XukoOPOY13hpIYUSzqkGFvmooxPyZUIV6IClOyVhAFzN?=
 =?us-ascii?Q?58O9GNC5a5m8VtdQDVkcYDpOjCXh9p09zfH3Y9a2QvYqLvanIKOozzCvaBwG?=
 =?us-ascii?Q?1cm0f/evTo7voyj5Zb6hSjoOpCaNzuPgB+rrKyoGo+8i+xkLF6/H161pgrpD?=
 =?us-ascii?Q?fKrWTU3hfTmGIWByFs8xZov+7MHa3iCPKkQGSIL1zzQCsjT/LUA9fmU6b7U+?=
 =?us-ascii?Q?vDOcQJ0uqJWN+6qZFmBVPv7DUBnk/NOdtGV9BJuuVtXJv7gZY9GPzn3XAdwV?=
 =?us-ascii?Q?z5kFk2EU0K/3qK1fvxOn2VwhA+COR2F2MzUh6H4ri1UFoogoKIstQVHUJOpH?=
 =?us-ascii?Q?F+oVU/ti4Oznik5x+li2lYBP9J9BUbnMWAiCrNpBYaNyHD21uNgOsFPLfLxX?=
 =?us-ascii?Q?DoQvCbevA+X5ofWzzpKZkXTraXChAu+FJtg5XUQlsKdBsKcz1rsSnIPile2Z?=
 =?us-ascii?Q?zzFA7ZeYtzzrdsYXx7wAh6bif+tUuNfRHZNSn+hOtLh4Uo9JyyMQSk2QtScz?=
 =?us-ascii?Q?ZzoECk51PpI33Nom8RM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:22.2222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225d085e-e4e2-40c0-81e9-08de2837fa74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Factor out common helper functions and export. Subsequent patches for
smmuv3 accel support will make use of this.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 44 +++++++++++++++++++++---------------
 include/hw/arm/smmu-common.h |  6 +++++
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 62a7612184..59d6147ec9 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -847,12 +847,24 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
-static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn)
 {
-    SMMUState *s = opaque;
-    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
-    SMMUDevice *sdev;
     static unsigned int index;
+    g_autofree char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn,
+                                            index++);
+    sdev->smmu = s;
+    sdev->bus = bus;
+    sdev->devfn = devfn;
+
+    memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
+                             s->mrtypename, OBJECT(s), name, UINT64_MAX);
+    address_space_init(&sdev->as, MEMORY_REGION(&sdev->iommu), name);
+    trace_smmu_add_mr(name);
+}
+
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus)
+{
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
 
     if (!sbus) {
         sbus = g_malloc0(sizeof(SMMUPciBus) +
@@ -861,23 +873,19 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
         g_hash_table_insert(s->smmu_pcibus_by_busptr, bus, sbus);
     }
 
+    return sbus;
+}
+
+static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *s = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
+    SMMUDevice *sdev;
+
     sdev = sbus->pbdev[devfn];
     if (!sdev) {
-        char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
-
         sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
-
-        sdev->smmu = s;
-        sdev->bus = bus;
-        sdev->devfn = devfn;
-
-        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
-                                 s->mrtypename,
-                                 OBJECT(s), name, UINT64_MAX);
-        address_space_init(&sdev->as,
-                           MEMORY_REGION(&sdev->iommu), name);
-        trace_smmu_add_mr(name);
-        g_free(name);
+        smmu_init_sdev(s, sdev, bus, devfn);
     }
 
     return &sdev->as;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 80d0fecfde..d307ddd952 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -180,6 +180,12 @@ OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
 /* Return the SMMUPciBus handle associated to a PCI bus number */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 
+/* Return the SMMUPciBus handle associated to a PCI bus */
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
+
+/* Initialize SMMUDevice handle associated to a SMMUPciBus */
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
+
 /* Return the stream ID of an SMMU device */
 static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
-- 
2.43.0


