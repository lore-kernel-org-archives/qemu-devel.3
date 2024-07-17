Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E478C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2W7-0005X6-So; Wed, 17 Jul 2024 07:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Uy-0000rf-Q5; Wed, 17 Jul 2024 07:07:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Ut-0007TA-5d; Wed, 17 Jul 2024 07:07:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 434757B379;
 Wed, 17 Jul 2024 14:06:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AAD1C10B28E;
 Wed, 17 Jul 2024 14:06:40 +0300 (MSK)
Received: (nullmailer pid 844403 invoked by uid 1000);
 Wed, 17 Jul 2024 11:06:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 07/16] doc/net/l2tpv3: Update boolean fields' description to
 avoid short-form use
Date: Wed, 17 Jul 2024 14:06:31 +0300
Message-Id: <20240717110640.844335-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717110640.844335-1-mjt@tls.msk.ru>
References: <20240717110640.844335-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zhao Liu <zhao1.liu@intel.com>

The short-form boolean options has been deprecated since v6.0 (refer
to docs/about/deprecated.rst).

Update the description and example of boolean fields in l2tpv3 option to
avoid deprecation warning.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ad6521ef5e..edeaefe2c7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3353,7 +3353,7 @@ SRST
                          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
-``-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6=on|off][,udp=on|off][,cookie64][,counter][,pincounter][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
+``-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6=on|off][,udp=on|off][,cookie64=on|off][,counter=on|off][,pincounter=on|off][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
     Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3931)
     is a popular protocol to transport Ethernet (and other Layer 2) data
     frames between two systems. It is present in routers, firewalls and
@@ -3368,7 +3368,7 @@ SRST
     ``dst=dstaddr``
         destination address (mandatory)
 
-    ``udp``
+    ``udp=on``
         select udp encapsulation (default is ip).
 
     ``srcport=srcport``
@@ -3377,7 +3377,7 @@ SRST
     ``dstport=dstport``
         destination udp port.
 
-    ``ipv6``
+    ``ipv6=on``
         force v6, otherwise defaults to v4.
 
     ``rxcookie=rxcookie``; \ ``txcookie=txcookie``
@@ -3385,7 +3385,7 @@ SRST
         Their function is mostly to prevent misconfiguration. By default
         they are 32 bit.
 
-    ``cookie64``
+    ``cookie64=on``
         Set cookie size to 64 bit instead of the default 32
 
     ``counter=off``
@@ -3419,7 +3419,7 @@ SRST
         # launch QEMU instance - if your network has reorder or is very lossy add ,pincounter
 
         |qemu_system| linux.img -device e1000,netdev=n1 \\
-            -netdev l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
+            -netdev l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp=on,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter=on
 
 ``-netdev vde,id=id[,sock=socketpath][,port=n][,group=groupname][,mode=octalmode]``
     Configure VDE backend to connect to PORT n of a vde switch running
-- 
2.39.2


