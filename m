Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916FAC4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 07:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkzMu-0000aK-2x; Sat, 18 Jul 2026 03:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkzMs-0000Zf-7d
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 03:21:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkzMp-0001SK-Ab
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 03:21:49 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66I6ScAa113313
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 07:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yrtz1juppdBLA0B3onjx1CeZV3fbOqsGLAPieL/ecSs=; b=T4BuIwcTa0d6klVU
 1VArulaBpBrjlVxW89fQsB29G1OurJTxXD1BrltImuurb1FUU74mmSUeavWmP3OR
 RRUc12/IC1TxU7x+1xenzW6t/VxO9poysMMIaWHKO1d9dpz8suh2QAecOsVU08xB
 f9YqLQJY7OfJVDB6leLU27S7OZGLdB4DC5X65ExsOFNMZ8zCkgezmC85ZqPqQ6KI
 1Q93K2xylHpuF8w+m4Wv06zr/WqsC2E0jItUVRj5ohFyLYO57Iz/G05pcDuhulh4
 6X1x913pNHfJVgWF2MndnntNHGtDKNtTStWSD2JdItD4LsXiEbas/J09n5Ri4V0e
 YWCyOw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d908x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 07:21:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c890bac374eso19888671a12.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 00:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784359304; x=1784964104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yrtz1juppdBLA0B3onjx1CeZV3fbOqsGLAPieL/ecSs=;
 b=WrwcblQt6OukHaYu9CAizDhkxRW5HO/LjY0E0yflfdIKB/0iUFGRkaWL1+7xXwft0g
 Hqtl8jMCrwr6HmooWRedxWbzQLr5CC8nJS9rjBKMeKKkbQAwy5gmwBDrHWa768onWCme
 u//E9AAxGCIrxlcdsMXGEMqe3JxZ3XeJ7q83fNC8Zd3QAPWXK+9cH9xZPCkTMhQ0Qgal
 w20BXAOIl252SGOuDEohLKcc2oBeBNvLLLhdYZ66TRLGZ5PVRWa/xZDNaHawi4srlouV
 pjPl6auuz91ScjHmw1mEBeFtxBu2Lp+uafZEspQZEP0x8/NvqwJlL8+1ly6GaMQaOAL+
 OC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784359304; x=1784964104;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yrtz1juppdBLA0B3onjx1CeZV3fbOqsGLAPieL/ecSs=;
 b=s3igRXLFeTNDLH7V7N+bOiQN7KuYD1zwjfo5is3X8c6ABm1smPE2at/oBhf4WhXHSV
 XDBODI+vZ/VpppFZctH+cTCezzQbSQhieljGICRxdPiDGrntJSwUGmoGMlwuzxMmHJ6q
 jfqY9DzjPjC11ba1E5x9ayHObYNLkPqWzCxU+NyxaFxnvV3VwuZUhHHahBhJqoH6LWCk
 TVpMA8Q5lApRcHeZLyeSjgdfJMlLko0VjE1CHRoaEFv1i7BZ2AS5XAGjaSO1iewPoT2p
 GHrzlt/QPTygXZ5Q9RIywQ0CH3gsxre97t5rHVPDFRcvTh7I/rJ91mlI2N+o3AAwOnns
 6HWA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpy6upL1A5MwMiOcYUg9kiSHgR7Pkt94GR3XkpLDNqVnpstoyOOyOv2l25vfUShaTp6Y6sqDlS1p6Qj@nongnu.org
X-Gm-Message-State: AOJu0YwiblBGfiC4IvmQ0OTn+6iI6aP1VgVNZ/TSWytab95YoYttxFZW
 85Dx0hEN8AZxkNa+T6iCo+8Vx0RGiI6zV+caRBZjCXC1yPrWam9vFNpN+gBgPSzooqR8JOkxO7M
 7FnKm1QDUrD1u7JMMBBRQ/77qPgwezE6q9JBknryO1U+N9bogoeN3R39SfA==
X-Gm-Gg: AfdE7cnnjiyfc3jaQXSRA5PlT+MZayrwhy/PdV82JC07yZjSmjlXT9Vx/P6CDqVVccE
 /BVXWVIxG5C7r/impbBLnK9ry7lhEfNU08rxSC1o5nWFEiaDFe2+v6zH066jUtEJY0MyIn2vR71
 fYVd25bjWCI4gWYePBT/vTWPQksrXJOL18ExKulou2BKn5HbJo77FWY1DogP1JzyH4hBRmqCvat
 h4ed29i+f1HvfL41kpTDqcD8gC2VnstUfnHZxk+HTG2acs2XS3EU9JPSOp1BXMQmU3Mrzx8t2yX
 ITSAp20JlwWHEnqQI6dX1WlzTAQz8on5WSZy/Vh7oMkwIboeBKCb5V5OWvqaCWGvUkHjc5D4s5s
 Fp3QagnAE3PbRDwQzf7GdYSQokgm89V8Tx/PEWIDkwdJ0Trme8FarrTRJigymE7e4REtL
