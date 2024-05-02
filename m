Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11A2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2W5x-0003tH-SO; Thu, 02 May 2024 09:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2W5p-0003pd-Tn
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:03:24 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2W5m-0001HN-Ci
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:03:21 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51f2ebbd8a7so664920e87.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714654996; x=1715259796; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UnYklU7wFt5spAunF+K5IWnVUMOtY8YDbkBuJRc3i6w=;
 b=eyn9QSAHBb3vF0wIlAM5xYhsFF9tHaRtHTzEHnTO1M5eXAgXry/cLcgCz6R3tjgsBO
 BttVUsPeQgL7/Eo5mjK/CA680s9Q74QmvaxO9KORH8ETMHaO6hBDfQt+HVK8mXVYLHWi
 pJtAzAFz86epyQR2qmLHua7XvXuFCVszUmiC+L2nYPg2ydj9PE18fRKU/8uxBMQcsWjk
 r/FXFLRGK3qYHwYPFSB5tEHN+W3OsPZp2HeHAx2bNpO1LngbXHa2TqQZJRvUnmp9vVgU
 aQ+ICZQUM89ICJSFAuk55nKoTjqyIVO2dVp5yWbMmI5boJLb2oAEDehoIqrOVOUtMWnE
 KopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714654996; x=1715259796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UnYklU7wFt5spAunF+K5IWnVUMOtY8YDbkBuJRc3i6w=;
 b=AkW/EmHQXuYAnGpWmpzAdXeYCbrIyCUfBXmgwZDFaC5KQNZC/jKkPj5mjDEPGCEW/E
 sLKgGSmKn7oyc4R+JchoBAh27aRRIkQRRcELOzut6EWZdPjfve/ExXTJ1jGKkbp0nOny
 4DOV7kLScd1II4yI6CaLp7MFJWgJrpmdBKwfxdmR/u3OL6UcyIF1GHhaSS9dmsR35jxg
 iqb81cHtXg6NdgGTsQ8cgfOIDP0yYZp+AalV0E20NbYhu/T05HLEqJWiVEJ789KM5W4B
 SYe6on4XbddQ8ejYDdwHjJKYdAxWfllo+3M6JHwioBt5hOWg80MaviAoegUNvoGxwUnC
 lDLA==
X-Gm-Message-State: AOJu0Yz5nYcxPDTlaQjFydWi1TaTU02So/5ToEnNe9vlfJPeClqQTxyw
 /eVOeRMnGaA4SSOCMuOjkSvRhVSO7F8l2FlNy+7WB60uvZi60BEVw/6SIlZ3xYXzn+15qrXxyZn
 doeMEmfXWGX0V3FASxW2UyE5VJ5Zjz47xhMlZNw==
X-Google-Smtp-Source: AGHT+IGIGkXnS48pVLYdD5e3QOzmiGIyQv2lxCQbhsajyiWepze862J2K7zCtKeeGl5PuG8zpjEzy4vVJBYyDTTdn48=
X-Received: by 2002:a05:6512:3d24:b0:512:cc50:c3e0 with SMTP id
 d36-20020a0565123d2400b00512cc50c3e0mr4847363lfv.52.1714654994721; Thu, 02
 May 2024 06:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR18MB3245B1A3994C378A3BED5C439E1A2@MN2PR18MB3245.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB3245B1A3994C378A3BED5C439E1A2@MN2PR18MB3245.namprd18.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 14:03:03 +0100
Message-ID: <CAFEAcA_GahiNnn10itFccO-vqjzzLpSRmo2DixQdQhqrGYknvw@mail.gmail.com>
Subject: Re: [PATCH] hw/display: Add SSD1306 dot matrix display controller
 support
To: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 30 Apr 2024 at 21:01, Ryan Mamone
<ryan.mamone@cambridgeconsultants.com> wrote:
>
> From 617b2d92085d03524dcf5c223568a4856cdff47f Mon Sep 17 00:00:00 2001
>
> From: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
>
> Date: Tue, 30 Apr 2024 13:20:50 -0400
>
> Subject: [PATCH] hw/display: Add SSD1306 dot matrix display controller support

