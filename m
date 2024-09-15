Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1857C35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spdjL-0001k8-GW; Sat, 14 Sep 2024 21:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdjI-0001dg-OK
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:07:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdjH-0004B2-0O
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:07:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20688fbaeafso24335925ad.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726362425; x=1726967225;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J4Fnc5bH9flclvZDSpxfqeUlOOXGOpttlfvN0QJF38M=;
 b=bgJDcfstcihiVU6eQQ8PLfut5KTSJv5QFpvSvlcUcWrfQb7NWGlb74OEi0+3vgCHkj
 Z4/NWgHRiFcHGBzx2gZfRtMWhRlSZM4nrJiNAa2kw+kHHNhvdo54QWH/CiMRaHPhOhbw
 FI12x4X7X8lsz4p/mTuMprvrEsnNAVhYEch7k6Qzgf4kKBLqtBk/JJsm9W9tusLrZe9L
 5cSyeDTzI9hvpKg2Oz7QRSyu0y9Dr2Nn8/rTOx7F1DzFd6KY1KehUeoSb9uIpaMwiUrT
 3afWHagtOddGCM/nnECoPt/BTAtr4FOXGqad/XShjo4RB4OLxnJ9ukFmt6UOmUJaghrs
 zSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726362425; x=1726967225;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4Fnc5bH9flclvZDSpxfqeUlOOXGOpttlfvN0QJF38M=;
 b=GsCp12UK+4xngop01S7oh/8BgJgJqDtSodrWc4cRMVdvFlH5wX/4IvAykWTIzCE/jT
 CpCuMxpJsEy/4I5nDqtyp6FJaKOBRg9Z/9h+GrZUQ+wWUqs80oL7q6EmFpZSvv92Z1Q4
 JtXVQ5fhKLsQvfAHPlh+/mWdJDHWl8UGhYOAsKtgmuV9soXwLXBscLPdCZMJ/0QBcOjS
 j5pAumKYQ4x70GJQykOxp+niVkuPkS2/36Yo2FXKidfCuxbebAeRBSchl8zzpEdQYdL2
 mwRRVAoXjQD5vyPw4Oq0kg2r307JBYg3I3B5Iw0w0RTlC5IWM9ynFHa0DBjoSgAchR3q
 Vslw==
X-Gm-Message-State: AOJu0Yw/j1uKQxeN6Q/dnfMerT5psIGxBP831zaCD0Qb+4YvoWwHJ8r3
 ksUr7qn+AvlmKdcFbHFKRODbjowRWF30fFHoM3hybWxwYUJ529C6zhPLr+4L5v8=
X-Google-Smtp-Source: AGHT+IFrVe47jm7gM/HMmMgsQkOB4+I/6M9uYczyr5Qzbx3rzSmV/5WZ2a3wCytqzCcCnFj8A4iN5A==
X-Received: by 2002:a17:902:e54e:b0:1fd:791d:1437 with SMTP id
 d9443c01a7336-20781b476efmr114581055ad.6.1726362425077; 
 Sat, 14 Sep 2024 18:07:05 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2079470eba6sm14662085ad.192.2024.09.14.18.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:07:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:06:44 +0900
Subject: [PATCH 6/7] virtio-net: Copy received header to buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-queue-v1-6-b49bd49b926d@daynix.com>
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

receive_header() used to cast the const qualifier of the pointer to the
received packet away to modify the header. Avoid this by copying the
received header to buffer.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 85 +++++++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3fc1d10cb9e0..ca4e22344f78 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1685,41 +1685,44 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
  * cache.
  */
 static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
