Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2008CCA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrio-0001Nb-OX; Wed, 30 Sep 2026 06:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrik-0001Kc-Kr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0006kc-Jf
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDJe5EtqI1Yy6hP9bXa6qv16jZ3RH8k6071a0OE9Cdg=;
 b=LQlMWKFzdiel6r7wtmeFQcTQD8tSV9JOPEOujgmaHtrVpMW7A+NDdURlZecZsF4Us8mC7P
 X8rF1aFPuw6C9wkTgnBbPkbZ/h/lB8GMpi9yeR3xrMPtqIyUgb+FPMyCW8hqI9dMKNjhL8
 H84bjJV0AwUUPyrd9bwL1Hg5l9OGQFU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-P7Hly_rxM7yt49ZUUuWULg-1; Wed,
 30 Sep 2026 06:39:23 -0400
X-MC-Unique: P7Hly_rxM7yt49ZUUuWULg-1
X-Mimecast-MFC-AGG-ID: P7Hly_rxM7yt49ZUUuWULg_1790764762
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6951F185FE55; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC16776F; Wed, 30 Sep 2026 10:39:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2AD7C21E681E; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 036/105] qapi: convert trivial intro sections for char.json
Date: Wed, 30 Sep 2026 12:38:01 +0200
Message-ID: <20260930103910.3934848-37-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20260831201945.287730-37-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json | 90 +++++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 60 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index abaccefa97..7ae67eedff 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -12,8 +12,7 @@
 
 ##
 # @ChardevInfo:
-#
-# Information about a character device.
+#     Information about a character device.
 #
 # @label: the label of the character device
 #
@@ -35,8 +34,7 @@
 
 ##
 # @query-chardev:
-#
-# Return information about current character devices.
+#     Return information about current character devices.
 #
 # Since: 0.14
 #
@@ -68,8 +66,7 @@
 
 ##
 # @ChardevBackendInfo:
-#
-# Information about a character device backend
+#     Information about a character device backend
 #
 # @name: The backend name
 #
@@ -79,8 +76,7 @@
 
 ##
 # @query-chardev-backends:
-#
-# Return information about character device backends.
+#     Return information about character device backends.
 #
 # Since: 2.0
 #
@@ -108,8 +104,7 @@
 
 ##
 # @DataFormat:
-#
-# An enumeration of data format.
+#     An enumeration of data format.
 #
 # @utf8: Data is a UTF-8 string (RFC 3629)
 #
@@ -122,8 +117,7 @@
 
 ##
 # @ringbuf-write:
-#
-# Write to a ring buffer character device.
+#     Write to a ring buffer character device.
 #
 # @device: the ring buffer character device name
 #
@@ -154,8 +148,7 @@
 
 ##
 # @ringbuf-read:
-#
-# Read from a ring buffer character device.
+#     Read from a ring buffer character device.
 #
 # @device: the ring buffer character device name
 #
@@ -189,8 +182,7 @@
 
 ##
 # @ChardevCommon:
-#
-# Configuration shared across all chardev backends
+#     Configuration shared across all chardev backends
 #
 # @logfile: The name of a logfile to save output
 #
@@ -209,8 +201,7 @@
 
 ##
 # @ChardevFile:
-#
-# Configuration info for file chardevs.
+#     Configuration info for file chardevs.
 #
 # @in: The name of the input file
 #
@@ -229,8 +220,7 @@
 
 ##
 # @ChardevHostdev:
-#
-# Configuration info for device and pipe chardevs.
+#     Configuration info for device and pipe chardevs.
 #
 # @device: The name of the special file for the device, i.e.
 #     /dev/ttyS0 on Unix or COM1: on Windows
@@ -243,8 +233,7 @@
 
 ##
 # @ChardevSocket:
-#
-# Configuration info for (stream) socket chardevs.
+#     Configuration info for (stream) socket chardevs.
 #
 # @addr: socket address to listen on (server=true) or connect to
 #     (server=false)
@@ -295,8 +284,7 @@
 
 ##
 # @ChardevUdp:
-#
-# Configuration info for datagram socket chardevs.
+#     Configuration info for datagram socket chardevs.
 #
 # @remote: remote address
 #
@@ -311,8 +299,7 @@
 
 ##
 # @ChardevMux:
-#
-# Configuration info for mux chardevs.
+#     Configuration info for mux chardevs.
 #
 # @chardev: name of the base chardev.
 #
