Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95794C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws17O-0006PM-64; Thu, 06 Aug 2026 12:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1ws17N-0006P8-6n
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:38:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1ws17L-000081-2x
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:38:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676Emiv81928263
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 16:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lRekVyQ2uAGcwSTw6pKuFdkBO3Oepb2f13xxewhw2Mc=; b=OKliCMv8y7Dn99mj
 /qfdS1XKoXNpLNKK4Cg5lS7zH3YYrIT6oaomsw+tiPR4wOtfcnort1xXTdwYsfIZ
 GSsXfjTNhZjl5oBHkL+Bf0YDw2MJSQ3iO6f2whAM/LxoDVhKEu9CNQkJSh7jk6Im
 WdGtv/Nj/GldBOEzQBXMyLq3U8W3THFdRUFGxyQ0Cxet1jb71kmz8BjbZrjf1zWz
 Zoiwy4NrCWUUeERoUjK3IfatMxKOyr3syk97OVJMuLtGfZiIl1Nu2t9TMriYTQeW
 xQTIGpvNmGblVAeyqOuBH3i+WPdJrWhD+W4jXF77rizlhqYU6xaCioGhheFXd+y3
 EURyeQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvqduj8fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 16:38:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso3010087a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786034326; x=1786639126; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lRekVyQ2uAGcwSTw6pKuFdkBO3Oepb2f13xxewhw2Mc=;
 b=d5FqTWYyRAMaFlz3MYz5A3pC+yzZch8HEDHxBlRk3Dr7SqKGTsd1fWC3y8sY5LRQdK
 wn+4GvOKV9TpC6KLpQD3q34y+Vxczketees3Zxs3yQflAFL4flulMdF2mhWsH6ysppS6
 so6yLt5YgKxMyMx/adgmajpmvfRiBN1PZdBL4z3Qr4MeCdTqLxGN8ADOWCaTTarl7wqb
 TQiFbmfwt04VBFygeAsGhQQ7PZgKyIVWQMx8+rYuJYMou+45sz6NoNYUluorAPcKFBwV
 9Cr9sxG4PNAbYn7UaOTEzJRVrXK/cTOhH26Hh0mvwi/u3T+yZgqJ35K/zgjbkY57i/Py
 PvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034326; x=1786639126;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lRekVyQ2uAGcwSTw6pKuFdkBO3Oepb2f13xxewhw2Mc=;
 b=E8kB7xT+P3nBZw2WPaCTDI4Pev8+Hy/ykgiE35PyERTA8Hh57ER2J1/XjyXJGCGEko
 ktF8w6h5AaR/R8NBu9MQviZLzRLjJX1yq8ik1NTrhvQ+XOJagjcdU7lprTZgxnCkama+
 ZiSv3seqYosfSrSAYtW8+T81h6anhEwlDmvAUL30l8MsZIfx6MMloQVZrYAmzQW06d0w
 wUFFanr9QiifQ5tLjAVP11D7Sr1EaCYbkstWvil71vbvUCrFlavTql1Ix4ZMB+/Ytz9v
 +PoK5pzsRwsT7QP+ZG91G/HYY4e1Oz6UGYdzm6KXshD8eLU0KarHe8WQ05iN8Cz6iR84
 a+jA==
X-Gm-Message-State: AOJu0Yz/dLPXnbrzz8OUvRh3hjNAbWnNiKK+T49mjNCVsAlIn5M/yptq
 LnGnxrZnZooXTWaHAtOKH4AnTttpc/lV1SrCHF6NjGynBbAkIRkCtEBSOBRW4XsjVjvqGQIOfx9
 +0n5X16cEHZoFIIVZ5nt0JTuc/CKwvR1FGVQQBZ82mR9JNUDpOXvVgqH1Aw==
X-Gm-Gg: AR+sD12eTyaHQliLtNT61gxIw14SZVFvhqCK0M/15Bc8bjMGZat/fBEkqZTmt5HjL8l
 l32AC5J0kbTTeNbvnkVtLEjIzYd6mqGmVpIf1ct80OELoRM+0cuDGV2TM319GsSYabNmOKz/pYv
 kCavddH5MAnnJ9vjQFX1vACp3uWP0rMmqYWdjPdstEopBIm4DUAGbw2j3fRyCu8pCYeTzk2Xp9+
 vO+xz5L3Fc9fjMtz1BFdBe5DfCox65Qlns7w3KUab7bd70+E5q3lLvt7SaVCssvVDpw2TCByWKW
 66/euzSKp4grH8temAPpjG12VrZTNbocns0yZQF8H2jidu/UQ7u1XTROefBUaU/SSIohjC+bw8n
 h9hHApAxd4k4mvYz7WyyqYpVbDeoGxtW15TpM9Pq6+YlThng+3yJuYvEA6gzHmHTlGHyJ