-                                        uint8_t *buf, size_t size)
+                                        size_t *hdr_len, const uint8_t *buf,
+                                        size_t buf_size, size_t *buf_offset)
 {
     size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
                        sizeof(struct udp_header);
 
+    buf += *buf_offset;
+    buf_size -= *buf_offset;
+
     if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
-        (size >= csum_size && size < 1500) && /* normal sized MTU */
+        (buf_size >= csum_size && buf_size < 1500) && /* normal sized MTU */
         (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
         (buf[23] == 17) && /* ip.protocol == UDP */
         (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
-        net_checksum_calculate(buf, size, CSUM_UDP);
+        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
+        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSUM_UDP);
         hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
+        *hdr_len += csum_size;
+        *buf_offset += csum_size;
     }
 }
 
-static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
-                           const void *buf, size_t size)
+static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
+                             const void *buf, size_t buf_size,
+                             size_t *buf_offset)
 {
-    if (n->has_vnet_hdr) {
-        /* FIXME this cast is evil */
-        void *wbuf = (void *)buf;
-        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
-                                    size - n->host_hdr_len);
+    size_t hdr_len = n->guest_hdr_len;
 
-        if (n->needs_vnet_hdr_swap) {
-            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
-        }
-        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
-    } else {
-        struct virtio_net_hdr hdr = {
-            .flags = 0,
-            .gso_type = VIRTIO_NET_HDR_GSO_NONE
-        };
-        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
+    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
+
+    *buf_offset = n->host_hdr_len;
+    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset);
+
+    if (n->needs_vnet_hdr_swap) {
+        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
     }
+
+    return hdr_len;
 }
 
 static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
@@ -1887,6 +1890,13 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     return (index == new_index) ? -1 : new_index;
 }
 
+typedef struct Header {
+    struct virtio_net_hdr_v1_hash virtio_net;
+    struct eth_header eth;
+    struct ip_header ip;
+    struct udp_header udp;
+} Header;
+
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                                       size_t size)
 {
@@ -1896,15 +1906,15 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
     struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
-    struct virtio_net_hdr_v1_hash extra_hdr;
+    Header hdr;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    memset(&extra_hdr, 0, sizeof(extra_hdr));
+    memset(&hdr.virtio_net, 0, sizeof(hdr.virtio_net));
 
     if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
-        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
+        int index = virtio_net_process_rss(nc, buf, size, &hdr.virtio_net);
         if (index >= 0) {
             nc = qemu_get_subqueue(n->nic, index);
         }
@@ -1969,21 +1979,18 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             if (n->mergeable_rx_bufs) {
                 mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
                                     sg, elem->in_num,
-                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
-                                    sizeof(extra_hdr.hdr.num_buffers));
+                                    offsetof(typeof(hdr),
+                                             virtio_net.hdr.num_buffers),
+                                    sizeof(hdr.virtio_net.hdr.num_buffers));
             }
 
-            receive_header(n, sg, elem->in_num, buf, size);
-            if (n->rss_data.populate_hash) {
-                offset = offsetof(typeof(extra_hdr), hash_value);
-                iov_from_buf(sg, elem->in_num, offset,
-                             (char *)&extra_hdr + offset,
-                             sizeof(extra_hdr.hash_value) +
-                             sizeof(extra_hdr.hash_report));
-            }
-            offset = n->host_hdr_len;
-            total += n->guest_hdr_len;
-            guest_offset = n->guest_hdr_len;
+            guest_offset = n->has_vnet_hdr ?
+                           receive_header(n, (struct virtio_net_hdr *)&hdr,
+                                          buf, size, &offset) :
+                           n->guest_hdr_len;
+
+            iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);
+            total += guest_offset;
         } else {
             guest_offset = 0;
         }
@@ -2009,11 +2016,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (mhdr_cnt) {
-        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
+        virtio_stw_p(vdev, &hdr.virtio_net.hdr.num_buffers, i);
         iov_from_buf(mhdr_sg, mhdr_cnt,
                      0,
-                     &extra_hdr.hdr.num_buffers,
-                     sizeof extra_hdr.hdr.num_buffers);
+                     &hdr.virtio_net.hdr.num_buffers,
+                     sizeof hdr.virtio_net.hdr.num_buffers);
     }
 
     for (j = 0; j < i; j++) {

-- 
2.46.0


