Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FBEC27C7B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Ww-0003tl-LT; Mon, 17 Jun 2024 03:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Wu-0003t2-To
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:52 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Wt-00029K-0k
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:52 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57c714a1e24so4449850a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608309; x=1719213109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V8dcRgEahFB3NY5bnQD9C47ReYjbE4TI9uiATbzbyw=;
 b=eyo5aA79Qzsh6urgQTqslLQaONRXXRMakM+crcjM/cnGeQ3SNTnBAbzR+ibRALHe1Q
 9jWizNjPXmDx/uOawRaVUBElQUAxAwcD5ZGuFoPC53XOZsyjmkSqYLVX5ztQ0TJSppsh
 rgXttmnUaXZFGDrRQPYLzQ5y/bI4CniIcfRjbT6+QbpIIs9+5Z0Ow5fXptInote46J8f
 IeTcBZlEOTaWyis1GTCEgkmarXn4wV33CSwzSIGEC5pGUDe4cGPkhCzEWcOBUmr1Gx13
 6i08Xzuke16cA7zGunRWbjQBscOlOFYhtP0qnAVVbb9qjmRItgGEIuAX+yxOBY7Vgiyg
 kLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608309; x=1719213109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3V8dcRgEahFB3NY5bnQD9C47ReYjbE4TI9uiATbzbyw=;
 b=q1s3toHt8a1gHPMtC0L1iGuGvweqx8ey7mcL1lulsrxL9gcN4KED0p3g0r5vtCYCbI
 kQ1a7BnDCE+zib+8mt2SU4SJAWjCAjEP9MrSCIKRHpvyOAlPglligHtNlIWyU7tz8nl1
 R49b9qsJlxVUkxQJ4A8bH4ZiXduaFtZIhMNY5GeUqX6OqDoRaoKTziMUbXKQiLYNSsas
 Ezh2bn7PxNZ8jn3kgjvyNZ6rmPffWlm2bNVPs+8kyz4lxD4ei8FBRWZHXdc1ilsVINml
 P/+jH6O2I1C9o1LWJIrAgq0+uUlaOMX0ytL7alYFVzFXQxHF3VPcl2iAWuCSmgYUwya5
 9Qjw==
X-Gm-Message-State: AOJu0YxQPZSJwLOXbBrgwo3LRQIC0GfTAW5J/HbxpTS1lIqROZyk7eDY
 ijBv0q4IkbUTo4Z1sJQWA9bGSxnZY7uLb4AUgtEEURKsghoGBuKa2rBlMI4g0I0k3MMG5iN269A
 f0Vs=
X-Google-Smtp-Source: AGHT+IF+sldkqGseynIGS9Ob+sq8ACl1jL4wMo4YALEjZBx7fjOdjnhy1Zt3JqZewY7m1ydGWmGIcg==
X-Received: by 2002:a50:9f64:0:b0:57c:6f67:b17c with SMTP id
 4fb4d7f45d1cf-57cbd6742bfmr5148671a12.7.1718608309067; 
 Mon, 17 Jun 2024 00:11:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb7439646sm6014070a12.88.2024.06.17.00.11.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:11:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 05/23] hw/i386/acpi: Remove
 PCMachineClass::legacy_acpi_table_size
