Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D77C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 11:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHj3U-0003Cu-EB; Thu, 13 Jun 2024 07:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHj3S-0003Ax-1I
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 07:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHj3P-00017M-QI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 07:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718279742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWXVkCW/V2kwJO88u1DWd5e9K5+tXufBxajVi5PtrYE=;
 b=Vol0CKi0yUAj/IKHvq+eKcpLniAzRQAovdV9tiLWSvDzdMTNZ1V8W07JPk/uVOhE1ayl0C
 5LMLky6T/9nC0zpxV5SYTcxcIpaBAuwQ05WxDQ4XfhwJZJdgT7p9F66dG4/3dyvi1BpCws
 m3yh6ir/75dEhJqfli3i8mFTDVIWc3s=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-z-Gq7aEKMFSk5fliteNPBw-1; Thu, 13 Jun 2024 07:55:41 -0400
X-MC-Unique: z-Gq7aEKMFSk5fliteNPBw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-631278f3b19so9462987b3.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 04:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718279740; x=1718884540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWXVkCW/V2kwJO88u1DWd5e9K5+tXufBxajVi5PtrYE=;
 b=o/D7JgZwd7T7SSb//FFD16wV8qKrZGkNfEktVKcO9bWkm43FEb5fCkpA/CbQ/lOEt6
 s+13UQ7QnZkSAPJELzJ3ap+NHToZPpJnnBAIkNFBb5AbXD1LdDgkrmlEoaEWbydR4g7o
 PIjlL/uE+4LT9c0IN7hgXQ3a4TsSXDPjguWqUEIJwevCIS/0ZiT1NR05K7rCUuL8NyWU
 6L31+mtPLf08Bqv50tQsGkq8Fo03iNnYT2rmpbk3w2F/elLksXyIVsU2iq63zySb4Weq
 SYfjcIDxZ319iOGhiUssbZPhWfIRgXea4OlLejpGPR2X6TlaM/AheBG6Ux/IEM7qS2CG
 v9Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSteUS6QAujJVwGV/WvXKy6QE22vnHojcjYNFDg3PZXnWWEtKL3Nv33Z1GOjVFodwT76SJB4IPadyrsNoss23NPL0FM1o=
X-Gm-Message-State: AOJu0YzRa7g7K/unNvHinWKr27+4F8QHnClOh3l08T283+j1HUXtHH02
 7EXiZbJuzs3Ysc2L5XP0I20xqYBe8DWOMCFmYcbA6V5ZT+e/vVG6/C8nC3Dw7A/00CPZ7TN+ogc
 EL6sKBB9meYFu8d4BSrFXR1P5aVEG6MZu6QqDhNedVtiUqRTkvkiFmKssaROJGWUpzuFlXGJo9F
 AtdEyRJmMwUwNSlyXCs3V4WQ3yT8I=
X-Received: by 2002:a25:9344:0:b0:df7:8abd:8852 with SMTP id
 3f1490d57ef6-dfe68c0eaedmr4242517276.60.1718279740499; 
 Thu, 13 Jun 2024 04:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHptHPoW/3jAd5E0p1/L4kLlSanOl0700EQ5IWrazDQHJ2NIMMfqWxuVhClc8jaNRTNUXXlNlt4KqHW6F9G1BA=
X-Received: by 2002:a25:9344:0:b0:df7:8abd:8852 with SMTP id
 3f1490d57ef6-dfe68c0eaedmr4242502276.60.1718279740074; Thu, 13 Jun 2024
 04:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-9-berrange@redhat.com>
 <87ed93k2hy.fsf@pond.sub.org> <ZmrbUTQW7woprq1n@redhat.com>
