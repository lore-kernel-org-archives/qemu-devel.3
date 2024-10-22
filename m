Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C8AD1CDAB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t39sl-0001gU-8W; Tue, 22 Oct 2024 04:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t39si-0001gB-N9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:04:44 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t39sf-0006A3-Sq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:04:44 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbf340fccaso42922896d6.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729584281; x=1730189081; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bLqxB6bSy9PL86q0CwYYOouEqhki3nI01/3L74hpq3Q=;
 b=OBl1AoBn28FxWodZk2GXTdXxieslsjGffRyAm59TpLOfIT/U2CsdZNxVyZZJGT3RBU
 37/SMH5to/C/VzpdCFK+bRc2lD5amza+H8CFFDCjtQW0KYM5n79VwmsDa9dKE7kcJdy5
 k5OD7cLt3ymvhW5iP9MpZSRntmaNHYBzE6+PXpTO0HR3lvUixxbxS5UNwSzRzaVExvh1
 4q/VzQpzt08r3rHuclV+R4gWOANY0j995P+Js2SVXVx5LZRG1Q1A2ee3AWnHe/ogRwYE
 eoCmlEZp57R8lX1WMWqUWFIoJmG90etZEozJOs0C3cEilMTvCKkmtTu7Rb+DGSHxF1z9
 kwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729584281; x=1730189081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bLqxB6bSy9PL86q0CwYYOouEqhki3nI01/3L74hpq3Q=;
 b=UtuXpf6QbdVH2EQQYsdE+89CaylRCr6NX7jY+iHxmsqfWeNDmWiah06/3N0lehyFLd
 JJZm+IuWoPvKupYed4Ng6grnG08U6/+TlVv5mQm7tyvhchIPw0hc4MXR5YljrOFQqQWZ
 /iKlva1SzfO3aSu536pzq85QReicNAI4Lv8RyQhJN8k04vqgw9Zx2esfLsRM+DAv5Xw8
 tdtzO7BRKYWBnB0LRkl3Ywz8olCN8WC3Ke2h5h7z1nrfhZsXNC2Ozlf4/CByBadPzU6a
 iu+l5tTENNr6x1KoyPMJXcnb/nAlFB/s+UIJHLxtG8P4epuhBbMLG5urAnbZ8HeEJIbo
 7mkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUul25/4ctkueMqGpHddjsS/NETQ1c+xnPKp5zCd7wAc6riUEL5MtVTbzLFNg8v0qA6kutwCXCQaXeQ@nongnu.org
X-Gm-Message-State: AOJu0YyKA9cnbQ0KS8C0iTPgBpN/cUx4WU2z24ejWpAmxZz5faRfw0Mt
 9eaS4bRC0xtjlF4BuNErfUpGU061j7Jrr41/JowOyyF5MR9WXCD1e3SS1+w3EPoSSEQ31BAli80
 UKhBcbiGRMpylZ6CbHV/rDsRxM2M=
X-Google-Smtp-Source: AGHT+IHgrrwNLOjp92gA9msg7vtZ2uKq1mGXYLWVHFVXEviTLeZ0djs4ZsZEWnEdSBJ3uIjgjniRuJnbS5cI5v5Qfjg=
X-Received: by 2002:a05:6214:f29:b0:6cb:644e:c9a8 with SMTP id
 6a1803df08f44-6ce21790824mr45008646d6.4.1729584280745; Tue, 22 Oct 2024
 01:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
 <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
 <ZxdaAtp6QlpqRSDs@redhat.com>
In-Reply-To: <ZxdaAtp6QlpqRSDs@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Oct 2024 12:04:29 +0400
Message-ID: <CAJ+F1CL003+CBNQmnD_pwx+TyvNDR75GnL-j7o+dXzkHbxYOuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, ankeesler@google.com,
 mst@redhat.com, qemu-devel@nongnu.org, venture@google.com
