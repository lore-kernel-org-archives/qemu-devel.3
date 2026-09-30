Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41036CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrjA-0001iE-7m; Wed, 30 Sep 2026 06:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrij-0001Js-Cs
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0006kM-6v
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PlLrn9wGndDEMy+JfzZPCt4u/0jgARRvlbVgPfgTg8=;
 b=VCWUuPy0HkF7O1wOZUoi7RIgvY5SHnn90XEFkbSav/Ppzfao5ukiL/qGtC+rBxSxpYNVTT
 hDHpdp2kWVR95iUqMZ++oGH9JwgQs/XM3oBRzcCLeoS1Y3eS/aOep3wRumdRWXy+Ml9oBo
 q8nKlrzrr1q2wHHnAqEmCAphlzL/vQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-sgERfqqjPgKx43-ic2b-pA-1; Wed,
 30 Sep 2026 06:39:23 -0400
X-MC-Unique: sgERfqqjPgKx43-ic2b-pA-1
X-Mimecast-MFC-AGG-ID: sgERfqqjPgKx43-ic2b-pA_1790764762
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 333FE195DE60; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF03D1800361; Wed, 30 Sep 2026 10:39:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F61E21E682C; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 041/105] qapi: convert trivial intro sections for migration.json
Date: Wed, 30 Sep 2026 12:38:06 +0200
Message-ID: <20260930103910.3934848-42-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260831201945.287730-42-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 131 ++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 83 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 9a1cc7c4e5..91681cdf03 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -13,8 +13,7 @@
 
 ##
 # @MigrationRAMStats:
-#
-# Detailed migration status.
+#     Detailed migration status.
 #
 # @transferred: amount of bytes already transferred to the target VM
 #
@@ -78,8 +77,7 @@
 
 ##
 # @XBZRLECacheStats:
-#
-# Detailed XBZRLE migration cache statistics
+#     Detailed XBZRLE migration cache statistics
 #
 # @cache-size: XBZRLE cache size
 #
@@ -104,8 +102,7 @@
 
 ##
 # @CompressionStats:
-#
-# Detailed migration compression statistics
+#     Detailed migration compression statistics
 #
 # @pages: amount of pages compressed and transferred to the target VM
 #
@@ -126,8 +123,7 @@
 
 ##
 # @MigrationStatus:
-#
-# An enumeration of migration status.
+#     An enumeration of migration status.
 #
 # @none: no migration has ever happened.
 #
@@ -189,8 +185,7 @@
 
 ##
 # @VfioStats:
-#
-# Detailed VFIO devices migration statistics
+#     Detailed VFIO devices migration statistics
 #
 # @transferred: amount of bytes transferred to the target VM by VFIO
 #     devices
@@ -202,8 +197,7 @@
 
 ##
 # @MigrationInfo:
-#
-# Information about current migration process.
+#     Information about current migration process.
 #
 # @status: `MigrationStatus` describing the current migration status.
 #     If this field is not returned, no migration process has been
@@ -435,8 +429,7 @@
 
 ##
 # @MigrationCapability:
-#
-# Migration capabilities enumeration
+#     Migration capabilities enumeration
 #
 # @xbzrle: Migration supports xbzrle (Xor Based Zero Run Length
 #     Encoding).  This feature allows us to minimize migration traffic
@@ -545,8 +538,7 @@
 
 ##
 # @MigrationCapabilityStatus:
-#
-# Migration capability information
+#     Migration capability information
 #
 # @capability: capability enum
 #
@@ -559,8 +551,8 @@
 
 ##
 # @migrate-set-capabilities:
-#
-# Enable/Disable the following migration capabilities (like xbzrle)
+#     Enable/Disable the following migration capabilities (like
+#     xbzrle)
 #
 # @capabilities: json array of capability modifications to make
 #
@@ -577,8 +569,8 @@
 
 ##
 # @query-migrate-capabilities:
-#
-# Return information about the current migration capabilities status
+#     Return information about the current migration capabilities
+#     status
 #
 # Since: 1.2
 #
