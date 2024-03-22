Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3B2C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWSC-0006WH-Si; Fri, 22 Mar 2024 00:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWSB-0006Vz-QQ; Fri, 22 Mar 2024 00:24:27 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWSA-0007Vp-8r; Fri, 22 Mar 2024 00:24:27 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7dac7cfbea0so287823241.3; 
 Thu, 21 Mar 2024 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711081465; x=1711686265; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgvKF5Sth88yKU/cA4NVFCY57XMKSTiSg1FuGuq7HP0=;
 b=K1Jl/sFipfog3kFv63QXZrfJO3g7bJqrohcaA3nC/otEkI3RCJKDBfsGSpUwMRzMt3
 kUk6RaVY65cYc/l+vVPUIz6Tr5wRmoGnQ+KPeQM1O+7HS49SJqcJ7HQADkiv08wcfX6/
 TUy6zpDMsfsPxUt4iGC0+jA+4kEWWB2d+Ecl+uMIFkirZz+PJDS/HZiFjGSP5AjvVpgx
 gXSzrw+7KG4+fIRA6PhcJRtjJtpyPbZcEn2hPRYUTqUfc5L82nvoTvVzCRvzt7yJYjRc
 ZNk06NzgbmYhSf4j9j5KNcXs+4ka70HSnYrEjO0CdOuCdCNhNjkh/3mVEud8sJXcSZYK
 8Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711081465; x=1711686265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgvKF5Sth88yKU/cA4NVFCY57XMKSTiSg1FuGuq7HP0=;
 b=VGxUi4z7dboyBuTVTC+1/kqmiuigSdBl/yGnskEE3KHt136zzNG4HKZozh+t1P9owb
 VR+M+SkxtVBxfIN5txExGHGHz9U3NQHLQCvM57lgqJrqbR8U2es/eTXulRAgW8z7arZI
 KYA7pKzpGi4qRtl3Q9SWmG38hBJfoZUGFivmOwVAPVOzZ4dfOP5iz3uZRuyG//bLLL7J
 E+Sd7GH3a2VYAIscGOe9719O8Ij897CWGReofScj/kkw8mXFNzZGq1riLL4S8gpWD3Z0
 IgiRo5oPXZETpnlPlLU9WRbOHlwlKIMZkY+79IIP4jpcqtipoHjhwLOyrOSdjvJU8rM8
 qLLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf0MIx11lZxOcvf+zH92vhVOhOflfoiaKmj6O7q2PV7Zps+UK5uQVWI2YPICahGkWTVt1pLqB5K8/gyneKhcqfItNKsiM=
X-Gm-Message-State: AOJu0YzkD3pJm6kLX6nffgnHmn1fZC61aXQREmi/LwV5FOGIKq0/5kaj
 +p9twQnp12kESzTahZtMcD6x6kQWtVeIAnwdK3gJ2CRkrt6DEE5yLm1NB+HwqcyWrc764M6jEah
 6Oddp6vPrXlioR+OpnTpfXbtGy9F8WUANgf281QXW
X-Google-Smtp-Source: AGHT+IHWPMokP0gyYF09raTOKovTzYum1iTAYoXlw39l+ZImqVZWTxxhwI1TXmQnLyl7pQ1APhWizEESOcCj9ip25u8=
X-Received: by 2002:a67:b404:0:b0:472:7b45:47de with SMTP id
 x4-20020a67b404000000b004727b4547demr1375426vsl.4.1711081464739; Thu, 21 Mar
 2024 21:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240321170929.1162507-1-max.chou@sifive.com>
In-Reply-To: <20240321170929.1162507-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:23:58 +1000
Message-ID: <CAKmqyKOf4w9CETdg8wu6KJC5B4WDG19U4fdczkDC3=NhdV=a8Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Remove the dependency of Zvfbfmin to
 Zfbfmin
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Rob Bradford <rbradford@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Fri, Mar 22, 2024 at 3:16=E2=80=AFAM Max Chou <max.chou@sifive.com> wrot=
e:
>
> According to the Zvfbfmin definition in the RISC-V BF16 extensions spec,
> the Zvfbfmin extension only requires either the V extension or the
> Zve32f extension.

Yeah, the dependency has been removed

https://github.com/riscv/riscv-bfloat16/commit/86d7a74f4b928e981f79f6d84a45=
92e6e9e4c0e9#diff-f3084dfbeae77f242848fc2cd24a84514a9f01aff7ae8ad945e1af1c0=
a33988cR20

>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 63192ef54f3..b5b95e052d2 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -530,11 +530,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> -    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zfbfmin) {
> -        error_setg(errp, "Zvfbfmin extension depends on Zfbfmin extensio=
n");
> -        return;
> -    }
> -
>      if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zve32f) {
>          error_setg(errp, "Zvfbfmin extension depends on Zve32f extension=
");
>          return;
> --
> 2.34.1
>
>

