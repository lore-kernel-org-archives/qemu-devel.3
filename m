Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A402CCD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbzI-0001dl-L1; Tue, 19 Mar 2024 12:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rmbzF-0001dJ-Bb
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rmbzD-0001Nx-Pr
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710864407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yijLkJFAZkjrMhjU1r7XuxuzL7h0Bg1bdDomxPz9TVU=;
 b=Whq/UbbJDBkusX46UdRIm9+4tOIYDIiJO6xqkWBeQL9F0TNQrRk8AERmB1g4CWCv5YzSag
 kVyXK6Z4JINuz274kZMkHEPjJLILoljnN1UkYEanrOo+y9SErnAr99MjZ7WrdnNe487eTc
 5DryAeYvP46MLeJnqpqExrMA/2/dMpI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-_t50_WMNOuazwtS4SKTv_g-1; Tue, 19 Mar 2024 12:06:45 -0400
X-MC-Unique: _t50_WMNOuazwtS4SKTv_g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29d7e7c0c7cso4468325a91.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 09:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710864401; x=1711469201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yijLkJFAZkjrMhjU1r7XuxuzL7h0Bg1bdDomxPz9TVU=;
 b=ZwZEMZ2UcybaYpa1cOkJfB54dBleWiZ8e40a78XaEdGdvlP9cdmwJdHLVA+PzxNNZf
 lzlY3h4Q264grydSrrMbdiydPSJxd1RMUOO2bCNcUMGgwPO+Tq9tdGR6OSovxjLSTu2A
 Bgdu8ui4090mweNQs/7+gCYhAJK9LKSRE5sRG4BXi+VsPqvJplfarsCUqYb0mT9dhDv6
 Fy3uxRS6Xv3UkJHL0nOqU1kkFRhddRuyrMm/OPf5zGIz3GgD+qnxwUw1Y3tXZs7jmj/J
 8PiB9Z2hHk8Hoi4EQ8BXyRUQ6qVRLf/oQxB22jOPtMCHEXMAXNyqxInYTxS2mGedIQV8
 35bw==
X-Gm-Message-State: AOJu0YzI1xEgTC7HzYKnDxeg4EJhwfMFKadAx/vHHUhrpN5c+WAc/gUB
 6KlnB0IEtSHwWJbgZctbMDmPLJX2jBUcUkbxnxzwaVY775mVLdGw0RZRaioh4fsdmTeF5KEVusF
 go5n76+Ofs3eM5MU++ARoDFBuc/dSlXGEbE8xDZ+OTHov4hdRrYHkIXYDyt7FBD2zmH2K6Japy+
 gRftXXyIQEm/SbuWCG+Vgv0ATbs7o=
X-Received: by 2002:a17:90a:749:b0:29f:c2f8:43ad with SMTP id
 s9-20020a17090a074900b0029fc2f843admr2939599pje.9.1710864401687; 
 Tue, 19 Mar 2024 09:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBCoaLnGfRsHlRocINukaybChIFZEkeCytCkY1Faaap03bgJoyckLCxWD0pXYvYzYi/NwB4pKZiWaw7WwgXqE=
X-Received: by 2002:a17:90a:749:b0:29f:c2f8:43ad with SMTP id
 s9-20020a17090a074900b0029fc2f843admr2939583pje.9.1710864401285; Tue, 19 Mar
 2024 09:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240315152301.3621858-1-armbru@redhat.com>
 <20240315152301.3621858-25-armbru@redhat.com>
 <CAFn=p-YuKWRvGcxDApVt3kXg22c1YJDogWJG9g4AXud_tgbZag@mail.gmail.com>
 <87r0g6yztz.fsf@pond.sub.org>
In-Reply-To: <87r0g6yztz.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Mar 2024 12:06:29 -0400
Message-ID: <CAFn=p-ar1iT7bgJqaN4nk4wjfbhNT2BKanYDq9H9vRKKo_34fA@mail.gmail.com>
Subject: Re: [PATCH v5 24/25] qapi: Tighten check whether implicit object type
 already exists
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000e5dd40061405a841"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

