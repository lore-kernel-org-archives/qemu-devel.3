Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B020CFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHS5U-00038G-2j; Mon, 27 Apr 2026 15:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wHQTP-00032y-KM; Mon, 27 Apr 2026 14:14:24 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wHQTO-00009V-0A; Mon, 27 Apr 2026 14:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kajWbX2JbIC2MWGTOhCqRgw2mrbTLIB6B2iLHVk+UaLF/Es2OdKJZ77cW3UX6t9eH+O3NaZdH27mUb++T4hSRSKsjk/WT3Q1WtbMxY1KrvbP/FMY2Ak2UQMdrSq1lb1bKJi/qka7FyqEDEzVO1QhKXiNzFHq5cr4U/fME30DQdaVWnqCQzzkqM4L5IpvmmRTizvko132HECKadsDiObemZTKwK8T+VsLgkVGhkkLmIbadBhBN6rcokAeSZiFWKnoU4nJIVMYYDPzZtcCi4Fn6eFymkFhYQVG9toUNcChFM+04066CRAjAP0pV6/12p10OjhLlMoqgHKGOSCiSXWp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amUqyT2zAZ5FovMijWrpd02U0cnVkmWTYD7v8WEbXGU=;
 b=bdqEFhiAKwUkPOOltWvzHyA5t7Y9i+AaS55o21uJo94SutKUm2eOwQy0EW9/WGTECWiAnzHGTqYTJlzxmTWhfONe+xnjJ8GyRevq/iord3ejZVxPPz8eRzuGgBWyUaTjLNBSf8N1a/Mhf5BXXViMf6z4Upk3ZYtUhCnp+/7M05MWpYo0o4w7G4Vt+/OdQVmG4wx5h4iiWYFkYs9nLbLPMtah9xJVu0QTl8oPoS0iJIaVobY58J6E7N+H55FrN1PSS6h5p6u0nL68MMQmY3Rplq1zUwVyaEWtFdtg5lxa6QCCF7Kdg8ZgjsgvyW4hnBtpf1bgjjPCZeMgJ69nL3B8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amUqyT2zAZ5FovMijWrpd02U0cnVkmWTYD7v8WEbXGU=;
 b=dBOoLSkxGPTYGmiMqr5LQ3ZSrEsEdagWGyS5DNtcis+KCMtxvXw1ucPXR2al1l0bMkZsaJq94pfWnDAqzp73StvFczv+rcxuj/fxF6BkfNA+yK7YxS4R1mxqbkx3OBIBJvkZDCCcpOyGbCKM7e0eGDVt7SY0wncAnT/Z9Xd9lHAfCHPgPUgkhkKocUuJGh0oAVMVNN/yR5sQ5jIC/kR33nv4nYvJUoW47Cc/o/T4S3hHH035cSCrOjYNl+WW/9Mbs8NvBslmET4Ab4Jk1yyBRCCaBnawzAQPy1joXXOQh5UB9yHeTanIlOf5fcL7649roqTxiyTMy5JNHoyOGdXeWw==
