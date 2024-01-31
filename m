Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7649EC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 22:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVJ4h-0006Ym-C6; Wed, 31 Jan 2024 17:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVJ4f-0006YP-O8
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 17:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVJ4d-0007uY-In
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 17:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706740130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhv/417WVeacha0HUCinD8kbRwXZ9AQFyl2iZk9brq0=;
 b=WBwWNqhmeFu+OtTvJqJfFHwIrW53NQT9LCjGEFIVX7v3ExxhILJY/5oupDgCktaZToC5O5
 fU4Hwa8ipmOQ1b0xxAFrjj2beyP4ZvVrfYS8//WkrHQMhZjQFzqyWFJO88AlSLm48i0GdQ
 7Zwg2xm/LmIuy2JCdAsnbLep6+rhVVM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-NcHmnhKoNwuRxES0qBWrog-1; Wed, 31 Jan 2024 17:28:48 -0500
X-MC-Unique: NcHmnhKoNwuRxES0qBWrog-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5d8dbe37d56so339768a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 14:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706740127; x=1707344927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhv/417WVeacha0HUCinD8kbRwXZ9AQFyl2iZk9brq0=;
 b=f6qyAW+GzS9LQ2e2zSh7U0/GzPiIMHf5jQsdODs4sAjsnNQ6J9gn4L80bjNKe5c8ZM
 Yd3MZbNRKsGkU6n94AP9rf7GzqkVpvx3A9KTGydTYkoU9uy+jreqj6F0ZYoOs/Y3h+nD
 Wj0TUq1gfEgP8uYf4BU3s9NowX/LGiQ/YUSTqyJ+DtwRMED5EvWdEbywcQ92I4+dCSHk
 kj8AA2Ve6XXdZF9cSPJ0hN97vuhj7JZVNxg6RkeRowLkaLp6hrSZ+Jz9Q/V7+UAx+Wf2
 /aHjbcTyB8llWOo4sLlNOFxxgCQVTv2LcLLJVSRjpJfBM4ouEB73UUhkZDOsHU/hn8XB
 x8NQ==
X-Gm-Message-State: AOJu0Yxb54uasclfA2cAwi8QCj8RhBLKqO738Agg1Z4/XzwTk53RmbN1
 H1HPd0Qi0USO0n+NV0D7ghkuUqmwoHYj4VkYw0UrTkP2WBN0/NPalzAys7kHObUw9jQA/auAG4w
 IsxECFb7cr8PK4qPAkmhtXb1yztwpKyc2ZrnDuCm1jmt6rbDo/tnr0ucow22d+DPGT3D96FI8oZ
 joKPf5DPCNNRDrmQxqNsXrKpJF0cA=
X-Received: by 2002:a17:90a:7342:b0:296:1ef:a763 with SMTP id
 j2-20020a17090a734200b0029601efa763mr344559pjs.23.1706740127200; 
 Wed, 31 Jan 2024 14:28:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy4683cC0LBFAYJk+LRz5nXVk8WhCtudGpx0LuBW9Ao+ybB0GJBcwAivVnMsHC3VfsysgHX+IZDzr9mT8UyUo=
X-Received: by 2002:a17:90a:7342:b0:296:1ef:a763 with SMTP id
 j2-20020a17090a734200b0029601efa763mr344537pjs.23.1706740126596; Wed, 31 Jan
 2024 14:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-10-jsnow@redhat.com>
 <87cyu15yc2.fsf@pond.sub.org>
 <CAFn=p-YTYuRsSLPS7A46Esq-R-OZDPFNKo8QHc4caTRv-NmC_A@mail.gmail.com>
 <87zfwxikay.fsf@pond.sub.org>
