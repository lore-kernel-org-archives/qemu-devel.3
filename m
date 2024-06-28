Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D89C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDSw-0006Bx-CX; Fri, 28 Jun 2024 11:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNDSv-0006BS-1X
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNDSr-0000ka-W5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719588281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DsP0R0SdMxfIzKtCUKKSxVlFnQALg06Nogb80c5+Qo8=;
 b=H6spkydFIcXIhM1WkgBNUOIyTDdcVvu0lWn6aUztRpgoGRxzk8NHUL3zRZeUBoaMEt1TMi
 afAIwP4ugae+BzXq64eKILXnNYxcXwH84TiI+z7T9hobtHvI7G6yt1Rbq/dZzJ0ceZlP4Y
 enFoNeK1KTu4Os54/E48cjTXalAqsO0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-vqh4-GahMDmKP8ZT2LSvFg-1; Fri, 28 Jun 2024 11:24:39 -0400
X-MC-Unique: vqh4-GahMDmKP8ZT2LSvFg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-70668593437so650596b3a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719588278; x=1720193078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DsP0R0SdMxfIzKtCUKKSxVlFnQALg06Nogb80c5+Qo8=;
 b=eCb4sOJoTjYct3K5fRw/Ytxh5mMzEka5jPnDW6/+yejmzJmxOgzntHtrtu4X8UX7Gk
 1ZHm990p/kZEWWkDFMePzF2+8+rol+m+kIU/asVvtfj6bTzXjjn672e+H9sNKzZxyMqf
 UZYcNekbbJlGgP3D3JsrSLLzelefOqB5Y3tigdN8p0FkBP+uzSzou/mRwD+OwgkWbjsI
 GFsa78UbX1hW5mrmSAc7jTdakqjXNJzGFqsmY5d8R4yYAlsc4X7py+J/08p49vNbGsPU
 /zYu1giQEuSZKketDcHmcVMk/Nhv3SIHD14thG8OQ/Es4cqSEWs+PXDNZvAjZ/DyXnY/
 tZ7A==
X-Gm-Message-State: AOJu0YxcTEitLmxsSNozzmrBhm5s7d3yUjsWneOtC/b9knTWKSX0Au5M
 rOY058HWz/FFztvCM0UYy+Qy6Ks8xXRCwMexmq5/aHkKvUmTx9bugEbLe+XlpKvAgJO8zHM/TtZ
 hb1AViiSR8XX6mNCbub17LqIImmjUF09pCX+S0YOSM28t4P2doqD1wvSgdbHD+SFE3fYWleW8PK
 R4+cac9wtH8TGUQ53zSKbReImRoBc=
X-Received: by 2002:a05:6a00:1703:b0:705:9bd8:4f57 with SMTP id
 d2e1a72fcca58-70670e8fbc0mr22025504b3a.7.1719588278106; 
 Fri, 28 Jun 2024 08:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgGkvgZJR4VOMtDBJ7lVdCpHvUCxxkFngDb866dz9tSv7AG1XtvCWFp4tnqY31BV1mu88kk8Y6sKS1IcYQQX8=
X-Received: by 2002:a05:6a00:1703:b0:705:9bd8:4f57 with SMTP id
 d2e1a72fcca58-70670e8fbc0mr22025467b3a.7.1719588277645; Fri, 28 Jun 2024
 08:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-16-jsnow@redhat.com>
 <87msn5xksj.fsf@pond.sub.org>
In-Reply-To: <87msn5xksj.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 28 Jun 2024 11:24:25 -0400
Message-ID: <CAFn=p-aDS6XHGs5DHp=P6H3B3CP4fMnrnestiMYTErFE+wE+WA@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] docs/qapidoc: create qmp-example directive
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mads Ynddal <mads@ynddal.dk>,
 Jiri Pirko <jiri@resnulli.us>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth <michael.roth@amd.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Ani Sinha <anisinha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000073100f061bf4d836"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000073100f061bf4d836
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024, 9:24=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This is a directive that creates a syntactic sugar for creating
> > "Example" boxes very similar to the ones already used in the bitmaps.rs=
t
> > document, please see e.g.
> >
> https://www.qemu.org/docs/master/interop/bitmaps.html#creation-block-dirt=
y-bitmap-add
> >
> > In its simplest form, when a custom title is not needed or wanted, and
> > the example body is *solely* a QMP example:
> >
> > ```
> > .. qmp-example::
> >
> >    {body}
> > ```
> >
> > is syntactic sugar for:
> >
> > ```
> > .. admonition:: Example:
> >
> >    .. code-block:: QMP
> >
> >       {body}
> > ```
> >
> > When a custom, plaintext title that describes the example is desired,
> > this form:
> >
> > ```
> > .. qmp-example::
> >    :title: Defrobnification
> >
> >    {body}
> > ```
> >
> > Is syntactic sugar for:
> >
> > ```
> > .. admonition:: Example: Defrobnification
> >
> >    .. code-block:: QMP
> >
> >       {body}
> > ```
> >
> > Lastly, when Examples are multi-step processes that require non-QMP
> > exposition, have lengthy titles, or otherwise involve prose with rST
> > markup (lists, cross-references, etc), the most complex form:
> >
> > ```
> > .. qmp-example::
> >    :annotated:
> >
> >    This example shows how to use `foo-command`::
> >
> >      {body}
> > ```
> >
> > Is desugared to:
> >
> > ```
> > .. admonition:: Example:
> >
> >    This example shows how to use `foo-command`::
> >
> >      {body}
> >
> >    For more information, please see `frobnozz`.
> > ```
>

