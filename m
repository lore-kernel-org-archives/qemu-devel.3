Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234F2C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPwq-0002KN-W8; Wed, 27 Mar 2024 05:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwp-0002J0-40
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:51:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwn-0006iz-3P
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:51:54 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a46ba938de0so866503366b.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533111; x=1712137911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EOMeI+cmJTs9JUVO4oguXe/gFC99HulgRN8N2p2Hs4=;
 b=s9xWxC7SwkhzkeR+FLXbln33qWvBy2o3AzsBu2eaqp8LSr4c8fyIZM2MKYWe8/q1vq
 ruVbHCXLZkTkawWI8cDW8Uu2qNMxHLVBlk3648iSxhEEMfNP9DLKhEBy96vfxJ2yPvhn
 TGnDNyfHIBe8OItOXHWtvHnjZzQktoepul6LRk2lBdNdv5T2Nm4UYBcfvRE0s4c9/Ix3
 ZNDFSJjpISLQxV/aHtbclwoIXzuFMfpE71cVQgRLp5Hume04m0fSaOsqdx50SbNCOfhd
 W6hiLUHfKCcGBYxBBWENsSJyGvPUe74c8y8j7xz+4hY/+ojXjy0WmkCU7jC4REC1sx0y
 nR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533111; x=1712137911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EOMeI+cmJTs9JUVO4oguXe/gFC99HulgRN8N2p2Hs4=;
 b=dggIbrWugJ1woSCn8hG56uXcE3DGrdNUW1hg1oIwOPQIWX9Tbf6tBdp3wBFCn9vNVW
 9DTSzW0xJarVVCCY5yjYFyw9D2On1VBmMqBqvKxvXgIvyTRQT2LDtuy9cEtISiLMmWCS
 Lpbu1SV5tg22LZTurZ9qCw/b+qxbQCBhNmInzfrrWHRb9vdX2gf68DJUxPUrTROLq+c9
 xZhBRjzRO7iOhHVan+zlozEAc1zCyjqvarmLT/AGR3w3LTqPjaybw4NxWfmZtlG09Tka
 Jt5rVZCUM+3BQSO0ohP4l5h2DkVWFMANx0ZupHpPbzcW18j5qQeEnBtHbiKIaS7fbRzF
 2INg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdJac2foieABKQ5kOeJmMno2NzbtK0Q5easSjDK+1oZ8Lt/q029Aw5W1KIkCxTF6xcW9L62pdCK4D9EkM98sxKCoTr4WQ=
X-Gm-Message-State: AOJu0YyvkEmfVtYktmo4rDfjKT09QM82kDZ2Lsb1w4ckEhgtwWWC/3fh
 +/DNcN+apRXEi8FSlja+QlLuI1DofiDrxWkBGKGo0patBusKvXCKjTlm0i9krDw=
X-Google-Smtp-Source: AGHT+IEdVi4MDq5ukDcPreLr3dc3lhJOZk6KNTNq2c7gCjryr0VDvxNmdzA7VwdCwJnOWswwpHo/Hw==
X-Received: by 2002:a17:906:4f85:b0:a46:cef3:4aba with SMTP id
 o5-20020a1709064f8500b00a46cef34abamr3515420eju.75.1711533111466; 
 Wed, 27 Mar 2024 02:51:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a1709063daa00b00a4d9e714efbsm2337434ejh.76.2024.03.27.02.51.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:51:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.1 v2 04/21] hw/i386/acpi: Remove
 PCMachineClass::legacy_acpi_table_size
Date: Wed, 27 Mar 2024 10:51:06 +0100
Message-ID: <20240327095124.73639-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

PCMachineClass::legacy_acpi_table_size was only used by the
pc-i440fx-2.0 machine, which got removed. Remove it and simplify
acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  1 -
 hw/i386/acpi-build.c | 62 +++++++++-----------------------------------
 2 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 67856f54c3..4ad724601a 100644
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
index 53f804ac16..a6f8203460 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2499,13 +2499,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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
@@ -2551,19 +2550,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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
@@ -2694,49 +2686,19 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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


