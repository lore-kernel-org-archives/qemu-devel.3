Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6B8FC592E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzv-0006wP-8a; Thu, 26 Feb 2026 05:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzt-0006vY-P3; Thu, 26 Feb 2026 05:53:33 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzs-00013a-45; Thu, 26 Feb 2026 05:53:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POllceQoF0pgnphqP/KZm6G3zcwDLJ8OrbN9WwgqcQ0NaYy9eVET0Gl3e0qVM4OYfkwMq5WAOtyVGdNFD7iLNrbiWbBdCxfnTREAcAQxHdX8Le+m9T/hWeOD72lqHtRyDIEdk9OpaZanDMguNZTmBhfY+uhFpScHAUPc+8cNe8rCl0LO8XSxgtpfZVz4aefHKfgh/XVpPKBTEfFSJtWdGahjAsfw1fZLP7oleu/I5jOLPeKuBrl/Hq+CbV6UY4Hz4qWwHRp5B61PGLfShwHMdol64ihj8y2uK2zZzohVb/maz1htDNnzYFwcg98LH+eVlfO2/86cvGN1UXvls774kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/c8blDUhOE7bV+G0gEI0dRRnDqaAgxiGgCB18bAe8w=;
 b=JFMDwpxLe17FIYXsCrc5h9BeSy0gK0HwShdec/41KTJ/tF2TzPUVZQ8hhuL/Pgw/PhNoccNXm5guVX+/g07NzZXRg7qLIg353Dv4YICabKsMHtsrZMo2X0MBltRl61RtRmecE9B/3YemjGWGphtPp0eZ1InWnCD+qSYKKpuHHlL6HNyLxwU4M4HTrFqufLjMhkoZMj9tyU7OEePUJj/OjML+wmjWNUPksVUWmtCaYDVUDPqozdAZy8vATSF1D/fRxVg4CeJbetIPmca8LRJcdnAVClGew8X4lFylTrllj3CibfxJVI8qwHvMomqHBiAcLJIYknxHlsLwp++NICtuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/c8blDUhOE7bV+G0gEI0dRRnDqaAgxiGgCB18bAe8w=;
 b=aDZLeCY/WlDw0BPIWIBmlsIGvqYCB0320zPU3uykDCcgtoKFPz5XiHXO3mlpPGT/XeEMRSav+dCd+eZr1wMtql3aKVTIS8a/e6qbD0WBkBMJnZPJgEGPQ/zgjcXIcS5D9CkafhqgJA0FAqHkONj3mztqI+og4t0TMTGdnh26O+P4ou1Sh22qLOPjWbVD2DSVLDsJ/2uBbdCrlfXtIsTXvFaCdq+R9P+qytaN+UhlquvymkAJc+ceqwRndQNCo7p4co8CZwXHEWLz/e/5Ffay6kbuwonZZqrca9Z/mHC0xv8Sq1JyQTaebd90rphcqjjtF245tqkUi342Baiu9lGLvg==
Received: from SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::21)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 10:53:24 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::8a) by SA9P223CA0016.outlook.office365.com
 (2603:10b6:806:26::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:00 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:57 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 24/32] hw/arm/tegra241-cmdqv: Read and propagate Tegra241
 CMDQV errors
