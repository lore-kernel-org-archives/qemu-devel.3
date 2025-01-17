Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3EDC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 04:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYddI-0005n2-Ta; Thu, 16 Jan 2025 23:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYddH-0005mG-F9; Thu, 16 Jan 2025 23:06:55 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYddC-0006wD-VL; Thu, 16 Jan 2025 23:06:55 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5187f0b893dso450150e0c.3; 
 Thu, 16 Jan 2025 20:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737086809; x=1737691609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPYpc0eETNSB9OfnwEeLVnqaeaoBPLE3rSCeuqnB/PM=;
 b=KItVAbvn9dMt7YpXd2ngDUIUgaXqYr/J7NlE6CPDGdIo729OL/JSTS9/IaYfpILinz
 vXpiytGbPIWKwxzmq4aUnoE6+nLu1ftumryBp5BldrWjVGt1EU1Vopp5d4pyWCxB+EhI
 vMAqnGiij0HjpfuiKCmblXWG/ilOaL/ZJTC1E+Q+GuudgMbVVm97PHrf1HQs405MhDAD
 AKynEh6BcZ6WAkKjfcypWvZUg8Pr3u64n9pTPu4xsPeDhyrRP4EFEdTwvymLI0iofaD5
 NiztpBXn2LDjeJmAYlFx9xVkjzguZU+keplbOmykADyws2GEvVCcW1yib1gOT5TWG/dx
 xBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737086809; x=1737691609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPYpc0eETNSB9OfnwEeLVnqaeaoBPLE3rSCeuqnB/PM=;
 b=Itts+GLVyMEhJpP3K2XVM5qfsaoRym3uIXweHx77Jp0Fn1rOKS3XPqnOurJfkHPZO2
 MgiXMvkzEQAfm5qoo/BOtyOkWAoREXU7VgE6UcABRlYr3z+YQf1XJTIDDBSGphQDVune
 Ei8eZubOoP5kXMwbkRk4tP91Ak6S6WtPJ8teTmncOjyUBG6tdIFv3p6nqTCecjG1Zt/F
 oMfLORFnhYpLZRL4hYiE5h/kNrn1TXJmoYZAUrJ7suJ7nwsvM6s9pP/Iax3cBY4aQJXx
 W7VcBK/LNIumoidnsGkLS4VLFLl70aVcIm4hu6rSde41JR8HrDZNT48QvTf9w5pFWRr9
 DQoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm7eCuI+4FfVZ3n36t4IVHx1j3zQtzn0mrWMSFS3O7H/vWvkG17gsTEPiMyDMyO182NGInu9XG70wA@nongnu.org
X-Gm-Message-State: AOJu0YyusRDchafYsmJ4LpTV5I2FY36PCjsV+s0gLfGbBOjGtSWR5zrT
 tXJEhm5fk1IxtaNrn8e70S0sN3TdOppq3y9UquM2xzmRmPbg57wknG3xW924NHQ8uNxcwLIAAcq
 b1w/yWPX5SDga8FmfXwY1JPFB3/o=
X-Gm-Gg: ASbGncv99xjkiosjChw9/N/Lac2KOoq8Z/GK9JZh2tTlsmfr1gMxdv8hAtlB9zbpIbg
 g3Z4rxqmJp2Zu0bpriodFWc1xehToaJfY0jnsdEVg3FXMr7r5PT9PR7OCkQSIKulabA0=
X-Google-Smtp-Source: AGHT+IHuDa9hdPvemMj0aHrynlD4FVy5ttVmVXIibuPQNF8JVr0SP3jQfUjznoHTS2dl8+4WIPMQ3EbJl3ppOxeaU+M=
X-Received: by 2002:a05:6102:c49:b0:4b2:adca:c13a with SMTP id
 ada2fe7eead31-4b690beff07mr830720137.12.1737086809394; Thu, 16 Jan 2025
 20:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20250116223609.81594-1-philmd@linaro.org>
In-Reply-To: <20250116223609.81594-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Jan 2025 14:06:23 +1000
X-Gm-Features: AbW1kvaxW2Yr3n7CDMQrVzPijf3crKgDC6RlSqcmVvENr5vq8wJ1YSE8of9HcMU
Message-ID: <CAKmqyKNAgvRSdPN0xY_STafz62wAuaD0m9oUujh3iy-wBJEiyQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/riscv_htif: Convert HTIF_DEBUG() to trace events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Weiwei Li <liwei1518@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Fri, Jan 17, 2025 at 8:37=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/char/riscv_htif.c | 15 +++------------
>  hw/char/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 11a0e1a7b7d..ec5db5a597f 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -32,14 +32,7 @@
>  #include "exec/tswap.h"
>  #include "system/dma.h"
>  #include "system/runstate.h"
> -
> -#define RISCV_DEBUG_HTIF 0
> -#define HTIF_DEBUG(fmt, ...)                                            =
       \
> -    do {                                                                =
       \
> -        if (RISCV_DEBUG_HTIF) {                                         =
       \
> -            qemu_log_mask(LOG_TRACE, "%s: " fmt "\n", __func__, ##__VA_A=
RGS__);\
> -        }                                                               =
       \
> -    } while (0)
> +#include "trace.h"
>
>  #define HTIF_DEV_SHIFT          56
>  #define HTIF_CMD_SHIFT          48
> @@ -159,8 +152,7 @@ static void htif_handle_tohost_write(HTIFState *s, ui=
nt64_t val_written)
>      uint64_t payload =3D val_written & 0xFFFFFFFFFFFFULL;
>      int resp =3D 0;
>
> -    HTIF_DEBUG("mtohost write: device: %d cmd: %d what: %02" PRIx64
> -        " -payload: %016" PRIx64 "\n", device, cmd, payload & 0xFF, payl=
oad);
> +    trace_htif_uart_write_to_host(device, cmd, payload);
>
>      /*
>       * Currently, there is a fixed mapping of devices:
> @@ -251,8 +243,7 @@ static void htif_handle_tohost_write(HTIFState *s, ui=
nt64_t val_written)
>          }
>      } else {
>          qemu_log("HTIF unknown device or command\n");
> -        HTIF_DEBUG("device: %d cmd: %d what: %02" PRIx64
> -            " payload: %016" PRIx64, device, cmd, payload & 0xFF, payloa=
d);
> +        trace_htif_uart_unknown_device_command(device, cmd, payload);
>      }
>      /*
>       * Latest bbl does not set fromhost to 0 if there is a value in toho=
st.
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 3ee7cfcdff2..b2e3d25ae34 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -136,3 +136,7 @@ stm32f2xx_usart_read(char *id, unsigned size, uint64_=
t ofs, uint64_t val) " %s s
>  stm32f2xx_usart_write(char *id, unsigned size, uint64_t ofs, uint64_t va=
l) "%s size %d ofs 0x%02" PRIx64 " <- 0x%02" PRIx64
>  stm32f2xx_usart_drop(char *id) " %s dropping the chars"
>  stm32f2xx_usart_receive(char *id, uint8_t chr) " %s receiving '%c'"
> +
> +# riscv_htif.c
> +htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t payload) "=
device: %u cmd: %02u payload: %016" PRIx64
> +htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t p=
ayload) "device: %u cmd: %02u payload: %016" PRIx64
> --
> 2.47.1
>
>

