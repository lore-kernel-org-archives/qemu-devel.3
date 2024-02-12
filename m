Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E89C4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOk-0006Kk-Ef; Mon, 12 Feb 2024 04:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOj-0006K7-0b
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOf-0003cL-Oy
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPsqU5rfe9kRi0DqoavTBNUcDMIT5EaKYBMxuSWZ1ic=;
 b=gsTKKSUJJj/VktQhCd7anSaYhAgGIuhVuC8DbIhmYVBqTPeE+Fxj0zUh15U+XvWboORxtW
 v7iRhBV0ZR9u0Gq0tB6pD5w7x8NEIJb7Sh3mi050/y9ilcAq3q6QO6gah3/W6LqXzfhWcp
 WuKL4ImZ4sxYiXNt5j6EZIGbnpXoJxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-r0bpvBN5PDuipClfc8cOUw-1; Mon, 12 Feb 2024 04:14:39 -0500
X-MC-Unique: r0bpvBN5PDuipClfc8cOUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 124B51021F71;
 Mon, 12 Feb 2024 09:14:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E487EF5594;
 Mon, 12 Feb 2024 09:14:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9089B21E60F4; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/18] qga/qapi-schema: Plug trivial documentation holes
Date: Mon, 12 Feb 2024 10:14:27 +0100
Message-ID: <20240212091436.688598-10-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add missing return member documentation of guest-get-disks,
guest-get-devices, guest-get-diskstats, and guest-get-cpustats.

The NVMe SMART information returned by guest-getdisks remains
undocumented.  Add a TODO there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-10-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/qapi-schema.json | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index f3d168d542..b8efe31897 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -36,12 +36,6 @@
         'guest-sync-delimited' ],
     # Types and commands with undocumented members:
     'documentation-exceptions': [
-        'GuestCpuStats',
-        'GuestCpuStatsType',
-        'GuestDeviceId',
-        'GuestDeviceType',
-        'GuestDiskSmart',
-        'GuestDiskStatsInfo',
         'GuestNVMeSmart' ] } }
 
 ##
@@ -944,6 +938,8 @@
 # NVMe smart information, based on NVMe specification, section
 # <SMART / Health Information (Log Identifier 02h)>
 #
+# TODO: document members briefly
+#
 # Since: 7.1
 ##
 { 'struct': 'GuestNVMeSmart',
@@ -978,7 +974,7 @@
 #
 # Disk type related smart information.
 #
-# - @nvme: NVMe disk smart
+# @type: disk bus type
 #
 # Since: 7.1
 ##
@@ -1499,6 +1495,8 @@
 
 ##
 # @GuestDeviceType:
+#
+# @pci: PCI device
 ##
 { 'enum': 'GuestDeviceType',
   'data': [ 'pci' ] }
@@ -1518,7 +1516,9 @@
 ##
 # @GuestDeviceId:
 #
-# Id of the device - @pci: PCI ID, since: 5.2
+# Id of the device
+#
+# @type: device type
 #
 # Since: 5.2
 ##
@@ -1700,6 +1700,8 @@
 # @major: major device number of disk
 #
 # @minor: minor device number of disk
+#
+# @stats: I/O statistics
 ##
 { 'struct': 'GuestDiskStatsInfo',
   'data': {'name': 'str',
@@ -1723,7 +1725,9 @@
 ##
 # @GuestCpuStatsType:
 #
-# An enumeration of OS type
+# Guest operating systems supporting CPU statistics
+#
+# @linux: Linux
 #
 # Since: 7.1
 ##
@@ -1780,7 +1784,7 @@
 #
 # Get statistics of each CPU in millisecond.
 #
-# - @linux: Linux style CPU statistics
+# @type: guest operating system
 #
 # Since: 7.1
 ##
-- 
2.43.0


