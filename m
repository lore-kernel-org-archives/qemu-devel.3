Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D0CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHoTJ-0005F5-EV; Fri, 16 Oct 2026 16:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoTI-0005El-6B
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:24:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoTF-0000C8-Fi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:24:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJejCI3725225
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7u9eLG6Hv+wKV5SFhDuyLtwBl01mf8hmz0IMtsh9RsU=; b=MMv3Fe3SrINYiaLD
 oJFv9Wu0xEqbodkc7KpvQVWb0UROQU9HArQFq89FIZLnE3FQcxJCNnAq9QC7bNk+
 Zs8FgSkx7h473ofUy24z6kkpBn6tyo0QE49NbBGZfSqgw863fb0tg/NXsw5SfouZ
 Bo+8CG73hfEWtPpUY/pEh5/3UYCZIFCZeYJF3XqnptHKzFMoOBL2xf7y34RlzYIl
 vgW6wPM9HNcHgXMuJn5A2UBW1P3a/wNWnQoqwMs24n/Idco6D5rKozda5a/14jUO
 RehnWzeWkzPnROVkJOVyEAfqJ4cMxdjFicUYyoF+9sOhWDmdsLcF3FimjM9b9jZ0
 gZ+l/w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450we5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:24:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5338cfe567eso5761991cf.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792182243; x=1792787043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7u9eLG6Hv+wKV5SFhDuyLtwBl01mf8hmz0IMtsh9RsU=;
 b=fy7LZr/ZqGYIug1mqsprepwPUoahao8o6TQ3NpeovzFugNJbA1mckA5IJf23QCYXrB
 VRFivW6pB25FfCI6Dlj08S2j8uQt+RyJiq6Vcg2b1m7OMc6vlA7a4WC3AxVlnIdP1Gl7
 muwTmvNWUFlCPhxX3BOJTIn0aqfHbUQhTaIP8tHh3S6PzYQVIAPudiogIseXMw3uoYhE
 yE37eatIc4OM7UEgzsgWe6PqcWaZhxKdScAy9d9YWuZzDin9OTEtpm4UgkOMgDdgYu+o
 Cvkh0AFb9CnFT+YQP4IIdZ6ri0P9JuDN8xOoPuC41gAN7LuS/oghRvOVgLKQhpNG+L6R
 kPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792182243; x=1792787043;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7u9eLG6Hv+wKV5SFhDuyLtwBl01mf8hmz0IMtsh9RsU=;
 b=stlLnpZrZB6AwXx1Ept+S8MJHy58h3bZqo6+IPYLMbJtOC1a8o5rjB2FLyUonUszyf
 1F+HAOsBCZM265NzQewfSlqe5w01SdtmwIN5Lkm04lkmeZ1GSlJcpTgpsg97FFHBMMp8
 6BlWHHICmjYeP3Jz24D0E7lTKz7d7Wf9v1AkGkDNB/ndvagoNQjTvZCqho68yMg2eafZ
 bjd+KgtQXMuZWR37HbXsm/eU0rHwDHDNcrAW0JG8VRmYzBkT3UD5GzngTsVJeSJR9RRH
 oo4+FTkGYq8gzGuNcAVeyJA3ktxbHfaBDIr8z44mrn0ranm8YEByoZar+lds2ITjyJpT
 bYQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtjPDgJxDBIXsGipUQ+UBIeRyIlyor50KL3saBP335tSCsvQdD1c43cI+sXVoxTFD0fcBWRP18xGFZ@nongnu.org
X-Gm-Message-State: AFq9FYISP4JVASXbRiVJFnZ8ZuDDsOeUEH6CUbiHkEncbZUdpfVBFDYI
 hkoL8XmFytYFoJgDMRxtvKXkTAB0GqcSzQRUDp800ltjTSaq/UlFn2c1xn7/n/JX0pXr5C4o/SL
 i7NYP0rD3tnqLNQ3lmxJjRc9eEL74sHegQuLNsN1hu6P0pc1HE3lz0UhawJ4/Ay0jjA==
