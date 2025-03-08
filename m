Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04885C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 18:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqyyX-00081j-Cp; Sat, 08 Mar 2025 13:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqyyU-00081L-Ba
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 13:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqyyR-0001YK-Id
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 13:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741458749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+UJUsLgqfGSQG8M8l8fZY5IVOdIKhfNgNZkoe0rqjWo=;
 b=HQy0n498FqQbWUywF75pkL0hV3hLPI/OG1bcxy46uOEASb4b2scNk7xx2Gu+ICrFp6NXeP
 tRHoj9gTZb8hgshow6uRwPVcJYWML9QDb7oJuVfgHSM+pi7E2dhfyzapF+taIXjq/DjJqE
 IZ9UH9IANe6otU9hr0xKq59dMcaCjwE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-_jHnUmlyOUu81juD9thKaQ-1; Sat, 08 Mar 2025 13:32:27 -0500
X-MC-Unique: _jHnUmlyOUu81juD9thKaQ-1
X-Mimecast-MFC-AGG-ID: _jHnUmlyOUu81juD9thKaQ_1741458746
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2254e0b4b85so6663035ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 10:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741458745; x=1742063545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+UJUsLgqfGSQG8M8l8fZY5IVOdIKhfNgNZkoe0rqjWo=;
 b=XF6XpHBtIzcUI5RWN2In1PtLHLPWhbiSTUNlC6v4MJseWL36WI1kYmOwmUKsAZ8W+j
 XCDqX2Lr0OxLAzeIujclQSYR0USWvWtNi168ah3FoEkcX6lmKIVKykDeeo29anorTKOS
 7fXpcpN2CSrgO73AqAHer8L74IG8+Whtz/r7Zr2VJmCwBNdCX4eFQiIQeY1Mv/NVH3Mr
 K6l3DsrXk27U9Zq9RITyA7ifgz3klDO6yu+9Pez1AX0gzEEOXow8cVoRE+QhAv/1KQ3d
 Zly5WKzliWlEFKsdkOBKnV49FeGWQ/PlgDS95qOu14NcfLSW2dzCY042GvsqSu0S0Cdw
 CtSA==
X-Gm-Message-State: AOJu0YyalJN3Fn9Tj8bCWnEtD5cK37FgQ2vcQOl2mjHF4wV3yVNUHMFa
 MIat3C3aWrqdubD7KmmTwKf3b6p+P78Hk6wpkghVGLEXmux8iObNCDqRl3xkfgAI80esIFH1HjX
 N/8X7BjVyDeMHvYYbh0d3JWrKd8VBh7AoamwlkIe0MjHsdyjofy97r9BMFmgOj+EgTfe7+my2WO
 YIzni4IiTh0yI+1XpdZl9uWYYqWOozPVsCNHw=
X-Gm-Gg: ASbGncuOewElYbezQg6GcNcnAZOXioI/Fq+tp8HCWaMnYFIiWoE5y8/dcyYUwfmC1gy
 i9DEwCaIc+JqnnuM1fTiaRcPWdXSexneSHEpPKdjskLxmq33c3JKBdGmdIoJJ6ZeyQF+F6w==
X-Received: by 2002:a17:903:8cd:b0:21f:53a5:19e0 with SMTP id
 d9443c01a7336-2246285e46fmr77227765ad.12.1741458745263; 
 Sat, 08 Mar 2025 10:32:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbiJsg9tOLOpcbMYSL3KS/0JJVoGyyoBjhWU+IdJlVTV4lZzIqF9kPvN7wl3GcUP57FKObwIv/i7c4YO2T9zQ=
X-Received: by 2002:a17:903:8cd:b0:21f:53a5:19e0 with SMTP id
 d9443c01a7336-2246285e46fmr77227375ad.12.1741458744865; Sat, 08 Mar 2025
 10:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-36-jsnow@redhat.com>
 <878qphkq4i.fsf@pond.sub.org>
In-Reply-To: <878qphkq4i.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 13:32:12 -0500
X-Gm-Features: AQ5f1Jq5X2ujWUgYczjkN49kZaNEkDM9_QsdcoiO9wRy4g3iiQrpvSbHmmWv-NY
Message-ID: <CAFn=p-bjiZcLGtaOh01745Qb4zpSWdj8G5LeXBOb8=5Uex-ytQ@mail.gmail.com>
Subject: Re: [PATCH 35/57] docs/qapidoc: Fix static typing on qapidoc.py
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e10fc3062fd8f509"
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

--000000000000e10fc3062fd8f509
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:00=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Now that the legacy code is factored out, fix up the typing on the
> > remaining code in qapidoc.py. Add a type ignore to qapi_legacy.py to
> > prevent the errors there from bleeding out into qapidoc.py.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py        | 40 ++++++++++++++++++++++-------------
> >  docs/sphinx/qapidoc_legacy.py |  1 +
> >  2 files changed, 26 insertions(+), 15 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index f4abf42e7bf..5246832b68c 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -24,17 +24,18 @@
> >  https://www.sphinx-doc.org/en/master/development/index.html
> >  """
> >
> > +from __future__ import annotations
> > +
> >  import os
> >  import sys
> > -from typing import List
> > +from typing import TYPE_CHECKING
> >
> >  from docutils import nodes
> >  from docutils.parsers.rst import Directive, directives
> >  from qapi.error import QAPIError
> > -from qapi.gen import QAPISchemaVisitor
> > -from qapi.schema import QAPISchema
> > +from qapi.schema import QAPISchema, QAPISchemaVisitor
> >
> > -from qapidoc_legacy import QAPISchemaGenRSTVisitor
> > +from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
> >  from sphinx import addnodes
> >  from sphinx.directives.code import CodeBlock
> >  from sphinx.errors import ExtensionError
> > @@ -42,6 +43,15 @@
> >  from sphinx.util.nodes import nested_parse_with_titles
> >
> >
> > +if TYPE_CHECKING:
> > +    from typing import Any, List, Sequence
> > +
> > +    from docutils.statemachine import StringList
> > +
> > +    from sphinx.application import Sphinx
> > +    from sphinx.util.typing import ExtensionMetadata
>
> Can you briefly explain why this needs to be conditional?
>

No requisite, but if they aren't used outside of type hints, they don't
actually need to be imported at runtime (when we use from __future__ import
annotations). Improves startup speed slightly and potentially makes the
plugin less porcelain at runtime.


>
> > +
> > +
> >  __version__ =3D "1.0"
> >
> >
> > @@ -53,11 +63,11 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
> >      schema file associated with each module in the QAPI input.
> >      """
> >
> > -    def __init__(self, env, qapidir):
> > +    def __init__(self, env: Any, qapidir: str) -> None:
>
> @env is QAPIDocDirective.state.document.settings.env, i.e. something
> deep in Sphinx.  I assume Any is the best Sphinx lets you do here.
>

Will double-check, I did this a while ago.


