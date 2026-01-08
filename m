Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EF0D1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdszZ-0007or-Gf; Thu, 08 Jan 2026 11:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdszX-0007oa-41
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:36:07 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdszV-0001zK-9X
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:36:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso11162665e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767890163; x=1768494963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bqu5mbThPK8II2QofeZ3rou6aM6XvJX4mkgKq5nFj4E=;
 b=iPOSFqKy+Ur0FvLnhYLjaEsnfvNT/Wyf98avHBY6y945rO7wFKzgkU6BCmo6wpj9Km
 luZu5zQDzZz6UX2GECVZoS18MzEPF3p5e+FWH7Nf7agHhUOw3JKIYmJIVVrh3yv/VcCj
 Bs7w8ERxaET/SzDDEAkG2D3i9gEk0JJEhL4dmn4liwJRBRdOIW1/WmAiZ7d+wiAbZlJI
 OuUN9kirYQmW2ox3nNrrLuMvpLEN8FG31E6+9uJuWlhq84suiZIXhhx3vzYMEzihMJQX
 Kkbmen9C/qvURfTx8l4zVXTal9kZRkeJnwnmxBCCthBVWw/6ezlRj47M+3jjl9q5Bp0a
 ZOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767890163; x=1768494963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqu5mbThPK8II2QofeZ3rou6aM6XvJX4mkgKq5nFj4E=;
 b=pMDCnf1bVzK/ubfiWYrNIJH7mHhOH65RruhyC8midQ3qGNoeSNrWsQeTz0Q1834sfW
 AU7TrTdWPSjVMD9LhtybXzTTH7VXW4N1JGAs4yttluwamJBz2aTXySXzpWKNuRZvI/n9
 nvMa8UCYUJVTGMrx1ob8ZfePHR69fRtayOt3M5j/kjV0RR/Nmsh+FMRHjpPeeg6bbyVq
 F5/CD6ekWHxAi6L+rLHfxjZ2Mq/HgtMBlhIDQRSsGTgSEVfXP//M9205NURyxwX1usf3
 8vN0DIHakQrHRLNV8mVo5EBCTrVJf0S9iHm60Ps1kI3XtKcweNBilvqeKruLESWaUc+q
 /E5w==
X-Gm-Message-State: AOJu0Yz6Ip/7UFB9zJZjQqnU8+Lcmbm6AqeS7MpuhdSeystlGjISEq+U
 UNewAclhKc1+pfLwExJkpFpSf3IkiIMfCIEwkp6TvJ1GgouIkVPg+nuD0VbDnf67fKkQPDH/zqt
 mEXDzOH4=
X-Gm-Gg: AY/fxX4neR0JXoPD9laQi8wZiUsPqfQUuXbeyDu97rkHBkc/RzUDj4iyRuhuIx5mDyf
 c2xSzJWtX/EwvZOdSehmrkChap0gdy1+1UYgVNklxQq0Vr6t+Aj+2SrTmfibbug/v0Kcwsi3xNd
 KAi4F4G2rF4YTlNG+XJMr1mxdvK5//dHO3AHinF/JCPS2gbSkq4HZPFPj5wwmsA9r+66EGD3oyC
 HcJ4LVCb8GzIX6Rx6DmO1iOGERc120Is6Hu3KE09tGGZ/E1/yZrQISI1kSOdzfrGT62LjxfLQ3r
 08Vcn5tO3absSYSX9mOORNgekQWxqaDMrXHNznjcDSad0OFbhcdHjQrjgVBryPHhGY4WWwutNh+
 gE2jdMLRugWpixMeCDv9lIZsVseEpK8u5y07Bo0r2DzE6RT+ii7vZQuHBk2BVDghwM5FO12UJ3X
 ht/zXcF3P2pVTWg3a416il4XEjL0JCoMBKwH+P68WAccphlepTuYDPrDaOU6MO
