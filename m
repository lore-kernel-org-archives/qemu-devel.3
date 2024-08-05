Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1B8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 08:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sasd5-0000RP-1u; Mon, 05 Aug 2024 03:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sasd2-0000M9-T3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sascx-0005P2-D2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722844773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufNZMEyo4pifiZFh1OsL2OHFPUOD9UzmkC+pt4aZCQU=;
 b=Wohe+PK4KKxc1qshLrv7qsDwmENFAKfKArwSqoiin+GOU7GrN+8JOUt1DXKnPq53EcndzF
 vvTkcBXcdyb6GAQ0VGdkilz4lEXHZAdRLBLanWxlKhr8BRXv60fQgCfiplhqcAZGq6jbZo
 wNaaMHgyijr3Xqs6pFztp8Q1A4AHPPY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-C6IJ-SCvMeu3zoMCpfW2pg-1; Mon,
 05 Aug 2024 03:59:29 -0400
X-MC-Unique: C6IJ-SCvMeu3zoMCpfW2pg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C77E71955D53; Mon,  5 Aug 2024 07:59:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D36301955D44; Mon,  5 Aug 2024 07:59:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A963B21EC369; Mon,  5 Aug 2024 09:59:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 1/2] qapi: Refill doc comments to conform to conventions
Date: Mon,  5 Aug 2024 09:59:24 +0200
Message-ID: <20240805075925.2062973-2-armbru@redhat.com>
In-Reply-To: <20240805075925.2062973-1-armbru@redhat.com>
References: <20240805075925.2062973-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Sweep the entire documentation again.  Last done in commit
209e64d9edf (qapi: Refill doc comments to conform to current
conventions).

To check the generated documentation does not change, I compared the
generated HTML before and after this commit with "wdiff -3".  Finds no
differences.  Comparing with diff is not useful, as the reflown
paragraphs are visible there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240729065220.860163-1-armbru@redhat.com>
[Straightforward conflict with commit 442110bc6f3 resolved]
---
 qapi/block-core.json     | 71 ++++++++++++++++++++--------------------
 qapi/block-export.json   |  8 ++---
 qapi/block.json          | 12 +++----
 qapi/char.json           |  8 ++---
 qapi/control.json        | 14 ++++----
 qapi/crypto.json         |  8 ++---
 qapi/cxl.json            | 42 ++++++++++++------------
 qapi/dump.json           |  2 +-
 qapi/ebpf.json           |  2 +-
 qapi/introspect.json     |  4 +--
 qapi/job.json            |  8 ++---
 qapi/machine-target.json | 54 +++++++++++++++---------------
 qapi/machine.json        | 22 ++++++-------
 qapi/migration.json      | 68 +++++++++++++++++++-------------------
 qapi/misc.json           | 31 +++++++++---------
 qapi/net.json            | 27 +++++++++------
 qapi/pci.json            |  1 -
 qapi/qdev.json           | 20 +++++------
 qapi/qom.json            | 38 ++++++++++-----------
 qapi/rocker.json         |  4 +--
 qapi/run-state.json      | 12 +++----
 qapi/sockets.json        |  5 +--
 qapi/stats.json          |  6 ++--
 qapi/transaction.json    |  4 +--
 qapi/ui.json             | 27 +++++++--------
 qapi/vfio.json           |  8 ++---
 qapi/virtio.json         |  6 ++--
 27 files changed, 262 insertions(+), 250 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f400b334c8..a1b7cdc58e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1158,11 +1158,11 @@
 #
 # @query-nodes: If true, the command will query all the block nodes
 #     that have a node name, in a list which will include "parent"
-#     information, but not "backing". If false or omitted, the
+#     information, but not "backing".  If false or omitted, the
 #     behavior is as before - query all the device backends,
-#     recursively including their "parent" and "backing". Filter nodes
-#     that were created implicitly are skipped over in this mode.
-#     (Since 2.3)
+#     recursively including their "parent" and "backing".  Filter
+#     nodes that were created implicitly are skipped over in this
+#     mode.  (Since 2.3)
 #
 # Returns: A list of @BlockStats for each virtual block devices.
 #
@@ -1286,7 +1286,7 @@
 #     jobs, cancel the job
 #
 # @ignore: ignore the error, only report a QMP event (BLOCK_IO_ERROR
-#     or BLOCK_JOB_ERROR). The backup, mirror and commit block jobs
+#     or BLOCK_JOB_ERROR).  The backup, mirror and commit block jobs
 #     retry the failing request later and may still complete
 #     successfully.  The stream block job continues to stream and will
 #     complete with an error.
@@ -1574,7 +1574,7 @@
 #     for unlimited.
 #
 # @bitmap: The name of a dirty bitmap to use.  Must be present if sync
-#     is "bitmap" or "incremental". Can be present if sync is "full"
+#     is "bitmap" or "incremental".  Can be present if sync is "full"
 #     or "top".  Must not be present otherwise.
 #     (Since 2.4 (drive-backup), 3.1 (blockdev-backup))
 #
@@ -1619,9 +1619,9 @@
 #
 # @unstable: Member @x-perf is experimental.
 #
-# .. note:: @on-source-error and @on-target-error only affect background
-#    I/O.  If an error occurs during a guest write request, the device's
-#    rerror/werror actions will be used.
+# .. note:: @on-source-error and @on-target-error only affect
+#    background I/O.  If an error occurs during a guest write request,
+#    the device's rerror/werror actions will be used.
 #
 # Since: 4.2
 ##
@@ -1699,7 +1699,7 @@
 # Takes a snapshot of a block device.
 #
 # Take a snapshot, by installing 'node' as the backing image of
-# 'overlay'. Additionally, if 'node' is associated with a block
+# 'overlay'.  Additionally, if 'node' is associated with a block
 # device, the block device changes to using 'overlay' as its new
 # active image.
 #
@@ -1738,7 +1738,7 @@
 # Change the backing file in the image file metadata.  This does not
 # cause QEMU to reopen the image file to reparse the backing filename
 # (it may, however, perform a reopen to change permissions from r/o ->
-# r/w -> r/o, if needed). The new backing file string is written into
+# r/w -> r/o, if needed).  The new backing file string is written into
 # the image file metadata, and the QEMU internal strings are updated.
 #
 # @image-node-name: The name of the block driver state node of the
@@ -1882,8 +1882,8 @@
 # Start a point-in-time copy of a block device to a new destination.
 # The status of ongoing drive-backup operations can be checked with
 # query-block-jobs where the BlockJobInfo.type field has the value
-# 'backup'. The operation can be stopped before it has completed using
-# the block-job-cancel command.
+# 'backup'.  The operation can be stopped before it has completed
+# using the block-job-cancel command.
 #
 # Features:
 #
@@ -1913,8 +1913,8 @@
 # Start a point-in-time copy of a block device to a new destination.
 # The status of ongoing blockdev-backup operations can be checked with
 # query-block-jobs where the BlockJobInfo.type field has the value
-# 'backup'. The operation can be stopped before it has completed using
-# the block-job-cancel command.
+# 'backup'.  The operation can be stopped before it has completed
+# using the block-job-cancel command.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -2832,7 +2832,7 @@
 #
 # @speed: the maximum speed, in bytes per second
 #
-# @on-error: the action to take on an error (default report). 'stop'
+# @on-error: the action to take on an error (default report).  'stop'
 #     and 'enospc' can only be used if the block device supports
 #     io-status (see BlockInfo).  (Since 1.3)
 #
