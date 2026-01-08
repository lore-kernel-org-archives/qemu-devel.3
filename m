Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8C2D1488B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr6G-0007QY-H9; Thu, 08 Jan 2026 09:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5x-00072S-Uf
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5u-0000in-36
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so21690025e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882873; x=1768487673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sbu0M+maxtcRxXrgLFp4j1Dj8ytESdyrwiWOp43GF9w=;
 b=gn2BDc8Db/3PE20HBSfrSfyEvv3tAhXbrAG/OBYrOiM5avEcOWyluVpQGLhNojzbqb
 cfN5hBYcIylkU6EgI/uj3/t76/2lZlZ7lEIhsXGINzU9DEJy1G4RYd9vCgBAXygjpksl
 KFcufQ5o14E6fHG5uxPAPn3eW2CFLK4okQfeikOcL/7SVmFgoQApfDZpdusRI1JHBfBK
 TZlDmZPdadJLVwTywwL/yL2+m3lwVCEP7UiLIKW9qQexx1XB5d3kdRTUdyRs2i5BsTCu
 58z9eZXmTOgrVJzO1krHiM+/Qcbc7C8yD7LG9X9GYR0ktJGD7g55pQydDfN33PRhtqge
 HUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882873; x=1768487673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sbu0M+maxtcRxXrgLFp4j1Dj8ytESdyrwiWOp43GF9w=;
 b=ftlkGJW+faMXGgSLKaVhMMCFghlDG0kYaoNwJuVrSN+Gc+2QCD/DhZjUgkTf8/XO/i
 WJqWIn5cPVo92AlaCHesZvzz35aCg/ps/qOFDnVb4kWjIzZqGeqPuZPLA/Gn/1aw+JG/
 SuhA7Ty98qotVTT65++hpm35mXMX9k4wty01+7J4rtI6TjzddsXPiThzWu74I79U4I/J
 7u1/zTMbss4wvxAGICG0p+xxgWQ7Y7awc9Uw2jjtg0tDEnN2GJSZqhbqEVK1KFUfbXKU
 k0x8oa/CXCkzyc9QPTyZRF6tNcBINJyEW7BvDqaI+VPESVqjT47piXbMADGL/VHYDXUu
 DBjA==
X-Gm-Message-State: AOJu0Yx0/iQ4OjcdheiPfkKHxiUT66aSdFTPwhMq1CTlj0Fm4FxOxmQj
 B/hemHKj6MSYXaE4Iuu/7nDN5DQD4VrtrACMoKzlP3+fMq+PBdgn2qGNd9RhJqj4eSysHmB0DPp
 eIx8u
X-Gm-Gg: AY/fxX4iX2J7sp45ocV31BBOG5ShGu9IRGNqOPhQNBG+CUa/J7hiO9J5nAlsjtjrfCb
 GLNVrt2xgultecGn2bD9UjH3TItgOUAbPUrbtFXtmeoiD8Y8kH4z3qNaFiXqU4l5tVCqPEkYPP2
 vJRVMU4jhIkXoP0Cb3RtEGZ1Kvie1CDWXQa53fnnejNg9kjyIMPnRWBxCBa45DmMZPFB0i4Crs3
 Rh27uVG1LPq/Ja16I6fMvEBczSU0gm5Q3SldiUgwOYlYXj7JJzrzoTrfcSAeInwXvAQ116NYlFu
 B6VgOV5vY9QhL3oWa7SsQLmvORrtUxVTwlhqD65LxRI/+yPGtQs8O3DceL4wcrA5xVK1wjkAdib
 /lH1G5a70oBqZrzZYCrR9J8IkZrY5NGQhuSrAV6mZInBJxJn7sZPi+OQlca4hhB0v0kRwsZI1a+
 IjMYRSucu0Czyf7mxkNB/Msw==
X-Google-Smtp-Source: AGHT+IHHSKKF+8FsIcUnpmA+HxWnW4K6jZYoR2rUxPtSe+qc42mC3oncWJhn1rGbKjit/NRtcIjHyw==
X-Received: by 2002:a05:600c:620f:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-47d8f34f2e2mr6490295e9.0.1767882872578; 
 Thu, 08 Jan 2026 06:34:32 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d86637b90sm42599195e9.2.2026.01.08.06.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 48F365F917;
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
Subject: [RFC PATCH 05/12] hw/m68k: register a an5206_cpu_reset handler
Date: Thu,  8 Jan 2026 14:34:16 +0000
Message-ID: <20260108143423.1378674-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

As the mbar/rambar0 values are currently fixed we can migrate the
setting of them to the reset handler as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/m68k/an5206.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index f92a5d6a339..918c376a384 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -15,11 +15,26 @@
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
+#include "system/reset.h"
 
 #define KERNEL_LOAD_ADDR 0x10000
 #define AN5206_MBAR_ADDR 0x10000000
 #define AN5206_RAMBAR_ADDR 0x20000000
 
+static void an5206_cpu_reset(void *opaque)
+{
+    M68kCPU *cpu = opaque;
+    CPUM68KState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    cpu_reset(cs);
+    cpu->env.vbr = 0;
+    cpu->env.mbar = AN5206_MBAR_ADDR | 1;
+    cpu->env.rambar0 = AN5206_RAMBAR_ADDR | 1;
+
+    cpu->env.pc = env->reset_pc;
+}
+
 static void mcf5206_init(M68kCPU *cpu, MemoryRegion *sysmem, uint32_t base)
 {
     DeviceState *dev;
@@ -47,14 +62,9 @@ static void an5206_init(MachineState *machine)
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    qemu_register_reset(an5206_cpu_reset, cpu);
     env = &cpu->env;
 
-    /* Initialize CPU registers.  */
-    env->vbr = 0;
-    /* TODO: allow changing MBAR and RAMBAR.  */
-    env->mbar = AN5206_MBAR_ADDR | 1;
-    env->rambar0 = AN5206_RAMBAR_ADDR | 1;
-
     /* DRAM at address zero */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
@@ -90,7 +100,7 @@ static void an5206_init(MachineState *machine)
         exit(1);
     }
 
-    env->pc = entry;
+    env->reset_pc = entry;
 }
 
 static void an5206_machine_init(MachineClass *mc)
-- 
2.47.3


