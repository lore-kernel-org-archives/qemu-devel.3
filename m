Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FEFFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITsn-0003KB-BB; Thu, 30 Apr 2026 12:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wITrv-0000fP-CF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:04:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wITrs-0007NK-FK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:04:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UCGpvC830496
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 16:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 55a4laP/nZU51is1w/ijrGovlectmTRWl7X667u7dG8=; b=dOTMuZlt3+7FAP43
 fHQ51rVz+oUFoempRXv8qRxy6UgGAUeiORm0QFb/bLDo9/YTL7m5u3fTqxQ9yx55
 Dec+ewNtCZ5FSD5/eWlsAT720nf/GRoUpytizQMw1kZUZPvRg/iIdu0i3df8q7yt
 7HFulHRjc3LyGCVNt9UHTaOdnlpilchaLgt6LFUb+rO8itON6GbDk8EgbsSlf5aE
 bARgWp4p2529zCJPgsgxqEPNOKKxeY/65C4VZaaFJ1vkdKiLmBCYl3KrJcmtCyg+
 KdD8jFrPfGjP3OMHMNRFW+HJxteOY2Nb9uA7dPFo7ma3Lx8tBJAiXyEtaSINAq2C
 4KpHUg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv2cq2cw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 16:03:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso1857522eec.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777565038; x=1778169838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=55a4laP/nZU51is1w/ijrGovlectmTRWl7X667u7dG8=;
 b=Ku3cQv5w5AggxQ/AJZvi94mHaVJSmtwpMb07E+oNTi+9oNqyj8CRwthYPliKKDGaD/
 PBMPwDu3iicvaLi5KNmj1TLlp+u2qYTCwI3AW6FvebWEup+ZdJp3YLp6xumRC+3fs/li
 QAXB1p74vWM/UM1PSM8g+/0/T0ruY2228+cFcaz/dg4hcZV12VNzeDtsFzGiKmRvpTnr
 bqoUJ6L3P+XcP6ouR4D10yYBtt1mtIDdHYKapivmwZsfMJH+gp/LAfJ7FwKBhV7b3J14
 g8j4UVHJgA7Ue58dEIYl03pa5uRP9zxuSSXQlaoK6//zcViR5gSb2t2mamRjY08Bw4zw
 wfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777565038; x=1778169838;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=55a4laP/nZU51is1w/ijrGovlectmTRWl7X667u7dG8=;
 b=ieKa51Z2OFHqgW22uqtkrq7+j3c1SwmKFs95o64oj1KG0aqJhK/vIHjwtY0xxxK23A
 n4t33H3h9Nyiw4r1IvdzkLAsm9gsi0wMTmkcbMqJORZKD85hKo3ViwRyVj64PyJXxOj2
 /GKcrqjiOXkw6kKuc5zCaip95oyU/mu+C5H4xT2cpvGkIcVI+81+e2XgsJ757s2aDchB
 Ptwxd42xFX6aTjsQRdpJspV/XrQzYCtwB1+m3MCudIB7D/+AuEf2ntHRPsph7TVgLy66
 N6WbfBhM7UoKR4S4+Evkt7xwFCUtPUBEPWEYUjXEwHnKmn8ZP7DwshKkvQ3MrW9fa5R4
 VMqg==
X-Gm-Message-State: AOJu0YyzYuW/xhMbZTn0Q5+rDXWu7T9bK/QJibcejg/JxRMt7tUaMKZh
 tqiRN324nhwb1hyLqiu6dDmmol+ORsleF1R2aWeFyPOAZmP8L8GFW8fQ3LdmXqvV0XhS0AeDShn
 vrV5clQNyt4FlYYSSvtwwzd+gmHyWL7hDZym/gX8++MqP1HS941Wu/wvVMw==
X-Gm-Gg: AeBDievVqU/oXcR3Cz2phiuzGtvY04iw7tZS3OXYymEKlvt3rpWr8UAalufm98ebny5
 zdEXt8TFax0xUcQPb4NKLsK7pixGTuk52V9da6AwJjI+0U3JB8sszMGzAigrfmlFZkPFVHhjtu7
 3+77SGjRMmOuWoa1rA9T0VstCvIqER5Uh4yYO5bd1IXy8vSrmB4dEM0dDjX/jFAaoQ085ZVinKb
 lnCkTFHrxOmlafTDTTFeJl3FUtuJ3mXWXcMgx14yIDDK3UVFfr3jujhNselWZz4pPMNJJ2iMBVb
 y0eMYIrYJO3XYO9QFcjQpgjVpvIM0z1zAIfyeTaa/RboihGF1q4rfUuLnhR4PPj3DbvBoyvMBHb
 pW+aj3MVLdBTxkUlR6t2Gmufo79s901rJyQqWZHhw6qrGZAA+lUuN+CJhEG8iDgwCDA3jykUcVq
 wT/D9l4mYfSIGx6/Es5Nrt7KNJ
