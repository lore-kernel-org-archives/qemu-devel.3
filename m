Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BB2C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFCa-0008Vh-Fz; Thu, 05 Jun 2025 14:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNFCY-0008U8-7U
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNFCW-0001Wl-NP
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749147627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYnGFQd+8T70d72YmedPkEkOM2OzR/O/qE3BDyg8SnQ=;
 b=CpCh9ZlBXTnqG7/s/o/rgA8R1lAXIG20ydXjNVVFSNw0p43hzFLSwp7d0qcEc+oIwz9DxF
 jFaExeb6MCg3sA0EqGimq0XGvI3tHltQjRYZL+rZ8kEG5N+5DtocAkrF6valZcNJo0iFUh
 PLTw0GZfoIe09Qv9hWz3gjuc6y6XRNg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-kVMxL3b0Mby7ffNZTZ9qkg-1; Thu,
 05 Jun 2025 14:20:24 -0400
X-MC-Unique: kVMxL3b0Mby7ffNZTZ9qkg-1
X-Mimecast-MFC-AGG-ID: kVMxL3b0Mby7ffNZTZ9qkg_1749147623
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 137361956089; Thu,  5 Jun 2025 18:20:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.99])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7913A1956094; Thu,  5 Jun 2025 18:20:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v2 2/6] docs/qapidoc: linting fixes
Date: Thu,  5 Jun 2025 14:20:10 -0400
Message-ID: <20250605182014.561172-3-jsnow@redhat.com>
In-Reply-To: <20250605182014.561172-1-jsnow@redhat.com>
References: <20250605182014.561172-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This restores the linting baseline in qapidoc. The order of some imports
change slightly here due to configuring isort a little better:
previously, isort was having difficulty understanding that "compat" and
"qapidoc_legacy" were local modules because docs/sphinx "isn't a python
package". Configuring this manually, isort chooses a different import
ordering, which _is_ intentional here.

Also: extra ignores are added for pylint. The most recent versions of
pylint don't require these ignores, but the oldest versions we support
do, so in the extra ignores go.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20250604200354.459501-3-jsnow@redhat.com
---
 docs/sphinx/qapi_domain.py | 25 ++++++++++++++-----------
 docs/sphinx/qapidoc.py     |  5 +++--
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index c94af5719ca..ebc46a72c61 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -20,16 +20,6 @@
 
 from docutils import nodes
 from docutils.parsers.rst import directives
-
-from compat import (
-    CompatField,
-    CompatGroupedField,
-    CompatTypedField,
-    KeywordNode,
-    ParserFix,
-    Signature,
-    SpaceNode,
-)
 from sphinx import addnodes
 from sphinx.directives import ObjectDescription
 from sphinx.domains import (
@@ -44,6 +34,16 @@
 from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id, make_refnode
 
+from compat import (
+    CompatField,
+    CompatGroupedField,
+    CompatTypedField,
+    KeywordNode,
+    ParserFix,
+    Signature,
+    SpaceNode,
+)
+
 
 if TYPE_CHECKING:
     from typing import (
@@ -56,7 +56,6 @@
     )
 
     from docutils.nodes import Element, Node
-
     from sphinx.addnodes import desc_signature, pending_xref
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
@@ -168,6 +167,8 @@ class QAPIDescription(ParserFix):
     """
 
     def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
+        # pylint: disable=unused-argument
+
         # Do nothing. The return value here is the "name" of the entity
         # being documented; for QAPI, this is the same as the
         # "signature", which is just a name.
@@ -210,6 +211,8 @@ def _get_fqn(self, name: Signature) -> str:
     def add_target_and_index(
         self, name: Signature, sig: str, signode: desc_signature
     ) -> None:
+        # pylint: disable=unused-argument
+
         # name is the return value of handle_signature.
         # sig is the original, raw text argument to handle_signature.
         # For QAPI, these are identical, currently.
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 661b2c4ed0e..8011ac9efaf 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -27,6 +27,7 @@
 
 from __future__ import annotations
 
+
 __version__ = "2.0"
 
 from contextlib import contextmanager
@@ -56,8 +57,6 @@
     QAPISchemaVisitor,
 )
 from qapi.source import QAPISourceInfo
-
-from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
 from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
@@ -65,6 +64,8 @@
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 
+from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
+
 
 if TYPE_CHECKING:
     from typing import (
-- 
2.48.1