>
> >          self._env =3D env
> >          self._qapidir =3D qapidir
> >
> > -    def visit_module(self, name):
> > +    def visit_module(self, name: str) -> None:
> >          if name !=3D "./builtin":
> >              qapifile =3D self._qapidir + "/" + name
> >              self._env.note_dependency(os.path.abspath(qapifile))
> > @@ -65,10 +75,10 @@ def visit_module(self, name):
> >
> >
> >  class NestedDirective(Directive):
> > -    def run(self):
> > +    def run(self) -> Sequence[nodes.Node]:
> >          raise NotImplementedError
> >
> > -    def do_parse(self, rstlist, node):
> > +    def do_parse(self, rstlist: StringList, node: nodes.Node) -> None:
> >          """
> >          Parse rST source lines and add them to the specified node
> >
> > @@ -93,15 +103,15 @@ class QAPIDocDirective(NestedDirective):
> >      }
> >      has_content =3D False
> >
> > -    def new_serialno(self):
> > +    def new_serialno(self) -> str:
> >          """Return a unique new ID string suitable for use as a node's
> ID"""
> >          env =3D self.state.document.settings.env
> >          return "qapidoc-%d" % env.new_serialno("qapidoc")
> >
> > -    def transmogrify(self, schema) -> nodes.Element:
> > +    def transmogrify(self, schema: QAPISchema) -> nodes.Element:
> >          raise NotImplementedError
> >
> > -    def legacy(self, schema) -> nodes.Element:
> > +    def legacy(self, schema: QAPISchema) -> nodes.Element:
> >          vis =3D QAPISchemaGenRSTVisitor(self)
> >          vis.visit_begin(schema)
> >          for doc in schema.docs:
> > @@ -109,9 +119,9 @@ def legacy(self, schema) -> nodes.Element:
> >                  vis.symbol(doc, schema.lookup_entity(doc.symbol))
> >              else:
> >                  vis.freeform(doc)
> > -        return vis.get_document_node()
> > +        return vis.get_document_node()  # type: ignore
>
> This is where you call qapidoc_legacy.py, which remains untyped.  Okay.
>
> >
> > -    def run(self):
> > +    def run(self) -> Sequence[nodes.Node]:
> >          env =3D self.state.document.settings.env
> >          qapifile =3D env.config.qapidoc_srctree + "/" + self.arguments=
[0]
> >          qapidir =3D os.path.dirname(qapifile)
> > @@ -185,7 +195,7 @@ def _highlightlang(self) -> addnodes.highlightlang:
> >          )
> >          return node
> >
> > -    def admonition_wrap(self, *content) -> List[nodes.Node]:
> > +    def admonition_wrap(self, *content: nodes.Node) -> List[nodes.Node=
]:
> >          title =3D "Example:"
> >          if "title" in self.options:
> >              title =3D f"{title} {self.options['title']}"
> > @@ -231,7 +241,7 @@ def run(self) -> List[nodes.Node]:
> >          return self.admonition_wrap(*content_nodes)
> >
> >
> > -def setup(app):
> > +def setup(app: Sphinx) -> ExtensionMetadata:
> >      """Register qapi-doc directive with Sphinx"""
> >      app.add_config_value("qapidoc_srctree", None, "env")
> >      app.add_directive("qapi-doc", QAPIDocDirective)
> > diff --git a/docs/sphinx/qapidoc_legacy.py
> b/docs/sphinx/qapidoc_legacy.py
> > index 679f38356b1..13520f4c26b 100644
> > --- a/docs/sphinx/qapidoc_legacy.py
> > +++ b/docs/sphinx/qapidoc_legacy.py
> > @@ -1,4 +1,5 @@
> >  # coding=3Dutf-8
> > +# type: ignore
> >  #
> >  # QEMU qapidoc QAPI file parsing extension
> >  #
>
> Types look good to me.
>
>

--000000000000e10fc3062fd8f509
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:00=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Now that the legacy code is factored out, fix up the typing on the<br>
&gt; remaining code in qapidoc.py. Add a type ignore to qapi_legacy.py to<b=
r>
&gt; prevent the errors there from bleeding out into qapidoc.py.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 40 +++++++++=
+++++++++++++-------------<br>
&gt;=C2=A0 docs/sphinx/qapidoc_legacy.py |=C2=A0 1 +<br>
&gt;=C2=A0 2 files changed, 26 insertions(+), 15 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index f4abf42e7bf..5246832b68c 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -24,17 +24,18 @@<br>
&gt;=C2=A0 <a href=3D"https://www.sphinx-doc.org/en/master/development/inde=
x.html" rel=3D"noreferrer" target=3D"_blank">https://www.sphinx-doc.org/en/=
master/development/index.html</a><br>
&gt;=C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt; +from __future__ import annotations<br>
&gt; +<br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 import sys<br>
&gt; -from typing import List<br>
&gt; +from typing import TYPE_CHECKING<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from docutils import nodes<br>
&gt;=C2=A0 from docutils.parsers.rst import Directive, directives<br>
&gt;=C2=A0 from qapi.error import QAPIError<br>
&gt; -from qapi.gen import QAPISchemaVisitor<br>
&gt; -from qapi.schema import QAPISchema<br>
&gt; +from qapi.schema import QAPISchema, QAPISchemaVisitor<br>
&gt;=C2=A0 <br>
&gt; -from qapidoc_legacy import QAPISchemaGenRSTVisitor<br>
&gt; +from qapidoc_legacy import QAPISchemaGenRSTVisitor=C2=A0 # type: igno=
re<br>
&gt;=C2=A0 from sphinx import addnodes<br>
&gt;=C2=A0 from sphinx.directives.code import CodeBlock<br>
&gt;=C2=A0 from sphinx.errors import ExtensionError<br>
&gt; @@ -42,6 +43,15 @@<br>
&gt;=C2=A0 from sphinx.util.nodes import nested_parse_with_titles<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +if TYPE_CHECKING:<br>
&gt; +=C2=A0 =C2=A0 from typing import Any, List, Sequence<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 from docutils.statemachine import StringList<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 from sphinx.application import Sphinx<br>
&gt; +=C2=A0 =C2=A0 from sphinx.util.typing import ExtensionMetadata<br>
<br>
Can you briefly explain why this needs to be conditional?<br></blockquote><=
div><br></div><div>No requisite, but if they aren&#39;t used outside of typ=
e hints, they don&#39;t actually need to be imported at runtime (when we us=
e from __future__ import annotations). Improves startup speed slightly and =
potentially makes the plugin less porcelain at runtime.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 __version__ =3D &quot;1.0&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; @@ -53,11 +63,11 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor):<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 schema file associated with each module in the QAP=
I input.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def __init__(self, env, qapidir):<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, env: Any, qapidir: str) -&gt; None:<=
br>
<br>
@env is QAPIDocDirective.state.document.settings.env, i.e. something<br>
deep in Sphinx.=C2=A0 I assume Any is the best Sphinx lets you do here.<br>=
</blockquote><div><br></div><div>Will double-check, I did this a while ago.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._env =3D env<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._qapidir =3D qapidir<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def visit_module(self, name):<br>
&gt; +=C2=A0 =C2=A0 def visit_module(self, name: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if name !=3D &quot;./builtin&quot;:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapifile =3D self._qap=
idir + &quot;/&quot; + name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._env.note_depende=
ncy(os.path.abspath(qapifile))<br>
&gt; @@ -65,10 +75,10 @@ def visit_module(self, name):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class NestedDirective(Directive):<br>
&gt; -=C2=A0 =C2=A0 def run(self):<br>
&gt; +=C2=A0 =C2=A0 def run(self) -&gt; Sequence[nodes.Node]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise NotImplementedError<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def do_parse(self, rstlist, node):<br>
&gt; +=C2=A0 =C2=A0 def do_parse(self, rstlist: StringList, node: nodes.Nod=
e) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Parse rST source lines and add them =
to the specified node<br>
&gt;=C2=A0 <br>
&gt; @@ -93,15 +103,15 @@ class QAPIDocDirective(NestedDirective):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 has_content =3D False<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def new_serialno(self):<br>
&gt; +=C2=A0 =C2=A0 def new_serialno(self) -&gt; str:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Return a unique ne=
w ID string suitable for use as a node&#39;s ID&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env =3D self.state.document.settings=
.env<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;qapidoc-%d&quot; % env.=
new_serialno(&quot;qapidoc&quot;)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def transmogrify(self, schema) -&gt; nodes.Element:<br>
&gt; +=C2=A0 =C2=A0 def transmogrify(self, schema: QAPISchema) -&gt; nodes.=
Element:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise NotImplementedError<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def legacy(self, schema) -&gt; nodes.Element:<br>
&gt; +=C2=A0 =C2=A0 def legacy(self, schema: QAPISchema) -&gt; nodes.Elemen=
t:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vis =3D QAPISchemaGenRSTVisitor(self=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vis.visit_begin(schema)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for doc in schema.docs:<br>
&gt; @@ -109,9 +119,9 @@ def legacy(self, schema) -&gt; nodes.Element:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vis.symb=
ol(doc, schema.lookup_entity(doc.symbol))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vis.free=
form(doc)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vis.get_document_node()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vis.get_document_node()=C2=A0 # ty=
pe: ignore<br>
<br>
This is where you call qapidoc_legacy.py, which remains untyped.=C2=A0 Okay=
.<br>
<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def run(self):<br>
&gt; +=C2=A0 =C2=A0 def run(self) -&gt; Sequence[nodes.Node]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env =3D self.state.document.settings=
.env<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapifile =3D env.config.qapidoc_srct=
ree + &quot;/&quot; + self.arguments[0]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapidir =3D os.path.dirname(qapifile=
)<br>
&gt; @@ -185,7 +195,7 @@ def _highlightlang(self) -&gt; addnodes.highlightl=
ang:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return node<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def admonition_wrap(self, *content) -&gt; List[nodes.No=
de]:<br>
&gt; +=C2=A0 =C2=A0 def admonition_wrap(self, *content: nodes.Node) -&gt; L=
ist[nodes.Node]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 title =3D &quot;Example:&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;title&quot; in self.options=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 title =3D f&quot;{titl=
e} {self.options[&#39;title&#39;]}&quot;<br>
&gt; @@ -231,7 +241,7 @@ def run(self) -&gt; List[nodes.Node]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.admonition_wrap(*content=
_nodes)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; -def setup(app):<br>
&gt; +def setup(app: Sphinx) -&gt; ExtensionMetadata:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Register qapi-doc directive with=
 Sphinx&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 app.add_config_value(&quot;qapidoc_srctree&quot;, =
None, &quot;env&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 app.add_directive(&quot;qapi-doc&quot;, QAPIDocDir=
ective)<br>
&gt; diff --git a/docs/sphinx/qapidoc_legacy.py b/docs/sphinx/qapidoc_legac=
y.py<br>
&gt; index 679f38356b1..13520f4c26b 100644<br>
&gt; --- a/docs/sphinx/qapidoc_legacy.py<br>
&gt; +++ b/docs/sphinx/qapidoc_legacy.py<br>
&gt; @@ -1,4 +1,5 @@<br>
&gt;=C2=A0 # coding=3Dutf-8<br>
&gt; +# type: ignore<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # QEMU qapidoc QAPI file parsing extension<br>
&gt;=C2=A0 #<br>
<br>
Types look good to me.<br>
<br>
</blockquote></div></div>

--000000000000e10fc3062fd8f509--


