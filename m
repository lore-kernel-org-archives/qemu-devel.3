Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E46C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNE-0000vX-OB; Wed, 08 May 2024 13:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lN6-0000eF-58
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:34 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lN4-0007rC-DT
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:27 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so7985666b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190384; x=1715795184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQ4w2/+EqpgnI71e92633PGSLkfTtg3h6pqel4U0YZE=;
 b=KsBl4vSgfvD7k5Z5erU5fDEwiMSzrVgksGpeJdzI8Nwgi+HvdPVrbfSnnTXmb2zaZw
 jQvAXW9F/7X0QHTPywN9ECDLpf2O9qIJHu7OP2Uf5Firs90mkr9RFjXdq7pfAYWBgZXb
 12oHqLiQIU/5yNSdhLMs/OQQlgjrfqDPWHV8f3iURR4DNM6ofSKf8FyP/icTtzURtFYj
 BhOgd092Q/nwIfS95Z/EJzq5AkoEUrUo8i2lAfAFWEqH0eSW+uXy13Frbe/tYLNhh26j
 HJ8ZrOXPxHOzwJH5PvwYWi9QnO2hoMXqncl1Y4VYMsFbpWPgiaktxRFQxl84YvzTS+kz
 pXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190384; x=1715795184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQ4w2/+EqpgnI71e92633PGSLkfTtg3h6pqel4U0YZE=;
 b=lqh1/c24kcl86QXzH4T8utUDAliMF5U1Ty2gN2v1cunG/fR2vcPYJIN1SbMsgYhTeG
 rxvFLLD5DQ/1ih4swz+KIMfZNRI5gaCur1yXguL9gphPJSHsRIwHd2yHoD8PyElWi+A0
 naQWWiF0GkXuYtoYU8UOaPQMI5UWiPQehgfzJLz0UCpWLbIlF3II/CPQsJhMk4vIWNxy
 G+bgGWkf0XkRiR1JqvcNY+Bm5yJP1G8X+qTSc1iY/frbyQGFIWonnJBD77R4KZ+sjhh8
 51TGFd74FROpbnGRorIad17uMl7/+/158YzFBcaL5UZSWAP3dQBmLCF+OKht+PpCQd0Z
 uW9g==
X-Gm-Message-State: AOJu0YxEqhdUvhsJlfZts7ikpPmeHHCSxQO7ibD77G6oufxmjVvznXRH
 nvfpnYeWA965kj1rAwy7DfJqV9Iai8D9wKBuPv4e75/WAIA1/bAZKb5SDgz1c5oDXSMU5zIFXuP
 Z
X-Google-Smtp-Source: AGHT+IEiKagKtza5aT6L4ZLuI7SQGF0EJkTsZHvIeE8YpRcTC+ECbCTzCurXnviFiIySRsajpy3OnQ==
X-Received: by 2002:a17:907:7ea1:b0:a59:c698:41ae with SMTP id
 a640c23a62f3a-a5a1180eb0cmr29319766b.34.1715190384076; 
 Wed, 08 May 2024 10:46:24 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 mb15-20020a170906eb0f00b00a59cc6d06f2sm4123186ejb.218.2024.05.08.10.46.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/26] hw/i386: Have x86_bios_rom_init() take X86MachineState
 rather than MachineState
Date: Wed,  8 May 2024 19:44:57 +0200
Message-ID: <20240508174510.60470-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The function creates and leaks two MemoryRegion objects regarding the BIOS which
will be moved into X86MachineState in the next steps to avoid the leakage.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240430150643.111976-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h | 2 +-
 hw/i386/microvm.c     | 2 +-
 hw/i386/pc_sysfw.c    | 4 ++--
 hw/i386/x86.c         | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 4dc30dcb4d..cb07618d19 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -116,7 +116,7 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
-void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
 
 void x86_load_linux(X86MachineState *x86ms,
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 61a772dfe6..fec63cacfa 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -278,7 +278,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     default_firmware = x86_machine_is_acpi_enabled(x86ms)
             ? MICROVM_BIOS_FILENAME
             : MICROVM_QBOOT_FILENAME;
-    x86_bios_rom_init(MACHINE(mms), default_firmware, get_system_memory(), true);
+    x86_bios_rom_init(x86ms, default_firmware, get_system_memory(), true);
 }
 
 static void microvm_memory_init(MicrovmMachineState *mms)
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 87b5bf59d6..59c7a81692 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -205,7 +205,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
 
     if (!pcmc->pci_enabled) {
-        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, true);
+        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
         return;
     }
 
@@ -226,7 +226,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
 
     if (!pflash_blk[0]) {
         /* Machine property pflash0 not set, use ROM mode */
-        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, false);
+        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2a4f3ee285..6d3c72f124 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1128,7 +1128,7 @@ void x86_load_linux(X86MachineState *x86ms,
     nb_option_roms++;
 }
 
-void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     const char *bios_name;
@@ -1138,7 +1138,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
     ssize_t ret;
 
     /* BIOS load */
-    bios_name = ms->firmware ?: default_firmware;
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         bios_size = get_image_size(filename);
-- 
2.41.0


