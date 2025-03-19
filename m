Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BFBC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuulx-0006zs-GT; Wed, 19 Mar 2025 10:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tuulM-0006x3-VO
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tuulF-00059k-BZ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742395870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E86JzgAH+W8taDSLOTqlscR7Lz89aonzfbH9Q4o6Ddc=;
 b=PPQ49KhxQcTu8ICLDhHOtU77hv08IvL+9lX1rwKcNIpKebqB6304jjWzN4EZ61EODTqttB
 7WNvUnAOc4iK5LIuwposbr+Q3ClnG0KSk91QgNDmD8CALn/71dGZxDuDyUNXgEJ6r+tMZZ
 GEtQXQ5ooLIVr+rse5ahYCp4s92Oueg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-gM08V9TiOXCBPVat761IkA-1; Wed, 19 Mar 2025 10:51:07 -0400
X-MC-Unique: gM08V9TiOXCBPVat761IkA-1
X-Mimecast-MFC-AGG-ID: gM08V9TiOXCBPVat761IkA_1742395867
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abf4c4294b0so85032066b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 07:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395864; x=1743000664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E86JzgAH+W8taDSLOTqlscR7Lz89aonzfbH9Q4o6Ddc=;
 b=LAz3099v4iJjJrSmX+RS4ZZAV72v6EssooS0rPTnGUhClbsTdEQgkUbdCyIgU/ye+1
 ejYbY4nhlpZ+WsQh1+Uvjlbs5zTozZ8Kn81NLG+mpmNw0D529msqiGed2DKbacao56X1
 VOlq+p3Ns8rpHnMXsyW0Os5Qdwp7oABddgCIz7N4B6OJGfmX9xRdUOxDftXEda9G6hih
 f9exCG5SlnPeBPRqk24Y5EGGNvmIO2C/MQJu2RwPKhQUONciUgusGAlHwtHnaLBAijit
 eAaqGV+Z1OWEaefJPHo2kwMOGyrPHlw40Q3NfGZzmILZ+NAKRx7A6V3t9tJfbvdEorym
 Qjcw==
X-Gm-Message-State: AOJu0YyYPCnArDTrhtNGVfAXl1jlEwAX0O9BklhAxFE1tpSjbhNPnIZQ
 Wj6USm2EtFRtB3E3hdcQMYPCyBOLsowdX8/pKfrQtqKXX6q0Ko5KUtULP2ShroxOGLlQf02XRlZ
 2uQ18CUcifn1mhDXX/2OR0d9yI/fWN3dqnrWVqkctG8fuvNQ8gHYQ
X-Gm-Gg: ASbGnctrfrOsT1WbSK600YYYsZ4zILyUa1i5MHnZhTpezSX9PLyMhrwdT3JlV7vpNvC
 +LHJBctkfmIUKMeMqNxztdD/bPH/+Pg+kNfWD6PQ9lwnE7cGhh1hr9ZctV6B35+JFmfS+MwPRxm
 1aViaZQh2q9s9hpab7rrSz1XaQZsgGI/rBytNL4qU9quYjW/1UeF24FK6eWW8NvbdCBlHNmSuB2
 9pkFYGbQgOWexqfvu5nVIJJO52Z111aeTz96k+A9P0/+ZW4STiSEIyWRykYBH0qBvTOTsE2dhQY
 s2ezoC+FFo36XvFVXfF8agWghWuid0vFHOjpqf6H68yr6/uzlORsz0N288Sc3A==
X-Received: by 2002:a17:907:d786:b0:ac3:3f13:a851 with SMTP id
 a640c23a62f3a-ac3b6abf5e3mr309068366b.4.1742395864217; 
 Wed, 19 Mar 2025 07:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL37HhBg5U2Uq9VUd/7TiANnj3JCVSDtxCkXPUq9PUI4BQKgivlPBdlBaRR/EgNs6nuQWIcg==
