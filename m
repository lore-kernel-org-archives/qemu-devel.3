Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497CAC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raUaR-0002Bj-7g; Thu, 15 Feb 2024 00:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raUaQ-0002BN-5M; Thu, 15 Feb 2024 00:47:06 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raUaO-0004a0-Ae; Thu, 15 Feb 2024 00:47:05 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7d2e1a0337bso205628241.3; 
 Wed, 14 Feb 2024 21:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707976023; x=1708580823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzokL+3yMSZ2WVDiG/PXcnmbwGDN+NMoaiKq7zHSffw=;
 b=N/cBeX98cKHb6F57v0yDfqn/nx4X26u1pIBCNCh5GOMmxR4MulDo4UF73r9YzPAaVw
 xHL4NBR2JkW+FgBjf9wDRJ6ql53HxlDUWdKdUIP6qUjYNNKPpC6K8dqPrwJRGBmEUMfM
 8CyFNieFSxvixgxnos0VdyCoc9z7vmWR6tV6u4F+FcMYHIyyajWnTgTDM25GZtfE1JYL
 /OYmC1ni06h+Gwyut8MeUXgdcyi7N0T1MojpCWrZSKXtqsr+8uA8snPYFa7M6NZSDJjP
 OAEtT8VuocIMIw4426Wce6NVmv7PH2X7WcTVyy6gQQa0t22aleCojP659T5QpOfOviP0
 QQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707976023; x=1708580823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzokL+3yMSZ2WVDiG/PXcnmbwGDN+NMoaiKq7zHSffw=;
 b=IhsvFLdz6Y/hltg8+2av/GuVW/rv1rEXBXioDw/lbq3HR/lA+7kEONEI6rMCeP2+IZ
 lmoz/GON61UjK4v3+1LyjxzHK2y8c5G7SLuE4H8o5mcTtEF6+vzVDVbh547RvIXsPDxM
 e87Vyngo55tInkQ+tM11PvcAthY9/bRlAg2qJMLjwq2PflRlk3LZmPga+Soi7sPdvXie
 zYYPw36FZb57ukwYxXyXPZqqzPq9g9BUcv+d5nqMM1lSiBHKS2VLqcyoR5xvZLQmBnvv
 Pbt9aeO0Z1hqa2P1TQORLcjvDU0YZDoVbA2kMJG2frUgr7HWe2l2GUhp0eBpqrLvFm5b
 ErdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4GEHAuJe4+d8XTeHt7HqN7kgsc/hnl9GAsc8HYyO9FoS2N2tsVKMk+9W8NKFd2UEas/aQUbeFuYCtsbX4dMoOZGKD6bw=
X-Gm-Message-State: AOJu0YyLsGkwr5yBoxDGUBC3XbK4nUWRsIe1hyKrMTW11PAeWUwBxdl+
 wZzbkjU3R709R/XyVAqEx5Xy6E3kh+BcEMKkrei7QxEC+AbPGiuge/5A2+zWPOexUYknBYHR7my
 WuNc0Lg1azUe9pSF/FSrQ3KY/po8tTX2v
X-Google-Smtp-Source: AGHT+IEBAyM99SVkJWyz9AV2NT/NNkLd3ghRqev5LHNfjTdvxxrcD2QYzL1E4+NTwAqXiyEVOBn42zIcv+KsqzmZqf4=
X-Received: by 2002:a1f:df83:0:b0:4bb:36bf:78f5 with SMTP id
 w125-20020a1fdf83000000b004bb36bf78f5mr509017vkg.16.1707976022811; Wed, 14
 Feb 2024 21:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240202152154.773253-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:46:36 +1000
