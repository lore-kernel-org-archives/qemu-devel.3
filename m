Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE0ACED256
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 02:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy03Y-0002xo-IF; Mon, 07 Oct 2024 22:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sy03W-0002xf-Mv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 22:34:34 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sy03T-0007Hc-Gs
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 22:34:34 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5e5a0519d00so1872894eaf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1728354869; x=1728959669;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yIPUZ51OYw24cGl9TaEM56fx5kK0EjSq5r+orsgcUjI=;
 b=Ee+YEQBPdmoO9oVuaUhf3FXjzejWH1006C3zXAcEdcuJ0wDpVh1DBh0CnNnAP2SRyS
 l7aSWbYVf4YMetOz1W5ZhhwJdcZvgTjE2KE9qbqJLzx8UpE5A/nX2UNQxcbLbq/p/QXw
 0RjiXIWwIVwVBwhCfrx6r6rG44CYXqznjsyDkoQ5aAUkg7tfup4nU6WQKCONUZnTuInH
 iigMHhiDFekc/zkjBMEMYaC27DH/IF9fb5w9cykNusEXNld/r8uEOXEq7grujUaH/S/J
 CRyqpDh5x2sOOZyh4vWorWvpz/AMveErE7kSdRz7ZxESAJ3J2Dx2inH6KFgIIAsSh91H
 iKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728354869; x=1728959669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yIPUZ51OYw24cGl9TaEM56fx5kK0EjSq5r+orsgcUjI=;
 b=kyXMEsTDIGVLp75oFS6vaB/eDwd3UglsM/9lf+cBF4ursd+PT45fDZnDGKJN7nosiJ
 hg68eOJrj5TNH3tLxU4UbddCBVD/dyxDpl+ONPHcNqoXgRkjrWlhB2jdeWSeM12kE1/O
 9SrVI8KVVKTtAAV6X9QLm3LXx/nfOZR8x8+3hBa2AuTHgGfxqODUvyWgKfoqX7y63m9b
 sTrbc4NDbL0tnafayK89QDFTsO9XYkZN0Hcx749Fo6RQO0ADio9z8m61CvDYN7+Cf6e/
 owTYoZ8nfkKW2o+7N6YsWGmOpRkA+gDJErJiwlnhAt0HuzZIt73d/N1NK3ek/Ebeb3L1
 nGcQ==
X-Gm-Message-State: AOJu0YymsNLZK+kyVik8beyJUbbRUDTbGKHQkA15WMiNPkyDwcp834yo
 GslyhR4HT5e85Rbh6JW6rdTb85CqnmcrLPWJL5bo+UTfrP1IL3+oPnuQjV8ZRvFxMOp7DdfcHXn
 6Ph5xCXUSgnDtD0GCz2Ep8BeREG9ej5g/N73hfg==
X-Google-Smtp-Source: AGHT+IHG+6qOxg+nF2V9igGGdBcUTHxH+kYlnkfuBnlbmiJSykoNwIWJ15tU0fibMQhdWOVneEP0tsvVjCgAiwD4tgo=
X-Received: by 2002:a05:6870:d202:b0:279:334e:7f93 with SMTP id
 586e51a60fabf-287c1db0177mr8386100fac.10.1728354868588; Mon, 07 Oct 2024
 19:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727630000.git.yong.huang@smartx.com>
 <3a383e563cc57c77320af805c8b8ece4e68eebea.1727630000.git.yong.huang@smartx.com>
 <ZvsORXZDZodSrzO-@x1n>
 <CAK9dgmZ7M30xXahBUKEkmQ2ZkWoF=DA=pb8XF_=YVM9xF2zcJw@mail.gmail.com>
 <ZvwXUHltQU2seIM4@x1n>
