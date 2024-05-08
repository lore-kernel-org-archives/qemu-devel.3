Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E05DC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 22:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pZl-0006h1-EU; Wed, 08 May 2024 18:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pZd-0006bh-GH
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:15:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pZa-0003m6-JM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 18:15:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b7a26326eso2013565e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715206537; x=1715811337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4D66cNAv7qIHWiiTBuwSDDuqQfsTkK/hRZN0LCYj6aY=;
 b=Wfkd+b8rfi5hPnJGLyqGtsO6ya9AUFiCOTNAuCAFG7YcIltzpNmmcT1DMlM0jz10IT
 qfKHknx1qpV9J7lCr1m2kHUThQ+DthNtlFztm5V3PQI+1HQV7j21gIudOj+zM09c7uH0
 OdcnTa97stz3i4u5nYT6T6rO4knHXMb8ApylPahaYEEMzeAJ8IALpvjaYqsyQooYT/42
 8CWKEh+fJkcw3eITa3xcmLDWvyhAzzfrR+Za6sfIPmOvRZ7kb7Mb4VZ6ENENMIZiaXLX
 tQKslZ/j/1CKYzdBxVEglQ9/FZj6rVXr54PuQHkYGQTjJ3ygUasfvnwkz7HmKCM2giKb
 H+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715206537; x=1715811337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4D66cNAv7qIHWiiTBuwSDDuqQfsTkK/hRZN0LCYj6aY=;
 b=s5D2tVqfkH/YM4ty/1I6CljKTbIC9dtCCNvJXakaI4dF8m+zbnxrxr3GpHvLMoWEP1
 GqDIX6Ub/32IivNXRO+J/lSudzg+nW/KOAHTT6mA0q/2nLXcgZiOfUmISavdfPTmAEZi
 ilWONmIFrj/sFQuL8lyDLL/gxYvH2kHbDDEpBBCdnoKpn4eeVwAGtSLfCM3k5fPlZr2P
 i/KxFgjqNcvdQ4czlNeSBfazHRi60YKtr5DAr7bs2+/Im46qVjeWF24bztNi8wwZWO+G
 rYbm/TMiAI0t6pxKDRZ7xmNr8D8Rh16CD8radOCCDEYmid1m62Ao42vG9+aiktHMmdCS
 vteg==
X-Gm-Message-State: AOJu0YxLxwD2hSixYsHeGzfzSArcNX8iOTaLJe0L4vS9BnhJoeEyK8lw
 En4p4FchouSWBAfI9NInZO3Bx8K7PFKb1okIbEYWe7gRMOBHpa+majfxUPynW8ar0Z8J3wHxO9k
 V
X-Google-Smtp-Source: AGHT+IGgXjR5q5QwjFgDaeG6bUJ4eSMfbZ81WlZsNIcc48/DDGMkgwA+fO33uzYLaTA/e4Wv30bowg==
X-Received: by 2002:a7b:c45a:0:b0:41b:d4a3:ad6a with SMTP id
 5b1f17b1804b1-41f71ec1adcmr35196295e9.17.1715206536948; 
 Wed, 08 May 2024 15:15:36 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87c254bfsm36824835e9.17.2024.05.08.15.15.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 15:15:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 16/28] hw/i386/x86: Extract x86_isa_bios_init() from
 x86_bios_rom_init()
Date: Thu,  9 May 2024 00:15:18 +0200
Message-ID: <20240508221518.72350-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508221518.72350-1-philmd@linaro.org>
References: <20240508221518.72350-1-philmd@linaro.org>
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

The function is inspired by pc_isa_bios_init() and should eventually replace it.
Using x86_isa_bios_init() rather than pc_isa_bios_init() fixes pflash commands
to work in the isa-bios region.

While at it convert the magic number 0x100000 (== 1MiB) to increase readability.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20240508175507.22270-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h |  2 ++
 hw/i386/x86.c         | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 55c6809ae0..d7b7d3f3ce 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -129,6 +129,8 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
+void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+                       MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 29167de97d..c61f4ebfa6 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1128,12 +1128,25 @@ void x86_load_linux(X86MachineState *x86ms,
     nb_option_roms++;
 }
 
+void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+                       MemoryRegion *bios, bool read_only)
+{
+    uint64_t bios_size = memory_region_size(bios);
+    uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
+
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                             bios_size - isa_bios_size, isa_bios_size);
+    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
+                                        isa_bios, 1);
+    memory_region_set_readonly(isa_bios, read_only);
+}
+
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     const char *bios_name;
     char *filename;
-    int bios_size, isa_bios_size;
+    int bios_size;
     ssize_t ret;
 
     /* BIOS load */
@@ -1171,14 +1184,8 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     g_free(filename);
 
     /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = MIN(bios_size, 128 * KiB);
-    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", &x86ms->bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(rom_memory,
-                                        0x100000 - isa_bios_size,
-                                        &x86ms->isa_bios,
-                                        1);
-    memory_region_set_readonly(&x86ms->isa_bios, !isapc_ram_fw);
+    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
+                      !isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.41.0


