Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE2CC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQWs-0003MY-KQ; Mon, 27 Jul 2026 14:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1woQWq-0003MH-3f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:58:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1woQWn-0006Mu-Lg
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 14:58:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RICArL452366
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 18:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oysyL9HgIpVDxw+SeQ+i4Xn87mnWI40/g3hVJs3HprE=; b=K82UAwdErTGDcttZ
 yW6QOf1pmxiIu8vzhVZASlkMsHUOpGFbni6sEP3U2gk4OHfZ+PbJcnjVr5qXkdkQ
 UOm/M7NrM/iHu1PQLXs9jxu4vdJndDmTMe5KLmW64wOrRpS4i0gdxAK/QwvnZ9wN
 kEAcZDJnN0qNxjlvf8ZUXdUniUCbtN7wNSznscK4/WRVxzJkLsXn6c8ytwqxHXD4
 aZ+OEz7Mz5L5XC5NdvnzyeyQYRnOQ55R7uyiezFabTfH0t55zUxPv16q5OGjcFai
 CYN3kqMBgFwEGzfxIohSe587ZrGKhiebCXdfaMUwImjgFtM8z7HbhqTpPNRbAyHo
 4NnIiw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrsrcnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 18:58:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-904ee4473a8so38328526d6.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785178694; x=1785783494; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oysyL9HgIpVDxw+SeQ+i4Xn87mnWI40/g3hVJs3HprE=;
 b=VqAScbxSSgyxB/bs39jsH18pb4zmv9x9Oz/c+g/kSYetZLNN3PiNmAofz/QVLz1yUW
 Jt+ZCf1Qi8CFkVlAq8yp7TMfyQi5GTH3D7qUpy1vgAJWSeciUZs/gi71UY4GSOZ7AR6o
 QrNrOF9mWwUNHZ+ftfakzo194C0REi96/g/kQcTtqxmD9lSRPOGHrqOaUG5+zQvihLJ8
 IGvTJ0Uddu2h6hOdKOP13gonqsGhYDKcUIGe3+s9Jl8Up/FvnrtepcFTkbiJ8HKPqUBI
 bfyt9CEEM58wex8fOHFTuJaafusxgLcX/JSYByqia+Cj1U9dpvwr1HkCyevJnT7dqB7S
 KWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785178694; x=1785783494;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oysyL9HgIpVDxw+SeQ+i4Xn87mnWI40/g3hVJs3HprE=;
 b=PURjKDS9ylL5ADQjZoPMRaFCJZN/mgO1aKc1R6Rr94f/YPamyNrseIfxbu1r/rVqAh
 A74CB5qEE+ZBUJD5j4FlN865ES8gFjeiuXMhmQEW6CydqknrLVde6/puTw63tYbGgpQj
 xrXboTYB6Z32ym7njIqh/9QlUgxm2TgBw7Lx2NIrl3Ry3UNiiKwjoXytkXHatRHswqJT
 4L9IJOaT/i0PGsInGmM3p/Ni/BD9stW5qwp/ohe02Xk6wTs8tniXAWU3JlBysXAWIYPQ
 kxSfqPreVvhlZA6/tlcWyXRatnGspforD+7TeNw6AX/W90eYExiezkMqRwuBu+9HNbMg
 TBPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUtI+M0j4eZM8TIxMsu9gQYURlDRcmuCC+TP8J/xsoSsJtyMQ4aoaLFlXmTxl0HlXumkGLBwPD5rom@nongnu.org
X-Gm-Message-State: AOJu0Yy36URgumRvA6oAWZqR8LK8wrwvTfc1Zne6AK7KSp2vyYv1iqJE
 4uLvLbOnCnetR8dbtvsw+seHT93YXa3p9oaKDoaPTpxIxTOFQD7IQTclmgQSD/ZPAbdiJyGzVIW
 /2hrz6tWIZZ8eqSeMGkrkN9GGopevBrF3//0QP2eb2t82GiSvNMpA0+qDlg==
