Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D048EC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZEL-00053N-AR; Mon, 10 Mar 2025 05:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trZEB-000538-Tj
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trZE9-0005SW-W7
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741598111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y0a5BkC4oDiKT+w+LCs5WR6HYRnWmgtrDZOaCHmX/mw=;
 b=AMv/lqZr8qbIg/6aqVBOtqTQC/eYPmZtynkgqk+bFiyzwyClvvRn4I30yVXfNs30IzGLSq
 ud8z1Z2xL79QdxCaZglAJDEGO+rKKuLJxQ6KEzk3QW37ErURVufrBb0oOgtft31c8B9Q3t
 AaaOSHKC6+XNrCnOtT3OTHyy2WSQaSM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-4MCYVW6HNPa6Vijg9CjzmQ-1; Mon,
 10 Mar 2025 05:15:08 -0400
X-MC-Unique: 4MCYVW6HNPa6Vijg9CjzmQ-1
X-Mimecast-MFC-AGG-ID: 4MCYVW6HNPa6Vijg9CjzmQ_1741598107
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7117319560AF; Mon, 10 Mar 2025 09:15:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D42F19560AD; Mon, 10 Mar 2025 09:15:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB59021E66C4; Mon, 10 Mar 2025 10:15:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 10/62] docs/qapi-domain: Add ObjectDescription
 abstract class
In-Reply-To: <20250309083550.5155-11-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:34:57 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-11-jsnow@redhat.com>
Date: Mon, 10 Mar 2025 10:15:04 +0100
Message-ID: <87jz8xtffr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> This class is a generic, top-level directive for documenting some kind
> of QAPI thingamajig that we expect to go into the Index. This class
> doesn't do much by itself, and it isn't yet associated with any
> particular directive.
>
> Only handle_signature() is defined in the base class; get_index_text and
> add_target_and_index are new methods defined here; they are based
> heavily on the layout and format of the Python domain's general object
> class.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapi_domain.py | 65 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index 49d42c0921c..0365891f354 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -14,11 +14,13 @@
>      NamedTuple,
>      Optional,
>      Tuple,
> +    cast,
>  )
>  
>  from docutils import nodes
>  
> -from sphinx.addnodes import pending_xref
> +from sphinx.addnodes import desc_signature, pending_xref
> +from sphinx.directives import ObjectDescription
>  from sphinx.domains import (
>      Domain,
>      Index,
> @@ -28,7 +30,7 @@
>  from sphinx.locale import _, __
>  from sphinx.roles import XRefRole
>  from sphinx.util import logging
> -from sphinx.util.nodes import make_refnode
> +from sphinx.util.nodes import make_id, make_refnode
>  
>  
>  if TYPE_CHECKING:
> @@ -96,6 +98,65 @@ def process_link(
>          return title, target
>  
>  
> +Signature = str
> +
> +
> +class QAPIDescription(ObjectDescription[Signature]):
> +    """
> +    Generic QAPI description.
> +
> +    Abstract class, not instantiated directly.
> +    """
> +
> +    def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
> +        # Do nothing. The return value here is the "name" of the entity
> +        # being documented; for QAPI, this is the same as the
> +        # "signature", which is just a name.
> +
> +        # Normally this method must also populate signode with nodes to
> +        # render the signature; here we do nothing instead.
> +        return sig
> +
> +    def get_index_text(self, name: Signature) -> Tuple[str, str]:
> +        """Return the text for the index entry of the object."""
> +
> +        # NB: this is used for the global index, not the QAPI index.
> +        return ("single", f"{name} (QMP {self.objtype})")
> +
> +    def add_target_and_index(
> +        self, name: Signature, sig: str, signode: desc_signature
> +    ) -> None:
> +        # name is the return value of handle_signature.
> +        # sig is the original, raw text argument to handle_signature.
> +        # For QAPI, these are identical, currently.
> +
> +        assert self.objtype
> +
> +        # If we're documenting a module, don't include the module as
> +        # part of the FQN.
> +        modname = ""
> +        if self.objtype != "module":
> +            modname = self.options.get(
> +                "module", self.env.ref_context.get("qapi:module")
> +            )
> +        fullname = (modname + "." if modname else "") + name
> +
> +        node_id = make_id(self.env, self.state.document, self.objtype, fullname)

pycodestyle-3 points out:

    docs/sphinx/qapi_domain.py:144:80: E501 line too long (80 > 79 characters)

> +        signode["ids"].append(node_id)
> +
> +        self.state.document.note_explicit_target(signode)
> +        domain = cast(QAPIDomain, self.env.get_domain("qapi"))
> +        domain.note_object(fullname, self.objtype, node_id, location=signode)

This one's pushing it, too :)

> +
> +        if "no-index-entry" not in self.options:
> +            arity, indextext = self.get_index_text(name)
> +            assert self.indexnode is not None
> +            if indextext:
> +                self.indexnode["entries"].append(
> +                    (arity, indextext, node_id, "", None)
> +                )
> +
> +
>  class QAPIIndex(Index):
>      """
>      Index subclass to provide the QAPI definition index.


