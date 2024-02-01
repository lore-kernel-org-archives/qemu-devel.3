Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67EFC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 19:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVcwi-00083h-VZ; Thu, 01 Feb 2024 14:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVcwf-00083S-2g
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 14:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVcwc-0008Mo-Ov
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 14:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706816511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSHOpL3Yu22f3jDnzKs6sgzx7uIdbyS9Xv1v4R3GPrk=;
 b=Ac4XsndooVA2tB9v0EHP0ZV8J08Eblp2M44tmvr726cK5nNeaIROvpy+qVKOxDfyUU2a10
 TfUE54me4J6J2RtlCkWTGDqI9rXMBoeJX+LAt85NooiWegBeSeon5rsowzjSOOGL5dv78t
 Ieyc+cQKg6j4bHrwNP439IPxKAtd2IY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-E-QgXkSrPb-c_B2TrPxW3g-1; Thu, 01 Feb 2024 14:41:50 -0500
X-MC-Unique: E-QgXkSrPb-c_B2TrPxW3g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-295e0640854so1096832a91.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 11:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706816509; x=1707421309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSHOpL3Yu22f3jDnzKs6sgzx7uIdbyS9Xv1v4R3GPrk=;
 b=Ul3YpqhhB9lGMhadS6mDeFO+NhnroJaH2laPbx/tyZfLkxMIz5fFHA/M4ogeu3IS2u
 3o4UyLJjIT95HFvBsTXJPyZlX0oehPi1Y1Qbb3AGTaUGwziYQ3LrKxG2nJqvzPtu5U/i
 t6+kv8K6WLaBg3g3KOnP6xh53Z3dvDRT6VQR8Fs5uiXBlYZj3hFY2OWqF1aBpM7KjYd+
 0wX/HldmwPuy69XF3EOp3jdI4OEa7YY2VG6lPghd/dK473ew6uyntuE94Fc2UlFZB4tc
 QJpmpGJfZyJqp9BLjHYRJrPYbpE5P/Za+bqWvIUoqp1mbXJy4JFqkgU8yBKI7smx7xmC
 8tDw==
X-Gm-Message-State: AOJu0YyzEWhWtxjGRjZ0MVYrvs9K+2cQbc1oAy2EcObh/9AW9Oj6rza2
 RsQ/qMUl20OezIjf1blr/XFWWLt36PzWFHOC4TfT5rYlY3lDScSuLDkUPifH1a6nZ1RtU/ov0Zp
 7JkABpK8DW2XVKKaKR+epsqsKOQ/DgxwOs3u+S/YiysOsVHpUyE7BBwlubSBljYhG9UWZ28jJGT
 lSVQr3H1ZllG4+UYAto5UbI57xFjI=
X-Received: by 2002:a17:90b:30f:b0:295:2a35:13b8 with SMTP id
 ay15-20020a17090b030f00b002952a3513b8mr36571pjb.0.1706816508995; 
 Thu, 01 Feb 2024 11:41:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWWFMX1r65Q6j9kUEVBjSuFxZQbyW1x7htyJxDLw0pNjqvb8xmMi7AWb5XKYkzU5slJ6Nx21X3FXMPLxYtvf4=
X-Received: by 2002:a17:90b:30f:b0:295:2a35:13b8 with SMTP id
 ay15-20020a17090b030f00b002952a3513b8mr36546pjb.0.1706816508576; Thu, 01 Feb
 2024 11:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-14-jsnow@redhat.com>
 <87o7dlqq96.fsf@pond.sub.org>
In-Reply-To: <87o7dlqq96.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 1 Feb 2024 14:41:36 -0500
Message-ID: <CAFn=p-ahu9L6A=JR0=Ug3em1hqqDhEaYYLpcW4uKeReqva9iNw@mail.gmail.com>
Subject: Re: [PATCH v2 13/19] qapi/schema: split "checked" field into
 "checking" and "checked"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 16, 2024 at 9:58=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > differentiate between "actively in the process of checking" and
> > "checking has completed". This allows us to clean up the types of some
> > internal fields such as QAPISchemaObjectType's members field which
> > currently uses "None" as a test for determining if check has been run
> > already or not.
> >
> > This simplifies the typing from a cumbersome Optional[List[T]] to merel=
y
> > a List[T], which is more pythonic: it is safe to iterate over an empty
> > list with "for x in []" whereas with an Optional[List[T]] you have to
> > rely on the more cumbersome "if L: for x in L: ..."
>
> Does this cumbersome form exist?

I thought it should, but I suppose it shouldn't given that you have
been relying on None to cause a crash.

Here's where that pattern *would* be used if None was legitimate:

qapi/schema.py:604: error: Item "None" of
"Optional[List[QAPISchemaObjectTypeMember]]" has no attribute
"__iter__" (not iterable)  [union-attr]
qapi/schema.py:626: error: Item "None" of
"Optional[List[QAPISchemaObjectTypeMember]]" has no attribute
"__iter__" (not iterable)  [union-attr]
qapi/gen.py:122: error: Item "None" of
"Optional[List[QAPISchemaObjectTypeMember]]" has no attribute
"__iter__" (not iterable)  [union-attr]
qapi/commands.py:68: error: Item "None" of
"Optional[List[QAPISchemaObjectTypeMember]]" has no attribute
"__iter__" (not iterable)  [union-attr]
qapi/events.py:60: error: Item "None" of
"Optional[List[QAPISchemaObjectTypeMember]]" has no attribute
"__iter__" (not iterable)  [union-attr]

