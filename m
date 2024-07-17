Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD0FC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4Sy-00049X-Jb; Wed, 17 Jul 2024 09:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sU4Su-0003z5-Nj
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sU4Ss-0004KT-0l
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721221979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZzB8lFug4oZknnn8pZAMzfSqdEwBUkNVttBYnRnrJ8=;
 b=AebQGyY0qsm2Il+4CvIPL2MqURddyJuz6vthprtR2FJEMTJ8WwIAURriFEtS7vzUuLObr+
 U6Txi9LyBBAGYqUe4BDQl+sQUib62dtVoFUASKoy/JWhwlggc3hYwsXXBcXenpx/63jUl2
 fr8hWXGSTq4+k49RsaXmQTlYcWHWtTs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0GoYXuSrOOquWbr084awug-1; Wed, 17 Jul 2024 09:12:57 -0400
X-MC-Unique: 0GoYXuSrOOquWbr084awug-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e035949cc4eso13000017276.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721221977; x=1721826777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LZzB8lFug4oZknnn8pZAMzfSqdEwBUkNVttBYnRnrJ8=;
 b=H/5yW65U49GcKYyF6Se9ekCxy0EEvnmMK78H6qidNUy53j5UhfJyHIizEEUS85xr2d
 RlJQ41WUz0fikUTNY9QF+pZS4mltNFCYhJ9l7ggUDhKetkPIRHU+TNuSLUByGT0CI8Z/
 aFlKJNyZ1Si8qw34K7eeKLufE888gsFVFUQAgDUClAELCW+Lq7qHoMu0csTcUnFZY+n5
 8sbqXdKt4JIvaqfwlUJ/rhCp4hPUnU5XQG6T5FvakRkinsLbvwaM9vWABmUKf6w9ZZaU
 30SDrDo/0WRwt+qvfU6FNmoroai61jt4cRBqdFdm38YLFetlEilsna19Ia2gcxFiPulw
 Or8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUV3UCXmqt53u8R4DMe2A006uFQ1Mg7ff/iNHj9RY5+4/EVdr9sNXP9fn3sOKpa/KBQYudJ6V+R45dn33rKeQTZIcm9QU=
X-Gm-Message-State: AOJu0Yz1wWtRaQzBqZYkz7eKs27LqXoS4nnXl7eAsSB5IL+w5q7IAHrG
 A3B1HPRDB3dPeMa6+uOotggenP2krA2Fw4qOxXouVoIdimLm/EL5UC6dgG/bPNeyAKYJ9uNV2hT
 J0wPiR+5YsJohu0dQ5NBcgRrg9/gz8i2KEJ58PXTpYAZFbPVz5lMUJQY4xA4l3xR9ONUEEflB1X
 2yopDP6pyDAh08sPeAGZ1W3kX3lpc=
X-Received: by 2002:a05:6902:a07:b0:e03:af3d:d4d1 with SMTP id
 3f1490d57ef6-e05ed797f7emr1947512276.54.1721221977101; 
 Wed, 17 Jul 2024 06:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD/mK5uHhaA1/BrrxOygaAOc3vS0jUN8ihkdZqBtyYLy23xwC473+JJaeo5ZlYib4+4OgyI6OU4mA72BAbtPo=
X-Received: by 2002:a05:6902:a07:b0:e03:af3d:d4d1 with SMTP id
 3f1490d57ef6-e05ed797f7emr1947493276.54.1721221976757; Wed, 17 Jul 2024
 06:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240716162351.270095-1-zhao1.liu@intel.com>
 <a6d1f8a4-5c1f-4dcf-b0dc-c1a019e8ba78@linaro.org>
In-Reply-To: <a6d1f8a4-5c1f-4dcf-b0dc-c1a019e8ba78@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 17 Jul 2024 16:12:45 +0300
Message-ID: <CAPMcbCpHQj8qjYhEKHg=jPkUzEqph3NOws=rm2M1kVgsqk0Qug@mail.gmail.com>
Subject: Re: [PATCH v2] qga/commands-posix: Make ga_wait_child() return boolean
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000081326c061d7138f0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000081326c061d7138f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

Hi Philippe,

I plan to merge this with "Add new api 'guest-network-get-route'"
https://patchwork.kernel.org/project/qemu-devel/cover/20240613092802.346246=
-1-demeng@redhat.com/
Can I ask you to review the new GuestNetworkRoute struct with IPv6 support?


