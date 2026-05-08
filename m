Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C5ECD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 19:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQVP-0007Yn-3t; Fri, 08 May 2026 15:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLQVM-0007YM-Ij
 for qemu-devel@nongnu.org; Fri, 08 May 2026 15:04:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLQVK-0001h0-SW
 for qemu-devel@nongnu.org; Fri, 08 May 2026 15:04:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648G50VN1116707
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 19:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fUbVUEDz1w/G9LmbSIthFrmcaUgxSLfAk51GPbpkE3w=; b=Udj8PVM/9QuYMUHz
 S2KbxfwIO8x9VCQ361L9OAbvgRmVgHwQbicluwxZ8Zl7Ky0wEC7ldpSXLUMyXXlm
 WcDDsqaks2/Sk8Oqk3gnOyy8YMuT/Alggj9d3C8SRRPHkS58h9uXoBZxtXlUTLk6
 4c7Udt3aUv3aOvYkAKEx2DsmB5uA2tvUK6OaPsCJigxvuzP01MglFGTWlN/Kc67I
 hER9rtPoDFwBEc193rHSdX8mOb/wK3x7uv4fzS5PvPXdJLYBJTf0NKisD1GVgRgf
 Ih1yij0lSwrJDwKuTxRd2Qq8GSwjVNbsSW5cvb8EWNe8yCWrxs5ZC3H/foD0KZ+X
 e4F4BQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1pgkn3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 19:04:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dba1e866dso1978234c88.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778267092; x=1778871892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fUbVUEDz1w/G9LmbSIthFrmcaUgxSLfAk51GPbpkE3w=;
 b=YdrGZXMAZOzwTOB8wEsa4yxe9M8ojNQdXaCa5pUMtkLp+K5HSqg+OisRa7urqTxrhP
 Os6MrS0yU+SmAof74gpD3P9b/3PZNeeyh4LjTOd6d8iQGzVOhpO91OkkcEx5cTmKw+je
 fKHElYCmD/Z6Trp3nEDsRXFgH9cA3jPb5wg5oIJ9Wog0nKiGwq3fssyLVaIoHMaU0dIh
 jh0Pxc678wn9nZMOhaqsFFHRgvhjPQV7er4CiskHGmr+GfQ9pX3iWH7BhYV1m93d07of
 xMWR6bfS9BX+5lQVEVpaQSRd0jbz3/tbpe8Mo+3p9eyYtPUToWCHgaeu4QXSU/13iL8t
 Q6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778267092; x=1778871892;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fUbVUEDz1w/G9LmbSIthFrmcaUgxSLfAk51GPbpkE3w=;
 b=iYfEdp9K5eWinQ3ulXNTHAeeuMeG0xYKyKT34mvPl5IfQO7x7brZIBdGQtPGOE3cdG
 h510amNx7KjV6d/oc4tcm9rNhoYzG+b2/bneFcOJ5aV1S66oEEViei61Ig7o4yf9NmC1
 XOobnCldT4doGkenbRa6QINPymXENVqzdM4Klcel3Rd9zLttL7v/gLbcqJYMacatRuv7
 4HEMy/hUcqBDFnxfUiVQ25FfdCJvAAsrqSEyYO1U6MV01MgIG0qhp/gjp0sEcfYZtZ34
 Z53GNzNfsKe7NW8yCUoF6MYuk9bF/+VX99rP862/yG6D2eKpzbIQaLIjRbXoAQRqvxZT
 LHAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gRTaa8wtmRlD9PToVlBFmDyk2SbH77lE+zz70sgnKpX07NAE9dhAuIJOS3wt7m0UX1W+jJt6NiM/O@nongnu.org
X-Gm-Message-State: AOJu0YxlUO+zbphXiKZu8kemplVKyr7n6trQlGIbys96FwCmo0uYMMJr
 Bn3OVLS1Nv02v7t2I9ef/zkAen1mDHiINyAUxeWIWPnapIpTRZEzosu0L4hVEVaJ2gbHuG1ZAqs
 fI5ryZeWwII3NsGyTTaLpsEo2KWq3o0caNhpPzOwvuOKh/eHMxO0+tkRu2g==
