Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371DAC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqd-0003JA-Vj; Tue, 11 Mar 2025 07:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqN-0003Bn-OI
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq4-0006WF-Nv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Hlbs1hovEuCbdsqBe7iz8d3ED9SWpS2plDRmLQQt/o=;
 b=g7A6hJ+k4QKp4zILkU0m6+Try5/ve+1hmLMMGhQ5rWQYUy4HWDHiwpWYNICv5GxFIzK4Bh
 DKGt5JyHhet3acpuLmhakeXDkb/Q/Rjf1c38btZnzzSgubTOpfkZ9RE2baxWXIM6eWgeq2
 P5HUnDUbC66emEvd2ZEoJk8YBbRq00c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-Z1zVohkDNcapuZacMkEjfQ-1; Tue,
 11 Mar 2025 07:31:54 -0400
X-MC-Unique: Z1zVohkDNcapuZacMkEjfQ-1
X-Mimecast-MFC-AGG-ID: Z1zVohkDNcapuZacMkEjfQ_1741692713
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8284B1800267; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 133A118001E9; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2297C21E64B6; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PULL 26/61] docs/qapi-domain: add CSS styling
Date: Tue, 11 Mar 2025 12:31:02 +0100
Message-ID: <20250311113137.1277125-27-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Improve the general look and feel of generated QAPI docs.

Attempt to limit line lengths to offer a more comfortable measure on
maximized windows, and improve some margin and spacing for field lists.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-29-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 56 +++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 3fd326613d..b225bf706f 100644
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
 
+/* most content in a QAPI object definition should not eclipse about
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


