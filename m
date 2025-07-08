Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC65C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFBl-0005xV-BJ; Tue, 08 Jul 2025 16:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZVBtaAkKCgYgtqkkyrkxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--ankeesler.bounces.google.com>)
 id 1uZDhT-0007Yc-L3
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:09:59 -0400
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZVBtaAkKCgYgtqkkyrkxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--ankeesler.bounces.google.com>)
 id 1uZDhI-0005R8-Pj
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:09:52 -0400
Received: by mail-qk1-x749.google.com with SMTP id
 af79cd13be357-7d40185a630so809409185a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752001780; x=1752606580; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt5FiZuTEwWbwXPv2NQcO1aF8uLHv/WKWe98QnZ0Huw=;
 b=jkdvBAzgEC1LToTWOzwvUfXXyTx2L3GIQc9SLl4TvjBFGqTG++Tg4kPFiuOvzKrxY8
 3036lVZCoQNvcHaG2KIH4zYAFjcdccqt7k2nHH+dqMcKOs1zVXWzTxStXLanQ3wKx12E
 DwJpFyL59aEhP+LCTmznsCuHil7cf+uqtiMPo6ZTB9yRyfisIwASWGuNIE9lsEPaBKTu
 7gpmt5zyDFro2C5qGsGmtHTd68oQd9ZTkmjI+g2SQn4JX56VzvE8phc5tl+DAqO48aeZ
 rSus9QfWnOTRW0q5wh7ycUjhwa/e7ZhY1QYP1vJauhenbBa1tsKGYrgMAHCwMFuwf3MQ
 vZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001780; x=1752606580;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt5FiZuTEwWbwXPv2NQcO1aF8uLHv/WKWe98QnZ0Huw=;
 b=F5uDBWpY5DfaQLoTqJ8CLYGHpU0sLc2KCKKcQ56iWn0ymDuJMB16aBMilWcihQ93J+
 iJJg3aBfVNoH+GnkRclqq1FnRXyFLJl76Aqaw4zZzSx8nx8kzVCVHhYA9EtVQLuc7WXr
 c1q6vHzwY/SEcrwrYHqlX332O+aJGWQrY1qjeiJ057aAZbMebdLVi/Z8yF+jEgn2e7Zi
 x+GcDPLBmxQEivbSoK8vtPyLeSCKrROiKvZAOlVAyCz+xVMLQcU/nEQQHEK6T2MZMKi8
 aG8LnD1mMReR9So7uDj4jzqCwsk9aP3rjsDINeVSTgPPb7pxo0AIP07MzwXca2jNT9PF
 Zc6w==
X-Gm-Message-State: AOJu0YwpJ4A7K4ibsggPJ25jDpnWPnbnfOkrk1BHiqPX4FT+7YyjJPfu
 /BmUbqEBRVZRywgoBDCV0ASI5H75tdOvX2oSfSeaCeel9ufF6fUNNMMjna63gQ41QuSYfZlC2oL
 KlZpyo4xi3uo8t63o
X-Google-Smtp-Source: AGHT+IEr4ScoUbF+FcvX2PPqRJzsSa+JmBq1KHz/MP+mqlR0mLYBXJII5rlF0rk5MQBEy8XRUqcjOt3hp6OGVU8=
X-Received: from qknrk2.prod.google.com ([2002:a05:620a:9002:b0:7ce:c505:145c])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1d03:b0:7d4:430b:f467 with SMTP id
 af79cd13be357-7d5df13b608mr2071068985a.35.1751994469512; 
 Tue, 08 Jul 2025 10:07:49 -0700 (PDT)
Date: Tue,  8 Jul 2025 17:07:45 +0000
In-Reply-To: <20250708170745.141040-1-ankeesler@google.com>
Mime-Version: 1.0
References: <20250708170745.141040-1-ankeesler@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708170745.141040-2-ankeesler@google.com>
Subject: [PATCH v5 1/1] hw/display: Allow injection of virtio-gpu EDID name
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::749;
 envelope-from=3ZVBtaAkKCgYgtqkkyrkxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--ankeesler.bounces.google.com;
 helo=mail-qk1-x749.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
