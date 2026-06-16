Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C642ECD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUbq-0001TD-F3; Tue, 16 Jun 2026 10:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbW-0001PP-Hu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbU-0003yh-Fk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781619443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFBl/N/U5ONcQNOCiC7Th4dffQSPKPn7UX5JIC8u6kg=;
 b=eRKPaohgXfWTQ13wNMuh/sBYTc/LfU7H8tFlLiIb8N/oweT3fVMdZDfmE8uqIfXksp0rZl
 56PEwm2V/jgKB3VBmrD7BRQmHCynU1AA79llRPjSjgI3NIUlyjeAq7pvSywy/HKBieLYuH
 Pu0e/cbfTzHSVKT6RHq2cMtF0lY24SM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-P5WZDWdNP8OzVi3n_lVmYA-1; Tue,
 16 Jun 2026 10:17:22 -0400
X-MC-Unique: P5WZDWdNP8OzVi3n_lVmYA-1
X-Mimecast-MFC-AGG-ID: P5WZDWdNP8OzVi3n_lVmYA_1781619441
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2208619539A7
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4F3918005AE
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6E30421E6A36; Tue, 16 Jun 2026 16:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 12/14] qapi: remove implicit doc comment Plain section
Date: Tue, 16 Jun 2026 16:17:13 +0200
Message-ID: <20260616141715.2974467-13-armbru@redhat.com>
In-Reply-To: <20260616141715.2974467-1-armbru@redhat.com>
References: <20260616141715.2974467-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prior to this patch, we always create an empty Plain section. Removing
this allows us to gradually phase out the "Plain" section in favor of
"Intro" and "Details" sections while keeping "Plain" around for the
interim churn during the series - meaning that we don't actually know
at __init__ time which type of section we'll have first.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260611042332.482979-12-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py         |  4 +---
 tests/qapi-schema/doc-good.out | 14 --------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 09720a2c27..b7a7b9465a 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -730,9 +730,7 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # definition doc's symbol, None for free-form doc
         self.symbol: Optional[str] = symbol
         # the sections in textual order
-        self.all_sections: List[QAPIDoc.Section] = [
-            QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
-        ]
+        self.all_sections: List[QAPIDoc.Section] = []
         # dicts mapping parameter/feature names to their description
         self._args: Dict[str, QAPIDoc.ArgSection] = {}
         self._features: Dict[str, QAPIDoc.ArgSection] = {}
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index b9829e2f84..16f4422177 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -106,8 +106,6 @@ Examples:
 - *verbatim*
 - {braces}
 doc symbol=Enum
-    Plain
-
     Member=one
 The _one_ {and only}, description on the same line
     Member=two
@@ -119,8 +117,6 @@ a member feature
     Plain
 @two is undocumented
 doc symbol=Base
-    Plain
-
     Member=base1
  description starts on a new line,
  minimally indented
@@ -138,16 +134,10 @@ a feature
     Feature=member-feat
 a member feature
 doc symbol=Variant2
-    Plain
-
 doc symbol=Object
-    Plain
-
     Feature=union-feat1
 a feature
 doc symbol=Alternate
-    Plain
-
     Member=i
 description starts on the same line
     remainder indented the same
@@ -161,8 +151,6 @@ doc freeform
 Another subsection
 ==================
 doc symbol=cmd
-    Plain
-
     Member=arg1
     description starts on a new line,
     indented
@@ -223,7 +211,5 @@ another feature
 
    <- ... has no title ...
 doc symbol=EVT_BOXED
-    Plain
-
     Feature=feat3
 a feature
-- 
2.54.0


