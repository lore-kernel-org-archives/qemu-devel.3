Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07100606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Iz3FRKdv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISBO8Rsi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTXw-00033m-NK; Thu, 29 Oct 2026 13:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTXt-00030S-QX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:04:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTXr-00070b-KY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:04:09 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxo01619552
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bu5u/O6/oKWSLiCwuQYECSQWs9MG7Nye9YNTy4iIV04=; b=Iz3FRKdvg83k2bJB
 JLVxt36Cpwls/V8yuzvw7tDM6hziom4g1kW5IpZfiHPIscoe5SLDoKdRBfWe8K2O
 6f9ucO71ybB5nzFXReSHX2VsWc9TmKMQaOQuTT8VzxCvCQcpeG04ZwTrYCwtsHY7
 ZH+TVKWtFdnrOrM4J2eWtaV5pLydGWrZlyBrqqwr84pPHvRUkBKaDjIjgkw12EEe
 QKmYiQs2jlq0d4WweFABEZnVuiqi1muWCq4D5EufMG7Ml/8LW7ZCrFdTM/Jf5BJZ
 4GBoWjPf9NVzsacmkkWxmREtE2QjejHoi6FBgv+v1AC8pFbofG4p14ckVGBeFExN
 mJRdyg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9pw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:04:05 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-189d17eca17so1317305c88.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793293445; x=1793898245; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bu5u/O6/oKWSLiCwuQYECSQWs9MG7Nye9YNTy4iIV04=;
 b=ISBO8RsijSKWBAf47QrZ1B1WgxbhjML47bRc6XdOf/IFegH2+wNyjeNb7vV7n/6nE2
 Mqeeo0IUipC3yH94MU9TRncg5YbDbF6kb8l9G2e10sAN5koPPqUUOEnONHfdp2WrMF4A
 aoe0pWmnqvbtQoILT3+3iEOlxZkRcRMqhCFZVFuGx/MRG+4szBmjrcE+SPKB5FaYB5G4
 xOFVyWg49QVrWCemSR2ACnaF0+0zfAymqtkHzKhTka0R7Bq1IrEgUW4mRf1pmw8p8R7F
 UyzPnMlH6girDD4EmjdpZz3FnpBckB53pVDHFBdkN07TJEPWUjM8/BMtIQurHQY5bXWD
 +E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293445; x=1793898245;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bu5u/O6/oKWSLiCwuQYECSQWs9MG7Nye9YNTy4iIV04=;
 b=DWkwNTf1bsn2n5+/cWTD7kNb0YptVKiiHLEOwV65VT9vazbPCNGGz1X/OMxjCwaw3K
 IOkGJ5rhUXuyC0UFfnVTlBbjJjfRKUL2Kf6/CBrUoiaYI54cCR4jKNKAPOV5f+aTRtCD
 k68vu56Nl8TK0EEZbbBXsfah5q+vWzWkTjVUDhn0Oneb/yXvdgRmnqUvkqvSSklOyxUs
 wGhvDnoB48RHt7WpU0DVnH0eCXDv1d+vPNrx0eZAFC0s/z11+LF+gncCzRHj7yi7RXF0
 2Iuscj6M6KwDtyLCGMS0KQQSj3YNUD6c71EdFzYk1aJqmanMxRcyZAeZhkB+Pla61HrZ
 zyqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhcr/q6T3o0edlN6fAfrtOlvv5XLscihL5U82Lhz5g4xtzqCnVEayni07gsq25H1Qb0EcuCO+4+anm@nongnu.org
X-Gm-Message-State: AFq9FYLtZFiIsTZL4Iz0S7WSQ9W1mlkeaYW9hq+D9mYWAD41UgAm/FVL
 KWyPJuTHUW8QFDwggLBzIKVa2vUtkBeGVO/UUgHG4MLis7Kf2OVh5bBsFPmnHfD2MEKXrzi7FoV
 Ue/7y/5O1ye5YDRAsajOrpKgQtHxJ9RJoqBSbaEVWCPjdMuR37x6PkuNZUQ==
X-Gm-Gg: AYBFou3EJL4PjeW4Yj1PQ4LpD9Xre3qztwUNBJDcMFl2qrwkzbcOO6VBtOg5Dcxk+9/
 xpgFgJZlaeaKz2jo2Lh5N5izCwqhv4xjF2j5E2jiJZs39HzpdbVSc4EfljtzQ9mWeBvUq4IpLEw
 02cKujUj6pz0RSFBO17Oj+gaZm5z4bLSXtz9GJRm1WQzTT+hwa2xhzkY+JLyrsNCLKqs2lG45dJ
 vyqglvYwG54UNscn4NGG+y0reQJC7mBjKM95L8ynhjFC8DC9WiJEDznYgmzwCPpyOd1ZqMLfgUe
 4wJ38FiaqFtV125zNTcdRUJ4YJoT1YoVHdtguEvbZa0cTKvgUDg4+kZLg0ejJMlh7XAPQOeTlGe
 vxQt3BNk5u4QJcyJma1e86hzisCkIfyFKaT/LQDMjU6qhVCrkZ6eHATwIWgx7yYfgUqv6sTge4F
 CvsxLGYSD5ZYAOZHZ5QuA6DLrXVVE0uIFV7+kjjGeAFfc=
X-Received: by 2002:a05:7022:ea8b:b0:191:a5b2:ef4a with SMTP id
 a92af1059eb24-1a6cf350f69mr6212734c88.28.1793293444673; 
 Thu, 29 Oct 2026 10:04:04 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8b:b0:191:a5b2:ef4a with SMTP id
 a92af1059eb24-1a6cf350f69mr6212694c88.28.1793293443753; 
 Thu, 29 Oct 2026 10:04:03 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1abea525ed3sm263427c88.16.2026.10.29.10.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:04:03 -0700 (PDT)
