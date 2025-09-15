Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3789CA0EE8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 02:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxzED-0004IG-VB; Sun, 14 Sep 2025 22:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzEC-0004Hc-93
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 22:46:04 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzDz-0001Bf-Lm
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 22:46:01 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b0418f6fc27so625504866b.3
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757904345; x=1758509145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOwfGJPbcKy5egc0Vc/xPrHlga6zY9r9p0hgHwbAlMc=;
 b=SUK7yhxNP/kWkoGANbnKSQLiIGIHu8Cq3ycVJNaliow8qaLO1cF89/XOdQcv97Pqj+
 8l7cricgv/upIS9KIiBgnIyOKxK3bjO3V203/MUVUQ7Wh6Mq804kKSnd+rCIpJRiO2Mh
 +zkIzBvRGEEB7uHCGP/ZEiVFWHH7Zjf6G/nxLNEGrsBO2/fJpaxj7ccyi+fB58GyZ4Cl
 XhT5iibw+28tDrCDMuB/C9wC4BbwYCIj4BW7azYVXCGJXc+OaQV0UgvDT4GpPWarbvyk
 1xhJoHwKgcdrHFZvqP7m2wnXrbEIygrvmdLrIDmag4sXoxb/kvZYCTufx1QNqrXySEHw
 wr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757904345; x=1758509145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOwfGJPbcKy5egc0Vc/xPrHlga6zY9r9p0hgHwbAlMc=;
 b=KZaAgB8medojhoK1uLzi3qvjpRWWbOj4b5pXgdUIPOVZzzRvrOul4vRo8XG87Jymnb
 qic0vk4RQhnmJlfETeUShfLdfE8SDQWKMhLu6mCbslAESXBUo0gU0tYplSrOVQtWEaSy
 Qg54D2MZbr2YbeH0h6kZ7uRaT0d+9uI11pf7uuJ21NaK38plhC+5cijB2S+U9k4nYjDY
 +fQceCSaSbIAvhH4SiRp0wUViGVXE07/pA5CJPQOd3QmajrOGK6MQcyns1w9G8AhcP+j
 hFgNQMFM6UKgO9XosDP4XZxmKCAW1HnmDvbK+ASolGa1ShOIwJtcEQPAZCvE3bn4Y1kU
 AY1Q==
X-Gm-Message-State: AOJu0Yy8226KGgrWeXDZkC3f1V3c1CGNNAG0g9tLUiQULJapG2zBTOXe
 ZhcSM5y0Fhy3RG+8K1zUbqDY2WxGjA0VUU7NFc8gHh0eeVunC+CrxmV8qvF1XhNJ4//vHO16QWu
 UEs0+loEJpMhBPJ/NEUQCYKv9LFntY2w=
X-Gm-Gg: ASbGncs5M1pjyU3/Tt/wrJTMoYxHTT7cZaKsB5AwZZS4Fla8/qykf0GrkMAfaK6+vQn
 ZBL+en/CpfNjXzH97oV/NYySSjJj9viLbTUrfKOCHNCUpxon09jvejur1DnrlGKQ685pOrr43yA
 Qq0Ij5I6KXH8BjNsw+ReRWMQ5+G+QtdrfRCkfCprg03/wplvuk0BvJLqvTdZpsthuxoDYZPdzub
 achCp5mpMFqoUu0ZDMW3XITNYxZJZNnUx9z8jSF3wMNU4FTFxaITiOgDGY=
X-Google-Smtp-Source: AGHT+IH6v/d6Z7+VTYvJ2bHdf2AoRnQqHlp2vTqFw12i7mkBqmIep1g4y8p19pPnJ45hDnOu8TxzQ8MWKyHqagtDUHU=
X-Received: by 2002:a17:907:1c0b:b0:b0f:53c0:e2b9 with SMTP id
 a640c23a62f3a-b0f53ef41b8mr274178566b.2.1757904345285; Sun, 14 Sep 2025
 19:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250903164043.2828336-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250903164043.2828336-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 12:45:19 +1000
