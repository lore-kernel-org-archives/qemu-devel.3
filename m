Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92065E6C60B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 05:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tILsL-0003Ho-62; Tue, 03 Dec 2024 00:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tILsI-0003FU-Mo; Tue, 03 Dec 2024 00:55:06 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tILsH-0002hl-1y; Tue, 03 Dec 2024 00:55:06 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4af4da7d22fso1623384137.0; 
 Mon, 02 Dec 2024 21:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733205303; x=1733810103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UJL41LN7bOgTFb/UcyJ339NvrJyg7EnCLjS1qR13O8=;
 b=E8XqYkSicAfPHHX0swWD7S1StHcfzUUQetCm5BaY+R+VBCWGmkRmJ0PRqqLOTb7KKz
 BFdrEqlNl5YngpQhb5ysMc307vCKDCsVy/Hx0nsWxsI18VifjUq6VnhHwIpIr/eX24uV
 4o3TkM2QiIU2hypjdbAooffnTnbMPwlF1B4wnz90AqiRyxqz6xaUKOyAVJUmJH5SFeqh
 1X/HqMR/tEYATw5vHxol+RmdKFZLnAeXN/ZEZFid6VbHbRne9/65elnpk+vs4IMfEZ6z
 JJQiha/1XLCr+djEL1LFlqUTAAW4CI3cv9hALYblMzIEUafxfLI53zeS4tBHZhw9VZVL
 AMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733205303; x=1733810103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UJL41LN7bOgTFb/UcyJ339NvrJyg7EnCLjS1qR13O8=;
 b=YyxqWKxaXrRXWLVoKN94LZfWKTGWt0BSnqlFt7IYwWHwEA1ufPo4fQUuWVL1VSMSmV
 8FNNyjPD8YvCrlkHOHGdPKTPwVjJ86m9onnrHuRhTigzWHb9+4cgAFf+Hm7Qnri47NMm
 33pXCVmXFSdxkFQzPAhJvhsz17BdvE3hnk0+ldhi7VJewsXpGKmfDSkMyEQUt0jofCS4
 mS/zhDHls6hLQjOL0BbZMy9HCpMqzAun80vAenHMLxOTc2FJf+fTgzhv8DUqUUxGBrGG
 66Hw8EkSD3xlSwMtcU9OKN7ForBELUp84gsqo0KXn6zwhluVEkufn5umeq3RWpXRoPqB
 Xv0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX77Gxq9yZLzfKVC7cp38FT993DFL2ZOWDyYTH19msB4+Yg/oDN6t5rEjtwU8PR+P4Nax3KLRDA89cj@nongnu.org
X-Gm-Message-State: AOJu0YxeG2JgMbly2Gy761H1G6pJo4LmhHyd3gGBBZVRjQGvMGqXyWSu
 nOraIz+xN8ktfnnQlb6i9upHgjjvKGPkbJsy/ZIRljhFYLBkDvfNkhRA2ZlEzo7gT4Ml9aJz3eN
 WAyV51Pun1Uq6Gvu0Az8V+1/2Alw=
X-Gm-Gg: ASbGncvwKJueEMH3qqmxsHAgu9bsUoVSanJuJurq+/3LYwj/eOffnoybBxhk0XzKqql
 kQfhpoo7VGeMyEcXpCDMwTkR62VeL7rjk
X-Google-Smtp-Source: AGHT+IE/9gIT/rufhj/XYORe0+UfbuyXSCsg1mFd3I0N9k9t+3kb8w7uXA6PdJjK1nSiJxENlTdFjbJqvBdfBCfy104=
X-Received: by 2002:a05:6102:2925:b0:4af:5f8d:660 with SMTP id
 ada2fe7eead31-4af96db79e2mr2286567137.0.1733205303005; Mon, 02 Dec 2024
 21:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20241129154304.34946-1-philmd@linaro.org>
 <20241129154304.34946-3-philmd@linaro.org>
In-Reply-To: <20241129154304.34946-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 14:54:35 +0900
Message-ID: <CAKmqyKN9kBakQqrXL4X6B1E0M_svmXMG25K=ZoRw=YEkdZrHTA@mail.gmail.com>
Subject: Re: [PATCH-for-10.0 2/3] hw/char/riscv_htif: Explicit little-endian
 implementation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Sat, Nov 30, 2024 at 12:43=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Since our RISC-V system emulation is only built for little
> endian, the HTIF device aims to interface with little endian
> memory accesses, thus we can explicit htif_mm_ops:endianness
> being DEVICE_LITTLE_ENDIAN.
>
> In that case tswap64() is equivalent to le64_to_cpu(), as in
> "convert this 64-bit little-endian value into host cpu order".
> Replace to simplify.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/riscv_htif.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 0345088e8b3..3f84d8d6738 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -29,7 +29,7 @@
>  #include "qemu/timer.h"
>  #include "qemu/error-report.h"
>  #include "exec/address-spaces.h"
> -#include "exec/tswap.h"
> +#include "qemu/bswap.h"
>  #include "sysemu/dma.h"
>  #include "sysemu/runstate.h"
>
> @@ -212,11 +212,11 @@ static void htif_handle_tohost_write(HTIFState *s, =
uint64_t val_written)
>              } else {
>                  uint64_t syscall[8];
>                  cpu_physical_memory_read(payload, syscall, sizeof(syscal=
l));
> -                if (tswap64(syscall[0]) =3D=3D PK_SYS_WRITE &&
> -                    tswap64(syscall[1]) =3D=3D HTIF_DEV_CONSOLE &&
> -                    tswap64(syscall[3]) =3D=3D HTIF_CONSOLE_CMD_PUTC) {
> +                if (le64_to_cpu(syscall[0]) =3D=3D PK_SYS_WRITE &&
> +                    le64_to_cpu(syscall[1]) =3D=3D HTIF_DEV_CONSOLE &&
> +                    le64_to_cpu(syscall[3]) =3D=3D HTIF_CONSOLE_CMD_PUTC=
) {
>                      uint8_t ch;
> -                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1=
);
> +                    cpu_physical_memory_read(le64_to_cpu(syscall[2]), &c=
h, 1);
>                      /*
>                       * XXX this blocks entire thread. Rewrite to use
>                       * qemu_chr_fe_write and background I/O callbacks
> @@ -324,6 +324,7 @@ static void htif_mm_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps htif_mm_ops =3D {
>      .read =3D htif_mm_read,
>      .write =3D htif_mm_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
>
>  HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
> --
> 2.45.2
>
>

