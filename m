Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2735C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9Ua-0000sd-8N; Tue, 12 Mar 2024 17:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rk9UW-0000rq-Vs
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rk9UV-00086B-Ac
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710278214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SbY+F1hf4r/Vionj9YUSuaZusp+wLF4MH41cp5w5kyY=;
 b=NhbcTbx4BhuItt6m50t3Wkjfpp7LkXvcoMpBs2hJ/hPnnch6Pw3Ln3EUdnQVtm+2qticLZ
 +E+xXugwjpBiNFNYTOByw7CwRh9OfTtKQbUeMVdV0wxXwcvR9ves3adYBl0xm5BfKaKGaa
 MX+jvefFDVy62wL8TrpYWGqoS5j5Ibc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-UUFmK5c-P3-vvNso7ygQWA-1; Tue, 12 Mar 2024 17:16:53 -0400
X-MC-Unique: UUFmK5c-P3-vvNso7ygQWA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-299c7e32642so4070158a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710278212; x=1710883012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbY+F1hf4r/Vionj9YUSuaZusp+wLF4MH41cp5w5kyY=;
 b=Xkn3CiM677e4mFcOvjJbLwXJVP0GMeFCu6xqfAJBu8h0Fl2bS4SjmPuFxl1N9QFBub
 w3/q4DCIBV6wDKDYipJJhbaqxahDrpV4iiNONFQIXjO128WmB8NKnz+Hw4rfT/WQ0pho
 4fjPKHlR27azt6CvF768SH0GL/7+iFx0EgJZrzSjcroRD3h7Jpxli0u2F1JktEYGDG4Z
 OnRDXoK/BOHE2XKidK8/6jJQTgJ7KulpOmlC/GKLKWhZrdtHtZLT6w6sKD86z+K9gGjU
 YNJ8sn5KzYuBfSTALLtgMNwqwGzEYs+6P9cUpbZPqzgityCbEBC4zR3u4wBJybu6EU6c
 Pn9g==
X-Gm-Message-State: AOJu0Yxcfv1ZLenWdXhPZxDwUAfay57f3Bl5PshGxAi8iIJDRAeRsrE/
 +kIUl9PLdqNettXkTUF8L/L9HvrR7SQWwO3gW+TommmGiQm+BUNVbz7zfDtruoLzQYl58mzlUCt
 yYSP58K4wwRc8puTf8J60veyEu0gqLKP/n3KJApC0PAmiqXcDw6jp94W7dtSYSlZbIDvH7VkJIh
 G6NMJbiuEtTEZD35KrI4Xl8Jd7gWE=
X-Received: by 2002:a17:90a:ea88:b0:29b:f981:1363 with SMTP id
 h8-20020a17090aea8800b0029bf9811363mr1627369pjz.5.1710278211942; 
 Tue, 12 Mar 2024 14:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4iUIs0pICIKHAfDGMsYbZoBJ6tPUGSjDKY0wOs2iqemrW3jUrs+uYd45xyZXb24hkY7XW1K/PWESNY55hGnA=
X-Received: by 2002:a17:90a:ea88:b0:29b:f981:1363 with SMTP id
 h8-20020a17090aea8800b0029bf9811363mr1627356pjz.5.1710278211564; Tue, 12 Mar
 2024 14:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-15-jsnow@redhat.com>
 <87y1bf5g9x.fsf@pond.sub.org>
In-Reply-To: <87y1bf5g9x.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Mar 2024 17:16:39 -0400
Message-ID: <CAFn=p-b57kMtG9dQZz6TNrMXOKVGZgF3wDx-NciV38sedpRxRQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] qapi/schema: Don't initialize "members" with
 `None`
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 20, 2024 at 10:03=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
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
> > the _checked/_checking fields.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index a459016e148..947e7efb1a8 100644
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
> > @@ -457,7 +457,7 @@ def __init__(self, name, info, doc, ifcond, feature=
s,
> >          self.base =3D None
> >          self.local_members =3D local_members
> >          self.variants =3D variants
> > -        self.members =3D None
> > +        self.members: List[QAPISchemaObjectTypeMember]
> >          self._checking =3D False
> >
> >      def check(self, schema):
> > @@ -474,7 +474,7 @@ def check(self, schema):
> >
> >          self._checking =3D True
> >          super().check(schema)
> > -        assert self._checked and self.members is None
> > +        assert self._checked
>
> This asserts state is "2. Being checked:.
>
> The faithful update would be
>
>            assert self._checked and self._checking
>
> Or with my alternative patch
>
>            assert self._checked and not self._check_complete
> >
> >          seen =3D OrderedDict()
> >          if self._base_name:
> > @@ -491,7 +491,10 @@ def check(self, schema):
> >          for m in self.local_members:
> >              m.check(schema)
> >              m.check_clash(self.info, seen)
> > -        members =3D seen.values()
> > +
> > +        # check_clash is abstract, but local_members is asserted to be
> > +        # List[QAPISchemaObjectTypeMember]. Cast to the narrower type.
>
> What do you mean by "check_clash is abstract"?
>
> > +        members =3D cast(List[QAPISchemaObjectTypeMember], list(seen.v=
alues()))
>
> Do we actually need this *now*, or only later when we have more type
> hints?

We need it now: to declare members without initializing it, I need to
declare a type. May as well choose the correct one. This assignment
needs to be the correct type.

>
> >
> >          if self.variants:
> >              self.variants.check(schema, seen)
> > @@ -524,11 +527,9 @@ def is_implicit(self):
> >          return self.name.startswith('q_')
> >
> >      def is_empty(self):
> > -        assert self.members is not None
>
> This asserts state is "3. Checked".
>
> The faithful update would be
>
>            assert self._checked and not self._checking
>
> Or with my alternative patch
>
>            assert self._check_complete
>
> >          return not self.members and not self.variants
> >
> >      def has_conditional_members(self):
> > -        assert self.members is not None
>
> Likewise.
>
> >          return any(m.ifcond.is_present() for m in self.members)
> >
> >      def c_name(self):
>
> This patch does two things:
>
> 1. Replace test of self.members (enabled by the previous patch)
>
> 2. Drop initialization of self.members and simplify the typing
>
> Observation, not demand.  Wouldn't *mind* a split, though :)
>


