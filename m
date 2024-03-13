Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A39C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 04:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGRC-0007yt-8x; Wed, 13 Mar 2024 00:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQu-0007uH-E7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQo-0001qM-Rk
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710304894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaWfQ1rC9x4SKVgGa0KB8I8w8nJlBnOhw3104wyGhp8=;
 b=iU1wv55HSftj4AV2L6wlkzwoUDK1BB9fw/m4jVFFz34EiihnBCmHbBPcphWBl1qXQvXxwB
 WAVH1S7imENp3HRbAPOc5omehMpIfjf+MVoO9siIu9Ai85qojwufX8m6dA/RavD+2ZNOio
 41UtmATdC/yZoU5Zfp3GzHQHHD850jg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-s2BFxgcmOoKpn6vnTl3K2w-1; Wed, 13 Mar 2024 00:41:30 -0400
X-MC-Unique: s2BFxgcmOoKpn6vnTl3K2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B913185A786;
 Wed, 13 Mar 2024 04:41:30 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0C9410E4B;
 Wed, 13 Mar 2024 04:41:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 04/23] qapi/schema: add pylint suppressions
Date: Wed, 13 Mar 2024 00:41:08 -0400
Message-ID: <20240313044127.49089-5-jsnow@redhat.com>
In-Reply-To: <20240313044127.49089-1-jsnow@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 8ba5665bc68..117f0f78f0c 100644
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
@@ -113,6 +116,7 @@ def is_implicit(self):
         return not self.info
 
     def visit(self, visitor):
+        # pylint: disable=unused-argument
         assert self._checked
 
     def describe(self):
@@ -131,6 +135,7 @@ def visit_module(self, name):
         pass
 
     def visit_needed(self, entity):
+        # pylint: disable=unused-argument
         # Default to visiting everything
         return True
 
-- 
2.44.0


