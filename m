Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB150D24463
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz66l-0007xy-NO; Thu, 10 Oct 2024 23:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz66j-0007xB-U5; Thu, 10 Oct 2024 23:14:25 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz66i-00023r-Aa; Thu, 10 Oct 2024 23:14:25 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-50ac27e3530so1479398e0c.1; 
 Thu, 10 Oct 2024 20:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728616463; x=1729221263; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXJ9raoBsx6pFj6NB6deFVdI2pGjjg1HftQdtPcj4+Y=;
 b=daoN14YbbLRBCuKld4D9XEnDi/UgnBbV7UZhZJs43QoG1iMC9WZP/W5T/voZEoy0jG
 akNUllHWiHn8uFbCpiKXXrKNwNl/4eB2gaZy0u9npSvLSWHVOlvvBhYAQtcZFZNc4pi/
 18BrMT0Jz+wEsQnRNuVXxJ5rqPjTkIP6GqMAFZkNKmojbuzZ0wPCHG4QWWdFFz7qx1Hc
 hssbZPTIVL0hHtmaOIHaHgNZUo2jfbVxnCcfv1zCbtqdkfVC7RmC82Bjc7OTU1zM5UQC
 ezEHQ1OwGwS4AkraEy7zGo1gReYfB/cyOveM2VWCrA3uWk5mnSdzsw0BVTiq+/nLym+i
 UKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728616463; x=1729221263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXJ9raoBsx6pFj6NB6deFVdI2pGjjg1HftQdtPcj4+Y=;
 b=JYJlOu2sMK+zIVdPoAWGb6AZ/eX2FGvVnJyRqW+FY2wSfk3LmZTawlLXpQescoTEFN
 ZtuGvNJNQngLEAXR6pWIa0I8hKzyEJmkLemse5qSmB3DRtYNvezp6DZ3QmBPu4eQe0wS
 3F5juSjXHNAy0rgK/XNMye13qSQ0sxjYuVANCrJ9HfT1975YGKEXIywd9GNirzgEIV9+
 4NyPrrxxDgk3l5IEWmOTjNJwIMdGZDfM38SKMsEBCduayU4ZH8QypUpRfYmwGXL7n4MX
 J9+w+snHoWfiXuSfk9WeEVCdVum1EeNai0EPcnRwP0oR/2UtduhuNnKj2f0uJbJmGebq
 KZeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI8QVUqORGAHRAbYIxLo3G9TjzvfqLY6z0Q1TTtsgEiXLJcpsQfN1HifWvuO0GchcOmZ4w6mgPuvK8@nongnu.org
X-Gm-Message-State: AOJu0YzuIyWZwDo2z9IEFj/zEQn48qYrnR6EXrIHLNKklJkcy1ieymEo
 XeYsn9u6tO3A5+Iiz723rcCGSl/WlRZuU10CKWGiQfKR9ktLqh84NIVPXfm4YmZ2GzuVww4O4Sy
 dcSIWNLMPwjh09+pD4SIHplldsGTwvNn2vqA=
X-Google-Smtp-Source: AGHT+IGqnueORyGrZZ7oBwA3FGINBkMkTaw4A3kXwZgY9JvziC6+16qnHp2UqjGRUhDlKigWUxZPrk2C3gfDy34GwT0=
X-Received: by 2002:a05:6122:1d0a:b0:50c:eb10:9792 with SMTP id
 71dfb90a1353d-50d1bb1b4f1mr1018493e0c.4.1728616462867; Thu, 10 Oct 2024
 20:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-3-cleger@rivosinc.com>
In-Reply-To: <20240925115808.77874-3-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 13:13:56 +1000
Message-ID: <CAKmqyKPrHtsjAnc8kX__BeHvxoMvm+MmYLWSgh5TKdx0FE8o9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] target/riscv: Implement Ssdbltrp sret, mret and
 mnret behavior
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Wed, Sep 25, 2024 at 9:58=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> When the Ssdbltrp extension is enabled, SSTATUS.SDT field is cleared
> when executing sret. When executing mret/mnret, SSTATUS.SDT is cleared
> when returning to U, VS or VU and VSSTATUS.SDT is cleared when returning
> to VU from HS.

