Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF252C2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJymD-0005B1-3j; Wed, 19 Jun 2024 13:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJymB-0005Aj-Q1
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJym9-00083J-G4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718816831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+8SHTy41AW3m0ugXofRuRB1IjFQtk7uu/qv2pIMW4v8=;
 b=g8MYy4GqLMETxH7ztI3UaWVTgqLsJ5SYsqFMUPuN7I12f74dN2I3CAnpjiwo9zpvobJw2C
 E++3yV7L7d4CaA4MHleQy0rLgEhas2YEZtVAo7HkPbt2iYndZBfDItUrJVdmKlmKM1CsVS
 nKZeh/ObRRCshVTlPurZL7fa0GeefT4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-DooPJgGnMbqF40P0BVBahA-1; Wed, 19 Jun 2024 13:07:09 -0400
X-MC-Unique: DooPJgGnMbqF40P0BVBahA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7a6b95d56so57314a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718816828; x=1719421628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+8SHTy41AW3m0ugXofRuRB1IjFQtk7uu/qv2pIMW4v8=;
 b=pA/LpslybLaU8kYAXlLvEmk0Lo2WJuNxAPlvUVANL7T0x95cqD3T59R7lgAviCecLW
 fpIgXbsbi6AGainlbo2XGga8HhmYLyDH/qkeo6UCyQ+xocy7NvmtL14NrMHLZwDKDdkX
 PafLunjZL5MtKWGGJejFJRPnJ7R3WweIdU6B8rAQxr+yVgbnq9aeEPpcU/h83b+H1LCu
 rjkCmkPhjQ5QL98C2g+3bXDwTZ/K955P9Sbd9U3g8JPncYayaoO5aouh28ha+HP8RAyO
 Q/qcu9/qMej+EpCFDBe4EDQbo3x+HTYHzwP1pPQ0f1t7pJLxx5hf7GunLcj/NDv8vtYk
 5+uw==
X-Gm-Message-State: AOJu0YzsTZHLczjfoMEpTX3sFhTJ/TU3h7yBI2NiLGj3rx0wBo0RTeXm
 433PJI5P0zwabiyFmaW+VthqCIDu/bJnNVyFn47Pq3L8r52StKMZNJpH5pWua1n/HoQDLAEq9u1
 Fjh18BsAFPd11ZALiirN+SCUWB3vnv0WMwZCcHVwgYH7kk0lh+Y6olXPvtzDWprtYzJUtQmskqA
 FLP3tnVFdWPFaJZ8oHCV5v0pdidS0=
X-Received: by 2002:a17:903:11ce:b0:1f4:b859:cb60 with SMTP id
 d9443c01a7336-1f9aa396f5amr33319465ad.10.1718816828105; 
 Wed, 19 Jun 2024 10:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHofnrORpKd3whv5uDuPVs/KLXBcsZrAJCWIZYBIWpuypUOT6md3ZwPbDThNhELBF3Cor92bRbO3VUrKvi/gvY=
X-Received: by 2002:a17:903:11ce:b0:1f4:b859:cb60 with SMTP id
 d9443c01a7336-1f9aa396f5amr33318885ad.10.1718816827534; Wed, 19 Jun 2024
 10:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-4-jsnow@redhat.com>
 <87plsd30qm.fsf@pond.sub.org>
