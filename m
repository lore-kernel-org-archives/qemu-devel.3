Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF218C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yB0-0006jQ-Pq; Fri, 11 Sep 2026 06:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAo-0006XD-5V
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:00 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAm-0007If-Fp
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:57 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so722262a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121275; x=1789726075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mf9E5O+vpQ3XA+Jie+/p9nC3sGIPSjge6K4hjAZVK9U=;
 b=Bp+Yd8uU0kf3mJ/rIrfSv+2lqpAHPx+U1xgvDliCTS3mostrNBGor7AsfVqLgRipwJ
 WfoNxMYMz7VEbuDNX24Pu2+MwphDMF8IacPBU73DNDDcX4NCeICDbNlfGRz3CBI9G4hy
 XczpzbPnF8J4BdgPkfWLi7Z4/B8pehJlOYRF0DwkwWjxuI99Qg7eFnpUy96Lc8z7BJSK
 hZ1JgWsmOkDUqLMB0kf/N1c79i+bi2KAJHYZgfz1KZ3xzL9vPItiZ8JY+82yIfCbe3lt
 kMmy5sQqY633vDjT+Sje1On77HX4Kg6eP48PqoBm7rcQkbjXN2C3Os595OShshvH3BHj
 495A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121275; x=1789726075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mf9E5O+vpQ3XA+Jie+/p9nC3sGIPSjge6K4hjAZVK9U=;
 b=W5C5I1zetYQv2ZHJAutTybkzxxRU/KpBcv7QhcILIXdRKVun646ztj9l7fapWX+0v4
 wl7Yk1Mk4UCiF4Ny7hc96edjupzLAbb1LF3ZBY4T5bf5h0AslqEalhu0I+Sw8uoSiNcB
 kiacSoJU53KqBuEy7nB6pdSAOwexZh3ItF7uqaZmdzTu/Q06HFnZ5Nbc6IzNGFPAcyfE
 4FPBm3Jxg+mLxmAhcUzmFiWHFTtvLN4141ggfHrgdOypQuAXDOmfcXhAUFdACUIR4MXP
 eucyYTOopIeIYhtZitm2RQAJ2uo4UKubLo+mPMUkuR6v/dm+2YiAArqFFJ8ZfhBrEZIp
 Y4NA==
X-Gm-Message-State: AFuF++m9ee22DL9myvjAaLzteFrMTzgtNe7yXUdhzBAJiS/etilzYKh7
 2gWlygkcST2SmbAaLj/E/F9JL5I6JFjH8ls9IZD9ufQDNiOPj84LpBIbcBAEabj6f0g=
X-Gm-Gg: AYBFou1T24PcJiuV2KdGzW3v8WL3eSfFOHnO0MGHTY9QOdD/KU+cFdQP4EyBXsu8JLK
 F3rzHyE9++RT6/NL3+NbEmiaaO5CJTa3f02M/e7jrF9GFjJSxmQJEUAKE+CJheipY810q6we5Bx
 449JdbFa6W2BceHg8LEQL5ImDQou9Q9GVb2H8RMpc7Bl4JtiSLN1cAG0uS8Nlvon/MPQL/n6P/r
 vM2pw4Jg0o2H6KV7hgPmwL8Qp2qTmzCYJBpn0HeQFC5BpJPEIpPILhFKLtV7kRV0WS2yK25O4pN
 z5ut39ec3IBQV7zHHQy1b0hnMK6ld8s95Gl7DXz7UvlWAcYSK1EC/PeJnAqg0RPiZ5WBaaiIb4o
 qUNkAeSMfp1t7Ym/3wui9gUd6tjgfUG+F+1WJDBAodoeERrsPZGQx1jVKmmTw35QbUwnDkvlanh
 qsP0T3rKUmpOp2pgCIkuazSB7HB/yx0/TOTHkOB1RmpqCPK/2mtzrDHFVtAWcpeYNdbFWc4o/FH
 CQwxmfeyyAdKVTCn9f+pK9wRWw=
X-Received: by 2002:a17:90b:2b50:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-39d9c1c199dmr5907522a91.14.1789121275020; 
 Fri, 11 Sep 2026 03:07:55 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:07:54 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 08/13] virtio-balloon: Update tracking iothread users with
 holder
Date: Fri, 11 Sep 2026 18:07:04 +0800
Message-ID: <20260911100709.726366-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1030.google.com
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


