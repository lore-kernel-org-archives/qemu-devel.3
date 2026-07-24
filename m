Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75322C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJAO-00074i-5e; Fri, 24 Jul 2026 12:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnJAG-000734-G4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:54:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnJAE-0007nb-7T
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:54:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGqP143153710
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 16:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jTqttKSo+tFsrEHgM+hgQ5WafYR+Ksf8WLBl86iKsJs=; b=eOOpSg/6Fz3nudIg
 ar5SQYd0acoQmdDePdaIrzSNS2yoYH7vgySdef+Vf6nq2BgFs2oHvfL7IHrRVld5
 2uSnaCJpefkx4X9sOcBphFQ4OPq92snNopF7m4+TvHnsDlf1FFVmH11zlm2E+iJy
 IKUGfw+GMk+d9rxy8YypZp/r2psM5p8IMU+l/t3MNN6VT+r4ztXMEOr/AK920PL1
 k+WUO0ik9QcK3Uk3TNT3w+fUJbOsz9tjIw64bXOTSjmntCNtLf7K178/Ive4l6wq
 nI18A+v49E6tJqKFyXbpjAXKte/x1hPWEOosOFlCbbtGuLVjxTgue4DD/4eZLnto
 dy8R0Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cggw81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 16:54:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so1015740a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784912058; x=1785516858; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jTqttKSo+tFsrEHgM+hgQ5WafYR+Ksf8WLBl86iKsJs=;
 b=b5R1PPl3UB9YCuxZKeQ92/S2A7bX4I2Za4JkkBx+iKc50p1/vikjI8ReE5GpdPqNMf
 9zEy9IGFcx9y2eL8ZD4g7os80PW2WEhjBzhc7gR5pEaBOhuGqzzlzCJlRQ6KKlS+sv6Z
 tyX1h2XXPaCYlmBiVvX2eDAbOVEgAXbEsAGNxjmYkfA0qq1TQ7r4s18p0IYHiT3xbmRd
 dT4cLOJpeYgwDFIGD733Yndf8d8lH00ho00bS049dN3ksAPe7N67Vd7OQmZgFw2QZLLG
 udbkt9c/u0wJ0eGOwRXs1kOs1/AyGE1AnzpggkVkcCd1Iyyfz5921kTBNWIfvwtEtnWC
 0V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784912058; x=1785516858;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jTqttKSo+tFsrEHgM+hgQ5WafYR+Ksf8WLBl86iKsJs=;
 b=XfQDxRm9A9bMH9JwgEBwaolvUbu60zcoG/yYAiaxl9P0FSC/PtEZ/LbbK2/N9kYDJw
 x4ajLKQ5qmKHNQ7+wnZ1fsooAlCSDeI1Ctuhn6JBE66dSUTeJuKSBMETo9d/gR2dw6Lv
 V2Krore16Z/Z6P+uDLvBR926ccuk7yt4GZlZHyoE1X4AywUDO0irVRUqmAGHGyXGxyou
 bVS4K+aPAQHLu200FJLlOaW1xIVYm4+djEXjcyjqt4gwUUVXXaHp6adSqX61DfNzJWuw
 iZFY7HfUb3g2ddnAjQNJ4lHnWCVEgTl9Cn8QTF0MCyd4eDPicciWhyEznjeJ3DrcFpzQ
 M6fQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtJT4M85NKN5JlFdzbfG1z3JidfHMxAlBfRRd75/DXg1Yi+MnCPIhRaXXYQYKHHsAsCMhJY0O+2hzs@nongnu.org
X-Gm-Message-State: AOJu0YySmxsq6aheCy/UX8R4TKLSC6Z+oGmyCGcDYGpavbTI3NVYL6Gn
 rXqH8kWNPIqL8aTCqz+FI6LReEoredXpJlcH8f6cZXWS1HIuzISFCB+QDUda9Bs5J9KLi9wxDJi
 O6DDO3Phix+WhiBuYyNDxBKArcXMASEdyYc32C3UkljPP/eAlQg4rB6Yqsg==
X-Gm-Gg: AR+sD13Auf0Sygv2GLqbldohNlR3DWd9h/ld+imT2CEdanon8vYE8eeQvDJV4BFIRxW
 Jyd34afbz/rNvuD4WbOU93Wgg1sCusFtVvcnmw2IGIfLLX9Ga/csXaCDdMoyUbcpIJfEAZMbX0M
 MCLdyz1vDfWifsekgEb7XV3yRBK8gmFoLn7IQzwqtfVzsdCdtsqIWZiYcdhn4xrdElJK4JXSDxY
 Hi+v67LCglmhFD4RpYkHIAS4pwfvo8eBLMteIqnr+qfp+Mm+fkaLXbUTMXUBsphCil4PmSw3FvR
 F+yQTBF2Q5u++f3dVWV6rXkHiUkJ5zFDufyYp+XbAOSb5slDPHeOqgZt9Gq0sgMOGxFddaOgMlV
 e6O29t8SMsxXzmryZA3Kqt7429mm2ass3fBlnsG588WYIUPcLj2FPVERWoHgCKWOJ9w0h
