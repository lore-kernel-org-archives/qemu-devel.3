Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E66C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZH0C-0004Go-M3; Tue, 08 Jul 2025 18:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZH0A-0004EE-Tc
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 18:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZH08-0005S9-42
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 18:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752014481;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Th59yqZKU5dEO/5ON0qAlIoffWY8AJQBXGx2RrXvJVE=;
 b=Ziu2XXlZ2Ety7r/y4hYdvhxLUoUaGo6XUYy4xJQpl+JkP189q/TFveP8QRH/YzdD+6OM2S
 DcqYJRV/SONT5jU4H+TOA3uMOwMquDtbQFI1RFNWGDppuClt1sKAxGNAJwQPxSyINT/BQX
 DwbWW4pPh4doqX+LKEcbzjhPkeRnt1M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-nd12ufosPRSTm9F6LrK3ng-1; Tue, 08 Jul 2025 02:17:29 -0400
X-MC-Unique: nd12ufosPRSTm9F6LrK3ng-1
X-Mimecast-MFC-AGG-ID: nd12ufosPRSTm9F6LrK3ng_1751955448
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso2206803f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 23:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751955448; x=1752560248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Th59yqZKU5dEO/5ON0qAlIoffWY8AJQBXGx2RrXvJVE=;
 b=ltcGnsKjdoeawkmG1LsZtVCDsLqZwIThQTxdvG1jwy+/mlsMrvhIE/WzCgmTRihiaq
 oJpMTZNYd3jbd3TZ5HpQp4wEQdlt+RlnVHNNDaMOOAuuW8WcNvUKwo+hoWhuptcOwe8w
 z4T5hSogVlgYJ0iNc3V4R9fv3eH1Y/9ew04B2LM5SMsr/q5KA3QKhDZ1Bnrtlxkdbmpx
 PgVI3/aas6WyTaNfp+WPlH+16ssjfW+C2DnudMF3Uynn5n7Rkv/TFGLu6qthyx0spkSo
 oh/e3B9dxjLkCOH4R29jcu7YSw81iQDQN2DK8kr5ywYne44q7ND7X2p5nzdoyfl1jUAI
 pT5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjBx5kDkx9n2UL16ObjgBAgu8LZVTkN5qj8Hj0JfYE4uHrFUwor22K3lSyGZDrbwmfq/vM6DcdoL3U@nongnu.org
X-Gm-Message-State: AOJu0YyojqtlpJseKjeYEWiZlRMGAclsyhpqH9/I7D0cnBuil41tWb0P
 v19m11Rr9xGDgw7k+BKwSI8QkEjEPntQ+/zvLDFjGlt/AgGquPjrq0DGZA0uHDm4j38BbT9hoKU
 y+nuuh7MM4U7Bo5FN5NxSL5m1B2KjDA7in/E4dYF46rq1A0H9XCiuOk6E
X-Gm-Gg: ASbGncssylwjxWhvKu+OdqqCLDP8h4t6VenMVWShS8LdaeMwhVEd+BctWmf4jkp/gr/
 gZiLiuQx1LaA/09DQTrHtqAH91yUyt4vVf++zcbY/uBn5Di/xPAF+HBfzwDbu6DYQA91MXOdVUk
 ZTo26OEWE5hv0FOqAHHL5pj60dewsr9aFZsWt9ybtsxfL1JcS/PDB+/9sXAjAxA44rlB04b3txg
 0/GxlF3mnuCOlerrdt5JO35qWe6mfDYpEznSgThiSNf0/Xg6L2nddf09h68DPT11HsN5hD4cqTD
 egbc1nbc2oRqY5Caq43g3cnumbANPtE3GGNHzq5dA2JyqhJ16J9RibhWOrA0Qq8XocPFGQ==
X-Received: by 2002:a05:6000:4205:b0:3a4:f7e3:c63c with SMTP id
 ffacd0b85a97d-3b496f97855mr11262770f8f.0.1751955447982; 
 Mon, 07 Jul 2025 23:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsjLhC+OZaSBMPgiGP99stWdu9P3CMZciBhti+rdh+SRSw6IO1EjHgKYIsILgLv3ocKPlGTg==
X-Received: by 2002:a05:6000:4205:b0:3a4:f7e3:c63c with SMTP id
 ffacd0b85a97d-3b496f97855mr11262739f8f.0.1751955447486; 
 Mon, 07 Jul 2025 23:17:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b472259806sm12178521f8f.67.2025.07.07.23.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 23:17:26 -0700 (PDT)
