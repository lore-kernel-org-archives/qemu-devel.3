Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76200606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iy8wUuQP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqFN-0007EE-3y; Tue, 10 Nov 2026 13:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqFK-0007Cc-SF
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:07:03 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqFI-0000Is-Cf
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:07:02 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so1602924f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794334019; x=1794938819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LaWGF+N6L9EnkTxRhEYuaJ0IgRPyJp84mCq60nLg0F4=;
 b=iy8wUuQPqeVzSievJ4lOsHnBrSp86KCeL5U7lb5pvMmax67grMsCbjgiDy2SLDssvq
 rAqtGZid24piOKyS7GEOAo69hn5MxLR+hcFkOwSCY2OqJ1/KcKJDmYFE8RCvMIGW4ApS
 lkcajdy2Ic7jVxIoeAwTaRq4Nv5zUPPjX7/H45vDdXxqXMgH1SGnsyniwmKqEMLYLT0C
 qhTsDYqxV48JakHziY2qKRjDFDP8x/yLT9FYAnd07za58KxlMSdNMyCg8uzSB2sx8fit
 tZneGPpWQbWdoMg/U/xiQWPBPFqL4ZLB5uDxdOUMreg6QwxKIQuhR8NrFhY3AaPJYlwR
 31MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334019; x=1794938819;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LaWGF+N6L9EnkTxRhEYuaJ0IgRPyJp84mCq60nLg0F4=;
 b=OhmBJdaajvc8kSaReIzcBc2nf7Op5X3pSJzflYmn6nHoaJfxePkWltOG07jqA2xs04
 FCL1BB3SFLtg+cwXUZmpICnRr3F2cNFQBrqCFB1phCA0ePjWNWKNZ8vD0vFzz+ihUpqx
 WHWiXypn+/mxkexCbmbvDNYCUdoFRyou3+yE48oA+RqP8nZ1wU9/c4xy2MV2OuIRUHX9
 YqIq9CqW3EwPwcuYMp78fRHebyRnFK+h4nP7i1k6Qs+OUUJiF7WCaVMdBDJQZdf996uL
 LEIgkMUUmYivnid495cHt3nOnl/4iGzo5nHQap74lPlp80nKU9Hz/Aoy5cxaa1pr/U/H
 uEWQ==
X-Gm-Message-State: APuU4Z+JtyYPc0DlPqefdsOjgyuZFAZ+ZSD/3TrLXbixgwunIWMkjNAx
 K1DNGQqZ7FdducgRNRbDTk5H5jrUZ+clQ1ZiPvOeypfO/4UVlPDvzteuOXUuv+MiieSmOG1gAYc
 WVI8IVSg=
X-Gm-Gg: AYBFou0ZSOwNi7lbdidIdLCk7siajhBpzgQd0mhtkDTekBCZng6vVS0lnxar+mhECaB
 dBq0NWOMarbg5nvzBiJ+ITjNBAY3tidkPqd00/BplWn3N3powCrutvPnUIEGFCQYB5hXERDMY3L
 O+fmnyI3UWwinSmHeXJt4IdPOsT6n9ai0OShP6r8taAXeg8J4ls5QmnoADXDRpLjTZ8ndBSM6pI
 KMzFKiqmW6z1Ld5648B1T92DzL2UASBm72JI5jPyX1zJe87zzDgnYL6GK4MLQLIRcbxsZ78Ey7j
 ElAvN02iyY/NMyb8MnvIWSOff9x9Je1lwCFvmQvfigQFKW5vpyamzvJkx2k3niz+IEE5UOolrmH
 CZ8psDUwub5dTMOCNOgEtKZy1mXOgOcDYaL7dZ/JKFe9Db40r1XWsCBcUpClc8WJ4wwD1XgqaYN
 y6gb2fGS4Dfz+ooIE0FtQO0G58M7E8+tv82HkgLfO1bOwF2ZKGREwbndZaoAO6TOCeNTWF4xYQU
 AC2K3RTXqXv+hjxQP4LtML+Rm9aAahhbKJ6DChAj3jpIDpAhh67t7dJ3STAismTIKPD2fgq1AkX
 2Lb1Anldu20YA44nwPAU1zHzd68P21T+iM+H3dkBYTcUwRk1mBFQniIZfzWcPqyVvLu/IQHG/Rv
 z/aoW0pAvqtkIwMKrCMFa+pgzicqUqQV6hg==
