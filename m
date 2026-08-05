Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5E9C55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1writ9-0001cp-60; Wed, 05 Aug 2026 17:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1writ7-0001ch-Jk
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 17:10:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1writ3-0001XT-E4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 17:10:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HRv3F4127600
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 21:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J3rPfADsGbvCCeKkKaDpGo3m8yB4QE48kYSuoCqF8VA=; b=DsPb1ri+hlhanfJa
 ZVo1c1jKI52V1jo5oEooyCbTzi2pcOVqzYtA7+vlK4oDhdCdMZtOKZZ6d5iTTEkR
 ZlQuZJpHjZ0PgB++p3erx7Zj1R9i2MSKCVvu3pAIGDJvPrzymh8wntY22lG21vYj
 NDYL6EgkW5onWuCET5Um4gFVIhnoAnHTbfBd/3S0ej/xC6zFQ1Towp2HXDAtJdhh
 S3Ps/RyS+f64QxlHr1KZtbZEkw7SsGXwCTnqoOAWRiAf/tVIq/Ijz/BnwAeaSoPI
 AFwWTBimORG7kd4dVAPi8+F9R+c/ZQ5Yf2OLb8RjAuU0gBd7ezmFL8FOrPnc3F+s
 ppH2UA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5dk28qv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:10:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso18134386d6.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785964249; x=1786569049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J3rPfADsGbvCCeKkKaDpGo3m8yB4QE48kYSuoCqF8VA=;
 b=N+PSaGdNNzoqY5oe7j5wlXRg3Dz1qbpPrJs37GWxl3TdhJ+z4r4Uv0AGgtAI2cGeey
 GbrcGLlFxZJABCIWr0ITkxYVZBU+HLebagDV3L8ZskhPKbPyNZ1Ma/5NZtCY8q4V5tL7
 oQbx3xyazucVi4AOZw8Eh+vTRrGuG9d9hT4YYBEa+sORwgTsm7C+5OsSBQNbR8a7/nIH
 9bNtgGTeXpZ93R/M3FeSsezjGqFPnb0IO+iLzfAL104/qxQog5e8CWg5hvmnaDy/VOvO
 FU/gIidnhvl09q0V0f+tpjTAL6aZiuN8QAykulihjow7cKdHVAFXaTuL2wUvyCQVjsp0
 LWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785964249; x=1786569049;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J3rPfADsGbvCCeKkKaDpGo3m8yB4QE48kYSuoCqF8VA=;
 b=Z6HyiEW8yxP3mOVdv68eZt9Fe8OMA5smmPWltaBtEK757mA+aH4v+bSGDj2D7exSHC
 G1KsiixPeFnimSVEdtgukD1vLHHiXP8UlIbWPDTi6lZFbhDd2ioIXdrAo2ibk3u2wWIZ
 yO2WLzmgiJRciDqhxo4NAg1m4TxAP/j4GUiSuZU774mLOZCj5EBZMx3cCEzln3lM2i+t
 kggVTN/C0EQOnsNWop/i3xMMB4P8/Z20wUY7K5Z2pri90Ixj03G5YU0YwQQbFg8jjoth
 rqIVkrKpAL3q0k9DRmTqmHEY+I2/Krzp28pBrP2MIL8U5UneDdLsRhkt1AcgPdhw8qOL
 Cvww==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpwo4Afg7aIcOCfBSlj6mMt2mE+6aWLwMg5MJiNAUdLBM3tDR3hMIRvxFww9YGWgxQGXcgNykJtxEpL@nongnu.org
X-Gm-Message-State: AOJu0YzIkKklTWlAKXazDjJox6TVTyFuXEdoN/WS5gljd8bJp7K6d5Tg
 qDRyAHFFyFxUzkaZqXMzwBkkZ07STj5z87/bhYR+TWJomqm/vVMlnsKjwGpbVmL75wRO9aYsQUw
 e6rSZIoovcqimB34hbiZOrYHuLysgjx/ZCGGtQwh5tJt/S6aZ4IZtsmKkvQ==
X-Gm-Gg: AR+sD11vOyHRWXALOuZGGZiICxl8NJd4PcnotBkW5t1mwrGVscNjuqyZevUWpAAeE70
 rzYTvGqxiakJgIOiFG1lxVAJ0ggUmWo+qIWLtrLij5BlmV0V1rXqC6B3SyEEumBgizWoeqU4x/2
 ws4LngwSsAu6Tfq1v9+5jn/pl4CZ5KQTXLiFYHQ/F/18TyM3P08oSe5agiXyfLNimlvdcnMPKw5
 aHhrRk+c5QC+nxIO7D8eCb8BGLAFZ7WjFUALAxyJimIeuTLyB38x6ZBi92+KNYjmW3Q+ihRmx9P
 e+eb7dooKcUAX0pAPr9T6m3kt4BC6AMQ8SMoy/p0hAVcOG7IE34fhElsF7J50/NRaP7QRJ7cBkk
 Dk2eZ529lys4b7yTmKOrZK/HERLYFvxkCjyeK2xqE1y47wlVQU7Xbv8jSsZBwE45o
