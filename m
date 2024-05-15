Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83118C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7I3G-000525-FQ; Wed, 15 May 2024 13:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7I2w-0004zK-7s
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7I2s-0008AM-5M
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715792641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WRX4N5+xF8yjQiDyMx0pabwErY63RRm6DmrH78wmhs=;
 b=V4s5vLKvL9l1BB+JsT6FWqIHDQbZwGsE/zqKFPlOaGft9bRj3U/f/xGfUx5g6M42+xrsXy
 eE6WQzwoDcsCjFzfAyyxzm2dDVW9bGud1NP2VaXcHPacrcZXaI1qHuiBlot2uSYDTw+sYn
 zGGVldHvbfT6ygvg+KJs+NARdHRO4Ao=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-vNvomZVeMvyd2huggubCtA-1; Wed, 15 May 2024 13:03:59 -0400
X-MC-Unique: vNvomZVeMvyd2huggubCtA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a49440f7b5so5998636a91.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715792638; x=1716397438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1WRX4N5+xF8yjQiDyMx0pabwErY63RRm6DmrH78wmhs=;
 b=sE3H15/0xF7sUdRpb+tIm/5fNqA5nzrRPDqE6uFFhI6mtMM4+CtBt9RgOIPpCpNqav
 hMxFgf5VSLoGBH8jYRzxEiIum9On+Tf3oinjCS41KeGdk1sreiJmyQf9LRFkbF+OB+hL
 j1elNr2YvwEwmO4DJy/8+hjmG+cCuMfpYbmDpJwuHD1SKHdvct7IP5dPvxDDl/KTKQca
 KiZYvj2HPeylW229Dw1R12hqIIDGE/UjhM7Rd5r3U53HYWTFV7FTsMqwebxvozlzTZoL
 YrVJiaRp41W7p6gcPyDC+3RBGzFIOQ9IDAkUhfCK0vkWb749HUq90FO53Yacq3OHj8Au
 4TyA==
X-Gm-Message-State: AOJu0YxOmMyykaTpOOYaLymz9c5C9azg8LehvB9pFqAjHEVGiU/18aV2
 YU/DwE5HYcU310v1G9PFFDjeP0yz6btbKvQwwHlv6tLoGj4eU0AVQeaGf2/WGhgdcbj79Ef78nt
 HryhUQVRAhmhzCCfr8UWG6lGKR13oraR6nln4ZkNflGvMrw+E8/T6KugKOXvmvVXp7yUtOKNBLA
 BfTO0hsC4jbixud9msLXGUXtl69c8=
X-Received: by 2002:a17:90a:d987:b0:2b4:365a:1bcf with SMTP id
 98e67ed59e1d1-2b6cc758a88mr13512112a91.12.1715792637890; 
 Wed, 15 May 2024 10:03:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdYxgHfqcyenHySDvs1J89UdrWxn+pXTTU68QI5LqfCU0paV20tyjflNCsMm2jbm3wAJ9j/F0nwYdShAujq2M=
X-Received: by 2002:a17:90a:d987:b0:2b4:365a:1bcf with SMTP id
 98e67ed59e1d1-2b6cc758a88mr13512062a91.12.1715792637386; Wed, 15 May 2024
 10:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-5-jsnow@redhat.com>
 <87msorthtp.fsf@pond.sub.org>
 <CAFn=p-brFTwcT_SwdnmXWBVhMbR602wQCmtc-6Qb+EBbScGoGg@mail.gmail.com>
 <87v83frwfe.fsf@pond.sub.org>
In-Reply-To: <87v83frwfe.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 May 2024 13:03:45 -0400
Message-ID: <CAFn=p-bFcJbOGGyU-2NcZRwzFPWJ7CKgyTCwcw+Fx3R=Xy+zmg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000a902210618811a66"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

