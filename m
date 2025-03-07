Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13733C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqRh2-0000Ym-FB; Fri, 07 Mar 2025 02:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqRgd-0000U0-PE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:00:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqRgc-00012g-7A
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 01:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741330796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YNFZqopnojGpZWlRMCrrvlTlBRW7WQ7D1D85arhJb+4=;
 b=WgPWNf215FuDPYImiveOUEoF0P/kaJ1zBJ1wDBLueKbt+NuCcIqZsxYH9ycNeLCfknmODO
 y+XEUHaqqO/b/jsojnOqx+UciF4ZY36jOE4mRvnqkfFyTuZxQKMz1nvUzjUvHKIUcOj6oM
 tGypgHqQQp8dlOG6SalAx8umGq/eZTo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-pnsGgYQ7NsORaIFmkGCQlw-1; Fri,
 07 Mar 2025 01:59:50 -0500
X-MC-Unique: pnsGgYQ7NsORaIFmkGCQlw-1
X-Mimecast-MFC-AGG-ID: pnsGgYQ7NsORaIFmkGCQlw_1741330789
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52F1A19560B0; Fri,  7 Mar 2025 06:59:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8C011801748; Fri,  7 Mar 2025 06:59:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41C0E21E675E; Fri, 07 Mar 2025 07:59:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 12/57] docs/qapi-domain: add :since: directive option
In-Reply-To: <20250305034610.960147-13-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:21 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-13-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 07:59:46 +0100
Message-ID: <878qphs4v1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> Add a little special markup for registering "Since:" information. Adding
> it as an option instead of generic content lets us hoist the information
> into the Signature bar, optionally put it in the index, etc.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapi_domain.py | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index 6168c23936f..9919dacd4e6 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -4,6 +4,7 @@
>  
>  from __future__ import annotations
>  
> +import re
>  from typing import (
>      TYPE_CHECKING,
>      AbstractSet,
> @@ -104,6 +105,18 @@ def process_link(
>          return title, target
>  
>  
> +def since_validator(param: str) -> str:
> +    """
> +    Validate the `:since: X.Y` option field.
> +    """
> +    match = re.match(r"[0-9]+\.[0-9]+", param)

This accepts arbitrary crap after the version.  Example:
"9.2.50v9.2.0-2253-ge8a0110293" is fine.  Intentional?

> +    if not match:
> +        raise ValueError(
> +            f":since: requires a version number in X.Y format; not {param!r}"
> +        )
> +    return param

Schema validation is the frontend's job.  Ideally, a backend doesn't
report any errors.  The backends generating C don't.  A backend
generating docs has to: all the reST processing happens there, and
therefore reST errors can only be diagnosed there.  Since "no errors"
purity is impossible for this backend, we can be pragmatic about sinning
a bit more.

Still, I think this one should rather go into the doc comment parser.

This is not a demand.  We can always clean it up later.

> +
> +
>  # Alias for the return of handle_signature(), which is used in several places.
>  # (In the Python domain, this is Tuple[str, str] instead.)
>  Signature = str
> @@ -124,6 +137,8 @@ class QAPIObject(ObjectDescription[Signature]):
>          {
>              # Borrowed from the Python domain:
>              "module": directives.unchanged,  # Override contextual module name
> +            # These are QAPI originals:
> +            "since": since_validator,
>          }
>      )
>  
> @@ -135,9 +150,19 @@ def get_signature_prefix(self) -> List[nodes.Node]:
>              SpaceNode(" "),
>          ]
>  
> -    def get_signature_suffix(self) -> list[nodes.Node]:
> +    def get_signature_suffix(self) -> List[nodes.Node]:
>          """Returns a suffix to put after the object name in the signature."""
> -        return []
> +        ret: List[nodes.Node] = []
> +
> +        if "since" in self.options:
> +            ret += [
> +                SpaceNode(" "),
> +                addnodes.desc_sig_element(
> +                    "", f"(Since: {self.options['since']})"
> +                ),
> +            ]
> +
> +        return ret
>  
>      def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
>          """


