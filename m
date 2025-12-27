Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2DCE7AD7F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 05:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZMRT-0006nS-Vf; Sat, 27 Dec 2025 00:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vZMRQ-0006mj-R9; Sat, 27 Dec 2025 00:02:12 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vZMRO-00064w-6l; Sat, 27 Dec 2025 00:02:12 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHNVxFaE9pHwhMAg--.6730S2;
 Sat, 27 Dec 2025 13:01:57 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.232.145])
 by mail (Coremail) with SMTP id AQAAfwDnP+1DaE9phB0PAA--.13123S2;
 Sat, 27 Dec 2025 13:01:55 +0800 (CST)
Message-ID: <9388d28b-1c94-4863-b295-68eb84595501@phytium.com.cn>
Date: Sat, 27 Dec 2025 13:01:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 1/7] hw/arm/smmuv3: Extract common definitions to
 smmuv3-common.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-2-tangtao1634@phytium.com.cn>
 <1c56c2d4-d472-4ec7-b3f2-22c7b4e935fb@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <1c56c2d4-d472-4ec7-b3f2-22c7b4e935fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDnP+1DaE9phB0PAA--.13123S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAQBWlNmrIGFAAEsO
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGr1rZryDCFW8Zr1kJrWkWFg_yoW5XF4rp3
 Z3G3ZxKFWrGw1I9r1fZr4Svryaqrs5tr10yrW7W34fuwsIvrWIvF429w4qgFy8GrWfAr4j
 vF12qF1DW3WUJrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

On 2025/12/27 06:45, Philippe Mathieu-Daudé wrote:
> On 24/12/25 04:46, Tao Tang wrote:
>> Move register definitions, command enums, and Stream Table Entry (STE) /
>> Context Descriptor (CD) structure definitions from the internal header
>> hw/arm/smmuv3-internal.h to a new common header
>> include/hw/arm/smmuv3-common.h.
>>
>> This allows other components, such as generic SMMUv3 tests or test 
>> devices,
>> to utilize these definitions without including the specific SMMUv3 
>> device
>> internal state.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmuv3-internal.h       | 255 +------------------------------
>>   include/hw/arm/smmuv3-common.h | 268 +++++++++++++++++++++++++++++++++
>>   2 files changed, 269 insertions(+), 254 deletions(-)
>>   create mode 100644 include/hw/arm/smmuv3-common.h
>
>
>> --- /dev/null
>> +++ b/include/hw/arm/smmuv3-common.h
>> @@ -0,0 +1,268 @@
>> +/*
>> + * ARM SMMUv3 support - Common API
>> + *
>> + * Copyright (C) 2014-2016 Broadcom Corporation
>> + * Copyright (c) 2017 Red Hat, Inc.
>> + * Written by Prem Mallappa, Eric Auger
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_ARM_SMMUV3_COMMON_H
>> +#define HW_ARM_SMMUV3_COMMON_H
>> +
>> +/* Configuration Data */
>> +
>> +/* STE Level 1 Descriptor */
>> +typedef struct STEDesc {
>> +    uint32_t word[2];
>> +} STEDesc;
>> +
>> +/* CD Level 1 Descriptor */
>> +typedef struct CDDesc {
>> +    uint32_t word[2];
>> +} CDDesc;
>> +
>> +/* Stream Table Entry(STE) */
>> +typedef struct STE {
>> +    uint32_t word[16];
>> +} STE;
>> +
>> +/* Context Descriptor(CD) */
>> +typedef struct CD {
>> +    uint32_t word[16];
>> +} CD;
> Pre-existing: should these be QEMU_PACKED?


Thanks for the feedback.


I tried adding QEMU_PACKED to STEDesc/CDDesc/STE/CD in smmuv3-common.h, 
but that means some call sites need updates.

For example, with packed structs, this triggers 
-Waddress-of-packed-member (and becomes a build failure with -Werror):

     le32_to_cpus(&buf->word[i]); // smmu_get_ste function in 
hw/arm/smmuv3.c

It needs to be changed to something like:

     buf->word[i] = le32_to_cpu(buf->word[i]);


Do you prefer that I send an extra commit to fix all affected call sites 
and keep QEMU_PACKED, or should we instead drop QEMU_PACKED and add 
compile-time size checks, e.g.:

     QEMU_BUILD_BUG_ON(sizeof(STEDesc) != 8);
     QEMU_BUILD_BUG_ON(sizeof(CDDesc) != 8);
     QEMU_BUILD_BUG_ON(sizeof(STE) != 64);
     QEMU_BUILD_BUG_ON(sizeof(CD) != 64);

Best regards,

Tao


