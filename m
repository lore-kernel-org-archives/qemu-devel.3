Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78692C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 16:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkRvG-0004xM-Np; Wed, 13 Mar 2024 12:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkRvB-0004wx-Ei
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 12:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkRv5-00008U-E8
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 12:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710349054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hhbyUfz/EkYIMX7EpUs0AuKlPCWaPSJIiggT9d4G/k=;
 b=SI7e6VjtIOhKxhmYC1qKH1wcpzs9CuIc/pXiid7+izE+QvVeg467rB1AH0UDkVektVrgId
 p0ZYKahWxHwAmMXERtQxZF6psfNyVhw/HqiRnw5+TfLPuPCEFmR1Eakrm9MAh8zja7yH3T
 IZALQsqiM84+3byEJyCOjzWiFtsUwng=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-H36xzhO3PCqlbqvA1cPJVg-1; Wed, 13 Mar 2024 12:57:32 -0400
X-MC-Unique: H36xzhO3PCqlbqvA1cPJVg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29c718b7ff5so89318a91.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 09:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710349051; x=1710953851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6hhbyUfz/EkYIMX7EpUs0AuKlPCWaPSJIiggT9d4G/k=;
 b=hswIBX4G7vTD09+oqgpwADWP7uC0Ok0/Wnb9Bn1QqJkpyRgpE7KlfKL7n+61jWT03r
 ZwnqTupBj4D/nnUr0nVumdnT3oI2UbvUdtLEl5nxAcwBEvWQE7bAoif4B3SZar700Efz
 gr7zoJTRdJsVP7LEeOM7mh2WvaWEZWw33cXEsG5vVKbBI4dhV8/3AlnRgTrGk6jRx8CX
 42qPSc4bt8gtz73eqsBz4EhSj2RDSAmjQDgxgX6gGcCfur12XKP8B0tlmG23akcymVCi
 Pdhb8qlWHouNxYgvcf6qFd8UPb+8E++qI/G3gD2BB1PNjIP2G1eyCyuGivXnWhcmu6QU
 xZrg==
X-Gm-Message-State: AOJu0YzUEzNSoCEh+koDMuSwycp4xjFaqN7CnPSU3v2ouI7q5kIHxpmC
 M1xaf/BsdHIQWtVoFQ6mAqohCkVmXEha2mspdctxiJ+DNi5uTT7TKT3CCFlvM5a9inVm3rLvTzH
 ExlfQe6xLyo1Bwmj8fKQSlgNMPMmzv3jPwnbxUWw2q9+NKKsqHtLlSc/LEtjn/Y1PzhHniaAJyF
 c6KKRsVVvrLEbm8ydLXHpjF0bqjvE=
X-Received: by 2002:a17:90a:4096:b0:29b:7a28:a795 with SMTP id
 l22-20020a17090a409600b0029b7a28a795mr10958417pjg.12.1710349051271; 
 Wed, 13 Mar 2024 09:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr7IPQgfFEk/hWWrJi2k6lzuSG8JQY607cfG1cutImIfnLiszhKmJ4O/7XDCNQl2MZqWjMYcp7iWJoGpHnQY0=
X-Received: by 2002:a17:90a:4096:b0:29b:7a28:a795 with SMTP id
 l22-20020a17090a409600b0029b7a28a795mr10958399pjg.12.1710349050919; Wed, 13
 Mar 2024 09:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-15-jsnow@redhat.com>
 <87y1bf5g9x.fsf@pond.sub.org>
 <CAFn=p-Yb935TK-FmKtun+wWPjZjMYPOAivHOLUQK0hZr64Gh1w@mail.gmail.com>
 <87cyryipq1.fsf@pond.sub.org>
In-Reply-To: <87cyryipq1.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Mar 2024 12:57:19 -0400
Message-ID: <CAFn=p-anX6iURimxDp=e7-XsxgMeAL4OhfykTb9RUJOeHNxqOw@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] qapi/schema: Don't initialize "members" with
 `None`
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000009f595206138dab65"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
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