On Wed, Jul 17, 2024 at 1:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Konstantin,
>
> If there are no other patches on your guest-agent queue,
> I can take this patch in my next pull request.
>
> Regards,
>
> Phil.
>
> On 16/7/24 18:23, Zhao Liu wrote:
> > Make ga_wait_child() return boolean and check the returned boolean
> > in ga_run_command() instead of dereferencing @errp.
> >
> > Cc: Michael Roth <michael.roth@amd.com>
> > Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > v2:
> >   * Added Phil's r/b.
> >   * Used Phil's polished words.
> > ---
> >   qga/commands-posix.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 7f05996495a2..64bb0be94479 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -59,7 +59,7 @@
> >   #endif
> >   #endif
> >
> > -static void ga_wait_child(pid_t pid, int *status, Error **errp)
> > +static bool ga_wait_child(pid_t pid, int *status, Error **errp)
> >   {
> >       pid_t rpid;
> >
> > @@ -70,10 +70,11 @@ static void ga_wait_child(pid_t pid, int *status,
> Error **errp)
> >       if (rpid =3D=3D -1) {
> >           error_setg_errno(errp, errno, "failed to wait for child (pid:
> %d)",
> >                            pid);
> > -        return;
> > +        return false;
> >       }
> >
> >       g_assert(rpid =3D=3D pid);
> > +    return true;
> >   }
> >
> >   static ssize_t ga_pipe_read_str(int fd[2], char **str)
> > @@ -178,8 +179,7 @@ static int ga_run_command(const char *argv[], const
> char *in_str,
> >           goto out;
> >       }
> >
> > -    ga_wait_child(pid, &status, errp);
> > -    if (*errp) {
> > +    if (!ga_wait_child(pid, &status, errp)) {
> >           goto out;
> >       }
> >
>
>

--00000000000081326c061d7138f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><br></div><div dir=3D"ltr">Hi Philippe,</div><div dir=3D"ltr"><=
br></div><div>I plan to merge this with &quot;Add new api &#39;guest-networ=
k-get-route&#39;&quot;</div><div><a href=3D"https://patchwork.kernel.org/pr=
oject/qemu-devel/cover/20240613092802.346246-1-demeng@redhat.com/">https://=
patchwork.kernel.org/project/qemu-devel/cover/20240613092802.346246-1-demen=
g@redhat.com/</a></div><div>Can I ask you to review the new GuestNetworkRou=
te struct with IPv6 support? <br></div></div></div><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 17, 2024=
 at 1:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Konstantin,<br>
<br>
If there are no other patches on your guest-agent queue,<br>
I can take this patch in my next pull request.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
On 16/7/24 18:23, Zhao Liu wrote:<br>
&gt; Make ga_wait_child() return boolean and check the returned boolean<br>
&gt; in ga_run_command() instead of dereferencing @errp.<br>
&gt; <br>
&gt; Cc: Michael Roth &lt;<a href=3D"mailto:michael.roth@amd.com" target=3D=
"_blank">michael.roth@amd.com</a>&gt;<br>
&gt; Cc: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" targ=
et=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com" tar=
get=3D"_blank">zhao1.liu@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; v2:<br>
&gt;=C2=A0 =C2=A0* Added Phil&#39;s r/b.<br>
&gt;=C2=A0 =C2=A0* Used Phil&#39;s polished words.<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qga/commands-posix.c | 8 ++++----<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
&gt; index 7f05996495a2..64bb0be94479 100644<br>
&gt; --- a/qga/commands-posix.c<br>
&gt; +++ b/qga/commands-posix.c<br>
&gt; @@ -59,7 +59,7 @@<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static void ga_wait_child(pid_t pid, int *status, Error **errp)<br>
&gt; +static bool ga_wait_child(pid_t pid, int *status, Error **errp)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pid_t rpid;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -70,10 +70,11 @@ static void ga_wait_child(pid_t pid, int *status, =
Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rpid =3D=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errno, =
&quot;failed to wait for child (pid: %d)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert(rpid =3D=3D pid);<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static ssize_t ga_pipe_read_str(int fd[2], char **str)<br>
&gt; @@ -178,8 +179,7 @@ static int ga_run_command(const char *argv[], cons=
t char *in_str,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 ga_wait_child(pid, &amp;status, errp);<br>
&gt; -=C2=A0 =C2=A0 if (*errp) {<br>
&gt; +=C2=A0 =C2=A0 if (!ga_wait_child(pid, &amp;status, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--00000000000081326c061d7138f0--


