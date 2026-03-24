Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01750F54AD6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 23:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5BVp-0002Ig-M1; Tue, 24 Mar 2026 19:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w5BVo-0002II-4t
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 19:50:16 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w5BVm-0006VN-BV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 19:50:15 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c742d4df00cso144330a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774396212; x=1775001012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYU3SCDMR6HSiuSZCiXJl/RsRG8wy61Pclyi/UR2lDo=;
 b=BtXEn2qfadWZO3nK0C6Scd5dmT041qRiJ7vfRXog4ScW7vBbhPR70K0UrXp6S8Zkzp
 4spGSfVck7wVp2DKmhrTlyGmCSiih9miTyVjW2ZkDKm7nOO42L9RcaHjhyrgo0I+9LNy
 LyjvDeTkEUMnkjbbWJIabnizX7GIFIRlh6i03+YX5Lhw1pDigkllbctW9+3kPjHeAMEw
 GiqbRsAN3ZJJO3W+CFXgkDIZfcIrNIviWRYOPO6bsZ3ZSaZpZ9z16ll9jqQXEOk+VQKS
 SZl+Z9ayXkSrkJuisdd2IYLsF4BGl4NKGSZljOcmT738aws6P5e4a932VvftBGh9Mqew
 Xg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774396212; x=1775001012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYU3SCDMR6HSiuSZCiXJl/RsRG8wy61Pclyi/UR2lDo=;
 b=L+bKbjDvMxnmO1rbfiEdmNKEuNBOCpyfMj2mxVgiLA4AFZ+pzf+LpLkwQkE9PpdyWn
 vseslc6lpSAwNN2Wgpne2Ys3dSS8KAmt6ODZ8p/fgba9HgSrcrhvWR/Dmr6CbYvtJnUx
 FBU3eeMYOaLuBvAfMub1ptY8fsLdHiJ3AAOKxbOsd5Em6Jh/o2ydjAAKfjRaDDcFI614
 bENCZy/PqV1tFSr1lyBjAUAXDxuxOKbwuEa1kc8FQXo9ce6CG2SmYCrQLuKnu5ugvTq7
 Jt0oKEIedOSzhJLRM68mOVGVLK7UyflMAiv34oaJTizCxZ4Ggh4KpGCt8AfbmAdE7rGL
 3C6Q==
X-Gm-Message-State: AOJu0YzXaRcJvUvCJ26Y3DpgIZtrqL7MliNx7sc6X5DSmNHZTzZ2/xet
 /V3+JXX6qfEYYu4O69u/nkZ+o8gBFvyAPmQBvs4tc289nqpENOaAlSAp
X-Gm-Gg: ATEYQzwgi6BM3UtuZhV+icbE44hiD/Ip7jsS1OktlG9v7wkSYxrVm5CNj0J3ikZ2yfv
 7REOBeszDTNj1YnFeW9Byi39BFmCp2ZfBlF+EDv3rICB+IATK/HvvmNSMA3glnp6BFaD8kbIg36
 ZuspuU40Q1MTdbyYMr8OjNF5/nHvrC5I1zPx45xG93vRNQYGn3J0dtCb6drAgUBqcFGewkO1Wwt
 H5gs25lkhZNrVZVCqeJ+8+MI5rUfTnsYOZerlptvUpro+f96ASrX6UKhGIVKuy72+9zcF5T8sef
 Tat/MzT2/sqa537On5oKtbTiEDas4KA4LKzZ4+QKT6RohxRpcy86zLiV/1XsKjwUZU09OAwjy7n
 V5bR7owOn8e2FLX4aeN2kgA9GwE1sbHWVK/rZKxpVsXJQSLWrrTNNanTzgIPBR5ea75VmfSzCLK
 5kxeeB2K0+aoskvR2vfI3aYRL80Au1xilB4j8FyXGd2mjcH6qZnN6uGB8d8kB6vOUqRj78oqop
X-Received: by 2002:a17:903:40ca:b0:2b0:4f16:22f7 with SMTP id
 d9443c01a7336-2b0a4e1302emr47628855ad.16.1774396211898; 
 Tue, 24 Mar 2026 16:50:11 -0700 (PDT)