@@ -324,8 +311,7 @@
 
 ##
 # @ChardevHub:
-#
-# Configuration info for hub chardevs.
+#     Configuration info for hub chardevs.
 #
 # @chardevs: IDs to be added to this hub (maximum 4 devices).
 #
@@ -337,8 +323,7 @@
 
 ##
 # @ChardevStdio:
-#
-# Configuration info for stdio chardevs.
+#     Configuration info for stdio chardevs.
 #
 # @signal: Allow signals (such as SIGINT triggered by ^C) be delivered
 #     to QEMU.  Default: true.
@@ -351,8 +336,7 @@
 
 ##
 # @ChardevSpiceChannel:
-#
-# Configuration info for spice vm channel chardevs.
+#     Configuration info for spice vm channel chardevs.
 #
 # @type: kind of channel (for example vdagent).
 #
@@ -365,8 +349,7 @@
 
 ##
 # @ChardevSpicePort:
-#
-# Configuration info for spice port chardevs.
+#     Configuration info for spice port chardevs.
 #
 # @fqdn: name of the channel (see docs/spice-port-fqdn.txt)
 #
@@ -379,8 +362,7 @@
 
 ##
 # @ChardevVCEncoding:
-#
-# Character encoding expected from the guest on a virtual console.
+#     Character encoding expected from the guest on a virtual console.
 #
 # @cp437: CP437 (8-bit Extended ASCII / VGA).  Every byte maps
 #     directly to a glyph; suitable for DOS or other guests that
@@ -397,8 +379,7 @@
 
 ##
 # @ChardevDBus:
-#
-# Configuration info for DBus chardevs.
+#     Configuration info for DBus chardevs.
 #
 # @name: name of the channel (following docs/spice-port-fqdn.txt)
 #
@@ -415,8 +396,7 @@
 
 ##
 # @ChardevVC:
-#
-# Configuration info for virtual console chardevs.
+#     Configuration info for virtual console chardevs.
 #
 # @width: console width, in pixels
 #
@@ -445,8 +425,7 @@
 
 ##
 # @ChardevRingbuf:
-#
-# Configuration info for ring buffer chardevs.
+#     Configuration info for ring buffer chardevs.
 #
 # @size: ring buffer size, must be power of two, default is 65536
 #
@@ -458,8 +437,7 @@
 
 ##
 # @ChardevQemuVDAgent:
-#
-# Configuration info for QEMU vdagent implementation.
+#     Configuration info for QEMU vdagent implementation.
 #
 # @mouse: enable/disable mouse, default is enabled.
 #
@@ -475,8 +453,7 @@
 
 ##
 # @ChardevPty:
-#
-# Configuration info for pty implementation.
+#     Configuration info for pty implementation.
 #
 # @path: optional path to create a symbolic link that points to the
 #     allocated PTY
@@ -723,8 +700,7 @@
 
 ##
 # @ChardevBackend:
-#
-# Configuration info for the new chardev backend.
+#     Configuration info for the new chardev backend.
 #
 # @type: backend type
 #
@@ -767,8 +743,7 @@
 
 ##
 # @ChardevReturn:
-#
-# Return info about the chardev backend just created.
+#     Return info about the chardev backend just created.
 #
 # @pty: name of the slave pseudoterminal device, present if and only
 #     if a chardev of type 'pty' was created
@@ -780,8 +755,7 @@
 
 ##
 # @chardev-add:
-#
-# Add a character device backend
+#     Add a character device backend
 #
 # @id: the chardev's ID, must be unique
 #
@@ -818,8 +792,7 @@
 
 ##
 # @chardev-change:
-#
-# Change a character device backend
+#     Change a character device backend
 #
 # @id: the chardev's ID
 #
@@ -859,8 +832,7 @@
 
 ##
 # @chardev-remove:
-#
-# Remove a character device backend
+#     Remove a character device backend
 #
 # @id: the chardev's ID, must not be in use
 #
@@ -876,8 +848,7 @@
 
 ##
 # @chardev-send-break:
-#
-# Send a break to a character device
+#     Send a break to a character device
 #
 # @id: the chardev's ID
 #
@@ -893,8 +864,7 @@
 
 ##
 # @VSERPORT_CHANGE:
-#
-# Emitted when the guest opens or closes a virtio-serial port.
+#     Emitted when the guest opens or closes a virtio-serial port.
 #
 # @id: device identifier of the virtio-serial port
 #
-- 
2.55.0


