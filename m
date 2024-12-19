Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECE2E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLFF-0000sI-Fw; Thu, 19 Dec 2024 13:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOLFE-0000s9-5B
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:27:32 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOLFC-0001YA-B1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:27:31 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2163b0c09afso10888905ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734632848; x=1735237648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dmOxa/yP4xXhzSvm4NLjg5AR27L+fmd/ScAJOLOB8/Q=;
 b=PjD514Nr3r1f2l30gbnxU1xZAVldktXI/WRpe7gtVRvoaSSUIwEg5PduUsRzMDdPZ2
 oMOEQ0z+fGKOYHWKJtElVgcAiqU866KXTi3mbOo/p5dn5akL/Zs2FzNpuhklWWagT4VO
 gjDQcrOncTP2GPsWvVhdaxA4npHgAWp9gMl2u3TNVZchImEzsJU7oF1ydTzcwXd/BPgK
 AKSfsd0x0H2boSnbzFreUo5ehDIvLhd7gehuMuwRrXS/Yu2sKIaayzncuoOUUSm1C3fA
 b+MXu0x1wOTgu1kqkEWDaSL/CmuazWpbS8OzFXwagI8ZwjUtJ7Mu7SYGaL0BjxLuo+tK
 0Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632848; x=1735237648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dmOxa/yP4xXhzSvm4NLjg5AR27L+fmd/ScAJOLOB8/Q=;
 b=mrNuYZsW+utzUyMUxPERYDcEnanRWcQAWm9OMje6MNEN3kksnfMJoKJVQ3PTorDjE8
 CfDho3MI9ZNgobGkRe7+z7oWjxNMaCZZvo4331QDNd694cp0onU42ikcFzsoskvLbAWw
 9+P7Vib1oFvSWtuQ+ysExzucHHpJ35UZ4AF1ibzNN3T3TW0nfNgkBv8J+XDoQRCJeIS4
 CTMkafJShUSpYg0QY6Hf/XNVasXgTNg1InQJjycgim3256qaVqJK7SUS7iZWfCLO4TI2
 Jw/zlOL0hXolC4oIuItdkBo6tsSa0D5Ft7ltaBHLX7UIGXI2tOBC8vlATPISfNZZPAIh
 0ROw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/Opy/OQ8Yx8vqD/IOW7P00yAPnSiy8NpDCeZRekRsjTrE4whiFiilYxrn5+iZl/7SHo5++w6uRXOV@nongnu.org
X-Gm-Message-State: AOJu0YwsAa0DHWSLdMPpsZvaR4UbqJJUMmmEFBzBoSRKCZqluqEKyyHD
 qIBRGwvBcigWy6hqZ4i+GwxtbzDQP+ia/37jvZOGD1A2v5gVdjCzyvIRY8MBGkyx8nZjtk7sFk1
 iegD7fw==
X-Gm-Gg: ASbGncvdlGr+o7/WfAwHPZOBhZz3X7SEU0qYpROydCp9KVMyUgZq0uRtWq9PCWYr6/s
 gGJcxOOKpVOiDSbdbs7sDyXrD7E4JBsDm8yjKkQZncKGf8GsrWRiBvdny7tSU5DxyU74PxIfqpl
 p0G01gayTWPF+bMSJEwc/9znhxQ/lF8yFhySqEKtmq7U9HoW0UZkba+ciQYiH8aXQJbIEnp6P98
 deni+mxxgl1FV/KOeEgGzff3H5twhe9B054kFHvQCMoXatQZ/c5uDst0CLI8sQfAom8OuxqXYxu
 mszZ6nqxJAdrl3AyiAl4LTr08uDlJ9tXu5ZDFmvpvg==
X-Google-Smtp-Source: AGHT+IGsYwzWC/KSSFRrABZmAkyy7fdbkIURWvZftFCkMQEHEMdyCKqX4LAMle4b3RRjMTaZNy4NFw==
X-Received: by 2002:a17:902:ebc8:b0:215:e98c:c5c1 with SMTP id
 d9443c01a7336-219e55915f9mr7252685ad.30.1734632848267; 
 Thu, 19 Dec 2024 10:27:28 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ec0:c32f:435b:9081:64c9:3330?
 ([2607:fb91:1ec0:c32f:435b:9081:64c9:3330])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9630a5sm15601715ad.51.2024.12.19.10.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:27:27 -0800 (PST)
