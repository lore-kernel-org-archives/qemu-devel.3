Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6526CC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 03:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYdMI-0002PY-7n; Thu, 16 Jan 2025 22:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYdMC-0002PE-Jb; Thu, 16 Jan 2025 22:49:16 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYdM9-0004iq-4W; Thu, 16 Jan 2025 22:49:15 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-518c46cc6e4so434477e0c.3; 
 Thu, 16 Jan 2025 19:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737085750; x=1737690550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5WwhmqBQIl7znAzfoBMjm0WAQMm9oqHMaTXtv4we1v8=;
 b=Qvoq3m16vallhR8snHMjBbzNk4o5I7spA73SmTElEnnXYCbOvq4QiKoU6aznyjQF4B
 4aasRd+6DMJKlOmLvK9sFY6c1OHMhiwmtVYG8ivoX+mQFOfuIB2HU3Q9f+avZDd/A+/N
 v2nF7ZkE0VQLUFrP1/qDIGyB7vRmfj0HAsRsLwYhihQN26VAhfEdT3OUT/8ao8eL+Bth
 KTEVRaqXu/XyDv9bWvJ5kybpAB4tNL/sRFeDlUix5D38pMkHfheAIhC1Ybcw+eD/GxrZ
 LUsRtmezf961EpBFd0wnlzKfPiOqqwwcxW/mfIenekTXH6niVrW1kKfVN06rvJdYos24
 uQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737085750; x=1737690550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5WwhmqBQIl7znAzfoBMjm0WAQMm9oqHMaTXtv4we1v8=;
 b=heLBJpKXXJtO2AWLMI8GIktFmWci5j8hEHYhFtRZkSUNmeDrPOm5V72zgvi3pZ3Uv8
 sTIFZgP56b/Xh5v69TQxl+IA/62bLQ2qxZVcUxF0+fBqqxx0L1s/anQhpxzj/QCHwQ4A
 PWFLqHyK+4h+lM6qd/QprErFbUJxEQTpRySoqNkJcEIKN+ld3ChUb34w+iwxC/SV48/1
 LfVp+AWP1TnpwWc2gcNFs/mKgLrl2X2pYdfYZS14Wp3TeBopQJNXReVuNCq3aUZ2OIFF
 s2K0xuwr/wUROmESJPckG1MJg64IZ3n0v6ZLrjQfqhpVdfzf6RVJLm+yRTaKrfyItEq8
 POrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyg/MfeSISeicbdN9jXRoK0ikpGrJ8nP8C2+RCdayvlLwHqnEY34ix6EFFf92Eb5u4UO8j+H9cyigi@nongnu.org
X-Gm-Message-State: AOJu0YzeZFFuxt1XfIY4P8Pau8thRZRJZRIeKYDScRXbJFg2Rqv3Q1Sj
 0lrmWthX++V/3zjyrzZxkROKPQGtIir0tdQhUOAkLfGe8+wzsYiGKGP08v+0n4jXHDbwYb314vk
 vsaumLrqsGuMpdpiUlLo6CbG0Sgk=
X-Gm-Gg: ASbGncsq1rMkpVJm4lF0lkF0sYrksAaQpV616yAsdQcCYgp/wwXpwnKfrrJ5T92tzyh
 PlETsvpslbKkFrgxWV865QTuGJvFf3ayzN2TWEBqwRgYQRM21B83ClhUpMQADovSAOhE=
X-Google-Smtp-Source: AGHT+IHBCnR7RINpDOHSz19V7tM8Z0U0tOH/Q+OKKO415CTXVl6DViygL/0uuCZ5j0a/lASYjVb/32pfscyPA18qksg=
X-Received: by 2002:a05:6122:3d46:b0:518:a261:adca with SMTP id
 71dfb90a1353d-51d5b301146mr913004e0c.8.1737085750455; Thu, 16 Jan 2025
 19:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20250116223609.81594-1-philmd@linaro.org>
In-Reply-To: <20250116223609.81594-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Jan 2025 13:48:44 +1000
X-Gm-Features: AbW1kvYVtOZLnR1dsUnRBQQt6CERsv43XhKCi8Bjvq5a3D4CqZq-lL_0CQr4XnM
Message-ID: <CAKmqyKNN3ev46pYn-B7Mng1Q4XMajRKA4D_VwqCLPB85KhcH8A@mail.gmail.com>
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

On Fri, Jan 17, 2025 at 8:37=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

