Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8F7CD129A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryX1-0007fj-LQ; Wed, 03 Apr 2024 07:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWp-0007So-4k
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:40 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWn-0007IT-FK
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:38 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so4146830a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142696; x=1712747496;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oHDxHk/VRjGjn6edzP0hNyOsa7tsF+d8bBPi58uVTU8=;
 b=jSO4vaywEAwqgMwQcUtsl66WlLMRpvycxl+nPHciWZ1U3fSA9h2kF1HeyVzb0wydkX
 4JvPN+h+kVCRzpn/cNzjuBMjHuM3Zi1Fgc+Pn3QC3+wjkRdw9Tt+I0BjOjQbzlG0Aunf
 CQW+h98fieT1Mk97L/jBqbgGiQ5X2nWhH8aw0CXYF2qTOMbIL//j/c5sSC5LNcsu6TeS
 7qXTGgF7gbNyFifNL1UeC7jMXIFx+otpFh9Oxg9GsS2FJ/i+kQBUGZ7Z45cLD6onO41U
 /8vGtZH6/LEL6bGc0HMOU1DarYxNYAvohiePVd2VVCgErQpJU8SXOKrErjo/H8RGGvhZ
 WnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142696; x=1712747496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHDxHk/VRjGjn6edzP0hNyOsa7tsF+d8bBPi58uVTU8=;
 b=J+BUf/5UsHaT+x0voIyqhZUndcWpyBw4HAXUppLtBrg84VhBaam2Icvpng1/G7YEg0
 gla1pgPTAMTKFClF4hP8i+Rj1oCQHvOMkXSwpehYUVgnqYBiVsNnGIjX+oIlzTJZan3+
 338Bl+F2WHl217RZKAqXZqAEIzhLhM3McuJ0oHtDaOC9a8c8Zczv9i42gjWc9WNA0t3X
 CFhNbepzaWwnNjmd41ST8c1PJsd1hz2wVvvwpJLBNVi5KKaWcb+vh3aQK+j+GBiDWCFj
 j5LZzFz1X2jkL+MXX6cV4HyB/8gwbnJOjksmBi2cpcCa67J/NSa8adQNm4BDp4/lb/pr
 uGkA==
X-Gm-Message-State: AOJu0YwHvaNjQ8i98yyCoiE2qSpLHwz2F/E7zSeN77Dwc43t/1FMjCwZ
 YnVwa809Yjf2LBFcjVxrngTE/0tkSC5PTeBDH94/g9n3I7f1itfJHAnQOK7egVE=
X-Google-Smtp-Source: AGHT+IFZey6Pi4h8CJZQtJqCdRgCrLPD9GsxeNbS36D5XYixl6TZQ4jRkYhaqdB3kPMA+Tuh0c0ZKg==
X-Received: by 2002:a17:90a:12ce:b0:2a1:f697:7b3f with SMTP id
 b14-20020a17090a12ce00b002a1f6977b3fmr13298974pjg.5.1712142695860; 
 Wed, 03 Apr 2024 04:11:35 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 n20-20020a6563d4000000b005f05c88c149sm10025954pgv.71.2024.04.03.04.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:58 +0900
Subject: [PATCH v9 10/20] virtio-net: Shrink header byte swapping buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-10-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
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


