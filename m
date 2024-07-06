Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D714C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQBWD-0000Pl-Q6; Sat, 06 Jul 2024 15:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sQBWB-0000PP-W5
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sQBWA-0000rw-8s
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720295781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiqRXPS5jruWf47z0jKHMOBGEx7vQ2JQUOMH2dok+r0=;
 b=bba3pL/E9NibvhHrc7d1b4Ah91HsqfGhbS0N/x2aHAt9a3Sibj2snYOU4D/TEyjXnJ2V/z
 AC7hCQOHt9AH6eXzYs70FPpIEMsCtj3FbR69wWwHKNuIjIkbu57SodXB8eaFjc7ZSmAWVR
 COcO50Vcys8Y6i0IbHr8SrEc1rMJhqw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Vki9hOsRMNSFmv4mPTw4HQ-1; Sat, 06 Jul 2024 15:56:17 -0400
X-MC-Unique: Vki9hOsRMNSFmv4mPTw4HQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c967a7aceeso2656614a91.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720295776; x=1720900576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RiqRXPS5jruWf47z0jKHMOBGEx7vQ2JQUOMH2dok+r0=;
 b=R645xGnTDPBl5m0004tbz2LBzHpzwcFcm7aQ41i2rY04hmIxEOcn5f6nKh4j1ao4bi
 yGyQNnWqolKllwU7nijg5O1sjbjXQWC6JLfu3gbJELp7AdQD9pA3JJOzL10H2LRKwdG8
 QawfNbbDqBOz7G4cSSs5x1aE369S2XN0Mkj+5gxFb7eZAHDRaAkP27GJTQQQUafgscm6
 4408jqUeVo0FLlESXJkd39PMRiM20y2oXtkWCK6yY0Ob19XJiEyRE8iogfVbEc/5QcLJ
 aG2ZMlOE554n4yk8Frc6wbQffjzZTff6QdGES8tpUc/QuX0vZcAXJzTsPHmGgEFuteWl
 kyaA==
X-Gm-Message-State: AOJu0YxzURjaI5K2S2QepTN18k8GqimXt2Ke2luyZGpup9c8UBd3wn99
 X+f7nKkUNgO1lPz+WEwl9Xp6mpgxME+aIaUexgMShyTfM639z9NNgTE1Wgm6ZFNR8n6fg8LhA1r
 fEhe1SXnwmIPjGdW1DwWQ+AmWITigA68KisAs/vv932uSIXia+qG2la+ZlCul7+M5aQR4LgI+ve
 ICtxLlzrKa8XmERsu3l5nqavaKoF8=
X-Received: by 2002:a17:90a:ba8f:b0:2c5:32c3:a777 with SMTP id
 98e67ed59e1d1-2c99c57fb63mr5738642a91.28.1720295776468; 
 Sat, 06 Jul 2024 12:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF2Bzp6w3FPM0GVsuNUs5n5G8Fa4Vf7GbL1f8XHDWvj1LSswaHmB/DmQ9/3VsB3y14LmgpLmuEqD/toCmgu20=
X-Received: by 2002:a17:90a:ba8f:b0:2c5:32c3:a777 with SMTP id
 98e67ed59e1d1-2c99c57fb63mr5738607a91.28.1720295776127; Sat, 06 Jul 2024
 12:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-6-jsnow@redhat.com>
 <87sewmtwdn.fsf@pond.sub.org>
