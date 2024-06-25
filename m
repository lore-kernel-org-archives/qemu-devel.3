Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41641C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 01:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLvHc-0000yG-GE; Mon, 24 Jun 2024 21:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sLvHa-0000xS-5M; Mon, 24 Jun 2024 21:47:42 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sLvHY-0000K1-Cp; Mon, 24 Jun 2024 21:47:41 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80f6efd265bso835995241.2; 
 Mon, 24 Jun 2024 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719280058; x=1719884858; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3+2dI9jw2wIxX3Q1wIulYvWEsyEGuowr8n1zlrbdVY=;
 b=ZYBS9GiZ5Vh5ii5xG7fK1QzYUsiOrb3RBxwJuDYap7TpK1PYRvL+Z1+4VQMKgAFoyh
 vKC+8swkf0dEMgR9xBwMdJEhFD44WcaFDMHrdlGDgKPeNDESIW+hp1JkV3gnxth/Ipau
 0+Xn3Z+NF7NeIGlxsOzEhWXzG7NIDPJGyde1mqEW8ZTlhaN7ZomlkZv/MANxWulIVQYn
 wP4zRIl8gyElBcKUQHTNSW+h7JOR70L8cTKPfzZUzydkh/1gNzkfVkn8FGCQbsy/dcAE
 Xvs4YA2LCiJq9r2KaPTQjrIJewMI6eSB4CHQGkzCFwrrXXueaPGJQydlFA1JPQaJd/ZG
 blcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719280058; x=1719884858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3+2dI9jw2wIxX3Q1wIulYvWEsyEGuowr8n1zlrbdVY=;
 b=MtkxQkFyz/Tji9qV0r3jCHClidVM1y1X9tsrgLR/1nf97W+G9ZCLqmInRStymqpcRO
 51/aVSHQHAOtRB39UrLpCUWwf+SaAC7JjnDxqzlDaoRiCCBECiUxYrqJLfhGIiBLz+5o
 IGFrFU7HWU8mrjtDNogpAdfAohj1XWsEyTGxn8yq94wV6xeOqQllU7MGysaSbAb53m7C
 2BdJyh9AWkSANTtxk2sdUYOV3/2EgnoWGhJPQYhSnEvPHtn7/QBYesG+AxxYfxr2pqRM
 bOBmiWSjZyL150YNjtq5l/r/3ckGtfkAXtg6cyMC8R3zilCUpCJJ6f7oz7Ez3Nfd3uSY
 AC5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVctoOIO3bOPvYc68DGm1BnpThkBiTL/oR1feqS3cVQnsCuzUauPirnvccrxgKSAVQZjxY115DAG/ltie+mwW/KxfVIPMA=
X-Gm-Message-State: AOJu0YwjQlY47YSpngVOffVHAhKxIAl+NOnwfu9tRY04RV0nliuDx2Ro
 e0AFcIixYsz290KuJXbFO9xBVjN3J3ECDwqHfNR/yCbZTvKEbInXHNiZrSKC4mg8RPQTspMS2fP
 l8BC+YJ38d8DxUPe46v/+4ujB8WY=
X-Google-Smtp-Source: AGHT+IEWmJN4ANFcBmHcUeeFf6w+/OODVCDkQUP75in0i0edk7C3N+0TFowYfzwidqYve7xxjBGlbu9UT9wVrsXzPcA=
X-Received: by 2002:a67:fd95:0:b0:48f:5383:c7b3 with SMTP id
 ada2fe7eead31-48f5383c9f4mr4229647137.11.1719280058563; Mon, 24 Jun 2024
 18:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240618112649.76683-1-cleger@rivosinc.com>
In-Reply-To: <20240618112649.76683-1-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Jun 2024 11:47:12 +1000
Message-ID: <CAKmqyKOH+KaRZipBUubFTpHUmzLc=-cLH0aXUNsttZ5s3CDbhw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: fix instructions count handling in
 icount mode
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Tue, Jun 18, 2024 at 9:28=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
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
>
> v2:
>  - Apply checkpatch and fixed missing braces
>
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
>

