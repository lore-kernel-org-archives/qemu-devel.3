Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241D3CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhdu-0002QY-SJ; Fri, 16 Oct 2026 09:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf04-0003Kj-AP; Fri, 16 Oct 2026 06:17:20 -0400
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf01-0002Sl-WB; Fri, 16 Oct 2026 06:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145831; bh=F+3NBbYQ7duTjQJsFBNeVolVsHxcmA5pPgQyf+ycFoE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gAW9AU2/iH+JKadfWDSA3meg3tRy1YznHn2h0O7aaY/hNqoNbyiPPOx9952kzOdVW
 1F7esqhDMbE5qHntilOwnmaAp7JkeSGGnzFJJ6wwCnAqlJaBkRfTC0klq3VUXWh1KB
 HIS36pY25xfxJaTRQ6VmCa2GGRjzrUUC3iBIwpl8=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 449272A2; Fri, 16 Oct 2026 18:17:09 +0800
X-QQ-mid: xmsmtpt1792145829treu3uonw
Message-ID: <tencent_C427298A199263A6959A34FE890C44CEDB07@qq.com>
X-QQ-XMAILINFO: MQehWLKhaMl1koD2t9N9QwSwL9G1E6oPi5l5iyZuygQGv9l7BD/RnVb8XVap0O
 kZ//dji7uAujNZzoBCFK6C0caYYneE9F5nCEYy1PwP4Cu/EaTJ89BHUGq04k1Jd/DAN0jgg254l/
 UMeN8QukCzRBQk51EUuW98acF7mghIDoP+ndc3+E4sV9VPWjkWfYrJ7LNSqXqSTMoBwk/B3Tw/l6
 vBHYqMR1NzZ/bQRUjxCtwXyrOzomqvDVyMTPL1Mxt4ZJvFHpanLSgOUvo+fX1GPiBiKnZgoFe7LN
 dNBpsOgKlk/vrmGaTU5jPtJUDsSHNatxls3trN729xfuXXSdAL43Y3OZnZ6+31KEw/mkKSVBs5np
 unqOsm1adbM1irJzceDPGtQtPfH7ez4pMGk0fqOzP+oE4Y/jWZ3jHMzYyctrYUnNamNvdjGxcgOl
 kEYmcBIZCJ8sFVv9FVKWkmetjWRd5YV7WMyQAOInGeUwy09pCHmlUU7Mcj3LCt10DbWpmisUDLIJ
 xTO/kCxyy3gAObCFFlugAnx+reLha5BZVKSZ7nKTVmy69sxOKVghb4TfWu6dsa3yPaKcmAWkGXkA
 sDZSAXnE2YmIYvZi4QychkNP8AB0G4CNFu5S3CEvFQT/FPe2tSPBaKgBUwrZ9HJJXH2eC8XkfI8+
 BzOdiFS6ZyIaFnBbU5+slhDvjhzjRsmjuadzfiEi7KvhAix3TaHhjrk2d2UeuNju+3s+QYx/+Y9F
 nTDHKR8gqvMkqDmFw53pxubMRqop4ZhAccQrT8GWp+LIwUc9vUaeWREjCwHOwmVQBm8e9+ujQW9I
 ktPQc1ZqyefueC3oY7yWa/g3e298HpNbhkutNAa4Txpx+korFWTd+9qKaHHpYK7CAdYygW4sge0D
 FdndqzeL0PDe8KotAC6mvYS+CegjzeYb+8+KMZkZ+I5MbD2x8G+oHXCODXErvynKTuP/u+ZkmPMX
 4HbRwUthbOeMLggG33ST4qoDtH8hIlUUs/6s9ndQ7HA9Ead1WVd5nvGBi+S50sMZlciQsyHLb5OG
 FPXQd5wJyqxT2K0xJY5KpSbArJ8hQ7spp0klJ3s3pDbxPEiOxKM2r6PGl7Z9ECj1d0WuwC0g==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 21/37] hw/arm/virt: Create L2/L3 cache MPAM MSCs
Date: Fri, 16 Oct 2026 18:10:41 +0800
X-OQ-MSGID: <20261016101058.1900808-7-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.210; envelope-from=2118537295@qq.com;
 helo=out162-62-57-210.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:43 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Derive the L2/L3 cache MSCs from the smp cache topology: the
sharing step comes from machine_get_cache_topo_level() so L3 MSCs
group per socket and L2 MSCs per cluster, and each MSC's cache id
(cpu | level << 16 | type << 24) matches the PPTT cache node the
MPAM table will point at.

Based on an RFC series by Jonathan Cameron, adapted to the current
cache topology API.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 77942e7..a57ba56 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2144,6 +2144,60 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
 #define MPAM_VIRT_NUM_PARTID     256
 #define MPAM_VIRT_NUM_INTPARTID  32
 
+static void create_mpam_msc_cache(VirtMachineState *vms, int level,
+                                  hwaddr *base)
+{
+    MachineState *ms = MACHINE(vms);
+    const CPUArchIdList *cpu_list = ms->possible_cpus;
+    DeviceState *dev;
+    int step, i;
+    CpuTopologyLevel topo;
+
+    /*
+     * Work out how many CPUs share a cache at this level, so each MSC
+     * covers exactly one cache, and the cache_id (derived from the
+     * first CPU of the group) matches the PPTT cache node the MPAM
+     * table points at.
+     */
+    topo = (level == 3) ?
+        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) :
+        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
+
+    if (topo == CPU_TOPOLOGY_LEVEL_SOCKET && ms->smp.sockets > 0) {
+        step = cpu_list->len / ms->smp.sockets;
+    } else if (topo == CPU_TOPOLOGY_LEVEL_CLUSTER && ms->smp.clusters > 0) {
+        /*
+         * ms->smp.clusters is per socket; possible_cpus is ordered
+         * socket-major, so dividing by the total cluster count keeps
+         * each group inside one cluster.
+         */
+        step = cpu_list->len / (ms->smp.sockets * ms->smp.clusters);
+    } else {
+        step = ms->smp.threads;
+    }
+    if (step < 1) {
+        step = 1;
+    }
+
+    for (i = 0; i < cpu_list->len; i += step) {
+        dev = qdev_new(TYPE_MPAM_MSC_CACHE);
+        object_property_set_uint(OBJECT(dev), "num-ris", 1, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-partid",
+                                 MPAM_VIRT_NUM_PARTID, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-int-partid",
+                                 MPAM_VIRT_NUM_INTPARTID,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "cache-level", level,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "cache-type", UNIFIED_CACHE,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "cpu", i, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, *base);
+        *base += MPAM_SIZE;
+    }
+}
+
 static void create_mpam_msc(VirtMachineState *vms, Error **errp)
 {
     MachineState *ms = MACHINE(vms);
@@ -2199,6 +2253,9 @@ static void create_mpam_msc(VirtMachineState *vms, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
         base += MPAM_SIZE;
     }
+
+    create_mpam_msc_cache(vms, 3, &base);
+    create_mpam_msc_cache(vms, 2, &base);
 }
 
 static void create_pcie(VirtMachineState *vms)
-- 
2.43.0


