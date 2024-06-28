Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A73DC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDLC-0002GI-Rp; Fri, 28 Jun 2024 11:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNDL9-0002FT-28
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNDKt-0007Fa-Mo
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719587786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iLfQdunI+W6b861bI9ZhihlIYR3+t0330Br9FNKzT8=;
 b=CG0u/TnIAHUUNyf+I3FRw7yMIQXjmefKP8g3yA9F+F9/WiDpKe1DZm2sFCZx8W8FVX479x
 20iFSKCM0tpuELspu43L0fO68k3A9j7dwGajRSq50qL2JyHSioegsRXaNV8gKgyAMcusVA
 SbKDULAd916Nxr0A0iHuqI+vj3PlowY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-MNF7FI5UPC-hWl5-4JoPkQ-1; Fri, 28 Jun 2024 11:16:21 -0400
X-MC-Unique: MNF7FI5UPC-hWl5-4JoPkQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-70ab3bc4a69so647345a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719587780; x=1720192580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2iLfQdunI+W6b861bI9ZhihlIYR3+t0330Br9FNKzT8=;
 b=D1ACPwynBSFHZ4RKiZ1kSMcQXAfec8UoSdfXzdspWEIgVUM8QPsFRVmZy0ROxzULst
 /4/3f4KE8m8J/rXVX22lEjUsWeruG0qw+A5Bj6qWpHc0Ke4zoutP4/gr4GSfTpl5U7U0
 7vqZ8nRt4GvjQ8f0ZbunzVKHeXNOer/gvTJ9UYQLgU9HM3rFsTJLda7MPWW2WNDWYmkl
 YmEQj13UMBiG961BVQjQ/DuhMDAlTrgkHqjq/cUZUbneR8axUSeNRihDuHh9dugFcuCv
 Fh/BxLvHsujVZdmBoMa8t8aSrDeoy2bVtX2bAIoEItAr8B2wJuTGDJbYCaQo9eomqYtA
 xGfw==
X-Gm-Message-State: AOJu0YxbMVlYRcp2rFW37LON05IrvPTOFOtzM9xkmJsMa/+c53wEWobs
 bGVNZcKWe/roo/73jucYc0djLIp7MGAS4hI3rdMXJ/HYzYxMZlBLbqH+v/9FY7uqUgz2WN6RR/8
 jzxDi7rW0RWJDLS8L9NAWZKnxtVImYOcMn1Uhq1BKaYaICXD0ULbtjk3PitdTg8TAiC+jKBww7+
 2QGgSnaszsNXgUHziN211XSbVLWMs=
X-Received: by 2002:a05:6a20:3c86:b0:1be:da68:1f26 with SMTP id
 adf61e73a8af0-1beda6820b8mr5693766637.59.1719587780398; 
 Fri, 28 Jun 2024 08:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLzUJ5EWePs5mtK7heg1VlwDNNF2OB1DHGdJfcL7favy6lsultVLTXFSfUgJprCqi3pUBZSh77Um+GsjxQa9o=
X-Received: by 2002:a05:6a20:3c86:b0:1be:da68:1f26 with SMTP id
 adf61e73a8af0-1beda6820b8mr5693726637.59.1719587779864; Fri, 28 Jun 2024
 08:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-15-jsnow@redhat.com>
 <87tthdxli7.fsf@pond.sub.org>
In-Reply-To: <87tthdxli7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 28 Jun 2024 11:16:08 -0400
Message-ID: <CAFn=p-af+DEBmjsiBH5BvTsGLMt=e0kuLkJgZuHd_8hNPH8SRg@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] docs/qapidoc: factor out do_parse()
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
Content-Type: multipart/alternative; boundary="000000000000c78aef061bf4badd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--000000000000c78aef061bf4badd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024, 9:09=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Factor out the compatibility parser helper so it can be shared by other
> > directives.
>
> Suggest "Factor out the compatibility parser helper into a base class,
> so it can be shared by other directives."


