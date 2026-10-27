Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EUqG5GV3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RE8C1+VO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlDl-0005N4-T3; Tue, 27 Oct 2026 13:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlDb-0005MK-7P
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:44:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlDZ-0000R6-En
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:44:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RH005a2772444
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 17:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fdtKwe2UX5w78OlHAa4gCbFnDau5kOKDXxWj7eU0Yug=; b=EUqG5GV3Pk8N6LyR
 qt8s5V1h3Gtexk8w/rePWqMei3HYtnp1agvdsOqplj00T12T9ssuvD3gu/CT4+ke
 8U4B6bt8sdI6k45bPIaBNEPGuPhs2qm6/YzXb/eSCJEwL5Is0EkS4eQGJB9IRx6H
 AUNTqL0X1/6/5OLSDaR16cD/2z9t45G9MRLyCjJr5IKfrJto4uHzjsjL7nwkKnJQ
 pkPDOh57rL6Er9uS8bQxYEwtDxx4bzNHfLzYDLlq3M54/0170kSJti3IVztkoFX1
 VHFqDcb1V7cRwoBdiz/mUNcIXewrxQpQvoOfCOoCZ8OC1QJs+rlZrhpj9T/TSlRm
 q6y8vQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq6a8vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 17:44:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3692c5b061bso245871eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793123051; x=1793727851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fdtKwe2UX5w78OlHAa4gCbFnDau5kOKDXxWj7eU0Yug=;
 b=RE8C1+VO5EWuFKPAS2e4RVvmrZulMkrDOo1ug1j5DfDAS1Qny+X2Q2hVQON5Epu2q/
 2oOXinRy0HuIAOi8YZL3icgmTnXPjSY8pAxBsLVRyjnGjQgeXUUVeW4NmVXUeMFreJGr
 8yntSdGOYHqlCz50z130XLZp5OsEEKKA9DKTmOkp3NRIIQsaB4AlCj9WoZJ7noqN89we
 sfsB6YSUl8BnARv4X41tW+9pW8/pmzSXVt1St6/zTKEq5eaU3uMCUUEwioKHzPFGSekp
 lWsCw7dNLrp09FtbvV1wck5dXEO/gkGFzo/ohKMSb9Lt33aSGfKCldqvnX9t5qvlvm4h
 yljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123051; x=1793727851;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fdtKwe2UX5w78OlHAa4gCbFnDau5kOKDXxWj7eU0Yug=;
 b=r4ktQeZWASpLJ5pmAwwxzE0tLAxTMwi7gb/zWAfKjU5Npat1dk3Z3TPFRK0d9H0Tsl
 mlar03NSWNUbOXIE27XWNDXXjr+Mu804eKA6+JQn9jIpmUy5pTM+rE3Gn+l/cO/OC+LV
 SYSdG++l8tjMS+/HvjNtaY2nGTgaL7aYKIJbP1FciNT67Qhi48bco2cjp8yeaRrwLjNi
 tzrVbKWJfRJeKPLTxSNN+oBXg57n7JSDIO6W8raOTRaN+3efbTElyg54MA7kHA9LWMz/
 RgjwW2bAf/QwvWirgpVDyoboJ6WcwYXwrZ/4sYH1lAwzyMwV+021xptYReyWjfX12FO7
 0Bdw==
X-Gm-Message-State: AFq9FYI9JQ42qfAuQKn7/SE3lqijhJ7GjFgv/EyNP+lyIr4lgY3/z20L
 c4x8cK68Jb1lUmMGWfdv5gEM058vIrY7emcTuYjRLxdf23MQ7yLS9YAgLBgPiwmg7/t6IUPTib7
 tA0a4EomIRC66KzrMB65/Kd3SKPcjD2Ykl9goiWCrMm+Gz1RwIozktv5OPA==
X-Gm-Gg: AYBFou1A7SpA8QA4bTXYJ8n/nQeAz3+NCoiZwMXTluVmGKuuERDyqZQeKlqDBNZK0y1
 S6Qs8MSPNnUUKDyynt5P5NRAd5MJzoobAVsVw6TrFs8wpYDiPkKf5iK/b2y0a98KDuSPT1zRZ+7
 xzuGtrlsMlmuIExPExn1OrzdFjU59WPq3mLYCOy2i0n3/JgAgPeJzxi8zBPAu4axsKPdze6wroc
 hWN9xNKJilHrE1R+QGtXoHgzny2gy34NnCaGmSedtohTqV480OABRjo4fnKH8anNy2jyupYrrbI
 2yfUlw/sflPYpZOLQA2wz3CxU4JoYt3DfjI5hTjITP0Hm0OyUkqKKQN2iI9MvvFZYbbsS28tsCg
 k7FfJE7qzvjiIF9d+Gyjnx3vw9yth1P7BpxYXDpX13YUqvPCtcN80qx4aCQCR3j7TnryhfA==
