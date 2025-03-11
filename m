Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DDEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqZ-0003EO-Mt; Tue, 11 Mar 2025 07:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqF-000385-N6
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq2-0006VC-LU
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MzgzaaGvIpDq4XniT4JU4yhPMfUYhG5BKDfJM+EEXp4=;
 b=HJxzaP31EremXVr1+GRcULs+GtM0xEesyrPdv3t3kBqq38FrUi2HRyIqVRO+58zI1YwIil
 6ydKHEquVUDyb0y47g8nAfcPg8N5oek67yjeT1+w7cq8BVwprk1kuu7BtvdD2sCSMSZjgV
 bQEOKWVhz+GUQgeBZGcDFGEuRptq6Ps=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-lYCE5hv4MziH34GkqMnTnw-1; Tue,
 11 Mar 2025 07:31:55 -0400
X-MC-Unique: lYCE5hv4MziH34GkqMnTnw-1
X-Mimecast-MFC-AGG-ID: lYCE5hv4MziH34GkqMnTnw_1741692714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DFF51955DDE
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A76B2180094A
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E2A621E61A4; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 29/61] docs/qapi-domain: Fix error context reporting in Sphinx
 5.x and 6.x
Date: Tue, 11 Mar 2025 12:31:05 +0100
Message-ID: <20250311113137.1277125-30-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Sphinx 5.3.0 to Sphinx 6.2.0 has a bug where nested content in an
ObjectDescription content block has its error position reported
incorrectly due to an oversight when they added nested section support
to this directive.

(This bug is present in Sphinx's own Python and C domains; test it
yourself by creating a py:func directive and creating a syntax error in
the directive's content block. The reporting will be incorrect.)

To avoid overriding and re-implementing the entirety of the run()
method, a workaround is employed where we parse the content block
ourselves in before_content(), then null the content block to make
Sphinx's own parsing a no-op. Then, in transform_content (which occurs
after Sphinx's nested parse), we simply swap our own parsed content tree
back in for Sphinx's.

It appears a little tricky, but it's the nicest solution I can find.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-32-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/compat.py      | 56 ++++++++++++++++++++++++++++++++++++++
 docs/sphinx/qapi_domain.py | 15 ++++++----
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index f068d70388..9cf7fe006e 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -4,6 +4,7 @@
 
 import re
 from typing import (
+    TYPE_CHECKING,
     Any,
     Callable,
     Optional,
@@ -12,9 +13,11 @@
 
 from docutils import nodes
 from docutils.nodes import Element, Node, Text
+from docutils.statemachine import StringList
 
 import sphinx
 from sphinx import addnodes, util
+from sphinx.directives import ObjectDescription
 from sphinx.environment import BuildEnvironment
 from sphinx.roles import XRefRole
 from sphinx.util import docfields
@@ -172,3 +175,56 @@ class CompatGroupedField(docfields.GroupedField):
 class CompatTypedField(docfields.TypedField):
     if MAKE_XREF_WORKAROUND:
         make_xref = _compat_make_xref
+
+
+# ################################################################
+# Nested parsing error location fix for Sphinx 5.3.0 < x < 6.2.0 #
+# ################################################################
+
+# When we require Sphinx 4.x, the TYPE_CHECKING hack where we avoid
+# subscripting ObjectDescription at runtime can be removed in favor of
+# just always subscripting the class.
+
+# When we require Sphinx > 6.2.0, the rest of this compatibility hack
+# can be dropped and QAPIObject can just inherit directly from
+# ObjectDescription[Signature].
+
+SOURCE_LOCATION_FIX = (5, 3, 0) <= sphinx.version_info[:3] < (6, 2, 0)
+
+Signature = str
+
+
+if TYPE_CHECKING:
+    _BaseClass = ObjectDescription[Signature]
+else:
+    _BaseClass = ObjectDescription
+
+
+class ParserFix(_BaseClass):
+
+    _temp_content: StringList
+    _temp_offset: int
+    _temp_node: Optional[addnodes.desc_content]
+
+    def before_content(self) -> None:
+        # Work around a sphinx bug and parse the content ourselves.
+        self._temp_content = self.content
+        self._temp_offset = self.content_offset
+        self._temp_node = None
+
+        if SOURCE_LOCATION_FIX:
+            self._temp_node = addnodes.desc_content()
+            self.state.nested_parse(
+                self.content, self.content_offset, self._temp_node
+            )
+            # Sphinx will try to parse the content block itself,
+            # Give it nothingness to parse instead.
+            self.content = StringList()
+            self.content_offset = 0
+
+    def transform_content(self, content_node: addnodes.desc_content) -> None:
+        # Sphinx workaround: Inject our parsed content and restore state.
+        if self._temp_node:
+            content_node += self._temp_node.children
+            self.content = self._temp_content
+            self.content_offset = self._temp_offset
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index b23db1eba2..ca3f3a7e2d 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -29,6 +29,8 @@
     CompatGroupedField,
     CompatTypedField,
     KeywordNode,
+    ParserFix,
+    Signature,
     SpaceNode,
 )
 from sphinx import addnodes
@@ -147,12 +149,7 @@ def result_nodes(
         return results, []
 
 
-# Alias for the return of handle_signature(), which is used in several places.
-# (In the Python domain, this is Tuple[str, str] instead.)
-Signature = str
-
-
-class QAPIDescription(ObjectDescription[Signature]):
+class QAPIDescription(ParserFix):
     """
     Generic QAPI description.
 
@@ -422,6 +419,10 @@ def _validate_field(self, field: nodes.field) -> None:
             logger.warning(msg, location=field)
 
     def transform_content(self, content_node: addnodes.desc_content) -> None:
+        # This hook runs after before_content and the nested parse, but
+        # before the DocFieldTransformer is executed.
+        super().transform_content(content_node)
+
         self._add_infopips(content_node)
 
         # Validate field lists.
@@ -519,10 +520,12 @@ class QAPIObjectWithMembers(QAPIObject):
 
 
 class QAPIEvent(QAPIObjectWithMembers):
+    # pylint: disable=too-many-ancestors
     """Description of a QAPI Event."""
 
 
 class QAPIJSONObject(QAPIObjectWithMembers):
+    # pylint: disable=too-many-ancestors
     """Description of a QAPI Object: structs and unions."""
 
 
-- 
2.48.1


