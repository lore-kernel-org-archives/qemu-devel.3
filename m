Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC87C25B7E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 16:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDRZr-0007IL-FR; Sat, 01 Jun 2024 12:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sDRZp-0007Hc-D9
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 12:27:29 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sDRZn-000881-3H
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 12:27:29 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-6c4f3e0e3d2so1141174a12.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717259244; x=1717864044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M03FvfURsmdCtAGINjDGY35+P1GzwVNmZmCY+CQ1+9g=;
 b=WtbU/8Ueme92CFufE6gP7WJ0bUFBDGRKU3hMMiDrd7GrbyqvThUFL8CIfjUZCB8ODR
 B+CAb79UKr4+gjuCFSyF19X9RZ+JypcVfGrhyP2KsKrOYdTWRaKaVyNRREWNEF67xB4E
 7ZFwfLq0mGP1j8D6/PREcJbnBkwM7Ew15IGnonWBAWZCmYL0XkSgYYk2twSM7yxKuCLW
 M0AlX+AGxCFc62ThPfe4gjOp1Vux83XcQMoefsIuA43r2ETwjLFECz+x77GIjzIlQ9kw
 5ZQVAx125hpcS+q0+hd4N9Kpzo8BekdvyZlyCdnD5ZWSWAl19RLD1krDaRUt21Kb26k4
 N2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717259244; x=1717864044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M03FvfURsmdCtAGINjDGY35+P1GzwVNmZmCY+CQ1+9g=;
 b=xF+CWQqwvZvOo5BG0FHJS8B/S33eCtHzwxXk+Hjvg9w4dGfQEspUntFGO1j8dRNMhT
 oEGuqxIt+YQMhGcYuIzzz51MRMB+WXZTknYJhQQI/jGw01nRlYRhtHgdKo7Fynqh/8tZ
 M/cWfAb22zi3/iFtI3xGrwMbLtcJBI6zaB4EidaL7Y3Xbc81BXvvi9rBKvYWmVfIRQdY
 4XwgqjLDsogKglySIqgNQJL8tq0l74lJ45KyDn5Tr0jtAOQ2h5R4fBZg+gQ8nD//owIz
 uaQZvO4rohvvMT+PqQWZBKDbYnVAd7ilGrHeiGYPhSaeK6FnC2d3lU+4FdoC2V4vCqY4
 CQmA==
X-Gm-Message-State: AOJu0YxUxFhKOsaE5nhNYfoe0lbx2j0gTLR7UYmd6NRxzLDi77wnLgjY
 NK0mPFtMkc3ffJlVSPqY/y1vet5WqNPXhdVKetM/4ZT9hijU4iTsvFKoMyRh
X-Google-Smtp-Source: AGHT+IFQjmQGUd2xuT0MyMpKBJJ7Yn/hDdc7JiU5IcXRV+eeAGcil+ujepRCM0Lm4+ACN0UuByD+Jg==
X-Received: by 2002:a17:90a:9f8d:b0:2bf:3859:d5a5 with SMTP id
 98e67ed59e1d1-2c1dc57016dmr4460323a91.11.1717259244061; 
 Sat, 01 Jun 2024 09:27:24 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1c27ad3cesm3285036a91.7.2024.06.01.09.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jun 2024 09:27:23 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 2/2] machine/nitro-enclave: new machine type for AWS nitro
 enclave
Date: Sat,  1 Jun 2024 22:26:52 +0600
Message-Id: <20240601162652.55643-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240601162652.55643-1-dorjoychy111@gmail.com>
References: <20240601162652.55643-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pg1-x52b.google.com
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
instances which are used for processing highly sensitive data.
Enclaves have no persistent storage and no external networking. The
enclave VMs are based on Firecracker microvm with a vhost-vsock
device for communication with the parent EC2 instance that spawned
it and a Nitro Secure Module (NSM) device for cryptographic attestation.
The parent instance VM always has CID 3 while the enclave VM gets a
dynamic CID.

This commit adds support for limited AWS nitro enclave emulation using
a new machine type option '-M nitro-enclave'. This new machine type is
based on the 'microvm' machine type (similar to how real nitro enclave
VMs are based on Firecracker microvm) which requires a mandatory
'guest-cid' machine type option which becomes the CID of the running
nitro-enclave VM using a built-in vhost-vsock device.

The code for checking and loading EIF in the microvm machine code added
in the previous commit has been put inside a 'nitro-enclave' machine
type check so that EIF images can only be loaded using a 'nitro-enclave'
machine.

Right now, the emulation support is not complete as nitro-enclave
cannot be run standalone using QEMU. A separate VM with CID 3 must be
run with the necessary vsock communication support that the enclave VM
communicates with. Also the Nitro Secure Module (NSM) device is not
implemented yet.

