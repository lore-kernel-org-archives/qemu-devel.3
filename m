Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93789C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 19:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGkVe-00047a-Cx; Mon, 10 Jun 2024 15:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sGkVc-00047E-Bt
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 15:16:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sGkVX-0000ON-Ts
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 15:16:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7041a7d4beeso2548263b3a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718047000; x=1718651800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fdHshu58sSOqx19B9GmmE1iI/o1+B/zqGYOCmubyuBU=;
 b=SXFzHvSgA/T+c+p1OXRO4Z2ssDdzcQ46lTN/RhjnXYzEjEAP1fyOulvLXx3xf7LGbV
 te3I/5zHdIN9UDTJEz8TLRdzs1KdcED/dryuyI7OOvUIxxYddnMw5FaheYRXz+xYuAM5
 2Kffl5D3/KsjmxD4JXblS+d3dXZ6UXRKc4Y6A6g8BPAch7Mohy3dFuJpy9PrwODZzFqW
 CPp3XBxgRJwXP+Xa1kMerYCWLLO2RESVKfGXxaIDWTGXv+o0YeouPZVsqlOZbrAk1Baa
 Ohqlofp+NVnvv5txxBpKN0wOyv1F+Dlktifi4re2IXCa+LuiOv+1W3jFEIn6ev8SELsr
 jNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718047000; x=1718651800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdHshu58sSOqx19B9GmmE1iI/o1+B/zqGYOCmubyuBU=;
 b=nI2BcVFd6kyeTW0N13RXg4hUzN1yiI0lvSTudzwKQrZ4J9LdMSb40H1L6JL2jnN4p5
 mN4Y1HqlwoYus/YWyRhlajPbR0tEF5/QVmueqWU0wD1af7H6maies7+64Kn3U0garOzr
 eS9hvDE+J6SN5vxYiqyRrIwUOOCE4GphRKzc0O1We0w+1sm/6NZuHHiCnF/vXA5l9rQi
 9amq60FGAOrAy5FxOca0V+OXMYkQyzvY+NtbBjFG9vzru3DUtKqZGe85bMDvg73Y1Vxq
 f0E6sLBcfDfTxtM0btgr4Z4MxkmnYfcs3qoTp0pBPEwkL6VWjGLMsuYY5+CtAAKle+6O
 j/tw==
X-Gm-Message-State: AOJu0Yy4KsjCsFFCQpx05kENaKZuMPH3X1oRRv94dDNnLAZChJwVlnDR
 ANsdbTIyTFpuYW0F7NTn+9CNBUzMXmTJRG0NxnTl88vrqXILxwyAzF3iF/DAqpwGqMV65bK4MM5
 U
X-Google-Smtp-Source: AGHT+IE/GtMpg2t6zvzhct5t2DksZMtH6qGhwTh4ewPjKzBVpjV7WEvp6Lnt2+EfDq4gU4lF3kZVwQ==
X-Received: by 2002:a05:6a20:7f8c:b0:1af:fff9:30dd with SMTP id
 adf61e73a8af0-1b2f9bd93c6mr11592899637.35.1718046999958; 
 Mon, 10 Jun 2024 12:16:39 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:251d:4eb6:84c9:21f7:86f2?
 ([2804:7f0:bcc0:251d:4eb6:84c9:21f7:86f2])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6de2678c69bsm7154059a12.71.2024.06.10.12.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 12:16:39 -0700 (PDT)
Message-ID: <53fc947b-8301-44c6-8bf0-57e6a705ba64@ventanamicro.com>
Date: Mon, 10 Jun 2024 16:16:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] riscv: QEMU RISC-V IOMMU Support
To: Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, tjeznach@rivosinc.com, frank.chang@sifive.com
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <CAKmqyKNd2BL-B12RnXu6ZRC0ApqgFXeZSTxggSxJSnbvcN=aSA@mail.gmail.com>
 <5ADE1DEF-D40E-4199-8646-5C539249796C@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <5ADE1DEF-D40E-4199-8646-5C539249796C@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 6/10/24 3:32 PM, Andrew Jones wrote:
> On June 10, 2024 2:34:58 AM GMT+02:00, Alistair Francis <alistair23@gmail.com> wrote:
>> On Fri, May 24, 2024 at 3:43 AM Daniel Henrique Barboza
>> <dbarboza@ventanamicro.com> wrote:
>>>
>>> Hi,
>>>
>>> In this new version a lot of changes were made throughout all the code,
>>> most notably on patch 3. Link for the previous version is [1].
>>>
>>> * How it was tested *
>>>
>>> This series was tested using an emulated QEMU RISC-V host booting a QEMU
>>> KVM guest, passing through an emulated e1000 network card from the host
>>> to the guest. I can provide more details (e.g. QEMU command lines) if
>>> required, just let me know. For now this cover-letter is too much of an
>>> essay as is.
>>
>> It would probably be helpful to document these somewhere, so others
>> can use them as a starting point for running this
>>
> 
> I've written up a testing procedure which I shared internally with Daniel. I'll sanitize it and post it somewhere public.
>

