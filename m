Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82710C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4QD-0004cB-I1; Tue, 09 Jul 2024 02:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sR4QB-0004Yc-3b
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:33:51 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sR4Q8-0002JC-8v
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:33:50 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so2416183a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 23:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720506826; x=1721111626;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UomquE8s4ypHQ9KZBxCWi+V0cCvOWgDu1LcmoJBSPTU=;
 b=14eDFpJIZamxH9c4WKRqqAkEviiO8pnwwWJYKdfDEf7D/Di28oYZOhoJww922RRAJ1
 KkrjuzEeEcCL18lGwkMHFtYHmuQ8npKpWRn0bRc7URr+ifRloF/pfmqgUjYeKFVUOHhT
 Y66Cp6mW+4OXKrl2ouqEImO+g/oioiQnAYs0rf+XeWMpiKM/34Zt0uUPuVmYp7Y0qD0/
 Q9O8ykuaHc/5nZIlOwENRCc1bx2SswwyFK5LoDLXY0/g0mHvx4T1Hz0EbAplLf1I2Exc
 d4mabYfw5mUGe3LTD1Q83dRwJWGWAcUDarlHvDW4188WGVPWpQ9Dx2hY72uO4lzlY5F6
 hw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720506826; x=1721111626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UomquE8s4ypHQ9KZBxCWi+V0cCvOWgDu1LcmoJBSPTU=;
 b=BUVcNZT1EQBdUl1yFJz8G3tAhSlql7dzV8fT6M9SbM34Tc9ce19K3zM6fq4LhMBipG
 mBDBMZCzMczyNchACX9r0AGalI+NKxiX9uzHltXTYOqJJA+SRyfbBfS2hV/ZXChBOIoF
 FsmpCPkRX5f1kQpTduk6IcLuJPJGiXjl3rDQqd5yCl7Ie+ertYJDu5XbJZLjpAZmyp8j
 Qx8KFp80NVN1qecoLGIewkZBhriOaDXYGC1xlimUd1jrn8+m97yjt+E05u0LIBc/1pcT
 lX2HEirHHdIEPCibbJOvGWxVvxFNBYAeK6+HgT/WYCOLY7NRE39G5FghhyLKxAld9VOF
 XUgA==
X-Gm-Message-State: AOJu0YzteD3iobobdGBeq716g6XLEUSNKDNOU7NJ7qePdNBp2KMdEc8m
 8aUMHwBXTvvJ/DCN8BH0XX0lbrYKumXJLbXNTS/oYx9P9/gBOgcRaCQpj31b7CXv4WCuadeY0+h
 x1wUg5XCm
X-Google-Smtp-Source: AGHT+IGLJMHLjYJRlTTNYPtHOWjB1v99nyeGweK7wJp5rO+haVWWQ4SsKcbJS+74rt0rSweX7JgXKA==
X-Received: by 2002:a05:6a20:439f:b0:1c0:f529:af05 with SMTP id
 adf61e73a8af0-1c2984cda84mr1514833637.43.1720506825860; 
 Mon, 08 Jul 2024 23:33:45 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local (vps-bd302c4a.vps.ovh.ca.
 [15.235.142.94]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a0fc38sm8713095ad.17.2024.07.08.23.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 23:33:45 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	yong.huang@smartx.com
Subject: [PATCH v2 1/1] e1000: Fix the overrun check of the receive ring buffer
Date: Tue,  9 Jul 2024 14:33:38 +0800
Message-Id: <0586c0bef4a8606a1efe9ccff24e037f1c954cd9.1720506723.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1720506723.git.yong.huang@smartx.com>
References: <cover.1720506723.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Unexpected work by certain Windows guests equipped with the e1000
interface can cause the network to go down and never come back up
again unless the guest's interface is reset.

To reproduce the failure:
1. Set up two guests with a Windows 2016 or 2019 server operating
   system.
2. Set up the e1000 interface for the guests.
3. Pressurize the network slightly between two guests using the iPerf tool.

The network goes down after a few days (2-5days), and the issue
is the result of not adhering to the e1000 specification. Refer
to the details of the specification at the following link:
https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf

Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
as following:
This register holds a value that is an offset from the base, and
identifies the location beyond the last descriptor hardware can
process. Note that tail should still point to an area in the
descriptor ring (somewhere between RDBA and RDBA + RDLEN).
This is because tail points to the location where software writes
the first new descriptor.

This means that if the provider—in this case, QEMU—has not yet
put packets into the descriptior of the receive ring buffer,
RDT should not point to that descriptior since it is in the range
of "hardware" handles. While when implementing the emulation of
the e1000 interface, QEMU evaluates thta the receive ring buffer
is full once the RDT equals the RDH.

We applied the following log patch to assist in analyzing the
issue and eventually obtained the unexpected information.

Log patch:
-----------------------------------------------------------------
|--- a/hw/net/e1000.c
|+++ b/hw/net/e1000.c
|@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
| static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
| {
|     int bufs;
|+    DBGOUT(RX, "rxbuf_size = %u, s->mac_reg[RDLEN] = %u, s->mac_reg[RDH] = %u, s->mac_reg[RDT] = %u\n",
|+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], s->mac_reg[RDT]);
|+
|     /* Fast-path short packets */
|     if (total_size <= s->rxbuf_size) {
|         if (s->mac_reg[RDH] == s->mac_reg[RDT] && s->last_overrun)
|@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
|         s->rxbuf_min_shift)
|         n |= E1000_ICS_RXDMT0;
|
|+    DBGOUT(RX, "rxbuf_size = %u, s->mac_reg[RDLEN] = %u, s->mac_reg[RDH] = %u, s->mac_reg[RDT] = %u\n",
|+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], s->mac_reg[RDT]);
|+
-----------------------------------------------------------------

