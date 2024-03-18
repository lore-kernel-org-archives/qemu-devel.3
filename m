Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7C6C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 09:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9LC-0002Qf-Gk; Mon, 18 Mar 2024 05:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rm9Ks-0002Mt-0p
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:31:16 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rm9Kp-0007xU-Nd
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:31:13 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-47651248841so1344714137.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710754270; x=1711359070; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rU4e3/ACr0PWzolG7no32golfeGkYaE7vSz1CoQwS6M=;
 b=G2ChSQQa02tZAXDO1FdwpnQKgbBHtw0V+WD3zeU75UAzlofAG834+jQAE62t8Jfetx
 vjyikGXaJaSUp02mix7PqyEyCpgOn68pBEUBMA/dX4x7+DViQk9yHJkNl0GAegY5CG7G
 GOkjR9XI/mNGSpES7PnId16HdS0/k26GOuR0qYMnknCGPEVa/Jsc2BEHq1pWPJrm5nuR
 ANnL3KC8t5sRUsPQ16/k/RUrQZwM14NRiTz5aKwtq5LZAZNsP6gVQH8eCiBNeKC+KfUq
 eLqagLuGhRSyYMuko+vzzfBgr37RKM/uDDXVkiO5E3QVmhXAE43NQPFmyv51rhzwh7e9
 YNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710754270; x=1711359070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rU4e3/ACr0PWzolG7no32golfeGkYaE7vSz1CoQwS6M=;
 b=QcKWgtg54p8JCo2WE196hosOROtLxOnkope+nTO3yjwBJNemlT3HHvzbXP2f36DC3B
 weMkstm6irVGQgWCOTMG0JFoya81d3KyEnWJpKB08PsDi+5d0e6vu/VzSJpo5YKDpMOO
 rJR2yloogrG2fWfXVBnd527Qic8Y/gqJd1NJYP7clLBtTQATxvKvO9+H/RzHWZwkLvlW
 XqOJumue4z4iBrpcLBLg7pU97qTR5nXXEd+bDTyj/SyroJ/HosIh6Oa/kKPKK09Yg69I
 VqpS8zlt1G1Pk/08USq/Ij/qfZJcvpnY5EwUD7tXftnxX46E50QKJw7hWCcSn+PoRbTJ
 yhog==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1kZ5GjFrA4bNlCqwlCAh1S5JrOj8cRGNcCyuOHIcABuWcibI0+DuUM26NJZ83rougtnG9fvzniMi3DCRyWjtd4dhTmVY=
X-Gm-Message-State: AOJu0YzYqf+MfAbJxhgJJxxIvuAXKoBpSRrVTMT+PwcntJAG8gAArOLt
 2vT/ceBBLaf4zc94+4CmvD9iE4uG5RFsz/IJmyuq4aV9i7eVUAZFY4nbeuUiht6VrvXBnZMiT41
 Tp3GwiE2BBQxTUmasTtmY2XtDt68=
X-Google-Smtp-Source: AGHT+IHApNekvRCa9CsztyvI/DZ5Raubrk3jtCnREffDALQzR3jsz5uC8DlOmf6PhffHqaoQdUkanhoaHRnjc1eb+E4=
X-Received: by 2002:a67:f308:0:b0:474:bbe6:9261 with SMTP id
 p8-20020a67f308000000b00474bbe69261mr7592233vsf.19.1710754269578; Mon, 18 Mar
 2024 02:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240318-console-v1-0-f4efbfa71253@daynix.com>
 <20240318-console-v1-2-f4efbfa71253@daynix.com>
 <CAJ+F1C+PipwudTRDF=BFJyqVkw0ORwpnXfumQ=kUadtf0HEfVA@mail.gmail.com>
 <e27ee189-3b72-413a-b1ab-f4b26cb37812@daynix.com>
