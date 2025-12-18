Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC012D68BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW8Uq-0000t9-54; Thu, 18 Dec 2025 02:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vW8Uk-0000sa-Nh; Thu, 18 Dec 2025 02:32:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vW8Ui-0004Xf-AO; Thu, 18 Dec 2025 02:32:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E6D0C176664;
 Thu, 18 Dec 2025 10:31:49 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE5F6338A50;
 Thu, 18 Dec 2025 10:32:10 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CE3B3702C7; Thu, 18 Dec 2025 10:32:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PATCH] qemu-options.hx: use KiB, MiB, GiB for power-of-2 units
Date: Thu, 18 Dec 2025 10:32:05 +0300
Message-ID: <20251218073208.160482-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Use MiB &Co instead of MB &Co when the talk is about
power-of-two-based sizes, in qemu-options.hx.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3222
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index fca2b7bc74f..65d50a81cb1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -303,9 +303,9 @@ SRST
         with break-before-make sequences are considerable and also if guest
         workloads are read intensive. The size here specifies how many pages
         to break at a time and needs to be a valid block size which is
-        1GB/2MB/4KB, 32MB/16KB and 512MB/64KB for 4KB/16KB/64KB PAGE_SIZE
-        respectively. Be wary of specifying a higher size as it will have an
-        impact on the memory. By default, this feature is disabled
+        1GiB/2MiB/4KiB, 32MiB/16KiB and 512MiB/64KiB for 4KiB/16KiB/64KiB
+        PAGE_SIZE respectively. Be wary of specifying a higher size as it will
+        have an impact on the memory. By default, this feature is disabled
         (eager-split-size=0).
 
     ``notify-vmexit=run|internal-error|disable,notify-window=n``
@@ -562,7 +562,7 @@ SRST
 
     lat is latency value in nanoseconds. bw is bandwidth value, the
     possible value and units are NUM[M\|G\|T], mean that the bandwidth
-    value are NUM byte per second (or MB/s, GB/s or TB/s depending on
+    value are NUM byte per second (or MiB/s, GiB/s or TiB/s depending on
     used suffix). Note that if latency or bandwidth value is 0, means
     the corresponding latency or bandwidth information is not provided.
 
@@ -577,10 +577,10 @@ SRST
     For example, the following options describe 2 NUMA nodes. Node 0 has
     2 cpus and a ram, node 1 has only a ram. The processors in node 0
     access memory in node 0 with access-latency 5 nanoseconds,
-    access-bandwidth is 200 MB/s; The processors in NUMA node 0 access
+    access-bandwidth is 200 MiB/s; The processors in NUMA node 0 access
     memory in NUMA node 1 with access-latency 10 nanoseconds,
-    access-bandwidth is 100 MB/s. And for memory side cache information,
-    NUMA node 0 and 1 both have 1 level memory cache, size is 10KB,
+    access-bandwidth is 100 MiB/s. And for memory side cache information,
+    NUMA node 0 and 1 both have 1 level memory cache, size is 10KiB,
     policy is write-back, the cache Line size is 8 bytes:
 
     ::
@@ -737,8 +737,8 @@ SRST
     amount of memory. Note that maxmem must be aligned to the page size.
 
     For example, the following command-line sets the guest startup RAM
-    size to 1GB, creates 3 slots to hotplug additional memory and sets
-    the maximum memory the guest can reach to 4GB:
+    size to 1GiB, creates 3 slots to hotplug additional memory and sets
+    the maximum memory the guest can reach to 4GiB:
 
     .. parsed-literal::
 
@@ -1694,7 +1694,7 @@ SRST
         Specify bandwidth throttling limits in bytes per second, either
         for all request types or for reads or writes only. Small values
         can lead to timeouts or hangs inside the guest. A safe minimum
-        for disks is 2 MB/s.
+        for disks is 2 MiB/s.
 
     ``bps_max=bm,bps_rd_max=rm,bps_wr_max=wm``
         Specify bursts in bytes per second, either for all request types
-- 
2.47.3


