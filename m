Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242A606A33F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xa6Gebdq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eIpydRiA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTEnA-0001WR-5L; Tue, 17 Nov 2026 03:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTEn4-0001W8-RD
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:43:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTEn2-0001HX-Li
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:43:46 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH6f07i2998606
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 08:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 djHbPyTVcDNSisCWpeCcDexZolzlwP/SGBF3RKIRGTc=; b=Xa6Gebdq2H9XHhsL
 /SHEfT6HPWIGIOq0RGiX2Pj5uGDv6bT7Bs7sHtujIgL+oeM+BcSypn5jnuHmP8es
 yB//tZRZgN1d+3l/osho93RiCu86cUGGEkbfqTlO7pLk+qVtpI1gvj5khcx739oi
 2CGTBMSm4BNPygwOPjyk6bJR9vMsbvJBjgNte3c65xKamMHtfwJBrAFuF6HeyyIg
 YXlvi5rK9Y5Khx9FlLY/2EzsMPh3QFl5OxKGFH9Gqt5xYHKHPz3iOyOqHiBKu6xe
 wvIQ7avgNUwiA87jkTzG3kFMMNkXX413TBjnE0fnj/c24WFefzx6ndbQO/ILqWVA
 rsPqGg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve0fn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 08:43:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f37c94ceeso121155285a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 00:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794905013; x=1795509813; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=djHbPyTVcDNSisCWpeCcDexZolzlwP/SGBF3RKIRGTc=;
 b=eIpydRiAbW8b6mpZFuBapibfTylBpLN6RoVBot9r4tCFescBL8HXKRjtl7DVAyiLp7
 UcLwnO80trR9gLXrAw65NO2gfAabcfDDCVZjBqZ1+z9ynj/4L/RC/X9Y0TpeaW9SzUZD
 aTuEEA9PNzD5+RlS4kw+Bj0Vu4PxHmRG7Icf5wQcgmiH6LY4YCeK48zfWouiF2rHKk5u
 oyxKk3KUJPQQiUmSQoiNd5lNe/Yn2sleLVZLKshaQWvf6vy8fAczPZAz/lfmS9/NjS9Q
 HvJiQWAw/6Rhd/kNs7IFO03FxCy5rfIkY1jIgE5Ibuq5CR836hrw/DpAnYmCSg4Q6H0N
 RKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905013; x=1795509813;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=djHbPyTVcDNSisCWpeCcDexZolzlwP/SGBF3RKIRGTc=;
 b=Rdpj5AInVYCTSIMCjcwBDA5Zyk7DLtGG97g/7JmRWm1yMXx2zvhqUwAE9uYUuuBk0Z
 42f/z0GdT2jps/AqCt5aRzE8sobakswWVngoBwfQVbmHrGoXuHP83q551V8rIvydTm2e
 8I6AvLiF9eyirLYFNfPpK4HeqNfJXtwbWu4nWoVltU3s+GqSi4PGata4L5doB9Ty8kmd
 5KL5bngL1MghpBsXNS6JBPzSD2f140j9rjFn6SYAPyLaaxT8n8W8PBULbt0QwK9XY2sb
 GQfVyesbYVrkmbhhxzomiGoLkvno/CNwNDmzrxw1hLXCG4Ds4M8nFo/+XYAitJsCRpRL
 zKMA==
X-Forwarded-Encrypted: i=1;
 AL+hErE1ehX//USJeCnWBz4PUgXVBlg2/RelF8zRc+i6S7xLy2tZD+AnYJEsmN2OqgRudioc9V97pDeun5Ff@nongnu.org
X-Gm-Message-State: APuU4Z/dKwcW9TimLS7p8ZRwk7HW02Oe1rhF80YIF6soRU4qVEdOU41f
 hFKaj3UCvbRTr3EUQ2UVlSyckki3alpE7RStqevENE73TgTZd+AWVpamUUKYPH/SUwzMEhhy2Oo
 MDC8oRl0RCI9DnksKZrvExMnPpxhKZcbnqKrm47U9Vt5WVIB/q1EwfoIK6w==
