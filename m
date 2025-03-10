Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215F0C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZjw-0002jN-4X; Mon, 10 Mar 2025 05:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trZjc-0002Tl-Iy
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trZjW-0002MY-P0
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741600058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwJGeg/VZuj4wMebVbdBwYDmSV6M/Wh5vBe3F0g4Oew=;
 b=QRt8w8jEjhzsho4yZmhzoPxav0P6t0uVr1JTPKuOyeXfEs4PmLQvkHlGDprbGooR/0TVpj
 6IIxNpLQIWvBcQENgPw/Wrh2Uui+poGwNZx4B/A2Sb8E2VSPDaOF8AdFQ8zIOkJk8h3ImT
 7uqh3SmCx3saADcbNwB8RGRM0Xgh3Ys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-wjR1AUdYP9KKchPsWX0dbA-1; Mon,
 10 Mar 2025 05:47:32 -0400
X-MC-Unique: wjR1AUdYP9KKchPsWX0dbA-1
X-Mimecast-MFC-AGG-ID: wjR1AUdYP9KKchPsWX0dbA_1741600051
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04677180025E; Mon, 10 Mar 2025 09:47:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B680F1800373; Mon, 10 Mar 2025 09:47:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 76D4D21E66C4; Mon, 10 Mar 2025 10:47:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 11/62] docs/qapi-domain: add qapi:module directive
In-Reply-To: <20250309083550.5155-12-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:34:58 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-12-jsnow@redhat.com>
Date: Mon, 10 Mar 2025 10:47:28 +0100
Message-ID: <87zfhtfc9b.fsf@pond.sub.org>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> This adds the qapi:module directive, which just notes the current module
> being documented and performs a nested parse of the content block, if
> present.
>
> This code is based pretty heavily on Sphinx's PyModule directive, but
> with unnecessary features excised.
>
> For example:
>
> .. qapi:module:: block-core
>
>    Hello, and welcome to block-core!
>    =================================
>
>    lorem ipsum, dolor sit amet ...
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapi_domain.py | 71 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 6 deletions(-)
>
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index 0365891f354..a445150ae59 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -19,6 +19,7 @@
>  
>  from docutils import nodes
>  
> +from sphinx import addnodes
>  from sphinx.addnodes import desc_signature, pending_xref
>  from sphinx.directives import ObjectDescription
>  from sphinx.domains import (
> @@ -34,7 +35,7 @@
>  
>  
>  if TYPE_CHECKING:
> -    from docutils.nodes import Element
> +    from docutils.nodes import Element, Node
>  
>      from sphinx.application import Sphinx
>      from sphinx.builders import Builder
> @@ -157,6 +158,60 @@ def add_target_and_index(
>                  )
>  
>  
> +class QAPIModule(QAPIDescription):
> +    """
> +    Directive to mark description of a new module.
> +
> +    This directive doesn't generate any special formatting, and is just
> +    a pass-through for the content body. Named section titles are
> +    allowed in the content body.
> +
> +    Use this directive to create entries for the QAPI module in the
> +    global index and the qapi index; as well as to associate subsequent

QAPI unless there's a reason for lower case.

> +    definitions with the module they are defined in for purposes of
> +    search and QAPI index organization.
> +
> +    :arg: The name of the module.
> +    :opt no-index: Don't add cross-reference targets or index entries.
> +    :opt no-typesetting: Don't render the content body (but preserve any
> +       cross-reference target IDs in the squelched output.)
> +
> +    Example::
> +
> +       .. qapi:module:: block-core
> +          :no-index:
> +          :no-typesetting:
> +
> +          Lorem ipsum, dolor sit amet ...
> +    """

[...]


