Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6D606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=liSATUMI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=egltvZF+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWCH-0003i2-Ep; Mon, 09 Nov 2026 15:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWBg-0003IG-4r
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:41:57 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWBe-0000IG-BY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:41:55 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9Jkx4g3799199
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PnI9mIlXZorXR4INuXCLEzClQGo86IaoZ3xVACIWVJc=; b=liSATUMIJiN4cR74
 xlZFmhKz1bR7BbeNQBe/LA6hhdluYDhcaHQMgMDFuxq9onK5IKgR2fqjxfZQ/Vwg
 PaBm9iybGgChE5aiuS8GYd6el/0molP+LP66g6qgwQ6uuB3vHUbD/ZZhrx6HuaCw
 QKtnKzsrft0bxrz/Q0xVqMrIpTrGPeXSv86eJsonKkupHPsXkapvJf1O0f7cyI9N
 v/BTkXrI57O2nR6Wf4KusSTXaIePtw1q4GOtgdkv3QBIairqG0vex8qCJvyOTDxd
 Qy8qIJcZRbilBwSYRLGKwBnzzfU39xtdpN6tKpo3INxntVG69A/9mCqrTfxbooqD
 g5pYYg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8takf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:41:52 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91eee6fa56bso4877736d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256911; x=1794861711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PnI9mIlXZorXR4INuXCLEzClQGo86IaoZ3xVACIWVJc=;
 b=egltvZF+ozg9EyiPknAKLlw3EmAIQN0RQr+5NEpn0yzlLuTjSYn+v6y/0gMQ4A+Lxz
 vDWzxnVbJJeexcTbWMoKx+VA+1jY7mg96A6YgXN5Q5oORmBfWg/nBRv+1rtwL81g+XpI
 u6Kd7LLAE7geIUKIh4ZnOnmewU3FCaJSZx7XftZqpt/c7sVPsmzCvcWpfPu3EGCpIea0
 DfyBYIOz+uUoZ//ZNKApKwiS+FCYqnp7Nxsz188KVSS44yQqRIFklLAoTnhwazTTeWiV
 U+eZ8PnzVeGbKzIDq/fS23k9Gt6TlHBoILxM2Erqbcfr2XM5i8yhfXzPEEY1VvWwkxxV
 Ym1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256911; x=1794861711;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PnI9mIlXZorXR4INuXCLEzClQGo86IaoZ3xVACIWVJc=;
 b=CLx0ESPxOBUjRFGJoiBEqDkLeOaBm0D4593VmfCA4pDvQLrFyWwHETaxyueOFGIiJM
 1IrNkLjAIl9E1sw0elIvd8gpdj8YRZdndqrKOtqp+4/DEY4r6AybMylIOF6NFWVN99rr
 nfU8OrgQHhM0JscIJVHrhwCPy1PdgV9noDi/gAvJlqcStbgmxn8cMFlH/KmRDPIzpSde
 DA4chD9mCq0m/CsH2l+iGpM/XVGNT/aaQlVM+hBczrfHXSG+xXPC8shTlnN/aIIq2h7g
 Q1QzU4tAPQfbhqAd3vP8fJhZqJoorBYHofUKsNsvqasi3pEWq3EM2Z/torLyTvNJW/LH
 kD6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFxOGgcsnYXKAy6DMZr6/fLv8jwp0SXyclVXWN0AhU2RUjRkgOcNEavy6IKv81zb4exnk1URGtjd2tx@nongnu.org
X-Gm-Message-State: APuU4Z92XB+O1/Tgq7HAAZGmN/0TCRIMzV4xk1WtJx8yw26iV3qSe/h5
 YYpRehW9HXY9g869siZ9bsJJXaik7cuTNFYGJiJkPOCRzZG0yObDXTjt240Td7synw6VM2Pcvs0
 wXVQ0f1hf6LTgIeE3/dOu+IMmyRPv0mQDCac5nwwatMLXrwn3w465/7GWlXO06Myj6g==
X-Gm-Gg: AYBFou0kF7UjcEFpvpAN2vFeTTaWjf3ruEo2RO9YBapJTcS8lr5sPHIebKit9xK5M1x
 uYlUekKeaWDfOZQPknuc96PDUrGHW9TNJ62Mm6lu8qicLs40uAe54TPXngIbMDuu5IcZ1V5BUtJ
 MBQBTih2QFnZS2Bmdnw4hcfi7hgtCF9fwJlMvn/i7Ui57Ok4MCuHUIGJO7mdB2jcMx7iVvw6HeB
 VtBwkJfYl4LJal5OSHVAXt5pFCIJQ5fZu+DyWZ/H7l/dAOWmgvbmen1bjcWANq2SBu8RHkmsRzs
 cPl4GMUa3ZRAxnQ8+uSNwl2ZWaNdwhMqzRzbP2LdYCI2WgLEZNpok5pXo+OlLoA96dYlSB+7nFH
 NjABjCL3I/XNuIsQbkq2ZOBltpqN53dnw0w6gf+m5ItwC+hmIH8fcxtQSwryPjVTFuOpJiy/5IM
 gjdpgBw08L