X-Gm-Gg: AR+sD125vGMsUDWDxYRk9k9I+WMkevky9iuHoSdtom3ANF/ctmhaVrVD49RQ/QCGF56
 D57pBdp2XAZtlbAVr/8yu5ph0qJYSAZnmWaE/ZmX27v50o4Tvxyt/6LUS6CM5XnqNaRj4aajXei
 mbh8J63J1N0f7sZEbwhcwhAgwUEEWEZXvYqcppkJ0CrX+4j1DWstYV+lFJuDO2w/JSzS8VHcRes
 lwo4yiASGvutN95dUOdmDo1bAFxv2EkVYoxJ+AJSSPgd0UfF+ceomnw+ji8K4kzq9Swq7zInLvw
 sMJs3ZDQ7LeOjiMs9Lu242E3RemFTWdm1qh71YxiyC/3/ct4oP0IFA0JyY8oH2tAN7nBYog7uA+
 JGJB7aLbmJ+ej66uh+V+qBsIav5iuo8x21UMXuw==
X-Received: by 2002:a05:620a:46a6:b0:92e:dfa8:c0f7 with SMTP id
 af79cd13be357-932fe404251mr53955785a.91.1785178694117; 
 Mon, 27 Jul 2026 11:58:14 -0700 (PDT)
X-Received: by 2002:a05:620a:46a6:b0:92e:dfa8:c0f7 with SMTP id
 af79cd13be357-932fe404251mr53951985a.91.1785178693584; 
 Mon, 27 Jul 2026 11:58:13 -0700 (PDT)
Received: from [192.168.68.104] ([191.202.238.134])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de55ddf8sm677711885a.20.2026.07.27.11.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 11:58:13 -0700 (PDT)
Message-ID: <83c56e5a-267a-4cf6-bf08-59355c686ce7@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 15:58:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] target/riscv: Add packed SIMD averaging and
 rounding instructions
To: Molly Chen <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <d6d31bfcc7d3490b8fdf5dc5c7d0e2c4480a16f9.1784280142.git.xiaoou@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d6d31bfcc7d3490b8fdf5dc5c7d0e2c4480a16f9.1784280142.git.xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3NSBTYWx0ZWRfXxsxktgaMAiUy
 zb25MbsB6HufZ14ts+7odMVw7Xjqcv7wPUwCq5ZBTpXn7RKbwd1BNK1+4yzNgs2ivHjAfxK6PkN
 FwxvDka/NTEjdeK2tTTulzBfctT1rgUtCZnD7C6rNB0rBFzjVZ6eNv5w14GlzNMfYCi9x+GEsaj
 g6aGb3BNfXofKe0Rr6LCirTX6qjrq0n+6YBojPcB/pkSp9cPqaeDE85wBVdlPDEyPYZVrIdUP5S
 iJ1P9NjgSi9XdMiNMZ3mDtQcF9v5wFYLWJ5sO8/ThGbcFl53RwCFg29LSJevKJXcl6h8plJO7cr
 gY7+nrX7cSe0R1Iz+HrPDKN82JNqMAZ42VkFTfvhxYS+a5aYfi0xXi/uu98haNhk5vcymxwrPua
 8+yQ8XQj0REcQAdXaQuiMX5UHC2Qp9gEZhz6W7tOx5GdL+T/3epQC0xApGobkssMplZxiKZc20q
 0uAISOSr3TQ0TcZJAxw==
X-Proofpoint-ORIG-GUID: YPHvKWiKUGgeBeQUPOyOTvvIvpN1QNOl
X-Proofpoint-GUID: YPHvKWiKUGgeBeQUPOyOTvvIvpN1QNOl
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a67aa46 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=krItrnN2KmZux9Htc+7Wjw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=w-l5qcP0kjA8xuI_VaQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3NSBTYWx0ZWRfXyU5zancd9wdg
 v85mpJ7zO4Af033OuLyRoGUA/VZ2HcIBgVzAWWUpC65zCM9R4fVQpa8YanHWgSXKALwB+jnqzTY
 hxXcf12vxqDqP6U2wUj16xddNTlrKP0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270175
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



