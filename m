Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7782C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7I4O-0005rk-Ox; Thu, 17 Sep 2026 15:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7I4H-0005qg-Lj
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7I4F-0005G3-Sf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789674407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQ5l2zQTKXrlbIqeocoytsYz76jJ9tSoC9AMPa4JXT4=;
 b=Bx0L+mw3PcMMQp8Ng3jslfx0JLhrqO7/1/Hr7bcKjy9WWp9LOsDKSQWCughf8pDR7lWquO
 lytGCo5+FfBnSbq8ysowVwVdlxQXmBfYA+EQW2XQldQtDyK2v0pT+LOPMdTPpXFxxqdhGl
 eJEJBS1SlyaKj+wAUDd5Iy+1ysF9xUI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-F7cXhwGiN9aA31adMYohaw-1; Thu,
 17 Sep 2026 15:46:43 -0400
X-MC-Unique: F7cXhwGiN9aA31adMYohaw-1
X-Mimecast-MFC-AGG-ID: F7cXhwGiN9aA31adMYohaw_1789674402
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED0DC1800758; Thu, 17 Sep 2026 19:46:41 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B2A419AC047; Thu, 17 Sep 2026 19:46:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Junjie Cao <junjie.cao@intel.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-cxl@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>, Jonathan Cameron <jic23@kernel.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v5 7/7] qapi: convert intro sections followed by notes/examples
Date: Thu, 17 Sep 2026 15:46:14 -0400
Message-ID: <20260917194614.549584-8-jsnow@redhat.com>
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch converts intro sections that are immediately followed by
".. note::" or ".. qmp-example::", which provides a natural cutoff
point. This patch does not change how these functions happen to be
rendered, as they do not have any auto-generated documention inserted
into them.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/migration.json | 15 +++++++--------
 qapi/misc.json      |  3 +--
 qapi/run-state.json |  7 +++----
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index d571c06fc20..a272e701385 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1254,10 +1254,10 @@
 
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
@@ -1632,8 +1632,8 @@
 
 ##
 # @xen-colo-do-checkpoint:
-#
-# Xen uses this command to notify replication to trigger a checkpoint.
+#     Xen uses this command to notify replication to trigger a
+#     checkpoint.
 #
 # .. qmp-example::
 #
@@ -1700,8 +1700,7 @@
 
 ##
 # @migrate-pause:
-#
-# Pause a migration.  Currently it only supports postcopy.
+#     Pause a migration.  Currently it only supports postcopy.
 #
 # .. qmp-example::
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index b7d08532768..b62cabc2b79 100644
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


