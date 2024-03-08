Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1B3C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 04:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riRlQ-0001lW-Aw; Thu, 07 Mar 2024 23:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riRlO-0001kT-80; Thu, 07 Mar 2024 23:23:18 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riRlM-00059S-Fe; Thu, 07 Mar 2024 23:23:17 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7db36dbd474so253508241.2; 
 Thu, 07 Mar 2024 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709871795; x=1710476595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kI7dpnWwB6s/ZQkuEJJSSMaou9QniH5TFgTBPF+WHb4=;
 b=SW/EcUb/ht6amFEroRxU2RmUyT7mZHIy5HPthP/Unq8vtqUUCoCaE+His5ii5OIG3K
 OUKPc297PwTaFLCrQ3O2fSP7zTx0SA76w404UWYRI8wQT0/DRsvlBEzCCSSPe/gr6YdD
 /CnPjn1uBcTWv/JSNkAh8Dwm/ujcGnvdeLYJjDyXU7doxW7x+GG9AJi9tu6EfEJzpqjg
 OEKto2HUOfCwHWNFdoSG6d68bDLOj4QVHBSFlRYoHY6YCbP4CpMqr0LxS+jm/ThpcgqX
 ObiaFvHLt3smqg3Hsuf+6lwbCU7TT4HHrCK5k5DmB6YjTD6TI+JBkLy2MqV0iDSQLGu0
 xNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709871795; x=1710476595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kI7dpnWwB6s/ZQkuEJJSSMaou9QniH5TFgTBPF+WHb4=;
 b=Q25TNFq0bLfduN/u6Z3Nn3Kr1wCZVksPDJa4NPuWe+QsPF5k94Un4Eu63cktubMbrD
 a/xadmK0TsXuy2LMQVMrJBGL38tLTAhBuy112t85RgQXNovNwB9ITqUrstVNO5Oj9QiV
 8yApKhx5EA8dM+o6QYcG1VTjwjSVAZjJJdRcrHozK3tDQGu1pmYMbenwAVmXYgldq2/P
 X/aZ2YZuE/b7j/DxskOPzl5j9TduAtSBz/1X/5e2M7bByVZU95p2WyNG2fAAfoCqbsp0
 te5n4fR/giEHKf+51jDocmUUDKIl5h8X+0tkwphoiZ/b7k5GdFJ1IMTBRHB0lzzu7ZG1
 ha0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg2TPkSR3rtk0kpO8KAO9G6Npr6OiLEvFe8d0UOid6cqVHDfWfk7PorJQZj5+ETMNzKjOxMbLYM4RPRCLdWfJnBkAxJzQ=
X-Gm-Message-State: AOJu0YyEdhhZO47/ltlvbtndvNItoU45RVhLOPQ3qbUnZhLF+3ahYOSH
 pzJkSRE6AGBLpBTmqGbQFH3q5V3ULP0kz/MSOBiR2t4Ltp0eyNgaR5gnD77N/IcANMAztLzl8fI
 WCVTxJ9V86nYM7aha8ok0IYsmYMw=
X-Google-Smtp-Source: AGHT+IGyoJWVlIQgpgvi50gOn4PU+OHYMj2PlQWg4NtjXWtEtWvjErCOiLUaBZiuJZKj2HGJ1yzlsPcpGADnTwrHJ2o=
X-Received: by 2002:a67:f5da:0:b0:473:884:7854 with SMTP id
 t26-20020a67f5da000000b0047308847854mr2388704vso.25.1709871794760; Thu, 07
 Mar 2024 20:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20240207115926.887816-1-christoph.muellner@vrull.eu>
 <20240207115926.887816-3-christoph.muellner@vrull.eu>
In-Reply-To: <20240207115926.887816-3-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 8 Mar 2024 14:22:48 +1000
Message-ID: <CAKmqyKMZqysJWyQULpD21LVHdHKAVHc4671sVe3hqJ9Ksz9a0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] linux-user/riscv: Sync hwprobe keys with Linux
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Laurent Vivier <laurent@vivier.eu>
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
 T_SCC_BODY_TEXT_LINE=-0.01,
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

