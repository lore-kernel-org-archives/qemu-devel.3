Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECEAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuHd-00017z-Ue; Thu, 12 Dec 2024 20:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuH6-0000yW-SP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuH0-0000vv-29
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2uBLnCFk7cw9O+LvbpeL9YtAqyFV9HBoqcOf2eGrOU=;
 b=Qv/3W8XVMBQW5Wea2zIvnEcWa3qzcEa0c2h4N5a+sqDsI8+mohSoj8HPUcnKkZZ1C9GGbB
 vzR9wFd8eXq9HvhHsvY2vKZwZOj4eBftgMuaxchAOuwG6ECxJiJjZ0oHAkUCc47rRjq7+b
 HUryIpyMTOzYV48/k7ogdPAVeohfiz4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-0EitUavIPSe0ikg6VNw1Qw-1; Thu,
 12 Dec 2024 20:15:14 -0500
X-MC-Unique: 0EitUavIPSe0ikg6VNw1Qw-1
X-Mimecast-MFC-AGG-ID: 0EitUavIPSe0ikg6VNw1Qw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BA4F19560B3; Fri, 13 Dec 2024 01:15:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD2BF1956086; Fri, 13 Dec 2024 01:15:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 32/35] WIP: 3.x - XREF
Date: Thu, 12 Dec 2024 20:13:01 -0500
Message-ID: <20241213011307.2942030-33-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py      | 114 +++++++++++++++++++-
 docs/sphinx/qapi-domain.py | 207 ++++++++++++-------------------------
 2 files changed, 179 insertions(+), 142 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 28cb39161fe..657c05a81a4 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -2,14 +2,32 @@
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
 from sphinx import addnodes
-from sphinx.util.docutils import SphinxDirective, switch_source_input
+from sphinx.environment import BuildEnvironment
+from sphinx.roles import XRefRole
+from sphinx.util import docfields
+from sphinx.util.docutils import (
+    ReferenceRole,
+    SphinxDirective,
+    switch_source_input,
+)
 from sphinx.util.nodes import nested_parse_with_titles
+from sphinx.util.typing import TextlikeNode
+
+
+MAKE_XREF_WORKAROUND = sphinx.version_info[:3] < (4, 1, 0)
 
 
 space_node: Callable[[str], Node]
@@ -46,3 +64,95 @@ def nested_parse(directive: SphinxDirective, content_node: Element) -> None:
             nested_parse_with_titles(
                 directive.state, directive.content, content_node
             )
+
+
+class CompatFieldMixin:
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
+    def make_xref(
+        self,
+        rolename: str,
+        domain: str,
+        target: str,
+        innernode: Type[TextlikeNode] = addnodes.literal_emphasis,
+        contnode: Optional[Node] = None,
+        env: Optional[BuildEnvironment] = None,
+        *args: Any,
+        **kwargs: Any,
+    ) -> Node:
+        print("Using compat make_xref")
+
+        assert env
+        if not rolename:
+            return contnode or innernode(target, target)
+
+        # Get the role instance, but don't *execute it* - we lack the
+        # correct state to do so. Instead, we'll just use its public
+        # methods to do our reference formatting, and emulate the rest.
+        role = env.get_domain(domain).roles[rolename]
+        assert isinstance(role, XRefRole)
+
+        # XRefRole features not supported by this compatibility shim;
+        # these were not supported in Sphinx 3.x either, so nothing of
+        # value is really lost.
+        assert not target.startswith("!")
+        assert not re.match(ReferenceRole.explicit_title_re, target)
+        assert not role.lowercase
+        assert not role.fix_parens
+
+        # Code below based mostly on sphinx.roles.XRefRole; run() and
+        # create_xref_node()
+        options = {
+            "refdoc": env.docname,
+            "refdomain": domain,
+            "reftype": rolename,
+            "refexplicit": False,
+            "refwarn": role.warn_dangling,
+        }
+        refnode = role.nodeclass(target, **options)
+        title, target = role.process_link(env, refnode, False, target, target)
+        refnode["reftarget"] = target
+        classes = ["xref", domain, f"{domain}-{rolename}"]
+        refnode += role.innernodeclass(target, title, classes=classes)
+        result_nodes, messages = role.result_nodes(
+            None,  # FIXME - normally self.inliner.document ...
+            env,
+            refnode,
+            is_ref=True,
+        )
+        return nodes.inline(target, "", *result_nodes)
+
+
+class CompatField(CompatFieldMixin, docfields.Field):
+    pass
+
+
+class CompatGroupedField(CompatFieldMixin, docfields.GroupedField):
+    pass
+
+
+class CompatTypedField(CompatFieldMixin, docfields.TypedField):
+    pass
+
+
+if not MAKE_XREF_WORKAROUND:
+    Field = docfields.Field
+    GroupedField = docfields.GroupedField
+    TypedField = docfields.TypedField
+else:
+    Field = CompatField
+    GroupedField = CompatGroupedField
+    TypedField = CompatTypedField
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index ee9b1d056ff..ebdf9074391 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -24,7 +24,14 @@
 from docutils.statemachine import StringList
 
 from collapse import CollapseNode