X-Received: by 2002:a05:6000:490f:b0:48e:412:3813 with SMTP id
 ffacd0b85a97d-4993bdb6c5bmr2338251f8f.20.1794334018954; 
 Tue, 10 Nov 2026 10:06:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm6825701f8f.53.2026.11.10.10.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:06:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org,
 "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Jason Wang" <jasowangio@gmail.com>,
 "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
 "Laurent Vivier" <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Zhang Chen" <zhangckid@gmail.com>, "Li Zhijian" <lizhijian@fujitsu.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 for-11.2 2/3] net: Set do_not_pad for net backends
Date: Tue, 10 Nov 2026 18:06:54 +0000
Message-ID: <20261110180655.2072265-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110180655.2072265-1-peter.maydell@linaro.org>
References: <20261110180655.2072265-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently our handling of short network packets (i.e.  those which
are smaller than the minimum ethernet frame size of 60 bytes) is a
little confused.  The intention is that we allow network device
models to transmit short packets, but we protect them from having to
deal with receiving short packets unless they explicitly opt into it.
This means we don't have to have a lot of code in each network device
to try to handle the short packet size -- historically that code was
untested, and often a source of "carefully crafted packet can cause
an out-of-bounds memory access" bugs.

Our implementation of the padding is currently done when each network
backend feeds a packet into the system via one of the
qemu_send_packet family of functions.  This mostly works, except that
we missed some of the more obscure backends (e.g.  the socket
backend), and it means code duplication in each backend.  We'd like
to switch to making qemu_send_packet do the padding itself.  To do
that, we first need to make sure that all the NetClientState
implementations which do not want padding set the do_not_pad flag.
We do this by setting the flag for NetClientState instances created
by qemu_new_net_client() and qemu_new_net_control_client().  Emulated
network devices use qemu_new_nic(), which does not set the flag.

Note that this also causes the net/hub client to request no padding.
This is the right behaviour: we want the hub to accept short packets
and forward them on to all destinations.  Each destination then gets
to choose whether it sees a padded packet or the short one.  The
hub.c code is length-agnostic and doesn't look inside the packets it
is passing on, so it has no issues with short packets.

That change means we can rely on do_not_pad being correct for all
NetClientInfo structs, and so we can pad short packets in the
qemu_send_packet() and qemu_sendv_packet() family of functions.

If the callsite is already padding, then this will have no effect,
but callsites like the socket and dgram backends will now correctly
add padding.  This fixes the bug where when two QEMU instances are
connected via one of those backends a short ARP packet transmitted by
one is not correctly padded by the other and gets dropped.

Note that if we pad a packet, our return value on success will
be the size of the padded packet, not the original. This is OK
because this function (like the NetQueueDeliverFunc function type
documented in include/net/queue.h and which we will eventually
end up calling and returning the return value of) returns
   >0 - success
    0 - queue packet for future redelivery
   <0 - failure (discard packet)
and doesn't guarantee to return exactly the size of the packet
sent. None of the callers try to use the return value as an
exact size.

Cc: qemu-stable@nongu.org
Fixes: CVE-2026-118490
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2362
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/net/eth.h | 22 ++++++++++++++++++++++
 include/net/net.h |  3 ++-
 net/eth.c         | 18 ++++++++++++++++++
 net/net.c         | 32 ++++++++++++++++++++++++++++----
 net/tap.c         |  2 +-
 5 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 46dc9ed5acd..042b2fc42db 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -437,4 +437,26 @@ eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
 bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
                          const void *pkt, size_t pkt_size);
 
+/**
+ * eth_pad_short_frame_iov - pad a short frame, iovec version
+ *
+ * This is equivalent to eth_pad_short_frame(), except that it works
+ * on a packet stored in a struct iovec.
+ *
+ * If the Ethernet frame size is shorter than 60 bytes, it will be padded to
+ * 60 bytes at the address @padded_pkt (and the caller will need to handle
+ * it as a not-in-an-iovec packet).
+ *
+ * @padded_pkt: buffer address to hold the padded frame
+ * @padded_buflen: pointer holding length of @padded_pkt. If the frame is
+ *                 padded, the length will be updated to the padded one.
+ * @iov: iovec holding the original Ethernet frame
+ * @iovcnt: number of elements in @iov
+ * @pkt_size: size of the original Ethernet frame (i.e. iov_size(iov, iovcnt))
+ * @return true if the frame is padded, otherwise false
+ */
+bool eth_pad_short_frame_iov(uint8_t *padded_pkt, size_t *padded_buflen,
+                             const struct iovec *iov, int iovcnt,
+                             size_t pkt_size);
+
 #endif
diff --git a/include/net/net.h b/include/net/net.h
index de4f03c3013..c2fd451f17e 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -171,7 +171,8 @@ void qemu_net_client_setup(NetClientState *nc,
                            const char *model,
                            const char *name,
                            NetClientDestructor *destructor,
-                           bool is_datapath);
+                           bool is_datapath,
+                           bool do_not_pad);
 NetClientState *qemu_new_net_client(NetClientInfo *info,
                                     NetClientState *peer,
                                     const char *model,
diff --git a/net/eth.c b/net/eth.c
index 12ec316e240..14006222d68 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -536,3 +536,21 @@ bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
 
     return true;
 }
