Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D43606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YpKY6nqU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jeeFYxiC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVQq-0000rm-35; Mon, 09 Nov 2026 14:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVQn-0000qy-SV
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:53:29 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVQl-0003YU-1t
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:53:29 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9JlJgU1172302
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zuhZXa3YEjBQ0lGDqmRitdcnjeYDmHa6ZhKZeBX7ojY=; b=YpKY6nqUgNHDNZf0
 HHPBJ1oSZX0ewyriffzQbB+FPy6Zlvhxyx2faH5d+lurqtDfdggRLjIVeITeEWpB
 uk9kv27gENRhHNlAuQtT8t8an8Bjgn0qtINiC1ARumtnjcweT+W1Q7fr3yZVyJym
 fptie4ZN0X7QcdxlVUQC4hFZDJoMfTNFhN54CuRdx6KOrKpiR0X8TDMyVp7wBmnx
 vbvkYR6kT2PmE8UzBw0ozCJ2PqqJKtut+rz+24REb855ptCQg1eW6CYjVLb/wQS3
 y/hL0WpeqpTpZG4wR0dQ0eOgBIvkAS3jPV+XT8O3cwGZltYjy3QJDf9wyonF6JX9
 28pbsw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucapa16y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:53:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5363b06bcb2so27763501cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254003; x=1794858803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zuhZXa3YEjBQ0lGDqmRitdcnjeYDmHa6ZhKZeBX7ojY=;
 b=jeeFYxiCk9LdmXIyXN5XWGIQJ9Ag74inPn0tHy/RiA131rexhx/Db1DiFYILQBSc+B
 8l3ePa6s0ltLjfBg4pksh4Cc3fqmCMOODbjUE41rSOLvA5SrBsx4/7eZr/ruBI86w/xU
 Jb37jycEbIpnipv1P6cDdYpHPRsgKWgXrUuGOHfsxmjBBWUq9IlvxwZoM8u7v9AnmDQs
 mecv1T7Nspw0xrrWslzOo2ItaykMHejd6Saq1wqINjZWHpRSGlNteA7ITaMcdB/bAcKZ
 KOU45W3BjXwwvgI9ze7eHmKpKETpDxQ6VsNdPGkDtRVSXUKAtEUM2ehTF4X/jsu1Scar
 2DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254003; x=1794858803;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zuhZXa3YEjBQ0lGDqmRitdcnjeYDmHa6ZhKZeBX7ojY=;
 b=ZV09uGEYZlSgUvno0TjyXRpenAW9JP4iU6TZWbaX3eYJnWAuOmO2eujBHKfxqCnyUI
 wVXR3nELXI2e6hJmfI2+521b75vDeGZd8y3H1betAFijMHGGvNY4LAVzYs1tEVcYQHOo
 J1COYm17U3QKoDtBxuPCrtC7gGFiz3pfH7YzzzIx22jKju3H0qj8FZe/THsBIkSN6TTe
 JtBKNatLFbjo7Bt0PX+9EqK+p4PizFxj3dVTtgJeyhw72/T5jgRYHTJDNArdWque5udy
 hDDSjy2QYf9wlRsWwPEYGRDp2VY5LrouKJtG00kQyU5vt6QWfjJdAMWINdjY8faUIC4N
 LfKw==
X-Forwarded-Encrypted: i=1;
 AL+hErFlYe3mS2sz0Fii1h2zlr5UdCi80ymRccexGELDDuY4gkTmtX4jREkwewTy25ghnAIo+NvmDi0BNiiR@nongnu.org
X-Gm-Message-State: APuU4Z/SX5lutiwu2Ctrk64HrDVZZSmE6aFcMfCU3Ixgf+jAG+ZW6OOD
 3JgZlbz6xRnQRMUQ8viXe1Wf4uP/h4sL/aF/GjFATDh2U6Guvoak7JNDk9RGAg04TznNiq8RShC
 8w8JGrhI8j2MnercbLp8FKeD+6e9CVoJPeWVQ5uFVVxuR4pzZK6VjzI9D7A==