In-Reply-To: <87zfwxikay.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 31 Jan 2024 17:28:35 -0500
Message-ID: <CAFn=p-bOip94huHje0RBfMWP48wWEmv0JyJ7V+VSOUf+paXZkQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] qapi/schema: allow resolve_type to be used for
 built-in types
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 22, 2024 at 8:12=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Jan 16, 2024 at 6:09=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > allow resolve_type to be used for both built-in and user-specified
> >> > type definitions. In the event that the type cannot be resolved, ass=
ert
> >> > that 'info' and 'what' were both provided in order to create a usabl=
e
> >> > QAPISemError.
> >> >
> >> > In practice, 'info' will only be None for built-in definitions, whic=
h
> >> > *should not fail* type lookup.
> >> >
> >> > As a convenience, allow the 'what' and 'info' parameters to be elide=
d
> >> > entirely so that it can be used as a can-not-fail version of
> >> > lookup_type.
> >>
> >> The convenience remains unused until the next patch.  It should be add=
ed
> >> there.
> >
> > Okie-ducky.
> >
> >>
> >> > Note: there are only three callsites to resolve_type at present wher=
e
> >> > "info" is perceived to be possibly None:
> >> >
> >> >     1) QAPISchemaArrayType.check()
> >> >     2) QAPISchemaObjectTypeMember.check()
> >> >     3) QAPISchemaEvent.check()
> >> >
> >> >     Of those three, only the first actually ever passes None;
> >>
> >> Yes.  More below.
> >
> > Scary...
>
> I know...
>
> >> >                                                               the ot=
her two
> >> >     are limited by their base class initializers which accept info=
=3DNone, but
> >>
> >> They do?
> >
> > In the case of QAPISchemaObjectTypeMember, the parent class
> > QAPISchemaMember allows initialization with info=3DNone. I can't fully
> > trace all of the callsites, but one of them at least is in types.py:
> >
> >>     enum_members =3D members + [QAPISchemaEnumMember('_MAX', None)]
>
> I see.
>
> We may want to do the _MAX thingy differently.  Not now.
>
> > which necessitates, for now, info-less QAPISchemaEnumMember, which
> > necessitates info-less QAPISchemaMember. There are others, etc.
>
> Overriding an inherited attribute of type Optional[T] so it's
> non-optional T makes mypy unhappy?

Yeah, it considers it to be improper OO - it remembers only the
broadest type from the base class, which is Optional[T]. We aren't
overriding the property itself, we've just redefined a different
initializer, which doesn't carry through to the actual object.

