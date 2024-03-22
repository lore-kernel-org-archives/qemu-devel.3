Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ED4C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaO-00038P-JN; Fri, 22 Mar 2024 10:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaM-00034K-Vf
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaH-0003Z6-KR
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTzixnSg4ZaiKpF+84vxXI1F1mLXm62KWGPtZIhyme0=;
 b=i/Gc2OYJNLyFusgP9KmKkPK84/A2QBV9AcGaGzUo25HMbRC0riptVo/25VWun4u8qINrZ4
 atCkd0u2wFkg1/pno8KbV0S18YCB9C9W2bwa9iKQKm3PXetK7JXc30/uNeaIr8lStyFSD6
 ++rGCJY6ydJpUDuTnGkfZy3fyOftK94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-mc832Ts5M1qXod_7xk_Grg-1; Fri, 22 Mar 2024 10:09:21 -0400
X-MC-Unique: mc832Ts5M1qXod_7xk_Grg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31D9A186E247;
 Fri, 22 Mar 2024 14:09:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD0A72022C23;
 Fri, 22 Mar 2024 14:09:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDABB21E5D31; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 11/12] qapi: Correct documentation indentation and whitespace
Date: Fri, 22 Mar 2024 15:09:09 +0100
Message-ID: <20240322140910.328840-12-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-1-armbru@redhat.com>
References: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 qapi/block-core.json | 20 ++++++++++----------
 qapi/crypto.json     | 12 ++++++------
 qapi/dump.json       |  2 +-
 qapi/machine.json    |  3 +--
 qapi/migration.json  | 38 ++++++++++++++++++--------------------
 qapi/qom.json        |  4 ++--
 qapi/run-state.json  |  9 ++++-----
 qapi/sockets.json    |  3 +--
 qapi/ui.json         | 14 +++++++-------
 9 files changed, 50 insertions(+), 55 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6b392ffe7..7d3fe59f6c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2593,27 +2593,27 @@
 #
 # @bps_max_length: maximum length of the @bps_max burst period, in
 #     seconds.  It must only be set if @bps_max is set as well.
-#     Defaults to 1. (Since 2.6)
+#     Defaults to 1.  (Since 2.6)
 #
 # @bps_rd_max_length: maximum length of the @bps_rd_max burst period,
 #     in seconds.  It must only be set if @bps_rd_max is set as well.
-#     Defaults to 1. (Since 2.6)
+#     Defaults to 1.  (Since 2.6)
 #
 # @bps_wr_max_length: maximum length of the @bps_wr_max burst period,
 #     in seconds.  It must only be set if @bps_wr_max is set as well.
-#     Defaults to 1. (Since 2.6)
+#     Defaults to 1.  (Since 2.6)
 #
 # @iops_max_length: maximum length of the @iops burst period, in
 #     seconds.  It must only be set if @iops_max is set as well.
-#     Defaults to 1. (Since 2.6)
+#     Defaults to 1.  (Since 2.6)
 #
 # @iops_rd_max_length: maximum length of the @iops_rd_max burst
 #     period, in seconds.  It must only be set if @iops_rd_max is set
-#     as well.  Defaults to 1. (Since 2.6)
+#     as well.  Defaults to 1.  (Since 2.6)
 #
 # @iops_wr_max_length: maximum length of the @iops_wr_max burst
 #     period, in seconds.  It must only be set if @iops_wr_max is set
-#     as well.  Defaults to 1. (Since 2.6)
+#     as well.  Defaults to 1.  (Since 2.6)
 #
 # @iops_size: an I/O size in bytes (Since 1.7)
 #
@@ -3354,7 +3354,7 @@
 #     decryption key (since 2.6). Mandatory except when doing a
 #     metadata-only probe of the image.
 #
-# @header: block device holding a detached LUKS header. (since 9.0)
+# @header: block device holding a detached LUKS header.  (since 9.0)
 #
 # Since: 2.9
 ##
@@ -4619,7 +4619,7 @@
 #     seconds for copy-before-write operation.  When a timeout occurs,
 #     the respective copy-before-write operation will fail, and the
 #     @on-cbw-error parameter will decide how this failure is handled.
