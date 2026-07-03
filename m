Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D09C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgKI-0004KH-71; Fri, 03 Jul 2026 12:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgJZ-00048M-GQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:00:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgJX-0002MW-QA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:00:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663Bqhhp4091101
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D9yKp3ZZGm39sMrmqjMtzaMN+dCyINSfUcdAfaRLQgA=; b=OCs10qwnQjs07JPQ
 h4hSYQtlza707wuD2cCoCAqXHyM+LolJwRTaTb4VJ3KXWPmEXw8VgZED4MHl79W8
 MKcDC1l3JD7/ODJes1x8ZSGX+JZtbgpPCawKqgFekL8jM8/gNnUGgTv8U8teOroC
 xcKhGd2Nr0FoAHv/DZAshBkISkbbct0J+pELMjwBDYcLE+1lxRQ/yMhzP15NtxBq
 X8mBrzPu2WisDryGtOrN5UFuWBCRMI3CP2CHCj7gI9hy0fia2tI7Em7etWF/pm2u
 AAY+ewB+uF6D70eoyJvku5w5rJP1sP74W95zXP8oXewGVBxVmS0SKLwrdpKEX/aC
 drZjQw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0u78-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:00:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so76075085a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783094425; x=1783699225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9yKp3ZZGm39sMrmqjMtzaMN+dCyINSfUcdAfaRLQgA=;
 b=KbFC/nn51QW/RBK4qPIwzL4WJ75GGCDP1sS8Q1jO8fZ8xQ8Xq6S+4Spzw2uMSvBHaV
 BeCwHFb5FAnX7gq5F4hLP+ZZ4uw+rZWSCmd7cg3wx1Zk++6mDYnnqZTfbcKu9wUOoThy
 rIlhjeTftFz1MsxZvsTMOVYxzSyAHI3L6fDWwIh1nLcXa2M9vSbuEonHP1o60wrxxmGq
 36yO5F/W1B9pDzb0sumW26tkqz96hmA29BDBuPzELGzGVL4RgkNtyLOldpU9IesODU6X
 xElHqW7Q4bhIdwis6R6vBi9S8FNndhEQsnm1CczZmRAhsDVpHWJl97UrfbL11nskWZRP
 vqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783094425; x=1783699225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9yKp3ZZGm39sMrmqjMtzaMN+dCyINSfUcdAfaRLQgA=;
 b=LbAjr1vl4QLcT5tbc7LuKXhBBiOxjyNFEfIDYjfVqz14aJ5rLq6ihZZeCCw5T3bfLy
 iwhHiVxZsdFrw5tvsJbTo3SQYGZDLBkRjhg76B4+nBd1kHzqXIS1mK28xlsmWKn1y4rP
 SsQMOF4Mpdaf7U3jVFsGHn38JR9gRp7tAt4ZHISMY6B4FVQPsSZU8JBfJ7E8SXkMmwuB
 8qQz4gCisQKY7iXTLf4qxBFolzdttEqdso+ORn2QSmbqdRhhafXS2sMk5vhCZP02S0HI
 OumkJ5l4ZbufAq30n2u9x/DJdOQuapbLk6sJHHiHPy3+Thq6csxWOZsEXgWiuMQW+H/q
 AkMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8f4fjFyUmT6FpDCvrjlxDrHvHIM/5aiG9lLuL8ur0cd1aGepJk2MsLb2bj/3F3EOe9kVrrOokThb4g@nongnu.org
X-Gm-Message-State: AOJu0Yy0J1zwRFVVyTWt719HaeVJF8H1T2yfd76IRrX9KQVTLQknA70n
 w5KYTZF+2Mg7BM3n1x3c/E19r3ts6QgQYV7vDhKzPecBJNsHYzdjqsc9Mrxv4nG8rNMWXGQhNBm
 l5ut/b11AK6Wy7J0MQ0Djg0q5WSi3sDb6J5R6zav0qYZEbQVtfSghKlyN3g==
