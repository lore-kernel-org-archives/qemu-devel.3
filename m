Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5ADC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqpIq-0006XZ-5T; Sat, 08 Mar 2025 03:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpIl-0006Wt-FC
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:12:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpIj-0001aG-DE
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741421571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MpzMYR7KXI0tBJ4BESzMuqvySpHf11L/YhHL/+TwC4=;
 b=jVUQ2hygkHgZf7Y3wguHrDjpndyDgAagSJFydh16wLwakdLFShulZOAFIIvIVOPSjMleoX
 /1STjsTyzA8DQeAp9x/NFq3rhnXtCAEgHV77ufLnYWdt3uOmG8fzgc0mZpbkn8tu2lWyto
 iRyfjLsMo1Ivewp7DVpg2m/qASOB1NU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-feY5kytHPZKe4Bp0UZUWjQ-1; Sat, 08 Mar 2025 03:12:48 -0500
X-MC-Unique: feY5kytHPZKe4Bp0UZUWjQ-1
X-Mimecast-MFC-AGG-ID: feY5kytHPZKe4Bp0UZUWjQ_1741421568
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff7f9a0b9bso2444638a91.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741421568; x=1742026368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6MpzMYR7KXI0tBJ4BESzMuqvySpHf11L/YhHL/+TwC4=;
 b=q5ncKs0j9KsmGICqUqERsMQA17OelrpGEZ57V5tbbcWiMP68oxkiwpF5nX5JnEgtne
 S9Q+Vqnw+b8dJg1CJI9BBOtM5vrCREUJ23u74+E2/GrWUthAo5zcINgqpoFuYSMWOKyM
 ZfUF8TA89QboOZXSunLfUVuaZ8uqkhdHgnT9isn1KC+XRw1gJX7dpcbbtcI/1ReGG3rb
 LZFmXPhX+mHYu8E4Cz/6848P7zmFQO9fQtALt2as6DS+suEed+gMKSAlMgT/QrXuKUSh
 tkTXzoVJUTKm2vq5SutrprL+7upFDxDcXpLcQmhWHEgw0n8teOoS1DE7v8wv2ObEO5ua
 YS2Q==
X-Gm-Message-State: AOJu0YxMpc2FzeCHH5XO+nZUEHUbBFXgUrGrvK3KmV94GQToRyI1+BFi
 76paYxqc+TF7j8jSIAsbjQ3HMwuAsXiKJgc6Tv9fVd07a+42Oli096PxruQRoHcRwntFII9M85b
 Q3GDxPXhqjXdJz0bzmzu1/DTdQP2kj0hUA5QB58Q9ABePm1PCHQ/wq2mkS/HAshVkWJL7Fd/0yH
 0nuBCDYTQXUrdHVPQ4uSxtrF53JEk=
X-Gm-Gg: ASbGncuWE+/pUcvtlnREK6N1qmv0mJXwsr6VRj1YTEvPxx06XdeU2yRAyHg1J09t40H
 ViAX27G+3HJgG1JQ6uNlzByDDMIg9n6kWuQECa8gtt6keZ7PWBP9eJbzIM+Lltob10Bbkgg==
X-Received: by 2002:a17:90b:3887:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-2ff7ce84ce1mr10394020a91.8.1741421567766; 
 Sat, 08 Mar 2025 00:12:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEJ/wowd/Ox0Dxtl0y85oF3qgBleu36LHjdFYoCcIOs2YekZV/PiAB7Wi/pDwwMDkML/3eL9oHMg9UycxsPN0=
X-Received: by 2002:a17:90b:3887:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-2ff7ce84ce1mr10393999a91.8.1741421567483; Sat, 08 Mar 2025
 00:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-52-jsnow@redhat.com>
 <87senphvqr.fsf@pond.sub.org>