--000000000000a902210618811a66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:18=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, May 15, 2024, 7:50=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Prior to this patch, a section like this:
> >> >
> >> > @name: lorem ipsum
> >> >    dolor sit amet
> >> >      consectetur adipiscing elit
> >> >
> >> > would be parsed as:
> >> >
> >> > "lorem ipsum\ndolor sit amet\n  consectetur adipiscing elit"
> >> >
> >> > We want to preserve the indentation for even the first body line so
> that
> >> > the entire block can be parsed directly as rST. This patch would now
> >> > parse that segment as:
> >> >
> >> > "lorem ipsum\n   dolor sit amet\n     consectetur adipiscing elit"
> >>
> >> I'm afraid it's less than clear *why* we want to parse the entire bloc=
k
> >> directly as rST.  I have just enough insight into what you've built on
> >> top of this series to hazard a guess.  Bear with me while I try to
> >> explain it.
> >>
> >
> > My own summary: qapidoc expects a paragraph, the new generator expects =
a
> > block.
> >
> >
> >> We first parse the doc comment with parser.py into an internal
> >> representation.  The structural parts become objects, and the remainde=
r
> >> becomes text attributes of these objects.  Currently, parser.py
> >> carefully adjusts indentation for these text attributes.  Why?  I'll g=
et
> >> to that.
> >>
> >> For your example, parser.py creates an ArgSection object, and sets its
> >> @text member to
> >>
> >>     "lorem ipsum\ndolor sit amet\n  consectetur adipiscing elit"
> >>
> >> Printing this string gives us
> >>
> >>     lorem ipsum
> >>     dolor sit amet
> >>       consectetur adipiscing elit
> >>
> >> qapidoc.py then transforms parser.py's IR into Sphinx IR.  The objects
> >> become (more complicated) Sphinx objects, and their text attributes ge=
t
> >> re-parsed as rST text into still more Sphinx objects.
> >>
> >> This re-parse rejects your example with "Unexpected indentation."
> >>
> >
> > Specifically, it'd be an unexpected *unindent*; the indent lacking on t=
he
> > first *two* lines is the problem.
> >
> >
> >> Let me use a slightly different one:
> >>
> >>     # @name: lorem ipsum
> >>     #    dolor sit amet
> >>     #    consectetur adipiscing elit
> >>
> >> Results in this @text member
> >>
> >>     lorem ipsum
> >>     dolor sit amet
> >>     consectetur adipiscing elit
> >>
> >> which is re-parsed as paragraph, i.e. exactly what we want.
> >>
> >
> > It's what we used to want, anyway.
>
> Yes, I'm describing the current state here.
>
> >> > This understandably breaks qapidoc.py;
> >>
> >> Without indentation adjustment, we'd get
> >>
> >>     lorem ipsum
> >>        dolor sit amet
> >>        consectetur adipiscing elit
> >>
> >> which would be re-parsed as a definition list, I guess.  This isn't wh=
at
> >> we want.
> >>
> >> >                                        so a new function is added
> there
> >> > to re-dedent the text.
> >>
> >> Your patch moves the indentation adjustment to another place.  No
> >> functional change.
> >>
> >> You move it so you can branch off your new rendering pipeline before t=
he
> >> indentation adjustment, because ...
> >>
> >> >                        Once the new generator is merged, this functi=
on
> >> > will not be needed any longer and can be dropped.
> >>
> >> ... yours doesn't want it.
> >>
> >> I believe it doesn't want it, because it generates rST (with a QAPI
> >> extension) instead of Sphinx objects.  For your example, something lik=
e
> >>
> >>     :arg name: lorem ipsum
> >>        dolor sit amet
> >>          consectetur adipiscing elit
> >>
> >> For mine:
> >>
> >>     :arg name: lorem ipsum
> >>        dolor sit amet
> >>        consectetur adipiscing elit
> >>
> >> Fair?
> >>
> >
> > Not quite;
> >
> > Old parsing, new generator:
> >
> > :arg type name: lorem ipsum
> > dolor sit amet
> >   consectetur apidiscing elit
> >
> > This is wrong - continuations of a field list must be indented. Unlike
> > paragraphs, we want indents to "keep the block".
> >
> > New parsing, new generator:
> >
> > :arg type name: lorem ipsum
> >    dolor sit amet
> >      consectetur apidiscing elit
> >
> > indent is preserved, maintaining the block-level element.
> >
> > I don't have to re-add indents and any nested block elements will be
> > preserved correctly. i.e. you can use code examples, nested lists, etc.
> in
> > argument definitions.
> >
> > The goal here was "Do not treat this as a paragraph, treat it directly =
as
> > rST and do not modify it needlessly."
> >
> > It's a lot simpler than trying to manage the indent and injecting space=
s
> > manually - and adding a temporary dedent to scheduled-for-demolition co=
de
> > seemed the nicer place to add the hack.
>
> Understand.
>
> A bit more rationale in the commit message would be nice.  Perhaps start
> with current state ("we deintent"), then describe the patch ("move the
> deindent"), then rationale "to get it out of the way of a new thingy I
> wrote, and intend to post soonish", then "which will replace qapidoc.py
> entirely".
>

Updated with more info than you require. I hear that American third graders
get a free trip to Pizza Hut if they read at least 20 of my commit messages
in a school year.


>
> >> The transition from the doc comment to (extended) rST is straightforwa=
rd
> >> for these examples.
> >>
> >> I hope it'll be as straightforward (and thus predictable) in other
> >> cases, too.
> >>
> >> > (I verified this patch changes absolutely nothing by comparing the
> >> > md5sums of the QMP ref html pages both before and after the change, =
so
> >> > it's certified inert. QAPI test output has been updated to reflect t=
he
> >> > new strategy of preserving indents for rST.)
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  docs/sphinx/qapidoc.py         | 36
> +++++++++++++++++++++++++++++-----
> >> >  scripts/qapi/parser.py         |  8 ++++++--
> >> >  tests/qapi-schema/doc-good.out | 32 +++++++++++++++---------------
> >> >  3 files changed, 53 insertions(+), 23 deletions(-)
> >> >
> >> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> >> > index 1655682d4c7..2e3ffcbafb7 100644
> >> > --- a/docs/sphinx/qapidoc.py
> >> > +++ b/docs/sphinx/qapidoc.py
> >> > @@ -26,6 +26,7 @@
> >> >
> >> >  import os
> >> >  import re
> >> > +import textwrap
> >> >
> >> >  from docutils import nodes
> >> >  from docutils.parsers.rst import Directive, directives
> >> > @@ -51,6 +52,28 @@
> >> >  __version__ =3D "1.0"
> >> >
> >> >
> >> > +def dedent(text: str) -> str:
> >> > +    # Temporary: In service of the new QAPI domain, the QAPI doc
> parser
> >> > +    # now preserves indents in args/members/features text. QAPIDoc
> does
> >> > +    # not handle this well, so undo that change here.
> >> > +
> >> > +    # QAPIDoc is being rewritten and will be replaced soon,
> >> > +    # but this function is here in the interim as transition glue.
> >>
> >> I'm not sure we need the comment.
> >
> > OK. Guess I'd rather overcomment than undercomment... easier to delete
> than
> > add :)
>
> Right :)
>
> >> > +
> >> > +    lines =3D text.splitlines(True)
> >> > +    if len(lines) > 1:
> >> > +        if re.match(r"\s+", lines[0]):
> >> > +            # First line is indented; description started on
> >> > +            # the line after the name. dedent the whole block.
> >> > +            return textwrap.dedent(text)
> >> > +        else:
> >>
> >> pylint gripes
> >>
> >>     docs/sphinx/qapidoc.py:65:8: R1705: Unnecessary "else" after
> "return",
> >> remove the "else" and de-indent the code inside it (no-else-return)
> >>
> >
> > Interesting. What pylint version?
>
> Fedora 39
>
> $ pylint --version
> pylint 3.0.4
> astroid 3.0.3
> Python 3.12.3 (main, Apr 17 2024, 00:00:00) [GCC 13.2.1 20240316 (Red Hat
> 13.2.1-7)]
>