Identification Data) is propagated by QEMU such that a virtual display
presents legitimate metadata (e.g., name, serial number, preferred
resolutions, etc.) to its connected guest.

This change adds the ability to specify the EDID name for a particular
virtio-vga display. Previously, every virtual display would have the same
name: "QEMU Monitor". Now, we can inject names of displays in order to test
guest behavior that is specific to display names. We provide the ability to
inject the display name from the frontend since this is guest visible
data. Furthermore, this makes it clear where N potential display outputs
would get their name from (which will be added in a future change).

Note that we have elected to use a struct here for output data for
extensibility - we intend to add per-output fields like resolution in a
future change.

It should be noted that EDID names longer than 12 bytes will be truncated
per spec (I think?).

Testing: verified that when I specified 2 outputs for a virtio-gpu with
edid_name set, the names matched those that I configured with my vnc
display.

  -display vnc=localhost:0,id=aaa,display=vga,head=0 \
  -display vnc=localhost:1,id=bbb,display=vga,head=1 \
  -device '{"driver":"virtio-vga",
            "max_outputs":2,
            "id":"vga",
            "outputs":[
              {
                 "name":"AAA",
              },
              {
                 "name":"BBB",
              }
            ]}'

Signed-off-by: Andrew Keesler <ankeesler@google.com>
---
 hw/core/qdev-properties-system.c    | 44 +++++++++++++++++++++++++++++
 hw/display/virtio-gpu-base.c        | 27 ++++++++++++++++++
 include/hw/display/edid.h           |  2 ++
 include/hw/qdev-properties-system.h |  5 ++++
 include/hw/virtio/virtio-gpu.h      |  3 ++
 qapi/virtio.json                    | 18 ++++++++++--
 6 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 24e145d870..1f810b7ddf 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1299,3 +1299,47 @@ const PropertyInfo qdev_prop_vmapple_virtio_blk_variant = {
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
+
+/* --- VirtIOGPUOutputList --- */
+
+static void get_virtio_gpu_output_list(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    VirtIOGPUOutputList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+
+    visit_type_VirtIOGPUOutputList(v, name, prop_ptr, errp);
+}
+
+static void set_virtio_gpu_output_list(Object *obj, Visitor *v,
+    const char *name, void *opaque, Error **errp)
+{
+    VirtIOGPUOutputList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+    VirtIOGPUOutputList *list;
+
+    if (!visit_type_VirtIOGPUOutputList(v, name, &list, errp)) {
+        return;
+    }
+
+    qapi_free_VirtIOGPUOutputList(*prop_ptr);
+    *prop_ptr = list;
+}
+
+static void release_virtio_gpu_output_list(Object *obj,
+    const char *name, void *opaque)
+{
+    VirtIOGPUOutputList **prop_ptr =
+        object_field_prop_ptr(obj, opaque);
+
+    qapi_free_VirtIOGPUOutputList(*prop_ptr);
+    *prop_ptr = NULL;
+}
+
+const PropertyInfo qdev_prop_virtio_gpu_output_list = {
+    .type = "VirtIOGPUOutputList",
+    .description = "VirtIO GPU output list [{\"name\":\"<name>\"},...]",
+    .get = get_virtio_gpu_output_list,
+    .set = set_virtio_gpu_output_list,
+    .release = release_virtio_gpu_output_list,
+};
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 9eb806b71f..7269477a1c 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "hw/display/edid.h"
 #include "trace.h"
+#include "qapi/qapi-types-virtio.h"
 
 void
 virtio_gpu_base_reset(VirtIOGPUBase *g)
@@ -56,6 +57,8 @@ void
 virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
                               struct virtio_gpu_resp_edid *edid)
 {
+    size_t output_idx;
+    VirtIOGPUOutputList *node;
     qemu_edid_info info = {
         .width_mm = g->req_state[scanout].width_mm,
         .height_mm = g->req_state[scanout].height_mm,
@@ -64,6 +67,14 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
         .refresh_rate = g->req_state[scanout].refresh_rate,
     };
 
+    for (output_idx = 0, node = g->conf.outputs;
+         output_idx <= scanout && node; output_idx++, node = node->next) {
+        if (output_idx == scanout && node->value && node->value->name) {
+            info.name = node->value->name;
+            break;
+        }
+    }
+
     edid->size = cpu_to_le32(sizeof(edid->edid));
     qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
 }
