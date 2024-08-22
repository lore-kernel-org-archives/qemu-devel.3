Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154EBC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9Rq-0000AV-Bb; Thu, 22 Aug 2024 11:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9Ro-0008Vt-Sz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:10:00 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9Rl-00053g-Jl
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:10:00 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2d3c5f769d6so669268a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724339396; x=1724944196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fk9kEBvjTnQ5i2HjwjK6rHdXtVSY94Nibsoxtw66GYo=;
 b=R8AcNynHWYuBtSIgVI93YyQ1V33meGiM3sJ67S4NTlEbqjJJyKzRpxfAxTnCGfbxOA
 g/QQncqNEAMGpCh5F3BPW/i3+jQpQtkiwfdw8pG1J1ipF/yEbLWlYCnlxQ+ua6C9puW3
 cniWzxgDVhkpVHTx9d7xI4msfhDxFFfD33ylLr3kcuB+o8G/C4s5Fi04NwqO48sS9O8G
 cgNHfMfZwtbWTIFph8dJdeB5daHnoaxSxgNcIbJwQK0LsbGq+k3qyS7SvZ6W3+0fclcw
 kAU6AgmIA7I+BI7V2mnJR5QvxQ1/a+SpXnh/DBxyEvlD8g94A/4EfCuvB2OqqjBdCSEG
 e/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724339396; x=1724944196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fk9kEBvjTnQ5i2HjwjK6rHdXtVSY94Nibsoxtw66GYo=;
 b=BlSHN544EmD4Bk6I0OUNN06CiAPHxTHEFfYuDl42WggSNq5BifV3Sgly3bH4mfO5q9
 y8+Cxi5taCHf9r+DcxYQZg2u8MwFM75goNQANdPrqns+TxYxgt1P9KXOV8Nd4UF9ZEQa
 FUuWGkYPUS2AYWWdvuTSCph1YR2dvTm76MIfQy4OuhVoO/DPrBZYoSOfhDcT2iyUZhnp
 1Jbg432lqHNJycjRzneVF9tITscDKEMc85gk07CVWx85N/f97w2JgA/ETOMrVjC6MNqK
 YQjQLX9G3CIi2KzjID+5Pfkj4euOk2TMWeESBwu9wJogCtNYvocLXHr1WwPYdZMce0PS
 KW0A==
X-Gm-Message-State: AOJu0YzlDwB4vJXu2gjIjMNJ3wEzjHowhuvL+uQE9WRM2E/nuAT7rkG8
 3IZEbT5AAwsglJ9ycnDfLTfaAFp1zVjCow6RTzGhVvmjMd0Rv67+zhCGxg==
X-Google-Smtp-Source: AGHT+IGemNPOKQWonuPX9Itwn3mvc8Ndz9aM9vN9GHciM5MifVe8crIo7zsyEGURYYx0pACn7pfr4g==
X-Received: by 2002:a17:90a:ad7:b0:2d3:c0d4:2c33 with SMTP id
 98e67ed59e1d1-2d616ae9acfmr2373062a91.17.1724339395668; 
 Thu, 22 Aug 2024 08:09:55 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.175])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613919fd2sm1991567a91.13.2024.08.22.08.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 08:09:55 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v5 7/8] machine/nitro-enclave: New machine type for AWS Nitro
 Enclaves
Date: Thu, 22 Aug 2024 21:08:48 +0600
Message-Id: <20240822150849.21759-8-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822150849.21759-1-dorjoychy111@gmail.com>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

AWS nitro enclaves[1] is an Amazon EC2[2] feature that allows creating
isolated execution environments, called enclaves, from Amazon EC2
instances which are used for processing highly sensitive data. Enclaves
have no persistent storage and no external networking. The enclave VMs
are based on the Firecracker microvm with a vhost-vsock device for
communication with the parent EC2 instance that spawned it and a Nitro
Secure Module (NSM) device for cryptographic attestation. The parent
instance VM always has CID 3 while the enclave VM gets a dynamic CID.

