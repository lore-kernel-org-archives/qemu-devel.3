Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2CBC5AC67
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wssQE-0000Kb-0W; Sat, 08 Aug 2026 21:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQB-0000Hu-VK
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:51 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQ9-0002JY-QR
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:51 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so787861a91.3
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 18:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786239228; x=1786844028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3f9Ac7OlBEkyz59lnyXFdyvLMnTSbAqV+WB14jXB64w=;
 b=e1/m91dzysrfwGvTuhegPGE67RODJzLyOc6Cp1i7goutYzgmHKa4EV3wT+hG18k3gl
 TT1OB74cklYk8QLtywyjBKwNlU4WV6Qjinyfybh4RAQYziElanYl6cC0FWQYz+ySc/Xe
 7xedCoLw/AH45yc5g13fPmvA0hec8DW3sK7QkVsi8Y5ou2FG3l+JD5AC/itrRnBeS0aI
 mjdai4eAudlZFxZM5Jvn6M7OjGbY5Lv9kQJ1gilq/n3MluTGslPGGY8mmPHtjjheHXVB
 FAEGnVsRllBq2jjJncJgJvdLu0E90af9dz1flGuYMv1ksgT/Q5rZjqIfOOPF8VPnAbsO
 ymgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786239228; x=1786844028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3f9Ac7OlBEkyz59lnyXFdyvLMnTSbAqV+WB14jXB64w=;
 b=kplHEOAfYydSThQoxv7s5fEMbauMOWbJq5NI/1p0Rn+Xw6j2pNU+4DMon1NB2Z8Mk/
 m0z8Z3XWGXzM6Z8TWhQfh3mvoe3KxXqW/GCfTYi7SB5Xmw8pJIvt8xgPIQrknidwczTT
 K2lb9U1JFPAhk1s5TXjJ8/BOioj610Rq8sF/lvDWjnF+cKYbNCZ5568yYjSJkYLGSSj6
 Jvw+Mvp/svH0FqtfKxlrim2q9B6bwsH59v/gTmOw/USnbaDG0z1pK6skbWvPeXeunKzL
 TrLPQ3uBASo2iXcgj2PStQRN0ZrASkaPJN1lq3c2au1jfaVy1y33R39xYIJPRctOGErf
 pmcA==
X-Gm-Message-State: AOJu0Yzk4FppDNcxhh+YIYQO9Gsgw2qQkHlpPzvLRXUf0SEg/djEnB/0
 BVIBHTQ+3Q4zLV+SXXENav3ceQIIhAVrA9tHRZtGSj/FihNhftfWxqK+Ud0dNveWtjlrrGmlr0n
 ugsVI
X-Gm-Gg: AR+sD105Og0j1sqTzumpQ0+o9UrYlIcDHHSlCk+qh3RoQtyM3yqbvXUjzPouslqfSBM
 erh+KsU9tExE2T4ok4G62jm3Bw5tKycAmrrken8J9+gPmiuZRSouThOPFdcBJal8yo6EDHbfwn+
 bFrVXrzCN+wV9LyVsMfIBYlUk3waE+6T0x1XLx3ESCNgxatLnNf3jhXbSRRZ1d9FNI6CxgFEZin
 xJIYNfo5iV0Jfl7pQGlsPJvwEir7iZm8eb1P6JxX661FUy50u8p8YRjPZKmKKiColx4FP2FH/5l
 YYaZWSS75XT0e6PU3+3tUqhr5+O/46hstFUNNNEE3k6Q/OiTQavS2x+/kqwoR6Eb45nDKmzdJxz
 /c0XKGzuIq0XAIIc69oi1IWKsAdYUNlKJ+KTsxmUAKTGwJ85Ofes0Rx43hUkomlsIDtjjHI34p5
 sErIs4EblnRJ+YtUMncpAuXOJc6SgaQmhgK/HqCgo5K0HGxVY8AUFsAWe6lbH+ZJXocQSZwICJQ
 iZ0QTTt71AzWedZ6O6i
