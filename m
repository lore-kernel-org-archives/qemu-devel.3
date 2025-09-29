Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0773CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 00:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v326y-0000xB-Ee; Sun, 28 Sep 2025 20:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v326r-0000v3-HH
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:51:22 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v326g-00049L-5v
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:51:21 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b30ead58e0cso754315266b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759107065; x=1759711865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqHSZsWWVFavEKjeTZX/1sR76kXRoNP9dSpFOjh1RSA=;
 b=FR++F+UTnTrJ467+Yi1CEH7iYT0JcIidN/a/RYu042vji+WnOr66HYlIV2UsxVjoan
 +u5MXMofXeKBXkNuyX+CWHPkYq8XSLerhzKGDIf9ehXA1KGB0SGPddJQNU/T97xLvlqm
 XKgAug0AZ1/x8rIx55dSNY/d5HIiWZ2caeemUlslDGMjc8yN2gp59owq298RC4jIgFNY
 HJ+rSO9DkjyDf7gehcxrgz+9dWs+OfWS9IKQW9ptkJqTZJMRACeH9s3OpnZFwkDSX1Dr
 djWZgkKZHS9hqosm96TfocgC84Ntl2sj7D3jgVhS2kD2C24gS+5Jcg/sNzf8Tf/VCKZN
 s3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759107065; x=1759711865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqHSZsWWVFavEKjeTZX/1sR76kXRoNP9dSpFOjh1RSA=;
 b=U2ClfklzdXEn1jgJ8G1RDjPkYiq4kh0fNwpStgOEG7nvHVQozeOdmgianLpbrJgMe8
 tG4/bGfrOZjEUlCgSb69EcyVM5j75bLHBNZE8JtPs5+5OTRqdtOWtRNCm344ljeaRILf
 OgG4IdX43WbOdaFoJdjaBIQe4DCLOurQ/Bg3vjvee2JhspGn4EkfgdQK8SjX+vCAdzCB
 /42+BZFMirjLVy8v33PQoR7Op68PglvkHZIVuuJ4oDqOo8t9EMOrxXetIO4zJQTIDZFt
 D6cLfC7/i/P76y0+M8z/qckzRTwhJ43GweE93jC9G3eRVx3od82/nkGnAIVZ/sW2Jne8
 AEcw==
X-Gm-Message-State: AOJu0YyQkg+n81693568ZUsYidNgE0iMKonD+w+d9N1J+tu22oek5ivj
 RfEcaU23cn61yrEt1yesnyUDMsvOBuIM9TP4sp99VNAKFGdqVgI2BZAPfl3E4NSxPH3/MxQ5zaS
 BWZZcr5jQ19HV6YO/yV5SMZ3CFthUMgY=
X-Gm-Gg: ASbGncu3JY2E2wG7Ehl0EPJoyOIjOkjLp4IvgoAepywhYTgwIxNFyjaP3jzgL77k0tw
 sq9lCZvtRO5671KZXjvDn0H5G13rhaLHMGrHyPOUMB3Ll+/qnMTn5I/W3M0RCcq0P84SjbgjLGV
 xnvUvVO5uqPSgUxV4ny2F2yVee5e9RHCFStSC73ufk/eXhKxeEG63WCNKT5p/pH0i0aglhb+OWU
 FPFsOPt3QyPORT+E/mRHVaMX2zbW4PTI53WGW8A1EjeNwNV
X-Google-Smtp-Source: AGHT+IGkAucT3rgQKf+KFwG6ma6TjDUXa1Kd95n0wLbdvPHwKL4kGhdMcaIncsmzuE0ujYSa/ne+qRwQHQEJhbv9Yew=
X-Received: by 2002:a17:907:971b:b0:b3c:31c2:b57d with SMTP id
 a640c23a62f3a-b3c31c2be2bmr526634166b.55.1759107065148; Sun, 28 Sep 2025
 17:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250924074818.230010-1-jim.shu@sifive.com>
 <20250924074818.230010-4-jim.shu@sifive.com>
