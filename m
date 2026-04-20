Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2A9F5A8AB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEtS2-0002h1-KP; Mon, 20 Apr 2026 14:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEtRj-0002eH-OW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:34:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEtRh-00025v-PG
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:34:11 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KIRL4d3212117
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ApRqMy1kqzGBsTRNHmo/vGRa+5pguJVky5xmotYkGLs=; b=d/a5CaqMfh8aAKnW
 uwMAcVVKLVI+K9dTGDWDxUEuUD7hULh3un8HzuSVjd7EEPiQSR2aRy72J6OTyKYE
 5zIAtbXZLM7QkrlYc3XIJnybyVB8PpJ7bwHQsDf+6vhI0Gsmn5uyVh9KWUzMppQo
 KKBMYadF5UmCzmMgs/f72ZGIkym/I8gfuC7P4CKLpWVL8F3q+BKTI0b4AvZOiNJ3
 vN1+884tLgXP31lOHvUIyLSYDtc1QgoMd87yRlvjDR36yZ7Dl/XOfENGjsfOaYzD
 W6uq+pdvHSXCmy0mnISV2hlUvkg7r//QFQDn5WMIIWr7aFMQZ5+8UrIc54Myr9hm
 UpobyA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfcfjstt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:34:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so5095784eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776710046; x=1777314846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ApRqMy1kqzGBsTRNHmo/vGRa+5pguJVky5xmotYkGLs=;
 b=hRfAeUTdh6qNiEaGYxu7tABXxi0zThVi7hyXocbAIlx2p3smw/NEbq1nubWo9KOCmb
 2Uct1Pwcz757bS15B8jhF8kZCR9vKbdXU3CvDpyEJhHAKhMClfxvTKLxAtwZdqNyUQB9
 T3slGNGkIL42FAHyv/ZlcpTWyRQtu6qwAo35hKLahSgyurPpbp4FuouIODrO4ks0P2gx
 Dg5RhbyM83ACmJoIuwEJkmyFk30n7kFtwpFRKs8bO5OX0yfKbYQtEyWgB95sudjXa0c1
 pStB9b2CRBstb3dbOYz8qx+9z4GBRGzcAe4iRklhQfI/j4U+1SB6D7AZWWggbFNB/e2b
 Gz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776710046; x=1777314846;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ApRqMy1kqzGBsTRNHmo/vGRa+5pguJVky5xmotYkGLs=;
 b=nojpSlHgLl/q8vRE9qFZnJxKFMMaVPrI1NLqUjrb/4suvZArpeikGnSTaRpuDJVMIa
 apYENti+RtAg8r4Ds2Famoog0BcHHaPTRBxBwUdkl9NoFTBe2/NJ/comDmFO50Jqe99Z
 PdtOoSqPDyX5E3vORAQnJq1fA+sWlS2C+TMNsFjHAFvClVxGxB/FQ56tpYX98xVwfu3A
 gG3UGY3jLJrfnmZrEEsQXkWqo0dx4nZPFRDJ+wi31Nmoh0ZemMudybqemSVzmgPiYT2v
 T3nVamDYfT2O2pRTR0gY8/6tE0S0iYrIxr6XTNkG3yRXwDjJ5Y8sP/kWJ7ildrSPSyaE
 QO5w==
X-Gm-Message-State: AOJu0Yxp7bndYRkrqSiQ9clYmkRA9FioYvPlD+oyU1ayYU3FqYK0Qzsc
 nRGsqB98Hx4MU47FFQmt7KF8wM0RzxKqx0e24yCAe0rBhK/ziTEuzEOcgF+g3EVNXKfahZSPcYq
 kZhfNde56kokYzfAVAi2LZS7VrR5C1EZyGy+emBkItTNUs0WrzWN8rbSR0A==
X-Gm-Gg: AeBDietYGG2HrOk1GMORQhkkujKgveY6d1MP2g+0LKAZhr0v3BsZEsYdcOPkeyfcqVt
 NTcZ2BPf9YBd53+pbuEtudtarxtWHdrNtBmfrj1bwTUY7fGE1LKmG7nGeWHJTJPnd+nluFmnl51
 1/gLptdMSYFr6vn22F98SXQpLZwKxrk0btEQIo/LISX91/zpDyw2tCBENFmFin5GSOKQYsyfD55
 h4U+4Lsonyc39qoEYWWYMFfi1F8l/V1wwr0yNsPqIJkKXuxwAUoWdX3pLOXuCeGJAROijn+v/ip
 dq8Rh0eZYMZHOhMZpUJo7vMDuD142MvWzUy62h3kQ1e3NekOMXq+T059nB5kc313X0YqrVH+JXH
 Zhaqq8Dy4Nrkgcs0uipZFc4e/UXpCfxuFsm/n3KIIa8ilrPxeZeslZ355xlimcoMee/3SeCjDJp
 UqD8ciJDOPPpD00iS92jGwrJom
X-Received: by 2002:a05:7301:1698:b0:2d9:89c8:8893 with SMTP id
 5a478bee46e88-2e466044892mr6731939eec.3.1776710046407; 
 Mon, 20 Apr 2026 11:34:06 -0700 (PDT)
X-Received: by 2002:a05:7301:1698:b0:2d9:89c8:8893 with SMTP id
 5a478bee46e88-2e466044892mr6731886eec.3.1776710045681; 
 Mon, 20 Apr 2026 11:34:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm15985691eec.3.2026.04.20.11.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 11:34:05 -0700 (PDT)