On Wed, Feb 7, 2024 at 10:00=E2=80=AFPM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> Upstream Linux recently added many additional keys to the hwprobe API.
> This patch adds support for all of them with the exception of Ztso,
> which is currently not supported in QEMU.
>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> ---
>  linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 91 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 43467c9707..3ba20f99ad 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8793,13 +8793,41 @@ static int do_getdents64(abi_long dirfd, abi_long=
 arg2, abi_long count)
>  #define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
>
>  #define RISCV_HWPROBE_KEY_IMA_EXT_0     4
> -#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
> -#define     RISCV_HWPROBE_IMA_C        (1 << 1)
> -#define     RISCV_HWPROBE_IMA_V        (1 << 2)
> -#define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
> -#define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
> -#define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
> -#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
> +#define                RISCV_HWPROBE_IMA_FD            (1 << 0)
> +#define                RISCV_HWPROBE_IMA_C             (1 << 1)
> +#define                RISCV_HWPROBE_IMA_V             (1 << 2)
> +#define                RISCV_HWPROBE_EXT_ZBA           (1 << 3)
> +#define                RISCV_HWPROBE_EXT_ZBB           (1 << 4)
> +#define                RISCV_HWPROBE_EXT_ZBS           (1 << 5)
> +#define                RISCV_HWPROBE_EXT_ZICBOZ        (1 << 6)
> +#define                RISCV_HWPROBE_EXT_ZBC           (1 << 7)
> +#define                RISCV_HWPROBE_EXT_ZBKB          (1 << 8)
> +#define                RISCV_HWPROBE_EXT_ZBKC          (1 << 9)
> +#define                RISCV_HWPROBE_EXT_ZBKX          (1 << 10)
> +#define                RISCV_HWPROBE_EXT_ZKND          (1 << 11)
> +#define                RISCV_HWPROBE_EXT_ZKNE          (1 << 12)
> +#define                RISCV_HWPROBE_EXT_ZKNH          (1 << 13)
> +#define                RISCV_HWPROBE_EXT_ZKSED         (1 << 14)
> +#define                RISCV_HWPROBE_EXT_ZKSH          (1 << 15)
> +#define                RISCV_HWPROBE_EXT_ZKT           (1 << 16)
> +#define                RISCV_HWPROBE_EXT_ZVBB          (1 << 17)
> +#define                RISCV_HWPROBE_EXT_ZVBC          (1 << 18)
> +#define                RISCV_HWPROBE_EXT_ZVKB          (1 << 19)
> +#define                RISCV_HWPROBE_EXT_ZVKG          (1 << 20)
> +#define                RISCV_HWPROBE_EXT_ZVKNED        (1 << 21)
> +#define                RISCV_HWPROBE_EXT_ZVKNHA        (1 << 22)
> +#define                RISCV_HWPROBE_EXT_ZVKNHB        (1 << 23)
> +#define                RISCV_HWPROBE_EXT_ZVKSED        (1 << 24)
> +#define                RISCV_HWPROBE_EXT_ZVKSH         (1 << 25)
> +#define                RISCV_HWPROBE_EXT_ZVKT          (1 << 26)
> +#define                RISCV_HWPROBE_EXT_ZFH           (1 << 27)
> +#define                RISCV_HWPROBE_EXT_ZFHMIN        (1 << 28)
> +#define                RISCV_HWPROBE_EXT_ZIHINTNTL     (1 << 29)
> +#define                RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
> +#define                RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
> +#define                RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
> +#define                RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
> +#define                RISCV_HWPROBE_EXT_ZICOND        (1ULL << 35)

This fails to pass checkpatch

Alistair

