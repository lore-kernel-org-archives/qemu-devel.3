Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7A606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P4xW7Lv+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TSb5WxM1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Fx-0007U8-Ni; Wed, 28 Oct 2026 13:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FB-0006DW-AY
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7F9-0003kX-77
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Rihfqxtr8GduSuOZLvFUoajDzpo9j2jlvTK0xVxxCE=;
 b=P4xW7Lv+GpwZjQfo2PZJnYUQQ2sQq+55zclF6Y7QLFcMm9nxiNyuxxsgso1Oa0CbN3kSIe
 3GVywPEh5iIq3q6X0/dZrYje1VXkEmBQ5a7uowRNYftl1IvvQJxIwMzvDIEI3yVV3xXbPx
 fWA4S9vlmkRMqluKyXCh0d+2HrPE5jc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-SSmPE6SGPp21Wh1R9sR5BA-1; Wed, 28 Oct 2026 13:15:14 -0400
X-MC-Unique: SSmPE6SGPp21Wh1R9sR5BA-1
X-Mimecast-MFC-AGG-ID: SSmPE6SGPp21Wh1R9sR5BA_1793207713
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so790565f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207713; x=1793812513; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Rihfqxtr8GduSuOZLvFUoajDzpo9j2jlvTK0xVxxCE=;
 b=TSb5WxM1/V5tDlhzKUUeYpMF5rVFtfJwN01jjYDGnGi1waRDcW7JhjfLJEBjy+nCSo
 xYlGkIHOULzYO92+8oxWqrbb6dLlmr+bbfnGXH6j/KGP1e9dhOd2X9npBorbuTSpU0FQ
 Q6wEtaEiIhs97ma4Iw0TCR0acaQxUh82Ki8PpOFRcM2PzrrQM50Q4CZB7/VQr8XafA87
 FF1Ih6c0mUg56rnsTKeksy+ydfsx/FRYozwlNpIV2h4yJRM17r954YSLm7E2FOuRhASs
 hUEI/F/91pup2fnlHjypmSvPeWm8iBcx6OIFLuw8GOPSGbPZvp7i2Z6BDsMO5jCH0gSR
 3HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207713; x=1793812513;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Rihfqxtr8GduSuOZLvFUoajDzpo9j2jlvTK0xVxxCE=;
 b=wan8bf1s8JXYBqfA9JdgMGdsHqKQ+qQXyz+z75LFqGuQELZCPq00jKV8JPmgj9Kymu
 1n9sGk436/s7BiFiRmUviVCJqtlibh6Baz3K0HveGVdpor1ocWgE342ggeqrTlYTgxfD
 1YBw5wnkQyoMXp5mg5zIXaYKoeioOaOaVo38+qOiXfdBB5ZZfeSmwQ1/1dOSwdl+jd9+
 Qozv0Cg4LT67pjjn3pckkZ2HC4NME9+2xGuhJXrIHhD7O8XLKwqMUHTkuDX6yFZDEMrB
 fha3V9pMzH0Q9amvQnLFNpkbuHAeL0PdJeFUcNthTKnqW3/30zCZrg3jgCH22BDseu8m
 BxiA==
X-Gm-Message-State: AFq9FYIkSu92m+D1p1tcHbwyHduEO181Lz6O9IEuX+hUB5EwlKZaUgGd
 VMKMBPoc0rA/Biq3IuzHnHNGGTgFreWKjzYAXWTySiJaL+KG2oKrxvrpTV80bm8gbNxmDFdpUyX
 UJxaJW+VlkpJH+1/kC8RjXuAFx2nQMuv0aNFscZZX0JqxEA8guo8yUfjwfDkiS0XNfF8PnMsc+x
 SB8SFMcADc4YknuJA7lzq9XgSePqRUU8pceg==
