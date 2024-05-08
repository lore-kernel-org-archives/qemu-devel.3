Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8064C25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lVt-0001DJ-UX; Wed, 08 May 2024 13:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVp-0001BQ-8Y
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:31 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVn-00028v-9M
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:29 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51fea3031c3so6120429e87.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715190924; x=1715795724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3ZfC5WZy7A+MxhECoq43BsVJE3/UqvvUQ3KRfQIO0U=;
 b=jP+QEOhXUorBfUa22ZkXPQ3cSlowtwI8OrxAumTwgOJlgIdTYG4+sP2G8bVi4xISJz
 7GGMgTs9wR9IYGMk8cfRu/tuqQtCIDPMYL4ddbRcKktcqpBhJNfQbYP7LPxhR2Z4S026
 RlOgvqwZ0nPyL5CEBGiil3GQur+F4UcnB/VA7Ec3W7lrq+kkJLvfiVkohV6CJVbK4t9c
 GwaN5TukU0GzCApcEpIl9QssoQDmXHLlFHQlpOiq/EXlTOdjI4rGvrltkgcMSl6H/5sA
 YZsMSsbrGyB5EFId9N4tZ76PUWM41nXF3st2q6q0plXPNOCQ7QpyRGs2bD0VbVE0kyQK
 HFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190924; x=1715795724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3ZfC5WZy7A+MxhECoq43BsVJE3/UqvvUQ3KRfQIO0U=;
 b=w9eFDhxnH04TwqIQe/bxXtYuEfEuTIwHHMxssYMPbEWuW2gFQBgj77ed90TWky9HHK
 q8wD+fdKkX+yClkNtkVOYc9VDw2ZK9N9c8tYyvndp4QIWn/zoI93F12yv3w5GC01tCbC
 yhjCLraotV0ftEy6MBLdGcQLkCuk75rveOJW9bL/KRy9AvjmLpCuvcBxDjv7TmtR1+rv
 AyvrkQ6Sz+cMFw0TMAfVhTHMrd0MQae0zoJxsvaLHWv3tM1/3DG0Tg7QcxHTo8SH5zCS
 lSJ2ryvGx8CIxzRvDYmwBZKBfz6JjwPLxYT3OJKLxNn5Ldr11LTkdzcbZnllNENAEqBr
 aQKw==
X-Gm-Message-State: AOJu0YzIW5jz6orZgxH7F0J03Kt3humtJloK1w7O8bdEDSBV3NjRb0tj
 8eTb8cNuvKP9ISQODo6MhDtROWdmHt1pRGxuQO3cqOJbiG5YQgqmNoCKWA==
X-Google-Smtp-Source: AGHT+IFfGYmch1gqNZb9XcfQUWivGCG3nbTaTZpgOfBmwqQa5UlGcX4pLYtghVITjLau2YUuq7+zqw==
X-Received: by 2002:a19:5f03:0:b0:521:e065:c6c6 with SMTP id
 2adb3069b0e04-521e065c97dmr286934e87.53.1715190924291; 
 Wed, 08 May 2024 10:55:24 -0700 (PDT)
Received: from archlinux.. (dynamic-077-013-167-103.77.13.pool.telefonica.de.
 [77.13.167.103]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906671800b00a59c5a129basm4483821ejp.80.2024.05.08.10.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 10:55:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 6/6] hw/i386/pc_sysfw: Alias rather than copy isa-bios
 region
Date: Wed,  8 May 2024 19:55:07 +0200
Message-ID: <20240508175507.22270-7-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508175507.22270-1-shentey@gmail.com>
References: <20240508175507.22270-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In the -bios case the "isa-bios" memory region is an alias to the BIOS mapped
to the top of the 4G memory boundary. Do the same in the -pflash case, but only
for new machine versions for migration compatibility. This establishes common
behavior and makes pflash commands work in the "isa-bios" region which some
real-world legacy bioses rely on.

Note that in the sev_enabled() case, the "isa-bios" memory region in the -pflash
case will now also point to encrypted memory, just like it already does in the
-bios case.

When running `info mtree` before and after this commit with
`qemu-system-x86_64 -S -drive \
if=pflash,format=raw,readonly=on,file=/usr/share/qemu/bios-256k.bin` and running
`diff -u before.mtree after.mtree` results in the following changes in the
memory tree:

   --- before.mtree
   +++ after.mtree
   @@ -71,7 +71,7 @@
        0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
   -      00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
   +      00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios @system.flash0 0000000000020000-000000000003ffff
        00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
        00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
        00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
   @@ -108,7 +108,7 @@
        0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
   -      00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
   +      00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios @system.flash0 0000000000020000-000000000003ffff
        00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
        00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
        00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
   @@ -131,11 +131,14 @@
   memory-region: pc.ram
   0000000000000000-0000000007ffffff (prio 0, ram): pc.ram

   +memory-region: system.flash0
   +  00000000fffc0000-00000000ffffffff (prio 0, romd): system.flash0
   +
   memory-region: pci
   0000000000000000-ffffffffffffffff (prio -1, i/o): pci
        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
        00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
   -    00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
   +    00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios @system.flash0 0000000000020000-000000000003ffff

   memory-region: smram
        00000000000a0000-00000000000bffff (prio 0, ram): alias smram-low @pc.ram 00000000000a0000-00000000000bffff

Note that in both cases the "system" memory region contains the entry

  00000000fffc0000-00000000ffffffff (prio 0, romd): system.flash0

but the "system.flash0" memory region only appears standalone when "isa-bios" is
an alias.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 1 +
 hw/i386/pc_piix.c    | 3 +++
 hw/i386/pc_q35.c     | 2 ++
 hw/i386/pc_sysfw.c   | 8 +++++++-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e52290916c..ad9c3d9ba8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -119,6 +119,7 @@ struct PCMachineClass {
     bool enforce_aligned_dimm;
     bool broken_reserved_end;
     bool enforce_amd_1tb_hole;
+    bool isa_bios_alias;
 
     /* generate legacy CPU hotplug AML */
     bool legacy_cpu_hotplug;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 46235466d7..4878705af7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1812,6 +1812,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_reserved_memory = true;
     pcmc->enforce_aligned_dimm = true;
     pcmc->enforce_amd_1tb_hole = true;
+    pcmc->isa_bios_alias = true;
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
      * to be used at the moment, 32K should be enough for a while.  */
     pcmc->acpi_data_size = 0x20000 + 0x8000;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8850c49c66..d4e9deb509 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -525,12 +525,15 @@ DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
 
 static void pc_i440fx_9_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_9_1_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
 
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
+    pcmc->isa_bios_alias = false;
 }
 
 DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index bb53a51ac1..bd7db4abac 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -378,10 +378,12 @@ DEFINE_Q35_MACHINE(v9_1, "pc-q35-9.1", NULL,
 
 static void pc_q35_9_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_9_1_machine_options(m);
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
+    pcmc->isa_bios_alias = false;
 }
 
 DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 82d37cb376..ac88ad4eb9 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -135,6 +135,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
                                 MemoryRegion *rom_memory)
 {
     X86MachineState *x86ms = X86_MACHINE(pcms);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     hwaddr total_size = 0;
     int i;
     BlockBackend *blk;
@@ -184,7 +185,12 @@ static void pc_system_flash_map(PCMachineState *pcms,
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
-            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
+            if (pcmc->isa_bios_alias) {
+                x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem,
+                                  true);
+            } else {
+                pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
+            }
 
             /* Encrypt the pflash boot ROM */
             if (sev_enabled()) {
-- 
2.45.0


