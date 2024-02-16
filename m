Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878ECC4829E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 00:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ramAl-0003fw-IK; Thu, 15 Feb 2024 19:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ramAk-0003fh-AX; Thu, 15 Feb 2024 19:33:46 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ramAi-0003Ii-Hc; Thu, 15 Feb 2024 19:33:46 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4c127eb4d6dso545917e0c.1; 
 Thu, 15 Feb 2024 16:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708043623; x=1708648423; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gB8/Fkt9uKc8NGcBURDmAIW/8egtKq93QlauaQn6c8=;
 b=F6flWzbkcHLE8zeyg+WRIrndkYzj3PlmGYJcAbsNUOH6GEI2Z9V4gJlyLacUitrhCb
 MAqY0YbuuR1sODfelihuzgzI5/ogmf4zYCnRpV4hcXFZXj3HHmZax9992zAPXi3QYqyh
 Ca+TBRSQvXo3/KbErvY+cmxYOmYP4w4tOh270lNkqkzDXHNd2X5xONj5SLzGHGOwVH/W
 xw0QbsZyTlyWVEQ6+xaBNPwV4xTZ56qcpk3hdUcs62tAv7ZDdbR1CyIgLciVKsLhOXx6
 6vP77X2R/hXROYobgy8bkma+5kYwr5Jzpgi6dUQriR6KWIXTC+g3HXpjpb2dyM0c8i5c
 xB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708043623; x=1708648423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1gB8/Fkt9uKc8NGcBURDmAIW/8egtKq93QlauaQn6c8=;
 b=hAlxH47GvcDM5i5KoAkGjcka8kI4iwZ2EKtWDAEuRM5x9p16h1HEsV54RbCdPmpWYW
 nzlUMfjMMF+oo3UZHzwpTkCX/WlgWFaiI0XJEj1BJX3qv5vS6WYY7mNHZxc7JxUpBgjJ
 Cdo2lMHL/j3WD+XZD7oEW8trPshVxGe+lBri5RzH+y8Zb+cX7sdtpvQU0cTh1VfXBQW5
 56mP91sPc9SFw9uoRDQR8u8LMBHo0DSKl7QE1Jj8oqJCti70CHQQj8g3oHsAKtOTtMDm
 QnmsaBVKlES4BH+e30OM55VXO5XnOoSSn4kLW9L6hfXKd/kE3evsVv9U3KM5/Uzrk0oR
 +nVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUygsgauGmNzaBBVfWwnMcDY9lkDmJ2b75cCULVbu0YOvRw0SRoFXsTC8LW99xFszyWD41GWIYqhSPomTqv5OsEPVB+DCg=
X-Gm-Message-State: AOJu0YzxjOQMNm0H9ckLcZorne7WF0O9blqMPdHLx2AdyRfAtXT/knQa
 4T/SA463YMf+3euVLvOA0EgUJRKLmRoJ0tT5jOJKT3+g/fvEjGGBQzmCO2uy/4US9YqXNIrdm5F
 WBgvMHiYz4ntbQE1LvEGcCOpGij8=
X-Google-Smtp-Source: AGHT+IHZ+8wn6DyKMBtRL2hnPi+CGZ3NaugfkjdZ2wblAsSSa/keJIY/Hdx6i7XT3DmMuTvztJJnX/yCHdnbiNEJaoI=
X-Received: by 2002:a1f:6602:0:b0:4bf:fe7f:1c56 with SMTP id
 a2-20020a1f6602000000b004bffe7f1c56mr3292692vkc.7.1708043622781; Thu, 15 Feb
 2024 16:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20240109145923.37893-1-irina.ryapolova@syntacore.com>
 <20240109145923.37893-2-irina.ryapolova@syntacore.com>
