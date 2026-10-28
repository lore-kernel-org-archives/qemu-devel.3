Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20252606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FF4T+S+L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzvz-000738-GI; Wed, 28 Oct 2026 05:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvx-0006zr-Ij
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvv-0006i0-T9
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e985106c0cso6140125ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179618; x=1793784418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AiQGYq/AMrxdJEu7NCO1nhO4S/ZduwCJs4CIWfesvEQ=;
 b=FF4T+S+L4BQhVMU3MU23zWSPXisZ1q2pqrWLALe7T5p10hvhX9HGXfi+RP+16ujrE9
 AtPZFAA3ViKFfog1b0CdJPpT+Ds/5sM5pENcKuh/jkQxsdBEZUnnL6ExQAOFdF2JG/qB
 s/02D6zfYWb5UgFc2Tj297HS1OxCwgbdZB8JSNUm+hplLzaeZnjaniCNjuDSAo5gOkVj
 pCDgJtyeRRGVGwqcHyqdq++DUDzp9lzl9D046a1NuBiYKWZqJREMpYsrfMdKpK+z9YBU
 XvpXCWOzn/ilxpLFAmGMefflEIvCxxkizaJhoLSF/1KGk49lj/qMtR/57Ix6oGMlbrat
 /YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179618; x=1793784418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AiQGYq/AMrxdJEu7NCO1nhO4S/ZduwCJs4CIWfesvEQ=;
 b=sq3+bmSjRfN7dtfL2/whJ+mbfN5BAvJxdZixghhoYVoQq9YI7rc1NAa+/kJyVhSxmX
 96hOHDIffvkHw9aVnYkjPPzjhGY3TvbFsXLR0tvQWFVFrONeQ/RbO81XedUtUTBBFmsV
 WECu5aH8kiOtwn+EKSLuURvosWyVlwzDaOPfgntkxvotckgdUmgukAn5KMoP4H+lmNK5
 phWh9asL7f4Nv8G+bLsn4K4c4yl6fCYNqp6akBS1VIUr1ocXY0oQWEudCSo0XJaunmvk
 4XpSzY6H7ZTDlZBhFQPZ176gK8VnncYxOcktVj7S7jOoMVxX6Qk9xfAlvpKf5YbRFJ4Z
 UGpA==
X-Gm-Message-State: AFq9FYJVUHCiPeFK28h0vRRuJeToKRidb+fKGDYZy6CC5j4rf5/s2pTF
 1vS9lmlm7DtbBuv8Jud0CgCVC6QWFVOPRI4Kiv4jrcBCdTzMu9F7E+4+G+m2IV+U
X-Gm-Gg: AYBFou2HT5W43446DhR8LNjU8w6i/8BFRZtzrK1btLb/eSMFfAbR0tG7RZ6Js8vO8o9
 pBdWbxkJsXcj0HNN3VIXynIw3CVYJVKG11LfexaI0x7bvpr+hgZhykMOr1YSzvaGOgQpZ19f27F
 skrWiluxvf+J+XqPaIRDmzvb5MpLXUoR4fs0Py4gNR1f7HUa7lmIm6SEV6X/+i0i9z/7h1DVHN7
 kdhEySGqw1CCqTEernFMl9V0EHA2NJM9LP43sU2j0v2MS4yCnWFCofd+EHcYXnxcJXw0g7ll/tD
 +OnNUnzEM8BQB47bvPjV7nttFZgckK5vBIvEeyMJiAZqSEmwRinIpe84eYvDRsW8AZquNVjhJ1G
 02jkP8Ep4tEUCkNtTv8bo2/GrPI/eGyQKy0EuxdTVxo90qY0SdJMSh0Mwd1pZAzvCoGDpg8xr3o
 OnTOu1b56UzQk1dfbQqp70TvC/m+UI//Sey/dSuLqQdDf6aFuPDXr1VTxPV6wP3ERThTSgoQnqO
 QpUCSGo6XrymBoNeCC8HAYE+dns2Rq70OF7OSmf/BOAQUY4N1rD+0qEwgmBAYaCLrpqyxxxLqWR
 8C1KpsOOHCtVVjGyZTFmOjY9SupESJ1QJwyrKd2irhTTSDtMOKDY+SonDKg=
X-Received: by 2002:a17:902:d485:b0:2dd:ad73:c93a with SMTP id
 d9443c01a7336-2eb004fc927mr15701715ad.27.1793179618544; 
 Wed, 28 Oct 2026 02:26:58 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:26:57 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 08/14] virtio-balloon: Update tracking iothread users with
 holder
Date: Wed, 28 Oct 2026 17:26:13 +0800
Message-ID: <20261028092619.1654474-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x635.google.com
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
index 07d519cf6d..cfc581940e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -896,12 +896,19 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
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
@@ -928,7 +935,11 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
-        AioContext *ctx = iothread_get_aio_context(s->iothread);
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
 
         qemu_bh_delete(s->free_page_bh);
 
@@ -936,9 +947,9 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
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


