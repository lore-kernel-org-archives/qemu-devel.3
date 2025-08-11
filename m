Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CD1C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 05:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulLD1-0007rk-VR; Mon, 11 Aug 2025 01:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ulLD0-0007qw-0O
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 01:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ulLCv-0006ax-CX
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 01:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754890580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vq5WHu4HCoOVCNVb0XYh6SqrZpzRhhO8BJylyBxK0bM=;
 b=UBMkPsTQl6xhEK6dpu8mHPUsIreypWIHkkc8OvrQrZm0AqQUL0xrEfGIk/x3tpWh7Viz22
 L+ytyvZ/PTZZwDXfspY/1bqs0uCLvKYe3wmwBOeZ6wf/AJXItd2JIABbOuQr5W4HH2YLWX
 e9Lh6rzBfYhhCaIorKON+ds9hDWAEdA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-16C32MeLNsOJ-Fey2GRSaQ-1; Mon, 11 Aug 2025 01:36:18 -0400
X-MC-Unique: 16C32MeLNsOJ-Fey2GRSaQ-1
X-Mimecast-MFC-AGG-ID: 16C32MeLNsOJ-Fey2GRSaQ_1754890577
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b81e16c17dso1897676f8f.3
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 22:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754890577; x=1755495377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vq5WHu4HCoOVCNVb0XYh6SqrZpzRhhO8BJylyBxK0bM=;
 b=qr7LyMYPBFM1j/nRKYAbsa3n6fogyDIIo/8+TXXFn3rEuoXc/W8Z55viXExQv6iDIw
 2iHBFF9yOejjikvXLlg5xIlDmJZZ+gCbrakagm3PllRqLOnQBVTX/cgOmOfrcE18iaLu
 grbv4VD6urXTe5B7sPcE01+mdX77MyNskZfsGs44gDFfYcnhttlo/r9X+kv/BLvWd8sE
 +nLDyLf1JWeLfSdiypiAm8FXRcq06az7i2sXw3WQX6MUEkdJIG2ir3wvmO10uaTW7m8m
 So91GRIPcMs7HJOvjOHNvBrnEu1QATvXHeGMjq+8uHWDken0aujzf3axDPDfwtc8YC6O
 J5VQ==
X-Gm-Message-State: AOJu0Yx0Q8unjRJNus7vaUo9/oR388ZhV0I/ee01S++6qduLiytxcWu8
 Hmbs4DqJHHOjtzRi5wgoSUZASc/OpQ4W10N1VJfXOfXCgfreOOWTruxl/Mfg4l+RvLabUIpSk7B
 7dxMF3tQv2hL0cv4v5iH8wdueCRi8zDh5HW83vi03pSL0u+rh8fJUFely
X-Gm-Gg: ASbGnctuIJnfsBnF0O6susiTUZh4l2CHwjjdM5PIppOCij2wtP/x+Nbbn0M5L7AXJl3
 8WVwQX5WjAYNcwwY37pXYfr1dOgIyw2qk4dwWjqDYFdM1gBsVia27zAZQmv2gmu0a7Z66FmOo/P
 4SlZrgx1nhDZ763vspVlNYcukm3yIBLJkj6fmTflAIRR1EZNjFvbsEEqeMqLqoH3P8sWGBIiHzh
 YUezvpDdXZcUVuqh59Ze4bCbUB/X/xuqyUmSOwQ+lVq8OHZayaIDI9hobVBhAipI5x8+I2GQIP+
 lneeO/CfneaMmH9ZEgffSD7tPLbIXfdS
X-Received: by 2002:a05:6000:240d:b0:3b8:d15f:45a2 with SMTP id
 ffacd0b85a97d-3b900942614mr8601982f8f.14.1754890577248; 
 Sun, 10 Aug 2025 22:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIvHIXz+LV+WXpysZEl2WT9rhatPKhinPHod1yLcEGDZrNAAFluasyZTjPgznsTdBh8XSoTw==
X-Received: by 2002:a05:6000:240d:b0:3b8:d15f:45a2 with SMTP id
 ffacd0b85a97d-3b900942614mr8601967f8f.14.1754890576814; 
 Sun, 10 Aug 2025 22:36:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e1cb7deesm29251955f8f.2.2025.08.10.22.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 22:36:16 -0700 (PDT)
Date: Mon, 11 Aug 2025 01:36:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 00/10] Reinvent BQL-free PIO/MMIO
Message-ID: <20250811013556-mutt-send-email-mst@kernel.org>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 08, 2025 at 02:01:27PM +0200, Igor Mammedov wrote:
> v3:
>   * hpet: replace explicit atomics with use seqlock API  (PeterX)
>   * introduce cpu_test_interrupt() (Paolo)
>     and use it tree wide for checking interrupts
>   * don't take BQL for setting exit_request, use qatomic_set() instead. (Paolo)
>   * after above change, relace conditional BQL with unconditional
>     to simlify things a bit (Paolo)
>   * drop not needed barriers (Paolo)
>   * minor tcg:cpu_handle_interrupt() cleanup
> 
> v2:
>   * Make both read and write pathes BQL-less (Gerd)
>   * Refactor HPET to handle lock-less access correctly
>     when stopping/starting counter in parallel. (Peter Maydell)
>   * Publish kvm-unit-tests HPET bench/torture test [1] to verify
>     HPET lock-less handling


