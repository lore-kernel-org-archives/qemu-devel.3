Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8B3C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLl4-0004Wv-7S; Thu, 30 Jul 2026 04:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpLl1-0004WZ-GF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:04:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpLkz-0007kK-Vl
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:04:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U7xedb354067
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 08:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IxO3Az/7UzgpLeO7MiA2Em00j3vlS2IoyTExgaeDHho=; b=lu5HbBJskU7XV4Dt
 tY34s8XrIocq9J51pRTGcAZQ/jvK/S5RHkIB8wIEY3xeULLULvn7f020qG87+F8X
 ORMjeah2BjBXDZnK8So0e64viSKJeJ8JQjM09PBy7d/IdiZXI+AHzKuRaIuCZMgY
 IHycnvlmXMd1lnGPgD0Gw4eKApfZiDafHclRIEuqyafFRpRLH4jpuQbKn/suohl4
 FFJ3+20D8CoMrw5kj+3FIhNNGFpJrYJaS+goL7IjPVG8gdMVX26ceRzLvj98bVja
 ZFc88m4znk6lDC4uoUwtG+SfUfL1ef4fabk3efmCube9eJyYbPjZbylxUbpfvJE2
 reZQpQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr2q6g0qc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 08:04:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so38188001cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785398681; x=1786003481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IxO3Az/7UzgpLeO7MiA2Em00j3vlS2IoyTExgaeDHho=;
 b=Rc5/cOGpIkpm4324VnUWqbjBG+x0rtyYHCKr9VS2PtPv+gKpzPo+GbJv3Sryi9dV0j
 4VPhjrfVUKRX/mTHx3vG0XQR7MLxg4W8EbFhLwnl1cT61/NvkAriP6PDJbIvcUd/vIeR
 6HJg9x+Amt3xNuAmubSErkH+AOIVY5SVlI9NakogGtnnU0gEeASSxkZoUvczVPke1Laa
 SKk+EXQEgVIPgtKiC0HvDnfUu7px6vXX7WSgHsS6kAo/MxwQExY5dpujAo1S3DjWBWCU
 SkmagML6focGBIOFuQ+PtuiWGw4lNeg8O4z1xzqadRN0uKgkMOHRdcexKZNk4XPDz7wr
 Hd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785398681; x=1786003481;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IxO3Az/7UzgpLeO7MiA2Em00j3vlS2IoyTExgaeDHho=;
 b=SP62dkLXKjXmmrRt4vYhGLdPUeEvZeurvgLgzGCwYujUX/8L4pYMzUetq7eVuu5Xcb
 s3A/xyNK+BSWwmk4O9GiLjbaVQIXXRqvrytBU+aHaPi3Bccq0K5OWXun6SGdss/vzeSy
 XYQBFetmIlJpvlFY4BZjAuafuPdjuqD6itBZPMfuNXYbw9PcskV8rWjl+LyxbLTmF21q
 8iIFNE7R6i2ORYauVyqbqiJtQMKTdKGZC8Vr0eT6Zw/ys+6TKvfpESX1ju0uew0MoFRF
 axZA1gP7LcNpFBtatIeY8jdGg8+WjBxLaTX6nyYMEeERd0qxufayE4xw6lVgDAphvuD0
 mo+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHy8qgkNSRd+28PXbORSK3lXHG+x6NsGoiHgNVBqT/N0ASXvJneW9FEeskVDsVQE1HdmQE+ZH9lPld@nongnu.org
X-Gm-Message-State: AOJu0YwkXJIIcqC1yhZXRb1qsYjEpJAlT3ASo24o8MUArKqEWbikrmNb
 m0trB7tBNdfgGArezwF/I1d/teqKmIkcej6q40a6diCy/D7drtW2siuw6hWLDy/ZnZR0U6PiMsq
 7U/z3fRd0qIjUoKgme5hfSmh1mdTISRS4JGHjsiw/pAingLOOObvMrtm37g==
X-Gm-Gg: AR+sD137BVZx5Fjk7Plk/GxixTy8ovsvuf9wQPbws+K5Ml+6yZ742z6n6WKYiI9NE9e
 BaubIpF3se5YhTyTswJqKwmGXdYhIyp4ZFya3cdpbFFqtWXlNFgsWTSDUdR4WYHFQh6sZuSfN4N
 VWU+LccirmT+/rrinnwLE8u+SB6/XU+vWSav+Z25xv5v8Ckrsi2Q8mhcxg9ml1JYZLgqRruJCmy
 Vob656gLn2b2DFQxSIca6tE82gh65yzo5UZIgqpkGtZHD30hcxCJk10hxl3DYH7WFz8bWp7jS5z
 N+Vt3ZS5N1zcO8B2wBrHaxKrFwT5cqJ7Y5UZw4zyB/LoynO0iMpB3yMTvdzEVyPs5/FeOADkEQs
 ibcQCT9PslFodyD2xiekTBU9XP9LDjbYFrtc2TMeemEtMF0tTb/o=
