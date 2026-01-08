Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDACD1D460
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr5z-00075O-KL; Thu, 08 Jan 2026 09:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5r-00071B-3u
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:33 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5p-0000gm-8C
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:30 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43277900fb4so925423f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882868; x=1768487668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrvdGZYfUVb/G7Ck+UxozbwBKfyc29iJxW1XdKqiM0k=;
 b=WyGdm3xQ59BQsfUKgWOkLSVQzWu9j/s9Zkw+xNuHNdXgi+GOujx87FAOevePisW8pJ
 foJo2lXXNSMZqMm+E/HuIsuarocykrHXcbHuSod+bOJ6baXY9smCM/0nP8qpct+dN0bD
 oVxL5hYVIq6oN7suCKVWg8V17AnmjdUgB7QxArTEB5KpHA/ZaQAMPc5ASLKJ2mnZtsZT
 U4bfn5qJZH48ULHsEQsMaLZiWmSB7Jr5FPb+F7EaFNlDOhcvQvp2Jj7Zreir2uQLYuzj
 2jGhJac2JMVg3vdY9kecBcG0Ur8wV6NbIOi3fxQ3o48641y8c9vEqeo0/bQI2WlWTwvB
 ZDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882868; x=1768487668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JrvdGZYfUVb/G7Ck+UxozbwBKfyc29iJxW1XdKqiM0k=;
 b=g3CBxA65SRjl15HL0KOO54p3TWB7vhdv3m5DgF7lc8fe/DiaQWmgsfe6I4t15fM9Xd
 KTy9czjvp11WeyuopTQkydFnEQq6syCill8ohfLdUynezf6RsFRRNP/OWwaoJyLQ2WnM
 56UxdyNUXWRWDOXZvLWG7zrRZqHRSlKfdKOx5JaOG1uQmAQYh2bKKyQJTZHHnpFnI2VS
 VCYsE1706IR4s70TKS/QDCvUFHCPiKPRwIcoeZjz1argSLTrxtNcDzhJf310+iasbpUL
 hD//x3pKYSk8AXBex/bmoXKeFQI1Jvh0d4eDV8Mg0n7JfGZMKaTr01OiPwEPDQXZFSsy
 vOqg==
X-Gm-Message-State: AOJu0YzJmsxpHdNnpjhNCkMkRG9NSkzzoBK57pY2JgBH/9jEzSPxV0wI
 h2ip/6Hsy5dGmZf/7g7OvDjwHITyh/6F6WSB+T/FpnP4iU0DEQHye6IgsfTclredpn8=
X-Gm-Gg: AY/fxX759gEhY4ZliS7bozWvMpYcS7zS+1sH1cK41pOnGSH0k0vBSWYY3mkVvPtAmMK
 FtoqEyBVH1AR3UU26m//tOpdV0JelFCkLMLgj9FFzCFjlkRc50NbWmRlSxShJz01CbmtNrWBtts
 uTpBXf2g03RTzXXQIpKQLRDzZFPZtypeERkb+LzJXtggnz+Fz+gYTRbl6w2oAz8i3VQ5gyNaQnb
 TwgePwlanYECqAOIQZFVdJBr+T6bDgdvxfkvjCnbu+FZJzGA1ASM6vLFScs6IqbPYZBGaE+R6JN
 a10g61JicqRYcqLtgEyMMO5+frRqfFbOHGsCrDP/frHrP+RRDgBkuaeRWqScyL3Eocp10OJxmw7
 kdtDiQU4w4JDh2ulPjfFJ/9xGI5pVS4cuxzk2pvNstSrmUQ3zIKB9TOdLNZ9Fxgwz0nRsTo4M2d
 b3jtR4n+QJOk8=
X-Google-Smtp-Source: AGHT+IGDHIfwJErYbSMAyAu5Hd64Y5pQD62DUstZYKJavFXL02WDUeDl9svWVvVL744sh9c/Ayw0Dw==
X-Received: by 2002:a5d:64c7:0:b0:431:327:5dd6 with SMTP id
 ffacd0b85a97d-432c3634312mr7519174f8f.8.1767882867572; 
 Thu, 08 Jan 2026 06:34:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df939sm16366478f8f.21.2026.01.08.06.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 351915F90C;
 Thu, 08 Jan 2026 14:34:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 04/12] hw/m68k: register a mcf5208evb_cpu_reset handler
Date: Thu,  8 Jan 2026 14:34:15 +0000
Message-ID: <20260108143423.1378674-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

It looks like allowing a -kernel to override any firmware setting is
intentional.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/m68k/mcf5208.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index c6d1c5fae9f..5680d516a23 100644
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
@@ -274,6 +275,20 @@ static void mcf_fec_init(MemoryRegion *sysmem, hwaddr base, qemu_irq *irqs)
     memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(s, 0));
 }
 
+static void mcf5208evb_cpu_reset(void *opaque)
+{
+    M68kCPU *cpu = opaque;
+    CPUM68KState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    cpu_reset(cs);
+    /* Initialize CPU registers.  */
+    env->vbr = 0;
+    /* TODO: Configure BARs.  */
+    env->aregs[7] = ldl_phys(cs->as, 0);
+    env->pc = env->reset_pc;
+}
+
 static void mcf5208evb_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
@@ -289,11 +304,9 @@ static void mcf5208evb_init(MachineState *machine)
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
-    env = &cpu->env;
+    qemu_register_reset(mcf5208evb_cpu_reset, cpu);
 
-    /* Initialize CPU registers.  */
-    env->vbr = 0;
-    /* TODO: Configure BARs.  */
+    env = &cpu->env;
 
     /* ROM at 0x00000000 */
     memory_region_init_rom(rom, NULL, "mcf5208.rom", ROM_SIZE, &error_fatal);
@@ -359,7 +372,7 @@ static void mcf5208evb_init(MachineState *machine)
         /* Initial PC is always at offset 4 in firmware binaries */
         ptr = rom_ptr(0x4, 4);
         assert(ptr != NULL);
-        env->pc = ldl_be_p(ptr);
+        env->reset_pc = ldl_be_p(ptr);
     }
 
     /* Load kernel.  */
@@ -388,7 +401,7 @@ static void mcf5208evb_init(MachineState *machine)
         exit(1);
     }
 
-    env->pc = entry;
+    env->reset_pc = entry;
 }
 
 static void mcf5208evb_machine_init(MachineClass *mc)
-- 
2.47.3


