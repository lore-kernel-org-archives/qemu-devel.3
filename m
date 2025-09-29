Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8190ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8n-0003ux-58; Mon, 29 Sep 2025 09:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7y-00032i-Lh; Mon, 29 Sep 2025 09:41:22 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7d-0003nM-IG; Mon, 29 Sep 2025 09:41:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t94EunajE6p7Oa53CaCiGXjytCuxTbh3Aeci6zfJN1noqJU1CsyI/0nDTjkzVplysJQFo0pA/yc/bskFE5G70dsLkZPryeAQxp4EBAEDkqDiEUUaMR+xijZQx7wSn7JeHnQUmfTj4jbj+WymN8n6oeN3amRv+8xG4faogNpBW0xpjYat4aXHveuQHWDm1Vare4kWss8SBzvy8A9sDUSP7nUuqANDUJn7ICihwHxMuXioRGruUhld3qUTsd6nPowSdUoOwcrbAp0ZQQPCrzVSPDL1Lzvl083clw1vOYYGe++VCoxVDvtETmN9kv5af1bbIfHk2Arw5Rkt3dWFnGA5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ/NUsksj/0g3F5yTbRxyOhMRp1NIJ6w//jrqEUqKp8=;
 b=EijmeRTIFshBF3tZFt8Zv4E7lshI4AKcht33yUDpYCvL03zk5aqzi/hfQzPGaLxNXugVeAcpFB/3Jk3CjivNd5sbQp/3UQ37FNjoteCDL8TGjlumIMEAMDhZ7pk9UBXTN9eRhYU4nMc432rJNecFkyfu4uNC/x1SOv4WJdl4qQSssQ6zzlW/YJYeG3ej+/ohCHJUxXPQk4FPjSxYCg4TvlkUw8+/YQGCOhCvGhUU3Xe/HIx+WK9n0fySxzWBRbOE7TBcgn4zXSxQ3n5Cyfe28L4jNdHhUIVjZ+XUM3GiuBNiCxGvjAea6oyH24giwqwKxfospVKsz2rYxu+L3G36AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ/NUsksj/0g3F5yTbRxyOhMRp1NIJ6w//jrqEUqKp8=;
 b=CXbSjbo5UJGG7+4lSxcp9UmtC/s9wYNJ1IZDLbuGZ6tF4dJbVMueFYm8YWMvpiWvq7dDhTKaq3mlcEP5uc81wHL7vrsfJLfnSFDtSV+8NPfliEAVmrsPzhkakldJXJ0H/Ode+0v2i+qkfOlrL3NZHQ3/OJz/TYrtzOdYO289euJshLVFyBlDp/ab5sSw+Bx6hScznp3Nrmgx6r2tf7IE/hCIyoj3DuYghNtDtlI70V4tUHQZbKohJjzF+3Fpl7gA/UG+ZibQG9Zy7/X2vv1SphZE9ArsIga7crECOkdjc+AEhQvljckHTyJIIp1taNE0Qttk/1gU+Sksqwd7eawNpA==
Received: from CH0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:610:33::10)
 by IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:39 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::4d) by CH0PR08CA0005.outlook.office365.com
 (2603:10b6:610:33::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:40:19 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:16 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 18/27] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Date: Mon, 29 Sep 2025 14:36:34 +0100
