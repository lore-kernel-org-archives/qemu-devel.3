Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8712CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUKP-00056v-0E; Tue, 16 Jun 2026 09:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wZUKL-00056R-IN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:59:41 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wZUKJ-0007MS-Rm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:59:41 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5aa68d65d24so4190006e87.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781618378; x=1782223178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkszgkRrL+lmmUAapTwwBv/OpmRR46GIrD5NRqmSiUY=;
 b=Ym6tQIrhD6YzmnzMCMnFhSe1t6Ma9Z8l5kxzjPuIp1Ax4C8a7joCC8FjRdbrYvyjtl
 LKj9qaTYlB9JPEZtQgM1M4qSvMiqrPk8K9RCxFkXEN4vkqNFu1pl2s6RsGjMk7KMRroC
 /1s1bMbtIIsOSbEBtbYUiJrotHTjWbSsDq+WXq2E7UtDWepAMeg8d9j138rdf0j6dDib
 hy2IqoeZbNaXjVEykfmSpPSypWiwhwM9ZYOuDqN3JNO1xAML/Pfgn8hCUIzvJJVoFqwH
 oT+v0izKoxkz/wlCJNfnNGyV9RUQluhgnb8vzSFTBfGofBfn83svwP75PmdTR02xiisS
 W5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781618378; x=1782223178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YkszgkRrL+lmmUAapTwwBv/OpmRR46GIrD5NRqmSiUY=;
 b=Cn0nN2zLjq50GVWAKOrNHJLy4UCAfMwaILMma+QAw+8gipUKz1ROBON0bSWhGJaicz
 BmVpxmx9koW/eO2TEg3c0uwCceFt3CifOafTescaDZlC3N9cu9ShKU5ydFn37pSV8Qdi
 KEzireQqYqChoHnMI8VdINmWoJ86qPMZAqGAxStLDz9ZL+LjTqns04zkZDCc0h1poBw/
 4bdk3h3wb0PgSPVXpcikURMJKdqOLgiQ+kz+nop1QJ4Y9338818POycAZl/ikNugSBkC
 bUfCrboHg7OOBmYJ7KRS6NFGPkSVuU/j7E4+gCEJJcfvh+Tk8YanUY0Km17qWN4y7o5x
 UcYQ==
X-Gm-Message-State: AOJu0YywblQpwYIVDgEXa/1G3PPjZihQ3K0T/N4zy8H833Y7h4rsuZEh
 0zUCzsmUS6moehG3xw1hYERZ+2hGdEdFLAcCs4lfrsHyi3PEiqmJ4fHJa+VICNRW3FI=
X-Gm-Gg: Acq92OELiUesxuRPAz1dzdzC2BEtnfLIpFr9r+sqWvTZ5cOE6VQqSZtkl6LW3gGbU49
 cduJXjhjKiI6XBhjr1mXk3d3rqyHEj5qWX8UtHpVo4Vql9aIT5ijAD4z0BB2BXV+CY4PvmtczTX
 gXtVjQx1li2fLp+w3Us7pKLK6Hjco64BQJmVUo1Ji2oU2lTEmtiBFwVkx6Inh9/BrbW758BEyQz
 WM1qgGxETR449tZnmtu4dyF/PEgo3Kjzk6T7dtH/g28g1DLyr3gO6ka17TnXb6+N1agCwzWK+XT
 nyAjEr+vQ0b4X7CT2oyb1SN+jjFfzFsH/8A3LF26ctzE/UQv9CTYxvWLOJVV/WXYfkBZBOqieiG
 VWJLSFc83TE5JwpNCiXpTSuo2unuQm98PJmaJftzX33JWZ4W03k1Wro4MmIkatquSudXPO8WboS
 SJ46WafnYwp/yrbIuZ/aome1xIk2FE718LZl3mgWqjL6bZTsnW
X-Received: by 2002:a05:6512:6c9:b0:5a8:886f:c03d with SMTP id
 2adb3069b0e04-5ad4277814bmr1443808e87.19.1781618377634; 
 Tue, 16 Jun 2026 06:59:37 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8011:f00:689d:b3a0:c7eb:5526])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161f1esm3634677e87.2.2026.06.16.06.59.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 06:59:36 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, philmd@linaro.org,
 anisinha@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 zhao1.liu@intel.com, Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH v2 3/3] tests/qtest: Add SMBIOS Type 8 handle base tests
