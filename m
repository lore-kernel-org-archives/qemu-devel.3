Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727CBC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJ4w-0005T8-1R; Thu, 20 Jun 2024 10:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJ4t-0005Si-Uw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJ4r-0001jo-C3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718894872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4JGC1fvUHB1tRPq+2mmrO0ujhtIQhLO4nLz11Ai6ojk=;
 b=Cui7Go/CK1lo95rtE6RPd5n/WWL95LjCiybbV5D4oIqfx0WxBAFRT7rbxjORUoGL4+AWvx
 PcZChnat0WNaH3sucAV7QxzThVhRiSs/qF27/AZ//154Z8fdE9+yckOtly6CO5bElmGxTm
 dMebrHd0JAMldcH959CHBpX6Jubwv68=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-AyW33aQuN_yJxnzofiG6iw-1; Thu, 20 Jun 2024 10:47:50 -0400
X-MC-Unique: AyW33aQuN_yJxnzofiG6iw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-715e59afb63so59983a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 07:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718894869; x=1719499669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4JGC1fvUHB1tRPq+2mmrO0ujhtIQhLO4nLz11Ai6ojk=;
 b=UGpAzD+aUjJ2u9LMiHNoj3NzDEz/KXOFsyabNkfEgmHEJgV4kE3U7lcPiFCYS/7l1R
 hpi0nuABwLk+jaZtkwnA3cYcGLGwlKZQsqzveEYQzIcN6rLgbaOhRn9lHLv5dRWR9OkI
 Zpmt9+HZbb7hHmsQJpTt6+rhttjfg0wVuPGPm09W6m/kgf/lJgyleKVd56y3eKhLdQgZ
 QucEue/q4yoWsL4sjzNrLG8LXkP8xdOY0E80TyBOjZc4w7sBNvdkv472coLq+x5NrDBi
 xXPBUP6nILmE27rY8e3lkXvzSf5OGknlXc/ovGft921nkOJyBtAN8hgdvcqQPMkF3AsD
 AfmA==
X-Gm-Message-State: AOJu0YwT0hv2tyQ6MFW/9714b7/RUx4Y3pS3/v9DZGwwpN6wxKnXcJC1
 yZTyghOEAQhTYERH72Q4hwxCYBRKc2j4uK0Hj/R9793D0Blk7JW9uJKiqI2NlbOMqPQGc6TURre
 nueARmZCFlUeq/gXo8eQ/sQQ0oTokuuBztCjBgOiZTkCWBj3+9ytEBSk2NEE4JPHZgld//obwQO
 7HJDWlJqWFdZTtxM2ShLE1UvaozwA=
X-Received: by 2002:a17:90a:d48e:b0:2c2:ee5c:35a4 with SMTP id
 98e67ed59e1d1-2c7b4e44920mr6334440a91.0.1718894868004; 
 Thu, 20 Jun 2024 07:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPO09+RL/Pu6ERYz9HxsLHQo3RzexSmVRykWe5m49QcopSk8vxwYF7GQoNrvqLtb2tspwuxpu3uKxJDYilegU=
X-Received: by 2002:a17:90a:d48e:b0:2c2:ee5c:35a4 with SMTP id
 98e67ed59e1d1-2c7b4e44920mr6334355a91.0.1718894866635; Thu, 20 Jun 2024
 07:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-5-jsnow@redhat.com>
 <878qz12l87.fsf@pond.sub.org>
In-Reply-To: <878qz12l87.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jun 2024 10:47:34 -0400
Message-ID: <CAFn=p-YUUfaSKWwEwdR=+3q-TrKR6v0HmYNUk75AvmFEjpviAQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] qapi/parser: preserve indentation in QAPIDoc
 sections
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
Content-Type: multipart/alternative; boundary="000000000000eeb5a7061b53657e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

--000000000000eeb5a7061b53657e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024, 8:03=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Change get_doc_indented() to preserve indentation on all subsequent tex=
t
> > lines, and create a compatibility dedent() function for qapidoc.py to
> > remove that indentation. This is being done for the benefit of a new
>
> Suggest "remove indentation the same way get_doc_indented() did."
>

Aight.


> > qapidoc generator which requires that indentation in argument and
> > features sections are preserved.
> >
> > Prior to this patch, a section like this:
> >
> > ```
> > @name: lorem ipsum
> >    dolor sit amet
> >      consectetur adipiscing elit
> > ```
> >
> > would have its body text be parsed as:
>
> Suggest "parsed into".
>

