Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CF3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxsG-0005qi-7N; Tue, 11 Mar 2025 07:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqd-0003IS-6l
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq9-0006YI-Oe
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXRhyny7T9Bf4bTFkXqMBiMcYNuJGRxrIwHw5pJ/Gmk=;
 b=UEP1f2gz/WYwZKyltUjKWp0IqNsTl0zgZYfpmhu5UeLHTaAdoq0HdvAlcnLMrE0133DFVU
 z7SxFwhDX1aBaFRxX6VtsYfNZIGWL0sBAO5WVpaEmeJc7VMOsqPDyVT+fbYxQyGkJXblvM
 PprwSmiaxc+Pq3l4sZfnO3WFIDNjuUo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-LtZw2NtGN7eZC47HlWu4Ew-1; Tue,
 11 Mar 2025 07:32:03 -0400
X-MC-Unique: LtZw2NtGN7eZC47HlWu4Ew-1
X-Mimecast-MFC-AGG-ID: LtZw2NtGN7eZC47HlWu4Ew_1741692722
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79F08180AF57
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21C891828A95
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9540E21E60E2; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 56/61] qapi/parser: add undocumented stub members to
 all_sections
Date: Tue, 11 Mar 2025 12:31:32 +0100
Message-ID: <20250311113137.1277125-57-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Parser and doc generator cooperate on generating stub documentation for
undocumented members.  The parser makes up an ArgSection with an empty
description, and the doc generator makes up a description.

Right now, the made-up ArgSections go into doc.args.  However, the new
doc generator uses .all_sections, not .args.  So put them into
.all_sections, too.

Insert them right after existing 'member' sections.  If there are none,
insert directly after the leading section.

Doesn't affect the old generator, because that one doesn't use
.all_sections.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-60-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message rewritten]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 11c11bb09e..949d9e8bff 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -789,8 +789,23 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                 raise QAPISemError(member.info,
                                    "%s '%s' lacks documentation"
                                    % (member.role, member.name))
-            self.args[member.name] = QAPIDoc.ArgSection(
+            # Insert stub documentation section for missing member docs.
+            # TODO: drop when undocumented members are outlawed
+
+            section = QAPIDoc.ArgSection(
                 self.info, QAPIDoc.Kind.MEMBER, member.name)
+            self.args[member.name] = section
+
+            # Determine where to insert stub doc - it should go at the
+            # end of the members section(s), if any. Note that index 0
+            # is assumed to be an untagged intro section, even if it is
+            # empty.
+            index = 1
+            if len(self.all_sections) > 1:
+                while self.all_sections[index].kind == QAPIDoc.Kind.MEMBER:
+                    index += 1
+            self.all_sections.insert(index, section)
+
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
-- 
2.48.1


