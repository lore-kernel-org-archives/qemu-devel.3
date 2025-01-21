Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B6C0218E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGxa-0000RD-Jc; Tue, 21 Jan 2025 11:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxY-0000QL-Uu
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:36 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxX-00060V-8C
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:36 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so5145797f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737476313; x=1738081113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9F5G+EcENNTFhblljg4GhllRgsxg85NXRho6Bc5oIjk=;
 b=riFpidDK/+rvtxGm2DB11zRvudWLvId8tHlNq+3yC0Y0gn8h+JKguAcJ8tJBk4DQoJ
 uHKlABB2BfEA1UHdUsMWHns4zVxUKC6Hv67Uv/lydhgrmOOA+KAzBUQRL4D7oi+dVXjv
 /OeUhIGXgMa2AI52UwLHmwGlZOv1DneP8HemDcq3eHgIoxiD6dtP2N4hceI9EYZRVXC5
 aXEHcpjpVumC0i/lXAnv/ZlYwHfAtLa8a40CQndtpp+e7v1hfbnrBReGxK1MY5+BdxmP
 8xNE+n8sv+VRCgd1Ukii0whnNDK6XDJtSmyBBYb/LBQ5R1oXskrwwvw+SdnvAlikf2/k
 degg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476313; x=1738081113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9F5G+EcENNTFhblljg4GhllRgsxg85NXRho6Bc5oIjk=;
 b=Iyj2/dX1YLUDE+H5Ii6l4PwN6C9fCJwq/gl5IUB/0cw7PThYaYrZ0oc7jQ5/1B3i9m
 OKHQvHuuP2rWazfnfIThQcJgU4Otv6A9y8VDCqXHFkjnlAzCOXPrF31u1/y+N8GTxJDW
 /Dfs2yAq2xLNe+7iqF8CntbisUKevty3jJDHbUCiQw8wEmetE58d4YizL74DVWGiMA+Z
 56M/+c7W982Hj/5DOGu0VyJC+qWHdFe7Z6nYF/MzOV7ss38TPqJWeuslpVd1Elp0hLIo
 WiHK9XyRMEC0DELwZfLkkYdOwOFZTVDSfBkEHZ3MiOxWkgffLG1VG77aNRj7cEdL8LQk
 oKiw==
X-Gm-Message-State: AOJu0YzwYp9QivpT+1/cV3tXC4M0SM40ncrdCTL5euCp9T4qSCDonGiu
 UKNkqIU+H8JsJM+HG/jLORlsR3L5JMmS66ckaG3IotaL/wkRyVX85dmhj/7k5LwImZOkN9Gr1h7
 dHgA=
X-Gm-Gg: ASbGncsqJskp0ipiqurdEd1PjKDw0cgXMWoEWvnV+lvrsLoks9ihlbedcZplmOzGJht
 uyGWjDLknsXskETvs9qd/gLCbfw0tNM+YzU7uotKsOKeJNZcyVCti/oRj+m/J0vzSL0QbKL+Pa0
 04zd/k4iKf7oad7PazMcDJyV3LoqkzgbW+MEDFMJByz7xSjGB5+rQPoNqZxcfHilbt/+LWqX0sQ
 d71A5zothe6Ej1YeC1ekOwk2FF/XbRNper2cg+0G9sTFwaH0QDlemDyTnpyLaJq+Hd27BlOh6dW
 nfQdCPNErTTFjU/cRwxkb9VW4rOoGUeIRzGlDe1kTUOz
X-Google-Smtp-Source: AGHT+IHyD1OyEejg3KwiYKZPeG5lIBRojV9nsSWa6HQA99IbEAqG8O1CxBiVLkEk1Y3f88P4/pUCGQ==
X-Received: by 2002:a05:6000:1445:b0:386:37af:dd9a with SMTP id
 ffacd0b85a97d-38bf57b76a4mr17831665f8f.35.1737476313299; 
 Tue, 21 Jan 2025 08:18:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ad74sm13989453f8f.56.2025.01.21.08.18.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 08:18:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 3/6] target/mips: Initialize CPU-specific timer/IRQs once in
 DeviceRealize
Date: Tue, 21 Jan 2025 17:18:14 +0100
Message-ID: <20250121161817.33654-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121161817.33654-1-philmd@linaro.org>
References: <20250121161817.33654-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

The MIPS timer and IRQs are tied to the CPU. Creating them outside
in board code isn't correct. Do it once in the DeviceRealize() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/cps.c            | 4 ----
 hw/mips/fuloong2e.c      | 4 ----
 hw/mips/jazz.c           | 4 ----
 hw/mips/loongson3_virt.c | 4 ----
 hw/mips/malta.c          | 4 ----
 hw/mips/mipssim.c        | 4 ----
 target/mips/cpu.c        | 5 +++++
 7 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 0d8cbdc8924..f85fb4458af 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -91,10 +91,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        /* Init internal devices */
-        cpu_mips_irq_init_cpu(cpu);
-        cpu_mips_clock_init(cpu);
-
         if (cpu_mips_itu_supported(env)) {
             itu_present = true;
             /* Attach ITC Tag to the VP */
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 160ceb769dc..9a638f596bd 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -277,10 +277,6 @@ static void mips_fuloong2e_init(MachineState *machine)
         }
     }
 
-    /* Init internal devices */
-    cpu_mips_irq_init_cpu(cpu);
-    cpu_mips_clock_init(cpu);
-
     /* North bridge, Bonito --> IP2 */
     pci_bus = bonito_init(env->irq[2]);
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index c89610639a9..ce4a702aa53 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -259,10 +259,6 @@ static void mips_jazz_init(MachineState *machine,
         exit(1);
     }
 
-    /* Init CPU internal devices */
-    cpu_mips_irq_init_cpu(cpu);
-    cpu_mips_clock_init(cpu);
-
     /* Chipset */
     rc4030 = rc4030_init(&dmas, &rc4030_dma_mr);
     sysbus = SYS_BUS_DEVICE(rc4030);
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index f3cc7a8376f..91070824bbe 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -568,10 +568,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
 
         /* init CPUs */
         cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
-
-        /* Init internal devices */
-        cpu_mips_irq_init_cpu(cpu);
-        cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
 
         if (!kvm_enabled()) {
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4e9cccaa347..ac3b16229c8 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1037,10 +1037,6 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
     for (i = 0; i < ms->smp.cpus; i++) {
         cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk,
                                          TARGET_BIG_ENDIAN);
-
-        /* Init internal devices */
-        cpu_mips_irq_init_cpu(cpu);
-        cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
     }
 
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index a294779a82b..d4b3b043053 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -203,10 +203,6 @@ mips_mipssim_init(MachineState *machine)
         reset_info->vector = load_kernel();
     }
 
-    /* Init CPU internal devices. */
-    cpu_mips_irq_init_cpu(cpu);
-    cpu_mips_clock_init(cpu);
-
     /*
      * Register 64 KB of ISA IO space at 0x1fd00000.  But without interrupts
      * (except for the hardcoded serial port interrupt) -device cannot work,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 028a3c91afb..95df8985bc6 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -476,6 +476,11 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     fpu_init(env, env->cpu_model);
     mvp_init(env);
 
+    /* Init internal devices */
+#ifndef CONFIG_USER_ONLY
+    cpu_mips_irq_init_cpu(cpu);
+    cpu_mips_clock_init(cpu);
+#endif
     if (!clock_get(cpu->clock)) {
 #ifndef CONFIG_USER_ONLY
         if (!qtest_enabled()) {
-- 
2.47.1


