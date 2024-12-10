Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA8DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 21:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL89y-0001yH-Vd; Tue, 10 Dec 2024 16:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tL89w-0001xp-Re
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:52:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tL89u-0000WQ-SW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:52:48 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BALchgc018822;
 Tue, 10 Dec 2024 21:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 laazpkf3Grxpi/lSmiAKpLAx7rv1EuKb8zCprSr4jmY=; b=WGDWXz1eGg3tS+2D
 qa7rnZBjKJGsSjoi9ObeSmzy3FkpTSH/1F3muHzSB+04pHDMvK44Kt+svSjVcE2V
 mLZSbl19m+Z8ipp9IajAGeOc/EpdIU5qnWCzyEmQSdT3awFX+AwYxDJPBQRF7Et4
 wbt8cE2eVn9F0fqDzMbDEEul9qFpgDsB1yIlEbKLbSGy7K1gymWR4cLYYmOg9qFm
 CLF6GdsvEbllY86VwcKml+kd/0QEr4Ad9WYtXaKKdaHSG1DkuGr6gmwp3/YdFbMl
 kgqDwU9k+6qVqoSgq9qW8kvbj36z6pnUnvZVN3rVQvJMP3am5FeKazNYlegZ1awm
 2emAiA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eak3bcbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 21:52:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BALqb3d032485
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 21:52:37 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 13:52:35 -0800
Message-ID: <45efac33-d493-4aca-8d89-1f987167e1ab@quicinc.com>
Date: Tue, 10 Dec 2024 15:52:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] target/hexagon: Remove internal_fmafx
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <mark.cave-ayland@ilande.co.uk>, Brian Cain
 <brian.cain@oss.qualcomm.com>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-13-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: KeALJXVKaDw5ILRnRfWS5VbTvv-qknaA
