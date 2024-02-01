Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0315DC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 22:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVfm6-0006FG-HY; Thu, 01 Feb 2024 17:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflt-00069Q-NP
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflp-0006a2-4i
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706827373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbvVQRggaouWq3+WTtvTbyOSHBEZ4Cs7EA+H9kbnD5A=;
 b=GiVu357h0YLokmk9Z9sFwgB4i6jf7PWqDFYZJOkBz7lsnEtKT00MQ9a1WXcQY47//Nju/J
 D6i0CTX4QVx3ilh/XMWRay6cL+pM84x9hTd0Y7/iVfpjzGJECtqIgvlHaSJK3XSxvmJd4W
 TiCigK+vKDSKHj934I/NKMum4zu+wLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-kccGcPnzPOuTReD8ghfHYg-1; Thu, 01 Feb 2024 17:42:51 -0500
X-MC-Unique: kccGcPnzPOuTReD8ghfHYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 293CD185A782;
 Thu,  1 Feb 2024 22:42:51 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F182C2166B34;
 Thu,  1 Feb 2024 22:42:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 02/20] qapi/schema: add pylint suppressions
Date: Thu,  1 Feb 2024 17:42:28 -0500
Message-ID: <20240201224246.39480-3-jsnow@redhat.com>
In-Reply-To: <20240201224246.39480-1-jsnow@redhat.com>
References: <20240201224246.39480-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With this patch, pylint is happy with the file, so enable it in the
configuration.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/pylintrc  | 5 -----
 scripts/qapi/schema.py | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index 1342412c3cf..c028a1f9f51 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -1,10 +1,5 @@
 [MASTER]
 
-# Add files or directories matching the regex patterns to the ignore list.
-# The regex matches against base names, not paths.
-ignore-patterns=schema.py,
-
-
 [MESSAGES CONTROL]
 
 # Disable the message, report, category or checker with the given id(s). You
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 6a836950a9a..b7830672e57 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -12,6 +12,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+# pylint: disable=too-many-lines
+
 # TODO catching name collisions in generated code would be nice
 
 from collections import OrderedDict
@@ -83,6 +85,7 @@ def c_name(self):
         return c_name(self.name)
 
     def check(self, schema):
+        # pylint: disable=unused-argument
         assert not self._checked
         seen = {}
         for f in self.features:
@@ -117,6 +120,7 @@ def is_implicit(self):
         return not self.info
 
     def visit(self, visitor):
+        # pylint: disable=unused-argument
         assert self._checked
 
     def describe(self):
@@ -135,6 +139,7 @@ def visit_module(self, name):
         pass
 
     def visit_needed(self, entity):
+        # pylint: disable=unused-argument
         # Default to visiting everything
         return True
 
-- 
2.43.0