Realized from the prior patch I was not actually running pylint on this
file, for good reason. Nonetheless, I did fix this particular gripe by
using your rewrite.

My current best attempt at reducing the noise:

*from inside the docs/sphinx directory*:

> PYTHONPATH=3D/home/jsnow/src/qemu/scripts/ pylint --rc-file
../../scripts/qapi/pylintrc qapidoc.py
************* Module qapidoc
qapidoc.py:45:0: C0103: Constant name "Use_SSI" doesn't conform to
UPPER_CASE naming style (invalid-name)
qapidoc.py:49:4: E0611: No name 'AutodocReporter' in module
'sphinx.ext.autodoc' (no-name-in-module)
qapidoc.py:77:10: R1708: Do not raise StopIteration in generator, use
return statement instead (stop-iteration-return)
qapidoc.py:567:11: R1735: Consider using '{"version": __version__,
"parallel_read_safe": True, "parallel_write_safe": True, ... }' instead of
a call to 'dict'. (use-dict-literal)

 Hm, actually, maybe this is tractable...


> >> > +            # Descr started on same line. Dedent line 2+.
> >> > +            return lines[0] + textwrap.dedent("".join(lines[1:]))
> >> > +    else:
> >> > +        # Descr was a single line; dedent entire line.
> >> > +        return textwrap.dedent(text)
> >> > +
> >> > +
> >> >  # fmt: off
> >> >  # Function borrowed from pydash, which is under the MIT license
> >> >  def intersperse(iterable, separator):
> >> > @@ -169,7 +192,7 @@ def _nodes_for_members(self, doc, what,
> base=3DNone, branches=3DNone):
> >> >              term =3D self._nodes_for_one_member(section.member)
> >> >              # TODO drop fallbacks when undocumented members are
> outlawed
> >> >              if section.text:
> >> > -                defn =3D section.text
> >> > +                defn =3D dedent(section.text)
> >> >              else:
> >> >                  defn =3D [nodes.Text('Not documented')]
> >> >
> >> > @@ -207,7 +230,7 @@ def _nodes_for_enum_values(self, doc):
> >> >
> termtext.extend(self._nodes_for_ifcond(section.member.ifcond))
> >> >              # TODO drop fallbacks when undocumented members are
> outlawed
> >> >              if section.text:
> >> > -                defn =3D section.text
> >> > +                defn =3D dedent(section.text)
> >> >              else:
> >> >                  defn =3D [nodes.Text('Not documented')]
> >> >
> >> > @@ -242,7 +265,7 @@ def _nodes_for_features(self, doc):
> >> >          dlnode =3D nodes.definition_list()
> >> >          for section in doc.features.values():
> >> >              dlnode +=3D self._make_dlitem(
> >> > -                [nodes.literal('', section.member.name)],
> section.text)
> >> > +                [nodes.literal('', section.member.name)],
> dedent(section.text))
> >> >              seen_item =3D True
> >> >
> >> >          if not seen_item:
> >> > @@ -265,9 +288,12 @@ def _nodes_for_sections(self, doc):
> >> >                  continue
> >> >              snode =3D self._make_section(section.tag)
> >> >              if section.tag and section.tag.startswith('Example'):
> >> > -                snode +=3D self._nodes_for_example(section.text)
> >> > +                snode +=3D
> self._nodes_for_example(dedent(section.text))
> >> >              else:
> >> > -                self._parse_text_into_node(section.text, snode)
> >> > +                self._parse_text_into_node(
> >> > +                    dedent(section.text) if section.tag else
> section.text,
> >> > +                    snode,
> >> > +                )
> >> >              nodelist.append(snode)
> >> >          return nodelist
> >> >
> >> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> >> > index 7b13a583ac1..8cdd5334ec6 100644
> >> > --- a/scripts/qapi/parser.py
> >> > +++ b/scripts/qapi/parser.py
> >> > @@ -448,7 +448,10 @@ def get_doc_indented(self, doc: 'QAPIDoc') ->
> Optional[str]:
> >> >          indent =3D must_match(r'\s*', line).end()
> >> >          if not indent:
> >> >              return line
> >> > -        doc.append_line(line[indent:])
> >> > +
> >> > +        # Preserve the indent, it's needed for rST formatting.
> >>
> >> I'm not sure we need the comment.
> >>
> >
> > OK.
> >
> >
> >> > +        doc.append_line(line)
> >> > +
> >> >          prev_line_blank =3D False
> >> >          while True:
> >> >              self.accept(False)
> >> > @@ -465,7 +468,8 @@ def get_doc_indented(self, doc: 'QAPIDoc') ->
> Optional[str]:
> >> >                      self,
> >> >                      "unexpected de-indent (expected at least %d
> spaces)" %
> >> >                      indent)
> >> > -            doc.append_line(line[indent:])
> >> > +            # Again, preserve the indent for ReST.
> >>
> >> Likewise.
> >>
> >> If you want to document the fact that .get_doc_indented() preserves
> >> indentation, a function comment or doc string would the proper place.
> >>
> >
> > Got it.
> >
> >
> >> > +            doc.append_line(line)
> >> >              prev_line_blank =3D True
> >> >
> >> >      def get_doc_paragraph(self, doc: 'QAPIDoc') -> Optional[str]:
> >>
> >> Correctness argument:
> >>
> >> 0. This patch merely moves an indentation adjustment from parser.py to
> >>    qapidoc.py.
> >>
> >>    Checks out: you remove indentation adjustment in parser.py, add it =
in
> >>    qapidoc.py, and that's it.
> >>
> >> 1. The new indentation adjuster in qapidoc.py behaves just like the ol=
d
> >>    one in parser.py did.
> >>
> >>    parser.py's .get_doc_indented() is used to parse what follows certa=
in
> >>    sections' first line.  It's users store the text on this first line=
,
> >>    if any, with leading whitespace stripped, then call
> >>    .get_doc_indented() to eat the section's remaining lines.  All
> >>    non-blank lines eaten must be indented at least as much as the firs=
t
> >>    non-blank line.  .get_doc_indented() appends the lines eaten to the
> >>    stored text with the first non-blank line's indentation stripped fr=
om
> >>    all the non-blank lines.
> >>
> >>    Your patch drops this stripping of indentation from non-first lines=
.
> >>    This is what must now be done in qapidoc.py.
> >>
> >>    If the section's first line has no text, the first non-blank line's
> >>    indentation must be stripped from all non-blank lines.
> >>
> >>    If the section's first line has text, the next non-blank line's
> >>    indentation must be stripped from all lines but the first.
> >>
> >>    How can qapidoc.py detect whether the section's first line has text=
?
> >>    Fortunately, such a line will be unindented, i.e. start with a
> >>    non-blank character, and all remaining lines will be blank or
> >>    indented.
> >>
> >>    qapidoc.py's dedent() seems to remove indentation common to all
> >>    non-blank lines.  Except when there are multiple lines, and the fir=
st
> >>    one is not indented, it removes common indentation from the remaini=
ng
> >>    lines.
> >>
> >>    Common indentation works, because all lines are indented at least a=
s
> >>    much as the one whose indentation we want to remove.
> >>
> >>    The conditional doesn't quite match the "if the section's first lin=
e"
> >>    above.  This simpler dedent() does, and also works in my testing:
> >>
> >> def dedent(text: str) -> str:
> >>     lines =3D text.splitlines(True)
> >>     if re.match(r"\s+", lines[0]):
> >>         # First line is indented; description started on
> >>         # the line after the name. dedent the whole block.
> >>         return textwrap.dedent(text)
> >>     # Descr started on same line. Dedent line 2+.
> >>     return lines[0] + textwrap.dedent("".join(lines[1:]))
> >>
> >>    What do you think?
> >>
> >
> > I try not to on most days.
>
> I always say "me thinking will cost you extra" ;)
>
> > I'll check it out, though in practice the generated documents were
> already
> > identical, so... I'll try yours and verify that's still true. If so,
> sure!
>

