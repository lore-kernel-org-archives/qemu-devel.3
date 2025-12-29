Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F35E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBO7-0000vq-31; Mon, 29 Dec 2025 06:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBNt-0000r3-01
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:25:57 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBNm-0006zX-Mr
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:25:56 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so10699479a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007548; x=1767612348; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgtZar7dYWRCX9WcBM4Q6J2jBm+o7esigXCIUlS8v6Q=;
 b=c/lC5zS6uTcPjsvm42MVyjBpBU98MmAq49rHKdizLlr6h0Nw6nHneL1dZaE15vQUlq
 CE4hDEEIX/GBXWeejbHXpr8LOTLZOmfloiHRDGg7ayT74RxhKB9lE1tli5148AQ7NsTT
 iaj4qQEgqPG2XhjxqPr/2fILGAj2ItuQHUmO6SuZX7hagiWqNnoriWKneSvyWmCQX3em
 O4INj/Gqrutf6hiXnj4drt/ioC7HKYu9ELzHAbFM7QJMJi8NTCUIMfGuDe878fVeOICg
 KlaBtkxa3DUmIW6/A2KtQZMcbum+T2AcmRZi5NzsmUCItcUlP+6GiJmhE09tAXPmyuRe
 bMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007548; x=1767612348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jgtZar7dYWRCX9WcBM4Q6J2jBm+o7esigXCIUlS8v6Q=;
 b=GjE5S+0O+6zJ/NlfwLpYhGRLwG72uWbBDooNXENawel8QPgXmw7aUOiCl1KkEPG0jh
 GUSDg9dg+aHzHLslxhXDCKTL8HThLZmAeiJhTs/IpqzUhcYxZCj8Hc4jWAD1qU4wyjg0
 9ZDNPecnmoVS73PSwfxxH9kRPDnDqHErr1eOCEskhFPLLpK4YY4f5UKYeFHAFfapbRZt
 B2Iz8W467FQIcloEXSJbR+7DynKx4+ZX60LrZFy3zYFaODVkI9ILJlY0jhG1p5IENbIi
 ksLu5dS6DGwMQQmqeJDpnkSMfqDsbnoQa/XmtjsAb0nVEBSWNyGWkUGHidjhr9h9Ra4y
 EEaA==
X-Gm-Message-State: AOJu0YzOgz1hdT2TIt2OElO50L8dirGGPf8iYQ2w9mResb+xwjFXhO5V
 fqZ8Ncn16rn0Tf7yzCUX1LpVKSm0WHUSjR5xWRBKAM7ntLfqdOCPJq3DJvKvFqzVD8r7PGwi0Lk
 wZJRkDZ05BtzgYVz5EEeS5JY5aN0Z0TXzv2fX1D6BKA==
X-Gm-Gg: AY/fxX7tYgKvZm9u06d+bKx8E+qu1A8eMBymvjSjdciifYX0Ofr6AM7i8bf4gvhPlgS
 btgw9XH0aCC6iHCfETW3RQIuJPOypSL9VuYm/SkCNFHyJiFrJUBLoBFlEwR17xLvQuAZNb0vZMs
 JWdgL6vLjYzkt1cibF2qfN6jFo2flRY8f+Uza1FMDVlHLWT1WJhepqarXT909qi8THA/DsBTWY9
 D9JiYWSxlsl8sXTA4Ldo4C6vCNPv4CFaivpEppKtA4TUHh/jZYlqEWsZas65YzMOuETA6cvDwvf
 ujOYHl8HhY/g2/kUTz2NVIv+JUgeRs3OAH7K7jo=
X-Google-Smtp-Source: AGHT+IE2mC6EQQU8GmfZKCWH4xPG09fyUx8wacD8S/2JLbVUzf96JKWgzlsKYMqxDaL3+/15x9RAJs3aw23XyDyfAlc=
X-Received: by 2002:a17:907:608c:b0:b76:e346:f74 with SMTP id
 a640c23a62f3a-b8036f637f2mr3212693366b.16.1767007548065; Mon, 29 Dec 2025
 03:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20251224163304.91384-1-philmd@linaro.org>
 <20251224163304.91384-2-philmd@linaro.org>
