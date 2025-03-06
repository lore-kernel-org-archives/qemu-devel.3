Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B1EC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5tA-000855-8O; Thu, 06 Mar 2025 02:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq5t6-00084f-IO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq5t3-0004GF-CQ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741246998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi1RqQkMCCf0Yj2VyGRuoP6+fhnqRcv4cba5n4bNypo=;
 b=azc9l81qOP8PXgWfXC5NpC0bubIUyvd91a1ELgulA3drFCaQyNeondOShWcx28jyjnMrKD
 PY9vtQ9jT5XfRi4hRwD9G4s6SAhs8atyd5SlVecFBqVCnuWxYEQG078/mnEgXlyEehK2Hz
 xBjXnr2vD4udhCo1rpjrOftFpnuehzM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-UImi3Js2MbSHM5iWX_fQkA-1; Thu,
 06 Mar 2025 02:43:01 -0500
X-MC-Unique: UImi3Js2MbSHM5iWX_fQkA-1
X-Mimecast-MFC-AGG-ID: UImi3Js2MbSHM5iWX_fQkA_1741246980
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A01BB180AF6E; Thu,  6 Mar 2025 07:43:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39C2E1956095; Thu,  6 Mar 2025 07:42:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C630121E675F; Thu, 06 Mar 2025 08:42:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 31/57] qapi: expand tags to all doc sections
In-Reply-To: <CAFn=p-bUtzo1dByK0k6kevNDqghcc15L1N8WFWNB_nm9kXvCbQ@mail.gmail.com>
 (John Snow's message of "Wed, 5 Mar 2025 22:58:14 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-32-jsnow@redhat.com>
 <875xknok8w.fsf@pond.sub.org>
 <CAFn=p-bUtzo1dByK0k6kevNDqghcc15L1N8WFWNB_nm9kXvCbQ@mail.gmail.com>
Date: Thu, 06 Mar 2025 08:42:56 +0100
Message-ID: <87zfhyeha7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Wed, Mar 5, 2025 at 5:16=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> Replaying review of a previous posting for your convenience...
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch adds an explicit section "kind" to all QAPIDoc
>> > sections. Members/Features are now explicitly marked as such, with the
>> > name now being stored in a dedicated "name" field (which qapidoc.py was
>> > not actually using anyway.)
>>
>> I'm not sure what the parenthesis is trying to convey.
>>
>
> The old qapidoc.py doesn't actually use the name field, so there's nothing
> to adjust for old callers.
>
>
>>
>> Before the patch, we have:
>>
>>               type        tag
>>     untagged  Section     None
>>     @foo:     ArgSection  'foo'
>>     Returns:  Section     'Returns'
>>     Errors:   Section     'Errors'
>>     Since:    Section     'Since'
>>     TODO:     Section     'TODO'
>>
>> Afterwards, I believe:
>>
>>               type         kind     name
>>     untagged  Section      PLAIN
>>     @foo:     ArgSection   MEMBER   'foo'   if member or argument
>>               ArgSection   FEATURE  'foo'   if feature
>>     Returns:  Section      RETURNS
>>     Errors:   Section      ERRORS
>>     Since:    Section      SINCE
>>     TODO:     Section      TODO
>>
>> So, .tag is replaced by .kind and .name, member vs. feature vs. other
>> tags is now obvious from .kind alone, i.e. there's no need to account
>> for context or type.
>>
>> Fine print: why do we need to account for type before the patch?
>> Consider @Since: ...
>>
>
> I'm not sure I follow...

Consider

    ##
    # @some-command
    #
    # @Since: an anti-socially named argument
    #
    # Since: 10.0
    ##

Before the patch, both the argument description and the Since section
have tag 'Since'.  The former has type ArgSection, which is a subtype of
Section.  The latter has type Section.  This is how we tell them apart.
There's potential for confusion and misuse of .tag.

After the patch, they have different kinds.

Do you follow now?

>> > The qapi-schema tests are updated to account for the new section names;
>> > mostly "TODO" becomes "Todo" and `None` becomes "Plain".
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/sphinx/qapidoc.py         |   7 ++-
>> >  scripts/qapi/parser.py         | 109 ++++++++++++++++++++++++---------
>> >  tests/qapi-schema/doc-good.out |  10 +--
>> >  tests/qapi-schema/test-qapi.py |   2 +-
>> >  4 files changed, 90 insertions(+), 38 deletions(-)
>> >
>> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> > index 61997fd21af..d622398f1da 100644
>> > --- a/docs/sphinx/qapidoc.py
>> > +++ b/docs/sphinx/qapidoc.py
>> > @@ -35,6 +35,7 @@
>> >  from docutils.statemachine import ViewList
>> >  from qapi.error import QAPIError, QAPISemError
>> >  from qapi.gen import QAPISchemaVisitor
>> > +from qapi.parser import QAPIDoc
>> >  from qapi.schema import QAPISchema
>> >
>> >  from sphinx import addnodes
>> > @@ -258,11 +259,11 @@ def _nodes_for_sections(self, doc):
>> >          """Return list of doctree nodes for additional sections"""
>> >          nodelist =3D []
>> >          for section in doc.sections:
>> > -            if section.tag and section.tag =3D=3D 'TODO':
>> > +            if section.kind =3D=3D QAPIDoc.Kind.TODO:
>> >                  # Hide TODO: sections
>> >                  continue
>> >
>> > -            if not section.tag:
>> > +            if section.kind =3D=3D QAPIDoc.Kind.PLAIN:
>> >                  # Sphinx cannot handle sectionless titles;
>> >                  # Instead, just append the results to the prior secti=
on.
>> >                  container =3D nodes.container()
>> > @@ -270,7 +271,7 @@ def _nodes_for_sections(self, doc):
>> >                  nodelist +=3D container.children
>> >                  continue
>> >
>> > -            snode =3D self._make_section(section.tag)
>> > +            snode =3D self._make_section(section.kind.name.title())
>> >              self._parse_text_into_node(dedent(section.text), snode)
>> >              nodelist.append(snode)
>> >          return nodelist
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 36cb64a677a..c3004aa70c6 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -15,6 +15,7 @@
>> >  # See the COPYING file in the top-level directory.
>> >
>> >  from collections import OrderedDict
>> > +import enum
>> >  import os
>> >  import re
>> >  from typing import (
>> > @@ -575,7 +576,10 @@ def get_doc(self) -> 'QAPIDoc':
>> >                          )
>> >                          raise QAPIParseError(self, emsg)
>> >
>> > -                    doc.new_tagged_section(self.info, match.group(1))
>> > +                    doc.new_tagged_section(
>> > +                        self.info,
>> > +                        QAPIDoc.Kind.from_string(match.group(1))
>> > +                    )
>> >                      text =3D line[match.end():]
>> >                      if text:
>> >                          doc.append_line(text)
>> > @@ -586,7 +590,7 @@ def get_doc(self) -> 'QAPIDoc':
>> >                          self,
>> >                          "unexpected '=3D' markup in definition docume=
ntation")
>> >                  else:
>> > -                    # tag-less paragraph
>> > +                    # plain paragraph(s)
>>
>> We're parsing a single pargraph here.  The plain section we add it to
>> may have any number of paragraphs.  But for me, the comment is about
>> what's being parsed.  Mind to drop (s)?
>>
>
> Anguish. I can't keep this straight in my head. OK. It wasn't obvious at a
> glance where the break is if we get an empty newline ...

The doc parsing code is more subtle than I'd like it to be.

>> >                      doc.ensure_untagged_section(self.info)
>> >                      doc.append_line(line)
>> >                      line =3D self.get_doc_paragraph(doc)
>> > @@ -635,14 +639,37 @@ class QAPIDoc:
>> >      Free-form documentation blocks consist only of a body section.
>> >      """
>> >
>> > +    class Kind(enum.Enum):
>> > +        PLAIN =3D 0
>> > +        MEMBER =3D 1
>> > +        FEATURE =3D 2
>> > +        RETURNS =3D 3
>> > +        ERRORS =3D 4
>> > +        SINCE =3D 5
>> > +        TODO =3D 6
>> > +
>> > +        @staticmethod
>> > +        def from_string(kind: str) -> 'QAPIDoc.Kind':
>>
>> Remind me, why do we need to quote the type here?
>>
>
> It doesn't exist yet; it's a forward reference, basically. While we are in
> the context of defining the class, we don't have access to variables scop=
ed
> within the class :)

Thanks!  Sure this wasn't designed in the 70s?

>> > +            return QAPIDoc.Kind[kind.upper()]
>> > +
>> > +        def text_required(self) -> bool:
>> > +            # Only "plain" sections can be empty
>> > +            return self.value not in (0,)
>>
>> Rather roundabout way to check for PLAIN, isn't it?
>>
>
> Vestigial from intro/details split. It can be removed here for now.
>
>
>>
>> There's just one caller (see below).  I doubt the method is worth its
>> keep.
>>
>
> Vestigial again. Whether it's worth it once there are multiple such
> sections, who knows. I thought it made the code read nicer in context. We
> don't need it right now anyway...

Let's drop it then.

>> > +
>> > +        def __str__(self) -> str:
>> > +            return self.name.title()
>> > +
>>
>> I wonder whether a simple StrEnum without methods would do.  Oh, StrEnum
>> is new in 3.11.  Nevermind.
>>
>> Hmm.
>>
>>     >>> Kind =3D Enum('Kind', [('PLAIN', 'Plain'), ('TODO, 'TODO)])
>>     >>> kind=3DKind('Plain')
>>     >>> kind.value
>>     'Plain'
>>
>> What do you think?
>>
>
> Maybe, lemme play with it and see if it makes something else worse, I don=
't
> know right away.
>
>
>>
>> >      class Section:
>> >          # pylint: disable=3Dtoo-few-public-methods
>> > -        def __init__(self, info: QAPISourceInfo,
>> > -                     tag: Optional[str] =3D None):
>> > +        def __init__(
>> > +            self,
>> > +            info: QAPISourceInfo,
>> > +            kind: 'QAPIDoc.Kind',
>> > +        ):
>> >              # section source info, i.e. where it begins
>> >              self.info =3D info
>> > -            # section tag, if any ('Returns', '@name', ...)
>> > -            self.tag =3D tag
>> > +            # section kind
>> > +            self.kind =3D kind
>> >              # section text without tag
>> >              self.text =3D ''
>> >
>> > @@ -650,8 +677,14 @@ def append_line(self, line: str) -> None:
>> >              self.text +=3D line + '\n'
>> >
>> >      class ArgSection(Section):
>> > -        def __init__(self, info: QAPISourceInfo, tag: str):
>> > -            super().__init__(info, tag)
>> > +        def __init__(
>> > +            self,
>> > +            info: QAPISourceInfo,
>> > +            kind: 'QAPIDoc.Kind',
>> > +            name: str
>> > +        ):
>> > +            super().__init__(info, kind)
>> > +            self.name =3D name
>> >              self.member: Optional['QAPISchemaMember'] =3D None
>>
>> Before the patch, use of a separate type for members, arguments and
>> features was necessary to distinguish between '@TAG:' and 'TAG:' for the
>> various TAGs.  This is no longer the case.  Fold ArgSection into
>> Section?  Not sure.  If yes, separate patch to keep this one as
>> mechanical as possible.
>>
>
> Possibly the case. I'll play with it. Do you want it in this series? (It's
> pretty long as is...!)

Perfectly fine as a follow-up.  We should resist mission-creep.

>> >
>> >          def connect(self, member: 'QAPISchemaMember') -> None:
>> > @@ -663,7 +696,9 @@ def __init__(self, info: QAPISourceInfo, symbol: O=
ptional[str] =3D None):
>> >          # definition doc's symbol, None for free-form doc
>> >          self.symbol: Optional[str] =3D symbol
>> >          # the sections in textual order
>> > -        self.all_sections: List[QAPIDoc.Section] =3D [QAPIDoc.Section=
(info)]
>> > +        self.all_sections: List[QAPIDoc.Section] =3D [
>> > +            QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
>> > +        ]
>> >          # the body section
>> >          self.body: Optional[QAPIDoc.Section] =3D self.all_sections[0]
>> >          # dicts mapping parameter/feature names to their description
>> > @@ -680,12 +715,17 @@ def __init__(self, info: QAPISourceInfo, symbol:=
 Optional[str] =3D None):
>> >      def end(self) -> None:
>> >          for section in self.all_sections:
>> >              section.text =3D section.text.strip('\n')
>> > -            if section.tag is not None and section.text =3D=3D '':
>> > +            if section.kind.text_required() and section.text =3D=3D '=
':
>>
>> This is the only use of .text_required().  I believe checking for PLAIN
>> would be clearer.
>>
>> >                  raise QAPISemError(
>> > -                    section.info, "text required after '%s:'" % secti=
on.tag)
>> > +                    section.info, "text required after '%s:'" % secti=
on.kind)
>> >
>> > -    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>> > -        if self.all_sections and not self.all_sections[-1].tag:
>> > +    def ensure_untagged_section(
>> > +        self,
>> > +        info: QAPISourceInfo,
>> > +    ) -> None:
>>
>> Accidental line breaking?
>>
>
> Something something something black autoformatter. I wonder why it did
> this, though... I'll see if I can undo it.

Yes, please.

>> > +        kind =3D QAPIDoc.Kind.PLAIN
>> > +
>> > +        if self.all_sections and self.all_sections[-1].kind =3D=3D ki=
nd:
>>
>> I'd prefer not to hide PLAIN behind a variable, but I'd also prefer
>> the condition to fit on a line.  Hmm.
>>
>
> Also somewhat vestigial from when I had intro/details. When that split
> comes, kind =3D becomes a conditional ternary.
>
>
>>
>> >              # extend current section
>> >              section =3D self.all_sections[-1]
>> >              if not section.text:
>>
>> Maybe
>>
>>            section =3D self.all_sections[-1] if self.all_sections else N=
one
>>
>>            if second and section.kind =3D QAPIDoc.Kind.Plain:
>>                # extend current section
>>                if not section.text:
>>
>
> Could, but it's going to get rewritten when the inliner comes anyway, ...

You decide.

[...]


