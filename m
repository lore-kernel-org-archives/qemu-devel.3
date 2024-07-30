Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E6AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYr2c-0000Pn-I0; Tue, 30 Jul 2024 13:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYr2U-0000Nq-6R
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYr2R-0003ny-22
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722362009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Br+aiHQ56Cf6eN5Hl3JWYzEJApspP6wHcJGm4svc0XA=;
 b=CXoCV1XWtYBJSwLbahjsl+fZS+6JkTvCeZGKaAm55VyDs8mf1yUGI6BiMcJCjCcure1Sx/
 xU3vHAH7P4nqM3hbhXfSZ1d4moM1r1++NJt0BBTfYUOFLA2Ju5ZHd74pEyNzqlMoPlW/QS
 HD40YOmuCiws7egFPpJew0EvThRzoDM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-_YOYC-y0PSCj7gTjBuxBfQ-1; Tue, 30 Jul 2024 13:53:28 -0400
X-MC-Unique: _YOYC-y0PSCj7gTjBuxBfQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a2c84a3bbaso6071293a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 10:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722362007; x=1722966807;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Br+aiHQ56Cf6eN5Hl3JWYzEJApspP6wHcJGm4svc0XA=;
 b=fehFBcLmfp7iokxven8CR4pppU79OUEk1yZ/IaIe1SM59GSbnhPaFJGTZ6VDst+qwd
 7OV40zLiNyKQyC8Bljraix6I5Y7alG5cMlCdD/Jr9s/ZqaulidA5EScdXZSlo+XPn9Tl
 UByONoVVcB0HC9M4hubS199T4iLApCVEqa9U2XGQvgMl/K2EWSgynhdxbUWORUJIi2AR
 heI+npJ2b0J80GdeGBMJ2j9QIpvn6L63mPJwwsX0xrNe8lhoMm6Hz0gVF2/GUzxtX4pc
 3nl1DAjHBb5ZI8x50NHKncU/DaNjESUzmArvq/PlK0cVzhUgEshbkI+n3MmGcKEjbiLW
 FfXg==
X-Gm-Message-State: AOJu0Yy1gqMIiJ8Jv2XetBZIAAui4CFL0LWGjoxIqlrzEskNl0KVF9Ig
 1jJ6LoxR441FD3Joo/GAGVi9jbKIZ/0Ol4+tf/r8kmp4Zt8kWktybe1k4D0axUlBdiWjEuVvvKY
 MNYrGSDJ1nZt2dMsEq07utBBid0fWUzkmFOqHs41tjbBHdkETRdyR
X-Received: by 2002:a05:6402:430d:b0:5a3:4ae8:cbd3 with SMTP id
 4fb4d7f45d1cf-5b0205d6eeamr9246766a12.11.1722362006988; 
 Tue, 30 Jul 2024 10:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyHvpLeM27SXTQgYwVPu6o7d91Y+nupRsUWlizuado7ZdjLKo1HKxhUHkQrxEgkVlqRhpq4Q==
X-Received: by 2002:a05:6402:430d:b0:5a3:4ae8:cbd3 with SMTP id
 4fb4d7f45d1cf-5b0205d6eeamr9246741a12.11.1722362006209; 
 Tue, 30 Jul 2024 10:53:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:ce53:abb9:7fe9:ef80:6a78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac631b03ccsm7522076a12.16.2024.07.30.10.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 10:53:25 -0700 (PDT)
Date: Tue, 30 Jul 2024 13:53:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH v2] hw/acpi: Add vmclock device
Message-ID: <20240730135143-mutt-send-email-mst@kernel.org>
References: <bc85aba60523e0d63e760d5143c5cb57688779d1.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc85aba60523e0d63e760d5143c5cb57688779d1.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> diff --git a/hw/acpi/vmclock-abi.h b/hw/acpi/vmclock-abi.h
> new file mode 100644
> index 0000000000..19cbf85efd
> --- /dev/null
> +++ b/hw/acpi/vmclock-abi.h
> @@ -0,0 +1,186 @@
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
> +	 * This field is based on the VIRTIO_RTC_LEAP_xxx values as defined
> +	 * in the current draft of virtio-rtc, but since smearing cannot be
> +	 * used with the shared memory device, some values are not used.
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
> +	 * Counter period, and error margin of same. The unit of these
> +	 * fields is 1/2^(64 + counter_period_shift) of a second.
> +	 */
> +	uint64_t counter_period_frac_sec;
> +	uint64_t counter_period_esterror_rate_frac_sec;
> +	uint64_t counter_period_maxerror_rate_frac_sec;
> +
> +	/*
> +	 * Time according to time_type field above.
> +	 */
> +	uint64_t time_sec;		/* Seconds since time_type epoch */
> +	uint64_t time_frac_sec;		/* Units of 1/2^64 of a second */
> +	uint64_t time_esterror_nanosec;
> +	uint64_t time_maxerror_nanosec;
> +};
> +
> +#endif /*  __VMCLOCK_ABI_H__ */

We don't want to manually sync headers with Linux.
I think Linux abi should live under uapi. When it is there, we can use
./scripts/update-linux-headers.sh machinery to import it.

-- 
MST


