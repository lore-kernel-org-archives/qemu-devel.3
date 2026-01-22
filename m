Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACCCD6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2ug-0007nL-O6; Thu, 22 Jan 2026 17:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2uV-0007bW-Cg
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:15 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2uT-0003Ts-JM
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:15 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so1337067f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119932; x=1769724732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXuSVtUqeSVJiLqCyCxZODoojrbZ2viLxGKE5qbD3lQ=;
 b=NKeK7COlE4BTyN1erGDwdFRNFrWL1kiqqIWtvdpkxJx9Qhvw76G2NfbJRK/YoceZem
 SkoU0wgvyig0hySz5fKjkAloiDco1Gylraceg4XobrN8OHt7oJUuDPwH6KFppu1uL3SM
 12WGmxO/QkecOYlRnVaW+9zAFAjYTTPJg5E7wt0f+MYmvljli8K2yD+PBmt69BXWN2JX
 yU/RxcxjvQKHfRNlnwZRn/Yfzn9rChxCan/ehlnTbIVXVhcpZNhqaqitgk4yCFyHjWfl
 K1xui2xgQrqK2KmfLowELdIyv3QXXl/m3/gZaOqnIKkZK8Q3cmwefR2B9uvVFnUFmTwt
 sICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119932; x=1769724732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VXuSVtUqeSVJiLqCyCxZODoojrbZ2viLxGKE5qbD3lQ=;
 b=fP6lXFrNQ8ohpYVRAk+gHMtKsdhj+HC83beATiH2sAQiF5rWlW8KIL/BC7iQnQ1h2r
 P9HonG9o2+kuS7cgN1tkUn2FVgX6Rpeyj0Zqd8QweaEEQYtzIIk0uHvmCCtbF94fMrBP
 rZm8WKA4pTTIUDYgU/sDgyrzgdZWjQHnMbrlbXl1IeZKLZ1F73Ip7lwXoPmEx3rwEjik
 GUKDFbjHlU+kgll3Nw6py9fgI3chWGZdUya+EwzLoSKGIyYaKom1XK3YygDvqFyJC7Zt
 PMDQf5c2njPU9MhnBwIyoN1dVWG0Vnx7bYpoj7Dtoe8VmfswyyQPL7aJFeVa6/6GH5wI
 +oCA==
X-Gm-Message-State: AOJu0YwQK1vTFHWBv6WgHl/O6VDd6HspybGRI2ASFc6P+9NdoNcvY33N
 r6oZqRPmYg8QsIk0L/XPcQBwZIfdIXcwZ/1KYa2zF3mjrNHdl3kS5F6hBnJ0ujdTu+nyqe1raLx
 9ZbCrZII=
X-Gm-Gg: AZuq6aKzn6uis9jLpjUQw1OOs2YBJvP3mttfFrxtY+KmIOT2Q7dCzaHlZwiQTlpbLIG
 9uJNM173Fo8IS2PyDVaDGtQhb0YinoniEg96xshZaJZ0ubq1dwgQanQOlZsMunnKEqqOQZaSlbQ
 07UVRQtlklpsG9wHOsmn/DXVOu6o6iMuKp7A+WtjX1rU1x2Jb1zBFrjxQwxXj8TwsEwL5Wknktb
 HOb6P+YnIlDt9DdtisbCOdEuq5+bXUd8mE+kb+ce+XNJcA2RBPvAcwefi300YcSBf7jfrOfUP2y
 UHU4PxQW8hoW35EsKhwJ7k16qeM4n/aFwk1U4Rvhekwn0z3JsqGFZUAg5lDTDaYLO0sug829G2R
 NIiGz09i2KpLgI7sql7+/XsiUw82ln7v8LkMGzIGN8CgF9r9Ux5YDE1WdV2FyRbZuTG/KXHJWxo
 6DCQxnABz4Lz6gKa6YsePtfSLBwCIVCJJN7E70E8k5c+yZQEmzE6i5FIaLPB6A48jwE00J52g=
X-Received: by 2002:a5d:5d0e:0:b0:431:369:e7b with SMTP id
 ffacd0b85a97d-435b159cbc2mr1650539f8f.18.1769119931542; 
 Thu, 22 Jan 2026 14:12:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02dd4sm1609429f8f.5.2026.01.22.14.12.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:12:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 09/11] target/ppc: Introduce ppc_env_is_little_endian()
 helper
