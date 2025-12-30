Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916B8EE57C2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagx6-0004Z1-HR; Tue, 30 Dec 2025 16:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagx4-0004YR-HV
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:22 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagx2-0002CV-Pi
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:22 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43277900fb4so1809420f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128899; x=1767733699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lzRXwIe1Jc8ddqbcAemZlDpnfBq+V4MD5nODk/G3BH4=;
 b=DaLd8VRUHHQtlYjjES4hB66egx9o/GsGpQrDC8HrCUXqlgLXzPNnkZghcRHQiDxm6n
 bQGD3a6gi4YgMisT2NoUCT0iRvTjmorhOKEwSabCqHQwXp/ZFDFi9RmXmlD5LodNmuE2
 sMoN0XSf8XwUa8xBOAnHe/fNcWcOo8DaNCbzzOn3q46JG1DJ7M1pG04wVXv8TFzoJYmD
 hVQup3EWoUpCHF1p5DAKprsKBwyLTfgC7hZmE92IFfWRTREWn8dk3f2LOlJCE2o4e+gd
 RT7bk4ol1wMNadwLUG3j6tNOB06k0/lqlkVHfTT76CCX/Ck7r8MSWSnT6h8OfjXT+RG1
 k8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128899; x=1767733699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lzRXwIe1Jc8ddqbcAemZlDpnfBq+V4MD5nODk/G3BH4=;
 b=ma3hOknKQnSTllDlVDLci2++9D8hb2vXiHz41Unhd2l5B3+9iwCGROwcWtI/KUcRda
 OunwrTQ2xu9aZy0jyJmCiPEzT+1UhmGHEsdyYZPS9GvtQk3RzHhpwbCAK71vx9Yzv8uD
 t/6eZfiN/nSMrLz0PVobDXvwaMTGveu+5bM/nQkYjrhUGTXsKmLCTYTpVNSqwkNc/E8Z
 MODOGiJwhUQ0u20jddzw2bYB1OQhoJ7sl92Ug8ewytQ5ZgMO2w+gFxZzL18b+cjg3fOj
 a07c4dOoGCKVzZ2F5jzwHi0dqjFD0Vf+RUBH/ZhSRUtatIKjN7ZFTAdU+oD10CNWZ2/b
 Mpwg==
X-Gm-Message-State: AOJu0Yx1SAGrbCbO/QCGe2LSlX6WKUKf83g8t4Xaw0dGaCPOWHN89KyQ
 xQL/VfBTD6KMMLq1V5zdhUx+MgyjFG3AN10KIlXFusblRxeERQpKoTmU8KrIav2LKHuQwnjPZla
 Q8BDRKaU=
X-Gm-Gg: AY/fxX4YNUczXZThSw0Ohi76em0h4QARG9Y9ENyb3tLVNwKEi65rkUyVXngHmYqhytu
 Roez2oQLwNG8TA8JF2+r3GNi1+WivjSkkBWit4Fco0/EI32Z/s5VaS8NPXFlJG/nIQ/R6E8fc2J
 IfcoQjbQ/vNLJqEpAJmAjATrAF6V0mtt4OeXlBmUR+kZdKCMhkYZR//odP4ulk9KeGxpbjGMg9b
 JLaYIhAEo+SAC4fOVTZbyEJpVOQMe20EiUpSJ+J/IBMqL6+cdmQWXDa8EpuDb7uc4KyR/tYieRN
 eM3pSQ6600yGzTZ/pyQX/mHEnt3E9hTiYYbqVMxaJK7IJRZU0xExa6hZGZyNI8k9BgVfAWxbBQd
 Thmdax/FZgaR79e0yGTLvGWszQukjZrrpunSgNMweF9FRur2gpQ4pEuVmkg9S+7KcjGacs7YmvG
 ZsSYmeVZCkrAWhOQQjpvdjPrOGzvZBbJPraUs1aA3JBD6KAFoA5rIqULPxAAP8
X-Google-Smtp-Source: AGHT+IEbx5oTGr66BMSxHkLtY0pp53PGAt32kN+7qD1+O64wUPZb/QSL9bPpjAi96EJxhd22sGdrNg==
X-Received: by 2002:a5d:64e9:0:b0:431:382:f141 with SMTP id
 ffacd0b85a97d-4324e3f5da3mr53342152f8f.12.1767128898771; 
 Tue, 30 Dec 2025 13:08:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1af2bsm70137622f8f.1.2025.12.30.13.08.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/34] hw/riscv: Treat kernel_start_addr as vaddr
Date: Tue, 30 Dec 2025 22:07:25 +0100
Message-ID: <20251230210757.13803-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Anton Johansson <anjo@rev.ng>

Changes kernel_start_addr from target_ulong to vaddr. Logically, the
argument represents a virtual address at which to load the kernel image,
which gets treated as a hwaddr as a fallback if elf and uimage loading
fails.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251210132130.14465-1-anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/boot.h    | 6 +++---
 hw/riscv/boot.c            | 6 +++---
 hw/riscv/microchip_pfsoc.c | 3 ++-
 hw/riscv/sifive_u.c        | 3 ++-
 hw/riscv/spike.c           | 2 +-
 hw/riscv/virt.c            | 3 ++-
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 35964bf8318..f00b3ca1224 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -43,8 +43,8 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
-hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                    hwaddr firmware_end_addr);
+vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                   hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
@@ -57,7 +57,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
                            symbol_fn_t sym_cb);
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
-                       target_ulong kernel_start_addr,
+                       vaddr kernel_start_addr,
                        bool load_initrd,
                        symbol_fn_t sym_cb);
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index df1f3abd171..e5490beda00 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -74,8 +74,8 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
     info->is_32bit = riscv_is_32bit(harts);
 }
 
-hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                    hwaddr firmware_end_addr) {
+vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                   hwaddr firmware_end_addr) {
     if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
     } else {
@@ -228,7 +228,7 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
-                       target_ulong kernel_start_addr,
+                       vaddr kernel_start_addr,
                        bool load_initrd,
                        symbol_fn_t sym_cb)
 {
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 0cf849ffb6d..4ff83e49403 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -521,7 +521,8 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     uint64_t mem_low_size, mem_high_size;
     hwaddr firmware_load_addr;
     const char *firmware_name;
-    hwaddr firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr;
+    vaddr kernel_start_addr;
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f1b47ab5848..7ec67b25651 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -515,7 +515,8 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     hwaddr start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
-    hwaddr firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr;
+    vaddr kernel_start_addr;
     const char *firmware_name;
     uint32_t start_addr_hi32 = 0x00000000;
     uint32_t fdt_load_addr_hi32 = 0x00000000;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index ea527c7bfc1..1493b928dad 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -199,7 +199,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     hwaddr firmware_end_addr = memmap[SPIKE_DRAM].base;
     hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
-    hwaddr kernel_start_addr;
+    vaddr kernel_start_addr;
     char *firmware_name;
     uint64_t fdt_load_addr;
     uint64_t kernel_entry;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c87c169d38c..bd8608ea5bf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1434,7 +1434,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                      machine_done);
     MachineState *machine = MACHINE(s);
     hwaddr start_addr = s->memmap[VIRT_DRAM].base;
-    hwaddr firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr;
+    vaddr kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint64_t fdt_load_addr;
     uint64_t kernel_entry = 0;
-- 
2.52.0