X-Received: by 2002:a17:90b:2782:b0:36a:8240:2477 with SMTP id
 98e67ed59e1d1-3903c60c488mr31941160a91.19.1786239228438; 
 Sat, 08 Aug 2026 18:33:48 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085de8ddcsm10067927a91.6.2026.08.08.18.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 18:33:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 3/9] target/riscv: Enable disassembly via capstone
Date: Sat,  8 Aug 2026 18:33:37 -0700
Message-ID: <20260809013343.664966-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809013343.664966-1-richard.henderson@linaro.org>
References: <20260809013343.664966-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

In capstone v5, riscv support is spare, but v6 is pretty good.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 34 +++++++++++++++++
 disas/capstone.c         | 19 ++++++++++
 target/riscv/cpu.c       | 81 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index c43033f7f6..5c78824da2 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -11,6 +11,8 @@
 
 /* Just enough to allow backends to init without ifdefs.  */
 
+#define CS_API_MAJOR     0
+
 #define CS_ARCH_ARM     -1
 #define CS_ARCH_ARM64   -1
 #define CS_ARCH_MIPS    -1
@@ -37,4 +39,36 @@
 #define CS_MODE_MIPS64           0
 
 #endif /* CONFIG_CAPSTONE */
+
+#if CS_API_MAJOR < 5
+#define CS_ARCH_RISCV           -1
+#define CS_MODE_RISCV32          0
+#define CS_MODE_RISCV64          0
+#define CS_MODE_RISCV_C          0
+#elif CS_API_MAJOR == 5
+/* The C symbol name changed between v5 and v6 */
+#define CS_MODE_RISCV_C          CS_MODE_RISCVC
+#endif
+#if CS_API_MAJOR < 6
+#define CS_MODE_RISCV_FD         0
+#define CS_MODE_RISCV_V          0
+#define CS_MODE_RISCV_ZFINX      0
+#define CS_MODE_RISCV_ZCMP_ZCMT_ZCE  0
+#define CS_MODE_RISCV_ZICFISS    0
+#define CS_MODE_RISCV_E          0
+#define CS_MODE_RISCV_A          0
+#define CS_MODE_RISCV_COREV      0
+#define CS_MODE_RISCV_THEAD      0
+#define CS_MODE_RISCV_SIFIVE     0
+#define CS_MODE_RISCV_BITMANIP   0
+#define CS_MODE_RISCV_ZBA        0
+#define CS_MODE_RISCV_ZBB        0
+#define CS_MODE_RISCV_ZBC        0
+#define CS_MODE_RISCV_ZBKB       0
+#define CS_MODE_RISCV_ZBKC       0
+#define CS_MODE_RISCV_ZBKX       0
+#define CS_MODE_RISCV_ZBS        0
+#define CS_MODE_RISCV_VENTANA    0
+#endif
+
 #endif /* QEMU_CAPSTONE_H */
diff --git a/disas/capstone.c b/disas/capstone.c
index 8fb8d0724c..78062339d0 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -49,6 +49,20 @@ static const cs_opt_skipdata cap_skipdata_s390x = {
     .callback = cap_skipdata_s390x_cb
 };
 
+/* Similarly for RISCV */
+static size_t CAPSTONE_API
+cap_skipdata_riscv_cb(const uint8_t *code, size_t code_size,
+                      size_t offset, void *user_data)
+{
+    /* See insn_len() from target/riscv/internals.h */
+    return (code[offset] & 3) == 3 ? 4 : 2;
+}
+
+static const cs_opt_skipdata cap_skipdata_riscv = {
+    .mnemonic = ".byte",
+    .callback = cap_skipdata_riscv_cb
+};
+
 /*
  * Initialize the Capstone library.
  *
@@ -76,6 +90,11 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
     cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
 
     switch (info->cap_arch) {
+    case CS_ARCH_RISCV:
+        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
+                  (uintptr_t)&cap_skipdata_riscv);
+        break;
+
     case CS_ARCH_SYSZ:
         cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
                   (uintptr_t)&cap_skipdata_s390x);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563b..a1a6c17b98 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -39,6 +39,7 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
+#include "disas/capstone.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "target/riscv/tcg/debug.h"
 #endif
@@ -1099,6 +1100,7 @@ static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
 {
     const RISCVCPU *cpu = RISCV_CPU(s);
     const CPURISCVState *env = &cpu->env;
+    int cap_mode;
 
     info->target_info = &cpu->cfg;
 
@@ -1111,16 +1113,93 @@ static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
     switch (env->xl) {
     case MXL_RV32:
         info->print_insn = print_insn_riscv32;
+        cap_mode = CS_MODE_RISCV32;
         break;
     case MXL_RV64:
         info->print_insn = print_insn_riscv64;
+        cap_mode = CS_MODE_RISCV64;
         break;
     case MXL_RV128:
         info->print_insn = print_insn_riscv128;
-        break;
+        /* capstone v6 doesn't support RV128 */
+        return;
     default:
         g_assert_not_reached();
     }