In-Reply-To: <ZmrbUTQW7woprq1n@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 13 Jun 2024 14:55:29 +0300
Message-ID: <CAPMcbCoHF2p03hzhpO2o7k7_i53QAdUBfwqgBr32DjTd1A4O0A@mail.gmail.com>
Subject: Re: [PATCH 08/20] qga: conditionalize schema for commands unsupported
 on Windows
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000884415061ac42d83"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000884415061ac42d83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 2:43=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Jun 11, 2024 at 03:55:37PM +0200, Markus Armbruster wrote:
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >
> > > Rather than creating stubs for every command that just return
> > > QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> > > fully exclude generation of the commands on Windows.
> > >
> > > The command will be rejected at QMP dispatch time instead,
> > > avoiding reimplementing rejection by blocking the stub commands.
> > >
> > > This fixes inconsistency where some commands are implemented
> > > as stubs, yet not added to the blockedrpc list.
> > >
> > > This has the additional benefit that the QGA protocol reference
> > > now documents what conditions enable use of the command.
> > >
> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > ---
> > >  qga/commands-win32.c | 56 +-----------------------------------------=
--
> > >  qga/qapi-schema.json | 45 +++++++++++++++++++++++------------
> > >  2 files changed, 31 insertions(+), 70 deletions(-)
> > >
> > > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > > index 9fe670d5b4..2533e4c748 100644
> > > --- a/qga/commands-win32.c
> > > +++ b/qga/commands-win32.c
> >
> > [...]
> >
> > >  /* add unsupported commands to the list of blocked RPCs */
> > >  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
> > >  {
> > > -    const char *list_unsupported[] =3D {
> > > -        "guest-suspend-hybrid",
> > > -        "guest-set-vcpus",
> > > -        "guest-get-memory-blocks", "guest-set-memory-blocks",
> > > -        "guest-get-memory-block-info",
> > > -        NULL};
> > > -    char **p =3D (char **)list_unsupported;
> > > -
> > > -    while (*p) {
> > > -        blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> > > -    }
> > > -
> > >      if (!vss_init(true)) {
> > >          g_debug("vss_init failed, vss commands are going to be
> disabled");
> > >          const char *list[] =3D {
> > >              "guest-get-fsinfo", "guest-fsfreeze-status",
> > >              "guest-fsfreeze-freeze", "guest-fsfreeze-thaw", NULL};
> > > -        p =3D (char **)list;
> > > +        char **p =3D (char **)list;
> > >
> > >          while (*p) {
> > >              blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++=
));
> >            }
> >        }
> >
> >        return blockedrpcs;
> >    }
> >
> > Four commands get disabled when vss_init() fails, i.e. when qga-vss.dll
> > can't be loaded and initialized.
> >
> > Three of the four commands do this first:
> >
> >         if (!vss_initialized()) {
> >             error_setg(errp, QERR_UNSUPPORTED);
> >             return 0;
> >         }
> >
> > The execption is qmp_guest_get_fsinfo().
> >
> > vss_initialized() returns true between successful vss_init() and
> > vss_deinit().
> >
> > Aside: we call vss_init() in three places.  Two of them init, call
> > something, then deinit.  Weird.  Moving on.
>
> The two odd balls are a special case for the Windows only --service
> argument, which installs a Windows system service for VSS. In that
> case, the QGA immediately exits after (un)installing the service.
> So the vss_init+vss_deinit pairly makes sense there.
>
> > If these commands are meant to be only available when the DLL is, then
> > having them check vss_initialized() is useless.
>
> The DLL should always exist unless the install is broken, but versions
> of Windows prior to win2k3 don't support the required APIs, so vss_init
> could fail.
>

If Windows VSS is disabled vss_init could fail too. Also, one person
reported
an error that VSS failed to initialize after the first boot. I can't
reproduce this
so I have not details but we should check in runtime that QGA-VSS is
initialized
before trying to freeze fs, in case to be more sure where is error.


>
> > Conversely, if the check isn't useless, then the "make it available
> > only" business is.
>
> The 'make it available only" business is bad practice, as it does not
> allow a caller to distinguish between the admin manually disabling
> these commands, vs the commands being unavailable due to the OS not
> supporting the feature. This distinction  is important to preserve
> to benefit those triaging bugs about why this might fail.
>
> I'm going to get rid of the runtime blocking in
> ga_command_init_blockedrpcs,
> and also replace QERR_UNSUPPORTED with a more targetted error message to
> clearly articulate why the commands are failing.
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

