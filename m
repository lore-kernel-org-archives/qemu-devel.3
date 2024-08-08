Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3382BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 23:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scCdp-0001Di-LB; Thu, 08 Aug 2024 19:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scCdm-0001CS-In
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 19:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scCdj-0008VU-Os
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 19:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723160028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/k/NZTRG2dRmG0gJT5CX5pgT+CIApxY87vm83QwcYY=;
 b=h/mQ56EIa5w1D6pqL0gPeb0tVd2IBIcsYzuUZij3tgeuMbEBASAyLokZq+h6PtBWmC1r4V
 f88GqtVUfwgvsEKo3Dcdeqbdpd0ahFr9sqKg1ZLxDjhAuHTkEhijIPv7bVjpXFbvNVYX9E
 9zdTrCydlwsD9w37JwveHG2R9xu0/Fc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-rdEmpnvrN5qeM1swTAwRhg-1; Thu, 08 Aug 2024 19:33:46 -0400
X-MC-Unique: rdEmpnvrN5qeM1swTAwRhg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7b544c7f7b3so1477481a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 16:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723160025; x=1723764825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/k/NZTRG2dRmG0gJT5CX5pgT+CIApxY87vm83QwcYY=;
 b=T1wabHIybn9XxVpD/Hip1P9VWfSYOIcvoHj8WxRm53VXLqNYVsRl4bOnv9wVsvfaM4
 phQCjFx9gz1F5Sq+HaveNhiEL/ZZ2Glk88W2/DTGU7vJa7us++35B3BSikIIix/Th5cy
 LvEyZ23h1GgyGUM108edl8aMKy/zCwMFQUluKsKbC99tcbuiSpn2JEs3wA4iXzKXla/w
 AR0lgWwcTt3ZsmFvLaA+Ie3CwRzm4XM5Skhr+pnpL0L0cI+wDlcacx+wosnou9vOBY6S
 965KKaOgcdMKRkwLsfxcC6mLf9PYoAfBmIAOQSRdpJxXUJSj/pjLWMnKCh4X9s2AmDlY
 sOcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxSkEo2mSZSCgtuX0uWJkTDNEKFoc3R45we16IoAXZqjE+6Pwvrg8Y3VyS92CeZOq+X3JfW5lEmcdpTs/7CCBDV63s4iE=
X-Gm-Message-State: AOJu0YyFjoqYVAdDkUxlxdsvW/BOjQ+q1EhzaftztYK2KFBHwARIyJqm
 hhHQ5DAx02h7FRuEteGevmGUjSUItE9PaM/12R2jHyJ/iDEMUmx+VrkjVVZ0veOXRQvsBhyXlxH
 x6E5bFtRDVS2ZC1qUUrnklBjRl8v67GT7nhbCNzHxyMmsXRCnaz9fkISJYyx/8SM127BKLD6MB9
 SJ0PMBzqHqpIlOmE4YGBVfaqq6eNE=
X-Received: by 2002:a05:6a20:9190:b0:1c4:2132:e205 with SMTP id
 adf61e73a8af0-1c6fcf8533cmr4627310637.48.1723160024913; 
 Thu, 08 Aug 2024 16:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcu6ejktV3nzi7M9MsCsPmVCenmaBCUyMiTyoP52+lzN0VQt0nNps54rqALRqiFW6X67dx/dPdUGAHaOn+o9E=
X-Received: by 2002:a05:6a20:9190:b0:1c4:2132:e205 with SMTP id
 adf61e73a8af0-1c6fcf8533cmr4627289637.48.1723160024434; Thu, 08 Aug 2024
 16:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
 <CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
 <20240809004137.01f97da2@foz.lan>
In-Reply-To: <20240809004137.01f97da2@foz.lan>
From: John Snow <jsnow@redhat.com>
Date: Thu, 8 Aug 2024 19:33:32 -0400
Message-ID: <CAFn=p-ZM8cgKvUx+5v7YU6TaPZySJL1QnHqjmN5rQpF=D_V=8Q@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate GHES
 error inject
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, 
 Cleber Rosa <crosa@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000025e0b0061f3475b8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

--00000000000025e0b0061f3475b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:41=E2=80=AFPM Mauro Carvalho Chehab <
mchehab+huawei@kernel.org> wrote:

> Em Thu, 8 Aug 2024 17:21:33 -0400
> John Snow <jsnow@redhat.com> escreveu:
>
> > On Fri, Aug 2, 2024 at 5:44=E2=80=AFPM Mauro Carvalho Chehab <
> > mchehab+huawei@kernel.org> wrote:
> >
>
> > > diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> > > new file mode 100644
> > > index 000000000000..13fae7a7af0e
> > > --- /dev/null
> > > +++ b/scripts/qmp_helper.py
> > >
> >
> > I'm going to admit I only glanced at this very briefly, but -- is there=
 a
