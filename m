Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3FBCA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrjl-0002kt-Oh; Wed, 30 Sep 2026 06:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0001NE-RN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0006kX-KA
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MITgclBiu56G4jSdKMnOHmysLpdA1p7KpY3RAyciZL0=;
 b=bhfzqJfl3TwdGjKqNWcfqIRTYmIlYBqxEm/O+c43fk+w68BClXpN7+yYZkpCviOEX5rcKj
 JD6gWNf/Jye5h7ZOeQvKDlwVO1Fij99ExVEOdOnJFQlSNx9O76DmRPoPvI4crGrnqtRrsp
 /u5xQlmxqw7sZnG4E3YpHsWct3NxMmw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-P6ozYghtNqq7lGnughl8uQ-1; Wed,
 30 Sep 2026 06:39:23 -0400
X-MC-Unique: P6ozYghtNqq7lGnughl8uQ-1
X-Mimecast-MFC-AGG-ID: P6ozYghtNqq7lGnughl8uQ_1790764762
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 450381954B17; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA0361956042; Wed, 30 Sep 2026 10:39:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47F6721E6833; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 043/105] qapi: convert trivial intro sections for
 block-core.json
Date: Wed, 30 Sep 2026 12:38:08 +0200
Message-ID: <20260930103910.3934848-44-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260831201945.287730-44-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Straightforward semantic conflict with commit 0bb4f47124 (parallels:
report the stored dirty bitmaps in qemu-img info) resolved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 434 ++++++++++++++++---------------------------
 1 file changed, 158 insertions(+), 276 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index aed2888147..a583bcc05c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -132,8 +132,7 @@
 
 ##
 # @VmdkExtentInfo:
-#
-# Information about a VMDK extent file
+#     Information about a VMDK extent file
 #
 # @filename: Name of the extent file
 #
@@ -279,9 +278,8 @@
 
 ##
 # @ImageInfoSpecific:
-#
-# A discriminated record of image format specific information
-# structures.
+#     A discriminated record of image format specific information
+#     structures.
 #
 # @type: block driver name
 #
@@ -364,8 +362,7 @@
 
 ##
 # @BlockNodeInfo:
-#
-# Information about a QEMU image file
+#     Information about a QEMU image file
 #
 # @filename: name of the image file
 #
@@ -409,9 +406,8 @@
 
 ##
 # @ImageInfo:
-#
-# Information about a QEMU image file, and potentially its backing
-# image
+#     Information about a QEMU image file, and potentially its backing
+#     image
 #
 # @backing-image: info of the backing image
 #
@@ -425,10 +421,9 @@
 
 ##
 # @BlockChildInfo:
-#
-# Information about all nodes in the block graph starting at some
-# node, annotated with information about that node in relation to its
-# parent.
+#     Information about all nodes in the block graph starting at some
+#     node, annotated with information about that node in relation to
+#     its parent.
 #
 # @name: Child name of the root node in the `BlockGraphInfo` struct,
 #     in its role as the child of some undescribed parent node
@@ -460,8 +455,7 @@
 
 ##
 # @ImageCheck:
-#
-# Information about a QEMU image file check
+#     Information about a QEMU image file check
 #
 # @filename: name of the image file checked
 #
@@ -504,8 +498,8 @@
 
 ##
 # @MapEntry:
-#
-# Mapping information from a virtual block range to a host file range
+#     Mapping information from a virtual block range to a host file
+#     range
 #
 # @start: virtual (guest) offset of the first byte described by this
 #     entry
@@ -543,8 +537,7 @@
 
 ##
 # @BlockdevCacheInfo:
-#
-# Cache mode information for a block device
+#     Cache mode information for a block device
 #
 # @writeback: true if writeback mode is enabled
 #
@@ -574,8 +567,7 @@
 
 ##
 # @BlockDeviceInfo:
-#
-# Information about the backing device for a block device.
+#     Information about the backing device for a block device.
 #
 # @file: the filename of the backing device
 #
@@ -691,8 +683,7 @@
 
 ##
 # @BlockDeviceIoStatus:
-#
-# An enumeration of block device I/O status.
+#     An enumeration of block device I/O status.
 #
 # @ok: The last I/O operation has succeeded
 #
@@ -707,8 +698,7 @@
 
 ##
 # @BlockDirtyInfo:
-#
-# Block dirty bitmap information.
+#     Block dirty bitmap information.
 #
 # @name: the name of the dirty bitmap (Since 2.4)
 #
@@ -740,8 +730,7 @@
 
 ##
 # @Qcow2BitmapInfoFlags:
