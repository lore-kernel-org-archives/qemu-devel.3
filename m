Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12275C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKmI-0005Z4-DP; Mon, 14 Jul 2025 11:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUd-0000Jz-K6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUT-0003bY-Og
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXw5Cyw4KWD07VCe3w5QtNyIiSVLgGwNEI/uTWKsrp4=;
 b=UJy0cZKMh0/11OgivEN2fYZ8v9xZE7dEh04zp943QQApCqoOMcScgnUEPQulQwuFhuXCR6
 ixAevdkzCXmP0GzcUFqkChHfC0yqdlW2L9wh5CzJF453Q9Te+GP4Lyi0DHCBD3X4TcOhA1
 lQQNhLkwvexeIQv0pVGkzh0VH/1POEk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-QzXPpoVjMRmG-DCNRMUZ4g-1; Mon,
 14 Jul 2025 09:45:06 -0400
X-MC-Unique: QzXPpoVjMRmG-DCNRMUZ4g-1
X-Mimecast-MFC-AGG-ID: QzXPpoVjMRmG-DCNRMUZ4g_1752500705
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98EEA1809C88
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E26A1800285
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E369621E677A; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 11/32] qapi: rephrase return docs to avoid type name
Date: Mon, 14 Jul 2025 15:44:37 +0200
Message-ID: <20250714134458.2991097-12-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Snow <jsnow@redhat.com>

"Returns: <description>" is rendered like "Return: <Type> –
<description>".  Mentioning the type in the description again is
commonly redundant.  Rephrase such descriptions not to.

Well, I tried. Maybe not very hard. Sorry!

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711051045.51110-5-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
[Commit message amended to explain why]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json   | 6 +++---
 qapi/block-export.json | 2 +-
 qapi/block.json        | 2 +-
 qapi/control.json      | 5 ++---
 qapi/dump.json         | 5 ++---
 qapi/introspect.json   | 6 +++---
 qapi/job.json          | 2 +-
 qapi/misc-i386.json    | 2 +-
 qapi/misc.json         | 5 ++---
 qapi/net.json          | 2 +-
 qapi/pci.json          | 2 +-
 qapi/qdev.json         | 3 +--
 qapi/qom.json          | 8 +++-----
 qapi/stats.json        | 2 +-
 qapi/trace.json        | 2 +-
 qapi/ui.json           | 2 +-
 qapi/virtio.json       | 6 +++---
 17 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 01bf41b8b0..848ebaff5a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -764,7 +764,7 @@
 #
 # Get a list of BlockInfo for all virtual block devices.
 #
-# Returns: a list of @BlockInfo describing each virtual block device.
+# Returns: a list describing each virtual block device.
 #     Filter nodes that were created implicitly are skipped over.
 #
 # Since: 0.14
@@ -1169,7 +1169,7 @@
 #     nodes that were created implicitly are skipped over in this
 #     mode.  (Since 2.3)
 #
-# Returns: A list of @BlockStats for each virtual block devices.
+# Returns: A list of statistics for each virtual block device.
 #
 # Since: 0.14
 #
@@ -1441,7 +1441,7 @@
 #
 # Return information about long-running block device operations.
 #
-# Returns: a list of @BlockJobInfo for each active block job
+# Returns: a list of job info for each active block job
 #
 # Since: 1.1
 ##
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 2241bfecf2..fb004e35fd 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -473,7 +473,7 @@
 ##
 # @query-block-exports:
 #
-# Returns: A list of BlockExportInfo describing all block exports
+# Returns: A list describing all block exports
 #
 # Since: 5.2
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 2d54a81c36..f0436ce871 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -89,7 +89,7 @@
 # Return a list of information about each persistent reservation
 # manager.
 #
-# Returns: a list of @PRManagerInfo for each persistent reservation
+# Returns: a list of manager info for each persistent reservation
 #     manager
 #
 # Since: 3.0
diff --git a/qapi/control.json b/qapi/control.json
index 5fed0701f8..931a860b30 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -95,8 +95,7 @@
 #
 # Return the current version of QEMU.
 #
-# Returns: A @VersionInfo object describing the current version of
-#     QEMU.
+# Returns: An object describing the current version of QEMU.
 #
 # Since: 0.14
 #
@@ -133,7 +132,7 @@
 #
 # Return a list of supported QMP commands by this server
 #
-# Returns: A list of @CommandInfo for all supported commands
+# Returns: A list of all supported commands
 #
 # Since: 0.14
 #
diff --git a/qapi/dump.json b/qapi/dump.json
index 0642ca157b..dc92b53247 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -148,7 +148,7 @@
 #
 # Query latest dump status.
 #
-# Returns: A @DumpStatus object showing the dump status.
+# Returns: An object showing the dump status.
 #
 # Since: 2.6
 #
@@ -199,8 +199,7 @@
 #
 # Return the available formats for dump-guest-memory
 #
-# Returns: A @DumpGuestMemoryCapability object listing available
-#     formats for dump-guest-memory
+# Returns: An object listing available formats for dump-guest-memory
 #
 # Since: 2.0
 #
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 26d8839f19..be8511b067 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -36,10 +36,10 @@
 # string into a specific enum or from one specific type into an
 # alternate that includes the original type alongside something else.
 #
-# Returns: array of @SchemaInfo, where each element describes an
-#     entity in the ABI: command, event, type, ...
+# Returns: an array where each element describes an entity in the ABI:
+#     command, event, type, ...
 #
