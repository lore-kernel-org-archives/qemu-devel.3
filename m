Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3889C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9P3-0005j8-IY; Tue, 12 Mar 2024 17:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rk9Oz-0005et-JR
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rk9Ox-0006xR-CC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710277867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAC/hQVd+BgLEfLHLjFjY+1sZ/TPmabImYE1vW7OCSE=;
 b=IFMGEl9a3WS3UaGCtmuvx2lsFxLHjQ2o4P0WBcXbGjHBF2/hDP1kAVOpId7vL7tduJvMn9
 hIZi52XDa1XLvOI8rZzaEaUCZQx2nwpPcyK5O3H0+UjMqvEFVtQ1C32gTNeoA2tJEYqiHF
 gVxt8amffE9+t4XVInPIZEogUx60zbQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-vg4ZruuNOxKHc3LrPpz4uA-1; Tue, 12 Mar 2024 17:11:05 -0400
X-MC-Unique: vg4ZruuNOxKHc3LrPpz4uA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cfd6ba1c11so4531562a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710277865; x=1710882665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAC/hQVd+BgLEfLHLjFjY+1sZ/TPmabImYE1vW7OCSE=;
 b=h/DA/C84hom+sN3yU5CIb/BA1wlmiZ1zg9OeBM8ffwrO+E2BfWDlXt92znDrfGmthf
 lrTwFsPkwUll/kJvJzKgq3Cv+RFsBaa8wIpOFZkCFcxSsYLSfJOrwtqlcLmeZ54B8MAY
 b9x9jZqmVGtD//TG/pQN0X3SJ5EJdQBxsgXyTAXXyY4Ykp3wu/TnNCpHm7nddyplhxz+
 fAaJJ/UtX7PBZaSaolA2sxGoWsqpwyLlH9E58OzTjCgPAHO2TIh51Yj+lHsblZgkHdaq
 SmIiIuEe34MNSv/qL3E5q96RfNKqhYrY695GUeWtZdP/OcEgqmiLWG0Lk/bwEiStOgLp
 Xh2w==
X-Gm-Message-State: AOJu0Yw0YmVDz40klMJiMd0Ct5Ny9yPAtRrwkQ1yuEGTCcFuVa4rdFcM
 DR9sEC54l7M+CABVZFHKV/17wzwtysvRJ/CZTVmqkc+qiRzoUJXf1mFnGlRG9uFMVsb9XcVhmEk
 neYiNKcbSIoicD1FGAOYGF/35OXh+RUH/nq9nAZpNSLhUEbBcptNVtn2vseCcP4/kvr4bE0IkQv
 XGnDlKpfa0qbxeGY4m/I7BUVfByhY=
X-Received: by 2002:a05:6a20:160b:b0:1a3:152b:99f2 with SMTP id
 l11-20020a056a20160b00b001a3152b99f2mr3421240pzj.2.1710277864870; 
 Tue, 12 Mar 2024 14:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaWFzXH3UbfcxphGiW8cayAEirJRMd9V/PcoSU68gwyGuByB5xQC6QTz8uv+9Jy76IeGwhkyXFXpim9pcT2ZM=
X-Received: by 2002:a05:6a20:160b:b0:1a3:152b:99f2 with SMTP id
 l11-20020a056a20160b00b001a3152b99f2mr3421221pzj.2.1710277864534; Tue, 12 Mar
 2024 14:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-15-jsnow@redhat.com>
 <87y1bf5g9x.fsf@pond.sub.org>
In-Reply-To: <87y1bf5g9x.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Mar 2024 17:10:53 -0400
Message-ID: <CAFn=p-Yb935TK-FmKtun+wWPjZjMYPOAivHOLUQK0hZr64Gh1w@mail.gmail.com>
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

Do we even need these assertions, though? If members isn't set, it's
gonna crash anyway. I don't think you actually need them at all. I
think it's fine to leave these changes in this patch and to remove the
assertion as it no longer really guards anything.

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

I think maybe one of the assertions can be replaced in the previous
patch, but I think everything else does really belong in this patch.

--js


