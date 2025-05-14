Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4F1C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdu-0006Nh-IR; Wed, 14 May 2025 07:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdk-00068Y-W8
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdi-0006Ih-4g
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8c96S+F4hIc7CJWfCqKFJxxIJ4AYWnwfDATH0X1d/os=;
 b=KhPfGROFrYlyRsIuFlWw8RivOzB/KsWkc2zRmG1Du1C1Qd2SBCGR2cUSrRgxqiVJlYw/2L
 KHukrNbq6wMX8VwP9ytL8WaCWVerYWSuIZCDSKylu5bbacS7+4ffg1e7zSFDSDcg0rAiH1
 5CpKnVqW+AGo6ttq8PaM4xVwod9NTIk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-auziYOpkOgCMbylwi3WrXw-1; Wed, 14 May 2025 07:51:07 -0400
X-MC-Unique: auziYOpkOgCMbylwi3WrXw-1
X-Mimecast-MFC-AGG-ID: auziYOpkOgCMbylwi3WrXw_1747223466
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so43988465e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223463; x=1747828263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8c96S+F4hIc7CJWfCqKFJxxIJ4AYWnwfDATH0X1d/os=;
 b=tg4vfjv7EY4ttxiGfm47VwkO3mZxcBL1/6Q2+5gsjwZN6238/xUVNvict2ckdUmYgs
 dDwPkGKmHxRslXu+WURed+9V/XYGXIjqWJALdMv7gB7dLel7NRDH0DH/YLjb/t4vQ30E
 fXdrc5SsefxvWoB8BjVeTnFIXLX7SybgrfZKkw/QYem70dmC7yDMNQWtK0Cg6rjhepQW
 OlHj+CuDQaNdgCOAmOCKffjQUuhs6B4e+GdcRI+cgVsG3UI3ALifmX3oYaday/hXflAK
 aTWw691kwl7HRq+yF7DQ06xUtb8RgvxRe7PeFLA5wjlzy4a/AThSsGSkWEkivQMGpSHn
 FvAQ==
X-Gm-Message-State: AOJu0Yz6c++ULyfBq3piXUsIdx9FGAxeotn6jvSJTYmqaIIA90paosxA
 RyA5Bgde+PfGRD3KmKihfVddNH8kkA6qoYKVyMrhmM3RU6zo7MdOpP9Wbpkw64w4q/5QjKIbDIJ
 x6pD9u2SIiPESRK0rr8F/mUtnnfVkGpMiZQSPYk0OGjPsm05nZkwiN/LcT7auhvSTW8rETmpWCw
 FoxNdDtnDYWUu/dkBhLflp7NL1rL8C5A==
X-Gm-Gg: ASbGncu23UgvGls2eyY4HZ0qxDKIUK2HPYrbzsfQLMaD6Em0GDVKgAWr3kYh7ip+eEX
 ELDZihAxstMbpzNhTTWajDtdKPdxjbr5T6Yo3oDN5520OR2QpqZxCfcYbkJL4e0y7wl+i92nmk4
 9Va1rnwzcnuD7UeVTB80TxRQ/Gu1uVmiNey0OaKslIHfxyC6UF4xKHpF1Zko+rZaGfhvgKrFBnE
 TvmYYjwFolDPHYbUYxQawMJkRJO4qg2JgFsF5NSakvuyMNzB8gXlsAmoHRdgQLhyFZAxqiawqeC
 SvH9cg==
X-Received: by 2002:a05:600c:871a:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-442f20e340bmr30745805e9.14.1747223462849; 
 Wed, 14 May 2025 04:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJRFk2u7LgrNLOuBP0GNidZWti02ElR+fF5Ou/k7KZw+6NacCoxOOcfn5tvvqzzqdLp3gopA==
X-Received: by 2002:a05:600c:871a:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-442f20e340bmr30745365e9.14.1747223462350; 
 Wed, 14 May 2025 04:51:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39792c3sm27037845e9.35.2025.05.14.04.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:01 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Haoqian He <haoqian.he@smartx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org
Subject: [PULL 18/27] system/runstate: add VM state change cb with return value
Message-ID: <e0f300b36da1ee794fd81aa95f56e7bc9f010d46.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Haoqian He <haoqian.he@smartx.com>