An EIF (Enclave Image Format)[3] file is used to boot an AWS nitro enclave
virtual machine. This commit adds support for AWS nitro enclave emulation
using a new machine type option '-M nitro-enclave'. This new machine type
is based on the 'microvm' machine type, similar to how real nitro enclave
VMs are based on Firecracker microvm. For nitro-enclave to boot from an
EIF file, the kernel and ramdisk(s) are extracted into a temporary kernel
and a temporary initrd file which are then hooked into the regular x86
boot mechanism along with the extracted cmdline. The EIF file path should
be provided using the '-kernel' QEMU option.

In QEMU, the vsock emulation for nitro enclave is added using vhost-user-
vsock as opposed to vhost-vsock. vhost-vsock doesn't support sibling VM
communication which is needed for nitro enclaves. So for the vsock
communication to CID 3 to work, another process that does the vsock
emulation in  userspace must be run, for example, vhost-device-vsock[4]
from rust-vmm, with necessary vsock communication support in another
guest VM with CID 3. Using vhost-user-vsock also enables the possibility
to implement some proxying support in the vhost-user-vsock daemon that
will forward all the packets to the host machine instead of CID 3 so
that users of nitro-enclave can run the necessary applications in their
host machine instead of running another whole VM with CID 3. The following
mandatory nitro-enclave machine option has been added related to the
vhost-user-vsock device.
  - 'vsock': The chardev id from the '-chardev' option for the
vhost-user-vsock device.

AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
has been added using the virtio-nsm device added in a previous commit.
In Nitro Enclaves, all the PCRs start in a known zero state and the first
16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR8
contain the SHA384 hashes related to the EIF file used to boot the VM
for validation. The following optional nitro-enclave machine options
have been added related to the NSM device.
  - 'id': Enclave identifier, reflected in the module-id of the NSM
device. If not provided, a default id will be set.
  - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
of the NSM device.
  - 'parent-id': Parent instance identifier, reflected in PCR4 of the
NSM device.