-#
-# An enumeration of flags that a bitmap can report to the user.
+#     An enumeration of flags that a bitmap can report to the user.
 #
 # @in-use: This flag is set by any process actively modifying the
 #     qcow2 file, and cleared when the updated bitmap is flushed to
@@ -759,8 +748,7 @@
 
 ##
 # @Qcow2BitmapInfo:
-#
-# Qcow2 bitmap information.
+#     Qcow2 bitmap information.
 #
 # @name: the name of the bitmap
 #
@@ -776,8 +764,7 @@
 
 ##
 # @ParallelsBitmapInfo:
-#
-# Parallels bitmap information.
+#     Parallels bitmap information.
 #
 # @name: the name of the bitmap
 #
@@ -794,8 +781,7 @@
 
 ##
 # @BlockLatencyHistogramInfo:
-#
-# Block latency histogram.
+#     Block latency histogram.
 #
 # @boundaries: list of interval boundary values in nanoseconds, all
 #     greater than zero and in ascending order.  For example, the list
@@ -893,8 +879,7 @@
 
 ##
 # @query-block:
-#
-# Get a list of `BlockInfo` for all virtual block devices.
+#     Get a list of `BlockInfo` for all virtual block devices.
 #
 # @flat: Omit nested data about the backing image, i.e. `BlockInfo`
 #     member 'inserted.image.backing-image' will be absent.
@@ -995,8 +980,7 @@
 
 ##
 # @BlockDeviceTimedStats:
-#
-# Statistics of a block device during a given interval of time.
+#     Statistics of a block device during a given interval of time.
 #
 # @interval_length: Interval used for calculating the statistics, in
 #     seconds.
@@ -1062,8 +1046,7 @@
 
 ##
 # @BlockDeviceStats:
-#
-# Statistics of a virtual block device or a block backing device.
+#     Statistics of a virtual block device or a block backing device.
 #
 # @rd_bytes: The number of bytes read by the device.
 #
@@ -1201,8 +1184,7 @@
 
 ##
 # @BlockStatsSpecificFile:
-#
-# File driver statistics
+#     File driver statistics
 #
 # @discard-nb-ok: The number of successful discard operations
 #     performed by the driver.
@@ -1222,8 +1204,7 @@
 
 ##
 # @BlockStatsSpecificNvme:
-#
-# NVMe driver statistics
+#     NVMe driver statistics
 #
 # @completion-errors: The number of completion errors.
 #
@@ -1243,8 +1224,7 @@
 
 ##
 # @BlockStatsSpecific:
-#
-# Block driver specific statistics
+#     Block driver specific statistics
 #
 # @driver: block driver name
 #
@@ -1261,8 +1241,7 @@
 
 ##
 # @BlockStats:
-#
-# Statistics of a virtual block device or a block backing device.
+#     Statistics of a virtual block device or a block backing device.
 #
 # @device: If the stats are for a virtual block device, the name
 #     corresponding to the virtual block device.
@@ -1295,8 +1274,7 @@
 
 ##
 # @query-blockstats:
-#
-# Query the `BlockStats` for all virtual block devices.
+#     Query the `BlockStats` for all virtual block devices.
 #
 # @query-nodes: If true, the command will query all the block nodes
 #     that have a node name, in a list which will include "parent"
@@ -1447,9 +1425,8 @@
 
 ##
 # @MirrorSyncMode:
-#
-# An enumeration of possible behaviors for the initial synchronization
-# phase of storage mirroring.
+#     An enumeration of possible behaviors for the initial
+#     synchronization phase of storage mirroring.
 #
 # @top: copies data in the topmost image to the destination
 #
@@ -1470,9 +1447,8 @@
 
 ##
 # @BitmapSyncMode:
-#
-# An enumeration of possible behaviors for the synchronization of a
-# bitmap when used for data copy operations.
+#     An enumeration of possible behaviors for the synchronization of
+#     a bitmap when used for data copy operations.
 #
 # @on-success: The bitmap is only synced when the operation is
 #     successful.  This is the behavior always used for incremental
@@ -1491,9 +1467,8 @@
 
 ##
 # @MirrorCopyMode:
-#
-# An enumeration whose values tell the mirror block job when to
-# trigger writes to the target.
+#     An enumeration whose values tell the mirror block job when to
+#     trigger writes to the target.
 #
 # @background: copy data in background only.
 #
@@ -1508,8 +1483,7 @@
 
 ##
 # @BlockJobInfoMirror:
-#
-# Information specific to mirror block jobs.
+#     Information specific to mirror block jobs.
 #
 # @actively-synced: Whether the source is actively synced to the
 #     target, i.e. same data and new writes are done synchronously to