This patch adds the new VM state change cb type `VMChangeStateHandlerWithRet`,
which has return value for `VMChangeStateEntry`.

Thus, we can register a new VM state change cb with return value for device.
Note that `VMChangeStateHandler` and `VMChangeStateHandlerWithRet` are mutually
exclusive and cannot be provided at the same time.

This patch is the pre patch for 'vhost-user: return failure if backend crashes
when live migration', which makes the live migration aware of the loss of
connection with the vhost-user backend and aborts the live migration.

Virtio device will use VMChangeStateHandlerWithRet.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Message-Id: <20250416024729.3289157-2-haoqian.he@smartx.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/system/runstate.h         | 13 +++++++++---
 hw/block/virtio-blk.c             |  2 +-
 hw/core/vm-change-state-handler.c | 18 ++++++++++------
 hw/scsi/scsi-bus.c                |  2 +-
 hw/vfio/migration.c               |  2 +-
 hw/virtio/virtio.c                |  2 +-
 system/cpus.c                     |  8 +++++--
 system/runstate.c                 | 35 ++++++++++++++++++++++++++-----
 8 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index bffc3719d4..fdd5c4a517 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -12,6 +12,7 @@ bool runstate_needs_reset(void);
 void runstate_replay_enable(void);
 
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
+typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
@@ -20,21 +21,27 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
+                                           VMChangeStateHandlerWithRet *cb_ret,
                                            void *opaque, int priority);
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
+                                                     VMChangeStateHandlerWithRet *cb_ret,
                                                      void *opaque);
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
-    DeviceState *dev, VMChangeStateHandler *cb,
-    VMChangeStateHandler *prepare_cb, void *opaque);
+    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
+    VMChangeStateHandlerWithRet *cb_ret, void *opaque);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 /**
  * vm_state_notify: Notify the state of the VM
  *
  * @running: whether the VM is running or not.
  * @state: the #RunState of the VM.
+ *
+ * Return the result of the callback which has return value.
+ * If no callback has return value, still return 0 and the
+ * upper layer should not do additional processing.
  */
-void vm_state_notify(bool running, RunState state);
+int vm_state_notify(bool running, RunState state);
 
 static inline bool shutdown_caused_by_guest(ShutdownCause cause)
 {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b54d01d3a2..ea948d18fd 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1802,7 +1802,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
      * called after ->start_ioeventfd() has already set blk's AioContext.
      */
     s->change =
-        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, s);
+        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, NULL, s);
 
     blk_ram_registrar_init(&s->blk_ram_registrar, s->blk);
     blk_set_dev_ops(s->blk, &virtio_block_ops, s);
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 7064995578..99c642b558 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -40,6 +40,7 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
  * qdev_add_vm_change_state_handler:
  * @dev: the device that owns this handler
  * @cb: the callback function to be invoked
+ * @cb_ret: the callback function with return value to be invoked
  * @opaque: user data passed to the callback function
  *
  * This function works like qemu_add_vm_change_state_handler() except callbacks
@@ -50,25 +51,30 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
  * controller's callback is invoked before the children on its bus when the VM
  * starts running.  The order is reversed when the VM stops running.
  *
+ * Note that the parameter `cb` and `cb_ret` are mutually exclusive.
+ *
  * Returns: an entry to be freed with qemu_del_vm_change_state_handler()
  */
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
+                                                     VMChangeStateHandlerWithRet *cb_ret,
                                                      void *opaque)
 {
-    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, opaque);
+    assert(!cb || !cb_ret);
+    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, cb_ret, opaque);
 }
 
 /*
  * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
- * argument too.
+ * and the cb_ret arguments too.
  */
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
-    DeviceState *dev, VMChangeStateHandler *cb,
-    VMChangeStateHandler *prepare_cb, void *opaque)
+    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
+    VMChangeStateHandlerWithRet *cb_ret, void *opaque)
 {
     int depth = qdev_get_dev_tree_depth(dev);
 
-    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, opaque,
-                                                      depth);
+    assert(!cb || !cb_ret);
+    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, cb_ret,
+                                                      opaque, depth);
 }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 70be4a7367..9b12ee7f1c 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -400,7 +400,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         return;
     }
     dev->vmsentry = qdev_add_vm_change_state_handler(DEVICE(dev),
-            scsi_dma_restart_cb, dev);
+            scsi_dma_restart_cb, NULL, dev);
 }
 
 static void scsi_qdev_unrealize(DeviceState *qdev)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1dceab1b19..b76697bd1a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1016,7 +1016,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
                      vfio_vmstate_change_prepare :
                      NULL;
     migration->vm_state = qdev_add_vm_change_state_handler_full(
-        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
+        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev);
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 480c2e5036..e3b62522ec 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3489,7 +3489,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
         vdev->config = NULL;
     }
     vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
