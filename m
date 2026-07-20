Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5931C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlvw1-0004Ib-Cg; Mon, 20 Jul 2026 17:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlvw0-0004IB-GL
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:54:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlvvy-0000Rx-EL
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:54:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTg693540058
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3oAgCDwcLlUlybeUDTMcUuIpYWtEImNwLr1q3z4rU/s=; b=ArgU1ZhJcncKNoB8
 zdBRboHqw/9f0DSgKX1XBF7DoKyaJS3XKvrTb+sTVDi/yj+Vm/IdexV4oNZRxl6b
 aL0kguNGe4cH1+NgakWHCcfPhHvNtFUCqv2y1XGwZIS4kcJ+xwlDyfoK7jmv4wew
 3ri8kjVD3oOqVfw6/Z3G3seGmsXsO3XD9KdKODo6krU/1c/U+ERPQ4UwsulDwaWg
 1m2E59ZT4So7OaROxjIGLXWLCbtQ57ViXeUWfyTudaWkpxEdvJbpwSDat+ooZGRP
 FGMbRJIB5T28LX+6PPwKxDOa0ha+gFEvqqAUQot3ArCofUeFyp1fh1fLg/s7MqVO
 ReQK3w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2fan4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:53:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso11819424a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784584435; x=1785189235; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3oAgCDwcLlUlybeUDTMcUuIpYWtEImNwLr1q3z4rU/s=;
 b=F0XySNpdAb8qoUqYgl8EY3Pilcx3hI8kZrqfMnFbwLA4U4W9pv5hPj/WZC6fqcZ6bd
 cy/ycoSCWynvEh2px1wpXRazDt06SMUsrgTVKmSvfOL1x8VOonp3x81g+ehCNZYEN8Pn
 II+fImMYIYUY/WIl7D6wYY23UI1S7d3azIkfVcBihNcyhAVbVlfsAIyxuk78i/k+sltF
 9V35l0ibCeM8zGStWRMYqpeYrvhE7PK6gj3RCkYzYM6NxMGsKzDRgFOOdHrlR7ABqIy3
 k30L9cHaAX1wyn94QLSaxY9oM/gxeErbpV7/EnQcXLn5pJ1uEuAcWwzSBHq4VlldC+wT
 jZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784584435; x=1785189235;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3oAgCDwcLlUlybeUDTMcUuIpYWtEImNwLr1q3z4rU/s=;
 b=HPl1E6T31Wz3GuGKRm7E4hEaQdT8Dh4njQ1G4SBFOhWVvH+Zf0aaa7yLyvvl73xGub
 SkhPyIAEKFnHlKalv4vQZKOqmHmOlIh7o9wKNZNIouDUxS+/IZbLhMSr3PaFOjjcZQfN
 Gb4bU023GS5EPzwuFs9THiJCn/tpqQ4f3WTZmI9yINPil3hsmTKkumUW98j2hQgS9Idh
 x1SvsPrwcDTC4KfpUShQS7MR5HRGts41mfqHqV/a1r5eVOAQf6K8sRo4/7gHuI/wnF/7
 17z4sam5OVaWEfA9AXPLKhmrRHu4sukRrSck7lxrDfWe2mdCguMkmIh7ALPdq+gNsx8m
 6RkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHuN9k1EntVOPltQxTpMnafqjB/TF/ls6p+TO1i05IXl43oi2+Scz4qNMx3pzPlWSPBdr6qG8N8oH8@nongnu.org
X-Gm-Message-State: AOJu0YxxwyveW9Mq7qIDeRjZhWoT64pcmqwfmHUaxdHnrbUS2VWGIE4Q
 OlvwSaj6hmRd81H7xrMiUzHZcfuDQVIOICjpoB2rYuuWJZ5h9bFuqYRSmK719ZN+H9wITAAB9jH
 XhZ6E8kRzHUJcHPxMJoj3kRtZxlISS8b6J+a1Hct4IiC5/08JkwuEMFN9NA==
X-Gm-Gg: AfdE7clPB+iIbHOa94cAymYcO2cfXwNMlNHdqYwa5kXo4p2na/+TpiVzFYxfhTRzAXk
 z1ujjKXH2StAR4Lpkuih4vUa4DYC3nluYvq4Mk5dYyDysTGph0KWOU3iqF2dXcn2XIDAkgtDM3f
 HorZDCfFZQUQpyjVRBZfdJRRg5aFAwYeois+zkeVajpwWfQG8TCBQTgpeySXGprvW9e0eF+XKlb
 3Clq0ilrGI1HF8nHPARKbrup/k4gH3E46DYEg6Q8YqJxUHlN+YOzrdWKilQRSGtxltwwCNQtTIU
 E6iPoRZqenXlgjUfDPZ9WWAKiUlN+bqDH0wf3Jnmls/gSpyEXBLbvw3oR3q+nQCzJjhmXprqL9s
 kdutQ7SV7cYEtVDLZeyAhnF4ocDuK2VDX1Zf14vX6Oyel9WBBckb6U2dd8KYecHf1aimg
X-Received: by 2002:a05:6a21:60c4:b0:3c0:9c1a:8936 with SMTP id
 adf61e73a8af0-3c3ad9ec55fmr17205370637.62.1784584434823; 
 Mon, 20 Jul 2026 14:53:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:60c4:b0:3c0:9c1a:8936 with SMTP id
 adf61e73a8af0-3c3ad9ec55fmr17205340637.62.1784584434252; 
 Mon, 20 Jul 2026 14:53:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cbb6e8sm31982872c88.9.2026.07.20.14.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 14:53:53 -0700 (PDT)
Message-ID: <641a7998-41eb-48a5-b2fa-db93ed21aae3@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
 <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
 <d3f85639-e6a4-4917-8300-d48a7852662f@oss.qualcomm.com>
 <5dc9f2fc-3bd6-4df3-8496-44e6037b51ad@tls.msk.ru>
 <73d87f66-6907-4e02-8026-b89c49912aeb@oss.qualcomm.com>
 <f1a78cc4-a660-4d20-85ad-84431d5a5c13@redhat.com>
 <cfa19c77-6783-0870-a509-691f0539ff2a@eik.bme.hu>
 <e43b316e-e8ac-42ea-afec-c56d2f030819@oss.qualcomm.com>
 <1d7b9883-5f12-4cc6-b379-ce13a1f1afcc@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1d7b9883-5f12-4cc6-b379-ce13a1f1afcc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YxYkEkGwAm1IiABCuq0G_ajsw9MjETK3
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5e98f3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=g26msxm2AAAA:8 a=G6qBhA0vHNr1WMaRXMAA:9 a=lqcHg5cX4UMA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22
 a=bFCP_H2QrGi7Okbo017w:22 a=GGU-N_oZwHsPb1Xv_0el:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIzNyBTYWx0ZWRfXyGQCYwyQwYVJ
 rfJvPR58nALK/1yg58bUfciJuiviRUaWjJjx4KPnSPXNA0NKSm6Tp5DLb9xnGaP4F0gBr9yjiRx
 rJNvRtdqpaPMlXlj6wCR2rFEgvB2qow=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIzNyBTYWx0ZWRfXwlxF5GOCjVfQ
 RV5m7lkU/ook4G4JYPcs5N+neYf0gKRUiJMJOl6FLAJxWqpenvKhpFsqjvgPYwQ/gZ6U0VWCrjE
 wSIYtB5Cp+Ghlevq5aA3ODZPfIE6rOOgAOko0qqQpkG3gfrKA7y4MxhHjkJIUKVbDQPX/63UfBj
 G0vbublkVYCqEX7npvZOmxRH9QuyrN85U2/7QVpQqspa/OQG4DJiZb6KB8lbE7vjjc27gPnhy7v
 8UpjaSna7Ce54zzTuqakcZgd+CZ3uV+COoexIdkdW7wQ2VUp+MQClwmNe4hauK0lOdgeHrLEtdX
 CnPe7dIl2mn49+0lGM96JFTDSOPuZso/TNNlfdm4ec6/UKfptvhv3ml5PKp6BnhUKq0QRErkzaH
 jBxyBARbir4nAHSdiYPjlblsPvgiJYLyZYqR0OPi9dCnxEiZjogfQFEA22AMW/SQAFuUrw+W/iN
 YX4q0BH4FiBq/dKtZsQ==
