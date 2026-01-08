Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AB9D1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsxA-0005eR-JI; Thu, 08 Jan 2026 11:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdsx9-0005eE-NT
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:33:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdsx7-0001FS-PF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:33:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso36970545e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767890016; x=1768494816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e/mnZFR56fsOJ0o31n8MizyStQrPbypzsKFujAAEmCM=;
 b=nXMUvz4jXGIz/sXklSpmNrGIzVibeKWMsyS0+4+kkKDfXQyhjN0GXK+vu2NzKSTVmP
 hwWUl3CTZiB8e98olUtCCFlYgs0c42zvuNJt+whIrzdeQPIWiIyiwdYnJXQh5RrIVyhs
 BmsALgHcpmK1cekk+Sob2ZyjffZS3fQ8JlB4KfKcDEXYjL9ZfVjv0B4dsmysN6aRDaKw
 hxjc1iOGc8gBv00nAZBDdKbCWzd+iTMfMGa7vqiy6pClIIJtC7UfoUCo5PBWBF2dv3PJ
 73b7ev5rzghOsygfHllwcvA/jzmpDIAViiqJbwkAU+zTgYn3JGYNMVjOJ66W1+Wh/v83
 3Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767890016; x=1768494816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/mnZFR56fsOJ0o31n8MizyStQrPbypzsKFujAAEmCM=;
 b=AMya2bO0yjccQsiIuWj/6ClSfSCdiZcPPppDcT47JoWGnX6tTWcOUnM3m0rIm/Svlq
 HO3fWQy5EyoUFxTESB05eigL1CWaPYm9EICEwbe35UmjXHWQiw0gn+vvoRlcHZROICnJ
 kaVSVc4onasrUXpJN2wWYZI8CcX5eUVk2qPqCky3swdxThNMmmfIDq/wO8I7ij3NqroG
 jef5vtekWx8zWdE/045Unz+3IlyUjZkRGuQkIkwzW4lebYdNx5v0Q39FscVvmbTpWIT4
 YtekGGKC675ySGtb0foFy97fjoL/q6DvktY4sJQW/C71OhCR17WxA7q8MItcYauLlK0n
 naew==
X-Gm-Message-State: AOJu0Yxuzvvh1/sEmkYTw4uECYcah92o2n2qGkJlBnZd0u0ONn/RMXO3
 xQxBK5VV/vWGaIETl+HcUxtNTcYg5+n3YLMkeLeyA5flknmTDThQX2QofkGpGh2QL3ZFQ52Dxrf
 xmHZPFlg=
X-Gm-Gg: AY/fxX7Fsu/UtIT6m2glZbIedXnSLuImM6T7C0fxn47riTntYymAgemej4yHp+3rarI
 yWYrglv3et384tVxMAKQnM6CP3xWkHtY+TgX7lM4OZVjBPvmZGBZDxHsEgi5DfA9SFc7FlnsuGS
 BVlfFeTUMyOCe0o49t69zB2nkXQLUvIu1/mpynMSRBrf78AjWXA3Sn3YublQGsIHDPkKAbtO1Ua
 NJInATIlTD9TEbQhKAeBrBp9sKwP2ItvuEfUGcLPUOhAcP+QE/pCW02FJvjmbYVX6sk7EDcR1oz
 G56nb/8Yum5v1YLU1wkhzdg2p26kD3PrVLzux6KQkl6N6GBuWoDC3mZvxrDGCydXhlJNHkOLash
 BGXT8fuEpizsX8qLTlq4rIB+DA/TL6WkX972DXsr4LTyxtwXgABxQYid+K2lEQt7r8gf314/2GT
 zEseRqHXvmnHlWDaWL+yc1DabNwDtbe2xjP+NgJG8hRq8ADkJPGqh7NgTTADxG
X-Google-Smtp-Source: AGHT+IFQscfqn6tIVGCT9hZP8XuTdEmxFd3S7tQ9vYzPSijC2dnKolIXPw95U0V423cPDuxLV3hWRQ==
X-Received: by 2002:a05:600c:1d04:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-47d84b3a06fmr90340195e9.27.1767890015828; 
 Thu, 08 Jan 2026 08:33:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8715b5f7sm42971715e9.4.2026.01.08.08.33.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 08:33:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] system: Convert qemu_arch_available() to TargetInfo API