Content-Type: multipart/alternative; boundary="000000000000a9c11206250c3860"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a9c11206250c3860
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 22, 2024 at 11:54=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Mon, Oct 21, 2024 at 03:14:39PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Roque
> >
> > On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez
> > <roqueh@google.com> wrote:
> > >
> > > From: Andrew Keesler <ankeesler@google.com>
> > >
> > > Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
> Identification
> > > Data) is propagated by QEMU such that a virtual display presents
> legitimate
> > > metadata (e.g., name, serial number, preferred resolutions, etc.) to
> its
> > > connected guest.
> > >
> > > This change propagates an optional user-provided display name to
> > > QemuConsole. Future changes will update downstream devices to leverag=
e
> this
> > > display name for various uses, the primary one being providing a
> custom EDID
> > > name to guests. Future changes will also update other displays (e.g.,
> spice)
> > > with a similar option to propagate a display name to downstream
> devices.
> > >
> > > Currently, every virtio-gpu virtual display has the same name: "QEMU
> > > Monitor". We hope to be able to inject the EDID name of virtual
> displays in
> > > order to test guest behavior that is specific to display names. We
> provide the
> > > ability to inject the display name from the display configuration as
> that most
> > > closely resembles how real displays work (hardware displays contain
> static EDID
> > > information that is provided to every connected host).
> > >
> > > It should also be noted that EDID names longer than 12 bytes will be
> truncated
> > > per spec (I think?).
> > >
> > > Signed-off-by: Andrew Keesler <ankeesler@google.com>
> > > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > > ---
> > >  include/ui/console.h | 1 +
> > >  ui/console-priv.h    | 1 +
> > >  ui/console.c         | 8 ++++++++
> > >  ui/vnc.c             | 8 +++++++-
> > >  4 files changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/ui/console.h b/include/ui/console.h
> > > index 5832d52a8a..74ab03ed72 100644
> > > --- a/include/ui/console.h
> > > +++ b/include/ui/console.h
> > > @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
> > >  uint32_t qemu_console_get_head(QemuConsole *con);
> > >  int qemu_console_get_width(QemuConsole *con, int fallback);
> > >  int qemu_console_get_height(QemuConsole *con, int fallback);
> > > +void qemu_console_set_name(QemuConsole *con, const char *name);
> > >  /* Return the low-level window id for the console */
> > >  int qemu_console_get_window_id(QemuConsole *con);
> > >  /* Set the low-level window id for the console */
> > > diff --git a/ui/console-priv.h b/ui/console-priv.h
> > > index 43ceb8122f..9f2769843f 100644
> > > --- a/ui/console-priv.h
> > > +++ b/ui/console-priv.h
> > > @@ -18,6 +18,7 @@ struct QemuConsole {
> > >      Object parent;
> > >
> > >      int index;
> > > +    const char *name;
> > >      DisplayState *ds;
> > >      DisplaySurface *surface;
> > >      DisplayScanout scanout;
> > > diff --git a/ui/console.c b/ui/console.c
> > > index 5165f17125..f377fd8417 100644
> > > --- a/ui/console.c
> > > +++ b/ui/console.c
> > > @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con,
> int fallback)
> > >      }
> > >  }
> > >
> > > +void qemu_console_set_name(QemuConsole *con, const char *name)
> > > +{
> > > +    if (con =3D=3D NULL) {
> > > +        return;
> > > +    }
> > > +    con->name =3D name;
> > > +}
> > > +
> > >  int qemu_invalidate_text_consoles(void)
> > >  {
> > >      QemuConsole *s;
> > > diff --git a/ui/vnc.c b/ui/vnc.c
> > > index 93a8dbd253..7d6acc5c2e 100644
> > > --- a/ui/vnc.c
> > > +++ b/ui/vnc.c
> > > @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {
> > >          },{
> > >              .name =3D "power-control",
> > >              .type =3D QEMU_OPT_BOOL,
> > > +        },{
> > > +            .name =3D "name",
> > > +            .type =3D QEMU_OPT_STRING,
> > >          },
> > >          { /* end of list */ }
> > >      },
> > > @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error
> **errp)
> > >      QemuOpts *opts =3D qemu_opts_find(&qemu_vnc_opts, id);
> > >      g_autoptr(SocketAddressList) saddr_list =3D NULL;
> > >      g_autoptr(SocketAddressList) wsaddr_list =3D NULL;
> > > -    const char *share, *device_id;
> > > +    const char *share, *device_id, *name;
> > >      QemuConsole *con;
> > >      bool password =3D false;
> > >      bool reverse =3D false;
> > > @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error
> **errp)
> > >      }
> > >      qkbd_state_set_delay(vd->kbd, key_delay_ms);
> > >
> > > +    name =3D qemu_opt_get(opts, "name");
> > > +    qemu_console_set_name(vd->dcl.con, name);
> >
> > Why not expose a "head_name" property in QemuGraphicConsole?
>
> QemuGraphicConsole isn't mapped to any CLI though, is it ?
>
>
No, it would be a bit tedious to do so with multi-head -devices.


