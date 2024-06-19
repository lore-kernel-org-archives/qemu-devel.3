Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E5C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 19:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1QG-0004MQ-LG; Wed, 19 Jun 2024 15:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sK1QE-0004M5-Uz
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 15:56:46 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sK1QB-0007AQ-Oy
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 15:56:46 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so1672311fa.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718827001; x=1719431801;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lgMMPd8r+VQYxhOOpA1tj1rJ/KsvcEJINeDP7tjNf8=;
 b=rt/PriYwYbCa2F9NmZ9hNfi6Pv9TXPGwqZSu336qootJ0Bk+wgAqxugEnX8TxkPYMN
 bkaI7t3jNLGUfgKxuRnAXd/zKDp6fcZt1JhFmyrOxIPoUHKQJEwDS2TsCEbQ/PISU/cH
 gmXMJRHW7XQghgUwZIrJdpOsFzrA8nB78RBmVfc8pe4HPK+t4Iokjk+BCmR5JQcW0CJe
 Hu5PLPxSq3u4B1REnYS1HScxPb5DIYUNE9h6GuWRjoRjYh3R/bSTrNcZe0LKC8kZZpNM
 77VsZ90bDK8Bu7tTQ9egmr78ZAaQZuJhutXeU93UND4tKJC5pHyeLqA3NsNypL6TTCm0
 UDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718827001; x=1719431801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lgMMPd8r+VQYxhOOpA1tj1rJ/KsvcEJINeDP7tjNf8=;
 b=kGxUhW0/nOLwVrzTV6lQL07ITbEVHWvhamrOZnfNfU2Fs/Z0ul9N75xfF6T93H8mi7
 AOkZAmWoNnQbML4v6h9Qs7MfVPaKfPXN6AF4QUCa769cY0IpfHp1Kmy+ZVC6chBLpbPr
 4tN/gJbnl15vmJHcjVFIoa6dUiE1PgFFbzob9LSwMIUi4uMhbsaAFtlYrNiiFuIl6wA/
 JLbUJZC+OHc1fbGYFTV4VjGU05CvO6F569caDwPHTDuj6Q12zXcnqXjXt/BAwqWjCjox
 DDGfqKj43YO2p5hDnqkM1/Q6QclLoZop8ZNXI01WhB7JDljbGgPYRfbhqP7kl19Wtpcf
 Yhjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZAC99nF+GOUXiICWysJISnrUNOJp4K0nKQmFArZp5mbEsmXDp7/lqqHkU7KOqiHLCyzcsTJxwy/fR2INpVwnDeAmtr2o=
X-Gm-Message-State: AOJu0Yx7qZtH9hGvYvm6T5sI9FyULvNUWhXx/DULfYPce/fldoK45g4D
 v1CeMfTiYDgOtbUNt1rNpO71Xnsj1330LhiU7jcTQ2w0eEwTHQ73aLz/yZyQsALBjSegNVhxbo6
 B63uGMTIr3dML52moNGy8f9+cYV2i5G3x9l4bkQ==
X-Google-Smtp-Source: AGHT+IHVSKlXq2sWcF3V91W9Km+1Bnv7AZDBDAW+Sf6CFj029srtdVdlRPoTYXrjBwFtufP1F2f5fln1QxfvRANMaVo=
X-Received: by 2002:a2e:2c01:0:b0:2eb:e258:717f with SMTP id
 38308e7fff4ca-2ec3cff2f10mr20188471fa.42.1718827000758; Wed, 19 Jun 2024
 12:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240618112649.76683-1-cleger@rivosinc.com>
In-Reply-To: <20240618112649.76683-1-cleger@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 19 Jun 2024 12:56:29 -0700
Message-ID: <CAHBxVyEF7bX2DEd+XMWcgPm_O3ABKAzymNhZbzcrhBoAqf09Jg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: fix instructions count handling in
 icount mode
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=atishp@rivosinc.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 18, 2024 at 4:27=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> When icount is enabled, rather than returning the virtual CPU time, we
> should return the instruction count itself. Add an instructions bool
> parameter to get_ticks() to correctly return icount_get_raw() when
> icount_enabled() =3D=3D 1 and instruction count is queried. This will mod=
ify
> the existing behavior which was returning an instructions count close to
> the number of cycles (CPI ~=3D 1).
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>
> ---
>
> v2:
>  - Apply checkpatch and fixed missing braces
>

