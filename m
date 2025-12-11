Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D69D3E79A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTb5d-0002pX-2R; Thu, 11 Dec 2025 02:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTb5a-0002pF-Mp; Thu, 11 Dec 2025 02:27:50 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTb5X-00079r-LR; Thu, 11 Dec 2025 02:27:50 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXHZlecjppECFSAw--.337S2;
 Thu, 11 Dec 2025 15:27:26 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX7epYcjppfSoLAA--.6702S2;
 Thu, 11 Dec 2025 15:27:20 +0800 (CST)
Message-ID: <85e5dc36-8cdf-4ee9-b482-882dc7a31aca@phytium.com.cn>
Date: Thu, 11 Dec 2025 15:27:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 2/4] hw/misc: Introduce iommu-testdev for
 bare-metal IOMMU testing
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
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-3-tangtao1634@phytium.com.cn>
 <829b3e14-92e8-4d22-bb02-c6e7322d9856@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <829b3e14-92e8-4d22-bb02-c6e7322d9856@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX7epYcjppfSoLAA--.6702S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWk4gq0InAAGso
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3GryrCFWrWrWDuw4UuryfZwb_yoWftFy8pF
 98GaySkF48JF1xCw1Sqw48CFy3GFsYy3WUCr1rKw1Fgr9Iyry8Jr1jk340k3srJrW8Z3Wx
 Zw40qFyUuw45ZrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Eric,

On 2025/12/11 02:35, Eric Auger wrote:
>
> On 11/26/25 4:45 PM, Tao Tang wrote:
>> Add a minimal PCI test device designed to exercise IOMMU translation
>> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
>> provides MMIO registers to configure and trigger DMA operations with
>> controllable attributes (security state, address space), enabling
>> deterministic IOMMU testing.
>>
>> Key features:
>> - Bare-metal IOMMU testing via simple MMIO interface
>> - Configurable DMA attributes for security states and address spaces
>> - Write-then-read verification pattern with automatic result checking
>>
>> The device performs a deterministic DMA test pattern: write a known
>> value (0x88888888) to a configured IOVA, read it back, and verify data
>> integrity. Results are reported through a dedicated result register,
>> eliminating the need for complex interrupt handling or driver
>> infrastructure in tests.
>>
>> This is purely a test device and not intended for production use or
>> machine realism. It complements existing test infrastructure like
>> pci-testdev but focuses specifically on IOMMU translation path
>> validation.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   docs/specs/index.rst            |   1 +
>>   docs/specs/iommu-testdev.rst    | 109 +++++++++++++
>>   hw/misc/Kconfig                 |   5 +
>>   hw/misc/iommu-testdev.c         | 278 ++++++++++++++++++++++++++++++++
>>   hw/misc/meson.build             |   1 +
>>   hw/misc/trace-events            |  10 ++
>>   include/hw/misc/iommu-testdev.h |  70 ++++++++
>>   7 files changed, 474 insertions(+)
>>   create mode 100644 docs/specs/iommu-testdev.rst
>>   create mode 100644 hw/misc/iommu-testdev.c
>>   create mode 100644 include/hw/misc/iommu-testdev.h
>>
>> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
>> index f19d73c9f6..1fc7fae6bb 100644
>> --- a/docs/specs/index.rst
>> +++ b/docs/specs/index.rst
>> @@ -39,3 +39,4 @@ guest hardware that is specific to QEMU.
>>      riscv-iommu
>>      riscv-aia
>>      aspeed-intc
>> +   iommu-testdev
>> \ No newline at end of file
>> diff --git a/docs/specs/iommu-testdev.rst b/docs/specs/iommu-testdev.rst
>> new file mode 100644
>> index 0000000000..fdc7f2ee89
>> --- /dev/null
>> +++ b/docs/specs/iommu-testdev.rst
>> @@ -0,0 +1,109 @@
>> +iommu-testdev — IOMMU test device for bare-metal testing
>> +=========================================================
>> +
>> +Overview
>> +--------
>> +``iommu-testdev`` is a minimal, test-only PCI device designed to exercise
>> +IOMMU translation (such as ARM SMMUv3) without requiring firmware or a guest
>> +OS. Tests can populate IOMMU translation tables with known values and trigger
>> +DMA operations that flow through the IOMMU translation path. It is **not** a
>> +faithful PCIe endpoint and must be considered a QEMU-internal test vehicle.
>> +
>> +Key Features
>> +------------
>> +* **Bare-metal IOMMU testing**: No guest kernel or firmware required
>> +* **Configurable DMA attributes**: Supports address space  configuration via
> double space


Thanks for catching it.

