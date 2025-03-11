Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E729C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrD-0003bf-RB; Tue, 11 Mar 2025 07:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqY-0003ER-SD
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq9-0006WT-Ja
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LP5sw2f1gov5R484H/AB6Qo7wnA0cFD7EU7BInj2rnE=;
 b=YVUTfA8TwnFqk9QSHxL2J9R9CB/71IGMq0R6+pkqw00659kCu82zj+Z6sB7F0binBQXZLK
 REtJ1b6pXi/ExHYCc810f9UVCDMgAgjXxn7FFkW8BKSDb+9SaXt/yfaxoJhYT8L4iWW3Vl
 z+NsnOklj5lkHKbqtUn7S/G44EY9iuo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-Yh0xqGH3PqWAos6jFn5PFg-1; Tue,
 11 Mar 2025 07:31:58 -0400
X-MC-Unique: Yh0xqGH3PqWAos6jFn5PFg-1
X-Mimecast-MFC-AGG-ID: Yh0xqGH3PqWAos6jFn5PFg_1741692718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E75E11955BC6
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AD6F195608F
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 493BD21E61B7; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 36/61] docs/qapidoc: add transmogrifier class stub
Date: Tue, 11 Mar 2025 12:31:12 +0100
Message-ID: <20250311113137.1277125-37-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Add the beginnings of the Transmogrifier class by adding the rST
conversion helpers that will be used to build the virtual rST document.

This version of the class does not actually "do anything" yet; each
individual feature is added one-at-a-time in the forthcoming commits.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-40-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 73 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5246832b68..c243bb6faa 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -26,14 +26,17 @@
 
 from __future__ import annotations
 
+from contextlib import contextmanager
 import os
 import sys
 from typing import TYPE_CHECKING
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
+from docutils.statemachine import StringList
 from qapi.error import QAPIError
 from qapi.schema import QAPISchema, QAPISchemaVisitor
+from qapi.source import QAPISourceInfo
 
 from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
 from sphinx import addnodes
@@ -44,9 +47,12 @@
 
 
 if TYPE_CHECKING:
-    from typing import Any, List, Sequence
-
-    from docutils.statemachine import StringList
+    from typing import (
+        Any,
+        Generator,
+        List,
+        Sequence,
+    )
 
     from sphinx.application import Sphinx
     from sphinx.util.typing import ExtensionMetadata
@@ -55,6 +61,67 @@
 __version__ = "1.0"
 
 
+class Transmogrifier:
+    def __init__(self) -> None:
+        self._result = StringList()
+        self.indent = 0
+
+    # General-purpose rST generation functions
+
+    def get_indent(self) -> str:
+        return "   " * self.indent
+
+    @contextmanager
+    def indented(self) -> Generator[None]:
+        self.indent += 1
+        try:
+            yield
+        finally:
+            self.indent -= 1
+
+    def add_line_raw(self, line: str, source: str, *lineno: int) -> None:
+        """Append one line of generated reST to the output."""
+
+        # NB: Sphinx uses zero-indexed lines; subtract one.
+        lineno = tuple((n - 1 for n in lineno))
+
+        if line.strip():
+            # not a blank line
+            self._result.append(
+                self.get_indent() + line.rstrip("\n"), source, *lineno
+            )
+        else:
+            self._result.append("", source, *lineno)
+
+    def add_line(self, content: str, info: QAPISourceInfo) -> None:
+        # NB: We *require* an info object; this works out OK because we
+        # don't document built-in objects that don't have
+        # one. Everything else should.
+        self.add_line_raw(content, info.fname, info.line)
+
+    def add_lines(
+        self,
+        content: str,
+        info: QAPISourceInfo,
+    ) -> None:
+        lines = content.splitlines(True)
+        for i, line in enumerate(lines):
+            self.add_line_raw(line, info.fname, info.line + i)
+
+    def ensure_blank_line(self) -> None:
+        # Empty document -- no blank line required.
+        if not self._result:
+            return
+
+        # Last line isn't blank, add one.
+        if self._result[-1].strip():  # pylint: disable=no-member
+            fname, line = self._result.info(-1)
+            assert isinstance(line, int)
+            # New blank line is credited to one-after the current last line.
+            # +2: correct for zero/one index, then increment by one.
+            self.add_line_raw("", fname, line + 2)
+
+
 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     """A QAPI schema visitor which adds Sphinx dependencies each module
 
-- 
2.48.1


