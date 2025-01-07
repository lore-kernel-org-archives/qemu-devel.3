Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAE9E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCRS-0001dK-Co; Tue, 07 Jan 2025 11:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+f031519a9170f34b3d42+7807+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVCRN-0001cq-0y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:28:25 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+f031519a9170f34b3d42+7807+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVCRJ-00036G-Am
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=4TlHN1aV5FXJvPiS6xq/Z/KSQXRusiKgXQgqktEqG00=; b=iUcaXBjW5jzg8BYCigFgAhbbgA
 kpg8joPRqFPPZ2HcQR7GNZGjgkR4SFIbGL1dD+mJ8nFFYoz2xDLTDkfMdnW2SFryzjZzmNlzws9eP
 Ks3MLNSEvwkY10QLsJ+yG3U4760OSdi70+YtQuu4Z/vNuc9JJhWzTTwo1S5vOoOZECKdiW5uVTIg8
 vrACTBYz1ZuiKOrw/BpFs6Yy1W13IRClAKhZ29jrmswwTxeTKgVMxv8jKCFZNTFmN/GN+yiThTfLD
 ub3l6il9zwtqsSyKgPtqwUtseISE18m/LhXYK6GSmDGzppMH9XYgoGwUdiCBjOqOZ/zSkX0sW/wwB
 ECIYA4GA==;