X-Received: by 2002:a17:907:d786:b0:ac3:3f13:a851 with SMTP id
 a640c23a62f3a-ac3b6abf5e3mr309064166b.4.1742395863532; 
 Wed, 19 Mar 2025 07:51:03 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-53.retail.telecomitalia.it.
 [79.53.30.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3149cf10asm1013747166b.120.2025.03.19.07.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:51:02 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:50:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, fengli@smartx.com, yuhua@smartx.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 1/3] virtio: add VM state change cb with return value
Message-ID: <2t3b6ckqr5wrfl7neutvazjegafl4la4cifndbh3hefyqc7crs@yhlsmtkzytqg>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-2-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250314101535.1059308-2-haoqian.he@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 14, 2025 at 06:15:32AM -0400, Haoqian He wrote:
>This patch contains two changes:
>
>1. Add VM state change cb type VMChangeStateHandlerExt which has return
>value for virtio devices VMChangeStateEntry. When VM state changes,
>virtio device will call the _Ext version.
>
>2. Add return value for vm_state_notify().

Can you explain why these changes are needed?

>
>Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>---
> hw/block/virtio-blk.c             |  2 +-
> hw/core/vm-change-state-handler.c | 14 ++++++++------
> hw/scsi/scsi-bus.c                |  2 +-
> hw/vfio/migration.c               |  2 +-
> hw/virtio/virtio.c                |  5 +++--
> include/system/runstate.h         | 11 ++++++++---
> system/cpus.c                     |  4 ++--
> system/runstate.c                 | 25 ++++++++++++++++++++-----
> 8 files changed, 44 insertions(+), 21 deletions(-)
>
>diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>index 5135b4d8f1..4a48a16790 100644
>--- a/hw/block/virtio-blk.c
>+++ b/hw/block/virtio-blk.c
>@@ -1928,7 +1928,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>      * called after ->start_ioeventfd() has already set blk's AioContext.
>      */
>     s->change =
>-        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, s);
>+        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, NULL, s);
>
>     blk_ram_registrar_init(&s->blk_ram_registrar, s->blk);
>     blk_set_dev_ops(s->blk, &virtio_block_ops, s);
>diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
>index 7064995578..d5045b17c1 100644
>--- a/hw/core/vm-change-state-handler.c
>+++ b/hw/core/vm-change-state-handler.c
>@@ -40,6 +40,7 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
>  * qdev_add_vm_change_state_handler:
>  * @dev: the device that owns this handler
>  * @cb: the callback function to be invoked
>+ * @cb_ext: the callback function with return value to be invoked

I think we need to document what happens if both `cb` and `cb_ext` are 
specified.

Also `cb_ext` is very cryptic, I'm not good with names, but what about 
something like `cb_ret`?

>  * @opaque: user data passed to the callback function
>  *
>  * This function works like qemu_add_vm_change_state_handler() except callbacks
>@@ -54,21 +55,22 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
>  */
> VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>                                                      VMChangeStateHandler *cb,
>+                                                     VMChangeStateHandlerExt *cb_ext,
>                                                      void *opaque)
> {
>-    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, opaque);
>+    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, cb_ext, opaque);
> }
>
> /*
>  * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
>- * argument too.
>+ * and the cb_ext arguments too.
>  */
> VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
>-    DeviceState *dev, VMChangeStateHandler *cb,
>-    VMChangeStateHandler *prepare_cb, void *opaque)
>+    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
>+    VMChangeStateHandlerExt *cb_ext, void *opaque)

