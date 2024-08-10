Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCACAC531DD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scpDd-0004ia-OJ; Sat, 10 Aug 2024 12:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1scpDb-0004aT-9G
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 12:45:27 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1scpDZ-0003le-0P
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 12:45:26 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-710dc3015bfso1008033b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723308323; x=1723913123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGRuJEu3JMWECje7NdV/UCTaQgL32q6jpJ2wJZ12l5U=;
 b=JI6hLTxLpVRVfsPJL9aGBCSWsnQDbmfhmVfOH5TLuK1bY6InznII157uOxDVVs8pix
 arFY2v74XHVcq1FrKfDK4gL58OX09znts/aS4vg35megqiucxBazZK3oRfp27xsj+ptL
 GfncJ0ywz4k9UimQ07BKv2fu8m8I0026xRblYz+K6azPZZDM4VUNZDIh12T7N8a9+RKu
 oEQg9MNEYgas+CJwf023X9ZQpbErqjLkR/BgMaS7NZ9IwVNiumOXkvi8BOVXY8rUxx+J
 T6lQyDvS0/+X2mYDltsQ1uWJPkL7+vnAcra5AY1a5rNEg+ixF56xmvnUF+hqBN3nub+P
 AmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723308323; x=1723913123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGRuJEu3JMWECje7NdV/UCTaQgL32q6jpJ2wJZ12l5U=;
 b=ado9UNQcOfDDjRNA2O5VFX+fW+GyLmMdRpbXJZUyBFKAeUtG3YV9pNWV/IrhkEIAJd
 /HErewVzoGxaInHdtHxxkZUibYgh+MhDaTXfihvp/rJA7DHP5Jsgl18y1xXrOcFMtzud
 JkS+GRVR6+KmxvAz93u701vmWEHaoJsyetp7XhIc50nXO1c9NRGyFUH7ThmFoRvT2uAe
 OZ5slEk+pzYMr1WAIcB/qyjxgAlmtAu7Ae4i+5x7xhPToT4Mx5MUgG9qaZbuHmoY7d99
 vnbXwvPkapfQLCA+8qgoCQSm6U7Hv1D+LIAaNeS1bHMhqy4xVswVKehA+2YTjp7l2YSg
 0BMg==
X-Gm-Message-State: AOJu0Yx+zHKvdrcA4zohPT+7fjc5TM9VNZd3soXf+DVWi28o4zuZHKt7
 MGZgzOgZ7L11uF5M+AOB4d5Jk23+WBxOzvbaue+5jEQhY45m99/Tiew/1VaP
X-Google-Smtp-Source: AGHT+IHWDJnHPVC7pxIGVIqnltF9gPoNB+lGOdWGHPMu7sSmJ4N/81gXIiru8twbmG0yNxpFg5CfeA==
X-Received: by 2002:a05:6a00:3c95:b0:70d:32bf:aa45 with SMTP id
 d2e1a72fcca58-710dce5da43mr6298303b3a.14.1723308322731; 
 Sat, 10 Aug 2024 09:45:22 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58735e2sm1424397b3a.30.2024.08.10.09.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 09:45:22 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v3 2/5] machine/nitro-enclave: Add vhost-user-vsock device
Date: Sat, 10 Aug 2024 22:44:59 +0600
Message-Id: <20240810164502.19693-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240810164502.19693-1-dorjoychy111@gmail.com>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

AWS Nitro Enclaves have built-in vhost-vsock device support which
enables applications in enclave VMs to communicate with the parent
EC2 VM over vsock. The enclave VMs have dynamic CID while the parent
always has CID 3. In QEMU, the vsock emulation for nitro enclave is
added using vhost-user-vsock as opposed to vhost-vsock. vhost-vsock
doesn't support sibling VM communication which is needed for nitro
enclaves.

In QEMU's nitro-enclave emulation, for the vsock communication to CID
3 to work, another process that does the vsock emulation in  userspace
must be run, for example, vhost-device-vsock[1] from rust-vmm, with
necessary vsock communication support in another guest VM with CID 3.
A new mandatory nitro-enclave machine option 'vsock' has been added.
The value for this option should be the chardev id from the '-chardev'
option for the vhost-user-vsock device to work.

Using vhost-user-vsock also enables the possibility to implement some
proxying support in the vhost-user-vsock daemon that will forward all
the packets to the host machine instead of CID 3 so that users of
nitro-enclave can run the necessary applications in their host machine
instead of running another whole VM with CID 3.