@@ -3034,8 +3034,8 @@
 # semantics.
 #
 # This command will refuse to operate on any job that has not yet
-# reached its terminal state, JOB_STATUS_CONCLUDED. For jobs that make
-# use of the BLOCK_JOB_READY event, block-job-cancel or
+# reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
+# make use of the BLOCK_JOB_READY event, block-job-cancel or
 # block-job-complete will still need to be used as appropriate.
 #
 # @id: The job identifier.
@@ -3351,7 +3351,7 @@
 # Driver specific block device options for LUKS.
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
-#     decryption key (since 2.6). Mandatory except when doing a
+#     decryption key (since 2.6).  Mandatory except when doing a
 #     metadata-only probe of the image.
 #
 # @header: block device holding a detached LUKS header.  (since 9.0)
@@ -4050,6 +4050,7 @@
 # @path: path to the vhost-vdpa character device.
 #
 # Features:
+#
 # @fdset: Member @path supports the special "/dev/fdset/N" path
 #     (since 8.1)
 #
@@ -4427,7 +4428,7 @@
 # curl backend.  URLs must start with "http://".
 #
 # @cookie: List of cookies to set; format is "name1=content1;
-#     name2=content2;" as explained by CURLOPT_COOKIE(3). Defaults to
+#     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to
 #     no cookies.
 #
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie
@@ -4447,7 +4448,7 @@
 # curl backend.  URLs must start with "https://".
 #
 # @cookie: List of cookies to set; format is "name1=content1;
-#     name2=content2;" as explained by CURLOPT_COOKIE(3). Defaults to
+#     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to
 #     no cookies.
 #
 # @sslverify: Whether to verify the SSL certificate's validity
@@ -4653,10 +4654,10 @@
 #
 # @driver: block driver name
 #
-# @node-name: the node name of the new node (Since 2.0). This option
+# @node-name: the node name of the new node (Since 2.0).  This option
 #     is required on the top level of blockdev-add.  Valid node names
 #     start with an alphabetic character and may contain only
-#     alphanumeric characters, '-', '.' and '_'. Their maximum length
+#     alphanumeric characters, '-', '.' and '_'.  Their maximum length
 #     is 31 characters.
 #
 # @discard: discard-related options (default: ignore)
@@ -4664,7 +4665,7 @@
 # @cache: cache-related options
 #
 # @read-only: whether the block device should be read-only (default:
-#     false). Note that some block drivers support only read-only
+#     false).  Note that some block drivers support only read-only
 #     access, either generally or in certain configurations.  In this
 #     case, the default value does not work and the option must be
 #     specified explicitly.
@@ -5231,8 +5232,8 @@
 #     monolithcFlat, twoGbMaxExtentSparse and twoGbMaxExtentFlat
 #     formats.  For monolithicFlat, only one entry is required; for
 #     twoGbMaxExtent* formats, the number of entries required is
-#     calculated as extent_number = virtual_size / 2GB. Providing more
-#     extents than will be used is an error.
+#     calculated as extent_number = virtual_size / 2GB.  Providing
+#     more extents than will be used is an error.
 #
 # @subformat: The subformat of the VMDK image.  Default:
 #     "monolithicSparse".
@@ -5244,7 +5245,7 @@
 #     Default: ide.
 #
 # @hwversion: Hardware version.  The meaningful options are "4" or
-#     "6". Default: "4".
+#     "6".  Default: "4".
 #
 # @toolsversion: VMware guest tools version.  Default: "2147483647"
 #     (Since 6.2)
@@ -5440,7 +5441,7 @@
 ##
 # @BlockdevAmendOptionsQcow2:
 #
-# Driver specific image amend options for qcow2. For now, only
+# Driver specific image amend options for qcow2.  For now, only
 # encryption options can be amended
 #
 # @encrypt: Encryption options to be amended
@@ -5543,8 +5544,8 @@
 #     after this event and must be repaired (Since 2.2; before, every
 #     BLOCK_IMAGE_CORRUPTED event was fatal)
 #
-# .. note:: If action is "stop", a STOP event will eventually follow the
-#    BLOCK_IO_ERROR event.
+# .. note:: If action is "stop", a STOP event will eventually follow
+#    the BLOCK_IO_ERROR event.
 #
 # .. qmp-example::
 #
@@ -5590,8 +5591,8 @@
 #     field is a debugging aid for humans, it should not be parsed by
 #     applications) (since: 2.2)
 #
-# .. note:: If action is "stop", a STOP event will eventually follow the
-#    BLOCK_IO_ERROR event.
+# .. note:: If action is "stop", a STOP event will eventually follow
+#    the BLOCK_IO_ERROR event.
 #
 # Since: 0.13
 #
@@ -6046,9 +6047,9 @@
 #
 # @name: the name of the internal snapshot to be created
 #
-# .. note:: In a transaction, if @name is empty or any snapshot matching
-#    @name exists, the operation will fail.  Only some image formats
-#    support it; for example, qcow2, and rbd.
+# .. note:: In a transaction, if @name is empty or any snapshot
+#    matching @name exists, the operation will fail.  Only some image
+#    formats support it; for example, qcow2, and rbd.
 #
 # Since: 1.7
 ##
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 3919a2d5b9..665d5fd026 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -163,8 +163,8 @@
 # Options for exporting a block graph node on some (file) mountpoint
 # as a raw image.
 #
-# @mountpoint: Path on which to export the block device via FUSE. This
-#     must point to an existing regular file.
+# @mountpoint: Path on which to export the block device via FUSE.
+#     This must point to an existing regular file.
 #
 # @growable: Whether writes beyond the EOF should grow the block node
 #     accordingly.  (default: false)
@@ -172,7 +172,7 @@
 # @allow-other: If this is off, only qemu's user is allowed access to
 #     this export.  That cannot be changed even with chmod or chown.
 #     Enabling this option will allow other users access to the export
-#     with the FUSE mount option "allow_other". Note that using
+#     with the FUSE mount option "allow_other".  Note that using
 #     allow_other as a non-root user requires user_allow_other to be
 #     enabled in the global fuse.conf configuration file.  In auto
 #     mode (the default), the FUSE export driver will first attempt to
@@ -199,7 +199,7 @@
 # @queue-size: the size of virtqueue.  Defaults to 256.
 #
 # @logical-block-size: Logical block size in bytes.  Range [512,
-#     PAGE_SIZE] and must be power of 2. Defaults to 512 bytes.
+#     PAGE_SIZE] and must be power of 2.  Defaults to 512 bytes.
 #
 # @serial: the serial number of virtio block device.  Defaults to
 #     empty string.
diff --git a/qapi/block.json b/qapi/block.json
index ce9490a367..e66666f5c6 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -454,8 +454,8 @@
 # different group.  In this case the limits specified in the
 # parameters will be applied to the new group only.
 #
-# I/O limits can be disabled by setting all of them to 0. In this case
-# the device will be removed from its group and the rest of its
+# I/O limits can be disabled by setting all of them to 0.  In this
+# case the device will be removed from its group and the rest of its
 # members will not be affected.  The 'group' parameter is ignored.
 #
 # Errors:
@@ -519,10 +519,10 @@
 # @id: The name or QOM path of the guest device.
 #
 # @boundaries: list of interval boundary values (see description in
