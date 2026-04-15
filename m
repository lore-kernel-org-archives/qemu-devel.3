Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22B8F41986
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxx5-0002P9-2J; Wed, 15 Apr 2026 06:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx1-00020r-NX; Wed, 15 Apr 2026 06:58:31 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx0-0004DG-2c; Wed, 15 Apr 2026 06:58:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/w6q9FrHP0KRZt3N68blq3zpVe7Fj/wBWBYZS3CHSTYt246Vwn6+Oltax5ZQE8Yjp+uUpoZQSyTvjHClA3JazaoOg/HaxIMOHLdfq0PK7KbytpmawPDLzGy05Yr3yWnEGb9mD5gyZWiyNXlrnoXTNZe0rdxFT0bcvCimIZrIeUwG65slFM555sdsZqS62s9zHbd0j6EL6P+Lgg8bc6kvvM80P2Nvnp/tId/snWykhDKsxU5lVj1+rnuLlQV6YlmWvZpFzxAilXPzmf/qoHq7uVi7LdEW4ZyttPMirJ8eaYzZzWX7nVX4NySz10teAO4txX/8lvTXmk5FODyJIWMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D0gmybRhKwkYkThmC7epLDVI2fKVwUod9I1Ce8l+/E=;
 b=iaQo1aaCmIaveKftZj7SKPjAEv9WyF7arNHoGuwueg5mYUL8MM88d5sdWSbObx8Rr8gR0j2RfL/aU6ZnS3St8R28VUGlgFe7+kBNUKw1LaGESWUB9UGNcyTS/lzANOx0T8GHpqOzOTuvzhq7o5WRIwsE18Nsha7UxEGQeWKwpT8rS5P1mX+C8TiTpdHkPRn20m9TWt3hre6F0xMQ6xNmTKffXoqt3iW/9or6qs8CLjEfvn2JEetrDXEQr1oMTcJfS0u3wjiPgNMFG0il/CgctsLmPmfwEogG9fpPv4BbPz5XKRWHFkcD9WIuSsXRcx76a0wcf8HClzw4SGvNKXhUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D0gmybRhKwkYkThmC7epLDVI2fKVwUod9I1Ce8l+/E=;
 b=QUrJfJZ7JUJlrlDOSmYnssuLxZ9Ef8sX85bLWlwQ+0thX3ZQKtM+PhDiHcculVQSRiPAc29ra40gTs5Zvmnf2DQFJub3usyLPTnuu75t8xQj8ZQzj3lGqSS7MR24jGlwMoLHDj5W7P3R2EcNrnHxAEy1qgWKNsqxpfC0gxlUOEknACXmXbOvv2ZQ2QIlW1v6XfQqCtvm6tHZ5w6DhAzC3OoNOrhX35AgUA+s13jTXrtRwXZZeDFsfI9dF6crcLqXFRax6ldTxQOe9rOJouppXif29Uu5UDiKTzPX8YKMqIIl13S1rCvBr6CqpidKlR894Pt+uWOrdyKRZVC4Ju8J1Q==
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:22 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::cd) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:04 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:01 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 24/31] hw/arm/tegra241-cmdqv: Read and propagate Tegra241
 CMDQV errors
