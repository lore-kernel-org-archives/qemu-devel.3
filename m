Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E764AC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Dp-00040h-Kl; Wed, 17 Jul 2024 06:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dn-0003sA-MG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dm-0001Uq-4a
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721213356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmyF6zUdYWYgClcv6MDOK0crgjFfPfJav3+CmWsi8vw=;
 b=ZWoswwG91UbCBm9RHIO4mGrnzxbuwAMxcMsqjAsHGYEulKOXLmWRPDCqfccAm/wy2Bkdya
 u5fs9KU1r0M91XIrjY35NHxUrtSZST9Cp3XQMOdnm9vVK+ABOQYqAQjQ459hALRy9J859/
 HEfUz9uN4LH6ZGM3wEzLh+JS9Z1u60E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-XVdpHkApNTKAzwlVZSD56A-1; Wed,
 17 Jul 2024 06:49:14 -0400
X-MC-Unique: XVdpHkApNTKAzwlVZSD56A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E23AA1955BFA; Wed, 17 Jul 2024 10:49:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87C4A1955D44; Wed, 17 Jul 2024 10:49:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6D9A21E5E6D; Wed, 17 Jul 2024 12:49:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Harmonie Snow <harmonie@gmail.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 10/14] docs/sphinx: add CSS styling for qmp-example directive
Date: Wed, 17 Jul 2024 12:49:03 +0200
Message-ID: <20240717104907.2962784-11-armbru@redhat.com>
In-Reply-To: <20240717104907.2962784-1-armbru@redhat.com>
References: <20240717104907.2962784-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Harmonie Snow <harmonie@gmail.com>

Add CSS styling for qmp-example directives to increase readability and
consistently style all example blocks.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240717021312.606116-6-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index c70ef95128..965ecac54f 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -87,6 +87,55 @@ div[class^="highlight"] pre {
     padding-bottom: 1px;
 }
 
+/* qmp-example directive styling */
+
+.rst-content .admonition-example {
+    /* do not apply the standard admonition background */
+    background-color: transparent;
+    border: solid #ffd2ed 1px;
+}
+
+.rst-content .admonition-example > .admonition-title:before {
+    content: "▷";
+}
+
+.rst-content .admonition-example > .admonition-title {
+    background-color: #5980a6;
+}
+
+.rst-content .admonition-example > div[class^="highlight"] {
+    /* make code boxes take up the full width of the admonition w/o margin */
+    margin-left: -12px;
+    margin-right: -12px;
+
+    border-top: 1px solid #ffd2ed;
+    border-bottom: 1px solid #ffd2ed;
+    border-left: 0px;
+    border-right: 0px;
+}
+
+.rst-content .admonition-example > div[class^="highlight"]:nth-child(2) {
+    /* If a code box is the second element in an example admonition,
+     * it is the first child after the title. let it sit flush against
+     * the title. */
+    margin-top: -12px;
+    border-top: 0px;
+}
+
+.rst-content .admonition-example > div[class^="highlight"]:last-child {
+    /* If a code box is the final element in an example admonition, don't
+     * render margin below it; let it sit flush with the end of the
+     * admonition box */
+    margin-bottom: -12px;
+    border-bottom: 0px;
+}
+
+.rst-content .admonition-example .highlight {
+    background-color: #fffafd;
+}
+
+/* end qmp-example styling */
+
 @media screen {
 
     /* content column
-- 
2.45.0