In-Reply-To: <20251224163304.91384-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:25:22 +0200
X-Gm-Features: AQt7F2plI0VzZEWbDrmAM2HK8cJrfiMCsWaFEUghYiSJWcCdlQnBhaN-ZGczkRM
Message-ID: <CAAjaMXYj4+X=sfwTLgkmDRs2V9+Ls6ppYw3yrsLuEt+wkFXqGg@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/rx: Use little-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Dec 24, 2025 at 6:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> We only build the RX target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
>
> Mechanical change running:
>
>   $ tgt=3Drx; \
>     end=3Dle; \
>     for op in data mmuidx_ra; do \
>       for ac in uw sw l q; do \
>         sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>       for ac in w l q; do \
>         sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  target/rx/helper.c    | 14 +++++++-------
>  target/rx/op_helper.c |  6 +++---
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/target/rx/helper.c b/target/rx/helper.c
> index e9a7aaf610d..83cd491eb4a 100644
> --- a/target/rx/helper.c
> +++ b/target/rx/helper.c
> @@ -68,10 +68,10 @@ void rx_cpu_do_interrupt(CPUState *cs)
>          qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
>      } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
>          env->isp -=3D 4;
> -        cpu_stl_data(env, env->isp, save_psw);
> +        cpu_stl_le_data(env, env->isp, save_psw);
>          env->isp -=3D 4;
> -        cpu_stl_data(env, env->isp, env->pc);
> -        env->pc =3D cpu_ldl_data(env, env->intb + env->ack_irq * 4);
> +        cpu_stl_le_data(env, env->isp, env->pc);
> +        env->pc =3D cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
>          env->psw_ipl =3D env->ack_ipl;
>          cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>          qemu_set_irq(env->ack, env->ack_irq);
> @@ -82,14 +82,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
>          const char *expname =3D "unknown exception";
>
>          env->isp -=3D 4;
> -        cpu_stl_data(env, env->isp, save_psw);
> +        cpu_stl_le_data(env, env->isp, save_psw);
>          env->isp -=3D 4;
> -        cpu_stl_data(env, env->isp, env->pc);
> +        cpu_stl_le_data(env, env->isp, env->pc);
>
>          if (vec < 0x100) {
> -            env->pc =3D cpu_ldl_data(env, 0xffffff80 + vec * 4);
> +            env->pc =3D cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
>          } else {
> -            env->pc =3D cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
> +            env->pc =3D cpu_ldl_le_data(env, env->intb + (vec & 0xff) * =
4);
>          }
>
>          if (vec =3D=3D 30) {
> diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
> index 2b190a4b2cf..ca3e9e85fc7 100644
> --- a/target/rx/op_helper.c
> +++ b/target/rx/op_helper.c
> @@ -217,20 +217,20 @@ void helper_scmpu(CPURXState *env)
>  static uint32_t (* const cpu_ldufn[])(CPUArchState *env,
>                                       abi_ptr ptr,
>                                       uintptr_t retaddr) =3D {
> -    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
> +    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
>  };
>
>  static uint32_t (* const cpu_ldfn[])(CPUArchState *env,
>                                       abi_ptr ptr,
>                                       uintptr_t retaddr) =3D {
> -    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
> +    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
>  };
>
>  static void (* const cpu_stfn[])(CPUArchState *env,
>                                   abi_ptr ptr,
>                                   uint32_t val,
>                                   uintptr_t retaddr) =3D {
> -    cpu_stb_data_ra, cpu_stw_data_ra, cpu_stl_data_ra,
> +    cpu_stb_data_ra, cpu_stw_le_data_ra, cpu_stl_le_data_ra,
>  };
>
>  void helper_sstr(CPURXState *env, uint32_t sz)
> --
> 2.52.0
>