@@ -1522,8 +1496,7 @@
 
 ##
 # @BlockJobInfo:
-#
-# Information about a long-running block device operation.
+#     Information about a long-running block device operation.
 #
 # @type: the job type ('stream' for image streaming)
 #
@@ -1575,8 +1548,7 @@
 
 ##
 # @query-block-jobs:
-#
-# Return information about long-running block device operations.
+#     Return information about long-running block device operations.
 #
 # Returns: a list of job info for each active block job
 #
@@ -1618,9 +1590,8 @@
 
 ##
 # @NewImageMode:
-#
-# An enumeration that tells QEMU how to set the backing file path in a
-# new image file.
+#     An enumeration that tells QEMU how to set the backing file path
+#     in a new image file.
 #
 # @existing: QEMU should look for an existing image file.
 #
@@ -1823,8 +1794,7 @@
 
 ##
 # @blockdev-snapshot-sync:
-#
-# Takes a synchronous snapshot of a block device.
+#     Takes a synchronous snapshot of a block device.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -2084,8 +2054,7 @@
 
 ##
 # @query-named-block-nodes:
-#
-# Get the named block driver list
+#     Get the named block driver list
 #
 # @flat: Omit the nested data about backing image ("backing-image"
 #     key) if true.  Default is false (Since 5.0)
@@ -2181,8 +2150,7 @@
 
 ##
 # @BlockPermission:
-#
-# Enum of base block permissions.
+#     Enum of base block permissions.
 #
 # @consistent-read: A user that has the "permission" of consistent
 #     reads is guaranteed that their view of the contents of the block
@@ -2212,8 +2180,7 @@
 
 ##
 # @XDbgBlockGraphEdge:
-#
-# Block Graph edge description for `x-debug-query-block-graph`.
+#     Block Graph edge description for `x-debug-query-block-graph`.
 #
 # @parent: parent id
 #
@@ -2235,8 +2202,7 @@
 
 ##
 # @XDbgBlockGraph:
-#
-# Block Graph - list of nodes and list of edges.
+#     Block Graph - list of nodes and list of edges.
 #
 # Since: 4.0
 ##
@@ -2245,8 +2211,7 @@
 
 ##
 # @x-debug-query-block-graph:
-#
-# Get the block graph.
+#     Get the block graph.
 #
 # Features:
 #
@@ -2288,8 +2253,7 @@
 
 ##
 # @DriveMirror:
-#
-# A set of parameters describing drive mirror setup.
+#     A set of parameters describing drive mirror setup.
 #
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
@@ -2442,9 +2406,8 @@
 
 ##
 # @block-dirty-bitmap-add:
-#
-# Create a dirty bitmap with a name on the node, and start tracking
-# the writes.
+#     Create a dirty bitmap with a name on the node, and start
+#     tracking the writes.
 #
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
@@ -2488,10 +2451,9 @@
 
 ##
 # @block-dirty-bitmap-clear:
-#
-# Clear (reset) a dirty bitmap on the device, so that an incremental
-# backup from this point in time forward will only backup clusters
-# modified after this clear operation.
+#     Clear (reset) a dirty bitmap on the device, so that an
+#     incremental backup from this point in time forward will only
+#     backup clusters modified after this clear operation.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2511,8 +2473,8 @@
 
 ##
 # @block-dirty-bitmap-enable:
-#
-# Enables a dirty bitmap so that it will begin tracking disk changes.
+#     Enables a dirty bitmap so that it will begin tracking disk
+#     changes.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2532,8 +2494,8 @@
 
 ##
 # @block-dirty-bitmap-disable:
-#
-# Disables a dirty bitmap so that it will stop tracking disk changes.
+#     Disables a dirty bitmap so that it will stop tracking disk
+#     changes.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2586,8 +2548,7 @@
 
 ##
 # @BlockDirtyBitmapSha256:
-#
-# SHA256 hash of dirty bitmap data
+#     SHA256 hash of dirty bitmap data
 #
 # @sha256: ASCII representation of SHA256 bitmap hash
 #
@@ -2598,8 +2559,7 @@
 
 ##
 # @x-debug-block-dirty-bitmap-sha256:
-#
-# Get bitmap SHA256.
+#     Get bitmap SHA256.
 #
 # Features:
 #
@@ -2618,8 +2578,7 @@
 
 ##
 # @blockdev-mirror:
-#
-# Start mirroring a block device's writes to a new destination.
+#     Start mirroring a block device's writes to a new destination.
 #
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
@@ -2705,8 +2664,7 @@
 
 ##
 # @BlockIOThrottle:
