Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1C5C3601E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 13:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3wwA-0000rq-TO; Sun, 13 Apr 2025 08:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1u3ww7-0000rD-Th; Sun, 13 Apr 2025 08:59:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1u3ww5-0007tj-Jf; Sun, 13 Apr 2025 08:59:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 542C2116A4D;
 Sun, 13 Apr 2025 15:57:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E1E4F1EEE7A;
 Sun, 13 Apr 2025 15:59:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D051E58523; Sun, 13 Apr 2025 15:59:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Weil via <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/3] docs: Fix some typos (found by codespell and typos)
Date: Sun, 13 Apr 2025 15:59:35 +0300
Message-Id: <20250413125937.2448971-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250413125937.2448971-1-mjt@tls.msk.ru>
References: <20250413125937.2448971-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Stefan Weil via <qemu-trivial@nongnu.org>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/about/deprecated.rst  | 4 ++--
 docs/devel/codebase.rst    | 6 +++---
 docs/devel/qapi-domain.rst | 4 ++--
 include/exec/memory.h      | 4 ++--
 qapi/qdev.json             | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0f41a99c67..05381441a9 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -452,7 +452,7 @@ Backend ``memory`` (since 9.0)
 ``reconnect`` (since 9.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^
 
-The ``reconnect`` option only allows specifiying second granularity timeouts,
+The ``reconnect`` option only allows specifying second granularity timeouts,
 which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 
 
@@ -462,7 +462,7 @@ Net device options
 Stream ``reconnect`` (since 9.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-The ``reconnect`` option only allows specifiying second granularity timeouts,
+The ``reconnect`` option only allows specifying second granularity timeouts,
 which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 
 VFIO device options
diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 1b09953197..ef98578296 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -5,7 +5,7 @@ Codebase
 This section presents the various parts of QEMU and how the codebase is
 organized.
 
-Beyond giving succint descriptions, the goal is to offer links to various
+Beyond giving succinct descriptions, the goal is to offer links to various
 parts of the documentation/codebase.
 
 Subsystems
@@ -67,7 +67,7 @@ yet, so sometimes the source code is all you have.
 * `chardev <https://gitlab.com/qemu-project/qemu/-/tree/master/chardev>`_:
   Various backends used by char devices.
 * `common-user <https://gitlab.com/qemu-project/qemu/-/tree/master/common-user>`_:
-  User-mode assembly code for dealing with signals occuring during syscalls.
+  User-mode assembly code for dealing with signals occurring during syscalls.
 * `configs <https://gitlab.com/qemu-project/qemu/-/tree/master/configs>`_:
   Makefiles defining configurations to build QEMU.
 * `contrib <https://gitlab.com/qemu-project/qemu/-/tree/master/contrib>`_:
@@ -102,7 +102,7 @@ yet, so sometimes the source code is all you have.
 * `.gitlab-ci.d <https://gitlab.com/qemu-project/qemu/-/tree/master/.gitlab-ci.d>`_:
   `CI <ci>` yaml and scripts.
 * `include <https://gitlab.com/qemu-project/qemu/-/tree/master/include>`_:
-  All headers associated to different subsystems in QEMU. The hierachy used
+  All headers associated to different subsystems in QEMU. The hierarchy used
   mirrors source code organization and naming.
 * `hw <https://gitlab.com/qemu-project/qemu/-/tree/master/hw>`_:
   `Devices <device-emulation>` and boards emulation. Devices are categorized by
diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index a748529f51..11238723c2 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -41,7 +41,7 @@ Schema or generating documentation from code that exists. It is merely
 the rST syntax used to describe things. For instance, the Sphinx Python
 domain adds syntax like ``:py:func:`` for describing Python functions in
 documentation, but it's the autodoc module that is responsible for
-reading python code and generating such syntax. QAPI is analagous here:
+reading Python code and generating such syntax. QAPI is analogous here:
 qapidoc.py is responsible for reading the QAPI Schema and generating rST
 syntax, and qapi_domain.py is responsible for translating that special
 syntax and providing APIs for Sphinx internals.
@@ -514,7 +514,7 @@ the definition's "fully qualified name", allowing two different
 namespaces to create an otherwise identically named definition.
 
 This directive also influences how reference resolution works for any
-references that do not explicity specify a namespace, so this directive
+references that do not explicitly specify a namespace, so this directive
 can be used to nudge references into preferring targets from within that
 namespace.
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index d09af58c97..e1c196a0c2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2162,7 +2162,7 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size);
  * only useful on RAM regions.
  *
  * @mr: the region being updated.
- * @readonly: whether rhe region is to be ROM or RAM.
+ * @readonly: whether the region is to be ROM or RAM.
  */
 void memory_region_set_readonly(MemoryRegion *mr, bool readonly);
 
@@ -2173,7 +2173,7 @@ void memory_region_set_readonly(MemoryRegion *mr, bool readonly);
  * only useful on RAM regions.
  *
  * @mr: the region being updated.
- * @nonvolatile: whether rhe region is to be non-volatile.
+ * @nonvolatile: whether the region is to be non-volatile.
  */
 void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
 
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 25cbcf977b..32c7d10046 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -173,7 +173,7 @@
 # configuration changed.
 #
 # The command may be used to notify the guest about block device
-# capcity change.  Currently only vhost-user-blk device supports
+# capacity change.  Currently only vhost-user-blk device supports
 # this.
 #
 # @id: the device's ID or QOM path
-- 
2.39.5


