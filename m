Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B55C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KU-0004ir-LD; Tue, 26 Mar 2024 03:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KS-0004h7-5R
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KQ-0005Np-Le
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jpPljqVg9QjdtoaeLaWIq1x6laii/MU2HPjfWZbX10U=;
 b=AEs7whbjmVqAkyXcOQD7g4X1ZmuDVRPPdfZ+HTM4VSrcIf6JEi5b9ErajMdONIhFJfTUye
 y40hAXFx/F+kfTJKOUOgAkqxSoTMDfFT2W8S2+WWIyjq9RoF4pDc3+RaZs8lalLYn7+p8R
 EazVNh+OhaHCI7QW8/7lZvkbZyz7q5w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-rGjlzsSiMNSf2esFox-v6Q-1; Tue,
 26 Mar 2024 03:34:36 -0400
X-MC-Unique: rGjlzsSiMNSf2esFox-v6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D414B1C02C9D;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3C44200AFA3;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B502521E5D36; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 16/20] qapi: document InputMultiTouchType
Date: Tue, 26 Mar 2024 08:34:16 +0100
Message-ID: <20240326073420.738016-17-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240325095648.2835381-1-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Update qapi/pragma.json]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/pragma.json |  2 --
 qapi/ui.json     | 12 ++++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/qapi/pragma.json b/qapi/pragma.json
index 6929ab776e..92715d22b3 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -62,8 +62,6 @@
         'ImageInfoSpecificKind',
         'InputAxis',
         'InputButton',
-        'InputMultiTouchEvent',
-        'InputMultiTouchType',
         'IscsiHeaderDigest',
         'IscsiTransport',
         'JSONType',
diff --git a/qapi/ui.json b/qapi/ui.json
index 9721c1e5af..f610bce118 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1080,6 +1080,16 @@
 #
 # Type of a multi-touch event.
 #
+# @begin: A new touch event sequence has just started.
+#
+# @update: A touch event sequence has been updated.
+#
+# @end: A touch event sequence has finished.
+#
+# @cancel: A touch event sequence has been canceled.
+#
+# @data: Absolute position data.
+#
 # Since: 8.1
 ##
 { 'enum'  : 'InputMultiTouchType',
@@ -1137,6 +1147,8 @@
 #
 # MultiTouch input event.
 #
+# @type: The type of multi-touch event.
+#
 # @slot: Which slot has generated the event.
 #
 # @tracking-id: ID to correlate this event with previously generated
-- 
2.44.0


