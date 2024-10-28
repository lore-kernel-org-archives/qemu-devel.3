Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24850D3E2BA
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 19:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5VMh-0007RR-V5; Mon, 28 Oct 2024 15:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1t5VMg-0007R8-NW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 15:25:22 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1t5VMd-0001sa-SR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 15:25:22 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso3187918a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730143517; x=1730748317; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=naTe7e4PC2y34ZgpkRJrNdD4ravHjUUfywJ10yCd/sQ=;
 b=eRY+CXIH2hOUL6aynFez1QALXxOwPsijBnIxaWlBUNaUXQRjSLC2yjTbDL+SbT62T9
 6zFwV0no0Ewr0AurMlVJtTFYwMYVygt9TY5lrb5LY4iU911sNzBUKe0AXyKh1ydtWYCt
 pw1EbzTVZ9wdPZd2BjMuuDcbHVJMkA2IjsVhzKTvbStH8gzEbGEUHnWbt8xuknPyyl0d
 3JiDy0WLSQ6xVQgykmx8EExLfo0HXzzz9AHz2TcVNd89d/R4PEOdzKj3WuMDrH1LgjgQ
 xMqwiwOwwSG46vizaYJRMCbnZDvCgsJ2it3YpCrH3YyCaNO6D07V8lVhB4m3cphPNi1o
 g/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143517; x=1730748317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=naTe7e4PC2y34ZgpkRJrNdD4ravHjUUfywJ10yCd/sQ=;
 b=FThjKM9+UPPkqxp+Y3P5EXEIiCSCXUAD0C/YedDsA0WIffwMVf6SNH5jg1WCMUVmj/
 VijPE9D2pbEGZVPeQ4s2aTugicOTQANVZCA9LsygwoVnYYGUMFsLyVs8R+W48WICRLMN
 5UAkGEqkYOWVgKsmyX3O+plTwi4S8scR1e6vf2Rs8KzHsvE2k4jC5IjQCSLz0bZT1dXe
 OBy5EPQ1woEqWVEbAXGp2+sykRUwR4X7bJg4OWyB1wnSqotKSta5AzF2LwY85JI6Gzuw
 QyEzsWK5tNUUlzcmlUdUBB728RZr3O3wa1qSn+x+O1/e3aF5UprX91zLpXxdwfj1SuiU
 Qa8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6hQir/55tklKtH1cud+bBuZddUUHUYj5/MMyNZ+KqZYyRtH+4P7mnKfIvJU/KBB/GIinJJ23vG791@nongnu.org
X-Gm-Message-State: AOJu0YxFY/Yh2X6VZDUDfRrq77DXtSy64MagBe6QBqQy9SZFJDQ7OVjl
 nIyfPZ1ZKXf1hoDUp+fAo49/zMWG+Ps+39Lfq+pXi+eSgb6/wThfkBXhSMICrqWPsixu1j9v6hg
 b7UOqU6XrCJL8Tvgjsg9gaO3GDjTPyOPXRIw=
X-Google-Smtp-Source: AGHT+IHx5/NvQAXHhPKTebkrOeKem8R/4+pAqspx16+roTIhB95ADY8uO3gSd+E4Mxs5MJtfKb10jYYjXhrcnf07wtc=
X-Received: by 2002:a05:6a21:3a4b:b0:1d7:1288:8338 with SMTP id
 adf61e73a8af0-1d9dc7ef63bmr965016637.8.1730143516890; Mon, 28 Oct 2024
 12:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
 <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
 <ZxdaAtp6QlpqRSDs@redhat.com>
 <CAJ+F1CL003+CBNQmnD_pwx+TyvNDR75GnL-j7o+dXzkHbxYOuw@mail.gmail.com>
 <Zxdd2UUtvSqBap9D@redhat.com>
 <CAJ+F1CK2oRvsh=+NQKTfUgkbt9XOvn141wodH-w2Zrne7g=SpQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CK2oRvsh=+NQKTfUgkbt9XOvn141wodH-w2Zrne7g=SpQ@mail.gmail.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Mon, 28 Oct 2024 15:25:05 -0400
Message-ID: <CAGZECHO9pL8LYPBDcKDj5Rm3KDHD6BmJP7iZLwf85EjJt14Rgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 qemu-devel@nongnu.org, venture@google.com
Content-Type: multipart/alternative; boundary="000000000000bd02bf06258e6dc7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=ankeesler@google.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000bd02bf06258e6dc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel and Marc-Andr=C3=A9 - please excuse my delay (I was traveling
last week).

