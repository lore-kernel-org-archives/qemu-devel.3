Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36ABC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1F-0007Se-IW; Fri, 19 Apr 2024 00:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1A-0007P2-9P
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg17-00049g-UF
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbx+fvhdbNSPrwljvaeH4rMdFjLjZX/GTuVJYLukLjo=;
 b=Ln8/pfuDGf/OgaCglUjAVuSwhWF9DZQbbyt8MjZH1p3V+P4mo5rl2vi26hpmZIEhxyN93i
 9YCbvqAWlibTkAKWGm1j5KvTWzO9usH4BdR1O2jwOAn1CAnAb5AsXDJg4nw2di0vKrS8KD
 HSw7WSWbNc94s3ChLU7x3RYEvM8w/nc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-FLHQZqTUPCie_RCVCD2E4g-1; Fri, 19 Apr 2024 00:38:26 -0400
X-MC-Unique: FLHQZqTUPCie_RCVCD2E4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ABD9811001;
 Fri, 19 Apr 2024 04:38:26 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69CA140C1233;
 Fri, 19 Apr 2024 04:38:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 06/27] docs/qapi-domain: add QAPI xref roles
Date: Fri, 19 Apr 2024 00:37:54 -0400
Message-ID: <20240419043820.178731-7-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add domain-specific cross-reference syntax. As of this commit, that
means new :qapi:mod:`block-core` and :qapi:obj:`block-core` referencing
syntax.

:mod: will only find modules, but :obj: will find anything registered to
the QAPI domain. (In forthcoming commits, this means commands, events,
enums, etc.)

Creating the cross-references is powered by the QAPIXRefRole class;
resolving them is handled by QAPIDomain.resolve_xref().

QAPIXrefRole is copied almost verbatim from Sphinx's own
PyXrefRole. PyXrefRole (and QAPIXrefRole) adds two features over the
base class:

(1) Creating a cross-reference with e.g. :py:class:`~class.name`
instructs sphinx to omit the fully qualified parts of the resolved name
from the actual link text. This may be useful in the future if we add
namespaces to QAPI documentation, e.g. :qapi:cmd:`~qsd.blockdev-backup`
could link to the QSD-specific documentation for blockdev-backup while
omitting that prefix from the link text.

(2) Prefixing the link target with a "." changes the search behavior to
prefer locally-scoped items first.

I think both of these are worth keeping to help manage future namespace
issues between QEMU, QSD and QGA; but it's possible it's extraneous. It
may possibly be worth keeping just to keep feature parity with Sphinx's
other domains; e.g. "principle of least surprise". Dunno.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        |  4 +++
 docs/sphinx/qapi-domain.py | 67 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 39ad405fd93..e2223d5f363 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -47,3 +47,7 @@ cross-referencing syntax. Here's a link to `bar-module`, even though
 the actual output of that directive was suppressed. Here's a link to
 `block-core`. A link to ```foo-module``` won't resolve because of the
 ``:no-index:`` option we used for that directive.
+
+Explicit cross-referencing syntax for QAPI modules is available with
+``:qapi:mod:`foo```, here's a link to :qapi:mod:`bar-module` and one to
+:qapi:mod:`block-core`.
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 4758451ff0e..d28ac1cb9d8 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -29,6 +29,7 @@
     ObjType,
 )
 from sphinx.locale import _, __
+from sphinx.roles import XRefRole
 from sphinx.util import logging
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import (
@@ -56,6 +57,34 @@ class ObjectEntry(NamedTuple):
     aliased: bool
 
 
+class QAPIXRefRole(XRefRole):
+    def process_link(
+        self,
+        env: BuildEnvironment,
+        refnode: Element,
+        has_explicit_title: bool,
+        title: str,
+        target: str,
+    ) -> tuple[str, str]:
+        refnode["qapi:module"] = env.ref_context.get("qapi:module")
+        if not has_explicit_title:
+            title = title.lstrip(".")  # only has a meaning for the target
+            target = target.lstrip("~")  # only has a meaning for the title
+            # if the first character is a tilde, don't display the module
+            # parts of the contents
+            if title[0:1] == "~":
+                title = title[1:]
+                dot = title.rfind(".")
+                if dot != -1:
+                    title = title[dot + 1 :]
+        # if the first character is a dot, search more specific namespaces first
+        # else search builtins first
+        if target[0:1] == ".":
+            target = target[1:]
+            refnode["refspecific"] = True
+        return title, target
+
+
 def _nested_parse(directive: SphinxDirective, content_node: Element) -> None:
     """
     This helper preserves error parsing context across sphinx versions.
@@ -234,7 +263,13 @@ class QAPIDomain(Domain):
         "module": QAPIModule,
     }
 
-    roles = {}
+    # These are all cross-reference roles; e.g.
+    # :qapi:cmd:`query-block`. The keys correlate to the names used in
+    # the object_types table values above.
+    roles = {
+        "mod": QAPIXRefRole(),
+        "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
+    }
 
     # Moved into the data property at runtime;
     # this is the internal index of reference-able objects.
@@ -363,6 +398,36 @@ def find_obj(
             matches = [m for m in matches if not m[1].aliased]
         return matches
 
+    def resolve_xref(
+        self,
+        env: BuildEnvironment,
+        fromdocname: str,
+        builder: Builder,
+        type: str,
+        target: str,
+        node: pending_xref,
+        contnode: Element,
+    ) -> Element | None:
+        modname = node.get("qapi:module")
+        matches = self.find_obj(modname, target, type)
+        multiple_matches = len(matches) > 1
+
+        if not matches:
+            return None
+        elif multiple_matches:
+            logger.warning(
+                __("more than one target found for cross-reference %r: %s"),
+                target,
+                ", ".join(match[0] for match in matches),
+                type="ref",
+                subtype="qapi",
+                location=node,
+            )
+        name, obj = matches[0]
+        return make_refnode(
+            builder, fromdocname, obj.docname, obj.node_id, contnode, name
+        )
+
     def resolve_any_xref(
         self,
         env: BuildEnvironment,
-- 
2.44.0