but, I suppose your argument is that it just literally never is. So
never mind the callsite argument - though mypy still wants its
guarantee that it will never be None here.

>
> > Note that it is valid to have an empty members list, see the internal
> > q_empty object as an example.
>
> Yes.
>
> .members becomes valid only in .check().  Before the patch, .__init__()
> initializes it to None, and .check() sets it to the real value.  We use
> assert .members is not None to catch invalid use.  We can also hope
> invalid use without an assert would crash.  for m in .members would.
>

Mmm, I see. (I very often just literally don't account for you relying
on invalid types being load-bearing ... Seeing a stack trace where
you're told that "None" does not have such-and-such property usually
feels about as helpful as getting kicked out of a moving car on the
freeway.)

> We've seen this pattern before: PATCH 4+5.  There, we change .__init__()
> to declare the attribute without initializing it.  Use before it becomes
> valid now certainly crashes, which is an improvement.  Why can't we do
> the same here?

Didn't occur to me to add a crash on purpose... In the other cases, I
think I didn't have any suitable value to add at all, but in this case
I can use an empty list.

(I have a kind of distaste for relying on Python-level exceptions like
AttributeError to indicate that a stateful error has occurred - i.e.
that this attribute doesn't exist yet, but it will. I usually aim for
having all of the attributes defined at initialization time. The error
is misleading, semantically.

In our case, full initialization directly at init time is not ...
quite possible without some vigorous reworking of the known universe,
so I capitulated and allowed some "very late initialization" which
causes some friction for static typing between pre- and post- "delayed
initialization" callsites. It's still very much something I look at
and regard as a code smell. The entire point of declaring all state in
the init method is to centralize that state so it's finite and
knowable, both to static analysis tools and to humans. Punting the
initialization to arbitrary points later in the object's lifetime
feels like lying: we promise this value is here after initialization,
except not really, have a nice day.)

*cough* that said, I can also use that same trick here. I just want to
whine about it. (I guess I don't want to teach folks what I consider
to be a bad habit just because it makes the linters shut up, but
realize the sausage has to get made.)

... I *just* now saw you had more ideas on how to approach this in the
last series, I will go back and read them. I didn't mean to skip past
them. Lemme investigate.

>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index eefa58a798b..0d9a70ab4cb 100644
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
> > @@ -457,22 +457,24 @@ def __init__(self, name, info, doc, ifcond, featu=
res,
> >          self.base =3D None
> >          self.local_members =3D local_members
> >          self.variants =3D variants
> > -        self.members =3D None
> > +        self.members: List[QAPISchemaObjectTypeMember] =3D []
> > +        self._checking =3D False
> >
> >      def check(self, schema):
> >          # This calls another type T's .check() exactly when the C
> >          # struct emitted by gen_object() contains that T's C struct
> >          # (pointers don't count).
> > -        if self.members is not None:
> > -            # A previous .check() completed: nothing to do
> > -            return
> > -        if self._checked:
> > +        if self._checking:
> >              # Recursed: C struct contains itself
> >              raise QAPISemError(self.info,
> >                                 "object %s contains itself" % self.name=
)
> > +        if self._checked:
> > +            # A previous .check() completed: nothing to do
> > +            return
> >
> > +        self._checking =3D True
> >          super().check(schema)
> > -        assert self._checked and self.members is None
> > +        assert self._checked and not self.members
> >
> >          seen =3D OrderedDict()
> >          if self._base_name:
> > @@ -489,13 +491,17 @@ def check(self, schema):
> >          for m in self.local_members:
> >              m.check(schema)
> >              m.check_clash(self.info, seen)
> > -        members =3D seen.values()
> > +
> > +        # check_clash is abstract, but local_members is asserted to be
> > +        # List[QAPISchemaObjectTypeMember]. Cast to the narrower type.
> > +        members =3D cast(List[QAPISchemaObjectTypeMember], list(seen.v=
alues()))
> >
> >          if self.variants:
> >              self.variants.check(schema, seen)
> >              self.variants.check_clash(self.info, seen)
> >
> > -        self.members =3D members  # mark completed
> > +        self.members =3D members
> > +        self._checking =3D False  # mark completed
> >
> >      # Check that the members of this type do not cause duplicate JSON =
members,
> >      # and update seen to track the members seen so far. Report any err=
ors
>
> I think you missed these:
>
>        def is_empty(self):
>            assert self.members is not None
>            return not self.members and not self.variants
>
>        def has_conditional_members(self):
>            assert self.members is not None
>            return any(m.ifcond.is_present() for m in self.members)
>
> The assertions no longer work.  I figure you want to assert .checked
> instead.
>
> Consider splitting the patch: first add .checking, and replace use of
> .members by use of .checking where possible.  Then change .members.  The
> split may or may not be easier to describe and digest.  Use your
> judgement.

Ah, oops.

(I wish mypy would bark about this, actually: if members is a List,
then surely it can't ever be None, right? It's definitely a smell. I
wonder if there is a reason why it doesn't, or if this is a valid
feature request.)

--js


