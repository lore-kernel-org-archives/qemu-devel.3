Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE0BD767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNl-0004OP-Fp; Thu, 31 Oct 2024 13:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMG-0001UI-5v
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMC-0007O8-3r
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3tW+R97Q4KNjmoQV4G8ZnERu1CG8juj8siuK6SGGUE=;
 b=TBaEc5vMr8ugaa0qJc7R/g9/PpF6Mium3NaEfXUIKKWMmQEtx7wFc0U3H2i5eWLj1pwVdb
 nCTRYwPbZqe3P5HMrwaDC4yo/A7hXikbYdyIcrA5DJrahntzbQ2LK2wDfdvjuP/otd0qqF
 YzANw4ycCsKdWmu04H063GED0JDdwpQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-yC9cjo7nP-WbOvDXzM2UgA-1; Thu, 31 Oct 2024 13:53:14 -0400
X-MC-Unique: yC9cjo7nP-WbOvDXzM2UgA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314a22ed8bso8561205e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397192; x=1731001992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3tW+R97Q4KNjmoQV4G8ZnERu1CG8juj8siuK6SGGUE=;
 b=TgCMNE0apgtVJ8CP85oIzLzqZ3IA2q/bZHBLXO99KtCBj9D7p8xdl9QO/Di7iyCPjj
 tayVdZwMR5FVkZYln2aTaM1ufh/0fJnLL905w4emZLdPbrq7oW9k+3g5bjY4y2GTMJbn
 H68+H7P25cRPLE9aRJOocARgFCwgaw0DPn67sf11gq0PAz0wTMw9f0X0D7kEpmxcqr/R
 aiDfHWl2UA8CHikEPtnvmyvYsSfhMivhiZe11AHivQ5HBU76oMuUzUEyWdbOw0OsTdc5
 oMZ/U6+hOzS21BMtVEFUp1wqEv1IR4NMgXho5BhlJobH4e+ByYT4EWmIIz/K28JOhQQh
 0F7w==
X-Gm-Message-State: AOJu0YxoXkPKMja4/HKKUW5eNqjoMBf/fR1Sb+u4RpwqVO8edhavL/tG
 H3DJIZ6slLrCM4aIQ4OjPQ+e/+pFxvMtKH2U7RNXS60D1wgGXvXpYvjA+0HtI2lCf+IdHZlnyqO
 snpBk5r45wxeXbTqG2AS0a1Zg19tb5Cx5WvfCFUI3qB5iJxItvWqBptIDzJ4epxbQQsFW1ikZZ1
 rLtuTlUcZr+ORY1nKXX9RDiKNImd0x9LgM/76MVpY=
X-Received: by 2002:a05:600c:4f05:b0:431:52b7:a47e with SMTP id
 5b1f17b1804b1-4327b8012a0mr34735565e9.35.1730397192246; 
 Thu, 31 Oct 2024 10:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaktCHpV4LvOAVKlkXzR7EnAAEUaCO8JnO9IQ3gW2eurff4MlEzHozTzq5SHiFLuYeHL6fPg==
X-Received: by 2002:a05:600c:4f05:b0:431:52b7:a47e with SMTP id
 5b1f17b1804b1-4327b8012a0mr34735335e9.35.1730397191685; 
 Thu, 31 Oct 2024 10:53:11 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e61f9sm2782105f8f.58.2024.10.31.10.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, Alexander Graf <graf@amazon.com>
Subject: [PULL 25/49] machine/nitro-enclave: New machine type for AWS Nitro
 Enclaves
Date: Thu, 31 Oct 2024 18:51:49 +0100
Message-ID: <20241031175214.214455-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

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
Reviewed-by: Alexander Graf <graf@amazon.com>
Link: https://lore.kernel.org/r/20241008211727.49088-6-dorjoychy111@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                              |   2 +
 configs/devices/i386-softmmu/default.mak |   1 +
 include/hw/i386/microvm.h                |   2 +
 include/hw/i386/nitro_enclave.h          |  62 ++++
 hw/i386/microvm.c                        |   6 +-
 hw/i386/nitro_enclave.c                  | 354 +++++++++++++++++++++++
 hw/i386/Kconfig                          |  10 +
 hw/i386/meson.build                      |   1 +
 8 files changed, 437 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/i386/nitro_enclave.h
 create mode 100644 hw/i386/nitro_enclave.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 19b7d54a193..5d3501ac289 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1840,6 +1840,8 @@ M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
 S: Maintained
 F: hw/core/eif.c
 F: hw/core/eif.h
+F: hw/i386/nitro_enclave.c
+F: include/hw/i386/nitro_enclave.h
 
 Machine core
 M: Eduardo Habkost <eduardo@habkost.net>
diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 448e3e3b1ba..4faf2f0315e 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -29,3 +29,4 @@
 # CONFIG_I440FX=n
 # CONFIG_Q35=n
 # CONFIG_MICROVM=n
+# CONFIG_NITRO_ENCLAVE=n
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index fad97a891dc..b9ac34a3ef1 100644
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
index 00000000000..b65875033cc
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
+    void (*parent_reset)(MachineState *machine, ResetType type);
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
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 693099f2256..86637afa0f3 100644
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
index 00000000000..b6263ae1273
--- /dev/null
+++ b/hw/i386/nitro_enclave.c
@@ -0,0 +1,354 @@
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
+static void nitro_enclave_machine_reset(MachineState *machine, ResetType type)
+{
+    NitroEnclaveMachineClass *ne_class =
+        NITRO_ENCLAVE_MACHINE_GET_CLASS(machine);
+    NitroEnclaveMachineState *ne_state = NITRO_ENCLAVE_MACHINE(machine);
+
+    ne_class->parent_reset(machine, type);
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
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index f4a33b6c082..32818480d26 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -129,6 +129,16 @@ config MICROVM
     select USB_XHCI_SYSBUS
     select I8254
 
+config NITRO_ENCLAVE
+    default y
+    depends on I386 && FDT # for MICROVM
+    depends on LIBCBOR && GNUTLS # for EIF and VIRTIO_NSM
+    depends on VHOST_USER # for VHOST_USER_VSOCK
+    select EIF
+    select MICROVM
+    select VHOST_USER_VSOCK
+    select VIRTIO_NSM
+
 config X86_IOMMU
     bool
     depends on PC
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 03aad10df7a..10bdfde27c6 100644
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
-- 
2.47.0


