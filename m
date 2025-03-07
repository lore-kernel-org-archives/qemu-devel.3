Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8391C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgPm-0003Sm-Gy; Fri, 07 Mar 2025 17:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgPk-0003Ri-68
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgPi-0004RJ-3P
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741387408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oz/XZ0UZs0t/89iAj1+OMLxOHoE+RFXNTb7ZmRrWT3o=;
 b=aRS731PyTHPC9ardMCstw80R1/COg1x+SsoHOVn29U1TdBWEIpZejZIs17P5Dyn6ILeuEF
 kklz6ZEIiaXdp4CIvA1SRt5LMg3UudpmW7y9bjqeh3LDyJL5lAml5MYAbxLNYUK/A8iFkt
 vPOlgPEc93+Ul+JQCKwhz11a8cJGrzM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-tvfN-i14MeajqCJnxoAxig-1; Fri, 07 Mar 2025 17:43:27 -0500
X-MC-Unique: tvfN-i14MeajqCJnxoAxig-1
X-Mimecast-MFC-AGG-ID: tvfN-i14MeajqCJnxoAxig_1741387406
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff605a7a43so6917925a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387406; x=1741992206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oz/XZ0UZs0t/89iAj1+OMLxOHoE+RFXNTb7ZmRrWT3o=;
 b=SqWANE2ZKI82sxKe+nNF9xSP5GsmrkWmmFwVNfvUkn8Yu252BQH8Ri6UGqgTJUt7+F
 4fwV6ln12iH/NoWPQydO5TmUFG6zS9fI0qqr7XGuihjHaoyBacFYyitR+JhM8EIDmq4m
 LSI+fRKcwDUqCf4G9Cg6EK4q0OUossnvBEH/FGmi3YvGiLlboyPzNd5t7uaKgu6Kyrex
 zitYyThwl3Rz33YcCzLm1x/IZISBxLpqsBc40P95jBHIyq+iiJP8F3F/RVU80H9z1IPu
 0o6j863CqsvavtG6Yj3zLyRf9HOu6tMI2eRRA1gsUmJouhzi0m42/kxs+kXSXmHOXny0
 saWA==
X-Gm-Message-State: AOJu0YyDgZhQKeriWTuWRhpuqSZJ9HMwJ9RQ65vp6XZ3oIPV38bOqYXr
 HtRl+qYyN/XhTnW7nDFv6n9XBbSjZxus4rT8WgweKB4AZZKkW/0sOO5JsMipKD9kxfWtXwU3oHt
 HW9kK5knt4HVJEHawd3+gmUBbTFwiESg23skBOHIOKCRC3/igZ6rqmOyU+kjYDD6lHo9GgGeg61
 x+tFNusALU3trzy4vUiWTR4JlAwt0=
X-Gm-Gg: ASbGncve4fLswsad0vnCIM+tnsGBDebEgl05Qu8IHT5OyjV/hRS246w98CwaMGQkk05
 ksm9XtClefEm4eKjNX+yv6fRcp8PAHV8yfmyvno4URBxElyigVMqmbjSAGm3kgz1PLN3gpg==
X-Received: by 2002:a17:90a:e7c2:b0:2fe:8a84:e032 with SMTP id
 98e67ed59e1d1-2ff7ceab4d6mr8155628a91.20.1741387406084; 
 Fri, 07 Mar 2025 14:43:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/SQKtjg/xzSjPTQQC5Ll/5LaU0Ewd4/4LLtlFnR3ylVS/ZQO8ogqifYwqXxe6OzFeYGHYF7A1Rvd/Tf9g7z4=
X-Received: by 2002:a17:90a:e7c2:b0:2fe:8a84:e032 with SMTP id
 98e67ed59e1d1-2ff7ceab4d6mr8155618a91.20.1741387405869; Fri, 07 Mar 2025
 14:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-13-jsnow@redhat.com>
 <878qphs4v1.fsf@pond.sub.org>
