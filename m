Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7A5C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQT9-0004JD-NL; Thu, 16 Jan 2025 09:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYQT0-0004IE-Pb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:03:27 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYQSw-0008AX-Hj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=/kqZSgUvu7/tkefaM0Wh87OSs2lkQ/1SzYgcb3Z9/5I=; b=A/6XCYOeKY2yHrMNBFPmtiKk3T
 z4N8ZCJkoSzzN0dJl0FDbwpCfv2D4xwhljBCiXR25jmT3jA8ogCyfwDpdtu9AlEmR2Kjsb4RRHxUF
 6b2/UQpN4ylzFOj8Qs4XLCsYSyLzDKlFMAeHqV+LVAm3J9tKTYjG0oOQtI6ajZTZnbONRAbgelgrF
 eZD+hIlwsVLP37jVTYAKAaBELCfUeelI7pqnGBYDP9J+Igmx7dSNKpJ2FYw1NUxtam8NGOwjXzwxY
 mTD498/7VTMsSyj/dJYaosEmeFJlBSznMyRviU2VLI+a4hYxeT4lv0SkyGG7SLVWixLHiJTCiu+fx
 cW4ZKoTg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYQSq-0000000Ezl3-2kyv; Thu, 16 Jan 2025 14:03:16 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYQSq-0000000AJgy-1lnT; Thu, 16 Jan 2025 14:03:16 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v7 2/3] linux-headers: Update to Linux 6.13-rc7
Date: Thu, 16 Jan 2025 13:59:42 +0000
Message-ID: <20250116140315.2455143-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250116140315.2455143-1-dwmw2@infradead.org>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org;
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

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/standard-headers/linux/vmclock-abi.h | 182 +++++++++++++++++++
 linux-headers/linux/iommufd.h                |  31 ++--
 linux-headers/linux/stddef.h                 |  13 +-
 3 files changed, 212 insertions(+), 14 deletions(-)
 create mode 100644 include/standard-headers/linux/vmclock-abi.h

