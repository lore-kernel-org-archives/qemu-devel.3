Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97585D1CDB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ANP-00018K-9U; Tue, 22 Oct 2024 04:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t3ANL-00017L-Te
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:36:25 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t3ANI-0001Le-KC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:36:23 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e290554afb4so5138416276.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729586179; x=1730190979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ct5h5sJ3+A+xGt9bh3WBS0emkAOPMzaGvt//muLyxCs=;
 b=J7KI1zFqFqL2PELc7b1OsGn4zIbVHtsTko4Qzj7w0wT3rgL9posshkbo1AlurS2crh
 t7hr6DviaWEXAckqc5IF2znKTItzJJEJhmAkvw8mVPlLWLedZnKkvQeZ6QuqMKKBa2jx
 ih63nkpQA2W8zs6PnX1QG5avJBs0yd257zVQsBn2FN09KCPO0eSd3wOtSucsxkx9ogje
 8KEyo0gylI0Q3rJih0rx8KYDrXxg8noOADykzh5SYNqygQNkMupZctD2JzmL451K3z0L
 Po9zLUZCTpEySJQjDq8Z7gDfIJcWNXsUvPiFIwipJgboTZ+v6UHYAa6cpOSlKaoqbNRS
 PuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586179; x=1730190979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ct5h5sJ3+A+xGt9bh3WBS0emkAOPMzaGvt//muLyxCs=;
 b=v7OM5GahT3LEsUlNlLfPfHdtDZOKrh7gW31EcBHoYYLnV1PbWdkYfwqANdsuNNzBES
 47yvWEi4yD4jfhaS5i230YcpqWPy9FeGC/1lnObqcOhLn8YHcoWLleJ9mr9xrR0qPUw5
 YSCte+KxqNsjhUHnic33iSn/DNeOMlyD1+JesK0OJSW3aCEMdwg2h9u0J7waOACNKojk
 J2+CRG6vrbwng+NTxnfnLZWfcQ9Zl5GJ6/rXXEtMdiRHEtKUCeWa4ospJwS1iyjnw67C
 a6KOHqnY5+rJiXWTCDVKJHX+T8oWqpKgkychAKZxfdkHOUoE21s+U91o4+vLNtDSlRBi
 6ZFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkhB/aA+MxT9MmiOa+dzKXaSmmn0K8lWqC7L79sSVi+KTs9V0Pgl97FEtDXr6mZQOOf0Bo6csfYXYb@nongnu.org
X-Gm-Message-State: AOJu0YzFOXO3EYMrYLyE63XOfyoR8t8At/f2z1OYrOVQ3z5XpxoRP34m
 Q73EdT0VIaqVElkptO/TWVC5yEPOs+18me+j2sBboeq5xT10CSZR2ox2Bhk41p8y+PAFSDuo9t5
 8+CxllnUO+/xGGOnHvCVofvWQch8=
X-Google-Smtp-Source: AGHT+IEqyYwaoQ7g9MxltztdqhGTkSJmUQ4BLttg7XMq2Djx0PJY4YAjwLhlN9zdtuRUR3R1aPQBk3dAV+9IbCza30s=
X-Received: by 2002:a05:6902:1244:b0:e2b:d075:5b4f with SMTP id
 3f1490d57ef6-e2e2715b7c2mr1523040276.3.1729586179354; Tue, 22 Oct 2024
 01:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
 <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
 <ZxdaAtp6QlpqRSDs@redhat.com>
 <CAJ+F1CL003+CBNQmnD_pwx+TyvNDR75GnL-j7o+dXzkHbxYOuw@mail.gmail.com>
 <Zxdd2UUtvSqBap9D@redhat.com>
In-Reply-To: <Zxdd2UUtvSqBap9D@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Oct 2024 12:36:07 +0400
Message-ID: <CAJ+F1CK2oRvsh=+NQKTfUgkbt9XOvn141wodH-w2Zrne7g=SpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, ankeesler@google.com,
 mst@redhat.com, qemu-devel@nongnu.org, venture@google.com
