Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62553C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yXe-0002Ri-FX; Sun, 28 Apr 2024 03:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXa-0002Qn-5L
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:40 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXX-0005T2-Vr
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:37 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so3459727b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287694; x=1714892494;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oHDxHk/VRjGjn6edzP0hNyOsa7tsF+d8bBPi58uVTU8=;
 b=jYfQafHV60mFNw+OAe8m9X0JNBjhOZ7/jpAjNGE5as2SBVlkB/mjH0vl31Jd8FytFa
 fHfQPLGbDAVAweY9mYdSaBPn6vmNPUgXID5MAtuF+s6cx7tw+Df38VZAYV6uQDRkmtrg
 CGRQWa6SJ3LyhW3xFQoei4doErRxuyLleo22i+JWh8ov+V/RPT1DOI/DS/FpaN6YDwlt
 aBrxqIFBmib9xss3xv9oiNu2mNIejjiDUqZ2Lu16lQ2d8G9qutwEAyI6jEOi0b6GU6UF
 ANTmvVCHInm2Wv22QhYQIU/4GbHqUouqwla3boB5N+NHcz+T/jggh5lA52RShHdR7wW8
 hpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287694; x=1714892494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHDxHk/VRjGjn6edzP0hNyOsa7tsF+d8bBPi58uVTU8=;
 b=Fn1ua1IaFNYeMMReLi0IUXfKePrdBchMKhaSRClzt/UGYm0LZTuPGrfoBh1nDz20Db
 hDd2AzwQhUqdLE1Yi+1BtRfmPzh5ol5pBoAWoxvH3Q/yN/QxQJpvVcEZHreejofGqH/m
 FdxEXvyUb+L0EiSdBzisvR4XVcP3u1YKtegGXBK9kpexURL0pjugzYcgzbzZQgtk43cD
 Dz3vqVZHqDUnitgkjH2YxbNkogimdXIowe8KooJcIwgkdWAxR2uo86Q16cO1IK76Zk/H
 y8pNGsyhgvG7bymZ4lhvCjrmaDr+yREhOqiOhlRL7REIRoneHJsTDxxxGUuYuDXn85BH
 wfYQ==
X-Gm-Message-State: AOJu0YzNOH7UACkmAFQyiMXRPnYJEs9XQhn68mZSsrw/nrKFlbSbQWne
 tUUz6AirAI5s9MLdaWOXkYBS1qMJqGy02y6Vjtfa0KuGAq6l7HTd7jx7Upclc8I=
X-Google-Smtp-Source: AGHT+IHV8pKJg1DEtbevyVhX5810J+UdW7Cbr3nr7FBeGsr90PzRqv1hq0XC9xLF9DG+Ji+vYhM1OQ==
X-Received: by 2002:a05:6a00:2384:b0:6e6:f9b6:4b1a with SMTP id
 f4-20020a056a00238400b006e6f9b64b1amr9686315pfc.11.1714287692817; 
 Sun, 28 Apr 2024 00:01:32 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 m4-20020aa78a04000000b006f3e3d9b4f2sm3237019pfa.4.2024.04.28.00.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:53 +0900
Subject: [PATCH v10 10/18] virtio-net: Shrink header byte swapping buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-10-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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

Byte swapping is only performed for the part of header shared with the
legacy standard and the buffer only needs to cover it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ca0fbf7b7654..5aa0527a1921 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -676,11 +676,6 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
 
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
-    /*
-     * Note: when extending the vnet header, please make sure to
-     * change the vnet header copying logic in virtio_net_flush_tx()
-     * as well.
-     */
     if (version_1) {
         n->guest_hdr_len = hash_report ?
             sizeof(struct virtio_net_hdr_v1_hash) :
@@ -2752,7 +2747,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         ssize_t ret;
         unsigned int out_num;
         struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
-        struct virtio_net_hdr_v1_hash vhdr;
+        struct virtio_net_hdr vhdr;
 
         elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
         if (!elem) {
@@ -2769,18 +2764,18 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         }
 
         if (n->needs_vnet_hdr_swap) {
-            if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
-                n->guest_hdr_len) {
+            if (iov_to_buf(out_sg, out_num, 0, &vhdr, sizeof(vhdr)) <
+                sizeof(vhdr)) {
                 virtio_error(vdev, "virtio-net header incorrect");
                 virtqueue_detach_element(q->tx_vq, elem, 0);
                 g_free(elem);
                 return -EINVAL;
             }
-            virtio_net_hdr_swap(vdev, (void *) &vhdr);
+            virtio_net_hdr_swap(vdev, &vhdr);
             sg2[0].iov_base = &vhdr;
-            sg2[0].iov_len = n->guest_hdr_len;
+            sg2[0].iov_len = sizeof(vhdr);
             out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1, out_sg, out_num,
-                               n->guest_hdr_len, -1);
+                               sizeof(vhdr), -1);
             if (out_num == VIRTQUEUE_MAX_SIZE) {
                 goto drop;
             }

-- 
2.44.0


