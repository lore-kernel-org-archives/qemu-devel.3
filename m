Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0BDD6CFA2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1od-0003Lu-Pg; Thu, 22 Jan 2026 16:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oS-0003Fc-S9
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oQ-0005Iu-Uy
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so1203868f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115712; x=1769720512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkPs1FcFNxMJ8Y8uZWUMxNftxsmN7tKxj2I2BegJ4Gs=;
 b=RGQ0ukp64rv4gDyOkD66gzcBd0RKOGE/ESHYJN8Gx3BmJiR6Dfu6Lp9jiI6Nib3aja
 l6bvAzg+0ftif/ht8atycUPN0R/FCISzOQk4hUWjVrfkKV6T/g4JKRH25x78rm2fmEGb
 4XBKcKCPas2yIySdi34csNDjENz2gkJZen/N7+3C52iCqFtFQdI0npsR+DxYnYkegf5t
 lCZnQpDnA9s3hfKRpqQRyNQcQ4Nlkv96ZI40iQ5EvHsGBEUsUANG1qHwFNGunyKnW4op
 CUqfTEAlRLk8kZUZgH21+F5UA6Pxd9s/ZWYcuSiGMtFyuwnZIqLIILpdBmOdEIZ+cRno
 2LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115712; x=1769720512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RkPs1FcFNxMJ8Y8uZWUMxNftxsmN7tKxj2I2BegJ4Gs=;
 b=HweJt4Gu2EW9R5WxySOsP86waBkbIDIec4AjkX8YA0KLqkWgNs1ADYWOB3XIb0iaMS
 9jL5dFp36Dw7P1wF4V9pi/yC8eO7gH4Xqb4sgqYw1D4agwwXRMjE26PPhbz1IRvXf/l0
 Mmlf65cLG3kdHbwxukR4gI41JcnD1lq9L3cFYdkXzjLYL9ZzF9uRZe7BdJwP46kPnkiw
 QxYy9Znz+GafRCbWvXLXsC5y1jMOk5OCgsnu3CduKMbTv9i4kobpVHSg9fXhAVX4AXxN
 AMqWJBe5BbjZV4MHx2UaepD+cpR/jw8oRM2BzJ2O4OHXFTQe/1AclW4gsi3iXXND4RLW
 umdw==
X-Gm-Message-State: AOJu0YxRBL7BKPKyquKPd5MFHWLCArk/5uaPfHfktooQlOAAmYZqQouB
 uh/1UZKxwCDE2GJ3qhRwDqjxHMJQ4ThxzXTFoFzyaAPmcXgUlGYNjHZ+954fVCKP8EtB84XdEPv
 oLYO6O24=
X-Gm-Gg: AZuq6aKVln6Lv3BYbNYDFqYLXs4rrqi1vu5HOLdgEfpBCODJyW9Xk6qFSwwE5bfMVST
 M+0d+O3Pwihwbdysfl8G+a/Rx4RN2i2JgL7wUpVNV/ulRBSMi0iwygjHpk6m93+UnyQ/gX5Sm7P
 D4gdOhzZ1WmcD4VTAUD8k+bgaUI3C13J2jKQT6MXRV3r7Ezb59mPEXsBI2WmDiZ1bobXj8OBAS7
 T3rEL2vRhoqUuxUAZIzH3rBj5SPWK6Nml7mSjGd7Y/sZ1Nu9W1IdgrIs153mI0MoKI2t/Z4Ug0a
 tKL2a/DtM83QLBayXETQBWlG3yXKP7STypY7mGN+ka4U/MnY9ZqNLu3PmfKCLakr1Cgg6yetdjw
 bnE9L+Wjyjwr+0q0T5GjtSwCqCRFNUoNex6pQkl4ClDjolkBRZrY/8nQeoZlAe5AQ8XfIJ0sWtF
 /9XD1aNzuUdjOlg+YJxnKHnSjxCgstmaFariUFctjdQd+7PWH7LKdGflQ6vIFK
X-Received: by 2002:a05:6000:268a:b0:430:f9c2:8500 with SMTP id
 ffacd0b85a97d-435b1606292mr1582805f8f.43.1769115712207; 
 Thu, 22 Jan 2026 13:01:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1b6e2besm1446963f8f.0.2026.01.22.13.01.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 07/11] target/ppc: Inline need_byteswap() and replace
 translator_ldl_swap()
Date: Thu, 22 Jan 2026 22:00:57 +0100
Message-ID: <20260122210101.55358-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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


