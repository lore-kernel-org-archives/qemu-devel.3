Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4216CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCWaa-0004pK-Us; Fri, 02 Oct 2026 02:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCWaY-0004o9-SV
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:17:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCWaW-00044l-FJ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:17:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6925j9IF911617
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 06:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BNbF31WJepZh7bWl7+TF0gI+HZOF0mqQQBhQ31lrdZA=; b=BkuR+rVRjDXEAsMG
 733EMA/EzqPzWffzn+IZZKdHtrFYDz1c3NSxPZTuS+v6pDsFFilbtFDhrJtDqJgQ
 WML4bS6MZ+EXGBdtAXopVs1bW0OHgo1/J8sTRzVysltrcIqwHhPtYu/GizL6oF2K
 t2H8ejGbHxojDTDWQZF7MpUP9PrgaI75I22rDGUCWQ8nvzjlc4Shk5V56KU5Rg2n
 SRQy777pGuT7PfQLPMw8PThoGE3xZBLTpKMQBazSyTpEPMXxX3ANLZJO+AkCEhHK
 RkoiLsb1NHiYbiHCnZ7Bjb2lldBEQkJ6GBBWKr28Kuw0wYa6miMrbpvGKJQSZRVG
 tRCqfA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh140h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 06:17:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so1654610585a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 23:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790921862; x=1791526662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BNbF31WJepZh7bWl7+TF0gI+HZOF0mqQQBhQ31lrdZA=;
 b=NwnP1lD2zRacwbRzBaNwbi5FghpcchfyRUJ5Yu6PPGP684q6rybvkMTRAZ9Z22sCgo
 zUkGPOXnBgW0BZ3lyrRVW7Jpm2pF1BUym5QYTnyXDi9KPQkrloxWfgKllsPSS1w16shY
 u3Q7ywvjVS8jIawoUMSyEC3Xv0xRdcQVsZ+aSRt91R6cJS9a8SSGpEuGJq76Lzlvq4A0
 q/U1vTNVVlWsy6h2jz/118+TsoPWYCzhF206PLIj6V+aj4WEh0Y9tLVwpSd2BiKEqeXv
 17kV3EZcRaSp0hD/8vtncpLbVF0hLOhzZoNq9FBjn7uIgj6cElGDfQUvvhD9ykYqUz5W
 2FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790921862; x=1791526662;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNbF31WJepZh7bWl7+TF0gI+HZOF0mqQQBhQ31lrdZA=;
 b=YrJlTAjQqm9him58iM8bo8f/PJcDpqG2Owg2db0DN9DDXO2ddEpwKoSVf7fXAlu514
 3uhYEmi0LLivDicoWMxTVWpJpQQh1ImW+JYIwB/zNfONf5mSFbw302GP0S2pVmOmKzZG
 +GkVFeAnZlkE15djQUHfwpyDwKAm1iG9e53CDeGzKkEOY0hwQoIzmFrFVpNybnPCThw6
 9ePZR9QPWUAMHsFb1GEhsPNMY0+K4OReuwmBtbEg3l1THql6Ic+GNTTnwwcXQFCna+to
 5uX5+A3lfkyCM7MN2dSfLugVbe071CJNu4BWZy6OMXd4cqphH+rv92HE6cc5BQRFvNnG
 SwAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+98MlEE36gBqWgXccTvrg/nmz4TDB5m18D5L4qWtk6OsYsxoP/k6MjcbvyyoVr/1yhbjj4O1RiAR3@nongnu.org
X-Gm-Message-State: AFuF++m0caEYJPQjR0xKu2U3uqG7ils7gAQ2z2GUMvBvRZOXI3kiSG14
 X1Wlwscy8xVebOm331sUoC2MHu2ZBYc01N/ie0e8How2a5ky4WHUH9/l1BO6nImj3+yUBqKUyig
 zWCouJsa9Yt3mGWikXl5duk7vF9u/duX4d82l3q3RqFu5D6i09Vnu7HrfLA==
