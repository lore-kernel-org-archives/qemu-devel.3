Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8DFC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaY-0003E6-JB; Fri, 22 Mar 2024 10:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaW-0003DZ-C7
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaT-0003an-At
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1U3IwoU0s3W1uzhTamoMDRybNBjwbPc7VsAKDIO2q4=;
 b=FYqD2ZofKy5kHC5o1l8SQFfWjVirpynOQcyRgcBT/8b95yrVhi9jaCr/JlHo9ERDYMFZ9Z
 t+DQnmLMD35/lEJtvdb82XbWqFHQeEzYHTHPUPeKjO28o64FN8IjOiY4tNpaDuL0IN1KbW
 Vhsga07SXNYCJJq0lG/2a1tH3BFpd1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-K1W1NmZtMPGxlvJW5d1K9g-1; Fri, 22 Mar 2024 10:09:32 -0400
X-MC-Unique: K1W1NmZtMPGxlvJW5d1K9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30BCA85A58C;
 Fri, 22 Mar 2024 14:09:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD92640C6CB3;
 Fri, 22 Mar 2024 14:09:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA99321E5D30; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 10/12] qapi: Refill doc comments to conform to current
 conventions
Date: Fri, 22 Mar 2024 15:09:08 +0100
Message-ID: <20240322140910.328840-11-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-1-armbru@redhat.com>
References: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For legibility, wrap text paragraphs so every line is at most 70
characters long.

To check the generated documentation does not change, I compared the
generated HTML before and after this commit with "wdiff -3".  Finds no
differences.  Comparing with diff is not useful, as the refilled
paragraphs are visible there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json     |  24 ++++-----
 qapi/block.json          |   4 +-
 qapi/cxl.json            |   4 +-
 qapi/dump.json           |  16 +++---
 qapi/ebpf.json           |  12 ++---
 qapi/machine-target.json |  22 +++++----
 qapi/machine.json        |  15 +++---
 qapi/migration.json      | 104 ++++++++++++++++++++-------------------
 qapi/net.json            |  27 +++++-----
 qapi/qom.json            |  34 ++++++-------
 qapi/run-state.json      |   4 +-
 qapi/virtio.json         |  12 +++--
 12 files changed, 142 insertions(+), 136 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 64668b080d..e6b392ffe7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1819,10 +1819,10 @@
 #     Care should be taken when specifying the string, to specify a
 #     valid filename or protocol.  (Since 2.1)
 #
-# @backing-mask-protocol: If true, replace any protocol mentioned in the
-#     'backing file format' with 'raw', rather than storing the protocol
-#     name as the backing format.  Can be used even when no image header
-#     will be updated (default false; since 9.0).
+# @backing-mask-protocol: If true, replace any protocol mentioned in
+#     the 'backing file format' with 'raw', rather than storing the
+#     protocol name as the backing format.  Can be used even when no
+#     image header will be updated (default false; since 9.0).
 #
 # @speed: the maximum speed, in bytes per second
 #
@@ -2825,10 +2825,10 @@
 #     Care should be taken when specifying the string, to specify a
 #     valid filename or protocol.  (Since 2.1)
 #
-# @backing-mask-protocol: If true, replace any protocol mentioned in the
-#     'backing file format' with 'raw', rather than storing the protocol
-#     name as the backing format.  Can be used even when no image header
-#     will be updated (default false; since 9.0).
+# @backing-mask-protocol: If true, replace any protocol mentioned in
+#     the 'backing file format' with 'raw', rather than storing the
+#     protocol name as the backing format.  Can be used even when no
+#     image header will be updated (default false; since 9.0).
 #
 # @speed: the maximum speed, in bytes per second
 #
@@ -3547,10 +3547,10 @@
 #     re-allocating them later.  Besides potential performance
 #     degradation, such fragmentation can lead to increased allocation
 #     of clusters past the end of the image file, resulting in image
