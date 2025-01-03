Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C61E77198
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTqvn-0007iG-6I; Fri, 03 Jan 2025 18:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvl-0007hq-6e
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:18:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvh-0004Jo-QB
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:18:12 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so131443185e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735946288; x=1736551088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3VKZk7ANLrajbjyIZIkbWQv3KcPJRE4raR0SfdiQq4=;
 b=GOyIHChAi691jApBr8m2r73VhB935aa7AOiidjNvlj1OgapK2vqf9qg2tzQUywIoyo
 TPP0KnflyKIv6xBexcec7iYFdc2jrZoOhaaid68qZyJrJfbjBXIQ4lS3wwrIV8RCLwBH
 yuZ/4OU32ccYOgnGlcyYY7uqz1DsIZwPtbdELaR4uAh7B6uUviqohSllTrM+r5oR+dFg
 F3KSW42XHpKpnSTUY93qW2q+nRLDSS4eU2G5Q+MFRIwuc+HV9qqBbYr8VSbFhjYpYZyi
 G2CwbRl4MjV+jDnCWi/0mi2CLLyoRasRV4ynMLH/QHI0O78QRU1aZwmRMnr9T0YpkDJU
 Tm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946288; x=1736551088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3VKZk7ANLrajbjyIZIkbWQv3KcPJRE4raR0SfdiQq4=;
 b=X0NR6r2yB6Su4lQvbsMKjnU9zcuqiN9AEHeLg6ZVSX0NydcayVArFRC13VKaXS9eS4
 hANQd5w41fKjNW9Zzf5OP3rllVTCzqL1FjtJxJC6QClhN2Hnoe6KiHc9GXs3jKeF88/e
 CzPdtbWKCNMVWqVun7cNSYdNhOG+dzuLRVsflRDCW5oFnvDlVEWMR5Et3mPUMb3WfDEj
 rMEHVEgL6I4pKgJTo/29u2ufNOJV4T20mgJex0Gv1xtLiG1DZaOqKCuN8jKX6YbfS1j0
 Q5sskxkAog7D0YKB4qG+NNiLtjDbynSK7+grXf9cIRkI2OWe/wLnQd8t3n815RU9BsQ+
 PfJg==
X-Gm-Message-State: AOJu0YzCR+OP1LeW+jdTwVqIVhT8qsDcHlUwoRsO64CQev+q5/uw01K9
 hNP4xmPxoPJ6uPgPFpn78gQ6DzoFYzc8x+vkG/iDQrwzRwBKvCCluX9zJ56c/E3k31TRakGCToB
 RhFU=
X-Gm-Gg: ASbGnct+dT04r9pdoePgWTk94ILhNmG2+alWIRfjRsM/7ExK+aHQjCrfsMDYQKOUyNg
 w7mgvclr0o1hCNd9CklhrWd6AWymQbSVnXh3+u3o8Ef7h14kVlW+5Z/buX3pQBPw2+L1PEAk3uc
 IomZWxMIEN2Zf2gz4bMEx06wL0tVlYjqpxRRD94VKqWgK+R3Eb9Prsvk7gt3wtQTQYbpglryZDx
 aWk3mvqQ+8qMWIkY79oB0GdPaN3JrlVIYGg4mpc9tQZVBlWKg9iuj1Uxe7s4YDSQ9Kj8hp7GORB
X-Google-Smtp-Source: AGHT+IFEHysbYBLuLj/9QM1m1PY5qEhH5KD0jEPySEtFb5KMM3ifYO7ZjTj/N31xzWrKxBhKrqXdGA==
X-Received: by 2002:a05:600c:3b13:b0:436:488f:4f5 with SMTP id
 5b1f17b1804b1-4366864420bmr437574275e9.19.1735946287896; 
 Fri, 03 Jan 2025 15:18:07 -0800 (PST)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a67c77a90sm3692353f8f.54.2025.01.03.15.18.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 15:18:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 4/6] disas: Have each system target select its disassembler
Date: Sat,  4 Jan 2025 00:17:36 +0100
Message-ID: <20250103231738.65413-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103231738.65413-1-philmd@linaro.org>
References: <20250103231738.65413-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

No change for host or user emulation.

For system emulation, each target explicitly selects
its disassembler.