>
>  #define RISCV_HWPROBE_KEY_CPUPERF_0     5
>  #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
> @@ -8860,6 +8888,62 @@ static void risc_hwprobe_fill_pairs(CPURISCVState =
*env,
>                       RISCV_HWPROBE_EXT_ZBS : 0;
>              value |=3D cfg->ext_zicboz ?
>                       RISCV_HWPROBE_EXT_ZICBOZ : 0;
> +            value |=3D cfg->ext_zbc ?
> +                     RISCV_HWPROBE_EXT_ZBC : 0;
> +            value |=3D cfg->ext_zbkb ?
> +                     RISCV_HWPROBE_EXT_ZBKB : 0;
> +            value |=3D cfg->ext_zbkc ?
> +                     RISCV_HWPROBE_EXT_ZBKC : 0;
> +            value |=3D cfg->ext_zbkx ?
> +                     RISCV_HWPROBE_EXT_ZBKX : 0;
> +            value |=3D cfg->ext_zknd ?
> +                     RISCV_HWPROBE_EXT_ZKND : 0;
> +            value |=3D cfg->ext_zkne ?
> +                     RISCV_HWPROBE_EXT_ZKNE : 0;
> +            value |=3D cfg->ext_zknh ?
> +                     RISCV_HWPROBE_EXT_ZKNH : 0;
> +            value |=3D cfg->ext_zksed ?
> +                     RISCV_HWPROBE_EXT_ZKSED : 0;
> +            value |=3D cfg->ext_zksh ?
> +                     RISCV_HWPROBE_EXT_ZKSH : 0;
> +            value |=3D cfg->ext_zkt ?
> +                     RISCV_HWPROBE_EXT_ZKT : 0;
> +            value |=3D cfg->ext_zvbb ?
> +                     RISCV_HWPROBE_EXT_ZVBB : 0;
> +            value |=3D cfg->ext_zvbc ?
> +                     RISCV_HWPROBE_EXT_ZVBC : 0;
> +            value |=3D cfg->ext_zvkb ?
> +                     RISCV_HWPROBE_EXT_ZVKB : 0;
> +            value |=3D cfg->ext_zvkg ?
> +                     RISCV_HWPROBE_EXT_ZVKG : 0;
> +            value |=3D cfg->ext_zvkned ?
> +                     RISCV_HWPROBE_EXT_ZVKNED : 0;
> +            value |=3D cfg->ext_zvknha ?
> +                     RISCV_HWPROBE_EXT_ZVKNHA : 0;
> +            value |=3D cfg->ext_zvknhb ?
> +                     RISCV_HWPROBE_EXT_ZVKNHB : 0;
> +            value |=3D cfg->ext_zvksed ?
> +                     RISCV_HWPROBE_EXT_ZVKSED : 0;
> +            value |=3D cfg->ext_zvksh ?
> +                     RISCV_HWPROBE_EXT_ZVKSH : 0;
> +            value |=3D cfg->ext_zvkt ?
> +                     RISCV_HWPROBE_EXT_ZVKT : 0;
> +            value |=3D cfg->ext_zfh ?
> +                     RISCV_HWPROBE_EXT_ZFH : 0;
> +            value |=3D cfg->ext_zfhmin ?
> +                     RISCV_HWPROBE_EXT_ZFHMIN : 0;
> +            value |=3D cfg->ext_zihintntl ?
> +                     RISCV_HWPROBE_EXT_ZIHINTNTL : 0;
> +            value |=3D cfg->ext_zvfh ?
> +                     RISCV_HWPROBE_EXT_ZVFH : 0;
> +            value |=3D cfg->ext_zvfhmin ?
> +                     RISCV_HWPROBE_EXT_ZVFHMIN : 0;
> +            value |=3D cfg->ext_zfa ?
> +                     RISCV_HWPROBE_EXT_ZFA : 0;
> +            value |=3D cfg->ext_zacas ?
> +                     RISCV_HWPROBE_EXT_ZACAS : 0;
> +            value |=3D cfg->ext_zicond ?
> +                     RISCV_HWPROBE_EXT_ZICOND : 0;
>              __put_user(value, &pair->value);
>              break;
>          case RISCV_HWPROBE_KEY_CPUPERF_0:
> --
> 2.43.0
>
>