-#     Default 0. (Since 7.1)
+#     Default 0.  (Since 7.1)
 #
 # Since: 6.2
 ##
@@ -4953,9 +4953,9 @@
 # Driver specific image creation options for LUKS.
 #
 # @file: Node to create the image format on, mandatory except when
-#        'preallocation' is not requested
+#     'preallocation' is not requested
 #
-# @header: Block device holding a detached LUKS header. (since 9.0)
+# @header: Block device holding a detached LUKS header.  (since 9.0)
 #
 # @size: Size of the virtual disk in bytes
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 931c88e688..e102be337b 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -48,15 +48,15 @@
 #
 # @sha1: SHA-1. Should not be used in any new code, legacy compat only
 #
-# @sha224: SHA-224. (since 2.7)
+# @sha224: SHA-224.  (since 2.7)
 #
 # @sha256: SHA-256. Current recommended strong hash.
 #
-# @sha384: SHA-384. (since 2.7)
+# @sha384: SHA-384.  (since 2.7)
 #
-# @sha512: SHA-512. (since 2.7)
+# @sha512: SHA-512.  (since 2.7)
 #
-# @ripemd160: RIPEMD-160. (since 2.7)
+# @ripemd160: RIPEMD-160.  (since 2.7)
 #
 # Since: 2.6
 ##
@@ -224,9 +224,9 @@
 #     'sha256'
 #
 # @iter-time: number of milliseconds to spend in PBKDF passphrase
-#     processing.  Currently defaults to 2000. (since 2.8)
+#     processing.  Currently defaults to 2000.  (since 2.8)
 #
-# @detached-header: create a detached LUKS header. (since 9.0)
+# @detached-header: create a detached LUKS header.  (since 9.0)
 #
 # Since: 2.6
 ##
diff --git a/qapi/dump.json b/qapi/dump.json
index ef1f3b62fc..2fa9504d86 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -77,7 +77,7 @@
 #
 # @detach: if true, QMP will return immediately rather than waiting
 #     for the dump to finish.  The user can track progress using
-#     "query-dump". (since 2.6).
+#     "query-dump".  (since 2.6).
 #
 # @begin: if specified, the starting physical address.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 01be411fa7..e8b60641f2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -920,7 +920,7 @@
 # @socket-id: socket number within parent container the CPU belongs to
 #
 # @die-id: die number within the parent container the CPU belongs to
-#    (since 4.1)
+#     (since 4.1)
 #
 # @cluster-id: cluster number within the parent container the CPU
 #     belongs to (since 7.1)
@@ -1190,7 +1190,6 @@
 #     <- { "event": "HV_BALLOON_STATUS_REPORT",
 #          "data": { "committed": 816640000, "available": 3333054464 },
 #          "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
-#
 ##
 { 'event': 'HV_BALLOON_STATUS_REPORT',
   'data': 'HvBalloonInfo' }
diff --git a/qapi/migration.json b/qapi/migration.json
index 302855198d..992ca32357 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -68,7 +68,6 @@
 # @deprecated: Member @skipped is always zero since 1.5.3
 #
 # Since: 0.14
