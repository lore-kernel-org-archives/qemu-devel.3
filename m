Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B397AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 21:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL8By-00049G-O1; Tue, 10 Dec 2024 16:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tL8Bw-00048p-VW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:54:52 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tL8Bv-0000je-6o
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:54:52 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAEnAZa029986;
 Tue, 10 Dec 2024 21:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +jnhMrI/LvdR3U6cFV6IPvMbiHpa1S+ZGWgsNigef44=; b=i+CSCLK5RACmn2N3
 nKQmKZcrq7spU0kJ/C8DuxCnbGzz5oGleVUqUtIamY/mRq+YXPjh7AAHvD+uvu1P
 55JACTgl68Qy25KEpQEl99wQ1c7BJGJP7yecufVhq4y5tgUzenzfr5AEGsnzXYqF
 vMdyACRw411TpmVhQDcqKPYfqft3H5vDMrTEKFdQT5nR9445j1TXTFOkIiYO//XC
 TuuHKqmV9QeFhxH6x2qu4ss5ojQw6sq3slazeQ3e/2ZWtt4ySbpJ2eQCaB/w7lK0
 CC3Gor3BBt15yhFXboji0780JHh2zZdhiwcLEzmVc84IkrgUzFU55iY65NkxG9kK
 egzUdg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eqr313uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 21:54:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BALsg2o027402
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 21:54:42 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 13:54:41 -0800
Message-ID: <774bccb2-f8af-4671-bce7-543db9c4e473@quicinc.com>
Date: Tue, 10 Dec 2024 15:54:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] target/hexagon: Remove Double
To: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <mark.cave-ayland@ilande.co.uk>, Brian Cain
 <brian.cain@oss.qualcomm.com>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-16-richard.henderson@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241208224844.570491-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: t5gLDLIN89RzUJEoyAqU2ECVvMfB6YTx
X-Proofpoint-GUID: t5gLDLIN89RzUJEoyAqU2ECVvMfB6YTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=791
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100156
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
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
> This structure, with bitfields, is incorrect for big-endian.
> Use extract64 and deposit64 instead.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/fma_emu.c | 46 ++++++++++++++--------------------------
>   1 file changed, 16 insertions(+), 30 deletions(-)
>
> diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
> index c359eecffd..343c40a686 100644
> --- a/target/hexagon/fma_emu.c
> +++ b/target/hexagon/fma_emu.c
> @@ -43,39 +43,29 @@
>   
>   #define WAY_BIG_EXP 4096
>   
> -typedef union {
> -    double f;
> -    uint64_t i;
> -    struct {
> -        uint64_t mant:52;
> -        uint64_t exp:11;
> -        uint64_t sign:1;
> -    };
> -} Double;
> -
>   static uint64_t float64_getmant(float64 f64)
>   {
> -    Double a = { .i = f64 };
> +    uint64_t mant = extract64(f64, 0, 52);
>       if (float64_is_normal(f64)) {
> -        return a.mant | 1ULL << 52;
> +        return mant | 1ULL << 52;
>       }
>       if (float64_is_zero(f64)) {
>           return 0;
>       }
>       if (float64_is_denormal(f64)) {
> -        return a.mant;
> +        return mant;
>       }
>       return ~0ULL;
>   }
>   
>   int32_t float64_getexp(float64 f64)
>   {
> -    Double a = { .i = f64 };
> +    int exp = extract64(f64, 52, 11);
>       if (float64_is_normal(f64)) {
> -        return a.exp;
> +        return exp;
>       }
>       if (float64_is_denormal(f64)) {
> -        return a.exp + 1;
> +        return exp + 1;
>       }
>       return -1;
>   }
> @@ -346,6 +336,8 @@ float32 infinite_float32(uint8_t sign)
>   /* Return a maximum finite value with the requested sign */
>   static float64 accum_round_float64(Accum a, float_status * fp_status)
>   {
> +    uint64_t ret;
> +
>       if ((int128_gethi(a.mant) == 0) && (int128_getlo(a.mant) == 0)
>           && ((a.guard | a.round | a.sticky) == 0)) {
>           /* result zero */
> @@ -453,22 +445,16 @@ static float64 accum_round_float64(Accum a, float_status * fp_status)
>           }
>       }
>       /* Underflow? */
> -    if (int128_getlo(a.mant) & (1ULL << DF_MANTBITS)) {
> +    ret = int128_getlo(a.mant);
> +    if (ret & (1ULL << DF_MANTBITS)) {
>           /* Leading one means: No, we're normal. So, we should be done... */
> -        Double ret;
> -        ret.i = 0;
> -        ret.sign = a.sign;
> -        ret.exp = a.exp;
> -        ret.mant = int128_getlo(a.mant);
> -        return ret.i;
> +        ret = deposit64(ret, 52, 11, a.exp);
> +    } else {
> +        assert(a.exp == 1);
> +        ret = deposit64(ret, 52, 11, 0);
>       }
> -    assert(a.exp == 1);
> -    Double ret;
> -    ret.i = 0;
> -    ret.sign = a.sign;
> -    ret.exp = 0;
> -    ret.mant = int128_getlo(a.mant);
> -    return ret.i;
> +    ret = deposit64(ret, 63, 1, a.sign);
> +    return ret;
>   }
>   
>   float64 internal_mpyhh(float64 a, float64 b,
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

