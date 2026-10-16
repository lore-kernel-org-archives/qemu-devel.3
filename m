Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0029FCCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhbF-0000OW-L0; Fri, 16 Oct 2026 09:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf24-0003cl-18; Fri, 16 Oct 2026 06:19:24 -0400
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf20-0002aJ-6i; Fri, 16 Oct 2026 06:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145954; bh=C2RTZzq4u5bztMTFK6ZL+O4cEDg7+Arn/hMSjcudkEQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vkipGbqRPc2bLbGIX2ymJ9E/abomOIXz6wlbxet3hpEpTcd2dqYkkJG0kPMjcu2zx
 YqH6Pyv7unjBLczT1QQt1Rb1swRh4kYeIE25HPjX9fVku3m61Jy7Xmxb7oU/R65P7M
 F4Xnrexi0EMrK8hjKJNOos3OqrqrCt6jnvpgRaiw=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 4CB98E55; Fri, 16 Oct 2026 18:19:11 +0800
X-QQ-mid: xmsmtpt1792145951tem50wlp4
Message-ID: <tencent_CCF4A4F14E44206EDE9A4871CF981EA7AE0A@qq.com>
X-QQ-XMAILINFO: M9YlfoOVRfpP2rsiYzRd0CqcQjpaosD4aLnbzdTGSNGdTrnX3OFqPqtz9aLACl
 tSAXL2O2kWiiKmMdwBkJ5bHFKMBI2LCdLhauCVfPnLLFbN1yKp+wGhVNWnH2pGQ44xb6JxutKwKo
 TEk5ZIygF4sN3ulBDzkWsQtCcXNZqLLsbq/JhuRTibJpiQG6xmvphSkujoNXWpYjz1dv5p3Gvccq
 TUqcR4OTqLcyzGQQBj2MisFEKg2TkZppgg3GfTn0Q2E5+xwi+3B1Zaj3wq7NBAEKOJ3WZFm1G8tM
 P4J8zsYNepPkTIbSzMINPoLTcDj22YY7t0VusIcGcgmv6U2O1e56QbKN25Vivif0GeDfj5Nmz91G
 DzoHjXKrqN1uWVZ9651D8kWzdhS0CqdLWeUP7hs+oyC8k9xjF9MSbcI9T/8YQnkOWh6Sm/mUG7zD
 V3B6G0AbWImm0gWAL+gDrwPiagl2+wGa/FsEI/V4zSaf5VcgtsLslXCMXIVwif5ebdm5D7LGUN6O
 9lh0iNANA14FDKzzE+tDLZNGezcxKxj5tdND1u1OSFAqgqVhGbf/X3xdG1z7hkVIS2MUGlQGLgRi
 kpXghsRXrCzWJ24T3H37AzIHnh+ZV7NUd4AEhiOECSLOHdCX0N7voFJHq305ORyAXGnf0KH3ufFN
 /SofPzjCrGaq5cFNmKMO2q9FXqJeTp+Ruth6Bt75AqcR7xRA88YwvdNYeOceYgH0K9j5cmcfiL8b
 q8X4VZZ9bmE2UmCNsevSNREIjRmJZGjKbWHqTwdXnwBCKEtZXkdq5hJqTZrFf3xLA0AO8q1F8lUe
 JZA+xFPFQPj7wQwuOmNG3t5GuSJSL0joQavoMDS1IQw09cjIJf559toQduNm2S/2ySvUYmKpfN+A
 TCTmKBNf4zwOxNPiQZPHk9nYBcLwIKXBs/ABltT4EgLMWLsoHjMyptNFgrqOhUuXgY7dJOcAkrww
 0MFpCG3iV4cbVCUGo5x9tcTAVYWJJNA4DfoQ7fZbmldU1sE0bk3fvJ1JTxaB5AReoRpCQg+OUpuk
 NTi/Lhyg2XtDQLxYJbWEvJudEnJpr8oPVbBDsK92Vj5PHb82/SwJgQlSs7A5CVjuxKgoNh0M9v0z
 nTwXro
X-QQ-XMRINFO: MFuljud3PUW4Hy49K308V+nvGr8SioTB3Q==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 23/37] hw/acpi: Build the MPAM ACPI table
Date: Fri, 16 Oct 2026 18:10:43 +0800
X-OQ-MSGID: <20261016101058.1900808-9-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.87; envelope-from=2118537295@qq.com;
 helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:44 -0400
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

