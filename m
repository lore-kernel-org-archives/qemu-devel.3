Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E088E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrhy-0000ys-9N; Wed, 18 Dec 2024 05:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhp-0000mP-OW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhn-0006sC-B8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FYSczBWmZzYWP3jGZ5iez4MtKwnNlrl2iQAhPcAask=;
 b=AhVrh3Q3z4Bfk8jUFJBhDnddlEzyQULJelziI+3XsoJjrYw99bePWMQBGjLuwf7TIUp3OY
 nluvIBzp3UhVl+V6Wkp93aksb+5FMKorjcq9nOwB+5els2DpKaBLh3+V/wgZSlMbRODYYE
 8B0s8kV4y1X94m6mgYoRWgrYKBIw3Gw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Ki4VnQz5Ma6pkDrB89Q-oQ-1; Wed, 18 Dec 2024 05:53:11 -0500
X-MC-Unique: Ki4VnQz5Ma6pkDrB89Q-oQ-1
X-Mimecast-MFC-AGG-ID: Ki4VnQz5Ma6pkDrB89Q-oQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43627bb20b5so49863365e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519190; x=1735123990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FYSczBWmZzYWP3jGZ5iez4MtKwnNlrl2iQAhPcAask=;
 b=mdGY3Yf3AQgcRNSmpYACC2nU511J/TVfiHu9tMWqm9jwxKuaDLMf/8yqJeKD2yvBQN
 vr7KfFEnGTE9HCaP4fMt/T3hhaJkKtRuK09NwLJ3ksPw1+Bz39ri+5b8zQqnSugE1R6Q
 MqO8lAa8+3erByWgSNYibu3LmH5foSrGjfIKVrnOjOGQfpMUAguT46+9jEbjX+FzLmY2
 kk+7SgUCQTI+XO5bgZQdseY+nXjt6OUDVPny4aKroCUAazWykbUlbPVjS2xCjjX/IaNF
 ERAi1gwKPEB8IA8wgPq2exlwQSAvAuJkfve1e2o1eWcFYKcdac7nQm/Q7IpeP9gZPTLS
 9iwg==
X-Gm-Message-State: AOJu0YyukCdzk+9Hmt/O/wIzoli9TWahrz4BF6xJFrs41y2tlcdBF94z
 6HYouTx12QE4GAVtUPJD5jRVOWoRmCnN1b6Qy3Z9yNWMQxAQrFOZ09EQqn4cTKHsGE278JeqK9B
 0zR/knYzn48KNqsJgXaFtC7Z6hYZTmPVd7rg9EEKaF7fzXbNLGY66haVSWKr3BVipR2TbwL+X5f
 DVgu+Gw63JycuUvMJipwjo1iZMBHVg1ITz6yw=
X-Gm-Gg: ASbGnctVYWXlc2pbJGTkyb23luJyU3CdlYAaTdLvq+CnQpAsQOKvZTP5tnVTWpbi5SN
 z8q7/LyhL2dkaI6bq2j/XPjOJuIotgva3b3GcMZYmH/XH2QP9m7b3tP1jetBAB0ct3Ov1v2T3uz
 LHJNrQl7+NicYQq3HgWsshZ/GClwPPQv+sZLc8ILWP8bn14PHjuwRLL2sZop/J3OLswJN6B0mvy
 wjgGZ8Ws53aInlYMAPPr7IXMQ4jjLHWnlPCc9s2f19zKk5E8+4i7Jgktvwn5q85LJUmcSxcZn4a
 a0jCzKPfhL2UDp1ZYYRL1XcpIRDofwITPpLnrE1c4w==
X-Received: by 2002:a05:600c:3ba8:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-43655341f14mr17282755e9.1.1734519190008; 
 Wed, 18 Dec 2024 02:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJdZsBZakKgxs096l2IqY1hOhqzw+dNo4w+a7zPwLN3zcl1j8auOY5+RpIUU8NGa6BAyWuNQ==
X-Received: by 2002:a05:600c:3ba8:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-43655341f14mr17282465e9.1.1734519189505; 
 Wed, 18 Dec 2024 02:53:09 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b1248dsm16289575e9.24.2024.12.18.02.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:08 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/15] virtio-mem: unplug memory only during system resets,
 not device resets