X-Received: by 2002:a05:6a21:6f12:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3c44b01327emr9328022637.25.1784912058267; 
 Fri, 24 Jul 2026 09:54:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f12:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3c44b01327emr9327997637.25.1784912057793; 
 Fri, 24 Jul 2026 09:54:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm1029996eec.10.2026.07.24.09.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 09:54:17 -0700 (PDT)
Message-ID: <eaf81277-4afa-4a4f-96d8-ddfb80d3706d@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 09:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <e310e5d1-8419-4087-a967-68f806c67fa9@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e310e5d1-8419-4087-a967-68f806c67fa9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JOMLdcKb c=1 sm=1 tr=0 ts=6a6398ba cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jQTJpVBTkmvQw_xdRuEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: xz6E-chF_ROO4hByOMTPmtV2AJ3XiTJE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1MSBTYWx0ZWRfXy9yyvatuydrv
 FijyekUQ1oMJ5BLUPF4N704zUaa4gb0cPJO7VMbn1Fo7y6z8gwUmTh4rDxn4kZ356FF462F1G8b
 JZNncA7ZXmdAWhXjdNdk3IEPkiQKlQg=
X-Proofpoint-GUID: xz6E-chF_ROO4hByOMTPmtV2AJ3XiTJE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1MSBTYWx0ZWRfX26goDQbkcFsW
 TLbKaRA26L80GK+rE0E5yiFqRGQs2ISgJ2souXffsJHFBCVPGmB7xUNo21fRVfgOU+Fg3IaOGHq
 Zg2U/xvKJHBhn2+StbJ5OPERfmYdQavR7miSa2h9DhQ/dg5l3/FN8LjqEZZGCcBDOcLdyYI93s3
 0S3L6rKg9fRTBEq+iCmEg6qxFn6ChP4ytuqgcj2yvPewVjjAwQDprf9cnPCwC7e72Lh4Osty24i
 oxLSonoXk+FYOOYgrFlD0IQDilEUFRstMDlOhitEms3IOQKZOI3qFAJ4hADN9zfMp/s35qoziMA
 guN0QWvnZfyGZl6sBdI2UFngCaTjlifOQI9ADzNqS2i8ENhTfMEY8ZjjXiVE7xkezSfXL1KwE48
 qq0GQCqVajv105Kkv1Shl/Exx8DxbASSOGM3HKQlrAbILveWExhHSKG0xUcA2BYT+Qk4D6j7bdO
 Es5UItzBQ0bhUVKqyfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240151
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

On 7/23/2026 11:21 PM, Philippe Mathieu-Daudé wrote:
> On 24/7/26 02:09, Pierrick Bouvier wrote:
>> In the next commits, We'll replace the logic to filter QOM types per
>> target from a static one (based on INTERFACES) to a runtime one, based
>> on is_available() function, that can be overriden per class.
>>
>> Introduce the new interface we'll use for that.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info-qom.h | 15 +++++++++++++++
>>   target-info-qom.c              |  5 +++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-
>> info-qom.h
>> index 91be415ed33..83eb537333b 100644
>> --- a/include/qemu/target-info-qom.h
>> +++ b/include/qemu/target-info-qom.h
>> @@ -14,6 +14,21 @@
>>     #define TYPE_TARGET_INFO "target-info"
>>   +#define TYPE_TARGET_SPECIFIC "target-specific"
>> +
>> +typedef struct TargetSpecific TargetSpecific;
>> +
>> +typedef struct TargetSpecificClass {
>> +    InterfaceClass parent_class;
>> +
>> +    bool (*is_available)(void);
> 
> Hopefully we won't have to call this with heterogeneous machines.
> Otherwise we might have to add another helper:
> 
>        bool (*is_available_ti)(const TargetInfo *ti);
>

It should not be needed, since meson build system filter files for which
CONFIG_X or target is not enabled, so they are excluded from the binary.
The case we deal with here is having two targets with two different
CONFIG_* sets, which makes additional types present at runtime for one
of those target.

>> +} TargetSpecificClass;
>> +
>> +#define TARGET_SPECIFIC(obj) \
>> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
>> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>> +                       TYPE_TARGET_SPECIFIC)
>> +
>>   typedef struct TargetInfoQom {
>>       Object parent_obj;
>>   } TargetInfoQom;
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