The last few logs of information before the network shuts down:

e1000: total_size = 1, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 897, s->mac_reg[RDT] = 885
<- the receive ring buffer is checked for fullness in the
e1000_has_rxbufs function, not full.

e1000: total_size = 64, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 898, s->mac_reg[RDT] = 885
<- RDT stays the same, RDH updates to 898, and 1 descriptor
utilized after putting the packet to ring buffer.

e1000: total_size = 1, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 898, s->mac_reg[RDT] = 885
<- the receive ring buffer is checked for fullness in the
e1000_has_rxbufs function, not full.

e1000: total_size = 64, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 899, s->mac_reg[RDT] = 885
<- RDT stays the same, RDH updates to 899, and 1 descriptor
utilized after putting the packet to ring buffer.

e1000: total_size = 1, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 899, s->mac_reg[RDT] = 885
<- the receive ring buffer is checked for fullness in the
e1000_has_rxbufs function, not full.

e1000: total_size = 64, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 900, s->mac_reg[RDT] = 885
<- RDT stays the same, RDH updates to 900 , and 1 descriptor
utilized after putting the packet to ring buffer.

e1000: total_size = 1, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 900, s->mac_reg[RDT] = 900
<- The ring is full, according to e1000_has_rxbufs, because
of the RDT update to 900 and equals RDH ! But in reality,
the state of the ring buffer is empty because the producer
only used one descriptor the last time, and the ring buffer
was not full after that.

To sum up, QEMU claims that the receive ring buffer is full
in the aforementioned scenario, placing the packet in the
self-maintained queue and unregistering the tap device's
readable fd handler and then waiting for the guest to consume
the receive ring buffer. This brings down the network since
guests have nothing to consume and never update the RDT
location.

In the above scenario, QEMU assert that the ring is full,
put the packet on the queue, unregister the readable fd
handler of the tap device, waiting the guest to consume
the receive ring. While, guest have nothing to consume
on the receive ring and never update the RDT location,
this makes the network down.

To get around this issue, just mark the overrun if RDH
equals RDT at the end of placing the packet on the ring
buffer for the producer.

This revert commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
in fact but in a kind of different way.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/net/e1000.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 5012b96464..0a7d5843f8 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -126,6 +126,12 @@ struct E1000State_st {
 
     QEMUTimer *flush_queue_timer;
 
+    /*
+     * Indicate that the receive circular buffer queue overrun
+     * the last time hardware produced packets.
+     */
+    bool last_overrun;
+
 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
 #define E1000_FLAG_MAC_BIT 2
 #define E1000_FLAG_TSO_BIT 3
@@ -832,7 +838,7 @@ static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
     int bufs;
     /* Fast-path short packets */
     if (total_size <= s->rxbuf_size) {
-        return s->mac_reg[RDH] != s->mac_reg[RDT];
+        return s->mac_reg[RDH] != s->mac_reg[RDT] || !s->last_overrun;
     }
     if (s->mac_reg[RDH] < s->mac_reg[RDT]) {
         bufs = s->mac_reg[RDT] - s->mac_reg[RDH];
@@ -840,7 +846,12 @@ static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
         bufs = s->mac_reg[RDLEN] /  sizeof(struct e1000_rx_desc) +
             s->mac_reg[RDT] - s->mac_reg[RDH];
     } else {
-        return false;
+        if (s->last_overrun) {
+            return false;
+        }
+
+        /* Receive ring buffer is empty */
+        bufs = s->mac_reg[RDLEN] / sizeof(struct e1000_rx_desc);
     }
     return total_size <= bufs * s->rxbuf_size;
 }
@@ -998,6 +1009,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
     } while (desc_offset < total_size);
 
     e1000x_update_rx_total_stats(s->mac_reg, pkt_type, size, total_size);
+    s->last_overrun = s->mac_reg[RDH] == s->mac_reg[RDT];
 
     n = E1000_ICS_RXT0;
     if ((rdt = s->mac_reg[RDT]) < s->mac_reg[RDH])
-- 
2.27.0


