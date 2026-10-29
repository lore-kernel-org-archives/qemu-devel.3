Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F44606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OyNhQVRN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BP/fZZum
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYTJ-000464-H1; Thu, 29 Oct 2026 18:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMYTF-00045N-SX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:19:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMYTD-0008T8-Kz
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:19:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLatZw2372758
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 22:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /cowfAW0TjtqUaoUpAvoslK1cQnMZxs/qkhmMh5wPTQ=; b=OyNhQVRNWy7hoekR
 w3Lva5jJIKq/ul6rfY0HhMqPQNqfInHZ4jNbb0lJxmS0T66KSYLJbJFgF0lPLmKh
 zStaHfvWD0nN9ypwejQ334GKP1eqpTDxz4ZZuHGSo1V13AflWePq/90Qwl02C56+
 GY2NaN8yfc9IBCwWN8683l/hQWxx57OSwhvLz2WMCOAa9kHvIhr9B2Hb7h6FsDt8
 3J5hBNsnZ2d7s3824EeAYvZIHf9elr9SnOO6DDk9q8dM4Y+JsHBLqVfpHwegyA4q
 5uxarQR7U+Ye0YDzWxqj/8FWTlpe1ApS3safp6Mktyy72uFzsnK9tsS52fHKfs4F
 w8tYTQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme7504ke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 22:19:36 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-147be78cd56so201037c88.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793312376; x=1793917176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/cowfAW0TjtqUaoUpAvoslK1cQnMZxs/qkhmMh5wPTQ=;
 b=BP/fZZumVTT8dpyGF4iuOWOjkgxXF/HI5MkEeE1gQMX3RT2s7hqY+ElUcQrTXoSQ+i
 HiZisvWB0FjvoQE8KrKY6fZbRT4kGS1MOKgcj9fRXjs68EjBWr/DGlj/ndLzJEzZUIeB
 Z+5LLR/bautUfmFHDUr9zdbAoJXaVDC5CBWyMyaYXcAAq+w86AnH3Qp/F1eq4p4Hu0K/
 b401mjKbqReUiRGJo+kelvNaxxWy9qfcL4yAxRVdFzHFbxwiFpsiFLI6vkr4DrE9LJln
 CjSnl2tYNFJwwjBeQMvfiQsXjVjaEhFhxlib327IdCeQJGkr347NEBgV9j/OtLMAh+yu
 T3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312376; x=1793917176;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/cowfAW0TjtqUaoUpAvoslK1cQnMZxs/qkhmMh5wPTQ=;
 b=yBmmgyXpvSiyS/ga4WIzTIHPnQCrwNHnERZvblFJR7IwBUYcqj3DJ6GKmjJvipJX/+
 WYuFLwASdPSETGCkFLhgKU+aXCOU6uoSeB3zZR34fyKY06SrXR/v3c6XFgsEiPh5D5Fk
 JDWtnbQ+/tiRg2ekaRh5OD2YNOCmoIR9CShlu8L1uPMgXQYK33Mg9bppebpnp5vJ2stH
 +xrNHLZQXU59lzOPfJdfqHnflzGDg03S6xp96DomIz/kk/6CidYSLrV2//WREh8iAAcl
 1anMKQSsb4ewz1h6Z/ayeQJuo6puf4Lj7v2c+2gS5dlalkbQdHCBgFwl+2Zl6F1oZUTK
 UmYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzShGP7t1pwafpEJGCsvtfoYwOAeSGgHvbAKpBv0WXPRZnYlm7NQsXy0Hq9sm2OfTZ7iuuA8zpwffFq@nongnu.org
X-Gm-Message-State: AFq9FYLFeoP1GwusFW3a555XaPDKDe/EM6K78na+EeLyonJb5GiFXKwa
 HU6MIjScRXb8sZXtuQAjrGAh9nNHeR9F6i4//oW4UrUaW03KV/15CIB7Y+NAS5RtnP4k4WiQK5D
 hGL7Bc1ODFpwJzJUn2Bdp3PBxXZYKU/IXyla1VUttmaGABhyl0CuGCMlbGA==