In-Reply-To: <20250924074818.230010-4-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 10:50:38 +1000
X-Gm-Features: AS18NWDXh-zggmejBt2yP7NGvTGg3uCdnwbQrYMUNQp208JJy1wGOaHuUR80i2Y
Message-ID: <CAKmqyKPCRrk61rz5hqCcbk44=K6OLzn=eVgWpTVLHY6JzjqyyA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] target/riscv: Fix ssamoswap error handling
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Wed, Sep 24, 2025 at 5:50=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> Follow the RISC-V CFI v1.0 spec [1] to fix the exception type
> when ssamoswap is disabled by xSSE.
>
> [1] RISC-V CFI spec v1.0, ch2.7 Atomic Swap from a Shadow Stack Location
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                         |  5 ++
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  8 +++
>  target/riscv/op_helper.c                      | 49 +++++++++++++++++++
>  3 files changed, 62 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index f712b1c368..c82bacdc39 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1284,3 +1284,8 @@ DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
>  DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
>  DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
>  DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
> +
> +/* CFI (zicfiss) helpers */
> +#ifndef CONFIG_USER_ONLY
> +DEF_HELPER_1(ssamoswap_disabled, void, env)
> +#endif
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index 45686af4d6..f4a1c12ca0 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -91,7 +91,11 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_a=
moswap_w *a)
>      }
>
>      if (!ctx->bcfi_enabled) {
> +#ifndef CONFIG_USER_ONLY
> +        gen_helper_ssamoswap_disabled(tcg_env);
> +#else
>          return false;
> +#endif
>      }
>
>      TCGv dest =3D dest_gpr(ctx, a->rd);
> @@ -116,7 +120,11 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg=
_amoswap_w *a)
>      }
>
>      if (!ctx->bcfi_enabled) {
> +#ifndef CONFIG_USER_ONLY
> +        gen_helper_ssamoswap_disabled(tcg_env);
> +#else
>          return false;
> +#endif
>      }
>
>      TCGv dest =3D dest_gpr(ctx, a->rd);
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 110292e84d..8382aa94cb 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -717,4 +717,53 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, =
target_ulong addr)
>      return cpu_ldl_code_mmu(env, addr, oi, ra);
>  }
>
> +void helper_ssamoswap_disabled(CPURISCVState *env)
> +{
> +    int exception =3D RISCV_EXCP_ILLEGAL_INST;
> +
> +    /*
> +     * Here we follow the RISC-V CFI spec [1] to implement the exception=
 type
> +     * of ssamoswap* instruction.
> +     *
> +     * [1] RISC-V CFI spec v1.0, ch2.7 Atomic Swap from a Shadow Stack L=
ocation
> +     *
> +     * Note: We have already checked some conditions in trans_* function=
s:
> +     *   1. The effective priv mode is not M-mode.
> +     *   2. The xSSE specific to the effictive priv mode is disabled.
> +     */
> +    if (!get_field(env->menvcfg, MENVCFG_SSE)) {
> +        /*
> +         * Disabled M-mode SSE always trigger illegal instruction when
> +         * current priv mode is not M-mode.
> +         */
> +        exception =3D RISCV_EXCP_ILLEGAL_INST;
> +        goto done;
> +    }
> +
> +    if (!riscv_has_ext(env, RVS)) {
> +        /* S-mode is not implemented */
> +        exception =3D RISCV_EXCP_ILLEGAL_INST;
> +        goto done;
> +    } else if (env->virt_enabled) {
> +        /*
> +         * VU/VS-mode with disabled xSSE will trigger the virtual instru=
ction
> +         * exception.
> +         */
> +        exception =3D RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +        goto done;
> +    } else {
> +        /*
> +         * U-mode with disabled S-mode SSE will trigger the illegal inst=
ruction
> +         * exception.
> +         *
> +         * Note: S-mode is already handled in the disabled M-mode SSE ca=
se.
> +         */
> +        exception =3D RISCV_EXCP_ILLEGAL_INST;
> +        goto done;
> +    }
> +
> +done:
> +    riscv_raise_exception(env, exception, GETPC());
> +}
> +
>  #endif /* !CONFIG_USER_ONLY */
> --
> 2.43.0
>
>

