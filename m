Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116B9FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOC0-00082s-EY; Wed, 25 Feb 2026 18:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBz-000821-Dn
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBx-0004Ky-IW
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:19 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4398f8e2837so215282f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061675; x=1772666475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RbWumpFxFwgmdfg77On7KTxRgoKNarNr0zHuzKc4adQ=;
 b=JHtf2Gi8RyINaWQeBFgRcMs4vOsLhndoc39KNS6GC70bD97g2yelXI1bdx0oy8AqJt
 pC8ipXMNcq9KC6UKQPWuYeZHZBs4MVHPzj0904bqzRsW5SJVRF1xbQaEZa9QpR0EvmDJ
 ps1SPzj2dhAxGrgQvbasGt04jLWHAzuvw+3it93i5UiM1bdIU5hW60JbhGINV260xLBF
 8tuEOS+7p/O/EC4Pp1YU7zO46PKBDK9sx8uUTNw8z87c8rOw6+D9zr+hvAI1ARGP1QOt
 mcjRyKqs68YYUAhhXa7GqYpQz/oTK35E1uqbPIz2tpAWunqTJ4su7b8gD9KE/3uwmZqr
 gySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061675; x=1772666475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RbWumpFxFwgmdfg77On7KTxRgoKNarNr0zHuzKc4adQ=;
 b=d+38gTOiynWRXkJCUQ/zAHjFj6kZ2DF/R0Qgg15wEITUkDOHTvLxnNMN461L5rQWV8
 ZiKlIRxhHLPMdIHL2eRGg7zxEtbU4PYXKfWaS2sNSOkjDq1NqoUUgswlgIpIHkOdsFM5
 higtdyn3T1eIJKLa0MGEEbYhYBFxXh4LStnbXUYGrTPmI5fxAxxnr9SnGghOmE1j+MQh
 dAfqpjVZNGv1DzgRNjZ77U1tDFjxCqeGYR6rIK+tLU3oGtJhh+zIQbx4gvvNIThSEapO
 jf0zoBwJm9Q9h/WFexm1LXYnsXSMqpIA4AtqMrEbndN54v8VbzzW6y8tOwn5pBW1FC9p
 c89g==
X-Gm-Message-State: AOJu0Yw7CbGSMp/abQRJsf8qHJYZXCbndEz3OAggZdvNWfPMXP/N0exL
 vVoezgLR7SwvJpLwuJv8AH7nfSoaeiFCyLfhV04lIid8onYEel76TtJGAbuxsRQ86O1N1/4V2Am
 WK7IL6/k=
X-Gm-Gg: ATEYQzyOffRBIcbSC74scy+kYwMBeufVHhkOh3JgRf1DBP/BORsZyk4yf+CJMQp/FHg
 MVCWJVt9EB5QgB7UWY+lYdBcDo0GM5QB1YysprsBr+P102ofizy239FZq07c9Ryiwv6N5w2h9S9
 3EtGhrbz+Q2s0ZLnFEmz0+I6+GmbiclQVPtKh9GxiAn4GvYD/w34u2eK4Al7uY+AQkFtLxsgVLM
 4Zl9Hf8GEx/+7DKbWQcEp6muPc/WOYW7rrkqnBL1LEUhjIqj9XbSRP1YbJfBoyjODIhHQzMzRCv
 8VDVhGQbG8XLkHVeSXCpsFKsZfiLk41FYC01Y5j2MDk3ioHDsuWpyN+TRh6PppkqcLMQHG0+Us9
 LxMrCoX1jKv0JytYUjYpCL8Py7JWXzrPhXWNEx3ue0QwoR54qmX+rzJswimYicmQgowTX6zLX/w
 F9uKVx/VDo5Ufp81AkdEW7t3rbZ4whaBqy9UfIt0ly+spIFaYDG84bJT21o+Hs5RHLaCnvs+K9
X-Received: by 2002:a05:6000:1861:b0:431:62:d946 with SMTP id
 ffacd0b85a97d-4396f15c4c8mr32379980f8f.23.1772061675300; 
 Wed, 25 Feb 2026 15:21:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d401aasm35842235f8f.23.2026.02.25.15.21.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/70] system: Make qemu_arch_available() common code
Date: Thu, 26 Feb 2026 00:14:02 +0100
Message-ID: <20260225231411.96482-63-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Remove the need of per-target QEMU_ARCH. Define the
QEMU_ARCH_* constants based on SYS_EMU_TARGET_* ones,
themselves already exposed via target_arch(), allowing
to check the current target is included in @arch_bitmask.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260213175032.32121-5-philmd@linaro.org>
---
 meson.build                |  2 --
 include/system/arch_init.h | 54 ++++++++++++++++++++++++--------------
 system/arch_init.c         |  4 ++-
 system/meson.build         |  5 +---
 4 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/meson.build b/meson.build
index 59c8204d881..4eeef552748 100644
--- a/meson.build
+++ b/meson.build
@@ -3375,8 +3375,6 @@ foreach target : target_dirs
       config_target_data.set(k, v)
     endif
   endforeach
-  config_target_data.set('QEMU_ARCH',
-                         'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'].to_upper())
   config_target_h += {target: configure_file(output: target + '-config-target.h',
                                                configuration: config_target_data)}
 
diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index 92d50ba8d63..bb17d18a2b5 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -1,30 +1,44 @@
 #ifndef QEMU_ARCH_INIT_H
 #define QEMU_ARCH_INIT_H
 
+#include "qapi/qapi-types-machine.h"
 
 enum {
-    QEMU_ARCH_ALL = -1,
-    QEMU_ARCH_ALPHA = (1 << 0),
-    QEMU_ARCH_ARM = (1 << 1),
-    QEMU_ARCH_I386 = (1 << 3),
-    QEMU_ARCH_M68K = (1 << 4),
-    QEMU_ARCH_MICROBLAZE = (1 << 6),
-    QEMU_ARCH_MIPS = (1 << 7),
-    QEMU_ARCH_PPC = (1 << 8),
-    QEMU_ARCH_S390X = (1 << 9),
-    QEMU_ARCH_SH4 = (1 << 10),
-    QEMU_ARCH_SPARC = (1 << 11),
-    QEMU_ARCH_XTENSA = (1 << 12),
-    QEMU_ARCH_OR1K = (1 << 13),
-    QEMU_ARCH_TRICORE = (1 << 16),
-    QEMU_ARCH_HPPA = (1 << 18),
-    QEMU_ARCH_RISCV = (1 << 19),
-    QEMU_ARCH_RX = (1 << 20),
-    QEMU_ARCH_AVR = (1 << 21),
-    QEMU_ARCH_HEXAGON = (1 << 22),
-    QEMU_ARCH_LOONGARCH = (1 << 23),
+    QEMU_ARCH_ALPHA =       (1UL << SYS_EMU_TARGET_ALPHA),
+    QEMU_ARCH_ARM =         (1UL << SYS_EMU_TARGET_ARM) |
+                            (1UL << SYS_EMU_TARGET_AARCH64),
+    QEMU_ARCH_I386 =        (1UL << SYS_EMU_TARGET_I386) |
+                            (1UL << SYS_EMU_TARGET_X86_64),
+    QEMU_ARCH_M68K =        (1UL << SYS_EMU_TARGET_M68K),
+    QEMU_ARCH_MICROBLAZE =  (1UL << SYS_EMU_TARGET_MICROBLAZE) |
+                            (1UL << SYS_EMU_TARGET_MICROBLAZEEL),
+    QEMU_ARCH_MIPS =        (1UL << SYS_EMU_TARGET_MIPS) |
+                            (1UL << SYS_EMU_TARGET_MIPSEL) |
+                            (1UL << SYS_EMU_TARGET_MIPS64) |
+                            (1UL << SYS_EMU_TARGET_MIPS64EL),
+    QEMU_ARCH_PPC =         (1UL << SYS_EMU_TARGET_PPC) |
+                            (1UL << SYS_EMU_TARGET_PPC64),
+    QEMU_ARCH_S390X =       (1UL << SYS_EMU_TARGET_S390X),
+    QEMU_ARCH_SH4 =         (1UL << SYS_EMU_TARGET_SH4) |
+                            (1UL << SYS_EMU_TARGET_SH4EB),
+    QEMU_ARCH_SPARC =       (1UL << SYS_EMU_TARGET_SPARC) |
+                            (1UL << SYS_EMU_TARGET_SPARC64),
+    QEMU_ARCH_XTENSA =      (1UL << SYS_EMU_TARGET_XTENSA) |
+                            (1UL << SYS_EMU_TARGET_XTENSAEB),
+    QEMU_ARCH_OR1K =        (1UL << SYS_EMU_TARGET_OR1K),
+    QEMU_ARCH_TRICORE =     (1UL << SYS_EMU_TARGET_TRICORE),
+    QEMU_ARCH_HPPA =        (1UL << SYS_EMU_TARGET_HPPA),
+    QEMU_ARCH_RISCV =       (1UL << SYS_EMU_TARGET_RISCV32) |
+                            (1UL << SYS_EMU_TARGET_RISCV64),
+    QEMU_ARCH_RX =          (1UL << SYS_EMU_TARGET_RX),
+    QEMU_ARCH_AVR =         (1UL << SYS_EMU_TARGET_AVR),
+    QEMU_ARCH_HEXAGON =     (1UL << SYS_EMU_TARGET_HEXAGON),
+    QEMU_ARCH_LOONGARCH =   (1UL << SYS_EMU_TARGET_LOONGARCH64),
+    QEMU_ARCH_ALL =         UINT32_MAX,
 };
 
+QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
+
 /**
  * qemu_arch_available:
  * @arch_bitmask: bitmask of QEMU_ARCH_* constants
diff --git a/system/arch_init.c b/system/arch_init.c
index ec9e45a1a80..604d5909ed0 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -23,8 +23,10 @@
  */
 #include "qemu/osdep.h"
 #include "system/arch_init.h"
+#include "qemu/bitops.h"
+#include "qemu/target-info-qapi.h"
 
 bool qemu_arch_available(uint32_t arch_bitmask)
 {
-    return arch_bitmask & QEMU_ARCH;
+    return extract32(arch_bitmask, target_arch(), 1);
 }
diff --git a/system/meson.build b/system/meson.build
index 035f0ae7de4..579e8353d53 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,12 +1,9 @@
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
-  'arch_init.c',
-)])
-
 system_ss.add(files(
   'vl.c',
 ), sdl, libpmem, libdaxctl)
 
 system_ss.add(files(
+  'arch_init.c',
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
-- 
2.52.0


