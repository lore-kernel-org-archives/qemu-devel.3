Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238C6D1CDAB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t39eV-0004vC-JP; Tue, 22 Oct 2024 03:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t39eT-0004ux-SP
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:50:02 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t39eR-0004SS-Is
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:50:01 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-460ad98b031so29015181cf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729583398; x=1730188198; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RQztYvJ+hQDBb9RwMfGInk86ktC4HeAcB5wn3VIR4SU=;
 b=eca3OTK2uiv2tBNRgroIQ3GOekfYIfuximfiapst/GNWK+OpQrscrlt+QB0+3pQOWu
 tJxIEfJG0nD9vt1cN48etS1Yenn4Ldxd6LONmBaeBOQR2tWF76yTnygYvzJui/YYMhem
 tn7IBwkCEa0miGqxz26QeSzqRSTHZYY6o3jgBi0dlbONA15CWqO4znFjnoHP3+XnyI14
 jvt0CLGWW3J+UY5K6djZ2WKo2J7w4dsF4fcquTgUNQkhaVbWDLIcTHfa/84l5fEhwJTu
 ALVRG5hOK/2WVLMtRU1OU36u621usMmW1XS/pCIKtfy7gca/0xI8n9PidAr5avXVE1/C
 Nlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729583398; x=1730188198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RQztYvJ+hQDBb9RwMfGInk86ktC4HeAcB5wn3VIR4SU=;
 b=qrxiuhLG8P31V5/GGlo4r0Zyd2TE+AdnMwxFfq98XCj6O5WsN5upHR22px0aKK6z0B
 WNpeljEpqkYb2xYfheZ7rF17DwjdGeoajph5kCK+DuxLcUIRS9lrLmEymY8Od5l2oSaX
 XcNWRQz2gcoYdmL585YHt2lJvlErw1mkJvL+9gSTToP7zaAyqlArSyaomcxj16PRwlOG
 wdrUxpreURADA2p2bLKJFH6CtulzCCA/aa/DKZhpi7bSzVbE98E63YsMq2k10UA49MBc
 ofUkbavvKmJk2d2U1nwDIq7Dt8Rf+c1MEYhDdTuVbmiVMEsc8cTYniKqhJTscNlGYGLy
 CT/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1k6M0cYueKn16T4DjosY7OFZNyQkDxhbFLNiNh1hyBhLkzNKTQbP+w8CDmgkWk8OtQeev/IKHM97U@nongnu.org
X-Gm-Message-State: AOJu0YxFowX6LMfNyIp78y+TefmMSUj6MPpvCgqorqBBtufxky6rYlZq
 R/p0W9fmg6u6lkXctUyFFCz1/in1LdqqGPC7q1WQZ+PpFC9rIAibulSzDzG3ozMV5a9QZ5KwOoD
 3dORnwvefKJ9vgioOrMPs1GMWhOA=
X-Google-Smtp-Source: AGHT+IFHL8Fjwn3rEDn2bDP7gNsSOSu2KFOMIs+/BEam3ZKzRzV4kNxTA4aOqUHwytnazwCpAQX/OdxKnUxDVLR8eD4=
X-Received: by 2002:ac8:5a56:0:b0:460:8d5c:34bd with SMTP id
 d75a77b69052e-460aed33e48mr229619421cf.17.1729583398128; Tue, 22 Oct 2024
 00:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
 <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
 <CAGZECHPnD5XiZbGzHbxCEUOxE_CTR3ZOHBzF8+38xAqwYQAn_A@mail.gmail.com>
In-Reply-To: <CAGZECHPnD5XiZbGzHbxCEUOxE_CTR3ZOHBzF8+38xAqwYQAn_A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Oct 2024 11:49:46 +0400
Message-ID: <CAJ+F1CJXBRe4kgVA_bPoB0jZsWefba5JYY=pUbLt32tczSLhTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
To: Andrew Keesler <ankeesler@google.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 qemu-devel@nongnu.org, venture@google.com
Content-Type: multipart/alternative; boundary="0000000000000e157006250c0442"
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

--0000000000000e157006250c0442
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 22, 2024 at 12:23=E2=80=AFAM Andrew Keesler <ankeesler@google.c=
om>
wrote:

> Hi Marc-Andr=C3=A9 -
>
> The ability to set the name with QMP qom-set seems like a nice behavior.
>
> Note that the ultimate goal of this name is to propagate it downstream to
> a device (see next patch[0] for a sample propagation to virtio-gpu).
>
> In order to accomplish this, would it work to expose this new "head_name"
> property via a qemu_graphic_console_get_head_name(QemuConsole *c) functio=
n
> that:
>
> 1. verifies that c is indeed a QemuGraphicConsole with
>    QEMU_IS_GRAPHIC_CONSOLE(), and
> 2. returns c->head_name (similar to qemu_console_get_name() from [0])?
>