Date: Thu,  8 Jan 2026 17:33:33 +0100
Message-ID: <20260108163333.18453-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
v2: Prefer switch over array (pbo)
---
 meson.build        |  2 --
 system/arch_init.c | 30 -----------------
 target-info.c      | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 system/meson.build |  1 -
 4 files changed, 83 insertions(+), 33 deletions(-)
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
index 24696ff4111..101875dddf1 100644
--- a/target-info.c
+++ b/target-info.c
@@ -11,6 +11,7 @@
 #include "qemu/target-info-qapi.h"
 #include "qemu/target-info-impl.h"
 #include "qapi/error.h"
+#include "system/arch_init.h"
 
 const char *target_name(void)
 {
@@ -33,6 +34,88 @@ SysEmuTarget target_arch(void)
     return arch;
 }
 
+bool qemu_arch_available(unsigned qemu_arch_mask)
+{
+    unsigned base_arch_mask;
+
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_ALPHA:
+        base_arch_mask = QEMU_ARCH_ALPHA;
+        break;
+    case SYS_EMU_TARGET_ARM:
+    case SYS_EMU_TARGET_AARCH64:
+        base_arch_mask = QEMU_ARCH_ARM;
+        break;
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        base_arch_mask = QEMU_ARCH_I386;
+        break;
+    case SYS_EMU_TARGET_M68K:
+        base_arch_mask = QEMU_ARCH_M68K;
+        break;
+    case SYS_EMU_TARGET_MICROBLAZE:
+    case SYS_EMU_TARGET_MICROBLAZEEL:
+        base_arch_mask = QEMU_ARCH_MICROBLAZE;
+        break;
+    case SYS_EMU_TARGET_MIPS:
+    case SYS_EMU_TARGET_MIPSEL:
+    case SYS_EMU_TARGET_MIPS64:
+    case SYS_EMU_TARGET_MIPS64EL:
+        base_arch_mask = QEMU_ARCH_MIPS;
+        break;
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPC64:
+        base_arch_mask = QEMU_ARCH_PPC;
+        break;
+    case SYS_EMU_TARGET_S390X:
+        base_arch_mask = QEMU_ARCH_S390X;
+        break;
+    case SYS_EMU_TARGET_SH4:
+    case SYS_EMU_TARGET_SH4EB:
+        base_arch_mask = QEMU_ARCH_SH4;
+        break;
+    case SYS_EMU_TARGET_SPARC:
+    case SYS_EMU_TARGET_SPARC64:
+        base_arch_mask = QEMU_ARCH_SPARC;
+        break;
+    case SYS_EMU_TARGET_XTENSA:
+    case SYS_EMU_TARGET_XTENSAEB:
+        base_arch_mask = QEMU_ARCH_XTENSA;
+        break;
+    case SYS_EMU_TARGET_OR1K:
+        base_arch_mask = QEMU_ARCH_OPENRISC;
+        break;
+    case SYS_EMU_TARGET_TRICORE:
+        base_arch_mask = QEMU_ARCH_TRICORE;
+        break;
+    case SYS_EMU_TARGET_HPPA:
+        base_arch_mask = QEMU_ARCH_HPPA;
+        break;
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        base_arch_mask = QEMU_ARCH_RISCV;
+        break;
+    case SYS_EMU_TARGET_RX:
+        base_arch_mask = QEMU_ARCH_RX;
+        break;
+    case SYS_EMU_TARGET_AVR:
+        base_arch_mask = QEMU_ARCH_AVR;
+        break;
+    /*
+    case SYS_EMU_TARGET_HEXAGON:
+        base_arch_mask = QEMU_ARCH_HEXAGON;
+        break;
+    */
+    case SYS_EMU_TARGET_LOONGARCH64:
+        base_arch_mask = QEMU_ARCH_LOONGARCH;
+        break;
+    default:
+        g_assert_not_reached();
+    };
+
+    return qemu_arch_mask & base_arch_mask;
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


