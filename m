Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4C3C48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 00:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWmYp-0003zN-LH; Sun, 04 Feb 2024 19:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWmYo-0003zA-2A; Sun, 04 Feb 2024 19:10:06 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWmYc-0000hN-40; Sun, 04 Feb 2024 19:10:04 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-467ed334c40so1209580137.0; 
 Sun, 04 Feb 2024 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707091792; x=1707696592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUzFHCOJpN3HKFVR4AuVJuPiKGpMrz0euio/avhtkGo=;
 b=hI8ndN3OSAug0fKC8oeY/K3QkPtd7B8l8BiqQOwJ5Hun3G/m49pJS2rpgsci3wHuLm
 cfZuVEd8t3I6mxEU2Qh4fTjLp1li8mbD0ezTNMCMihchmzGsdQtAC4YHJryGNs+l6ybn
 Y4Okz2znSDxsuwuj9tpYOpRlVY5ttyNQwfNsq2Qjvkxjrt1HyMD+iX5RUAAodFEVcNaq
 vhD1TyQfiESlRGthXnRq2mFw+J4jSOY2uQ7P+MAWgIJ4xRuP6YeQVpWAr3eZbhrmD+83
 y5rpJqj6HGF6qyo74fdOkkey/cq10ijZRptw3SznnMXyjIFg5YQc+LXhXjCDxbYaGdD7
 zYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707091792; x=1707696592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUzFHCOJpN3HKFVR4AuVJuPiKGpMrz0euio/avhtkGo=;
 b=DrmFiHAetHV1H8aMYVmdtIT82G0dD+oH0EGhDhFqhpLpyvh2H4iJz6MTTfwLod9dbx
 Gk2vb0opnLlbFSlC6K4Gu3eG5UrVyu45IMcGn51YioZo/L7tAMSEohk6YGaoN5iOgmSf
 +Sp3GVhlqaKzCnRe8Bi2eNHtuWmBxIxbs9gM3vFSxFngi6WF/YM56Gt+E3pMKHLDyQHV
 pqYNTB0bkJKpg4QzPpJz1OoddIhWG6uSxJ/G57AWBuvcF+FpstVApHOdwJHKovfva1TG
 g5i6QSe/t9roY04oyakdh1bNHH66J/WPRDd/sDWIFa9bHnJiXdXo8ImGIoFpZjEjvTU6
 iBOQ==
X-Gm-Message-State: AOJu0YxH7hlx4j8D6kPa4o4bt4M8BBlcngddpuaQyx2OYM38efmCR3EB
 9T+6fpHwLcPxxubQeIkT8DqZV9PyX1z8ELx31f/HV92Q+6st1BXkb7SQXYyjPr2ry2eH9rsY1Nl
 eHikaUQ44dEXkjwAm+13p4IBEGxEJsfK/EOs=
X-Google-Smtp-Source: AGHT+IGKeVshKtmHLHM+26mnTW0O+rdrRuTq5eWHdmjvUK4XTtD3RanAyXWZKOHZGxzzHuW9JqwUA8XO/GaqJb0UUxs=
X-Received: by 2002:a05:6102:dc7:b0:46d:3043:92de with SMTP id
 e7-20020a0561020dc700b0046d304392demr751276vst.4.1707091791836; Sun, 04 Feb
 2024 16:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
 <20240126193657.792005-2-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240126193657.792005-2-ines.varhol@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 10:09:25 +1000