On 7/17/2026 7:06 AM, Molly Chen wrote:
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/helper.h                       | 18 ++++++++++
>   target/riscv/insn32.decode                  | 26 ++++++++++++++
>   target/riscv/tcg/insn_trans/trans_rvp.c.inc | 18 ++++++++++
>   target/riscv/tcg/psimd_helper.c             | 40 +++++++++++++++++++++
>   4 files changed, 102 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index eebb2febd95..7256f776ae6 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1399,3 +1399,21 @@ DEF_HELPER_3(sati_32, i32, env, i32, i32)
>   DEF_HELPER_3(usati_32, i32, env, i32, i32)
>   DEF_HELPER_3(sati_64, i64, env, i64, i64)
>   DEF_HELPER_3(usati_64, i64, env, i64, i64)
> +
> +/* Packed SIMD - Averaging and Rounding Operations */
> +DEF_HELPER_3(paadd_b, tl, env, tl, tl)
> +DEF_HELPER_3(paadd_h, tl, env, tl, tl)
> +DEF_HELPER_3(paadd_w, i64, env, i64, i64)
> +DEF_HELPER_3(paaddu_b, tl, env, tl, tl)
> +DEF_HELPER_3(paaddu_h, tl, env, tl, tl)
> +DEF_HELPER_3(paaddu_w, i64, env, i64, i64)
> +DEF_HELPER_3(aadd, i32, env, i32, i32)
> +DEF_HELPER_3(aaddu, i32, env, i32, i32)
> +DEF_HELPER_3(pasub_b, tl, env, tl, tl)
> +DEF_HELPER_3(pasub_h, tl, env, tl, tl)
> +DEF_HELPER_3(pasub_w, i64, env, i64, i64)
> +DEF_HELPER_3(pasubu_b, tl, env, tl, tl)
> +DEF_HELPER_3(pasubu_h, tl, env, tl, tl)
> +DEF_HELPER_3(pasubu_w, i64, env, i64, i64)
> +DEF_HELPER_3(asub, i32, env, i32, i32)
> +DEF_HELPER_3(asubu, i32, env, i32, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 8da13669d73..005cc055b8a 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1147,3 +1147,29 @@ pusati_h   10100 001.... ..... 100 ..... 0011011 @p_ui16
>   }
>   sati_64    111001 ...... ..... 100 ..... 0011011 @p_ui64
>   usati_64   101001 ...... ..... 100 ..... 0011011 @p_ui64
> +
> +# Packed SIMD - Averaging and Rounding Operations
> +paadd_b    1001110 ..... ..... 000 ..... 0111011 @r
> +paadd_h    1001100 ..... ..... 000 ..... 0111011 @r
> +{
> +  aadd     1001101 ..... ..... 000 ..... 0111011 @r
> +  paadd_w  1001101 ..... ..... 000 ..... 0111011 @r
> +}
> +paaddu_b   1011110 ..... ..... 000 ..... 0111011 @r
> +paaddu_h   1011100 ..... ..... 000 ..... 0111011 @r
> +{
> +  aaddu    1011101 ..... ..... 000 ..... 0111011 @r
> +  paaddu_w 1011101 ..... ..... 000 ..... 0111011 @r
> +}
> +pasub_b    1101110 ..... ..... 000 ..... 0111011 @r
> +pasub_h    1101100 ..... ..... 000 ..... 0111011 @r
> +{
> +  asub     1101101 ..... ..... 000 ..... 0111011 @r
> +  pasub_w  1101101 ..... ..... 000 ..... 0111011 @r
> +}
> +pasubu_b   1111110 ..... ..... 000 ..... 0111011 @r
> +pasubu_h   1111100 ..... ..... 000 ..... 0111011 @r
> +{
> +  asubu    1111101 ..... ..... 000 ..... 0111011 @r
> +  pasubu_w 1111101 ..... ..... 000 ..... 0111011 @r
> +}
> diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> index 056ccfb486e..43c59aef182 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> @@ -545,3 +545,21 @@ GEN_SIMD_TRANS_IMM_32_VXSAT(usati_32)
>   GEN_SIMD_TRANS_IMM_64_VXSAT(sati_64)
>   GEN_SIMD_TRANS_IMM_64_VXSAT(usati_64)
>   
> +/* Packed SIMD - Averaging and Rounding Operations */
> +GEN_SIMD_TRANS(paadd_b)
> +GEN_SIMD_TRANS(paadd_h)
> +GEN_SIMD_TRANS_64(paadd_w)
> +GEN_SIMD_TRANS(paaddu_b)
> +GEN_SIMD_TRANS(paaddu_h)
> +GEN_SIMD_TRANS_64(paaddu_w)
> +GEN_SIMD_TRANS_32(aadd)
> +GEN_SIMD_TRANS_32(aaddu)
> +GEN_SIMD_TRANS(pasub_b)
> +GEN_SIMD_TRANS(pasub_h)
> +GEN_SIMD_TRANS_64(pasub_w)
> +GEN_SIMD_TRANS(pasubu_b)
> +GEN_SIMD_TRANS(pasubu_h)
> +GEN_SIMD_TRANS_64(pasubu_w)
> +GEN_SIMD_TRANS_32(asub)
> +GEN_SIMD_TRANS_32(asubu)
> +
> diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
> index 52c58e0287e..162041a8f18 100644
> --- a/target/riscv/tcg/psimd_helper.c
> +++ b/target/riscv/tcg/psimd_helper.c
> @@ -1768,3 +1768,43 @@ GEN_PSIMD_SATI(sati_64, uint64_t, int64_t, int64_t,
>   GEN_PSIMD_USATI(usati_64, uint64_t, int64_t, uint64_t, uint64_t,
>                   EXTRACT64, INSERT64, ELEMS_D, 1ULL)
>   
> +/* Averaging Operations (non-saturating) */
> +
> +GEN_PSIMD_AVG_BINOP(paadd_b, target_ulong, int8_t, int16_t,
> +                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
> +GEN_PSIMD_AVG_BINOP(paadd_h, target_ulong, int16_t, int32_t,
> +                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
> +GEN_PSIMD_AVG_BINOP(paadd_w, uint64_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
> +
> +GEN_PSIMD_AVG_BINOP(paaddu_b, target_ulong, uint8_t, uint16_t,
> +                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
> +GEN_PSIMD_AVG_BINOP(paaddu_h, target_ulong, uint16_t, uint32_t,
> +                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
> +GEN_PSIMD_AVG_BINOP(paaddu_w, uint64_t, uint32_t, uint64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
> +
> +GEN_PSIMD_AVG_BINOP(aadd, uint32_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
> +GEN_PSIMD_AVG_BINOP(aaddu, uint32_t, uint32_t, uint64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
> +
> +GEN_PSIMD_AVG_BINOP(pasub_b, target_ulong, int8_t, int16_t,
> +                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB)
> +GEN_PSIMD_AVG_BINOP(pasub_h, target_ulong, int16_t, int32_t,
> +                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB)
> +GEN_PSIMD_AVG_BINOP(pasub_w, uint64_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
> +
> +GEN_PSIMD_AVG_BINOP(pasubu_b, target_ulong, uint8_t, uint16_t,
> +                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB)
> +GEN_PSIMD_AVG_BINOP(pasubu_h, target_ulong, uint16_t, uint32_t,
> +                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB)
> +GEN_PSIMD_AVG_BINOP(pasubu_w, uint64_t, uint32_t, uint64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
> +
> +GEN_PSIMD_AVG_BINOP(asub, uint32_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
> +GEN_PSIMD_AVG_BINOP(asubu, uint32_t, uint32_t, uint64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
> +


