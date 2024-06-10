Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E71FC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhoI-000474-Gn; Mon, 10 Jun 2024 12:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGhoG-00045v-8K
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:23:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGhoC-0005lF-M7
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:23:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42189d3c7efso12748235e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718036627; x=1718641427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=51rpOCPyyqijxNaq+plifSaYwuIzh/Wia3WOiDOVjbI=;
 b=KlWzzFF/Xgn4UC7iTfBr0j6Tr1PBA/sA5iNczDKeTHp65jcc6pg2dHdAPp6KKw7DJL
 5vwFjmYPbgo9re/PIj6ce4e6Yt4LFJwj+q8ugtlwuMOkdH4RoDoFKvjIIj/X22DNMaRt
 tj/pDMPb13pZlhfTq8BsklOiNUZ5WawVNMIIpOBnxJm+XAir6m4b0T2bfiQ9Ks5YSeRM
 tD0VRTJXxGEoFwCM4qMnnmfHQ0EFAD6okdM7jSDkZ6OflIBXweStx/TvYzk+hGOcirWT
 GPw3WPdtKqrDQiV8QKQ97K2MTb4tepHmHorcU/0i8ve3/aWALEqxuv1X5v/XKR0UW3Ha
 SFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718036627; x=1718641427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51rpOCPyyqijxNaq+plifSaYwuIzh/Wia3WOiDOVjbI=;
 b=efe23Z3pHLQLffMkzbaoj3vFbijsnz7uIKDX3gBp/qrwIhk8WvQ/Omf4iowiKsMymP
 oqTQSCC6O1XYurJlChZxRf/tLDKwYl4y0PuWdXxmJy1za1My8Rt0CVLzpWh90hHO0GgP
 PZX1hRQAPJENOthp9PuV2t5PFd8lL7mx0g/Ex3EsaUhD1e8Dmo9gnA9oEA3BkLpLZ53s
 5LroyV4hXGogUUnWzUN6zFfyWOsYnH0zJEDKrKu5vW0T+oQZAyMFt3uw4qDimEyPZHhl
 giZzaRphDqmVMo1xqKuw5ScqvYFaU7VKteFZQXydUAFb9W7kdwyCyiNbp3/KklQN6zJ0
 E9Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXudjtJ74p20HNgzPoTsJj/Pd9lX3J9dWw36YzJmrwtU2CU/FBos5a+LKWszFYwlxzdJPAdcGxkblT7+sCb+hlmTRt+E7A=
X-Gm-Message-State: AOJu0Yx2L+QbA2GjXDLLRYftv3ZmHlkcXBBp36xkoVNAark8oWGG1TX5
 0WkxG/rA4Rx5KPgtXf9kO1nF190Xk1I0miDiYFx3MQkkKWKgFe377mx/1yR9pHw=
X-Google-Smtp-Source: AGHT+IEIJlTr0u2MZXSxkl3a9TL7Lm8/kX2GrxUFvvbicerOk1qAlaa/YaKc/meHB1uz2DcojoCWUA==
X-Received: by 2002:a05:600c:314a:b0:422:1a82:3ed2 with SMTP id
 5b1f17b1804b1-4221a8245ccmr11939475e9.27.1718036627150; 
 Mon, 10 Jun 2024 09:23:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a6225sm147250405e9.25.2024.06.10.09.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:23:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/arm/virt: allow creation of a second NonSecure UART
Date: Mon, 10 Jun 2024 17:23:43 +0100
Message-Id: <20240610162343.2131524-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610162343.2131524-1-peter.maydell@linaro.org>
References: <20240610162343.2131524-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

For some use-cases, it is helpful to have more than one UART
available to the guest.  If the second UART slot is not already used
for a TrustZone Secure-World-only UART, create it as a NonSecure UART
only when the user provides a serial backend (e.g.  via a second
-serial command line option).

This avoids problems where existing guest software only expects a
single UART, and gets confused by the second UART in the DTB.  The
major example of this is older EDK2 firmware, which will send the
GRUB bootloader output to UART1 and the guest serial output to UART0.
Users who want to use both UARTs with a guest setup including EDK2
are advised to update to EDK2 release edk2-stable202311 or newer.
(The prebuilt EDK2 blobs QEMU upstream provides are new enough.)
The relevant EDK2 changes are the ones described here:
https://bugzilla.tianocore.org/show_bug.cgi?id=4577

