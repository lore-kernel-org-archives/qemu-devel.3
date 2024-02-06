Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D20AC48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXG1y-0001Uh-Pl; Tue, 06 Feb 2024 02:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXG1x-0001UY-N0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:38:09 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXG1v-00017O-Fo
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:38:09 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so697598266b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707205085; x=1707809885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A6EOD6o7XFO1cgbHBrobNr6sKoEax6z2rbRoUXsoTsM=;
 b=CCYTw2DNmaf+ni4HXLjlWssM4PGWjocVOZKL8RKTjHnorIpagSRKepDRMIj0r7FwTA
 i/uPicRmpOM9TYwyDP7u/hrcQ9twJ+iSIEzqfY6DKC3eRTuBZYSQNGq+Lq1M3eD5VqzK
 BAMJYtHYfTt4kEmAUq+dfL1u9GvDVMpEZvgV01G+7f+hsX0dX0qOZXi0CZAey9XPFsdt
 sQCqn9l2eSQhdnXK52Kph8U4CJBoWtktHPKsszBeTl/g1ZL/XOxDiq5EZPOdVVcoJxaM
 ZSDvgK+tI3hYLVePd21vcjuEhJHZ3BHgtx/r66wltHRw+G+GiLnzLtsWZoaZ3GNiCAgM
 msvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707205085; x=1707809885;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A6EOD6o7XFO1cgbHBrobNr6sKoEax6z2rbRoUXsoTsM=;
 b=vWn9iw7O2+aGnCVetJzkE1/5oIWZlW45O28EW4Xk78JFwoadC+kzxT/1tIOwVaeLQ4
 qAX1uyi7VYKj96EuiyU9nrBmse4pYSNsvMAn+1gQfZGBn6TIagMWpJJlIxYRnsOk/Upw
 iIoqzG9hQdFWzzbRMKML+MQOuweroYUR54qnbdyuiwVTVc1UfAtJlAZKy8rNVzyi4OE9
 //386zgtEccHUJZLQMLSXXexfIjfQrm95GBRKBPyyfJRau85PQC6OZ+4A3pe4Y8dxiPy
 wn9omkYJ6yGPrxY6jcqVEkkZu+9Kw7waXpo8BY+Rj5HPf0ivploIXa5Erj5jhHijLbpc
 BVEw==
X-Gm-Message-State: AOJu0Yz34aXNLJYt23knGVAn2rY+J3e8D5JUluYNqR68jpKG01PTkt10
 Dq/hQ0E/Uq+QZnp9Hzv6zinI5Ps3DGHd+ySJBLvjReqW0+oCcqFP3xZpV1M4x+o=
X-Google-Smtp-Source: AGHT+IED5Era31m1eR2OiFcjyVaezBYkDmpr2PylrRLApwYInFmN8V0gGd6iD8V0idNegCCeT1ZzTA==
X-Received: by 2002:a17:906:b88d:b0:a37:124b:4782 with SMTP id
 hb13-20020a170906b88d00b00a37124b4782mr853882ejb.36.1707205085487; 
 Mon, 05 Feb 2024 23:38:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWbnmrSig0zudmGcat/vRpR20J/c32da7mj4RTFtn0/mfjwFxsdnE4SJXbVUQ9BmmwaccKT3Om6fZ03oRkKtKhD3Wy6WulqAbWybaSN6fnEUZTzL9uRJG0XB1USqDrNGwQJQRF0twuD7O6tksRju0UWZ5lov7QiadyWP8BWswceMmTxVDsrc4Z9G0rZLkzOmAz9yVtUE716/Xb/H5NTtbcBBzuep5aq
