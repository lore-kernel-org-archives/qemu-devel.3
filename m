Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9B6CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVKa-0004aX-S4; Thu, 30 Apr 2026 13:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIVK3-0004My-3P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:37:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIVK1-0000Ok-2B
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:37:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UFQ2SH811044
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 17:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JX1Ldo/qkpoO6LVqki3sM59jKBrokdWMjgkHb3FbB1o=; b=MKiT08KHYMn9/oFH
 biIwzTaaONjzzi/QTJiYC0xBUMV/FZd3qST2U/gavhhNY0ubyFXOxomJ2OVOdHTS
 scdpHrrxG9+BrtXrAPOVMBFuQITEMPUKq9K7fR3OYvkCmun+YwDe6dfR4Grjrqpt
 roFizepSYkxd7ceGC7Z0Ol5pOfc7GGEnUPV+i+WP7QwYIXbgsGqRqFZwRpU71/qh
 kIYFnGoLCx1XzOUqp3ejG6V05Nxy84opO2LAGBVHmhhNtZZP9AbD95YOMvqpxjTp
 TNMxT9Gd9Vot+JitFdei7ms7jVarQS+RiybN6eSPBNYqQ2AvfMFDs2tVMe0kLnwB
 /tvrYA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q43wd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 17:37:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso544130eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777570626; x=1778175426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JX1Ldo/qkpoO6LVqki3sM59jKBrokdWMjgkHb3FbB1o=;
 b=iIL9s7ZRAjb7bVj0bkaVuFfpvgwQVNll9UUS0pM7cDUx7pv6u43sPjugDOOjtye7Lw
 LPRwjZMHD9q7o4GT9ANlyh6g/zbPNv4HfhT77UXAXcc8VoeYtq0bbTKaqqmI2U7gCdQc
 JxWwXy2LNJadwLIx3kUXotdACTUhgKxPSTU6WtIoBKRGoUNHGVCAfatm6lRmu1kZxVFJ
 ctmCz5Tmd1zCoP/5qx2/JOTJqXIuqFQjt4TSmcamnJbe1RBjGZa4dJXh1bO2GqKfCbB4
 ArWmghgJt7805ZnkwJ4cQpG6Vwfla3nsfq4NBYd3bFQKWp7kz7U8kod4kiunuQ0XCeel
 hIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777570626; x=1778175426;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JX1Ldo/qkpoO6LVqki3sM59jKBrokdWMjgkHb3FbB1o=;
 b=Jx7MHr73eDX3Kyvshk/CxHAuGab2QOn4YsqhFmog6+J0iAqpAAQYe6yn43Q2ZQxb0O
 ZmC5yQmw/DlKHD7zznfw4MKuFv4AUpNEyddAOvvLFP+8Bh1k1G6OPdA9kZ9JbHip/GvU
 UK8O3ZE8nyGWDJWXldMbvCvjGbI735nHCDiThYo5IE3wCho81RoKGDvDP3bfkpaVwd6E
 yEiHoVds+KV9XHnNyOFpFVgwoK3u+sxOyXsbJV2Iw91h7Yl6j4RNu3p3lvaESm4psmBO
 mwB6Wi+8dh4WZHrEoGXIJgiou/M6O6m+CX++/3URfKjJLvp80MYZa1+rdfEYaaBmcTQS
 7CWg==
X-Gm-Message-State: AOJu0YwUbCZseEBYHhvJdEN6h7LLdjqkCsCIuZajYSGD/XIGuG97NcGF
 acT0gW9hNbdY0sNLt8lz2D7dcGet2mu6j//lBqNbq1xa5bgmrUMGoVaZdCLaa8+QfBbfqNi1H76
 maUhAvuS3nujrTz0d+YJSrk3A9y2fYjzS0AzqZO8wce7PL31DEzLUGHKOAg==
