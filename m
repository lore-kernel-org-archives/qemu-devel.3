Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCB6E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKw15-00042x-16; Tue, 10 Dec 2024 03:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1tKw0y-00042h-R5
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:54:44 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1tKw0u-0004M2-I4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:54:44 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so4385671a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733820877; x=1734425677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eMmuDzCOtk0P3qAVSDrdvfD9qizU1PjXn3xjXpj8i7Q=;
 b=esHz944Ip4gPfo3i74f3qubIwEBAJCS65DD+yKreh6itZOmvXvA9HuLoPr0jINbJIM
 ywmwU3VQ4UATEnzccWn4HpXy2q4Fqhqs9ZNiqWpK9RAKgdqTVE5ifHYFUGo4jk4OydTY
 wiuOGnA/NENED9R5ygTmMOXpIwhHCi02E9rBUOhJ0r0pQywtO5SBwO8uVfvuh8qeVc9B
 QyC7AJfLu5kyAzTGiILVMD8qMRS3Ord0aGoe6+V7igcrW5lXBHcc2cqbKb0vUxlbBgbB
 XlVPcSjTRGOsk2u8pU8jDEQTtMCl0S2kDcQrRlXqeTjym3gxXP/BKaufQsfhBiXmmV8I
 Vh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733820877; x=1734425677;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMmuDzCOtk0P3qAVSDrdvfD9qizU1PjXn3xjXpj8i7Q=;
 b=Nc2JkUe58gd5FkjJgkIPNgO6BgWSwk1u6s5m9R7UEn3EnfU3TSXGA17GiOzW8qD7aH
 HNfwWAloyyZpTQOESq3zI6aSD3kMO+QnXvd7cd8AwyP3mvpyu8Z8lSLSlPyrzrrwatC1
 eTh5r7hQ084+w1POGKvRiGfodJuiBDOIpLwywxWfDOU61bQOS72LnmSRD/ELUCZB0svu
 M90LAyLCXrQhEqHZ6DZbzXiSDJHB2AWHG4Z2qfyYYnSxRzqu0VL5ChrKia67jKwRPTmp
 Nd4WI8iKn+bq3hw/SRWiM1aaH5HBBBAZDlMEweBSnH0KmgHmr4LneYTswHdksu7CJvy9
 gxHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbCyZQ4NR+1ZT8Y6nFrdIEtAEiOJRzA1ud5pRxOk3RuhjGJemPd7heXWVyMKrwiSadTKBwEP0n9maN@nongnu.org
X-Gm-Message-State: AOJu0YynSqXychT1PIVox7EoK6VdIB3mvXmh53nKmL0usmYNoOgHm0Ty
 EwXCU9NkrpL1+BLtH8KT9ErpArMgpaG1xsbOHQSz7maOcug8gD0d
X-Gm-Gg: ASbGncs5t/4NOpde3ACLlXdBabtjOgZLCezgjwj9h3PSejZdzSbd+BpjISIdDTZBpln
 23WmAWK0tZo0GlSKmPt7WEOMj8dVXUh77X2u6yb8m9rhTLafpl9R0bYacZTWhsuN3xBqSFge/r3
 RNPKzcm0d/b/aayqL1xTjhvbFlrmUQ/ndobGaBrsP2P2/jHpcaHS/8DMY9e3p/7K92axbJVZAZg
 aQeRwsS692Pm4JRhagE8kYgoR9LlQf5k1JVOeFgfvMjwJHrpE7tm5YzsW39RhrDsiGbNft7q98R
 x8rm3XQ=
X-Google-Smtp-Source: AGHT+IHqv0gN5Y6seCjNUmRACQ4qGrQhe9Oe9Xxqu5KtInfnMah2xk1/OLK5CT7rLnXQtRS+OSCzOQ==
X-Received: by 2002:a05:6402:4490:b0:5d3:da65:ff26 with SMTP id
 4fb4d7f45d1cf-5d418604a7amr7866661a12.31.1733820876486; 
 Tue, 10 Dec 2024 00:54:36 -0800 (PST)
Received: from [192.168.9.8] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3cedbb8fesm5738281a12.22.2024.12.10.00.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 00:54:35 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <48f0be10-718c-409f-b5ac-d0775add9824@xen.org>
Date: Tue, 10 Dec 2024 08:54:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/acpi: Add vmclock device
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
References: <7bdd6feab5bb6c32c9c83ef3d184882c2499baa6.camel@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <7bdd6feab5bb6c32c9c83ef3d184882c2499baa6.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/12/2024 17:33, David Woodhouse wrote:
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
> sufficient and is compatible with what's being shipped in certain
> commercial hypervisors.
> 
> Linux guest support was merged into the 6.13-rc1 kernel:
> https://git.kernel.org/torvalds/c/205032724226
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> This is basically unchanged since the last time the structure was
> changed in July, apart from fairly trivial cosmetic changes and now
> importing the header file from Linux.
> 
> 
> v5:
>   • Trivial simplification to AML generation.
>   • Import vmclock-abi.h from Linux now the guest support is merged.
> 
> v4:
>   • Trivial checkpatch fixes and comment improvements.
> 
> v3:
>   • Add comment that vmclock-abi.h will come from the Linux kernel
>     headers once it gets merged there.
> 
> v2:
>   • Change esterror/maxerror fields to nanoseconds.
>   • Change to officially assigned AMZNC10C ACPI HID.
>   • Fix little-endian handling of fields in update.
> 
>   hw/acpi/Kconfig                              |   5 +
>   hw/acpi/meson.build                          |   1 +
>   hw/acpi/vmclock.c                            | 184 +++++++++++++++++++
>   hw/i386/Kconfig                              |   1 +
>   hw/i386/acpi-build.c                         |  10 +-
>   include/hw/acpi/vmclock.h                    |  34 ++++
>   include/standard-headers/linux/vmclock-abi.h | 182 ++++++++++++++++++
>   scripts/update-linux-headers.sh              |   1 +
>   8 files changed, 417 insertions(+), 1 deletion(-)
>   create mode 100644 hw/acpi/vmclock.c
>   create mode 100644 include/hw/acpi/vmclock.h
>   create mode 100644 include/standard-headers/linux/vmclock-abi.h
> 

Reviewed-by: Paul Durrant <paul@xen.org>