In-Reply-To: <87senphvqr.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 03:12:35 -0500
X-Gm-Features: AQ5f1JpfDSy29XdQc3XWlZ_g4SbeYtOoYzU_2mic94oU_q5ri0tKxOhtvUn9t7o
Message-ID: <CAFn=p-bTpr=m9F0+YZHh63dRDyYEEXpWqczDxiDjmuJrnZK5yA@mail.gmail.com>
Subject: Re: [PATCH 51/57] docs/qapidoc: add visit_entity()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ef47dd062fd04d25"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ef47dd062fd04d25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:27=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Finally, the core entry method for a qapi entity.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 7308fa0a767..fb2ad7492ae 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -78,6 +78,8 @@
> >
> >
> >  class Transmogrifier:
> > +    # pylint: disable=3Dtoo-many-public-methods
> > +
>
> Tsk, tsk, tsk ...  ;-P
>

Strongly tempted to make all the "visit_foo" methods "_handle_foo" and
delete this line.

... But I don't want to fight with the rebase conflicts on all of the chunk
context not lining up anymore. So I'll live with this little dishonor for
now.


>
> >      # Field names used for different entity types:
> >      field_types =3D {
> >          "enum": "value",
> > @@ -368,6 +370,25 @@ def visit_freeform(self, doc: QAPIDoc) -> None:
> >          self.add_lines(text, info)
> >          self.ensure_blank_line()
> >
> > +    def visit_entity(self, ent: QAPISchemaDefinition) -> None:
> > +        assert ent.info
> > +
> > +        try:
> > +            self._curr_ent =3D ent
> > +
> > +            # Squish structs and unions together into an "object"
> directive.
> > +            meta =3D ent.meta
> > +            if meta in ("struct", "union"):
> > +                meta =3D "object"
> > +
> > +            # This line gets credited to the start of the /definition/=
.
> > +            self.add_line(f".. qapi:{meta}:: {ent.name}", ent.info)
> > +            with self.indented():
> > +                self.preamble(ent)
> > +                self.visit_sections(ent)
> > +        finally:
> > +            self._curr_ent =3D None
> > +
> >
> >  class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
> >      """A QAPI schema visitor which adds Sphinx dependencies each modul=
e
>
>

--000000000000ef47dd062fd04d25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:27=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Finally, the core entry method for a qapi entity.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 21 +++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 21 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 7308fa0a767..fb2ad7492ae 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -78,6 +78,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class Transmogrifier:<br>
&gt; +=C2=A0 =C2=A0 # pylint: disable=3Dtoo-many-public-methods<br>
&gt; +<br>
<br>
Tsk, tsk, tsk ...=C2=A0 ;-P<br></blockquote><div><br></div><div>Strongly te=
mpted to make all the &quot;visit_foo&quot; methods &quot;_handle_foo&quot;=
 and delete this line.</div></div><div class=3D"gmail_quote gmail_quote_con=
tainer"><br></div><div class=3D"gmail_quote gmail_quote_container">... But =
I don&#39;t want to fight with the rebase conflicts on all of the chunk con=
text not lining up anymore. So I&#39;ll live with this little dishonor for =
now.<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Field names used for different entity types:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 field_types =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enum&quot;: &quot;value&quot;,=
<br>
&gt; @@ -368,6 +370,25 @@ def visit_freeform(self, doc: QAPIDoc) -&gt; None=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_lines(text, info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_entity(self, ent: QAPISchemaDefinition) -&gt;=
 None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert <a href=3D"http://ent.info" rel=3D=
"noreferrer" target=3D"_blank">ent.info</a><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._curr_ent =3D ent<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Squish structs and unions=
 together into an &quot;object&quot; directive.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 meta =3D ent.meta<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if meta in (&quot;struct&qu=
ot;, &quot;union&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 meta =3D &quo=
t;object&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This line gets credited t=
o the start of the /definition/.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&quot;.. qap=
i:{meta}:: {<a href=3D"http://ent.name" rel=3D"noreferrer" target=3D"_blank=
">ent.name</a>}&quot;, <a href=3D"http://ent.info" rel=3D"noreferrer" targe=
t=3D"_blank">ent.info</a>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with self.indented():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.preamble=
(ent)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.visit_se=
ctions(ent)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._curr_ent =3D None<br>
&gt; +<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;A QAPI schema visitor which adds=
 Sphinx dependencies each module<br>
<br>
</blockquote></div></div>

--000000000000ef47dd062fd04d25--


