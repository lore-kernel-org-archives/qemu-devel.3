Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB07C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwY-0005bM-Tn; Sun, 05 Jul 2026 10:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwY-0005b3-32
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwV-0001Q7-TN
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u90+7BA/9+gBWZCPusQaFHx03QikGWcwz/+Bmxojzyc=;
 b=TcFVAXnsu7wMPN9NXNNa2WsWJGOBTrVf0qC7jW+oaXdXPfNYtyRBGPskqUhbeUNGeT2lCi
 D43r3lvNE4qrGG51TPVJWMKglLbtDH4uOwg8VRTLukp/UB8IU8iNWFBf1hl/WWqJ7i9VAn
 9Jl7TpeVJ3q5LcbwZ7fjYHstqoi8awU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-l9_Ou6ijOvyiKLtZjP1MWQ-1; Sun, 05 Jul 2026 10:35:33 -0400
X-MC-Unique: l9_Ou6ijOvyiKLtZjP1MWQ-1
X-Mimecast-MFC-AGG-ID: l9_Ou6ijOvyiKLtZjP1MWQ_1783262132
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46fb9079a04so837815f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262132; x=1783866932; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u90+7BA/9+gBWZCPusQaFHx03QikGWcwz/+Bmxojzyc=;
 b=Da7p81iM1RR+/o1IxcEgcdrHb4s9VpZ5h7PHqPRrLbCc5Y/pGP+H+M/foS5dOZuwKr
 FFMorUSCe9gjGLklGWrIHphXCTRfEydE/MAwZrvrwQmOjJBZATyhwX4YeZWpGZ3ZvW2j
 7hQLlvmgtlGcRzNSz8YhXF6NuGpGQUcvEf3bYM/uJiopDdaPQFVhTRO2KqCMr1jDjfD+
 lxydeX9SquLqIZa3zPFOzO7Ie4JnXH9TUO/DN1qxfzwBa1JpNDURYPE81IhaDHraUJ+r
 f+mLrfZLHjAAWaV/f7W8IEiyACRCxQ9rBUsJmRC3OGBtn6WJBPYsV/XNk7Nrdd/BEk+4
 9+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262132; x=1783866932;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u90+7BA/9+gBWZCPusQaFHx03QikGWcwz/+Bmxojzyc=;
 b=Bk4GjSRrkrxN48pbYo/kXAeA/wdhTXclJEgeedpxG/A233pcp8+zUgo6Iswqi/e0+u
 FQIIzCWYILbUmry/uZr/P90SXG4zEgzw6O9fHoEy7gxZCB8tRVeuaIyuCSF4OgqrG0jA
 RrJb9Do1rXJCmYNHjP53Byfo4gB6ao+A6+1JAPkLpy26Q4s+C0VBiDFFGSUMsMw+bhfA
 fWCTPwZHcMAckl/U/PJz8foFBjhMgvCoCGw8CeinOHLYHUrHH3ldh59URtCQUSYys0zq
 cMukE9UfbvoX5CHizaz4i95QHD0bNs2R7L7BziErsKejHQnCh3ut4DtYD4ULndgzg/eK
 RFgg==
X-Gm-Message-State: AOJu0YzIT+gyD3uRPBfsrrLnFgkvV65/UZXY062sYjZcVnEIDt1hVIIT
 oHtkpVY+GixLA/rOImbQqfp5UsZe1PUXVK9/wf68dNAa7Yz5jg3j89+tw6V6ifzwSK5PukU39I0
 Pw0rT++UE30t1FW1CxyhrhbCfUH7ykV56mGWDXaajqDA1XV/fGvB504lm548yWvm2L9g7js6TeV
 +zn/JgY3YwTN2Sgc59QL39JmdCl4c2yC3uLQ==
