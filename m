Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765CDCD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrT-0001KK-O7; Wed, 06 May 2026 10:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpq-0007RD-Rv
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpp-0000xM-96
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44b052142e1so2792068f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076162; x=1778680962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wnUhPBvByi3xklzN4tpBvRpQo8+T/x7M5oAr/ykzJl8=;
 b=SrcT0UjSGOPSrytkcG8EYbLB9eu0IGqZEDKS/gwL8zG+FGa9MiG/UzKfYEjXxtsKSc
 5qg4424Me4BMHecZQP7Sn2knNOzZwdEqpQnc7ZpjQ+5f/A4Og3MctJom65vs7UQDfV5h
 sYvc/mOVLPzeaTZ1Ubz47nFCYJMAjhZpPPcin0cLGX9cafmsbtyUMh46sDq0Jd4gLnGB
 OBvaKmJttl59saHgeoLpGk05btMFCgXXSHt8ATZRIBsEh2YeT26w07h2Jf/EpG2lUZ30
 0TyPNnX15eKKPi/iye91+IBtGuiOr+OQat054n8V6TrUOV/igVdXUrkKUu7bWhXSUfC+
 px2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076162; x=1778680962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wnUhPBvByi3xklzN4tpBvRpQo8+T/x7M5oAr/ykzJl8=;
 b=jYCjfsvoymlfoB+Ag1S80lvjm2NBfZwKQWjgB0Okgvgdvz/UsUgg2RrnK/nRhC9U9u
 47mpkQXkX+/jyvYVv2/2V5QcH+Ll8yZo/aplXyjgAe8VJSrJhM1KwNrhpH9Fg9oCwh/7
 dh9uahGDaMfrIA0C9UXPoWuyVhYi/v4NuDfQPEmbvAFae19ZvZ0M8yD6Iy6A2bTXXD/y
 d3s2s4sUVAm5dIWz7NE7DC1dz2tNzOT/kalgUBhgHqZ0Zs7eFlugzWV6xMOIwrXyGs7x
 qHXxQaqsW7bpy4h5IyjQnrTSTTQPBViIm9Q4v7ymLUe3YerbO01QpiUbge43z8D2hGx0
 1qTQ==
X-Gm-Message-State: AOJu0YzJAyJbgjuQXVmuG6ywBSodmiVROaOL6vbsv6TEIxH2vRK0t3aj
 z9rfQqkQ4PRtQY1EOn3CVoUXrhE+4CP5okp5o0x/Cljjc7nOhic+WgUI2poOZZmltBU2QW38M52
 ESHbLEDY=
X-Gm-Gg: AeBDieuAf2ilmLWfNEcBJP47le/gTTJI9/Adl0jOEEWzmi6QD4UENgPIXQ3GOyqRx+Y
 BBBrZ4Jl0AThwOejwXmYB8/J7PXFxs+Mvqzl7kkj0UbRRmFSGRUeQ0Yh52Ns6TBbi7s05F6ThCf
 h4cPn7rb/ihAiYPr4QMJXBGgrh2CUXkC340bQ9MXvzGAUZ/GgnWBkfwCL4AzfxGYtsmBXNlK8Wg
 KqH6XnBaW5AHBTPEZIULYo8+XYNhJe1FrJW+0Q15v5w8UbgldRPa8tI9P6lALTpd8PnSBD8PUg5
 cayhF1bvqGgBcaQLJmgTHE7/A16wc7M6SBK2icwwgaDwZSQmrM9h9bIRB3BupIS20FX25OMIUth
 lJ6Foc8axPD+WjeVI4J6iB72SANtKqDt0YgozeiP1PpRyxpXXKjfHVG9PaAWH5nKjiS4WsGb1JO
 D0GWTDmqvAfGG+b2b135L4b6GHWblc/7xCnYb1s0A9QT2FrtxohImsOyTiq3VxASEa8MeZFPFIt
 zGxr/eo+j6QcuZT7bOrrQ==
X-Received: by 2002:a5d:584e:0:b0:44b:8fb6:9a2e with SMTP id
 ffacd0b85a97d-4515ce1ca99mr5598797f8f.20.1778076161604; 
 Wed, 06 May 2026 07:02:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4504f4857ffsm12380903f8f.0.2026.05.06.07.02.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:02:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 056/110] target/riscv: Register target_get_monitor_def in
 SysemuCPUOps
Date: Wed,  6 May 2026 15:54:28 +0200
Message-ID: <20260506135524.20617-57-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Rename target_get_monitor_def() as riscv_monitor_get_register_legacy()
and register it as SysemuCPUOps::monitor_get_register() handler.
Take care to sign-extend values for 32-bit HARTs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260427080738.77138-21-philmd@linaro.org>
---
 target/riscv/internals.h |  3 +++
 target/riscv/cpu.c       |  1 +
 target/riscv/monitor.c   | 11 +++++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index bac6c8032a2..8c24af0d855 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -250,4 +250,7 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      int64_t *pval);
+
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37d..a13727c0d4b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2733,6 +2733,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
+    .monitor_get_register = riscv_monitor_get_register_legacy,
     .legacy_vmsd = &vmstate_riscv_cpu,
 };
 #endif
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index bca04a7580c..3898595a3cb 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -27,6 +27,7 @@
 #include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "system/memory.h"
+#include "internals.h"
 
 #ifdef TARGET_RISCV64
 #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
@@ -311,16 +312,18 @@ static bool reg_is_vreg(const char *name)
     return false;
 }
 
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      int64_t *pval)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *hart = RISCV_CPU(cs);
+    CPURISCVState *env = cpu_env(cs);
     target_ulong val = 0;
     uint64_t val64 = 0;
     int i;
 
     if (reg_is_ulong_integer(env, name, &val, false) ||
         reg_is_ulong_integer(env, name, &val, true)) {
-        *pval = val;
+        *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
         return 0;
     }
 
@@ -369,7 +372,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
          * to do the filtering of the registers that are present.
          */
         if (res == RISCV_EXCP_NONE) {
-            *pval = val;
+            *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
             return 0;
         }
     }
-- 
2.53.0


