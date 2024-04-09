Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFA8CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruGn6-0003mt-NK; Tue, 09 Apr 2024 15:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adobriyan@gmail.com>)
 id 1ruGmv-0003mW-CD
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:05:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adobriyan@gmail.com>)
 id 1ruGmt-0007ng-Hd
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:05:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-343e7c20686so3306956f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712689542; x=1713294342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IhLPEdtbq6jDpbKbP02h1k6WxT0ukK1avtaorQ2oyrc=;
 b=m3kIzx7VVOTkU5bP+2uWUT3DWc0lfFxCCMK3Zf0viyq7RhMB93ZpIaMCmr68baGZH1
 FG1Inva46OrDqTxZiCXUM5+p9pPaSanChO8U/x1wuMB+37p1EL7Lii9MFgTktR3XiFlN
 SeivWiWpP8x5WYZSvtUEMBgCcwLAYwWWcQ788uMqNIj7BJLJGnoPei2nJ64AeZz0okHj
 GT9u8+vGOmhs0Qc+mGlaHfwHhZRTCtp5GQ2Pk+ocf6AeVgi6QIT7hcol+Y09mO79bsPM
 O5rw+C4Ork/IqI/x1xk6Q5q8dFPXYG+kxhS3JxduSUlnt1w0GHQnLySMocSkPosPwXCX
 qrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712689542; x=1713294342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IhLPEdtbq6jDpbKbP02h1k6WxT0ukK1avtaorQ2oyrc=;
 b=ebPQfMoOQkduHkXkR279GVdV/ha+HSpjXIRLmp8v34CJWCXeHaFwEuQ8nfh2rNIsLW
 wGwoyW/hqLV0XchZBh8ABTL3AYnLg0GjnDpSgABdNuEkDQLbdAEXhoSt/ch6mz+S8ZXu
 r6MrwmvVjqUuGa+2xQd/eFbwZYxRHHx4YUF/a3ujlqfV3XuUzLXPvZ+NjEsESxF+CuRG
 0wvHsunFW7yaER/bmpe976GZyy4iJ+wQ8J1SZT10W4Ys1GGJdPC8FEQrJtWWVwrI9G/a
 WYzqALKXW97fWQqEIyg4wQVKMAkAJ3hy1UyYzbZZnCEMQBBeh8eHR6HAiAIssb2f12Ol
 b3tA==
X-Gm-Message-State: AOJu0Yy1UU/iLBzPYYb5kR4HbzrBiGjArz/MHEqhEkmZwI/I/Td5tA2q
 I48qdtw+Lnv6tJBKKRiLcDBKIDltWOmjclqHNx+VBchUQeBvihCKcGtrKG/gRA==
X-Google-Smtp-Source: AGHT+IHaVvcmkQnuNnl583wHjEWc+goP/J7wmxjuouFLoiDTftLWI+vMjnckjt1Q0WTl50rCaj+OgQ==
X-Received: by 2002:a05:6000:1743:b0:345:bbf8:5587 with SMTP id
 m3-20020a056000174300b00345bbf85587mr396264wrf.8.1712689541680; 
 Tue, 09 Apr 2024 12:05:41 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.134])
 by smtp.gmail.com with ESMTPSA id
 j11-20020adff54b000000b003433bf6651dsm11378044wrp.75.2024.04.09.12.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:05:41 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: qemu-devel@nongnu.org
Cc: adobriyan@gmail.com, adobriyan@yandex-team.ru, mst@redhat.com,
 jasowang@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH 1/1] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem); "
Date: Tue,  9 Apr 2024 22:05:22 +0300
Message-ID: <20240409190522.101658-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=adobriyan@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
creates small packet (1 segment, len=10 == n->guest_hdr_len),
destroys queue.

"if (n->host_hdr_len != n->guest_hdr_len)" is triggered. There is
nothing after guest header, if body creates zero length/zero segment packet.

qemu_sendv_packet_async() tries to send it.

Packet is discarded inside net_slirp_receive() which returns number of
sent bytes which is 0.

0 is propagated upwards and is interpreted as "zero bytes has been sent"
which is terrible because queue is being destroyed, nobody is waiting
for TX to complete, TX complete hook is _not_ called and
assert(async_tx.elem) is eventually triggered.

The fix is to discard such phantom packets in virtio_net_flush_tx().

Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
---
 hw/net/virtio-net.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 58014a92ad..e156f1d78c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2765,18 +2765,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         out_sg = elem->out_sg;
         if (out_num < 1) {
             virtio_error(vdev, "virtio-net header not in first element");
-            virtqueue_detach_element(q->tx_vq, elem, 0);
-            g_free(elem);
-            return -EINVAL;
+            goto detach;
         }
 
         if (n->has_vnet_hdr) {
             if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
-                virtqueue_detach_element(q->tx_vq, elem, 0);
-                g_free(elem);
-                return -EINVAL;
+                goto detach;
             }
             if (n->needs_vnet_hdr_swap) {
                 virtio_net_hdr_swap(vdev, (void *) &vhdr);
@@ -2807,6 +2803,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                              n->guest_hdr_len, -1);
             out_num = sg_num;
             out_sg = sg;
+
+            if (out_num < 1) {
+                virtio_error(vdev, "virtio-net nothing to send");
+                goto detach;
+            }
         }
 
         ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
@@ -2827,6 +2828,11 @@ drop:
         }
     }
     return num_packets;
+
+detach:
+    virtqueue_detach_element(q->tx_vq, elem, 0);
+    g_free(elem);
+    return -EINVAL;
 }
 
 static void virtio_net_tx_timer(void *opaque);
-- 
2.43.0


