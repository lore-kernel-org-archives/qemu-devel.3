Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97F3C30658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 15:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMUx7-000249-IQ; Wed, 26 Jun 2024 11:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sMUx4-00023p-Bq
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 11:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sMUx2-0001Wz-BI
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 11:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719417171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yUc2JAmzNScQ21iDVf6IVAjmDF7CxJE686b2I+3r24Q=;
 b=K3FH/yLstZLX5unAVXxEoewKh6whTgkTvseqgXhMToxv5c5bM7EWOfl5OVeaKZo/b152G8
 zdtplpopAOqnh4/JsTEffy+Vxdeg1iD5l/tbiv8mlwS07JXKY2O+D5Z8cEuNwg6NVhIpAV
 7K1ZaDlWK5ylGBFiWKevv3l7sDo3o64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557--AVzxjllNVqNFW06AfuWaQ-1; Wed,
 26 Jun 2024 11:51:45 -0400
X-MC-Unique: -AVzxjllNVqNFW06AfuWaQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52FE4195604F
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 15:51:44 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.193.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E030F300021A; Wed, 26 Jun 2024 15:51:41 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] net: update netdev stream/dgram man page
Date: Wed, 26 Jun 2024 17:51:40 +0200
Message-ID: <20240626155140.74752-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the description of "-netdev stream" and "-netdev dgram" in the QEMU
manpage.

Add some examples on how to use them, including a way to use
"-netdev stream" and "passt" in place of "-netdev user".
("passt" is a non privileged translation proxy between layer-2,
like "-netdev stream", and layer-4 on host, like TCP, UDP,
ICMP/ICMPv6 echo)

Fixes: 5166fe0ae46d ("qapi: net: add stream and dgram netdevs")
Fixes: 13c6be96618c ("net: stream: add unix socket")
Fixes: 784e7a253104 ("net: dgram: add unix socket")
Fixes: 148fbf0d58a6 ("net: stream: add a new option to automatically reconnect"
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 qemu-options.hx | 189 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 8ca7f34ef0c8..b8a1a65f05e7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3353,6 +3353,195 @@ SRST
                          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
+``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect=seconds]``
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
+    ``reconnect=seconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+        Setting this to zero disables this function.  (default: 0)
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
+                      -netdev stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234,reconnect=5
+
+``-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect=seconds]``
+    Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/UNIX socket.
+
+    ``server=on|off``
+        if ``on`` create a server socket
+
+    ``addr.path=path``
+        filesystem path to use
+
+    ``abstract=on|off``
+        if ``on``, this is a Linux abstract socket address.
+
+    ``tight=on|off``
+        if false, pad an abstract socket address with enough null bytes to make it fill struct sockaddr_un member sun_path.
+
+    ``reconnect=seconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+        Setting this to zero disables this function.  (default: 0)
+
+    Example (using passt as a replacement of -netdev user):
+
+    .. parsed-literal::
+
+        # start passt server as a non privileged user
+        passt
+        UNIX domain socket bound at /tmp/passt_1.socket
+        # start QEMU to connect to passt
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0 \\
+                      -netdev stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/passt_1.socket
+
+    Example (two guests connected using a TCP/UNIX socket):
+
+    .. parsed-literal::
+
+        # first VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
+                      netdev stream,id=net0,server=on,addr.type=unix,addr.path=/tmp/qemu0
+        # second VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
+                      -netdev stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/qemu0,reconnect=5
+
+``-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect=seconds]``
+    Configure a network backend to connect to another  QEMU  virtual machine or a proxy using a TCP socket file descriptor.
+
+    ``server=on|off``
+        if ``on`` create a server socket
+
+    ``addr.str=file-descriptor``
+        file descriptor number to use as a socket
+
+    ``reconnect=seconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+        Setting this to zero disables this function.  (default: 0)
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
+    machine or a proxy using an UDP/IP socket.
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
+``-netdev dgram,id=str,local.type=unix,local.path=path[,remote.type=unix,remote.path=path]``
+    Configure a network backend to connect to another QEMU virtual
+    machine or a proxy using an UDP/UNIX socket.
+
+    ``local.path=path``
+        filesystem path to use to bind the socket
+
+    ``remote.path=path``
+        filesystem path to use as a destination (see sendto(2))
+
+    Example (two guests connected using an UDP/UNIX socket):
+
+    .. parsed-literal::
+
+        # first VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
+                      -netdev dgram,id=net0,local.type=unix,local.path=/tmp/qemu0,remote.type=unix,remote.path=/tmp/qemu1
+        # second VM
+        |qemu_system| linux.img \\
+                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
+                      -netdev dgram,id=net0,local.type=unix,local.path=/tmp/qemu1,remote.type=unix,remote.path=/tmp/qemu0
+
+``-netdev dgram,id=str,local.type=fd,local.str=file-descriptor``
+    Configure a network backend to connect to another QEMU virtual
+    machine or a proxy using an UDP socket file descriptor.
+
+    ``local.str=file-descriptor``
+        File descriptor to use to send packets
+
 ``-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6=on|off][,udp=on|off][,cookie64][,counter][,pincounter][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
     Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3931)
     is a popular protocol to transport Ethernet (and other Layer 2) data
-- 
2.45.2


