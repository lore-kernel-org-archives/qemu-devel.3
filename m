Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75675C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x57uF-0001YJ-Hx; Fri, 11 Sep 2026 16:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tb-0001Mk-GO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tV-00059S-0u
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789158644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqBqMGiKbrsHNyp8kl+Jbo3UWVW23oLGDfjdz49nmX8=;
 b=GapLao/Zexn/2Z8qTuaeNrxDDl2fvdc7jsOpcURu5mLVVmOkuXR9RlNPROgRN9l1EOMUtJ
 OYCciMBQDydxYWqOQKfGu6glnNX5RaxmS9NK+Ge88UCYUaSSWhzr2miyCeugCbtazOkOEK
 3Gn+N9oU1AmQW3eEeXkvSqgr4mopWR4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-xi5VbkQ5PmOtz07BqSIT2w-1; Fri,
 11 Sep 2026 16:30:42 -0400
X-MC-Unique: xi5VbkQ5PmOtz07BqSIT2w-1
X-Mimecast-MFC-AGG-ID: xi5VbkQ5PmOtz07BqSIT2w_1789158641
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F73B1802676; Fri, 11 Sep 2026 20:30:41 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BF955C0; Fri, 11 Sep 2026 20:30:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 5/9] qapi: split intro sections for commands
Date: Fri, 11 Sep 2026 16:29:58 -0400
Message-ID: <20260911203002.305316-6-jsnow@redhat.com>
In-Reply-To: <20260911203002.305316-1-jsnow@redhat.com>
References: <20260911203002.305316-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For commands, the primary difference between "intro" and "details" is
that the intro will appear "above the fold" on generated HTML
documentation (i.e. before argument/features tables), and "details"
will appear afterwards.

Review notes: As these are commands, the split is more
arbitrary. These commands all have quite a bit of text, so I tended to
split off just the first sentence or maybe the first paragraph. Some
of these are likely candidates for writing a new one-sentence synopsis
and shuffling most, if not all, of the existing prose down into the
details.

As an artifact from when these patches were part of a much, much
larger set of changes, the details split is not physically relocated
in these patches to keep the diffs simple and obvious to read. This
can be changed if desired, but it does produce uglier diffs and can
obscure prose changes where they arise.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json   | 76 ++++++++++++++++++------------------------
 qapi/block-export.json |  3 +-
 qapi/block.json        | 42 +++++++++++------------
 qapi/control.json      |  3 +-
 qapi/introspect.json   | 16 ++++-----
 qapi/job.json          | 43 +++++++++++-------------
 qapi/machine.json      | 30 ++++++++---------
 qapi/migration.json    |  9 +++--
 qapi/misc-i386.json    | 22 +++++-------
 qapi/misc.json         |  5 ++-
 qapi/net.json          |  3 +-
 qapi/stats.json        |  5 ++-
 qapi/transaction.json  |  6 ++--
 qapi/ui.json           |  3 +-
 14 files changed, 118 insertions(+), 148 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c505369aeb2..ec052f6bd2d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1516,8 +1516,7 @@
 
 ##
 # @block_resize:
-#
-# Resize a block image while a guest is running.
+#     Resize a block image while a guest is running.
 #
 # Either @device or @node-name must be set but not both.
 #
@@ -1842,9 +1841,8 @@
 
 ##
 # @block-commit:
-#
-# Live commit of data from overlay image nodes into backing nodes -
-# i.e., writes data between 'top' and 'base' into 'base'.
+#     Live commit of data from overlay image nodes into backing nodes
+#     - i.e., writes data between 'top' and 'base' into 'base'.
 #
 # If top == base, that is an error.  If top has no overlays on top of
 # it, or if it is in use by a writer, the job will not be completed by
@@ -2824,8 +2822,7 @@
 
 ##
 # @block-stream:
-#
-# Copy data from a backing file into a block device.
+#     Copy data from a backing file into a block device.
 #
 # The block streaming operation is performed in the background until
 # the entire backing file has been copied.  This command returns
@@ -2936,8 +2933,7 @@
 
 ##
 # @block-job-set-speed:
-#
-# Set maximum speed for a background block operation.
+#     Set maximum speed for a background block operation.
 #
 # This command can only be issued when there is an active block job.
 #
@@ -2962,8 +2958,7 @@
 
 ##
 # @block-job-cancel:
-#
-# Stop an active background block operation.
+#     Stop an active background block operation.
 #
 # This command returns immediately after marking the active background
 # block operation for cancellation.  It is an error to call this
@@ -3005,8 +3000,7 @@
 
 ##
 # @block-job-pause:
-#
-# Pause an active background block operation.
+#     Pause an active background block operation.
 #
 # This command returns immediately after marking the active job for
 # pausing.  Pausing an already paused job is an error.
@@ -3038,8 +3032,7 @@
 
 ##
 # @block-job-resume:
-#
-# Resume an active background block operation.
+#     Resume an active background block operation.
 #
 # This command returns immediately after resuming a paused job.
 # Resuming an already running job is an error.
@@ -3067,9 +3060,9 @@
 
 ##
 # @block-job-complete:
-#
-# Manually trigger completion of an active job in the READY or STANDBY
-# state.  Completing the job in any other state is an error.
+#     Manually trigger completion of an active job in the READY or
+#     STANDBY state.  Completing the job in any other state is an
+#     error.
 #
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
@@ -3107,14 +3100,13 @@
 
 ##
 # @block-job-dismiss:
-#
-# Deletes a job that is in the CONCLUDED state.  This command only
-# needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled.  In turn, automatic dismiss may be enabled only for
-# jobs that have @auto-dismiss option, which are `drive-backup`,
-# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
-# and `block-stream`.  @auto-dismiss is enabled by default for these
-# jobs.
+#     Deletes a job that is in the CONCLUDED state.  This command only
+#     needs to be run explicitly for jobs that don't have automatic
+#     dismiss enabled.  In turn, automatic dismiss may be enabled only
+#     for jobs that have @auto-dismiss option, which are
+#     `drive-backup`, `blockdev-backup`, `drive-mirror`,
+#     `blockdev-mirror`, `block-commit` and `block-stream`.
+#     @auto-dismiss is enabled by default for these jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, CONCLUDED.  For jobs that make use of
@@ -3136,11 +3128,10 @@
 
 ##
 # @block-job-finalize:
-#
-# Instructs all jobs in a transaction (or a single job if it is not
-# part of any transaction) to finalize any graph changes and do any
-# necessary cleanup.  This command requires that all involved jobs are
-# in the PENDING state.
+#     Instructs all jobs in a transaction (or a single job if it is
+#     not part of any transaction) to finalize any graph changes and
+#     do any necessary cleanup.  This command requires that all
+#     involved jobs are in the PENDING state.
 #
 # For jobs in a transaction, instructing one job to finalize will
 # force ALL jobs in the transaction to finalize, so it is only
@@ -4882,14 +4873,13 @@
 
 ##
 # @blockdev-reopen:
-#
-# Reopens one or more block devices using the given set of options.
-# Any option not specified will be reset to its default value
-# regardless of its previous status.  If an option cannot be changed
-# or a particular driver does not support reopening then the command
-# will return an error.  All devices in the list are reopened in one
-# transaction, so if one of them fails then the whole transaction is
-# cancelled.
+#     Reopens one or more block devices using the given set of
+#     options.  Any option not specified will be reset to its default
+#     value regardless of its previous status.  If an option cannot be
+#     changed or a particular driver does not support reopening then
+#     the command will return an error.  All devices in the list are
+#     reopened in one transaction, so if one of them fails then the
+#     whole transaction is cancelled.
 #
 # The command receives a list of block devices to reopen.  For each
 # one of them, the top-level @node-name option (from
@@ -4961,9 +4951,8 @@
 
 ##
 # @blockdev-set-active:
-#
-# Activate or deactivate a block device.  Use this to manage the
-# handover of block devices on migration with qemu-storage-daemon.
+#     Activate or deactivate a block device.  Use this to manage the
+#     handover of block devices on migration with qemu-storage-daemon.
 #
 # Activating a node automatically activates all of its child nodes
 # first.  Deactivating a node automatically deactivates any of its
@@ -5876,8 +5865,7 @@
 
 ##
 # @x-blockdev-change:
-#
-# Dynamically reconfigure the block driver state graph.
+#     Dynamically reconfigure the block driver state graph.
 #
 # Currently only supports adding and deleting quorum children.  A
 # child will be added at the end of the list of children.  Its
diff --git a/qapi/block-export.json b/qapi/block-export.json
index e9f7e72c8ee..77459f6321b 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -235,8 +235,7 @@
 
 ##
 # @nbd-server-add:
-#
-# Export a block node to QEMU's embedded NBD server.
+#     Export a block node to QEMU's embedded NBD server.
 #
 # The export name will be used as the id for the resulting block
 # export.
diff --git a/qapi/block.json b/qapi/block.json
index 15f08372564..73aad7f4f2b 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -128,11 +128,25 @@
 
 ##
 # @blockdev-open-tray:
+#     Opens a block device's tray.
 #
