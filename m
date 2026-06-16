Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FE3CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVEM-0005f2-I3; Tue, 16 Jun 2026 10:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVEK-0005eN-73
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:57:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVEI-0008Jx-0l
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:57:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GE067k3314831
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B57kRHFoPnP72mhiGRHky+uVRi49jEqigGeiBRZkDpU=; b=G9e73a3wZ9gyM/3a
 865vUMO3dZpcl33l0S5MSw/ryWHyKXPrAfeV/HLu2NUc5uNfq+yjXET+I2sWVAZ3
 9Cpo6L8eIUovU9VenDIVpNxkXNvVDS8fijBuqm4WIPoO502I/NEBEQtkkABzV/Q4
 aBcrGI3DoY7er8SOCO80QFEwzKXPseMQyGgqkMEbkt9BzDTt7Sy4tf0MV5kS3Wwg
 yp88ENgwezNDJ12lO+n999uke+DSnr5tzu0jZKitvHewcy+TuixJuL8uY/DEGOgD
 t1a/h+K2fIR8a8gYZFvZgR3Gvon3FAz9cBOyYu033C+xTJPf+8VUagut9YrZDUHH
 MaJuDQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu0a7tg6x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:57:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963a96abbb3so5394728241.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781621844; x=1782226644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B57kRHFoPnP72mhiGRHky+uVRi49jEqigGeiBRZkDpU=;
 b=e8rpBNoi3yfZCbJunk1sDGseODGYtPvIbq7UCYQBYecTqGUy50iKB5bjJrNBRMD0GX
 J2RlbvIbllF+1sfdMlE93NFf6prSELREe07WKlqdLAvDpfr13C1aVMnhqkSyjCYAQC3b
 PkVtXUTLxgU8MY+H9IP+Qw157nQeIdhXMuLBISRP4VcVniGzBWF/Eg11UfM4/130Mn1C
 vuIAamrwYt1x/3GdVWCwBCaSLk73BIcxcbyRnJaR/SnNTXuf7ksgv+DRJuDHtnMBYXFR
 9pBgeoHydzv5Zx8AJmUqjf5f05+P9oEs2LWOZr2t5OAOf12GAhjNGUEHhz+PpdOW6aGf
 NAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781621844; x=1782226644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B57kRHFoPnP72mhiGRHky+uVRi49jEqigGeiBRZkDpU=;
 b=p1GZz59rs5GKTkmOgR7uI2ukZ3vpw52u0hYfyu3+DoqvgJt7AyvJzFHOtth1fp4tCo
 R+RWyQKNGdhDNMel/GysK01tHlvKIY6tO58VAa68dUzy5AfCkn5F4PXJuzdIo/HhQPg6
 k8OwZMYFof5wzHRN8xqJN+ISp3QxvsvwcBGYGLRJ7BLFF1ijv7mYFGK2kDX4ZCy2cJ2I
 i6jAqFq5lmJ72PVZHTwm1h4URfB0xIfepvup5phOomqrCq0x4eLd9TKZ6uLEgkBkOpw0
 InJJ7Bt2MQdOSxS20Cnaun+ArZIMYSU9vd2iLgjmBrDoTGgRJ+Fdi5ZdkwITyVTbdCR2
 u9iA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IX/sB+x2FVeLExHwxiyZMWYjRf7cY6lvw1YGs4PrvNqrDKOeofQ8mSfm4xNEYcS0JG9OtNtYCyK9u@nongnu.org
X-Gm-Message-State: AOJu0YxNzk4KL5nP1fStL7b9TP5lKB2g+MW82womgkfKANoMNQ59MVTF
 lYTxcOeQkcDtrSfMHkA8eS5VPyeLhrdV4I0PJ5lOaiGu9u0LwZCCm6g8RqNCyoCtWmIUvC+MflE
 o6hDH/Q322pujp9dL1IQUaydw71NsvPfpBp1ioy5Ad0yV45M4imZmAEcKSg==
