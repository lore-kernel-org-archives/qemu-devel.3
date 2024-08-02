Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80F3C49EA1
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZipr-00047G-Hn; Thu, 01 Aug 2024 23:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipo-0003rq-KO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipk-0008Rg-FE
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722568799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yH7Hhnxy+JZeYhNTYJSvoZ9X0We0m2TGS1abbdMhA+w=;
 b=BZOJvwrfMIROmagTuBGH0rGHWGOBfdH4ByMb8bYWWfFoqmbMCnQN+YE4cWzxHf+Hy9oJqL
 XFEbzednmpSPnfCGtAs7cTjY3ya1RSVtce15prhoYSb+LopmZqHP4Uq08j0UoDpPDssJc1
 tT5ZMnLVwnAOSWgBxdhnZaRkrMUo6OQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-BUoW7K4zMr6vrT31lF51mg-1; Thu,
 01 Aug 2024 23:19:58 -0400
X-MC-Unique: BUoW7K4zMr6vrT31lF51mg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE39A1955D4F
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2024 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.229])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36B6B300019D; Fri,  2 Aug 2024 03:19:52 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 4/8] net: update netdev stream/dgram man page
Date: Fri,  2 Aug 2024 11:19:25 +0800
Message-ID: <20240802031929.44060-5-jasowang@redhat.com>
In-Reply-To: <20240802031929.44060-1-jasowang@redhat.com>
References: <20240802031929.44060-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

Add the description of "-netdev stream" and "-netdev dgram" in the QEMU
manpage.

Add some examples on how to use them.

Fixes: 5166fe0ae46d ("qapi: net: add stream and dgram netdevs")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 114 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 369ae81d7c..52143cfb8f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3353,6 +3353,120 @@ SRST
                          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
+``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off]``
+    Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/IP socket.
+
+    ``server=on|off``
+        if ``on`` create a server socket
+
+    ``addr.host=host,addr.port=port``
+        socket address to listen on (server=on) or connect to (server=off)
+
+    ``to=maxport``
+        if present, this is range of possible addresses, with port between ``port`` and ``maxport``.
+
+    ``numeric=on|off``
+        if ``on`` ``host`` and ``port`` are guaranteed to be numeric, otherwise a name resolution should be attempted (default: ``off``)
+
+    ``keep-alive=on|off``
+        enable keep-alive when connecting to this socket.  Not supported for passive sockets.
+
+    ``mptcp=on|off``
+        enable multipath TCP
+
+    ``ipv4=on|off``
+        whether to accept IPv4 addresses, default to try both IPv4 and IPv6
+
+    ``ipv6=on|off``
+        whether to accept IPv6 addresses, default to try both IPv4 and IPv6
+
+    Example (two guests connected using a TCP/IP socket):
+
+    .. parsed-literal::
+
+        # first VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
+                      -netdev stream,id=net0,server=on,addr.type=inet,addr.host=localhost,addr.port=1234
+        # second VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
+                      -netdev stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234
+
+``-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor``
+    Configure a network backend to connect to another QEMU virtual machine or a proxy using a stream oriented socket file descriptor.
+
+    ``server=on|off``
+        if ``on`` create a server socket
+
+    ``addr.str=file-descriptor``
+        file descriptor number to use as a socket
+
+``-netdev dgram,id=str,remote.type=inet,remote.host=maddr,remote.port=port[,local.type=inet,local.host=addr]``
+    Configure a network backend to connect to a multicast address.
+
+    ``remote.host=maddr,remote.port=port``
+        multicast address
+
+    ``local.host=addr``
+        specify the host address to send packets from
+
+    Example:
+
+    .. parsed-literal::
+
+        # launch one QEMU instance
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
+                      -netdev dgram,id=net0,remote.type=inet,remote.host=224.0.0.1,remote.port=1234
+        # launch another QEMU instance on same "bus"
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
+                      -netdev dgram,id=net0,remote.type=inet,remote.host=224.0.0.1,remote.port=1234
+        # launch yet another QEMU instance on same "bus"
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:58 \\
+                      -netdev dgram,id=net0,remote.type=inet,remote.host=224.0.0.1,remote.port=1234
+
+``-netdev dgram,id=str,remote.type=inet,remote.host=maddr,remote.port=port[,local.type=fd,local.str=file-descriptor]``
+    Configure a network backend to connect to a multicast address using a UDP socket file descriptor.
+
+    ``remote.host=maddr,remote.port=port``
+        multicast address
+
+    ``local.str=file-descriptor``
+        File descriptor to use to send packets
+
+``-netdev dgram,id=str,local.type=inet,local.host=addr,local.port=port[,remote.type=inet,remote.host=addr,remote.port=port]``
+    Configure a network backend to connect to another QEMU virtual
+    machine or a proxy using a datagram oriented unix domain socket.
+
+    ``local.host=addr,local.port=port``
+        IP address to use to send the packets from
+
+    ``remote.host=addr,remote.port=port``
+        Destination IP address
+
+    Example (two guests connected using an UDP/IP socket):
+
+    .. parsed-literal::
+
+        # first VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
+                      -netdev dgram,id=net0,local.type=inet,local.host=localhost,local.port=1234,remote.type=inet,remote.host=localhost,remote.port=1235
+        # second VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
+                      -netdev dgram,id=net0,local.type=inet,local.host=localhost,local.port=1235,remote.type=inet,remote.host=localhost,remote.port=1234
+
+``-netdev dgram,id=str,local.type=fd,local.str=file-descriptor``
+    Configure a network backend to connect to another QEMU virtual
+    machine or a proxy using a datagram oriented socket file descriptor.
+
+    ``local.str=file-descriptor``
+        File descriptor to use to send packets
+
 ``-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6=on|off][,udp=on|off][,cookie64=on|off][,counter=on|off][,pincounter=on|off][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
     Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3931)
     is a popular protocol to transport Ethernet (and other Layer 2) data
-- 
2.42.0