X-Received: by 2002:a05:6214:2428:b0:8e8:199b:aad0 with SMTP id
 6a1803df08f44-9088108f4c6mr117797566d6.7.1785964249166; 
 Wed, 05 Aug 2026 14:10:49 -0700 (PDT)
X-Received: by 2002:a05:6214:2428:b0:8e8:199b:aad0 with SMTP id
 6a1803df08f44-9088108f4c6mr117796386d6.7.1785964248488; 
 Wed, 05 Aug 2026 14:10:48 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ff9d814sm34010916d6.10.2026.08.05.14.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 14:10:47 -0700 (PDT)
Message-ID: <77d37dfe-1e6f-42d3-8254-6e2423c444b1@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 16:10:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/18] hw/timer: Add QCT QTimer device model
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com,
 Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?Q?Tobias_R=C3=B6hmel?= <quic_trohmel@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 Thomas Marceron <tmarcero@qti.qualcomm.com>,
 Mahmoud Kamel <mkamel@qti.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-16-brian.cain@oss.qualcomm.com>
 <83d2fcb8-1446-4619-bee0-e57eca31783a@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <83d2fcb8-1446-4619-bee0-e57eca31783a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YlgVYPCRgwF6MYPPYdTa8rrWM1TB3ZdN
X-Authority-Analysis: v=2.4 cv=Or9/DS/t c=1 sm=1 tr=0 ts=6a73a6da cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=1cGLs3X8AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=d8bxP-KCry6P0NCL74kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=d8ghUycwObenwynNfMyN:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE3MyBTYWx0ZWRfX+YGNxhZIkFSg
 5hNlhanyyAo0xJhrAxv2t4h1bYINSWApx8UcCkztYZ64tOCTG/fK0u5aemPcjyIi0h15Cd2DqaH
 Rs/diPY5eT2N/VzCqQzspMLh4M2bN91Nj3t4QvYn3AXa59BUOCFVhalAkUnveot1LF8iWOVnTPA
 II/mj7NQdCHdLGsmgiPH5XTQzE/dp9mCoRPSassFdSIX00VZ6dKFZMezSGM9icmzKFmBphiyZ5n
 Fg02owZ5gdE8blG4Nk5Y2q3sHL8kZhOVvdvuCR9Pi08qSJS8T1maRu5yEdlbSsNGxl94gafoE1q
 wZUxnczt1jgZWnh8DCI6VpgPkWowvydHzEhlcN+hEq1qi9auJkD8kBfvMNbESAfBX7rxOdYhkaj
 gfzmD1pEhng1imBxtKFEABXsCElDzJgKoxby1Kvdt/PUrGvsQRInL28tIyiw1JlBnOJvFQpKBIw
 JCwRkh+LEf5N7rltdOQ==
X-Proofpoint-GUID: YlgVYPCRgwF6MYPPYdTa8rrWM1TB3ZdN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE3MyBTYWx0ZWRfX7PwC/Hd3xY6p
 5rfqK0rptw4wdjIAotHAP768hnH6qus0l5yAqBo/wRe+g0e1IqGraf8hE0Js7FS9vceeqHB5R4i
 HWObTqYCzqSQZkCS5vwTiluxeXt8XCE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050173
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


On 7/31/2026 12:59 PM, Pierrick Bouvier wrote:
> On 7/29/2026 6:28 PM, Brian Cain wrote:
>> Implement the QCT QTimer generic timer device used by Hexagon DSP
>> systems.
>>
>> Co-authored-by: Damien Hedde <damien.hedde@greensocs.com>
>> Co-authored-by: Tobias Röhmel <quic_trohmel@quicinc.com>
>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>> Co-authored-by: Thomas Marceron <tmarcero@qti.qualcomm.com>
>> Co-authored-by: Mahmoud Kamel <mkamel@qti.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                   |   2 +
>>   include/hw/timer/qct-qtimer.h |  43 +++
>>   hw/timer/qct-qtimer.c         | 681 ++++++++++++++++++++++++++++++++++
>>   hw/timer/Kconfig              |   3 +
>>   hw/timer/meson.build          |   2 +
>>   hw/timer/trace-events         |   5 +
>>   6 files changed, 736 insertions(+)
>>   create mode 100644 include/hw/timer/qct-qtimer.h
>>   create mode 100644 hw/timer/qct-qtimer.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 114bbec45ad..de106416b64 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -253,6 +253,8 @@ F: target/hexagon/
>>   F: hw/intc/hex-l2vic.c
>>   F: include/hw/intc/hex-l2vic.h
>>   F: tests/qtest/l2vic-test.c
>> +F: hw/timer/qct-qtimer.c
>> +F: include/hw/timer/qct-qtimer.h
>>   X: target/hexagon/idef-parser/
>>   X: target/hexagon/gen_idef_parser_funcs.py
>>   F: linux-user/hexagon/
>> diff --git a/include/hw/timer/qct-qtimer.h b/include/hw/timer/qct-qtimer.h
>> new file mode 100644
>> index 00000000000..53d8291472d
>> --- /dev/null
>> +++ b/include/hw/timer/qct-qtimer.h
>> @@ -0,0 +1,43 @@
>> +/*
>> + * Qualcomm QCT QTimer
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_TIMER_QCT_QTIMER_H
>> +#define HW_TIMER_QCT_QTIMER_H
>> +
>> +#include "qom/object.h"
>> +
>> +#define TYPE_QCT_QTIMER "qct-qtimer"
>> +
>> +/* QTimer interface for external access from hexagon_globalreg */
>> +#define TYPE_QCT_QTIMER_INTERFACE "qct-qtimer-if"
>> +
> Why not directly get access to TYPE_QCT_QTIMER?
> Is it to ensure there is no other access than get_timer_lo/hi made from
> there?

