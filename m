Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F99C35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spdjG-0001cJ-1j; Sat, 14 Sep 2024 21:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdjB-0001Va-Hx
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:07:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdj9-0004Aj-Ur
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:07:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so2559659b3a.2
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726362419; x=1726967219;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IFsY7Jbbc9omILLrT31tgNp0GmY4wuWUF2cGaPcUD9M=;
 b=HC3NfCRD2SsPfbl3G+XetPINPehmnTOOPs6fnMDiV6H6LtPdh3TXLvkVXtwL1Farvr
 jw/XheOfAEap/qANTJ1nh5j8o0QlbXdDP5X8MSqBUnlzw8cBZH7l46NggC9mMToFK2+l
 7uzwk+puHHYOzMvWasbUbRmQglolA4dpL+i3j5kO6NFp4PpHVMIAcm1uASXRXhib2A9Z
 kmwDnp6yP/yLtIGnBqOO+Or/F/BfqPJZOpEK3DxhVGeZHPbMgQWil2/q6JrlxI25RgRk
 Thq/HBqnspQwS1pXuoU8DUIST5b0P1eIp949y/i9d3jQYLp0r9benQrVtSBPe+tLWvuK
 qf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726362419; x=1726967219;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFsY7Jbbc9omILLrT31tgNp0GmY4wuWUF2cGaPcUD9M=;
 b=f9OIvELEUbU7ijSP3XnDg7DVkAQmdk1CfwUBhdGHdSlQ/PaNaIbLLSuL+D1o73MIT3
 P5PxGYa4U4fAtLaUV4UrYrg0yK6d1w1YdB0xbaDi2T23Gl9ea9aNzTJzhz5HCCLOQVL3
 pshfGvH8hXbor+f5eMAqTAOzaxm+po8qI4eumZNDK1rN4vR+DAYbIE1SJI+GGbNrlUQl
 sxUpfn0/ZF42ytX+5SUx61wqCINCQ0YKdScOtqkiW37K1m3iLQOtITIkoQJPPpKDockf
 MC/FqW9Sj1tOMIizQW1BFG3zSAlq5j7hXwV25Z3s3KOSGlbnBQK9VJN4TRfpl0Ah/MBl
 pgbg==
X-Gm-Message-State: AOJu0YybMxBnv3fhHFwfsFDhKp8zbrpXqXAu7F+5ydmsAlCy+0J3mkq1
 il+2bVw7nYDjL+BWfOHqkKUV+9Mb8MDAWNrfuo73PORXN5ZzcpRo5N7mskGQwYI=
X-Google-Smtp-Source: AGHT+IEwCBWBwXztUrVuo8Lx+gZmAjgs+7b3KjaYUYsoHJf4zsyfkri/CEswWJDJkjucmyJipw7oMQ==
X-Received: by 2002:a05:6a20:ac43:b0:1cf:36f2:21e9 with SMTP id
 adf61e73a8af0-1cf76358fdfmr15366816637.32.1726362418537; 
 Sat, 14 Sep 2024 18:06:58 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71944a9759esm1507734b3a.44.2024.09.14.18.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:06:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:06:42 +0900
Subject: [PATCH 4/7] virtio-net: Fix hash reporting when the queue changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-queue-v1-4-b49bd49b926d@daynix.com>
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

virtio_net_process_rss() fills the values used for hash reporting, but
the values used to be thrown away with a recursive function call if
the queue changes after RSS. Avoid the function call to keep the values.

Fixes: a4c960eedcd2 ("virtio-net: Do not write hashes to peer buffer")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3ee1ebd88daa..3753c6aaca83 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1888,10 +1888,10 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
 }
 
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
-                                      size_t size, bool no_rss)
+                                      size_t size)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
-    VirtIONetQueue *q = virtio_net_get_subqueue(nc);
+    VirtIONetQueue *q;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
@@ -1901,11 +1901,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
+    if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
-            NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
-            return virtio_net_receive_rcu(nc2, buf, size, true);
+            nc = qemu_get_subqueue(n->nic, index);
         }
     }
 
@@ -1913,6 +1912,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
+    q = virtio_net_get_subqueue(nc);
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;
@@ -2038,7 +2039,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
 {
     RCU_READ_LOCK_GUARD();
 
-    return virtio_net_receive_rcu(nc, buf, size, false);
+    return virtio_net_receive_rcu(nc, buf, size);
 }
 
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,

-- 
2.46.0


