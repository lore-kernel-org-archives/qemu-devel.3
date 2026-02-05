Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EDAE91299
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnvXQ-0007a5-IH; Thu, 05 Feb 2026 04:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnvXN-0007Zt-Bt
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:20:33 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnvXI-00079T-Cc
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:20:33 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso524404b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 01:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770283226; x=1770888026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0D+zt9D1vZcxFTxAIgmqw+B9KZ0rc7gP1+4wo/iCUU=;
 b=HNisU4o+eb4iJHDkbJam2fPJMBLw0H5UfR6gN1/dN1r9HapEEg4Zqe2c1srjUn59pn
 8704S3kH3BoSfS3W2rp3tnRN2nhkgldyTUUZWRj5htE084JTRovWMeP+nJ+xxte3X4SG
 xjlirpSHL+HYOFgdR4MuCWVVKTgBVgnuUQafsHFbSoMsOtSou4svKTNR07UYLwtU9kai
 idczE1zFMpKXup6QFthsASkhQIEqwXhIQpSQPLnxp4jQT5yfn27Ya+b37zfoy6e3Ki5v
 MmuyxTUVGLDt8FF7IN3DVXxZJKjVWaXVuTvj0BJC4mduqg72F+jWjP5pvviY59hov3uL
 67FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770283226; x=1770888026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I0D+zt9D1vZcxFTxAIgmqw+B9KZ0rc7gP1+4wo/iCUU=;
 b=i0OJ4w99UuDWhevFMY5rLGnWrDOcs1HcL4UhGo6ZccbhBtfZbc4VbFyPLo8QxUb44A
 uUD1cJLKbK6RqRkmn7rPbhqQ0hCJHUpmHPyObXli5Y+kB+dWDiK5yn6EFucLRDysCBn9
 aT3qns/EnhP4KPZw//iaphxbM7Kh6O7gc0R0FfqQE+eHXGXQE9jO9M5oWjtNtDZZDTE6
 0iwgC/qEcRln9szGdwvv875uS++9NRQUuIkE/HWdQ0LFvih1egLQVxVOeMzQjFyeQHW1
 nSOb4IvF0nu7OSy36Ai78qu9P5R+N9eApInsxfnF7tRplrKHH1tcbTFmEDDwSyOl0IYZ
 bVVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpq+Imw+FpThOZGZB6Vf/VfVtUHP3+8bDpheS24rUlGIM4wcakxU9ySwBMidpgWDMhOMNEbcFvHErV@nongnu.org
X-Gm-Message-State: AOJu0YycnrW+HOSXen0f2tHU2S/VPwOW6V/P/4s5C49ixfhuPawzwyp0
 QgfPebc/pFHrJ/gOCKQc3DUvG3sB6if3wONDzcD9CkPUe2hNXwH7dZ5c
X-Gm-Gg: AZuq6aKokC4O0p1vSxqGJRvhYkDa/EdjDls9ZdfcuqWa3LAq+QONMYdRL5UnpZD4hNy
 dwdTg8SkesGU0Ig4UjRAntV87ty7HtsYlw3oQmpuBbaVq/RGnAsUKRTjEmufZKGb7M9NabmunOH
 n79T21++aJrpAYF+8eZv75xDebwr83KsKGU/ikg+7SJIT1/n82WoncJ5lIo4eMo8OUDlb0B+sYy
 bmccMTtGUSnQ+/hE1vuJzDzMQcOqXzghxhsveWfKd4RgEv8gTrr1cDWiAV6K/Mhl/TViRyu2n/y
 zhyLiNb/yf7gxnVQkCVOKRmc7WIEA0M2KWfeCyJtIRBcBL3LQi1Whzp+yT4PjmiPkpNoPtGGCWa
 bm5mdJWiJg3fOvmeX6iJF6qlm/LLXof8KOq5oxfehTYfLNPeiF+icVsLOSLbQ2t48QO8+K/ClPx
 qF7r/DsQWRJ9E4QH8WTxLZSniISnzc9vHX33GYYnklwoJ6GQOdZOZUJYd1g3IfLpjMjtM=
X-Received: by 2002:a05:6a00:2353:b0:81b:c2b5:31a with SMTP id
 d2e1a72fcca58-8241c64940amr5793379b3a.53.1770283226304; 
 Thu, 05 Feb 2026 01:20:26 -0800 (PST)
