Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7EBEFCBDF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226Q-0007pU-Mb; Mon, 16 Mar 2026 03:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225t-0007Vy-EJ; Mon, 16 Mar 2026 03:10:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225p-0007m0-DP; Mon, 16 Mar 2026 03:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645002; bh=9L7t5ss71R6N1H6jAb9ssg+VvhN8SmRC3QAN3PvN090=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uEjMThPdNNmeB13Vzh3Dc0Mr5AIOfnV++U9PH7s9jjYYY1F4B2iyI1x6C2r6BkmMZ
 5Mq/KQduGGh6BF6Wy+WEkc4d7Y78KJDf85TkIH/t6S5fkDc3LVYHprXtm6CpUs1uwb
 f5FW83rE1fu9IEiBx58R1cVf5gKLxqw8xZsOLE+e3JdxzxRKqw8a13ygnBt/Qm4HTE
 ljeCK3P+XMmKd94q70bisC4zE9HWiDSL0scmNJIleT28YnKUG7izuGMQQNYBJ5GILh
 s+LGzHu+pvCRMPcl+KcAADriW6MNXae18YM2oiIfLmXYrFBFMPQt3LBi8OkGAYmoK3
 QQzj93TXRm0nw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8879193C29;
 Mon, 16 Mar 2026 10:10:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E1253380051;
 Mon, 16 Mar 2026 10:10:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 07/14] docs: Move xbzrle.txt into the migration folder and
 convert to rst
Date: Mon, 16 Mar 2026 10:09:55 +0300
Message-ID: <20260316071005.91624-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

xbzrle is a feature of migration and thus this file should go
into the docs/devel/migration/ folder. While we're at it, turn
it into proper .rst format, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/devel/migration/features.rst             |   1 +
 .../migration/xbzrle.rst}                     | 106 +++++++++++-------
 2 files changed, 65 insertions(+), 42 deletions(-)
 rename docs/{xbzrle.txt => devel/migration/xbzrle.rst} (74%)

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 8f431d52f9..9aef79e7fa 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -15,3 +15,4 @@ Migration has plenty of features to support different use cases.
    qpl-compression
    uadk-compression
    qatzip-compression
+   xbzrle
diff --git a/docs/xbzrle.txt b/docs/devel/migration/xbzrle.rst
similarity index 74%
rename from docs/xbzrle.txt
rename to docs/devel/migration/xbzrle.rst
index bcb3f0c901..d4f4007261 100644
--- a/docs/xbzrle.txt
+++ b/docs/devel/migration/xbzrle.rst
@@ -20,7 +20,7 @@ A small cache size will result in high cache miss rate.
 Cache size can be changed before and during migration.
 
 Format
-=======
+------
 
 The compression format performs a XOR between the previous and current content
 of the page, where zero represents an unchanged value.
@@ -29,17 +29,19 @@ A zero run is represented by its length (in bytes).
 A non zero run is represented by its length (in bytes) and the new data.
 The run length is encoded using ULEB128 (http://en.wikipedia.org/wiki/LEB128)
 
-There can be more than one valid encoding, the sender may send a longer encoding
-for the benefit of reducing computation cost.
+There can be more than one valid encoding, the sender may send a longer
+encoding for the benefit of reducing computation cost.
 
-page = zrun nzrun
-       | zrun nzrun page
+::
 
-zrun = length
+    page = zrun nzrun
+           | zrun nzrun page
 
-nzrun = length byte...
+    zrun = length
 
-length = uleb128 encoded integer
+    nzrun = length byte...
+
+    length = uleb128 encoded integer
 
 On the sender side XBZRLE is used as a compact delta encoding of page updates,
 retrieving the old page content from the cache (default size of 64MB). The
@@ -55,24 +57,34 @@ instead.
 XBZRLE has a sustained bandwidth of 2-2.5 GB/s for typical workloads making it
 ideal for in-line, real-time encoding such as is needed for live-migration.
 
-Example
+Example:
+
 old buffer:
-1001 zeros
-05 06 07 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 68 00 00 6b 00 6d
-3074 zeros
+
+.. code:: batch
+
+    1001 zeros
+    05 06 07 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 68 00 00 6b 00 6d
+    3074 zeros
 
 new buffer:
-1001 zeros
-01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 68 00 00 67 00 69
-3074 zeros
+
+.. code:: batch
+
+    1001 zeros
+    01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 68 00 00 67 00 69
+    3074 zeros
 
 encoded buffer:
 
-encoded length 24
-e9 07 0f 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 03 01 67 01 01 69
+.. code:: batch
+
+    encoded length 24
+    e9 07 0f 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 03 01 67 01 01 69
 
 Cache update strategy
-=====================
+---------------------
+
 Keeping the hot pages in the cache is effective for decreasing cache
 misses. XBZRLE uses a counter as the age of each page. The counter will
 increase after each ram dirty bitmap sync. When a cache conflict is
@@ -80,21 +92,27 @@ detected, XBZRLE will only evict pages in the cache that are older than
 a threshold.
 
 Usage
-======================
-1. Verify the destination QEMU version is able to decode the new format.
-    {qemu} info migrate_capabilities
-    {qemu} xbzrle: off , ...
+-----
 
-2. Activate xbzrle on both source and destination:
-   {qemu} migrate_set_capability xbzrle on
+1. Verify the destination QEMU version is able to decode the new format::
+
+    (qemu) info migrate_capabilities
+    xbzrle: off
+    ...
+
+2. Activate xbzrle on both source and destination::
+
+    (qemu) migrate_set_capability xbzrle on
 
 3. Set the XBZRLE cache size - the cache size is in MBytes and should be a
-power of 2. The cache default value is 64MBytes. (on source only)
-    {qemu} migrate_set_parameter xbzrle-cache-size 256m
+   power of 2. The cache default value is 64 MBytes (on source only)::
+
+    (qemu) migrate_set_parameter xbzrle-cache-size 256m
 
-4. Start outgoing migration
-    {qemu} migrate -d tcp:destination.host:4444
-    {qemu} info migrate
+4. Start outgoing migration::
+
+    (qemu) migrate -d tcp:destination.host:4444
+    (qemu) info migrate
     capabilities: xbzrle: on
     Migration status: active
     transferred ram: A kbytes
@@ -114,6 +132,7 @@ power of 2. The cache default value is 64MBytes. (on source only)
 
 xbzrle cache miss: the number of cache misses to date - high cache-miss rate
 indicates that the cache size is set too low.
+
 xbzrle overflow: the number of overflows in the decoding which where the delta
 could not be compressed. This can happen if the changes in the pages are too
 large or there are many short changes; for example, changing every second byte
@@ -123,16 +142,19 @@ Testing: Testing indicated that live migration with XBZRLE was completed in 110
 seconds, whereas without it would not be able to complete.
 
 A simple synthetic memory r/w load generator:
-..    include <stdlib.h>
-..    include <stdio.h>
-..    int main()
-..    {
-..        char *buf = (char *) calloc(4096, 4096);
-..        while (1) {
-..            int i;
-..            for (i = 0; i < 4096 * 4; i++) {
-..                buf[i * 4096 / 4]++;
-..            }
-..            printf(".");
-..        }
-..    }
+
+.. code-block:: c
+
+    #include <stdlib.h>
+    #include <stdio.h>
+    int main()
+    {
+        char *buf = (char *) calloc(4096, 4096);
+        while (1) {
+            int i;
+            for (i = 0; i < 4096 * 4; i++) {
+                buf[i * 4096 / 4]++;
+            }
+            printf(".");
+        }
+    }
-- 
2.47.3