This change allows selecting more than two (host + target)
disassemblers in a binary supporting multiple targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build               |  3 ++-
 Kconfig                   |  1 +
 disas/Kconfig             | 56 +++++++++++++++++++++++++++++++++++++++
 target/alpha/Kconfig      |  1 +
 target/avr/Kconfig        |  1 +
 target/hexagon/Kconfig    |  1 +
 target/hppa/Kconfig       |  1 +
 target/i386/Kconfig       |  1 +
 target/loongarch/Kconfig  |  1 +
 target/m68k/Kconfig       |  1 +
 target/microblaze/Kconfig |  1 +
 target/mips/Kconfig       |  1 +
 target/openrisc/Kconfig   |  1 +
 target/ppc/Kconfig        |  1 +
 target/riscv/Kconfig      |  2 ++
 target/rx/Kconfig         |  1 +
 target/s390x/Kconfig      |  1 +
 target/sh4/Kconfig        |  1 +
 target/sparc/Kconfig      |  2 ++
 target/tricore/Kconfig    |  1 +
 target/xtensa/Kconfig     |  1 +
 21 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 disas/Kconfig

diff --git a/meson.build b/meson.build
index e62251c7ca3..a35ef579c28 100644
--- a/meson.build
+++ b/meson.build
@@ -3319,7 +3319,8 @@ foreach target : target_dirs
   endif
 
   foreach k, v: disassemblers
-    if host_arch.startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
+    if host_arch.startswith(k) \
+        or (target.endswith('-user') and config_target['TARGET_BASE_ARCH'].startswith(k))
       foreach sym: v
         config_target += { sym: 'y' }
       endforeach
diff --git a/Kconfig b/Kconfig
index 63ca7f46df7..d937ad3b7fe 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,6 +1,7 @@
 source Kconfig.host
 source backends/Kconfig
 source accel/Kconfig
+source disas/Kconfig
 source target/Kconfig
 source hw/Kconfig
 source semihosting/Kconfig
diff --git a/disas/Kconfig b/disas/Kconfig
new file mode 100644
index 00000000000..1d2c397c953
--- /dev/null
+++ b/disas/Kconfig
@@ -0,0 +1,56 @@
+config ALPHA_DIS
+    bool
+
+config ARM_DIS
+    bool
+
+config AVR_DIS
+    bool
+
+config HEXAGON_DIS
+    bool
+
+config HPPA_DIS
+    bool
+
+config I386_DIS
+    bool
+
+config LOONGARCH_DIS
+    bool
+
+config M68K_DIS
+    bool
+
+config MICROBLAZE_DIS
+    bool
+
+config MIPS_DIS
+    bool
+
+config OPENRISC_DIS
+    bool
+
+config PPC_DIS
+    bool
+
+config RISCV_DIS
+    bool
+
+config RX_DIS
+    bool
+
+config S390_DIS
+    bool
+
+config SH4_DIS
+    bool
+
+config SPARC_DIS
+    bool
+
+config TRICORE_DIS
+    bool
+
+config XTENSA_DIS
+    bool
diff --git a/target/alpha/Kconfig b/target/alpha/Kconfig
index 267222c05b8..1b9cc8077db 100644
--- a/target/alpha/Kconfig
+++ b/target/alpha/Kconfig
@@ -1,2 +1,3 @@
 config ALPHA
     bool
+    select ALPHA_DIS
diff --git a/target/avr/Kconfig b/target/avr/Kconfig
index 155592d3537..7a7580c65f7 100644
--- a/target/avr/Kconfig
+++ b/target/avr/Kconfig
@@ -1,2 +1,3 @@
 config AVR
     bool
+    select AVR_DIS
diff --git a/target/hexagon/Kconfig b/target/hexagon/Kconfig
index 7e556f35063..a96415fb2fa 100644
--- a/target/hexagon/Kconfig
+++ b/target/hexagon/Kconfig
@@ -1,2 +1,3 @@
 config HEXAGON
     bool
+    select HEXAGON_DIS
diff --git a/target/hppa/Kconfig b/target/hppa/Kconfig
index 395a35d799c..e8fbdc02346 100644
--- a/target/hppa/Kconfig
+++ b/target/hppa/Kconfig
@@ -1,2 +1,3 @@
 config HPPA
     bool
+    select HPPA_DIS
diff --git a/target/i386/Kconfig b/target/i386/Kconfig
index 6b0feef0299..af603c7cd3a 100644
--- a/target/i386/Kconfig
+++ b/target/i386/Kconfig
@@ -1,5 +1,6 @@
 config I386
     bool