+
+    info->cap_arch = CS_ARCH_RISCV;
+    info->cap_insn_unit = 4;
+    info->cap_insn_split = 4;
+
+    /*
+     * Capstone compresses some features together. See RISCV_getFeatureBits,
+     * which maps LLVM feature bits to capstone bits.
+     */
+    if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca) {
+        cap_mode |= CS_MODE_RISCV_C;
+    }
+    if (riscv_has_ext(env, RVF)) {
+        cap_mode |= CS_MODE_RISCV_FD;
+    }
+    if (riscv_has_ext(env, RVV)) {
+        cap_mode |= CS_MODE_RISCV_V;
+    }
+    if (cpu->cfg.ext_zfinx || cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinx) {
+        cap_mode |= CS_MODE_RISCV_ZFINX;
+    }
+    if (cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt || cpu->cfg.ext_zce) {
+        cap_mode |= CS_MODE_RISCV_ZCMP_ZCMT_ZCE;
+    }
+    if (cpu->cfg.ext_zicfiss) {
+        cap_mode |= CS_MODE_RISCV_ZICFISS;
+    }
+    if (riscv_has_ext(env, RVE)) {
+        cap_mode |= CS_MODE_RISCV_E;
+    }
+    if (riscv_has_ext(env, RVA)) {
+        cap_mode |= CS_MODE_RISCV_A;
+    }
+    if (cpu->cfg.ext_xlrbr) {
+        cap_mode |= CS_MODE_RISCV_BITMANIP;
+    }
+    if (cpu->cfg.ext_zba) {
+        cap_mode |= CS_MODE_RISCV_ZBA;
+    }
+    if (cpu->cfg.ext_zbb) {
+        cap_mode |= CS_MODE_RISCV_ZBB;
+    }
+    if (cpu->cfg.ext_zbc) {
+        cap_mode |= CS_MODE_RISCV_ZBC;
+    }
+    if (cpu->cfg.ext_zbkb) {
+        cap_mode |= CS_MODE_RISCV_ZBKB;
+    }
+    if (cpu->cfg.ext_zbkc) {
+        cap_mode |= CS_MODE_RISCV_ZBKC;
+    }
+    if (cpu->cfg.ext_zbkx) {
+        cap_mode |= CS_MODE_RISCV_ZBKX;
+    }
+    if (cpu->cfg.ext_zbs) {
+        cap_mode |= CS_MODE_RISCV_ZBS;
+    }
+    if (cpu->cfg.ext_xtheadba ||
+        cpu->cfg.ext_xtheadbb ||
+        cpu->cfg.ext_xtheadbs ||
+        cpu->cfg.ext_xtheadcmo ||
+        cpu->cfg.ext_xtheadcondmov ||
+        cpu->cfg.ext_xtheadfmemidx ||
+        cpu->cfg.ext_xtheadfmv ||
+        cpu->cfg.ext_xtheadmac ||
+        cpu->cfg.ext_xtheadmemidx ||
+        cpu->cfg.ext_xtheadmempair ||
+        cpu->cfg.ext_xtheadsync) {
+        cap_mode |= CS_MODE_RISCV_THEAD;
+    }
+    if (cpu->cfg.ext_XVentanaCondOps) {
+        cap_mode |= CS_MODE_RISCV_VENTANA;
+    }
+    info->cap_mode = cap_mode;
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.43.0


