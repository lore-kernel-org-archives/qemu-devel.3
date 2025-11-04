Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52436CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGzH-0000IY-SD; Tue, 04 Nov 2025 08:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyh-0000DL-DZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyb-0001Q2-L8
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PTyIsJ5W1EI9RLAOXgIRsJxrt+N4ltcXSktjLRysZ4=;
 b=A0SNUMCxi6s2ti1TAELa/c9RHJkMImyY5LbNO9cx0122Rh/D65Z9EmXcaPudwvSVfHsv13
 waHEUwYgtrhp6RldiGU+TVvLTc5Xli0MdnhkkaYkiytbMnDmAcEcrDsyaBYMm/0FFKpdGX
 CCtl/Vfmj8jSZ9tu4CLCXlY/iSpGRM8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-tEA84LapNSuxIkBCSRCLsg-1; Tue,
 04 Nov 2025 08:21:30 -0500
X-MC-Unique: tEA84LapNSuxIkBCSRCLsg-1
X-Mimecast-MFC-AGG-ID: tEA84LapNSuxIkBCSRCLsg_1762262490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76A7E1956094; Tue,  4 Nov 2025 13:21:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BA23180057F; Tue,  4 Nov 2025 13:21:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D1FA21E675E; Tue, 04 Nov 2025 14:21:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 04/12] qapi: Refill doc comments to conform to conventions
Date: Tue,  4 Nov 2025 14:21:17 +0100
Message-ID: <20251104132125.4134730-5-armbru@redhat.com>
In-Reply-To: <20251104132125.4134730-1-armbru@redhat.com>
References: <20251104132125.4134730-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sweep the entire documentation again.  Last done in commit
01bed0ff14b (qapi: Refill doc comments to conform to conventions).