X-Received: by 2002:a05:620a:458a:b0:945:c50d:569e with SMTP id
 af79cd13be357-9479f2e99efmr116374085a.36.1794256911126; 
 Mon, 09 Nov 2026 12:41:51 -0800 (PST)
X-Received: by 2002:a05:620a:458a:b0:945:c50d:569e with SMTP id
 af79cd13be357-9479f2e99efmr116368185a.36.1794256910482; 
 Mon, 09 Nov 2026 12:41:50 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04d9b70sm4624486d6.21.2026.11.09.12.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:41:50 -0800 (PST)
Message-ID: <ee5e02ce-73e6-452b-83c1-0529d0136842@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:41:46 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 32/38] target/riscv: rvv: Implement Zvfqwbdota8f
 instructions
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
 <20261104194155.679241-33-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-33-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX/18R81dhLfgv
 90VHvjeLKsv6EGp539iUsmykrOXafJNZl+axTK2TgJUn7e3LTBpYJRbUJY3tkxn8DxfXK+OGt/O
 ttDl3xX8Vgju2h8pu7KYZeHNWKxRt0nDy6N0a+fZQjqIPAioCjQwm3jGvY5um9FBGNLDS1DS7e/
 kwuLN61f24maSPx8xYaz3/BZAR8Gn3RynHtarbTljQFtirApyRzDNiXHdSKpJrF3WVyHzdwINVB
 ZoJ7/FTBnx++iBrsoGBb3+5fIZIA+c+AZTsiNaAcTCaBBzQNsa3j9GASbwZkoMe2l1cvx1n7zyv
 nEKOng9STEFCqR5dfuEnk6knWjhueWHjdNuRbwEGOxrPzS9d4JHj0QXgCYRJl9TXmjINg46okWE
 UlyOpbablrStj+xBcjDZExI4Vq1orNTKGJKBvPFJMagbe6GTAoK3IQJ3/1ZPJRrrSRlJVIF1GCW
 EYo/XZ6UIOf1eL+Wd8A==
