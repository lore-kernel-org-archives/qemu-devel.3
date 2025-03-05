Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBAEC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfjf-0007Xe-Ue; Tue, 04 Mar 2025 22:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjc-0007Mx-P5
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfja-0006Cc-JQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCfOGBdJQwnF5xt02pbv4fzYOIJ9eH+7LDoB69oghKg=;
 b=ZqK2fgWFuyueX7glf+II4NNnWoaT1FibWaVvK3JdmXFYNBjy9+TsiAzddTxV8+GFIPsUBu
 4BozdvGWqhZEGXFc/flCunENqHtGuEcO7XK9arNVRl1EuKCu0q3P6Ns8Vxgqk/Y//ibpsz
 g8grWS3+BxBPzY8puJ1DxwLBGZKpuqo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-1WX9GH9zO2CR64c-kSLR3w-1; Tue,
 04 Mar 2025 22:47:48 -0500
X-MC-Unique: 1WX9GH9zO2CR64c-kSLR3w-1
X-Mimecast-MFC-AGG-ID: 1WX9GH9zO2CR64c-kSLR3w_1741146467
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B8331954191; Wed,  5 Mar 2025 03:47:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 271841956095; Wed,  5 Mar 2025 03:47:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 25/57] docs/qapi-domain: add type cross-refs to field lists
Date: Tue,  4 Mar 2025 22:45:34 -0500
Message-ID: <20250305034610.960147-26-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

For optional arguments, the special "?" suffix is used. Because "*" has
special meaning in rST that would cause parsing errors, we elect to use
"?" instead. The special syntax processing strips this character from
the end of any type name argument and will append ", optional" to the
rendered output, applying the cross-reference only to the actual type
name.

The intent here is that the actual syntax in doc-blocks need not change;
but e.g. qapidoc.py will need to process and transform "@arg foo lorem
ipsum" into ":arg type? foo: lorem ipsum" based on the schema
information. Therefore, nobody should ever actually witness this
intermediate syntax unless they are writing manual documentation or the
doc transmogrifier breaks.

For array arguments, type names can similarly be surrounded by "[]",
which are stripped off and then re-appended outside of the
cross-reference.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 6eaf8ce92b4..753e07024f5 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -2,6 +2,9 @@
 QAPI domain extension.
 """
 
+# The best laid plans of mice and men, ...
+# pylint: disable=too-many-lines
+
 from __future__ import annotations
 
 import re
@@ -119,6 +122,28 @@ def process_link(
 
         return title, target
 
+    def result_nodes(
+        self,
+        document: nodes.document,
+        env: BuildEnvironment,
+        node: Element,
+        is_ref: bool,
+    ) -> Tuple[List[nodes.Node], List[nodes.system_message]]:
+
+        # node here is the pending_xref node (or whatever nodeclass was
+        # configured at XRefRole class instantiation time).
+        results: List[nodes.Node] = [node]
+
+        if node.get("qapi:array"):
+            results.insert(0, nodes.literal("[", "["))
+            results.append(nodes.literal("]", "]"))
+
+        if node.get("qapi:optional"):
+            results.append(nodes.Text(", "))
+            results.append(nodes.emphasis("?", "optional"))
+
+        return results, []
+
 
 def since_validator(param: str) -> str:
     """
@@ -423,6 +448,7 @@ class QAPICommand(QAPIObject):
                 "argument",
                 label=_("Arguments"),
                 names=("arg",),
+                typerolename="type",
                 can_collapse=False,
             ),
             # :error: descr
@@ -436,6 +462,7 @@ class QAPICommand(QAPIObject):
             GroupedField(
                 "returnvalue",
                 label=_("Returns"),
+                rolename="type",
                 names=("return", "returns"),
                 can_collapse=True,
             ),
@@ -471,6 +498,7 @@ class QAPIAlternate(QAPIObject):
                 "choice",
                 label=_("Choices"),
                 names=("choice",),
+                typerolename="type",
                 can_collapse=False,
             ),
         ]
@@ -488,6 +516,7 @@ class QAPIObjectWithMembers(QAPIObject):
                 "member",
                 label=_("Members"),
                 names=("memb",),
+                typerolename="type",
                 can_collapse=False,
             ),
         ]
-- 
2.48.1