X-Gm-Gg: AeBDietXv1Sfei9usrl54E0GJaPvq+DtMXpKrjBfewxXWumPetiYJ52G1bOkAkU9cGd
 pnvRpgK3vnlYCy0LJJhVG4UN7d5zM4A1e8otkk0STte0hwB6tYBh/32eMn1wlTBqaDKUCfW5yjd
 bKDsCFKenkvG7tvC4INYbMz4rRzev10io6e3aYKphR2clrEse6U2utjis9TZ90NxKLu458gkhTA
 sWG50SvA5EoTlWQvE9ur0UkY/cckF2Ct7IOaGz8QluxkjLggKfiMOqyEM4tDHRcxdJUtRBCwo9N
 IgB22atQXaGrgkdZ2dUKHPcBM+iJutia/54PJInQ1c13WN4sxrw+yeVoH7cUUz3wDbSDfk0+33E
 vd2gnYWyGmpl/cQ+/R7ZqVcKwX7+pUfqolsnNGJDWMkiADg/QJLUtkkr8mX9pA4WXeLlfzxxFMX
 x6SO/fo7ElOm0b9w==
X-Received: by 2002:a05:7022:628d:b0:12c:9037:5115 with SMTP id
 a92af1059eb24-1323ae99371mr3793431c88.13.1778267091728; 
 Fri, 08 May 2026 12:04:51 -0700 (PDT)
X-Received: by 2002:a05:7022:628d:b0:12c:9037:5115 with SMTP id
 a92af1059eb24-1323ae99371mr3793417c88.13.1778267091152; 
 Fri, 08 May 2026 12:04:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327875a269sm3511588c88.13.2026.05.08.12.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 12:04:50 -0700 (PDT)
Message-ID: <b49f02ae-4fac-4a6e-8968-84fbbf3a6e51@oss.qualcomm.com>
Date: Fri, 8 May 2026 12:04:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] qom/object: register OBJECT and INTERFACE QOM
 types before main
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-3-pierrick.bouvier@oss.qualcomm.com>
 <21c6ed67-ad7a-440b-b6e8-20835cacd389@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <21c6ed67-ad7a-440b-b6e8-20835cacd389@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IQNYVqn0IQeAX0ICwKHCyrxqUfh7NaiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX00ZgHPBEs01J
 Fvy5k0RmIlhsqB1xwiVb/baH3PYZjc0iESso5Nv29dHhUjqVPpYmAt72aQ9R99e58FGdpYF3UWx
 JqDjjIZ6qysQ6FT1Msw5FvluWK0ZXYSArOIpwJBJgP1wo+vD7shrClQD5CJFXzr97zQyZl0SNrx
 2w1zDsqH3LDGM8VJMHldruNzmd6KSyDLmJIaQUAoFBtnwgen4uXr18G6hRI5ASTdPRbK6D2HutI
 VPXKObB0rhH1HBFKjsR3XWNBxCMiYcipcSebAx9BPAeNb2P385Xfm3glRx3q6IPgadyDKEUdDE9
 71WX76o5sevAFVTyg7L3O96ZYMUXBOveDBU3hNdx+pbO/T1t60nsfpaeriwtCNw1/iYAIqRr5k3
 zOvjIv4XL7TDhfyb24YqqVhx3aFRmlaTMo7GSgosW7l5TSNayS05U20UDxOAqokqVHli3AU8ccq
 lfHuFbAgBJiEQloD+jw==
X-Authority-Analysis: v=2.4 cv=COwamxrD c=1 sm=1 tr=0 ts=69fe33d4 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=cilDik7dx2sqUwjTVvYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: IQNYVqn0IQeAX0ICwKHCyrxqUfh7NaiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190
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

On 5/8/2026 11:55 AM, Richard Henderson wrote:
> On 5/5/26 17:48, Pierrick Bouvier wrote:
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
>>   qom/object.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index f981e270440..a5d268d0722 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass
>> *klass, const void *data)
>>                                     NULL);
>>   }
>>   -static void register_types(void)
>> +static void __attribute__((constructor)) register_types(void)
>>   {
>>       static const TypeInfo interface_info = {
>>           .name = TYPE_INTERFACE,
>> @@ -2857,5 +2857,3 @@ static void register_types(void)
>>       type_interface = type_register_internal(&interface_info);
>>       type_register_internal(&object_info);
>>   }
>> -
>> -type_init(register_types)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> As a followup QOM improvement, we could use this constructor to
> explicitly initialize type_table, and drop type_table_get() and its
> continual checking for NULL.
>

This sounds like a reasonable idea. There should not be any other QOM
type registered with a static constructor (previous patch is the only
occurrence I found after review), so we should be safe regarding non
deterministic call sequence for static ctor.

I'll add this in v5.

> 
> r~

Regards,
Pierrick