X-Received: by 2002:a05:6a21:687:b0:3cb:7b9d:9869 with SMTP id
 adf61e73a8af0-3cb85f4a600mr20885854637.35.1786034326439; 
 Thu, 06 Aug 2026 09:38:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:687:b0:3cb:7b9d:9869 with SMTP id
 adf61e73a8af0-3cb85f4a600mr20885793637.35.1786034325932; 
 Thu, 06 Aug 2026 09:38:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0bfesm30013948eec.3.2026.08.06.09.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 09:38:45 -0700 (PDT)
Message-ID: <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 09:38:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
 <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
 <anNqhjSU5tEDC0br@redhat.com>
 <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VOfma2AqpJcf1nqyusrN42bH_0SCT9aG
X-Proofpoint-ORIG-GUID: VOfma2AqpJcf1nqyusrN42bH_0SCT9aG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyOSBTYWx0ZWRfX92UNkX0yjYM9
 QFxG6Au8PLQ347Z8izYYJNZcbjBSsoIAnRan3NCDy7lCHQ1Kl2HAZs+ogBn+3xj7c2Fc7mdmBAe
 54FBUwqYSN279AnNDwIwV9moPvnTY46iGW7jQZq2HkQmI/L7SJpT7hl6oGNzX2AmLoqq4cHlX+/
 fVAkGMD9z9tNiycgiJK5CAq5jJrj08GBwdNaic76F7IRiYEGwr9STnrEcbQ6Lh0JybYmeKjL+8b
 2O3ZxE2zLOootq6wcgU2A4pInS11RVGvIt8SPVFGS5Q/Hq1XlKfLIvFHPlDZZbO1yjCybVyG8fD
 f7I0LDVf54f0RPIO+QHLKA6BcMmcyP/XEZbOq9+cy8CLes5HKzx1Diy87hA899xEuzSgNZTOVCE
 97z8kVTuwOswAd7C/lQN4Gr5CPRkyWaDhseGHFmwczGBCETSKCqkeEHkAXa5cl2wCL2f6qchh7S
 lBKV8xScEnN4OqQe0fQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyOSBTYWx0ZWRfX9ZRXBSifnz0Z
 OGcxup/OKZJ8UOUJlMK8lRl55+rPRCa66xEZ/74K+p3Kt7oaaug6/d3PygI6cL9iXUpxrNnqrj4
 YcFqKJBReyrOeuxdG1LRYY/S6yzLpjI=
