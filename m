Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6991BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZGK-00041t-Hp; Tue, 14 Jul 2026 05:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjZGI-00040l-0Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjZGF-0006iO-Rh
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784020626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qrc/Z0z3WhrXTjamW5bNYK+l2DjvgjxwFXRtsj+CTh8=;
 b=dtHx3wUji4gs8hikPS+D5W4dIoiEzMXxsaEV9ePAvh/dr9sL5Mf283WAArzHM+dglYTTy+
 8MpkyhmlQl0FQKzMUwjhn2bOgX04M7CaXQ3FjC3swuITk9VBzkcoOWHigwnUsJFDVdH0/q
 kybas957Dg6REkwUupgmjUDQZgPjEwg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-L0z5nzmaNzuAb-uXGMll3g-1; Tue,
 14 Jul 2026 05:17:04 -0400
X-MC-Unique: L0z5nzmaNzuAb-uXGMll3g-1
X-Mimecast-MFC-AGG-ID: L0z5nzmaNzuAb-uXGMll3g_1784020623
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69FB31956079; Tue, 14 Jul 2026 09:17:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2311130002D6; Tue, 14 Jul 2026 09:17:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 79AE221E692F; Tue, 14 Jul 2026 11:17:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/4] qapi: Fix misspelled section tags in doc comments
Date: Tue, 14 Jul 2026 11:16:57 +0200
Message-ID: <20260714091700.3797064-2-armbru@redhat.com>
In-Reply-To: <20260714091700.3797064-1-armbru@redhat.com>
References: <20260714091700.3797064-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Message-ID: <20260701061136.798815-1-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index d96cc5aa21..c55776af7d 100644
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


