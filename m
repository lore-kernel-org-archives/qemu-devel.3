Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E97C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUxL-0007rf-HS; Mon, 26 May 2025 06:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJUxJ-0007rJ-SE
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJUxG-0002Ln-T7
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748254872;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2r2NJt7gr1iPEVYKtZXa/2g3jnOxC9qXFGu7EwA7rI=;
 b=Zl1u63PLI9xPO6OKW9IPNwrdvl1AcUzuZ+hpAMQXUlabc6WERu2f6ruBKwPnuJEpgKoKT0
 iRgOW0DM22FjeBjxqPWX/4L2NOUs2+9DJ31VD+0Yj2oYWF5WtA5GU2RvUJ0FUKdrCi/87K
 yxNJbM4dEw475QGX1HLTQctg5eJfRfU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-_baR-G7kPNKQZMr1PgA1gQ-1; Mon, 26 May 2025 06:21:10 -0400
X-MC-Unique: _baR-G7kPNKQZMr1PgA1gQ-1
X-Mimecast-MFC-AGG-ID: _baR-G7kPNKQZMr1PgA1gQ_1748254869
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so11393115e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 03:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254869; x=1748859669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D2r2NJt7gr1iPEVYKtZXa/2g3jnOxC9qXFGu7EwA7rI=;
 b=Uo6bAm//eUPmRANO9PJV7bHZo0guULNkxrNW1o86y49AWFLDZHaHH+3o9u1j5D56o4
 tWDylzJjyciNv7HEK3TrTwIizhM1EZ2HgcTlANtuCOSFVgFR4bymjQQai/BOTyFsAcvO
 4Spq5a8JwFCWmnJQJ0FJ4j9HF9a02kK4o1f9B2HLy8uQ8yhpig3/+4qIS4snFQzowzLc
 hy7b+sAwCI0QtdjLYjrdk57tGeHtOAjQme8XZ6CRTgoVurEbujRxQd4MkVKknFm8cvR0
 Xo+8IyC+8rlJUX1NRyL54h9AaW6fnSOldu4w9oWu1uaU25D4WxzeevMYct3GDteB8CnU
 Rh9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/whXqV86xYogPB1jnD7Z+npg42YVRRh9hU4bI5zYiMhX+A256tr62Tq0sNqQVipfNS66/fVjk54RN@nongnu.org
X-Gm-Message-State: AOJu0YwrgesIVioPcBrHGs5cRv+icALTHj33+UrysA2k8jIMuub4HBOX
 BP9Dl2O5q4wDQy53bLee/p8l24AsujNIMR/Npz+EyoXdvb65BkRBTfU1zGEn06EfKeCkE9HDUnK
 QWcWRKFGyjsBr0c/B8XUo6bfycB61+OJa04/8yy+ss3mc/Qx5gz0/jjVG
X-Gm-Gg: ASbGncukahYrqIZj8no0xaRdF2FQntIE8Zh15q6GZDR9syXacL90wSR2pZevrNy95QT
 SsOCMf0XQ+i6rwcdEg9BIQuaS/HpUtQr7ctV8mod5hsSzlGpAOP9VvPmja0pZiuhB2z3lakBmUE
 wKWIQ+CDWcm006lqdzffEWb9a8uJNzz9cJf+hsv4QTrcrqc02f3V+WkrdK6ab6RaRAlGiOfjTKD
 X0vDYHH0+15h6IUmCIdhqBDGHjLQxKmxXTPpmtl/64hc79ozkYMx5tZiWWMCxecZ4ub+oYhL/K6
 foab8FBFPukxSZxAuhvnhSQeqtV1UzlLXZlLO2H126ak/qdM8XWNgOEcUbY=
X-Received: by 2002:a05:600c:64ca:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-44c935dcaecmr69828615e9.12.1748254869120; 
 Mon, 26 May 2025 03:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaWPNtZCgdd1aWK94g/ddOVQ1pYnNiUS+ZPBOEeb6YcvsVZpbsL2I3t+/QK/xfaOiCk9oqRw==
X-Received: by 2002:a05:600c:64ca:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-44c935dcaecmr69828295e9.12.1748254868701; 
 Mon, 26 May 2025 03:21:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebd8b9absm215122685e9.1.2025.05.26.03.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 03:21:08 -0700 (PDT)