Message-ID: <e53e11b6-169f-4988-9cf1-8c5a5c79e42e@linaro.org>
Date: Thu, 19 Dec 2024 10:27:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/42] Rust, qdev, target/i386 changes for 2024-12-19
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241219134843.443085-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241219134843.443085-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/19/24 05:48, Paolo Bonzini wrote:
> The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:
> 
>    Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 9c70b74bd8c7a3753b80a1aab22a0dc58da1ed68:
> 
>    rust: pl011: simplify handling of the FIFO enabled bit in LCR (2024-12-19 14:37:58 +0100)
> 
> ----------------------------------------------------------------
> * qdev: second part of Property cleanups
> * rust: second part of QOM rework
> * rust: callbacks wrapper
> * rust: pl011 bugfixes
> * kvm: cleanup errors in kvm_convert_memory()
> 
> ----------------------------------------------------------------
> v1->v2: I noticed that "meson test" returns success even if the tests actually failed
>          with SIGSEGV!  Sorry for not noticing that before.  For now I added a bandaid
>          in the form of "--test-threads 1" and replaced the Mutex<Cell<bool>> with a
>          BqlCell<bool> for documentation purposes.
> 
> Maciej S. Szmigiero (1):
>        target/i386: Reset TSCs of parked vCPUs too on VM reset
> 
> Paolo Bonzini (17):
>        rust: qom: put class_init together from multiple ClassInitImpl<>
>        rust: qom: add possibility of overriding unparent
>        rust: rename qemu-api modules to follow C code a bit more
>        rust: re-export C types from qemu-api submodules
>        bql: add a "mock" BQL for Rust unit tests
>        rust: tests: allow writing more than one test
>        rust: qom: add casting functionality
>        rust: qom: add initial subset of methods on Object
>        rust: qemu-api: add a module to wrap functions and zero-sized closures
>        kvm: consistently return 0/-errno from kvm_convert_memory
>        rust: pl011: fix declaration of LineControl bits
>        rust: pl011: match break logic of C version
>        rust: pl011: always use reset() method on registers
>        rust: pl011: fix break errors and definition of Data struct
>        rust: pl011: extend registers to 32 bits
>        rust: pl011: fix migration stream
>        rust: pl011: simplify handling of the FIFO enabled bit in LCR
> 
> Richard Henderson (24):
>        migration: Constify migration_properties
>        hw/ide: Constify sysbus_ahci_properties
>        target/ppc: Remove empty property list
>        target/s390x: Use s390x_cpu_properties for system mode only
>        hw/pci-host/astro: Remove empty Property list
>        hw/ppc: Only register spapr_nvdimm_properties if CONFIG_LIBPMEM
>        hw/tricore: Remove empty Property lists
>        hw/s390x: Remove empty Property lists
>        hw/xen: Remove empty Property lists
>        hw/sparc: Remove empty Property lists
>        hw/virtio: Remove empty Property lists
>        include/hw/qdev-core: Detect most empty Property lists at compile time
>        hw/core: Introduce device_class_set_props_n
>        migration: Use device_class_set_props_n
>        hw/scsi/megasas: Use device_class_set_props_n
>        hw/arm/armsse: Use device_class_set_props_n
>        rust/qemu-api: Use device_class_set_props_n
>        hw/core: Replace device_class_set_props with a macro
>        target/riscv: Do not abuse DEFINE_PROP_END_OF_LIST
>        include/hw/qdev-properties: Remove DEFINE_PROP_END_OF_LIST
>        include/hw/qdev-properties: Shrink struct Property
>        hw/core/qdev-properties: Constify Property argument to object_field_prop_ptr
>        hw/core/qdev-properties: Constify Property argument to PropertyInfo.print
>        Constify all opaque Property pointers

Please, really, replace my constify series with v2.


r~

