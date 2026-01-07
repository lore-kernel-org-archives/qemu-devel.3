Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA07ED0D172
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vda7D-0003yV-8I; Wed, 07 Jan 2026 15:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda7B-0003vt-P0
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:45 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda78-0006T0-T7
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:45 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso1328015f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767817600; x=1768422400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCJOHklqjP8knzo5ZIRFytt5dYZtQRrh9H0n2o/TRQI=;
 b=kfQO+4ZoX8AHY59JqKPvcRHWVhhBWnAJ3BocIV3ma9jZOZEpnactBPJPT1hp2k3Anj
 V0hhi6Mm+mJoAOUyQz5h6aNInCxPsF5VxVYUMqzYfMQIMxDCfy170w9YPOIVH2wAamOb
 MG+Q47/KpcN9NUfXNiSd/x5Y8IeMMMRPnXzjGWE8zymf5RaQlaUHKJ+3wK7d6lRxTosE
 +JN7K9aZYHuLnVSXw7RX5PpUzYBiTTncF2UUQ1XJh/r7xAeAsFekYzqzQ4gtOVux6lUf
 LxFG4DSuaBBE22Ys1JMrREiV9d+PleNUIsEYPn32jc7UBtJH46K97YqXe4T6JhObrnrw
 uE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817600; x=1768422400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fCJOHklqjP8knzo5ZIRFytt5dYZtQRrh9H0n2o/TRQI=;
 b=IjaR8zMwguHmGLHXr9RtZvLqcQAu6sqRSpvb78pddbFJ6q6dMwZYFLGoHDF635GQ1r
 MRJJ0sKNLbkPHAt5bqkuofQnwMnBUdwaPtr2TjMEMEoBfrfVHoF+2epohCSf8zsD8R9S
 wt9BCOyZkGz3SI/Fa1ahtN/8wmRgKhccuIUS6XaHwOvPOUhsDVE038N8zeIRMRZqAw4k
 RoK4htNH/QNCGgO4a5Exw2gySNh7PB4EV3VVRCkOPaozv1rLVx+YaDAO/E8VoHwwLTdR
 oiJFRKQZGAwW21KSvC8F5HQLgFdPKNqW+6RRqTKLxxx5nLpS+4CczXDW6zege7QteOB1
 jtJw==
X-Gm-Message-State: AOJu0Yzj7QvrrqptFEENnQsfK58z7AArRTOP3wE1wSgNmTfdBQaWOT3T
 Rz6LZej4si49LOx++zChYkoJEPlpZ4tU0tg8WbdwkIJZZIc2oXrf+IOSkFqGQt8HJ3nJwyqopiu
 4zrvNnzc=
X-Gm-Gg: AY/fxX7a6KAfLo+WIEr5qYIE5JnNU9aCYYQkXZbIFvtjdfby8Y8AadwdkoMJ2tcUQut
 2/7cVfVnLXaWFt8Q+zAMQz8XZhrVwLxCUJvm1SrZkxnnR5iP34cToOUn87wGC4hiqyqbJrmaBwE
 fCmpwiAAxiBFP7ORlgAZti+XOLz7XERutWy3fy8zowEhujW4JhGBXd/G68k4RhdLaLEqskhKhE7
 +oKYNxF17vqSgqQSiUG9lGWtq2y3bjrsA9gznHc8m7E26lVlEXX8KC114Ie07uza9yqSqkLIQLw
 rss0IoVVVGre9gVlmk2EzAkjknxmrbi0QTSbT7l59OaRzJQztkRQA2cUu6YMxqwvjm7x7GQX67J
 vPPGS8P6zW+xbl5CUSpAFKO5NreHSs6WwX5rOKuiwYYemQkj/Ewxu/YhekZw5t1o6kV7S8oQMyI
 +oA76K6NEAZwiC0qUfpYtHJs5T+CdA/MmZMBW/gb2VwDIL5tEiDtmLTFal0CaGzGnU0wYdUL0=
X-Google-Smtp-Source: AGHT+IFAgID/2wBRBgV0m2B7lR4lvHlcE/hTHLEZ4spNrPOr98FoPO8sltPA+JysiTLGGXPLCYCqdw==
X-Received: by 2002:a05:6000:2c01:b0:431:8bf:f092 with SMTP id
 ffacd0b85a97d-432c3763558mr4952431f8f.43.1767817600231; 
 Wed, 07 Jan 2026 12:26:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa84sm12116584f8f.2.2026.01.07.12.26.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:26:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] hw/xtensa: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Date: Wed,  7 Jan 2026 21:25:55 +0100
Message-ID: <20260107202556.55787-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107202556.55787-1-philmd@linaro.org>
References: <20260107202556.55787-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/sim.c    |  3 ++-
 hw/xtensa/xtfpga.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 03dbe69c2d4..3a5ac8d67cd 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -34,6 +34,7 @@
 #include "elf.h"
 #include "system/memory.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "xtensa_memory.h"
 #include "xtensa_sim.h"
 #include "target/xtensa/cpu-qom.h"
@@ -102,7 +103,7 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu, MachineState *machine)
         uint64_t elf_entry;
         int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
                                &elf_entry, NULL, NULL, NULL,
-                               TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
+                               target_big_endian() ? ELFDATA2MSB : ELFDATA2LSB,
                                EM_XTENSA, 0, 0);
 
         if (success > 0) {
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 3d7afcad4cc..150fcd24f15 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "system/system.h"
@@ -313,7 +314,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (dinfo) {
-        flash = xtfpga_flash_init(system_io, board, dinfo, TARGET_BIG_ENDIAN);
+        flash = xtfpga_flash_init(system_io, board, dinfo, target_big_endian());
     }
 
     /* Use presence of kernel file name as 'boot from SRAM' switch. */
@@ -402,7 +403,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         uint64_t elf_entry;
         int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
                                &elf_entry, NULL, NULL, NULL,
-                               TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
+                               target_big_endian() ? ELFDATA2MSB : ELFDATA2LSB,
                                EM_XTENSA, 0, 0);
         if (success > 0) {
             entry_point = elf_entry;
@@ -440,9 +441,9 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 0x21, 0xfe, 0xff,       /* l32r a2, entry_a2 */
                 0xa0, 0x00, 0x00,       /* jx   a0 */
             };
-            const size_t boot_sz = TARGET_BIG_ENDIAN ? sizeof(boot_be)
-                                                     : sizeof(boot_le);
-            uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : boot_le;
+            const size_t boot_sz = target_big_endian() ? sizeof(boot_be)
+                                                       : sizeof(boot_le);
+            uint8_t *boot = target_big_endian() ? boot_be : boot_le;
             uint32_t entry_pc = tswap32(entry_point);
             uint32_t entry_a2 = tswap32(tagptr);
 
-- 
2.52.0