I see 2 primary takeaways here:

1. Updating the name field from the ServerInit RFB message to be
   controlled by the 'name' VNC option

2. Updating where we store the display 'name' in memory

For 1 - are we amenable to me updating this display name field to be
controlled by 'name' in a future patch? I'm still learning what the
QEMU community prefers with respect to patch sizes, but in general I
have been trying to keep the patches small.

For 2 - have we landed on storing the per-display 'name' in
DisplayOptions? I can't quite tell if we've converged here. It also
seems like there is some more plumbing to install here before we
leverage DisplayOptions, so I am curious what the recommendation is
for this patch - is there a temporary solution we could pursue and do
refactors later to unlock the CLI functionality that has been brought
up?

Correct me if I am wrong about any of this.

On Tue, Oct 22, 2024 at 4:36=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com>
> wrote:
>
>> On Tue, Oct 22, 2024 at 12:04:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> > Hi
>> >
>> > On Tue, Oct 22, 2024 at 11:54=E2=80=AFAM Daniel P. Berrang=C3=A9 <
>> berrange@redhat.com>
>> > wrote:
>> >
>> > > On Mon, Oct 21, 2024 at 03:14:39PM +0400, Marc-Andr=C3=A9 Lureau wro=
te:
>> > > > Hi Roque
>> > > >
>> > > > On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez
>> > > > <roqueh@google.com> wrote:
>> > > > >
>> > > > > From: Andrew Keesler <ankeesler@google.com>
>> > > > >
>> > > > > Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
>> > > Identification
>> > > > > Data) is propagated by QEMU such that a virtual display presents
>> > > legitimate
>> > > > > metadata (e.g., name, serial number, preferred resolutions, etc.=
)
>> to
>> > > its
>> > > > > connected guest.
>> > > > >
>> > > > > This change propagates an optional user-provided display name to
>> > > > > QemuConsole. Future changes will update downstream devices to
>> leverage
>> > > this
>> > > > > display name for various uses, the primary one being providing a
>> > > custom EDID
>> > > > > name to guests. Future changes will also update other displays
>> (e.g.,
>> > > spice)
>> > > > > with a similar option to propagate a display name to downstream
>> > > devices.
>> > > > >
>> > > > > Currently, every virtio-gpu virtual display has the same name:
>> "QEMU
>> > > > > Monitor". We hope to be able to inject the EDID name of virtual
>> > > displays in
>> > > > > order to test guest behavior that is specific to display names. =
We
>> > > provide the
>> > > > > ability to inject the display name from the display configuratio=
n
>> as
>> > > that most
>> > > > > closely resembles how real displays work (hardware displays
>> contain
>> > > static EDID
>> > > > > information that is provided to every connected host).
>> > > > >
>> > > > > It should also be noted that EDID names longer than 12 bytes wil=
l
>> be
>> > > truncated
>> > > > > per spec (I think?).
>> > > > >
>> > > > > Signed-off-by: Andrew Keesler <ankeesler@google.com>
>> > > > > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
>> > > > > ---
>> > > > >  include/ui/console.h | 1 +
>> > > > >  ui/console-priv.h    | 1 +
>> > > > >  ui/console.c         | 8 ++++++++
>> > > > >  ui/vnc.c             | 8 +++++++-
>> > > > >  4 files changed, 17 insertions(+), 1 deletion(-)
>> > > > >
>> > > > > diff --git a/include/ui/console.h b/include/ui/console.h
>> > > > > index 5832d52a8a..74ab03ed72 100644
>> > > > > --- a/include/ui/console.h
>> > > > > +++ b/include/ui/console.h
>> > > > > @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con)=
;
>> > > > >  uint32_t qemu_console_get_head(QemuConsole *con);
>> > > > >  int qemu_console_get_width(QemuConsole *con, int fallback);
>> > > > >  int qemu_console_get_height(QemuConsole *con, int fallback);
>> > > > > +void qemu_console_set_name(QemuConsole *con, const char *name);
>> > > > >  /* Return the low-level window id for the console */
>> > > > >  int qemu_console_get_window_id(QemuConsole *con);
>> > > > >  /* Set the low-level window id for the console */
>> > > > > diff --git a/ui/console-priv.h b/ui/console-priv.h
>> > > > > index 43ceb8122f..9f2769843f 100644
>> > > > > --- a/ui/console-priv.h
>> > > > > +++ b/ui/console-priv.h
>> > > > > @@ -18,6 +18,7 @@ struct QemuConsole {
>> > > > >      Object parent;
>> > > > >
>> > > > >      int index;
>> > > > > +    const char *name;
>> > > > >      DisplayState *ds;
>> > > > >      DisplaySurface *surface;
>> > > > >      DisplayScanout scanout;
>> > > > > diff --git a/ui/console.c b/ui/console.c
>> > > > > index 5165f17125..f377fd8417 100644
>> > > > > --- a/ui/console.c
>> > > > > +++ b/ui/console.c
>> > > > > @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole
>> *con,
>> > > int fallback)
>> > > > >      }
>> > > > >  }
>> > > > >
>> > > > > +void qemu_console_set_name(QemuConsole *con, const char *name)
>> > > > > +{
>> > > > > +    if (con =3D=3D NULL) {
>> > > > > +        return;
>> > > > > +    }
>> > > > > +    con->name =3D name;
>> > > > > +}
>> > > > > +
>> > > > >  int qemu_invalidate_text_consoles(void)
>> > > > >  {
>> > > > >      QemuConsole *s;
>> > > > > diff --git a/ui/vnc.c b/ui/vnc.c
>> > > > > index 93a8dbd253..7d6acc5c2e 100644
>> > > > > --- a/ui/vnc.c
>> > > > > +++ b/ui/vnc.c
>> > > > > @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {
>> > > > >          },{
>> > > > >              .name =3D "power-control",
>> > > > >              .type =3D QEMU_OPT_BOOL,
>> > > > > +        },{
>> > > > > +            .name =3D "name",
>> > > > > +            .type =3D QEMU_OPT_STRING,
>> > > > >          },
>> > > > >          { /* end of list */ }
>> > > > >      },
>> > > > > @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Erro=
r
>> > > **errp)
>> > > > >      QemuOpts *opts =3D qemu_opts_find(&qemu_vnc_opts, id);
>> > > > >      g_autoptr(SocketAddressList) saddr_list =3D NULL;
>> > > > >      g_autoptr(SocketAddressList) wsaddr_list =3D NULL;
>> > > > > -    const char *share, *device_id;
>> > > > > +    const char *share, *device_id, *name;
>> > > > >      QemuConsole *con;
>> > > > >      bool password =3D false;
>> > > > >      bool reverse =3D false;
>> > > > > @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Erro=
r
>> > > **errp)
>> > > > >      }
>> > > > >      qkbd_state_set_delay(vd->kbd, key_delay_ms);
>> > > > >
>> > > > > +    name =3D qemu_opt_get(opts, "name");
>> > > > > +    qemu_console_set_name(vd->dcl.con, name);
>> > > >
>> > > > Why not expose a "head_name" property in QemuGraphicConsole?
>> > >
>> > > QemuGraphicConsole isn't mapped to any CLI though, is it ?
>> > >
>> > >
>> > No, it would be a bit tedious to do so with multi-head -devices.
>> >
>> >
>> > > In QAPI we have DisplayOptions union  for all the local displays,
>> > > and as a user I think I'd expect 'name' to be settable from
>> > > those.
>> > >
>> > >
>> > DisplayOptions is meant for the UI display.. Here, the intent is reall=
y
>> to
>> > set the HW EDID name field.
>>
>> But it is also applicable to the backend, all of which have a
>> name for the display set in the window titlebar. We should
>> be looking at both sides IMHO.
>>
>
> Ok, if we consider both should be treated similarly / reflect each other.
>
>
>>
>> > Also DisplayOptions doesn't map to a specific console.
>>
>> It could be made to contain per-head information if we desired
>> though, and would be more useful than just the name. There were
>> some patches a while ago trying to express per-console placement
>> of windows onto host monitor outputs, for example.
>>
>
> [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
> https://patchew.org/QEMU/20240531185804.119557-1-dongwon.kim@intel.com/
>
>>
>> > > own CLI options we can expose.
>> > >
>> > > For runtime setting, we have a QMP  "display-update" command, that
>> > > currently just lets you change VNC listening address, but was intend=
ed
>> > > to allow for any runtime display changes.
>> > >
>> > > > This way it should be possible to set the name with QMP qom-set.
>> > >
>> > > qom-set isn't a particularly nice interface, as things you can set
>> > > from that are not introspectable and have no type information that
>> > > can be queried.
>> > >
>> >
>> > fwiw, it could be easily exposed to D-Bus, for ex:
>> >
>> > busctl --user set-property org.qemu /org/qemu/Display1/Console_1
>> > org.qemu.Display1.Console HeadName s "First Monitor"
>>
>> That could be mapped to whatever interface we expose on the QEMU side,
>> it doesn't have to be qom-set.
>>
>
> It seems to me the main problem is that consoles are dynamically created
> by devices, and it's hard for the ui/display to map options to a specific
> console.
>
> The other issue is handling arrays with CLI in general...
>
> --
> Marc-Andr=C3=A9 Lureau
>

--000000000000bd02bf06258e6dc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel and Marc-Andr=C3=A9 - please excuse my delay (I =
was traveling<br>last week).<br><br>I see 2 primary takeaways here:<br><br>=
1. Updating the name field from the ServerInit RFB message to be<br>=C2=A0 =
=C2=A0controlled by the &#39;name&#39; VNC option<br><br>2. Updating where =
we store the display &#39;name&#39; in memory<br><br>For 1 - are we amenabl=
e to me updating this display name field to be<br>controlled by &#39;name&#=
39; in a future patch? I&#39;m still learning what the<br>QEMU community pr=
efers with respect to patch sizes, but in general I<br>have been trying to =
keep the patches small.<br><br>For 2 - have we landed on storing the per-di=
splay &#39;name&#39; in<br>DisplayOptions? I can&#39;t quite tell if we&#39=
;ve converged here. It also<br>seems like there is some more plumbing to in=
stall here before we<br>leverage DisplayOptions, so I am curious what the r=
ecommendation is<br>for this patch - is there a temporary solution we could=
 pursue and do<br>refactors later to unlock the CLI functionality that has =
been brought<br>up?<br><br>Correct me if I am wrong about any of this.<br><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Oct 22, 2024 at 4:36=E2=80=AFAM Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 22, 2024 at 12=
:10=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Tue, Oct 22, 2024 at 12:04:2=
9PM +0400, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Tue, Oct 22, 2024 at 11:54=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com=
</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Oct 21, 2024 at 03:14:39PM +0400, Marc-Andr=C3=A9 Lureau =
wrote:<br>
&gt; &gt; &gt; Hi Roque<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernan=
dez<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:roqueh@google.com" target=3D"_blank">r=
oqueh@google.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; From: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@go=
ogle.com" target=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extende=
d Display<br>
&gt; &gt; Identification<br>
&gt; &gt; &gt; &gt; Data) is propagated by QEMU such that a virtual display=
 presents<br>
