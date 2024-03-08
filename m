Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709EFC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9A-0006WQ-9S; Fri, 08 Mar 2024 06:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY98-0006WB-3k
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:14 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY96-0001OM-40
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:13 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dd1d9daf02so11744215ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896330; x=1710501130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXtIHKVY2AV8WUjzbtv3+hua/eWqofTiBpmxeUSggTA=;
 b=HQBTevj/qs4wRo1nDCXrq1+hTTw6pNPjuj0yqRlIK924vguE3yPmqNE8ytTkdG6aHi
 lz6Fg4rxRBz5EmnPPgYnAuwfywH0SfjY/rpzUejWO0/LdbG1SRgyHH4h3mpElM+3VteX
 S2DXYv1tb0J5+p4drkEL1n9k5kYMecMm/nq2VbCIgGXwOz+oUSRcwCISD6Bus+5Cn2ys
 LqSoEDXQ8eHwQJbLTV3ZcRZV5uXgM5zlzxluwh/gbv4Bg59+fFD748Jr/gvtr+HUt0Ek
 b3Z/ynzFZqKEArcMfZgJ+pPcjdF8DBj8Y28Cgm/YNkubsjAKSmD8vfffb8QHd/qguDGx
 aEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896330; x=1710501130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXtIHKVY2AV8WUjzbtv3+hua/eWqofTiBpmxeUSggTA=;
 b=DCdOtC9X9hxRT5K7syJhIw7bXcRR9nk05zWxpavcG4VRXU05Dp1GfxSp/WinCCSSGa
 /hMPuVDQ50xVPGfuR03A/1OBLr29UhpbQZBg4bOgCSUBkH8rQWCJCN2oVhnCxOkTrtzw
 /hF1Iecg9yp9wcLtghBwCuIoNulNQiG2ghLCjr1OUP2LVFOznLGPMAKFSCRD0Yk4slq5
 +QCILJBPw6OjAbHzuX209SCu8to9G18HjByfXTJALzxja/iGKMubPYZsqVqU4098+mhX
 VYxFubnfoQT7+ESS0JZtgLxoGtq6aFw5YWZu4nSn+WM04sNMtJq/2ho4E4lBXwz8AGVN
 3qUw==
X-Gm-Message-State: AOJu0YxUmfHvJ4V8kS2B3qdIhZ13wqMK1AcMmlzRj+DLG34mOLKpKwPG
 brOzJ0+RYercJ5KsD5IK0GA9HCp23M50YFWQQgwKFuDy4VvoCsJuSlaFvZ6XwNnEeA==
X-Google-Smtp-Source: AGHT+IGxHkWk+fLymlvfEnuYTcZlt/XpPGLK3J0f0aIV8RzK00hNYrneYcJ/I89lIRc9pN15FEspPA==
X-Received: by 2002:a17:902:c94d:b0:1dd:54a6:63e5 with SMTP id
 i13-20020a170902c94d00b001dd54a663e5mr5579854pla.14.1709896330384; 
 Fri, 08 Mar 2024 03:12:10 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:09 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/34] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
Date: Fri,  8 Mar 2024 21:11:20 +1000
Message-ID: <20240308111152.2856137-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

