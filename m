Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87889C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p4m-000125-CC; Tue, 30 Apr 2024 11:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4S-0000ze-DF
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:05 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4Q-0000AY-81
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:04 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5196fe87775so6471185e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714489618; x=1715094418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGNe/5kNutRKm5uz4mTsWbXpNf42QSU6anrwo6QJebg=;
 b=Ebnu/dBhF2myrVXslHwCl9Vr1YR7HZcIjtkR0Ds3vAzX3jV0+DEzpc6su66qkv2Nkx
 G97BYDYudfsSq5hzHnIsaW5+C/iAiZD4IwvC3WC93AQ7VrSII1gas+iYHpyPE8nMIzJ8
 3VTRAMKo1R8OiNhrqxygz6VRIqKRkFOsXzFz6dB6/8DOH6eoWSIB47cLsKj0EDEKPH6L
 4448wBDcvj799ysMgeBrFDoLP92a6tbZF/Ji3O7WKzJoCEGrg+h6Szz8U7GdIiYMxf/P
 DHyaG45QqaPLUYWHk5+6LJbILtbwN3GHQqw/mcs9bSCE5vOIb37QBIq3hOcL3E4nM6Lp
 jDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489618; x=1715094418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DGNe/5kNutRKm5uz4mTsWbXpNf42QSU6anrwo6QJebg=;
 b=kTo0aDmXEdpmVmy3m+2LmaBfVCChfNyk3KXioi3HUi6k7JlN4PqoqhjVfOGF2xF438
 QjWR6uJulpK0a2Cuwo03DaRaANS9LDxkfYaySVam78Iiatdz2X2t3Fh1Y+7hTOQdsYEf
 aTKXsHB2V/AfFk31itH/aKLLC4NdO6hV/ux9jvfIJ1xzrZ11yy0JQU7HSXL3C9RPdFKr
 0WCd0L9rVCp3LY7F07t5bOAqQ9ro94Vk37Rciu3ppg3Xb5KQJ2Uv8TjifgTKcYKkhh40
 IXqMNZ8McFeOF9oTNHK4sMLqZ/JHyAeY8ECcdyx+HEH7qlypQZ7CAhd31EriYvx8Ymd9
 cV2g==
X-Gm-Message-State: AOJu0YzU8fWuvtZqwEd6J8MFTIgImajJ1N6OAwq3Twc2yqgVpORFc+sK
 A7gBTwH3MfSiBoTEPVs1S23LPAg1O9DN9rhzy5HhQl95zByxzJl2k/7DTg==
X-Google-Smtp-Source: AGHT+IGh1IMzyKILTn1jOKJNN/J1d60hIQ8cDdnoAbW4m5fexs4SvWWZDrg1cPKiaiv7StLNdWrpFg==
X-Received: by 2002:a19:5f19:0:b0:51b:e0f0:e4f8 with SMTP id
 t25-20020a195f19000000b0051be0f0e4f8mr7009382lfb.31.1714489618436; 
 Tue, 30 Apr 2024 08:06:58 -0700 (PDT)
Received: from archlinux.. (pd9ed788d.dip0.t-ipconnect.de. [217.237.120.141])
 by smtp.gmail.com with ESMTPSA id
 11-20020a0564021f4b00b005727e826977sm2345741edz.19.2024.04.30.08.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 08:06:57 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 6/6] hw/i386/pc_sysfw: Alias rather than copy isa-bios
 region
Date: Tue, 30 Apr 2024 17:06:43 +0200
Message-ID: <20240430150643.111976-7-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240430150643.111976-1-shentey@gmail.com>
References: <20240430150643.111976-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x129.google.com
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
index 08c7de416f..ce61bb7fc1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1811,6 +1811,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
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