&gt; &gt; legitimate<br>
&gt; &gt; &gt; &gt; metadata (e.g., name, serial number, preferred resoluti=
ons, etc.) to<br>
&gt; &gt; its<br>
&gt; &gt; &gt; &gt; connected guest.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This change propagates an optional user-provided displa=
y name to<br>
&gt; &gt; &gt; &gt; QemuConsole. Future changes will update downstream devi=
ces to leverage<br>
&gt; &gt; this<br>
&gt; &gt; &gt; &gt; display name for various uses, the primary one being pr=
oviding a<br>
&gt; &gt; custom EDID<br>
&gt; &gt; &gt; &gt; name to guests. Future changes will also update other d=
isplays (e.g.,<br>
&gt; &gt; spice)<br>
&gt; &gt; &gt; &gt; with a similar option to propagate a display name to do=
wnstream<br>
&gt; &gt; devices.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Currently, every virtio-gpu virtual display has the sam=
e name: &quot;QEMU<br>
&gt; &gt; &gt; &gt; Monitor&quot;. We hope to be able to inject the EDID na=
me of virtual<br>
&gt; &gt; displays in<br>
&gt; &gt; &gt; &gt; order to test guest behavior that is specific to displa=
y names. We<br>
&gt; &gt; provide the<br>
&gt; &gt; &gt; &gt; ability to inject the display name from the display con=
figuration as<br>
&gt; &gt; that most<br>
&gt; &gt; &gt; &gt; closely resembles how real displays work (hardware disp=
lays contain<br>
&gt; &gt; static EDID<br>
&gt; &gt; &gt; &gt; information that is provided to every connected host).<=
br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; It should also be noted that EDID names longer than 12 =
bytes will be<br>
&gt; &gt; truncated<br>
&gt; &gt; &gt; &gt; per spec (I think?).<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Andrew Keesler &lt;<a href=3D"mailto:ank=
eesler@google.com" target=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Roque Arcudia Hernandez &lt;<a href=3D"m=
ailto:roqueh@google.com" target=3D"_blank">roqueh@google.com</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 include/ui/console.h | 1 +<br>
&gt; &gt; &gt; &gt;=C2=A0 ui/console-priv.h=C2=A0 =C2=A0 | 1 +<br>
&gt; &gt; &gt; &gt;=C2=A0 ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8=
 ++++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 8 +++++++-<br>
