Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A86C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 17:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlBUn-0002Mc-Ad; Fri, 15 Mar 2024 13:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rlBUj-0002M1-Ll
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 13:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rlBUh-0008Qm-Ef
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 13:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710524241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2zq0H2KZ7KLSRGf+Aoi1m/uDaQEgtzPp9Qb+7DrVto=;
 b=RNBMLmX5aigGcfAFwd7/N6D+uBaimF0L3oNX9/evha05+Pv5V6hU3a11V8h6L3DCDr1Hfe
 sLjE8SLuluWOQX+fySgLYAG5rR1edTsKVVdnIKEmP/mP79GDuuL6y+82NjMqGcOwLqS+gn
 F58PDVmzEG7hglE2WXXAoytGo4T906g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-cRHsluf3NXi4oIESk-TPew-1; Fri, 15 Mar 2024 13:37:19 -0400
X-MC-Unique: cRHsluf3NXi4oIESk-TPew-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29c6ff57cedso2149874a91.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 10:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710524238; x=1711129038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t2zq0H2KZ7KLSRGf+Aoi1m/uDaQEgtzPp9Qb+7DrVto=;
 b=ElW9kornu5cI5LTvPxRYGq338lUgG+/QmRZFsEZcQMEJag2Xn3L7Xy2EGIqPbxskEQ
 IRAiT3mE7cetb8IgKfGPdRCHsTOLU+pPcMVlSpbB5a3+FBewS4ISASjJsY3HPQWGMRWC
 5xS49lx8LvWhLv9XX+Ad3GCy31bTBlMDS06CcmKpUieV7CAN/uRtZlDpIq9F+iXqYptn
 A/KMfPgEe4naCCq0VJ6IZFYsvlhYR/xZYZGWSPsfrcGIML1jrypZOIRpqQJ5KKz/BuO2
 /0XUvh/lj67qpmVZTe8ZNWgUsnxOaiGYZ7iN0y1EnAruoKgeRTcg/HKd7WqeV4MM2h5D
 QQHA==
X-Gm-Message-State: AOJu0YylT5Q0S61rGl0XCcXcAKOjWhQthfsiwtLDg5J6VpVdNEy048P2
 jMCoIg36GLT2f6cDJzM3IvyjZNPRFnSGyJU349x9VgMi1gfgUr2/RbcCjD8Wbq7K/QrugfDYev3
 aaSQFtHD2VQcwI8Nda1znOCTUd0z+SLsvte+2IclNMQSUZ+5TA7p14BB7o6kiXuz1ksDaeo5bqJ
 mlfnqRivzHkMm+0BBoc5TaZLz8Is0=
X-Received: by 2002:a17:90b:148d:b0:29c:76a9:3b7b with SMTP id
 js13-20020a17090b148d00b0029c76a93b7bmr3701798pjb.7.1710524238284; 
 Fri, 15 Mar 2024 10:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECjNuIx7txYB7J+yZgIITJ8fieuWsvBB9NBUaKZGmBcnAo4/8gAXjDOitBARg/F02hZ5Nb4rtKQ8JKNb/Lh5c=
X-Received: by 2002:a17:90b:148d:b0:29c:76a9:3b7b with SMTP id
 js13-20020a17090b148d00b0029c76a93b7bmr3701784pjb.7.1710524238023; Fri, 15
 Mar 2024 10:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-22-jsnow@redhat.com>
 <87edcbegn0.fsf@pond.sub.org>
In-Reply-To: <87edcbegn0.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 15 Mar 2024 13:37:05 -0400
Message-ID: <CAFn=p-aJKNWHW6+XE1RFzDu8eHBGY-0k=1CgnkFJyYZd-EZgHA@mail.gmail.com>
Subject: Re: [PATCH v4 21/23] qapi/schema: add type hints
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000965f880613b67522"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

--000000000000965f880613b67522
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024, 10:03=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch only adds type hints, which aren't utilized at runtime and
> > don't change the behavior of this module in any way.
> >
> > In a scant few locations, type hints are removed where no longer
> > necessary due to inference power from typing all of the rest of
> > creation; and any type hints that no longer need string quotes are
> > changed.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 568 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 396 insertions(+), 172 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 3b8c2ebbb5f..d2faaea6eac 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
>
> [...]
>
> > @@ -1006,18 +1181,27 @@ def _def_definition(self, defn):
> >                  defn.info, "%s is already defined" %
> other_defn.describe())
> >          self._entity_dict[defn.name] =3D defn
> >
> > -    def lookup_entity(self, name, typ=3DNone):
> > +    def lookup_entity(
> > +        self,
> > +        name: str,
> > +        typ: Optional[type] =3D None,
> > +    ) -> Optional[QAPISchemaEntity]:
>
> Optional[QAPISchemaDefinition], actually.
>

Ah! Very good catch.


> >          ent =3D self._entity_dict.get(name)
> >          if typ and not isinstance(ent, typ):
> >              return None
> >          return ent
>
> [...]
>
>

--000000000000965f880613b67522
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Mar 15, 2024, 10:03=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:j=
snow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&=
gt; writes:<br>
<br>
&gt; This patch only adds type hints, which aren&#39;t utilized at runtime =
and<br>
&gt; don&#39;t change the behavior of this module in any way.<br>
&gt;<br>
&gt; In a scant few locations, type hints are removed where no longer<br>
&gt; necessary due to inference power from typing all of the rest of<br>
&gt; creation; and any type hints that no longer need string quotes are<br>
&gt; changed.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py | 568 ++++++++++++++++++++++++++++-------=
------<br>
&gt;=C2=A0 1 file changed, 396 insertions(+), 172 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index 3b8c2ebbb5f..d2faaea6eac 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
<br>
[...]<br>
<br>
&gt; @@ -1006,18 +1181,27 @@ def _def_definition(self, defn):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=
=3D"http://defn.info" rel=3D"noreferrer noreferrer" target=3D"_blank">defn.=
info</a>, &quot;%s is already defined&quot; % other_defn.describe())<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_dict[<a href=3D"http://=
defn.name" rel=3D"noreferrer noreferrer" target=3D"_blank">defn.name</a>] =
=3D defn<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def lookup_entity(self, name, typ=3DNone):<br>
&gt; +=C2=A0 =C2=A0 def lookup_entity(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ: Optional[type] =3D None,<br>
&gt; +=C2=A0 =C2=A0 ) -&gt; Optional[QAPISchemaEntity]:<br>
<br>
Optional[QAPISchemaDefinition], actually.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Ah! Very good catch.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ent =3D self._entity_dict.get(name)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if typ and not isinstance(ent, typ):=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ent<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000965f880613b67522--