RISC-V should also generate the SPCR in a manner similar to ARM.
Therefore, instead of replicating the code, relocate this function
to the common AML build.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
[ Changes by AF:
 - Add missing Language SPCR entry
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/acpi/acpi-defs.h | 33 ++++++++++++++++++
 include/hw/acpi/aml-build.h |  4 +++
 hw/acpi/aml-build.c         | 53 +++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 68 +++++++++++++++----------------------
 4 files changed, 117 insertions(+), 41 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 2b42e4192b..0e6e82b339 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -90,6 +90,39 @@ typedef struct AcpiFadtData {
     unsigned *xdsdt_tbl_offset;
 } AcpiFadtData;
 
+typedef struct AcpiGas {
+    uint8_t id;                /* Address space ID */
+    uint8_t width;             /* Register bit width */
+    uint8_t offset;            /* Register bit offset */
+    uint8_t size;              /* Access size */
+    uint64_t addr;             /* Address */
+} AcpiGas;
+
+/* SPCR (Serial Port Console Redirection table) */
+typedef struct AcpiSpcrData {
+    uint8_t interface_type;
+    uint8_t reserved[3];
+    struct AcpiGas base_addr;
+    uint8_t interrupt_type;
+    uint8_t pc_interrupt;
+    uint32_t interrupt;        /* Global system interrupt */
+    uint8_t baud_rate;
+    uint8_t parity;
+    uint8_t stop_bits;
+    uint8_t flow_control;
+    uint8_t terminal_type;
+    uint8_t language;
+    uint8_t reserved1;
+    uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
+    uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
+    uint8_t pci_bus;
+    uint8_t pci_device;
+    uint8_t pci_function;
+    uint32_t pci_flags;
+    uint8_t pci_segment;
+    uint32_t reserved2;
+} AcpiSpcrData;
+
 #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
 #define ACPI_FADT_ARM_PSCI_USE_HVC    (1 << 1)
 
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index ff2a310270..a3784155cb 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -497,4 +497,8 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
 
 void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
                 const char *oem_id, const char *oem_table_id);
+
+void build_spcr(GArray *table_data, BIOSLinker *linker,
+                const AcpiSpcrData *f, const uint8_t rev,
+                const char *oem_id, const char *oem_table_id);
 #endif
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index af66bde0f5..6d4517cfbe 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1994,6 +1994,59 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
     }
 }
 
