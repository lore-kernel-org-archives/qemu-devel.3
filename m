Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA1606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kf4uN4nd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jUWfg30V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ9ft-0002gu-5a; Sun, 08 Nov 2026 15:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQ9fX-0002bT-Jl
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 15:39:15 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQ9fV-0001LP-Kl
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 15:39:15 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A8HoDVQ488605
 for <qemu-devel@nongnu.org>; Sun, 8 Nov 2026 20:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JtkrEwRq8CS5UHdk7YZcdxdbNbKUia0wZEAHUDXiCwU=; b=kf4uN4ndnc0aK/h6
 6oXhKiSsG0F6U8Pm506Ia6Vfx/py3zqgxV6O99x9XPO9RB2R7JJVH0ZIAoMB8qVs
 1UtuuOSGbqhXS8g//81NOXBxIbf9Mk6T1n/5mKSIfHzThxm5aftLFPSkW6V9qbeL
 IZp6OhsrBYJEPafGFHLsLj/YbjyoxH+l1YLcajdTwXAUkGNjkmJ1sMzido1/F1zj
 uJiFmFIPXolaSmM3dA1KQjs851ZzxPIvAzlqjrM/Htdr/5or1iGx6TYlqkBS6qEh
 7EfHxZCXdb1WTRTOvazhLxKdRCljmWqFZh0es4J8yzanAoVdTU0AyTtrJ7w+BhbR
 +4pMhg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k3hku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 20:39:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c6c1e082bso6035056d6.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794170348; x=1794775148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JtkrEwRq8CS5UHdk7YZcdxdbNbKUia0wZEAHUDXiCwU=;
 b=jUWfg30VvjvE/BswImK7J9QcHS331MMUP0wh75U4OD2O4MwRexCWWVSu5ZFZPBB5Tq
 xT/cPH1NbPCNISkV4/nkeuBp1SsWJ2g5uITg/j+KrUGVZ9192y+0NT3Pe1BATeJ9DOg5
 F6JBZJwp9zWtpECruq1jJpCf6nQvEpxIiAESaYVcvvHahNXb1viKR6Pf60G3AQSmdtpT
 AKE3N8vlzX335uG1FEN1jLrKN4XGVsKlCrAp1IW9kFYgn6P+dh4x1bRGyvshVi5/sVZ2
 kYBhHw14aKktgwz1y74+DF42SG5qOSgzIJiJl9C5f+HitmfaMMa0anCJ/L0b7AogrPFC
 WfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794170348; x=1794775148;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JtkrEwRq8CS5UHdk7YZcdxdbNbKUia0wZEAHUDXiCwU=;
 b=v0c9I2dSwsY+P7h9zLrNuxJ/VCnv7o3weIgPwn669LkR4Gi6/xFETOP1KRFJ2vFWnO
 KjAtxbE/AJS9U0qVEiSGgoR4y+75xhTwrynGmXdxhC44iuMQV5apauSCmL2pwLMKI97k
 r79TYBnb5/UQOHbRxf8e+n5ma7dAYdR1Zxs6dKOzyDZE5Lo389l5cm6r0zYEKVEEn5t6
 ZXrcmm0EShovRM0u3owWHztBr+HOI/zzxd3yFD3sAXSbbNt6flXhcC7Sm22Z/Xtec5ac
 598MTIhLZF5j+aZ+BH3ty/Z0lYEiy50bVr9Spfm/0aj37tM7igHwinTfY7A+kzsXxS2Y
 n3Fw==
X-Forwarded-Encrypted: i=1;
 AL+hErGgbHWF2u2utRZ+fxmGu8H7lAzIomsNT2BTWYlb39yM6qHuLxHN0HSogeCWg/F2mO9o6WsqoG9bB4l+@nongnu.org
X-Gm-Message-State: APuU4Z8p8cUbIAW+iKBfFFcRQ024nbCnWy+sLwrkr8j3y8VRpVX0hWkd
 UT1iXHSSjIhAf0/UiaaLGsv77iYON6zIekw4NYKSSifFz/IEijeoFZa7O7so2nSLuMECOMI+qQT
 MPIyD2Z+iMPkKKellA59MbRdsbyJwfmuPwXPeC3B8jQYQXLnGNsiU2BJZaQ==
X-Gm-Gg: AYBFou0eWIaPU9FNnt+Za/G1YQdv+VMfGY22iBiipPAzR7nwSKpYsZApv6vHkDUZhqw
 M+OOhYujsxv/bwaUmJMTSE6oXYWE15Pj3Qxsf1eXChg+or+Mh12UVUhyItUQjGtYJvZG+Ep1oCS
 UXPGBKBJnfmjS49GO5yBe8nbAnGCeu3JWha1TcPYhRUqPHyf9+EFJej9hJTLarjmmULYzV9MCX3
 iKSjzSSM9/rVtsoewF1rHaRxcVjLSCqkzXcnypj+q9HTQSehUgk0cmgnhmwtCA/r8ZGzbyDP9DH
 UBgarAJc3byS1mxiNfVXIEc1c98vxdJZoM1yJpUdvtZ89B9fViCgIvmn54w62WQ84sSxATncLHT
 hte2n1psAG8aqqwdzm1oMfLY+kXRxGaJML3G+EB077aZqZUuhTFPuNsLOrnwb9dUPmDFV0qtQ/S
 drBpg+Eiyk
X-Received: by 2002:a05:622a:5299:b0:533:95c1:fb11 with SMTP id
 d75a77b69052e-54fa6b087famr71161251cf.28.1794170348535; 
 Sun, 08 Nov 2026 12:39:08 -0800 (PST)