Date: Wed, 18 Dec 2024 11:52:49 +0100
Message-ID: <20241218105303.1966303-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently converted from the LegacyReset to the new reset framework
in commit c009a311e939 ("virtio-mem: Use new Resettable framework instead
of LegacyReset") to be able to use the ResetType to filter out wakeup
resets.

However, this change had an undesired implications: as we override the
Resettable interface methods in VirtIOMEMClass, the reset handler will
not only get called during system resets (i.e., qemu_devices_reset())
but also during any direct or indirect device rests (e.g.,
device_cold_reset()).

Further, we might now receive two reset callbacks during
qemu_devices_reset(), first when reset by a parent and later when reset
directly.

The memory state of virtio-mem devices is rather special: it's supposed to
be persistent/unchanged during most resets (similar to resetting a hard
disk will not destroy the data), unless actually cold-resetting the whole
system (different to a hard disk where a reboot will not destroy the data):
ripping out system RAM is something guest OSes don't particularly enjoy,
but we want to detect when rebooting to an OS that does not support
virtio-mem and wouldn't be able to detect+use the memory -- and we want
to force-defragment hotplugged memory to also shrink the usable device
memory region. So we rally want to catch system resets to do that.

On supported targets (e.g., x86), getting a cold reset on the
device/parent triggers is not that easy (but looks like PCI code
might trigger it), so this implication went unnoticed.

However, with upcoming s390x support it is problematic: during
kdump, s390x triggers a subsystem reset, ending up in
s390_machine_reset() and calling only subsystem_reset() instead of
qemu_devices_reset() -- because it's not a full system reset.

In subsystem_reset(), s390x performs a device_cold_reset() of any
TYPE_VIRTUAL_CSS_BRIDGE device, which ends up resetting all children,
including the virtio-mem device. Consequently, we wrongly detect a system
reset and unplug all device memory, resulting in hotplugged memory not
getting included in the crash dump -- undesired.

We really must not mess with hotplugged memory state during simple
device resets. To fix, create+register a new reset object that will only
get triggered during qemu_devices_reset() calls, but not during any other
resets as it is logically not the child of any other object.

Message-ID: <20241025104103.342188-1-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c         | 103 +++++++++++++++++++++++----------
 include/hw/virtio/virtio-mem.h |  13 ++++-
 2 files changed, 84 insertions(+), 32 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 3f6f46fad7..a0dceaddec 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -956,6 +956,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     VirtIOMEM *vmem = VIRTIO_MEM(dev);
     uint64_t page_size;
     RAMBlock *rb;
+    Object *obj;
     int ret;
 
     if (!vmem->memdev) {
@@ -1121,7 +1122,28 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         vmstate_register_any(VMSTATE_IF(vmem),
                              &vmstate_virtio_mem_device_early, vmem);
     }
-    qemu_register_resettable(OBJECT(vmem));
+
+    /*
+     * We only want to unplug all memory to start with a clean slate when
+     * it is safe for the guest -- during system resets that call
+     * qemu_devices_reset().
+     *
+     * We'll filter out selected qemu_devices_reset() calls used for other
+     * purposes, like resetting all devices during wakeup from suspend on
+     * x86 based on the reset type passed to qemu_devices_reset().
+     *
+     * Unplugging all memory during simple device resets can result in the VM
+     * unexpectedly losing RAM, corrupting VM state.
+     *
+     * Simple device resets (or resets triggered by getting a parent device
+     * reset) must not change the state of plugged memory blocks. Therefore,
+     * we need a dedicated reset object that only gets called during
+     * qemu_devices_reset().
+     */
+    obj = object_new(TYPE_VIRTIO_MEM_SYSTEM_RESET);
+    vmem->system_reset = VIRTIO_MEM_SYSTEM_RESET(obj);
+    vmem->system_reset->vmem = vmem;
+    qemu_register_resettable(obj);
 
     /*
      * Set ourselves as RamDiscardManager before the plug handler maps the
@@ -1141,7 +1163,10 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
      * found via an address space anymore. Unset ourselves.
      */
     memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
-    qemu_unregister_resettable(OBJECT(vmem));
+
+    qemu_unregister_resettable(OBJECT(vmem->system_reset));
+    object_unref(OBJECT(vmem->system_reset));
+
     if (vmem->early_migration) {
         vmstate_unregister(VMSTATE_IF(vmem), &vmstate_virtio_mem_device_early,
                            vmem);
@@ -1841,38 +1866,12 @@ static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
     }
 }
 