-#
-# A set of parameters describing block throttling.
+#     A set of parameters describing block throttling.
 #
 # @device: Block device name
 #
@@ -2857,8 +2815,7 @@
 
 ##
 # @ThrottleGroupProperties:
-#
-# Properties for throttle-group objects.
+#     Properties for throttle-group objects.
 #
 # @limits: limits to apply for this throttle group
 #
@@ -3265,8 +3222,7 @@
 
 ##
 # @BlockJobChangeOptions:
-#
-# Block job options that can be changed after job creation.
+#     Block job options that can be changed after job creation.
 #
 # @id: The job identifier
 #
@@ -3281,8 +3237,7 @@
 
 ##
 # @block-job-change:
-#
-# Change the block job's options.
+#     Change the block job's options.
 #
 # Since: 8.2
 ##
@@ -3291,8 +3246,7 @@
 
 ##
 # @BlockdevDiscardOptions:
-#
-# Determines how to handle discard requests.
+#     Determines how to handle discard requests.
 #
 # @ignore: Ignore the request
 #
@@ -3305,10 +3259,9 @@
 
 ##
 # @BlockdevDetectZeroesOptions:
-#
-# Describes the operation mode for the automatic conversion of plain
-# zero writes by the OS to driver specific optimized zero write
-# commands.
+#     Describes the operation mode for the automatic conversion of
+#     plain zero writes by the OS to driver specific optimized zero
+#     write commands.
 #
 # @off: Disabled (default)
 #
@@ -3325,8 +3278,7 @@
 
 ##
 # @BlockdevAioOptions:
-#
-# Selects the AIO backend to handle I/O requests
+#     Selects the AIO backend to handle I/O requests
 #
 # @threads: Use QEMU's thread pool
 #
@@ -3342,8 +3294,7 @@
 
 ##
 # @BlockdevCacheOptions:
-#
-# Includes cache-related options for block devices
+#     Includes cache-related options for block devices
 #
 # @direct: enables use of O_DIRECT (bypass the host page cache;
 #     default: false)
@@ -3358,8 +3309,7 @@
 
 ##
 # @BlockdevDriver:
-#
-# Drivers that are supported in block device operations.
+#     Drivers that are supported in block device operations.
 #
 # @throttle: Since 2.11
 #
@@ -3401,8 +3351,7 @@
 
 ##
 # @BlockdevOptionsFile:
-#
-# Driver specific block device options for the file backend.
+#     Driver specific block device options for the file backend.
 #
 # @filename: path to the image file
 #
@@ -3461,8 +3410,7 @@
 
 ##
 # @BlockdevOptionsNull:
-#
-# Driver specific block device options for the null backend.
+#     Driver specific block device options for the null backend.
 #
 # @size: size of the device in bytes.
 #
@@ -3481,8 +3429,7 @@
 
 ##
 # @BlockdevOptionsNVMe:
-#
-# Driver specific block device options for the NVMe backend.
+#     Driver specific block device options for the NVMe backend.
 #
 # @device: PCI controller address of the NVMe device in format
 #     hhhh:bb:ss.f (host:bus:slot.function)
@@ -3499,8 +3446,7 @@
 
 ##
 # @BlockdevOptionsVVFAT:
-#
-# Driver specific block device options for the vvfat protocol.
+#     Driver specific block device options for the vvfat protocol.
 #
 # @dir: directory to be exported as FAT image
 #
@@ -3524,9 +3470,8 @@
 
 ##
 # @BlockdevOptionsGenericFormat:
-#
-# Driver specific block device options for image format that have no
-# option besides their data source.
+#     Driver specific block device options for image format that have
+#     no option besides their data source.
 #
 # @file: reference to or definition of the data source block device
 #
@@ -3537,8 +3482,7 @@
 
 ##
 # @BlockdevOptionsLUKS:
-#
-# Driver specific block device options for LUKS.
+#     Driver specific block device options for LUKS.
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when doing a metadata-only
@@ -3555,9 +3499,9 @@
 
 ##
 # @BlockdevOptionsGenericCOWFormat:
-#
-# Driver specific block device options for image format that have no
-# option besides their data source and an optional backing file.
+#     Driver specific block device options for image format that have
+#     no option besides their data source and an optional backing
+#     file.
 #
 # @backing: reference to or definition of the backing file block
 #     device, null disables the backing file entirely.  Defaults to
@@ -3571,8 +3515,7 @@
 
 ##
 # @Qcow2OverlapCheckMode:
-#
-# General overlap check modes.
+#     General overlap check modes.
 #
 # @none: Do not perform any checks
 #