In-Reply-To: <ZvwXUHltQU2seIM4@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 8 Oct 2024 10:34:12 +0800
Message-ID: <CAK9dgmbi5YRGJsUEY0XdvM9zhfacvSxksjUcCXvqG0SA4D-C7Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] migration: Support responsive CPU throttle
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fd0a450623edf968"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000fd0a450623edf968
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:37=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Tue, Oct 01, 2024 at 10:18:54AM +0800, Yong Huang wrote:
> > On Tue, Oct 1, 2024 at 4:47=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > > On Mon, Sep 30, 2024 at 01:14:28AM +0800, yong.huang@smartx.com wrote=
:
> > > > From: Hyman Huang <yong.huang@smartx.com>
> > > >
> > > > Currently, the convergence algorithm determines that the migration
> > > > cannot converge according to the following principle:
> > > > The dirty pages generated in current iteration exceed a specific
> > > > percentage (throttle-trigger-threshold, 50 by default) of the numbe=
r
> > > > of transmissions. Let's refer to this criteria as the "dirty rate".
> > > > If this criteria is met more than or equal to twice
> > > > (dirty_rate_high_cnt >=3D 2), the throttle percentage increased.
> > > >
> > > > In most cases, above implementation is appropriate. However, for a
> > > > VM with high memory overload, each iteration is time-consuming.
> > > > The VM's computing performance may be throttled at a high percentag=
e
> > > > and last for a long time due to the repeated confirmation behavior.
> > > > Which may be intolerable for some computationally sensitive softwar=
e
> > > > in the VM.
> > > >
> > > > As the comment mentioned in the migration_trigger_throttle function=
,
> > > > in order to avoid erroneous detection, the original algorithm
> confirms
> > > > the criteria repeatedly. Put differently, the criteria does not nee=
d
> > > > to be validated again once the detection is more reliable.
> > > >
> > > > In the refinement, in order to make the detection more accurate, we
> > > > introduce another criteria, called the "dirty ratio" to determine
> > > > the migration convergence. The "dirty ratio" is the ratio of
> > > > bytes_xfer_period and bytes_dirty_period. When the algorithm
> > > > repeatedly detects that the "dirty ratio" of current sync is lower
> > > > than the previous, the algorithm determines that the migration cann=
ot
> > > > converge. For the "dirty rate" and "dirty ratio", if one of the two
> > > > criteria is met, the penalty percentage would be increased. This
> > > > makes CPU throttle more responsively and therefor saves the time of
> > > > the entire iteration and therefore reduces the time of VM performan=
ce
> > > > degradation.
> > > >
> > > > In conclusion, this refinement significantly reduces the processing
> > > > time required for the throttle percentage step to its maximum while
> > > > the VM is under a high memory load.
> > >
> > > I'm a bit lost on why this patch 2-3 is still needed if patch 1 works=
.
> > > Wouldn't that greatly increase the chance of throttle code being
> inovked
> > > already?  Why we still need this?
> > >
> >
> > Indeed, if we are considering how to increase the change of throttle.
> > Patch 1 is sufficient, and I'm not insisting.
> >
> > If we are talking about how to detect the migration convergence, this
> > patch, IMHO, is still helpful. Anyway, it depends on your judgment. :)
>
> Thanks.  I really hope we can stick with patch 1 only for now, and we lea=
ve
> patches like 2-3 for future, or probably never.
>
> I want to avoid more magical tunables, and I want to avoid the code harde=
r
> to read.  Unlike most of other migration features, auto converge so far i=
s
> already pretty heavy on the "engineering" aspect of things.  More people
> care about downtime with 100ms or even less, then it makes zero sense a
> throttle feature can stop a group of vCPUs for more than that easily.
>
> I hope we can unite more dev/qe resources on postcopy across QEMU communi=
ty
> for enterprise users.  PoCs are always good stuff for QEMU as it's a
> community project and people experiment things on it, but I hope at least
> from design level, not small tunables like this one.  We could have
> introduced 10 more tunables all over, feed them to AI and train some
> numbers that migration can improve 10%, but IMHO that doesn't hugely help=
.
>
> If you really care about convergence issues, I want to know whether you
> agree on postcopy being a better way to go.  There're still plenty of
>

Agree, postcopy ought to deserve more attention as respect to refining the
huge
VM migration.


