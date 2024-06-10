Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465C2C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhoI-000479-Oy; Mon, 10 Jun 2024 12:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGhoE-000450-Rq
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:23:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGhoC-0005l9-6N
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:23:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42133f8432aso1160905e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718036627; x=1718641427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Imr1z9bfFUSXc72Pq5zm13hYL6VZ46pb0N02MSoc4g=;
 b=a1gfukT98Bk9or3OzDi9vbeE3IOSOeecpWveHG4rt3l9tM/tQRVFMQQq29m4KehIui
 22EVihlguUc7Ny7O3lqKp7RrS3A9CszkUPnjgHL6f7q7wlNhj9zHO2Ds3++MT+I+2wsB
 ODIF4/lxlb3gdppFpC0Gs39tOBRkvB6SNfcwg1hHOoPhtdQbcjxBxuVMLHJ+1U3AqmpG
 ZxjawH8bL0YQ4PAPdvHvZvwi/3l+DBxopNLEaHNbl/8tSCp6zwTQWANpl24oVJ29BDSM
 wi8wX3LmH0pnM1cY3dldrCrJdpocz9In51NafhdXwavJownl70AeYLGeyXTJR/izanZI
 xGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718036627; x=1718641427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Imr1z9bfFUSXc72Pq5zm13hYL6VZ46pb0N02MSoc4g=;
 b=CIXsnUTflt4fxhzoQhHfzaez73WHLAK1zoyvbm9BmkgG4zsNXEL/Fs/QnkLFQ/vLWV
 VpE/dpkp+OFD36iiK9eDk27Kg2Zcv95L9DI3aWrAYvdj2/9X+sjuxpggVSCbBAYv2D2f
 63iBJD2TyfdQTNknFttP1SBHpzp+oE1TuwWq1gHJ7Xt7ThtpAflGnPrpb/593MgISbyu
 mbGxKP5SMiB4cTkUdfHn/KG01Qr2nt/9wE5Vnio1Fe1mZcKvShF+/jeJrqujIajy62St
 A6J250YqURkfiqJfibiP440wG+01/J8wB1NacCaI1GgEJVy5/ADm/ddsViXPBjRIMRVi
 MvUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOam0rXV0J5/XgHskHeAYOCXSZOQYBcpZ/JrfHqpTn2ixpLAdt+4PQUpU8KBIhytLVyk3T2JmpzJyfsNV5LegzRgSf/e8=
X-Gm-Message-State: AOJu0YztNxJTaicM8cV5Mm2zorhqVPub33xdvGeMSQOR8W3TYctiJCk9
 SXeQf+AvyEL3gTljEbcQWl/T5kF4AusFfGNh5s0BqUDXqQKsXlf1ZquhYCOf52mSfUvOkGl8Bz8
 h
X-Google-Smtp-Source: AGHT+IE2TIv+oEgSAyM6P1lUm4tI8zotWB02zbA9aEPu6fcLjPSfM+d6glXmOaruxTIE2w1PGCwiyQ==
X-Received: by 2002:a05:600c:4752:b0:421:182d:9232 with SMTP id
 5b1f17b1804b1-42164a031c2mr88763325e9.18.1718036626656; 
 Mon, 10 Jun 2024 09:23:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a6225sm147250405e9.25.2024.06.10.09.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:23:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/arm/virt: Rename VIRT_UART and VIRT_SECURE_UART to
 VIRT_UART[01]
Date: Mon, 10 Jun 2024 17:23:42 +0100
Message-Id: <20240610162343.2131524-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610162343.2131524-1-peter.maydell@linaro.org>
References: <20240610162343.2131524-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

We're going to make the second UART not always a secure-only device.
Rename the constants VIRT_UART and VIRT_SECURE_UART to VIRT_UART0
and VIRT_UART1 accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h    |  4 ++--
 hw/arm/virt-acpi-build.c | 12 ++++++------
 hw/arm/virt.c            | 14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index bb486d36b14..1227e7f7f08 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -59,7 +59,7 @@ enum {
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
     VIRT_SMMU,
-    VIRT_UART,
+    VIRT_UART0,
     VIRT_MMIO,
     VIRT_RTC,
     VIRT_FW_CFG,
@@ -69,7 +69,7 @@ enum {
     VIRT_PCIE_ECAM,
     VIRT_PLATFORM_BUS,
     VIRT_GPIO,
-    VIRT_SECURE_UART,
+    VIRT_UART1,
     VIRT_SECURE_MEM,
     VIRT_SECURE_GPIO,
     VIRT_PCDIMM_ACPI,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c3ccfef026f..eb5796e309b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -440,10 +440,10 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         .base_addr.width = 32,
         .base_addr.offset = 0,
         .base_addr.size = 3,
-        .base_addr.addr = vms->memmap[VIRT_UART].base,
+        .base_addr.addr = vms->memmap[VIRT_UART0].base,
         .interrupt_type = (1 << 3),/* Bit[3] ARMH GIC interrupt*/
         .pc_interrupt = 0,         /* IRQ */
-        .interrupt = (vms->irqmap[VIRT_UART] + ARM_SPI_BASE),
+        .interrupt = (vms->irqmap[VIRT_UART0] + ARM_SPI_BASE),
         .baud_rate = 3,            /* 9600 */
         .parity = 0,               /* No Parity */
         .stop_bits = 1,            /* 1 Stop bit */
@@ -631,11 +631,11 @@ build_dbg2(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     /* BaseAddressRegister[] */
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 3,
-                     vms->memmap[VIRT_UART].base);
+                     vms->memmap[VIRT_UART0].base);
 
     /* AddressSize[] */
     build_append_int_noprefix(table_data,
-                              vms->memmap[VIRT_UART].size, 4);
+                              vms->memmap[VIRT_UART0].size, 4);
 
     /* NamespaceString[] */
     g_array_append_vals(table_data, name, namespace_length);
@@ -816,8 +816,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      */
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, vms);
-    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
-                       (irqmap[VIRT_UART] + ARM_SPI_BASE));
+    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
+                       (irqmap[VIRT_UART0] + ARM_SPI_BASE));
     if (vmc->acpi_expose_flash) {
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0c1dab67c00..920a9db22f2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -165,11 +165,11 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
     /* This redistributor space allows up to 2*64kB*123 CPUs */
     [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
-    [VIRT_UART] =               { 0x09000000, 0x00001000 },
+    [VIRT_UART0] =              { 0x09000000, 0x00001000 },
     [VIRT_RTC] =                { 0x09010000, 0x00001000 },
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
-    [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
+    [VIRT_UART1] =              { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
     [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
@@ -212,11 +212,11 @@ static MemMapEntry extended_memmap[] = {
 };
 
 static const int a15irqmap[] = {
-    [VIRT_UART] = 1,
+    [VIRT_UART0] = 1,
     [VIRT_RTC] = 2,
     [VIRT_PCIE] = 3, /* ... to 6 */
     [VIRT_GPIO] = 7,
-    [VIRT_SECURE_UART] = 8,
+    [VIRT_UART1] = 8,
     [VIRT_ACPI_GED] = 9,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
@@ -939,7 +939,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     qemu_fdt_setprop(ms->fdt, nodename, "clock-names",
                          clocknames, sizeof(clocknames));
 
-    if (uart == VIRT_UART) {
+    if (uart == VIRT_UART0) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
         qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
     } else {
@@ -2318,11 +2318,11 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
+    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0));
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem, secure_tag_sysmem);
-        create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1));
     }
 
     if (tag_sysmem) {
-- 
2.34.1


