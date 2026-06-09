Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B86DCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudh-0001gI-9J; Tue, 09 Jun 2026 07:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudP-0008TJ-Hx; Tue, 09 Jun 2026 07:28:43 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudN-0003MC-OE; Tue, 09 Jun 2026 07:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHtOMgRJ1i/L0KYREQGseFdpmaAm1rK6LhJk2y7Hkxkb64PuTVFEf3ewtN4W/zZ2cTgIH0NvYpGiHc9wenZfAkfqXAEE702r8xvPtk2KoQHL/Adn7Jen3koAweGRUbg1A7VujRXJOrfQTbLNuVdBFqKZpzXzGLYsReyRWfOyAGEnVYosrWp+KfXADEjrfS5Rw8+5DtizG3KOcuJupetlrYSyToJ0hywxqmKQOdebqGHDyS/tQvJitaMIW7P8wpUsANHA1j27zQpehRZSL3VxKOMenESjGD25VeuQElICPC+mEMXqM5Y1y6B4zVzCYCp2lISN1Ld63wQ49JlziI/4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcujV4QVm67fxL6GgXbfiiDX4+9ZytIVT5IQyoKybBo=;
 b=VJuRqL4kG7r8c1GZyoJeVZQu5c8mFeSmhzpPuIgqu8JIttzkf2LJA7FUlQa9UJjlhrAmoHqknjG0apMx3d+eBjLVso86Ag3T8DxWlBuQcx8MD66lTY5/ULdGnDOEmeLQ8LhU+aXDz0yldjqT6YQniLicjSmfQgYnod/f3il5o2J7txeKHtqZ/0u1oPK+cDPEIrPHXQUvXXL7xxTjmnNPn1An0e+Xstah1k2DTHOx2Gwhxubml1zILzhqL+BXARV5vsAJp6w2/0XK0FBiZb9BW8EGFr7Gd4S+2jOiW947ivrY03r7DOj4gbV9Am8rky3Qfd+2J9V15wPjvyX+9/2Rsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcujV4QVm67fxL6GgXbfiiDX4+9ZytIVT5IQyoKybBo=;
 b=cdRyw6xsoJQ2y9ISAHSpFPxCzQuNh0R511JYottbovP7NuaE2I0O1HBxc6jUI10Mpk2sYhRpe5lcYGn5xR9d24fbDCdhIlPNhOJJZStKEAdUuID7jcTcMi7zIllwaSfwK+jMegyX/+UjIUeSdGuWS1nO5x2Rd0WL8W0frHTeemypAnpqtNMhclQwZvS7FQqqS4FX9RwVZVWC0Sl1ecW6dVKtFXDM0KNmYwaAvJAWlYN5P9hPcS87xDnpLxHu1w87mMVR+QwGPFiaQL65KP2Bfsqd+9q7g5P4scwH8HjQA1AnTbSBXFgLLWo2sF7WHE8sb6lieRPNjac9gD70Uc4FoA==
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:28:36 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::a6) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:16 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:13 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 23/31] hw/arm/tegra241-cmdqv: Read and propagate Tegra241
 CMDQV errors
