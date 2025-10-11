Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CD8CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a7D-00065n-H6; Sat, 11 Oct 2025 09:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7B-00064x-Ar; Sat, 11 Oct 2025 09:58:29 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a6t-0004cV-Ix; Sat, 11 Oct 2025 09:58:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2658CC0199;
 Sat, 11 Oct 2025 16:58:00 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-EGShGhYw; Sat, 11 Oct 2025 16:57:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191079;
 bh=rkyf7rGbhwFt5gk0ynFY+SGn3DOMn5p/CpXqqwTOTto=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Zj5qwqN1LSLiffLtliXXUknI01sPoYPBCEjVXgK1QGafati8dh+/NcLJJh+IVCE1c
 NEOOuWR7kUr3iwg95J49NFVT9mTyI6gDYZDgDaS5TxGIiLT92ZMh4d1S+Nxcf/GmeQ
 wrXG1CJVzmpzs+1MYd4W0efAd+R+7SHmV0Vq1lWE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 04/33] qapi/block-core.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:56:47 +0300
Message-ID: <20251011135754.294521-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/block-core.json | 191 ++++++++++++++++++++++++-------------------
 1 file changed, 106 insertions(+), 85 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index dc6eb4ae23..4828a78371 100644
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
@@ -340,8 +341,8 @@
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
@@ -507,11 +508,12 @@
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
@@ -1627,11 +1629,12 @@
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
@@ -1743,7 +1746,8 @@
 #
 # @allow-write-only-overlay: If present, the check whether this
 #     operation is safe was relaxed so that it can be used to change
-#     backing file of a destination of a `blockdev-mirror`.  (since 5.0)
+#     backing file of a destination of a `blockdev-mirror`.
+#     (since 5.0)
 #
 # Since: 2.5
 #
@@ -1870,8 +1874,8 @@
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
@@ -1944,10 +1948,10 @@
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
@@ -2005,7 +2009,8 @@
 #                           "format":"qcow2",
 #                           "virtual-size":2048000,
 #                           "backing_file":"base.qcow2",
-#                           "full-backing-filename":"disks/base.qcow2",
+#                           "full-backing-filename":
+#                               "disks/base.qcow2",
 #                           "backing-filename-format":"qcow2",
 #                           "snapshots":[
 #                              {
@@ -2231,8 +2236,8 @@
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
@@ -2282,7 +2287,8 @@
 #
 # @disabled: the bitmap is created in the disabled state, which means
 #     that it will not track drive changes.  The bitmap may be enabled
-#     with `block-dirty-bitmap-enable`.  Default is false.  (Since: 4.0)
+#     with `block-dirty-bitmap-enable`.  Default is false.
+#     (Since: 4.0)
 #
 # Since: 2.4
 ##
@@ -2347,8 +2353,8 @@
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
@@ -2546,8 +2552,8 @@
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
@@ -2873,8 +2879,8 @@
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
@@ -3044,16 +3050,16 @@
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
@@ -3083,8 +3089,8 @@
 # needs to be run explicitly for jobs that don't have automatic
 # dismiss enabled.  In turn, automatic dismiss may be enabled only
 # for jobs that have @auto-dismiss option, which are `drive-backup`,
-# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit` and
-# `block-stream`.  @auto-dismiss is enabled by default for these
+# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
+# and `block-stream`.  @auto-dismiss is enabled by default for these
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
@@ -3117,8 +3123,8 @@
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
@@ -4748,9 +4754,9 @@
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
@@ -4942,11 +4948,12 @@
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
@@ -4965,10 +4972,10 @@
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
@@ -4979,8 +4986,8 @@
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
@@ -5012,18 +5019,18 @@
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
@@ -5671,9 +5678,12 @@
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_IMAGE_CORRUPTED",
-#          "data": { "device": "", "node-name": "drive", "fatal": false,
-#                    "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)" },
-#          "timestamp": { "seconds": 1648243240, "microseconds": 906060 } }
+#          "data": {
+#            "device": "", "node-name": "drive", "fatal": false,
+#            "msg":
+#              "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)" },
+#          "timestamp": { "seconds": 1648243240,
+#                         "microseconds": 906060 } }
 #
 # Since: 1.7
 ##
