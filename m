Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCFFC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 17:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGXu-00074J-Gy; Mon, 17 Jun 2024 13:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJGXs-00073y-Ur
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJGXr-0002iB-Bi
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718646810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jgAnQ2VGTD1LEJPqihlP2fJyDfTq50PNDO45zT7E3SI=;
 b=WCRQ/NLMbv9zI8dwOczsnI4642vHYIZiW4TJoZJffcFbqo0z9VXaQLQaCRrm0JKUWll0WH
 9ALYwETYt3lvbJBZKr9t7tgmGUCYt9Hcs2Wmsr6bLYFyoajIGt3HAxPDq3eALIA+k1aqS5
 ZUwYHyRZMe5WVYbtv/YPD1E41b0ovuM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-u_uHgJHFOiyYPcwz7OHA-g-1; Mon, 17 Jun 2024 13:53:09 -0400
X-MC-Unique: u_uHgJHFOiyYPcwz7OHA-g-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c1e953176cso4814607a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 10:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718646789; x=1719251589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jgAnQ2VGTD1LEJPqihlP2fJyDfTq50PNDO45zT7E3SI=;
 b=NvIYeRFKMJo7M4uYzGyRy32E5pJs0iGhXP7ea/Mx7VQZqHTeUj9Rifr0bDyR+rvIzM
 jIyhILeKr36D2R6s4d5J8yTnO6XXDTblgjB9AoVTFJQ9FCrNvjNNeOWxeA5aEMItsP9Z
 ZFqeSI1yvW96PFJlRHboNKIwBgh/nPZJaeAE50XvRNFltmOSikJd0/geRGfW5xg68Him
 YgiRRE6t15rNkzey10MBrioBc7OHM7t2WMHLgHBrc+65QmNtXCetBHEmLHWDW7Y9HHBJ
 AuZbkVHr6oTI7mR4q1d6Q+UJq9hLbmzic6X5oVtyvtwwekiy3DHZf2R87Edeloaho6mN
 qWoQ==
X-Gm-Message-State: AOJu0Yxr5V2tcL6awMTWYVFJjJYXJvb8Wv4qBXxjEd76d/5PBX8jQCFR
 nyYMRf2qRIUClhCLe9Rl3MwAnuNP/TPDSt8Knvb6LgfdEhH46H0Kc0pqXC3A+uzW/6QDt9LvNXw
 oddyC30YiKTIFyB+P0nAZXnV8L+yqKnKiDdpjKAd31z3MdgCM+tNjCyUXujhz9YwCXTjgeh5PO0
 cg2t3C9zx9QkFA2uBi30NLFVH0gGI=
X-Received: by 2002:a17:90a:4418:b0:2c3:514:e0 with SMTP id
 98e67ed59e1d1-2c4dbb43cecmr9913103a91.35.1718646788837; 
 Mon, 17 Jun 2024 10:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOK8Jeduf3tuvUHFs93npeTMkeTP9+cyI/Em3HnJpG4y6mfRJ0rFU85BnhBRPIvfsiU5AZ1EokOQ/muPV7tFA=
X-Received: by 2002:a17:90a:4418:b0:2c3:514:e0 with SMTP id
 98e67ed59e1d1-2c4dbb43cecmr9913084a91.35.1718646788495; Mon, 17 Jun 2024
 10:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-15-jsnow@redhat.com>
 <87frtf3iad.fsf@pond.sub.org>
In-Reply-To: <87frtf3iad.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 13:52:56 -0400
Message-ID: <CAFn=p-YKEnSW=EOqJGz=vne7FCh-4xth4eGtCKrp2ywEzdVTtQ@mail.gmail.com>
Subject: Re: [PATCH 14/20] qapi: fix non-compliant JSON examples
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Mads Ynddal <mads@ynddal.dk>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000052bcbf061b19a316"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--00000000000052bcbf061b19a316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024, 6:55=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > If we parse all examples as QMP, we need them to conform to a standard
> > so that they render correctly. Once the QMP lexer is active for
> > examples, these will produce warning messages and fail the build.
> >
> > The QMP lexer still supports elisions, but they must be represented as
> > the value "...", so two examples have been adjusted to support that
> > format here.
>
> I think this could use a bit more context.  I believe you're referring
> to docs/sphinx/qmp_lexer.py.  It describes itself as "a Sphinx extension
> that provides a QMP lexer for code blocks."
>

