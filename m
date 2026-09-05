Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB78C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 17:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uaO-0005KF-JQ; Sat, 05 Sep 2026 13:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaH-0005ED-Ap; Sat, 05 Sep 2026 13:53:45 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaE-0008I8-2G; Sat, 05 Sep 2026 13:53:45 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DDDBC4345B;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15CA1F00A3F;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788630812;
 bh=thcqgOO3ngF6wL+4cjJHzcIM722Ty9k1ajLeGeC9oG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wlr1NiOB84Nri9E0jzWM+4Ac4OQ18Kg9YBxW7nX5t3YzbBqddGXr5JP5R/U+a8toy
 KLWuybG9AnS2a1pYVoN1pY5j+XzODHBNhEaA4k6G9/LShb1CAdshS7SZXjWhc1Ezuj
 Jm50y1GjT4RPaEAsM7aZb0g9HNYFJJSME2syoOG/scgl4AXCaFx0cpWBFPANWqz1gJ
 3WLnPWae31+OnsVuc9Bc3H0x5TB2Jds5XMY52DA+VRsL5MYJ68VjiTP5MTbrDuVsI/
 qTo5p7up8Vlw8uoAFXBZcK0GpUcVUjnNx033vFdieqtyDhlJeSGaYf/BmW1xk7vD7P
 PTWc4t8vO84Rw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.5)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2ua2-0000000Bks9-3chS; Sat, 05 Sep 2026 19:53:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 8/8] tests: add GHES tests for x86 piix4 and q35
Date: Sat,  5 Sep 2026 19:53:28 +0200
Message-ID: <694086fd203b3149de806e66aaa70b8f181db957.1788630333.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788630333.git.mchehab+huawei@kernel.org>
References: <cover.1788630333.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support to test GHES on x86 using the SCI mechanism.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tests/qtest/bios-tables-test.c | 66 +++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 5582b1dd72e4..77399e9100d9 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -914,7 +914,8 @@ static uint8_t base_required_struct_types[] = {
     0, 1, 3, 4, 16, 17, 19, 32, 127
 };
 
-static void test_acpi_ghes_v2_injection(test_data *data)
+static void test_acpi_ghes_v2_injection(test_data *data, bool sci,
+                                        int notif_type)
 {
     const uint8_t cper[20] = { [0] = 2, [16] = 2 }; /* corrected GESB */
     g_autofree char *payload = g_base64_encode(cper, sizeof(cper));
@@ -923,14 +924,18 @@ static void test_acpi_ghes_v2_injection(test_data *data)
     QTestState *qts = data->qts;
     const uint8_t *ghes = NULL;
     AcpiSdtTable *hest = NULL;
+    AcpiSdtTable *fadt = NULL;
     AcpiSdtTable *table;
+    uint8_t gpe_len;
+    uint32_t gpe0;
 
     for (unsigned i = 0; i < data->tables->len; i++) {
         table = &g_array_index(data->tables, AcpiSdtTable, i);
 
         if (compare_signature(table, "HEST")) {
             hest = table;
-            break;
+        } else if (compare_signature(table, "FACP")) {
+            fadt = table;
         }
     }
     g_assert_nonnull(hest);
@@ -945,29 +950,51 @@ static void test_acpi_ghes_v2_injection(test_data *data)
         }
     }
     g_assert_nonnull(ghes);
-    g_assert_cmpuint(ghes[32], ==, 7); /* GPIO notification */
+    g_assert_cmpuint(ghes[32], ==, notif_type);
     status_addr = qtest_readq(qts, ldq_le_p(ghes + 24));
     ack_addr = ldq_le_p(ghes + 68);
     g_assert_cmphex(status_addr, !=, 0);
     g_assert_cmphex(ack_addr, !=, 0);
     g_assert_cmpuint(qtest_readq(qts, ack_addr), ==, 1);
 
