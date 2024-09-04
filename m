Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DEBCA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slneD-0007uE-Jp; Wed, 04 Sep 2024 06:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slneC-0007qW-BK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:54:00 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slne9-0005gF-V0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:54:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42bb9d719d4so48873495e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725447236; x=1726052036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LkE1rk4UOMoA8ya2rTLplkoALpKQ4Ru80s1qUNLPK9U=;
 b=Oenk9QLopNWGRfYrkZVxyNUn/KdidvTte0/6Kw5TJXII/M8La6oglHD3bb3CSUqjyt
 ExamQJ8CE8JnpOPV4yDtvqPmy6WOpXfx8GvMl6+VSXK3mWLEJha/VUGrY14JBazaTII5
 SiMfRjiG4ACym/61nNDPZIjqUDl8r+eo61QSCcb/ogrOgA2BNa2UjyZvJf6pQOnVJzqW
 ogfn+ZlgEqVqhbGQfedgXfHPxXd+OEV4c3b/JNmmtvYNVOW/aRO3gLZBU7fxXTMIZv5b
 LHTSrRsQFD5GukdnwlT7BR51LacAWfv6TkUIaLjXbZCqGsSjbiCKzp6pF0IkF4f4AUbo
 bsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725447236; x=1726052036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LkE1rk4UOMoA8ya2rTLplkoALpKQ4Ru80s1qUNLPK9U=;
 b=rv6/nE3d5R/mxdmQPRvZPiC7elrunRNVrj7O2ocE+6Ip/rxHxjUVXfY3jnn4nFiHES
 eARMmP3bhSwpkBkicljb7PBBnrFSwv0fY2QsiJJGQrOwGvZI+1lqOE+IHPNHJCDWQVO1
 tZ1KkbxsQzGcCQT9S3LPdtDs99+pCeA+MQbI4P6s+hhHTPH3xmCUQzbNargkGYn4beIk
 E+nELHACWhotvp+Yz33UiloSyNsG5vZ+IHUbB6ulXR164UPJO7LgQmgOKZ2VlIoUuUbt
 hlstRsKMqgJ+Q1/MsZHgidYdGrciVMdmiPD4ylQTxY039tLq/jtF8KXdtlQhKLhE7Rbu
 uOaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHnX5u7rcS35MZxY3sP/dZSplRn0vPOFTO3PuTQObsCIJV/RyD960IMwg08rejduyND/Q1bycnkzll@nongnu.org
X-Gm-Message-State: AOJu0YzI3Ajoa4oTBuByFHR0oMLBEXmQzRCh8VeNsKNjSAhyQBGdngvi
 CdJtWa778BdoJ73F4WoWmD+elx/UQJk2zXtvOrOHIDmXa+3xRsjTmCCrfV1aAaE=
X-Google-Smtp-Source: AGHT+IHBGHLd7ULZeQJCpSgOOzBzud5WHYmhcXYp/NNDgyCrtYC36dfLNZF1ocCNqQhzD9fvUKt8pg==
X-Received: by 2002:a05:6000:1865:b0:371:79f2:3d5c with SMTP id
 ffacd0b85a97d-374eccc222cmr5838705f8f.31.1725447235779; 
 Wed, 04 Sep 2024 03:53:55 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c15705easm11215289f8f.33.2024.09.04.03.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 03:53:54 -0700 (PDT)
Message-ID: <e828e000-664e-48af-ae33-6e323e28d167@linaro.org>
Date: Wed, 4 Sep 2024 12:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] escc: convert Sun mouse to use QemuInputHandler
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, chauser@pullman.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20240904102301.175706-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240904102301.175706-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 4/9/24 12:23, Mark Cave-Ayland wrote:
> Update the Sun mouse implementation to use QemuInputHandler instead of the
> legacy qemu_add_mouse_event_handler() function.
> 
> Note that this conversion adds extra sunmouse_* members to ESCCChannelState
> but they are not added to the migration stream (similar to the Sun keyboard
> members). If this were desired in future, the Sun devices should be split
> into separate devices and added to the migration stream there instead.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2518
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

On v3 there is also an implicit:
Tested-by: Carl Hauser <chauser@pullman.com>

