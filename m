Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D71EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1N-0007VQ-Nk; Fri, 19 Apr 2024 00:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1B-0007Qf-MX
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg19-0004BS-6r
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rcUHy7QSQh4ohx4ayY+RA7M+aNEuZhNoIheLxzP2v0=;
 b=QAY60fQ/IYaZjFUWwXK+yI43Ack92HYqfFDqBxiXXPa4lXGv6gBsDLQWp90S9trB36JBzn
 6EDJ0YjKNH16z6d2zecQdkYqAY/sOMg8qR2WwX5eH8J5MUYCI1xYDP7KFmLIFGZfoJGBPi
 j/fsys5z85Db/9bpvsE/vNIPD2ClZrM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-5uEvj-fxOCOF0PM9TX1-6Q-1; Fri,
 19 Apr 2024 00:38:28 -0400
X-MC-Unique: 5uEvj-fxOCOF0PM9TX1-6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5623811F28;
 Fri, 19 Apr 2024 04:38:28 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F23640C1233;
 Fri, 19 Apr 2024 04:38:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 09/27] docs/qapi-domain: add "Arguments:" field lists
Date: Fri, 19 Apr 2024 00:37:57 -0400
Message-ID: <20240419043820.178731-10-jsnow@redhat.com>
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

This adds special rendering for Sphinx's typed field lists.

This patch does not add any QAPI-aware markup, rendering, or
cross-referencing for the type names, yet. That feature requires a
subclass to TypedField which will happen in its own commit quite a bit
later in this series; after all the basic fields and objects have been
established first.

The syntax for this field is:

:arg type name: description
   description cont'd

You can omit the type or the description, but you cannot omit the name
-- if you do so, it degenerates into a "normal field list" entry, and
probably isn't what you want.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        | 15 +++++++++++++++
 docs/sphinx/qapi-domain.py | 14 ++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 33b9349a3ee..197587bbc81 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -86,3 +86,18 @@ Explicit cross-referencing syntax for QAPI modules is available with
    * ``:no-index-entry:`` or ``:noindexentry:``
    * ``:no-contents-entry:`` or ``:nocontentsentry:``
    * ``:no-typesetting:``
+
+.. qapi:command:: fake-command
+   :since: 13.37
+
+   This is a fake command, it's not real. It can't hurt you.
+
+   :arg int foo: normal parameter documentation.
+   :arg str bar: Another normal parameter description.
+   :arg baz: Missing a type.
+   :arg no-descr:
+
+   Field lists can appear anywhere in the directive block, but any field
+   list entries in the same list block that are recognized as special
+   ("arg") will be reformatted and grouped accordingly for rendered
+   output.
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 38a50318d08..853bd91b7a8 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -33,6 +33,7 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
+from sphinx.util.docfields import TypedField
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import (
     make_id,
@@ -254,8 +255,17 @@ def _toc_entry_name(self, sig_node: desc_signature) -> str:
 class QAPICommand(QAPIObject):
     """Description of a QAPI Command."""
 
-    # Nothing unique for now! Changed in later commits O:-)
-    pass
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            TypedField(
+                "argument",
+                label=_("Arguments"),
+                names=("arg",),
+                can_collapse=True,
+            ),
+        ]
+    )
 
 
 class QAPIModule(SphinxDirective):
-- 
2.44.0