-#     BlockLatencyHistogramInfo definition). If specified, all latency
-#     histograms are removed, and empty ones created for all io types
-#     with intervals corresponding to @boundaries (except for io
-#     types, for which specific boundaries are set through the
+#     BlockLatencyHistogramInfo definition).  If specified, all
+#     latency histograms are removed, and empty ones created for all
+#     io types with intervals corresponding to @boundaries (except for
+#     io types, for which specific boundaries are set through the
 #     following parameters).
 #
 # @boundaries-read: list of interval boundary values for read latency
diff --git a/qapi/char.json b/qapi/char.json
index 5e4aeb9799..ef58445cee 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -258,7 +258,7 @@
 # @server: create server socket (default: true)
 #
 # @wait: wait for incoming connection on server sockets (default:
-#     false). Silently ignored with server: false.  This use is
+#     false).  Silently ignored with server: false.  This use is
 #     deprecated.
 #
 # @nodelay: set TCP_NODELAY socket option (default: false)
@@ -388,9 +388,9 @@
 #
 # @rows: console height, in chars
 #
-# .. note:: The options are only effective when the VNC or SDL graphical
-#    display backend is active.  They are ignored with the GTK, Spice,
-#    VNC and D-Bus display backends.
+# .. note:: The options are only effective when the VNC or SDL
+#    graphical display backend is active.  They are ignored with the
+#    GTK, Spice, VNC and D-Bus display backends.
 #
 # Since: 1.5
 ##
diff --git a/qapi/control.json b/qapi/control.json
index 950443df9d..336386f79e 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -22,13 +22,14 @@
 #          "arguments": { "enable": [ "oob" ] } }
 #     <- { "return": {} }
 #
-# .. note:: This command is valid exactly when first connecting: it must
-#    be issued before any other command will be accepted, and will fail
-#    once the monitor is accepting other commands.
-#    (see :doc:`/interop/qmp-spec`)
+# .. note:: This command is valid exactly when first connecting: it
+#    must be issued before any other command will be accepted, and
+#    will fail once the monitor is accepting other commands.  (see
+#    :doc:`/interop/qmp-spec`)
 #
-# .. note:: The QMP client needs to explicitly enable QMP capabilities,
-#    otherwise all the QMP capabilities will be turned off by default.
+# .. note:: The QMP client needs to explicitly enable QMP
+#    capabilities, otherwise all the QMP capabilities will be turned
+#    off by default.
 #
 # Since: 0.13
 ##
@@ -150,7 +151,6 @@
 #        }
 #
 # This example has been shortened as the real response is too long.
-#
 ##
 { 'command': 'query-commands', 'returns': ['CommandInfo'],
   'allow-preconfig': true }
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 39b191e8a2..97e02dbd59 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -44,13 +44,13 @@
 #
 # The supported algorithms for computing content digests
 #
-# @md5: MD5. Should not be used in any new code, legacy compat only
+# @md5: MD5.  Should not be used in any new code, legacy compat only
 #
-# @sha1: SHA-1. Should not be used in any new code, legacy compat only
+# @sha1: SHA-1.  Should not be used in any new code, legacy compat only
 #
 # @sha224: SHA-224.  (since 2.7)
 #
-# @sha256: SHA-256. Current recommended strong hash.
+# @sha256: SHA-256.  Current recommended strong hash.
 #
 # @sha384: SHA-384.  (since 2.7)
 #
@@ -440,7 +440,7 @@
 #
 # @iv: the random initialization vector used for encryption of this
 #     particular secret.  Should be a base64 encrypted string of the
-#     16-byte IV. Mandatory if @keyid is given.  Ignored if @keyid is
+#     16-byte IV.  Mandatory if @keyid is given.  Ignored if @keyid is
 #     absent.
 #
 # Features:
diff --git a/qapi/cxl.json b/qapi/cxl.json
index bdfac67c47..e9315d5b4d 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -369,8 +369,8 @@
 # of memory by Device Physical Address within a single Dynamic
 # Capacity Region on a CXL Type 3 Device.
 #
-# @offset: The offset (in bytes) to the start of the region
-#     where the extent belongs to.
+# @offset: The offset (in bytes) to the start of the region where the
+#     extent belongs to.
 #
 # @len: The length of the extent in bytes.
 #
@@ -404,16 +404,16 @@
 #
 # @enable-shared-access: Capacity has already been allocated to a
 #     different host using free, contiguous or prescriptive policy
-#     with a known tag.  This policy then instructs the device to
-#     make the capacity with the specified tag available to an
-#     additional host.  Capacity is implicit as it matches that
-#     already associated with the tag.  Note that the extent list
-#     (and hence Device Physical Addresses) used are per host, so
-#     a device may use different representations on each host.
-#     The ordering of the extents provided to each host is indicated
-#     to the host using per extent sequence numbers generated by
-#     the device.  Has a similar meaning for temporal sharing, but
-#     in that case there may be only one host involved.
+#     with a known tag.  This policy then instructs the device to make
+#     the capacity with the specified tag available to an additional
+#     host.  Capacity is implicit as it matches that already
+#     associated with the tag.  Note that the extent list (and hence
+#     Device Physical Addresses) used are per host, so a device may
+#     use different representations on each host.  The ordering of the
+#     extents provided to each host is indicated to the host using per
+#     extent sequence numbers generated by the device.  Has a similar
+#     meaning for temporal sharing, but in that case there may be only
+#     one host involved.
 #
 # Since: 9.1
 ##
@@ -429,7 +429,7 @@
 #
 # Initiate adding dynamic capacity extents to a host.  This simulates
 # operations defined in Compute Express Link (CXL) Specification,
-# Revision 3.1, Section 7.6.7.6.5. Note that, currently, establishing
+# Revision 3.1, Section 7.6.7.6.5.  Note that, currently, establishing
 # success or failure of the full Add Dynamic Capacity flow requires
 # out of band communication with the OS of the CXL host.
 #
@@ -495,7 +495,7 @@
 #
 # Initiate release of dynamic capacity extents from a host.  This
 # simulates operations defined in Compute Express Link (CXL)
-# Specification, Revision 3.1, Section 7.6.7.6.6. Note that,
+# Specification, Revision 3.1, Section 7.6.7.6.6.  Note that,
 # currently, success or failure of the full Release Dynamic Capacity
 # flow requires out of band communication with the OS of the CXL host.
 #
@@ -514,13 +514,13 @@
 #     from the host.  Instead, the host immediately looses access to
 #     the released capacity.
 #
-# @sanitize-on-release: Bit[5] of the "Flags" field in Compute
-#     Express Link (CXL) Specification, Revision 3.1, Table 7-71.
-#     When set, the device should sanitize all released capacity as
-#     a result of this request. This ensures that all user data
-#     and metadata is made permanently unavailable by whatever
-#     means is appropriate for the media type. Note that changing
-#     encryption keys is not sufficient.
+# @sanitize-on-release: Bit[5] of the "Flags" field in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-71.  When set,
+#     the device should sanitize all released capacity as a result of
+#     this request.  This ensures that all user data and metadata is
+#     made permanently unavailable by whatever means is appropriate
+#     for the media type.  Note that changing encryption keys is not
+#     sufficient.
 #
 # @region: The "Region Number" field as defined in Compute Express
 #     Link Specification, Revision 3.1, Table 7-71.  Valid range
