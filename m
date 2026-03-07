Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3279FCB602
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytYU-0004y8-QL; Sat, 07 Mar 2026 10:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYT-0004xy-Ru
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:01 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYS-00084s-9x
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:01 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so5201145e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897218; x=1773502018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+cnL7rrglnAkX3oC4Hnt8yatSlp+vMC4sJA5HGzfMk=;
 b=WPNPnAkrs0+hQw/bcNc0qoCd1pJH7qLzZI/9dCLXfmuz1PzHynxFNoq9eTYSsjFtt0
 bvuP51zNgJ8rnOZ5xUrkMU2Bi+sxI5PLKKr3NmnXNCUukRFheMVFjNBFVXPZkdCcR33x
 Cy63R49kfqIzugdY6YAL6RZuVaoEvAXrjb5KE5qpLKbXij1PwbZNtHVQNCFFMl7iMTG5
 M/C3gV/EfuYMa6n58j8Kl+Ese35Bm32plHeXks5NdUniKwS0+R5a1mZ0OmEgjDY2xT/V
 YYOb6Nonu+dJ/jA469t9KrWTRmGnafs6Y/TnR5pnQetUJddTjrPPt9qZ/e8KK0Vnsa2a
 xg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897218; x=1773502018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+cnL7rrglnAkX3oC4Hnt8yatSlp+vMC4sJA5HGzfMk=;
 b=Vxpz7XtvJbQO//lZ2QfYQ9t92G0C0cf4+qE6fa2BVuUtDLyRGDzgJQ8ZHuCpyt9NiJ
 AGB+CL/OlON+tlIZSXw7D2Jo5ClPbZW8+R/2orxe5cf5+e/VJ4L8In7QSBF6M0ZhHoRi
 3BE4d5DeLe6T5QxWWKDjl1Wi2bybDCNcNOLm6KsQ3Qk1O3D0i6Q5L0PJTzbYAwZ7AM4l
 oEy6EDdLuWQLUZlXBIocMVjFegAoe1nsqHavUp8UlmIjHDdl9Z6GUe2d4wWe1o8f+9hR
 VHfybE2efNO9jL7SazJSNnjnxH5P8AzD+P77JyRJWLug1aUMEAu9Bq0y5JhBMHBec8zd
 K9BA==
X-Gm-Message-State: AOJu0Ywy1w1HBIvRVOKmGDMl54JACfUjYn0uIa2ew9HBZSOs4PYb7GKv
 CdBwys1yA2zF6OCthwJLmxgl4BmAPv8U5n0msAQ87q2eck8djb5+19GWLz9JYrUYS/qzoKKO34A
 B5bPNtK8=
X-Gm-Gg: ATEYQzyMkcuiGMGndJU4T0nb0klEy9/cL/9dKIhDa0OOZjg1y+023SZZtrlNy+Lfzc6
 FUsrkZGF1jZf/O5rCIBpb3zdW3+Xk5PiB1/kibZB9qe3VdT5wCxx6o0z/YovNabzTm1OKn9z2Um
 AhToG3xeyuLkRVjHUqGup+hTPkzxsDdlpUL7acqPEYWNyPeGkG8BeaCdeIQBFdKFcv97CRIu/Fs
 2lbP9AYR2k+OBGdaqgplBFhI0/eusDN2C8HWkGb4l3vAetR5/FXeviKg8yxYOjIhHX0yWzemCNB
 No92f472fiTOU2+QIjRC4YbRToka4z6XECe6NoHtxLrbBFYpoDnEbThg8cR7KAdnyKl3Ubt9phO
 HscnGdKS+jaOCoq7Tu5AlrWvALLnJGMAvGGG29IOsFJC5i+h6njGZMMY9G+5OPHXdvmMSwDEwIH
 MMrouCQHI1+AcW5m3ACez9WTKTJd1+dUDtN9/pXpwbat4zGI8NWje8/3lVKFAP58Mj5Wb6csjL
X-Received: by 2002:a05:600c:c117:b0:485:2f6a:6ed with SMTP id
 5b1f17b1804b1-4852f6a07f5mr27134405e9.28.1772897218501; 
 Sat, 07 Mar 2026 07:26:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb4257csm313924355e9.15.2026.03.07.07.26.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:26:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexander Graf <graf@amazon.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PATCH 03/10] hw/i386/x86: Remove @pvh_enabled argument in
 x86_load_linux()
Date: Sat,  7 Mar 2026 16:26:27 +0100
Message-ID: <20260307152635.83893-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

x86_load_linux()'s @pvh_enabled is now always %true: remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/microvm.h | 2 +-
 include/hw/i386/x86.h     | 3 +--
 hw/i386/microvm.c         | 2 +-
 hw/i386/nitro_enclave.c   | 2 +-
 hw/i386/pc.c              | 4 ++--
 hw/i386/x86-common.c      | 3 +--
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 6b9a5065272..184b7a8c094 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -79,7 +79,7 @@ struct MicrovmMachineClass {
     HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
     void (*x86_load_linux)(X86MachineState *x86ms, FWCfgState *fw_cfg,
-                        int acpi_data_size, bool pvh_enabled);
+                           int acpi_data_size);
 };
 
 struct MicrovmMachineState {
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index a85a5600ce9..71fe6b5e122 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -129,8 +129,7 @@ void x86_bios_rom_reload(X86MachineState *x86ms);
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-                    int acpi_data_size,
-                    bool pvh_enabled);
+                    int acpi_data_size);
 
 bool x86_machine_is_smm_enabled(const X86MachineState *x86ms);
 bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 7ff20512636..5a7889f21b8 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -330,7 +330,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        mmc->x86_load_linux(x86ms, fw_cfg, 0, true);
+        mmc->x86_load_linux(x86ms, fw_cfg, 0);
     }
 
     if (mms->option_roms) {
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index 640b1d8c548..8e72dc49f34 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -199,7 +199,7 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
         machine->kernel_cmdline = eif_cmdline;
     }
 
-    x86_load_linux(x86ms, fw_cfg, 0, true);
+    x86_load_linux(x86ms, fw_cfg, 0);
 
     unlink(machine->kernel_filename);
     unlink(machine->initrd_filename);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 107f12cbe73..b11afa0531c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -606,7 +606,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
+    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
@@ -940,7 +940,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
+        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index db8d4e855f4..fde05fa7d7b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -642,8 +642,7 @@ static bool load_elfboot(const char *kernel_filename,
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-                    int acpi_data_size,
-                    bool pvh_enabled)
+                    int acpi_data_size)
 {
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
-- 
2.52.0


