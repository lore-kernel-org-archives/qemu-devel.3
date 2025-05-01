Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96550C3ABAC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYnV-0000ps-C0; Thu, 01 May 2025 14:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmO-0007Kk-L0
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:07 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmM-0007yp-Rw
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:04 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d5e43e4725so3588475ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124621; x=1746729421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7AMA5ZLAGtFwb46rBtPIk1KAapPoLENY9+BSCyDrfE=;
 b=ueT0FKpe6bnPG3qkhWpWNhUu/FJ3RbNGXnMPWKIpb1TUPzuLl7MCHXwzj3BFiVRXMy
 /VL/NwSDIqCh4gYRqRVrKBF7/g653H97U9gRhHXsp4ZZebN6egjNPM2UjAFHtP7kHAd8
 vb4J38hEHx9ZHUIe3Z+YpDXlbZMjHG4vTglYQoGhvnRi+TJmnfTXcIstXz13z9GEJC+H
 vzeDLgvGaW0HbHAFl4WJl77QppyBfN7I9W+UQV6sH8ax6j+oHflXtwTAg9/pXh5k1061
 2ZNK/yQGp4fL2fSjvO5Ya3SSCsaB9Ni4VqRXIu7iFhdApj+v4zIFj03NC2O96bHkMW2g
 fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124621; x=1746729421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7AMA5ZLAGtFwb46rBtPIk1KAapPoLENY9+BSCyDrfE=;
 b=xUom7FnwMtvo7NWe/EELz+9zmE5L22AbWQOKWO4ogqQKN+bDIjiYUTRmXnlhP2VC13
 7JRsMm9yMprHYotAVoZZavFn6FO2NDPbnlw65Yul7+JwP/nfwudWd/VWrGlAPeu+RR7z
 WSd/Qx2leTHY8n4d8gFiUrHcoEHBoSYR3jKX76MEawEFklxUGto6/h1RIqnNX8dP+IzX
 /l9QFKNFc+lhr0zbpACrg6gB4o0bDLo0x3VQyOBIlApfqejcc3JWs8hXKbBiDNec5DnP
 Xwt6Gdk0a+8IRI6Q2Xo/uoNV2S4ThJFo/eyJv3Hhq5aBCN7d85UvORXY+x6f0pA3pc56
 U75A==
X-Gm-Message-State: AOJu0YwG/oxb8GGVoWjDiITeDZsoXPwOCsnyaP3QQuTZrkNg4bPk+mxv
 9agCtCeI9f+4oApGAKAUmttU8eMkNqmKtyOByWOnNtgYofkujXACXWJcgydkTNIOSIhvWIVfezB
 U
X-Gm-Gg: ASbGncuQrNc1MTQNMjFnV8diYsgL/FhyMTJAeMt8jrdHnTLYDxAhn9j/UW6PdbGL5PA
 3+DLZU4Dam2KspZMTlY/hUpJ6LZrdiX+V6GPU8rhDu9HsSsiHFQUxck+giWDK5YNO0HRXzpQcAC
 pTbE/42krwscPBcFKAo/0kM3V2dTNznYcMfVvkBnvRuIyK0bRikx2+J+vSZK7yJUEN0I9I5h+3/
 vR7I3FuMtzyH/kpjvrEBHkRObNhNFtC9iH2+qFBf6W8mHumhwUriVW4aDmDCBmtzUJv1sOGBteu
 6A0zhlKR1z8/GzSBCghLZIzPfRWHl5zbSy/jSIDZyHYCMkEaTPhf/iN43DJ/0CbKolM0s/U4UEV
 pQhQLvxHBTrnkTWvkfzJp
X-Google-Smtp-Source: AGHT+IEbgbYrfwCi4lUJZSoS1gjtceVFTKnF4ENVHIkF7Z80LdhTE5+fiBsGESpUtA+lHn4QE7xS2g==
X-Received: by 2002:a05:6e02:1c07:b0:3d8:975:b808 with SMTP id
 e9e14a558f8ab-3d96f1918famr56293115ab.5.1746124621120; 
 Thu, 01 May 2025 11:37:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882ee3c6dsm309119173.44.2025.05.01.11.36.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:37:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 03/16] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
Date: Thu,  1 May 2025 20:36:15 +0200
Message-ID: <20250501183628.87479-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-il1-x130.google.com
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

The X86MachineClass::fwcfg_dma_enabled boolean was only used
by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
removed. Remove it and simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h | 2 --
 hw/i386/microvm.c     | 3 ---
 hw/i386/multiboot.c   | 7 +------
 hw/i386/x86-common.c  | 3 +--
 hw/i386/x86.c         | 2 --
 5 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index fc460b82f82..29d37af11e6 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -29,8 +29,6 @@
 struct X86MachineClass {
     MachineClass parent;
 
-    /* use DMA capable linuxboot option rom */
-    bool fwcfg_dma_enabled;
     /* CPU and apic information: */
     bool apic_xrupt_override;
 };
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e0daf0d4fc3..b1262fb1523 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -637,7 +637,6 @@ GlobalProperty microvm_properties[] = {
 
 static void microvm_class_init(ObjectClass *oc, const void *data)
 {
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
@@ -671,8 +670,6 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    x86mc->fwcfg_dma_enabled = true;
-
     object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
                               microvm_machine_get_rtc,
                               microvm_machine_set_rtc,
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 6e6b96bc345..bfa7e8f1e83 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
                    int kernel_file_size,
                    uint8_t *header)
 {
-    bool multiboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     int i, is_multiboot = 0;
     uint32_t flags = 0;
     uint32_t mh_entry_addr;
@@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
     fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
                      sizeof(bootinfo));
 
-    if (multiboot_dma_enabled) {
-        option_rom[nb_option_roms].name = "multiboot_dma.bin";
-    } else {
-        option_rom[nb_option_roms].name = "multiboot.bin";
-    }
+    option_rom[nb_option_roms].name = "multiboot_dma.bin";
     option_rom[nb_option_roms].bootindex = 0;
     nb_option_roms++;
 
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 1b0671c5239..27254a0e9f1 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -634,7 +634,6 @@ void x86_load_linux(X86MachineState *x86ms,
                     int acpi_data_size,
                     bool pvh_enabled)
 {
-    bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
     int dtb_size, setup_data_offset;
@@ -993,7 +992,7 @@ void x86_load_linux(X86MachineState *x86ms,
 
     option_rom[nb_option_roms].bootindex = 0;
     option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+    if (fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     }
     nb_option_roms++;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f80533df1c5..dbf104d60af 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -375,14 +375,12 @@ static void x86_machine_initfn(Object *obj)
 static void x86_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
     mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
-- 
2.47.1