In-Reply-To: <e27ee189-3b72-413a-b1ab-f4b26cb37812@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Mar 2024 13:30:57 +0400
Message-ID: <CAJ+F1CLomtQL-PySRFd3Akghiv4i9OgPwu2ZC2a7ao5F_z6zAg@mail.gmail.com>
Subject: Re: [PATCH 2/4] ui/vnc: Do not use console_select()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Mar 18, 2024 at 1:05=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/03/18 17:21, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Mar 18, 2024 at 11:58=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> console_select() is shared by other displays and a console_select() ca=
ll
> >> from one of them triggers console switching also in ui/curses,
> >> circumventing key state reinitialization that needs to be performed in
> >> preparation and resulting in stuck keys.
> >>
> >> Use its internal state to track the current active console to prevent
> >> such a surprise console switch.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   include/ui/console.h   |  1 +
> >>   include/ui/kbd-state.h | 11 +++++++++++
> >>   ui/console.c           | 12 ++++++++++++
> >>   ui/kbd-state.c         |  6 ++++++
> >>   ui/vnc.c               | 14 +++++++++-----
> >>   5 files changed, 39 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/ui/console.h b/include/ui/console.h
> >> index a4a49ffc640c..a703f7466499 100644
> >> --- a/include/ui/console.h
> >> +++ b/include/ui/console.h
> >> @@ -413,6 +413,7 @@ void qemu_console_early_init(void);
> >>
> >>   void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx =
*ctx);
> >>
> >> +QemuConsole *qemu_console_lookup_first_graphic_console(void);
> >>   QemuConsole *qemu_console_lookup_by_index(unsigned int index);
> >>   QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_=
t head);
> >>   QemuConsole *qemu_console_lookup_by_device_name(const char *device_i=
d,
> >> diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
> >> index fb79776128cf..1f37b932eb62 100644
> >> --- a/include/ui/kbd-state.h
> >> +++ b/include/ui/kbd-state.h
> >> @@ -99,4 +99,15 @@ bool qkbd_state_modifier_get(QKbdState *kbd, QKbdMo=
difier mod);
> >>    */
> >>   void qkbd_state_lift_all_keys(QKbdState *kbd);
> >>
> >> +/**
> >> + * qkbd_state_switch_console: Switch console.
> >> + *
> >> + * This sends key up events to the previous console for all keys whic=
h are in
> >> + * down state to prevent keys being stuck, and remembers the new cons=
ole.
> >> + *
> >> + * @kbd: state tracker state.
> >> + * @con: new QemuConsole for this state tracker.
> >> + */
> >> +void qkbd_state_switch_console(QKbdState *kbd, QemuConsole *con);
> >> +
> >>   #endif /* QEMU_UI_KBD_STATE_H */
> >> diff --git a/ui/console.c b/ui/console.c
> >> index 832055675c50..6bf02a23414c 100644
> >> --- a/ui/console.c
> >> +++ b/ui/console.c
> >> @@ -1325,6 +1325,18 @@ void graphic_console_close(QemuConsole *con)
> >>       dpy_gfx_replace_surface(con, surface);
> >>   }
> >>
> >> +QemuConsole *qemu_console_lookup_first_graphic_console(void)
> >> +{
> >> +    QemuConsole *con;
> >> +
> >> +    QTAILQ_FOREACH(con, &consoles, next) {
> >> +        if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
> >> +            return con;
> >> +        }
> >> +    }
> >> +    return NULL;
> >> +}
> >> +
> >>   QemuConsole *qemu_console_lookup_by_index(unsigned int index)
> >>   {
> >>       QemuConsole *con;
> >> diff --git a/ui/kbd-state.c b/ui/kbd-state.c
> >> index 62d42a7a22e1..52ed28b8a89b 100644
> >> --- a/ui/kbd-state.c
> >> +++ b/ui/kbd-state.c
> >> @@ -117,6 +117,12 @@ void qkbd_state_lift_all_keys(QKbdState *kbd)
> >>       }
> >>   }
> >>
> >> +void qkbd_state_switch_console(QKbdState *kbd, QemuConsole *con)
> >> +{
> >> +    qkbd_state_lift_all_keys(kbd);
> >> +    kbd->con =3D con;
> >> +}
> >> +
> >>   void qkbd_state_set_delay(QKbdState *kbd, int delay_ms)
> >>   {
> >>       kbd->key_delay_ms =3D delay_ms;
> >> diff --git a/ui/vnc.c b/ui/vnc.c
> >> index fc12b343e254..94564b196ba8 100644
> >> --- a/ui/vnc.c
> >> +++ b/ui/vnc.c
> >> @@ -1872,12 +1872,16 @@ static void do_key_event(VncState *vs, int dow=
n, int keycode, int sym)
> >>       /* QEMU console switch */
> >>       switch (qcode) {
> >>       case Q_KEY_CODE_1 ... Q_KEY_CODE_9: /* '1' to '9' keys */
> >> -        if (vs->vd->dcl.con =3D=3D NULL && down &&
> >> +        if (down &&
> >>               qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL) &&
> >>               qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALT)) {
> >> -            /* Reset the modifiers sent to the current console */
> >> -            qkbd_state_lift_all_keys(vs->vd->kbd);
> >> -            console_select(qcode - Q_KEY_CODE_1);
> >> +            QemuConsole *con =3D qemu_console_lookup_by_index(qcode -=
 Q_KEY_CODE_1);
> >> +            if (con) {
> >> +                unregister_displaychangelistener(&vs->vd->dcl);
> >> +                qkbd_state_switch_console(vs->vd->kbd, con);
> >> +                vs->vd->dcl.con =3D con;
> >> +                register_displaychangelistener(&vs->vd->dcl);
> >> +            }
> >>               return;
> >>           }
> >>       default:
> >> @@ -4206,7 +4210,7 @@ void vnc_display_open(const char *id, Error **er=
rp)
> >>               goto fail;
> >>           }
> >>       } else {
> >> -        con =3D NULL;
> >> +        con =3D qemu_console_lookup_first_graphic_console();
> >
> > why this change here?
>
> console_select() is to change the console that is used when
> DisplayChangeListener::con is NULL. console_select() is no longer called
> so DisplayChangeListener::con must not be NULL.


But qemu_console_lookup_first_graphic_console() can return NULL. It's
problematic for the next patches also which seem to assume that NULL
console is no longer a valid argument.

We would need a lot of assert(con !=3D NULL) or similar to ensure this hold=
s.

> >
> > otherwise, lgtm
> >
> >>       }
> >>
> >>       if (con !=3D vd->dcl.con) {
> >>
> >> --
> >> 2.44.0
> >>
> >>
> >
> >



--=20
Marc-Andr=C3=A9 Lureau