-#     files whose file length can grow much larger than their guest disk
-#     size would suggest.  If image file length is of concern (e.g. when
-#     storing qcow2 images directly on block devices), you should
-#     consider enabling this option.  (since 8.1)
+#     files whose file length can grow much larger than their guest
+#     disk size would suggest.  If image file length is of concern
+#     (e.g. when storing qcow2 images directly on block devices), you
+#     should consider enabling this option.  (since 8.1)
 #
 # @overlap-check: which overlap checks to perform for writes to the
 #     image, defaults to 'cached' (since 2.2)
diff --git a/qapi/block.json b/qapi/block.json
index 2410145cd3..5de99fe09d 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -555,8 +555,8 @@
 #
 # Example:
 #
-#     Set new histogram only for write, other histograms will remain not
-#     changed (or not created):
+#     Set new histogram only for write, other histograms will remain
+#     not changed (or not created):
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 8cc4c72fa9..4281726dec 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -144,8 +144,8 @@
 # @cxl-inject-memory-module-event:
 #
 # Inject an event record for a Memory Module Event (CXL r3.0
-# 8.2.9.2.1.3).  This event includes a copy of the Device Health
-# info at the time of the event.
+# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
+# at the time of the event.
 #
 # @path: CXL type 3 device canonical QOM path
 #
diff --git a/qapi/dump.json b/qapi/dump.json
index 4c021dd53c..ef1f3b62fc 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -15,20 +15,20 @@
 #
 # @elf: elf format
 #
-# @kdump-zlib: makedumpfile flattened, kdump-compressed format with zlib
-#     compression
+# @kdump-zlib: makedumpfile flattened, kdump-compressed format with
+#     zlib compression
 #
 # @kdump-lzo: makedumpfile flattened, kdump-compressed format with lzo
 #     compression
 #
-# @kdump-snappy: makedumpfile flattened, kdump-compressed format with snappy
-#     compression
+# @kdump-snappy: makedumpfile flattened, kdump-compressed format with
+#     snappy compression
 #
-# @kdump-raw-zlib: raw assembled kdump-compressed format with zlib compression
-#     (since 8.2)
+# @kdump-raw-zlib: raw assembled kdump-compressed format with zlib
+#     compression (since 8.2)
 #
-# @kdump-raw-lzo: raw assembled kdump-compressed format with lzo compression
-#     (since 8.2)
+# @kdump-raw-lzo: raw assembled kdump-compressed format with lzo
+#     compression (since 8.2)
 #
 # @kdump-raw-snappy: raw assembled kdump-compressed format with snappy
 #     compression (since 8.2)
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index 61359e1c0f..e500b5a744 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -7,15 +7,13 @@
 ##
 # = eBPF Objects
 #
-# eBPF object is an ELF binary that contains the eBPF
-# program and eBPF map description(BTF). Overall, eBPF
-# object should contain the program and enough metadata
-# to create/load eBPF with libbpf. As the eBPF maps/program
-# should correspond to QEMU, the eBPF can't be used from
-# different QEMU build.
+# eBPF object is an ELF binary that contains the eBPF program and eBPF
+# map description(BTF). Overall, eBPF object should contain the
+# program and enough metadata to create/load eBPF with libbpf.  As the
+# eBPF maps/program should correspond to QEMU, the eBPF can't be used
+# from different QEMU build.
 #
 # Currently, there is a possible eBPF for receive-side scaling (RSS).
-#
 ##
 
 ##
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 519adf3220..03d7a185b9 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -394,9 +394,9 @@
 ##
 # @set-cpu-topology:
 #
-# Modify the topology by moving the CPU inside the topology tree,
-# or by changing a modifier attribute of a CPU.
-# Absent values will not be modified.
+# Modify the topology by moving the CPU inside the topology tree, or
+# by changing a modifier attribute of a CPU.  Absent values will not
+# be modified.
 #
 # @core-id: the vCPU ID to be moved
 #
@@ -408,7 +408,8 @@
 #
 # @entitlement: entitlement to set
 #
-# @dedicated: whether the provisioning of real to virtual CPU is dedicated
+# @dedicated: whether the provisioning of real to virtual CPU is
+#     dedicated
 #
 # Features:
 #