diff --git a/qapi/dump.json b/qapi/dump.json
index d8145dad97..d7826c0e32 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -55,7 +55,7 @@
 #     allows using gdb to process the core file.
 #
 #     IMPORTANT: this option can make QEMU allocate several gigabytes
-#     of RAM. This can happen for a large guest, or a malicious guest
+#     of RAM.  This can happen for a large guest, or a malicious guest
 #     pretending to be large.
 #
 #     Also, paging=true has the following limitations:
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index e500b5a744..db19ae850f 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -8,7 +8,7 @@
 # = eBPF Objects
 #
 # eBPF object is an ELF binary that contains the eBPF program and eBPF
-# map description(BTF). Overall, eBPF object should contain the
+# map description(BTF).  Overall, eBPF object should contain the
 # program and enough metadata to create/load eBPF with libbpf.  As the
 # eBPF maps/program should correspond to QEMU, the eBPF can't be used
 # from different QEMU build.
diff --git a/qapi/introspect.json b/qapi/introspect.json
index b15052ec21..14df049580 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -42,8 +42,8 @@
 #     with different meta-types).
 #
 # .. note:: The QAPI schema is also used to help define *internal*
-#    interfaces, by defining QAPI types.  These are not part of the QMP
-#    wire ABI, and therefore not returned by this command.
+#    interfaces, by defining QAPI types.  These are not part of the
+#    QMP wire ABI, and therefore not returned by this command.
 #
 # Since: 2.5
 ##
diff --git a/qapi/job.json b/qapi/job.json
index b3957207a4..cfc3beedd2 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -138,7 +138,7 @@
 #
 # The job will pause as soon as possible, which means transitioning
 # into the PAUSED state if it was RUNNING, or into STANDBY if it was
-# READY. The corresponding JOB_STATUS_CHANGE event will be emitted.
+# READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.
 #
 # Cancelling a paused job automatically resumes it.
 #
@@ -200,9 +200,9 @@
 # dismiss enabled.
 #
 # This command will refuse to operate on any job that has not yet
-# reached its terminal state, JOB_STATUS_CONCLUDED. For jobs that make
-# use of JOB_READY event, job-cancel or job-complete will still need
-# to be used as appropriate.
+# reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
+# make use of JOB_READY event, job-cancel or job-complete will still
+# need to be used as appropriate.
 #
 # @id: The job identifier.
 #
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 00bbecc905..1a394c08f5 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -12,9 +12,10 @@
 # Virtual CPU model.
 #
 # A CPU model consists of the name of a CPU definition, to which delta
-# changes are applied (e.g. features added/removed). Most magic values
-# that an architecture might require should be hidden behind the name.
-# However, if required, architectures can expose relevant properties.
+# changes are applied (e.g. features added/removed).  Most magic
+# values that an architecture might require should be hidden behind
+# the name.  However, if required, architectures can expose relevant
+# properties.
 #
 # @name: the name of the CPU definition the model is based on
 #
@@ -46,13 +47,13 @@
 #
 # .. note:: When a non-migration-safe CPU model is expanded in static
 #    mode, some features enabled by the CPU model may be omitted,
-#    because they can't be implemented by a static CPU model definition
-#    (e.g. cache info passthrough and PMU passthrough in x86). If you
-#    need an accurate representation of the features enabled by a
-#    non-migration-safe CPU model, use @full.  If you need a static
-#    representation that will keep ABI compatibility even when changing
-#    QEMU version or machine-type, use @static (but keep in mind that
-#    some features may be omitted).
+#    because they can't be implemented by a static CPU model
+#    definition (e.g. cache info passthrough and PMU passthrough in
+#    x86).  If you need an accurate representation of the features
+#    enabled by a non-migration-safe CPU model, use @full.  If you
+#    need a static representation that will keep ABI compatibility
+#    even when changing QEMU version or machine-type, use @static (but
+#    keep in mind that some features may be omitted).
 #
 # Since: 2.8
 ##
@@ -155,11 +156,11 @@
 # Some architectures may not support comparing CPU models.  s390x
 # supports comparing CPU models.
 #
-# @modela: description of the first CPU model to compare, referred to as
-#     "model A" in CpuModelCompareResult
+# @modela: description of the first CPU model to compare, referred to
+#     as "model A" in CpuModelCompareResult
 #
-# @modelb: description of the second CPU model to compare, referred to as
-#     "model B" in CpuModelCompareResult
+# @modelb: description of the second CPU model to compare, referred to
+#     as "model B" in CpuModelCompareResult
 #
 # Returns: a CpuModelCompareInfo describing how both CPU models
 #     compare
@@ -185,7 +186,8 @@
 #
 # Baseline two CPU models, @modela and @modelb, creating a compatible
 # third model.  The created model will always be a static,
-# migration-safe CPU model (see "static" CPU model expansion for details).
+# migration-safe CPU model (see "static" CPU model expansion for
+# details).
 #
 # This interface can be used by tooling to create a compatible CPU
 # model out two CPU models.  The created CPU model will be identical
@@ -242,12 +244,12 @@
 #
 # @model: the expanded CpuModelInfo.
 #
-# @deprecated-props: a list of properties that are flagged as deprecated
-#     by the CPU vendor.  The list depends on the CpuModelExpansionType:
-#     "static" properties are a subset of the enabled-properties for
-#     the expanded model; "full" properties are a set of properties
-#     that are deprecated across all models for the architecture.
-#     (since: 9.1).
+# @deprecated-props: a list of properties that are flagged as
+#     deprecated by the CPU vendor.  The list depends on the
+#     CpuModelExpansionType: "static" properties are a subset of the
+#     enabled-properties for the expanded model; "full" properties are
+#     a set of properties that are deprecated across all models for
+#     the architecture.  (since: 9.1).
 #
 # Since: 2.8
 ##
@@ -265,9 +267,9 @@
 # @query-cpu-model-expansion:
 #
 # Expands a given CPU model, @model, (or a combination of CPU model +
-# additional options) to different granularities, specified by
-# @type, allowing tooling to get an understanding what a specific
-# CPU model looks like in QEMU under a certain configuration.
+# additional options) to different granularities, specified by @type,
+# allowing tooling to get an understanding what a specific CPU model
+# looks like in QEMU under a certain configuration.
 #
 # This interface can be used to query the "host" CPU model.
 #
@@ -288,7 +290,7 @@
 #   Using query-cpu-model-expansion while using these is not advised.
 #
 # Some architectures may not support all expansion types.  s390x
-# supports "full" and "static". Arm only supports "full".
+# supports "full" and "static".  Arm only supports "full".
 #
 # @model: description of the CPU model to expand
 #
@@ -355,7 +357,7 @@
 # CPU model attributes that prevent the CPU from running.  If the QOM
 # property is read-only, that means there's no known way to make the
 # CPU model run in the current host.  Implementations that choose not
-# to provide specific information return the property name "type". If
+# to provide specific information return the property name "type".  If
 # the property is read-write, it means that it MAY be possible to run
 # the CPU model in the current host if that property is changed.
 # Management software can use it as hints to suggest or choose an
diff --git a/qapi/machine.json b/qapi/machine.json
index fcfd249e2d..4582e58f7d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -27,8 +27,8 @@
 # @loongarch64: since 7.1
 #
 # .. note:: The resulting QMP strings can be appended to the