Message-ID: <c8405058-b26b-4d19-9251-1c37548e2b70@redhat.com>
Date: Tue, 8 Jul 2025 08:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/36] ACPI PCI Hotplug support on ARM
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, Jonathan.Cameron@huawei.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250703123728.414386-1-eric.auger@redhat.com>
 <152beeb2-7de7-4a4b-8f5d-806e7f18dda6@redhat.com>
 <20250707135106-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250707135106-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Michael,

On 7/7/25 7:53 PM, Michael S. Tsirkin wrote:
> On Mon, Jul 07, 2025 at 07:09:34PM +0200, Eric Auger wrote:
>> Hi,
>>
>> On 7/3/25 2:35 PM, Eric Auger wrote:
>>> This series enables ACPI PCI hotplug/hotunplug on ARM.
>>> It is not enabled by default and ACPI PCI hotplug can
>>> be selected by setting:
>>>
>>> -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
>>>
>>> Expected benefits should be similar to those listed in [1],
>>> ie. removal of some racy behaviors, improved latencies.
>>>
>>> The infrastructure used in x86 is heavily reused and a
>>> huge part of the series consists in moving code from
>>> hw/i386/acpi-build.c to a generic place and slightly
>>> adapting it to make it usable on ARM. The DSDT table is
>>> augmented to support ACPI PCI hotplug elements.
>>>
>>> On ARM we use use a GED event to notify the OS about
>>> hotplug events.
>> gentle ping on this series. I was hoping that this could target 10.1 but
>> I ackowledge this is a big series to review and I am already very
>> grateful to all reviewers.
>>
>> At least patches 1-15 have collected R-bs including Igor's ones. They
>> can be seen as code move/reshuffle/cleanup and does not bring any
>> functionality. I think patches 16-19 also belong to prerequisite and
>> fixes and are easy to parse.
>> So if we could at least have patches 1-19 merged in 10.1, this would
>> alleviate the rebase efforts for next respins if any.
>>
>> Of course I have not totally lost all hopes to get this in in 10.1 ;-)
>> and I will be able to diligently respin upon comments.
>>
>> Thanks
>>
>> Eric
>
> If no one objects, I can queue this. OK with ARM maintainers?
> I think the only comment I have is shorter/cropped commit logs for the blobs,
> that Jonathan already pointed out.
> Want to respin doing that?
Sure I will respin today with that change and grabbing latest R-bs from
Jonathan.

Thanks