-static ResettableState *virtio_mem_get_reset_state(Object *obj)
-{
-    VirtIOMEM *vmem = VIRTIO_MEM(obj);
-    return &vmem->reset_state;
-}
-
-static void virtio_mem_system_reset_hold(Object *obj, ResetType type)
-{
-    VirtIOMEM *vmem = VIRTIO_MEM(obj);
-
-    /*
-     * When waking up from standby/suspend-to-ram, do not unplug any memory.
-     */
-    if (type == RESET_TYPE_WAKEUP) {
-        return;
-    }
-
-    /*
-     * During usual resets, we will unplug all memory and shrink the usable
-     * region size. This is, however, not possible in all scenarios. Then,
-     * the guest has to deal with this manually (VIRTIO_MEM_REQ_UNPLUG_ALL).
-     */
-    virtio_mem_unplug_all(vmem);
-}
-
 static void virtio_mem_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     VirtIOMEMClass *vmc = VIRTIO_MEM_CLASS(klass);
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
     dc->vmsd = &vmstate_virtio_mem;
@@ -1899,9 +1898,6 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
     rdmc->replay_discarded = virtio_mem_rdm_replay_discarded;
     rdmc->register_listener = virtio_mem_rdm_register_listener;
     rdmc->unregister_listener = virtio_mem_rdm_unregister_listener;
-
-    rc->get_state = virtio_mem_get_reset_state;
-    rc->phases.hold = virtio_mem_system_reset_hold;
 }
 
 static const TypeInfo virtio_mem_info = {
@@ -1924,3 +1920,48 @@ static void virtio_register_types(void)
 }
 
 type_init(virtio_register_types)
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(VirtioMemSystemReset, virtio_mem_system_reset, VIRTIO_MEM_SYSTEM_RESET, OBJECT, { TYPE_RESETTABLE_INTERFACE }, { })
+
+static void virtio_mem_system_reset_init(Object *obj)
+{
+}
+
+static void virtio_mem_system_reset_finalize(Object *obj)
+{
+}
+
+static ResettableState *virtio_mem_system_reset_get_state(Object *obj)
+{
+    VirtioMemSystemReset *vmem_reset = VIRTIO_MEM_SYSTEM_RESET(obj);
+
+    return &vmem_reset->reset_state;
+}
+
+static void virtio_mem_system_reset_hold(Object *obj, ResetType type)
+{
+    VirtioMemSystemReset *vmem_reset = VIRTIO_MEM_SYSTEM_RESET(obj);
+    VirtIOMEM *vmem = vmem_reset->vmem;
+
+    /*
+     * When waking up from standby/suspend-to-ram, do not unplug any memory.
+     */
+    if (type == RESET_TYPE_WAKEUP) {
+        return;
+    }
+
+    /*
+     * During usual resets, we will unplug all memory and shrink the usable
+     * region size. This is, however, not possible in all scenarios. Then,
+     * the guest has to deal with this manually (VIRTIO_MEM_REQ_UNPLUG_ALL).
+     */
+    virtio_mem_unplug_all(vmem);
+}
+
+static void virtio_mem_system_reset_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->get_state = virtio_mem_system_reset_get_state;
+    rc->phases.hold = virtio_mem_system_reset_hold;
+}
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index a1af144c28..550ce585b2 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -25,6 +25,10 @@
 OBJECT_DECLARE_TYPE(VirtIOMEM, VirtIOMEMClass,
                     VIRTIO_MEM)
 
+#define TYPE_VIRTIO_MEM_SYSTEM_RESET "virtio-mem-system-reset"
+
+OBJECT_DECLARE_SIMPLE_TYPE(VirtioMemSystemReset, VIRTIO_MEM_SYSTEM_RESET)
+
 #define VIRTIO_MEM_MEMDEV_PROP "memdev"
 #define VIRTIO_MEM_NODE_PROP "node"
 #define VIRTIO_MEM_SIZE_PROP "size"
@@ -117,8 +121,15 @@ struct VirtIOMEM {
     /* listeners to notify on plug/unplug activity. */
     QLIST_HEAD(, RamDiscardListener) rdl_list;
 
-    /* State of the resettable container */
+    /* Catch system resets -> qemu_devices_reset() only. */
+    VirtioMemSystemReset *system_reset;
+};
+
+struct VirtioMemSystemReset {
+    Object parent;
+
     ResettableState reset_state;
+    VirtIOMEM *vmem;
 };
 
 struct VirtIOMEMClass {
-- 
2.47.1


