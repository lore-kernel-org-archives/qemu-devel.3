Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147AAC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 17:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54xS-000146-MH; Fri, 11 Sep 2026 13:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x54xQ-00013u-SL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 13:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x54xP-0004fL-9R
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 13:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789147354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhXIqCf/hAEpGNtdeyWPDfvZ8dculLK71e35WLjicQI=;
 b=Uyn3UF1DDhN669hOTUhsTvu1yt1XEbXbFSeHOvnyWtPQB1wRfpWtWXVB0Lo09d9+QQ679e
 6yjnBso/6+MexpR+KHvXX5AQhJkL8VKaeP1yo/vf4H0cbQkrSl5c7P0lLu2lLakVbjGKyE
 5cVYYbFRF4yGKmFwKiUQmoGxxleeoBQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-0pDL3bT_Pi6wuPwcMFl0-Q-1; Fri,
 11 Sep 2026 13:22:31 -0400
X-MC-Unique: 0pDL3bT_Pi6wuPwcMFl0-Q-1
X-Mimecast-MFC-AGG-ID: 0pDL3bT_Pi6wuPwcMFl0-Q_1789147350
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8D07195E90E; Fri, 11 Sep 2026 17:22:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.222])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F0EF195608F; Fri, 11 Sep 2026 17:22:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>, Jonathan Cameron <jic23@kernel.org>,
 Lukas Straub <lukasstraub2@web.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, linux-cxl@vger.kernel.org,
 Jason Wang <jasowangio@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 6/6] qapi: convert intro sections followed by notes/examples
Date: Fri, 11 Sep 2026 13:22:00 -0400
Message-ID: <20260911172200.227914-7-jsnow@redhat.com>
In-Reply-To: <20260911172200.227914-1-jsnow@redhat.com>
References: <20260911172200.227914-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These provide a rather natural cutoff point, but technically this does
introduce a new intro/details split to these documentation blocks.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json   |  5 ++---
 qapi/migration.json | 15 +++++++--------
 qapi/misc.json      |  3 +--
 qapi/run-state.json |  7 +++----
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 108033b6d64..9a790da9db2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1181,9 +1181,8 @@
 
 ##
 # @HV_BALLOON_STATUS_REPORT:
-#
-# Emitted when the hv-balloon driver receives a "STATUS" message from
-# the guest.
+#     Emitted when the hv-balloon driver receives a "STATUS" message
+#     from the guest.
 #
 # .. note:: This event is rate-limited.
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 70a1854fb73..c831e692feb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1241,10 +1241,10 @@
 
 ##
 # @migrate_cancel:
-#
-# Cancel the currently executing migration process.  Allows a new
-# migration to be started right after.  When postcopy-ram is in use,
-# cancelling is not allowed after the postcopy phase has started.
+#     Cancel the currently executing migration process.  Allows a new
+#     migration to be started right after.  When postcopy-ram is in
+#     use, cancelling is not allowed after the postcopy phase has
+#     started.
 #
 # .. note:: This command succeeds even if there is no migration
 #    process running.
@@ -1619,8 +1619,8 @@
 
 ##
 # @xen-colo-do-checkpoint:
-#
-# Xen uses this command to notify replication to trigger a checkpoint.
+#     Xen uses this command to notify replication to trigger a
+#     checkpoint.
 #
 # .. qmp-example::
 #
@@ -1687,8 +1687,7 @@
 
 ##
 # @migrate-pause:
-#
-# Pause a migration.  Currently it only supports postcopy.
+#     Pause a migration.  Currently it only supports postcopy.
 #
 # .. qmp-example::
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index b3c2a1421f3..ec783c067c9 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -103,8 +103,7 @@
 
 ##
 # @query-iothreads:
-#
-# Return a list of information about each iothread.
+#     Return a list of information about each iothread.
 #
 # .. note:: This list excludes the QEMU main loop thread, which is not
 #    declared using the ``-object iothread`` command-line option.  It
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 703ca1bb5b9..8bbd9884087 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -232,10 +232,9 @@
 
 ##
 # @SUSPEND_DISK:
-#
-# Emitted when guest enters a hardware suspension state with data
-# saved on disk, for example, S4 state, which is sometimes called
-# hibernate state
+#     Emitted when guest enters a hardware suspension state with data
+#     saved on disk, for example, S4 state, which is sometimes called
+#     hibernate state
 #
 # .. note:: QEMU shuts down (similar to event `SHUTDOWN`) when
 #    entering this state.
-- 
2.55.0