Message-ID: <CAKmqyKM9HBVy38Faed59X+WCZLMJ-Td8S1At6eUbU3_iZ2P-LA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] target/riscv: Gate hardware A/D PTE bit updating
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Sat, Feb 3, 2024 at 1:22=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Andrew Jones <ajones@ventanamicro.com>
>
> Gate hardware A/D PTE bit updating on {m,h}envcfg.ADUE and only
> enable menvcfg.ADUE on reset if svade has not been selected. Now
> that we also consider svade, we have four possible configurations:
>
>  1) !svade && !svadu
>     use hardware updating and there's no way to disable it
>     (the default, which maintains past behavior. Maintaining
>      the default, even with !svadu is a change that fixes [1])
>
>  2) !svade && svadu
>     use hardware updating, but also provide {m,h}envcfg.ADUE,
>     allowing software to switch to exception mode
>     (being able to switch is a change which fixes [1])
>
>  3) svade && !svadu
>     use exception mode and there's no way to switch to hardware
>     updating
>     (this behavior change fixes [2])
>
>  4) svade && svadu
>     use exception mode, but also provide {m,h}envcfg.ADUE,
>     allowing software to switch to hardware updating
>     (this behavior change fixes [2])
>
> Fixes: 0af3f115e68e ("target/riscv: Add *envcfg.HADE related check in add=
ress translation") [1]
> Fixes: 48531f5adb2a ("target/riscv: implement svade") [2]
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         |  3 ++-
>  target/riscv/cpu_helper.c  | 19 +++++++++++++++----
>  target/riscv/tcg/tcg-cpu.c | 15 +++++----------
>  3 files changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9045f87481..50ac7845a8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -960,7 +960,8 @@ static void riscv_cpu_reset_hold(Object *obj)
>      env->two_stage_lookup =3D false;
>
>      env->menvcfg =3D (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
> -                   (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
> +                   (!cpu->cfg.ext_svade && cpu->cfg.ext_svadu ?
> +                    MENVCFG_ADUE : 0);
>      env->henvcfg =3D 0;
>
>      /* Initialized default priorities of local interrupts. */
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 8da9104da4..3a440833f8 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -907,7 +907,9 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>      }
>
>      bool pbmte =3D env->menvcfg & MENVCFG_PBMTE;
> -    bool adue =3D env->menvcfg & MENVCFG_ADUE;
> +    bool svade =3D riscv_cpu_cfg(env)->ext_svade;
> +    bool svadu =3D riscv_cpu_cfg(env)->ext_svadu;
> +    bool adue =3D svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
>
>      if (first_stage && two_stage && env->virt_enabled) {
>          pbmte =3D pbmte && (env->henvcfg & HENVCFG_PBMTE);
> @@ -1082,9 +1084,18 @@ restart:
>          return TRANSLATE_FAIL;
>      }
>
> -    /* If necessary, set accessed and dirty bits. */
> -    target_ulong updated_pte =3D pte | PTE_A |
> -                (access_type =3D=3D MMU_DATA_STORE ? PTE_D : 0);
> +    target_ulong updated_pte =3D pte;
> +
> +    /*
> +     * If ADUE is enabled, set accessed and dirty bits.
> +     * Otherwise raise an exception if necessary.
> +     */
> +    if (adue) {
> +        updated_pte |=3D PTE_A | (access_type =3D=3D MMU_DATA_STORE ? PT=
E_D : 0);
> +    } else if (!(pte & PTE_A) ||
> +               (access_type =3D=3D MMU_DATA_STORE && !(pte & PTE_D))) {
> +        return TRANSLATE_FAIL;
> +    }
>
>      /* Page table updates need to be atomic with MTTCG enabled */
>      if (updated_pte !=3D pte && !is_debug) {
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 673097c6e4..43c32b4a15 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -196,17 +196,14 @@ static bool cpu_cfg_offset_is_named_feat(uint32_t e=
xt_offset)
>
>  static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_off=
set)
>  {
> -    switch (feat_offset) {
> -    case CPU_CFG_OFFSET(ext_zic64b):
> +     /*
> +      * All other named features are already enabled
> +      * in riscv_tcg_cpu_instance_init().
> +      */
> +    if (feat_offset =3D=3D CPU_CFG_OFFSET(ext_zic64b)) {
>          cpu->cfg.cbom_blocksize =3D 64;
>          cpu->cfg.cbop_blocksize =3D 64;
>          cpu->cfg.cboz_blocksize =3D 64;
> -        break;
> -    case CPU_CFG_OFFSET(ext_svade):
> -        cpu->cfg.ext_svadu =3D false;
> -        break;
> -    default:
> -        g_assert_not_reached();
>      }
>  }
>
> @@ -348,8 +345,6 @@ static void riscv_cpu_update_named_features(RISCVCPU =
*cpu)
>      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
>                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
>                            cpu->cfg.cboz_blocksize =3D=3D 64;
> -
> -    cpu->cfg.ext_svade =3D !cpu->cfg.ext_svadu;
>  }
>
>  static void riscv_cpu_validate_g(RISCVCPU *cpu)
> --
> 2.43.0
>
>

