Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642FAC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twohV-0005x3-DU; Mon, 24 Mar 2025 16:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1twohS-0005vh-LO
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:47:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1twohQ-0008WF-Bj
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:47:10 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OJ2WxO004762
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 20:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BYURPXPLDy15UtsC72a8k+p9oaylohP7zRQqJ3Titu0=; b=VQ3HKeceqyUYw7uS
 a8hwuuvTrN1tBp8Iwn3+O6h3yH1NvH7rRJuzYElMoYSxbjHjBlNV+/d7um6Pf5Kf
 Aba1tuQsHSSmGSML6ksyf6p/vKX/UtPPKoOfK6ELC0lNqJyLFAh/mEr1vwWCyjdH
 omSBcwgP5sn8V+qm4EiJ3+Rnf19Y7G5i+wMcwDAr+ixeVhYegGuUJbpl69RSgV8R
 Ufezkiav+JHurGcleA9ywLHuIdjEk5EyI9Y52V2asIpD2yQDqRa2B5FFM+3OtGzZ
 HPdYcZqWp6Uv5VVGrGuZ4BCX2bikVnhsG++e4h4LgaLfpacxiyoDnMQ0coAHl7Qv
 +YiKTQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79nnnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 20:47:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-224364f2492so71550715ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849224; x=1743454024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYURPXPLDy15UtsC72a8k+p9oaylohP7zRQqJ3Titu0=;
 b=NMIJCn6U9tq35MFfLYbND8YYWcXZ3hdpKNpIhlsM4s+iU7jhIKVEcCyTStwYXRhr7I
 A3lTPtDP2w7fvohYakh9o3F3D0lO7dwgTBOxP0huXXOzo1wRvCUuLiBgWUUBX0qgmzVl
 Z1Ky5/s1fBbJEaso1xbEYEz1e2XuxDNfOrC3auy+fBuJzVjMy/VYWqdGFvSQYZlqq5Du
 TPTochXq/NW7gKtXyv9WU1u4tdWTZCrhsiZpO2I+iRvUzBMXHM52mKiwwwkVbOelcEUW
 MoDFThduzJZ21eyjIHHzMWQDH5pY47C8xw0c3dXoBX5mXuCwPYDAXs4A/X+TZoPjReWf
 hRGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKGE1YsHR2yBX09+PbaySnZm4D0ccW0skxobv2IFBL87v5TelIiIm4H1UC1DZQY281/XHmQGxWcPr4@nongnu.org
X-Gm-Message-State: AOJu0YwXXPp5tGTzldzgrZdOL7PARi7Hf4r9A5cuO/pgIPLpD3EXXmNJ
 P51smjjGv3lYuk8TWj9GQo7wCVF+1RpI5k6XFkBYiGldBonhQwmszZ+nEnZfuPXs7DxKhfjINSk
 q0NQsEelNHcSF2rdc7UkeDqhEzN3CtwRcyQajF9bfnasHidNnItB8lw==
X-Gm-Gg: ASbGncsaue+g9OftpKI3jadUwh+4qQzlR5QHh9Y4oKPjYyYpp9qJsApGQAshqbZ5Hrc
 gnNDwHL0Aax0SAOJdpqpEovnC8mRPhP/Fw8MgF9Rtvia50xd64YxruMMdyCh8zeM4mTpljN/NLS
 B7JYZCWWx/VMgGrjDwK31CvyYN5NIbsVub2L0HNL5fjlPNx3147aPuSKFMOG39myQA90xXQv772
 18PqK4mYGwJd2mWRfSx21yhsKzCFXKr1Xtgf0SNGMIPQjOhs6mIUiDipqzNteO112Td/Q4OQCci
 5cxTLCLysArneJgaYoPqtybEUexcqyoiK9N4V6ToDE+JvIlL1H//dOVGJGr0JjPeagedlP0PS3J
 etDVQErhtVwaD1Kp2
X-Received: by 2002:a17:902:ce01:b0:223:faf5:c82 with SMTP id
 d9443c01a7336-22780c7e05fmr190200875ad.8.1742849224060; 
 Mon, 24 Mar 2025 13:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVNa6ArphlPS4TD6Adh+SGRIcP3rONGcrJNXxI16f/1RfTugvS1S4ymkvhoBFFZQGT5peGpw==
X-Received: by 2002:a17:902:ce01:b0:223:faf5:c82 with SMTP id
 d9443c01a7336-22780c7e05fmr190200465ad.8.1742849223424; 
 Mon, 24 Mar 2025 13:47:03 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf63610asm12722590a91.44.2025.03.24.13.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:47:03 -0700 (PDT)
