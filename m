Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4C6C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 13:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rklD1-0000Bl-BL; Thu, 14 Mar 2024 09:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rklCr-0000BS-Ku
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rklCo-00085U-Dl
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710423187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cq6mkbI92Tf7ls263D8mi8YyBge6GZSlUDN7Lq8Y2h4=;
 b=bxoYsihoHJ5UEFxvuo3TFPZqkXoTgkBIatautLcgd40cY7Mc99IqTH5+whcQq5G18mWKS6
 bVinifmVBA/QixhFeYtS1Z8qpzw2GjFH/4zw7rUl9sxxBCdLlU+YSt3ieuAO/pYPRrTpnv
 v2SmV3CCkjLNFU8UWGs86XPv4U9Qr4Q=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-0QTpYXoSNpy50isqNSXh_g-1; Thu, 14 Mar 2024 09:33:05 -0400
X-MC-Unique: 0QTpYXoSNpy50isqNSXh_g-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5d8dd488e09so869429a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 06:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710423185; x=1711027985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cq6mkbI92Tf7ls263D8mi8YyBge6GZSlUDN7Lq8Y2h4=;
 b=IFZnNgBzXFGrHWc0NOzhL6NQZG2VrOS67RU6tVFfLyxS+aqNNEyNfYtkJAKKXymEK1
 C22cAMzoeS9ijlwpBkUDm102XWtVU1kwH+3sS6hjGWr6IDhyjwzht+UIoJ9lzWmxo+1a
 ldvqW3MaiDR3Mbe7YeTnI6FWAUYPsvhwgfrMVwIydCjCpiXsAdgtD1r78spf5dN6uGz5
 1HBvCTeAFyoAeOh4tCqPPexNtBQSx84W0ODk/PO9+BTQ5cvvU3I2TNfA5UPVnqzVt0DD
 U2pgOGaaAGy2dmIz5wwgpXQXiz6pYT53Cfx2jDc6/WhZG+rt2u8HhOylpcB530/krP53
 TWnA==
X-Gm-Message-State: AOJu0Yw7ac44tTc2aqiJ/zAsHy2jxRQzW4NxWwlB23IEMTNOo4w+3fzb
 +1b9LUJTl9PWWOXFf8uEXes/vKD5NssBdNcGmVnvqHRML7xK910n9dUadDsr5EHVDhJU+2g4arC
 vsu2MQjKV0a8J6TzWNGqheJ4dwdObDPLXKNNO2zGNKowp+TTxGDXEKmrkDtU2+N3xLqkqyI6Prl
 7P8aPQKAmVN+lgR5b+mh06Krh50js=
X-Received: by 2002:a05:6a20:54a6:b0:1a3:492d:a0da with SMTP id
 i38-20020a056a2054a600b001a3492da0damr41911pzk.43.1710423184895; 
 Thu, 14 Mar 2024 06:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTgNGdmMJ9sJrfK/LkM/YmIasDNqHqqUXLEdHgXwnu7ej+WkTVegXTpgOrIyBXvwd2p+M17NsU0u62SGdQTvA=
X-Received: by 2002:a05:6a20:54a6:b0:1a3:492d:a0da with SMTP id
 i38-20020a056a2054a600b001a3492da0damr41859pzk.43.1710423184234; Thu, 14 Mar
 2024 06:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-6-jsnow@redhat.com>
 <87o7bh9nyt.fsf@pond.sub.org>
In-Reply-To: <87o7bh9nyt.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 14 Mar 2024 09:32:52 -0400
Message-ID: <CAFn=p-bZdrG=MiGpP6jUNqwUfV1RW9aD4Ps+7WKKkCfrshm5rQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/23] qapi: create QAPISchemaDefinition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000005005b406139eee64"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

