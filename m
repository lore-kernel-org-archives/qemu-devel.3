Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39458CF34D5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVTH-0007Zl-Sl; Thu, 03 Oct 2024 19:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTD-0007WI-9F
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTA-0003cn-5D
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cae102702so12306345e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727998970; x=1728603770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=660tqqXa5tibARPW9AYEAAZGQpIeIe3jt8UfaadrvBw=;
 b=XM+BqOW/ecMbnyGoCJNk7wY6qh6mhMJJhX+MyS/q0xBCLKmPpotVapi8zHBpBI+3La
 vE4GHM+GvO2ppJCQz1CVbKhKGzyrzlDj9ejnyMYOv7eAaIu+fIQtWiAIaV+27ru6T6Eg
 VzES0FWNIJGPAjjmb37/iw0DcgkEIo0S2L+rLraRGiZm9qrdl3w0/SWa14kk33eT0P/T
 Mu7eOgou95QT6zXPePb9LvNXIiY7O4ZaXE3UIB7enMMlv5800v+q4O2xHKu63s7v6p5P
 qOfXrJTZE72fwbbUnGzjXtggGM3odpSWSX6Dg3LOVNbJJW7lIMZibnfVHKMAOj66+Y9G
 hoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998970; x=1728603770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=660tqqXa5tibARPW9AYEAAZGQpIeIe3jt8UfaadrvBw=;
 b=A9cHKcfE3hBhxGfO5T/YpYk4wB1nXt6rhvDsPm/S93SlGmDeUNHXzIQcMT/Us++YpA
 /oGJZbIYZI7sPf6Y7d+4N4eFQrkwK5VAkS5W/XrEbMiO6tXjHhohzGM3+5Kw7dFTWx38
 DnyLQGYxXSI0MCgHrNUnZRtQYoH8OirUYRwWZJGISw2/CGX/w6spKC3+vR4TLDaKXGuz
 kVf6xTYzMgdzWRjooUFoTKUxI0YK1S2AvuNMfT0KjZZSiGoPf4iChMPAcAm/adUMLWLt
 9yd8al5lmtooAT5ZLKrHt14jECz+sAq3C7UOvni1ICNomQMHjsBPwJU8yBazHTPQq/kD
 KCIg==
X-Gm-Message-State: AOJu0YzsPVQXYXmd9jYJzZjH1RYcyXpL5NWeWSXxHwyTGkyLGQt0GP6H
 jnRSHtMQSEDJrEI+9WcWQElNuZAg0z0l82jZ3LVO8KCts7pwiBVY/SgasUnUdhk53cCVR94PHAZ
 e//M=
X-Google-Smtp-Source: AGHT+IHo9sePMa2N5NN4I6NNQXgzlh26D+snxVOI/qqhCJDUMzz2LtBPncDtoeC2idC56XydTVoZRQ==
X-Received: by 2002:a05:600c:1907:b0:426:6326:4cec with SMTP id
 5b1f17b1804b1-42f85af412bmr3516735e9.29.1727998969948; 
 Thu, 03 Oct 2024 16:42:49 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b444f1sm1230055e9.38.2024.10.03.16.42.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:42:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 04/16] hw/i386: Use explicit little-endian LD/ST API
