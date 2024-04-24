Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8EDC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXpE-0001J1-CZ; Wed, 24 Apr 2024 04:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoc-0000Lm-HM
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoa-0006MB-92
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNjgmhzSB7f+n+iWYXPzQcQrVJoZVSDzsuVJvF8EmrU=;
 b=K7e2SBni1a3lnmIM40BQT4Rydv+0deBTrEiR62kN6IroEhBjrx4HlJIpvtCY0aO785BNvw
 qyWN1syyDZTsNnJEdaxBy7YCIlcby6QVuK4UI8iCaklY7m7l7FkGIUBHjjY91SF8eI6XKM
 t/Ix6FYTTkFW3o0GtYGQ0h3yHyhjwo0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-MrsGbSbxO_yJ91MAC4Uiwg-1; Wed,
 24 Apr 2024 04:17:12 -0400
X-MC-Unique: MrsGbSbxO_yJ91MAC4Uiwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDF8E1C05AA0;
 Wed, 24 Apr 2024 08:17:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF0AF44047;
 Wed, 24 Apr 2024 08:17:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEF6621E669C; Wed, 24 Apr 2024 10:17:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 04/25] qapi/schema: add pylint suppressions
Date: Wed, 24 Apr 2024 10:16:49 +0200
Message-ID: <20240424081710.2907748-5-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

From: John Snow <jsnow@redhat.com>

With this patch, pylint is happy with the file, so enable it in the
configuration.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240315152301.3621858-5-armbru@redhat.com>
---
 scripts/qapi/pylintrc  | 5 -----
 scripts/qapi/schema.py | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index 1342412c3c..c028a1f9f5 100644
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
index 8ba5665bc6..117f0f78f0 100644
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


