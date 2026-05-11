Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48E7CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHW-0002kT-K4; Mon, 11 May 2026 10:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGG-0000qM-Bt
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG8-0007Ih-3o
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:25 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2bcd730e090so5704255ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508322; x=1779113122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23F2qkNukByaUJQk9pbl2bbnzE/ZXLLhOxWd32Zs67g=;
 b=DhfEXw3R7kjiveTG+QBsn6IqpHPzvHPYcdPHS721FGgA18WQ3vv2F5gOIEDFRXz7ne
 IEios4SJ/RwGLc4hBCO90tdcqRRsLWK7+Msu9cCD/hn1ZettEKEbWCkWndlM78R6xhhU
 a7gNrigq5ST47dl1b/9gxwkCRzA2CThWe7TcLjW05hWbSlHFdwRA5leFQwOmA0+XMMVt
 O+g/RtjxqbjzQ05JPsyrBOyU58IWHrAsZnzF1SwwgZk3TU5qsSxSwxvNUZ3+GyPGOKAS
 LbXi4FDQJ/5iaBPJNzW/0Ut3wEWreq7e9+g4gFev6wxMN3tR0uRR+yShvAngduW0lPxr
 Pkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508322; x=1779113122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23F2qkNukByaUJQk9pbl2bbnzE/ZXLLhOxWd32Zs67g=;
 b=eg1+EadCqH6XOa+iEnOCXYOojWc4xZGI2cKW291BddvVij/5dZU/w9iL914n22cehV
 PmDnVJsykngsHEy9STuTfALBOABv+eVLl0dc2a36UJFhiMrIS6VlLn/N56WLUF9exFON
 2aPAgtOc1XcUWcacvUG18QkiMFG4D7GEtDvziUIoZ5igIxcVICwrwZdaFdh0ehB2Nz4a
 V5OqNM7VK2YDznCJv3g+RZxhDG/kb4PC6Xu75i2Jt/KbpKs7eDzYBLlfDwXm0mR6QZWd
 zY8y5tiIYPEALEfpQtJWqqXANbrXIbPx+FCBFVOM3WS2jwR+BEQakTFP5BkJdyElshPP
 SGTg==
X-Gm-Message-State: AOJu0YzwAlPi+45LIUtiJq+qUAQmy0bMofHkZ7wE0TMLVird0mKDAWOm
 P+XyejIGKZG/vHwRDnfEYKfFa9kmK/gAkRS3JwmkMtJvPykg9LPixc/t4r5t/x4v5Hc=
X-Gm-Gg: Acq92OFTJ6ui2ppaZ/UIr0Yg1mGS+BNcQdwvVRR4XTNtZOXdAx+QTCOuM6GhZTnLehf
 Idd56Uukb8mO2v0jGoPVljZq+hPB6FhskwkJD9KGHeG/fDYw0j6vRGbAxvp7oc5SxTo+wO7KEPt
 Pkuxmk8iGfFeFG2bFkUc5GL0ongaJiiWhoNa0nmAUhpciHi7g291rYJq9U6gSUtPMsnjpc89kj1
 Hln5AI+wUBxrnefaq85U/mxoegItZn+sN0KJAHoTPS+dC5sYfNamw87ay1ZvzVddRq+FvlYJrsb
 0zevwh1jOYHeAENVnpRJnCxcQ7yGVdN858QztVMK+TqIqGWNkWQiD9UaeN6dIbJuUZ+c5upDTB7
 yCnhrzBR7E5pIpfB7JTj0gTvgYJmojl9m8Re2xfRi/trvCmrNZcExQsmSn36q3lnqbfCGmiO1Lt
 6fOaBOkKYIfEmYjOV5gUdqpDJ0zK/etwriBOx/lC3tYyPMJSxXtCTRZacL
X-Received: by 2002:a17:903:350d:b0:2b0:6f21:8289 with SMTP id
 d9443c01a7336-2ba79c2232amr235690825ad.25.1778508321394; 
 Mon, 11 May 2026 07:05:21 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:20 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 10/14] virtio-balloon: Update tracking iothread users with
 holder name
Date: Mon, 11 May 2026 22:04:12 +0800
Message-ID: <20260511140416.28271-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x636.google.com
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
 hw/virtio/virtio-balloon.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..8a4494905a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -892,14 +892,16 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
         precopy_add_notifier(&s->free_page_hint_notify);
 
-        object_ref(OBJECT(s->iothread));
-        s->free_page_bh = aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
-                                             virtio_ballloon_get_free_page_hints, s,
-                                             &dev->mem_reentrancy_guard);
+        s->free_page_bh = aio_bh_new_guarded(
+                            iothread_ref_and_get_aio_context(s->iothread, path),
+                            virtio_ballloon_get_free_page_hints, s,
+                            &dev->mem_reentrancy_guard);
     }
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
@@ -919,9 +921,11 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+
         qemu_bh_delete(s->free_page_bh);
-        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
+        iothread_put_aio_context(s->iothread, path);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
-- 
2.49.0


