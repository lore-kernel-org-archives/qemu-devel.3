Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D16CD37B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 22:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slbuV-0006rr-5X; Tue, 03 Sep 2024 18:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carl.hauser@gmail.com>)
 id 1slbuQ-0006rC-Qn
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 18:21:58 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carl.hauser@gmail.com>)
 id 1slbuN-0001Ii-G5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 18:21:58 -0400
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2d8881850d9so2965573a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 15:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725402114; x=1726006914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3L6YpTESeSPscMNo3xVox5/gF1qkJpmE5RcuZprNy9g=;
 b=UAyzXcnIkI1bSr38Mzfesl81vOuC/Z00WGgJTIZdcT4p6ayYCWY14D11kIEiD+Olg8
 3EAvo4dST5wG0e03jsvgqhw5wchmO7GFegfXzivzKYUPSzyxlo4OYEqQh8ixctG13wyc
 sJGee7u0S9vC4oXE/RifKKjaHL8kSZzCRSaNbIIhIjWZwb/sUpqOYvgIpNNYkJ98ijZI
 hbJ58VTqw9EewX2bTDz8yaVp0B6EKifhNncGNWsHExp4oIrKSNNI1ml01g5vUp6bO/kT
 w+Kr5O6GC6Htju/r+IoGiQXN0QkG8r0goAZUhRneh1NToPEEU/bofaoyU2vkDI45u/Tv
 6CHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFPkt5u0iq+r7IWvjwrG8mHNRmJvIK1SxCtGF+rcsCTv+pdDxIgPYRkHcl6WAkBaaHu/MuieiAknit@nongnu.org
X-Gm-Message-State: AOJu0YyXGFMpcouTniCAaAfnz8vZFFj/5fXDjaIxDFbrYOVmTkTOYAs2
 /ybkfo0XpQ0kwdVAlvSq1WUS3iOrUiv6R1fyDIwNtAxLma+PqIvhpXR6f4xs5+WjFAdhmoBBni2
 jFp7pFgUL2u3ZaFQW25OdZv09Egc=
X-Google-Smtp-Source: AGHT+IEiI3YjbwtFJHxD5w4tLqr7pWxrt3lzzX1ePg6rtbfvwRR3qaB7iGjcRKPiDUM2i8Nok0eh+3UxI6gBr6GADPA=
X-Received: by 2002:a17:90a:4701:b0:2ca:2c4b:476 with SMTP id
 98e67ed59e1d1-2da62fdb90fmr4216472a91.10.1725402113802; Tue, 03 Sep 2024
 15:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240903203846.144354-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240903203846.144354-1-mark.cave-ayland@ilande.co.uk>
Date: Tue, 3 Sep 2024 15:21:42 -0700
Message-ID: <CABJXFgUaUCqrTLROLh2-nB74fux72SyxnrZgy2aGmfqRDw3gRA@mail.gmail.com>
Subject: Re: [PATCH v2] escc: convert Sun mouse to use QemuInputHandler
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000168b4d06213e7cd8"
Received-SPF: pass client-ip=209.85.216.53; envelope-from=carl.hauser@gmail.com;
 helo=mail-pj1-f53.google.com
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

--000000000000168b4d06213e7cd8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This works well.