X-Proofpoint-GUID: KeALJXVKaDw5ILRnRfWS5VbTvv-qknaA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=913 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100156
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 12/8/2024 4:48 PM, Richard Henderson wrote:
> The function is now unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/fma_emu.h |   2 -
>   target/hexagon/fma_emu.c | 171 ---------------------------------------
>   2 files changed, 173 deletions(-)
>
> diff --git a/target/hexagon/fma_emu.h b/target/hexagon/fma_emu.h
> index ad5df5d038..fed054b609 100644
> --- a/target/hexagon/fma_emu.h
> +++ b/target/hexagon/fma_emu.h
> @@ -30,8 +30,6 @@ static inline uint32_t float32_getexp_raw(float32 f32)
>   }
>   int32_t float32_getexp(float32 f32);
>   float32 infinite_float32(uint8_t sign);
> -float32 internal_fmafx(float32 a, float32 b, float32 c,
> -                       int scale, float_status *fp_status);
>   float64 internal_mpyhh(float64 a, float64 b,
>                          unsigned long long int accumulated,
>                          float_status *fp_status);
> diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
> index 35971b8b99..0c7c7f636c 100644
> --- a/target/hexagon/fma_emu.c
> +++ b/target/hexagon/fma_emu.c
> @@ -90,21 +90,6 @@ int32_t float64_getexp(float64 f64)
>       return -1;
>   }
>   
> -static uint64_t float32_getmant(float32 f32)
> -{
> -    Float a = { .i = f32 };
> -    if (float32_is_normal(f32)) {
> -        return a.mant | 1ULL << 23;
> -    }
> -    if (float32_is_zero(f32)) {
> -        return 0;
> -    }
> -    if (float32_is_denormal(f32)) {
> -        return a.mant;
> -    }
> -    return ~0ULL;
> -}
> -
>   int32_t float32_getexp(float32 f32)
>   {
>       Float a = { .i = f32 };
> @@ -369,25 +354,6 @@ float32 infinite_float32(uint8_t sign)
>   }
>   
>   /* Return a maximum finite value with the requested sign */
> -static float32 maxfinite_float32(uint8_t sign)
> -{
> -    if (sign) {
> -        return make_float32(SF_MINUS_MAXF);
> -    } else {
> -        return make_float32(SF_MAXF);
> -    }
> -}
> -
> -/* Return a zero value with requested sign */
> -static float32 zero_float32(uint8_t sign)
> -{
> -    if (sign) {
> -        return make_float32(0x80000000);
> -    } else {
> -        return float32_zero;
> -    }
> -}
> -
>   #define GEN_XF_ROUND(SUFFIX, MANTBITS, INF_EXP, INTERNAL_TYPE) \
>   static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
>   { \
> @@ -517,143 +483,6 @@ static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
>   }
>   
>   GEN_XF_ROUND(float64, DF_MANTBITS, DF_INF_EXP, Double)
> -GEN_XF_ROUND(float32, SF_MANTBITS, SF_INF_EXP, Float)
> -
> -static bool is_inf_prod(float64 a, float64 b)
> -{
> -    return ((float64_is_infinity(a) && float64_is_infinity(b)) ||
> -            (float64_is_infinity(a) && is_finite(b) && (!float64_is_zero(b))) ||
> -            (float64_is_infinity(b) && is_finite(a) && (!float64_is_zero(a))));
> -}
> -
> -static float64 special_fma(float64 a, float64 b, float64 c,
> -                           float_status *fp_status)
> -{
> -    float64 ret = make_float64(0);
> -
> -    /*
> -     * If A multiplied by B is an exact infinity and C is also an infinity
> -     * but with the opposite sign, FMA returns NaN and raises invalid.
> -     */
> -    uint8_t a_sign = float64_is_neg(a);
> -    uint8_t b_sign = float64_is_neg(b);
> -    uint8_t c_sign = float64_is_neg(c);
> -    if (is_inf_prod(a, b) && float64_is_infinity(c)) {
> -        if ((a_sign ^ b_sign) != c_sign) {
> -            ret = make_float64(DF_NAN);
> -            float_raise(float_flag_invalid, fp_status);
> -            return ret;
> -        }
> -    }
> -    if ((float64_is_infinity(a) && float64_is_zero(b)) ||
> -        (float64_is_zero(a) && float64_is_infinity(b))) {
> -        ret = make_float64(DF_NAN);
> -        float_raise(float_flag_invalid, fp_status);
> -        return ret;
> -    }
> -    /*
> -     * If none of the above checks are true and C is a NaN,
> -     * a NaN shall be returned
> -     * If A or B are NaN, a NAN shall be returned.
> -     */
> -    if (float64_is_any_nan(a) ||
> -        float64_is_any_nan(b) ||
> -        float64_is_any_nan(c)) {
> -        if (float64_is_any_nan(a) && (fGETBIT(51, a) == 0)) {
> -            float_raise(float_flag_invalid, fp_status);
> -        }
> -        if (float64_is_any_nan(b) && (fGETBIT(51, b) == 0)) {
> -            float_raise(float_flag_invalid, fp_status);
> -        }
> -        if (float64_is_any_nan(c) && (fGETBIT(51, c) == 0)) {
> -            float_raise(float_flag_invalid, fp_status);
> -        }
> -        ret = make_float64(DF_NAN);
> -        return ret;
> -    }
> -    /*
> -     * We have checked for adding opposite-signed infinities.
> -     * Other infinities return infinity with the correct sign
> -     */
> -    if (float64_is_infinity(c)) {
> -        ret = infinite_float64(c_sign);
> -        return ret;
> -    }
> -    if (float64_is_infinity(a) || float64_is_infinity(b)) {
> -        ret = infinite_float64(a_sign ^ b_sign);
> -        return ret;
> -    }
> -    g_assert_not_reached();
> -}
> -
> -static float32 special_fmaf(float32 a, float32 b, float32 c,
> -                            float_status *fp_status)
> -{
> -    float64 aa, bb, cc;
> -    aa = float32_to_float64(a, fp_status);
> -    bb = float32_to_float64(b, fp_status);
> -    cc = float32_to_float64(c, fp_status);
> -    return float64_to_float32(special_fma(aa, bb, cc, fp_status), fp_status);
> -}
> -
> -float32 internal_fmafx(float32 a, float32 b, float32 c, int scale,
> -                       float_status *fp_status)
> -{
> -    Accum prod;
> -    Accum acc;
> -    Accum result;
> -    accum_init(&prod);
> -    accum_init(&acc);
> -    accum_init(&result);
> -
> -    uint8_t a_sign = float32_is_neg(a);
> -    uint8_t b_sign = float32_is_neg(b);
> -    uint8_t c_sign = float32_is_neg(c);
> -    if (float32_is_infinity(a) ||
> -        float32_is_infinity(b) ||
> -        float32_is_infinity(c)) {
> -        return special_fmaf(a, b, c, fp_status);
> -    }
> -    if (float32_is_any_nan(a) ||
> -        float32_is_any_nan(b) ||
> -        float32_is_any_nan(c)) {
> -        return special_fmaf(a, b, c, fp_status);
> -    }
> -    if ((scale == 0) && (float32_is_zero(a) || float32_is_zero(b))) {
> -        float32 tmp = float32_mul(a, b, fp_status);
> -        tmp = float32_add(tmp, c, fp_status);
> -        return tmp;
> -    }
> -
> -    /* (a * 2**b) * (c * 2**d) == a*c * 2**(b+d) */
> -    prod.mant = int128_mul_6464(float32_getmant(a), float32_getmant(b));
> -
> -    /*
> -     * Note: extracting the mantissa into an int is multiplying by
> -     * 2**23, so adjust here
> -     */
> -    prod.exp = float32_getexp(a) + float32_getexp(b) - SF_BIAS - 23;
> -    prod.sign = a_sign ^ b_sign;
> -    if (float32_is_zero(a) || float32_is_zero(b)) {
> -        prod.exp = -2 * WAY_BIG_EXP;
> -    }
> -    if ((scale > 0) && float32_is_denormal(c)) {
> -        acc.mant = int128_mul_6464(0, 0);
> -        acc.exp = -WAY_BIG_EXP;
> -        acc.sign = c_sign;
> -        acc.sticky = 1;
> -        result = accum_add(prod, acc);
> -    } else if (!float32_is_zero(c)) {
> -        acc.mant = int128_mul_6464(float32_getmant(c), 1);
> -        acc.exp = float32_getexp(c);
> -        acc.sign = c_sign;
> -        result = accum_add(prod, acc);
> -    } else {
> -        result = prod;
> -    }
> -    result.exp += scale;
> -    return accum_round_float32(result, fp_status);
> -}
>   
>   float64 internal_mpyhh(float64 a, float64 b,
>                         unsigned long long int accumulated,


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


