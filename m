Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A3CE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 11:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKc8L-0007aW-5b; Mon, 09 Dec 2024 06:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tKc8K-0007aN-3h
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:41:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tKc8D-0007st-DT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733744450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2BWwQrYlP+p45J8R384UptfX8JwRxIERNGuo2GWQX4=;
 b=Ogpoc8PQcywILFxXtagYMZ5TjG7JfvRpmbI1vEif3pNXOAnlY6R1qD/B/KJ0hzfGXFH2xb
 GSC/ulzL56tUKVVZiXy3pmCMeuhyiNi9VIO/BvSf9Aouv1DwOHIseYjCIkEitJdnr25Nqb
 hDbTdH6eqe7c7D07teL3jyDWShhqXMY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-qGDCJ2CQOYyTnTElSxuGjQ-1; Mon, 09 Dec 2024 06:40:49 -0500
X-MC-Unique: qGDCJ2CQOYyTnTElSxuGjQ-1
X-Mimecast-MFC-AGG-ID: qGDCJ2CQOYyTnTElSxuGjQ
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8897ea603so79656076d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 03:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733744449; x=1734349249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q2BWwQrYlP+p45J8R384UptfX8JwRxIERNGuo2GWQX4=;
 b=ooGR/gW4CT1jEw37hkx4uyFlpC5kpHzdXS63XD4CTLHYLuSeIimwAnxVyvtP6Pz8yB
 tRHSylE220Q1XdEdks3uVImQnX9AgfFp1MjFO8R11+VHLDU3rBfdhcfVFarMWx5gSWgx
 NfonmJtMfllfMcbELocmXkmvduY1ebvG4p7iKIKZGVonYIAfdszSiOrpvRsPnihFyPa6
 eF6tK7ES7T3ICxf/nw78JGs3+bNcI/yGLXwSTYoE5S+hukkyG4FT5d1BQHqRsAHD1DGY
 sM2aljqpg0Vo4pLUiqNiM3bGtpmeEFJTYwXP8s2+U1uVy539BK+zhQdUt/stDcIvNpxM
 9EnQ==
X-Gm-Message-State: AOJu0YwCCo2O7JquljS3TsDnebUEOuddm8OKdM+gG+U3nSftrcWyhKYa
 6xWpT9qXntSd1B0jtKGk6GLcCho1Cq6kxtYsYPkRrrNgDP+J3Q6e3CuMaC4lPLBo2PpeSC12aKo
 k9JCgCQA2jaHUYbBL6XIghMprQTCyJaCg090iFuOafNb+QpCvHu+cCqFyclK32ZofNkP5D7nxLN
 M1wdKHmGqQ9aM07rgGkVfaL1pwXH8=
X-Gm-Gg: ASbGncs4BFj5w/pgE8svJZreSNclB/q5J5rKqh+tjZmZhdwT1tJKZcYmAebUcvQSpvC
 ZlVPMMI3+9HWo0u4EzgPonn1FK/Jdi/bkjQ==
X-Received: by 2002:a05:6214:300c:b0:6d9:87d:66f4 with SMTP id
 6a1803df08f44-6d9087d693amr82232736d6.8.1733744448696; 
 Mon, 09 Dec 2024 03:40:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBsBVlm1uI7tfA9OrRqMFpLfCFA/K6i9Ca/xIFCO0fAMr9d2EKeKjyEITXGzl9psFrwM7VvLU3RYg6m0EaJ48=
X-Received: by 2002:a05:6214:300c:b0:6d9:87d:66f4 with SMTP id
 6a1803df08f44-6d9087d693amr82232476d6.8.1733744448407; Mon, 09 Dec 2024
 03:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20241209111817.31307-1-kkostiuk@redhat.com>
 <Z1bU5g4jnppsi4Xf@redhat.com>
In-Reply-To: <Z1bU5g4jnppsi4Xf@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 9 Dec 2024 13:40:37 +0200
Message-ID: <CAPMcbCqKRftWUitBpgq1bzDcNV8GCPPxMJahL0ozf11D=qgHDA@mail.gmail.com>
Subject: Re: [PATCH] qga: Add log to guest-fsfreeze-thaw command
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000faa5710628d4d52e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000faa5710628d4d52e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Best Regards,
Konstantin Kostiuk.


On Mon, Dec 9, 2024 at 1:30=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Mon, Dec 09, 2024 at 01:18:17PM +0200, Konstantin Kostiuk wrote:
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > ---
> >  qga/commands-posix.c | 3 +++
> >  qga/commands-win32.c | 2 ++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 636307bedf..ac8d150582 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -805,6 +805,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
> >      int ret;
> >
> >      ret =3D qmp_guest_fsfreeze_do_thaw(errp);
> > +
> > +    slog("guest-fsthaw called");
>
> If ret < 0, then thawing failed and surely it is potentially
> unsafe to log ?
>
>
Potentially yes, but we have similar in guest_fsfreeze_cleanup.
We print the log when qmp_guest_fsfreeze_thaw fails.


> > +
> >      if (ret >=3D 0) {
> >          ga_unset_frozen(ga_state);
> >          execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 038beb8cfa..3a6f3ac7c5 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -1272,6 +1272,8 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
> >
> >      qga_vss_fsfreeze(&i, false, NULL, errp);
> >
> > +    slog("guest-fsthaw called");
> > +
> >      ga_unset_frozen(ga_state);
> >      return i;
> >  }
> > --
> > 2.47.1
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000faa5710628d4d52e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</di=
v><div>Konstantin Kostiuk.</div></div></div></div><br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, Dec 9, 2024 at 1:30=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a hre=
f=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Dec 09, 2024 at=
 01:18:17PM +0200, Konstantin Kostiuk wrote:<br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-posix.c | 3 +++<br>
&gt;=C2=A0 qga/commands-win32.c | 2 ++<br>
&gt;=C2=A0 2 files changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
&gt; index 636307bedf..ac8d150582 100644<br>
&gt; --- a/qga/commands-posix.c<br>
&gt; +++ b/qga/commands-posix.c<br>
&gt; @@ -805,6 +805,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D qmp_guest_fsfreeze_do_thaw(errp);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 slog(&quot;guest-fsthaw called&quot;);<br>
<br>
If ret &lt; 0, then thawing failed and surely it is potentially<br>
unsafe to log ?<br>
<br></blockquote><div><br></div><div>Potentially yes, but we have similar i=
n guest_fsfreeze_cleanup. <br></div><div>We print the log when qmp_guest_fs=
freeze_thaw fails. <br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &gt;=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_unset_frozen(ga_state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execute_fsfreeze_hook(FSFREEZE_HOOK_=
THAW, errp);<br>
&gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt; index 038beb8cfa..3a6f3ac7c5 100644<br>
&gt; --- a/qga/commands-win32.c<br>
&gt; +++ b/qga/commands-win32.c<br>
&gt; @@ -1272,6 +1272,8 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br=
>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qga_vss_fsfreeze(&amp;i, false, NULL, errp);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 slog(&quot;guest-fsthaw called&quot;);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ga_unset_frozen(ga_state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return i;<br>
&gt;=C2=A0 }<br>
&gt; -- <br>
&gt; 2.47.1<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--000000000000faa5710628d4d52e--