^ Whoops, added prose in the desugar block without modifying the original.


> Can we combine the latter two?  Like this:
>
>   .. qmp-example::
>      :title: Defrobnification
>      :annotated:
>
>      This example shows how to use `foo-command`::
>
>        {body}
>

Yes! I only didn't use that form in the series because splitting longer
Examples into title and prose felt like an editorial decision, but
absolutely you can use both.


> > The primary benefit here being documentation source consistently using
> > the same directive for all forms of examples to ensure consistent visua=
l
> > styling, and ensuring all relevant prose is visually grouped alongside
> > the code literal block.
> >
> > Note that as of this commit, the code-block rST syntax "::" does not
> > apply QMP highlighting; you would need to use ".. code-block:: QMP". Th=
e
> > very next commit changes this behavior to assume all "::" code blocks
> > within this directive are QMP blocks.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 60 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 58 insertions(+), 2 deletions(-)
>
> No tests?  Hmm, I see you convert existing tests in PATCH 19-21.  While
> that works, test coverage now would make it easier to see how each patch
> affects doc generator output.
>

Mmm. Do you want me to move the test changes up to this patch ... ?


> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 43dd99e21e6..a2fa05fc491 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -27,16 +27,19 @@
> >  import os
> >  import re
> >  import textwrap
> > +from typing import List
> >
> >  from docutils import nodes
> > -from docutils.parsers.rst import Directive, directives
> > +from docutils.parsers.rst import directives
> >  from docutils.statemachine import ViewList
> >  from qapi.error import QAPIError, QAPISemError
> >  from qapi.gen import QAPISchemaVisitor
> >  from qapi.schema import QAPISchema
> >
> >  import sphinx
> > +from sphinx.directives.code import CodeBlock
> >  from sphinx.errors import ExtensionError
> > +from sphinx.util.docutils import SphinxDirective
> >  from sphinx.util.nodes import nested_parse_with_titles
> >
> >
> > @@ -494,7 +497,7 @@ def visit_module(self, name):
> >          super().visit_module(name)
> >
> >
> > -class NestedDirective(Directive):
> > +class NestedDirective(SphinxDirective):
>
> What is this about?
>

Hmm. Strictly it's for access to sphinx configuration which I use only in
the next patch, but practically I suspect if I don't change it *here* that
the multiple inheritance from CodeBlock (which is a SphinxDirective) would
possibly be stranger.

I can try delaying that change by a patch and see if it hurts anything ...


