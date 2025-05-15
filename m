Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAEDC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRDi-0002s5-Es; Thu, 15 May 2025 01:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRDg-0002ru-Us
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:33:25 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRDf-0006pu-5B
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:33:24 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-86715793b1fso159109241.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287202; x=1747892002; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkMUJ1gdRTZxGVceyX4JhxKXh4aHHL9iiy3HxlflB/E=;
 b=gv1yyqq/B6GHitdrbgEJETPDHCAbX/inySe3sqC2wtkKwogvQVnToKcpoAAFfRLG2G
 5GekeniviVA5JQBrbemCNe+Ar+8B4CN3Fp3jqHcwhe0TwPGa0C9JDBps31gDBbXtAGuR
 u+Zuoe6xE7kmr7KiWxowXUkh47JENEZ9mtlyspfCzeU76cE5TaCnUt8i/lGUnO+Asi4d
 WPXd7/bbzdDB8FeyoqRxXO/PAWEiJ90HpQ7S93LATv/8xQl7PF1EEEus7TwN/sSMWAtC
 uYSTx5cNxAA8qn5OaWBW+6zlghP5P+lZ3IeDJw71+BdYJvmhU5m2+J7HpXWwVj+ojSbh
 zKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287202; x=1747892002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkMUJ1gdRTZxGVceyX4JhxKXh4aHHL9iiy3HxlflB/E=;
 b=SqGrpTnnQg8Ke8k1sHz6kkFxVvJU04ZubNLlGp0GchPqZ7gk3AxOtdHCsDlws/1628
 GKwCSezJWDa8D282EhYDWXDewsJUMPZOYULKTZGr8nnZ7s8Rv24ndyNylb84CCV3jmlX
 oDrQSsCs3FAC+5txlZBUdOPnuKbnXom1OHE/sZCRmmDlu9eycF41ORaNjsb6bsfg6RK4
 yG4omZWFEsxqGoxBqfsr8LWOVjnBSD5d8dRrjDAxQx5ewN1CJu0Viv4c615K+uQn1z2B
 ohkFoSDTPO3bIz99t7I81iV2c/0gIXOz38W9disYlT4qTjMceLbk8KC/PL8CJF8iL+Eq
 sITg==
X-Gm-Message-State: AOJu0Yw61DlgLdOiyjPvQ2A20GF0bkabZ+MUVMCN2L/0KZrWBkS/g8CI
 RicQbdsl2K/yoZCRh5I0s9cmG+/j0ERL1vjZ7z8bqS54Pa28sSNGu8WgurXdIfv2OESGMdiQOA4
 QRaAKMVy265aYyq0LWnF5swHHKdo=
X-Gm-Gg: ASbGncs+B4QxihZ+pRKOLsjsh+pckMgKZvjtK/niq1sl16Djwtjy5fYm72YpBK8KAUy
 BtyWtlvy9L+lwxzoC2OddZJ5WIzsoXPpzYIDcqSaZGHveeN0HikOPpsJ89coehJ7aXxP5Z3/rnG
 3kjB1cOb1wdr/MgkB58NPrIjhjkpvllAHAJRHGvYzFIArGQXmLDFUEecpiAWs9ztM=
X-Google-Smtp-Source: AGHT+IE81RV2bFjT9zKK4oZ2UmEfpV4naHEpaUH+cYhgK5fQGlbodfnV+1ABPSZ3UXyTrPRPEldzOUjvOdxzCw9LyCA=
X-Received: by 2002:a05:6102:3e0c:b0:4df:84d5:543e with SMTP id
 ada2fe7eead31-4df9541ae27mr837195137.7.1747287201892; Wed, 14 May 2025
 22:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-18-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-18-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:32:53 +1000
X-Gm-Features: AX0GCFuG_LO2FUGJ3XJ73F70pihbVW1dCKp6EKR0H0JTsTr1ZQuUJn3kslN-ddo
Message-ID: <CAKmqyKPw-2zBs3gtutM2dVVv+P12bRn9iaXUF9VPx4=_X3K2cA@mail.gmail.com>
Subject: Re: [PATCH 17/26] target/riscv: convert ibex CPU models to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index aea5d7d197e..661b2384d82 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -690,28 +690,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.mmu =3D true;
>      cpu->cfg.pmp =3D true;
>  }
> -
> -static void rv32_ibex_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVC | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_12_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> -#endif
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -    cpu->cfg.ext_smepmp =3D true;
> -
> -    cpu->cfg.ext_zba =3D true;
> -    cpu->cfg.ext_zbb =3D true;
> -    cpu->cfg.ext_zbc =3D true;
> -    cpu->cfg.ext_zbs =3D true;
> -}
>  #endif
>
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> @@ -3169,7 +3147,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_mxl_max =3D MXL_RV32,
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cp=
u_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV32,
> +        .misa_ext =3D RVI | RVM | RVC | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +        .cfg.max_satp_mode =3D VM_1_10_MBARE,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.pmp =3D true,
> +        .cfg.ext_smepmp =3D true,
> +
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbs =3D true
> +    ),
> +
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
>          .misa_mxl_max =3D MXL_RV32
>      ),
> --
> 2.49.0
>