Inspired-by: Axel Heider <axel.heider@hensoldt.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
 docs/system/arm/virt.rst |  6 +++++-
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt-acpi-build.c | 12 ++++++++----
 hw/arm/virt.c            | 38 +++++++++++++++++++++++++++++++++++---
 4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 26fcba00b76..e67e7f0f7c5 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -26,7 +26,7 @@ The virt board supports:
 
 - PCI/PCIe devices
 - Flash memory
-- One PL011 UART
+- Either one or two PL011 UARTs for the NonSecure World
 - An RTC
 - The fw_cfg device that allows a guest to obtain data from QEMU
 - A PL061 GPIO controller
@@ -48,6 +48,10 @@ The virt board supports:
   - A secure flash memory
   - 16MB of secure RAM
 
+The second NonSecure UART only exists if a backend is configured
+explicitly (e.g. with a second -serial command line option) and
+TrustZone emulation is not enabled.
+
 Supported guest CPU types:
 
 - ``cortex-a7`` (32-bit)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 1227e7f7f08..ab961bb6a9b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -151,6 +151,7 @@ struct VirtMachineState {
     bool ras;
     bool mte;
     bool dtb_randomness;
+    bool second_ns_uart_present;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index eb5796e309b..b2366f24f96 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -79,11 +79,11 @@ static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
 }
 
 static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
-                                           uint32_t uart_irq)
+                               uint32_t uart_irq, int uartidx)
 {
-    Aml *dev = aml_device("COM0");
+    Aml *dev = aml_device("COM%d", uartidx);
     aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0011")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(uartidx)));
 
     Aml *crs = aml_resource_template();
     aml_append(crs, aml_memory32_fixed(uart_memmap->base,
@@ -817,7 +817,11 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, vms);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
-                       (irqmap[VIRT_UART0] + ARM_SPI_BASE));
+                       (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
+    if (vms->second_ns_uart_present) {
+        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
+                           (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
+    }
     if (vmc->acpi_expose_flash) {
         acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 920a9db22f2..5028af8eb56 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -906,7 +906,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 }
 
 static void create_uart(const VirtMachineState *vms, int uart,
-                        MemoryRegion *mem, Chardev *chr)
+                        MemoryRegion *mem, Chardev *chr, bool secure)
 {
     char *nodename;
     hwaddr base = vms->memmap[uart].base;
@@ -944,6 +944,8 @@ static void create_uart(const VirtMachineState *vms, int uart,
         qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
     } else {
         qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial1", nodename);
+    }
+    if (secure) {
         /* Mark as not usable by the normal world */
         qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
         qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
@@ -2318,11 +2320,41 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0));
+    /*
+     * The first UART always exists. If the security extensions are
+     * enabled, the second UART also always exists. Otherwise, it only exists
+     * if a backend is configured explicitly via '-serial <backend>'.
+     * This avoids potentially breaking existing user setups that expect
+     * only one NonSecure UART to be present (for instance, older EDK2
+     * binaries).
+     *
+     * The nodes end up in the DTB in reverse order of creation, so we must
+     * create UART0 last to ensure it appears as the first node in the DTB,
+     * for compatibility with guest software that just iterates through the
+     * DTB to find the first UART, as older versions of EDK2 do.
+     * DTB readers that follow the spec, as Linux does, should honour the
+     * aliases node information and /chosen/stdout-path regardless of
+     * the order that nodes appear in the DTB.
+     *
+     * For similar back-compatibility reasons, if UART1 is the secure UART
+     * we create it second (and so it appears first in the DTB), because
+     * that's what QEMU has always done.
+     */
+    if (!vms->secure) {
+        Chardev *serial1 = serial_hd(1);
+
+        if (serial1) {
+            vms->second_ns_uart_present = true;
+            create_uart(vms, VIRT_UART1, sysmem, serial1, false);
+        }
+    }
+    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0), false);
+    if (vms->secure) {
+        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1), true);
+    }
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem, secure_tag_sysmem);
-        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1));
     }
 
     if (tag_sysmem) {
-- 
2.34.1