[1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
[2] https://aws.amazon.com/ec2/
[3] https://github.com/aws/aws-nitro-enclaves-image-format
[4] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 MAINTAINERS                              |   9 +
 backends/hostmem-memfd.c                 |   2 -
 configs/devices/i386-softmmu/default.mak |   1 +
 hw/core/machine.c                        |  71 ++---
 hw/core/meson.build                      |   3 +
 hw/i386/Kconfig                          |   6 +
 hw/i386/meson.build                      |   3 +
 hw/i386/microvm.c                        |   6 +-
 hw/i386/nitro_enclave.c                  | 355 +++++++++++++++++++++++
 include/hw/boards.h                      |   2 +
 include/hw/i386/microvm.h                |   2 +
 include/hw/i386/nitro_enclave.h          |  62 ++++
 include/sysemu/hostmem.h                 |   2 +
 13 files changed, 488 insertions(+), 36 deletions(-)
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 include/hw/i386/nitro_enclave.h

diff --git a/MAINTAINERS b/MAINTAINERS
index da4f698137..aa7846107e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1877,6 +1877,15 @@ F: hw/i386/microvm.c
 F: include/hw/i386/microvm.h
 F: pc-bios/bios-microvm.bin
 
+nitro-enclave
+M: Alexander Graf <graf@amazon.com>
+M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
+S: Maintained
+F: hw/core/eif.c
+F: hw/core/eif.h
+F: hw/i386/nitro_enclave.c
+F: include/hw/i386/nitro_enclave.h
+
 Machine core
 M: Eduardo Habkost <eduardo@habkost.net>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
 
 
diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 448e3e3b1b..4faf2f0315 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -29,3 +29,4 @@
 # CONFIG_I440FX=n
 # CONFIG_Q35=n
 # CONFIG_MICROVM=n
+# CONFIG_NITRO_ENCLAVE=n
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
diff --git a/hw/core/meson.build b/hw/core/meson.build
index a3d9bab9f4..5437a94490 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -24,6 +24,9 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
 system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
+if libcbor.found() and gnutls.found()
+  system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib, libcbor, gnutls])
+endif
 
 system_ss.add(files(
   'cpu-sysemu.c',
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index f4a33b6c08..63271bf915 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -129,6 +129,12 @@ config MICROVM
     select USB_XHCI_SYSBUS
     select I8254
 
+config NITRO_ENCLAVE
+    default y
+    depends on MICROVM
+    select VHOST_USER_VSOCK
+    select VIRTIO_NSM
+
 config X86_IOMMU
     bool
     depends on PC
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 03aad10df7..1ddd7a83be 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -15,6 +15,9 @@ i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
+if libcbor.found() and gnutls.found()
+  i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
+endif
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
 i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 40edcee7af..869c177642 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -283,6 +283,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
 static void microvm_memory_init(MicrovmMachineState *mms)
 {
+    MicrovmMachineClass *mmc = MICROVM_MACHINE_GET_CLASS(mms);
     MachineState *machine = MACHINE(mms);
     X86MachineState *x86ms = X86_MACHINE(mms);
     MemoryRegion *ram_below_4g, *ram_above_4g;
@@ -328,7 +329,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        x86_load_linux(x86ms, fw_cfg, 0, true);
+        mmc->x86_load_linux(x86ms, fw_cfg, 0, true);
     }
 
     if (mms->option_roms) {
@@ -637,9 +638,12 @@ GlobalProperty microvm_properties[] = {
 static void microvm_class_init(ObjectClass *oc, void *data)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
+    MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
+    mmc->x86_load_linux = x86_load_linux;
+
     mc->init = microvm_machine_state_init;
 
     mc->family = "microvm_i386";
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
new file mode 100644
index 0000000000..7dbeee530f
--- /dev/null
+++ b/hw/i386/nitro_enclave.c
@@ -0,0 +1,355 @@
+/*
+ * AWS nitro-enclave machine
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+
+#include "chardev/char.h"
+#include "hw/sysbus.h"
+#include "hw/core/eif.h"
+#include "hw/i386/x86.h"
+#include "hw/i386/microvm.h"
+#include "hw/i386/nitro_enclave.h"
+#include "hw/virtio/virtio-mmio.h"
+#include "hw/virtio/virtio-nsm.h"
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
+static void virtio_nsm_init(NitroEnclaveMachineState *nems)
+{
+    DeviceState *dev = qdev_new(TYPE_VIRTIO_NSM);
+    VirtIONSM *vnsm = VIRTIO_NSM(dev);
+    BusState *bus = find_free_virtio_mmio_bus();
+
+    if (!bus) {
+        error_report("Failed to find bus for virtio-nsm device.");
+        exit(1);
+    }
+
+    qdev_prop_set_string(dev, "module-id", nems->id);
+
+    qdev_realize_and_unref(dev, bus, &error_fatal);
+    nems->vnsm = vnsm;
+}
+
+static void nitro_enclave_devices_init(NitroEnclaveMachineState *nems)
+{
+    vhost_user_vsock_init(nems);
+    virtio_nsm_init(nems);
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
+
+static void nitro_enclave_machine_reset(MachineState *machine,
+                                        ShutdownCause reason)
+{
+    NitroEnclaveMachineClass *ne_class =
+        NITRO_ENCLAVE_MACHINE_GET_CLASS(machine);
+    NitroEnclaveMachineState *ne_state = NITRO_ENCLAVE_MACHINE(machine);
+
+    ne_class->parent_reset(machine, reason);
+
+    memset(ne_state->vnsm->pcrs, 0, sizeof(ne_state->vnsm->pcrs));
+
+    /* PCR0 */
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 0, ne_state->image_sha384,
+                               QCRYPTO_HASH_DIGEST_LEN_SHA384);
+    /* PCR1 */
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 1, ne_state->bootstrap_sha384,
+                               QCRYPTO_HASH_DIGEST_LEN_SHA384);
+    /* PCR2 */
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 2, ne_state->app_sha384,
+                               QCRYPTO_HASH_DIGEST_LEN_SHA384);
+    /* PCR3 */
+    if (ne_state->parent_role) {
+        ne_state->vnsm->extend_pcr(ne_state->vnsm, 3,
+                                   (uint8_t *) ne_state->parent_role,
+                                   strlen(ne_state->parent_role));
+    }
+    /* PCR4 */
+    if (ne_state->parent_id) {
+        ne_state->vnsm->extend_pcr(ne_state->vnsm, 4,
+                                   (uint8_t *) ne_state->parent_id,
+                                   strlen(ne_state->parent_id));
+    }
+    /* PCR8 */
+    if (ne_state->signature_found) {
+        ne_state->vnsm->extend_pcr(ne_state->vnsm, 8,
+                                   ne_state->fingerprint_sha384,
+                                   QCRYPTO_HASH_DIGEST_LEN_SHA384);
+    }
+
+    /* First 16 PCRs are locked from boot and reserved for nitro enclave */
+    for (int i = 0; i < 16; ++i) {
+        ne_state->vnsm->lock_pcr(ne_state->vnsm, i);
+    }
+}
+
+static void nitro_enclave_machine_initfn(Object *obj)
+{
+    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
+    X86MachineState *x86ms = X86_MACHINE(obj);
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    nems->id = g_strdup("i-234-enc5678");
+
+    /* AWS nitro enclaves have PCIE and ACPI disabled */
+    mms->pcie = ON_OFF_AUTO_OFF;
+    x86ms->acpi = ON_OFF_AUTO_OFF;
+}
+
+static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
+                         int acpi_data_size, bool pvh_enabled)
+{
+    Error *err = NULL;
+    char *eif_kernel, *eif_initrd, *eif_cmdline;
+    MachineState *machine = MACHINE(x86ms);
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(x86ms);
+
+    if (!read_eif_file(machine->kernel_filename, machine->initrd_filename,
+                       &eif_kernel, &eif_initrd, &eif_cmdline,
+                       nems->image_sha384, nems->bootstrap_sha384,
+                       nems->app_sha384, nems->fingerprint_sha384,
+                       &(nems->signature_found), &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    g_free(machine->kernel_filename);
+    machine->kernel_filename = eif_kernel;
+    g_free(machine->initrd_filename);
+    machine->initrd_filename = eif_initrd;
+
+    /*
+     * If kernel cmdline argument was provided, let's concatenate it to the
+     * extracted EIF kernel cmdline.
+     */
+    if (machine->kernel_cmdline != NULL) {
+        char *cmd = g_strdup_printf("%s %s", eif_cmdline,
+                                    machine->kernel_cmdline);
+        g_free(eif_cmdline);
+        g_free(machine->kernel_cmdline);
+        machine->kernel_cmdline = cmd;
+    } else {
+        machine->kernel_cmdline = eif_cmdline;
+    }
+
+    x86_load_linux(x86ms, fw_cfg, 0, true);
+
+    unlink(machine->kernel_filename);
+    unlink(machine->initrd_filename);
+    return;
+}
+
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
+static char *nitro_enclave_get_id(Object *obj, Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    return g_strdup(nems->id);
+}
+
+static void nitro_enclave_set_id(Object *obj, const char *value,
+                                            Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->id);
+    nems->id = g_strdup(value);
+}
+
+static char *nitro_enclave_get_parent_role(Object *obj, Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    return g_strdup(nems->parent_role);
+}
+
+static void nitro_enclave_set_parent_role(Object *obj, const char *value,
+                                          Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->parent_role);
+    nems->parent_role = g_strdup(value);
+}
+
+static char *nitro_enclave_get_parent_id(Object *obj, Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    return g_strdup(nems->parent_id);
+}
+
+static void nitro_enclave_set_parent_id(Object *obj, const char *value,
+                                        Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->parent_id);
+    nems->parent_id = g_strdup(value);
+}
+
+static void nitro_enclave_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
+    NitroEnclaveMachineClass *nemc = NITRO_ENCLAVE_MACHINE_CLASS(oc);
+
+    mmc->x86_load_linux = x86_load_eif;
+
+    mc->family = "nitro_enclave_i386";
+    mc->desc = "AWS Nitro Enclave";
+
+    nemc->parent_init = mc->init;
+    mc->init = nitro_enclave_machine_state_init;
+
+    nemc->parent_reset = mc->reset;
+    mc->reset = nitro_enclave_machine_reset;
+
+    mc->create_default_memdev = create_memfd_backend;
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
+                                  nitro_enclave_get_vsock_chardev_id,
+                                  nitro_enclave_set_vsock_chardev_id);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
+                                          "Set chardev id for vhost-user-vsock "
+                                          "device");
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_ID, nitro_enclave_get_id,
+                                  nitro_enclave_set_id);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_ID,
+                                          "Set enclave identifier");
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_PARENT_ROLE,
+                                  nitro_enclave_get_parent_role,
+                                  nitro_enclave_set_parent_role);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_PARENT_ROLE,
+                                          "Set parent instance IAM role ARN");
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_PARENT_ID,
+                                  nitro_enclave_get_parent_id,
+                                  nitro_enclave_set_parent_id);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_PARENT_ID,
+                                          "Set parent instance identifier");
+}
+
+static const TypeInfo nitro_enclave_machine_info = {
+    .name          = TYPE_NITRO_ENCLAVE_MACHINE,
+    .parent        = TYPE_MICROVM_MACHINE,
+    .instance_size = sizeof(NitroEnclaveMachineState),
+    .instance_init = nitro_enclave_machine_initfn,
+    .class_size    = sizeof(NitroEnclaveMachineClass),
+    .class_init    = nitro_enclave_class_init,
+};
+
+static void nitro_enclave_machine_init(void)
+{
+    type_register_static(&nitro_enclave_machine_info);
+}
+type_init(nitro_enclave_machine_init);
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
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index fad97a891d..b9ac34a3ef 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -78,6 +78,8 @@ struct MicrovmMachineClass {
     X86MachineClass parent;
     HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
+    void (*x86_load_linux)(X86MachineState *x86ms, FWCfgState *fw_cfg,
+                        int acpi_data_size, bool pvh_enabled);
 };
 
 struct MicrovmMachineState {
diff --git a/include/hw/i386/nitro_enclave.h b/include/hw/i386/nitro_enclave.h
new file mode 100644
index 0000000000..687c88cb54
--- /dev/null
+++ b/include/hw/i386/nitro_enclave.h
@@ -0,0 +1,62 @@
+/*
+ * AWS nitro-enclave machine
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef HW_I386_NITRO_ENCLAVE_H
+#define HW_I386_NITRO_ENCLAVE_H
+
+#include "crypto/hash.h"
+#include "hw/i386/microvm.h"
+#include "qom/object.h"
+#include "hw/virtio/virtio-nsm.h"
+
+/* Machine type options */
+#define NITRO_ENCLAVE_VSOCK_CHARDEV_ID "vsock"
+#define NITRO_ENCLAVE_ID    "id"
+#define NITRO_ENCLAVE_PARENT_ROLE "parent-role"
+#define NITRO_ENCLAVE_PARENT_ID "parent-id"
+
+struct NitroEnclaveMachineClass {
+    MicrovmMachineClass parent;
+
+    void (*parent_init)(MachineState *state);
+    void (*parent_reset)(MachineState *machine, ShutdownCause reason);
+};
+
+struct NitroEnclaveMachineState {
+    MicrovmMachineState parent;
+
+    /* Machine type options */
+    char *vsock;
+    /* Enclave identifier */
+    char *id;
+    /* Parent instance IAM role ARN */
+    char *parent_role;
+    /* Parent instance identifier */
+    char *parent_id;
+
+    /* Machine state */
+    VirtIONSM *vnsm;
+
+    /* kernel + ramdisks + cmdline sha384 hash */
+    uint8_t image_sha384[QCRYPTO_HASH_DIGEST_LEN_SHA384];
+    /* kernel + boot ramdisk + cmdline sha384 hash */
+    uint8_t bootstrap_sha384[QCRYPTO_HASH_DIGEST_LEN_SHA384];
+    /* application ramdisk(s) hash */
+    uint8_t app_sha384[QCRYPTO_HASH_DIGEST_LEN_SHA384];
+    /* certificate fingerprint hash */
+    uint8_t fingerprint_sha384[QCRYPTO_HASH_DIGEST_LEN_SHA384];
+    bool signature_found;
+};
+
+#define TYPE_NITRO_ENCLAVE_MACHINE MACHINE_TYPE_NAME("nitro-enclave")
+OBJECT_DECLARE_TYPE(NitroEnclaveMachineState, NitroEnclaveMachineClass,
+                    NITRO_ENCLAVE_MACHINE)
+
+#endif
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