> We'd probably need a similar function
> qemu_graphic_console_get_head_name(QemuConsole *c, const char *name) in
> order to
> set the head_name from a display (e.g., VNC) - correct me if you were
> thinking
>

Right (qemu_graphic_console_set_head_name), get/set exposed to QOM via
object_class_property_add_str()


> of going a different direction with this interface, though. My main goal
> is to
> provide some way for a user to inject a display EDID name from the comman=
d
> line.
>
> Also, just to verify my understanding - there would never be a QemuConsol=
e
> that
> a) is NOT a QemuGraphicConsole AND b) is associated with an EDID in a
> guest,
> correct?
>
>
Seems correct.

(fwiw, I think we should have all UI info(s) as part of QemuUIInfo,
including the head name, but this would require further refactoring to
avoid some copy etc)


> [0] https://lists.gnu.org/archive/html/qemu-devel/2024-10/msg03238.html
>
> On Mon, Oct 21, 2024 at 7:14=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@redhat.com> wrote:
>
>> Hi Roque
>>
>> On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez
>> <roqueh@google.com> wrote:
>> >
>> > From: Andrew Keesler <ankeesler@google.com>
>> >
>> > Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
>> Identification
>> > Data) is propagated by QEMU such that a virtual display presents
>> legitimate
>> > metadata (e.g., name, serial number, preferred resolutions, etc.) to i=
ts
>> > connected guest.
>> >
>> > This change propagates an optional user-provided display name to
>> > QemuConsole. Future changes will update downstream devices to leverage
>> this
>> > display name for various uses, the primary one being providing a custo=
m
>> EDID
>> > name to guests. Future changes will also update other displays (e.g.,
>> spice)
>> > with a similar option to propagate a display name to downstream device=
s.
>> >
>> > Currently, every virtio-gpu virtual display has the same name: "QEMU
>> > Monitor". We hope to be able to inject the EDID name of virtual
>> displays in
>> > order to test guest behavior that is specific to display names. We
>> provide the
>> > ability to inject the display name from the display configuration as
>> that most
>> > closely resembles how real displays work (hardware displays contain
>> static EDID
>> > information that is provided to every connected host).
>> >
>> > It should also be noted that EDID names longer than 12 bytes will be
>> truncated
>> > per spec (I think?).
>> >
>> > Signed-off-by: Andrew Keesler <ankeesler@google.com>
>> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
>> > ---
>> >  include/ui/console.h | 1 +
>> >  ui/console-priv.h    | 1 +
>> >  ui/console.c         | 8 ++++++++
>> >  ui/vnc.c             | 8 +++++++-
>> >  4 files changed, 17 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/include/ui/console.h b/include/ui/console.h
>> > index 5832d52a8a..74ab03ed72 100644
>> > --- a/include/ui/console.h
>> > +++ b/include/ui/console.h
>> > @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
>> >  uint32_t qemu_console_get_head(QemuConsole *con);
>> >  int qemu_console_get_width(QemuConsole *con, int fallback);
>> >  int qemu_console_get_height(QemuConsole *con, int fallback);
>> > +void qemu_console_set_name(QemuConsole *con, const char *name);
>> >  /* Return the low-level window id for the console */
>> >  int qemu_console_get_window_id(QemuConsole *con);
>> >  /* Set the low-level window id for the console */
>> > diff --git a/ui/console-priv.h b/ui/console-priv.h
>> > index 43ceb8122f..9f2769843f 100644
>> > --- a/ui/console-priv.h
>> > +++ b/ui/console-priv.h
>> > @@ -18,6 +18,7 @@ struct QemuConsole {
>> >      Object parent;
>> >
>> >      int index;
>> > +    const char *name;
>> >      DisplayState *ds;
>> >      DisplaySurface *surface;
>> >      DisplayScanout scanout;
>> > diff --git a/ui/console.c b/ui/console.c
>> > index 5165f17125..f377fd8417 100644
>> > --- a/ui/console.c
>> > +++ b/ui/console.c
>> > @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con,
>> int fallback)
>> >      }
>> >  }
>> >
>> > +void qemu_console_set_name(QemuConsole *con, const char *name)
>> > +{
>> > +    if (con =3D=3D NULL) {
>> > +        return;
>> > +    }
>> > +    con->name =3D name;
>> > +}
>> > +
>> >  int qemu_invalidate_text_consoles(void)
>> >  {
>> >      QemuConsole *s;
>> > diff --git a/ui/vnc.c b/ui/vnc.c
>> > index 93a8dbd253..7d6acc5c2e 100644
>> > --- a/ui/vnc.c
>> > +++ b/ui/vnc.c
>> > @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {
>> >          },{
>> >              .name =3D "power-control",
>> >              .type =3D QEMU_OPT_BOOL,
>> > +        },{
>> > +            .name =3D "name",
>> > +            .type =3D QEMU_OPT_STRING,
>> >          },
>> >          { /* end of list */ }
>> >      },
>> > @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error
>> **errp)
>> >      QemuOpts *opts =3D qemu_opts_find(&qemu_vnc_opts, id);
>> >      g_autoptr(SocketAddressList) saddr_list =3D NULL;
>> >      g_autoptr(SocketAddressList) wsaddr_list =3D NULL;
>> > -    const char *share, *device_id;
>> > +    const char *share, *device_id, *name;
>> >      QemuConsole *con;
>> >      bool password =3D false;
>> >      bool reverse =3D false;
>> > @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error
>> **errp)
>> >      }
>> >      qkbd_state_set_delay(vd->kbd, key_delay_ms);
>> >
>> > +    name =3D qemu_opt_get(opts, "name");
>> > +    qemu_console_set_name(vd->dcl.con, name);
>>
>> Why not expose a "head_name" property in QemuGraphicConsole?
>>
>> This way it should be possible to set the name with QMP qom-set.
>>
>>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000000e157006250c0442
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 22, 2024 at 12:23=E2=80=
=AFAM Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.com">ankeesler@=
google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div>Hi Marc-Andr=C3=A9 -<br><br>The ability to=
 set the name with QMP qom-set seems like a nice behavior.<br><br>Note that=
 the ultimate goal of this name is to propagate it downstream to<br>a devic=