[1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
[2] https://aws.amazon.com/ec2/

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 MAINTAINERS                              |  10 ++
 configs/devices/i386-softmmu/default.mak |   1 +
 docs/system/i386/nitro-enclave.rst       |  58 ++++++++++
 hw/i386/Kconfig                          |   4 +
 hw/i386/meson.build                      |   1 +
 hw/i386/microvm.c                        |  21 ++--
 hw/i386/nitro_enclave.c                  | 134 +++++++++++++++++++++++
 include/hw/i386/nitro_enclave.h          |  38 +++++++
 8 files changed, 260 insertions(+), 7 deletions(-)
 create mode 100644 docs/system/i386/nitro-enclave.rst
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 include/hw/i386/nitro_enclave.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 448dc951c5..250ab32743 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1867,6 +1867,16 @@ F: hw/i386/microvm.c
 F: include/hw/i386/microvm.h
 F: pc-bios/bios-microvm.bin
 
+nitro-enclave
+M: Alexander Graf <graf@amazon.com>
+M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
+S: Maintained
+F: docs/system/i386/nitro-enclave.rst
+F: hw/core/eif.c
+F: hw/core/eif.h
+F: hw/i386/nitro_enclave.c
+F: include/hw/i386/nitro_enclave.h
+
 Machine core
 M: Eduardo Habkost <eduardo@habkost.net>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 448e3e3b1b..4faf2f0315 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -29,3 +29,4 @@
 # CONFIG_I440FX=n
 # CONFIG_Q35=n
 # CONFIG_MICROVM=n
+# CONFIG_NITRO_ENCLAVE=n
diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
new file mode 100644
index 0000000000..0b86b6ab88
--- /dev/null
+++ b/docs/system/i386/nitro-enclave.rst
@@ -0,0 +1,58 @@
+'nitro-enclave' virtual machine (``nitro-enclave``)
+===================================================
+
+``nitro-enclave`` is a machine type which emulates an ``AWS nitro enclave``
+virtual machine. `AWS nitro enclaves`_ is an `Amazon EC2`_ feature that allows
+creating isolated execution environments, called enclaves, from Amazon EC2
+instances which are used for processing highly sensitive data. Enclaves have
+no persistent storage and no external networking. The enclave VMs are based
+on Firecracker microvm with a vhost-vsock device for communication with the
+parent EC2 instance that spawned it and a Nitro Secure Module (NSM) device
+for cryptographic attestation. The parent instance VM always has CID 3 while
+the enclave VM gets a dynamic CID. Enclaves use an EIF (`Enclave Image Format`_)
+file which contains the necessary kernel, cmdline and ramdisk(s) to boot.
+
+In QEMU, ``nitro-enclave`` is a machine type based on ``microvm`` similar to how
+``AWS nitro enclaves`` are based on ``Firecracker``. This is useful for local
+testing of EIF images using QEMU instead of running real AWS Nitro Enclaves
+which can be difficult for debugging due to its roots in security.
+
+.. _AWS nitro enlaves: https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
+.. _Amazon EC2: https://aws.amazon.com/ec2/
+.. _Enclave Image Format: https://github.com/aws/aws-nitro-enclaves-image-format
+
+
+Limitations
+-----------
+
+AWS nitro enclave emulation support is not complete yet:
+
+- Although support for the vhost-vsock device is implemented, standalone
+nitro-enclave VMs cannot be run right now as nitro-enclave VMs communicate
+with a parent instance VM with CID 3. So another VM with CID 3 must be run
+with necessary vsock communication support.
+- Enclaves also have a Nitro Secure Module (NSM) device which is not implemented
+yet.
+
+
+Using the nitro-enclave machine type
+------------------------------
+
+Machine-specific options
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+It supports the following machine-specific options:
+
+- nitro-enclave.guest-cid=uint32_t (required) (Set nitro enclave VM's CID)
+
+
+Running a nitro-enclave VM
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A nitro-enclave VM can be run using the following command where ``hello.eif`` is
+an EIF image you would use to spawn a real AWS nitro enclave virtual machine:
+
+  $ sudo qemu-system-x86_64 -M nitro-enclave,guest-cid=8 \
+     -enable-kvm -cpu host -m 512m \
+     -kernel hello.eif \
+     -nographic
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index f4a33b6c08..eba8eaa960 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -129,6 +129,10 @@ config MICROVM
     select USB_XHCI_SYSBUS
     select I8254
 
+config NITRO_ENCLAVE
+    default y
+    depends on MICROVM
+
 config X86_IOMMU
     bool
     depends on PC
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 03aad10df7..10bdfde27c 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -15,6 +15,7 @@ i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
+i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
 i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 27d092ed29..fd07825c6c 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -35,6 +35,7 @@
 #include "hw/irq.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/i386/microvm.h"
+#include "hw/i386/nitro_enclave.h"
 #include "hw/i386/x86.h"
 #include "target/i386/cpu.h"
 #include "hw/intc/i8259.h"
@@ -452,13 +453,19 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        Error *err;
-        bool is_eif = false;
-        if (!check_if_eif_file(machine->kernel_filename, &is_eif, &err)) {
-            error_report_err(err);
-            exit(1);
-        }
-        if (is_eif) {
+        if (object_dynamic_cast(OBJECT(machine), TYPE_NITRO_ENCLAVE_MACHINE)) {
+            Error *err;
+            bool is_eif = false;
+            if (!check_if_eif_file(machine->kernel_filename, &is_eif, &err)) {
+                error_report_err(err);
+                exit(1);
+            }
+            if (!is_eif) {
+                error_report("%s is not a valid EIF file.",
+                             machine->kernel_filename);
+                exit(1);
+            }
+
             load_eif(mms, fw_cfg);
         } else {
             x86_load_linux(x86ms, fw_cfg, 0, true);
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
new file mode 100644
index 0000000000..5a9b9b04bf
--- /dev/null
+++ b/hw/i386/nitro_enclave.c
@@ -0,0 +1,134 @@
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
+#include "qapi/visitor.h"
+
+#include "hw/sysbus.h"
+#include "hw/i386/x86.h"
+#include "hw/i386/microvm.h"
+#include "hw/i386/nitro_enclave.h"
+#include "hw/virtio/vhost-vsock.h"
+#include "hw/virtio/virtio-mmio.h"
+
+static BusState *find_virtio_mmio_bus(void)
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
+            return mmio_bus;
+        }
+    }
+
+    return NULL;
+}
+
+static void nitro_enclave_devices_init(NitroEnclaveMachineState *nems)
+{
+    DeviceState *dev = qdev_new(TYPE_VHOST_VSOCK);
+    BusState *bus = find_virtio_mmio_bus();
+    if (!bus) {
+        error_report("Failed to find bus for vhost-vsock device.");
+        exit(1);
+    }
+
+    if (nems->guest_cid <= 3) {
+        error_report("Nitro enclave machine option 'guest-cid' must be set "
+                     "with a value greater than or equal to 4");
+        exit(1);
+    }
+
+    qdev_prop_set_uint64(dev, "guest-cid", nems->guest_cid);
+    qdev_realize_and_unref(dev, bus, &error_fatal);
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
+static void nitro_enclave_machine_initfn(Object *obj)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
+    X86MachineState *x86ms = X86_MACHINE(obj);
+
+    nems->guest_cid = 0;
+
+    /* AWS nitro enclaves have PCIE and ACPI disabled */
+    mms->pcie = ON_OFF_AUTO_OFF;
+    x86ms->acpi = ON_OFF_AUTO_OFF;
+}
+
+static void nitro_enclave_get_guest_cid(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+    uint32_t guest_cid = nems->guest_cid;
+
+    visit_type_uint32(v, name, &guest_cid, errp);
+}
+
+static void nitro_enclave_set_guest_cid(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    visit_type_uint32(v, name, &nems->guest_cid, errp);
+}
+
+static void nitro_enclave_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    NitroEnclaveMachineClass *nemc = NITRO_ENCLAVE_MACHINE_CLASS(oc);
+
+    mc->family = "nitro_enclave_i386";
+    mc->desc = "AWS Nitro Enclave";
+
+    nemc->parent_init = mc->init;
+    mc->init = nitro_enclave_machine_state_init;
+
+    object_class_property_add(oc, NITRO_ENCLAVE_GUEST_CID, "uint32_t",
+                              nitro_enclave_get_guest_cid,
+                              nitro_enclave_set_guest_cid,
+                              NULL, NULL);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_GUEST_CID,
+                                          "Set enclave machine's cid");
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
diff --git a/include/hw/i386/nitro_enclave.h b/include/hw/i386/nitro_enclave.h
new file mode 100644
index 0000000000..9dc3afd494
--- /dev/null
+++ b/include/hw/i386/nitro_enclave.h
@@ -0,0 +1,38 @@
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
+#include "hw/boards.h"
+#include "hw/i386/microvm.h"
+#include "qom/object.h"
+
+/* Machine type options */
+#define NITRO_ENCLAVE_GUEST_CID  "guest-cid"
+
+struct NitroEnclaveMachineClass {
+    MicrovmMachineClass parent;
+
+    void (*parent_init)(MachineState *state);
+};
+
+struct NitroEnclaveMachineState {
+    MicrovmMachineState parent;
+
+    /* Machine type options */
+    uint32_t guest_cid;
+};
+
+#define TYPE_NITRO_ENCLAVE_MACHINE MACHINE_TYPE_NAME("nitro-enclave")
+OBJECT_DECLARE_TYPE(NitroEnclaveMachineState, NitroEnclaveMachineClass,
+                    NITRO_ENCLAVE_MACHINE)
+
+#endif
-- 
2.39.2