X-Gm-Gg: AYBFou2Mi9YYl7Y1tpmGNCdODNDozSjaxZSGVEsxJVFW4TfF1A6ZaTanwUFHOgbRniv
 ZS0CY1LS+/hy5utMLnyRfuAIU9YyYQB+GY4CHz/gNdHnkMYTB1WZVeA3aFx3Ummiow25Wd0HCj4
 2o18n6ML6XNDPBsOQdjifnQb0rOfk/sW42wLXE5njPIpXLTsUy3xAYkdeVVbN1P7cFoG4Hczymh
 CBssR7BYr1BmXz5jgIqniiMaHhpUphhL6O7zEt3UYzOZ/1YcjJX7UXZwGOnBbYRqDaZPAdcPUXI
 D0qRHtl0lSAW1vE/nEcRiR61eQAyBlUr3h1TcNXqQVVaKATGzOK2caOuS3WuQYGdj9ZfUIDyfLb
 py+BnIRJ0uONpj1U4/XPUicdfP8bGtIo8DA==
X-Received: by 2002:a05:620a:a2ce:20b0:93c:5872:ef3f with SMTP id
 af79cd13be357-93cf170bc45mr216967485a.16.1790921861359; 
 Thu, 01 Oct 2026 23:17:41 -0700 (PDT)
X-Received: by 2002:a05:620a:a2ce:20b0:93c:5872:ef3f with SMTP id
 af79cd13be357-93cf170bc45mr216964785a.16.1790921860819; 
 Thu, 01 Oct 2026 23:17:40 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02773ba02sm50348535e9.12.2026.10.01.23.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 23:17:40 -0700 (PDT)
Message-ID: <0a2a9b0f-82cb-427b-a24e-4d0656601212@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 08:17:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 039/114] target/riscv: preserve signed XLEN semantics
 without target_long
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Zhao Liu <zhao1.liu@intel.com>,
 Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
 <20260923131635.1894-40-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923131635.1894-40-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyNCBTYWx0ZWRfX0Mn34hFMnEKC
 hl+0yCg1vl2HaSuHZ6Mw/R62hl978rCfkMnCNCli1Q/IoFa3zZ50w5vo5JxjNPRyRCzDGjU3cWO
 mSA0/4QA6ehdTzuWzfhge+wNClacSFQ=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abf4c86 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=Y1mprN9G3zUyOUoue3YA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyNCBTYWx0ZWRfX2pKnGHgl1i8u
 VMtKWkjg9SGEQcHi21NCXJKiurpilOqsY+d6qqS+piBkoVKsk13dCm0SNYTy7aPO/cYs3nryVzL
 jImbH6U1U4dq0Pb4kEFMpqMZNskGuQm3NDuciC29ST0U/+dqd0hSa5Whoza6Q3wML7cRzu7uF+9
 7OkdQ1O3wpt1hu0zqKCZ+MCFgiq423ohxbs2I1mcUSpm8DX7fECGlWC07FaxTSpAc3N+6wASC2E
 CAX6u1Q1xMHWAzw7RYYV5ziFL9YdaUxu2y1zXpYdFyx30d5UxQcU4KVRuzgXyDPdyHuu1CPBWh/
 xBZZ4b8EvSdNWN5RJ+jopgIgyjuH+YU/htqWgBUqrbGMuK5XDFzS8Lpt+Xe+OPkF5+myh58VGEc
 63l6or1sNeY9lQG/C+TPv8/pwru+B2iqunBFPWUopvZ99zTITZdW36J7daT/Idcm+xAN8kc2JOu
 8m3ALitUGKxbtVq+BEA==
X-Proofpoint-GUID: TJV8zgqJ_fSQCQsSp8EIxi-6tealEBTd
X-Proofpoint-ORIG-GUID: TJV8zgqJ_fSQCQsSp8EIxi-6tealEBTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020024
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

