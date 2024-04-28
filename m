Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7A5C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yXa-0002Ql-4U; Sun, 28 Apr 2024 03:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXV-0002QJ-HB
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXS-0005QO-8b
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:32 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f07de6ab93so3236075b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287689; x=1714892489;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xe74X6FoQm294awHcG8+aJfTJ6SJKDn+2TXhvqpinSY=;
 b=ynqnG3oNMxlrrwkn0DdO3R0ow4pUz7or7PIqUCl1mxuTqOOY2a9DM4Vo+DTQygc/55
 zqpxyZ4PaHACc0TvzxyUnM6oMeeDZEhLJ/VZdBvKNcG8ANetexI+kaPvGoXfTKgXIbJp
 1+9D1wS7QbLzw/e/BpHw+dVNmOCQOWyfCzfMxgamD6uHyncibxn7lBCVjldpJmYlgtfX
 yiW1whzM24wbBs6ntOFLcrJ4ncNWa/OWn7D9gWGRDDhF1Bo6I/gcFad8WjR+7rYVZRd2
 TRqp1kA+pi7U3oXw8zsWGr12+OGmeD4fbgC2807UoXEYuoguvmEMYiayQM0XjmkMyVAg
 9GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287689; x=1714892489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xe74X6FoQm294awHcG8+aJfTJ6SJKDn+2TXhvqpinSY=;
 b=LKBJLfsqhhEWrSZZrvF9WSppxMK3Eelhvl6UYSbKo/IoHUfArIh+CiYsgiG3Ezo6Nf
 zAHgDlipJyTnLdu3L5oq6ej21+7faKGv8ypmqcYEQr9WETGjo+U+AUcaNz7NA2iGR6w7
 xd4uLbAK1f6f1nGz/UQcSi9cZ6ZWnuBklLoSiMZFcywWDGprz5De2NiFMcyxGDRV5P+T
 DbtR2b84aBNcU6VaTpb8ZxtwITdRheH+xEltDEeGvHenwuiD8h6SbKR/vt6CjBFcwy/a
 jl6HzuH8jKheTXNBxzkxrq3iJhnRtxWlaZlMDYrVh+caqC137WDBgskdhTnrTpQFadWC
 3//g==
X-Gm-Message-State: AOJu0Yw8J86YkbVCzbhU1FzYc5jR11wrjfUv8KL2UFWI1zj6SDdT8eJ2
 51p+R/fWQpYHvCKF36xqxlP46QAPrxMZi/ljopCruURkvqoxG5yr1k+sRwFk+IY=
X-Google-Smtp-Source: AGHT+IE+mOzRZmvBArFzR0f/i6GzUUhTlitUeZMz2b7z5CrhWnMtoPRHk8zq/KztI7l7Zduipd+qhA==
X-Received: by 2002:a05:6a21:4995:b0:1a7:64dd:ebe8 with SMTP id
 ax21-20020a056a21499500b001a764ddebe8mr7468787pzc.49.1714287689015; 
 Sun, 28 Apr 2024 00:01:29 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 e10-20020aa7980a000000b006ed38291aebsm17835836pfl.178.2024.04.28.00.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:52 +0900
Subject: [PATCH v10 09/18] virtio-net: Copy header only when necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-9-73cbaa91aeb6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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

The copied header is only used for byte swapping.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e33bdbfd84a5..ca0fbf7b7654 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -360,7 +360,8 @@ static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t status)
          * can't do it, we fallback onto fixing the headers in the core
          * virtio-net code.
          */
-        n->needs_vnet_hdr_swap = virtio_net_set_vnet_endian(vdev, n->nic->ncs,
+        n->needs_vnet_hdr_swap = n->has_vnet_hdr &&
+                                 virtio_net_set_vnet_endian(vdev, n->nic->ncs,
                                                             queue_pairs, true);
     } else if (virtio_net_started(n, vdev->status)) {
         /* After using the device, we need to reset the network backend to
@@ -2767,7 +2768,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
             return -EINVAL;
         }
 
-        if (n->has_vnet_hdr) {
+        if (n->needs_vnet_hdr_swap) {
             if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
@@ -2775,19 +2776,16 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                 g_free(elem);
                 return -EINVAL;
             }
-            if (n->needs_vnet_hdr_swap) {
-                virtio_net_hdr_swap(vdev, (void *) &vhdr);
-                sg2[0].iov_base = &vhdr;
-                sg2[0].iov_len = n->guest_hdr_len;
-                out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
-                                   out_sg, out_num,
-                                   n->guest_hdr_len, -1);
-                if (out_num == VIRTQUEUE_MAX_SIZE) {
-                    goto drop;
-                }
-                out_num += 1;
-                out_sg = sg2;
+            virtio_net_hdr_swap(vdev, (void *) &vhdr);
+            sg2[0].iov_base = &vhdr;
+            sg2[0].iov_len = n->guest_hdr_len;
+            out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1, out_sg, out_num,
+                               n->guest_hdr_len, -1);
+            if (out_num == VIRTQUEUE_MAX_SIZE) {
+                goto drop;
             }
+            out_num += 1;
+            out_sg = sg2;
         }
         /*
          * If host wants to see the guest header as is, we can

-- 
2.44.0