-from compat import keyword_node, nested_parse, space_node
+from compat import (
+    Field,
+    GroupedField,
+    TypedField,
+    keyword_node,
+    nested_parse,
+    space_node,
+)
 import sphinx
 from sphinx import addnodes
 from sphinx.addnodes import desc_signature, pending_xref
@@ -38,24 +45,18 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
-from sphinx.util.docfields import (
-    DocFieldTransformer,
-    Field,
-    GroupedField,
-    TypedField,
-)
+from sphinx.util.docfields import DocFieldTransformer
 from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id, make_refnode
 
 
 if TYPE_CHECKING:
     from docutils.nodes import Element, Node
-    from docutils.parsers.rst.states import Inliner
 
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
     from sphinx.environment import BuildEnvironment
-    from sphinx.util.typing import OptionSpec, TextlikeNode
+    from sphinx.util.typing import OptionSpec
 
 logger = logging.getLogger(__name__)
 
@@ -82,111 +83,8 @@ class ObjectEntry(NamedTuple):
     aliased: bool
 
 
-class QAPIXrefMixin:
-    def make_xref(
-        self,
-        rolename: str,
-        domain: str,
-        target: str,
-        innernode: type[TextlikeNode] = nodes.literal,
-        contnode: Optional[Node] = None,
-        env: Optional[BuildEnvironment] = None,
-        inliner: Optional[Inliner] = None,
-        location: Optional[Node] = None,
-    ) -> Node:
-        # make_xref apparently has a mode of operation where the inliner
-        # class argument is passed to the role object
-        # (e.g. QAPIXRefRole) to construct the final result; passing
-        # inliner = location = None forces it into its legacy mode where
-        # it returns a pending_xref node instead.
-        # (This is how the built-in Python domain behaves.)
-        result = super().make_xref(  # type: ignore[misc]
-            rolename,
-            domain,
-            target,
-            innernode=innernode,
-            contnode=contnode,
-            env=env,
-            inliner=None,
-            location=None,
-        )
-        if isinstance(result, pending_xref):
-            assert env is not None
-            # Add domain-specific context information to the pending reference.
-            result["refspecific"] = True
-            result["qapi:module"] = env.ref_context.get("qapi:module")
-
-        assert isinstance(result, nodes.Node)
-        return result
-
-    def make_xrefs(
-        self,
-        rolename: str,
-        domain: str,
-        target: str,
-        innernode: type[TextlikeNode] = nodes.literal,
-        contnode: Optional[Node] = None,
-        env: Optional[BuildEnvironment] = None,
-        inliner: Optional[Inliner] = None,
-        location: Optional[Node] = None,
-    ) -> list[Node]:
-        # Note: this function is called on up to three fields of text:
-        # (1) The field name argument (e.g. member/arg name)
-        # (2) The field name type (e.g. member/arg type)
-        # (3) The field *body* text, for Fields that do not take arguments.
-
-        list_type = False
-        optional = False
-
-        # If the rolename is qapi:type, we know we are processing a type
-        # and not an arg/memb name or field body text.
-        if rolename == "type":
-            # force the innernode class to be a literal.
-            innernode = nodes.literal
-
-            # Type names that end with "?" are considered Optional
-            # arguments and should be documented as such, but it's not
-            # part of the xref itself.
-            if target.endswith("?"):
-                optional = True
-                target = target[:-1]
-
-            # Type names wrapped in brackets denote lists. strip the
-            # brackets and remember to add them back later.
-            if target.startswith("[") and target.endswith("]"):
-                list_type = True
-                target = target[1:-1]
-
-            # When processing Fields with bodyrolename="type", contnode
-            # will be present, which indicates that the body has already
-            # been parsed into nodes.  We don't want that, actually:
-            # we'll re-create our own nodes for it.
-            contnode = None
-
-        results = []
-        result = self.make_xref(
-            rolename,
-            domain,
-            target,
-            innernode,
-            contnode,
-            env,
-            inliner,
-            location,
-        )
-        results.append(result)
-
-        if list_type:
-            results.insert(0, nodes.literal("[", "["))
-            results.append(nodes.literal("]", "]"))
-        if optional:
-            results.append(nodes.Text(", "))
-            results.append(nodes.emphasis("?", "optional"))
-
-        return results
-
-
 class QAPIXRefRole(XRefRole):