Sure. Haven't read the other mails yet. I'll make the change if you want a
v3, otherwise feel free to edit.


> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 64 +++++++++++++++++++++++-------------------
> >  1 file changed, 35 insertions(+), 29 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index efcd84656fa..43dd99e21e6 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -494,7 +494,41 @@ def visit_module(self, name):
> >          super().visit_module(name)
> >
> >
> > -class QAPIDocDirective(Directive):
> > +class NestedDirective(Directive):
> > +    def run(self):
> > +        raise NotImplementedError
>
> Should this class be abstract?
>

It could be ...

*sneezes*

I plan to delete it by the end of the qapi-domain series anyway, or perhaps
I could even delete it *before* with a dedicated "require sphinx >=3D 3.x"
miniseries.

Actually, that's probably a really good idea...


> > +
> > +    def do_parse(self, rstlist, node):
> > +        """
> > +        Parse rST source lines and add them to the specified node
> > +
> > +        Take the list of rST source lines rstlist, parse them as
> > +        rST, and add the resulting docutils nodes as children of node.
> > +        The nodes are parsed in a way that allows them to include
> > +        subheadings (titles) without confusing the rendering of
> > +        anything else.
> > +        """
> > +        # This is from kerneldoc.py -- it works around an API change i=
n
> > +        # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
> > +        # sphinx.util.nodes.nested_parse_with_titles() rather than the
> > +        # plain self.state.nested_parse(), and so we can drop the savi=
ng
> > +        # of title_styles and section_level that kerneldoc.py does,
> > +        # because nested_parse_with_titles() does that for us.
> > +        if USE_SSI:
> > +            with switch_source_input(self.state, rstlist):
> > +                nested_parse_with_titles(self.state, rstlist, node)
> > +        else:
> > +            save =3D self.state.memo.reporter
> > +            self.state.memo.reporter =3D AutodocReporter(
> > +                rstlist, self.state.memo.reporter
> > +            )
> > +            try:
> > +                nested_parse_with_titles(self.state, rstlist, node)
> > +            finally:
> > +                self.state.memo.reporter =3D save
> > +
> > +
> > +class QAPIDocDirective(NestedDirective):
> >      """Extract documentation from the specified QAPI .json file"""
> >
> >      required_argument =3D 1
> > @@ -532,34 +566,6 @@ def run(self):
> >              # so they are displayed nicely to the user
> >              raise ExtensionError(str(err)) from err
> >
> > -    def do_parse(self, rstlist, node):
> > -        """Parse rST source lines and add them to the specified node
> > -
> > -        Take the list of rST source lines rstlist, parse them as
> > -        rST, and add the resulting docutils nodes as children of node.
> > -        The nodes are parsed in a way that allows them to include
> > -        subheadings (titles) without confusing the rendering of
> > -        anything else.
> > -        """
> > -        # This is from kerneldoc.py -- it works around an API change i=
n
> > -        # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
> > -        # sphinx.util.nodes.nested_parse_with_titles() rather than the
> > -        # plain self.state.nested_parse(), and so we can drop the savi=
ng
> > -        # of title_styles and section_level that kerneldoc.py does,
> > -        # because nested_parse_with_titles() does that for us.
> > -        if USE_SSI:
> > -            with switch_source_input(self.state, rstlist):
> > -                nested_parse_with_titles(self.state, rstlist, node)
> > -        else:
> > -            save =3D self.state.memo.reporter
> > -            self.state.memo.reporter =3D AutodocReporter(
> > -                rstlist, self.state.memo.reporter
> > -            )
> > -            try:
> > -                nested_parse_with_titles(self.state, rstlist, node)
> > -            finally:
> > -                self.state.memo.reporter =3D save
> > -
> >
> >  def setup(app):
> >      """Register qapi-doc directive with Sphinx"""
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>

