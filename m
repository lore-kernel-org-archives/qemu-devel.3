Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBD2D0D157
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXzM-0003kE-Dw; Wed, 07 Jan 2026 13:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdXzL-0003jy-Md
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:10:31 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdXzJ-0002VZ-SI
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:10:31 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so13695505e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767809427; x=1768414227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MvFhBQ4Ny6vNcveZgCAwpeDHU24ZiX3IJIodsU/6mK8=;
 b=Nor5sz/J3LvWTuM4JxyZ1cbAc7hnn0SWoiVH9+ok1B8Jupbsj5gXJDZwOsJD1hd9Zi
 ICnBPDqQSU+f0u6B14okkRYnZaEcHRUdN7HIv0Lv2aVMaA0Qs9Jx7HBiOfUaIchfoWJc
 8yzaXhWo4ChUiXZokkxMyA1qnxE71yCjcwKOSLm046qmL0n63pgUJXCavMxCa4ExlQlP
 NfrlXkYyBQ/wV15oZdDlqyFT3NA9bWQC9QlSQeSYqB/YDy/qx5MybLSH4lV3UMS/5Ekp
 6XghiCwUc7cCwk2fSHyIQ5vK6/fTCm0Av6fvi340wfJS4KSMvFQCzImE3z4Vavz1momb
 sQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767809427; x=1768414227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvFhBQ4Ny6vNcveZgCAwpeDHU24ZiX3IJIodsU/6mK8=;
 b=JazeGdf8gAcLPilE3K2dgOOHDWqM94eKFPbjEOLL2yeZtQtwhjUw1fSMHJq56MVXiO
 GyBa0CMOOPEJAx/6kV0n1ujmuKNd2Q16psnBOkZgaYh59M88FLXBjKeDH3T0gVqgjDNB
 N1N/TMNDLnKEqwJ10QkPZtcm1Zt9ISGTJgxrtPAzoJCwMpUUedQ5lDOSnab7taJhRAPq
 Ssm5b+KtXzaP5C7ISVdVWiyxBks31TswZncnr2/sflJrpOSn50vcPQt6MbB6iWGN9uNB
 O8al5+pdqEPCOK/IbRN6oa0GTX51Io0A2mGWYqb5HNTBRNmLAlgoKEkAfUd2ZI7mte1T
 2Jcw==
X-Gm-Message-State: AOJu0YyPnjMR7DYbUBHJW1PpJcURMWLXiXKZ4inBaL2v6Axhg7EPENVK
 19pw4YdjtfTGTC4lNzpbkBNvXFvcgpXmU+heI6P0BBZBSeiMWtmfEdaMiqpad8/lPN+tpq6Hij/
 pocO8LD0=
X-Gm-Gg: AY/fxX4oiCGktXvbdrjGzWGsfW8k39oH7DGJXbMgsrQK3KjINhHe3XANv1++iWomIQ3
 nlRosjm08JMi9WDIqXZYwE8Y1lZnDpU4DSY4gnVbiUuX4xU+hypkkrMaI4/Ed7ow+bnCw34ZnnI
 bv8t6O3bD3ZixpM+HFxftmmdTeAh+Y0B/acK79Av8eHikfshksfGidjps2/DeeDfMKI2YFqpuRd
 0sZRkM4jMP1oHvGgLJh4O4GwK0EPku8znqpD81/Hecl9bjskXi6Qf7JjkELwh1CCfmWA1lL/tul
 cO2qydM8ouvWma4AfqrK79KP1mBhnL3swgneVzl6rjzfJse0KEPy4i5PWFr7b6ANxUTBY4GPbD/
 uEK9/j1KAcWUjxUovWlRY9PSK375UZzYU2t0pZoagfXVxzZxn0c5LGKHiTPyfJzMamgRJBQ8Y72
 5pAeU1+//NjVyGWsfnC35B7PBfFyfqxJKk/nWN7r7M3lG2FmSFIMUGVZemza4c
X-Google-Smtp-Source: AGHT+IEU65TsDFa1vpCbwVAzBdPPiMLcNFYXpdyUVkZaPE7RtdHcO11gKLDzA131yYM9S93J9MnDOg==
X-Received: by 2002:a05:600c:348f:b0:479:3a88:de5d with SMTP id
 5b1f17b1804b1-47d84b48f75mr43960815e9.36.1767809427433; 
 Wed, 07 Jan 2026 10:10:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d86c6ff40sm39536295e9.2.2026.01.07.10.10.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 10:10:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH] system: Convert qemu_arch_available() to TargetInfo API
Date: Wed,  7 Jan 2026 19:10:25 +0100
Message-ID: <20260107181025.51276-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Get the base arch_mask from the current SysEmuTarget,
making qemu_arch_available() target-agnostic.

We don't need the per-target QEMU_ARCH definition anymore,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build        |  2 --
 system/arch_init.c | 30 ------------------------------
 target-info.c      | 41 +++++++++++++++++++++++++++++++++++++++++
 system/meson.build |  1 -
 4 files changed, 41 insertions(+), 33 deletions(-)
 delete mode 100644 system/arch_init.c

