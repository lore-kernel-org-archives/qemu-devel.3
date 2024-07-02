Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01FFC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 19:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjeu-0007dK-5q; Tue, 02 Jul 2024 15:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOjeq-0007Vt-OX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOjem-0008NB-0N
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719950353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Vh+AvXbys9BnSQdGfQjFfKkDpfemI4LniCYktbIwqo=;
 b=QrT0HLtaFDNbkM6G1bSI6rzpiGWRHKvtKtISGU+eX/vLnK8vOZwojQWORB/IDPe6AvYxDL
 n03mpL08rN/v1d9kquxFD181CT+ZmpZTyMoB0PGNC4My2Hw4/UjbZvLaTvby3ChlZ8wK5f
 ECo85zi6xWEQXQrLJlJ2nm1PKyM0uxE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-q4Lt0JB1OBm49Dthgfyd_Q-1; Tue,
 02 Jul 2024 15:59:09 -0400
X-MC-Unique: q4Lt0JB1OBm49Dthgfyd_Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BFD419560B6; Tue,  2 Jul 2024 19:59:08 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DD853000603; Tue,  2 Jul 2024 19:59:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 1/2] Python: bump minimum sphinx version to 3.4.3
Date: Tue,  2 Jul 2024 15:59:02 -0400
Message-ID: <20240702195903.204007-2-jsnow@redhat.com>
In-Reply-To: <20240702195903.204007-1-jsnow@redhat.com>
References: <20240702195903.204007-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

With RHEL 8 support retired (It's been two years today since RHEL 9
came out), our very oldest build platform version of Sphinx is now
3.4.3; and keeping backwards compatibility for versions as old as v1.6
when using domain extensions is a lot of work we don't need to do.

This patch is motivated by my work creating a new QAPI domain, which
unlike the dbus documentation, cannot be allowed to regress by creating
a "dummy" doc. Easier is to improve our minimum version as far as we can
push it forwards, reducing my burden in creating cross-compatibility
hacks and patches.

A sampling of sphinx versions from various distributions, courtesy
https://repology.org/project/python:sphinx/versions

Alpine 3.16: v4.3.0 (QEMU support ended 2024-05-23)
Alpine 3.17: v5.3.0
Alpine 3.18: v6.1.3
Alpine 3.19: v6.2.1
Ubuntu 20.04 LTS: EOL
Ubuntu 22.04 LTS: v4.3.2
Ubuntu 22.10: EOL
Ubuntu 23.04: EOL
Ubuntu 23.10: v5.3.0
Ubuntu 24.04 LTS: v7.2.6
Debian 11: v3.4.3 (QEMU support ends 2024-07-xx)
Debian 12: v5.3.0
Fedora 38: EOL
Fedora 39: v6.2.1
Fedora 40: v7.2.6
CentOS Stream 8: v1.7.6 (QEMU support ended 2024-05-17)
CentOS Stream 9: v3.4.3
OpenSUSE Leap 15.4: EOL
OpenSUSE Leap 15.5: 2.3.1, 4.2.0 and 7.2.6

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py           |  7 +++----
 docs/sphinx/qapidoc.py | 29 +++--------------------------
 pythondeps.toml        |  2 +-
 3 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index aae0304ac6e..876f6768815 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -53,10 +53,9 @@
 
 # If your documentation needs a minimal Sphinx version, state it here.
 #
-# Sphinx 1.5 and earlier can't build our docs because they are too
-# picky about the syntax of the argument to the option:: directive
-# (see Sphinx bugs #646, #3366).
-needs_sphinx = '1.6'
+# 3.4.3 is the oldest version of Sphinx that ships on a platform we
+# pledge build support for.
+needs_sphinx = '3.4.3'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
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
diff --git a/pythondeps.toml b/pythondeps.toml
index 9c16602d303..bc656376caa 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -23,7 +23,7 @@ meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
+sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 
 [avocado]
-- 
2.45.0