--0000000000005005b406139eee64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024, 5:12=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Include entities don't have names, but we generally expect "entities" t=
o
> > have names. Reclassify all entities with names as *definitions*, leavin=
g
> > the nameless include entities as QAPISchemaEntity instances.
> >
> > This is primarily to help simplify typing around expectations of what
> > callers expect for properties of an "entity".
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 144 +++++++++++++++++++++++------------------
> >  1 file changed, 82 insertions(+), 62 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 117f0f78f0c..da273c1649d 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
>
> [...]
>
> > @@ -107,6 +90,46 @@ def _set_module(self, schema, info):
> >      def set_module(self, schema):
> >          self._set_module(schema, self.info)
> >
> > +    def visit(self, visitor):
> > +        # pylint: disable=3Dunused-argument
> > +        assert self._checked
> > +
> > +
> > +class QAPISchemaDefinition(QAPISchemaEntity):
> > +    meta: Optional[str] =3D None
> > +
> > +    def __init__(self, name: str, info, doc, ifcond=3DNone,
> features=3DNone):
> > +        assert isinstance(name, str)
> > +        super().__init__(info)
> > +        for f in features or []:
> > +            assert isinstance(f, QAPISchemaFeature)
> > +            f.set_defined_in(name)
> > +        self.name =3D name
> > +        self.doc =3D doc
> > +        self._ifcond =3D ifcond or QAPISchemaIfCond()
> > +        self.features =3D features or []
> > +
> > +    def __repr__(self):
> > +        return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
> > +                                    id(self))
> > +
> > +    def c_name(self):
> > +        return c_name(self.name)
> > +
> > +    def check(self, schema):
> > +        assert not self._checked
> > +        seen =3D {}
> > +        for f in self.features:
> > +            f.check_clash(self.info, seen)
> > +        super().check(schema)
>
> v3 called super().check() first.  Why did you move it?  I'm asking just
> to make sure I'm not missing something subtle.
>

I don't believe you are, I think it was just ... something I didn't notice
when rebasing, since I merged this patch by hand. I recall having to insert
the super call manually, and I guess my preferences are nondeterministic.


> > +
> > +    def connect_doc(self, doc=3DNone):
> > +        super().connect_doc(doc)
> > +        doc =3D doc or self.doc
> > +        if doc:
> > +            for f in self.features:
> > +                doc.connect_feature(f)
> > +
> >      @property
> >      def ifcond(self):
> >          assert self._checked
>
> [...]
>
>

--0000000000005005b406139eee64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Mar 14, 2024, 5:12=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Include entities don&#39;t have names, but we generally expect &quot;e=
ntities&quot; to<br>
&gt; have names. Reclassify all entities with names as *definitions*, leavi=
ng<br>
&gt; the nameless include entities as QAPISchemaEntity instances.<br>
&gt;<br>
&gt; This is primarily to help simplify typing around expectations of what<=
br>
&gt; callers expect for properties of an &quot;entity&quot;.<br>
&gt;<br>
&gt; Suggested-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.co=
m" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py | 144 +++++++++++++++++++++++------------=
------<br>
&gt;=C2=A0 1 file changed, 82 insertions(+), 62 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index 117f0f78f0c..da273c1649d 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
<br>
[...]<br>
<br>
&gt; @@ -107,6 +90,46 @@ def _set_module(self, schema, info):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def set_module(self, schema):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_module(schema, <a href=3D"=
http://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info=
</a>)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit(self, visitor):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # pylint: disable=3Dunused-argument<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
&gt; +<br>
&gt; +<br>
&gt; +class QAPISchemaDefinition(QAPISchemaEntity):<br>
&gt; +=C2=A0 =C2=A0 meta: Optional[str] =3D None<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, name: str, info, doc, ifcond=3DNone,=
 features=3DNone):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinstance(name, str)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in features or []:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinstance(f, QAPISc=
hemaFeature)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.set_defined_in(name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.name" rel=3D"noref=
errer noreferrer" target=3D"_blank">self.name</a> =3D name<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.doc =3D doc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ifcond =3D ifcond or QAPISchemaIfCo=
nd()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features =3D features or []<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __repr__(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&lt;%s:%s at 0x%x&gt;&quot; =
% (type(self).__name__, <a href=3D"http://self.name" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">self.name</a>,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id(self))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def c_name(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c_name(<a href=3D"http://self.name=
" rel=3D"noreferrer noreferrer" target=3D"_blank">self.name</a>)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def check(self, schema):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert not self._checked<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 seen =3D {}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in self.features:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.check_clash(<a href=3D"ht=
tp://self.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</=
a>, seen)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
<br>
v3 called super().check() first.=C2=A0 Why did you move it?=C2=A0 I&#39;m a=
sking just<br>
to make sure I&#39;m not missing something subtle.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t believe you a=
re, I think it was just ... something I didn&#39;t notice when rebasing, si=
nce I merged this patch by hand. I recall having to insert the super call m=
anually, and I guess my preferences are nondeterministic.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def connect_doc(self, doc=3DNone):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().connect_doc(doc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 doc =3D doc or self.doc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if doc:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in self.features:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.connect_f=
eature(f)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 @property<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def ifcond(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._checked<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--0000000000005005b406139eee64--


