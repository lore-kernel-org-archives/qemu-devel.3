Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B252CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB9mc-0003ht-3A; Mon, 28 Sep 2026 07:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB9mb-0003hl-En
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:44:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB9mW-00035f-Ex
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:44:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBA9gZ1433709
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QB64X2E2SS0Iwoi1vv14nkxlr4iWhgT9EQIn3Jy78Lk=; b=Dz1wmfHOy/6FlKmo
 AG256Q/zevXP7H8xLLg2ILtq24O4Aq3fQyhpnsmy/Uy0X3I078Spqxq+fSE1IQkw
 3e/0MwjNqquMZlmWcSCHMgH25glHLUjMRalqE8FOmBmzCPZR6IcwkRglUxvT2w5q
 5BIxf5zzovPUEfUndCocCSlmO1a85OeTzWrCI+kXNVy4nXeXX/SXayZMSnhIg0bK
 qUldpgagqWGaykShflwozf4a+RhjffY85ogESmpddLQIyRiKwFNDAON5MRaGb+d4
 yflMugOVqlIVU3Fjxpo0YWRqfy4dTH2fT81galHl2f+ELVcE2EqAGq8KZFdrkb/P
 zxGT0A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s1bh0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:44:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-532dc3793easo69920361cf.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790595866; x=1791200666; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QB64X2E2SS0Iwoi1vv14nkxlr4iWhgT9EQIn3Jy78Lk=;
 b=FkbjX+0MQMkK2XoDPbvzYFbTra4lpe8u/2VvDwG192aJdfD5FWZLtlRN3C25mLrs8O
 y8y0TX/vEMLjXQkIsZdYv9wdyBqfnk5qZ724fVo5Hm49XVA6m5ZD2RFqD/qVoSay1nrf
 TUCzVPk9nCwy6WJzoKxFvK98j16i3yFaTOZnBVGUoIVUux6OqLtogBB/wSCi3mXOgqPC
 p8NeoBMGSwslt5XQv3U8xaPLtIoyl+xR0fMOA7kv5giAAZW8vkFJKk81qlRvemg0Z8Qe
 hJiqvEi33Zi/DGFYe85IiMt0q0zAe8vyd1j9Zwj3CPbCajJ6jAUWEZpO5PdDGs90n40v
 TSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790595866; x=1791200666;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QB64X2E2SS0Iwoi1vv14nkxlr4iWhgT9EQIn3Jy78Lk=;
 b=iKwbOa34RODH0XNjvZx6LG45eQ8zUahT1d91xtqm4xv7g0kpstSDA4DvjPJPS6F5OK
 hVyGP7qh3xnnNsyoc2aDTw4HzaN4qL7tkNhwR0MtYieL/WdEW7P5FcQ3ZoJgpAgvcSGW
 dfpQ5kDxipR7OGGk4+nhH8UBEDN8Vspp4zrqxooU/cRk0PlBkjgHA1pbaH62bvyDR92N
 J56bz9ljMSmxV6z2REeBV9ktCiDQTnvS9hIOTxgysEag51R1AVBdCEbDeakNXbVw+qp6
 vuEPIpcJzcevmQteW0/ztf7oAFz96GBMr2Rfs+pYSQZTU/D2RV8UbTRJGjhY1DtY4oUu
 nV4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6hSqrDNzkE1mmZnvYpBHwRHKkU4ji1uwvHO6KA7n/EtUCrP3lxtn+QvCVD4ByITH8tceGdgkgMcwu@nongnu.org
X-Gm-Message-State: AFuF++k18v1ooY968GOxNlXJ/5zyrkBiYvrPBytYce3nEwVDs5obMO6u
 +JXKwDDdPOaZk0m27xDvk2N2VYNOjuW5OAOL0XxfTStAn2K/sOmGF8ziiLBTuMd1JLcnUe+w2WH
 6LPkb9ueYm+b9tknlqPihdrYJQFOBBXnFZsrUiHWISm4OPJ5gLj96mC2jfw==
