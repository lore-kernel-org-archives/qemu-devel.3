Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB55DC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OZc-00071u-Tv; Thu, 03 Apr 2025 13:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0OZV-0006tB-JD
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:41:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0OZT-0001zy-Bp
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:41:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533FV2p8023220
 for <qemu-devel@nongnu.org>; Thu, 3 Apr 2025 17:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aXWrm3WjeGmEoBJiNQW4tZxJmXIIkHQGAxb9fM2F4Uk=; b=kTASrjy+quFAOoFH
 oojnMRX5cfWFAXd+Oscxeh7yUlt4c7Tk2nrV4R/OuOrDmm1iNk6OkzGgGA44OT4v
 gNVUJEscMlTViHtE9NjJ8H2l1Pyt+XTJPnnN/FMImuEANwuzqeUpNoSvFwtlW6CT
 39RnWE6kIKfyal4/g02UJrsfo2/HYRsyumGn8/ByjUqciNad1cvJXGKWKj7fwlAy
 0DMWUNjC8+NvUT7n8UNvkV1iKWrVtZ5SYRzMd2Urulj1xVU2T7KwpbKpAhvkraAn
 2QPNocgeYXNcQYE7ApufUiSxwTACxeZkALxA5aRODexUfiVXOEnUCiCVjkOgooqm
 zrEVjA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45sc2ytu6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:41:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff7aecba07so1148785a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743702092; x=1744306892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXWrm3WjeGmEoBJiNQW4tZxJmXIIkHQGAxb9fM2F4Uk=;
 b=SteHu8jvGEmbsmvk57PZl8MgTE1d4Y6fgRAAsWF/gdUrRH7pP7XBjLsggR7jUP8fLX
 Vhsqt4VgMI+dz/jgr2sGjQzQ98dSyZfQj9yqHXk0ScDGuzwiqcy+OEdeiAYQS8WxcTuJ
 cXMCoiof+t/ryZSgDZniBOhGuddK3p3INp6Mb3E6IXKcy9D9hHvCHI7e5SMk8NZTAwAP
 +doPl9yrXwVPP88O0DJgBjHK/h3Vb3tohhsdDCT3f4fqSwms8O/piwnrOgPbAkOOrizW
 Fve3qWzCGJVnMAUA0gwhYpbBWtvTJ5EFdoc4IQr24Sl9jFPAAxNXa6McV1M4SvoOwqxk
 j91g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPppvdTIUH8EC94PCIn6iCyryIfBwOk6NemNGlw2vWeLQ/xTqh9spl0ugWAReDdz9PRbPwjH7yX3kT@nongnu.org
X-Gm-Message-State: AOJu0YxyXrdho+tuKR3h6CbUQ8zQJunIcFiWqHC7WW/8F3/sIAHSH+7E
 k9C2Gupxe9M2Lm3a7cNzStNUzx4LRbhEbmZwyJ/Ncc69jarqxwAvGvzvtf1mBj+DE1KzbZRDKCW
 kEvaHpMR/+zSO98DwxaBmGoZSM2WlS+2a3h/fNP2Pc2wGYguMd45FvA==
X-Gm-Gg: ASbGncueSWXfGKf7ti6YPU9w1r2U7SbMQnSPK4F8fRcLC2qvFV0sRrpdjYuKPslBf9i
 uoqbFJcUyXWus9Qj7DyqGSuDmB2pDCQlFK4n3kMCCbdSC6IMJ+fYSp1Lz1nkQWjST+7h8dbv34j
 zlQRwJaDAuBGJT3vNr961n1wbzAH0ARrFj+UNYp1d3Mlir74sRwKpT7Z7ponozNi94LijpBh3KY
 7of8CZ3NaUa10nsmG8nPdm5nrZjaFoWAUSLOkylLcUSutVk7c2fcJbj4Fcvwi3gI9AEeDsIu/BN
 Yy7cO593FVAucUhDGwdjODNBDkITxWBTlU65g8+A48HcUjiWrI4076pwYzeY7zYWDqQgaGLaUA=
 =
