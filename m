Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDD1C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9w6-0005DK-Nl; Thu, 23 May 2024 11:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9w4-00052H-3O
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9w2-0004nl-7A
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njYSO7HTB+sDeOmmffYU6ooE+v8Mi/U08DiKKYNjzGE=;
 b=LDIxoY9y/Byi0M5ErTlkeSrHUaGAa2z5ds4ubXEoqQYKiSPQGv3iEwEpeRFJE8xIaYdQQv
 YnzC2Q82JU0hGY0NmvdmpQLoK+GsKNWjat/eyYU+uxeZPwjNnCT+WLS5dyyHgjvy2HzBCO
 gfSc2fYnQhEe7Rky3gAxkaBoq/KGwZE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-P7rGI563PRS9X---cgDlkQ-1; Thu, 23 May 2024 11:00:46 -0400
X-MC-Unique: P7rGI563PRS9X---cgDlkQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59aedbd9a9so131181966b.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476445; x=1717081245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njYSO7HTB+sDeOmmffYU6ooE+v8Mi/U08DiKKYNjzGE=;
 b=rVIiFdRTV0q7lpNcwFgWFw6QSa7Sd30T+7PquyO45mk0gIWckfT57LC1sASgNFjME7
 jS+q9s+NuFozLYzNUtJ1E3VE+ZRzhJB96RQZ0aF1OTTDLDT6lrcuFixwFxJGHaQI+tbg
 oksPSsMoZ4RTo9+MUVI8Wq5rnqmFA3zU8BjrL7+20CsoEnGoBLDqSY+505xQcI2zZokl
 FHvbk28f1VWMnAsyqXRDE3+e3uXY5CmqDxtwTEOftpwhB/AyndK7Pc9wf9BbnOEwwMgU
 P357AwE0Sou9g/2ARQhQFTvjldyOnF6blgg9TMgDPP1vCGqXMV31q8YV4Oofg1oe/JLh
 Kf9w==
X-Gm-Message-State: AOJu0Yxc6EeW/GV+OnYF5GS6Bpj6UxILLIXkh0L9QKOGn0sQkBApmWxW
 tnG8lG84cmC59bTfnoa7EK+YgO/BRuqu9w8cPjrJfjNZAkvsHHZ/jej3OADWXDODhxAYcBL5eok
 qvKKuSb0h7ZITJvzffOwW5kd2HyPMT5TPOUsoMhBxBDCeiq++ATTVZ3GecDy7M84L4Kjz/ZAPZR
 PnBkb0VzwmxVANEXmwLDWTcEFjESVMZcZ7C8IX
X-Received: by 2002:a17:906:7158:b0:a59:cd18:92f5 with SMTP id
 a640c23a62f3a-a62280556d2mr355745866b.11.1716476445069; 
 Thu, 23 May 2024 08:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlWqwt6lkTcobGw3vOKvo57EmJ1TPORZQNO3mGjzdXQtQQ/rU3+v2oUuUlxw3gTnUg4YZ5DA==
X-Received: by 2002:a17:906:7158:b0:a59:cd18:92f5 with SMTP id
 a640c23a62f3a-a62280556d2mr355744166b.11.1716476444545; 
 Thu, 23 May 2024 08:00:44 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a55afdea7sm1681003666b.141.2024.05.23.08.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 03/23] hw/i386/pc_sysfw: Alias rather than copy isa-bios region
Date: Thu, 23 May 2024 17:00:16 +0200
Message-ID: <20240523150036.1050011-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

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
Message-ID: <20240508175507.22270-7-shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 1 +
 hw/i386/pc_piix.c    | 3 +++
 hw/i386/pc_q35.c     | 2 ++
 hw/i386/pc_sysfw.c   | 8 +++++++-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e52290916cb..ad9c3d9ba84 100644
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
index bfb46e9b548..4a2d6f5a97f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1816,6 +1816,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_reserved_memory = true;
     pcmc->enforce_aligned_dimm = true;
     pcmc->enforce_amd_1tb_hole = true;
+    pcmc->isa_bios_alias = true;
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
      * to be used at the moment, 32K should be enough for a while.  */
     pcmc->acpi_data_size = 0x20000 + 0x8000;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 99efb3c45cb..ebb51de3809 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -526,12 +526,15 @@ DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
 
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
index bb53a51ac18..bd7db4abacf 100644
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
index 82d37cb376b..ac88ad4eb91 100644
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
2.45.1