&gt; &gt; &gt; &gt;=C2=A0 4 files changed, 17 insertions(+), 1 deletion(-)<=
br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/include/ui/console.h b/include/ui/console.=
h<br>
&gt; &gt; &gt; &gt; index 5832d52a8a..74ab03ed72 100644<br>
&gt; &gt; &gt; &gt; --- a/include/ui/console.h<br>
&gt; &gt; &gt; &gt; +++ b/include/ui/console.h<br>
&gt; &gt; &gt; &gt; @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuCons=
ole *con);<br>
&gt; &gt; &gt; &gt;=C2=A0 uint32_t qemu_console_get_head(QemuConsole *con);=
<br>
&gt; &gt; &gt; &gt;=C2=A0 int qemu_console_get_width(QemuConsole *con, int =
fallback);<br>
&gt; &gt; &gt; &gt;=C2=A0 int qemu_console_get_height(QemuConsole *con, int=
 fallback);<br>
&gt; &gt; &gt; &gt; +void qemu_console_set_name(QemuConsole *con, const cha=
r *name);<br>
&gt; &gt; &gt; &gt;=C2=A0 /* Return the low-level window id for the console=
 */<br>
&gt; &gt; &gt; &gt;=C2=A0 int qemu_console_get_window_id(QemuConsole *con);=
<br>
&gt; &gt; &gt; &gt;=C2=A0 /* Set the low-level window id for the console */=
<br>
&gt; &gt; &gt; &gt; diff --git a/ui/console-priv.h b/ui/console-priv.h<br>
&gt; &gt; &gt; &gt; index 43ceb8122f..9f2769843f 100644<br>
&gt; &gt; &gt; &gt; --- a/ui/console-priv.h<br>
&gt; &gt; &gt; &gt; +++ b/ui/console-priv.h<br>
&gt; &gt; &gt; &gt; @@ -18,6 +18,7 @@ struct QemuConsole {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 Object parent;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 int index;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 const char *name;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 DisplayState *ds;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 DisplayScanout scanout;<br>
&gt; &gt; &gt; &gt; diff --git a/ui/console.c b/ui/console.c<br>
&gt; &gt; &gt; &gt; index 5165f17125..f377fd8417 100644<br>
&gt; &gt; &gt; &gt; --- a/ui/console.c<br>
&gt; &gt; &gt; &gt; +++ b/ui/console.c<br>
&gt; &gt; &gt; &gt; @@ -1452,6 +1452,14 @@ int qemu_console_get_height(Qemu=
Console *con,<br>
&gt; &gt; int fallback)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +void qemu_console_set_name(QemuConsole *con, const cha=
r *name)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 con-&gt;name =3D name;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt;=C2=A0 int qemu_invalidate_text_consoles(void)<br>
&gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 QemuConsole *s;<br>
&gt; &gt; &gt; &gt; diff --git a/ui/vnc.c b/ui/vnc.c<br>
&gt; &gt; &gt; &gt; index 93a8dbd253..7d6acc5c2e 100644<br>
&gt; &gt; &gt; &gt; --- a/ui/vnc.c<br>
&gt; &gt; &gt; &gt; +++ b/ui/vnc.c<br>
&gt; &gt; &gt; &gt; @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts=
 =3D {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =
=3D &quot;power-control&quot;,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =
=3D QEMU_OPT_BOOL,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &q=
uot;name&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QE=
MU_OPT_STRING,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { /* end of list */ }=
<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt; &gt; &gt; @@ -4016,7 +4019,7 @@ void vnc_display_open(const char =
*id, Error<br>
&gt; &gt; **errp)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 QemuOpts *opts =3D qemu_opts_find(&=
amp;qemu_vnc_opts, id);<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(SocketAddressList) saddr_=
list =3D NULL;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(SocketAddressList) wsaddr=
_list =3D NULL;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 const char *share, *device_id;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 const char *share, *device_id, *name;<br=
>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 QemuConsole *con;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool password =3D false;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool reverse =3D false;<br>
&gt; &gt; &gt; &gt; @@ -4217,6 +4220,9 @@ void vnc_display_open(const char =
*id, Error<br>
&gt; &gt; **errp)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 qkbd_state_set_delay(vd-&gt;kbd, ke=
y_delay_ms);<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 name =3D qemu_opt_get(opts, &quot;name&q=
uot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_console_set_name(vd-&gt;dcl.con, na=
me);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Why not expose a &quot;head_name&quot; property in QemuGraph=
icConsole?<br>
&gt; &gt;<br>
&gt; &gt; QemuGraphicConsole isn&#39;t mapped to any CLI though, is it ?<br=
>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; No, it would be a bit tedious to do so with multi-head -devices.<br>
&gt; <br>
&gt; <br>
&gt; &gt; In QAPI we have DisplayOptions union=C2=A0 for all the local disp=
lays,<br>
&gt; &gt; and as a user I think I&#39;d expect &#39;name&#39; to be settabl=
e from<br>
&gt; &gt; those.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; DisplayOptions is meant for the UI display.. Here, the intent is reall=
y to<br>
&gt; set the HW EDID name field.<br>
<br>
But it is also applicable to the backend, all of which have a<br>
name for the display set in the window titlebar. We should<br>
be looking at both sides IMHO.<br></blockquote><div><br></div><div>Ok, if w=
e consider both should be treated similarly / reflect each other.</div><div=
>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Also DisplayOptions doesn&#39;t map to a specific console.<br>
<br>
It could be made to contain per-head information if we desired<br>
though, and would be more useful than just the name. There were<br>
some patches a while ago trying to express per-console placement<br>
of windows onto host monitor outputs, for example.<br></blockquote><div><br=
></div><div>[RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors</di=
v><div><a href=3D"https://patchew.org/QEMU/20240531185804.119557-1-dongwon.=
kim@intel.com/" target=3D"_blank">https://patchew.org/QEMU/20240531185804.1=
19557-1-dongwon.kim@intel.com/</a></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt; &gt; own CLI options we can expose.<br>
&gt; &gt;<br>
&gt; &gt; For runtime setting, we have a QMP=C2=A0 &quot;display-update&quo=
t; command, that<br>
&gt; &gt; currently just lets you change VNC listening address, but was int=
ended<br>
&gt; &gt; to allow for any runtime display changes.<br>
&gt; &gt;<br>
&gt; &gt; &gt; This way it should be possible to set the name with QMP qom-=
set.<br>
&gt; &gt;<br>
&gt; &gt; qom-set isn&#39;t a particularly nice interface, as things you ca=
n set<br>
&gt; &gt; from that are not introspectable and have no type information tha=
t<br>
&gt; &gt; can be queried.<br>
&gt; &gt;<br>
&gt; <br>
&gt; fwiw, it could be easily exposed to D-Bus, for ex:<br>
&gt; <br>
&gt; busctl --user set-property org.qemu /org/qemu/Display1/Console_1<br>
&gt; org.qemu.Display1.Console HeadName s &quot;First Monitor&quot;<br>
<br>
That could be mapped to whatever interface we expose on the QEMU side,<br>
it doesn&#39;t have to be qom-set.<br clear=3D"all"></blockquote><div><br><=
/div><div>It seems to me the main problem is that consoles are dynamically =
created by devices, and it&#39;s hard for the ui/display to map options to =
a specific console.</div><div><br></div><div>The other issue is handling ar=
rays with CLI in general...<br></div></div><br><span class=3D"gmail_signatu=
re_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-An=
dr=C3=A9 Lureau<br></div></div>
</div>
</blockquote></div>

--000000000000bd02bf06258e6dc7--