Hi; thanks for this patch. It looks like unfortunately your
mail client has mangled it somewhat (among other things, it's
got sent in multipart/mixed with HTML, and for some reason when
I reply to it there are blank lines between every line). You
might want to look into sending it with a mail client that can
send plain text emails for the next version. (git send-email
is what I use.)

Anyway, some initial review comments (and some more interspersed
with the code below):

What's the purpose of this device model? Is it intended to be
used with a particular board model? What's an example of
a command line and/or guest setup demonstrating its use?

This is the kind of thing that's useful to provide in the
commit message, since it gives readers a rationale for why
this device is being added.

(Our existing ssd0303 and ssd0323 device models are both used
by boards we have models for: the stellaris boards.)


> +++ b/hw/display/ssd1306.c
>
> @@ -0,0 +1,612 @@
>
> +/*
>
> + * SSD1306 Dot Matrix Display Controller.
>
> + *
>
> + * The SSD1306 controller can support a variety of different displays up to
>
> + * 128 x 64. The dimensions of the emulated display can be configured by the
>
> + * 'width' and 'height' properties and has been tested using the most common
>
> + * displays dimensions of 128x64 and 128x32. A 'scaling' property has also
>
> + * been provided to perform integer pixel scaling of the output image to make
>
> + * it more viewable on pc displays. While the SSD1306 controller supports
>
> + * multiple physical interfaces this implementation only supports the I2C
>
> + * interface. Most of the commands relating to physical control, scrolling,
>
> + * multiplexing, and scanning direction are ignored.
>
> + *
>
> + * Copyright (C) 2024 Cambridge Consultants.
>
> + * Written by Ryan Mamone
>
> + *
>
> + * This code is licensed under the GPL.

This is ambiguous -- please can you specify the exact version
of the GPL you're licensing the code under, eg "GPLv2 or later"?

>
> + */


Is there a publicly available datasheet for the device?
The top of the file is a good place for a comment giving the
title of the datasheet and (if possible) a URL where it can
be obtained.