Message-ID: <20250929133643.38961-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac6ccdd-801b-4e2e-1945-08ddff5dc6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7QMCYnXz+JqioYAn2TEzKIbJY76RXC5ewGqZooYjKcmwHFKZLyKFiMk/DUaB?=
 =?us-ascii?Q?OwtrztmsNnqBaFew5k4FpjpvoiYdk4GFzP+29UZd+yUF575ooeHaiEld3eYi?=
 =?us-ascii?Q?yC/PgWaAGOyMqzhG+H1hFS+4gVIzIy654uM7kNQ6ZSyTN38dccJU6aNOL+eY?=
 =?us-ascii?Q?k520x9uF3LgpqGDmK0bnT36+EnByepXRG0u1mqyO9nC/6I2GjduqT+sZ/22q?=
 =?us-ascii?Q?L6J1XwUGQlilbv42OMksdJB0nMPqc71qWCnlxAyrYRf2S4wB5MM9DXD2i0oK?=
 =?us-ascii?Q?Ui8xwTBXXw0N7TVqBkZ5aZufz7uA68g9GyA4gv51nZ5+c62LO1XQE0ITb94Z?=
 =?us-ascii?Q?PvERpjYkKA14dZYt3Hp78XL/aCRsYSUdwdrktn4EFmI5rsD4nOY+QsZBqNcM?=
 =?us-ascii?Q?NTZdIBRhjxPQxpWbANNBEO0MGn032Kb0J4vbbPHOfzSR34Mi0I6RYIeXY4yQ?=
 =?us-ascii?Q?FOZQ+j5OLi55haW4u9nKfu7GHxra5bOD0SWoPmSUROtgab1GOcnK73lYGjqU?=
 =?us-ascii?Q?uwpM1HNuwZ427SHAroCtGUYKg5KYf9MhNBle2uen1B51+TSzaGgnUbohVTiw?=
 =?us-ascii?Q?DngaLpDk4wrFxTTOlaV2UnPS+qWA4OaXZWrwZUyOnkxfu83iy92nIfs/zd8Q?=
 =?us-ascii?Q?2IqnTXdT6oRYbrYM3FgftL8lP0I9f5mdL4Q/HaDMA4p6pChfQFymJvJoL/jy?=
 =?us-ascii?Q?HkWuZxdahX6zy2nn/hdqd9KO+cbQ2c2VcXteGdGt1ziwUXTtaonMcrpJ79x7?=
 =?us-ascii?Q?IFGGDBX5nwJs1YkW+FPEELq8F8NRvi0U810FYZLYjAGqndJnw1cUHF9OaY77?=
 =?us-ascii?Q?1NdtlBCT3QBoInj7XphGcj671f4MbAuGWG+OOUwvhKt4RFFisjeJuvSG83vf?=
 =?us-ascii?Q?vE/moBQ84ZEwM0QjIXni4JYF6hG5I+wx00BIpMbhYYp1/QDc7D5DC8bdA+4v?=
 =?us-ascii?Q?e5pnkFeJjZ5jE8BiWyfve9vEFDMjd72q4TDrfw0oJSg2WJwj6/TTnw+fUrOn?=
 =?us-ascii?Q?YSADseODUPsLsfti7JvbV9W+24mO9AbyQt/2ZYCmppFAsEbHLweU9mvxwe/I?=
 =?us-ascii?Q?+01wBRBG9elQ72p/sqz1yD3paf3iGMqjDqS/Y7LKYvjmJw1HwacNv4ZSUGnb?=
 =?us-ascii?Q?3Jonlgi40Awjh8AXEcklvOYY0uKaGpYIOj3WriFxW7z3kVY5+SuhZ+J+g+Bb?=
 =?us-ascii?Q?8lLabZv7cOvdejwq9/6FoGcSekxntVcg+P2M6z15FDq3L3ygcH7pSOfqFhDX?=
 =?us-ascii?Q?w9cdraWJOm7UdNObKlkAz/8FxDzhyCXiu0bRjY2NYxI5DOJ+81IobxQQSgub?=
 =?us-ascii?Q?YYvNwp2wclxx8/rcrxhiHrdha7G8iAFkc+0NpxCZ8vTFuVqhXp0stpczAThq?=
 =?us-ascii?Q?kh9X3isenG5hTojfvs0hEhm3hAjr8ODwUaFYsk3I5S3RE+4oGb03W55I5I0J?=
 =?us-ascii?Q?11Tt64W1k5axFU+WYmjYRXKxw7+lQsIy4NwpNR1pq6K0uH7rtyCWUGoWSnpP?=
 =?us-ascii?Q?NWx+0yU3/Cs+eW0mtfi/2PRFASVofBa5nVnZixI8KlyE07WlYGjTNRJcw+CL?=
 =?us-ascii?Q?Vn4ZrPeSlsuys75+Lpk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:38.6742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac6ccdd-801b-4e2e-1945-08ddff5dc6c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

To handle SMMUv3 nested stage support it is practical to expose the guest
with reserved memory regions (RMRs) covering the IOVAs used by the host
kernel to map physical MSI doorbells.

Those IOVAs belong to [0x8000000, 0x8100000] matching MSI_IOVA_BASE and
MSI_IOVA_LENGTH definitions in kernel arm-smmu-v3 driver. This is the
window used to allocate IOVAs matching physical MSI doorbells.

With those RMRs, the guest is forced to use a flat mapping for this range.
Hence the assigned device is programmed with one IOVA from this range.
Stage 1, owned by the guest has a flat mapping for this IOVA. Stage2,
owned by the VMM then enforces a mapping from this IOVA to the physical
MSI doorbell.

The creation of those RMR nodes is only relevant if nested stage SMMU is
in use, along with VFIO. As VFIO devices can be hotplugged, all RMRs need
to be created in advance.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 75 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index fd03b7f6a9..d0c1e10019 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -264,7 +264,8 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
  * Note that @id_count gets internally subtracted by one, following the spec.
  */
 static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