X-Authority-Analysis: v=2.4 cv=bdtbluPB c=1 sm=1 tr=0 ts=6a74b897 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=45k1y9aGPGjku8oAKx0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/6/2026 7:52 AM, Philippe Mathieu-Daudé wrote:
> On 6/8/26 12:21, Daniel P. BerrangÃ© wrote:
>> On Wed, Aug 05, 2026 at 12:10:27PM -0700, Pierrick Bouvier wrote:
>>> On 8/5/2026 9:53 AM, Daniel P. Berrangé wrote:
>>>> On Wed, Aug 05, 2026 at 09:16:20AM -0700, Pierrick Bouvier wrote:
>>>>> On 8/5/2026 7:05 AM, Daniel P. Berrangé wrote:
>>>>>> On Fri, Jul 24, 2026 at 12:09:21AM +0000, Pierrick Bouvier wrote:
>>>>>>> In the next commits, We'll replace the logic to filter QOM types per
>>>>>>> target from a static one (based on INTERFACES) to a runtime one,
>>>>>>> based
>>>>>>> on is_available() function, that can be overriden per class.
>>>>>>>
>>>>>>> Introduce the new interface we'll use for that.
>>>>>>>
>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>   include/qemu/target-info-qom.h | 15 +++++++++++++++
>>>>>>>   target-info-qom.c              |  5 +++++
>>>>>>>   2 files changed, 20 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/
>>>>>>> target-info-qom.h
>>>>>>> index 91be415ed33..83eb537333b 100644
>>>>>>> --- a/include/qemu/target-info-qom.h
>>>>>>> +++ b/include/qemu/target-info-qom.h
>>>>>>> @@ -14,6 +14,21 @@
>>>>>>>     #define TYPE_TARGET_INFO "target-info"
>>>>>>>   +#define TYPE_TARGET_SPECIFIC "target-specific"
>>>>>>> +
>>>>>>> +typedef struct TargetSpecific TargetSpecific;
>>>>>>> +
>>>>>>> +typedef struct TargetSpecificClass {
>>>>>>> +    InterfaceClass parent_class;
>>>>>>> +
>>>>>>> +    bool (*is_available)(void);
>>>>>>> +} TargetSpecificClass;
>>>>>>> +
>>>>>>> +#define TARGET_SPECIFIC(obj) \
>>>>>>> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
>>>>>>> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>>>>>>> +                       TYPE_TARGET_SPECIFIC)
>>>>>>
>>>>>> Looking through the series,I don't really see the point
>>>>>> in this interface.   Why is this not possible to do by
>>>>>> adding 'is_available' to MachineClass.  It would make
>>>>>> the rest of the series simpler and especially avoid the
>>>>>> need to introduced yet more series of macros for defining
>>>>>> machine classes.
>>>>>>
>>>>>
>>>>> We'll need the exact same interface for cpus, and devices also.
>>>>> IMHO, it
>>>>> makes sense to have this in an external interface, instead of
>>>>> forcing it
>>>>> to be present in all cpus/devices/machines. I also considered
>>>>> adding it
>>>>> directly in Object class directly (would be the simplest), but I
>>>>> felt it
>>>>> would be hard to motivate it.
>>>>
>>>> I don't see a need for the common interface across cpus/devices/etc as
>>>> as code that's filtering only cares about the specific types. It also
>>>> definitely doesn't beloong in Object class, but the Object class could
>>>> be changed to make it simpler.
>>>>
>>>
>>> We agree on this.
>>>
>>>> The object_class_get_list() method could get a 'bool
>>>> filter(ObjectClass *cl)'
>>>> callback which could be invoked on each class to filter it.
>>>>
>>>> That said I find it pretty undesirable as an approach that we're
>>>> registering classes that can't then be used in a given situation.
>>>> This has a ripple effect where every bit of code that iterates over
>>>> classes needs changing to add filtering after the fact. It is also
>>>> not great for scalability, as it means every QEMU process will have
>>>> the union of all classes for all targets registered, most of which
>>>> have to be discarded / ignored at runtime.
>>>>
>>>
>>> This is inherent to the nature of having a single binary.
>>> We need to cover those two requirements:
>>> 1. having a filter mechanism (per target)
>>> 2. have all the classes accessible for the heterogeneous machines that
>>> will be coming in the future
>>>
>>> 1. could be covered by what you describe, however, it breaks 2. For
>>> this, you need to be able to register all types by design.
>>
>>
>> Even the heterogeneous machines aren't going to need all the
>> classes from all 30+ targets that QEMU supports.
>>
>> IIUC, the current approach relies on '--target <blah>' to select
>> which target we need. Would the heterogeneous machines not just
>> change that to allow "--target <this> --target <that>". It still
>> looks like we should be able to significantly limit  what we
>> register for heterogeneous machines.
> 
> Heterogeneous binary won't filter anything at runtime (if we want
> to filter components we already have Kconfig at compile time).
> 
> "--target <foo>" is only needed to have a single binary backward
> compatible. If you use it, you fall back to single architecture
> (our current binaries). If you want anything heterogeneous, you
> can not use it. This will be by design.

I've been thinking about it yesterday, and we could apply the paradigm
"register only classes that will be used". For heterogeneous machine,
either we'll provide a "none" target, which enables all target, or use
--target aarch64,riscv64, like Daniel proposed.

I will implement what Daniel asked for v2.
However, please be aware it will be probably be more invasive and
verbose, since we'll need to add macros and stuff to have conditional
type_register_static.

I would like to avoid doing a change you asked, and have no further
comment after that or something like "it was better before".
Do we agree on this Daniel?

Regards,
Pierrick

