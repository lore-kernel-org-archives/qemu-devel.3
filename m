Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7B9CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmxZ-000143-2p; Thu, 25 Jun 2026 12:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcmxX-00013n-PO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:29:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcmxV-000558-S8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:29:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFdvja2510949
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 16:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 frOH9uM9RUyqGUjmnClzsXZKSWUDl1YsRr58UHTvyPk=; b=mkpsmh6OdAo+iCMs
 Ur5XzkZcHGi/pXshVgRdqf8PBcOMdE3nJo5MeMxR+IKDz0TmaCxFbeTUlwl5ndRQ
 LjT2SD7P5J34hl19Lh6AsFl3PdLZU1vBGfSDQ6J3svSi3/OhJfPw8aVFMueQbcBw
 Y0w2f2rOllp1RCfam5y2tbmOrDiXwoX3pUalyJOQzUAddVCKG/NnEMCGT17NOLQR
 5I/28oqoZ3pjxsJ+gzixhZqbulRRrGlsuPDSB+PESRFnwgOo0DyI21CbpYGVW4aF
 +NI+IPLzQInQGE9aq1XOoAzSHxeMkdtz5tEpAm7vfdB5OLbFBNMFNGV+no/7ADQj
 E/ZqRw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f16jg8cq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 16:29:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91579011fd1so9880285a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782404982; x=1783009782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=frOH9uM9RUyqGUjmnClzsXZKSWUDl1YsRr58UHTvyPk=;
 b=QFktQS7RTeOxDMUY+5jeSyMTF0ySLM6BaE6RQJik3TC6gYz8uLI2dGZDHYQcNUqlYq
 FIu7dNZ+CfYK7fR16p/G6Mwrz9aW7QOmS3fSfyI95nKuq846zZj2U+fIXaQcYZKz+Ux8
 6He91HMjai5pqux788WmiTNBHX8qg8T5o1BSE/r0ZRHgFB/6tWvF9aNHYkJ8tutc4l1n
 X7tbDxZZjQe6zLlzLnrz3f5h/7A1FrAyPl7mJW/w4JSKLVAvyA4u9DNGBa3BNWCBxoPn
 EYXU9u6xcW2qNiA4Oa8q36dWjidAPJn1w1uielyFJ0D9/HPmTgageZSuGpT2Gt4g7P7x
 btYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782404982; x=1783009782;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=frOH9uM9RUyqGUjmnClzsXZKSWUDl1YsRr58UHTvyPk=;
 b=SNxUT08ZnQ73ud7CNDv57/94cvYyJ7AsQG7PyldEA9+lDHK7/EBCCw7CFLRfhBFKbZ
 9UMtUiF2soueakDP7gQNKy4TGeB/EoCM2qWf3kYotTO7/qBJDPPmcPmbGD7b/K7gGOe0
 k2cmTW0UYUBUJ9z7azWBtf2wVtFm6L+o1pZETX0C5ZXHkKYZoSkle9RHzPDmHKVmP10a
 SAcv9J9QYHjcrIbqJtVaDmB+uHAIRkHlLYi5LJkb2RhiWxxDQVCR5exsKCeIljc/9QWO
 Cu0/IyDicB0SJngJidt8CEcNi/vpR9WsU3El43cscQVKTRsDyOgtg3T6WSbxXTj6FnOG
 EmPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1PdX7OdGuDfC0Hkl2qFLuQxA2vbI3QeTNwOaWrYv6wEou27+bTQhs8pfXzs9k/cL1GCor85f4bJnU@nongnu.org
X-Gm-Message-State: AOJu0YxkbOej5Vg+Zxlp1jGgu+LHuOJ44+xCj0oB+dzCNnMCjMeaV3W5
 EXsFYYIFHc0V3hfh5ISiZ31NZCFfXuiFda8auJ8t9JowdcDstGdSPQS7nhgG9CY9n1IO3cnlr7F
 EwpgjuflfGZScVtn1PhlfzSmO79zBa9w2Fpr84KzIzuZr1ASDr0pxUhrzYA==