--000000000000884415061ac42d83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 2:43=E2=80=AF=
PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Tue, Jun 11, 2024 at 03:55:37PM +0200, Markus Armbruster w=
rote:<br>
&gt; Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" tar=
get=3D"_blank">berrange@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; Rather than creating stubs for every command that just return<br>
&gt; &gt; QERR_UNSUPPORTED, use &#39;if&#39; conditions in the QAPI schema =
to<br>
&gt; &gt; fully exclude generation of the commands on Windows.<br>
&gt; &gt;<br>
&gt; &gt; The command will be rejected at QMP dispatch time instead,<br>
&gt; &gt; avoiding reimplementing rejection by blocking the stub commands.<=
br>
&gt; &gt;<br>
&gt; &gt; This fixes inconsistency where some commands are implemented<br>
&gt; &gt; as stubs, yet not added to the blockedrpc list.<br>
&gt; &gt;<br>
&gt; &gt; This has the additional benefit that the QGA protocol reference<b=
r>
&gt; &gt; now documents what conditions enable use of the command.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 qga/commands-win32.c | 56 +--------------------------------=
-----------<br>
&gt; &gt;=C2=A0 qga/qapi-schema.json | 45 +++++++++++++++++++++++----------=
--<br>
&gt; &gt;=C2=A0 2 files changed, 31 insertions(+), 70 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt; &gt; index 9fe670d5b4..2533e4c748 100644<br>
&gt; &gt; --- a/qga/commands-win32.c<br>
&gt; &gt; +++ b/qga/commands-win32.c<br>
&gt; <br>
&gt; [...]<br>
&gt; <br>
&gt; &gt;=C2=A0 /* add unsupported commands to the list of blocked RPCs */<=
br>
&gt; &gt;=C2=A0 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 const char *list_unsupported[] =3D {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-suspend-hybrid&quot;,<br=
>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-set-vcpus&quot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-blocks&quot;,=
 &quot;guest-set-memory-blocks&quot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-block-info&qu=
ot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL};<br>
&gt; &gt; -=C2=A0 =C2=A0 char **p =3D (char **)list_unsupported;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 while (*p) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 blockedrpcs =3D g_list_append(blocke=
drpcs, g_strdup(*p++));<br>
&gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!vss_init(true)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;vss_init failed, =
vss commands are going to be disabled&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *list[] =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-f=
sinfo&quot;, &quot;guest-fsfreeze-status&quot;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfre=
eze-freeze&quot;, &quot;guest-fsfreeze-thaw&quot;, NULL};<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D (char **)list;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **p =3D (char **)list;<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (*p) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blockedrpcs =3D g=
_list_append(blockedrpcs, g_strdup(*p++));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return blockedrpcs;<br>
&gt;=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; Four commands get disabled when vss_init() fails, i.e. when qga-vss.dl=
l<br>
&gt; can&#39;t be loaded and initialized.<br>
&gt; <br>
&gt; Three of the four commands do this first:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vss_initialized()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, QERR_U=
NSUPPORTED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; The execption is qmp_guest_get_fsinfo().<br>
&gt; <br>
&gt; vss_initialized() returns true between successful vss_init() and<br>
&gt; vss_deinit().<br>
&gt; <br>
&gt; Aside: we call vss_init() in three places.=C2=A0 Two of them init, cal=
l<br>
&gt; something, then deinit.=C2=A0 Weird.=C2=A0 Moving on.<br>
<br>
The two odd balls are a special case for the Windows only --service<br>
argument, which installs a Windows system service for VSS. In that<br>
case, the QGA immediately exits after (un)installing the service.<br>
So the vss_init+vss_deinit pairly makes sense there.<br>
<br>
&gt; If these commands are meant to be only available when the DLL is, then=
<br>
&gt; having them check vss_initialized() is useless.<br>
<br>
The DLL should always exist unless the install is broken, but versions<br>
of Windows prior to win2k3 don&#39;t support the required APIs, so vss_init=
<br>
could fail.<br></blockquote><div><br></div><div>If Windows VSS is disabled =
vss_init could fail too. Also, one person reported</div><div>an error that =
VSS failed to initialize after the first boot. I can&#39;t reproduce this</=
div><div>so I have not details but we should check in runtime that QGA-VSS =
is initialized</div><div>before trying to freeze fs, in case to be more sur=
e where is error.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt; Conversely, if the check isn&#39;t useless, then the &quot;make it ava=
ilable<br>
&gt; only&quot; business is.<br>
<br>
The &#39;make it available only&quot; business is bad practice, as it does =
not<br>
allow a caller to distinguish between the admin manually disabling<br>
these commands, vs the commands being unavailable due to the OS not<br>
supporting the feature. This distinction=C2=A0 is important to preserve<br>
to benefit those triaging bugs about why this might fail.<br>
<br>
I&#39;m going to get rid of the runtime blocking in ga_command_init_blocked=
rpcs,<br>
and also replace QERR_UNSUPPORTED with a more targetted error message to<br=
>
clearly articulate why the commands are failing.<br>
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

--000000000000884415061ac42d83--