Date: Fri,  4 Oct 2024 01:41:59 +0200
Message-ID: <20241003234211.53644-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The x86 architecture uses little endianness. Directly use
the little-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/multiboot.c  | 36 ++++++++++++++++++------------------
 hw/i386/x86-common.c | 26 +++++++++++++-------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 3332712ab35..ba4ead5270c 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -133,9 +133,9 @@ static void mb_add_mod(MultibootState *s,
 
     p = (char *)s->mb_buf + s->offset_mbinfo + MB_MOD_SIZE * s->mb_mods_count;
 
-    stl_p(p + MB_MOD_START,   start);
-    stl_p(p + MB_MOD_END,     end);
-    stl_p(p + MB_MOD_CMDLINE, cmdline_phys);
+    stl_le_p(p + MB_MOD_START,   start);
+    stl_le_p(p + MB_MOD_END,     end);
+    stl_le_p(p + MB_MOD_CMDLINE, cmdline_phys);
 
     mb_debug("mod%02d: "HWADDR_FMT_plx" - "HWADDR_FMT_plx,
              s->mb_mods_count, start, end);
@@ -168,9 +168,9 @@ int load_multiboot(X86MachineState *x86ms,
     /* Ok, let's see if it is a multiboot image.
        The header is 12x32bit long, so the latest entry may be 8192 - 48. */
     for (i = 0; i < (8192 - 48); i += 4) {
-        if (ldl_p(header+i) == 0x1BADB002) {
-            uint32_t checksum = ldl_p(header+i+8);
-            flags = ldl_p(header+i+4);
+        if (ldl_le_p(header+i) == 0x1BADB002) {
+            uint32_t checksum = ldl_le_p(header+i+8);
+            flags = ldl_le_p(header+i+4);
             checksum += flags;
             checksum += (uint32_t)0x1BADB002;
             if (!checksum) {
@@ -223,11 +223,11 @@ int load_multiboot(X86MachineState *x86ms,
                  mb_kernel_size, (size_t)mh_entry_addr);
     } else {
         /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_ADDR. */
-        uint32_t mh_header_addr = ldl_p(header+i+12);
-        uint32_t mh_load_end_addr = ldl_p(header+i+20);
-        uint32_t mh_bss_end_addr = ldl_p(header+i+24);
+        uint32_t mh_header_addr = ldl_le_p(header+i+12);
+        uint32_t mh_load_end_addr = ldl_le_p(header+i+20);
+        uint32_t mh_bss_end_addr = ldl_le_p(header+i+24);
 
-        mh_load_addr = ldl_p(header+i+16);
+        mh_load_addr = ldl_le_p(header+i+16);
         if (mh_header_addr < mh_load_addr) {
             error_report("invalid load_addr address");
             exit(1);
@@ -239,7 +239,7 @@ int load_multiboot(X86MachineState *x86ms,
 
         uint32_t mb_kernel_text_offset = i - (mh_header_addr - mh_load_addr);
         uint32_t mb_load_size = 0;
-        mh_entry_addr = ldl_p(header+i+28);
+        mh_entry_addr = ldl_le_p(header+i+28);
 
         if (mh_load_end_addr) {
             if (mh_load_end_addr < mh_load_addr) {
@@ -364,22 +364,22 @@ int load_multiboot(X86MachineState *x86ms,
 
     /* Commandline support */
     kcmdline = g_strdup_printf("%s %s", kernel_filename, kernel_cmdline);
-    stl_p(bootinfo + MBI_CMDLINE, mb_add_cmdline(&mbs, kcmdline));
+    stl_le_p(bootinfo + MBI_CMDLINE, mb_add_cmdline(&mbs, kcmdline));
 
-    stl_p(bootinfo + MBI_BOOTLOADER, mb_add_bootloader(&mbs, bootloader_name));
+    stl_le_p(bootinfo + MBI_BOOTLOADER, mb_add_bootloader(&mbs, bootloader_name));
 
-    stl_p(bootinfo + MBI_MODS_ADDR,  mbs.mb_buf_phys + mbs.offset_mbinfo);
-    stl_p(bootinfo + MBI_MODS_COUNT, mbs.mb_mods_count); /* mods_count */
+    stl_le_p(bootinfo + MBI_MODS_ADDR,  mbs.mb_buf_phys + mbs.offset_mbinfo);
+    stl_le_p(bootinfo + MBI_MODS_COUNT, mbs.mb_mods_count); /* mods_count */
 
     /* the kernel is where we want it to be now */
-    stl_p(bootinfo + MBI_FLAGS, MULTIBOOT_FLAGS_MEMORY
+    stl_le_p(bootinfo + MBI_FLAGS, MULTIBOOT_FLAGS_MEMORY
                                 | MULTIBOOT_FLAGS_BOOT_DEVICE
                                 | MULTIBOOT_FLAGS_CMDLINE
                                 | MULTIBOOT_FLAGS_MODULES
                                 | MULTIBOOT_FLAGS_MMAP
                                 | MULTIBOOT_FLAGS_BOOTLOADER);
-    stl_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */
-    stl_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
+    stl_le_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */
+    stl_le_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
 
     mb_debug("multiboot: entry_addr = %#x", mh_entry_addr);
     mb_debug("           mb_buf_phys   = "HWADDR_FMT_plx, mbs.mb_buf_phys);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 992ea1f25e9..daa6a5d500c 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -586,7 +586,7 @@ static bool load_elfboot(const char *kernel_filename,
     uint64_t elf_low, elf_high;
     int kernel_size;
 
-    if (ldl_p(header) != 0x464c457f) {
+    if (ldl_le_p(header) != 0x464c457f) {
         return false; /* no elfboot */
     }
 
@@ -669,8 +669,8 @@ void x86_load_linux(X86MachineState *x86ms,
      * kernel protocol version.
      * Please see https://www.kernel.org/doc/Documentation/x86/boot.txt
      */
-    if (ldl_p(header + 0x202) == 0x53726448) /* Magic signature "HdrS" */ {
-        protocol = lduw_p(header + 0x206);
+    if (ldl_le_p(header + 0x202) == 0x53726448) /* Magic signature "HdrS" */ {
+        protocol = lduw_be_p(header + 0x206);
     } else {
         /*
          * This could be a multiboot kernel. If it is, let's stop treating it
@@ -762,7 +762,7 @@ void x86_load_linux(X86MachineState *x86ms,
 
     /* highest address for loading the initrd */
     if (protocol >= 0x20c &&
-        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
+        lduw_be_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
         /*
          * Linux has supported initrd up to 4 GB for a very long time (2007,
          * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
@@ -781,7 +781,7 @@ void x86_load_linux(X86MachineState *x86ms,
          */
         initrd_max = UINT32_MAX;
     } else if (protocol >= 0x203) {
-        initrd_max = ldl_p(header + 0x22c);
+        initrd_max = ldl_le_p(header + 0x22c);
     } else {
         initrd_max = 0x37ffffff;
     }
@@ -797,10 +797,10 @@ void x86_load_linux(X86MachineState *x86ms,
     sev_load_ctx.cmdline_size = strlen(kernel_cmdline) + 1;
 
     if (protocol >= 0x202) {
-        stl_p(header + 0x228, cmdline_addr);
+        stl_le_p(header + 0x228, cmdline_addr);
     } else {
-        stw_p(header + 0x20, 0xA33F);
-        stw_p(header + 0x22, cmdline_addr - real_addr);
+        stw_le_p(header + 0x20, 0xA33F);
+        stw_le_p(header + 0x22, cmdline_addr - real_addr);
     }
 
     /* handle vga= parameter */
@@ -824,7 +824,7 @@ void x86_load_linux(X86MachineState *x86ms,
                 exit(1);
             }
         }
-        stw_p(header + 0x1fa, video_mode);
+        stw_le_p(header + 0x1fa, video_mode);
     }
 
     /* loader type */
@@ -839,7 +839,7 @@ void x86_load_linux(X86MachineState *x86ms,
     /* heap */
     if (protocol >= 0x201) {
         header[0x211] |= 0x80; /* CAN_USE_HEAP */
-        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
+        stw_le_p(header + 0x224, cmdline_addr - real_addr - 0x200);
     }
 
     /* load initrd */
@@ -879,8 +879,8 @@ void x86_load_linux(X86MachineState *x86ms,
         sev_load_ctx.initrd_data = initrd_data;
         sev_load_ctx.initrd_size = initrd_size;
 
-        stl_p(header + 0x218, initrd_addr);
-        stl_p(header + 0x21c, initrd_size);
+        stl_le_p(header + 0x218, initrd_addr);
+        stl_le_p(header + 0x21c, initrd_size);
     }
 
     /* load kernel and setup */
@@ -926,7 +926,7 @@ void x86_load_linux(X86MachineState *x86ms,
         kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
         kernel = g_realloc(kernel, kernel_size);
 
-        stq_p(header + 0x250, prot_addr + setup_data_offset);
+        stq_le_p(header + 0x250, prot_addr + setup_data_offset);
 
         setup_data = (struct setup_data *)(kernel + setup_data_offset);
         setup_data->next = 0;
-- 
2.45.2


