Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC963C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 19:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scVGQ-0002fG-K4; Fri, 09 Aug 2024 15:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scVGP-0002ek-Tp
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 15:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scVGN-0000qD-Cw
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 15:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723231617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FOhpNu8illGrk/nr5gQdx9CKgvOvNo7RRuSN8ezsyBo=;
 b=bs4l7xg619H1R56d+RNScpUjIX0OOtbVLdfWFR6pAbCLtTANo3nWCrSq4Q1W+EFLx5JrG1
 Jca1lFbv4eC4SVWLbPkgDvav6bs0EZxKO7ktwW8ISOW88llq426i23EMcLS2yoznz0jaQe
 6RjuRxQbF3p1bCnMBn3+IM0VkqETrTY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-bVEuLl7EOKi77hmlufVWZQ-1; Fri, 09 Aug 2024 15:26:56 -0400
X-MC-Unique: bVEuLl7EOKi77hmlufVWZQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2cb6c5f9810so2865323a91.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 12:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723231615; x=1723836415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOhpNu8illGrk/nr5gQdx9CKgvOvNo7RRuSN8ezsyBo=;
 b=RYIjnLd+LmUcSTgIKE6fryF4MLwqy55NBfL8YrHgTC853FDDvaAtpRBAGPuM/vvAZh
 AL1T+dw0tf4H2rkucEYKrG9KU5N/30+IuhzgldQn3zUrqYJeHR05EXfJkxjYD5+L0JZq
 +LDk5KA4qol3a6FNu5M/vRjj0sqwTqaqnNZM6HeD+vGPCYepC6dTz+Qa1J/MM9EJ6nF8
 nVzoVfC9PZswrK5hkVtKP0zpcFwZ48q0Kc9IcFS//k3Hfe1WiQcEjF4vE4McJ9Vic0CL
 lsrBfQmhx6j4VHuhfWt8YBVAS5UprMY1L00LsB0nGRQv5NPxixu2r/AIyJtSBuqWzU3b
 mtrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlWWZK25g0UKw8ZMA5RWWqTDqxhupb3KVeMeS/KQn+jOE0rZ52S6HLgqeBYN/3Ijvl2nlV4YKf2qVcWK+RJftW23AZi9w=
X-Gm-Message-State: AOJu0Yx4tuu1c7oA53QosBMWsBVMRiCFVv00y9jWMtszaKOjo2DBbvNf
 blLx2RUbC+36Dl44wA/EhECdb0DDmwDh6vttNWp02QxkgtpHhkMnL+2/lCWJVBxfNTJeSXYrz5G
 TjDmY08NYWKf11dche3C+cM4l2y8Y+ze6rcRl5/1DOR4eldoGraHkLwbmHJoWeWBYu5b5PmIP07
 sfQ+T2ptPGQEu2uCrBROhUDuReZnA=
X-Received: by 2002:a17:90a:1697:b0:2cd:4b37:a96a with SMTP id
 98e67ed59e1d1-2d1e7fc46c8mr2987068a91.14.1723231614776; 
 Fri, 09 Aug 2024 12:26:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOStyZYXFXsFo9yZ+rSIB6TlL0Awbbttt31hAX+ziO9zURr4oK/85AZJsgtGnmXMkr4z1dvpqVEzybwXhjzF8=
X-Received: by 2002:a17:90a:1697:b0:2cd:4b37:a96a with SMTP id
 98e67ed59e1d1-2d1e7fc46c8mr2987031a91.14.1723231614239; Fri, 09 Aug 2024
 12:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
 <CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
 <20240809004137.01f97da2@foz.lan>
 <CAFn=p-ZM8cgKvUx+5v7YU6TaPZySJL1QnHqjmN5rQpF=D_V=8Q@mail.gmail.com>
 <20240809102409.136837ec@foz.lan>
In-Reply-To: <20240809102409.136837ec@foz.lan>
From: John Snow <jsnow@redhat.com>
Date: Fri, 9 Aug 2024 15:26:41 -0400
Message-ID: <CAFn=p-as6hvPsYp+c7bDROHWeM096uP=+yBBAbrLu_MgNZ2WNw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate GHES
 error inject
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, 
 Cleber Rosa <crosa@redhat.com>, linux-kernel@vger.kernel.org, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000003b99c5061f4520e4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000003b99c5061f4520e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024, 4:24=E2=80=AFAM Mauro Carvalho Chehab <
mchehab+huawei@kernel.org> wrote:

> Em Thu, 8 Aug 2024 19:33:32 -0400
> John Snow <jsnow@redhat.com> escreveu:
>
> > > > Then here you'd use qmp.cmd (raises exception on QMPError) or
> qmp.cmd_raw
> > > > or qmp.cmd_obj (returns the QMP response as the return value even i=
f
> it
> > > was
> > > > an error.)
> > >
> > > Good to know, I'll try and see what fits best.
> > >
> >
> > I might *suggest* you try to use the exception-raising interface and
> catch
> > exceptions to interrogate expected errors as it aligns better with the
> > "idiomatic python API" - I have no plans to support an external API tha=
t
> > *returns* error objects except via the exception class. This approach
> will
> > be easier to port when I drop the legacy interface in the future, see
> below.
> >
> > But, that said, whichever is easiest. We use all three interfaces in ma=
ny
> > places in the QEMU tree. I have no grounds to require you to use a
> specific
> > one ;)
>
> While a python-style exception handling is cool, I ended opting to use
> cmd_obj(), as the script needs to catch the end of
> /machine/unattached/device[]
> array, and using cmd_obj() made the conversion easier.
>
> One of the things I missed at the documentation is a description of the
> possible exceptions that cmd() could raise.
>
> It is probably worth documenting it and placing them on a QMP-specific
> error class, but a change like that would probably be incompatible with
> the existing applications. Probably something to be considered on your
> TODO list to move this from legacy ;-)
>

