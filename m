Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB95FC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWfnx-0002UK-TT; Wed, 24 Jul 2024 13:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWfns-0002BV-GG
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWfno-00067d-Bn
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721842163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4M+gACxK4jWbtk3e3Wi3i3yanD7P8jcD3pINUs7qZDY=;
 b=OJVjtMXhrpUBEoFG7G0Oe0t7s9Dn4SU3xzyD+nnI9QhQdjR8HNyYp6K1ailH2juCoyD8ZK
 +XlHNRWW3hyzz75ehmlZRpm176lgmXAibUNWWMB632v2GgSCJW65xTBBLWIBWfV5yHhO4V
 OgCHFQNuxeGXVztKX9ZoYsx9mfYf3Yk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-pcEQbdWHOnu_sgsKV2EOoQ-1; Wed, 24 Jul 2024 13:29:19 -0400
X-MC-Unique: pcEQbdWHOnu_sgsKV2EOoQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-368448dfe12so498988f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 10:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721842158; x=1722446958;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4M+gACxK4jWbtk3e3Wi3i3yanD7P8jcD3pINUs7qZDY=;
 b=psEhLsVR/QYjhm3Vi9Gi0+DbqXndZxKcZRrFSd8bQW6AaKTZuAKPbIW4oajZnMm1aY
 tWadGQr2PHDnCU8iBglKfVuq9KRMmig8HCTdUf5nolCgNElhnXr2kCCEYOs2RZoXhg53
 zHVMC/KDoq15FV5XwPk1WKiucGe9i/02++VIK6xvw65o/GjHmcrTHS1nZdCvqkrHbwNt
 17wDy50ArCRDehmgHGoff6tXV69fC+Ugz6yhy3DVEWDeLBMtxNiGaDZHVG84syRbQM+h
 1po7coHNm7G3zppmyfDRsdZAqX0TJR58QUNZSyk7DFFoJMCWZzO0MEZ8g0Izp0LJmgn7
 JeZg==
X-Gm-Message-State: AOJu0YyBTFCuL9VDLRwssP/DjSUxzZKr7Zu2+1bqyadvXpjBFAUi0GuL
 vi09iAcDc0WpuKl0zgH8jLrHAylHTVdfGg8AGK1SZAxSQHJUZTYNJBg2C2x5tCMDDSb4pRAyqQK
 ZiZiaFE6IW20XdcCHZEvNUqkKrH6WygddpndKEdo7v3awP3/v0B6TRLOC2ogc
X-Received: by 2002:a5d:44c6:0:b0:360:7856:fa62 with SMTP id
 ffacd0b85a97d-369f66bbc5emr2188803f8f.15.1721842157452; 
 Wed, 24 Jul 2024 10:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELlSlGmcc/Bq5YiLAujttqtlnyyfv8jdQLif/nRXgkDyMDyAT0QMhLAWt0+2V/dsXiYT47Ag==
X-Received: by 2002:a5d:44c6:0:b0:360:7856:fa62 with SMTP id
 ffacd0b85a97d-369f66bbc5emr2188774f8f.15.1721842156661; 
 Wed, 24 Jul 2024 10:29:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:6083:a67a:e8a9:2855:2683])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868ac3asm14775024f8f.27.2024.07.24.10.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 10:29:16 -0700 (PDT)