Received: from 54-240-197-232.amazon.com ([54.240.197.232]
 helo=u09cd745991455d.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tVCRF-00000008ESg-0Tcp; Tue, 07 Jan 2025 16:28:17 +0000
Message-ID: <07fd5e2f529098ad4d7cab1423fe9f4a03a9cc14.camel@infradead.org>
Subject: [PATCH v6] hw/acpi: Add vmclock device
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Date: Tue, 07 Jan 2025 16:28:16 +0000
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-J1ylVrQPvLVTPasFrdw5"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+f031519a9170f34b3d42+7807+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--=-J1ylVrQPvLVTPasFrdw5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

The vmclock device addresses the problem of live migration with
precision clocks. The tolerances of a hardware counter (e.g. TSC) are
typically around =C2=B150PPM. A guest will use NTP/PTP/PPS to discipline th=
at
counter against an external source of 'real' time, and track the precise
frequency of the counter as it changes with environmental conditions.

When a guest is live migrated, anything it knows about the frequency of
the underlying counter becomes invalid. It may move from a host where
the counter running at -50PPM of its nominal frequency, to a host where
it runs at +50PPM. There will also be a step change in the value of the
counter, as the correctness of its absolute value at migration is
limited by the accuracy of the source and destination host's time
synchronization.

The device exposes a shared memory region to guests, which can be mapped
all the way to userspace. In the first phase, this merely advertises a
'disruption_marker', which indicates that the guest should throw away any
NTP synchronization it thinks it has, and start again.

Because the region can be exposed all the way to userspace, applications
can still use time from a fast vDSO 'system call', and check the
disruption marker to be sure that their timestamp is indeed truthful.

The structure also allows for the precise time, as known by the host, to
be exposed directly to guests so that they don't have to wait for NTP to
resync from scratch.

The values and fields are based on the nascent virtio-rtc specification,
and the intent is that a version (hopefully precisely this version) of
this structure will be included as an optional part of that spec. In the
meantime, a simple ACPI device along the lines of VMGENID is perfectly
sufficient and is compatible with what's being shipped in certain
commercial hypervisors.

Linux guest support was merged into the 6.13-rc1 kernel:
https://git.kernel.org/torvalds/c/205032724226

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
v6:
 =E2=80=A2 Rebase for DEFINE_PROP_END_OF_LIST removal and sysemu=E2=86=92sy=
stem
   rename.

v5:
 =E2=80=A2 Trivial simplification to AML generation.
 =E2=80=A2 Import vmclock-abi.h from Linux now the guest support is merged.

v4:
 =E2=80=A2 Trivial checkpatch fixes and comment improvements.

v3:
 =E2=80=A2 Add comment that vmclock-abi.h will come from the Linux kernel
   headers once it gets merged there.

v2:
 =E2=80=A2 Change esterror/maxerror fields to nanoseconds.
 =E2=80=A2 Change to officially assigned AMZNC10C ACPI HID.
 =E2=80=A2 Fix little-endian handling of fields in update.


 hw/acpi/Kconfig                              |   5 +
 hw/acpi/meson.build                          |   1 +
 hw/acpi/vmclock.c                            | 179 ++++++++++++++++++
 hw/i386/Kconfig                              |   1 +
 hw/i386/acpi-build.c                         |  10 +-
 include/hw/acpi/vmclock.h                    |  34 ++++
 include/standard-headers/linux/vmclock-abi.h | 182 +++++++++++++++++++
 scripts/update-linux-headers.sh              |   1 +
 8 files changed, 412 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/vmclock.c
 create mode 100644 include/hw/acpi/vmclock.h
 create mode 100644 include/standard-headers/linux/vmclock-abi.h

diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index e07d3204eb..1d4e9f0845 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -60,6 +60,11 @@ config ACPI_VMGENID
     default y
     depends on PC
=20
+config ACPI_VMCLOCK
+    bool
+    default y
+    depends on PC
+
 config ACPI_VIOT
     bool
     depends on ACPI
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index c8854f4d48..73f02b9691 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -15,6 +15,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('=
acpi-nvdimm-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: fi=
les('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_=
device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: =
files('ghes-stub.c'))
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
new file mode 100644
index 0000000000..7387e5c9ca
--- /dev/null
+++ b/hw/acpi/vmclock.c
@@ -0,0 +1,179 @@
+/*
+ * Virtual Machine Clock Device
+ *
+ * Copyright =C2=A9 2024 Amazon.com, Inc. or its affiliates. All Rights Re=
served.
+ *
+ * Authors: David Woodhouse <dwmw2@infradead.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/i386/e820_memory_layout.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/vmclock.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "system/reset.h"
+
+#include "standard-headers/linux/vmclock-abi.h"
+
+void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
+                        BIOSLinker *linker, const char *oem_id)
+{
+    Aml *ssdt, *dev, *scope, *crs;
+    AcpiTable table =3D { .sig =3D "SSDT", .rev =3D 1,
+                        .oem_id =3D oem_id, .oem_table_id =3D "VMCLOCK" };
+
+    /* Put VMCLOCK into a separate SSDT table */
+    acpi_table_begin(&table, table_data);
+    ssdt =3D init_aml_allocator();
+
+    scope =3D aml_scope("\\_SB");
+    dev =3D aml_device("VCLK");
+    aml_append(dev, aml_name_decl("_HID", aml_string("AMZNC10C")));
+    aml_append(dev, aml_name_decl("_CID", aml_string("VMCLOCK")));
+    aml_append(dev, aml_name_decl("_DDN", aml_string("VMCLOCK")));
+
+    /* Simple status method */
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
+
+    crs =3D aml_resource_template();
+    aml_append(crs, aml_qword_memory(AML_POS_DECODE,
+                                     AML_MIN_FIXED, AML_MAX_FIXED,
+                                     AML_CACHEABLE, AML_READ_ONLY,
+                                     0xffffffffffffffffULL,
+                                     vms->physaddr,
+                                     vms->physaddr + VMCLOCK_SIZE - 1,
+                                     0, VMCLOCK_SIZE));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+    aml_append(ssdt, scope);
+
+    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
+    acpi_table_end(linker, &table);
+    free_aml_allocator();
+}
+
+static void vmclock_update_guest(VmclockState *vms)
+{
+    uint64_t disruption_marker;
+    uint32_t seq_count;
+
+    if (!vms->clk) {
+        return;
+    }
+
+    seq_count =3D le32_to_cpu(vms->clk->seq_count) | 1;
+    vms->clk->seq_count =3D cpu_to_le32(seq_count);
+    /* These barriers pair with read barriers in the guest */
+    smp_wmb();
+
+    disruption_marker =3D le64_to_cpu(vms->clk->disruption_marker);
+    disruption_marker++;
+    vms->clk->disruption_marker =3D cpu_to_le64(disruption_marker);
+
+    /* These barriers pair with read barriers in the guest */
+    smp_wmb();
+    vms->clk->seq_count =3D cpu_to_le32(seq_count + 1);
+}
+
+/*
+ * After restoring an image, we need to update the guest memory to notify
+ * it of clock disruption.
+ */
+static int vmclock_post_load(void *opaque, int version_id)
+{
+    VmclockState *vms =3D opaque;
+
+    vmclock_update_guest(vms);
+    return 0;
+}
+
+static const VMStateDescription vmstate_vmclock =3D {
+    .name =3D "vmclock",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .post_load =3D vmclock_post_load,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_UINT64(physaddr, VmclockState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void vmclock_handle_reset(void *opaque)
+{
+    VmclockState *vms =3D VMCLOCK(opaque);
+
+    if (!memory_region_is_mapped(&vms->clk_page)) {
+        memory_region_add_subregion_overlap(get_system_memory(),
+                                            vms->physaddr,
+                                            &vms->clk_page, 0);
+    }
+}
+
+static void vmclock_realize(DeviceState *dev, Error **errp)
+{
+    VmclockState *vms =3D VMCLOCK(dev);
+
+    /*
+     * Given that this function is executing, there is at least one VMCLOC=
K
+     * device. Check if there are several.
+     */
+    if (!find_vmclock_dev()) {
+        error_setg(errp, "at most one %s device is permitted", TYPE_VMCLOC=
K);
+        return;
+    }
+
+    vms->physaddr =3D VMCLOCK_ADDR;
+
+    e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
+
+    memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
+                           VMCLOCK_SIZE, &error_abort);
+    memory_region_set_enabled(&vms->clk_page, true);
+    vms->clk =3D memory_region_get_ram_ptr(&vms->clk_page);
+    memset(vms->clk, 0, VMCLOCK_SIZE);
+
+    vms->clk->magic =3D cpu_to_le32(VMCLOCK_MAGIC);
+    vms->clk->size =3D cpu_to_le16(VMCLOCK_SIZE);
+    vms->clk->version =3D cpu_to_le16(1);
+
+    /* These are all zero and thus default, but be explicit */
+    vms->clk->clock_status =3D VMCLOCK_STATUS_UNKNOWN;
+    vms->clk->counter_id =3D VMCLOCK_COUNTER_INVALID;
+
+    qemu_register_reset(vmclock_handle_reset, vms);
+
+    vmclock_update_guest(vms);
+}
+
+static void vmclock_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_vmclock;
+    dc->realize =3D vmclock_realize;
+    dc->hotpluggable =3D false;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo vmclock_device_info =3D {
+    .name          =3D TYPE_VMCLOCK,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(VmclockState),
+    .class_init    =3D vmclock_device_class_init,
+};
+
+static void vmclock_register_types(void)
+{
+    type_register_static(&vmclock_device_info);
+}
+
+type_init(vmclock_register_types)
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 32818480d2..d34ce07b21 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -43,6 +43,7 @@ config PC
     select SERIAL_ISA
     select ACPI_PCI
     select ACPI_VMGENID
+    select ACPI_VMCLOCK
     select VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MEM_SUPPORTED
     select HV_BALLOON_SUPPORTED
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 733b8f0851..d482f974df 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -43,6 +43,7 @@
 #include "system/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/acpi/vmclock.h"
 #include "hw/acpi/erst.h"
 #include "hw/acpi/piix4.h"
 #include "system/tpm_backend.h"
@@ -2432,7 +2433,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
 *machine)
     uint8_t *u;
     GArray *tables_blob =3D tables->table_data;
     AcpiSlicOem slic_oem =3D { .id =3D NULL, .table_id =3D NULL };
-    Object *vmgenid_dev;
+    Object *vmgenid_dev, *vmclock_dev;
     char *oem_id;
     char *oem_table_id;
=20
@@ -2505,6 +2506,13 @@ void acpi_build(AcpiBuildTables *tables, MachineStat=
e *machine)
                            tables->vmgenid, tables->linker, x86ms->oem_id)=
