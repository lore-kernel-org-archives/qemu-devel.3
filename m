Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B3FE77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 03:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUdco-0000Lk-Tz; Sun, 05 Jan 2025 22:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdcg-0000LQ-Vf; Sun, 05 Jan 2025 22:17:47 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdcf-0003PB-Dj; Sun, 05 Jan 2025 22:17:46 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-51ba75ee2f3so3649284e0c.2; 
 Sun, 05 Jan 2025 19:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736133464; x=1736738264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdVjyWIslowjc+XiB2n8nHKnoFskwztZus0YURbz7h8=;
 b=FiXkNDUtdsDy2fzvC9fRwo6XfVZTFYCnK7qI6UH2gWmyY/gHkfaRGUDzEKhqpn8ALz
 iarCl3+cVLV05l+Ih4keeitTyrgPigoiMdQgZQ8xuN57BV7SmPv1Yrj2Ms85xh8zkSs8
 tGBRG06GJ4K3hITPF2TxRoY2v5hCifzHDKQyd6BOoOmaPQmX//nP3ILYRXhCRchJZY80
 WCNRv4XTbETtP9q6xzqatsP4TnDuR2ZHTMWSxKPnqdGbyvg6AGHsX/u+rAKjDDwiT0bP
 NT6tE2jOWygybjJ2MFIlS7GEJ+8jOel3D//pnwt0Cx1jojiFFIVErh4aIuCL+68AlxDH
 CR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736133464; x=1736738264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdVjyWIslowjc+XiB2n8nHKnoFskwztZus0YURbz7h8=;
 b=wBdGvnTozYd+bTaQCzwj2VxrUt4aS7dzZJb+dIxDao1q4ktm6RC++DQNAjqveDGYwG
 rMQCODerQM/FqulPQrOO1xNfY3tkK2hxZohW/nErdCHKG0SO3Le3vUeu1LzFyKZqt97K
 tBDTMWogDy6eryWOoKDPfFqevf/aqo+d/g/9FswyHWBE6eAdOc7TGC3SbVl/N1ySBoFW
 OaUor3p6Jr501+UTXNfDTs3+uKNg6qUJ4Wknlk+mio4z0DkWypbwcN2fmomrs9MtL5fW
 JBm2kTUtqcTlnabb+Xkl50vwXFikOFR0Jy89VcbKgReDvlHwq+jq7YpuNrm/7CAkXqoK
 ltAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT8iL2jx3t28OP6O2xYnsLC1N21F6VJYa7AFolN9zmh3tK4xocVLzRM+q5ahevKjOD0KdMP1ZHSvY/@nongnu.org,
 AJvYcCWuRzK44YRCkLuKC2FYD8Maf4vj00B9X0EMeRkr1ddJi7TAi4+XBx7/Xza2+MBawpKYh/ySzFfOSk1uEg==@nongnu.org
X-Gm-Message-State: AOJu0YykPggilC2O7diWiryFgNyD5l8vkCypt+bO2mLDOUwIlQbpuU6q
 +96f0ltlVhC+HSltuZXkXNk0JfqIR7as//+9kg/Ms9ft3eC0uISS6rHLP9DeTB5vTRuZIGI9Pw8
 ZCP5HuukUroGMGNKUgw8Kf1OyYLM=
X-Gm-Gg: ASbGncvBROjWVs04T7Yzx49RkLjyAptqMoeJ5SgquWR+hOUJrT9D0ATYH+iYilNH6b8
 QgiAJ2ScHeZesvjC8wXBa7m8pn5cI8vU0GTH5uqqKpksYUGaU/OBzfRtljEN60MU+u6o=
X-Google-Smtp-Source: AGHT+IG5PTW/BkFrfmnxFrheYjTT+dcolixn/2nBilrzRSLgqkxxfEGsGqwg8/+BFk7y8qHqNhivLbaQNg++IJuDVrE=
X-Received: by 2002:a05:6122:8c0c:b0:518:9582:db90 with SMTP id
 71dfb90a1353d-51b75d6fb20mr38998242e0c.11.1736133463952; Sun, 05 Jan 2025
 19:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20241217085709.679823-1-baturo.alexey@gmail.com>
 <20241217085709.679823-4-baturo.alexey@gmail.com>
In-Reply-To: <20241217085709.679823-4-baturo.alexey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 13:17:18 +1000
Message-ID: <CAKmqyKMJ8MeCyv5JPX38s22Tk+mL+rFECUyRJXTESxL_sPX5eQ@mail.gmail.com>
Subject: Re: [PATCH v14 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Tue, Dec 17, 2024 at 6:57=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |  5 +++
>  target/riscv/cpu_helper.c | 78 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 417ff45544..e7f346ff6b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -768,8 +768,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr =
*pc,
>
>  bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> +uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
> +
>  RISCVException riscv_csrr(CPURISCVState *env, int csrno,
>                            target_ulong *ret_value);
> +
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value,
>                             target_ulong new_value, target_ulong write_ma=
sk);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dba04851d5..7d149dfb33 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -214,6 +214,84 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr =
*pc,
>      *pflags =3D flags;
>  }
>
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    int priv_mode =3D cpu_address_mode(env);
> +
> +    if (get_field(env->mstatus, MSTATUS_MPRV) &&
> +        get_field(env->mstatus, MSTATUS_MXR)) {
> +        return PMM_FIELD_DISABLED;
> +    }
> +
> +    /* Get current PMM field */
> +    switch (priv_mode) {
> +    case PRV_M:
> +        if (riscv_cpu_cfg(env)->ext_smmpm) {
> +            return get_field(env->mseccfg, MSECCFG_PMM);
> +        }
> +        break;
> +    case PRV_S:
> +        if (riscv_cpu_cfg(env)->ext_smnpm) {
> +            if (get_field(env->mstatus, MSTATUS_MPV)) {
> +                return get_field(env->henvcfg, HENVCFG_PMM);
> +            } else {
> +                return get_field(env->menvcfg, MENVCFG_PMM);
> +            }
> +        }
> +        break;
> +    case PRV_U:
> +        if (riscv_has_ext(env, RVS)) {
> +            if (riscv_cpu_cfg(env)->ext_ssnpm) {
> +                return get_field(env->senvcfg, SENVCFG_PMM);
> +            }
> +        } else {
> +            if (riscv_cpu_cfg(env)->ext_smnpm) {
> +                return get_field(env->menvcfg, MENVCFG_PMM);
> +            }
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return PMM_FIELD_DISABLED;
> +#else
> +    return PMM_FIELD_DISABLED;
> +#endif
> +}
> +
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    int satp_mode =3D 0;
> +    int priv_mode =3D cpu_address_mode(env);
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        satp_mode =3D get_field(env->satp, SATP32_MODE);
> +    } else {
> +        satp_mode =3D get_field(env->satp, SATP64_MODE);
> +    }
> +
> +    return ((satp_mode !=3D VM_1_10_MBARE) && (priv_mode !=3D PRV_M));
> +#else
> +    return false;
> +#endif
> +}
> +
> +uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm)
> +{
> +    switch (pmm) {
> +    case PMM_FIELD_DISABLED:
> +        return 0;
> +    case PMM_FIELD_PMLEN7:
> +        return 7;
> +    case PMM_FIELD_PMLEN16:
> +        return 16;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>
>  /*
> --
> 2.39.5
>

