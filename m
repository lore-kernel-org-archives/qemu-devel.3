Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425FACCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFprQ-0000ur-SY; Mon, 03 Nov 2025 03:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprN-0000u4-VP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprE-0006iH-FC
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762158240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8P+t0vPWm/TWfB5fUN+OFZ9X7P3YLLrzY9LiZ8mhhIU=;
 b=hJm+LcFyP7YjRhyst9u5ISpso1dAi0XeI3Lg7wbRzp0ExHbWjRzKp18ItUImwkHzzRGpZH
 o9VysIKA5KNIznRB+OGg2VKqu2kYbiGUCFboUWiBkLkf4vr3BGFfM3YbiFUG05ahBSRGZD
 E7QCDXhLxXGZ/iXuA47RB1uwb7+QARU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-djDAqMhjO7K9HRLe0aZI5w-1; Mon,
 03 Nov 2025 03:23:59 -0500
X-MC-Unique: djDAqMhjO7K9HRLe0aZI5w-1
X-Mimecast-MFC-AGG-ID: djDAqMhjO7K9HRLe0aZI5w_1762158238
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A0F9180A201; Mon,  3 Nov 2025 08:23:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFA0C1800452; Mon,  3 Nov 2025 08:23:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05BDC21E6741; Mon, 03 Nov 2025 09:23:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH v2 4/9] qga/qapi-schema: Refill doc comments to conform to
 conventions
Date: Mon,  3 Nov 2025 09:23:49 +0100
Message-ID: <20251103082354.3273027-5-armbru@redhat.com>
In-Reply-To: <20251103082354.3273027-1-armbru@redhat.com>
References: <20251103082354.3273027-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
7270819384c (qga/qapi-schema: Refill doc comments to conform to
current conventions).

To check the generated documentation does not change, I compared the
generated HTML before and after this commit with "wdiff -3".  Finds no
differences.  Comparing with diff is not useful, as the reflown
paragraphs are visible there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qga/qapi-schema.json | 87 ++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8162d888bb..af75f12a28 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -2,8 +2,8 @@
 # vim: filetype=python
 
 ##
-# This manual describes the commands supported by the QEMU Guest
-# Agent Protocol.
+# This manual describes the commands supported by the QEMU Guest Agent
+# Protocol.
 #
 # For locating  a particular item, please see the `qapi-qga-index`.
 #
@@ -96,8 +96,8 @@
 # In cases where a partial stale response was previously received by
 # the client, this cannot always be done reliably.  One particular
 # scenario being if qemu-ga responses are fed character-by-character
-# into a JSON parser.  In these situations, using `guest-sync-delimited`
-# may be optimal.
+# into a JSON parser.  In these situations, using
+# `guest-sync-delimited` may be optimal.
 #
 # For clients that fetch responses line by line and convert them to
 # JSON objects, `guest-sync` should be sufficient, but note that in
@@ -153,9 +153,9 @@
 # This command tries to set guest's System Time to the given value,
 # then sets the Hardware Clock (RTC) to the current System Time.  This
 # will make it easier for a guest to resynchronize without waiting for
-# NTP. If no @time is specified, then the time to set is read from
-# RTC. However, this may not be supported on all platforms (i.e.
-# Windows). If that's the case users are advised to always pass a
+# NTP.  If no @time is specified, then the time to set is read from
+# RTC.  However, this may not be supported on all platforms (i.e.
+# Windows).  If that's the case users are advised to always pass a
 # value.
 #
 # @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in
@@ -444,8 +444,8 @@
 # Returns: Number of file systems currently frozen.
 #
 # .. note:: On Windows, the command is implemented with the help of a
-#    Volume Shadow-copy Service DLL helper.  The frozen state is limited
-#    for up to 10 seconds by VSS.
+#    Volume Shadow-copy Service DLL helper.  The frozen state is
+#    limited for up to 10 seconds by VSS.
 #
 # Since: 0.15.0
 ##
@@ -482,9 +482,9 @@
 # Returns: Number of file systems thawed by this call
 #
 # .. note:: If the return value does not match the previous call to
-#    `guest-fsfreeze-freeze`, this likely means some freezable filesystems
-#    were unfrozen before this call, and that the filesystem state may
-#    have changed before issuing this command.
+#    `guest-fsfreeze-freeze`, this likely means some freezable
+#    filesystems were unfrozen before this call, and that the
+#    filesystem state may have changed before issuing this command.
 #
 # Since: 0.15.0
 ##
@@ -513,7 +513,8 @@
 ##
 # @GuestFilesystemTrimResponse:
 #
-# @paths: list of `GuestFilesystemTrimResult` per path that was trimmed
+# @paths: list of `GuestFilesystemTrimResult` per path that was
+#     trimmed
 #
 # Since: 2.4
 ##
@@ -557,16 +558,16 @@
 #
 # This command does NOT return a response on success.  There is a high
 # chance the command succeeded if the VM exits with a zero exit status
-# or, when running with --no-shutdown, by issuing the `query-status` QMP
-# command to to confirm the VM status is "shutdown". However, the VM
-# could also exit (or set its status to "shutdown") due to other
+# or, when running with --no-shutdown, by issuing the `query-status`
+# QMP command to to confirm the VM status is "shutdown".  However, the
+# VM could also exit (or set its status to "shutdown") due to other
 # reasons.
 #
 # Errors:
 #     - If suspend to disk is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the `guest-sync` command
