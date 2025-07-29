Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A17DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 03:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugau0-0003n7-MO; Mon, 28 Jul 2025 23:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugatw-0003kR-BU; Mon, 28 Jul 2025 23:21:16 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugatu-0005RY-Dc; Mon, 28 Jul 2025 23:21:16 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-88bc56adfb8so2691241.2; 
 Mon, 28 Jul 2025 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753759272; x=1754364072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/1Y2Mm++NdkMd3OOAkyd0ynJ62OT3Rt/rSHsWFkF2U=;
 b=YIgF4hgBwUOAzEckwBcJ2vMgKWcOKJK4tenbIR1cAMrO+mYiBuh/id7gHF5wP+M+a7
 300EHS/NX1xqIPqyIdq9Gykok3cVRl+AC1XoWY1IjYO4NSqJO2DlHMOeb25g1V+chY6+
 +jpncQjF3PJ3be4YpRFHcCAXKIST6JvBxCapvTrReYjwpLleJSZodS4zKYEf7B0/6CI7
 zEycrwP36l9a2JSiyTStTygX+14gLkk2k2mJqEhuiMeJP6Ze3R1M6Si+D3upsNJwNDW3
 YR3KJpXssTtHrS/a6Va9MvinLOY0ax5vVLWolIiXWVXrCQ8U9h34kMB8aoRk6JDjI4Wi
 9eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753759272; x=1754364072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/1Y2Mm++NdkMd3OOAkyd0ynJ62OT3Rt/rSHsWFkF2U=;
 b=IlzkzXxZ5v6QUvgq5bKglwmpq2WTUxgBM2jNpCadOPJ4Pt4HFm86EkEVc0+RzjYHvI
 bxcn8HIXWdoZMMQOGaJocv1/oHzqZrs6EGsC04vHzSqaoSSj4vNymxL+ekalxfj3tkRX
 WHpl86G3htkzu6c++zh4bF01V61BKk6Jf3gKSU1BkyoQzyPvwuljHtNPA8EJMKfNJbUH
 yQZRDLjBHWIBoDyKZslmjwUfKpLoWznPwyqS+nIM/w4KBPyqPwC4i7MHsMt98sRmu0Oh
 vRBt9xzRG8rukYp4D9P9MIrSQ1eCjwoo/g0C5+BThHCUeSec24335IylsfcdlMADxua3
 /o3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+yaHbCipSUVNdq6ZQgcMY6d9WKZ52ZXZDz0FU2EZbEX4LJbupaKK/WTPeC2KOWONLy64wBCATnQxp@nongnu.org
X-Gm-Message-State: AOJu0YxXTb/qmozt2InoP+1pNHxhaBpvippxwdyZGTV9kRZ7BWbvlBf0
 vQC809k+K8QjeVB8t8n4xk3QCENET+isT6AZhLiH8S7E3SbF/1xmLCMh94cH5ZVqF8jFcUMmMAN
 7Hfz0uQgT272EQYljf34+JfBwPTydyzQOfA==
X-Gm-Gg: ASbGncuuj6BT7wcu82HEYsMBY75ULNPD8TkQr0F9ozeMc+ZbZoDLDoljIgau/rcCwGv
 LOeqBmCNKJiY5ossGoDVyZbYSCt6NgG6rG2+ukjPUSlmZ5Gic783VCOiubCPNZtkUpStft+ht30
 7Jg19c/JRz+z5O9KJlCMoJQDFB9da3d0+Nqg97ZWyIWf2vl837ujdaUYQrNCX1w5Y1xeP3akHGp
 buiITJ2r75VCNSGfXQ+K9+RohLEVHcd3wETgYhIydFl4cX5
X-Google-Smtp-Source: AGHT+IHVQXsB1QcaWrESFXyojhfPVQbwqVwIdVEJwuS5Ina680C8/fgyo8H+hDBI2UggYJMgwLWIW/eeOH8H9+zajr8=
X-Received: by 2002:a05:6102:3e94:b0:4f9:d957:a417 with SMTP id
 ada2fe7eead31-4fa3fc4cd5fmr5793466137.17.1753759272483; Mon, 28 Jul 2025
 20:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Jul 2025 13:20:46 +1000
X-Gm-Features: Ac12FXw4Px5nABxL-bLggmg7Y8e7tHnI3Y1YKV-blf12eFWKidN6vVzaaOGRA1s
Message-ID: <CAKmqyKNN+FBuRgJpXHe=3idV+_6_FYFL6=c+p=h_QF90V_axxQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: do not call GETPC() in
 check_ret_from_m_mode()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Tue, Jul 15, 2025 at 1:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> GETPC() should always be called from the top level helper, e.g. the
> first helper that is called by the translation code. We stopped doing
> that in commit 3157a553ec, and then we introduced problems when
> unwinding the exceptions being thrown by helper_mret(), as reported by
> [1].
>
> Call GETPC() at the top level helper and pass the value along.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/3020
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: 3157a553ec ("target/riscv: Add Smrnmi mnret instruction")
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3020
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/op_helper.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 15460bf84b..110292e84d 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -355,21 +355,22 @@ target_ulong helper_sret(CPURISCVState *env)
>  }
>
>  static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc=
,
> -                                  target_ulong prev_priv)
> +                                  target_ulong prev_priv,
> +                                  uintptr_t ra)
>  {
>      if (!(env->priv >=3D PRV_M)) {
> -        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
>      }
>
>      if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
>                                      env->priv_ver,
>                                      env->misa_ext) && (retpc & 0x3)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, ra);
>      }
>
>      if (riscv_cpu_cfg(env)->pmp &&
>          !pmp_get_num_rules(env) && (prev_priv !=3D PRV_M)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC()=
);
> +        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, ra);
>      }
>  }
>  static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong msta=
tus,
> @@ -394,8 +395,9 @@ target_ulong helper_mret(CPURISCVState *env)
>      target_ulong retpc =3D env->mepc & get_xepc_mask(env);
>      uint64_t mstatus =3D env->mstatus;
>      target_ulong prev_priv =3D get_field(mstatus, MSTATUS_MPP);
> +    uintptr_t ra =3D GETPC();
>
> -    check_ret_from_m_mode(env, retpc, prev_priv);
> +    check_ret_from_m_mode(env, retpc, prev_priv, ra);
>
>      target_ulong prev_virt =3D get_field(env->mstatus, MSTATUS_MPV) &&
>                               (prev_priv !=3D PRV_M);
> @@ -443,8 +445,9 @@ target_ulong helper_mnret(CPURISCVState *env)
>      target_ulong retpc =3D env->mnepc;
>      target_ulong prev_priv =3D get_field(env->mnstatus, MNSTATUS_MNPP);
>      target_ulong prev_virt;
> +    uintptr_t ra =3D GETPC();
>
> -    check_ret_from_m_mode(env, retpc, prev_priv);
> +    check_ret_from_m_mode(env, retpc, prev_priv, ra);
>
>      prev_virt =3D get_field(env->mnstatus, MNSTATUS_MNPV) &&
>                  (prev_priv !=3D PRV_M);
> --
> 2.50.1
>
>

