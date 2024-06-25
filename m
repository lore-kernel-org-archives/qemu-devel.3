Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EAEC30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7oO-0002zD-68; Tue, 25 Jun 2024 11:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7oM-0002xs-Nz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:10:22 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7oK-0006pu-7U
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:10:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7024d571d8eso4418567b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328218; x=1719933018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekscQEnP3gpmZV2Wq3Q1zFJVqJpw78Y8pmFq27S2T54=;
 b=awpOqezgpP9C9R3PB+cs8eaDvoyds3/lgeiybcTDwX5G0p5djX7pz6msw0TdvbAbzz
 8qpJWTvAlwIE5jPZxAKovHrt40SyCh1y05Hl6tHf/fReufjXiUI9smSruOJbMQJFnwlv
 q6tXwk5gAB5E2jeiOrx1ZdYyZ2JFgNjIqfWaBwGyd/wUnw0rI74EiOuXNzMyFB8pnePG
 V5hWzuHEplpyqVcOb81cH3Ka0yYBjeHWW4dV5VeeIc5bQQ9TMtwLOsS+PDVMMm/nePs0
 c7p89Z4ZAzludJljhLeQKLdwvh2CUemO0twHL65qOmMRJsnyf+OtWpo+BE0HZC3lLC5f
 ObrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328218; x=1719933018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekscQEnP3gpmZV2Wq3Q1zFJVqJpw78Y8pmFq27S2T54=;
 b=Z0rRE5CzADA4tyr4GqimRMjzscvwC6Cg9mwyh2WOhcWh3rzqkNQJEVmMFPhNo/xGgJ
 28A7faPO+JH9+3VaxZqA4xe3RfDWURLODy6wol5KVWCpJbiA7jZJjMGBrb5P93RbCSSP
 c7kMfqpr30tZ5IWAcwcT1uFfHTI+bP5rCJcwMTa1y4n2kgAn46tsKBXJ8bnG6AFDBlhP
 xwCoI6KPFupdVj7qGxTnpgRnNYWG+2ctHz2WFoEq4A9cZvywsTW1mskw6KXugxQK09E/
 6+q46mVUEzvk+Nk5ZYvD1t+/9z9isvvlHX6RRFyIXzy/5Hkn3G7PmChKW4HTyswFeDxP
 Qzww==
X-Gm-Message-State: AOJu0Ywvmzpdm9zp+0hWsNbpk+Lqqk8aX/xFox0GyYabsuIIaYv9dN4o
 27lPc7x0bx6ElQC4P3feX+odZy/uZWSER58PtbQtA6tYTd7xfyTtvxUgflUzgt7r3wpQaKx0YR8
 4
X-Google-Smtp-Source: AGHT+IHFshzYimtqyEKXsBMujDimtP/DnCKXkUXxy6IPeoiAjv20AprA+Az9e8Nw4cuokVIe6bcO0Q==
X-Received: by 2002:a05:6a00:2d9b:b0:6ed:cd4c:cc1a with SMTP id
 d2e1a72fcca58-706745be4bamr9530589b3a.8.1719328218235; 
 Tue, 25 Jun 2024 08:10:18 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70681722219sm4142636b3a.73.2024.06.25.08.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:10:17 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 15/16] tests/qtest/bios-tables-test.c: Enable basic testing
 for RISC-V
Date: Tue, 25 Jun 2024 20:38:38 +0530
Message-Id: <20240625150839.1358279-16-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42b.google.com
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
2.40.1


