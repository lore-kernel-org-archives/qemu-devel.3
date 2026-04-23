Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0E1FDEE52
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG26X-0005jN-CK; Thu, 23 Apr 2026 18:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26U-0005if-OD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26S-0005oL-Q1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776981656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJwsAHqVNyKJNf+9t90voerKf684uX/eo0z3dIcCjdA=;
 b=dR83mil9PjrH4NVqQS9GpPB0Gg6HFBzRKWOaZhECPK26IPLIx0JN6jAOHA6nRErIsQ7/b/
 6tR3RmSc55X21qwqw/iusOEecNTFfGdeIX5/rztAeLB7ytRPovdRKHb9WI/cSZ31NWu9Q3
 APfx3/O//bkaOtn0tuUtekrGMSl5RO8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-YgNc6UtWOX6AobcM3Y2MVQ-1; Thu,
 23 Apr 2026 18:00:52 -0400
X-MC-Unique: YgNc6UtWOX6AobcM3Y2MVQ-1
X-Mimecast-MFC-AGG-ID: YgNc6UtWOX6AobcM3Y2MVQ_1776981651
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E78E18004AD; Thu, 23 Apr 2026 22:00:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10D393007572; Thu, 23 Apr 2026 22:00:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH 07/12] qapi/docs: add "Intro" section parsing
Date: Thu, 23 Apr 2026 18:00:16 -0400
Message-ID: <20260423220022.2180059-8-jsnow@redhat.com>
In-Reply-To: <20260423220022.2180059-1-jsnow@redhat.com>
References: <20260423220022.2180059-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add parsing for explicit Intro section syntax.

A side effect of this patch is that we will always create an empty Intro
section, similar to how we used to have an empty Plain section. The
tests are adjusted accordingly, rendered document output does not change
at all.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst            | 17 +++++----
 scripts/qapi/parser.py                  | 47 ++++++++++++++++++-------
 tests/qapi-schema/doc-good.out          | 18 ++++++++++
 tests/qapi-schema/doc-missing-colon.err |  2 +-
 4 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 3a632b4a648..a8175934d52 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -862,7 +862,7 @@ documentation comment.
 If the documentation comment starts like ::
 
     ##
-    # @SYMBOL:
+    # @SYMBOL: [...]
 
 it documents the definition of SYMBOL, else it's free-form
 documentation.
@@ -984,11 +984,11 @@ definition it documents.
 When documentation is required (see pragma_ 'doc-required'), every
 definition must have documentation.
 
-Definition documentation starts with a line naming the definition,
-followed by an optional overview, a description of each argument (for
-commands and events), member (for structs and unions), branch (for
-alternates), or value (for enums), a description of each feature (if
-any), and finally optional tagged sections.
+Definition documentation starts with a description naming the definition
+with an optional overview, a description of each argument (for commands
+and events), member (for structs and unions), branch (for alternates),
+or value (for enums), a description of each feature (if any), and
+finally optional tagged sections.
 
 Descriptions start with '\@name:'.  The description text must be
 indented like this::
@@ -996,6 +996,11 @@ indented like this::
  # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
  #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
 
+Definition descriptions are special: the optional introductory overview
+describing the definition will not be inlined when referenced by other
+definitions (such as when using 'base' to include members from another
+definition), while other descriptions and tagged sections will be.
+
 .. FIXME The parser accepts these things in almost any order.
 
 .. FIXME union branches should be described, too.
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 6612f471bb8..c23fd26aaa7 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -24,6 +24,7 @@
     Match,
     Optional,
     Set,
+    Tuple,
     Union,
 )
 
@@ -524,6 +525,30 @@ def get_doc_paragraph(self, doc: 'QAPIDoc') -> Optional[str]:
                 return line
             doc.append_line(line)
 
