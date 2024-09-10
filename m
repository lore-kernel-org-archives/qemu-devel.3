Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A83EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 03:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snrqQ-0006jM-Pn; Mon, 09 Sep 2024 23:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snrqO-0006g8-JC; Mon, 09 Sep 2024 23:47:08 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snrqL-0005LS-Vz; Mon, 09 Sep 2024 23:47:08 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5010861905bso2602452e0c.1; 
 Mon, 09 Sep 2024 20:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725940024; x=1726544824; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZNPRbionTsAOUBsp9u7Q6mRoWxD1l6R4haxdEA0Ua0=;
 b=KX1J5D65O+IMtBCZVfpy5j+iMlX+Us4feO+bWd+HIBWPOiPnWFpCGkAbsEMRTBY9HB
 nfuWz0H+Wwn1dO3P+cKt9zJqz87xz0qGkaO/98L9lGsOsER8TOXB7vgbylW+jkE9vFT9
 1NUNKFG+zYLi4kbtJiIQ73s0gxB5ivdkqY60lMfXP4VTAsIU6syDvNR/YcG0IY9rmI5/
 31XkqMRkV+8erZbrB7cAxPA2Jlo6R9TY9d2HQkL6MDIvEm2TVZyHUUfAnIZBgpL9Cjmv
 MYOkAw1czQYqY1Ssq1kMKoYQvKKlFTVWlH0m4LhU7FRh8wVEaXJzeC0jMf34Lw1lhI5P
 HPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725940024; x=1726544824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZNPRbionTsAOUBsp9u7Q6mRoWxD1l6R4haxdEA0Ua0=;
 b=dg7ZuMzpRfE3g7WWVKVA/LHphzrG83NP7UIX4Jqzy+F/1chot+mdC9I0gg1rhTtRGx
 zlCcKV0XBi+59ambhEHDpO/Zx3wvrgczCl097LBb+Z/ZXX8KLWNjF4AhYa/iKySlBGcZ
 SzyN8OfCawBWY4Vmr+b1QdEFxFx/HSgomRccalCxqBF4uakg543BzQuyHyjNsv+O+jKT
 viLLqVUGvNR8J8rzKZ2IAlWE9O/9Lme+Vk6g57q30ne3ZlYE2J+NBQD4ELA2wFMX2Ju0
 cqGSoEE4LU+HbTNouwZvQD4AoTZfBMcS3Tjc0ABPFAvsjyeS8/5/VWHghz2TYBqp9x5V
 yhuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgiNanm5dsTppgEQUUQtEvn/XJ/SwKViD/NOBKnEaphrLXIScq20DVo6UznoPYesdKBHzlWZdnY6V6@nongnu.org
X-Gm-Message-State: AOJu0YwMI55q8b78+Bq4hBFGIH5J7LR/+uWKXChqj8LKXPKO2HrxR+dn
 dbPrynf+yMvsM8keByTQCw2T7UmISLafaI+Deth/bMiaeVEDtQAT/9ZDy12Evw16LQdeMTtP0f5
 tNo8gNmicEHP83YW267tzysUNu6k=
X-Google-Smtp-Source: AGHT+IHCe18uRYIPptKP0e40LVOph7TPmmu0adDPCcRm3V0yQTrdVrrGcJj2JF6CfghoVrXKDl8AAVycoLCgyjL3xzk=
X-Received: by 2002:a05:6122:da4:b0:4f5:197a:d679 with SMTP id
 71dfb90a1353d-502f72e1a49mr1552023e0c.1.1725940024163; Mon, 09 Sep 2024
 20:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240909083241.43836-2-ajones@ventanamicro.com>
In-Reply-To: <20240909083241.43836-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Sep 2024 13:46:37 +1000
Message-ID: <CAKmqyKPzhFSfVVVQmqjCTApJp+uv5or38edLUf7sr-+faifEjw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv32: Fix masking of physical address
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, zong.li@sifive.com, 
 liwei1518@gmail.com, cwshu@andestech.com, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org, philmd@linaro.org
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

Thanks!

Applied to riscv-to-apply.next

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

