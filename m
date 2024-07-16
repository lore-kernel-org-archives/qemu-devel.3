Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EC6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjPV-00076F-O9; Tue, 16 Jul 2024 10:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjPI-0005ya-Dl
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:57 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjPE-00034h-MS
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:55 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c967e21888so4182513a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721141030; x=1721745830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4tYSD3kmwvsTXZv9JDOMjH919bSCwsQC+O4tYKQ71A=;
 b=lFe517fuNbxBeZr9q/RQNXj0ve0ADjC4RPgVxtaDO6qJvRWwEXrJwfLs1HHOgGEj1i
 kYfjrFiv/tUPW9itITbrHSSk/GZP/1Q0OXQghwHnWYwMGEa9aDkT4emTt3NDLX8C7NBE
 kcKCvux5fhpnWYHXDctii/XLgQmnc2QOE6K2GdVVi5x8Dj3k5z7y9XbhoMN5zI5j0ibu
 K7G9Vs7UuecBdS7XhNE0xfdvcJ88R3IVkN+GXO6oV33INQnBWD03ju4PbvTTkZf+FIpI
 TDhjVAJpny3woFQlWLAbJMx0NA6fEfO9QamzRXMa/QB/Vc7uW8sZger3FumYvwLQR+2y
 RLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141030; x=1721745830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4tYSD3kmwvsTXZv9JDOMjH919bSCwsQC+O4tYKQ71A=;
 b=X1MvxAFl4gFUW4yi7RAeovwl+4ic8H9WWU9HhdSj2ORLQSNJbrvRoDDc38V1I0tiyq
 //4wBJ6Pqf/msCvzLd6RfBmupHoVxLS95yUtvPkxI0fs41Z6X4ZuJkKH6Xe7dszy0Yf8
 9AW2faD9kCY1KEWpLlacYmUI2fWUM+c4qEHGb7t4/LgS/sr7VhZYhSoiTM0vjCvLT+W9
 xSOk2mjqk8Mi4/Heq2Xs7rmYkynNa6qFv935owfVVUKxIsYhY9FlwZjz+pIMbz+YdcK2
 7fdlPTV9DuHZ+XF/XOM2CEi531FSiQO+Oe0kcWBhgKDpLNJuRifBc8m+V1u+Me0yzMt0
 9A9w==
X-Gm-Message-State: AOJu0Yz86bql1ZbY6X0smdEsJS7N4LMcdcC8or5ki4cXJKrawznnUkYW
 +KVdCTGKbxCcJ8dt2LvGBrudyZ6xLVfKJ8NRZ9KRAV5li84qtqqAr90D91RVMmjO8XfELTpq1Kb
 Kkwo=
X-Google-Smtp-Source: AGHT+IE3HsjsSGmlFxWpXWXciOT0T99znxXY1Kopt/4Ald6uNuvyR6MQ9l/+qM7uPdlFYFydUvo06w==
X-Received: by 2002:a17:90a:df02:b0:2c3:40b7:1f6d with SMTP id
 98e67ed59e1d1-2cb37356ed6mr1904166a91.0.1721141030389; 
 Tue, 16 Jul 2024 07:43:50 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caf480d61bsm6084782a91.18.2024.07.16.07.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:43:49 -0700 (PDT)
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
Subject: [PATCH v4 8/9] tests/qtest/bios-tables-test.c: Enable basic testing
 for RISC-V
Date: Tue, 16 Jul 2024 20:13:05 +0530
Message-ID: <20240716144306.2432257-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
References: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


