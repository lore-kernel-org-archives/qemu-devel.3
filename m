Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8F9C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lZp-0002vg-ON; Tue, 14 May 2024 02:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lZf-0002pb-QL; Tue, 14 May 2024 02:23:43 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lZV-00041c-8y; Tue, 14 May 2024 02:23:43 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4df3da90b6cso2145526e0c.2; 
 Mon, 13 May 2024 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715667810; x=1716272610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9BxGImZ7yb2DVgj2h4msXpaSc5PWY4eUd4882LFy0g=;
 b=geGXFj+HIqiGa/W2oec4FyfYULLfVClgLsmJ066KeNz5t8gyY/oDHnDQLQX7me8svC
 AaT2MnJMlAtV0UvlDrOsNcSGgZTaCu/YTuCBnHnKo3cDuyLp1YcQumIIqMDuTEHC/Z0y
 XLj6Eaj0CNMqrGuse+gUNTtcx2+NnLclzNz+qUnk9sfu1Sdolxuuk25psUFjOVFkJ41/
 /cBvAJR5cmy+hPI/pY7kQn89GMC/gxIJUZLBcWwCoE0uwqyLnit1Hd+9pB95aiWOYv2c
 xc+hr4su0fs2rOOHPuwzbl7ZYhTpBkD0RBvBUIH99+gG5a24WAzNIFe7pjBPVE4iIijS
 xxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715667810; x=1716272610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9BxGImZ7yb2DVgj2h4msXpaSc5PWY4eUd4882LFy0g=;
 b=PvIWK0iivWhSfB1qvlyyVdcuARZP5+9kvfZeitH3BSV9Yql7gifHt9vKTo8s+lNHDo
 G/xPQeTaeYoOIKTfBTCb8wo3i2odbV98gXYmzW4JQpEfFfrfVR5/fVxeXStKE4kLdsjS
 7zbynu0jX23uA50vTfedMH8yYw9EhXBIR1a2KOX8aqmugSbl2rpMZVqQjqy7afWmyJk2
 n9A617mG9+l/NBWBfd1cbNzKcLcvOn65MV2aP1Rwer6rCY/VF5iMr3grjGOQH2AXa2E/
 MWXJf1LTYvDMT8LSUB6lusgQqKedHGMd1eRtg0c/ZTYTtzmkhMHjCeu7gbLpB/bpWUsu
 wt5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn+lQYpm0B00pW4rI+YaaB7sZ6UFe+v4skHFYZIvl3EIFLSD1/JzGduw5TKvqmMfmZBElk4Oqpt/9hSQ2Qya6LprTZ7Uw=
X-Gm-Message-State: AOJu0YwaoHuDltNh2Z7eh+gy2csmOXyYAkTYnpcYhhJMCDUnxgnl6zeG
 pq2XjBJ1xRkJvfooOBxYN9Qe72PJPWU/oHIx0eM0f8AS2n7eLEkA9tsVI+EEP35Rho5k6pDCNDi
 YIxjrUypPZduOgmeyNUhw2ViD2cxaW5U+V2w=
X-Google-Smtp-Source: AGHT+IEPxp814nRm2idT3t/I+haPAPuzZ/S7SI7DKWYZQWepedcdp1m4B6/jRTMEhsF/3qE/EbiC/Cu8DI34P3jRlc4=
X-Received: by 2002:a05:6122:914:b0:4d3:3f2b:dc63 with SMTP id
 71dfb90a1353d-4df882a16cdmr9478403e0c.5.1715667809707; Mon, 13 May 2024
 23:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
 <20240429-countinhibit_fix-v1-2-802ec1e99133@rivosinc.com>
In-Reply-To: <20240429-countinhibit_fix-v1-2-802ec1e99133@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 16:23:02 +1000
Message-ID: <CAKmqyKOz=W270USCi8aZ5teLwnifCWa93pLHAZN65_17Nk01dA@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv: Enforce WARL behavior for
 scounteren/hcounteren
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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
> scounteren/hcountern are also WARL registers similar to mcountern.
> Only set the bits for the available counters during the write to
> preserve the WARL behavior.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 68ca31aff47d..a01911541d67 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2843,7 +2843,11 @@ static RISCVException read_scounteren(CPURISCVStat=
e *env, int csrno,
>  static RISCVException write_scounteren(CPURISCVState *env, int csrno,
>                                         target_ulong val)
>  {
> -    env->scounteren =3D val;
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    /* WARL register - disable unavailable counters */
> +    env->scounteren =3D val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUN=
TEREN_TM |
> +                             COUNTEREN_IR);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -3475,7 +3479,11 @@ static RISCVException read_hcounteren(CPURISCVStat=
e *env, int csrno,
>  static RISCVException write_hcounteren(CPURISCVState *env, int csrno,
>                                         target_ulong val)
>  {
> -    env->hcounteren =3D val;
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    /* WARL register - disable unavailable counters */
> +    env->hcounteren =3D val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUN=
TEREN_TM |
> +                             COUNTEREN_IR);
>      return RISCV_EXCP_NONE;
>  }
>
>
> --
> 2.34.1
>
>

