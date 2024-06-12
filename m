Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041F2C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMo6-0004px-Cj; Wed, 12 Jun 2024 08:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sHMnz-0004os-8W
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:10:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sHMnw-0007Iz-Dm
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:10:19 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7046e87e9afso1822773b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718194211; x=1718799011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20S6/krIItg4OnfY+koAY3dczf7cy8e7FGQDb2dEfVU=;
 b=Aq1PtcndgTCKyRCV8k3gf91TtHvFEk9Xy6j1K27en9J1iiWYk5JguGE7MYhn1ZvUjB
 Dc8nGuMdAAlt8SEl/mGoMIDw4roZWjt89EuhyahqyD+yXS5gGR8b6vFnj6gXMmWXjqLP
 Px10VBwsq7EpkU/ABXFW/sSUpnNfYEZDHiZTAgg/aI4cjmfVOWBlMf2K1rmd50AnraE/
 h77uPCbPeUMEItY2fzcMNA963/omh0YPK/ruG5dZe3X/dMBlpcgIWZt/k3JWj1In5J54
 rSxo60b5ZCep8rs2PIACViG3MBdW1smEjvn7oeC7x+DI7tPDVUXkT6iOxpEOmyeIW67A
 giYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718194211; x=1718799011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=20S6/krIItg4OnfY+koAY3dczf7cy8e7FGQDb2dEfVU=;
 b=eFyhgBklhnk/2lzZtGc5Ab5wqJRZ5qP9Qb2/UcebWrSMqKhT8gynJf7NU+Y07hkPov
 AaheIFCvYIKJfFj0WfrvcnW7PDH45hzeSExk7FN6/53eU82NmdhPoaPbEecAIgXa/O+A
 Ebvh/aukozbEAxiFkSfymTbof5iXvVDAJ5iT+5IZaHFAplMyviT7wscsTS7mrXblbxGz
 kJmDVYp6AS0GiaKYCP6neYeD+4bzzBIzBNmZEsW5A9sTMR8TeqUmYLTPUhQ2t8q0n/fr
 mWbNpJa7ZqJT9zBfTIpmWX6I1CbTO8PeegkffUd4PK0M+C/oGSuW7ZJhB83tp6G8EXyC
 JW7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhe+CRfFysnzHamObT+mCvvKR0pD2vKx99PKXYlaZ9An46qWMmLeCtBiMhYHGM35wht+llopoO9CcXai9ZvPq0zXc3KAI=
X-Gm-Message-State: AOJu0Yx9KTN6NFNg4WyGHs+YtUPq2isDZnlipuB0FiFJS43o+TN9dPA6
 YA/cH3bxzK+jXKRaLBw+rUURORq3AZZfneWa0No1pkwe7DFpXlkxXHeXbfsDVvs=
X-Google-Smtp-Source: AGHT+IHTJC+LudTAJlP1P4dN7pAxjdJRT1rnUe169OeLWefHS8TTv6w+f1OMOze3tRgkRIS7g3piBQ==
X-Received: by 2002:a05:6a20:3d84:b0:1b5:d36a:5d6e with SMTP id
 adf61e73a8af0-1b8a9c2c914mr1742183637.43.1718194211103; 
 Wed, 12 Jun 2024 05:10:11 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f71790b089sm54644195ad.106.2024.06.12.05.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 05:10:10 -0700 (PDT)
Message-ID: <fe6b18e2-59e0-447d-a0a8-58b59d179be2@ventanamicro.com>
Date: Wed, 12 Jun 2024 09:10:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] riscv: QEMU RISC-V IOMMU Support
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, tjeznach@rivosinc.com,
 ajones@ventanamicro.com, frank.chang@sifive.com
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <4368759b-506c-410c-980c-4ab34de7f142@linux.alibaba.com>
 <19dbebe9-75c8-41cf-9e31-713e84904713@ventanamicro.com>
 <e98e7047-d13b-4443-94ea-981c4dd9e58c@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <e98e7047-d13b-4443-94ea-981c4dd9e58c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/12/24 4:50 AM, LIU Zhiwei wrote:
> 
> On 2024/6/11 18:13, Daniel Henrique Barboza wrote:
>> Hi Zhiwei,
>>
>> On 6/10/24 10:51 PM, LIU Zhiwei wrote:
>>> Hi Daniel,
>>>
>>> I want to know if we can use the IOMMU and IOPMP at the same time.
>>
>> AFAIK we can. They're not mutually exclusive since they offer protection
>> and isolation at different layers/stages.
> 
> OK. Thanks. I will dive into more details.
> 
> I see the IOMMU and IOPMP implementations on mail list both set IOMMU for PCI root bus.
> Is it right?

For now the riscv-iommu-pci device must be placed at a root bus for the
sake of simplicity. We'll want to lift this restriction in the future as
the support matures.


Thanks,

Daniel

> 
> Thanks,
> Zhiwei
> 
>>
>>
>>>
>>> The relationship between them is more similar to MMU and sPMP or to MMU and PMP?
>>
>> I'd say MMU and PMP since the IOMMU can isolate devices regardless of
>> s-mode context or not.
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>>
>>> Thanks,
>>> Zhiwei
>>>
>>> On 2024/5/24 1:39, Daniel Henrique Barboza wrote:
>>>> Hi,
>>>>
>>>> In this new version a lot of changes were made throughout all the code,
>>>> most notably on patch 3. Link for the previous version is [1].
>>>>
>>>> * How it was tested *
>>>>
>>>> This series was tested using an emulated QEMU RISC-V host booting a QEMU
>>>> KVM guest, passing through an emulated e1000 network card from the host
>>>> to the guest. I can provide more details (e.g. QEMU command lines) if
>>>> required, just let me know. For now this cover-letter is too much of an
>>>> essay as is.
>>>>
>>>> The Linux kernel used for tests can be found here:
>>>>
>>>> https://github.com/tjeznach/linux/tree/riscv_iommu_v6-rc3
>>>>
>>>> This is a newer version of the following work from Tomasz:
>>>>
>>>> https://lore.kernel.org/linux-riscv/cover.1715708679.git.tjeznach@rivosinc.com/
>>>> ("[PATCH v5 0/7] Linux RISC-V IOMMU Support")
>>>>
>>>> The v5 wasn't enough for the testing being done. v6-rc3 did the trick.
>>>>
>>>> Note that to test this work using riscv-iommu-pci we'll need to provide
>>>> the Rivos PCI ID in the command line. More details down below.
>>>>
>>>> * Highlights of this version *
>>>>
>>>> - patches removed from v2: platform driver (riscv-iommu-sys, former
>>>> patch 05) and the EDU changes (patches 14 and 15). The platform driver
>>>> will be sent later with a working example on the 'virt' machine,
>>>> either on a newer version of this series or via a follow-up series. We
>>>> already have a PoC on [2] created by Sunil. More tests are needed, so
>>>> it'll be left behind for now. The EDU changes will be sent in separate
>>>> after I finish the doc changes that Frank cited in v2.
>>>>
>>>> - patch 3 contains the bulk of changes made from v2. Please give special
>>>> attention to the following functions since this is entirely new code I
>>>> ended up adding:
>>>>   - riscv_iommu_report_fault()
>>>>   - riscv_iommu_validate_device_ctx()
>>>>   - riscv_iommu_update_ipsr()
>>>>    Aside from these helpers most of the changes made in this patch 3 were
>>>> punctual.
>>>>
>>>> - Red HAT PCI ID related changes. A new patch (4) that introduces a
>>>> generic RISC-V IOMMU PCI ID was added. This PCI ID was gracefully given
>>>> to us by Red Hat and Gerd Hoffman from their ID space. The
>>>> riscv-iommu-pci device now defaults to this PCI ID instead of Rivos PCI
>>>> ID. The device was changed slightly to allow vendor-id and device-id to
>>>> be set in the command-line, so it's now possible to use this reference
>>>> device as another RISC-V IOMMU PCI device to ease the burden of
>>>> testing/development.
>>>>
>>>>    To instantiate the riscv-iommu-pci device using the previous Rivos PCI
>>>> ID, use the following cmd line:
>>>>
>>>>    -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1
>>>>
>>>>    I'm using these options to test the series with the existing Linux RISC-V
>>>> IOMMU support that uses just a Rivos ID to identify the device.
>>>>
>>>>
>>>> Series based on alistair/riscv-to-apply.next. It's also applicable on
>>>> current QEMU master. It can also be fetched from:
>>>>
>>>> https://gitlab.com/danielhb/qemu/-/tree/riscv_iommu_v3
>>>>
>>>> Patches missing reviews/acks: 3, 5, 9, 10, 11.
>>>>
>>>> Changes from v2 [1]:
>>>> - patch 05 (hw/riscv: add riscv-iommu-sys platform device): dropped
>>>>    - will be reintroduced in a later review or as a follow-up series
>>>>
>>>> - patches 14 and 15: dropped
>>>>    - will be sent in separate
>>>>
>>>> - patches 2, 3, 4 and 5:
>>>>    - removed all 'Ziommu' references
>>>>
>>>> - patch 2:
>>>>    - added extra bits that patch 3 ended up using
>>>>
>>>> - patch 3:
>>>>    - fixed blank line at EOF in hw/riscv/trace.h
>>>>    - added a riscv_iommu_report_fault() helper to report faults. The helper checks if
>>>>      a given fault is eligible to be reported if DTF is 1
>>>>    - Use riscv_iommu_report_fault() in riscv_iommu_ctx() and riscv_iommu_translate()
>>>>      to avoid code repetition
>>>>    - added a riscv_iommu_validate_device_ctx() helper to validate the device context
>>>>      as specified in "Device configuration checks" section. This helper is being used
>>>>      in riscv_iommu_ctx_fetch()
>>>>    - added a new riscv_iommu_update_ipsr() helper to handle IPSR updates
>>>>      in riscv_iommu_mmio_write()
>>>>    - riscv_iommmu_msi_write() now reports a fault in all error paths
>>>>    - check for fctl.WSI before issuing a MSI interrupt in riscv_iommu_notify()
>>>>    - change riscv-iommu region name to 'riscv-iommu'
>>>>    - change address_space_init() name for PCI devices to 'name' instead of using TYPE_RISCV_IOMMU_PCI
>>>>    - changed riscv_iommu_mmio_ops min_access_size to 4
>>>>    - do not check for min and max sizes on riscv_iommu_mmio_write()
>>>>    - changed riscv_iommu_trap_ops  min_access_size to 4
>>>>    - removed IOMMU qemu_thread thread:
>>>>      - riscv_iommu_mmio_write() will now execute a riscv_iommu_process_fn by holding
>>>>        'core_lock'
>>>>    - init FSCR as zero explicitly
>>>>    - check for bus->iommu_opaque == NULL before calling pci_setup_iommu()
>>>>
>>>> - patch 4 (new):
>>>>    - add Red-Hat PCI RISC-V IOMMU ID
>>>>
>>>> - patch 5 (former 4):
>>>>    - create vendor-id and device-id properties
>>>>    - set Red-hat PCI RISC-V IOMMU ID as default ID
>>>>
>>>> - patch 8:
>>>>    - use IOMMU_NONE instead of '0' in relevant 'iot->perm = 0' instances
>>>>
>>>> - patch 9:
>>>>    - add s-stage and g-stage steps in riscv_iommu_validate_device_ctx()
>>>>    - removed 'gpa' boolean from riscv_iommu_spa_fetch()
>>>>    - 'en_s' is no longer used for early MSI address match
>>>>
>>>> - patch 10:
>>>>    - add ATS steps in riscv_iommu_validate_device_ctx()
>>>>    - check for 's->enable_ats' before adding RISCV_IOMMU_DC_TC_EN_ATS in device context
>>>>    - check for 's->enable_ats' before processing ATS commands in riscv_iommu_process_cq_tail()
>>>>    - remove ambiguous trace_riscv_iommu_ats() from riscv_iommu_translate()
>>>>
>>>> - patch 11:
>>>>    - removed unused bits
>>>>    - added RISCV_IOMMU_TR_REQ_CTL_NW and RISCV_IOMMU_TR_RESPONSE_S
>>>>      bits
>>>>    - set IOMMUTLBEntry 'perm' using RISCV_IOMMU_TR_REQ_CTL_NW in riscv_iommu_process_dbg()
>>>>    - clear RISCV_IOMMU_TR_RESPONSE_S in riscv_iommu_process_dbg(). Added a comment talking about the (lack of) superpage support
>>>> [1] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@ventanamicro.com/
>>>> [2] https://github.com/vlsunil/qemu/commits/acpi_rimt_poc_v1/
>>>>
>>>> Andrew Jones (1):
>>>>    hw/riscv/riscv-iommu: Add another irq for mrif notifications
>>>>
>>>> Daniel Henrique Barboza (3):
>>>>    pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
>>>>    test/qtest: add riscv-iommu-pci tests
>>>>    qtest/riscv-iommu-test: add init queues test
>>>>
>>>> Tomasz Jeznach (9):
>>>>    exec/memtxattr: add process identifier to the transaction attributes
>>>>    hw/riscv: add riscv-iommu-bits.h
>>>>    hw/riscv: add RISC-V IOMMU base emulation
>>>>    hw/riscv: add riscv-iommu-pci reference device
>>>>    hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
>>>>    hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>>>>    hw/riscv/riscv-iommu: add s-stage and g-stage support
>>>>    hw/riscv/riscv-iommu: add ATS support
>>>>    hw/riscv/riscv-iommu: add DBG support
>>>>
>>>>   docs/specs/pci-ids.rst           |    2 +
>>>>   hw/riscv/Kconfig                 |    4 +
>>>>   hw/riscv/meson.build             |    1 +
>>>>   hw/riscv/riscv-iommu-bits.h      |  416 ++++++
>>>>   hw/riscv/riscv-iommu-pci.c       |  177 +++
>>>>   hw/riscv/riscv-iommu.c           | 2283 ++++++++++++++++++++++++++++++
>>>>   hw/riscv/riscv-iommu.h           |  146 ++
>>>>   hw/riscv/trace-events            |   15 +
>>>>   hw/riscv/trace.h                 |    1 +
>>>>   hw/riscv/virt.c                  |   33 +-
>>>>   include/exec/memattrs.h          |    5 +
>>>>   include/hw/pci/pci.h             |    1 +
>>>>   include/hw/riscv/iommu.h         |   36 +
>>>>   meson.build                      |    1 +
>>>>   tests/qtest/libqos/meson.build   |    4 +
>>>>   tests/qtest/libqos/riscv-iommu.c |   76 +
>>>>   tests/qtest/libqos/riscv-iommu.h |  100 ++
>>>>   tests/qtest/meson.build          |    1 +
>>>>   tests/qtest/riscv-iommu-test.c   |  234 +++
>>>>   19 files changed, 3535 insertions(+), 1 deletion(-)
>>>>   create mode 100644 hw/riscv/riscv-iommu-bits.h
>>>>   create mode 100644 hw/riscv/riscv-iommu-pci.c
>>>>   create mode 100644 hw/riscv/riscv-iommu.c
>>>>   create mode 100644 hw/riscv/riscv-iommu.h
>>>>   create mode 100644 hw/riscv/trace-events
>>>>   create mode 100644 hw/riscv/trace.h
>>>>   create mode 100644 include/hw/riscv/iommu.h
>>>>   create mode 100644 tests/qtest/libqos/riscv-iommu.c
>>>>   create mode 100644 tests/qtest/libqos/riscv-iommu.h
>>>>   create mode 100644 tests/qtest/riscv-iommu-test.c
>>>>

