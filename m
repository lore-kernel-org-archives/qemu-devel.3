Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3F9CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSFq3-0001V0-Ak; Wed, 27 May 2026 11:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSFq1-0001U6-2p; Wed, 27 May 2026 11:06:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSFpx-0003dh-Od; Wed, 27 May 2026 11:06:28 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64RF5nBi078744
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 May 2026 00:06:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=X0SPhmE0Xjpslj3iCmCvjK2ymSjQtmkUR5qYU1FCc1w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779894368; v=1;
 b=YwGeIZpx7WJOiEzhzCmp+WLQgkjMt4iAQVdtcm8rISphUijhdEEkJVMqzxXK6M2V
 niDvp2d8/XT7bLgsOQ/5EE3jOIKv4H2S6To61RAfMsYljYPZ+cmBQeB1MIz0qFI+
 0U1CbkL83jareBnwjTSvtxzaS4/JVoWbqcvcWvxbDJPTy2qApxELGEBPHnVM3hOe
 DUNhTT8y3n8TVuXg5Q5dFy/rX5jRWFUOQu0hgyF4FcaiV/gqAWRtui78++fFsPoU
 yJA00hW7wLQ6qQV/oZEybEhAuzB5IOhJfEgj1Q/A4ZmgtutApxfzKs4SkDbHwsRT
 qAN16AgV3XWKhnl0UDWE+A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 May 2026 00:05:41 +0900
Subject: [PATCH v7 1/5] test/acpi: aarch64/virt: Test version 11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-virt-v7-1-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp>
References: <20260528-virt-v7-0-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260528-virt-v7-0-42c4d18620b8@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=2100;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=SEb0vlNxL6dzhkzJ1YzRxn1j5mKStS1Z9+siY2A2vQM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5Y4R8ypzrsiZ5nu+1z6tk59jkDfesOlhnGSM+fItnaFf
 TKYraTSUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBGrk4wMkyr0/x/lT5aqCtz1
 QuC6U4vB5Uilu1Jr4lds7Zs7qfTZRkaGp+xMHPc470vHtc0uLp35RWHRtU8yx+5+Umo3n1r8Lli
 ECQA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 510751799e48..00e62699197a 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2214,6 +2214,28 @@ static void test_acpi_aarch64_virt_tcg(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_11_0(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .machine_param = "-11.0",
+        .arch = "aarch64",
+        .variant = ".11.0",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
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
@@ -2851,6 +2873,8 @@ int main(int argc, char *argv[])
     } else if (strcmp(arch, "aarch64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
+            qtest_add_func("acpi/virt/11.0",
+                           test_acpi_aarch64_virt_tcg_11_0);
             qtest_add_func("acpi/virt/acpihmatvirt",
                            test_acpi_aarch64_virt_tcg_acpi_hmat);
             qtest_add_func("acpi/virt/topology",

-- 
2.54.0