diff --git a/meson.build b/meson.build
index 734c801cc77..435dc6e3c8e 100644
--- a/meson.build
+++ b/meson.build
@@ -3419,8 +3419,6 @@ foreach target : target_dirs
       config_target_data.set(k, v)
     endif
   endforeach
-  config_target_data.set('QEMU_ARCH',
-                         'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'].to_upper())
   config_target_h += {target: configure_file(output: target + '-config-target.h',
                                                configuration: config_target_data)}
 
diff --git a/system/arch_init.c b/system/arch_init.c
deleted file mode 100644
index e85736884c9..00000000000
--- a/system/arch_init.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-#include "qemu/osdep.h"
-#include "system/arch_init.h"
-
-bool qemu_arch_available(unsigned qemu_arch_mask)
-{
-    return qemu_arch_mask & QEMU_ARCH;
-}
diff --git a/target-info.c b/target-info.c
index 24696ff4111..4d38767d214 100644
--- a/target-info.c
+++ b/target-info.c
@@ -11,6 +11,7 @@
 #include "qemu/target-info-qapi.h"
 #include "qemu/target-info-impl.h"
 #include "qapi/error.h"
+#include "system/arch_init.h"
 
 const char *target_name(void)
 {
@@ -33,6 +34,46 @@ SysEmuTarget target_arch(void)
     return arch;
 }
 
+bool qemu_arch_available(unsigned qemu_arch_mask)
+{
+    static const unsigned base_arch_mask[SYS_EMU_TARGET__MAX] = {
+        [SYS_EMU_TARGET_AARCH64]        = QEMU_ARCH_ARM,
+        [SYS_EMU_TARGET_ALPHA]          = QEMU_ARCH_ALPHA,
+        [SYS_EMU_TARGET_ARM]            = QEMU_ARCH_ARM,
+        [SYS_EMU_TARGET_AVR]            = QEMU_ARCH_AVR,
+        /*
+        [SYS_EMU_TARGET_HEXAGON]        = QEMU_ARCH_HEXAGON,
+        */
+        [SYS_EMU_TARGET_HPPA]           = QEMU_ARCH_HPPA,
+        [SYS_EMU_TARGET_I386]           = QEMU_ARCH_I386,
+        [SYS_EMU_TARGET_LOONGARCH64]    = QEMU_ARCH_LOONGARCH,
+        [SYS_EMU_TARGET_M68K]           = QEMU_ARCH_M68K,
+        [SYS_EMU_TARGET_MICROBLAZE]     = QEMU_ARCH_MICROBLAZE,
+        [SYS_EMU_TARGET_MICROBLAZEEL]   = QEMU_ARCH_MICROBLAZE,
+        [SYS_EMU_TARGET_MIPS]           = QEMU_ARCH_MIPS,
+        [SYS_EMU_TARGET_MIPS64]         = QEMU_ARCH_MIPS,
+        [SYS_EMU_TARGET_MIPS64EL]       = QEMU_ARCH_MIPS,
+        [SYS_EMU_TARGET_MIPSEL]         = QEMU_ARCH_MIPS,
+        [SYS_EMU_TARGET_OR1K]           = QEMU_ARCH_OPENRISC,
+        [SYS_EMU_TARGET_PPC]            = QEMU_ARCH_PPC,
+        [SYS_EMU_TARGET_PPC64]          = QEMU_ARCH_PPC,
+        [SYS_EMU_TARGET_RISCV32]        = QEMU_ARCH_RISCV,
+        [SYS_EMU_TARGET_RISCV64]        = QEMU_ARCH_RISCV,
+        [SYS_EMU_TARGET_RX]             = QEMU_ARCH_RX,
+        [SYS_EMU_TARGET_S390X]          = QEMU_ARCH_S390X,
+        [SYS_EMU_TARGET_SH4]            = QEMU_ARCH_SH4,
+        [SYS_EMU_TARGET_SH4EB]          = QEMU_ARCH_SH4,
+        [SYS_EMU_TARGET_SPARC]          = QEMU_ARCH_SPARC,
+        [SYS_EMU_TARGET_SPARC64]        = QEMU_ARCH_SPARC,
+        [SYS_EMU_TARGET_TRICORE]        = QEMU_ARCH_TRICORE,
+        [SYS_EMU_TARGET_X86_64]         = QEMU_ARCH_I386,
+        [SYS_EMU_TARGET_XTENSA]         = QEMU_ARCH_XTENSA,
+        [SYS_EMU_TARGET_XTENSAEB]       = QEMU_ARCH_XTENSA,
+    };
+
+    return qemu_arch_mask & base_arch_mask[target_arch()];
+}
+
 const char *target_cpu_type(void)
 {
     return target_info()->cpu_type;
diff --git a/system/meson.build b/system/meson.build
index 4b69ef0f5fb..66e16db55ce 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,5 +1,4 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
-  'arch_init.c',
   'globals-target.c',
 )])
 
-- 
2.52.0