Date: Tue, 16 Jun 2026 16:59:04 +0300
Message-Id: <20260616135904.44930-4-xpahos@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260616135904.44930-1-xpahos@gmail.com>
References: <20260616135904.44930-1-xpahos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Verify that SMBIOS Type 8 table handles use the correct base address
depending on the machine type version:
- pc-q35-11.2 and pc-i440fx-11.2 (latest): handles start at 0x800
- pc-q35-11.1 and pc-i440fx-11.1 (compat): handles start at 0x0
Each test creates two Type 8 entries to verify both the base address
and sequential handle assignment (base+0, base+1).

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
 tests/qtest/bios-tables-test.c | 70 +++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 510751799e..66d6015667 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -99,6 +99,7 @@ typedef struct {
     uint16_t smbios_core_count2;
     uint8_t smbios_thread_count;
     uint16_t smbios_thread_count2;
+    bool smbios_type8_t8_base;
     uint8_t *required_struct_types;
     int required_struct_types_len;
     int type4_count;
@@ -720,12 +721,22 @@ static void smbios_type4_count_test(test_data *data, int type4_count)
     }
 }
 
+static void smbios_type8_test(test_data *data, uint32_t addr,
+                              int instance)
+{
+    uint16_t handle = qtest_readw(data->qts,
+        addr + offsetof(struct smbios_structure_header, handle));
+    uint16_t expected_base = data->smbios_type8_t8_base ? 0x800 : 0x0;
+
+    g_assert_cmpuint(handle, ==, expected_base + instance);
+}
+
 static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
 {
     DECLARE_BITMAP(struct_bitmap, SMBIOS_MAX_TYPE+1) = { 0 };
 
     SmbiosEntryPoint *ep_table = &data->smbios_ep_table;
-    int i = 0, len, max_len = 0, type4_count = 0;
+    int i = 0, len, max_len = 0, type4_count = 0, type8_count = 0;
     uint8_t type, prv, crt;
     uint64_t addr;
 
@@ -754,6 +765,11 @@ static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
             type4_count++;
         }
 
+        if (type == 8) {
+            smbios_type8_test(data, addr, type8_count);
+            type8_count++;
+        }
+
         /* seek to end of unformatted string area of this struct ("\0\0") */
         prv = crt = 1;
         while (prv || crt) {
@@ -2534,6 +2550,50 @@ static void test_acpi_isapc_smbios_legacy(void)
     free_test_data(&data);
 }
 
+static void test_smbios_type8_common(const char *machine,
+                                     const char *variant, bool t8_base)
+{
+    uint8_t req_type8[] = { 8 };
+    test_data data = {
+        .machine = machine,
+        .arch    = "x86",
+        .variant = variant,
+        .required_struct_types = req_type8,
+        .required_struct_types_len = ARRAY_SIZE(req_type8),
+        .smbios_type8_t8_base = t8_base,
+    };
+
+    test_smbios("-smbios type=8,connector_type=7,port_type=8,"
+                "external_reference=USB1 "
+                "-smbios type=8,connector_type=8,port_type=9,"
+                "external_reference=USB2", &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_q35_smbios_type8(void)
+{
+    test_smbios_type8_common(MACHINE_Q35,
+        ".q35_smbios_type8", true);
+}
+
+static void test_acpi_q35_smbios_type8_compat(void)
+{
+    test_smbios_type8_common("pc-q35-11.1",
+        ".q35_smbios_type8_compat", false);
+}
+
+static void test_acpi_pc_smbios_type8(void)
+{
+    test_smbios_type8_common(MACHINE_PC,
+        ".pc_smbios_type8", true);
+}
+
+static void test_acpi_pc_smbios_type8_compat(void)
+{
+    test_smbios_type8_common("pc-i440fx-11.1",
+        ".pc_smbios_type8_compat", false);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2760,6 +2820,10 @@ int main(int argc, char *argv[])
                            test_acpi_pc_smbios_options);
             qtest_add_func("acpi/piix4/smbios-blob",
                            test_acpi_pc_smbios_blob);
+            qtest_add_func("acpi/piix4/smbios-type8",
+                           test_acpi_pc_smbios_type8);
+            qtest_add_func("acpi/piix4/smbios-type8-compat",
+                           test_acpi_pc_smbios_type8_compat);
             qtest_add_func("acpi/piix4/smbios-legacy",
                            test_acpi_isapc_smbios_legacy);
         }
@@ -2828,6 +2892,10 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/q35/cxl", test_acpi_q35_cxl);
 #endif
             qtest_add_func("acpi/q35/slic", test_acpi_q35_slic);
+            qtest_add_func("acpi/q35/smbios-type8",
+                test_acpi_q35_smbios_type8);
+            qtest_add_func("acpi/q35/smbios-type8-compat",
+                test_acpi_q35_smbios_type8_compat);
         }
         if (qtest_has_machine("microvm")) {
             qtest_add_func("acpi/microvm", test_acpi_microvm_tcg);
-- 
2.39.5 (Apple Git-154)


