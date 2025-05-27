Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5E9C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJouW-00045O-4R; Tue, 27 May 2025 03:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouU-00044b-Jb
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouF-0007rX-Rs
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmFHNpKSFFrq4naAyQKAi3/skB3lwt2fdhExkNUvdQg=;
 b=QmLNgBS7dKQAhIHvES8Yn/LVRqVGoVfrT32BuohaClfqw+9LTMc1+HzZdKgB/5xXjmroDe
 t3ZZ5Vq2tLUaSN2T+afrOh1kjsS+gIdzZi5Bg0DJGdmQO5ZZbYM06MEZqWzfKzwMfARZ/1
 pCCpiiQsN24tU0uQsBg94bGatrdo8Vw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-NLz7u2fQOoe6aWdNu6Bb2w-1; Tue,
 27 May 2025 03:39:23 -0400
X-MC-Unique: NLz7u2fQOoe6aWdNu6Bb2w-1
X-Mimecast-MFC-AGG-ID: NLz7u2fQOoe6aWdNu6Bb2w_1748331563
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C85DB195423C; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B1AF18001DA; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37F5621E65DF; Tue, 27 May 2025 09:39:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, qemu-block@nongnu.org
Subject: [PATCH 06/13] qapi: Correct spelling of QEMU in doc comments
Date: Tue, 27 May 2025 09:39:09 +0200
Message-ID: <20250527073916.1243024-7-armbru@redhat.com>
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Improve awkward phrasing in migrate-incoming While there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/audio.json        |  8 ++++----
 qapi/block-core.json   | 10 +++++-----
 qapi/block-export.json |  2 +-
 qapi/char.json         |  6 +++---
 qapi/introspect.json   |  4 ++--
 qapi/migration.json    |  8 ++++----
 qapi/run-state.json    |  6 +++---
 qapi/transaction.json  |  2 +-
 qapi/uefi.json         |  2 +-
 qapi/ui.json           |  4 ++--
 10 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 49633cf317..67f36f1cfe 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -309,9 +309,9 @@
 #
 # @name: name of the sink/source to use
 #
-# @stream-name: name of the PulseAudio stream created by qemu.  Can be
+# @stream-name: name of the PulseAudio stream created by QEMU.  Can be
 #     used to identify the stream in PulseAudio when you create
-#     multiple PulseAudio devices or run multiple qemu instances
+#     multiple PulseAudio devices or run multiple QEMU instances
 #     (default: audiodev's id, since 4.2)
 #
 # @latency: latency you want PulseAudio to achieve in microseconds
@@ -353,9 +353,9 @@
 #
 # @name: name of the sink/source to use
 #
-# @stream-name: name of the PipeWire stream created by qemu.  Can be
+# @stream-name: name of the PipeWire stream created by QEMU.  Can be
 #     used to identify the stream in PipeWire when you create multiple
-#     PipeWire devices or run multiple qemu instances (default:
+#     PipeWire devices or run multiple QEMU instances (default:
 #     audiodev's id)
 #
 # @latency: latency you want PipeWire to achieve in microseconds
diff --git a/qapi/block-core.json b/qapi/block-core.json
index cc48fc7122..b6447e847e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2030,7 +2030,7 @@
 #
 # @id: Block graph node identifier.  This @id is generated only for
 #     x-debug-query-block-graph and does not relate to any other
-#     identifiers in Qemu.
+#     identifiers in QEMU.
 #
 # @type: Type of graph node.  Can be one of block-backend, block-job
 #     or block-driver-state.
@@ -2794,7 +2794,7 @@
 # The node that receives the data is called the top image, can be
 # located in any part of the chain (but always above the base image;
 # see below) and can be specified using its device or node name.
-# Earlier qemu versions only allowed 'device' to name the top level
+# Earlier QEMU versions only allowed 'device' to name the top level
 # node; presence of the 'base-node' parameter during introspection can
 # be used as a witness of the enhanced semantics of 'device'.
 #
@@ -3196,7 +3196,7 @@
 #
 # Selects the AIO backend to handle I/O requests
 #
-# @threads: Use qemu's thread pool
+# @threads: Use QEMU's thread pool
 #
 # @native: Use native AIO backend (only Linux and Windows)
 #
@@ -5157,10 +5157,10 @@
 ##
 # @BlockdevQcow2Version:
 #
-# @v2: The original QCOW2 format as introduced in qemu 0.10 (version
+# @v2: The original QCOW2 format as introduced in QEMU 0.10 (version
 #     2)
 #
-# @v3: The extended QCOW2 format as introduced in qemu 1.1 (version 3)
+# @v3: The extended QCOW2 format as introduced in QEMU 1.1 (version 3)
 #
 # Since: 2.12
 ##
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 04190b503c..ed4deb54db 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -169,7 +169,7 @@
 # @growable: Whether writes beyond the EOF should grow the block node
 #     accordingly.  (default: false)
 #
-# @allow-other: If this is off, only qemu's user is allowed access to
+# @allow-other: If this is off, only QEMU's user is allowed access to
 #     this export.  That cannot be changed even with chmod or chown.
 #     Enabling this option will allow other users access to the export
 #     with the FUSE mount option "allow_other".  Note that using