Date: Tue, 9 Jun 2026 12:25:44 +0100
Message-ID: <20260609112552.378999-24-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: eeae847a-dd98-4a0e-9598-08dec61a3f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uXG00VhN/YgNPhbAEefMwx26jBbJomDUQR2m/NZEQNrbGvRJlkIxg5hV+jocyPK2lJMkiIpk66PLxXEzvl7q+4t/si9xG/SEKehMs3RyDZ6eNPusfvd/eQme3vha4z3dNjNaDJb+S/OXw4yZKMyR0H6yA9emgorCt0/fRoI3YFXbKjPb6G13njx/4pqr4KKc+SMzCuAu9b2q2NLCih9u+5saynEDfxmcHo4vNPTIUzA+V5nxxKx0eEgR9jqk0L6Anfbf+RreHV5yR3CUojdpCXLnfvAojkqJq5sj485scQMFsCPWw6XMFgm/0bG2IFQp/wlclNHs6M1ZDKlJljmXk3F7VBr6h+0Tp6pymuvG+61+4yVEspz9tFScTz/ZIJta1C1Vxj8Xj/RUpshSeALL69WU4Esx1c9hPncmYK6TL3dNthPZHxE2ApVY79mW04wnIfbNdFyGIhdEHOJGLSl2QPDAQPdvVlysQJFcW+LmNI3mLgvYv68yEfq03O8tQZQJoVTajGfiZ3j3WoqCMQS0m0tmzMh5xsB6Fkx2zZj4HM35KNP9+CB9uN8X0ZlJCWpL6++dafh9NNg73CkCncGWqdXCgt/WGkFb2yJC7NLsncQeInTBnjKJp0Zb2kySFdzo/drpbfQo6/0k9zD5G1Rl7mlfn/G8J5THaIphsZmOIVAsTci/SXpjSs9AszfaXaoXM2HrLJPhhaMOhkHdg9Yzco3itfgp4K8ncJlM2RKCj24=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uO5vi7W4kzMtx+y4yFNfAlRCrUBKQf1uuiJPLzUQeSu1XhRQzZCsrz3iprr7nIEqwMjJhvIOpOpNdEXpowTEcF7MqGnlB92dza+ttBJP/muiOu03b/883lmXDdegWEEIFV3LKmsLVNEjXfxBx0wPV1SIoSOkc984zOPBBmYnGnJLnviAerfLu984+X1AW+COy6vDfZd6G1TiA3vFvIkKuMh6CztxlhHSyeCNtgCcu6EugiYuEY7Tw8hkXXbPhaM0NStnNlo8oZXTjmKA002vrdLd2VKmyWpbhDwg7yzD3yapP69c/IV66mRlbf62N8iCffKPdg6XY6cgrNeKqEyxTnAfcmi+DOUOlRjTPj6Yl8OaGW2wDC+wphih4JPRu5NmmctWsSj73vtmQi3yQVIbCgRIDLioHuK1hXUbPnK8iYkG4vF0rqGu1qLL5pSZnwst
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:36.0267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeae847a-dd98-4a0e-9598-08dec61a3f08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 63 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 2 files changed, 64 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 7264b4bfa9..ff0fcd1e66 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -12,6 +12,7 @@
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-common.h"
+#include "hw/core/irq.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
@@ -729,6 +730,51 @@ out:
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
+            extract64(buf.vevent.lvcmdq_err_map[0], 0, 32);
+        cmdqv->vintf_cmdq_err_map[1] =
+            extract64(buf.vevent.lvcmdq_err_map[0], 32, 32);
+        cmdqv->vintf_cmdq_err_map[2] =
+            extract64(buf.vevent.lvcmdq_err_map[1], 0, 32);
+        cmdqv->vintf_cmdq_err_map[3] =
+            extract64(buf.vevent.lvcmdq_err_map[1], 32, 32);
+        /*
+         * CMDQV_CMDQ_ERR_MAP and VINTF0_LVCMDQ_ERR_MAP are distinct
+         * registers (different MMIO offsets). With only VINTF0 exposed
+         * they carry the same data, so mirror.
+         */
+        for (int i = 0; i < 4; i++) {
+            cmdqv->cmdq_err_map[i] = cmdqv->vintf_cmdq_err_map[i];
+        }
+        /* Set the VINTF0 bit in VI_ERR_MAP_0 (only VINTF0 is exposed). */
+        cmdqv->vi_err_map[0] |= BIT(0);
+        if (!(cmdqv->vi_int_mask[0] & BIT(0))) {
+            qemu_irq_pulse(cmdqv->irq);
+        }
+        trace_tegra241_cmdqv_err_map(
+            cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
+            cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
+    }
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
     SMMUv3AccelState *accel = s->s_accel;
@@ -740,6 +786,7 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         return;
     }
     if (veventq) {
+        qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
         close(veventq->veventq_fd);
         iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
         g_free(veventq);
@@ -759,6 +806,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
     uint32_t viommu_id, veventq_id, veventq_fd;
     IOMMUFDVeventq *veventq;
+    int flags;
 
     if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
                                       IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
@@ -784,14 +832,29 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto munmap_page0;
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
 munmap_page0:
     munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
     cmdqv->vintf_page0 = NULL;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index a8dcbc82db..dbed00afbb 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,6 +75,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
-- 
2.43.0


