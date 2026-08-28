Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E5DC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzuqn-0006gG-8C; Fri, 28 Aug 2026 07:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzuql-0006fe-99
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 07:34:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzuqh-00013s-Qb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 07:34:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA88Qr2596125
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JGW4RgfEY7Ln5iUSNEPtUtMax4LL2q+BpytSc/Gpy3U=; b=dpLG4jqTRKrkz1Lt
 zkoLqzSUdncEtPPCdqhhMQb9LKpIDQ1VQTJUDV8s39nWGu3VkW5LA0cmfSoCqekf
 FH8GEBa/5uCCw6qYRUVsbMe2b+MqlK1iYFZEwbutcp+4/M2sjqh+mExeKZzrOfqh
 XDhv1NJZzswQF/ieLbl09LN9M6JntKbZ0IpMpQCPkgPdOhEaQ4r29QcL1wyV1za0
 a54xOnBKs0/Ue8Ai79kI460r1eu+OikpIt1fkyQ0jRBwLLth88nEdHbrLZNiBn+m
 QD+FfJraLMt6yOgdFKqS4M1PdWBK5gmj5w+IoOC8QmtRs61jUdOUoTMEhTcRABeA
 rTydxQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb1v3a046-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:34:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9390126581fso77103185a.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787916857; x=1788521657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JGW4RgfEY7Ln5iUSNEPtUtMax4LL2q+BpytSc/Gpy3U=;
 b=OPyuU88HhskxnpP5WkCEg6mlzdsv0ETs6PP2W+7kEuhuUWvbGj4u7Tde73Ds5csBiO
 c5km6p/1Qqq/MPEK3iWYB22IMv+zjDOawIoPlAmQ1GsRqzL/Sz9EwxwQRG7N8E79rs3p
 txHx03D1Qypf0ehXINNQJNoRbawIPDLgE7pRE9W5ZsQydLn9LZdPf+X17bVcmrrHAUK2
 0kXFRgRFPAP6Gj3lX7wl0sRnMjfj3sMhvEzWJDmWnCQ5tuTNOfjENSWXjyBxpyZty/CN
 cnFfzPgy7PWgyy7Fq5JJclnAHdb+vT1v7cTwrGr/9Jq3/3RXBT7U1SATUTd5fYM6LBhz
 i7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916857; x=1788521657;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JGW4RgfEY7Ln5iUSNEPtUtMax4LL2q+BpytSc/Gpy3U=;
 b=URvBrTChmT9gVxKEv0s6mWT7Vy93cG5od9sR2FTTETo+Uk6sbvue7uKKRH9u6896iJ
 U2g4t7QUuzELmVLbBy5jxBbh5zJ0NZs2PHu4gq41igqCUqKQlKwR3rcrLCIVrikaNwGs
 CP9azukeGutS7Sm0EzfI2wCh9uO0vUnhzq4YNbSq8QVyX8yqefwhkc6nb12C7jygTAxw
 xdnBf4M4NVHapo63VBKV3LZg2PTe/zd/nnFdAESUngrBr2lcuVSB6WksixTsUTc2OKpx
 TE3Nn5w8nGNxhmceo+8UOjTujV3rOMfHuyScSttBhDfMPqPBMWxDSyacxHLXg2Jtnqut
 oXmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCPzNbZWwUu+9CBx0SUZbPwL+ZFe/7z5efQfPYx61TZhPVM2IoziUYkySZXEV24REnkaI+OHXv9TTE@nongnu.org
X-Gm-Message-State: AFuF++ka7PtBwAL5JFyjneDrnGrk60dFXTG1zg39iBuBtUJoep4Vy5Ww
 0LGs4KN4NyfAHUHIMWKoiv5VBEy1Re8eIRQyhRql/g/h+5xuB1yjJS7DMw1cUIc3Hwzd+njwb2s
 b9NWHxHBqbhs0tvpUFiKhksG9FtlTJBA+TsXR82m4ZBy1GrsjgDd+d8mbww==