(reducing huge Cc list a bit)

On 23/9/26 15:15, Yonggang Luo wrote:
> - Mask pointer-masked addresses with extract64/sextract64 at
>    runtime XLEN instead of a target_long arithmetic shift.
> - Pass vector vx scalars as int64_t after sextract64 from the
>    helper tl slot so RV32 keeps bit 31 as the sign bit.
> - Leave every target_ulong helper argument unchanged.

I'm not a RISCV expert but have the feeling some target_long_bits()
should be riscv_cpu_mxl_bits() instead (or something else), as it
depends in which state the CPU is running.

Helpers having @env passed as argument could infer locally.

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/riscv/internals.h            | 12 ++++++++----
>   target/riscv/tcg/vector_helper.c    | 21 +++++++++++----------
>   target/riscv/tcg/vector_internals.c |  2 +-
>   target/riscv/tcg/vector_internals.h |  9 +++++----
>   4 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 1ee7e99e988..0844867246d 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -214,6 +214,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
>   {
>       RISCVPmPmm pmm = PMM_FIELD_DISABLED;
>       uint32_t pmlen = 0;
> +    unsigned kept;
>       bool signext = false;
>   
>       /* do nothing for rv32 mode */
> @@ -235,13 +236,16 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
>   
>       signext = riscv_cpu_virt_mem_enabled(env, is_virt_addr);
>       pmlen = riscv_pm_get_pmlen(pmm);
> -    addr = addr << pmlen;
>   
> -    /* sign/zero extend masked address by N-1 bit */
> +    /*
> +     * Drop the top pmlen bits of XLEN. Do not rely on target_ulong
> +     * shift wrap; common-system target_ulong is always 64 bits.
> +     */
> +    kept = target_long_bits() - pmlen;
>       if (signext) {
> -        addr = (target_long)addr >> pmlen;
> +        addr = sextract64(addr, 0, kept);
>       } else {
> -        addr = addr >> pmlen;
> +        addr = extract64(addr, 0, kept);
>       }
>   
>       return addr;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 0d1e4e09646..0b78a733ce4 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -1248,7 +1248,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
>           ETYPE carry = vext_elem_mask(v0, i);                             \
>                                                                            \
> -        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
> +        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits()), carry);\
>       }                                                                    \
>       env->vstart = 0;                                                     \
>       /* set tail elements to 1s */                                        \
> @@ -1325,7 +1325,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
>           ETYPE carry = !vm && vext_elem_mask(v0, i);             \
>           vext_set_elem_mask(vd, i,                               \
> -                DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
> +                DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits()), carry));      \
>       }                                                           \
>       env->vstart = 0;                                            \
>       /*
> @@ -1609,7 +1609,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
>               continue;                                               \
>           }                                                           \
>           vext_set_elem_mask(vd, i,                                   \
> -                DO_OP(s2, (ETYPE)(target_long)s1));                 \
> +                DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits())));                 \
>       }                                                               \
>       env->vstart = 0;                                                \
>       /*
> @@ -2050,7 +2050,7 @@ GEN_VEXT_VV(vnmsub_vv_w, 4)
>   GEN_VEXT_VV(vnmsub_vv_d, 8)
>   
>   #define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
> -static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
> +static void do_##NAME(void *vd, int64_t s1, void *vs2, int i)   \
>   {                                                                   \
>       TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
>       TD d = *((TD *)vd + HD(i));                                     \
> @@ -2246,7 +2246,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
>       for (i = env->vstart; i < vl; i++) {                             \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
>           ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
> -                   (ETYPE)(target_long)s1);                          \
> +                   (ETYPE)sextract64(s1, 0, target_long_bits()));                          \
>           *((ETYPE *)vd + H(i)) = d;                                   \
>       }                                                                \
>       env->vstart = 0;                                                 \
> @@ -2397,12 +2397,12 @@ GEN_VEXT_VV_RM(vsaddu_vv_h, 2)
>   GEN_VEXT_VV_RM(vsaddu_vv_w, 4)
>   GEN_VEXT_VV_RM(vsaddu_vv_d, 8)
>   
> -typedef void opivx2_rm_fn(void *vd, target_long s1, void *vs2, int i,
> +typedef void opivx2_rm_fn(void *vd, int64_t s1, void *vs2, int i,
>                             CPURISCVState *env, uint8_t vxrm);
>   
>   #define OPIVX2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)          \
>   static inline void                                                  \
> -do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
> +do_##NAME(void *vd, int64_t s1, void *vs2, int i,               \
>             CPURISCVState *env, uint8_t vxrm)                         \
>   {                                                                   \
>       TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
> @@ -2410,7 +2410,7 @@ do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
>   }
>   
>   static inline void
> -vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
> +vext_vx_rm_1(void *vd, void *v0, int64_t s1, void *vs2,
>                CPURISCVState *env,
>                uint32_t vl, uint32_t vm, uint8_t vxrm,
>                opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
> @@ -2427,7 +2427,7 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
>   }
>   
>   static inline void
> -vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
> +vext_vx_rm_2(void *vd, void *v0, int64_t s1, void *vs2,
>                CPURISCVState *env,
>                uint32_t desc,
>                opivx2_rm_fn *fn, uint32_t esz)
> @@ -2468,7 +2468,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
>                     void *vs2, CPURISCVState *env,          \
>                     uint32_t desc)                          \
>   {                                                         \
> -    vext_vx_rm_2(vd, v0, s1, vs2, env, desc,              \
> +    vext_vx_rm_2(vd, v0, sextract64(s1, 0, target_long_bits()), \
> +                 vs2, env, desc,                          \
>                    do_##NAME, ESZ);                         \
>   }
>   
> diff --git a/target/riscv/tcg/vector_internals.c b/target/riscv/tcg/vector_internals.c
> index b490b1d3989..95327052666 100644
> --- a/target/riscv/tcg/vector_internals.c
> +++ b/target/riscv/tcg/vector_internals.c
> @@ -81,7 +81,7 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
>       vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
>   }
>   
> -void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
> +void do_vext_vx(void *vd, void *v0, int64_t s1, void *vs2,
>                   CPURISCVState *env, uint32_t desc,
>                   opivx2_fn fn, uint32_t esz)
>   {
> diff --git a/target/riscv/tcg/vector_internals.h b/target/riscv/tcg/vector_internals.h
> index 5681b818153..da093d561eb 100644
> --- a/target/riscv/tcg/vector_internals.h
> +++ b/target/riscv/tcg/vector_internals.h
> @@ -201,20 +201,20 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>                  do_##NAME, ESZ);                           \
>   }
>   
> -typedef void opivx2_fn(void *vd, target_long s1, void *vs2, int i);
> +typedef void opivx2_fn(void *vd, int64_t s1, void *vs2, int i);
>   
>   /*
>    * (T1)s1 gives the real operator type.
>    * (TX1)(T1)s1 expands the operator type of widen or narrow operations.
>    */
>   #define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
> -static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
> +static void do_##NAME(void *vd, int64_t s1, void *vs2, int i)       \
>   {                                                                   \
>       TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
>       *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1);                      \
>   }
>   
> -void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
> +void do_vext_vx(void *vd, void *v0, int64_t s1, void *vs2,
>                   CPURISCVState *env, uint32_t desc,
>                   opivx2_fn fn, uint32_t esz);
>   
> @@ -224,7 +224,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
>                     void *vs2, CPURISCVState *env,          \
>                     uint32_t desc)                          \
>   {                                                         \
> -    do_vext_vx(vd, v0, s1, vs2, env, desc,                \
> +    do_vext_vx(vd, v0, sextract64(s1, 0, target_long_bits()), \
> +               vs2, env, desc,                            \
>                  do_##NAME, ESZ);                           \
>   }
>   