X-Received: by 2002:a05:622a:5299:b0:533:95c1:fb11 with SMTP id
 d75a77b69052e-54fa6b087famr71160991cf.28.1794170348083; 
 Sun, 08 Nov 2026 12:39:08 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55263891251sm24939051cf.5.2026.11.08.12.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 12:39:06 -0800 (PST)
Message-ID: <4175432b-e8c4-422d-9ca0-f3a4e5375c91@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 17:39:03 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: Apply pointer masking to
 SSPUSH/SSPOPCHK addresses
To: Rishab Pradeep <rishab@rispop.dev>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tarun Patanjali <tarun.patanjali@utexas.edu>,
 Chris Elwood <christopher.elwood2024@gmail.com>
References: <20261108064641.179764-1-rishab@rispop.dev>
 <20261108064641.179764-3-rishab@rispop.dev>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261108064641.179764-3-rishab@rispop.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA4MiBTYWx0ZWRfX+DOnVGAjK293
 5JxPv24awojYEs/ULMTbrc+GHf4n8FtQNJlv+B1P2H/Zp8PeZEWWfvTwo7icHzZCT9yvoFobTmz
 W0mxhEMzfpkFLnzXKwawCClK94l27agcbbeZxm0mK/tpd1YPjKWBeikv+9KXbNzJo+N/LpNjycw
 jca1g7LHYTREShxcxDTLXOrH25E49YXL7cr4HVW74vciyZbrtVyjfvH/ASdK9POdvjQdaOy1KGM
 Pw4ZP02wyU8eaVygierVGT7Fng2I7OK1MDnHbrY3axOLlIN2Fj/L6/nWQjuy1A5anF7pMxbVAo7
 bNub8De3dGLqXvb9ff8YmMuKw286JlkZzMSWJkUyrxrito50y4JmVQv/ioltJWmAamH5oYWa2Pl
 8Bu+SlC9+bIElOansnwjDpqphL+nMA4TJIVoq9vdMWeEq1Pk41ePsdPZKSUK0SyCBdJdQu78IcK
 xUx6jx9EqpKzGVe9RJA==
X-Proofpoint-ORIG-GUID: VMYT77uSbyWkkXtq3d7y-AFUVFLIcsed
X-Proofpoint-GUID: VMYT77uSbyWkkXtq3d7y-AFUVFLIcsed
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6af0dded cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=E3SDrXxsNsjWtnqY_CYA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA4MiBTYWx0ZWRfX1zal8SyOxVb8
 LvlRsPwulXSaLK0mUPb1ZbHAA3MM3o7L3g6HdeDDJXfIgzAMPvNOGANqYrsYorG4S0Mv+y8o/kh
 aMad+NcjZkWXeI8zGx7EASbfRtizZgc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080082
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/8/2026 3:46 AM, Rishab Pradeep wrote:
> From: Rishab Pradeep <rishab@rispop.dev>
> 
> SSPUSH and SSPOPCHK form their effective address from ssp rather than
> a GPR, so they bypass get_address() and the pointer-masking ignore
> transformation is never applied. With pointer masking enabled, a
> tagged ssp raises a store/AMO page fault, while SSAMOSWAP through the
> same tagged pointer succeeds.
> 
> The Privileged Architecture Specification, Section 17.1.2.6 ("Memory
> Accesses Subject to Pointer Masking"), applies the ignore
> transformation to the effective address of explicit memory accesses.
> SSPUSH and SSPOPCHK perform explicit store and load accesses at ssp,
> so that address must be masked.
> 
> Apply gen_pm_adjust_addr() to the ssp-derived address. ssp itself is
> still written back unmasked, and the SSPOPCHK comparison of the loaded
> value against rs1 is unchanged.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4758
> Co-developed-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
> Signed-off-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
> Co-developed-by: Chris Elwood <christopher.elwood2024@gmail.com>
> Signed-off-by: Chris Elwood <christopher.elwood2024@gmail.com>
> Signed-off-by: Rishab Pradeep <rishab@rispop.dev>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> index d47a9f9c7d..c2dddcc8bb 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> @@ -29,6 +29,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>       }
>   
>       TCGv addr = tcg_temp_new();
> +    TCGv maddr = tcg_temp_new();
>       TCGLabel *skip = gen_new_label();
>       uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
>       TCGv data = tcg_temp_new();
> @@ -36,8 +37,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>       TCGv_i64 wide_addr = tcg_temp_new_i64();
>       tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
>       tcg_gen_trunc_i64_tl(addr, wide_addr);
> +    gen_pm_adjust_addr(ctx, maddr, addr);
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> -    tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
> +    tcg_gen_qemu_ld_tl(data, maddr, SS_MMU_INDEX(ctx),
>                          mxl_memop(ctx) | MO_ALIGN);
>       TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
>       tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
> @@ -60,6 +62,7 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
>       }
>   
>       TCGv addr = tcg_temp_new();
> +    TCGv maddr = tcg_temp_new();
>       int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
>       TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
>       TCGv_i64 wide_addr = tcg_temp_new_i64();
> @@ -67,7 +70,8 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
>       tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
>       tcg_gen_trunc_i64_tl(addr, wide_addr);
>       tcg_gen_addi_tl(addr, addr, tmp);
> -    tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
> +    gen_pm_adjust_addr(ctx, maddr, addr);
> +    tcg_gen_qemu_st_tl(data, maddr, SS_MMU_INDEX(ctx),
>                          mxl_memop(ctx) | MO_ALIGN);
>       tcg_gen_ext_tl_i64(wide_addr, addr);
>       tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));


