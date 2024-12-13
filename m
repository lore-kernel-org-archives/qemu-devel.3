Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D35E77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuH0-0000TE-P4; Thu, 12 Dec 2024 20:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGy-0000FI-Iv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGo-0000to-Di
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w11qbz5LS8mfp4Zf8SPjOFvm9fv3TsBf+zaZUYZeWXc=;
 b=EyNvPpxWDWkI6nxczKj9vcJQM2BiJe20jfaXUtDHGjJRsznMTk6aOXnNIW2kPwI1aWvsMX
 HsuIp3V8ukfxQ+MkUTnrjKfoKe68qCALR22jPHPbFk6/tIRa70dqYX11L3vqtKLATKCzrY
 Eu290Yk53Ht+WgHcoor+mMu4NxDge2Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-War67uLBP1GD292nBirB1Q-1; Thu,
 12 Dec 2024 20:15:00 -0500
X-MC-Unique: War67uLBP1GD292nBirB1Q-1
X-Mimecast-MFC-AGG-ID: War67uLBP1GD292nBirB1Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91B9E1956095; Fri, 13 Dec 2024 01:14:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B9841956086; Fri, 13 Dec 2024 01:14:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Harmonie Snow <harmonie@gmail.com>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 28/35] docs/qapi-domain: add CSS styling
Date: Thu, 12 Dec 2024 20:12:57 -0500
Message-ID: <20241213011307.2942030-29-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Harmonie Snow <harmonie@gmail.com>

Improve the general look and feel of generated QAPI docs.

Attempt to limit line lengths to offer a more comfortable measure on
maximized windows, and improve some margin and spacing for field lists.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 50 ++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 3fd326613d9..5ceb89eb9a8 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -18,8 +18,8 @@ h1, h2, .rst-content .toctree-wrapper p.caption, h3, h4, h5, h6, legend {
 
 .rst-content dl:not(.docutils) dt {
     border-top: none;
-    border-left: solid 3px #ccc;
-    background-color: #f0f0f0;
+    border-left: solid 5px #bcc6d2;
+    background-color: #eaedf1;
     color: black;
 }
 
@@ -211,6 +211,18 @@ div[class^="highlight"] pre {
 
 /* QAPI domain theming */
 
+/* most content in a qapi object definition should not eclipse about
+   80ch, but nested field lists are explicitly exempt due to their
+   two-column nature */
+.qapi dd *:not(dl) {
+    max-width: 80ch;
+}
+
+/* but the content column itself should still be less than ~80ch. */
+.qapi .field-list dd {
+    max-width: 80ch;
+}
+
 .qapi-infopips {
     margin-bottom: 1em;
 }
@@ -250,3 +262,37 @@ div[class^="highlight"] pre {
     border-radius: 15px;
     margin: 5px;
 }
+
+/* code blocks */
+.qapi div[class^="highlight"] {
+    width: fit-content;
+    background-color: #fffafd;
+    border: 2px solid #ffe1f3;
+}
+
+/* note, warning, etc. */
+.qapi .admonition {
+    width: fit-content;
+}
+
+/* pad the top of the field-list so the text doesn't start directly at
+   the top border; primarily for the field list labels, but adjust the
+   field bodies as well for parity. */
+dl.field-list > dt:first-of-type, dl.field-list > dd:first-of-type {
+    padding-top: 0.3em;
+}
+
+dl.field-list > dt:last-of-type, dl.field-list > dd:last-of-type {
+    padding-bottom: 0.3em;
+}
+
+/* pad the field list labels so they don't crash into the border */
+dl.field-list > dt {
+    padding-left: 0.5em;
+    padding-right: 0.5em;
+}
+
+/* Add a little padding between field list sections */
+dl.field-list > dd:not(:last-child) {
+    padding-bottom: 1em;
+}
-- 
2.47.0