-                                  uint32_t id_count, uint32_t out_ref)
+                                  uint32_t id_count, uint32_t out_ref,
+                                  uint32_t flags)
 {
     build_append_int_noprefix(table_data, input_base, 4); /* Input base */
     /* Number of IDs - The number of IDs in the range minus one */
@@ -272,7 +273,7 @@ static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
     build_append_int_noprefix(table_data, input_base, 4); /* Output base */
     build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
     /* Flags */
-    build_append_int_noprefix(table_data, 0 /* Single mapping (disabled) */, 4);
+    build_append_int_noprefix(table_data, flags, 4);
 }
 
 struct AcpiIortIdMapping {
@@ -320,6 +321,7 @@ typedef struct AcpiIortSMMUv3Dev {
     GArray *rc_smmu_idmaps;
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
+    bool accel;
 } AcpiIortSMMUv3Dev;
 
 /*
@@ -374,6 +376,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
     }
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
+    sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -447,6 +450,56 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
     }
 }
 
+static void
+build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
+{
+    AcpiIortSMMUv3Dev *sdev;
+    AcpiIortIdMapping *idmap;
+    int i;
+
+    for (i = 0; i < smmuv3_devices->len; i++) {
+        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
+        idmap = &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMapping, 0);
+        int bdf = idmap->input_base;
+
+        if (!sdev->accel) {
+            continue;
+        }
+
+        /* Table 18 Reserved Memory Range Node */
+        build_append_int_noprefix(table_data, 6 /* RMR */, 1); /* Type */
+        /* Length */
+        build_append_int_noprefix(table_data, 28 + ID_MAPPING_ENTRY_SIZE + 20,
+                                  2);
+        build_append_int_noprefix(table_data, 3, 1); /* Revision */
+        build_append_int_noprefix(table_data, *id, 4); /* Identifier */
+        /* Number of ID mappings */
+        build_append_int_noprefix(table_data, 1, 4);
+        /* Reference to ID Array */
+        build_append_int_noprefix(table_data, 28, 4);
+
+        /* RMR specific data */
+
+        /* Flags */
+        build_append_int_noprefix(table_data, 0 /* Disallow remapping */, 4);
+        /* Number of Memory Range Descriptors */
+        build_append_int_noprefix(table_data, 1 , 4);
+        /* Reference to Memory Range Descriptors */
+        build_append_int_noprefix(table_data, 28 + ID_MAPPING_ENTRY_SIZE, 4);
+        build_iort_id_mapping(table_data, bdf, idmap->id_count, sdev->offset,
+                              1);
+
+        /* Table 19 Memory Range Descriptor */
+
+        /* Physical Range offset */
+        build_append_int_noprefix(table_data, 0x8000000, 8);
+        /* Physical Range length */
+        build_append_int_noprefix(table_data, 0x100000, 8);
+        build_append_int_noprefix(table_data, 0, 4); /* Reserved */
+        *id += 1;
+    }
+}
+
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -464,7 +517,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
     GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
-    AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
+    AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
@@ -490,6 +543,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             nb_nodes++; /* ITS */
             rc_mapping_count += rc_its_idmaps->len;
         }
+        /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
+        for (i = 0; i < num_smmus; i++) {
+            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            if (sdev->accel) {
+                nb_nodes++;
+            }
+        }
     } else {
         if (vms->its) {
             nb_nodes = 2; /* RC and ITS */
@@ -562,7 +622,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Array of ID mappings */
         if (smmu_mapping_count) {
             /* Output IORT node is the ITS Group node (the first node). */
-            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
         }
     }
 
@@ -614,7 +674,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                        AcpiIortIdMapping, j);
                 /* Output IORT node is the SMMUv3 node. */
                 build_iort_id_mapping(table_data, range->input_base,
-                                      range->id_count, sdev->offset);
+                                      range->id_count, sdev->offset, 0);
             }
         }
 
@@ -627,7 +687,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                 range = &g_array_index(rc_its_idmaps, AcpiIortIdMapping, i);
                 /* Output IORT node is the ITS Group node (the first node). */
                 build_iort_id_mapping(table_data, range->input_base,
-                                      range->id_count, IORT_NODE_OFFSET);
+                                      range->id_count, IORT_NODE_OFFSET, 0);
             }
         }
     } else {
@@ -636,9 +696,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
          * SMMU: RC -> ITS.
          * Output IORT node is the ITS Group node (the first node).
          */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
     }
 
+    build_iort_rmr_nodes(table_data, smmuv3_devs, &id);
     acpi_table_end(linker, &table);
     g_array_free(rc_its_idmaps, true);
     for (i = 0; i < num_smmus; i++) {
-- 
2.43.0


