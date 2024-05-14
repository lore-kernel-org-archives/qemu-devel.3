Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E4DC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lbi-00041u-JW; Tue, 14 May 2024 02:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lbh-00041P-6x
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:25:49 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lbf-0004A2-Nl
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:25:48 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4df400d6875so1643980e0c.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715667946; x=1716272746; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHDJU90K0i4Tl1e7IlO2ZB68rK6VHlBxiwbV9OkdmOE=;
 b=Kv1NmXd3Fwr/MBkDYWUBMNKLUIfVytrGKkuj+vSwmBjxYYeS6zHwWSxfBjjJmB25l9
 fcyZ4xsuiYychywxt8tfSJeqSksiVOFKJ1J7r1fBdwu94RxTgPies3/DCiEB8rFkfxBG
 /JUbhVySjRqVOzyFtd1GSol5GPt5OX7EUgCoYCsTqblgIQ+Ty6LpwbN9+HAL+KDEngxM
 ACD1/Ewmm7Tm7SPb+Oshho8mwdFY2p+7Mfvb8fKdADBOi7h0sjC9UY7rHQSiR8+KWeao
 w2t1T0xK3Q/k18JTvnY8HGNdTrYDJ2psrODHTTmW1CI2anCEJxxKXzLGbZ7KUs/jmJcj
 2jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715667946; x=1716272746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHDJU90K0i4Tl1e7IlO2ZB68rK6VHlBxiwbV9OkdmOE=;
 b=V9h4OM9AOIZaiFsxqPrzS7XPhHMkbXsRfMcDv5WOyXSR3qvmy8FnTn5OEe+C/ZnkYh
 h3fIdEpwgwNKCEpmwUV3UdXVUHO33gigU61yGRWZBZkZVSIpYl2/st65MdsUVf32+tFf
 YgbM17XuPCcxEVbgI8VPtw9OTNh2Iw5H0rNN+StstFlcPZo+DOtUIOrS3CRLMajEHy+q
 tCYG1sUhdpFA9gojKT8DMA1c5F13xLuPArCNZnKg6lNmfg+mEo0irURmh6NLUHjiSMmX
 Uv/2GbZVzjAfY5FNQuCXJsMWYl5zfmn1KB86LSu0dzDMBl/4G4PyciUURRfktOUQLhyy
 LkAw==
X-Gm-Message-State: AOJu0Yyvij+7VmHHyZFRk08vM1WJjNwDgkLeSXBEkJmpdXxB+GiYr3F3
 lc3f01VpJFiZX6yVB9K5w65uPaPN1aaTM5ne4XipUmjILShLPOe0I9hwiDPhVTDw53reQZD3a4z
 /9ECdLu+aOGE74yz6Pgso4XKgc/pzRmEFEl4=
X-Google-Smtp-Source: AGHT+IG8fcXvnffvfx8jV4cRzA5WKM96spa2f/sZEj/8NrnjzAeboYX4uhT0yT2kbZnrB388yEU7vs7IRKuy40RCJs8=
X-Received: by 2002:a05:6122:d95:b0:4dc:d7aa:ccf9 with SMTP id
 71dfb90a1353d-4df8834b383mr8664304e0c.12.1715667945118; Mon, 13 May 2024
 23:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-30-richard.henderson@linaro.org>
In-Reply-To: <20240424233131.988727-30-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 16:25:19 +1000
Message-ID: <CAKmqyKMjj-r5j-_vj-+APZCF1eNbOG6UK0VuiM3dtYVPtT75BA@mail.gmail.com>
Subject: Re: [PATCH v2 29/33] target/riscv: Use translator_ld* for everything
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 25, 2024 at 9:36=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index c999e942e1..2c27fd4ce1 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -20,7 +20,6 @@
>  #include "qemu/log.h"
>  #include "cpu.h"
>  #include "tcg/tcg-op.h"
> -#include "exec/cpu_ldst.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
>  #include "exec/helper-gen.h"
> @@ -1082,7 +1081,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>      CPUState *cpu =3D ctx->cs;
>      CPURISCVState *env =3D cpu_env(cpu);
>
> -    return cpu_ldl_code(env, pc);
> +    return translator_ldl(env, &ctx->base, pc);
>  }
>
>  /* Include insn module translation function */
> @@ -1243,7 +1242,8 @@ static void riscv_tr_translate_insn(DisasContextBas=
e *dcbase, CPUState *cpu)
>              unsigned page_ofs =3D ctx->base.pc_next & ~TARGET_PAGE_MASK;
>
>              if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
> -                uint16_t next_insn =3D cpu_lduw_code(env, ctx->base.pc_n=
ext);
> +                uint16_t next_insn =3D
> +                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
>                  int len =3D insn_len(next_insn);
>
>                  if (!is_same_page(&ctx->base, ctx->base.pc_next + len - =
1)) {
> --
> 2.34.1
>
>