Yup, it checks out and the md5sums are still the same. Good enough for me.


> >
> >
> >> 2. The new one is applied exactly when the old one was.
> >>
> >>    The old one is applied to the sections starting with @FOO: and the
> >>    tagged sections (Returns:, Errors:, ...).
> >>
> >>    The new one is applied in ._nodes_for_members(),
> >>    ._nodes_for_enum_values(), _nodes_for_features(), and
> >>    ._nodes_for_sections().
> >>
> >>    It is not applied to the text of untagged sections, including the
> >>    body section.
> >>
> >>    Good.
>
> Thanks!
>
> [...]
>
>

--000000000000a902210618811a66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 15, 2024 at 10:18=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Wed, May 15, 2024, 7:50=E2=80=AFAM Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrot=
e:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Prior to this patch, a section like this:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; @name: lorem ipsum<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; would be parsed as:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &quot;lorem ipsum\ndolor sit amet\n=C2=A0 consectetur adipisc=
ing elit&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; We want to preserve the indentation for even the first body l=
ine so that<br>
&gt;&gt; &gt; the entire block can be parsed directly as rST. This patch wo=
uld now<br>
&gt;&gt; &gt; parse that segment as:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &quot;lorem ipsum\n=C2=A0 =C2=A0dolor sit amet\n=C2=A0 =C2=A0=
 =C2=A0consectetur adipiscing elit&quot;<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m afraid it&#39;s less than clear *why* we want to parse the=
 entire block<br>