Why? (I mean, I'll do it, but I don't see the semantic difference
personally)


> > (first and final newline only for presentation)
> >
> > ```
> > lorem ipsum
> > dolor sit amet
> >   consectetur adipiscing elit
> > ```
> >
> > We want to preserve the indentation for even the first body line so tha=
t
> > the entire block can be parsed directly as rST. This patch would now
> > parse that segment as:
>
> If you change "parsed as" to "parsed into" above, then do it here, too.
>
> >
> > ```
> > lorem ipsum
> >    dolor sit amet
> >      consectetur adipiscing elit
> > ```
> >
> > This is helpful for formatting arguments and features as field lists in
> > rST, where the new generator will format this information as:
> >
> > ```
> > :arg type name: lorem ipsum
> >    dolor sit amet
> >      consectetur apidiscing elit
> > ```
> >
> > ...and can be formed by the simple concatenation of the field list
> > construct and the body text. The indents help preserve the continuation
> > of a block-level element, and further allow the use of additional rST
> > block-level constructs such as code blocks, lists, and other such
> > markup. Avoiding reflowing the text conditionally also helps preserve
> > source line context for better rST error reporting from sphinx through
> > generated source, too.
>
> What do you mean by "reflowing"?
>

Poorly phrased, was thinking about emacs too much. I mean munging the text
post-hoc for the doc generator such that newlines are added or removed in
the process of re-formatting text to get the proper indentation for the new
rST form.

In prototyping, this got messy very quickly and was difficult to correlate
source line numbers across the transformation.

It was easier to just not munge the text at all instead of munging it and
then un-munging it.

(semantic satiation: munge munge munge munge.)


> > This understandably breaks the existing qapidoc.py; so a new function i=
s
> > added there to dedent the text for compatibility. Once the new generato=
r
> > is merged, this function will not be needed any longer and can be
> > dropped.
> >
> > I verified this patch changes absolutely nothing by comparing the
> > md5sums of the QMP ref html pages both before and after the change, so
> > it's certified inert. QAPI test output has been updated to reflect the
> > new strategy of preserving indents for rST.
>
> I think the remainder is unnecessary detail.  Drop?
>

As long as you're convinced it's safe, it's done its job and we thank it
for its service

=F0=9F=AB=A1


