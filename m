Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9E8C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVA2-0006OI-VE; Thu, 13 Aug 2026 09:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9s-0006Ki-11; Thu, 13 Aug 2026 09:07:45 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuV9p-0005HS-0A; Thu, 13 Aug 2026 09:07:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aG11FkBFD3azR0cb2rlMErSR9ABoNKp3QIn0oFG8j4MSqTSyJUdmhl8WSVcAEXjME2Lw8dAnV8/0MJL2YCKpA2re4rsmxSNF1ecSr26RysMafz55K5HRDTNfPt8XgwP1GAXEgpHMgvYpDkiNMvBRLBd6qNeNn8ayMhCyi1i3YQmHVGYVac8HSYgCFsiOB7qzeUlaKWh/lkpKCw7ePa59plWAJ76+xW3m3iFzOHKrh+DpFGQ2wmEWoRCpMciAh/EDkBmHRwE1H5VFJfttHDFs5km302Nt9Z4sMPxG2a8zCAExBhDNeCBD/iQi9HSk/tQfPPw7Mv/D/JSchSEQJ3Khow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No3TEfslhxb/ptd5SDrD580aDCFbvvsVzptvRIcEYGg=;
 b=s7GZRm1n5blUxx7S519IG5WgkMo5gwU9TuLBlcg3eAfxLmCzRLqx1wTL3DsAEj8VP24LBdwlvak4+yj51jhyPNWRFpkbPZZk81iKMEqPKkleJs4ZJMWwjcA6+bpH3BDA2f5/S/AI+icKV3R1ecKAQAjPpiW9SvH+vREXHyzPuMKPJ/e/k2wv5LCTUdFaeFR964rZsgxZSmntdZ1yPiBPLve4mlkYdpqTAkJ7OeGUFPCpOhIOsv6zGyCHNvxeDOCmvotOpWE4Mt4qAjrwrKnDy3uSKbTuYLX3noGIZK0ZWFBdNf2XqQjzUb0Gafw8BcWz5Mci2lx6Jbgop0sH6cUDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No3TEfslhxb/ptd5SDrD580aDCFbvvsVzptvRIcEYGg=;
 b=GguvhXsyHfHBDyLVT12V5RSgWEThD1Vs7pmeM9ajWnmuadqOUb4asJT4gjoAnqur+svla3zYsDWA7DOiMzjWVDin2mAqS8CeJZL2tE0wbO6zDPm36FUOV0Ukzs74TE91ea8zGYYUP1Rj8B64hN+jB4U+SX8Uu5QzmY8Ik6lT2X0e8cnNm9JXM2L9j4137mmIijTmwfxnEszVK3DKrXAaTF9ap9Dqvvddy6RUNbcHOcQ5k50+cueWgKukkX6u1x0b3kyLbaEpIWs75zlCaE8nTrgo1shp27oNH+KMKGrJNqPRWIGrE1+qHs7752TJsC84GT4WeqjIZfhs8J4YderN1w==
Received: from IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 13:07:29 +0000
Received: from MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:07:27 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::5d) by MN2PR20CA0066.outlook.office365.com
 (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 13:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:07:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:07:02 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:06:56 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 03/10] hw/vfio/pci: Detect a CXL Type-2 device and read its
 geometry
