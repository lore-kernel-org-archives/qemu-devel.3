Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1300D3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPU-0007Sf-S2; Wed, 10 Dec 2025 08:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPS-0007Ry-Uw; Wed, 10 Dec 2025 08:39:14 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKPQ-0001NY-Vp; Wed, 10 Dec 2025 08:39:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSV0v19x8zw5oTxTcXsx/lWXh/Mdb/qbyD5pMoAtKHrrUKKIkfV0vQVwP0F6lbaC0Ztj3Dl1JDL4mP2prrWp3S7WDnY1dCm5A4EuQxk2uxvWa6dD6+IwAu99FFPxwA1NL2NYeN1Aebhr3W73na/HH5BsaUPtadn86wsSYKchZSugNwLlYzPPvy7MOyWY+ybV9d1QAok/ChhX8hKpFXFKzH+q/MWO9m70mOS6TzSJme5QWal4DQ4XjkkkPbKs6/fIpntPWjJzOlJbwhUsdB0PMxTknw9wPnxD9rTwOIE3LT/zmJ0bBKClokRZtOUJRJq6b4rsPIlAKc0eiHQhrkfn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHAk0NQhLCmkGfyoaeK7SjDhL4xAdfRtiRabscri2Wk=;
 b=Ax6ojah3JrmVmJ1NtdV9lkU1+Yfhn2AsNPDK7CZhzIqW+MaMhHKGJkCL/I78RjigyJnocO1bPDxye9JH4IMqxhHeUGv2adHA1KJEy7wg2zxeLNj0qBgwInYm4TbYZAK8WQgxUk/cdhu38TH5n1piQe7YwoIiPPVJOsC5QVIoE8EFw7I9Dbu9Hy3dEes+TOrLTXpvdW2eD/6M3A8bUiKMTzohUy3RdvmBwuf/MdMAJG26JX14UnjePHAC/7df7cUlRpOJKu8syngotahzOWceIGlzTOquFiPmuBJHdghmmSwWG3Th1vZxfRNE9ocWsLWL9VuUtomHSuwpXLy9lrY+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHAk0NQhLCmkGfyoaeK7SjDhL4xAdfRtiRabscri2Wk=;
 b=Mg+BRmc4Eq6C5k6ZiIg+lN5dMvpOIIY749wx772af5t+a0g/+hRCjFSqJRMMB8tYcuMrOyPMtMNJghT5AqwoAO2raoLf5arz19NkX7Ox9DHzJN7nA6Wp9DG5zyPbBR80BGRX0pdqxjPdFvo4V3mXGNBqNA7zmKKtIMRDe9Jv4u2ZWo1RxchmaDSai1F3XH7sx9d9BXHNH0Zv+XrwGhUPpxH+LqM1TysgCA2DJlDF1Q6p1eCByIAkJaMcwOmphEtCP3HwPtAskeUHzJ5uGJ6dErCQzzEo81JMpcrVewV6cqpPH4qG17yk0mKNzrXkcjGQR8wZe8kT8hscPpSiFKPYbA==
Received: from BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28) by
 IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 13:39:06 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::4c) by BYAPR01CA0051.outlook.office365.com
 (2603:10b6:a03:94::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:39:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:49 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:47 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 09/16] hw/arm/tegra241-cmdqv:: Add write emulation for
 registers