X-Received: by 2002:a17:90b:2f10:b0:2ff:5a9d:9390 with SMTP id
 98e67ed59e1d1-306a487e35dmr503058a91.8.1743702092308; 
 Thu, 03 Apr 2025 10:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvmN2LOoMwzuy6TnwxYr6v8EbBm8Apzm9LFLHeMO9FK2iA56E3gv/n6B9S9e8Lkw1p8C8mYw==
X-Received: by 2002:a17:90b:2f10:b0:2ff:5a9d:9390 with SMTP id
 98e67ed59e1d1-306a487e35dmr503022a91.8.1743702091861; 
 Thu, 03 Apr 2025 10:41:31 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca4b200sm2008237a91.20.2025.04.03.10.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:41:31 -0700 (PDT)
Message-ID: <dbb8c1b8-a1b9-4b14-8418-602ccda5bb9d@oss.qualcomm.com>
Date: Thu, 3 Apr 2025 12:41:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/intc: Add l2vic interrupt controller
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Damien Hedde <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-2-brian.cain@oss.qualcomm.com>
 <3029782c-8d16-4428-9d6b-1c2fa8a7e755@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <3029782c-8d16-4428-9d6b-1c2fa8a7e755@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AMoviu7M c=1 sm=1 tr=0 ts=67eec850 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ABNU-bO0iG1_zgacNiEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: thM_D69Zyxe64qM83En69Es2krOMCxWm
X-Proofpoint-ORIG-GUID: thM_D69Zyxe64qM83En69Es2krOMCxWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_08,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030089
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


