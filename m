Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2F7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Io8-00079f-Q0; Wed, 15 May 2024 13:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7Io5-00076D-Q1
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7Inr-0003Jv-Pa
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715795553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlbfrWtERwdYucVx/FK18hyp3l2x4NPlpo8NBqo2pIk=;
 b=TtIsZbHWVGvMjsxRz9eAKhS0m8AbOH70B1xTwSEFp5rKT4vowyrJKZZn4xGkWJKjpFSFJ3
 wHe16uOHFMdYvYCmRhgnIePIaimyfGWiE4YjgI1+MoQVQQCHPGQh9T4dITTy34ffBSeMZw
 MBfC3kf6oqjU6rLuIMf/yow/LD26RsQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-UiF_EFpDOLqYsItwWwgVIQ-1; Wed, 15 May 2024 13:52:31 -0400
X-MC-Unique: UiF_EFpDOLqYsItwWwgVIQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2b4330e57b6so6947143a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715795550; x=1716400350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlbfrWtERwdYucVx/FK18hyp3l2x4NPlpo8NBqo2pIk=;
 b=myUP4WD1IHR1X8AMfnqMtw0Gn3sbaoMo+pX7ME4kT3NjPYd5PgS0TFSdWYr457iHAN
 F4KnU89qCnq0eqWe9hri4rpWkuWehL5OO48RhpxOj3U3LEbcw5U57oWq34/AAXWfIwqj
 G4U83qAUHmhrRuNOdF98mzO/Eeqovfp/tnEm9ieVVF0bbw4P6h97NZvZSMkzrLwFnCYS
 l+s8eYVMI3H7Wouf2gRGYLSEU0rnH2O7NElFgrLExOq0zFguAtP682IysoUZLee22blv
 qopy2UKBCdqYcHcr1ymeD6OmKf3SExY4oZcs/X8w8YZtBx1gEPnglLohmBcQDQXSSh0C
 Em/A==
X-Gm-Message-State: AOJu0YzYLB7zNWPE7vV3fUoPnu3901RvwK1NBmIRg2i508keImM1qHaC
 XSTx6/A+4ayVY3NygWpnAwQ9pqUqap+Xz9uYue+zehWP0HIOQO5aIKWgSwmSSFn5GfKJR+BzWod
 PgGtmey5j8diYrFDSMZgsu9Jv2VaQUi5UoiWuMzcHS1puNN6egHC3OkFKoN+GmScKouBvwSs3hR
 xO6UFNkoRfCqtX1s/cpxaKcNXMqrc=
X-Received: by 2002:a17:90b:1d05:b0:2b4:33ee:25a1 with SMTP id
 98e67ed59e1d1-2b6cc87abb9mr20180255a91.26.1715795550261; 
 Wed, 15 May 2024 10:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtuoDsbqC0YuRKWWMkQo8HhIof/FTGY8gFywTNZ9nmk6LoiZkrF8fBeafWFlscA8VIO5sOqLEHQFuqlqRcNZw=
X-Received: by 2002:a17:90b:1d05:b0:2b4:33ee:25a1 with SMTP id
 98e67ed59e1d1-2b6cc87abb9mr20180208a91.26.1715795549865; Wed, 15 May 2024
 10:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-4-jsnow@redhat.com>
 <87h6ezwi2j.fsf@pond.sub.org>
 <CAFn=p-aO=g18OQGQWbg+=23n-dRiXrQPEFk52i1-=nczqeLEPA@mail.gmail.com>
 <87o797q93i.fsf@pond.sub.org>