X-Gm-Gg: AfdE7cnc3vYznUzvqHXRBoPTuo5+O2s6NSLsc4zIs2D1JHcnc8nIAZ69OTJ0vUqDWGQ
 74/nYcRp54wdCZ0+MOGvMzViTCPKkDhUjMA0VlZ4oaGVgxiab8ZnbRo9cv3l3A+PIkKgjLSZN14
 RmvqHWtgQtZKigpbMbIBBcyuLV8Z1TvRIgiSxZUhzxEHIpsypSxC+118+T6gxSNpDNcZGpvGrer
 B7pyNZtlhjtgt51tRRxaIEG2nmvQBURJdOklC2wWvK/Q+K6j+0P2QXTU2AbyeXlX8gLKNpnvp+D
 KotUUq6JrCwXI4QtZjU4hrIozdffYuuJGxrimxNFxh+aq1XYWOEfO4MGu4ON0r5Ea5EqutjMYSy
 93dkoX7O1mdgLqKnKfeXA+kFPmMmnkGn2
X-Received: by 2002:adf:f3c4:0:b0:465:ba53:a006 with SMTP id
 ffacd0b85a97d-47aacf86305mr5419711f8f.23.1783262131673; 
 Sun, 05 Jul 2026 07:35:31 -0700 (PDT)
X-Received: by 2002:adf:f3c4:0:b0:465:ba53:a006 with SMTP id
 ffacd0b85a97d-47aacf86305mr5419682f8f.23.1783262131104; 
 Sun, 05 Jul 2026 07:35:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b126sm16303035f8f.24.2026.07.05.07.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:30 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 20/44] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
Message-ID: <36b37f8494800ed9c5d4b6ef03924bd1636cb810.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

A malicious guest can craft virtqueue descriptors with arbitrary lengths.
control_out() calls iov_size() on the guest-supplied scatter-gather list
and passes the result directly to g_malloc(), allowing a guest to force
QEMU to attempt multi-gigabyte allocations and crash the host process.

Fix this by copying at most sizeof(struct virtio_console_control) into a
stack-local variable instead of allocating a buffer sized by the guest.
handle_control_message() only accesses the fixed-size id, event, and
value fields, so no data beyond the struct was ever needed.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3585
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260622161144.2883799-1-lvivier@redhat.com>
---
 hw/char/virtio-serial-bus.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index cd234dc6db..c1973f0248 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -344,22 +344,16 @@ void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle)
 }
 
 /* Guest wants to notify us of some event */
-static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
+static void handle_control_message(VirtIOSerial *vser,
+                                   struct virtio_console_control *gcpkt)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vser);
     struct VirtIOSerialPort *port;
     VirtIOSerialPortClass *vsc;
-    struct virtio_console_control cpkt, *gcpkt;
+    struct virtio_console_control cpkt;
     uint8_t *buffer;
     size_t buffer_len;
 
-    gcpkt = buf;
-
-    if (len < sizeof(cpkt)) {
-        /* The guest sent an invalid control packet */
-        return;
-    }
-
     cpkt.event = virtio_lduw_p(vdev, &gcpkt->event);
     cpkt.value = virtio_lduw_p(vdev, &gcpkt->value);
 
@@ -457,41 +451,27 @@ static void control_in(VirtIODevice *vdev, VirtQueue *vq)
 
 static void control_out(VirtIODevice *vdev, VirtQueue *vq)
 {
+    struct virtio_console_control cpkt;
     VirtQueueElement *elem;
     VirtIOSerial *vser;
-    uint8_t *buf;
     size_t len;
 
     vser = VIRTIO_SERIAL(vdev);
 
-    len = 0;
-    buf = NULL;
     for (;;) {
-        size_t cur_len;
-
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
         }
 
-        cur_len = iov_size(elem->out_sg, elem->out_num);
-        /*
-         * Allocate a new buf only if we didn't have one previously or
-         * if the size of the buf differs
-         */
-        if (cur_len > len) {
-            g_free(buf);
-
-            buf = g_malloc(cur_len);
-            len = cur_len;
+        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &cpkt, sizeof(cpkt));
+        if (len == sizeof(cpkt)) {
+            handle_control_message(vser, &cpkt);
         }
-        iov_to_buf(elem->out_sg, elem->out_num, 0, buf, cur_len);
 
-        handle_control_message(vser, buf, cur_len);
         virtqueue_push(vq, elem, 0);
         g_free(elem);
     }
-    g_free(buf);
     virtio_notify(vdev, vq);
 }
 
-- 
MST


