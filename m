Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FF606A32D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=csmQtD0I;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HXEe6y3M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPmKQ-0002bO-9l; Sat, 07 Nov 2026 14:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPmKN-0002b4-Tb
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 14:43:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPmKK-00020B-Kc
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 14:43:50 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7HthKv3388254
 for <qemu-devel@nongnu.org>; Sat, 7 Nov 2026 19:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oTlpJ0w4un70KcL9qwpLPg5kywp6vmMrRr21Wh/6gG0=; b=csmQtD0IMhkNWwVx
 g3v9z87g/AaMva/lgy9iGiUzoRtS7Ry44Q9kHuw/Aro1ETW+N5l6IHzd2v1TLkOG
 ROty4pKGl9Pb+zAPL2SH2K/ln0QJwM6eMWbggTyZCegnFlSddbJa7ujYOnGjdnFw
 aKEO/OThRZR5mO07ZODfdeqkQEtEp4/7y9PsHvVfW0MoLKugWTrZHiuKq2IIJbST
 w+cz+RcbqF5EIWwSANXB8N3EeHjPYteQwFk98Z8g+TQ8LT8UOSqch/PnBvtbPaVg
 I7ETyQRmagjHk5vQwV+2P0pXWuIAQsImi6qxI4zPja6H33wJLymWy70iQrgUJexo
 KNhmvw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsv731gyp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 19:43:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so399161885a.1
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2026 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794080625; x=1794685425; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oTlpJ0w4un70KcL9qwpLPg5kywp6vmMrRr21Wh/6gG0=;
 b=HXEe6y3MMXkfmP1SY+s347GVY4oG5O+j8/SuCCxk1SZ6/M/sMXioSHu0XVQlNM4BNI
 6+6Id/cxdhFsmJNLRl1eHQ3kf+E2lgUi8H9z5QibXxGH6M8KhjvBHg33S5Z3peqj0hi5
 +0oMB58a7t/DmXA2z37vpz8SJkJ1oZgtcsuyUTnUoG+92ROrhV4mwkHUZulpQj3/Fns5
 7iQfSl2lCufRRkDpF6qzbwXzEnX7Mqz4ywYQ11wCKfpHqqy4CYlq2XtaxdGHqY3CGj99
 J7a+vDeVtqpfJHZGUhvhGsj18UC8nOV2x4vHx1q613IjCa5YFLZcQeI8KRJVns3g06R/
 B8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794080625; x=1794685425;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oTlpJ0w4un70KcL9qwpLPg5kywp6vmMrRr21Wh/6gG0=;
 b=Ipu1OpO3Y/Y1gDK779KIcPK0BZl++umRh3Sl4hUn4IhUrOh3tW4hovpxbFBxMfmpF2
 OInEoq73le0Bpbek5oSVnl4TTY50sy3QCkL/v298jVvGUeW1G/q4vn6UtgS1bt9G+gNY
 /E1UQYcxOXm6L07W5/9ms1Mmtt9uT5cXrj/PDRWB+HKw3FM3VajnoHRQelW31gjT2M5m
 uJU27yrCTyuMq2+whUDYPE3RsdcDZWIc9l4u/SxVinPjEWfNFBcK/6vTsAyZm4ZOH5SX
 Ir0OZvBsddzDsh70PFqCOhhc/2Lf6YC2XDR56dICIFYUq7sh6MEl5uI/Luruyido3EHh
 hK9A==
X-Forwarded-Encrypted: i=1;
 AKwUvByZLTdSsidfms010YL+ULanid2L0IkS+OK4jnytyOXs80VLTJVAcQbIbqC6s+HXJVrC1xmuXjJc+ymn@nongnu.org
X-Gm-Message-State: APuU4Z/DM/0Ueh0+ZOJs8EdA+MhyxXvMN68d70I7AUin+WuDi0AT09W5
 WYHU6WDkceTK3XzdqoZxplYXG/DU/L90SbNSEXicjvpaKwKwsVdAIBZQYJbjnp4gy/U9JmNJnZu
 8QPmfdxX+RetcHgCBf++o1VwB/FpwcDJQWm1BpC9V1KfJJ1bjEmNqMLoULA==
