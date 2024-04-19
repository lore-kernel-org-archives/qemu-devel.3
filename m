Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C362BC05023
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1c-0007fV-Fb; Fri, 19 Apr 2024 00:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1P-0007Vg-2t
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1N-0004F2-2a
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PULeYLsuR2VLx6UCPvozb8ITIbXW39pMMYzXoqDSqzc=;
 b=jRCzimrSgBd/YqaUjSubU6/5OBVHNj0VMu3SH2UU1oZ60SYBuyfNBjiumyLY/un8WBlF/c
 vS4dX9QPsgq5yix0Sere94M+8D/iOV/BYW1x8W5PcUf8MlkWQbS1tGJ6n6lCP9ggcS4nw/
 zVU3mVGXScob0UFmJ+U976cltQXbPd4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-vS7iFMpKNcu7TA9lo1khqQ-1; Fri,
 19 Apr 2024 00:38:40 -0400
X-MC-Unique: vS7iFMpKNcu7TA9lo1khqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C59EF3CBDF64;
 Fri, 19 Apr 2024 04:38:39 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2187440357A7;
 Fri, 19 Apr 2024 04:38:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 24/27] docs/qapi-domain: add type cross-refs to field lists
Date: Fri, 19 Apr 2024 00:38:12 -0400
Message-ID: <20240419043820.178731-25-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

This commit, finally, adds cross-referencing support to various field
lists; modeled tightly after Sphinx's own Python domain code.

Cross-referencing support is added to type names provided to :arg:,
:memb:, :returns: and :choice:.

:feat:, :error: and :value:, which do not take type names, do not
support this syntax.

The general syntax is simple:

:arg TypeName ArgName: Lorem Ipsum ...

The domain will transform TypeName into :qapi:type:`TypeName` in this
basic case, and also apply the ``literal`` decoration to indicate that
this is a type cross-reference.

For Optional arguments, the special "?" suffix is used. Because "*" has
special meaning in ReST that would cause parsing errors, we elect to use
"?" instead. The special syntax processing in QAPIXrefMixin strips this
character from the end of any type name argument and will append ",
Optional" to the rendered output, applying the cross-reference only to
the actual type name.

The intent here is that the actual syntax in doc-blocks need not change;
but e.g. qapidoc.py will need to process and transform "@arg foo lorem
ipsum" into ":arg type? foo: lorem ipsum" based on the schema
information. Therefore, nobody should ever actually witness this
intermediate syntax unless they are writing manual documentation or the
doc transmogrifier breaks.

For array arguments, type names can similarly be surrounded by "[]",
which are stripped off and then re-appended outside of the
cross-reference.

Note: The mixin pattern here (borrowed from Sphinx) confuses mypy
because it cannot tell that it will be mixed into a descendent of
Field. Doing that instead causes more errors, because many versions of
Sphinx erroneously did not mark various arguments as Optional, so we're
a bit hosed either way. Do the simpler thing.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        |  34 ++++++++++++
 docs/sphinx/qapi-domain.py | 110 +++++++++++++++++++++++++++++++++++--
 2 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 8352a27d4a5..6e85ea5280d 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -105,6 +105,11 @@ Explicit cross-referencing syntax for QAPI modules is available with
    :arg str bar: Another normal parameter description.
    :arg baz: Missing a type.
    :arg no-descr:
+   :arg int? oof: Testing optional argument parsing.
+   :arg [XDbgBlockGraphNode] rab: Testing array argument parsing.
+   :arg [BitmapSyncMode]? zab: Testing optional array argument parsing,
+      even though Markus said this should never happen. I believe him,
+      but I didn't *forbid* the syntax either.
    :arg BitmapSyncMode discrim: How about branches in commands?
 
    .. qapi:branch:: discrim on-success
@@ -261,3 +266,32 @@ Explicit cross-referencing syntax for QAPI modules is available with
 
       :memb str key-secret: ID of a QCryptoSecret object providing a
          passphrase for unlocking the encryption
+
+.. qapi:command:: x-debug-query-block-graph
+   :since: 4.0
+   :unstable:
+
+   Get the block graph.
+
+   :feat unstable: This command is meant for debugging.
+   :return XDbgBlockGraph: lorem ipsum ...
+
+.. qapi:struct:: XDbgBlockGraph
+   :since: 4.0
+
+   Block Graph - list of nodes and list of edges.
+
+   :memb [XDbgBlockGraphNode] nodes:
+   :memb [XDbgBlockGraphEdge] edges:
+
+.. qapi:struct:: XDbgBlockGraphNode
+   :since: 4.0
+
+   :memb uint64 id: Block graph node identifier.  This @id is generated only for
+      x-debug-query-block-graph and does not relate to any other
+      identifiers in Qemu.
+   :memb XDbgBlockGraphNodeType type: Type of graph node.  Can be one of
+      block-backend, block-job or block-driver-state.
+   :memb str name: Human readable name of the node.  Corresponds to
+      node-name for block-driver-state nodes; is not guaranteed to be
+      unique in the whole graph (with block-jobs and block-backends).
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index bf8bb933345..074453193ce 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -50,11 +50,12 @@
 
 if TYPE_CHECKING:
     from docutils.nodes import Element, Node
+    from docutils.parsers.rst.states import Inliner
 
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
     from sphinx.environment import BuildEnvironment