Received: from ?IPV6:240e:469:64e:26f:31b9:833e:80d3:35b3?
 ([240e:469:64e:26f:31b9:833e:80d3:35b3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516908sm196389605ad.1.2026.03.24.16.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 16:50:11 -0700 (PDT)
Message-ID: <dda1d80e-e2f7-4444-943c-b863d9314389@gmail.com>
Date: Wed, 25 Mar 2026 07:50:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tests/qtest/libqos: Add Intel IOMMU helper library
To: Tao Tang <tangtao1634@phytium.com.cn>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>
References: <cover.1773450180.git.15fengyuan@gmail.com>
 <75efb1c5f4088f449754ac05d0aaff4e70e8329f.1773450180.git.15fengyuan@gmail.com>
 <baefd7cd-3a4c-41cf-892e-a6002bc6418a@phytium.com.cn>
From: Fengyuan <15fengyuan@gmail.com>
In-Reply-To: <baefd7cd-3a4c-41cf-892e-a6002bc6418a@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=15fengyuan@gmail.com; helo=mail-pg1-x52d.google.com
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

Hi Tao,

On 3/24/2026 12:12 PM, Tao Tang wrote:
> Hi Fengyuan,
> 
> On 2026/3/14 09:11, Fengyuan Yu wrote:
>> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
>> ---
>>   MAINTAINERS                          |   6 +
>>   tests/qtest/libqos/meson.build       |   3 +
>>   tests/qtest/libqos/qos-intel-iommu.c | 454 +++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-intel-iommu.h | 191 +++++++++++
>>   4 files changed, 654 insertions(+)
>>   create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
>>   create mode 100644 tests/qtest/libqos/qos-intel-iommu.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 247799c817..876e00ff77 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -151,6 +151,9 @@ F: target/i386/meson.build
>>   F: tools/i386/
>>   F: tests/functional/i386/
>>   F: tests/functional/x86_64/
>> +F: tests/qtest/intel-iommu-test.c
>> +F: tests/qtest/libqos/qos-intel-iommu*
>> +F: tests/qtest/iommu-intel-test.c
>>   X86 VM file descriptor change on reset test
>>   M: Ani Sinha <anisinha@redhat.com>
>> @@ -4026,6 +4029,9 @@ F: hw/i386/intel_iommu_accel.*
>>   F: include/hw/i386/intel_iommu.h
>>   F: tests/functional/x86_64/test_intel_iommu.py
>>   F: tests/qtest/intel-iommu-test.c
>> +F: tests/qtest/libqos/qos-intel-iommu*
>> +F: tests/qtest/iommu-intel-test.c
>> +
>>   AMD-Vi Emulation
>>   M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
>> index 4a69acad0d..96f2fc48b4 100644
>> --- a/tests/qtest/libqos/meson.build
>> +++ b/tests/qtest/libqos/meson.build
>> @@ -73,6 +73,9 @@ endif
>>   if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
>>     libqos_srcs += files('riscv-iommu.c', 'qos-riscv-iommu.c')
>>   endif
>> +if config_all_devices.has_key('CONFIG_VTD')
>> +  libqos_srcs += files('qos-intel-iommu.c')
>> +endif
>>   if config_all_devices.has_key('CONFIG_TPCI200')
>>     libqos_srcs += files('tpci200.c')
>>   endif
>> diff --git a/tests/qtest/libqos/qos-intel-iommu.c b/tests/qtest/libqos/qos- 
>> intel-iommu.c
>> new file mode 100644
>> index 0000000000..b1baf5ea7c
>> --- /dev/null
>> +++ b/tests/qtest/libqos/qos-intel-iommu.c
>> @@ -0,0 +1,454 @@
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
>> +#include "hw/i386/intel_iommu_internal.h"
>> +#include "tests/qtest/libqos/pci.h"
>> +#include "qos-iommu-testdev.h"
>> +#include "qos-intel-iommu.h"
>> +
>> +#define QVTD_AW_48BIT_ENCODING    2
>> +
>> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx)
>> +{
>> +    return ctx->config.expected_result;
>> +}
>> +
>> +uint32_t qvtd_build_dma_attrs(void)
>> +{
>> +    /*
>> +     * VT-d obtains the Requester ID (Source ID) from PCI bus/devfn routing
>> +     * via pci_device_iommu_address_space(), not from DMA attributes.
>> +     *
>> +     * For scalable mode, QEMU maps MemTxAttrs.pid==0 to PCI_NO_PASID,
>> +     * then remaps PCI_NO_PASID to PASID_0 when root_scalable is set.
>> +     * So returning 0 here implicitly selects PASID=0, which matches
>> +     * the PASID entry we configure in qvtd_build_pasid_table_entry().
>> +     *
>> +     */
>> +    return 0;
>> +}
> 
> The comment is partially misleading.
> 
> The SID part is correct. But iommu-testdev does not program MemTxAttrs.pid( only 
> program .secure and .space now), so returning 0 here does not explicitly select 
> PASID=0. PASID_0 is reached implicitly via VT-d’s no-PASID handling fallback, 
> not via DMA_ATTRS.
> 
> I think the comment should be clarified to reflect this.  You may need check 
> whether the related logic runs as your expectations. Expanding the DMA_ATTRS in 
> iommu-testdev is open if you really need it.
> 
> 
> Thanks,
> 
> Tao
> 

Thanks for the review. The current iommu-testdev dma_attrs_cfg is somewhat 
ARM-centric — it only exposes secure, space, and space_valid, which are
primarily relevant to ARM TrustZone. For x86 VT-d, the missing piece is 
MemTxAttrs.pid. Currently we can only test PASID=0 via the
no-PASID fallback path. I'll fix the comment to clarify this in v3. 

  

Best regards, 

Fengyuan




