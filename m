Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACB8C5B543
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZA-0002L4-TK; Sun, 01 Jun 2025 11:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZ9-0002Jr-K9
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZ7-0004ei-Vx
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZhAj20XZvrF3oiCRDGg3TLM+ez1BRti6haDYRLcshk0=;
 b=JCAX2PaOF/I20U0anATpndciHxvseC5Ay18hkuiQQz1WG0py0UzF0hrwks13ECjn0U3tuP
 B+yAnaWSG0Iu7+o1rEZoHhilZdyTAIqLvD9zWzuF1tFiM1DnjDAMDlIA0PzX2N8HmtISvg
 NSX6JpVpwWWlm9yqh9WtmERCmUrwZs4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-BwOT61UlPemRkWDDe9Qn4w-1; Sun, 01 Jun 2025 11:25:36 -0400
X-MC-Unique: BwOT61UlPemRkWDDe9Qn4w-1
X-Mimecast-MFC-AGG-ID: BwOT61UlPemRkWDDe9Qn4w_1748791535
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so19858125e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791535; x=1749396335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhAj20XZvrF3oiCRDGg3TLM+ez1BRti6haDYRLcshk0=;
 b=jS+akDjLw8GVPPvJnByGeOo7RpD+aLvXyss1DsaShGfwwgamoJ5H/HX9jOtppX6ZZr
 ZzA+QNgj9azgfxjBAx4ZxIlV6lyZdNr6if2BTaLcUDv9hKjXvBDgP549oDMyekqpCqHT
 vzACLJvlLFqKwFQwdPGl6ngVPwYBYfvJ83dkYKlWBBbiBWvS0HRYy7skFGu2HbYGNasX
 C/iKwqVdE27wyrW7ZXQ5HRxSyyRs6D9QdEOurb7BJrWDdTZbjhZl4ZCh6cN0/ULXFTwA
 IYL29E/Rr2AR0gzKfr1Lfe6pMAVlpWrqJVD08UBBUS8vZgAnFFRFsJcGn2WT700+i0lW
 SzqA==
X-Gm-Message-State: AOJu0Ywz+Ck5XbGlvcy2qO5ungt8/uCdJ5/hhIJSDqBn6bO1Qc+tZj+9
 BJxeshHbsS8i30tkFdT/0v4YXK4lKZTjo56tkyVtviRA37gPZd/tETqyjD1IMRWgM54FEUyt82N
 ES3u8MyopUJt4I5ZKsXt3xRzXK2QEHWQGxGsndoT3bpVowLE7MFTLNW8XXxS+mg7/hOE1MH0xCt
 FfENlg8mReESnYWxWe6jCYmGRh1QmKhh5TiA==
X-Gm-Gg: ASbGncv0XAhQYrO5juKSHEAiHCGgQxJ5JIwtPEo0rDW3nX0YxH+WdQQDHtJi1TgMXCz
 9vNdE/+xq+CxkGnWG4ouN6OHAzwAwrdiS3qnSCHA0Zge4xyL+DwNiSf9gk6gd2tvpVE6Kybca+B
 92nBYYIOZbPAO3R16cbTV18VcniQcQytXJLzKTsrUxPVtmgBVGsKA5T0D9zLFSk8knfv0AMx5lr
 FA2o4txTWUfFygBtlQwY5e7l/UH0ALbT/BJItLq9nSu83rHryIQtgEOJJrIdGLIdb/4GZEvIcnM
 eFOyeQ==
X-Received: by 2002:a05:600c:5494:b0:442:cab1:e092 with SMTP id
 5b1f17b1804b1-4511ecc2522mr38168935e9.11.1748791534864; 
 Sun, 01 Jun 2025 08:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe8Rtv2C5Xtb4hTznxvLVojM37voBHAmtZcvuYVqI6ZOXLRnIZlLC/LzEH2W4voF3PPoNnMA==
X-Received: by 2002:a05:600c:5494:b0:442:cab1:e092 with SMTP id
 5b1f17b1804b1-4511ecc2522mr38168625e9.11.1748791534418; 
 Sun, 01 Jun 2025 08:25:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450dc818f27sm74271845e9.18.2025.06.01.08.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:33 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 19/31] tests/qtest/bios-tables-test: Add basic testing for
 LoongArch
Message-ID: <16736bf01b79ef411dbab75289979e283153ea23.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bibo Mao <maobibo@loongson.cn>

Add basic ACPI table test case for LoongArch, including cpu topology,
numa memory, memory hotplug and oem-id test cases.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250520130158.767083-6-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 79 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  1 +
 2 files changed, 80 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0b2bdf9d0d..d057cd90db 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2420,6 +2420,74 @@ static void test_acpi_aarch64_virt_oem_fields(void)
     g_free(args);
 }
 
+#define LOONGARCH64_INIT_TEST_DATA(data)                          \
+    test_data data = {                                            \
+        .machine = "virt",                                        \
+        .arch    = "loongarch64",                                 \
+        .tcg_only = true,                                         \
+        .uefi_fl1 = "pc-bios/edk2-loongarch64-code.fd",           \
+        .uefi_fl2 = "pc-bios/edk2-loongarch64-vars.fd",           \
+        .cd = "tests/data/uefi-boot-images/"                      \
+              "bios-tables-test.loongarch64.iso.qcow2",           \
+        .ram_start = 0,                                           \
+        .scan_len = 128ULL * MiB,                                 \
+    }
+
+static void test_acpi_loongarch64_virt(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+
+    test_acpi_one("-cpu la464 ", &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_loongarch64_virt_topology(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+
+    data.variant = ".topology";
+    test_acpi_one("-cpu la464 -smp sockets=1,cores=4,threads=2", &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_loongarch64_virt_numamem(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+
+    data.variant = ".numamem";
+    test_acpi_one(" -cpu la464 -m 128"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_loongarch64_virt_memhp(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+
+    data.variant = ".memhp";
+    test_acpi_one(" -cpu la464 -m 128,slots=2,maxmem=256M"
+                  " -object memory-backend-ram,id=ram0,size=128M",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_loongarch64_virt_oem_fields(void)
+{
+    LOONGARCH64_INIT_TEST_DATA(data);
+    char *args;
+
+    args = test_acpi_create_args(&data, "-cpu la464 "OEM_TEST_ARGS);
+    data.qts = qtest_init(args);
+    test_acpi_load_tables(&data);
+    test_oem_fields(&data);
+    qtest_quit(data.qts);
+    free_test_data(&data);
+    g_free(args);
+}
 
 int main(int argc, char *argv[])
 {
@@ -2593,6 +2661,17 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_riscv64_virt_tcg_numamem);
         }
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        if (has_tcg) {
+            qtest_add_func("acpi/virt", test_acpi_loongarch64_virt);
+            qtest_add_func("acpi/virt/topology",
+                           test_acpi_loongarch64_virt_topology);
+            qtest_add_func("acpi/virt/numamem",
+                           test_acpi_loongarch64_virt_numamem);
+            qtest_add_func("acpi/virt/memhp", test_acpi_loongarch64_virt_memhp);
+            qtest_add_func("acpi/virt/oem-fields",
+                           test_acpi_loongarch64_virt_oem_fields);
+        }
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 43e5a86699..395ccc0d4c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -148,6 +148,7 @@ qtests_hppa = \
 
 qtests_loongarch64 = qtests_filter + \
   (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
+  (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   ['boot-serial-test',
    'cpu-plug-test']
 
-- 
MST


