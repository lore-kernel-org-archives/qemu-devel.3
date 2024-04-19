Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B18DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1N-0007Uy-6w; Fri, 19 Apr 2024 00:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1C-0007R7-0W
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg19-0004Bi-W7
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtfPOVc2sq5gvEb2kNhiQ+7sghfVmy34SoiYv6DOq5U=;
 b=ZEHmPehC4yr9WVeruMDn3iWIvyy0G8TxFWb+iby6vAGEhWJVw5HZU4iDYXwqV+5Btxz9TW
 Ydm73k2+h6OJs3IwyxGqCI8L9BXrZ3pWdpoemPTxr9k1G5TZP6auvhCX7Uzhavyy0gxNXF
 GvlmDMU+nC4RAtKH32VcDshcJ0vgfbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-_gerOnxrMACSfH8DytaZbQ-1; Fri, 19 Apr 2024 00:38:29 -0400
X-MC-Unique: _gerOnxrMACSfH8DytaZbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D7CD834FB1;
 Fri, 19 Apr 2024 04:38:29 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D1B140357A7;
 Fri, 19 Apr 2024 04:38:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 10/27] docs/qapi-domain: add "Features:" field lists
Date: Fri, 19 Apr 2024 00:37:58 -0400
Message-ID: <20240419043820.178731-11-jsnow@redhat.com>
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

Add support for Features field lists. There is no QAPI-specific
functionality here, but this could be changed if desired (if we wanted
the feature names to link somewhere, for instance.)

This feature list doesn't have any restrictions, so it can be used to
document object-wide features or per-member features as deemed
appropriate. It's essentially free-form text.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        |  6 ++++++
 docs/sphinx/qapi-domain.py | 11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 197587bbc81..a570c37abb2 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -95,9 +95,15 @@ Explicit cross-referencing syntax for QAPI modules is available with
    :arg int foo: normal parameter documentation.
    :arg str bar: Another normal parameter description.
    :arg baz: Missing a type.
+   :feat unstable: More than unstable, this command doesn't even exist!
    :arg no-descr:
+   :feat hallucination: This command is a figment of your imagination.
 
    Field lists can appear anywhere in the directive block, but any field
    list entries in the same list block that are recognized as special
    ("arg") will be reformatted and grouped accordingly for rendered
    output.
+
+   At the moment, the order of grouped sections is based on the order in
+   which each group was encountered. This example will render Arguments
+   first, and then Features; but the order can be any that you choose.
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 853bd91b7a8..c0dc6482204 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -33,7 +33,7 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
-from sphinx.util.docfields import TypedField
+from sphinx.util.docfields import GroupedField, TypedField
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import (
     make_id,
@@ -146,6 +146,15 @@ class QAPIObject(ObjectDescription[Signature]):
         }
     )
 
+    doc_field_types = [
+        GroupedField(
+            "feature",
+            label=_("Features"),
+            names=("feat",),
+            can_collapse=True,
+        ),
+    ]
+
     def get_signature_prefix(self, sig: str) -> List[nodes.Node]:
         """Returns a prefix to put before the object name in the signature."""
         assert self.objtype
-- 
2.44.0


