Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172B3C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3uJ-0000Ty-A8; Tue, 12 Mar 2024 11:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk3uI-0000Th-6P
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:19:10 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk3uF-0006VQ-Ff
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:19:09 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so7316297a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710256745; x=1710861545; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vckrPcfv6XciLm9Q/kHa2ZdTPe3qu0tjvxznEZ5BDnY=;
 b=mZeqkZB5JXQidpA5VJaVDtRAkleMO9Tl+oQc59cbAFeQMztBPMWamuuhhyvYcmZrT8
 FyEa2Nrq4z7KBMFmkldj5bulQbT/kcmnXKUC6JuPW+Vh3ZisT2brJRNnM3O6Zow1Npmy
 5w9eJ00Mav+3Q+put1xNUX2s7lqM1UDMfZUztSbDuue1P9gIM9cCrKtWFzGQU4bLJu6d
 gl6Do69Om+cS3JH6Rs6LD3vfw5GDKebbsbTUWYjQqg7kNNCrtf/wTPkKcb7ZroMtUrJc
 rqgjAbdgNdjRbvnVUJ5y98/Lweghnluu5LkgOW6sZRtYTpKkoFsXyz5P7Qp3V/JD0R67
 llYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710256745; x=1710861545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vckrPcfv6XciLm9Q/kHa2ZdTPe3qu0tjvxznEZ5BDnY=;
 b=iZ4QAXHTizkwDWTqvcxaF32KKohrKRqZ1kLHr1kLXtehVYoHoDLzlGi+xj003EX3ZD
 W+7qWfTIJ+n42jYCjxXffh73Koofy1vJgMJLIqLvmdjvkfNx5pfS2O9eUpl2oZiRy8Iw
 qCUThjbmFAqKakYQ6tjpqdugrRXfwHKnxQcsWkDqA0HQc8HTzlXRjDztUt1SW89BzvFe
 lRYa9gXk4kLgulBY5/ZfJy7LgnNHOVrG090D6LkxuCJKxZ3IqJsK/PxIFrrLwB5q9fFz
 60iT9duZu1e25n5MoR/CrnXG9hv4CcKCFncR9ICLnAs39sAMWCQgNJIXhSXrX56D4+GF
 MeAA==
X-Gm-Message-State: AOJu0Yw37OX90Jksih0plZpCtokmUOx4d+wzODMANDn+2tig6yZvsNaN
 D0WvALOWGAMzUULFNAQvpi/Id8j/FfLmSCREYtJg3wFnCBswXxRszdaWBqfxfcdXJfH9QCGMdrz
 Orj6isXmSFagusWwrIWfh0goDNaoRHhxdvpCibQ==
X-Google-Smtp-Source: AGHT+IF2jpls+rejUnX0ifRBg5YS9H6/iV7o/8+LYOw7vp/2g8hUbuqh/kbNUon7fXUAL6KCwQ7Hlh/xvL7OYfnoPjc=
X-Received: by 2002:a50:cd95:0:b0:567:45e2:c4db with SMTP id
 p21-20020a50cd95000000b0056745e2c4dbmr3121824edi.39.1710256745357; Tue, 12
 Mar 2024 08:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240228120215.277717-1-ines.varhol@telecom-paris.fr>
 <20240228120215.277717-2-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240228120215.277717-2-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 15:18:54 +0000