X-Received: by 2002:ac8:5955:0:b0:517:875a:d634 with SMTP id
 d75a77b69052e-52b383878d2mr16956721cf.2.1785398681171; 
 Thu, 30 Jul 2026 01:04:41 -0700 (PDT)
X-Received: by 2002:ac8:5955:0:b0:517:875a:d634 with SMTP id
 d75a77b69052e-52b383878d2mr16956501cf.2.1785398680640; 
 Thu, 30 Jul 2026 01:04:40 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011e5edesm40004405e9.2.2026.07.30.01.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 01:04:39 -0700 (PDT)
Message-ID: <99f0096b-8183-439d-863a-b40a4986a103@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 10:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/50] accel/tcg: Add bitreverse and funnel-shift
 runtime helper functions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-2-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260730031025.12926-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1NiBTYWx0ZWRfX9DHHWXYmdk1J
 xS0GDiA6tK4LxqFNIc3g/BXRLm9yOjOPYFF9d+zFF7k5mRcdhNhdXKL2YZ0LdeX2lbiQAmEEesc
 G5DDXOAyYtS8hlsjKfnAhiaNpQc1v3kkBpGHPZRe3v1JE7qg1ipW3BTMEC5v4igU50JRPkQAj16
 TQXIa8tnM8aAq0fTzs2Qd++XDJPJmKEWRdUUMM5wDwG4mULkYM0ObAAHfKqTn+ugXe+JqywXsNY
 EB3UWCVYimtQXE1JE9YnyEPvqdnElvnOF8FAPHOkyCA1i5ZwTY7TYpTqMyuZIM+Pzij/7Lmdizh
 0L7sIi9GTNLeeHKgkfrEtJizk+2ldM/qBiPAWZaKPvNcH4uZBwL1E+M2loFldy4dsheJjteKZpf
 HJG1ztNbNCiJETMBNVHCYqrV8W3u4LS8kXS4litkpj1/LZcNcLem8AQcyHmDm8vvjs99mq0hgYp
 RnMxDp+yeezuutBjMFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1NiBTYWx0ZWRfX3i1YtJ2wCpuM
 HOhGbH5D53dIodr2S9vPNNMRWlyBPSBQ0WaKE419mHmfpIvY29vwIuArRhPfUwNnMoRbwdBil9J
 KhZbiVApdJkr4evRAMLUb8ftfLYpJpc=
X-Authority-Analysis: v=2.4 cv=KYTidwYD c=1 sm=1 tr=0 ts=6a6b0599 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=3BIpWbpnriZcojft0aAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: OdVuisUTrZw3Bzio41tZ5zysR0ogrklC
X-Proofpoint-ORIG-GUID: OdVuisUTrZw3Bzio41tZ5zysR0ogrklC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300056
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

On 30/7/26 05:09, Anton Johansson via qemu development wrote:
> Adds necessary helper functions for mapping LLVM IR onto TCG.
> Specifically, helpers corresponding to the bitreverse and funnel-shift
> intrinsics in LLVM.
> 
> Note: these may be converted to more efficient implementations in the
> future, but for the time being it allows helper-to-tcg to support a
> wider subset of LLVM IR.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> --
> TODO: `tcg_gen_*()` variants will be added in the next version, it
> slipped through (Richard).
> ---
>   accel/tcg/tcg-runtime.c | 28 ++++++++++++++++++++++++++++
>   accel/tcg/tcg-runtime.h |  6 ++++++
>   2 files changed, 34 insertions(+)


> +uint32_t HELPER(bitreverse8_i32)(uint32_t x)
> +{
> +  return revbit8((uint8_t) x);
> +}
> +
> +uint32_t HELPER(bitreverse16_i32)(uint32_t x)
> +{
> +  return revbit16((uint16_t) x);
> +}
> +
> +uint32_t HELPER(bitreverse32_i32)(uint32_t x)
> +{
> +  return revbit32(x);
> +}

Please split in 2 patches, adding bitreverse family in
one, and fshl_i64 in another.

For bitreverse:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>   /* 64-bit helpers */
>   
> +uint64_t HELPER(fshl_i64)(uint64_t a, uint64_t b, uint64_t c)

Please use clearer hi/lo/sh/val/ret instead of a/b/c/d/shift:

   HELPER(fshl_i64)(uint64_t hi, uint64_t lo, uint64_t sh)

> +{
> +    Int128 d = int128_make128(b, a);
> +    Int128 shift = int128_lshift(d, c);
> +    return int128_gethi(shift);
> +}