X-Gm-Gg: AYBFou2Ej9pbTuX6+bVEdYSsnHJtSkgqETpBqLQj6iZSGJ+AppKboN7nmKs0f7r3YO3
 tmNBLMnBu3oPUo7CTOeBhC/AjwJLunGoZmz3J7yLjBP81qD1eM8EBP0l4rDh1BF+k2RKkDTHGWw
 7Q6i8Br5onWEBmOmlOxmWm6EFhQ4AVhXOlQRGsKKjgQ1NOre1Qtkf2MzVC2d10RCYECfa0OiRt0
 +uUjtV2HOixbuhQrtHnh1txSJem71VI9xtEYqPTRYNAwVvvhAuccmFoDSpP/SjqurOUXQWProLI
 14iJsqv/12//IraooIMTk8/NS1csJocbbgWPL8DGxi+xWkcYeHutKHdeQy+ZnnA9shER/dmg5ai
 vyFdNJoecfrJbX/d1kZlkoa4MaNMKxMcF3QJgsbL7JgwhUzYOJeP7MTzR8hnv3GIRBsqWyeMzCo
 mzzQnGsASH
X-Received: by 2002:a05:620a:6c8b:b0:93e:90e0:d2f2 with SMTP id
 af79cd13be357-945f355a9bbmr983487785a.41.1794080625581; 
 Sat, 07 Nov 2026 11:43:45 -0800 (PST)
X-Received: by 2002:a05:620a:6c8b:b0:93e:90e0:d2f2 with SMTP id
 af79cd13be357-945f355a9bbmr983485785a.41.1794080625077; 
 Sat, 07 Nov 2026 11:43:45 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91eceb5777dsm1088926d6.6.2026.11.07.11.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2026 11:43:44 -0800 (PST)
Message-ID: <7862410f-d4a4-4316-a54a-67252cfc9860@oss.qualcomm.com>
Date: Sat, 7 Nov 2026 16:43:41 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Apply pointer masking to
 SSPUSH/SSPOPCHK addresses
To: Rishab Pradeep <rishab@rispop.dev>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tarun Patanjali <tarun.patanjali@utexas.edu>,
 Chris Elwood <christopher.elwood2024@gmail.com>
References: <20261029183751.11143-1-rishab@rispop.dev>
 <20261029183751.11143-3-rishab@rispop.dev>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029183751.11143-3-rishab@rispop.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA3OCBTYWx0ZWRfXyWrZyK1gAn3n
 2LuTyp7dhkGY482k81GZroQIRoBBKJ/dCIckmPPuGzlguHlK6m4MSWEEZSkke6sq/ItEwYeK+dN
 oowCYhxzNpm+/PL/Ad9yLop4BoV4zKChkp7p+5+aNKyv9etcrRNUe9FALY4ckvkx3VSdrAESct7
 ASkppMGvvGbG7W+8StC8c82rifr8XorVUJZXiKrdoPK+bDmLT4hhPAdjhHZAiElQvFlRqN8JO9I
 7IG0YCFIHDlNetHszGAtvxQGrpsYpzHZQyvvY2Um+VYo/2+cmCERibEl2lmVuh4A2mQzMgUSnLp
 cSs71XgoaNf1i9Z9RkUb0OZesbTIqXIr9l4QggRnuXSwHe+JM4E25NBAfRISslwEXAmTCur4OZl
 KhF+ScDjsAoeasH7XuFS4eRLsLO0Qd68+9zdVIaUg5LbOrITeK6WTShrOtb7FAkHIB5BIgtPlZ9
 aBevUHNn4DPrNt7VH8Q==
X-Proofpoint-ORIG-GUID: 5cDU-IUAQag-IeIMOLHV7AeYDTgjtI5L
X-Authority-Analysis: v=2.4 cv=bcb+w+PB c=1 sm=1 tr=0 ts=6aef7f72 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=E3SDrXxsNsjWtnqY_CYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA3OCBTYWx0ZWRfX1n6iXMwrjOQR
 x/IjB30es+O4IfcC9TKhWuwN6xcI5KkJj0bl1SaXmT6rHpoHomzvIflQ19LXfVJF/KW39XFCq31
 zDQOvH/pIfW4uiBxWOu3PVGq26nBxZY=
X-Proofpoint-GUID: 5cDU-IUAQag-IeIMOLHV7AeYDTgjtI5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/2026 3:37 PM, Rishab Pradeep wrote:
> SSPUSH and SSPOPCHK form their effective address from ssp rather than
> a GPR, so they bypass get_address() and the pointer-masking ignore
> transformation is never applied. With pointer masking enabled, a
> tagged ssp raises a store/AMO page fault, while SSAMOSWAP through the
> same tagged pointer succeeds.
> 

Please add a spec reference/citation so it's easier for others to double
check if we're in line with the spec wording.


The code LGTM.  Thanks,
Daniel

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