(i.e. the initializer takes a T, the core object has an Optional[T],
there's no problem - but the field remains Optional[T].)

>
> >> >     neither actually use it in practice.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >>
> >> Hmm.
> >
> > Scary.
> >
> >>
> >> We look up types by name in two ways:
> >>
> >> 1. Failure is a semantic error
> >>
> >>    Use .resolve_type(), passing real @info and @what.
> >>
> >>    Users:
> >>
> >>    * QAPISchemaArrayType.check() resolving the element type
> >>
> >>      Fine print: when the array type is built-in, we pass None @info a=
nd
> >>      @what.  The built-in array type's element type must exist for
> >>      .resolve_type() to work.  This commit changes .resolve_type() to
> >>      assert it does.
> >>
> >>    * QAPISchemaObjectType.check() resolving the base type
> >>
> >>    * QAPISchemaObjectTypeMember.check() resolving the member type
> >>
> >>    * QAPISchemaCommand.check() resolving argument type (if named) and
> >>      return type (which is always named).
> >>
> >>    * QAPISchemaEvent.check() resolving argument type (if named).
> >>
> >>    Note all users are in .check() methods.  That's where type named ge=
t
> >>    resolved.
> >>
> >> 2. Handle failure
> >>
> >>    Use .lookup_type(), which returns None when the named type doesn't
> >>    exist.
> >>
> >>    Users:
> >>
> >>    * QAPISchemaVariants.check(), to look up the base type containing t=
he
> >>      tag member for error reporting purposes.  Failure would be a
> >>      programming error.
> >>
> >>    * .resolve_type(), which handles failure as semantic error
> >>
> >>    * ._make_array_type(), which uses it as "type exists already"
> >>       predicate.
> >>
> >>    * QAPISchemaGenIntrospectVisitor._use_type(), to look up certain
> >>      built-in types.  Failure would be a programming error.
> >>
> >> The next commit switches the uses where failure would be a programming
> >> error from .lookup_type() to .resolve_type() without @info and @what, =
so
> >> failure trips its assertion.  I don't like it, because it overloads
> >> .resolve_type() to serve two rather different use cases:
> >>
> >> 1. Failure is a semantic error; pass @info and @what
> >>
> >> 2. Failure is a programming error; don't pass @info and what
> >>
> >> The odd one out is of course QAPISchemaArrayType.check(), which wants =
to
> >> use 1. for the user's types and 2. for built-in types.  Let's ignore i=
t
> >> for a second.
> >
> > "Let's ignore what motivated this patch" aww...
>
> Just for a second, I swear!
>
> >> I prefer to do 2. like typ =3D .lookup_type(); assert typ.  We can fac=
tor
> >> this out into its own helper if that helps (pardon the pun).
> >>
> >> Back to QAPISchemaArrayType.check().  Its need to resolve built-in
> >> element types, which have no info, necessitates .resolve_type() taking
> >> Optional[QAPISourceInfo].  This might bother you.  It doesn't bother m=
e,
> >> unless it leads to mypy complications I can't see.
> >
> > Well, with this patch I allowed it to take Optional[QAPISourceInfo] -
> > just keep in mind that QAPISemError *requires* an info object, even
> > though the typing there is also Optional[QAPISourceInfo] ... It will
> > assert that info is present in __str__.
> >
> > Actually, I'd love to change that too - and make it fully required -
> > but since built-in types have no info, there's too many places I'd
> > need to change to enforce this as a static type.
> >
> > Still.
>
> Invariant: no error reports for built-in types.
>
> Checked since forever by asserting info is not None, exploiting the fact
> that info is None exactly for built-in types.
>
> This makes info: Optional[QAPISourceInfo] by design.
>
> Works.
>
> Specializing it to just QAPISourceInfo moves the assertion check from
> run time to compile time.  Might give a nice feeling, but I don't think
> it's practical everywhere, and it doesn't really matter anyway.
>
> Using a special value of QAPISourceInfo instead of None would also get
> rid of the Optional, along with the potential of checking at compile
> time.  Good trade *if* it simplifies the code.  See also the very end of
> my reply.
>
> >> We can simply leave it as is.  Adding the assertion to .resolve_type()
> >> is fine.
> >>
> >> Ot we complicate QAPISchemaArrayType.check() to simplify
> >> .resolve_type()'s typing, roughly like this:
> >>
> >>             if self.info:
> >>                 self.element_type =3D schema.resolve_type(
> >>                     self._element_type_name,
> >>                     self.info, self.info.defn_meta)
> >>             else:               # built-in type
> >>                 self.element_type =3D schema.lookup_type(
> >>                     self._element_type_name)
> >>                 assert self.element_type
> >>
> >> Not sure it's worth the trouble.  Thoughts?
> >
> > I suppose it's your call, ultimately. This patch exists primarily to
> > help in two places:
> >
> > (A) QAPISchemaArrayType.check(), as you've noticed, because it uses
> > the same path for both built-in and user-defined types. This is the
> > only place in the code where this occurs *at the moment*, but I can't
> > predict the future.
> >
> > (B) Calls to lookup_type in introspect.py which look up built-in types
> > and must-not-fail. It was cumbersome in the old patchset, but this one
> > makes it simpler.
> >
> > I suppose at the moment, having the assert directly in resolve_type
> > just means we get to use the same helper/pathway for both user-defined
> > and built-in types, which matches the infrastructure we already have,
> > which doesn't differentiate between the two. (By which I mean, all of
> > the Schema classes are not split into built-in and user-defined types,
> > so it is invisible to the type system.)
>
> Yes.
>
> > I could add conditional logic to the array check, and leave the
> > lookup_type calls in introspect.py being a little cumbersome - my main
> > concern with that solution is that I might be leaving a nasty
> > booby-trap in the future if someone wants to add a new built-in type
> > or something gets refactored to share more code pathways. Maybe that's
> > not fully rational, but it's why I went the way I did.
>
> In my mind, .resolve_type() is strictly for resolving types during
> semantic analysis: look up a type by name, report an error if it doesn't
> exist.
>
> Before this patch:
>
> (A) QAPISchemaArrayType.check() works.  The invariant check is buried
> somewhat deep, in QAPISourceError.
>
> (B) introspect.py works.  The invariant is not checked there.
>
> (C) QAPISchemaVariants.check() works.  A rather losely related invariant
> is checked there: the tag member's type exists.
>
> This patch conflates two changes.
>
> One, it adds an invariant check right to .resolve_type().  Impact:
>
>     (A) Adds an invariant check closer to the surface.
>
>     (B) Not touched.
>
>     (C) Not touched.
>
> No objection.
>
> Two, it defaults .resolve_type()'s arguments to None.  Belongs to the
> next patch.
>
> The next patch overloads .resolve_type() to serve two use cases,
> 1. failure is a semantic error, and 2. failure is a programming error.
> The first kind passes the arguments, the second doesn't.  Impact:
>
>     (A) Not touched.
>
>     (B) Adds invariant checking, in the callee.
>
>     (C) Pushes the invariant checking into the callee.
>
> I don't like overloading .resolve_type() this way.  Again: in my mind,
> it's strictly for resolving the user's type names in semantic analysis.
>
> If I drop this patch and the next one, mypy complains
>
>     scripts/qapi/schema.py:1219: error: Argument 1 has incompatible type =
"QAPISourceInfo | None"; expected "QAPISourceInfo"  [arg-type]
>     scripts/qapi/introspect.py:230: error: Incompatible types in assignme=
nt (expression has type "QAPISchemaType | None", variable has type "QAPISch=
emaType")  [assignment]
>     scripts/qapi/introspect.py:233: error: Incompatible types in assignme=
nt (expression has type "QAPISchemaType | None", variable has type "QAPISch=
emaType")  [assignment]
>
> Retaining the assertion added in this patch takes care of the first one.
>
> To get rid of the two in introspect.py, we need to actually check the
> invariant:
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 67c7d89aae..4679b1bc2c 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -> str:
>
>          # Map the various integer types to plain int
>          if typ.json_type() =3D=3D 'int':
> -            typ =3D self._schema.lookup_type('int')
> +            type_int =3D self._schema.lookup_type('int')
> +            assert type_int
> +            typ =3D type_int
>          elif (isinstance(typ, QAPISchemaArrayType) and
>                typ.element_type.json_type() =3D=3D 'int'):
> -            typ =3D self._schema.lookup_type('intList')
> +            type_intList =3D self._schema.lookup_type('intList')
> +            assert type_intList
> +            typ =3D type_intList
>          # Add type to work queue if new
>          if typ not in self._used_types:
>              self._used_types.append(typ)
>
> Straightforward enough, although with a bit of notational overhead.
>
> We use t =3D .lookup_type(...); assert t in three places then.  Feel free
> to factor it out into a new helper.
>
> > (P.S. I still violently want to create an info object that represents
> > built-in definitions so I can just get rid of all the
> > Optional[QAPISourceInfo] types from everywhere. I know I tried to do
> > it before and you vetoed it, but the desire lives on in my heart.)
>
> Once everything is properly typed, the cost and benefit of such a change
> should be more clearly visible.
>
> For now, let's try to type what we have, unless what we have complicates
> typing too much.


