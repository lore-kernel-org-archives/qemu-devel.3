Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217B5C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu5Qr-000592-4U; Wed, 12 Aug 2026 05:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu5Qp-00058l-SB
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:39:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu5Qn-0004oT-FG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:39:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C9InvM3077209
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lNPLJO9dGeTgjZZVprqwtSB1h+9DCYxqeQqA5RQTzW4=; b=EzDIL64iO3zjmBsj
 Ue2trSsFyEDcGik09/Q1cIL3Pk0hdJJaASYHnWa2Ved9qlVXruTQwIXzOL2OBhCP
 LOQa+pAAsJcQTyny0ESlJ17pXWmH2M3xhnZ2CJnhykbh3fZfUnaBPknIVkoiISsr
 C1Wj0SiLZ04FJ1Quz9zN5JIOSgFjNfGIJ4Wvfj8Hnuk2tn2t+8VOTZjUjteOlUl1
 a4sHLWdpqGL0hfVML5tLgG3AFBQtgQMsq5YzSJTZWSjVG3iEMYYfNXmzVE8asY4/
 Q8rMxFSRqLGzYYmFzBGRCJoTNxNc/mvPXo0MIc47+0GvRXQdGIpG6BcrI2W8xznT
 ZMjAVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d02ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:39:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso7366801cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 02:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786527566; x=1787132366; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lNPLJO9dGeTgjZZVprqwtSB1h+9DCYxqeQqA5RQTzW4=;
 b=e2gmX+fTp01NGJp3t3Sy+JZIogUaoZ/jrQqpo1MHrm1ymo0M3esJQQVjIzob3nkBNA
 CwxbISMpfuQf9Bfv3GAD7v3YSSSnKr65ZDJ71swM593G2LR6RL4nqw8KtjKan22zDTGU
 l+L8Vu9CySNNu3czCX4B2FRTIRVTIKrfet3czUq5Eh8sTO18tU5vgZOJ16xQW8BngtOM
 g1IAnKStJ+40Yy96cWfhMg8T3qjE4IIS1CCBqGqUWV3esLmK0N9TncDsKlAAIWRH/jYG
 5zq50Wtl034W3+X9pmfikRC3mJ9gQoTmgwMeV46aqU75sywH2GJqivPFQh++qaJdsg9L
 qPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786527566; x=1787132366;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lNPLJO9dGeTgjZZVprqwtSB1h+9DCYxqeQqA5RQTzW4=;
 b=no6WLYPD6BTmmopLXxY0U/yB2sLBO1fvSsrRhkY7EwxdG7aArzIPtpwwGp+BCu7gDG
 yPFx2Ahg0tf8GNtiT7xy7L90/xT6s+xSXtqYo0v/sBtw3pvPQu0+WEN9+rrpFlEm5gvu
 sdzb4IMqfuq7dBrG2bYDTK+zhFGr3mL8syd1KUqUSlLWpVIfvJ/JAyk1Ewo0r0fOTC3N
 S78EWWaQsxoEIYfUZxHcZg/rQ52Bw3azLpBKN6VSoBFs6eMJL2t0P8YxJR0bSJsFU+H0
 YiE9q6jDwveAq8IMHq54GJFn5JsruMBxUN1fOOvKPY64+QpXYzK4dpUQCQrprcSNSgIz
 dcow==
X-Gm-Message-State: AOJu0YzyxAFxEbr3p9p1UfyLEucgHFZJ6AI6fwAEP+aH2iY0VtWaE3Z1
 L0oxd0Q4wrQ7oe8zR8fqZM9Isn1KIWPbeb64R2c1+4IWNfA9lG+BVWBcIBynX3Jy+azFHZhXeXm
 c1KATvEWS+013Jr5+BsI+lrhioJkFygH9PRdr/2VaUiqaOUIxOXLT1gJuAQ==
X-Gm-Gg: AR+sD11jRQi0eOEVBP+NWuTGR+yDDdMGuP2x08ptNFTfwW3/kDq6ZSnQE7zJZut92bd
 2jqF6Q/WyAGES2BD+zMh774pWFF7xHWJXlG8YS/U4op2ujCENDAwmajWZO/s5wNXt1U6S5Xf9YW
 C8qzCQlKQllrHUF4WOVEmGds7MFNrYJlW1TQjh1WtVM0VOFjbsvIUj+UfXtZd2Ts81NOWzZAgUB
 MTbcBYYvzJUEp26KgUFVLcrNo6229H3c8F7RDn1XL2ZdH5RC7PYSHM5gV+Gb1r/+KoYiecBCtET
 fpRcXnTq7/Iw8b7/BglyGB4gCyRtqFJSlYjJAby92mcCdwDQBzHgG4RoX2ubHqcP/tkHw+SB5fi
 njy9ap0zH2PqH84ZuPMaM+622RXDhQBbzN68=
X-Received: by 2002:ac8:5f10:0:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-52d64805fbamr25673721cf.28.1786527566091; 
 Wed, 12 Aug 2026 02:39:26 -0700 (PDT)
X-Received: by 2002:ac8:5f10:0:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-52d64805fbamr25673521cf.28.1786527565642; 
 Wed, 12 Aug 2026 02:39:25 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d72141sm6020055f8f.36.2026.08.12.02.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 02:39:24 -0700 (PDT)
