Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FA1C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqlg-00074x-Vf; Wed, 05 Mar 2025 10:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpqlf-00074h-5u
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpqlc-0001cS-Hn
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741188879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wbpsnXiTZKsfLNR0iXEeyPfo7Tu7LdpgjJzX2CeF0Ok=;
 b=Clt49XZfKa78P0LzF/8nJq1QfK2XvBYzOB+ZlV20d35lf6/rOxyxilJeCSD40UOYelp6sw
 6h4hGZk7k+l30E/3kiTgPLn0HWkNoOb5hiaCWWeQpsiqXk2Qhdzyx5GV5kHAnqRBv8yQT9
 6CaCuVlQgMXmZ4j2+CC1FDQs6dLaYuw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-7ysZ25JWN8-9osDnb2X8-Q-1; Wed, 05 Mar 2025 10:34:27 -0500
X-MC-Unique: 7ysZ25JWN8-9osDnb2X8-Q-1
X-Mimecast-MFC-AGG-ID: 7ysZ25JWN8-9osDnb2X8-Q_1741188866
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fe8fdfdd94so13493134a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741188866; x=1741793666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbpsnXiTZKsfLNR0iXEeyPfo7Tu7LdpgjJzX2CeF0Ok=;
 b=mnnRcu3dkr1c31bRW+j/cDT7N9WA/GzUUbe3QCA3bd6JhP6q1MgHDAUSrbDkmlI/mX
 22tJA/pGfzyjr6Si10L9dz4z9yTYR1IVZeSwYhUZP+QSGBkb79uOx1f4zX1DmNHsbnrW
 Dmux3QPMBr20O7TCuYSnnq6ZW96oRNsWqbieroSVaZ6cXM/wISeHK4uHOc44zCtpWTww
 0krjPiczzC2MS3HfT7SkasxK06PwAuXi4mccEOlA0QD4VqWwnUBzV3fGFTAQvbOIsUEw
 ahAd8aKe1ke19YvgH9h4uWyGj3+zxmrId/FLjb+T7L1C2Jn2Ec1JiMwLyD6NLjhcBbm7
 UomQ==
X-Gm-Message-State: AOJu0Yz0V0VHSyaqedPwSYN7ViTHBNCR4jKEDLC0x9JZUVgKVM3MZR4p
 iDKQkZ2Vx9IPDl3Su9hZUQ/wWPi1/cBznC5PlxLhHQ6vIiI5ublI4gPWie7+1SrtxwOkuntfMP4
 +djEcwmZW357u0PW0eDNZ0vkus2S0rW1HssVZUhhcJo8AFXRscJDC5IL2nvgShzOdgFGky0PXI5
 kPqnwBx2XhBYlOfA01ja2HU6ZKzNA=
X-Gm-Gg: ASbGnctV6H8Fkf/TiTWwcs0/ZE4BvMVQtbvB7Qk67fNRUtDyKwPGB8m1b09bz4mz22K
 NN1bKx9Zd+eO0YP4dW802GAYbkG4oGggTPQ7qaHk740IQtuS1ZS8W8/CZAMmyoyYe62ENjbf/hP
 o4kaTmRuQMHz7ZRMEnhwypszKaOpUT
X-Received: by 2002:a17:90a:da90:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2ff497a0762mr5877272a91.27.1741188866331; 
 Wed, 05 Mar 2025 07:34:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNuM/V1/7yE4VzE4z6ea3heU/arVHOPFwyMDuFtZCtlf5f8GIpWyCokMM6Zp23Oh212w6UUxYNOA7ZUJIjf7g=
X-Received: by 2002:a17:90a:da90:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2ff497a0762mr5877239a91.27.1741188865931; Wed, 05 Mar 2025
 07:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-22-jsnow@redhat.com>
 <87v7snon6o.fsf@pond.sub.org>
In-Reply-To: <87v7snon6o.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 5 Mar 2025 10:34:12 -0500
X-Gm-Features: AQ5f1JorBIGUSxxtmM_NJCeQFW4kAJO_tGq1fxW9I-cpFMZtmb2Qz4Mnmd0QKsY
Message-ID: <CAFn=p-avGWfsjmPFR4DBGD5RrO67Vrh8rzPB1cEOQ7hvpgvBmQ@mail.gmail.com>
Subject: Re: [PATCH 21/57] docs/qapi-domain: add :deprecated: directive option
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Harmonie Snow <harmonie@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d7594f062f9a1fe6"
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