@@ -172,6 +183,8 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
                                VirtIOHandleOutput cursor_cb,
                                Error **errp)
 {
+    size_t output_idx;
+    VirtIOGPUOutputList *node;
     VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
     int i;
@@ -181,6 +194,20 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
         return false;
     }
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node; output_idx++, node = node->next) {
+        if (output_idx == g->conf.max_outputs) {
+            error_setg(errp, "invalid outputs > %d", g->conf.max_outputs);
+            return false;
+        }
+        if (node->value && node->value->name &&
+            strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
+            error_setg(errp, "invalid output name '%s' > %d",
+                       node->value->name, EDID_NAME_MAX_LENGTH);
+            return false;
+        }
+    }
+
     if (virtio_gpu_virgl_enabled(g->conf)) {
         error_setg(&g->migration_blocker, "virgl is not yet migratable");
         if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index 520f8ec202..91c0a428af 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -1,6 +1,8 @@
 #ifndef EDID_H
 #define EDID_H
 
+#define EDID_NAME_MAX_LENGTH 12
+
 typedef struct qemu_edid_info {
     const char *vendor; /* http://www.uefi.org/pnp_id_list */
     const char *name;
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index b921392c52..9601a11a09 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -32,6 +32,7 @@ extern const PropertyInfo qdev_prop_cpus390entitlement;
 extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 extern const PropertyInfo qdev_prop_endian_mode;
 extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
+extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -110,4 +111,8 @@ extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
                          qdev_prop_vmapple_virtio_blk_variant, \
                          VMAppleVirtioBlkVariant)
 
+#define DEFINE_PROP_VIRTIO_GPU_OUTPUT_LIST(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_virtio_gpu_output_list, \
+                VirtIOGPUOutputList *)
+
 #endif
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index a42957c4e2..9f16f89a36 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -20,6 +20,7 @@
 #include "hw/virtio/virtio.h"
 #include "qemu/log.h"
 #include "system/vhost-user-backend.h"
+#include "qapi/qapi-types-virtio.h"
 
 #include "standard-headers/linux/virtio_gpu.h"
 #include "standard-headers/linux/virtio_ids.h"
@@ -128,6 +129,7 @@ struct virtio_gpu_base_conf {
     uint32_t xres;
     uint32_t yres;
     uint64_t hostmem;
+    VirtIOGPUOutputList *outputs;
 };
 
 struct virtio_gpu_ctrl_command {
@@ -167,6 +169,7 @@ struct VirtIOGPUBaseClass {
 
 #define VIRTIO_GPU_BASE_PROPERTIES(_state, _conf)                       \
     DEFINE_PROP_UINT32("max_outputs", _state, _conf.max_outputs, 1),    \
+    DEFINE_PROP_VIRTIO_GPU_OUTPUT_LIST("outputs", _state, _conf.outputs), \
     DEFINE_PROP_BIT("edid", _state, _conf.flags, \
                     VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
     DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 73df718a26..5e658a7033 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -963,17 +963,31 @@
 { 'struct': 'IOThreadVirtQueueMapping',
   'data': { 'iothread': 'str', '*vqs': ['uint16'] } }
 
+##
+# @VirtIOGPUOutput:
+#
+# Describes configuration of a VirtIO GPU output.
+#
+# @name: the name of the output
+#
+# Since: 10.1
+##
+
+{ 'struct': 'VirtIOGPUOutput',
+  'data': { 'name': 'str' } }
+
 ##
 # @DummyVirtioForceArrays:
 #
 # Not used by QMP; hack to let us use IOThreadVirtQueueMappingList
-# internally
+# and VirtIOGPUOutputList internally
 #
 # Since: 9.0
 ##
 
 { 'struct': 'DummyVirtioForceArrays',
-  'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'] } }
+  'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'],
+            'unused-virtio-gpu-output': ['VirtIOGPUOutput'] } }
 
 ##
 # @GranuleMode:
-- 
2.50.0.727.gbf7dc18ff4-goog