X-Gm-Features: Ac12FXzTMYpD6Ez19ycS-f3bSfc-1SpWpzuTrgd2W7AzLKzX8hMkN2o5tRU82xc
Message-ID: <CAKmqyKPWrG3UWZWM8TOpi7Eu7QbV-n68EnjPN1agRuwtn4RXnA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/syscall.c: sync RISC-V hwprobe with Linux
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Thu, Sep 4, 2025 at 2:42=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> It has been awhile since the last sync. Let's bring QEMU hwprobe support
> on par with Linux 6.17-rc4.
>
> A lot of new RISCV_HWPROBE_KEY_* entities are added but this patch is
> only adding support for ZICBOM_BLOCK_SIZE.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/syscall.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 91360a072c..ef80c689d2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8992,6 +8992,29 @@ static int do_getdents64(abi_long dirfd, abi_long =
arg2, abi_long count)
>  #define     RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
>  #define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
>  #define     RISCV_HWPROBE_EXT_ZICOND        (1ULL << 35)
> +#define     RISCV_HWPROBE_EXT_ZIHINTPAUSE   (1ULL << 36)
> +#define     RISCV_HWPROBE_EXT_ZVE32X        (1ULL << 37)
> +#define     RISCV_HWPROBE_EXT_ZVE32F        (1ULL << 38)
> +#define     RISCV_HWPROBE_EXT_ZVE64X        (1ULL << 39)
> +#define     RISCV_HWPROBE_EXT_ZVE64F        (1ULL << 40)
> +#define     RISCV_HWPROBE_EXT_ZVE64D        (1ULL << 41)
> +#define     RISCV_HWPROBE_EXT_ZIMOP         (1ULL << 42)
> +#define     RISCV_HWPROBE_EXT_ZCA           (1ULL << 43)
> +#define     RISCV_HWPROBE_EXT_ZCB           (1ULL << 44)
> +#define     RISCV_HWPROBE_EXT_ZCD           (1ULL << 45)
> +#define     RISCV_HWPROBE_EXT_ZCF           (1ULL << 46)
> +#define     RISCV_HWPROBE_EXT_ZCMOP         (1ULL << 47)
> +#define     RISCV_HWPROBE_EXT_ZAWRS         (1ULL << 48)
> +#define     RISCV_HWPROBE_EXT_SUPM          (1ULL << 49)
> +#define     RISCV_HWPROBE_EXT_ZICNTR        (1ULL << 50)
> +#define     RISCV_HWPROBE_EXT_ZIHPM         (1ULL << 51)
> +#define     RISCV_HWPROBE_EXT_ZFBFMIN       (1ULL << 52)
> +#define     RISCV_HWPROBE_EXT_ZVFBFMIN      (1ULL << 53)
> +#define     RISCV_HWPROBE_EXT_ZVFBFWMA      (1ULL << 54)
> +#define     RISCV_HWPROBE_EXT_ZICBOM        (1ULL << 55)
> +#define     RISCV_HWPROBE_EXT_ZAAMO         (1ULL << 56)
> +#define     RISCV_HWPROBE_EXT_ZALRSC        (1ULL << 57)
> +#define     RISCV_HWPROBE_EXT_ZABHA         (1ULL << 58)
>
>  #define RISCV_HWPROBE_KEY_CPUPERF_0     5
>  #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
> @@ -9002,6 +9025,22 @@ static int do_getdents64(abi_long dirfd, abi_long =
arg2, abi_long count)
>  #define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
>
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
> +#define RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS 7
> +#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ 8
> +#define RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF        9
> +#define     RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN     0
> +#define     RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED    1
> +#define     RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW        2
> +#define     RISCV_HWPROBE_MISALIGNED_SCALAR_FAST        3
> +#define     RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED 4
> +#define RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF 10
> +#define     RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN     0
> +#define     RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW        2
> +#define     RISCV_HWPROBE_MISALIGNED_VECTOR_FAST        3
> +#define     RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED 4
> +#define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0     11
> +#define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE      12
> +#define RISCV_HWPROBE_KEY_VENDOR_EXT_SIFIVE_0    13
>
>  struct riscv_hwprobe {
>      abi_llong  key;
> @@ -9110,6 +9149,52 @@ static void risc_hwprobe_fill_pairs(CPURISCVState =
*env,
>                       RISCV_HWPROBE_EXT_ZACAS : 0;
>              value |=3D cfg->ext_zicond ?
>                       RISCV_HWPROBE_EXT_ZICOND : 0;
> +            value |=3D cfg->ext_zihintpause ?
> +                     RISCV_HWPROBE_EXT_ZIHINTPAUSE : 0;
> +            value |=3D cfg->ext_zve32x ?
> +                     RISCV_HWPROBE_EXT_ZVE32X : 0;
> +            value |=3D cfg->ext_zve32f ?
> +                     RISCV_HWPROBE_EXT_ZVE32F : 0;
> +            value |=3D cfg->ext_zve64x ?
> +                     RISCV_HWPROBE_EXT_ZVE64X : 0;
> +            value |=3D cfg->ext_zve64f ?
> +                     RISCV_HWPROBE_EXT_ZVE64F : 0;
> +            value |=3D cfg->ext_zve64d ?
> +                     RISCV_HWPROBE_EXT_ZVE64D : 0;
> +            value |=3D cfg->ext_zimop ?
> +                     RISCV_HWPROBE_EXT_ZIMOP : 0;
> +            value |=3D cfg->ext_zca ?
> +                     RISCV_HWPROBE_EXT_ZCA : 0;
> +            value |=3D cfg->ext_zcb ?
> +                     RISCV_HWPROBE_EXT_ZCB : 0;
> +            value |=3D cfg->ext_zcd ?
> +                     RISCV_HWPROBE_EXT_ZCD : 0;
> +            value |=3D cfg->ext_zcf ?
> +                     RISCV_HWPROBE_EXT_ZCF : 0;
> +            value |=3D cfg->ext_zcmop ?
> +                     RISCV_HWPROBE_EXT_ZCMOP : 0;
> +            value |=3D cfg->ext_zawrs ?
> +                     RISCV_HWPROBE_EXT_ZAWRS : 0;
> +            value |=3D cfg->ext_supm ?
> +                     RISCV_HWPROBE_EXT_SUPM : 0;
> +            value |=3D cfg->ext_zicntr ?
> +                     RISCV_HWPROBE_EXT_ZICNTR : 0;
> +            value |=3D cfg->ext_zihpm ?
> +                     RISCV_HWPROBE_EXT_ZIHPM : 0;
> +            value |=3D cfg->ext_zfbfmin ?
> +                     RISCV_HWPROBE_EXT_ZFBFMIN : 0;
> +            value |=3D cfg->ext_zvfbfmin ?
> +                     RISCV_HWPROBE_EXT_ZVFBFMIN : 0;
> +            value |=3D cfg->ext_zvfbfwma ?
> +                     RISCV_HWPROBE_EXT_ZVFBFWMA : 0;
> +            value |=3D cfg->ext_zicbom ?
> +                     RISCV_HWPROBE_EXT_ZICBOM : 0;
> +            value |=3D cfg->ext_zaamo ?
> +                     RISCV_HWPROBE_EXT_ZAAMO : 0;
> +            value |=3D cfg->ext_zalrsc ?
> +                     RISCV_HWPROBE_EXT_ZALRSC : 0;
> +            value |=3D cfg->ext_zabha ?
> +                     RISCV_HWPROBE_EXT_ZABHA : 0;
>              __put_user(value, &pair->value);
>              break;
>          case RISCV_HWPROBE_KEY_CPUPERF_0:
> @@ -9119,6 +9204,10 @@ static void risc_hwprobe_fill_pairs(CPURISCVState =
*env,
>              value =3D cfg->ext_zicboz ? cfg->cboz_blocksize : 0;
>              __put_user(value, &pair->value);
>              break;
> +        case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
> +            value =3D cfg->ext_zicbom ? cfg->cbom_blocksize : 0;
> +            __put_user(value, &pair->value);
> +            break;
>          default:
>              __put_user(-1, &pair->key);
>              break;
> --
> 2.50.1
>
>

