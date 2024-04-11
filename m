Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF31FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 17:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruy8H-00006z-3R; Thu, 11 Apr 2024 13:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1ruy8F-00006K-B9
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 13:22:39 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1ruy8D-0005RP-DW
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 13:22:39 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516db2214e6so114665e87.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712856155; x=1713460955;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mU/v67jgVY3bfXd6+1KCyb91Qhu805+BTHsSP3Tb/p0=;
 b=H2W4izTN6wIVPndCrENqjtuOAs3Bf8dkmzDRWRAtXC/jYWK8D8IAO1naLCFm/qqu9k
 JhzliKwrAxX9uELFyvne+rbTN3qmkw7NKZNqWsjqjT/bfaVRFgb8ogxja0x4CUldF5JP
 s6QcV0Bk6GPjjtz3cAHB1p/3r54/kX28Mc7YTBK/kdKxbKH1Gm9HzvA5hPz20WtqNetv
 PVqwZJHPTkf7fFb/EQmdbNk/du199Odhi92Lmr+05vEKVV3rIebVf0P3/HhQy5/BhfWo
 S4i0O874QfCxoggCU0jvCy362MdI9b9ma1ps2g9R4muX00FdhHiZ0fOVUWfFXA0nTfP4
 Vuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712856155; x=1713460955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mU/v67jgVY3bfXd6+1KCyb91Qhu805+BTHsSP3Tb/p0=;
 b=ohV9ZJWtKdweP2IMG0g8MzrQpGniDO7J9xDg6P4axYt9f7XHCO4U4IDwspIDXA7t4l
 p/ZQFExQBvt7kS4KRj4Fvo39l6sLXD+KcsoGSYqM/rI4DH4rD3WsfcXSVZ/nS0jt6DL/
 YT5FL5QKE4WsTVBhbs3f+OWFbvQvhhgbxoNl9cyufcFgijsWUkLIIu5p70BSXxpmuK/P
 /IPkvEL/TPEXX1NpP0aX1abTT6gT+a2tiIeCxhNK2BgjAEtABuTnsjRlxh+yFSF3Ra2k
 kjcLO54ny8hFEFVMsVqASponeO79aVw6WFSfMax9mrmrY86GoETKFbEHa02VzSBuCh7I
 fuqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeWThhQtFqHmW1b3uVMuc2tNcVyaqvRgU6jeFFfglYq2bPd8ApI+fmFsbF4PbEsYCNF5rLg0V6VXhIJHWiImpYmiOGQW0=
X-Gm-Message-State: AOJu0YyMKozxRBnKsJEc9rs4OjFjMNKa2Zyv3/mcxUPByI7IGuwS3rxA
 kv3zI5J6nAl1xgqs/ycyvbeYc+WrFZv/nwCP7PZX8PBtH0E+SECs96X51XM4tNVrsHJ+vrofOP8
 vFQo08FWtxuKxw/GxXy6QhZEuzdxqApwAuxzoqw==
X-Google-Smtp-Source: AGHT+IEa1V2yr/k/lyAO8vJISaM0wANGgNWBLam5LbpZRMIY4Rg4BPgiqBldXqJsQ6oQbQMyFg31WdaNFcnXc9AlTAU=
X-Received: by 2002:a05:651c:1994:b0:2d8:394c:6e7e with SMTP id
 bx20-20020a05651c199400b002d8394c6e7emr228636ljb.15.1712856154885; Thu, 11
 Apr 2024 10:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240411113406.1301906-1-cleger@rivosinc.com>
In-Reply-To: <20240411113406.1301906-1-cleger@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Thu, 11 Apr 2024 10:22:23 -0700
Message-ID: <CAHBxVyG-_HeTBx=R8NyPvGL3wS8cVH=R_f9pV469LW=a6KRvZw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix instructions count handling in icount
 mode
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 11, 2024 at 4:34=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
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


Reviewed-by: Atish Patra <atishp@rivosinc.com>