X-Gm-Gg: AeBDieuzWCsiBR2JF/ZMDTKQ6ES1X5yjmTTPZDBC1xEZfgz7uLAVr5AaQwgv9HtHALI
 +id99eiKc7OVOOTy/zd1OC4NxTlTJOCbQ+jHbWv12FEVw8qi6Q6PegZdxhw/Nr2/zLSUWmAKB6U
 GsL04z8zQjXrReN5wPD6EsqcSGS6mJVLBwUA63NEtW5lHErXGfP0HL2M72gGdq4cKKr2CfAqNW6
 wznffYLJGO7lBoB+kmk15qtSOTKQRDvPo5UsPrDQ/qaHXYPr7unzE7jIhBUQOED682Z8KzAJzd9
 vC7nJVQv39i8ohsQlpP7FiusDaocQRvk+RALJSUdf7qm07A3ZpfOGN5Ptf8OwxOjcGeDopMAauA
 oGpW+3raoNml2u49elXTHvbu9ys43jLrzy/L6Z98rCJFF+LK5laj2vtjBm4OFxHi/oXMu6TQ9bx
 Gxom0tnje9e541tJWAvisrilF8
X-Received: by 2002:a05:693c:2d8f:b0:2c4:61be:1d33 with SMTP id
 5a478bee46e88-2ed3bdfb209mr2105915eec.6.1777570626340; 
 Thu, 30 Apr 2026 10:37:06 -0700 (PDT)
X-Received: by 2002:a05:693c:2d8f:b0:2c4:61be:1d33 with SMTP id
 5a478bee46e88-2ed3bdfb209mr2105876eec.6.1777570625696; 
 Thu, 30 Apr 2026 10:37:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3b29b1a4sm796349eec.18.2026.04.30.10.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 10:37:05 -0700 (PDT)
Message-ID: <c237e91f-8293-4455-b087-3e6dac4e1fde@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 10:37:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] qom/object: register OBJECT and INTERFACE QOM
 types before main
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-4-pierrick.bouvier@oss.qualcomm.com>
 <afMA8SCcF9XJ8VUe@redhat.com>
 <d95d58da-764d-4967-ae93-2cb7418d8c5d@oss.qualcomm.com>
 <afOMOcbpEnjzfyj6@redhat.com>
 <727834b3-b4be-47b4-a14b-22473118dcca@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <727834b3-b4be-47b4-a14b-22473118dcca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8kVaVQQYKYAeEnVSSycQFxKIk2ZsNPuz
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f39343 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=idz6DIzpsbBe8igxbM8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE4MiBTYWx0ZWRfX0yYtbf4JYuHJ
 KnCzDllb/zlnoJ6uWQFTqrlJdFvcB9OfQGWYFF06uWH8RzCwAyiwCK9nYGExnWfwitT2go4pwul
 J7sPkl0wZADh/bhsxYWm3hoAs7cyrZZsCuLJHpqmq62qzVHlhN0jOafl7CrQqoFC3Atu2zi766F
 4Bu4qnBvd3NeRmzNxRZ5YRfC2qCw7e0O303lYvWiU0dx6R19+CKTnhnh30uV4L9I7YgG0C6vhKw
 BGVCw57ilQiHuwuxnYbeN3qAqmMkDI/IxfxnT7ysLc0GknBB/ubmxE4PDHECo6OS7ZDkclZpHvI
 Y8F+r/J/JtsogTFp8m8m69fO2E84YmNsIKq4jFvu1o/ZhksV3ulxOkxgmLpzVXR2wvw7CDJ1fTm
 G3TKMjUfeMLmy1VwE/SWlEHjgLAfVn/JoYvxp+QLKbgC2JHjfX95fS0b4Jb8tKLue1o9hjhzMZT
 Ri3MAg5KG9Gpxrcmnvw==
X-Proofpoint-ORIG-GUID: 8kVaVQQYKYAeEnVSSycQFxKIk2ZsNPuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300182
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