Message-ID: <CAKmqyKMt=GbObvc-oasr_s8a09OT-zxr99Y5ayRdz7hPF_4K8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/display : Add device DM163
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <sam@rfc1149.net>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jan 27, 2024 at 5:38=E2=80=AFAM In=C3=A8s Varhol
<ines.varhol@telecom-paris.fr> wrote:
>
> This device implements the IM120417002 colors shield v1.1 for Arduino
> (which relies on the DM163 8x3-channel led driving logic) and features
> a simple display of an 8x8 RGB matrix. The columns of the matrix are
> driven by the DM163 and the rows are driven externally.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/Kconfig         |   3 +
>  hw/display/dm163.c         | 307 +++++++++++++++++++++++++++++++++++++
>  hw/display/meson.build     |   1 +
>  hw/display/trace-events    |  13 ++
>  include/hw/display/dm163.h |  57 +++++++
>  5 files changed, 381 insertions(+)
>  create mode 100644 hw/display/dm163.c
>  create mode 100644 include/hw/display/dm163.h
>
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 1aafe1923d..4dbfc6e7af 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -139,3 +139,6 @@ config XLNX_DISPLAYPORT
>      bool
>      # defaults to "N", enabled by specific boards
>      depends on PIXMAN
> +
> +config DM163
> +    bool
> diff --git a/hw/display/dm163.c b/hw/display/dm163.c
> new file mode 100644
> index 0000000000..565fc84ddf
> --- /dev/null
> +++ b/hw/display/dm163.c
> @@ -0,0 +1,307 @@
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
> +#define ROW_PERSISTANCE 2
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
> +}
> +
> +static void dm163_dck_gpio_handler(void *opaque, int line, int new_state=
)
> +{
> +    DM163State *s =3D DM163(opaque);
> +
> +    if (new_state && !s->dck) {
> +        /*
> +         * On raising dck, sample selbk to get the bank to use, and
> +         * sample sin for the bit to enter into the bank shift buffer.
> +         */
> +        uint64_t *sb =3D
> +            s->selbk ? s->bank1_shift_register : s->bank0_shift_register=
;
> +        /* Output the outgoing bit on sout */
> +        const bool sout =3D (s->selbk ? sb[2] & MAKE_64BIT_MASK(63, 1) :
> +                           sb[2] & MAKE_64BIT_MASK(15, 1)) !=3D 0;
> +        qemu_set_irq(s->sout, sout);
> +        /* Enter sin into the shift buffer */
> +        sb[2] =3D (sb[2] << 1) | ((sb[1] >> 63) & 1);
> +        sb[1] =3D (sb[1] << 1) | ((sb[0] >> 63) & 1);
> +        sb[0] =3D (sb[0] << 1) | s->sin;
> +    }
> +
> +    s->dck =3D new_state;
> +    trace_dm163_dck(new_state);
> +}
> +
> +static void dm163_propagate_outputs(DM163State *s)
> +{
> +    s->last_buffer_idx =3D (s->last_buffer_idx + 1) % COLOR_BUFFER_SIZE;
> +    /* Values are output when reset and enable are both high. */
> +    if (s->rst_b && !s->en_b) {
> +        memcpy(s->outputs, s->latched_outputs, sizeof(s->outputs));
> +    } else {
> +        memset(s->outputs, 0, sizeof(s->outputs));
> +    }
> +    for (unsigned x =3D 0; x < RGB_MATRIX_NUM_COLS; x++) {
> +        trace_dm163_channels(3 * x, (uint8_t)(s->outputs[3 * x] >> 6));
> +        trace_dm163_channels(3 * x + 1, (uint8_t)(s->outputs[3 * x + 1] =
>> 6));
> +        trace_dm163_channels(3 * x + 2, (uint8_t)(s->outputs[3 * x + 2] =
>> 6));
> +        s->buffer[s->last_buffer_idx][x] =3D
> +            (s->outputs[3 * x + 2] >> 6) |
> +            ((s->outputs[3 * x + 1] << 2) & 0xFF00) |
> +            (((uint32_t)s->outputs[3 * x] << 10) & 0xFF0000);
> +    }
> +    for (unsigned row =3D 0; row < RGB_MATRIX_NUM_ROWS; row++) {
> +        if (s->activated_rows & (1 << row)) {
> +            s->buffer_idx_of_row[row] =3D s->last_buffer_idx;
> +        }
> +    }
> +}
> +
> +static void dm163_en_b_gpio_handler(void *opaque, int line, int new_stat=
e)
> +{
> +    DM163State *s =3D DM163(opaque);
> +
> +    s->en_b =3D new_state;
> +    dm163_propagate_outputs(s);
> +    trace_dm163_en_b(new_state);
> +}
> +
> +static inline uint8_t dm163_bank0(const DM163State *s, uint8_t led)
> +{
> +    /*
> +     * Bank 1 uses 6 bits per led, so a value may be stored accross
> +     * two uint64_t entries.
> +     */
> +    const uint8_t low_bit =3D 6 * led;
> +    const uint8_t low_word =3D low_bit / 64;
> +    const uint8_t high_word =3D (low_bit + 5) / 64;
> +    const uint8_t low_shift =3D low_bit % 64;
> +
> +    if (low_word =3D=3D high_word) {
> +        /* Simple case: the value belongs to one entry. */
> +        return (s->bank0_shift_register[low_word] &
> +                MAKE_64BIT_MASK(low_shift, 6)) >> low_shift;
> +    }
> +
> +    const uint8_t bits_in_low_word =3D 64 - low_shift;
> +    const uint8_t bits_in_high_word =3D 6 - bits_in_low_word;
> +    return ((s->bank0_shift_register[low_word] &
> +             MAKE_64BIT_MASK(low_shift, bits_in_low_word)) >>
> +            low_shift) |
> +           ((s->bank0_shift_register[high_word] &
> +             MAKE_64BIT_MASK(0, bits_in_high_word))
> +         << bits_in_low_word);
> +}
> +
> +static inline uint8_t dm163_bank1(const DM163State *s, uint8_t led)
> +{
> +    const uint64_t entry =3D s->bank1_shift_register[led / 8];
> +    const unsigned shift =3D 8 * (led % 8);
> +    return (entry & MAKE_64BIT_MASK(shift, 8)) >> shift;
> +}
> +
> +static void dm163_lat_b_gpio_handler(void *opaque, int line, int new_sta=
te)
> +{
> +    DM163State *s =3D DM163(opaque);
> +
> +    if (s->lat_b && !new_state) {
> +        for (int led =3D 0; led < DM163_NUM_LEDS; led++) {
> +            s->latched_outputs[led] =3D dm163_bank0(s, led) * dm163_bank=
1(s, led);
> +        }
> +        dm163_propagate_outputs(s);
> +    }
> +
> +    s->lat_b =3D new_state;
> +    trace_dm163_lat_b(new_state);
> +}
> +
> +static void dm163_rst_b_gpio_handler(void *opaque, int line, int new_sta=
te)
> +{
> +    DM163State *s =3D DM163(opaque);
> +
> +    s->rst_b =3D new_state;
> +    dm163_propagate_outputs(s);
> +    trace_dm163_rst_b(new_state);
> +}
> +
> +static void dm163_selbk_gpio_handler(void *opaque, int line, int new_sta=
te)
> +{
> +    DM163State *s =3D DM163(opaque);
> +
> +    s->selbk =3D new_state;
> +    trace_dm163_selbk(new_state);
> +}
> +
> +static void dm163_sin_gpio_handler(void *opaque, int line, int new_state=
)
> +{
> +    DM163State *s =3D DM163(opaque);
> +
> +    s->sin =3D new_state;
> +    trace_dm163_sin(new_state);
> +}
> +
> +static void dm163_rows_gpio_handler(void *opaque, int line, int new_stat=
e)
> +{
> +    DM163State *s =3D DM163(opaque);
> +
> +    if (new_state) {
> +        s->activated_rows |=3D (1 << line);
> +        s->buffer_idx_of_row[line] =3D s->last_buffer_idx;
> +        s->age_of_row[line] =3D 0;
> +    } else {
> +        s->activated_rows &=3D ~(1 << line);
> +        s->age_of_row[line] =3D ROW_PERSISTANCE;
> +    }
> +    trace_dm163_activated_rows(s->activated_rows);
> +}
> +
> +static void dm163_invalidate_display(void *opaque)
> +{
> +}
> +
> +static void dm163_update_display(void *opaque)
> +{
> +    DM163State *s =3D (DM163State *)opaque;
> +    DisplaySurface *surface =3D qemu_console_surface(s->console);
> +    uint32_t *dest;
> +    unsigned bits_ppi =3D surface_bits_per_pixel(surface);
> +
> +    trace_dm163_bits_ppi(bits_ppi);
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
> +     *
> +     * if (dpy_ui_info_supported(s->console)) {
> +     *     trace_dm163_refresh_rate(dpy_get_ui_info(s->console)->refresh=
_rate);
> +     * } else {
> +     *     trace_dm163_refresh_rate(0);
> +     * }
> +     */
> +    dpy_gfx_update(s->console, 0, 0, RGB_MATRIX_NUM_COLS * LED_SQUARE_SI=
ZE,
> +                   RGB_MATRIX_NUM_ROWS * LED_SQUARE_SIZE);
> +}
> +
> +static const GraphicHwOps dm163_ops =3D {
> +    .invalidate  =3D dm163_invalidate_display,
> +    .gfx_update  =3D dm163_update_display,
> +};
> +
> +static void dm163_realize(DeviceState *dev, Error **errp)
> +{
> +    DM163State *s =3D DM163(dev);
> +
> +    qdev_init_gpio_in(dev, dm163_rows_gpio_handler, 8);
> +    qdev_init_gpio_in(dev, dm163_sin_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_dck_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_rst_b_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_lat_b_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_selbk_gpio_handler, 1);
> +    qdev_init_gpio_in(dev, dm163_en_b_gpio_handler, 1);
> +    qdev_init_gpio_out_named(dev, &s->sout, "sout", 1);
> +
> +    s->console =3D graphic_console_init(dev, 0, &dm163_ops, s);
> +    qemu_console_resize(s->console, RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZ=
E,
> +                        RGB_MATRIX_NUM_ROWS * LED_SQUARE_SIZE);
> +}
> +
> +static void dm163_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    dc->desc =3D "DM163";
> +    dc->vmsd =3D &vmstate_dm163;
> +    dc->realize =3D dm163_realize;
> +    rc->phases.hold =3D dm163_reset_hold;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +}
> +
> +static const TypeInfo dm163_types[] =3D {
> +    {
> +        .name =3D TYPE_DM163,
> +        .parent =3D TYPE_DEVICE,
> +        .instance_size =3D sizeof(DM163State),
> +        .class_init =3D dm163_class_init
> +    }
> +};
> +
> +DEFINE_TYPES(dm163_types)
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index f93a69f70f..71e489308e 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('=
next-fb.c'))
>
>  system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
>  system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
> +system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
>
>  if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
>      config_all_devices.has_key('CONFIG_VGA_PCI') or
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 2336a0ca15..444b014d6e 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -177,3 +177,16 @@ macfb_ctrl_write(uint64_t addr, uint64_t value, unsi=
gned int size) "addr 0x%"PRI
>  macfb_sense_read(uint32_t value) "video sense: 0x%"PRIx32
>  macfb_sense_write(uint32_t value) "video sense: 0x%"PRIx32
>  macfb_update_mode(uint32_t width, uint32_t height, uint8_t depth) "setti=
ng mode to width %"PRId32 " height %"PRId32 " size %d"
> +
> +# dm163.c
> +dm163_dck(int new_state) "dck : %d"
> +dm163_en_b(int new_state) "en_b : %d"
> +dm163_rst_b(int new_state) "rst_b : %d"
> +dm163_lat_b(int new_state) "lat_b : %d"
> +dm163_sin(int new_state) "sin : %d"
> +dm163_selbk(int new_state) "selbk : %d"
> +dm163_activated_rows(int new_state) "Activated rows : 0x%" PRIx32 ""
> +dm163_bits_ppi(unsigned dest_width) "dest_width : %u"
> +dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> +dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> +dm163_refresh_rate(uint32_t rr) "refresh rate %d"
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
> +    uint8_t age_of_row[RGB_MATRIX_NUM_ROWS];
> +} DM163State;
> +
> +#endif /* HW_DISPLAY_DM163_H */
> --
> 2.43.0
>
>

