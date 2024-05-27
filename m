Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E7EC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdwV-00030S-58; Mon, 27 May 2024 13:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwO-0002yd-3W
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:20 -0400
Received: from wfhigh3-smtp.messagingengine.com ([64.147.123.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwM-0004gT-2S
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:19 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id 77A281800139;
 Mon, 27 May 2024 13:15:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 27 May 2024 13:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716830115;
 x=1716916515; bh=TpF+LHkA27GmX2zM44+D/InSAryVrJfrT0+bWhayZYQ=; b=
 pR7brity8sNFDTvaixsYjmsSCcf6aeW+o05fcxeeMRbxx4UlLtVZUthoiHKOzMb+
 v0qM9qNfPbqEomq6ooDr7FgBTHbf21qCiCOnz2zESj01AV+t0zI2eLSuHW3Deo6o
 UJyz+FtuQmRntbe5NDticsNy6q2P1StdSRZLphxQC0iOIKmmMnnbRS92cF1LLuuL
 4wJ27WceFGRdGZhkJkcUManQLjD8QiBe/BfOtelLyw2ii99r8NqBO3ktn8Z1UowV
 bwHjkPbtxVrm3S6RoH7zKxhLPT5SbMRlFNb45B6y0TFo9MZXvnpXi9CJMopZBeTW
 xnfGSSNlkR1I+s6Mi48VfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716830115; x=
 1716916515; bh=TpF+LHkA27GmX2zM44+D/InSAryVrJfrT0+bWhayZYQ=; b=S
 TiHhqxmg3bFxyDKw2yXUGc7Tc2/VhAksbJD2A/xRZJDo76ZNWxsWlw1zgQLJeuyD
 7GeBxKHGP2c6Y/euFIYsS1xO+54T6ts1+2JIpS6XVcC3yW96DP4Qgcc2WKgvQHr1
 gqrXB/B9ZTDg/o1KdVkNYmhi9iGg/3Yw1yWk/86Aj3NPUfSZXBHmaAxm0f6lTajc
 HKFcUZun73UHVUqEOlIxkGmPzl5kUFyAh9SJFGbxYeYS+AXn2Z+zGj01TN+BDItg
 HkbmarY8A/ARLP5vOaDR3bn5WB22PCBiz+hGraSq3bpVoB7uYwazv2ngmQAiMcK7
 2d6FYBOP9qi0hGjdB+WVg==
X-ME-Sender: <xms:or9UZteKJdFeDzDKqGQuXNDZOYLj7y8yajH-iqbMP89c8gTDnsK_2g>
 <xme:or9UZrNj4396PRaK6GchEThMM9z9O0fYlXiG7Ead1KAU0zlbtOqn4JLK4N1VM9HKa
 0jq12PVtmP1NmVdTcs>
X-ME-Received: <xmr:or9UZmidyNkrjNIGdEi0cVXltotwOiWl3LVrV22_Uwrz9OaxInVYCMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:or9UZm_hmYio0d6X1_uF4DzWT0tftD2O4wL0juRYH-EAeN8UAka6kA>
 <xmx:or9UZpt6prrff0NIvs8ZmPZ6rM7W5rWylvSGRLJBlta1MUqRmQ5yAg>
 <xmx:or9UZlES1Pza2VoIW06XUvWnkBMHEdmlstbjaiJfov5eiHj1Kk8k8Q>
 <xmx:or9UZgMkCsJ4QhRMeYGbb0nu1c0_sjIhaPgD_yGBEkAFi3GHcpnx8w>
 <xmx:o79UZthTd5orlOyYvQTD9KpYYQxggEkFdqq53mudHUi3c_i9ziSaNHJe>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 13:15:13 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 27 May 2024 18:15:07 +0100
Subject: [PATCH 4/4] hw/m68k/virt: Supply bootinfo for BIOS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-m68k-bios-v1-4-6de26552fa77@flygoat.com>
References: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
In-Reply-To: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9672;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=nHaNjYJp2Db3HKKzI2WU5EhbcN3PdSAvxdjvtn6y5K0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSQ/TOZJ5UevfHWcE/V4T3i0jsDG2zCFvzsW2DREv9/6
 RLj9UYBHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRKycZ/nAcOjNxkagMl0bb
 5uDDQVzLLCyKOXZxTDSzKen5wua5mZPhf55aUtQNtVzOhJ2HEyf1389w1N+99qJbp275UpkTcfP
 UOAE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

We follow common function split between BIOS and QEMU loader,
When BIOS firmware is available QEMU does not load kernel/initrd
binary to memory, instead BIOS retrieve those binaries from fw_cfg.

A stripped version of bootinfo is placed at 1 KiB position of memory.
This allows BIOS to probe board level information. It does not contain
any booting related information (kernel, initrd, cmdline, random).

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/m68k/virt.c | 160 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 90 insertions(+), 70 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index a2eebc0f2243..ea7a1bb430fc 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -138,13 +138,16 @@ static void virt_init(MachineState *machine)
     M68kCPU *cpu = NULL;
     int32_t kernel_size;
     uint64_t elf_entry;
-    ram_addr_t initrd_base;
-    int32_t initrd_size;
+    ram_addr_t initrd_base = 0;
+    int32_t initrd_size = 0;
+    int32_t bootinfo_size;
+    bool bios_loaded = false;
     ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
-    hwaddr parameters_base;
+    void *param_blob, *param_ptr, *param_rng_seed = NULL;
+    hwaddr parameters_base = 1 * KiB;
     DriveInfo *dinfo;
     DeviceState *dev;
     DeviceState *irqc_dev;
@@ -264,6 +267,9 @@ static void virt_init(MachineState *machine)
 
     /* pflash */
     dinfo = drive_get(IF_PFLASH, 0, 0);
+    if (dinfo) {
+        bios_loaded = true;
+    }
     pflash_cfi01_register(VIRT_PFLASH_MMIO_BASE,
                           "virt.pflash0",
                            VIRT_PFLASH_SIZE,
@@ -293,18 +299,12 @@ static void virt_init(MachineState *machine)
             error_report("Could not load ROM image '%s'", machine->firmware);
             exit(1);
         }
+
+        bios_loaded = true;
     }
 
-    if (kernel_filename) {
-        CPUState *cs = CPU(cpu);
+    if (kernel_filename && !bios_loaded) {
         uint64_t high;
-        void *param_blob, *param_ptr, *param_rng_seed;
-
-        if (kernel_cmdline) {
-            param_blob = g_malloc(strlen(kernel_cmdline) + 1024);
-        } else {
-            param_blob = g_malloc(1024);
-        }
 
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &elf_entry, NULL, &high, NULL, 1,
@@ -315,57 +315,6 @@ static void virt_init(MachineState *machine)
         }
         reset_info->initial_pc = elf_entry;
         parameters_base = (high + 1) & ~1;
-        param_ptr = param_blob;
-
-        BOOTINFO1(param_ptr, BI_MACHTYPE, MACH_VIRT);
-        if (m68k_feature(&cpu->env, M68K_FEATURE_M68020)) {
-            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68020);
-        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68030)) {
-            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68030);
-            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68030);
-        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68040)) {
-            BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68040);
-            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68040);
-            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68040);
-        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68060)) {
-            BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68060);
-            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68060);
-            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68060);
-        }
-        BOOTINFO2(param_ptr, BI_MEMCHUNK, 0, ram_size);
-
-        BOOTINFO1(param_ptr, BI_VIRT_QEMU_VERSION,
-                  ((QEMU_VERSION_MAJOR << 24) | (QEMU_VERSION_MINOR << 16) |
-                   (QEMU_VERSION_MICRO << 8)));
-        BOOTINFO2(param_ptr, BI_VIRT_GF_PIC_BASE,
-                  VIRT_GF_PIC_MMIO_BASE, VIRT_GF_PIC_IRQ_BASE);
-        BOOTINFO2(param_ptr, BI_VIRT_GF_RTC_BASE,
-                  VIRT_GF_RTC_MMIO_BASE, VIRT_GF_RTC_IRQ_BASE);
-        BOOTINFO2(param_ptr, BI_VIRT_GF_TTY_BASE,
-                  VIRT_GF_TTY_MMIO_BASE, VIRT_GF_TTY_IRQ_BASE);
-        BOOTINFO2(param_ptr, BI_VIRT_CTRL_BASE,
-                  VIRT_CTRL_MMIO_BASE, VIRT_CTRL_IRQ_BASE);
-        BOOTINFO2(param_ptr, BI_VIRT_VIRTIO_BASE,
-                  VIRT_VIRTIO_MMIO_BASE, VIRT_VIRTIO_IRQ_BASE);
-        if (machine_usb(machine)) {
-            BOOTINFO2(param_ptr, BI_VIRT_XHCI_BASE,
-                    VIRT_XHCI_MMIO_BASE, VIRT_XHCI_IRQ_BASE);
-        }
-        BOOTINFO2(param_ptr, BI_VIRT_FW_CFG_BASE,
-                  VIRT_FW_CFG_MMIO_BASE, VIRT_FW_CFG_IRQ_BASE);
-        BOOTINFO2(param_ptr, BI_VIRT_PFLASH_BASE,
-                    VIRT_PFLASH_MMIO_BASE, 0);
-
-        if (kernel_cmdline) {
-            BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
-                        kernel_cmdline);
-        }
-
-        /* Pass seed to RNG. */
-        param_rng_seed = param_ptr;
-        qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-        BOOTINFODATA(param_ptr, BI_RNG_SEED,
-                     rng_seed, sizeof(rng_seed));
 
         /* load initrd */
         if (initrd_filename) {
@@ -379,21 +328,92 @@ static void virt_init(MachineState *machine)
             initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
             load_image_targphys(initrd_filename, initrd_base,
                                 ram_size - initrd_base);
-            BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
-                      initrd_size);
         } else {
             initrd_base = 0;
             initrd_size = 0;
         }