As the changes were minor, you can keep the RB tag. Anyways,

Reviewed-by: Atish Patra <atishp@rivosinc.com>

> ---
>  target/riscv/csr.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 58ef7079dc..b8915e32a2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -762,14 +762,18 @@ static RISCVException write_vcsr(CPURISCVState *env=
, int csrno,
>  }
>
>  /* User Timers and Counters */
> -static target_ulong get_ticks(bool shift)
> +static target_ulong get_ticks(bool shift, bool instructions)
>  {
>      int64_t val;
>      target_ulong result;
>
>  #if !defined(CONFIG_USER_ONLY)
>      if (icount_enabled()) {
> -        val =3D icount_get();
> +        if (instructions) {
> +            val =3D icount_get_raw();
> +        } else {
> +            val =3D icount_get();
> +        }
>      } else {
>          val =3D cpu_get_host_ticks();
>      }
> @@ -804,14 +808,14 @@ static RISCVException read_timeh(CPURISCVState *env=
, int csrno,
>  static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
>                                        target_ulong *val)
>  {
> -    *val =3D get_ticks(false);
> +    *val =3D get_ticks(false, (csrno =3D=3D CSR_INSTRET));
>      return RISCV_EXCP_NONE;
>  }
>
>  static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
>                                         target_ulong *val)
>  {
> -    *val =3D get_ticks(true);
> +    *val =3D get_ticks(true, (csrno =3D=3D CSR_INSTRETH));
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -875,11 +879,11 @@ static RISCVException write_mhpmcounter(CPURISCVSta=
te *env, int csrno,
>      int ctr_idx =3D csrno - CSR_MCYCLE;
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
>      uint64_t mhpmctr_val =3D val;
> +    bool instr =3D riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>
>      counter->mhpmcounter_val =3D val;
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        counter->mhpmcounter_prev =3D get_ticks(false);
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> +        counter->mhpmcounter_prev =3D get_ticks(false, instr);
>          if (ctr_idx > 2) {
>              if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
>                  mhpmctr_val =3D mhpmctr_val |
> @@ -902,12 +906,12 @@ static RISCVException write_mhpmcounterh(CPURISCVSt=
ate *env, int csrno,
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
>      uint64_t mhpmctr_val =3D counter->mhpmcounter_val;
>      uint64_t mhpmctrh_val =3D val;
> +    bool instr =3D riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>
>      counter->mhpmcounterh_val =3D val;
>      mhpmctr_val =3D mhpmctr_val | (mhpmctrh_val << 32);
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        counter->mhpmcounterh_prev =3D get_ticks(true);
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> +        counter->mhpmcounterh_prev =3D get_ticks(true, instr);
>          if (ctr_idx > 2) {
>              riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
>          }
> @@ -926,6 +930,7 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVStat=
e *env, target_ulong *val,
>                                           counter->mhpmcounter_prev;
>      target_ulong ctr_val =3D upper_half ? counter->mhpmcounterh_val :
>                                          counter->mhpmcounter_val;
> +    bool instr =3D riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>
>      if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>          /*
> @@ -946,9 +951,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVStat=
e *env, target_ulong *val,
>       * The kernel computes the perf delta by subtracting the current val=
ue from
>       * the value it initialized previously (ctr_val).
>       */
> -    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> -        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        *val =3D get_ticks(upper_half) - ctr_prev + ctr_val;
> +    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
> +        *val =3D get_ticks(upper_half, instr) - ctr_prev + ctr_val;
>      } else {
>          *val =3D ctr_val;
>      }
> --
> 2.45.2
>

