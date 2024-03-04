Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334CBC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1sh-0005bJ-2X; Mon, 04 Mar 2024 01:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sU-0005XV-Jm
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sR-00008X-An
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoerteqzZBJWDn5qrScOg6SAib2ZuH5H4VV8uCSj2Xw=;
 b=ahWTYlHDyeOs9S0MgIkA5lKqKcc55A8lb38lTlsi990hRNSZ5soob+Xw3ffav3SBIceJ/5
 QLmmjzU0zv+oB3q0PI6qqT/+3rAeazNufuhi3uPGGOEJbdCSeFwPvcqHQvC0KBIG4Y9lKu
 jKpsibO396yBs91pSTMfmMWVqZIXdKQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-wQk1LFeXORir5QTyX4KVfw-1; Mon,
 04 Mar 2024 01:32:38 -0500
X-MC-Unique: wQk1LFeXORir5QTyX4KVfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 001F63C14941;
 Mon,  4 Mar 2024 06:32:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 944ED1121306;
 Mon,  4 Mar 2024 06:32:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7321621E692E; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 03/18] qapi: New documentation section tag "Errors"
Date: Mon,  4 Mar 2024 07:32:21 +0100
Message-ID: <20240304063236.213955-4-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

We use section "Returns" for documenting both success and error
response of commands.

I intend to generate better command success response documentation.
Easier when "Returns" documents just he success response.

Create new section tag "Errors".  The next two commits will move error
response documentation from "Returns" sections to "Errors" sections.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-4-armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst    |  6 +++++-
 scripts/qapi/parser.py          | 23 +++++++++++++++++------
 tests/qapi-schema/doc-good.json |  2 ++
 tests/qapi-schema/doc-good.out  |  2 ++
 tests/qapi-schema/doc-good.txt  |  6 ++++++
 5 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 6804a4b596..f453bd3546 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -996,7 +996,8 @@ line "Features:", like this::
 
 A tagged section begins with a paragraph that starts with one of the
 following words: "Note:"/"Notes:", "Since:", "Example:"/"Examples:",
-"Returns:", "TODO:".  It ends with the start of a new section.
+"Returns:", "Errors:", "TODO:".  It ends with the start of a new
+section.
 
 The second and subsequent lines of tagged sections must be indented
 like this::
@@ -1007,6 +1008,9 @@ like this::
  #     Duis aute irure dolor in reprehenderit in voluptate velit esse
  #     cillum dolore eu fugiat nulla pariatur.
 
+"Returns" and "Errors" sections are only valid for commands.  They
+document the success and the error response, respectively.
+
 A "Since: x.y.z" tagged section lists the release that introduced the
 definition.
 
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index e4c2259e39..a32b2c7e7f 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -543,7 +543,7 @@ def get_doc(self) -> 'QAPIDoc':
                         line = self.get_doc_indented(doc)
                     no_more_args = True
                 elif match := re.match(
-                        r'(Returns|Since|Notes?|Examples?|TODO): *',
+                        r'(Returns|Errors|Since|Notes?|Examples?|TODO): *',
                         line):
                     # tagged section
                     doc.new_tagged_section(self.info, match.group(1))
@@ -639,8 +639,9 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # dicts mapping parameter/feature names to their description
         self.args: Dict[str, QAPIDoc.ArgSection] = {}
         self.features: Dict[str, QAPIDoc.ArgSection] = {}
-        # a command's "Returns" section
+        # a command's "Returns" and "Errors" section
         self.returns: Optional[QAPIDoc.Section] = None
+        self.errors: Optional[QAPIDoc.Section] = None
         # "Since" section
         self.since: Optional[QAPIDoc.Section] = None
         # sections other than .body, .args, .features
@@ -670,6 +671,11 @@ def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
                 raise QAPISemError(
                     info, "duplicated '%s' section" % tag)
             self.returns = section
+        elif tag == 'Errors':
+            if self.errors:
+                raise QAPISemError(
+                    info, "duplicated '%s' section" % tag)
+            self.errors = section
         elif tag == 'Since':
             if self.since:
                 raise QAPISemError(
@@ -715,10 +721,15 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
         self.features[feature.name].connect(feature)
 
     def check_expr(self, expr: QAPIExpression) -> None:
-        if self.returns and 'command' not in expr:
-            raise QAPISemError(
-                self.returns.info,
-                "'Returns' section is only valid for commands")
+        if 'command' not in expr:
+            if self.returns:
+                raise QAPISemError(
+                    self.returns.info,
+                    "'Returns' section is only valid for commands")
+            if self.errors:
+                raise QAPISemError(
+                    self.returns.info,
+                    "'Errors' section is only valid for commands")
 
     def check(self) -> None:
 
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 5bb2b69071..de38a386e8 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -159,6 +159,8 @@
 #
 # Returns: @Object
 #
+# Errors: some
+#
 # TODO: frobnicate
 #
 # Notes:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 34ee74af4b..716a9a4102 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -173,6 +173,8 @@ another feature
 @arg3 is undocumented
     section=Returns
 @Object
+    section=Errors
+some
     section=TODO
 frobnicate
     section=Notes
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 879f6ff50a..847db70412 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -206,6 +206,12 @@ Returns
 "Object"
 
 
+Errors
+~~~~~~
+
+some
+
+
 Notes
 ~~~~~
 
-- 
2.44.0