X-Google-Smtp-Source: AGHT+IEW0quElwILXT2Q+B3CAxeVPFjNPmJ8lSXb0Ki7qQ45iTGTucx7oeOz/LizFakHfT6/JUFi+w==
X-Received: by 2002:a05:600c:a30c:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-47d848787eemr64246995e9.15.1767890163098; 
 Thu, 08 Jan 2026 08:36:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e13bsm158806355e9.7.2026.01.08.08.36.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 08:36:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
Date: Thu,  8 Jan 2026 17:36:00 +0100
Message-ID: <20260108163601.18676-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
v3: Return directly within switch
v2: Prefer switch over array (pbo)
---
 meson.build        |  2 --
 system/arch_init.c | 30 -----------------------
 target-info.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 system/meson.build |  1 -
 4 files changed, 60 insertions(+), 33 deletions(-)
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
index 24696ff4111..774fdcd2c46 100644
--- a/target-info.c
+++ b/target-info.c
@@ -11,6 +11,7 @@
 #include "qemu/target-info-qapi.h"
 #include "qemu/target-info-impl.h"
 #include "qapi/error.h"
+#include "system/arch_init.h"
 
 const char *target_name(void)
 {
@@ -33,6 +34,65 @@ SysEmuTarget target_arch(void)
     return arch;
 }
 
+bool qemu_arch_available(unsigned qemu_arch_mask)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_ALPHA:
+        return qemu_arch_mask & QEMU_ARCH_ALPHA;
+    case SYS_EMU_TARGET_ARM:
+    case SYS_EMU_TARGET_AARCH64:
+        return qemu_arch_mask & QEMU_ARCH_ARM;
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return qemu_arch_mask & QEMU_ARCH_I386;
+    case SYS_EMU_TARGET_M68K:
+        return qemu_arch_mask & QEMU_ARCH_M68K;
+    case SYS_EMU_TARGET_MICROBLAZE:
+    case SYS_EMU_TARGET_MICROBLAZEEL:
+        return qemu_arch_mask & QEMU_ARCH_MICROBLAZE;
+    case SYS_EMU_TARGET_MIPS:
+    case SYS_EMU_TARGET_MIPSEL:
+    case SYS_EMU_TARGET_MIPS64:
+    case SYS_EMU_TARGET_MIPS64EL:
+        return qemu_arch_mask & QEMU_ARCH_MIPS;
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPC64:
+        return qemu_arch_mask & QEMU_ARCH_PPC;
+    case SYS_EMU_TARGET_S390X:
+        return qemu_arch_mask & QEMU_ARCH_S390X;
+    case SYS_EMU_TARGET_SH4:
+    case SYS_EMU_TARGET_SH4EB:
+        return qemu_arch_mask & QEMU_ARCH_SH4;
+    case SYS_EMU_TARGET_SPARC:
+    case SYS_EMU_TARGET_SPARC64:
+        return qemu_arch_mask & QEMU_ARCH_SPARC;
+    case SYS_EMU_TARGET_XTENSA:
+    case SYS_EMU_TARGET_XTENSAEB:
+        return qemu_arch_mask & QEMU_ARCH_XTENSA;
+    case SYS_EMU_TARGET_OR1K:
+        return qemu_arch_mask & QEMU_ARCH_OPENRISC;
+    case SYS_EMU_TARGET_TRICORE:
+        return qemu_arch_mask & QEMU_ARCH_TRICORE;
+    case SYS_EMU_TARGET_HPPA:
+        return qemu_arch_mask & QEMU_ARCH_HPPA;
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return qemu_arch_mask & QEMU_ARCH_RISCV;
+    case SYS_EMU_TARGET_RX:
+        return qemu_arch_mask & QEMU_ARCH_RX;
+    case SYS_EMU_TARGET_AVR:
+        return qemu_arch_mask & QEMU_ARCH_AVR;
+    /*
+    case SYS_EMU_TARGET_HEXAGON:
+        return qemu_arch_mask & QEMU_ARCH_HEXAGON;
+    */
+    case SYS_EMU_TARGET_LOONGARCH64:
+        return qemu_arch_mask & QEMU_ARCH_LOONGARCH;
+    default:
+        g_assert_not_reached();
+    };
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