-            virtio_vmstate_change, vdev);
+            virtio_vmstate_change, NULL, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
 }
diff --git a/system/cpus.c b/system/cpus.c
index 2cc5f887ab..d16b0dff98 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -299,14 +299,18 @@ static int do_vm_stop(RunState state, bool send_stop)
         if (oldstate == RUN_STATE_RUNNING) {
             pause_all_vcpus();
         }
-        vm_state_notify(0, state);
+        ret = vm_state_notify(0, state);
         if (send_stop) {
             qapi_event_send_stop();
         }
     }
 
     bdrv_drain_all();
-    ret = bdrv_flush_all();
+    /*
+     * Even if vm_state_notify() return failure,
+     * it would be better to flush as before.
+     */
+    ret |= bdrv_flush_all();
     trace_vm_stop_flush_all(ret);
 
     return ret;
diff --git a/system/runstate.c b/system/runstate.c
index 272801d307..de74d962bc 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -297,6 +297,7 @@ void qemu_system_vmstop_request(RunState state)
 struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
     VMChangeStateHandler *prepare_cb;
+    VMChangeStateHandlerWithRet *cb_ret;
     void *opaque;
     QTAILQ_ENTRY(VMChangeStateEntry) entries;
     int priority;
@@ -320,14 +321,15 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority)
 {
-    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
-                                                      priority);
+    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, NULL,
+                                                      opaque, priority);
 }
 
 /**
  * qemu_add_vm_change_state_handler_prio_full:
  * @cb: the main callback to invoke
  * @prepare_cb: a callback to invoke before the main callback
+ * @cb_ret: the main callback to invoke with return value
  * @opaque: user data passed to the callbacks
  * @priority: low priorities execute first when the vm runs and the reverse is
  *            true when the vm stops
@@ -344,6 +346,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
+                                           VMChangeStateHandlerWithRet *cb_ret,
                                            void *opaque, int priority)
 {
     VMChangeStateEntry *e;
@@ -352,6 +355,7 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
     e = g_malloc0(sizeof(*e));
     e->cb = cb;
     e->prepare_cb = prepare_cb;
+    e->cb_ret = cb_ret;
     e->opaque = opaque;
     e->priority = priority;
 
@@ -379,9 +383,10 @@ void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
     g_free(e);
 }
 
-void vm_state_notify(bool running, RunState state)
+int vm_state_notify(bool running, RunState state)
 {
     VMChangeStateEntry *e, *next;
+    int ret = 0;
 
     trace_vm_state_notify(running, state, RunState_str(state));
 
@@ -393,7 +398,17 @@ void vm_state_notify(bool running, RunState state)
         }
 
         QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
-            e->cb(e->opaque, running, state);
+            if (e->cb) {
+                e->cb(e->opaque, running, state);
+            } else if (e->cb_ret) {
+                /*
+                 * Here ignore the return value of cb_ret because
+                 * we only care about the stopping the device during
+                 * the VM live migration to indicate whether the
+                 * connection between qemu and backend is normal.
+                 */
+                e->cb_ret(e->opaque, running, state);
+            }
         }
     } else {
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
@@ -403,9 +418,19 @@ void vm_state_notify(bool running, RunState state)
         }
 
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
-            e->cb(e->opaque, running, state);
+            if (e->cb) {
+                e->cb(e->opaque, running, state);
+            } else if (e->cb_ret) {
+                /*
+                 * We should execute all registered callbacks even if
+                 * one of them returns failure, otherwise, some cleanup
+                 * work of the device will be skipped.
+                 */
+                ret |= e->cb_ret(e->opaque, running, state);
+            }
         }
     }
+    return ret;
 }
 
 static ShutdownCause reset_requested;
-- 
MST


