Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B567AFD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO5m-0004km-5N; Wed, 25 Feb 2026 18:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5k-0004kQ-6n
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:52 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5h-0002Zp-HU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:51 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso2362885e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061287; x=1772666087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sAQRekBqnyK/EC0T/BHUhyfWFZckIqsnxlQCebdjSa8=;
 b=ZJA8eH2Lh02gppzykXb8ATfNmaNv4txeCWYsFYc6kl3SUPzCP9Eq5lyUNM/C0nvYlr
 BuT6mZBSKOiddV7bRefZRX+zdcxTdHNKQESfu3SyTubsJGGTEa+sgt9nCu6CmhjgR2ht
 FEvZ7SSFLqTB9Bd8G5qJw+JwZszFMPCe5P+Bn/uukb2vMRRqOV03gqx49POCxKs9feax
 Te4o6w/sKzSmCffLtvz5z49vRvvElotqIF3xzy/ip/ncJPooEddgsfzruqhzO/Ujxc1I
 3TfyyTl3w45W8pmDKACywDfGqtR7z6pIyxeO8t4uanAD+fK4IsEpHHQZVU/GH/u5Vg9s
 lZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061287; x=1772666087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sAQRekBqnyK/EC0T/BHUhyfWFZckIqsnxlQCebdjSa8=;
 b=XRhP3HyxvVKTy4Fh997G7pTZ2bo/Aw4eeIoM+68VuTB9aQ4wS+Ahdqyq+C+hOlZM1G
 /0akK0P6x9fzaiEFrFEKumrbxZdeZr6R8b+1PLNlHYL0jRFW29D71u2u0ScLF2BYbPpY
 MbF0mJSvUNuORi2AljYujmmwe3DELgQVnMg0KbFOHmxIQ3q2u3uPP/DHPjTPq5bhmRVc
 3/1CIVGY+ysc8eubhi7fLW8YC3UtBIdXVol0WQNyiDeTXQtuTu4SjRljbS2mhyoUhAcf
 q17YDIC7vli1NfpAiF7W6kZE3KC1Hta9UW7QAQ5/TcIjgBsingtqRWXRrofFAXo8IzDD
 biNg==
X-Gm-Message-State: AOJu0Yx3RUyl/OVPF86YwAIrndtZdTChpfLCAlQ++iOw0AJpiwph91aH
 Qpgc7GMzXPsRquk7SbfiWRIcbh+L63YywCr+lTGHyPwvfDpBGsWn2ox2ddMnQag/FiKU/m/G5l8
 HCVr4VS8=
X-Gm-Gg: ATEYQzxAoFBYmsb3Cb/pNPg4cDn7a3mynjEL4l7rX7+P58htef/SCYvfepHuC1dbtQm
 T1//A9B94y6O4gbEBJzIa+neIGH40q70iodIZpkCP3wOlwq07LO3UlNxKO4MJR2ofVfZ1FtegHh
 fNQJok4EnMjfjby/kUbFN97MDA2exWjpB/27gOj13hAc4CX1Vl9kTc4LDI745bCdFsAHP2+D8SD
 uGuRDT90Pu6FCb/9DM3sQ35kZI/d/RRK6nzToeTJFYbSBh/a2Kqshx3hxxg5OCB8uMt9JSTyhEq
 lxPyCfMsyjVXZ0rc/MoN5jb5FBb0/jUDC+P1KgsvTbdgci+TXPbCSCDeYySLzBvIAd4szniRW5n
 6fnDlsBvL19Um9FwEvKMyhh2c+obyS8T1+lQtlewr5JG3mFEfu51i7KRWv18TBTvZM2tTIEMT4P
 W4uAcX6QoXF9R87fq3eqxOzIX4uBgFec/qjyHoiyteU2uAnlOwXvzh9nTYABkfp5KGuuXtljkV
X-Received: by 2002:a05:600c:a009:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-483c3df5a16mr954445e9.29.1772061287554; 
 Wed, 25 Feb 2026 15:14:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e692sm98330635e9.7.2026.02.25.15.14.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:14:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/70] hw/loongarch: Use loongarch_palen_mask()
Date: Thu, 26 Feb 2026 00:13:05 +0100
Message-ID: <20260225231411.96482-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Replaces remaining uses of TARGET_PHYS_ADDR_SPACE_BITS with
runtime calls to loongarch_palen_mask() to fetch the physical
address mask from the cpucfg PALEN field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260218-phys_addr-v6-5-a603bf363218@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loongarch/boot.h |  3 ++-
 hw/loongarch/boot.c         | 28 ++++++++++++++++------------
 hw/loongarch/virt.c         |  5 ++++-
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 9819f7fbe30..4984322f75e 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -113,6 +113,7 @@ struct memmap_entry {
     uint32_t reserved;
 };
 
