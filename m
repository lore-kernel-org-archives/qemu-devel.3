Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809C1CD5BC0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQlnQ-0007i9-FU; Sat, 23 May 2026 08:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wQdIP-0000bQ-MW
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:45:05 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wQdIM-0002rh-FD
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:45:05 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5a8721851e2so9191492e87.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 20:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779507899; x=1780112699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkszgkRrL+lmmUAapTwwBv/OpmRR46GIrD5NRqmSiUY=;
 b=MAsvzaSH7sUOchzuMMCK5NIB6QJcIsmuB87m3a2cMoUdPDaJI3Rg7vzGCh+aAV1ifD
 gqymiGmnilCJIAlWCpmCGJY7xjY3QCf/Tb98e1nTLUD8ZQ3HlB54xTTzDv3maG1iTZeg
 u/TtzR9rjRN7JKctvu52H/Eqbr2p+o9Fz5cnlqy12eQ3F58AD2lv1iNEJSpY+VXed8E/
 5ytu7DrP/5KCV0nbYP+AEaY8AmhMjsJ2SmM3cphuS9ilTZIuax4ijXj8m/Yz+XC+T9cF
 3P6LX2PscAWHYJclYfEVl6Y016BmnBVLoT2tvcBIof381zMe1KwGPOY+PSW+z5uMrC71
 Ewdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779507899; x=1780112699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YkszgkRrL+lmmUAapTwwBv/OpmRR46GIrD5NRqmSiUY=;
 b=R8r2fFcpAOKz4YVQ1CW+EMUkL860FScfvGzpND7XC59JFQwnX/WcZB148v/lwUwX5f
 gWZ9CA/JqdU1i+QI6PFOLSDJr7saodnAUZR9ZX8xzaRZBDVSif6lbLUdmpF8oJhZO1Ks
 Ewm6MPjEEc8PRDWWHrkcIxAduGCN0hO/en1xBvKfllWWNSIbH0n8UYngH5sz/bKDyp8X
 6YFs0eUntDys0IVKoMtrbGcAtyHGuCHLX/6BXIvf7hez1tA/L1/5BytOPMLGWX5d6lUK
 GYA1cBAlRPKJe11WTRs8+E0hyRoIiZYKPkz1awgfpRlLrVXqTieXm4pCA+MJ2T6uuGby
 A+SQ==
X-Gm-Message-State: AOJu0Yzuq7rWUZZwB0LaOIA2OwBXWrPOL6cLgeNO2TG7H5lpi4Pfm5E1
 vPRC0gg/8qMlv+NjSsdVcj+LrH5ha/Cq33Bb4+uUIIpKkUKmChBPNLRDyZpl+Z/hNuo=
X-Gm-Gg: Acq92OGrLv9dZLMYMQnRv2ieRxz1Ojnbqon3NIzEcWCvcBYh92T27zIiwMCugFkETdm
 DUx3wAk3pbXGPJijrqxIAJ9uOSk9n1vEERaoVi2lsVlsdsoZm2bStEPrpWmmB5NI/ZBDYId7TKt
 IGzeHCyYuCTCtrT1aWqY1POEduiGCEKLfgMvrSOz4IlVMrLidRzy8MIXaM27qzmsVZ/UYepCVgB
 zCU1SQnY6Qc4kvf/nDApj02TQ/DMfZ14fLe1GiewRwVHDq7/0haESzflJMSBYk3ehss5zlCfjWZ
 oQI1SuqiAt254S9X/4OMjBpNn1ZL+Jv6c762fW8W/G7YMNcinRRJxPTtnmAD7uVAvKPyl2yZp+w
 DxydwiiY2DfJ37t9CtxDgIvQM5tHS+VGW75o4N/aXb0F6lDTnbkIuTBc9mXlyXVeSrjpVBrF/Bn
 EHjGkUqDBezCBP+CfyppXeSaP4NB2oRQAVdNvrpxXa
X-Received: by 2002:ac2:4c50:0:b0:5a8:a754:f9d6 with SMTP id
 2adb3069b0e04-5aa3237db6dmr2006569e87.29.1779507899483; 
 Fri, 22 May 2026 20:44:59 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:c2d::1:2b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb36f6sm848685e87.4.2026.05.22.20.44.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 20:44:57 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH 3/3] tests/qtest: Add SMBIOS Type 8 handle base tests
Date: Sat, 23 May 2026 06:41:58 +0300
Message-Id: <20260523034158.57487-4-xpahos@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260523034158.57487-1-xpahos@gmail.com>
References: <20260523034158.57487-1-xpahos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 23 May 2026 08:49:35 -0400
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