> {
>     int depth = qdev_get_dev_tree_depth(dev);
>
>-    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, opaque,
>-                                                      depth);
>+    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, cb_ext,
>+                                                      opaque, depth);
> }
>diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>index 7d4546800f..ec098f5f0a 100644
>--- a/hw/scsi/scsi-bus.c
>+++ b/hw/scsi/scsi-bus.c
>@@ -356,7 +356,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
>         return;
>     }
>     dev->vmsentry = qdev_add_vm_change_state_handler(DEVICE(dev),
>-            scsi_dma_restart_cb, dev);
>+            scsi_dma_restart_cb, NULL, dev);
> }
>
> static void scsi_qdev_unrealize(DeviceState *qdev)
>diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>index 416643ddd6..f531db83ea 100644
>--- a/hw/vfio/migration.c
>+++ b/hw/vfio/migration.c
>@@ -1015,7 +1015,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>                      vfio_vmstate_change_prepare :
>                      NULL;
>     migration->vm_state = qdev_add_vm_change_state_handler_full(
>-        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
>+        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev);
>     migration_add_notifier(&migration->migration_state,
>                            vfio_migration_state_notifier);
>
>diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>index 85110bce37..5e8d4cab53 100644
>--- a/hw/virtio/virtio.c
>+++ b/hw/virtio/virtio.c
>@@ -3419,7 +3419,7 @@ void virtio_cleanup(VirtIODevice *vdev)
>     qemu_del_vm_change_state_handler(vdev->vmstate);
> }
>
>-static void virtio_vmstate_change(void *opaque, bool running, RunState state)
>+static int virtio_vmstate_change(void *opaque, bool running, RunState state)
> {
>     VirtIODevice *vdev = opaque;
>     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>@@ -3438,6 +3438,7 @@ static void virtio_vmstate_change(void *opaque, bool running, RunState state)
>     if (!backend_run) {
>         virtio_set_status(vdev, vdev->status);
>     }
>+    return 0;
> }
>
> void virtio_instance_init_common(Object *proxy_obj, void *data,
>@@ -3489,7 +3490,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
>         vdev->config = NULL;
>     }
>     vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
>-            virtio_vmstate_change, vdev);
>+            NULL, virtio_vmstate_change, vdev);

IIUC virtio_vmstate_change now returns always 0, so what is the point of
this change?

I'd also do this change in a separate commit if it's really needed.

>     vdev->device_endian = virtio_default_endian();
>     vdev->use_guest_notifier_mask = true;
> }
>diff --git a/include/system/runstate.h b/include/system/runstate.h
>index bffc3719d4..af33ea92b6 100644
>--- a/include/system/runstate.h
>+++ b/include/system/runstate.h
>@@ -12,6 +12,7 @@ bool runstate_needs_reset(void);
> void runstate_replay_enable(void);
>
> typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
>+typedef int VMChangeStateHandlerExt(void *opaque, bool running, RunState state);

Ditto about "Ext"

>
> VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>                                                      void *opaque);
>@@ -20,21 +21,25 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
> VMChangeStateEntry *
> qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>                                            VMChangeStateHandler *prepare_cb,
>+                                           VMChangeStateHandlerExt *cb_ext,
>                                            void *opaque, int priority);
> VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>                                                      VMChangeStateHandler *cb,
>+                                                     VMChangeStateHandlerExt *cb_ext,
>                                                      void *opaque);
> VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
>-    DeviceState *dev, VMChangeStateHandler *cb,
>-    VMChangeStateHandler *prepare_cb, void *opaque);
>+    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
>+    VMChangeStateHandlerExt *cb_ext, void *opaque);
> void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
> /**
>  * vm_state_notify: Notify the state of the VM
>  *
>  * @running: whether the VM is running or not.
>  * @state: the #RunState of the VM.
>+ *
>+ * Return the result of the callback which has return value.

What if the callback has no return value?

>  */
>-void vm_state_notify(bool running, RunState state);
>+int vm_state_notify(bool running, RunState state);
>
> static inline bool shutdown_caused_by_guest(ShutdownCause cause)
> {
>diff --git a/system/cpus.c b/system/cpus.c
>index 2cc5f887ab..6e1cf5720f 100644
>--- a/system/cpus.c
>+++ b/system/cpus.c
>@@ -299,14 +299,14 @@ static int do_vm_stop(RunState state, bool send_stop)
>         if (oldstate == RUN_STATE_RUNNING) {
>             pause_all_vcpus();
>         }
>-        vm_state_notify(0, state);
>+        ret = vm_state_notify(0, state);
>         if (send_stop) {
>             qapi_event_send_stop();
>         }
>     }
>
>     bdrv_drain_all();
>-    ret = bdrv_flush_all();
>+    ret |= bdrv_flush_all();