Date: Wed, 24 Jul 2024 13:29:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH] hw/acpi: Add vmclock device
Message-ID: <20240724132727-mutt-send-email-mst@kernel.org>
References: <b2c50884f0a6992edec5d7d59626702508369cca.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2c50884f0a6992edec5d7d59626702508369cca.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 24, 2024 at 06:22:42PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.
> 
> When a guest is live migrated, anything it knows about the frequency of
> the underlying counter becomes invalid. It may move from a host where
> the counter running at -50PPM of its nominal frequency, to a host where
> it runs at +50PPM. There will also be a step change in the value of the
> counter, as the correctness of its absolute value at migration is
> limited by the accuracy of the source and destination host's time
> synchronization.
> 
> The device exposes a shared memory region to guests, which can be mapped
> all the way to userspace. In the first phase, this merely advertises a
> 'disruption_marker', which indicates that the guest should throw away any
> NTP synchronization it thinks it has, and start again.
> 
> Because the region can be exposed all the way to userspace, applications
> can still use time from a fast vDSO 'system call', and check the
> disruption marker to be sure that their timestamp is indeed truthful.
> 
> The structure also allows for the precise time, as known by the host, to
> be exposed directly to guests so that they don't have to wait for NTP to
> resync from scratch.
> 
> The values and fields are based on the nascent virtio-rtc specification,
> and the intent is that a version (hopefully precisely this version) of
> this structure will be included as an optional part of that spec. In the
> meantime, a simple ACPI device along the lines of VMGENID is perfectly
> sufficient.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Isn't the existing vmgenid sufficient for this disruption marker
and if not, why?


