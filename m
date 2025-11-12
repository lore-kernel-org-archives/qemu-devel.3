Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9685CCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 02:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ0D0-000330-44; Tue, 11 Nov 2025 21:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ0Cy-00031x-CR
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 21:03:40 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ0Cv-0004O7-Dp
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 21:03:40 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b73161849e1so62429366b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 18:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762913015; x=1763517815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4Va8c6OPMRrscisMdJqeUCRm70mbmVuUFwICVdanFw=;
 b=mNY8jW05naQ3E4fbNB/t5lBkR319hmWUQe0OoVtDSEIcToPIGjtK+YRbfxYksjMTn9
 3ot8y92c5tTtBqS+EB8ReaZy4ID7HDHM+XbPSQ0stO9+QvJEiAWrWYbsp9TytmTfQWm0
 L4wKiaujO+VlmITKbev74LmYfYqfh2r66TAQY8s/oR2ltrHRw+tgDCYoEJF58YsQu1gt
 GXOF+4XFsSbwZEpqCMMOFOYrkqzgW5KqzWm+UbLPdQjgdnJspxFMTol5ACt7nPwsW2E4
 4ymwMEISx3d05NeboF8ouLYL40S6yeJnjjnkU2jhtyb8dS5fFZ3VnkevEAx79vLQjGk5
 C9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762913015; x=1763517815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s4Va8c6OPMRrscisMdJqeUCRm70mbmVuUFwICVdanFw=;
 b=uHg1bjDGcRU/W1cVWYBgwU4p4yNDBa1qoFAjhALWGaxOmPLokh4mNNT2+7y7e05Bz1
 7p/s+biIAnc70F3GLc3ZsRXqt+3U5sPrSE9ctZR69B6nzGbMaLWh8X3H9SyokqYG1Yfu
 2KpJJKy7671yvlIN4Ewc8bC4dDlzSqY7vPeoloIKdsdFqZV6fPd2DGbiIv0+SFBtzLUo
 sOX3uQe4aNf4nbr+kSefiTxO17k5Rhs3syL4Y+CilJoi4YoiZXdMRQETfD0L9ikHGFeJ
 WduMDsQ01fssNo5OFH1NvujeCANnyffauVhwZaNb3D0BPJbJJZRG+92rrCqx0VsGapAu
 CUlA==
X-Gm-Message-State: AOJu0Yxz5aekZ/7WhKisJReSVuPeFZmRtw8Y5LE78d1WJYxXryru8f5O
 18ScSnOtxVNFCrcdzKB2tRk6FKtcDGmqtx4mNjcGrxwCvro8gOsuFHxHT6b+OnyksyOQoDDxtfE
 kQcrY32HrFt5IL4rRLWoWW2P0cpdCKrw=
X-Gm-Gg: ASbGnct8ztifaOSDrccKzb8fIiYK93KyhTVIc+FNDxzFL2B6Y3bWlD88L0kMPuysXA+
 /UqPyqb5RMXRq4PW3fugGZoTMqaP19/PxEsLF/35D3y7f8YILbrEHx6YH8q+2tHbYfqMMPfN9q5
 f2VQTf3/JqnIeoemfA4ytTOgnLa8Y2k4DZEzo13TVuxKTjUsLByypLIDLEROKL2iIIdIooMq/0R
 ykv1ylBHtlFkvkoy7TphMKUrFLJfazUm19MfRqmgAkyKFl0UwAo7nGcQcWZIgD4y+6f35JOr4ET
 Ru2+q332+ol07aZ85yQLW3wsxw==
X-Google-Smtp-Source: AGHT+IG2p2ua7HGbjaBQPqF7dtVrOi/E0ybiMjd2vmTJyktv4qlvHzzgOHz5JlFaAqyRwMbKYdvXHzDy0iZro6Nl59w=
X-Received: by 2002:a17:907:d0e:b0:b73:3028:93a1 with SMTP id
 a640c23a62f3a-b7331958c1fmr130111166b.9.1762913015376; Tue, 11 Nov 2025
 18:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-4-michael@videogpu.com>
