Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360FAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7DLo-0002Ez-7c; Wed, 15 May 2024 08:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7DLY-0002Ap-IA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7DLU-0003xN-8K
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715774568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ncz+B+Yk/HrJTLnxj835jg9VjoXkJIRRQvW80efL5FE=;
 b=Aqd6F+hXnd78eWVZ5Pcspemg95TPqkmceyNI9LCyU0P5TrymdzTre5+vo4JRxtRuBb8Uf5
 TAcXJVzeD3HZ7lZKDkjWFYnxD4YcVJrYw2fXiSM7K/UdhLkvtGrrew+yPDZMmIXd4aXDQJ
 QTGdGRd9t78D4QNj+lZ3ynYKPeMTCV4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-cwu2bhu2ODiqzWz_yTrp9w-1; Wed, 15 May 2024 08:02:46 -0400
X-MC-Unique: cwu2bhu2ODiqzWz_yTrp9w-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b29f4af4e4so5509116a91.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715774566; x=1716379366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ncz+B+Yk/HrJTLnxj835jg9VjoXkJIRRQvW80efL5FE=;
 b=cJyXH0pwg78zSChFIZriDImFbbfsJXPL018o8yzP6GicxR2xligS1gUYYWx+/9R48w
 MqT8ZE65zyLVDqZ/ELFsTnxhe1gp9l57MS6g1DRKsrkT9r6A77ERDB+zHPhVgD/SyrBQ
 9P1xe/IgDaptxMcCTvNTYwKoIlyXmJvPvKdO+oj9otkTmlNC06BlJvfq5runDjJp62OY
 +/f6yJiH6QZgb5+oDCWPGBaF6hXRkUe6notXW11j9r0SBag6KmTJLXKXQzQcs3peBZ4D
 i+I1+BTdvoY4bIVVKd4++0kVjFgiam5Z1nnghYN+SRLI2g1ZCLFYaPXDxxcZ6YAjytFw
 YzFw==
X-Gm-Message-State: AOJu0YzOwfT3cnhdJwFAw+iLZZcHbegTWlevm0yDS3kOPpDsfCpdPeYx
 elhkbRTcpQ161a13Nk5axWHoPaudDwzTVWm0iJCX2/EFuA1mMRTl+NCuaeh0Ta+lMb/7sHOjJOK
 cH0reob4+pUTYWU8SVpRbzGCycAXjND4m/V/49Ny3XBkQzGwpaVR2YxfcpMYiBWySO+YNLCnnrO
 DgA5FgpqvL2rS/bGHl31ziXWndW/o=
X-Received: by 2002:a17:90a:69e1:b0:2a6:4293:f88c with SMTP id
 98e67ed59e1d1-2b6cc44f987mr13273063a91.16.1715774565523; 
 Wed, 15 May 2024 05:02:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4F/lZlfxlwlRbG84E0nOm+zqrm9X/v/7M4w+qi7ITHv3rJPBOhzDgky2t6HhUywHtbDKXJgCvBBtpQpmpThE=
X-Received: by 2002:a17:90a:69e1:b0:2a6:4293:f88c with SMTP id
 98e67ed59e1d1-2b6cc44f987mr13273025a91.16.1715774565117; Wed, 15 May 2024
 05:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-4-jsnow@redhat.com>
 <87h6ezwi2j.fsf@pond.sub.org>
In-Reply-To: <87h6ezwi2j.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 May 2024 08:02:33 -0400
Message-ID: <CAFn=p-bYke=3S4R8fWoyvh6-Bj+5NcuDc9bnEVpCMJZ8Wfv7zg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000780ffb06187ce56a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

--000000000000780ffb06187ce56a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024, 5:17=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > In the coming patches, it's helpful to have a linting baseline. However=
,
> > there's no need to shuffle around the deck chairs too much, because mos=
t
> > of this code will be removed once the new qapidoc generator (the
> > "transmogrifier") is in place.
> >
> > To ease my pain: just turn off the black auto-formatter for most, but
> > not all, of qapidoc.py. This will help ensure that *new* code follows a
> > coding standard without bothering too much with cleaning up the existin=
g
> > code.
> >
> > For manual checking for now, try "black --check qapidoc.py" from the
> > docs/sphinx directory. "pip install black" (without root permissions) i=
f
> > you do not have it installed otherwise.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index f270b494f01..1655682d4c7 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -28,28 +28,30 @@
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
>
> Exchanges old pylint gripe
>
>     docs/sphinx/qapidoc.py:45:4: C0412: Imports from package sphinx are
> not grouped (ungrouped-imports)
>
> for new gripes
>
>     docs/sphinx/qapidoc.py:37:0: C0411: third party import "import sphinx=
"
> should be placed before "from qapi.error import QAPIError, QAPISemError"
> (wrong-import-order)
>     docs/sphinx/qapidoc.py:38:0: C0411: third party import "from
> sphinx.errors import ExtensionError" should be placed before "from
> qapi.error import QAPIError, QAPISemError" (wrong-import-order)
>     docs/sphinx/qapidoc.py:39:0: C0411: third party import "from
> sphinx.util.nodes import nested_parse_with_titles" should be placed befor=
e
> "from qapi.error import QAPIError, QAPISemError" (wrong-import-order)
>
> Easy enough to fix.
>