[1] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 backends/hostmem-memfd.c        |   2 -
 hw/core/machine.c               |  71 +++++++++---------
 hw/i386/Kconfig                 |   1 +
 hw/i386/nitro_enclave.c         | 123 ++++++++++++++++++++++++++++++++
 include/hw/boards.h             |   2 +
 include/hw/i386/nitro_enclave.h |   8 +++
 include/sysemu/hostmem.h        |   2 +
 7 files changed, 174 insertions(+), 35 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 6a3c89a12b..9f890a813e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -18,8 +18,6 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 
-#define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
-
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 27dcda0248..b4662b2795 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -998,6 +998,39 @@ void machine_add_audiodev_property(MachineClass *mc)
                                           "Audiodev to use for default machine devices");
 }
 
+static bool create_default_memdev(MachineState *ms, const char *path,
+                                  Error **errp)
+{
+    Object *obj;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    bool r = false;
+
+    obj = object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKEND_RAM);
+    if (path) {
+        if (!object_property_set_str(obj, "mem-path", path, errp)) {
+            goto out;
+        }
+    }
+    if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
+        goto out;
+    }
+    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
+                              obj);
+    /* Ensure backend's memory region name is equal to mc->default_ram_id */
+    if (!object_property_set_bool(obj, "x-use-canonical-path-for-ramblock-id",
+                             false, errp)) {
+        goto out;
+    }
+    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
+        goto out;
+    }
+    r = object_property_set_link(OBJECT(ms), "memory-backend", obj, errp);
+
+out:
+    object_unref(obj);
+    return r;
+}
+
 static void machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1017,6 +1050,8 @@ static void machine_class_init(ObjectClass *oc, void *data)
      */
     mc->numa_mem_align_shift = 23;
 
+    mc->create_default_memdev = create_default_memdev;
+
     object_class_property_add_str(oc, "kernel",
         machine_get_kernel, machine_set_kernel);
     object_class_property_set_description(oc, "kernel",
@@ -1410,38 +1445,6 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
     return ret;
 }
 
-static bool create_default_memdev(MachineState *ms, const char *path, Error **errp)
-{
-    Object *obj;
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-    bool r = false;
-
-    obj = object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKEND_RAM);
-    if (path) {
-        if (!object_property_set_str(obj, "mem-path", path, errp)) {
-            goto out;
-        }
-    }
-    if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
-        goto out;
-    }
-    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
-                              obj);
-    /* Ensure backend's memory region name is equal to mc->default_ram_id */
-    if (!object_property_set_bool(obj, "x-use-canonical-path-for-ramblock-id",
-                             false, errp)) {
-        goto out;
-    }
-    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
-        goto out;
-    }
-    r = object_property_set_link(OBJECT(ms), "memory-backend", obj, errp);
-
-out:
-    object_unref(obj);
-    return r;
-}
-
 const char *machine_class_default_cpu_type(MachineClass *mc)
 {
     if (mc->valid_cpu_types && !mc->valid_cpu_types[1]) {
@@ -1545,7 +1548,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
                 machine_class->default_ram_id);
             return;
         }
-        if (!create_default_memdev(current_machine, mem_path, errp)) {
+
+        if (!machine_class->create_default_memdev(current_machine, mem_path,
+                                                  errp)) {
             return;
         }
     }
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index eba8eaa960..821532c4c8 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -132,6 +132,7 @@ config MICROVM
 config NITRO_ENCLAVE
     default y
     depends on MICROVM
+    select VHOST_USER_VSOCK
 
 config X86_IOMMU
     bool
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index 98690c6373..280ab4cc9b 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -11,11 +11,81 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qom/object_interfaces.h"
 
+#include "chardev/char.h"
+#include "hw/sysbus.h"
 #include "hw/core/eif.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/microvm.h"
 #include "hw/i386/nitro_enclave.h"
