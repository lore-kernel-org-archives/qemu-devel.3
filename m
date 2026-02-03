Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0716E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHyX-0001Ph-7u; Tue, 03 Feb 2026 10:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyD-00014k-FC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyB-0001lJ-18
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:36 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso58692885e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131133; x=1770735933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3JkkiWNW/vPY7qYcJZ62kWywsjWOtipez8oarLaZo6g=;
 b=sYTphMSKAXoIcE3xYxHZxdiPrUdSLCCqvD3QwCMelz79TX8XNkTw1KsccD/UVxX+Jh
 Et6mrSlZXvk4TShgbP1atPCKWzuFWDhvZTvgX16nHnn/b9P1V3acz3TyERl4qKMIJjJj
 3x350lyTxiauLrskWdHEIG4vg4HxUuoY5URet0RUSLAQlczVCmUk2jo8NB+0o1cAcg4a
 of1zD5E2ru8pAWMd9Iy3rC8FgsEy66LBWHetO9ZQMheo424iqRYghpGXDbRTtNk6G1ku
 65o9a3tQEZJXJJJZ9y91hpwnsn7EDzDJmvNIx80fade0Wgp3a/fCFg2W+qYGeoYPylYN
 XSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131133; x=1770735933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3JkkiWNW/vPY7qYcJZ62kWywsjWOtipez8oarLaZo6g=;
 b=pS6lYE1hkpT2JtaXRxlqXoBHmhDwIsUSYk0XRgTFsVSXYdRPAx7GUugPbp2Cw3vmCJ
 KXHclTtP9GEkQShtHLCKaXX76e1LijZTRLmaOBzZABSqvWEeYbDZX9iAVe5tjiTsvlCP
 ycBc06CizEAd1yFkRj+YMKvSrFGHb3VfP8Iu+kUlegWEg6vCUPvjPXQeamgmTvRwWR86
 iJXlovCUu0Av4QjAHJULIRv49nUGl7VNjwViuKd0h1T2xWIojWGytW0Im3f0JBftfMh9
 M7YYB1m9s6aER3pS+R4Bfcoj1Swkshwnll4ZB03VilAsbDCdqoL13dQjOAEVyVr94tOv
 axJw==
X-Gm-Message-State: AOJu0YzjLbRl6awyH2mCuyQAcKwATBaG7iFZzSFzrYD0beLys7t6Iqj6
 CECoyclcSH7vlUOGxxmR8d4zjPTENEQfe3/T5Q0NmwAhUuFQ4kbgC/tgf3RqW4wyz/6t6/7in9X
 /hSvjQyY=
X-Gm-Gg: AZuq6aKY8d9gTgzD22Xq2k2aRTX58SOhPJIyOb8Mn7iRoIMRkwsfRF3S2l//Vrxonbk
 v+woafVhUGXFRpOcvB09PjIwTcQBOAPcubWL5nz8KUL7o+ZDTGH3CBpIARG3YKx56HXrjlscp54
 4npcVU39QSpotCQgkCnyb0zoFh2/DjzcGbsywajEgw4sLcLSRKJ6Po1Sv2It7GPhbOh5Wu3igG9
 ql9cvY+E64Fa7BZZkBwIx9sOZKKtY9iAdAmwP0lgFnDsW48KhL47O66lWUb3PxdFdznpmWzkPHO
 8q2qaXfsdhl+l/84jpBAnud83DKBU99fPV6phm4JejlnU1rr+ooBEufjyEraCI5L0h4nSd5XuhD
 4P8UXBQuNq96ck/e7J2lTmIEPZtJTRh9pmT7+U2v9LazrizxSmTYhpTVfo8XzVTFJ6ELq7hprEW
 MR4MT2i4/Umnc31VQ0/ssIWf77zwveBgkyUKASJbWpniuhXckXkGlgxgvO7MAKbv9ToCgAEkA=
X-Received: by 2002:a05:600c:1d03:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-482db4567d6mr231897235e9.1.1770131133034; 
 Tue, 03 Feb 2026 07:05:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305133689sm67848505e9.12.2026.02.03.07.05.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:05:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/30] target/ppc: Inline need_byteswap() and replace
 translator_ldl_swap()
Date: Tue,  3 Feb 2026 16:04:13 +0100
Message-ID: <20260203150436.71907-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
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

Rather than using a boolean with translator_ldl_swap(),
get the MemOp endianness with ppc_code_endian() and pass
it to translator_ldl_end().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260202210106.93257-8-philmd@linaro.org>
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


