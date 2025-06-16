Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19282C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9lZ-00027Y-Rp; Mon, 16 Jun 2025 09:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9lK-0001wR-Jo
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:38 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9lI-0005Tf-2y
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:34 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2360ff7ac1bso30884275ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080027; x=1750684827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pb22C6xJcHTC7zCwmUSNjwxICkvjIFLQmQAAl9DeMUI=;
 b=jMxscr73EAv6+Y2XmzUoIrtUCeFWT2FVzNRM+o0mX1pJx5T8+Eq/P5ceZlyGNdwVPg
 +w56eIxrq+G3MmT3g5ZSEHIio56jsP3KpIcFF7Fchzu9GwJXVQYrwEqS2jdiv2AFh77C
 pz9112r64vOEkvatgmkb3+pvImldF8KzsB2Dxn+A4AUV/1db7yUdv8lQnvP1yIVC//C6
 z6q0jA3pBeU8LUECspd/xYZzZUfoUAfHhsXoQI+ZmFpAAlT5LBt1LlvhNRXX6J0BEBCF
 W44iOfZyvnuLd34DK6PZVp7XOxeRRlns2l2b/E0aKR1FtILzlZComAsg8dqDZcYIUbvr
 3lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080027; x=1750684827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pb22C6xJcHTC7zCwmUSNjwxICkvjIFLQmQAAl9DeMUI=;
 b=ObIRtQrhp67AD69w7p5+Kb4BBEaGjVqNpkaixehN1+0R/neQmPjEjLQNhyQufEHWrx
 NDikmUTHMNilPTeor90BcZoSAs3SMBPdUBF9mOsy3D5NVGKLXZf9vDJJidqyBndALkL5
 toa3V5N79g4sgu8heqxvEf2zOwbmcKR27757SDBOAwJ1JtXKeK72tOrhxjF0y/U6Wsq/
 8XqZOrXS4LIE/Aa1hS4B6I4K8ieOBsoOM2auEi49pILUTRXOEnxQYLKxzz8ZnvrH25iF
 4/J3t7+hLoRSmQylyVgVUlUBeUXlRsw9pqZvfwzhr4152T3MrlzwoS/s7fvS064PulXw
 rJgA==
X-Gm-Message-State: AOJu0YzkL+91fMlVEowEFTBSSiPEBX6LrYOlpAkyg0wHvAL/JHpIaumh
 JbeUBKMlqmm3znbzRcfPhkmzdaMvzlDTqIt2KHTQtaAsoveWPRUMExIGVeJI1OBesmkzAmwOGiZ
 tpel4
X-Gm-Gg: ASbGncv0d3wLkrKC+KVQptvyv6slqe4cLnepjWRSBSabRD7J2gUTymN0ueyH8MhytRo
 8eP3Ut4udoe8Hcpy5Wantiukw7u06vNH/qs6PpyaBsNkPdOSy0z9jWNV4pbr1/xR8nBA0vuaiVa
 elRweQ06AcUVdT7fd7jpl5c9F5xDZpNwy4fcTfQayHkqnN5DTIP/ZSW55lIU7BUsJZ+kpk1DqFw
 WCoOfynyAZe3dbYJcIhD4XVwF2Wc4Ytilhn5qACCvv8tEKvk79YQzB4myn3hvVSzr6tQXfvXBjw
 +D+TfUGIhpziNGY6xAaNuQOrQE+5S9ltcrusiMSkkddIVVyvKLgN+y8gMN5KyiByEAw=
X-Google-Smtp-Source: AGHT+IFCStmfOmsnPdmEaxuUS6wfRTCeQyHwuBgp4aOVsXWxixMkPmB2dOR2f62POR4NWL5VIkKCfw==
X-Received: by 2002:a17:902:ec8b:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-2366b16e7d6mr133455025ad.48.1750080027034; 
 Mon, 16 Jun 2025 06:20:27 -0700 (PDT)
Received: from gromero0.. ([186.215.60.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365de781dfsm60848405ad.131.2025.06.16.06.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 06:20:26 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v4 5/8] qtest/bios-tables-test: Add test for when ITS is off
 on aarch64
Date: Mon, 16 Jun 2025 13:18:21 +0000
Message-Id: <20250616131824.425315-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616131824.425315-1-gustavo.romero@linaro.org>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Arm64 GIC ITS (Interrupt Translation Service) is an optional piece of
hardware introduced in GICv3 and, being optional, it can be disabled
in QEMU aarch64 VMs that support it using machine option "its=off",
like, for instance: "-M virt,its=off".

In ACPI, the ITS is advertised, if present, in the MADT (aka APIC)
table and the remappings from the Root Complex (RC) and from the SMMU
nodes to the ITS Group nodes are described in the IORT table.

This new test verifies that when the "its=off" option is passed to the
machine the ITS-related data is correctly pruned from the ACPI tables.

The new blobs for this test will be added in a following commit.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
 tests/qtest/bios-tables-test.c              | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a88198d5c2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0b2bdf9d0d..4201ec1131 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2146,6 +2146,25 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_its_off(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .variant =".its_off",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    test_acpi_one("-cpu cortex-a57 "
+                  "-M gic-version=3,iommu=smmuv3,its=off", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_viot(void)
 {
     test_data data = {
@@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
                            test_acpi_aarch64_virt_tcg_acpi_hmat);
             qtest_add_func("acpi/virt/topology",
                            test_acpi_aarch64_virt_tcg_topology);
+            qtest_add_func("acpi/virt/its_off",
+                           test_acpi_aarch64_virt_tcg_its_off);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
-- 
2.34.1


