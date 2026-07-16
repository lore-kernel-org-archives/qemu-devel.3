Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57919C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNJb-0007QE-Jt; Thu, 16 Jul 2026 10:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNI9-0006Tl-Ak
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:32 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNI2-0007Rk-JG
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc73e322dbso81959015ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212934; x=1784817734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TMWKjSKfCkLdRLDphuftQNsCyWQFXmHbwlzRM8NRv8w=;
 b=VrGh4TzBH0Mshr3pzCQY6ZbQbELVkmD/dmyk4VZGjT6IACs/o84exCu7p5tbWk/dFN
 /cUFwG6lDqhSjBnifTDqnKpoO41ChFY4LHHSjjYr1eYl5vqCUffFRuMnp9f1F0pRqDJh
 rSE8vELdwmkdKHbgoG4qSMXuEdLdG4We+rlmtp/6T0rbr2cVL+RhgcgMsDwYfq3JpyL5
 oxHLRhFtzuJtA8dtb2Y77vi3SvIp1sxKIULXTl7UL1Tt16RyTyQ5rSVmVEyoEVbAUGRv
 0+CveGR5aPPtVSutABF7nhwLnVkgZuN/poa+MyetjMkmlhbydPN5Zow5UZ0WRZJ4BRj+
 dhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212934; x=1784817734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TMWKjSKfCkLdRLDphuftQNsCyWQFXmHbwlzRM8NRv8w=;
 b=oOdVSD8k1FiAZT/M3URDrALL5GFSfrh0RKM0Ne/8ANVMUrZEKxN073oc+536I2ARd1
 fSyjvykyeYC2xvPiWybeZvk2Gf3liVDhJdrHRfYqfHajIUrbbJabgjpU+KCLFtZswhK1
 jC/bajnF3bTUkgNvKzi0R6BuwrVCFzQOh51a5ug+T+5KBsLaCfXoowQGN5vm4SY3nQ5z
 EsoS9z4+3m1NCkeSEhjay5dRjRbrIXQ7+KawLFSCvjC48CVhzaoYqoi89xtLZf+8+BV3
 UMTA0oZdILbOXYR5200DNzelUIuKrItczRglo70upPeZ5Ws5MCFRx4frc84KeBlRfbxn
 vZ7Q==
X-Gm-Message-State: AOJu0Yw/+Q2uHy0BE3rOHjx/x+Htdcc+EVz7Wp60iltkPPw6SZbnkdO4
 jMxFwiBDEyZGIEtu3mqs3sroyDCySO5XAUGNyjGk8k+E3Ye00ZdJpQOjSCU1G42jqFI=
X-Gm-Gg: AfdE7clLzmflxwTWUaufCLC2cSkuSSgWegOrpv55w24Zzptu2w2HoRxbJkC4vhrQGmD
 Ve6HFhxsuwpXodFpLWyIYLswhZYzCyjKNge60Zfeo8TeYZih9YbF8/PoAkurCID9x4BjyEIBtQX
 vbdJtRaxd/UMT5lKlUgf8zoY6w7Omolxqx2a8iWUuqH0apYzq4xEpicMywsxNtQFiCuSCVcZtyK
 69GDONh51Dr1ZG66tZERIJQRIYM7DbDrL5fmOCVd+aqXYT14FfDhPahQD3CrmsXRo8/aVTKBZsU
 AroqNXQr2oaFN5uIaKQlq9yCmV87xso/WzlqOMoKPiUI+uDoFhnb+T8PBEFCKGGyb7hIefOYPV5
 oPVmZG5v/cTnfRHfIt++oiEyWFZbb2h5YBNVn97MOOMq7dimW21CdihkOBrkYEBmGxIH3vadByM
 5qZtRO6GQkd7MQ1YQH85JR+sHxeov6aRVqCncfGeTl
X-Received: by 2002:a17:903:8c7:b0:2c8:1f56:9fc5 with SMTP id
 d9443c01a7336-2cf03d93757mr71087935ad.35.1784212934450; 
 Thu, 16 Jul 2026 07:42:14 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.42.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:42:14 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V10 10/15] virtio-balloon: Update tracking iothread users with
 holder
Date: Thu, 16 Jul 2026 22:40:35 +0800
Message-ID: <20260716144043.76414-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/virtio/virtio-balloon.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..e9d023b4ec 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -892,14 +892,20 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+
         qemu_bh_delete(s->free_page_bh);
-        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
+        iothread_put_aio_context(s->iothread, &io_holder);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
-- 
2.49.0