X-Received: by 2002:a05:7301:4683:b0:35e:51d6:9f6f with SMTP id
 5a478bee46e88-36a20418ca8mr175102eec.27.1793123050541; 
 Tue, 27 Oct 2026 10:44:10 -0700 (PDT)
X-Received: by 2002:a05:7301:4683:b0:35e:51d6:9f6f with SMTP id
 5a478bee46e88-36a20418ca8mr175061eec.27.1793123049886; 
 Tue, 27 Oct 2026 10:44:09 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ee71f5sm44749863eec.28.2026.10.27.10.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 10:44:09 -0700 (PDT)
Message-ID: <00d8ad3f-5a5a-4e3f-9656-1e2df124011a@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 09:44:08 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: Peter Maydell <peter.maydell@linaro.org>, luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>
References: <20261013195606.152-1-luoyonggang@gmail.com>
 <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
 <CAE2XoE828e76zdCEkYVcbjRwhcsaSYZF1_UE4akeaoCTqCK3zg@mail.gmail.com>
 <baf81ba3-f29f-48f0-a9a2-6dc4f005d433@oss.qualcomm.com>
 <CAE2XoE9L8tuhU2nieJ8D=Cz9svS=W3oqAH+j30RGtZibjp1G=Q@mail.gmail.com>
 <bb979f8e-1372-4be4-814e-aa5dcb09942a@oss.qualcomm.com>
 <CAE2XoE-RcE24+9BNTSUD08QT1ECdbZm464YHiDQ4JJ4xpOE4Ww@mail.gmail.com>
 <CAFEAcA_sSTSR-J2p1C-euCsOCr0dCvQ3RJU0fr5pDa5QPKjiig@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_sSTSR-J2p1C-euCsOCr0dCvQ3RJU0fr5pDa5QPKjiig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0e2eb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=K3j-U--Li3Mwtit8ARUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: hN2D5xBadoB9ubHYYYw6uCAI8C4z5uHD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MCBTYWx0ZWRfX7VvTW4o6BDFk
 iRIsRqaiphZDcO9F3PnTIReXzTSszxOT2KcM2eefOxh9fD2VaBfFUP/9bC7oq39yf5l70ALzUyp
 q1n5qyzVbP5gF+wjIO6BlqMqTU2GgtE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MCBTYWx0ZWRfX5bxyjS5LfBhM
 DuSgf3zlUpUalseGHwwKdYmEHAIxBL+HqQGfMnhWLUoGYYbHRxCVqqGTLV2xJ5BhQzd+4gm5VR8
 RSc9jq2F7LET5IOY3qn+yORdfC0tUbU+F4aVNO7Yagy7l9z83GfyZu+R0q+IgW98xA39qiSTp9y
 6F2QyBpLPUGjKySvs922wMSZ+fRV93rs6GGm5GJVIEHdntp1xxhQfmj1D9T2bDk8xuLhnprnHic
 r68jKEm+xWWj891lRPLEho9t2dFXuYVQ5LBiOqLQ1ggsOCXYwjBSZPNrRXUDNX3cTEPqMUiYSU5
 M9sD8xyV5h+0cBNlf3ZO3bIkGRLHzcu6vD4ZdslzuVhxlAixityB3nq/Kl4KdQdm8HimfW0+1fV
 vgKEsLe/OuclgXKT1cNh5LMqdmxNJRkX7CSWT4T+iYzm7iv/D1aJShgvhBNn5k3hbvWJDOUfBBJ
 hDv+aeMAikot0O7DOvQ==