-#    before sending commands when the guest resumes.
+# .. note:: It's strongly recommended to issue the `guest-sync`
+#    command before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -586,7 +587,7 @@
 # - manual write into sysfs
 #
 # IMPORTANT: `guest-suspend-ram` requires working wakeup support in
-# QEMU. You should check QMP command `query-current-machine` returns
+# QEMU.  You should check QMP command `query-current-machine` returns
 # wakeup-suspend-support: true before issuing this command.  Failure
 # in doing so can result in a suspended guest that QEMU will not be
 # able to awaken, forcing the user to power cycle the guest to bring
@@ -602,8 +603,8 @@
 # Errors:
 #     - If suspend to ram is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the `guest-sync` command
-#    before sending commands when the guest resumes.
+# .. note:: It's strongly recommended to issue the `guest-sync`
+#    command before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -622,7 +623,7 @@
 # - pm-utils (via pm-suspend-hybrid)
 #
 # IMPORTANT: `guest-suspend-hybrid` requires working wakeup support in
-# QEMU. You should check QMP command `query-current-machine` returns
+# QEMU.  You should check QMP command `query-current-machine` returns
 # wakeup-suspend-support: true before issuing this command.  Failure
 # in doing so can result in a suspended guest that QEMU will not be
 # able to awaken, forcing the user to power cycle the guest to bring
@@ -638,8 +639,8 @@
 # Errors:
 #     - If hybrid suspend is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the `guest-sync` command
-#    before sending commands when the guest resumes.
+# .. note:: It's strongly recommended to issue the `guest-sync`
+#    command before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -1048,10 +1049,11 @@
 #
 # @used-bytes: file system used bytes (since 3.0)
 #
-# @total-bytes: filesystem capacity in bytes for unprivileged users (since 3.0)
+# @total-bytes: filesystem capacity in bytes for unprivileged users
+#     (since 3.0)
 #
-# @total-bytes-privileged: filesystem capacity in bytes for privileged users
-#     (since 9.1)
+# @total-bytes-privileged: filesystem capacity in bytes for privileged
+#     users (since 9.1)
 #
 # @disk: an array of disk hardware information that the volume lies
 #     on, which may be empty if the disk type is not supported
@@ -1171,7 +1173,8 @@
 ##
 # @GuestMemoryBlockResponse:
 #
-# @phys-index: same with the 'phys-index' member of `GuestMemoryBlock`.
+# @phys-index: same with the 'phys-index' member of
+#     `GuestMemoryBlock`.
 #
 # @response: the result of memory block operation.
 #
@@ -1491,10 +1494,11 @@
 #
 # .. note:: On POSIX systems the fields @id, @name, @pretty-name,
 #    @version, @version-id, @variant and @variant-id follow the
-#    definition specified in os-release(5). Refer to the manual page for
-#    exact description of the fields.  Their values are taken from the
-#    os-release file.  If the file is not present in the system, or the
-#    values are not present in the file, the fields are not included.
+#    definition specified in os-release(5).  Refer to the manual page
+#    for exact description of the fields.  Their values are taken from
+#    the os-release file.  If the file is not present in the system,
+#    or the values are not present in the file, the fields are not
+#    included.
 #
 #    On Windows the values are filled from information gathered from
 #    the system.
@@ -1639,7 +1643,7 @@
 # @guest-ssh-remove-authorized-keys:
 #
 # Remove public keys from the user .ssh/authorized_keys on Unix
-# systems (not implemented for other systems). It's not an error if
+# systems (not implemented for other systems).  It's not an error if
 # the key is already missing.
 #
 # @username: the user account to remove the authorized keys
@@ -1862,10 +1866,10 @@
 #
 # Retrieve CPU process load information
 #
-# .. note:: Windows does not have load average API, so QGA emulates it by
-#           calculating the average CPU usage in the last 1, 5, 15 minutes
-#           similar as Linux does this.
-#           Calculation starts from the first time this command is called.
+# .. note:: Windows does not have load average API, so QGA emulates it
+#    by calculating the average CPU usage in the last 1, 5, 15 minutes
+#    similar as Linux does this.  Calculation starts from the first
+#    time this command is called.
 #
 # Returns: load information
 #
@@ -1881,9 +1885,11 @@
 #
 # Route information, currently, only linux supported.
 #
-# @iface: The destination network or host's egress network interface in the routing table
+# @iface: The destination network or host's egress network interface
+#     in the routing table
 #
-# @destination: The IP address of the target network or host, The final destination of the packet
+# @destination: The IP address of the target network or host, The
+#     final destination of the packet
 #
 # @metric: Route metric
 #
@@ -1899,7 +1905,8 @@
 #
 # @use: Route usage count (not for windows)
 #
-# @window: TCP window size, used for flow control (not for windows, IPv4 only)
+# @window: TCP window size, used for flow control (not for windows,
+#     IPv4 only)
 #
 # @mtu: Data link layer maximum packet size (not for windows)
 #
-- 
2.49.0


