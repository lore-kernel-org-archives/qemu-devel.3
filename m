Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D430C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lYc-0002RA-3H; Tue, 14 May 2024 02:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lYU-0002Q6-34; Tue, 14 May 2024 02:22:30 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lYS-0003tF-5c; Tue, 14 May 2024 02:22:29 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4df3da90b6cso2145218e0c.2; 
 Mon, 13 May 2024 23:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715667746; x=1716272546; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1iOd8ATpKURMFSV2O/vwJTp0YGgjsTvL5vV2zlK/AE=;
 b=lo0lCO+i6Hq/c6szraoq0QrRBFjaawwobG5+z/VzdlYEIQBXLu3tR1OsVaKyj8EjBi
 GY+6LhGKqS7kn5Kl0Funy6neI0zdSSty+P5bHw6sPCgd4ykVP0Ng3YOihDe1KbUmRom3
 e6FU+lXstwmLMwB0QFdEDlPJuGjdvKv7GfbZO+vXGUUf9H1qObHBs2I50Z7WImj3nUL6
 evDqg4e8xq17mYmert/YkWKbYIeXwUrILsB9oXpnP4df4Zst4XQBCR5W66Wun9XQLkuH
 nwpqwdzrPJEeu8fHrvUJsPFwC5DGp643uBoqWoLN5UTcR9Vb09cmr6/07fy19mA5H3Dp
 tYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715667746; x=1716272546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1iOd8ATpKURMFSV2O/vwJTp0YGgjsTvL5vV2zlK/AE=;
 b=oVtE3drghCJjRm8ramVwmvJpzXPl2OscIEontyoUcSQkBQdup0FdDGGcoqRv3gJXsJ
 ZcXvF4xXC54phpsmH+lXUHBtMdvBi1N+xR4vm9AcAEVbaF9GR96YkO9i5h/j5+pC6WCR
 Y4tpc9gR9DYVxeWrRgjzk9Q37jRSiQSjcBvd3/SdY6enTk/h7nvo/aSwYP42C1kZPe6J
 /eoIZv7zncR0rJXXfThizOYilMqZmrzu2in/c4dKykZaHHQorLMPYxvS7eUcGnEbdUnx
 afmtjFGvXIlRskVtLJwwZSySX59DKqjSvJaeVorftQdx04DtQSLqIBI+yoJtYPS3IFTC
 mMuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQspa4fa5f/ZvR7mHiyNY9jKNvNQ+mY2ABY212h9CPNj21n4xVqSJ9Xrueh0cjdjVWJxiZKTId8GwBsRVVcMt1axVT4zI=
X-Gm-Message-State: AOJu0YznPq/bkxNEFMeOYVVbJdluZV1UitHe5nttMTFIVnnhFwhbLwUH
 W9DQ6x+wz+U/X5vIPz0HyMrh8iil4wfrDjmltKOTA8Tx8yaZJN33G5jsE07sz00+gGwr66uMMMu
 X+zT2DVpPh5pMebFcy7Q7+GCb/4u8wWj9tkc=
X-Google-Smtp-Source: AGHT+IF0615b3K9tgeNv7GOZE7WQY53vbmRSl2ExMMHsDH0GMJ6MTftGHsv0IR8c/uqT3Z9LiDkQ8j9K/equKYKGJyU=
X-Received: by 2002:a05:6122:914:b0:4d3:3f2b:dc63 with SMTP id
 71dfb90a1353d-4df882a16cdmr9476847e0c.5.1715667746636; Mon, 13 May 2024
 23:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
 <20240429-countinhibit_fix-v1-1-802ec1e99133@rivosinc.com>
In-Reply-To: <20240429-countinhibit_fix-v1-1-802ec1e99133@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 16:22:00 +1000
Message-ID: <CAKmqyKMCpa_HihX9s6HNa0b+Dsw5E_pLUdOLhGrSR9vwGKEqHA@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv: Save counter values during countinhibit
 update
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Tue, Apr 30, 2024 at 5:29=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     |  1 -
>  target/riscv/csr.c     | 32 ++++++++++++++++++++------------
>  target/riscv/machine.c |  1 -
>  3 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b9449a..09bbf7ce9880 100644
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
> index 726096444fae..68ca31aff47d 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -929,17 +929,11 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVSt=
ate *env, target_ulong *val,
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
> @@ -1973,9 +1967,23 @@ static RISCVException write_mcountinhibit(CPURISCV=
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
> +           /*
> +             * Update the counter value for cycle/instret as we can't st=
op the
> +             * host ticks. But we should show the current value at this =
moment.
> +             */
> +            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
> +                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
> +                counter->mhpmcounter_val =3D get_ticks(false) -
> +                                           counter->mhpmcounter_prev +
> +                                           counter->mhpmcounter_val;
> +                if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +                    counter->mhpmcounterh_val =3D get_ticks(false) -
> +                                                counter->mhpmcounterh_pr=
ev +
> +                                                counter->mhpmcounterh_va=
l;
> +               }
> +            }
>          }
>      }
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 76f2150f78b5..3e0f2dd2ce2a 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -328,7 +328,6 @@ static const VMStateDescription vmstate_pmu_ctr_state=
 =3D {
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