+    select I386_DIS
     select APIC
     # kvm_arch_fixup_msi_route() needs to access PCIDevice
     select PCI if KVM
diff --git a/target/loongarch/Kconfig b/target/loongarch/Kconfig
index 46b26b1a857..690404b4a5a 100644
--- a/target/loongarch/Kconfig
+++ b/target/loongarch/Kconfig
@@ -1,2 +1,3 @@
 config LOONGARCH64
     bool
+    select LOONGARCH_DIS
diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
index 23aae24ebec..57cd896dd0e 100644
--- a/target/m68k/Kconfig
+++ b/target/m68k/Kconfig
@@ -1,3 +1,4 @@
 config M68K
     bool
+    select M68K_DIS
     imply SEMIHOSTING if TCG
diff --git a/target/microblaze/Kconfig b/target/microblaze/Kconfig
index e91d58d88f2..09525a8e3ff 100644
--- a/target/microblaze/Kconfig
+++ b/target/microblaze/Kconfig
@@ -1,3 +1,4 @@
 config MICROBLAZE
     bool
+    select MICROBLAZE_DIS
     select DEVICE_TREE # needed by boot.c
diff --git a/target/mips/Kconfig b/target/mips/Kconfig
index 876048b150c..74a220f410a 100644
--- a/target/mips/Kconfig
+++ b/target/mips/Kconfig
@@ -1,5 +1,6 @@
 config MIPS
     bool
+    select MIPS_DIS
     imply SEMIHOSTING if TCG
 
 config MIPS64
diff --git a/target/openrisc/Kconfig b/target/openrisc/Kconfig
index cd66c2e3b6c..7e3c092345c 100644
--- a/target/openrisc/Kconfig
+++ b/target/openrisc/Kconfig
@@ -1,3 +1,4 @@
 config OPENRISC
     bool
+    select OPENRISC_DIS
     select DEVICE_TREE # needed by boot.c
diff --git a/target/ppc/Kconfig b/target/ppc/Kconfig
index 0283711673e..930337c4422 100644
--- a/target/ppc/Kconfig
+++ b/target/ppc/Kconfig
@@ -1,5 +1,6 @@
 config PPC
     bool
+    select PPC_DIS
 
 config PPC64
     bool
diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index 11bc09b4146..f5cf6185a88 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,11 @@
 config RISCV32
     bool
+    select RISCV_DIS
     select ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
+    select RISCV_DIS
     select ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
diff --git a/target/rx/Kconfig b/target/rx/Kconfig
index aceb5ed28fe..c050315add7 100644
--- a/target/rx/Kconfig
+++ b/target/rx/Kconfig
@@ -1,2 +1,3 @@
 config RX
     bool
+    select RX_DIS
diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
index 8a95f2bc3ff..51bb0afa446 100644
--- a/target/s390x/Kconfig
+++ b/target/s390x/Kconfig
@@ -1,5 +1,6 @@
 config S390X
     bool
+    select S390_DIS
     select PCI
     select S390_FLIC
 
diff --git a/target/sh4/Kconfig b/target/sh4/Kconfig
index 93b92f1e480..6ecf3173361 100644
--- a/target/sh4/Kconfig
+++ b/target/sh4/Kconfig
@@ -1,4 +1,5 @@
 config SH4
     bool
+    select SH4_DIS
     # needed for sh_intc_get_pending_vector
     select SH_INTC
diff --git a/target/sparc/Kconfig b/target/sparc/Kconfig
index 70cc0f3a210..bcb53d964f0 100644
--- a/target/sparc/Kconfig
+++ b/target/sparc/Kconfig
@@ -1,5 +1,7 @@
 config SPARC
     bool
+    select SPARC_DIS
 
 config SPARC64
     bool
+    select SPARC_DIS
diff --git a/target/tricore/Kconfig b/target/tricore/Kconfig
index 93134093093..c7c5fa8b074 100644
--- a/target/tricore/Kconfig
+++ b/target/tricore/Kconfig
@@ -1,2 +1,3 @@
 config TRICORE
     bool
+    select TRICORE_DIS
diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
index e8c2598c4d9..d54e3523401 100644
--- a/target/xtensa/Kconfig
+++ b/target/xtensa/Kconfig
@@ -1,3 +1,4 @@
 config XTENSA
     bool
     imply SEMIHOSTING if TCG
+    select XTENSA_DIS
-- 
2.47.1


