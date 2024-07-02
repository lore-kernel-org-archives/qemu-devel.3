Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE103C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEP-000784-CV; Tue, 02 Jul 2024 10:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDr-0005Hm-4I
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDm-0000Re-Qh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYcGnVhFPwoZSWuivRppJKLTtobAaVwu1fbEznMs2YQ=;
 b=ivtKHSO7l4ijpDNTdAr5zA/fvOs17XesD7bjfqVIwkho3obtIcSRovLAXKRhYPrtBDuQoZ
 KiuiXOPKcul/h/iE5Zb5htWqEJymtNtaISxqw++sh22lQvz8MMtOhimCuPiDqnhKjdoF+O
 BjS0+XyT6hNVUkWW3LygRMIYzoWHpIA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-hQ8XnS69PUOeC1wYy9PGUg-1; Tue, 02 Jul 2024 10:10:58 -0400
X-MC-Unique: hQ8XnS69PUOeC1wYy9PGUg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42567dbbd20so31687345e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929457; x=1720534257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYcGnVhFPwoZSWuivRppJKLTtobAaVwu1fbEznMs2YQ=;
 b=F3yfuIvvfV5gXoO55mqXGp2diPeha9Ola8SnXkWyQQVL7htkQy5NMO24RZPZ/Azi0F
 fOIm3LaCqcNXG/ysCsCOJh08J4lCqXEr5KfC/IKvEAz8o1I1IF9Dk8NtrVjeNzsBbp+O
 pbBZ0OVMJLWsD96l7By9B+ZPde9vdBdHfvdIjeiU3libD07U8K/dO9PiF5/raLZwlUV9
 2u9gzCy+i+qx4ju+j192rsHyuOAKDfsFZzywxka3clcmD4TxPUWjAVeoFnHYGzFb+ynj
 A6TRd3fPNOnUIDjo+8UuueplZP5EF02i3bssQFjbmUiYpDW1zK17DiRGuYKuZTKPylJP
 4Ihw==
X-Gm-Message-State: AOJu0YxfJkJYSRUd/P/OaGw/ue4+yrN76UCa/S8D71ZIYEixcgqZr/0p
 vsy/+oasQ/BdsThMVwGLdYZCUbBFvdGYhA8M5AeZlIHSkzgs+paVM4Qxys5kyHlnlZNp3WKE3rF
 l9qdsMfhxTWg0TRSufUQu7bhDBwg0AU6qnmOg/LTvb0x7dqW3BNXqm735iSFqyqzTpcKBCyHuUU
 c/qCzIKrhgE4IuRYVUh9iJo2Fzo3FD9w==
X-Received: by 2002:a05:600c:4aa9:b0:425:656b:76ae with SMTP id
 5b1f17b1804b1-4257a00ce69mr58232815e9.23.1719929457206; 
 Tue, 02 Jul 2024 07:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqlsKd2f4fzcx/rAiCo2L0yUzu3ELum731IQMLwJfYQe/Isnab1sTKoMTn1v/QPAvDlgMBww==
X-Received: by 2002:a05:600c:4aa9:b0:425:656b:76ae with SMTP id
 5b1f17b1804b1-4257a00ce69mr58232565e9.23.1719929456693; 
 Tue, 02 Jul 2024 07:10:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9385sm13272258f8f.39.2024.07.02.07.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:56 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 76/91] tests/qtest/bios-tables-test.c: Enable basic testing
 for RISC-V
Message-ID: <45fa5b80a3bc3df238414aa738a7bd352bb6665f.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

Add basic ACPI table test case for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-16-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f4c4704bab..0f9c654e96 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1977,6 +1977,28 @@ static void test_acpi_microvm_acpi_erst(void)
 }
 #endif /* CONFIG_POSIX */
 
+static void test_acpi_riscv64_virt_tcg(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "riscv64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
+        .ram_start = 0x80000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    /*
+     * RHCT will have ISA string encoded. To reduce the effort
+     * of updating expected AML file for any new default ISA extension,
+     * use the profile rva22s64.
+     */
+    test_acpi_one("-cpu rva22s64 ", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
@@ -2455,6 +2477,10 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
         }
+    } else if (strcmp(arch, "riscv64") == 0) {
+        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
+            qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
+        }
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
MST