+#include "hw/virtio/virtio-mmio.h"
+#include "hw/virtio/vhost-user-vsock.h"
+#include "sysemu/hostmem.h"
+
+static BusState *find_free_virtio_mmio_bus(void)
+{
+    BusChild *kid;
+    BusState *bus = sysbus_get_default();
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev = kid->child;
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO)) {
+            VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
+            VirtioBusState *mmio_virtio_bus = &mmio->bus;
+            BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
+            if (QTAILQ_EMPTY(&mmio_bus->children)) {
+                return mmio_bus;
+            }
+        }
+    }
+
+    return NULL;
+}
+
+static void vhost_user_vsock_init(NitroEnclaveMachineState *nems)
+{
+    DeviceState *dev = qdev_new(TYPE_VHOST_USER_VSOCK);
+    VHostUserVSock *vsock = VHOST_USER_VSOCK(dev);
+    BusState *bus;
+
+    if (!nems->vsock) {
+        error_report("A valid chardev id for vhost-user-vsock device must be "
+                     "provided using the 'vsock' machine option");
+        exit(1);
+    }
+
+    bus = find_free_virtio_mmio_bus();
+    if (!bus) {
+        error_report("Failed to find bus for vhost-user-vsock device");
+        exit(1);
+    }
+
+    Chardev *chardev = qemu_chr_find(nems->vsock);
+    if (!chardev) {
+        error_report("Failed to find chardev with id %s", nems->vsock);
+        exit(1);
+    }
+
+    vsock->conf.chardev.chr = chardev;
+
+    qdev_realize_and_unref(dev, bus, &error_fatal);
+}
+
+static void nitro_enclave_devices_init(NitroEnclaveMachineState *nems)
+{
+    vhost_user_vsock_init(nems);
+}
+
+static void nitro_enclave_machine_state_init(MachineState *machine)
+{
+    NitroEnclaveMachineClass *ne_class =
+        NITRO_ENCLAVE_MACHINE_GET_CLASS(machine);
+    NitroEnclaveMachineState *ne_state = NITRO_ENCLAVE_MACHINE(machine);
+
+    ne_class->parent_init(machine);
+    nitro_enclave_devices_init(ne_state);
+}
 
 static void nitro_enclave_machine_initfn(Object *obj)
 {
@@ -66,15 +136,68 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
     return;
 }
 
+static bool create_memfd_backend(MachineState *ms, const char *path,
+                                 Error **errp)
+{
+    Object *obj;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    bool r = false;
+
+    obj = object_new(TYPE_MEMORY_BACKEND_MEMFD);
+    if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
+        goto out;
+    }
+    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
+                              obj);
+
+    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
+        goto out;
+    }
+    r = object_property_set_link(OBJECT(ms), "memory-backend", obj, errp);
+
+out:
+    object_unref(obj);
+    return r;
+}
+
+static char *nitro_enclave_get_vsock_chardev_id(Object *obj, Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    return g_strdup(nems->vsock);
+}
+
+static void nitro_enclave_set_vsock_chardev_id(Object *obj, const char *value,
+                                               Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->vsock);
+    nems->vsock = g_strdup(value);
+}
+
 static void nitro_enclave_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
+    NitroEnclaveMachineClass *nemc = NITRO_ENCLAVE_MACHINE_CLASS(oc);
 
     mmc->x86_load_linux = x86_load_eif;
 
     mc->family = "nitro_enclave_i386";
     mc->desc = "AWS Nitro Enclave";
+
+    nemc->parent_init = mc->init;
+    mc->init = nitro_enclave_machine_state_init;
+
+    mc->create_default_memdev = create_memfd_backend;
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
+                                  nitro_enclave_get_vsock_chardev_id,
+                                  nitro_enclave_set_vsock_chardev_id);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
+                                          "Set chardev id for vhost-user-vsock "
+                                          "device");
 }
 
 static const TypeInfo nitro_enclave_machine_info = {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 48ff6d8b93..c268e7f005 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -308,6 +308,8 @@ struct MachineClass {
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
     ram_addr_t (*fixup_ram_size)(ram_addr_t size);
     uint64_t smbios_memory_device_size;
+    bool (*create_default_memdev)(MachineState *ms, const char *path,
+                                  Error **errp);
 };
 
 /**
diff --git a/include/hw/i386/nitro_enclave.h b/include/hw/i386/nitro_enclave.h
index a1dada9371..3e302de851 100644
--- a/include/hw/i386/nitro_enclave.h
+++ b/include/hw/i386/nitro_enclave.h
@@ -14,12 +14,20 @@
 #include "hw/i386/microvm.h"
 #include "qom/object.h"
 
+/* Machine type options */
+#define NITRO_ENCLAVE_VSOCK_CHARDEV_ID "vsock"
+
 struct NitroEnclaveMachineClass {
     MicrovmMachineClass parent;
+
+    void (*parent_init)(MachineState *state);
 };
 
 struct NitroEnclaveMachineState {
     MicrovmMachineState parent;
+
+    /* Machine type options */
+    char *vsock;
 };
 
 #define TYPE_NITRO_ENCLAVE_MACHINE MACHINE_TYPE_NAME("nitro-enclave")
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index de47ae59e4..67f45abe39 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -39,6 +39,8 @@ OBJECT_DECLARE_TYPE(HostMemoryBackend, HostMemoryBackendClass,
  */
 #define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
 
+#define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
+
 
 /**
  * HostMemoryBackendClass:
-- 
2.39.2