@@ -3635,9 +3578,8 @@
 
 ##
 # @Qcow2OverlapChecks:
-#
-# Specifies which metadata structures should be guarded against
-# unintended overwriting.
+#     Specifies which metadata structures should be guarded against
+#     unintended overwriting.
 #
 # @flags: set of flags for separate specification of each metadata
 #     structure type
@@ -3674,8 +3616,7 @@
 
 ##
 # @BlockdevOptionsQcow:
-#
-# Driver specific block device options for qcow.
+#     Driver specific block device options for qcow.
 #
 # @encrypt: Image decryption options.  Mandatory for encrypted images,
 #     except when doing a metadata-only probe of the image.
@@ -3711,9 +3652,8 @@
 
 ##
 # @BlockdevOptionsPreallocate:
-#
-# Filter driver intended to be inserted between format and protocol
-# node and do preallocation in protocol node on write.
+#     Filter driver intended to be inserted between format and
+#     protocol node and do preallocation in protocol node on write.
 #
 # @prealloc-align: on preallocation, align file length to this number,
 #     default 1048576 (1M)
@@ -3728,8 +3668,7 @@
 
 ##
 # @BlockdevOptionsQcow2:
-#
-# Driver specific block device options for qcow2.
+#     Driver specific block device options for qcow2.
 #
 # @lazy-refcounts: whether to enable the lazy refcounts feature
 #     (default is taken from the image file)
@@ -3882,8 +3821,7 @@
 
 ##
 # @BlkdebugEvent:
-#
-# Trigger events supported by blkdebug.
+#     Trigger events supported by blkdebug.
 #
 # @l1_shrink_write_table: write zeros to the l1 table to shrink image.
 #     (since 2.11)
@@ -3919,8 +3857,7 @@
 
 ##
 # @BlkdebugIOType:
-#
-# Kinds of I/O that blkdebug can inject errors in.
+#     Kinds of I/O that blkdebug can inject errors in.
 #
 # @read: .bdrv_co_preadv()
 #
@@ -3942,8 +3879,7 @@
 
 ##
 # @BlkdebugInjectErrorOptions:
-#
-# Describes a single error injection for blkdebug.
+#     Describes a single error injection for blkdebug.
 #
 # @event: trigger event
 #
@@ -3981,8 +3917,7 @@
 
 ##
 # @BlkdebugSetStateOptions:
-#
-# Describes a single state-change event for blkdebug.
+#     Describes a single state-change event for blkdebug.
 #
 # @event: trigger event
 #
@@ -4001,8 +3936,7 @@
 
 ##
 # @BlockdevOptionsBlkdebug:
-#
-# Driver specific block device options for blkdebug.
+#     Driver specific block device options for blkdebug.
 #
 # @image: underlying raw block device (or image file)
 #
@@ -4063,8 +3997,7 @@
 
 ##
 # @BlockdevOptionsBlklogwrites:
-#
-# Driver specific block device options for blklogwrites.
+#     Driver specific block device options for blklogwrites.
 #
 # @file: block device
 #
@@ -4090,8 +4023,7 @@
 
 ##
 # @BlockdevOptionsBlkverify:
-#
-# Driver specific block device options for blkverify.
+#     Driver specific block device options for blkverify.
 #
 # @test: block device to be tested
 #
@@ -4105,8 +4037,7 @@
 
 ##
 # @BlockdevOptionsBlkreplay:
-#
-# Driver specific block device options for blkreplay.
+#     Driver specific block device options for blkreplay.
 #
 # @image: disk image which should be controlled with blkreplay
 #
@@ -4117,8 +4048,7 @@
 
 ##
 # @QuorumReadPattern:
-#
-# An enumeration of quorum read patterns.
+#     An enumeration of quorum read patterns.
 #
 # @quorum: read all the children and do a quorum vote on reads
 #
@@ -4130,8 +4060,7 @@
 
 ##
 # @BlockdevOptionsQuorum:
-#
-# Driver specific block device options for Quorum
+#     Driver specific block device options for Quorum
 #
 # @blkverify: true if the driver must print content mismatch set to
 #     false by default
@@ -4157,8 +4086,7 @@
 
 ##
 # @BlockdevOptionsIoUring:
-#
-# Driver specific block device options for the io_uring backend.
+#     Driver specific block device options for the io_uring backend.
 #
 # @filename: path to the image file
 #
@@ -4170,8 +4098,8 @@
 
 ##
 # @BlockdevOptionsNvmeIoUring:
-#
-# Driver specific block device options for the nvme-io_uring backend.
+#     Driver specific block device options for the nvme-io_uring
+#     backend.
 #
 # @path: path to the NVMe namespace's character device (e.g.
 #     /dev/ng0n1).
@@ -4184,9 +4112,8 @@
 
 ##
 # @BlockdevOptionsVirtioBlkVfioPci:
-#
-# Driver specific block device options for the virtio-blk-vfio-pci
-# backend.
+#     Driver specific block device options for the virtio-blk-vfio-pci
+#     backend.
 #
 # @path: path to the PCI device's sysfs directory (e.g.
 #     /sys/bus/pci/devices/0000:00:01.0).
@@ -4199,9 +4126,8 @@
 
 ##
 # @BlockdevOptionsVirtioBlkVhostUser:
-#
-# Driver specific block device options for the virtio-blk-vhost-user
-# backend.
+#     Driver specific block device options for the
+#     virtio-blk-vhost-user backend.
 #
 # @path: path to the vhost-user UNIX domain socket.
 #
@@ -4213,9 +4139,8 @@
 
 ##
 # @BlockdevOptionsVirtioBlkVhostVdpa:
-#
-# Driver specific block device options for the virtio-blk-vhost-vdpa
-# backend.
+#     Driver specific block device options for the
+#     virtio-blk-vhost-vdpa backend.
 #
 # @path: path to the vhost-vdpa character device.
 #
@@ -4234,8 +4159,7 @@
 
 ##
 # @IscsiTransport:
-#
-# An enumeration of libiscsi transport types
+#     An enumeration of libiscsi transport types
 #
 # Since: 2.9
 ##
@@ -4244,8 +4168,7 @@
 
 ##
 # @IscsiHeaderDigest:
-#
-# An enumeration of header digests supported by libiscsi
+#     An enumeration of header digests supported by libiscsi
 #
 # Since: 2.9
 ##
@@ -4255,8 +4178,7 @@
 
 ##
 # @BlockdevOptionsIscsi:
-#
-# Driver specific block device options for iscsi
+#     Driver specific block device options for iscsi
 #
 # @transport: The iscsi transport type
 #
@@ -4458,8 +4380,7 @@
 
 ##
 # @ReplicationMode:
-#
-# An enumeration of replication modes.
+#     An enumeration of replication modes.
 #
 # @primary: Primary mode, the vm's state will be sent to secondary
 #     QEMU.
@@ -4474,8 +4395,7 @@
 
 ##
 # @BlockdevOptionsReplication:
-#
-# Driver specific block device options for replication
+#     Driver specific block device options for replication
 #
 # @mode: the replication mode
 #
@@ -4493,8 +4413,7 @@
 
 ##
 # @NFSTransport:
-#
-# An enumeration of NFS transport types
+#     An enumeration of NFS transport types
 #
 # @inet: TCP transport
 #
@@ -4505,8 +4424,7 @@
 
 ##
 # @NFSServer:
-#
-# Captures the address of the socket
+#     Captures the address of the socket
 #
 # @type: transport type used for NFS (only TCP supported)
 #
@@ -4520,8 +4438,7 @@
 
 ##
 # @BlockdevOptionsNfs:
-#
-# Driver specific block device option for NFS
+#     Driver specific block device option for NFS
 #
 # @server: host address
 #
@@ -4558,9 +4475,8 @@
 
 ##
 # @BlockdevOptionsCurlBase:
-#
-# Driver specific block device options shared by all protocols
-# supported by the curl backend.
+#     Driver specific block device options shared by all protocols
+#     supported by the curl backend.
 #
 # @url: URL of the image file
 #
@@ -4661,8 +4577,7 @@
 
 ##
 # @BlockdevOptionsNbd:
-#
-# Driver specific block device options for NBD.
+#     Driver specific block device options for NBD.
 #
 # @server: NBD server address
 #
@@ -4710,8 +4625,7 @@
 
 ##
 # @BlockdevOptionsRaw:
-#
-# Driver specific block device options for the raw driver.
+#     Driver specific block device options for the raw driver.
 #
 # @offset: position where the block device starts
 #
@@ -4725,8 +4639,7 @@
 
 ##
 # @BlockdevOptionsThrottle:
-#
-# Driver specific block device options for the throttle driver
+#     Driver specific block device options for the throttle driver
 #
 # @throttle-group: the name of the throttle-group object to use.  It
 #     must already exist.
@@ -4742,8 +4655,8 @@
 
 ##
 # @BlockdevOptionsCor:
-#
-# Driver specific block device options for the copy-on-read driver.
+#     Driver specific block device options for the copy-on-read
+#     driver.
 #
 # @bottom: The name of a non-filter node (allocation-bearing layer)
 #     that limits the COR operations in the backing chain (inclusive),
@@ -4759,9 +4672,8 @@
 
 ##
 # @OnCbwError:
-#
-# An enumeration of possible behaviors for copy-before-write operation
-# failures.
+#     An enumeration of possible behaviors for copy-before-write
+#     operation failures.
 #
 # @break-guest-write: report the error to the guest.  This way, the
 #     guest will not be able to overwrite areas that cannot be backed
@@ -4936,8 +4848,7 @@
 
 ##
 # @BlockdevRef:
-#
-# Reference to a block device.
+#     Reference to a block device.
 #
 # @definition: defines a new block device inline
 #
@@ -4951,8 +4862,7 @@
 
 ##
 # @BlockdevRefOrNull:
-#
-# Reference to a block device.
+#     Reference to a block device.
 #
 # @definition: defines a new block device inline
 #
@@ -4971,8 +4881,7 @@
 
 ##
 # @blockdev-add:
-#
-# Creates a new block device.
+#     Creates a new block device.
 #
 # Since: 2.9
 #
@@ -5133,8 +5042,7 @@
 
 ##
 # @BlockdevCreateOptionsFile:
-#
-# Driver specific image creation options for file.
+#     Driver specific image creation options for file.
 #
 # @filename: Filename for the new image file
 #
@@ -5160,8 +5068,7 @@
 
 ##
 # @BlockdevCreateOptionsLUKS:
-#
-# Driver specific image creation options for LUKS.
+#     Driver specific image creation options for LUKS.
 #
 # @file: Node to create the image format on, mandatory except when
 #     'preallocation' is not requested
@@ -5184,8 +5091,7 @@
 
 ##
 # @BlockdevCreateOptionsNfs:
-#
-# Driver specific image creation options for NFS.
+#     Driver specific image creation options for NFS.
 #
 # @location: Where to store the new image file
 #
@@ -5199,8 +5105,7 @@
 
 ##
 # @BlockdevCreateOptionsParallels:
-#
-# Driver specific image creation options for parallels.
+#     Driver specific image creation options for parallels.
 #
 # @file: Node to create the image format on
 #
@@ -5217,8 +5122,7 @@
 
 ##
 # @BlockdevCreateOptionsQcow:
-#
-# Driver specific image creation options for qcow.
+#     Driver specific image creation options for qcow.
 #
 # @file: Node to create the image format on
 #
@@ -5252,8 +5156,7 @@
 
 ##
 # @Qcow2CompressionType:
-#
-# Compression type used in qcow2 image file
+#     Compression type used in qcow2 image file
 #
 # @zlib: zlib compression, see <http://zlib.net/>
 #
@@ -5266,8 +5169,7 @@
 
 ##
 # @BlockdevCreateOptionsQcow2:
-#
-# Driver specific image creation options for qcow2.
+#     Driver specific image creation options for qcow2.
 #
 # @file: Node to create the image format on
 #
@@ -5326,8 +5228,7 @@
 
 ##
 # @BlockdevCreateOptionsQed:
-#
-# Driver specific image creation options for qed.
+#     Driver specific image creation options for qed.
 #
 # @file: Node to create the image format on
 #
@@ -5354,8 +5255,7 @@
 
 ##
 # @BlockdevCreateOptionsRbd:
-#
-# Driver specific image creation options for rbd/Ceph.
+#     Driver specific image creation options for rbd/Ceph.
 #
 # @location: Where to store the new image file.  This location cannot
 #     point to a snapshot.
@@ -5376,8 +5276,7 @@
 
 ##
 # @BlockdevVmdkSubformat:
-#
-# Subformat options for VMDK images
+#     Subformat options for VMDK images
 #
 # @monolithicSparse: Single file image with sparse cluster allocation
 #
@@ -5400,8 +5299,7 @@
 
 ##
 # @BlockdevVmdkAdapterType:
-#
-# Adapter type info for VMDK images
+#     Adapter type info for VMDK images
 #
 # Since: 4.0
 ##
@@ -5410,8 +5308,7 @@
 
 ##
 # @BlockdevCreateOptionsVmdk:
-#
-# Driver specific image creation options for VMDK.
+#     Driver specific image creation options for VMDK.
 #
 # @file: Where to store the new image file.  This refers to the image
 #     file for monolithcSparse and streamOptimized format, or the
@@ -5459,8 +5356,7 @@
 
 ##
 # @BlockdevCreateOptionsSsh:
-#
-# Driver specific image creation options for SSH.
+#     Driver specific image creation options for SSH.
 #
 # @location: Where to store the new image file
 #
@@ -5474,8 +5370,7 @@
 
 ##
 # @BlockdevCreateOptionsVdi:
-#
-# Driver specific image creation options for VDI.
+#     Driver specific image creation options for VDI.
 #
 # @file: Node to create the image format on
 #
@@ -5505,8 +5400,7 @@
 
 ##
 # @BlockdevCreateOptionsVhdx:
-#
-# Driver specific image creation options for vhdx.
+#     Driver specific image creation options for vhdx.
 #
 # @file: Node to create the image format on
 #
@@ -5549,8 +5443,7 @@
 
 ##
 # @BlockdevCreateOptionsVpc:
-#
-# Driver specific image creation options for vpc (VHD).
+#     Driver specific image creation options for vpc (VHD).
 #
 # @file: Node to create the image format on
 #
@@ -5572,8 +5465,7 @@
 
 ##
 # @BlockdevCreateOptions:
-#
-# Options for creating an image format on a given node.
+#     Options for creating an image format on a given node.
 #
 # @driver: block driver to create the image format
 #
@@ -5618,8 +5510,7 @@
 
 ##
 # @BlockdevAmendOptionsLUKS:
-#
-# Driver specific image amend options for LUKS.
+#     Driver specific image amend options for LUKS.
 #
 # Since: 5.1
 ##
@@ -5643,8 +5534,7 @@
 
 ##
 # @BlockdevAmendOptions:
-#
-# Options for amending an image format
+#     Options for amending an image format
 #
 # @driver: Block driver of the node to amend.
 #
@@ -5692,8 +5582,8 @@
 
 ##
 # @BlockErrorAction:
-#
-# An enumeration of action that has been taken when a DISK I/O occurs
+#     An enumeration of action that has been taken when a DISK I/O
+#     occurs
 #
 # @ignore: error has been ignored
 #
@@ -5756,8 +5646,7 @@
 
 ##
 # @BLOCK_IO_ERROR:
-#
-# Emitted when a disk I/O error occurs
+#     Emitted when a disk I/O error occurs
 #
 # @qom-path: path to the device object in the QOM tree (since 9.2)
 #
@@ -5809,8 +5698,7 @@
 
 ##
 # @BLOCK_JOB_COMPLETED:
-#
-# Emitted when a block job has completed
+#     Emitted when a block job has completed
 #
 # @type: job type
 #
@@ -5849,8 +5737,7 @@
 
 ##
 # @BLOCK_JOB_CANCELLED:
-#
-# Emitted when a block job has been cancelled
+#     Emitted when a block job has been cancelled
 #
 # @type: job type
 #
@@ -5883,8 +5770,7 @@
 
 ##
 # @BLOCK_JOB_ERROR:
-#
-# Emitted when a block job encounters an error
+#     Emitted when a block job encounters an error
 #
 # @device: The job identifier.  Originally the device name but other
 #     values are allowed since QEMU 2.7
@@ -5910,8 +5796,7 @@
 
 ##
 # @BLOCK_JOB_READY:
-#
-# Emitted when a block job is ready to complete
+#     Emitted when a block job is ready to complete
 #
 # @type: job type
 #
@@ -5970,8 +5855,7 @@
 
 ##
 # @PreallocMode:
-#
-# Preallocation mode of QEMU image file
+#     Preallocation mode of QEMU image file
 #
 # @off: no preallocation
 #
@@ -6150,8 +6034,7 @@
 
 ##
 # @QuorumOpType:
-#
-# An enumeration of the quorum operation types
+#     An enumeration of the quorum operation types
 #
 # @read: read operation
 #
@@ -6166,8 +6049,8 @@
 
 ##
 # @QUORUM_FAILURE:
-#
-# Emitted by the Quorum block driver if it fails to establish a quorum
+#     Emitted by the Quorum block driver if it fails to establish a
+#     quorum
 #
 # @reference: device name if defined else node name
 #
@@ -6190,8 +6073,7 @@
 
 ##
 # @QUORUM_REPORT_BAD:
-#
-# Emitted to report a corruption of a Quorum file
+#     Emitted to report a corruption of a Quorum file
 #
 # @type: quorum operation type (Since 2.6)
 #
@@ -6324,8 +6206,8 @@
 
 ##
 # @DummyBlockCoreForceArrays:
-#
-# Not used by QMP; hack to let us use BlockGraphInfoList internally
+#     Not used by QMP; hack to let us use BlockGraphInfoList
+#     internally
 #
 # Since: 8.0
 ##
-- 
2.55.0


