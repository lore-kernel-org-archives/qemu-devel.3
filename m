Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508E8C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeEr-00088l-RO; Fri, 03 Jul 2026 09:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfeEV-00088K-JN
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:47:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfeET-0004bH-Fg
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:47:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663BO8f32994889
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 13:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vsRSNqARpRkb7JvKOYiFGrmveTVefTAeqjsyKSKiOHI=; b=FnIk+9UXcXAADLYb
 G0GKg1dBAMmEMaalueW7QHfVy/GOehB7lhGMrmyg9BZ8y9zLXu14MAkDHReq2myo
 KjthO55GnnCZXaBk/sgqqYN1L97+xD+N+nzsOskh9vVLac281n4NXPle45Foibdh
 /1gUdclfT9/QrFbmrEfSg8TviDPzhHCiCz4/Z5svD3Xs9HyFtkOGalP/ZONoEB0w
 mi9NGXV7lUNwohziZNkc9QeQpBMR7xxhmP2RKu7X/07E0yZV7BzTOyq7ZQNU4m1R
 WhEohYWdPcuGjKST/Os8d2oJepPZhsYqOpCrtyfRea0Xprye/ibRs/ZgEFO+y6K3
 8GXrXQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n2n3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 13:47:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a23afcbso5815521cf.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783086423; x=1783691223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vsRSNqARpRkb7JvKOYiFGrmveTVefTAeqjsyKSKiOHI=;
 b=CKm/tD/9kppJe9h4ECF/dlqFFS7WFPlBNQ4Fc5zZVz3LpZg+Tw5uWBcM25yuKX8HV2
 eiIRqDE0h+P//hheM/kiL4iPYAs6x+JtFW9JPZHhbuoZ8SSiCs+tE/18nOLP7h2dC+9i
 SQ1TDAYcVGMrDz0s843YftvffBg/7fBVTb7UJPHO9wmXAGeFYo2wSOE5kzYQ4+7HF07H
 1g+wHU+J3tPZ8zXsT7pgKgcP5vWfM5Fdw74Z5+/A7eW6cjukm3/cDAdxuVOiu4rMq4S2
 pf21nghplKQOpqn653r+snVqiuImrNXeJtBz/Nu/61sAt0QY6FXWxV9mO0N5/QlW3yS/
 JHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783086423; x=1783691223;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vsRSNqARpRkb7JvKOYiFGrmveTVefTAeqjsyKSKiOHI=;
 b=K5vC4nD0cREldvuzik/j9hIn6WlDmMWX5OGQvy3tBsbp8FQ6F6o42C2iDhPBuYsdT6
 ylNGlNwj3oDfxqThFCSHZC53CFXn/PVdSXN5xWjsYdv1zKM0611VKnqbZJWTkD+cC+IU
 8kWPUyhlq0bR2cdJa60rHbFy+RE1w+PsF/qX6/T8OKALGcLU/KYrjRjSEN9U0TOV3gnB
 EswNF/VFy/tWEtXzeydV07LGnWWBnwWEKiisGg4dXAKZ3yiCUxhycvSmfwDYe4tv3I37
 nDVUbivLhTJq4anz4Jksd95/U4bxX0GgIjpPzmb4gB8z+BX4aPGziWlYfjIZfewenQGJ
 zPUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rDOXw3F9v8dD0fKwPJQ/icVqr5WfIU2RRP2PCOT6ygVpArIaOxfiuUpPfVL5oQ6icmbC8fnuv5Esu@nongnu.org
X-Gm-Message-State: AOJu0YxOmAi0uKSOnuht4IuFFpTcE2m/fcmVkwZ/pWBk2/zrr/XaWT2S
 /lVIhCgXKyWXCB88MfF4MCg0n77Puw4IVCM0C6Q+QJdC/C2W0bBc0YE5VDN9vn4OuTy2aOGQagL
 pVHIHdVN0gzvW5Pv4yR06dbdVdZSb49aWH353ukwSCf9vGdrFCp0oSrSONm9CsXSwvA==
X-Gm-Gg: AfdE7cnVkYkaOqJbpAuTIsEicDkDK4JN1nZC0uMSQUee4XIttaj+72PGHNn0zqy7nMc
 evKa3WCi2RobLEAqkF+zwc3aFar/4CrWJcDZZ7+1NrHcuiyh8obsqXG3wN3WKtsJVsb9E5j9ey3
 tTaRD9D4YRQXrbsLElOBJ6vQ0bFmonhV7w34uDh/cS0C3TR2Voesfi9Lz53D77vPnMXFkVHrhtV
 sGdFFLUftkMsA0fjA6e9xHej53ZmiFRxw4MKtmSfflwafItXrIsLnQl42Ph2PM9TciO9JsdVN3+
 Zi5huqkdbDLPVPkgK2SkEQnnbmKfpxT6U68dAcRfY10j8ykpI/XxbAlYn9orWAK5m7o6fwBMTWN
 t9jQ7/sSOik5mp9Dz3m70pNzHg/lzRO7r4ipAIYLNS7ft