--000000000000e5dd40061405a841
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024, 12:02=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Mar 15, 2024, 11:23=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
> >
> >> Entities with names starting with q_obj_ are implicit object types.
> >> Therefore, QAPISchema._make_implicit_object_type()'s .lookup_entity()
> >> can only return a QAPISchemaObjectType.  Assert that.
> >>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  scripts/qapi/schema.py | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> index e52930a48a..a6180f93c6 100644
> >> --- a/scripts/qapi/schema.py
> >> +++ b/scripts/qapi/schema.py
> >> @@ -1297,8 +1297,9 @@ def _make_implicit_object_type(
> >>              return None
> >>          # See also QAPISchemaObjectTypeMember.describe()
> >>          name =3D 'q_obj_%s-%s' % (name, role)
> >> -        typ =3D self.lookup_entity(name, QAPISchemaObjectType)
> >> +        typ =3D self.lookup_entity(name)
> >>          if typ:
> >> +            assert(isinstance(typ, QAPISchemaObjectType))
> >>              # The implicit object type has multiple users.  This can
> >>              # only be a duplicate definition, which will be flagged
> >>              # later.
> >> --
> >> 2.44.0
> >>
> >
> > Seems obviously fine, though I don't suppose this narrowing will be
> > "remembered" by the type system. Do we care?
>
> mypy passes without it.  It's for catching programming errors and
> helping the reader along.  The former are unlikely, and the latter is
> debatable, but when in doubt, assert.
>

mmhmm. I was just wondering if we could tighten the typing of typ itself,
or if it conflicted with legitimate broader uses. it happens a lot in qapi
that we're regulated by broader base types in parent classes etc.

If we CAN tighten the variable/field (without runtime code changes), we
should do so. If we can't, this patch is 100% totally fine as is.


> > Reviewed-by: John Snow <jsnow@redhat.com>
>
> Thanks!
>
>

--000000000000e5dd40061405a841
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Mar 19, 2024, 12:02=E2=80=AFPM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Mar 15, 2024, 11:23=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blan=
k">armbru@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Entities with names starting with q_obj_ are implicit object types=
.<br>
&gt;&gt; Therefore, QAPISchema._make_implicit_object_type()&#39;s .lookup_e=
ntity()<br>
&gt;&gt; can only return a QAPISchemaObjectType.=C2=A0 Assert that.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com" rel=3D"noreferrer noreferrer" target=3D"_blank">armbru@redhat.com</=
a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 scripts/qapi/schema.py | 3 ++-<br>
&gt;&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt;&gt; index e52930a48a..a6180f93c6 100644<br>
&gt;&gt; --- a/scripts/qapi/schema.py<br>
&gt;&gt; +++ b/scripts/qapi/schema.py<br>
&gt;&gt; @@ -1297,8 +1297,9 @@ def _make_implicit_object_type(<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # See also QAPISchemaObjectTypeM=
ember.describe()<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D &#39;q_obj_%s-%s&#39; %=
 (name, role)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.lookup_entity(name, QAPI=
SchemaObjectType)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.lookup_entity(name)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if typ:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(isinstance(typ, =
QAPISchemaObjectType))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # The implicit obj=
ect type has multiple users.=C2=A0 This can<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # only be a duplic=
ate definition, which will be flagged<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # later.<br>
&gt;&gt; --<br>
&gt;&gt; 2.44.0<br>
&gt;&gt;<br>
&gt;<br>
&gt; Seems obviously fine, though I don&#39;t suppose this narrowing will b=
e<br>
&gt; &quot;remembered&quot; by the type system. Do we care?<br>
<br>
mypy passes without it.=C2=A0 It&#39;s for catching programming errors and<=
br>
helping the reader along.=C2=A0 The former are unlikely, and the latter is<=
br>
debatable, but when in doubt, assert.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">mmhmm. I was just wondering if we cou=
ld tighten the typing of typ itself, or if it conflicted with legitimate br=
oader uses. it happens a lot in qapi that we&#39;re regulated by broader ba=
se types in parent classes etc.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">If we CAN tighten the variable/field (without runtime code change=
s), we should do so. If we can&#39;t, this patch is 100% totally fine as is=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<br>
&gt; Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"=
noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Thanks!<br>
<br>
</blockquote></div></div></div>

--000000000000e5dd40061405a841--