-#
 ##
 { 'struct': 'MigrationStats',
   'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
@@ -230,7 +229,7 @@
 #     throttled during auto-converge.  This is only present when
 #     auto-converge has started throttling guest cpus.  (Since 2.7)
 #
-# @error-desc: the human readable error description string. Clients
+# @error-desc: the human readable error description string.  Clients
 #     should not attempt to parse the error strings.  (Since 2.7)
 #
 # @postcopy-blocktime: total time when all vCPU were blocked during
@@ -638,7 +637,7 @@
 ##
 # @MigMode:
 #
-# @normal: the original form of migration. (since 8.2)
+# @normal: the original form of migration.  (since 8.2)
 #
 # @cpr-reboot: The migrate command stops the VM and saves state to the
 #     URI.  After quitting QEMU, the user resumes by running QEMU
@@ -781,15 +780,15 @@
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50. (Since 5.0)
+#     percentage.  The default value is 50.  (Since 5.0)
 #
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
 #     throttled when migration auto-converge is activated.  The
-#     default value is 20. (Since 2.7)
+#     default value is 20.  (Since 2.7)
 #
 # @cpu-throttle-increment: throttle percentage increase each time
 #     auto-converge detects that migration is not making progress.
-#     The default value is 10. (Since 2.7)
+#     The default value is 10.  (Since 2.7)
 #
 # @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
 #     the tail stage of throttling, the Guest is very sensitive to CPU
@@ -874,13 +873,13 @@
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
+#     more CPU. Defaults to 1.  (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
+#     more CPU. Defaults to 1.  (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #     aliases for the purpose of dirty bitmap migration.  Such aliases
@@ -976,15 +975,15 @@
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50. (Since 5.0)
+#     percentage.  The default value is 50.  (Since 5.0)
 #
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
 #     throttled when migration auto-converge is activated.  The
-#     default value is 20. (Since 2.7)
+#     default value is 20.  (Since 2.7)
 #
 # @cpu-throttle-increment: throttle percentage increase each time
 #     auto-converge detects that migration is not making progress.
-#     The default value is 10. (Since 2.7)
+#     The default value is 10.  (Since 2.7)
 #
 # @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
 #     the tail stage of throttling, the Guest is very sensitive to CPU
@@ -1072,13 +1071,13 @@
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
+#     more CPU. Defaults to 1.  (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
+#     more CPU. Defaults to 1.  (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #     aliases for the purpose of dirty bitmap migration.  Such aliases
@@ -1212,7 +1211,7 @@
 #
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
 #     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50. (Since 5.0)
+#     percentage.  The default value is 50.  (Since 5.0)
 #
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
 #     throttled when migration auto-converge is activated.  (Since
@@ -1306,13 +1305,13 @@
 #     migration, the compression level is an integer between 0 and 9,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
+#     more CPU. Defaults to 1.  (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
 #     where 0 means no compression, 1 means the best compression
 #     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
+#     more CPU. Defaults to 1.  (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #     aliases for the purpose of dirty bitmap migration.  Such aliases
@@ -1739,7 +1738,7 @@
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
-# @resume: resume one paused migration, default "off". (since 3.0)
+# @resume: resume one paused migration, default "off".  (since 3.0)
 #
 # Features:
 #
@@ -2165,7 +2164,6 @@
 # @millisecond: value is in milliseconds
 #
 # Since: 8.2
-#
 ##
 { 'enum': 'TimeUnit',
   'data': ['second', 'millisecond'] }
@@ -2247,7 +2245,7 @@
 #     will not increase dirty page rate anymore.
 #
 # @calc-time-unit: time unit in which @calc-time is specified.
-#     By default it is seconds. (Since 8.2)
+#     By default it is seconds.  (Since 8.2)
 #
 # @sample-pages: number of sampled pages per each GiB of guest memory.
 #     Default value is 512.  For 4KiB guest pages this corresponds to
@@ -2284,7 +2282,7 @@
 # Query results of the most recent invocation of @calc-dirty-rate.
 #
 # @calc-time-unit: time unit in which to report calculation time.
-#     By default it is reported in seconds. (Since 8.2)
+#     By default it is reported in seconds.  (Since 8.2)
 #
 # Since: 5.2
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index e263e29a26..8d4ca8ed92 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -649,14 +649,14 @@
 #
 # @offset: the offset into the target file that the region starts at.
 #     You can use this option to back multiple regions with a single
-#     file. Must be a multiple of the page size.
+#     file.  Must be a multiple of the page size.
 #     (default: 0) (since 8.1)
 #
 # @discard-data: if true, the file contents can be destroyed when QEMU
 #     exits, to avoid unnecessarily flushing data to the backing file.
 #     Note that @discard-data is only an optimization, and QEMU might
 #     not discard file contents if it aborts unexpectedly or is
-#     terminated using SIGKILL. (default: false)
+#     terminated using SIGKILL.  (default: false)
 #
 # @mem-path: the path to either a shared memory or huge page
 #     filesystem mount
diff --git a/qapi/run-state.json b/qapi/run-state.json
index bc1c3a9217..5f07444b84 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -91,7 +91,7 @@
 #
 # @snapshot-load: A snapshot is being loaded by the record & replay
 #     subsystem.  This value is used only within QEMU.  It doesn't
-#     occur in QMP. (since 7.2)
+#     occur in QMP.  (since 7.2)
 ##
 { 'enum': 'ShutdownCause',
   # Beware, shutdown_caused_by_guest() depends on enumeration order
@@ -109,7 +109,6 @@
 # @status: the virtual machine @RunState
 #
 # Since: 0.14
-#
 ##
 { 'struct': 'StatusInfo',
   'data': {'running': 'bool',
@@ -142,7 +141,7 @@
 # @guest: If true, the shutdown was triggered by a guest request (such
 #     as a guest-initiated ACPI shutdown request or other
 #     hardware-specific action) rather than a host request (such as
-#     sending qemu a SIGINT). (since 2.10)
+#     sending qemu a SIGINT).  (since 2.10)
 #
 # @reason: The @ShutdownCause which resulted in the SHUTDOWN.
 #     (since 4.0)
@@ -184,9 +183,9 @@
 # @guest: If true, the reset was triggered by a guest request (such as
 #     a guest-initiated ACPI reboot request or other hardware-specific
 #     action) rather than a host request (such as the QMP command
-#     system_reset). (since 2.10)
+#     system_reset).  (since 2.10)
 #
-# @reason: The @ShutdownCause of the RESET. (since 4.0)
+# @reason: The @ShutdownCause of the RESET.  (since 4.0)
 #
 # Since: 0.12
 #
diff --git a/qapi/sockets.json b/qapi/sockets.json
index ef777928e7..aa97c89768 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -58,7 +58,7 @@
 # @keep-alive: enable keep-alive when connecting to this socket.  Not
 #     supported for passive sockets.  (Since 4.2)
 #
-# @mptcp: enable multi-path TCP. (Since 6.1)
+# @mptcp: enable multi-path TCP.  (Since 6.1)
 #
 # Since: 1.3
 ##
@@ -125,7 +125,6 @@
 #     Decimal file descriptors are permitted at startup or other
 #     contexts where no monitor context is active.
 #
-#
 # Since: 1.2
 ##
 { 'struct': 'FdSocketAddress',
diff --git a/qapi/ui.json b/qapi/ui.json
index e71cd2f50b..9721c1e5af 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -181,7 +181,7 @@
 # @head: head to use in case the device supports multiple heads.  If
 #     this parameter is missing, head #0 will be used.  Also note that
 #     the head can only be specified in conjunction with the device
-#     ID. (Since 2.12)
+#     ID.  (Since 2.12)
 #
 # @format: image format for screendump.  (default: ppm) (Since 7.1)
 #
@@ -303,7 +303,7 @@
 #
 # @auth: the current authentication type used by the server
 #
-#     - 'none'  if no authentication is being used
+#     - 'none' if no authentication is being used
 #     - 'spice' uses SASL or direct TLS authentication, depending on
 #       command line options
 #
@@ -1314,7 +1314,7 @@
 #     display device can notify the guest on window resizes
 #     (virtio-gpu) this will default to "on", assuming the guest will
 #     resize the display to match the window size then.  Otherwise it
-#     defaults to "off". (Since 3.1)
+#     defaults to "off".  (Since 3.1)
 #
 # @show-tabs: Display the tab bar for switching between the various
 #     graphical interfaces (e.g. VGA and virtual console character
@@ -1417,12 +1417,12 @@
 #     codes match their position on non-Mac keyboards and you can use
 #     Meta/Super and Alt where you expect them.  (default: off)
 #
-# @zoom-to-fit: Zoom guest display to fit into the host window. When
-#     turned off the host window will be resized instead. Defaults to
-#     "off". (Since 8.2)
+# @zoom-to-fit: Zoom guest display to fit into the host window.  When
+#     turned off the host window will be resized instead.  Defaults to
+#     "off".  (Since 8.2)
 #
 # @zoom-interpolation: Apply interpolation to smooth output when
-#     zoom-to-fit is enabled. Defaults to "off". (Since 9.0)
+#     zoom-to-fit is enabled. Defaults to "off".  (Since 9.0)
 #
 # Since: 7.0
 ##
-- 
2.44.0


