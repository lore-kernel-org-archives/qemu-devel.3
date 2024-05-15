Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13905C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7DhB-0002A5-Ap; Wed, 15 May 2024 08:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7Dh8-00029k-RS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7Dh4-0006RT-GH
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715775909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=otL1LxUCRQuWBGwY/5dqgxzFz9eQAyk3olQNF8ZN0XU=;
 b=TyFIgwSeSiwWRxTnpIKtRdK4Mk6ecxHySHuTvGePg73+znsqKN14dt6gLMqhMmya0e0bj/
 Bmi63S7GacuJ7LLLVmg2jGE9Gq8V0rj1Z/3BuQnYUKWpyVX5EeVTHAj6XPV8aXu02P3Y5y
 P/0OXGL8MdxUEy6DMP+54akSyF6nsig=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-8oV_7NVqM6KzntUw-Dau0g-1; Wed, 15 May 2024 08:24:57 -0400
X-MC-Unique: 8oV_7NVqM6KzntUw-Dau0g-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-65160f333aeso1349219a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715775896; x=1716380696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otL1LxUCRQuWBGwY/5dqgxzFz9eQAyk3olQNF8ZN0XU=;
 b=TbKISgvOtUWTnd3qFZpvLtAHCdkw0buw1Vsi8hNfBCmGe9zEC/MBF8ZxRAd+mMQHy1
 XKj4Q+Zu8185A/mP6MaFRittxNc5AKplBfQDpZKuw0LhS0ncyhdi7M4FMCSXTodgcdlH
 wXLv4FLTQx5sOVmctCSjQBlKnxzOP5mA5IM/n8EFGIPaZYWmG17mqKzLLVxki2nuHUgq
 Bv2BFM51buLiyz72y4KmRTY75RquKnIxN8Msay3apHcVIZ6CUNrGR/j5fw+dFz7LPO+b
 PR3cVqc/ZTKAPy1eGKaXiLlG0fWIPQaKAgVBakBReNgbAIAWMxVI3/jEYgK2zKC9oome
 grbA==
X-Gm-Message-State: AOJu0YxAxdfZuemlWd2/d9dMfFyBYAFueVgzX7jAjm1dbmVGguPBj7t/
 JmXskrLM6Q0j2PX3GaAszjOazPfGXZrfXJCeA3j6pZ0KnXTPa/UpE8qKb0YnBhm89e8S9VgW2k1
 Aaa5l4d/yYrIEs9qOamL8ndYAckrYXPioHc3ys9LUjWWfNbcWDpZwTlvr52XbbKYrr8xg4TlHaS
 TrXIFMUCIzc84akV+pZeAT5mzdFc8=
X-Received: by 2002:a17:90a:5987:b0:2a5:f19:978d with SMTP id
 98e67ed59e1d1-2b6ccd8012cmr14372197a91.37.1715775896411; 
 Wed, 15 May 2024 05:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5tJ1uIBZZGsNJY/vWgemAfv2YPJVqiExTMv1Wd5pTPjSzRMTMB72G6l/acQgTs4xf2wQz1qmVJzHpHX0cThg=
X-Received: by 2002:a17:90a:5987:b0:2a5:f19:978d with SMTP id
 98e67ed59e1d1-2b6ccd8012cmr14372150a91.37.1715775895879; Wed, 15 May 2024
 05:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-5-jsnow@redhat.com>
 <87msorthtp.fsf@pond.sub.org>
In-Reply-To: <87msorthtp.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 May 2024 08:24:43 -0400
Message-ID: <CAFn=p-brFTwcT_SwdnmXWBVhMbR602wQCmtc-6Qb+EBbScGoGg@mail.gmail.com>
Subject: Re: [PATCH 04/20] qapi/parser: preserve indentation in QAPIDoc
 sections
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
Content-Type: multipart/alternative; boundary="000000000000c9da8906187d3465"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000c9da8906187d3465
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024, 7:50=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Prior to this patch, a section like this:
> >
> > @name: lorem ipsum
> >    dolor sit amet
> >      consectetur adipiscing elit
> >
> > would be parsed as:
> >
> > "lorem ipsum\ndolor sit amet\n  consectetur adipiscing elit"
> >
> > We want to preserve the indentation for even the first body line so tha=
t
> > the entire block can be parsed directly as rST. This patch would now
> > parse that segment as:
> >
> > "lorem ipsum\n   dolor sit amet\n     consectetur adipiscing elit"
>
> I'm afraid it's less than clear *why* we want to parse the entire block
> directly as rST.  I have just enough insight into what you've built on
> top of this series to hazard a guess.  Bear with me while I try to
> explain it.
>

