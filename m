Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5B9CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhe8-0002nQ-RK; Fri, 16 Oct 2026 09:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf11-0003Us-Uz; Fri, 16 Oct 2026 06:18:19 -0400
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf0z-0002Um-3I; Fri, 16 Oct 2026 06:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145892; bh=86sTBapwQiSDrYD5ErNUQ+RgQt/BnCmBs1DfUgrcRjE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=zz/wOfXlLa8+G0NNfVYMTVHXAjB7LMsDJIPOUMO+loxeMzAxgak5yY4o52rM7tu+x
 lOw7X4W0NghSPBj167z05pREdGd1Q+JuN2aPG8giAtgMSvKhbBnXCY4H0dlzjegxfw
 vy7haPgYcWpxfYrJzGRTwV7+C8wPArzdXR7NOhAE=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 48A3704A; Fri, 16 Oct 2026 18:18:10 +0800
X-QQ-mid: xmsmtpt1792145890t9aepixc8
Message-ID: <tencent_9B35CD72A206F1E676456A66E6F898612505@qq.com>
X-QQ-XMAILINFO: MLINc68tus9/i0LV/YdTp8mS+PFAaIH55Q2YLpMh0/EShlEeRFJ7w/SxyJ6bpe
 d4PIUSjs1qyx7LYMsR5gzjcqatuExxkAj0q8CgpalitLsMM0Tuj20YxREJUSWB/PovECAI0wN9sX
 Ss/nkdK4A19+GI6CsXr9jn1EE+Vvi/UBfd7JgJyufcPqSGWRpL65G6B+kFRAQxYzBCgbxVUZx+qw
 znWCP3jbsPM0+FivhTb6MvHbxo5Nr4ITN/+fb5//CwgcWST97bjC86koam6Z/n/sSsSUEF1FKaPK
 kbr44npYZKLuo+bu+srQTHnSpZ1ZLacnxe2tmd9dIJSscq3bigAIvcn0PMXkPjRGXsuOXCxK0w+L
 weOju7hVykOqx3d2L9aH720F5S6v7qcMBcAoevW7SFIvMoQ2VbY0ww4kEIpYNm0WytppJC9+J8in
 PImfCQPhlyxp0JZjKc+wu0k5RssS/vxxHu1hHvZLzYucLLbpHPbVsnFmn/ovOgi/bZXXXJ632gnF
 wjPkRn8u/5hMSSW7qNhFZRx9RV3jjCb7jbEEHoZ/JHGFZWqlqUdRT2eaPVS7eU/Z4gF4j1N3e3nt
 tL9TeOjAnkMVkyM2FevmHPgg6cvWyl2vpT7c9sxoIcPQj/NbKZr/ISoyNEEygUHhYZLL3W6xVCN+
 YXgFp5P9nxVJeJTUBtGU9Uy0UftEX25zKApq09LnvyDWbmUgRgoYq58iyYDIxzC9Jupx319B0fat
 uF/iP8NXdSZY8mJnQXwB6UYnI42mllQGRe2e8Qjo08tFTWEphq0qSU3F7AEzberH7weAoEkqXpri
 /0wHpikHIBNupF6xbaWO8LqO7BplCtFShgOXeoxNy6+501Y4MZlGSmPWwUr1nvZu/rSuSzJnCLoP
 dDcfrfH/VVZUFxD1ZNSCuosq+By8hb+j2GSIsrmhK9n0r+lEsSsZDZcma8yW55dhGRnVlPRHaAXX
 8LTj/ALEHQja9AQSFtehpfgTuAWrAzC0eZRUiCLoxcfNDFO3Qza+RGP8djSGF8IoVmIllVeNId5U
 bSWE7KQEwf40B6s7s0N8S144XRs+uUEG5Q2wnuVjWlOkBtZEQTvs6ByWvYgidMTzMsa0LWiQ==
X-QQ-XMRINFO: NmyfvsrRkCkJAbzJWTXK6qOFf6uNn0Tzaw==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 22/37] hw/acpi: Add MPAM table MSC node builders
Date: Fri, 16 Oct 2026 18:10:42 +0800
X-OQ-MSGID: <20261016101058.1900808-8-2118537295@qq.com>
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

Add the DEN0065 MSC node builders for the MPAM table: the
interrupt entry (flags 0 = wired, level per Table 5; GSIV 0 means
not present) and the memory-controller and cache-controller node
layouts (fixed 72-byte header plus one 24-byte resource node per
RIS, MAX_NRDY_USEC 100) with the matching locators (proximity
domain for memory, PPTT cache id for caches).

Static helpers; wired into the generated table by the next patch.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt-acpi-build.c | 130 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index d368913..871ee45 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -52,6 +52,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/virt.h"
+#include "hw/arm/mpam.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/core/platform-bus.h"
@@ -855,6 +856,135 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_end(linker, &table);
 }
 