> > before:
> >
> > 69cde3d6f18b0f324badbb447d4381ce  manual_before/interop/qemu-ga-ref.htm=
l
> > 446e9381833def2adc779f1b90f2215f  manual_before/interop/qemu-qmp-ref.ht=
ml
> > df0ad6c26cb4c28b85d663fe44609c12
> manual_before/interop/qemu-storage-daemon-qmp-ref.html
> >
> > after:
> >
> > 69cde3d6f18b0f324badbb447d4381ce  manual/interop/qemu-ga-ref.html
> > 446e9381833def2adc779f1b90f2215f  manual/interop/qemu-qmp-ref.html
> > df0ad6c26cb4c28b85d663fe44609c12
> manual/interop/qemu-storage-daemon-qmp-ref.html
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py         | 29 ++++++++++++++++++++++++-----
> >  scripts/qapi/parser.py         |  5 +++--
> >  tests/qapi-schema/doc-good.out | 32 ++++++++++++++++----------------
> >  3 files changed, 43 insertions(+), 23 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index e675966defa..f2f2005dd5f 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -26,6 +26,7 @@
> >
> >  import os
> >  import re
> > +import textwrap
> >
> >  from docutils import nodes
> >  from docutils.parsers.rst import Directive, directives
> > @@ -53,6 +54,21 @@
> >  __version__ =3D "1.0"
> >
> >
> > +def dedent(text: str) -> str:
> > +    # Temporary: In service of the new QAPI Sphinx domain, the QAPI do=
c
> > +    # parser now preserves indents in args/members/features text.
> > +    # QAPIDoc does not handle this well, so undo that change here.
>
> A comment should explain how things are.  This one explains how things
> have changed.  Suggest:
>
>        # Adjust indentation to make description text parse as paragraph.
>
> If we planned to keep this, we might want to explain in more detail, as
> I did in review of v1.  But we don't.
>
> > +
> > +    lines =3D text.splitlines(True)
> > +    if re.match(r"\s+", lines[0]):
> > +        # First line is indented; description started on the line afte=
r
> > +        # the name. dedent the whole block.
> > +        return textwrap.dedent(text)
> > +
> > +    # Descr started on same line. Dedent line 2+.
> > +    return lines[0] + textwrap.dedent("".join(lines[1:]))
> > +
> > +
> >  # Disable black auto-formatter until re-enabled:
> >  # fmt: off
> >
> > @@ -176,7 +192,7 @@ def _nodes_for_members(self, doc, what, base=3DNone=
,
> branches=3DNone):
> >              term =3D self._nodes_for_one_member(section.member)
> >              # TODO drop fallbacks when undocumented members are outlaw=
ed
> >              if section.text:
> > -                defn =3D section.text
> > +                defn =3D dedent(section.text)
> >              else:
> >                  defn =3D [nodes.Text('Not documented')]
> >
> > @@ -214,7 +230,7 @@ def _nodes_for_enum_values(self, doc):
> >
> termtext.extend(self._nodes_for_ifcond(section.member.ifcond))
> >              # TODO drop fallbacks when undocumented members are outlaw=
ed
> >              if section.text:
> > -                defn =3D section.text
> > +                defn =3D dedent(section.text)
> >              else:
> >                  defn =3D [nodes.Text('Not documented')]
> >
> > @@ -249,7 +265,7 @@ def _nodes_for_features(self, doc):
> >          dlnode =3D nodes.definition_list()
> >          for section in doc.features.values():
> >              dlnode +=3D self._make_dlitem(
> > -                [nodes.literal('', section.member.name)], section.text=
)
> > +                [nodes.literal('', section.member.name)],
> dedent(section.text))
> >              seen_item =3D True
> >
> >          if not seen_item:
> > @@ -272,9 +288,12 @@ def _nodes_for_sections(self, doc):
> >                  continue
> >              snode =3D self._make_section(section.tag)
> >              if section.tag and section.tag.startswith('Example'):
> > -                snode +=3D self._nodes_for_example(section.text)
> > +                snode +=3D self._nodes_for_example(dedent(section.text=
))
> >              else:
> > -                self._parse_text_into_node(section.text, snode)
> > +                self._parse_text_into_node(
> > +                    dedent(section.text) if section.tag else
> section.text,
> > +                    snode,
> > +                )
> >              nodelist.append(snode)
> >          return nodelist
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 7b13a583ac1..43167ef0ab3 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -437,6 +437,7 @@ def _match_at_name_colon(string: str) ->
> Optional[Match[str]]:
> >          return re.match(r'@([^:]*): *', string)
> >
> >      def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
> > +        """get_doc_indented preserves indentation for later rST
> parsing."""
>
> A proper function comment explains what the function does.  This one
> merely points out one minor aspect.  Easy fix: delete it.  Alternative
> fix: write a proper function comment.
>

Fair. I'll take a stab at writing a better one, but encourage inevitable
tweaks to the phrasing to be handled by the maintainer afterwards ;)


> >          self.accept(False)
> >          line =3D self.get_doc_line()
> >          while line =3D=3D '':
>
> [...]
>
> Just commit message and doc nitpicks, so
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Thanks! I'll make some good faith adjustments and keep the RB, but
re-review before you merge and (please) feel free to make phrasing tweaks
as you see fit.

>