Content-Type: multipart/alternative; boundary="000000000000d4446f06250ca98a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb2e.google.com
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

--000000000000d4446f06250ca98a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Tue, Oct 22, 2024 at 12:04:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Oct 22, 2024 at 11:54=E2=80=AFAM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com
> >
> > wrote:
> >
> > > On Mon, Oct 21, 2024 at 03:14:39PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi Roque
> > > >
> > > > On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez
> > > > <roqueh@google.com> wrote:
> > > > >
> > > > > From: Andrew Keesler <ankeesler@google.com>
> > > > >
> > > > > Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
> > > Identification
> > > > > Data) is propagated by QEMU such that a virtual display presents
> > > legitimate
> > > > > metadata (e.g., name, serial number, preferred resolutions, etc.)
> to
> > > its
> > > > > connected guest.
> > > > >
> > > > > This change propagates an optional user-provided display name to
> > > > > QemuConsole. Future changes will update downstream devices to
> leverage
> > > this
> > > > > display name for various uses, the primary one being providing a
> > > custom EDID
> > > > > name to guests. Future changes will also update other displays
> (e.g.,
> > > spice)
> > > > > with a similar option to propagate a display name to downstream
> > > devices.
> > > > >
> > > > > Currently, every virtio-gpu virtual display has the same name:
> "QEMU
> > > > > Monitor". We hope to be able to inject the EDID name of virtual
> > > displays in
> > > > > order to test guest behavior that is specific to display names. W=
e
> > > provide the
> > > > > ability to inject the display name from the display configuration
> as
> > > that most
> > > > > closely resembles how real displays work (hardware displays conta=
in
> > > static EDID
> > > > > information that is provided to every connected host).
> > > > >
> > > > > It should also be noted that EDID names longer than 12 bytes will
> be
> > > truncated
> > > > > per spec (I think?).
> > > > >
> > > > > Signed-off-by: Andrew Keesler <ankeesler@google.com>
> > > > > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > > > > ---
> > > > >  include/ui/console.h | 1 +
> > > > >  ui/console-priv.h    | 1 +
> > > > >  ui/console.c         | 8 ++++++++
> > > > >  ui/vnc.c             | 8 +++++++-
> > > > >  4 files changed, 17 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/ui/console.h b/include/ui/console.h
> > > > > index 5832d52a8a..74ab03ed72 100644
> > > > > --- a/include/ui/console.h
> > > > > +++ b/include/ui/console.h
> > > > > @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
> > > > >  uint32_t qemu_console_get_head(QemuConsole *con);
> > > > >  int qemu_console_get_width(QemuConsole *con, int fallback);
> > > > >  int qemu_console_get_height(QemuConsole *con, int fallback);
> > > > > +void qemu_console_set_name(QemuConsole *con, const char *name);
> > > > >  /* Return the low-level window id for the console */
> > > > >  int qemu_console_get_window_id(QemuConsole *con);
> > > > >  /* Set the low-level window id for the console */
> > > > > diff --git a/ui/console-priv.h b/ui/console-priv.h
> > > > > index 43ceb8122f..9f2769843f 100644
> > > > > --- a/ui/console-priv.h
> > > > > +++ b/ui/console-priv.h
> > > > > @@ -18,6 +18,7 @@ struct QemuConsole {
> > > > >      Object parent;
> > > > >
> > > > >      int index;
> > > > > +    const char *name;
> > > > >      DisplayState *ds;
> > > > >      DisplaySurface *surface;
> > > > >      DisplayScanout scanout;
> > > > > diff --git a/ui/console.c b/ui/console.c
> > > > > index 5165f17125..f377fd8417 100644
> > > > > --- a/ui/console.c
> > > > > +++ b/ui/console.c
> > > > > @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole
> *con,
> > > int fallback)
> > > > >      }
> > > > >  }
> > > > >
> > > > > +void qemu_console_set_name(QemuConsole *con, const char *name)
> > > > > +{
> > > > > +    if (con =3D=3D NULL) {
> > > > > +        return;
> > > > > +    }
> > > > > +    con->name =3D name;
> > > > > +}
> > > > > +
> > > > >  int qemu_invalidate_text_consoles(void)
> > > > >  {
> > > > >      QemuConsole *s;
> > > > > diff --git a/ui/vnc.c b/ui/vnc.c
> > > > > index 93a8dbd253..7d6acc5c2e 100644
> > > > > --- a/ui/vnc.c
> > > > > +++ b/ui/vnc.c
> > > > > @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {
> > > > >          },{
> > > > >              .name =3D "power-control",
> > > > >              .type =3D QEMU_OPT_BOOL,
> > > > > +        },{
> > > > > +            .name =3D "name",
> > > > > +            .type =3D QEMU_OPT_STRING,
> > > > >          },
> > > > >          { /* end of list */ }
> > > > >      },
> > > > > @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error
> > > **errp)
> > > > >      QemuOpts *opts =3D qemu_opts_find(&qemu_vnc_opts, id);
> > > > >      g_autoptr(SocketAddressList) saddr_list =3D NULL;
> > > > >      g_autoptr(SocketAddressList) wsaddr_list =3D NULL;
> > > > > -    const char *share, *device_id;
> > > > > +    const char *share, *device_id, *name;
> > > > >      QemuConsole *con;
> > > > >      bool password =3D false;
> > > > >      bool reverse =3D false;
> > > > > @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error
> > > **errp)
> > > > >      }
> > > > >      qkbd_state_set_delay(vd->kbd, key_delay_ms);
> > > > >
> > > > > +    name =3D qemu_opt_get(opts, "name");
> > > > > +    qemu_console_set_name(vd->dcl.con, name);
> > > >
> > > > Why not expose a "head_name" property in QemuGraphicConsole?
> > >
> > > QemuGraphicConsole isn't mapped to any CLI though, is it ?
> > >
> > >
> > No, it would be a bit tedious to do so with multi-head -devices.
> >
> >
> > > In QAPI we have DisplayOptions union  for all the local displays,
> > > and as a user I think I'd expect 'name' to be settable from
> > > those.
> > >
> > >
> > DisplayOptions is meant for the UI display.. Here, the intent is really
> to
> > set the HW EDID name field.
>
> But it is also applicable to the backend, all of which have a
> name for the display set in the window titlebar. We should
> be looking at both sides IMHO.
>