+/*
+ * DEN0065 3.0 Table 5: interrupt flags bit0 = mode (0 level, 1 edge),
+ * bits[2:1] = type (00b wired), bit4 = affinity valid (must be 0 for an
+ * SPI).  The MSC model signals both interrupts level, so flags are 0.
+ * GSIV 0 means the interrupt is not present.
+ */
+/*
+ * DEN0065 4.0: an MSC node is a 72-byte fixed header plus one 24-byte
+ * resource node per RIS.  MAX_NRDY_USEC 100 is the default ready-time.
+ */
+#define MPAM_MSC_NODE_HDR_LEN   72
+#define MPAM_MSC_RIS_ENTRY_LEN   24
+#define MPAM_MSC_MAX_NRDY_USEC  100
+
+static void build_msc_interrupt(GArray *table_data, uint32_t gsiv)
+{
+    build_append_int_noprefix(table_data, gsiv, 4);
+    build_append_int_noprefix(table_data, 0 /* wired, level */, 4);
+}
+
+static void build_msc_memory_controller(GArray *table_data, int identifier,
+                                        hwaddr base_addr, uint32_t mpam_id,
+                                        int num_ris, uint64_t *nodes,
+                                        uint32_t oflow_gsiv,
+                                        uint32_t err_gsiv)
+{
+    int length = MPAM_MSC_NODE_HDR_LEN + MPAM_MSC_RIS_ENTRY_LEN * num_ris;
+    int i;
+
+    build_append_int_noprefix(table_data, length, 2);
+    /* Interface Type */
+    build_append_int_noprefix(table_data, 0 /* MMIO */, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    build_append_int_noprefix(table_data, identifier, 4);
+    build_append_int_noprefix(table_data, base_addr, 8);
+    build_append_int_noprefix(table_data, MPAM_SIZE, 4);
+    /* Overflow interrupt */
+    build_msc_interrupt(table_data, oflow_gsiv);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Overflow Int Affinity */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Error interrupt */
+    build_msc_interrupt(table_data, err_gsiv);
+    /* More reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Error Int Affinity */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* MAX_NRDY_USEC */
+    build_append_int_noprefix(table_data, MPAM_MSC_MAX_NRDY_USEC, 4);
+    /* Linked Device - none for now */
+    build_append_int_noprefix(table_data, 0, 8);
+    /* _UID of linked device */
+    build_append_int_noprefix(table_data, 0, 4);
+    build_append_int_noprefix(table_data, num_ris, 4);
+    /* Build a memory controller resource */
+    for (i = 0; i < num_ris; i++) {
+        build_append_int_noprefix(table_data, mpam_id, 4);
+        build_append_int_noprefix(table_data, i, 1);
+        /* Reserved1 */
+        build_append_int_noprefix(table_data, 0, 2);
+        /* Locator type - 1 = Memory */
+        build_append_int_noprefix(table_data, 1, 1);
+        /* Locator part 1 Node */
+        build_append_int_noprefix(table_data, nodes[i], 8);
+        /* Locator part 2 reserved */
+        build_append_int_noprefix(table_data, 0, 4);
+        /* Num functional dependencies */
+        build_append_int_noprefix(table_data, 0, 4);
+    }
+}
+
+static void build_msc_cache_controller(GArray *table_data, int identifier,
+                                       hwaddr base_addr, uint32_t mpam_id,
+                                       int num_ris, uint64_t *cache_id,
+                                       uint32_t oflow_gsiv,
+                                       uint32_t err_gsiv)
+{
+    int length = MPAM_MSC_NODE_HDR_LEN + MPAM_MSC_RIS_ENTRY_LEN * num_ris;
+    int i;
+
+    build_append_int_noprefix(table_data, length, 2);
+    /* Interface Type */
+    build_append_int_noprefix(table_data, 0 /* MMIO */, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    build_append_int_noprefix(table_data, identifier, 4);
+    build_append_int_noprefix(table_data, base_addr, 8);
+    build_append_int_noprefix(table_data, MPAM_SIZE, 4);
+    /* Overflow interrupt */
+    build_msc_interrupt(table_data, oflow_gsiv);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Overflow Int Affinity */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Error interrupt */
+    build_msc_interrupt(table_data, err_gsiv);
+    /* More reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Error Int Affinity */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* MAX_NRDY_USEC */
+    build_append_int_noprefix(table_data, MPAM_MSC_MAX_NRDY_USEC, 4);
+    /* Linked Device - none for now */
+    build_append_int_noprefix(table_data, 0, 8);
+    /* _UID of linked device */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Num resource nodes */
+    build_append_int_noprefix(table_data, num_ris, 4);
+    /* Build a cache resource */
+    for (i = 0; i < num_ris; i++) {
+        /* Identifier */
+        build_append_int_noprefix(table_data, mpam_id, 4);
+        /* RIS index */
+        build_append_int_noprefix(table_data, i, 1);
+        /* Reserved1 */
+        build_append_int_noprefix(table_data, 0, 2);
+        /* Locator type - 0 = Cache */
+        build_append_int_noprefix(table_data, 0, 1);
+        /* Locator part 1 PPTT ID */
+        build_append_int_noprefix(table_data, cache_id[i], 8);
+        /* Locator part 2 reserved */
+        build_append_int_noprefix(table_data, 0, 4);
+        /* Num functional dependencies */
+        build_append_int_noprefix(table_data, 0, 4);
+    }
+}
+
 /*
  * ACPI spec, Revision 6.5
  * 5.2.25 Generic Timer Description Table (GTDT)
-- 
2.43.0