+
     def process_link(
         self,
         env: BuildEnvironment,
@@ -196,34 +94,63 @@ def process_link(
         target: str,
     ) -> tuple[str, str]:
         refnode["qapi:module"] = env.ref_context.get("qapi:module")
-        if not has_explicit_title:
-            title = title.lstrip(".")  # only has a meaning for the target
-            target = target.lstrip("~")  # only has a meaning for the title
-            # if the first character is a tilde, don't display the module
-            # parts of the contents
-            if title[0:1] == "~":
-                title = title[1:]
-                dot = title.rfind(".")
-                if dot != -1:
-                    title = title[dot + 1 :]
-        # if the first character is a dot, search more specific namespaces first
-        # else search builtins first
-        if target[0:1] == ".":
+
+        # Cross-references that begin with a tilde adjust the title to
+        # only show the reference without a leading module, even if one
+        # was provided. This is a Sphinx-standard syntax; give it
+        # priority over QAPI-specific type markup below.
+        hide_module = False
+        if target.startswith("~"):
+            hide_module = True
             target = target[1:]
-            refnode["refspecific"] = True
+
+        # Type names that end with "?" are considered optional
+        # arguments and should be documented as such, but it's not
+        # part of the xref itself.
+        if target.endswith("?"):
+            refnode["qapi:optional"] = True
+            target = target[:-1]
+
+        # Type names wrapped in brackets denote lists. strip the
+        # brackets and remember to add them back later.
+        if target.startswith("[") and target.endswith("]"):
+            refnode["qapi:array"] = True
+            target = target[1:-1]
+
+        if has_explicit_title:
+            # Don't mess with the title at all if it was explicitly set.
+            # Explicit title syntax for references is e.g.
+            # :qapi:type:`target <explicit title>`
+            # and this explicit title overrides everything else here.
+            return title, target
+
+        title = target
+        if hide_module:
+            title = target.split(".")[-1]
+
         return title, target
 
+    def result_nodes(
+        self,
+        document: nodes.document,
+        env: BuildEnvironment,
+        node: Element,
+        is_ref: bool,
+    ) -> Tuple[List[nodes.Node], List[nodes.system_message]]:
 
-class QAPIGroupedField(QAPIXrefMixin, GroupedField):
-    pass
+        # node here is the pending_xref node (or whatever nodeclass was
+        # configured at XRefRole class instantiation time).
+        results: List[nodes.Node] = [node]
 
+        if node.get("qapi:array"):
+            results.insert(0, nodes.literal("[", "["))
+            results.append(nodes.literal("]", "]"))
 
-class QAPITypedField(QAPIXrefMixin, TypedField):
-    pass
+        if node.get("qapi:optional"):
+            results.append(nodes.Text(", "))
+            results.append(nodes.emphasis("?", "optional"))
 
-
-class QAPIField(QAPIXrefMixin, Field):
-    pass
+        return results, []
 
 
 def since_validator(param: str) -> str:
@@ -633,7 +560,7 @@ class QAPICommand(QAPIObject):
     doc_field_types.extend(
         [
             # :arg TypeName ArgName: descr
-            QAPITypedField(
+            TypedField(
                 "argument",
                 label=_("Arguments"),
                 names=("arg",),
@@ -648,7 +575,7 @@ class QAPICommand(QAPIObject):
                 has_arg=False,
             ),
             # :returns TypeName: descr
-            QAPIGroupedField(
+            GroupedField(
                 "returnvalue",
                 label=_("Returns"),
                 rolename="type",
@@ -656,7 +583,7 @@ class QAPICommand(QAPIObject):
                 can_collapse=True,
             ),
             # :returns-nodesc: TypeName
-            QAPIField(
+            Field(
                 "returnvalue",
                 label=_("Returns"),
                 names=("returns-nodesc",),
@@ -691,7 +618,7 @@ class QAPIAlternate(QAPIObject):
     doc_field_types.extend(
         [
             # :choice type name: descr
-            QAPITypedField(
+            TypedField(
                 "choice",
                 label=_("Choices"),
                 names=("choice",),
@@ -709,7 +636,7 @@ class QAPIObjectWithMembers(QAPIObject):
     doc_field_types.extend(
         [
             # :member type name: descr
-            QAPITypedField(
+            TypedField(
                 "member",
                 label=_("Members"),
                 names=("memb",),
@@ -842,7 +769,7 @@ class Branch(SphinxDirective):
     doc_field_types: List[Field] = [
         # :arg type name: descr
         # :memb type name: descr
-        QAPITypedField(
+        TypedField(
             "branch-arg-or-memb",
             label=":BRANCH:",
             names=("arg", "memb"),
-- 
2.47.0


