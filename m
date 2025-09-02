Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52708CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIbJ-0000QO-MK; Tue, 02 Sep 2025 00:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIbF-0000KQ-2n
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:26:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIbC-0001TT-LI
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:26:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkMP029653
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WDscHpA+NhTLY9XCKWlhPudbSug8N5ZCOBi3a4lzWHI=; b=j+j2e0OR6guiG2oT
 R0+1eXYKA+opzbu0E2dllaReOQbQWWTrK9JamwHlYVDZ461g5uYs6Br6iMBWuctI
 kwjE8Gb89PsklHn9hIUk8fr/C/QPeZXCzpbC82uFGs3bY5HWfm4AOERFR/WdA/fY
 jrDHeX+thIw30cGNqEOhsndCuRGoR/OlixGf1uj+W91HqQQD48oa5RyDDQonivEM
 QsSqcnSTQPYevYgioWmLQeEsdrFwlG+mYu2UPE2nBW5tjQKuX5UjOccngppD1qkB
 7CPd7KjM38aW3638e8IEoAk+e4QILaaB+20gJXQo51fY68/LHFG9nfc9P4ZGNGGM
 2eOllw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xd3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:26:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70deedd1deaso85045736d6.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787183; x=1757391983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WDscHpA+NhTLY9XCKWlhPudbSug8N5ZCOBi3a4lzWHI=;
 b=RsTN6R/y24P4s9e8nnsfwBYMUaPrt5nH8Hz94aFkiWcZYBvghmAZHQsgPyyxFzBhVo
 +MURwds4dMXKLSHpTLb443shYzN4P9PJqBNh1NeKA5xcfoSfGkWpEyxQoxKcdbTQCWQk
 u4NU3LbCqFPBMPAzySEisomzlM1G+pwZL5JWrv7Fkybq/HtH/6KS1UdD21T1n3S2FMzP
 ovRNiQWnKdgKgO6ors2oc+DGAbI5APrp9LZDZibYpBc6jPjVmWY6uMYOf7sEFYHuwazq
 yafp4LHb88j1m3TWbcadGUxtovuiIw9hHxrSTeJAp1ycJ3Wpb7bfibAdUj+TjOrw2mDu
 rOuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZsF8xxDja2/mhvXUjSXoQfc+PgnrifS5pllngyusGgIvULOu4474WZJW0rRYCrcf3vuSHHcs0ii/q@nongnu.org
X-Gm-Message-State: AOJu0Yw3uRJBFyvd1kTmq798d9/K6yxoT96PgMolmtN9SVQfoKvn1+PD
 Lxi6S1DmiQRD+dLLkXu5e8Y+iHCLWNGOAebItfJpunJhJ3/baRb6IXxrNONacNaAeb47X+vDOTD
 xlaVQlR4rJ44HwlguKAdZac97Zx/qaY2a35wya1/JK34MwyCKKeOr1662eQ==
X-Gm-Gg: ASbGncuc62R9UpMSviVw7ZXh97LoD42HU1H7zlhhFaxPPXwMWBIiMvTX1jrphYBA+0t
 5eikQP5ss9MjrANd5NVb7dngZMladuobDa+9hsMMMuKvlnUngjU/SM8T2BL8NbiGDeQeT4pALdh
 MpnG1i2/ldsS2MwZ1PixQFIBt6gQVD0TdyYOWnB6MDA8kqPnbUXD7KWW7NxwfEYzXy0oIIr4wAm
 4Zhp4KPuVr9QRxrhSRO/G3XMZsa/DpBHA8KGNsorJHfJQbz5+IUxTFChX3GLtkEJRN6NKoC2u3Y
 W/D3UrlJnPa5KhDGG4/OPmj59ITfI2iRvIx620nsewH0kEZdcTsVIP1mATGBrw==
X-Received: by 2002:a05:6214:cc1:b0:71a:a3be:a900 with SMTP id
 6a1803df08f44-71aa3beaf2bmr48804076d6.53.1756787183370; 
 Mon, 01 Sep 2025 21:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAhkfc/QoEgJuzTvi4sGgy3i+3RX4+UsqdBe6U6e10xGiq3w/CJ7DcSlMg/k8lN/D7nlK2uw==
X-Received: by 2002:a05:6214:cc1:b0:71a:a3be:a900 with SMTP id
 6a1803df08f44-71aa3beaf2bmr48803946d6.53.1756787182865; 
 Mon, 01 Sep 2025 21:26:22 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b88007a60sm65955265e9.8.2025.09.01.21.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:26:22 -0700 (PDT)
Message-ID: <da64f88c-710d-458b-a3d0-1185e391b03d@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 21:46:37 -0500
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX/lv8YEtVYN5B
 KT/q1ktpdBsZibz56ffoTbAvmlR1ql8MFK5UHM1WQq97ZiV/4F1XH1rk7RLN82LcHcYvSgNXTLX
 Rmai3y1adMbBN7hxxgCDXCzx5yU/qM3s4pI5+h0V1eLKlDtDJQctoS/Y+JVE5buEeGKD8dNe3ZO
 HkyX/rXNETUHPuSZ6z1hhaWOiFIqHBpMPHhSqdJaam2gga5OYvAn04muwHWnxkP1srP2JYVNrz9
 KQ/07PbgvxUfv4xfdbw4fI935srXyBc+ERkPDE58iaFu43hZqfA4qHbVSUgeAp+MJvSExYNaYzu
 huawOKIcic0QFjw2Paw72BThQFVtQeMvE64Ub1OjyG95yWg+Tq1qmyo6QNm8pyrPRBYxzQ4FHoV
 Ojz4Gofw
X-Proofpoint-ORIG-GUID: PKM3T3MJznffjXUtcWA_YvF8aJpnmV7U
X-Proofpoint-GUID: PKM3T3MJznffjXUtcWA_YvF8aJpnmV7U
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b671f0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8
 a=ya1OogIx4tq_LYJqWmsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Ok - I will rename l2vic hex_l2vic in v3.


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
Ok, will be fixed in v3.
> Are these alignments needed?

The assignments below resulted in unaligned accesses which were flagged 
by UBSan.  We'll revisit whether or not the alignments are necessary 
after making the other suggested changes for v3 and we'll ideally omit them.


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

Ok, will revisit this.


>> +
>> +    l2vic_update_all(s);
>> +}

