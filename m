Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EC3E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOdmm-0001BV-9t; Fri, 20 Dec 2024 09:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOdmj-0001BH-8i
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:15:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOdmh-0000fa-0T
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734704116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JYYe/yg4ZXCHXJUnJf+ZqYKjuKMMy5okFoMItBkEqFk=;
 b=O3lw/ZIkGlzgqIQgAAQENrBfA7b0S2GvfHcTy5i1iQjYDL3iYZpZqOrG4w2ieVXjGejAG6
 toMgpH+6CImQhrYoK4FumpJlLZqLQUs8TzB3qaBIj+n5cr1ejXcOEqRi5rbLmt40YiIEZt
 LkEAYi+OsZxPprnntpfx2dZmlYYYvvM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-dhjj_xWiOIeUuQxs_LBqOQ-1; Fri,
 20 Dec 2024 09:15:10 -0500
X-MC-Unique: dhjj_xWiOIeUuQxs_LBqOQ-1
X-Mimecast-MFC-AGG-ID: dhjj_xWiOIeUuQxs_LBqOQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 386AB1955F41; Fri, 20 Dec 2024 14:15:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 061AD1956053; Fri, 20 Dec 2024 14:15:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF52221E6740; Fri, 20 Dec 2024 15:15:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 11/23] docs/qapidoc: add preamble() method
In-Reply-To: <20241213021827.2956769-12-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:14 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-12-jsnow@redhat.com>
Date: Fri, 20 Dec 2024 15:15:04 +0100
Message-ID: <87h66y30gn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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
>  docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 6f8f69077b1..85c7ce94564 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -38,7 +38,7 @@
>  from qapi.error import QAPIError, QAPISemError
>  from qapi.gen import QAPISchemaVisitor
>  from qapi.parser import QAPIDoc
> -from qapi.schema import QAPISchema
> +from qapi.schema import QAPISchema, QAPISchemaEntity
>  from qapi.source import QAPISourceInfo
>  
>  from sphinx import addnodes
> @@ -125,6 +125,37 @@ def ensure_blank_line(self) -> None:
>              # +2: correct for zero/one index, then increment by one.
>              self.add_line_raw("", fname, line + 2)
>  
> +    # Transmogrification helpers
> +
> +    def preamble(self, ent: QAPISchemaEntity) -> None:
> +        """
> +        Generate option lines for qapi entity directives.
> +        """
> +        if ent.doc and ent.doc.since:
> +            assert ent.doc.since.tag == QAPIDoc.Tag.SINCE
> +            # Generated from the entity's docblock; info location is exact.
> +            self.add_line(f":since: {ent.doc.since.text}", ent.doc.since.info)
> +
> +        if ent.ifcond.is_present():
> +            doc = ent.ifcond.docgen()
> +            # Generated from entity definition; info location is approximate.
> +            self.add_line(f":ifcond: {doc}", ent.info)
> +
> +        # Hoist special features such as :deprecated: and :unstable:
> +        # into the options block for the entity. If, in the future, new
> +        # special features are added, qapi-domain will chirp about
> +        # unrecognized options and fail.
> +        for feat in ent.features:
> +            if feat.is_special():
> +                # We don't expect special features to have an ifcond property.
> +                # (Hello, intrepid developer in the future who changed that!)
> +                # ((With luck, you are not me.))
> +                assert not feat.ifcond.is_present()

Nope :)

The attempt to add a conditional special feature now fails with

    Sphinx parallel build error:
    AssertionError

If you want to outlaw conditional special features, reject them cleanly
in schema.py, document the restriction in docs/devel/qapi-code-gen.rst,
and explain why in the commit message.  Recommend a separate commit, to
make it stand out in git-log.

> +                # Generated from entity def; info location is approximate.
> +                self.add_line(f":{feat.name}:", feat.info)
> +
> +        self.ensure_blank_line()
> +
>      # Transmogrification core methods
>  
>      def visit_module(self, path: str) -> None:


