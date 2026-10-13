Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DC2CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkBN-0003mk-Sm; Tue, 13 Oct 2026 17:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkBM-0003mL-D1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:37:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkBK-0003tm-AQ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:37:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DKQBBr1999291
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NjmQi3KBma8XK+Rjo4d8+FpWwgLIpmkPj1KQ/A1Ey44=; b=WNDvvTdoB76ndPVq
 FOK8hRl33IyMqodcQIJYHzPebBwZaaI4Yxf5gA9xJJ8F4DiVje+8LGc+TE/cOBjM
 jHcIiwYcGiHOlmIdrWvvhto/Wjo4qvt9zmh1fxq1ROXbCdg8/PwgDI/bmrLYd+iG
 8m7yV3sCuv44cuvh5hefpsDctP7NkOnhYT48OOI4vrtf63It0+Yyl4TunnnZkKKM
 h8xwp0j6M1V2JQrSZq56dLAKo0kjR9NsO/6PYhF9bTZZclWEkCMqNuM06u75bvIF
 GX+1G42vmrBDDQ6XxrFP13Qc4Pj8JqTUbWDi3koVVmKd/OjBnpmQhc3E4YFxD5aX
 Kka5jg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f62byq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:37:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3515266f6eeso524166eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791927427; x=1792532227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NjmQi3KBma8XK+Rjo4d8+FpWwgLIpmkPj1KQ/A1Ey44=;
 b=Fsmf2BQFsuVXJO2hMH7IDfzw/gW++9kYQI+XcyME7h6wX81ZuYf547wcWUmt/87ym0
 5z0kBy2ppjZf4LY9mTmvyGMM2B9Q8Kr1GTpzjQELbiYnp94PtCMDZX+srKgqa9Yrb6/z
 JaKKp17PPtIRLNV5ZBbNt7V7kH26UwXtnxmteLSqnQQpHM4wbS3ZYPirpmflImjaPA5b
 1vV+c6icj2ey8IYn8BNaKaxFJN/FZNLTSrpn715xkyajLNBohWM0+YlQGtx7kc7t9Vyn
 IQ7el4RF+lCSWb/0KnUQSWVagnvWNzQ49pObDQsE4KO2FGnt+ltP/NrA0uz5KWEAZ9EN
 dy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791927427; x=1792532227;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NjmQi3KBma8XK+Rjo4d8+FpWwgLIpmkPj1KQ/A1Ey44=;
 b=UOARwcDvbnbSfx6JECTq87Xp/JfqdcfgIEDQdVvbkW/GJhyAmKpWPNe10cUL0hhEjx
 hms2xuM1/oJonYJ4OymhD3IrnsXu7iztskOEZhExtJ+tKJIVxjph+nJaR7DvVCiB+dYD
 Vq85qtwn7T/S5h+H9I0Tfemev5xZQkBKdouq7uB7wh6fPrheAvgUiOXsTgtRaq+gRLui
 Ip4LGQKMm1mKHIpHAL5WQTkLRE40Oaq7ALZIVtLG6CueCNvKw0Bk6bNgT/3jQ4o2ZyHh
 Kx1WAhFgfXfGG/oWIrEnR5E5zTPUeec0Bu4IQxlD5fPDLG5HMoa9hNeC0EmHo9+v4v26
 y90A==
X-Gm-Message-State: AFq9FYKqc6DjSiV+7POgC/yJB1Qar/Tjnd0skA+Yw2/MSeaK4DyeWIYb
 rgs8ta+2cYVdZC7R6Wk/NAjqNPQ6X9MuN/TzIQ4i6Ezuj2laZfiS6jmBDRhj6BD23ca9Jr8/ZP9
 CiEJA79UMpdKASgWQLA5glVtzrRMWWJXdcJlEvyHrX7yCS/pojkzuv1quPg==
X-Gm-Gg: AYBFou2GvliIlypkpXyyDWs0lkReA3/axLNq3AliXWeEop8DcOVCVfVTJRc2O7TTYh9
 XtBN3DZBhRZVM6NzvsmwC6Sptf1Dl3X3JIadgR5/Nk7+RMVHFKpOSgV5o16emcnINrgAcc5fh8A
 bNZEmqVxRR4f6F7IXWpLKBeAn8r3LrR1CfiiCSdXgRzXFwjBmrEbgyDDmLaywrfukHhu+dgvpb+
 p23VkN4XzooCu8Pef/TXyKNYmWNZjZUl+4YISQHj2EqCvXYtHC5eSIVyRkAloWnZfcOGiKQrMPb
 mG9467I0JNJMoI4rKMnCqPW1U+qZSdIFXi8idmb4jCsT6zUAZ8NPMXeEbXlm7+VzkKckSvuFA8K
 YTCvcF48g4i4pNtR61CMd/+dLG3CeUt/qia5H3W2rHC2nBgpPs2VZnDlzC2757TpeHQbEgg==
X-Received: by 2002:a05:7300:ce94:b0:345:84eb:7153 with SMTP id
 5a478bee46e88-3537e033341mr19194120eec.11.1791927427250; 
 Tue, 13 Oct 2026 14:37:07 -0700 (PDT)
X-Received: by 2002:a05:7300:ce94:b0:345:84eb:7153 with SMTP id
 5a478bee46e88-3537e033341mr19194071eec.11.1791927425861; 
 Tue, 13 Oct 2026 14:37:05 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2fd33sm44713112eec.28.2026.10.13.14.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:37:05 -0700 (PDT)
Message-ID: <bb979f8e-1372-4be4-814e-aa5dcb09942a@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:37:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261013195606.152-1-luoyonggang@gmail.com>
 <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
 <CAE2XoE828e76zdCEkYVcbjRwhcsaSYZF1_UE4akeaoCTqCK3zg@mail.gmail.com>
 <baf81ba3-f29f-48f0-a9a2-6dc4f005d433@oss.qualcomm.com>
 <CAE2XoE9L8tuhU2nieJ8D=Cz9svS=W3oqAH+j30RGtZibjp1G=Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE9L8tuhU2nieJ8D=Cz9svS=W3oqAH+j30RGtZibjp1G=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6acea484 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=jimn5nu4UPjwLZt2rX0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NiBTYWx0ZWRfX2LRUjFrDpsW8
 m2GLHrchA7kbLCFqONc2IlM5SP2rv4bl6fGyuh9o2luKPrmrF4IKbiNq1KgKacnCHOtXa9D6Oog
 RIgxzu4PRfmCSUFQGtVavXBcMGhQoNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NiBTYWx0ZWRfX55WZraai2DiY
 R84Nth6p9MOOJFUWBOqA6yO3ZNEjPSRvi3dzzUxZH2TBfq98L/IxoMzV/C+fBIsAXO9jxMQmM4n
 Qk2ljpTVjkKueb2RfDhpl5o+FwLhzWpoGI5Atb/GU8lzFibQXmaqXws6x/pkjY0nHZCPL43a8TU
 +/QS0WzUPQNNo6aLxVoMKtFqolzv6KfkeUhIqcGksJ1IFL6I1hzPXBqNjrRjbXsJhhbmSvTQ1SC
 4TS+7vOzfDEVccj3M0MtFknU4ef9LBoJzqZ/0EujxxeShEbmwHAu4XShEf4fQrxA9F0jvdOTJMp
 ePB3p7R7RsSnsf0TIIVDYyH/LjTWT04E3H4xpa7PVYzDptVZ9HuhAyRd2CQEzM0v2mtaj2JUGii
 UZZ0xsUjCkUlk0GLBviVHjiNMcSuD1MYwenpKDYJurb459HiPe8NYXdeLuYrxyiFJyZgbKZL0wv
 appKiNlqFZkA0aGL1ig==
X-Proofpoint-GUID: XS0CTv7xYhaXh6ItoNG1L62piTXCXxSQ
X-Proofpoint-ORIG-GUID: XS0CTv7xYhaXh6ItoNG1L62piTXCXxSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130086
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

On 10/13/2026 2:30 PM, Yonggang Luo wrote:
> On Wed, Oct 14, 2026 at 5:07 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/13/26 1:19 PM, Yonggang Luo wrote:
>>> On Wed, Oct 14, 2026 at 4:08 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/13/2026 12:56 PM, Yonggang Luo wrote:
>>>>> This is for avoid "max-v8" qom name conflict in multi-target qemu
>>>>>
>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>> ---
>>>>>   target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
>>>>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
>>>>> index 65f851f2006..d7323ab431c 100644
>>>>> --- a/target/arm/tcg/cpu-max-v8.c
>>>>> +++ b/target/arm/tcg/cpu-max-v8.c
>>>>> @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
>>>>>   #endif
>>>>>   }
>>>>>
>>>>> +static void max_v8_tcg_initfn(Object *obj)
>>>>> +{
>>>>> +    if (target_aarch64()) {
>>>>> +        aarch64_max_v8_tcg_initfn(obj);
>>>>> +    } else {
>>>>> +        aarch32_max_v8_tcg_initfn(obj);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>   static void cpu_max_v8_register_type(void)
>>>>>   {
>>>>> -    static const ARMCPUInfo max_v8[2] = {
>>>>> -        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
>>>>> -        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
>>>>> +    static const ARMCPUInfo max_v8 = {
>>>>> +        .name = "max-v8",
>>>>> +        .initfn = max_v8_tcg_initfn,
>>>>>       };
>>>>> -    arm_cpu_register(&max_v8[target_aarch64()]);
>>>>> +    arm_cpu_register(&max_v8);
>>>>>   }
>>>>>   type_init(cpu_max_v8_register_type)
>>>>
>>>> It works for the current need, but will require further changes for
>>>> heterogeneous emulation. A more versatile solution could be:
>>>>
>>>> arm_cpu_register(&aarch32_max_v8, target_arm);
>>>> arm_cpu_register(&aarch64_max_v8, target_aarch64);
>>>
>>> And another way to handle it is like x86. it's comes with two variant for
>>>
>>> #ifdef TARGET_X86_64
>>> #define TYPE_X86_CPU "x86_64-cpu"
>>> #else
>>> #define TYPE_X86_CPU "i386-cpu"
>>> #endif
>>>
>>> This also solves this issue, which looks more straightforward. no need
>>> .targets magic for CPU.
>>> Anyway, maybe the best way is to merge "x86_64-cpu" and "i386-cpu"
>>> into a single cpu type and
>>> add .targets magic? When I am trying to get x86 works, faced this issue
>>>
>>
>> This solves including i386 or x86_64, but not including both at the same
>> time. Same goes for arm vs aarch64.
>>
>> You can take a look at git history in target/arm, to see which kind of
>> changes we did to make arm and aarch64 targets linkable. You'll notice
>> most of the work was to remove (a lot of) #ifdef TARGET_X.
> 
> See it
> SHA-1: ec7e5a90fea996f04ea24e81b680a87bc975354a
> * target/arm: Remove TYPE_AARCH64_CPU
> 
> So I am just doing just the reverse direction, I am fixes x86_64 in a way that
> register both "x86_64-cpu" "i386-cpu" variants, though this way seems
> more suitable
> for your heterogeneous emulation, but we need to register
> everything(CPUs) twice.

We'll have to register this twice anyway for heterogeneous, I don't see
any other solution to have both accessible at the same time. That said,
we are not yet there, and current patch solves the actual problem of
having QOM types registered twice.

I'll let Peter say what he thinks about this.

Regards,
Pierrick

