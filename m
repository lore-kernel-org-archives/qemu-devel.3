Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EE606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eZOHBjD/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gBs24QXF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVUG-0002Ek-G0; Mon, 09 Nov 2026 14:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVTW-00027N-GA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:56:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVTS-0003tx-SO
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:56:17 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HGx7r4125880
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2+EXaHpDc72ldrAuZGfHui0hFMnIRkBeoi4cZSnr/Wk=; b=eZOHBjD/zIr59zQK
 b94Y83kzjb1iMT1VtlEpXsN1enZR7Mh4TESASikNwCPio1Ba/PAmSfPJOyxeDe9c
 LK9CJGHOHxLBv05/WCUIQIpbo6wbo7jQL0vjXjfk4Tuzn9s5POpA9eP9FuEHKCNt
 DMYsa9ECOj8Sqg153te6sYfw7YlH8sq0zxjkVMvfSlpkpxtrXmwqvkruelO14pBU
 +KngdtE5+nkzHOrNGI5O685zR1HZdreP2Afv4fWa8rjeHbDrQoc/RJzS2pBs+nm3
 ElhgBb4hJLOlgWLZ+L/oDUkUJSG9i53d9H1K+cBEL+EIOXPYKk+nJJ6a9hyLNgdl
 CtRBPQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcj9u56-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:56:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c6c1e082bso22531656d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254172; x=1794858972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2+EXaHpDc72ldrAuZGfHui0hFMnIRkBeoi4cZSnr/Wk=;
 b=gBs24QXFkGdKeiiJ5T4i4oe2hxRisyjrDm3B59OHl4jklwH2hPJVdk/iVRbjjAy4/2
 jv3rUeor+hpdNRwsU/laQN299zWBPzsXEL3juVtmHRHY8mU1rk6zOcFsW2a6b59/4xfa
 j1NY4NtN1f80abqaaFfRe0/9Czi7hqFA9G/0DSOf5Xq0GgpH/w6yj7OBMAoQv4j8gLYo
 +g889UCo6BfYLmhCaIw+qpz7HbX23/xIzYzm41rwYTWOcunvlYCWHqBxd8hjUG1pU8Bz
 NLl6SThBqo5qgsZa9eYjU6fok3xxUpaFrOafBUxRCfzlE1ghbBysx/8iDkrV/aZE3dRI
 r3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254172; x=1794858972;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2+EXaHpDc72ldrAuZGfHui0hFMnIRkBeoi4cZSnr/Wk=;
 b=c+6YPuYyw/Vhly8HP2Doc0lGiIdvQ35YhyCY9FlhgGU+aGm/H9Xo7D+5A+0ugzZEd2
 HjU6hMLNL9Ti5aG+NWb572d7uSpsAQw4ODxSlMPrP3FQIYMiVunFe0hZxVqgHbApyrsP
 xX/hwVffqycqCoafk+xKA17SPVNvFM7bdczOnUXbcjkx59YuyahcQUZZdpk+obh0YQ8K
 X73f/uH7Yea444zkJVpOPneavHlbN5J+9vnqJXfsYRCoIVBP9rc3vB9JFteJCuoBWnUa
 xpf1gdvF5kttgdNAOeVizOXEftLZN+DTx7gGxtCqhcCBvTCt5H+Gl2Jgk8XqV39z+1gb
 qzQA==
X-Forwarded-Encrypted: i=1;
 AL+hErF8CJDSx4yaVLlYoTw/MQSxQVebcomk2TeEVuSFUKSZKA69+LLgCpor0qYU9LTDuhvr4JuoWthAZlZB@nongnu.org
X-Gm-Message-State: APuU4Z916Q8tNQUIDEaxDMM5gTKMvANIbu+hIRVAM+NOivOnCA5jX81M
 VdYUoCsMjST4j79leGobd3aUTUQhGq/d8Pudi2m/0F7DqnYYdVPSiwyUOQRcWcuPzROTmyXjozJ
 qQ2aQLpoFj71C2fkvV6IhZHCQRuw2TBu7OpIJNOuYLRtAslxsg/LpdFIzvA==