X-Gm-Gg: Acq92OH80OnUhSx9WPH3FT9PQ9mwGJ8shAi1iUZIgkV5EHacZKsEouAjWkeekVCzJvz
 kD8RmCAOwTxjrJsUpoIDyt1Zg0ft3ThJir3QM3e8qV7/iSHcZKIzAiHXGpGF/BW/E8BsSFblr2h
 P8qZ2B3SLDuED7pJdwU6ChdJZqcBLwsQDBYgHHRhRecTkdD5zu1l+97hLtGk5GrbwkiEsY43Ick
 rGj9aVc5v3PfZAjCanbCrchChfAQmR1s+rnfjYD7ZxqiQM4nZDwtpqwAUTr/cl2P6/pVWygns1B
 DVg7Sb3EpC22NVK7d81J3FUbUGJTUK2OFCQgPItRz33j52alW3IS57yfaGQ6zFEmbhuMDIYiYKm
 ES2SnMnXqUOdOiFfZInvAEKKY3Zm2IpFDMFMHnHzzorE/rfjUflCvyxeoyur9B/1Ruo/a6IKF
X-Received: by 2002:a05:6102:580c:b0:6ef:dc8c:9367 with SMTP id
 ada2fe7eead31-71e88adcb08mr10490298137.5.1781621844297; 
 Tue, 16 Jun 2026 07:57:24 -0700 (PDT)
X-Received: by 2002:a05:6102:580c:b0:6ef:dc8c:9367 with SMTP id
 ada2fe7eead31-71e88adcb08mr10490282137.5.1781621843875; 
 Tue, 16 Jun 2026 07:57:23 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm44842215f8f.18.2026.06.16.07.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 07:57:23 -0700 (PDT)
Message-ID: <f1bc9dcd-09e5-4277-8266-b95c33223ad0@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 16:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] target/loongarch: clear the registers when cpu is reset
Content-Language: en-US
To: lixianglai <lixianglai@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20260616092554.1704380-1-lixianglai@loongson.cn>
 <dac37988-c69e-4915-84cc-2072901a9321@oss.qualcomm.com>
 <059f7cea-c478-c325-860f-b5ff84ff8be7@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <059f7cea-c478-c325-860f-b5ff84ff8be7@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1MiBTYWx0ZWRfXzdxv3mKUoFcJ
 bSD4ZEQW8EEU/kaGCebCnt4ZmJh3ljfdL0asKS8fLCkfIzqZPsktAyQgO+0RqRtKHdWuwDNtMq2
 lGEwAp2VlJd6Yy2SokTnoEYJ3EuDTrsf8haJ/ntgy4Fq8XQb5xPi9ZO0sTE4Snq2zQ1XFBai/9g
 UVYaUn4MuvlB0VMRi7Bcb4ShbGkb1wwwVICNmi+WOg2AY6Z2kn/1izgMDLhCXRHqNE7dBj01Pc6
 YYs1+gZYnza/RaqmUa8xy8TPMBOz1JW2g4BmIw4SeJIBG245pFqFPJZQlTDyIyWshK6ng7OC2TH
 43d9zoMjVo+kPssyj8HMYIEJ9tCo4eC7qFqHi7BVqU2HPpEGvyuDF8begFRyS/3Z1XbPcCAkbPZ
 jMMELzYdGHvcowoMYcvAYXciPX/9cv8X/0GcM+fKH7U/LyGmQhKBUSyITe5vQ9gy5WmsN6tpa2V
 S0bCtS+oX8AUJbZdJbQ==
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a316455 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kqjAFhMmMJbbSOBgd7oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sQEOvsMB-2raJaEvhcBua2lSDpyHSwpG
X-Proofpoint-GUID: sQEOvsMB-2raJaEvhcBua2lSDpyHSwpG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1MiBTYWx0ZWRfX1uJ4td98Br5L
 t2Y0LZCb6AI7asChyZeBFkYVhACh5X8VyXmXXMtl/UnOXkOn/xlLqTaKebUIxALyk6fnNl/6qOK
 k2j4uBeSVI9ypukR22pPcRM+tZfjrLI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160152
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 16/6/26 14:20, lixianglai wrote:
> Hi Philippe Mathieu-Daudé:
>> Hi,
>>
>> On 16/6/26 11:25, Xianglai Li wrote:
>>> Use virt-manager to start a virtual machine, and then use the following
>>> command to manually trigger the crash of the virtual machine:
>>> echo c > /proc/sysrq-trigger
>>>
>>> After the VM is abnormal, the ESTAT register has a certain 
>>> probability of
>>> remaining interrupted. Then the VM is forced to restart and the VM is
>>> suspended in the interrupt handling function during startup.
>>>
>>> In order to clear the remaining interrupt information in the ESTAT
>>> register, we carried out the operation and checked the status of other
>>> registers during the reset process:
>>>
>>> Set the CSR_CRMD, CSR_ESTAT, CSR_MSGIS and CSR_PERFCTRL registers to the
>>> reset state when the CPU is reset.
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Bibo Mao <maobibo@loongson.cn>
>>> Cc: Song Gao <gaosong@loongson.cn>
>>>
>>> changelog:
>>> V1->V2:
>>> 1.Add a description of the issues related to this patch
>>> 2.Replace the macro definition MAX_PERF_EVENTS with the variable
>>> perf_event_num as the condition for the for loop.
>>> 3.Rebase against the latest codebase.
>>> 4.Refer to the usage of end_reset_fields on ARM and other architectures,
>>> and modify the current implementation accordingly.
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>>   target/loongarch/cpu-csr.h |  7 +++++++
>>>   target/loongarch/cpu.c     | 41 +++++++++++++++++---------------------
>>>   target/loongarch/cpu.h     | 22 +++++++++++---------
>>>   3 files changed, 38 insertions(+), 32 deletions(-)


