Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5DDC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 03:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raShG-0007pk-36; Wed, 14 Feb 2024 22:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSh4-0007oQ-Dh; Wed, 14 Feb 2024 22:45:51 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSh2-0005cP-SR; Wed, 14 Feb 2024 22:45:50 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d5c890c67fso224012241.0; 
 Wed, 14 Feb 2024 19:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707968747; x=1708573547; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eSaavf8wcpJ8uKpNCvzdIVJDO5IsJhxbebNouDxkPE=;
 b=CqEe1pjaZN+guvLEMsGdmyDNvIo3j8TfqTDFaRykX9cd6m46Cp+0WkNjpCvSFVHXNJ
 o6qNaNXHCGJt/KnaZBmx7lL4QRrCUxMEGDQTKDDMkvont6CEsxNPcHpnPB3mizo0qtSO
 lX43IJvEA6lTUldq+q+Rv1aE0ogxR3GvnpxHj/7EAUbJ99LP/9kjY9YzEiDdYvF5lJnn
 dLls/d1L/Sw754NOb40eUcdH/q2SeTx8CxUq+DtOG3fnMjO1xGMjd+YgD4r40YNAshmH
 7G2HwHpH+oKLG9Tp2LsBosawUDFVCfEryr2z/HWsY1NXLS00WChvg+O2RQdE/dW3vhpO
 hySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707968747; x=1708573547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eSaavf8wcpJ8uKpNCvzdIVJDO5IsJhxbebNouDxkPE=;
 b=e03zuQmXkvGg2QhalqjgyDs+kSoxXegiAGmPctr8KEP2YP6+BKErjgWhH6k8UpfSu9
 nFSZqrzPFIT6A65etyzSGFE/OYp/R3QGjJdlPq9j//TWcKSa0l03HhT4NnuXL6+0Wt5k
 6Qlp1BBOpHvhuupFMjxkvhJiX4+e/QEeSN1IFGKRBBgxK/6mE+KesaD9OC1iAV6A0/QV
 mGPkLWbnW7tQclvb2HWyUehMbv3Bb5PDu3SJfkyoVbW6rm/fTI3qqDMVn+ozXSzgHuEm
 r+fsyYz3CRdZ4rCj7KsVmDJgiJdSO1Th5Vns4odCy9B7F4k5aBxsYyMXpVF/P2ca5/Oy
 SPqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXARYGK0UpBbhxSAqWNyTwK32gCoD+q7mIoispiP5kAX4EVSPSi1NF9snOLcmXzaInyx+c7cTVHHIluQz9kHg7r9tifwWw=
X-Gm-Message-State: AOJu0Yze5Qv1AhaWNwg0R9hq0zObLmZdDz2dknoFY4t9i195jgdUSvDF
 WlYaCYglTrm+6cVbDmd6t1MFGmEhG9ElTV8inOCkyorZTPvemJLnoc2v9rzkJA4VFYqFhd2oZxJ
 HiBadsSd6Qlp49YNkQ0xy16XQvN1hfrxf
X-Google-Smtp-Source: AGHT+IH9XdkF3tRChOnFCQHyXKqwNPKUmtAsRD8E/YceOQoQM5dGi1mi+8quZHvSdoggUjLGfq0Tn0VK/NPMlk788yw=
X-Received: by 2002:a1f:edc1:0:b0:4c0:2181:81ac with SMTP id
 l184-20020a1fedc1000000b004c0218181acmr404740vkh.14.1707968747243; Wed, 14
 Feb 2024 19:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20240109145923.37893-1-irina.ryapolova@syntacore.com>
 <20240109145923.37893-2-irina.ryapolova@syntacore.com>
In-Reply-To: <20240109145923.37893-2-irina.ryapolova@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 13:45:21 +1000
Message-ID: <CAKmqyKOqv_2+cRh45v=w=PhasopC=18E6vy9KZEwpmSvQ_2V2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] target/riscv: UPDATE xATP write CSR
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

