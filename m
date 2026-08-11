Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C48FC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgKa-0003hr-Oa; Tue, 11 Aug 2026 02:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgKU-0003hW-2Y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:51:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgKS-0006ZB-Mp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:51:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMptMB2995763
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nW0xE3B4HxAwmjzOskOD3KAB6NxqsxKT9NRBRZwTy4M=; b=R1LNWHKdLU2gGQ/T
 nW2SMnNc6FbB6WhIEf+kTWN/BQl/BDvs1kico4J+7/+6fbeXY1uIEp5sRs1z76tK
 +s3TO7gE8PDv4TeWjTuMUUTztt340sHqne4RcSnjfMWxvJKauretLbldd8wG+8hF
 wLWw4fJmOffCg0I0O0Oe0cgTI8mXSwYLo0LhnhpMHzTHfDrLtAx6szvpKaWhFxAC
 IJoDBU3pxt5BGgWJ5onW7k5wE9I32M59DasaURnozE7X7F88gMKE6XQ86lxyucJL
 Ai0FG4ziq6PgfDvOHIHx14rRw/AF/OFgTF2KVLZhnGEHMmPqvd5PraKqOCNqnpLm
 sH325w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf2pg8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:51:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso46913971cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786431074; x=1787035874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nW0xE3B4HxAwmjzOskOD3KAB6NxqsxKT9NRBRZwTy4M=;
 b=Nbp4NhISfz85Kaw6OHM1QyYAl0Hz6HTQYpLD2ZD3Usdwd5fzlrrU5de9MZ/6xHmHH3
 aEWxtYBwJd1WOej5xXNdiMC1fdP9mTZbJzXGLW5vXC7dRUFPZN5Sh037bWUYDBTfECPc
 YIAVvpWN+oSELnfGCfpdo8wzauq9tgEK7FJygp94d5kAvMCVfztRImBAbQ1x/BV1YBBq
 ZH9tZP2r2CR4qVj+XEoI5s/ADzW9zTDNZmwYkJbwswvM26LtAer0LMOMMe0gGKQ+rMOk
 bSd7h9BJGhOd/rHUj/HabtgNGGAoS7Z/TyVeW61Nj33OylM3iYtZpaRgvfry3T7hwQoq
 JnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786431074; x=1787035874;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nW0xE3B4HxAwmjzOskOD3KAB6NxqsxKT9NRBRZwTy4M=;
 b=eeF21CxF5rIH1jn6iwwqedTqZLbWhHHynuRUd86suLQ7wlziS6VNAmsR8BayHt94F9
 chZSFGFUZCTWI7CrSj8Twk/qmsR5cifL618o/DC04qM99yhdkQv7ucKUJiMcrAd0IgWf
 SfUFdVuaYUJ5NEku6rRxv1aQdan/nAqgZem6eJLDuHtJ3J8+Y6Pfa850DxCxroJCIMRJ
 lrFOZ4iOBJT1tlFJJ0rjItXqXAwl/jhNhlaAToTialXc1CReu7Tuw/DOcEeL3Ejn0+7U
 M4vEoV93b3Jk0GcPElSRxxxofObE//BCFvlW6CCIq6ClgfMNHm6YNmGf7NqfqH8ryzeq
 FB/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcHlm9Zi8QWvb1jJAedw4Q6b7XQQ1Ip+aC58T8Vi8P7ePawHQe8iN9E6IxlU+hxek8ATdLrkTU7qyO@nongnu.org
X-Gm-Message-State: AOJu0YzaR1wpUixyGZz+MkLOyHNOtSTW+M/v9YiygZ5ujtb254rCfW0n
 7Dl2X1wfQ9ZlKhBMGYGEWDm4Tz6i+31UTCtEduxSJsnnkrEwZ8QkCbrUBbC6s9X6kmtxhbz3DSM
 +lZ68hOBnh2OSGScg1lzJ0HCibBuFMTCRQJhIYVSICkaOnbzm2xCsnInYrA==
