Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57CDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 01:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb8uG-0001BS-H5; Mon, 05 Aug 2024 21:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb8uE-00017n-Jz; Mon, 05 Aug 2024 21:22:30 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb8uD-0007Nj-3G; Mon, 05 Aug 2024 21:22:30 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-49296011b52so3344338137.1; 
 Mon, 05 Aug 2024 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722907347; x=1723512147; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuGgPswDjyu7qvUJ7hCx+RfBSTQClNPoMgH4brrlAhk=;
 b=KcduEeDDxN9RXW0tmroO2nmHjyvEKOU3Kt3VQX6yXZ3f9/nGIGYJgepByJm7/i99KZ
 sL+U5wWC6r/AZwCAl9AHG80/alWvxicO527rBjuOnhLujoXwGouRqNX6YrxYheit2LFk
 RYxYuf+zBvS/iPk6FE0UMYEVu6AwqpkxfavaE6VgQZKVk2vSBIGP3za9smroO4z/tfbU
 2waQznrLWIt5UZsizf0OGrr3R9C95Bar1kSKXB4HWKmLj1IZbgm6RJ42TuA/luUKq1Xn
 DJgd6Iyo/rluywHWvquOedkRSmYRIVf8G7CPqGtrGu/sse3rKSqytEGTAT36FdHAWsIV
 Nj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722907347; x=1723512147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GuGgPswDjyu7qvUJ7hCx+RfBSTQClNPoMgH4brrlAhk=;
 b=oWvHDjpe726Rz8gK0BcUx4nykBUmVPVqn2klVqlPK7pE6RVeq0Z8optMXwkq6zaD0r
 Oa7cz/rGz4umNMFmbFNjUuLfvbgVI4HgSuHrXuYTXI80DA7XR1bjpwSifSJ0a00ity5n
 95Z14le4w32mSLJJBTv9ExqrO5n7cUW/1inEYndqrRUf9k89iZw8ftcCWe0IDIOXu3eZ
 m5suHzHE4TxbAz+hbfgOFfGi2+uUzl0YRj3Q9/VbWTpbMcNiIQ8T2L3JhTUnPE8p6uOB
 xbpbdCv7+ArxUGsC+p6TcG7Xx6G3QoQ+MlVSQCvEjjR2XKwBl2M6Brz6OvMovgaRUyfo
 13+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhcrF1oVR/CQ4TDCMbayYjOR4UXtcMZfZIoOxl1Myap+YdID+CsYLVG7Qr/MNfne7Jgf6X0k8hCFVurnTRKb3YX0iS4fw=
X-Gm-Message-State: AOJu0YwIKDdWASE8JZSMqXkfpZK83RVbiFzCUc4RYw+UTDc5tELBEPML
 z0o+64ThC/4P1+Kf1m6E9v98Htcj0LIY8Wx/pyfdrYElOc3Nc7x6obDiQkpX1HlbPqJV6mOPpi7
 LKbx1Ra/N50GZNWnwF7ZrUJZSwto=
X-Google-Smtp-Source: AGHT+IFSiyTHSQ/4Pahu+WZuOJeVbO+2y+x/XYNt9E2Sz68CWBbv5cbJ/q1I1+psLbm4xUWLV4xteHfD/BtqMH7OjXY=
X-Received: by 2002:a05:6102:3f4d:b0:492:97c1:a78a with SMTP id
 ada2fe7eead31-4945ce9f9bbmr9784839137.13.1722907347520; Mon, 05 Aug 2024
 18:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-8-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-8-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 11:22:01 +1000
Message-ID: <CAKmqyKMhhT=FT0bGzNw6Kgva488pP1Tvi+Gcu0-s1cbeEC5znA@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] target/riscv: Add configuration for
 S[m|s]csrind, Smcdeleg/Ssccfg
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Wed, Jul 24, 2024 at 9:33=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Add configuration options so that they can be enabled/disabld from
> qemu commandline.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ac2dce734d80..1731dc461376 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1477,6 +1477,10 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[=
] =3D {
>      /* Defaults for standard extensions */
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
>      MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
> +    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
> +    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
> +    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
> +    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>
> --
> 2.34.1
>
>

