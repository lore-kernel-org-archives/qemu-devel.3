Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0722D6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1pU-0004Eq-RP; Thu, 22 Jan 2026 16:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oh-0003Rw-5u
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:02:11 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oe-0005KB-7X
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:02:10 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4327555464cso951301f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115726; x=1769720526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDHngiUwEbIgiBsmhSfkRWTOLuQP8i2N7EL07ewZgHk=;
 b=R+FOONq6MhxFCNVNIsSj53slscQUQB5VZ0azKtfBBbb3VrD8NtA7rLp04Kfl/UO5jI
 Yu8SV2gPL8x7GMyMBjfW5whtl7yq/Ur2Z5EJG8ammz0HbRJBCEDaGr1zHtivi/tLwW1N
 6FteHf2GVOYawnZgJC+WqjeuHGOQjtF7s8reej+2cr1b4FNVmAgIyH8UIfLcbxzee+CC
 J1Cke74ZRs2OshNsjN/akm4aKTtG7ElmPN8b4xHUrTLrxZ7e/slr/Pl89sbPGyia0UUk
 L/iHPJ6oLl/2/uUz2U97bTeP0ZpIX4Fxe6tIx66IBRstdcDOOjqV7VFOiz6NzSlS65uP
 Vw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115726; x=1769720526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XDHngiUwEbIgiBsmhSfkRWTOLuQP8i2N7EL07ewZgHk=;
 b=eojNNzQajYCRvzSzGaP3IeSnb0bTq/ePdBJAh78EJt6zLHb4viZaTs0S5lnaf3RZqX
 TI3jmcUrrjZCMHYEGLdkgFBqe8F0H1RGbD2M4SJwHMRyqNVrKARlkbur8n0c2TXOXhmo
 3jyS0Xgij4/zH6If4E5k11aXvi47WLcENVc/toMCWosgZcSDq68izvhxsmevZ3WeIvzS
 5/y0h+aphe3FkgWR8PNUpOhEHyi/PIGll2IFsBkFhJj8gZ6L7vSRrIkPpve5VZAM/Yu7
 8l51lN/3rRqGQLhgIoFC7BPPuVFSMjj2G1ooF6OhDybajoNZqabyahcGlyAhvokms328
 ZuGQ==
X-Gm-Message-State: AOJu0YwOu/C++B/91tblmlRaQ+tLFTRbl0Twg3G6FfSPkJ3JnjpIL9am
 cWHm+Q+GmRXyYaheiasq/esRsuPA2bLl6ciCMPj3NmPQ3FNkLJR3k5zVAdF1Hw9W1Hj9SAeqoyv
 Klfjrm6o=
X-Gm-Gg: AZuq6aLjH/6GPonUD2Jn7pvZbT6tTRgvi9LORVSHDodin2whj2bUmjbCgLhz7ZKWzBG
 5r5SzRRpR04vctSiedopcfR3LZ9ktKwpOZzSH4Gj1nipOZXg9m0mZ27687FwWwo4KW3psEQG3pO
 w0tOaRxY3S30jvuiQnTjJk6yH8ONQQUrbfzBT60jCF4lX/E6tHUUmFYbiCFtkCdCBQnnllBSsif
 SrJDtWNGYWeq/JFA5ZZe2XqRAk9l04yP46AWeqCc63Lq1xbXlNpogO7IvzTv9bNL+umpeTouoPS
 /XlDrRMB6fG5zMOJmJTrysev/B3uHO8NuPd3AyXYPBo0+upIh4yL9un1SExGU5lp2gr7b0qql8N
 Nalt60ngZqImp8Aau1VdzloUOFCcQV9PlHWvUJaQccWNE6xo+6zwG1IsBiPM69RRKwrxi0jkiZY
 DVmqcBYhL23skJfNk88mr3exazkONol7KcINHt1+h5d8M6JH3P0YZKmMcVxVlL
X-Received: by 2002:a05:6000:23c1:b0:435:9d3f:92ee with SMTP id
 ffacd0b85a97d-435b17501f3mr1135404f8f.57.1769115725925; 
 Thu, 22 Jan 2026 13:02:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f73855sm1284107f8f.29.2026.01.22.13.02.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:02:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 09/11] target/ppc: Introduce ppc_env_is_little_endian()
 helper
Date: Thu, 22 Jan 2026 22:00:59 +0100
Message-ID: <20260122210101.55358-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 3c91d641f9a..c483b60c9d0 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -416,7 +416,7 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
         int adjust = HI_IDX * (n_elems - 1);                    \
         int sh = sizeof(r->element[0]) >> 1;                    \
         int index = (addr & 0xf) >> sh;                         \
-        bool byteswap = FIELD_EX64(env->msr, MSR, LE);          \
+        bool byteswap = ppc_env_is_little_endian(env);          \
                                                                 \
         if (byteswap) {                                         \
             index = n_elems - index - 1;                        \
@@ -442,7 +442,7 @@ LVE(LVEWX, cpu_ldl_be_data_ra, bswap32, u32)
         int adjust = HI_IDX * (n_elems - 1);                            \
         int sh = sizeof(r->element[0]) >> 1;                            \
         int index = (addr & 0xf) >> sh;                                 \
-        bool byteswap = FIELD_EX64(env->msr, MSR, LE);                  \
+        bool byteswap = ppc_env_is_little_endian(env);                  \
                                                                         \
         if (byteswap) {                                                 \
             index = n_elems - index - 1;                                \
@@ -475,7 +475,7 @@ void helper_##name(CPUPPCState *env, target_ulong addr,                 \
     t.s128 = int128_zero();                                             \
     if (nb) {                                                           \
         nb = (nb >= 16) ? 16 : nb;                                      \
-        if (FIELD_EX64(env->msr, MSR, LE) && !lj) {                     \
+        if (ppc_env_is_little_endian(env) && !lj) {                     \
             for (i = 16; i > 16 - nb; i--) {                            \
                 t.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());   \
                 addr = addr_add(env, addr, 1);                          \
@@ -506,7 +506,7 @@ void helper_##name(CPUPPCState *env, target_ulong addr,           \
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