X-Gm-Gg: AYBFou1paZW9raSfR5nJDXikfW7Qla1Fgok+d1+B7P/AhARFNGLVEWFShoGXKBfis7G
 6JODs5DlnrayPN/T8Qeu5HWHRYeTMuoPC+a4BqBaiyLwX48A4izNJLaOJOKJhKRQ4cEIblS9x51
 y19N4iBIFjHM3hKt/e9MCfWcRLss8+lmb1HgyAp5kUq3l+7ro8ByweQ4f9E2CAVUR6cvOjm6up/
 f750A3u9r31njgstEbmTwNMMYIi+jhIPpvjrAAkQ3fhCPFfreAiQDXpIHp4Cmh1UPFUVnN9JRQh
 F6a3Iw5yXIvDknPb7bEzHVNVGvvjzm5GyOGalOBVSGlhmZ0bfnQwdTHGsq+0DpPHnBQg8x0exHH
 FkrHzwZDbfddhztJxUXJm85Yf4AygbpU3FN6z9iMB1IMZIftTaVs2oe6bvw+FjiARtnCMcdmbX8
 MKl8jbeo4=
X-Received: by 2002:a05:620a:2781:b0:945:fd9c:b26f with SMTP id
 af79cd13be357-9498b7655bamr305132685a.2.1794905013216; 
 Tue, 17 Nov 2026 00:43:33 -0800 (PST)
X-Received: by 2002:a05:620a:2781:b0:945:fd9c:b26f with SMTP id
 af79cd13be357-9498b7655bamr305131185a.2.1794905012740; 
 Tue, 17 Nov 2026 00:43:32 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8d615sm27191580f8f.56.2026.11.17.00.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 00:43:31 -0800 (PST)
Message-ID: <c3c954c7-257a-4ee0-95ea-052ff7876213@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 09:43:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: make error message for -cpu host more
 informative
Content-Language: en-US
To: xmphyr <xmphyr@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20261115-4836-cpu-host-error-v1-1-fdf0eb56ba8a@gmail.com>
 <CAFEAcA_dyd8Y5mJc_J7dtDwLL3eDaEo1P8fx01Rjkgah+q4Dvw@mail.gmail.com>
 <ae1a4df8-e52a-45c8-b723-60d86931f286@oss.qualcomm.com>
 <CA+hLWEGpkbvcyYV+u_keidnXE2yRrnkbqAEMy9=PkYvV3He_MQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CA+hLWEGpkbvcyYV+u_keidnXE2yRrnkbqAEMy9=PkYvV3He_MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzNCBTYWx0ZWRfX822s3BcEaE+U
 9kEqa0xExoAgzPFZ/TFzPed8t7mLYLpVOBK1XNV9DTdOl9CN99+eN8YmJmRUjI8cZh/kvjLvWEa
 /ChjKPZfHCq3nJBk8lfuu9pzeB93hNk=
X-Proofpoint-GUID: Uw9o5AOCZS_sZ9UkjMsn-SbJg-x5rc0l
X-Proofpoint-ORIG-GUID: Uw9o5AOCZS_sZ9UkjMsn-SbJg-x5rc0l
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc13b6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=ywXvYsWstchaLYkw83EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzNCBTYWx0ZWRfXxZC1alzpSR0s
 AY/aI9Q8sTrgYoFtSRkyFZVej3w9Di9OnQhCbmNd4g6kEtIunAFrTVrdPFUfi8QZjo8oAL1hFAl
 iug44xejY+vcVUOSNiqhr+MuNuLtI2mV9emw4AEuNPEMRyvnTPu9qs4l5odaaPElCMGiiPOjhB1
 q19Rqb8uuoAou51x8hyoXyy4evMgdSZ/WtHm0J6n+D01/PvDlVmi5yRsiIrRSOTH/JemLliPVPL
 W0g+uf3fqAVL8HGo+hoLcRu9CEiNek+ac4cNl6y0VIN9Wsk2rmYS5GAYvbDV+GWExyaa+379pqs
 fKyCgRWlgRtem27+2W1rmWUXJHo6rIffvUgs8RFAIQfmqom7fuQElwa2Xdx/8qBb3AX0w7pfD+O
 ekbXwXNsdyZgGCcJGO0BepbRjdVu4hzEY7zW6tqlwOVJN+EfDxbu2X/G3OUmzsiKOXN90b+krvI
 jp4QjN7jKw8/G9qzrfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170034
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 17/11/26 05:15, xmphyr wrote:
> I appreciate the both of you for the feedback.
> 
> As Philippe has suggested, I will add hwaccel_enabled() as a condition in
> order to check for KVM, HVF, or WHPX.
> 
> To Peter, instead of explicitly printing the list of accelerators, maybe I
> should add a macro of a string that's something like "KVM, HVF, or WHPX"?
> This would be in include/system/hw_accel.h.

