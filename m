Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0048C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLHy-0000Ax-Bb; Tue, 03 Jun 2025 02:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGo-0007oO-0D
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGZ-0003RX-4z
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d6vQ+3F9zqFptJ346LQVWbUwoL7pzMlDvFAj6XFtZ/Q=;
 b=VaDxy+1bdfKAaImYQt6s1PKGDWuuQ8T7nn08gs5cNWw+Fu0ORzvuI49xqcob/F8AMccJ3k
 6lx5WfqKTxeB6t2ZIxSZuBoS4UrfO+VVP4CRAqVPDQZe2ucP0TAGtvCbnZEyeLzsE4RKSr
 v9UAzC9wZevECOZRIGMmIkdE0A9I7KI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-_9lQTTBpOUKejO5nN3OAVQ-1; Tue,
 03 Jun 2025 02:36:52 -0400
X-MC-Unique: _9lQTTBpOUKejO5nN3OAVQ-1
X-Mimecast-MFC-AGG-ID: _9lQTTBpOUKejO5nN3OAVQ_1748932611
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D2FE1956086
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2B601800361
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12DDD21E65EC; Tue, 03 Jun 2025 08:36:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 10/13] qapi: Refer to job-FOO instead of deprecated
 block-job-FOO in docs
Date: Tue,  3 Jun 2025 08:36:41 +0200
Message-ID: <20250603063644.3953528-11-armbru@redhat.com>
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

We deprecated several block-job-FOO commands in commit
b836bf2ab68 (qapi/block-core: deprecate some block-job- APIs).  Update
the doc comments to refer to their replacements instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250527073916.1243024-11-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 57 ++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f8f89ee2d7..6e5b90d5df 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1606,16 +1606,16 @@
 #     copy-before-write jobs; defaults to break-guest-write.  (Since 10.1)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @block-job-finalize
-#     before making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for @job-finalize before
+#     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 2.12)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @block-job-dismiss.  When true, this job will automatically
-#     disappear from the query list without user intervention.
-#     Defaults to true.  (Since 2.12)
+#     @job-dismiss.  When true, this job will automatically disappear
+#     from the query list without user intervention.  Defaults to
+#     true.  (Since 2.12)
 #
 # @filter-node-name: the node name that should be assigned to the
 #     filter driver that the backup job inserts into the graph above
@@ -1785,8 +1785,7 @@
 # If top == base, that is an error.  If top has no overlays on top of
 # it, or if it is in use by a writer, the job will not be completed by
 # itself.  The user needs to complete the job with the
-# block-job-complete command after getting the ready event.
-# (Since 2.0)
+# job-complete command after getting the ready event.  (Since 2.0)
 #
 # If the base image is smaller than top, then the base image will be
 # resized to be the same size as top.  If top is smaller than the base
@@ -1848,16 +1847,16 @@
 #     autogenerated.  (Since: 2.9)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @block-job-finalize
-#     before making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for @job-finalize before
+#     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @block-job-dismiss.  When true, this job will automatically
-#     disappear from the query list without user intervention.
-#     Defaults to true.  (Since 3.1)
+#     @job-dismiss.  When true, this job will automatically disappear
+#     from the query list without user intervention.  Defaults to
+#     true.  (Since 3.1)
 #
 # Features:
 #
@@ -2212,16 +2211,16 @@
 #     'background' (Since: 3.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @block-job-finalize
-#     before making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for @job-finalize before
+#     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @block-job-dismiss.  When true, this job will automatically
-#     disappear from the query list without user intervention.
-#     Defaults to true.  (Since 3.1)
+#     @job-dismiss.  When true, this job will automatically disappear
+#     from the query list without user intervention.  Defaults to
+#     true.  (Since 3.1)
 #
 # Since: 1.3
 ##
@@ -2531,16 +2530,16 @@
 #     'background' (Since: 3.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @block-job-finalize
-#     before making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for @job-finalize before
+#     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @block-job-dismiss.  When true, this job will automatically
-#     disappear from the query list without user intervention.
-#     Defaults to true.  (Since 3.1)
+#     @job-dismiss.  When true, this job will automatically disappear
+#     from the query list without user intervention.  Defaults to
+#     true.  (Since 3.1)
 #
 # @target-is-zero: Assume the destination reads as all zeroes before
 #     the mirror started.  Setting this to true can speed up the
@@ -2859,16 +2858,16 @@
 #     autogenerated.  (Since: 6.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for @block-job-finalize
-#     before making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for @job-finalize before
+#     making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state
 #     after it has completely ceased all work, and awaits
-#     @block-job-dismiss.  When true, this job will automatically
-#     disappear from the query list without user intervention.
-#     Defaults to true.  (Since 3.1)
+#     @job-dismiss.  When true, this job will automatically disappear
+#     from the query list without user intervention.  Defaults to
+#     true.  (Since 3.1)
 #
 # Errors:
 #     - If @device does not exist, DeviceNotFound.
@@ -3077,7 +3076,7 @@
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
 # make use of the BLOCK_JOB_READY event, block-job-cancel or
-# block-job-complete will still need to be used as appropriate.
+# job-complete will still need to be used as appropriate.
 #
 # @id: The job identifier.
 #
@@ -5866,7 +5865,7 @@
 # @BLOCK_JOB_PENDING:
 #
 # Emitted when a block job is awaiting explicit authorization to
-# finalize graph changes via @block-job-finalize.  If this job is part
+# finalize graph changes via @job-finalize.  If this job is part
 # of a transaction, it will not emit this event until the transaction
 # has converged first.
 #
-- 
2.48.1


