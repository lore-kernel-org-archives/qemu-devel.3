Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DCED3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaB2f-0007PA-Ge; Mon, 29 Dec 2025 06:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB2d-0007MB-E3
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:03:59 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB2b-0003CE-FC
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:03:59 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7636c96b9aso1627349966b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006236; x=1767611036; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyJLARG22ua/FQ0hvU8tCbRtxU2Bjse8dDsXtsofhy8=;
 b=NwEByJG27d5dyG3H2lSbD0rbkfnVKwEYu5BZkU6+m7S4pQInm0+OpPyF7wpA/ebwwm
 uFgw6pmpJz/DSnplbu97BH+EnngR4bab6HOtMZrMcLpHYkYL5tF+z7Hm0gngwTed1taD
 wnccFlxO/mQF75Pk1tARU6UixuS8kDFSbMAbi2aLgPw3JYHLadtVFpjEdPttlgWx8Wyf
 bhGsV5RIQTLQeO3hWjacF/XWwZR7wXM4JvZ1us2ESb8hyEvemmwIqJ5iTAppTqQM8zH0
 yjOLSAhj2UvsFihPiG1ljKfCUR2oLABosInh+PA28HdGDtvlzrGkX+utVffTCm9V6g0A
 BGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006236; x=1767611036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyJLARG22ua/FQ0hvU8tCbRtxU2Bjse8dDsXtsofhy8=;
 b=WrfrqC6tlTRp61BQ+mKZxw2u72hDchO8Qry0dSac/NDudPiWTSwQjn2X0t7m2owjlg
 J1JOP7/r8qKPt1g5TXUrHhQbhGHiBDq/hIwiVkg3fk3TS4+7Fgle7A9aC4ru+Qu5BSnR
 TyCgnvTDNiAQx43qUTs8ATtzwaLMK4+AamQbJKP8ydn1vaPY0xm602HsGqsI94CEGFRG
 Yd+G227TiAYoePrkNHJzfzyYkzsGYje+M90AwM3vlxgDt6DGALRpwkBgR58jJ112KoYx
 tMTFExhjjIzAivCInshEOoQbKSgVjH4Ra8lhfpW6WmPgUnc8QEiod1zA6ZBkRF739mxh
 jEJg==
X-Gm-Message-State: AOJu0YyJ/dX/JP1gmcpn/QFhMhoktfjDkWuFY1576T0+8kKr5kp44VEY
 8ks1yo886xoc4gmdn9C93rTcqAESwXqTcgdEfPfpkxREfJPDK2D24zTZZEFgIQ7RqS5Y4TvOhIH
 oeAOc64rYLOsCJg8l4uo5Izo7MDr7rEWHq4x6vwoD/w==
X-Gm-Gg: AY/fxX4bdbaG9aLwq2wSgunyMSitFZcMOxK+8mOhT/2weoeGi1B/Dfa4VZztHauDhVo
 bNagMFciCUZhVh3xAnD12LIfxx+L9fCHWLuaGjCMiqPi7fdb7erw9NO/K9LF/y41DnXH9d0Y5Pg
 6ve3k2odr9fTKN+iQA8/ZSMi75nMWnYbLdYewDr53OmFs/SLUTWJJTMLdTHwpMLTkq1+mEcNvcg
 ZfbdllzjwQpijougWQp34XRqXqQ/mQA5/Ezr5NngjvF48NX32eQ8U7Xfo126KE1T8VVQ0w4NlO/
 qFIbbJsi4Wgab3Q5Ohg/Zp9/15t7Lxwv8ywSMevYy4LAJXlxcQ==
X-Google-Smtp-Source: AGHT+IFW4JLaaFaoDeDM4rCrrAbr3sJVIjfMtTM4ZQVduD3YTYBqYahS858aGRdyLeweQ/WVwIu3G8xkVypcXFhIkfo=
X-Received: by 2002:a17:907:868e:b0:b76:4c8f:2cd8 with SMTP id
 a640c23a62f3a-b8037233e75mr3022213866b.55.1767006235836; Mon, 29 Dec 2025
 03:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-3-philmd@linaro.org>