--0000000000009f595206138dab65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024, 2:57=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Feb 20, 2024 at 10:03=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com>
> wrote:
> >>
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
> >> > the _checked/_checking fields.)
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/schema.py | 13 +++++++------
> >> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> > index a459016e148..947e7efb1a8 100644
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
> >> > @@ -457,7 +457,7 @@ def __init__(self, name, info, doc, ifcond,
> features,
> >> >          self.base =3D None
> >> >          self.local_members =3D local_members
> >> >          self.variants =3D variants
> >> > -        self.members =3D None
> >> > +        self.members: List[QAPISchemaObjectTypeMember]
> >> >          self._checking =3D False
> >> >
> >> >      def check(self, schema):
> >> > @@ -474,7 +474,7 @@ def check(self, schema):
> >> >
> >> >          self._checking =3D True
> >> >          super().check(schema)
> >> > -        assert self._checked and self.members is None
> >> > +        assert self._checked
> >>
> >> This asserts state is "2. Being checked:.
> >>
> >> The faithful update would be
> >>
> >>            assert self._checked and self._checking
> >>
> >> Or with my alternative patch
> >>
> >>            assert self._checked and not self._check_complete
> >> >
> >> >          seen =3D OrderedDict()
> >> >          if self._base_name:
> >> > @@ -491,7 +491,10 @@ def check(self, schema):
> >> >          for m in self.local_members:
> >> >              m.check(schema)
> >> >              m.check_clash(self.info, seen)
> >> > -        members =3D seen.values()
> >> > +
> >> > +        # check_clash is abstract, but local_members is asserted to
> be
> >> > +        # List[QAPISchemaObjectTypeMember]. Cast to the narrower
> type.
> >>
> >> What do you mean by "check_clash is abstract"?
> >>
> >> > +        members =3D cast(List[QAPISchemaObjectTypeMember],
> list(seen.values()))
> >>
> >> Do we actually need this *now*, or only later when we have more type
> >> hints?
> >>
> >> >
> >> >          if self.variants:
> >> >              self.variants.check(schema, seen)
> >> > @@ -524,11 +527,9 @@ def is_implicit(self):
> >> >          return self.name.startswith('q_')
> >> >
> >> >      def is_empty(self):
> >> > -        assert self.members is not None
> >>
> >> This asserts state is "3. Checked".
> >>
> >> The faithful update would be
> >>
> >>            assert self._checked and not self._checking
> >>
> >> Or with my alternative patch
> >>
> >>            assert self._check_complete
> >>
> >> >          return not self.members and not self.variants
> >> >
> >> >      def has_conditional_members(self):
> >> > -        assert self.members is not None
> >>
> >> Likewise.
> >
> > Do we even need these assertions, though? If members isn't set, it's
> > gonna crash anyway. I don't think you actually need them at all. I
> > think it's fine to leave these changes in this patch and to remove the
> > assertion as it no longer really guards anything.
>
> When I wrote my review comment, my mind was running on "mechanical
> transformation" rails: "the faithful update would be".  The "in state 3"
> predicate is .members is not None before the patch, and ._check_complete
> afterwards.
>
> You're right, the assertion no longer guards.  It can at best aid
> understanding the code.  Feel free to drop it.
>

I did. I felt it was relevant here instead of in the drop assertions patch
(at the end of the series) because it wasn't doing type narrowing, it's
checking for a value that can truly not occur anymore as of this patch.


> Would it make sense to explain the transformation of the "in state N"
> predicates briefly in the commit message?
>

The wha...?

Oh, if you'd like your invariant analysis in the commit message, please be
my guest and add it with my blessing.


> >> >          return any(m.ifcond.is_present() for m in self.members)
> >> >
> >> >      def c_name(self):
> >>
> >> This patch does two things:
> >>
> >> 1. Replace test of self.members (enabled by the previous patch)
> >>
> >> 2. Drop initialization of self.members and simplify the typing
> >>
> >> Observation, not demand.  Wouldn't *mind* a split, though :)
> >>
> >
> > I think maybe one of the assertions can be replaced in the previous
> > patch, but I think everything else does really belong in this patch.
>
> My observation is that this patch could be split in two, not that parts
> of it belong to the previous patch.
>

What I did was change the assertions in the previous patch (including
moving one from this patch backwards one) such that comparisons to None are
nearly eliminated (the two assertions in is_empty and
has_conditional_members remain, however.)

then this patch:

- changes initialization to declaration by adding the type hint (and
removing the None initial value)
- adds the cast to the seen dict
- removes the two assertions

For mypy not to regress mid-series, I *believe* all of those above items
cannot be split. The patch has become pretty small...

(If you remove the None assertions in the two predicate methods, I think
you either run into a type checking problem *or* you just have a commit
that technically has a bug. Either way, it seems most cohesive to defer
that particular change.)

If you believe it is still semantically two changes, you're welcome to
adjust the commit message or attempt to split it yourself, but I don't
think I see what you do, sorry.

--js

--0000000000009f595206138dab65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Mar 13, 2024, 2:57=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; On Tue, Feb 20, 2024 at 10:03=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
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
&gt;&gt; &gt; the _checked/_checking fields.)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/schema.py | 13 +++++++------<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 7 insertions(+), 6 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<=
br>
&gt;&gt; &gt; index a459016e148..947e7efb1a8 100644<br>
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
&gt;&gt; &gt; @@ -457,7 +457,7 @@ def __init__(self, name, info, doc, ifcon=
d, features,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.base =3D None<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.local_members =3D loca=
l_members<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.variants =3D variants<=
br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members =3D None<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.members: List[QAPISchemaObj=
ectTypeMember]<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._checking =3D False<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def check(self, schema):<br>
&gt;&gt; &gt; @@ -474,7 +474,7 @@ def check(self, schema):<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._checking =3D True<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked and self.me=
mbers is None<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
&gt;&gt;<br>
&gt;&gt; This asserts state is &quot;2. Being checked:.<br>
&gt;&gt;<br>
&gt;&gt; The faithful update would be<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked and =
self._checking<br>
&gt;&gt;<br>
&gt;&gt; Or with my alternative patch<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked and =
not self._check_complete<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seen =3D OrderedDict()<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._base_name:<br>
&gt;&gt; &gt; @@ -491,7 +491,10 @@ def check(self, schema):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for m in self.local_members=
:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.check(schem=
a)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.check_clash=
(<a href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blan=
k">self.info</a>, seen)<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 members =3D seen.values()<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check_clash is abstract, but l=
ocal_members is asserted to be<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # List[QAPISchemaObjectTypeMembe=
r]. Cast to the narrower type.<br>
&gt;&gt;<br>
&gt;&gt; What do you mean by &quot;check_clash is abstract&quot;?<br>
&gt;&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 members =3D cast(List[QAPISchema=
ObjectTypeMember], list(seen.values()))<br>
&gt;&gt;<br>
&gt;&gt; Do we actually need this *now*, or only later when we have more ty=
pe<br>
&gt;&gt; hints?<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.variants:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.variants=
.check(schema, seen)<br>
&gt;&gt; &gt; @@ -524,11 +527,9 @@ def is_implicit(self):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.name.startswith=
(&#39;q_&#39;)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def is_empty(self):<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.members is not None<=
br>
&gt;&gt;<br>
&gt;&gt; This asserts state is &quot;3. Checked&quot;.<br>
&gt;&gt;<br>
&gt;&gt; The faithful update would be<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked and =
not self._checking<br>
&gt;&gt;<br>
&gt;&gt; Or with my alternative patch<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._check_comple=
te<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return not self.members and=
 not self.variants<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def has_conditional_members(self):<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.members is not None<=
br>
&gt;&gt;<br>
&gt;&gt; Likewise.<br>
&gt;<br>
&gt; Do we even need these assertions, though? If members isn&#39;t set, it=
&#39;s<br>
&gt; gonna crash anyway. I don&#39;t think you actually need them at all. I=
<br>
&gt; think it&#39;s fine to leave these changes in this patch and to remove=
 the<br>
&gt; assertion as it no longer really guards anything.<br>
<br>
When I wrote my review comment, my mind was running on &quot;mechanical<br>
transformation&quot; rails: &quot;the faithful update would be&quot;.=C2=A0=
 The &quot;in state 3&quot;<br>
predicate is .members is not None before the patch, and ._check_complete<br=
>
afterwards.<br>
<br>
You&#39;re right, the assertion no longer guards.=C2=A0 It can at best aid<=
br>
understanding the code.=C2=A0 Feel free to drop it.<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">I did. I felt it was rel=
evant here instead of in the drop assertions patch (at the end of the serie=
s) because it wasn&#39;t doing type narrowing, it&#39;s checking for a valu=
e that can truly not occur anymore as of this patch.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
Would it make sense to explain the transformation of the &quot;in state N&q=
uot;<br>
predicates briefly in the commit message?<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">The wha...?</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Oh, if you&#39;d like your invariant analysis =
in the commit message, please be my guest and add it with my blessing.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return any(m.ifcond.is_pres=
ent() for m in self.members)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def c_name(self):<br>
&gt;&gt;<br>
&gt;&gt; This patch does two things:<br>
&gt;&gt;<br>
&gt;&gt; 1. Replace test of self.members (enabled by the previous patch)<br=
>
&gt;&gt;<br>
&gt;&gt; 2. Drop initialization of self.members and simplify the typing<br>
&gt;&gt;<br>
&gt;&gt; Observation, not demand.=C2=A0 Wouldn&#39;t *mind* a split, though=
 :)<br>
&gt;&gt;<br>
&gt;<br>
&gt; I think maybe one of the assertions can be replaced in the previous<br=
>
&gt; patch, but I think everything else does really belong in this patch.<b=
r>
<br>
My observation is that this patch could be split in two, not that parts<br>
of it belong to the previous patch.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">What I did was change the assertions in =
the previous patch (including moving one from this patch backwards one) suc=
h that comparisons to None are nearly eliminated (the two assertions in is_=
empty and has_conditional_members remain, however.)</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">then this patch:</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">- changes initialization to declaration by adding the =
type hint (and removing the None initial value)</div><div dir=3D"auto">- ad=
ds the cast to the seen dict</div><div dir=3D"auto">- removes the two asser=
tions</div><div dir=3D"auto"><br></div><div dir=3D"auto">For mypy not to re=
gress mid-series, I *believe* all of those above items cannot be split. The=
 patch has become pretty small...</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">(If you remove the None assertions in the two predicate methods, =
I think you either run into a type checking problem *or* you just have a co=
mmit that technically has a bug. Either way, it seems most cohesive to defe=
r that particular change.)</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">If you believe it is still semantically two changes, you&#39;re welcome =
to adjust the commit message or attempt to split it yourself, but I don&#39=
;t think I see what you do, sorry.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">--js</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000009f595206138dab65--