;
     }
=20
+    vmclock_dev =3D find_vmclock_dev();
+    if (vmclock_dev) {
+        acpi_add_table(table_offsets, tables_blob);
+        vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, tables->link=
er,
+                           x86ms->oem_id);
+    }
+
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
         build_hpet(tables_blob, tables->linker, x86ms->oem_id,
diff --git a/include/hw/acpi/vmclock.h b/include/hw/acpi/vmclock.h
new file mode 100644
index 0000000000..5605605812
--- /dev/null
+++ b/include/hw/acpi/vmclock.h
@@ -0,0 +1,34 @@
+#ifndef ACPI_VMCLOCK_H
+#define ACPI_VMCLOCK_H
+
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/qdev-core.h"
+#include "qemu/uuid.h"
+#include "qom/object.h"
+
+#define TYPE_VMCLOCK    "vmclock"
+
+#define VMCLOCK_ADDR    0xfeffb000
+#define VMCLOCK_SIZE    0x1000
+
+OBJECT_DECLARE_SIMPLE_TYPE(VmclockState, VMCLOCK)
+
+struct vmclock_abi;
+
+struct VmclockState {
+    DeviceState parent_obj;
+    MemoryRegion clk_page;
+    uint64_t physaddr;
+    struct vmclock_abi *clk;
+};
+
+/* returns NULL unless there is exactly one device */
+static inline Object *find_vmclock_dev(void)
+{
+    return object_resolve_path_type("", TYPE_VMCLOCK, NULL);
+}
+
+void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
+                        BIOSLinker *linker, const char *oem_id);
+
+#endif
diff --git a/include/standard-headers/linux/vmclock-abi.h b/include/standar=
d-headers/linux/vmclock-abi.h
new file mode 100644
index 0000000000..15b0316cb4
--- /dev/null
+++ b/include/standard-headers/linux/vmclock-abi.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Cl=
ause) */
+
+/*
+ * This structure provides a vDSO-style clock to VM guests, exposing the
+ * relationship (or lack thereof) between the CPU clock (TSC, timebase, ar=
ch
+ * counter, etc.) and real time. It is designed to address the problem of
+ * live migration, which other clock enlightenments do not.
+ *
+ * When a guest is live migrated, this affects the clock in two ways.
+ *
+ * First, even between identical hosts the actual frequency of the underly=
ing
+ * counter will change within the tolerances of its specification (typical=
ly
+ * =C2=B150PPM, or 4 seconds a day). This frequency also varies over time =
on the
+ * same host, but can be tracked by NTP as it generally varies slowly. Wit=
h
+ * live migration there is a step change in the frequency, with no warning=
.
+ *
+ * Second, there may be a step change in the value of the counter itself, =
as
+ * its accuracy is limited by the precision of the NTP synchronization on =
the
+ * source and destination hosts.
+ *
+ * So any calibration (NTP, PTP, etc.) which the guest has done on the sou=
rce
+ * host before migration is invalid, and needs to be redone on the new hos=
t.
+ *
+ * In its most basic mode, this structure provides only an indication to t=
he
+ * guest that live migration has occurred. This allows the guest to know t=
hat
+ * its clock is invalid and take remedial action. For applications that ne=
ed
+ * reliable accurate timestamps (e.g. distributed databases), the structur=
e
+ * can be mapped all the way to userspace. This allows the application to =
see
+ * directly for itself that the clock is disrupted and take appropriate
+ * action, even when using a vDSO-style method to get the time instead of =
a
+ * system call.
+ *
+ * In its more advanced mode. this structure can also be used to expose th=
e
+ * precise relationship of the CPU counter to real time, as calibrated by =
the
+ * host. This means that userspace applications can have accurate time
+ * immediately after live migration, rather than having to pause operation=
s
+ * and wait for NTP to recover. This mode does, of course, rely on the
+ * counter being reliable and consistent across CPUs.
+ *
+ * Note that this must be true UTC, never with smeared leap seconds. If a
+ * guest wishes to construct a smeared clock, it can do so. Presenting a
+ * smeared clock through this interface would be problematic because it
+ * actually messes with the apparent counter *period*. A linear smearing
+ * of 1 ms per second would effectively tweak the counter period by 1000PP=
M
+ * at the start/end of the smearing period, while a sinusoidal smear would
+ * basically be impossible to represent.
+ *
+ * This structure is offered with the intent that it be adopted into the
+ * nascent virtio-rtc standard, as a virtio-rtc that does not address the =
live
+ * migration problem seems a little less than fit for purpose. For that
+ * reason, certain fields use precisely the same numeric definitions as in
+ * the virtio-rtc proposal. The structure can also be exposed through an A=
CPI
+ * device with the CID "VMCLOCK", modelled on the "VMGENID" device except =
for
+ * the fact that it uses a real _CRS to convey the address of the structur=
e
+ * (which should be a full page, to allow for mapping directly to userspac=
e).
+ */
+
+#ifndef __VMCLOCK_ABI_H__
+#define __VMCLOCK_ABI_H__
+
+#include "standard-headers/linux/types.h"
+
+struct vmclock_abi {
+	/* CONSTANT FIELDS */
+	uint32_t magic;
+#define VMCLOCK_MAGIC	0x4b4c4356 /* "VCLK" */
+	uint32_t size;		/* Size of region containing this structure */
+	uint16_t version;	/* 1 */
+	uint8_t counter_id; /* Matches VIRTIO_RTC_COUNTER_xxx except INVALID */
+#define VMCLOCK_COUNTER_ARM_VCNT	0
+#define VMCLOCK_COUNTER_X86_TSC		1
+#define VMCLOCK_COUNTER_INVALID		0xff
+	uint8_t time_type; /* Matches VIRTIO_RTC_TYPE_xxx */
+#define VMCLOCK_TIME_UTC			0	/* Since 1970-01-01 00:00:00z */
+#define VMCLOCK_TIME_TAI			1	/* Since 1970-01-01 00:00:00z */
+#define VMCLOCK_TIME_MONOTONIC			2	/* Since undefined epoch */
+#define VMCLOCK_TIME_INVALID_SMEARED		3	/* Not supported */
+#define VMCLOCK_TIME_INVALID_MAYBE_SMEARED	4	/* Not supported */
+
+	/* NON-CONSTANT FIELDS PROTECTED BY SEQCOUNT LOCK */
+	uint32_t seq_count;	/* Low bit means an update is in progress */
+	/*
+	 * This field changes to another non-repeating value when the CPU
+	 * counter is disrupted, for example on live migration. This lets
+	 * the guest know that it should discard any calibration it has
+	 * performed of the counter against external sources (NTP/PTP/etc.).
+	 */
+	uint64_t disruption_marker;
+	uint64_t flags;
+	/* Indicates that the tai_offset_sec field is valid */
+#define VMCLOCK_FLAG_TAI_OFFSET_VALID		(1 << 0)
+	/*
+	 * Optionally used to notify guests of pending maintenance events.
+	 * A guest which provides latency-sensitive services may wish to
+	 * remove itself from service if an event is coming up. Two flags
+	 * indicate the approximate imminence of the event.
+	 */
+#define VMCLOCK_FLAG_DISRUPTION_SOON		(1 << 1) /* About a day */
+#define VMCLOCK_FLAG_DISRUPTION_IMMINENT	(1 << 2) /* About an hour */
+#define VMCLOCK_FLAG_PERIOD_ESTERROR_VALID	(1 << 3)
+#define VMCLOCK_FLAG_PERIOD_MAXERROR_VALID	(1 << 4)
+#define VMCLOCK_FLAG_TIME_ESTERROR_VALID	(1 << 5)
+#define VMCLOCK_FLAG_TIME_MAXERROR_VALID	(1 << 6)
+	/*
+	 * If the MONOTONIC flag is set then (other than leap seconds) it is
+	 * guaranteed that the time calculated according this structure at
+	 * any given moment shall never appear to be later than the time
+	 * calculated via the structure at any *later* moment.
+	 *
+	 * In particular, a timestamp based on a counter reading taken
+	 * immediately after setting the low bit of seq_count (and the
+	 * associated memory barrier), using the previously-valid time and
+	 * period fields, shall never be later than a timestamp based on
+	 * a counter reading taken immediately before *clearing* the low
+	 * bit again after the update, using the about-to-be-valid fields.
+	 */
+#define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)
+
+	uint8_t pad[2];
+	uint8_t clock_status;
+#define VMCLOCK_STATUS_UNKNOWN		0
+#define VMCLOCK_STATUS_INITIALIZING	1
+#define VMCLOCK_STATUS_SYNCHRONIZED	2
+#define VMCLOCK_STATUS_FREERUNNING	3
+#define VMCLOCK_STATUS_UNRELIABLE	4
+
+	/*
+	 * The time exposed through this device is never smeared. This field
+	 * corresponds to the 'subtype' field in virtio-rtc, which indicates
+	 * the smearing method. However in this case it provides a *hint* to
+	 * the guest operating system, such that *if* the guest OS wants to
+	 * provide its users with an alternative clock which does not follow
+	 * UTC, it may do so in a fashion consistent with the other systems
+	 * in the nearby environment.
+	 */
+	uint8_t leap_second_smearing_hint; /* Matches VIRTIO_RTC_SUBTYPE_xxx */
+#define VMCLOCK_SMEARING_STRICT		0
+#define VMCLOCK_SMEARING_NOON_LINEAR	1
+#define VMCLOCK_SMEARING_UTC_SLS	2
+	uint16_t tai_offset_sec; /* Actually two's complement signed */
+	uint8_t leap_indicator;
+	/*
+	 * This field is based on the VIRTIO_RTC_LEAP_xxx values as defined
+	 * in the current draft of virtio-rtc, but since smearing cannot be
+	 * used with the shared memory device, some values are not used.
+	 *
+	 * The _POST_POS and _POST_NEG values allow the guest to perform
+	 * its own smearing during the day or so after a leap second when
+	 * such smearing may need to continue being applied for a leap
+	 * second which is now theoretically "historical".
+	 */
+#define VMCLOCK_LEAP_NONE	0x00	/* No known nearby leap second */
+#define VMCLOCK_LEAP_PRE_POS	0x01	/* Positive leap second at EOM */
+#define VMCLOCK_LEAP_PRE_NEG	0x02	/* Negative leap second at EOM */
+#define VMCLOCK_LEAP_POS	0x03	/* Set during 23:59:60 second */
+#define VMCLOCK_LEAP_POST_POS	0x04
+#define VMCLOCK_LEAP_POST_NEG	0x05
+
+	/* Bit shift for counter_period_frac_sec and its error rate */
+	uint8_t counter_period_shift;
+	/*
+	 * Paired values of counter and UTC at a given point in time.
+	 */
+	uint64_t counter_value;
+	/*
+	 * Counter period, and error margin of same. The unit of these
+	 * fields is 1/2^(64 + counter_period_shift) of a second.
+	 */
+	uint64_t counter_period_frac_sec;
+	uint64_t counter_period_esterror_rate_frac_sec;
+	uint64_t counter_period_maxerror_rate_frac_sec;
+
+	/*
+	 * Time according to time_type field above.
+	 */
+	uint64_t time_sec;		/* Seconds since time_type epoch */
+	uint64_t time_frac_sec;		/* Units of 1/2^64 of a second */
+	uint64_t time_esterror_nanosec;
+	uint64_t time_maxerror_nanosec;
+};
+
+#endif /*  __VMCLOCK_ABI_H__ */
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers=
.sh
index 99a8d9fa4c..8913e4fb99 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -258,6 +258,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/kernel.h" \
          "$hdrdir/include/linux/kvm_para.h" \
          "$hdrdir/include/linux/vhost_types.h" \
+         "$hdrdir/include/linux/vmclock-abi.h" \
          "$hdrdir/include/linux/sysinfo.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
