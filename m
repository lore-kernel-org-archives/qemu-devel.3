Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086A9C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfk0-0000pq-9v; Tue, 04 Mar 2025 22:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjv-0000gT-PJ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfju-0006FE-1B
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4NWkQ4ouYUL+mKJBAl/nb9/STXk2k++zJ8lVadQp84=;
 b=GR2NAovtL7xolgbBRXIUiTSpXQdUiwbtDk6fh6gj2MVliBwDJ3ZggkT+6zWjdpmFlUi9Zq
 NHYDEC8Cjc9qXGj3jAZz47lzHgj/H3xjzkmuLrCGFnMhQx0Cb8l9nEXlX2jpvDwaOcWL4X
 Z63SgVWRORoILK/XSaGgs1sUVIapCaA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-089OL6oYPDeXDB1PT4Pt_w-1; Tue,
 04 Mar 2025 22:47:57 -0500
X-MC-Unique: 089OL6oYPDeXDB1PT4Pt_w-1
X-Mimecast-MFC-AGG-ID: 089OL6oYPDeXDB1PT4Pt_w_1741146471
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2F781954218; Wed,  5 Mar 2025 03:47:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 261031956095; Wed,  5 Mar 2025 03:47:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH 26/57] docs/qapi-domain: add CSS styling
Date: Tue,  4 Mar 2025 22:45:35 -0500
Message-ID: <20250305034610.960147-27-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

Improve the general look and feel of generated QAPI docs.

Attempt to limit line lengths to offer a more comfortable measure on
maximized windows, and improve some margin and spacing for field lists.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 56 +++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 3fd326613d9..92f395054a8 100644
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
@@ -250,3 +262,43 @@ div[class^="highlight"] pre {
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
+
+/* Sphinx 3.x: unresolved xrefs */
+.rst-content *:not(a) > code.xref {
+    font-weight: 400;
+    color: #333333;
+}
-- 
2.48.1


