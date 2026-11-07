Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9BA606A33B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xop6UbJo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O4d1yJDH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPmHI-0001zj-Ub; Sat, 07 Nov 2026 14:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPmHH-0001z3-0K
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 14:40:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPmHF-0001gt-9y
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 14:40:38 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7Ht81L1820421
 for <qemu-devel@nongnu.org>; Sat, 7 Nov 2026 19:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AThOmcik4HunwJsGYQL/wupsZnfSEToAcb6L0E4N3iI=; b=Xop6UbJo8eiLs7Bo
 KhychT9fnqg82tMYr1oryNYbX9k8ojRovP1nffNq1+sxG45T9/vFxsuiSpLGtfD5
 EgMLcLCcaJfLXjAtAwPWcGYRWLPhE1LFlbg/fRrOL9DL2adGNo3NRr2i78fwsgR6
 WiRAqq97MjecIwpM5MEZ1V2UrNCGdOaXwpu5jTvfi0Q2LSpY2Gtucze+qiavHxbW
 MwWqkfU1oeyUKjKKzDHlNJAxekOeu0qECwiZmyzFQG+6QTLV1hmrdmVPB99FsH1y
 fo0jfwaI2Oao6x6Y4rq0CiA9jIJTq6PoGMGN8Rwj/RJrWoQumJOjk8JMP9CbO8II
 ntzXhA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k1d0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 19:40:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5364f562140so372331cf.0
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794080433; x=1794685233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AThOmcik4HunwJsGYQL/wupsZnfSEToAcb6L0E4N3iI=;
 b=O4d1yJDH4+sw2pheYyWXgpZva+9ItwpiPSpWXHdy2FPeuWR4ANoA220NYjip/vtcF9
 1pgazy6+5oqa/gXcZLUFAmpveSwoRawrE9ad8xrBhlf7ExI3OFeiMwAaa4pY/KQoCpR5
 MUY8YtpfGJ2YU06vCpUdLA2q8HsMbUj2FHlV2Fg/2RXEfQ9+trmGR4jb5Tsnwai/RkBj
 MC1RXVlJWoGJM9+qZIe9g56v9Rk1BLosdSHJW4sOQIKld6r4RpQ2bcWvKE67KS93JrrP
 2DWUt7/t3+IETn56FIVOUeH5VG+jMIwCH7Y+B6VNO9excOm1KhpO1MgIomB+vxogCeuG
 CKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794080433; x=1794685233;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AThOmcik4HunwJsGYQL/wupsZnfSEToAcb6L0E4N3iI=;
 b=N29kDxZb50OXJUWGfGHyhCzou1h8WVKa8V4k+1R06MDjaFZ56QQsx1wD/Wt3PdJsHq
 nx+5Fmg3NpyDI6f76ZuN9pYLno4O3wV8CvCtHnCQy50Z7eYgFGe9wzKg35LkzqBz9kJj
 4d4n8GhyTttIltPXsM59bA8i2Tbmh1ZYh3HRkd3F/AfecjUwocZ144jigy4SWKr2h3lk
 Xkd1jazzJodn6ByIBtNLORRgMNgZxa50frCWahht5A9WuGW06Gb0QOeJqIq11uK1uGaq
 yfFH6PJsoCboLzI/Y3+qZMWD6U9XTykpUnLehmLxWatsBD3aIya4fAUTM3uMDmpjbVEJ
 i46Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBziuCwAj4uIvhbBfIKNqe0P9G5u4iIofNwIm99+K6rRonWFD1w9Z7rGFD1KHdw1KNOMbnoORtaBs4nb@nongnu.org
X-Gm-Message-State: APuU4Z8GBFfEwp1tteQTZvvoYDKhaqvOPwZb6hwInEwlIP+7wkYlLmvs
 g8j5r7An5TBYghIm49B37icxHfcMzU+mxZG7c7Zy3sborPfF1buRdzZ9TdcVLDrJMb0inqhHAX4
 N+fh1Cb0TFXz9f1Icd3if6mSMkkgyTJCGZJ09EqT6vu304QIee26JzWpPAw==
X-Gm-Gg: AYBFou14wquzH77LWOQO+oVi0gLZB1HrIo0hecEWMSQJvl3U+eefT6neO3APU+IoIV4
 yjEiWM9M1qhP23Lpez9S4ZzZxHDUVU3kn73gZX/UqXhEymwqM35F0yFnxCEYG8bsbEbB+kZ5wkS
 8z+LGV977n0a8ndP5L/1GrJcF2n6ig33awbGdKTQ6Tuxi1k6978+KlmzPApIVVTMQbQ7X2Y75zh
 atnCbVGsTHW3gIsjj9M4R5znuivW56764iflUerHQLGFDGuv/Gpe6cVJYrNhpOE+AU4flAkvgqi
 FBTAYVhVjYYzBU+WJi9UKl20ml8uI5Ga46Tj4ZRP+k7bRWden4SfS0hkfTNKQcnRN+tP/QgBgE1
 gc9L42GafHv9kmrT+ex2lQVrfkpbfuJiFfpL2Nn5+SXuajnByilWz2Cy1aXyXtvc6fgctYDzGZE
 yDyTZYvugR
