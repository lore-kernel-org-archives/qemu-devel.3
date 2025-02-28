Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F38C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzco-0005Ee-Bs; Fri, 28 Feb 2025 07:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnzcm-0005ET-Dn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnzcg-0003l5-HX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740746263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b8SwAhFp5iAfSVIavksa/iFm3DfIubcpap7e3OTgyng=;
 b=I5jIeSlo36k9N/9pIw2USDiSBn+jDqjZBrKUL3Tq9qZbbx4rbJMewEikOx/AzGMGq5uTjC
 INJIPKYwPbY5CG8WNAWk9R0aJouL3rvZdZVwd6tCAXxpzXpwkb3a2u8pc8GmMUWmsT4v/b
 /y4XlCVyxBvfpcvucAUuYHi8INp3vvY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-dhDaisdVNTeG_6Qn99vXxw-1; Fri,
 28 Feb 2025 07:37:40 -0500
X-MC-Unique: dhDaisdVNTeG_6Qn99vXxw-1
X-Mimecast-MFC-AGG-ID: dhDaisdVNTeG_6Qn99vXxw_1740746258
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E2CF19560BC; Fri, 28 Feb 2025 12:37:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEC071800367; Fri, 28 Feb 2025 12:37:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D11121E66B9; Fri, 28 Feb 2025 13:37:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Thomas
 Huth <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 07/10] qapi: expand tags to all doc sections
In-Reply-To: <20250224033741.222749-8-jsnow@redhat.com> (John Snow's message
 of "Sun, 23 Feb 2025 22:37:38 -0500")
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-8-jsnow@redhat.com>
Date: Fri, 28 Feb 2025 13:37:35 +0100
Message-ID: <871pviw8hc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> This patch adds an explicit section "kind" to all QAPIDoc
> sections. Members/Features are now explicitly marked as such, with the
> name now being stored in a dedicated "name" field (which qapidoc.py was
> not actually using anyway.)

I'm not sure what the parenthesis is trying to convey.

Before the patch, we have:

              type        tag
    untagged  Section     None
    @foo:     ArgSection  'foo'
    Returns:  Section     'Returns'
    Errors:   Section     'Errors'
    Since:    Section     'Since'
    TODO:     Section     'TODO'

Afterwards, I believe:

              type         kind     name
    untagged  Section      PLAIN
    @foo:     ArgSection   MEMBER   'foo'   if member or argument
              ArgSection   FEATURE  'foo'   if feature
    Returns:  Section      RETURNS
    Errors:   Section      ERRORS
    Since:    Section      SINCE
    TODO:     Section      TODO

So, .tag is replaced by .kind and .name, member vs. feature vs. other
tags is now obvious from .kind alone, i.e. there's no need to account
for context or type.

Fine print: why do we need to account for type before the patch?
Consider @Since: ...

> The qapi-schema tests are updated to account for the new section names;
> mostly "TODO" becomes "Todo" and `None` becomes "Plain".
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py         |   7 ++-
>  scripts/qapi/parser.py         | 109 ++++++++++++++++++++++++---------
>  tests/qapi-schema/doc-good.out |  10 +--
>  tests/qapi-schema/test-qapi.py |   2 +-
>  4 files changed, 90 insertions(+), 38 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 61997fd21af..d622398f1da 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -35,6 +35,7 @@
>  from docutils.statemachine import ViewList
>  from qapi.error import QAPIError, QAPISemError
>  from qapi.gen import QAPISchemaVisitor
> +from qapi.parser import QAPIDoc
>  from qapi.schema import QAPISchema
>
>  from sphinx import addnodes
> @@ -258,11 +259,11 @@ def _nodes_for_sections(self, doc):
>          """Return list of doctree nodes for additional sections"""
>          nodelist = []
>          for section in doc.sections:
> -            if section.tag and section.tag == 'TODO':
> +            if section.kind == QAPIDoc.Kind.TODO:
>                  # Hide TODO: sections
>                  continue
>
> -            if not section.tag:
> +            if section.kind == QAPIDoc.Kind.PLAIN:
>                  # Sphinx cannot handle sectionless titles;
>                  # Instead, just append the results to the prior section.
>                  container = nodes.container()
> @@ -270,7 +271,7 @@ def _nodes_for_sections(self, doc):
>                  nodelist += container.children
>                  continue
>
> -            snode = self._make_section(section.tag)
> +            snode = self._make_section(section.kind.name.title())
>              self._parse_text_into_node(dedent(section.text), snode)
>              nodelist.append(snode)
>          return nodelist
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 36cb64a677a..c3004aa70c6 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -15,6 +15,7 @@
>  # See the COPYING file in the top-level directory.
>
>  from collections import OrderedDict
> +import enum
>  import os
>  import re
>  from typing import (
> @@ -575,7 +576,10 @@ def get_doc(self) -> 'QAPIDoc':
>                          )
>                          raise QAPIParseError(self, emsg)
>
> -                    doc.new_tagged_section(self.info, match.group(1))
> +                    doc.new_tagged_section(
> +                        self.info,
> +                        QAPIDoc.Kind.from_string(match.group(1))
> +                    )
>                      text = line[match.end():]
>                      if text:
>                          doc.append_line(text)
> @@ -586,7 +590,7 @@ def get_doc(self) -> 'QAPIDoc':
>                          self,
>                          "unexpected '=' markup in definition documentation")
>                  else:
> -                    # tag-less paragraph
> +                    # plain paragraph(s)

