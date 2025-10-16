Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53F2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9FKA-0002yB-Ik; Thu, 16 Oct 2025 00:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9FK7-0002xv-GN
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:10:43 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9FK3-0002Tn-Kc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:10:42 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63bad3cd668so412905a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760587837; x=1761192637; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcabmIrN+PHEohbsBlnhoOhQJrojRwDahKtVCGwgQ2s=;
 b=WUse9B6mfG9YWKZMr4Hu/eyHkF5+UIreaHBZhS4vUdn9wvd3zytTzawu8bzIWsTusj
 kziRrrwMxxS4riyWQnpoTfVv3fFI/ffvUKLHg4pltxLnaXsU32Psht/IB2ejwSeMcAn+
 IS6ejvdU1DRWuUmnFmM0nug0NPLGwC7A+5wnlLkrPwsmqJ8QPbrYhHytyRr7wL8Zcfvf
 Cigl72gnT7JmIj+HikSl1EBr96aF838cZbRlNe+BDf9qAQaWzbFu9MSXhfON3WMWr1H6
 go2948G8B/HpZ2CD6FLlEWO9T0w/Ens7xuSu8tRh40KPqKMZu9AGWor9+W/gADuf6AKj
 1apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760587837; x=1761192637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcabmIrN+PHEohbsBlnhoOhQJrojRwDahKtVCGwgQ2s=;
 b=phFqnvurh5nWDWvDSAZ7oI1AQ7hLYKzpIVq9HEFU/k+0UDnB9r6Cu31yR3w8QC8pJk
 G72AvQBVxFrvaoSx/S6lIQKI0Wn1u5avmMrpnAHKZ43oQ48sudM5rS/mnG5ylinl7DoP
 SPjC+cjMdii4bP2Enz91FSWOKsKmopTVTIDwe7LE+PHCufb2aSYZrMavujLqeebStCWN
 IcjynheYGlEc24a1xAG3A/Ko0K88DmYHD6QhsAHiV6ONdt0NG3sdKuxtvexqv9auv3Uo
 8zaf/BLsA8mA1ad9lS8LswJC/2QYVZ2r3WHTQSDHZ9NNcXa8DPCM4b1c4QbdLOxmvhQq
 3a7Q==
X-Gm-Message-State: AOJu0Yyhf6QVdAJkYM5x8Q5CgRTeYAvkGq8PTVVRV7XyMdHfThumnXSm
 FQQYQJM91z/U++e8p2zaqKEifUGnNEalvRwbNxIyPCCq4tANCvoBdneK9ysinEbU1b05/kX+Io6
 7kxvQO/DIfQhEKmfSX/bYB9US/eVuOS8=
X-Gm-Gg: ASbGncvOBmKa9CqjzRkcQsOnfsG3YpHCBe58qXZTuUaZxkm5T1xWo5gITJXpyj+HDPQ
 MY/V6ZPSxgIE2fx7dg2VhxYPsF90sLfnVD4k+umoCaozRe8aoXLSdRUd0CqNXSYgPKtBHYTnVjs
 tDlljNHvVxe9rhiI7ODmm0jmOOpLoxxCUxrzAS5QwtZpbwnr+WThoXuroVfIT2vYdQEHIcYuA+q
 tnfii2fD3V2nzDbFNxcqL8R6m6oLIZbps6Zr7M4ef4jbP7b/nHEuc3LuzgF0K2xHg9RpKRMSk/7
 Y+6mgLC6ymNAXfI=
X-Google-Smtp-Source: AGHT+IG86W6tJtHP4vKv9RMDGFVCB+SsP8ThowEFrpDBZhxf/RhDijTe+mpxlotd+LVmRZtbhKJfWQMKAMcl33Gjgvs=
X-Received: by 2002:a05:6402:27ca:b0:639:4e0b:2724 with SMTP id
 4fb4d7f45d1cf-639d5c31fbfmr30933056a12.24.1760587837367; Wed, 15 Oct 2025
 21:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-10-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-10-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 14:09:58 +1000