X-Received: by 2002:a05:622a:1e0a:b0:517:c38c:74b2 with SMTP id
 d75a77b69052e-51c2aee7f9dmr122273611cf.54.1783086422846; 
 Fri, 03 Jul 2026 06:47:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0a:b0:517:c38c:74b2 with SMTP id
 d75a77b69052e-51c2aee7f9dmr122273111cf.54.1783086422374; 
 Fri, 03 Jul 2026 06:47:02 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c4190e9e0sm15990081cf.0.2026.07.03.06.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 06:47:01 -0700 (PDT)
Message-ID: <10315dfc-37f1-40fb-bbf5-b2c5f460c956@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:46:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-4-daniel.barboza@oss.qualcomm.com>
 <18ce4e8c-bb35-49c2-abee-9145a33d95ec@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <18ce4e8c-bb35-49c2-abee-9145a33d95ec@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX2zv2ZRSgoW8G
 wm698ZM4BTLKVepxpgIVPgvaq9z7FPrXOGfbG3Abflk0p+pNueIiKpaucH04tyywlJ5mrjzmKY6
 3SPurqEzCXvCnBK/O/EjkaaBC6LNPlU=
X-Proofpoint-ORIG-GUID: 6BH8g1TcO64ZDXvW-Tf3Xbpt3sKkSC2d
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47bd57 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8 a=rs0RgS9yrw13dJXldI0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: 6BH8g1TcO64ZDXvW-Tf3Xbpt3sKkSC2d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXww9WG2cYISN8
 RHeKL1F++4nxH+PXNXMntO8i1G+dqgq2hdBNSws5XmLL3pZJoBaQ5tvmbK0iP/+6caJlk86nqW0
 CXeEuXZVrS0rdhWQiNMA+VD94I42uMrto0eBl8Lf+5Lvn4N982PVzKn7t0TABAo77MkrHaFwCU6
 3jTlId0L2Czzq/ASkpqUNe6oQKKGdzWxWcLA4s7SWLuZweBdUh9fN+/NF0UnWGnMdKudb1Af+rT
 ML48DJW3h7YdSuPzB6V8wUHHbmtRI/gVmVYAQWa6GeW6A1e+VF/5SLJiw1pbhhp6ABykFkeSNjH
 1iuh5GfyItGnjTPC6NVPmbbr17WqzdtY+besazvyLFA7jqHL/TPG9O0HMBYCNoF/Cv1YT559EQ5
 PBpM3ke7QrO8axL6NzW9UgF77Tttp3GHkBQ0t5jXhaWJPLyGAmrBpAIJdsj2IFGE/TkthYD6aMw
 1YSXd6p5KxOpYil0zZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/3/2026 7:58 AM, Philippe Mathieu-Daudé wrote:
> On 2/7/26 15:51, Daniel Henrique Barboza wrote:
>> The PMP emulation isn't present in the KVM driver.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> ---
>>   target/riscv/machine.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index ba96ceceef..e1cbcaa349 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -20,6 +20,7 @@
>>   #include "cpu.h"
>>   #include "qemu/error-report.h"
>>   #include "system/kvm.h"
>> +#include "system/tcg.h"
>>   #include "migration/cpu.h"
>>   #include "exec/icount.h"
>>   #include "target/riscv/debug.h"
>> @@ -29,7 +30,11 @@ static bool pmp_needed(void *opaque)
>>   {
>>       RISCVCPU *cpu = opaque;
>> -    return cpu->cfg.pmp;
>> +    if (kvm_enabled()) {
>> +        return false;
>> +    }
>> +
>> +    return tcg_enabled() && cpu->cfg.pmp;
>>   }
>>   static int pmp_post_load(void *opaque, int version_id)
>> @@ -39,10 +44,12 @@ static int pmp_post_load(void *opaque, int version_id)
>>       int i;
>>       uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
> 
> Maybe we can use:
> 
>    if (!pmp_needed(opaque)) {
>        return 0;
>    }

Hmmmm I thought that pmp_post_load() already infers pmp_needed() == true.
In migration/main.rst we have:

---
The 'pre_load' and 'post_load' functions on subsections are only
called if the subsection is loaded.
---

Hence we'll only execute the post_load() cb for a section/subsection if
the section was transferred, and that is determined by the .needed cb.
In this particular case we'll only reach pmp_post_load() if
pmp_needed() is already true.


Or am I wrong?  It has been awhile since I last read migration code and
I'm not finding docs w.r.t how .needed and .pre/post_load interact
with each other.



> 
>> -    for (i = 0; i < pmp_regions; i++) {
>> -        pmp_update_rule_addr(env, i);
>> +    if (tcg_enabled()) {
> 
> or use it here; also restrict pmp_regions variable scope?

Just moved pmp_regions.  Thanks,

Daniel

> 
> Anyhow:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
>> +        for (i = 0; i < pmp_regions; i++) {
>> +            pmp_update_rule_addr(env, i);
>> +        }
>> +        pmp_update_rule_nums(env);
>>       }
>> -    pmp_update_rule_nums(env);
>>       return 0;
>>   }
> 
> Since you are working in multi-accelerators frontier, keep in
> mind in the future we might have some targets migrating between
> different accelerators 🤯 :)