--000000000000eeb5a7061b53657e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 19, 2024, 8:03=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Change get_doc_indented() to preserve indentation on all subsequent te=
xt<br>
&gt; lines, and create a compatibility dedent() function for qapidoc.py to<=
br>
&gt; remove that indentation. This is being done for the benefit of a new<b=
r>
<br>
Suggest &quot;remove indentation the same way get_doc_indented() did.&quot;=
<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Aight.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; qapidoc generator which requires that indentation in argument and<br>
&gt; features sections are preserved.<br>
&gt;<br>
&gt; Prior to this patch, a section like this:<br>
&gt;<br>
&gt; ```<br>
&gt; @name: lorem ipsum<br>
&gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt; ```<br>
&gt;<br>
&gt; would have its body text be parsed as:<br>
<br>
Suggest &quot;parsed into&quot;.<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Why? (I mean, I&#39;ll do it, but I don&#39=
;t see the semantic difference personally)</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<br>
&gt; (first and final newline only for presentation)<br>
&gt;<br>
&gt; ```<br>
&gt; lorem ipsum<br>
&gt; dolor sit amet<br>
&gt;=C2=A0 =C2=A0consectetur adipiscing elit<br>
&gt; ```<br>
&gt;<br>
&gt; We want to preserve the indentation for even the first body line so th=
at<br>
&gt; the entire block can be parsed directly as rST. This patch would now<b=
r>
&gt; parse that segment as:<br>
<br>
If you change &quot;parsed as&quot; to &quot;parsed into&quot; above, then =
do it here, too.<br>
<br>
&gt;<br>
&gt; ```<br>
&gt; lorem ipsum<br>
&gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt; ```<br>
&gt;<br>
&gt; This is helpful for formatting arguments and features as field lists i=
n<br>
&gt; rST, where the new generator will format this information as:<br>
&gt;<br>
&gt; ```<br>
&gt; :arg type name: lorem ipsum<br>
&gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 consectetur apidiscing elit<br>
&gt; ```<br>
&gt;<br>
&gt; ...and can be formed by the simple concatenation of the field list<br>
&gt; construct and the body text. The indents help preserve the continuatio=
n<br>
&gt; of a block-level element, and further allow the use of additional rST<=
br>
&gt; block-level constructs such as code blocks, lists, and other such<br>
&gt; markup. Avoiding reflowing the text conditionally also helps preserve<=
br>
&gt; source line context for better rST error reporting from sphinx through=
<br>
&gt; generated source, too.<br>
<br>
What do you mean by &quot;reflowing&quot;?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Poorly phrased, was thinking abou=
t emacs too much. I mean munging the text post-hoc for the doc generator su=
ch that newlines are added or removed in the process of re-formatting text =
to get the proper indentation for the new rST form.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">In prototyping, this got messy very quickly and=
 was difficult to correlate source line numbers across the transformation.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">It was easier to just no=
t munge the text at all instead of munging it and then un-munging it.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">(semantic satiation: munge mu=
nge munge munge.)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; This understandably breaks the existing qapidoc.py; so a new function =
is<br>
&gt; added there to dedent the text for compatibility. Once the new generat=
or<br>
&gt; is merged, this function will not be needed any longer and can be<br>
&gt; dropped.<br>
&gt;<br>
&gt; I verified this patch changes absolutely nothing by comparing the<br>
&gt; md5sums of the QMP ref html pages both before and after the change, so=
<br>
&gt; it&#39;s certified inert. QAPI test output has been updated to reflect=
 the<br>
&gt; new strategy of preserving indents for rST.<br>
<br>
I think the remainder is unnecessary detail.=C2=A0 Drop?<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">As long as you&#39;=
re convinced it&#39;s safe, it&#39;s done its job and we thank it for its s=
ervice</div><div dir=3D"auto"><br></div><div dir=3D"auto">=F0=9F=AB=A1</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
&gt; before:<br>
&gt;<br>
&gt; 69cde3d6f18b0f324badbb447d4381ce=C2=A0 manual_before/interop/qemu-ga-r=
ef.html<br>
&gt; 446e9381833def2adc779f1b90f2215f=C2=A0 manual_before/interop/qemu-qmp-=
ref.html<br>
&gt; df0ad6c26cb4c28b85d663fe44609c12=C2=A0 manual_before/interop/qemu-stor=
age-daemon-qmp-ref.html<br>
&gt;<br>
&gt; after:<br>
&gt;<br>
&gt; 69cde3d6f18b0f324badbb447d4381ce=C2=A0 manual/interop/qemu-ga-ref.html=
<br>
&gt; 446e9381833def2adc779f1b90f2215f=C2=A0 manual/interop/qemu-qmp-ref.htm=
l<br>
&gt; df0ad6c26cb4c28b85d663fe44609c12=C2=A0 manual/interop/qemu-storage-dae=
mon-qmp-ref.html<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 29 +++=
+++++++++++++++++++++-----<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
5 +++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out | 32 ++++++++++++++++------------=
----<br>
&gt;=C2=A0 3 files changed, 43 insertions(+), 23 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index e675966defa..f2f2005dd5f 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -26,6 +26,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 import re<br>
&gt; +import textwrap<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from docutils import nodes<br>
&gt;=C2=A0 from docutils.parsers.rst import Directive, directives<br>
&gt; @@ -53,6 +54,21 @@<br>
&gt;=C2=A0 __version__ =3D &quot;1.0&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +def dedent(text: str) -&gt; str:<br>
&gt; +=C2=A0 =C2=A0 # Temporary: In service of the new QAPI Sphinx domain, =
the QAPI doc<br>
&gt; +=C2=A0 =C2=A0 # parser now preserves indents in args/members/features=
 text.<br>