X-Gm-Gg: AfdE7cmwvTZmPRtZ/jsZNOKbiW3U1emN1C7gz6tF2P+69zwWjJ5fubKT9tjps5kcBae
 M//zQNI56mYqytq9kJtBJYsL7p+dRs3f4tZMijgc5bCuF2DI2Z0d+39TBfDLni3hpMMc99NWlhC
 Nop7zueGei2+cOYXlrANPFElI2maYYc61QeCKAnNN9B3PUc05tglXb7Ab9ogvVtVU6HaQtwelZ7
 bdB60Dfw6Iv74pvAxkUHIiD6yOCg4Tie6cPPxECOUm85n3EOPQW/AieqzMe1blajwMRzWwHynCQ
 ZwFwCLbPpeXodPy+7M/LRLD2Le+QOAF7JTTkLrKUjxuBhR6zoFkIXnQ/SZ9YayE2/NCv9Viu92O
 OVscTeEO/SYIeeHBw4FbSfit5ZxU5XhV1VbgM37EmsusOkrCyCPTTkz6RmIhEnw==
X-Received: by 2002:a05:620a:408b:b0:925:dce9:4773 with SMTP id
 af79cd13be357-92e8b56256cmr585042385a.35.1783094424257; 
 Fri, 03 Jul 2026 09:00:24 -0700 (PDT)
X-Received: by 2002:a05:620a:408b:b0:925:dce9:4773 with SMTP id
 af79cd13be357-92e8b56256cmr585023585a.35.1783094423196; 
 Fri, 03 Jul 2026 09:00:23 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bf11eba5sm144992625e9.0.2026.07.03.09.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 09:00:22 -0700 (PDT)
Message-ID: <7865c724-97be-4e51-9352-c256154fd665@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 18:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-4-daniel.barboza@oss.qualcomm.com>
 <18ce4e8c-bb35-49c2-abee-9145a33d95ec@oss.qualcomm.com>
 <10315dfc-37f1-40fb-bbf5-b2c5f460c956@oss.qualcomm.com>
 <37525427-720b-48af-a906-8cc1062e7ed0@oss.qualcomm.com>
 <104fa6b5-fb9e-42b3-b74b-a31fc554ffc6@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <104fa6b5-fb9e-42b3-b74b-a31fc554ffc6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1OCBTYWx0ZWRfX/X1YkTPwPPju
 BXbVBPkpP5Y2YMFUoMHUhpOqL7sCFRupTnf5trYxJ+5qH2RwioJ5E6Z/f3KxYqFIGulICYxe6su
 4RYd9m7vxlzy9cYsB7lf/Aufsm0q/ek=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47dc99 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8 a=KNUYBBPBvgDUunmgLloA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: nY-oGcOkGztqg3YZ-teHUCTeuKOD7Sv9
