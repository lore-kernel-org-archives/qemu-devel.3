Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3040AC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhj9t-0006ry-Gf; Tue, 05 Mar 2024 23:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhj9l-0006ov-DF; Tue, 05 Mar 2024 23:45:29 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhj9g-0008VN-2D; Tue, 05 Mar 2024 23:45:29 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-47260f17741so247201137.0; 
 Tue, 05 Mar 2024 20:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709700319; x=1710305119; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuiU1i8aAcKzaUSIYxEtXeeTx2sJdhMHHLjH8mDV1lA=;
 b=ldbu3MlRwNZfQjY0bGUidBU0ZfqOG6keqluGv3J8t6M0bF59jwc5CeeaLdnWCjHmpG
 S44y9+pDPrK1D4G5jHCfsaku1iMxZN5spB+395RWoMCUrtf2d8ozPLcIxAoAEvxP4xrX
 WnzEqxgxy8100Evh9sh7fRXANZADuwpok7NlvosHMuHC0ye0OF4kkS9+GSvHlKP7Fkl6
 5XtQnfWXeeedPz8dyDYTTj8IH8I03ANvHohVq3obo8mCAT5zpWGVuCJQczly3jiN5qKS
 /0KVaUBritQx5tPBAxE6jPMxNefDkGMr6lltZJHUF8rMm/SE5PD1Qvd/37VksLjC3TUR
 +eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709700319; x=1710305119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuiU1i8aAcKzaUSIYxEtXeeTx2sJdhMHHLjH8mDV1lA=;
 b=ked1IrzJDSlvvGliFTBEndTEgwA7YqfLNC+GI71NizpbACxQb/eG0WK3w5yxxEFvam
 QzwWoYfxsthOpKJJ6E9qCoVS0PU83Ho9q6vT8p8hBVJxTBfuo1bgV8yYVPakdvQcHc4P
 D/0ZRpc+rhOeTdpddUyW/ut7h8WzvaXFtWbByODsc45uKl9abNNwSaKY9fxAQ1PNYSnF
 /eWlktIfWVnOh2w0z4M1Znn6dnrWvnWZH6s3p1ens/gS15zYxli00+NiczjEuQXzZ2aI
 Oun3uLy1xuqoSC463I2ygSTYVZa4yKKmECwJJo1YuGQdSOZZGDk/pzyhmpcFvwAqvPut
 WwFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVBOGEgRWJkKZLUcZ5BuMHGqIeCCrm5cpW3h/Q10TiVeQk/UJnB6LbjyOUtr7LWR2B/yXGcfgrNUKnBPfMjOSXZYLixbM=
X-Gm-Message-State: AOJu0Yyb2U6C8O+pfFHrdWbjz5ow+zGYuXC06wP0BPH28gjW1UJO8v/2
 2UGFKAthAA0Ga29i/1GFr+0GZ2j2O36C1UYFwWUtaDiJbXtgV7TVvujOHyabvddzqaB7tfqjoW+
 li7r4GZVikQZFSf1CFAYfwDv53bU=
X-Google-Smtp-Source: AGHT+IF0mtYNj7WRqOX5MGGYx8Kf/IEgWVR7O5VDzxkP8EKZ+Z5Rn3j0rk8l0BWAhBpb/FCJawXX4qhq3M+QIfdtw94=
X-Received: by 2002:a05:6102:160f:b0:472:ece1:53ca with SMTP id
 cu15-20020a056102160f00b00472ece153camr592477vsb.12.1709700318774; Tue, 05
 Mar 2024 20:45:18 -0800 (PST)
MIME-Version: 1.0
References: <20240301144053.265964-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240301144053.265964-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 14:44:52 +1000
Message-ID: <CAKmqyKMDnj5+a3iDw8TRG3xs9dF8h8cj6hWrZCSQNbe821Bm2A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: move ratified/frozen exts to
 non-experimental
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Mar 2, 2024 at 12:41=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> smaia and ssaia were ratified in August 25th 2023 [1].
>
> zvfh and zvfhmin were ratified in August 2nd 2023 [2].
>
> zfbfmin and zvfbf(min|wma) are frozen and moved to public review since
> Dec 16th 2023 [3].
>
> zaamo and zalrsc are both marked as "Frozen" since January 24th 2024
> [4].
>
> [1] https://jira.riscv.org/browse/RVS-438
> [2] https://jira.riscv.org/browse/RVS-871
> [3] https://jira.riscv.org/browse/RVS-704
> [4] https://jira.riscv.org/browse/RVS-1995
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fd0c7efdda..f5d30510ef 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1463,17 +1463,26 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions=
[] =3D {
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
>      MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
> +    MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
> +    MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
>      MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
>      MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
> +    MULTI_EXT_CFG_BOOL("zfbfmin", ext_zfbfmin, false),
>      MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
>      MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
>      MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
>      MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
>      MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
> +    MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
> +    MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
> +    MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
> +    MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
>      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>
> +    MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> +    MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>      MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
>      MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
> @@ -1561,19 +1570,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts=
[] =3D {
>
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
> -    MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
> -    MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
> -
> -    MULTI_EXT_CFG_BOOL("x-zaamo", ext_zaamo, false),
> -    MULTI_EXT_CFG_BOOL("x-zalrsc", ext_zalrsc, false),
> -
> -    MULTI_EXT_CFG_BOOL("x-zvfh", ext_zvfh, false),
> -    MULTI_EXT_CFG_BOOL("x-zvfhmin", ext_zvfhmin, false),
> -
> -    MULTI_EXT_CFG_BOOL("x-zfbfmin", ext_zfbfmin, false),
> -    MULTI_EXT_CFG_BOOL("x-zvfbfmin", ext_zvfbfmin, false),
> -    MULTI_EXT_CFG_BOOL("x-zvfbfwma", ext_zvfbfwma, false),
> -
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.43.2
>
>