--000000000000d7594f062f9a1fe6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025, 4:13=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Although "deprecated" is a feature (and *will* appear in the features
> > list), add a special :deprecated: option to generate an eye-catch that
> > makes this information very hard to miss.
> >
> > (The intent is to modify qapidoc.py to add this option whenever it
> > detects that the features list attached to a definition contains the
> > "deprecated" entry.)
> >
> > -
> >
> > RFC: Technically, this object-level option is un-needed and could be
> > replaced with a standard content-level directive that e.g. qapidoc.py
> > could insert at the beginning of the content block. I've done it here a=
s
> > an option to demonstrate how it would be possible to do.
> >
> > It's a matter of taste for "where" we feel like implementing it.
> >
> > One benefit of doing it this way is that we can create a single
> > containing box to set CSS style options controlling the flow of multipl=
e
> > infoboxes. The other way to achieve that would be to create a directive
> > that allows us to set multiple options instead, e.g.:
> >
> > .. qapi:infoboxes:: deprecated unstable
> >
> > or possibly:
> >
> > .. qapi:infoboxes::
> >    :deprecated:
> >    :unstable:
> >
> > For now, I've left these as top-level QAPI object options. "Hey, it
> works."
> >
> > P.S., I outsourced the CSS ;)
> >
> > Signed-off-by: Harmonie Snow <harmonie@gmail.com>
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> > diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> > index fff5cca24cc..1be59e36bdf 100644
> > --- a/docs/sphinx/qapi_domain.py
> > +++ b/docs/sphinx/qapi_domain.py
> > @@ -140,6 +140,7 @@ class QAPIObject(ObjectDescription[Signature]):
> >              "module": directives.unchanged,  # Override contextual
> module name
> >              # These are QAPI originals:
> >              "since": since_validator,
> > +            "deprecated": directives.flag,
> >          }
> >      )
> >
> > @@ -253,6 +254,31 @@ def add_target_and_index(
> >                      ("single", indextext, node_id, "", None)
> >                  )
> >
> > +    def _add_infopips(self, contentnode: addnodes.desc_content) -> Non=
e:
> > +        # Add various eye-catches and things that go below the signatu=
re
> > +        # bar, but precede the user-defined content.
> > +        infopips =3D nodes.container()
> > +        infopips.attributes["classes"].append("qapi-infopips")
> > +
> > +        def _add_pip(source: str, content: str, classname: str) -> Non=
e:
> > +            node =3D nodes.container(source)
> > +            node.append(nodes.Text(content))
> > +            node.attributes["classes"].extend(["qapi-infopip",
> classname])
> > +            infopips.append(node)
> > +
> > +        if "deprecated" in self.options:
> > +            _add_pip(
> > +                ":deprecated:",
> > +                f"This {self.objtype} is deprecated.",
> > +                "qapi-deprecated",
> > +            )
> > +
> > +        if infopips.children:
> > +            contentnode.insert(0, infopips)
> > +
> > +    def transform_content(self, content_node: addnodes.desc_content) -=
>
> None:
>
> pylint warns:
>
>     docs/sphinx/qapi_domain.py:279:4: W0237: Parameter 'contentnode' has
> been renamed to 'content_node' in overriding 'QAPIObject.transform_conten=
t'
> method (arguments-renamed)
>
> For what it's worth, @content_node is easier on on my eyes than
> @contentnode.
>

Almost certifiably a Sphinx version difference that I simply won't be able
to accommodate. It comes back clean against 8.x, and does not impact the
runtime functionality at all.


> > +        self._add_infopips(content_node)
> > +
> >      def _toc_entry_name(self, sig_node: desc_signature) -> str:
> >          # This controls the name in the TOC and on the sidebar.
>
>