X-Received: by 2002:a05:6a20:3886:b0:3c3:b628:6d17 with SMTP id
 adf61e73a8af0-3c3b62871a1mr3783789637.25.1784359303943; 
 Sat, 18 Jul 2026 00:21:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:3886:b0:3c3:b628:6d17 with SMTP id
 adf61e73a8af0-3c3b62871a1mr3783778637.25.1784359303528; 
 Sat, 18 Jul 2026 00:21:43 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9bcccsm15907310eec.4.2026.07.18.00.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 00:21:42 -0700 (PDT)
Message-ID: <b56a2e20-0e8c-45f5-ac9d-f207e996498c@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 00:21:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f1a78cc4-a660-4d20-85ad-84431d5a5c13@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5b2988 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=sE8Y2hUrly7P2sNbtWAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: wVRGQl4f7dhjHIbcLYXO2jR4ErSHhemP
X-Proofpoint-ORIG-GUID: wVRGQl4f7dhjHIbcLYXO2jR4ErSHhemP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDA3NSBTYWx0ZWRfX9frHZcFCi2ua
 nkgBfaFN0Cevt7idvlDd6lPCLevgcQQkVsT0DCCBKZX7KwMQ1AhT1Lv/O95evHDmpwCWN3IGiwn
 Cc5iv0iBjC/mBLdbyVbykzQ57wCrGTAmx4JQg4sGjw/mPDOGHJWVGuyJOcKckhQANUl2PuUICnZ
 n6nZ+vnW+eXmhHsEIJ6ZDiZ6EWTMPo1UZ3t0xD0oUXXxVub+ejAQ+aIS5h8b+2tiuxG6YyiTFnX
 V+Ydiybn0anCZtOIf9Nd0fBtHp5qYBB1kXxPYmCo8mdaYYu1Nm+Xy+WhG+1CVzEL3Ohnv+QQjuU
 VURKrRi537Va/etSRGQOY/fiuycJJqH98sdMlPDjCvIjllkUZcPQjwodlKn9OEXg2MtD9JQ310o
 46/K84CII7SYecvl85Ubggt7ytEZCEvXbKBi1v/EacP71AFZ7ZFP5eWEV2F/efYT+02V5Y2h6Zw
 Nw8DLZahyDhYrofd8WA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDA3NSBTYWx0ZWRfX3hfAY6dOl2e0
 shTIQ9ppbzBMHBHWgU6OKsKAXZK6Z3u1o1Rhol8H7UbETy7+eu0LlaQHCq34/EFtp6fzMLFSD8b
 T7YLoZUUmik4PH2H13iF3C8m6sUwsVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/17/2026 10:30 PM, Cédric Le Goater wrote:
> On 7/18/26 06:52, Pierrick Bouvier wrote:
>> On 7/17/2026 9:14 PM, Michael Tokarev wrote:
>>> On 7/17/26 22:40, Pierrick Bouvier wrote:
>>>
>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/vfio/Kconfig?
>>>> ref_type=heads#L5
>>>>
>>>> ```
>>>> config VFIO
>>>>       bool
>>>>       depends on LINUX
>>>> ```
>>>>
>>>> Incorrect, and it should exclude Linux hosts not supporting VFIO.
>>>> At least sparc64 to fix the current issue.
>>>
>>> Shouldn't there be "depends on LINUX & KVM" ?  At least, this
>>> way we can do --disable-kvm and it will work.
>>>
>>
>> I think it's a safe choice, but not sure if we are supposed to be able
>> to use the exotic combination of vfio with tcg also. Maybe it doesn't
>> make any sense technically though, I don't know the arcane of vfio.
> 
> VFIO works in some heterogeneous configurations, aarch64 TCG running
> on an x86 host for instance. The opposite doesn't. ppc64 TCG on an x86
> used to work. The limitations primarily stem from architectural
> differences in the host/guest memory mode, CPU/IOMMU address spaces,
> assumptions, etc.
>

Thanks, I remembered trying the first heterogeneous configuration you
mentioned, but it was some time ago, so I was not completely sure.

>> @Cédric, Any idea of which matrix of host/target is supposed to be
>> supported?
> 
> Overall, heterogeneous TCG configurations happen to work by accident.
> I would not consider them supported.
>

Should we forbid them explicitly?
In this case, we can restrict config VFIO to LINUX & KVM.

> With KVM, the supported architectures are x86, aarch64, s390x, ppc64.
>  C.
> 

Regards,
Pierrick

