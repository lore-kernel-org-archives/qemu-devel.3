Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC83CC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gZ-0004Qa-1Z; Thu, 06 Aug 2026 16:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gI-0004Ak-1B
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gD-00052U-KP
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so34047745ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048024; x=1786652824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=siXGvCcgP1Ec19oXDZvBjrP0pURCAyCLQMkuuwkWUhU=;
 b=lyOdzzpHYyKpjo3RJFE+w+KkMYexgjkuw5Tb6kNwJ9p9a3I3lLsGx+4AkcZL9kqtk6
 aP3d+fTzIXKZY/e975umlMSayA6/qh64zzF9Z7MSzL8Jc1u7k4rfTtF8o9z+gvparv5d
 lmmEFLI/IX5DSlWDvPoxH/xoQbl0ZSxCX2o2QEdhlrapM4nl6ACjcb3x03lZR9ihwWIC
 gv683CohmtFHug8cB3PCrkkI1/WECLmhiOf9NrFVpwfufVj3w7DJ5Ja2EglWz4EAJvEc
 A4igse6FEsIS+flAcLa4wxusIWPB25+CC7FUvmOI+zuLq+V5Rsyvy5cfkfhIBtsXp5+P
 eoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048024; x=1786652824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=siXGvCcgP1Ec19oXDZvBjrP0pURCAyCLQMkuuwkWUhU=;
 b=UG/Xe2fumIMTe67pTJBfoQQajqqzJ4+0wk+4ZxwNLoNRqOj+mKQg0GcyzjZaHNDWc3
 n+p+2BeWCho2o0GoEA9XBkCY7tlpM0AQt1/jcc470xiDRzXDstjn22rWYSFiou+ofoMr
 Nfr+pM1nB+cy9dR8GJzBIvZScS9Hv2b8OK5F89vjSm0MVK4/1JxEsX4RP+6Z/2m2ZWKF
 uMNlEEUBiRDrbZl5gAocup0eXACOC+PW//aV96vIQuQWE1I8m6oLMZDgU1lLbekkJQ+f
 s+kZiBT9/7+ID/4d+S+DxURmmFCou9CDpimyh7RcBwRwuOCD2YHJJlDWMXqEAfbNgUTO
 JTCw==
X-Gm-Message-State: AOJu0YxoQuWD4bMyxcHuJXg/JuUWTm5uNjbvKUJ2N+r1mR52ZS5GR8Tj
 7+sKM2qUmWPvP7SqBZcRe347m4ZWwG5t/oWvlr5yftmZiwcNSJ8MgL8Cdi8sckKi+1HS+1Dl
X-Gm-Gg: AR+sD139lYqHS4Ug6QJZoeEwYlv/Dwq8e6j+Kr/gXYbQKkaAKt2Urb1wIHs9GlYbrsv
 DCPklv2Ehe07Bm9AU+T48lw+gwbxFSLNwJoh0Mi/t+1VLdiLcr/NKyX+xixzwYKOi9NETP1uVZr
 E1dJLJxmOpF0ZKUeGBHwJC8y5VTqG9NN6saBHKEVsegbR1tGIYVgoU8p4Art+3Fw0FJHbbMsaO9
 6fZ0fiZXRFX5Tr8yci1gyRQIt51QI/LqzDBsIc+HO3SynWU60wpqhdW+mYJLLyVLvT1u2ET+Jy7
 e0DDUxd3D+DYZC7GoKJFQbbCCEsN1H14zHCXUcFXUlcfj9Aq6UzlQT+/ddlFw9kvt+8qRoMI6vj
 HXgWMyeni/2NotcAWzzAonFZ6iFOFIT1SoRBblAsndRqBmjxkg2aPTVkruQygR18CpN0FLO5fM4
 pBU+IZbG5XG1tnIzKhG9EhZDVJZxwc2D72/7HSL/gHwkn5zK9WB5H7mDj/lTOO7PMI/0T+iFQFN
 GiJUPOmpwLzFg6yjp3rDROgSIuL
X-Received: by 2002:a17:902:e885:b0:2ca:e565:7b15 with SMTP id
 d9443c01a7336-2d0ca7f8a67mr180406275ad.10.1786048024293; 
 Thu, 06 Aug 2026 13:27:04 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:27:03 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 10/15] virtio-balloon: Update tracking iothread users with
 holder
Date: Fri,  7 Aug 2026 04:25:19 +0800
Message-ID: <20260806202531.243806-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62a.google.com
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
2.53.0