Eric
>
>
>>> Best Regards
>>>
>>> Eric
>>>
>>> This series can be found at:
>>> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v5
>>>
>>> previous series:
>>> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v4
>>>
>>> History:
>>> v4 -> v5:
>>> - Collected Jonathan's R-bs (many thanks!)
>>> - fixed the tests/qtest/bios-tables-test issue by
>>>   creating a variant for the viot test
>>> - use the 3 phase reset API
>>> - fixed qom-test failures that were due to unconditionnal
>>>   fetches of the GED property
>>>
>>> v3 -> v4:
>>> - toook into account all comments on v3
>>> - static acpi-index is now supported unconditionally
>>>   from acpi pcihp option. See indiviual patches.
>>> - I hit a problem with ref block generation at
>>>   [19/32] tests/qtest/bios-tables-test: Update ARM DSDT reference
>>>   blobs: despite I regenerate the blobs, I get some errors.
>>>
>>> v2 -> v3:
>>> - lot of changes taking into account various feedbacks
>>>   (many thanks to all reviewers). Please refer to
>>>   individual patches for details. Main changes:
>>>   - no more machine option, acpi pci hp is not set by
>>>     default.
>>>   - removal of 2 unused variables in the osc method
>>>   - introduction of GED property to set the bus
>>>   - rework of the init/reset sequence
>>>   - fix virtio-mem-pci hotplug regression
>>>
>>> v1 -> v2:
>>> - collected a bunch of R-bs from Gustavo (many thanks!)
>>> - Fixed the breakage of bios-tables-test in TCG mode by
>>>   incorporating Gustavo's patches (part of
>>>   [PATCH 0/5] ACPI tests for PCI Hotplug on ARM
>>>   https://lore.kernel.org/all/20250526053123.1434204-1-gustavo.romero@linaro.org/)
>>> - Tweeked the dsdt aml changes to avoid any dsdt blob difference when
>>>   acpi-pcihp is off.
>>>
>>> RFC -> v1:
>>> - First 3 trivial patches were pulled separately
>>> - Fix of the register region size (0x18), ie. ACPI_PCIHP_SIZE
>>> - addition of aml_pci_edsm which was not called in RFC
>>> - acpi-index feature is now fixed. vms->bus was not set on
>>>   acpi_pcihp_init. The init sequence is still hacky though. Suggestions
>>>   are welcome.
>>>
>>> [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
>>> https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/
>>>
>>>
>>> Eric Auger (32):
>>>   hw/i386/acpi-build: Make aml_pci_device_dsm() static
>>>   hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>>>   hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
>>>     acpi_dsdt_add_pci_osc
>>>   hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>>>   hw/acpi/ged: Add a acpi-pci-hotplug-with-bridge-support property
>>>   hw/pci-host/gpex-acpi: Use GED acpi pcihp property
>>>   hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>>>   hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
>>>   tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change
>>>   hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>>>   hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>>>   hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>>>   hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
>>>     pcihp
>>>   hw/i386/acpi-build: Use AcpiPciHpState::root in acpi_set_pci_info
>>>   hw/i386/acpi-build: Move aml_pci_edsm to a generic place
>>>   qtest/bios-tables-test: Prepare for fixing the aarch64 viot test
>>>   qtest/bios-tables-test: Add a variant to the aarch64 viot test
>>>   qtest/bios-tables-test: Generate DSDT.viot
>>>   hw/arm/virt-acpi-build: Let non hotplug ports support static
>>>     acpi-index
>>>   tests/qtest/bios-tables-test: Update ARM DSDT reference blobs
>>>   hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
>>>     hotplug
>>>   hw/acpi/ged: Add a bus link property
>>>   hw/arm/virt: Pass the bus on the ged creation
>>>   hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
>>>     implementation
>>>   hw/acpi/pcihp: Remove root arg in acpi_pcihp_init
>>>   hw/acpi/ged: Prepare the device to react to PCI hotplug events
>>>   hw/acpi/ged: Support migration of AcpiPciHpState
>>>   hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>>>   hw/arm/virt: Minor code reshuffling in create_acpi_ged
>>>   hw/arm/virt: Let virt support pci hotplug/unplug GED event
>>>   qtest/bios-tables-test: Generate reference blob for
>>>     DSDT.hpoffacpiindex
>>>   qtest/bios-tables-test: Generate reference blob for DSDT.acpipcihp
>>>
>>> Gustavo Romero (4):
>>>   tests/qtest/bios-tables-test: Prepare for changes in the DSDT table
>>>   tests/qtest/bios-tables-test: Prepare for changes in the arm virt DSDT
>>>     table
>>>   tests/qtest/bios-tables-test: Prepare for addition of acpi pci hp
>>>     tests
>>>   tests/qtest/bios-tables-test: Add aarch64 ACPI PCI hotplug test
>>>
>>>  hw/i386/acpi-build.h                          |   4 -
>>>  include/hw/acpi/generic_event_device.h        |  17 +-
>>>  include/hw/acpi/pci.h                         |   5 +-
>>>  include/hw/acpi/pcihp.h                       |  17 +-
>>>  include/hw/arm/virt.h                         |   1 +
>>>  include/hw/pci-host/gpex.h                    |   1 +
>>>  include/hw/sysbus.h                           |   1 +
>>>  hw/acpi/acpi-pci-hotplug-stub.c               |   2 +-
>>>  hw/acpi/generic_event_device.c                |  77 +++
>>>  hw/acpi/ich9.c                                |   7 +-
>>>  hw/acpi/pci-bridge.c                          |  54 ++
>>>  hw/acpi/pci.c                                 |  50 ++
>>>  hw/acpi/pcihp.c                               | 439 ++++++++++++++-
>>>  hw/acpi/piix4.c                               |   5 +-
>>>  hw/arm/virt-acpi-build.c                      |  38 ++
>>>  hw/arm/virt.c                                 |  27 +-
>>>  hw/core/sysbus.c                              |  11 +
>>>  hw/i386/acpi-build.c                          | 532 +-----------------
>>>  hw/pci-host/gpex-acpi.c                       |  74 +--
>>>  tests/qtest/bios-tables-test.c                |  53 ++
>>>  hw/arm/Kconfig                                |   2 +
>>>  hw/pci-host/Kconfig                           |   1 +
>>>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5293 bytes
>>>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5379 bytes
>>>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 0 -> 6202 bytes
>>>  .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 0 -> 5347 bytes
>>>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6654 bytes
>>>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7768 bytes
>>>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5495 bytes
>>>  tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 0 -> 5310 bytes
>>>  tests/data/acpi/riscv64/virt/DSDT             | Bin 3576 -> 3538 bytes
>>>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
>>>  32 files changed, 811 insertions(+), 607 deletions(-)
>>>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
>>>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
>>>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.viot
>>>


