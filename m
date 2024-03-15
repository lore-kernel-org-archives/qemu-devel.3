Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5660FC54E69
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Jq-00065V-1W; Fri, 15 Mar 2024 09:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7Jk-0005s8-KB
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:49 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7Jh-0007jJ-Kl
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:48 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-29c731ba369so1667909a91.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710508183; x=1711112983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sxhd0rb4V/HdCcNYSiwuf6DPCAi6g3IEdE6KnOG7L8=;
 b=WkMssXfpQ72/546c6pyY8+dYrdEaCQmvalRNFzut6jAw+LNz3bNan/gotAO3MPX7Nu
 GA64tUdLJeSuLtCzEfbg7Fz7FWvBgfRtiGiFTY9jHrGo38dxD759FsnBwUxca/CIoEVV
 UXH5udjMpKnkN6umtNiIwDldsISyHwZ96uAbwERajHP2372iSSUMwjoU7s/5w0tzY8N+
 K2AcTob0iMtgk6gb3NbcXrg9AbkV76qxVTzbOu/t16c5YMJdVFqkab9cNZlos+BXCCA4
 q4mLJg9L2q4Owvtg5C44ny82k7pRaLYG/T/sP4Pya9F2Rn7Mxpttr6iF4rl3yBdYTuFh
 z78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508183; x=1711112983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sxhd0rb4V/HdCcNYSiwuf6DPCAi6g3IEdE6KnOG7L8=;
 b=TnXREUlvEcBvTs/EqNYtImJcJgPTlnMjpmVy/dys715vhEdSeAwknAEFZtSJt3lMrk
 Cua+Wfqz18urMGSA4O5XOueyZ9o3ZdIaWHGCQthMe0CK0pUXYpDl/wifEtZDoP+FcN9i
 3wDIuyIBi5NoHaUD0kLaPsNnWJssA/4H+iNPw2WwT71krqDNIJUEDnBiNuA752M5/i+6
 49kPK9/vhyTXUdyWWvyQBTT33yUgw0CPSdTo67sWNC9Jy23gv2FkY58xmpP8MKjK43AT
 IWesC1eO973hyT6lZYYK482vBr2VEgK/SCpe/NddpVoLigG0I2Qwd6bUb1yv9BDCvHF3
 oriA==
X-Gm-Message-State: AOJu0YwZPTLNmIpGSs6m/1B4CevKsYgp11E8tG8AZ2EKS01cbUO0HQUg
 H4wJo7ebZ+PVBc86H+lAg5I5vp/KG7HNWAvXO24sOMGSmgy3ZnjFCtuDRxU6iBaRVAxdLufZLS6
 m
X-Google-Smtp-Source: AGHT+IHDcQxN1/MJNwNoSh49TDo40dWND/kk0IWkS9VF06tAR3byrXGl+IML3QcUiWglnJ3WuxuutA==
X-Received: by 2002:a17:90a:e016:b0:29c:403b:ea2e with SMTP id
 u22-20020a17090ae01600b0029c403bea2emr4309258pjy.49.1710508183338; 
 Fri, 15 Mar 2024 06:09:43 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.184.12])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a17090ad40300b0029c68206e2bsm2886663pju.0.2024.03.15.06.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 06:09:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 05/12] qtest: bios-tables-test: Rename aarch64 tests with
 aarch64 in them
Date: Fri, 15 Mar 2024 18:39:17 +0530
Message-Id: <20240315130924.2378849-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Existing AARCH64 virt test functions do not have AARCH64 in their name.
To add RISC-V virt related test cases, better to rename existing
functions to indicate they are ARM only.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/qtest/bios-tables-test.c | 35 ++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 21811a1ab5..ea3ba1992b 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1557,7 +1557,7 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
 
-static void test_acpi_virt_tcg_memhp(void)
+static void test_acpi_aarch64_virt_tcg_memhp(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1650,7 +1650,7 @@ static void test_acpi_microvm_ioapic2_tcg(void)
     free_test_data(&data);
 }
 
-static void test_acpi_virt_tcg_numamem(void)
+static void test_acpi_aarch64_virt_tcg_numamem(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1672,7 +1672,7 @@ static void test_acpi_virt_tcg_numamem(void)
 
 }
 
-static void test_acpi_virt_tcg_pxb(void)
+static void test_acpi_aarch64_virt_tcg_pxb(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1745,7 +1745,7 @@ static void test_acpi_piix4_tcg_acpi_hmat(void)
     test_acpi_tcg_acpi_hmat(MACHINE_PC);
 }
 
-static void test_acpi_virt_tcg_acpi_hmat(void)
+static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1901,7 +1901,7 @@ static void test_acpi_microvm_acpi_erst(void)
 }
 #endif /* CONFIG_POSIX */
 
-static void test_acpi_virt_tcg(void)
+static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
         .machine = "virt",
@@ -1920,7 +1920,7 @@ static void test_acpi_virt_tcg(void)
     free_test_data(&data);
 }
 
-static void test_acpi_virt_tcg_topology(void)
+static void test_acpi_aarch64_virt_tcg_topology(void)
 {
     test_data data = {
         .machine = "virt",
@@ -2003,7 +2003,7 @@ static void test_acpi_q35_cxl(void)
 }
 #endif /* CONFIG_POSIX */
 
-static void test_acpi_virt_viot(void)
+static void test_acpi_aarch64_virt_viot(void)
 {
     test_data data = {
         .machine = "virt",
@@ -2135,7 +2135,7 @@ static void test_acpi_microvm_oem_fields(void)
     g_free(args);
 }
 
-static void test_acpi_virt_oem_fields(void)
+static void test_acpi_aarch64_virt_oem_fields(void)
 {
     test_data data = {
         .machine = "virt",
@@ -2301,16 +2301,19 @@ int main(int argc, char *argv[])
         }
     } else if (strcmp(arch, "aarch64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
-            qtest_add_func("acpi/virt", test_acpi_virt_tcg);
+            qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
             qtest_add_func("acpi/virt/acpihmatvirt",
-                            test_acpi_virt_tcg_acpi_hmat);
-            qtest_add_func("acpi/virt/topology", test_acpi_virt_tcg_topology);
-            qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
-            qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
-            qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
-            qtest_add_func("acpi/virt/oem-fields", test_acpi_virt_oem_fields);
+                           test_acpi_aarch64_virt_tcg_acpi_hmat);
+            qtest_add_func("acpi/virt/topology",
+                           test_acpi_aarch64_virt_tcg_topology);
+            qtest_add_func("acpi/virt/numamem",
+                           test_acpi_aarch64_virt_tcg_numamem);
+            qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
+            qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
+            qtest_add_func("acpi/virt/oem-fields",
+                           test_acpi_aarch64_virt_oem_fields);
             if (qtest_has_device("virtio-iommu-pci")) {
-                qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
+                qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
         }
     }
-- 
2.40.1