X-Proofpoint-GUID: w4rctoZz3q4XTreNcPahs2i6sq9HbW1D
X-Proofpoint-ORIG-GUID: w4rctoZz3q4XTreNcPahs2i6sq9HbW1D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX50ROkmd3WeUo
 RisErGZLVySrvLfZRw0bZqfGVn+2FfBkxKKfEkpMWlD4o5QyyoGqBdFxBUW0C1P/ZGnXTB/pnOd
 ws2WcZufbfQwUU32a5V6sriyW7M3X8E=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af23010 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=lJZNAZFkayBBf_mOynUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090082
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Support the Zvfqwbdota8f OCP FP8 batched dot-product instructions.
> These instructions perform 8 parallel dot products between OCP FP8 vectors,
> accumulating into FP32 elements.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/helper.h                       |  4 ++
>   target/riscv/insn32.decode                  |  4 ++
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 13 ++++
>   target/riscv/tcg/vector_helper.c            | 69 +++++++++++++++++++++
>   4 files changed, 90 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 1f2dfd6d557..a257436fb31 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1398,6 +1398,10 @@ DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>   /* Zvfwbdota16bf - BF16 Batched Dot Product */
>   DEF_HELPER_7(vfwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
>   
> +/* Zvfqwbdota8f - OCP FP8 Batched Dot Product */
> +DEF_HELPER_7(vfqwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +DEF_HELPER_7(vfqwbdota_alt_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
> +
>   /* Zvfqwdota8f - OCP FP8 Dot Product */
>   DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>   DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 00ed64b73fd..48597915f7b 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1108,6 +1108,10 @@ vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
>   # *** Zvfwbdota16bf BF16 Batched Dot-Product Extension ***
>   vfwbdota_vv 101100 . ..... ..... 001 ..... 1110111 @r_vm
>   
> +# *** Zvfqwbdota8f OCP FP8 Batched Dot-Product Extension ***
> +vfqwbdota_vv     101110 . ..... ..... 001 ..... 1110111 @r_vm
> +vfqwbdota_alt_vv 101111 . ..... ..... 001 ..... 1110111 @r_vm
> +
>   # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
>   vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
>   vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index d4678171ac5..50f0f67ea60 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4417,3 +4417,16 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr * a)                 \
>   }
>   
>   GEN_ZVBDOTA_FP_TRANS(vfwbdota_vv, vext_vfwbdota_check, MO_32)
> +
> +/* Zvfqwbdota8f OCP FP8 Batched Dot-Product Extension */
> +static bool vext_vfqwbdota_check(DisasContext *s, arg_rmrr * a)
> +{
> +    int32_t sew = s->sew;
> +    int32_t vd_eew = sew + 2;
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvbdota_base_check(s, a, vd_eew) &&
> +           (s->cfg_ptr->ext_zvfqwbdota8f && sew == MO_8);
> +}
> +
> +GEN_ZVBDOTA_FP_TRANS(vfqwbdota_vv, vext_vfqwbdota_check, MO_32)
> +GEN_ZVBDOTA_FP_TRANS(vfqwbdota_alt_vv, vext_vfqwbdota_check, MO_32)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 6f3b666784e..e641e21d088 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6258,3 +6258,72 @@ void HELPER(vfwbdota_vv)(void *vd, void *v0, void *vs1, void *vs2, uint32_t ci,
>           }
>       }
>   }
> +
> +/*
> + * Zvfqwdota8f: OCP FP8 Dot Product with Accumulation
> + */
> +#define GEN_VEXT_ZVBDOTA_FP8(NAME, TYPE_VS2)                             \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
> +                  uint32_t ci, CPURISCVState *env, uint32_t desc)        \
> +{                                                                        \
> +    uint32_t vm = vext_vm(desc);                                         \
> +    uint32_t vl = env->vl;                                               \
> +    uint32_t vta = vext_vta(desc);                                       \
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);                         \
> +    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;                          \
> +    uint32_t vd_emul = vext_lmul(desc);                                  \
> +    uint32_t total_elems = (vlenb << vd_emul) >> 2;                      \
> +    uint32_t vlmax = vlenb;                                              \
> +    uint32_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);             \
> +    uint32_t n, k;                                                       \
> +    uint8_t *a_vec, *b_vec;                                              \
> +    float32 acc, dot_result;                                             \
> +                                                                         \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                                    \
> +                                                                         \
> +    a_vec = g_new0(uint8_t, vlmax);                                      \
> +    b_vec = g_new0(uint8_t, vlmax);                                      \
> +                                                                         \
> +    FloatExceptionFlags pre_fflag =                                      \
> +        get_float_exception_flags(&env->fp_status);                      \
> +    for (n = 0; n < 8; n++) {                                            \
> +        if (!vm && !vext_elem_mask(v0, ci + n)) {                        \
> +            continue;                                                    \
> +        }                                                                \
> +                                                                         \
> +        for (k = 0; k < vl; k++) {                                       \
> +            a_vec[k] = *((uint8_t *)vs2 + n * vlmax + H1(k));            \
> +            b_vec[k] = *((uint8_t *)vs1 + H1(k));                        \
> +        }                                                                \
> +                                                                         \
> +        FloatSNaNRule pre_snan_rule = get_snan_rule(&env->fp_status);    \
> +        set_snan_rule(float_snan_never, &env->fp_status);                \
> +        if (altfmt == 0) {                                               \
> +            dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e4m3(      \
> +                    a_vec, b_vec, vlmax, &env->fp_status);               \
> +        } else {                                                         \
> +            dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e5m2(      \
> +                    a_vec, b_vec, vlmax, &env->fp_status);               \
> +        }                                                                \
> +        set_snan_rule(pre_snan_rule, &env->fp_status);                   \
> +                                                                         \
> +        acc = *((float32 *)vd + H4(ci + n));                             \
> +        *((float32 *)vd + H4(ci + n)) = rvbna_final_f32_add(             \
> +                dot_result, acc, &env->fp_status);                       \
> +    }                                                                    \
> +    riscv_cpu_check_fflags(env, pre_fflag);                              \
> +                                                                         \
> +    g_free(a_vec);                                                       \
> +    g_free(b_vec);                                                       \
> +                                                                         \
> +    env->vstart = 0;                                                     \
> +                                                                         \
> +    if (ci + 8 < total_elems) {                                          \
> +        if (vta_all_1s) {                                                \
> +            vext_set_elems_1s(vd, vta, (ci + 8) * 4, total_elems * 4);   \
> +        }                                                                \
> +    }                                                                    \
> +}
> +
> +GEN_VEXT_ZVBDOTA_FP8(vfqwbdota_vv, e4m3)
> +GEN_VEXT_ZVBDOTA_FP8(vfqwbdota_alt_vv, e5m2)