Message-ID: <2fe04c2b-d631-4ea5-9703-d44e50e13016@redhat.com>
Date: Mon, 26 May 2025 12:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] ACPI PCI Hotplug support on ARM
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <6b7b0e20-546b-4b72-9489-4468fafb76ba@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6b7b0e20-546b-4b72-9489-4468fafb76ba@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/26/25 7:55 AM, Gustavo Romero wrote:
> Hi Eric,
>
> On 5/14/25 14:00, Eric Auger wrote:
>> This series enables ACPI PCI hotplug/hotunplug on ARM
>> and makes it default for 10.1 machine type. This aligns with
>> x86 q35 machine. Expected benefits should be similar to
>> those listed in [1].
>>
>> It is still possible to disable it using a virt machine
>> option: virt,acpi-pcihp=off and restore the legacy behavior.
>>
>> The infrastructure used in x86 is heavily reused and a
>> huge part of the series consists in moving code from
>> hw/i386/acpi-build.c to a generic place and slightly
>> adapting it to make it usable on ARM. The DSDT table is
>> augmented to support ACPI PCI hotplug elements.
>>
>> On ARM we use use a GED event to notify the OS about
>> hotplug events.
>>
>> I have not noticed any tests/qtest/bios-tables-test failures
>> neither on x86 nor ARM. x86 DSDT table has not changed.
>> ARM DSDT table definitively has but there are no tests
>> impacted. ARM misses hotplug tests that do exist on x86. This
>> most probably should be considered in the future.
>
> I've just posted a v1 for a acpi-pcihp=on test:
>
> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05824.html
>
> The odd thing is that I noticed failures in the existing aarch64
> acpi tests in tests/qtest/bios-tables-test. At least the rename
> of the variable 'CTRL' to 'Local0' in the _OSC method should cause
> a mismatch against the current base DSDT? So I had to handle it
> via patches 1/5, 2/5, and 3/5. The diff is in the 3/5 commit body.

Thank you for contributing those tests.

Hum I think my mistake was to have executed the existing tests in KVM
acceleration mode only using
QTEST_QEMU_BINARY=qemu-system-aarch64 tests/qtest/bios-tables-test
direct execution.

The failing tests belong to the TCG category I think.

I will review your tests and if you allow me I may need to include
patches 1 and 3 in my series to prevent existing tests from failing, of
course with all your credits.

Thank you again for reporting the issue!

Eric




>
> Cheers,
> Gustavo
>
>> Best Regards
>>
>> Eric
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v1
>>
>> previous RFC:
>> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-rfc
>>
>> History:
>> RFC -> v1:
>> - First 3 trivial patches were pulled separately
>> - Fix of the register region size (0x18), ie. ACPI_PCIHP_SIZE
>> - addition of aml_pci_edsm which was not called in RFC
>> - acpi-index feature is now fixed. vms->bus was not set on
>>    acpi_pcihp_init. The init sequence is still hacky though. Suggestions
>>    appreciated.
>>
>> [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
>> https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/
>>
>>
>> Eric Auger (22):
>>    hw/i386/acpi-build: Make aml_pci_device_dsm() static
>>    hw/arm/virt: Introduce machine state acpi pcihp flags and props
>>    hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>>    hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
>>      acpi_dsdt_add_pci_osc
>>    hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>>    hw/pci-host/gpex-acpi: Propagate hotplug type info from virt machine
>>      downto gpex
>>    hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>>    hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
>>    hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>>    hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>>    hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>>    hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
>>      pcihp
>>    hw/i386/acpi-build: Introduce and use acpi_get_pci_host
>>    hw/i386/acpi-build: Move aml_pci_edsm to a generic place
>>    hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
>>      hotplug
>>    hw/acpi/ged: Prepare the device to react to PCI hotplug events
>>    hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
>>      implementation
>>    hw/acpi/ged: Support migration of AcpiPciHpState
>>    hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>>    hw/arm/virt: Let virt support pci hotplug/unplug GED event
>>    hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
>>    hw/arm/virt: Use ACPI PCI hotplug by default
>>
>>   hw/i386/acpi-build.h                   |   4 -
>>   include/hw/acpi/aml-build.h            |   2 +
>>   include/hw/acpi/generic_event_device.h |   5 +
>>   include/hw/acpi/pci.h                  |   4 +-
>>   include/hw/acpi/pcihp.h                |  19 +-
>>   include/hw/arm/virt.h                  |   4 +
>>   include/hw/pci-host/gpex.h             |   1 +
>>   include/hw/sysbus.h                    |   1 +
>>   hw/acpi/aml-build.c                    |  50 +++
>>   hw/acpi/generic_event_device.c         |  55 +++
>>   hw/acpi/pci.c                          |  20 +
>>   hw/acpi/pcihp.c                        | 482 ++++++++++++++++++++-
>>   hw/arm/virt-acpi-build.c               |  27 ++
>>   hw/arm/virt.c                          | 107 ++++-
>>   hw/core/sysbus.c                       |  11 +
>>   hw/i386/acpi-build.c                   | 552 +------------------------
>>   hw/pci-host/gpex-acpi.c                |  75 +---
>>   hw/arm/Kconfig                         |   2 +
>>   18 files changed, 806 insertions(+), 615 deletions(-)
>>
>