Date: Wed, 15 Apr 2026 11:55:45 +0100
Message-ID: <20260415105552.622421-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 903e115c-6f98-4715-5004-08de9adde8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: djcp7w5G8trms5001kiFeZe13MT60afsk8cRP1zJSwek8DlQSBudpDfLWDWFFywKAneGeVfAeZnpCYEy8V9srGGse5DDdGAQAITNDjam1XpEUbM3Z+0OO1Pf298qejGqXh1mPUTSRQp2dG8Q7PMcKFVvVHuslgkCJVf0p5/leUTaMnU3sX7W2HBYT54N1toJyQPnN0dArZxh8bqHTubt/MEiXWDrETgYGwP4ckEjAIAX5AMiTZ05HEgZbmhcYRLQsLG0+9CBfCmn2GwGu/527mp0qK5l3potb+6oRFWZhxJbE8AT+ekloxxKYi0GJE0olvfHSfhGIxBVvPpsMGZ3EKJl1Ujlf+fsE8szR0trJFkSKN85givXCbJusFp0VaBOIJkcVJVcc7dH+4pYXuZsLDTht68K+ou32ZLz/EuJ0uiBgFZOhTmNjxoZaz9fxhHC/mW4iKT4n31jUEkIEY84UOF70D67CUZb8yG6ErAwgwcKAB8cB9mcT9L1O0O5/CoLqh/gM1nEyrbje8AuCKPkduvARW8G3XijXCJelxbBhHsrNCDMsF3Kfy3v2axWiuWB3QRInpz53PNv2MsvKe6UK3MOGyBQKVA5vK/OUp9lh3nEq1ttepfHkmR+BX4lzfC3e0Iv8CHzhXl6T5juFWdRZfdqyMkKfEg1QDbHSq4LVgv/1P3oL/vwjlZTJMSTU80Fqv0KhkajVsYFT0N9FUGRv0UpQVj1rt8cmiD+HFFTbdreV2TnQo6G2biNNVbeNxeSRv0ARwZjyBEod22As45VzA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8TIVje+RjQTpGtYodD7+8bPnsdDwwflA+z4i85PrBwQJ1YSc3PeH07HYlcZiuE2TXn2Tper2A4GOK0e5zYuVmodZr6hI2Ej2jVMFWHgLHUCAaxB4MlQlP+SJSD4X+Dob0BSuueSWDc0s1pAEKzFgiptC31lrRNwU2jWWum89j/SuK16LADHsX9hiVcXwSm+30QzngxD3rm/DEHQtGr0OvgnYtwqKx8phPNNlot+sQd3Pi0CEooTKcqdAfgP3lN6ek8V6rNep7dyCB5XJigMYwq9t4U+aSej56Uv0ei8oK0DDb1bv6tfEPx+iMBvPE0kVUw1Tqzz6mLmq4jdmeLAFWNqDV39Z+PFhuDdAFOsDFaehZdmaPeorPgJgPwZeGQJvmL3mOrOkVqcOMnJ2d0F2S822/TFtFSr94IuLCxg9dX7p1oiVPvGDM//oquzuTIn4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:21.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903e115c-6f98-4715-5004-08de9adde8bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Install an event handler on the CMDQV vEVENTQ fd to read and propagate
host received CMDQV errors to the guest.

The handler runs in QEMU’s main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 55 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 2 files changed, 56 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index bf989dd51f..9c2fc02b92 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/core/irq.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
@@ -534,6 +535,43 @@ out:
     trace_tegra241_cmdqv_write_mmio(offset, value, size);
 }
 
+static void tegra241_cmdqv_event_read(void *opaque)
+{
+    Tegra241CMDQV *cmdqv = opaque;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_tegra241_cmdqv vevent;
+    } buf;
+    Error *local_err = NULL;
+
+    if (!smmuv3_accel_event_read_validate(veventq,
+                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                          &buf, sizeof(buf), &local_err)) {
+        warn_report_err_once(local_err);
+        return;
+    }
+
+    if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
+        cmdqv->vintf_cmdq_err_map[0] =
+            buf.vevent.lvcmdq_err_map[0] & 0xffffffff;
+        cmdqv->vintf_cmdq_err_map[1] =
+            (buf.vevent.lvcmdq_err_map[0] >> 32) & 0xffffffff;
+        cmdqv->vintf_cmdq_err_map[2] =
+            buf.vevent.lvcmdq_err_map[1] & 0xffffffff;
+        cmdqv->vintf_cmdq_err_map[3] =
+            (buf.vevent.lvcmdq_err_map[1] >> 32) & 0xffffffff;
+        for (int i = 0; i < 4; i++) {
+            cmdqv->cmdq_err_map[i] = cmdqv->vintf_cmdq_err_map[i];
+        }
+        cmdqv->vi_err_map[0] |= 0x1;
+        qemu_irq_pulse(cmdqv->irq);
+        trace_tegra241_cmdqv_err_map(
+            cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
+            cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
+    }
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
     SMMUv3AccelState *accel = s->s_accel;
@@ -545,6 +583,7 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         return;
     }
     if (veventq) {
+        qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
         close(veventq->veventq_fd);
         iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
         g_free(veventq);
@@ -560,6 +599,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
     uint32_t viommu_id, veventq_id, veventq_fd;
     IOMMUFDVeventq *veventq;
+    int flags;
 
     if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
                                       IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
@@ -577,14 +617,29 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_viommu;
     }
 
+    flags = fcntl(veventq_fd, F_GETFL);
+    if (flags < 0) {
+        error_setg(errp, "Failed to get flags for vEVENTQ fd");
+        goto free_veventq;
+    }
+    if (fcntl(veventq_fd, F_SETFL, O_NONBLOCK | flags) < 0) {
+        error_setg(errp, "Failed to set O_NONBLOCK on vEVENTQ fd");
+        goto free_veventq;
+    }
+
     veventq = g_new(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
     cmdqv->veventq = veventq;
 
+    /* Set up event handler for veventq fd */
+    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
     *out_viommu_id = viommu_id;
     return true;
 
+free_veventq:
+    close(veventq_fd);
+    iommufd_backend_free_id(idev->iommufd, veventq_id);
 free_viommu:
     iommufd_backend_free_id(idev->iommufd, viommu_id);
     return false;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8c61d66a26..fd6441bfa7 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,6 +75,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


