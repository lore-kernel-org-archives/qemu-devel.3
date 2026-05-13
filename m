Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB0CCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN33Z-0002bI-3i; Wed, 13 May 2026 02:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wN33Q-0002b0-7L
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wN32l-0000yO-BA
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778653566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnQL5HKtJlaQ60VSRxjPuhYaFJRE2krATHj930QZ04k=;
 b=SFQ+fuwJsYxictHmkflRBTQizMG/D8h62ntxFuRriuNdSEai3GHfN5z5i0osASw3zu6bKm
 LTQ/pch/tHd0H8puDeCafhssG5BNFs3yECtlzb4iy/x7omWPpOuD0JsJUMqgrMNMytEQjr
 do6vwUWldVyowIazj2M9Hr1Mt7UvLh4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-6lzD1--yPdGAljgHOLUK0g-1; Wed,
 13 May 2026 02:26:03 -0400
X-MC-Unique: 6lzD1--yPdGAljgHOLUK0g-1
X-Mimecast-MFC-AGG-ID: 6lzD1--yPdGAljgHOLUK0g_1778653561
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 840DE19560A2; Wed, 13 May 2026 06:26:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFF2619560A2; Wed, 13 May 2026 06:26:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F51B21E6A01; Wed, 13 May 2026 08:25:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 08/13] qapi/docs: Add rendering for INTRO sections
In-Reply-To: <CAFn=p-Z5U8Zy0OiDuM8fpR26xvBHQZ8v=6yCBvU899jOPJYQwQ@mail.gmail.com>
 (John Snow's message of "Tue, 12 May 2026 17:13:09 -0400")
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-9-jsnow@redhat.com>
 <871pfr9y8c.fsf@pond.sub.org>
 <CAFn=p-Z5U8Zy0OiDuM8fpR26xvBHQZ8v=6yCBvU899jOPJYQwQ@mail.gmail.com>
Date: Wed, 13 May 2026 08:25:58 +0200
Message-ID: <87ecjfvn9l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Mon, May 4, 2026 at 8:05=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > The only real difference here is that we need to dedent all but the
>> > first line so that it renders correctly. We don't need to do this for
>> > members and features because they are always rendered as part of a fie=
ld
>> > list directive which expects indented lines - Undecorated plaintext
>> > doesn't, so we chop the indent off.
>> >
>> > This does not reflow the text or mess with the source info in any way,
>> > so "blame" for error messages should be unchanged.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/sphinx/qapidoc.py | 14 +++++++++++---
>> >  1 file changed, 11 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> > index 70ab9cdc214..6b8e4ecd76a 100644
>> > --- a/docs/sphinx/qapidoc.py
>> > +++ b/docs/sphinx/qapidoc.py
>> > @@ -35,6 +35,7 @@
>> >  from pathlib import Path
>> >  import re
>> >  import sys
>> > +import textwrap
>> >  from typing import TYPE_CHECKING
>> >
>> >  from docutils import nodes
>> > @@ -150,8 +151,14 @@ def add_lines(
>> >          self,
>> >          content: str,
>> >          info: QAPISourceInfo,
>> > +        dedent: bool =3D False,
>> >      ) -> None:
>> >          lines =3D content.splitlines(True)
>> > +
>> > +        if dedent:
>> > +            txt =3D "".join(lines[1:])
>> > +            lines[1:] =3D textwrap.dedent(txt).splitlines(True)
>> > +
>>
>> Sure you want to wrap and not just remove indentation?
>
> "textwrap" is the module, "dedent" is the function. This really is
> just removing indentation. It just happens to be bundled with the
> "textwrap" stdlib module.

Basic reading comprehension fail, my apologies.

>> >          for i, line in enumerate(lines):
>> >              self.add_line_raw(line, info.fname, info.line + i)
>> >
>> > @@ -223,13 +230,14 @@ def reformat_arobase(text: str) -> str:
>> >
>> >      # Transmogrification helpers
>> >
>> > -    def visit_paragraph(self, section: QAPIDoc.Section) -> None:
>> > +    def visit_text(self, section: QAPIDoc.Section) -> None:
>>
>> This is what gets used for sections of kind PLAIN and INTRO.  Can we
>> come up with a better term for these than "text"?  Your turf, so I
>> *will* take no for an answer.
>
> "patches welcome" - I was just avoiding the use of "paragraph" for
> something that might be multiple paragraphs.

Could use "paragraphs".

>                                              Once the literal "PLAIN"
> section is removed (in favor of semantic successors INTRO and
> DETAILS), we can use "visit_plaintext" to refer to the general
> category, but currently it's semantically overloaded.
>
> How about I just do "visit_plaintext" and we suffer with the slight
> ambiguity for the interim? not married to "text", "plaintext" or
> anything else, just don't have better ideas and naming is one of the
> two hard problems in CS.

The temporary ambiguity feels tolerable.

"plaintext" is probably clearer than "paragraphs" once it's no longer
ambiguous.

Thanks!


