Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87D7C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 01:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRMCs-0005nD-88; Tue, 09 Jul 2024 21:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRMCo-0005ki-Ax; Tue, 09 Jul 2024 21:33:14 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRMCk-0001UH-0l; Tue, 09 Jul 2024 21:33:12 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4e7eadf3668so2286727e0c.0; 
 Tue, 09 Jul 2024 18:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720575187; x=1721179987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkx8kStre13Ac+v7aPPQ9slogI60apbpl/3c2FMpLxA=;
 b=TBp87x5nsgJiTVTbYO2UXltu2ynQOEONiodBWcv4UDrisauNKXrFbTlZeVfd2tmc4P
 NNAa2e125YaG6DytSwfBYo5ttXN2VHE3C/Ve2GsSmUoHsdtk6XN2PLc8q6HzUxmsNFmI
 14Mu78dCadXggfd8xBqiPM5Opuo0iWlHNYq02oo+Os3aTE1Bmv1rzygjF8pLHzBle6D1
 zNq9lEVEAp6Z2SiLq6ZP+uydd67P+Nk7/bMT6rbMY6X439tVpAIky17v5Hxr8sUy3yS7
 fciAMOy2ibxi37BMTUE0T2+TJhbq1D6LvEm4TGBy7GwKlCapJFBO21/qL4F+uDzEwRsg
 dK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720575187; x=1721179987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkx8kStre13Ac+v7aPPQ9slogI60apbpl/3c2FMpLxA=;
 b=JvVG2vIQk3SO3U/Wo0tphyXPFRCWy4usjfJqth8NeFkNtwzEvzv/i2PJUgphV4u3tX
 VAWPdIyJNPM7zOvVdbkKA7TGtot4+HYg+G8FHLgG9SvCgquStXDwpS0nFgXUDF/mAMlB
 M5Nt0bK4bS13PYjezG13ozm9oFNA3DfLEwNIxtD0Ohvf+ejR1fTKZ7RCPqS2CfxMyJs7
 Ci68P9Mh6lVKogrDonXuz6AmY1tJs338oDxHVkvuaQTK8fO5oVc48xPEQrPJb+XhkD4q
 EsJvSdhmsQwPhbOD7R5RhqVaNwb8MknZaH6XMFZpKKX6HrZSNghMggIReotRgLLcHxaf
 hJow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1GH6HdBr1tw/+soMatBawyHUWkmlhG3xU2hL0rK1j2YwZdukQU0vntcvdu2uI2X7FtGjUn3rdCTWnLwZjDsatTc+M8Ok=
X-Gm-Message-State: AOJu0YyeoCSFfr4jl8Eje/LfJ4klk3citzacdmnSTx+Lh18U/3n8xq7P
 +2Zotn/ysLzdXOR5nFgFTDCgkwgunwtsS0j+cNMViPQDWqkzOJwGFx1rVMnwvYtLd6fsfZWZqe+
 QVuLMqhMrqKpStW8IEPo36PB7Bsg=
X-Google-Smtp-Source: AGHT+IElsuui7GpqoZopKMDfOpyvkIr/FEqKTeBrb+FX+NnYsAWAZp5xKjtfp+FAwroKjjyyI8mAY3d7165GhmMNb/g=
X-Received: by 2002:a05:6102:1505:b0:48f:eb37:fd86 with SMTP id
 ada2fe7eead31-4903220aeffmr5234339137.30.1720575187505; Tue, 09 Jul 2024
 18:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240708131645.1345-1-zhiwei_liu@linux.alibaba.com>
 <20240708131645.1345-6-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240708131645.1345-6-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 11:32:41 +1000
Message-ID: <CAKmqyKN3U_iwf+vqJsaWpibpn8OjMFrfwBWgXUvnPWgCmXhF3w@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] target/riscv: Correct mcause/scause bit width for
 RV32 in RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, richard.henderson@linaro.org, philmd@linaro.org, 
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Mon, Jul 8, 2024 at 11:21=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Ensure mcause high bit is correctly set by using 32-bit width for RV32
> mode and 64-bit width for RV64 mode.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 4f0ab90ac7..3eedb26cd9 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1673,6 +1673,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
>      target_ulong mtval2 =3D 0;
> +    int sxlen =3D 0;
> +    int mxlen =3D 0;
>
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
> @@ -1799,7 +1801,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          s =3D set_field(s, MSTATUS_SPP, env->priv);
>          s =3D set_field(s, MSTATUS_SIE, 0);
>          env->mstatus =3D s;
> -        env->scause =3D cause | ((target_ulong)async << (TARGET_LONG_BIT=
S - 1));
> +        sxlen =3D 16 << riscv_cpu_sxl(env);
> +        env->scause =3D cause | ((target_ulong)async << (sxlen - 1));
>          env->sepc =3D env->pc;
>          env->stval =3D tval;
>          env->htval =3D htval;
> @@ -1830,7 +1833,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          s =3D set_field(s, MSTATUS_MPP, env->priv);
>          s =3D set_field(s, MSTATUS_MIE, 0);
>          env->mstatus =3D s;
> -        env->mcause =3D cause | ~(((target_ulong)-1) >> async);
> +        mxlen =3D 16 << riscv_cpu_mxl(env);
> +        env->mcause =3D cause | ((target_ulong)async << (mxlen - 1));
>          env->mepc =3D env->pc;
>          env->mtval =3D tval;
>          env->mtval2 =3D mtval2;
> --
> 2.43.0
>
>