In-Reply-To: <87o797q93i.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 May 2024 13:52:17 -0400
Message-ID: <CAFn=p-bTqemvc3RXM5y6ffqZOvQJynyF5cmkLkHTO8GigukkDQ@mail.gmail.com>
Subject: Re: [PATCH 03/20] docs/qapidoc: delint a tiny portion of the module
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Mads Ynddal <mads@ynddal.dk>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000041e341061881c82a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000041e341061881c82a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024, 1:27=E2=80=AFPM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, May 15, 2024 at 5:17=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > In the coming patches, it's helpful to have a linting baseline.
> However,
> >> > there's no need to shuffle around the deck chairs too much, because
> most
> >> > of this code will be removed once the new qapidoc generator (the
> >> > "transmogrifier") is in place.
> >> >
> >> > To ease my pain: just turn off the black auto-formatter for most, bu=
t
> >> > not all, of qapidoc.py. This will help ensure that *new* code follow=
s
> a
> >> > coding standard without bothering too much with cleaning up the
> existing
> >> > code.
> >> >
> >> > For manual checking for now, try "black --check qapidoc.py" from the
> >> > docs/sphinx directory. "pip install black" (without root permissions=
)
> if
> >> > you do not have it installed otherwise.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  docs/sphinx/qapidoc.py | 16 +++++++++-------
> >> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >> >
> >> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> >> > index f270b494f01..1655682d4c7 100644
> >> > --- a/docs/sphinx/qapidoc.py
> >> > +++ b/docs/sphinx/qapidoc.py
> >> > @@ -28,28 +28,30 @@
> >> >  import re
> >> >
> >> >  from docutils import nodes
> >> > +from docutils.parsers.rst import Directive, directives
> >> >  from docutils.statemachine import ViewList
> >> > -from docutils.parsers.rst import directives, Directive
> >> > -from sphinx.errors import ExtensionError
> >> > -from sphinx.util.nodes import nested_parse_with_titles
> >> > -import sphinx
> >> > -from qapi.gen import QAPISchemaVisitor
> >> >  from qapi.error import QAPIError, QAPISemError
> >> > +from qapi.gen import QAPISchemaVisitor
> >> >  from qapi.schema import QAPISchema
> >> >
> >> > +import sphinx
> >> > +from sphinx.errors import ExtensionError
> >> > +from sphinx.util.nodes import nested_parse_with_titles
> >> > +
> >>
> >> Exchanges old pylint gripe
> >>
> >>     docs/sphinx/qapidoc.py:45:4: C0412: Imports from package sphinx ar=
e
> >> not grouped (ungrouped-imports)
> >>
> >> for new gripes
> >>
> >>     docs/sphinx/qapidoc.py:37:0: C0411: third party import "import
> sphinx"
> >> should be placed before "from qapi.error import QAPIError, QAPISemErro=
r"
> >> (wrong-import-order)
> >>     docs/sphinx/qapidoc.py:38:0: C0411: third party import "from
> >> sphinx.errors import ExtensionError" should be placed before "from
> >> qapi.error import QAPIError, QAPISemError" (wrong-import-order)
> >>     docs/sphinx/qapidoc.py:39:0: C0411: third party import "from
> >> sphinx.util.nodes import nested_parse_with_titles" should be placed
> before
> >> "from qapi.error import QAPIError, QAPISemError" (wrong-import-order)
> >>
> >> Easy enough to fix.
> >>
> >
> > I believe these errors are caused by the fact that the tools are confus=
ed
> > about the "sphinx" namespace - some interpret them as being the local
> > "module", the docs/sphinx/ directory, and others believe them to be the
> > third party external package.
> >
> > I have not been using pylint on docs/sphinx/ files because of the
> > difficulty of managing imports - this environment is generally beyond t=
he
> > reaches of my python borgcube and at present I don't have plans to
> > integrate it.
> >
> > At the moment, I am using black, isort and flake8 for qapidoc.py and
> > they're happy with it. I am not using mypy because I never did the typi=
ng
> > boogaloo with qapidoc.py and I won't be bothering - except for any new
> code
> > I write, which *will* bother. By the end of the new transmogrifier,
> > qapidoc.py *will* strictly typecheck.
> >
> > pylint may prove to be an issue with the imports, though. isort also
> seems
> > to misunderstand "sphinx, the stuff in this folder" and "sphinx, the
> stuff
> > in a third party package" and so I'm afraid I don't have any good abili=
ty
> > to get pylint to play along, here.
> >
> > Pleading for "Sorry, this sucks and I can't figure out how to solve it
> > quickly". Maybe a future project, apologies.
>
> Is this pain we inflict on ourselves by naming the directory "sphinx"?
>

More or less, yeah. If you check the file from a CWD where there is no
"sphinx" directory, it behaves more normally.

Just not worth renaming it and futzing about for now. However, I did get an
invocation that lets me get a clean pylint run by abusing PYTHONPATH again,
so I have at least one standard baseline we can count on. I updated the
do-not-merge patch to include the special magick incantations.

Maybe in the future I'll make a qemu.plugins submodule instead, but that's
for quite a bit later.


