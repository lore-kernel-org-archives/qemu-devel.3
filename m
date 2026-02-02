Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1252BE7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn145-0004C2-Kb; Mon, 02 Feb 2026 16:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13M-0002CH-QV
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:51 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13J-0004Uk-5T
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-480142406b3so36543345e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066103; x=1770670903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dKMRrvX7UDbQAQDWoI8kadJYUH4efShqat9P1GFuQE=;
 b=EYpAUQSJ9YbSx7S4Pvgq9V/Gba2C8eAHwTjNxcbyApbwAGy5kJ5eZJgoBlLePNAIfd
 Qs/jLNnZ8cWBNZq61B5O/na5TjU/9CXYh1q5Q1mJEn/7YENdTxJ5vu/2uAZeLWVOjA5x
 H8bdC1QbzROv24qf8l2KiSeFrlf3+tEabqbrb7gvzVJGNnrQmMG9PB46jRi8hHUy9H03
 Lh2wVZ9N30M0UmVpPgQYNC8o21+8GVrzN5ztuezwaeSO1SkdrRbaWkcgdDsXuvlFlYOe
 ApyZFO5ZBzKVItxXW1RqYOnLQy7yxRgWqRZTa+EJVxOs+Pnh2kBbYpcbO4dN5LLXs5OF
 vV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066103; x=1770670903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2dKMRrvX7UDbQAQDWoI8kadJYUH4efShqat9P1GFuQE=;
 b=vqvr5oaPlWRb5CzSmAdiAG6iDz2A7155fKvTVfr9/RgS5W1Jb0lxaH2Gfv2saFHywI
 W8bH9dhFHOJDMxbSmjnBvdrj1ggdLurIsjUiRlcFUO8SX1Mpct+U3v4MSqCn2wozZqph
 Zc67P0C7pxzBxg6rAyWRNMnOk1cNHKuTE/XkydSN7hAah2d3UwCjsuxyByp3GTnSmr++
 avhF+fDZzveDwMnjQEcS7zpN0PFBBrPU7jEuvegPm6SuJUxfkvfkeW7tyESJRS0zWNHB
 OHD26nCqjSHpv4DqbeYf8tIzWvx5JsT5BENn47By2Gh+Ry0OIl+50PpiHaBSU5qH1WGx
 pBGw==
X-Gm-Message-State: AOJu0YzdcQO4up8YtGEQOmf1CSb8kIUl0byYhJVn1DxhXGApR3YTB4g0
 UOblJGMERrHmsCSivOHldZEAQbQXtu8JCAu83pEj+kvqgTro9InuhPnsn9qQaSvz+ShYGWwsSmT
 JG0vq3fA=
X-Gm-Gg: AZuq6aKkOr4bNVlkpgpYX3pCKcrgxKS1isjAe40D5qdaJogH3uK/+up9Z/7nzhQmJrM
 wBZfQF9REMIeh6YS7fqAZ1IsusQYn2YbU2TfkzmzmJETt6/F1rTaWMHQW6V0g1PqycrwDTbw5bU
 srN4pJEKpAeRUFOIC8ezJTfd3obqCl4N/+Ifbeb7NJ+/c3D+iErlKXiCxIPldbCefUMW9cFNxXS
 MQ1FfyBkuYmhPzoQTwD3FYh+y3uP9mj0iK1PMarWeNqMJLugF2Z3bZa+IHxRug1nddKJdcoWRWA
 D0odM+wA5ZTpYSv80UfYOkqkdKODM7Fay+KrP+wUoxMdljDfcy9rAPyIBOkdadMV45FGVSlvDY/
 A2o/dE4PXZW8QOhzw3TlrZSp2UEbIr7Z4MuWwrSRWt9fs3W7uEOePnl0T5Z9GKKH6gCMqmo1tgp
 kZ6MOkPkMgkNrdQSupfPUFFlrTcvvqg4RqMs+h4oK4/pBfZJutQQTcBs9bTMvkFzu27dM6OLg=
X-Received: by 2002:a5d:5f47:0:b0:430:f449:5f0e with SMTP id
 ffacd0b85a97d-435f3a7e61cmr18865712f8f.16.1770066103159; 
 Mon, 02 Feb 2026 13:01:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e490esm46697622f8f.9.2026.02.02.13.01.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:01:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 05/11] target/ppc: Introduce ppc_data_endian_env() helper
Date: Mon,  2 Feb 2026 22:00:59 +0100
Message-ID: <20260202210106.93257-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Introduce ppc_data_endian_env() which returns the endian MemOp
of the data path from the vCPU env pointer. Keep it hardcoded
as MO_TE, the target built-time endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/internal.h        | 12 ++++++++++++
 target/ppc/mem_helper.c      | 18 +++++++++---------
 target/ppc/tcg-excp_helper.c |  2 +-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 58f315ffcf5..c3d3590cc89 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -19,10 +19,22 @@
 #define PPC_INTERNAL_H
 
 #include "exec/breakpoint.h"
+#include "exec/memop.h"
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
 #include "accel/tcg/tb-cpu-state.h"
 
+/**
+ * ppc_data_endian_env:
+ * @env: the cpu context
+ *
+ * Return the MemOp endianness of the DATA path.
+ */
+static inline MemOp ppc_data_endian_env(const CPUPPCState *env)
+{
+    return MO_TE;
+}
+
 /* PM instructions */
 typedef enum {
     PPC_PM_DOZE,
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 90546967593..ca84131d1a9 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -88,7 +88,7 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
         }
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = ppc_data_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (; reg < 32; reg++) {
@@ -114,7 +114,7 @@ void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; reg < 32; reg++) {
-            MemOp op = MO_TE | MO_UL | MO_UNALN;
+            MemOp op = ppc_data_endian_env(env) | MO_UL | MO_UNALN;
             MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
             cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
@@ -158,7 +158,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = ppc_data_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         /* Slow path -- at least some of the operation requires i/o.  */
@@ -174,12 +174,12 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
             break;
         case 2:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = ppc_data_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             break;
         case 3:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = ppc_data_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             addr = addr_add(env, addr, 2);
@@ -254,7 +254,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = ppc_data_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (; nb > 3; nb -= 4) {
@@ -268,12 +268,12 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
             break;
         case 2:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = ppc_data_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             break;
         case 3:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = ppc_data_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             addr = addr_add(env, addr, 2);
@@ -304,7 +304,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
     if (unlikely(!haddr)) {
         /* Slow path */
-        MemOp op = MO_TE | MO_UQ | MO_UNALN;
+        MemOp op = ppc_data_endian_env(env) | MO_UQ | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (int i = 0; i < dcbz_size; i += 8) {
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index a8c67364669..3f9eb3d924e 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -161,7 +161,7 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
-    MemOp op = MO_TE | MO_UQ;
+    MemOp op = ppc_data_endian_env(env) | MO_UQ;
     MemOpIdx oi = make_memop_idx(op, mmu_idx);
     uintptr_t retaddr = GETPC();
 
-- 
2.52.0


