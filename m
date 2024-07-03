Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED929C3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpML-00037Q-9I; Tue, 02 Jul 2024 22:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpMA-0002z0-N6; Tue, 02 Jul 2024 22:04:26 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpM8-0008PC-SA; Tue, 02 Jul 2024 22:04:26 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80f4f1e7cc3so1421737241.3; 
 Tue, 02 Jul 2024 19:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719972263; x=1720577063; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yA0nsuBxDHKXqddDwafxCaALqmi+U9hUNrKaAD2hkzA=;
 b=SOdrkAwmSHVIIeLV+fvbFVZGzIFaNSropKgSTOYEg5qa8hx4i4QDyqhtJujQFf6LZs
 3AdUNfcnl6mp3GTXSPH3TKr/SbWGtSUx8bUwWqJmY3OJcazU8AGS3pNqAo2eYK3Kayo7
 DbK0j/+XG27YA09KLvgt1jMxnvV/I6uIe346frh23iBKEk/Pb7nDIr+XSD+rn+m3dwMz
 r0Ld9UZkdjKT/edSM+Z3xJ8Co+jYzB0XbS4dx/JAmKRZqEC2kAqXCmbiJU/Ajiwi41Kt
 eoRhLdn2jOmimunyPsVlNDCshoiN6Wb4BiXsqoF7YB5hsausCLzJ0MmsWvBBCOFriJQ+
 dJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719972263; x=1720577063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yA0nsuBxDHKXqddDwafxCaALqmi+U9hUNrKaAD2hkzA=;
 b=OAyY0Jr1MmD42vt/s79l1XF2fbIK1eqHsJzrX0oZG2ggemmx8maIfmkBtrJ12mfk1L
 jYVmCgTFwaKXrXg2o9uzgyRO3OiGuGymh2t/0xQFKd8h54dZr/Vv9G1CKcvl7yjx2bVR
 NWl9Ry/whZbSf6r2gnIEyi5B0oV4foMjcANXlDVIunn/PQ3lYDPhEo3o8aI2NmV0h/Yi
 msCynnmF245j0auFIJ9TWQqy6JLATf5U1QpghCXst147/H0WwCQ47wFU3OhtkGgodbwa
 Sei6MkT+48pk65Bp1eT4TT3OyQxgkle0jTqblBNVOowXR9M65gzAgzaukzCGt8c6LvsI
 q78A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVlCyNyQcc86NXFaC6jgsaRQH4/JVDcXo0ABxl74gMKijV9io9XN4vAgRReIXP1+YPPik9ENhvEnVrbsHHP8b9Q4L+6j0=
X-Gm-Message-State: AOJu0Yxhhuks7hS5KHt193b68bLZLjL4ymwElsXichpDFxSYI9T0nQlI
 +FkwyJdOkG3vw90cYPUoQaZKmBrKT49kPL8YcmP6801TWCB6WuvrVEKEK6bkhXVOsJzpFrcoQar
 m0lZiK74Y1ZnUY1fzSMVlotHlJVw=
X-Google-Smtp-Source: AGHT+IE+XAhoDAOjTYSPa1vT5VruCbyhigTzND7mxgKHlN8w/9rP37D+OliToE/EM/LQDPU4MAFlyIyD82FYwVD+OHM=
X-Received: by 2002:a67:fe49:0:b0:48f:6009:a924 with SMTP id
 ada2fe7eead31-48faf0c64e4mr11716290137.17.1719972263047; Tue, 02 Jul 2024
 19:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-7-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-7-bb0f10af7fa9@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:03:57 +1000
Message-ID: <CAKmqyKOS4BzOFjqt6-Czkd4VZbrvHj-XBQ3UNEaQFWtw864nbw@mail.gmail.com>
Subject: Re: [PATCH v7 07/11] target/riscv: Save counter values during
 countinhibit update
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
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

On Thu, Jun 27, 2024 at 9:58=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Currently, if a counter monitoring cycle/instret is stopped via
> mcountinhibit we just update the state while the value is saved
> during the next read. This is not accurate as the read may happen
> many cycles after the counter is stopped. Ideally, the read should
> return the value saved when the counter is stopped.
>
> Thus, save the value of the counter during the inhibit update
> operation and return that value during the read if corresponding bit
> in mcountihibit is set.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     |  1 -
>  target/riscv/csr.c     | 34 ++++++++++++++++++++++------------
>  target/riscv/machine.c |  5 ++---
>  3 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d56d640b06be..91fe2a46ba35 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -153,7 +153,6 @@ typedef struct PMUCTRState {
>      target_ulong mhpmcounter_prev;
>      /* Snapshort value of a counter in RV32 */
>      target_ulong mhpmcounterh_prev;
> -    bool started;
>      /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trig=
ger */
>      target_ulong irq_overflow_left;
>  } PMUCTRState;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c292d036bcb2..e4adfa324efe 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1062,17 +1062,11 @@ static RISCVException riscv_pmu_read_ctr(CPURISCV=
State *env, target_ulong *val,
>
>      if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>          /*
> -         * Counter should not increment if inhibit bit is set. We can't =
really
> -         * stop the icount counting. Just return the counter value writt=
en by
> -         * the supervisor to indicate that counter was not incremented.
> +         * Counter should not increment if inhibit bit is set. Just retu=
rn the
> +         * current counter value.
>           */
> -        if (!counter->started) {
> -            *val =3D ctr_val;
> -            return RISCV_EXCP_NONE;
> -        } else {
> -            /* Mark that the counter has been stopped */
> -            counter->started =3D false;
> -        }
> +         *val =3D ctr_val;
> +         return RISCV_EXCP_NONE;
>      }
>
>      /*
> @@ -2114,9 +2108,25 @@ static RISCVException write_mcountinhibit(CPURISCV=
State *env, int csrno,
>
>      /* Check if any other counter is also monitoring cycles/instructions=
 */
>      for (cidx =3D 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> -        if (!get_field(env->mcountinhibit, BIT(cidx))) {
>              counter =3D &env->pmu_ctrs[cidx];
> -            counter->started =3D true;
> +        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx)=
)) {
> +            /*
> +             * Update the counter value for cycle/instret as we can't st=
op the
> +             * host ticks. But we should show the current value at this =
moment.
> +             */
> +            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
> +                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
> +                counter->mhpmcounter_val =3D
> +                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, fals=
e) -
> +                                           counter->mhpmcounter_prev +
> +                                           counter->mhpmcounter_val;
> +                if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +                    counter->mhpmcounterh_val =3D
> +                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, =
true) -
> +                                                counter->mhpmcounterh_pr=
ev +
> +                                                counter->mhpmcounterh_va=
l;
> +                }
> +            }
>          }
>      }
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 76f2150f78b5..492c2c6d9d79 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -320,15 +320,14 @@ static bool pmu_needed(void *opaque)
>
>  static const VMStateDescription vmstate_pmu_ctr_state =3D {
>      .name =3D "cpu/pmu",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .needed =3D pmu_needed,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
>          VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
>          VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
>          VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
> -        VMSTATE_BOOL(started, PMUCTRState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>
> --
> 2.34.1
>
>

