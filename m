Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADB5FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJs38-0004gR-Lh; Mon, 04 May 2026 08:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJs37-0004gJ-3w
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJs34-0001EL-6B
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777896316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnUN5y2ebiFUpCyANeZ8qqKqqKx+aDTe6R1X+yxnlyQ=;
 b=P394FYAQ0t0PVNW6ocAeAz6DSvQtru+Px0alDQOwTVDte8xRRVSQJrrI3gU3wakNPWZwB4
 RXL+Q8R2cJzBfA1musORcT6K9kEox/T2YY2a0qgnI5bSjLoUCoUXVl9MsLIbI1W9ZHsvpy
 TiXa/viHDXJWgKB+o7NDlh9h2na7xPA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-_26rMXNaMxGhEBhQi2bg2w-1; Mon,
 04 May 2026 08:05:12 -0400
X-MC-Unique: _26rMXNaMxGhEBhQi2bg2w-1
X-Mimecast-MFC-AGG-ID: _26rMXNaMxGhEBhQi2bg2w_1777896310
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C72819560B4; Mon,  4 May 2026 12:05:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F4D41955D84; Mon,  4 May 2026 12:05:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A2DAE21E6A01; Mon, 04 May 2026 14:05:07 +0200 (CEST)
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
In-Reply-To: <20260429192611.1581223-9-jsnow@redhat.com> (John Snow's message
 of "Wed, 29 Apr 2026 15:26:06 -0400")
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-9-jsnow@redhat.com>
Date: Mon, 04 May 2026 14:05:07 +0200
Message-ID: <871pfr9y8c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> The only real difference here is that we need to dedent all but the
> first line so that it renders correctly. We don't need to do this for
> members and features because they are always rendered as part of a field
> list directive which expects indented lines - Undecorated plaintext
> doesn't, so we chop the indent off.
>
> This does not reflow the text or mess with the source info in any way,
> so "blame" for error messages should be unchanged.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 70ab9cdc214..6b8e4ecd76a 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -35,6 +35,7 @@
>  from pathlib import Path
>  import re
>  import sys
> +import textwrap
>  from typing import TYPE_CHECKING
>  
>  from docutils import nodes
> @@ -150,8 +151,14 @@ def add_lines(
>          self,
>          content: str,
>          info: QAPISourceInfo,
> +        dedent: bool = False,
>      ) -> None:
>          lines = content.splitlines(True)
> +
> +        if dedent:
> +            txt = "".join(lines[1:])
> +            lines[1:] = textwrap.dedent(txt).splitlines(True)
> +

Sure you want to wrap and not just remove indentation?

>          for i, line in enumerate(lines):
>              self.add_line_raw(line, info.fname, info.line + i)
>  
> @@ -223,13 +230,14 @@ def reformat_arobase(text: str) -> str:
>  
>      # Transmogrification helpers
>  
> -    def visit_paragraph(self, section: QAPIDoc.Section) -> None:
> +    def visit_text(self, section: QAPIDoc.Section) -> None:

This is what gets used for sections of kind PLAIN and INTRO.  Can we
come up with a better term for these than "text"?  Your turf, so I
*will* take no for an answer.

>          # Squelch empty paragraphs.
>          if not section.text:
>              return
>  
> +        dedent = bool(section.kind == QAPIDoc.Kind.INTRO)
>          self.ensure_blank_line()
> -        self.add_lines(section.text, section.info)
> +        self.add_lines(section.text, section.info, dedent)
>          self.ensure_blank_line()
>  
>      def visit_member(self, section: QAPIDoc.ArgSection) -> None:
> @@ -367,7 +375,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
>              section.text = self.reformat_arobase(section.text)
>  
>              if section.kind.name in ("PLAIN", "INTRO"):
> -                self.visit_paragraph(section)
> +                self.visit_text(section)
>              elif section.kind == QAPIDoc.Kind.MEMBER:
>                  assert isinstance(section, QAPIDoc.ArgSection)
>                  if section.name == "q_dummy":


