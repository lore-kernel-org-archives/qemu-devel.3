Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50B3CFB441
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 13:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxoBf-0002Ej-Qp; Mon, 07 Oct 2024 09:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+42afba82b90b59d217f6+7715+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1sxoBb-0002EN-Rv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:54:08 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+42afba82b90b59d217f6+7715+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1sxoBX-0005zi-QU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=WEWEqY9KMDRxQa0cUXKQzrSNvnpC9PRpXzWbOpYxPeA=; b=IXlMAs9iSHgz+WPvTyCWHt34sz
 emNWDfGwp+wAYv4REJLaSzGk5bjdtI+6AkJiGj4GXfA0AkQ92drXtsqsbp1zc6MQage0/zZEMj2O1
 lEoCwOx+xKjtLW1hSRgrRiog7yafG1qYZSt/TM0FgOaTmCGnStZbWkB5KdsV7wabxyPWUweaauwzV
 Uwf+VPEj+LD15+n2lwXGORC63yCnR/alx8UotJEK03I1na2eLmLduZUwX7IcskO/IYnW/+sXkGnB6
 gABnC5/e0MPZhIyVHb3D++bxdE3xzwBDadNKruvuxbIfjFdihTCQhvmlAHiA9RJnwf9+vCj0L/mJG
 a6dRS1ww==;
Received: from [2001:8b0:10b:5:2e47:989a:8186:4053]
 (helo=u3832b3a9db3152.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1sxoBO-0000000HXp5-0zNZ; Mon, 07 Oct 2024 13:53:55 +0000
Message-ID: <64144cfa550c54bee25c7be0cc3101cb1d1b1967.camel@infradead.org>
Subject: [PATCH v4] hw/acpi: Add vmclock device
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Date: Mon, 07 Oct 2024 14:53:54 +0100
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-2ESeYS3m1v7EC05+TgS+"
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+42afba82b90b59d217f6+7715+infradead.org+dwmw2@casper.srs.infradead.org;
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


--=-2ESeYS3m1v7EC05+TgS+
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
v4:
 =E2=80=A2 Trivial checkpatch fixes and comment improvements.

v3:
 =E2=80=A2 Add comment that vmclock-abi.h will come from the Linux kernel
   headers once it gets merged there.

v2:
 =E2=80=A2 Change esterror/maxerror fields to nanoseconds.
 =E2=80=A2 Change to officially assigned AMZNC10C ACPI HID.
 =E2=80=A2 Fix little-endian handling of fields in update.

Guest support:
https://lore.kernel.org/all/78969a39b51ec00e85551b752767be65f6794b46.camel@=
infradead.org/

 hw/acpi/Kconfig           |   5 +
 hw/acpi/meson.build       |   1 +
 hw/acpi/vmclock-abi.h     | 186 +++++++++++++++++++++++++++++++++++++
 hw/acpi/vmclock.c         | 189 ++++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig           |   1 +
 hw/i386/acpi-build.c      |  10 +-
 include/hw/acpi/vmclock.h |  34 +++++++
 7 files changed, 425 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/vmclock-abi.h
 create mode 100644 hw/acpi/vmclock.c
 create mode 100644 include/hw/acpi/vmclock.h

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
index 7f8ccc9b7a..995f99084a 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -16,6 +16,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('=
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
diff --git a/hw/acpi/vmclock-abi.h b/hw/acpi/vmclock-abi.h
new file mode 100644
index 0000000000..19cbf85efd
--- /dev/null
+++ b/hw/acpi/vmclock-abi.h
@@ -0,0 +1,186 @@
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
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
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
+	int16_t tai_offset_sec;
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
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
new file mode 100644
index 0000000000..e7df047c33
--- /dev/null
+++ b/hw/acpi/vmclock.c
@@ -0,0 +1,189 @@
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
+#include "sysemu/reset.h"
+
+/* This will come from Linux headers in the end, but we carry our own for =
now. */
+#include "vmclock-abi.h"
+
+void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
+                        BIOSLinker *linker, const char *oem_id)
+{
+    Aml *ssdt, *dev, *scope, *method, *addr, *crs;
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
+    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
+    addr =3D aml_local(0);
+    aml_append(method, aml_store(aml_int(0xf), addr));
+    aml_append(method, aml_return(addr));
+    aml_append(dev, method);
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
+static Property vmclock_device_properties[] =3D {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vmclock_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_vmclock;
+    dc->realize =3D vmclock_realize;
+    device_class_set_props(dc, vmclock_device_properties);
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
index f4a33b6c08..86b00bb94f 100644
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
index 4967aa7459..097fe08836 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -43,6 +43,7 @@
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/acpi/vmclock.h"
 #include "hw/acpi/erst.h"
 #include "hw/acpi/piix4.h"
 #include "sysemu/tpm_backend.h"
@@ -2429,7 +2430,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
 *machine)
     uint8_t *u;
     GArray *tables_blob =3D tables->table_data;
     AcpiSlicOem slic_oem =3D { .id =3D NULL, .table_id =3D NULL };
-    Object *vmgenid_dev;
+    Object *vmgenid_dev, *vmclock_dev;
     char *oem_id;
     char *oem_table_id;
=20
@@ -2502,6 +2503,13 @@ void acpi_build(AcpiBuildTables *tables, MachineStat=
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
--=20
2.44.0



--=-2ESeYS3m1v7EC05+TgS+
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMDA3MTM1MzU0WjAvBgkqhkiG9w0BCQQxIgQgT1xcoO4x
pSuhLyM3YkxNQGz4l/8SZ3U2zOe/U6+GYWEwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgB3JlW5G+uYqmNeGMb+sbBefKAuam3ucdVf
hwkoISHF79fxwVmx5m8Q7ZYwbtyIaD/b6818A5MwVs4XgcxGaobLWifhJjRzLBGpqPU6o/nZzXdz
o8m8Q9Mgu5fcPNWS3DRjNQpm4SDoin/xL1ayEQe+3SdIde+gpI3w/PWKfl1qTetiTuAuUW3HUdzb
xgCkJW9IenoM8j+1msaQelLYiD1iTeAOo9j8EfGx5r5v9QJ65GunlGMfnJmpkeWDKvjOG1Ql11Rd
XKfOnEB1+v315YkZRtg25/hjW3Sz4K+EwdkH/MfgbFBx6ON/a2QByJdUJhRTT5lqo3A+FAezVPgK
ggn1764ZJaFbL4qcGAnYWLiYY0Hy/nK08xaBuq5fjZykgJusg+TcEl8aI05Ozc9xE/apQZ7Ae2QQ
VzRUV+neX7ZmxqEV1vIWzP0+xAKnrM/6yDPSNUxHsiiakknAHXaFZ3PT+/84k8O1+tqRA4/dHeX7
m4HbgZFsEoLpKOYW9PhaEF0484RNsexR/ndI0zE/rTqm3mD+30upf1yxoShlJkmcjsYq+M/xZ3j8
WCJEkFEhp7HxeyGi9MXmzd5ln5yne0QnqT3pRlrKtEb+3CkAkUVk6fIDW9bpItw3jwoudrDKE8Ej
j/DGqb1zNNBFRzPydnQHCpzu4zdYbNUUH7sRbjlPBwAAAAAAAA==


--=-2ESeYS3m1v7EC05+TgS+--

