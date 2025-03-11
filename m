Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45454C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqWf-0003lL-Ep; Mon, 10 Mar 2025 23:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWd-0003kd-CT
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWb-00029r-Cr
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJ8i3B3IWUv9hwDYZ3ZSUdrZb/ZBpQUf3O+dp/jYjMw=;
 b=arQAaNZqEjEGa/wlKJS5HU0Df4lSxklWMbUOOjW9BzQh9CWv+TmBdxOxVKhI8P7BqPYRfi
 avYEVVW1+ALs9xK5kfkpaoMD1UV227kfdYpq06i2nJTZDvfvUZxpLXG0vX38j79Fpw5Uj3
 +cH3/NFOxhGP3KgV1nHa3xyB4obn2N4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-zlaE8VDgP124pwqUBwFykQ-1; Mon,
 10 Mar 2025 23:43:22 -0400
X-MC-Unique: zlaE8VDgP124pwqUBwFykQ-1
X-Mimecast-MFC-AGG-ID: zlaE8VDgP124pwqUBwFykQ_1741664601
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E452180AF4D; Tue, 11 Mar 2025 03:43:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8C631800373; Tue, 11 Mar 2025 03:43:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 03/63] docs/sphinx: create QAPI domain extension stub
Date: Mon, 10 Mar 2025 23:42:01 -0400
Message-ID: <20250311034303.75779-4-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

A Sphinx domain is a collection of directive and role extensions meant
to facilitate the documentation of a specific language. For instance,
Sphinx ships with "python" and "cpp" domains. This patch introduces a
stub for the "qapi" language domain.

Please see https://www.sphinx-doc.org/en/master/usage/domains/index.html
for more information.

This stub doesn't really do anything yet, we'll get to it brick-by-brick
in the forthcoming commits to keep the series breezy and the git history
informative.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py               |  9 +++++-
 docs/sphinx/qapi_domain.py | 56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 docs/sphinx/qapi_domain.py

diff --git a/docs/conf.py b/docs/conf.py
index 31bb9a37893..49d9de894c0 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -60,7 +60,14 @@
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile', 'qapidoc']
+extensions = [
+    'depfile',
+    'hxtool',
+    'kerneldoc',
+    'qapi_domain',
+    'qapidoc',
+    'qmp_lexer',
+]
 
 if sphinx.version_info[:3] > (4, 0, 0):
     tags.add('sphinx4')
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
new file mode 100644
index 00000000000..a1983d94440
--- /dev/null
+++ b/docs/sphinx/qapi_domain.py
@@ -0,0 +1,56 @@
+"""
+QAPI domain extension.
+"""
+
+from __future__ import annotations
+
+from typing import (
+    TYPE_CHECKING,
+    AbstractSet,
+    Any,
+    Dict,
+    Tuple,
+)
+
+from sphinx.domains import Domain, ObjType
+from sphinx.util import logging
+
+
+if TYPE_CHECKING:
+    from sphinx.application import Sphinx
+
+logger = logging.getLogger(__name__)
+
+
+class QAPIDomain(Domain):
+    """QAPI language domain."""
+
+    name = "qapi"
+    label = "QAPI"
+
+    object_types: Dict[str, ObjType] = {}
+    directives = {}
+    roles = {}
+    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {}
+    indices = []
+
+    def merge_domaindata(
+        self, docnames: AbstractSet[str], otherdata: Dict[str, Any]
+    ) -> None:
+        pass
+
+    def resolve_any_xref(self, *args: Any, **kwargs: Any) -> Any:
+        # pylint: disable=unused-argument
+        return []
+
+
+def setup(app: Sphinx) -> Dict[str, Any]:
+    app.setup_extension("sphinx.directives")
+    app.add_domain(QAPIDomain)
+
+    return {
+        "version": "1.0",
+        "env_version": 1,
+        "parallel_read_safe": True,
+        "parallel_write_safe": True,
+    }
-- 
2.48.1