My own summary: qapidoc expects a paragraph, the new generator expects a
block.


> We first parse the doc comment with parser.py into an internal
> representation.  The structural parts become objects, and the remainder
> becomes text attributes of these objects.  Currently, parser.py
> carefully adjusts indentation for these text attributes.  Why?  I'll get
> to that.
>
> For your example, parser.py creates an ArgSection object, and sets its
> @text member to
>
>     "lorem ipsum\ndolor sit amet\n  consectetur adipiscing elit"
>
> Printing this string gives us
>
>     lorem ipsum
>     dolor sit amet
>       consectetur adipiscing elit
>
> qapidoc.py then transforms parser.py's IR into Sphinx IR.  The objects
> become (more complicated) Sphinx objects, and their text attributes get
> re-parsed as rST text into still more Sphinx objects.
>
> This re-parse rejects your example with "Unexpected indentation."
>

Specifically, it'd be an unexpected *unindent*; the indent lacking on the
first *two* lines is the problem.


> Let me use a slightly different one:
>
>     # @name: lorem ipsum
>     #    dolor sit amet
>     #    consectetur adipiscing elit
>
> Results in this @text member
>
>     lorem ipsum
>     dolor sit amet
>     consectetur adipiscing elit
>
> which is re-parsed as paragraph, i.e. exactly what we want.
>

It's what we used to want, anyway.


> > This understandably breaks qapidoc.py;
>
> Without indentation adjustment, we'd get
>
>     lorem ipsum
>        dolor sit amet
>        consectetur adipiscing elit
>
> which would be re-parsed as a definition list, I guess.  This isn't what
> we want.
>
> >                                        so a new function is added there
> > to re-dedent the text.
>
> Your patch moves the indentation adjustment to another place.  No
> functional change.
>
> You move it so you can branch off your new rendering pipeline before the
> indentation adjustment, because ...
>
> >                        Once the new generator is merged, this function
> > will not be needed any longer and can be dropped.
>
> ... yours doesn't want it.
>
> I believe it doesn't want it, because it generates rST (with a QAPI
> extension) instead of Sphinx objects.  For your example, something like
>
>     :arg name: lorem ipsum
>        dolor sit amet
>          consectetur adipiscing elit
>
> For mine:
>
>     :arg name: lorem ipsum
>        dolor sit amet
>        consectetur adipiscing elit
>
> Fair?
>

Not quite;

Old parsing, new generator:

:arg type name: lorem ipsum
dolor sit amet
  consectetur apidiscing elit

This is wrong - continuations of a field list must be indented. Unlike
paragraphs, we want indents to "keep the block".

New parsing, new generator:

:arg type name: lorem ipsum
   dolor sit amet
     consectetur apidiscing elit

indent is preserved, maintaining the block-level element.

I don't have to re-add indents and any nested block elements will be
preserved correctly. i.e. you can use code examples, nested lists, etc. in
argument definitions.

The goal here was "Do not treat this as a paragraph, treat it directly as
rST and do not modify it needlessly."

It's a lot simpler than trying to manage the indent and injecting spaces
manually - and adding a temporary dedent to scheduled-for-demolition code
seemed the nicer place to add the hack.


> The transition from the doc comment to (extended) rST is straightforward
> for these examples.
>
> I hope it'll be as straightforward (and thus predictable) in other
> cases, too.
>
> > (I verified this patch changes absolutely nothing by comparing the
> > md5sums of the QMP ref html pages both before and after the change, so
> > it's certified inert. QAPI test output has been updated to reflect the
> > new strategy of preserving indents for rST.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py         | 36 +++++++++++++++++++++++++++++-----
> >  scripts/qapi/parser.py         |  8 ++++++--
> >  tests/qapi-schema/doc-good.out | 32 +++++++++++++++---------------
> >  3 files changed, 53 insertions(+), 23 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 1655682d4c7..2e3ffcbafb7 100644
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
> > @@ -51,6 +52,28 @@
> >  __version__ =3D "1.0"
> >
> >
> > +def dedent(text: str) -> str:
> > +    # Temporary: In service of the new QAPI domain, the QAPI doc parse=
r
> > +    # now preserves indents in args/members/features text. QAPIDoc doe=
s
> > +    # not handle this well, so undo that change here.
> > +
> > +    # QAPIDoc is being rewritten and will be replaced soon,
> > +    # but this function is here in the interim as transition glue.
>
> I'm not sure we need the comment.
>

OK. Guess I'd rather overcomment than undercomment... easier to delete than
add :)


