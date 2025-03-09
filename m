Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BECC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCA0-0003mD-Sw; Sun, 09 Mar 2025 04:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9q-0002x9-8l
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9o-0002S7-8z
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ekPYIeGl/BH+mwtaU9zE1BN8bqRKp122Ax/OIEDqBQ=;
 b=XSEHhmvgd0DYwcUrZYBx21L1YTZxCIdlFMbc9wnviEhj5HaChcRyYSSnbIPQeNo4tk9zBI
 sOzyZQHDPsr8fcO7ppp2GOaJ3lOZTyEpf2KZ4gWwJ8wo5nVqy0D+UkayWe00hV/u/jnycp
 LQsdeMXgwb1yZvSV5rpyDmDxQYh+na8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-SG8uBF33PfiSKJqUHg9B6A-1; Sun,
 09 Mar 2025 04:37:08 -0400
X-MC-Unique: SG8uBF33PfiSKJqUHg9B6A-1
X-Mimecast-MFC-AGG-ID: SG8uBF33PfiSKJqUHg9B6A_1741509427
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 044D01956083; Sun,  9 Mar 2025 08:37:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2C5019560AB; Sun,  9 Mar 2025 08:37:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 29/62] docs/qapi-domain: add XREF compatibility goop for
 Sphinx < 4.1
Date: Sun,  9 Mar 2025 04:35:16 -0400
Message-ID: <20250309083550.5155-30-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

Sphinx < 4.1 handles cross-references ... differently. Factor out and
isolate the compatibility goop we need to make cross references work
properly in old versions of Sphinx.

Yes, it's ugly. Yes, it works. No, I don't want to talk about
it.