Message-ID: <175353e4-051f-4402-9b1f-37e8695fd5c2@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 15:47:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/intc: Add l2vic interrupt controller
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Damien Hedde' <damien.hedde@dahe.fr>,
 'Paolo Bonzini' <pbonzini@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-2-brian.cain@oss.qualcomm.com>
 <04b401db9cf4$8a44ce80$9ece6b80$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <04b401db9cf4$8a44ce80$9ece6b80$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bOWhgrjfO_HfZrUMOXc_QHU-2VQdLQcz
X-Proofpoint-ORIG-GUID: bOWhgrjfO_HfZrUMOXc_QHU-2VQdLQcz
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e1c4c9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=20KFwNOVAAAA:8 a=ya1OogIx4tq_LYJqWmsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240146
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


On 3/24/2025 2:40 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Saturday, March 1, 2025 11:21 AM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Damien Hedde <damien.hedde@dahe.fr>; Paolo
>> Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH 1/8] hw/intc: Add l2vic interrupt controller
>>
>> From: Sid Manning <sidneym@quicinc.com>
>>
>> Co-authored-by: Matheus Tavares Bernardino
>> <quic_mathbern@quicinc.com>
>> Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                    |   2 +
>>   docs/devel/hexagon-l2vic.rst   |  59 +++++
>>   docs/devel/index-internals.rst |   1 +
>>   include/hw/intc/l2vic.h        |  37 +++
>>   hw/intc/l2vic.c                | 417 +++++++++++++++++++++++++++++++++
>>   hw/intc/Kconfig                |   3 +
>>   hw/intc/meson.build            |   2 +
>>   hw/intc/trace-events           |   4 +
>>   8 files changed, 525 insertions(+)
>>   create mode 100644 docs/devel/hexagon-l2vic.rst  create mode 100644
>> include/hw/intc/l2vic.h  create mode 100644 hw/intc/l2vic.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 804c07bcd5..a842f7fe1b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -232,6 +232,7 @@ Hexagon TCG CPUs
>>   M: Brian Cain <brian.cain@oss.qualcomm.com>
>>   S: Supported
>>   F: target/hexagon/
>> +F: hw/intc/l2vic.[ch]
> Consider naming all the files outside target/hexagon as hex_* or hexagon_*
> That will make it clear they belong to hexagon and you can use an easy wild card in the MAINTAINERS file.
> Ditto for the docs files.

I'm not sure we can do this in all cases.  Devices aren't necessarily 
bound to one particular architecture.  Of course, for interrupt 
controllers in all practical terms they are bound to an architecture.  
So sure - we can make it hex_l2vic.*

But for example for the QTimer device (yet to be sent to the list for 
review), that wouldn't make sense IMO.


