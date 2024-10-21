Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E082BD3C927
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2gxW-0002J2-C4; Sun, 20 Oct 2024 21:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gxT-0002IB-1q; Sun, 20 Oct 2024 21:11:43 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gxR-0004X4-EE; Sun, 20 Oct 2024 21:11:42 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4a471fd7ef6so2458919137.1; 
 Sun, 20 Oct 2024 18:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729473100; x=1730077900; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnxkH4vaPmpRBL3v1eFVPTFL6E5XlqqYd+UDOd4cHq4=;
 b=NzQ1NdcmCNDOKn8DrhKNVWDMdSGmKGwz+wPIvLps69Tfb+uAaMqVO18JF5gUYh7SNU
 LH3y+W3/mFvcyTyKO8GCTaJ6kqMFDrsEmZ7W1Bb1RvM15Ujulr+JW90rGrZzd+UG7M71
 Tm3tpMslvtiMcogm/yTfbTIdrE1eUt7ooz4sVGuvl78ZvqORl46wGXhbfvRSoryHp4sw
 mEN8EraQPge24w7nwjKMo2MsY4Z4bZ7ZWLDgW+qahNan1Eo1ufDp4igud49XoNqt/ZUk
 16vznKIAep5dpLLk0YwX+//9lrTFwlgiUXx3LewLmZZPO2mL2cpLl7YwQwkwEHDkOd8r
 /Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729473100; x=1730077900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnxkH4vaPmpRBL3v1eFVPTFL6E5XlqqYd+UDOd4cHq4=;
 b=bQg6jODIuo++re0cG99GzAb3C67UBAXQjVMqoqjB+zJwHmqAgzoyhvGC/IWwd066a/
 Dc6i0jnre4G6jLBiKrZsN5Y4z7UtICmveMeBQbRJE61vWY74Ytdl0Mc7Sh3djussvEgK
 LPctjLBxun7CdkheZOd3orBBl/8T4KsJ782AsWmzNhJZxHrekrUYtFz4Uebl50k1m7uB
 35raORLlJZotHB4mirAIlaiBi/tZnp+8piUca/E6dYsJ5UxEhpDPwmFGv/nx2FnDzB21
 EdzShGeglpnEo9199VWQ2fJmtpQV5Rff7mpPWx0LWThMosi9D1yyH48HA2v2DBhlNDR0
 AayQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3QFv6BiM8o8CM35DOVJUG3smiD7ynytetkwCFFYA267+I8T1QWUMWKxYxc4wncph7oYuwRNKgOAL6@nongnu.org
X-Gm-Message-State: AOJu0Yzxb43CCX13Sfr3ugkbCgDrqxAAtFjvd3z2afno2CrgZdT0Xbb1
 kdEJUHaEh8VN64lqaweB3L2ygb8HKAh4p1PgNFC0U4RLriKKaKtN8NJgJMs33B/X0N8KyKS5uxR
 21TznZxGLg/agvGMczT1BqSC7t04=
X-Google-Smtp-Source: AGHT+IGKeND24/D/ttY8PRJXe8c9FAegTzlb0hxKr2QNZDNBUl00t1hzrbt79OCawBiSVk/8ybSW+TVnQnzXL6fjjYA=
X-Received: by 2002:a05:6102:32c7:b0:4a4:71e5:eb76 with SMTP id
 ada2fe7eead31-4a5c49cc3c4mr8951046137.10.1729473099926; Sun, 20 Oct 2024
 18:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-8-cleger@rivosinc.com>
In-Reply-To: <20241017145226.365825-8-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:11:14 +1000
Message-ID: <CAKmqyKNeUPC3KLXbzpK5g-=cAeOTTReOMGjP1PXsZMpnj3EXqA@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] target/riscv: Implement Smdbltrp sret, mret and
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Fri, Oct 18, 2024 at 12:54=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> When the Ssdbltrp extension is enabled, SSTATUS.MDT field is cleared
> when executing sret if executed in M-mode. When executing mret/mnret,
> SSTATUS.MDT is cleared.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/op_helper.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index dabc74de39..64c5792af8 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -299,6 +299,9 @@ target_ulong helper_sret(CPURISCVState *env)
>          }
>          mstatus =3D set_field(mstatus, MSTATUS_SDT, 0);
>      }
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp && env->priv >=3D PRV_M) {
> +        mstatus =3D set_field(mstatus, MSTATUS_MDT, 0);
> +    }
>      if (env->priv_ver >=3D PRIV_VERSION_1_12_0) {
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
> @@ -375,6 +378,9 @@ target_ulong helper_mret(CPURISCVState *env)
>      if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
>          mstatus =3D ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
>      }
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +        mstatus =3D set_field(mstatus, MSTATUS_MDT, 0);
> +    }
>      if ((env->priv_ver >=3D PRIV_VERSION_1_12_0) && (prev_priv !=3D PRV_=
M)) {
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
> @@ -412,6 +418,12 @@ target_ulong helper_mnret(CPURISCVState *env)
>          env->mstatus =3D ssdbltrp_mxret(env, env->mstatus, prev_priv, pr=
ev_virt);
>      }
>
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +        if (prev_priv < PRV_M) {
> +            env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, false)=
;

0 instead of false, otherwise

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +        }
> +    }
> +
>      if (riscv_has_ext(env, RVH) && prev_virt) {
>          riscv_cpu_swap_hypervisor_regs(env);
>      }
> --
> 2.45.2
>
>