-# Opens a block device's tray.  If there is a block driver state tree
-# inserted as a medium, it will become inaccessible to the guest (but
-# it will remain associated to the block device, so closing the tray
-# will make it accessible again).
+# @device: Block device name
+#
+# @id: The name or QOM path of the guest device (since: 2.8)
+#
+# @force: if false (the default), an eject request will be sent to the
+#     guest if it has locked the tray (and the tray will not be opened
+#     immediately); if true, the tray will be opened regardless of
+#     whether it is locked
+#
+# Features:
+#
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
+# If there is a block driver state tree inserted as a medium, it will
+# become inaccessible to the guest (but it will remain associated to
+# the block device, so closing the tray will make it accessible
+# again).
 #
 # If the tray was already open before, this will be a no-op.
 #
@@ -145,19 +159,6 @@
 #   device attached to it
 # - if the guest device does not have an actual tray
 #
-# @device: Block device name
-#
-# @id: The name or QOM path of the guest device (since: 2.8)
-#
-# @force: if false (the default), an eject request will be sent to the
-#     guest if it has locked the tray (and the tray will not be opened
-#     immediately); if true, the tray will be opened regardless of
-#     whether it is locked
-#
-# Features:
-#
-# @deprecated: Member @device is deprecated.  Use @id instead.
-#
 # Since: 2.5
 #
 # .. qmp-example::
@@ -429,8 +430,10 @@
 
 ##
 # @block_set_io_throttle:
+#     Change I/O throttle limits for a block drive.
 #
-# Change I/O throttle limits for a block drive.
+# Errors:
+#     - If @device is not a valid block device, DeviceNotFound
 #
 # Since QEMU 2.4, each device with I/O limits is member of a throttle
 # group.
@@ -453,9 +456,6 @@
 # case the device will be removed from its group and the rest of its
 # members will not be affected.  The 'group' parameter is ignored.
 #
-# Errors:
-#     - If @device is not a valid block device, DeviceNotFound
-#
 # Since: 1.1
 #
 # .. qmp-example::
diff --git a/qapi/control.json b/qapi/control.json
index 0fc465936d8..b19ca910d5f 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -152,8 +152,7 @@
 
 ##
 # @quit:
-#
-# Request graceful QEMU process termination.
+#     Request graceful QEMU process termination.
 #
 # While every attempt is made to send the QMP response before
 # terminating, this is not guaranteed.  When using this interface, a
diff --git a/qapi/introspect.json b/qapi/introspect.json
index bd42aac3358..d579e5c8554 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -17,15 +17,15 @@
 
 ##
 # @query-qmp-schema:
+#     Command `query-qmp-schema` exposes the QMP wire ABI as an array
+#     of `SchemaInfo`.  This lets QMP clients figure out what commands
+#     and events are available in this QEMU, and their parameters and
+#     results.
 #
-# Command `query-qmp-schema` exposes the QMP wire ABI as an array of
-# `SchemaInfo`.  This lets QMP clients figure out what commands and
-# events are available in this QEMU, and their parameters and results.
-#
-# However, the `SchemaInfo` can't reflect all the rules and
-# restrictions that apply to QMP.  It's interface introspection
-# (figuring out what's there), not interface specification.  The
-# specification is in the QAPI schema.
+# The `SchemaInfo` can't reflect all the rules and restrictions that
+# apply to QMP.  It's interface introspection (figuring out what's
+# there), not interface specification.  The specification is in the
+# QAPI schema.
 #
 # Furthermore, while we strive to keep the QMP wire format
 # backwards-compatible across QEMU versions, the introspection output
diff --git a/qapi/job.json b/qapi/job.json
index b68d7292423..1aec4ceb9f1 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -128,8 +128,7 @@
 
 ##
 # @job-pause:
-#
-# Pause an active job.
+#     Pause an active job.
 #
 # This command returns immediately after marking the active job for
 # pausing.  Pausing an already paused job is an error.
@@ -148,8 +147,7 @@
 
 ##
 # @job-resume:
-#
-# Resume a paused job.
+#     Resume a paused job.
 #
 # This command returns immediately after resuming a paused job.
 # Resuming an already running job is an error.
@@ -165,10 +163,9 @@
 
 ##
 # @job-cancel:
-#
-# Instruct an active background job to cancel at the next opportunity.
-# This command returns immediately after marking the active job for
-# cancellation.
+#     Instruct an active background job to cancel at the next
+#     opportunity.  This command returns immediately after marking the
+#     active job for cancellation.
 #
 # The job will cancel as soon as possible and then emit a
 # `JOB_STATUS_CHANGE` event.  Usually, the status will change to