> things we can do better in that area on either postcopy in general, or
> downtime optimizations that lots of people are working (e.g. VFIO's), so
> again IMHO it'll be good we keep focused there.
>
> Thanks,
>
> --
> Peter Xu
>
>
Thanks for sharing your idea, I'll drop these 2 patches in the next version=
.

Yong

--=20
Best regards

--000000000000fd0a450623edf968
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 202=
4 at 11:37=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Tue, Oct 01, 202=
4 at 10:18:54AM +0800, Yong Huang wrote:<br>
&gt; On Tue, Oct 1, 2024 at 4:47=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:=
peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Sep 30, 2024 at 01:14:28AM +0800, <a href=3D"mailto:yong.=
huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> wrote:<br>
&gt; &gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Currently, the convergence algorithm determines that the mig=
ration<br>
&gt; &gt; &gt; cannot converge according to the following principle:<br>
&gt; &gt; &gt; The dirty pages generated in current iteration exceed a spec=
ific<br>
&gt; &gt; &gt; percentage (throttle-trigger-threshold, 50 by default) of th=
e number<br>
&gt; &gt; &gt; of transmissions. Let&#39;s refer to this criteria as the &q=
uot;dirty rate&quot;.<br>
&gt; &gt; &gt; If this criteria is met more than or equal to twice<br>
&gt; &gt; &gt; (dirty_rate_high_cnt &gt;=3D 2), the throttle percentage inc=
reased.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In most cases, above implementation is appropriate. However,=
 for a<br>
&gt; &gt; &gt; VM with high memory overload, each iteration is time-consumi=
ng.<br>
&gt; &gt; &gt; The VM&#39;s computing performance may be throttled at a hig=
h percentage<br>
&gt; &gt; &gt; and last for a long time due to the repeated confirmation be=
havior.<br>
&gt; &gt; &gt; Which may be intolerable for some computationally sensitive =
software<br>
&gt; &gt; &gt; in the VM.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As the comment mentioned in the migration_trigger_throttle f=
unction,<br>
&gt; &gt; &gt; in order to avoid erroneous detection, the original algorith=
m confirms<br>
&gt; &gt; &gt; the criteria repeatedly. Put differently, the criteria does =
not need<br>
&gt; &gt; &gt; to be validated again once the detection is more reliable.<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In the refinement, in order to make the detection more accur=
ate, we<br>
&gt; &gt; &gt; introduce another criteria, called the &quot;dirty ratio&quo=
t; to determine<br>
&gt; &gt; &gt; the migration convergence. The &quot;dirty ratio&quot; is th=
e ratio of<br>
&gt; &gt; &gt; bytes_xfer_period and bytes_dirty_period. When the algorithm=
<br>
&gt; &gt; &gt; repeatedly detects that the &quot;dirty ratio&quot; of curre=
nt sync is lower<br>
&gt; &gt; &gt; than the previous, the algorithm determines that the migrati=
on cannot<br>
&gt; &gt; &gt; converge. For the &quot;dirty rate&quot; and &quot;dirty rat=
io&quot;, if one of the two<br>
&gt; &gt; &gt; criteria is met, the penalty percentage would be increased. =
This<br>
&gt; &gt; &gt; makes CPU throttle more responsively and therefor saves the =
time of<br>
&gt; &gt; &gt; the entire iteration and therefore reduces the time of VM pe=
rformance<br>
&gt; &gt; &gt; degradation.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In conclusion, this refinement significantly reduces the pro=
cessing<br>
&gt; &gt; &gt; time required for the throttle percentage step to its maximu=
m while<br>
&gt; &gt; &gt; the VM is under a high memory load.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m a bit lost on why this patch 2-3 is still needed if patch=
 1 works.<br>
&gt; &gt; Wouldn&#39;t that greatly increase the chance of throttle code be=
ing inovked<br>
&gt; &gt; already?=C2=A0 Why we still need this?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Indeed, if we are considering how to increase the change of throttle.<=
br>
&gt; Patch 1 is sufficient, and I&#39;m not insisting.<br>
&gt; <br>
&gt; If we are talking about how to detect the migration convergence, this<=
br>
&gt; patch, IMHO, is still helpful. Anyway, it depends on your judgment. :)=
<br>
<br>
Thanks.=C2=A0 I really hope we can stick with patch 1 only for now, and we =
leave<br>
patches like 2-3 for future, or probably never.<br>
<br>
I want to avoid more magical tunables, and I want to avoid the code harder<=
br>
to read.=C2=A0 Unlike most of other migration features, auto converge so fa=
r is<br>
already pretty heavy on the &quot;engineering&quot; aspect of things.=C2=A0=
 More people<br>
care about downtime with 100ms or even less, then it makes zero sense a<br>
throttle feature can stop a group of vCPUs for more than that easily.<br>
<br>
I hope we can unite more dev/qe resources on postcopy across QEMU community=
<br>
for enterprise users.=C2=A0 PoCs are always good stuff for QEMU as it&#39;s=
 a<br>
community project and people experiment things on it, but I hope at least<b=
r>
from design level, not small tunables like this one.=C2=A0 We could have<br=
>
introduced 10 more tunables all over, feed them to AI and train some<br>
numbers that migration can improve 10%, but IMHO that doesn&#39;t hugely he=
lp.<br>
<br>
If you really care about convergence issues, I want to know whether you<br>
agree on postcopy being a better way to go.=C2=A0 There&#39;re still plenty=
 of<br></blockquote><div><br></div><div><div style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif" class=3D"gmail_default">Agree, postcopy ought =
to deserve more attention as respect to refining the huge</div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">VM migration.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
things we can do better in that area on either postcopy in general, or<br>
downtime optimizations that lots of people are working (e.g. VFIO&#39;s), s=
o<br>
again IMHO it&#39;ll be good we keep focused there.<br>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><br></div><div style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif" class=3D"gmail_default">Thanks for sharing your idea=
, I&#39;ll drop these 2 patches in the next version.</div><div style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br>=
</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">Yong</div><div><br></div><span class=3D"gmail_signature_=
prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font></div>=
</div></div>

--000000000000fd0a450623edf968--