&gt;&gt; directly as rST.=C2=A0 I have just enough insight into what you&#3=
9;ve built on<br>
&gt;&gt; top of this series to hazard a guess.=C2=A0 Bear with me while I t=
ry to<br>
&gt;&gt; explain it.<br>
&gt;&gt;<br>
&gt;<br>
&gt; My own summary: qapidoc expects a paragraph, the new generator expects=
 a<br>
&gt; block.<br>
&gt;<br>
&gt;<br>
&gt;&gt; We first parse the doc comment with parser.py into an internal<br>
&gt;&gt; representation.=C2=A0 The structural parts become objects, and the=
 remainder<br>
&gt;&gt; becomes text attributes of these objects.=C2=A0 Currently, parser.=
py<br>
&gt;&gt; carefully adjusts indentation for these text attributes.=C2=A0 Why=
?=C2=A0 I&#39;ll get<br>
&gt;&gt; to that.<br>
&gt;&gt;<br>
&gt;&gt; For your example, parser.py creates an ArgSection object, and sets=
 its<br>
&gt;&gt; @text member to<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;lorem ipsum\ndolor sit amet\n=C2=A0 conse=
ctetur adipiscing elit&quot;<br>
&gt;&gt;<br>
&gt;&gt; Printing this string gives us<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0lorem ipsum<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0dolor sit amet<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0consectetur adipiscing elit<br>
&gt;&gt;<br>
&gt;&gt; qapidoc.py then transforms parser.py&#39;s IR into Sphinx IR.=C2=
=A0 The objects<br>
&gt;&gt; become (more complicated) Sphinx objects, and their text attribute=
s get<br>
&gt;&gt; re-parsed as rST text into still more Sphinx objects.<br>
&gt;&gt;<br>
&gt;&gt; This re-parse rejects your example with &quot;Unexpected indentati=
on.&quot;<br>
&gt;&gt;<br>
&gt;<br>
&gt; Specifically, it&#39;d be an unexpected *unindent*; the indent lacking=
 on the<br>
&gt; first *two* lines is the problem.<br>
&gt;<br>
&gt;<br>
&gt;&gt; Let me use a slightly different one:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0# @name: lorem ipsum<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt;<br>
&gt;&gt; Results in this @text member<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0lorem ipsum<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0dolor sit amet<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0consectetur adipiscing elit<br>
&gt;&gt;<br>
&gt;&gt; which is re-parsed as paragraph, i.e. exactly what we want.<br>
&gt;&gt;<br>
&gt;<br>
&gt; It&#39;s what we used to want, anyway.<br>
<br>
Yes, I&#39;m describing the current state here.<br>
<br>
&gt;&gt; &gt; This understandably breaks qapidoc.py;<br>
&gt;&gt;<br>
&gt;&gt; Without indentation adjustment, we&#39;d get<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0lorem ipsum<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt;<br>
&gt;&gt; which would be re-parsed as a definition list, I guess.=C2=A0 This=
 isn&#39;t what<br>
&gt;&gt; we want.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 so a new function is added there<br>
&gt;&gt; &gt; to re-dedent the text.<br>
&gt;&gt;<br>
&gt;&gt; Your patch moves the indentation adjustment to another place.=C2=
=A0 No<br>
&gt;&gt; functional change.<br>
&gt;&gt;<br>
&gt;&gt; You move it so you can branch off your new rendering pipeline befo=
re the<br>
&gt;&gt; indentation adjustment, because ...<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 Once the new generator is merged, this function<br>
&gt;&gt; &gt; will not be needed any longer and can be dropped.<br>
&gt;&gt;<br>
&gt;&gt; ... yours doesn&#39;t want it.<br>
&gt;&gt;<br>
&gt;&gt; I believe it doesn&#39;t want it, because it generates rST (with a=
 QAPI<br>
