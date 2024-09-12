Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B7FEE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPJ-00009X-Uj; Thu, 12 Sep 2024 01:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPF-0008O6-7K
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPD-0002yT-Fv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7191ee537cbso411545b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119009; x=1726723809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3uTPve2mzx49hu7WEVCseBvT4eXpfBEBSsLLj942CY=;
 b=N0lHiWRD4cS2I2MqNFbN/tORLZR2ert36LGNcgp0xKA8yCTQ+nV/rRtw8cwBqV8B0k
 G6CXXrazWxdte+Lx2h2NxcbW8+1UZOEbaH5PRIFEVDPHMRTQVnQYvfUR/Z+HtSw7tur3
 A9jwi1sCZMs3HIVzvaijyC38H4EyOMumDFJAb6NoxhySZJ1Fl8oCwRMIAn0vnb04qdsq
 dr1Yzb/xdavsuFeNLpfy8aFlYQrjV0YjF7HljMI3JrtmxjGokEnGQAs/zg7oXxcGFApE
 LSqfZ3A8ruFDOGF1nBTtloVzuL5LV8GXl1zGujp4ZlQZtrLwrfNjcvTOhtYuqoTKALyO
 R44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119009; x=1726723809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3uTPve2mzx49hu7WEVCseBvT4eXpfBEBSsLLj942CY=;
 b=N4tPnmJPilJxAU6PMAHz9Y3Hm5PrYJ06YH2sbPVjzxtwxN31i1gOZklhDnLCvwpexP
 YRBN1NGXuwkuuM+jUQgjgFQztsctbyfjje7N1qRoVxLVu3RbC1n5QA7ICZl2A9ykqQ/X
 YQSxuwtzCB398R3GNQkoWo6+EcVA7PUzKaZiMYZEzRS8I2WNpYcVbHaOG70AT04my//u
 8K/d02jaDrGDNYcL6RxVOU2e+R+EY9T3qOPFvKcumLBVn4u/u+RooiDoiZO/uL8ijmDH
 2om79SPkw/fMDnM34vR2fZI3XXFIdXod8WI1BrJATZnLfNjhqw4Wq1n1CG6eeIBgmDYX
 XT7w==
X-Gm-Message-State: AOJu0YxoZOIYHi3KAtLqJ/+uTtG8+jpyrelMKJ16cQMRLtfZtg+nJuzV
 D903lV1wMl9XANdhG6EfeXi9Tn5qdxTFI1q3MgXZdvFpv11twfS5Uh1hgg==
X-Google-Smtp-Source: AGHT+IFSEXK0TaAqemG7p92dP4KUTpd36cQy0n8IznMbjBuO6nM2e02WWrWyFMgKWgPdboH8rbropA==
X-Received: by 2002:a05:6a00:812:b0:70d:1b48:e362 with SMTP id
 d2e1a72fcca58-719262065e5mr2379405b3a.26.1726119009550; 
 Wed, 11 Sep 2024 22:30:09 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:09 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/47] tests/qtest/bios-tables-test.c: Enable numamem testing
 for RISC-V
Date: Thu, 12 Sep 2024 15:29:08 +1000
Message-ID: <20240912052953.2552501-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Haibo Xu <haibo1.xu@intel.com>

Add ACPI SRAT table test case for RISC-V when NUMA was enabled.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <a6f7e1a4b20ff7eb199e94ca0c8aa2e6794ce5b2.1723172696.git.haibo1.xu@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 36e5c0adde..e79f3a03df 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1706,6 +1706,32 @@ static void test_acpi_microvm_ioapic2_tcg(void)
     free_test_data(&data);
 }
 
+static void test_acpi_riscv64_virt_tcg_numamem(void)
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
+    data.variant = ".numamem";
+    /*
+     * RHCT will have ISA string encoded. To reduce the effort
+     * of updating expected AML file for any new default ISA extension,
+     * use the profile rva22s64.
+     */
+    test_acpi_one(" -cpu rva22s64"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node,memdev=ram0",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_aarch64_virt_tcg_numamem(void)
 {
     test_data data = {
@@ -2466,6 +2492,8 @@ int main(int argc, char *argv[])
     } else if (strcmp(arch, "riscv64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
+            qtest_add_func("acpi/virt/numamem",
+                           test_acpi_riscv64_virt_tcg_numamem);
         }
     }
     ret = g_test_run();
-- 
2.46.0