Received: from CH0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:76::19)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:14:12 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:610:76:cafe::18) by CH0PR04CA0014.outlook.office365.com
 (2603:10b6:610:76::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:14:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:13:51 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:13:43 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>, <ankita@nvidia.com>, 
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <marcel.apfelbaum@gmail.com>, <clg@redhat.com>, <cohuck@redhat.com>,
 <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
 <alejandro.lucero-palau@amd.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 "Manish Honap" <mhonap@nvidia.com>
Subject: [RFC 4/9] hw/vfio/region: Add vfio_region_setup_with_ops() for custom
 region ops
Date: Mon, 27 Apr 2026 23:42:30 +0530
Message-ID: <20260427181235.3003865-5-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260427181235.3003865-1-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0d3ccc-18c9-4912-2190-08dea488c86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cAJQrGJzX6lTWkW3ZPpfnSFb2dZ2dc20cfZ6hxH4uqZ5+OyGsvaGfuOWomARGaQYBA6A2AXOqey1c/RCULqGaHEY60iTjLy2UZUYlfLnF+JpiH2IAL6o7Gr69rtc97uUuv45J9K3CjHL35ezY9fJ7RA+orOPTGmqtZmZjYMM34hOvB/aqnpOk4UZuMYs8PNjHCY4C8HyJhK9A82czBCURhVKPABqFMNIGEgnILVEABQUa5wYP2UXdQ4Xky/vdimdo3fYbXeWOqKT+CCbxJbdKvUKmTYarCMXYWTG1MSngtMW5L6fqEkenh3MUiTO0FrMdLAjfITz1hFRg95WFhHgAO2vJrMr0N+x0e/ACLNWMCCpuz/yBZeCi4GffN9nzfGRpnFXplZ1GGWcUP0jX7+4SkA+UHGZJuHTtNYo1mtw7k96gMacItJod9sOOyCB1xuJEtA1CNrtRLRBhs0jAZEPFltlMFh5tCpjAVm/hkq893HomGFFcGBIOEKvMyhkmFZujKuk5PBhtYku/uzIL/R6qK//33zG5mojSO48ydo/n7iLglJVzQngGXbCp5T4Qxnd5LCMCq0dwqUrZkz4OCjlCejnvsgJjSWz0+8wT2JoHBqmHL5MIgEXbRx6cFqFwgGA9nDDApinBK9Z1+lT/i/+wz2KnNfZ/wFBNXEAoM19mfWcvQGph1Mb7wg5jZ7SdCpJ1n87I6+mdqwMhywfMoDLY4dqARMoygroQRap3ClpXTS4TspMJMX8AKe8Zc6NBhDCskFmyoJ+OwZj6CfZwchywrd7rwxruuglgg/a8t4vXpgTHWUVtNUf3lsYsB+77IFl
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iSwmj/H/lf5qUhWdc/DeQWo4d94UAcxpWN0GiSM4UXyuD3VS1pzB5IJxyQKhuov/tBA/VZwRBV9Iem0hnTjDzJ8O2gdverYhLr+V8twV7+W0lGSZ3OvprvKa3xuyPN4IeMgDW95pDL5aXZj+3BAxzg4yT3enGv7DGRprZu4C8rFGDg6Ju/ETFRyEVWC+1psuIDXRlJFlQHj6rUsCZvsULsXFqVIYSazvRMpokPtwSj+caxNnVAlLjfjLcP0Zr5x6qmdt+kMAO3347anCqsz8cabUXWZSOKTWTwmR3up2rNkFRvZ8hwQC5KvZvBt78sZTBuuIEgd6uF7Ta/mnFCi7hbXOugUumrcfMjV0bP8JQamd5+w2vcM8IBnECzhIKAB4w425hliAEwq7+rHCWoOrrPUZ2r0MZWAQFVmrHXq0cMTV/HtKysk2gBDH3jgvtEkg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:14:11.7191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0d3ccc-18c9-4912-2190-08dea488c86e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=mhonap@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Apr 2026 15:57:41 -0400
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

vfio_region_setup() always initializes the region MemoryRegion with
vfio_region_ops. CXL needs custom pread/pwrite ops for the Component
Register shadow region.

Add vfio_region_setup_with_ops() which accepts a const MemoryRegionOps *
parameter. When non-NULL it is passed to memory_region_init_io(); when
NULL the existing vfio_region_ops is used. vfio_region_setup() is
retained unchanged as a thin wrapper for all existing callers.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/region.c      | 15 ++++++++++++---
 hw/vfio/vfio-region.h |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 0342ca712a..9bbe758d6f 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -228,8 +228,9 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
     return 0;
 }
 
-int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name, Error **errp)
+int vfio_region_setup_with_ops(Object *obj, VFIODevice *vbasedev,
+                               VFIORegion *region, int index, const char *name,
+                               Error **errp, const MemoryRegionOps *ops)
 {
     struct vfio_region_info *info = NULL;
     int ret;
@@ -249,7 +250,8 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
-        memory_region_init_io(region->mem, obj, &vfio_region_ops,
+        memory_region_init_io(region->mem, obj,
+                              ops ? ops : &vfio_region_ops,
                               region, name, region->size);
 
         if (!vbasedev->no_mmap &&
@@ -273,6 +275,13 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     return 0;
 }
 
+int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
+                      int index, const char *name, Error **errp)
+{
+    return vfio_region_setup_with_ops(obj, vbasedev, region, index,
+                                      name, errp, NULL);
+}
+
 static void vfio_subregion_unmap(VFIORegion *region, int index)
 {
     trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 9b21d4ee5b..84abbec1ec 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -39,6 +39,9 @@ uint64_t vfio_region_read(void *opaque,
                           hwaddr addr, unsigned size);
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name, Error **errp);
+int vfio_region_setup_with_ops(Object *obj, VFIODevice *vbasedev,
+                               VFIORegion *region, int index, const char *name,
+                               Error **errp, const MemoryRegionOps *ops);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_unmap(VFIORegion *region);
-- 
2.25.1


