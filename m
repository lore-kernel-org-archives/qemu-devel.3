Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EA3C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOgT-00032x-Tw; Fri, 09 Feb 2024 06:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdW-0007bp-Qs
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:44 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdT-0000uc-Mn
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:37 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e0507eb60cso548278b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476491; x=1708081291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THLH44KZ0Lw73EwXc5lGcpB+FJn+KEQb4YaOtb3i2FM=;
 b=TMddkavk6exxw49wz9fuXq9cax3hgh7RGhofF7HEFxRjvSdRuHBVPJUOPuV9KZaNHi
 8KtxJOhrEYFZ1TLXItGOcRkPMRNLE2soAS//NTNXYAPu692a0Hy1O+kATz36vqv66lIx
 fJIcOJ6UUDaAX2hCr8OeGW0lcKDglC2PU4Mi8INNr+SyfKS5HAM7ltVPLOzPlZAShJqr
 SQIBq8SCRpVymvAUD2uvr+ykRfggcuYK2FeqtiPxHI7vpxFrOozA7xQKCpXdd1n+pCLC
 /zH3oWWrPCPmMPU3TP8lH0wIF6K36mvhXh3h49Ka3mtV1vPdLPvaLPCPl3LXahtmm00h
 TkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476491; x=1708081291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THLH44KZ0Lw73EwXc5lGcpB+FJn+KEQb4YaOtb3i2FM=;
 b=NtGfLzrvdMsB4JDAT0Av+IDVGCpJ4yFlymAuh5+WsP4kodAAxu3ff1wUXGjXx8Tvm7
 xRmGRGCor8tHsKfXi3kMysGhT1LMZ88us94uwZX2n3f2fHjFox+MhSrrnQHm/9k5fATT
 BQkuTAFWTduvJYWGhLRy5KsQxgfCZypR66+l+dNCGd+lamss8Eu5DyVuVrgoomuaAwu9
 zNTxQizM8/1LzIk19r446GelYAvd5pTf0s7Bw13WihE4/HdgL1Rw9IbYibORqJmFqPGM
 TdhfDrwpdAgebhfSMtJubhX6MqqaTCKLOYOo7fPWV+kIwtIQ3annIUy5PW00Y9pYP/vi
 ZdgA==
X-Gm-Message-State: AOJu0YwGwmmiVCXjBx/TZB9Hn3Mzjjcwq8XheUxrxacswCfPNUewJOkW
 IXhYcii2qOiOwBmjxwmhbM77moteDIRKBgo9XR+qXB0gBJ6xvrtwDYsqOB64zslh8Q==
X-Google-Smtp-Source: AGHT+IE2ePe1J4Hh0SeCVQJFdQnFPc6wtjG1DCy+gI24sVZEixoYtpAsgtItsO6bUkkXNlq/t4BX9w==
X-Received: by 2002:a05:6a21:2d88:b0:19c:9d4d:7d7 with SMTP id
 ty8-20020a056a212d8800b0019c9d4d07d7mr1887797pzb.41.1707476491422; 
 Fri, 09 Feb 2024 03:01:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXO+tLZ95mlTG+4XWJ8AkSx8wRPuRqHv09DM6Io4+ZzOvPpvz9wlocuHj8FFj83vUuBjbgEDqM25wgwo8sCP4j4UceywujybqiywIqoLzvNcNQlyJaFLJM6VLmGNQvtS5q9o8eqUBQBUGYonIfUNZpKz4S5agULe19ilb3Az63tz+dZis0=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:30 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 57/61] target/riscv: SMBIOS support for RISC-V virt machine
Date: Fri,  9 Feb 2024 20:58:09 +1000
Message-ID: <20240209105813.3590056-58-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Generate SMBIOS tables for the RISC-V mach-virt.
Add CONFIG_SMBIOS=y to the RISC-V default config.
Set the default processor family in the type 4 table.

The implementation is based on the corresponding ARM and Loongson code.

With the patch the following firmware tables are provided:

    etc/smbios/smbios-anchor
    etc/smbios/smbios-tables

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20240123184229.10415-4-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig |  1 +
 2 files changed, 43 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b4e80b0b0d..fd35c74781 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
+#include "hw/firmware/smbios.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
@@ -1221,6 +1222,45 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
                                 sysbus_mmio_get_region(sysbus, 0));
 }
 
+static void virt_build_smbios(RISCVVirtState *s)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(s);
+    MachineState *ms = MACHINE(s);
+    uint8_t *smbios_tables, *smbios_anchor;
+    size_t smbios_tables_len, smbios_anchor_len;
+    struct smbios_phys_mem_area mem_array;
+    const char *product = "QEMU Virtual Machine";
+
+    if (kvm_enabled()) {
+        product = "KVM Virtual Machine";
+    }
+
+    smbios_set_defaults("QEMU", product, mc->name, false,
+                        true, SMBIOS_ENTRY_POINT_TYPE_64);
+
+    if (riscv_is_32bit(&s->soc[0])) {
+        smbios_set_default_processor_family(0x200);
+    } else {
+        smbios_set_default_processor_family(0x201);
+    }
+
+    /* build the array of physical mem area from base_memmap */
+    mem_array.address = s->memmap[VIRT_DRAM].base;
+    mem_array.length = ms->ram_size;
+
+    smbios_get_tables(ms, &mem_array, 1,
+                      &smbios_tables, &smbios_tables_len,
+                      &smbios_anchor, &smbios_anchor_len,
+                      &error_fatal);
+
+    if (smbios_anchor) {
+        fw_cfg_add_file(s->fw_cfg, "etc/smbios/smbios-tables",
+                        smbios_tables, smbios_tables_len);
+        fw_cfg_add_file(s->fw_cfg, "etc/smbios/smbios-anchor",
+                        smbios_anchor, smbios_anchor_len);
+    }
+}
+
 static void virt_machine_done(Notifier *notifier, void *data)
 {
     RISCVVirtState *s = container_of(notifier, RISCVVirtState,
@@ -1309,6 +1349,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
         riscv_setup_direct_kernel(kernel_entry, fdt_load_addr);
     }
 
+    virt_build_smbios(s);
+
     if (virt_is_acpi_enabled(s)) {
         virt_acpi_setup(s);
     }
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a50717be87..5d644eb7b1 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -41,6 +41,7 @@ config RISCV_VIRT
     select RISCV_IMSIC
     select SIFIVE_PLIC
     select SIFIVE_TEST
+    select SMBIOS
     select VIRTIO_MMIO
     select FW_CFG_DMA
     select PLATFORM_BUS
-- 
2.43.0