@@ -435,14 +436,15 @@
 # Emitted when the guest asks to change the polarization.
 #
 # The guest can tell the host (via the PTF instruction) whether the
-# CPUs should be provisioned using horizontal or vertical polarization.
+# CPUs should be provisioned using horizontal or vertical
+# polarization.
 #
-# On horizontal polarization the host is expected to provision all vCPUs
-# equally.
+# On horizontal polarization the host is expected to provision all
+# vCPUs equally.
 #
-# On vertical polarization the host can provision each vCPU differently.
-# The guest will get information on the details of the provisioning
-# the next time it uses the STSI(15) instruction.
+# On vertical polarization the host can provision each vCPU
+# differently.  The guest will get information on the details of the
+# provisioning the next time it uses the STSI(15) instruction.
 #
 # @polarization: polarization specified by the guest
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 0840c91e70..01be411fa7 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -925,8 +925,7 @@
 # @cluster-id: cluster number within the parent container the CPU
 #     belongs to (since 7.1)
 #
-# @core-id: core number within the parent container the CPU
-#     belongs to
+# @core-id: core number within the parent container the CPU belongs to
 #
 # @thread-id: thread number within the core the CPU  belongs to
 #
@@ -982,8 +981,8 @@
 #
 # Examples:
 #
-#     For pseries machine type started with -smp 2,cores=2,maxcpus=4 -cpu
-#     POWER8:
+#     For pseries machine type started with -smp 2,cores=2,maxcpus=4
+#     -cpu POWER8:
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1008,8 +1007,8 @@
 #          }
 #        ]}
 #
-#     For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2 -cpu
-#     qemu (Since: 2.11):
+#     For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2
+#     -cpu qemu (Since: 2.11):
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1152,8 +1151,8 @@
 ##
 # @query-hv-balloon-status-report:
 #
-# Returns the hv-balloon driver data contained in the last received "STATUS"
-# message from the guest.
+# Returns the hv-balloon driver data contained in the last received
+# "STATUS" message from the guest.
 #
 # Returns:
 #     @HvBalloonInfo
diff --git a/qapi/migration.json b/qapi/migration.json
index 9ce0f6249f..302855198d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -23,8 +23,8 @@
 #
 # @duplicate: number of duplicate (zero) pages (since 1.2)
 #
-# @skipped: number of skipped zero pages. Always zero, only provided for
-#     compatibility (since 1.5)
+# @skipped: number of skipped zero pages.  Always zero, only provided
+#     for compatibility (since 1.5)
 #
 # @normal: number of normal pages (since 1.2)
 #
@@ -501,8 +501,8 @@
 #
 # @background-snapshot: If enabled, the migration stream will be a
 #     snapshot of the VM exactly at the point when the migration
-#     procedure starts.  The VM RAM is saved with running VM. (since
-#     6.0)
+#     procedure starts.  The VM RAM is saved with running VM.
+#     (since 6.0)
 #
 # @zero-copy-send: Controls behavior on sending memory pages on
 #     migration.  When true, enables a zero-copy mechanism for sending
@@ -640,9 +640,9 @@
 #
 # @normal: the original form of migration. (since 8.2)
 #
-# @cpr-reboot: The migrate command stops the VM and saves state to
-#     the URI.  After quitting QEMU, the user resumes by running
-#     QEMU -incoming.
+# @cpr-reboot: The migrate command stops the VM and saves state to the
+#     URI.  After quitting QEMU, the user resumes by running QEMU
+#     -incoming.
 #
 #     This mode allows the user to quit QEMU, optionally update and
 #     reboot the OS, and restart QEMU.  If the user reboots, the URI
@@ -652,8 +652,8 @@
 #     does not block the migration, but the user must not modify the
 #     contents of guest block devices between the quit and restart.
 #
-#     This mode supports VFIO devices provided the user first puts
-#     the guest in the suspended runstate, such as by issuing
+#     This mode supports VFIO devices provided the user first puts the
+#     guest in the suspended runstate, such as by issuing
 #     guest-suspend-ram to the QEMU guest agent.
 #
 #     Best performance is achieved when the memory backend is shared
