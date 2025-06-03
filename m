Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1928C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLHA-0007zV-ND; Tue, 03 Jun 2025 02:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGo-0007oQ-1G
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGZ-0003Ri-Qx
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=luFeafPnvOVtx7ro6pi0IN6b+Ie4wJvUpdyAR+l9GWE=;
 b=VV0N7B3vqbAJinpgqytc1P+UcK9NicaI1Cszgy5Jo82jGsvduUAEfGZ0UW75CUwLeXM4ql
 jdTdLCD4dtGBPGlUVQKTy4KRvu3ufsCP3QqjSY3VDj9ptwJtffwhq/tdwFmXpRd9JB044Y
 VVWKeRaJphllaM73xblWDKLfr90n7lc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-8blElABpNhi1k2rZA59Nmg-1; Tue,
 03 Jun 2025 02:36:51 -0400
X-MC-Unique: 8blElABpNhi1k2rZA59Nmg-1
X-Mimecast-MFC-AGG-ID: 8blElABpNhi1k2rZA59Nmg_1748932611
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CA89195608A
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 911B218004A7
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0AC1A21E65E7; Tue, 03 Jun 2025 08:36:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 08/13] qapi: Use proper markup instead of CAPS for emphasis in
 doc comments
Date: Tue,  3 Jun 2025 08:36:39 +0200
Message-ID: <20250603063644.3953528-9-armbru@redhat.com>
In-Reply-To: <20250603063644.3953528-1-armbru@redhat.com>
References: <20250603063644.3953528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250527073916.1243024-9-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json |  2 +-
 qapi/dump.json       |  6 +++---
 qapi/migration.json  | 26 +++++++++++++-------------
 qapi/misc.json       |  4 ++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f0faca1054..7b0548dc2e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1589,7 +1589,7 @@
 #
 # @bitmap-mode: Specifies the type of data the bitmap should contain
 #     after the operation concludes.  Must be present if a bitmap was
-#     provided, must NOT be present otherwise.  (Since 4.2)
+#     provided, must **not** be present otherwise.  (Since 4.2)
 #
 # @compress: true to compress data, if the target format supports it.
 #     (default: false) (since 2.8)
diff --git a/qapi/dump.json b/qapi/dump.json
index f2835c0b47..d0ba1f0596 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -54,9 +54,9 @@
 # @paging: if true, do paging to get guest's memory mapping.  This
 #     allows using gdb to process the core file.
 #
-#     IMPORTANT: this option can make QEMU allocate several gigabytes
-#     of RAM.  This can happen for a large guest, or a malicious guest
-#     pretending to be large.
+#     **Important**: this option can make QEMU allocate several
+#     gigabytes of RAM.  This can happen for a large guest, or a
+#     malicious guest pretending to be large.
 #
 #     Also, paging=true has the following limitations:
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 84edcf81e4..4963f6ca12 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -407,7 +407,7 @@
 # @postcopy-ram: Start executing on the migration target before all of
 #     RAM has been migrated, pulling the remaining pages along as
 #     needed.  The capacity must have the same setting on both source
-#     and target or migration will not even start.  NOTE: If the
+#     and target or migration will not even start.  **Note:** if the
 #     migration fails during postcopy the VM will fail.  (since 2.6)
 #
 # @x-colo: If enabled, migration will never end, and the state of the
@@ -801,10 +801,10 @@
 #     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations
-#     when making decisions to switchover.  By default, this value is
-#     zero, which means QEMU will estimate the bandwidth
+#     migration can use during switchover phase.  **Note:** this does
+#     not limit the bandwidth during switchover, but only for
+#     calculations when making decisions to switchover.  By default,
+#     this value is zero, which means QEMU will estimate the bandwidth
 #     automatically.  This can be set when the estimated value is not
 #     accurate, while the user is able to guarantee such bandwidth is
 #     available when switching over.  When specified correctly, this
@@ -982,10 +982,10 @@
 #     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations
-#     when making decisions to switchover.  By default, this value is
-#     zero, which means QEMU will estimate the bandwidth
+#     migration can use during switchover phase.  **Note:** this does
+#     not limit the bandwidth during switchover, but only for
+#     calculations when making decisions to switchover.  By default,
+#     this value is zero, which means QEMU will estimate the bandwidth
 #     automatically.  This can be set when the estimated value is not
 #     accurate, while the user is able to guarantee such bandwidth is
 #     available when switching over.  When specified correctly, this
@@ -1192,10 +1192,10 @@
 #     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations
-#     when making decisions to switchover.  By default, this value is
-#     zero, which means QEMU will estimate the bandwidth
+#     migration can use during switchover phase.  **Note:** this does
+#     not limit the bandwidth during switchover, but only for
+#     calculations when making decisions to switchover.  By default,
+#     this value is zero, which means QEMU will estimate the bandwidth
 #     automatically.  This can be set when the estimated value is not
 #     accurate, while the user is able to guarantee such bandwidth is
 #     available when switching over.  When specified correctly, this
diff --git a/qapi/misc.json b/qapi/misc.json
index dcf9f7df5b..4b9e601cfa 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -222,8 +222,8 @@
 # .. note:: This command only exists as a stop-gap.  Its use is highly
 #    discouraged.  The semantics of this command are not guaranteed:
 #    this means that command names, arguments and responses can change
-#    or be removed at ANY time.  Applications that rely on long term
-#    stability guarantees should NOT use this command.
+#    or be removed at **any** time.  Applications that rely on long
+#    term stability guarantees should **not** use this command.
 #
 #    Known limitations:
 #
-- 
2.48.1


