Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C854104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5nf-0006Q6-S1; Fri, 27 Feb 2026 16:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5ne-0006NI-Cj
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:55:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5nc-0003sY-Iv
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:55:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4833115090dso25135425e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772229302; x=1772834102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OwBHQwHNVJrEfB9pdfIPzyKBKlnjElNvqnLI7dwsX28=;
 b=g3VqVCq7QIrPfnApnUbvO/UlykkRx7sgSyzGbZit5tk14EzBD1ved23RnX6TueVijJ
 icL38rDzCNjCLb45ti7KJ3VqGrtDQkNjVpDF6FL8jdQN3d+3IqiSuWrjpxDuXtLwNwr8
 NiZB29p5RN453wYeQLttfuHuX6m+KhEuTIOMzftY8cHBCNivXRx8pCjeS7j4QPo+uj1c
 Iva0CVJa577ibHIim0A1ak7IG1GaEtYrC660quXXTOB9iVjKoBHFiPe7+AZzvWUxDJr/
 NLJ5+7ejquhqLm5F0pDG2gGkwCGU5vE/VOuacAMS+mlVeOE15vaoqK/iWQoSUVs5PBBk
 GS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772229302; x=1772834102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwBHQwHNVJrEfB9pdfIPzyKBKlnjElNvqnLI7dwsX28=;
 b=FcEZnVZ26Q9uUYHG+SaU75+Ps2CQtxLQu7Hl+bT1i7EJYAVOxm7gXaJXVnmU+BdV+F
 TWJuAaoNj3mpvxCUjbIaU5TKXxBvJXDpufTE7JvvM0Qx3BTjLbcRmRncwMbZyBHayRVy
 7sdAKXDdlG0o1no+rNiwOVgumsf0mMdUQpqJ4lFhCEjjcLRn4F+3dqN8GQbJVkE072Ko
 LRVhV4q+cwlWOoQLWefM4NbUGc3GRuxiPPFqfW0DrNE+mnLQHdZnIN/Z0LV0muFLhhhw
 H0yk6dB0kgoBDlli2nkIPdIRQj19zFmrLNxOVhMwrMpSjpM11iGb3wPpXR3vnf+BunAx
 yldw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyhBROM6pGK671dp8xWqSxfWiyFg1K04QHOkbwVuFSxYnY3dV1uMbtcEI2At8co7k5Phiwv7w6m0ic@nongnu.org
X-Gm-Message-State: AOJu0YzERcjkb9gyBPqGBTL2gxz7q6QMoEyOxnH3C7W6oBLeHJ5ubsHT
 LHsp8X7Bmb9quZa8xBo8HhQ7EKPYIDZDbHbh+d5ZpP1zanY/tU0dAt2l5lPk6JEaCnc=
X-Gm-Gg: ATEYQzxratYs3d8yG/Cl7urN2nYesxXESfod1PRpxJz3UrHtMfkW4Jb0UPLdTJtMdWF
 HidQIk0gJqqWXLfCyPxg4/X1NeQEDBeT0AJHYrLG/vGvhhA338KE/qkf2cpQkqYYTVE0iuGrJvp
 C193nb1lr9NCf+oZCxEFtaD+Bwd9VqV3lUfaOYHxWHT2wl/axeX+1Fwkz6VPDlXHVM7aF5A6OlI
 mZhgC540eSCVyRCnfwdfaHvjg+ld8OYSQKit2wGgfRFqm7H1Iiuw66R+pk00pxw2UFX29nlVzav
 AeipMl8YgpJ3CCUTz2HA50OCLok4s9RuDNocZmEM+2Z771zp9hFghCY2mL1Q/QY17GE2MJjdXrE
 S23Irqli5HdV6SMVC9nBDd2b64Cb2gNxkcnnskB/hIJo0Gcn9kuPvfzzOQA7n9XBqk8tze+NBq4
 Fz2JPeeexxOqbajTr+m/eW0g37dP4ww+qb1E0+F3TnTLHwILFzZmkrdOkTZAHFY+451qxPiPcN0
 B20
X-Received: by 2002:a05:600c:3512:b0:480:7162:fa48 with SMTP id
 5b1f17b1804b1-483c9bb1fcfmr75841225e9.13.1772229302116; 
 Fri, 27 Feb 2026 13:55:02 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb6d16sm100080905e9.5.2026.02.27.13.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:55:01 -0800 (PST)
Message-ID: <3ffa447b-b625-42eb-b535-0f61a73c0acf@linaro.org>
Date: Fri, 27 Feb 2026 22:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/37] target/hexagon: Make gen_exception_end_tb
 non-static
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-7-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Brian,

On 27/2/26 21:35, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/translate.h | 2 ++
>   target/hexagon/translate.c | 6 +++---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index b37cb492381..2804e08ce57 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -282,6 +282,8 @@ extern TCGv hex_vstore_addr[VSTORES_MAX];
>   extern TCGv hex_vstore_size[VSTORES_MAX];
>   extern TCGv hex_vstore_pending[VSTORES_MAX];
>   
> +void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
> +
>   void process_store(DisasContext *ctx, int slot_num);
>   
>   FIELD(PROBE_PKT_SCALAR_STORE_S0, MMU_IDX,       0, 2)
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 8a223f6e13e..877cb38ae77 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -189,7 +189,7 @@ static void gen_end_tb(DisasContext *ctx)
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
>   
> -static void gen_exception_end_tb(DisasContext *ctx, int excp)
> +void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
>   {
>       gen_exec_counters(ctx);
>       tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC);
> @@ -207,7 +207,7 @@ static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int excp)
>   
>       gen_exec_counters(ctx);
>       tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], fail_pc);
> -    gen_exception_raw(excp);
> +    gen_exception(excp, fail_pc);

gen_exception() is not introduced in this series, future
commit https://github.com/quic/qemu/commit/ff8ac066dd8d
rename gen_exception_raw() to it. I don't expect this
commit to build.

Maybe keep the gen_exception_raw(excp) call in this
commit and convert to gen_exception(excp, fail_pc)
in ff8ac066dd8d?

>       ctx->base.is_jmp = DISAS_NORETURN;
>       ctx->base.pc_next = fail_pc;
>   }
> @@ -590,7 +590,7 @@ static void gen_insn(DisasContext *ctx)
>           ctx->insn->generate(ctx);
>           mark_store_width(ctx);
>       } else {
> -        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_OPCODE);
> +        hex_gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_OPCODE);
>       }
>   }
>   