Message-ID: <CAFEAcA8LWa70KZMO1ajVLvKxwcbKQEQOHZ8Jy6JM75pr4jB9Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] hw/display : Add device DM163
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Samuel Tardieu <sam@rfc1149.net>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Wed, 28 Feb 2024 at 12:02, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> This device implements the IM120417002 colors shield v1.1 for Arduino
> (which relies on the DM163 8x3-channel led driving logic) and features
> a simple display of an 8x8 RGB matrix. The columns of the matrix are
> driven by the DM163 and the rows are driven externally.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  docs/system/arm/b-l475e-iot01a.rst |   3 +-
>  include/hw/display/dm163.h         |  57 ++++++
>  hw/display/dm163.c                 | 308 +++++++++++++++++++++++++++++
>  hw/display/Kconfig                 |   3 +
>  hw/display/meson.build             |   1 +
>  hw/display/trace-events            |  13 ++
>  6 files changed, 384 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/display/dm163.h
>  create mode 100644 hw/display/dm163.c
>
> diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e=
-iot01a.rst
> index 0afef8e4f4..60b9611167 100644
> --- a/docs/system/arm/b-l475e-iot01a.rst
> +++ b/docs/system/arm/b-l475e-iot01a.rst
> @@ -12,13 +12,14 @@ USART, I2C, SPI, CAN and USB OTG, as well as a variet=
y of sensors.
>  Supported devices
>  """""""""""""""""
>
> -Currently B-L475E-IOT01A machine's only supports the following devices:
> +Currently B-L475E-IOT01A machine's supports the following devices:

"machines support"

>
>  - Cortex-M4F based STM32L4x5 SoC
>  - STM32L4x5 EXTI (Extended interrupts and events controller)
>  - STM32L4x5 SYSCFG (System configuration controller)
>  - STM32L4x5 RCC (Reset and clock control)
>  - STM32L4x5 GPIOs (General-purpose I/Os)
> +- optional 8x8 led display (based on DM163 driver)
>
>  Missing devices
>  """""""""""""""
> diff --git a/include/hw/display/dm163.h b/include/hw/display/dm163.h
> new file mode 100644
> index 0000000000..aa775e51e1
> --- /dev/null
> +++ b/include/hw/display/dm163.h
> @@ -0,0 +1,57 @@
> +/*
> + * QEMU DM163 8x3-channel constant current led driver
> + * driving columns of associated 8x8 RGB matrix.
> + *
> + * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
> + * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (C) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_DISPLAY_DM163_H
> +#define HW_DISPLAY_DM163_H
> +
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_DM163 "dm163"
> +OBJECT_DECLARE_SIMPLE_TYPE(DM163State, DM163);
> +
> +#define DM163_NUM_LEDS 24
> +#define RGB_MATRIX_NUM_ROWS 8
> +#define RGB_MATRIX_NUM_COLS (DM163_NUM_LEDS / 3)
> +#define COLOR_BUFFER_SIZE RGB_MATRIX_NUM_ROWS
> +
> +typedef struct DM163State {
> +    DeviceState parent_obj;
> +
> +    /* DM163 driver */
> +    uint64_t bank0_shift_register[3];
> +    uint64_t bank1_shift_register[3];
> +    uint16_t latched_outputs[DM163_NUM_LEDS];
> +    uint16_t outputs[DM163_NUM_LEDS];
> +    qemu_irq sout;
> +
> +    uint8_t dck;
> +    uint8_t en_b;
> +    uint8_t lat_b;
> +    uint8_t rst_b;
> +    uint8_t selbk;
> +    uint8_t sin;
> +
> +    /* IM120417002 colors shield */
> +    uint8_t activated_rows;
> +
> +    /* 8x8 RGB matrix */
> +    QemuConsole *console;
> +    /* Rows currently being displayed on the matrix. */
> +    /* The last row is filled with 0 (turned off row) */
> +    uint32_t buffer[COLOR_BUFFER_SIZE + 1][RGB_MATRIX_NUM_COLS];
> +    uint8_t last_buffer_idx;
> +    uint8_t buffer_idx_of_row[RGB_MATRIX_NUM_ROWS];
> +    /* Used to simulate retinal persistance of rows */

"persistence" (I think there are some other instances of this
typo below as well.)