Message-ID: <84240548-b0bd-48ae-a8c2-b81bd7e02280@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:04:02 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/33] util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for
 string table lookups
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-3-philmd@oss.qualcomm.com>
 <d38a8380-9e17-4286-9b3b-a92020cb087f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d38a8380-9e17-4286-9b3b-a92020cb087f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX6bJafprKUxOo
 RiuR0XHEgTioQXXlMmcCsV7nQz9CufK3ZhUg/y9uTOznvEIh48BZ9RoL0mKzXNnaBHSUL0Hpvke
 VUiJ7f4pSpmBkLb0dHIsBndDaiiN/yM=
X-Proofpoint-ORIG-GUID: 6dWho8emL1mYtB05R2N8FdTOun3-_DHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX35KmLxELi2wL
 TPbxV8752IBWvRgJJStKzrKb/7pdYuXYzRNSZQBXkBoUpnIJv8MluRFmYNsBcD6IBc1juflT8W/
 bN88s0zWpmzxizBn2H61Cj1oAG0jMV711RK5YecYq9qxcqKJhzLvCJys3N9mszVka+K+NEtT8tQ
 D9wbzjU/zUANrKmnyMTbFysDPLDn7Us+xdJSo19O8Qp7jra3hf0SAoxulzr+uFltVswFdhuB3Qr
 qXWgIZIX5SyY8sqxiVsScSAP/MQegzNAHOWBAM9ls01068ntWMs13pL9fGvCROtt1UTYGOmD3Mr
 mmpFa157MQdFKVYRhtJcWBybq7I/7rfgTTNyDeLscNpoOupZa3ZFek90gq+E9bCUVf8yreQwm6W
 iCt89ROtZrEH9qEOr/4GjU/sQbE0KaPHiIlTsq8j9jJWJkRwdS1WnXavFdn4zjAMTJESbQejltY
 +ZRvgSbFBj/zsBIN5QQ==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae37c85 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=oPz6RXJ-ZawvsP2KAPsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6dWho8emL1mYtB05R2N8FdTOun3-_DHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 5:19 AM, Richard Henderson wrote:
> On 10/22/26 16:50, Philippe Mathieu-Daudé wrote:
>> Many functions map an enum or exception number to a name, either
>> with a switch statement or by indexing a string table after an
>> open-coded bounds check. Add STR_ARRAY_ELEM_OR_NULL(array, index),
>> which returns array[index], or NULL when index is out of bounds,
>> so such code can use a static table and a single call.
>>
>> The array is passed as 'const char *const *', so only arrays of
>> strings are accepted; hence the STR_ prefix rather than a generic
>> name.
>>
>> Misuse is caught at build time:
>> - pointer instead of array: "negative width in bit-field" error,
>>    plus -Wsizeof-pointer-div (GCC);
>> - array of non-strings (int[], char[][N], int *[]):
>>    -Wincompatible-pointer-types;
>> - array of non-const 'char *': -Wincompatible-pointer-types (GCC),
>>    -Wincompatible-pointer-types-discards-qualifiers (clang);
>> - pointer as index: -Wint-conversion.
>>
>> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   include/qemu/cutils.h | 17 +++++++++++++++++
>>   include/qemu/osdep.h  |  3 +++
>>   util/cutils.c         |  6 ++++++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
>> index d249f226766..ad4c778ea3a 100644
>> --- a/include/qemu/cutils.h
>> +++ b/include/qemu/cutils.h
>> @@ -19,6 +19,23 @@ const char *si_prefix(unsigned int exp10);
>>    */
>>   const char *iec_binary_prefix(unsigned int exp2);
>>   +const char *str_array_elem_or_null(const char *const *array,
>> +                                   size_t nelem, uint64_t index);
>> +
>> +/**
>> + * STR_ARRAY_ELEM_OR_NULL() - Return a string array element, or NULL if
>> + *                            out of bounds
>> + * @array: array of strings to index
>> + * @index: index of the element to return
>> + *
>> + * Return @array[@index] if @index is a valid index, otherwise return
>> + * NULL. @index is converted to uint64_t, so negative values of signed
>> + * types are out of bounds and also yield NULL. Useful to look up
>> entries
>> + * in enum-indexed string tables without a prior bounds check.
>> + */
>> +#define STR_ARRAY_ELEM_OR_NULL(array, index) \
>> +    str_array_elem_or_null(array, ARRAY_SIZE(array), index)
>> +
>>   /**
>>    * pstrcpy:
>>    * @buf: buffer to copy string into
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 5d5695ade28..50c7ce33b6a 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -532,6 +532,9 @@ void QEMU_ERROR("code path is reachable")
>>    * ARRAY_SIZE() - Return the number of elements of an array
>>    * @x: the array
>>    *
>> + * For bounds-checked lookups in arrays of strings, see
>> + * STR_ARRAY_ELEM_OR_NULL() in "qemu/cutils.h".
>> + *
>>    * Note: fails to build if @x is a pointer.
>>    */
>>   #ifndef ARRAY_SIZE
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 91ddadfd15a..d8a04ead5a4 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -954,6 +954,12 @@ const char *iec_binary_prefix(unsigned int exp2)
>>       return prefixes[exp2 / 10];
>>   }
>>   +const char *str_array_elem_or_null(const char *const *array,
>> +                                   size_t nelem, uint64_t index)
>> +{
>> +    return index >= nelem ? NULL : array[index];
>> +}
> Why is this trivial function out of line?
>

It ensures array is a string array, and not any other type.
_Generic could probably catch this also, with a more clunky syntax.

> Otherwise,
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~
> 