In-Reply-To: <20251224162036.90404-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:03:29 +0200
X-Gm-Features: AQt7F2otN2BjjRmNgEbKRlxFaAFMLNrnjmSbBrGnTOKOuSwmf_mzFrU0gBAPHiw
Message-ID: <CAAjaMXa2pVMEOCPpy8+XUjNgKiXdnVdSTgkSmb_ZTh1F+DHCGw@mail.gmail.com>
Subject: Re: [PATCH 2/8] target/s390x: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, Dec 24, 2025 at 6:20=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The S390x architecture uses big endianness. Directly use
> the big-endian LD/ST API.
>
> Mechanical change running:
>
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' target/s390x/);
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/s390x/cpu-system.c      |  2 +-
>  target/s390x/kvm/kvm.c         |  8 ++++----
>  target/s390x/mmu_helper.c      |  3 ++-
>  target/s390x/tcg/excp_helper.c | 16 ++++++++--------
>  target/s390x/tcg/mem_helper.c  |  5 +++--
>  5 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
> index f3a9ffb2a27..b0c59b5676e 100644
> --- a/target/s390x/cpu-system.c
> +++ b/target/s390x/cpu-system.c
> @@ -63,7 +63,7 @@ static void s390_cpu_load_normal(CPUState *s)
>      uint64_t spsw;
>
>      if (!s390_is_pv()) {
> -        spsw =3D ldq_phys(s->as, 0);
> +        spsw =3D ldq_be_phys(s->as, 0);
>          cpu->env.psw.mask =3D spsw & PSW_MASK_SHORT_CTRL;
>          /*
>           * Invert short psw indication, so SIE will report a specificati=
on
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 916dac1f14e..89911f356e4 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -1667,10 +1667,10 @@ static int handle_oper_loop(S390CPU *cpu, struct =
kvm_run *run)
>      CPUState *cs =3D CPU(cpu);
>      PSW oldpsw, newpsw;
>
> -    newpsw.mask =3D ldq_phys(cs->as, cpu->env.psa +
> -                           offsetof(LowCore, program_new_psw));
> -    newpsw.addr =3D ldq_phys(cs->as, cpu->env.psa +
> -                           offsetof(LowCore, program_new_psw) + 8);
> +    newpsw.mask =3D ldq_be_phys(cs->as, cpu->env.psa +
> +                              offsetof(LowCore, program_new_psw));
> +    newpsw.addr =3D ldq_be_phys(cs->as, cpu->env.psa +
> +                              offsetof(LowCore, program_new_psw) + 8);
>      oldpsw.mask  =3D run->psw_mask;
>      oldpsw.addr  =3D run->psw_addr;
>      /*
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 3b1e75f7833..8c87b30a8e3 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -44,7 +44,8 @@ static void trigger_access_exception(CPUS390XState *env=
, uint32_t type,
>      } else {
>          CPUState *cs =3D env_cpu(env);
>          if (type !=3D PGM_ADDRESSING) {
> -            stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code=
), tec);
> +            stq_be_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_c=
ode),
> +                        tec);
>          }
>          trigger_pgm_exception(env, type);
>      }
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helpe=
r.c
> index c6641280bc6..868efca3221 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -55,8 +55,8 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *=
env, uint32_t dxc,
>      g_assert(dxc <=3D 0xff);
>  #if !defined(CONFIG_USER_ONLY)
>      /* Store the DXC into the lowcore */
> -    stl_phys(env_cpu(env)->as,
> -             env->psa + offsetof(LowCore, data_exc_code), dxc);
> +    stl_be_phys(env_cpu(env)->as,
> +                env->psa + offsetof(LowCore, data_exc_code), dxc);
>  #endif
>
>      /* Store the DXC into the FPC if AFP is enabled */
> @@ -72,8 +72,8 @@ G_NORETURN void tcg_s390_vector_exception(CPUS390XState=
 *env, uint32_t vxc,
>      g_assert(vxc <=3D 0xff);
>  #if !defined(CONFIG_USER_ONLY)
>      /* Always store the VXC into the lowcore, without AFP it is undefine=
d */
> -    stl_phys(env_cpu(env)->as,
> -             env->psa + offsetof(LowCore, data_exc_code), vxc);
> +    stl_be_phys(env_cpu(env)->as,
> +                env->psa + offsetof(LowCore, data_exc_code), vxc);
>  #endif
>
>      /* Always store the VXC into the FPC, without AFP it is undefined */
> @@ -651,10 +651,10 @@ void monitor_event(CPUS390XState *env,
>                     uint8_t monitor_class, uintptr_t ra)
>  {
>      /* Store the Monitor Code and the Monitor Class Number into the lowc=
ore */
> -    stq_phys(env_cpu(env)->as,
> -             env->psa + offsetof(LowCore, monitor_code), monitor_code);
> -    stw_phys(env_cpu(env)->as,
> -             env->psa + offsetof(LowCore, mon_class_num), monitor_class)=
;
> +    stq_be_phys(env_cpu(env)->as,
> +                env->psa + offsetof(LowCore, monitor_code), monitor_code=
);
> +    stw_be_phys(env_cpu(env)->as,
> +                env->psa + offsetof(LowCore, mon_class_num), monitor_cla=
ss);
>
>      tcg_s390_program_interrupt(env, PGM_MONITOR, ra);
>  }
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.=
c
> index 24675fc818d..0c7e099df21 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -958,8 +958,9 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0=
, uint32_t r1, uint32_t r2)
>  inject_exc:
>  #if !defined(CONFIG_USER_ONLY)
>      if (exc !=3D PGM_ADDRESSING) {
> -        stq_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, trans_ex=
c_code),
> -                 env->tlb_fill_tec);
> +        stq_be_phys(env_cpu(env)->as,
> +                    env->psa + offsetof(LowCore, trans_exc_code),
> +                    env->tlb_fill_tec);
>      }
>      if (exc =3D=3D PGM_PAGE_TRANS) {
>          stb_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, op_acces=
s_id),
> --
> 2.52.0
>

