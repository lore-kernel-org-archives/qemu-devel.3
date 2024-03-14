Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48779C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 14:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rklwj-000551-MX; Thu, 14 Mar 2024 10:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rklwi-00054l-Ot
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rklwd-0008M4-5u
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710426029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wIvrs85Z71jl3BURTZ6lE1WwPDHmzy3Mt1SnWKMYNtw=;
 b=g53j4CgXg64qM8VA1UhsQSmT5/GOabvxBiqKwGxRyU1gfy00nwL1gRwyBS9QvjK0tbuM+P
 uijtzuqagWWh3joRqffbhKv4k+yQeP8t+46akleHWCproOFooSqus+Et9hVtv1lZvzvSHj
 Y2cEaQovnAwDLdkUO0h+54uEw9x0KCk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39--fluZueSOeO31fionTa-7A-1; Thu, 14 Mar 2024 10:20:21 -0400
X-MC-Unique: -fluZueSOeO31fionTa-7A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29c0315df00so883666a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 07:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710426019; x=1711030819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIvrs85Z71jl3BURTZ6lE1WwPDHmzy3Mt1SnWKMYNtw=;
 b=nu+dhYRc0izpZEGAuVA1aDtROBONAapZOYa0KVBRzfxgKPFhzKiMMR5VBkx4AM7BNr
 RJQeJEHDkF5ha0NPZ7eu0OWQZhlsrlL883E5poV8aImZ/gJKXtR+Mc0OkMQkZfu7ErnM
 7BDP0a7xfvVyzUZTLSYikFbEha75oROO7bQGNCSz0Im4uUYBS5qq151AyexDHXfyjEkY
 OxMVzfP+4Bo7JyLKj2IoTfO6uZTMb4g6Y6QwXEUi4+kiFxm/wQhPtgrmVFhuw0VVA45M
 RTlgiyRt0womWhDL/u5Vq7o1I3JpJ2mic0r2snJg9BCKRtrtdNUKcvbLe3fzatTdqZEX
 +s3A==
X-Gm-Message-State: AOJu0YyiPwGEsH8M0HGSqPI8GfXKf9MQdS92IJMbpB6+QbQpkvbJwW1p
 /TbG0pzWn9Q4t/ptYt2G8a5CJn+1YyD12KI5jUzt/VhUVzdH8akkFE5X0Q0R90znh718Hy2DsdZ
 DrDFkCjgGT0Vu2afXeWHL5AmwWHRn7G0uNqaXbjYaM3uEsFseO20g0sOVqJS4wnCHnIOpE14suV
 tPbyqXfR1pSMdo5X3SzXbkOv5Icmo=
X-Received: by 2002:a17:90b:2e8e:b0:29d:32c5:f0e9 with SMTP id
 sn14-20020a17090b2e8e00b0029d32c5f0e9mr130509pjb.2.1710426018842; 
 Thu, 14 Mar 2024 07:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc5iBQgME0olJIitYe5fxzvrz84OxoEZl/7wVEqbsswqktlp/wMHadbSQRYWlVjdoNLhpJ/zT90t+rCcyYHbc=
X-Received: by 2002:a17:90b:2e8e:b0:29d:32c5:f0e9 with SMTP id
 sn14-20020a17090b2e8e00b0029d32c5f0e9mr130490pjb.2.1710426018470; Thu, 14 Mar
 2024 07:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-6-jsnow@redhat.com>
 <87o7bh9nyt.fsf@pond.sub.org>
 <CAFn=p-bZdrG=MiGpP6jUNqwUfV1RW9aD4Ps+7WKKkCfrshm5rQ@mail.gmail.com>
 <87il1o9afc.fsf@pond.sub.org>
In-Reply-To: <87il1o9afc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 14 Mar 2024 10:20:07 -0400
Message-ID: <CAFn=p-ZEoHajMe1uh_BV-EhyAEkf_QYMtcRjWecfGamHC7GnTA@mail.gmail.com>
Subject: Re: [PATCH v4 05/23] qapi: create QAPISchemaDefinition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000003ef63606139f975f"
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

--0000000000003ef63606139f975f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024, 10:04=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Mar 14, 2024, 5:12=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Include entities don't have names, but we generally expect "entities=
"
> to
> >> > have names. Reclassify all entities with names as *definitions*,
> leaving
> >> > the nameless include entities as QAPISchemaEntity instances.
> >> >
> >> > This is primarily to help simplify typing around expectations of wha=
t
> >> > callers expect for properties of an "entity".
> >> >
> >> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/schema.py | 144
> +++++++++++++++++++++++------------------
> >> >  1 file changed, 82 insertions(+), 62 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> >> > index 117f0f78f0c..da273c1649d 100644
> >> > --- a/scripts/qapi/schema.py
> >> > +++ b/scripts/qapi/schema.py
> >>
> >> [...]
> >>
> >> > @@ -107,6 +90,46 @@ def _set_module(self, schema, info):
> >> >      def set_module(self, schema):
> >> >          self._set_module(schema, self.info)
> >> >
> >> > +    def visit(self, visitor):
> >> > +        # pylint: disable=3Dunused-argument
> >> > +        assert self._checked
> >> > +
> >> > +
> >> > +class QAPISchemaDefinition(QAPISchemaEntity):
> >> > +    meta: Optional[str] =3D None
> >> > +
> >> > +    def __init__(self, name: str, info, doc, ifcond=3DNone,
> features=3DNone):
> >> > +        assert isinstance(name, str)
> >> > +        super().__init__(info)
> >> > +        for f in features or []:
> >> > +            assert isinstance(f, QAPISchemaFeature)
> >> > +            f.set_defined_in(name)
> >> > +        self.name =3D name
> >> > +        self.doc =3D doc
> >> > +        self._ifcond =3D ifcond or QAPISchemaIfCond()
> >> > +        self.features =3D features or []
> >> > +
> >> > +    def __repr__(self):
> >> > +        return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
> >> > +                                    id(self))
> >> > +
> >> > +    def c_name(self):
> >> > +        return c_name(self.name)
> >> > +
> >> > +    def check(self, schema):
> >> > +        assert not self._checked
> >> > +        seen =3D {}
> >> > +        for f in self.features:
> >> > +            f.check_clash(self.info, seen)
> >> > +        super().check(schema)
> >>
> >> v3 called super().check() first.  Why did you move it?  I'm asking jus=
t
> >> to make sure I'm not missing something subtle.
> >>
> >
> > I don't believe you are, I think it was just ... something I didn't
> notice
> > when rebasing, since I merged this patch by hand. I recall having to
> insert
> > the super call manually, and I guess my preferences are nondeterministi=
c.
>
> I'd like to move it back, for consistency with its subtypes' .check(),
> which all call super().check() early.  Okay?
>