In-Reply-To: <20240109145923.37893-2-irina.ryapolova@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Feb 2024 10:33:16 +1000
Message-ID: <CAKmqyKNhRJtgg7ycxzN=AjmAM35F=Q4m51Xpfy=As5_Vtes6mw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] target/riscv: UPDATE xATP write CSR
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 10, 2024 at 2:07=E2=80=AFAM Irina Ryapolova
<irina.ryapolova@syntacore.com> wrote:
>
> Added xATP_MODE validation for vsatp/hgatp CSRs.
> The xATP register is an SXLEN-bit read/write WARL register, so
> the legal value must be returned (See riscv-privileged-20211203, SATP/VSA=
TP/HGATP CSRs).
>
> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks for the patches.

In the future can you please send a multi-patch series with a cover
letter. It makes
the QEMU automation a lot easier to work with.

I have applied these two patches to the riscv-to-apply.next branch

Alistair

> ---
>  target/riscv/csr.c | 52 ++++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 735fb27be7..6d7a3dd9aa 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1282,6 +1282,32 @@ static bool validate_vm(CPURISCVState *env, target=
_ulong vm)
>      return get_field(mode_supported, (1 << vm));
>  }
>
> +static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_x=
atp,
> +                                  target_ulong val)
> +{
> +    target_ulong mask;
> +    bool vm;
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        vm =3D validate_vm(env, get_field(val, SATP32_MODE));
> +        mask =3D (val ^ old_xatp) & (SATP32_MODE | SATP32_ASID | SATP32_=
PPN);
> +    } else {
> +        vm =3D validate_vm(env, get_field(val, SATP64_MODE));
> +        mask =3D (val ^ old_xatp) & (SATP64_MODE | SATP64_ASID | SATP64_=
PPN);
> +    }
> +
> +    if (vm && mask) {
> +        /*
> +         * The ISA defines SATP.MODE=3DBare as "no translation", but we =
still
> +         * pass these through QEMU's TLB emulation as it improves
> +         * performance.  Flushing the TLB on SATP writes with paging
> +         * enabled avoids leaking those invalid cached mappings.
> +         */
> +        tlb_flush(env_cpu(env));
> +        return val;
> +    }
> +    return old_xatp;
> +}
> +
>  static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mp=
p,
>                                   target_ulong val)
>  {
> @@ -2997,31 +3023,11 @@ static RISCVException read_satp(CPURISCVState *en=
v, int csrno,
>  static RISCVException write_satp(CPURISCVState *env, int csrno,
>                                   target_ulong val)
>  {
> -    target_ulong mask;
> -    bool vm;
> -
>      if (!riscv_cpu_cfg(env)->mmu) {
>          return RISCV_EXCP_NONE;
>      }
>
> -    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -        vm =3D validate_vm(env, get_field(val, SATP32_MODE));
> -        mask =3D (val ^ env->satp) & (SATP32_MODE | SATP32_ASID | SATP32=
_PPN);
> -    } else {
> -        vm =3D validate_vm(env, get_field(val, SATP64_MODE));
> -        mask =3D (val ^ env->satp) & (SATP64_MODE | SATP64_ASID | SATP64=
_PPN);
> -    }
> -
> -    if (vm && mask) {
> -        /*
> -         * The ISA defines SATP.MODE=3DBare as "no translation", but we =
still
> -         * pass these through QEMU's TLB emulation as it improves
> -         * performance.  Flushing the TLB on SATP writes with paging
> -         * enabled avoids leaking those invalid cached mappings.
> -         */
> -        tlb_flush(env_cpu(env));
> -        env->satp =3D val;
> -    }
> +    env->satp =3D legalize_xatp(env, env->satp, val);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -3506,7 +3512,7 @@ static RISCVException read_hgatp(CPURISCVState *env=
, int csrno,
>  static RISCVException write_hgatp(CPURISCVState *env, int csrno,
>                                    target_ulong val)
>  {
> -    env->hgatp =3D val;
> +    env->hgatp =3D legalize_xatp(env, env->hgatp, val);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -3772,7 +3778,7 @@ static RISCVException read_vsatp(CPURISCVState *env=
, int csrno,
>  static RISCVException write_vsatp(CPURISCVState *env, int csrno,
>                                    target_ulong val)
>  {
> -    env->vsatp =3D val;
> +    env->vsatp =3D legalize_xatp(env, env->vsatp, val);
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.25.1
>
>