@@ -184,9 +181,9 @@
 
 ##
 # @job-complete:
-#
-# Manually trigger completion of an active job in the READY or STANDBY
-# state.  Completing the job in any other state is an error.
+#     Manually trigger completion of an active job in the READY or
+#     STANDBY state.  Completing the job in any other state is an
+#     error.
 #
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
@@ -211,14 +208,13 @@
 
 ##
 # @job-dismiss:
-#
-# Deletes a job that is in the CONCLUDED state.  This command only
-# needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled.  In turn, automatic dismiss may be enabled only for
-# jobs that have @auto-dismiss option, which are `drive-backup`,
-# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
-# and `block-stream`.  @auto-dismiss is enabled by default for these
-# jobs.
+#     Deletes a job that is in the CONCLUDED state.  This command only
+#     needs to be run explicitly for jobs that don't have automatic
+#     dismiss enabled.  In turn, automatic dismiss may be enabled only
+#     for jobs that have @auto-dismiss option, which are
+#     `drive-backup`, `blockdev-backup`, `drive-mirror`,
+#     `blockdev-mirror`, `block-commit` and `block-stream`.
+#     @auto-dismiss is enabled by default for these jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, CONCLUDED.  For jobs that make use of
@@ -233,11 +229,10 @@
 
 ##
 # @job-finalize:
-#
-# Instructs all jobs in a transaction (or a single job if it is not
-# part of any transaction) to finalize any graph changes and do any
-# necessary cleanup.  This command requires that all involved jobs are
-# in the PENDING state.
+#     Instructs all jobs in a transaction (or a single job if it is
+#     not part of any transaction) to finalize any graph changes and
+#     do any necessary cleanup.  This command requires that all
+#     involved jobs are in the PENDING state.
 #
 # For jobs in a transaction, instructing one job to finalize will
 # force ALL jobs in the transaction to finalize, so it is only
diff --git a/qapi/machine.json b/qapi/machine.json
index aaecd151407..45e79c18b09 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1978,12 +1978,12 @@
 ##
 # @query-cpu-model-comparison:
 #
-# Compares two CPU models, @modela and @modelb, returning how they
-# compare in a specific configuration.  The results indicates how both
-# models compare regarding runnability.  This result can be used by
-# tooling to make decisions if a certain CPU model will run in a
-# certain configuration or if a compatible CPU model has to be created
-# by baselining.
+#     Compares two CPU models, @modela and @modelb, returning how they
+#     compare in a specific configuration.  The results indicates how
+#     both models compare regarding runnability.  This result can be
+#     used by tooling to make decisions if a certain CPU model will
+#     run in a certain configuration or if a compatible CPU model has
+#     to be created by baselining.
 #
 # Usually, a CPU model is compared against the maximum possible CPU
 # model of a certain configuration (e.g. the "host" model for KVM).
@@ -2034,10 +2034,10 @@
 ##
 # @query-cpu-model-baseline:
 #
-# Baseline two CPU models, @modela and @modelb, creating a compatible
-# third model.  The created model will always be a static,
-# migration-safe CPU model (see "static" CPU model expansion for
-# details).
+#     Baseline two CPU models, @modela and @modelb, creating a
+#     compatible third model.  The created model will always be a
+#     static, migration-safe CPU model (see "static" CPU model
+#     expansion for details).
 #
 # This interface can be used by tooling to create a compatible CPU
 # model out two CPU models.  The created CPU model will be identical
@@ -2105,11 +2105,11 @@
 
 ##
 # @query-cpu-model-expansion:
-#
-# Expands a given CPU model, @model, (or a combination of CPU model +
-# additional options) to different granularities, specified by @type,
-# allowing tooling to get an understanding what a specific CPU model
-# looks like in QEMU under a certain configuration.
+#     Expands a given CPU model, @model, (or a combination of CPU
+#     model + additional options) to different granularities,
+#     specified by @type, allowing tooling to get an understanding
+#     what a specific CPU model looks like in QEMU under a certain
+#     configuration.
 #
 # This interface can be used to query the "host" CPU model.
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 13c446b922f..2c490736019 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1820,9 +1820,9 @@
 
 ##
 # @calc-dirty-rate:
-#
-# Start measuring dirty page rate of the VM.  Results can be retrieved
-# with `query-dirty-rate` after measurements are completed.
+#     Start measuring dirty page rate of the VM.  Results can be
+#     retrieved with `query-dirty-rate` after measurements are
+#     completed.
 #
 # Dirty page rate is the number of pages changed in a given time
 # period expressed in MiB/s.  The following methods of calculation are
