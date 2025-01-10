Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C525FE7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 02:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW4M1-0005mF-Ah; Thu, 09 Jan 2025 21:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW4Ly-0005ky-Sw; Thu, 09 Jan 2025 21:02:26 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW4Lx-0004iu-CH; Thu, 09 Jan 2025 21:02:26 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5161d5b8650so528234e0c.3; 
 Thu, 09 Jan 2025 18:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736474544; x=1737079344; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fqnTWEVE0v7qnc+ptwfN4S7ZmmGefPlD92GKyN9mE4=;
 b=BeApzJE0APSwQzzf2he3GwYB712tiN1SLtfFggzdjJ/7gk8WvzbD+lwtD0CIOkaF6i
 1ZnwBqyH2CcTNyb9BppEYCN8lvxFAsOXe3qwffHKwOdzINXsyVKCtwECPhPg3VpzFlBg
 n9NmTYV6N7i7UQ3m4xuM0dw0ZxX/Ssf+LGFoNPQYBnJ2kZvsOC4op3fx5tXCGrlHwqas
 EPCGx9+0sNkdb2e8GobDhoWf94xn52c8/Wti80lkGyr2XqAoAoHVD67v2mKU4U/bZBK6
 Meu29k1H8v6ujiIkG0VRirVNVjRdHOL58+HTNoGnbnMGrq5hWD99yjrvUKOBxIkw+lQU
 K0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736474544; x=1737079344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fqnTWEVE0v7qnc+ptwfN4S7ZmmGefPlD92GKyN9mE4=;
 b=OLtW4ntVB1UCDHz/coN1Uqp9BkMcTu8D1CZrSUvMEH35xXWsmjGif0Bzts3hLh0qRt
 5MjZqYqOR2j5b4L8OPb8ozvAr7qHqn2R78tKXJBLOWFG8ZRmDawSvr0f4fPx4qHpEO8y
 O7lOrTKale2hSuKb3I62HB0i6vTiEsRsLDRbJyfa7EWYihnD2EXa9YkvuWzuzQQsIclE
 WcnzTTjyfTFYoegEYxZNbxsEmncrQfXyYCkAdYWG5IyAa/xy36BWkmqWetTUrof+4L2C
 Vb5zEcvnsHwVeyhZAL9rV60PpqdDIfSc37kSf9vONkvnGy2F5RzHGC0h5Mam8Ib/LpA+
 Vt5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnRSv8GOD1fn+U8gLlaRRUL1y4C6hcyhMn4fFbpGZC4bpJ3jT9Hs/7uC8KiUtYmRYl40LyBIS4WY57@nongnu.org
X-Gm-Message-State: AOJu0YwHp02tu4pxUZp6ydRyfeXkyzCK7qeFFmKCZuu2xdify7TGnD3I
 SuCwP/HuXROGooPdFlPiV+9G1aY6SYpITx741OGVO0Ig4EI+N3BuP3kTn0kym0yVGeRtQpNsWJW
 6ZheEaAeNai/xK5UIMdrP4bSa3gc=
X-Gm-Gg: ASbGnctxPXFFe9ZNJuMIQJNkV6584uUFirMRj8TK7WwVvzqN1AUWs/3EL4YQksVN7F/
 YF/QGk36ANfgu5Gdl2O+T2NvFamR+ZoyV5LFs2fTDA3gpC28VbB2eYiE7RdNz+SEoMqM=
X-Google-Smtp-Source: AGHT+IGs4WAploawKr3edFTbxebjvU8UP4uSse2l4hWjGUF+ovMy0BLP1AqtjTVwmJZmOPbQm0O3WY0NdawBOETcfls=
X-Received: by 2002:a05:6122:220c:b0:515:4fab:28c6 with SMTP id
 71dfb90a1353d-51c6c45f4afmr8545264e0c.4.1736474543895; Thu, 09 Jan 2025
 18:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
 <20241203-counter_delegation-v4-10-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-10-c12a89baed86@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2025 12:01:57 +1000
X-Gm-Features: AbW1kvYxl75ZaBFNsUGdPaZdnCxV1ZXe1xJE1pMm9MPdumgM3yNUWGBfuhdhB1A
Message-ID: <CAKmqyKP0rsEF9A5T6UYQsWd=NpjbKbuHJaz1RMepm0vwo5f0YQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] target/riscv: Add implied rule for counter
 delegation extensions
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Wed, Dec 4, 2024 at 9:17=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> The counter delegation/configuration extensions depend on the following
> extensions.
>
> 1. Smcdeleg - To enable counter delegation from M to S
> 2. S[m|s]csrind - To enable indirect access CSRs
>
> Add an implied rule so that these extensions are enabled by default
> if the sscfg extension is enabled.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 82edd28e2e1d..410ca2e3a666 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2642,6 +2642,16 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule SSCFG_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_ssccfg),
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
> +        CPU_CFG_OFFSET(ext_smcdeleg),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2659,7 +2669,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_ru=
les[] =3D {
>      &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
>      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> -    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
> +    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
>      NULL
>  };
>
>
> --
> 2.34.1
>
>