This is a problem where our sphinx directory is colliding with the sphinx
namespace and different versions of the tooling disagree with the
assessment.

I'll try to fix this without renaming our directory, but I'm worried that
might be the most robust solution.


> >
> >  # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
> >  # use switch_source_input. Check borrowed from kerneldoc.py.
> > -Use_SSI =3D sphinx.__version__[:3] >=3D '1.7'
> > +Use_SSI =3D sphinx.__version__[:3] >=3D "1.7"
> >  if Use_SSI:
> >      from sphinx.util.docutils import switch_source_input
> >  else:
> >      from sphinx.ext.autodoc import AutodocReporter
> >
> >
> > -__version__ =3D '1.0'
> > +__version__ =3D "1.0"
> >
> >
> > +# fmt: off
>
> I figure this tells black to keep quiet for the remainder of the file.
> Worth a comment, I think.
>

It does, yes. Want an inline comment here?


> >  # Function borrowed from pydash, which is under the MIT license
> >  def intersperse(iterable, separator):
> >      """Yield the members of *iterable* interspersed with *separator*."=
""
>
> With my comments addressed
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>

--000000000000780ffb06187ce56a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, May 15, 2024, 5:17=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; In the coming patches, it&#39;s helpful to have a linting baseline. Ho=
wever,<br>
&gt; there&#39;s no need to shuffle around the deck chairs too much, becaus=
e most<br>
&gt; of this code will be removed once the new qapidoc generator (the<br>
&gt; &quot;transmogrifier&quot;) is in place.<br>
&gt;<br>
&gt; To ease my pain: just turn off the black auto-formatter for most, but<=
br>
&gt; not all, of qapidoc.py. This will help ensure that *new* code follows =
a<br>
&gt; coding standard without bothering too much with cleaning up the existi=
ng<br>
&gt; code.<br>
&gt;<br>
&gt; For manual checking for now, try &quot;black --check qapidoc.py&quot; =
from the<br>
&gt; docs/sphinx directory. &quot;pip install black&quot; (without root per=
missions) if<br>
&gt; you do not have it installed otherwise.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 16 +++++++++-------<br>
&gt;=C2=A0 1 file changed, 9 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index f270b494f01..1655682d4c7 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -28,28 +28,30 @@<br>
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
<br>
Exchanges old pylint gripe<br>
<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:45:4: C0412: Imports from package sphi=
nx are not grouped (ungrouped-imports)<br>
<br>
for new gripes<br>
<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:37:0: C0411: third party import &quot;=
import sphinx&quot; should be placed before &quot;from qapi.error import QA=
PIError, QAPISemError&quot; (wrong-import-order)<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:38:0: C0411: third party import &quot;=
from sphinx.errors import ExtensionError&quot; should be placed before &quo=
t;from qapi.error import QAPIError, QAPISemError&quot; (wrong-import-order)=
<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:39:0: C0411: third party import &quot;=
from sphinx.util.nodes import nested_parse_with_titles&quot; should be plac=
ed before &quot;from qapi.error import QAPIError, QAPISemError&quot; (wrong=
-import-order)<br>
<br>
Easy enough to fix.<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">This is a problem where our sphinx directory is collidin=
g with the sphinx namespace and different versions of the tooling disagree =
with the assessment.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#=
39;ll try to fix this without renaming our directory, but I&#39;m worried t=
hat might be the most robust solution.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later<br>
&gt;=C2=A0 # use switch_source_input. Check borrowed from kerneldoc.py.<br>
&gt; -Use_SSI =3D sphinx.__version__[:3] &gt;=3D &#39;1.7&#39;<br>
&gt; +Use_SSI =3D sphinx.__version__[:3] &gt;=3D &quot;1.7&quot;<br>
&gt;=C2=A0 if Use_SSI:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.util.docutils import switch_source_inp=
ut<br>
&gt;=C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.ext.autodoc import AutodocReporter<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; -__version__ =3D &#39;1.0&#39;<br>
&gt; +__version__ =3D &quot;1.0&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +# fmt: off<br>
<br>
I figure this tells black to keep quiet for the remainder of the file.<br>
Worth a comment, I think.<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">It does, yes. Want an inline comment here?</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
&gt;=C2=A0 # Function borrowed from pydash, which is under the MIT license<=
br>
&gt;=C2=A0 def intersperse(iterable, separator):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Yield the members of *iterable* =
interspersed with *separator*.&quot;&quot;&quot;<br>
<br>
With my comments addressed<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000780ffb06187ce56a--