e (see next patch[0] for a sample propagation to virtio-gpu).<br><br>In ord=
er to accomplish this, would it work to expose this new &quot;head_name&quo=
t;<br>property via a qemu_graphic_console_get_head_name(QemuConsole *c) fun=
ction that:<br><br>1. verifies that c is indeed a QemuGraphicConsole with<b=
r>=C2=A0 =C2=A0QEMU_IS_GRAPHIC_CONSOLE(), and<br>2. returns c-&gt;head_name=
 (similar to qemu_console_get_name() from [0])? <br></div></div></blockquot=
e><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><=
br>We&#39;d probably need a similar function<br>qemu_graphic_console_get_he=
ad_name(QemuConsole *c, const char *name) in order to<br>set the head_name =
from a display (e.g., VNC) - correct me if you were thinking<br></div></div=
></blockquote><div><br></div><div>Right (qemu_graphic_console_set_head_name=
), get/set exposed to QOM via object_class_property_add_str()<br></div><div=
>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div>of going a different direction with this interface, though. M=
y main goal is to<br>provide some way for a user to inject a display EDID n=
ame from the command line.<br><br>Also, just to verify my understanding - t=
here would never be a QemuConsole that<br>a) is NOT a QemuGraphicConsole AN=
D b) is associated with an EDID in a guest,<br>correct?<br><br></div></div>=
</blockquote><div>=C2=A0</div><div>Seems correct.</div><div><br></div><div>=
(fwiw, I think we should have all UI info(s) as part of QemuUIInfo, includi=
ng the head name, but this would require further refactoring to avoid some =
copy etc)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div>[0] <a href=3D"https://lists.gnu.org/archi=
ve/html/qemu-devel/2024-10/msg03238.html" target=3D"_blank">https://lists.g=
nu.org/archive/html/qemu-devel/2024-10/msg03238.html</a><br></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, O=
ct 21, 2024 at 7:14=E2=80=AFAM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto=
:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Hi Roque<br>
<br>
On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez<br>
&lt;<a href=3D"mailto:roqueh@google.com" target=3D"_blank">roqueh@google.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.com" targe=
t=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt;<br>
&gt; Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Ident=
ification<br>
&gt; Data) is propagated by QEMU such that a virtual display presents legit=
imate<br>
&gt; metadata (e.g., name, serial number, preferred resolutions, etc.) to i=
ts<br>
&gt; connected guest.<br>
&gt;<br>
&gt; This change propagates an optional user-provided display name to<br>
&gt; QemuConsole. Future changes will update downstream devices to leverage=
 this<br>
