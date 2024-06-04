Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C6AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKeK-0000dC-Gw; Mon, 03 Jun 2024 23:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKeH-0000cC-Nl; Mon, 03 Jun 2024 23:15:45 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKeG-0007dB-4d; Mon, 03 Jun 2024 23:15:45 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4e8a6159479so1960638e0c.3; 
 Mon, 03 Jun 2024 20:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717470942; x=1718075742; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oa42MayHyGq46VBIQiJ1rcFmB0Wx74uG1AqTT7LifkA=;
 b=lzEjbBWF35AniCe6+m/V+q6apnuRn1uTQ3HSOI2qdRiGIF4ftKJ54yQRBp/krGOJyF
 H1AEmkK21yos14tf7oovJF7517Qt4C4IW4Wi/wjYg20E4MtVFs19/A3dhKmCmA2lJf7b
 ZBND8i40ZnwamrF+aTDEudMJr8dq63BtqvyZ+Kbb6FppiK1n3D6XyH/xMamINB3VsiKf
 rK6NR3KFuhuoXpAn4IGrZU2E+hBtHt6sSHTHlWZz3urPM4o2vPuZBx1g5cmP5zubabOm
 yKiRcLU/dMNE2sNFo6f2pxz7c+Rrq7v5M+cOi97Ids4oLOhS65G9d2CmzfCTOK+je4We
 WYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717470942; x=1718075742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oa42MayHyGq46VBIQiJ1rcFmB0Wx74uG1AqTT7LifkA=;
 b=rynY0F6KY00BbQu3fECV5cV52bxAmfYhDxVP346LFIdD2Bo9fQ5P5Zj1G0YAE+I+bw
 ZC0eyaKdzrX3af/agWOCyOpB5WjweZCWbhKTmiw1ecqD9VJFM3KPGH1u5UIM70Fe7IsC
 yimv0zdahrS2BItSSrZ7OTNYpONW/9zj6HjWKo9bPq1kU7NkH6jirwYGOKfWhgCFU9zm
 Fx1m2YhUWssG8wzKGF70Z4WPD65pEmC0CDBDCz6qjFxI+G6A9vaXrqixXjVqmMWP8AFJ
 NVFfA6C5KOJ6w7rKBnJIsHCSeWa8YQytlmUotBKQwEMmaPEO3mwf8Kp4iUUl0GrLNi9g
 EOpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK5S+afhuGLaezuLm5yeeDH/soH6Zalwu48HOxp3aCNuWkqnZzWd0fokaoQVEY2dbH0rpaR2UpLBngQQtLkMppJn/9aZk=
X-Gm-Message-State: AOJu0YymvIgc304wBDOnszR8lacRfVMjEBNG+Nx/cwCzJ5n4Q1MIM10y
 YjD1TARL7G4lrQgyXEJOfLCAapvFnq5nRi/Ka4JLdjjH6WJodNiTlacMG4M8xQ/JqL9Y/uIoq0e
 tEiDHn37AFl3g8QIYOIs1ChoQB/2jFCYh
X-Google-Smtp-Source: AGHT+IGLP8nQhj5a9SwKCGnJoc4gKK66dWvSnZMWkOwFKHqPKRZ19ruFsJc4BAmYD4yIi+JSeUaPbYxWvMPnSybe6Js=
X-Received: by 2002:a1f:e483:0:b0:4df:235b:8ba1 with SMTP id
 71dfb90a1353d-4eb02da89aemr10351036e0c.7.1717470942401; Mon, 03 Jun 2024
 20:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
 <20240523124045.1964-4-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240523124045.1964-4-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:15:16 +1000
Message-ID: <CAKmqyKPGfCY-ZN+R2hv7Eei=vcTYvdCATQV_=7q2zWpCBgYEpw@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/riscv: Move gen_cmpxchg before adding
 amocas.[b|h]
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 23, 2024 at 10:44=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvzacas.c.inc | 13 -------------
>  target/riscv/translate.c                    | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/i=
nsn_trans/trans_rvzacas.c.inc
> index 5d274d4c08..fcced99fc7 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -22,19 +22,6 @@
>      }                                     \
>  } while (0)
>
> -static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
> -{
> -    TCGv dest =3D get_gpr(ctx, a->rd, EXT_NONE);
> -    TCGv src1 =3D get_address(ctx, a->rs1, 0);
> -    TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> -
> -    decode_save_opc(ctx);
> -    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop)=
;
> -
> -    gen_set_gpr(ctx, a->rd, dest);
> -    return true;
> -}
> -
>  static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
>  {
>      REQUIRE_ZACAS(ctx);
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f597542f1c..0ce188bc91 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1097,6 +1097,19 @@ static bool gen_amo(DisasContext *ctx, arg_atomic =
*a,
>      return true;
>  }
>
> +static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
> +{
> +    TCGv dest =3D get_gpr(ctx, a->rd, EXT_NONE);
> +    TCGv src1 =3D get_address(ctx, a->rs1, 0);
> +    TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +
> +    decode_save_opc(ctx);
> +    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop)=
;
> +
> +    gen_set_gpr(ctx, a->rd, dest);
> +    return true;
> +}
> +
>  static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> --
> 2.25.1
>
>