diff --git a/qapi/char.json b/qapi/char.json
index 9ad9d11cf6..f1d8b503dd 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -351,7 +351,7 @@
 # Configuration info for stdio chardevs.
 #
 # @signal: Allow signals (such as SIGINT triggered by ^C) be delivered
-#     to qemu.  Default: true.
+#     to QEMU.  Default: true.
 #
 # Since: 1.5
 ##
@@ -443,7 +443,7 @@
 ##
 # @ChardevQemuVDAgent:
 #
-# Configuration info for qemu vdagent implementation.
+# Configuration info for QEMU vdagent implementation.
 #
 # @mouse: enable/disable mouse, default is enabled.
 #
@@ -656,7 +656,7 @@
 ##
 # @ChardevQemuVDAgentWrapper:
 #
-# @data: Configuration info for qemu vdagent implementation
+# @data: Configuration info for QEMU vdagent implementation
 #
 # Since: 6.1
 ##
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 95724ee2d2..e9e0297282 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -26,9 +26,9 @@
 # the QAPI schema.
 #
 # Furthermore, while we strive to keep the QMP wire format
-# backwards-compatible across qemu versions, the introspection output
+# backwards-compatible across QEMU versions, the introspection output
 # is not guaranteed to have the same stability.  For example, one
-# version of qemu may list an object member as an optional
+# version of QEMU may list an object member as an optional
 # non-variant, while another lists the same member only through the
 # object's variants; or the type of a member may change from a generic
 # string into a specific enum or from one specific type into an
diff --git a/qapi/migration.json b/qapi/migration.json
index 0e5a656cc9..461f9f0892 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -415,7 +415,7 @@
 #     on secondary side, this process is called COarse-Grain LOck
 #     Stepping (COLO) for Non-stop Service.  (since 2.8)
 #
-# @release-ram: if enabled, qemu will free the migrated ram pages on
+# @release-ram: if enabled, QEMU will free the migrated ram pages on
 #     the source during postcopy-ram migration.  (since 2.9)
 #
 # @return-path: If enabled, migration will use the return path even
@@ -1500,7 +1500,7 @@
 ##
 # @x-colo-lost-heartbeat:
 #
-# Tell qemu that heartbeat is lost, request it to do takeover
+# Tell QEMU that heartbeat is lost, request it to do takeover
 # procedures.  If this command is sent to the PVM, the Primary side
 # will exit COLO mode.  If sent to the Secondary, the Secondary side
 # will run failover work, then takes over server operation to become
@@ -1729,8 +1729,8 @@
 ##
 # @migrate-incoming:
 #
-# Start an incoming migration, the qemu must have been started with
-# -incoming defer
+# Start an incoming migration.  QEMU must have been started with
+# -incoming defer.
 #
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 4e44da63a0..eee61edff4 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -135,19 +135,19 @@
 ##
 # @SHUTDOWN:
 #
-# Emitted when the virtual machine has shut down, indicating that qemu
+# Emitted when the virtual machine has shut down, indicating that QEMU
 # is about to exit.
 #
 # @guest: If true, the shutdown was triggered by a guest request (such
 #     as a guest-initiated ACPI shutdown request or other
 #     hardware-specific action) rather than a host request (such as
-#     sending qemu a SIGINT).  (since 2.10)
+#     sending QEMU a SIGINT).  (since 2.10)
 #
 # @reason: The @ShutdownCause which resulted in the SHUTDOWN.
 #     (since 4.0)
 #
 # .. note:: If the command-line option ``-no-shutdown`` has been
-#    specified, qemu will not exit, and a STOP event will eventually
+#    specified, QEMU will not exit, and a STOP event will eventually
 #    follow the SHUTDOWN event.
 #
 # Since: 0.12
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 021e383496..5c3394919e 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -223,7 +223,7 @@
 # exists, the request will be rejected.  Only some image formats
 # support it, for example, qcow2, and rbd,
 #
-# On failure, qemu will try delete the newly created internal snapshot
+# On failure, QEMU will try delete the newly created internal snapshot
 # in the transaction.  When an I/O error occurs during deletion, the
 # user needs to fix it later with qemu-img or other command.
 #
diff --git a/qapi/uefi.json b/qapi/uefi.json
index bdfcabe1df..6592183d6c 100644
--- a/qapi/uefi.json
+++ b/qapi/uefi.json
@@ -5,7 +5,7 @@
 ##
 # = UEFI Variable Store
 #
-# The qemu efi variable store implementation (hw/uefi/) uses this to
+# The QEMU efi variable store implementation (hw/uefi/) uses this to
 # store non-volatile variables in json format on disk.
 #
 # This is an existing format already supported by (at least) two other
diff --git a/qapi/ui.json b/qapi/ui.json
index 3991329668..5939947b76 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1526,12 +1526,12 @@
 #
 # Display (user interface) options.
 #
-# @type: Which DisplayType qemu should use.
+# @type: Which DisplayType QEMU should use.
 #
 # @full-screen: Start user interface in fullscreen mode
 #     (default: off).
 #
-# @window-close: Allow to quit qemu with window close button
+# @window-close: Allow to quit QEMU with window close button
 #     (default: on).
 #
 # @show-cursor: Force showing the mouse cursor (default: off).
-- 
2.48.1


