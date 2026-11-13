Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E766606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kHbwOf+f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYi-0000fp-IP; Fri, 13 Nov 2026 04:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYg-0000fZ-PW
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYf-00060v-8R
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:58 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ede7cb02daso12975095ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562016; x=1795166816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pFOYRSr2lEA/XDAlOEnhBcCXZDLbuRVgFw78rMsTQ/o=;
 b=kHbwOf+f60k4OWSPrHxlhpVfpEw8FEz7qIK0pWglUAB7tB26MRK2jZ5Wj1olkxl27O
 tJPHdI+1Rehb9HHJZC0Nkj7SOFHr0bZbfZXHuPzvDld/2s8dYApOioXFZd0+gk7nbQ/J
 849xBIja6n3A51PeSRcr9dMMY1xpd/pCx4EpvGkaIFLt9dF7CjJb7/d7Q8rQ7cpP0t80
 dw7PHngp7GoaDGJVgSziGEsmnGJiLsc8E7lTmDyCbJiLvWB0M8Q9vDx1S99E13913sKx
 5ePtZ2+nDRJQzIWISdJjhOfQEDpTakrNmcefSPWewNcJtqs5gYy1EgESGVzcymOeWhx2
 7M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562016; x=1795166816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pFOYRSr2lEA/XDAlOEnhBcCXZDLbuRVgFw78rMsTQ/o=;
 b=b1oM7RJ0dS4NuwKlEl/x8RHBK1joXn0Yl6h2zJ3BIpLBR03FNx5neUDFi1FQkhSPbj
 E/NqswClZL5tQkuORCu/DlVzf6Yvytb8RCdEEgVUSgLWghZ5tTo/Mx7m4DkYR5NFCa6v
 ewz0KqcKE0d6SylEIBSr8pUaxN6Q7OEd+3haObYuJW7FkwcUCeOehcVjbnsKUmSjfTxM
 aft3ROsT0DffrklP0hrSXedCPJdSKKGH9iVs/F/UcxneIUA6rlfLBSKO8HStxf2oIct6
 arTnCqiNY1ECGPZlmG6tKWXylRA0Y3vbVzNHajM0ZyRgT2ayFojdC/vYsn1x7aniEoFW
 bx+A==
X-Gm-Message-State: APuU4Z89YVarGKyRMvVrDki9I57n/u7RYbW7ZWPzvjM/vXl9Whr1sNwF
 qrwu8vUG/7jR0Zi8xWpMi1gweDFMTGAfIJSRpg2t97+CUaKT96U9noan/XtgEIfN
X-Gm-Gg: AYBFou29uGDIx4mvFf1XNHeGw7Dyd9JTKDDhYJF10mXPwxt0bJ6vTryzxHXclxoFltB
 ZaWodvtP+ZHZu+tC3uk6dIXEFcK5NEM8fq5nIe5h13VqKZ2NEg27qoRegsycUz4QF8uyfWibhfX
 x+2hlEeWrH2iupLNV3o+xBm0MAsd7ZPWrDRde+6ah4Y2Jtim04Kic661BX31UDsVViCh9BKmFvK
 wj/O7Zg6LjmPgfFCwXO53ZU8Mkj6UwqI/ALiyYrqT+AQhvJW+DEFl6WadsK+1GijN9bkP7hWmSr
 NRRHrSIZ8tSly/O5DClmJKPLULgNIzrza58Q1ef67OcM80XsURjG4xUGaXPOh2MbH9rXPgHGX84
 KVDWD9nS4W2c2lh8wPuoOWN1OIG3nwHRiY20PhXtF7RKZ8+NbpxXnq2QeZMLBpN5CYutIkJ5RQ3
 P3/eYmvc5W+gk7UCHf3udqHSIopyFO61PEyQRpjQ5q1kKA+hgAaU4cI65NjFPaHB6/z6ry6qVxy
 drDc9Jser45JnWcjH27CIqFQnBYIoAXvDurPtk0dCEo0a91GMYhJSeiDGgSnH68l1JC70FKwCIo
 gbttFuX+Ot7yxhYi01d2CFt9yQKjx05CDbNA/GSiCRoFgKTC5kvvoXYXG20=
X-Received: by 2002:a17:903:1a28:b0:2df:5c13:b37c with SMTP id
 d9443c01a7336-2edf20f20b7mr38290825ad.26.1794562015710; 
 Fri, 13 Nov 2026 01:26:55 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:54 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 08/14] virtio-balloon: Update tracking iothread users with
 holder
Date: Fri, 13 Nov 2026 17:25:59 +0800
Message-ID: <20261113092605.942292-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio-balloon.c         | 21 ++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 547173e035..ef694a17b2 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -871,12 +871,19 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
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
+        s->free_page_ctx = iothread_ref_and_get_aio_context(s->iothread,
+                                                          &io_holder);
+        s->free_page_bh = aio_bh_new_guarded(s->free_page_ctx,
                                              virtio_ballloon_get_free_page_hints, s,
                                              &dev->mem_reentrancy_guard);
     }
@@ -903,7 +910,11 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
-        AioContext *ctx = iothread_get_aio_context(s->iothread);
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
 
         qemu_bh_delete(s->free_page_bh);
 
@@ -911,9 +922,9 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
         s->free_page_hint_status = FREE_PAGE_HINT_S_UNREALIZE;
         qemu_cond_signal(&s->free_page_cond);
         qemu_mutex_unlock(&s->free_page_lock);
-        aio_wait_bh_oneshot(ctx, dummy_bh, NULL);
+        aio_wait_bh_oneshot(s->free_page_ctx, dummy_bh, NULL);
 
-        object_unref(OBJECT(s->iothread));
+        iothread_unref_and_put_aio_context(s->iothread, &io_holder);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 53bbaa4c9a..5c3731b3e9 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -54,6 +54,7 @@ struct VirtIOBalloon {
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
     IOThread *iothread;
+    AioContext *free_page_ctx;
     QEMUBH *free_page_bh;
     /*
      * Lock to synchronize threads to access the free page reporting related
-- 
2.53.0