X-Gm-Gg: AYBFou2PzSuJcT1P2V8jjmdG5VzyxtxazIIZ+QbEcHQWgUWUDyqcGZpN0WFwi0zQSPy
 Mg+IXdaTUvCj7d8YzfwkH0v66PThUcOPMHPIgWnQ9+im1gp2/Ppi3NOa1dWOux77nU+Dw75i1zr
 EaJji4Gis78jTSNbfWTXTi2rdqLLPC10wzfiJMLPhqs6oLQq5TMsPak46GV/jWh4uPPMulvuznm
 lJL+uxFTNXsZ+/asixsyfWa8duJr6XHoaEA6jcO8X7TSCJK2XQSkOHoNaKfCpDcGgrsCbt3KORt
 vRBXOlPf8CZVMp8X34HcZt7sECdo/pPSYxi1/ZstAwiRn1mnKkpEBi0Arqi9KjubJz5VEayG7hB
 LokYgz/A6vQPt2o2WYkaNcK8G6jZCjCxo15Nsr+0l
X-Received: by 2002:a05:600c:524c:b0:4a2:a9:ed56 with SMTP id
 5b1f17b1804b1-4a9661ab67fmr69806945e9.8.1793207713312; 
 Wed, 28 Oct 2026 10:15:13 -0700 (PDT)
X-Received: by 2002:a05:600c:524c:b0:4a2:a9:ed56 with SMTP id
 5b1f17b1804b1-4a9661ab67fmr69805945e9.8.1793207712706; 
 Wed, 28 Oct 2026 10:15:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm5698975e9.1.2026.10.28.10.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:10 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 27/78] vhost: release ownership on exit
Message-ID: <30e26e913be83667e501eb2ed1a09b0ca90874ce.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a target which has loaded the state
but hasn't been started yet, e.g. one started with -S, may be quit
normally, with the source being resumed instead.  Devices aren't
unrealized on quit, so the ownership stays with the dead process.  The
source still holds the FD, so the kernel never releases the device, and
the source can't take it back after being resumed -> SET_OWNER fails
with EBUSY.

Add an exit notifier to each vhost_dev, registered for its lifetime,
that releases the ownership if still held.  This covers every orderly
exit.  A target killed with SIGKILL or crashing still leaves the device
unrecoverable.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-18-36c38bd15ffc@virtuozzo.com>
---
 include/hw/virtio/vhost.h |  2 ++
 hw/virtio/vhost.c         | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 3b9ef86bac..eb693e3289 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -123,6 +123,8 @@ struct vhost_dev {
      * when this vhost_dev goes away.  Set by the device.
      */
     bool owner_handed_over;
+    /* @exit_notifier: releases the ownership at exit, vhost_exit_notify() */
+    Notifier exit_notifier;
     /*
      * @migration_notifier: releases the ownership when an incoming
      * migration fails, vhost_migration_notify()
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7fd2883504..cbf6e82afb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -31,6 +31,7 @@
 #include "system/dma.h"
 #include "system/memory.h"
 #include "system/ramblock.h"
+#include "system/system.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -90,6 +91,19 @@ static int vhost_migration_notify(NotifierWithReturn *notifier,
     return 0;
 }
 
+/*
+ * Release the ownership of the vhost devices still held at exit(), so that
+ * another process sharing the backend FDs (e.g. the CPR source) can take
+ * them over.
+ */
+static void vhost_exit_notify(Notifier *notifier, void *data)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          exit_notifier);
+
+    vhost_dev_try_release_owner(hdev, "exit");
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1860,6 +1874,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    hdev->exit_notifier.notify = vhost_exit_notify;
+    qemu_add_exit_notifier(&hdev->exit_notifier);
     migration_add_notifier_modes(&hdev->migration_notifier,
                                  vhost_migration_notify,
                                  BIT(MIG_MODE_CPR_TRANSFER) |
@@ -1913,6 +1929,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    if (hdev->exit_notifier.notify) {
+        qemu_remove_exit_notifier(&hdev->exit_notifier);
+        hdev->exit_notifier.notify = NULL;
+    }
     migration_remove_notifier(&hdev->migration_notifier);
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
-- 
MST


