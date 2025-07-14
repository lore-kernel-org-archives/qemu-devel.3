Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFB6C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGd-0003k4-Dc; Mon, 14 Jul 2025 19:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSG9-00038w-CL
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSG6-0005Pc-H1
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J0gwwssvFtLIpcn/0bSSmR4Ew9FktX7NduuxGFwTfeA=;
 b=XFB+87dlQiNV3Jp6cqFOk70YcvcjYq2pwAhNlqs/sAweKERX+KJAH360k6cz3CaHudb+NQ
 y49TGxqI1P35wVvwuaMDW1nO7ARNpnO4O/1nGd7bhoNedYVyH6/x1BcW7PVJxXrtLGklj3
 i1e1LAOO9kXDqrM8E8tk5V7B0pKkEzw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-FOKJF5yQNhOT1gr33OwcOA-1; Mon, 14 Jul 2025 19:06:48 -0400
X-MC-Unique: FOKJF5yQNhOT1gr33OwcOA-1
X-Mimecast-MFC-AGG-ID: FOKJF5yQNhOT1gr33OwcOA_1752534407
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so25166095e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534407; x=1753139207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0gwwssvFtLIpcn/0bSSmR4Ew9FktX7NduuxGFwTfeA=;
 b=UIHgvkNJZzQ/eI8zlVcdAY9ECsA1X+FbaQMxoEnDyTYedaxsWTbmPAQXm4aj6EOxI/
 j+z2cRq+5XlKrcOccfWJm+xW/CCifrFk12ADjCn+w9MREaFxZmAMRGcsVnuhGCwfSTmI
 bGq1JJNKKsS+xLiwad4xHOaXccZIwWZe09Tstxe5mAhBus/RHBUwNbJen956SvZf4d9B
 8wcAiglC0LgO66afj4wpcyt6l2W0iXe0A2PmHbX0V9sBL5fKvGR5buC1RfI361XbSQcN
 gqSBBb77HJdSSKDN+CFpj6R4WyIiZOQCXxhYCivaRqOgiKoqd/ToIhe0tkag2ur/MI8i
 7rsA==
X-Gm-Message-State: AOJu0Yxafj6HLly/lzdy76YoerjYleaoHFXnnb0+0Ton8wWvfTgyga4d
 4Y+s5v6pMZWyJu5OV0Lc5sr0D880dvsf0NGwfx8oJoE00Cd1aQgk3zUZTJKDAupBPL6Adiz2nfH
 OWSsdYFMXXuA5Ps3rXFWlJA+xdfcnNZrAAYEGj059RPEl11aetvVs089P2Ne7VByjQg6qv1Az6U
 ASpN59lKUtI0rJAoZvT93NPHy0lfTL7Nzdwg==
X-Gm-Gg: ASbGncvEEUmq8MdsnzVtrUxYS0cxouR9mZDQLWpcZGIuOOuwC8cbIwQ1IOb2HyAcc+p
 0O5niMsw9Kbj5mWQ6gAMCftdQ2xS4NiVuh+23v06zI0xsU60/aX1ESR+vB0oueq8sVF3XQxUCFM
 SJxTdeXxlSbBpXx/zQjshORXYNjUbYJreBftUxWGG9DEbGedjJzEOXGA1Y491aWmRES9TasUCg2
 2LKIdTEGCCQELQKLdTjq0NVVEB9kQCLmO+4bc2t0jwACSZJXjnn1zK7GIDuoX5sw+xo/nA9I7SJ
 ACMUNFkd0PzRkoIz6ByTxehMpKTVJfG4
X-Received: by 2002:a05:600c:a308:b0:455:fab4:4b80 with SMTP id
 5b1f17b1804b1-455fab44c03mr80226375e9.19.1752534406792; 
 Mon, 14 Jul 2025 16:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUaG+DA4FSjO97dsvyc6n+5OVKY3hgCy/hn91DWQayqUi3eK8+2ai/AeAiiGYyjM3bcAfL9Q==
X-Received: by 2002:a05:600c:a308:b0:455:fab4:4b80 with SMTP id
 5b1f17b1804b1-455fab44c03mr80226135e9.19.1752534406203; 
 Mon, 14 Jul 2025 16:06:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1de0sm13395802f8f.24.2025.07.14.16.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:45 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/97] tests/qtest/bios-tables-test: Add basic testing for
 LoongArch
Message-ID: <73e2cba058c74c9a0d5b640711a1ff2428551952.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Message-Id: <20250612090321.3416594-3-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 79 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  1 +
 2 files changed, 80 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 4dbc07ec5e..f41e638014 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2439,6 +2439,74 @@ static void test_acpi_aarch64_virt_oem_fields(void)
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
+    test_acpi_one("-cpu la464 -smp sockets=1,cores=2,threads=2", &data);
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
@@ -2614,6 +2682,17 @@ int main(int argc, char *argv[])
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
index 5ad969f616..669d07c06b 100644
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