>>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>>> index fb03424ffa..aa6ecd9da2 100644
>>> --- a/target/loongarch/cpu.c
>>> +++ b/target/loongarch/cpu.c
>>> @@ -623,44 +623,39 @@ static void loongarch_cpu_reset_hold(Object 
>>> *obj, ResetType type)
>>>       env->fcsr0 = 0x0;
>>>         int n;
>>> -    /* Set csr registers value after reset, see the manual 6.4. */
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
>>> -    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
>>>   -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
>>> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
>>> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
>>> -    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
>>> +    memset(sys, 0, offsetof(CPUSysState, end_reset_fields));
>>>   -    sys->CSR_MISC = 0;
>>> -
>>> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
>>> -    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
>>> +    /* Set csr registers value after reset, see the manual 6.4. */
>>> +    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
>>>   -    sys->CSR_ESTAT = sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
>>> -    sys->CSR_RVACFG = FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS, 
>>> 0);
>>>       sys->CSR_CPUID = cs->cpu_index;
>>>       sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
>>>       sys->CSR_LLBCTL = FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
>>>       sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, 
>>> ISTLBR, 0);
>>>       sys->CSR_MERRCTL = FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, 
>>> ISMERR, 0);
>>>       sys->CSR_TID = cs->cpu_index;
>>> +
>>> +    sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 0);
>>> +    for (n = 0; n < env->perf_event_num; n++) {
>>> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], 
>>> CSR_PERFCTRL,
>>> +                                          PLV0, 0);
>>> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], 
>>> CSR_PERFCTRL,
>>> +                                          PLV1, 0);
>>> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], 
>>> CSR_PERFCTRL,
>>> +                                          PLV2, 0);
>>> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], 
>>> CSR_PERFCTRL,
>>> +                                          PLV3, 0);
>>> +        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], 
>>> CSR_PERFCTRL,
>>> +                                          PMIE, 0);
>>> +    }
>>> +
>>>       /*
>>>        * Workaround for edk2-stable202408, CSR PGD register is set 
>>> only if
>>>        * its value is equal to zero for boot cpu, it causes reboot 
>>> issue.
>>
>> Is this comment still accurate?
>>
> Yes, the comment is outdated. We should move it before memset(sys, 0, 
> offsetof(CPUSysState, end_reset_fields)), like this:
> 
>        /*
>         * Workaround for edk2-stable202408, CSR PGD register is set only if
>         * its value is equal to zero for boot cpu, it causes reboot issue.
>          */
>         memset(sys, 0, offsetof(CPUSysState, end_reset_fields));

OK, then add on v3:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
>>>        *
>>>        * Here clear CSR registers relative with TLB.
> Let's just delete this comment in the next version — the related note is 
> no longer needed.
> 
> Thanks!
> Xianglai.