> > +
> > +    lines =3D text.splitlines(True)
> > +    if len(lines) > 1:
> > +        if re.match(r"\s+", lines[0]):
> > +            # First line is indented; description started on
> > +            # the line after the name. dedent the whole block.
> > +            return textwrap.dedent(text)
> > +        else:
>
> pylint gripes
>
>     docs/sphinx/qapidoc.py:65:8: R1705: Unnecessary "else" after "return"=
,
> remove the "else" and de-indent the code inside it (no-else-return)
>

Interesting. What pylint version?


> > +            # Descr started on same line. Dedent line 2+.
> > +            return lines[0] + textwrap.dedent("".join(lines[1:]))
> > +    else:
> > +        # Descr was a single line; dedent entire line.
> > +        return textwrap.dedent(text)
> > +
> > +
> >  # fmt: off
> >  # Function borrowed from pydash, which is under the MIT license
> >  def intersperse(iterable, separator):
> > @@ -169,7 +192,7 @@ def _nodes_for_members(self, doc, what, base=3DNone=
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
> > @@ -207,7 +230,7 @@ def _nodes_for_enum_values(self, doc):
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
> > @@ -242,7 +265,7 @@ def _nodes_for_features(self, doc):
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
> > @@ -265,9 +288,12 @@ def _nodes_for_sections(self, doc):
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
> > index 7b13a583ac1..8cdd5334ec6 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -448,7 +448,10 @@ def get_doc_indented(self, doc: 'QAPIDoc') ->
> Optional[str]:
> >          indent =3D must_match(r'\s*', line).end()
> >          if not indent:
> >              return line
> > -        doc.append_line(line[indent:])
> > +
> > +        # Preserve the indent, it's needed for rST formatting.
>
> I'm not sure we need the comment.
>

OK.


> > +        doc.append_line(line)
> > +
> >          prev_line_blank =3D False
> >          while True:
> >              self.accept(False)
> > @@ -465,7 +468,8 @@ def get_doc_indented(self, doc: 'QAPIDoc') ->
> Optional[str]:
> >                      self,
> >                      "unexpected de-indent (expected at least %d
> spaces)" %
> >                      indent)
> > -            doc.append_line(line[indent:])
> > +            # Again, preserve the indent for ReST.
>
> Likewise.
>
> If you want to document the fact that .get_doc_indented() preserves
> indentation, a function comment or doc string would the proper place.
>

Got it.


> > +            doc.append_line(line)
> >              prev_line_blank =3D True
> >
> >      def get_doc_paragraph(self, doc: 'QAPIDoc') -> Optional[str]:
>
> Correctness argument:
>
> 0. This patch merely moves an indentation adjustment from parser.py to
>    qapidoc.py.
>
>    Checks out: you remove indentation adjustment in parser.py, add it in
>    qapidoc.py, and that's it.
>
> 1. The new indentation adjuster in qapidoc.py behaves just like the old
>    one in parser.py did.
>
>    parser.py's .get_doc_indented() is used to parse what follows certain
>    sections' first line.  It's users store the text on this first line,
>    if any, with leading whitespace stripped, then call
>    .get_doc_indented() to eat the section's remaining lines.  All
>    non-blank lines eaten must be indented at least as much as the first
>    non-blank line.  .get_doc_indented() appends the lines eaten to the
>    stored text with the first non-blank line's indentation stripped from
>    all the non-blank lines.
>
>    Your patch drops this stripping of indentation from non-first lines.
>    This is what must now be done in qapidoc.py.
>
>    If the section's first line has no text, the first non-blank line's
>    indentation must be stripped from all non-blank lines.
>
>    If the section's first line has text, the next non-blank line's
>    indentation must be stripped from all lines but the first.
>
>    How can qapidoc.py detect whether the section's first line has text?
>    Fortunately, such a line will be unindented, i.e. start with a
>    non-blank character, and all remaining lines will be blank or
>    indented.
>
>    qapidoc.py's dedent() seems to remove indentation common to all
>    non-blank lines.  Except when there are multiple lines, and the first
>    one is not indented, it removes common indentation from the remaining
>    lines.
>
>    Common indentation works, because all lines are indented at least as
>    much as the one whose indentation we want to remove.
>
>    The conditional doesn't quite match the "if the section's first line"
>    above.  This simpler dedent() does, and also works in my testing:
>
> def dedent(text: str) -> str:
>     lines =3D text.splitlines(True)
>     if re.match(r"\s+", lines[0]):
>         # First line is indented; description started on
>         # the line after the name. dedent the whole block.
>         return textwrap.dedent(text)
>     # Descr started on same line. Dedent line 2+.
>     return lines[0] + textwrap.dedent("".join(lines[1:]))
>
>    What do you think?
>

