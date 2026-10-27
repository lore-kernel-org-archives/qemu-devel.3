Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D0606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fBOUXM1o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlFv-0006o2-9S; Tue, 27 Oct 2026 13:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFq-0006n3-Rt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFo-0000in-Ji
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so105055f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793123191; x=1793727991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zq2Sa/uOqbcY5SjiEhkMQu9ePszRZfI1ZosMKgXKR+A=;
 b=fBOUXM1o332PeEFn3XW58bvynknQg7/3cwYrTdqbB+wkbjnisV2jbsU3QtzUlWMHbL
 vFwyxnoSe6gl5ttNk/GG0W6qdEwIFExlxi6dHGIFyeQunsQ9WmsBBGJhFwo7IUwDVEWa
 CHoKjbI712v9+E9Hzqq8bIo6pwXZiK04wpSORydLbPc+UARQ6iUR0qxmMWwZD/zfp+SO
 DFhcK/VVrsDmwlv1/09Jo283yxSsMMbPZERslFm7tJy2s6jquhcVpaFSLPqE51QWcJ8R
 YlV/otn8CDjEZ9LVNcrTwUvAk5OJ0RHl2lTzeOW7RG3vhbOaw34O+A6lahgcQJz9y+90
 rxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123191; x=1793727991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zq2Sa/uOqbcY5SjiEhkMQu9ePszRZfI1ZosMKgXKR+A=;
 b=v3tWq3CD/irpIfQc0W3EgYF9lMsVxzTjITAbWV9ai++6upvojOR9wWAmYZ/ZyvRk96
 QhiEur1Sa6BSZpvDGBTQwvSUBcgOghnK/PjCgHqTbADg2UdsVeJQKSh9H+VYbs7h1FCi
 562TWCoYSG1Rz0XrEg3pX1VY+I8bk4x4Op8CbqB4wXIvKRV8g60tDhGw8LxldWxHjVEV
 HoJq3BbZ2gr/2DPBfMUGwIE9n9T+OVtmNnYOdCNWr50OOmxHgp66ob9qdmscAhQWGhoE
 G+bx8flzskzE3ADwl1vQdD2oM2AiKrX8yostfgEZq95NPTtR54YuGWVzJYGEC1o59F2I
 iwuQ==
X-Gm-Message-State: AFq9FYI6LA62RFT4Vtud9Xvkx+KktneuUlBFEdgOzO5WVOdQDot2lpM4
 JfloBoy7eD5WvSdknbJV0ZWiaf51N8kB9hTkurRJgwpXjV3PtpY3dF0wAqW+hwR5avIgGqpO2ID
 rcQe++EM=
X-Gm-Gg: AYBFou0Co+9X3UiCYJjZR0g+9bo5akE7His/WH5iIRxAa1o0qXUxhtyEcg6U7as5mSx
 J0nmSccyWDRVcXm4wBg74mb4VVHbsIgu9inVaaPRWM/MJjBC5c1SlfsrAKz56M/bQo8kJmcVmIi
 wjKjKGr1gdRQq1rnxm4DMCYpMlmWnRMA6glyTmDbZ4GJDqVYIHOTas/eBjZy9XFeCBcvNUloDIT
 cFu82WMQUPvr2b+SuOcXHAW+4LR6KMJdLtspLTrU20iarAGCGTdFDuZ954VWMeLL5K+DWmg8VYi
 KGEc+Bs0mOsL5tA6zuCeAWX7omDykVn8z7MxMVglbfSeVzj2xgr4MVMhFGEQmL7dVh0T8mb9yFg
 SPN3RgT5pk2NBZnQ3bQSVHhe4ZwASITpXOMUayLonuaU92pQWck141NFH6RqJWiM1u+pfMb4oNE
 KwW4ROkrKGAW+XbV8qLmcK8BrLNg21nCrys40GcuyDNjQGj+PyO5ZnkQYRTCwOSMlNHRIS28+Jv
 OsxcliIFhKchk4mPSbuJXeUB5N/07ozlz+9MotdARaeVSns+6tHZhe30NpLfQwZ6dRtzulU+FST
 tewi1zvF3sEaY3wxoUwtjLyqBPAwjR3wadl/oG9qqWP+x2skMzxWuE1uH95J
X-Received: by 2002:a05:600c:3f0f:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4a35acafb3fmr186104355e9.25.1793123190972; 
 Tue, 27 Oct 2026 10:46:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92b8812c5sm5518875e9.10.2026.10.27.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:46:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 3/4] net: Pad short packets in qemu_send_packet and
 qemu_sendv_packet
Date: Tue, 27 Oct 2026 17:46:24 +0000
Message-ID: <20261027174625.4025878-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027174625.4025878-1-peter.maydell@linaro.org>
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Now that we can rely on do_not_pad being correct for all
NetClientInfo structs, we can pad short packets in the
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
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2362
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/net/eth.h | 22 ++++++++++++++++++++++
 net/eth.c         | 18 ++++++++++++++++++
 net/net.c         | 22 ++++++++++++++++++++++
 3 files changed, 62 insertions(+)

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
index 1042a9d3a8e..408871d3c21 100644
--- a/net/net.c
+++ b/net/net.c
@@ -735,6 +735,8 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
 {
     NetQueue *queue;
     int ret;
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz = sizeof(min_pkt);
 
 #ifdef DEBUG_NET
     printf("qemu_send_packet_async:\n");
@@ -745,6 +747,13 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
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
@@ -899,6 +908,19 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender,
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
-- 
2.43.0