X-Gm-Gg: AfdE7ckuS2lRpisa1a1za9WpgIbMWGp0cc7SF2V+jypuFXyylJA8IGmRirwqdj5STv6
 Xp77wCA49cdk/Wbi6mz9E9Yc471GtvH31XTz9oAeYJyp86s09lQq+WWOskDTg1UXf+B3IXhegGk
 JgLH3V0DI159hyTwhrxBH8bKGFRV9h2SvB530LHugFIHY0gUyj0XrbnliuUN+bxQQh8Z3jbfSZT
 CglFhvNVrjw1ekrBcmr4Cskc4rhlhmwPPhowcrQG3dhQF2JQJ92KFdv3RmbrInOljva7dSMzqD2
 DgnehF3hH8mrEcG8NYjcZeTRr2ZDX4TbcEqecoPKoLYbl2C0dnPZQXyosNH0RLEuOgXOkClgcxG
 +ehlL6waG0XJzAr1ro8KOE48MFf1TQU3zd86w9j1mtS1S
X-Received: by 2002:a05:620a:318e:b0:915:9051:ba2 with SMTP id
 af79cd13be357-9293ddaeba9mr476274685a.49.1782404982535; 
 Thu, 25 Jun 2026 09:29:42 -0700 (PDT)
X-Received: by 2002:a05:620a:318e:b0:915:9051:ba2 with SMTP id
 af79cd13be357-9293ddaeba9mr476265685a.49.1782404981868; 
 Thu, 25 Jun 2026 09:29:41 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fa56463dsm874621085a.0.2026.06.25.09.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 09:29:41 -0700 (PDT)
Message-ID: <18878720-7dd1-4463-9a42-e4b91cfcfaf6@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 13:29:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Report QEMU CPU archid as 42
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Charlie Jenkins <thecharlesjenkins@gmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Atish Patra <atish.patra@linux.dev>, qemu-riscv@nongnu.org
References: <20260624-marchid-v1-1-a0af7997071f@gmail.com>
 <15e2ffbd-cb14-4767-ab56-e647fdc38b15@oss.qualcomm.com>
 <88192e79-65af-4c91-9824-99dc810c7cd0@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <88192e79-65af-4c91-9824-99dc810c7cd0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE0MSBTYWx0ZWRfX6gqYD19jAdyZ
 ezrmk9551OWvLWjgnT7Hr0sxsokEx+Fnxrtt8/z+5R8eT0Z4/hXz8deW/zlnoJUMwtsNWeAeMIh
 iXXH3Mx17u8ErgLgWMjHVR+e+7N14grZrs4OrI8incMxURp70+hwjFVb0aspVoqMQlyA/LUicG3
 +r4X9/BYPiHhjfzxyVDwC8y12oWty4qfbaSVy7ON+tlARPGiQLI612tJcpxX2y03jnyvP/9NVqc
 YS+qmio6+abr8GRgd3CzUqdgYc0qz8X2oiSSmStKLObl66FXQidIs5MhGVHBF/TBSnSXOx41p3F
 lvKIdEXRGoL3f9pqciVXmtTyqe71OIdv14y1eGI0ghRpee16ztiok8YF1r5rz2RYzcVDghIYVeu
 UTbGBA86otmQbU6JCl3S7ry9auUGfncCXGmVt0X+cv4tT/7tpCD8AAPfsm5NQvHsCX8fKDPlWnz
 dwJ22eJzqdhYML7upXw==
X-Proofpoint-ORIG-GUID: 1GsHPrt_e1MuN_3_tvq_ZYxwtSG8Qi60
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE0MSBTYWx0ZWRfX+A2JhQ/kNx5z
 RxuwnjaB34f8IvaHbk1A5lW4c2Y8YNHiKIpBgNr4+uhoOllHEF+FqCV8Sc2N9WvdAyLlPvGKwUJ
 ZDOYeMqFRjxiJKUwCr3iuHpa4UojAiE=