I try not to on most days.

I'll check it out, though in practice the generated documents were already
identical, so... I'll try yours and verify that's still true. If so, sure!


> 2. The new one is applied exactly when the old one was.
>
>    The old one is applied to the sections starting with @FOO: and the
>    tagged sections (Returns:, Errors:, ...).
>
>    The new one is applied in ._nodes_for_members(),
>    ._nodes_for_enum_values(), _nodes_for_features(), and
>    ._nodes_for_sections().
>
>    It is not applied to the text of untagged sections, including the
>    body section.
>
>    Good.
>
> > diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> > index 716a9a41026..435f6e6d768 100644
> > --- a/tests/qapi-schema/doc-good.out
> > +++ b/tests/qapi-schema/doc-good.out
> > @@ -117,8 +117,8 @@ doc symbol=3DBase
> >      body=3D
> >
> >      arg=3Dbase1
> > -description starts on a new line,
> > -minimally indented
> > + description starts on a new line,
> > + minimally indented
> >  doc symbol=3DVariant1
> >      body=3D
> >  A paragraph
> > @@ -145,8 +145,8 @@ doc symbol=3DAlternate
> >
> >      arg=3Di
> >  description starts on the same line
> > -remainder indented the same
> > -@b is undocumented
> > +    remainder indented the same
> > +    @b is undocumented
> >      arg=3Db
> >
> >      feature=3Dalt-feat
> > @@ -158,11 +158,11 @@ doc symbol=3Dcmd
> >      body=3D
> >
> >      arg=3Darg1
> > -description starts on a new line,
> > -indented
> > +    description starts on a new line,
> > +    indented
> >      arg=3Darg2
> >  description starts on the same line
> > -remainder indented differently
> > +    remainder indented differently
> >      arg=3Darg3
> >
> >      feature=3Dcmd-feat1
> > @@ -178,16 +178,16 @@ some
> >      section=3DTODO
> >  frobnicate
> >      section=3DNotes
> > -- Lorem ipsum dolor sit amet
> > -- Ut enim ad minim veniam
> > + - Lorem ipsum dolor sit amet
> > + - Ut enim ad minim veniam
> >
> > -Duis aute irure dolor
> > + Duis aute irure dolor
> >      section=3DExample
> > --> in
> > -<- out
> > + -> in
> > + <- out
> >      section=3DExamples
> > -- *verbatim*
> > -- {braces}
> > + - *verbatim*
> > + - {braces}
> >      section=3DSince
> >  2.10
> >  doc symbol=3Dcmd-boxed
> > @@ -198,9 +198,9 @@ a feature
> >      feature=3Dcmd-feat2
> >  another feature
> >      section=3DExample
> > --> in
> > + -> in
> >
> > -<- out
> > + <- out
> >  doc symbol=3DEVT_BOXED
> >      body=3D
>
> The indentation change is nicely visible here.
>
>