> ---
> Guest kernel support posted at
> https://lore.kernel.org/lkml/14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org/T/#u
> 
> 
>  hw/acpi/Kconfig           |   5 +
>  hw/acpi/meson.build       |   1 +
>  hw/acpi/vmclock-abi.h     | 187 ++++++++++++++++++++++++++++++++++++++
>  hw/acpi/vmclock.c         | 176 +++++++++++++++++++++++++++++++++++
>  hw/i386/Kconfig           |   1 +
>  hw/i386/acpi-build.c      |  10 +-
>  include/hw/acpi/vmclock.h |  34 +++++++
>  7 files changed, 413 insertions(+), 1 deletion(-)
>  create mode 100644 hw/acpi/vmclock-abi.h
>  create mode 100644 hw/acpi/vmclock.c
>  create mode 100644 include/hw/acpi/vmclock.h
> 
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index e07d3204eb..1d4e9f0845 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -60,6 +60,11 @@ config ACPI_VMGENID
>      default y
>      depends on PC
>  
> +config ACPI_VMCLOCK
> +    bool
> +    default y
> +    depends on PC
> +
>  config ACPI_VIOT
>      bool
>      depends on ACPI
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db90..77566ae8a8 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -16,6 +16,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('acpi-nvdimm-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
> diff --git a/hw/acpi/vmclock-abi.h b/hw/acpi/vmclock-abi.h
> new file mode 100644
> index 0000000000..3bde10ddec
> --- /dev/null
> +++ b/hw/acpi/vmclock-abi.h
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> +
> +/*
> + * This structure provides a vDSO-style clock to VM guests, exposing the
> + * relationship (or lack thereof) between the CPU clock (TSC, timebase, arch
> + * counter, etc.) and real time. It is designed to address the problem of
> + * live migration, which other clock enlightenments do not.
> + *
> + * When a guest is live migrated, this affects the clock in two ways.
> + *
> + * First, even between identical hosts the actual frequency of the underlying
> + * counter will change within the tolerances of its specification (typically
> + * ±50PPM, or 4 seconds a day). This frequency also varies over time on the
> + * same host, but can be tracked by NTP as it generally varies slowly. With
> + * live migration there is a step change in the frequency, with no warning.
> + *
> + * Second, there may be a step change in the value of the counter itself, as
> + * its accuracy is limited by the precision of the NTP synchronization on the
> + * source and destination hosts.
> + *
> + * So any calibration (NTP, PTP, etc.) which the guest has done on the source
> + * host before migration is invalid, and needs to be redone on the new host.
> + *
> + * In its most basic mode, this structure provides only an indication to the
> + * guest that live migration has occurred. This allows the guest to know that
> + * its clock is invalid and take remedial action. For applications that need
> + * reliable accurate timestamps (e.g. distributed databases), the structure
> + * can be mapped all the way to userspace. This allows the application to see
> + * directly for itself that the clock is disrupted and take appropriate
> + * action, even when using a vDSO-style method to get the time instead of a
> + * system call.
> + *
> + * In its more advanced mode. this structure can also be used to expose the
> + * precise relationship of the CPU counter to real time, as calibrated by the
> + * host. This means that userspace applications can have accurate time
> + * immediately after live migration, rather than having to pause operations
> + * and wait for NTP to recover. This mode does, of course, rely on the
> + * counter being reliable and consistent across CPUs.
> + *
> + * Note that this must be true UTC, never with smeared leap seconds. If a
> + * guest wishes to construct a smeared clock, it can do so. Presenting a
> + * smeared clock through this interface would be problematic because it
> + * actually messes with the apparent counter *period*. A linear smearing
> + * of 1 ms per second would effectively tweak the counter period by 1000PPM
> + * at the start/end of the smearing period, while a sinusoidal smear would
> + * basically be impossible to represent.
> + *
> + * This structure is offered with the intent that it be adopted into the
> + * nascent virtio-rtc standard, as a virtio-rtc that does not address the live
> + * migration problem seems a little less than fit for purpose. For that
> + * reason, certain fields use precisely the same numeric definitions as in
> + * the virtio-rtc proposal. The structure can also be exposed through an ACPI
> + * device with the CID "VMCLOCK", modelled on the "VMGENID" device except for
> + * the fact that it uses a real _CRS to convey the address of the structure
> + * (which should be a full page, to allow for mapping directly to userspace).
> + */
> +
> +#ifndef __VMCLOCK_ABI_H__
> +#define __VMCLOCK_ABI_H__
> +
> +#ifdef __KERNEL__
> +#include <linux/types.h>
> +#else
> +#include <stdint.h>
> +#endif
> +
> +struct vmclock_abi {
> +	/* CONSTANT FIELDS */
> +	uint32_t magic;
> +#define VMCLOCK_MAGIC	0x4b4c4356 /* "VCLK" */
> +	uint32_t size;		/* Size of region containing this structure */
> +	uint16_t version;	/* 1 */
> +	uint8_t counter_id; /* Matches VIRTIO_RTC_COUNTER_xxx except INVALID */
> +#define VMCLOCK_COUNTER_ARM_VCNT	0
> +#define VMCLOCK_COUNTER_X86_TSC		1
> +#define VMCLOCK_COUNTER_INVALID		0xff
> +	uint8_t time_type; /* Matches VIRTIO_RTC_TYPE_xxx */
> +#define VMCLOCK_TIME_UTC			0	/* Since 1970-01-01 00:00:00z */
> +#define VMCLOCK_TIME_TAI			1	/* Since 1970-01-01 00:00:00z */
> +#define VMCLOCK_TIME_MONOTONIC			2	/* Since undefined epoch */
> +#define VMCLOCK_TIME_INVALID_SMEARED		3	/* Not supported */
> +#define VMCLOCK_TIME_INVALID_MAYBE_SMEARED	4	/* Not supported */
> +
> +	/* NON-CONSTANT FIELDS PROTECTED BY SEQCOUNT LOCK */
> +	uint32_t seq_count;	/* Low bit means an update is in progress */
> +	/*
> +	 * This field changes to another non-repeating value when the CPU
> +	 * counter is disrupted, for example on live migration. This lets
> +	 * the guest know that it should discard any calibration it has
> +	 * performed of the counter against external sources (NTP/PTP/etc.).
> +	 */
> +	uint64_t disruption_marker;
> +	uint64_t flags;
> +	/* Indicates that the tai_offset_sec field is valid */
> +#define VMCLOCK_FLAG_TAI_OFFSET_VALID		(1 << 0)
> +	/*
> +	 * Optionally used to notify guests of pending maintenance events.
> +	 * A guest which provides latency-sensitive services may wish to
> +	 * remove itself from service if an event is coming up. Two flags
> +	 * indicate the approximate imminence of the event.
> +	 */
> +#define VMCLOCK_FLAG_DISRUPTION_SOON		(1 << 1) /* About a day */
> +#define VMCLOCK_FLAG_DISRUPTION_IMMINENT	(1 << 2) /* About an hour */
> +#define VMCLOCK_FLAG_PERIOD_ESTERROR_VALID	(1 << 3)
> +#define VMCLOCK_FLAG_PERIOD_MAXERROR_VALID	(1 << 4)
> +#define VMCLOCK_FLAG_TIME_ESTERROR_VALID	(1 << 5)
> +#define VMCLOCK_FLAG_TIME_MAXERROR_VALID	(1 << 6)
> +	/*
> +	 * If the MONOTONIC flag is set then (other than leap seconds) it is
> +	 * guaranteed that the time calculated according this structure at
> +	 * any given moment shall never appear to be later than the time
> +	 * calculated via the structure at any *later* moment.
> +	 *
> +	 * In particular, a timestamp based on a counter reading taken
> +	 * immediately after setting the low bit of seq_count (and the
> +	 * associated memory barrier), using the previously-valid time and
> +	 * period fields, shall never be later than a timestamp based on
> +	 * a counter reading taken immediately before *clearing* the low
> +	 * bit again after the update, using the about-to-be-valid fields.
> +	 */
> +#define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)
> +
> +	uint8_t pad[2];
> +	uint8_t clock_status;
> +#define VMCLOCK_STATUS_UNKNOWN		0
> +#define VMCLOCK_STATUS_INITIALIZING	1
> +#define VMCLOCK_STATUS_SYNCHRONIZED	2
> +#define VMCLOCK_STATUS_FREERUNNING	3
> +#define VMCLOCK_STATUS_UNRELIABLE	4
> +
> +	/*
> +	 * The time exposed through this device is never smeared. This field
> +	 * corresponds to the 'subtype' field in virtio-rtc, which indicates
> +	 * the smearing method. However in this case it provides a *hint* to
> +	 * the guest operating system, such that *if* the guest OS wants to
> +	 * provide its users with an alternative clock which does not follow
> +	 * UTC, it may do so in a fashion consistent with the other systems
> +	 * in the nearby environment.
> +	 */
> +	uint8_t leap_second_smearing_hint; /* Matches VIRTIO_RTC_SUBTYPE_xxx */
> +#define VMCLOCK_SMEARING_STRICT		0
> +#define VMCLOCK_SMEARING_NOON_LINEAR	1
> +#define VMCLOCK_SMEARING_UTC_SLS	2
> +	int16_t tai_offset_sec;
> +	uint8_t leap_indicator;
> +	/*
> +	 * This field is based on the the VIRTIO_RTC_LEAP_xxx values as
> +	 * defined in the current draft of virtio-rtc, but since smearing
> +	 * cannot be used with the shared memory device, some values are
> +	 * not used.
> +	 *
> +	 * The _POST_POS and _POST_NEG values allow the guest to perform
> +	 * its own smearing during the day or so after a leap second when
> +	 * such smearing may need to continue being applied for a leap
> +	 * second which is now theoretically "historical".
> +	 */
> +#define VMCLOCK_LEAP_NONE	0x00	/* No known nearby leap second */
> +#define VMCLOCK_LEAP_PRE_POS	0x01	/* Positive leap second at EOM */
> +#define VMCLOCK_LEAP_PRE_NEG	0x02	/* Negative leap second at EOM */
> +#define VMCLOCK_LEAP_POS	0x03	/* Set during 23:59:60 second */
> +#define VMCLOCK_LEAP_POST_POS	0x04
> +#define VMCLOCK_LEAP_POST_NEG	0x05
> +
> +	/* Bit shift for counter_period_frac_sec and its error rate */
> +	uint8_t counter_period_shift;
> +	/*
> +	 * Paired values of counter and UTC at a given point in time.
> +	 */
> +	uint64_t counter_value;
> +	/*
> +	 * Counter frequency, and error margin. The unit of these fields is
> +	 * seconds >> (64 + counter_period_shift)
> +	 */
> +	uint64_t counter_period_frac_sec;
> +	uint64_t counter_period_esterror_rate_frac_sec;
> +	uint64_t counter_period_maxerror_rate_frac_sec;
> +
> +	/*
> +	 * Time according to time_type field above.
> +	 */
> +	uint64_t time_sec;		/* Seconds since time_type epoch */
> +	uint64_t time_frac_sec;		/* (seconds >> 64) */
> +	uint64_t time_esterror_nanosec;
> +	uint64_t time_maxerror_nanosec;
> +};
> +
> +#endif /*  __VMCLOCK_ABI_H__ */
> diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
> new file mode 100644
> index 0000000000..acf91b54c2
> --- /dev/null
> +++ b/hw/acpi/vmclock.c
> @@ -0,0 +1,176 @@
> +/*
> + * Virtual Machine Clock Device
> + *
> + * Copyright © 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * Authors: David Woodhouse <dwmw2@infradead.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/i386/e820_memory_layout.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/vmclock.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "migration/vmstate.h"
> +#include "sysemu/reset.h"
> +
> +#include "vmclock-abi.h"
> +
> +void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
> +                        BIOSLinker *linker, const char *oem_id)
> +{
> +    Aml *ssdt, *dev, *scope, *method, *addr, *crs;
> +    AcpiTable table = { .sig = "SSDT", .rev = 1,
> +                        .oem_id = oem_id, .oem_table_id = "VMCLOCK" };
> +
> +    /* Put VMCLOCK into a separate SSDT table */
> +    acpi_table_begin(&table, table_data);
> +    ssdt = init_aml_allocator();
> +
> +    scope = aml_scope("\\_SB");
> +    dev = aml_device("VCLK");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVCLK")));
> +    aml_append(dev, aml_name_decl("_CID", aml_string("VMCLOCK")));
> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VMCLOCK")));
> +
> +    /* Simple status method */
> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    addr = aml_local(0);
> +    aml_append(method, aml_store(aml_int(0xf), addr));
> +    aml_append(method, aml_return(addr));
> +    aml_append(dev, method);
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_qword_memory(AML_POS_DECODE,
> +                                     AML_MIN_FIXED, AML_MAX_FIXED,
> +                                     AML_CACHEABLE, AML_READ_ONLY,
> +                                     0xffffffffffffffffULL,
> +                                     vms->physaddr,
> +                                     vms->physaddr + VMCLOCK_SIZE - 1,
> +                                     0, VMCLOCK_SIZE));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +    aml_append(ssdt, scope);
> +
> +    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> +    acpi_table_end(linker, &table);
> +    free_aml_allocator();
> +}
> +
> +static void vmclock_update_guest(VmclockState *vms)
> +{
> +    if (!vms->clk) {
> +        return;
> +    }
> +    vms->clk->seq_count |= 1;
> +    smp_wmb();
> +
> +    vms->clk->disruption_marker++;
> +
> +    smp_wmb();
> +    vms->clk->seq_count += 1;
> +}
> +
> +/* After restoring an image, we need to update the guest memory and notify
> + * it of a potential change to VM Generation ID
> + */
> +static int vmclock_post_load(void *opaque, int version_id)
> +{
> +    VmclockState *vms = opaque;
> +    vmclock_update_guest(vms);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_vmclock = {
> +    .name = "vmclock",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = vmclock_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(physaddr, VmclockState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void vmclock_handle_reset(void *opaque)
> +{
> +    VmclockState *vms = VMCLOCK(opaque);
> +
> +    if (!memory_region_is_mapped(&vms->clk_page)) {
> +        memory_region_add_subregion_overlap(get_system_memory(),
> +                                            vms->physaddr,
> +                                            &vms->clk_page, 0);
> +    }
> +}
> +
> +static void vmclock_realize(DeviceState *dev, Error **errp)
> +{
> +    VmclockState *vms = VMCLOCK(dev);
> +
> +    /* Given that this function is executing, there is at least one VMCLOCK
> +     * device. Check if there are several.
> +     */
> +    if (!find_vmclock_dev()) {
> +        error_setg(errp, "at most one %s device is permitted", TYPE_VMCLOCK);
> +        return;
> +    }
> +
> +    vms->physaddr = VMCLOCK_ADDR;
> +
> +    e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
> +
> +    memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
> +                           VMCLOCK_SIZE, &error_abort);
> +    memory_region_set_enabled(&vms->clk_page, true);
> +    vms->clk = memory_region_get_ram_ptr(&vms->clk_page);
> +    memset(vms->clk, 0, VMCLOCK_SIZE);
> +
> +    vms->clk->magic = cpu_to_le32(VMCLOCK_MAGIC);
> +    vms->clk->size = cpu_to_le16(VMCLOCK_SIZE);
> +    vms->clk->version = cpu_to_le16(1);
> +
> +    /* These are all zero and thus default, but be explicit */
> +    vms->clk->clock_status = VMCLOCK_STATUS_UNKNOWN;
> +    vms->clk->counter_id = VMCLOCK_COUNTER_INVALID;
> +
> +    qemu_register_reset(vmclock_handle_reset, vms);
> +
> +    vmclock_update_guest(vms);
> +}
> +
> +static Property vmclock_device_properties[] = {
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmclock_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_vmclock;
> +    dc->realize = vmclock_realize;
> +    device_class_set_props(dc, vmclock_device_properties);
> +    dc->hotpluggable = false;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo vmclock_device_info = {
> +    .name          = TYPE_VMCLOCK,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(VmclockState),
> +    .class_init    = vmclock_device_class_init,
> +};
> +
> +static void vmclock_register_types(void)
> +{
> +    type_register_static(&vmclock_device_info);
> +}
> +
> +type_init(vmclock_register_types)
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index f4a33b6c08..86b00bb94f 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -43,6 +43,7 @@ config PC
>      select SERIAL_ISA
>      select ACPI_PCI
>      select ACPI_VMGENID
> +    select ACPI_VMCLOCK
>      select VIRTIO_PMEM_SUPPORTED
>      select VIRTIO_MEM_SUPPORTED
>      select HV_BALLOON_SUPPORTED
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5d4bd2b710..e4dfad148e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -43,6 +43,7 @@
>  #include "sysemu/tpm.h"
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/vmgenid.h"
> +#include "hw/acpi/vmclock.h"
>  #include "hw/acpi/erst.h"
>  #include "hw/acpi/piix4.h"
>  #include "sysemu/tpm_backend.h"
> @@ -2505,7 +2506,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      uint8_t *u;
>      GArray *tables_blob = tables->table_data;
>      AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
> -    Object *vmgenid_dev;
> +    Object *vmgenid_dev, *vmclock_dev;
>      char *oem_id;
>      char *oem_table_id;
>  
> @@ -2578,6 +2579,13 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>                             tables->vmgenid, tables->linker, x86ms->oem_id);
>      }
>  
> +    vmclock_dev = find_vmclock_dev();
> +    if (vmclock_dev) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, tables->linker,
> +                           x86ms->oem_id);
> +    }
> +
>      if (misc.has_hpet) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_hpet(tables_blob, tables->linker, x86ms->oem_id,
> diff --git a/include/hw/acpi/vmclock.h b/include/hw/acpi/vmclock.h
> new file mode 100644
> index 0000000000..5605605812
> --- /dev/null
> +++ b/include/hw/acpi/vmclock.h
> @@ -0,0 +1,34 @@
> +#ifndef ACPI_VMCLOCK_H
> +#define ACPI_VMCLOCK_H
> +
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "hw/qdev-core.h"
> +#include "qemu/uuid.h"
> +#include "qom/object.h"
> +
> +#define TYPE_VMCLOCK    "vmclock"
> +
> +#define VMCLOCK_ADDR    0xfeffb000
> +#define VMCLOCK_SIZE    0x1000
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VmclockState, VMCLOCK)
> +
> +struct vmclock_abi;
> +
> +struct VmclockState {
> +    DeviceState parent_obj;
> +    MemoryRegion clk_page;
> +    uint64_t physaddr;
> +    struct vmclock_abi *clk;
> +};
> +
> +/* returns NULL unless there is exactly one device */
> +static inline Object *find_vmclock_dev(void)
> +{
> +    return object_resolve_path_type("", TYPE_VMCLOCK, NULL);
> +}
> +
> +void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
> +                        BIOSLinker *linker, const char *oem_id);
> +
> +#endif
> -- 
> 2.44.0
> 
> 