Date: Thu, 22 Jan 2026 23:11:03 +0100
Message-ID: <20260122221106.57184-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
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

Centralize endianness check on MSR via a common helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h   | 5 +++++
 target/ppc/cpu_init.c   | 9 +++------
 target/ppc/gdbstub.c    | 2 +-
 target/ppc/mem_helper.c | 8 ++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 09333bed342..714629079b5 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -24,6 +24,11 @@
 #include "exec/page-protection.h"
 #include "accel/tcg/tb-cpu-state.h"
 
+static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
+{
+    return FIELD_EX64(env->msr, MSR, LE);
+}
+
 static inline MemOp mo_endian_env(const CPUPPCState *env)
 {
     return MO_TE;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 0808284b722..c5cec7c2ed9 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7364,7 +7364,7 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
 {
     cpu_synchronize_state(cs);
 
-    return !FIELD_EX64(cpu_env(cs)->msr, MSR, LE);
+    return !ppc_env_is_little_endian(cpu_env(cs));
 }
 
 static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
@@ -7456,11 +7456,8 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     CPUPPCState *env = cpu_env(cs);
 
-    if ((env->msr >> MSR_LE) & 1) {
-        info->endian = BFD_ENDIAN_LITTLE;
-    } else {
-        info->endian = BFD_ENDIAN_BIG;
-    }
+    info->endian = ppc_env_is_little_endian(env) ? BFD_ENDIAN_LITTLE
+                                                 : BFD_ENDIAN_BIG;
     info->mach = env->bfd_mach;
     if (!env->bfd_mach) {
 #ifdef TARGET_PPC64
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3b28d4e21c7..b19c0f1ea9c 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -84,7 +84,7 @@ static int ppc_gdb_register_len(int n)
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
 #ifndef CONFIG_USER_ONLY
-    if (!FIELD_EX64(env->msr, MSR, LE)) {
+    if (!ppc_env_is_little_endian(env)) {
         /* do nothing */
     } else if (len == 4) {
         bswap32s((uint32_t *)mem_buf);
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 89718441310..31057c6440a 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -420,7 +420,7 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
         int adjust = HI_IDX * (n_elems - 1);                    \
         int sh = sizeof(r->element[0]) >> 1;                    \
         int index = (addr & 0xf) >> sh;                         \
-        bool byteswap = FIELD_EX64(env->msr, MSR, LE);          \
+        bool byteswap = ppc_env_is_little_endian(env);          \
                                                                 \
         if (byteswap) {                                         \
             index = n_elems - index - 1;                        \
@@ -446,7 +446,7 @@ LVE(LVEWX, cpu_ldl_be_data_ra, bswap32, u32)
         int adjust = HI_IDX * (n_elems - 1);                            \
         int sh = sizeof(r->element[0]) >> 1;                            \
         int index = (addr & 0xf) >> sh;                                 \
-        bool byteswap = FIELD_EX64(env->msr, MSR, LE);                  \
+        bool byteswap = ppc_env_is_little_endian(env);                  \
                                                                         \
         if (byteswap) {                                                 \
             index = n_elems - index - 1;                                \
@@ -479,7 +479,7 @@ void helper_##name(CPUPPCState *env, target_ulong addr,                 \
     t.s128 = int128_zero();                                             \
     if (nb) {                                                           \
         nb = (nb >= 16) ? 16 : nb;                                      \
-        if (FIELD_EX64(env->msr, MSR, LE) && !lj) {                     \
+        if (ppc_env_is_little_endian(env) && !lj) {                     \
             for (i = 16; i > 16 - nb; i--) {                            \
                 t.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());   \
                 addr = addr_add(env, addr, 1);                          \
@@ -510,7 +510,7 @@ void helper_##name(CPUPPCState *env, target_ulong addr,           \
     }                                                             \
                                                                   \
     nb = (nb >= 16) ? 16 : nb;                                    \
-    if (FIELD_EX64(env->msr, MSR, LE) && !lj) {                   \
+    if (ppc_env_is_little_endian(env) && !lj) {                   \
         for (i = 16; i > 16 - nb; i--) {                          \
             cpu_stb_data_ra(env, addr, xt->VsrB(i - 1), GETPC()); \
             addr = addr_add(env, addr, 1);                        \
-- 
2.52.0


