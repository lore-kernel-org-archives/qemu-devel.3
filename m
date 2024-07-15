Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380CAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPFH-00061Z-Bv; Mon, 15 Jul 2024 13:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPFF-0005rl-9B
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:12:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPFD-0007Tq-Mg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:12:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70af5fbf0d5so2798191b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721063527; x=1721668327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4tYSD3kmwvsTXZv9JDOMjH919bSCwsQC+O4tYKQ71A=;
 b=H6K2KSfdY8kkbPcDoDOYuNpMPMykCIVis4+rYSKMo5idwVCiY4bMbkhkiDd5VWRdEz
 zxJ3ize1DKhw845wb7u1vBJ+/jGL1HHBys9/dBzTzy8aRn/oh15ZVHhLgD2udik3EiUN
 w61sgElhijQE/y4L6gRQOLrYFsfzX902m4O/KJ8MhBnkm8bVkood5/iEU7/UBp+chpjw
 sLgIM12L9rlA4RVzCPhViczayAoj9w1lkSuctpw1USUcWth0Fizf1kgiDM386GJb3yfn
 Ksc8F2rM01gEkzBC4m9XvcOarsKhyrrbeFz0j/qx0Aa9xc/VPcZM6DlaqCSjCv3vjqz0
 W9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721063527; x=1721668327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4tYSD3kmwvsTXZv9JDOMjH919bSCwsQC+O4tYKQ71A=;
 b=dWk+G05+8j+MAx6Jy5KdK3tZXEvbObL3Z7hAVWqUfgpPZeGv1kGYnq5BdHQStzn0OZ
 FgJSmn+ig7J5rHWkBhVIvzd5UTPJ4pScZNJwoSGRgkKmvuQfNVhlfiq7hVBX8J6AUA2s
 ihm+5dYvQRBAwWQffMoXFzW3JtUDZhIMoMsnExZaH3+WhWxhGV5Yc3IqM5yzCgVYfAHJ
 5QkU6lzEYoJTUsBID0lUsoC7eHSBjgq3LWO3a4LMFETyLYQkSEJ4JXHypkHRV0vdW3tB
 wLcsAF+th8m4zhaozaTt4CzkRs39aTw/tZ9Mkf4SW/FR1VjMujHuu4RHdUJbmmhS428s
 WHnw==
X-Gm-Message-State: AOJu0YwJWnLPJucRUvUkWcwkzDV2IivxyzTs4lt/rqpcsHVd6IvvsBMn
 WE8+UEGho1bZiKcX+0fo6fLY5+6F6/wt14FPcij3Z55tqQ/PKqp1IWZgo4GQtSWb8y+0HDWg9pU
 Wx30=
X-Google-Smtp-Source: AGHT+IGXFGdiF8idtIVw+VFQFzaRHGhimX6PajwqwGLA9AFhXicg71ra4v4EVC3mjZkj6dPCRT5ldA==
X-Received: by 2002:a05:6a00:860d:b0:705:9669:af1f with SMTP id
 d2e1a72fcca58-70b6c929256mr14359580b3a.10.1721063527329; 
 Mon, 15 Jul 2024 10:12:07 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca85ccsm4752618b3a.178.2024.07.15.10.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:12:06 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 8/9] tests/qtest/bios-tables-test.c: Enable basic testing
 for RISC-V
Date: Mon, 15 Jul 2024 22:41:28 +0530
Message-ID: <20240715171129.1168896-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add basic ACPI table test case for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 498e0e35d9..36e5c0adde 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1963,6 +1963,28 @@ static void test_acpi_microvm_acpi_erst(void)
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
@@ -2441,6 +2463,10 @@ int main(int argc, char *argv[])
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
2.43.0