> >      def run(self):
> >          raise NotImplementedError
> >
> > @@ -567,10 +570,63 @@ def run(self):
> >              raise ExtensionError(str(err)) from err
> >
> >
> > +class QMPExample(CodeBlock, NestedDirective):
> > +    """
> > +    Custom admonition for QMP code examples.
> > +
> > +    When the :annotated: option is present, the body of this directive
> > +    is parsed as normal rST instead. Code blocks must be explicitly
> > +    written by the user, but this allows for intermingling explanatory
> > +    paragraphs with arbitrary rST syntax and code blocks for more
> > +    involved examples.
> > +
> > +    When :annotated: is absent, the directive body is treated as a
> > +    simple standalone QMP code block literal.
> > +    """
> > +
> > +    required_argument =3D 0
> > +    optional_arguments =3D 0
> > +    has_content =3D True
> > +    option_spec =3D {
> > +        "annotated": directives.flag,
> > +        "title": directives.unchanged,
> > +    }
> > +
> > +    def admonition_wrap(self, *content) -> List[nodes.Node]:
> > +        title =3D "Example:"
> > +        if "title" in self.options:
> > +            title =3D f"{title} {self.options['title']}"
> > +
> > +        admon =3D nodes.admonition(
> > +            "",
> > +            nodes.title("", title),
> > +            *content,
> > +            classes=3D["admonition", "admonition-example"],
> > +        )
> > +        return [admon]
> > +
> > +    def run_annotated(self) -> List[nodes.Node]:
> > +        content_node: nodes.Element =3D nodes.section()
> > +        self.do_parse(self.content, content_node)
> > +        return content_node.children
> > +
> > +    def run(self) -> List[nodes.Node]:
> > +        annotated =3D "annotated" in self.options
> > +
> > +        if annotated:
> > +            content_nodes =3D self.run_annotated()
> > +        else:
> > +            self.arguments =3D ["QMP"]
> > +            content_nodes =3D super().run()
> > +
> > +        return self.admonition_wrap(*content_nodes)
> > +
> > +
> >  def setup(app):
> >      """Register qapi-doc directive with Sphinx"""
> >      app.add_config_value("qapidoc_srctree", None, "env")
> >      app.add_directive("qapi-doc", QAPIDocDirective)
> > +    app.add_directive("qmp-example", QMPExample)
> >
> >      return {
> >          "version": __version__,
>
>

--00000000000073100f061bf4d836
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 28, 2024, 9:24=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; This is a directive that creates a syntactic sugar for creating<br>
&gt; &quot;Example&quot; boxes very similar to the ones already used in the=
 bitmaps.rst<br>
&gt; document, please see e.g.<br>
&gt; <a href=3D"https://www.qemu.org/docs/master/interop/bitmaps.html#creat=
ion-block-dirty-bitmap-add" rel=3D"noreferrer noreferrer" target=3D"_blank"=
>https://www.qemu.org/docs/master/interop/bitmaps.html#creation-block-dirty=
-bitmap-add</a><br>
&gt;<br>
&gt; In its simplest form, when a custom title is not needed or wanted, and=
<br>
&gt; the example body is *solely* a QMP example:<br>
&gt;<br>
&gt; ```<br>
&gt; .. qmp-example::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 {body}<br>
&gt; ```<br>
&gt;<br>
&gt; is syntactic sugar for:<br>
&gt;<br>
&gt; ```<br>
&gt; .. admonition:: Example:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 .. code-block:: QMP<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{body}<br>
&gt; ```<br>
&gt;<br>
&gt; When a custom, plaintext title that describes the example is desired,<=
br>
&gt; this form:<br>
&gt;<br>
&gt; ```<br>
&gt; .. qmp-example::<br>
&gt;=C2=A0 =C2=A0 :title: Defrobnification<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 {body}<br>
&gt; ```<br>
&gt;<br>
&gt; Is syntactic sugar for:<br>
&gt;<br>
&gt; ```<br>
&gt; .. admonition:: Example: Defrobnification<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 .. code-block:: QMP<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{body}<br>
&gt; ```<br>
&gt;<br>
&gt; Lastly, when Examples are multi-step processes that require non-QMP<br=
>
&gt; exposition, have lengthy titles, or otherwise involve prose with rST<b=
r>
&gt; markup (lists, cross-references, etc), the most complex form:<br>
&gt;<br>
&gt; ```<br>
&gt; .. qmp-example::<br>
&gt;=C2=A0 =C2=A0 :annotated:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 This example shows how to use `foo-command`::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {body}<br>
&gt; ```<br>
&gt;<br>
&gt; Is desugared to:<br>
&gt;<br>
&gt; ```<br>
&gt; .. admonition:: Example:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 This example shows how to use `foo-command`::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {body}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 For more information, please see `frobnozz`.<br>
&gt; ```<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">^ Whoops, added prose in the desugar block without modifying the =
original.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
Can we combine the latter two?=C2=A0 Like this:<br>
<br>
=C2=A0 .. qmp-example::<br>
=C2=A0 =C2=A0 =C2=A0:title: Defrobnification<br>
=C2=A0 =C2=A0 =C2=A0:annotated:<br>
<br>
=C2=A0 =C2=A0 =C2=A0This example shows how to use `foo-command`::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0{body}<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Yes! I only didn&#39;t use that form in th=
e series because splitting longer Examples into title and prose felt like a=
n editorial decision, but absolutely you can use both.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
&gt; The primary benefit here being documentation source consistently using=
<br>
&gt; the same directive for all forms of examples to ensure consistent visu=
al<br>
&gt; styling, and ensuring all relevant prose is visually grouped alongside=
<br>
&gt; the code literal block.<br>
&gt;<br>
&gt; Note that as of this commit, the code-block rST syntax &quot;::&quot; =
does not<br>
&gt; apply QMP highlighting; you would need to use &quot;.. code-block:: QM=
P&quot;. The<br>
&gt; very next commit changes this behavior to assume all &quot;::&quot; co=
de blocks<br>
&gt; within this directive are QMP blocks.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 60 ++++++++++++++++++++++++++++++++++++=
++++--<br>
&gt;=C2=A0 1 file changed, 58 insertions(+), 2 deletions(-)<br>
<br>
No tests?=C2=A0 Hmm, I see you convert existing tests in PATCH 19-21.=C2=A0=
 While<br>
that works, test coverage now would make it easier to see how each patch<br=
>
affects doc generator output.<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Mmm. Do you want me to move the test changes u=
p to this patch ... ?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 43dd99e21e6..a2fa05fc491 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -27,16 +27,19 @@<br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 import re<br>
&gt;=C2=A0 import textwrap<br>
&gt; +from typing import List<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from docutils import nodes<br>
&gt; -from docutils.parsers.rst import Directive, directives<br>
&gt; +from docutils.parsers.rst import directives<br>
&gt;=C2=A0 from docutils.statemachine import ViewList<br>
&gt;=C2=A0 from qapi.error import QAPIError, QAPISemError<br>
&gt;=C2=A0 from qapi.gen import QAPISchemaVisitor<br>
&gt;=C2=A0 from qapi.schema import QAPISchema<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 import sphinx<br>
&gt; +from sphinx.directives.code import CodeBlock<br>
&gt;=C2=A0 from sphinx.errors import ExtensionError<br>
&gt; +from sphinx.util.docutils import SphinxDirective<br>
&gt;=C2=A0 from sphinx.util.nodes import nested_parse_with_titles<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; @@ -494,7 +497,7 @@ def visit_module(self, name):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().visit_module(name)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; -class NestedDirective(Directive):<br>
&gt; +class NestedDirective(SphinxDirective):<br>
<br>
What is this about?<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Hmm. Strictly it&#39;s for access to sphinx configuratio=
n which I use only in the next patch, but practically I suspect if I don&#3=
9;t change it *here* that the multiple inheritance from CodeBlock (which is=
 a SphinxDirective) would possibly be stranger.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">I can try delaying that change by a patch and see i=
f it hurts anything ...</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def run(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise NotImplementedError<br>
&gt;=C2=A0 <br>
&gt; @@ -567,10 +570,63 @@ def run(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ExtensionError(s=
tr(err)) from err<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +class QMPExample(CodeBlock, NestedDirective):<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 Custom admonition for QMP code examples.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 When the :annotated: option is present, the body of thi=
s directive<br>
&gt; +=C2=A0 =C2=A0 is parsed as normal rST instead. Code blocks must be ex=
plicitly<br>
&gt; +=C2=A0 =C2=A0 written by the user, but this allows for intermingling =
explanatory<br>
&gt; +=C2=A0 =C2=A0 paragraphs with arbitrary rST syntax and code blocks fo=
r more<br>
&gt; +=C2=A0 =C2=A0 involved examples.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 When :annotated: is absent, the directive body is treat=
ed as a<br>
&gt; +=C2=A0 =C2=A0 simple standalone QMP code block literal.<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 required_argument =3D 0<br>
&gt; +=C2=A0 =C2=A0 optional_arguments =3D 0<br>
&gt; +=C2=A0 =C2=A0 has_content =3D True<br>
&gt; +=C2=A0 =C2=A0 option_spec =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;annotated&quot;: directives.flag,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;title&quot;: directives.unchanged,<=
br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def admonition_wrap(self, *content) -&gt; List[nodes.No=
de]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 title =3D &quot;Example:&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;title&quot; in self.options:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 title =3D f&quot;{title} {s=
elf.options[&#39;title&#39;]}&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 admon =3D nodes.admonition(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodes.title(&quot;&quot;, t=
itle),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *content,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 classes=3D[&quot;admonition=
&quot;, &quot;admonition-example&quot;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return [admon]<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def run_annotated(self) -&gt; List[nodes.Node]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 content_node: nodes.Element =3D nodes.sec=
tion()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_parse(self.content, content_node)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return content_node.children<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def run(self) -&gt; List[nodes.Node]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 annotated =3D &quot;annotated&quot; in se=
lf.options<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if annotated:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content_nodes =3D self.run_=
annotated()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arguments =3D [&quot;Q=
MP&quot;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content_nodes =3D super().r=
un()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.admonition_wrap(*content_node=
s)<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 def setup(app):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Register qapi-doc directive with=
 Sphinx&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 app.add_config_value(&quot;qapidoc_srctree&quot;, =
None, &quot;env&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 app.add_directive(&quot;qapi-doc&quot;, QAPIDocDir=
ective)<br>
&gt; +=C2=A0 =C2=A0 app.add_directive(&quot;qmp-example&quot;, QMPExample)<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;version&quot;: __version__,<br=
>
<br>
</blockquote></div></div></div>

--00000000000073100f061bf4d836--