+
+bool eth_pad_short_frame_iov(uint8_t *padded_pkt, size_t *padded_buflen,
+                             const struct iovec *iov, int iovcnt,
+                             size_t pkt_size)
+{
+    assert(padded_buflen && *padded_buflen >= ETH_ZLEN);
+
+    if (pkt_size >= ETH_ZLEN) {
+        return false;
+    }
+
+    /* pad to minimum Ethernet frame length */
+    iov_to_buf(iov, iovcnt, 0, padded_pkt, pkt_size);
+    memset(&padded_pkt[pkt_size], 0, ETH_ZLEN - pkt_size);
+    *padded_buflen = ETH_ZLEN;
+
+    return true;
+}
diff --git a/net/net.c b/net/net.c
index bf7e5d9b125..7c7fb4bd30e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -267,7 +267,8 @@ void qemu_net_client_setup(NetClientState *nc,
                            const char *model,
                            const char *name,
                            NetClientDestructor *destructor,
-                           bool is_datapath)
+                           bool is_datapath,
+                           bool do_not_pad)
 {
     nc->info = info;
     nc->model = g_strdup(model);
@@ -287,6 +288,7 @@ void qemu_net_client_setup(NetClientState *nc,
     nc->incoming_queue = qemu_new_net_queue(qemu_deliver_packet_iov, nc);
     nc->destructor = destructor;
     nc->is_datapath = is_datapath;
+    nc->do_not_pad = do_not_pad;
     QTAILQ_INIT(&nc->filters);
 }
 
@@ -301,7 +303,7 @@ NetClientState *qemu_new_net_client(NetClientInfo *info,
 
     nc = g_malloc0(info->size);
     qemu_net_client_setup(nc, info, peer, model, name,
-                          qemu_net_client_destructor, true);
+                          qemu_net_client_destructor, true, true);
 
     return nc;
 }
@@ -317,7 +319,7 @@ NetClientState *qemu_new_net_control_client(NetClientInfo *info,
 
     nc = g_malloc0(info->size);
     qemu_net_client_setup(nc, info, peer, model, name,
-                          qemu_net_client_destructor, false);
+                          qemu_net_client_destructor, false, true);
 
     return nc;
 }
@@ -344,7 +346,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
 
     for (i = 0; i < queues; i++) {
         qemu_net_client_setup(&nic->ncs[i], info, peers[i], model, name,
-                              NULL, true);
+                              NULL, true, false);
         nic->ncs[i].queue_index = i;
     }
 
@@ -742,6 +744,8 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
 {
     NetQueue *queue;
     int ret;
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz = sizeof(min_pkt);
 
 #ifdef DEBUG_NET
     printf("qemu_send_packet_async:\n");
@@ -752,6 +756,13 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
         return size;
     }
 
+    if (net_peer_needs_padding(sender)) {
+        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
+            buf = min_pkt;
+            size = min_pktsz;
+        }
+    }
+
     /* Let filters handle the packet first */
     ret = filter_receive(sender, NET_FILTER_DIRECTION_TX,
                          sender, flags, buf, size, sent_cb);
@@ -906,6 +917,19 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender,
         return size;
     }
 
+    if (net_peer_needs_padding(sender)) {
+        uint8_t min_pkt[ETH_ZLEN];
+        size_t min_pktsz = sizeof(min_pkt);
+
+        /*
+         * If we pad the packet, we get back a simple buffer, so handle
+         * it by sending it to the non-iov qemu_send_packet function
+         */
+        if (eth_pad_short_frame_iov(min_pkt, &min_pktsz, iov, iovcnt, size)) {
+            return qemu_send_packet_async(sender, min_pkt, min_pktsz, sent_cb);
+        }
+    }
+
     /* Let filters handle the packet first */
     ret = filter_receive_iov(sender, NET_FILTER_DIRECTION_TX, sender,
                              QEMU_NET_PACKET_FLAG_NONE, iov, iovcnt, sent_cb);
diff --git a/net/tap.c b/net/tap.c
index 9bce0d088f9..ee6430d34a5 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -627,7 +627,7 @@ static TAPState *new_tap(NetClientState *peer,
     TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
 
     qemu_net_client_setup(&s->nc, &net_tap_info, peer, model, name,
-                          tap_net_client_destructor, true);
+                          tap_net_client_destructor, true, true);
 
     s->queue_index = queue_index;
 
-- 
2.43.0