X-Gm-Gg: AYBFou25ak13BztQREqmmzNNrsYwbBinLDZoCn55TF+r6TDclnMpS3Dnc4d5cq/L7CT
 BqKPVxo2/4zk9PkMTQOtfVp69b3J3Cnj0BSHxbqqghGZVv5jxA59iDr0eoO8uSAqEmAc5HsS3tf
 jlidaFVLBn/CSFXa/WKYSJeLO0aq3DhR2Ji88zhLy++gyZRpd6TgyumvT8x9IPsoyqnppnZAgBl
 Ufq8vQg2rR7ZiNXfKgnkBjCCJK0DvCrDgOFi2Kc+Stj3kJSqXozKS09HJG8CrnTeOCnlj90VkyT
 RQKy1YjjbrEOlxffzsPgZTl4BUxOnXOCphsWNHJLe4eGNatLVqvv1q2SVFoSSZkzSZbPdGJWa7Q
 xYl7eg/3yBl+DD+tF7v3xXeBCsAscRnwIrWM3Peg5BYOLdezl4X9rn+KFeUSI+LXoyzfvai1HZ3
 5DGo6D8pqtS/bhiWfuvhYKTxtuDTn55bJkKhP9vWjUWqY=
X-Received: by 2002:a05:7022:f409:b0:143:26eb:18e9 with SMTP id
 a92af1059eb24-1ac5d5aae14mr654311c88.28.1793312375987; 
 Thu, 29 Oct 2026 15:19:35 -0700 (PDT)
X-Received: by 2002:a05:7022:f409:b0:143:26eb:18e9 with SMTP id
 a92af1059eb24-1ac5d5aae14mr654282c88.28.1793312375354; 
 Thu, 29 Oct 2026 15:19:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1d4dsm1530978c88.3.2026.10.29.15.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 15:19:34 -0700 (PDT)
Message-ID: <237bc517-6436-4d44-ae34-220fb7659222@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:19:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/33] util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for
 string table lookups
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-3-philmd@oss.qualcomm.com>
 <d38a8380-9e17-4286-9b3b-a92020cb087f@linaro.org>
 <84240548-b0bd-48ae-a8c2-b81bd7e02280@oss.qualcomm.com>
 <8c769188-14f9-494e-afc9-fe3087dc7baf@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8c769188-14f9-494e-afc9-fe3087dc7baf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F1MvRUS5lLoLR4IDk1ax0sqSLMRu-4ey
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX/98CdZbxZdjz
 2YZT0HB/cxezqNmhAUc6bF6sFWaj0hY306EyVnQfRL0aabG0YXkdRB2KNqX2ia+GeJ3Lu0lHPDw
 3SNsHx1jiBCsEQJAUEHffUpzkYC0L5x3srnnxXGZHy/6UW2SqJhJHjvMbG+7wjjDGToDCvA+BzZ
 Voha3rXuwuv0mNIjfxMLE36jLDwjXUd8vXEfKDiBVLO1Ukie3/vLPTweotUrctDaaGfXFxSfig7
 TpIvad3Rp2h0OECFiVZAfcYe3TTe85Dl1gyS+31rW7swmQ4IK06tw6Jk/dDZkxBW6makU0ysTzm
 T+09BTdT2fjnQUEkOb0OJQ0puro76UWB8oSdFanVT+/sNWxnl6xC/u7BRAUhAVTSaHeXJevSsgE
 9dKtx0WZxtHxz9TswH5IMZldVzJOso9bIMnR+tPlcLDOlXzwvjcQrxe0hLoDhfWbzGwv61TpDRY
 C2br4V0z2h4y+soeivw==
X-Proofpoint-ORIG-GUID: F1MvRUS5lLoLR4IDk1ax0sqSLMRu-4ey
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX1h7m+/ahq7Ws
 zXjJHMZRrKpFZhkSkvESD9b2jLw51VT6F5nniUES+5SBNA9yN2PEQJ3w6F7QXkDCpepKv31v9Vr
 GiyE8Zd8IS5+VYEcx7v3QFriV203pd8=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae3c678 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aqkcsIkdNuZtsdR1u4cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290088
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 2:12 PM, Richard Henderson wrote:
> On 10/29/26 12:04, Pierrick Bouvier wrote:
>>>>    +const char *str_array_elem_or_null(const char *const *array,
>>>> +                                   size_t nelem, uint64_t index)
>>>> +{
>>>> +    return index >= nelem ? NULL : array[index];
>>>> +}
>>> Why is this trivial function out of line?
>>>
>>
>> It ensures array is a string array, and not any other type.
>> _Generic could probably catch this also, with a more clunky syntax.
> You can get the same thing from a static inline, is my point.
>

It was my initial suggestion:
https://lore.kernel.org/qemu-devel/5e3635d5-1bd2-46b2-9f7d-78001159038c@oss.qualcomm.com/

I guessed Philippe preferred it to be an extern function, I don't mind
either way. Can be a static inline for perf.

> 
> r~