In-Reply-To: <878qphs4v1.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 17:43:13 -0500
X-Gm-Features: AQ5f1JoPfPufgUmfy3n10viSprRccxKRR-1eoP42yK5dMZjYMRWunJE0j3-Xb9Y
Message-ID: <CAFn=p-bDyj5AQ0TK9Y8BQj-zj9uVg8MOO7NFq5S_A0UTmjpWeg@mail.gmail.com>
Subject: Re: [PATCH 12/57] docs/qapi-domain: add :since: directive option
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000be5a19062fc859be"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000be5a19062fc859be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:59=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Add a little special markup for registering "Since:" information. Addin=
g
> > it as an option instead of generic content lets us hoist the informatio=
n
> > into the Signature bar, optionally put it in the index, etc.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapi_domain.py | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> > index 6168c23936f..9919dacd4e6 100644
> > --- a/docs/sphinx/qapi_domain.py
> > +++ b/docs/sphinx/qapi_domain.py
> > @@ -4,6 +4,7 @@
> >
> >  from __future__ import annotations
> >
> > +import re
> >  from typing import (
> >      TYPE_CHECKING,
> >      AbstractSet,
> > @@ -104,6 +105,18 @@ def process_link(
> >          return title, target
> >
> >
> > +def since_validator(param: str) -> str:
> > +    """
> > +    Validate the `:since: X.Y` option field.
> > +    """
> > +    match =3D re.match(r"[0-9]+\.[0-9]+", param)
>
> This accepts arbitrary crap after the version.  Example:
> "9.2.50v9.2.0-2253-ge8a0110293" is fine.  Intentional?
>

Nope! O:-) I forgot that match doesn't imply ^...$


>
> > +    if not match:
> > +        raise ValueError(
> > +            f":since: requires a version number in X.Y format; not
> {param!r}"
> > +        )
> > +    return param
>
> Schema validation is the frontend's job.  Ideally, a backend doesn't
> report any errors.  The backends generating C don't.  A backend
> generating docs has to: all the reST processing happens there, and
> therefore reST errors can only be diagnosed there.  Since "no errors"
> purity is impossible for this backend, we can be pragmatic about sinning
> a bit more.
>
> Still, I think this one should rather go into the doc comment parser.
>
> This is not a demand.  We can always clean it up later.
>

You *can* technically use this without touching the QAPI parser at all,
nothing stops you. I.e., you *could* write a QMP reference manual by hand
into an .rst if you wanted.

That said, I know we probably won't. I can remove the validator.


>
> > +
> > +
> >  # Alias for the return of handle_signature(), which is used in several
> places.
> >  # (In the Python domain, this is Tuple[str, str] instead.)
> >  Signature =3D str
> > @@ -124,6 +137,8 @@ class QAPIObject(ObjectDescription[Signature]):
> >          {
> >              # Borrowed from the Python domain:
> >              "module": directives.unchanged,  # Override contextual
> module name
> > +            # These are QAPI originals:
> > +            "since": since_validator,
> >          }
> >      )
> >
> > @@ -135,9 +150,19 @@ def get_signature_prefix(self) -> List[nodes.Node]=
:
> >              SpaceNode(" "),
> >          ]
> >
> > -    def get_signature_suffix(self) -> list[nodes.Node]:
> > +    def get_signature_suffix(self) -> List[nodes.Node]:
> >          """Returns a suffix to put after the object name in the
> signature."""
> > -        return []
> > +        ret: List[nodes.Node] =3D []
> > +
> > +        if "since" in self.options:
> > +            ret +=3D [
> > +                SpaceNode(" "),
> > +                addnodes.desc_sig_element(
> > +                    "", f"(Since: {self.options['since']})"
> > +                ),
> > +            ]
> > +
> > +        return ret
> >
> >      def handle_signature(self, sig: str, signode: desc_signature) ->
> Signature:
> >          """
>
>

--000000000000be5a19062fc859be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 1:59=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add a little special markup for registering &quot;Since:&quot; informa=
tion. Adding<br>
&gt; it as an option instead of generic content lets us hoist the informati=
on<br>
&gt; into the Signature bar, optionally put it in the index, etc.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapi_domain.py | 29 +++++++++++++++++++++++++++--<br=
>
&gt;=C2=A0 1 file changed, 27 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py<b=
r>
&gt; index 6168c23936f..9919dacd4e6 100644<br>
&gt; --- a/docs/sphinx/qapi_domain.py<br>
&gt; +++ b/docs/sphinx/qapi_domain.py<br>
&gt; @@ -4,6 +4,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from __future__ import annotations<br>
&gt;=C2=A0 <br>
&gt; +import re<br>
&gt;=C2=A0 from typing import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TYPE_CHECKING,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AbstractSet,<br>
&gt; @@ -104,6 +105,18 @@ def process_link(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return title, target<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +def since_validator(param: str) -&gt; str:<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 Validate the `:since: X.Y` option field.<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 match =3D re.match(r&quot;[0-9]+\.[0-9]+&quot;, param)<=
br>
<br>
This accepts arbitrary crap after the version.=C2=A0 Example:<br>
&quot;9.2.50v9.2.0-2253-ge8a0110293&quot; is fine.=C2=A0 Intentional?<br></=
blockquote><div><br></div><div>Nope! O:-) I forgot that match doesn&#39;t i=
mply ^...$</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
&gt; +=C2=A0 =C2=A0 if not match:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ValueError(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;:since: requires a v=
ersion number in X.Y format; not {param!r}&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 return param<br>
<br>
Schema validation is the frontend&#39;s job.=C2=A0 Ideally, a backend doesn=
&#39;t<br>
report any errors.=C2=A0 The backends generating C don&#39;t.=C2=A0 A backe=
nd<br>
generating docs has to: all the reST processing happens there, and<br>
therefore reST errors can only be diagnosed there.=C2=A0 Since &quot;no err=
ors&quot;<br>
purity is impossible for this backend, we can be pragmatic about sinning<br=
>
a bit more.<br>
<br>
Still, I think this one should rather go into the doc comment parser.<br>
<br>
This is not a demand.=C2=A0 We can always clean it up later.<br></blockquot=
e><div><br></div><div>You *can* technically use this without touching the Q=
API parser at all, nothing stops you. I.e., you *could* write a QMP referen=
ce manual by hand into an .rst if you wanted.</div><div><br></div><div>That=
 said, I know we probably won&#39;t. I can remove the validator.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 # Alias for the return of handle_signature(), which is used in s=
everal places.<br>
&gt;=C2=A0 # (In the Python domain, this is Tuple[str, str] instead.)<br>
&gt;=C2=A0 Signature =3D str<br>
&gt; @@ -124,6 +137,8 @@ class QAPIObject(ObjectDescription[Signature]):<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Borrowed from the Py=
thon domain:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;module&quot;: di=
rectives.unchanged,=C2=A0 # Override contextual module name<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # These are QAPI originals:=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;since&quot;: since_va=
lidator,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt; @@ -135,9 +150,19 @@ def get_signature_prefix(self) -&gt; List[nodes.N=
ode]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SpaceNode(&quot; &quot=
;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def get_signature_suffix(self) -&gt; list[nodes.Node]:<=
br>
&gt; +=C2=A0 =C2=A0 def get_signature_suffix(self) -&gt; List[nodes.Node]:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns a suffix t=
o put after the object name in the signature.&quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return []<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret: List[nodes.Node] =3D []<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;since&quot; in self.options:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SpaceNode(&qu=
ot; &quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addnodes.desc=
_sig_element(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;&quot;, f&quot;(Since: {self.options[&#39;since&#39;]})&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def handle_signature(self, sig: str, signode: desc=
_signature) -&gt; Signature:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
<br>
</blockquote></div></div>

--000000000000be5a19062fc859be--


