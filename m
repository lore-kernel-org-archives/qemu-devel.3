Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDD1CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7d-0005BG-IN; Thu, 28 Mar 2024 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7X-0004rr-OX
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:52 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7V-0002ZL-Ta
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:51 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a47385a4379so400335866b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641408; x=1712246208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Aa27ZqAQEFmCBsiqy9XwiiPf6EIjcNyjahGDi9IpJg=;
 b=wmdnFLj8N4MTTkR7GiUS/vACf4UOgkQnipJ9uaXGwtqukwJjWxXXHCpTdrIfMmaC9O
 vAypE0B0AyVCEO4LDMYLsR5ktjQUbduAPOUKkwgTeP1dmGemNlFXL6EgWk0yypiHpjP4
 0CEe6VRJA2xvnxEtRM4RCH/WzVBdHHGEChi9ZcnQet88RxX4yS0m7M8FPyiLRct61ujf
 gJT1FBUa9UhqIn47HAdOSGJ8SZWQlmncRI9nHiC/oiBHJQkH4q9tZsrK0sQqGgf2tLY+
 SPQ8Ov0ceOY0g2oqMNGevizgKfLCrYHFykaHasXTXJkyRK31ObzD1hDYYGn6a3eESre2
 WZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641408; x=1712246208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Aa27ZqAQEFmCBsiqy9XwiiPf6EIjcNyjahGDi9IpJg=;
 b=Po2+yTlOWTJL6gSRXdkHm0NeTJCbbBXoqYQVIRV/16DPm2qoGho3W5/VlH3AAr8lKe
 FOHwjVBMFC3kGX9cUEBkxWXrfU7NOm8/hkiZ5/VJBs5m+T2eTWly3GYHmp5NAUKhG3cE
 EQT2tb4y4IQjX6AmNq6fqbJ73hU3sNWT8vGV4eFg79Npo54YNjJVB1CEO3bL9WgOXrPs
 TOdB4B0jzAkjhygU4pqBa9sn6yxLKOwwnVsVMAU37Of1TmNkEuEqYYEfo34m/JO3ABrl
 qKRYxMxyVi1U8ScM/q/eR5/6MwhP8rdOd5SesRI66KXgqQ7xCwn4fpE7OQzkjZYdtNcy
 DeSg==
X-Gm-Message-State: AOJu0YxDFLwz1FoW26Neci2HmR1+l1uTKYa291+fJu90vW4yFizRyJUf
 UTfPGVbrjZNSxH1cUgf9l293XpgpqKz7SpluRcd7iORvVY6hwj1fG5E8XbZZ5YfVIdQNg1VFlWr
 L
X-Google-Smtp-Source: AGHT+IGf+dMAnCAltiuzPzgchc+sbbW407Sj1dQczYyJgyomDKws4CVNCOW6jzbL55k6+JJbXoaF8w==
X-Received: by 2002:a17:906:ccc3:b0:a47:1f61:4d02 with SMTP id
 ot3-20020a170906ccc300b00a471f614d02mr2207346ejb.36.1711641408058; 
 Thu, 28 Mar 2024 08:56:48 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 u23-20020a170906125700b00a47522c193asm892212eja.196.2024.03.28.08.56.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 20/29] hw/i386/pc: Pass PcPciMachineState argument
 to pc_pci_hole64_start()
Date: Thu, 28 Mar 2024 16:54:28 +0100
Message-ID: <20240328155439.58719-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

pc_pci_hole64_start() is only used by PCI-based
machines.  Pass it a PcPciMachineState argument,
removing a qdev_get_machine() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 2 +-
 hw/i386/pc.c         | 8 ++++----
 hw/pci-host/i440fx.c | 2 +-
 hw/pci-host/q35.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index df4c813854..7da0bc8aa4 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -157,7 +157,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
                     uint64_t pci_hole64_size);
-uint64_t pc_pci_hole64_start(void);
+uint64_t pc_pci_hole64_start(PcPciMachineState *ppms);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d8e91d18b8..b83abee8e9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -747,7 +747,8 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 
     if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
         /* 64-bit systems */
-        return pc_pci_hole64_start() + pci_hole64_size - 1;
+        PcPciMachineState *ppms = PC_PCI_MACHINE(pcms);
+        return pc_pci_hole64_start(ppms) + pci_hole64_size - 1;
     }
 
     /* 32-bit systems */
@@ -1016,11 +1017,10 @@ void pc_memory_init(PCMachineState *pcms,
  * The 64bit pci hole starts after "above 4G RAM" and
  * potentially the space reserved for memory hotplug.
  */
-uint64_t pc_pci_hole64_start(void)
+uint64_t pc_pci_hole64_start(PcPciMachineState *ppms)
 {
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
+    PCMachineState *pcms = PC_MACHINE(ppms);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    PcPciMachineState *ppms = PC_PCI_MACHINE(pcms);
     MachineState *ms = MACHINE(pcms);
     uint64_t hole64_start = 0;
     ram_addr_t size = 0;
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 4f0a0438d7..add99e4f76 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -180,7 +180,7 @@ static uint64_t i440fx_pcihost_get_pci_hole64_start_value(Object *obj)
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_lob(&w64);
     if (!value && s->pci_hole64_fix) {
-        value = pc_pci_hole64_start();
+        value = pc_pci_hole64_start(PC_PCI_MACHINE(qdev_get_machine()));
     }
     return value;
 }
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0d7d4e3f08..baf55897b2 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -123,7 +123,7 @@ static uint64_t q35_host_get_pci_hole64_start_value(Object *obj)
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_lob(&w64);
     if (!value && s->pci_hole64_fix) {
-        value = pc_pci_hole64_start();
+        value = pc_pci_hole64_start(PC_PCI_MACHINE(qdev_get_machine()));
     }
     return value;
 }
-- 
2.41.0