> >> >
> >> >  # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
> >> >  # use switch_source_input. Check borrowed from kerneldoc.py.
> >> > -Use_SSI =3D sphinx.__version__[:3] >=3D '1.7'
> >> > +Use_SSI =3D sphinx.__version__[:3] >=3D "1.7"
> >> >  if Use_SSI:
> >> >      from sphinx.util.docutils import switch_source_input
> >> >  else:
> >> >      from sphinx.ext.autodoc import AutodocReporter
> >> >
> >> >
> >> > -__version__ =3D '1.0'
> >> > +__version__ =3D "1.0"
> >> >
> >> >
> >> > +# fmt: off
> >>
> >> I figure this tells black to keep quiet for the remainder of the file.
> >> Worth a comment, I think.
> >>
> >> >  # Function borrowed from pydash, which is under the MIT license
> >> >  def intersperse(iterable, separator):
> >> >      """Yield the members of *iterable* interspersed with
> *separator*."""
> >>
> >> With my comments addressed
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >>
> >
> > ^ Dropping this unless you're okay with the weird import orders owing t=
o
> > the strange import paradigm in the sphinx folder.r
>
> Feel free to keep it.
>
>

--00000000000041e341061881c82a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, May 15, 2024, 1:27=E2=80=AFPM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"norefer=
rer">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Wed, May 15, 2024 at 5:17=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blan=
k">armbru@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferre=
r noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; In the coming patches, it&#39;s helpful to have a linting bas=
eline. However,<br>
&gt;&gt; &gt; there&#39;s no need to shuffle around the deck chairs too muc=
h, because most<br>
&gt;&gt; &gt; of this code will be removed once the new qapidoc generator (=
the<br>
&gt;&gt; &gt; &quot;transmogrifier&quot;) is in place.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; To ease my pain: just turn off the black auto-formatter for m=
ost, but<br>
&gt;&gt; &gt; not all, of qapidoc.py. This will help ensure that *new* code=
 follows a<br>
&gt;&gt; &gt; coding standard without bothering too much with cleaning up t=
he existing<br>
&gt;&gt; &gt; code.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; For manual checking for now, try &quot;black --check qapidoc.=
py&quot; from the<br>
&gt;&gt; &gt; docs/sphinx directory. &quot;pip install black&quot; (without=
 root permissions) if<br>
&gt;&gt; &gt; you do not have it installed otherwise.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" rel=3D"noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt=
;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 docs/sphinx/qapidoc.py | 16 +++++++++-------<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 9 insertions(+), 7 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<=
br>
&gt;&gt; &gt; index f270b494f01..1655682d4c7 100644<br>
&gt;&gt; &gt; --- a/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt; @@ -28,28 +28,30 @@<br>
&gt;&gt; &gt;=C2=A0 import re<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 from docutils import nodes<br>
&gt;&gt; &gt; +from docutils.parsers.rst import Directive, directives<br>
&gt;&gt; &gt;=C2=A0 from docutils.statemachine import ViewList<br>
&gt;&gt; &gt; -from docutils.parsers.rst import directives, Directive<br>
&gt;&gt; &gt; -from sphinx.errors import ExtensionError<br>
&gt;&gt; &gt; -from sphinx.util.nodes import nested_parse_with_titles<br>
&gt;&gt; &gt; -import sphinx<br>
&gt;&gt; &gt; -from qapi.gen import QAPISchemaVisitor<br>
&gt;&gt; &gt;=C2=A0 from qapi.error import QAPIError, QAPISemError<br>
&gt;&gt; &gt; +from qapi.gen import QAPISchemaVisitor<br>
&gt;&gt; &gt;=C2=A0 from qapi.schema import QAPISchema<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +import sphinx<br>
&gt;&gt; &gt; +from sphinx.errors import ExtensionError<br>
&gt;&gt; &gt; +from sphinx.util.nodes import nested_parse_with_titles<br>
&gt;&gt; &gt; +<br>
&gt;&gt;<br>
&gt;&gt; Exchanges old pylint gripe<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0docs/sphinx/qapidoc.py:45:4: C0412: Imports fro=
m package sphinx are<br>
&gt;&gt; not grouped (ungrouped-imports)<br>
&gt;&gt;<br>
&gt;&gt; for new gripes<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0docs/sphinx/qapidoc.py:37:0: C0411: third party=
 import &quot;import sphinx&quot;<br>
&gt;&gt; should be placed before &quot;from qapi.error import QAPIError, QA=
PISemError&quot;<br>
&gt;&gt; (wrong-import-order)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0docs/sphinx/qapidoc.py:38:0: C0411: third party=
 import &quot;from<br>
&gt;&gt; sphinx.errors import ExtensionError&quot; should be placed before =
&quot;from<br>
&gt;&gt; qapi.error import QAPIError, QAPISemError&quot; (wrong-import-orde=
r)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0docs/sphinx/qapidoc.py:39:0: C0411: third party=
 import &quot;from<br>