--000000000000d7594f062f9a1fe6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, 2025, 4:13=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Although &quot;deprecated&quot; is a feature (and *will* appear in the=
 features<br>
&gt; list), add a special :deprecated: option to generate an eye-catch that=
<br>
&gt; makes this information very hard to miss.<br>
&gt;<br>
&gt; (The intent is to modify qapidoc.py to add this option whenever it<br>
&gt; detects that the features list attached to a definition contains the<b=
r>
&gt; &quot;deprecated&quot; entry.)<br>
&gt;<br>
&gt; -<br>
&gt;<br>
&gt; RFC: Technically, this object-level option is un-needed and could be<b=
r>
&gt; replaced with a standard content-level directive that e.g. qapidoc.py<=
br>
&gt; could insert at the beginning of the content block. I&#39;ve done it h=
ere as<br>
&gt; an option to demonstrate how it would be possible to do.<br>
&gt;<br>
&gt; It&#39;s a matter of taste for &quot;where&quot; we feel like implemen=
ting it.<br>
&gt;<br>
&gt; One benefit of doing it this way is that we can create a single<br>
&gt; containing box to set CSS style options controlling the flow of multip=
le<br>
&gt; infoboxes. The other way to achieve that would be to create a directiv=
e<br>
&gt; that allows us to set multiple options instead, e.g.:<br>
&gt;<br>
&gt; .. qapi:infoboxes:: deprecated unstable<br>
&gt;<br>
&gt; or possibly:<br>
&gt;<br>
&gt; .. qapi:infoboxes::<br>
&gt;=C2=A0 =C2=A0 :deprecated:<br>
&gt;=C2=A0 =C2=A0 :unstable:<br>
&gt;<br>
&gt; For now, I&#39;ve left these as top-level QAPI object options. &quot;H=
ey, it works.&quot;<br>
&gt;<br>
&gt; P.S., I outsourced the CSS ;)<br>
&gt;<br>
&gt; Signed-off-by: Harmonie Snow &lt;<a href=3D"mailto:harmonie@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">harmonie@gmail.com</a>&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py<b=
r>
&gt; index fff5cca24cc..1be59e36bdf 100644<br>
&gt; --- a/docs/sphinx/qapi_domain.py<br>
&gt; +++ b/docs/sphinx/qapi_domain.py<br>
&gt; @@ -140,6 +140,7 @@ class QAPIObject(ObjectDescription[Signature]):<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;module&quot;: di=
rectives.unchanged,=C2=A0 # Override contextual module name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # These are QAPI origi=
nals:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;since&quot;: sin=
ce_validator,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;deprecated&quot;: dir=
ectives.flag,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt; @@ -253,6 +254,31 @@ def add_target_and_index(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (&quot;single&quot;, indextext, node_id, &quot;&quot;, None)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def _add_infopips(self, contentnode: addnodes.desc_cont=
ent) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add various eye-catches and things that=
 go below the signature<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # bar, but precede the user-defined conte=
nt.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 infopips =3D nodes.container()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 infopips.attributes[&quot;classes&quot;].=
append(&quot;qapi-infopips&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def _add_pip(source: str, content: str, c=
lassname: str) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D nodes.container(so=
urce)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node.append(nodes.Text(cont=
ent))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node.attributes[&quot;class=
es&quot;].extend([&quot;qapi-infopip&quot;, classname])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 infopips.append(node)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;deprecated&quot; in self.options=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _add_pip(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;:deprec=
ated:&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;This {=
self.objtype} is deprecated.&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;qapi-de=
precated&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if infopips.children:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 contentnode.insert(0, infop=
ips)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def transform_content(self, content_node: addnodes.desc=
_content) -&gt; None:<br>
<br>
pylint warns:<br>
<br>
=C2=A0 =C2=A0 docs/sphinx/qapi_domain.py:279:4: W0237: Parameter &#39;conte=
ntnode&#39; has been renamed to &#39;content_node&#39; in overriding &#39;Q=
APIObject.transform_content&#39; method (arguments-renamed)<br>
<br>
For what it&#39;s worth, @content_node is easier on on my eyes than<br>
@contentnode.<br></blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Almost certifiably a Sphinx version difference that I simply w=
on&#39;t be able to accommodate. It comes back clean against 8.x, and does =
not impact the runtime functionality at all.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._add_infopips(content_node)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def _toc_entry_name(self, sig_node: desc_signature=
) -&gt; str:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This controls the name in the TOC =
and on the sidebar.<br>
<br>
</blockquote></div></div></div>

--000000000000d7594f062f9a1fe6--