X-Authority-Analysis: v=2.4 cv=daqwG3Xe c=1 sm=1 tr=0 ts=6a3d5777 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=xvfqbYfxAAAA:20 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=h0uksLzaAAAA:8
 a=CtIvD7FJ-Gc6_f__wLwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=MSi_79tMYmZZG2gvAgS0:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 1GsHPrt_e1MuN_3_tvq_ZYxwtSG8Qi60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250141
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/25/2026 12:10 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 25/6/26 14:13, Daniel Henrique Barboza wrote:
>> Hi,
>>
>> On 6/25/2026 3:26 AM, Charlie Jenkins wrote:
>>> When a non-vendor CPU is used, report the archid as 42 which has been
>>> allocated for QEMU in the riscv isa manual [1]. This can help software
>>> check if it is running in QEMU.
>>>
>>> [1] https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
>>>
>>> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
>>> ---
>>> This series was original proposed by Palmer Dabbelt [1] with a follow up
>>> by Daniel Henrique Barboza. This patch implement's Daniel's suggestion.
>>>
>>> When booting with a non-vendor CPU such as with the qemu arg "-cpu rv64"
>>> marchid will now be reported as 42.
>>>
>>>> qemu-system-riscv64 ... -cpu rv64
>>>
>>> processor       : 0
>>> hart            : 0
>>> isa             : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
>>> mmu             : sv57
>>> mvendorid       : 0x0
>>> marchid         : 0x2a
>>> mimpid          : 0x0
>>> hart isa        : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
>>>
>>> When booting with a vendor CPU like veyron-v1, the proper marchid will
>>> still appear.
>>>
>>>> qemu-system-riscv64 ... -cpu veyron-v1
>>>
>>> processor       : 0
>>> hart            : 0
>>> isa             : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
>>> mmu             : sv48
>>> mvendorid       : 0x61f
>>> marchid         : 0x8000000000010000
>>> mimpid          : 0x111
>>> hart isa        : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
>>>
>>> [1] https://lore.kernel.org/all/20240131182430.20174-1- palmer@rivosinc.com/
>>
>> Thanks for linking the discussion.  I have but a vague memory of it and the link
>> helped.
>>
>>
>>> ---
>>>   target/riscv/cpu.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index fa497e5e8a..59d63f82c2 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -44,6 +44,9 @@
>>>   #endif
>>>   /* RISC-V CPU definitions */
>>> +#define RISCV_CPU_MVENDORID 0
>>> +#define RISCV_CPU_MARCHID 42
> 
> Worth adding a comment (possibly linking to the previous URL)
> making explicit this is an assigned number and not the answer
> for the ultimate question of life, the universe, and everything.

Don't forget to thank for all the fish!

> 
>>> +#define RISCV_CPU_MIMPID 0
>>>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>>>   const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
>>>                                 RVC, RVS, RVU, RVH, RVG, RVB, 0};
>>> @@ -1198,6 +1201,12 @@ static void riscv_cpu_init(Object *obj)
>>>       }
>>>   #endif
>>> +    if (!riscv_cpu_is_vendor(obj)) {
>>> +        RISCV_CPU(obj)->cfg.mvendorid = RISCV_CPU_MVENDORID;
>>> +        RISCV_CPU(obj)->cfg.marchid = RISCV_CPU_MARCHID;
>>> +        RISCV_CPU(obj)->cfg.mimpid = RISCV_CPU_MIMPID;
>>> +    }
>>> +
>>
>> Two things:
>>
>> - we have a 'cpu' pointer at the start so you can use cpu->cfg... instead;
> 
> Yep, cleaner.
> 
>>
>> - the "cpu_is_vendor" check shouldn't be needed.  Whatever is set as default during
>> cpu_init() must be overwritten by CPUDef settings done in each DEFINE_RISCV_CPU()
>> macro.
>>
>> This happens at this point:
>>
>>
>>      env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
>>      riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);  <================
>>
>> Therefore we can remove the "cpu_is_vendor" check and just assign the default QEMU IDs
>> as long as we do it before cpu_cfg_merge(e.g. right after "cpu-  >cfg.max_satp_mode = -1;").
>> If we do that we'll ensure that all CPUs will carry the RVI archid 42 unless told otherwise
>> by the CPU definition.
>>
>> Yes, this will end up changing the IDs for vendor CPUs that don't set their own IDs.  This is
>> fine - if the CPU doesn't bother setting its own ID this means that the CPU is perfectly
>> fine with whatever default ID QEMU will provide.
> 
> Should we check for unset marchid and warn or even not accept config
> with this field unset?

Hmmm maybe we can adopt a new policy where new CPUs must have an explicit
ID set, even if zero, to be clear that the CPU doesn't care about the
field.  But I wouldn't bother about existing vendor CPUs that doesn't set
mvendorid TBH ... people will most likely complain about existing CPUs
throwing warnings that they weren't throwing before.


Cheers,
Daniel

> 
>>
>>
>> Thanks,
>> Daniel
>>
>>
>>>       accel_cpu_instance_init(CPU(obj));
>>>   }
>>>
>>> ---
>>> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
>>> change-id: 20260624-marchid-80d176b873d8
>>>
>>> Best regards,
>>> -- 
>>> - Charlie
>>>
>>
>>
> 


