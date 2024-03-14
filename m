Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31938C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 13:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rklG4-0001ej-0b; Thu, 14 Mar 2024 09:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rklFw-0001dl-Ce
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rklFu-0000IY-Fu
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710423379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Ky7gdeCawCKuyeUy6fxlWATfKiw5Vr9F7HpaMZyVAI=;
 b=LaIexcLLmu7sGnCiHsTrTJXifSgu01elpmPj4vepnS+adK406qIXXgJ30OaXKdQGN7C9x8
 ksxwX2rVhAAR/Dogn4C6dfYgB5tq/A/Gx1Ahnzr41Ip6gEPY7Oc81NwiXtO34rgx81tjpK
 zBoTfFijiOYQ/PUfE6I3mfJ7ebMS0E4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-PuUpRGCrN6C2KxWK4Y1kkA-1; Thu, 14 Mar 2024 09:36:13 -0400
X-MC-Unique: PuUpRGCrN6C2KxWK4Y1kkA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5ce63e72bc3so773918a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 06:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710423371; x=1711028171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Ky7gdeCawCKuyeUy6fxlWATfKiw5Vr9F7HpaMZyVAI=;
 b=fYnJibon8tJ6vndkio1AOiz2uJ+14RRnCSOMgyPef27ar5vy0y+6sL1Pn6T3jqzvxm
 Fz1fR9a5FHfKMQewWq9fCtxBwfq2oQ7DmcrgBWVM/3EgqkrYFJ2XJIs27AfXdSgFfEfZ
 fAkpTGV75UUBKEoQMnhp8NuBvNLodUyDun6ezoKc/oFSNc+b/oU9kPSLAXzTKWAXzAo0
 WksG/C2mQFwnjs8lmTxFUikXHgv7rM4JU0/hp6yLCc7E62EBV1aq9j6jskf4yZ01XvM9
 JIRGiCMg6kNlX7pMcBr7cY0z/H5rKtWpDVXDK+Aal3Mp475wS3adzQ2ZpPj+Rt2O/uAr
 rtbA==
X-Gm-Message-State: AOJu0YzUD0ltStBPuTVAz+WxliPW22MGbsoF1ulfkkSftgceE/D3Xsf0
 FpU+90Qzn9RxYllBpeDdeI4XH+XY9vZzw/7PQ0bp7+0a4XGgVz26vcDdrAu23usvKJMuYqzjDRt
 JoJL4Rhq4HAfkIzmru553PCx4CYhakIk5+DVIz7xPpQpWPRS6WTh4UfxJ8Dkwf0fbaOSminkBxR
 uswisQrbluNsDVA+neDC14CuovaQSjvG4DlPc=
X-Received: by 2002:a17:903:2291:b0:1db:cb13:10f1 with SMTP id
 b17-20020a170903229100b001dbcb1310f1mr1891987plh.19.1710423371180; 
 Thu, 14 Mar 2024 06:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhjxPmYqgUh7mUTb5lP/btqMxfY/fX7ryEkh1ZbelvWasNpxs7d2FmF48/sR+pdRlezmrnzXEDnlkIXs/3JCI=
X-Received: by 2002:a17:903:2291:b0:1db:cb13:10f1 with SMTP id
 b17-20020a170903229100b001dbcb1310f1mr1891961plh.19.1710423370911; Thu, 14
 Mar 2024 06:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-17-jsnow@redhat.com>
 <87a5n19dce.fsf@pond.sub.org>