-        BOOTINFO0(param_ptr, BI_LAST);
-        rom_add_blob_fixed_as("bootinfo", param_blob, param_ptr - param_blob,
-                              parameters_base, cs->as);
+    }
+
+    /* BIOS is going to retrive cmdline from fw_cfg */
+    if (kernel_cmdline && !bios_loaded) {
+        param_blob = g_malloc(strlen(kernel_cmdline) + 1024);
+    } else {
+        param_blob = g_malloc(1024);
+    }
+
+    param_ptr = param_blob;
+    BOOTINFO1(param_ptr, BI_MACHTYPE, MACH_VIRT);
+    if (m68k_feature(&cpu->env, M68K_FEATURE_M68020)) {
+        BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68020);
+    } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68030)) {
+        BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68030);
+        BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68030);
+    } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68040)) {
+        BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68040);
+        BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68040);
+        BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68040);
+    } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68060)) {
+        BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68060);
+        BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68060);
+        BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68060);
+    }
+    BOOTINFO2(param_ptr, BI_MEMCHUNK, 0, ram_size);
+
+    BOOTINFO1(param_ptr, BI_VIRT_QEMU_VERSION,
+                ((QEMU_VERSION_MAJOR << 24) | (QEMU_VERSION_MINOR << 16) |
+                (QEMU_VERSION_MICRO << 8)));
+    BOOTINFO2(param_ptr, BI_VIRT_GF_PIC_BASE,
+                VIRT_GF_PIC_MMIO_BASE, VIRT_GF_PIC_IRQ_BASE);
+    BOOTINFO2(param_ptr, BI_VIRT_GF_RTC_BASE,
+                VIRT_GF_RTC_MMIO_BASE, VIRT_GF_RTC_IRQ_BASE);
+    BOOTINFO2(param_ptr, BI_VIRT_GF_TTY_BASE,
+                VIRT_GF_TTY_MMIO_BASE, VIRT_GF_TTY_IRQ_BASE);
+    BOOTINFO2(param_ptr, BI_VIRT_CTRL_BASE,
+                VIRT_CTRL_MMIO_BASE, VIRT_CTRL_IRQ_BASE);
+    BOOTINFO2(param_ptr, BI_VIRT_VIRTIO_BASE,
+                VIRT_VIRTIO_MMIO_BASE, VIRT_VIRTIO_IRQ_BASE);
+    if (machine_usb(machine)) {
+        BOOTINFO2(param_ptr, BI_VIRT_XHCI_BASE,
+                VIRT_XHCI_MMIO_BASE, VIRT_XHCI_IRQ_BASE);
+    }
+    BOOTINFO2(param_ptr, BI_VIRT_FW_CFG_BASE,
+                VIRT_FW_CFG_MMIO_BASE, VIRT_FW_CFG_IRQ_BASE);
+    BOOTINFO2(param_ptr, BI_VIRT_PFLASH_BASE,
+                VIRT_PFLASH_MMIO_BASE, 0);
+
+    /* Boot related */
+    if (!bios_loaded) {
+        if (kernel_cmdline) {
+            BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
+                        kernel_cmdline);
+        }
+        if (initrd_size) {
+            BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
+                      initrd_size);
+        }
+
+        /* Pass seed to RNG. */
+        param_rng_seed = param_ptr;
+        qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
+        BOOTINFODATA(param_ptr, BI_RNG_SEED,
+                     rng_seed, sizeof(rng_seed));
+    }
+
+    BOOTINFO0(param_ptr, BI_LAST);
+    bootinfo_size = param_ptr - param_blob;
+    rom_add_blob_fixed_as("bootinfo", param_blob, bootinfo_size,
+                          parameters_base, &address_space_memory);
+    if (param_rng_seed) {
         qemu_register_reset_nosnapshotload(rerandomize_rng_seed,
-                            rom_ptr_for_as(cs->as, parameters_base,
+                            rom_ptr_for_as(&address_space_memory,
+                                           parameters_base,
                                            param_ptr - param_blob) +
                             (param_rng_seed - param_blob));
-        g_free(param_blob);
     }
+
+    fw_cfg_add_file(fw_cfg, "etc/bootinfo",
+                    g_memdup2(param_blob, bootinfo_size), bootinfo_size);
+    g_free(param_blob);
 }
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)

-- 
2.43.0