&gt;&gt; extension) instead of Sphinx objects.=C2=A0 For your example, some=
thing like<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0:arg name: lorem ipsum<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt;<br>
&gt;&gt; For mine:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0:arg name: lorem ipsum<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt;<br>
&gt;&gt; Fair?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Not quite;<br>
&gt;<br>
&gt; Old parsing, new generator:<br>
&gt;<br>
&gt; :arg type name: lorem ipsum<br>
&gt; dolor sit amet<br>
&gt;=C2=A0 =C2=A0consectetur apidiscing elit<br>
&gt;<br>
&gt; This is wrong - continuations of a field list must be indented. Unlike=
<br>
&gt; paragraphs, we want indents to &quot;keep the block&quot;.<br>
&gt;<br>
&gt; New parsing, new generator:<br>
&gt;<br>
&gt; :arg type name: lorem ipsum<br>
&gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 consectetur apidiscing elit<br>
&gt;<br>
&gt; indent is preserved, maintaining the block-level element.<br>
&gt;<br>
&gt; I don&#39;t have to re-add indents and any nested block elements will =
be<br>
&gt; preserved correctly. i.e. you can use code examples, nested lists, etc=
. in<br>
&gt; argument definitions.<br>
&gt;<br>
&gt; The goal here was &quot;Do not treat this as a paragraph, treat it dir=
ectly as<br>
&gt; rST and do not modify it needlessly.&quot;<br>
&gt;<br>
&gt; It&#39;s a lot simpler than trying to manage the indent and injecting =
spaces<br>
&gt; manually - and adding a temporary dedent to scheduled-for-demolition c=
ode<br>
&gt; seemed the nicer place to add the hack.<br>
<br>
Understand.<br>
<br>
A bit more rationale in the commit message would be nice.=C2=A0 Perhaps sta=
rt<br>
with current state (&quot;we deintent&quot;), then describe the patch (&quo=
t;move the<br>
deindent&quot;), then rationale &quot;to get it out of the way of a new thi=
ngy I<br>
wrote, and intend to post soonish&quot;, then &quot;which will replace qapi=
doc.py<br>
entirely&quot;.<br></blockquote><div><br></div><div>Updated with more info =
than you require. I hear that American third graders get a free trip to Piz=
za Hut if they read at least 20 of my commit messages in a school year.<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; The transition from the doc comment to (extended) rST is straightf=
orward<br>
&gt;&gt; for these examples.<br>
&gt;&gt;<br>
&gt;&gt; I hope it&#39;ll be as straightforward (and thus predictable) in o=
ther<br>
&gt;&gt; cases, too.<br>
&gt;&gt;<br>
&gt;&gt; &gt; (I verified this patch changes absolutely nothing by comparin=
g the<br>
&gt;&gt; &gt; md5sums of the QMP ref html pages both before and after the c=
hange, so<br>
&gt;&gt; &gt; it&#39;s certified inert. QAPI test output has been updated t=
o reflect the<br>
&gt;&gt; &gt; new strategy of preserving indents for rST.)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 36 +++++++++++++++++++++++++++++-----<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 8 ++++++--<br>
&gt;&gt; &gt;=C2=A0 tests/qapi-schema/doc-good.out | 32 +++++++++++++++----=
-----------<br>
&gt;&gt; &gt;=C2=A0 3 files changed, 53 insertions(+), 23 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<=
br>
&gt;&gt; &gt; index 1655682d4c7..2e3ffcbafb7 100644<br>
&gt;&gt; &gt; --- a/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt; @@ -26,6 +26,7 @@<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 import os<br>
&gt;&gt; &gt;=C2=A0 import re<br>
&gt;&gt; &gt; +import textwrap<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 from docutils import nodes<br>
&gt;&gt; &gt;=C2=A0 from docutils.parsers.rst import Directive, directives<=
br>
&gt;&gt; &gt; @@ -51,6 +52,28 @@<br>
&gt;&gt; &gt;=C2=A0 __version__ =3D &quot;1.0&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +def dedent(text: str) -&gt; str:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 # Temporary: In service of the new QAPI domain=
, the QAPI doc parser<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 # now preserves indents in args/members/featur=
es text. QAPIDoc does<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 # not handle this well, so undo that change he=
re.<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 # QAPIDoc is being rewritten and will be repla=
ced soon,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 # but this function is here in the interim as =
transition glue.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure we need the comment.<br>
&gt;<br>
&gt; OK. Guess I&#39;d rather overcomment than undercomment... easier to de=
lete than<br>
&gt; add :)<br>
<br>
Right :)<br>
<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 lines =3D text.splitlines(True)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if len(lines) &gt; 1:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.match(r&quot;\s+&quot;, li=
nes[0]):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # First line is in=
dented; description started on<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the line after t=
he name. dedent the whole block.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return textwrap.de=
dent(text)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt;<br>
&gt;&gt; pylint gripes<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0docs/sphinx/qapidoc.py:65:8: R1705: Unnecessary=
 &quot;else&quot; after &quot;return&quot;,<br>
&gt;&gt; remove the &quot;else&quot; and de-indent the code inside it (no-e=
lse-return)<br>
&gt;&gt;<br>
&gt;<br>
&gt; Interesting. What pylint version?<br>
<br>
Fedora 39<br>
<br>
$ pylint --version<br>
pylint 3.0.4<br>
astroid 3.0.3<br>
Python 3.12.3 (main, Apr 17 2024, 00:00:00) [GCC 13.2.1 20240316 (Red Hat 1=
3.2.1-7)]<br></blockquote><div><br></div><div>Realized from the prior patch=
 I was not actually running pylint on this file, for good reason. Nonethele=
