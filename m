Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E5EC48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYcD-0002hU-6q; Tue, 06 Feb 2024 22:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXYcB-0002h1-17
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:28:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXYc9-0008TL-MH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707276524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1ETf3G89+07sqIJZ1itJGHRIP2rSKrdosNzaPpWDgvk=;
 b=C0RfVfgkfko54MEXR8AlbpSJsGtmF1Ar6mENijLlnWkrG3gYPvUQVQCcwUHbeTc6ZjTVEA
 IIf4nyAT2UtqDbWTNlEqk6jE0WRr061BfipYOya7p4IqJYQ3fB/VHtByKss+B3FElOvz+B
 karGMia3QQg2UDHW1gK9KAiKk9R2tFw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-vC7Y4-J7On6SX6o7W7G0EQ-1; Tue, 06 Feb 2024 22:28:41 -0500
X-MC-Unique: vC7Y4-J7On6SX6o7W7G0EQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B2283B7E6;
 Wed,  7 Feb 2024 03:28:40 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70CE02166B31;
 Wed,  7 Feb 2024 03:28:37 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] qapi/migration: Add missing tls-authz documentation
Date: Wed,  7 Feb 2024 11:28:36 +0800
Message-ID: <20240207032836.268183-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

As reported in Markus's recent enforcement series on qapi doc [1], we
accidentally miss one entry for tls-authz.  Add it.  Then we can drop
@MigrateSetParameters from documentation-exceptions safely later.

[1] https://lore.kernel.org/r/20240205074709.3613229-1-armbru@redhat.com

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 819708321d..f4c5f59e01 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -980,6 +980,10 @@
 #     2.9) Previously (since 2.7), this was reported by omitting
 #     tls-hostname instead.
 #
+# @tls-authz: ID of the 'authz' object subclass that provides access
+#     control checking of the TLS x509 certificate distinguished name.
+#     (Since 4.0)
+#
 # @max-bandwidth: to set maximum speed for migration.  maximum speed
 #     in bytes per second.  (Since 2.8)
 #
-- 
2.43.0


