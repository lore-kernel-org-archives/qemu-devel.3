Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B913C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoAo-0004p7-33; Wed, 01 Jul 2026 02:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weoAm-0004oy-Cd
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weoAk-0004aR-Uv
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782886305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LqeXJlUSDTcsnPt8HZfpqMS9xwP3e7tPUyX0337KuVk=;
 b=Y/L7PxGo2Ybnj3+b4KM3Ehyg8nWcZKQxS+rzqgfpumK1nruL6ZBiaTyB1yFOlhLa3pmDU7
 Nbpxs3Ocbq0q9YOLOCahz0Tymv7hN6DAUXmAQiwvJlOy2mQEUvQEMfUMNYpblropOgYDhs
 AGzN1f4R7zb+KQG4bPw0AkSWxVAZFH4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-4oW4lirMOSKd-QXaLEoq6Q-1; Wed,
 01 Jul 2026 02:11:44 -0400
X-MC-Unique: 4oW4lirMOSKd-QXaLEoq6Q-1
X-Mimecast-MFC-AGG-ID: 4oW4lirMOSKd-QXaLEoq6Q_1782886303
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AEA7192D0C6; Wed,  1 Jul 2026 06:11:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E84933691C; Wed,  1 Jul 2026 06:11:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 594D021E6920; Wed, 01 Jul 2026 08:11:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, zhao1.liu@intel.com, eblake@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com
Subject: [PATCH] qapi: Fix misspelled section tags in doc comments
Date: Wed,  1 Jul 2026 08:11:36 +0200
Message-ID: <20260701061136.798815-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Section tags are case sensitive and end with a colon.  Screwing up
either gets them interpreted as ordinary paragraph.  Fix a few.

Fixes: 4e88e7e340 (qapi/qom: Define cache enumeration and properties for machine, 2024-11-01)
Fixes: 8eb6d39e22 (qom: qom-list-get, 2025-07-11)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine-common.json | 2 +-
 qapi/qom.json            | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index 92e84dfb14..aca98e994a 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -108,7 +108,7 @@
 #
 # @caches: the list of `SmpCacheProperties`.
 #
-# Since 9.2
+# Since: 9.2
 ##
 { 'struct': 'SmpCachePropertiesWrapper',
   'data': { 'caches': ['SmpCacheProperties'] } }
diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..18e05f81df 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -58,7 +58,7 @@
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
 #
-# Since 10.1
+# Since: 10.1
 ##
 { 'struct': 'ObjectPropertyValue',
   'data': { 'name': 'str',
@@ -70,7 +70,7 @@
 #
 # @properties: a list of properties.
 #
-# Since 10.1
+# Since: 10.1
 ##
 { 'struct': 'ObjectPropertiesValues',
   'data': { 'properties': [ 'ObjectPropertyValue' ] }}
@@ -167,7 +167,7 @@
 # Returns: A list where each element is the result for the
 #     corresponding element of @paths.
 #
-# Since 10.1
+# Since: 10.1
 ##
 { 'command': 'qom-list-get',
   'data': { 'paths': [ 'str' ] },
-- 
2.54.0


