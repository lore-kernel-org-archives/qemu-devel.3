Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E37FC19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEex-0004HI-9v; Wed, 26 Feb 2025 05:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEeu-0004Fd-8y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEes-0003gD-Ho
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740565733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J63+xeMvDp8oP/T4oQACy9QBFnsjVacP1Jp692/Nx7o=;
 b=HOhokfowgzhVtDNeRad9kQcRGGrC1oeA5NqGH9u6loqQNyVWUHkbb4fW6DtMMRF+KjL8f8
 naqPb0JDzvkTw6h5Efm9Fcq/Je9zOvmeuV7IdSgyoDzk0vuW4sJw4Nevsy1S8eyld8U/VO
 GOFLXeSYzle0DSaxsEFvaH1GPURk5CY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-5tNp8bw3OTKKNrXlu7rkdA-1; Wed,
 26 Feb 2025 05:28:50 -0500
X-MC-Unique: 5tNp8bw3OTKKNrXlu7rkdA-1
X-Mimecast-MFC-AGG-ID: 5tNp8bw3OTKKNrXlu7rkdA_1740565729
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B04841800268
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:28:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69E31180087F
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:28:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F43321E65FD; Wed, 26 Feb 2025 11:28:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 5/6] docs/qapidoc: remove example section support
Date: Wed, 26 Feb 2025 11:28:41 +0100
Message-ID: <20250226102842.3721046-6-armbru@redhat.com>
In-Reply-To: <20250226102842.3721046-1-armbru@redhat.com>
References: <20250226102842.3721046-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since commit 3c5f6114 (qapi: remove "Example" doc section), Example
sections no longer exist, so this support in qapidoc is now dead code.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250224033741.222749-7-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5a4d7388b2..61997fd21a 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -254,10 +254,6 @@ def _nodes_for_features(self, doc):
         section += dlnode
         return [section]
 
-    def _nodes_for_example(self, exampletext):
-        """Return list of doctree nodes for a code example snippet"""
-        return [nodes.literal_block(exampletext, exampletext)]
-
     def _nodes_for_sections(self, doc):
         """Return list of doctree nodes for additional sections"""
         nodelist = []
@@ -275,10 +271,7 @@ def _nodes_for_sections(self, doc):
                 continue
 
             snode = self._make_section(section.tag)
-            if section.tag.startswith('Example'):
-                snode += self._nodes_for_example(dedent(section.text))
-            else:
-                self._parse_text_into_node(dedent(section.text), snode)
+            self._parse_text_into_node(dedent(section.text), snode)
             nodelist.append(snode)
         return nodelist
 
-- 
2.48.1