Date: Wed, 10 Dec 2025 13:37:30 +0000
Message-ID: <20251210133737.78257-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: c901ccce-9809-48fd-4fe4-08de37f17d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2n4UUhTGUxFasIDlp8p5kPsm/S+VRLJSY4nxnT5Mjmi1PavXhSbV3s1ALMka?=
 =?us-ascii?Q?tGFnHD5jmUV1eN2Tqx7BsRYIPwkBsS9VDi77aXE7EJHKAyooK8bOodj4iQap?=
 =?us-ascii?Q?9gWL0EKXompsHzfSLepQTpKQLKeYQQHsXohb3APhCTMxnDN6HqmxRRETrO9N?=
 =?us-ascii?Q?bXCzf5+D9bYpeo9AfSMXgBUUFmUsblMDCRMd9YjrHSVO5AI0abF73Jpsvi8/?=
 =?us-ascii?Q?iV7EyNw/YiYMs0hTSmzsfGjb/ozGAVqmocF5Hcy/0ct7+v3niLOYa9xe2UIe?=
 =?us-ascii?Q?cqhUNfPtSE9bwDObHytFNdV1mLfu/YSlpm7aM9/SmzFSm8TOR1PfZIscf1Be?=
 =?us-ascii?Q?mTLrD59kckaAp//QiGXG47lU80kLN6X4rG7FtL5Y/kDLPpIonzYXebEsWyNf?=
 =?us-ascii?Q?xDRa0bYbu0i8WiXP8eDOuZARXya8p2E1BjWCixIbJzGtkgENbtkSWch/2A3u?=
 =?us-ascii?Q?ZS+MprsS/OctZRIVRRTEIUS0ROC72lE5pL7qygPcIeVY/wxmKa/LQ2qkMHNm?=
 =?us-ascii?Q?99EE0RyhJtham2z3ZxZOr1zubUyKss9+K+cuEs10hEinL29/A71uNQXDGcVA?=
 =?us-ascii?Q?EJqkTFu7tMzobzxQJi5vxnEguXogaY/95I5P+cb1OWRBlij/vU0jnJCJeD0O?=
 =?us-ascii?Q?Exige7TNzQvDDs30ZIRp5QYwrKPx1w43BOux2BolXI9r6KPQ9YoZdnxUmzf+?=
 =?us-ascii?Q?MXO2B02zG8+P3XbcbMU72hPSMacNyRwp0BDs51yosCqzx+r8Mk4eMt28gmoc?=
 =?us-ascii?Q?7/ZpzuGBehlKR6C3kzubizfNDwGdiH3H19ZUhyERPklZr/fuzA19AUHnBHXO?=
 =?us-ascii?Q?gbjLQx5BdWc1tliXsGoj9n/TndIZUDx1V3rtpCy4XPYLLozlaQK6lxZ6MxLm?=
 =?us-ascii?Q?17FwiBvHDbPo1dUDoYr/2PXES8FHVoP5rclM8MquSw6YvG0p2Hhgst/tJzuA?=
 =?us-ascii?Q?F6nVmUiGTR/ZTZvK6CPoMIP9K4eq9mjCauX7C2yNRYgrdXVKZCV9UZoaZ5LL?=
 =?us-ascii?Q?nkqQh4TEsWKwBDFDNJaDf6nfP1mqsXjBqk9jBHOgDmvuboPDSTNVhHhId+Bv?=
 =?us-ascii?Q?ko5hLWM+l732C0ge+gB8s55DKpNTke3pU8azFfC+x9RFthWfvwDZm+9pXfP/?=
 =?us-ascii?Q?DV+dXY3IXelfUTbiujWcCdl5oGYpWRrRbqYVkbh56CsxhWc9sx2ba74NdqF/?=
 =?us-ascii?Q?dHejxTzk4tJ3YXX+N2zznoxNvRbMKeeaB77MHVt2bjXmV6xpdK4PzE8S1e6j?=
 =?us-ascii?Q?3Qyn9W3XOrS51SJfSKhSiSS6hXux4x/j8d5dUMrqnjgiQPssclqe/YW9RKVM?=
 =?us-ascii?Q?UHsKBKem5hHH8V3Fot9mVuLQosT81L0nQsbXGk/0ElNGhsNnK5CA4DrK11YZ?=
 =?us-ascii?Q?GC5ST2g87M1O4AxMMqQFVsNEHDQjYa1+HC/Qzke4oiob6R+o1fXRfLxQkIDD?=
 =?us-ascii?Q?yKt7doTQwDlNc+5Z3x4KrfM3yPh4e88N3lqAfM0MrMLCj4aFHBldE+CKYeIL?=
 =?us-ascii?Q?qPOLMXtV355/GjJ+fA39dZeBkyqoL77ruxzf5ypH1TS2R0sPUKWciXrm9bs5?=
 =?us-ascii?Q?tJNP5gfLxFYJHY5O2Z4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:39:06.0347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c901ccce-9809-48fd-4fe4-08de37f17d3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
Received-SPF: softfail client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Introduces write handling for VINTF and VCMDQ MMIO regions, including
status/config updates, queue index tracking, and BASE_L/BASE_H
processing. Writes to VCMDQ BASE_L/BASE_H trigger allocation or
teardown of an IOMMUFD HW queue.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 213 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 185ef957bc..5e9a980d27 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -210,11 +210,158 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
     }
 }
 