Message-ID: <67c40737-c5f0-4b4c-afaa-cf466fd7460f@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:34:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 37/37] target/hexagon: Add hex_interrupts support
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>, Michael Lambert <mlambert@quicinc.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-38-brian.cain@oss.qualcomm.com>
 <ebd8b10e-90d9-4267-b117-9e9a8a564cf5@oss.qualcomm.com>
 <CAEqNhNamfBvyhE4JFp5xDwgB3S6dxN8UnL04-VM2juKoTY2OzQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAEqNhNamfBvyhE4JFp5xDwgB3S6dxN8UnL04-VM2juKoTY2OzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4MCBTYWx0ZWRfX8WCJeK14hkW+
 nNZV65vjEVluazAMCTiSV7QOvorm3c+Ik3BF2wdP/gzKQhyIUgytTPMv3THIIY169LHVu8kR6Ci
 VABmvbWioSraIpahxA8B8m+UPmDKCwaomZhnjUmaSyaSEYA1cHCPnoLZTK+miWbRVxBPeWFBjPp
 fl41qi0VHbEyfyJjtgnb/Ak4prMv1V+UC+8d9kRL5eJbF6WI6XlE6LXWJkQ6KphHBEpoIClOpl2
 9ZYaoRN2mPLQmUwvcxbRfdM16ofwk+NhLMM/RbvYGo2K4PgvjaJ/dYyWVthx9oY8V+bAgcD59KY
 e6VeRu1CJt0h6KYeEQUvy965JPiXP2eLfei8WPRbw77432JUogkSFOANGJlT161U7puqoynKGOT
 btXw7wA2srdNiW90xQLkinx7PO19My/8HqTQvwdFd1+GZCcghpvX+2kJMzchHxzQS5wSwhNSVVW
 WpCPS9JjJqQA/YK/ABA==
X-Proofpoint-ORIG-GUID: MUO9hB3lOLCzRkMmFRPueFZTKH76ZiYK
X-Proofpoint-GUID: MUO9hB3lOLCzRkMmFRPueFZTKH76ZiYK
X-Authority-Analysis: v=2.4 cv=L+ItheT8 c=1 sm=1 tr=0 ts=69e6719f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=Qqn3tbOjeLx0eTyRt0sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200180
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/20/2026 11:12 AM, Brian Cain wrote:
> On Mon, Apr 20, 2026 at 12:54 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 4/1/2026 8:26 AM, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>>> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    target/hexagon/cpu.h            |   2 +
>>>    target/hexagon/hex_interrupts.h |  15 ++
>>>    target/hexagon/cpu.c            |   4 +
>>>    target/hexagon/hex_interrupts.c | 379 ++++++++++++++++++++++++++++++++
>>>    4 files changed, 400 insertions(+)
>>>    create mode 100644 target/hexagon/hex_interrupts.h
>>>    create mode 100644 target/hexagon/hex_interrupts.c
>>>
>>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>>> index c4fac9c2d38..3049b5a411a 100644
>>> --- a/target/hexagon/cpu.h
>>> +++ b/target/hexagon/cpu.h
>>> @@ -196,6 +196,8 @@ struct ArchCPU {
>>>        bool short_circuit;
>>>    #ifndef CONFIG_USER_ONLY
>>>        HexagonTLBState *tlb;
>>> +    uint32_t boot_addr;
>>> +    HexagonGlobalRegState *globalregs;
>>>        uint32_t htid;
>>>    #endif
>>>    };
>>> diff --git a/target/hexagon/hex_interrupts.h b/target/hexagon/hex_interrupts.h
>>> new file mode 100644
>>> index 00000000000..6b6f5403633
>>> --- /dev/null
>>> +++ b/target/hexagon/hex_interrupts.h
>>> @@ -0,0 +1,15 @@
>>> +/*
>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef HEX_INTERRUPTS_H
>>> +#define HEX_INTERRUPTS_H
>>> +
>>> +bool hex_check_interrupts(CPUHexagonState *env);
>>> +void hex_clear_interrupts(CPUHexagonState *env, uint32_t mask, uint32_t type);
>>> +void hex_raise_interrupts(CPUHexagonState *env, uint32_t mask, uint32_t type);
>>> +void hex_interrupt_update(CPUHexagonState *env);
>>> +
>>> +#endif
>>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>>> index 4e9c65f785a..9ae8e104043 100644
>>> --- a/target/hexagon/cpu.c
>>> +++ b/target/hexagon/cpu.c
>>> @@ -59,6 +59,9 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>>>
>>>    static const Property hexagon_cpu_properties[] = {
>>>    #if !defined(CONFIG_USER_ONLY)
>>> +    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffff),
>>> +    DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
>>> +        TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
>>>        DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
>>>    #endif
>> I expect global-regs to always be set, and thus cpu->globalregs to
>> always be non NULL.
>> Thus why should be check if it's set in all interrupts related functions?
> 
> I did this for `-machine=none` test cases.  It may be overkill, but
> there's definitely *some* target/hexagon/ code that gets executed for
> those.
>

I see.

> I'll take a closer look and maybe we can omit these.
>

In this case, we might simply add a wrapper hex_{read/write}_global_regs 
which has no effect if cpu->globalregs is NULL.
For the code that still needs to check if globalregs is really 
available, `if (cpu->globalregs)` can still be used.

>> Regards,
>> Pierrick