The export for the sake of the globalreg only needs access to that timer 
count, so -- yes, I guess.  And I think this also allows us to keep the 
state private?

>> +typedef struct QctQtimerInterface QctQtimerInterface;
>> +
>> +typedef struct QctQtimerInterfaceClass {
>> +    InterfaceClass parent_class;
>> +
>> +    /* Read the live physical counter, backing HEX_SREG_TIMERLO/TIMERHI */
>> +    uint32_t (*get_timer_lo)(const QctQtimerInterface *qtimer);
>> +    uint32_t (*get_timer_hi)(const QctQtimerInterface *qtimer);
>> +} QctQtimerInterfaceClass;
>> +
>> +DECLARE_OBJ_CHECKERS(QctQtimerInterface, QctQtimerInterfaceClass,
>> +                     QCT_QTIMER_INTERFACE, TYPE_QCT_QTIMER_INTERFACE);
>> +
>> +static inline uint32_t qct_qtimer_get_timer_lo(const QctQtimerInterface *qtimer)
>> +{
>> +    QctQtimerInterfaceClass *k = QCT_QTIMER_INTERFACE_GET_CLASS(qtimer);
>> +    return k->get_timer_lo(qtimer);
>> +}
>> +
>> +static inline uint32_t qct_qtimer_get_timer_hi(const QctQtimerInterface *qtimer)
>> +{
>> +    QctQtimerInterfaceClass *k = QCT_QTIMER_INTERFACE_GET_CLASS(qtimer);
>> +    return k->get_timer_hi(qtimer);
>> +}
>> +
>> +#endif /* HW_TIMER_QCT_QTIMER_H */
>> diff --git a/hw/timer/qct-qtimer.c b/hw/timer/qct-qtimer.c
>> new file mode 100644
>> index 00000000000..82c711000eb
>> --- /dev/null
>> +++ b/hw/timer/qct-qtimer.c
>> @@ -0,0 +1,681 @@
>> +/*
>> + * Qualcomm QCT QTimer
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/core/irq.h"
>> +#include "hw/core/qdev-properties.h"
>> +#include "hw/core/sysbus.h"
>> +#include "hw/timer/qct-qtimer.h"
>> +#include "migration/vmstate.h"
>> +#include "qemu/bitops.h"
>> +#include "qemu/log.h"
>> +#include "qemu/module.h"
>> +#include "qemu/timer.h"
>> +#include "qapi/error.h"
>> +#include "trace.h"
>> +
>> +#define QTIMER_MEM_SIZE_BYTES 0x1000
>> +#define QTIMER_DEFAULT_FREQ_HZ 19200000ULL
>> +
>> +#define QCT_QTIMER_TIMER_FRAME_ELTS (16)
>> +#define QCT_QTIMER_TIMER_VIEW_ELTS (2)
>> +
>> +#define QCT_QTIMER_AC_CNTFRQ (0x000)
>> +#define QCT_QTIMER_AC_CNTSR (0x004)
>> +#define QCT_QTIMER_AC_CNTTID_0 (0x08)
>> +#define QCT_QTIMER_AC_CNTACR_START (0x40)
>> +#define QCT_QTIMER_AC_CNTACR_END (0x5c)
>> +#define QCT_QTIMER_AC_CNTTID_1 (0x108)
>> +#define QCT_QTIMER_AC_CNTACR_RWPT (1 << 5) /* R/W of CNTP_* regs */
>> +#define QCT_QTIMER_AC_CNTACR_RWVT (1 << 4) /* R/W of CNTV_* regs */
>> +#define QCT_QTIMER_AC_CNTACR_RVOFF (1 << 3) /* R/W of CNTVOFF register */
>> +#define QCT_QTIMER_AC_CNTACR_RFRQ (1 << 2) /* R/W of CNTFRQ register */
>> +#define QCT_QTIMER_AC_CNTACR_RPVCT (1 << 1) /* R/W of CNTVCT register */
>> +#define QCT_QTIMER_AC_CNTACR_RPCT (1 << 0) /* R/W of CNTPCT register */
>> +#define QCT_QTIMER_VERSION (0x0fd0)
>> +
>> +#define QCT_QTIMER_CNTPCT_LO (0x000)
>> +#define QCT_QTIMER_CNTPCT_HI (0x004)
>> +#define QCT_QTIMER_CNT_FREQ (0x010)
>> +#define QCT_QTIMER_CNTPL0ACR (0x014)
>> +#define QCT_QTIMER_CNTPL0ACR_PL0CTEN (1 << 9)
>> +#define QCT_QTIMER_CNTPL0ACR_PL0TVEN (1 << 8)
>> +#define QCT_QTIMER_CNTPL0ACR_PL0VCTEN (1 << 1)
>> +#define QCT_QTIMER_CNTPL0ACR_PL0PCTEN (1 << 0)
>> +#define QCT_QTIMER_CNTP_CVAL_LO (0x020)
>> +#define QCT_QTIMER_CNTP_CVAL_HI (0x024)
>> +#define QCT_QTIMER_CNT_MASK 0x00ffffffffffffffULL
>> +#define QCT_QTIMER_CNT_HI_BITS 24
>> +#define QCT_QTIMER_CNTP_TVAL (0x028)
>> +#define QCT_QTIMER_CNTP_CTL (0x02c)
>> +#define QCT_QTIMER_CNTP_CTL_ENABLE (1 << 0)
>> +#define QCT_QTIMER_CNTP_CTL_INTEN (1 << 1)
>> +#define QCT_QTIMER_CNTP_CTL_ISTAT (1 << 2)
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(QCTQtimerState, QCT_QTIMER)
>> +
>> +typedef struct QCTHextimerState {
>> +    QCTQtimerState *qtimer;
>> +    QEMUTimer *timer;       /* one-shot deadline timer */
>> +    int64_t offset_ns;      /* QEMU_CLOCK_VIRTUAL ns at which cntpct == 0 */
>> +    uint64_t cntval;        /* 64-bit physical timer compare value */
>> +    uint32_t control;
>> +    uint32_t cnt_ctrl;
>> +    uint32_t cntpl0acr;
>> +    uint32_t int_level;
>> +    qemu_irq irq;
>> +} QCTHextimerState;
>> +
>> +struct QCTQtimerState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion iomem;
>> +    MemoryRegion view_iomem;
>> +    uint32_t secure;
>> +    QCTHextimerState timer[QCT_QTIMER_TIMER_FRAME_ELTS];
>> +    uint32_t freq_hz;
>> +    uint32_t nr_frames;
>> +    uint32_t nr_views;
>> +    uint32_t frame_stride;
>> +    uint32_t cnttid_0;
>> +    uint32_t cnttid_1;
>> +    uint32_t freq_scale;
>> +};
>> +
>> +/*
>> + * QTimer version register:
>> + *
>> + *    3                   2                   1
>> + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
>> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>> + * | Major |         Minor         |           Step                |
>> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>> + */
>> +#define QCT_QTIMER_VERSION_VALUE 0x20020000
>> +
>> +/* Counter value derived on-demand from QEMU_CLOCK_VIRTUAL. */
>> +static uint64_t hex_timer_now(QCTHextimerState *s)
>> +{
>> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +    uint32_t scale;
>> +    uint64_t scaled_elapsed;
>> +
>> +    if (now <= s->offset_ns) {
>> +        return 0;
>> +    }
>> +    scale = MAX(s->qtimer->freq_scale, 1u);
>> +    scaled_elapsed = (uint64_t)(now - s->offset_ns) / scale;
>> +    return muldiv64(scaled_elapsed, s->qtimer->freq_hz,
>> +                    NANOSECONDS_PER_SECOND) &
>> +           QCT_QTIMER_CNT_MASK;
>> +}
>> +
>> +/* Arm (or disarm) the one-shot deadline timer. */
>> +static void hex_timer_rearm(QCTHextimerState *s)
>> +{
>> +    uint32_t scale;
>> +    uint64_t base_ns;
>> +    int64_t deadline_ns;
>> +
>> +    if (!(s->control & QCT_QTIMER_CNTP_CTL_ENABLE)) {
>> +        timer_del(s->timer);
>> +        return;
>> +    }
>> +
>> +    scale = MAX(s->qtimer->freq_scale, 1u);
>> +    /*
>> +     * Round the ticks-to-ns conversion up so that hex_timer_now(), which
>> +     * truncates when it divides elapsed ns by scale, is guaranteed to
>> +     * report >= cntval once this deadline fires. A truncating conversion
>> +     * here could re-arm at the same deadline forever when scale > 1.
>> +     */
>> +    base_ns = muldiv64_round_up(s->cntval, NANOSECONDS_PER_SECOND,
>> +                                s->qtimer->freq_hz);
>> +    if (base_ns >
>> +        ((uint64_t)INT64_MAX - (uint64_t)s->offset_ns) / scale) {
>> +        timer_del(s->timer);
>> +        return;
>> +    }
>> +    deadline_ns = s->offset_ns + (int64_t)(base_ns * scale);
>> +    timer_mod(s->timer, deadline_ns);
>> +}
>> +
>> +static void hex_timer_update(QCTHextimerState *s)
>> +{
>> +    int level = s->int_level &&
>> +                (s->control & QCT_QTIMER_CNTP_CTL_ENABLE) &&
>> +                !(s->control & QCT_QTIMER_CNTP_CTL_INTEN);
>> +
>> +    trace_qtimer_interrupt();
>> +    qemu_set_irq(s->irq, level);
>> +}
>> +
>> +/*
>> + * Access-control (AC) region: offsets below 0x1000, gates CNTFRQ/CNTSR/
>> + * CNTTID/CNTACR per frame plus the shared VERSION register.
>> + */
>> +static uint64_t qct_qtimer_ac_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    QCTQtimerState *s = opaque;
>> +    uint32_t frame;
>> +
>> +    switch (offset) {
>> +    case QCT_QTIMER_AC_CNTFRQ:
>> +        return s->freq_hz;
>> +    case QCT_QTIMER_AC_CNTSR:
>> +        return s->secure;
>> +    case QCT_QTIMER_AC_CNTTID_0:
>> +        return s->cnttid_0;
>> +    case QCT_QTIMER_AC_CNTTID_1:
>> +        return s->cnttid_1;
>> +    case QCT_QTIMER_AC_CNTACR_START ... QCT_QTIMER_AC_CNTACR_END:
>> +        frame = (offset - QCT_QTIMER_AC_CNTACR_START) / 4;
>> +        if (frame >= s->nr_frames) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad CNTACR offset 0x%x\n",
>> +                          __func__, (int)offset);
>> +            return 0;
>> +        }
>> +        return s->timer[frame].cnt_ctrl;
>> +    case QCT_QTIMER_VERSION:
>> +        return QCT_QTIMER_VERSION_VALUE;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%x\n", __func__,
>> +                      (int)offset);
>> +        return 0;
>> +    }
>> +}
>> +
>> +static void qct_qtimer_ac_write(void *opaque, hwaddr offset, uint64_t value,
>> +                                unsigned size)
>> +{
>> +    QCTQtimerState *s = opaque;
>> +    uint32_t frame;
>> +
>> +    switch (offset) {
>> +    case QCT_QTIMER_AC_CNTFRQ:
>> +        if (value == 0) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad CNTFRQ value 0\n",
>> +                          __func__);
>> +            return;
>> +        }
>> +        s->freq_hz = value;
>> +        return;
>> +    case QCT_QTIMER_AC_CNTSR:
>> +        if (value > 0xff) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad CNTSR value 0x%x\n",
>> +                          __func__, (int)value);
>> +            return;
>> +        }
>> +        s->secure = value;
>> +        return;
>> +    case QCT_QTIMER_AC_CNTACR_START ... QCT_QTIMER_AC_CNTACR_END:
>> +        frame = (offset - QCT_QTIMER_AC_CNTACR_START) / 4;
>> +        if (frame >= s->nr_frames) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad CNTACR offset 0x%x\n",
>> +                          __func__, (int)offset);
>> +            return;
>> +        }
>> +        s->timer[frame].cnt_ctrl = value;
>> +        return;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%x\n", __func__,
>> +                      (int)offset);
>> +        return;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps qct_qtimer_ac_ops = {
>> +    .read = qct_qtimer_ac_read,
>> +    .write = qct_qtimer_ac_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +        .unaligned = false,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +};
>> +
>> +/*
>> + * View region: a flat array of (frame, view) slots, each frame_stride
>> + * bytes wide, holding the per-frame CNTPCT/CNTP_CVAL/CNTP_TVAL/CNTP_CTL
>> + * register set.
>> + */
>> +static QCTHextimerState *qct_qtimer_demux(QCTQtimerState *s, hwaddr offset,
>> +                                          uint32_t *reg_offset,
>> +                                          uint32_t *view)
>> +{
>> +    uint32_t stride = s->frame_stride;
>> +    uint32_t stride_shift = ctz32(stride);
>> +    uint32_t slot_nr = offset >> stride_shift;
>> +    uint32_t frame = slot_nr / s->nr_views;
>> +
>> +    *reg_offset = offset & (stride - 1);
>> +    *view = slot_nr % s->nr_views;
>> +    if (frame >= s->nr_frames) {
>> +        return NULL;
>> +    }
>> +    return &s->timer[frame];
>> +}
>> +
>> +/* Frames 8+ share cnttid_1; each frame's second view is gated by a bit. */
>> +static bool qct_qtimer_view_visible(QCTQtimerState *s, uint32_t frame,
>> +                                    uint32_t view)
>> +{
>> +    uint32_t cnttid = frame < 8 ? s->cnttid_0 : s->cnttid_1;
>> +    uint32_t frame_idx = frame < 8 ? frame : frame - 8;
>> +
>> +    return !view || (cnttid & (0x4 << (frame_idx * 4)));
>> +}
>> +
>> +static MemTxResult hex_timer_read(void *opaque, hwaddr offset, uint64_t *data,
>> +                                  unsigned size, MemTxAttrs attrs)
>> +{
>> +    QCTQtimerState *qs = opaque;
>> +    uint32_t reg_offset;
>> +    uint32_t view;
>> +    QCTHextimerState *s = qct_qtimer_demux(qs, offset, &reg_offset, &view);
>> +    uint32_t frame;
>> +
>> +    if (!s) {
>> +        *data = 0;
>> +        return MEMTX_ACCESS_ERROR;
>> +    }
>> +    frame = s - qs->timer;
>> +
>> +    trace_qtimer_read(offset);
>> +
>> +    if (!qct_qtimer_view_visible(qs, frame, view)) {
>> +        *data = 0;
>> +        return MEMTX_OK;
>> +    }
>> +
>> +    switch (reg_offset) {
>> +    case QCT_QTIMER_CNT_FREQ:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RFRQ)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & (QCT_QTIMER_CNTPL0ACR_PL0PCTEN |
>> +                                      QCT_QTIMER_CNTPL0ACR_PL0VCTEN))) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        *data = s->qtimer->freq_hz;
>> +        return MEMTX_OK;
>> +    case QCT_QTIMER_CNTP_CVAL_LO:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        *data = extract64(s->cntval, 0, 32);
>> +        return MEMTX_OK;
>> +    case QCT_QTIMER_CNTP_CVAL_HI:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        /* HI half is 24-bit per TRM; bits [31:24] are reserved. */
>> +        *data = extract64(s->cntval, 32, QCT_QTIMER_CNT_HI_BITS);
>> +        return MEMTX_OK;
>> +    case QCT_QTIMER_CNTPCT_LO:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RPCT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0PCTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        *data = extract64(hex_timer_now(s), 0, 32);
>> +        return MEMTX_OK;
>> +    case QCT_QTIMER_CNTPCT_HI:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RPCT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0PCTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        *data = extract64(hex_timer_now(s), 32, QCT_QTIMER_CNT_HI_BITS);
>> +        return MEMTX_OK;
>> +    case QCT_QTIMER_CNTP_TVAL:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        *data = (uint32_t)(int32_t)(int64_t)(s->cntval - hex_timer_now(s));
>> +        return MEMTX_OK;
>> +    case QCT_QTIMER_CNTP_CTL:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        /*
>> +         * CNTP_CTL: bit 0 EN, bit 1 IMASK, bit 2 ISTAT (interrupt
>> +         * pending). ISTAT tracks int_level and is read-only.
>> +         */
>> +        *data = s->control | ((s->int_level & 0x1) << 2);
>> +        return MEMTX_OK;
>> +    case QCT_QTIMER_CNTPL0ACR:
>> +        *data = view ? 0 : s->cntpl0acr;
>> +        return MEMTX_OK;
>> +    case QCT_QTIMER_VERSION:
>> +        *data = QCT_QTIMER_VERSION_VALUE;
>> +        return MEMTX_OK;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%x\n", __func__,
>> +                      (int)offset);
>> +        *data = 0;
>> +        return MEMTX_ACCESS_ERROR;
>> +    }
>> +}
> Similar to a previous series, it seems like we could use a table (or at
> least a CHECK macro to remove redundant code for each register.
> Same for write function below.


I'll add an access_ok() check to remove redundancies.


>> +
>> +static MemTxResult hex_timer_write(void *opaque, hwaddr offset,
>> +                                   uint64_t value, unsigned size,
>> +                                   MemTxAttrs attrs)
>> +{
>> +    QCTQtimerState *qs = opaque;
>> +    uint32_t reg_offset;
>> +    uint32_t view;
>> +    QCTHextimerState *s = qct_qtimer_demux(qs, offset, &reg_offset, &view);
>> +    uint32_t frame;
>> +
>> +    if (!s) {
>> +        return MEMTX_ACCESS_ERROR;
>> +    }
>> +    frame = s - qs->timer;
>> +
>> +    trace_qtimer_write(offset, value);
>> +
>> +    if (!qct_qtimer_view_visible(qs, frame, view)) {
>> +        return MEMTX_OK;
>> +    }
>> +
>> +    switch (reg_offset) {
>> +    case QCT_QTIMER_CNTP_CVAL_LO:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        s->int_level = 0;
>> +        s->cntval = deposit64(s->cntval, 0, 32, value);
>> +        hex_timer_rearm(s);
>> +        break;
>> +    case QCT_QTIMER_CNTP_CVAL_HI:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        s->int_level = 0;
>> +        /* HI half is 24-bit per TRM; bits [31:24] are reserved. */
>> +        s->cntval = deposit64(s->cntval, 32, QCT_QTIMER_CNT_HI_BITS, value) &
>> +                    QCT_QTIMER_CNT_MASK;
>> +        hex_timer_rearm(s);
>> +        break;
>> +    case QCT_QTIMER_CNTP_CTL:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        /* ISTAT (bit 2) is read-only; keep SW writes from polluting it. */
>> +        s->control = value & ~QCT_QTIMER_CNTP_CTL_ISTAT;
>> +        hex_timer_rearm(s);
>> +        break;
>> +    case QCT_QTIMER_CNTP_TVAL:
>> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
>> +            return MEMTX_ACCESS_ERROR;
>> +        }
>> +        /* TVAL write: CVAL = CNTPCT + TVAL (TVAL is signed 32-bit). */
>> +        s->int_level = 0;
>> +        s->cntval = (hex_timer_now(s) + (int64_t)(int32_t)value) &
>> +                    QCT_QTIMER_CNT_MASK;
>> +        hex_timer_rearm(s);
>> +        break;
>> +    case QCT_QTIMER_CNTPL0ACR:
>> +        if (!view) {
>> +            s->cntpl0acr = value;
>> +        }
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%x\n", __func__,
>> +                      (int)offset);
>> +        return MEMTX_ACCESS_ERROR;
>> +    }
>> +    hex_timer_update(s);
>> +    return MEMTX_OK;
>> +}
>> +
>> +static void hex_timer_tick(void *opaque)
>> +{
>> +    QCTHextimerState *s = opaque;
>> +    uint64_t now = hex_timer_now(s);
>> +    uint64_t diff56 = (now - s->cntval) & QCT_QTIMER_CNT_MASK;
>> +    int64_t signed_diff = (int64_t)(diff56 << 8) >> 8;
>> +
>> +    if (signed_diff >= 0) {
>> +        s->int_level = 1;
>> +        hex_timer_update(s);
>> +    } else {
>> +        hex_timer_rearm(s);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps hex_timer_ops = {
>> +    .read_with_attrs = hex_timer_read,
>> +    .write_with_attrs = hex_timer_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +        .unaligned = false,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +};
>> +
>> +static const VMStateDescription vmstate_qct_hextimer = {
>> +    .name = "qct-hextimer",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32(control, QCTHextimerState),
>> +        VMSTATE_UINT32(cnt_ctrl, QCTHextimerState),
>> +        VMSTATE_INT64(offset_ns, QCTHextimerState),
>> +        VMSTATE_UINT64(cntval, QCTHextimerState),
>> +        VMSTATE_UINT32(cntpl0acr, QCTHextimerState),
>> +        VMSTATE_UINT32(int_level, QCTHextimerState),
>> +        VMSTATE_TIMER_PTR(timer, QCTHextimerState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_qct_qtimer = {
>> +    .name = "qct-qtimer",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32(freq_hz, QCTQtimerState),
>> +        VMSTATE_UINT32(secure, QCTQtimerState),
>> +        VMSTATE_STRUCT_VARRAY_UINT32(timer, QCTQtimerState, nr_frames,
>> +                                    1, vmstate_qct_hextimer, QCTHextimerState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void qct_qtimer_realize(DeviceState *dev, Error **errp)
>> +{
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    QCTQtimerState *s = QCT_QTIMER(dev);
>> +    unsigned int i;
>> +
>> +    if (s->nr_frames > QCT_QTIMER_TIMER_FRAME_ELTS) {
>> +        error_setg(errp, "nr_frames too high");
>> +        return;
>> +    }
>> +    if (s->nr_views > QCT_QTIMER_TIMER_VIEW_ELTS) {
>> +        error_setg(errp, "nr_views too high");
>> +        return;
>> +    }
>> +    if (s->freq_hz == 0) {
>> +        error_setg(errp, "freq-hz must be nonzero");
>> +        return;
>> +    }
>> +    if (s->frame_stride == 0 || !is_power_of_2(s->frame_stride)) {
>> +        error_setg(errp, "frame_stride must be a nonzero power of two");
>> +        return;
>> +    }
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &qct_qtimer_ac_ops, s,
>> +                          "qct-qtimer-ac", QTIMER_MEM_SIZE_BYTES);
>> +    sysbus_init_mmio(sbd, &s->iomem);
>> +
>> +    memory_region_init_io(&s->view_iomem, OBJECT(s), &hex_timer_ops, s,
>> +                          "qct-qtimer-view",
>> +                          (uint64_t)s->frame_stride * s->nr_frames *
>> +                          s->nr_views);
>> +    sysbus_init_mmio(sbd, &s->view_iomem);
>> +
>> +    for (i = 0; i < s->nr_frames; i++) {
>> +        QCTHextimerState *t = &s->timer[i];
>> +
>> +        t->qtimer = s;
>> +        s->secure |= (1 << i);
>> +
>> +        sysbus_init_irq(sbd, &t->irq);
>> +        t->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hex_timer_tick, t);
>> +    }
>> +}
>> +
>> +static void qct_qtimer_unrealize(DeviceState *dev)
>> +{
>> +    QCTQtimerState *s = QCT_QTIMER(dev);
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < s->nr_frames; i++) {
>> +        QCTHextimerState *t = &s->timer[i];
>> +
>> +        if (t->timer) {
>> +            timer_free(t->timer);
>> +            t->timer = NULL;
>> +        }
>> +    }
>> +}
>> +
>> +static void qct_qtimer_reset_hold(Object *obj, ResetType type)
>> +{
>> +    QCTQtimerState *s = QCT_QTIMER(obj);
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < s->nr_frames; i++) {
>> +        QCTHextimerState *t = &s->timer[i];
>> +
>> +        /*
>> +         * Per TRM: CTL = 0 (EN=0, IMASK=0, ISTAT=0), CVAL = 0 so that
>> +         * TVAL (= CVAL - CNTPCT) also reads 0 at reset. The QEMUTimer is
>> +         * only armed when SW sets CTL.EN=1, so cntval=0 does not cause a
>> +         * spurious fire before SW programs the compare value.
>> +         */
>> +        t->control = 0;
>> +        t->cnt_ctrl = QCT_QTIMER_AC_CNTACR_RWPT | QCT_QTIMER_AC_CNTACR_RWVT |
>> +                      QCT_QTIMER_AC_CNTACR_RVOFF | QCT_QTIMER_AC_CNTACR_RFRQ |
>> +                      QCT_QTIMER_AC_CNTACR_RPVCT | QCT_QTIMER_AC_CNTACR_RPCT;
>> +        t->cntval = 0;
>> +        t->cntpl0acr = 0;
>> +        t->int_level = 0;
>> +        t->offset_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +        timer_del(t->timer);
>> +        qemu_set_irq(t->irq, 0);
>> +    }
>> +}
>> +
>> +static const Property qct_qtimer_properties[] = {
>> +    DEFINE_PROP_UINT32("freq-hz", QCTQtimerState, freq_hz,
>> +                       QTIMER_DEFAULT_FREQ_HZ),
>> +    DEFINE_PROP_UINT32("freq-scale", QCTQtimerState, freq_scale, 1),
>> +    DEFINE_PROP_UINT32("nr_frames", QCTQtimerState, nr_frames, 2),
>> +    DEFINE_PROP_UINT32("nr_views", QCTQtimerState, nr_views, 1),
>> +    DEFINE_PROP_UINT32("frame_stride", QCTQtimerState, frame_stride, 0x1000),
>> +    DEFINE_PROP_UINT32("cnttid_0", QCTQtimerState, cnttid_0, 0x11),
>> +    DEFINE_PROP_UINT32("cnttid_1", QCTQtimerState, cnttid_1, 0x0),
>> +};
>> +
>> +static void qct_qtimer_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>> +
>> +    device_class_set_props(dc, qct_qtimer_properties);
>> +    dc->realize = qct_qtimer_realize;
>> +    dc->unrealize = qct_qtimer_unrealize;
>> +    dc->vmsd = &vmstate_qct_qtimer;
>> +    rc->phases.hold = qct_qtimer_reset_hold;
>> +}
>> +
>> +/* QTimer interface implementation, backing HEX_SREG_TIMERLO/TIMERHI */
>> +static uint32_t qct_qtimer_get_timer_lo_impl(const QctQtimerInterface *obj)
>> +{
>> +    QCTQtimerState *s = QCT_QTIMER((QctQtimerInterface *)obj);
>> +
>> +    return s->nr_frames > 0 ? extract64(hex_timer_now(&s->timer[0]), 0, 32)
>> +                            : 0;
>> +}
>> +
>> +static uint32_t qct_qtimer_get_timer_hi_impl(const QctQtimerInterface *obj)
>> +{
>> +    QCTQtimerState *s = QCT_QTIMER((QctQtimerInterface *)obj);
>> +
>> +    return s->nr_frames > 0 ? extract64(hex_timer_now(&s->timer[0]), 32, 32)
>> +                            : 0;
>> +}
>> +
>> +static void qct_qtimer_interface_class_init(ObjectClass *klass,
>> +                                            const void *data)
>> +{
>> +    QctQtimerInterfaceClass *k = QCT_QTIMER_INTERFACE_CLASS(klass);
>> +
>> +    k->get_timer_lo = qct_qtimer_get_timer_lo_impl;
>> +    k->get_timer_hi = qct_qtimer_get_timer_hi_impl;
>> +}
>> +
>> +static const TypeInfo qct_qtimer_types[] = {
>> +    {
>> +        .name = TYPE_QCT_QTIMER_INTERFACE,
>> +        .parent = TYPE_INTERFACE,
>> +        .class_size = sizeof(QctQtimerInterfaceClass),
>> +        .class_init = qct_qtimer_interface_class_init,
>> +    },
>> +    {
>> +        .name = TYPE_QCT_QTIMER,
>> +        .parent = TYPE_SYS_BUS_DEVICE,
>> +        .instance_size = sizeof(QCTQtimerState),
>> +        .class_init = qct_qtimer_class_init,
>> +        .interfaces = (InterfaceInfo[]) {
>> +            { TYPE_QCT_QTIMER_INTERFACE },
>> +            { }
>> +        },
>> +    },
>> +};
>> +
>> +DEFINE_TYPES(qct_qtimer_types)
>> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
>> index b3d823ce2c3..e1b751a54a7 100644
>> --- a/hw/timer/Kconfig
>> +++ b/hw/timer/Kconfig
>> @@ -65,3 +65,6 @@ config STELLARIS_GPTM
>>   
>>   config AVR_TIMER16
>>       bool
>> +
>> +config HEX_QTIMER
>> +    bool
>> diff --git a/hw/timer/meson.build b/hw/timer/meson.build
>> index 201b5d8316d..0e8326b0492 100644
>> --- a/hw/timer/meson.build
>> +++ b/hw/timer/meson.build
>> @@ -34,3 +34,5 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
>>   system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
>>   
>>   system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
>> +
>> +specific_ss.add(when: 'CONFIG_HEX_QTIMER', if_true: files('qct-qtimer.c'))
> Is there something preventing it from being in system_ss?
> The file itself can be conditionnally included by meson, but it does not
> seem to have target specifics in itself (or maybe through one header).

I'll change it to `system_ss`.


>
>> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
>> index 634ba1da27a..636310f8caa 100644
>> --- a/hw/timer/trace-events
>> +++ b/hw/timer/trace-events
>> @@ -128,3 +128,8 @@ imx_epit_get_freq(uint32_t freq) "ptimer frequency is %u"
>>   imx_epit_read(const char *name, uint32_t value) "(%s) = 0x%08x"
>>   imx_epit_write(const char *name, uint64_t value) "(%s, value = 0x%08" PRIx64 ")"
>>   imx_epit_cmp(uint32_t sr) "sr was %d"
>> +
>> +# qct-qtimer.c
>> +qtimer_interrupt(void) "qtimer interrupt line updated"
>> +qtimer_read(uint64_t offset) "offset 0x%" PRIx64
>> +qtimer_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64

