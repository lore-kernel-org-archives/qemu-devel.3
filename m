Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576ECCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbyJn-0006j6-06; Tue, 23 Jun 2026 06:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbyJe-0006hH-CQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:25:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbyJc-0002IA-Ea
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:25:13 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N7j9SW1778166
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y7CJuPjqNfT31lkMAVQfj7NtVWQLceYnNCOXwjO6FNs=; b=KXJciRqn4cl0Ch63
 zaiYcPDSLFSQVCXRi+2YHafvH5alNIinGPUI/p+f6R/LCKbBZZn2ma3CFseutjrC
 Pe5W5W8sbqdVp7qvhbGhSRso2ajlUvM8ilASKSZcVxd7m9KmlXqq/vmgFqNsnOxA
 1FIN9nKbS03YOQB5/w4uVj81swkQbFbeHZo7u03MfmacUNvjqciwCJtXoq51jya7
 nLuh8RSwm/7Aq4ZKVoGMy5lzpBJI95fS4+BmX3qMEIT4b5hj3NetQTd+deUAXIrC
 pzQrTmox1JHOWkdYfsaLEoQ8pSlLTEPAwLLpHRoaN6tGDANKoMo25p9lajB3l3eQ
 ZgwgiQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp1grp0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:25:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91598af506cso532760085a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782210308; x=1782815108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y7CJuPjqNfT31lkMAVQfj7NtVWQLceYnNCOXwjO6FNs=;
 b=iJrH2s6YE77184X4zxT9BuKPoXXB7UL9Jh0vBEnNUAku7lD0YpKOG2SyMYGlRGBouh
 ut/LGp0S/0k5omWOZSChIHFExwIg62F0wWIi+AbDphuKEl8rMjMUn7xoa/f+ysGlKbOi
 7CLXXBaFbXa2Ez6gI6B5CsiOkDP1w/Lw7R60oIdtVnn266GKzpSL976NyDcHjmbX+hyd
 eG9dvCZTODf4MowkAQthjVAcXu/z5y1QVtPfm5SZHem9ZFiXnvTesezEmj2+Zu/DBgsQ
 0iBuI9NY12vzkvZZ++M9r45lHPvROsV4iP5y1DAkX8+d7RH5N9bn9qemvIv+iNk2a3Hw
 lcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782210308; x=1782815108;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y7CJuPjqNfT31lkMAVQfj7NtVWQLceYnNCOXwjO6FNs=;
 b=ldS5jTdB9Pi/CN1S/E1JN01rNNYq6TLgn+4vtvAiNxLRrmldVF1eHy98jNOumtGk1+
 6Xzu2c8AsYT3qmBr/beL4LJJqh5dF5/6mO5V8CBIPyRXpWpTK14viYksJP+WfLi/hGyx
 6pa29iro3I9JCTFu6zNM9NUBxmWu2r8wnuhU+iKqt4a8/mBzpRZ7LscLZb63SVHh7k0Z
 TcRZhvPxvlOsCyGwCpjBaSbH5SH77mpF1W+eejr+/53vKIkG9Wk6HdYajMhKykYmZIli
 +2kZJOnniPb9ip552/Kb6N4QYlJYtg42zJu4m/PYnxlZtRrLTpFbo5nNpX9o0WOZbiFk
 ULyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oY6uVNgh2a8G3piNk03PQfAUC3TcZ2wkcNNrf13aZJ1UdS0TWqnYXS8mAnsExVnlaiZ9Q64XC5qNQ@nongnu.org
X-Gm-Message-State: AOJu0YyGf1XmnjyxLKOmiBlUCRuJ5uPID5Q2XS88V2p1Hv/EX7yntXdK
 Ek4aWh/dsu7zyIz2M4+83NdASYju3l5+ZCNCtP9sGOAazmnWb+58U5VjVXJxk5+GmNXufrnsUf0
 InKMyby9a9ZfzzRGH/QEW6s3NOmmGhdnX5n6Q4/ujscQRCJ8iBksjDSknDg==
X-Gm-Gg: AfdE7cm6bgDDEN6x3+rHqfrOj+pMEvZyt8Fr+5c68UUP4alMJosSO6+92tBB1Gqp3CN
 yo2wrEiEyK0pr70bRjZLqJbw8SLb6Gte/DnA+7SC9YhBEKOpFCZe7T6WU18hdMzMXapvZN14lQ6
 GgZ3/Bp65Sl5uxS6bL9E0sICmyDf667FdXauzVODbFp+/23JgPQ2fBhknE/3RnRx/ueeNWcf8CR
 NbpGRCZElTRkDI97SXMQ+vyC1Lzdb8ZvQk6K9K7Vu63U9e+K278UNt7CkA3PkD67t8PMF7u5IPl
 Uwr0l5lDaH7HGpzk448vQnQaNrrzLzVFQnGE8ZOK4to1TymGZsQg/eIbtoFZdZuBbIAtNzyRDoK
 kpKGyr7fChUkxMKu6Yl/HJE04YO1g5BZIUvf1EKuEdDNbiLDYRUWJx9wOlZuq/Q==
