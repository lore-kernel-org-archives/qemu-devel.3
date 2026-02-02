Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C6E7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14C-0005GP-Sb; Mon, 02 Feb 2026 16:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13Z-0002kK-BJ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:02 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13W-0004Xh-L3
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43590777e22so3091496f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066117; x=1770670917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GYtXYwLjyQ4L7gUf7a69nMvlzjx1PzBJaCNpq/QF/A=;
 b=WDvqs5XC8EWrGfpkC2fvty2r66yHpjvZ3qV+O/eCfCykIqSU/U2zXfPUv22nwOLwXt
 qC4J/Exz1lkwUPozQwwcls/Ep1WssBVSFkX4Pgx3tZm0Ov4h0xM0Zy0dGqgqBfVXgxho
 mIT1Fo7xgeVQ1DRaVD0aYmXmMNpV3bBkgOCtbzlEixCvn8x9Cq4204UcBYZSzh6qxW12
 aoi7U0QujcM72E3iYGksoZoX1JzV2pxTFu6lkFK+XlbbQfAZbMm/eq2fll54k+JShcqi
 dbG3o13K9jAF7Bplc7FP0gvHwrvxCUN5UkET65C9eQzy7LP/hsE/QpXgRcQQBLZ53boK
 ZaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066117; x=1770670917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8GYtXYwLjyQ4L7gUf7a69nMvlzjx1PzBJaCNpq/QF/A=;
 b=k38PUebibSv8aiF0+FPVJ7E6LPyIGo8j2ELbkSUBxdLklTferkZDnOYgUzH6DavTzB
 0xb7nfftgKbd5CMbSjqL/S54/7KTqMealESVbPIYmJc0dRv7UvSHcu2Sxkx9G0+Vagrg
 iJGanJyfh0WrVaj0PAEtnUCu4wbGZvgadapbu2rIHCK0aG4br2oR+leGJ+mtw4vnbUJq
 UqLHE2YApGiT3t1BAqrhz4SdKmE8nluhH6cOyVozpz9Fhw49+Gk4HggFNx0U8XRh3Ke6
 synctS0120+m6FBVpaE92suzioJfQHq72sdolCWsa5mJf5XjQwn5JXGu/tVKqsNCd9lL
 NgUQ==
X-Gm-Message-State: AOJu0YyxGitVM9mt2ErPoV/pOEpcrLiZIpDlxmlLUMW8RgBmJHAfBQDc
 W6sroKb9x58kwQdRP0NryH87BZQRRhTMt212MlqqOsV2YnjxLkYgwUkZY+mxBItCXYyqGqhmORK
 zK1zJCSQ=
X-Gm-Gg: AZuq6aIsYFBGQMOLLOQGYrfP8kzkPbpNuZX8FaGkdDaOFgG0CneNYsuraFxlRGBgoaX
 jCAslNcoGby91du9B5wMBq+DRw7pBJ8CWZRs4zARppuJ93oGBiTpypoBlIQzULe0G+02+iMioL+
 BScHo7yL8pPnTnEbFzFSEeuOI8/TTDeo5qKczaEa4YmEJ0vTtjyg8xFtNLGazw1g5HTSh75akGz
 m9HbLwq9z8eT2KkbvwTGwlmjo6JtzLTi2lPWdRQK3YNWClGAxeYV4lXU2TE0vCRAdqZ4oLxMQr5
 Cz0+mfvRdF/gOMqmdcr19i8d56BE80XN90I5LmisL4snkovphi0azP/khCh5yBhBJcny4iEX9Gv
 S6/pbmT2trIjSF8WOsRIOPiXiBqJy4x3Rs7Nk5n3o6mDilA6mh3IVsk6wgQ3JCXzcZNzL4OjuSJ
 V8isdW284lKjxUDs8esGEZG8yGgUJ7J710pSpX6WhaOfFreil/SAqNpNFiP1GL
X-Received: by 2002:a05:6000:40c8:b0:431:104:6dc2 with SMTP id
 ffacd0b85a97d-435f3a674f5mr17649342f8f.8.1770066116806; 
 Mon, 02 Feb 2026 13:01:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4360ef9e804sm5041493f8f.41.2026.02.02.13.01.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:01:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 07/11] target/ppc: Inline need_byteswap() and replace
 translator_ldl_swap()
Date: Mon,  2 Feb 2026 22:01:01 +0100
Message-ID: <20260202210106.93257-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e1753ce19ce..e9acfa239ec 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -225,12 +225,6 @@ static inline MemOp ppc_code_endian_dc(const DisasContext *ctx)
     return MO_BE ^ (ctx->le_mode * MO_BSWAP);
 }
 
-/* Return true iff byteswap is needed in a scalar memop */
-static inline bool need_byteswap(const DisasContext *ctx)
-{
-    return ppc_code_endian_dc(ctx) != MO_TE;
-}
-
 /* True when active word size < size of target_long.  */
 #ifdef TARGET_PPC64
 # define NARROW_MODE(C)  (!(C)->sf_mode)
@@ -6595,6 +6589,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = cpu_env(cs);
+    MemOp mo_endian = ppc_code_endian_dc(ctx);
     target_ulong pc;
     uint32_t insn;
     bool ok;
@@ -6604,7 +6599,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
               ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
 
     ctx->cia = pc = ctx->base.pc_next;
-    insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx));
+    insn = translator_ldl_end(env, dcbase, pc, mo_endian);
     ctx->base.pc_next = pc += 4;
 
     if (!is_prefix_insn(ctx, insn)) {
@@ -6620,8 +6615,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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