Or:

   error_setg(&local_err, "CPU type '%s' can not work with '%s':"
                          " hardware   accelerator required",
                          name, current_accel_name());

> As a sidenote, this is my first patch.

Going well so far! :)

> When I receive feedback, should I
> reply first with my plan and get feedback on that before sending a revision?

Extra reply is never an issue, the list is noisy anyway, subscribers
have to filter for noise.

When the requested changes are not obvious, it is indeed better to
expose your plan before respinning, so doubts can be cleared early
enough.

(Also, on technical mailing lists, it is better to not write comments
at the top, see 
https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying 
for an explanation)

Regards,

Phil.

> 
> ---
> Thanks,
> Andrew Nguyen
> 
> On Mon, Nov 16, 2026 at 8:10 AM Philippe Mathieu-Daudé <
> philmd@oss.qualcomm.com> wrote:
> 
>> Hi Andrew,
>>
>> On 16/11/26 10:38, Peter Maydell wrote:
>>> On Mon, 16 Nov 2026 at 03:38, Andrew Nguyen <xmphyr@gmail.com> wrote:
>>>>
>>>> Included the mention of WHPX when the option -cpu host doesn't have
>>>> an accelerator option.
>>>>
>>>> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4836
>>>> ---
>>>> This is a resolution for issue #4836:
>> https://gitlab.com/qemu-project/qemu/-/work_items/4836.
>>>> "-cpu host" by itself is not permitted; an accelerator must be
>> specified as well. For Linux,
>>>> it is KVM. macOS is HVF and Windows is WHPX.
>>>>
>>>> Previously, QEMU would only tell the user to use either KVM or HVF,
>> essentially excluding
>>>> Windows users. This patch adds WHPX to the error message. A similar
>> patch was made seven
>>>> months ago in target/arm/cpu.c:1861.
>>>>
>>>> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>>>> ---
>>>> Changes:
>>>> - cpu.c:10229: added WHPX to the error message when "-cpu host" doesn't
>> include an accelerator
>>>> ---
>>>>    target/i386/cpu.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index eab0d5a4d4..7dd5535f80 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -10229,7 +10229,8 @@ static void x86_cpu_realizefn(DeviceState *dev,
>> Error **errp)
>>>>
>>>>        if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
>>>>            g_autofree char *name = x86_cpu_class_get_model_name(xcc);
>>>> -        error_setg(&local_err, "CPU model '%s' requires KVM or HVF",
>> name);
>>>> +        error_setg(&local_err, "The '%s' CPU type can only be used
>> with KVM,
>>>> +            HVF or WHPX", name);
>>>>            goto out;
>>>>        }
>>>
>>> The code isn't checking "is this KVM, HVF or WHPX", though.
>>> accel_uses_host_cpuid() is checking "not TCG" (also "not qtest" but as
>>> that's a test facility we don't need to mention it here). Listing
>>> an explicit set of accelerators means it gets out of date whenever
>>> a new one is added (as has already happened here once when the
>>> WHPX accelerator was added and the message not updated).
>>
>> See commit f7fa2b88084c22299b347cea8fd9fadb0b136b22 for an example
>> of the hwaccel_enabled() method.
>>
> 