In-Reply-To: <87plsd30qm.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Jun 2024 13:06:55 -0400
Message-ID: <CAFn=p-Zdcgh3nQnBbBpFbeXxp7_Hq4Z-M83CGecR9mm3uWJUvQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] docs/qapidoc: delint a tiny portion of the module
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000709242061b413a16"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000709242061b413a16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024, 2:28=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > In a forthcoming series that adds a new QMP documentation generator, it
> > will be helpful to have a linting baseline. However, there's no need to
> > shuffle around the deck chairs too much, because most of this code will
> > be removed once that new qapidoc generator (the "transmogrifier") is in
> > place.
> >
> > To ease my pain: just turn off the black auto-formatter for most, but
> > not all, of qapidoc.py. This will help ensure that *new* code follows a
> > coding standard without bothering too much with cleaning up the existin=
g
> > code.
> >
> > Code that I intend to keep is still subject to the delinting beam.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 66 +++++++++++++++++++++++++-----------------
> >  1 file changed, 40 insertions(+), 26 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index f270b494f01..e675966defa 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -28,33 +28,42 @@
> >  import re
> >
> >  from docutils import nodes
> > +from docutils.parsers.rst import Directive, directives
> >  from docutils.statemachine import ViewList
> > -from docutils.parsers.rst import directives, Directive
> > -from sphinx.errors import ExtensionError
> > -from sphinx.util.nodes import nested_parse_with_titles
> > -import sphinx
> > -from qapi.gen import QAPISchemaVisitor
> >  from qapi.error import QAPIError, QAPISemError
> > +from qapi.gen import QAPISchemaVisitor
> >  from qapi.schema import QAPISchema
> >
> > +import sphinx
> > +from sphinx.errors import ExtensionError
> > +from sphinx.util.nodes import nested_parse_with_titles
> > +
> >
> >  # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
> >  # use switch_source_input. Check borrowed from kerneldoc.py.
> > -Use_SSI =3D sphinx.__version__[:3] >=3D '1.7'
> > -if Use_SSI:
> > +USE_SSI =3D sphinx.__version__[:3] >=3D "1.7"
> > +if USE_SSI:
> >      from sphinx.util.docutils import switch_source_input
> >  else:
> > -    from sphinx.ext.autodoc import AutodocReporter
> > +    from sphinx.ext.autodoc import (  # pylint:
> disable=3Dno-name-in-module
> > +        AutodocReporter,
> > +    )
> >
> >
> > -__version__ =3D '1.0'
> > +__version__ =3D "1.0"
> >
> >
> > +# Disable black auto-formatter until re-enabled:
> > +# fmt: off
> > +
> >  # Function borrowed from pydash, which is under the MIT license
> >  def intersperse(iterable, separator):
> >      """Yield the members of *iterable* interspersed with *separator*."=
""
> >      iterable =3D iter(iterable)
> > -    yield next(iterable)
> > +    try:
> > +        yield next(iterable)
> > +    except StopIteration:
> > +        return
>
> This gets rid of pylint's
>
>     docs/sphinx/qapidoc.py:82:10: R1708: Do not raise StopIteration in
> generator, use return statement instead (stop-iteration-return)
>
> I considered the same change some time ago, and decided against it to
> avoid deviating from pydash.  StopIteration would be a programming error
> here.
>
> Please *delete* the function instead: commit fd62bff901b removed its
> last use.  I'd do it in a separate commit, but that's up to you.
>

Oh! I didn't realize it wasn't being used. That's certainly easier :)


> >      for item in iterable:
> >          yield separator
> >          yield item
> > @@ -451,6 +460,10 @@ def get_document_nodes(self):
> >          return self._top_node.children
> >
> >
> > +# Turn the black formatter on for the rest of the file.
> > +# fmt: on
> > +
> > +
> >  class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
> >      """A QAPI schema visitor which adds Sphinx dependencies each modul=
e
> >
> > @@ -458,34 +471,34 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
> >      that the generated documentation output depends on the input
> >      schema file associated with each module in the QAPI input.
> >      """
> > +
> >      def __init__(self, env, qapidir):
> >          self._env =3D env
> >          self._qapidir =3D qapidir
> >
> >      def visit_module(self, name):
> >          if name !=3D "./builtin":
> > -            qapifile =3D self._qapidir + '/' + name
> > +            qapifile =3D self._qapidir + "/" + name
>
> The string literal quote changes are mildly annoying.  But since by your
> good work you're effectively appointing yourself maintainer of this
> file...  ;)
>

Mildly. However, I do think black is "close enough" on most style issues
that I have absolutely no regret or hesitation using it for all new python
development.

(I've been using it a lot in hobby code the last year and I find it to be
remarkably helpful for my own consistency in style issues, it's
indispensable for me.)

So in this series, I start using it because I essentially wind up rewriting
this entire file and wanted an autoformatter so I could shut my brain off
for stuff like this.

A "flag day" as you call it is likely coming soon to python/ where I'll
start enforcing black standards. It just makes development easier to have a
tool that just always DTRT. When I move QAPI there, it'll get the same
treatment.


> >              self._env.note_dependency(os.path.abspath(qapifile))
> >          super().visit_module(name)
> >
> >
> >  class QAPIDocDirective(Directive):
> >      """Extract documentation from the specified QAPI .json file"""
> > +
> >      required_argument =3D 1
> >      optional_arguments =3D 1
> > -    option_spec =3D {
> > -        'qapifile': directives.unchanged_required
> > -    }
> > +    option_spec =3D {"qapifile": directives.unchanged_required}
> >      has_content =3D False
> >
> >      def new_serialno(self):
> >          """Return a unique new ID string suitable for use as a node's
> ID"""
> >          env =3D self.state.document.settings.env
> > -        return 'qapidoc-%d' % env.new_serialno('qapidoc')
> > +        return "qapidoc-%d" % env.new_serialno("qapidoc")
> >
> >      def run(self):
> >          env =3D self.state.document.settings.env
> > -        qapifile =3D env.config.qapidoc_srctree + '/' + self.arguments=
[0]
> > +        qapifile =3D env.config.qapidoc_srctree + "/" + self.arguments=
[0]
> >          qapidir =3D os.path.dirname(qapifile)
> >
> >          try:
> > @@ -523,13 +536,14 @@ def do_parse(self, rstlist, node):
> >          # plain self.state.nested_parse(), and so we can drop the savi=
ng
> >          # of title_styles and section_level that kerneldoc.py does,
> >          # because nested_parse_with_titles() does that for us.
> > -        if Use_SSI:
> > +        if USE_SSI:
> >              with switch_source_input(self.state, rstlist):
> >                  nested_parse_with_titles(self.state, rstlist, node)
> >          else:
> >              save =3D self.state.memo.reporter
> >              self.state.memo.reporter =3D AutodocReporter(
> > -                rstlist, self.state.memo.reporter)
> > +                rstlist, self.state.memo.reporter
> > +            )
> >              try:
> >                  nested_parse_with_titles(self.state, rstlist, node)
> >              finally:
> > @@ -537,12 +551,12 @@ def do_parse(self, rstlist, node):
> >
> >
> >  def setup(app):
> > -    """ Register qapi-doc directive with Sphinx"""
> > -    app.add_config_value('qapidoc_srctree', None, 'env')
> > -    app.add_directive('qapi-doc', QAPIDocDirective)
> > +    """Register qapi-doc directive with Sphinx"""
> > +    app.add_config_value("qapidoc_srctree", None, "env")
> > +    app.add_directive("qapi-doc", QAPIDocDirective)
> >
> > -    return dict(
> > -        version=3D__version__,
> > -        parallel_read_safe=3DTrue,
> > -        parallel_write_safe=3DTrue
> > -    )
> > +    return {
> > +        "version": __version__,
> > +        "parallel_read_safe": True,
> > +        "parallel_write_safe": True,
> > +    }
>
> With intersperse() deleted
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

=E3=81=82=E3=82=8A=E3=81=8C=E3=81=A8=E3=81=86

>

--000000000000709242061b413a16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 19, 2024, 2:28=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; In a forthcoming series that adds a new QMP documentation generator, i=
t<br>
&gt; will be helpful to have a linting baseline. However, there&#39;s no ne=
ed to<br>
&gt; shuffle around the deck chairs too much, because most of this code wil=
l<br>
&gt; be removed once that new qapidoc generator (the &quot;transmogrifier&q=
uot;) is in<br>
&gt; place.<br>
&gt;<br>
&gt; To ease my pain: just turn off the black auto-formatter for most, but<=
br>
&gt; not all, of qapidoc.py. This will help ensure that *new* code follows =
a<br>
&gt; coding standard without bothering too much with cleaning up the existi=
ng<br>
&gt; code.<br>
&gt;<br>
&gt; Code that I intend to keep is still subject to the delinting beam.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 66 +++++++++++++++++++++++++-----------=
------<br>
&gt;=C2=A0 1 file changed, 40 insertions(+), 26 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index f270b494f01..e675966defa 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -28,33 +28,42 @@<br>
&gt;=C2=A0 import re<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from docutils import nodes<br>
&gt; +from docutils.parsers.rst import Directive, directives<br>
&gt;=C2=A0 from docutils.statemachine import ViewList<br>
&gt; -from docutils.parsers.rst import directives, Directive<br>
&gt; -from sphinx.errors import ExtensionError<br>
&gt; -from sphinx.util.nodes import nested_parse_with_titles<br>
&gt; -import sphinx<br>
&gt; -from qapi.gen import QAPISchemaVisitor<br>
&gt;=C2=A0 from qapi.error import QAPIError, QAPISemError<br>
&gt; +from qapi.gen import QAPISchemaVisitor<br>
&gt;=C2=A0 from qapi.schema import QAPISchema<br>
&gt;=C2=A0 <br>
&gt; +import sphinx<br>
&gt; +from sphinx.errors import ExtensionError<br>
&gt; +from sphinx.util.nodes import nested_parse_with_titles<br>
&gt; +<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later<br>
&gt;=C2=A0 # use switch_source_input. Check borrowed from kerneldoc.py.<br>
&gt; -Use_SSI =3D sphinx.__version__[:3] &gt;=3D &#39;1.7&#39;<br>
&gt; -if Use_SSI:<br>
&gt; +USE_SSI =3D sphinx.__version__[:3] &gt;=3D &quot;1.7&quot;<br>
&gt; +if USE_SSI:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.util.docutils import switch_source_inp=
ut<br>
&gt;=C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 from sphinx.ext.autodoc import AutodocReporter<br>
&gt; +=C2=A0 =C2=A0 from sphinx.ext.autodoc import (=C2=A0 # pylint: disabl=
e=3Dno-name-in-module<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AutodocReporter,<br>
&gt; +=C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; -__version__ =3D &#39;1.0&#39;<br>
&gt; +__version__ =3D &quot;1.0&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +# Disable black auto-formatter until re-enabled:<br>
&gt; +# fmt: off<br>
&gt; +<br>
&gt;=C2=A0 # Function borrowed from pydash, which is under the MIT license<=
br>
&gt;=C2=A0 def intersperse(iterable, separator):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Yield the members of *iterable* =
interspersed with *separator*.&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 iterable =3D iter(iterable)<br>
&gt; -=C2=A0 =C2=A0 yield next(iterable)<br>
&gt; +=C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 yield next(iterable)<br>
&gt; +=C2=A0 =C2=A0 except StopIteration:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
<br>
This gets rid of pylint&#39;s<br>
<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:82:10: R1708: Do not raise StopIterati=
on in generator, use return statement instead (stop-iteration-return)<br>
<br>
I considered the same change some time ago, and decided against it to<br>
avoid deviating from pydash.=C2=A0 StopIteration would be a programming err=
or<br>
here.<br>
<br>
Please *delete* the function instead: commit fd62bff901b removed its<br>
last use.=C2=A0 I&#39;d do it in a separate commit, but that&#39;s up to yo=
u.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Oh! I didn&#39;t realize it wasn&#39;t being used. That&#39;s certainly e=
asier :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for item in iterable:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yield separator<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yield item<br>
&gt; @@ -451,6 +460,10 @@ def get_document_nodes(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._top_node.children<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +# Turn the black formatter on for the rest of the file.<br>
&gt; +# fmt: on<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;A QAPI schema visitor which adds=
 Sphinx dependencies each module<br>
&gt;=C2=A0 <br>
&gt; @@ -458,34 +471,34 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor)=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 that the generated documentation output depends on=
 the input<br>
&gt;=C2=A0 =C2=A0 =C2=A0 schema file associated with each module in the QAP=
I input.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def __init__(self, env, qapidir):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._env =3D env<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._qapidir =3D qapidir<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_module(self, name):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if name !=3D &quot;./builtin&quot;:<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapifile =3D self._qapidir =
+ &#39;/&#39; + name<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapifile =3D self._qapidir =
+ &quot;/&quot; + name<br>
<br>
The string literal quote changes are mildly annoying.=C2=A0 But since by yo=
ur<br>
good work you&#39;re effectively appointing yourself maintainer of this<br>
file...=C2=A0 ;)<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Mildly. However, I do think black is &quot;close enough&quo=
t; on most style issues that I have absolutely no regret or hesitation usin=
g it for all new python development.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">(I&#39;ve been using it a lot in hobby code the last year and =
I find it to be remarkably helpful for my own consistency in style issues, =
it&#39;s indispensable for me.)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">So in this series, I start using it because I essentially wind up=
 rewriting this entire file and wanted an autoformatter so I could shut my =
brain off for stuff like this.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">A &quot;flag day&quot; as you call it is likely coming soon to pytho=
n/ where I&#39;ll start enforcing black standards. It just makes developmen=
t easier to have a tool that just always DTRT. When I move QAPI there, it&#=
39;ll get the same treatment.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._env.note_depende=
ncy(os.path.abspath(qapifile))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().visit_module(name)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPIDocDirective(Directive):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Extract documentation from the s=
pecified QAPI .json file&quot;&quot;&quot;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 required_argument =3D 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 optional_arguments =3D 1<br>
&gt; -=C2=A0 =C2=A0 option_spec =3D {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;qapifile&#39;: directives.unchanged_=
required<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 option_spec =3D {&quot;qapifile&quot;: directives.uncha=
nged_required}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 has_content =3D False<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def new_serialno(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Return a unique ne=
w ID string suitable for use as a node&#39;s ID&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env =3D self.state.document.settings=
.env<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &#39;qapidoc-%d&#39; % env.new_ser=
ialno(&#39;qapidoc&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;qapidoc-%d&quot; % env.new_s=
erialno(&quot;qapidoc&quot;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def run(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env =3D self.state.document.settings=
.env<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapifile =3D env.config.qapidoc_srctree +=
 &#39;/&#39; + self.arguments[0]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapifile =3D env.config.qapidoc_srctree +=
 &quot;/&quot; + self.arguments[0]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapidir =3D os.path.dirname(qapifile=
)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; @@ -523,13 +536,14 @@ def do_parse(self, rstlist, node):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # plain self.state.nested_parse(), a=
nd so we can drop the saving<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # of title_styles and section_level =
that kerneldoc.py does,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # because nested_parse_with_titles()=
 does that for us.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if Use_SSI:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if USE_SSI:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with switch_source_inp=
ut(self.state, rstlist):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_p=
arse_with_titles(self.state, rstlist, node)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save =3D self.state.me=
mo.reporter<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.state.memo.report=
er =3D AutodocReporter(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rstlist, self=
.state.memo.reporter)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rstlist, self=
.state.memo.reporter<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_p=
arse_with_titles(self.state, rstlist, node)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
&gt; @@ -537,12 +551,12 @@ def do_parse(self, rstlist, node):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def setup(app):<br>
&gt; -=C2=A0 =C2=A0 &quot;&quot;&quot; Register qapi-doc directive with Sph=
inx&quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 app.add_config_value(&#39;qapidoc_srctree&#39;, None, &=
#39;env&#39;)<br>
&gt; -=C2=A0 =C2=A0 app.add_directive(&#39;qapi-doc&#39;, QAPIDocDirective)=
<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Register qapi-doc directive with Sphi=
nx&quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 app.add_config_value(&quot;qapidoc_srctree&quot;, None,=
 &quot;env&quot;)<br>
&gt; +=C2=A0 =C2=A0 app.add_directive(&quot;qapi-doc&quot;, QAPIDocDirectiv=
e)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 return dict(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 version=3D__version__,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 parallel_read_safe=3DTrue,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 parallel_write_safe=3DTrue<br>
&gt; -=C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 return {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;version&quot;: __version__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;parallel_read_safe&quot;: True,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;parallel_write_safe&quot;: True,<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
With intersperse() deleted<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=E3=81=82=E3=82=
=8A=E3=81=8C=E3=81=A8=E3=81=86</div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000709242061b413a16--


