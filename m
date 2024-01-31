Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8EEC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9CA-0008CY-OJ; Wed, 31 Jan 2024 06:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9C9-0008C4-G7; Wed, 31 Jan 2024 06:55:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9C7-0003uI-N2; Wed, 31 Jan 2024 06:55:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CF789490C0;
 Wed, 31 Jan 2024 14:56:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0688570269;
 Wed, 31 Jan 2024 14:55:50 +0300 (MSK)
Received: (nullmailer pid 2263918 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 02/21] colo: examples: remove mentions of script= and (wrong)
 downscript=
Date: Wed, 31 Jan 2024 14:55:30 +0300
Message-Id: <20240131115549.2263854-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131115549.2263854-1-mjt@tls.msk.ru>
References: <20240131115549.2263854-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

There's no need to repeat script=/etc/qemu-ifup in examples,
as it is already in there.  More, all examples uses incorrect
"down script=" (which should be "downscript=").

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 docs/colo-proxy.txt | 6 +++---
 qemu-options.hx     | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
index 1fc38aed1b..e712c883db 100644
--- a/docs/colo-proxy.txt
+++ b/docs/colo-proxy.txt
@@ -162,7 +162,7 @@ Here is an example using demonstration IP and port addresses to more
 clearly describe the usage.
 
 Primary(ip:3.3.3.3):
--netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
+-netdev tap,id=hn0,vhost=off
 -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
 -chardev socket,id=mirror0,host=3.3.3.3,port=9003,server=on,wait=off
 -chardev socket,id=compare1,host=3.3.3.3,port=9004,server=on,wait=off
@@ -177,7 +177,7 @@ Primary(ip:3.3.3.3):
 -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1
 
 Secondary(ip:3.3.3.8):
--netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
+-netdev tap,id=hn0,vhost=off
 -device e1000,netdev=hn0,mac=52:a4:00:12:78:66
 -chardev socket,id=red0,host=3.3.3.3,port=9003
 -chardev socket,id=red1,host=3.3.3.3,port=9004
@@ -202,7 +202,7 @@ Primary(ip:3.3.3.3):
 -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,vnet_hdr_support
 
 Secondary(ip:3.3.3.8):
--netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
+-netdev tap,id=hn0,vhost=off
 -device e1000,netdev=hn0,mac=52:a4:00:12:78:66
 -chardev socket,id=red0,host=3.3.3.3,port=9003
 -chardev socket,id=red1,host=3.3.3.3,port=9004
diff --git a/qemu-options.hx b/qemu-options.hx
index ced8284863..484cc21c1f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5462,7 +5462,7 @@ SRST
             KVM COLO
 
             primary:
-            -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
+            -netdev tap,id=hn0,vhost=off
             -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
             -chardev socket,id=mirror0,host=3.3.3.3,port=9003,server=on,wait=off
             -chardev socket,id=compare1,host=3.3.3.3,port=9004,server=on,wait=off
@@ -5477,7 +5477,7 @@ SRST
             -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1
 
             secondary:
-            -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
+            -netdev tap,id=hn0,vhost=off
             -device e1000,netdev=hn0,mac=52:a4:00:12:78:66
             -chardev socket,id=red0,host=3.3.3.3,port=9003
             -chardev socket,id=red1,host=3.3.3.3,port=9004
@@ -5488,7 +5488,7 @@ SRST
             Xen COLO
 
             primary:
-            -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
+            -netdev tap,id=hn0,vhost=off
             -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
             -chardev socket,id=mirror0,host=3.3.3.3,port=9003,server=on,wait=off
             -chardev socket,id=compare1,host=3.3.3.3,port=9004,server=on,wait=off
@@ -5504,7 +5504,7 @@ SRST
             -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,notify_dev=nofity_way,iothread=iothread1
 
             secondary:
-            -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
+            -netdev tap,id=hn0,vhost=off
             -device e1000,netdev=hn0,mac=52:a4:00:12:78:66
             -chardev socket,id=red0,host=3.3.3.3,port=9003
             -chardev socket,id=red1,host=3.3.3.3,port=9004
-- 
2.39.2


