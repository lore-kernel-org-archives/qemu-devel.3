Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12FAC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raUS9-0007nz-DO; Thu, 15 Feb 2024 00:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raUS8-0007nk-13; Thu, 15 Feb 2024 00:38:32 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raUS6-00027L-HZ; Thu, 15 Feb 2024 00:38:31 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-46d3a2901cdso112230137.2; 
 Wed, 14 Feb 2024 21:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707975509; x=1708580309; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dl+Dbps6p9wLnWxY4AKOVC0VqOlcbvihkgiP+zbugpY=;
 b=D8+l2b+PqWJkW2kjj2hA2SJcX9PxGgfQYvVMrkL+BnW7dDZQB2ufVLUv0hl444expd
 uV7aKo7tkpuT+K9gdzr1Go3L1Ksu7jhIqau2NJ7RtkgKI550X+dNLbSCnLOYb3tUKBWI
 bOI/A5wCTNAIiofLxFFUbCaeO/TQdOCVto0kqTjOTLH2r2HjlzZNiybVrp9OdpLNvV+N
 RgFCVIRPs7v9AHdyKdMIu0dG2n3qNgrE1bn4BgkeXszBf0upNsWmYxvT0v8Bz1Ceh6Ey
 fes2Jz5O4s3zdJXdVTldreq4I09fjPgf37PhyGuX3e7BUL4i8tyBnJBq/4DhgyDSmco/
 y62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707975509; x=1708580309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dl+Dbps6p9wLnWxY4AKOVC0VqOlcbvihkgiP+zbugpY=;
 b=AJOT3S0PXCWri7mZeUxfOMRHlJbT2Ea9PJYJotFGHKr3cEG4n2XlqmECGekQwDss1z
 btARp6o6QzrTFa24kD7EfPo5mw3k5GOVa8ulfpnX8wKc+sq45HMXVCQJV9Ggx7D2E1lK
 Vl+USyV0K6ORp6zSrGejoZt/add5VWrSlDEG9NjizmA3tnbH1wP51wcMW4RzRBC8qjmc
 fMgqkhCml15Z08fiHiPurHnNdqUtFVsNQ5hxWhajWvui5Mdlh0ksO3KMRemnC2MUf9Kh
 JsGpvKl7ip/zOBB5yqvcwfvQgGaOCf6AnN88wL2QcGzPb7jus9MinG7+E2fWs8cZOL9L
 t8Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY0DGplZosD14t93EquXffLVMB9HGUUGQUg5AssyeU3aZLSR1PAA/vlI79H9okN0WV96eUT04+46Tt8NNMDRoosRuRWbs=
X-Gm-Message-State: AOJu0YxuloblY8t+D8Jzli3uJHhee6en829WADady3LcAhyS/ASg53N1
 YVbExcqLjQaqiyhFrmfBd4niewIE/m2e9g8SQNbm5buwHKb7+dMHYMwvXttA1jj4LOzliGkrVyr
 LJcLe7FwcTuwmXb7gQdBalmN23NI=
X-Google-Smtp-Source: AGHT+IHl73uYZMvRl4XeG5K2+1VCbZEuqxKkYPcQ6LEz61LCvPMqzyJ9PUa3oetOEKGWG8rXpgrs7EDkPV5SZ7YfZB8=
X-Received: by 2002:a05:6102:f0a:b0:46e:c898:310d with SMTP id
 v10-20020a0561020f0a00b0046ec898310dmr1030057vss.21.1707975509198; Wed, 14
 Feb 2024 21:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-5-dbarboza@ventanamicro.com>
In-Reply-To: <20240202152154.773253-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:38:03 +1000
Message-ID: <CAKmqyKPwegj6gYUdUrwH8qw99Ueme6KBF-eH88AAe2ZDhsA6Yw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] target/riscv: Reset henvcfg to zero
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Sat, Feb 3, 2024 at 1:23=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Andrew Jones <ajones@ventanamicro.com>
>
> The hypervisor should decide what it wants to enable. Zero all
> configuration enable bits on reset.
>
> Also, commit ed67d63798f2 ("target/riscv: Update CSR bits name for
> svadu extension") missed one reference to 'hade'. Change it now.
>
> Fixes: 0af3f115e68e ("target/riscv: Add *envcfg.HADE related check in add=
ress translation")
> Fixes: ed67d63798f2 ("target/riscv: Update CSR bits name for svadu extens=
ion")
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 3 +--
>  target/riscv/csr.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 94843c4f6e..9045f87481 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -961,8 +961,7 @@ static void riscv_cpu_reset_hold(Object *obj)
>
>      env->menvcfg =3D (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                     (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
> -    env->henvcfg =3D (cpu->cfg.ext_svpbmt ? HENVCFG_PBMTE : 0) |
> -                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0);
> +    env->henvcfg =3D 0;
>
>      /* Initialized default priorities of local interrupts. */
>      for (i =3D 0; i < ARRAY_SIZE(env->miprio); i++) {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d9a010387f..93f7bc2cb4 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2115,7 +2115,7 @@ static RISCVException read_henvcfg(CPURISCVState *e=
nv, int csrno,
>      /*
>       * henvcfg.pbmte is read_only 0 when menvcfg.pbmte =3D 0
>       * henvcfg.stce is read_only 0 when menvcfg.stce =3D 0
> -     * henvcfg.hade is read_only 0 when menvcfg.hade =3D 0
> +     * henvcfg.adue is read_only 0 when menvcfg.adue =3D 0
>       */
>      *val =3D env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_AD=
UE) |
>                             env->menvcfg);
> --
> 2.43.0
>
>