-    from sphinx.util.typing import OptionSpec
+    from sphinx.util.typing import OptionSpec, TextlikeNode
 
 logger = logging.getLogger(__name__)
 
@@ -68,6 +69,90 @@ class ObjectEntry(NamedTuple):
     aliased: bool
 
 
+class QAPIXrefMixin:
+    def make_xref(
+        self,
+        rolename: str,
+        domain: str,
+        target: str,
+        innernode: type[TextlikeNode] = nodes.literal,
+        contnode: Optional[Node] = None,
+        env: Optional[BuildEnvironment] = None,
+        inliner: Optional[Inliner] = None,
+        location: Optional[Node] = None,
+    ) -> Node:
+        result = super().make_xref(  # type: ignore[misc]
+            rolename,
+            domain,
+            target,
+            innernode=innernode,
+            contnode=contnode,
+            env=env,
+            inliner=None,
+            location=None,
+        )
+        if isinstance(result, pending_xref):
+            assert env is not None
+            result["refspecific"] = True
+            result["qapi:module"] = env.ref_context.get("qapi:module")
+
+        assert isinstance(result, Node)
+        return result
+
+    def make_xrefs(
+        self,
+        rolename: str,
+        domain: str,
+        target: str,
+        innernode: type[TextlikeNode] = nodes.literal,
+        contnode: Optional[Node] = None,
+        env: Optional[BuildEnvironment] = None,
+        inliner: Optional[Inliner] = None,
+        location: Optional[Node] = None,
+    ) -> list[Node]:
+        # Note: this function is called on up to three fields of text:
+        # (1) The field name argument (e.g. member/arg name)
+        # (2) The field name type (e.g. member/arg type)
+        # (3) The field *body* text, for Fields that do not take arguments.
+
+        list_type = False
+        optional = False
+
+        # If the rolename is qapi:type, we know we are processing a type
+        # and not an arg/memb name or field body text.
+        if rolename == "type":
+            # force the innernode class to be a literal.
+            innernode = nodes.literal
+
+            # Type names that end with "?" are considered Optional
+            # arguments and should be documented as such, but it's not
+            # part of the xref itself.
+            if target.endswith("?"):
+                optional = True
+                target = target[:-1]
+
+            # Type names wrapped in brackets denote lists. strip the
+            # brackets and remember to add them back later.
+            if target.startswith("[") and target.endswith("]"):
+                list_type = True
+                target = target[1:-1]
+
+        results = []
+        result = self.make_xref(
+            rolename, domain, target, innernode, contnode, env, inliner, location
+        )
+        results.append(result)
+
+        if list_type:
+            results.insert(0, nodes.literal("[", "["))
+            results.append(nodes.literal("]", "]"))
+        if optional:
+            results.append(nodes.Text(", "))
+            results.append(nodes.emphasis("?", "Optional"))
+
+        return results
+
+
 class QAPIXRefRole(XRefRole):
     def process_link(
         self,
@@ -96,6 +181,14 @@ def process_link(
         return title, target
 
 
+class QAPIGroupedField(QAPIXrefMixin, GroupedField):
+    pass
+
+
+class QAPITypedField(QAPIXrefMixin, TypedField):
+    pass
+
+
 def since_validator(param: str) -> str:
     """
     Validate the `:since: X.Y` option field.
@@ -416,10 +509,11 @@ class QAPICommand(QAPIObject):
     doc_field_types = QAPIObject.doc_field_types.copy()
     doc_field_types.extend(
         [
-            TypedField(
+            QAPITypedField(
                 "argument",
                 label=_("Arguments"),
                 names=("arg",),
+                typerolename="type",
                 can_collapse=True,
             ),
             GroupedField(
@@ -428,9 +522,10 @@ class QAPICommand(QAPIObject):
                 names=("error",),
                 can_collapse=True,
             ),
-            GroupedField(
+            QAPIGroupedField(
                 "returnvalue",
                 label=_("Returns"),
+                rolename="type",
                 names=("return", "returns"),
                 can_collapse=True,
             ),
@@ -460,10 +555,11 @@ class QAPIAlternate(QAPIObject):
     doc_field_types = QAPIObject.doc_field_types.copy()
     doc_field_types.extend(
         [
-            TypedField(
+            QAPITypedField(
                 "choice",
                 label=_("Choices"),
                 names=("choice",),
+                typerolename="type",
                 can_collapse=True,
             ),
         ]
@@ -476,10 +572,11 @@ class QAPIObjectWithMembers(QAPIObject):
     doc_field_types = QAPIObject.doc_field_types.copy()
     doc_field_types.extend(
         [
-            TypedField(
+            QAPITypedField(
                 "member",
                 label=_("Members"),
                 names=("memb",),
+                typerolename="type",
                 can_collapse=True,
             ),
         ]
@@ -629,12 +726,13 @@ def run(self) -> list[Node]:
         # of per-class to incorporate the branch conditions as a label
         # name.
         self.doc_field_types = [
-            TypedField(
+            QAPITypedField(
                 "branch-arg-or-memb",
                 label=f"[{discrim} = {value}]",
                 # In a branch, we don't actually use the name of the
                 # field name to generate the label; so allow either-or.
                 names=("arg", "memb"),
+                typerolename="type",
             ),
         ]
 
-- 
2.44.0


