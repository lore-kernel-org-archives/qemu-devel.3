Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77548C982C7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgky0-0001xA-FC; Fri, 16 Jan 2026 09:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vgkwy-0001Wg-Ei; Fri, 16 Jan 2026 09:37:22 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vgkwu-00039P-4N; Fri, 16 Jan 2026 09:37:18 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnq5cUTWppg+7hBQ--.1356S2;
 Fri, 16 Jan 2026 22:37:08 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.235.43])
 by mail (Coremail) with SMTP id AQAAfwDHHuwSTWpp0DoUAA--.21322S2;
 Fri, 16 Jan 2026 22:37:06 +0800 (CST)
Message-ID: <05ffd4cb-5eb6-4592-bdf1-7104a781d38d@phytium.com.cn>
Date: Fri, 16 Jan 2026 22:37:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 3/7] hw/misc: Introduce iommu-testdev for bare-metal
 IOMMU testing
To: eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-4-tangtao1634@phytium.com.cn>
 <75e5bd17-c319-419b-a977-1e9d529a710f@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <75e5bd17-c319-419b-a977-1e9d529a710f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHHuwSTWpp0DoUAA--.21322S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQARBWlpSgQHHAABsB
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3uF45Cr15Kw4DXF1xZrykAFb_yoWkZr4Upa
 43AFsFyr4UtF1rJw1Ivr48GF12vrs5ta4UAr15Ka4Fyws0yF1xJryUK3409ryDJrW8Z3Wx
 ZrWjvrnxX3Z8ZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Eric,

On 2026/1/15 20:59, Eric Auger wrote:
> Hi Tao,
>
> On 12/24/25 4:46 AM, Tao Tang wrote:
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +Status
>> +------
>> +* Location: ``hw/misc/iommu-testdev.c``
>> +* Header: ``include/hw/misc/iommu-testdev.h``
>> +* Build guard: ``CONFIG_IOMMU_TESTDEV``
>> +
>> +Device Interface
>> +----------------
>> +The device exposes a single PCI BAR0 with 32bit MMIO registers:
>> +
>> +* ``ITD_REG_DMA_TRIGGERING`` (0x00): Reading triggers DMA execution
>> +* ``ITD_REG_DMA_GVA_LO`` (0x04): GVA bits [31:0]
>> +* ``ITD_REG_DMA_GVA_HI`` (0x08): GVA bits [63:32]
>> +* ``ITD_REG_DMA_LEN`` (0x0C): DMA transfer length
>> +* ``ITD_REG_DMA_RESULT`` (0x10): DMA operation result (0=success)
>> +* ``ITD_REG_DMA_DBELL`` (0x14): Write 1 to arm DMA
> I know you provided some explanations to be me earlier about separation
> between "arming" and "triggering" but I don't find info in the doc about
> what arming practically does and what kind of checks it can enable
> compared to the actual trigger. I am not asking for removing it but
> maybe document what it aims at.


Thanks for the feedback. I’ll document the intent in the doc.

Today arming only marks the request as armed and sets BUSY; it does not 
latch parameters or run checks, so its current effect is intentionally 
light. It’s still useful as an explicit gate so qtests can distinguish 
NOT_ARMED vs trigger-time failures, and it keeps room for future 
extensions (async execution or parameter latching).

>> +* ``ITD_REG_DMA_ATTRS`` (0x18): DMA attributes which shadow MemTxAttrs format:
>> +
>> +  - bit[0]: secure (1=Secure, 0=Non-Secure)
>> +  - bits[2:1]: address space (0=Non-Secure, 1=Secure)
> I was confused by the diff between those 2 fields. If my understanding
> is correct they should equal today, until we got some further RME stuff?
> Correct?
>
> In MemTxAttrs it is said:
>       unsigned int secure:1;
>      /*
>       * ARM: ArmSecuritySpace.  This partially overlaps secure, but it is
>       * easier to have both fields to assist code that does not understand
>       * ARMv9 RME, or no specific knowledge of ARM at all (e.g. pflash).
>       */
>      unsigned int space:2;


Yes — today they end up equal in value. But they carry different 
semantics: the same numeric value is interpreted differently (e.g. 
space==1 means Non-secure, while secure==0 also means Non-secure). I 
added both fields to predefine the upcoming split needed for RME, 
without implying any RME support in the SMMU yet.