-#    "qemu-system-" prefix to produce the corresponding QEMU executable
-#    name.  This is true even for "qemu-system-x86_64".
+#    "qemu-system-" prefix to produce the corresponding QEMU
+#    executable name.  This is true even for "qemu-system-x86_64".
 #
 # Since: 3.0
 ##
@@ -371,8 +371,8 @@
 #
 # .. note:: A guest may or may not respond to this command.  This
 #    command returning does not indicate that a guest has accepted the
-#    request or that it has shut down.  Many guests will respond to this
-#    command by prompting the user in some way.
+#    request or that it has shut down.  Many guests will respond to
+#    this command by prompting the user in some way.
 #
 # .. qmp-example::
 #
@@ -437,7 +437,7 @@
 # @inject-nmi:
 #
 # Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or
-# all CPUs (ppc64). The command fails when the guest doesn't support
+# all CPUs (ppc64).  The command fails when the guest doesn't support
 # injecting.
 #
 # Since: 0.14
@@ -988,8 +988,8 @@
 # @cluster-id: cluster number within the parent container the CPU
 #     belongs to (since 7.1)
 #
-# @module-id: module number within the parent container the CPU belongs
-#     to (since 9.1)
+# @module-id: module number within the parent container the CPU
+#    belongs to (since 9.1)
 #
 # @core-id: core number within the parent container the CPU belongs to
 #
@@ -1132,8 +1132,8 @@
 #     - If no balloon device is present, DeviceNotActive
 #
 # .. note:: This command just issues a request to the guest.  When it
-#    returns, the balloon size may not have changed.  A guest can change
-#    the balloon size independent of this command.
+#    returns, the balloon size may not have changed.  A guest can
+#    change the balloon size independent of this command.
 #
 # Since: 0.14
 #
@@ -1659,8 +1659,8 @@
 # The members other than @cpus and @maxcpus define a topology of
 # containers.
 #
-# The ordering from highest/coarsest to lowest/finest is:
-# @drawers, @books, @sockets, @dies, @clusters, @cores, @threads.
+# The ordering from highest/coarsest to lowest/finest is: @drawers,
+# @books, @sockets, @dies, @clusters, @cores, @threads.
 #
 # Different architectures support different subsets of topology
 # containers.
diff --git a/qapi/migration.json b/qapi/migration.json
index 073b67c052..7324571e92 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -142,8 +142,8 @@
 #
 # @postcopy-paused: during postcopy but paused.  (since 3.0)
 #
-# @postcopy-recover-setup: setup phase for a postcopy recovery process,
-#     preparing for a recovery phase to start.  (since 9.1)
+# @postcopy-recover-setup: setup phase for a postcopy recovery
+#     process, preparing for a recovery phase to start.  (since 9.1)
 #
 # @postcopy-recover: trying to recover from a paused postcopy.  (since
 #     3.0)
@@ -245,10 +245,10 @@
 #     blocked.  Present and non-empty when migration is blocked.
 #     (since 6.0)
 #
-# @dirty-limit-throttle-time-per-round: Maximum throttle time
-#     (in microseconds) of virtual CPUs each dirty ring full round,
-#     which shows how MigrationCapability dirty-limit affects the
-#     guest during live migration.  (Since 8.1)
+# @dirty-limit-throttle-time-per-round: Maximum throttle time (in
+#     microseconds) of virtual CPUs each dirty ring full round, which
+#     shows how MigrationCapability dirty-limit affects the guest
+#     during live migration.  (Since 8.1)
 #
 # @dirty-limit-ring-full-time: Estimated average dirty ring full time
 #     (in microseconds) for each dirty ring full round.  The value
@@ -381,7 +381,7 @@
 # Migration capabilities enumeration
 #
 # @xbzrle: Migration supports xbzrle (Xor Based Zero Run Length
-#     Encoding). This feature allows us to minimize migration traffic
+#     Encoding).  This feature allows us to minimize migration traffic
 #     for certain work loads, by sending compressed difference of the
 #     pages
 #
@@ -393,8 +393,8 @@
 #     efficiently.  This essentially saves 1MB of zeroes per block on
 #     the wire.  Enabling requires source and target VM to support
 #     this feature.  To enable it is sufficient to enable the
-#     capability on the source VM. The feature is disabled by default.
-#     (since 1.6)
+#     capability on the source VM.  The feature is disabled by
+#     default.  (since 1.6)
 #
 # @events: generate events for each migration state change (since 2.4)
 #
@@ -562,9 +562,9 @@
 # @zstd: use zstd compression method.
 #
 # @qpl: use qpl compression method.  Query Processing Library(qpl) is
-#       based on the deflate compression algorithm and use the Intel
-#       In-Memory Analytics Accelerator(IAA) accelerated compression
-#       and decompression.  (Since 9.1)
+#     based on the deflate compression algorithm and use the Intel
+#     In-Memory Analytics Accelerator(IAA) accelerated compression and
+#     decompression.  (Since 9.1)
 #
 # @uadk: use UADK library compression method.  (Since 9.1)
 #
@@ -790,13 +790,13 @@
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1.  (Since 5.0)
+#     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1.  (Since 5.0)
+#     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #     aliases for the purpose of dirty bitmap migration.  Such aliases
@@ -965,13 +965,13 @@
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1.  (Since 5.0)
+#     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1.  (Since 5.0)
+#     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #     aliases for the purpose of dirty bitmap migration.  Such aliases
@@ -1169,13 +1169,13 @@
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1.  (Since 5.0)
+#     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1.  (Since 5.0)
+#     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #     aliases for the purpose of dirty bitmap migration.  Such aliases
@@ -1201,7 +1201,7 @@
 #     Defaults to 1.  (Since 8.1)
 #
 # @mode: Migration mode.  See description in @MigMode.  Default is
-#        'normal'.  (Since 8.2)
+#     'normal'.  (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
@@ -1459,8 +1459,8 @@
 #
 # Cancel the current executing migration process.
 #
-# .. note:: This command succeeds even if there is no migration process
-#    running.
+# .. note:: This command succeeds even if there is no migration
+#    process running.
 #
 # Since: 0.14
 #
@@ -1604,7 +1604,7 @@
 #        should not be used.
 #
 #     4. The uri argument should have the Uniform Resource Identifier
-#        of default destination VM. This connection will be bound to
+#        of default destination VM.  This connection will be bound to
 #        default network.
 #
 #     5. For now, number of migration streams is restricted to one,
@@ -1650,7 +1650,6 @@
 #                                        "filename": "/tmp/migfile",
 #                                        "offset": "0x1000" } } ] } }
 #     <- { "return": {} }