In-Reply-To: <20251027100938.11822-4-michael@videogpu.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 12:03:09 +1000
X-Gm-Features: AWmQ_bm6738B14j2BV9ocKuJLDEhynJ3AQPLSotdTlV4VpNW4pKId7zGh3BYK9U
Message-ID: <CAKmqyKNbcAv9OsbxOv9cA1Dmk5xNXdEqoupS2FgZS9g_D1vfwQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] hw/char: add NEORV32 UART (CTRL/DATA, fifo,
 chardev)
To: Michael Levit <michael@videogpu.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, smishash@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

On Mon, Oct 27, 2025 at 8:12=E2=80=AFPM Michael Levit <michael@videogpu.com=
> wrote:
>
> From: Michael <michael@videogpu.com>
>
> Add NEORV32 UART device: CTRL/DATA registers, RX FIFO, TX to chardev.
> Includes Kconfig/meson and public header.
>
> Signed-off-by: Michael Levit <michael@videogpu.com>
>
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 020c0a84bb..1fd39c2b30 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -95,3 +95,6 @@ config IP_OCTAL_232
>      bool
>      default y
>      depends on IPACK
> +
> +config NEORV32_UART
> +    bool
>
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index a9e1dc26c0..2f5bf827a7 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap=
_uart.c'))
>  system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
>  system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'=
))
>  system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'=
))
> +system_ss.add(when: 'CONFIG_NEORV32_UART', if_true: files('neorv32_uart.=
c'))
>  system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
>  system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_=
usart.c'))
>  system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_=
usart.c'))
>
> diff --git a/hw/char/neorv32_uart.c b/hw/char/neorv32_uart.c
> new file mode 100644
> index 0000000000..b54ab54d6a
> --- /dev/null
> +++ b/hw/char/neorv32_uart.c
> @@ -0,0 +1,311 @@
> +/*
> + * Neorv32-specific UART.
> + *
> + * Copyright (c) 2025 Michael Levit
> + *
> + * Author:
> + *   Michael Levit <michael@videogpu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "migration/vmstate.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
> +#include "hw/irq.h"
> +#include "hw/char/neorv32_uart.h"
> +#include "hw/qdev-properties-system.h"
> +
> +typedef volatile struct __attribute__((packed,aligned(4))) {
> +  uint32_t CTRL;  /**< offset 0: control register (#NEORV32_UART_CTRL_en=
um) */
> +  uint32_t DATA;  /**< offset 4: data register  (#NEORV32_UART_DATA_enum=
) */
> +} neorv32_uart_t;

This doesn't seem to be used at all

Alistair

> +
> +#define NEORV32_UART_IO_REGION_SIZE  (32)
> +
> +static Property neorv32_uart_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev", Neorv32UARTState, chr),
> +};
> +
> +enum {
> +    NEORV32_UART_CTRL =3D 0,  /**< offset 0: control register */
> +    NEORV32_UART_DATA =3D 4  /**< offset 4: data register  */
> +};
> +
> +/** UART control register bits */
> +enum NEORV32_UART_CTRL_enum {
> +  UART_CTRL_EN            =3D  0, /**< UART control register(0)  (r/w): =
UART global enable */
> +  UART_CTRL_SIM_MODE      =3D  1, /**< UART control register(1)  (r/w): =
Simulation output override enable */
> +  UART_CTRL_HWFC_EN       =3D  2, /**< UART control register(2)  (r/w): =
Enable RTS/CTS hardware flow-control */
> +  UART_CTRL_PRSC_LSB      =3D  3, /**< UART control register(3)  (r/w): =
clock prescaler select, bit 0 (LSB) */
> +  UART_CTRL_PRSC_MSB      =3D  5, /**< UART control register(5)  (r/w): =
clock prescaler select, bit 2 (MSB) */
> +  UART_CTRL_BAUD_LSB      =3D  6, /**< UART control register(6)  (r/w): =
BAUD rate divisor, bit 0 (LSB) */
> +  UART_CTRL_BAUD_MSB      =3D 15, /**< UART control register(15) (r/w): =
BAUD rate divisor, bit 9 (MSB) */
> +  UART_CTRL_RX_NEMPTY     =3D 16, /**< UART control register(16) (r/-): =
RX FIFO not empty */
> +  UART_CTRL_RX_FULL       =3D 17, /**< UART control register(17) (r/-): =
RX FIFO full */
> +  UART_CTRL_TX_EMPTY      =3D 18, /**< UART control register(18) (r/-): =
TX FIFO empty */
> +  UART_CTRL_TX_NFULL      =3D 19, /**< UART control register(19) (r/-): =
TX FIFO not full */
> +  UART_CTRL_IRQ_RX_NEMPTY =3D 20, /**< UART control register(20) (r/w): =
Fire IRQ if RX FIFO not empty */
> +  UART_CTRL_IRQ_RX_FULL   =3D 21, /**< UART control register(21) (r/w): =
Fire IRQ if RX FIFO full */
> +  UART_CTRL_IRQ_TX_EMPTY  =3D 22, /**< UART control register(22) (r/w): =
Fire IRQ if TX FIFO empty */
> +  UART_CTRL_IRQ_TX_NFULL  =3D 23, /**< UART control register(23) (r/w): =
Fire IRQ if TX FIFO not full */
> +
> +  UART_CTRL_RX_OVER       =3D 30, /**< UART control register(30) (r/-): =
RX FIFO overflow */
> +  UART_CTRL_TX_BUSY       =3D 31  /**< UART control register(31) (r/-): =
Transmitter busy or TX FIFO not empty */
> +};
> +
> +/**  bits */
> +enum NEORV32_UART_DATA_enum {
> +  UART_DATA_RTX_LSB          =3D  0, /**< (r/w): UART rx/tx data, LSB */
> +  UART_DATA_RTX_MSB          =3D  7, /**< (r/w): UART rx/tx data, MSB */
> +
> +  UART_DATA_RX_FIFO_SIZE_LSB =3D  8, /**< (r/-): log2(RX FIFO size), LSB=
 */
> +  UART_DATA_RX_FIFO_SIZE_MSB =3D 11, /**< (r/-): log2(RX FIFO size), MSB=
 */
> +
> +  UART_DATA_TX_FIFO_SIZE_LSB =3D 12, /**< (r/-): log2(RX FIFO size), LSB=
 */
> +  UART_DATA_TX_FIFO_SIZE_MSB =3D 15, /**< (r/-): log2(RX FIFO size), MSB=
 */
> +};
> +/**@}*/
> +
> +static void neorv32_uart_update_irq(Neorv32UARTState *s)
> +{
> +    int cond =3D 0;
> +    if ((s->ie & NEORV32_UART_IE_TXWM) ||
> +        ((s->ie & NEORV32_UART_IE_RXWM) && s->rx_fifo_len)) {
> +        cond =3D 1;
> +    }
> +    if (cond) {
> +        qemu_irq_raise(s->irq);
> +    } else {
> +        qemu_irq_lower(s->irq);
> +    }
> +}
> +
> +static uint64_t
> +neorv32_uart_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    Neorv32UARTState *s =3D opaque;
> +    unsigned char r;
> +
> +    switch (addr) {
> +        case NEORV32_UART_CTRL:
> +                       if (s->rx_fifo_len) {
> +                               s->CTRL |=3D (1 << UART_CTRL_RX_NEMPTY); =
/* set data available */
> +                       } else {
> +                               s->CTRL &=3D ~(1 << UART_CTRL_RX_NEMPTY);=
 /* clear data available */
> +                       }
> +                       //TODO: assuming here TX is always avalable, fix =
it.
> +                       s->CTRL |=3D (1 << UART_CTRL_TX_NFULL); /* set TX=
 not full */
> +
> +               return s->CTRL;
> +
> +        case NEORV32_UART_DATA:
> +            if (s->rx_fifo_len) {
> +                r =3D s->rx_fifo[0];
> +                memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
> +                s->rx_fifo_len--;
> +                qemu_chr_fe_accept_input(&s->chr);
> +                s->DATA =3D r;
> +
> +                neorv32_uart_update_irq(s); /* TODO: check if need to ca=
ll */
> +                return r;
> +            }
> +        }
> +
> +
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr=3D0x%x\n",
> +                  __func__, (int)addr);
> +    return 0;
> +}
> +
> +
> +
> +static void
> +neorv32_uart_write(void *opaque, hwaddr addr,
> +                  uint64_t val64, unsigned int size)
> +{
> +
> +    Neorv32UARTState *s =3D opaque;
> +    uint32_t value =3D val64;
> +    unsigned char ch =3D value;
> +
> +    /* TODO: check if need to update data and control bits */
> +    switch (addr) {
> +        case NEORV32_UART_CTRL:
> +            s->CTRL =3D value;
> +            /* TODO: check if need to call, depending on IRQ flags */
> +            /* neorv32_uart_update_irq(s); */
> +            return;
> +        case NEORV32_UART_DATA:
> +            s->DATA =3D value;
> +            qemu_chr_fe_write(&s->chr, &ch, 1);
> +            /* neorv32_uart_update_irq(s); TODO: check if need to call *=
/
> +            return;
> +        }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=3D0x%x v=3D0x%x\=
n",
> +                  __func__, (int)addr, (int)value);
> +}
> +
> +static const MemoryRegionOps neorv32_uart_ops =3D {
> +    .read  =3D neorv32_uart_read,
> +    .write =3D neorv32_uart_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4
> +    }
> +};
> +
> +static void neorv32_uart_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    Neorv32UARTState *s =3D NEORV32_UART(obj);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &neorv32_uart_ops, s,
> +                          TYPE_NEORV32_UART, NEORV32_UART_IO_REGION_SIZE=
);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +
> +static void neorv32_uart_rx(void *opaque, const uint8_t *buf, int size)
> +{
> +    Neorv32UARTState *s =3D opaque;
> +
> +    /* Got a byte.  */
> +    if (s->rx_fifo_len >=3D sizeof(s->rx_fifo)) {
> +        printf("WARNING: UART dropped char.\n");
> +        return;
> +    }
> +    s->rx_fifo[s->rx_fifo_len++] =3D *buf;
> +
> +    neorv32_uart_update_irq(s);
> +}
> +
> +static int neorv32_uart_can_rx(void *opaque)
> +{
> +    Neorv32UARTState *s =3D opaque;
> +
> +    return s->rx_fifo_len < sizeof(s->rx_fifo);
> +}
> +
> +static void neorv32_uart_event(void *opaque, QEMUChrEvent event)
> +{
> +}
> +
> +static int  neorv32_uart_be_change(void *opaque)
> +{
> +    Neorv32UARTState *s =3D opaque;
> +
> +    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_=
rx,
> +                             neorv32_uart_event, neorv32_uart_be_change,=
 s,
> +                             NULL, true);
> +
> +    return 0;
> +}
> +
> +static void neorv32_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    Neorv32UARTState *s =3D NEORV32_UART(dev);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_=
rx,
> +                            neorv32_uart_event, neorv32_uart_be_change, =
s,
> +                             NULL, true);
> +
> +}
> +
> +static const VMStateDescription vmstate_neorv32_uart =3D {
> +    .name =3D TYPE_NEORV32_UART,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(rx_fifo,
> +                            Neorv32UARTState,
> +                            NEORV32_UART_RX_FIFO_SIZE),
> +        VMSTATE_UINT8(rx_fifo_len, Neorv32UARTState),
> +        VMSTATE_UINT32(ie, Neorv32UARTState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void neorv32_uart_reset_enter(Object *obj, ResetType type)
> +{
> +    Neorv32UARTState *s =3D NEORV32_UART(obj);
> +    s->rx_fifo_len =3D 0;
> +    s->ie =3D 0;
> +}
> +
> +static void neorv32_uart_reset_hold(Object *obj, ResetType type)
> +{
> +    Neorv32UARTState *s =3D NEORV32_UART(obj);
> +    qemu_irq_lower(s->irq);
> +}
> +
> +static void neorv32_uart_class_init(ObjectClass *oc,const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(oc);
> +
> +    dc->realize =3D neorv32_uart_realize;
> +    dc->vmsd =3D &vmstate_neorv32_uart;
> +    rc->phases.enter =3D neorv32_uart_reset_enter;
> +    rc->phases.hold  =3D neorv32_uart_reset_hold;
> +    device_class_set_props(dc, neorv32_uart_properties);
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static const TypeInfo neorv32_uart_info =3D {
> +    .name          =3D TYPE_NEORV32_UART,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(Neorv32UARTState),
> +    .instance_init =3D neorv32_uart_init,
> +    .class_init    =3D neorv32_uart_class_init,
> +};
> +
> +static void neorv32_uart_register_types(void)
> +{
> +    type_register_static(&neorv32_uart_info);
> +}
> +
> +type_init(neorv32_uart_register_types)
> +/*
> + * Create UART device.
> + */
> +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space,
> +                                      hwaddr base,
> +                                      Chardev *chr)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +    bool succed=3D false;
> +
> +    dev =3D qdev_new("riscv.neorv32.uart");
> +
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    s =3D SYS_BUS_DEVICE(dev);
> +    succed =3D sysbus_realize_and_unref(s, &error_fatal);
> +
> +    if (succed) {
> +        memory_region_add_subregion(address_space, base,
> +                                    sysbus_mmio_get_region(s, 0));
> +        return NEORV32_UART(dev);
> +    } else {
> +        return NULL;
> +    }
> +} //neorv32_uart_create
>
> diff --git a/include/hw/char/neorv32_uart.h b/include/hw/char/neorv32_uar=
t.h
> new file mode 100644
> index 0000000000..3651d4741f
> --- /dev/null
> +++ b/include/hw/char/neorv32_uart.h
> @@ -0,0 +1,68 @@
> +/*
> + * Neorv32-specific UART.
> + *
> + * Copyright (c) 2025 Michael Levit
> + *
> + * Author:
> + *   Michael Levit <michael@videogpu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_NEORV32_UART_H
> +#define HW_NEORV32_UART_H
> +
> +#include "chardev/char-fe.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_NEORV32_UART "riscv.neorv32.uart"
> +OBJECT_DECLARE_SIMPLE_TYPE(Neorv32UARTState, NEORV32_UART)
> +
> +#define QEMU_UART_DATA_RX_FIFO_SIZE_LSB  8 /**256 < UART data register(8=
)  (r/-): log2(RX FIFO size), LSB */
> +#define QEMU_UART_DATA_RX_FIFO_SIZE_MSB  11 /** 2048 < UART data registe=
r(11) (r/-): log2(RX FIFO size), MSB */
> +
> +#define NEORV32_UART_RX_FIFO_SIZE  32 //in HW it is  2048 + 256 =3D _MSB=
 + _LSB
> +
> +enum {
> +       NEORV32_UART_IE_TXWM       =3D 1, /* Transmit watermark interrupt=
 enable */
> +       NEORV32_UART_IE_RXWM       =3D 2  /* Receive watermark interrupt =
enable */
> +};
> +
> +enum {
> +       NEORV32_UART_IP_TXWM       =3D 1, /* Transmit watermark interrupt=
 pending */
> +       NEORV32_UART_IP_RXWM       =3D 2  /* Receive watermark interrupt =
pending */
> +};
> +
> +
> +
> +struct Neorv32UARTState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    qemu_irq irq;
> +    MemoryRegion mmio;
> +    CharBackend chr;
> +    uint8_t rx_fifo[NEORV32_UART_RX_FIFO_SIZE];
> +    uint8_t rx_fifo_len;
> +    uint32_t ie; //interrupt enable
> +    uint32_t CTRL;
> +    uint32_t DATA;
> +};
> +
> +Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space, hwadd=
r base,
> +    Chardev *chr);
> +
> +#endif //HW_NEORV32_UART_H
>