Are we sure this is the right thing to do?
If vm_state_notify() failed, shouldn't we go out first, and then why put 
them in or?

I think it should be explained in the commit or in a comment here.

>     trace_vm_stop_flush_all(ret);
>
>     return ret;
>diff --git a/system/runstate.c b/system/runstate.c
>index 272801d307..2219cec409 100644
>--- a/system/runstate.c
>+++ b/system/runstate.c
>@@ -297,6 +297,7 @@ void qemu_system_vmstop_request(RunState state)
> struct VMChangeStateEntry {
>     VMChangeStateHandler *cb;
>     VMChangeStateHandler *prepare_cb;
>+    VMChangeStateHandlerExt *cb_ext;
>     void *opaque;
>     QTAILQ_ENTRY(VMChangeStateEntry) entries;
>     int priority;
>@@ -320,14 +321,15 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
> VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>         VMChangeStateHandler *cb, void *opaque, int priority)
> {
>-    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
>-                                                      priority);
>+    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, NULL,
>+                                                      opaque, priority);
> }
>
> /**
>  * qemu_add_vm_change_state_handler_prio_full:
>  * @cb: the main callback to invoke
>  * @prepare_cb: a callback to invoke before the main callback
>+ * @cb_ext: the main callback to invoke with return value
>  * @opaque: user data passed to the callbacks
>  * @priority: low priorities execute first when the vm runs and the reverse is
>  *            true when the vm stops
>@@ -344,6 +346,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
> VMChangeStateEntry *
> qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>                                            VMChangeStateHandler *prepare_cb,
>+                                           VMChangeStateHandlerExt *cb_ext,
>                                            void *opaque, int priority)
> {
>     VMChangeStateEntry *e;
>@@ -352,6 +355,7 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>     e = g_malloc0(sizeof(*e));
>     e->cb = cb;
>     e->prepare_cb = prepare_cb;
>+    e->cb_ext = cb_ext;
>     e->opaque = opaque;
>     e->priority = priority;
>
>@@ -379,9 +383,10 @@ void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
>     g_free(e);
> }
>
>-void vm_state_notify(bool running, RunState state)
>+int vm_state_notify(bool running, RunState state)
> {
>     VMChangeStateEntry *e, *next;
>+    int ret = 0;
>
>     trace_vm_state_notify(running, state, RunState_str(state));
>
>@@ -393,7 +398,12 @@ void vm_state_notify(bool running, RunState state)
>         }
>
>         QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
>-            e->cb(e->opaque, running, state);
>+            if (e->cb) {
>+                e->cb(e->opaque, running, state);
>+            } else if (e->cb_ext) {
>+                // no need to process the result when starting VM

Why?

(a good comment should explain more why than what we're doing which is 
pretty clear)

>+                e->cb_ext(e->opaque, running, state);
>+            }
>         }
>     } else {
>         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
>@@ -403,9 +413,14 @@ void vm_state_notify(bool running, RunState state)
>         }
>
>         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
>-            e->cb(e->opaque, running, state);
>+            if (e->cb) {
>+                e->cb(e->opaque, running, state);
>+            } else if (e->cb_ext) {
>+                ret |= e->cb_ext(e->opaque, running, state);

I think putting them in or should be documented or at least explained 
somewhere. It's not clear to me, but it's true that I don't know this 
code.

>+            }
>         }
>     }
>+    return ret;
> }
>
> static ShutdownCause reset_requested;
>-- 
>2.48.1
>