ss, I did fix this particular gripe by using your rewrite.<br></div><div><b=
r></div><div>My current best attempt at reducing the noise:</div><div><br><=
/div><div>*from inside the docs/sphinx directory*:</div><div><br></div><div=
>&gt; PYTHONPATH=3D/home/jsnow/src/qemu/scripts/ pylint --rc-file ../../scr=
ipts/qapi/pylintrc qapidoc.py</div><div>************* Module qapidoc<br>qap=
idoc.py:45:0: C0103: Constant name &quot;Use_SSI&quot; doesn&#39;t conform =
to UPPER_CASE naming style (invalid-name)<br>qapidoc.py:49:4: E0611: No nam=
e &#39;AutodocReporter&#39; in module &#39;sphinx.ext.autodoc&#39; (no-name=
-in-module)<br>qapidoc.py:77:10: R1708: Do not raise StopIteration in gener=
ator, use return statement instead (stop-iteration-return)<br>qapidoc.py:56=
7:11: R1735: Consider using &#39;{&quot;version&quot;: __version__, &quot;p=
arallel_read_safe&quot;: True, &quot;parallel_write_safe&quot;: True, ... }=
&#39; instead of a call to &#39;dict&#39;. (use-dict-literal)<br></div><div=
><br></div><div>=C2=A0Hm, actually, maybe this is tractable...</div><div><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Descr started on=
 same line. Dedent line 2+.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return lines[0] + =
textwrap.dedent(&quot;&quot;.join(lines[1:]))<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 else:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Descr was a single line; deden=
t entire line.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return textwrap.dedent(text)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 # fmt: off<br>
&gt;&gt; &gt;=C2=A0 # Function borrowed from pydash, which is under the MIT=
 license<br>
