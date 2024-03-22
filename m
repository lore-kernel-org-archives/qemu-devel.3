Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0ADC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaJ-0002xt-1s; Fri, 22 Mar 2024 10:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaH-0002xA-0M
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaF-0003Yg-HJ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGvRNvb/xbqkQlMDZwwzuKEO52MOmr06TILvUFwPl9A=;
 b=JMHO/jYuS+BsI5mfiYZlojdKbQXssc5UX8ADktQ+63GbPKZCqWCWxu4TPIzQUnko4/sepv
 uwcTXtnij0NNuoJ+xRonTkq4Kh9MkjYp0W0uIYwczy4r5P5cdpBW+7SJMQImhS1Hp5NRoq
 XyRoRc/rEDrnYK67+fzvi6Q8MafZeKM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-3MbrDfVfNJe225Ak2Qu0_w-1; Fri,
 22 Mar 2024 10:09:21 -0400
X-MC-Unique: 3MbrDfVfNJe225Ak2Qu0_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE91F1C01526;
 Fri, 22 Mar 2024 14:09:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD3942166AE1;
 Fri, 22 Mar 2024 14:09:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D4B6421E5D2E; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 08/12] qapi: Start sentences with a capital letter,
 end them with a period
Date: Fri, 22 Mar 2024 15:09:06 +0100
Message-ID: <20240322140910.328840-9-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-1-armbru@redhat.com>
References: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 16 ++++++++--------
 qapi/ui.json        |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index faeb7d1ca9..9ce0f6249f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -826,8 +826,8 @@
 #     and recreated on the fly while the migration server is active.
 #     If missing, it will default to denying access (Since 4.0)
 #
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
+# @max-bandwidth: maximum speed for migration, in bytes per second.
+#     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
@@ -1023,8 +1023,8 @@
 #     control checking of the TLS x509 certificate distinguished name.
 #     (Since 4.0)
 #
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
+# @max-bandwidth: maximum speed for migration, in bytes per second.
+#     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
@@ -1256,8 +1256,8 @@
 #     control checking of the TLS x509 certificate distinguished name.
 #     (Since 4.0)
 #
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
+# @max-bandwidth: maximum speed for migration, in bytes per second.
+#     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
@@ -1949,8 +1949,8 @@
 #
 # @primary: true for primary or false for secondary.
 #
-# @failover: true to do failover, false to stop.  but cannot be
-#     specified if 'enable' is true.  default value is false.
+# @failover: true to do failover, false to stop.  Cannot be specified
+#     if 'enable' is true.  Default value is false.
 #
 # Example:
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index 5744c24e3c..e71cd2f50b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -290,7 +290,7 @@
 # @enabled: true if the SPICE server is enabled, false otherwise
 #
 # @migrated: true if the last guest migration completed and spice
-#     migration had completed as well.  false otherwise.  (since 1.4)
+#     migration had completed as well, false otherwise (since 1.4)
 #
 # @host: The hostname the SPICE server is bound to.  This depends on
 #     the name resolution on the host and may be an IP address.
-- 
2.44.0


