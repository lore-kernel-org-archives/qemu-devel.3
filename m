Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A8EC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1O-0007VV-Rf; Fri, 19 Apr 2024 00:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1B-0007QG-Ab
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg18-00049t-Gz
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yd3gqttPN7y/yTkQ3a8gByZcKPzL7SnUWn217oHpxJI=;
 b=XDudCDnn/pN6bgOCz64qBGFvnOhyja6q76/MTsUx6aM6CbEVmaChBb16pw2Iw+rEq1aXmo
 OYIHY5BrmBpFxk55FxPZlenr+zTuqwRHnctiHJc2dP1P95wOF6B/xXbRAr/X+d/Thtb3Bd
 xonVgqCP+zCti0ml5viDCRjkYwHV8mY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-13vhTZKfMQqnhK7fAlMlrQ-1; Fri, 19 Apr 2024 00:38:25 -0400
X-MC-Unique: 13vhTZKfMQqnhK7fAlMlrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9992B811029;
 Fri, 19 Apr 2024 04:38:24 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E76984011FF7;
 Fri, 19 Apr 2024 04:38:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 04/27] docs/qapi-domain: add QAPI index
Date: Fri, 19 Apr 2024 00:37:52 -0400
Message-ID: <20240419043820.178731-5-jsnow@redhat.com>
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

Use the QAPI object registry to generate a special index just for QAPI
definitions. The index can show entries both by definition type and
alphabetically.

The index can be linked from anywhere in the QEMU manual by using
`qapi-index`.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        |  6 +++-
 docs/sphinx/qapi-domain.py | 66 +++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 880fd17c709..051dc6b3a37 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -9,7 +9,8 @@ QAPI Domain Test
    doesn't create a cross-reference target and it isn't added to the
    index.
 
-   Check out the `genindex` for proof that foo-module is not present.
+   Check out the `genindex` or the `qapi-index` for proof that
+   foo-module is not present.
 
 .. qapi:module:: bar-module
    :no-typesetting:
@@ -36,3 +37,6 @@ QAPI Domain Test
 
    The ``block-core`` module will have two entries in the `genindex`,
    under both "block-core" and "QAPI module".
+
+   Modules will also be reported in the `qapi-index`, under the Modules
+   category and in the alphabetical categories that follow.
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index ab80fd5f634..65409786119 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -12,6 +12,7 @@
     Iterable,
     List,
     NamedTuple,
+    Optional,
     Tuple,
     cast,
 )
@@ -20,7 +21,12 @@
 from docutils.parsers.rst import directives
 
 from sphinx import addnodes
-from sphinx.domains import Domain, ObjType
+from sphinx.domains import (
+    Domain,
+    Index,
+    IndexEntry,
+    ObjType,
+)
 from sphinx.locale import _, __
 from sphinx.util import logging
 from sphinx.util.docutils import SphinxDirective, switch_source_input
@@ -74,9 +80,10 @@ class QAPIModule(SphinxDirective):
     a pass-through for the content body. Named section titles are
     allowed in the content body.
 
-    Use this directive to associate subsequent definitions with the
-    module they are defined in for purposes of search and QAPI index
-    organization.
+    Use this directive to create entries for the QAPI module in the
+    global index and the qapi index; as well as to associate subsequent
+    definitions with the module they are defined in for purposes of
+    search and QAPI index organization.
 
     :arg: The name of the module.
     :opt no-index: Don't add cross-reference targets or index entries.
@@ -155,6 +162,52 @@ def run(self) -> List[Node]:
         return ret
 
 
+class QAPIIndex(Index):
+    """
+    Index subclass to provide the QAPI definition index.
+    """
+
+    name = "index"
+    localname = _("QAPI Index")
+    shortname = _("QAPI Index")
+
+    def generate(
+        self,
+        docnames: Optional[Iterable[str]] = None,
+    ) -> Tuple[List[Tuple[str, List[IndexEntry]]], bool]:
+        assert isinstance(self.domain, QAPIDomain)
+        content: Dict[str, List[IndexEntry]] = {}
+        collapse = False
+
+        # list of all object (name, ObjectEntry) pairs, sorted by name
+        objects = sorted(self.domain.objects.items(), key=lambda x: x[0].lower())
+
+        for objname, obj in objects:
+            if docnames and obj.docname not in docnames:
+                continue
+
+            # Strip the module name out:
+            objname = objname.split(".")[-1]
+
+            # Add an alphabetical entry:
+            entries = content.setdefault(objname[0].upper(), [])
+            entries.append(
+                IndexEntry(objname, 0, obj.docname, obj.node_id, obj.objtype, "", "")
+            )
+
+            # Add a categorical entry:
+            category = obj.objtype.title() + "s"
+            entries = content.setdefault(category, [])
+            entries.append(IndexEntry(objname, 0, obj.docname, obj.node_id, "", "", ""))
+
+        # alphabetically sort categories; type names first, ABC entries last.
+        sorted_content = sorted(
+            content.items(),
+            key=lambda x: (len(x[0]) == 1, x[0]),
+        )
+        return sorted_content, collapse
+
+
 class QAPIDomain(Domain):
     """QAPI language domain."""
 
@@ -182,7 +235,10 @@ class QAPIDomain(Domain):
         "objects": {},  # fullname -> ObjectEntry
     }
 
-    indices = []
+    # Index pages to generate; each entry is an Index class.
+    indices = [
+        QAPIIndex,
+    ]
 
     @property
     def objects(self) -> Dict[str, ObjectEntry]:
-- 
2.44.0


