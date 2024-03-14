Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A5EC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 13:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rklcP-0001UG-WA; Thu, 14 Mar 2024 09:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rklcN-0001Rd-Rg
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rklcI-0004kO-Gw
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710424769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDoTEIrF8Tb9kD7kaY2+BGieZQk75IulybEo+y86rSg=;
 b=aWOMJNl1mOe73OvcFmCJaM6jOKEX1jp3dmL+bsDNRGunmTcV+gT0EvYbkeYYsT9gNyhWbc
 itTrstIhVw9p6aZejVn6rONGsv6ozDAOqnMdVzCqy8C35ghlPZi39pijLDOkuZ5uLt7XOW
 Mi6evAvBcRsTXrXisjxocGvX5TPGBrg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-MNPI06epM1eSn0S5o-51zA-1; Thu, 14 Mar 2024 09:59:25 -0400
X-MC-Unique: MNPI06epM1eSn0S5o-51zA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29a5bae5b3fso868519a91.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 06:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710424765; x=1711029565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CDoTEIrF8Tb9kD7kaY2+BGieZQk75IulybEo+y86rSg=;
 b=aiNkBc5FHfxDXfyAt9WOpnaZJs+iVlZQUw7TH+M7eopO7/hK9gblB3obCIl/RskORl
 evQ+0L7fO1uzkAis/qUN0BM63Do88uDfGM6icFcTbWYnh97D+jvuynxK6G/AoM39LB8v
 7YIWHw5Vr2DPZ6qdKnzY3pCye+7DmG6SxnXaquXIaV1fWawHd/pM//QTwDAVOLtSZAdi
 YzO9DW7L5nwUnUKlsjcS8Kc/0HWPCg9+COV8cAAloT0nRqOhZ/tOfXHccBMGKdCqMavW
 qWQ2tlNXiEKwr0REA8B4UD6AtHqhEzF3vlQC97wP2NHlHM6sJaRzl4b+4TkTJHRam5DT
 6t2w==
X-Gm-Message-State: AOJu0YwlNjIpPTWwgkpf4olz9nLyCuXoaqfzSR0sroeWdV8W7nMnoIBT
 jk5BraNYxPSxHiMKVK6/PJL9hnnOs1u0oOT5r9rci8dr03r0LOF2vAWLJ/MeTs4pba+0YgJ/8+l
 /Q2Bw7gpO5hnXskLWC7wM88dBfwEp9zw0owMv7HMjjzkCoboeHhLRXGlD4rkgeiWyKXg6U6zG/+
 ElBcZKRJgGeX3StwZY1iZi+Nf1XLE=
X-Received: by 2002:a17:90b:148d:b0:29b:9daa:3a92 with SMTP id
 js13-20020a17090b148d00b0029b9daa3a92mr23770pjb.31.1710424764816; 
 Thu, 14 Mar 2024 06:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFt1w97Tpo7uxFEh3fceur9h/58wmCJN/BZqHIDw93dJMcrapgoWjCbhEh1vsE2bCXAtTvl722yjn0XyY241Y=
X-Received: by 2002:a17:90b:148d:b0:29b:9daa:3a92 with SMTP id
 js13-20020a17090b148d00b0029b9daa3a92mr23760pjb.31.1710424764521; Thu, 14 Mar
 2024 06:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-17-jsnow@redhat.com>
 <87a5n19dce.fsf@pond.sub.org>
 <CAFn=p-Z9Y_wOn8H9qusrD8vHsvyseEZfLn67uo4JpMgjzt9-yQ@mail.gmail.com>
 <87msr09aq6.fsf@pond.sub.org>
