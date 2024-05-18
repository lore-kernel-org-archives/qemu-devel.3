Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0117C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Gos-00068s-JP; Sat, 18 May 2024 05:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s8Gom-00065Z-PY; Sat, 18 May 2024 05:57:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s8Goh-0001jT-FD; Sat, 18 May 2024 05:57:30 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 036484E602D;
 Sat, 18 May 2024 11:57:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id NtMFjYvPABOw; Sat, 18 May 2024 11:57:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CAE554E601D; Sat, 18 May 2024 11:57:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C923D746E3B;
 Sat, 18 May 2024 11:57:20 +0200 (CEST)
Date: Sat, 18 May 2024 11:57:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: Re: [PATCH 02/14] target/ppc: Remove redundant MEMOP_GET_SIZE
 macro
In-Reply-To: <20240518093157.407144-3-npiggin@gmail.com>
Message-ID: <321e6c3c-8533-a0b7-9eb9-45409c607340@eik.bme.hu>
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 18 May 2024, Nicholas Piggin wrote:
> There is a memop_size() function for this.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> target/ppc/translate.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0882fe2fd2..cf2404330b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2904,8 +2904,6 @@ static void gen_isync(DisasContext *ctx)
>     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
> }
>
> -#define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))
> -
> static void gen_load_locked(DisasContext *ctx, MemOp memop)
> {
>     TCGv gpr = cpu_gpr[rD(ctx->opcode)];
> @@ -2938,7 +2936,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
>     TCGv u = tcg_temp_new();
>
>     tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
> -    tcg_gen_addi_tl(t2, EA, MEMOP_GET_SIZE(memop));
> +    tcg_gen_addi_tl(t2, EA, memop_size(memop));
>     tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
>     tcg_gen_addi_tl(u, t, addend);
>
> @@ -2948,7 +2946,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
>     tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
>
>     /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
> -    tcg_gen_movi_tl(u, 1 << (MEMOP_GET_SIZE(memop) * 8 - 1));
> +    tcg_gen_movi_tl(u, 1 << (memop_size(memop) * 8 - 1));
>     tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t, u);
> }
>
> @@ -3110,7 +3108,7 @@ static void gen_st_atomic(DisasContext *ctx, MemOp memop)
>             TCGv ea_plus_s = tcg_temp_new();
>
>             tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
> -            tcg_gen_addi_tl(ea_plus_s, EA, MEMOP_GET_SIZE(memop));
> +            tcg_gen_addi_tl(ea_plus_s, EA, memop_size(memop));
>             tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
>             tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
>             tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
>