+/* Note that offset aligns down to 0x1000 */
+static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
+                                       uint64_t value, unsigned size)
+{
+    switch (offset) {
+    case A_VINTF0_CONFIG:
+        /* Strip off HYP_OWN setting from guest kernel */
+        value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
+
+        cmdqv->vintf_config = value;
+        if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
+            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+        } else {
+            cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return;
+    }
+}
+
+static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
+                                       Error **errp)
+{
+    SMMUv3State *smmu = cmdqv->smmu;
+    SMMUv3AccelState *s_accel = smmu->s_accel;
+    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
+                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
+    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
+    uint64_t log2 = cmdqv->vcmdq_base[index] & R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
+    uint64_t size = 1ULL << (log2 + 4);
+    IOMMUFDHWqueue *vcmdq = cmdqv->vcmdq[index];
+    IOMMUFDViommu *viommu;
+    IOMMUFDHWqueue *hw_queue;
+    uint32_t hw_queue_id;
+
+    /* Ignore any invalid address. This may come as part of reset etc */
+    if (!cpu_physical_memory_is_ram(addr)) {
+        return true;
+    }
+
+    if (vcmdq) {
+        iommufd_backend_free_id(s_accel->viommu.iommufd, vcmdq->hw_queue_id);
+        cmdqv->vcmdq[index] = NULL;
+        g_free(vcmdq);
+    }
+
+    viommu = &s_accel->viommu;
+    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu->viommu_id,
+                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
+                                        index, addr, size, &hw_queue_id,
+                                        errp)) {
+        return false;
+    }
+    hw_queue = g_new(IOMMUFDHWqueue, 1);
+    hw_queue->hw_queue_id = hw_queue_id;
+    hw_queue->viommu = viommu;
+
+    cmdqv->vcmdq[index] = hw_queue;
+    return true;
+}
+
+/* Note that offset aligns down to 0x10000 */
+static void
+tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset, int index,
+                           uint64_t value, unsigned size, Error **errp)
+{
+    uint32_t *ptr = NULL;
+    uint64_t off;
+
+    if (cmdqv->vcmdq_page0) {
+        off = (0x80 * index) + (offset - 0x10000);
+        ptr = (uint32_t *)(cmdqv->vcmdq_page0 + off);
+    }
+
+    switch (offset) {
+    case A_VCMDQ0_CONS_INDX:
+        if (ptr) {
+            *ptr = value;
+        }
+        cmdqv->vcmdq_cons_indx[index] = value;
+        return;
+    case A_VCMDQ0_PROD_INDX:
+        if (ptr) {
+            *ptr = value;
+        }
+        cmdqv->vcmdq_prod_indx[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_CONFIG:
+        if (ptr) {
+            *ptr = (uint32_t)value;
+        } else {
+            if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
+                cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+            } else {
+                cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+            }
+        }
+        cmdqv->vcmdq_config[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_GERRORN:
+        if (ptr) {
+            *ptr = (uint32_t)value;
+        }
+        cmdqv->vcmdq_gerrorn[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_BASE_L:
+        if (size == 8) {
+            cmdqv->vcmdq_base[index] = value;
+        } else if (size == 4) {
+            cmdqv->vcmdq_base[index] =
+                (cmdqv->vcmdq_base[index] & 0xffffffff00000000ULL) |
+                (value & 0xffffffffULL);
+        }
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
+        return;
+    case A_VCMDQ0_BASE_H:
+        cmdqv->vcmdq_base[index] =
+            (cmdqv->vcmdq_base[index] & 0xffffffffULL) |
+            ((uint64_t)value << 32);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
+        return;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        if (size == 8) {
+            cmdqv->vcmdq_cons_indx_base[index] = value;
+        } else if (size == 4) {
+            cmdqv->vcmdq_cons_indx_base[index] =
+                (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffff00000000ULL) |
+                (value & 0xffffffffULL);
+        }
+        return;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        cmdqv->vcmdq_cons_indx_base[index] =
+            (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffffULL) |
+            ((uint64_t)value << 32);
+        return;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return;
+    }
+}
+
 static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
                                  unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
     Error *local_err = NULL;
+    int index;
 
     if (!cmdqv->vcmdq_page0) {
         tegra241_cmdqv_init_vcmdq_page0(cmdqv, &local_err);
@@ -223,6 +370,72 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
             local_err = NULL;
         }
     }
+
+    if (offset > TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
+                      offset);
+        return;
+    }
+
+    switch (offset) {
+    case A_CONFIG:
+        cmdqv->config = value;
+        if (value & R_CONFIG_CMDQV_EN_MASK) {
+            cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
+        } else {
+            cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
+        }
+        break;
+    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
+        cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4] = value;
+        break;
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_127:
+        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
+        break;
+    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        tegra241_cmdqv_write_vintf(cmdqv, offset, value, size);
+        break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ127_GERRORN:
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN:
+        /*
+         * Align offset down to 0x10000 while extracting the index:
+         *   VCMDQ0_CONS_INDX  (0x10000) => 0x10000, 0
+         *   VCMDQ1_CONS_INDX  (0x10080) => 0x10000, 1
+         *   VCMDQ2_CONS_INDX  (0x10100) => 0x10000, 2
+         *   ...
+         *   VCMDQ127_CONS_INDX (0x13f80) => 0x10000, 127
+         */
+        index = (offset - 0x10000) / 0x80;
+        tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
+                                   size, &local_err);
+        break;
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ127_CONS_INDX_BASE_DRAM_H:
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ127_CONS_INDX_BASE_DRAM_H:
+        /*
+         * Align offset down to 0x20000 while extracting the index:
+         *   VCMDQ0_BASE_L  (0x20000) => 0x20000, 0
+         *   VCMDQ1_BASE_L  (0x20080) => 0x20000, 1
+         *   VCMDQ2_BASE_L  (0x20100) => 0x20000, 2
+         *   ...
+         *   VCMDQ127_BASE_L (0x23f80) => 0x20000, 127
+         */
+        index = (offset - 0x20000) / 0x80;
+        tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
+                                   size, &local_err);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+    }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
-- 
2.43.0


