Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47650C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLkV-0004tp-05; Tue, 23 Jan 2024 13:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLkJ-0004lg-Ej
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:42 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLkH-0002pA-8n
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:39 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F108C40A04
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706035399;
 bh=iGr0FnTYaT+qArrCpsR1nJW5AEkfoz2acQmeTnnwl5I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=WIIYqj4ptsSdCYilcm1hp9CLZx0wgx8/S7mZeX/NdGZep0C8MRniWLS2nGHbUfoM8
 64a3gVma3lcK6DgsrAxciMo0eai7eKk60j0JJF7E6OURlz3z2Jdw3aBX90gKraGmDW
 3nQQnv6PO+EZgg0n2heeP92rLRo/jd4F+O+f9AszaDl8HfHSwQ5hW2cfA0acwZKRKb
 JtC4GkMlkOrs/YIENK0iAcm/9EAEPaE9Xhd6AM9aNGZtJkYFpNUt+msRmqL79Irr18
 I7fi/vPysixdNJj3JHHvDcnpDVoclV7HNQBAOCj7jrzVQtACwFBFXXtiKAszI6Hxmc
 nO1NH5QuSiz+Q==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-339214f9199so2544409f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 10:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706035393; x=1706640193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGr0FnTYaT+qArrCpsR1nJW5AEkfoz2acQmeTnnwl5I=;
 b=VpDWsG6hyimISun+UO0Q5fCTge0iDFn7cXjEKxlaEWO2GygOAHxzMDcmDsFgPFp5Zg
 EJKdhIGusZ/1TvpOOG09UCZS+vBYzgUHbnyijVQXfhgaVs+7hQf2M4Pnt3pVhYHyIEvD
 QrKDF2+muSVupQmPbrcAqyxapmZd09g+6wmNizcYBRy6Kv1N914TF6y+1g3L306IPZkO
 iXZbircMdQDUwU3YI14RxZ0UET5/pZZo+EbSR2gne00bU5eZ6S+c4jBDwdP/3dofskGW
 mwGs0dkvVqxhqT/hH3BI9J4LRYM4w9G55YQp3iqOA/fu1gmE03+aJGociZxMznW2I9pQ
 AXCA==
X-Gm-Message-State: AOJu0Yx3nQpCyiJXzCzq/Mu/ELOhu9WNHU+r+f6zra1y+wpNdmB91trp
 wb0D4sSHWnCjoJ5OrM04r964hjSGeUxehT3PlseUj3AUYLA+VrOrecmN6/mPH8lqAW10sJRenjA
 RhASLS2l39+B41FwI3Rf86XDymyrMqIDd+UueOXmHaL3Kavdneb5KOjJzJJx5KmFysk2V
X-Received: by 2002:adf:f243:0:b0:337:cdc5:daf4 with SMTP id
 b3-20020adff243000000b00337cdc5daf4mr3549855wrp.9.1706035393570; 
 Tue, 23 Jan 2024 10:43:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhLhrfATAl+MbUI9CG7wf9yl5VnYt7D1KtWSc4Uw3hcCY/iekiY5zgW3rbp/1ejbrfypYWjg==
X-Received: by 2002:adf:f243:0:b0:337:cdc5:daf4 with SMTP id
 b3-20020adff243000000b00337cdc5daf4mr3549842wrp.9.1706035393317; 
 Tue, 23 Jan 2024 10:43:13 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a5d6ac9000000b00337d392c6c3sm14180252wrw.13.2024.01.23.10.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 10:43:12 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 3/4] target/riscv: SMBIOS support for RISC-V virt machine
Date: Tue, 23 Jan 2024 19:42:28 +0100
Message-ID: <20240123184229.10415-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
References: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Generate SMBIOS tables for the RISC-V mach-virt.
Add CONFIG_SMBIOS=y to the RISC-V default config.
Set the default processor family in the type 4 table.

The implementation is based on the corresponding ARM and Loongson code.

With the patch the following firmware tables are provided:

    etc/smbios/smbios-anchor
    etc/smbios/smbios-tables

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	remove a superfluous #ifdef
v3:
	use misa_mxl_max to determine bitness
v2:
	set processor family
---
 hw/riscv/Kconfig |  1 +
 hw/riscv/virt.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

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
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f9fd1341fc..1b333af4f0 100644
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
@@ -1263,6 +1264,45 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
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
@@ -1351,6 +1393,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
         riscv_setup_direct_kernel(kernel_entry, fdt_load_addr);
     }
 
+    virt_build_smbios(s);
+
     if (virt_is_acpi_enabled(s)) {
         virt_acpi_setup(s);
     }
-- 
2.43.0