&gt; display name for various uses, the primary one being providing a custo=
m EDID<br>
&gt; name to guests. Future changes will also update other displays (e.g., =
spice)<br>
&gt; with a similar option to propagate a display name to downstream device=
s.<br>
&gt;<br>
&gt; Currently, every virtio-gpu virtual display has the same name: &quot;Q=
EMU<br>
&gt; Monitor&quot;. We hope to be able to inject the EDID name of virtual d=
isplays in<br>
&gt; order to test guest behavior that is specific to display names. We pro=
vide the<br>
&gt; ability to inject the display name from the display configuration as t=
hat most<br>
&gt; closely resembles how real displays work (hardware displays contain st=
atic EDID<br>
&gt; information that is provided to every connected host).<br>
&gt;<br>
&gt; It should also be noted that EDID names longer than 12 bytes will be t=
runcated<br>
&gt; per spec (I think?).<br>
&gt;<br>
&gt; Signed-off-by: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.c=
om" target=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt; Signed-off-by: Roque Arcudia Hernandez &lt;<a href=3D"mailto:roqueh@go=
ogle.com" target=3D"_blank">roqueh@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/ui/console.h | 1 +<br>
&gt;=C2=A0 ui/console-priv.h=C2=A0 =C2=A0 | 1 +<br>
&gt;=C2=A0 ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++++++<br>
&gt;=C2=A0 ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++=
+++-<br>
&gt;=C2=A0 4 files changed, 17 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/include/ui/console.h b/include/ui/console.h<br>
&gt; index 5832d52a8a..74ab03ed72 100644<br>
&gt; --- a/include/ui/console.h<br>
&gt; +++ b/include/ui/console.h<br>
&gt; @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);<br>
&gt;=C2=A0 uint32_t qemu_console_get_head(QemuConsole *con);<br>
&gt;=C2=A0 int qemu_console_get_width(QemuConsole *con, int fallback);<br>
&gt;=C2=A0 int qemu_console_get_height(QemuConsole *con, int fallback);<br>
&gt; +void qemu_console_set_name(QemuConsole *con, const char *name);<br>
&gt;=C2=A0 /* Return the low-level window id for the console */<br>
&gt;=C2=A0 int qemu_console_get_window_id(QemuConsole *con);<br>
&gt;=C2=A0 /* Set the low-level window id for the console */<br>
&gt; diff --git a/ui/console-priv.h b/ui/console-priv.h<br>
&gt; index 43ceb8122f..9f2769843f 100644<br>
&gt; --- a/ui/console-priv.h<br>
&gt; +++ b/ui/console-priv.h<br>
&gt; @@ -18,6 +18,7 @@ struct QemuConsole {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Object parent;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int index;<br>
&gt; +=C2=A0 =C2=A0 const char *name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DisplayState *ds;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DisplayScanout scanout;<br>
&gt; diff --git a/ui/console.c b/ui/console.c<br>
&gt; index 5165f17125..f377fd8417 100644<br>
&gt; --- a/ui/console.c<br>
&gt; +++ b/ui/console.c<br>
&gt; @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con, i=
nt fallback)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +void qemu_console_set_name(QemuConsole *con, const char *name)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 con-&gt;name =3D name;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int qemu_invalidate_text_consoles(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuConsole *s;<br>
&gt; diff --git a/ui/vnc.c b/ui/vnc.c<br>
&gt; index 93a8dbd253..7d6acc5c2e 100644<br>
&gt; --- a/ui/vnc.c<br>
&gt; +++ b/ui/vnc.c<br>
&gt; @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;power-=
control&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_BOO=
L,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;name&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_STRING,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { /* end of list */ }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error **er=
rp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuOpts *opts =3D qemu_opts_find(&amp;qemu_vnc_op=
ts, id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(SocketAddressList) saddr_list =3D NULL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(SocketAddressList) wsaddr_list =3D NULL;=
<br>
&gt; -=C2=A0 =C2=A0 const char *share, *device_id;<br>
&gt; +=C2=A0 =C2=A0 const char *share, *device_id, *name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuConsole *con;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool password =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool reverse =3D false;<br>
&gt; @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error **er=
rp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qkbd_state_set_delay(vd-&gt;kbd, key_delay_ms);<br=
>
&gt;<br>
&gt; +=C2=A0 =C2=A0 name =3D qemu_opt_get(opts, &quot;name&quot;);<br>
&gt; +=C2=A0 =C2=A0 qemu_console_set_name(vd-&gt;dcl.con, name);<br>
<br>
Why not expose a &quot;head_name&quot; property in QemuGraphicConsole?<br>
<br>
This way it should be possible to set the name with QMP qom-set.<br>
<br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000000e157006250c0442--

