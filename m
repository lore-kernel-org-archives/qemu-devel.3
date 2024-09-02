Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59606C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 23:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slGHh-0002TR-Ui; Mon, 02 Sep 2024 19:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carl.hauser@gmail.com>)
 id 1slGHd-0002So-Tx
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 19:16:30 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carl.hauser@gmail.com>)
 id 1slGHY-0001aT-Ni
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 19:16:29 -0400
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-714287e4083so4212651b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 16:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725318983; x=1725923783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=juKEpoAhPVPUaAXsCKN7YLrrQKpKt61oA+fOLIwtm88=;
 b=jHnC6z4OV+j3CYA3HQzB504Fg/j21Y1SSRfYW+ZTVfZ0hfG7WGsmcya8YgTngq7DiN
 4U9orh50HnaQ9U8YjyBys3vFzCrGGD+xrWdKJEldCRmZe/GTL4JdSCN8G3ENCFFQhJ8q
 Zgmxdp6egraJw3lB1K1584F30h1AhVmfWZTOJpzCR8xqrrUc1Zu2/2/pfaxoW3Ick8Us
 TXA5LN33EDG1PDnUoDplQm+DAnt9rctRYz1qOQhYNDssdXK1en++LrkKKSE6uT4rbZJA
 /ngJ5k5A1eRHog/jPkxVMGGYq7UAX4FPx7POLokyzMern/d9bPlIwCmj+DABT4xjdM7A
 c6YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl/Fu5Kc43CaaWPodFgTn9dqPPE3xMvbi7gLfOY1vsIfnka3qD/XgbBVdiWQoX087npCekFOg3kAOW@nongnu.org
X-Gm-Message-State: AOJu0Yx1RWjavNVFqfGbc96X1EAoo80t+8ci7Ah0/YdafFm94Od3lmop
 6f3ZtYFl3L2WaPaYF/sIjCmh11XmbmiDitBPuKiD+pyXg9QGgJ4tAsr6W0WyF3Dzcynj5qJEBZD
 GEDqewHa/rZOIm+hyT/Ux+4S159Z63A==
X-Google-Smtp-Source: AGHT+IGeh64KpOzy7xyghVtezHbibt35zuzkaMzGVO/kcPdSXzfwme5btIu8kkTVyd2XC9sQ9Hz60dwcJBNWeXFTpNo=
X-Received: by 2002:a05:6a20:d487:b0:1c6:fa4b:3648 with SMTP id
 adf61e73a8af0-1cecdf294b6mr13286185637.22.1725318982703; Mon, 02 Sep 2024
 16:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240902213816.89071-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240902213816.89071-1-mark.cave-ayland@ilande.co.uk>
Date: Mon, 2 Sep 2024 16:16:11 -0700
Message-ID: <CABJXFgUxPWkbynMWZW_i20KDSetu1ucWWMFha7vk5+=GE9_vYA@mail.gmail.com>
Subject: Re: [PATCH] escc: convert Sun mouse to use QemuInputHandler
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000016a12b06212b21d8"
Received-SPF: pass client-ip=209.85.210.177;
 envelope-from=carl.hauser@gmail.com; helo=mail-pf1-f177.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Carl Hauser <chauser@pullman.com>
From:  Carl Hauser via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000016a12b06212b21d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This still, but less frequently, shows the behavior of having the cursor
leap downwards occasionally. I may not be able to work on debugging it
until next week, but I'll try to see if I can figure it out sooner. The
hypothesis with the old code was that it was sending floods of mouse
messages and the Sun driver was dropping a byte at some point. So that's
the first thing I'll look into with this new code, but it could be
something different. This is definitely better than the old code -- just
not sending anything in response to mouse wheel movement helps a lot.