&gt;&gt; sphinx.util.nodes import nested_parse_with_titles&quot; should be =
placed before<br>
&gt;&gt; &quot;from qapi.error import QAPIError, QAPISemError&quot; (wrong-=
import-order)<br>
&gt;&gt;<br>
&gt;&gt; Easy enough to fix.<br>
&gt;&gt;<br>
&gt;<br>
&gt; I believe these errors are caused by the fact that the tools are confu=
sed<br>
&gt; about the &quot;sphinx&quot; namespace - some interpret them as being =
the local<br>
&gt; &quot;module&quot;, the docs/sphinx/ directory, and others believe the=
m to be the<br>
&gt; third party external package.<br>
&gt;<br>
&gt; I have not been using pylint on docs/sphinx/ files because of the<br>
&gt; difficulty of managing imports - this environment is generally beyond =
the<br>
&gt; reaches of my python borgcube and at present I don&#39;t have plans to=
<br>
&gt; integrate it.<br>
&gt;<br>
&gt; At the moment, I am using black, isort and flake8 for qapidoc.py and<b=
r>
&gt; they&#39;re happy with it. I am not using mypy because I never did the=
 typing<br>
&gt; boogaloo with qapidoc.py and I won&#39;t be bothering - except for any=
 new code<br>
&gt; I write, which *will* bother. By the end of the new transmogrifier,<br=
>
&gt; qapidoc.py *will* strictly typecheck.<br>
&gt;<br>
&gt; pylint may prove to be an issue with the imports, though. isort also s=
eems<br>
&gt; to misunderstand &quot;sphinx, the stuff in this folder&quot; and &quo=
t;sphinx, the stuff<br>
&gt; in a third party package&quot; and so I&#39;m afraid I don&#39;t have =
any good ability<br>
&gt; to get pylint to play along, here.<br>
&gt;<br>
&gt; Pleading for &quot;Sorry, this sucks and I can&#39;t figure out how to=
 solve it<br>
&gt; quickly&quot;. Maybe a future project, apologies.<br>
<br>
Is this pain we inflict on ourselves by naming the directory &quot;sphinx&q=
uot;?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">More or less, yeah. If you check the file from a CWD where there is no=
 &quot;sphinx&quot; directory, it behaves more normally.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Just not worth renaming it and futzing abo=
ut for now. However, I did get an invocation that lets me get a clean pylin=
t run by abusing PYTHONPATH again, so I have at least one standard baseline=
 we can count on. I updated the do-not-merge patch to include the special m=
agick incantations.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Mayb=
e in the future I&#39;ll make a qemu.plugins submodule instead, but that&#3=
9;s for quite a bit later.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later<=
br>
&gt;&gt; &gt;=C2=A0 # use switch_source_input. Check borrowed from kerneldo=
c.py.<br>
&gt;&gt; &gt; -Use_SSI =3D sphinx.__version__[:3] &gt;=3D &#39;1.7&#39;<br>
&gt;&gt; &gt; +Use_SSI =3D sphinx.__version__[:3] &gt;=3D &quot;1.7&quot;<b=
r>
&gt;&gt; &gt;=C2=A0 if Use_SSI:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.util.docutils import switch_s=
ource_input<br>
&gt;&gt; &gt;=C2=A0 else:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.ext.autodoc import AutodocRep=
orter<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -__version__ =3D &#39;1.0&#39;<br>
&gt;&gt; &gt; +__version__ =3D &quot;1.0&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +# fmt: off<br>
&gt;&gt;<br>
&gt;&gt; I figure this tells black to keep quiet for the remainder of the f=
ile.<br>
&gt;&gt; Worth a comment, I think.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 # Function borrowed from pydash, which is under the MIT=
 license<br>
&gt;&gt; &gt;=C2=A0 def intersperse(iterable, separator):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Yield the members of *i=
terable* interspersed with *separator*.&quot;&quot;&quot;<br>
&gt;&gt;<br>
&gt;&gt; With my comments addressed<br>
&gt;&gt; Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com" rel=3D"noreferrer noreferrer" target=3D"_blank">armbru@redhat.com</a>=
&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; ^ Dropping this unless you&#39;re okay with the weird import orders ow=
ing to<br>
&gt; the strange import paradigm in the sphinx folder.r<br>
<br>
Feel free to keep it.<br>
<br>
</blockquote></div></div></div>

--00000000000041e341061881c82a--