X-Gm-Gg: AYBFou0/WmnQJsYp2xmUbyvklQmHW4Be4UsBT32YrE8vL+amgNxTdiqxm439Sax98Jq
 gGd2NYjUdN+sADnHBuldwi/PD0H0CXlYwUyu0Xq9/y7Zw1hTp/xzmPCPxU1FO4Zx1t1b730K1R0
 lkLikEpcfCr+EfjYaGnY+N2ta0uyluXp5NKPH6smEG/CktL6p0m25lL2gX3452MaOP2+6l6zOvX
 Ofcuv2geUvfHJA3XFYdM+/9+yauDliNWnlqQS5ATSyFliyq0QPIR8AfIyDPPmUfG96gREaQ9B/+
 Tde4vA2/tosASFbLfexFMWOkp4bWa8bvxEC651AA99RpGEDSbXuXRPb5+SVkr7SiuqpSeWapkav
 yEr6jyUQ3cclYOSwLpM2agDUsnz6tdb6gTg==
X-Received: by 2002:a05:620a:4494:b0:939:fcf1:5c27 with SMTP id
 af79cd13be357-93c43c1d4cfmr1840227985a.8.1790595865614; 
 Mon, 28 Sep 2026 04:44:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4494:b0:939:fcf1:5c27 with SMTP id
 af79cd13be357-93c43c1d4cfmr1840225385a.8.1790595865171; 
 Mon, 28 Sep 2026 04:44:25 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0056e2044sm36922515e9.3.2026.09.28.04.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 04:44:24 -0700 (PDT)
Message-ID: <5a65e8cb-b934-4d66-9317-32ccd711a78e@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 13:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 025/101] tcg: Generic expansion of tcg_gen_shli_*
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-26-richard.henderson@linaro.org>
 <47e7e33d-4d44-4fb4-b5f8-272e1e5ab04f@oss.qualcomm.com>
In-Reply-To: <47e7e33d-4d44-4fb4-b5f8-272e1e5ab04f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX8uYCy6/aWjRJ
 PAGermgBbKrrAt3ClDA0XEFF9fwnnQBotog1ITcmvwnAVX8GdPd8b0yCjBCWHLOXc0eDEl2vLm8
 CeTNtvQeaw/jPPkUS0gOGRiRNjr8WM9TQ4H0UjamTm6VCsRiino4K0iRH0EYIc8J3mQZlpSkROZ
 O47IKQ1fyPgfAUh44cgo8zCoi4Ky93gYAxm10vim1OUPQLhB+Z5Rcip4rFz2ombPoy4MnZzMfCs
 rQXpJyrDHquH2iWcihJs8U4yrHkh4HEoxDLfhaYF22rS3HErxpCNAbHsBJh9vEw0/y7OE2sdodX
 M31l/K0DVX7NSf/OsaLZ3j3Epg5/Odn8WhRfP0IKVZ5Zr5HGLw8YE3nmYMCfhG24Et/fsP1j5wq
 QcF1kICnAs1KOT2a30T78T4fvkcPNcrmJkfkykf1DXRuaf6Fnf7gEOIB5s1TwUmWyicAdPIAvhl
 HP/+Pf16A4t+yZX+fNg==
X-Proofpoint-ORIG-GUID: 4juDjA4waTqCTmYi8DdW5Da4dWi8OcWm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX2a1ISomwNtHs
 7jw20hjPZnR3K6HX6/NXgVhzELPjI+rL1fEQJkqj78OxrJFQH59ebsdcCACq6tOtjePgDuKHI7W
 YjkH2JZZAM2t6tjEglmLBLDFwdsn0vo=
X-Proofpoint-GUID: 4juDjA4waTqCTmYi8DdW5Da4dWi8OcWm
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba531a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=wbhZ9lBzWcXqse4nRUEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280046
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 28/9/26 11:46, Philippe Mathieu-DaudÃ© wrote:
> On 27/9/26 10:58, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-op-common.h  |  2 --
>>   include/tcg/tcg-op-def.h.inc |  1 +
>>   tcg/tcg-op.c                 | 30 ++++++++++--------------------
>>   3 files changed, 11 insertions(+), 22 deletions(-)
> 
> 
>> +void tcg_gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t 
>> src2)
>> +{
>> +    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
> 
> Can we add a tcg_type_bits() helper?

https://lore.kernel.org/qemu-devel/20260928113938.3157-1-philmd@oss.qualcomm.com/


