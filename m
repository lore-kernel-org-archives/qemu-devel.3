Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600CAC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSNl-0007X8-8Y; Mon, 29 Jul 2024 11:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYSNk-0007Tm-Bi
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYSNi-0001i7-26
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722267227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gOdxuhlC0hKorSyQVfDMKmXgVB7ow0l5OK4sY+cYrK0=;
 b=cDbh7m7VbzIKhMO5u5xWiUUGUsNSRVDF78yNY0FhwVVgq/k2poyVTpJOd9YOVAsb70wq+V
 VsBq2Q76kSSi471Hoby4bJCd/FMQ9rcahPl2m1vdHCqMuZCqzL/ve7nMbkG90XvPAZQa5L
 Ehos8NgSttWDrf/0Fs+LIosEiwOGi5I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-DifgApCgOTmC1vj5BGZEqw-1; Mon, 29 Jul 2024 11:33:46 -0400
X-MC-Unique: DifgApCgOTmC1vj5BGZEqw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42820af1106so3722345e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722267225; x=1722872025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOdxuhlC0hKorSyQVfDMKmXgVB7ow0l5OK4sY+cYrK0=;
 b=u7sxdCb62IEphAamTm8An3vXXcDnrVjfgUiGdjHBtXu/h7aLIyBhE5oHifPjC8cVRK
 S8GGGnu/NiwMfWqILCH+qdQYRF+7NYsacw7BB+PjfWQUFmnEcj2paHY26jGjlrjFU3sW
 h6LuS2jHd9JsGhvj2vfw87mWI1NrieneQmpy89mSQH0zA2RNZv2VYXf604pWmI06Vano
 8oLxEt5ICuDLOwOStRaRLIE+e0FY2MIFMDL8WjfD1jdKzZf53IseIviP2xp7zn3yF7Ke
 4t5hza2Vh+9hQw2ZFy1ouJEoDFI2erMZuGMN/vDtaqmLGyfohs2JUhRv0EcrtKbqjq1h
 C6cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtxYQUzkbHj6XCna9Wwk0IwCPOMLt4MIj8gwd7z1qaGG7T0HdC8EFeJSAn0iQytQTnCkGLNXGKN7bCEhxS0EM+bQ56HF8=
X-Gm-Message-State: AOJu0YxmafGuKfOrueY9zebSfWkjuLH3NBfVlQSc1z//kcsnbhJvdDyn
 3xwsgo812iP11sIkcqMP2TD3As4Zy3xWVIsKLnVKwrXogOmRuu1jIK1fNOiGUG5ZFodcyaVOs8H
 OHzgzdNQkR/Kirtx/rGpPiikJtji7gwhWDd6c7PuECYQbyj/4QfEe
X-Received: by 2002:a05:600c:3b99:b0:426:5269:9827 with SMTP id
 5b1f17b1804b1-42811a94590mr60054415e9.0.1722267224673; 
 Mon, 29 Jul 2024 08:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH11CwyPhlrH2xJ/R5zuEwuK8l7eeYYGyXEbvzQ/zeQzSr5tEaXptiR7TnM3lG3ZWRGuUwuXg==
X-Received: by 2002:a05:600c:3b99:b0:426:5269:9827 with SMTP id
 5b1f17b1804b1-42811a94590mr60053985e9.0.1722267223937; 
 Mon, 29 Jul 2024 08:33:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:98c4:742e:26be:b52d:dd54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281fd617desm21464125e9.35.2024.07.29.08.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 08:33:43 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:33:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3] ptp: Add vDSO-style vmclock support
Message-ID: <20240729113320-mutt-send-email-mst@kernel.org>
References: <e3164fc80e21336cbf13e24f98c9e5706afb77ab.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3164fc80e21336cbf13e24f98c9e5706afb77ab.camel@infradead.org>
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

On Mon, Jul 29, 2024 at 11:42:22AM +0100, David Woodhouse wrote:
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
> -- 
> 2.44.0
> 
> 



you said you will use __le here?


