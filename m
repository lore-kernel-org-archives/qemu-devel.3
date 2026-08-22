Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51ACC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMX-0003uk-Ex; Sat, 22 Aug 2026 17:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMQ-0003je-Mr
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:43 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMP-0000jz-9k
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:42 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso1833780a12.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434480; x=1788039280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UR7W3Pe7W3BhlNp97UTwJZRPRNXtcAGA9dL8kQpcSkw=;
 b=jKJbjLFsy+fFtlU5HoHR/KR9RVKipMqf5PjXS5z5FwogsC7Ek7iJAtLPL111n6+cis
 XGne4PNWnylxKOD49kl2I/vgbeppNgHQBe8ONhIfhPW6NKUsOKFRAt0sDn1EyfjUgrcp
 PDFw+DtHFvPk1FSb/lr2zNFycrLw19HIDpizZtm25VTjkH/KQs1g+pNo8R/Q1aLJpTCb
 fL+upj6Go+RLGXOa5wwiSEigRaKwPT8yz5FXQ7UtdHzS1gWiO96suBjfnmjHlWKzC8x3
 3bduzMzvK4DOFeYxVd1XjQGGQGyIrrxkXlWGjYs5qpL36iZMjrF7kuw1t+Q/Rrjt6qQP
 EGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434480; x=1788039280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UR7W3Pe7W3BhlNp97UTwJZRPRNXtcAGA9dL8kQpcSkw=;
 b=BgvQHgYDkTcD89vyP4KfTwZTRE0Siufm/Lh6X5oMmY2Io+Zqd2WHzkvdZJF4DHV4Xk
 9xR1KVb+a9kV0/ceX41Aa4M74Ea2tO+sAIGoluwds++ATU0TLg1zgxWXNGDU7ONlRdAS
 /R4xWaipQYT7FGmMnT2f+SfbAdSh9/65DqKdnoZuXhY9OTNhyKjPGhCR5WrnCq38vuBw
 wpoe2JlgXJRVh5yRS9CELztqhBpIIPz0ebO+YO7jPP0Y8q/glP91GCtIqHJaboKIye+M
 ZSP4shS7f01SUw4s7GYBowzp8LTR2b/ueXRlMj8utIF2+P3/Bc2LpRnKrNQX22KAXB5/
 BKIQ==
X-Gm-Message-State: AFuF++k5B4GxrqkIvfNfn3RhM++IvmuYrEhgNum/68KshgRK7Fg8qQP4
 pSYNtMf3QMkMo0mYjHJuPEwVzFnJowpxvslmYyRihPwrLGt7VlH/rGW3qHdgis4x/xG1xJ+V
X-Gm-Gg: AR+sD1350Q99OVrFloicnDy6EzLRV39EMQ6qL7CsYMhkFhrZ89ZPqomIDQaPdKE74xT
 EscUfiIO4XEegPPjPCBPiL/rP5Reaxb6lCau9PgH3n4v++Nelvg1Gbcn4wHYmWdqTHk1zslsHzB
 r0IXz/deJZ1wMhUmJ68wmuOPKPzhOjV4rFYl6jRedIIrwWf1khN//lr9v0Fa4Qpz4JTpdTf0GaH
 k9SnjEyJBwNaq7/ul7WklPXPWFDU0cp+RREypmfTeWgtqNq9CtOvigb+Gk3pPVX0mb7uuKejyBO
 JrghYJPrMxwfzFAKAWI14h4sN/03h/TPnSh7ZQACj+CmzkWc+LIqlUIuqpRvZNqdiwN47CjugN7
 Og19cTkHKNsGk1YElS3lQmSnNB4D2blmFt8cezf08RgxpgZy8s/xY77AaqwOs+yhE3TTDrCbnGr
 7JmFdAgOE8ODg52Bg/JbmLyUHoCR56y2UXW1KaHpcc6b5AUW49SMOka1HAh/Rf2tbnHHKiqS6H0
 oqCFocT
X-Received: by 2002:a05:6a20:a111:b0:3c8:e304:99d0 with SMTP id
 adf61e73a8af0-3cd14870281mr24821739637.0.1787434479996; 
 Sat, 22 Aug 2026 14:34:39 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:39 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 10/15] virtio-balloon: Update tracking iothread users with
 holder
Date: Sun, 23 Aug 2026 05:33:33 +0800
Message-ID: <20260822213343.661939-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x534.google.com
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