@@ -598,8 +590,7 @@
 
 ##
 # @MultiFDCompression:
-#
-# An enumeration of multifd compression methods.
+#     An enumeration of multifd compression methods.
 #
 # @none: no compression.
 #
@@ -776,9 +767,8 @@
 
 ##
 # @BitmapMigrationNodeAlias:
-#
-# Maps a block node name and the bitmaps it has to aliases for dirty
-# bitmap migration.
+#     Maps a block node name and the bitmaps it has to aliases for
+#     dirty bitmap migration.
 #
 # @node-name: A block node name.
 #
@@ -1111,8 +1101,7 @@
 
 ##
 # @MIGRATION:
-#
-# Emitted when a migration event happens
+#     Emitted when a migration event happens
 #
 # @status: `MigrationStatus` describing the current migration status.
 #
@@ -1129,9 +1118,8 @@
 
 ##
 # @MIGRATION_PASS:
-#
-# Emitted from the source side of a migration at the start of each
-# pass (when it syncs the dirty bitmap)
+#     Emitted from the source side of a migration at the start of each
+#     pass (when it syncs the dirty bitmap)
 #
 # @pass: An incrementing count (starting at 1 on the first pass)
 #
@@ -1147,8 +1135,8 @@
 
 ##
 # @COLOMessage:
-#
-# The message transmission between Primary side and Secondary side.
+#     The message transmission between Primary side and Secondary
+#     side.
 #
 # @checkpoint-ready: Secondary VM (SVM) is ready for checkpointing
 #
@@ -1174,8 +1162,7 @@
 
 ##
 # @COLOMode:
-#
-# The COLO current mode.
+#     The COLO current mode.
 #
 # @none: COLO is disabled.
 #
@@ -1190,8 +1177,7 @@
 
 ##
 # @FailoverStatus:
-#
-# An enumeration of COLO failover status
+#     An enumeration of COLO failover status
 #
 # @none: no failover has ever happened
 #
@@ -1211,9 +1197,8 @@
 
 ##
 # @COLO_EXIT:
-#
-# Emitted when VM finishes COLO mode due to some errors happening or
-# at the request of users.
+#     Emitted when VM finishes COLO mode due to some errors happening
+#     or at the request of users.
 #
 # @mode: report COLO mode when COLO exited.
 #
@@ -1231,8 +1216,7 @@
 
 ##
 # @COLOExitReason:
-#
-# The reason for a COLO exit.
+#     The reason for a COLO exit.
 #
 # @none: failover has never happened.  This state does not occur in
 #     the `COLO_EXIT` event, and is only visible in the result of
@@ -1294,8 +1278,7 @@
 
 ##
 # @migrate-continue:
-#
-# Continue migration when it's in a paused state.
+#     Continue migration when it's in a paused state.
 #
 # @state: The state the migration is currently expected to be in
 #
@@ -1311,8 +1294,7 @@
 
 ##
 # @MigrationAddressType:
-#
-# The migration stream transport mechanisms.
+#     The migration stream transport mechanisms.
 #
 # @socket: Migrate via socket.
 #
@@ -1352,8 +1334,7 @@
 
 ##
 # @MigrationAddress:
-#
-# Migration endpoint configuration.
+#     Migration endpoint configuration.
 #
 # @transport: The migration stream transport mechanism
 #
@@ -1370,8 +1351,7 @@
 
 ##
 # @MigrationChannelType:
-#
-# The migration channel-type request options.
+#     The migration channel-type request options.
 #
 # @main: Main outbound migration channel.
 #
@@ -1384,8 +1364,7 @@
 
 ##
 # @MigrationChannel:
-#
-# Migration stream channel parameters.
+#     Migration stream channel parameters.
 #
 # @channel-type: Channel type for transferring packet information.
 #
@@ -1400,8 +1379,7 @@
 
 ##
 # @migrate:
-#
-# Migrates the current running guest to another Virtual Machine.
+#     Migrates the current running guest to another Virtual Machine.
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
@@ -1573,8 +1551,7 @@
 
 ##
 # @xen-set-global-dirty-log:
