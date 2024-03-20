Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0B1C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmo4Y-0008FX-JT; Wed, 20 Mar 2024 01:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmo4P-0008D4-NJ; Wed, 20 Mar 2024 01:00:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmo4N-0001Ph-2V; Wed, 20 Mar 2024 01:00:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e88e4c8500so99793b3a.2; 
 Tue, 19 Mar 2024 22:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710910848; x=1711515648; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpOWB7Meyyi+PEQciVfates0LsJ+rJAWX/JqT+qExl0=;
 b=EYj5nTi3zg2dzOkGSaXmKonzUHFlGb0lGirFoO4FBr2XPoD+UNmPHURumMq/eKeZcO
 U/f6WJ3UoRA7xe+fYWTLXogP1Bs+48sRpYkz7UAusbsm+CEYW7TXkvl6XR39fW4jt1At
 Fqm2KD7ypGMILLPCt1Lno3Fy2k9+kKa+1VG0DtgZhFUpqOinikqLDzgZFIvt+OfsiSXi
 rCrDGcJuuVr/GMUCgqTFPftf9YuTiPBO9D9YSN+qQ7PQV4l87xlrLqbNRF6qjSrGgGMa
 qWIW8ztgnqTuNbLW3C8Zs3nQzqoFbblVc1kX1W0KdyixT382uzRYaFlzo8zm71/Eqdt1
 dOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710910848; x=1711515648;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IpOWB7Meyyi+PEQciVfates0LsJ+rJAWX/JqT+qExl0=;
 b=S3Tg+wgaCBEELSlVJuX7hGUfJdUAk8+5OhwT1VxY6ac0GxaJqZ0N6im7JREVwR738R
 CXkxsNOEU7Bm3AVaxkkzdvm+IM94TwBb/vHJ/bJP9a+hrcp9+l9mIaigcaVqjl/G6UrD
 oUoUkb/h4b/pa/o63Fx8vvULPS+tQ+ckXJuk6Viw1eRKPpe4kVeRe5/RKUt/uSU3Y4r/
 tLuwdOwEE9OhyN6MxVBXsgI+t+jzLbimMUy7mmekSo2QiJefF3MccPT098UJLL+FdFj7
 wnSzbBKs0bsRi/36wS13SOykHu+BVHy9Bci+v+bS95AK4uwawuYtdRXjAKBEkDnMsQo9
 oXYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVemLIN2Ba4abqq/girQ3EDVDNOZLfni6mApvgywiFJeRN+8ZdGOmxBPlBQAA5oguuMo1m6xv1Lv8ntKOAY1y3d+dSZIGIYzzACielFvP5TvC/xkTG77fF9FUxgoIerFbZYT/Vu3CaEE/HlfiF3NqsTPIoElu9Ibj5ckxbm8pIvUwcApduyA==
X-Gm-Message-State: AOJu0YxJEf4kPcCe2mojUyUhWd84a6KfQN4XRAXgVXc+tU/B4uq891nl
 GKpbAAUH2lI/ba/TJdES/sCTpjCcXG9+3VUrCAbroWy5rNH2ZUZH
X-Google-Smtp-Source: AGHT+IHmBuWNXIgQPrrQT9ZywdJYkgxE8mIchY1DPXFQExfq7vuQwv8FovBFbRVNxBuit/2OQ97QLQ==
X-Received: by 2002:a05:6a21:3406:b0:1a3:6940:82ea with SMTP id
 yn6-20020a056a21340600b001a3694082eamr6597267pzb.31.1710910848031; 
 Tue, 19 Mar 2024 22:00:48 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 ey1-20020a056a0038c100b006e6b12d650asm10675761pfb.31.2024.03.19.22.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 22:00:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 15:00:42 +1000
Message-Id: <CZYB9YB3MYGQ.4T8I8FJO64AO@wheely>
Cc: <qemu-s390x@nongnu.org>, "Richard Henderson"
 <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>,
 <qemu-arm@nongnu.org>, <qemu-riscv@nongnu.org>, "Anton Johansson"
 <anjo@rev.ng>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH-for-9.1 18/27] target/ppc: Convert to
 TCGCPUOps::get_cpu_state()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240319154258.71206-1-philmd@linaro.org>
 <20240319154258.71206-19-philmd@linaro.org>
In-Reply-To: <20240319154258.71206-19-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Mar 20, 2024 at 1:42 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state(),
> unifying with the method declared in target/ppc/helper_regs.c.

Looks okay AFAIKS.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/ppc/cpu.h         | 16 +++-------------
>  target/ppc/cpu_init.c    |  1 +
>  target/ppc/helper_regs.c | 13 +++++++------
>  3 files changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index ced4e53024..6aa18db335 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2716,19 +2716,9 @@ void cpu_write_xer(CPUPPCState *env, target_ulong =
xer);
>   */
>  #define is_book3s_arch2x(ctx) (!!((ctx)->insns_flags & PPC_SEGMENT_64B))
> =20
> -#define TARGET_HAS_CPU_GET_TB_CPU_STATE
> -
> -#ifdef CONFIG_DEBUG_TCG
> -void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
> -                          uint64_t *cs_base, uint32_t *flags);
> -#else
> -static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
> -                                        uint64_t *cs_base, uint32_t *fla=
gs)
> -{
> -    *pc =3D env->nip;
> -    *cs_base =3D 0;
> -    *flags =3D env->hflags;
> -}
> +#ifdef CONFIG_TCG
> +void ppc_get_cpu_state(CPUPPCState *env, vaddr *pc,
> +                       uint64_t *cs_base, uint32_t *flags);
>  #endif
> =20
>  G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 464e91faa2..673559b444 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7362,6 +7362,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops =3D=
 {
>  static const TCGCPUOps ppc_tcg_ops =3D {
>      .initialize =3D ppc_translate_init,
>      .restore_state_to_opc =3D ppc_restore_state_to_opc,
> +    .get_cpu_state =3D ppc_get_cpu_state,
> =20
>  #ifdef CONFIG_USER_ONLY
>      .record_sigsegv =3D ppc_cpu_record_sigsegv,
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 25258986e3..e62591067c 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -217,25 +217,26 @@ void hreg_update_pmu_hflags(CPUPPCState *env)
>      env->hflags |=3D hreg_compute_pmu_hflags_value(env);
>  }
> =20
> -#ifdef CONFIG_DEBUG_TCG
> -void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
> -                          uint64_t *cs_base, uint32_t *flags)
> +#ifdef CONFIG_TCG
> +void ppc_get_cpu_state(CPUPPCState *env, vaddr *pc,
> +                       uint64_t *cs_base, uint32_t *flags)
>  {
>      uint32_t hflags_current =3D env->hflags;
> -    uint32_t hflags_rebuilt;
> =20
>      *pc =3D env->nip;
>      *cs_base =3D 0;
>      *flags =3D hflags_current;
> =20
> -    hflags_rebuilt =3D hreg_compute_hflags_value(env);
> +#ifdef CONFIG_DEBUG_TCG
> +    uint32_t hflags_rebuilt =3D hreg_compute_hflags_value(env);
>      if (unlikely(hflags_current !=3D hflags_rebuilt)) {
>          cpu_abort(env_cpu(env),
>                    "TCG hflags mismatch (current:0x%08x rebuilt:0x%08x)\n=
",
>                    hflags_current, hflags_rebuilt);
>      }
> -}
>  #endif
> +}
> +#endif /* CONFIG_TCG */
> =20
>  void cpu_interrupt_exittb(CPUState *cs)
>  {