-#
 ##
 { 'command': 'migrate',
   'data': {'*uri': 'str',
@@ -1671,7 +1670,8 @@
 #
 # @exit-on-error: Exit on incoming migration failure.  Default true.
 #     When set to false, the failure triggers a MIGRATION event, and
-#     error details could be retrieved with query-migrate.  (since 9.1)
+#     error details could be retrieved with query-migrate.
+#     (since 9.1)
 #
 # Since: 2.3
 #
@@ -1938,9 +1938,9 @@
 # @UNPLUG_PRIMARY:
 #
 # Emitted from source side of a migration when migration state is
-# WAIT_UNPLUG. Device was unplugged by guest operating system.  Device
-# resources in QEMU are kept on standby to be able to re-plug it in
-# case of migration failure.
+# WAIT_UNPLUG.  Device was unplugged by guest operating system.
+# Device resources in QEMU are kept on standby to be able to re-plug
+# it in case of migration failure.
 #
 # @device-id: QEMU device id of the unplugged device
 #
@@ -2084,16 +2084,16 @@
 #    This mode tracks page modification per each vCPU separately.  It
 #    requires that KVM accelerator property "dirty-ring-size" is set.
 #
-# @calc-time: time period for which dirty page rate is calculated.
-#     By default it is specified in seconds, but the unit can be set
+# @calc-time: time period for which dirty page rate is calculated.  By
+#     default it is specified in seconds, but the unit can be set
 #     explicitly with @calc-time-unit.  Note that larger @calc-time
 #     values will typically result in smaller dirty page rates because
-#     page dirtying is a one-time event.  Once some page is counted
-#     as dirty during @calc-time period, further writes to this page
-#     will not increase dirty page rate anymore.
+#     page dirtying is a one-time event.  Once some page is counted as
+#     dirty during @calc-time period, further writes to this page will
+#     not increase dirty page rate anymore.
 #
-# @calc-time-unit: time unit in which @calc-time is specified.
-#     By default it is seconds.  (Since 8.2)
+# @calc-time-unit: time unit in which @calc-time is specified.  By
+#     default it is seconds.  (Since 8.2)
 #
 # @sample-pages: number of sampled pages per each GiB of guest memory.
 #     Default value is 512.  For 4KiB guest pages this corresponds to
diff --git a/qapi/misc.json b/qapi/misc.json
index 4a6f3baeae..559b66f201 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -26,7 +26,7 @@
 # @skipauth: whether to skip authentication.  Only applies to "vnc"
 #     and "spice" protocols
 #
-# @tls: whether to perform TLS. Only applies to the "spice" protocol
+# @tls: whether to perform TLS.  Only applies to the "spice" protocol
 #
 # Since: 0.14
 #
@@ -104,8 +104,8 @@
 # Returns a list of information about each iothread.
 #
 # .. note:: This list excludes the QEMU main loop thread, which is not
-#    declared using the ``-object iothread`` command-line option.  It is
-#    always the main thread of the process.
+#    declared using the ``-object iothread`` command-line option.  It
+#    is always the main thread of the process.
 #
 # Returns: a list of @IOThreadInfo for each iothread
 #
@@ -141,8 +141,8 @@
 #    guest remains paused once migration finishes, as if the ``-S``
 #    option was passed on the command line.
 #
-#    In the "suspended" state, it will completely stop the VM and cause
-#    a transition to the "paused" state.  (Since 9.0)
+#    In the "suspended" state, it will completely stop the VM and
+#    cause a transition to the "paused" state.  (Since 9.0)
 #
 # .. qmp-example::
 #
@@ -158,15 +158,15 @@
 #
 # Since: 0.14
 #
-# .. note:: This command will succeed if the guest is currently running.
-#    It will also succeed if the guest is in the "inmigrate" state; in
-#    this case, the effect of the command is to make sure the guest
-#    starts once migration finishes, removing the effect of the ``-S``
-#    command line option if it was passed.
+# .. note:: This command will succeed if the guest is currently
+#    running.  It will also succeed if the guest is in the "inmigrate"
+#    state; in this case, the effect of the command is to make sure
+#    the guest starts once migration finishes, removing the effect of
+#    the ``-S`` command line option if it was passed.
 #
 #    If the VM was previously suspended, and not been reset or woken,
-#    this command will transition back to the "suspended" state.  (Since
-#    9.0)
+#    this command will transition back to the "suspended" state.
+#    (Since 9.0)
 #
 # .. qmp-example::
 #
@@ -227,8 +227,8 @@
 #
 #    Known limitations:
 #
-#    * This command is stateless, this means that commands that
-#      depend on state information (such as getfd) might not work.
+#    * This command is stateless, this means that commands that depend
+#      on state information (such as getfd) might not work.
 #
 #    * Commands that prompt the user for data don't currently work.
 #
@@ -341,7 +341,8 @@
 #
 # .. note:: The list of fd sets is shared by all monitor connections.
 #
-# .. note:: If @fdset-id is not specified, a new fd set will be created.
+# .. note:: If @fdset-id is not specified, a new fd set will be
+#    created.
 #
 # Since: 1.2
 #
diff --git a/qapi/net.json b/qapi/net.json
index 31b3417d65..87fc0d0b28 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -22,9 +22,9 @@
 #
 # Since: 0.14
 #
-# .. note:: Not all network adapters support setting link status.  This
-#    command will succeed even if the network adapter does not support
-#    link status notification.
+# .. note:: Not all network adapters support setting link status.
+#    This command will succeed even if the network adapter does not
+#    support link status notification.
 #
 # .. qmp-example::
 #
@@ -403,7 +403,7 @@
 # Connect a client to a netmap-enabled NIC or to a VALE switch port
 #
 # @ifname: Either the name of an existing network interface supported
-#     by netmap, or the name of a VALE port (created on the fly). A
+#     by netmap, or the name of a VALE port (created on the fly).  A
 #     VALE port name is in the form 'valeXXX:YYY', where XXX and YYY
 #     are non-negative integers.  XXX identifies a switch and YYY
 #     identifies a port of the switch.  VALE ports having the same XXX
@@ -535,13 +535,13 @@
 # interfaces that are in host mode and also with the host.
 #
 # @start-address: The starting IPv4 address to use for the interface.
-#     Must be in the private IP range (RFC 1918). Must be specified
+#     Must be in the private IP range (RFC 1918).  Must be specified
 #     along with @end-address and @subnet-mask.  This address is used
 #     as the gateway address.  The subsequent address up to and
 #     including end-address are placed in the DHCP pool.
 #
 # @end-address: The DHCP IPv4 range end address to use for the
-#     interface.  Must be in the private IP range (RFC 1918). Must be
+#     interface.  Must be in the private IP range (RFC 1918).  Must be
 #     specified along with @start-address and @subnet-mask.
 #
 # @subnet-mask: The IPv4 subnet mask to use on the interface.  Must be
@@ -556,7 +556,7 @@
 #     network vmnet interface should be added to.  If set, no DHCP
 #     service is provided for this interface and network communication
 #     is allowed only with other interfaces added to this network
-#     identified by the UUID. Requires at least macOS Big Sur 11.0.
+#     identified by the UUID.  Requires at least macOS Big Sur 11.0.
 #
 # Since: 7.1
 ##
@@ -575,20 +575,20 @@
 # vmnet (shared mode) network backend.
 #
 # Allows traffic originating from the vmnet interface to reach the
-# Internet through a network address translator (NAT). The vmnet
+# Internet through a network address translator (NAT).  The vmnet
 # interface can communicate with the host and with other shared mode
 # interfaces on the same subnet.  If no DHCP settings, subnet mask and
 # IPv6 prefix specified, the interface can communicate with any of
 # other interfaces in shared mode.
 #
 # @start-address: The starting IPv4 address to use for the interface.
-#     Must be in the private IP range (RFC 1918). Must be specified
+#     Must be in the private IP range (RFC 1918).  Must be specified
 #     along with @end-address and @subnet-mask.  This address is used
 #     as the gateway address.  The subsequent address up to and
 #     including end-address are placed in the DHCP pool.
 #
 # @end-address: The DHCP IPv4 range end address to use for the
-#     interface.  Must be in the private IP range (RFC 1918). Must be
+#     interface.  Must be in the private IP range (RFC 1918).  Must be
 #     specified along with @start-address and @subnet-mask.
 #
 # @subnet-mask: The IPv4 subnet mask to use on the interface.  Must be
@@ -703,12 +703,19 @@
 # Available netdev drivers.
 #
 # @l2tpv3: since 2.1
+#
 # @vhost-vdpa: since 5.1
+#
 # @vmnet-host: since 7.1
+#
 # @vmnet-shared: since 7.1
+#
 # @vmnet-bridged: since 7.1
+#
 # @stream: since 7.2
+#
 # @dgram: since 7.2
+#
 # @af-xdp: since 8.2
 #
 # Since: 2.7
diff --git a/qapi/pci.json b/qapi/pci.json
index ec28f1d9b4..78bee57b77 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -310,6 +310,5 @@
 #        }
 #
 # This example has been shortened as the real response is too long.
-#
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
diff --git a/qapi/qdev.json b/qapi/qdev.json
index e91ca0309d..53d147c7b4 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -59,8 +59,8 @@
 #        the 'docs/qdev-device-use.txt' file.
 #
 #     3. It's possible to list device properties by running QEMU with
-#        the ``-device DEVICE,help`` command-line argument, where DEVICE
-#        is the device's name.
+#        the ``-device DEVICE,help`` command-line argument, where
+#        DEVICE is the device's name.
 #
 # .. qmp-example::
 #
@@ -94,13 +94,13 @@
 #
 # .. note:: When this command completes, the device may not be removed
 #    from the guest.  Hot removal is an operation that requires guest
-#    cooperation.  This command merely requests that the guest begin the
-#    hot removal process.  Completion of the device removal process is
-#    signaled with a DEVICE_DELETED event.  Guest reset will
-#    automatically complete removal for all devices.  If a guest-side
-#    error in the hot removal process is detected, the device will not
-#    be removed and a DEVICE_UNPLUG_GUEST_ERROR event is sent.  Some
-#    errors cannot be detected.
+#    cooperation.  This command merely requests that the guest begin
+#    the hot removal process.  Completion of the device removal
+#    process is signaled with a DEVICE_DELETED event.  Guest reset
+#    will automatically complete removal for all devices.  If a
+#    guest-side error in the hot removal process is detected, the
+#    device will not be removed and a DEVICE_UNPLUG_GUEST_ERROR event
+#    is sent.  Some errors cannot be detected.
 #
 # Since: 0.14
 #
@@ -123,7 +123,7 @@
 #
 # Emitted whenever the device removal completion is acknowledged by
 # the guest.  At this point, it's safe to reuse the specified device
-# ID. Device removal can be initiated by the guest or by HMP/QMP
+# ID.  Device removal can be initiated by the guest or by HMP/QMP
 # commands.
 #
 # @device: the device's ID if it has one
diff --git a/qapi/qom.json b/qapi/qom.json
index fc035f126a..321ccd708a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -356,7 +356,7 @@
 #     filter list.  "head" means the filter is inserted at the head of
 #     the filter list, before any existing filters.  "tail" means the
 #     filter is inserted at the tail of the filter list, behind any
-#     existing filters (default). "id=<id>" means the filter is
+#     existing filters (default).  "id=<id>" means the filter is
 #     inserted before or behind the filter specified by <id>,
 #     depending on the @insert property.  (default: "tail")
 #
@@ -620,8 +620,8 @@
 # .. note:: prealloc=true and reserve=false cannot be set at the same
 #    time.  With reserve=true, the behavior depends on the operating
 #    system: for example, Linux will not reserve swap space for shared
-#    file mappings -- "not applicable". In contrast, reserve=false will
-#    bail out if it cannot be configured accordingly.
+#    file mappings -- "not applicable".  In contrast, reserve=false
+#    will bail out if it cannot be configured accordingly.
 #
 # Since: 2.1
 ##
@@ -646,9 +646,9 @@
 # @align: the base address alignment when QEMU mmap(2)s @mem-path.
 #     Some backend stores specified by @mem-path require an alignment
 #     different than the default one used by QEMU, e.g. the device DAX
-#     /dev/dax0.0 requires 2M alignment rather than 4K. In such cases,
-#     users can specify the required alignment via this option.  0
-#     selects a default alignment (currently the page size).
+#     /dev/dax0.0 requires 2M alignment rather than 4K.  In such
+#     cases, users can specify the required alignment via this option.
+#     0 selects a default alignment (currently the page size).
 #     (default: 0)
 #
 # @offset: the offset into the target file that the region starts at.
@@ -709,7 +709,7 @@
 #
 # @hugetlbsize: the hugetlb page size on systems that support multiple
 #     hugetlb page sizes (it must be a power of 2 value supported by
-#     the system). 0 selects a default page size.  This option is
+#     the system).  0 selects a default page size.  This option is
 #     ignored if @hugetlb is false.  (default: 0)
 #
 # @seal: if true, create a sealed-file, which will block further
@@ -930,17 +930,17 @@
 #
 # @handle: SEV firmware handle (default: 0)
 #
-# @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating the VM.
-#                  The newer KVM_SEV_INIT2 interface, from Linux >= 6.10, syncs
-#                  additional vCPU state when initializing the VMSA structures,
-#                  which will result in a different guest measurement. Set
-#                  this to 'on' to force compatibility with older QEMU or kernel
-#                  versions that rely on legacy KVM_SEV_INIT behavior. 'auto'
-#                  will behave identically to 'on', but will automatically
-#                  switch to using KVM_SEV_INIT2 if the user specifies any
-#                  additional options that require it. If set to 'off', QEMU
-#                  will require KVM_SEV_INIT2 unconditionally.
-#                  (default: off) (since 9.1)
+# @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating
+#    the VM.  The newer KVM_SEV_INIT2 interface, from Linux >= 6.10,
+#    syncs additional vCPU state when initializing the VMSA
+#    structures, which will result in a different guest measurement.
+#    Set this to 'on' to force compatibility with older QEMU or kernel
+#    versions that rely on legacy KVM_SEV_INIT behavior.  'auto' will
+#    behave identically to 'on', but will automatically switch to
+#    using KVM_SEV_INIT2 if the user specifies any additional options
+#    that require it.  If set to 'off', QEMU will require
+#    KVM_SEV_INIT2 unconditionally.
+#    (default: off) (since 9.1)
 #
 # Since: 2.12
 ##
@@ -992,7 +992,7 @@
 # @vcek-disabled: Guests are by default allowed to choose between VLEK
 #     (Versioned Loaded Endorsement Key) or VCEK (Versioned Chip
 #     Endorsement Key) when requesting attestation reports from
-#     firmware. Set this to true to disable the use of VCEK.
+#     firmware.  Set this to true to disable the use of VCEK.
 #     (default: false) (since: 9.1)
 #
 # Since: 9.1
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 2e63dcb3d6..6950ca9602 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -288,8 +288,8 @@
 #
 # @ttl-check: perform TTL check
 #
-# .. note:: Optional members may or may not appear in the group depending
-#    if they're relevant to the group type.
+# .. note:: Optional members may or may not appear in the group
+#    depending if they're relevant to the group type.
 #
 # Since: 2.4
 ##
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 287691ca0e..ce95cfa46b 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -527,20 +527,20 @@
 # Hyper-V specific guest panic information (HV crash MSRs)
 #
 # @arg1: for Windows, STOP code for the guest crash.  For Linux,
-#        an error code.
+#     an error code.
 #
 # @arg2: for Windows, first argument of the STOP.  For Linux, the
-#        guest OS ID, which has the kernel version in bits 16-47
-#        and 0x8100 in bits 48-63.
+#     guest OS ID, which has the kernel version in bits 16-47 and
+#     0x8100 in bits 48-63.
 #
 # @arg3: for Windows, second argument of the STOP.  For Linux, the
-#        program counter of the guest.
+#     program counter of the guest.
 #
 # @arg4: for Windows, third argument of the STOP.  For Linux, the
-#        RAX register (x86) or the stack pointer (aarch64) of the guest.
+#     RAX register (x86) or the stack pointer (aarch64) of the guest.
 #
 # @arg5: for Windows, fourth argument of the STOP.  For x86 Linux, the
-#        stack pointer of the guest.
+#     stack pointer of the guest.
 #
 # Since: 2.9
 ##
diff --git a/qapi/sockets.json b/qapi/sockets.json
index e76fdb9925..6a95023315 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -29,6 +29,7 @@
 # @InetSocketAddressBase:
 #
 # @host: host part of the address
+#
 # @port: port part of the address
 ##
 { 'struct': 'InetSocketAddressBase',
@@ -104,8 +105,8 @@
 #
 # @port: port
 #
-# .. note:: String types are used to allow for possible future hostname
-#    or service resolution support.
+# .. note:: String types are used to allow for possible future
+#    hostname or service resolution support.
 #
 # Since: 2.8
 ##
diff --git a/qapi/stats.json b/qapi/stats.json
index efbbe26244..8902ef94e0 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -117,10 +117,10 @@
 # information for that target.
 #
 # @target: the kind of objects to query.  Note that each possible
-#          target may enable additional filtering options
+#     target may enable additional filtering options
 #
-# @providers: which providers to request statistics from, and optionally
-#             which named values to return within each provider
+# @providers: which providers to request statistics from, and
+#     optionally which named values to return within each provider
 #
 # Since: 7.1
 ##
diff --git a/qapi/transaction.json b/qapi/transaction.json
index b0ae3437eb..021e383496 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -238,8 +238,8 @@
 #     - Any errors from commands in the transaction
 #
 # .. note:: The transaction aborts on the first failure.  Therefore,
-#    there will be information on only one failed operation returned in
-#    an error condition, and subsequent actions will not have been
+#    there will be information on only one failed operation returned
+#    in an error condition, and subsequent actions will not have been
 #    attempted.
 #
 # Since: 1.1
diff --git a/qapi/ui.json b/qapi/ui.json
index 5daca5168c..8c8464faac 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -48,8 +48,8 @@
 # @password: the new password
 #
 # @connected: How to handle existing clients when changing the
-#     password.  If nothing is specified, defaults to 'keep'. For VNC,
-#     only 'keep' is currently implemented.
+#     password.  If nothing is specified, defaults to 'keep'.  For
+#     VNC, only 'keep' is currently implemented.
 #
 # Since: 7.0
 ##
@@ -107,10 +107,11 @@
 #     - '+INT' where INT is the number of seconds from now (integer)
 #     - 'INT' where INT is the absolute time in seconds
 #
-# .. note:: Time is relative to the server and currently there is no way
-#    to coordinate server time with client time.  It is not recommended
-#    to use the absolute time version of the @time parameter unless
-#    you're sure you are on the same machine as the QEMU instance.
+# .. note:: Time is relative to the server and currently there is no
+#    way to coordinate server time with client time.  It is not
+#    recommended to use the absolute time version of the @time
+#    parameter unless you're sure you are on the same machine as the
+#    QEMU instance.
 #
 # Since: 7.0
 ##
@@ -624,7 +625,7 @@
 # @id: vnc server name.
 #
 # @server: A list of @VncBasincInfo describing all listening sockets.
-#     The list can be empty (in case the vnc server is disabled). It
+#     The list can be empty (in case the vnc server is disabled).  It
 #     also may have multiple entries: normal + websocket, possibly
 #     also ipv4 + ipv6 in the future.
 #
@@ -719,8 +720,8 @@
 #
 # @client: client information
 #
-# .. note:: This event is emitted before any authentication takes place,
-#    thus the authentication ID is not provided.
+# .. note:: This event is emitted before any authentication takes
+#    place, thus the authentication ID is not provided.
 #
 # Since: 0.13
 #
@@ -1266,7 +1267,7 @@
 # Since: 2.6
 #
 # .. note:: The consoles are visible in the qom tree, under
-#    ``/backend/console[$index]``. They have a device link and head
+#    ``/backend/console[$index]``.  They have a device link and head
 #    property, so it is possible to map which console belongs to which
 #    device and display.
 #
@@ -1416,11 +1417,11 @@
 #
 # @left-command-key: Enable/disable forwarding of left command key to
 #     guest.  Allows command-tab window switching on the host without
-#     sending this key to the guest when "off". Defaults to "on"
+#     sending this key to the guest when "off".  Defaults to "on"
 #
 # @full-grab: Capture all key presses, including system combos.  This
 #     requires accessibility permissions, since it performs a global
-#     grab on key events.  (default: off) See
+#     grab on key events.  (default: off)  See
 #     https://support.apple.com/en-in/guide/mac-help/mh32356/mac
 #
 # @swap-opt-cmd: Swap the Option and Command keys so that their key
@@ -1432,7 +1433,7 @@
 #     "off".  (Since 8.2)
 #
 # @zoom-interpolation: Apply interpolation to smooth output when
-#     zoom-to-fit is enabled. Defaults to "off".  (Since 9.0)
+#     zoom-to-fit is enabled.  Defaults to "off".  (Since 9.0)
 #
 # Since: 7.0
 ##
diff --git a/qapi/vfio.json b/qapi/vfio.json
index 40cbcde02e..eccca82068 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -15,16 +15,16 @@
 #
 # @running: The device is running.
 #
-# @stop-copy: The device is stopped and its internal state is available
-#     for reading.
+# @stop-copy: The device is stopped and its internal state is
+#     available for reading.
 #
 # @resuming: The device is stopped and its internal state is available
 #     for writing.
 #
 # @running-p2p: The device is running in the P2P quiescent state.
 #
-# @pre-copy: The device is running, tracking its internal state and its
-#     internal state is available for reading.
+# @pre-copy: The device is running, tracking its internal state and
+#     its internal state is available for reading.
 #
 # @pre-copy-p2p: The device is running in the P2P quiescent state,
 #     tracking its internal state and its internal state is available
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 26df8b3064..2529c2d8b2 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -568,9 +568,9 @@
 # .. note:: last_avail_idx will not be displayed in the case where the
 #    selected VirtIODevice has a running vhost device and the
 #    VirtIODevice VirtQueue index (queue) does not exist for the
-#    corresponding vhost device vhost_virtqueue.  Also, shadow_avail_idx
-#    will not be displayed in the case where the selected VirtIODevice
-#    has a running vhost device.
+#    corresponding vhost device vhost_virtqueue.  Also,
+#    shadow_avail_idx will not be displayed in the case where the
+#    selected VirtIODevice has a running vhost device.
 #
 # Since: 7.2
 #
-- 
2.45.0


