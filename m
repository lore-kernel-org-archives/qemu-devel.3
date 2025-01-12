Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1869DE7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6KM-0004Wy-1B; Sun, 12 Jan 2025 17:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KI-0004TW-MP
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:58 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KG-0006sb-J8
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:58 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so1904494f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720455; x=1737325255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PY2xzaJd4C4roXkkRjiU6ex9RApXwoXOgYcP70nq+ss=;
 b=sGXUVGBWgWMVrDfOwzXmrax/Gfq/xRUB9TLlQnT9nuYngPlv8rKPyjoi4zehciyjuj
 TUKJzRHJvSr0pnd1NMX46V24bFC57FaCFKD/eiF03GhHlPlwrJ4EZ97T8C5Vj/U9fKMv
 LOVwnzZco5TRgEeMsVtlPFn1b2awfiigVMLU3FnKtIE1rGL9z5TL+oG8556yQ4G5sb4K
 snCPyVbFqKrc2RPvYIqcsokN3mX7BRKFTNew3qNxw7Dpwz3Ng1vQMV8EhdSBOQfvkwyy
 0vWoaRIVImgORirzhw7B1pAO+iT9wbenkwVmRTQSg7hCvucakM9PDia7rHGEs1+42s/L
 QBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720455; x=1737325255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PY2xzaJd4C4roXkkRjiU6ex9RApXwoXOgYcP70nq+ss=;
 b=ZnSP7GKFu9ah3uO4xcIa72BaTq70OQhLqc6V0jL9Oibkt1x9tWgBHQ5+f63b+II5p1
 WYASD0WjEFcbALVXT/1shs+prMIimiNoBisFE/FLPuHcxnYqfzh3p7x5tH3AXosSCmtO
 dUSQXI9ePnIacv9Q95lR3CG4EgSiI0Ndrspu8BhDoV9OZxa77DcsEgxFAv5cexzr3gQb
 7jvmz7gFRhAW0q94pcvxNRVO/ZgLn2lUOO7D2TN6ZKbVUyRuiQKg+aP46+EIEZdoVfPp
 eAzDssuZkyvAm4ssTTbR/iAR3xoRTIT9Bt5YVCEGUxfZQhfKeWljS1fhJZejfzw22Vlw
 iA2A==
X-Gm-Message-State: AOJu0Yy4fq0rl3wjoY+i+0OEdAr7KdSilSH88a1FYa5i7Yx6ggLyWyvv
 RYkxdgyO9Oqckfveu02BOi4yHIJ6WzKLDi+0khGoHO2g0aLpmmcUoWRsWv0bESE0ZNrj/QjH8Te
 axEE=
X-Gm-Gg: ASbGncu+cC9UxJth3J+KiRqflH6DsgkoRwy5xBsI23mQaQi0cI1lnF5qQ8jQ/3rtfV0
 y95KQRAkb1laKVcydFzNUjQ4gVEBbKPslfr3n2IHfOZpZJ+gzQ2FIjWl2X6m6PIjgxbvBkab62k
 gOVMiARO5LpjsMhVIUGDBIgUIAu5c/RXdo+VWD3d+6FKEXfJIgv6AoH2XOP8H06xB/YCY70Hzvk
 xdTzVJAupHeQ345W9ytwlLDnvXudiRHzjmn6QgVTwEHH4Pvdolu4VBbLa8ume56DjEp7ghA5rX8
 UZpWRZt8TyQs6z5DYB7cWvHfEgTyaU0=
X-Google-Smtp-Source: AGHT+IEdqNqqfGIbCFfHG33qyK/9EffB2uSlrWlHZRajNdQJ2/84F+LicaL5/AL7/5Nzxr5JNrhRkg==
X-Received: by 2002:a5d:47a3:0:b0:38a:4184:2510 with SMTP id
 ffacd0b85a97d-38a872db629mr18532819f8f.23.1736720454772; 
 Sun, 12 Jan 2025 14:20:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm10782722f8f.39.2025.01.12.14.20.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/49] hw/loongarch/virt: Checkpatch cleanup
Date: Sun, 12 Jan 2025 23:17:18 +0100
Message-ID: <20250112221726.30206-43-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Code cleanup with directory hw/loongarch/, removing errors from
command "scripts/checkpatch.pl hw/loongarch/*"

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250103064514.2660438-1-maobibo@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/loongarch/acpi-build.c | 3 ++-
 hw/loongarch/boot.c       | 4 ++--
 hw/loongarch/virt.c       | 8 +++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 9eb5fb68bff..fdd62acf7e9 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -456,8 +456,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
-    for (i = 0; i < VIRT_UART_COUNT; i++)
+    for (i = 0; i < VIRT_UART_COUNT; i++) {
         build_uart_device_aml(dsdt, i);
+    }
     build_pci_device_aml(dsdt, lvms);
     build_la_ged_aml(dsdt, machine);
     build_flash_aml(dsdt, lvms);
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 241c0eef1f0..bd8763c61c3 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -292,7 +292,7 @@ static void reset_load_elf(void *opaque)
 
     cpu_reset(CPU(cpu));
     if (env->load_elf) {
-	if (cpu == LOONGARCH_CPU(first_cpu)) {
+        if (cpu == LOONGARCH_CPU(first_cpu)) {
             env->gpr[4] = env->boot_info->a0;
             env->gpr[5] = env->boot_info->a1;
             env->gpr[6] = env->boot_info->a2;
@@ -354,7 +354,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
     if (info->kernel_filename) {
         kernel_addr = load_kernel_info(info);
     } else {
-        if(!qtest_enabled()) {
+        if (!qtest_enabled()) {
             warn_report("No kernel provided, booting from flash drive.");
         }
     }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index df56d75a6e7..db37ed6a717 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -331,8 +331,9 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
     qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "ns16550a");
     qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0, base, 0x0, size);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clock-frequency", 100000000);
-    if (chosen)
+    if (chosen) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
+    }
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
@@ -815,7 +816,7 @@ static void virt_devices_init(DeviceState *pch_pic,
      * Create uart fdt node in reverse order so that they appear
      * in the finished device tree lowest address first
      */
-    for (i = VIRT_UART_COUNT; i --> 0;) {
+    for (i = VIRT_UART_COUNT; i-- > 0;) {
         hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
         int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
         serial_mm_init(get_system_memory(), base, 0,
@@ -1175,8 +1176,9 @@ static void fw_cfg_add_memory(MachineState *ms)
         size = ram_size - numa_info[0].node_mem;
     }
 
-   if (size)
+    if (size) {
         memmap_add_entry(base, size, 1);
+    }
 }
 
 static void virt_init(MachineState *machine)
-- 
2.47.1