>> +  MMIO registers
>> +* **Deterministic verification**: Write-then-read DMA pattern with automatic
>> +  result checking
>> +
>> +Status
>> +------
>> +* Location: ``hw/misc/iommu-testdev.c``
>> +* Header: ``include/hw/misc/iommu-testdev.h``
>> +* Build guard: ``CONFIG_IOMMU_TESTDEV``
>> +
>> +Device Interface
>> +----------------
>> +The device exposes a single PCI BAR0 with MMIO registers:
> all those regs are 32b?


Yes. All registers are 32-bit, little-endian, and only support 4-byte 
accesses, as enforced by the MemoryRegionOps valid range. I’ll make this 
explicit in  the docs and in the register table to avoid any ambiguity.

>> +
>> +* ``ITD_REG_DMA_TRIGGERING`` (0x00): Reading triggers DMA execution
>> +* ``ITD_REG_DMA_GVA_LO`` (0x04): IOVA/GVA bits [31:0]
>> +* ``ITD_REG_DMA_GVA_HI`` (0x08): IOVA/GVA bits [63:32]
>> +* ``ITD_REG_DMA_LEN`` (0x0C): DMA transfer length
>> +* ``ITD_REG_DMA_RESULT`` (0x10): DMA operation result (0=success)
>> +* ``ITD_REG_DMA_DBELL`` (0x14): Write 1 to arm DMA
> can you elaborate on this DMA_DBELL? It is not crystal clear to me.


The idea is to model a tiny, explicit DMA state machine instead of 
having a single MMIO operation that implicitly does “configure + start + 
complete”.

In this model:

   * DMA_DBELL is just an “arm / doorbell” register.
   * DMA_TRIGGERING is the “consume / execute” action.
   * DMA_RESULT exposes the state/outcome.

This split is mainly for timing control and debuggability: qtests can 
easily exercise and assert distinct paths (NOT_ARMED, BAD_LEN, TX/RD 
failures, mismatch) instead of having all side effects hidden behind a 
single write.


If you feel this is overkill for a qtest-only device, I'm open to 
simplifying the interface (e.g. "write a register and immediately 
execute DMA").

>> +* ``ITD_REG_DMA_ATTRS`` (0x18): DMA attributes
>> +
>> +  - bit[0]: secure (1=Secure, 0=Non-Secure)
>> +  - bits[2:1]: address space (0=Non-Secure, 1=Secure, 2=Root, 3=Realm)
> I would simply remove Root and Realm for now. Are those bits part of
>
> ITD_REG_DMA_ATTR?


Yes I just shadowed the MemTxAttrs. I'll remove the unused Root/Realm 
definition.

>
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
>> +is set up for this device.
>> +
>> +DMA Operation Flow
>> +------------------
>> +1. Test programs IOMMU translation tables
>> +2. Test configures DMA address (GVA_LO/HI), length, and attributes
>> +3. Test writes 1 to DMA_DBELL to arm the operation
>> +4. Test reads DMA_TRIGGERING to execute DMA
> why do we need 3 and 4?


As previously described.

>> +5. Test polls DMA_RESULT:
>> +
>> +   - 0x00000000: Success
>> +   - 0xFFFFFFFE: Busy (still in progress)
>> +   - 0xDEAD000X: Various error codes
>> +
>> +The device performs a write-then-read sequence using a known pattern
>> +(0x88888888) and verifies data integrity automatically.
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
>> +* Multiple security spaces (Non-Secure, Secure, Root, Realm)
> ditto


I'll remove it.

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
> does it work -device arm-smmuv3 multi instantiation too?


No. It only supports machine-wide SMMU (`iommu=smmuv3`) as SMMU base 
address is hardcoded with 0x9050000 in tests/qtest/libqos/qos-smmuv3.h. 
Should we support user-creatable SMMUv3 in this testdev?

>> +
>> +The device will be placed behind the IOMMU automatically.
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
>> index 0000000000..3182ccea4d
>> --- /dev/null
>> +++ b/hw/misc/iommu-testdev.c
>> @@ -0,0 +1,278 @@
>> +/*
>> + * A test device for IOMMU
>> + *
>> + * This test device is a minimal IOMMU-aware device used to test the IOMMU.
> how is it IOMMU aware? Isn't it "simply" a kinda PCIe DMA device
>
> it behaves as other PCIe devices with s->dma_as = pci_device_iommu_address_space(pdev);
> no?


Sorry for the confusing wording. The device is not really "IOMMU-aware": 
it is just a PCI DMA engine, and the tests are responsible 
for programming the emulated IOMMU and wiring the device behind it, not 
the iommu-testdev itself.


Thanks again for the review,
Tao