+    def _get_doc_intro(
+        self,
+        line: str,
+        info: QAPISourceInfo
+    ) -> Tuple['QAPIDoc', Optional[str]]:
+        match = self._match_at_name_colon(line)
+        if not match:
+            raise QAPIParseError(self, "@name must end with ':'")
+
+        # Invalid names are not checked here, but the name
+        # provided *must* match the following definition,
+        # which *is* validated in expr.py.
+        symbol = match.group(1)
+        if not symbol:
+            raise QAPIParseError(self, "name required after '@'")
+        doc = QAPIDoc(info, symbol)
+
+        doc.ensure_untagged_section(info, QAPIDoc.Kind.INTRO)
+        text = line[match.end():]
+        if text:
+            doc.append_line(text)
+
+        return doc, self.get_doc_indented(doc)
+
     def get_doc(self) -> 'QAPIDoc':
         if self.val != '##':
             raise QAPIParseError(
@@ -532,18 +557,9 @@ def get_doc(self) -> 'QAPIDoc':
         self.accept(False)
         line = self.get_doc_line()
         if line is not None and line.startswith('@'):
+
             # Definition documentation
-            if not line.endswith(':'):
-                raise QAPIParseError(self, "line should end with ':'")
-            # Invalid names are not checked here, but the name
-            # provided *must* match the following definition,
-            # which *is* validated in expr.py.
-            symbol = line[1:-1]
-            if not symbol:
-                raise QAPIParseError(self, "name required after '@'")
-            doc = QAPIDoc(info, symbol)
-            self.accept(False)
-            line = self.get_doc_line()
+            doc, line = self._get_doc_intro(line, info)
             no_more_args = False
 
             while line is not None:
@@ -751,8 +767,13 @@ def end(self) -> None:
                 raise QAPISemError(
                     section.info, "text required after '%s:'" % section.kind)
 
-    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
-        kind = QAPIDoc.Kind.PLAIN
+    def ensure_untagged_section(
+        self,
+        info: QAPISourceInfo,
+        kind: Optional['QAPIDoc.Kind'] = None,
+    ) -> None:
+        if kind is None:
+            kind = QAPIDoc.Kind.PLAIN
 
         if self.all_sections and self.all_sections[-1].kind == kind:
             # extend current section
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 6fcc8175cfe..bc89853765f 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -106,6 +106,8 @@ Examples:
 - *verbatim*
 - {braces}
 doc symbol=Enum
+    section=Intro
+
     arg=one
 The _one_ {and only}, description on the same line
     arg=two
@@ -117,10 +119,14 @@ a member feature
     section=Plain
 @two is undocumented
 doc symbol=Base
+    section=Intro
+
     arg=base1
  description starts on a new line,
  minimally indented
 doc symbol=Variant1
+    section=Intro
+
     section=Plain
 A paragraph
 
@@ -134,10 +140,16 @@ a feature
     feature=member-feat
 a member feature
 doc symbol=Variant2
+    section=Intro
+
 doc symbol=Object
+    section=Intro
+
     feature=union-feat1
 a feature
 doc symbol=Alternate
+    section=Intro
+
     arg=i
 description starts on the same line
     remainder indented the same
@@ -151,6 +163,8 @@ doc freeform
 Another subsection
 ==================
 doc symbol=cmd
+    section=Intro
+
     arg=arg1
     description starts on a new line,
     indented
@@ -198,6 +212,8 @@ Note::
     section=Since
 2.10
 doc symbol=cmd-boxed
+    section=Intro
+
     section=Plain
 If you're bored enough to read this, go see a video of boxed cats
     feature=cmd-feat1
@@ -211,5 +227,7 @@ another feature
 
    <- ... has no title ...
 doc symbol=EVT_BOXED
+    section=Intro
+
     feature=feat3
 a feature
diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schema/doc-missing-colon.err
index cbcea007153..bd5862b30f3 100644
--- a/tests/qapi-schema/doc-missing-colon.err
+++ b/tests/qapi-schema/doc-missing-colon.err
@@ -1 +1 @@
-doc-missing-colon.json:4:1: line should end with ':'
+doc-missing-colon.json:4:1: @name must end with ':'
-- 
2.53.0


