Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83B1C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfoc4-00082y-FT; Wed, 05 Feb 2025 18:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfobk-0007hb-Us
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfobj-0005q1-2L
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5a5n4efKymKtAME8NwZAOJy7b6IhV1FNDCgSqtH52E=;
 b=Myaq7LUgxel6oIyeP7O4PTl+H8aX5vsTD4stDDym5wupHc1NVJebSFi9pcBlGnxdogi8ap
 6Wr3mNNbwfmqCjzoUOwS7TzctyCoWjlYTYArN/TiFoDpwyhbDfsr5g7A8AtivMMeAwEnxv
 vRkgm6VH6Tp8OVFFf+gW8xW2vcS/28Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-s6j-xG_uNI-eTvrM3iEkxw-1; Wed,
 05 Feb 2025 18:14:55 -0500
X-MC-Unique: s6j-xG_uNI-eTvrM3iEkxw-1
X-Mimecast-MFC-AGG-ID: s6j-xG_uNI-eTvrM3iEkxw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3CC81800876; Wed,  5 Feb 2025 23:14:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 330031800570; Wed,  5 Feb 2025 23:14:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 26/42] qapi/parser: add undocumented stub members to
 all_sections
Date: Wed,  5 Feb 2025 18:11:52 -0500
Message-ID: <20250205231208.1480762-27-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This helps simplify the new doc generator if it doesn't have to check
for undocumented members; especially when dealing recursively with
inherited documentation blocks.

NB: If there is no existing 'member' section, these undocumented stub
members will be inserted directly after the intro paragraph(s). This is
potentially problematic for cases where a doc block contains *only* free
paragraphs, but some of those paragraphs are conceptually better suited
for the "outro" section; i.e.:


This patch will insert member documentation after the example,
effectively solidifying all preceding paragraphs as "intro" type, which
may not be what we want.

Solution for this issue is still TBD; auditing is needed to understand
how prevalent the problem is to help engineer a fix or decide it's not
really a problem that needs solving.

While I'm rambling about RFC stuff in the commit message though, this
patch really did help cull over a hundred lines from the new generator,
so I think I'm predisposed to find a way to keep it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index af5d7bf892c..a8b30ae1a4b 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -800,6 +800,18 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
             section = QAPIDoc.ArgSection(
                 self.info, QAPIDoc.Kind.MEMBER, member.name)
             self.args[member.name] = section
+
+            # Insert stub documentation section for missing member docs.
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