X-Gm-Gg: AYBFou0L47if0E7sp0jc2WnvHXRPyLo4d3C/uaBY81a+YqA00tlHcG31Bd604iklX8Y
 DApUj8LSDzywLwppaS115bvhnvSDcIMRJTP5hjSc2zbr5Cqyv9GbuGq5Hj0gkwtTNz+CBzjAiZg
 Qf78+ZRWx3w55rUpZJTu1HbJVXEZ96RjxV49Wj+b4+/DLVFOl10Qv/eaDltSVoIxrksFbMO4U3x
 +wKROqBwjP/zsBO9FaEPaBx7cazWJ5kgzH37qjoB7o8lh1HXnTrozWPC4+VzvNhJeJWRtdbkpSv
 SIFuKkOvxzqFXH+2gsT2qULVa7H1V2wFvU48GV/qdIvvwMuHAEYpp8sxWxjrsZ8HcdUWrk/w/XQ
 H5cyFdAHbFLyojiPMCm9AmEux+VDcqJazl0E=
X-Received: by 2002:a05:620a:288d:b0:939:c1d4:e2e1 with SMTP id
 af79cd13be357-93f29cc979fmr188789485a.25.1792182243061; 
 Fri, 16 Oct 2026 13:24:03 -0700 (PDT)
X-Received: by 2002:a05:620a:288d:b0:939:c1d4:e2e1 with SMTP id
 af79cd13be357-93f29cc979fmr188784285a.25.1792182242503; 
 Fri, 16 Oct 2026 13:24:02 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f1a0cf9absm296923585a.6.2026.10.16.13.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 13:24:01 -0700 (PDT)
Message-ID: <552f7cfb-2319-4cbf-b0c3-cef1d80076b2@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 17:23:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/riscv: prefix helpers conflicting with other
 arch
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016182751.264704-4-pierrick.bouvier@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016182751.264704-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HbqHcC6y6Z20car1i2qRevP1JEN4-Vtg
X-Proofpoint-GUID: HbqHcC6y6Z20car1i2qRevP1JEN4-Vtg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX1gxO/stdrs1p
 vnnnb3zX8mJGvUooj6D33UkmiG/d8tTKx9mZafvUTie8LKT3fe7ORRBnmpKicNnQxTEHCBHOw/e
 BQiMlP9RJlbbSZNDAXDRQBbNeVLky6B6xiO8mPakGDuJw0E4J3ylKjRolTdC5+kGOmeBIIUe2ya
 /KZwvxKlJdUTU60cslmN8WatMuXecNoHn773sHkO1ZSM8xPhVdEX7nYBhHwVmRlT96oenpqiqqE
 1yzX3fyjYl1UVlpRIoh3ohvQczSYorZGUWUrhp6BoB6KMZr6jHp6TilizKQaylcIUe3Dw7+dJGY
 /V8nblPHI6S/JEpHSLHv0BUzc54QmXfXtONz8i+ARhzzoZH5cXGY7KQu5Dh+ElgHOHHWo/PVp5M
 XpmPwsuFaDlWGOZrYPkGOs1U1sHICcTqKTivzb5bT3ZwK3cQqIWv7VRDBM2T+E70Y7IKS6+Cqi2
 mRHCjEldCa+r1ZQtAwg==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad287e4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=wAUiHKX5OPmSjsUu6kIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX3UN1qpbpNPBP
 HZ7roawRWwzzi7b/Bgo++b+67senFL0XHjKVnRuwIcKKX2aShwVUonVauKg7eiyQQONGsoekouA
 50VNoIBw4ZcnHJZ6r0AXeIoaQxBM8e0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 10/16/2026 3:27 PM, Pierrick Bouvier wrote:
> List of helpers:
> - fadd_s
> - fsub_s
> - fdiv_s
> - fsqrt_s
> - fadd_d
> - fsub_d
> - fdiv_d
> - fsqrt_d
> - crc32
> - crc32c
> - raise_exception
> - wfi
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/helper.h                         | 24 +++++++++----------
>   target/riscv/tcg/bitmanip_helper.c            |  4 ++--
>   target/riscv/tcg/fpu_helper.c                 | 16 ++++++-------
>   .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>   target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 +++----
>   target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 +++----
>   target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 ++--
>   .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
>   target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 ++--
>   target/riscv/tcg/op_helper.c                  |  4 ++--
>   target/riscv/tcg/translate.c                  |  4 ++--
>   11 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 372f1049726..6aae192112a 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1,5 +1,5 @@
>   /* Exceptions */
> -DEF_HELPER_2(raise_exception, noreturn, env, i32)
> +DEF_HELPER_2(riscv_raise_exception, noreturn, env, i32)
>   
>   /* Floating Point - rounding mode */
>   DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
> @@ -20,15 +20,15 @@ DEF_HELPER_FLAGS_4(fnmadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>   DEF_HELPER_FLAGS_4(fnmadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
>   
>   /* Floating Point - Single Precision */
> -DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
> -DEF_HELPER_FLAGS_3(fsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(riscv_fadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(riscv_fsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fmul_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
> -DEF_HELPER_FLAGS_3(fdiv_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(riscv_fdiv_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fmin_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fminm_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fmax_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fmaxm_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
> -DEF_HELPER_FLAGS_2(fsqrt_s, TCG_CALL_NO_RWG, i64, env, i64)
> +DEF_HELPER_FLAGS_2(riscv_fsqrt_s, TCG_CALL_NO_RWG, i64, env, i64)
>   DEF_HELPER_FLAGS_3(fle_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fleq_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
>   DEF_HELPER_FLAGS_3(flt_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
> @@ -47,17 +47,17 @@ DEF_HELPER_FLAGS_2(fround_s, TCG_CALL_NO_RWG_SE, i64, env, i64)
>   DEF_HELPER_FLAGS_2(froundnx_s, TCG_CALL_NO_RWG_SE, i64, env, i64)
>   
>   /* Floating Point - Double Precision */
> -DEF_HELPER_FLAGS_3(fadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
> -DEF_HELPER_FLAGS_3(fsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(riscv_fadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(riscv_fsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fmul_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
> -DEF_HELPER_FLAGS_3(fdiv_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(riscv_fdiv_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fmin_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fminm_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fmax_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fmaxm_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_2(fcvt_s_d, TCG_CALL_NO_RWG, i64, env, i64)
>   DEF_HELPER_FLAGS_2(fcvt_d_s, TCG_CALL_NO_RWG, i64, env, i64)
> -DEF_HELPER_FLAGS_2(fsqrt_d, TCG_CALL_NO_RWG, i64, env, i64)
> +DEF_HELPER_FLAGS_2(riscv_fsqrt_d, TCG_CALL_NO_RWG, i64, env, i64)
>   DEF_HELPER_FLAGS_3(fle_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
>   DEF_HELPER_FLAGS_3(fleq_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
>   DEF_HELPER_FLAGS_3(flt_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
> @@ -83,8 +83,8 @@ DEF_HELPER_FLAGS_1(unzip, TCG_CALL_NO_RWG_SE, tl, tl)
>   DEF_HELPER_FLAGS_1(zip, TCG_CALL_NO_RWG_SE, tl, tl)
>   DEF_HELPER_FLAGS_2(xperm4, TCG_CALL_NO_RWG_SE, tl, tl, tl)
>   DEF_HELPER_FLAGS_2(xperm8, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> -DEF_HELPER_FLAGS_2(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> -DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> +DEF_HELPER_FLAGS_2(riscv_crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> +DEF_HELPER_FLAGS_2(riscv_crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl)
>   
>   /* Floating Point - Half Precision */
>   DEF_HELPER_FLAGS_3(fadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
> @@ -135,7 +135,7 @@ DEF_HELPER_1(mret, tl, env)
>   DEF_HELPER_1(dret, tl, env)
>   DEF_HELPER_1(mnret, tl, env)
>   DEF_HELPER_1(ctr_clear, void, env)
> -DEF_HELPER_1(wfi, void, env)
> +DEF_HELPER_1(riscv_wfi, void, env)
>   DEF_HELPER_1(wrs_nto, void, env)
>   DEF_HELPER_1(tlb_flush, void, env)
>   DEF_HELPER_1(tlb_flush_all, void, env)
> diff --git a/target/riscv/tcg/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
> index d8d94bca7ba..5af3efe194d 100644
> --- a/target/riscv/tcg/bitmanip_helper.c
> +++ b/target/riscv/tcg/bitmanip_helper.c
> @@ -117,7 +117,7 @@ target_ulong HELPER(xperm8)(target_ulong rs1, target_ulong rs2)
>       return do_xperm(rs1, rs2, 3);
>   }
>   
> -target_ulong HELPER(crc32)(target_ulong rs1, target_ulong sz)
> +target_ulong HELPER(riscv_crc32)(target_ulong rs1, target_ulong sz)
>   {
>       for (target_ulong i = 0; i < sz; i++) {
>           rs1 = crc32_table[rs1 & 0xFF] ^ (rs1 >> 8);
> @@ -126,7 +126,7 @@ target_ulong HELPER(crc32)(target_ulong rs1, target_ulong sz)
>       return rs1;
>   }
>   
> -target_ulong HELPER(crc32c)(target_ulong rs1, target_ulong sz)
> +target_ulong HELPER(riscv_crc32c)(target_ulong rs1, target_ulong sz)
>   {
>       for (target_ulong i = 0; i < sz; i++) {
>           rs1 = crc32c_table[rs1 & 0xFF] ^ (rs1 >> 8);
> diff --git a/target/riscv/tcg/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
> index db1475271b6..85fc419eb95 100644
> --- a/target/riscv/tcg/fpu_helper.c
> +++ b/target/riscv/tcg/fpu_helper.c
> @@ -230,14 +230,14 @@ uint64_t helper_fnmadd_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
>                         float_muladd_negate_c | float_muladd_negate_product);
>   }
>   
> -uint64_t helper_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +uint64_t helper_riscv_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
>       float32 frs1 = check_nanbox_s(env, rs1);
>       float32 frs2 = check_nanbox_s(env, rs2);
>       return nanbox_s(env, float32_add(frs1, frs2, &env->fp_status));
>   }
>   
> -uint64_t helper_fsub_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +uint64_t helper_riscv_fsub_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
>       float32 frs1 = check_nanbox_s(env, rs1);
>       float32 frs2 = check_nanbox_s(env, rs2);
> @@ -251,7 +251,7 @@ uint64_t helper_fmul_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>       return nanbox_s(env, float32_mul(frs1, frs2, &env->fp_status));
>   }
>   
> -uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
> +uint64_t helper_riscv_fdiv_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>   {
>       float32 frs1 = check_nanbox_s(env, rs1);
>       float32 frs2 = check_nanbox_s(env, rs2);
> @@ -292,7 +292,7 @@ uint64_t helper_fmaxm_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
>       return nanbox_s(env, ret);
>   }
>   
> -uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t rs1)
> +uint64_t helper_riscv_fsqrt_s(CPURISCVState *env, uint64_t rs1)
>   {
>       float32 frs1 = check_nanbox_s(env, rs1);
>       return nanbox_s(env, float32_sqrt(frs1, &env->fp_status));
> @@ -434,12 +434,12 @@ uint64_t helper_froundnx_s(CPURISCVState *env, uint64_t rs1)
>       return nanbox_s(env, frs1);
>   }
>   
> -uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_riscv_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
>       return float64_add(frs1, frs2, &env->fp_status);
>   }
>   
> -uint64_t helper_fsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_riscv_fsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
>       return float64_sub(frs1, frs2, &env->fp_status);
>   }
> @@ -449,7 +449,7 @@ uint64_t helper_fmul_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>       return float64_mul(frs1, frs2, &env->fp_status);
>   }
>   
> -uint64_t helper_fdiv_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +uint64_t helper_riscv_fdiv_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
>   {
>       return float64_div(frs1, frs2, &env->fp_status);
>   }
> @@ -489,7 +489,7 @@ uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
>       return float32_to_float64(frs1, &env->fp_status);
>   }
>   
> -uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
> +uint64_t helper_riscv_fsqrt_d(CPURISCVState *env, uint64_t frs1)
>   {
>       return float64_sqrt(frs1, &env->fp_status);
>   }
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index e22df6fbe71..4f18b6c3fa4 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -168,7 +168,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>   #ifndef CONFIG_USER_ONLY
>       decode_save_opc(ctx, 0);
>       gen_update_pc(ctx, ctx->cur_insn_len);
> -    gen_helper_wfi(tcg_env);
> +    gen_helper_riscv_wfi(tcg_env);
>       ctx->base.is_jmp = DISAS_NORETURN;
>       return true;
>   #else
> diff --git a/target/riscv/tcg/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
> index 1be2bee9465..596a4ad888e 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
> @@ -194,7 +194,7 @@ static bool trans_fadd_d(DisasContext *ctx, arg_fadd_d *a)
>       TCGv_i64 src2 = get_fpr_d(ctx, a->rs2);
>   
>       gen_set_rm(ctx, a->rm);
> -    gen_helper_fadd_d(dest, tcg_env, src1, src2);
> +    gen_helper_riscv_fadd_d(dest, tcg_env, src1, src2);
>       gen_set_fpr_d(ctx, a->rd, dest);
>       mark_fs_dirty(ctx);
>       return true;
> @@ -211,7 +211,7 @@ static bool trans_fsub_d(DisasContext *ctx, arg_fsub_d *a)
>       TCGv_i64 src2 = get_fpr_d(ctx, a->rs2);
>   
>       gen_set_rm(ctx, a->rm);
> -    gen_helper_fsub_d(dest, tcg_env, src1, src2);
> +    gen_helper_riscv_fsub_d(dest, tcg_env, src1, src2);
>       gen_set_fpr_d(ctx, a->rd, dest);
>       mark_fs_dirty(ctx);
>       return true;
> @@ -245,7 +245,7 @@ static bool trans_fdiv_d(DisasContext *ctx, arg_fdiv_d *a)
>       TCGv_i64 src2 = get_fpr_d(ctx, a->rs2);
>   
>       gen_set_rm(ctx, a->rm);
> -    gen_helper_fdiv_d(dest, tcg_env, src1, src2);
> +    gen_helper_riscv_fdiv_d(dest, tcg_env, src1, src2);
>       gen_set_fpr_d(ctx, a->rd, dest);
>       mark_fs_dirty(ctx);
>       return true;
> @@ -261,7 +261,7 @@ static bool trans_fsqrt_d(DisasContext *ctx, arg_fsqrt_d *a)
>       TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
>   
>       gen_set_rm(ctx, a->rm);
> -    gen_helper_fsqrt_d(dest, tcg_env, src1);
> +    gen_helper_riscv_fsqrt_d(dest, tcg_env, src1);
>       gen_set_fpr_d(ctx, a->rd, dest);
>       mark_fs_dirty(ctx);
>       return true;
> diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> index 636dec1664d..551c9b39861 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
> @@ -178,7 +178,7 @@ static bool trans_fadd_s(DisasContext *ctx, arg_fadd_s *a)
>       TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
>   
>       gen_set_rm(ctx, a->rm);
> -    gen_helper_fadd_s(dest, tcg_env, src1, src2);
> +    gen_helper_riscv_fadd_s(dest, tcg_env, src1, src2);
>       gen_set_fpr_hs(ctx, a->rd, dest);
>       mark_fs_dirty(ctx);
>       return true;
> @@ -194,7 +194,7 @@ static bool trans_fsub_s(DisasContext *ctx, arg_fsub_s *a)
>       TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
>   
>       gen_set_rm(ctx, a->rm);
> -    gen_helper_fsub_s(dest, tcg_env, src1, src2);
> +    gen_helper_riscv_fsub_s(dest, tcg_env, src1, src2);
>       gen_set_fpr_hs(ctx, a->rd, dest);
>       mark_fs_dirty(ctx);
>       return true;
> @@ -226,7 +226,7 @@ static bool trans_fdiv_s(DisasContext *ctx, arg_fdiv_s *a)
>       TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
>   
>       gen_set_rm(ctx, a->rm);
> -    gen_helper_fdiv_s(dest, tcg_env, src1, src2);
> +    gen_helper_riscv_fdiv_s(dest, tcg_env, src1, src2);
>       gen_set_fpr_hs(ctx, a->rd, dest);
>       mark_fs_dirty(ctx);
>       return true;
> @@ -241,7 +241,7 @@ static bool trans_fsqrt_s(DisasContext *ctx, arg_fsqrt_s *a)
>       TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
>   
>       gen_set_rm(ctx, a->rm);
> -    gen_helper_fsqrt_s(dest, tcg_env, src1);
> +    gen_helper_riscv_fsqrt_s(dest, tcg_env, src1);
>       gen_set_fpr_hs(ctx, a->rd, dest);
>       mark_fs_dirty(ctx);
>       return true;
> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> index cc1b5dbbadc..8d63efe09b5 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> @@ -55,7 +55,7 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>            */
>           tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
>                           tcg_env, offsetof(CPURISCVState, sw_check_code));
> -        gen_helper_raise_exception(tcg_env,
> +        gen_helper_riscv_raise_exception(tcg_env,
>                         tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>           return true;
>       }
> @@ -68,7 +68,7 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>           tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
>           tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
>                           tcg_env, offsetof(CPURISCVState, sw_check_code));
> -        gen_helper_raise_exception(tcg_env,
> +        gen_helper_riscv_raise_exception(tcg_env,
>                         tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>           gen_set_label(skip);
>       }
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> index d47a9f9c7d2..0556f37805a 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> @@ -43,7 +43,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>       tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
>       tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
>                       tcg_env, offsetof(CPURISCVState, sw_check_code));
> -    gen_helper_raise_exception(tcg_env,
> +    gen_helper_riscv_raise_exception(tcg_env,
>                     tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>       gen_set_label(skip);
>       tcg_gen_addi_tl(addr, addr, tmp);
> diff --git a/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
> index 01da2b6ce1d..795231f0839 100644
> --- a/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
> @@ -29,11 +29,11 @@ static bool gen_crc(DisasContext *ctx, arg_r2 *a,
>   #define TRANS_CRC32(NAME, SIZE) \
>       static bool trans_crc32_##NAME(DisasContext *ctx, arg_r2 *a) \
>       { if (SIZE == 8) { REQUIRE_64BIT(ctx); }; \
> -      return gen_crc(ctx, a, gen_helper_crc32, tcg_constant_tl(SIZE)); }
> +      return gen_crc(ctx, a, gen_helper_riscv_crc32, tcg_constant_tl(SIZE)); }
>   #define TRANS_CRC32C(NAME, SIZE) \
>       static bool trans_crc32c_##NAME(DisasContext *ctx, arg_r2 *a) \
>       { if (SIZE == 8) { REQUIRE_64BIT(ctx); }; \
> -      return gen_crc(ctx, a, gen_helper_crc32c, tcg_constant_tl(SIZE)); }
> +      return gen_crc(ctx, a, gen_helper_riscv_crc32c, tcg_constant_tl(SIZE)); }
>   
>   TRANS_CRC32(b, 1);
>   TRANS_CRC32(h, 2);
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index b8b3e43ccd5..3df01016dfa 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -48,7 +48,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>       cpu_loop_exit_restore(cs, pc);
>   }
>   
> -void helper_raise_exception(CPURISCVState *env, uint32_t exception)
> +void helper_riscv_raise_exception(CPURISCVState *env, uint32_t exception)
>   {
>   #ifndef CONFIG_USER_ONLY
>       riscv_pmu_decr_instret(env);
> @@ -625,7 +625,7 @@ void helper_ctr_clear(CPURISCVState *env)
>       riscv_ctr_clear(env);
>   }
>   
> -void helper_wfi(CPURISCVState *env)
> +void helper_riscv_wfi(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);
>       bool rvs = riscv_has_ext(env, RVS);
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index ede9c2563f7..2ffbf26bb19 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -259,7 +259,7 @@ static void gen_update_pc(DisasContext *ctx, target_long diff)
>   static void generate_exception(DisasContext *ctx, RISCVException excp)
>   {
>       gen_update_pc(ctx, 0);
> -    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
> +    gen_helper_riscv_raise_exception(tcg_env, tcg_constant_i32(excp));
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
>   
> @@ -1407,7 +1407,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>           tcg_ctx->emit_before_op = QTAILQ_NEXT(ctx->base.insn_start, link);
>           tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
>                           tcg_env, offsetof(CPURISCVState, sw_check_code));
> -        gen_helper_raise_exception(tcg_env,
> +        gen_helper_riscv_raise_exception(tcg_env,
>                         tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>           tcg_ctx->emit_before_op = NULL;
>           ctx->base.is_jmp = DISAS_NORETURN;


