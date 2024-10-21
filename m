Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19029D3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2gq6-0000x7-4i; Sun, 20 Oct 2024 21:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gq4-0000wj-O0; Sun, 20 Oct 2024 21:04:04 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gq3-0003hE-8W; Sun, 20 Oct 2024 21:04:04 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84fcfe29e09so1235792241.2; 
 Sun, 20 Oct 2024 18:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729472642; x=1730077442; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xuVzBZPLl7ryriC7QBSp1lzP9D+VXZQ5Pr3iE12DR4=;
 b=DCrWKqILRU50wYpZgiZaY35DSko0Wq+TcUsVu+4qTFauPdUhmZbAhrgKV0qeQBsBRn
 99rp1pA2pMxLgbkx3JVM/NPpU1BE6FJFLRD3baW+afI7ty7XRDIXYLCb7km+fw9xP5/y
 /9bcY6l3O7KSj9aQXLJ/ufGX8/FzFe6QJPaiv5JjVv0Cu5fgorwPJs+cbTiUwO8Y7jjM
 pJ4/nAomDyBOCXQblspBm/KCOsH7M84Ih9L0EAqCY4veDo01JZUu+E2o0jfAAgyVjtWq
 Xct/xJ7Tk7HrtKiFKlN6lj0BP9ZtdXvAjI10JRWV6awAWZSsrjXSb2lSt+mxrAs4+pWM
 5Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729472642; x=1730077442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xuVzBZPLl7ryriC7QBSp1lzP9D+VXZQ5Pr3iE12DR4=;
 b=PTVbmyZKkAao89dQUd/U2zHEpSqWC/U6YehpMyCKPGpBFZxb4wng17gT5Q6gSjW8Mj
 xgmQFRstcPiPsuqCSeCq5VZRuo+FroE8oDxGuYfVWEbug2yOYI0lgP6ysXK138PdPOyH
 hmy7+Xpx8jewFsD12WXUV3WfK/cSBBYFaTmcJZqzvbdJ7pOb6R1bcx1SQ8G2g5M6uf37
 zzW7R9wWO1gYJUwdteRlWvPBCdxOO3veBilh0Qa8dPSYRI6mMhCkI8nlVwIU248cmir8
 LebnHxNn56WyoGK/k/NGzShzNLG/j9xQgwASFsL9rJ86uw/Ss8g8F2jwdvqOhstluIhH
 K40A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX71LsXEke/FqpyLO+ueLgWW7jOFTEzDbr5lvBHZbcThtoXDpR8+z0Sz5ih3mDGtc02ATtfDoA/SyWW@nongnu.org
X-Gm-Message-State: AOJu0Yzk5EAc7F7gz/65PfrnG0qnF3T300EaS68akilws420E+pOeKxI
 /ATdc/pR6OcWG6Pj3WBZuxs2cTAJNMM312udO9kWHHPIFep/j6u0YKEIr6ZksGnSw1ovHf1fl5Q
 J0bL/aWetH+iKT7+SV9FkMIk02sU3oUt6
X-Google-Smtp-Source: AGHT+IFa0HQVePDNN0J1cR6OMPjjrZz+0zv4WNZ5a2hITo8YbOK7rf/dZn8EE8Zgm2DZZU6wKv3ach7njHMfuJ56hok=
X-Received: by 2002:a05:6122:201e:b0:50d:7a14:ddf7 with SMTP id
 71dfb90a1353d-50dda3a0289mr7301814e0c.8.1729472642035; Sun, 20 Oct 2024
 18:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-7-cleger@rivosinc.com>
In-Reply-To: <20241017145226.365825-7-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:03:36 +1000
Message-ID: <CAKmqyKOUTjORcwvnXrQh=5-Qr_R3U=p5gufa9HaJdghRGRwE4A@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] target/riscv: Add Smdbltrp CSRs handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Fri, Oct 18, 2024 at 12:54=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.
> Also set MDT to 1 at reset according to the specification.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c      |  3 +++
>  target/riscv/cpu_bits.h |  1 +
>  target/riscv/cpu_cfg.h  |  1 +
>  target/riscv/csr.c      | 13 +++++++++++++
>  4 files changed, 18 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 39555364bf..15b21e4f7d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -959,6 +959,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTy=
pe type)
>              env->mstatus_hs =3D set_field(env->mstatus_hs,
>                                          MSTATUS64_UXL, env->misa_mxl);
>          }
> +        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +            env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
> +        }
>      }
>      env->mcause =3D 0;
>      env->miclaim =3D MIP_SGEIP;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 0d0f253fcb..b368e27ca0 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -561,6 +561,7 @@
>  #define MSTATUS_SDT         0x01000000
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> +#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
>
>  #define MSTATUS64_UXL       0x0000000300000000ULL
>  #define MSTATUS64_SXL       0x0000000C00000000ULL
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 518102d748..8ac1e7fce3 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -78,6 +78,7 @@ struct RISCVCPUConfig {
>      bool ext_sstc;
>      bool ext_smcntrpmf;
>      bool ext_ssdbltrp;
> +    bool ext_smdbltrp;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 9aa33611f7..9d2caf34ba 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1616,6 +1616,13 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>          }
>      }
>
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +        mask |=3D MSTATUS_MDT;
> +        if ((val & MSTATUS_MDT) !=3D 0) {
> +            val &=3D ~MSTATUS_MIE;
> +        }
> +    }
> +
>      if (xl !=3D MXL_RV32 || env->debugger) {
>          if (riscv_has_ext(env, RVH)) {
>              mask |=3D MSTATUS_MPV | MSTATUS_GVA;
> @@ -1654,6 +1661,12 @@ static RISCVException write_mstatush(CPURISCVState=
 *env, int csrno,
>      uint64_t valh =3D (uint64_t)val << 32;
>      uint64_t mask =3D riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GV=
A : 0;
>
> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
> +        mask |=3D MSTATUS_MDT;
> +        if ((valh & MSTATUS_MDT) !=3D 0) {
> +            mask |=3D MSTATUS_MIE;
> +        }
> +    }
>      env->mstatus =3D (env->mstatus & ~mask) | (valh & mask);
>
>      return RISCV_EXCP_NONE;
> --
> 2.45.2
>
>

