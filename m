Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05698C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1GuN-0003dm-LZ; Sun, 28 Apr 2024 22:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GuI-0003cs-7J; Sun, 28 Apr 2024 22:38:18 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GuF-0004Iv-Vu; Sun, 28 Apr 2024 22:38:17 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7efa7296beeso1058997241.3; 
 Sun, 28 Apr 2024 19:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714358294; x=1714963094; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eVXmK6+2m9WwEHiwS+PKrCL35CniEAxLboqlfKAv6o=;
 b=N1sSJdvYIifTjmX9wv3z4U6nKddJ0LOKPtK8d5DyRmBLp5egFHR5vEoZmI0fL7ggp6
 LWkmjDh9AYJHs6i3uic6antnVIPHX9ho5v+i4RQ5JYK77DS8t5Jjk0/4YKMBXWJyrpBT
 aaH1h8jKvwFAlJNRwZ6EckYMAIvKxrfAO4ERRSA8TZel40/dABI/fDrSNDz+sd5Y8+MD
 pNQfwo1GSgdNrmxwedwuqjDXmwXbSS6F6sl6K+/FclF6nLO/xA5EhZ1zKIzHKBFe7kA5
 QsM7pI2Z7I7LS2zFqNYDXVgmpxPFJBubw7ADX6steoKrv0WIYVLG6z2e6+QIWIijSmKQ
 FHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714358294; x=1714963094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eVXmK6+2m9WwEHiwS+PKrCL35CniEAxLboqlfKAv6o=;
 b=ZABCqFTMA9SkPp6GRrEGnWxgbEqImb3hrnryeU7T7l9JLrXsm57am6GVy9uLO7S+Tr
 dGzmTmiIaHva1+I0QcXWTNXOc3SWFxqOeyWtw/8CZQuP3lFE+iXqfMIUQh7id9KxuG3Q
 QdI/0Vy5nh0AE1eku24z6F6GarBP4sSoofMmjOj2pWQxGj0fpEc9/hGlfbbdW8xV/8de
 qWvZvgWqoObsVyAXSgR7YBVGsS4AP3F57XsACgSrUCycousdtaQDMLNiLpsMPW5Sz0yY
 nEJJtWgHvkT0fC4+kQm/ktmoiXAc8VSQyypLF8IgtqTXyqAS3m+wueJdIdDJnzCpBacd
 OZsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8auGl6k6gjrX+V/EEehYGoEea/68fKN73cMLvxxmzISJG7CDerl2Ja16ZqEWvugRxN6lvSj9gSCvJRmhpYttfPbFqg1c=
X-Gm-Message-State: AOJu0YzALZvIZ4i1kZ40jf+kVm3ZiFEn+4qNzVuiuN8sERUa9luYykIG
 jyaKK6PtINylPo+31cAGjIkDPwKBVPgv+Dm4a6fSLleoMvZw+uVx28v8mIJhf1Mr8wLkj9yzq2a
 dx7Cg0Tod2N3DB/pKMCVULqKHRSI=
X-Google-Smtp-Source: AGHT+IFHVmMYPtz/c5B3MTtby5HSXqW9NO1xIjkeDly4myiUU/wVWOzB9O+3AsjGi5D4nmZoQAqOa+ZD7cM4Dl8muTs=
X-Received: by 2002:a67:e213:0:b0:47a:2f34:db07 with SMTP id
 g19-20020a67e213000000b0047a2f34db07mr8123070vsa.30.1714358294107; Sun, 28
 Apr 2024 19:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240411113406.1301906-1-cleger@rivosinc.com>
In-Reply-To: <20240411113406.1301906-1-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:37:48 +1000
Message-ID: <CAKmqyKPSEF0vsfq2Zy9D9YXaiaH0iELAAWrTZnA5BRvd8Xky=w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix instructions count handling in icount
 mode
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Atish Patra <atishp@rivosinc.com>
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

On Thu, Apr 11, 2024 at 9:34=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
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

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> ---
>  target/riscv/csr.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444f..5f1dcee102 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -762,14 +762,17 @@ static RISCVException write_vcsr(CPURISCVState *env=
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
> +        if (instructions)
> +            val =3D icount_get_raw();
> +        else
> +            val =3D icount_get();
>      } else {
>          val =3D cpu_get_host_ticks();
>      }
> @@ -804,14 +807,14 @@ static RISCVException read_timeh(CPURISCVState *env=
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
> @@ -875,11 +878,11 @@ static RISCVException write_mhpmcounter(CPURISCVSta=
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
> @@ -902,12 +905,12 @@ static RISCVException write_mhpmcounterh(CPURISCVSt=
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
> @@ -926,6 +929,7 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVStat=
e *env, target_ulong *val,
>                                           counter->mhpmcounter_prev;
>      target_ulong ctr_val =3D upper_half ? counter->mhpmcounterh_val :
>                                          counter->mhpmcounter_val;
> +    bool instr =3D riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
>
>      if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>          /*
> @@ -946,9 +950,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVStat=
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
> 2.43.0
>
>

