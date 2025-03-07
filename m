Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29356C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 06:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqRHX-0002Ed-Td; Fri, 07 Mar 2025 01:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqRHW-0002ER-M5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 01:34:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqRHU-0006AE-V6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 01:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741329239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syfad5OqPcErHx6LK0OpRAZNhvk5+kf3vsfEoJ8IAO4=;
 b=WRwXHDV8ySU5VLYGfWskuFQ0vgaTSaPRYbg5ffbABMNLFWGGKacSqpx4uPffJlOdYtBXwE
 lPLkqBlA/wAW2Um3O4Uad46HSh9rFoox3zf+F2lngHrRj9qAkul3dKa8FCLj4xRSmIK964
 +2/Ts2hXf+ZDoYMuc7MTO4/b0ZlrmHc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-1EEJhJPyP8SHxuhfzSf6fA-1; Fri,
 07 Mar 2025 01:33:56 -0500
X-MC-Unique: 1EEJhJPyP8SHxuhfzSf6fA-1
X-Mimecast-MFC-AGG-ID: 1EEJhJPyP8SHxuhfzSf6fA_1741329234
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF857180AF4D; Fri,  7 Mar 2025 06:33:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B3BE300019E; Fri,  7 Mar 2025 06:33:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D794E21E675F; Fri, 07 Mar 2025 07:33:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 11/57] docs/qapi-domain: add qapi:command directive
In-Reply-To: <20250305034610.960147-12-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:20 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-12-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 07:33:50 +0100
Message-ID: <87ikols629.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> This commit adds a stubbed version of QAPICommand that utilizes the
> QAPIObject class, the qapi:command directive, the :qapi:cmd:
> cross-reference role, and the "command" object type in the QAPI object
> registry.
>
> This commit also adds the aforementioned generic QAPIObject class for
> use in documenting various QAPI entities in the Sphinx ecosystem.
>
> They don't do anything *particularly* interesting yet, but that will
> come in forthcoming commits.
>
> Note: some versions of mypy get a little confused over the difference
> between class and instance variables; because sphinx's ObjectDescription
> does not declare option_spec as a ClassVar (even though it's obvious
> that it is), mypy may produce this error:
>
> qapi-domain.py:125: error: Cannot override instance variable (previously
> declared on base class "ObjectDescription") with class variable [misc]
>
> I can't control that; so silence the error with a pragma.

Is this still accurate?  qapi-domain.py line 125 is a comment.  I can't
see the pragma.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapi_domain.py | 146 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 144 insertions(+), 2 deletions(-)
>
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index 104bae709f3..6168c23936f 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -21,9 +21,10 @@
>  from docutils import nodes
>  from docutils.parsers.rst import directives
>  
> -from compat import nested_parse
> +from compat import KeywordNode, SpaceNode, nested_parse
>  from sphinx import addnodes
> -from sphinx.addnodes import pending_xref
> +from sphinx.addnodes import desc_signature, pending_xref
> +from sphinx.directives import ObjectDescription
>  from sphinx.domains import (
>      Domain,
>      Index,
> @@ -103,6 +104,144 @@ def process_link(
>          return title, target
>  
>  
> +# Alias for the return of handle_signature(), which is used in several places.
> +# (In the Python domain, this is Tuple[str, str] instead.)
> +Signature = str
> +
> +
> +class QAPIObject(ObjectDescription[Signature]):
> +    """
> +    Description of a generic QAPI object.
> +
> +    It's not used directly, but is instead subclassed by specific directives.
> +    """
> +
> +    # Inherit some standard options from Sphinx's ObjectDescription
> +    option_spec: OptionSpec = (  # type:ignore[misc]
> +        ObjectDescription.option_spec.copy()
> +    )
> +    option_spec.update(
> +        {
> +            # Borrowed from the Python domain:

This is line 125 mentioned above.

> +            "module": directives.unchanged,  # Override contextual module name
> +        }
> +    )

[...]


