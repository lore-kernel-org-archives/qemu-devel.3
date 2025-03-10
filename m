Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AB9C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 21:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trkR6-0007Lj-1E; Mon, 10 Mar 2025 17:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkR2-0007LJ-DK
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkQx-0006c2-Uf
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741641191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ru+ISeZk9dRxq1wvLXnso50P638pojPkk1c0iYxp4Zc=;
 b=XywaWTmgnN825zy9ezGzFTQ1Ai3S3sOgolyAo273q3tcyDyL7IbX29PAVUrlsEu1mbsS+y
 Hk+zT9gPx6EYWPhiV3m1UIi2jrHSS7yhfHpEyaTI1oBIzXF3AeXmnHozn96QCfLNxgosBX
 zdJu6axU9BOpQDiQivOnHEQtK3XvS4o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-UnZ96AclOYC2GpV-_nIGWA-1; Mon, 10 Mar 2025 17:13:09 -0400
X-MC-Unique: UnZ96AclOYC2GpV-_nIGWA-1
X-Mimecast-MFC-AGG-ID: UnZ96AclOYC2GpV-_nIGWA_1741641188
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff799be8f5so6441022a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741641188; x=1742245988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ru+ISeZk9dRxq1wvLXnso50P638pojPkk1c0iYxp4Zc=;
 b=RdSEP5N6Rt1KHPpkSiYCrZUgS1W53N6/GPFOzah+9WGi6tuDDVOZ67w/ObLEGbULwa
 4EBIcs/iT8aLOTzKHcuCA4sfzfBpUBXyfAgrB8xJUuUl0Z6QCDI4zjL0Bb/aJ3Qcxu61
 sU6sq1lUJ1pvwZV/lIKn9WbMy26tnQzivt32I69w4syhruOaiXvn9KsuTEV88qCYR0yv
 KXs4NAwW90PmwXSOqB+MxQuQoRVhXDNjdEXTvI7dGVA+YPXZm0M7sA5wYwr/VPqyyadO
 HPAcmMplbPZoFWtmAAv6dbayvCjJ3ceoQHzFlwiNxRZ3ggqc9xe2p8mPd0LroQRxEIDy
 ytmQ==
X-Gm-Message-State: AOJu0Yy1AqFfIWQW6Vnzy4l8OFEQg9rlnpthuTUexJ4hUol6upHV3ifz
 7vKnANXhtaYcPS+2ucfIujF2KLStOMx9vRkmyekacspqD3XkGW7Wd4JcTEWl7+uVn/vqKCZgDL1
 WqRxQMNv7QwkauGdbZeWYnuy/AE41XAyiOkuwuVsgkYnH8i7sA38rXM1eZBWgR8PC1hlkHt3fyQ
 UPRkD3fel5Dwfh8tr4dBLINl+Y6r4=
X-Gm-Gg: ASbGncsry29BVDNCqZmFKMSdB6ulc1V4CT0LvBLcfMcFoO/MmJXo6yBmeGBBP4Qf2H6
 V7pJ0NESqN/dX4+lMU7C9FC1ncZyfBE9fiufbJ1xTnU49nTezuhYQeRTPgbI2Ko+/ih8gFGuaud
 xfm88vZ35laD0C0PwLJpXmYY0G823J
X-Received: by 2002:a17:90b:224b:b0:2ff:71ad:e84e with SMTP id
 98e67ed59e1d1-2ff7ce7abccmr23722448a91.10.1741641188548; 
 Mon, 10 Mar 2025 14:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5pg4Cm8Mfuca9OI8dwfptbNEkh9YWG81HXIWq7IZwnBChTXsL/R22dVOKLLBExR8e0rnVlbXJooPwJg3TpYI=
X-Received: by 2002:a17:90b:224b:b0:2ff:71ad:e84e with SMTP id
 98e67ed59e1d1-2ff7ce7abccmr23722428a91.10.1741641188141; Mon, 10 Mar 2025
 14:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-11-jsnow@redhat.com>
 <87jz8xtffr.fsf@pond.sub.org>
In-Reply-To: <87jz8xtffr.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Mar 2025 17:12:56 -0400
X-Gm-Features: AQ5f1Jq9VLAoW-90yM0qUNAFaaq1UnaT_kvym1qUXrQ78C-usVDqB2FZsV-C4t0
Message-ID: <CAFn=p-a+CYBZ93j-T+JAwvm7RXX8uHafJm4nwuZzSwYJwcJ38Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/62] docs/qapi-domain: Add ObjectDescription abstract
 class
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000058809b06300370d6"
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

