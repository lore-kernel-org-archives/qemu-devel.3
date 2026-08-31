Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E342C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14SL-0002jT-6q; Mon, 31 Aug 2026 12:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SF-0002Yt-9f
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SD-0001eZ-Pq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:51 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so32631755ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192108; x=1788796908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UR7W3Pe7W3BhlNp97UTwJZRPRNXtcAGA9dL8kQpcSkw=;
 b=IXbi5VG6OUgQQMsJwq5ISo4zfo0+HpbW/QILfGrLHPHIKjP+ZPhmPG3xVW08wswfyX
 4raIbcfiX1YgcLfOfMd5kXd1mrDbF/WS6yZ/5OvQ0h7w3m0o81539hO8hOQy9n5lR00f
 BxwCPUGvX1dlMB2r/dxLu0+yckD9kjVmcX+FgPCyWYzxMDEWVvuErX3iaQ45jlAF35Sa
 0ul/1Lqk0jDDw4QTMDJaNPxHeMyEQUUsFNWD6hR0xK2bNOSVrt4OOw1QiU5DVUBRvMHB
 SCfMvncGe/G7Rh6Y2vuNPSu7V1pWgCKYQqwEVfKCe4HuaENZ98sBMd9Z/gcAZFFVu0Jq
 fpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192108; x=1788796908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UR7W3Pe7W3BhlNp97UTwJZRPRNXtcAGA9dL8kQpcSkw=;
 b=mKwTWvn/j9Li2ld74i5gMOVOdYy7FLZtoLKrnSPMMr+IrQ8F7oAmD1OpHsHTWnbejx
 zFxNGrQAcQjWvf4kluViZ45BsV9Yx7zFDrF6PbMDFDdJszCSKuM5xrwJOyQixi06a5zJ
 W6dudzhsh0tMBrOOTMEAI4jtcBrgAydxNXSOYAi1LwI8bi2JiRu1jpsnM3z5S+rVok0W
 atjawbBHxKU4jKXYOgSMck8NR3Tz96oFZ/2a4Ww+cCRZGelYeTtYhxPPHUD/Vee+scjU
 f0hQZZzGUoVpRWaVqh8r2LjLC4DArGhpZAIWJLVcWO+0VeLsfaHqj1J/L4jVjdBicn8V
 wGrw==
X-Gm-Message-State: AFuF++lVbkR04h76nvWGYKb3+ZQZe3Ul2ov3bOSKupLU59a3JpUfnKvy
 1EB2shJl4vpHygvtDQEISknkd0vQLgqlIXBfnUwXaeGXkJwDc98x3m12i6h0AKShpBKxwcaY
X-Gm-Gg: AYBFou3/+WZIpcZ6LGpwzAM8qZQKzAxv2Gj/uf+qezblU6SeNuv0H9kmZS9N8lWzBsV
 40eUyuBfd5hA1489k5VbNMHJDD+uNtxTXwAyQoD4RRfaM8NeGyDcmHLN25qB4+eyTrYqggjDbkP
 AL+dduaBPoKljG8jrl4vs/Y1DfimGo/putldl+RlSBCqEs8FbSQFU4gU7+7tGOpOUMKoZ5YQXss
 cI5JtXCmG3zoWhmvyIQcGHjKhKH/Rp1ajaWqUxa9xVoVHFFGoTJO62rx2SPCa7yPEpgAmpbuX4r
 tHtQcVE+enVK976n5PW0AIAXVLa3JOXCbcW5eMLBgpe9FEL1WLn8M6zbPDa4iIylukxh36ZL9ZR
 qrTQXP/qE3hLGXmoc3E6XkqVknj5VlE3m9Zy4RtjnY6v5lvIr41B4BbF7ctJFfYFKba5CfGHRYu
 VHQSychu6vRvJiJby/TP478XnV6fJNeXT3zAEWPt3miXov/nHbweXAJ6UqW809xBcdq9qkf5gDA
 zbsHxAk42d8HYDuG3rW
X-Received: by 2002:a17:902:f786:b0:2d8:d4ce:7e3d with SMTP id
 d9443c01a7336-2d8d4ce836bmr299993485ad.18.1788192108124; 
 Mon, 31 Aug 2026 09:01:48 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:01:46 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 10/15] virtio-balloon: Update tracking iothread users with
 holder
Date: Tue,  1 Sep 2026 00:00:31 +0800
Message-ID: <20260831160038.221776-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.55.0