> In QAPI we have DisplayOptions union  for all the local displays,
> and as a user I think I'd expect 'name' to be settable from
> those.
>
>
DisplayOptions is meant for the UI display.. Here, the intent is really to
set the HW EDID name field.

Also DisplayOptions doesn't map to a specific console.


For VNC/SPICE, we have not mapped to QAPI, but they do have their
> own CLI options we can expose.
>
> For runtime setting, we have a QMP  "display-update" command, that
> currently just lets you change VNC listening address, but was intended
> to allow for any runtime display changes.
>
> > This way it should be possible to set the name with QMP qom-set.
>
> qom-set isn't a particularly nice interface, as things you can set
> from that are not introspectable and have no type information that
> can be queried.
>

fwiw, it could be easily exposed to D-Bus, for ex:

busctl --user set-property org.qemu /org/qemu/Display1/Console_1
org.qemu.Display1.Console HeadName s "First Monitor"

--=20
Marc-Andr=C3=A9 Lureau

--000000000000a9c11206250c3860
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 22, 2024 at 11:54=E2=80=
=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Mon, Oct 21, 2024 at 03:14:39PM +0400, Marc-Andr=C3=A9 =
Lureau wrote:<br>
&gt; Hi Roque<br>
&gt; <br>
&gt; On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez<br>
&gt; &lt;<a href=3D"mailto:roqueh@google.com" target=3D"_blank">roqueh@goog=
le.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; From: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.com" =
target=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display =
Identification<br>
&gt; &gt; Data) is propagated by QEMU such that a virtual display presents =
legitimate<br>
&gt; &gt; metadata (e.g., name, serial number, preferred resolutions, etc.)=
 to its<br>
&gt; &gt; connected guest.<br>
&gt; &gt;<br>
&gt; &gt; This change propagates an optional user-provided display name to<=
br>
&gt; &gt; QemuConsole. Future changes will update downstream devices to lev=
erage this<br>
&gt; &gt; display name for various uses, the primary one being providing a =
custom EDID<br>
&gt; &gt; name to guests. Future changes will also update other displays (e=
.g., spice)<br>
&gt; &gt; with a similar option to propagate a display name to downstream d=
evices.<br>
&gt; &gt;<br>
&gt; &gt; Currently, every virtio-gpu virtual display has the same name: &q=
uot;QEMU<br>
&gt; &gt; Monitor&quot;. We hope to be able to inject the EDID name of virt=
ual displays in<br>
&gt; &gt; order to test guest behavior that is specific to display names. W=
e provide the<br>
&gt; &gt; ability to inject the display name from the display configuration=
 as that most<br>
&gt; &gt; closely resembles how real displays work (hardware displays conta=
in static EDID<br>
&gt; &gt; information that is provided to every connected host).<br>
&gt; &gt;<br>
&gt; &gt; It should also be noted that EDID names longer than 12 bytes will=
 be truncated<br>
&gt; &gt; per spec (I think?).<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@goo=
gle.com" target=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Roque Arcudia Hernandez &lt;<a href=3D"mailto:roqu=
eh@google.com" target=3D"_blank">roqueh@google.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 include/ui/console.h | 1 +<br>
&gt; &gt;=C2=A0 ui/console-priv.h=C2=A0 =C2=A0 | 1 +<br>
&gt; &gt;=C2=A0 ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++++++<=
br>
&gt; &gt;=C2=A0 ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8=
 +++++++-<br>