I can also add a QEMU docs under docs/system/riscv, both as a
subsection of virt.rst and perhaps a new doc that describes the
devices itself (riscv-iommu-pci and later on riscv-iommu-sys).


Thanks,


Daniel
  
> Thanks,
> drew
> 
>> Alistair
>>
>>>
>>> The Linux kernel used for tests can be found here:
>>>
>>> https://github.com/tjeznach/linux/tree/riscv_iommu_v6-rc3
>>>
>>> This is a newer version of the following work from Tomasz:
>>>
>>> https://lore.kernel.org/linux-riscv/cover.1715708679.git.tjeznach@rivosinc.com/
>>> ("[PATCH v5 0/7] Linux RISC-V IOMMU Support")
>>>
>>> The v5 wasn't enough for the testing being done. v6-rc3 did the trick.
>>>
>>> Note that to test this work using riscv-iommu-pci we'll need to provide
>>> the Rivos PCI ID in the command line. More details down below.
>>>
>>> * Highlights of this version *
>>>
>>> - patches removed from v2: platform driver (riscv-iommu-sys, former
>>> patch 05) and the EDU changes (patches 14 and 15). The platform driver
>>> will be sent later with a working example on the 'virt' machine,
>>> either on a newer version of this series or via a follow-up series. We
>>> already have a PoC on [2] created by Sunil. More tests are needed, so
>>> it'll be left behind for now. The EDU changes will be sent in separate
>>> after I finish the doc changes that Frank cited in v2.
>>>
>>> - patch 3 contains the bulk of changes made from v2. Please give special
>>> attention to the following functions since this is entirely new code I
>>> ended up adding:
>>>
>>>   - riscv_iommu_report_fault()
>>>   - riscv_iommu_validate_device_ctx()
>>>   - riscv_iommu_update_ipsr()
>>>
>>>    Aside from these helpers most of the changes made in this patch 3 were
>>> punctual.
>>>
>>> - Red HAT PCI ID related changes. A new patch (4) that introduces a
>>> generic RISC-V IOMMU PCI ID was added. This PCI ID was gracefully given
>>> to us by Red Hat and Gerd Hoffman from their ID space. The
>>> riscv-iommu-pci device now defaults to this PCI ID instead of Rivos PCI
>>> ID. The device was changed slightly to allow vendor-id and device-id to
>>> be set in the command-line, so it's now possible to use this reference
>>> device as another RISC-V IOMMU PCI device to ease the burden of
>>> testing/development.
>>>
>>>    To instantiate the riscv-iommu-pci device using the previous Rivos PCI
>>> ID, use the following cmd line:
>>>
>>>    -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1
>>>
>>>    I'm using these options to test the series with the existing Linux RISC-V
>>> IOMMU support that uses just a Rivos ID to identify the device.
>>>
>>>
>>> Series based on alistair/riscv-to-apply.next. It's also applicable on
>>> current QEMU master. It can also be fetched from:
>>>
>>> https://gitlab.com/danielhb/qemu/-/tree/riscv_iommu_v3
>>>
>>>
>>> Patches missing reviews/acks: 3, 5, 9, 10, 11.
>>>
>>> Changes from v2 [1]:
>>> - patch 05 (hw/riscv: add riscv-iommu-sys platform device): dropped
>>>    - will be reintroduced in a later review or as a follow-up series
>>>
>>> - patches 14 and 15: dropped
>>>    - will be sent in separate
>>>
>>> - patches 2, 3, 4 and 5:
>>>    - removed all 'Ziommu' references
>>>
>>> - patch 2:
>>>    - added extra bits that patch 3 ended up using
>>>
>>> - patch 3:
>>>    - fixed blank line at EOF in hw/riscv/trace.h
>>>    - added a riscv_iommu_report_fault() helper to report faults. The helper checks if
>>>      a given fault is eligible to be reported if DTF is 1
>>>    - Use riscv_iommu_report_fault() in riscv_iommu_ctx() and riscv_iommu_translate()
>>>      to avoid code repetition
>>>    - added a riscv_iommu_validate_device_ctx() helper to validate the device context
>>>      as specified in "Device configuration checks" section. This helper is being used
>>>      in riscv_iommu_ctx_fetch()
>>>    - added a new riscv_iommu_update_ipsr() helper to handle IPSR updates
>>>      in riscv_iommu_mmio_write()
>>>    - riscv_iommmu_msi_write() now reports a fault in all error paths
>>>    - check for fctl.WSI before issuing a MSI interrupt in riscv_iommu_notify()
>>>    - change riscv-iommu region name to 'riscv-iommu'
>>>    - change address_space_init() name for PCI devices to 'name' instead of using TYPE_RISCV_IOMMU_PCI
>>>    - changed riscv_iommu_mmio_ops min_access_size to 4
>>>    - do not check for min and max sizes on riscv_iommu_mmio_write()
>>>    - changed riscv_iommu_trap_ops  min_access_size to 4
>>>    - removed IOMMU qemu_thread thread:
>>>      - riscv_iommu_mmio_write() will now execute a riscv_iommu_process_fn by holding
>>>        'core_lock'
>>>    - init FSCR as zero explicitly
>>>    - check for bus->iommu_opaque == NULL before calling pci_setup_iommu()
>>>
>>> - patch 4 (new):
>>>    - add Red-Hat PCI RISC-V IOMMU ID
>>>
>>> - patch 5 (former 4):
>>>    - create vendor-id and device-id properties
>>>    - set Red-hat PCI RISC-V IOMMU ID as default ID
>>>
>>> - patch 8:
>>>    - use IOMMU_NONE instead of '0' in relevant 'iot->perm = 0' instances
>>>
>>> - patch 9:
>>>    - add s-stage and g-stage steps in riscv_iommu_validate_device_ctx()
>>>    - removed 'gpa' boolean from riscv_iommu_spa_fetch()
>>>    - 'en_s' is no longer used for early MSI address match
>>>
>>> - patch 10:
>>>    - add ATS steps in riscv_iommu_validate_device_ctx()
>>>    - check for 's->enable_ats' before adding RISCV_IOMMU_DC_TC_EN_ATS in device context
>>>    - check for 's->enable_ats' before processing ATS commands in riscv_iommu_process_cq_tail()
>>>    - remove ambiguous trace_riscv_iommu_ats() from riscv_iommu_translate()
>>>
>>> - patch 11:
>>>    - removed unused bits
>>>    - added RISCV_IOMMU_TR_REQ_CTL_NW and RISCV_IOMMU_TR_RESPONSE_S
>>>      bits
>>>    - set IOMMUTLBEntry 'perm' using RISCV_IOMMU_TR_REQ_CTL_NW in riscv_iommu_process_dbg()
>>>    - clear RISCV_IOMMU_TR_RESPONSE_S in riscv_iommu_process_dbg(). Added a comment talking about the (lack of) superpage support
>>>
>>> [1] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@ventanamicro.com/
>>> [2] https://github.com/vlsunil/qemu/commits/acpi_rimt_poc_v1/
>>>
>>> Andrew Jones (1):
>>>    hw/riscv/riscv-iommu: Add another irq for mrif notifications
>>>
>>> Daniel Henrique Barboza (3):
>>>    pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
>>>    test/qtest: add riscv-iommu-pci tests
>>>    qtest/riscv-iommu-test: add init queues test
>>>
>>> Tomasz Jeznach (9):
>>>    exec/memtxattr: add process identifier to the transaction attributes
>>>    hw/riscv: add riscv-iommu-bits.h
>>>    hw/riscv: add RISC-V IOMMU base emulation
>>>    hw/riscv: add riscv-iommu-pci reference device
>>>    hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
>>>    hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>>>    hw/riscv/riscv-iommu: add s-stage and g-stage support
>>>    hw/riscv/riscv-iommu: add ATS support
>>>    hw/riscv/riscv-iommu: add DBG support
>>>
>>>   docs/specs/pci-ids.rst           |    2 +
>>>   hw/riscv/Kconfig                 |    4 +
>>>   hw/riscv/meson.build             |    1 +
>>>   hw/riscv/riscv-iommu-bits.h      |  416 ++++++
>>>   hw/riscv/riscv-iommu-pci.c       |  177 +++
>>>   hw/riscv/riscv-iommu.c           | 2283 ++++++++++++++++++++++++++++++
>>>   hw/riscv/riscv-iommu.h           |  146 ++
>>>   hw/riscv/trace-events            |   15 +
>>>   hw/riscv/trace.h                 |    1 +
>>>   hw/riscv/virt.c                  |   33 +-
>>>   include/exec/memattrs.h          |    5 +
>>>   include/hw/pci/pci.h             |    1 +
>>>   include/hw/riscv/iommu.h         |   36 +
>>>   meson.build                      |    1 +
>>>   tests/qtest/libqos/meson.build   |    4 +
>>>   tests/qtest/libqos/riscv-iommu.c |   76 +
>>>   tests/qtest/libqos/riscv-iommu.h |  100 ++
>>>   tests/qtest/meson.build          |    1 +
>>>   tests/qtest/riscv-iommu-test.c   |  234 +++
>>>   19 files changed, 3535 insertions(+), 1 deletion(-)
>>>   create mode 100644 hw/riscv/riscv-iommu-bits.h
>>>   create mode 100644 hw/riscv/riscv-iommu-pci.c
>>>   create mode 100644 hw/riscv/riscv-iommu.c
>>>   create mode 100644 hw/riscv/riscv-iommu.h
>>>   create mode 100644 hw/riscv/trace-events
>>>   create mode 100644 hw/riscv/trace.h
>>>   create mode 100644 include/hw/riscv/iommu.h
>>>   create mode 100644 tests/qtest/libqos/riscv-iommu.c
>>>   create mode 100644 tests/qtest/libqos/riscv-iommu.h
>>>   create mode 100644 tests/qtest/riscv-iommu-test.c
>>>
>>> --
>>> 2.44.0
>>>
>>>
> 

