Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE15BCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUbY-0001R6-Kp; Tue, 16 Jun 2026 10:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbW-0001Q1-Sq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbU-0003ya-J0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781619443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBpBjsEE2g+cwsPP1umyLpfeli8IdNVIxzIrnz1y72E=;
 b=DX8k4Tkf7CXiyRoaskEYp+6mIzhr6PNKI0WGbWus5jABHTRBTbIbgY9XEZvNYRlZTTGBoM
 JQCVZaIs07qxFwfgxqEcQ5Evdb1yRUJi7MJ0V1OJMemLzRKQyI/LKjBd/fEGS3YDUCD5k8
 DMVeqCEt7vTPO4ulVIYyDw4IGTtCdn0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-9qprcjbpP2u9DJNpZUf3Lw-1; Tue,
 16 Jun 2026 10:17:22 -0400
X-MC-Unique: 9qprcjbpP2u9DJNpZUf3Lw-1
X-Mimecast-MFC-AGG-ID: 9qprcjbpP2u9DJNpZUf3Lw_1781619441
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63D431956065
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 044D91954B09
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E0AB21E6A23; Tue, 16 Jun 2026 16:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 08/14] qapi: new doc comment "Intro" section
Date: Tue, 16 Jun 2026 16:17:09 +0200
Message-ID: <20260616141715.2974467-9-armbru@redhat.com>
In-Reply-To: <20260616141715.2974467-1-armbru@redhat.com>
References: <20260616141715.2974467-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

This patch adds an "Intro" doc section, intended to eventually replace
the "Plain" doc section alongside a forthcoming "Details" section.

For now, this section is not actually instantiated or used, but
subsequent patches will slowly convert the leading introductory sections
of QAPIDoc documentation to use this new section.

A main motivation of this series of changes is to more explicitly
delineate the "Introductory" documentation for each QAPI definition for
the sake of the inliner. When inlining members, examples, and details
from multiple QAPIDoc sections, we will want to omit the "Introductory"
text from inlined definitions while keeping notes, caution boxes,
examples, and so on. This new section facilitates that.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260611042332.482979-8-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 2 +-
 scripts/qapi/parser.py | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index c2f09bac16..1f7c15b707 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -368,7 +368,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
         for i, section in enumerate(sections):
             section.text = self.reformat_arobase(section.text)
 
-            if section.kind == QAPIDoc.Kind.PLAIN:
+            if section.kind.name in ("PLAIN", "INTRO"):
                 self.visit_paragraph(section)
             elif section.kind == QAPIDoc.Kind.MEMBER:
                 assert isinstance(section, QAPIDoc.ArgSection)
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index d8068bb1bf..97e7dacb0f 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -681,6 +681,7 @@ class Kind(enum.Enum):
         ERRORS = 4
         SINCE = 5
         TODO = 6
+        INTRO = 7
 
         @staticmethod
         def from_string(kind: str) -> 'QAPIDoc.Kind':
@@ -748,7 +749,7 @@ def has_features(self) -> bool:
     def end(self) -> None:
         for section in self.all_sections:
             section.text = section.text.strip('\n')
-            if section.kind != QAPIDoc.Kind.PLAIN and section.text == '':
+            if not (section.kind.name in ("INTRO", "PLAIN") or section.text):
                 raise QAPISemError(
                     section.info, "text required after '%s:'" % section.kind)
 
-- 
2.54.0


