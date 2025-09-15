Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E70CAC587
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 02:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxzEr-0004jm-VD; Sun, 14 Sep 2025 22:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzEp-0004jL-Dd
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 22:46:43 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzEj-0001NC-5I
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 22:46:43 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b07883a5feeso633277266b.1
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757904389; x=1758509189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXUV/kd9EGV1/EaGgc27BXhHc4WuvWETYrbFbPQbcfM=;
 b=kgckyIxlHFJx8wsl9pX4an3Pe41z+uKEPc5lLClId8kDhDwBU4l6pq1OmepQpwiULA
 8m9ZgmMOX1IxIsFa30BjY1B2wAMoQpnT8Ko35h8DZHmTyU2sfi0HfBsjKk2pQygmC3yD
 aq8gqZh5Y5PTAc48UNXGZXYdAGxblms60KenYFA/IicltbEbt/zPI8r4mg88JvTqzYGU
 kofB8jFkyFqJ3CE5QMsUOJoU6cDUW9PxTrZ2fbVPv7rFdlyrEUQf7HJQquj9pKvl6Ngv
 1a1EzK8EM7wdm/l/EL+hVO5/Nd2iZKQmxMJHQoC/rk1Rz+9Im/slsfgvUH6taJH73tHP
 tvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757904389; x=1758509189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXUV/kd9EGV1/EaGgc27BXhHc4WuvWETYrbFbPQbcfM=;
 b=Lgl2gvgls04BvX7GXl/DJ1I6e9hfFeuNqq1ettoPp7NbUGVfLJ81mJ0z3kwurjeltv
 kPADZgxjHrgMfIUL/gH9rq3V++GbNRTCuvXqtF3DouSv5YxlqE/c4xwx4w7S8YcYENle
 XoR+Dz1Hc+a3tMU8zVVK8PJ5Rf0+NABjn4z5/58dAIRSVYda+/hETOQaqaaSioZax30d
 I2nHqvUBkAtIAAF6gJto+J9K0S3UEw1Zf6nJ5W9tKVbhweisOz+LQvAOBYxCzOKtuxJR
 IS9bepTRT9f9j0j0JaIiJxp/7fI9ryRMsIyxqVt5db/rhTnX1XT7caAYUhZNJzq5Ohsk
 YqlA==
X-Gm-Message-State: AOJu0YzKJpIEp7jRZ90nPYant5AGKP3IDZBM/vVHAh8HqVi1le0/slXU
 eHkP/H8qPXwnWRvM8YvJcQaxqz7+CX1akCkAUvquZsOcn0Eo8YRIzO62ZetAsw3PhJCE7AfLxfY
 UwR9PZ7yvUda1wyRxMsGcHMyYGgoDiOmecA==
X-Gm-Gg: ASbGncsLF3tZVSpGiiAK6tY7o2LfHRLt2okOBDMJY6huHfarznmOaJbDZifNCNL4/pT
 SB4Q6rcvUCbz10PK09CBb8x0a6SZZhUItQUAQtkAuDN50nZRZfTXjuXUuSxS5zqXqDz5zt+Nca5
 mzQFQlTl5wDlYMMp7d+RMtMlBuUa3W+crgvF3ocCqn0H0/EGwM/sPcTKrNZmeoj9447l4a3TsIf
 QJJRz6WXykHy0b/g8yUEZXPbmfmbf1IT2G7HNwndz8NvkSu
X-Google-Smtp-Source: AGHT+IFSuTXXvH+JajUXyz0LBdcC226VVuPNd7arj0VxB4rwsBV6x75dol/Yyss4sqvsyIYByA8sZkDjZLB8W217bp0=
X-Received: by 2002:a17:906:aad2:b0:b07:c94c:a1aa with SMTP id
 a640c23a62f3a-b07c94ca24bmr956141566b.57.1757904388854; Sun, 14 Sep 2025
 19:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250903164043.2828336-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250903164043.2828336-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 12:46:02 +1000
X-Gm-Features: Ac12FXwDgkAbKXRt3NdbtOr8zTT-59u4F5Kp2fa4QERZnmXNeF9vHm4-YarN6Ns
Message-ID: <CAKmqyKPW1EavcBhE85aY=XgUbV=XF8OeWUiEQ6iq5qorUojfKg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/syscall.c: sync RISC-V hwprobe with Linux
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

