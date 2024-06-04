Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A9DC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEIRf-0006GB-7u; Mon, 03 Jun 2024 20:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIRe-0006FU-21; Mon, 03 Jun 2024 20:54:34 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIRc-0004yO-Gk; Mon, 03 Jun 2024 20:54:33 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-80ac969db43so1164525241.2; 
 Mon, 03 Jun 2024 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717462470; x=1718067270; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlDVSa2tXv2VMHNgXIyxMAPbBgElkSUfn77H5X48KpQ=;
 b=XKqd6uzAZr9tphiCawuX7PlIYXOX7VZeWAXqLF3gi3OU8voh7Xb25SOKJNQHyeGdO7
 BHE+pC2s0f+XMZIS02ns8jSInLwtBNm9TqeaBgiUQYpI6Sp8EdvVWsKES7Ck8YV1lN5R
 ok+mbteu4aZYQHsfnMgI2ytpFudsvOQpczBd1ZCai1PmhjyTiHSMS5Rz0ELlTcNsQ0nJ
 8LHtyVLKGVnaR25imxlTzadLPiFZ4fmS/ZGRgJjHfAZfFQeX9o1EnSrSMo8bRFMXDFyq
 gyphpdOf4HGBVUsh+n4Bn39NeTn+LplaKStc+jsEV8UzvBbeLUKd2L1i6tk7E0j8Hvbx
 Ia1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717462470; x=1718067270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlDVSa2tXv2VMHNgXIyxMAPbBgElkSUfn77H5X48KpQ=;
 b=f1LFrY9U5WuzcYxLsvB4bary3jIqjDMgdvJBiluxW5sXdQS/dM1WRXjgezSHlMDI/u
 utnNzAqwSc2nMDYbEZE3BtK7YgxxyfAt953GGWnI1IXT3xmdUYMitJgkcYDytze6db8b
 +9Hkny33mP3kHvHGalRPrRwORcv1HflL58p4vSM7eKSu4ZeSFMU/eWj6MbhxiYvnJcsH
 35jdRrUtgbOc7/7ECMVpRdLVoYca1m2IpMsQ/1A4MVHr9SYYho5oEiLehJkfae28Hpsa
 HJ+acCsqfO+Y2e3kc+iW3hZUBamSncKNtXk+8f6Yj/Je4aXoqQhRlZe2CZExSkBwtiW3
 +eNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqDVc1uVQRxI8JmyohDCduXfxlvMT0Ttm52ZVH4Gzqr6tko42yP1WGOqabsrwEnFxtzwmXjk99oqiLzCNrCo1P3hBFg0c=
X-Gm-Message-State: AOJu0YywRrh55QEjSu1vw/WP2DY1r9GuKBdPK5UpAOcHtue8tJojzKtv
 FDEuuml1p17TzX0+UbGXA9N6eWQWtwnWP8G61EvLXu8Z8i2HK4cDaAFcAmDIb6bMAklGMS6xsDY
 IiPjV7HrHSPzC2lNNuFTXCM8wROU=
X-Google-Smtp-Source: AGHT+IF+NXtjkaX5jaN20r3Kc6ercSKa95C3hFaR+j/UlpFMRY0OhHrYM4P4HtsPeUjm7OlRdIVQxGJQtiTTqx0BYCk=
X-Received: by 2002:a05:6102:4652:b0:47c:37e4:9143 with SMTP id
 ada2fe7eead31-48bc215adcamr8997301137.11.1717462470552; Mon, 03 Jun 2024
 17:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <20240515080605.2675399-4-fea.wang@sifive.com>
In-Reply-To: <20240515080605.2675399-4-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:54:04 +1000
Message-ID: <CAKmqyKPN7GUAQUggXvLbeUiuFgSRhmGpK32QGNKReiS59qbCGg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 3/5] target/riscv: Add 'P1P13' bit in SMSTATEEN0
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, Weiwei Li <liwei1518@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Wed, May 15, 2024 at 6:01=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
> SMSTATEEN0 that controls access to the hedeleg.

I don't see this in the spec. I only see P1P13 in mstateen0

Alistair

>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
> ---
>  target/riscv/cpu_bits.h | 1 +
>  target/riscv/csr.c      | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 74318a925c..28bd3fb0b4 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -315,6 +315,7 @@
>  #define SMSTATEEN0_CS       (1ULL << 0)
>  #define SMSTATEEN0_FCSR     (1ULL << 1)
>  #define SMSTATEEN0_JVT      (1ULL << 2)
> +#define SMSTATEEN0_P1P13    (1ULL << 56)
>  #define SMSTATEEN0_HSCONTXT (1ULL << 57)
>  #define SMSTATEEN0_IMSIC    (1ULL << 58)
>  #define SMSTATEEN0_AIA      (1ULL << 59)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6b460ee0e8..bdbc8de0e2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2248,6 +2248,10 @@ static RISCVException write_mstateen0(CPURISCVStat=
e *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_FCSR;
>      }
>
> +    if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> +        wr_mask |=3D SMSTATEEN0_P1P13;
> +    }
> +
>      return write_mstateen(env, csrno, wr_mask, new_val);
>  }
>
> @@ -2283,6 +2287,10 @@ static RISCVException write_mstateen0h(CPURISCVSta=
te *env, int csrno,
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> +    if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> +        wr_mask |=3D SMSTATEEN0_P1P13;
> +    }
> +
>      return write_mstateenh(env, csrno, wr_mask, new_val);
>  }
>
> --
> 2.34.1
>
>