--00000000000058809b06300370d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:15=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This class is a generic, top-level directive for documenting some kind
> > of QAPI thingamajig that we expect to go into the Index. This class
> > doesn't do much by itself, and it isn't yet associated with any
> > particular directive.
> >
> > Only handle_signature() is defined in the base class; get_index_text an=
d
> > add_target_and_index are new methods defined here; they are based
> > heavily on the layout and format of the Python domain's general object
> > class.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapi_domain.py | 65 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 63 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> > index 49d42c0921c..0365891f354 100644
> > --- a/docs/sphinx/qapi_domain.py
> > +++ b/docs/sphinx/qapi_domain.py
> > @@ -14,11 +14,13 @@
> >      NamedTuple,
> >      Optional,
> >      Tuple,
> > +    cast,
> >  )
> >
> >  from docutils import nodes
> >
> > -from sphinx.addnodes import pending_xref
> > +from sphinx.addnodes import desc_signature, pending_xref
> > +from sphinx.directives import ObjectDescription
> >  from sphinx.domains import (
> >      Domain,
> >      Index,
> > @@ -28,7 +30,7 @@
> >  from sphinx.locale import _, __
> >  from sphinx.roles import XRefRole
> >  from sphinx.util import logging
> > -from sphinx.util.nodes import make_refnode
> > +from sphinx.util.nodes import make_id, make_refnode
> >
> >
> >  if TYPE_CHECKING:
> > @@ -96,6 +98,65 @@ def process_link(
> >          return title, target
> >
> >
> > +Signature =3D str
> > +
> > +
> > +class QAPIDescription(ObjectDescription[Signature]):
> > +    """
> > +    Generic QAPI description.
> > +
> > +    Abstract class, not instantiated directly.
> > +    """
> > +
> > +    def handle_signature(self, sig: str, signode: desc_signature) ->
> Signature:
> > +        # Do nothing. The return value here is the "name" of the entit=
y
> > +        # being documented; for QAPI, this is the same as the
> > +        # "signature", which is just a name.
> > +
> > +        # Normally this method must also populate signode with nodes t=
o
> > +        # render the signature; here we do nothing instead.
> > +        return sig
> > +
> > +    def get_index_text(self, name: Signature) -> Tuple[str, str]:
> > +        """Return the text for the index entry of the object."""
> > +
> > +        # NB: this is used for the global index, not the QAPI index.
> > +        return ("single", f"{name} (QMP {self.objtype})")
> > +
> > +    def add_target_and_index(
> > +        self, name: Signature, sig: str, signode: desc_signature
> > +    ) -> None:
> > +        # name is the return value of handle_signature.
> > +        # sig is the original, raw text argument to handle_signature.
> > +        # For QAPI, these are identical, currently.
> > +
> > +        assert self.objtype
> > +
> > +        # If we're documenting a module, don't include the module as
> > +        # part of the FQN.
> > +        modname =3D ""
> > +        if self.objtype !=3D "module":
> > +            modname =3D self.options.get(
> > +                "module", self.env.ref_context.get("qapi:module")
> > +            )
> > +        fullname =3D (modname + "." if modname else "") + name
> > +
> > +        node_id =3D make_id(self.env, self.state.document, self.objtyp=
e,
> fullname)
>
> pycodestyle-3 points out:
>
>     docs/sphinx/qapi_domain.py:144:80: E501 line too long (80 > 79
> characters)
>

Adjusted my black config to aim for 79 chars instead of 80 and it fixes
this one.


>
> > +        signode["ids"].append(node_id)
> > +
> > +        self.state.document.note_explicit_target(signode)
> > +        domain =3D cast(QAPIDomain, self.env.get_domain("qapi"))
> > +        domain.note_object(fullname, self.objtype, node_id,
> location=3Dsignode)
>
> This one's pushing it, too :)
>

black left this one alone, though. For consistency I'm just doing whatever
black tells me.


>
> > +
> > +        if "no-index-entry" not in self.options:
> > +            arity, indextext =3D self.get_index_text(name)
> > +            assert self.indexnode is not None
> > +            if indextext:
> > +                self.indexnode["entries"].append(
> > +                    (arity, indextext, node_id, "", None)
> > +                )
> > +
> > +
> >  class QAPIIndex(Index):
> >      """
> >      Index subclass to provide the QAPI definition index.
>
>

--00000000000058809b06300370d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 10,=
 2025 at 5:15=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This class is a generic, top-level directive for documenting some kind=
<br>
&gt; of QAPI thingamajig that we expect to go into the Index. This class<br=
>
&gt; doesn&#39;t do much by itself, and it isn&#39;t yet associated with an=
y<br>
&gt; particular directive.<br>
&gt;<br>
&gt; Only handle_signature() is defined in the base class; get_index_text a=
nd<br>
&gt; add_target_and_index are new methods defined here; they are based<br>
&gt; heavily on the layout and format of the Python domain&#39;s general ob=
ject<br>
&gt; class.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapi_domain.py | 65 ++++++++++++++++++++++++++++++++=
++++--<br>
&gt;=C2=A0 1 file changed, 63 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py<b=
r>
&gt; index 49d42c0921c..0365891f354 100644<br>
&gt; --- a/docs/sphinx/qapi_domain.py<br>
&gt; +++ b/docs/sphinx/qapi_domain.py<br>
&gt; @@ -14,11 +14,13 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 NamedTuple,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Optional,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Tuple,<br>
&gt; +=C2=A0 =C2=A0 cast,<br>
&gt;=C2=A0 )<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from docutils import nodes<br>
&gt;=C2=A0 <br>
&gt; -from sphinx.addnodes import pending_xref<br>
&gt; +from sphinx.addnodes import desc_signature, pending_xref<br>
&gt; +from sphinx.directives import ObjectDescription<br>
&gt;=C2=A0 from sphinx.domains import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Domain,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Index,<br>
&gt; @@ -28,7 +30,7 @@<br>
&gt;=C2=A0 from sphinx.locale import _, __<br>
&gt;=C2=A0 from sphinx.roles import XRefRole<br>
&gt;=C2=A0 from sphinx.util import logging<br>
&gt; -from sphinx.util.nodes import make_refnode<br>
&gt; +from sphinx.util.nodes import make_id, make_refnode<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 if TYPE_CHECKING:<br>
&gt; @@ -96,6 +98,65 @@ def process_link(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return title, target<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +Signature =3D str<br>
&gt; +<br>
&gt; +<br>
&gt; +class QAPIDescription(ObjectDescription[Signature]):<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 Generic QAPI description.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 Abstract class, not instantiated directly.<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def handle_signature(self, sig: str, signode: desc_sign=
ature) -&gt; Signature:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Do nothing. The return value here is th=
e &quot;name&quot; of the entity<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # being documented; for QAPI, this is the=
 same as the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # &quot;signature&quot;, which is just a =
name.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Normally this method must also populate=
 signode with nodes to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # render the signature; here we do nothin=
g instead.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sig<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def get_index_text(self, name: Signature) -&gt; Tuple[s=
tr, str]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Return the text for the=
 index entry of the object.&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # NB: this is used for the global index, =
not the QAPI index.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (&quot;single&quot;, f&quot;{name}=
 (QMP {self.objtype})&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def add_target_and_index(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, name: Signature, sig: str, signode:=
 desc_signature<br>
&gt; +=C2=A0 =C2=A0 ) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # name is the return value of handle_sign=
ature.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # sig is the original, raw text argument =
to handle_signature.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For QAPI, these are identical, currentl=
y.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.objtype<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If we&#39;re documenting a module, don&=
#39;t include the module as<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # part of the FQN.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modname =3D &quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.objtype !=3D &quot;module&quot;:<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modname =3D self.options.ge=
t(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;module&=
quot;, self.env.ref_context.get(&quot;qapi:module&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fullname =3D (modname + &quot;.&quot; if =
modname else &quot;&quot;) + name<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_id =3D make_id(self.env, self.state.=
document, self.objtype, fullname)<br>
<br>
pycodestyle-3 points out:<br>
<br>
=C2=A0 =C2=A0 docs/sphinx/qapi_domain.py:144:80: E501 line too long (80 &gt=
; 79 characters)<br></blockquote><div><br></div><div>Adjusted my black conf=
ig to aim for 79 chars instead of 80 and it fixes this one.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 signode[&quot;ids&quot;].append(node_id)<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.state.document.note_explicit_target(=
signode)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 domain =3D cast(QAPIDomain, self.env.get_=
domain(&quot;qapi&quot;))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 domain.note_object(fullname, self.objtype=
, node_id, location=3Dsignode)<br>
<br>
This one&#39;s pushing it, too :)<br></blockquote><div><br></div><div>black=
 left this one alone, though. For consistency I&#39;m just doing whatever b=
lack tells me.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;no-index-entry&quot; not in self=
.options:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arity, indextext =3D self.g=
et_index_text(name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.indexnode is no=
t None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if indextext:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.indexnod=
e[&quot;entries&quot;].append(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (arity, indextext, node_id, &quot;&quot;, None)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 class QAPIIndex(Index):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Index subclass to provide the QAPI definition inde=
x.<br>
<br>
</blockquote></div></div>

--00000000000058809b06300370d6--