--000000000000c78aef061bf4badd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 28, 2024, 9:09=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Factor out the compatibility parser helper so it can be shared by othe=
r<br>
&gt; directives.<br>
<br>
Suggest &quot;Factor out the compatibility parser helper into a base class,=
<br>
so it can be shared by other directives.&quot;</blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Sure. Haven&#39;t read the other =
mails yet. I&#39;ll make the change if you want a v3, otherwise feel free t=
o edit.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 64 +++++++++++++++++++++++-------------=
------<br>
&gt;=C2=A0 1 file changed, 35 insertions(+), 29 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index efcd84656fa..43dd99e21e6 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -494,7 +494,41 @@ def visit_module(self, name):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().visit_module(name)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; -class QAPIDocDirective(Directive):<br>
&gt; +class NestedDirective(Directive):<br>
&gt; +=C2=A0 =C2=A0 def run(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise NotImplementedError<br>
<br>
Should this class be abstract?<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">It could be ...=C2=A0</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">*sneezes*</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">I plan to delete it by the end of the qapi-domain series anyw=
ay, or perhaps I could even delete it *before* with a dedicated &quot;requi=
re sphinx &gt;=3D 3.x&quot; miniseries.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Actually, that&#39;s probably a really good idea...</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def do_parse(self, rstlist, node):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Parse rST source lines and add them to th=
e specified node<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Take the list of rST source lines rstlist=
, parse them as<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rST, and add the resulting docutils nodes=
 as children of node.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The nodes are parsed in a way that allows=
 them to include<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 subheadings (titles) without confusing th=
e rendering of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 anything else.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This is from kerneldoc.py -- it works a=
round an API change in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sphinx between 1.6 and 1.7. Unlike kern=
eldoc.py, we use<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # sphinx.util.nodes.nested_parse_with_tit=
les() rather than the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # plain self.state.nested_parse(), and so=
 we can drop the saving<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # of title_styles and section_level that =
kerneldoc.py does,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # because nested_parse_with_titles() does=
 that for us.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if USE_SSI:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with switch_source_input(se=
lf.state, rstlist):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_parse_=
with_titles(self.state, rstlist, node)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save =3D self.state.memo.re=
porter<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.state.memo.reporter =
=3D AutodocReporter(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rstlist, self=
.state.memo.reporter<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_parse_=
with_titles(self.state, rstlist, node)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.state.me=
mo.reporter =3D save<br>
&gt; +<br>
&gt; +<br>
&gt; +class QAPIDocDirective(NestedDirective):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Extract documentation from the s=
pecified QAPI .json file&quot;&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 required_argument =3D 1<br>
&gt; @@ -532,34 +566,6 @@ def run(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # so they are displaye=
d nicely to the user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ExtensionError(s=
tr(err)) from err<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def do_parse(self, rstlist, node):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Parse rST source lines =
and add them to the specified node<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 Take the list of rST source lines rstlist=
, parse them as<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 rST, and add the resulting docutils nodes=
 as children of node.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 The nodes are parsed in a way that allows=
 them to include<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 subheadings (titles) without confusing th=
e rendering of<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 anything else.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This is from kerneldoc.py -- it works a=
round an API change in<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sphinx between 1.6 and 1.7. Unlike kern=
eldoc.py, we use<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # sphinx.util.nodes.nested_parse_with_tit=
les() rather than the<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # plain self.state.nested_parse(), and so=
 we can drop the saving<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # of title_styles and section_level that =
kerneldoc.py does,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # because nested_parse_with_titles() does=
 that for us.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if USE_SSI:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with switch_source_input(se=
lf.state, rstlist):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_parse_=
with_titles(self.state, rstlist, node)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save =3D self.state.memo.re=
porter<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.state.memo.reporter =
=3D AutodocReporter(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rstlist, self=
.state.memo.reporter<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_parse_=
with_titles(self.state, rstlist, node)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.state.me=
mo.reporter =3D save<br>
&gt; -<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def setup(app):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Register qapi-doc directive with=
 Sphinx&quot;&quot;&quot;<br>
<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000c78aef061bf4badd--