X-Proofpoint-ORIG-GUID: hN2D5xBadoB9ubHYYYw6uCAI8C4z5uHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/2026 6:05 AM, Peter Maydell wrote:
> On Tue, 27 Oct 2026 at 13:06, Yonggang Luo <luoyonggang@gmail.com> wrote:
>>
>> On Wed, Oct 14, 2026 at 5:37 AM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>
>>> On 10/13/2026 2:30 PM, Yonggang Luo wrote:
>>>> On Wed, Oct 14, 2026 at 5:07 AM Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>> On 10/13/26 1:19 PM, Yonggang Luo wrote:
>>>>>> On Wed, Oct 14, 2026 at 4:08 AM Pierrick Bouvier
>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>> On 10/13/2026 12:56 PM, Yonggang Luo wrote:
>>>>>>>> This is for avoid "max-v8" qom name conflict in multi-target qemu
>>>>>>>>
>>>>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>>>>> ---
>>>>>>>>   target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
>>>>>>>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
>>>>>>>> index 65f851f2006..d7323ab431c 100644
>>>>>>>> --- a/target/arm/tcg/cpu-max-v8.c
>>>>>>>> +++ b/target/arm/tcg/cpu-max-v8.c
>>>>>>>> @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
>>>>>>>>   #endif
>>>>>>>>   }
>>>>>>>>
>>>>>>>> +static void max_v8_tcg_initfn(Object *obj)
>>>>>>>> +{
>>>>>>>> +    if (target_aarch64()) {
>>>>>>>> +        aarch64_max_v8_tcg_initfn(obj);
>>>>>>>> +    } else {
>>>>>>>> +        aarch32_max_v8_tcg_initfn(obj);
>>>>>>>> +    }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   static void cpu_max_v8_register_type(void)
>>>>>>>>   {
>>>>>>>> -    static const ARMCPUInfo max_v8[2] = {
>>>>>>>> -        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
>>>>>>>> -        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
>>>>>>>> +    static const ARMCPUInfo max_v8 = {
>>>>>>>> +        .name = "max-v8",
>>>>>>>> +        .initfn = max_v8_tcg_initfn,
>>>>>>>>       };
>>>>>>>> -    arm_cpu_register(&max_v8[target_aarch64()]);
>>>>>>>> +    arm_cpu_register(&max_v8);
>>>>>>>>   }
>>>>>>>>   type_init(cpu_max_v8_register_type)
>>>>>>>
>>>>>>> It works for the current need, but will require further changes for
>>>>>>> heterogeneous emulation. A more versatile solution could be:
>>>>>>>
>>>>>>> arm_cpu_register(&aarch32_max_v8, target_arm);
>>>>>>> arm_cpu_register(&aarch64_max_v8, target_aarch64);
>>>>>>
>>>>>> And another way to handle it is like x86. it's comes with two variant for
>>>>>>
>>>>>> #ifdef TARGET_X86_64
>>>>>> #define TYPE_X86_CPU "x86_64-cpu"
>>>>>> #else
>>>>>> #define TYPE_X86_CPU "i386-cpu"
>>>>>> #endif
>>>>>>
>>>>>> This also solves this issue, which looks more straightforward. no need
>>>>>> .targets magic for CPU.
>>>>>> Anyway, maybe the best way is to merge "x86_64-cpu" and "i386-cpu"
>>>>>> into a single cpu type and
>>>>>> add .targets magic? When I am trying to get x86 works, faced this issue
>>>>>>
>>>>>
>>>>> This solves including i386 or x86_64, but not including both at the same
>>>>> time. Same goes for arm vs aarch64.
>>>>>
>>>>> You can take a look at git history in target/arm, to see which kind of
>>>>> changes we did to make arm and aarch64 targets linkable. You'll notice
>>>>> most of the work was to remove (a lot of) #ifdef TARGET_X.
>>>>
>>>> See it
>>>> SHA-1: ec7e5a90fea996f04ea24e81b680a87bc975354a
>>>> * target/arm: Remove TYPE_AARCH64_CPU
>>>>
>>>> So I am just doing just the reverse direction, I am fixes x86_64 in a way that
>>>> register both "x86_64-cpu" "i386-cpu" variants, though this way seems
>>>> more suitable
>>>> for your heterogeneous emulation, but we need to register
>>>> everything(CPUs) twice.
>>>
>>> We'll have to register this twice anyway for heterogeneous, I don't see
>>> any other solution to have both accessible at the same time. That said,
>>> we are not yet there, and current patch solves the actual problem of
>>> having QOM types registered twice.
>>>
>>> I'll let Peter say what he thinks about this.
>>
>> Hi Peter, what's your suggest about this?
> 
> I don't really have a preference here as I haven't been following
> the heterogenous work that closely. I'm happy to go with whatever
> Pierrick / Philippe think makes sense.
>

Ok. In this case Yonggang, let's go with two max types, each with on
init function, and using is_available to register the right one.

Regards,
Pierrick