We're parsing a single pargraph here.  The plain section we add it to
may have any number of paragraphs.  But for me, the comment is about
what's being parsed.  Mind to drop (s)?

>                      doc.ensure_untagged_section(self.info)
>                      doc.append_line(line)
>                      line = self.get_doc_paragraph(doc)
> @@ -635,14 +639,37 @@ class QAPIDoc:
>      Free-form documentation blocks consist only of a body section.
>      """
>
> +    class Kind(enum.Enum):
> +        PLAIN = 0
> +        MEMBER = 1
> +        FEATURE = 2
> +        RETURNS = 3
> +        ERRORS = 4
> +        SINCE = 5
> +        TODO = 6
> +
> +        @staticmethod
> +        def from_string(kind: str) -> 'QAPIDoc.Kind':

Remind me, why do we need to quote the type here?

> +            return QAPIDoc.Kind[kind.upper()]
> +
> +        def text_required(self) -> bool:
> +            # Only "plain" sections can be empty
> +            return self.value not in (0,)

Rather roundabout way to check for PLAIN, isn't it?

There's just one caller (see below).  I doubt the method is worth its
keep.

> +
> +        def __str__(self) -> str:
> +            return self.name.title()

I wonder whether a simple StrEnum without methods would do.  Oh, StrEnum
is new in 3.11.  Nevermind.

Hmm.

    >>> Kind = Enum('Kind', [('PLAIN', 'Plain'), ('TODO, 'TODO)])
    >>> kind=Kind('Plain')
    >>> kind.value
    'Plain'

What do you think?

> +
>      class Section:
>          # pylint: disable=too-few-public-methods
> -        def __init__(self, info: QAPISourceInfo,
> -                     tag: Optional[str] = None):
> +        def __init__(
> +            self,
> +            info: QAPISourceInfo,
> +            kind: 'QAPIDoc.Kind',
> +        ):
>              # section source info, i.e. where it begins
>              self.info = info
> -            # section tag, if any ('Returns', '@name', ...)
> -            self.tag = tag
> +            # section kind
> +            self.kind = kind
>              # section text without tag
>              self.text = ''
>
> @@ -650,8 +677,14 @@ def append_line(self, line: str) -> None:
>              self.text += line + '\n'
>
>      class ArgSection(Section):
> -        def __init__(self, info: QAPISourceInfo, tag: str):
> -            super().__init__(info, tag)
> +        def __init__(
> +            self,
> +            info: QAPISourceInfo,
> +            kind: 'QAPIDoc.Kind',
> +            name: str
> +        ):
> +            super().__init__(info, kind)
> +            self.name = name
>              self.member: Optional['QAPISchemaMember'] = None

Before the patch, use of a separate type for members, arguments and
features was necessary to distinguish between '@TAG:' and 'TAG:' for the
various TAGs.  This is no longer the case.  Fold ArgSection into
Section?  Not sure.  If yes, separate patch to keep this one as
mechanical as possible.

>
>          def connect(self, member: 'QAPISchemaMember') -> None:
> @@ -663,7 +696,9 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
>          # definition doc's symbol, None for free-form doc
>          self.symbol: Optional[str] = symbol
>          # the sections in textual order
> -        self.all_sections: List[QAPIDoc.Section] = [QAPIDoc.Section(info)]
> +        self.all_sections: List[QAPIDoc.Section] = [
> +            QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
> +        ]
>          # the body section
>          self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
>          # dicts mapping parameter/feature names to their description
> @@ -680,12 +715,17 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
>      def end(self) -> None:
>          for section in self.all_sections:
>              section.text = section.text.strip('\n')
> -            if section.tag is not None and section.text == '':
> +            if section.kind.text_required() and section.text == '':

This is the only use of .text_required().  I believe checking for PLAIN
would be clearer.

>                  raise QAPISemError(
> -                    section.info, "text required after '%s:'" % section.tag)
> +                    section.info, "text required after '%s:'" % section.kind)
>  
> -    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> -        if self.all_sections and not self.all_sections[-1].tag:
> +    def ensure_untagged_section(
> +        self,
> +        info: QAPISourceInfo,
> +    ) -> None:

Accidental line breaking?

> +        kind = QAPIDoc.Kind.PLAIN
> +
> +        if self.all_sections and self.all_sections[-1].kind == kind:

I'd prefer not to hide PLAIN behind a variable, but I'd also prefer
the condition to fit on a line.  Hmm.

>              # extend current section
>              section = self.all_sections[-1]
>              if not section.text:

Maybe

           section = self.all_sections[-1] if self.all_sections else None

           if second and section.kind = QAPIDoc.Kind.Plain:
               # extend current section
               if not section.text:

> @@ -693,46 +733,56 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>                  section.info = info
>              section.text += '\n'
>              return
> +
>          # start new section
> -        section = self.Section(info)
> +        section = self.Section(info, kind)
>          self.sections.append(section)
>          self.all_sections.append(section)
>
> -    def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
> -        section = self.Section(info, tag)
> -        if tag == 'Returns':
> +    def new_tagged_section(
> +        self,
> +        info: QAPISourceInfo,
> +        kind: 'QAPIDoc.Kind',
> +    ) -> None:
> +        section = self.Section(info, kind)
> +        if kind == QAPIDoc.Kind.RETURNS:
>              if self.returns:
>                  raise QAPISemError(
> -                    info, "duplicated '%s' section" % tag)
> +                    info, "duplicated '%s' section" % kind)
>              self.returns = section
> -        elif tag == 'Errors':
> +        elif kind == QAPIDoc.Kind.ERRORS:
>              if self.errors:
>                  raise QAPISemError(
> -                    info, "duplicated '%s' section" % tag)
> +                    info, "duplicated '%s' section" % kind)
>              self.errors = section
> -        elif tag == 'Since':
> +        elif kind == QAPIDoc.Kind.SINCE:
>              if self.since:
>                  raise QAPISemError(
> -                    info, "duplicated '%s' section" % tag)
> +                    info, "duplicated '%s' section" % kind)
>              self.since = section
>          self.sections.append(section)
>          self.all_sections.append(section)
>
> -    def _new_description(self, info: QAPISourceInfo, name: str,
> -                         desc: Dict[str, ArgSection]) -> None:
> +    def _new_description(
> +        self,
> +        info: QAPISourceInfo,
> +        name: str,
> +        kind: 'QAPIDoc.Kind',
> +        desc: Dict[str, ArgSection]
> +    ) -> None:
>          if not name:
>              raise QAPISemError(info, "invalid parameter name")
>          if name in desc:
>              raise QAPISemError(info, "'%s' parameter name duplicated" % name)
> -        section = self.ArgSection(info, '@' + name)
> +        section = self.ArgSection(info, kind, name)
>          self.all_sections.append(section)
>          desc[name] = section
>
>      def new_argument(self, info: QAPISourceInfo, name: str) -> None:
> -        self._new_description(info, name, self.args)
> +        self._new_description(info, name, QAPIDoc.Kind.MEMBER, self.args)
>
>      def new_feature(self, info: QAPISourceInfo, name: str) -> None:
> -        self._new_description(info, name, self.features)
> +        self._new_description(info, name, QAPIDoc.Kind.FEATURE, self.features)

QAPIDoc.Kind.FOO is a mouthful, and it tends to result in long lines,
like here.  Can't see an easy and clean way to reduce the verbosity.

>
>      def append_line(self, line: str) -> None:
>          self.all_sections[-1].append_line(line)
> @@ -744,8 +794,9 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
>                  raise QAPISemError(member.info,
>                                     "%s '%s' lacks documentation"
>                                     % (member.role, member.name))
> -            self.args[member.name] = QAPIDoc.ArgSection(
> -                self.info, '@' + member.name)
> +            section = QAPIDoc.ArgSection(
> +                self.info, QAPIDoc.Kind.MEMBER, member.name)
> +            self.args[member.name] = section

Why the extra variable?

>          self.args[member.name].connect(member)
>
>      def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index ec277be91e9..2d33a305ee7 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -110,7 +110,7 @@ The _one_ {and only}, description on the same line
>  Also _one_ {and only}
>      feature=enum-member-feat
>  a member feature
> -    section=None
> +    section=Plain
>  @two is undocumented
>  doc symbol=Base
>      body=
> @@ -168,15 +168,15 @@ description starts on the same line
>  a feature
>      feature=cmd-feat2
>  another feature
> -    section=None
> +    section=Plain
>  .. note:: @arg3 is undocumented
>      section=Returns
>  @Object
>      section=Errors
>  some
> -    section=TODO
> +    section=Todo

With the method-less Enum I suggested, this hunk would go away.  Not
that it matters :)

>  frobnicate
> -    section=None
> +    section=Plain
>  .. admonition:: Notes
>
>   - Lorem ipsum dolor sit amet
> @@ -209,7 +209,7 @@ If you're bored enough to read this, go see a video of boxed cats
>  a feature
>      feature=cmd-feat2
>  another feature
> -    section=None
> +    section=Plain
>  .. qmp-example::
>
>     -> "this example"
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
> index 7e3f9f4aa1f..bca924309be 100755
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -131,7 +131,7 @@ def test_frontend(fname):
>          for feat, section in doc.features.items():
>              print('    feature=%s\n%s' % (feat, section.text))
>          for section in doc.sections:
> -            print('    section=%s\n%s' % (section.tag, section.text))
> +            print('    section=%s\n%s' % (section.kind, section.text))
>
>
>  def open_test_result(dir_name, file_name, update):


