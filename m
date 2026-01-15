Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C371D44C41
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMxT-0004Bs-SA; Thu, 15 Jan 2026 08:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgMx3-0003fX-7H
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:59:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgMx0-0006qU-4w
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768481984;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIF+IrY03TZzvCnfdR7msIYCRLJAw+K72hAgZyEuJPc=;
 b=hB2+xZ22g7VvPyumE0QEW7rHMFywRLYm+WXCTp93fpENKdJUPwvrCn9u7QzCx2TsfnmqTh
 HIj0lBTOuSuLl/ds06v9NhnerY54aNY1s/gXYCNQrp3JvLx5cbHb4drXZqmzp3McaXDZqB
 c5Ft2wX05KNh+D4dW/Ey96b04KLhVv4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-DKfHszEHMKOOsaJpzXCIWA-1; Thu, 15 Jan 2026 07:59:42 -0500
X-MC-Unique: DKfHszEHMKOOsaJpzXCIWA-1
X-Mimecast-MFC-AGG-ID: DKfHszEHMKOOsaJpzXCIWA_1768481981
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4801c632124so2988195e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 04:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768481981; x=1769086781;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIF+IrY03TZzvCnfdR7msIYCRLJAw+K72hAgZyEuJPc=;
 b=nXAPs9cyvM2WBi6yHwzKxjLKcSBg1OIJv8FdqxXk99kTVwZU2obPE/F2Clqm2x4/r8
 CnFJELGxR85gY1Wxa0nT29jxXtrKOTt7/fekjoAc6qqCIL/VfeCbyx6mwOF0a4GnVNvk
 VaaeeW9g2he1MLrL7eVJCBq+WPj5a/FcKZH9jE46wf7UH4YMAFPJ4t/TP5l0Ugu+F36v
 NEVjGGnXTuDFgOmijQqiHBHQ21uP0Yb/JukS92Y7z5yfRkadMcmRBjBpKyV/h9xgHZpQ
 lDZp2vnoHB6S+TqRaXcEe79a4lOuaMFDvdgZblX8XIv7Ma5HnNb/BHdeAdpswO77ixgn
 DrIA==
X-Gm-Message-State: AOJu0YyTiwpfxvWsdhD2Fho8v/gwnLSWad0Zbj/BuYSgeE05ZliWkiLE
 meRgAgbpF/OZZkm8gYxpqAaerrzT0LwwEmEDTd6S9e9Hg7JNonWP7rrklKc9TR5DW1fyEH3w2Cg
 IXGGToFb2dxqbgHbYUGX3xz2am5/2bkyJNBLAunmadUhPIFmi3iAmw2+O
X-Gm-Gg: AY/fxX6jiEbe782Uk7/NsPPd5VEDuuJuo3cst4Kc6RLUCQDx8fpzH8fKRGmTyQ1eUal
 Gxl9IzRr1Q0YY7jGegoEbJrmJ7+FWngYmVs9xLQ105T1YySh1aGESO1kSyFsC0tUtDPr4fiLh3d
 S/EscH0NokhQ7vPkuY6qE663SDKFzWi2GgCajykWIlY8VNrARF7KJxBo4W9oFvb78oVQ8JsR3ot
 l6cfcyA7e76HZb1rPoVbkQumF5cv4ZbikkpMmRorj7phaIEj8B6IV+CbYaLE6pMerMHWUdsJ0SW
 4S/DAHeiw6ONmTxxSd/tGnnLGfeA4eXzK0mMBloktoeRekO9MOHRLSICTVftvpAzGWlHZgYjGXo
 cUkeSrE0hV+JaKBrGSyivZYejv0Jzi0fIEniZO+dSZX+Yk4p79moW+fQ77g==
X-Received: by 2002:a05:600c:8b52:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-47ee335699fmr63152275e9.23.1768481981199; 
 Thu, 15 Jan 2026 04:59:41 -0800 (PST)
X-Received: by 2002:a05:600c:8b52:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-47ee335699fmr63151885e9.23.1768481980662; 
 Thu, 15 Jan 2026 04:59:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee2814548sm43342365e9.9.2026.01.15.04.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 04:59:40 -0800 (PST)