-#
-# Enable or disable the global dirty log mode.
+#     Enable or disable the global dirty log mode.
 #
 # @enable: true to enable, false to disable.
 #
@@ -1610,8 +1587,7 @@
 
 ##
 # @xen-set-replication:
-#
-# Enable or disable replication.
+#     Enable or disable replication.
 #
 # @enable: true to enable, false to disable.
 #
@@ -1634,8 +1610,7 @@
 
 ##
 # @ReplicationStatus:
-#
-# The result format for `query-xen-replication-status`.
+#     The result format for `query-xen-replication-status`.
 #
 # @error: true if an error happened, false if replication is normal.
 #
@@ -1683,8 +1658,7 @@
 
 ##
 # @COLOStatus:
-#
-# The result format for `query-colo-status`.
+#     The result format for `query-colo-status`.
 #
 # @mode: COLO running mode.  If COLO is running, this field will
 #     return 'primary' or 'secondary'.
@@ -1722,8 +1696,7 @@
 
 ##
 # @migrate-recover:
-#
-# Provide a recovery migration stream URI.
+#     Provide a recovery migration stream URI.
 #
 # @uri: the URI to be used for the recovery of migration stream.
 #
@@ -1776,8 +1749,7 @@
 
 ##
 # @DirtyRateVcpu:
-#
-# Dirty rate of vcpu.
+#     Dirty rate of vcpu.
 #
 # @id: vcpu index.
 #
@@ -1790,8 +1762,7 @@
 
 ##
 # @DirtyRateStatus:
-#
-# Dirty page rate measurement status.
+#     Dirty page rate measurement status.
 #
 # @unstarted: measuring thread has not been started yet
 #
@@ -1823,8 +1794,7 @@
 
 ##
 # @TimeUnit:
-#
-# Specifies unit in which time-related value is specified.
+#     Specifies unit in which time-related value is specified.
 #
 # @second: value is in seconds
 #
@@ -1837,8 +1807,7 @@
 
 ##
 # @DirtyRateInfo:
-#
-# Information about measured dirty page rate.
+#     Information about measured dirty page rate.
 #
 # @dirty-rate: an estimate of the dirty page rate of the VM in units
 #     of MiB/s.  Value is present only when @status is 'measured'.
@@ -1948,8 +1917,8 @@
 
 ##
 # @query-dirty-rate:
-#
-# Query results of the most recent invocation of `calc-dirty-rate`.
+#     Query results of the most recent invocation of
+#     `calc-dirty-rate`.
 #
 # @calc-time-unit: time unit in which to report calculation time.
 #     By default it is reported in seconds.  (Since 8.2)
@@ -1975,8 +1944,7 @@
 
 ##
 # @DirtyLimitInfo:
-#
-# Dirty page rate limit information of a virtual CPU.
+#     Dirty page rate limit information of a virtual CPU.
 #
 # @cpu-index: index of a virtual CPU.
 #
@@ -2042,8 +2010,8 @@
 
 ##
 # @query-vcpu-dirty-limit:
-#
-# Return information about virtual CPU dirty page rate limits, if any.
+#     Return information about virtual CPU dirty page rate limits, if
+#     any.
 #
 # Since: 7.1
 #
@@ -2059,8 +2027,7 @@
 
 ##
 # @snapshot-save:
-#
-# Save a VM snapshot
+#     Save a VM snapshot
 #
 # @job-id: identifier for the newly created job
 #
@@ -2131,8 +2098,7 @@
 
 ##
 # @snapshot-load:
-#
-# Load a VM snapshot
+#     Load a VM snapshot
 #
 # @job-id: identifier for the newly created job
 #
@@ -2201,8 +2167,7 @@
 
 ##
 # @snapshot-delete:
-#
-# Delete a VM snapshot
+#     Delete a VM snapshot
 #
 # @job-id: identifier for the newly created job
 #
-- 
2.55.0


