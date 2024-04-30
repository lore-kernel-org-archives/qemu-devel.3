Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C4DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p4w-0001BW-HA; Tue, 30 Apr 2024 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4Q-0000zD-Bl
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:02 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4O-0000A9-Bv
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:02 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so6131479a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714489617; x=1715094417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRgm75PlnTxOQz8vg7A+phJJKx6kz6lMxdJhZ2IMl6o=;
 b=LCuBY0yNgpQj7XtGng/pn/bb1UyyebwX89TaLlI4onMgRhYAUECMtlxPo/HUnQZ+k+
 66r6e6D5j0CSZ6zNKNjspvSdsLxrw/4nCe31r+F+powR0njOvswBtKjeMqa9jCSdQfRx
 c0jOyNQPRqMfkBExD3Dfx6UTGOBEXWCGZL/0yfwAJk02dF7IDG+i/tJ/ggYBgoJxMxjE
 R6Pr7jcGRPqksnRY7HViiwGqhZZru1glO3G64BcpIFDl/6uYcztmftUDG0bRodp7GQQo
 Vd4CFgmyh8UpHApqrqp7cPoYo0Bz+PMt2fJKQesX8BNA+GNGrqt1oOFDmTPBajgRbYgR
 f5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489617; x=1715094417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRgm75PlnTxOQz8vg7A+phJJKx6kz6lMxdJhZ2IMl6o=;
 b=nMolnr0STNGG8mq5ThkQgBtmOfvAWD/TsT6lJdYfTaWqtIXYDekcdJUcUOKUdUHrgp
 5L6Gwk4m4tN+SVSe2b7boe2UNjhr28H3kq68JCpCx3yF0xjI7CA5pvXkK5Akkm4OkOkP
 2S8OiCAjwb9kWL1LRyIoXzgHPg8Y8NahXBVPgInLLr5JXS7moSKujQp0GLquZ5KBx3gT
 NKRVpbvRyAqz2hyR+eA78/bhvtIWRvYUv05fmEcvgC0GXufbnPcW/ENl5e4CyJ+UQbSA
 Pr7T0BDaW1znwUpf2L0HFW3wgdJuXYwYemkprQvustv7V3kZXHZBeMVm6qziYnn61j1B
 1xwg==
X-Gm-Message-State: AOJu0YySFRRshVT6k8LDDq37FShfUlQxO7/wjtdiGd0t1mvMfLQRQW4t
 cc91YYTwuv3EKwwhd6leXDrUSjwrCZTW52M0+K5tSS4B7xUNVs7BocT9VA==
X-Google-Smtp-Source: AGHT+IEQIhNkOpKrzXM4VqkWubKD2NvCz6qoRTpbCaUl5t1e4lfMTekm9P7cLlqfvIMvdtz66+B4wQ==
X-Received: by 2002:a50:9556:0:b0:56e:2d93:3f84 with SMTP id
 v22-20020a509556000000b0056e2d933f84mr54530eda.4.1714489617346; 
 Tue, 30 Apr 2024 08:06:57 -0700 (PDT)
Received: from archlinux.. (pd9ed788d.dip0.t-ipconnect.de. [217.237.120.141])
 by smtp.gmail.com with ESMTPSA id
 11-20020a0564021f4b00b005727e826977sm2345741edz.19.2024.04.30.08.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 08:06:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 5/6] hw/i386/x86: Extract x86_isa_bios_init() from
 x86_bios_rom_init()
Date: Tue, 30 Apr 2024 17:06:42 +0200
Message-ID: <20240430150643.111976-6-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240430150643.111976-1-shentey@gmail.com>
References: <20240430150643.111976-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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

The function is inspired by pc_isa_bios_init() and should eventually replace it.
Using x86_isa_bios_init() rather than pc_isa_bios_init() fixes pflash commands
to work in the isa-bios region.

While at it convert the magic number 0x100000 (== 1MiB) to increase readability.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h |  2 ++
 hw/i386/x86.c         | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index fb41263b9d..e92a226d13 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -119,6 +119,8 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
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
2.45.0