&gt; +=C2=A0 =C2=A0 # QAPIDoc does not handle this well, so undo that chang=
e here.<br>
<br>
A comment should explain how things are.=C2=A0 This one explains how things=
<br>
have changed.=C2=A0 Suggest:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# Adjust indentation to make description text pa=
rse as paragraph.<br>
<br>
If we planned to keep this, we might want to explain in more detail, as<br>
I did in review of v1.=C2=A0 But we don&#39;t.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 lines =3D text.splitlines(True)<br>
&gt; +=C2=A0 =C2=A0 if re.match(r&quot;\s+&quot;, lines[0]):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # First line is indented; description sta=
rted on the line after<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # the name. dedent the whole block.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return textwrap.dedent(text)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 # Descr started on same line. Dedent line 2+.<br>
&gt; +=C2=A0 =C2=A0 return lines[0] + textwrap.dedent(&quot;&quot;.join(lin=
es[1:]))<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 # Disable black auto-formatter until re-enabled:<br>
&gt;=C2=A0 # fmt: off<br>
&gt;=C2=A0 <br>
&gt; @@ -176,7 +192,7 @@ def _nodes_for_members(self, doc, what, base=3DNon=
e, branches=3DNone):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 term =3D self._nodes_f=
or_one_member(section.member)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO drop fallbacks =
when undocumented members are outlawed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.text:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn =3D sect=
ion.text<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn =3D dede=
nt(section.text)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn =3D=
 [nodes.Text(&#39;Not documented&#39;)]<br>
&gt;=C2=A0 <br>
&gt; @@ -214,7 +230,7 @@ def _nodes_for_enum_values(self, doc):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 termtext=
.extend(self._nodes_for_ifcond(section.member.ifcond))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO drop fallbacks =
when undocumented members are outlawed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.text:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn =3D sect=
ion.text<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn =3D dede=
nt(section.text)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn =3D=
 [nodes.Text(&#39;Not documented&#39;)]<br>
&gt;=C2=A0 <br>
&gt; @@ -249,7 +265,7 @@ def _nodes_for_features(self, doc):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dlnode =3D nodes.definition_list()<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in doc.features.values()=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dlnode +=3D self._make=
_dlitem(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [nodes.litera=
l(&#39;&#39;, <a href=3D"http://section.member.name" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">section.member.name</a>)], section.text)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [nodes.litera=
l(&#39;&#39;, <a href=3D"http://section.member.name" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">section.member.name</a>)], dedent(section.text))<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seen_item =3D True<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not seen_item:<br>
&gt; @@ -272,9 +288,12 @@ def _nodes_for_sections(self, doc):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snode =3D self._make_s=
ection(section.tag)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.tag and sec=
tion.tag.startswith(&#39;Example&#39;):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snode +=3D se=
lf._nodes_for_example(section.text)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snode +=3D se=
lf._nodes_for_example(dedent(section.text))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_t=
ext_into_node(section.text, snode)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_t=
ext_into_node(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 dedent(section.text) if section.tag else section.text,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 snode,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodelist.append(snode)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return nodelist<br>
&gt;=C2=A0 <br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 7b13a583ac1..43167ef0ab3 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -437,6 +437,7 @@ def _match_at_name_colon(string: str) -&gt; Option=
al[Match[str]]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return re.match(r&#39;@([^:]*): *&#3=
9;, string)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def get_doc_indented(self, doc: &#39;QAPIDoc&#39;)=
 -&gt; Optional[str]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;get_doc_indented preser=
ves indentation for later rST parsing.&quot;&quot;&quot;<br>
<br>
A proper function comment explains what the function does.=C2=A0 This one<b=
r>
merely points out one minor aspect.=C2=A0 Easy fix: delete it.=C2=A0 Altern=
ative<br>
fix: write a proper function comment.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Fair. I&#39;ll take a stab at writing=
 a better one, but encourage inevitable tweaks to the phrasing to be handle=
d by the maintainer afterwards ;)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept(False)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D self.get_doc_line()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while line =3D=3D &#39;&#39;:<br>
<br>
[...]<br>
<br>
Just commit message and doc nitpicks, so<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks! I&#39;ll=
 make some good faith adjustments and keep the RB, but re-review before you=
 merge and (please) feel free to make phrasing tweaks as you see fit.</div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
></blockquote></div></div></div>

--000000000000eeb5a7061b53657e--