> > chance you could use qemu.git/python/qemu/qmp instead of writing your o=
wn
> > helpers here?
> >
> > If *NOT*, is there something that I need to add to our QMP library to
> > facilitate your script?
>
> I started writing this script to be hosted outside qemu tree, when
> we had a very different API.
>
> I noticed later about the QMP, and even tried to write a patch for it,
> but I gave up due to asyncio complexity...
>

Sorry :)


>
> Please notice that, on this file, I actually placed three classes:
>
> - qmp
> - util
> - cper_guid
>
> I could probably make the first one to be an override of
> QEMUMonitorProtocol
> (besides normal open/close/cmd communication, it also contains some
> methods that are specific to error inject use case:
>
> - to generate a CPER record;
> - to search for data via qom-get.
>
> The other two classes are just common code used by ghes_inject commands.
> My idea is to have multiple commands to do different kinds of GHES
> error injection, each command on a different file/class.
>

Gotcha! Thanks for the feedback. I would *prefer* that code checked in to
qemu.git use the QMP module where possible so that I don't have to maintain
multiple copies of QMP wrangling code. I think what you want to do should
be easily possible with the existing library; and anything that isn't, I'm
more than happy to meet your needs. Reach out absolutely any time.


>
> > > +    s =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> > > +    try:
> > > +        s.connect((host, port))
> > > +    except ConnectionRefusedError:
> > > +        sys.exit(f"Can't connect to QMP host {host}:{port}")
> > >
> >
> > You should be able to use e.g.
> >
> > legacy.py's QEMUMonitorProtocol class for synchronous connections, e.g.
> >
> > from qemu.qmp.legacy import QEMUMonitorProtocol
> >
> > qmp =3D QEMUMonitorProtocol((host, port))
> > qmp.connect(negotiate=3DTrue)
>
> That sounds interesting! I give it a try.
>
> > If you want to run the script w/o setting up a virtual environment or
> > installing the package, take a look at the hacks in scripts/qmp/ for ho=
w
> I
> > support e.g. qom-get directly from the source tree.
>
> Yeah, I saw that already. Doing:
>
>         sys.path.append(path.join(qemu_dir, 'python'))
>
> the same way qom-get does should do the trick.
>
> > > +
> > > +    data =3D s.recv(1024)
> > > +    try:
> > > +        obj =3D json.loads(data.decode("utf-8"))
> > > +    except json.JSONDecodeError as e:
> > > +        print(f"Invalid QMP answer: {e}")
> > > +        s.close()
> > > +        return
> > > +
> > > +    if "QMP" not in obj:
> > > +        print(f"Invalid QMP answer: {data.decode("utf-8")}")
> > > +        s.close()
> > > +        return
> > > +
> > > +    for i, command in enumerate(commands):
> > >
> >
> > Then here you'd use qmp.cmd (raises exception on QMPError) or qmp.cmd_r=
aw
> > or qmp.cmd_obj (returns the QMP response as the return value even if it
> was
> > an error.)
>
> Good to know, I'll try and see what fits best.
>

I might *suggest* you try to use the exception-raising interface and catch
exceptions to interrogate expected errors as it aligns better with the
"idiomatic python API" - I have no plans to support an external API that
*returns* error objects except via the exception class. This approach will
be easier to port when I drop the legacy interface in the future, see below=
.

But, that said, whichever is easiest. We use all three interfaces in many
places in the QEMU tree. I have no grounds to require you to use a specific
one ;)


>
> > More details:
> >
> https://qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/qemu.qmp.l=
egacy.html
>
> I'll take a look. The name "legacy" is a little scary, as it might
> imply that this has been deprecated. If there's no plans to deprecate,
> then it would be great to use it and simplify the code a little bit.
>

I named it legacy to be scary on purpose :)

The truth is that the "legacy" module was designed to be a 1:1 drop-in
replacement for an older version of the synchronous QMP library that
powered our internal iotests. We still use this "legacy" module in
thousands of places in the QEMU tree. I do have plans to replace it with a
"proper" synchronous frontend class, eventually, someday, etc. It's been a
while and I still haven't done it, though. Oops...

When I do eventually replace it, I will convert all users inside of
qemu.git personally, and the design of the "non-legacy" API will be chosen
pretty explicitly to make that task really easy for myself and reviewers.
This would include your script inside the qemu.git tree. It should be
pretty safe to use the legacy module *in qemu.git*, but for external,
out-of-tree scripts, it may indeed disappear someday - but converting to
the new API, when I merge it, should be very, very trivial. How much of a
headache that is for you depends on how you package/distribute the script
and how awful it will be to update the code and dependencies when it
happens.

