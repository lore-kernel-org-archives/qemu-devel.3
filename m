Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3BFC48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWti9-0003KC-UM; Mon, 05 Feb 2024 02:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthN-000334-NP
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthE-00062x-Vy
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNynqkKX4qBeTYspk/1SN2AngUmIP8zYz3tbq++y9GA=;
 b=JVGnN6ChoiB7XJqvkaDohYpVpGwNfp1LvoOQuVgBu3McWvd7qOWiMUmZuJDFkGgz14+794
 s0Ba0ViN3bPnYPVCyY569R7wSgzwoH3PMFETsWRn5H5M6D5T8vd5ej/U0sLupkbu0RaKpN
 +0HPMTWiz3FSZJhBr6eXIsehahbNFvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-7OHGOt5UNOekdql2fumkMg-1; Mon, 05 Feb 2024 02:47:13 -0500
X-MC-Unique: 7OHGOt5UNOekdql2fumkMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23B8D85A597;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFF8A2026F95;
 Mon,  5 Feb 2024 07:47:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B8D221E60F5; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: [PATCH 09/15] qga/qapi-schema: Plug trivial documentation holes
Date: Mon,  5 Feb 2024 08:47:03 +0100
Message-ID: <20240205074709.3613229-10-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


