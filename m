Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED44C103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Wn-0007nz-NK; Fri, 27 Feb 2026 17:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6Wm-0007la-Kl
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:41:44 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6Wl-00037Y-1E
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:41:44 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4398f8403edso1977855f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772232101; x=1772836901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQ88jLxHMH0BcOoSDAI/nDiZx5RzOvlSGPqAZG+5zWk=;
 b=FgQ/GfkVyhmkq71Ou13QwFTWW8NvfidNLIymPiw+s9zVfeAgQ5KHgsAynj6LhBi+t+
 QecGs0tF1PIfZY4e8Ef2etfrCIE7UGinwLAptsu+ETLnyR6hLq29EhXJA/dTT7fZEAuM
 g6KARqNBDoZqxKECFt6XyQnymSJfyPn488w8N0P6rDv7c46NxQ11f/lobAdTlzQT6BeW
 +ykg7AhuJ/6d7rY7QF344LZ7GBdJytbjnegyDFBuw6bpwgvZu2BrF4i8moT8RBNdjN1v
 ElIVZONGodArAtKJNxlY1wNrZM7P/lmBUA3CaFYaLDyO3lMVKWYLNiiZooikgVjgNm0z
 00Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232101; x=1772836901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQ88jLxHMH0BcOoSDAI/nDiZx5RzOvlSGPqAZG+5zWk=;
 b=OJRqYVCG5n5Dy4pofmw6DA/byPmejsCLzbarzkMvO61g6+jA3+HZcxsCZrlrviAe+3
 Xc8tafkL1a2fB92BkLDfEugyZdpdUDqcvDf5JDha/c8Wsd5FyIJfxNBrfKHoAfwAPTta
 yse+RYBBwQxaW88teoL8kfhVW6Al+1V/BfFkuhagjpSFMLJrbh4Ii1h5LR5JgrJ3eTpW
 EwGKJEREQocV3K31ww2IyaSiR7CvakOtc9UnpNEW7ki8UhMF87Jutu+P/Ix+t7r2rZvV
 mhPAoHQ3tc1R34JrBcb+S90FwtTt9dxpy1dZJmDh0xJ7k3JHudgO58pi1ousuagQozP5
 rr9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0MNajUg9/TYbGw9dnwJLt2LXdXYSqBOZ+RG6iPwAoKkQOtPg9rm8rJ9xlMOcrO3ukYkelAo8us/vh@nongnu.org
X-Gm-Message-State: AOJu0YzylVTpnB1WlZuNg/HzxwkltoTMKYMXRl859joatmnekKIrpRCQ
 KUWn0XGxGVpuqWDuDtEHFkjGSDEhN1ajjxk0t1PmZ2GfjFsAqNnR6bmYBdBjtv8ODGM=
X-Gm-Gg: ATEYQzxzfX/MUpxu/X+oCXUxwnOKtZWs1UGIIDa/38s2kxiheXel2IQxBFJSOZUp/AD
 VoSPUd1RXp3okSkAADvWYEeOe1qZQ9ylwl4EXNqvl9bssBqwiZ99DrWVFANOxgTzqbpRjw8avSb
 f6FXVchBOZaNB9uVfpBuMsHaxOoqFc8ZA2h8C+yatNaAWUTFAsDNrI0sbPpn+8Am7lqecVWhCe4
 8SmdDAlyMswF8+OrI6jh7JMI9EcLwUa6B9fbPhKCxfIstvRjGRTi1SAkArfq6BOPBGYSoW3WrMa
 K4px6iCMc0+By+drUpv1QvL9FVEmyd7dEhUTKpnOli+iaJ1CdDvZOb2OmgssLppSws/8x5MswVV
 4Bm1vxHYkohLkTJnwqiVneoIlEBPQctJKVFY6OWH9mGCeR6DAwflT3x9QI+7lOmV9ItU9Z3WZiu
 wEQyyx93mq/rbAmbHsGnPniLxE97IEMqRcbl6oSi+hMfOT4/bJwP8xIKXBvv3COA6Luw==
X-Received: by 2002:a05:600c:34d0:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-483c9bdb2d2mr84951095e9.31.1772232101435; 
 Fri, 27 Feb 2026 14:41:41 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750701sm256758945e9.11.2026.02.27.14.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:41:40 -0800 (PST)
Message-ID: <203f4d67-da40-41c9-881e-19359fc39faa@linaro.org>
Date: Fri, 27 Feb 2026 23:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] target/riscv: Ensure LE instruction fetching
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-5-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225102016.200654-5-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 25/2/26 11:20, Djordje Todorovic wrote:
> With the insroduction of BE RISCV target, instruction fetching
> needs to always expect instructions to be LE encoded as specified
> by the RISCV specification.
> ---
>   target/riscv/translate.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f687c75fe4..67dfb5f1c0 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -23,6 +23,8 @@
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
>   #include "exec/target_page.h"
> +#include "exec/tswap.h"
> +
>   #include "exec/translator.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "exec/translation-block.h"
> @@ -302,7 +304,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
>                           target_long diff)
>   {
>       target_ulong dest = ctx->base.pc_next + diff;
> -
> +
>        /*
>         * Under itrigger, instruction executes one by one like singlestep,
>         * direct block chain benefits will be small.
> @@ -617,7 +619,7 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
>   static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
>   {
>       TCGv succ_pc = dest_gpr(ctx, rd);
> -
> +
>       /* check misaligned: */
>       if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
>                                       ctx->priv_ver,
> @@ -1253,13 +1255,13 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
>            * real one is 2 or 4 bytes. Instruction preload wouldn't trigger
>            * additional page fault.
>            */
> -        opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
> +        opcode = tswap32(translator_ldl(env, &ctx->base, ctx->base.pc_next));
>       } else {
>           /*
>            * For unaligned pc, instruction preload may trigger additional
>            * page fault so we only load 2 bytes here.
>            */
> -        opcode = (uint32_t) translator_lduw(env, &ctx->base, ctx->base.pc_next);
> +        opcode = (uint32_t) tswap16(translator_lduw(env, &ctx->base, ctx->base.pc_next));
>       }
>       ctx->ol = ctx->xl;
>   
> @@ -1278,9 +1280,9 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
>       } else {
>           if (!pc_is_4byte_align) {
>               /* Load last 2 bytes of instruction here */
> -            opcode = deposit32(opcode, 16, 16,
> -                               translator_lduw(env, &ctx->base,
> -                                               ctx->base.pc_next + 2));
> +            uint16_t opcode_hi = translator_lduw(env, &ctx->base,
> +                                                 ctx->base.pc_next + 2);
> +            opcode = deposit32(opcode, 16, 16, tswap16(opcode_hi));
>           }
>           ctx->opcode = opcode;
>   
> @@ -1396,6 +1398,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>               if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
>                   uint16_t next_insn =
>                       translator_lduw(env, &ctx->base, ctx->base.pc_next);
> +                next_insn = tswap16(next_insn);
>                   int len = insn_len(next_insn);
>   
>                   if (!translator_is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {

Per commit a31f16bdd4a ("target/riscv: Inline translator_ld[uw,l,q]
calls") you shouldn't need that.

This series base branch is outdated.