Received: from meli.delivery (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 o2-20020a170906358200b00a377c2ec6b9sm811194ejb.82.2024.02.05.23.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 23:38:05 -0800 (PST)
Date: Tue, 06 Feb 2024 09:29:29 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/5] virtio-blk: enforce iothread-vq-mapping validation
User-Agent: meli 0.8.5-rc.3
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-2-stefanha@redhat.com>
In-Reply-To: <20240205172659.476970-2-stefanha@redhat.com>
Message-ID: <8fbve.tkrjtk9401p1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 05 Feb 2024 19:26, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>Hanna Czenczek <hreitz@redhat.com> noticed that the safety of
>`vq_aio_context[vq->value] = ctx;` with user-defined vq->value inputs is
>not obvious.
>
>The code is structured in validate() + apply() steps so input validation
>is there, but it happens way earlier and there is nothing that
>guarantees apply() can only be called with validated inputs.
>
>This patch moves the validate() call inside the apply() function so
>validation is guaranteed. I also added the bounds checking assertion
>that Hanna suggested.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> hw/block/virtio-blk.c | 192 +++++++++++++++++++++++-------------------
> 1 file changed, 107 insertions(+), 85 deletions(-)
>
>diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>index 227d83569f..e8b37fd5f4 100644
>--- a/hw/block/virtio-blk.c
>+++ b/hw/block/virtio-blk.c
>@@ -1485,6 +1485,72 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
>     return 0;
> }
> 
>+static void virtio_resize_cb(void *opaque)
>+{
>+    VirtIODevice *vdev = opaque;
>+
>+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
>+    virtio_notify_config(vdev);
>+}
>+
>+static void virtio_blk_resize(void *opaque)
>+{
>+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>+
>+    /*
>+     * virtio_notify_config() needs to acquire the BQL,
>+     * so it can't be called from an iothread. Instead, schedule
>+     * it to be run in the main context BH.
>+     */
>+    aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, vdev);
>+}
>+
>+static void virtio_blk_ioeventfd_detach(VirtIOBlock *s)
>+{
>+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>+
>+    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
>+        VirtQueue *vq = virtio_get_queue(vdev, i);
>+        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]);
>+    }
>+}
>+
>+static void virtio_blk_ioeventfd_attach(VirtIOBlock *s)
>+{
>+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>+
>+    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
>+        VirtQueue *vq = virtio_get_queue(vdev, i);
>+        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]);
>+    }
>+}
>+
>+/* Suspend virtqueue ioeventfd processing during drain */
>+static void virtio_blk_drained_begin(void *opaque)
>+{
>+    VirtIOBlock *s = opaque;
>+
>+    if (s->ioeventfd_started) {
>+        virtio_blk_ioeventfd_detach(s);
>+    }
>+}
>+
>+/* Resume virtqueue ioeventfd processing after drain */
>+static void virtio_blk_drained_end(void *opaque)
>+{
>+    VirtIOBlock *s = opaque;
>+
>+    if (s->ioeventfd_started) {
>+        virtio_blk_ioeventfd_attach(s);
>+    }
>+}
>+
>+static const BlockDevOps virtio_block_ops = {
>+    .resize_cb     = virtio_blk_resize,
>+    .drained_begin = virtio_blk_drained_begin,
>+    .drained_end   = virtio_blk_drained_end,
>+};
>+
> static bool
> validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
>         uint16_t num_queues, Error **errp)
>@@ -1547,81 +1613,33 @@ validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
>     return true;
> }
> 
>-static void virtio_resize_cb(void *opaque)
>-{
>-    VirtIODevice *vdev = opaque;
>-
>-    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
>-    virtio_notify_config(vdev);
>-}
>-
>-static void virtio_blk_resize(void *opaque)
>-{
>-    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>-
>-    /*
>-     * virtio_notify_config() needs to acquire the BQL,
>-     * so it can't be called from an iothread. Instead, schedule
>-     * it to be run in the main context BH.
>-     */
>-    aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, vdev);
>-}
>-
>-static void virtio_blk_ioeventfd_detach(VirtIOBlock *s)
>-{
>-    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>-
>-    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
>-        VirtQueue *vq = virtio_get_queue(vdev, i);
>-        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]);
>-    }
>-}
>-
>-static void virtio_blk_ioeventfd_attach(VirtIOBlock *s)
>-{
>-    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>-
>-    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
>-        VirtQueue *vq = virtio_get_queue(vdev, i);
>-        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]);
>-    }
>-}
>-
>-/* Suspend virtqueue ioeventfd processing during drain */
>-static void virtio_blk_drained_begin(void *opaque)
>-{
>-    VirtIOBlock *s = opaque;
>-
>-    if (s->ioeventfd_started) {
>-        virtio_blk_ioeventfd_detach(s);
>-    }
>-}
>-
>-/* Resume virtqueue ioeventfd processing after drain */
>-static void virtio_blk_drained_end(void *opaque)
>-{
>-    VirtIOBlock *s = opaque;
>-
>-    if (s->ioeventfd_started) {
>-        virtio_blk_ioeventfd_attach(s);
>-    }
>-}
>-
>-static const BlockDevOps virtio_block_ops = {
>-    .resize_cb     = virtio_blk_resize,
>-    .drained_begin = virtio_blk_drained_begin,
>-    .drained_end   = virtio_blk_drained_end,
>-};
>-
>-/* Generate vq:AioContext mappings from a validated iothread-vq-mapping list */
>-static void
>-apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
>-                 AioContext **vq_aio_context, uint16_t num_queues)
>+/**
>+ * apply_iothread_vq_mapping:
>+ * @iothread_vq_mapping_list: The mapping of virtqueues to IOThreads.
>+ * @vq_aio_context: The array of AioContext pointers to fill in.
>+ * @num_queues: The length of @vq_aio_context.
>+ * @errp: If an error occurs, a pointer to the area to store the error.
>+ *
>+ * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
>+ * the iothread-vq-mapping parameter in @iothread_vq_mapping_list.
>+ *
>+ * Returns: %true on success, %false on failure.
>+ **/
>+static bool apply_iothread_vq_mapping(
>+        IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
>+        AioContext **vq_aio_context,
>+        uint16_t num_queues,
>+        Error **errp)
> {
>     IOThreadVirtQueueMappingList *node;
>     size_t num_iothreads = 0;
>     size_t cur_iothread = 0;
> 
>+    if (!validate_iothread_vq_mapping_list(iothread_vq_mapping_list,
>+                                           num_queues, errp)) {
>+        return false;
>+    }
>+
>     for (node = iothread_vq_mapping_list; node; node = node->next) {
>         num_iothreads++;
>     }
>@@ -1638,6 +1656,7 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
> 
>             /* Explicit vq:IOThread assignment */
>             for (vq = node->value->vqs; vq; vq = vq->next) {
>+                assert(vq->value < num_queues);
>                 vq_aio_context[vq->value] = ctx;
>             }
>         } else {
>@@ -1650,6 +1669,8 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
> 
>         cur_iothread++;
>     }
>+
>+    return true;
> }
> 
> /* Context: BQL held */
>@@ -1660,6 +1681,14 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
>     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> 
>+    if (conf->iothread && conf->iothread_vq_mapping_list) {
>+        if (conf->iothread) {
>+            error_setg(errp, "iothread and iothread-vq-mapping properties "
>+                             "cannot be set at the same time");
>+            return false;
>+        }
>+    }
>+
>     if (conf->iothread || conf->iothread_vq_mapping_list) {
>         if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
>             error_setg(errp,
>@@ -1685,8 +1714,14 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
>     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
> 
>     if (conf->iothread_vq_mapping_list) {
>-        apply_vq_mapping(conf->iothread_vq_mapping_list, s->vq_aio_context,
>-                         conf->num_queues);
>+        if (!apply_iothread_vq_mapping(conf->iothread_vq_mapping_list,
>+                                       s->vq_aio_context,
>+                                       conf->num_queues,
>+                                       errp)) {
>+            g_free(s->vq_aio_context);
>+            s->vq_aio_context = NULL;
>+            return false;
>+        }
>     } else if (conf->iothread) {
>         AioContext *ctx = iothread_get_aio_context(conf->iothread);
>         for (unsigned i = 0; i < conf->num_queues; i++) {
>@@ -1996,19 +2031,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>         return;
>     }
> 
>-    if (conf->iothread_vq_mapping_list) {
>-        if (conf->iothread) {
>-            error_setg(errp, "iothread and iothread-vq-mapping properties "
>-                             "cannot be set at the same time");
>-            return;
>-        }
>-
>-        if (!validate_iothread_vq_mapping_list(conf->iothread_vq_mapping_list,
>-                                               conf->num_queues, errp)) {
>-            return;
>-        }
>-    }
>-
>     s->config_size = virtio_get_config_size(&virtio_blk_cfg_size_params,
>                                             s->host_features);
>     virtio_init(vdev, VIRTIO_ID_BLOCK, s->config_size);
>-- 
>2.43.0
>
>


virtio_block_ops and methods are moved around without changes in the 
diff, is that on purpose? If no the patch and history would be less 
noisy.


Regardless:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