In-Reply-To: <87sewmtwdn.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 6 Jul 2024 15:56:03 -0400
Message-ID: <CAFn=p-aeEYjCse3wiPEpwoXgm2R16U+MtZC83F=tkgy_wt8A1w@mail.gmail.com>
Subject: Re: [PATCH 5/8] qapi: convert "Example" sections without titles
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, 
 Alex Williamson <alex.williamson@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: multipart/alternative; boundary="000000000000a52c89061c999274"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--000000000000a52c89061c999274
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024, 10:42=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Use the no-option form of ".. qmp-example::" to convert any Examples
> > that do not have any form of caption or explanation whatsoever. Note
> > that in a few cases, example sections are split into two or more
> > separate example blocks. This is only done stylistically to create a
> > delineation between two or more logically independent examples.
> >
> > See commit-3: "docs/qapidoc: create qmp-example directive", for a
> >               detailed explanation of this custom directive syntax.
> >
> > See commit+3: "qapi: remove "Example" doc section" for a detailed
> >               explanation of why.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> > diff --git a/qapi/run-state.json b/qapi/run-state.json
> > index 252d7d6afa7..718a3c958e9 100644
> > --- a/qapi/run-state.json
> > +++ b/qapi/run-state.json
>
> [...]
>
> > @@ -453,7 +453,7 @@
> >  #
> >  # Since: 5.0
> >  #
> > -# Example:
> > +# .. qmp-example::
> >  #
> >  #     <- { "event": "GUEST_CRASHLOADED",
> >  #          "data": { "action": "run" },
>
> Trivial semantic conflict, we need
>

Caught on rebase late Fri, already fixed locally and will be in v2 (which I
rebased on top of my sphinx 3.x patches, which change the do_parse() stuff
too.)


>   @@ -469,7 +469,7 @@
>    #
>    # Since: 9.1
>    #
>   -# Example:
>   +# .. qmp-example::
>    #
>    #     <- { "event": "GUEST_PVSHUTDOWN",
>    #          "timestamp": { "seconds": 1648245259, "microseconds": 89377=
1
> } }
>
>
> > @@ -597,7 +597,7 @@
> >  #
> >  # Since: 5.2
> >  #
> > -# Example:
> > +# .. qmp-example::
> >  #
> >  #     <- { "event": "MEMORY_FAILURE",
> >  #          "data": { "recipient": "hypervisor",
>
> [...]
>
>

--000000000000a52c89061c999274
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sat, Jul 6, 2024, 10:42=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Use the no-option form of &quot;.. qmp-example::&quot; to convert any =
Examples<br>
&gt; that do not have any form of caption or explanation whatsoever. Note<b=
r>
&gt; that in a few cases, example sections are split into two or more<br>
&gt; separate example blocks. This is only done stylistically to create a<b=
r>
&gt; delineation between two or more logically independent examples.<br>
&gt;<br>
&gt; See commit-3: &quot;docs/qapidoc: create qmp-example directive&quot;, =
for a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0detailed explana=
tion of this custom directive syntax.<br>
&gt;<br>
&gt; See commit+3: &quot;qapi: remove &quot;Example&quot; doc section&quot;=
 for a detailed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0explanation of w=
hy.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/run-state.json b/qapi/run-state.json<br>
&gt; index 252d7d6afa7..718a3c958e9 100644<br>
&gt; --- a/qapi/run-state.json<br>
&gt; +++ b/qapi/run-state.json<br>
<br>
[...]<br>
<br>
&gt; @@ -453,7 +453,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 5.0<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;event&quot;: &quot;GUEST_CRAS=
HLOADED&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;data&quot;: { &quot;ac=
tion&quot;: &quot;run&quot; },<br>
<br>
Trivial semantic conflict, we need<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Caught on rebase late Fri, already fixed =
locally and will be in v2 (which I rebased on top of my sphinx 3.x patches,=
 which change the do_parse() stuff too.)</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 @@ -469,7 +469,7 @@<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# Since: 9.1<br>
=C2=A0 =C2=A0#<br>
=C2=A0 -# Example:<br>
=C2=A0 +# .. qmp-example::<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;event&quot;: &quot;GUEST_PV=
SHUTDOWN&quot;,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;timestamp&quot;: { &=
quot;seconds&quot;: 1648245259, &quot;microseconds&quot;: 893771 } }<br>
<br>
<br>
&gt; @@ -597,7 +597,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 5.2<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;event&quot;: &quot;MEMORY_FAI=
LURE&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;data&quot;: { &quot;re=
cipient&quot;: &quot;hypervisor&quot;,<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000a52c89061c999274--