FYI: I have promised in the readme for the standalone version of qemu.qmp
that legacy.py will not be removed prior to v0.1.0. All versions before
then will still have it, guaranteed.

(Neither here nor there: One of the holdups in this replacement is figuring
out how to structure the API for event listening, which was the main
motivator of the *async* version of the class. We have many users who don't
want full async handling, but still want to listen for and catch events. I
need a proper sit and think for what the API I want to commit to supporting
and maintaining for this should look like. Not your problem, anyway!)


>
> > There's also an async version, but it doesn't look like you require tha=
t
> > complexity, so you can ignore it.
>
> Yes, that's the case: a serialized sync send/response logic works perfect=
ly
> for this script. No need to be burden with asyncio complexity.
>
> Thanks,
> Mauro
>
>

--00000000000025e0b0061f3475b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 8, 2024 at 6:41=E2=80=AFP=
M Mauro Carvalho Chehab &lt;<a href=3D"mailto:mchehab%2Bhuawei@kernel.org">=
mchehab+huawei@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Em Thu, 8 Aug 2024 17:21:33 -0400<br>
John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsnow@r=
edhat.com</a>&gt; escreveu:<br>
<br>
&gt; On Fri, Aug 2, 2024 at 5:44=E2=80=AFPM Mauro Carvalho Chehab &lt;<br>
&gt; <a href=3D"mailto:mchehab%2Bhuawei@kernel.org" target=3D"_blank">mcheh=
ab+huawei@kernel.org</a>&gt; wrote:=C2=A0 <br>
&gt; <br>
<br>
&gt; &gt; diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py<br>
&gt; &gt; new file mode 100644<br>
&gt; &gt; index 000000000000..13fae7a7af0e<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/scripts/qmp_helper.py<br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; I&#39;m going to admit I only glanced at this very briefly, but -- is =
there a<br>
&gt; chance you could use qemu.git/python/qemu/qmp instead of writing your =
own<br>
&gt; helpers here?<br>
&gt; <br>
&gt; If *NOT*, is there something that I need to add to our QMP library to<=
br>
&gt; facilitate your script?<br>
<br>
I started writing this script to be hosted outside qemu tree, when<br>
we had a very different API.<br>
<br>
I noticed later about the QMP, and even tried to write a patch for it,<br>
but I gave up due to asyncio complexity...<br></blockquote><div><br></div><=
div>Sorry :)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
Please notice that, on this file, I actually placed three classes:<br>
<br>
- qmp<br>
- util<br>
- cper_guid<br>
<br>
I could probably make the first one to be an override of QEMUMonitorProtoco=
l <br>
(besides normal open/close/cmd communication, it also contains some<br>
methods that are specific to error inject use case:<br>
<br>
- to generate a CPER record;<br>
- to search for data via qom-get.<br>
<br>
The other two classes are just common code used by ghes_inject commands.<br=
>
My idea is to have multiple commands to do different kinds of GHES<br>
error injection, each command on a different file/class.<br></blockquote><d=
iv><br></div><div>Gotcha! Thanks for the feedback. I would *prefer* that co=
de checked in to qemu.git use the QMP module where possible so that I don&#=
39;t have to maintain multiple copies of QMP wrangling code. I think what y=
ou want to do should be easily possible with the existing library; and anyt=
hing that isn&#39;t, I&#39;m more than happy to meet your needs. Reach out =
absolutely any time.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt; &gt; +=C2=A0 =C2=A0 s =3D socket.socket(socket.AF_INET, socket.SOCK_ST=
REAM)<br>
&gt; &gt; +=C2=A0 =C2=A0 try:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s.connect((host, port))<br>
&gt; &gt; +=C2=A0 =C2=A0 except ConnectionRefusedError:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(f&quot;Can&#39;t connect to=
 QMP host {host}:{port}&quot;)<br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; You should be able to use e.g.<br>
&gt; <br>
&gt; legacy.py&#39;s QEMUMonitorProtocol class for synchronous connections,=
 e.g.<br>
&gt; <br>
&gt; from qemu.qmp.legacy import QEMUMonitorProtocol<br>
&gt; <br>
&gt; qmp =3D QEMUMonitorProtocol((host, port))<br>
&gt; qmp.connect(negotiate=3DTrue)<br>
<br>
That sounds interesting! I give it a try.<br>
<br>
&gt; If you want to run the script w/o setting up a virtual environment or<=
br>
&gt; installing the package, take a look at the hacks in scripts/qmp/ for h=
ow I<br>
&gt; support e.g. qom-get directly from the source tree.<br>
<br>
Yeah, I saw that already. Doing: <br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.path.append(path.join(qemu_dir, &#39;python=
&#39;))<br>
<br>
the same way qom-get does should do the trick.<br>
<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 data =3D s.recv(1024)<br>
&gt; &gt; +=C2=A0 =C2=A0 try:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D json.loads(data.decode(&quot=
;utf-8&quot;))<br>
&gt; &gt; +=C2=A0 =C2=A0 except json.JSONDecodeError as e:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Invalid QMP answer: {e}=
&quot;)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s.close()<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if &quot;QMP&quot; not in obj:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Invalid QMP answer: {da=
ta.decode(&quot;utf-8&quot;)}&quot;)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s.close()<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 for i, command in enumerate(commands):<br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; Then here you&#39;d use qmp.cmd (raises exception on QMPError) or qmp.=
cmd_raw<br>
&gt; or qmp.cmd_obj (returns the QMP response as the return value even if i=
t was<br>
&gt; an error.)<br>
<br>
Good to know, I&#39;ll try and see what fits best.<br></blockquote><div><br=
></div><div>I might *suggest* you try to use the exception-raising interfac=
e and catch exceptions to interrogate expected errors as it aligns better w=
ith the &quot;idiomatic python API&quot; - I have no plans to support an ex=
ternal API that *returns* error objects except via the exception class. Thi=
s approach will be easier to port when I drop the legacy interface in the f=
uture, see below.</div><div><br></div><div>But, that said, whichever is eas=
iest. We use all three interfaces in many places in the QEMU tree. I have n=
o grounds to require you to use a specific one ;)<br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; More details:<br>
&gt; <a href=3D"https://qemu.readthedocs.io/projects/python-qemu-qmp/en/lat=
est/qemu.qmp.legacy.html" rel=3D"noreferrer" target=3D"_blank">https://qemu=
.readthedocs.io/projects/python-qemu-qmp/en/latest/qemu.qmp.legacy.html</a>=
<br>
<br>
I&#39;ll take a look. The name &quot;legacy&quot; is a little scary, as it =
might<br>
imply that this has been deprecated. If there&#39;s no plans to deprecate,<=
br>
then it would be great to use it and simplify the code a little bit.<br></b=
lockquote><div><br></div><div>I named it legacy to be scary on purpose :)</=
div><div><br></div><div>The truth is that the &quot;legacy&quot; module was=
 designed to be a 1:1 drop-in replacement for an older version of the synch=
