Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B37C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 10:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sitYC-000504-93; Tue, 27 Aug 2024 06:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sitY7-0004ym-VT
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 06:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sitY6-0004Yf-0I
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 06:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724754939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4Q8o0IG0jTVd7vOErL8HdXdFcv0ZdMf445XvAP4iWo=;
 b=hbB2ipLbu+OuahLTUEcjiaIAbVsflFhjBKr+D0LaxUvT6u3phDtNKs/TtYmpTn4BJFgsi/
 RVKuiHTCfr9g7b12tcPBMsdCDIuUiG/A1RUrZwtCmkxDXvobXaFGIcEEX6AKB5lpxjqdxV
 nh0ykMB6kkNA3p7ZjhrrfeBkVHH+sJ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-Kfx7Fj9xP72fnVeaz1iwQg-1; Tue,
 27 Aug 2024 06:35:36 -0400
X-MC-Unique: Kfx7Fj9xP72fnVeaz1iwQg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCE731955D42; Tue, 27 Aug 2024 10:35:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 287021954B04; Tue, 27 Aug 2024 10:35:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C639A21E691E; Tue, 27 Aug 2024 12:35:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 1/1] docs/sphinx: fix extra stuff in TOC after freeform QMP
 sections
Date: Tue, 27 Aug 2024 12:35:32 +0200
Message-ID: <20240827103532.799039-2-armbru@redhat.com>
In-Reply-To: <20240827103532.799039-1-armbru@redhat.com>
References: <20240827103532.799039-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: John Snow <jsnow@redhat.com>

Freeform sections with titles are currently generating a TOC entry for
the first paragraph in the section after the header, which is not what
we want.

(Easiest to observe directly in the QMP reference manual's
"Introduction" section.)

When freeform sections are parsed, we create both a section header *and*
an empty, title-less section. This causes some problems with sphinx's
post-parse tree transforms, see also 2664f317 - this is a similar issue:
Sphinx doesn't like section-less titles and it also doesn't like
title-less sections.

Modify qapidoc.py to parse text directly into the preceding section
title as child nodes, eliminating the section duplication. This removes
the extra text from the TOC.

Only very, very lightly tested: "it looks right at a glance" :tm:. I am
still in the process of rewriting qapidoc, so I didn't give it much
deeper thought.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20240822204803.1649762-1-jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 738b2450fb..5f96b46270 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -388,6 +388,7 @@ def _start_new_heading(self, heading, level):
         self._active_headings[level - 1] += snode
         self._active_headings = self._active_headings[:level]
         self._active_headings.append(snode)
+        return snode
 
     def _add_node_to_current_heading(self, node):
         """Add the node to whatever the current active heading is"""
@@ -417,13 +418,11 @@ def freeform(self, doc):
             # the first line of the block)
             (heading, _, text) = text.partition('\n')
             (leader, _, heading) = heading.partition(' ')
-            self._start_new_heading(heading, len(leader))
+            node = self._start_new_heading(heading, len(leader))
             if text == '':
                 return
 
-        node = self._make_section(None)
         self._parse_text_into_node(text, node)
-        self._add_node_to_current_heading(node)
         self._cur_doc = None
 
     def _parse_text_into_node(self, doctext, node):
-- 
2.46.0