> ---
>   hw/char/escc.c         | 88 +++++++++++++++++++++++++++++++-----------
>   include/hw/char/escc.h |  3 ++
>   2 files changed, 69 insertions(+), 22 deletions(-)
> 
> v3:
> - Subtract the deltas in sunmouse_sync() instead of resetting them to zero
>    which provides better tracking if the mouse movement exceeds the 8-bit
>    delta limit of the MSC protocol
> 
> - Add R-B tag from Richard
> 
> v2:
> - Only allow left, middle and right button events (use bit 7 which is always
>    set in the first byte to indicate a valid event)
> 
> - Remove zero entries from the bmap table as static entries should be
>    zero anyway
> 
> 
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index d450d70eda..245a7b19d3 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -287,6 +287,7 @@ static void escc_reset_chn(ESCCChannelState *s)
>       s->rxint = s->txint = 0;
>       s->rxint_under_svc = s->txint_under_svc = 0;
>       s->e0_mode = s->led_mode = s->caps_lock_mode = s->num_lock_mode = 0;
> +    s->sunmouse_dx = s->sunmouse_dy = s->sunmouse_buttons = 0;
>       clear_queue(s);
>   }
>   
> @@ -952,53 +953,96 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
>       }
>   }
>   
> -static void sunmouse_event(void *opaque,
> -                               int dx, int dy, int dz, int buttons_state)
> +static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
> +                                  InputEvent *evt)
>   {
> -    ESCCChannelState *s = opaque;
> -    int ch;
> +    ESCCChannelState *s = (ESCCChannelState *)dev;
> +    InputMoveEvent *move;
> +    InputBtnEvent *btn;
> +    static const int bmap[INPUT_BUTTON__MAX] = {
> +        [INPUT_BUTTON_LEFT]   = 0x4,
> +        [INPUT_BUTTON_MIDDLE] = 0x2,
> +        [INPUT_BUTTON_RIGHT]  = 0x1,
> +    };
> +
> +    switch (evt->type) {
> +    case INPUT_EVENT_KIND_REL:
> +        move = evt->u.rel.data;
> +        if (move->axis == INPUT_AXIS_X) {
> +            s->sunmouse_dx += move->value;
> +        } else if (move->axis == INPUT_AXIS_Y) {
> +            s->sunmouse_dy -= move->value;
> +        }
> +        break;
>   
> -    trace_escc_sunmouse_event(dx, dy, buttons_state);
> -    ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
> +    case INPUT_EVENT_KIND_BTN:
> +        btn = evt->u.btn.data;
> +        if (bmap[btn->button]) {
> +            if (btn->down) {
> +                s->sunmouse_buttons |= bmap[btn->button];
> +            } else {
> +                s->sunmouse_buttons &= ~bmap[btn->button];
> +            }
> +            /* Indicate we have a supported button event */
> +            s->sunmouse_buttons |= 0x80;
> +        }
> +        break;
>   
> -    if (buttons_state & MOUSE_EVENT_LBUTTON) {
> -        ch ^= 0x4;
> -    }
> -    if (buttons_state & MOUSE_EVENT_MBUTTON) {
> -        ch ^= 0x2;
> +    default:
> +        /* keep gcc happy */
> +        break;
>       }
> -    if (buttons_state & MOUSE_EVENT_RBUTTON) {
> -        ch ^= 0x1;
> +}
> +
> +static void sunmouse_sync(DeviceState *dev)
> +{
> +    ESCCChannelState *s = (ESCCChannelState *)dev;
> +    int ch;
> +
> +    if (s->sunmouse_dx == 0 && s->sunmouse_dy == 0 &&
> +        (s->sunmouse_buttons & 0x80) == 0) {
> +            /* Nothing to do after button event filter */
> +            return;
>       }
>   
> +    /* Clear our button event flag */
> +    s->sunmouse_buttons &= ~0x80;
> +    trace_escc_sunmouse_event(s->sunmouse_dx, s->sunmouse_dy,
> +                              s->sunmouse_buttons);
> +    ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
> +    ch ^= s->sunmouse_buttons;
>       put_queue(s, ch);
>   
> -    ch = dx;
> -
> +    ch = s->sunmouse_dx;
>       if (ch > 127) {
>           ch = 127;
>       } else if (ch < -127) {
>           ch = -127;
>       }
> -
>       put_queue(s, ch & 0xff);
> +    s->sunmouse_dx -= ch;
>   
> -    ch = -dy;
> -
> +    ch = s->sunmouse_dy;
>       if (ch > 127) {
>           ch = 127;
>       } else if (ch < -127) {
>           ch = -127;
>       }
> -
>       put_queue(s, ch & 0xff);
> +    s->sunmouse_dy -= ch;
>   
>       /* MSC protocol specifies two extra motion bytes */
> -
>       put_queue(s, 0);
>       put_queue(s, 0);
>   }
>   
> +static const QemuInputHandler sunmouse_handler = {
> +    .name  = "QEMU Sun Mouse",
> +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
> +    .event = sunmouse_handle_event,
> +    .sync  = sunmouse_sync,
> +};
> +
>   static void escc_init1(Object *obj)
>   {
>       ESCCState *s = ESCC(obj);
> @@ -1036,8 +1080,8 @@ static void escc_realize(DeviceState *dev, Error **errp)
>       }
>   
>       if (s->chn[0].type == escc_mouse) {
> -        qemu_add_mouse_event_handler(sunmouse_event, &s->chn[0], 0,
> -                                     "QEMU Sun Mouse");
> +        s->chn[0].hs = qemu_input_handler_register((DeviceState *)(&s->chn[0]),
> +                                                   &sunmouse_handler);
>       }
>       if (s->chn[1].type == escc_kbd) {
>           s->chn[1].hs = qemu_input_handler_register((DeviceState *)(&s->chn[1]),
> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> index 5669a5b811..8c4c6a7730 100644
> --- a/include/hw/char/escc.h
> +++ b/include/hw/char/escc.h
> @@ -46,6 +46,9 @@ typedef struct ESCCChannelState {
>       uint8_t rx, tx;
>       QemuInputHandlerState *hs;
>       char *sunkbd_layout;
> +    int sunmouse_dx;
> +    int sunmouse_dy;
> +    int sunmouse_buttons;
>   } ESCCChannelState;
>   
>   struct ESCCState {