To check the generated documentation does not change, I compared the
generated HTML before and after this commit with "wdiff -3".  Finds no
differences.  Comparing with diff is not useful, as the reflown
paragraphs are visible there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20251103082354.3273027-3-armbru@redhat.com>
---
 qapi/accelerator.json    |   3 +-
 qapi/acpi-hest.json      |   4 +-
 qapi/block-core.json     | 158 ++++++++++++++++++++-------------------
 qapi/block-export.json   |  26 ++++---
 qapi/crypto.json         |   7 +-
 qapi/introspect.json     |   8 +-
 qapi/job.json            |  30 ++++----
 qapi/machine-common.json |   4 +-
 qapi/machine-s390x.json  |   4 +-
 qapi/machine.json        |  49 ++++++------
 qapi/migration.json      | 123 +++++++++++++++---------------
 qapi/net.json            |  23 +++---
 qapi/qdev.json           |   4 +-
 qapi/qom.json            |  44 +++++------
 qapi/run-state.json      |  19 ++---
 qapi/sockets.json        |  30 ++++----
 qapi/stats.json          |   4 +-
 qapi/ui.json             |  15 ++--
 qapi/virtio.json         |   4 +-
 19 files changed, 293 insertions(+), 266 deletions(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 2b92060884..0cf5e0f9d9 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -87,7 +87,8 @@
 #
 # @enabled: the accelerator that is in use
 #
-# @present: the list of accelerators that are built into this executable
+# @present: the list of accelerators that are built into this
+#     executable
 #
 # Since: 10.2.0
 ##
diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
index 28af1266a7..88c53eaf1b 100644
--- a/qapi/acpi-hest.json
+++ b/qapi/acpi-hest.json
@@ -5,8 +5,8 @@
 ##
 # == GHESv2 CPER Error Injection
 #
-# Defined since ACPI Specification 6.1,
-# section 18.3.2.8 Generic Hardware Error Source version 2. See:
+# Defined since ACPI Specification 6.1, section 18.3.2.8 Generic
+# Hardware Error Source version 2.  See:
 #
 # https://uefi.org/sites/default/files/resources/ACPI_6_1.pdf
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2c037183f0..b82af74256 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -159,14 +159,15 @@
 ##
 # @ImageInfoSpecificRbd:
 #
-# @encryption-format: Image encryption format. If encryption is enabled for the
-#     image (see encrypted in BlockNodeInfo), this is the actual format in which the
-#     image is accessed. If encryption is not enabled, this is the result of
-#     probing when the image was opened, to give a suggestion which encryption
-#     format could be enabled. Note that probing results can be changed by the
-#     guest by writing a (possibly partial) encryption format header to the
-#     image, so don't treat this information as trusted if the guest is not
-#     trusted.
+# @encryption-format: Image encryption format.  If encryption is
+#     enabled for the image (see encrypted in BlockNodeInfo), this is
+#     the actual format in which the image is accessed.  If encryption
+#     is not enabled, this is the result of probing when the image was
+#     opened, to give a suggestion which encryption format could be
+#     enabled.  Note that probing results can be changed by the guest
+#     by writing a (possibly partial) encryption format header to the
+#     image, so don't treat this information as trusted if the guest
+#     is not trusted.
 #
 # Since: 6.1
 ##
@@ -406,8 +407,8 @@
 # node, annotated with information about that node in relation to its
 # parent.
 #
-# @name: Child name of the root node in the `BlockGraphInfo` struct, in
-#     its role as the child of some undescribed parent node
+# @name: Child name of the root node in the `BlockGraphInfo` struct,
+#     in its role as the child of some undescribed parent node
 #
 # @info: Block graph information starting at this node
 #
@@ -573,11 +574,12 @@
 # @backing_file_depth: number of files in the backing file chain
 #     (since: 1.2)
 #
-# @children: Information about child block nodes. (since: 10.1)
+# @children: Information about child block nodes.  (since: 10.1)
 #
-# @active: true if the backend is active; typical cases for inactive backends
-#     are on the migration source instance after migration completes and on the
-#     destination before it completes.  (since: 10.0)
+# @active: true if the backend is active; typical cases for inactive
+#     backends are on the migration source instance after migration
+#     completes and on the destination before it completes.
+#     (since: 10.0)
 #
 # @encrypted: true if the backing device is encrypted
 #
@@ -853,8 +855,8 @@
 #
 # Get a list of `BlockInfo` for all virtual block devices.
 #
-# Returns: a list describing each virtual block device.
-#     Filter nodes that were created implicitly are skipped over.
+# Returns: a list describing each virtual block device.  Filter nodes
+#     that were created implicitly are skipped over.
 #
 # Since: 0.14
 #
@@ -1693,11 +1695,12 @@
 #     different block device than @device).
 #
 # @on-cbw-error: policy defining behavior on I/O errors in
-#     copy-before-write jobs; defaults to break-guest-write.  (Since 10.1)
+#     copy-before-write jobs; defaults to break-guest-write.
+#     (Since 10.1)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for `job-finalize` before
-#     making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for `job-finalize`
+#     before making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 2.12)
 #
@@ -1809,7 +1812,8 @@
 #
 # @allow-write-only-overlay: If present, the check whether this
 #     operation is safe was relaxed so that it can be used to change
-#     backing file of a destination of a `blockdev-mirror`.  (since 5.0)
+#     backing file of a destination of a `blockdev-mirror`.
+#     (since 5.0)
 #
 # Since: 2.5
 #
@@ -1873,8 +1877,8 @@
 #
 # If top == base, that is an error.  If top has no overlays on top of
 # it, or if it is in use by a writer, the job will not be completed by
-# itself.  The user needs to complete the job with the
-# `job-complete` command after getting the ready event.  (Since 2.0)
+# itself.  The user needs to complete the job with the `job-complete`
+# command after getting the ready event.  (Since 2.0)
 #
 # If the base image is smaller than top, then the base image will be
 # resized to be the same size as top.  If top is smaller than the base
@@ -1936,8 +1940,8 @@
 #     autogenerated.  (Since: 2.9)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for `job-finalize` before
-#     making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for `job-finalize`
+#     before making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
@@ -2010,10 +2014,10 @@
 # @blockdev-backup:
 #
 # Start a point-in-time copy of a block device to a new destination.
-# The status of ongoing `blockdev-backup` operations can be checked with
-# `query-block-jobs` where the `BlockJobInfo`.type field has the value
-# 'backup'.  The operation can be stopped before it has completed
-# using the `job-cancel` or `block-job-cancel` command.
+# The status of ongoing `blockdev-backup` operations can be checked
+# with `query-block-jobs` where the `BlockJobInfo`.type field has the
+# value 'backup'.  The operation can be stopped before it has
+# completed using the `job-cancel` or `block-job-cancel` command.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -2297,8 +2301,8 @@
 #     'background' (Since: 3.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for `job-finalize` before
-#     making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for `job-finalize`
+#     before making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
@@ -2348,7 +2352,8 @@
 #
 # @disabled: the bitmap is created in the disabled state, which means
 #     that it will not track drive changes.  The bitmap may be enabled
-#     with `block-dirty-bitmap-enable`.  Default is false.  (Since: 4.0)
+#     with `block-dirty-bitmap-enable`.  Default is false.
+#     (Since: 4.0)
 #
 # Since: 2.4
 ##
@@ -2413,8 +2418,8 @@
 # @block-dirty-bitmap-remove:
 #
 # Stop write tracking and remove the dirty bitmap that was created
-# with `block-dirty-bitmap-add`.  If the bitmap is persistent, remove it
-# from its storage too.
+# with `block-dirty-bitmap-add`.  If the bitmap is persistent, remove
+# it from its storage too.
 #
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
@@ -2612,8 +2617,8 @@
 #     'background' (Since: 3.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for `job-finalize` before
-#     making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for `job-finalize`
+#     before making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
@@ -2939,8 +2944,8 @@
 #     autogenerated.  (Since: 6.0)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state
-#     after it has finished its work, waiting for `job-finalize` before
-#     making any block graph changes.  When true, this job will
+#     after it has finished its work, waiting for `job-finalize`
+#     before making any block graph changes.  When true, this job will
 #     automatically perform its abort or commit actions.  Defaults to
 #     true.  (Since 3.1)
 #
@@ -3110,16 +3115,16 @@
 #
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
-# mirroring includes `drive-mirror`, `blockdev-mirror` and `block-commit`
-# job (only in case of "active commit", when the node being commited
-# is used by the guest).  The ability to complete is signaled with a
-# `BLOCK_JOB_READY` event.
+# mirroring includes `drive-mirror`, `blockdev-mirror` and
+# `block-commit` job (only in case of "active commit", when the node
+# being commited is used by the guest).  The ability to complete is
+# signaled with a `BLOCK_JOB_READY` event.
 #
 # This command completes an active background block operation
 # synchronously.  The ordering of this command's return with the
-# `BLOCK_JOB_COMPLETED` event is not defined.  Note that if an I/O error
-# occurs during the processing of this command: 1) the command itself
-# will fail; 2) the error will be processed according to the
+# `BLOCK_JOB_COMPLETED` event is not defined.  Note that if an I/O
+# error occurs during the processing of this command: 1) the command
+# itself will fail; 2) the error will be processed according to the
 # rerror/werror arguments that were specified when starting the
 # operation.
 #
@@ -3147,10 +3152,10 @@
 #
 # Deletes a job that is in the CONCLUDED state.  This command only
 # needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled.  In turn, automatic dismiss may be enabled only
-# for jobs that have @auto-dismiss option, which are `drive-backup`,
-# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit` and
-# `block-stream`.  @auto-dismiss is enabled by default for these
+# dismiss enabled.  In turn, automatic dismiss may be enabled only for
+# jobs that have @auto-dismiss option, which are `drive-backup`,
+# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
+# and `block-stream`.  @auto-dismiss is enabled by default for these
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
@@ -3183,8 +3188,8 @@
 # force ALL jobs in the transaction to finalize, so it is only
 # necessary to instruct a single member job to finalize.
 #
-# The command is applicable only to jobs which have @auto-finalize option
-# and only when this option is set to false.
+# The command is applicable only to jobs which have @auto-finalize
+# option and only when this option is set to false.
 #
 # @id: The job identifier.
 #
@@ -4814,9 +4819,9 @@
 # @cache: cache-related options
 #
 # @active: whether the block node should be activated (default: true).
-#     Having inactive block nodes is useful primarily for migration because it
-#     allows opening an image on the destination while the source is still
-#     holding locks for it.  (Since 10.0)
+#     Having inactive block nodes is useful primarily for migration
+#     because it allows opening an image on the destination while the
+#     source is still holding locks for it.  (Since 10.0)
 #
 # @read-only: whether the block device should be read-only (default:
 #     false).  Note that some block drivers support only read-only
@@ -5008,11 +5013,12 @@
 # cancelled.
 #
 # The command receives a list of block devices to reopen.  For each
-# one of them, the top-level @node-name option (from `BlockdevOptions`)
-# must be specified and is used to select the block device to be
-# reopened.  Other @node-name options must be either omitted or set to
-# the current name of the appropriate node.  This command won't change
-# any node name and any attempt to do it will result in an error.
+# one of them, the top-level @node-name option (from
+# `BlockdevOptions`) must be specified and is used to select the block
+# device to be reopened.  Other @node-name options must be either
+# omitted or set to the current name of the appropriate node.  This
+# command won't change any node name and any attempt to do it will
+# result in an error.
 #
 # In the case of options that refer to child nodes, the behavior of
 # this command depends on the value:
@@ -5031,10 +5037,10 @@
 # Options (1) and (2) are supported in all cases.  Option (3) is
 # supported for @file and @backing, and option (4) for @backing only.
 #
-# Unlike with `blockdev-add`, the @backing option must always be present
-# unless the node being reopened does not have a backing file and its
-# image does not have a default backing file name as part of its
-# metadata.
+# Unlike with `blockdev-add`, the @backing option must always be
+# present unless the node being reopened does not have a backing file
+# and its image does not have a default backing file name as part of
+# its metadata.
 #
 # Since: 6.1
 ##
@@ -5045,8 +5051,8 @@
 ##
 # @blockdev-del:
 #
-# Deletes a block device that has been added using `blockdev-add`.  The
-# command will fail if the node is attached to a device or is
+# Deletes a block device that has been added using `blockdev-add`.
+# The command will fail if the node is attached to a device or is
 # otherwise being used.
 #
 # @node-name: Name of the graph node to delete.
@@ -5078,18 +5084,18 @@
 ##
 # @blockdev-set-active:
 #
-# Activate or inactivate a block device.  Use this to manage the handover of
-# block devices on migration with qemu-storage-daemon.
+# Activate or inactivate a block device.  Use this to manage the
+# handover of block devices on migration with qemu-storage-daemon.
 #
-# Activating a node automatically activates all of its child nodes first.
-# Inactivating a node automatically inactivates any of its child nodes that are
-# not in use by a still active node.
+# Activating a node automatically activates all of its child nodes
+# first.  Inactivating a node automatically inactivates any of its
+# child nodes that are not in use by a still active node.
 #
-# @node-name: Name of the graph node to activate or inactivate.  By default, all
-#     nodes are affected by the operation.
+# @node-name: Name of the graph node to activate or inactivate.  By
+#     default, all nodes are affected by the operation.
 #
-# @active: true if the nodes should be active when the command returns success,
-#     false if they should be inactive.
+# @active: true if the nodes should be active when the command returns
+#     success, false if they should be inactive.
 #
 # Since: 10.0
 #
@@ -5945,9 +5951,9 @@
 # @BLOCK_JOB_PENDING:
 #
 # Emitted when a block job is awaiting explicit authorization to
-# finalize graph changes via `job-finalize`.  If this job is part
-# of a transaction, it will not emit this event until the transaction
-# has converged first.
+# finalize graph changes via `job-finalize`.  If this job is part of a
+# transaction, it will not emit this event until the transaction has
+# converged first.
 #
 # @type: job type
 #
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 6878b89dcf..076954ef1a 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -38,8 +38,8 @@
 ##
 # @NbdServerOptions:
 #
-# Keep this type consistent with the `NbdServerOptionsLegacy` type.  The
-# only intended difference is using `SocketAddress` instead of
+# Keep this type consistent with the `NbdServerOptionsLegacy` type.
+# The only intended difference is using `SocketAddress` instead of
 # `SocketAddressLegacy`.
 #
 # @addr: Address on which to listen (since 4.2).
@@ -51,8 +51,8 @@
 ##
 # @NbdServerOptionsLegacy:
 #
-# Keep this type consistent with the `NbdServerOptions` type.  The only
-# intended difference is using `SocketAddressLegacy` instead of
+# Keep this type consistent with the `NbdServerOptions` type.  The
+# only intended difference is using `SocketAddressLegacy` instead of
 # `SocketAddress`.
 #
 # @addr: Address on which to listen (since 1.3).
@@ -125,8 +125,8 @@
 # A vhost-user-blk block export.
 #
 # @addr: The vhost-user socket on which to listen.  Both 'unix' and
-#     'fd' `SocketAddress` types are supported.  Passed fds must be UNIX
-#     domain sockets.
+#     'fd' `SocketAddress` types are supported.  Passed fds must be
+#     UNIX domain sockets.
 #
 # @logical-block-size: Logical block size in bytes.  Defaults to 512
 #     bytes.
@@ -373,11 +373,12 @@
 #     cannot be moved to the iothread.  The default is false.
 #     (since: 5.2)
 #
-# @allow-inactive: If true, the export allows the exported node to be inactive.
-#     If it is created for an inactive block node, the node remains inactive.  If
-#     the export type doesn't support running on an inactive node, an error is
-#     returned.  If false, inactive block nodes are automatically activated before
-#     creating the export and trying to inactivate them later fails.
+# @allow-inactive: If true, the export allows the exported node to be
+#     inactive.  If it is created for an inactive block node, the node
+#     remains inactive.  If the export type doesn't support running on
+#     an inactive node, an error is returned.  If false, inactive
+#     block nodes are automatically activated before creating the
+#     export and trying to inactivate them later fails.
 #     (since: 10.0; default: false)
 #
 # Since: 4.2
@@ -460,7 +461,8 @@
 # @node-name: The node name of the block node that is exported
 #
 # @shutting-down: True if the export is shutting down (e.g. after a
-#     `block-export-del` command, but before the shutdown has completed)
+#     `block-export-del` command, but before the shutdown has
+#     completed)
 #
 # Since: 5.2
 ##
diff --git a/qapi/crypto.json b/qapi/crypto.json
index ab6eda4c2f..72ac718147 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -46,7 +46,8 @@
 #
 # @md5: MD5.  Should not be used in any new code, legacy compat only
 #
-# @sha1: SHA-1.  Should not be used in any new code, legacy compat only
+# @sha1: SHA-1.  Should not be used in any new code, legacy compat
+#     only
 #
 # @sha224: SHA-224.  (since 2.7)
 #
@@ -377,8 +378,8 @@
 #     deactivate all keyslots that match password located in
 #     QCryptoSecret with this ID
 #
-# @iter-time: Optional (for activation only).  Number of milliseconds to
-#     spend in PBKDF passphrase processing for the newly activated
+# @iter-time: Optional (for activation only).  Number of milliseconds
+#     to spend in PBKDF passphrase processing for the newly activated
 #     keyslot.  Currently defaults to 2000.
 #
 # @keyslot: Optional.  ID of the keyslot to activate/deactivate.  For
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 53100714a8..c8432c8ed8 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -22,10 +22,10 @@
 # `SchemaInfo`.  This lets QMP clients figure out what commands and
 # events are available in this QEMU, and their parameters and results.
 #
-# However, the `SchemaInfo` can't reflect all the rules and restrictions
-# that apply to QMP.  It's interface introspection (figuring out
-# what's there), not interface specification.  The specification is in
-# the QAPI schema.
+# However, the `SchemaInfo` can't reflect all the rules and
+# restrictions that apply to QMP.  It's interface introspection
+# (figuring out what's there), not interface specification.  The
+# specification is in the QAPI schema.
 #
 # Furthermore, while we strive to keep the QMP wire format
 # backwards-compatible across QEMU versions, the introspection output
diff --git a/qapi/job.json b/qapi/job.json
index 8b08350af2..0a301fc094 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -194,16 +194,16 @@
 #
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
-# mirroring includes `drive-mirror`, `blockdev-mirror` and `block-commit`
-# job (only in case of "active commit", when the node being commited
-# is used by the guest).  The ability to complete is signaled with a
-# `BLOCK_JOB_READY` event.
+# mirroring includes `drive-mirror`, `blockdev-mirror` and
+# `block-commit` job (only in case of "active commit", when the node
+# being commited is used by the guest).  The ability to complete is
+# signaled with a `BLOCK_JOB_READY` event.
 #
 # This command completes an active background block operation
 # synchronously.  The ordering of this command's return with the
-# `BLOCK_JOB_COMPLETED` event is not defined.  Note that if an I/O error
-# occurs during the processing of this command: 1) the command itself
-# will fail; 2) the error will be processed according to the
+# `BLOCK_JOB_COMPLETED` event is not defined.  Note that if an I/O
+# error occurs during the processing of this command: 1) the command
+# itself will fail; 2) the error will be processed according to the
 # rerror/werror arguments that were specified when starting the
 # operation.
 #
@@ -218,16 +218,16 @@
 #
 # Deletes a job that is in the CONCLUDED state.  This command only
 # needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled.  In turn, automatic dismiss may be enabled only
-# for jobs that have @auto-dismiss option, which are `drive-backup`,
-# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit` and
-# `block-stream`.  @auto-dismiss is enabled by default for these
+# dismiss enabled.  In turn, automatic dismiss may be enabled only for
+# jobs that have @auto-dismiss option, which are `drive-backup`,
+# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
+# and `block-stream`.  @auto-dismiss is enabled by default for these
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, CONCLUDED.  For jobs that make use of
-# the JOB_READY event, `job-cancel` or `job-complete` will still need to
-# be used as appropriate.
+# the JOB_READY event, `job-cancel` or `job-complete` will still need
+# to be used as appropriate.
 #
 # @id: The job identifier.
 #
@@ -247,8 +247,8 @@
 # force ALL jobs in the transaction to finalize, so it is only
 # necessary to instruct a single member job to finalize.
 #
-# The command is applicable only to jobs which have @auto-finalize option
-# and only when this option is set to false.
+# The command is applicable only to jobs which have @auto-finalize
+# option and only when this option is set to false.
 #
 # @id: The identifier of any job in the transaction, or of a job that
 #     is not part of any transaction.
diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index ed3d20a2fb..92e84dfb14 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -87,8 +87,8 @@
 #
 # Cache information for SMP system.
 #
-# @cache: Cache name, which is the combination of cache level
-#     and cache type.
+# @cache: Cache name, which is the combination of cache level and
+#     cache type.
 #
 # @topology: Cache topology level.  It accepts the CPU topology
 #     enumeration as the parameter, i.e., CPUs in the same
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 8412668b67..ea430e1b88 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -123,8 +123,8 @@
 ##
 # @SCLP_CPI_INFO_AVAILABLE:
 #
-# Emitted when the Control-Program Identification data is available
-# in the QOM tree.
+# Emitted when the Control-Program Identification data is available in
+# the QOM tree.
 #
 # Features:
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index c6dc6fe69b..907cb25f75 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -620,8 +620,8 @@
 ##
 # @NumaCpuOptions:
 #
-# Option "-numa cpu" overrides default cpu to node mapping.  It accepts
-# the same set of cpu properties as returned by
+# Option "-numa cpu" overrides default cpu to node mapping.  It
+# accepts the same set of cpu properties as returned by
 # `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
 # node-id could be used to override default node mapping.
 #
@@ -686,8 +686,8 @@
 # Set the system locality latency and bandwidth information between
 # Initiator and Target proximity Domains.
 #
-# For more information about `NumaHmatLBOptions`, see chapter 5.2.27.4:
-# Table 5-146 of ACPI 6.3 spec.
+# For more information about `NumaHmatLBOptions`, see chapter
+# 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
 #
 # @initiator: the Initiator Proximity Domain.
 #
@@ -743,8 +743,8 @@
 # Cache write policy in the Memory Side Cache Information Structure of
 # HMAT
 #
-# For more information of `HmatCacheWritePolicy`, see chapter 5.2.27.5:
-# Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
+# For more information of `HmatCacheWritePolicy`, see chapter
+# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @none: None (no memory side cache in this proximity domain, or cache
 #     write policy unknown)
@@ -763,8 +763,8 @@
 #
 # Set the memory side cache information for a given memory domain.
 #
-# For more information of `NumaHmatCacheOptions`, see chapter 5.2.27.5:
-# Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
+# For more information of `NumaHmatCacheOptions`, see chapter
+# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @node-id: the memory proximity domain to which the memory belongs.
 #
@@ -959,7 +959,7 @@
 #     belongs to (since 7.1)
 #
 # @module-id: module number within the parent container the CPU
-#    belongs to (since 9.1)
+#     belongs to (since 9.1)
 #
 # @core-id: core number within the parent container the CPU belongs to
 #
@@ -1090,7 +1090,7 @@
 # @value: the target logical size of the VM in bytes.  We can deduce
 #     the size of the balloon using this formula:
 #
-#        logical_vm_size = vm_ram_size - balloon_size
+#         logical_vm_size = vm_ram_size - balloon_size
 #
 #     From it we have: balloon_size = vm_ram_size - @value
 #
@@ -1845,7 +1845,7 @@
 # @version: Firmware version.
 #
 # @log: Firmware debug log, in base64 encoding.  First and last log
-#       line might be incomplete.
+#     line might be incomplete.
 #
 # Since: 10.2
 ##
@@ -1859,8 +1859,8 @@
 # Find firmware memory log buffer in guest memory, return content.
 #
 # @max-size: limit the amount of log data returned.  Up to 1 MiB of
-#            log data is allowed.  In case the amount of log data is
-#            larger than @max-size the tail of the log is returned.
+#     log data is allowed.  In case the amount of log data is larger
+#     than @max-size the tail of the log is returned.
 #
 # Since: 10.2
 ##
@@ -2004,11 +2004,11 @@
 # @query-cpu-model-comparison:
 #
 # Compares two CPU models, @modela and @modelb, returning how they
-# compare in a specific configuration.  The results indicates how
-# both models compare regarding runnability.  This result can be
-# used by tooling to make decisions if a certain CPU model will
-# run in a certain configuration or if a compatible CPU model has
-# to be created by baselining.
+# compare in a specific configuration.  The results indicates how both
+# models compare regarding runnability.  This result can be used by
+# tooling to make decisions if a certain CPU model will run in a
+# certain configuration or if a compatible CPU model has to be created
+# by baselining.
 #
 # Usually, a CPU model is compared against the maximum possible CPU
 # model of a certain configuration (e.g. the "host" model for KVM).
@@ -2029,7 +2029,8 @@
 #   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using `query-cpu-model-expansion` while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not
+#   advised.
 #
 # Some architectures may not support comparing CPU models.  s390x
 # supports comparing CPU models.
@@ -2083,7 +2084,8 @@
 #   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using `query-cpu-model-expansion` while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not
+#   advised.
 #
 # Some architectures may not support baselining CPU models.  s390x
 # supports baselining CPU models.
@@ -2114,8 +2116,8 @@
 #
 # @model: the expanded `CpuModelInfo`.
 #
-# @deprecated-props: an optional list of properties that are flagged as
-#     deprecated by the CPU vendor.  The list depends on the
+# @deprecated-props: an optional list of properties that are flagged
+#     as deprecated by the CPU vendor.  The list depends on the
 #     `CpuModelExpansionType`: "static" properties are a subset of the
 #     enabled-properties for the expanded model; "full" properties are
 #     a set of properties that are deprecated across all models for
@@ -2151,7 +2153,8 @@
 #   `query-cpu-definitions`.)
 # * "-cpu" arguments and global properties: arguments to the -cpu
 #   option and global properties may affect expansion of CPU models.
-#   Using `query-cpu-model-expansion` while using these is not advised.
+#   Using `query-cpu-model-expansion` while using these is not
+#   advised.
 #
 # Some architectures may not support all expansion types.  s390x
 # supports "full" and "static".  Arm only supports "full".
diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..4dd1098219 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -160,11 +160,11 @@
 #
 # @pre-switchover: Paused before device serialisation.  (since 2.11)
 #
-# @device: During device serialisation (also known as switchover phase).
-#     Before 9.2, this is only used when (1) in precopy, and (2) when
-#     pre-switchover capability is enabled.  After 10.0, this state will
-#     always be present for every migration procedure as the switchover
-#     phase.  (since 2.11)
+# @device: During device serialisation (also known as switchover
+#     phase).  Before 9.2, this is only used when (1) in precopy, and
+#     (2) when pre-switchover capability is enabled.  After 10.0, this
+#     state will always be present for every migration procedure as
+#     the switchover phase.  (since 2.11)
 #
 # @wait-unplug: wait for device unplug request by guest OS to be
 #     completed.  (since 4.2)
@@ -238,31 +238,34 @@
 #     This is only present when the postcopy-blocktime migration
 #     capability is enabled.  (Since 3.0)
 #
-# @postcopy-latency: average remote page fault latency (in ns).  Note that
-#     this doesn't include all faults, but only the ones that require a
-#     remote page request.  So it should be always bigger than the real
-#     average page fault latency. This is only present when the
-#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
-#
-# @postcopy-latency-dist: remote page fault latency distributions.  Each
-#     element of the array is the number of faults that fall into the
-#     bucket period.  For the N-th bucket (N>=0), the latency window is
-#     [2^Nus, 2^(N+1)us).  For example, the 8th element stores how many
-#     remote faults got resolved within [256us, 512us) window. This is only
-#     present when the postcopy-blocktime migration capability is enabled.
+# @postcopy-latency: average remote page fault latency (in ns).  Note
+#     that this doesn't include all faults, but only the ones that
+#     require a remote page request.  So it should be always bigger
+#     than the real average page fault latency.  This is only present
+#     when the postcopy-blocktime migration capability is enabled.
 #     (Since 10.1)
 #
-# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
-#     ns).  It has the same definition of @postcopy-latency, but instead
-#     this is the per-vCPU statistics.  This is only present when the
-#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
-#
-# @postcopy-non-vcpu-latency: average remote page fault latency for all
-#     faults happend in non-vCPU threads (in ns).  It has the same
-#     definition of @postcopy-latency but this only provides statistics to
-#     non-vCPU faults.  This is only present when the postcopy-blocktime
+# @postcopy-latency-dist: remote page fault latency distributions.
+#     Each element of the array is the number of faults that fall into
+#     the bucket period.  For the N-th bucket (N>=0), the latency
+#     window is [2^Nus, 2^(N+1)us).  For example, the 8th element
+#     stores how many remote faults got resolved within [256us, 512us)
+#     window.  This is only present when the postcopy-blocktime
 #     migration capability is enabled.  (Since 10.1)
 #
+# @postcopy-vcpu-latency: average remote page fault latency per vCPU
+#     (in ns).  It has the same definition of @postcopy-latency, but
+#     instead this is the per-vCPU statistics.  This is only present
+#     when the postcopy-blocktime migration capability is enabled.
+#     (Since 10.1)
+#
+# @postcopy-non-vcpu-latency: average remote page fault latency for
+#     all faults happend in non-vCPU threads (in ns).  It has the same
+#     definition of @postcopy-latency but this only provides
+#     statistics to non-vCPU faults.  This is only present when the
+#     postcopy-blocktime migration capability is enabled.
+#     (Since 10.1)
+#
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
@@ -290,7 +293,8 @@
 # Features:
 #
 # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
-#     @postcopy-latency-dist, @postcopy-non-vcpu-latency are experimental.
+#     @postcopy-latency-dist, @postcopy-non-vcpu-latency are
+#     experimental.
 #
 # Since: 0.14
 ##
@@ -322,9 +326,8 @@
 ##
 # @query-migrate:
 #
-# Return information about current migration process.  If migration
-# is active there will be another json-object with RAM migration
-# status.
+# Return information about current migration process.  If migration is
+# active there will be another json-object with RAM migration status.
 #
 # Since: 0.14
 #
@@ -627,8 +630,8 @@
 #
 # @normal: the original form of migration.  (since 8.2)
 #
-# @cpr-reboot: The `migrate` command stops the VM and saves state to the
-#     URI.  After quitting QEMU, the user resumes by running QEMU
+# @cpr-reboot: The `migrate` command stops the VM and saves state to
+#     the URI.  After quitting QEMU, the user resumes by running QEMU
 #     -incoming.
 #
 #     This mode allows the user to quit QEMU, optionally update and
@@ -659,15 +662,15 @@
 #     time by preserving guest RAM in place.
 #
 #     Devices and their pinned pages are also preserved for VFIO and
-#     IOMMUFD. (since 10.1)
+#     IOMMUFD.  (since 10.1)
 #
 #     The user starts new QEMU on the same host as old QEMU, with
 #     command-line arguments to create the same machine, plus the
 #     -incoming option for the main migration channel, like normal
 #     live migration.  In addition, the user adds a second -incoming
 #     option with channel type "cpr".  This CPR channel must support
-#     file descriptor transfer with SCM_RIGHTS, i.e. it must be a
-#     UNIX domain socket.
+#     file descriptor transfer with SCM_RIGHTS, i.e. it must be a UNIX
+#     domain socket.
 #
 #     To initiate CPR, the user issues a migrate command to old QEMU,
 #     adding a second migration channel of type "cpr" in the channels
@@ -708,8 +711,8 @@
 #     QEMU binary.
 #
 #     Because old QEMU terminates when new QEMU starts, one cannot
-#     stream data between the two, so the channel must be a type,
-#     such as a file, that accepts all data before old QEMU exits.
+#     stream data between the two, so the channel must be a type, such
+#     as a file, that accepts all data before old QEMU exits.
 #     Otherwise, old QEMU may quietly block writing to the channel.
 #
 #     Memory-backend objects must have the share=on attribute, but
@@ -903,9 +906,10 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration.  The level is an integer between 1 and 9, where 1 means
-#     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
+#     migration.  The level is an integer between 1 and 9, where 1
+#     means the best compression speed, and 9 means the best
+#     compression ratio which will consume more CPU.  Defaults to 1.
+#     (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
@@ -939,8 +943,8 @@
 # @mode: Migration mode.  See description in `MigMode`.  Default is
 #     'normal'.  (Since 8.2)
 #
-# @zero-page-detection: Whether and how to detect zero pages.
-#     See description in `ZeroPageDetection`.  Default is 'multifd'.
+# @zero-page-detection: Whether and how to detect zero pages.  See
+#     description in `ZeroPageDetection`.  Default is 'multifd'.
 #     (since 9.0)
 #
 # @direct-io: Open migration files with O_DIRECT when possible.  This
@@ -1089,9 +1093,10 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration.  The level is an integer between 1 and 9, where 1 means
-#     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
+#     migration.  The level is an integer between 1 and 9, where 1
+#     means the best compression speed, and 9 means the best
+#     compression ratio which will consume more CPU.  Defaults to 1.
+#     (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
@@ -1125,8 +1130,8 @@
 # @mode: Migration mode.  See description in `MigMode`.  Default is
 #     'normal'.  (Since 8.2)
 #
-# @zero-page-detection: Whether and how to detect zero pages.
-#     See description in `ZeroPageDetection`.  Default is 'multifd'.
+# @zero-page-detection: Whether and how to detect zero pages.  See
+#     description in `ZeroPageDetection`.  Default is 'multifd'.
 #     (since 9.0)
 #
 # @direct-io: Open migration files with O_DIRECT when possible.  This
@@ -1304,9 +1309,10 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration.  The level is an integer between 1 and 9, where 1 means
-#     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
+#     migration.  The level is an integer between 1 and 9, where 1
+#     means the best compression speed, and 9 means the best
+#     compression ratio which will consume more CPU.  Defaults to 1.
+#     (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
@@ -1340,8 +1346,8 @@
 # @mode: Migration mode.  See description in `MigMode`.  Default is
 #     'normal'.  (Since 8.2)
 #
-# @zero-page-detection: Whether and how to detect zero pages.
-#     See description in `ZeroPageDetection`.  Default is 'multifd'.
+# @zero-page-detection: Whether and how to detect zero pages.  See
+#     description in `ZeroPageDetection`.  Default is 'multifd'.
 #     (since 9.0)
 #
 # @direct-io: Open migration files with O_DIRECT when possible.  This
@@ -1813,9 +1819,9 @@
 #     list connected to a destination interface endpoint.
 #
 # @exit-on-error: Exit on incoming migration failure.  Default true.
-#     When set to false, the failure triggers a :qapi:event:`MIGRATION`
-#     event, and error details could be retrieved with `query-migrate`.
-#     (since 9.1)
+#     When set to false, the failure triggers a
+#     :qapi:event:`MIGRATION` event, and error details could be
+#     retrieved with `query-migrate`.  (since 9.1)
 #
 # Since: 2.3
 #
@@ -2368,8 +2374,7 @@
 ##
 # @query-vcpu-dirty-limit:
 #
-# Return information about virtual CPU dirty page rate limits, if
-# any.
+# Return information about virtual CPU dirty page rate limits, if any.
 #
 # Since: 7.1
 #
@@ -2507,8 +2512,8 @@
 # time it takes to load the snapshot.
 #
 # It is strongly recommended that @devices contain all writable block
-# device nodes that can have changed since the original `snapshot-save`
-# command execution.
+# device nodes that can have changed since the original
+# `snapshot-save` command execution.
 #
 # .. qmp-example::
 #
diff --git a/qapi/net.json b/qapi/net.json
index 7f62f8cc39..4c6cc5ca8d 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -119,9 +119,11 @@
 #
 # Unprivileged user-mode network connectivity using passt
 #
-# @path: Filename of the passt program to run (by default 'passt', and use PATH)
+# @path: Filename of the passt program to run (by default 'passt', and
+#     use PATH)
 #
-# @quiet: don't print informational messages (default, passed as '--quiet')
+# @quiet: don't print informational messages (default, passed as
+#     '--quiet')
 #
 # @vhost-user: enable vhost-user
 #
@@ -281,8 +283,8 @@
 #
 # @smbserver: IP address of the built-in SMB server
 #
-# @hostfwd: redirect incoming TCP, UDP or UNIX host connections to guest
-#     endpoints
+# @hostfwd: redirect incoming TCP, UDP or UNIX host connections to
+#     guest endpoints
 #
 # @guestfwd: forward guest TCP connections
 #
@@ -569,7 +571,8 @@
 #     (default: 0).
 #
 # @inhibit: Don't load a default XDP program, use one already loaded
-#     to the interface (default: false).  Requires @sock-fds or @map-path.
+#     to the interface (default: false).  Requires @sock-fds or
+#     @map-path.
 #
 # @sock-fds: A colon (:) separated list of file descriptors for
 #     already open but not bound AF_XDP sockets in the queue order.
@@ -582,7 +585,8 @@
 #     mutually exclusive.  Requires @inhibit.  (Since 10.1)
 #
 # @map-start-index: Use @map-path to insert xsk sockets starting from
-#     this index number (default: 0).  Requires @map-path.  (Since 10.1)
+#     this index number (default: 0).  Requires @map-path.
+#     (Since 10.1)
 #
 # Since: 8.2
 ##
@@ -770,9 +774,10 @@
 #
 # @server: create server socket (default: false)
 #
-# @reconnect-ms: For a client socket, if a socket is disconnected, then
-#     attempt a reconnect after the given number of milliseconds.  Setting
-#     this to zero disables this function.  (default: 0) (Since: 9.2)
+# @reconnect-ms: For a client socket, if a socket is disconnected,
+#     then attempt a reconnect after the given number of milliseconds.
+#     Setting this to zero disables this function.
+#     (default: 0) (Since: 9.2)
 #
 # Only `SocketAddress` types 'unix', 'inet' and 'fd' are supported.
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index e14a0c9259..974cf9c583 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -100,8 +100,8 @@
 #    process is signaled with a `DEVICE_DELETED` event.  Guest reset
 #    will automatically complete removal for all devices.  If a
 #    guest-side error in the hot removal process is detected, the
-#    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR` event
-#    is sent.  Some errors cannot be detected.
+#    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR`
+#    event is sent.  Some errors cannot be detected.
 #
 # Since: 0.14
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 830cb2ffe7..d7dceaf2f8 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -52,7 +52,8 @@
 #
 # @name: the name of the property.
 #
-# @type: the type of the property, as described in `ObjectPropertyInfo`.
+# @type: the type of the property, as described in
+#     `ObjectPropertyInfo`.
 #
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
@@ -112,7 +113,7 @@
 #     Absolute paths are derived from the root object and can follow
 #     child<> or link<> properties.  Since they can follow link<>
 #     properties, they can be arbitrarily long.  Absolute paths look
-#     like absolute filenames and are prefixed  with a leading slash.
+#     like absolute filenames and are prefixed with a leading slash.
 #
 #     Partial paths look like relative filenames.  They do not begin
 #     with a prefix.  The matching rules for partial paths are subtle
@@ -917,14 +918,14 @@
 #     combined with information retrieved from the discoverable part
 #     of the path.  An example would use CDAT (see UEFI.org)
 #     information read from devices and switches in conjunction with
-#     link characteristics read from PCIe Configuration space.
-#     To get the full path latency from CPU to CXL attached DRAM
-#     CXL device: Add the latency from CPU to Generic Port (from
-#     HMAT indexed via the node ID in this SRAT structure) to
-#     that for CXL bus links, the latency across intermediate switches
-#     and from the EP port to the actual memory.  Bandwidth is more
-#     complex as there may be interleaving across multiple devices
-#     and shared links in the path.
+#     link characteristics read from PCIe Configuration space.  To get
+#     the full path latency from CPU to CXL attached DRAM CXL device:
+#     Add the latency from CPU to Generic Port (from HMAT indexed via
+#     the node ID in this SRAT structure) to that for CXL bus links,
+#     the latency across intermediate switches and from the EP port to
+#     the actual memory.  Bandwidth is more complex as there may be
+#     interleaving across multiple devices and shared links in the
+#     path.
 #
 # Since: 9.2
 ##
@@ -1040,8 +1041,7 @@
 #    behave identically to 'on', but will automatically switch to
 #    using KVM_SEV_INIT2 if the user specifies any additional options
 #    that require it.  If set to 'off', QEMU will require
-#    KVM_SEV_INIT2 unconditionally.
-#    (default: off) (since 9.1)
+#    KVM_SEV_INIT2 unconditionally.  (default: off) (since 9.1)
 #
 # Since: 2.12
 ##
@@ -1082,8 +1082,8 @@
 #     Authentication Information Structure' for the SNP_LAUNCH_FINISH
 #     command defined in the SEV-SNP firmware ABI (default: all-zero)
 #
-# @author-key-enabled: true if 'id-auth' blob contains the 'AUTHOR_KEY'
-#     field defined SEV-SNP firmware ABI (default: false)
+# @author-key-enabled: true if 'id-auth' blob contains the
+#     'AUTHOR_KEY' field defined SEV-SNP firmware ABI (default: false)
 #
 # @host-data: 32-byte, base64-encoded, user-defined blob to provide to
 #     the guest, as documented for the 'HOST_DATA' parameter of the
@@ -1117,17 +1117,17 @@
 # @attributes: The 'attributes' of a TD guest that is passed to
 #     KVM_TDX_INIT_VM
 #
-# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
-#     of EPT violation conversion to #VE on guest TD access of PENDING
-#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
-#     be set, otherwise they refuse to boot.
+# @sept-ve-disable: toggle bit 28 of TD attributes to control
+#     disabling of EPT violation conversion to #VE on guest TD access
+#     of PENDING pages.  Some guest OS (e.g., Linux TD guest) may
+#     require this to be set, otherwise they refuse to boot.
 #
 # @mrconfigid: ID for non-owner-defined configuration of the guest TD,
-#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
-#     Defaults to all zeros.
+#     e.g., run-time or OS configuration (base64 encoded SHA384
+#     digest).  Defaults to all zeros.
 #
-# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
-#     Defaults to all zeros.
+# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384
+#     digest).  Defaults to all zeros.
 #
 # @mrownerconfig: ID for owner-defined configuration of the guest TD,
 #     e.g., specific to the workload rather than the run-time or OS
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 4757947ca6..2872bee06e 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -247,8 +247,8 @@
 # saved on disk, for example, S4 state, which is sometimes called
 # hibernate state
 #
-# .. note:: QEMU shuts down (similar to event `SHUTDOWN`) when entering
-#    this state.
+# .. note:: QEMU shuts down (similar to event `SHUTDOWN`) when
+#    entering this state.
 #
 # Since: 1.2
 #
@@ -281,9 +281,9 @@
 #
 # @action: action that has been taken
 #
-# .. note:: If action is "reset", "shutdown", or "pause" the `WATCHDOG`
-#    event is followed respectively by the `RESET`, `SHUTDOWN`, or `STOP`
-#    events.
+# .. note:: If action is "reset", "shutdown", or "pause" the
+#    `WATCHDOG` event is followed respectively by the `RESET`,
+#    `SHUTDOWN`, or `STOP` events.
 #
 # .. note:: This event is rate-limited.
 #
@@ -402,7 +402,8 @@
 #
 # @panic: `PanicAction` action taken on guest panic.
 #
-# @watchdog: `WatchdogAction` action taken when watchdog timer expires.
+# @watchdog: `WatchdogAction` action taken when watchdog timer
+#     expires.
 #
 # Since: 6.0
 #
@@ -542,8 +543,8 @@
 # @arg4: for Windows, third argument of the `STOP`.  For Linux, the
 #     RAX register (x86) or the stack pointer (aarch64) of the guest.
 #
-# @arg5: for Windows, fourth argument of the `STOP`.  For x86 Linux, the
-#     stack pointer of the guest.
+# @arg5: for Windows, fourth argument of the `STOP`.  For x86 Linux,
+#     the stack pointer of the guest.
 #
 # Since: 2.9
 ##
@@ -610,7 +611,7 @@
 #
 # @error-code: TD-specific error code
 #
-# @message: Human-readable error message provided by the guest. Not
+# @message: Human-readable error message provided by the guest.  Not
 #     to be trusted.
 #
 # @gpa: guest-physical address of a page that contains more verbose
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 32fac51728..473be2ac58 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -58,24 +58,26 @@
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
 #     IPv6
 #
-# @keep-alive: enable keep-alive when connecting to/listening on this socket.
+# @keep-alive: enable keep-alive when connecting to/listening on this
+#     socket.
 #     (Since 4.2, not supported for listening sockets until 10.1)
 #
-# @keep-alive-count: number of keep-alive packets sent before the connection is
-#     closed.  Only supported for TCP sockets on systems where TCP_KEEPCNT
-#     socket option is defined (this includes Linux, Windows, macOS, FreeBSD,
-#     but not OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
+# @keep-alive-count: number of keep-alive packets sent before the
+#     connection is closed.  Only supported for TCP sockets on systems
+#     where TCP_KEEPCNT socket option is defined (this includes Linux,
+#     Windows, macOS, FreeBSD, but not OpenBSD).  When set to 0,
+#     system setting is used.  (Since 10.1)
 #
-# @keep-alive-idle: time in seconds the connection needs to be idle before
-#     sending a keepalive packet.  Only supported for TCP sockets on systems
-#     where TCP_KEEPIDLE socket option is defined (this includes Linux,
-#     Windows, macOS, FreeBSD, but not OpenBSD).  When set to 0, system setting
-#     is used.  (Since 10.1)
+# @keep-alive-idle: time in seconds the connection needs to be idle
+#     before sending a keepalive packet.  Only supported for TCP
+#     sockets on systems where TCP_KEEPIDLE socket option is defined
+#     (this includes Linux, Windows, macOS, FreeBSD, but not OpenBSD).
+#     When set to 0, system setting is used.  (Since 10.1)
 #
-# @keep-alive-interval: time in seconds between keep-alive packets.  Only
-#     supported for TCP sockets on systems where TCP_KEEPINTVL is defined (this
-#     includes Linux, Windows, macOS, FreeBSD, but not OpenBSD).  When set to
-#     0, system setting is used.  (Since 10.1)
+# @keep-alive-interval: time in seconds between keep-alive packets.
+#     Only supported for TCP sockets on systems where TCP_KEEPINTVL is
+#     defined (this includes Linux, Windows, macOS, FreeBSD, but not
+#     OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
 #
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
diff --git a/qapi/stats.json b/qapi/stats.json
index 151ac43c48..a98624531c 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -185,8 +185,8 @@
 # Return runtime-collected statistics for objects such as the VM or
 # its vCPUs.
 #
-# The arguments are a `StatsFilter` and specify the provider and objects
-# to return statistics about.
+# The arguments are a `StatsFilter` and specify the provider and
+# objects to return statistics about.
 #
 # Returns: a list of statistics, one for each provider and object
 #     (e.g., for each vCPU).
diff --git a/qapi/ui.json b/qapi/ui.json
index 1b2f4a4769..804b1ecc3b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1023,10 +1023,10 @@
 #
 # Send keys to guest.
 #
-# @keys: An array of `KeyValue` elements.  All @KeyValues in this array
-#     are simultaneously sent to the guest.  A `KeyValue`.number value
-#     is sent directly to the guest, while `KeyValue`.qcode must be a
-#     valid `QKeyCode` value
+# @keys: An array of `KeyValue` elements.  All @KeyValues in this
+#     array are simultaneously sent to the guest.  A `KeyValue`.number
+#     value is sent directly to the guest, while `KeyValue`.qcode must
+#     be a valid `QKeyCode` value
 #
 # @hold-time: time to delay key up events, milliseconds.  Defaults to
 #     100
@@ -1335,10 +1335,11 @@
 # @show-menubar: Display the main window menubar.  Defaults to "on".
 #     (Since 8.0)
 #
-# @keep-aspect-ratio: Keep width/height aspect ratio of guest content when
-#     resizing host window.  Defaults to "on". (Since 10.1)
+# @keep-aspect-ratio: Keep width/height aspect ratio of guest content
+#     when resizing host window.  Defaults to "on".  (Since 10.1)
 #
-# @scale: Set preferred scale of the display.  Defaults to 1.0.  (Since 10.1)
+# @scale: Set preferred scale of the display.  Defaults to 1.0.
+#     (Since 10.1)
 #
 # Since: 2.12
 ##
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 05295ab665..72790bcfb0 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -984,8 +984,8 @@
 ##
 # @DummyVirtioForceArrays:
 #
-# Not used by QMP; hack to let us use IOThreadVirtQueueMappingList
-# and VirtIOGPUOutputList internally
+# Not used by QMP; hack to let us use IOThreadVirtQueueMappingList and
+# VirtIOGPUOutputList internally
 #
 # Since: 9.0
 ##
-- 
2.49.0