-void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
+void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info,
+                           uint64_t phys_addr_mask);
 
 #endif /* HW_LOONGARCH_BOOT_H */
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 711d5ffbbc0..ef8eae237cb 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -217,10 +217,12 @@ static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
 
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
-    return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
+    uint64_t *phys_addr_mask = opaque;
+    return addr & *phys_addr_mask;
 }
 
 static int64_t load_loongarch_linux_image(const char *filename,
+                                          uint64_t phys_addr_mask,
                                           uint64_t *kernel_entry,
                                           uint64_t *kernel_low,
                                           uint64_t *kernel_high)
@@ -251,10 +253,8 @@ static int64_t load_loongarch_linux_image(const char *filename,
     }
 
     /* Early kernel versions may have those fields in virtual address */
-    *kernel_entry = extract64(le64_to_cpu(hdr->kernel_entry),
-                              0, TARGET_PHYS_ADDR_SPACE_BITS);
-    *kernel_low = extract64(le64_to_cpu(hdr->load_offset),
-                            0, TARGET_PHYS_ADDR_SPACE_BITS);
+    *kernel_entry = le64_to_cpu(hdr->kernel_entry) & phys_addr_mask;
+    *kernel_low = le64_to_cpu(hdr->load_offset) & phys_addr_mask;
     *kernel_high = *kernel_low + size;
 
     rom_add_blob_fixed(filename, buffer, size, *kernel_low);
@@ -303,19 +303,21 @@ static ram_addr_t alloc_initrd_memory(struct loongarch_boot_info *info,
     exit(1);
 }
 
-static int64_t load_kernel_info(struct loongarch_boot_info *info)
+static int64_t load_kernel_info(struct loongarch_boot_info *info,
+                                uint64_t phys_addr_mask)
 {
     uint64_t kernel_entry, kernel_low, kernel_high, initrd_offset = 0;
     ssize_t kernel_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
-                           cpu_loongarch_virt_to_phys, NULL,
+                           cpu_loongarch_virt_to_phys, &phys_addr_mask,
                            &kernel_entry, &kernel_low,
                            &kernel_high, NULL, ELFDATA2LSB,
                            EM_LOONGARCH, 1, 0);
-    kernel_entry = cpu_loongarch_virt_to_phys(NULL, kernel_entry);
+    kernel_entry = cpu_loongarch_virt_to_phys(&phys_addr_mask, kernel_entry);
     if (kernel_size < 0) {
         kernel_size = load_loongarch_linux_image(info->kernel_filename,
+                                                 phys_addr_mask,
                                                  &kernel_entry, &kernel_low,
                                                  &kernel_high);
     }
@@ -395,14 +397,15 @@ static void init_boot_rom(MachineState *ms,
 }
 
 static void loongarch_direct_kernel_boot(MachineState *ms,
-                                         struct loongarch_boot_info *info)
+                                         struct loongarch_boot_info *info,
+                                         uint64_t phys_addr_mask)
 {
     void *p, *bp;
     int64_t kernel_addr = VIRT_FLASH0_BASE;
     uint64_t *data;
 
     if (info->kernel_filename) {
-        kernel_addr = load_kernel_info(info);
+        kernel_addr = load_kernel_info(info, phys_addr_mask);
     } else {
         if (!qtest_enabled()) {
             warn_report("No kernel provided, booting from flash drive.");
@@ -429,7 +432,8 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
     g_free(bp);
 }
 
-void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
+void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info,
+                           uint64_t phys_addr_mask)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
 
@@ -440,6 +444,6 @@ void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
     if (lvms->bios_loaded) {
         loongarch_firmware_boot(lvms, info);
     } else {
-        loongarch_direct_kernel_boot(ms, info);
+        loongarch_direct_kernel_boot(ms, info, phys_addr_mask);
     }
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a75968e4c95..9e26c25c23c 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -34,6 +34,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/loongarch/fw_cfg.h"
 #include "target/loongarch/cpu.h"
+#include "target/loongarch/cpu-mmu.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/acpi/generic_event_device.h"
@@ -928,6 +929,7 @@ static void virt_init(MachineState *machine)
     hwaddr base, size, ram_size = machine->ram_size;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     Object *cpuobj;
+    uint64_t phys_addr_mask = 0;
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -1017,7 +1019,8 @@ static void virt_init(MachineState *machine)
     qemu_register_powerdown_notifier(&lvms->powerdown_notifier);
 
     lvms->bootinfo.ram_size = ram_size;
-    loongarch_load_kernel(machine, &lvms->bootinfo);
+    phys_addr_mask = loongarch_palen_mask(&LOONGARCH_CPU(first_cpu)->env);
+    loongarch_load_kernel(machine, &lvms->bootinfo, phys_addr_mask);
 }
 
 static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
-- 
2.52.0