&gt; &gt;=C2=A0 4 files changed, 17 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/include/ui/console.h b/include/ui/console.h<br>
&gt; &gt; index 5832d52a8a..74ab03ed72 100644<br>
&gt; &gt; --- a/include/ui/console.h<br>
&gt; &gt; +++ b/include/ui/console.h<br>
&gt; &gt; @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);=
<br>
&gt; &gt;=C2=A0 uint32_t qemu_console_get_head(QemuConsole *con);<br>
&gt; &gt;=C2=A0 int qemu_console_get_width(QemuConsole *con, int fallback);=
<br>
&gt; &gt;=C2=A0 int qemu_console_get_height(QemuConsole *con, int fallback)=
;<br>
&gt; &gt; +void qemu_console_set_name(QemuConsole *con, const char *name);<=
br>
&gt; &gt;=C2=A0 /* Return the low-level window id for the console */<br>
&gt; &gt;=C2=A0 int qemu_console_get_window_id(QemuConsole *con);<br>
&gt; &gt;=C2=A0 /* Set the low-level window id for the console */<br>
&gt; &gt; diff --git a/ui/console-priv.h b/ui/console-priv.h<br>
&gt; &gt; index 43ceb8122f..9f2769843f 100644<br>
&gt; &gt; --- a/ui/console-priv.h<br>
&gt; &gt; +++ b/ui/console-priv.h<br>
&gt; &gt; @@ -18,6 +18,7 @@ struct QemuConsole {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Object parent;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int index;<br>
&gt; &gt; +=C2=A0 =C2=A0 const char *name;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DisplayState *ds;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DisplayScanout scanout;<br>
&gt; &gt; diff --git a/ui/console.c b/ui/console.c<br>
&gt; &gt; index 5165f17125..f377fd8417 100644<br>
&gt; &gt; --- a/ui/console.c<br>
&gt; &gt; +++ b/ui/console.c<br>
&gt; &gt; @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *c=
on, int fallback)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +void qemu_console_set_name(QemuConsole *con, const char *name)<b=
r>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 con-&gt;name =3D name;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 int qemu_invalidate_text_consoles(void)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 QemuConsole *s;<br>
&gt; &gt; diff --git a/ui/vnc.c b/ui/vnc.c<br>
&gt; &gt; index 93a8dbd253..7d6acc5c2e 100644<br>
&gt; &gt; --- a/ui/vnc.c<br>
&gt; &gt; +++ b/ui/vnc.c<br>
&gt; &gt; @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;p=
ower-control&quot;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OP=
T_BOOL,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;name&q=
uot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_STR=
ING,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { /* end of list */ }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt; @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error=
 **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 QemuOpts *opts =3D qemu_opts_find(&amp;qemu_v=
nc_opts, id);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(SocketAddressList) saddr_list =3D N=
ULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(SocketAddressList) wsaddr_list =3D =
NULL;<br>
&gt; &gt; -=C2=A0 =C2=A0 const char *share, *device_id;<br>
&gt; &gt; +=C2=A0 =C2=A0 const char *share, *device_id, *name;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 QemuConsole *con;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool password =3D false;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool reverse =3D false;<br>
&gt; &gt; @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error=
 **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 qkbd_state_set_delay(vd-&gt;kbd, key_delay_ms=
);<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 name =3D qemu_opt_get(opts, &quot;name&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 qemu_console_set_name(vd-&gt;dcl.con, name);<br>
&gt; <br>
&gt; Why not expose a &quot;head_name&quot; property in QemuGraphicConsole?=
<br>
<br>
QemuGraphicConsole isn&#39;t mapped to any CLI though, is it ?<br>
<br></blockquote><div><br></div><div>No, it would be a bit tedious to do so=
 with multi-head -devices.</div><div>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
In QAPI we have DisplayOptions union=C2=A0 for all the local displays,<br>
and as a user I think I&#39;d expect &#39;name&#39; to be settable from<br>
those.<br>
<br></blockquote><div><br></div><div>DisplayOptions is meant for the UI dis=
play.. Here, the intent is really to set the HW EDID name field.<br></div><=
div>=C2=A0</div><div>Also DisplayOptions doesn&#39;t map to a specific cons=
ole.</div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
For VNC/SPICE, we have not mapped to QAPI, but they do have their<br>
own CLI options we can expose.<br>
<br>
For runtime setting, we have a QMP=C2=A0 &quot;display-update&quot; command=
, that<br>
currently just lets you change VNC listening address, but was intended<br>
to allow for any runtime display changes.<br>
<br>
&gt; This way it should be possible to set the name with QMP qom-set.<br>
<br>
qom-set isn&#39;t a particularly nice interface, as things you can set<br>
from that are not introspectable and have no type information that<br>
can be queried.<br clear=3D"all"></blockquote><div><br></div><div>fwiw, it =
could be easily exposed to D-Bus, for ex:<br></div><div><br></div><div>busc=
tl --user set-property org.qemu /org/qemu/Display1/Console_1 org.qemu.Displ=
ay1.Console HeadName s &quot;First Monitor&quot; <br></div></div><br><span =
class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gm=
ail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000a9c11206250c3860--