X-Gm-Gg: AR+sD11Bm8FO/uzvI0agWDuKyzMTHihfiXWajpHDJ1sP0PQSosntHI6bxbL6ujuMsfm
 xDp86BOyxnBsJ3MhUKzgT2XHTxLD5aYdqkKT5JmxJEwli5EugZTDJGRLADqiF8ZL33qZBGFZplB
 ipGN17lKVJhNEcpTQ7oUDgBY4rciCesUPKT89Dk0RP0B/LBtVs1YYaayEvCroSDXWWuhaH1qK9g
 ID1ijopgdZfWwWD6ZyLF21SY4C5GLzBfrnL5yjff/B9Up2w6e5paq4+TDI6x7uFk6EhpJoUUuM6
 RlHBLXxIYle0hPbTq44F/Z9yjl0vvn78OCztRTJzpfK1yStj/vjgbdKAvar4fu2DwAJqJjiblC4
 AXjH/sUDOT3Xhj1hJmUVzeFbifIwoqztiKy0D
X-Received: by 2002:a05:620a:8003:b0:936:cd74:4f45 with SMTP id
 af79cd13be357-9391391b3f0mr610131985a.37.1787916857209; 
 Fri, 28 Aug 2026 04:34:17 -0700 (PDT)
X-Received: by 2002:a05:620a:8003:b0:936:cd74:4f45 with SMTP id
 af79cd13be357-9391391b3f0mr610122885a.37.1787916856389; 
 Fri, 28 Aug 2026 04:34:16 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917016ed4sm123413685a.9.2026.08.28.04.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 04:34:15 -0700 (PDT)
Message-ID: <11e5ab2c-b87e-4033-a424-028e42dc9954@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 08:34:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Add experimental Zvabd extension support
To: liumingliang <liumingliang.dev@bytedance.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com,
 chao.liu@processmission.com, Zhibo Hong <hongzhibo@bytedance.com>
References: <20260828092053.3787517-1-liumingliang.dev@bytedance.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828092053.3787517-1-liumingliang.dev@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX144QgHsSn4AM
 zfoV5MVVE39iNomkQfqGUh+Np/Fl/chyFgmUW6ePMwhYppvn+6oKV91jN3Pg+2aW1vGVCWiYv8X
 6Vvwrz/IVMFdHVEDe80ZjMg9HeKbGlJuAMFz/bcFigaFUrer2hwca05BIHI2ZGXpt365ZWTkmM1
 9YOReXvs0fBQZA/gLWe0d61gNkE00Tt+K6Nm7Gm41+izSxa7AUliEJgoBzeivfOW42fIbLbZVri
 qHvLs0E3FEBXNWYfyhPyQk+y62Dac2PXG5qzRN/oPms8IVq+7ysQWzr+kdK77mR/wG7L+h8OT1H
 x0OahEuCkLyg9ZxLLwrrr8GIk/EqvVnxL7iPSmOTOwRFr8obXQCotXoW8tcnEETWdCQG5v/6rdr
 nU40hiI9m6eu96YPVMOjXnwxsxRGzAXV62Va3WpYVP0SIKH8MWFy+HSAn6v4o5n0pntMusqvtzG
 Ul0NRijHFXxmJOm/I0w==
X-Proofpoint-ORIG-GUID: FeiYrMmxx2l12ni_M4gSDbNnZM1xLNtB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX1GsqNzLd1nZ9
 3R4BV3fUVjvJ5XigExGHkDFjcqC4UtzQ5cHCOr3GQVuJvLgWb81vTyUx8i9pW44jg3JhPfw6bzP
 SJX11eb28ZDWnfIB8d+z0IInVMRkfH0=
X-Authority-Analysis: v=2.4 cv=faedDUQF c=1 sm=1 tr=0 ts=6a91723a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=968KyxNXAAAA:8 a=jQRO3n_qYhbkmsKaj84A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: FeiYrMmxx2l12ni_M4gSDbNnZM1xLNtB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099
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

Hi,

This patch is missing vabs.v, which is also part of the specification.

I added vabs.v, and a .S test file for this new insns, using Zhibo's original
patch, in this branch:

https://gitlab.com/danielhb/qemu/-/tree/zvabd

vabs.v implementation:

https://gitlab.com/danielhb/qemu/-/commit/1ce5701e737f885f2e32248c1587614ea3435d76

test file:

https://gitlab.com/danielhb/qemu/-/commit/9f4626bc8e55c0768ff474037e291431d4deb0fb


Feel free to add these 2 commits in this work.  It's already rebased on a recent code
base so shouldn't be much of a problem.


Also, I believe we'll want tests for the other zvabd insns too, so we'll need extra
code in test-zvabd.S.


Thanks,
Daniel

On 8/28/2026 6:20 AM, liumingliang wrote:
> From: Zhibo Hong <hongzhibo@bytedance.com>
> 
> The draft Zvabd extension provides vector integer absolute-difference
> operations for image, video, and other data-processing workloads. It
> introduces eight new intructions:
> 
>    - vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from
>      8 through ELEN, with SEW 64 requiring Zve64x.
>    - vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support SEW 8
>      and 16 and accumulate into a double-width destination.
> 
> This patch implement this instruction extension, including instruction
> decoder, TCG translation, and helpers, etc. The specification is under
> review at:
> https://github.com/riscv/riscv-isa-manual/pull/3279
> 
> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
> ---
>   disas/riscv-op.c.inc                        |  8 +++
>   disas/riscv.c                               |  8 +++
>   target/riscv/cpu.c                          |  1 +
>   target/riscv/cpu_cfg_fields.h.inc           |  1 +
>   target/riscv/helper.h                       | 26 ++++++++++
>   target/riscv/insn32.decode                  | 10 ++++
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 45 +++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c                  |  6 +++
>   target/riscv/tcg/vector_helper.c            | 56 +++++++++++++++++++++
>   9 files changed, 161 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 1d334e4857..07b56f5d52 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -490,6 +490,10 @@ OP(vaadd_vv, "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>   OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>   OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
>   OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
>   OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> @@ -861,6 +865,10 @@ OP(vsuxei16_v, "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>   OP(vsuxei32_v, "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>   OP(vsuxei64_v, "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
>   OP(vsuxei8_v, "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vwabda_vv, "vwabda.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwabda_vx, "vwabda.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwabdau_vv, "vwabdau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwabdau_vx, "vwabdau.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>   OP(vwadd_vv, "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vwadd_vx, "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>   OP(vwadd_wv, "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index b8099cbdf8..e0a8b3a756 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2022,6 +2022,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   case 48: return &op_vwredsumu_vs;
>                   case 49: return &op_vwredsum_vs;
>                   case 53: return &op_vwsll_vv;
> +                case 61: return &op_vwabda_vv;
> +                case 62: return &op_vwabdau_vv;
>                   }
>                   break;
>               case 1:
> @@ -2164,6 +2166,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                           break;
>                       }
>                       break;
> +                case 21: return &op_vabd_vv;
> +                case 22: return &op_vabdu_vv;
>                   case 23:
>                       if ((inst >> 25) & 1) {
>                           return &op_vcompress_vm;
> @@ -2349,6 +2353,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   case 46: return &op_vnclipu_wx;
>                   case 47: return &op_vnclip_wx;
>                   case 53: return &op_vwsll_vx;
> +                case 61: return &op_vwabda_vx;
> +                case 62: return &op_vwabdau_vx;
>                   }
>                   break;
>               case 5:
> @@ -2417,6 +2423,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   case 13: return &op_vclmulh_vx;
>                   case 14: return &op_vslide1up_vx;
>                   case 15: return &op_vslide1down_vx;
> +                case 21: return &op_vabd_vx;
> +                case 22: return &op_vabdu_vx;
>                   case 16:
>                       switch ((inst >> 20) & 0b11111) {
>                       case 0:
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a13177b7b7..4b8944b051 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -220,6 +220,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
>       ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
>       ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_ztso),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvabd, PRIV_VERSION_1_13_0, ext_zvabd),
>       ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
>       ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
>       ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index f8c27a574f..6018e58195 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -83,6 +83,7 @@ BOOL_FIELD(ext_zve32x)
>   BOOL_FIELD(ext_zve64f)
>   BOOL_FIELD(ext_zve64d)
>   BOOL_FIELD(ext_zve64x)
> +BOOL_FIELD(ext_zvabd)
>   BOOL_FIELD(ext_zvbb)
>   BOOL_FIELD(ext_zvbc)
>   BOOL_FIELD(ext_zvkb)
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 4fc2d3a155..3aef6e0e3e 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1350,6 +1350,32 @@ DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
>   DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
>   DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>   
> +/* Zvabd Extension */
> +DEF_HELPER_6(vabd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vabdu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabda_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwabdau_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +
>   /* CFI (zicfiss) helpers */
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_1(ssamoswap_disabled, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 21272fdb50..1c991a6f42 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1084,3 +1084,13 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
>   sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
>   sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
>   sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> +
> +# *** Zvabd Extension ***
> +vabd_vv       010101 . ..... ..... 010 ..... 1010111 @r_vm
> +vabd_vx       010101 . ..... ..... 110 ..... 1010111 @r_vm
> +vabdu_vv      010110 . ..... ..... 010 ..... 1010111 @r_vm
> +vabdu_vx      010110 . ..... ..... 110 ..... 1010111 @r_vm
> +vwabda_vv     111101 . ..... ..... 000 ..... 1010111 @r_vm
> +vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
> +vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
> +vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index a22e2cae6c..14ef961607 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4091,3 +4091,48 @@ GEN_INT_EXT_TRANS(vzext_vf8, 3, 2)
>   GEN_INT_EXT_TRANS(vsext_vf2, 1, 3)
>   GEN_INT_EXT_TRANS(vsext_vf4, 2, 4)
>   GEN_INT_EXT_TRANS(vsext_vf8, 3, 5)
> +
> +/* Zvabd Extension */
> +#define GEN_ABD_CHECK(NAME, CHECK_FN, MAX_SEW)                       \
> +static bool NAME(DisasContext *s, arg_rmrr *a)                       \
> +{                                                                    \
> +    return CHECK_FN(s, a) && s->cfg_ptr->ext_zvabd &&                \
> +           s->sew <= MAX_SEW &&                                      \
> +           (s->sew != MO_64 || s->cfg_ptr->ext_zve64x);              \
> +}
> +GEN_ABD_CHECK(vabd_vv_check, opivv_check, MO_64)
> +GEN_ABD_CHECK(vabd_vx_check, opivx_check, MO_64)
> +GEN_ABD_CHECK(vwabd_vv_check, opivv_overwrite_widen_check, MO_16)
> +GEN_ABD_CHECK(vwabd_vx_check, opivx_overwrite_widen_check, MO_16)
> +
> +GEN_OPIVV_TRANS(vabd_vv, vabd_vv_check)
> +GEN_OPIVX_TRANS(vabd_vx, vabd_vx_check)
> +GEN_OPIVV_TRANS(vabdu_vv, vabd_vv_check)
> +GEN_OPIVX_TRANS(vabdu_vx, vabd_vx_check)
> +
> +#define GEN_ABD_OPIVV_WIDEN_TRANS(NAME, CHECK)                          \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    static gen_helper_gvec_4_ptr * const fns[2] = {                     \
> +        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                   \
> +    };                                                                  \
> +    return s->sew <= MO_16 && do_opivv_widen(s, a, fns[s->sew], CHECK); \
> +}
> +
> +#define GEN_ABD_OPIVX_WIDEN_TRANS(NAME, CHECK)                          \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    if (CHECK(s, a)) {                                                  \
> +        static gen_helper_opivx * const fns[2] = {                      \
> +            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               \
> +        };                                                              \
> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm,                \
> +                           fns[s->sew], s);                             \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
> +GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)
> +GEN_ABD_OPIVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)
> +GEN_ABD_OPIVV_WIDEN_TRANS(vwabdau_vv, vwabd_vv_check)
> +GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 9e3cc87f8a..4c2fb6f063 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -732,6 +732,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if ((cpu->cfg.ext_zvabd) && !cpu->cfg.ext_zve32x) {
> +        error_setg(errp,
> +                   "Zvabd extensions require V or Zve* extensions");
> +        return;
> +    }
> +
>       if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
>           if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicntr))) {
>               error_setg(errp, "zicntr requires zicsr");
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index e28d8a3d9f..bdb1efcebc 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -5906,3 +5906,59 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
>   GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
>   GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
>   GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
> +
> +/* Zvabd Extension */
> +#define DO_ABD(N, M)  (N > M ? N - M : M - N)
> +#define DO_ABDACC(N, M, D) (DO_ABD(N, M) + D)
> +
> +RVVCALL(OPIVV2, vabd_vv_b, OP_SSS_B, H1, H1, H1, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_h, OP_SSS_H, H2, H2, H2, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_w, OP_SSS_W, H4, H4, H4, DO_ABD)
> +RVVCALL(OPIVV2, vabd_vv_d, OP_SSS_D, H8, H8, H8, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_b, OP_SSS_B, H1, H1, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_h, OP_SSS_H, H2, H2, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_w, OP_SSS_W, H4, H4, DO_ABD)
> +RVVCALL(OPIVX2, vabd_vx_d, OP_SSS_D, H8, H8, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_b, OP_UUU_B, H1, H1, H1, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_h, OP_UUU_H, H2, H2, H2, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_w, OP_UUU_W, H4, H4, H4, DO_ABD)
> +RVVCALL(OPIVV2, vabdu_vv_d, OP_UUU_D, H8, H8, H8, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_b, OP_UUU_B, H1, H1, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_h, OP_UUU_H, H2, H2, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_w, OP_UUU_W, H4, H4, DO_ABD)
> +RVVCALL(OPIVX2, vabdu_vx_d, OP_UUU_D, H8, H8, DO_ABD)
> +
> +RVVCALL(OPIVV3, vwabda_vv_b, WOP_SSS_B, H2, H1, H1, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabda_vv_h, WOP_SSS_H, H4, H2, H2, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabda_vx_b, WOP_SSS_B, H2, H1, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabda_vx_h, WOP_SSS_H, H4, H2, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabdau_vv_b, WOP_UUU_B, H2, H1, H1, DO_ABDACC)
> +RVVCALL(OPIVV3, vwabdau_vv_h, WOP_UUU_H, H4, H2, H2, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabdau_vx_b, WOP_UUU_B, H2, H1, DO_ABDACC)
> +RVVCALL(OPIVX3, vwabdau_vx_h, WOP_UUU_H, H4, H2, DO_ABDACC)
> +
> +GEN_VEXT_VV(vabd_vv_b, 1)
> +GEN_VEXT_VV(vabd_vv_h, 2)
> +GEN_VEXT_VV(vabd_vv_w, 4)
> +GEN_VEXT_VV(vabd_vv_d, 8)
> +GEN_VEXT_VX(vabd_vx_b, 1)
> +GEN_VEXT_VX(vabd_vx_h, 2)
> +GEN_VEXT_VX(vabd_vx_w, 4)
> +GEN_VEXT_VX(vabd_vx_d, 8)
> +GEN_VEXT_VV(vabdu_vv_b, 1)
> +GEN_VEXT_VV(vabdu_vv_h, 2)
> +GEN_VEXT_VV(vabdu_vv_w, 4)
> +GEN_VEXT_VV(vabdu_vv_d, 8)
> +GEN_VEXT_VX(vabdu_vx_b, 1)
> +GEN_VEXT_VX(vabdu_vx_h, 2)
> +GEN_VEXT_VX(vabdu_vx_w, 4)
> +GEN_VEXT_VX(vabdu_vx_d, 8)
> +
> +GEN_VEXT_VV(vwabda_vv_b, 2)
> +GEN_VEXT_VV(vwabda_vv_h, 4)
> +GEN_VEXT_VX(vwabda_vx_b, 2)
> +GEN_VEXT_VX(vwabda_vx_h, 4)
> +GEN_VEXT_VV(vwabdau_vv_b, 2)
> +GEN_VEXT_VV(vwabdau_vv_h, 4)
> +GEN_VEXT_VX(vwabdau_vx_b, 2)
> +GEN_VEXT_VX(vwabdau_vx_h, 4)


