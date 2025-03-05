Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C380C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfic-0005Pf-Rf; Tue, 04 Mar 2025 22:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiZ-0005Oa-7M
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiX-00062x-N6
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLKQxzj4s8eRpQziP7kQUeQMQDmRMosC+w0qxb65wKk=;
 b=FHIJzQr1LNWqECi6QwVlMAv9QdUrpy7bBXBRnr8q/H3eLIXU8qNeLzQiZV6n1toSCKumg0
 vsXCfoMM2nUvJ0HebfOL81I+PVmYUmIndTXk+QOOqj97tF3cj9WWCu1CeWMbwfIhF2F4jG
 diWGY/+mDllRxgUiZ5Y8GFK729cvL1I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-U1-V5-DPPwmFw10mDOjTsg-1; Tue,
 04 Mar 2025 22:46:40 -0500
X-MC-Unique: U1-V5-DPPwmFw10mDOjTsg-1
X-Mimecast-MFC-AGG-ID: U1-V5-DPPwmFw10mDOjTsg_1741146399
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D8DA1955BC9; Wed,  5 Mar 2025 03:46:39 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 306771956095; Wed,  5 Mar 2025 03:46:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 07/57] docs/qapi-domain: add QAPI index
Date: Tue,  4 Mar 2025 22:45:16 -0500
Message-ID: <20250305034610.960147-8-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

Use the QAPI object registry to generate a special index just for QAPI
definitions. The index can show entries both by definition type and all
together, alphabetically.

The index can be linked from anywhere in the QEMU manual by using the
reference `qapi-index`.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 76 +++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index b17fcb93f24..716a38a5f00 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -13,6 +13,7 @@
     Iterable,
     List,
     NamedTuple,
+    Optional,
     Tuple,
     cast,
 )
@@ -22,7 +23,12 @@
 
 from compat import nested_parse
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
 from sphinx.util.docutils import SphinxDirective
@@ -53,9 +59,10 @@ class QAPIModule(SphinxDirective):
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
@@ -134,6 +141,62 @@ def run(self) -> List[Node]:
         return ret
 
 
+class QAPIIndex(Index):
+    """
+    Index subclass to provide the QAPI definition index.
+    """
+
+    # pylint: disable=too-few-public-methods
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
+        # (ignoring the module)
+        objects = sorted(
+            self.domain.objects.items(),
+            key=lambda x: x[0].split(".")[-1].lower(),
+        )
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
+                IndexEntry(
+                    objname, 0, obj.docname, obj.node_id, obj.objtype, "", ""
+                )
+            )
+
+            # Add a categorical entry:
+            category = obj.objtype.title() + "s"
+            entries = content.setdefault(category, [])
+            entries.append(
+                IndexEntry(objname, 0, obj.docname, obj.node_id, "", "", "")
+            )
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
 
@@ -161,7 +224,10 @@ class QAPIDomain(Domain):
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
2.48.1