diff --git a/include/standard-headers/linux/vmclock-abi.h b/include/standard-headers/linux/vmclock-abi.h
new file mode 100644
index 0000000000..15b0316cb4
--- /dev/null
+++ b/include/standard-headers/linux/vmclock-abi.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+
+/*
+ * This structure provides a vDSO-style clock to VM guests, exposing the
+ * relationship (or lack thereof) between the CPU clock (TSC, timebase, arch
+ * counter, etc.) and real time. It is designed to address the problem of
+ * live migration, which other clock enlightenments do not.
+ *
+ * When a guest is live migrated, this affects the clock in two ways.
+ *
+ * First, even between identical hosts the actual frequency of the underlying
+ * counter will change within the tolerances of its specification (typically
+ * ±50PPM, or 4 seconds a day). This frequency also varies over time on the
+ * same host, but can be tracked by NTP as it generally varies slowly. With
+ * live migration there is a step change in the frequency, with no warning.
+ *
+ * Second, there may be a step change in the value of the counter itself, as
+ * its accuracy is limited by the precision of the NTP synchronization on the
+ * source and destination hosts.
+ *
+ * So any calibration (NTP, PTP, etc.) which the guest has done on the source
+ * host before migration is invalid, and needs to be redone on the new host.
+ *
+ * In its most basic mode, this structure provides only an indication to the
+ * guest that live migration has occurred. This allows the guest to know that
+ * its clock is invalid and take remedial action. For applications that need
+ * reliable accurate timestamps (e.g. distributed databases), the structure
+ * can be mapped all the way to userspace. This allows the application to see
+ * directly for itself that the clock is disrupted and take appropriate
+ * action, even when using a vDSO-style method to get the time instead of a
+ * system call.
+ *
+ * In its more advanced mode. this structure can also be used to expose the
+ * precise relationship of the CPU counter to real time, as calibrated by the
+ * host. This means that userspace applications can have accurate time
+ * immediately after live migration, rather than having to pause operations
+ * and wait for NTP to recover. This mode does, of course, rely on the
+ * counter being reliable and consistent across CPUs.
+ *
+ * Note that this must be true UTC, never with smeared leap seconds. If a
+ * guest wishes to construct a smeared clock, it can do so. Presenting a
+ * smeared clock through this interface would be problematic because it
+ * actually messes with the apparent counter *period*. A linear smearing
+ * of 1 ms per second would effectively tweak the counter period by 1000PPM
+ * at the start/end of the smearing period, while a sinusoidal smear would
+ * basically be impossible to represent.
+ *
+ * This structure is offered with the intent that it be adopted into the
+ * nascent virtio-rtc standard, as a virtio-rtc that does not address the live
+ * migration problem seems a little less than fit for purpose. For that
+ * reason, certain fields use precisely the same numeric definitions as in
+ * the virtio-rtc proposal. The structure can also be exposed through an ACPI
+ * device with the CID "VMCLOCK", modelled on the "VMGENID" device except for
+ * the fact that it uses a real _CRS to convey the address of the structure
+ * (which should be a full page, to allow for mapping directly to userspace).
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
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 37aae16502..f97145a311 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -297,7 +297,7 @@ struct iommu_ioas_unmap {
  *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
  * @IOMMU_OPTION_RLIMIT_MODE:
  *    Change how RLIMIT_MEMLOCK accounting works. The caller must have privilege
- *    to invoke this. Value 0 (default) is user based accouting, 1 uses process
+ *    to invoke this. Value 0 (default) is user based accounting, 1 uses process
  *    based accounting. Global option, object_id must be 0
  * @IOMMU_OPTION_HUGE_PAGES:
  *    Value 1 (default) allows contiguous pages to be combined when generating
@@ -390,7 +390,7 @@ struct iommu_vfio_ioas {
  * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
  *                          domain can be attached to any PASID on the device.
  *                          Any domain attached to the non-PASID part of the
- *                          device must also be flaged, otherwise attaching a
+ *                          device must also be flagged, otherwise attaching a
  *                          PASID will blocked.
  *                          If IOMMU does not support PASID it will return
  *                          error (-EOPNOTSUPP).
@@ -558,16 +558,25 @@ struct iommu_hw_info_vtd {
  * For the details of @idr, @iidr and @aidr, please refer to the chapters
  * from 6.3.1 to 6.3.6 in the SMMUv3 Spec.
  *
- * User space should read the underlying ARM SMMUv3 hardware information for
- * the list of supported features.
+ * This reports the raw HW capability, and not all bits are meaningful to be
+ * read by userspace. Only the following fields should be used:
  *
- * Note that these values reflect the raw HW capability, without any insight if
- * any required kernel driver support is present. Bits may be set indicating the
- * HW has functionality that is lacking kernel software support, such as BTM. If
- * a VMM is using this information to construct emulated copies of these
- * registers it should only forward bits that it knows it can support.
+ * idr[0]: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN , CD2L, ASID16, TTF
+ * idr[1]: SIDSIZE, SSIDSIZE
+ * idr[3]: BBML, RIL
+ * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K
  *
- * In future, presence of required kernel support will be indicated in flags.
+ * - S1P should be assumed to be true if a NESTED HWPT can be created
+ * - VFIO/iommufd only support platforms with COHACC, it should be assumed to be
+ *   true.
+ * - ATS is a per-device property. If the VMM describes any devices as ATS
+ *   capable in ACPI/DT it should set the corresponding idr.
+ *
+ * This list may expand in future (eg E0PD, AIE, PBHA, D128, DS etc). It is
+ * important that VMMs do not read bits outside the list to allow for
+ * compatibility with future kernels. Several features in the SMMUv3
+ * architecture are not currently supported by the kernel for nesting: HTTU,
+ * BTM, MPAM and others.
  */
 struct iommu_hw_info_arm_smmuv3 {
 	__u32 flags;
@@ -766,7 +775,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
 };
 
 /**
- * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
+ * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cache invalidation
  *         (IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3)
  * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
  *       Must be little-endian.
diff --git a/linux-headers/linux/stddef.h b/linux-headers/linux/stddef.h
index 96aa341942..e1416f7937 100644
--- a/linux-headers/linux/stddef.h
+++ b/linux-headers/linux/stddef.h
@@ -8,6 +8,13 @@
 #define __always_inline __inline__
 #endif
 
+/* Not all C++ standards support type declarations inside an anonymous union */
+#ifndef __cplusplus
+#define __struct_group_tag(TAG)		TAG
+#else
+#define __struct_group_tag(TAG)
+#endif
+
 /**
  * __struct_group() - Create a mirrored named and anonyomous struct
  *
@@ -20,13 +27,13 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
-		struct TAG { MEMBERS } ATTRS NAME; \
+		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
 	} ATTRS
 
 #ifdef __cplusplus
-- 
2.47.0