+void build_spcr(GArray *table_data, BIOSLinker *linker,
+                const AcpiSpcrData *f, const uint8_t rev,
+                const char *oem_id, const char *oem_table_id)
+{
+    AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+
+    acpi_table_begin(&table, table_data);
+    /* Interface type */
+    build_append_int_noprefix(table_data, f->interface_type, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 3);
+    /* Base Address */
+    build_append_gas(table_data, f->base_addr.id, f->base_addr.width,
+                     f->base_addr.offset, f->base_addr.size,
+                     f->base_addr.addr);
+    /* Interrupt type */
+    build_append_int_noprefix(table_data, f->interrupt_type, 1);
+    /* IRQ */
+    build_append_int_noprefix(table_data, f->pc_interrupt, 1);
+    /* Global System Interrupt */
+    build_append_int_noprefix(table_data, f->interrupt, 4);
+    /* Baud Rate */
+    build_append_int_noprefix(table_data, f->baud_rate, 1);
+    /* Parity */
+    build_append_int_noprefix(table_data, f->parity, 1);
+    /* Stop Bits */
+    build_append_int_noprefix(table_data, f->stop_bits, 1);
+    /* Flow Control */
+    build_append_int_noprefix(table_data, f->flow_control, 1);
+    /* Language */
+    build_append_int_noprefix(table_data, f->language, 1);
+    /* Terminal Type */
+    build_append_int_noprefix(table_data, f->terminal_type, 1);
+    /* PCI Device ID  */
+    build_append_int_noprefix(table_data, f->pci_device_id, 2);
+    /* PCI Vendor ID */
+    build_append_int_noprefix(table_data, f->pci_vendor_id, 2);
+    /* PCI Bus Number */
+    build_append_int_noprefix(table_data, f->pci_bus, 1);
+    /* PCI Device Number */
+    build_append_int_noprefix(table_data, f->pci_device, 1);
+    /* PCI Function Number */
+    build_append_int_noprefix(table_data, f->pci_function, 1);
+    /* PCI Flags */
+    build_append_int_noprefix(table_data, f->pci_flags, 4);
+    /* PCI Segment */
+    build_append_int_noprefix(table_data, f->pci_segment, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    acpi_table_end(linker, &table);
+}
 /*
  * ACPI spec, Revision 6.3
  * 5.2.29 Processor Properties Topology Table (PPTT)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 84141228d5..6a1bde61ce 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -431,48 +431,34 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
  * Rev: 1.07
  */
 static void
-build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
-    AcpiTable table = { .sig = "SPCR", .rev = 2, .oem_id = vms->oem_id,
-                        .oem_table_id = vms->oem_table_id };
-
-    acpi_table_begin(&table, table_data);
-
-    /* Interface Type */
-    build_append_int_noprefix(table_data, 3, 1); /* ARM PL011 UART */
-    build_append_int_noprefix(table_data, 0, 3); /* Reserved */
-    /* Base Address */
-    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 3,
-                     vms->memmap[VIRT_UART].base);
-    /* Interrupt Type */
-    build_append_int_noprefix(table_data,
-        (1 << 3) /* Bit[3] ARMH GIC interrupt */, 1);
-    build_append_int_noprefix(table_data, 0, 1); /* IRQ */
-    /* Global System Interrupt */
-    build_append_int_noprefix(table_data,
-                              vms->irqmap[VIRT_UART] + ARM_SPI_BASE, 4);
-    build_append_int_noprefix(table_data, 3 /* 9600 */, 1); /* Baud Rate */
-    build_append_int_noprefix(table_data, 0 /* No Parity */, 1); /* Parity */
-    /* Stop Bits */
-    build_append_int_noprefix(table_data, 1 /* 1 Stop bit */, 1);
-    /* Flow Control */
-    build_append_int_noprefix(table_data,
-        (1 << 1) /* RTS/CTS hardware flow control */, 1);
-    /* Terminal Type */
-    build_append_int_noprefix(table_data, 0 /* VT100 */, 1);
-    build_append_int_noprefix(table_data, 0, 1); /* Language */
-    /* PCI Device ID  */
-    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/, 2);
-    /* PCI Vendor ID */
-    build_append_int_noprefix(table_data, 0xffff /* not a PCI device*/, 2);
-    build_append_int_noprefix(table_data, 0, 1); /* PCI Bus Number */
-    build_append_int_noprefix(table_data, 0, 1); /* PCI Device Number */
-    build_append_int_noprefix(table_data, 0, 1); /* PCI Function Number */
-    build_append_int_noprefix(table_data, 0, 4); /* PCI Flags */
-    build_append_int_noprefix(table_data, 0, 1); /* PCI Segment */
-    build_append_int_noprefix(table_data, 0, 4); /* Reserved */
+    AcpiSpcrData serial = {
+        .interface_type = 3,       /* ARM PL011 UART */
+        .base_addr.id = AML_AS_SYSTEM_MEMORY,
+        .base_addr.width = 32,
+        .base_addr.offset = 0,
+        .base_addr.size = 3,
+        .base_addr.addr = vms->memmap[VIRT_UART].base,
+        .interrupt_type = (1 << 3),/* Bit[3] ARMH GIC interrupt*/
+        .pc_interrupt = 0,         /* IRQ */
+        .interrupt = (vms->irqmap[VIRT_UART] + ARM_SPI_BASE),
+        .baud_rate = 3,            /* 9600 */
+        .parity = 0,               /* No Parity */
+        .stop_bits = 1,            /* 1 Stop bit */
+        .flow_control = 1 << 1,    /* RTS/CTS hardware flow control */
+        .terminal_type = 0,        /* VT100 */
+        .language = 0,             /* Language */
+        .pci_device_id = 0xffff,   /* not a PCI device*/
+        .pci_vendor_id = 0xffff,   /* not a PCI device*/
+        .pci_bus = 0,
+        .pci_device = 0,
+        .pci_function = 0,
+        .pci_flags = 0,
+        .pci_segment = 0,
+    };
 
-    acpi_table_end(linker, &table);
+    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
 }
 
 /*
@@ -938,7 +924,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    build_spcr(tables_blob, tables->linker, vms);
+    spcr_setup(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
     build_dbg2(tables_blob, tables->linker, vms);
-- 
2.44.0