I don't see mret being mentioned in the spec. Where do you see that
V/SSTATUS.SDT should be cleared?

Alistair

>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/op_helper.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 6895c7596b..00b6f75102 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -287,6 +287,18 @@ target_ulong helper_sret(CPURISCVState *env)
>                          get_field(mstatus, MSTATUS_SPIE));
>      mstatus =3D set_field(mstatus, MSTATUS_SPIE, 1);
>      mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
> +
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        if (riscv_has_ext(env, RVH)) {
> +            target_ulong prev_vu =3D get_field(env->hstatus, HSTATUS_SPV=
) &&
> +                                   prev_priv =3D=3D PRV_U;
> +            /* Returning to VU from HS, vsstatus.sdt =3D 0 */
> +            if (!env->virt_enabled && prev_vu) {
> +                env->vsstatus =3D set_field(env->vsstatus, MSTATUS_SDT, =
0);
> +            }
> +        }
> +        mstatus =3D set_field(mstatus, MSTATUS_SDT, 0);
> +    }
>      if (env->priv_ver >=3D PRIV_VERSION_1_12_0) {
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
> @@ -297,7 +309,6 @@ target_ulong helper_sret(CPURISCVState *env)
>          target_ulong hstatus =3D env->hstatus;
>
>          prev_virt =3D get_field(hstatus, HSTATUS_SPV);
> -
>          hstatus =3D set_field(hstatus, HSTATUS_SPV, 0);
>
>          env->hstatus =3D hstatus;
> @@ -328,6 +339,22 @@ static void check_ret_from_m_mode(CPURISCVState *env=
, target_ulong retpc,
>          riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC()=
);
>      }
>  }
> +static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong msta=
tus,
> +                                   target_ulong prev_priv,
> +                                   target_ulong prev_virt)
> +{
> +    /* If returning to U, VS or VU, sstatus.sdt =3D 0 */
> +    if (prev_priv =3D=3D PRV_U || (prev_virt &&
> +        (prev_priv =3D=3D PRV_S || prev_priv =3D=3D PRV_U))) {
> +        mstatus =3D set_field(mstatus, MSTATUS_SDT, 0);
> +        /* If returning to VU, vsstatus.sdt =3D 0 */
> +        if (prev_virt && prev_priv =3D=3D PRV_U) {
> +            env->vsstatus =3D set_field(env->vsstatus, MSTATUS_SDT, 0);
> +        }
> +    }
> +
> +    return mstatus;
> +}
>
>  target_ulong helper_mret(CPURISCVState *env)
>  {
> @@ -345,6 +372,9 @@ target_ulong helper_mret(CPURISCVState *env)
>      mstatus =3D set_field(mstatus, MSTATUS_MPP,
>                          riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
>      mstatus =3D set_field(mstatus, MSTATUS_MPV, 0);
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mstatus =3D ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
> +    }
>      if ((env->priv_ver >=3D PRIV_VERSION_1_12_0) && (prev_priv !=3D PRV_=
M)) {
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
> @@ -382,6 +412,9 @@ target_ulong helper_mnret(CPURISCVState *env)
>      if (prev_priv < PRV_M) {
>          env->mstatus =3D set_field(env->mstatus, MSTATUS_MPRV, false);
>      }
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        env->mstatus =3D ssdbltrp_mxret(env, env->mstatus, prev_priv, pr=
ev_virt);
> +    }
>
>      if (riscv_has_ext(env, RVH) && prev_virt) {
>          riscv_cpu_swap_hypervisor_regs(env);
> --
> 2.45.2
>
>