X-Gm-Gg: AYBFou23dNuJTf5OZBDXlpZ+SaL4QIO/MpX02NEdapNGC1bnvrHCatf4mg2ukhvfsrj
 KOHFT3V2y+H2OXz2M8CUeJ5wXcqcQXbJ/w8strH2DccBkNCwTY29LWF4osybFfevCjQZGZAtxik
 nODo693xaorNMYBpQ9o6VW4l2c5HP44NiRW3RBRO9PucU9ZL531vPKVeHwKSWHbhqhj1urRhIzf
 5FeKomKycMlm2VCvt2/wgilOseJ6079/dLG3v39LATVSwuNJvQRLOmK7i2f9P9qrrF0ANQyCdSX
 WOchJEgNiTKipaxjXazmXEqD2likKpKVjoQUatFsHKaU2clwr9Gp+glEC9oG1W3P1EQuFP43mCZ
 V2RPiTlXR3XObuC5U0zwHrrmTu+QHjddnaMXxp1MAEfZD93l/yzIV4yS2WVQj7HKSbw7jKa1FVZ
 qU5koSkoiI
X-Received: by 2002:a05:622a:1f8c:b0:536:4482:2c5d with SMTP id
 d75a77b69052e-555292bb79dmr5973521cf.19.1794254003268; 
 Mon, 09 Nov 2026 11:53:23 -0800 (PST)
X-Received: by 2002:a05:622a:1f8c:b0:536:4482:2c5d with SMTP id
 d75a77b69052e-555292bb79dmr5973091cf.19.1794254002606; 
 Mon, 09 Nov 2026 11:53:22 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-555091eb801sm5435591cf.2.2026.11.09.11.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:53:22 -0800 (PST)
Message-ID: <090e835e-ae47-46e3-b8e6-8639bd9db920@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:53:18 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/38] fpu/softfloat: Support OCP(Open Compute
 Project) OFP8 checking functions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-2-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-2-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX7EQViweiVJRv
 UGJ7CrUcNySbU6s6Fck7pxE5PKesckOqQxaxjcFsKXNfTjhsj0vhqGEbft8K54LxEA1DbfCEKGr
 ZM2pyn0lbGATtw25cjCLh4RMkMJRyCaRz+6q5xO0w03nNV4VzrOw1uA3KQGQxSgF2mvGr0Pjm2I
 OJESC4pOKtFDGjJfYVdqdagkBUCjWXBC2Ut04FMrwKz9cR84TyMvVqElk3DAHZOw1Ha5koOuHTe
 7EOhhmLWzpOyjzDqaY/8yhW6hnBZAkJ+iV7052TRwpJN9/lrTaDU65SqM16L2lXRWnWN3tRuIDU
 7wC7CNXWjD8p7j+RzJW5WWAblQVf5j8NtOf9HH49OOh5pr3ru3fO8/muitkePZfAAoKzte4F79w
 Um+3r9/Tik7yNvWx36Aywk420zzEJ6KLPiI2McR3QSwmCfWE7uvfqAvc2etHanioGc1Nm17iStG
 Npd0a/OQu+wkrlfGqiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX3tzWf14o6tOY
 /tNH1/uywHULdF15JgzRuvBqq1WQMHBt8Ukwp7XCLYtqfKFknTj4MWNE4KbxSr3BIOeXG4mW3nl
 bu/ISOOUhET/VmqOYFcRp4V/Wpa3I2Q=
X-Proofpoint-ORIG-GUID: jyJxeT0FruLSh-7lcfwrKknsuEfiVp-8
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af224b4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=FVchq9tdzEtsCYCC46gA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: jyJxeT0FruLSh-7lcfwrKknsuEfiVp-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Include following checking functions liked other fp types:

typo: s/liked/like