@@ -678,11 +678,10 @@
 # @legacy: Perform zero page checking in main migration thread.
 #
 # @multifd: Perform zero page checking in multifd sender thread if
-#     multifd migration is enabled, else in the main migration
-#     thread as for @legacy.
+#     multifd migration is enabled, else in the main migration thread
+#     as for @legacy.
 #
 # Since: 9.0
-#
 ##
 { 'enum': 'ZeroPageDetection',
   'data': [ 'none', 'legacy', 'multifd' ] }
@@ -831,13 +830,14 @@
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations when
-#     making decisions to switchover.  By default, this value is zero,
-#     which means QEMU will estimate the bandwidth automatically.  This can
-#     be set when the estimated value is not accurate, while the user is
-#     able to guarantee such bandwidth is available when switching over.
-#     When specified correctly, this can make the switchover decision much
-#     more accurate.  (Since 8.2)
+#     limit the bandwidth during switchover, but only for calculations
+#     when making decisions to switchover.  By default, this value is
+#     zero, which means QEMU will estimate the bandwidth
+#     automatically.  This can be set when the estimated value is not
+#     accurate, while the user is able to guarantee such bandwidth is
+#     available when switching over.  When specified correctly, this
+#     can make the switchover decision much more accurate.
+#     (Since 8.2)
 #
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
@@ -899,14 +899,14 @@
 #     to their node name otherwise.  (Since 5.2)
 #
 # @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
-#     limit during live migration.  Should be in the range 1 to 1000ms.
-#     Defaults to 1000ms.  (Since 8.1)
+#     limit during live migration.  Should be in the range 1 to
+#     1000ms.  Defaults to 1000ms.  (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
-# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
-#        (Since 8.2)
+# @mode: Migration mode.  See description in @MigMode.  Default is
+#     'normal'.  (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
@@ -919,8 +919,8 @@
 #     @compress-threads, @decompress-threads and @compress-wait-thread
 #     are deprecated because @compression is deprecated.
 #
-# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#     are experimental.
+# @unstable: Members @x-checkpoint-delay and
+#     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
 ##
@@ -1028,13 +1028,14 @@
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations when
-#     making decisions to switchover.  By default, this value is zero,
-#     which means QEMU will estimate the bandwidth automatically.  This can
-#     be set when the estimated value is not accurate, while the user is
-#     able to guarantee such bandwidth is available when switching over.
-#     When specified correctly, this can make the switchover decision much
-#     more accurate.  (Since 8.2)
+#     limit the bandwidth during switchover, but only for calculations
+#     when making decisions to switchover.  By default, this value is
+#     zero, which means QEMU will estimate the bandwidth
+#     automatically.  This can be set when the estimated value is not
+#     accurate, while the user is able to guarantee such bandwidth is
+#     available when switching over.  When specified correctly, this
+#     can make the switchover decision much more accurate.
+#     (Since 8.2)
 #
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
@@ -1096,14 +1097,14 @@
 #     to their node name otherwise.  (Since 5.2)
 #
 # @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
-#     limit during live migration.  Should be in the range 1 to 1000ms.
-#     Defaults to 1000ms.  (Since 8.1)
+#     limit during live migration.  Should be in the range 1 to
+#     1000ms.  Defaults to 1000ms.  (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
-# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
-#        (Since 8.2)
+# @mode: Migration mode.  See description in @MigMode.  Default is
+#     'normal'.  (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
@@ -1116,8 +1117,8 @@
 #     @compress-threads, @decompress-threads and @compress-wait-thread
 #     are deprecated because @compression is deprecated.
 #
-# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#     are experimental.
+# @unstable: Members @x-checkpoint-delay and
+#     @x-vcpu-dirty-limit-period are experimental.
 #
 # TODO: either fuse back into MigrationParameters, or make
 #     MigrationParameters members mandatory