Message-ID: <6308ccd5-0941-4729-8082-b40657ee421e@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 11:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] target/hexagon: Update TARGET_PAGE_BITS, stubs for
 modify_ssr/get_exe_mode
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
 <20260611052857.3911981-35-brian.cain@oss.qualcomm.com>
 <CAJ+F1CJb1rZPCE8euSqdwojNRTHtquOYcT+BTWjuO_c8oKYgqg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJ+F1CJb1rZPCE8euSqdwojNRTHtquOYcT+BTWjuO_c8oKYgqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q3YDjo4uL0R6qQQLiED9UGfoJ9Zx4rPA
X-Proofpoint-GUID: q3YDjo4uL0R6qQQLiED9UGfoJ9Zx4rPA
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7c3f4e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=3Y4bHdc0Ay6CIvZ6QhIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3NyBTYWx0ZWRfX8y7Sijc8PHXh
 /dh9+poIs6JDuyh3+TX8e4gVqZK8sNP47Ove/zoo0hy7GCzp1mVWEh7zzgiw4RqFrLyBppfSXJU
 sBXp1CjnvNaMYQZDR/Xv0dyyPA6NXVtGzL7WcYTEZdivl35+oaZdFf2gSznSFzL3F6IIJ8Jz6Jn
 Ic5BCyFYJyhXovtPf+20i5qSdsVk0Q3Th4ON5F8nP8i1RymQWQ7h9xyounLbvZFAyv4yJAifASa
 9BeR4UKk51KWPUASG7HziJ/SEGTTrbnsoC4KF6d3qdIooRFQQIzM+pK4Q9LyxaQifNlZ9a9DjJE
 mH/I/WWirD/NQEEsmpkdkyygZ7dxbB6nVO+a8W1Pqwr+AxD5xGuMzyAXWx8wvMZJYp3WoyUKV+T
 pAkVRJc3Y1wN2PlUQHGGo3UH0MEQ1O7pPav28by5N1QaJ5fQPfqlTr0kIHV4mqq754jiqBMCJ92
 3PEqM6VBiWurrnGu/xQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3NyBTYWx0ZWRfXxHMVda3q+Yfl
 r/j6ncODm0MRwhK7mUGhDdVPROeJU7vkHHixESXZOyWz6fnMFvEfK3aIO5lcdwNN1MwmFwW+846
 twnh7qZ2HECtbw5zYh4XndZOUldPY9o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 12/8/26 08:59, Marc-AndrÃ© Lureau wrote:
> Hi Brian
> 
> On Thu, Jun 11, 2026 at 9:31 AM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>
>> Add hex_mmu.[ch], cpu mode helpers, and additional includes/stubs
>> that integrate the TLB device with the CPU model.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu-param.h  |   2 +-
>>   target/hexagon/cpu.h        |  21 +++
>>   target/hexagon/hex_mmu.h    |  26 ++++
>>   target/hexagon/internal.h   |   9 ++
>>   target/hexagon/sys_macros.h |   3 +
>>   target/hexagon/cpu.c        |  36 +++++
>>   target/hexagon/hex_mmu.c    | 268 ++++++++++++++++++++++++++++++++++++
>>   7 files changed, 364 insertions(+), 1 deletion(-)
>>   create mode 100644 target/hexagon/hex_mmu.h
>>   create mode 100644 target/hexagon/hex_mmu.c


>> diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
>> new file mode 100644
>> index 00000000000..4f556c715a9
>> --- /dev/null
>> +++ b/target/hexagon/hex_mmu.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HEXAGON_MMU_H
>> +#define HEXAGON_MMU_H
>> +
>> +#include "cpu.h"
>> +#include "monitor/monitor.h"
>> +
>> +extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value);
>> +extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA);
>> +extern void hex_mmu_on(CPUHexagonState *env);
>> +extern void hex_mmu_off(CPUHexagonState *env);
>> +extern void hex_mmu_mode_change(CPUHexagonState *env);
>> +extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
>> +                               MMUAccessType access_type, hwaddr *PA, int *prot,
>> +                               uint64_t *size, int32_t *excp, int mmu_idx);
>> +extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
>> +                                 uint64_t index);
>> +extern void hex_tlb_lock(CPUHexagonState *env);
>> +extern void hex_tlb_unlock(CPUHexagonState *env);
>> +void dump_mmu(Monitor *mon, CPUHexagonState *env);
> 
> dump_mmu() is unused, should it be dropped or commented out (and
> reintroduced when wired to info tlb?)

Indeed we are missing the hmp_info_tlb() binding.

We are not testing "info tlb" at all, so hard to blame anyone.

If we want to keep having this HMP command I suppose we should
convert each target to qmp_info_tlb() and have a generic HMP
dispatch. (out of scope of this Hexagon patch).

>> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
>> new file mode 100644
>> index 00000000000..c921e82b377
>> --- /dev/null
>> +++ b/target/hexagon/hex_mmu.c
>> @@ -0,0 +1,268 @@


>> +void dump_mmu(Monitor *mon, CPUHexagonState *env)
>> +{
>> +    HexagonCPU *cpu = env_archcpu(env);
>> +    hexagon_tlb_dump(mon, cpu->tlb);
>> +}

