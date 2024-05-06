Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FDDC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7m-0002zq-Ac; Mon, 06 May 2024 07:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7f-0002om-F5
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7X-0003ej-7y
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ra3UHb3T8zQv2R0nHBXpbhmQsfMIG/kMMF2WRy9zyZo=;
 b=YjYFkAmZCkdsBYdFISl8N2U1XDxjLJipcjpS8PwvjJ6iKhzMmuSUpSBJxXy/gDwO7YKXW3
 drLjDTALJKDnx+FvmwHLJTZ3BHrqhreHaWOJnGHIItw2NXqFoGnXr8pdQysObrhJEme+sF
 u5G5YYodFZguzY/KsRWR53Gp+f6g2no=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-_gKCVzV8NVepu-nMb8c9ew-1; Mon,
 06 May 2024 07:02:56 -0400
X-MC-Unique: _gKCVzV8NVepu-nMb8c9ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96B0A1C0514B;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59983EC685;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5881D21D49C2; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 6/7] qga/qapi-schema: Drop "Returns" section where default is
 fine WIP
Date: Mon,  6 May 2024 13:02:52 +0200
Message-ID: <20240506110254.3965097-13-armbru@redhat.com>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
References: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

---
 qga/qapi-schema.json | 40 +++++-----------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d5af155007..fe41670ed2 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -194,8 +194,6 @@
 #
 # Get some information about the guest agent.
 #
-# Returns: @GuestAgentInfo
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-info',
@@ -277,8 +275,6 @@
 # @count: maximum number of bytes to read (default is 4KB, maximum is
 #     48MB)
 #
-# Returns: @GuestFileRead
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-read',
@@ -312,8 +308,6 @@
 # @count: bytes to write (actual bytes, after base64-decode), default
 #     is all content in buf-b64 buffer after base64 decoding
 #
-# Returns: @GuestFileWrite
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-write',
@@ -379,8 +373,6 @@
 #
 # @whence: Symbolic or numeric code for interpreting offset
 #
-# Returns: @GuestFileSeek
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-seek',
@@ -419,9 +411,6 @@
 #
 # Get guest fsfreeze state.
 #
-# Returns: GuestFsfreezeStatus ("thawed", "frozen", etc., as defined
-#     below)
-#
 # Note: This may fail to properly report the current state as a result
 #     of some other guest processes having issued an fs freeze/thaw.
 #
@@ -725,8 +714,6 @@
 #
 # Get list of guest IP addresses, MAC addresses and netmasks.
 #
-# Returns: List of GuestNetworkInterface
-#
 # Since: 1.1
 ##
 { 'command': 'guest-network-get-interfaces',
@@ -760,6 +747,7 @@
 #
 # Returns: The list of all VCPUs the guest knows about.  Each VCPU is
 #     put on the list exactly once, but their order is unspecified.
+#     TODO
 #
 # Since: 1.5
 ##
@@ -1009,6 +997,7 @@
 #     the physical disks.  On Linux these are all root block devices
 #     of non-zero size including e.g. removable devices, loop devices,
 #     NBD, etc.
+#     TODO
 #
 # Since: 5.2
 ##
@@ -1045,6 +1034,7 @@
 #     The returned mountpoints may be specified to
 #     @guest-fsfreeze-freeze-list.  Network filesystems (such as CIFS
 #     and NFS) are not listed.
+#     TODO
 #
 # Since: 2.2
 ##
@@ -1108,6 +1098,7 @@
 # Returns: The list of all memory blocks the guest knows about.  Each
 #     memory block is put on the list exactly once, but their order is
 #     unspecified.
+#     TODO
 #
 # Since: 2.3
 ##
@@ -1179,6 +1170,7 @@
 #     Note: it will return an empty list if the @mem-blks list was
 #     empty on input, or there is an error, and in this case, guest
 #     state will not be changed.
+#     TODO
 #
 # Since: 2.3
 ##
@@ -1203,8 +1195,6 @@
 #
 # Get information relating to guest memory blocks.
 #
-# Returns: @GuestMemoryBlockInfo
-#
 # Since: 2.3
 ##
 { 'command': 'guest-get-memory-block-info',
@@ -1249,8 +1239,6 @@
 #
 # @pid: pid returned from guest-exec
 #
-# Returns: GuestExecStatus
-#
 # Since: 2.5
 ##
 { 'command': 'guest-exec-status',
@@ -1322,8 +1310,6 @@
 # @capture-output: bool flag to enable capture of stdout/stderr of
 #     running process.  Defaults to false.
 #
-# Returns: PID
-#
 # Since: 2.5
 ##
 { 'command': 'guest-exec',
@@ -1351,8 +1337,6 @@
 # or even present in DNS or some other name service at all.  It need
 # not even be unique on your local network or site, but usually it is.
 #
-# Returns: the host name of the machine
-#
 # Since: 2.10
 ##
 { 'command': 'guest-get-host-name',
@@ -1381,8 +1365,6 @@
 #
 # Retrieves a list of currently active users on the VM.
 #
-# Returns: A unique list of users.
-#
 # Since: 2.10
 ##
 { 'command': 'guest-get-users',
@@ -1407,8 +1389,6 @@
 #
 # Retrieves the timezone information from the guest.
 #
-# Returns: A GuestTimezone dictionary.
-#
 # Since: 2.10
 ##
 { 'command': 'guest-get-timezone',
@@ -1483,8 +1463,6 @@
 #
 # Retrieve guest operating system information
 #
-# Returns: @GuestOSInfo
-#
 # Since: 2.10
 ##
 { 'command': 'guest-get-osinfo',
@@ -1550,8 +1528,6 @@
 #
 # Retrieve information about device drivers in Windows guest
 #
-# Returns: @GuestDeviceInfo
-#
 # Since: 5.2
 ##
 { 'command': 'guest-get-devices',
@@ -1579,8 +1555,6 @@
 #
 # @username: the user account to add the authorized keys
 #
-# Returns: @GuestAuthorizedKeys
-#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-get-authorized-keys',
@@ -1707,8 +1681,6 @@
 #
 # Retrieve information about disk stats.
 #
-# Returns: List of disk stats of guest.
-#
 # Since: 7.1
 ##
 { 'command': 'guest-get-diskstats',
@@ -1791,8 +1763,6 @@
 #
 # Retrieve information about CPU stats.
 #
-# Returns: List of CPU stats of guest.
-#
 # Since: 7.1
 ##
 { 'command': 'guest-get-cpustats',
-- 
2.44.0


