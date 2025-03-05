Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE69C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkoc-0002L6-1p; Wed, 05 Mar 2025 04:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpkoY-0002K7-Jq
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:13:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpkoU-0007g4-Pf
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741165993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJbV+oDP4a8B7KNzhwyLxIKNJLDkjmmAU1BXduoVLuU=;
 b=iUewmiaXCrsflvawy0McHCQZTAk6pUr6QbAuROu3rJVZaG3XjqZjAb1Uq8D5Jhzb1hOg+F
 74qheLKNOuO+TVqfFNW9zm2EyCDXisFwxfUwHchaB4G43zsqqgCMKhFqCapcktCX4SRpL3
 xU9ifMFcWoC6K9u2C1HVefDJdhoNWOY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-XnpOqfPAM9STLQuRjf4cNg-1; Wed,
 05 Mar 2025 04:13:08 -0500
X-MC-Unique: XnpOqfPAM9STLQuRjf4cNg-1
X-Mimecast-MFC-AGG-ID: XnpOqfPAM9STLQuRjf4cNg_1741165987
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CFBA1955D80; Wed,  5 Mar 2025 09:13:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E0B418001E9; Wed,  5 Mar 2025 09:13:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB68321E66C2; Wed, 05 Mar 2025 10:13:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Harmonie Snow <harmonie@gmail.com>
Subject: Re: [PATCH 21/57] docs/qapi-domain: add :deprecated: directive option
In-Reply-To: <20250305034610.960147-22-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:30 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-22-jsnow@redhat.com>
Date: Wed, 05 Mar 2025 10:13:03 +0100
Message-ID: <87v7snon6o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 127.0.0.2
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

> Although "deprecated" is a feature (and *will* appear in the features
> list), add a special :deprecated: option to generate an eye-catch that
> makes this information very hard to miss.
>
> (The intent is to modify qapidoc.py to add this option whenever it
> detects that the features list attached to a definition contains the
> "deprecated" entry.)
>
> -
>
> RFC: Technically, this object-level option is un-needed and could be
> replaced with a standard content-level directive that e.g. qapidoc.py
> could insert at the beginning of the content block. I've done it here as
> an option to demonstrate how it would be possible to do.
>
> It's a matter of taste for "where" we feel like implementing it.
>
> One benefit of doing it this way is that we can create a single
> containing box to set CSS style options controlling the flow of multiple
> infoboxes. The other way to achieve that would be to create a directive
> that allows us to set multiple options instead, e.g.:
>
> .. qapi:infoboxes:: deprecated unstable
>
> or possibly:
>
> .. qapi:infoboxes::
>    :deprecated:
>    :unstable:
>
> For now, I've left these as top-level QAPI object options. "Hey, it works."
>
> P.S., I outsourced the CSS ;)
>
> Signed-off-by: Harmonie Snow <harmonie@gmail.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index fff5cca24cc..1be59e36bdf 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -140,6 +140,7 @@ class QAPIObject(ObjectDescription[Signature]):
>              "module": directives.unchanged,  # Override contextual module name
>              # These are QAPI originals:
>              "since": since_validator,
> +            "deprecated": directives.flag,
>          }
>      )
>  
> @@ -253,6 +254,31 @@ def add_target_and_index(
>                      ("single", indextext, node_id, "", None)
>                  )
>  
> +    def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
> +        # Add various eye-catches and things that go below the signature
> +        # bar, but precede the user-defined content.
> +        infopips = nodes.container()
> +        infopips.attributes["classes"].append("qapi-infopips")
> +
> +        def _add_pip(source: str, content: str, classname: str) -> None:
> +            node = nodes.container(source)
> +            node.append(nodes.Text(content))
> +            node.attributes["classes"].extend(["qapi-infopip", classname])
> +            infopips.append(node)
> +
> +        if "deprecated" in self.options:
> +            _add_pip(
> +                ":deprecated:",
> +                f"This {self.objtype} is deprecated.",
> +                "qapi-deprecated",
> +            )
> +
> +        if infopips.children:
> +            contentnode.insert(0, infopips)
> +
> +    def transform_content(self, content_node: addnodes.desc_content) -> None:

pylint warns:

    docs/sphinx/qapi_domain.py:279:4: W0237: Parameter 'contentnode' has been renamed to 'content_node' in overriding 'QAPIObject.transform_content' method (arguments-renamed)

For what it's worth, @content_node is easier on on my eyes than
@contentnode.

> +        self._add_infopips(content_node)
> +
>      def _toc_entry_name(self, sig_node: desc_signature) -> str:
>          # This controls the name in the TOC and on the sidebar.