X-Proofpoint-GUID: YxYkEkGwAm1IiABCuq0G_ajsw9MjETK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200237
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

On 7/20/2026 2:24 PM, Philippe Mathieu-Daudé wrote:
> On 18/7/26 20:44, Pierrick Bouvier wrote:
>> On 7/18/2026 4:51 AM, BALATON Zoltan wrote:
>>> On Sat, 18 Jul 2026, Cédric Le Goater wrote:
>>>> On 7/18/26 06:52, Pierrick Bouvier wrote:
>>>>> On 7/17/2026 9:14 PM, Michael Tokarev wrote:
>>>>>> On 7/17/26 22:40, Pierrick Bouvier wrote:
>>>>>>
>>>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/vfio/Kconfig?
>>>>>>> ref_type=heads#L5
>>>>>>>
>>>>>>> ```
>>>>>>> config VFIO
>>>>>>>        bool
>>>>>>>        depends on LINUX
>>>>>>> ```
>>>>>>>
>>>>>>> Incorrect, and it should exclude Linux hosts not supporting VFIO.
>>>>>>> At least sparc64 to fix the current issue.
>>>>>>
>>>>>> Shouldn't there be "depends on LINUX & KVM" ?  At least, this
>>>>>> way we can do --disable-kvm and it will work.
>>>>>>
>>>>>
>>>>> I think it's a safe choice, but not sure if we are supposed to be able
>>>>> to use the exotic combination of vfio with tcg also. Maybe it doesn't
>>>>> make any sense technically though, I don't know the arcane of vfio.
>>>>
>>>> VFIO works in some heterogeneous configurations, aarch64 TCG running
>>>> on an x86 host for instance. The opposite doesn't. ppc64 TCG on an x86
>>>> used to work. The limitations primarily stem from architectural
>>>> differences in the host/guest memory mode, CPU/IOMMU address spaces,
>>>> assumptions, etc.
>>>>
>>>>> @Cédric, Any idea of which matrix of host/target is supposed to be
>>>>> supported?
> 
>>>> With KVM, the supported architectures are x86, aarch64, s390x, ppc64.
> 
>>>>
>>>> Overall, heterogeneous TCG configurations happen to work by accident.
>>>> I would not consider them supported.
>>>
>>> VFIO (vfio-pci) works with PPC TCG and is used for passing through cards
>>> including GPU to emulated AmigaNG machines (maybe also mac99).
> 
> So also Kconfig PPC (32-bit).
> 
> Can we assume the following is safe on 'LINUX && !KVM'?
> 
>   #include <linux/kvm.h>
> 
>> Please do
>>> not break that. There are some quirks mostly with GPUs, see https://
>>> qmiga.codeberg.page/qemu_vfio.html but it works and used by some people.
>>>
>>
>> 👍
>>
>> In this case, and we want to ensure we don't break any existing workflow
>> we might now be aware of, a safe choice could be to restrict VFIO to all
>> hosts that supports KVM. This is different from CONFIG_KVM, which is
>> only enabled for new hosts.
>>
>> @Michael: You'll need to detect kvm hosts (see meson.build for
>> kvm_targets), add a host config CONFIG_KVM_HOST, and use that for
>> CONFIG_VFIO definition. This should restrict VFIO to host providing KVM,
>> without limiting which target is ran.
> 
> For the 11.1 release I'd go with this 1-line fix:
> 
>  -         depends on LINUX
>  +         depends on LINUX && (AARCH64 || I386 || PPC || S390X)
>

It duplicates the information we have in meson.build from kvm_targets
section.

That's why I suggested to add a new CONFIG_KVM_HOST with this list
directly from the same meson.build place.

Not the end of the world though, but it's definitely not the thing you
want to debug in a few years when soemone will ask "Why my device has
KVM but no VFIO support"?

>>
>>> Regards,
>>> BALATON Zoltan
>>
>> Regards,
>> Pierrick
>>
> 