Message-ID: <75e5bd17-c319-419b-a977-1e9d529a710f@redhat.com>
Date: Thu, 15 Jan 2026 13:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 3/7] hw/misc: Introduce iommu-testdev for bare-metal
 IOMMU testing
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-4-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251224034647.2596434-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 12/24/25 4:46 AM, Tao Tang wrote:
> Add a minimal PCI test device designed to exercise IOMMU translation
> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
> provides MMIO registers to configure and trigger DMA operations with
> controllable attributes (security state, address space), enabling
> deterministic IOMMU testing.
>
> Key features:
> - Bare-metal IOMMU testing via simple MMIO interface
> - Configurable DMA attributes for security states and address spaces
> - Write-then-read verification pattern with automatic result checking
>
> The device performs a deterministic DMA test pattern: write a known
> value (0x12345678) to a configured GVA, read it back, and verify data
> integrity. Results are reported through a dedicated result register,
> eliminating the need for complex interrupt handling or driver
> infrastructure in tests.
>
> This is purely a test device and not intended for production use or
> machine realism. It complements existing test infrastructure like
> pci-testdev but focuses specifically on IOMMU translation path
> validation.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>  MAINTAINERS                     |   7 +
>  docs/specs/index.rst            |   1 +
>  docs/specs/iommu-testdev.rst    | 112 +++++++++++++
>  hw/misc/Kconfig                 |   5 +
>  hw/misc/iommu-testdev.c         | 271 ++++++++++++++++++++++++++++++++
>  hw/misc/meson.build             |   1 +
>  hw/misc/trace-events            |  10 ++
>  include/hw/misc/iommu-testdev.h |  68 ++++++++
>  8 files changed, 475 insertions(+)
>  create mode 100644 docs/specs/iommu-testdev.rst
>  create mode 100644 hw/misc/iommu-testdev.c
>  create mode 100644 include/hw/misc/iommu-testdev.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63e9ba521b..3c88ed5dc4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2349,6 +2349,13 @@ F: include/qemu/chardev_open.h
>  F: util/chardev_open.c
>  F: docs/devel/vfio-iommufd.rst
>  
> +iommu-testdev
> +M: Tao Tang <tangtao1634@phytium.com.cn>
> +S: Maintained
> +F: hw/misc/iommu-testdev.c
> +F: include/hw/misc/iommu-testdev.h
> +F: docs/specs/iommu-testdev.rst
> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  R: Stefano Garzarella <sgarzare@redhat.com>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index f19d73c9f6..1fc7fae6bb 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -39,3 +39,4 @@ guest hardware that is specific to QEMU.
>     riscv-iommu
>     riscv-aia
>     aspeed-intc
> +   iommu-testdev
> \ No newline at end of file
> diff --git a/docs/specs/iommu-testdev.rst b/docs/specs/iommu-testdev.rst
> new file mode 100644
> index 0000000000..2bcd9bec93
> --- /dev/null
> +++ b/docs/specs/iommu-testdev.rst
> @@ -0,0 +1,112 @@
> +iommu-testdev — IOMMU test device for bare-metal testing
> +=========================================================
> +
> +Overview
> +--------
> +``iommu-testdev`` is a minimal, test-only PCI device designed to exercise
> +IOMMU translation (such as ARM SMMUv3) without requiring firmware or a guest
> +OS. Tests can populate IOMMU translation tables with known values and trigger
> +DMA operations that flow through the IOMMU translation path. It is **not** a
> +faithful PCIe endpoint and must be considered a QEMU-internal test vehicle.
> +
> +Key Features
> +------------
> +* **Bare-metal IOMMU testing**: No guest kernel or firmware required
> +* **Configurable DMA attributes**: Supports address space configuration via
> +  MMIO registers
> +* **Deterministic verification**: Write-then-read DMA pattern with automatic
> +  result checking
> +
> +Status
> +------
> +* Location: ``hw/misc/iommu-testdev.c``
> +* Header: ``include/hw/misc/iommu-testdev.h``
> +* Build guard: ``CONFIG_IOMMU_TESTDEV``
> +
> +Device Interface
> +----------------
> +The device exposes a single PCI BAR0 with 32bit MMIO registers:
> +
> +* ``ITD_REG_DMA_TRIGGERING`` (0x00): Reading triggers DMA execution
> +* ``ITD_REG_DMA_GVA_LO`` (0x04): GVA bits [31:0]
> +* ``ITD_REG_DMA_GVA_HI`` (0x08): GVA bits [63:32]
> +* ``ITD_REG_DMA_LEN`` (0x0C): DMA transfer length
> +* ``ITD_REG_DMA_RESULT`` (0x10): DMA operation result (0=success)
> +* ``ITD_REG_DMA_DBELL`` (0x14): Write 1 to arm DMA
I know you provided some explanations to be me earlier about separation
between "arming" and "triggering" but I don't find info in the doc about
what arming practically does and what kind of checks it can enable
compared to the actual trigger. I am not asking for removing it but
maybe document what it aims at.
> +* ``ITD_REG_DMA_ATTRS`` (0x18): DMA attributes which shadow MemTxAttrs format:
> +
> +  - bit[0]: secure (1=Secure, 0=Non-Secure)
> +  - bits[2:1]: address space (0=Non-Secure, 1=Secure)
I was confused by the diff between those 2 fields. If my understanding
is correct they should equal today, until we got some further RME stuff?
Correct?