>>   X: target/hexagon/idef-parser/
>>   X: target/hexagon/gen_idef_parser_funcs.py
>>   F: linux-user/hexagon/
>> diff --git a/include/hw/intc/l2vic.h b/include/hw/intc/l2vic.h new file mode
>> 100644 index 0000000000..ed8ccf33b1
>> --- /dev/null
>> +++ b/include/hw/intc/l2vic.h
>> @@ -0,0 +1,37 @@
>> +/*
>> + * QEMU L2VIC Interrupt Controller
>> + *
>> + * Copyright(c) 2020-2025 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
>> +
>> +#define L2VIC_VID_GRP_0 0x0 /* Read */
>> +#define L2VIC_VID_GRP_1 0x4 /* Read */
>> +#define L2VIC_VID_GRP_2 0x8 /* Read */
>> +#define L2VIC_VID_GRP_3 0xC /* Read */
>> +#define L2VIC_VID_0 0x10 /* Read SOFTWARE DEFINED */ #define
>> +L2VIC_VID_1 0x14 /* Read SOFTWARE DEFINED NOT YET USED */ #define
>> +L2VIC_INT_ENABLEn 0x100 /* Read/Write */ #define
>> +L2VIC_INT_ENABLE_CLEARn 0x180 /* Write */ #define
>> L2VIC_INT_ENABLE_SETn
>> +0x200 /* Write */ #define L2VIC_INT_TYPEn 0x280 /* Read/Write */
>> +#define L2VIC_INT_STATUSn 0x380 /* Read */ #define L2VIC_INT_CLEARn
>> +0x400 /* Write */ #define L2VIC_SOFT_INTn 0x480 /* Write */ #define
>> +L2VIC_INT_PENDINGn 0x500 /* Read */ #define L2VIC_INT_GRPn_0 0x600
>> /*
>> +Read/Write */ #define L2VIC_INT_GRPn_1 0x680 /* Read/Write */ #define
>> +L2VIC_INT_GRPn_2 0x700 /* Read/Write */ #define L2VIC_INT_GRPn_3
>> 0x780
>> +/* Read/Write */
>> +
>> +#define L2VIC_INTERRUPT_MAX 1024
>> +#define L2VIC_CIAD_INSTRUCTION -1
>> +/*
>> + * Note about l2vic groups:
>> + * Each interrupt to L2VIC can be configured to associate with one of
>> + * four groups.
>> + * Group 0 interrupts go to IRQ2 via VID 0 (SSR: 0xC2, the default)
>> + * Group 1 interrupts go to IRQ3 via VID 1 (SSR: 0xC3)
>> + * Group 2 interrupts go to IRQ4 via VID 2 (SSR: 0xC4)
>> + * Group 3 interrupts go to IRQ5 via VID 3 (SSR: 0xC5)  */
>> diff --git a/hw/intc/l2vic.c b/hw/intc/l2vic.c new file mode 100644 index
>> 0000000000..9df6575214
>> --- /dev/null
>> +++ b/hw/intc/l2vic.c
>> @@ -0,0 +1,417 @@
>> +/*
>> + * QEMU L2VIC Interrupt Controller
>> + *
>> + * Arm PrimeCell PL190 Vector Interrupt Controller was used as a reference.
>> + * Copyright(c) 2020-2025 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
>> + * SPDX-License-Identifier: GPL-2.0-or-later  */
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
>> +
>> +#define SLICE_MAX (L2VIC_INTERRUPT_MAX / 32)
>> +
>> +typedef struct L2VICState {
>> +    SysBusDevice parent_obj;
>> +
>> +    QemuMutex active;
>> +    MemoryRegion iomem;
>> +    MemoryRegion fast_iomem;
>> +    uint32_t level;
>> +    /*
>> +     * offset 0:vid group 0 etc, 10 bits in each group
>> +     * are used:
>> +     */
>> +    uint32_t vid_group[4];
>> +    uint32_t vid0;
>> +    /* Clear Status of Active Edge interrupt, not used: */
>> +    uint32_t int_clear[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* Enable interrupt source */
>> +    uint32_t int_enable[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* Clear (set to 0) corresponding bit in int_enable */
>> +    uint32_t int_enable_clear;
>> +    /* Set (to 1) corresponding bit in int_enable */
>> +    uint32_t int_enable_set;
>> +    /* Present for debugging, not used */
>> +    uint32_t int_pending[SLICE_MAX] QEMU_ALIGNED(16);
> Consider using DECLARE_BITMAP32 since you use test_bit/set_bit/clear_bit.
> Are these alignments needed?
>
>> +    /* Generate an interrupt */
>> +    uint32_t int_soft;
>> +    /* Which enabled interrupt is active */
>> +    uint32_t int_status[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* Edge or Level interrupt */
>> +    uint32_t int_type[SLICE_MAX] QEMU_ALIGNED(16);
>> +    /* L2 interrupt group 0-3 0x600-0x7FF */
>> +    uint32_t int_group_n0[SLICE_MAX] QEMU_ALIGNED(16);
>> +    uint32_t int_group_n1[SLICE_MAX] QEMU_ALIGNED(16);
>> +    uint32_t int_group_n2[SLICE_MAX] QEMU_ALIGNED(16);
>> +    uint32_t int_group_n3[SLICE_MAX] QEMU_ALIGNED(16);
>> +    qemu_irq irq[8];
>> +} L2VICState;
>> +
>
>
>> +
>> +static void l2vic_set_irq(void *opaque, int irq, int level) {
>> +    L2VICState *s = (L2VICState *)opaque;
>> +    if (level) {
>> +        qemu_mutex_lock(&s->active);
>> +        set_bit(irq, (unsigned long *)s->int_pending);
> Here's an example of the set_bit mentioned above.
>
>> +        qemu_mutex_unlock(&s->active);
>> +    }
>> +    l2vic_update(s, irq);
>> +}
>> +
>> +static void l2vic_reset_hold(Object *obj, G_GNUC_UNUSED ResetType
>> +res_type) {
>> +    L2VICState *s = L2VIC(obj);
>> +    memset(s->int_clear, 0, sizeof(s->int_clear));
>> +    memset(s->int_enable, 0, sizeof(s->int_enable));
>> +    memset(s->int_pending, 0, sizeof(s->int_pending));
>> +    memset(s->int_status, 0, sizeof(s->int_status));
>> +    memset(s->int_type, 0, sizeof(s->int_type));
>> +    memset(s->int_group_n0, 0, sizeof(s->int_group_n0));
>> +    memset(s->int_group_n1, 0, sizeof(s->int_group_n1));
>> +    memset(s->int_group_n2, 0, sizeof(s->int_group_n2));
>> +    memset(s->int_group_n3, 0, sizeof(s->int_group_n3));
>> +    s->int_soft = 0;
>> +    s->vid0 = 0;
> How about a single memset(s, 0, sizeof(L2VICState))?
>
>> +
>> +    l2vic_update_all(s);
>> +}

