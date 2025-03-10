Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F69C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZiS-0001wc-H7; Mon, 10 Mar 2025 05:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trZiA-0001vr-C4
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trZi8-00028R-1D
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741599971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVNCI35jGo9JgsCnsZItdklgQgoFO+Ck2ShjqTB0P+M=;
 b=OnoCena9MsACtpvUe3wP4o1BC2sQkyXQ9Lqqq7d48ZUWJ7ZFG1zGg0IyKxHZTO02x/vD/P
 MpvS4uaPkTAx+Ys6qf/XX0Ov1Q0dylNwajnWWd05w0bI4gRjWhB0tnBeU+D8oZMykeknGM
 ZH2a7gRKEAjP716J7+EChh8iX80gPE8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-bRJPM4WjN-WvQF4rpxiNEA-1; Mon,
 10 Mar 2025 05:46:08 -0400
X-MC-Unique: bRJPM4WjN-WvQF4rpxiNEA-1
X-Mimecast-MFC-AGG-ID: bRJPM4WjN-WvQF4rpxiNEA_1741599967
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B9F419560B3; Mon, 10 Mar 2025 09:46:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D52C01956094; Mon, 10 Mar 2025 09:46:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9491021E66C1; Mon, 10 Mar 2025 10:46:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Alex =?utf-8?Q?Ben?=
 =?utf-8?Q?n=C3=A9e?=
 <alex.bennee@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 12/62] docs/qapi-domain: add QAPIObject class
In-Reply-To: <20250309083550.5155-13-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:34:59 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-13-jsnow@redhat.com>
Date: Mon, 10 Mar 2025 10:46:04 +0100
Message-ID: <874j01gqw3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapi_domain.py | 95 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> index a445150ae59..183d9a2766f 100644
> --- a/docs/sphinx/qapi_domain.py
> +++ b/docs/sphinx/qapi_domain.py
> @@ -18,7 +18,9 @@
>  )
>  
>  from docutils import nodes
> +from docutils.parsers.rst import directives
>  
> +from compat import KeywordNode, SpaceNode
>  from sphinx import addnodes
>  from sphinx.addnodes import desc_signature, pending_xref
>  from sphinx.directives import ObjectDescription
> @@ -40,6 +42,7 @@
>      from sphinx.application import Sphinx
>      from sphinx.builders import Builder
>      from sphinx.environment import BuildEnvironment
> +    from sphinx.util.typing import OptionSpec
>  
>  logger = logging.getLogger(__name__)
>  
> @@ -99,6 +102,8 @@ def process_link(
>          return title, target
>  
>  
> +# Alias for the return of handle_signature(), which is used in several places.
> +# (In the Python domain, this is Tuple[str, str] instead.)
>  Signature = str
>  
>  
> @@ -158,6 +163,96 @@ def add_target_and_index(
>                  )
>  
>  
> +class QAPIObject(QAPIDescription):
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
> +            "module": directives.unchanged,  # Override contextual module name
> +        }
> +    )
> +
> +    def get_signature_prefix(self) -> List[nodes.Node]:
> +        """Returns a prefix to put before the object name in the signature."""

Recommend imperative mood: Return a prefix

> +        assert self.objtype
> +        return [
> +            KeywordNode("", self.objtype.title()),
> +            SpaceNode(" "),
> +        ]
> +
> +    def get_signature_suffix(self) -> List[nodes.Node]:
> +        """Returns a suffix to put after the object name in the signature."""

Likewise.

> +        return []
> +
> +    def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
> +        """
> +        Transform a QAPI definition name into RST nodes.

Like you do here.

> +
> +        This method was originally intended for handling function
> +        signatures. In the QAPI domain, however, we only pass the
> +        definition name as the directive argument and handle everything
> +        else in the content body with field lists.
> +
> +        As such, the only argument here is "sig", which is just the QAPI
> +        definition name.
> +        """
> +        modname = self.options.get(
> +            "module", self.env.ref_context.get("qapi:module")
> +        )
> +
> +        signode["fullname"] = sig
> +        signode["module"] = modname
> +        sig_prefix = self.get_signature_prefix()
> +        if sig_prefix:
> +            signode += addnodes.desc_annotation(
> +                str(sig_prefix), "", *sig_prefix
> +            )
> +        signode += addnodes.desc_name(sig, sig)
> +        signode += self.get_signature_suffix()
> +
> +        return sig
> +
> +    def _object_hierarchy_parts(
> +        self, sig_node: desc_signature
> +    ) -> Tuple[str, ...]:
> +        if "fullname" not in sig_node:
> +            return ()
> +        modname = sig_node.get("module")
> +        fullname = sig_node["fullname"]
> +
> +        if modname:
> +            return (modname, *fullname.split("."))
> +
> +        return tuple(fullname.split("."))
> +
> +    def _toc_entry_name(self, sig_node: desc_signature) -> str:
> +        # This controls the name in the TOC and on the sidebar.
> +
> +        # This is the return type of _object_hierarchy_parts().
> +        toc_parts = cast(Tuple[str, ...], sig_node.get("_toc_parts", ()))
> +        if not toc_parts:
> +            return ""
> +
> +        config = self.env.app.config
> +        *parents, name = toc_parts
> +        if config.toc_object_entries_show_parents == "domain":
> +            return sig_node.get("fullname", name)
> +        if config.toc_object_entries_show_parents == "hide":
> +            return name
> +        if config.toc_object_entries_show_parents == "all":
> +            return ".".join(parents + [name])
> +        return ""
> +
> +
>  class QAPIModule(QAPIDescription):
>      """
>      Directive to mark description of a new module.