X-Received: by 2002:a05:620a:6cc6:b0:915:d322:c482 with SMTP id
 af79cd13be357-9208aab206amr2986817085a.2.1782210308401; 
 Tue, 23 Jun 2026 03:25:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc6:b0:915:d322:c482 with SMTP id
 af79cd13be357-9208aab206amr2986812285a.2.1782210307829; 
 Tue, 23 Jun 2026 03:25:07 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923c862sm269310865e9.7.2026.06.23.03.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 03:25:06 -0700 (PDT)
Message-ID: <53df1b7e-44e5-4d87-8878-8b3fb97cb5a1@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-4-daniel.barboza@oss.qualcomm.com>
 <e3c93122-d0e5-4868-bf83-d757c0d1e0d4@oss.qualcomm.com>
In-Reply-To: <e3c93122-d0e5-4868-bf83-d757c0d1e0d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tSVVQ1YF3XYbfCdMouX2-FbLvSrV5hLa
X-Proofpoint-GUID: tSVVQ1YF3XYbfCdMouX2-FbLvSrV5hLa
X-Authority-Analysis: v=2.4 cv=QJhYgALL c=1 sm=1 tr=0 ts=6a3a5f05 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KoNX9JoVznXDVZnRfakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4NCBTYWx0ZWRfXzh+o12wL1hfH
 /bu1qb7DXnc6jowKjetPHQVRatUaJRuAvu0JSPaxy7XXek71p7pWzezPOuTtAcW9aBB2GcE2WpG
 /qd21eY+jSrcOym9jH2vCt7bc2wh7ko=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4NCBTYWx0ZWRfXxAeyYGyFPSd8
 brsi8OOBlv3LKG5fjQeAICoUtk58xaqv/8gHFtp5maPcFmsRgiOBXyKlmxopbc4h7iOW+VlRNV9
 BJwyTNIamVaD2E8hCtfzEq/AmqXkQ00uQ63b5/f4+vA/iNLuFecbRXbXjLRUw/Kr9LLsC4qgY7a
 6fdW9xGROYDdiW4PwY95BxPioHVmmKzFDpBVNCC6ZetB9wX+lrtDtb1SQkIsag1xVtY9IpLX6f/
 elutyffzISa2cdFxJ4B5lSdICY6IW9IqZD/2kMHaWjJYcM7jOlmo9cq70z9MXMCzGTuMrtcTB7e
 ygwz2i+TqvlKoIP4RcM+7FYX0Uetn7Hl0oXh58gAK6gysB84s5eoE397oSHDkUUvXB9TBO8dPoJ
 sJNGm2L0M2vNJCfkQt3+RJMcZ4oNfq7+pk5iXm8KylahP6K3+cYQs2HJ3Z2GYXsvVvfO64SEaJy
 qT+erMGGGMb4aSYrTUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 22/6/26 23:25, Philippe Mathieu-DaudÃ© wrote:
> On 22/6/26 21:31, Daniel Henrique Barboza wrote:
>> The PMP emulation isn't present in the KVM driver.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/machine.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index ba96ceceef..bd93d6f3a8 100644
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
>> @@ -29,6 +30,10 @@ static bool pmp_needed(void *opaque)
>>   {
>>       RISCVCPU *cpu = opaque;
>> +    if (kvm_enabled()) {
>> +        return false;
>> +    }
>> +
>>       return cpu->cfg.pmp;
> 
> Here we want to keep logic parity, in case another RISCV
> accelerator is added:
> 
>          return tcg_enabled() ? cpu->cfg.pmp : false;

FYI there is also the hwaccel_enabled() helper, but I don't think
it applies here.

> 
>>   }
>> @@ -39,10 +44,12 @@ static int pmp_post_load(void *opaque, int 
>> version_id)
>>       int i;
>>       uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>> -    for (i = 0; i < pmp_regions; i++) {
>> -        pmp_update_rule_addr(env, i);
>> +    if (tcg_enabled()) {
>> +        for (i = 0; i < pmp_regions; i++) {
>> +            pmp_update_rule_addr(env, i);
>> +        }
>> +        pmp_update_rule_nums(env);
>>       }
>> -    pmp_update_rule_nums(env);
>>       return 0;
>>   }
> 
> 