In-Reply-To: <87msr09aq6.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 14 Mar 2024 09:59:12 -0400
Message-ID: <CAFn=p-Z0dP5vdaSLTEZ+1AATQD5spA59oxG3Cdw39DPc9X1c6w@mail.gmail.com>
Subject: Re: [PATCH v4 16/23] qapi/schema: Don't initialize "members" with
 `None`
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000813b3d06139f4ca7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000813b3d06139f4ca7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024, 9:58=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Mar 14, 2024, 9:01=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Declare, but don't initialize the "members" field with type
> >> > List[QAPISchemaObjectTypeMember].
> >> >
> >> > This simplifies the typing from what would otherwise be
> >> > Optional[List[T]] to merely List[T]. This removes the need to add
> >> > assertions to several callsites that this value is not None - which =
it
> >> > never will be after the delayed initialization in check() anyway.
> >> >
> >> > The type declaration without initialization trick will cause
> accidental
> >> > uses of this field prior to full initialization to raise an
> >> > AttributeError.
> >> >
> >> > (Note that it is valid to have an empty members list, see the intern=
al
> >> > q_empty object as an example. For this reason, we cannot use the emp=
ty
> >> > list as a replacement test for full initialization and instead rely =
on
> >> > the _checked/_check_complete fields.)
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/schema.py | 12 +++++++-----
> >> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> > index 50ebc4f12de..fb30314741a 100644
> >> > --- a/scripts/qapi/schema.py
> >> > +++ b/scripts/qapi/schema.py
> >> > @@ -20,7 +20,7 @@
> >> >  from collections import OrderedDict
> >> >  import os
> >> >  import re
> >> > -from typing import List, Optional
> >> > +from typing import List, Optional, cast
> >> >
> >> >  from .common import (
> >> >      POINTER_SUFFIX,
> >> > @@ -449,7 +449,7 @@ def __init__(self, name, info, doc, ifcond,
> features,
> >> >          self.base =3D None
> >> >          self.local_members =3D local_members
> >> >          self.variants =3D variants
> >> > -        self.members =3D None
> >> > +        self.members: List[QAPISchemaObjectTypeMember]
> >> >          self._check_complete =3D False
> >> >
> >> >      def check(self, schema):
> >> > @@ -482,7 +482,11 @@ def check(self, schema):
> >> >          for m in self.local_members:
> >> >              m.check(schema)
> >> >              m.check_clash(self.info, seen)
> >> > -        members =3D seen.values()
> >> > +
> >> > +        # check_clash works in terms of the supertype, but
> local_members
> >> > +        # is asserted to be List[QAPISchemaObjectTypeMember].
> >>
> >> Do you mean "but self.members is declared as
> >> List[QAPISchemaObjectTypeMember]"?
> >
> > Argh. I meant asserted in the linguistic sense. mypy asserts it to be;
> not
> > a runtime assertion.
> >
> > I do this a lot, apparently.
>
> Okay to adjust your comment to my version?
>

Absolutely, of course!


> [...]
>
>

--000000000000813b3d06139f4ca7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Mar 14, 2024, 9:58=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; On Thu, Mar 14, 2024, 9:01=E2=80=AFAM Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redh=
at.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Declare, but don&#39;t initialize the &quot;members&quot; fie=
ld with type<br>
&gt;&gt; &gt; List[QAPISchemaObjectTypeMember].<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This simplifies the typing from what would otherwise be<br>
&gt;&gt; &gt; Optional[List[T]] to merely List[T]. This removes the need to=
 add<br>
&gt;&gt; &gt; assertions to several callsites that this value is not None -=
 which it<br>
&gt;&gt; &gt; never will be after the delayed initialization in check() any=
way.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The type declaration without initialization trick will cause =
accidental<br>
&gt;&gt; &gt; uses of this field prior to full initialization to raise an<b=
r>
&gt;&gt; &gt; AttributeError.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (Note that it is valid to have an empty members list, see the=
 internal<br>
&gt;&gt; &gt; q_empty object as an example. For this reason, we cannot use =
the empty<br>
&gt;&gt; &gt; list as a replacement test for full initialization and instea=
d rely on<br>
&gt;&gt; &gt; the _checked/_check_complete fields.)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/schema.py | 12 +++++++-----<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 7 insertions(+), 5 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<=
br>
&gt;&gt; &gt; index 50ebc4f12de..fb30314741a 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/schema.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/schema.py<br>
&gt;&gt; &gt; @@ -20,7 +20,7 @@<br>
&gt;&gt; &gt;=C2=A0 from collections import OrderedDict<br>
&gt;&gt; &gt;=C2=A0 import os<br>
&gt;&gt; &gt;=C2=A0 import re<br>
&gt;&gt; &gt; -from typing import List, Optional<br>
&gt;&gt; &gt; +from typing import List, Optional, cast<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 from .common import (<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 POINTER_SUFFIX,<br>
&gt;&gt; &gt; @@ -449,7 +449,7 @@ def __init__(self, name, info, doc, ifcon=
d, features,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.base =3D None<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.local_members =3D loca=
l_members<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.variants =3D variants<=
br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members =3D None<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members: List[QAPISchemaObj=
ectTypeMember]<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_complete =3D Fa=
lse<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;&gt; &gt; @@ -482,7 +482,11 @@ def check(self, schema):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for m in self.local_members=
:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.check(schem=
a)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.check_clash=
(<a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blan=
k">self.info</a>, seen)<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 members =3D seen.values()<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check_clash works in terms of =
the supertype, but local_members<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # is asserted to be List[QAPISch=
emaObjectTypeMember].<br>
&gt;&gt;<br>
&gt;&gt; Do you mean &quot;but self.members is declared as<br>
&gt;&gt; List[QAPISchemaObjectTypeMember]&quot;?<br>
&gt;<br>
&gt; Argh. I meant asserted in the linguistic sense. mypy asserts it to be;=
 not<br>
&gt; a runtime assertion.<br>
&gt;<br>
&gt; I do this a lot, apparently.<br>
<br>
Okay to adjust your comment to my version?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Absolutely, of course!</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000813b3d06139f4ca7--