On 4/30/2026 10:28 AM, Pierrick Bouvier wrote:
> On 4/30/2026 10:07 AM, Daniel P. Berrangé wrote:
>> On Thu, Apr 30, 2026 at 09:03:52AM -0700, Pierrick Bouvier wrote:
>>> On 4/30/2026 12:12 AM, Daniel P. Berrangé wrote:
>>>> On Wed, Apr 29, 2026 at 08:56:22PM -0700, Pierrick Bouvier wrote:
>>>>> Those types are special, as they are the base of all other QOM types. In
>>>>> next commit, we'll introduce an extra step in module initialization for
>>>>> target-info-* types.
>>>>>
>>>>> However, those types depend on TYPE_OBJECT, which is only registered
>>>>> at MODULE_INIT_QOM step.
>>>>>
>>>>> To avoid having to introduce another step, and modify all code calling
>>>>> module_call_init(MODULE_INIT_QOM), we simply register those base types
>>>>> directly in the static constructor, before anything else.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>  qom/object.c | 4 +---
>>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/qom/object.c b/qom/object.c
>>>>> index f981e270440..a5d268d0722 100644
>>>>> --- a/qom/object.c
>>>>> +++ b/qom/object.c
>>>>> @@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
>>>>>                                    NULL);
>>>>>  }
>>>>>  
>>>>> -static void register_types(void)
>>>>> +static void __attribute__((constructor)) register_types(void)
>>>>>  {
>>>>>      static const TypeInfo interface_info = {
>>>>>          .name = TYPE_INTERFACE,
>>>>> @@ -2857,5 +2857,3 @@ static void register_types(void)
>>>>>      type_interface = type_register_internal(&interface_info);
>>>>>      type_register_internal(&object_info);
>>>>>  }
>>>>> -
>>>>> -type_init(register_types)
>>>>
>>>> IMHO this should have been done using the MODULE_INIT_QOM_EARLY
>>>> approach that I suggested on v1, rather than special casing both
>>>> the base classes and MODULE_INIT_TARGET_INFO
>>>>
>>>
>>> I'm ok to follow your approach if you really prefer it.
>>> However, can you specify what should be the semantic to put in comment
>>> for it? I have trouble finding to explain what is early vs non early,
>>> while it's clear for me what is TARGET_INFO vs REST_OF_QOM.
>>
>> I don't think we need to set our strong rules. It is just an early
>> startup hook to be used by classes which are a dependency of other
>> initialization code.  Conceptually this is similar to what we did
>> in system/vl.c, where we have various stages for creating -object
>> args. What goes in each stage is simply determined by a functional
>> need at the point in time.
>>
> 
> Ok!
> 
>>> As well, adding a INIT_QOM_EARLY implies we need to call it in all
>>> locations where we already call INIT_QOM for future-proofing, which
>>> seems very redundant. Should we had it or not?
>>
>> Yep, that's true, but not the end of the world imho.
>>
> 
> I'll go this route then, and initialize TYPE_OBJECT and TYPE_INTERFACE
> in QOM_INIT_EARLY step along with target info.
> 
>> Ultimately an solution is a bit of a hack. Long term what we need
>> to do is follow glib's approach from GType and have "just in time"
>> initialization on first use which will make everything "just work"
>> without having to think about ordering. I didn't want to suggest
>> that now though, as it has potential to be a can of worms.
>>
> 
> This is kind of what we do already. First time we access a type, it's
> initialized. The only thing done statically is registering types, which
> does not trigger anything except adding them to the global type table.
>

More exactly, we statically register the function registration, and then
the module_init "orders" calling them at different chosen steps.

> The current issue is more a dependency issue between target-info VS
> other types, which is why I thought Marc-André suggestion was better
> than a generic QOM_INIT_EARLY. But I don't mind following this approach,
> my goal is just to have something that works for our need.
> 
> Regards,
> Pierrick
> 


