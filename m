Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C63FC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63AJ-0003Yd-2M; Mon, 14 Sep 2026 05:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AH-0003WH-Vi; Mon, 14 Sep 2026 05:39:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63AE-0001ON-W8; Mon, 14 Sep 2026 05:39:53 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9ddbu024283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:39:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=KS4O+cwZhBS67KvYku6mjcEoxm1KHxiXlGoWqDizidM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378783; v=1;
 b=OyufENjwkNXABoZR2dZwhO67HDerOaInvn9lM0W4g+3EWY+V4jj1rE5D6YvnMQKW
 EEBAi752RskycHYdbHoRI3t5tt8U/fS6gWBc37YwEfxO6rlP4Qx4KQHq2TXlzn6R
 xvvZXtTxVKc3Bpsf7geG0BYWQDVeeMv5cehcE9iTKjkYo+9tnTZaLUMEdOCMRZP+
 r4mpFKJFMAh+s1EhiPs7DrXLMRa25YcRb1wtKMTeGj9ohXlVVSF7TgDUh4GYqA1K
 XJnYcUMRG298vhhhKxMWsbsL/arbhW67da5fkw/eNjRwL3nG6XNjWdEJBmEKQW8L
 QAeMsPc5hI4SgOF0PNPj9A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:39:22 +0900
Subject: [PATCH v8 1/5] test/acpi: aarch64/virt: Test version 11.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-virt-v8-1-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
References: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260914-virt-v8-0-7418578fef08@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=hCiYnNWSNugTV2B3DQM54anvMCrR57lEsm6X4UcasXM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9byAzfqNp+2XsZecnz+blmPxaHuDPtr5vqL7dGc7s2xX
 nrqxvnzO0pZGMS4GGTFFFlSinZza0TXfipMiG+BmcPKBDKEgYtTACYSmMXIsEddi9P8+h4Bgfpl
 v4OamZLV9OSm71OXNzmioZz+8vqtYoZ/pvdcBa7OFWyJVOvari1or/jxw7obx4NYtYPMTt5u2F7
 PBAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

A future commit changes the memory map for the latest version of the
machine. Test that the memory map of the previous version is preserved.

Suggested-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f6dfa4131b89..7fbcde856448 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2234,6 +2234,28 @@ static void test_acpi_aarch64_virt_tcg(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_11_1(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .machine_param = "-11.1",
+        .arch = "aarch64",
+        .variant = ".11.1",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    data.smbios_cpu_max_speed = 2900;
+    data.smbios_cpu_curr_speed = 2700;
+    test_acpi_one("-cpu cortex-a57 -machine ras=on "
+                  "-smbios type=4,max-speed=2900,current-speed=2700", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_aarch64_virt_tcg_topology(void)
 {
     test_data data = {
@@ -2930,6 +2952,8 @@ int main(int argc, char *argv[])
     } else if (strcmp(arch, "aarch64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
+            qtest_add_func("acpi/virt/11.1",
+                           test_acpi_aarch64_virt_tcg_11_1);
             qtest_add_func("acpi/virt/acpihmatvirt",
                            test_acpi_aarch64_virt_tcg_acpi_hmat);
             qtest_add_func("acpi/virt/topology",

-- 
2.55.0