Date: Thu, 26 Feb 2026 10:50:48 +0000
Message-ID: <20260226105056.897-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: e55079d9-9032-4fc8-29c6-08de75254395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: 1MRXbAJt47qw4myJOZvZBd4VIR3NErA4xhaUkRpTNLbXGEgdp7QKcK23AJtBfdXiKAq/WH4lvq9Y2dmTDH97EwCSqbMU75dDxEHcXRnqvVOSqQ2wzIdcUsYuHeCDu//orcCzy/BSozsUcEc1QBv+e8AmRogYQg0Km/MetGraaxX5GjZBu3CqXt9Yq3DAwb0ssP0iUooopK03wqlSxxn2o7Kd9ggD1z3dJFt80M4CC91odxij2pV1LEOzwGRJ5mkTBmHFG79H+tF3kbyqeuUVLX3q2gUSempM4UQinbyyRknwO6Otg2gIXr8tAhZUOW9ltMMrvR1Wlv6NZrGDyO9qsqj6Uu3B3V+unnGgBHbYHeEsV0HrDetLrjbcU2eBw9AT9g7PYHm70WMWztCHTV+naedBLiShWvbUHQVLC3MKGDqjr92ncs+mjE/Feq1v6urbAIibVASGBDddzPgMMQ5jo5uO7J3Cl8sp9e/eA994078WPpHnC9TBH9pLet8wvYL3dx3LUwiPGOWtFKuXM//bSd6d1+0TFpz2e7Vbf75RkGLZf+jeMTUE9Lo5hRidKzOSoP7P22rD+7VahdrGwI9/MdRsg5ZpVdT5JUQGUVJKN5WDcAuSgDhjjHyyg+l9btc7o9on46ffcJFVpyWFoICJpKu4K/ROCekRZ9hYN1bXXQ8Wdx99trwrYChsldZXwqmk+uSv11j9cGMNA+ic1LCKOhU13gF0uWFyKGAk9g0vLQNTTBbXVqp014M0F+8iLb7D1sK+B8t16U8CIuoQD2iJ40FnZSBdaJQ0T6jzaeu7GG5XTGgFu0/6poGNYkBcaS1eJrud3ca4t2juPe3ayvUizA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MwvVyp1/Qaw7qrKMfB9eyzdF6x0e3sQVeYKgLz4wMVAU/XgkUUrI8sDw9JRYAIu4HLk5E3uWimBNln6DSs4ScW6q5ulxfGid7T/I72tf8O/OlSJDmPl/hwyzkPgKuIAjGJFrYL4UBbzXY7xesnIaMfx9QlGvxbkr6UdIl8xL1nmu2sdk41V/D/qx/A+oytMbI5H/NQJoEk0Hzvo8+69b1fSEzLzySjp7z9OrPw3VySQ90sH8xx3ge0J4OhOf7em+F1bW5bOEuFSg9RV0FyNWP0gF0s2ZqwUyYWAN4p5ZE5RXpBUozN0MAPyyoHlkTqpD1S9Bue5lW2fL2xJJVTLUEpiG2BvEQGngrYr9w/pDrRCFve3esCpxZwV77eWx9rNwOor1ujQD0mcUAenNj9kzZJ2kBRnyRNojOhv9xZ7iBitZVJWGPBAQxzFOZH3L0LZu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:23.8207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e55079d9-9032-4fc8-29c6-08de75254395
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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
 hw/arm/tegra241-cmdqv.c | 58 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  3 +++
 2 files changed, 61 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 8cde459b4f..99b85e698f 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -9,8 +9,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/core/irq.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
@@ -487,6 +489,43 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+static void tegra241_cmdqv_event_read(void *opaque)
+{
+    Tegra241CMDQV *cmdqv = opaque;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_tegra241_cmdqv vevent;
+    } buf;
+    Error *local_err;
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
+        cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
+        cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
+    }
+}
+
 static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
 {
     SMMUv3AccelState *accel = s->s_accel;
@@ -496,6 +535,7 @@ static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
     close(veventq->veventq_fd);
     iommufd_backend_free_id(veventq->viommu->iommufd, veventq->veventq_id);
     g_free(veventq);
@@ -510,6 +550,7 @@ static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
     IOMMUFDVeventq *veventq;
     uint32_t veventq_id;
     uint32_t veventq_fd;
+    int flags;
 
     if (cmdqv->veventq) {
         return true;
@@ -523,13 +564,30 @@ static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
         return false;
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
     veventq->viommu = accel->viommu;
     cmdqv->veventq = veventq;
 
+    /* Set up event handler for veventq fd */
+    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
     return true;
+
+free_veventq:
+    close(veventq_fd);
+    iommufd_backend_free_id(viommu->iommufd, veventq_id);
+    return false;
 }
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 3457536fb0..76bda0efef 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -72,6 +72,9 @@ smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev dev
 smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
 smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
 
+# tegra241-cmdqv
+tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
-- 
2.43.0