That's our guy! I explain its use a bit more in ... some other patch,
somewhere...


> "If we parse all examples as QMP" and "Once the QMP lexer is active for
> examples" suggests we're *not* using it for (some?) examples.  So what
> are we using it for?
>

My incremental backup doc makes use of it; you have to "opt in" to using
the QMP lexer instead of the generic lexer.

The example conversion patch later in this series opts all of the qapi docs
into using it.

((Later, it's possible to make "Example::" choose the QMP lexer by default
on any of our generated QMP pages. (and opting out would require explicit
code-block syntax with the lexer of choice named.)))


> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Patch looks lovely.
>
> Hat tip to Victor Toso, who fixed up most examples two years ago.  Back
> then we couldn't decide how to do elisions, so we left some unfixed.
>

Sorry I didn't chime in back then! "..." is arbitrary, but it's what we
already use for the qmp lexer and in the incremental backup/bitmap docs, so
I figured consistency was good.

The QMP lexer has syntax support for ->, <- and ... and otherwise requires
the examples to be valid JSON. It doesn't understand grammar, though, so
it's kind of "dumb", but this is one small protection.

>

--00000000000052bcbf061b19a316
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 14, 2024, 6:55=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"norefer=
rer">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; If we parse all examples as QMP, we need them to conform to a standard=
<br>
&gt; so that they render correctly. Once the QMP lexer is active for<br>
&gt; examples, these will produce warning messages and fail the build.<br>
&gt;<br>
&gt; The QMP lexer still supports elisions, but they must be represented as=
<br>
&gt; the value &quot;...&quot;, so two examples have been adjusted to suppo=
rt that<br>
&gt; format here.<br>
<br>
I think this could use a bit more context.=C2=A0 I believe you&#39;re refer=
ring<br>
to docs/sphinx/qmp_lexer.py.=C2=A0 It describes itself as &quot;a Sphinx ex=
tension<br>
that provides a QMP lexer for code blocks.&quot;<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">That&#39;s our guy! I expla=
in its use a bit more in ... some other patch, somewhere...</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&quot;If we parse all examples as QMP&quot; and &quot;Once the QMP lexer is=
 active for<br>
examples&quot; suggests we&#39;re *not* using it for (some?) examples.=C2=
=A0 So what<br>
are we using it for?<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">My incremental backup doc makes use of it; you have to =
&quot;opt in&quot; to using the QMP lexer instead of the generic lexer.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">The example conversion patc=
h later in this series opts all of the qapi docs into using it.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">((Later, it&#39;s possible to make =
&quot;Example::&quot; choose the QMP lexer by default on any of our generat=
ed QMP pages. (and opting out would require explicit code-block syntax with=
 the lexer of choice named.)))</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Patch looks lovely.<br>
<br>
Hat tip to Victor Toso, who fixed up most examples two years ago.=C2=A0 Bac=
k<br>
then we couldn&#39;t decide how to do elisions, so we left some unfixed.<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sor=
ry I didn&#39;t chime in back then! &quot;...&quot; is arbitrary, but it&#3=
9;s what we already use for the qmp lexer and in the incremental backup/bit=
map docs, so I figured consistency was good.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">The QMP lexer has syntax support for -&gt;, &lt;- and =
... and otherwise requires the examples to be valid JSON. It doesn&#39;t un=
derstand grammar, though, so it&#39;s kind of &quot;dumb&quot;, but this is=
 one small protection.</div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000052bcbf061b19a316--


