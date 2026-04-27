Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F96CFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH2Z-0005Nt-Sz; Mon, 27 Apr 2026 04:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2X-00052m-Mm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2V-0002D2-TH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so7844595f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277398; x=1777882198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+UtYw+wvw45FuO+6veL5kPFJkNDEH8lZGFLqErw/iU4=;
 b=u9HXGMxfjYeQLBSZhiYTpo0rCr65rzP+g3zpp/G3v1W96FDHi7+h7MEajcO5/fA2m+
 AYPJq4r/l/DsAXdMmc6R37HMx6BApM5aEgv5IykYSmVPBAcJtu9uw6gMZeZAzTeASiBg
 je+TkYzVLPp7IFoG1FqZLjwZELs34aBC4Xs4LVfJPNKMJ/i5sH1EmKEo/B+RvpItIC/G
 ce57K8mVXzrMXSs6lE1HduRHjqCggfgPXw+7teqyvTNiV4dQ8PO13+CrUpxRbeGRjRza
 x1ZlTGdHILhEoqVckTeserzmsIJXQg4jmm6OLzraj/rdQfaEn/piWkfMHPwBBO9kpYpQ
 rBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277398; x=1777882198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+UtYw+wvw45FuO+6veL5kPFJkNDEH8lZGFLqErw/iU4=;
 b=eefGmMkscCqQhjoH5CQnyvfn0qgiyTnrtzbAClLDQzI0BVtMqrpoQ/XhphPXez6Rah
 QJXBLRNPD8LETXt3mhrE/tts6a0Uod1We9ATz5Q/Zrw3osqssmtuQjDTo7NWDV53buL0
 ZqpPJ5gdxAPL4z/RnG1w2/aChpDSXIoBGdhvFfuwVDC2hDZNuhVtYGgnrvHO4UtSYV/j
 PnseroiSedqgj6WoC+B1Vhxm7KP6IG1Yp8u9S/p2/q2SxhWnRPf+/YNCihdjfZoucOOC
 fzbmFnGowGpgEnBMwoFSdhcnb8uUheZ5UNLqBPQa91yL/CxdkZ4kRzYV0s5xURvif8YT
 SixQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9X9MPkYYGEFfbIqj7lALzIUTTHF/5hmpVCsaDGZCtiamrDVbLHZc7blCDnEtfeFevqjyWYZlhrfiA0@nongnu.org
X-Gm-Message-State: AOJu0YxXpVgfbe6Of0yxCc+CVbPZ0bB0kIqptRPC4lVKbK34lhsa2RTO
 DJze+CYxuukpQlMwPaACE7SK6Tgvhj3LD3IFjKV1ym0p8ldabwl917PJ2VXE+0VcNlF++JSoyyu
 NpReNx2E=
X-Gm-Gg: AeBDieuZuEL6E+HIrdWZrNzpoEhXoB3QsYhxVHpiFXFTKgrBwJ3YEsm3ebecIb20KYz
 p32w5ju7elgsg8fz5ZSRleCTufp81RVa3zALxaLrAqDY4RZLGJQDGUMoN9zxEvozCtE1jde0goi
 4VRrfs6NiIICi2hg5F9GkmJorbCvSZ/XsEhXNEUQyZCVhGCbbAzM4NadTGc0KV5xIltChieMtBX
 U4mm80rJrKlKI3sinW9OunGQc0eZ1hx0RNCERDx5liXWbdmOVKa5iSozgtup9d/2nBUK0bgjyem
 kT56WOR7ImBuiVeFUVDg0OIdG59h6Fihdj/j227YyU/E8xIc25NrhanreKZCV+60ZQZuKy0Fbkj
 8AmlTeOuOCywuPRgIGgZp8A2AE0oLDdMyRaEz6qpT43WiJC9DPks65f0wfCtmL3NlEu7UZcGHMd
 Vg9BZqdcThPqYHbCcln6zWisTliDzsiuTIeA8ZxRf2GZ79UwlULCBG1SbSYfrrj8MlnamlWMFl5
 6tkfTdEJts=
X-Received: by 2002:a05:6000:230b:b0:43d:7cb5:43b2 with SMTP id
 ffacd0b85a97d-43fe3db3150mr64172192f8f.15.1777277397980; 
 Mon, 27 Apr 2026 01:09:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm81979585f8f.30.2026.04.27.01.09.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 20/32] target/riscv: Register target_get_monitor_def in
 SysemuCPUOps
Date: Mon, 27 Apr 2026 10:07:26 +0200
Message-ID: <20260427080738.77138-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
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
---
 target/riscv/internals.h |  3 +++
 target/riscv/cpu.c       |  1 +
 target/riscv/monitor.c   | 11 +++++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 35b923c4bf5..47becca37f2 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -233,4 +233,7 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      int64_t *pval);
+
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8ac935ac06e..dbd88fa6655 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2720,6 +2720,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
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