X-Received: by 2002:a05:622a:2449:b0:536:64ee:73e8 with SMTP id
 d75a77b69052e-54fa2100112mr36551391cf.8.1794080433349; 
 Sat, 07 Nov 2026 11:40:33 -0800 (PST)
X-Received: by 2002:a05:622a:2449:b0:536:64ee:73e8 with SMTP id
 d75a77b69052e-54fa2100112mr36551181cf.8.1794080432758; 
 Sat, 07 Nov 2026 11:40:32 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55264a2b7c8sm824151cf.25.2026.11.07.11.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2026 11:40:31 -0800 (PST)
Message-ID: <e9e3fbf8-d349-4cff-8a8d-7e4894045621@oss.qualcomm.com>
Date: Sat, 7 Nov 2026 16:40:28 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Factor out pointer-masking address
 adjustment
To: Rishab Pradeep <rishab@rispop.dev>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tarun Patanjali <tarun.patanjali@utexas.edu>,
 Chris Elwood <christopher.elwood2024@gmail.com>
References: <20261029183751.11143-1-rishab@rispop.dev>
 <20261029183751.11143-2-rishab@rispop.dev>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029183751.11143-2-rishab@rispop.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA3OCBTYWx0ZWRfX76Ldld0bN669
 L0zbtj/3ZY9GFytKEoZtNIc0UxRw7hS+n9v1eM4LGW1GIM14Aa+phq5vHOLcd2TtT/3HG9LJLLJ
 TYpyDhAXHNmAn4JZAru8pi0KB1HJ5MDdx9aYZPjfxgWx9cU6BUaB0S80GBUOcyz5R/yhKZSk+PG
 CIRurFWvp666hlKB4gL4po0NoX9MJPznDFzGNCMQwMaJE0+YqZidrGuWk07utjwFK+omJzjKAAF
 S5GsNNxk9BbKoZD6r2x0QI+MQ/IsRMrUZLvByoODU+Njuo/jSy6d+ohuIPEuj9yCEZpwlBQ8I8s
 xYiYL5IdJBe6litpjIXM1Itezs5ktDK1SLR4yJoZLOvElMEhvfe/BRP3+9bzlwRK5KW22VXL2+1
 GBdks5PLO0gTVaFkIooKhEcCIWE2pJ+uN1gmYp9oflbSwqOygj8q6SG+d9SMSASexATFMBgJyKf
 2JKjFnWl6Jc1Wur6iFw==
X-Proofpoint-ORIG-GUID: Cp8K6uUYzfLzuWxR67Sq-RUzxx6nYAvp
X-Proofpoint-GUID: Cp8K6uUYzfLzuWxR67Sq-RUzxx6nYAvp
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6aef7eb2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=bRW93ZNPrfNHTEDgfpIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA3OCBTYWx0ZWRfX2Xujl81Iynio
 NdBw9my49WCfx/C3jvFNQu6Yyd6yV3fxfsI1wYGN+F9Gaww6VLuy0hf5TIu23AsiWRV/bVKIDCv
 BhntKGrZ/LtQdkDsOvLGLfFW5nk5rd4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070078
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/2026 3:37 PM, Rishab Pradeep wrote:
> Move the addr_xl/addr_signed extract, which applies address-width
> truncation and the pointer-masking ignore transformation, out of
> get_address() and get_address_indexed() into a new helper,
> gen_pm_adjust_addr(), so it can be applied to addresses that are not
> formed from a GPR. No functional change.
> 
> Co-developed-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
> Signed-off-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
> Co-developed-by: Chris Elwood <christopher.elwood2024@gmail.com>
> Signed-off-by: Chris Elwood <christopher.elwood2024@gmail.com>
> Signed-off-by: Rishab Pradeep <rishab@rispop.dev>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/translate.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index 79b0f444ef..72d36764d8 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -654,6 +654,15 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
>   
> +static void gen_pm_adjust_addr(DisasContext *ctx, TCGv dest, TCGv src)
> +{
> +    if (ctx->addr_signed) {
> +        tcg_gen_sextract_tl(dest, src, 0, ctx->addr_xl);
> +    } else {
> +        tcg_gen_extract_tl(dest, src, 0, ctx->addr_xl);
> +    }
> +}
> +
>   /* Compute a canonical address from a register plus offset. */
>   static TCGv get_address(DisasContext *ctx, int rs1, int imm)
>   {
> @@ -661,11 +670,7 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
>       TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
>   
>       tcg_gen_addi_tl(addr, src1, imm);
> -    if (ctx->addr_signed) {
> -        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
> -    } else {
> -        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
> -    }
> +    gen_pm_adjust_addr(ctx, addr, addr);
>   
>       return addr;
>   }
> @@ -677,11 +682,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
>       TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
>   
>       tcg_gen_add_tl(addr, src1, offs);
> -    if (ctx->addr_signed) {
> -        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
> -    } else {
> -        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
> -    }
> +    gen_pm_adjust_addr(ctx, addr, addr);
>   
>       return addr;
>   }


