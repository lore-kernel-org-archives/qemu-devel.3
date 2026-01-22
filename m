Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4E7D6CFAA
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2uI-0006op-O6; Thu, 22 Jan 2026 17:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2uG-0006hZ-PZ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2uF-0003NQ-6x
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso18500035e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119917; x=1769724717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkPs1FcFNxMJ8Y8uZWUMxNftxsmN7tKxj2I2BegJ4Gs=;
 b=Pd6QNhVB4SV0+1K+YWlK9SUoRtOfeC3jNxPbpqU58ODzHx2l/HmAvfmG4Lwqv37YIT
 ctcFBzJ8NZKIt+Tm1xPqvcXWFaI/GadwttkK/kOfrrRP1QINBuSttM8zikzXctKgXGs/
 u9dfxi+oCIuOBL/tAvFHKG1BCBSiF59j9e4bm+UUqCuLqxO4FtwVlNOvOWcHRp46beY4
 rLYdfb31zI1KKWUEIxY4/D38j9xY62nv+PEx+Bd9rAtKZ4kUMOrGg3mcyPTA2Ll/S8uz
 bj8TdmK8SzALlOnYqp1oi9pXMGulpGp2iBI46pZQpxidmVJx4UAHnbR9YWTdSn81gUj3
 N1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119917; x=1769724717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RkPs1FcFNxMJ8Y8uZWUMxNftxsmN7tKxj2I2BegJ4Gs=;
 b=iCZcWb0Nm5s2Pd8ogXUna/9dckGwVc3EHFEgKZ1XVsZgsiPPwQyO/rt3UlrqbdzSMA
 HONqvWWJjs9WDFufvloRf154Az83OH7+K/1Qdhj64Xo4hpUrw9O+zqDuCYPK+iXvnkZV
 USfW9Sg+bLSN4W+MplDYVtlK/j0gK2bdhjhf9rgsQQZiRQpY1PZFoAdaB3kgoB0se9PC
 HVQLhU6tFV5Z5aMj0H3EzErIHRTridgmeL57AFoFLciuLQweRIcau3g9lMAy1ZmPcX+o
 OCY9Krh1f1vnknm5Jlx/ND5LP5IPX05Ize1pG/BlDsf43blHg94BUdt65JFasMtGlh17
 mhUg==
X-Gm-Message-State: AOJu0YxYmBjtzZzpav9l71B6tt7XzI0wnWdZi7FT9swy6Tyn3CwYISpw
 sBimx6bAiZ6C3g0KeUFSiw3gHbDF9kwd+BS8DSST0uojSf4aBIZhfW9bettjp8FfB8yD7VgVfI4
 ktRzryfo=
X-Gm-Gg: AZuq6aL1uvo5bBVXtJGTePkj+roYzGYxyXL82pnyLN5yJrbgQmiedXZYOkuXXBR4EWx
 PvQf2Q0LjM8yYWpVJAV6WNs9/1p+3P1l3EsLNJX8O3SpzU0ZJzIJ1s4Y8K9WoES6wFcMyJ7qtCE
 zzyDoLjaDLz6857d6L/LpwHF4oO3f0O80n+gCtvDhQ6rp/CCVZQDyFPD1UwXxYs06z+bRLXY9zD
 bj5CgqUrGrcgYbXVTglzWDDh40tlRE96Zc5dRO5Z+D5NpONzDbw+CeG6h+UC0MsbpPTs12ZB4+P
 wT8utW0W2XwMnzD1dhTPo+bAf1mNX6v/fymRAnTWtTslxKsvA3WCG4kX2J8cBkxG4v5gB2BLIEg
 5tqQhz3cA1t3HPNtPxAy3ewYQ6pEilxWAGwxFC/lwPs4PSPq0cJT+hZvdtXi8Ezcqdo8JFfzW0i
 EoGVaaxrakSLugZeO8ak/pRvdwh5bNvD6DV6X0p54KJMyhikHpc0VRcWnndmsM
X-Received: by 2002:a05:600d:108:10b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-48047052112mr53492885e9.1.1769119917166; 
 Thu, 22 Jan 2026 14:11:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d7d2d9csm12296625e9.0.2026.01.22.14.11.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:11:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 07/11] target/ppc: Inline need_byteswap() and replace
 translator_ldl_swap()
Date: Thu, 22 Jan 2026 23:11:01 +0100
Message-ID: <20260122221106.57184-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Rather than using a boolean with translator_ldl_swap(),
get the MemOp endianness with ppc_code_endian() and pass
it to translator_ldl_end().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a9199a4473..2ea18e7981c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -219,12 +219,6 @@ static inline MemOp ppc_code_endian(const DisasContext *ctx)
     return MO_BE ^ (ctx->le_mode * MO_BSWAP);
 }
 
-/* Return true iff byteswap is needed in a scalar memop */
-static inline bool need_byteswap(const DisasContext *ctx)
-{
-    return ppc_code_endian(ctx) != MO_TE;
-}
-
 /* True when active word size < size of target_long.  */
 #ifdef TARGET_PPC64
 # define NARROW_MODE(C)  (!(C)->sf_mode)
@@ -6589,6 +6583,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = cpu_env(cs);
+    MemOp mo_endian = ppc_code_endian(ctx);
     target_ulong pc;
     uint32_t insn;
     bool ok;
@@ -6598,7 +6593,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
               ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
 
     ctx->cia = pc = ctx->base.pc_next;
-    insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx));
+    insn = translator_ldl_end(env, dcbase, pc, mo_endian);
     ctx->base.pc_next = pc += 4;
 
     if (!is_prefix_insn(ctx, insn)) {
@@ -6614,8 +6609,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         gen_exception_err(ctx, POWERPC_EXCP_ALIGN, POWERPC_EXCP_ALIGN_INSN);
         ok = true;
     } else {
-        uint32_t insn2 = translator_ldl_swap(env, dcbase, pc,
-                                             need_byteswap(ctx));
+        uint32_t insn2 = translator_ldl_end(env, dcbase, pc, mo_endian);
         ctx->base.pc_next = pc += 4;
         ok = decode_insn64(ctx, deposit64(insn2, 32, 32, insn));
     }
-- 
2.52.0