Date: Mon, 17 Jun 2024 09:11:00 +0200
Message-ID: <20240617071118.60464-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PCMachineClass::legacy_acpi_table_size was only used by the
pc-i440fx-2.0 machine, which got removed. Remove it and simplify
acpi_build().

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/acpi-build.c | 63 +++++++++-----------------------------------
 2 files changed, 12 insertions(+), 52 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3e606949fb..434e531160 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -103,7 +103,6 @@ struct PCMachineClass {
     /* ACPI compat: */
     bool has_acpi_build;
     bool rsdp_in_ram;
-    int legacy_acpi_table_size;
     unsigned acpi_data_size;
     int pci_root_uid;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 53f804ac16..f5d74e2b4b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -85,7 +85,6 @@
  * a little bit, there should be plenty of free space since the DSDT
  * shrunk by ~1.5k between QEMU 2.0 and QEMU 2.1.
  */
-#define ACPI_BUILD_LEGACY_CPU_AML_SIZE    97
 #define ACPI_BUILD_ALIGN_SIZE             0x1000
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -2499,13 +2498,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     X86MachineState *x86ms = X86_MACHINE(machine);
     DeviceState *iommu = pcms->iommu;
     GArray *table_offsets;
-    unsigned facs, dsdt, rsdt, fadt;
+    unsigned facs, dsdt, rsdt;
     AcpiPmInfo pm;
     AcpiMiscInfo misc;
     AcpiMcfgInfo mcfg;
     Range pci_hole = {}, pci_hole64 = {};
     uint8_t *u;
-    size_t aml_len = 0;
     GArray *tables_blob = tables->table_data;
     AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
     Object *vmgenid_dev;
@@ -2551,19 +2549,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     build_dsdt(tables_blob, tables->linker, &pm, &misc,
                &pci_hole, &pci_hole64, machine);
 
-    /* Count the size of the DSDT and SSDT, we will need it for legacy
-     * sizing of ACPI tables.
-     */
-    aml_len += tables_blob->len - dsdt;
-
     /* ACPI tables pointed to by RSDT */
-    fadt = tables_blob->len;
     acpi_add_table(table_offsets, tables_blob);
     pm.fadt.facs_tbl_offset = &facs;
     pm.fadt.dsdt_tbl_offset = &dsdt;
     pm.fadt.xdsdt_tbl_offset = &dsdt;
     build_fadt(tables_blob, tables->linker, &pm.fadt, oem_id, oem_table_id);
-    aml_len += tables_blob->len - fadt;
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, x86ms,
@@ -2694,49 +2685,19 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      * too simple to be enough.  4k turned out to be too small an
      * alignment very soon, and in fact it is almost impossible to
      * keep the table size stable for all (max_cpus, max_memory_slots)
-     * combinations.  So the table size is always 64k for pc-i440fx-2.1
-     * and we give an error if the table grows beyond that limit.
-     *
-     * We still have the problem of migrating from "-M pc-i440fx-2.0".  For
-     * that, we exploit the fact that QEMU 2.1 generates _smaller_ tables
-     * than 2.0 and we can always pad the smaller tables with zeros.  We can
-     * then use the exact size of the 2.0 tables.
-     *
-     * All this is for PIIX4, since QEMU 2.0 didn't support Q35 migration.
+     * combinations.
      */
-    if (pcmc->legacy_acpi_table_size) {
-        /* Subtracting aml_len gives the size of fixed tables.  Then add the
-         * size of the PIIX4 DSDT/SSDT in QEMU 2.0.
-         */
-        int legacy_aml_len =
-            pcmc->legacy_acpi_table_size +
-            ACPI_BUILD_LEGACY_CPU_AML_SIZE * x86ms->apic_id_limit;
-        int legacy_table_size =
-            ROUND_UP(tables_blob->len - aml_len + legacy_aml_len,
-                     ACPI_BUILD_ALIGN_SIZE);
-        if ((tables_blob->len > legacy_table_size) &&
-            !pcmc->resizable_acpi_blob) {
-            /* Should happen only with PCI bridges and -M pc-i440fx-2.0.  */
-            warn_report("ACPI table size %u exceeds %d bytes,"
-                        " migration may not work",
-                        tables_blob->len, legacy_table_size);
-            error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                         " or PCI bridges.\n");
-        }
-        g_array_set_size(tables_blob, legacy_table_size);
-    } else {
-        /* Make sure we have a buffer in case we need to resize the tables. */
-        if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
-            !pcmc->resizable_acpi_blob) {
-            /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
-            warn_report("ACPI table size %u exceeds %d bytes,"
-                        " migration may not work",
-                        tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
-            error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                         " or PCI bridges.\n");
-        }
-        acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
+    /* Make sure we have a buffer in case we need to resize the tables. */
+    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
+        !pcmc->resizable_acpi_blob) {
+        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
+        warn_report("ACPI table size %u exceeds %d bytes,"
+                    " migration may not work",
+                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
+        error_printf("Try removing CPUs, NUMA nodes, memory slots"
+                     " or PCI bridges.\n");
     }
+    acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
 
     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
 
-- 
2.41.0