On Mon, Sep 2, 2024 at 2:38=E2=80=AFPM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> Update the Sun mouse implementation to use QemuInputHandler instead of th=
e
> legacy qemu_add_mouse_event_handler() function.
>
> Note that this conversion adds extra sunmouse_* members to ESCCChannelSta=
te
> but they are not added to the migration stream (similar to the Sun keyboa=
rd
> members). If this were desired in future, the Sun devices should be split
> into separate devices and added to the migration stream there instead.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2518
> ---
>  hw/char/escc.c         | 79 ++++++++++++++++++++++++++++++------------
>  include/hw/char/escc.h |  3 ++
>  roms/seabios           |  2 +-
>  3 files changed, 60 insertions(+), 24 deletions(-)
>
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index d450d70eda..6d4e3e3350 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -287,6 +287,7 @@ static void escc_reset_chn(ESCCChannelState *s)
>      s->rxint =3D s->txint =3D 0;
>      s->rxint_under_svc =3D s->txint_under_svc =3D 0;
>      s->e0_mode =3D s->led_mode =3D s->caps_lock_mode =3D s->num_lock_mod=
e =3D 0;
> +    s->sunmouse_dx =3D s->sunmouse_dy =3D s->sunmouse_buttons =3D 0;
>      clear_queue(s);
>  }
>
> @@ -952,53 +953,85 @@ static void handle_kbd_command(ESCCChannelState *s,
> int val)
>      }
>  }
>
> -static void sunmouse_event(void *opaque,
> -                               int dx, int dy, int dz, int buttons_state=
)
> +static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
> +                                  InputEvent *evt)
>  {
> -    ESCCChannelState *s =3D opaque;
> -    int ch;
> +    ESCCChannelState *s =3D (ESCCChannelState *)dev;
> +    InputMoveEvent *move;
> +    InputBtnEvent *btn;
> +    static const int bmap[INPUT_BUTTON__MAX] =3D {
> +        [INPUT_BUTTON_LEFT]   =3D 0x4,
> +        [INPUT_BUTTON_MIDDLE] =3D 0x2,
> +        [INPUT_BUTTON_RIGHT]  =3D 0x1,
> +        [INPUT_BUTTON_SIDE]   =3D 0x0,
> +        [INPUT_BUTTON_EXTRA]  =3D 0x0,
> +    };
> +
> +    switch (evt->type) {
> +    case INPUT_EVENT_KIND_REL:
> +        move =3D evt->u.rel.data;
> +        if (move->axis =3D=3D INPUT_AXIS_X) {
> +            s->sunmouse_dx +=3D move->value;
> +        } else if (move->axis =3D=3D INPUT_AXIS_Y) {
> +            s->sunmouse_dy -=3D move->value;
> +        }
> +        break;
>
> -    trace_escc_sunmouse_event(dx, dy, buttons_state);
> -    ch =3D 0x80 | 0x7; /* protocol start byte, no buttons pressed */
> +    case INPUT_EVENT_KIND_BTN:
> +        btn =3D evt->u.btn.data;
> +        if (btn->down) {
> +            s->sunmouse_buttons |=3D bmap[btn->button];
> +        } else {
> +            s->sunmouse_buttons &=3D ~bmap[btn->button];
> +        }
> +        break;
>
> -    if (buttons_state & MOUSE_EVENT_LBUTTON) {
> -        ch ^=3D 0x4;
> -    }
> -    if (buttons_state & MOUSE_EVENT_MBUTTON) {
> -        ch ^=3D 0x2;
> -    }
> -    if (buttons_state & MOUSE_EVENT_RBUTTON) {
> -        ch ^=3D 0x1;
> +    default:
> +        /* keep gcc happy */
> +        break;
>      }
> +}
>
> -    put_queue(s, ch);
> +static void sunmouse_sync(DeviceState *dev)
> +{
> +    ESCCChannelState *s =3D (ESCCChannelState *)dev;
> +    int ch;
>
> -    ch =3D dx;
> +    trace_escc_sunmouse_event(s->sunmouse_dx, s->sunmouse_dy, 0);
> +    ch =3D 0x80 | 0x7; /* protocol start byte, no buttons pressed */
> +    ch ^=3D s->sunmouse_buttons;
> +    put_queue(s, ch);
>
> +    ch =3D s->sunmouse_dx;
>      if (ch > 127) {
>          ch =3D 127;
>      } else if (ch < -127) {
>          ch =3D -127;
>      }
> -
>      put_queue(s, ch & 0xff);
> +    s->sunmouse_dx =3D 0;
>
> -    ch =3D -dy;
> -
> +    ch =3D s->sunmouse_dy;
>      if (ch > 127) {
>          ch =3D 127;
>      } else if (ch < -127) {
>          ch =3D -127;
>      }
> -
>      put_queue(s, ch & 0xff);
> +    s->sunmouse_dy =3D 0;
>
>      /* MSC protocol specifies two extra motion bytes */
> -
>      put_queue(s, 0);
>      put_queue(s, 0);
>  }
>
> +static const QemuInputHandler sunmouse_handler =3D {
> +    .name  =3D "QEMU Sun Mouse",
> +    .mask  =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
> +    .event =3D sunmouse_handle_event,
> +    .sync  =3D sunmouse_sync,
> +};
> +
>  static void escc_init1(Object *obj)
>  {
>      ESCCState *s =3D ESCC(obj);
> @@ -1036,8 +1069,8 @@ static void escc_realize(DeviceState *dev, Error
> **errp)
>      }
>
>      if (s->chn[0].type =3D=3D escc_mouse) {
> -        qemu_add_mouse_event_handler(sunmouse_event, &s->chn[0], 0,
> -                                     "QEMU Sun Mouse");
> +        s->chn[0].hs =3D qemu_input_handler_register((DeviceState
> *)(&s->chn[0]),
> +                                                   &sunmouse_handler);
>      }
>      if (s->chn[1].type =3D=3D escc_kbd) {
>          s->chn[1].hs =3D qemu_input_handler_register((DeviceState
> *)(&s->chn[1]),
> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> index 5669a5b811..8c4c6a7730 100644
> --- a/include/hw/char/escc.h
> +++ b/include/hw/char/escc.h
> @@ -46,6 +46,9 @@ typedef struct ESCCChannelState {
>      uint8_t rx, tx;
>      QemuInputHandlerState *hs;
>      char *sunkbd_layout;
> +    int sunmouse_dx;
> +    int sunmouse_dy;
> +    int sunmouse_buttons;
>  } ESCCChannelState;
>
>  struct ESCCState {
> diff --git a/roms/seabios b/roms/seabios
> index a6ed6b701f..7d0c606870 160000
> --- a/roms/seabios
> +++ b/roms/seabios
> @@ -1 +1 @@
> -Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8
> +Subproject commit 7d0c6068703eae9f2498be0c900ab95b25b4f07a
> --
> 2.39.2
>
>
>

--00000000000016a12b06212b21d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This still, but less frequently, shows the behavior of hav=
ing the cursor leap downwards occasionally. I may not be able to work on de=
bugging it until next week, but I&#39;ll try to see if I can figure it out =
sooner. The hypothesis with the old code was that it was sending floods of =
mouse messages and the Sun driver was dropping a byte at some point. So tha=
t&#39;s the first thing I&#39;ll look into with this new code, but it could=
 be something different. This is definitely better than the old code -- jus=
t not sending anything in response to mouse wheel movement helps a lot.<br>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Mon, Sep 2, 2024 at 2:38=E2=80=AFPM Mark Cave-Ayland &lt;<a href=3D"mail=
to:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Update the S=
un mouse implementation to use QemuInputHandler instead of the<br>
legacy qemu_add_mouse_event_handler() function.<br>
<br>
Note that this conversion adds extra sunmouse_* members to ESCCChannelState=
<br>
but they are not added to the migration stream (similar to the Sun keyboard=
<br>
members). If this were desired in future, the Sun devices should be split<b=
r>
into separate devices and added to the migration stream there instead.<br>
<br>
Signed-off-by: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilan=
de.co.uk" target=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt;<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2518" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2518</a><br>
---<br>
=C2=A0hw/char/escc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 79 ++++++++++++++++=
++++++++++++++------------<br>
=C2=A0include/hw/char/escc.h |=C2=A0 3 ++<br>
=C2=A0roms/seabios=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A03 files changed, 60 insertions(+), 24 deletions(-)<br>
<br>
diff --git a/hw/char/escc.c b/hw/char/escc.c<br>
index d450d70eda..6d4e3e3350 100644<br>
--- a/hw/char/escc.c<br>
+++ b/hw/char/escc.c<br>
@@ -287,6 +287,7 @@ static void escc_reset_chn(ESCCChannelState *s)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;rxint =3D s-&gt;txint =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;rxint_under_svc =3D s-&gt;txint_under_svc =3D 0;<=
br>
=C2=A0 =C2=A0 =C2=A0s-&gt;e0_mode =3D s-&gt;led_mode =3D s-&gt;caps_lock_mo=
de =3D s-&gt;num_lock_mode =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;sunmouse_dx =3D s-&gt;sunmouse_dy =3D s-&gt;sunmouse_b=
uttons =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0clear_queue(s);<br>
=C2=A0}<br>
<br>
@@ -952,53 +953,85 @@ static void handle_kbd_command(ESCCChannelState *s, i=
nt val)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void sunmouse_event(void *opaque,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int dx, int dy, int dz, int buttons_s=
tate)<br>
+static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InputEvent *evt)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ESCCChannelState *s =3D opaque;<br>
-=C2=A0 =C2=A0 int ch;<br>
+=C2=A0 =C2=A0 ESCCChannelState *s =3D (ESCCChannelState *)dev;<br>
+=C2=A0 =C2=A0 InputMoveEvent *move;<br>
+=C2=A0 =C2=A0 InputBtnEvent *btn;<br>
+=C2=A0 =C2=A0 static const int bmap[INPUT_BUTTON__MAX] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_LEFT]=C2=A0 =C2=A0=3D 0x4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_MIDDLE] =3D 0x2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_RIGHT]=C2=A0 =3D 0x1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_SIDE]=C2=A0 =C2=A0=3D 0x0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_EXTRA]=C2=A0 =3D 0x0,<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 switch (evt-&gt;type) {<br>
+=C2=A0 =C2=A0 case INPUT_EVENT_KIND_REL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (move-&gt;axis =3D=3D INPUT_AXIS_X) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sunmouse_dx +=3D move-&gt;=
value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (move-&gt;axis =3D=3D INPUT_AXIS_Y) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sunmouse_dy -=3D move-&gt;=
value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
-=C2=A0 =C2=A0 trace_escc_sunmouse_event(dx, dy, buttons_state);<br>
-=C2=A0 =C2=A0 ch =3D 0x80 | 0x7; /* protocol start byte, no buttons presse=
d */<br>
+=C2=A0 =C2=A0 case INPUT_EVENT_KIND_BTN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (btn-&gt;down) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sunmouse_buttons |=3D bmap=
[btn-&gt;button];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sunmouse_buttons &amp;=3D =
~bmap[btn-&gt;button];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
-=C2=A0 =C2=A0 if (buttons_state &amp; MOUSE_EVENT_LBUTTON) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ch ^=3D 0x4;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (buttons_state &amp; MOUSE_EVENT_MBUTTON) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ch ^=3D 0x2;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (buttons_state &amp; MOUSE_EVENT_RBUTTON) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ch ^=3D 0x1;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* keep gcc happy */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
<br>
-=C2=A0 =C2=A0 put_queue(s, ch);<br>
+static void sunmouse_sync(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 ESCCChannelState *s =3D (ESCCChannelState *)dev;<br>
+=C2=A0 =C2=A0 int ch;<br>
<br>
-=C2=A0 =C2=A0 ch =3D dx;<br>
+=C2=A0 =C2=A0 trace_escc_sunmouse_event(s-&gt;sunmouse_dx, s-&gt;sunmouse_=
dy, 0);<br>
+=C2=A0 =C2=A0 ch =3D 0x80 | 0x7; /* protocol start byte, no buttons presse=
d */<br>
+=C2=A0 =C2=A0 ch ^=3D s-&gt;sunmouse_buttons;<br>
+=C2=A0 =C2=A0 put_queue(s, ch);<br>
<br>
+=C2=A0 =C2=A0 ch =3D s-&gt;sunmouse_dx;<br>
=C2=A0 =C2=A0 =C2=A0if (ch &gt; 127) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch =3D 127;<br>
=C2=A0 =C2=A0 =C2=A0} else if (ch &lt; -127) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch =3D -127;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
=C2=A0 =C2=A0 =C2=A0put_queue(s, ch &amp; 0xff);<br>
+=C2=A0 =C2=A0 s-&gt;sunmouse_dx =3D 0;<br>
<br>
-=C2=A0 =C2=A0 ch =3D -dy;<br>
-<br>
+=C2=A0 =C2=A0 ch =3D s-&gt;sunmouse_dy;<br>
=C2=A0 =C2=A0 =C2=A0if (ch &gt; 127) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch =3D 127;<br>
=C2=A0 =C2=A0 =C2=A0} else if (ch &lt; -127) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch =3D -127;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
=C2=A0 =C2=A0 =C2=A0put_queue(s, ch &amp; 0xff);<br>
+=C2=A0 =C2=A0 s-&gt;sunmouse_dy =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* MSC protocol specifies two extra motion bytes */<br>
-<br>
=C2=A0 =C2=A0 =C2=A0put_queue(s, 0);<br>
=C2=A0 =C2=A0 =C2=A0put_queue(s, 0);<br>
=C2=A0}<br>
<br>
+static const QemuInputHandler sunmouse_handler =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =3D &quot;QEMU Sun Mouse&quot;,<br>
+=C2=A0 =C2=A0 .mask=C2=A0 =3D INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,=
<br>
+=C2=A0 =C2=A0 .event =3D sunmouse_handle_event,<br>
+=C2=A0 =C2=A0 .sync=C2=A0 =3D sunmouse_sync,<br>
+};<br>
+<br>
=C2=A0static void escc_init1(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ESCCState *s =3D ESCC(obj);<br>
@@ -1036,8 +1069,8 @@ static void escc_realize(DeviceState *dev, Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;chn[0].type =3D=3D escc_mouse) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_add_mouse_event_handler(sunmouse_event, &=
amp;s-&gt;chn[0], 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;QEMU Sun M=
ouse&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;chn[0].hs =3D qemu_input_handler_registe=
r((DeviceState *)(&amp;s-&gt;chn[0]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;sunmouse_handler);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;chn[1].type =3D=3D escc_kbd) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;chn[1].hs =3D qemu_input_handler_re=
gister((DeviceState *)(&amp;s-&gt;chn[1]),<br>
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h<br>
index 5669a5b811..8c4c6a7730 100644<br>
--- a/include/hw/char/escc.h<br>
+++ b/include/hw/char/escc.h<br>
@@ -46,6 +46,9 @@ typedef struct ESCCChannelState {<br>
=C2=A0 =C2=A0 =C2=A0uint8_t rx, tx;<br>
=C2=A0 =C2=A0 =C2=A0QemuInputHandlerState *hs;<br>
=C2=A0 =C2=A0 =C2=A0char *sunkbd_layout;<br>
+=C2=A0 =C2=A0 int sunmouse_dx;<br>
+=C2=A0 =C2=A0 int sunmouse_dy;<br>
+=C2=A0 =C2=A0 int sunmouse_buttons;<br>
=C2=A0} ESCCChannelState;<br>
<br>
=C2=A0struct ESCCState {<br>
diff --git a/roms/seabios b/roms/seabios<br>
index a6ed6b701f..7d0c606870 160000<br>
--- a/roms/seabios<br>
+++ b/roms/seabios<br>
@@ -1 +1 @@<br>
-Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8<br>
+Subproject commit 7d0c6068703eae9f2498be0c900ab95b25b4f07a<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div>

--00000000000016a12b06212b21d8--