@@ -5730,7 +5740,8 @@
 #                    "operation": "write",
 #                    "action": "stop",
 #                    "reason": "No space left on device" },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_IO_ERROR',
   'data': { 'qom-path': 'str', 'device': 'str', '*node-name': 'str',
@@ -5768,7 +5779,8 @@
 #          "data": { "type": "stream", "device": "virtio-disk0",
 #                    "len": 10737418240, "offset": 10737418240,
 #                    "speed": 0 },
-#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#          "timestamp": { "seconds": 1267061043,
+#                         "microseconds": 959568 } }
 ##
 { 'event': 'BLOCK_JOB_COMPLETED',
   'data': { 'type'  : 'JobType',
@@ -5803,7 +5815,8 @@
 #          "data": { "type": "stream", "device": "virtio-disk0",
 #                    "len": 10737418240, "offset": 134217728,
 #                    "speed": 0 },
-#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#          "timestamp": { "seconds": 1267061043,
+#                         "microseconds": 959568 } }
 ##
 { 'event': 'BLOCK_JOB_CANCELLED',
   'data': { 'type'  : 'JobType',
@@ -5832,7 +5845,8 @@
 #          "data": { "device": "ide0-hd1",
 #                    "operation": "write",
 #                    "action": "stop" },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_JOB_ERROR',
   'data': { 'device'   : 'str',
@@ -5866,7 +5880,8 @@
 #     <- { "event": "BLOCK_JOB_READY",
 #          "data": { "device": "drive0", "type": "mirror", "speed": 0,
 #                    "len": 2097152, "offset": 2097152 },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_JOB_READY',
   'data': { 'type'  : 'JobType',
@@ -5893,7 +5908,8 @@
 #
 #     <- { "event": "BLOCK_JOB_PENDING",
 #          "data": { "type": "mirror", "id": "backup_1" },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_JOB_PENDING',
   'data': { 'type'  : 'JobType',
@@ -6113,8 +6129,10 @@
 # .. qmp-example::
 #
 #     <- { "event": "QUORUM_FAILURE",
-#          "data": { "reference": "usr1", "sector-num": 345435, "sectors-count": 5 },
-#          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#          "data": { "reference": "usr1", "sector-num": 345435,
+#                    "sectors-count": 5 },
+#          "timestamp": { "seconds": 1344522075,
+#                         "microseconds": 745528 } }
 ##
 { 'event': 'QUORUM_FAILURE',
   'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'int' } }
@@ -6145,17 +6163,20 @@
 #    :title: Read operation
 #
 #     <- { "event": "QUORUM_REPORT_BAD",
-#          "data": { "node-name": "node0", "sector-num": 345435, "sectors-count": 5,
-#                    "type": "read" },
-#          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#          "data": { "node-name": "node0", "sector-num": 345435,
+#                    "sectors-count": 5, "type": "read" },
+#          "timestamp": { "seconds": 1344522075,
+#                         "microseconds": 745528 } }
 #
 # .. qmp-example::
 #    :title: Flush operation
 #
 #     <- { "event": "QUORUM_REPORT_BAD",
-#          "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2097120,
-#                    "type": "flush", "error": "Broken pipe" },
-#          "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
+#          "data": { "node-name": "node0", "sector-num": 0,
+#                    "sectors-count": 2097120, "type": "flush",
+#                    "error": "Broken pipe" },
+#          "timestamp": { "seconds": 1456406829,
+#                         "microseconds": 291763 } }
 ##
 { 'event': 'QUORUM_REPORT_BAD',
   'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
-- 
2.48.1