--=20
2.47.0



--=-J1ylVrQPvLVTPasFrdw5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwNzE2Mjgx
NlowLwYJKoZIhvcNAQkEMSIEICFXo+3FcPgsfUikSBkutVpRiXz16jgCiTCDKKZynS0MMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAUgQ3CX3uHYPj
O2GClzK00d4ycxsUZQsX5O6FIYlCLL6w+AjaBIMAmNb2VWOVsbP9Q818KMs9zKD2FXLiM1Zmz2OK
yXkK6qStpGIbzsDrTglZAss6GqQwS7Gm+zzXZsnOENqLMyu0DtLcJECySv3u6sxwvxosvbV5g2T3
O3Wh1n/zd91nSFKbkwK/CpY3nYBO967bzWNMbP91aqCYKHZ+SlY5DK2BGbQ1FOCx2KdWTenW1YC/
3laNbf34eRCWZ96Msm9NimI9Ez9MMZqbVX6huNLqQVynYKF6lOuyLv0lcDWLHQzkSNc5HTS1VcbA
bP1BkSJtYitOf5J4x8kuD1Eo2waklbqLPXh7hVeeQAVuRTab0bjK5JiRfyz3Ou0OYWNjrfUO1ko1
RC9n6qEuRggoyg35CA79VMxCYnf4+qufAhG58yx5s4ot6DHSG5HmWb09JZUXiYDtQ9fNRTt8au/w
a3qje+S/q27PEBD5nbgvLmKuQP31MFZewId31FV+ebIW+7KEzd1EObWr8T4Qt7wgG921NaEVW7O4
DpURGDRKwstYQjDaGqXgjXcZVyRNZAODAGlDR0uhiStjn4GvItyW9oQgVqRANHwcgjsgDg3K/L+K
MldoYHMwoYkZt9hLDBkC3T+BHEjg5kTz2SUR8k/CHJWkWcJFC2vOzAsQoxAJg9MAAAAAAAA=


--=-J1ylVrQPvLVTPasFrdw5--

