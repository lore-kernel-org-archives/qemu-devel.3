Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFEFC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 04:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQW-0008Pw-4a; Thu, 13 Mar 2025 00:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQL-0008L3-Qb
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaQJ-00071C-7Z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YMu7QaZORjvtQpH7ZgbjoBhVg9RDEtgDWanjFFt9fM=;
 b=ga5tY6piOvIwMLgvfTIrPu656SEkhF6O/FJ6tLFS9vnKRwY0p4Ph16dYPo+V6UytL19c/r
 rC2DOVizf8olo09GpzdlPv15dwj4jpBoWCbtrwvzAuz9xbbQDhf9bVbGL9CVzbjilVq4Zb
 voDODC/1HtbyJMfTwylPxLWzotdqpp8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-fGQorzbhOyqIimJqvGgRXw-1; Thu,
 13 Mar 2025 00:43:54 -0400
X-MC-Unique: fGQorzbhOyqIimJqvGgRXw-1
X-Mimecast-MFC-AGG-ID: fGQorzbhOyqIimJqvGgRXw_1741841033
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 735CB180AF4E; Thu, 13 Mar 2025 04:43:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BB0C1955BCB; Thu, 13 Mar 2025 04:43:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 09/11] docs: add QAPI namespace "QMP" to qemu-qmp-ref
Date: Thu, 13 Mar 2025 00:43:10 -0400
Message-ID: <20250313044312.189276-10-jsnow@redhat.com>
In-Reply-To: <20250313044312.189276-1-jsnow@redhat.com>
References: <20250313044312.189276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

This also creates the qapi-qmp-index.html index and cross-reference
target.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py                  | 4 +++-
 docs/interop/qemu-qmp-ref.rst | 1 +
 qapi/qapi-schema.json         | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 175491148c3..9a86e84a804 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -163,7 +163,9 @@
 
 # Due to a limitation in Sphinx, we need to know which indices to
 # generate in advance. Adding a namespace here allows that generation.
-qapi_namespaces = set()
+qapi_namespaces = {
+    "QMP",
+}
 
 # -- Options for HTML output ----------------------------------------------
 
diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
index e95eeac45e2..ef8792b53f5 100644
--- a/docs/interop/qemu-qmp-ref.rst
+++ b/docs/interop/qemu-qmp-ref.rst
@@ -8,3 +8,4 @@ QEMU QMP Reference Manual
 
 .. qapi-doc:: qapi/qapi-schema.json
    :transmogrify:
+   :namespace: QMP
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 4475e81cc3e..c41c01eb2ab 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -5,7 +5,7 @@
 #
 # This document describes all commands currently supported by QMP.
 #
-# For locating a particular item, please see the `qapi-index`.
+# For locating a particular item, please see the `qapi-qmp-index`.
 #
 # Most of the time their usage is exactly the same as in the user
 # Monitor, this means that any other document which also describe
-- 
2.48.1