&gt;&gt; &gt;=C2=A0 def intersperse(iterable, separator):<br>
&gt;&gt; &gt; @@ -169,7 +192,7 @@ def _nodes_for_members(self, doc, what, b=
ase=3DNone, branches=3DNone):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 term =3D self=
._nodes_for_one_member(section.member)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO drop f=
allbacks when undocumented members are outlawed<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.te=
xt:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn=
 =3D section.text<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn=
 =3D dedent(section.text)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 defn =3D [nodes.Text(&#39;Not documented&#39;)]<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; @@ -207,7 +230,7 @@ def _nodes_for_enum_values(self, doc):<br=
>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 termtext.extend(self._nodes_for_ifcond(section.member.ifcond))<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO drop f=
allbacks when undocumented members are outlawed<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.te=
xt:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn=
 =3D section.text<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defn=
 =3D dedent(section.text)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 defn =3D [nodes.Text(&#39;Not documented&#39;)]<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; @@ -242,7 +265,7 @@ def _nodes_for_features(self, doc):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dlnode =3D nodes.definition=
_list()<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in doc.features=
.values():<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dlnode +=3D s=
elf._make_dlitem(<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [nod=
es.literal(&#39;&#39;, <a href=3D"http://section.member.name" rel=3D"norefe=
rrer" target=3D"_blank">section.member.name</a>)], section.text)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [nod=
es.literal(&#39;&#39;, <a href=3D"http://section.member.name" rel=3D"norefe=
rrer" target=3D"_blank">section.member.name</a>)], dedent(section.text))<br=
>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seen_item =3D=
 True<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not seen_item:<br>
&gt;&gt; &gt; @@ -265,9 +288,12 @@ def _nodes_for_sections(self, doc):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snode =3D sel=
f._make_section(section.tag)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.ta=
g and section.tag.startswith(&#39;Example&#39;):<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snod=
e +=3D self._nodes_for_example(section.text)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snod=
e +=3D self._nodes_for_example(dedent(section.text))<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._parse_text_into_node(section.text, snode)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._parse_text_into_node(<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dedent(section.text) if section.tag else section.text,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 snode,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodelist.appe=
nd(snode)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return nodelist<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<=
br>
&gt;&gt; &gt; index 7b13a583ac1..8cdd5334ec6 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/parser.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/parser.py<br>
&gt;&gt; &gt; @@ -448,7 +448,10 @@ def get_doc_indented(self, doc: &#39;QAP=
IDoc&#39;) -&gt; Optional[str]:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indent =3D must_match(r&#39=
;\s*&#39;, line).end()<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not indent:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return line<b=
r>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(line[indent:])<b=
r>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Preserve the indent, it&#39;s =
needed for rST formatting.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure we need the comment.<br>
&gt;&gt;<br>
&gt;<br>
&gt; OK.<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(line)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_line_blank =3D False<b=
r>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept(F=
alse)<br>
&gt;&gt; &gt; @@ -465,7 +468,8 @@ def get_doc_indented(self, doc: &#39;QAPI=
Doc&#39;) -&gt; Optional[str]:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 self,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;unexpected de-indent (expected at least %d spaces)&quo=
t; %<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 indent)<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(li=
ne[indent:])<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Again, preserve =
the indent for ReST.<br>
&gt;&gt;<br>
&gt;&gt; Likewise.<br>
&gt;&gt;<br>
&gt;&gt; If you want to document the fact that .get_doc_indented() preserve=
s<br>
&gt;&gt; indentation, a function comment or doc string would the proper pla=
ce.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Got it.<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(li=
ne)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_line_bla=
nk =3D True<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def get_doc_paragraph(self, doc: &#39;QAP=
IDoc&#39;) -&gt; Optional[str]:<br>
&gt;&gt;<br>
&gt;&gt; Correctness argument:<br>
&gt;&gt;<br>
&gt;&gt; 0. This patch merely moves an indentation adjustment from parser.p=
y to<br>
&gt;&gt;=C2=A0 =C2=A0 qapidoc.py.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 Checks out: you remove indentation adjustment in pars=
er.py, add it in<br>
&gt;&gt;=C2=A0 =C2=A0 qapidoc.py, and that&#39;s it.<br>
&gt;&gt;<br>
&gt;&gt; 1. The new indentation adjuster in qapidoc.py behaves just like th=
e old<br>
&gt;&gt;=C2=A0 =C2=A0 one in parser.py did.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 parser.py&#39;s .get_doc_indented() is used to parse =
what follows certain<br>
&gt;&gt;=C2=A0 =C2=A0 sections&#39; first line.=C2=A0 It&#39;s users store =
the text on this first line,<br>
&gt;&gt;=C2=A0 =C2=A0 if any, with leading whitespace stripped, then call<b=
r>
&gt;&gt;=C2=A0 =C2=A0 .get_doc_indented() to eat the section&#39;s remainin=
g lines.=C2=A0 All<br>
&gt;&gt;=C2=A0 =C2=A0 non-blank lines eaten must be indented at least as mu=
ch as the first<br>
&gt;&gt;=C2=A0 =C2=A0 non-blank line.=C2=A0 .get_doc_indented() appends the=
 lines eaten to the<br>
&gt;&gt;=C2=A0 =C2=A0 stored text with the first non-blank line&#39;s inden=
tation stripped from<br>
&gt;&gt;=C2=A0 =C2=A0 all the non-blank lines.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 Your patch drops this stripping of indentation from n=
on-first lines.<br>
&gt;&gt;=C2=A0 =C2=A0 This is what must now be done in qapidoc.py.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 If the section&#39;s first line has no text, the firs=
t non-blank line&#39;s<br>
&gt;&gt;=C2=A0 =C2=A0 indentation must be stripped from all non-blank lines=
.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 If the section&#39;s first line has text, the next no=
n-blank line&#39;s<br>
&gt;&gt;=C2=A0 =C2=A0 indentation must be stripped from all lines but the f=
irst.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 How can qapidoc.py detect whether the section&#39;s f=
irst line has text?<br>
&gt;&gt;=C2=A0 =C2=A0 Fortunately, such a line will be unindented, i.e. sta=
rt with a<br>
&gt;&gt;=C2=A0 =C2=A0 non-blank character, and all remaining lines will be =
blank or<br>
&gt;&gt;=C2=A0 =C2=A0 indented.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 qapidoc.py&#39;s dedent() seems to remove indentation=
 common to all<br>
&gt;&gt;=C2=A0 =C2=A0 non-blank lines.=C2=A0 Except when there are multiple=
 lines, and the first<br>
&gt;&gt;=C2=A0 =C2=A0 one is not indented, it removes common indentation fr=
om the remaining<br>
&gt;&gt;=C2=A0 =C2=A0 lines.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 Common indentation works, because all lines are inden=
ted at least as<br>
&gt;&gt;=C2=A0 =C2=A0 much as the one whose indentation we want to remove.<=
br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 The conditional doesn&#39;t quite match the &quot;if =
the section&#39;s first line&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 above.=C2=A0 This simpler dedent() does, and also wor=
ks in my testing:<br>
&gt;&gt;<br>
&gt;&gt; def dedent(text: str) -&gt; str:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0lines =3D text.splitlines(True)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0if re.match(r&quot;\s+&quot;, lines[0]):<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# First line is indented; descrip=
tion started on<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# the line after the name. dedent=
 the whole block.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return textwrap.dedent(text)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0# Descr started on same line. Dedent line 2+.<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0return lines[0] + textwrap.dedent(&quot;&quot;.=
join(lines[1:]))<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 What do you think?<br>
&gt;&gt;<br>
&gt;<br>
&gt; I try not to on most days.<br>
<br>
I always say &quot;me thinking will cost you extra&quot; ;)<br>
<br>
&gt; I&#39;ll check it out, though in practice the generated documents were=
 already<br>
&gt; identical, so... I&#39;ll try yours and verify that&#39;s still true. =
If so, sure!<br></blockquote><div><br></div><div>Yup, it checks out and the=
 md5sums are still the same. Good enough for me.<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt;<br>
&gt;&gt; 2. The new one is applied exactly when the old one was.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 The old one is applied to the sections starting with =
@FOO: and the<br>
&gt;&gt;=C2=A0 =C2=A0 tagged sections (Returns:, Errors:, ...).<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 The new one is applied in ._nodes_for_members(),<br>
&gt;&gt;=C2=A0 =C2=A0 ._nodes_for_enum_values(), _nodes_for_features(), and=
<br>
&gt;&gt;=C2=A0 =C2=A0 ._nodes_for_sections().<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 It is not applied to the text of untagged sections, i=
ncluding the<br>
&gt;&gt;=C2=A0 =C2=A0 body section.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 Good.<br>
<br>
Thanks!<br>
<br>
[...]<br>
<br>
</blockquote></div></div>

--000000000000a902210618811a66--