Ok, if we consider both should be treated similarly / reflect each other.


>
> > Also DisplayOptions doesn't map to a specific console.
>
> It could be made to contain per-head information if we desired
> though, and would be more useful than just the name. There were
> some patches a while ago trying to express per-console placement
> of windows onto host monitor outputs, for example.
>

[RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
https://patchew.org/QEMU/20240531185804.119557-1-dongwon.kim@intel.com/

>
> > > own CLI options we can expose.
> > >
> > > For runtime setting, we have a QMP  "display-update" command, that
> > > currently just lets you change VNC listening address, but was intende=
d
> > > to allow for any runtime display changes.
> > >
> > > > This way it should be possible to set the name with QMP qom-set.
> > >
> > > qom-set isn't a particularly nice interface, as things you can set
> > > from that are not introspectable and have no type information that
> > > can be queried.
> > >
> >
> > fwiw, it could be easily exposed to D-Bus, for ex:
> >
> > busctl --user set-property org.qemu /org/qemu/Display1/Console_1
> > org.qemu.Display1.Console HeadName s "First Monitor"
>
> That could be mapped to whatever interface we expose on the QEMU side,
> it doesn't have to be qom-set.
>

It seems to me the main problem is that consoles are dynamically created by
devices, and it's hard for the ui/display to map options to a specific
console.

The other issue is handling arrays with CLI in general...

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d4446f06250ca98a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 22, 20=
24 at 12:10=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Oct 22, 2024 at=
 12:04:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:<br>
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
kim@intel.com/">https://patchew.org/QEMU/20240531185804.119557-1-dongwon.ki=
m@intel.com/</a></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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

--000000000000d4446f06250ca98a--

