Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA975C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXqJ-0000Kk-Fz; Mon, 24 Aug 2026 12:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wyXq9-0000HJ-1Q
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wyXq7-0001Fs-5T
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787590081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3O5lL7j5Gaw8uyE4y6+gQMzQfNHgk4ZvmN4OCSUHFsU=;
 b=HrsKLq1soeruQgn3569Cf61uasNnjbM9VwsDUK2tZflWHdvtopFbtYK99HpskdojE6rPTa
 2mZTeHw9KereyHLap7QSF4v5RnTaeaoWT4GeiYXIpWJv3QBxCX+JTFjjVGpNCBKzNIlDBt
 nIJscOXK8ZIJYHPRTNsuT65p7TEi0v0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-3qawbCCfMqOaEmYKdnhqpg-1; Mon,
 24 Aug 2026 12:47:59 -0400
X-MC-Unique: 3qawbCCfMqOaEmYKdnhqpg-1
X-Mimecast-MFC-AGG-ID: 3qawbCCfMqOaEmYKdnhqpg_1787590077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 756DD186097B; Mon, 24 Aug 2026 16:47:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FB8A30002EF; Mon, 24 Aug 2026 16:47:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8E665183189E; Mon, 24 Aug 2026 18:47:53 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/12] edk2: rename risc-v firmware builds
Date: Mon, 24 Aug 2026 18:47:38 +0200
Message-ID: <20260824164751.1700783-7-kraxel@redhat.com>
In-Reply-To: <20260824164751.1700783-1-kraxel@redhat.com>
References: <20260824164751.1700783-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

'riscv' => 'riscv64', for consistency with the other
architectures which all have '64' in the name.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/qtest/bios-tables-test.c                      |  12 ++++++------
 pc-bios/descriptors/60-edk2-riscv64.json            |   4 ++--
 ...2-riscv-code.fd.bz2 => edk2-riscv64-code.fd.bz2} | Bin
 ...2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} | Bin
 pc-bios/meson.build                                 |   4 ++--
 roms/edk2-build.config                              |   8 ++++----
 6 files changed, 14 insertions(+), 14 deletions(-)
 rename pc-bios/{edk2-riscv-code.fd.bz2 => edk2-riscv64-code.fd.bz2} (100%)
 rename pc-bios/{edk2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} (100%)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 9aadc1a1f6c3..8fc470daa086 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1782,8 +1782,8 @@ static void test_acpi_riscv64_virt_tcg_numamem(void)
         .machine = "virt",
         .arch = "riscv64",
         .tcg_only = true,
-        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .uefi_fl1 = "pc-bios/edk2-riscv64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
         .ram_start = 0x80000000ULL,
         .scan_len = 128ULL * MiB,
@@ -1883,8 +1883,8 @@ static void test_acpi_riscv64_virt_tcg_acpi_spcr(void)
         .machine = "virt",
         .arch = "riscv64",
         .tcg_only = true,
-        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .uefi_fl1 = "pc-bios/edk2-riscv64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
         .ram_start = 0x80000000ULL,
         .scan_len = 128ULL * 1024 * 1024,
@@ -2198,8 +2198,8 @@ static void test_acpi_riscv64_virt_tcg(void)
         .machine = "virt",
         .arch = "riscv64",
         .tcg_only = true,
-        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .uefi_fl1 = "pc-bios/edk2-riscv64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
         .ram_start = 0x80000000ULL,
         .scan_len = 128ULL * MiB,
diff --git a/pc-bios/descriptors/60-edk2-riscv64.json b/pc-bios/descriptors/60-edk2-riscv64.json
index 14811ca307f6..7f03083d5e0b 100644
--- a/pc-bios/descriptors/60-edk2-riscv64.json
+++ b/pc-bios/descriptors/60-edk2-riscv64.json
@@ -6,11 +6,11 @@
     "mapping": {
         "device": "flash",
         "executable": {
-            "filename": "@DATADIR@/edk2-riscv-code.fd",
+            "filename": "@DATADIR@/edk2-riscv64-code.fd",
             "format": "raw"
         },
         "nvram-template": {
-            "filename": "@DATADIR@/edk2-riscv-vars.fd",
+            "filename": "@DATADIR@/edk2-riscv64-vars.fd",
             "format": "raw"
         }
     },
diff --git a/pc-bios/edk2-riscv-code.fd.bz2 b/pc-bios/edk2-riscv64-code.fd.bz2
similarity index 100%
rename from pc-bios/edk2-riscv-code.fd.bz2
rename to pc-bios/edk2-riscv64-code.fd.bz2
diff --git a/pc-bios/edk2-riscv-vars.fd.bz2 b/pc-bios/edk2-riscv64-vars.fd.bz2
similarity index 100%
rename from pc-bios/edk2-riscv-vars.fd.bz2
rename to pc-bios/edk2-riscv64-vars.fd.bz2
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index f7412bf53e69..961d99fde4e6 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -3,8 +3,8 @@ if unpack_edk2_blobs
   fds = [
     'edk2-aarch64-code.fd',
     'edk2-aarch64-vars.fd',
-    'edk2-riscv-code.fd',
-    'edk2-riscv-vars.fd',
+    'edk2-riscv64-code.fd',
+    'edk2-riscv64-vars.fd',
     'edk2-x86_64-code.fd',
     'edk2-x86_64-secure-code.fd',
     'edk2-loongarch64-code.fd',
diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index fcf9da8c7681..96ebc3bcd9e7 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -89,10 +89,10 @@ conf = OvmfPkg/RiscVVirt/RiscVVirtQemu.dsc
 arch = RISCV64
 plat = RiscVVirtQemu
 dest = ../pc-bios
-cpy1 = FV/RISCV_VIRT_CODE.fd  edk2-riscv-code.fd
-cpy2 = FV/RISCV_VIRT_VARS.fd  edk2-riscv-vars.fd
-pad1 = edk2-riscv-code.fd     32m
-pad2 = edk2-riscv-vars.fd     32m
+cpy1 = FV/RISCV_VIRT_CODE.fd  edk2-riscv64-code.fd
+cpy2 = FV/RISCV_VIRT_VARS.fd  edk2-riscv64-vars.fd
+pad1 = edk2-riscv64-code.fd   32m
+pad2 = edk2-riscv64-vars.fd   32m
 
 ####################################################################################
 # LoongArch64
-- 
2.55.0


