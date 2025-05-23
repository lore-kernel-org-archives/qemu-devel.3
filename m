Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2949FC54EDA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 18:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIWos-0005JF-CM; Fri, 23 May 2025 14:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIWom-0005Ig-VA
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIWok-0001HH-Ur
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748023705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nasIQc1MWOMIJ1F8E5zcoXWoGvUcVHo9qkQB0uq4/mM=;
 b=U5bXHnfgtm+N5KoK5Bqse5QAegWti1Q8NxeSdWTBiAAdRGKEy9dwRBGgSLq7icsL+OnlKq
 S1cOyxprTtg0pElicKgATkm6lv212tzGal52fk9MI3OCcZ4AkelBybSLZaGCx9biPK8yRZ
 PgIJOMEeswRmmFpBEMknT0sR0iSe71k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-K1tGxZfwNmS63UwTn8kVfA-1; Fri,
 23 May 2025 14:08:22 -0400
X-MC-Unique: K1tGxZfwNmS63UwTn8kVfA-1
X-Mimecast-MFC-AGG-ID: K1tGxZfwNmS63UwTn8kVfA_1748023701
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B8E3195608C; Fri, 23 May 2025 18:08:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.78])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B2911800361; Fri, 23 May 2025 18:08:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/1] docs/qapi-domain: Improve QAPI indices
Date: Fri, 23 May 2025 14:08:09 -0400
Message-ID: <20250523180809.41211-2-jsnow@redhat.com>
In-Reply-To: <20250523180809.41211-1-jsnow@redhat.com>
References: <20250523180809.41211-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

This patch changes the "by type" categorization in favor of using
sub-categories of a literal "By type" category instead. A new "By
module" categorization is also added that follows a similar pattern.

Alphabetical sorting has been improved and will sort in a case
insensitive manner for all categories, now.

Lastly, the "main" QAPI Index (qapi-index.html) is altered to index
*everything* from all namespaces, adding disambiguation where necessary
to do so.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 51 +++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index c94af5719ca..d844493c5cb 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -679,37 +679,60 @@ def generate(
     ) -> Tuple[List[Tuple[str, List[IndexEntry]]], bool]:
         assert isinstance(self.domain, QAPIDomain)
         content: Dict[str, List[IndexEntry]] = {}
-        collapse = False
+        collapse = bool(not self.namespace)
 
-        for objname, obj in self.domain.objects.items():
+        module_index: Dict[str, List[IndexEntry]] = {}
+        type_index: Dict[str, List[IndexEntry]] = {}
+
+        for objname, obj in sorted(
+            self.domain.objects.items(),
+            key=lambda x: QAPIDescription.split_fqn(x[0])[2].lower(),
+        ):
             if docnames and obj.docname not in docnames:
                 continue
 
-            ns, _mod, name = QAPIDescription.split_fqn(objname)
+            ns, mod, name = QAPIDescription.split_fqn(objname)
 
-            if self.namespace != ns:
+            if self.namespace and self.namespace != ns:
                 continue
 
-            # Add an alphabetical entry:
+            # Index alphabetally on name only
             entries = content.setdefault(name[0].upper(), [])
+            extra = obj.objtype if self.namespace else f"{obj.objtype}, {ns}"
             entries.append(
                 IndexEntry(
-                    name, 0, obj.docname, obj.node_id, obj.objtype, "", ""
+                    name, 0, obj.docname, obj.node_id, extra, "", ""
                 )
             )
 
-            # Add a categorical entry:
-            category = obj.objtype.title() + "s"
-            entries = content.setdefault(category, [])
+            # Sub-index by-type
+            entries = type_index.setdefault(obj.objtype.title(), [])
+            extra = "" if self.namespace else ns
             entries.append(
-                IndexEntry(name, 0, obj.docname, obj.node_id, "", "", "")
+                IndexEntry(name, 2, obj.docname, obj.node_id, extra, "", "")
             )
 
-        # Sort entries within each category alphabetically
-        for category in content:
-            content[category] = sorted(content[category])
+            # Sub-index by-module
+            if mod:
+                category = mod if self.namespace else f"{mod}, {ns}"
+                entries = module_index.setdefault(category, [])
+                entries.append(
+                    IndexEntry(
+                        name, 2, obj.docname, obj.node_id, obj.objtype, "", ""
+                    )
+                )
 
-        # Sort the categories themselves; type names first, ABC entries last.
+        for key, indices in sorted(type_index.items()):
+            entries = content.setdefault("By type", [])
+            entries.append(IndexEntry(key, 1, "", "", "", "", ""))
+            entries.extend(indices)
+
+        for key, indices in sorted(module_index.items()):
+            entries = content.setdefault("By module", [])
+            entries.append(IndexEntry(key, 1, "", "", "", "", ""))
+            entries.extend(indices)
+
+        # Sort the categories themselves; meta-categories first.
         sorted_content = sorted(
             content.items(),
             key=lambda x: (len(x[0]) == 1, x[0]),
-- 
2.48.1