-#     The order of the various SchemaInfo is unspecified; however, all
+#     The order of the various elements is unspecified; however, all
 #     names are guaranteed to be unique (no name will be duplicated
 #     with different meta-types).
 #
diff --git a/qapi/job.json b/qapi/job.json
index 16b280f52f..51a57c523e 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -297,7 +297,7 @@
 #
 # Return information about jobs.
 #
-# Returns: a list with a @JobInfo for each active job
+# Returns: a list with info for each active job
 #
 # Since: 3.0
 ##
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 5c3c9a14e0..282bd3627b 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -163,7 +163,7 @@
 # 'sev-guest' confidential virtualization object.  The launch
 # measurement for SEV-SNP guests is only available within the guest.
 #
-# Returns: The @SevLaunchMeasureInfo for the guest
+# Returns: The guest's SEV guest launch measurement info
 #
 # Errors:
 #     - If the launch measurement is unavailable, either due to an
diff --git a/qapi/misc.json b/qapi/misc.json
index b19eb08606..7dbc29dbd6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -107,7 +107,7 @@
 #    declared using the ``-object iothread`` command-line option.  It
 #    is always the main thread of the process.
 #
-# Returns: a list of @IOThreadInfo for each iothread
+# Returns: a list of info for each iothread
 #
 # Since: 2.0
 #
@@ -511,8 +511,7 @@
 #
 # @option: option name
 #
-# Returns: list of @CommandLineOptionInfo for all options (or for the
-#     given @option).
+# Returns: list of objects for all options (or for the given @option).
 #
 # Errors:
 #     - if the given @option doesn't exist
diff --git a/qapi/net.json b/qapi/net.json
index 3b03843c16..a266c6786e 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -847,7 +847,7 @@
 #
 # @name: net client name
 #
-# Returns: list of @RxFilterInfo for all NICs (or for the given NIC).
+# Returns: list of info for all NICs (or for the given NIC).
 #
 # Errors:
 #     - if the given @name doesn't exist
diff --git a/qapi/pci.json b/qapi/pci.json
index a8671cd9ac..418ea4fc93 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -177,7 +177,7 @@
 #
 # Return information about the PCI bus topology of the guest.
 #
-# Returns: a list of @PciInfo for each PCI bus.  Each bus is
+# Returns: a list of info for each PCI bus.  Each bus is
 #     represented by a json-object, which has a key with a json-array
 #     of all PCI devices attached to it.  Each device is represented
 #     by a json-object.
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 441ed518b8..6441357e00 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -19,8 +19,7 @@
 #
 # @typename: the type name of a device
 #
-# Returns: a list of ObjectPropertyInfo describing a devices
-#     properties
+# Returns: a list describing a devices properties
 #
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
diff --git a/qapi/qom.json b/qapi/qom.json
index fbf94b9e09..aa09eddbf9 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -55,8 +55,7 @@
 # @path: the path within the object model.  See @qom-get for a
 #     description of this parameter.
 #
-# Returns: a list of @ObjectPropertyInfo that describe the properties
-#     of the object.
+# Returns: a list that describe the properties of the object.
 #
 # Since: 1.2
 #
@@ -178,8 +177,7 @@
 #
 # @abstract: if true, include abstract types in the results
 #
-# Returns: a list of @ObjectTypeInfo or an empty list if no results
-#     are found
+# Returns: a list of types, or an empty list if no results are found
 #
 # Since: 1.1
 ##
@@ -199,7 +197,7 @@
 #    describe links between different devices and/or objects.  These
 #    properties are not included in the output of this command.
 #
-# Returns: a list of ObjectPropertyInfo describing object properties
+# Returns: a list describing object properties
 #
 # Since: 2.12
 ##
diff --git a/qapi/stats.json b/qapi/stats.json
index 78b88881ea..b63a7369dd 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -188,7 +188,7 @@
 # The arguments are a StatsFilter and specify the provider and objects
 # to return statistics about.
 #
-# Returns: a list of StatsResult, one for each provider and object
+# Returns: a list of statistics, one for each provider and object
 #     (e.g., for each vCPU).
 #
 # Since: 7.1
diff --git a/qapi/trace.json b/qapi/trace.json
index d08c9c6a88..de369dae6b 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -49,7 +49,7 @@
 #
 # @name: Event name pattern (case-sensitive glob).
 #
-# Returns: a list of @TraceEventInfo for the matching events
+# Returns: a list of info for the matching events
 #
 # Since: 2.2
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index 53489ab65f..b48266c458 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -822,7 +822,7 @@
 #
 # Return information about each active mouse device
 #
-# Returns: a list of @MouseInfo for each device
+# Returns: a list of info for each device
 #
 # Since: 0.14
 #
diff --git a/qapi/virtio.json b/qapi/virtio.json
index f0753cde71..2e23512085 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -201,7 +201,7 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtioStatus of the virtio device
+# Returns: Status of the virtio device
 #
 # Since: 7.2
 #
@@ -565,7 +565,7 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtQueueStatus of the VirtQueue
+# Returns: Status of the queue
 #
 # .. note:: last_avail_idx will not be displayed in the case where the
 #    selected VirtIODevice has a running vhost device and the
@@ -700,7 +700,7 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtVhostQueueStatus of the vhost_virtqueue
+# Returns: Status of the vhost_virtqueue
 #
 # Since: 7.2
 #
-- 
2.49.0


