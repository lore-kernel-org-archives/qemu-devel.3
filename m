Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE14CD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUc2-0001UV-Nu; Tue, 16 Jun 2026 10:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbX-0001Qi-Uw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbV-0003zI-SU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781619444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98qCAa40b2WRoqkSDRJEiAfNrGQZ3fKQ3kKQj22kUvY=;
 b=HJeWWGHYL1snDlmqzwgZ0+oGXNtUVPS99wKEa45ntoac86e5WrLe7k2sddRijAzmGpXlDU
 KGN/1NBHvcZY/ICnXlJeaYgxnfrfVTcXxL7NqAEcmbu+EBhofsgF/XMs8mIFAX4xjb6ps3
 PPvzYrCQa6uG/RV3jEoUQN+suz8iUL8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-CX6qRwv9Pr2rgH5QU4pe9w-1; Tue,
 16 Jun 2026 10:17:22 -0400
X-MC-Unique: CX6qRwv9Pr2rgH5QU4pe9w-1
X-Mimecast-MFC-AGG-ID: CX6qRwv9Pr2rgH5QU4pe9w_1781619442
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06FC21955F56
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74860364CC
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7624621E6A3C; Tue, 16 Jun 2026 16:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 14/14] qapi: add doc comment "Intro" section parsing
Date: Tue, 16 Jun 2026 16:17:15 +0200
Message-ID: <20260616141715.2974467-15-armbru@redhat.com>
In-Reply-To: <20260616141715.2974467-1-armbru@redhat.com>
References: <20260616141715.2974467-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Add parsing for explicit Intro section syntax.

A side effect of this patch is that we will (currently) always create
an empty Intro section, similar to how we used to have an empty Plain
section. The tests are adjusted accordingly, rendered document output
does not change at all.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260611042332.482979-14-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst   | 16 +++++++---------
 scripts/qapi/parser.py         |  4 ++--
 tests/qapi-schema/doc-good.out | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 3a632b4a64..b1cc5b5f0d 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -984,11 +984,11 @@ definition it documents.
 When documentation is required (see pragma_ 'doc-required'), every
 definition must have documentation.
 
-Definition documentation starts with a line naming the definition,
-followed by an optional overview, a description of each argument (for
-commands and events), member (for structs and unions), branch (for
-alternates), or value (for enums), a description of each feature (if
-any), and finally optional tagged sections.
+Definition documentation starts with a description naming the
+definition with an optional indented overview, a description of each
+argument (for commands and events), member (for structs and unions),
+branch (for alternates), or value (for enums), a description of each
+feature (if any), and finally optional tagged sections.
 
 Descriptions start with '\@name:'.  The description text must be
 indented like this::
@@ -1093,8 +1093,7 @@ Examples of complete definition documentation::
 
  ##
  # @BlockStats:
- #
- # Statistics of a virtual block device or a block backing device.
+ #     Statistics of a virtual block device or a block backing device.
  #
  # @device: If the stats are for a virtual block device, the name
  #     corresponding to the virtual block device.
@@ -1111,8 +1110,7 @@ Examples of complete definition documentation::
 
  ##
  # @query-blockstats:
- #
- # Query the @BlockStats for all virtual block devices.
+ #     Query the @BlockStats for all virtual block devices.
  #
  # @query-nodes: If true, the command will query all the block nodes
  #     ... explain, explain ...
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index b7a7b9465a..9e14c2f792 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -542,8 +542,8 @@ def get_doc(self) -> 'QAPIDoc':
             if not symbol:
                 raise QAPIParseError(self, "name required after '@'")
             doc = QAPIDoc(info, symbol)
-            self.accept(False)
-            line = self.get_doc_line()
+            doc.all_sections.append(QAPIDoc.Section(info, QAPIDoc.Kind.INTRO))
+            line = self.get_doc_indented(doc)
             no_more_args = False
 
             while line is not None:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 16f4422177..371dd25ffc 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -106,6 +106,8 @@ Examples:
 - *verbatim*
 - {braces}
 doc symbol=Enum
+    Intro
+
     Member=one
 The _one_ {and only}, description on the same line
     Member=two
@@ -117,10 +119,14 @@ a member feature
     Plain
 @two is undocumented
 doc symbol=Base
+    Intro
+
     Member=base1
  description starts on a new line,
  minimally indented
 doc symbol=Variant1
+    Intro
+
     Plain
 A paragraph
 
@@ -134,10 +140,16 @@ a feature
     Feature=member-feat
 a member feature
 doc symbol=Variant2
+    Intro
+
 doc symbol=Object
+    Intro
+
     Feature=union-feat1
 a feature
 doc symbol=Alternate
+    Intro
+
     Member=i
 description starts on the same line
     remainder indented the same
@@ -151,6 +163,8 @@ doc freeform
 Another subsection
 ==================
 doc symbol=cmd
+    Intro
+
     Member=arg1
     description starts on a new line,
     indented
@@ -198,6 +212,8 @@ Note::
     Since
 2.10
 doc symbol=cmd-boxed
+    Intro
+
     Plain
 If you're bored enough to read this, go see a video of boxed cats
     Feature=cmd-feat1
@@ -211,5 +227,7 @@ another feature
 
    <- ... has no title ...
 doc symbol=EVT_BOXED
+    Intro
+
     Feature=feat3
 a feature
-- 
2.54.0