@@ -1261,13 +1262,14 @@
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations when
-#     making decisions to switchover.  By default, this value is zero,
-#     which means QEMU will estimate the bandwidth automatically.  This can
-#     be set when the estimated value is not accurate, while the user is
-#     able to guarantee such bandwidth is available when switching over.
-#     When specified correctly, this can make the switchover decision much
-#     more accurate.  (Since 8.2)
+#     limit the bandwidth during switchover, but only for calculations
+#     when making decisions to switchover.  By default, this value is
+#     zero, which means QEMU will estimate the bandwidth
+#     automatically.  This can be set when the estimated value is not
+#     accurate, while the user is able to guarantee such bandwidth is
+#     available when switching over.  When specified correctly, this
+#     can make the switchover decision much more accurate.
+#     (Since 8.2)
 #
 # @downtime-limit: set maximum tolerated downtime for migration.
 #     maximum downtime in milliseconds (Since 2.8)
@@ -1329,14 +1331,14 @@
 #     to their node name otherwise.  (Since 5.2)
 #
 # @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
-#     limit during live migration.  Should be in the range 1 to 1000ms.
-#     Defaults to 1000ms.  (Since 8.1)
+#     limit during live migration.  Should be in the range 1 to
+#     1000ms.  Defaults to 1000ms.  (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
 #     Defaults to 1.  (Since 8.1)
 #
-# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
-#        (Since 8.2)
+# @mode: Migration mode.  See description in @MigMode.  Default is
+#        'normal'.  (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
 #     See description in @ZeroPageDetection.  Default is 'multifd'.
@@ -1349,8 +1351,8 @@
 #     @compress-threads, @decompress-threads and @compress-wait-thread
 #     are deprecated because @compression is deprecated.
 #
-# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#     are experimental.
+# @unstable: Members @x-checkpoint-delay and
+#     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
 ##
diff --git a/qapi/net.json b/qapi/net.json
index 417b61a321..0f5a259475 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -425,8 +425,8 @@
 #
 # @skb: generic mode, no driver support necessary
 #
-# @native: DRV mode, program is attached to a driver, packets are passed to
-#     the socket without allocation of skb.
+# @native: DRV mode, program is attached to a driver, packets are
+#     passed to the socket without allocation of skb.
 #
 # Since: 8.2
 ##
@@ -441,23 +441,26 @@
 #
 # @ifname: The name of an existing network interface.
 #
-# @mode: Attach mode for a default XDP program.  If not specified, then
-#     'native' will be tried first, then 'skb'.
+# @mode: Attach mode for a default XDP program.  If not specified,
+#     then 'native' will be tried first, then 'skb'.
 #
 # @force-copy: Force XDP copy mode even if device supports zero-copy.
 #     (default: false)
 #
-# @queues: number of queues to be used for multiqueue interfaces (default: 1).
+# @queues: number of queues to be used for multiqueue interfaces
+#     (default: 1).
 #
-# @start-queue: Use @queues starting from this queue number (default: 0).
+# @start-queue: Use @queues starting from this queue number
+#     (default: 0).
 #
-# @inhibit: Don't load a default XDP program, use one already loaded to
-#     the interface (default: false).  Requires @sock-fds.
+# @inhibit: Don't load a default XDP program, use one already loaded
+#     to the interface (default: false).  Requires @sock-fds.
 #
-# @sock-fds: A colon (:) separated list of file descriptors for already open
-#     but not bound AF_XDP sockets in the queue order.  One fd per queue.
-#     These descriptors should already be added into XDP socket map for
-#     corresponding queues.  Requires @inhibit.
+# @sock-fds: A colon (:) separated list of file descriptors for
+#     already open but not bound AF_XDP sockets in the queue order.
+#     One fd per queue.  These descriptors should already be added
+#     into XDP socket map for corresponding queues.  Requires
+#     @inhibit.
 #
 # Since: 8.2
 ##
diff --git a/qapi/qom.json b/qapi/qom.json
index baae3a183f..e263e29a26 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -668,19 +668,20 @@
 # @readonly: if true, the backing file is opened read-only; if false,
 #     it is opened read-write.  (default: false)
 #
