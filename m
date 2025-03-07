Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF61CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWaE-0005GA-2N; Fri, 07 Mar 2025 07:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWZr-0005C0-9H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:13:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWZm-00067G-OU
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741349593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjY0Rs9bBUSnmOtRJuhpN5sxQF2DEeLVFmZhpYTE4WE=;
 b=hU6+P2XKfiAzwUmYGpl+Jr7efvxYEY80uJYZc9B0ZVyNyzd+Ls8m7RBxoGvasgbdvXVajt
 V/rkkN8D2RuFX5unC14lAC7qelIRRUzmn2hN4aNZM6UhS5TYXa6aqH54Ps8p9WO70N4bzS
 j8s90XLvmQYFslUSl9W269v8VNN/SEI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-GIEExsErN8qBrx-658jI5w-1; Fri,
 07 Mar 2025 07:13:09 -0500
X-MC-Unique: GIEExsErN8qBrx-658jI5w-1
X-Mimecast-MFC-AGG-ID: GIEExsErN8qBrx-658jI5w_1741349588
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0769195608D; Fri,  7 Mar 2025 12:13:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45CC61828A81; Fri,  7 Mar 2025 12:13:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B14D921E675F; Fri, 07 Mar 2025 13:13:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 41/57] docs/qapidoc: add preamble() method
In-Reply-To: <20250305034610.960147-42-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:50 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-42-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 13:13:04 +0100
Message-ID: <87r039jay7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> This method adds the options/preamble to each definition block. Notably,
> :since: and :ifcond: are added, as are any "special features" such as
> :deprecated: and :unstable:.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index cf5dbb0133d..d8bf0073dfa 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -37,7 +37,12 @@
>  from docutils.parsers.rst import Directive, directives
>  from docutils.statemachine import StringList
>  from qapi.error import QAPIError
> -from qapi.schema import QAPISchema, QAPISchemaVisitor
> +from qapi.parser import QAPIDoc
> +from qapi.schema import (
> +    QAPISchema,
> +    QAPISchemaDefinition,
> +    QAPISchemaVisitor,
> +)
>  from qapi.source import QAPISourceInfo
>  
>  from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
> @@ -56,8 +61,6 @@
>          Sequence,
>      )
>  
> -    from qapi.parser import QAPIDoc
> -

Some kind of accident?

>      from sphinx.application import Sphinx
>      from sphinx.util.typing import ExtensionMetadata
>  
> @@ -125,6 +128,38 @@ def ensure_blank_line(self) -> None:
>              # +2: correct for zero/one index, then increment by one.
>              self.add_line_raw("", fname, line + 2)
>  
> +    # Transmogrification helpers
> +
> +    def preamble(self, ent: QAPISchemaDefinition) -> None:
> +        """
> +        Generate option lines for qapi entity directives.
> +        """
> +        if ent.doc and ent.doc.since:
> +            assert ent.doc.since.kind == QAPIDoc.Kind.SINCE
> +            # Generated from the entity's docblock; info location is exact.
> +            self.add_line(f":since: {ent.doc.since.text}", ent.doc.since.info)

Break the line afte the comma?

> +
> +        if ent.ifcond.is_present():
> +            doc = ent.ifcond.docgen()
> +            assert ent.info
> +            # Generated from entity definition; info location is approximate.
> +            self.add_line(f":ifcond: {doc}", ent.info)
> +
> +        # Hoist special features such as :deprecated: and :unstable:
> +        # into the options block for the entity. If, in the future, new
> +        # special features are added, qapi-domain will chirp about
> +        # unrecognized options and fail until they are handled in
> +        # qapi-domain.
> +        for feat in ent.features:
> +            if feat.is_special():
> +                # FIXME: handle ifcond if present. How to display that
> +                # information is TBD.

Is the FIXME worth mentioning in the commit message?

> +                # Generated from entity def; info location is approximate.
> +                assert feat.info
> +                self.add_line(f":{feat.name}:", feat.info)
> +
> +        self.ensure_blank_line()
> +
>      # Transmogrification core methods
>  
>      def visit_module(self, path: str) -> None:


