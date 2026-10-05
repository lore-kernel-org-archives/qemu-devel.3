Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5577CCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDno2-0006dF-T4; Mon, 05 Oct 2026 14:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDno0-0006d3-Pe
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:52:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnnz-0005Kd-1u
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:52:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HuYI52484596
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6/L04cvnLPoEdfa01Y+kJHZylIHuNNtiYN5aGfc9EHI=; b=HfPGScYOF5hsGouH
 ZkAMpbCmDgO59yrLsIdWA6/ASN/HMONNTrA0QzeGgf2FQFuDlUfSCoqN5YP4k7/5
 fH72DXhYdY6Vk85PoenBI+0JEwALyPOiUuGN/MhQsOBbpC2E0GaaxnV4N8LZnclP
 3bLbRyNN5Fym/6KRuUhP2tKC6suyJc3TJ1viZt8a7EC/C727cnAoZzJ6SzX69D0d
 SK0ITTV/jtsWSWg/w/UWXY0WXbnmTAF3aOihR3Xf/0pg4AbI4NzrN7wOBum3Y4dT
 s2NAnsk4KbGc8Xc2yLw6nb94h/ZrFlYSemwoRoQXg91fA3v4THH2yXuAXey9fxQQ
 6VpOAQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr087e1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:52:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so5028148eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226372; x=1791831172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6/L04cvnLPoEdfa01Y+kJHZylIHuNNtiYN5aGfc9EHI=;
 b=Xw2LKdxy1ckiu5AZcVJ4/s0uB1FL/+G0m1bE7DYZZG+UoTHj8dzkzoQOWJXjwlX/lT
 wrP1Ylma1V0b7vWLEQW04CaX5VgCHDDOHWmHL4l6GtpoUKqPl8omaaN3p3aZ1yr4VQve
 1+XU5riN3K8erAXLS0gVzs9pbcYsA99bsopBspsQRvWzlnRevXWAe7cNden8zCmaal5E
 HU1HCXFl3cIg+cRsm4+bdc1oY3Xk1vHnA2xfqsdM6Xr5RIw702BZWnFadNRj3I/bchso
 DgaJj3MOgGIYKkceFa1am8N9uKkQS9NZHgkFPyGiGUKhOo1mWIAXc6qmtDH8fVsf/VVx
 tPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226372; x=1791831172;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6/L04cvnLPoEdfa01Y+kJHZylIHuNNtiYN5aGfc9EHI=;
 b=WR8rU5DNe7UMCHoMoPYEWn8UPcYtZNA5PcyDJ1i72DAZ+vxiwrFu/DFtNO5bf1FcN3
 30snnNdOCqWKaQoSSLDdzM8wuQEkspoSADGPZSMw+JYiFJ5zL5ks3b94kOzF6dLE2bsK
 8Q1YPSpBQbNnULgGxmqsgqSSqZygQ9tSNaWjVDotoInbqaqAEjByVFgX2I99Cb0DU0ZJ
 6C57+dNGMfuC+duoSBdGJ0+NjB5IMNwcod2rOJZEcvbMvT7rAiR7Ie7f39Vf4VXD2kPt
 wykpJNndtXFGgp+domScm1eAIjG3zolPDnCK56u0vcg7i5JK9jiFwmoRTpwWlO3IzNqM
 6haw==
X-Gm-Message-State: AFuF++meLRoARAILIbrODU6YfS4hsaxoRySNaekket7xcj2wV4Y89JlA
 Z7bgwEeJaZOvYhEiHlyhgvahKeR+4lyvy830ipGm1xXM2nkiWWh7CXQcH4I70Eddq4bQuMURQ29
 8yOiB1sLRW1xukDbnHDLf6bJF3x8OX5UYk4Su4eMonNn68gRc71W/b35B+g==
X-Gm-Gg: AYBFou0DOzTIGmn/Px3eM5IQJcd5Hz7jON88FwDKxs3DqY5O/x8GXgd0SVEJRt6Rl/w
 zNgbX8H4kuNnKDSSiW2FU11tnkUWzYFIGg9ZpygB4c3ZzH8+2+Eb6ysx6+7ZztyK39HMpPmNwkL
 6VQygAHTPSTlLrN70xKJv+daLgP/DQJspt/umHWfMx9vdkP0d/UltzxQRcBZ/IzuwsC1qEPls4S
 dDrWxcXC+cSWKpCid7f4Q1+foHmvV0ayXdt0Z4KfWyWpM4CqL55z47jE1z86dvu/4h8+Xze8EWu
 C6v/iczt9fOG8JvENB6jawUdf1qgn4U8OQ+TzoHAoc47CnkXpwoe692UpVbgTM6CpVfF9IC5jYa
 geUPJd0YMy8/dyLIoZhVjnbQLefZKaG9Qxo9CzYmCcZ6QbFVU8tpOAC9OnsWZIPFQUXxd9w==
X-Received: by 2002:a05:701b:2705:b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-15a41554461mr3035053c88.31.1791226372048; 
 Mon, 05 Oct 2026 11:52:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2705:b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-15a41554461mr3034972c88.31.1791226370639; 
 Mon, 05 Oct 2026 11:52:50 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d84ec510dsm289314c88.13.2026.10.05.11.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 11:52:50 -0700 (PDT)
Message-ID: <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 11:52:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX4GTm0IFrSe3n
 TSf3vpFZA3F/B3tB9sDI6E59x68Nm8e3GZ9Yea9B8+Ygwyslx3GGZ+IHWqp72VI4K0sE2+aGBZk
 cuqCgSusBq5NTqNqj8GOT0TTRkJTUHSetHpJ1Kn6BRiiXCNj/+HFiXZEujTt1wVu1/0uLbISplo
 LqIQD86U/Y66+X+oSmVje3/2WMSOLH6OfdJ/tVvoXdxXq7SvUTfahMmTXNzWaE55owITlgYUhE/
 vGJSznHhaRhQpINJPmt/TdaLRG1vG57aIIVeanP9mHFuCIvDKOpoIZdse0AwnEU2rPFphbErPCk
 NtZD3WHeDJmQWweYm6/Bl+2Xdn4xl2hwvnne95trn6RFMaOVx3MB8paXHKneUk4jgjQbUwyZAZ3
 uzMqrs8G1yHO6lyUjyk/w/xnvbggP9brdw2x9vleOpaXqdP6a+5rFOvP6jU6DCJY3rwLYRcnjoT
 QQoMu+cqC+z2IqtIxBQ==
X-Proofpoint-GUID: zyB3O5zwGjdMYCeyzdtWyCPa4KRtf1uO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX0x88lkdT1xSd
 +hR0k0Ow0RmJt/aXBHmnqhF8T7OfO/IQ16Y5BYzHNp9nW6kX6+utnDvaIgOY3U0FCxzh0ccvT9L
 hjmlL+EWcvctgEyiHDhpl1ilPy0ETwk=
X-Proofpoint-ORIG-GUID: zyB3O5zwGjdMYCeyzdtWyCPa4KRtf1uO
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac3f205 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=nknU55U_wiY0WzLILoMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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

On 10/5/2026 11:45 AM, Yonggang Luo wrote:
> On Tue, Oct 6, 2026 at 2:06 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
>>> On Tue, Oct 6, 2026 at 12:25 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> Ok, but I'm not sure it answers the why.
>>>>>> Could you explain the benefits?
>>>>>
>>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary because
>>>>> The following original code would return -1 for some user-binary
>>>>> +    SysEmuTarget arch = target_info()->target_arch;
>>>>> +
>>>>> +    if (arch == SYS_EMU_TARGET__MAX) {
>>>>> +        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>>>>> +                               &error_abort);
>>>>> +    }
>>>>> +    return arch;
>>>>> So basically assigning any value for the user binary is valid.
>>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarget.
>>>>> -1 is another option but easy to confuse.
>>>>>
>>>>>
>>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
>>>>> "target-info: Statically initialize target_arch"
>>>>> doing that, I am not sure.
>>>>>
>>>>
>>>> I guess there is a (good or bad) reason for which sub variants of
>>>> targets are not reflected in SYS_EMU_TARGET enum. We should double check
>>>> that before doing any change, as it might have other consequences.
>>>
>>>
>>> You’re right to ask, and I need to correct my earlier suggestion:
>>> leaving user-mode target_arch
>>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
>>> code shared with user-mode builds,
>>> including cpu-max-v8.c, where its result indexes a two-entry array.
>>> For aarch64-linux-user, the sentinel could therefore cause an
>>> out-of-bounds access during type registration.
>>>
>>> I checked the distinction: softmmu needs the full system-target
>>> identity, including variants such as mipsel;
>>> user-mode variants such as aarch64_be use their base TARGET_ARCH
>>> (aarch64) for this enum. I’ll keep the full TARGET_SYS_EMU
>>>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
>>> than leave the field at SYS_EMU_TARGET__MAX.
>>>
>>
>> That's technical details, but not an answer to the initial question of
>> why we need to change anything for user binaries, compared to what exists.
> 
> The first two patches revert the current static initialization so the
> token can be replaced. They are not a user-mode behavior change.
> 
> Compared with current QEMU, user-mode still uses TARGET_ARCH.
> qemu-mipsel already reports mips, and it still will. Names such as
> aarch64_be are not SysEmuTarget values, so user-mode cannot use the
> full target name for this field; keeping TARGET_ARCH preserves today's
> value and avoids the runtime parse.
>

Why should we need to expose this precise information?
So far, if those targets were not exposed (and aliased to 32/64 bit
variant), it's probably we didn't need it.

In case there is a real need to expose it, maybe the simplest solution
is to add such target configs.

> The only intended change is softmmu, where TARGET_NAME differs from
> TARGET_ARCH. qemu-system-mipsel must report mipsel, not mips.
> 
> The cover-letter sentence about mipsel-linux-user compared against the
> old target_name() parse, not against current QEMU.
> 
> 
> 
>>
>>>>
>>>>>
>>>>>>
>>>>>>> "target-info: Statically initialize target_arch"
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Pierrick
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>> --
>>>>>          此致
>>>>> 礼
>>>>> 罗勇刚
>>>>> Yours
>>>>>     sincerely,
>>>>> Yonggang Luo
>>>>
>>>
>>>
>>
> 
> 


