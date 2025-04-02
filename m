Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DA7C36010
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 01:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzmZl-0007i1-Ci; Tue, 01 Apr 2025 21:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tzmZj-0007hj-G7
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 21:07:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tzmZh-0000ux-Gr
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 21:07:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5320Zm7a000399
 for <qemu-devel@nongnu.org>; Wed, 2 Apr 2025 01:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7p/255aLCkhaJYy6wJJUtuOHgtcM/qDOdpKSHl8h9t4=; b=HUgmgSitj6O1OU6q
 G5GJGuAt67Pl2XzQ9dkPzZ8KDgCYG8pYhMynn3mbOecRp+6fHAuY0zBQ9RFaYmhn
 w4czMTKJgVmA06DmmAYKMoipi3JDwNt/jtIDsGKQHMnMhIP3+ClpRICVRYDJ+Xm0
 QIUxHAhzL7TTty6yJ6HDuGQmxOiD6vQI93+NR3r4/I2s/FCpDHEGIy6Is9TBSqfL
 HGaqzDISkcGzJ9X1iZxPrxlzmuHpQ5ZDdKdv3qqrYXFv6DA2PwvGa7nG+FmAoytO
 CuoLhDaE4lbgQKUyuzILwzTDP6vk3ftEs0FNSI5sE+5X/8T8y4AAXiFXNo8o1U5Z
 GoOvaA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qhydh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 01:07:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2254bdd4982so157021705ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 18:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743556037; x=1744160837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7p/255aLCkhaJYy6wJJUtuOHgtcM/qDOdpKSHl8h9t4=;
 b=cGaJzskpzYtE3UNXSjsPJlluyMvnwtBLksv3KGBSS5H0wnBf8n155kmfSCmnr+ePbS
 61cKFVOxfWn9DtYgCp3uNPquZQt6HpJEe+bC4PbyiEYKTJfItJhQoKxiGL5CC3durTju
 VB7UHWCne3iYg3j5jDrwxBiM9SfbAhw9G/e8LRhCMP3mzevZWg7QjFRAhnBy0Z0LzoAT
 eeH7t16IkiyWuxHuNTjJur2KoPKm16RIBfOh0SgH2szJEZDKJpwCWSDu7Dh/LnL7sdh5
 KUVtNbjESTeYHN2VnHT8Bj8SdWrzrb+U5O1Sob48kMLrvZuT+sIjEt1wNkW6aK7SDofX
 D/nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPso63vB3ZbsYmjyo8N6fW2iAxZQ27qBhAinqba54faFUYBpiJLLVSiUP5q6EXX2bx+rdDkwC+U6OL@nongnu.org
X-Gm-Message-State: AOJu0YyCKRECBHGj9C3e/AYGkJpeU47TVW04j3XjN2+6CKg2A/Z9OHv2
 dWoihM59LC9Uw/OYManYDKJUVZEtpr5848iqjDWxKUn75iveW9gmLoWXco7uw/iOMam7yYtV9KL
 UjqjU6nWikqkseB2VnZDHExCPvvrOg23mfB+mTha3YF6MG8+vYaQ84w==
X-Gm-Gg: ASbGncvKJ/J2TCUcB9fphET6vZwLzGED2zli2esSjxh6olAZmF5heg4mCgHINyCHXe2
 wWnJKNXOO8F1uUBrTgj35edd9QO6jhKysQlpcP2bePIhpaQ9gK9YPO1HJbFPRn7vP2DRY/TZ6pd
 ab6sW5AjUhnZZX1fEuQoKExka6n83wTne7WoxS4FNOG4XfFOmHpRRxbznY30VFeov1ufEKmFASC
 P9afZN9WWgsol56Oe6QNlW7iDN6zUgZyMShiv9iUxzKhrwMc37UAov8FEFBlTcGSof99wJrQYbJ
 upagPbpMuM8EdzGuJAOLuRBTf3PMmOU+mWr9HMFs+++Kfz7X7vuElqw4ecXuh/znPSI3907dlbW
 US5fg4YQlh92EZAE8
X-Received: by 2002:a05:6a00:244b:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-739c78c0ef0mr867675b3a.12.1743556037367; 
 Tue, 01 Apr 2025 18:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0c1Qlc1Rqst6PUuHwc7eRkY0lHU9VXeIixA95oog9i4v14m00cLH8BRo/6pRhhST002SA1g==
X-Received: by 2002:a05:6a00:244b:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-739c78c0ef0mr867640b3a.12.1743556036897; 
 Tue, 01 Apr 2025 18:07:16 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710ace02sm9683770b3a.150.2025.04.01.18.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 18:07:16 -0700 (PDT)
Message-ID: <6ea7476a-1544-4921-a385-e0d2eff6dcef@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 20:07:14 -0500
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
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ec8dc8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ABNU-bO0iG1_zgacNiEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AMncwz4DhkK6yd3PiN79zF8w8p6StMsE
X-Proofpoint-GUID: AMncwz4DhkK6yd3PiN79zF8w8p6StMsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020006
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

Will do, thanks.


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

I think your suggestion is based on the fact the state to hold the 
interrupt status (et al) were declared as uint32_t arrays. But in fact 
it might be clearer to take Taylor's suggestion from this thread and use 
DECLARE_BITMAP() instead?

In which case, perhaps the call to find_first_bit() could remain?


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