Yes, please do.

(You *really* don't have to ask, but I understand you are being courteous
to a fault. It's your module, though! I argue a lot but it *is* yours. Run
it through the armbru delinter as much as you'd like.)


> >> > +
> >> > +    def connect_doc(self, doc=3DNone):
> >> > +        super().connect_doc(doc)
> >> > +        doc =3D doc or self.doc
> >> > +        if doc:
> >> > +            for f in self.features:
> >> > +                doc.connect_feature(f)
> >> > +
> >> >      @property
> >> >      def ifcond(self):
> >> >          assert self._checked
> >>
> >> [...]
> >>
> >>
>
>

--0000000000003ef63606139f975f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Mar 14, 2024, 10:04=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:j=
snow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&=
gt; writes:<br>
<br>
&gt; On Thu, Mar 14, 2024, 5:12=E2=80=AFAM Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redh=
at.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Include entities don&#39;t have names, but we generally expec=
t &quot;entities&quot; to<br>
&gt;&gt; &gt; have names. Reclassify all entities with names as *definition=
s*, leaving<br>
&gt;&gt; &gt; the nameless include entities as QAPISchemaEntity instances.<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This is primarily to help simplify typing around expectations=
 of what<br>
&gt;&gt; &gt; callers expect for properties of an &quot;entity&quot;.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Suggested-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@=
redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<=
br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/schema.py | 144 +++++++++++++++++++++++---=
---------------<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 82 insertions(+), 62 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<=
br>
&gt;&gt; &gt; index 117f0f78f0c..da273c1649d 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/schema.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/schema.py<br>
&gt;&gt;<br>
&gt;&gt; [...]<br>
&gt;&gt;<br>
&gt;&gt; &gt; @@ -107,6 +90,46 @@ def _set_module(self, schema, info):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def set_module(self, schema):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_module(schema, <a=
 href=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">=
self.info</a>)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def visit(self, visitor):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # pylint: disable=3Dunused-argum=
ent<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +class QAPISchemaDefinition(QAPISchemaEntity):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 meta: Optional[str] =3D None<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def __init__(self, name: str, info, doc, ifcon=
d=3DNone, features=3DNone):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinstance(name, str)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(info)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in features or []:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinstance(=
f, QAPISchemaFeature)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.set_defined_in(n=
ame)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.name" rel=
=3D"noreferrer noreferrer" target=3D"_blank">self.name</a> =3D name<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.doc =3D doc<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ifcond =3D ifcond or QAPIS=
chemaIfCond()<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features =3D features or []=
<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def __repr__(self):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&lt;%s:%s at 0x%x&g=
t;&quot; % (type(self).__name__, <a href=3D"http://self.name" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">self.name</a>,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id(self)=
)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def c_name(self):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c_name(<a href=3D"http://=
self.name" rel=3D"noreferrer noreferrer" target=3D"_blank">self.name</a>)<b=
r>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def check(self, schema):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert not self._checked<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 seen =3D {}<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in self.features:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.check_clash(<a h=
ref=3D"http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">se=
lf.info</a>, seen)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
&gt;&gt;<br>
&gt;&gt; v3 called super().check() first.=C2=A0 Why did you move it?=C2=A0 =
I&#39;m asking just<br>
&gt;&gt; to make sure I&#39;m not missing something subtle.<br>
&gt;&gt;<br>
&gt;<br>
&gt; I don&#39;t believe you are, I think it was just ... something I didn&=
#39;t notice<br>
&gt; when rebasing, since I merged this patch by hand. I recall having to i=
nsert<br>
&gt; the super call manually, and I guess my preferences are nondeterminist=
ic.<br>
<br>
I&#39;d like to move it back, for consistency with its subtypes&#39; .check=
(),<br>
which all call super().check() early.=C2=A0 Okay?<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, please do.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">(You *really* don&#39;t have to as=
k, but I understand you are being courteous to a fault. It&#39;s your modul=
e, though! I argue a lot but it *is* yours. Run it through the armbru delin=
ter as much as you&#39;d like.)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def connect_doc(self, doc=3DNone):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().connect_doc(doc)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 doc =3D doc or self.doc<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if doc:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in self.feat=
ures:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.=
connect_feature(f)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 @property<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def ifcond(self):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
&gt;&gt;<br>
&gt;&gt; [...]<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000003ef63606139f975f--


