Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6932AE9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fZ-0005To-RT; Thu, 19 Feb 2026 12:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fR-0005OG-Ra
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:21 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fQ-0000SF-2v
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:21 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-658b6757f7fso2313542a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521498; x=1772126298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNFbszyLV6dYFrNFoEy5UENmIo/yFnvFimQs2acqFY8=;
 b=ZjRjmN8VxoEu0dbM5Mrh80oxgVJ1k0pfA0T3kX1VniDbUU4XRIuP4dX9l/BYPrq+sH
 3jrtjc2FbREejBWDdYKEvmYnReJYxJvatMpYB39NubutvgOelw5j8CKvLyCRbOfseuEs
 pQRPZZ2z5OPt/YqgAXt36sFSBLr82zTkCcPNak3beY/e/fSLDIxfPhghFl9ep5lz9LaB
 mlUyi+dRN2ninMukpVm7Lw1hRT7keiF8PupixLoG/NA0icuEyP/vsegElJ0nHx8BKvjc
 Pn3gE3jryP+DQ+gsKFXS96w8XPW/KbuKcpzzx8XmYZ0Rl1fXeeUX+DU65xpP7eaBIrY0
 uLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521498; x=1772126298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HNFbszyLV6dYFrNFoEy5UENmIo/yFnvFimQs2acqFY8=;
 b=HE0PO4Hf9fJBRH0eHfuVzysQPNSaYZR6nllp/xlq9/4+XAAbA4mibWGH+Aq7v0c8pT
 vYb9jLBLRNEBWIctiZa+Dx/6Vsv9HzXluMBNp5yPf9yPK81GLQyP7BC/QlOGbc9FLgH1
 80kGNVnrCe+2HthaRZB6O2MFfQzVAYqLISME7IoW5P1BFpY97aSfAz7Ec/d01++7fSRi
 UcLT1ZYdvozkkCsk2VCKfxVGNC720NjWr/YSEXE+U6Wax+jdGSl3mf6Parf3Xbat5/tl
 y3Phfz2Lb/S6/+ATOfJ738xeka6jTV0MuZeZy24JFYvfqBZneIPcomNOLuk6AJ7CmD/O
 HRag==
X-Gm-Message-State: AOJu0YwMzZF7iaqtOqO1pSecRgrW9DuE0/dD2Xu64RXX4vwWh48TUp87
 triJrHQuEgf0MP3smqIcwrIWl+3bScPY5uSSx7GBnrtMiE+g2H/6oESReV7tVEKTwZs=
X-Gm-Gg: AZuq6aJkvGHGJ8PP/T7h0P8HVFxqef27Ikx0A5Rh2E4iixaRCzS8jm/+Y00zjJ0wMxc
 O8ZxNr+4aRukMykvb4+woKTGnl/Z705K1oc1TsnxUShNKD6pz/UNmNo96k6PhCreTbDYkrlfTbL
 ozBahSUEFIdVKtsE40B0AzhWtD5GojqMl9nDNvU8yP4mMym3+6h64Y3hqduTqtZ1wZeRSmiMjUq
 aINNY3E0QQA9ORwfIQ2DhvyUn4k4vVuwesg7Fku6t8RdARwnvuSQTFtkbIEjRPD28mo8+qxK0ns
 jhM4wUwBorPBxcw5ADmLwnKvb+Hx+5zeDwFlSa3hGq7favwmtMOi4HKmA5Zo/g8zXchmgbyp6Qq
 7ohMa5Z7Fg3AN/qQuBByZwhzmoF4dW3tKGJUHcbUBvMo1Z28kRtsBzgXbJ8h1rwrnCMgjIFDujS
 Sm/gkwvSEtQFAgym/kSN79X+PP9BtzSyMXrw==
X-Received: by 2002:a05:6402:5207:b0:658:b029:9e50 with SMTP id
 4fb4d7f45d1cf-65e4f76df95mr1538580a12.12.1771521498318; 
 Thu, 19 Feb 2026 09:18:18 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad3f137dsm3928037a12.27.2026.02.19.09.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F41195F8BC;
 Thu, 19 Feb 2026 17:18:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 05/14] hw/m68k: update mcf5208evb to 3-phase reset
Date: Thu, 19 Feb 2026 17:18:01 +0000
Message-ID: <20260219171810.602667-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - rewritten
  - favour cpu_reset over resettable_reset(cs)
---
 hw/m68k/mcf5208.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index c6d1c5fae9f..38e2d1307a6 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -27,6 +27,7 @@
 #include "qemu/timer.h"
 #include "hw/core/ptimer.h"
 #include "system/system.h"
+#include "system/reset.h"
 #include "system/qtest.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
@@ -274,6 +275,13 @@ static void mcf_fec_init(MemoryRegion *sysmem, hwaddr base, qemu_irq *irqs)
     memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(s, 0));
 }
 
+static void mcf5208evb_reset(MachineState *ms, ResetType type)
+{
+    CPUState *cs = first_cpu;
+    qemu_devices_reset(type);
+    cpu_reset(cs);
+}
+
 static void mcf5208evb_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
@@ -289,11 +297,8 @@ static void mcf5208evb_init(MachineState *machine)
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
-    env = &cpu->env;
 
-    /* Initialize CPU registers.  */
-    env->vbr = 0;
-    /* TODO: Configure BARs.  */
+    env = &cpu->env;
 
     /* ROM at 0x00000000 */
     memory_region_init_rom(rom, NULL, "mcf5208.rom", ROM_SIZE, &error_fatal);
@@ -343,10 +348,7 @@ static void mcf5208evb_init(MachineState *machine)
 
     /* Load firmware */
     if (machine->firmware) {
-        char *fn;
-        uint8_t *ptr;
-
-        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
+        g_autofree char *fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
         if (!fn) {
             error_report("Could not find ROM image '%s'", machine->firmware);
             exit(1);
@@ -355,11 +357,6 @@ static void mcf5208evb_init(MachineState *machine)
             error_report("Could not load ROM image '%s'", machine->firmware);
             exit(1);
         }
-        g_free(fn);
-        /* Initial PC is always at offset 4 in firmware binaries */
-        ptr = rom_ptr(0x4, 4);
-        assert(ptr != NULL);
-        env->pc = ldl_be_p(ptr);
     }
 
     /* Load kernel.  */
@@ -388,13 +385,14 @@ static void mcf5208evb_init(MachineState *machine)
         exit(1);
     }
 
-    env->pc = entry;
+    env->direct_kernel_boot_pc = entry;
 }
 
 static void mcf5208evb_machine_init(MachineClass *mc)
 {
     mc->desc = "MCF5208EVB";
     mc->init = mcf5208evb_init;
+    mc->reset = mcf5208evb_reset;
     mc->is_default = true;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
     mc->default_ram_id = "mcf5208.ram";
-- 
2.47.3