Received: from ?IPV6:240e:468:788:182d:c9a0:5302:cea5:79d2?
 ([240e:468:788:182d:c9a0:5302:cea5:79d2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d487886sm6115687b3a.59.2026.02.05.01.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 01:20:25 -0800 (PST)
Message-ID: <4326198f-a2ed-44de-8f80-1e5d94ba1d1b@gmail.com>
Date: Thu, 5 Feb 2026 17:20:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/2] tests/qtest/libqos: Add Intel IOMMU helper
 library
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 qemu-devel@nongnu.org
References: <cover.1770172615.git.15fengyuan@gmail.com>
 <43566a31edae425986188b71fce8520c58e9476d.1770172615.git.15fengyuan@gmail.com>
 <aYL1wVGNYgQnRSRF@ZEVORN-PC>
From: Fengyuan <15fengyuan@gmail.com>
In-Reply-To: <aYL1wVGNYgQnRSRF@ZEVORN-PC>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=15fengyuan@gmail.com; helo=mail-pf1-x42c.google.com
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

Hi Chao,

Thanks for the review!

On 2/4/2026 3:31 PM, Chao Liu wrote:
> Hi Fengyuan,
> 
> Thanks for working on Intel IOMMU bare-metal testing support. I have some
> comments below.
> 
> On Wed, Feb 04, 2026 at 11:06:19AM +0800, Fengyuan Yu wrote:
>> Introduce a libqos helper module for Intel IOMMU (VT-d) testing with
>> iommu-testdev. The helper provides routines to:
>>
>> - Build Root Entry Tables, Context Entry Tables, and 4-level page tables
>>    for 48-bit address translation
>> - Program VT-d registers (Root Table Pointer, Global Command Register)
>>    following the Intel VT-d specification
>> - Execute DMA translations and verify results
>>
>> The current implementation supports Legacy mode with both pass-through and
>> translated (4-level paging) modes. Support for Scalable mode (PASID-based)
>> can be added in future patches.
>>
> The commit message looks good.
> 
>> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
>>
>> ---
>>   MAINTAINERS                          |   1 +
>>   tests/qtest/libqos/meson.build       |   3 +
>>   tests/qtest/libqos/qos-intel-iommu.c | 566 +++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-intel-iommu.h | 299 ++++++++++++++
>>   4 files changed, 869 insertions(+)
>>   create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
>>   create mode 100644 tests/qtest/libqos/qos-intel-iommu.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9b7ed4fccb..1cd2a4f474 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3585,6 +3585,7 @@ M: Tao Tang <tangtao1634@phytium.com.cn>
>>   S: Maintained
>>   F: tests/qtest/libqos/qos-iommu*
>>   F: tests/qtest/libqos/qos-smmuv3*
>> +F: tests/qtest/libqos/qos-intel-iommu*
>>   
>>   Device Fuzzing
>>   M: Alexander Bulekov <alxndr@bu.edu>
>> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
>> index 8d6758ec2b..7f7c4f9c6f 100644
>> --- a/tests/qtest/libqos/meson.build
>> +++ b/tests/qtest/libqos/meson.build
>> @@ -72,6 +72,9 @@ endif
>>   if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
>>     libqos_srcs += files('riscv-iommu.c')
>>   endif
>> +if config_all_devices.has_key('CONFIG_VTD')
>> +  libqos_srcs += files('qos-intel-iommu.c')
>> +endif
>>   if config_all_devices.has_key('CONFIG_TPCI200')
>>     libqos_srcs += files('tpci200.c')
>>   endif
>> diff --git a/tests/qtest/libqos/qos-intel-iommu.c b/tests/qtest/libqos/qos-intel-iommu.c
>> new file mode 100644
>> index 0000000000..d6a733de7e
>> --- /dev/null
>> +++ b/tests/qtest/libqos/qos-intel-iommu.c
>> @@ -0,0 +1,566 @@
>> +/*
>> + * QOS Intel IOMMU (VT-d) Module Implementation
>> + *
>> + * This module provides Intel IOMMU-specific helper functions for libqos tests.
>> + *
>> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "../libqtest.h"
>> +#include "pci.h"
>> +#include "qos-intel-iommu.h"
>> +
> You should also include "qos-iommu-testdev.h" here, as the SMMUv3 helper
> does. This would allow reusing the common DMA trigger infrastructure.
> 
Thanks for the review. After developing based on an earlier version of 
iommu-testdev, I had overlooked its interface updates. I have now pulled the 
latest changes and adapted the unified interface for Intel IOMMU functionality. 
I will include this update in v2.

>> +#define QVTD_POLL_DELAY_US        1000
>> +#define QVTD_POLL_MAX_RETRIES     1000
>> +#define QVTD_AW_48BIT_ENCODING    2
>> +
>> +/*
>> + * iommu-testdev DMA attribute layout for Intel VT-d traffic.
>> + *
>> + * Bits [2:0] keep using the generic iommu-testdev encoding
>> + * (secure + ArmSecuritySpace). Bits [23:8] carry the PCI Requester ID in the
>> + * format defined in the Intel VT-d spec (Figure 3-2 in
>> + * spec/Intel-iommu-spec.txt), and bits [31:24] contain the PASID that tags
>> + * scalable-mode transactions. Bit 4 distinguishes between pure legacy RID
>> + * requests and scalable-mode PASID-tagged requests. The PASID field is
>> + * limited to 8 bits because MemTxAttrs::pid only carries 8 bits today (see
>> + * include/exec/memattrs.h and the VTD_ECAP_PSS limit in
>> + * hw/i386/intel_iommu_internal.h).
>> + */
>> +#define QVTD_DMA_ATTR_MODE_SHIFT      4
>> +#define QVTD_DMA_ATTR_MODE_MASK       0x1
>> +#define QVTD_DMA_ATTR_MODE_LEGACY     0
>> +#define QVTD_DMA_ATTR_MODE_SCALABLE   1
>> +#define QVTD_DMA_ATTR_RID_SHIFT       8
>> +#define QVTD_DMA_ATTR_RID_MASK        0xffffu
>> +#define QVTD_DMA_ATTR_PASID_BITS      8
>> +#define QVTD_DMA_ATTR_PASID_SHIFT     24
>> +#define QVTD_DMA_ATTR_PASID_MASK      ((1u << QVTD_DMA_ATTR_PASID_BITS) - 1)
>> +
>> +#define QVTD_PCI_FUNCS_PER_DEVICE     8
>> +#define QVTD_PCI_DEVS_PER_BUS         32
>> +
>> +static void qvtd_wait_for_bitsl(QTestState *qts, uint64_t addr,
>> +                                uint32_t mask, bool expect_set)
>> +{
>> +    uint32_t val = 0;
>> +
>> +    for (int attempt = 0; attempt < QVTD_POLL_MAX_RETRIES; attempt++) {
>> +        val = qtest_readl(qts, addr);
>> +        if (!!(val & mask) == expect_set) {
>> +            return;
>> +        }
>> +        g_usleep(QVTD_POLL_DELAY_US);
>> +    }
>> +
>> +    g_error("Timeout waiting for bits 0x%x (%s) at 0x%llx, last=0x%x",
> Please use PRIx64 instead of %llx with (unsigned long long) cast.
> This applies to all similar occurrences in this file.
> 
Thanks for the review. I'ill fix this in v2.

>> +            mask, expect_set ? "set" : "clear",
>> +            (unsigned long long)addr, val);
>> +}
>> +
>> +static void qvtd_wait_for_bitsq(QTestState *qts, uint64_t addr,
>> +                                uint64_t mask, bool expect_set)
>> +{
>> +    uint64_t val = 0;
>> +
>> +    for (int attempt = 0; attempt < QVTD_POLL_MAX_RETRIES; attempt++) {
>> +        val = qtest_readq(qts, addr);
>> +        if (!!(val & mask) == expect_set) {
>> +            return;
>> +        }
>> +        g_usleep(QVTD_POLL_DELAY_US);
>> +    }
>> +
>> +    g_error("Timeout waiting for bits 0x%llx (%s) at 0x%llx, last=0x%llx",
>> +            (unsigned long long)mask, expect_set ? "set" : "clear",
>> +            (unsigned long long)addr, (unsigned long long)val);
>> +}
>> +
>> +static uint16_t qvtd_calc_sid(const QPCIDevice *dev)
>> +{
>> +    uint16_t devfn = dev->devfn & 0xff;
>> +    uint16_t bus = (dev->devfn >> 8) & 0xff;
>> +    uint8_t device = (devfn >> 3) & 0x1f;
>> +    uint8_t function = devfn & 0x7;
>> +
>> +    /* Validate BDF components. */
>> +    if (device >= QVTD_PCI_DEVS_PER_BUS || function >= QVTD_PCI_FUNCS_PER_DEVICE) {
>> +        g_error("Invalid BDF: bus=%u device=%u function=%u", bus, device, function);
>> +    }
>> +
>> +    return (bus << 8) | devfn;
>> +}
>> +
>> +static bool qvtd_validate_dma_memory(QVTDTestContext *ctx)
>> +{
>> +    uint32_t len = ctx->config.dma_len;
>> +    g_autofree uint8_t *buf = NULL;
>> +
>> +    if (!len) {
>> +        return true;
>> +    }
>> +
>> +    buf = g_malloc(len);
>> +    qtest_memread(ctx->qts, ctx->config.dma_pa, buf, len);
>> +
>> +    for (uint32_t i = 0; i < len; i++) {
>> +        uint8_t expected = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
>> +        if (buf[i] != expected) {
>> +            g_test_message("Memory mismatch at PA=0x%llx offset=%u "
>> +                           "expected=0x%02x actual=0x%02x",
>> +                           (unsigned long long)ctx->config.dma_pa, i,
>> +                           expected, buf[i]);
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx)
>> +{
>> +    return ctx->config.expected_result;
>> +}
>> +
>> +uint32_t qvtd_build_dma_attrs(uint16_t bdf, uint32_t pasid)
>> +{
>> +    uint32_t attrs = 0;
>> +    uint8_t bus = (bdf >> 8) & 0xff;
>> +    uint8_t devfn = bdf & 0xff;
>> +    uint8_t device = devfn >> 3;
>> +    uint8_t function = devfn & 0x7;
>> +    bool scalable_mode = pasid != 0;
>> +
>> +    if (device >= QVTD_PCI_DEVS_PER_BUS || function >= QVTD_PCI_FUNCS_PER_DEVICE) {
>> +        g_error("Invalid requester-id 0x%04x (bus=%u device=%u function=%u)",
>> +                bdf, bus, device, function);
>> +    }
>> +
>> +    attrs = ITD_ATTRS_SET_SECURE(attrs, 0);
>> +    attrs = ITD_ATTRS_SET_SPACE(attrs, 0);
>> +    attrs |= ((uint32_t)bdf & QVTD_DMA_ATTR_RID_MASK) << QVTD_DMA_ATTR_RID_SHIFT;
>> +
>> +    if (scalable_mode) {
>> +        if (pasid > QVTD_DMA_ATTR_PASID_MASK) {
>> +            g_error("PASID 0x%x exceeds %u-bit limit imposed by MemTxAttrs",
>> +                    pasid, QVTD_DMA_ATTR_PASID_BITS);
>> +        }
>> +
>> +        attrs |= (QVTD_DMA_ATTR_MODE_SCALABLE << QVTD_DMA_ATTR_MODE_SHIFT);
>> +        attrs |= ((pasid & QVTD_DMA_ATTR_PASID_MASK) << QVTD_DMA_ATTR_PASID_SHIFT);
>> +    } else {
>> +        attrs |= (QVTD_DMA_ATTR_MODE_LEGACY << QVTD_DMA_ATTR_MODE_SHIFT);
>> +    }
>> +
>> +    return attrs;
>> +}
>> +
>> +static void qvtd_build_root_entry(QTestState *qts, uint8_t bus,
>> +                                  uint64_t context_table_ptr)
>> +{
>> +    uint64_t root_entry_addr = QVTD_ROOT_TABLE_BASE + (bus * 16);
>> +    uint64_t lo, hi;
>> +
>> +    /* Root Entry Low: Context Table Pointer + Present bit (VT-d spec Section 9.1). */
>> +    lo = (context_table_ptr & VTD_CONTEXT_ENTRY_SLPTPTR) | VTD_CONTEXT_ENTRY_P;
>> +    hi = 0;  /* Reserved. */
>> +
>> +    qtest_writeq(qts, root_entry_addr, lo);
>> +    qtest_writeq(qts, root_entry_addr + 8, hi);
>> +}
>> +
>> +static void qvtd_build_context_entry(QTestState *qts, uint16_t sid,
>> +                                     QVTDTransMode mode, uint16_t domain_id,
>> +                                     uint64_t slptptr)
>> +{
>> +    uint8_t devfn = sid & 0xff;
>> +    uint64_t context_entry_addr = QVTD_CONTEXT_TABLE_BASE + (devfn * 16);
>> +    uint64_t lo, hi;
>> +
>> +    if (mode == QVTD_TM_LEGACY_PT) {
>> +        /* Pass-through mode (VT-d spec Section 3.9, Section 9.3). */
>> +        lo = VTD_CONTEXT_ENTRY_P | VTD_CONTEXT_TT_PASS_THROUGH;
>> +        hi = ((uint64_t)domain_id << 8) | QVTD_AW_48BIT_ENCODING;
>> +    } else {
>> +        /* Translated mode: 4-level paging (AW=2 for 48-bit, VT-d spec Section 9.3). */
>> +        lo = VTD_CONTEXT_ENTRY_P | VTD_CONTEXT_TT_MULTI_LEVEL |
>> +             (slptptr & VTD_CONTEXT_ENTRY_SLPTPTR);
>> +        hi = ((uint64_t)domain_id << 8) | QVTD_AW_48BIT_ENCODING;
>> +    }
>> +
>> +    qtest_writeq(qts, context_entry_addr, lo);
>> +    qtest_writeq(qts, context_entry_addr + 8, hi);
>> +}
>> +
>> +void qvtd_setup_translation_tables(QTestState *qts, uint64_t iova,
>> +                                   uint64_t pa, QVTDTransMode mode)
>> +{
>> +    uint64_t pml4_entry, pdpt_entry, pd_entry, pt_entry;
>> +    uint64_t pml4_addr, pdpt_addr, pd_addr, pt_addr;
>> +    uint32_t pml4_idx, pdpt_idx, pd_idx, pt_idx;
>> +    const char *mode_str = (mode == QVTD_TM_LEGACY_PT) ?
>> +                           "Pass-Through" : "Translated";
>> +
>> +    g_test_message("Begin of page table construction: IOVA=0x%llx PA=0x%llx mode=%s",
>> +                   (unsigned long long)iova, (unsigned long long)pa, mode_str);
>> +
>> +    /* Pass-through mode doesn't need page tables */
>> +    if (mode == QVTD_TM_LEGACY_PT) {
>> +        g_test_message("Pass-through mode: skipping page table setup");
>> +        return;
>> +    }
>> +
>> +    /* Extract indices from IOVA
>> +     * 4-level paging for 48-bit virtual address space:
>> +     * - PML4 index: bits [47:39] (9 bits = 512 entries)
>> +     * - PDPT index:  bits [38:30] (9 bits = 512 entries)
>> +     * - PD index:    bits [29:21] (9 bits = 512 entries)
>> +     * - PT index:    bits [20:12] (9 bits = 512 entries)
>> +     * - Page offset: bits [11:0]  (12 bits = 4KB pages)
>> +     */
>> +    pml4_idx = (iova >> 39) & 0x1ff;  /* Bits [47:39] */
>> +    pdpt_idx = (iova >> 30) & 0x1ff;  /* Bits [38:30] */
>> +    pd_idx = (iova >> 21) & 0x1ff;    /* Bits [29:21] */
>> +    pt_idx = (iova >> 12) & 0x1ff;    /* Bits [20:12] */
>> +
>> +    /*
>> +     * Build 4-level page table hierarchy (VT-d spec Section 9.3, Table 9-3).
>> +     * Non-leaf entries: both R+W set for full access (spec allows R or W individually).
>> +     * Per VT-d spec Section 9.8: "If either the R or W field of a non-leaf
>> +     * paging-structure entry is 1", indicating that setting one or both is valid.
>> +     * We set both R+W for non-leaf entries as standard practice.
>> +     */
>> +
>> +    /* PML4 Entry: points to PDPT. */
>> +    pml4_addr = QVTD_PT_L4_BASE + (pml4_idx * 8);
>> +    pml4_entry = QVTD_PT_L3_BASE | VTD_SL_R | VTD_SL_W;
>> +    qtest_writeq(qts, pml4_addr, pml4_entry);
>> +
>> +    /* PDPT Entry: points to PD. */
>> +    pdpt_addr = QVTD_PT_L3_BASE + (pdpt_idx * 8);
>> +    pdpt_entry = QVTD_PT_L2_BASE | VTD_SL_R | VTD_SL_W;
>> +    qtest_writeq(qts, pdpt_addr, pdpt_entry);
>> +
>> +    /* PD Entry: points to PT. */
>> +    pd_addr = QVTD_PT_L2_BASE + (pd_idx * 8);
>> +    pd_entry = QVTD_PT_L1_BASE | VTD_SL_R | VTD_SL_W;
>> +    qtest_writeq(qts, pd_addr, pd_entry);
>> +
>> +    /* PT Entry: points to physical page (leaf). */
>> +    pt_addr = QVTD_PT_L1_BASE + (pt_idx * 8);
>> +    pt_entry = (pa & VTD_PAGE_MASK_4K) | VTD_SL_R | VTD_SL_W;
>> +    qtest_writeq(qts, pt_addr, pt_entry);
>> +
>> +    g_test_message("End of page table construction: mapped IOVA=0x%llx -> PA=0x%llx",
>> +                   (unsigned long long)iova, (unsigned long long)pa);
>> +}
>> +
>> +static void qvtd_invalidate_context_cache(QTestState *qts,
>> +                                          uint64_t iommu_base)
>> +{
>> +    uint64_t ccmd_val;
>> +
>> +    /* Context Command Register: Global invalidation (VT-d spec Section 6.5.1.1). */
>> +    ccmd_val = VTD_CCMD_ICC | VTD_CCMD_GLOBAL_INVL;
>> +    qtest_writeq(qts, iommu_base + DMAR_CCMD_REG, ccmd_val);
>> +
>> +    /* Wait for ICC bit to clear. */
>> +    qvtd_wait_for_bitsq(qts, iommu_base + DMAR_CCMD_REG,
>> +                        VTD_CCMD_ICC, false);
>> +}
>> +
>> +static void qvtd_invalidate_iotlb(QTestState *qts, uint64_t iommu_base)
>> +{
>> +    uint64_t iotlb_val;
>> +
>> +    /* IOTLB Invalidate Register: Global flush (VT-d spec Section 6.5.1.2). */
>> +    iotlb_val = VTD_TLB_IVT | VTD_TLB_GLOBAL_FLUSH;
>> +    qtest_writeq(qts, iommu_base + DMAR_IOTLB_REG, iotlb_val);
>> +
>> +    /* Wait for IVT bit to clear. */
>> +    qvtd_wait_for_bitsq(qts, iommu_base + DMAR_IOTLB_REG,
>> +                        VTD_TLB_IVT, false);
>> +}
>> +
>> +static void qvtd_clear_memory_regions(QTestState *qts)
>> +{
>> +    /* Clear root table. */
>> +    qtest_memset(qts, QVTD_ROOT_TABLE_BASE, 0, 4096);
>> +
>> +    /* Clear context table. */
>> +    qtest_memset(qts, QVTD_CONTEXT_TABLE_BASE, 0, 4096);
>> +
>> +    /* Clear all page table levels (4 levels * 4KB each = 16KB). */
>> +    qtest_memset(qts, QVTD_PT_L4_BASE, 0, 16384);
>> +}
>> +
>> +void qvtd_program_regs(QTestState *qts, uint64_t iommu_base)
>> +{
>> +    uint32_t gcmd;
>> +
>> +    /* 1. Disable translation (VT-d spec Section 11.4.4). */
>> +    gcmd = qtest_readl(qts, iommu_base + DMAR_GCMD_REG);
>> +    gcmd &= ~VTD_GCMD_TE;
>> +    qtest_writel(qts, iommu_base + DMAR_GCMD_REG, gcmd);
>> +
>> +    /* Wait for TES to clear. */
>> +    qvtd_wait_for_bitsl(qts, iommu_base + DMAR_GSTS_REG,
>> +                        VTD_GSTS_TES, false);
>> +
>> +    /* 2. Program root table address (VT-d spec Section 11.4.5). */
>> +    qtest_writeq(qts, iommu_base + DMAR_RTADDR_REG, QVTD_ROOT_TABLE_BASE);
>> +
>> +    /* 3. Set root table pointer (VT-d spec Section 6.6). */
>> +    gcmd = qtest_readl(qts, iommu_base + DMAR_GCMD_REG);
>> +    gcmd |= VTD_GCMD_SRTP;
>> +    qtest_writel(qts, iommu_base + DMAR_GCMD_REG, gcmd);
>> +
>> +    /* Wait for RTPS. */
>> +    qvtd_wait_for_bitsl(qts, iommu_base + DMAR_GSTS_REG,
>> +                        VTD_GSTS_RTPS, true);
>> +
>> +    /* Invalidate context cache after setting root table pointer. */
>> +    qvtd_invalidate_context_cache(qts, iommu_base);
>> +
>> +    /* 4. Unmask fault event interrupt to avoid warning messages. */
>> +    qtest_writel(qts, iommu_base + DMAR_FECTL_REG, 0);
>> +
>> +    /* NOTE: Translation is NOT enabled here - caller must enable after building structures. */
>> +}
>> +
>> +uint32_t qvtd_build_translation(QTestState *qts, QVTDTransMode mode,
>> +                                uint16_t sid, uint16_t domain_id,
>> +                                uint64_t iova, uint64_t pa)
>> +{
>> +    uint8_t bus = (sid >> 8) & 0xff;
>> +    const char *mode_str = (mode == QVTD_TM_LEGACY_PT) ?
>> +                           "Pass-Through" : "Translated";
>> +
>> +    g_test_message("Begin of construction: IOVA=0x%llx PA=0x%llx "
>> +                   "mode=%s domain_id=%u ===",
>> +                   (unsigned long long)iova, (unsigned long long)pa,
>> +                   mode_str, domain_id);
>> +
>> +    /* Build root entry */
>> +    qvtd_build_root_entry(qts, bus, QVTD_CONTEXT_TABLE_BASE);
>> +
>> +    /* Build context entry */
>> +    if (mode == QVTD_TM_LEGACY_PT) {
>> +        /* Pass-through mode: no page tables needed */
>> +        qvtd_build_context_entry(qts, sid, mode, domain_id, 0);
>> +        g_test_message("End of construction: identity mapping to PA=0x%llx ===",
>> +                       (unsigned long long)pa);
>> +    } else {
>> +        /* Translated mode: build 4-level page tables */
>> +        qvtd_setup_translation_tables(qts, iova, pa, QVTD_TM_LEGACY_TRANS);
>> +        qvtd_build_context_entry(qts, sid, mode, domain_id, QVTD_PT_L4_BASE);
>> +        g_test_message("End of construction: mapped IOVA=0x%llx -> PA=0x%llx ===",
>> +                       (unsigned long long)iova, (unsigned long long)pa);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +uint32_t qvtd_setup_and_enable_translation(QVTDTestContext *ctx)
>> +{
>> +    uint32_t gcmd;
>> +
>> +    /* Clear memory regions once during setup */
>> +    qvtd_clear_memory_regions(ctx->qts);
>> +
>> +    /* Program IOMMU registers (sets up root table pointer) */
>> +    qvtd_program_regs(ctx->qts, ctx->iommu_base);
>> +
>> +    /* Build translation structures AFTER clearing memory */
>> +    ctx->trans_status = qvtd_build_translation(ctx->qts, ctx->config.trans_mode,
>> +                                               ctx->sid, ctx->config.domain_id,
>> +                                               ctx->config.dma_iova,
>> +                                               ctx->config.dma_pa);
>> +    if (ctx->trans_status != 0) {
>> +        return ctx->trans_status;
>> +    }
>> +
>> +    /* Invalidate caches using register-based invalidation */
>> +    qvtd_invalidate_context_cache(ctx->qts, ctx->iommu_base);
>> +    qvtd_invalidate_iotlb(ctx->qts, ctx->iommu_base);
>> +
>> +    /* Enable translation AFTER building structures and invalidating caches */
>> +    gcmd = qtest_readl(ctx->qts, ctx->iommu_base + DMAR_GCMD_REG);
>> +    gcmd |= VTD_GCMD_TE;
>> +    qtest_writel(ctx->qts, ctx->iommu_base + DMAR_GCMD_REG, gcmd);
>> +
>> +    /* Wait for TES */
>> +    qvtd_wait_for_bitsl(ctx->qts, ctx->iommu_base + DMAR_GSTS_REG,
>> +                        VTD_GSTS_TES, true);
>> +
>> +    return 0;
>> +}
>> +
>> +uint32_t qvtd_trigger_dma(QVTDTestContext *ctx)
> This function duplicates the logic in qos_iommu_testdev_trigger_dma().
> The SMMUv3 helper uses the common qos-iommu-testdev infrastructure with
> callback functions (setup_fn, attrs_fn, validate_fn, report_fn).
> 
> I'd suggest refactoring to use qos_iommu_testdev_single_translation()
> instead, similar to how qsmmu_run_translation_case() does it in
> qos-smmuv3.c
> 
> Thanks,
> Chao
Thank you. The root cause of this issue is the same as the first review.
I will port my functionality following the coding style of the latest 
iommu-testdev version in v2.

Thanks,
Fengyuan

>> +{
>> +    uint64_t iova = ctx->config.dma_iova;
>> +    uint32_t len = ctx->config.dma_len;
>> +    uint32_t result, attrs_val;
>> +    const char *mode_str = (ctx->config.trans_mode == QVTD_TM_LEGACY_PT) ?
>> +                           "Pass-Through" : "Translated";
>> +
>> +    /* Write IOVA low 32 bits */
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_GVA_LO, (uint32_t)iova);
>> +
>> +    /* Write IOVA high 32 bits */
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_GVA_HI, (uint32_t)(iova >> 32));
>> +
>> +    /* Write DMA length */
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_LEN, len);
>> +
>> +    /* Build and write DMA attributes with BDF (PASID=0 for Legacy mode) */
>> +    attrs_val = qvtd_build_dma_attrs(ctx->sid, 0);
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_ATTRS, attrs_val);
>> +
>> +    /* Arm DMA by writing 1 to doorbell */
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_DBELL, ITD_DMA_DBELL_ARM);
>> +
>> +    /* Trigger DMA by reading from triggering register */
>> +    qpci_io_readl(ctx->dev, ctx->bar, ITD_REG_DMA_TRIGGERING);
>> +
>> +    /* Poll for completion */
>> +    ctx->dma_result = ITD_DMA_RESULT_BUSY;
>> +    for (int attempt = 0; attempt < QVTD_POLL_MAX_RETRIES; attempt++) {
>> +        result = qpci_io_readl(ctx->dev, ctx->bar, ITD_REG_DMA_RESULT);
>> +        if (result != ITD_DMA_RESULT_BUSY) {
>> +            ctx->dma_result = result;
>> +            break;
>> +        }
>> +        g_usleep(QVTD_POLL_DELAY_US);
>> +    }
>> +
>> +    if (ctx->dma_result == ITD_DMA_RESULT_BUSY) {
>> +        ctx->dma_result = ITD_DMA_ERR_TX_FAIL;
>> +        g_test_message("-> DMA timeout detected, forcing failure");
>> +    }
>> +
>> +    if (ctx->dma_result == 0) {
>> +        g_test_message("-> DMA succeeded: mode=%s", mode_str);
>> +    } else {
>> +        g_test_message("-> DMA failed: mode=%s result=0x%x",
>> +                       mode_str, ctx->dma_result);
>> +    }
>> +
>> +    return ctx->dma_result;
>> +}
>> +
>> +void qvtd_cleanup_translation(QVTDTestContext *ctx)
>> +{
>> +    uint8_t bus = (ctx->sid >> 8) & 0xff;
>> +    uint8_t devfn = ctx->sid & 0xff;
>> +    uint64_t root_entry_addr = QVTD_ROOT_TABLE_BASE + (bus * 16);
>> +    uint64_t context_entry_addr = QVTD_CONTEXT_TABLE_BASE + (devfn * 16);
>> +    uint32_t gcmd;
>> +
>> +    /* Disable translation before tearing down the structures */
>> +    gcmd = qtest_readl(ctx->qts, ctx->iommu_base + DMAR_GCMD_REG);
>> +    if (gcmd & VTD_GCMD_TE) {
>> +        gcmd &= ~VTD_GCMD_TE;
>> +        qtest_writel(ctx->qts, ctx->iommu_base + DMAR_GCMD_REG, gcmd);
>> +        qvtd_wait_for_bitsl(ctx->qts, ctx->iommu_base + DMAR_GSTS_REG,
>> +                            VTD_GSTS_TES, false);
>> +    }
>> +
>> +    /* Clear context entry */
>> +    qtest_writeq(ctx->qts, context_entry_addr, 0);
>> +    qtest_writeq(ctx->qts, context_entry_addr + 8, 0);
>> +
>> +    /* Clear root entry */
>> +    qtest_writeq(ctx->qts, root_entry_addr, 0);
>> +    qtest_writeq(ctx->qts, root_entry_addr + 8, 0);
>> +
>> +    /* Invalidate caches using register-based invalidation */
>> +    qvtd_invalidate_context_cache(ctx->qts, ctx->iommu_base);
>> +    qvtd_invalidate_iotlb(ctx->qts, ctx->iommu_base);
>> +}
>> +
>> +bool qvtd_validate_test_result(QVTDTestContext *ctx)
>> +{
>> +    uint32_t expected = qvtd_expected_dma_result(ctx);
>> +    bool passed = (ctx->dma_result == expected);
>> +    bool mem_ok = true;
>> +
>> +    g_test_message("-> Validating result: expected=0x%x actual=0x%x",
>> +                   expected, ctx->dma_result);
>> +
>> +    if (passed && expected == 0) {
>> +        mem_ok = qvtd_validate_dma_memory(ctx);
>> +        g_test_message("-> Memory validation %s at PA=0x%llx",
>> +                       mem_ok ? "passed" : "failed",
>> +                       (unsigned long long)ctx->config.dma_pa);
>> +        passed = mem_ok;
>> +    }
>> +
>> +    return passed;
>> +}
>> +
>> +void qvtd_single_translation(QVTDTestContext *ctx)
>> +{
>> +    uint32_t config_result;
>> +    bool test_passed;
>> +
>> +    /* Configure Intel IOMMU translation */
>> +    config_result = qvtd_setup_and_enable_translation(ctx);
>> +    if (config_result != 0) {
>> +        g_test_message("Configuration failed: mode=%u status=0x%x",
>> +                       ctx->config.trans_mode, config_result);
>> +    }
>> +    g_assert_cmpint(config_result, ==, 0);
>> +
>> +    /* Trigger DMA operation */
>> +    qvtd_trigger_dma(ctx);
>> +
>> +    /* Validate test result */
>> +    test_passed = qvtd_validate_test_result(ctx);
>> +    g_assert_true(test_passed);
>> +
>> +    /* Clean up translation state to prepare for the next test */
>> +    qvtd_cleanup_translation(ctx);
>> +}
>> +
>> +void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
>> +                               QPCIBar bar, uint64_t iommu_base,
>> +                               const QVTDTestConfig *cfg)
>> +{
>> +    /* Initialize test memory */
>> +    qtest_memset(qts, cfg->dma_pa, 0x00, cfg->dma_len);
>> +
>> +    /* Create test context on stack */
>> +    QVTDTestContext ctx = {
>> +        .qts = qts,
>> +        .dev = dev,
>> +        .bar = bar,
>> +        .iommu_base = iommu_base,
>> +        .config = *cfg,
>> +        .trans_status = 0,
>> +        .dma_result = 0,
>> +        .sid = qvtd_calc_sid(dev),
>> +    };
>> +
>> +    /* Execute the test using existing single_translation logic */
>> +    qvtd_single_translation(&ctx);
>> +
>> +    /* Report results */
>> +    g_test_message("--> Test completed: mode=%u domain_id=%u "
>> +                   "status=0x%x result=0x%x",
>> +                   cfg->trans_mode, cfg->domain_id,
>> +                   ctx.trans_status, ctx.dma_result);
>> +}
>> +
>> +void qvtd_translation_batch(const QVTDTestConfig *configs, size_t count,
>> +                            QTestState *qts, QPCIDevice *dev,
>> +                            QPCIBar bar, uint64_t iommu_base)
>> +{
>> +    for (size_t i = 0; i < count; i++) {
>> +        g_test_message("=== Running test %zu/%zu ===", i + 1, count);
>> +        qvtd_run_translation_case(qts, dev, bar, iommu_base, &configs[i]);
>> +    }
>> +}
>> diff --git a/tests/qtest/libqos/qos-intel-iommu.h b/tests/qtest/libqos/qos-intel-iommu.h
>> new file mode 100644
>> index 0000000000..dab5d4df63
>> --- /dev/null
>> +++ b/tests/qtest/libqos/qos-intel-iommu.h
>> @@ -0,0 +1,299 @@
>> +/*
>> + * QOS Intel IOMMU (VT-d) Module
>> + *
>> + * This module provides Intel IOMMU-specific helper functions for libqos tests,
>> + * encapsulating VT-d setup, assertion, and cleanup operations.
>> + *
>> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef QTEST_LIBQOS_INTEL_IOMMU_H
>> +#define QTEST_LIBQOS_INTEL_IOMMU_H
>> +
>> +#include "hw/misc/iommu-testdev.h"
>> +#include "hw/i386/intel_iommu_internal.h"
>> +
>> +/*
>> + * Intel IOMMU MMIO register base. This is the standard Q35 IOMMU address.
>> + */
>> +#define Q35_IOMMU_BASE            0xfed90000ULL
>> +
>> +/*
>> + * Guest memory layout for IOMMU structures.
>> + * All structures are placed in guest physical memory inside the 512MB RAM.
>> + * Using 256MB mark (0x10000000) as base to ensure all structures fit in RAM.
>> + */
>> +#define QVTD_MEM_BASE             0x10000000ULL
>> +
>> +/* Root Entry Table: 256 entries * 16 bytes = 4KB */
>> +#define QVTD_ROOT_TABLE_BASE      (QVTD_MEM_BASE + 0x00000000)
>> +
>> +/* Context Entry Table: 256 entries * 16 bytes = 4KB per bus */
>> +#define QVTD_CONTEXT_TABLE_BASE   (QVTD_MEM_BASE + 0x00001000)
>> +
>> +/* Page Tables: 4-level hierarchy for 48-bit address translation */
>> +#define QVTD_PT_L4_BASE           (QVTD_MEM_BASE + 0x00010000)  /* PML4 */
>> +#define QVTD_PT_L3_BASE           (QVTD_MEM_BASE + 0x00011000)  /* PDPT */
>> +#define QVTD_PT_L2_BASE           (QVTD_MEM_BASE + 0x00012000)  /* PD */
>> +#define QVTD_PT_L1_BASE           (QVTD_MEM_BASE + 0x00013000)  /* PT */
>> +
>> +/* Invalidation Queue: 256 entries * 16 bytes = 4KB */
>> +#define QVTD_INV_QUEUE_BASE       (QVTD_MEM_BASE + 0x00020000)
>> +
>> +/* Test IOVA and target physical address */
>> +#define QVTD_TEST_IOVA            0x0000008080604000ULL
>> +#define QVTD_TEST_PA              (QVTD_MEM_BASE + 0x00100000)
>> +
>> +/*
>> + * Translation modes supported by Intel IOMMU
>> + */
>> +typedef enum QVTDTransMode {
>> +    QVTD_TM_LEGACY_PT,      /* Legacy pass-through mode */
>> +    QVTD_TM_LEGACY_TRANS,   /* Legacy translated mode (4-level paging) */
>> +} QVTDTransMode;
>> +
>> +/*
>> + * Test configuration structure
>> + */
>> +typedef struct QVTDTestConfig {
>> +    QVTDTransMode trans_mode;     /* Translation mode */
>> +    uint64_t dma_iova;            /* DMA IOVA address for testing */
>> +    uint64_t dma_pa;              /* Target physical address */
>> +    uint32_t dma_len;             /* DMA length for testing */
>> +    uint32_t expected_result;     /* Expected DMA result */
>> +    uint16_t domain_id;           /* Domain ID for this test */
>> +} QVTDTestConfig;
>> +
>> +/*
>> + * Test context structure
>> + */
>> +typedef struct QVTDTestContext {
>> +    QTestState *qts;              /* QTest state handle */
>> +    QPCIDevice *dev;              /* PCI device handle */
>> +    QPCIBar bar;                  /* PCI BAR for MMIO access */
>> +    QVTDTestConfig config;        /* Test configuration */
>> +    uint64_t iommu_base;          /* Intel IOMMU base address */
>> +    uint32_t trans_status;        /* Translation configuration status */
>> +    uint32_t dma_result;          /* DMA operation result */
>> +    uint16_t sid;                 /* Source ID (bus:devfn) */
>> +} QVTDTestContext;
>> +
>> +/*
>> + * qvtd_setup_and_enable_translation - Complete translation setup and enable
>> + *
>> + * @ctx: Test context containing configuration and device handles
>> + *
>> + * Returns: Translation status (0 = success, non-zero = error)
>> + *
>> + * This function performs the complete translation setup sequence:
>> + * 1. Builds all required VT-d structures (root entry, context entry, page tables)
>> + * 2. Programs IOMMU registers
>> + * 3. Invalidates caches
>> + * 4. Enables translation
>> + */
>> +uint32_t qvtd_setup_and_enable_translation(QVTDTestContext *ctx);
>> +
>> +/*
>> + * qvtd_build_translation - Build Intel IOMMU translation structures
>> + *
>> + * @qts: QTest state handle
>> + * @mode: Translation mode (pass-through or translated)
>> + * @sid: Source ID (bus:devfn)
>> + * @domain_id: Domain ID
>> + * @iova: IOVA address for logging purposes
>> + * @pa: Physical address backed by the mapping
>> + *
>> + * Returns: Build status (0 = success, non-zero = error)
>> + *
>> + * Constructs all necessary VT-d translation structures in guest memory:
>> + * - Root Entry for the device's bus
>> + * - Context Entry for the device
>> + * - Complete 4-level page table hierarchy (if translated mode)
>> + */
>> +uint32_t qvtd_build_translation(QTestState *qts, QVTDTransMode mode,
>> +                                uint16_t sid, uint16_t domain_id,
>> +                                uint64_t iova, uint64_t pa);
>> +
>> +/*
>> + * qvtd_program_regs - Program Intel IOMMU registers
>> + *
>> + * @qts: QTest state handle
>> + * @iommu_base: IOMMU base address
>> + *
>> + * Programs IOMMU registers with the following sequence:
>> + * 1. Disable translation
>> + * 2. Program root table address
>> + * 3. Set root table pointer
>> + * 4. Unmask fault event interrupt
>> + *
>> + * Note: This function does NOT clear memory regions or enable translation.
>> + * Memory clearing should be done once during test setup via qvtd_clear_memory_regions().
>> + * Translation is enabled separately after building all structures.
>> + */
>> +void qvtd_program_regs(QTestState *qts, uint64_t iommu_base);
>> +
>> +/*
>> + * qvtd_trigger_dma - Trigger DMA operation via iommu-testdev
>> + *
>> + * @ctx: Test context
>> + *
>> + * Returns: DMA result code
>> + *
>> + * Programs iommu-testdev BAR0 registers to trigger a DMA operation:
>> + * 1. Write IOVA address (GVA_LO/HI)
>> + * 2. Write DMA length
>> + * 3. Arm DMA (write to DBELL)
>> + * 4. Trigger DMA (read from TRIGGERING)
>> + * 5. Poll for completion (read DMA_RESULT)
>> + */
>> +uint32_t qvtd_trigger_dma(QVTDTestContext *ctx);
>> +
>> +/*
>> + * qvtd_cleanup_translation - Clean up translation configuration
>> + *
>> + * @ctx: Test context containing configuration and device handles
>> + *
>> + * Clears all translation structures and invalidates IOMMU caches.
>> + */
>> +void qvtd_cleanup_translation(QVTDTestContext *ctx);
>> +
>> +/*
>> + * qvtd_validate_test_result - Validate actual vs expected test result
>> + *
>> + * @ctx: Test context containing actual and expected results
>> + *
>> + * Returns: true if test passed (actual == expected), false otherwise
>> + *
>> + * Compares the actual DMA result with the expected result and logs
>> + * the comparison for debugging purposes.
>> + */
>> +bool qvtd_validate_test_result(QVTDTestContext *ctx);
>> +
>> +/*
>> + * qvtd_setup_translation_tables - Setup complete VT-d page table hierarchy
>> + *
>> + * @qts: QTest state handle
>> + * @iova: Input Virtual Address to translate
>> + * @pa: Physical address to map to
>> + * @mode: Translation mode
>> + *
>> + * This function builds the complete 4-level page table structure for translating
>> + * the given IOVA to PA through Intel VT-d. The structure is:
>> + * - PML4 (Level 4): IOVA bits [47:39]
>> + * - PDPT (Level 3): IOVA bits [38:30]
>> + * - PD (Level 2): IOVA bits [29:21]
>> + * - PT (Level 1): IOVA bits [20:12]
>> + * - Page offset: IOVA bits [11:0]
>> + *
>> + * The function writes all necessary Page Table Entries (PTEs) to guest
>> + * memory using qtest_writeq(), setting up the complete translation path
>> + * that the VT-d hardware will traverse during DMA operations.
>> + */
>> +void qvtd_setup_translation_tables(QTestState *qts, uint64_t iova,
>> +                                   uint64_t pa, QVTDTransMode mode);
>> +
>> +/*
>> + * qvtd_expected_dma_result - Calculate expected DMA result
>> + *
>> + * @ctx: Test context containing configuration
>> + *
>> + * Returns: Expected DMA result code
>> + *
>> + * This function acts as a test oracle, calculating the expected DMA result
>> + * based on the test configuration. It centralizes validation logic for
>> + * different scenarios (pass-through vs. translated, fault conditions).
>> + */
>> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx);
>> +
>> +/*
>> + * qvtd_build_dma_attrs - Build DMA attributes for an Intel VT-d DMA request
>> + *
>> + * @bdf: PCI requester ID encoded as Bus[15:8]/Device[7:3]/Function[2:0]
>> + * @pasid: PASID tag (0 for legacy requests, non-zero for scalable mode)
>> + *
>> + * Returns: Value to program into iommu-testdev's DMA_ATTRS register
>> + *
>> + * The iommu-testdev attribute register mirrors Intel VT-d request metadata:
>> + *   - bits[2:0] keep the generic iommu-testdev fields (secure + space)
>> + *   - bit[4] selects legacy (0) vs. scalable (1) transactions
>> + *   - bits[23:8] carry the requester ID as defined in the VT-d spec
>> + *   - bits[31:24] carry the PASID (limited to 8 bits in QEMU, matching
>> + *     the MemTxAttrs::pid width and ECAP.PSS advertisement)
>> + *
>> + * The helper validates the BDF layout (bus <= 255, device <= 31, function <= 7)
>> + * and makes sure PASID fits in the supported width before returning the value.
>> + */
>> +uint32_t qvtd_build_dma_attrs(uint16_t bdf, uint32_t pasid);
>> +
>> +/*
>> + * High-level test execution functions
>> + */
>> +
>> +/*
>> + * qvtd_single_translation - Execute single translation test
>> + *
>> + * @ctx: Test context
>> + *
>> + * Performs a complete test cycle:
>> + * 1. Setup translation structures
>> + * 2. Trigger DMA operation
>> + * 3. Validate results
>> + * 4. Cleanup
>> + */
>> +void qvtd_single_translation(QVTDTestContext *ctx);
>> +
>> +/*
>> + * qvtd_run_translation_case - Execute a single Intel VT-d translation test
>> + *
>> + * @qts: QTestState for the test
>> + * @dev: PCI device (iommu-testdev)
>> + * @bar: BAR0 of iommu-testdev
>> + * @iommu_base: Base address of Intel IOMMU MMIO registers
>> + * @cfg: Test configuration
>> + *
>> + * High-level wrapper that creates test context internally and executes
>> + * a single translation test case. This provides a simpler API compared
>> + * to qvtd_single_translation() which requires manual context initialization.
>> + *
>> + * This function is analogous to qriommu_run_translation_case() in the
>> + * RISC-V IOMMU test framework, providing a consistent API across different
>> + * IOMMU architectures.
>> + *
>> + * Example usage:
>> + *   QVTDTestConfig cfg = {
>> + *       .trans_mode = QVTD_TM_LEGACY_PT,
>> + *       .domain_id = 1,
>> + *       .dma_iova = 0x40100000,
>> + *       .dma_pa = 0x40100000,
>> + *       .dma_len = 4,
>> + *   };
>> + *   qvtd_run_translation_case(qts, dev, bar, iommu_base, &cfg);
>> + */
>> +void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
>> +                               QPCIBar bar, uint64_t iommu_base,
>> +                               const QVTDTestConfig *cfg);
>> +
>> +/*
>> + * qvtd_translation_batch - Execute batch of translation tests
>> + *
>> + * @configs: Array of test configurations
>> + * @count: Number of configurations
>> + * @qts: QTest state handle
>> + * @dev: PCI device handle
>> + * @bar: PCI BAR for MMIO access
>> + * @iommu_base: IOMMU base address
>> + *
>> + * Executes multiple translation tests in sequence, each with its own
>> + * configuration. Useful for testing different translation modes and
>> + * scenarios in a single test run.
>> + *
>> + * This function now uses qvtd_run_translation_case() internally to
>> + * reduce code duplication.
>> + */
>> +void qvtd_translation_batch(const QVTDTestConfig *configs, size_t count,
>> +                            QTestState *qts, QPCIDevice *dev,
>> +                            QPCIBar bar, uint64_t iommu_base);
>> +
>> +#endif /* QTEST_LIBQOS_INTEL_IOMMU_H */
>> -- 
>> 2.39.5
>>