> +    uint8_t age_of_row[RGB_MATRIX_NUM_ROWS];
> +} DM163State;
> +
> +#endif /* HW_DISPLAY_DM163_H */
> diff --git a/hw/display/dm163.c b/hw/display/dm163.c
> new file mode 100644
> index 0000000000..87e886356a
> --- /dev/null
> +++ b/hw/display/dm163.c
> @@ -0,0 +1,308 @@
> +/*
> + * QEMU DM163 8x3-channel constant current led driver
> + * driving columns of associated 8x8 RGB matrix.
> + *
> + * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
> + * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (C) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/*
> + * The reference used for the DM163 is the following :
> + * http://www.siti.com.tw/product/spec/LED/DM163.pdf
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/display/dm163.h"
> +#include "ui/console.h"
> +#include "trace.h"
> +
> +#define LED_SQUARE_SIZE 100
> +/* Number of frames a row stays visible after being turned off. */
> +#define ROW_PERSISTANCE 4
> +
> +static const VMStateDescription vmstate_dm163 =3D {
> +    .name =3D TYPE_DM163,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT8(activated_rows, DM163State),
> +        VMSTATE_UINT64_ARRAY(bank0_shift_register, DM163State, 3),
> +        VMSTATE_UINT64_ARRAY(bank1_shift_register, DM163State, 3),
> +        VMSTATE_UINT16_ARRAY(latched_outputs, DM163State, DM163_NUM_LEDS=
),
> +        VMSTATE_UINT16_ARRAY(outputs, DM163State, DM163_NUM_LEDS),
> +        VMSTATE_UINT8(dck, DM163State),
> +        VMSTATE_UINT8(en_b, DM163State),
> +        VMSTATE_UINT8(lat_b, DM163State),
> +        VMSTATE_UINT8(rst_b, DM163State),
> +        VMSTATE_UINT8(selbk, DM163State),
> +        VMSTATE_UINT8(sin, DM163State),
> +        VMSTATE_UINT32_2DARRAY(buffer, DM163State,
> +            COLOR_BUFFER_SIZE + 1, RGB_MATRIX_NUM_COLS),
> +        VMSTATE_UINT8(last_buffer_idx, DM163State),
> +        VMSTATE_UINT8_ARRAY(buffer_idx_of_row, DM163State, RGB_MATRIX_NU=
M_ROWS),
> +        VMSTATE_UINT8_ARRAY(age_of_row, DM163State, RGB_MATRIX_NUM_ROWS)=
,
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void dm163_reset_hold(Object *obj)
> +{
> +    DM163State *s =3D DM163(obj);
> +
> +    /* Reset only stops the PWM. */
> +    memset(s->outputs, 0, sizeof(s->outputs));
> +
> +    /* The last row of the buffer stores a turned off row */
> +    memset(s->buffer[COLOR_BUFFER_SIZE], 0, sizeof(s->buffer[0]));

This reset function seems to be missing reset handling for
a lot of this device's state.

> +}


> +static void dm163_invalidate_display(void *opaque)
> +{
> +}

I'm not sure but I think the invalidate_display method is supposed
to at least do a qemu_console_resize() to the correct size.
It also typically sets a flag to tell the update_display method
that it needs to redraw the whole window.

> +
> +static void dm163_update_display(void *opaque)
> +{
> +    DM163State *s =3D (DM163State *)opaque;
> +    DisplaySurface *surface =3D qemu_console_surface(s->console);
> +    uint32_t *dest;
> +    unsigned bits_ppi =3D surface_bits_per_pixel(surface);
> +
> +    /* Should the code be updated to handle other bpp than 32 ? */

No. The UI layer guarantees that the console surface is always
32 bits per pixel. You don't need to assert that this is true.
(We still have some old display driver models which have legacy
code we never cleaned up from back when they had to cope with
possibly different console surface bit depths; but the handling
of other depths is just dead code in those devices.)

> +    /* trace_dm163_bits_ppi(bits_ppi); */
> +    g_assert((bits_ppi =3D=3D 32));
> +    dest =3D surface_data(surface);
> +    for (unsigned y =3D 0; y < RGB_MATRIX_NUM_ROWS; y++) {
> +        for (unsigned _ =3D 0; _ < LED_SQUARE_SIZE; _++) {
> +            for (int x =3D RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE - 1; x =
>=3D 0; x--) {
> +                *dest++ =3D s->buffer[s->buffer_idx_of_row[y]][x / LED_S=
QUARE_SIZE];
> +            }
> +        }
> +        if (s->age_of_row[y]) {
> +            s->age_of_row[y]--;
> +            if (!s->age_of_row[y]) {
> +                /*
> +                 * If the ROW_PERSISTANCE delay is up,
> +                 * the row is turned off.
> +                 * (s->buffer[COLOR_BUFFER] is filled with 0)
> +                 */
> +                s->buffer_idx_of_row[y] =3D COLOR_BUFFER_SIZE;
> +            }
> +        }
> +    }
> +    /*
> +     * Ideally set the refresh rate so that the row persistance
> +     * doesn't need to be changed.
> +     *
> +     * Currently `dpy_ui_info_supported(s->console)` returns false
> +     * which makes it impossible to get or set UIInfo.
> +     */
> +    if (dpy_ui_info_supported(s->console)) {
> +        trace_dm163_refresh_rate(dpy_get_ui_info(s->console)->refresh_ra=
te);
> +    } else {
> +        trace_dm163_refresh_rate(0);
> +    }

Why does this device care about the console's refresh rate at all?
It should just be displaying what it needs to display.
No other device in hw/display calls dpy_get_ui_info().

(The reason it returns false is because your GraphicHwOps struct
doesn't define a ui_info function -- dpy_get_ui_info()/dpy_set_ui_info()
is for the UI layer to tell the display device about changes in things
like refresh rate and window size, not for the display device to ask
something else for this information. This is typically only needed by
virtual devices like virtio-vga or xenfb, though, so I wouldn't
expect you to need to set a ui_info function.)

> +
> +    dpy_gfx_update(s->console, 0, 0, RGB_MATRIX_NUM_COLS * LED_SQUARE_SI=
ZE,
> +                   RGB_MATRIX_NUM_ROWS * LED_SQUARE_SIZE);

This will redraw the entire 800x800 window every time, which is
not very efficient. Do we really need to do that?

> +}
> +
> +static const GraphicHwOps dm163_ops =3D {
> +    .invalidate  =3D dm163_invalidate_display,
> +    .gfx_update  =3D dm163_update_display,
> +};

thanks
-- PMM