Good feedback, thanks! I definitely didn't spend much time polishing the
"legacy" interface. I clearly thought it'd be more temporary than it became
;)

I owe the package some updates for 3.13, I'll improve the documentation and
also consider adding some "you forgot to make the address a tuple"
protection so that part is less of a trap. (Without the tuple, I think it
likely used the address as a socket path and the port as a bool to enter
server mode. mypy would catch this, but it's a design goal to not require
or expect script writers to need such things.)

Thank you! :)


> Anyway, I already folded the changes at the branch I'll be using as basis
> for the next submission (be careful to use it, as I'm always rebasing it)=
:
>

Great, I'll review the entire script more thoroughly on v2, if that's OK
with you.

Just got back from a long PTO and an illness and I'm still ramping back up
and handling backlog.


>
> https://gitlab.com/mchehab_kernel/qemu/-/commit/62feb8f6037ab762a9848eb60=
1a041fbbbe2a77a#b665bcbc1e5ae3a488f1c0f20f8c29ae640bfa63_0_17
>
>
> Thanks,
> Mauro
>

~~js

>

--0000000000003b99c5061f4520e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Aug 9, 2024, 4:24=E2=80=AFAM Mauro Carvalho Ch=
ehab &lt;<a href=3D"mailto:mchehab%2Bhuawei@kernel.org">mchehab+huawei@kern=
el.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Em Thu, 8 Aug=
 2024 19:33:32 -0400<br>
John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"=
noreferrer">jsnow@redhat.com</a>&gt; escreveu:<br>
<br>
&gt; &gt; &gt; Then here you&#39;d use qmp.cmd (raises exception on QMPErro=
r) or qmp.cmd_raw<br>
&gt; &gt; &gt; or qmp.cmd_obj (returns the QMP response as the return value=
 even if it=C2=A0 <br>
&gt; &gt; was=C2=A0 <br>
&gt; &gt; &gt; an error.)=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; Good to know, I&#39;ll try and see what fits best.<br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; I might *suggest* you try to use the exception-raising interface and c=
atch<br>
&gt; exceptions to interrogate expected errors as it aligns better with the=
<br>
&gt; &quot;idiomatic python API&quot; - I have no plans to support an exter=
nal API that<br>
&gt; *returns* error objects except via the exception class. This approach =
will<br>
&gt; be easier to port when I drop the legacy interface in the future, see =
below.<br>
&gt; <br>
&gt; But, that said, whichever is easiest. We use all three interfaces in m=
any<br>
&gt; places in the QEMU tree. I have no grounds to require you to use a spe=
cific<br>
&gt; one ;)<br>
<br>
While a python-style exception handling is cool, I ended opting to use <br>
cmd_obj(), as the script needs to catch the end of /machine/unattached/devi=
ce[]<br>
array, and using cmd_obj() made the conversion easier.<br>
<br>
One of the things I missed at the documentation is a description of the<br>
possible exceptions that cmd() could raise.<br>
<br>
It is probably worth documenting it and placing them on a QMP-specific<br>
error class, but a change like that would probably be incompatible with<br>
the existing applications. Probably something to be considered on your<br>
TODO list to move this from legacy ;-)<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Good feedback, thanks! I definitely d=
idn&#39;t spend much time polishing the &quot;legacy&quot; interface. I cle=
arly thought it&#39;d be more temporary than it became ;)</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">I owe the package some updates for 3.13, =
I&#39;ll improve the documentation and also consider adding some &quot;you =
forgot to make the address a tuple&quot; protection so that part is less of=
 a trap. (Without the tuple, I think it likely used the address as a socket=
 path and the port as a bool to enter server mode. mypy would catch this, b=
ut it&#39;s a design goal to not require or expect script writers to need s=
uch things.)=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank=
 you! :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
Anyway, I already folded the changes at the branch I&#39;ll be using as bas=
is<br>
for the next submission (be careful to use it, as I&#39;m always rebasing i=
t):<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Great, I&#39;ll review the entire script more thoroughly on v2, if that&=
#39;s OK with you.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Just =
got back from a long PTO and an illness and I&#39;m still ramping back up a=
nd handling backlog.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://gitlab.com/mchehab_kernel/qe=
mu/-/commit/62feb8f6037ab762a9848eb601a041fbbbe2a77a#b665bcbc1e5ae3a488f1c0=
f20f8c29ae640bfa63_0_17" rel=3D"noreferrer noreferrer" target=3D"_blank">ht=
tps://gitlab.com/mchehab_kernel/qemu/-/commit/62feb8f6037ab762a9848eb601a04=
1fbbbe2a77a#b665bcbc1e5ae3a488f1c0f20f8c29ae640bfa63_0_17</a><br>
<br>
<br>
Thanks,<br>
Mauro<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">~~js</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
</blockquote></div></div></div>

--0000000000003b99c5061f4520e4--