--000000000000c9da8906187d3465
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, May 15, 2024, 7:50=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Prior to this patch, a section like this:<br>
&gt;<br>
&gt; @name: lorem ipsum<br>
&gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;<br>
&gt; would be parsed as:<br>
&gt;<br>
&gt; &quot;lorem ipsum\ndolor sit amet\n=C2=A0 consectetur adipiscing elit&=
quot;<br>
&gt;<br>
&gt; We want to preserve the indentation for even the first body line so th=
at<br>
&gt; the entire block can be parsed directly as rST. This patch would now<b=
r>
&gt; parse that segment as:<br>
&gt;<br>
&gt; &quot;lorem ipsum\n=C2=A0 =C2=A0dolor sit amet\n=C2=A0 =C2=A0 =C2=A0co=
nsectetur adipiscing elit&quot;<br>
<br>
I&#39;m afraid it&#39;s less than clear *why* we want to parse the entire b=
lock<br>
directly as rST.=C2=A0 I have just enough insight into what you&#39;ve buil=
t on<br>
top of this series to hazard a guess.=C2=A0 Bear with me while I try to<br>
explain it.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">My own summary: qapidoc expects a paragraph, the new generator e=
xpects a block.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
We first parse the doc comment with parser.py into an internal<br>
representation.=C2=A0 The structural parts become objects, and the remainde=
r<br>
becomes text attributes of these objects.=C2=A0 Currently, parser.py<br>
carefully adjusts indentation for these text attributes.=C2=A0 Why?=C2=A0 I=
&#39;ll get<br>
to that.<br>
<br>
For your example, parser.py creates an ArgSection object, and sets its<br>
@text member to<br>
<br>
=C2=A0 =C2=A0 &quot;lorem ipsum\ndolor sit amet\n=C2=A0 consectetur adipisc=
ing elit&quot;<br>
<br>
Printing this string gives us<br>
<br>
=C2=A0 =C2=A0 lorem ipsum<br>
=C2=A0 =C2=A0 dolor sit amet<br>
=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
<br>
qapidoc.py then transforms parser.py&#39;s IR into Sphinx IR.=C2=A0 The obj=
ects<br>
become (more complicated) Sphinx objects, and their text attributes get<br>
re-parsed as rST text into still more Sphinx objects.<br>
<br>
This re-parse rejects your example with &quot;Unexpected indentation.&quot;=
<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Specifically, it&#39;d be an unexpected *unindent*; the indent lacking on t=
he first *two* lines is the problem.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Let me use a slightly different one:<br>
<br>
=C2=A0 =C2=A0 # @name: lorem ipsum<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 dolor sit amet<br>
=C2=A0 =C2=A0 #=C2=A0 =C2=A0 consectetur adipiscing elit<br>
<br>
Results in this @text member<br>
<br>
=C2=A0 =C2=A0 lorem ipsum<br>
=C2=A0 =C2=A0 dolor sit amet<br>
=C2=A0 =C2=A0 consectetur adipiscing elit<br>
<br>
which is re-parsed as paragraph, i.e. exactly what we want.<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s what we=
 used to want, anyway.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; This understandably breaks qapidoc.py;<br>
<br>
Without indentation adjustment, we&#39;d get<br>
<br>
=C2=A0 =C2=A0 lorem ipsum<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0dolor sit amet<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0consectetur adipiscing elit<br>
<br>
which would be re-parsed as a definition list, I guess.=C2=A0 This isn&#39;=
t what<br>
we want.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 so a =
new function is added there<br>
&gt; to re-dedent the text.<br>
<br>
Your patch moves the indentation adjustment to another place.=C2=A0 No<br>
functional change.<br>
<br>
You move it so you can branch off your new rendering pipeline before the<br=
>
indentation adjustment, because ...<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Once the new generator is merged, this function<br>
&gt; will not be needed any longer and can be dropped.<br>
<br>
... yours doesn&#39;t want it.<br>
<br>
I believe it doesn&#39;t want it, because it generates rST (with a QAPI<br>
extension) instead of Sphinx objects.=C2=A0 For your example, something lik=
e<br>
<br>
=C2=A0 =C2=A0 :arg name: lorem ipsum<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0dolor sit amet<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0consectetur adipiscing elit<br>
<br>
For mine:<br>
<br>
=C2=A0 =C2=A0 :arg name: lorem ipsum<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0dolor sit amet<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0consectetur adipiscing elit<br>
<br>
Fair?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Not quite;</div><div dir=3D"auto"><br></div><div dir=3D"auto">Old pars=
ing, new generator:</div><div dir=3D"auto"><br></div><div dir=3D"auto">:arg=
 type name: lorem ipsum</div><div dir=3D"auto">dolor sit amet</div><div dir=
=3D"auto">=C2=A0 consectetur apidiscing elit</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">This is wrong - continuations of a field list must be =
indented. Unlike paragraphs, we want indents to &quot;keep the block&quot;.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">New parsing, new genera=
tor:</div><div dir=3D"auto"><br></div><div dir=3D"auto">:arg type name: lor=
em ipsum</div><div dir=3D"auto">=C2=A0 =C2=A0dolor sit amet</div><div dir=
=3D"auto">=C2=A0 =C2=A0 =C2=A0consectetur apidiscing elit</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">indent is preserved, maintaining the bloc=
k-level element.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#=
39;t have to re-add indents and any nested block elements will be preserved=
 correctly. i.e. you can use code examples, nested lists, etc. in argument =
