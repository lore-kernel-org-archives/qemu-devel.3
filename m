Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4404FC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPmr-0006LZ-4e; Thu, 16 Jul 2026 13:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmn-00065Z-4k
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:13 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPml-0000VJ-DC
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:12 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c9fe3c9bd5fso431755a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222530; x=1784827330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TMWKjSKfCkLdRLDphuftQNsCyWQFXmHbwlzRM8NRv8w=;
 b=E9dS8IH5xNFT9xFFg/Zah9hOp9wICM0GQbJLUrek43GCEk6lFI5dqlZ2+p++luKFKG
 PK+yiFc0yMrgbv3jcT27qECudwu6F2CYtihyXwzzefI1UgLsm0fXNyHx3qVgSjJJ6G3Q
 fE/8vPucWqPf4MHZFomO5yxknVm4Ru5sksrUrr/mCTLW44GQutkT1oHfFLpTlhUNw5D0
 ITgFAUb6KD8AQdaN1vaWLm1lZeI7wXhXuvhgtQwP5mP+S6IZIIb7KKYdB4XodVPu/Aa2
 l30ruj0x0FMu4eE0FK9sqDzfn+/2P8zYhBvc/f4ui/nS8UfgJ4YsfjX2sS+ZHzpphZw3
 q/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222530; x=1784827330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TMWKjSKfCkLdRLDphuftQNsCyWQFXmHbwlzRM8NRv8w=;
 b=MIy29NuOARjyz6/O6zfWZWC/SlXYEQZTijZOL4ta9MLVe6X4Ih4YV1UnoIcKQi5Igx
 /o/oxp/yYSxO0ru/ROwHTTh/UUDyE6+ubTO1A3bXuTfg5Kdypht4VgIxlYyXWCmA0yse
 Qks1zm/dVmjPGWU2MlR7JPZnxhht++6/p+ygRneJ3Qpqeb0VO2hDcp7VyIqxaSNlsh8J
 3l+d2olJpg+yxwuVRwq/xYUg5PSDGqouU04wHNgSTYcbwuqZb48Ygkv8rNCMCCmJWYp/
 XMfPKTc3dSupjUGHwawIBluJHkomPVVjdwlvb2fysPWzAEiHufTqYxeLYNramenFfwNQ
 hltQ==
X-Gm-Message-State: AOJu0Yw9Zk40YJtI8sx/GgI5EL5izYZLKMDXOL91ciNCb65QFkMRQ4Ny
 R8GSyF72agJ1XwJIlM6mV4nOYDh52maKzeaDPDWg0mNqTVJsueJPqA4zgtLFN47Y3BE=
X-Gm-Gg: AfdE7cm30LLaZlwTyMkj5KKRQp55k5s4pLMXL5dQbTHpNuNteVqIhUHkiWH3bWSbwaS
 jKP8u5v8jdjJquY9TGp33Binp7PGQJ6rmCya2lmKTnVghMBHQrjoUwkfXA1d4cVk4IUZ3avnUHU
 vE9TlZaEoYs2oUYhh+nkiczF0GioISnkwBH9Pe1+BKBip2Xv4WAWoHdoO+Sogh41O8n92u+yXfa
 M3KSoJma37ttahi9Hwrdn2nXBK393yFbM8y1g5itlW7iTxeGwTStKSciY1hHIyQD7WwYE5dcn8u
 7GoxyuMpkj5tSy4NisRhbBFDCnRF38yYurpfuogahSgbhKR7bAc23XXHdgDtTbsnfYze+2sMo5s
 5hE+DWQ5Qb7+mx4dbl5c+9uhRQNHqbRe0Y0cSAl9NKtwnIOr3+CWrx6j9WKAtaYWpwlsRZSawNs
 2dTpRxYg59VlfLeV79UOhPUWXKlPZB5Q==
X-Received: by 2002:a05:6a21:710f:b0:3bd:1cfc:1b9b with SMTP id
 adf61e73a8af0-3c38d90b038mr4351191637.10.1784222529965; 
 Thu, 16 Jul 2026 10:22:09 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:22:09 -0700 (PDT)
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
Subject: [RESEND PATCH V10 10/15] virtio-balloon: Update tracking iothread
 users with holder
Date: Fri, 17 Jul 2026 01:20:51 +0800
Message-ID: <20260716172108.87700-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52c.google.com
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