ronous QMP library that powered our internal iotests. We still use this &qu=
ot;legacy&quot; module in thousands of places in the QEMU tree. I do have p=
lans to replace it with a &quot;proper&quot; synchronous frontend class, ev=
entually, someday, etc. It&#39;s been a while and I still haven&#39;t done =
it, though. Oops...<br></div><div><br></div><div>When I do eventually repla=
ce it, I will convert all users inside of qemu.git personally, and the desi=
gn of the &quot;non-legacy&quot; API will be chosen pretty explicitly to ma=
ke that task really easy for myself and reviewers. This would include your =
script inside the qemu.git tree. It should be pretty safe to use the legacy=
 module *in qemu.git*, but for external, out-of-tree scripts, it may indeed=
 disappear someday - but converting to the new API, when I merge it, should=
 be very, very trivial. How much of a headache that is for you depends on h=
ow you package/distribute the script and how awful it will be to update the=
 code and dependencies when it happens.</div><div><br></div><div>FYI: I hav=
e promised in the readme for the standalone version of qemu.qmp that legacy=
.py will not be removed prior to v0.1.0. All versions before then will stil=
l have it, guaranteed.</div><div><br></div><div>(Neither here nor there: On=
e of the holdups in this replacement is figuring out how to structure the A=
PI for event listening, which was the main motivator of the *async* version=
 of the class. We have many users who don&#39;t want full async handling, b=
ut still want to listen for and catch events. I need a proper sit and think=
 for what the API I want to commit to supporting and maintaining for this s=
hould look like. Not your problem, anyway!)<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; There&#39;s also an async version, but it doesn&#39;t look like you re=
quire that<br>
&gt; complexity, so you can ignore it.<br>
<br>
Yes, that&#39;s the case: a serialized sync send/response logic works perfe=
ctly<br>
for this script. No need to be burden with asyncio complexity.<br>
<br>
Thanks,<br>
Mauro<br>
<br>
</blockquote></div></div>

--00000000000025e0b0061f3475b8--