On Tue, Sep 3, 2024 at 1:38=E2=80=AFPM Mark Cave-Ayland <
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
>  hw/char/escc.c         | 88 +++++++++++++++++++++++++++++++-----------
>  include/hw/char/escc.h |  3 ++
>  2 files changed, 69 insertions(+), 22 deletions(-)
>
>
> v2:
> - Only allow left, middle and right button events (use bit 7 which is
> always
>   set in the first byte to indicate a valid event)
>
> - Remove zero entries from the bmap table as static entries should be
>   zero anyway
>
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index d450d70eda..641d4ee206 100644
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
> @@ -952,53 +953,96 @@ static void handle_kbd_command(ESCCChannelState *s,
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
> +        if (bmap[btn->button]) {
> +            if (btn->down) {
> +                s->sunmouse_buttons |=3D bmap[btn->button];
> +            } else {
> +                s->sunmouse_buttons &=3D ~bmap[btn->button];
> +            }
> +            /* Indicate we have a supported button event */
> +            s->sunmouse_buttons |=3D 0x80;
> +        }
> +        break;
>
> -    if (buttons_state & MOUSE_EVENT_LBUTTON) {
> -        ch ^=3D 0x4;
> -    }
> -    if (buttons_state & MOUSE_EVENT_MBUTTON) {
> -        ch ^=3D 0x2;
> +    default:
> +        /* keep gcc happy */
> +        break;
>      }
> -    if (buttons_state & MOUSE_EVENT_RBUTTON) {
> -        ch ^=3D 0x1;
> +}
> +
> +static void sunmouse_sync(DeviceState *dev)
> +{
> +    ESCCChannelState *s =3D (ESCCChannelState *)dev;
> +    int ch;
> +
> +    if (s->sunmouse_dx =3D=3D 0 && s->sunmouse_dy =3D=3D 0 &&
> +        (s->sunmouse_buttons & 0x80) =3D=3D 0) {
> +            /* Nothing to do after button event filter */
> +            return;
>      }
>
> +    /* Clear our button event flag */
> +    s->sunmouse_buttons &=3D ~0x80;
> +    trace_escc_sunmouse_event(s->sunmouse_dx, s->sunmouse_dy,
> +                              s->sunmouse_buttons);
> +    ch =3D 0x80 | 0x7; /* protocol start byte, no buttons pressed */
> +    ch ^=3D s->sunmouse_buttons;
>      put_queue(s, ch);
>
> -    ch =3D dx;
> -
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
> @@ -1036,8 +1080,8 @@ static void escc_realize(DeviceState *dev, Error
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
> --
> 2.39.2
>
>
>

--000000000000168b4d06213e7cd8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This works well.<br></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 3, 2024 at 1:38=E2=80=
=AFPM Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk"=
>mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Update the Sun mouse implementation to use Qe=
muInputHandler instead of the<br>
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
=C2=A0hw/char/escc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 88 ++++++++++++++++=
+++++++++++++++-----------<br>
=C2=A0include/hw/char/escc.h |=C2=A0 3 ++<br>
=C2=A02 files changed, 69 insertions(+), 22 deletions(-)<br>
<br>
<br>
v2:<br>
- Only allow left, middle and right button events (use bit 7 which is alway=
s<br>
=C2=A0 set in the first byte to indicate a valid event)<br>
<br>
- Remove zero entries from the bmap table as static entries should be<br>
=C2=A0 zero anyway<br>
<br>
diff --git a/hw/char/escc.c b/hw/char/escc.c<br>
index d450d70eda..641d4ee206 100644<br>
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
@@ -952,53 +953,96 @@ static void handle_kbd_command(ESCCChannelState *s, i=
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bmap[btn-&gt;button]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (btn-&gt;down) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sunmouse_but=
tons |=3D bmap[btn-&gt;button];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sunmouse_but=
tons &amp;=3D ~bmap[btn-&gt;button];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Indicate we have a supported =
button event */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sunmouse_buttons |=3D 0x80=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
-=C2=A0 =C2=A0 if (buttons_state &amp; MOUSE_EVENT_LBUTTON) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ch ^=3D 0x4;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (buttons_state &amp; MOUSE_EVENT_MBUTTON) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ch ^=3D 0x2;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* keep gcc happy */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (buttons_state &amp; MOUSE_EVENT_RBUTTON) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ch ^=3D 0x1;<br>
+}<br>
+<br>
+static void sunmouse_sync(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 ESCCChannelState *s =3D (ESCCChannelState *)dev;<br>
+=C2=A0 =C2=A0 int ch;<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;sunmouse_dx =3D=3D 0 &amp;&amp; s-&gt;sunmouse_dy =
=3D=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;sunmouse_buttons &amp; 0x80) =3D=3D 0) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Nothing to do after button ev=
ent filter */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* Clear our button event flag */<br>
+=C2=A0 =C2=A0 s-&gt;sunmouse_buttons &amp;=3D ~0x80;<br>
+=C2=A0 =C2=A0 trace_escc_sunmouse_event(s-&gt;sunmouse_dx, s-&gt;sunmouse_=
dy,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sunmouse_buttons);<br>
+=C2=A0 =C2=A0 ch =3D 0x80 | 0x7; /* protocol start byte, no buttons presse=
d */<br>
+=C2=A0 =C2=A0 ch ^=3D s-&gt;sunmouse_buttons;<br>
=C2=A0 =C2=A0 =C2=A0put_queue(s, ch);<br>
<br>
-=C2=A0 =C2=A0 ch =3D dx;<br>
-<br>
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
@@ -1036,8 +1080,8 @@ static void escc_realize(DeviceState *dev, Error **er=
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
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div></div>

--000000000000168b4d06213e7cd8--