> - *_nan_is_snan
> - *_is_quiet_nan
> - *_is_signaling_nan
> - *_is_any_nan
> - *_is_neg
> - *_is_infinity
> - *_is_zero
> - *_is_zero_or_denormal
> - *_is_normal
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   fpu/softfloat-specialize.c.inc | 55 ++++++++++++++++++++++++++
>   include/fpu/softfloat.h        | 70 ++++++++++++++++++++++++++++++++++
>   2 files changed, 125 insertions(+)
> 
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index 8b765ef623f..22a3188f99b 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -255,6 +255,61 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
>       return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
>   }
>   
> +/*----------------------------------------------------------------------------
> +| Determine if a OCP FP8 E4M3 NaN is signaling NaN.
> +| E4M3 has only one NaN encoding, so classification is policy-based.
> +*----------------------------------------------------------------------------*/
> +
> +static bool float8_e4m3_nan_is_snan(float8_e4m3 a, float_status *status)
> +{
> +    return get_float_e4m3_nan_is_snan(status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP FP8 E4M3 value `a' is a quiet NaN; otherwise returns 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_quiet_nan(float8_e4m3 a_, float_status *status)
> +{
> +    return float8_e4m3_is_any_nan(a_) && !float8_e4m3_nan_is_snan(a_, status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP FP8 E4M3 value `a' is a signaling NaN; otherwise 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_signaling_nan(float8_e4m3 a_, float_status *status)
> +{
> +    return float8_e4m3_is_any_nan(a_) && float8_e4m3_nan_is_snan(a_, status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Determine if a OCP FP8 E5M2 NaN is signaling NaN.
> +*----------------------------------------------------------------------------*/
> +
> +static bool float8_e5m2_nan_is_snan(float8_e5m2 a, float_status *status)
> +{
> +    return frac_msb_is_snan((a >> 1) & 1, status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP FP8 E5M2 value `a' is a quiet NaN; otherwise returns 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e5m2_is_quiet_nan(float8_e5m2 a_, float_status *status)
> +{
> +    return float8_e5m2_is_any_nan(a_) && !float8_e5m2_nan_is_snan(a_, status);
> +}
> +
> +/*----------------------------------------------------------------------------
> +| Returns 1 if the OCP FP8 E5M2 value `a' is a signaling NaN; otherwise 0.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e5m2_is_signaling_nan(float8_e5m2 a_, float_status *status)
> +{
> +    return float8_e5m2_is_any_nan(a_) && float8_e5m2_nan_is_snan(a_, status);
> +}
> +
>   /*----------------------------------------------------------------------------
>   | Determine if a float16 NaN is signaling NaN.
>   *----------------------------------------------------------------------------*/
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index d48fc6b0437..4d91599e25d 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -222,6 +222,76 @@ bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, float_status *status);
>   float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool sat, float_status *status);
>   float8_e5m2 float32_to_float8_e5m2(float32, bool sat, float_status *status);
>   
> +/*----------------------------------------------------------------------------
> +| OCP FP{4,8} classify operations.
> +*----------------------------------------------------------------------------*/
> +
> +bool float8_e4m3_is_quiet_nan(float8_e4m3, float_status *status);
> +bool float8_e4m3_is_signaling_nan(float8_e4m3, float_status *status);
> +bool float8_e5m2_is_quiet_nan(float8_e5m2, float_status *status);
> +bool float8_e5m2_is_signaling_nan(float8_e5m2, float_status *status);
> +
> +static inline bool float8_e4m3_is_any_nan(float8_e4m3 a)
> +{
> +    return ((a & ~0x80) == 0x7f);
> +}
> +
> +static inline bool float8_e5m2_is_any_nan(float8_e5m2 a)
> +{
> +    return ((a & ~0x80) > 0x7c);
> +}
> +
> +static inline bool float8_e4m3_is_neg(float8_e4m3 a)
> +{
> +    return a >> 7;
> +}
> +
> +static inline bool float8_e5m2_is_neg(float8_e5m2 a)
> +{
> +    return a >> 7;
> +}
> +
> +static inline bool float8_e4m3_is_infinity(float8_e4m3 a)
> +{
> +    return false;
> +}
> +
> +static inline bool float8_e5m2_is_infinity(float8_e5m2 a)
> +{
> +    return (a & 0x7f) == 0x7c;
> +}
> +
> +static inline bool float8_e4m3_is_zero(float8_e4m3 a)
> +{
> +    return (a & 0x7f) == 0;
> +}
> +
> +static inline bool float8_e5m2_is_zero(float8_e5m2 a)
> +{
> +    return (a & 0x7f) == 0;
> +}
> +
> +static inline bool float8_e4m3_is_zero_or_denormal(float8_e4m3 a)
> +{
> +    return (a & 0x78) == 0;
> +}
> +
> +static inline bool float8_e5m2_is_zero_or_denormal(float8_e5m2 a)
> +{
> +    return (a & 0x7c) == 0;
> +}
> +
> +static inline bool float8_e4m3_is_normal(float8_e4m3 a)
> +{
> +    uint8_t em = a & 0x7f;
> +    return em >= 0x8 && em <= 0x7e;
> +}
> +
> +static inline bool float8_e5m2_is_normal(float8_e5m2 a)
> +{
> +    return (((a >> 2) + 1) & 0x1f) >= 2;
> +}
> +
>   /*----------------------------------------------------------------------------
>   | Software half-precision conversion routines.
>   *----------------------------------------------------------------------------*/