-# @rom: whether to create Read Only Memory (ROM) that cannot be modified
-#       by the VM.  Any write attempts to such ROM will be denied.  Most
-#       use cases want writable RAM instead of ROM.  However, selected use
-#       cases, like R/O NVDIMMs, can benefit from ROM.  If set to 'on',
-#       create ROM; if set to 'off', create writable RAM;  if set to
-#       'auto', the value of the @readonly property is used.  This
-#       property is primarily helpful when we want to have proper RAM in
-#       configurations that would traditionally create ROM before this
-#       property was introduced: VM templating, where we want to open a
-#       file readonly (@readonly set to true) and mark the memory to be
-#       private for QEMU (@share set to false).  For this use case, we need
-#       writable RAM instead of ROM, and want to set this property to 'off'.
-#       (default: auto, since 8.2)
+# @rom: whether to create Read Only Memory (ROM) that cannot be
+#     modified by the VM.  Any write attempts to such ROM will be
+#     denied.  Most use cases want writable RAM instead of ROM.
+#     However, selected use cases, like R/O NVDIMMs, can benefit from
+#     ROM.  If set to 'on', create ROM; if set to 'off', create
+#     writable RAM; if set to 'auto', the value of the @readonly
+#     property is used.  This property is primarily helpful when we
+#     want to have proper RAM in configurations that would
+#     traditionally create ROM before this property was introduced: VM
+#     templating, where we want to open a file readonly (@readonly set
+#     to true) and mark the memory to be private for QEMU (@share set
+#     to false).  For this use case, we need writable RAM instead of
+#     ROM, and want to set this property to 'off'.  (default: auto,
+#     since 8.2)
 #
 # Since: 2.1
 ##
@@ -801,10 +802,9 @@
 #
 # @fd: file descriptor name previously passed via 'getfd' command,
 #     which represents a pre-opened /dev/iommu.  This allows the
-#     iommufd object to be shared accross several subsystems
-#     (VFIO, VDPA, ...), and the file descriptor to be shared
-#     with other process, e.g. DPDK.  (default: QEMU opens
-#     /dev/iommu by itself)
+#     iommufd object to be shared accross several subsystems (VFIO,
+#     VDPA, ...), and the file descriptor to be shared with other
+#     process, e.g. DPDK.  (default: QEMU opens /dev/iommu by itself)
 #
 # Since: 9.0
 ##
diff --git a/qapi/run-state.json b/qapi/run-state.json
index ae084e13a0..bc1c3a9217 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -144,8 +144,8 @@
 #     hardware-specific action) rather than a host request (such as
 #     sending qemu a SIGINT). (since 2.10)
 #
-# @reason: The @ShutdownCause which resulted in the SHUTDOWN. (since
-#     4.0)
+# @reason: The @ShutdownCause which resulted in the SHUTDOWN.
+#     (since 4.0)
 #
 # Note: If the command-line option "-no-shutdown" has been specified,
 #     qemu will not exit, and a STOP event will eventually follow the
diff --git a/qapi/virtio.json b/qapi/virtio.json
index b0cd41be72..74fc27c702 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -938,10 +938,11 @@
 #
 # @iothread: the id of IOThread object
 #
-# @vqs: an optional array of virtqueue indices that will be handled by this
-#     IOThread.  When absent, virtqueues are assigned round-robin across all
-#     IOThreadVirtQueueMappings provided.  Either all IOThreadVirtQueueMappings
-#     must have @vqs or none of them must have it.
+# @vqs: an optional array of virtqueue indices that will be handled by
+#     this IOThread.  When absent, virtqueues are assigned round-robin
+#     across all IOThreadVirtQueueMappings provided.  Either all
+#     IOThreadVirtQueueMappings must have @vqs or none of them must
+#     have it.
 #
 # Since: 9.0
 ##
@@ -952,7 +953,8 @@
 ##
 # @DummyVirtioForceArrays:
 #
-# Not used by QMP; hack to let us use IOThreadVirtQueueMappingList internally
+# Not used by QMP; hack to let us use IOThreadVirtQueueMappingList
+# internally
 #
 # Since: 9.0
 ##
-- 
2.44.0