+    if (sci) {
+        g_assert_nonnull(fadt);
+        gpe0 = ldl_le_p(fadt->aml + 80);
+        gpe_len = fadt->aml[92];
+        qtest_irq_intercept_in(qts, "ioapic");
+        qtest_outb(qts, gpe0, 0xff);
+        qtest_outb(qts, gpe0 + gpe_len / 2, 0x80);
+    }
+
     for (unsigned i = 0; i < 3; i++) {
+        if (sci) {
+            g_assert_false(qtest_get_irq(qts, 9));
+        }
         qtest_qmp_assert_success(qts,
             "{'execute': 'inject-ghes-v2-error', 'arguments': {'cper': %s}}",
             payload);
         g_assert_cmpuint(qtest_readq(qts, ack_addr), ==, 0);
         qtest_memread(qts, status_addr, actual, sizeof(actual));
         g_assert_cmpmem(actual, sizeof(actual), cper, sizeof(cper));
-
-        /* GED converts the GPIO notification into an Error event. */
-        g_assert_cmphex(qtest_readl(qts, VIRT_ACPI_GED_BASE), ==, 0x20);
-        g_assert_cmphex(qtest_readl(qts, VIRT_ACPI_GED_BASE), ==, 0);
+        if (sci) {
+            g_assert_cmphex(qtest_inb(qts, gpe0) & 0x80, ==, 0x80);
+            g_assert_true(qtest_get_irq(qts, 9));
+        } else {
+            /* GED converts the GPIO notification into an Error event. */
+            g_assert_cmphex(qtest_readl(qts, VIRT_ACPI_GED_BASE), ==, 0x20);
+            g_assert_cmphex(qtest_readl(qts, VIRT_ACPI_GED_BASE), ==, 0);
+        }
 
         /* A second injection must wait for OSPM's acknowledgement. */
         qobject_unref(qtest_qmp_assert_failure_ref(qts,
             "{'execute': 'inject-ghes-v2-error', 'arguments': {'cper': %s}}",
             payload));
+
+        if (sci) {
+            /* Emulate OSPM clearing the edge GPE. */
+            qtest_outb(qts, gpe0, 0x80);
+            g_assert_false(qtest_get_irq(qts, 9));
+        }
         qtest_writeq(qts, ack_addr, 1);
     }
 }
@@ -987,7 +1014,28 @@ static void test_acpi_aarch64_virt_ras(void)
 
     test_vm_prepare("-cpu cortex-a57 -machine ras=on", &data);
     process_acpi_tables_noexit(&data);
-    test_acpi_ghes_v2_injection(&data);
+    test_acpi_ghes_v2_injection(&data, false, 7);
+    qtest_quit(data.qts);
+    free_test_data(&data);
+}
+
+static void test_acpi_x86_ras(const void *opaque)
+{
+    test_data data = {
+        .machine = opaque,
+        .arch = "x86",
+        .variant = ".ras",
+    };
+
+    test_vm_prepare("-machine ras=on", &data);
+    process_acpi_tables_noexit(&data);
+    test_acpi_ghes_v2_injection(&data, true, 3);
+    free_test_data(&data);
+
+    /* Check if fw restored error buffer, then write back HEST on reset. */
+    qtest_system_reset(data.qts);
+    process_acpi_tables_noexit(&data);
+    test_acpi_ghes_v2_injection(&data, true, 3);
     qtest_quit(data.qts);
     free_test_data(&data);
 }
@@ -2875,6 +2923,7 @@ int main(int argc, char *argv[])
         }
         if (qtest_has_machine(MACHINE_PC)) {
             qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
+            qtest_add_data_func("acpi/piix4/ras", MACHINE_PC, test_acpi_x86_ras);
             qtest_add_func("acpi/piix4/oem-fields", test_acpi_piix4_oem_fields);
             qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
             qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
@@ -2913,6 +2962,7 @@ int main(int argc, char *argv[])
         }
         if (qtest_has_machine(MACHINE_Q35)) {
             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
+            qtest_add_data_func("acpi/q35/ras", MACHINE_Q35, test_acpi_x86_ras);
             qtest_add_func("acpi/q35/oem-fields", test_acpi_q35_oem_fields);
             if (tpm_model_is_available("-machine q35", "tpm-tis")) {
                 qtest_add_func("acpi/q35/tpm2-tis", test_acpi_q35_tcg_tpm2_tis);
-- 
2.55.0