@@ -1939,8 +1939,7 @@
 
 ##
 # @set-vcpu-dirty-limit:
-#
-# Set the upper limit of dirty page rate for virtual CPUs.
+#     Set the upper limit of dirty page rate for virtual CPUs.
 #
 # Requires KVM with accelerator property "dirty-ring-size" set.  A
 # virtual CPU's dirty page rate is a measure of its memory load.  To
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 78ec9aec647..6e0ab46b8ea 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -5,10 +5,9 @@
 
 ##
 # @rtc-reset-reinjection:
-#
-# Reset the RTC interrupt reinjection backlog.  Can be used if another
-# mechanism to synchronize guest time is in effect, for example QEMU
-# guest agent's `guest-set-time` command.
+#     Reset the RTC interrupt reinjection backlog.  Can be used if
+#     another mechanism to synchronize guest time is in effect, for
+#     example QEMU guest agent's `guest-set-time` command.
 #
 # Use of this command is only applicable for x86 machines with an RTC,
 # and on other machines will silently return without performing any
@@ -119,8 +118,7 @@
 
 ##
 # @query-sev:
-#
-# Return information about SEV/SEV-ES/SEV-SNP.
+#     Return information about SEV/SEV-ES/SEV-SNP.
 #
 # If unavailable due to an incompatible configuration the returned
 # @enabled field is set to 'false' and the state of all other fields
@@ -149,8 +147,7 @@
 
 ##
 # @query-sev-launch-measure:
-#
-# Query the SEV/SEV-ES guest launch information.
+#     Query the SEV/SEV-ES guest launch information.
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  The launch
@@ -199,8 +196,7 @@
 
 ##
 # @query-sev-capabilities:
-#
-# Get SEV capabilities.
+#     Get SEV capabilities.
 #
 # This is only supported on AMD X86 platforms with KVM enabled.
 #
@@ -220,8 +216,7 @@
 
 ##
 # @sev-inject-launch-secret:
-#
-# Inject a secret blob into a SEV/SEV-ES guest's memory.
+#     Inject a secret blob into a SEV/SEV-ES guest's memory.
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  SEV-SNP guests do
@@ -257,8 +252,7 @@
 
 ##
 # @query-sev-attestation-report:
-#
-# Get the SEV attestation report.
+#     Get the SEV attestation report.
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  The attestation
diff --git a/qapi/misc.json b/qapi/misc.json
index 374711ac6c7..44f38b60448 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -12,9 +12,8 @@
 
 ##
 # @add_client:
-#
-# Allow client connections for VNC, Spice and socket based character
-# devices to be passed in to QEMU via SCM_RIGHTS.
+#     Allow client connections for VNC, Spice and socket based
+#     character devices to be passed in to QEMU via SCM_RIGHTS.
 #
 # If the FD associated with @fdname is not a socket, the command will
 # fail and the FD will be closed.
diff --git a/qapi/net.json b/qapi/net.json
index 50dc3137182..6beabc0e9dd 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -37,8 +37,7 @@
 
 ##
 # @netdev_add:
-#
-# Add a network backend.
+#     Add a network backend.
 #
 # Additional arguments depend on the type.
 #
diff --git a/qapi/stats.json b/qapi/stats.json
index af57ec08546..e9d05390c31 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -175,9 +175,8 @@
 
 ##
 # @query-stats:
-#
-# Return runtime-collected statistics for objects such as the VM or
-# its vCPUs.
+#     Return runtime-collected statistics for objects such as the VM
+#     or its vCPUs.
 #
 # The arguments are a `StatsFilter` and specify the provider and
 # objects to return statistics about.
diff --git a/qapi/transaction.json b/qapi/transaction.json
index c0dc811ba61..02e1d072c63 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -198,9 +198,9 @@
 ##
 # @transaction:
 #
-# Executes a number of transactionable QMP commands atomically.  If
-# any operation fails, then the entire set of actions will be
-# abandoned and the appropriate error returned.
+#     Executes a number of transactionable QMP commands atomically.
+#     If any operation fails, then the entire set of actions will be
+#     abandoned and the appropriate error returned.
 #
 # For external snapshots, the dictionary contains the device, the file
 # to use for the new snapshot, and the format.  The default format, if
diff --git a/qapi/ui.json b/qapi/ui.json
index a59cd635774..73ee2cb2056 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1198,8 +1198,7 @@
 
 ##
 # @input-send-event:
-#
-# Send input event(s) to guest.
+#     Send input event(s) to guest.
 #
 # The @device and @head parameters can be used to send the input event
 # to specific input devices in case (a) multiple input devices of the
-- 
2.55.0