X-Gm-Features: AS18NWCIPyJkIuZL_bIUWB70CtZjCMI8Z4o2CDsKyx_BE6OhFblNGmrwtfkLCPs
Message-ID: <CAKmqyKMXYEA6EVA1EoEJ51DE=5GU_3xR3vU0sngvDGvoNU-Agg@mail.gmail.com>
Subject: Re: [PATCH v3 09/34] target/riscv: Combine mhpmcounter and
 mhpmcounterh
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Oct 15, 2025 at 6:38=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> According to version 20250508 of the privileged specification,
> mhpmconter is a 64-bit register and mhpmcounterh refers to the top
> 32 bits of this register when XLEN =3D=3D 32.  No real advantage is
> gained by keeping them separate, and combining allows for slight
> simplification.
>
> Note, the cpu/pmu VMSTATE version is bumped breaking migration from
> older versions.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     |  10 ++--
>  target/riscv/csr.c     |  76 ++++++++++++++--------------
>  target/riscv/machine.c |  10 ++--
>  target/riscv/pmu.c     | 111 +++++++++++------------------------------
>  4 files changed, 73 insertions(+), 134 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 58384c77b3..09d9e4c33c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -195,13 +195,9 @@ FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 =
- 11)
>
>  typedef struct PMUCTRState {
>      /* Current value of a counter */
> -    target_ulong mhpmcounter_val;
> -    /* Current value of a counter in RV32 */
> -    target_ulong mhpmcounterh_val;
> -    /* Snapshot values of counter */
> -    target_ulong mhpmcounter_prev;
> -    /* Snapshort value of a counter in RV32 */
> -    target_ulong mhpmcounterh_prev;
> +    uint64_t mhpmcounter_val;
> +    /* Snapshot value of a counter */
> +    uint64_t mhpmcounter_prev;
>      /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trig=
ger */
>      target_ulong irq_overflow_left;
>  } PMUCTRState;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index b28839d121..65b6469395 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1300,24 +1300,27 @@ static RISCVException riscv_pmu_write_ctr(CPURISC=
VState *env, target_ulong val,
>                                            uint32_t ctr_idx)
>  {
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> -    uint64_t mhpmctr_val =3D val;
> +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;
> +    int deposit_size =3D rv32 ? 32 : 64;
> +    uint64_t ctr;
> +
> +    counter->mhpmcounter_val =3D deposit64(counter->mhpmcounter_val,
> +                                         0, deposit_size, val);
>
> -    counter->mhpmcounter_val =3D val;
>      if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
>          (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> -        counter->mhpmcounter_prev =3D riscv_pmu_ctr_get_fixed_counters_v=
al(env,
> -                                                                ctr_idx,=
 false);
> +        ctr =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, false=
);
> +        counter->mhpmcounter_prev =3D deposit64(counter->mhpmcounter_pre=
v,
> +                                              0, deposit_size, ctr);
>          if (ctr_idx > 2) {
> -            if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -                mhpmctr_val =3D mhpmctr_val |
> -                              ((uint64_t)counter->mhpmcounterh_val << 32=
);
> -            }
> -            riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
> +            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx=
);
>          }
>       } else {
>          /* Other counters can keep incrementing from the given value */
> -        counter->mhpmcounter_prev =3D val;
> +        counter->mhpmcounter_prev =3D deposit64(counter->mhpmcounter_pre=
v,
> +                                              0, deposit_size, val);
> +
>      }
>
>      return RISCV_EXCP_NONE;
> @@ -1327,21 +1330,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURIS=
CVState *env, target_ulong val,
>                                            uint32_t ctr_idx)
>  {
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> -    uint64_t mhpmctr_val =3D counter->mhpmcounter_val;
> -    uint64_t mhpmctrh_val =3D val;
> +    uint64_t ctrh;
>
> -    counter->mhpmcounterh_val =3D val;
> -    mhpmctr_val =3D mhpmctr_val | (mhpmctrh_val << 32);
> +    counter->mhpmcounter_val =3D deposit64(counter->mhpmcounter_val,
> +                                         32, 32, val);
>      if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
>          (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> -        counter->mhpmcounterh_prev =3D riscv_pmu_ctr_get_fixed_counters_=
val(env,
> -                                                                 ctr_idx=
, true);
> +        ctrh =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, true=
);
> +        counter->mhpmcounter_prev =3D deposit64(counter->mhpmcounter_pre=
v,
> +                                              32, 32, ctrh);
>          if (ctr_idx > 2) {
> -            riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
> +            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx=
);
>          }
>      } else {
> -        counter->mhpmcounterh_prev =3D val;
> +        counter->mhpmcounter_prev =3D deposit64(counter->mhpmcounter_pre=
v,
> +                                              32, 32, val);
>      }
>
>      return RISCV_EXCP_NONE;
> @@ -1364,13 +1368,19 @@ static RISCVException write_mhpmcounterh(CPURISCV=
State *env, int csrno,
>  }
>
>  RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
> -                                         bool upper_half, uint32_t ctr_i=
dx)
> +                                  bool upper_half, uint32_t ctr_idx)
>  {
>      PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> -    target_ulong ctr_prev =3D upper_half ? counter->mhpmcounterh_prev :
> -                                         counter->mhpmcounter_prev;
> -    target_ulong ctr_val =3D upper_half ? counter->mhpmcounterh_val :
> -                                        counter->mhpmcounter_val;
> +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;
> +    int start =3D upper_half ? 32 : 0;
> +    int length =3D rv32 ? 32 : 64;
> +    uint64_t ctr_prev, ctr_val;
> +
> +    /* Ensure upper_half is only set for XLEN =3D=3D 32 */
> +    g_assert(rv32 || !upper_half);
> +
> +    ctr_prev =3D extract64(counter->mhpmcounter_prev, start, length);
> +    ctr_val  =3D extract64(counter->mhpmcounter_val, start, length);
>
>      if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>          /*
> @@ -2994,6 +3004,7 @@ static RISCVException write_mcountinhibit(CPURISCVS=
tate *env, int csrno,
>      uint32_t present_ctrs =3D cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNT=
EREN_IR;
>      target_ulong updated_ctrs =3D (env->mcountinhibit ^ val) & present_c=
trs;
>      uint64_t mhpmctr_val, prev_count, curr_count;
> +    uint64_t ctrh;
>
>      /* WARL register - disable unavailable counters; TM bit is always 0 =
*/
>      env->mcountinhibit =3D val & present_ctrs;
> @@ -3012,17 +3023,13 @@ static RISCVException write_mcountinhibit(CPURISC=
VState *env, int csrno,
>              counter->mhpmcounter_prev =3D
>                  riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
>              if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -                counter->mhpmcounterh_prev =3D
> -                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true=
);
> +                ctrh =3D riscv_pmu_ctr_get_fixed_counters_val(env, cidx,=
 true);
> +                counter->mhpmcounter_prev =3D deposit64(counter->mhpmcou=
nter_prev,
> +                                                      32, 32, ctrh);
>              }
>
>              if (cidx > 2) {
> -                mhpmctr_val =3D counter->mhpmcounter_val;
> -                if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -                    mhpmctr_val =3D mhpmctr_val |
> -                            ((uint64_t)counter->mhpmcounterh_val << 32);
> -                }
> -                riscv_pmu_setup_timer(env, mhpmctr_val, cidx);
> +                riscv_pmu_setup_timer(env, counter->mhpmcounter_val, cid=
x);
>              }
>          } else {
>              curr_count =3D riscv_pmu_ctr_get_fixed_counters_val(env, cid=
x, false);
> @@ -3034,18 +3041,11 @@ static RISCVException write_mcountinhibit(CPURISC=
VState *env, int csrno,
>                      riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true=
);
>
>                  curr_count =3D curr_count | (tmp << 32);
> -                mhpmctr_val =3D mhpmctr_val |
> -                    ((uint64_t)counter->mhpmcounterh_val << 32);
> -                prev_count =3D prev_count |
> -                    ((uint64_t)counter->mhpmcounterh_prev << 32);
>              }
>
>              /* Adjust the counter for later reads. */
>              mhpmctr_val =3D curr_count - prev_count + mhpmctr_val;
>              counter->mhpmcounter_val =3D mhpmctr_val;
> -            if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -                counter->mhpmcounterh_val =3D mhpmctr_val >> 32;
> -            }
>          }
>      }
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 6146124229..09c032a879 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -335,14 +335,12 @@ static bool pmu_needed(void *opaque)
>
>  static const VMStateDescription vmstate_pmu_ctr_state =3D {
>      .name =3D "cpu/pmu",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .needed =3D pmu_needed,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
> -        VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
> -        VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
> -        VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
> +        VMSTATE_UINT64(mhpmcounter_val, PMUCTRState),
> +        VMSTATE_UINT64(mhpmcounter_prev, PMUCTRState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 273822e921..708f2ec7aa 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -101,82 +101,6 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu,=
 uint32_t ctr_idx)
>      }
>  }
>
> -static int riscv_pmu_incr_ctr_rv32(RISCVCPU *cpu, uint32_t ctr_idx)
> -{
> -    CPURISCVState *env =3D &cpu->env;
> -    target_ulong max_val =3D UINT32_MAX;
> -    PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> -    bool virt_on =3D env->virt_enabled;
> -
> -    /* Privilege mode filtering */
> -    if ((env->priv =3D=3D PRV_M &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
> -        (env->priv =3D=3D PRV_S && virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
> -        (env->priv =3D=3D PRV_U && virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
> -        (env->priv =3D=3D PRV_S && !virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
> -        (env->priv =3D=3D PRV_U && !virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
> -        return 0;
> -    }
> -
> -    /* Handle the overflow scenario */
> -    if (counter->mhpmcounter_val =3D=3D max_val) {
> -        if (counter->mhpmcounterh_val =3D=3D max_val) {
> -            counter->mhpmcounter_val =3D 0;
> -            counter->mhpmcounterh_val =3D 0;
> -            /* Generate interrupt only if OF bit is clear */
> -            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> -                env->mhpmevent_val[ctr_idx] |=3D MHPMEVENT_BIT_OF;
> -                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> -            }
> -        } else {
> -            counter->mhpmcounterh_val++;
> -        }
> -    } else {
> -        counter->mhpmcounter_val++;
> -    }
> -
> -    return 0;
> -}
> -
> -static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
> -{
> -    CPURISCVState *env =3D &cpu->env;
> -    PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> -    uint64_t max_val =3D UINT64_MAX;
> -    bool virt_on =3D env->virt_enabled;
> -
> -    /* Privilege mode filtering */
> -    if ((env->priv =3D=3D PRV_M &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
> -        (env->priv =3D=3D PRV_S && virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
> -        (env->priv =3D=3D PRV_U && virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
> -        (env->priv =3D=3D PRV_S && !virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
> -        (env->priv =3D=3D PRV_U && !virt_on &&
> -        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
> -        return 0;
> -    }
> -
> -    /* Handle the overflow scenario */
> -    if (counter->mhpmcounter_val =3D=3D max_val) {
> -        counter->mhpmcounter_val =3D 0;
> -        /* Generate interrupt only if OF bit is clear */
> -        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> -            env->mhpmevent_val[ctr_idx] |=3D MHPMEVENT_BIT_OF;
> -            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> -        }
> -    } else {
> -        counter->mhpmcounter_val++;
> -    }
> -    return 0;
> -}
> -
>  /*
>   * Information needed to update counters:
>   *  new_priv, new_virt: To correctly save starting snapshot for the newl=
y
> @@ -275,8 +199,10 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,=
 target_ulong newpriv,
>  int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx=
)
>  {
>      uint32_t ctr_idx;
> -    int ret;
>      CPURISCVState *env =3D &cpu->env;
> +    uint64_t max_val =3D UINT64_MAX;
> +    bool virt_on =3D env->virt_enabled;
> +    PMUCTRState *counter;
>      gpointer value;
>
>      if (!cpu->cfg.pmu_mask) {
> @@ -293,13 +219,34 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pm=
u_event_idx event_idx)
>          return -1;
>      }
>
> -    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -        ret =3D riscv_pmu_incr_ctr_rv32(cpu, ctr_idx);
> +    /* Privilege mode filtering */
> +    if ((env->priv =3D=3D PRV_M &&
> +        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
> +        (env->priv =3D=3D PRV_S && virt_on &&
> +        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
> +        (env->priv =3D=3D PRV_U && virt_on &&
> +        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
> +        (env->priv =3D=3D PRV_S && !virt_on &&
> +        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
> +        (env->priv =3D=3D PRV_U && !virt_on &&
> +        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
> +        return 0;
> +    }
> +
> +    /* Handle the overflow scenario */
> +    counter =3D &env->pmu_ctrs[ctr_idx];
> +    if (counter->mhpmcounter_val =3D=3D max_val) {
> +        counter->mhpmcounter_val =3D 0;
> +        /* Generate interrupt only if OF bit is clear */
> +        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> +            env->mhpmevent_val[ctr_idx] |=3D MHPMEVENT_BIT_OF;
> +            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> +        }
>      } else {
> -        ret =3D riscv_pmu_incr_ctr_rv64(cpu, ctr_idx);
> +        counter->mhpmcounter_val++;
>      }
>
> -    return ret;
> +    return 0;
>  }
>
>  bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
> @@ -470,8 +417,6 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
>          riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ct=
r_idx);
>          curr_ctr_val =3D curr_ctr_val | (curr_ctrh_val << 32);
> -        ctr_val =3D ctr_val |
> -                ((uint64_t)counter->mhpmcounterh_val << 32);
>      }
>
>      /*
> --
> 2.51.0
>
>