Understand that this patch exists because of the overflowing love in my
heart.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py      | 136 +++++++++++++++++++++++++++++++++++--
 docs/sphinx/qapi_domain.py |  23 ++++---
 2 files changed, 144 insertions(+), 15 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 6bc698c5ada..f068d70388d 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -2,14 +2,31 @@
 Sphinx cross-version compatibility goop
 """
 
-from typing import Callable
+import re
+from typing import (
+    Any,
+    Callable,
+    Optional,
+    Type,
+)
 
+from docutils import nodes
 from docutils.nodes import Element, Node, Text
 
 import sphinx
-from sphinx import addnodes
-from sphinx.util import nodes
-from sphinx.util.docutils import SphinxDirective, switch_source_input
+from sphinx import addnodes, util
+from sphinx.environment import BuildEnvironment
+from sphinx.roles import XRefRole
+from sphinx.util import docfields
+from sphinx.util.docutils import (
+    ReferenceRole,
+    SphinxDirective,
+    switch_source_input,
+)
+from sphinx.util.typing import TextlikeNode
+
+
+MAKE_XREF_WORKAROUND = sphinx.version_info[:3] < (4, 1, 0)
 
 
 SpaceNode: Callable[[str], Node]
@@ -36,7 +53,7 @@ def nested_parse_with_titles(
     try:
         # Modern sphinx (6.2.0+) supports proper offsetting for
         # nested parse error context management
-        nodes.nested_parse_with_titles(
+        util.nodes.nested_parse_with_titles(
             directive.state,
             directive.content,
             content_node,
@@ -45,6 +62,113 @@ def nested_parse_with_titles(
     except TypeError:
         # No content_offset argument. Fall back to SSI method.
         with switch_source_input(directive.state, directive.content):
-            nodes.nested_parse_with_titles(
+            util.nodes.nested_parse_with_titles(
                 directive.state, directive.content, content_node
             )
+
+
+# ###########################################
+# xref compatibility hacks for Sphinx < 4.1 #
+# ###########################################
+
+# When we require >= Sphinx 4.1, the following function and the
+# subsequent 3 compatibility classes can be removed. Anywhere in
+# qapi_domain that uses one of these Compat* types can be switched to
+# using the garden-variety lib-provided classes with no trickery.
+
+
+def _compat_make_xref(  # pylint: disable=unused-argument
+    self: sphinx.util.docfields.Field,
+    rolename: str,
+    domain: str,
+    target: str,
+    innernode: Type[TextlikeNode] = addnodes.literal_emphasis,
+    contnode: Optional[Node] = None,
+    env: Optional[BuildEnvironment] = None,
+    inliner: Any = None,
+    location: Any = None,
+) -> Node:
+    """
+    Compatibility workaround for Sphinx versions prior to 4.1.0.
+
+    Older sphinx versions do not use the domain's XRefRole for parsing
+    and formatting cross-references, so we need to perform this magick
+    ourselves to avoid needing to write the parser/formatter in two
+    separate places.
+
+    This workaround isn't brick-for-brick compatible with modern Sphinx
+    versions, because we do not have access to the parent directive's
+    state during this parsing like we do in more modern versions.
+
+    It's no worse than what pre-Sphinx 4.1.0 does, so... oh well!
+    """
+
+    # Yes, this function is gross. Pre-4.1 support is a miracle.
+    # pylint: disable=too-many-locals
+
+    assert env
+    # Note: Sphinx's own code ignores the type warning here, too.
+    if not rolename:
+        return contnode or innernode(target, target)  # type: ignore[call-arg]
+
+    # Get the role instance, but don't *execute it* - we lack the
+    # correct state to do so. Instead, we'll just use its public
+    # methods to do our reference formatting, and emulate the rest.
+    role = env.get_domain(domain).roles[rolename]
+    assert isinstance(role, XRefRole)
+
+    # XRefRole features not supported by this compatibility shim;
+    # these were not supported in Sphinx 3.x either, so nothing of
+    # value is really lost.
+    assert not target.startswith("!")
+    assert not re.match(ReferenceRole.explicit_title_re, target)
+    assert not role.lowercase
+    assert not role.fix_parens
+
+    # Code below based mostly on sphinx.roles.XRefRole; run() and
+    # create_xref_node()
+    options = {
+        "refdoc": env.docname,
+        "refdomain": domain,
+        "reftype": rolename,
+        "refexplicit": False,
+        "refwarn": role.warn_dangling,
+    }
+    refnode = role.nodeclass(target, **options)
+    title, target = role.process_link(env, refnode, False, target, target)
+    refnode["reftarget"] = target
+    classes = ["xref", domain, f"{domain}-{rolename}"]
+    refnode += role.innernodeclass(target, title, classes=classes)
+
+    # This is the very gross part of the hack. Normally,
+    # result_nodes takes a document object to which we would pass
+    # self.inliner.document. Prior to Sphinx 4.1, we don't *have* an
+    # inliner to pass, so we have nothing to pass here. However, the
+    # actual implementation of role.result_nodes in this case
+    # doesn't actually use that argument, so this winds up being
+    # ... fine. Rest easy at night knowing this code only runs under
+    # old versions of Sphinx, so at least it won't change in the
+    # future on us and lead to surprising new failures.
+    # Gross, I know.
+    result_nodes, _messages = role.result_nodes(
+        None,  # type: ignore
+        env,
+        refnode,
+        is_ref=True,
+    )
+    return nodes.inline(target, "", *result_nodes)
+
+
+class CompatField(docfields.Field):
+    if MAKE_XREF_WORKAROUND:
+        make_xref = _compat_make_xref
+
+
+class CompatGroupedField(docfields.GroupedField):
+    if MAKE_XREF_WORKAROUND:
+        make_xref = _compat_make_xref
+
+
+class CompatTypedField(docfields.TypedField):
+    if MAKE_XREF_WORKAROUND:
+        make_xref = _compat_make_xref
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 4f4bf328cc7..2649fa8c1db 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -24,7 +24,13 @@
 from docutils import nodes
 from docutils.parsers.rst import directives
 
-from compat import KeywordNode, SpaceNode
+from compat import (
+    CompatField,
+    CompatGroupedField,
+    CompatTypedField,
+    KeywordNode,
+    SpaceNode,
+)
 from sphinx import addnodes
 from sphinx.addnodes import desc_signature, pending_xref
 from sphinx.directives import ObjectDescription
@@ -37,7 +43,6 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
-from sphinx.util.docfields import Field, GroupedField, TypedField
 from sphinx.util.nodes import make_id, make_refnode
 
 
@@ -228,7 +233,7 @@ class QAPIObject(QAPIDescription):
 
     doc_field_types = [
         # :feat name: descr
-        GroupedField(
+        CompatGroupedField(
             "feature",
             label=_("Features"),
             names=("feat",),
@@ -429,7 +434,7 @@ class QAPICommand(QAPIObject):
     doc_field_types.extend(
         [
             # :arg TypeName ArgName: descr
-            TypedField(
+            CompatTypedField(
                 "argument",
                 label=_("Arguments"),
                 names=("arg",),
@@ -437,14 +442,14 @@ class QAPICommand(QAPIObject):
                 can_collapse=False,
             ),
             # :error: descr
-            Field(
+            CompatField(
                 "error",
                 label=_("Errors"),
                 names=("error", "errors"),
                 has_arg=False,
             ),
             # :returns TypeName: descr
-            GroupedField(
+            CompatGroupedField(
                 "returnvalue",
                 label=_("Return"),
                 rolename="type",
@@ -462,7 +467,7 @@ class QAPIEnum(QAPIObject):
     doc_field_types.extend(
         [
             # :value name: descr
-            GroupedField(
+            CompatGroupedField(
                 "value",
                 label=_("Values"),
                 names=("value",),
@@ -479,7 +484,7 @@ class QAPIAlternate(QAPIObject):
     doc_field_types.extend(
         [
             # :alt type name: descr
-            TypedField(
+            CompatTypedField(
                 "alternative",
                 label=_("Alternatives"),
                 names=("alt",),
@@ -497,7 +502,7 @@ class QAPIObjectWithMembers(QAPIObject):
     doc_field_types.extend(
         [
             # :member type name: descr
-            TypedField(
+            CompatTypedField(
                 "member",
                 label=_("Members"),
                 names=("memb",),
-- 
2.48.1