Date: Thu, 13 Aug 2026 18:36:16 +0530
Message-ID: <20260813130623.2499506-4-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|IA0PR12MB8326:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: f868ba7f-6bb4-4f22-0db4-08def93bd2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|11063799006|56012099006|10067099003|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yC+svBWuowOCJeMiQc2Bxpp0aGVtkBVZjGV3KZBMeHLKWeAt8Q6jDntA0mMuIvcGSlD5E7OjDYNGeabBTwQV1fALgWd1U07EV8KEy11cfrEP19B6G2fvYO/0/Gn+h9q1tsdNIaURGfqpjNwNczi7YHVTXvfuMwYSxIS8/lijYFq/m8uRmWoBa5qycBShyjqgy/ntTbEoJr0HSH30FTOgzSmVdz3s8s3JC1c2qEbFxOxIH1K0KW1hj5qFmDf0i0fu/R6m+HqFVaLo/uMo7btPzZLVhKxY5aN99+TNStWVI46G3kR7Fm7Cwzu5sFST1FO1JBVq8nFmWaYqp4lhocTsvxFqdj66gVHoLtzMwH+usspiR/hRFBwYOttcr1IgXF4t/zssk6qGeWuN27OKO71x+PUELHWvMp+tQvsmJgkiQWlE4wqWRaz3nPX/1LZtdhRIC7zJNrH8FcUkioLei+RtENo4nBffsxjqy3xi3jf5M3KvWbSBDmkugxEa/UJC1zzbPnCULMyR6WFFko5VXotG2tfwqxs+mT/xc3Cs3S9xO8K7Cs4I3AHG59krjEHSMgDq6oEVtaBpUB8X21HT+SgVGNEpPvXO8CBTVHN3Pfsms/5BjIpBCRBP/5oQ9NpzBLX0Wv0CQeGnu2LDPnU4Rq8pzaE7sNLssRAu/YUvYjjoFnPgG9IgiU3kcymUPe4/i1tPayx9/Zd++sOJGyn8WJVDS/7PvMe9Nnp/46q7g65R9wyi/5ScKhU60u8sKN8Dw+mG
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(10067099003)(6133799003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /yimBYkeBsoRHRusXQlQL/Q5//+24yEZ2tGZw97mIb0BmAWNHl2ZYY9QyWdr46WhjXJHFlYB4uS9uIT+mpfznWbbh2An7+nyJdVB5R493Evr7VfVnE0caMk3jyP82GHVMtQZ9w+Kmnjuc63opxkYIagOOvichjb9DbhEAZGtr+/AAtQ4fkdEdXMzpB2ExW1mQXu91sA2KeaL45LXXIioQpbgQkOsBuF23icIlzE2g1WudufIfQqLj7S9PuDu0bQ3eZ/f31iXcA3vKs93q0gKA7uSM7+vUdDjitTD4DCNInZXo0Mi4Pu7FV/XKQ9PFYAJuH0g8H6bT8IMbjXrNJ/2iycRMpa2p4FacGyBcLJ00AbHo8lvzgpN1dClIQjHrEyC2O1/61ktZ+jteX4ZBfCt6MzCZf2YWNUot0o+wbXR/0olEEr239rCFZuSiuo+I4UJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:26.9592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f868ba7f-6bb4-4f22-0db4-08def93bd2fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=mhonap@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Manish Honap <mhonap@nvidia.com>

The kernel marks a passed-through CXL Type-2 device with a device flag and
exposes two regions: the HDM memory (host physical) and the trapped HDM
decoder register block. Read the flag, locate both regions by type, and
take the component BAR and block offset from the geometry capability.
Realize only records this; later patches build the guest mapping on top.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/pci.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h | 15 ++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f069..157786df72 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3570,6 +3570,60 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+/*
+ * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
+ * and the trapped HDM decoder block (which BAR carries it and at what offset).
+ * A non-CXL device leaves cxl.enabled false and takes no CXL paths.
+ */
+static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    VFIOCXL *cxl = &vdev->cxl;
+    struct vfio_region_info *mem_info = NULL, *comp_info = NULL;
+    struct vfio_region_info_cap_cxl_comp_regs *cap;
+    struct vfio_info_cap_header *hdr;
+
+    if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_CXL)) {
+        return true;
+    }
+
+    if (vfio_device_get_region_info_type(vbasedev, VFIO_REGION_TYPE_CXL,
+                                         VFIO_REGION_SUBTYPE_CXL_MEM,
+                                         &mem_info)) {
+        error_setg(errp, "vfio-cxl: %s: CXL memory region not found",
+                   vbasedev->name);
+        return false;
+    }
+
+    if (vfio_device_get_region_info_type(vbasedev, VFIO_REGION_TYPE_CXL,
+                                         VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+                                         &comp_info)) {
+        error_setg(errp,
+                   "vfio-cxl: %s: CXL component-register region not found",
+                   vbasedev->name);
+        return false;
+    }
+
+    hdr = vfio_get_region_info_cap(comp_info,
+                                   VFIO_REGION_INFO_CAP_CXL_COMP_REGS);
+    if (!hdr) {
+        error_setg(errp,
+                   "vfio-cxl: %s: component-register geometry not reported",
+                   vbasedev->name);
+        return false;
+    }
+    cap = container_of(hdr, struct vfio_region_info_cap_cxl_comp_regs, header);
+
+    cxl->mem_region_index = mem_info->index;
+    cxl->comp_regs_region_index = comp_info->index;
+    cxl->dpa_size = mem_info->size;
+    cxl->comp_bar = cap->bar;
+    cxl->hdm_offset = cap->offset;
+    cxl->enabled = true;
+
+    return true;
+}
+
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
@@ -3700,6 +3754,20 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (!vfio_cxl_setup(vdev, errp)) {
+        /*
+         * vfio_migration_realize() above installed a migration blocker in auto
+         * mode (generic vfio-pci exposes no migration ops). out_deregister does
+         * not remove it, so a rejected CXL setup would leave VM migration
+         * blocked until QEMU restarts. Drop it here, under the same
+         * failover-pair condition used to install it.
+         */
+        if (!pdev->failover_pair_id) {
+            vfio_migration_exit(vbasedev);
+        }
+        goto out_deregister;
+    }
+
     vfio_pci_register_err_notifier(vdev);
     vfio_pci_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c9ab949870..7fdd695704 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -122,10 +122,25 @@ typedef struct VFIOMSIXInfo {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_DEVICE)
 
+/*
+ * State for a CXL Type-2 device. The kernel owns the host physical placement
+ * of the device memory; QEMU only maps it at the guest physical address the
+ * guest commits into its endpoint HDM decoder.
+ */
+typedef struct VFIOCXL {
+    bool enabled;
+    uint32_t mem_region_index;       /* HPA-backed HDM memory VFIO region */
+    uint32_t comp_regs_region_index; /* trapped HDM decoder register block */
+    uint32_t comp_bar;               /* component BAR carrying that block */
+    uint64_t hdm_offset;             /* block offset within the component BAR */
+    uint64_t dpa_size;               /* size of the HDM memory region */
+} VFIOCXL;
+
 struct VFIOPCIDevice {
     PCIDevice parent_obj;
 
     VFIODevice vbasedev;
+    VFIOCXL cxl;
     VFIOINTx intx;
     unsigned int config_size;
     uint8_t *emulated_config_bits; /* QEMU emulated bits, little-endian */
-- 
2.25.1