X-Received: by 2002:a05:7300:df4c:b0:2c1:6cfd:73ee with SMTP id
 5a478bee46e88-2ed3dcb58bemr1818092eec.24.1777565037399; 
 Thu, 30 Apr 2026 09:03:57 -0700 (PDT)
X-Received: by 2002:a05:7300:df4c:b0:2c1:6cfd:73ee with SMTP id
 5a478bee46e88-2ed3dcb58bemr1817842eec.24.1777565034965; 
 Thu, 30 Apr 2026 09:03:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38e71bccsm415800eec.11.2026.04.30.09.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 09:03:54 -0700 (PDT)
Message-ID: <d95d58da-764d-4967-ae93-2cb7418d8c5d@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:03:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] qom/object: register OBJECT and INTERFACE QOM
 types before main
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-4-pierrick.bouvier@oss.qualcomm.com>
 <afMA8SCcF9XJ8VUe@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afMA8SCcF9XJ8VUe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A3MKNk81txQ1hRziGrYcT8wHsI0TneAm
X-Authority-Analysis: v=2.4 cv=aYRRWxot c=1 sm=1 tr=0 ts=69f37d6e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=cilDik7dx2sqUwjTVvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2NiBTYWx0ZWRfX3Is5mxTcLdM8
 JKRdNtkuzhd1eL810iJPjPn9fgMhnuxGeI2EFMzH+dfnkchmAg0A530LF/0PDuGFhQwXE+15Nwe
 q3uyIX1Mnv0IgV2JXpHjkyPYqJhhEUtc3pJky3yoQczHOgOJiEDRfiRe3Dr13uBSYBourcT0Fwv
 fYLzjjef1DzlGtiHIMLCDH4hwbmkU6a33N2EOOOEP2gE1OG6dwdSwOc1yQ7fXw+mY2FCm6OqUw8
 6CMMGwHotNdZo88D1K5GlT4KDLKunWusgJUErjU+as6b+yTrvklyx16IjKkwBf4ts3vQIXK840i
 ohdh8QxX9bbiRFsK/HujQq9YNJfDj7QKAl+xe/qH0WGhgG6MEyyqPdlMxwzeYJp1zEadD4u4OPR
 48CSKXCdb3G8VRFzQmUARwl99Rdii3DTySDfccCxELLxLYODaLJXyYuU4W3kP5ReohINJcxJYWW
 qMvLs2BtzV2X/tpOhYQ==
X-Proofpoint-ORIG-GUID: A3MKNk81txQ1hRziGrYcT8wHsI0TneAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300166
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

On 4/30/2026 12:12 AM, Daniel P. Berrangé wrote:
> On Wed, Apr 29, 2026 at 08:56:22PM -0700, Pierrick Bouvier wrote:
>> Those types are special, as they are the base of all other QOM types. In
>> next commit, we'll introduce an extra step in module initialization for
>> target-info-* types.
>>
>> However, those types depend on TYPE_OBJECT, which is only registered
>> at MODULE_INIT_QOM step.
>>
>> To avoid having to introduce another step, and modify all code calling
>> module_call_init(MODULE_INIT_QOM), we simply register those base types
>> directly in the static constructor, before anything else.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  qom/object.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index f981e270440..a5d268d0722 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
>>                                    NULL);
>>  }
>>  
>> -static void register_types(void)
>> +static void __attribute__((constructor)) register_types(void)
>>  {
>>      static const TypeInfo interface_info = {
>>          .name = TYPE_INTERFACE,
>> @@ -2857,5 +2857,3 @@ static void register_types(void)
>>      type_interface = type_register_internal(&interface_info);
>>      type_register_internal(&object_info);
>>  }
>> -
>> -type_init(register_types)
> 
> IMHO this should have been done using the MODULE_INIT_QOM_EARLY
> approach that I suggested on v1, rather than special casing both
> the base classes and MODULE_INIT_TARGET_INFO
>

I'm ok to follow your approach if you really prefer it.
However, can you specify what should be the semantic to put in comment
for it? I have trouble finding to explain what is early vs non early,
while it's clear for me what is TARGET_INFO vs REST_OF_QOM.

As well, adding a INIT_QOM_EARLY implies we need to call it in all
locations where we already call INIT_QOM for future-proofing, which
seems very redundant. Should we had it or not?

What do you think about these two points?

> With regards,
> Daniel
> 

Regards,
Pierrick