In MemTxAttrs it is said:
     unsigned int secure:1;
    /*
     * ARM: ArmSecuritySpace.  This partially overlaps secure, but it is
     * easier to have both fields to assist code that does not understand
     * ARMv9 RME, or no specific knowledge of ARM at all (e.g. pflash).
     */
    unsigned int space:2;



> +    Only these MemTxAttrs fields (``secure`` and ``space``) are consumed today;
> +    other bits are reserved but can be wired up easily if future tests need
> +    to pass extra attributes.
> +
> +Translation Setup Workflow
> +--------------------------
> +``iommu-testdev`` never builds SMMU/AMD-Vi/RISC-V IOMMU structures on its own.
> +Architecture-specific construction lives entirely in qtest/libqos helpers.
> +Those helpers populate guest memory with page tables/architecture-specific
> +structures and program the emulated IOMMU registers directly. See the
> +``qsmmu_setup_and_enable_translation()`` function in
> +``tests/qtest/libqos/qos-smmuv3.c`` for an example of how SMMUv3 translation
> +is set up for this device, which will be introduced in the next commit.
nit: this is rather a commit description comment.
> +
> +DMA Operation Flow
> +------------------
> +The flow would be split into these steps, mainly for timing control and
> +debuggability: qtests can easily exercise and assert distinct paths
> +(NOT_ARMED, BAD_LEN, TX/RD failures, mismatch) instead of having all side
> +effects hidden behind a single step:
> +1. Test programs IOMMU translation tables
> +2. Test configures DMA address (GVA_LO/HI), length, and attributes
> +3. Test writes 1 to DMA_DBELL to arm the operation
so what does it? is it possible to arm if a transaction is already pending?
> +4. Test reads DMA_TRIGGERING to execute DMA
> +5. Test polls DMA_RESULT:
> +
> +   - 0x00000000: Success
> +   - 0xFFFFFFFE: Busy (still in progress)
> +   - 0xDEAD000X: Various error codes
> +
> +The device performs a write-then-read sequence using a known pattern
> +(0x12345678) and verifies data integrity automatically.
> +
> +Running the qtest
> +-----------------
> +The SMMUv3 test suite uses this device and covers multiple translation modes::
> +
> +    cd build-debug
> +    QTEST_QEMU_BINARY=./qemu-system-aarch64 \\
> +        ./tests/qtest/iommu-smmuv3-test --tap -k
> +
> +This test suite exercises:
> +
> +* Stage 1 only translation
> +* Stage 2 only translation
> +* Nested (Stage 1 + Stage 2) translation
> +
> +Instantiation
> +-------------
> +The device is not wired into any board by default. Tests instantiate it
> +via QEMU command line::
> +
> +    -device iommu-testdev
> +
> +For ARM platforms with SMMUv3::
> +
> +    -M virt,iommu=smmuv3 -device iommu-testdev
> +
> +The device will be placed behind the IOMMU automatically.
I guess the device is added on pci.0. so it works by default with
machine wide instantiation but not necessarily with arm-smmuv3 device
which can plugged downstream to a pxb. Maybe reword to avoid confusion.
> +
> +Limitations
> +-----------
> +* No realistic PCIe enumeration, MSI/MSI-X, or interrupt handling
> +* No ATS/PRI support
> +* No actual device functionality beyond DMA test pattern
> +* Test-only; not suitable for production or machine realism
> +* Address space support (Secure/Root/Realm) is architecture-dependent
> +
> +See also
> +--------
> +* ``tests/qtest/iommu-smmuv3-test.c`` — SMMUv3 test suite
> +* ``tests/qtest/libqos/qos-smmuv3.{c,h}`` — SMMUv3 test library
> +* SMMUv3 emulation: ``hw/arm/smmu*``
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index fccd735c24..b5f6fdbd9c 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -25,6 +25,11 @@ config PCI_TESTDEV
>      default y if TEST_DEVICES
>      depends on PCI
>  
> +config IOMMU_TESTDEV
> +    bool
> +    default y if TEST_DEVICES
> +    depends on PCI
> +
>  config EDU
>      bool
>      default y if TEST_DEVICES
> diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
> new file mode 100644
> index 0000000000..2cc1176aa6
> --- /dev/null
> +++ b/hw/misc/iommu-testdev.c
> @@ -0,0 +1,271 @@
> +/*
> + * A test device for IOMMU
> + *
> + * Copyright (c) 2025 Phytium Technology
nit 26
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/address-spaces.h"
> +#include "trace.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/qdev-properties.h"
> +#include "qom/object.h"
> +#include "hw/misc/iommu-testdev.h"
> +
> +#define TYPE_IOMMU_TESTDEV "iommu-testdev"
> +OBJECT_DECLARE_SIMPLE_TYPE(IOMMUTestDevState, IOMMU_TESTDEV)
> +
> +struct IOMMUTestDevState {
> +    PCIDevice parent_obj;
> +    MemoryRegion bar0;
> +    uint64_t dma_vaddr;
> +    uint32_t dma_len;
> +    uint32_t dma_result;
> +    bool dma_pending;
> +
> +    AddressSpace *dma_as;   /* IOMMU-mediated DMA AS for this device */
> +    uint32_t dma_attrs_cfg; /* bit0 secure, bits[2:1] space, bit3 unspecified */
> +};
> +
> +static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
> +{
> +    uint32_t expected_val, actual_val;
> +    g_autofree uint8_t *write_buf = NULL;
> +    g_autofree uint8_t *read_buf = NULL;
> +    MemTxResult write_res, read_res;
> +    MemTxAttrs attrs;
> +    AddressSpace *as;
> +
> +    if (!s->dma_pending) {
> +        s->dma_result = ITD_DMA_ERR_NOT_ARMED;
> +        trace_iommu_testdev_dma_result(s->dma_result);
> +        return;
> +    }
> +    trace_iommu_testdev_dma_start();
> +
> +    s->dma_pending = false;
strange you reset pending before the very access. if I understand
correctly your dma_pending means dma_armed though
> +
> +    if (!s->dma_len) {
> +        s->dma_result = ITD_DMA_ERR_BAD_LEN;
> +        return;
> +    }
> +
> +    write_buf = g_malloc(s->dma_len);
> +    read_buf = g_malloc(s->dma_len);
> +
> +    /* Initialize MemTxAttrs from generic register */
> +    attrs.secure = ITD_ATTRS_GET_SECURE(s->dma_attrs_cfg);
> +
> +    /* The 'space' field in MemTxAttrs is ARM-specific. */
> +    attrs.space = ITD_ATTRS_GET_SPACE(s->dma_attrs_cfg);

maybe check they both secure and space are somehow consistent?
> +
> +    as = s->dma_as;
> +
> +    /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
> +    trace_iommu_testdev_dma_write(s->dma_vaddr, s->dma_len);
> +
> +    for (int i = 0; i < s->dma_len; i++) {
> +        /* Data is written in little-endian order */
> +        write_buf[i] = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
> +    }
> +    write_res = dma_memory_write(as, s->dma_vaddr, write_buf, s->dma_len, attrs);
> +
> +    if (write_res != MEMTX_OK) {
> +        s->dma_result = ITD_DMA_ERR_TX_FAIL;
> +        trace_iommu_testdev_dma_result(s->dma_result);
> +        return;
> +    }
> +
> +    /* Step 2: Read back from the same DMA address */
> +    trace_iommu_testdev_dma_read(s->dma_vaddr, s->dma_len);
> +
> +    read_res = dma_memory_read(as, s->dma_vaddr, read_buf, s->dma_len, attrs);
This assumes the IOMMU translation is correct. If it is bad in both
directions, you may read the same value but does not necessarily means
the translated addr is correct.
Wouldn't it be better to read the mem at expected GPA without going
through the IOMMU?
> +
> +    if (read_res != MEMTX_OK) {
> +        s->dma_result = ITD_DMA_ERR_RD_FAIL;
> +        trace_iommu_testdev_dma_result(s->dma_result);
> +        return;
> +    }
> +
> +    /* Step 3: Verify the read data matches what we wrote */
> +    for (int i = 0; i < s->dma_len; i += 4) {
> +        int remaining_bytes = MIN(4, s->dma_len - i);
> +
> +        expected_val = 0;
> +        actual_val = 0;
> +
> +        for (int j = 0; j < remaining_bytes; j++) {
> +            expected_val |= ((uint32_t)write_buf[i + j]) << (j * 8);
> +            actual_val |= ((uint32_t)read_buf[i + j]) << (j * 8);
> +        }
> +
> +        trace_iommu_testdev_dma_verify(expected_val, actual_val);
> +
> +        if (expected_val != actual_val) {
> +            s->dma_result = ITD_DMA_ERR_MISMATCH;
> +            trace_iommu_testdev_dma_result(s->dma_result);
> +            return;
> +        }
> +    }
> +
> +    /* All checks passed */
> +    s->dma_result = 0;
> +    trace_iommu_testdev_dma_result(s->dma_result);
> +}
> +
> +static uint64_t iommu_testdev_mmio_read(void *opaque, hwaddr addr,
> +                                        unsigned size)
> +{
> +    IOMMUTestDevState *s = opaque;
> +    uint64_t value = 0;
> +
> +    switch (addr) {
> +    case ITD_REG_DMA_TRIGGERING:
> +        /*
> +         * This lets tests poll ITD_REG_DMA_RESULT to observe BUSY before
> +         * consuming the DMA.
> +         */
> +        iommu_testdev_maybe_run_dma(s);
> +        value = 0;
> +        break;
> +    case ITD_REG_DMA_GVA_LO:
> +        value = (uint32_t)(s->dma_vaddr & 0xffffffffu);
> +        break;
> +    case ITD_REG_DMA_GVA_HI:
> +        value = (uint32_t)(s->dma_vaddr >> 32);
> +        break;
> +    case ITD_REG_DMA_LEN:
> +        value = s->dma_len;
> +        break;
> +    case ITD_REG_DMA_RESULT:
> +        value = s->dma_result;
> +        break;
> +    case ITD_REG_DMA_ATTRS:
> +        value = s->dma_attrs_cfg;
> +        break;
> +    default:
> +        value = 0;
> +        break;
> +    }
> +
> +    trace_iommu_testdev_mmio_read(addr, value, size);
> +    return value;
> +}
> +
> +static void iommu_testdev_mmio_write(void *opaque, hwaddr addr, uint64_t val,
> +                                     unsigned size)
> +{
> +    IOMMUTestDevState *s = opaque;
> +    uint32_t data = val;
> +
> +    trace_iommu_testdev_mmio_write(addr, val, size);
> +
> +    switch (addr) {
> +    case ITD_REG_DMA_GVA_LO:
> +        s->dma_vaddr = (s->dma_vaddr & ~0xffffffffull) | data;
> +        break;
> +    case ITD_REG_DMA_GVA_HI:
> +        s->dma_vaddr = (s->dma_vaddr & 0xffffffffull) |
> +                       ((uint64_t)data << 32);
> +        break;
> +    case ITD_REG_DMA_LEN:
> +        s->dma_len = data;
> +        break;
> +    case ITD_REG_DMA_RESULT:
> +        s->dma_result = data;
> +        break;
> +    case ITD_REG_DMA_DBELL:
> +        if (data & ITD_DMA_DBELL_ARM) {
> +            /* Arm the DMA operation */
> +            s->dma_pending = true;
dma_armed?
> +            s->dma_result = ITD_DMA_RESULT_BUSY;
> +            trace_iommu_testdev_dma_pending(true);
> +        } else {
> +            /* Disarm the DMA operation */
> +            s->dma_pending = false;
> +            s->dma_result = ITD_DMA_RESULT_IDLE;
> +            trace_iommu_testdev_dma_pending(false);
> +        }
> +        break;
> +    case ITD_REG_DMA_ATTRS:
> +        s->dma_attrs_cfg = data;
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps iommu_testdev_mmio_ops = {
> +    .read = iommu_testdev_mmio_read,
> +    .write = iommu_testdev_mmio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void iommu_testdev_realize(PCIDevice *pdev, Error **errp)
> +{
> +    IOMMUTestDevState *s = IOMMU_TESTDEV(pdev);
> +
> +    s->dma_vaddr = 0;
> +    s->dma_len = 0;
> +    s->dma_result = ITD_DMA_RESULT_IDLE;
> +    s->dma_pending = false;
> +    s->dma_attrs_cfg = 0;
> +    s->dma_as = pci_device_iommu_address_space(pdev);
> +
> +    memory_region_init_io(&s->bar0, OBJECT(pdev), &iommu_testdev_mmio_ops, s,
> +                          TYPE_IOMMU_TESTDEV ".bar0", BAR0_SIZE);
> +    pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
> +}
> +
> +static void iommu_testdev_reset(DeviceState *dev)
> +{
> +    IOMMUTestDevState *s = IOMMU_TESTDEV(dev);
> +
> +    s->dma_vaddr = 0;
> +    s->dma_len = 0;
> +    s->dma_result = ITD_DMA_RESULT_IDLE;
> +    s->dma_pending = false;
> +    s->dma_attrs_cfg = 0;
> +}
> +
> +static void iommu_testdev_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
> +
> +    pc->realize = iommu_testdev_realize;
> +    pc->vendor_id = IOMMU_TESTDEV_VENDOR_ID;
> +    pc->device_id = IOMMU_TESTDEV_DEVICE_ID;
> +    pc->revision = 0;
> +    pc->class_id = PCI_CLASS_OTHERS;
> +    dc->desc = "A test device for IOMMU";
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    device_class_set_legacy_reset(dc, iommu_testdev_reset);
> +}
> +
> +static const TypeInfo iommu_testdev_info = {
> +    .name          = TYPE_IOMMU_TESTDEV,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(IOMMUTestDevState),
> +    .class_init    = iommu_testdev_class_init,
> +    .interfaces    = (const InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
> +};
> +
> +static void iommu_testdev_register_types(void)
> +{
> +    type_register_static(&iommu_testdev_info);
> +}
> +
> +type_init(iommu_testdev_register_types);
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b1d8d8e5d2..6f9bb9bb0f 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
>  system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
>  system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
>  system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
> +system_ss.add(when: 'CONFIG_IOMMU_TESTDEV', if_true: files('iommu-testdev.c'))
>  system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
>  system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
>  system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index eeb9243898..84fd349fb8 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -409,3 +409,13 @@ ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Interrupting
>  i2c_echo_event(const char *id, const char *event) "%s: %s"
>  i2c_echo_recv(const char *id, uint8_t data) "%s: recv 0x%02" PRIx8
>  i2c_echo_send(const char *id, uint8_t data) "%s: send 0x%02" PRIx8
> +
> +# iommu-testdev.c
> +iommu_testdev_mmio_read(uint64_t addr, uint64_t value, unsigned size) "addr=0x%" PRIx64 " value=0x%" PRIx64 " size=%u"
> +iommu_testdev_mmio_write(uint64_t addr, uint64_t value, unsigned size) "addr=0x%" PRIx64 " value=0x%" PRIx64 " size=%u"
> +iommu_testdev_dma_start(void) "DMA operation started"
> +iommu_testdev_dma_write(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
> +iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
> +iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
> +iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
> +iommu_testdev_dma_pending(bool pending) "pending=%d"
> diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-testdev.h
> new file mode 100644
> index 0000000000..14a5bca721
> --- /dev/null
> +++ b/include/hw/misc/iommu-testdev.h
> @@ -0,0 +1,68 @@
> +/*
> + * A test device for IOMMU
> + *
> + * Copyright (c) 2025 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_IOMMU_TESTDEV_H
> +#define HW_MISC_IOMMU_TESTDEV_H
> +
> +#include "hw/pci/pci.h"
> +
> +#define IOMMU_TESTDEV_VENDOR_ID     PCI_VENDOR_ID_REDHAT
> +#define IOMMU_TESTDEV_DEVICE_ID     PCI_DEVICE_ID_REDHAT_TEST
> +
> +/* DMA_ATTRS register bit definitions (architecture-agnostic) */
> +#define ITD_ATTRS_SECURE_SHIFT      0
> +#define ITD_ATTRS_SECURE_MASK       0x1
> +#define ITD_ATTRS_SPACE_SHIFT       1
> +#define ITD_ATTRS_SPACE_MASK        0x3
> +
> +/* Helper macros for setting fields */
> +#define ITD_ATTRS_SET_SECURE(attrs, val)                              \
> +    (((attrs) & ~(ITD_ATTRS_SECURE_MASK << ITD_ATTRS_SECURE_SHIFT)) | \
> +     (((val) & ITD_ATTRS_SECURE_MASK) << ITD_ATTRS_SECURE_SHIFT))
> +
> +#define ITD_ATTRS_SET_SPACE(attrs, val)                               \
> +    (((attrs) & ~(ITD_ATTRS_SPACE_MASK << ITD_ATTRS_SPACE_SHIFT)) |   \
> +     (((val) & ITD_ATTRS_SPACE_MASK) << ITD_ATTRS_SPACE_SHIFT))
> +
> +/* Helper macros for getting fields */
> +#define ITD_ATTRS_GET_SECURE(attrs)                                   \
> +    (((attrs) >> ITD_ATTRS_SECURE_SHIFT) & ITD_ATTRS_SECURE_MASK)
> +
> +#define ITD_ATTRS_GET_SPACE(attrs)                                    \
> +    (((attrs) >> ITD_ATTRS_SPACE_SHIFT) & ITD_ATTRS_SPACE_MASK)
> +
> +/* DMA result/status values shared with tests */
> +#define ITD_DMA_RESULT_IDLE   0xffffffffu
> +#define ITD_DMA_RESULT_BUSY   0xfffffffeu
> +#define ITD_DMA_ERR_BAD_LEN   0xdead0001u
> +#define ITD_DMA_ERR_TX_FAIL   0xdead0002u
> +#define ITD_DMA_ERR_RD_FAIL   0xdead0003u
> +#define ITD_DMA_ERR_MISMATCH  0xdead0004u
> +#define ITD_DMA_ERR_NOT_ARMED 0xdead0005u
> +
> +#define ITD_DMA_WRITE_VAL     0x12345678u
> +
> +/* DMA doorbell bits */
> +#define ITD_DMA_DBELL_ARM    0x1u
> +
> +/* BAR0 layout of iommu-testdev */
> +enum {
> +    ITD_REG_DMA_TRIGGERING  = 0x00,
> +    ITD_REG_DMA_GVA_LO      = 0x04,
> +    ITD_REG_DMA_GVA_HI      = 0x08,
> +    ITD_REG_DMA_LEN         = 0x0c,
> +    ITD_REG_DMA_RESULT      = 0x10,
> +    ITD_REG_DMA_DBELL       = 0x14,
> +    ITD_REG_DMA_ATTRS       = 0x18, /* [0] secure,[2:1] space,[3] unspecified */
> +    BAR0_SIZE               = 0x1000,
> +};
> +
> +#endif /* HW_MISC_IOMMU_TESTDEV_H */
Thanks

Eric