Assemble the MPAM table when vms->mpam is set: walk the QOM tree
for the board-created MSCs and emit each as a memory-controller or
cache-controller node with its MMIO base, wired interrupt GSIVs
and per-RIS locators -- per-node instances scope their locator to
their own NUMA node, single-MSC instances span every memory node,
and cache nodes carry the PPTT-referencing cache id.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt-acpi-build.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 871ee45..3b71af9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -985,6 +985,102 @@ static void build_msc_cache_controller(GArray *table_data, int identifier,
     }
 }
 
+struct mpam_stat {
+    MachineState *ms;
+    GArray *table_data;
+    hwaddr base_addr;
+    int count;
+    int cpu_count;
+    uint32_t mpam_id; /* Just needs to be unique */
+};
+
+static int mpam_add_msc(Object *obj, void *opaque)
+{
+    if (object_dynamic_cast(obj, TYPE_MPAM_MSC_MEM)) {
+        struct mpam_stat *mpam_s = opaque;
+        SysBusDevice *s = SYS_BUS_DEVICE(obj);
+        int num_ris = object_property_get_uint(obj, "num-ris", &error_fatal);
+        uint32_t oflow_gsiv = object_property_get_uint(obj, "oflow-gsiv",
+                                                       &error_fatal);
+        uint32_t err_gsiv = object_property_get_uint(obj, "err-gsiv",
+                                                     &error_fatal);
+        uint64_t *ids = g_new0(uint64_t, num_ris);
+        int j = 0;
+        int i;
+
+        /*
+         * Locator for each RIS.  A per-node instance (node property set)
+         * covers exactly its own NUMA node; a single-MSC instance spans
+         * every memory-bearing node, one RIS each.
+         */
+        if (object_property_get_uint(obj, "node", &error_fatal) != UINT16_MAX) {
+            ids[j++] = object_property_get_uint(obj, "node", &error_fatal);
+        }
+        for (i = 0; i < mpam_s->ms->numa_state->num_nodes; i++) {
+            if (j >= num_ris) {
+                break;
+            }
+            if (mpam_s->ms->numa_state->nodes[i].node_mem) {
+                ids[j++] = i;
+            }
+        }
+
+        build_msc_memory_controller(mpam_s->table_data, mpam_s->count,
+                                    s->mmio[0].addr, mpam_s->mpam_id++,
+                                    num_ris, ids, oflow_gsiv, err_gsiv);
+        mpam_s->count++;
+        g_free(ids);
+    }
+
+    if (object_dynamic_cast(obj, TYPE_MPAM_MSC_CACHE)) {
+        struct mpam_stat *mpam_s = opaque;
+        SysBusDevice *s = SYS_BUS_DEVICE(obj);
+        int num_ris = 1;
+        uint64_t *ids = g_new0(uint64_t, num_ris);
+        uint8_t cache_level = object_property_get_uint(obj, "cache-level",
+                                                       &error_fatal);
+        uint8_t cache_type = object_property_get_uint(obj, "cache-type",
+                                                      &error_fatal);
+        uint16_t cpu = object_property_get_uint(obj, "cpu", &error_fatal);
+        uint32_t oflow_gsiv = object_property_get_uint(obj, "oflow-gsiv",
+                                                       &error_fatal);
+        uint32_t err_gsiv = object_property_get_uint(obj, "err-gsiv",
+                                                     &error_fatal);
+
+        ids[0] = PPTT_CACHE_ID(cache_type, cache_level, cpu);
+        build_msc_cache_controller(mpam_s->table_data, mpam_s->count,
+                                   s->mmio[0].addr, mpam_s->mpam_id++,
+                                   num_ris, ids, oflow_gsiv, err_gsiv);
+        mpam_s->count++;
+        g_free(ids);
+    }
+
+    return 0;
+}
+
+static void
+build_mpam(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+{
+    AcpiTable table = {
+        .sig = "MPAM",
+        .rev = 1,
+        .oem_id = vms->oem_id,
+        .oem_table_id = vms->oem_table_id,
+    };
+    struct mpam_stat mpam_s = {
+        .ms = MACHINE(vms),
+        .count = 0,
+        .base_addr = vms->memmap[VIRT_MPAM_MSC].base,
+        .table_data = table_data,
+    };
+
+    acpi_table_begin(&table, table_data);
+
+    object_child_foreach_recursive(object_get_root(), mpam_add_msc, &mpam_s);
+
+    acpi_table_end(linker, &table);
+}
+
 /*
  * ACPI spec, Revision 6.5
  * 5.2.25 Generic Timer Description Table (GTDT)
@@ -1517,6 +1613,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_gtdt(tables_blob, tables->linker, vms, wdt && !has_wdat);
 
+    if (vms->mpam) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_mpam(tables_blob, tables->linker, vms);
+    }
+
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
-- 
2.43.0