X-Gm-Gg: AYBFou09Wjp+yx+0pOJ6Ep8opZHH3GEFU6g6jkQwVVi/yV8e8UXm2XCEKdBW66Ub3tf
 CwpPV6fP6Ugz2IWw/e97Rtn9ZBWD4CxtWA452BztRkPb9/RBOlxIg0KcnRT4IK8PlNBf7m1+kVU
 4RKLma969xz4pzjNzjL5b4S4adHirHcIXgJU4bP8Ax1uK9SEPKse6m1xvOD+ttW1oEIfvSx+e9l
 lpl0DHHezqs9LYg8xRrDriC4srXr36OAnSeNaD7DFcZpGcH5bNAOsh19siO88G2225qDcTP57RG
 eLShzpK8lqqQE5zHqU3w28FW5gDTkXexUmjlCgW42RNZSzegX3RR+s4RDIum+rrs+TxuvBh2YEf
 A0dC62a14u7pl0q+26HcNpF3drg/3ByEUjNC/lHQY2jhva36iFmqRrxhNWhd/g5rnMI0IHSG5uo
 X4XGbbbycW
X-Received: by 2002:a05:620a:44ca:b0:93f:231:9ff with SMTP id
 af79cd13be357-9479f220178mr84951485a.27.1794254171988; 
 Mon, 09 Nov 2026 11:56:11 -0800 (PST)
X-Received: by 2002:a05:620a:44ca:b0:93f:231:9ff with SMTP id
 af79cd13be357-9479f220178mr84946985a.27.1794254171387; 
 Mon, 09 Nov 2026 11:56:11 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73c3d0sm52467585a.11.2026.11.09.11.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:56:10 -0800 (PST)
Message-ID: <8911070d-8caa-4695-aa81-3733d508fb41@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:56:07 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/38] target/riscv: rvv: Introduce RVBNA algorithm
 for Zvdota/Zvbdota extensions
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
 <20261104194155.679241-4-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Gqhxkfw6OoS1ZBjD2sWULW0Eluuwp234
X-Proofpoint-ORIG-GUID: Gqhxkfw6OoS1ZBjD2sWULW0Eluuwp234
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af2255d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=YEB5RgzmAAAA:8
 a=fAVkfpSqpBLX86kczpIA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=oJz5jJLG1JtSoe7EL652:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfXwA0eVvQJE5KS
 8BKCVoMqn904NK3VMbgaYDa/XYB0tr7bjVXSnNlNC3hi6QLj8/54khHOij0Fm2ZklsOzx8ZR9j+
 IVnSsk+MCfLsg3hT6Po6Q8hDKdjZB/g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX9ugp3lIeRbGH
 ppv+LnH2CLFpszkdcrBLj64Hk500/eBA2C3uOLgCUDo3JS+ZlJnjubbwtc4db3kOoi770l1cV43
 Rg83PA2VBoKU46QR4yLdBNBugNvST2WZ3r4n64fYLV63bFEFAjU5FEd+BnT37NBBiIag/VwBOla
 A55lagdqLYX6Y1NXJSsWRvcv3eb6l4O5I/QMuZb67vcyJq/p3VTuAcxpTaZWfeXHOo3nPeviizd
 1R+3IhvHhI+Vd1JiYRDeUzfqfZ+G1adK3Dn4EXerMfEexZBWNzyw8IMNcRwFTXMPAkuoHrLRLYY
 nD7KqDuHPqc8N/0r7wIZilF0SZNkvt8sSNXy+j+ADQ0vYjCQguMpwTeX9QUsVR3LvrnCwUftyuS
 lz0ELyrc1jfU8EZ29Arz8qe6XTvlWQHxQBRFmbqLkjlFHl4lWT3X4ArY4WEI83fGrlRTH1u2cDe
 DmGFIhx3wvCB2vZK1Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 11/4/2026 4:41 PM, Max Chou wrote:
> The RISC-V Bulk Normalization Algorithm (RVBNA) is a scheme employed by
> multiple RISC-V extensions (e.g. Zvdota/Zvbdota family) for efficient
> computation of floating-point dot products.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                      |   6 +
>   target/riscv/tcg/meson.build     |   2 +-
>   target/riscv/tcg/rvbna.c         | 185 +++++++++++++++++++++++++++++++
>   target/riscv/tcg/rvbna.h         |  40 +++++++
>   target/riscv/tcg/vector_helper.c |   1 +
>   5 files changed, 233 insertions(+), 1 deletion(-)
>   create mode 100644 target/riscv/tcg/rvbna.c
>   create mode 100644 target/riscv/tcg/rvbna.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55463103ff1..b91e5925344 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -416,6 +416,12 @@ F: target/riscv/tcg/xsf_helper.c
>   F: disas/riscv-xsf*
>   F: tests/tcg/riscv64/test-xsfvqmacc.S
>   
> +RISC-V Bulk Normalization Algorithm (RVBNA)
> +M: Max Chou <max.chou@sifive.com>
> +L: qemu-riscv@nongnu.org
> +S: Supported
> +F: target/riscv/tcg/rvbna.*
> +
>   RENESAS RX CPUs
>   R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   S: Orphan
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index 86805b30cbc..3b7821178fc 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -10,6 +10,7 @@ riscv_ss.add(files(
>     'fpu_helper.c',
>     'm128_helper.c',
>     'op_helper.c',
> +  'rvbna.c',
>     'translate.c',
>     'tcg-cpu.c',
>     'vcrypto_helper.c',
> @@ -27,4 +28,3 @@ riscv_system_ss.add(files(
>     'th_csr.c',
>   ))
>   
> -
> diff --git a/target/riscv/tcg/rvbna.c b/target/riscv/tcg/rvbna.c
> new file mode 100644
> index 00000000000..f6150e4976d
> --- /dev/null
> +++ b/target/riscv/tcg/rvbna.c
> @@ -0,0 +1,185 @@
> +/*
> + * RISC-V Bulk Normalization Algorithm (RVBNA)
> + *
> + * Copyright (c) 2026 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/host-utils.h"
> +#include "fpu/softfloat.h"
> +#include "fpu/softfloat-macros.h"
> +#include "rvbna.h"
> +
> +static inline int rvbna_guard_bits(uint32_t n_prod)
> +{
> +    g_assert(n_prod > 0);
> +    return 32 - clz32(n_prod - 1);
> +}
> +
> +float32 rvbna_final_f32_add(float32 partial, float32 accumulator,
> +                            float_status *fp_status)
> +{
> +    FloatRoundMode old_rm = get_float_rounding_mode(fp_status);
> +    int old_flags = get_float_exception_flags(fp_status);
> +    int new_flags;
> +    float32 result;
> +
> +    set_float_rounding_mode(float_round_to_odd_inf, fp_status);
> +    set_float_exception_flags(0, fp_status);
> +    result = float32_add(partial, accumulator, fp_status);
> +    new_flags = get_float_exception_flags(fp_status) &
> +                (float_flag_invalid | float_flag_overflow);
> +    set_float_rounding_mode(old_rm, fp_status);
> +    set_float_exception_flags(old_flags | new_flags, fp_status);
> +
> +    return result;
> +}
> +
> +#define RVBNA_STACK_THRESHOLD 8
> +
> +#define GEN_RVBNA(TA, TB, TO, A_E, A_M, B_E, B_M, OUT_E, OUT_M)              \
> +TO rvbna_dot_##TA##_##TB(const TA a[], const TB b[], uint32_t n_prod,        \
> +                         float_status *fp_status)                            \
> +{                                                                            \
> +    int32_t stack_ref_exps[RVBNA_STACK_THRESHOLD];                           \
> +    bool stack_signs[RVBNA_STACK_THRESHOLD];                                 \
> +    uint64_t stack_sigs[RVBNA_STACK_THRESHOLD];                              \
> +    int32_t *prod_ref_exps = stack_ref_exps;                                 \
> +    bool *prod_signs = stack_signs;                                          \
> +    uint64_t *prod_sigs = stack_sigs;                                        \
> +    g_autofree int32_t *heap_ref_exps = NULL;                                \
> +    g_autofree bool *heap_signs = NULL;                                      \
> +    g_autofree uint64_t *heap_sigs = NULL;                                   \
> +    int guard_bits = rvbna_guard_bits(n_prod);                               \
> +    int pad = OUT_M - (A_M + B_M) + guard_bits;                              \
> +    int output_bias = (1 << (OUT_E - 1)) - 1;                                \
> +    int a_exp_bias = (1 << (A_E - 1)) - 1;                                   \
> +    int b_exp_bias = (1 << (B_E - 1)) - 1;                                   \
> +    int ref_bias = output_bias - (a_exp_bias + b_exp_bias);                  \
> +    int max_prod_ref_exp = ref_bias;                                         \
> +    int overflow_exp = (1 << OUT_E) - 1;                                     \
> +    int64_t acc = 0;                                                         \
> +    bool nan_result = false;                                                 \
> +    bool inf_result = false;                                                 \
> +    bool inf_sign = false;                                                   \
> +    bool any_pos_inf = false;                                                \
> +    bool any_neg_inf = false;                                                \
> +    bool any_invalid_prod = false;                                           \
> +    bool any_signan = false;                                                 \
> +    bool op_sign_inf, sign, overflow;                                        \
> +    uint32_t i;                                                              \
> +    uint64_t sig;                                                            \
> +    int lead, exp, sig_bits;                                                 \
> +                                                                             \
> +    g_assert(pad >= 0);                                                      \
> +    if (n_prod > RVBNA_STACK_THRESHOLD) {                                    \
> +        heap_ref_exps = g_new(int32_t, n_prod);                              \
> +        heap_signs = g_new(bool, n_prod);                                    \
> +        heap_sigs = g_new(uint64_t, n_prod);                                 \
> +        prod_ref_exps = heap_ref_exps;                                       \
> +        prod_signs = heap_signs;                                             \
> +        prod_sigs = heap_sigs;                                               \
> +    }                                                                        \
> +                                                                             \
> +    for (i = 0; i < n_prod; i++) {                                           \
> +        bool a_sign = TA##_is_neg(a[i]);                                     \
> +        bool b_sign = TB##_is_neg(b[i]);                                     \
> +        bool a_sub = TA##_is_zero_or_denormal(a[i]);                         \
> +        bool b_sub = TB##_is_zero_or_denormal(b[i]);                         \
> +        bool a_zero = TA##_is_zero(a[i]);                                    \
> +        bool b_zero = TB##_is_zero(b[i]);                                    \
> +        bool a_inf = TA##_is_infinity(a[i]);                                 \
> +        bool b_inf = TB##_is_infinity(b[i]);                                 \
> +        bool a_nan = TA##_is_any_nan(a[i]);                                  \
> +        bool b_nan = TB##_is_any_nan(b[i]);                                  \
> +        bool prod_sign = a_sign ^ b_sign;                                    \
> +        bool invalid_prod = (a_inf && b_zero) || (b_inf && a_zero);          \
> +        bool inf_prod_lhs = a_inf && !b_nan && !b_zero;                      \
> +        bool inf_prod_rhs = b_inf && !a_nan && !a_zero;                      \
> +        bool inf_prod = inf_prod_lhs || inf_prod_rhs;                        \
> +        bool invalid_sum = inf_result && inf_prod &&                         \
> +                           (inf_sign != prod_sign);                          \
> +        uint32_t a_mant = extract32(a[i], 0, A_M);                           \
> +        uint32_t b_mant = extract32(b[i], 0, B_M);                           \
> +        bool a_signan = a_nan && TA##_is_signaling_nan(a[i], fp_status);     \
> +        bool b_signan = b_nan && TB##_is_signaling_nan(b[i], fp_status);     \
> +        uint64_t a_sig = a_mant | (!a_sub << A_M);                           \
> +        uint64_t b_sig = b_mant | (!b_sub << B_M);                           \
> +        bool prod_is_zero = a_zero || b_zero;                                \
> +        bool either_inf = a_inf || b_inf;                                    \
> +        bool either_nan = a_nan || b_nan;                                    \
> +                                                                             \
> +        any_invalid_prod |= invalid_prod;                                    \
> +        nan_result |= a_nan || b_nan || any_invalid_prod || invalid_sum;     \
> +        inf_result |= inf_prod;                                              \
> +        inf_sign = inf_prod ? prod_sign : inf_sign;                          \
> +                                                                             \
> +        prod_signs[i] = prod_sign;                                           \
> +        prod_sigs[i] = (uint64_t)(a_sig * b_sig) << pad;                     \
> +        prod_ref_exps[i] = ref_bias;                                         \
> +        if (!prod_is_zero) {                                                 \
> +            prod_ref_exps[i] += (a_sub ? 1 : extract32(a[i], A_M, A_E)) +    \
> +                                (b_sub ? 1 : extract32(b[i], B_M, B_E));     \
> +        }                                                                    \
> +        max_prod_ref_exp = MAX(prod_ref_exps[i], max_prod_ref_exp);          \
> +                                                                             \
> +        any_pos_inf |= (either_inf && !either_nan && !prod_is_zero &&        \
> +                        (a_sign == b_sign));                                 \
> +        any_neg_inf |= (either_inf && !either_nan && !prod_is_zero &&        \
> +                        (a_sign != b_sign));                                 \
> +        any_signan |= a_signan || b_signan;                                  \
> +    }                                                                        \
> +                                                                             \
> +    op_sign_inf = any_pos_inf && any_neg_inf;                                \
> +                                                                             \
> +    if (nan_result) {                                                        \
> +        if (any_signan || any_invalid_prod || op_sign_inf) {                 \
> +            float_raise(float_flag_invalid, fp_status);                      \
> +        }                                                                    \
> +        return TO##_default_nan(fp_status);                                  \
> +    } else if (inf_result) {                                                 \
> +        return TO##_set_sign(TO##_infinity, inf_sign);                       \
> +    }                                                                        \
> +                                                                             \
> +    for (i = 0; i < n_prod; i++) {                                           \
> +        shift64RightJamming(prod_sigs[i],                                    \
> +                            max_prod_ref_exp - prod_ref_exps[i], &sig);      \
> +        acc += prod_signs[i] ? -(int64_t)sig : (int64_t)sig;                 \
> +    }                                                                        \
> +                                                                             \
> +    sign = acc < 0;                                                          \
> +    sig = sign ? -(uint64_t)acc : acc;                                       \
> +    if (sig == 0) {                                                          \
> +        return 0;                                                            \
> +    }                                                                        \
> +                                                                             \
> +    lead = 63 - clz64(sig);                                                  \
> +    exp = max_prod_ref_exp - OUT_M - guard_bits + lead;                      \
> +    overflow = exp >= overflow_exp;                                          \
> +    if (overflow) {                                                          \
> +        float_raise(float_flag_overflow, fp_status);                         \
> +        sig = 0;                                                             \
> +        exp = overflow_exp;                                                  \
> +    } else {                                                                 \
> +        sig_bits = MAX(0, exp <= 0 ? OUT_M - (1 - exp) : OUT_M);             \
> +        if (lead > sig_bits) {                                               \
> +            shift64RightJamming(sig, lead - sig_bits, &sig);                 \
> +        } else {                                                             \
> +            sig <<= (sig_bits - lead);                                       \
> +        }                                                                    \
> +        exp = MAX(exp, 0);                                                   \
> +    }                                                                        \
> +    return (TO)deposit64(deposit64(sig, OUT_M, OUT_E, exp),                  \
> +                         OUT_M + OUT_E,                                      \
> +                         1, sign);                                           \
> +}
> +
> +GEN_RVBNA(float8_e4m3, float8_e4m3, float32, 4, 3, 4, 3, 8, 23)
> +GEN_RVBNA(float8_e4m3, float8_e5m2, float32, 4, 3, 5, 2, 8, 23)
> +GEN_RVBNA(float8_e5m2, float8_e4m3, float32, 5, 2, 4, 3, 8, 23)
> +GEN_RVBNA(float8_e5m2, float8_e5m2, float32, 5, 2, 5, 2, 8, 23)
> +GEN_RVBNA(float16, float16, float32, 5, 10, 5, 10, 8, 23)
> +GEN_RVBNA(bfloat16, bfloat16, float32, 8, 7, 8, 7, 8, 23)
> diff --git a/target/riscv/tcg/rvbna.h b/target/riscv/tcg/rvbna.h
> new file mode 100644
> index 00000000000..d4d3eced952
> --- /dev/null
> +++ b/target/riscv/tcg/rvbna.h
> @@ -0,0 +1,40 @@
> +/*
> + * RISC-V Bulk Normalization Algorithm (RVBNA)
> + *
> + * Copyright (c) 2026 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef TARGET_RISCV_TCG_RVBNA_H
> +#define TARGET_RISCV_TCG_RVBNA_H
> +
> +#include "fpu/softfloat.h"
> +
> +float32 rvbna_final_f32_add(float32 partial, float32 accumulator,
> +                            float_status *fp_status);
> +
> +float32 rvbna_dot_float8_e4m3_float8_e4m3(const float8_e4m3 a[],
> +                                          const float8_e4m3 b[],
> +                                          uint32_t n_prod,
> +                                          float_status *fp_status);
> +float32 rvbna_dot_float8_e4m3_float8_e5m2(const float8_e4m3 a[],
> +                                          const float8_e5m2 b[],
> +                                          uint32_t n_prod,
> +                                          float_status *fp_status);
> +float32 rvbna_dot_float8_e5m2_float8_e4m3(const float8_e5m2 a[],
> +                                          const float8_e4m3 b[],
> +                                          uint32_t n_prod,
> +                                          float_status *fp_status);
> +float32 rvbna_dot_float8_e5m2_float8_e5m2(const float8_e5m2 a[],
> +                                          const float8_e5m2 b[],
> +                                          uint32_t n_prod,
> +                                          float_status *fp_status);
> +float32 rvbna_dot_float16_float16(const float16 a[], const float16 b[],
> +                                  uint32_t n_prod,
> +                                  float_status *fp_status);
> +float32 rvbna_dot_bfloat16_bfloat16(const bfloat16 a[], const bfloat16 b[],
> +                                    uint32_t n_prod,
> +                                    float_status *fp_status);
> +
> +#endif
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 917a48b5106..172ae0f11dc 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -31,6 +31,7 @@
>   #include "tcg/tcg-gvec-desc.h"
>   #include "internals.h"
>   #include "vector_internals.h"
> +#include "rvbna.h"
>   #include <math.h>
>   
>   static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)