definitions.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The goal he=
re was &quot;Do not treat this as a paragraph, treat it directly as rST and=
 do not modify it needlessly.&quot;</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">It&#39;s a lot simpler than trying to manage the indent and inj=
ecting spaces manually - and adding a temporary dedent to scheduled-for-dem=
olition code seemed the nicer place to add the hack.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
The transition from the doc comment to (extended) rST is straightforward<br=
>
for these examples.<br>
<br>
I hope it&#39;ll be as straightforward (and thus predictable) in other<br>
cases, too.<br>
<br>
&gt; (I verified this patch changes absolutely nothing by comparing the<br>
&gt; md5sums of the QMP ref html pages both before and after the change, so=
<br>
&gt; it&#39;s certified inert. QAPI test output has been updated to reflect=
 the<br>
&gt; new strategy of preserving indents for rST.)<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 36 +++=
++++++++++++++++++++++++++-----<br>
&gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
8 ++++++--<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out | 32 +++++++++++++++-------------=
--<br>
&gt;=C2=A0 3 files changed, 53 insertions(+), 23 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 1655682d4c7..2e3ffcbafb7 100644<br>
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
&gt; @@ -51,6 +52,28 @@<br>
&gt;=C2=A0 __version__ =3D &quot;1.0&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +def dedent(text: str) -&gt; str:<br>
&gt; +=C2=A0 =C2=A0 # Temporary: In service of the new QAPI domain, the QAP=
I doc parser<br>
&gt; +=C2=A0 =C2=A0 # now preserves indents in args/members/features text. =
QAPIDoc does<br>
&gt; +=C2=A0 =C2=A0 # not handle this well, so undo that change here.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 # QAPIDoc is being rewritten and will be replaced soon,=
<br>
&gt; +=C2=A0 =C2=A0 # but this function is here in the interim as transitio=
n glue.<br>
<br>
I&#39;m not sure we need the comment.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">OK. Guess I&#39;d rather overcomment =
than undercomment... easier to delete than add :)</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 lines =3D text.splitlines(True)<br>
&gt; +=C2=A0 =C2=A0 if len(lines) &gt; 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.match(r&quot;\s+&quot;, lines[0]):<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # First line is indented; d=
escription started on<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the line after the name. =
dedent the whole block.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return textwrap.dedent(text=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
<br>
pylint gripes<br>
<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:65:8: R1705: Unnecessary &quot;else&qu=
ot; after &quot;return&quot;, remove the &quot;else&quot; and de-indent the=
 code inside it (no-else-return)<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Interesting. What pylint version?</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Descr started on same lin=
e. Dedent line 2+.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return lines[0] + textwrap.=
dedent(&quot;&quot;.join(lines[1:]))<br>
&gt; +=C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Descr was a single line; dedent entire =
line.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return textwrap.dedent(text)<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 # fmt: off<br>
&gt;=C2=A0 # Function borrowed from pydash, which is under the MIT license<=
br>
&gt;=C2=A0 def intersperse(iterable, separator):<br>
&gt; @@ -169,7 +192,7 @@ def _nodes_for_members(self, doc, what, base=3DNon=
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
&gt; @@ -207,7 +230,7 @@ def _nodes_for_enum_values(self, doc):<br>
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
&gt; @@ -242,7 +265,7 @@ def _nodes_for_features(self, doc):<br>
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
&gt; @@ -265,9 +288,12 @@ def _nodes_for_sections(self, doc):<br>
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
&gt; index 7b13a583ac1..8cdd5334ec6 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -448,7 +448,10 @@ def get_doc_indented(self, doc: &#39;QAPIDoc&#39;=
) -&gt; Optional[str]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indent =3D must_match(r&#39;\s*&#39;=
, line).end()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not indent:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return line<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(line[indent:])<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Preserve the indent, it&#39;s needed fo=
r rST formatting.<br>
<br>
I&#39;m not sure we need the comment.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">OK.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(line)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_line_blank =3D False<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept(False)<br>
&gt; @@ -465,7 +468,8 @@ def get_doc_indented(self, doc: &#39;QAPIDoc&#39;)=
 -&gt; Optional[str]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;unexpected de-indent (expected at least %d spaces)&quot; %<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 indent)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(line[indent=
:])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Again, preserve the inden=
t for ReST.<br>
<br>
Likewise.<br>
<br>
If you want to document the fact that .get_doc_indented() preserves<br>
indentation, a function comment or doc string would the proper place.<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Got it=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(line)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_line_blank =3D Tr=
ue<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def get_doc_paragraph(self, doc: &#39;QAPIDoc&#39;=
) -&gt; Optional[str]:<br>
<br>
Correctness argument:<br>
<br>
0. This patch merely moves an indentation adjustment from parser.py to<br>
=C2=A0 =C2=A0qapidoc.py.<br>
<br>
=C2=A0 =C2=A0Checks out: you remove indentation adjustment in parser.py, ad=
d it in<br>
=C2=A0 =C2=A0qapidoc.py, and that&#39;s it.<br>
<br>
1. The new indentation adjuster in qapidoc.py behaves just like the old<br>
=C2=A0 =C2=A0one in parser.py did.<br>
<br>
=C2=A0 =C2=A0parser.py&#39;s .get_doc_indented() is used to parse what foll=
ows certain<br>
=C2=A0 =C2=A0sections&#39; first line.=C2=A0 It&#39;s users store the text =
on this first line,<br>
=C2=A0 =C2=A0if any, with leading whitespace stripped, then call<br>
=C2=A0 =C2=A0.get_doc_indented() to eat the section&#39;s remaining lines.=
=C2=A0 All<br>
=C2=A0 =C2=A0non-blank lines eaten must be indented at least as much as the=
 first<br>
=C2=A0 =C2=A0non-blank line.=C2=A0 .get_doc_indented() appends the lines ea=
ten to the<br>
=C2=A0 =C2=A0stored text with the first non-blank line&#39;s indentation st=
ripped from<br>
=C2=A0 =C2=A0all the non-blank lines.<br>
<br>
=C2=A0 =C2=A0Your patch drops this stripping of indentation from non-first =
lines.<br>
=C2=A0 =C2=A0This is what must now be done in qapidoc.py.<br>
<br>
=C2=A0 =C2=A0If the section&#39;s first line has no text, the first non-bla=
nk line&#39;s<br>
=C2=A0 =C2=A0indentation must be stripped from all non-blank lines.<br>
<br>
=C2=A0 =C2=A0If the section&#39;s first line has text, the next non-blank l=
ine&#39;s<br>
=C2=A0 =C2=A0indentation must be stripped from all lines but the first.<br>
<br>
=C2=A0 =C2=A0How can qapidoc.py detect whether the section&#39;s first line=
 has text?<br>
=C2=A0 =C2=A0Fortunately, such a line will be unindented, i.e. start with a=
<br>
=C2=A0 =C2=A0non-blank character, and all remaining lines will be blank or<=
br>
=C2=A0 =C2=A0indented.<br>
<br>
=C2=A0 =C2=A0qapidoc.py&#39;s dedent() seems to remove indentation common t=
o all<br>
=C2=A0 =C2=A0non-blank lines.=C2=A0 Except when there are multiple lines, a=
nd the first<br>
=C2=A0 =C2=A0one is not indented, it removes common indentation from the re=
maining<br>
=C2=A0 =C2=A0lines.<br>
<br>
=C2=A0 =C2=A0Common indentation works, because all lines are indented at le=
ast as<br>
=C2=A0 =C2=A0much as the one whose indentation we want to remove.<br>
<br>
=C2=A0 =C2=A0The conditional doesn&#39;t quite match the &quot;if the secti=
on&#39;s first line&quot;<br>
=C2=A0 =C2=A0above.=C2=A0 This simpler dedent() does, and also works in my =
testing:<br>
<br>
def dedent(text: str) -&gt; str:<br>
=C2=A0 =C2=A0 lines =3D text.splitlines(True)<br>
=C2=A0 =C2=A0 if re.match(r&quot;\s+&quot;, lines[0]):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # First line is indented; description started o=
n<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # the line after the name. dedent the whole blo=
ck.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return textwrap.dedent(text)<br>
=C2=A0 =C2=A0 # Descr started on same line. Dedent line 2+.<br>
=C2=A0 =C2=A0 return lines[0] + textwrap.dedent(&quot;&quot;.join(lines[1:]=
))<br>
<br>
=C2=A0 =C2=A0What do you think?<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">I try not to on most days.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">I&#39;ll check it out, though in practice=
 the generated documents were already identical, so... I&#39;ll try yours a=
nd verify that&#39;s still true. If so, sure!</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
2. The new one is applied exactly when the old one was.<br>
<br>
=C2=A0 =C2=A0The old one is applied to the sections starting with @FOO: and=
 the<br>
=C2=A0 =C2=A0tagged sections (Returns:, Errors:, ...).<br>
<br>
=C2=A0 =C2=A0The new one is applied in ._nodes_for_members(),<br>
=C2=A0 =C2=A0._nodes_for_enum_values(), _nodes_for_features(), and<br>
=C2=A0 =C2=A0._nodes_for_sections().<br>
<br>
=C2=A0 =C2=A0It is not applied to the text of untagged sections, including =
the<br>
=C2=A0 =C2=A0body section.<br>
<br>
=C2=A0 =C2=A0Good.<br>
<br>
&gt; diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-go=
od.out<br>
&gt; index 716a9a41026..435f6e6d768 100644<br>
&gt; --- a/tests/qapi-schema/doc-good.out<br>
&gt; +++ b/tests/qapi-schema/doc-good.out<br>
&gt; @@ -117,8 +117,8 @@ doc symbol=3DBase<br>
&gt;=C2=A0 =C2=A0 =C2=A0 body=3D<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 arg=3Dbase1<br>
&gt; -description starts on a new line,<br>
&gt; -minimally indented<br>
&gt; + description starts on a new line,<br>
&gt; + minimally indented<br>
&gt;=C2=A0 doc symbol=3DVariant1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 body=3D<br>
&gt;=C2=A0 A paragraph<br>
&gt; @@ -145,8 +145,8 @@ doc symbol=3DAlternate<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 arg=3Di<br>
&gt;=C2=A0 description starts on the same line<br>
&gt; -remainder indented the same<br>
&gt; -@b is undocumented<br>
&gt; +=C2=A0 =C2=A0 remainder indented the same<br>
&gt; +=C2=A0 =C2=A0 @b is undocumented<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arg=3Db<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dalt-feat<br>
&gt; @@ -158,11 +158,11 @@ doc symbol=3Dcmd<br>
&gt;=C2=A0 =C2=A0 =C2=A0 body=3D<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 arg=3Darg1<br>
&gt; -description starts on a new line,<br>
&gt; -indented<br>
&gt; +=C2=A0 =C2=A0 description starts on a new line,<br>
&gt; +=C2=A0 =C2=A0 indented<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arg=3Darg2<br>
&gt;=C2=A0 description starts on the same line<br>
&gt; -remainder indented differently<br>
&gt; +=C2=A0 =C2=A0 remainder indented differently<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arg=3Darg3<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat1<br>
&gt; @@ -178,16 +178,16 @@ some<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DTODO<br>
&gt;=C2=A0 frobnicate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DNotes<br>
&gt; -- Lorem ipsum dolor sit amet<br>
&gt; -- Ut enim ad minim veniam<br>
&gt; + - Lorem ipsum dolor sit amet<br>
&gt; + - Ut enim ad minim veniam<br>
&gt;=C2=A0 <br>
&gt; -Duis aute irure dolor<br>
&gt; + Duis aute irure dolor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DExample<br>
&gt; --&gt; in<br>
&gt; -&lt;- out<br>
&gt; + -&gt; in<br>
&gt; + &lt;- out<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DExamples<br>
&gt; -- *verbatim*<br>
&gt; -- {braces}<br>
&gt; + - *verbatim*<br>
&gt; + - {braces}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DSince<br>
&gt;=C2=A0 2.10<br>
&gt;=C2=A0 doc symbol=3Dcmd-boxed<br>
&gt; @@ -198,9 +198,9 @@ a feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 feature=3Dcmd-feat2<br>
&gt;=C2=A0 another feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 section=3DExample<br>
&gt; --&gt; in<br>
&gt; + -&gt; in<br>
&gt;=C2=A0 <br>
&gt; -&lt;- out<br>
&gt; + &lt;- out<br>
&gt;=C2=A0 doc symbol=3DEVT_BOXED<br>
&gt;=C2=A0 =C2=A0 =C2=A0 body=3D<br>
<br>
The indentation change is nicely visible here.<br>
<br>
</blockquote></div></div></div>

--000000000000c9da8906187d3465--


