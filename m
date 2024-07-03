Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D16BC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP4A2-0003Gy-J1; Wed, 03 Jul 2024 13:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP49y-0003Fp-3y
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP49v-0001Fe-0Y
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720029164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4I2T2ZmkOf3dKAxZp55DRV8fPhtqB+VU98FEWUnYfyU=;
 b=ZMFvM7SnX9n3UA6DeMKtEfKdZJKBiNXOcu0rfGGrmgKPWvFDp6aQuOTIOKz+wTI6cTHRxi
 ycj+Jc+z3sv3tmFAHp74ZPoS+mXi6arhxz0O72zUTN2QsIfgYCihVJyC68LRg9OnYlW/OY
 YPHnQaIzbJ4xMfazOpTqvXfAFUwiMVU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-QijJW2V8Mt6KGnWvgMNDSA-1; Wed,
 03 Jul 2024 13:52:43 -0400
X-MC-Unique: QijJW2V8Mt6KGnWvgMNDSA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31C371955BC9; Wed,  3 Jul 2024 17:52:42 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.34.31])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C15CF1955BC0; Wed,  3 Jul 2024 17:52:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 2/2] docs: remove Sphinx 1.x compatibility code
Date: Wed,  3 Jul 2024 13:52:35 -0400
Message-ID: <20240703175235.239004-3-jsnow@redhat.com>
In-Reply-To: <20240703175235.239004-1-jsnow@redhat.com>
References: <20240703175235.239004-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

In general, the Use_SSI workaround is no longer needed, and neither is
the pre-1.6 logging shim for kerneldoc.

Signed-off-by: John Snow <jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/hxtool.py    | 21 ++++-----------------
 docs/sphinx/kerneldoc.py | 38 ++++++++++++--------------------------
 docs/sphinx/kernellog.py | 28 ----------------------------
 docs/sphinx/qapidoc.py   | 29 +++--------------------------
 4 files changed, 19 insertions(+), 97 deletions(-)
 delete mode 100644 docs/sphinx/kernellog.py

diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
index 3729084a36c..a84723be19e 100644
--- a/docs/sphinx/hxtool.py
+++ b/docs/sphinx/hxtool.py
@@ -24,16 +24,10 @@
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
 from sphinx.errors import ExtensionError
+from sphinx.util.docutils import switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 import sphinx
 
-# Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
-# use switch_source_input. Check borrowed from kerneldoc.py.
-Use_SSI = sphinx.__version__[:3] >= '1.7'
-if Use_SSI:
-    from sphinx.util.docutils import switch_source_input
-else:
-    from sphinx.ext.autodoc import AutodocReporter
 
 __version__ = '1.0'
 
@@ -185,16 +179,9 @@ def run(self):
     # of title_styles and section_level that kerneldoc.py does,
     # because nested_parse_with_titles() does that for us.
     def do_parse(self, result, node):
-        if Use_SSI:
-            with switch_source_input(self.state, result):
-                nested_parse_with_titles(self.state, result, node)
-        else:
-            save = self.state.memo.reporter
-            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
-            try:
-                nested_parse_with_titles(self.state, result, node)
-            finally:
-                self.state.memo.reporter = save
+        with switch_source_input(self.state, result):
+            nested_parse_with_titles(self.state, result, node)
+
 
 def setup(app):
     """ Register hxtool-doc directive with Sphinx"""
diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 72c403a7379..3aa972f2e89 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -38,20 +38,14 @@
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
 
-#
-# AutodocReporter is only good up to Sphinx 1.7
-#
 import sphinx
+from sphinx.util import logging
+from sphinx.util.docutils import switch_source_input
 
-Use_SSI = sphinx.__version__[:3] >= '1.7'
-if Use_SSI:
-    from sphinx.util.docutils import switch_source_input
-else:
-    from sphinx.ext.autodoc import AutodocReporter
-
-import kernellog
 
 __version__  = '1.0'
+logger = logging.getLogger('kerneldoc')
+
 
 class KernelDocDirective(Directive):
     """Extract kernel-doc comments from the specified file"""
@@ -111,8 +105,7 @@ def run(self):
         cmd += [filename]
 
         try:
-            kernellog.verbose(env.app,
-                              'calling kernel-doc \'%s\'' % (" ".join(cmd)))
+            logger.verbose('calling kernel-doc \'%s\'' % (" ".join(cmd)))
 
             p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
             out, err = p.communicate()
@@ -122,8 +115,10 @@ def run(self):
             if p.returncode != 0:
                 sys.stderr.write(err)
 
-                kernellog.warn(env.app,
-                               'kernel-doc \'%s\' failed with return code %d' % (" ".join(cmd), p.returncode))
+                logger.warning(
+                    'kernel-doc \'%s\' failed with return code %d' %
+                    (" ".join(cmd), p.returncode)
+                )
                 return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
             elif env.config.kerneldoc_verbosity > 0:
                 sys.stderr.write(err)
@@ -149,22 +144,13 @@ def run(self):
             return node.children
 
         except Exception as e:  # pylint: disable=W0703
-            kernellog.warn(env.app, 'kernel-doc \'%s\' processing failed with: %s' %
+            logger.warning('kernel-doc \'%s\' processing failed with: %s' %
                            (" ".join(cmd), str(e)))
             return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
 
     def do_parse(self, result, node):
-        if Use_SSI:
-            with switch_source_input(self.state, result):
-                self.state.nested_parse(result, 0, node, match_titles=1)
-        else:
-            save = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
-            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
-            self.state.memo.title_styles, self.state.memo.section_level = [], 0
-            try:
-                self.state.nested_parse(result, 0, node, match_titles=1)
-            finally:
-                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = save
+        with switch_source_input(self.state, result):
+            self.state.nested_parse(result, 0, node, match_titles=1)
 
 
 def setup(app):
diff --git a/docs/sphinx/kernellog.py b/docs/sphinx/kernellog.py
deleted file mode 100644
index af924f51a7d..00000000000
--- a/docs/sphinx/kernellog.py
+++ /dev/null
@@ -1,28 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Sphinx has deprecated its older logging interface, but the replacement
-# only goes back to 1.6.  So here's a wrapper layer to keep around for
-# as long as we support 1.4.
-#
-import sphinx
-
-if sphinx.__version__[:3] >= '1.6':
-    UseLogging = True
-    from sphinx.util import logging
-    logger = logging.getLogger('kerneldoc')
-else:
-    UseLogging = False
-
-def warn(app, message):
-    if UseLogging:
-        logger.warning(message)
-    else:
-        app.warn(message)
-
-def verbose(app, message):
-    if UseLogging:
-        logger.verbose(message)
-    else:
-        app.verbose(message)
-
-
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index f270b494f01..9a0cfcbce75 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -31,6 +31,7 @@
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
 from sphinx.errors import ExtensionError
+from sphinx.util.docutils import switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 import sphinx
 from qapi.gen import QAPISchemaVisitor
@@ -38,15 +39,6 @@
 from qapi.schema import QAPISchema
 
 
-# Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
-# use switch_source_input. Check borrowed from kerneldoc.py.
-Use_SSI = sphinx.__version__[:3] >= '1.7'
-if Use_SSI:
-    from sphinx.util.docutils import switch_source_input
-else:
-    from sphinx.ext.autodoc import AutodocReporter
-
-
 __version__ = '1.0'
 
 
@@ -517,23 +509,8 @@ def do_parse(self, rstlist, node):
         subheadings (titles) without confusing the rendering of
         anything else.
         """
-        # This is from kerneldoc.py -- it works around an API change in
-        # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
-        # sphinx.util.nodes.nested_parse_with_titles() rather than the
-        # plain self.state.nested_parse(), and so we can drop the saving
-        # of title_styles and section_level that kerneldoc.py does,
-        # because nested_parse_with_titles() does that for us.
-        if Use_SSI:
-            with switch_source_input(self.state, rstlist):
-                nested_parse_with_titles(self.state, rstlist, node)
-        else:
-            save = self.state.memo.reporter
-            self.state.memo.reporter = AutodocReporter(
-                rstlist, self.state.memo.reporter)
-            try:
-                nested_parse_with_titles(self.state, rstlist, node)
-            finally:
-                self.state.memo.reporter = save
+        with switch_source_input(self.state, rstlist):
+            nested_parse_with_titles(self.state, rstlist, node)
 
 
 def setup(app):
-- 
2.45.0