On 3/3/2025 6:26 AM, Philippe Mathieu-Daudé wrote:
> Hi Brian and Sid,
>
> On 1/3/25 18:20, Brian Cain wrote:
>> From: Sid Manning <sidneym@quicinc.com>
>>
>> Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                    |   2 +
>>   docs/devel/hexagon-l2vic.rst   |  59 +++++
>>   docs/devel/index-internals.rst |   1 +
>>   include/hw/intc/l2vic.h        |  37 +++
>>   hw/intc/l2vic.c                | 417 +++++++++++++++++++++++++++++++++
>>   hw/intc/Kconfig                |   3 +
>>   hw/intc/meson.build            |   2 +
>>   hw/intc/trace-events           |   4 +
>>   8 files changed, 525 insertions(+)
>>   create mode 100644 docs/devel/hexagon-l2vic.rst
>>   create mode 100644 include/hw/intc/l2vic.h
>>   create mode 100644 hw/intc/l2vic.c
>
>
>> diff --git a/hw/intc/l2vic.c b/hw/intc/l2vic.c
>> new file mode 100644
>> index 0000000000..9df6575214
>> --- /dev/null
>> +++ b/hw/intc/l2vic.c
>> @@ -0,0 +1,417 @@
>> +/*
>> + * QEMU L2VIC Interrupt Controller
>> + *
>> + * Arm PrimeCell PL190 Vector Interrupt Controller was used as a 
>> reference.
>> + * Copyright(c) 2020-2025 Qualcomm Innovation Center, Inc. All 
>> Rights Reserved.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/irq.h"
>> +#include "hw/sysbus.h"
>> +#include "migration/vmstate.h"
>> +#include "qemu/log.h"
>> +#include "qemu/module.h"
>> +#include "hw/intc/l2vic.h"
>> +#include "trace.h"
>> +
>> +#define L2VICA(s, n) (s[(n) >> 2])
>> +
>> +#define TYPE_L2VIC "l2vic"
>> +#define L2VIC(obj) OBJECT_CHECK(L2VICState, (obj), TYPE_L2VIC)
>
> Why not use OBJECT_DECLARE_SIMPLE_TYPE()?
>

Great suggestion, ty.  Will do.


>> +
>> +#define SLICE_MAX (L2VIC_INTERRUPT_MAX / 32)
>> +
>> +typedef struct L2VICState {
>> +    SysBusDevice parent_obj;
>> +
>> +    QemuMutex active;
>> +    MemoryRegion iomem;
>> +    MemoryRegion fast_iomem;
>> +    uint32_t level;
>> +    /*
>> +     * offset 0:vid group 0 etc, 10 bits in each group
>> +     * are used:
>> +     */
>> +    uint32_t vid_group[4];
>> +    uint32_t vid0;
>> +    /* Clear Status of Active Edge interrupt, not used: */
>> +    uint32_t int_clear[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* Enable interrupt source */
>> +    uint32_t int_enable[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* Clear (set to 0) corresponding bit in int_enable */
>> +    uint32_t int_enable_clear;
>> +    /* Set (to 1) corresponding bit in int_enable */
>> +    uint32_t int_enable_set;
>> +    /* Present for debugging, not used */
>> +    uint32_t int_pending[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* Generate an interrupt */
>> +    uint32_t int_soft;
>> +    /* Which enabled interrupt is active */
>> +    uint32_t int_status[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* Edge or Level interrupt */
>> +    uint32_t int_type[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* L2 interrupt group 0-3 0x600-0x7FF */
>> +    uint32_t int_group_n0[SLICE_MAX] QEMU_ALIGNED(16);
>> +    uint32_t int_group_n1[SLICE_MAX] QEMU_ALIGNED(16);
>> +    uint32_t int_group_n2[SLICE_MAX] QEMU_ALIGNED(16);
>> +    uint32_t int_group_n3[SLICE_MAX] QEMU_ALIGNED(16);
>> +    qemu_irq irq[8];
>> +} L2VICState;
>
> OBJECT_DECLARE_SIMPLE_TYPE(L2VICState, L2VIC)
>
>
>> +static inline bool vid_active(L2VICState *s)
>> +
>> +{
>> +    /* scan all 1024 bits in int_status arrary */
>> +    const int size = sizeof(s->int_status) * CHAR_BIT;
>> +    const int active_irq = find_first_bit((unsigned long 
>> *)s->int_status, size);
>
> Maybe this file could leverage the 32-bit bitops.h API:
>
> $ git grep bit32\( include/qemu/bitops.h
> include/qemu/bitops.h:38: * - Bits stored in an array of 'uint32_t': 
> set_bit32(), clear_bit32(), etc
> include/qemu/bitops.h:270:static inline void set_bit32(long nr, 
> uint32_t *addr)
> include/qemu/bitops.h:296:static inline void clear_bit32(long nr, 
> uint32_t *addr)
> include/qemu/bitops.h:322:static inline void change_bit32(long nr, 
> uint32_t *addr)
> include/qemu/bitops.h:335:static inline int test_and_set_bit32(long 
> nr, uint32_t *addr)
> include/qemu/bitops.h:350:static inline int test_and_clear_bit32(long 
> nr, uint32_t *addr)
> include/qemu/bitops.h:365:static inline int test_and_change_bit32(long 
> nr, uint32_t *addr)
> include/qemu/bitops.h:380:static inline int test_bit32(long nr, const 
> uint32_t *addr)
>

Okay - I will make this change.


There's several places in the code today where we do this L2VICA() macro 
to assign all of the bits to/from a single uint32_t word.  And if we 
take your and Taylor's suggestion to use the DECLARE_BITMAP32, we can 
probably change these to use bitmap_copy_with_{src,dst}_offset() 
instead, I think?


>> +    return ((active_irq != size)) ? true : false;
>> +}
>> +
>> +static bool l2vic_update(L2VICState *s, int irq)
>> +{
>> +    if (vid_active(s)) {
>> +        return true;
>> +    }
>> +
>> +    bool pending = test_bit(irq, (unsigned long *)s->int_pending);
>> +    bool enable = test_bit(irq, (unsigned long *)s->int_enable);
>> +    if (pending && enable) {
>> +        int vid = get_vid(s, irq);
>> +        set_bit(irq, (unsigned long *)s->int_status);
>> +        clear_bit(irq, (unsigned long *)s->int_pending);
>> +        clear_bit(irq, (unsigned long *)s->int_enable);
>> +        /* ensure the irq line goes low after going high */
>> +        s->vid0 = irq;
>> +        s->vid_group[get_vid(s, irq)] = irq;
>> +
>> +        /* already low: now call pulse */
>> +        /*     pulse: calls qemu_upper() and then qemu_lower()) */
>> +        qemu_irq_pulse(s->irq[vid + 2]);
>> +        trace_l2vic_delivered(irq, vid);
>> +        return true;
>> +    }
>> +    return false;
>> +}
>