X-Proofpoint-GUID: nY-oGcOkGztqg3YZ-teHUCTeuKOD7Sv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1OCBTYWx0ZWRfX5haZF7Fp7qdf
 ZnTUM00FnCpJ4Ud5cfLp+SS9RTNJ53a9fCQB4g/JdpO1tzlm8peQ5Fg+KgElagTuRwLT0OqcZ2S
 O9f7fSqGHtOt2GR0+Taa/0UUuoDeuDjTZk1E/g2kzunCRYWDTSNTnIvvxn6BjpCUL02HaqdUdWR
 o/ME8SGTOkinzhMrV1sqij/ebxcw3reWVS5KA0L9RwjyyPe/O3y+7C3kF1PxUpglxA4xJM0I/EB
 83P3H3SDjELRFMo7TlOXVzQ8lNYa5llBMq8aYHAjCYrG63b0nA9th6kyMsUZvzC5khQTZfvdG2a
 99P4GRu5JCo4m0nblUTNag6Jxj7LKmkuBF1SbZXZIrpHLeeMyeoJkmOnoOdRbgPYaF2NMqtU9B3
 XrA+BRRx4HMHCByIHUlwypzZn4fGyNloZU9wM0ya7DwwGCPbq4+GEoGrpqANFn+IXWx/WMtQqzd
 3j8H/+MH9SjLd+N8SZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030158
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/7/26 16:26, Daniel Henrique Barboza wrote:
> 
> 
> On 7/3/2026 10:58 AM, Philippe Mathieu-Daudé wrote:
>> On 3/7/26 15:46, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 7/3/2026 7:58 AM, Philippe Mathieu-Daudé wrote:
>>>> On 2/7/26 15:51, Daniel Henrique Barboza wrote:
>>>>> The PMP emulation isn't present in the KVM driver.
>>>>>
>>>>> Signed-off-by: Daniel Henrique Barboza 
>>>>> <daniel.barboza@oss.qualcomm.com>
>>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>>>>> ---
>>>>>   target/riscv/machine.c | 15 +++++++++++----
>>>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>>>>> index ba96ceceef..e1cbcaa349 100644
>>>>> --- a/target/riscv/machine.c
>>>>> +++ b/target/riscv/machine.c
>>>>> @@ -20,6 +20,7 @@
>>>>>   #include "cpu.h"
>>>>>   #include "qemu/error-report.h"
>>>>>   #include "system/kvm.h"
>>>>> +#include "system/tcg.h"
>>>>>   #include "migration/cpu.h"
>>>>>   #include "exec/icount.h"
>>>>>   #include "target/riscv/debug.h"
>>>>> @@ -29,7 +30,11 @@ static bool pmp_needed(void *opaque)
>>>>>   {
>>>>>       RISCVCPU *cpu = opaque;
>>>>> -    return cpu->cfg.pmp;
>>>>> +    if (kvm_enabled()) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    return tcg_enabled() && cpu->cfg.pmp;
>>>>>   }
>>>>>   static int pmp_post_load(void *opaque, int version_id)
>>>>> @@ -39,10 +44,12 @@ static int pmp_post_load(void *opaque, int 
>>>>> version_id)
>>>>>       int i;
>>>>>       uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>>>>
>>>> Maybe we can use:
>>>>
>>>>    if (!pmp_needed(opaque)) {
>>>>        return 0;
>>>>    }
>>>
>>> Hmmmm I thought that pmp_post_load() already infers pmp_needed() == 
>>> true.
>>> In migration/main.rst we have:
>>>
>>> ---
>>> The 'pre_load' and 'post_load' functions on subsections are only
>>> called if the subsection is loaded.
>>> ---
>>>
>>> Hence we'll only execute the post_load() cb for a section/subsection if
>>> the section was transferred, and that is determined by the .needed cb.
>>> In this particular case we'll only reach pmp_post_load() if
>>> pmp_needed() is already true.
>>
>> OK.
>>
>>>
>>>
>>> Or am I wrong?  It has been awhile since I last read migration code and
>>> I'm not finding docs w.r.t how .needed and .pre/post_load interact
>>> with each other.
>>
>> Maybe check 'if (cpu->cfg.pmp)' then? What confuses me is the
>> 'if (tcg_enabled)' since we already checked that in needed().
> 
> That's in there because pmp_update_rule_addr() and pmp_update_rule_nums()
> are TCG only and it won't build with --disable-tcg.
> 
> And now that I said it out loud maybe this would be clearer:
> 
> static int pmp_post_load(void *opaque, int version_id)
> {
> #ifdef CONFIG_TCG
>      RISCVCPU *cpu = opaque;
>      CPURISCVState *env = &cpu->env;
>      int i;
>      uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
> 
>      for (i = 0; i < pmp_regions; i++) {
>          pmp_update_rule_addr(env, i);
>      }
>      pmp_update_rule_nums(env);
> #endif
> 
>      return 0;
> }
> 
> I just checked it and it works with --disable-tcg.  Let me know
> if you're ok with it and I'll change it for v4.

Yes, this is clearer, thanks!