In-Reply-To: <87a5n19dce.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 14 Mar 2024 09:35:59 -0400
Message-ID: <CAFn=p-Z9Y_wOn8H9qusrD8vHsvyseEZfLn67uo4JpMgjzt9-yQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/23] qapi/schema: Don't initialize "members" with
 `None`
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000706e5e06139ef9ac"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000706e5e06139ef9ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024, 9:01=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Declare, but don't initialize the "members" field with type
> > List[QAPISchemaObjectTypeMember].
> >
> > This simplifies the typing from what would otherwise be
> > Optional[List[T]] to merely List[T]. This removes the need to add
> > assertions to several callsites that this value is not None - which it
> > never will be after the delayed initialization in check() anyway.
> >
> > The type declaration without initialization trick will cause accidental
> > uses of this field prior to full initialization to raise an
> > AttributeError.
> >
> > (Note that it is valid to have an empty members list, see the internal
> > q_empty object as an example. For this reason, we cannot use the empty
> > list as a replacement test for full initialization and instead rely on
> > the _checked/_check_complete fields.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 50ebc4f12de..fb30314741a 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -20,7 +20,7 @@
> >  from collections import OrderedDict
> >  import os
> >  import re
> > -from typing import List, Optional
> > +from typing import List, Optional, cast
> >
> >  from .common import (
> >      POINTER_SUFFIX,
> > @@ -449,7 +449,7 @@ def __init__(self, name, info, doc, ifcond, feature=
s,
> >          self.base =3D None
> >          self.local_members =3D local_members
> >          self.variants =3D variants
> > -        self.members =3D None
> > +        self.members: List[QAPISchemaObjectTypeMember]
> >          self._check_complete =3D False
> >
> >      def check(self, schema):
> > @@ -482,7 +482,11 @@ def check(self, schema):
> >          for m in self.local_members:
> >              m.check(schema)
> >              m.check_clash(self.info, seen)
> > -        members =3D seen.values()
> > +
> > +        # check_clash works in terms of the supertype, but local_membe=
rs
> > +        # is asserted to be List[QAPISchemaObjectTypeMember].
>
> Do you mean "but self.members is declared as
> List[QAPISchemaObjectTypeMember]"?
>

Argh. I meant asserted in the linguistic sense. mypy asserts it to be; not
a runtime assertion.

I do this a lot, apparently.


> > +        # Cast down to the subtype.
> > +        members =3D cast(List[QAPISchemaObjectTypeMember],
> list(seen.values()))
>
> Let's break the line after the comma.
>

Go for it.

After this series I may send a patchset showing what changes black would
make. I cannot be trusted with aesthetic consistency.


> >
> >          if self.variants:
> >              self.variants.check(schema, seen)
> > @@ -515,11 +519,9 @@ def is_implicit(self):
> >          return self.name.startswith('q_')
> >
> >      def is_empty(self):
> > -        assert self.members is not None
> >          return not self.members and not self.variants
> >
> >      def has_conditional_members(self):
> > -        assert self.members is not None
> >          return any(m.ifcond.is_present() for m in self.members)
> >
> >      def c_name(self):
>
>

--000000000000706e5e06139ef9ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Mar 14, 2024, 9:01=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Declare, but don&#39;t initialize the &quot;members&quot; field with t=
ype<br>
&gt; List[QAPISchemaObjectTypeMember].<br>
&gt;<br>
&gt; This simplifies the typing from what would otherwise be<br>
&gt; Optional[List[T]] to merely List[T]. This removes the need to add<br>
&gt; assertions to several callsites that this value is not None - which it=
<br>
&gt; never will be after the delayed initialization in check() anyway.<br>
&gt;<br>
&gt; The type declaration without initialization trick will cause accidenta=
l<br>
&gt; uses of this field prior to full initialization to raise an<br>
&gt; AttributeError.<br>
&gt;<br>
&gt; (Note that it is valid to have an empty members list, see the internal=
<br>
&gt; q_empty object as an example. For this reason, we cannot use the empty=
<br>
&gt; list as a replacement test for full initialization and instead rely on=
<br>
&gt; the _checked/_check_complete fields.)<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py | 12 +++++++-----<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index 50ebc4f12de..fb30314741a 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
&gt; @@ -20,7 +20,7 @@<br>
&gt;=C2=A0 from collections import OrderedDict<br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 import re<br>
&gt; -from typing import List, Optional<br>
&gt; +from typing import List, Optional, cast<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from .common import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 POINTER_SUFFIX,<br>
&gt; @@ -449,7 +449,7 @@ def __init__(self, name, info, doc, ifcond, featur=
es,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.base =3D None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.local_members =3D local_members=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.variants =3D variants<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members =3D None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members: List[QAPISchemaObjectTypeMe=
mber]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_complete =3D False<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt; @@ -482,7 +482,11 @@ def check(self, schema):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for m in self.local_members:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.check(schema)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.check_clash(<a href=
=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.=
info</a>, seen)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 members =3D seen.values()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check_clash works in terms of the super=
type, but local_members<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # is asserted to be List[QAPISchemaObject=
TypeMember].<br>
<br>
Do you mean &quot;but self.members is declared as<br>
List[QAPISchemaObjectTypeMember]&quot;?<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Argh. I meant asserted in the lingui=
stic sense. mypy asserts it to be; not a runtime assertion.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I do this a lot, apparently.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Cast down to the subtype.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 members =3D cast(List[QAPISchemaObjectTyp=
eMember], list(seen.values()))<br>
<br>
Let&#39;s break the line after the comma.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Go for it.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">After this series I may send a patchset showing=
 what changes black would make. I cannot be trusted with aesthetic consiste=
ncy.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.variants:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.variants.check(sc=
hema, seen)<br>
&gt; @@ -515,11 +519,9 @@ def is_implicit(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.name.startswith(&#39;q_&=
#39;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def is_empty(self):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.members is not None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return not self.members and not self=
.variants<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def has_conditional_members(self):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.members is not None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return any(m.ifcond.is_present() for=
 m in self.members)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def c_name(self):<br>
<br>
</blockquote></div></div></div>

--000000000000706e5e06139ef9ac--


