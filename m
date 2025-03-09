Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84498C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 07:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trBIr-0006B2-Fc; Sun, 09 Mar 2025 03:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trBIp-0006AC-9t
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 03:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trBIj-0003wq-Cb
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 03:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741506137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=2iBvVjU7DYhGcbkPxgvGvxolSBVT2lc1Kb3LQBK8DCI=;
 b=Bcq04pVbJsQUmpZ9rXCy1y+1qqBtDJXcP/qNYyDfC9bbS6IMvw/2fjhAVrh+pdPGekAh6W
 8VKZMfHXgBI+nLqvlkB94mLFsMelTynRZ9Ip/IdelRTckyrIa2KJLAjFeViP1+xqvqeBAn
 NoQCmupfHw/KLPUESa0Nepm1yPiV5Ak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-W6Hln7HLO5mqI7mHOaahoQ-1; Sun,
 09 Mar 2025 03:42:15 -0400
X-MC-Unique: W6Hln7HLO5mqI7mHOaahoQ-1
X-Mimecast-MFC-AGG-ID: W6Hln7HLO5mqI7mHOaahoQ_1741506134
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25230180882E; Sun,  9 Mar 2025 07:42:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82F1B300019E; Sun,  9 Mar 2025 07:42:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04CF021E675F; Sun, 09 Mar 2025 08:42:11 +0100 (CET)
Resent-To: michael.roth@amd.com, alex.bennee@linaro.org,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 09 Mar 2025 08:42:10 +0100
Resent-Message-ID: <874j02646l.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 35/57] docs/qapidoc: Fix static typing on qapidoc.py
In-Reply-To: <CAFn=p-bjiZcLGtaOh01745Qb4zpSWdj8G5LeXBOb8=5Uex-ytQ@mail.gmail.com>
 (John Snow's message of "Sat, 8 Mar 2025 13:32:12 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-36-jsnow@redhat.com>
 <878qphkq4i.fsf@pond.sub.org>
 <CAFn=p-bjiZcLGtaOh01745Qb4zpSWdj8G5LeXBOb8=5Uex-ytQ@mail.gmail.com>
Date: Sun, 09 Mar 2025 06:37:51 +0100
Message-ID: <878qpe7oi8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Fri, Mar 7, 2025 at 7:00=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Now that the legacy code is factored out, fix up the typing on the
>> > remaining code in qapidoc.py. Add a type ignore to qapi_legacy.py to
>> > prevent the errors there from bleeding out into qapidoc.py.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/sphinx/qapidoc.py        | 40 ++++++++++++++++++++++-------------
>> >  docs/sphinx/qapidoc_legacy.py |  1 +
>> >  2 files changed, 26 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> > index f4abf42e7bf..5246832b68c 100644
>> > --- a/docs/sphinx/qapidoc.py
>> > +++ b/docs/sphinx/qapidoc.py
>> > @@ -24,17 +24,18 @@
>> >  https://www.sphinx-doc.org/en/master/development/index.html
>> >  """
>> >
>> > +from __future__ import annotations
>> > +
>> >  import os
>> >  import sys
>> > -from typing import List
>> > +from typing import TYPE_CHECKING
>> >
>> >  from docutils import nodes
>> >  from docutils.parsers.rst import Directive, directives
>> >  from qapi.error import QAPIError
>> > -from qapi.gen import QAPISchemaVisitor
>> > -from qapi.schema import QAPISchema
>> > +from qapi.schema import QAPISchema, QAPISchemaVisitor
>> >
>> > -from qapidoc_legacy import QAPISchemaGenRSTVisitor
>> > +from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
>> >  from sphinx import addnodes
>> >  from sphinx.directives.code import CodeBlock
>> >  from sphinx.errors import ExtensionError
>> > @@ -42,6 +43,15 @@
>> >  from sphinx.util.nodes import nested_parse_with_titles
>> >
>> >
>> > +if TYPE_CHECKING:
>> > +    from typing import Any, List, Sequence
>> > +
>> > +    from docutils.statemachine import StringList
>> > +
>> > +    from sphinx.application import Sphinx
>> > +    from sphinx.util.typing import ExtensionMetadata
>>
>> Can you briefly explain why this needs to be conditional?
>>
>
> No requisite, but if they aren't used outside of type hints, they don't
> actually need to be imported at runtime (when we use from __future__ impo=
rt
> annotations). Improves startup speed slightly and potentially makes the
> plugin less porcelain at runtime.

Should we do that for all typing-only imports everywhere?

[...]


