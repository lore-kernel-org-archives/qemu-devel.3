Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59854C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Szn-0005tJ-1w; Mon, 07 Sep 2026 02:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szm-0005nU-4r
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szk-00069d-KV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:21 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cace91f112so26032235ad.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763099; x=1789367899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mf9E5O+vpQ3XA+Jie+/p9nC3sGIPSjge6K4hjAZVK9U=;
 b=CnN/ScZqkJbEbr/QT3byAXnuMt8tQPWdjXwHQX7MKCcgNng+U/h5QarB9SXZr93xA7
 GRskhy9roV4K81xu2nhLD1uwYH2F0EOPWikoo8gi51AV3UwUI129wV3RIzzIXQpsAZaa
 VaW4e1W3VaGP/EP6KaIrUCRU2W0T9Uf2wlZXjKGcvoABKII4r2J00hSrI8e2koJgCuSj
 saFrJRB03yANYACVe0ySlLueAPB3gv7ap8LA1p0ckcv978fGiw2/vz3hZj3aItECXq0l
 yb9clhyiTsvKrukWOFXJGlqvh4ePa4mxiy5ARF8hV8j4nDnP+tgcSeW/v98JxwWte7Zs
 yZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763099; x=1789367899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mf9E5O+vpQ3XA+Jie+/p9nC3sGIPSjge6K4hjAZVK9U=;
 b=L8VFf65IV00zQd/TJoTxdPoflm9viWgwIUBwvzConDMO+x+g/DAnMD9C7k5QRuCA5y
 vSjETrXMpB3H5ILhUJZPt3aWWNoaEDGNzGNyLN1XRRsxsDHAWSi3M4g1mvov2Yuq7cB5
 Cm8QX+BXb9e/8cAhfDOipaaVtydme9dEhddQ83pjDW6cU/FQackrQiiBQYUlCpRFvj2q
 YEDXYgpMnfAJp9vZJM7Huw0jlqohKcxIk+lNePY84n5aOP4oZ9N01vZufkZHRTFRGvOX
 ka1YPF86hCUNO/H4W3CnXzWV9xobf3mrG0gAXcOf51K/yQOv3HdB/DNPwbY/NgTPf9Ys
 dHaQ==
X-Gm-Message-State: AFuF++moWAD3JZ3y6QYlresdoxmbIzV6m4C8zWVRy8qEBlMlurbPDuVv
 oT5h0MsUKU0LTQlOcHBXM043PzDGpsahGMXzN06XKP3/upfweN0iRUdDXxHUuNVjj62hug==
X-Gm-Gg: AYBFou1IHjOTCvIdibtk6ul532MaHpLCtVqiyfMvy5cYRERQB3k8E9MhAiUDsB/+gLF
 nWjyZtD7jKUR9VvQ2M7X5kxbgxIk5FSIq0ZSjQGQzVVHkW6eiCSnnE2lNo5W1RK0ecCqazfIxOC
 ww9h3qc2sQDzkxj1/Zo+2Iy9zURJuP6fWs/zoF1n6DWXfLGW3w/9CgRIBZh/6io4kfbcChuIec4
 tzBFaq6L80fLP2mEgTctX0LpbI1cx/qmWdUJ6LFB1rIIX4idQ8OF4c86/o4QmgMsfx+icFIfEyO
 IMqEaRHatIE46ek8wYx1xOi8VOXHouH8cYc7tC40XLEbiU/5edz6Wddfx1KimG4FLUqth7SigzR
 dUKY5LJN6u6x1ZZEzrBtK3A4tGOekkFPYC5OCMW6u8+ggb9TcxUMFITAH1srKhhCHWPZjeaLLsE
 D262t4WbRmAx0Wn31vLsAS3EsnrsPgMGz/xnV+syKHOSs2l+kjp8gppQb/hcyPbXpaFWPWCLP04
 QihJ5ZFJbSAXvgc
X-Received: by 2002:a17:903:3c24:b0:2db:479a:5127 with SMTP id
 d9443c01a7336-2db479a55c8mr89297985ad.19.1788763099063; 
 Sun, 06 Sep 2026 23:38:19 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:38:18 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 09/14] virtio-balloon: Update tracking iothread users with
 holder
Date: Mon,  7 Sep 2026 14:37:20 +0800
Message-ID: <20260907063725.626685-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x631.google.com
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

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/virtio/virtio-balloon.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..7c9c8d2a41 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -892,14 +892,20 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
         precopy_add_notifier(&s->free_page_hint_notify);
 
-        object_ref(OBJECT(s->iothread));
-        s->free_page_bh = aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
-                                             virtio_ballloon_get_free_page_hints, s,
-                                             &dev->mem_reentrancy_guard);
+        s->free_page_bh = aio_bh_new_guarded(
+                      iothread_ref_and_get_aio_context(s->iothread, &io_holder),
+                      virtio_ballloon_get_free_page_hints, s,
+                      &dev->mem_reentrancy_guard);
     }
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
@@ -919,9 +925,15 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         qemu_bh_delete(s->free_page_bh);
-        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
+        iothread_unref_and_put_aio_context(s->iothread, &io_holder);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
-- 
2.43.0