X-Gm-Gg: AR+sD10PcLP7qpddCa7dXgCgHxWW9m3DR4u4vAsfdf5t4zFvx4LcENBhWngL1NXnKqm
 Go/3d+ax/wgjiAw2kOiJuLXDSq344CmBLN6LPJ1gNW4EvQs4LDEqIOUhH5M2MldAdRO99XsIE8y
 I6GoUjd7fR+QVSH81HKXPpKqtO0wu5mWysFZkOQ8zwepFW5LoR8ouc2cKQ9CxhWkluDvJ/IstFO
 5k6/3U7UUpap3rlB+DZbxMEq8AVrdBTQ1S9foCSVPLWBP+V0YbWnf3L5aCDx2pl7BoGbpc+PPzN
 +v9M+nbg1f5Eoek7D0vkbFIHLCf5A7O+aITNbfGngAodv6C+kzbwBGrp7XSSUta+WhTdnYEkl0u
 gG9NXAySyJD3Z7IJVhpTSTEntS7BLH+13TS30ylPa
X-Received: by 2002:a05:622a:4cc7:b0:51c:1291:911c with SMTP id
 d75a77b69052e-52d584f683dmr9875211cf.14.1786431074579; 
 Mon, 10 Aug 2026 23:51:14 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc7:b0:51c:1291:911c with SMTP id
 d75a77b69052e-52d584f683dmr9875021cf.14.1786431074233; 
 Mon, 10 Aug 2026 23:51:14 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e57785sm20815655e9.2.2026.08.10.23.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:51:13 -0700 (PDT)
Message-ID: <a6b9953d-7438-41a4-a739-4ea0c93d5864@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] tcg: Add revbit{8,32,64} opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JBKfIcfZfoq4XW2kjLWDonevr_OzKmOG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NSBTYWx0ZWRfX8WPwPQ37QhOB
 OD4fw1Gsm2xqOWS+STcGJF6anqP5ORlZF5b6ub4TEOC0Q68HKpTm6yecaoEXzuyjb7akSvQXwd9
 d6CuVf3uAl6wKlvrZzTnaOvFmjqjEyM=
X-Proofpoint-GUID: JBKfIcfZfoq4XW2kjLWDonevr_OzKmOG
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7ac663 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NSBTYWx0ZWRfXzktOzANC4sHo
 /X45v3qVCbOh1hqVWXvd9Jw24mDADzyTUIs+vLg9H2tK5FjoIF6eZugM6cyKEzHIfkldzFRfCLN
 sXNwAtUCiZN4/i5Kbo+pi4g1/BAWCLGSdwaFX5cNIKQN9m1/WkCveHa+2CQxl6zDRe/aEGUTKDz
 U5+RpgAftVJFtJ/Hgx2P4Y6lhERX4AKn3/sRRINhRu/JMiBZylSmT4/FHd5bl8m8pKeZNh4w9RM
 RFtjc0T+1djOWy5lfPjzxC2PWcTRA/MwnJYS2mcMjdClmoQjZWrd7G0VoaS6Dp/RhKV0met+P4D
 I3Sc7G5mBqHa5aAhnLm9+jFu4RA6SYSRrT9UdQ8d96qtsA6kbDRKp6yg4mP/GGsG2mg2m6MVbpl
 LRtJDIW+zt8XL3x0U6fWx/5nwBTpqkJxg34zZ2u2MJQs91MxsRm7xxLrx5UN0nZIapuEc3B0nTl
 rWZOXZDUqbxEqUbdg4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/8/26 06:55, Richard Henderson wrote:
> Add the plumbing, but not yet implemented for any host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  3 ++
>   tcg/tcg-op.c                     | 66 +++++++++++++++++++++++++-------
>   tcg/tcg.c                        |  7 ++++
>   docs/devel/tcg-ops.rst           | 16 ++++++++
>   tcg/aarch64/tcg-target.c.inc     | 12 ++++++
>   tcg/loongarch64/tcg-target.c.inc | 12 ++++++
>   tcg/ppc64/tcg-target.c.inc       | 12 ++++++
>   tcg/riscv64/tcg-target.c.inc     | 12 ++++++
>   tcg/s390x/tcg-target.c.inc       | 12 ++++++
>   tcg/sparc64/tcg-target.c.inc     | 12 ++++++
>   tcg/tci/tcg-target.c.inc         | 12 ++++++
>   tcg/x86_64/tcg-target.c.inc      | 12 ++++++
>   12 files changed, 174 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