BTW  I'll change `bits[2:1]: address space` to be `bits[2:1]: 
ArmSecuritySpace` to match the ARM spec as address space is not 
particularly accurate.

>> +    Only these MemTxAttrs fields (``secure`` and ``space``) are consumed today;
>> +    other bits are reserved but can be wired up easily if future tests need
>> +    to pass extra attributes.
>> +
>> +Translation Setup Workflow
>> +--------------------------
>> +``iommu-testdev`` never builds SMMU/AMD-Vi/RISC-V IOMMU structures on its own.
>> +Architecture-specific construction lives entirely in qtest/libqos helpers.
>> +Those helpers populate guest memory with page tables/architecture-specific
>> +structures and program the emulated IOMMU registers directly. See the
>> +``qsmmu_setup_and_enable_translation()`` function in
>> +``tests/qtest/libqos/qos-smmuv3.c`` for an example of how SMMUv3 translation
>> +is set up for this device, which will be introduced in the next commit.
> nit: this is rather a commit description comment.


I'll move it into commit message.

>> +
>> +DMA Operation Flow
>> +------------------
>> +The flow would be split into these steps, mainly for timing control and
>> +debuggability: qtests can easily exercise and assert distinct paths
>> +(NOT_ARMED, BAD_LEN, TX/RD failures, mismatch) instead of having all side
>> +effects hidden behind a single step:
>> +1. Test programs IOMMU translation tables
>> +2. Test configures DMA address (GVA_LO/HI), length, and attributes
>> +3. Test writes 1 to DMA_DBELL to arm the operation
> so what does it? is it possible to arm if a transaction is already pending?


Arming just sets the armed gate and BUSY; it doesn’t run checks or start 
DMA. Re‑arming while already armed is idempotent: it keeps BUSY and does 
not queue a second request.

>> +4. Test reads DMA_TRIGGERING to execute DMA
>> +5. Test polls DMA_RESULT:
>> +
>> +   - 0x00000000: Success
>> +   - 0xFFFFFFFE: Busy (still in progress)
>> +   - 0xDEAD000X: Various error codes
>> +
>> +The device performs a write-then-read sequence using a known pattern
>> +(0x12345678) and verifies data integrity automatically.
>> +
>> +Running the qtest
>> +-----------------
>> +The SMMUv3 test suite uses this device and covers multiple translation modes::
>> +
>> +    cd build-debug
>> +    QTEST_QEMU_BINARY=./qemu-system-aarch64 \\
>> +        ./tests/qtest/iommu-smmuv3-test --tap -k
>> +
>> +This test suite exercises:
>> +
>> +* Stage 1 only translation
>> +* Stage 2 only translation
>> +* Nested (Stage 1 + Stage 2) translation
>> +
>> +Instantiation
>> +-------------
>> +The device is not wired into any board by default. Tests instantiate it
>> +via QEMU command line::
>> +
>> +    -device iommu-testdev
>> +
>> +For ARM platforms with SMMUv3::
>> +
>> +    -M virt,iommu=smmuv3 -device iommu-testdev
>> +
>> +The device will be placed behind the IOMMU automatically.
> I guess the device is added on pci.0. so it works by default with
> machine wide instantiation but not necessarily with arm-smmuv3 device
> which can plugged downstream to a pxb. Maybe reword to avoid confusion.


I’ll reword it in next version.

>> +
>> +Limitations
>> +-----------
>> +* No realistic PCIe enumeration, MSI/MSI-X, or interrupt handling
>> +* No ATS/PRI support
>> +* No actual device functionality beyond DMA test pattern
>> +* Test-only; not suitable for production or machine realism
>> +* Address space support (Secure/Root/Realm) is architecture-dependent
>> +
>> +See also
>> +--------
>> +* ``tests/qtest/iommu-smmuv3-test.c`` — SMMUv3 test suite
>> +* ``tests/qtest/libqos/qos-smmuv3.{c,h}`` — SMMUv3 test library
>> +* SMMUv3 emulation: ``hw/arm/smmu*``
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index fccd735c24..b5f6fdbd9c 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -25,6 +25,11 @@ config PCI_TESTDEV
>>       default y if TEST_DEVICES
>>       depends on PCI
>>   
>> +config IOMMU_TESTDEV
>> +    bool
>> +    default y if TEST_DEVICES
>> +    depends on PCI
>> +
>>   config EDU
>>       bool
>>       default y if TEST_DEVICES
>> diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
>> new file mode 100644
>> index 0000000000..2cc1176aa6
>> --- /dev/null
>> +++ b/hw/misc/iommu-testdev.c
>> @@ -0,0 +1,271 @@
>> +/*
>> + * A test device for IOMMU
>> + *
>> + * Copyright (c) 2025 Phytium Technology
> nit 26


I’ll fix the copyright formatting, including other files.

>> + *
>> + * Author:
>> + *  Tao Tang <tangtao1634@phytium.com.cn>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/address-spaces.h"
>> +#include "trace.h"
>> +#include "hw/pci/pci_device.h"
>> +#include "hw/qdev-properties.h"
>> +#include "qom/object.h"
>> +#include "hw/misc/iommu-testdev.h"
>> +
>> +#define TYPE_IOMMU_TESTDEV "iommu-testdev"
>> +OBJECT_DECLARE_SIMPLE_TYPE(IOMMUTestDevState, IOMMU_TESTDEV)
>> +
>> +struct IOMMUTestDevState {
>> +    PCIDevice parent_obj;
>> +    MemoryRegion bar0;
>> +    uint64_t dma_vaddr;
>> +    uint32_t dma_len;
>> +    uint32_t dma_result;
>> +    bool dma_pending;
>> +
>> +    AddressSpace *dma_as;   /* IOMMU-mediated DMA AS for this device */
>> +    uint32_t dma_attrs_cfg; /* bit0 secure, bits[2:1] space, bit3 unspecified */
>> +};
>> +
>> +static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
>> +{
>> +    uint32_t expected_val, actual_val;
>> +    g_autofree uint8_t *write_buf = NULL;
>> +    g_autofree uint8_t *read_buf = NULL;
>> +    MemTxResult write_res, read_res;
>> +    MemTxAttrs attrs;
>> +    AddressSpace *as;
>> +
>> +    if (!s->dma_pending) {
>> +        s->dma_result = ITD_DMA_ERR_NOT_ARMED;
>> +        trace_iommu_testdev_dma_result(s->dma_result);
>> +        return;
>> +    }
>> +    trace_iommu_testdev_dma_start();
>> +
>> +    s->dma_pending = false;
> strange you reset pending before the very access. if I understand
> correctly your dma_pending means dma_armed though


You’re right — pending was meant to mean ‘armed’. I’ve changed it so the 
flag stays set until the DMA finishes (cleared only at the end), and 
renamed it to dma_armed for clarity.

>> +
>> +    if (!s->dma_len) {
>> +        s->dma_result = ITD_DMA_ERR_BAD_LEN;
>> +        return;
>> +    }
>> +
>> +    write_buf = g_malloc(s->dma_len);
>> +    read_buf = g_malloc(s->dma_len);
>> +
>> +    /* Initialize MemTxAttrs from generic register */
>> +    attrs.secure = ITD_ATTRS_GET_SECURE(s->dma_attrs_cfg);
>> +
>> +    /* The 'space' field in MemTxAttrs is ARM-specific. */
>> +    attrs.space = ITD_ATTRS_GET_SPACE(s->dma_attrs_cfg);
> maybe check they both secure and space are somehow consistent?


I will check the consistency between space and secure.

>> +
>> +    as = s->dma_as;
>> +
>> +    /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
>> +    trace_iommu_testdev_dma_write(s->dma_vaddr, s->dma_len);
>> +
>> +    for (int i = 0; i < s->dma_len; i++) {
>> +        /* Data is written in little-endian order */
>> +        write_buf[i] = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
>> +    }
>> +    write_res = dma_memory_write(as, s->dma_vaddr, write_buf, s->dma_len, attrs);
>> +
>> +    if (write_res != MEMTX_OK) {
>> +        s->dma_result = ITD_DMA_ERR_TX_FAIL;
>> +        trace_iommu_testdev_dma_result(s->dma_result);
>> +        return;
>> +    }
>> +
>> +    /* Step 2: Read back from the same DMA address */
>> +    trace_iommu_testdev_dma_read(s->dma_vaddr, s->dma_len);
>> +
>> +    read_res = dma_memory_read(as, s->dma_vaddr, read_buf, s->dma_len, attrs);
> This assumes the IOMMU translation is correct. If it is bad in both
> directions, you may read the same value but does not necessarily means
> the translated addr is correct.
> Wouldn't it be better to read the mem at expected GPA without going
> through the IOMMU?


Sure. I just tried to pass GPA into iommu-testdev and address_space_read 
from GPA and then validated the result. It works well and I'll add this 
logic in V9. Thanks for your suggestion.

>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +static void iommu_testdev_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>> +                                     unsigned size)
>> +{
>> +    IOMMUTestDevState *s = opaque;
>> +    uint32_t data = val;
>> +
>> +    trace_iommu_testdev_mmio_write(addr, val, size);
>> +
>> +    switch (addr) {
>> +    case ITD_REG_DMA_GVA_LO:
>> +        s->dma_vaddr = (s->dma_vaddr & ~0xffffffffull) | data;
>> +        break;
>> +    case ITD_REG_DMA_GVA_HI:
>> +        s->dma_vaddr = (s->dma_vaddr & 0xffffffffull) |
>> +                       ((uint64_t)data << 32);
>> +        break;
>> +    case ITD_REG_DMA_LEN:
>> +        s->dma_len = data;
>> +        break;
>> +    case ITD_REG_DMA_RESULT:
>> +        s->dma_result = data;
>> +        break;
>> +    case ITD_REG_DMA_DBELL:
>> +        if (data & ITD_DMA_DBELL_ARM) {
>> +            /* Arm the DMA operation */
>> +            s->dma_pending = true;
> dma_armed?

I'll change it as mentioned earlier.



Thank you again for your thorough and detailed code review.

Best regards,

Tao