> +
>
> +#include "qemu/osdep.h"
>
> +#include "qemu/error-report.h"
>
> +#include "hw/i2c/i2c.h"
>
> +#include "hw/qdev-properties.h"
>
> +#include "migration/vmstate.h"
>
> +#include "qemu/module.h"
>
> +#include "ui/console.h"
>
> +#include "qom/object.h"
>
> +
>
> +/*#define DEBUG_SSD1306 1*/
>
> +
>
> +#ifdef DEBUG_SSD1306
>
> +#define DPRINTF(fmt, ...) \
>
> +do { error_printf("ssd1306: " fmt , ## __VA_ARGS__); } while (0)
>
> +#define BADF(fmt, ...) \
>
> +do { error_printf("ssd1306: error: " fmt , ## __VA_ARGS__); } while (0)
>
> +#else
>
> +#define DPRINTF(fmt, ...) do {} while (0)
>
> +#define BADF(fmt, ...) \
>
> +do { error_printf("ssd1306: error: " fmt , ## __VA_ARGS__); } while (0)
>
> +#endif

Please don't use DPRINTF debug printing in new code: prefer
tracepoints for debug type messages and qemu_log_mask() for
guest errors and not-yet-implemented messages.

>
> +
>
> +
>
> +/* Max supported display dimensions of the SSD1306 controller */
>
> +#define MAX_WIDTH 128
>
> +#define MAX_HEIGHT 64
>
> +/* Max supported color depth 32bit */
>
> +#define MAX_BPP 32
>
> +
>
> +enum ssd1306_addr_mode {
>
> +    ssd1306_ADDR_MODE_HORIZ = 0,
>
> +    ssd1306_ADDR_MODE_VERT = 1,
>
> +    ssd1306_ADDR_MODE_PAGE = 2,
>
> +    ssd1306_ADDR_MODE_INVALID
>
> +};
>
> +
>
> +enum ssd1306_mode {
>
> +    ssd1306_IDLE,
>
> +    ssd1306_DATA,
>
> +    ssd1306_CMD,
>
> +    ssd1306_CMD_DATA
>
> +};
>
> +
>
> +#define TYPE_SSD1306 "ssd1306"
>
> +OBJECT_DECLARE_SIMPLE_TYPE(ssd1306_state, SSD1306)
>
> +
>
> +struct ssd1306_state {
>
> +    I2CSlave parent_obj;
>
> +
>
> +    QemuConsole *con;
>
> +    /* Emulated display dimensions */
>
> +    uint8_t width;
>
> +    uint8_t height;
>
> +    /* Integer scaling factor to enlarge pixels for better viewing on PC displays */
>
> +    uint8_t scaling_factor;

I don't think we should do this. AFAIK no other display device
does this; if we wanted to do it we'd probably be better off
doing it generically at the UI level.

>
> +    uint8_t addr_mode;
>
> +    uint8_t col;
>
> +    uint8_t col_start;
>
> +    uint8_t col_end;
>
> +    uint8_t page;
>
> +    uint8_t page_start;
>
> +    uint8_t page_end;
>
> +    int mirror;
>
> +    int flash;
>
> +    int enabled;
>
> +    int inverse;
>
> +    int redraw;

These seem to be used as booleans, so prefer "bool".

>
> +    enum ssd1306_mode mode;
>
> +    uint8_t cmd; /* Command ID byte */
>
> +    uint8_t cmd_byte_num; /* Command data parameter number */
>
> +    uint8_t mono_framebuffer[MAX_WIDTH * MAX_HEIGHT];
>
> +    uint8_t color_framebuffer[MAX_WIDTH * MAX_HEIGHT * (MAX_BPP / 8)];

The usage of these two arrays seems rather awkward:

 * data from the device is monochrome, 1 bit per pixel, but it
   comes in as a byte that has the pixels for a vertical run of
   8 pixels rather than the usual horizontal
 * we expand this out into mono_framebuffer at 1 byte per pixel
   in ssd1306_send()
 * then we expand it again from that into color_framebuffer
   in ssd1306_mono_to_color_fb()
 * then we copy that across into the destination surface
   in ssd1306_scale_fb(), possibly scaling it up

I think we'd be better with only one framebuffer data array,
not two, and going straight from that to the destination surface.
(Given the stuff in the datasheet about scrolling and dispaly
offsets and so on, it's tempting to suggest that we should store
the data in the same format the GDDRAM keeps it in, and do the
byte-to-column-of-pixels conversion as we write into the destination
surface. But I haven't thought through that idea completely.)

> +};
>
> +
>
> +/* Handler for I2C data transferred from SSD1306 controller */
>
> +static uint8_t ssd1306_recv(I2CSlave *i2c)
>
> +{
>
> +    BADF("Reads not implemented\n");
>
> +    return 0xff;
>
> +}
>
> +
>
> +/* Handler for I2C data transferred to SSD1306 controller */
>
> +static int ssd1306_send(I2CSlave *i2c, uint8_t data)
>
> +{
>
> +    ssd1306_state *s = SSD1306(i2c);
>
> +
>
> +    switch (s->mode) {
>
> +    case ssd1306_IDLE:
>
> +        s->mode = ((data & 0x40) == 0x40) ? ssd1306_DATA : ssd1306_CMD;
>
> +        break;
>
> +    case ssd1306_DATA:
>
> +        /*
>
> +         * Map incoming data to pixels at correct location in framebuffer.
>
> +         * Notably every 8 pixels are mapped vertically along the page
>
> +         * (ref Figure 10-2 in the datasheet).
>
> +         */
>
> +        for (int i = 0; i < 8; i++) {
>
> +            /* Simulating a monochrome display so just set/clear all bits */
>
> +            s->mono_framebuffer[(((s->page * 8) + i) * s->width) + s->col] =
>
> +                ((data >> i) & 0x01) ? 0xff : 0x00;
>
> +        }
>
> +
>
> +        /* GDDRAM pointers update differently dependent on the addressing mode */
>
> +        switch (s->addr_mode) {
>
> +        case ssd1306_ADDR_MODE_HORIZ: /* Horizontal Addressing Mode */
>
> +            s->col++;
>
> +            if (s->col > s->col_end) {
>
> +                s->col = s->col_start;
>
> +                s->page++;
>
> +                if (s->page > s->page_end) {
>
> +                    s->page = s->page_start;
>
> +                }
>
> +            }
>
> +            break;
>
> +        case ssd1306_ADDR_MODE_VERT: /* Vertical Addressing Mode (UNTESTED) */
>
> +            s->page++;
>
> +            if (s->page > s->page_end) {
>
> +                s->page = s->page_start;
>
> +                s->col++;
>
> +                if (s->col > s->col_end) {
>
> +                    s->col = s->col_start;
>
> +                }
>
> +            }
>
> +            break;
>
> +        case ssd1306_ADDR_MODE_PAGE: /* Page Addressing Mode (UNTESTED) */
>
> +            if (s->col < s->col_end) {
>
> +                s->col++;
>
> +            }
>
> +            break;
>
> +        default:
>
> +            break;
>
> +        }
>
> +        s->redraw = 1;
>
> +        break;
>
> +    case ssd1306_CMD:
>
> +            s->cmd = data;
>
> +            s->cmd_byte_num = 0;
>
> +            /*
>
> +             * Fallthrough so same code can handle commands with/without
>
> +             * additional data bytes.
>
> +             */
>
> +            __attribute__ ((fallthrough));
>
> +    case ssd1306_CMD_DATA:
>
> +        switch (s->cmd) {
>
> +        /*
>
> +         * Fundamental Commands
>
> +         */
>
> +        /* Set Contrast Control */

A lot of these commands look similar to those used in
sd0303 and sd0323. Is it worth trying to share
implementation between these device models, or do they
have too many divergences for it to be worthwhile ?


> +        case 0x81:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else {
>
> +                data = data;
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Entire display off (Use GDDRAM) */
>
> +        case 0xA4:
>
> +            s->flash = 0;
>
> +            s->redraw = 1;
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Entire display on (Ignore GDDRAM) */
>
> +        case 0xA5:
>
> +            s->flash = 1;
>
> +            s->redraw = 1;
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Inverse off */
>
> +        case 0xA6:
>
> +            s->inverse = 0;
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Inverse on */
>
> +        case 0xA7:
>
> +            s->inverse = 1;
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Display off */
>
> +        case 0xAE:
>
> +            s->enabled = 0;
>
> +            s->redraw = 1;
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Display on */
>
> +        case 0xAF:
>
> +            s->enabled = 1;
>
> +            s->redraw = 1;
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +
>
> +        /*
>
> +         * Scrolling Commands
>
> +         */
>
> +        /* Continuous Horizontal Scroll Setup (6 data bytes) */
>
> +        case 0x26 ... 0x27:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                DPRINTF("Continuous Horizontal Scroll Setup not implemented\n");
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 6) {
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Continuous Vertical and Horizontal Scroll Setup (5 data bytes) */
>
> +        case 0x29 ... 0x2A:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                DPRINTF("Continuous Vertical and Horizontal Scroll Setup not "
>
> +                        "implemented\n");
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 5) {
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Deactivate Scroll */
>
> +        case 0x2E:
>
> +            DPRINTF("Deactivate Scroll not implemented\n");
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Activate Scroll */
>
> +        case 0x2F:
>
> +            DPRINTF("Activate Scroll not implemented\n");
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Set Vertical Scroll (2 data bytes) */
>
> +        case 0xA3:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                DPRINTF("Set Vertical Scroll not implemented\n");
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 2) {
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +
>
> +        /*
>
> +         * Address Setting Commands
>
> +         */
>
> +        /* Set Lower Column Start Address for Page Addressing Mode */
>
> +        case 0x00 ... 0x0F:
>
> +            s->col = (s->col & 0xf0) | (data & 0xf);
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Set Higher Column Start Address for Page Addressing Mode */
>
> +        case 0x10 ... 0x1F:
>
> +            s->col = (s->col & 0x0f) | (data & 0xf);
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Set Memory Addressing Mode (1 data byte) */
>
> +        case 0x20:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                s->addr_mode = data & 0x3;
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Column Address (2 data bytes) */
>
> +        case 0x21:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                s->col_start = data & 0x7F;
>
> +                s->col = s->col_start;
>
> +            } else if (s->cmd_byte_num == 2) {
>
> +                s->col_end = data & 0x7F;
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Page Address (2 data bytes) */
>
> +        case 0x22:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                s->page_start = data & 0x07;
>
> +                s->page = s->page_start;
>
> +            } else if (s->cmd_byte_num == 2) {
>
> +                s->page_end = data & 0x07;
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Page Start Address for Page Addressing Mode */
>
> +        case 0xB0 ... 0xB7:
>
> +            s->page = data & 0x07;
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +
>
> +        /*
>
> +         * Hardware Configuration Commands
>
> +         */
>
> +        /* Set Display Start Line */
>
> +        case 0x40 ... 0x7F:
>
> +            if (s->cmd != 0x40) {
>
> +                DPRINTF("Set Display Start Line (cmd 0x%02x) not implemented\n", s->cmd);
>
> +            }
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Set Segment Re-map */
>
> +        case 0xA0 ... 0xA1:
>
> +            if (s->cmd == 0xA1) {
>
> +                DPRINTF("Set Segment Re-map (cmd 0x%02x) not implemented\n", s->cmd);
>
> +            }
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Set Multiplex Ratio (1 data byte) */
>
> +        case 0xA8:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                if (data != s->height - 1) {
>
> +                    DPRINTF("Set Multiplex Ratio (0x%02x) not implemented\n", data);
>
> +                }
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set COM Output Scan Direction */
>
> +        case 0xC0 ... 0xC8:
>
> +            if (s->cmd == 0xC8) {
>
> +                DPRINTF("Set COM Output Scan Dir (cmd 0x%02x) not implemented\n", s->cmd);
>
> +            }
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        /* Set Display Offset (1 data byte) */
>
> +        case 0xD3:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                if (data != 0x00) {
>
> +                    DPRINTF("Set Display Offset (0x%02x) not implemented\n", data);
>
> +                }
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set COM Pins Hardware Configuration (1 data byte) */
>
> +        case 0xDA:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                if (data != 0x12) {
>
> +                    DPRINTF("Set COM Pins Hardware (0x%02x) not implemented\n", data);
>
> +                }
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +
>
> +        /*
>
> +         * Timing and Driving Scheme Setting Commands
>
> +         */
>
> +        /* Set Display Clock Divide Ratio/Oscillator Freq. (1 data byte) */
>
> +        case 0xD5:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Pre-charge Period (1 data byte) */
>
> +        case 0xD9:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Vcomh Deselect Level (1 data byte) */
>
> +        case 0xDB:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Charge Pump Setting (1 data byte) */
>
> +        case 0x8D:
>
> +            if (s->cmd_byte_num == 0) {
>
> +                s->mode = ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num == 1) {
>
> +                s->mode = ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* NOP */
>
> +        case 0xE3:
>
> +            s->mode = ssd1306_CMD;
>
> +            break;
>
> +        default:
>
> +            BADF("Unknown command: 0x%x\n", data);
>
> +        }
>
> +        s->cmd_byte_num++;
>
> +        break;
>
> +    }
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +/* Handles I2C bus framing events */
>
> +static int ssd1306_event(I2CSlave *i2c, enum i2c_event event)
>
> +{
>
> +    ssd1306_state *s = SSD1306(i2c);
>
> +
>
> +    switch (event) {
>
> +    case I2C_FINISH:
>
> +        s->mode = ssd1306_IDLE;
>
> +        break;
>
> +    case I2C_START_RECV:
>
> +    case I2C_START_SEND:
>
> +    case I2C_NACK:
>
> +        /* Nothing to do.  */
>
> +        break;
>
> +    default:
>
> +        return -1;
>
> +    }
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +/*
>
> + * Helper function to convert monochrome framebuffer to color framebuffer
>
> + * by padding out values to match dest color depth.
>
> + * 'src' framebuffer is expected to be 1 byte per pixel
>
> + */
>
> +static void ssd1306_mono_to_color_fb(uint8_t *src, uint32_t size,
>
> +                            uint8_t *dst, uint8_t bits_per_pixel)
>
> +{
>
> +    unsigned int idx = 0;
>
> +    for (int i = 0; i < size; i++) {
>
> +        for (int pad = 0; pad < (bits_per_pixel / 8); pad++) {
>
> +            dst[idx++] = src[i];
>
> +        }
>
> +    }
>
> +}
>
> +
>
> +/* Helper function to perform per pixel integer scaling */
>
> +static void ssd1306_scale_fb(uint8_t *src, uint32_t src_width, uint32_t src_height,
>
> +                          uint8_t src_bits_per_pixel, uint8_t *dst, uint8_t scale_factor)
>
> +{
>
> +    uint8_t bytes_per_pixel = src_bits_per_pixel / 8;
>
> +    unsigned int idx = 0;
>
> +
>
> +    /* Scaling of 1 is just a direct copy */
>
> +    if (scale_factor == 1) {
>
> +        memcpy(dst, src, src_width * src_height * bytes_per_pixel);
>
> +    } else {
>
> +        /*
>
> +         * Copies each pixel (size=src_bits_per_pixel) scale_factor times and
>
> +         * duplicate each of those lines scale_factor times.
>
> +         */
>
> +        for (int h = 0; h < src_height; h++) {
>
> +            for (int hs = 0; hs < scale_factor; hs++) {
>
> +                for (int w = 0; w < src_width; w++) {
>
> +                    for (int ws = 0; ws < scale_factor; ws++) {
>
> +                        memcpy(&dst[idx],
>
> +                               &src[h * src_width * bytes_per_pixel +
>
> +                                    w * bytes_per_pixel],
>
> +                               bytes_per_pixel);
>
> +                        idx += bytes_per_pixel;
>
> +                    }
>
> +                }
>
> +            }
>
> +        }
>
> +    }
>
> +}
>
> +
>
> +/* Render the virtual framebuffer to the surface which will be displayed */
>
> +static void ssd1306_update_display(void *opaque)
>
> +{
>
> +    ssd1306_state *s = (ssd1306_state *)opaque;
>
> +    DisplaySurface *surface = qemu_console_surface(s->con);
>
> +
>
> +    if (!s->redraw) {
>
> +        return;
>
> +    }
>
> +
>
> +    int bpp = surface_bits_per_pixel(surface);

In modern QEMU surface_bits_per_pixel() will always be 32
for the output display surface, so you don't need to try to
handle anything else. You can clean up/remove/simplify
any code that's handling arbitrary bpp values here.


>
> +    /* This device only handles displays with whole byte color depths */
>
> +    if (bpp && bpp % 8 != 0) {
>
> +        DPRINTF("Invalid color depth (bpp=%d). "
>
> +                "Only whole byte color depths supported.\n", bpp);
>
> +        return;
>
> +    } else {
>
> +        uint8_t *dest_surface = surface_data(surface);
>
> +
>
> +        if (s->flash) {
>
> +            /* Turn on all pixels */
>
> +            memset(dest_surface, 0xff,
>
> +                   (s->width * s->scaling_factor) *
>
> +                   (s->height * s->scaling_factor) *
>
> +                   (bpp / 8));
>
> +        } else if (!s->enabled) {
>
> +            /* Clear the output */
>
> +            memset(dest_surface, 0x00,
>
> +                   (s->width * s->scaling_factor) *
>
> +                   (s->height * s->scaling_factor) *
>
> +                   (bpp / 8));
>
> +        } else {
>
> +            /*
>
> +             * The following operations could have been done in a single pass
>
> +             * but that would likely have resulted in even more unreadable code.
>
> +             */
>
> +            ssd1306_mono_to_color_fb(s->mono_framebuffer, s->width * s->height,
>
> +                                     s->color_framebuffer, bpp);
>
> +            ssd1306_scale_fb(s->color_framebuffer, s->width, s->height, bpp,
>
> +                             dest_surface, s->scaling_factor);
>
> +        }
>
> +        s->redraw = 0;
>
> +        dpy_gfx_update(s->con, 0, 0, s->width * s->scaling_factor,
>
> +                       s->height * s->scaling_factor);
>
> +    }
>
> +}
>
> +
>
> +static void ssd1306_invalidate_display(void *opaque)
>
> +{
>
> +    ssd1306_state *s = (ssd1306_state *)opaque;
>
> +    s->redraw = 1;
>
> +}
>
> +
>
> +static const VMStateDescription vmstate_ssd1306 = {
>
> +    .name = "ssd1306_oled",
>
> +    .version_id = 1,
>
> +    .minimum_version_id = 1,
>
> +    .fields = (const VMStateField[]) {
>
> +        VMSTATE_UINT8(addr_mode, ssd1306_state),
>
> +        VMSTATE_UINT8(col, ssd1306_state),
>
> +        VMSTATE_UINT8(col_start, ssd1306_state),
>
> +        VMSTATE_UINT8(col_end, ssd1306_state),
>
> +        VMSTATE_UINT8(page, ssd1306_state),
>
> +        VMSTATE_UINT8(page_start, ssd1306_state),
>
> +        VMSTATE_UINT8(page_end, ssd1306_state),
>
> +        VMSTATE_INT32(mirror, ssd1306_state),
>
> +        VMSTATE_INT32(flash, ssd1306_state),
>
> +        VMSTATE_INT32(enabled, ssd1306_state),
>
> +        VMSTATE_INT32(inverse, ssd1306_state),
>
> +        VMSTATE_INT32(redraw, ssd1306_state),
>
> +        VMSTATE_UINT32(mode, ssd1306_state),
>
> +        VMSTATE_UINT8(cmd, ssd1306_state),
>
> +        VMSTATE_UINT8(cmd_byte_num, ssd1306_state),
>
> +        VMSTATE_BUFFER(mono_framebuffer, ssd1306_state),
>
> +        VMSTATE_BUFFER(color_framebuffer, ssd1306_state),
>
> +        VMSTATE_I2C_SLAVE(parent_obj, ssd1306_state),

Usually we put the parent_obj at the top of the vmstate array,
not the bottom.

>
> +        VMSTATE_END_OF_LIST()
>
> +    }
>
> +};
>
> +
>
> +static const GraphicHwOps ssd1306_ops = {
>
> +    .invalidate  = ssd1306_invalidate_display,
>
> +    .gfx_update  = ssd1306_update_display,
>
> +};
>
> +
>
> +static void ssd1306_realize(DeviceState *dev, Error **errp)
>
> +{
>
> +    ssd1306_state *s = SSD1306(dev);
>
> +
>
> +    s->addr_mode = ssd1306_ADDR_MODE_PAGE;
>
> +    s->col_start = 0;
>
> +    s->col_start = 127;
>
> +    s->page_start = 0;
>
> +    s->page_end = 7;
>
> +    memset(s->mono_framebuffer, 0, sizeof(s->mono_framebuffer));

At least some of this should be done in reset, not realize.

>
> +    s->con = graphic_console_init(dev, 0, &ssd1306_ops, s);
>
> +    qemu_console_resize(s->con, s->width * s->scaling_factor,
>
> +                        s->height * s->scaling_factor);
>
> +}
>
> +
>
> +static Property ssd1306_properties[] = {
>
> +    DEFINE_PROP_UINT8("width", ssd1306_state, width, 128),
>
> +    DEFINE_PROP_UINT8("height", ssd1306_state, height, 32),

Are these really variable in real hardware?

>
> +    DEFINE_PROP_UINT8("scaling", ssd1306_state, scaling_factor, 4),
>
> +    DEFINE_PROP_END_OF_LIST(),
>
> +};
>
> +
>
> +static void ssd1306_class_init(ObjectClass *klass, void *data)
>
> +{
>
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>
> +
>
> +    dc->realize = ssd1306_realize;
>
> +    k->event = ssd1306_event;
>
> +    k->recv = ssd1306_recv;
>
> +    k->send = ssd1306_send;
>
> +    dc->vmsd = &vmstate_ssd1306;
>
> +    device_class_set_props(dc, ssd1306_properties);

I think this is missing device reset handling.

>
> +}

thanks
-- PMM

