Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A57C54E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9I-0006X9-4d; Fri, 08 Mar 2024 06:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9B-0006Wh-CA
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:17 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY99-0001P4-JF
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:17 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so477507a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896333; x=1710501133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Lx1U2+PzZZqUvDQJGZxdX2KWNymuUz6M3pfeiGeF1g=;
 b=IDVOVu/2qyEgTQ7YT5f2LkGItUTdsfAW5JyYJspwsfhX9/hNCeHJucvvmBWbN+qMXa
 XCOZ7xKJJ07Ki7Wc8KPWUgTAmz+1jKNO+Arg7gCFi8pG/XRDO2cktzKXLnt41WoQ6VO+
 yxQU5irZgmr79ZGTJ34hpjfnXnWAksv0+z/csn7U9axUXxLvB1dxLct0oiFZS4sLGNZC
 KYjctu7KH5Ez7HuJALmDL/wtvmnD+ZMIJE485lYKNFx0PBXY2HuYMVoNsniCF7zLZF16
 J2usfg2H8eT4guxBpTjABRdrRnXNbs5umbB8wDOhj0d6blAEJU+07X3iWs8XqvfS2cDp
 ttTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896333; x=1710501133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Lx1U2+PzZZqUvDQJGZxdX2KWNymuUz6M3pfeiGeF1g=;
 b=b1H58pmuE3BfPIiOXaUJRmenjnUXlkr4slUm+q+8xgCwd5I+WLXIOA+WQ2MLYQ5+4u
 AKprvr3kt521IfiQ6IqjhKbqnViddV/rFr5i+GjhFDHMCNpOKYDhvk/J4qEdZ1mhv/6C
 AzVIgKqjnCvr7UQQoy4RLS74/Bg+sckNmypMfmBe6ULFExaJ4tKukiuD/t1RsMhdP+bN
 MK4C3DxmM8DfkzijD20XzEZj+ZQ51uyQ6CyPzpyGzgwg1/fHQ+QRIvzu+t0kvvJGKgOx
 WQyf1vB87J4HzQH1zQUohIrJsja09tiqSaB7HyesyhuocdsazyygTQPIYj6QgJJmXGMW
 m7Ig==
X-Gm-Message-State: AOJu0YwtBEMNhtr/1CZUOc7i8Sd3vUnu04C5ARObzUUwT40N1yvMzWNM
 tkGPpWW2p4vYaUSCBWC4bXN0jR0ed8/txYMyjSNROgg/BPLcpicPsyWl4zqdIrwN4A==
X-Google-Smtp-Source: AGHT+IHNs4kiNLGo03xTQ/GKQOrpa8HX2Aylskwl/M/p0MI+dpXQ5SKNlqppn/igiEQcN/aL5bQTYw==
X-Received: by 2002:a05:6a20:d486:b0:1a1:44c9:2d90 with SMTP id
 im6-20020a056a20d48600b001a144c92d90mr12616067pzb.40.1709896333628; 
 Fri, 08 Mar 2024 03:12:13 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:13 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/34] hw/riscv/virt-acpi-build.c: Generate SPCR table
Date: Fri,  8 Mar 2024 21:11:21 +1000
Message-ID: <20240308111152.2856137-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

Generate Serial Port Console Redirection Table (SPCR) for RISC-V
virtual machine.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240129021440.17640-3-jeeheng.sia@starfivetech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index fb8baf64f6..0baa902fea 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -174,6 +174,42 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
     aml_append(scope, dev);
 }
 
+/*
+ * Serial Port Console Redirection Table (SPCR)
+ * Rev: 1.07
+ */
+
+static void
+spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
+{
+    AcpiSpcrData serial = {
+        .interface_type = 0,       /* 16550 compatible */
+        .base_addr.id = AML_AS_SYSTEM_MEMORY,
+        .base_addr.width = 32,
+        .base_addr.offset = 0,
+        .base_addr.size = 1,
+        .base_addr.addr = s->memmap[VIRT_UART0].base,
+        .interrupt_type = (1 << 4),/* Bit[4] RISC-V PLIC/APLIC */
+        .pc_interrupt = 0,
+        .interrupt = UART0_IRQ,
+        .baud_rate = 7,            /* 15200 */
+        .parity = 0,
+        .stop_bits = 1,
+        .flow_control = 0,
+        .terminal_type = 3,        /* ANSI */
+        .language = 0,             /* Language */
+        .pci_device_id = 0xffff,   /* not a PCI device*/
+        .pci_vendor_id = 0xffff,   /* not a PCI device*/
+        .pci_bus = 0,
+        .pci_device = 0,
+        .pci_function = 0,
+        .pci_flags = 0,
+        .pci_segment = 0,
+    };
+
+    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table_id);
+}
+
 /* RHCT Node[N] starts at offset 56 */
 #define RHCT_NODE_ARRAY_OFFSET 56
 
@@ -555,6 +591,9 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_rhct(tables_blob, tables->linker, s);
 
+    acpi_add_table(table_offsets, tables_blob);
+    spcr_setup(tables_blob, tables->linker, s);
+
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
-- 
2.44.0


