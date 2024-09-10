Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5F8EDE996
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 03:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snrAf-00017R-FU; Mon, 09 Sep 2024 23:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snrAd-000140-Pc; Mon, 09 Sep 2024 23:03:59 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snrAc-0000fC-8D; Mon, 09 Sep 2024 23:03:59 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-502fbf07c47so79039e0c.3; 
 Mon, 09 Sep 2024 20:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725937436; x=1726542236; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sbJwnaa8JMq3yEC94H95wQBYjXJak8dV6q2xHmWwW0=;
 b=I3V0yQdePAkPytDRExk/8NmRKUnM35/kskl4N/d4UT5hz3+Jmlga/IJBTGfl5HadLK
 4CZbPWZNR7IszDIXWY/2V5+6U/atTkcBB2yxlxH4JPoTnV0CLCr5hEPgQphxDfXQezF3
 yozV8YwRdfK7PMWaDBAVX+ieVr8XjWbf791C4qJtYjN/FU94E63h/9Dm7jjaHG/D4yks
 r0cMFFrHR5P5bVSiVYXbRMsgJvHlSC0aNivKIcCeOHYfRZiRX7SiVMm6+AAaePCHVQQD
 X3l1iPJhs9Ns3VqulfoHyK9UZe9zGv1RlwozHQfMzWFFIIPanVc1oeyFzTFwLQ+VnQrF
 XrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725937436; x=1726542236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sbJwnaa8JMq3yEC94H95wQBYjXJak8dV6q2xHmWwW0=;
 b=iNy7h1xrSIjT2t0/dS2+gR44ux93BjI3jZr5qD5D1pRdGwQx6n6toxQi1OhezRp8kT
 dbW2v/AYrk6id4itPxC27NPFKEl3uhhmrwBubv6s9ZyLd51EnthIN26jx5EZ7yXnqgIH
 7WeiHmYLRt4FfOxffuEYi/znFgL/I9dpJdaM2UnetoV69wh+MZgY6fTuGu5o37tYVDBg
 aPtCg/jtQgvFy8olZinmwkdtz437cLLUj6kdZzbIXO3JuDeHR8RvFPBcK1cJfYdPV3ru
 e7aNgSsrsYch/nbwAEYT3xnSFlgCTA/64NrfrIL657vqe/FRyHP2FVp0aLu+EgmwRR48
 c4ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWftDyE37d+Kb284B6X8EyDo/SE0mLun+J5vWbfv377VPm5vyXXMUZYnuUDOdjJN5i38UKwiehvl9i1@nongnu.org
X-Gm-Message-State: AOJu0Yx1a0Ge9dU0aEq6QIV4+VA8AXSsiOGlai04YLvZOp3vtHNJfeHT
 dJk4u0D9Qj94k+tOaYN5Affco7kiGFbF5WO+Y4IApIZoXDcpvIALyVR9ahxznLtryINNrIJ2EjK
 vigLQGMd4o0bNz5w5cmmK1izLE08=
X-Google-Smtp-Source: AGHT+IH6Uxj6yeFDq+nx3bUmZPeWt3yZ2qTUu36XrNmVBX9bydcnB2lVBmzsNQRDvNLgNogMErlUJhKJeI+Yi8Dyyxs=
X-Received: by 2002:a05:6122:4d1a:b0:502:b3a9:f40b with SMTP id
 71dfb90a1353d-502b3a9f4ffmr13403660e0c.7.1725937436135; Mon, 09 Sep 2024
 20:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240909083241.43836-2-ajones@ventanamicro.com>
In-Reply-To: <20240909083241.43836-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Sep 2024 13:03:29 +1000
Message-ID: <CAKmqyKNFUHtsw6oJZaX4xLgs+WrNbX4dOhUrBS2W1vP6SH-STA@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv32: Fix masking of physical address
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, zong.li@sifive.com, 
 liwei1518@gmail.com, cwshu@andestech.com, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Mon, Sep 9, 2024 at 6:33=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> C doesn't extend the sign bit for unsigned types since there isn't a
> sign bit to extend. This means a promotion of a u32 to a u64 results
> in the upper 32 bits of the u64 being zero. If that result is then
> used as a mask on another u64 the upper 32 bits will be cleared. rv32
> physical addresses may be up to 34 bits wide, so we don't want to
> clear the high bits while page aligning the address. The fix is to
> use hwaddr for the mask, which, even on rv32, is 64-bits wide.
>
> Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on P=
MP entries.")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> -v2: Switch from signed long to hwaddr
>
>  target/riscv/cpu_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395a1d914061..4b2c72780c36 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>      int ret =3D TRANSLATE_FAIL;
>      int mode =3D mmuidx_priv(mmu_idx);
>      /* default TLB page size */
> -    target_ulong tlb_size =3D TARGET_PAGE_SIZE;
> +    hwaddr tlb_size =3D TARGET_PAGE_SIZE;
>
>      env->guest_phys_fault_addr =3D 0;
>
> @@ -1375,7 +1375,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>
>                  qemu_log_mask(CPU_LOG_MMU,
>                                "%s PMP address=3D" HWADDR_FMT_plx " ret %=
d prot"
> -                              " %d tlb_size " TARGET_FMT_lu "\n",
> +                              " %d tlb_size %" HWADDR_PRIu "\n",
>                                __func__, pa, ret, prot_pmp, tlb_size);
>
>                  prot &=3D prot_pmp;
> @@ -1409,7 +1409,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>
>              qemu_log_mask(CPU_LOG_MMU,
>                            "%s PMP address=3D" HWADDR_FMT_plx " ret %d pr=
ot"
> -                          " %d tlb_size " TARGET_FMT_lu "\n",
> +                          " %d tlb_size %" HWADDR_PRIu "\n",
>                            __func__, pa, ret, prot_pmp, tlb_size);
>
>              prot &=3D prot_pmp;
> --
> 2.46.0
>
>

