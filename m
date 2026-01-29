Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7535BD358D1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 07:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlMPm-0002wQ-JZ; Thu, 29 Jan 2026 02:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vlMPi-0002p0-Af; Thu, 29 Jan 2026 02:26:02 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vlMPf-0008T0-G2; Thu, 29 Jan 2026 02:26:02 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60T7Pbfv030033
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 29 Jan 2026 16:25:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Orqqg8RnNOibIBB0Uoq6tC54t21Cg+e6HEMJm6fhFco=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1769671551; v=1;
 b=Rc9gG0KY3fVZAcxMGNpLzq+wUW9W3FlVWFpC3gmsWtWb2RdioAsbcQ0kWBToCn1N
 cghLlsgSd9cEvve4qU9FoPmkukDw2xCWPQnxu3eAkN0Ai56fp9P2/V4yJg/IvmJi
 nn8O1Y2+X6uPBBk6f5zgKbfgkGf/ASV20OMeVk5Eh3ckqNx2INYtxQxySOaA2ddg
 jmkxC6/IrATzQHrQRmfrT8mxyhrXv47MSnMuNawrdZ9fSpIbwPKV4xbmslZqvk/x
 iimmjxcfMiUUqJZod/Pu8a3jdCHOSk88H+cK1ZlTkTT36d75oDCJO9BSFXF8ON/H
 6axX2yOWEWxx6gaZ51yEdA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 29 Jan 2026 16:25:36 +0900
Subject: [PATCH v5 1/4] test/acpi: aarch64/virt: Test version 10.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-virt-v5-1-421c0abaaf26@rsg.ci.i.u-tokyo.ac.jp>
References: <20260129-virt-v5-0-421c0abaaf26@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260129-virt-v5-0-421c0abaaf26@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
---
 tests/qtest/bios-tables-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 6b892ef23e1a..3c032173dbf4 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2213,6 +2213,28 @@ static void test_acpi_aarch64_virt_tcg(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_10_2(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .machine_param = "-10.2",
+        .arch = "aarch64",
+        .variant = ".10.2",
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
@@ -2827,6 +2849,8 @@ int main(int argc, char *argv[])
     } else if (strcmp(arch, "aarch64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
+            qtest_add_func("acpi/virt/10.2",
+                           test_acpi_aarch64_virt_tcg_10_2);
             qtest_add_func("acpi/virt/acpihmatvirt",
                            test_acpi_aarch64_virt_tcg_acpi_hmat);
             qtest_add_func("acpi/virt/topology",

-- 
2.52.0