nice

acpi things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> When booting WS2025 with following CLI
>  1)   -M q35,hpet=off -cpu host -enable-kvm -smp 240,sockets=4
> the guest boots very slow and is sluggish after boot
> or it's stuck on boot at spinning circle (most of the time).
> 
> pref shows that VM is experiencing heavy BQL contention on IO path
> which happens to be ACPI PM timer read access. A variation with
> HPET enabled moves contention to HPET timer read access.
> And it only gets worse with increasing number of VCPUs.
> 
> Series prevents large VM vCPUs contending on BQL due to PM|HPET timer
> access and lets Windows to move on with boot process.
> 
> Testing lock-less IO with HPET micro benchmark [2] shows approx 80%
> better performance than the current BLQ locked path.
> [chart https://ibb.co/MJY9999 shows much better scaling of lock-less
> IO compared to BQL one.]
> 
> In my tests, with CLI WS2025 guest wasn't able to boot within 30min
> on both hosts
>   * 32 core 2NUMA nodes
>   * 448 cores 8NUMA nodes
> With ACPI PM timer in BQL-free read mode, guest boots within approx:
>  * 2min
>  * 1min
> respectively.
> 
> With HPET enabled boot time shrinks ~2x
>  * 4m13 -> 2m21
>  * 2m19 -> 1m15
> respectively.
> 
> 2) "[kvm-unit-tests PATCH v4 0/5] x86: add HPET counter tests"
>     https://lore.kernel.org/kvm/20250725095429.1691734-1-imammedo@redhat.com/T/#t
> PS:
> Using hv-time=on cpu option helps a lot (when it works) and
> lets [1] guest boot fine in ~1-2min. Series doesn't make
> a significant impact in this case.
> 
> PS2:
> Tested series with a bunch of different guests:
>  RHEL-[6..10]x64, WS2012R2, WS2016, WS2022, WS2025
> 
> PS3:
>  dropped mention of https://bugzilla.redhat.com/show_bug.cgi?id=1322713
>  as it's not reproducible with current software stack or even with
>  the same qemu/seabios as reported (kernel versions mentioned in
>  the report were interim ones and no longer available,
>  so I've used nearest released at the time for testing) 
> 
> Igor Mammedov (10):
>   memory: reintroduce BQL-free fine-grained PIO/MMIO
>   acpi: mark PMTIMER as unlocked
>   hpet: switch to fain-grained device locking
>   hpet: move out main counter read into a separate block
>   hpet: make main counter read lock-less
>   introduce cpu_test_interrupt() that will replace open coded checks
>   x86: kvm: use cpu_test_interrupt() instead of oppen coding checks
>   kvm: i386: irqchip: take BQL only if there is an interrupt
>   use cpu_test_interrupt() instead of oppen coding checks tree wide
>   tcg: move interrupt caching and single step masking closer to user
> 
>  include/hw/core/cpu.h               | 12 ++++++++
>  include/system/memory.h             | 10 +++++++
>  accel/tcg/cpu-exec.c                | 25 +++++++---------
>  accel/tcg/tcg-accel-ops.c           |  3 +-
>  hw/acpi/core.c                      |  1 +
>  hw/timer/hpet.c                     | 38 +++++++++++++++++++-----
>  system/cpus.c                       |  3 +-
>  system/memory.c                     | 15 ++++++++++
>  system/physmem.c                    |  2 +-
>  target/alpha/cpu.c                  |  8 ++---
>  target/arm/cpu.c                    | 20 ++++++-------
>  target/arm/helper.c                 | 16 +++++-----
>  target/arm/hvf/hvf.c                |  6 ++--
>  target/avr/cpu.c                    |  2 +-
>  target/hppa/cpu.c                   |  2 +-
>  target/i386/hvf/hvf.c               |  4 +--
>  target/i386/hvf/x86hvf.c            | 21 +++++++------
>  target/i386/kvm/kvm.c               | 46 ++++++++++++++---------------
>  target/i386/nvmm/nvmm-all.c         | 24 +++++++--------
>  target/i386/tcg/system/seg_helper.c |  2 +-
>  target/i386/whpx/whpx-all.c         | 34 ++++++++++-----------
>  target/loongarch/cpu.c              |  2 +-
>  target/m68k/cpu.c                   |  2 +-
>  target/microblaze/cpu.c             |  2 +-
>  target/mips/cpu.c                   |  6 ++--
>  target/mips/kvm.c                   |  2 +-
>  target/openrisc/cpu.c               |  3 +-
>  target/ppc/cpu_init.c               |  2 +-
>  target/ppc/kvm.c                    |  2 +-
>  target/rx/cpu.c                     |  3 +-
>  target/rx/helper.c                  |  2 +-
>  target/s390x/cpu-system.c           |  2 +-
>  target/sh4/cpu.c                    |  2 +-
>  target/sh4/helper.c                 |  2 +-
>  target/sparc/cpu.c                  |  2 +-
>  target/sparc/int64_helper.c         |  4 +--
>  36 files changed, 193 insertions(+), 139 deletions(-)
> 
> -- 
> 2.47.1


