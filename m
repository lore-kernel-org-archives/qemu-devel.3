Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E90C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhjCx-0008Pw-2u; Tue, 05 Mar 2024 23:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhjCv-0008Pj-Q5; Tue, 05 Mar 2024 23:48:45 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhjCp-0000of-21; Tue, 05 Mar 2024 23:48:45 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d698a8d93cso3747716241.3; 
 Tue, 05 Mar 2024 20:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709700517; x=1710305317; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzyAnx1YN+A682ycpv4XsKOHK1WzO+bUua81MOBC7Os=;
 b=QzVL5Lu62XULlrcepSNJ+1AimwmWaY+G2fBHQOMTs6a2fs+mc0UcoZIoA2ucgHTVhi
 q9KJGfJ9eZ0no8YCvV17GX2AeIkGjKX6rQDCY1Rn2lvcCeukygSptfINtPGMoUT/HWEv
 3Vj5mWuhictDcd9/wR95mxP0scbcZCCvQ6Quhf8JI6JyUbAPmFDB2jnMScktlqjz0h01
 xkO025p38V7Kzbckx38c1kUzyjB+sJnAbwTJK5/NdbNZSwxeQgY8z0w3wcsxb2Mgt0ZE
 5qpSOUaZssoHC0baAaKJGhw0kTr7C2SpuIkZZjWm675cs+IphaZJaEbLYzsrHpb+kPrW
 37ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709700517; x=1710305317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IzyAnx1YN+A682ycpv4XsKOHK1WzO+bUua81MOBC7Os=;
 b=UuYmwa8U+uN7BNJG/mAjsW0rJxUt6LzgWvRpB+kgmM/gbG+jOHvE2r6JCWZJF2HqC5
 XG1fB29Hefu4cy9P48qpbHSU5HlwrorfODKi8GFzLmwj5HAITF5zIsTxH3MzMXG7r1BF
 y9azkSzcVdEgZYEv/egRkgOQ7uXoRKK8DtgXSDK4wBCW7tBZuzI857h+npWTFUEfQoGB
 +nLGvgsHA0g6wEDQqW45DH77hWmh6JtpCD6X/ise4H3GMNtwo0MoWRpSFWYxiAqBNLbM
 VsZnhfdJK8pQjyd1v+JIWsToZiDqWHvFX3/69oqHcUrNV38P+w7vdqluZFCNJ7vaKy74
 y6Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL2/99EwYF/l/ooFF7avy86gDe2RBdMO3wLuUyj3kkVomrL3Jsj8p9CoZNCI7BVMB7Y41PigMIlhCleo71qFDIYL4GCbo=
X-Gm-Message-State: AOJu0YywvfGE3Ds5durNMqrgDzwqBYgULQxorAI9mnvPOWJyoSSXfZlr
 XlV8NaFeOVJD04rxLIbq3aRxIiD7lXHQneBfKfb3IkStG2hgVccC4GrJVzBafycugBKrI8TG6q1
 Ak+cyhR5W2dej7OtedEGGFOaDTeQ=
X-Google-Smtp-Source: AGHT+IEBYMWz78ZOcCO2F0pLHZIQQYmgBu2HFNMl/fKjdrVnrPKzWs5XgutWqve1HJjkCW7MppfjKG7vHYNJNsUeN/4=
X-Received: by 2002:a05:6102:38d2:b0:472:8d0d:1700 with SMTP id
 k18-20020a05610238d200b004728d0d1700mr4658562vst.2.1709700517571; Tue, 05 Mar
 2024 20:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20240301144053.265964-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240301144053.265964-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 14:48:11 +1000
Message-ID: <CAKmqyKNGTChTAAnQ90LEw0pkxMtyZ4vQ27-Z4f4-kS8ndq7HMQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: move ratified/frozen exts to
 non-experimental
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
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

Thanks!

Applied to riscv-to-apply.next

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

