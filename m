Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A47606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hSUooM30;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CuCEf7/d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMULg-00079J-2F; Thu, 29 Oct 2026 13:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMULV-0006zz-6o
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:55:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMULS-00059U-Rh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:55:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDHvx1654904
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4Mc+Fdl83qzfmlbsFfM7O3W4T+LwdkvYjEi+9qnibQ=; b=hSUooM303D8obxNI
 zRAtyHoR8JVN0P6ZVPHz/ppJ+oenuhCgTktDZtMrr3YKeawg81tAzePF2ul+Rg1p
 XqS8CPCvHgbOwnywce0abJPGgqDlQNu9GvEZvrXPl1zX2cCoYqX4755d3ahUJnzo
 0vi1NTUpLZ/Oee3XY6+4m/6y8//SBI8x7ecuKO12UVciBUMA6NAGFCBitJADqAx8
 dD8Q4xrSvpMZ+WuQFwwC3QwkwPNIkAmT+I0nHkdrPKgD91MwxJmwhrbdcLdskDqY
 U2JB+M9anrduX59fRPgJngHmhSWRwgKpy08cpVs3Qpg+ZBBmrkp6AgCkg5jHaoR7
 NGsDZw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a21y8s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:55:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5376f1849bbso51947061cf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793296520; x=1793901320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T4Mc+Fdl83qzfmlbsFfM7O3W4T+LwdkvYjEi+9qnibQ=;
 b=CuCEf7/dEd+sBfSGpeotmLxtrl9Ys4WoiSkSANiN9b2QHaieZYGrSgrJ0zuHeOExPq
 9GHtZtHbVQVfeJC0ZWZNUpvh946L36faj5R522HjGs0mOifjfbSm1sy+cqYr1JLCfR35
 Dyt8HU8xEbytQk/Klt2TmXz8byNWwTCXtfZ6E3ONBfeXCqLDu2GmHagPHI2CktAzRJ5c
 ZpYa6Ml2X0t5w93eHzDfrrWc45Ndck9lsque72H/ckfKxJcntv0JwUxgq+WPVa12JNZ1
 3mNd9bz8u+3+9FJf1z7+C1/5WNWxjwKqI/tpFHLtMP8yqUGn8noVRfEZt4JPM/ZaVGoq
 /1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793296520; x=1793901320;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T4Mc+Fdl83qzfmlbsFfM7O3W4T+LwdkvYjEi+9qnibQ=;
 b=go3umO/80WNZvRIleZUALYpULP3K/u1WnZHP47xSpZKg/iS540tevL81GeGOajeREM
 qW6K7BWzKeLnuJc4XvkVO7uWgrATD8o6cN42yTQHobeIlTdzDUD1TNs5krf5/DASARnp
 mx6xh2lj2q4jqy3iH6AKzFeHwc58t3UfDctdvkEITLdp0GopH1ellz/LD2JpYejBFMCS
 mapnqCulWINHwlsXDyyyO3mRvfiatdAUoL+sd9JSF3pHGbSRxMOBv8i++phL9Y+mVvzX
 N1bdv3rxXvdijc1x3c1AtaTNplI9dS/jkpsJaImIqA6QvgvRq8us4zj9nSL+MttJMuXh
 zoXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDO/eAQvxdl+bMWH3lStdswXbqH7X8O4nFHBegIGys+sAUlvxoBgRfIiCgKAewBiNtSFZihq+UnadM@nongnu.org
X-Gm-Message-State: AFq9FYL51z906uNnvvxtdIkjhUj2GerfzSeNBXod576mPrT/Agg6Y5g+
 V82byd5sKKvlgAzieinYmQkoE+58yEfAN0rC0EdeJexsKkA9MQ1z+DQJt4PFXDEp4RRuxmwcVGM
 vPv1ZKNCjGjMnnRfVWyNmYf7PfedzTSRYc9MQyC+BeZSx0uViu/2cYwDOYA==
X-Gm-Gg: AYBFou1ntPrhWSXdvGf/P2xlvBpkCrwpcdkdvXd9IiVggRvFlgcS9X5nxqo9P9wCoUO
 +kzIwyj5dim5SfyvRef3iifGBUZZrlRy+RbyOFY8wxJMBXwvCFE64bEM3JJ9UN3H3BMCGcqfbJV
 H9Lk6IrFe8/0ug8Dk6/Ln5mZohudMKVgCZlAajvgi1bjKP5zetvyTUoRiWWwkJYcS+ltKhR+kmC
 fqNug4/MJywxkgK7LkdvwHKv9UuMjlP2dReoh47Yjzu6/g1KS4TPtA8F8OLU0ow9uPbyq5fbMwI
 9nSEPDmG0Sqt26FA3oMLgYcYSeORnvL7+q8aqjaeDm556QNFdWymd4EaqpjM/dE0v/e5BeKKQz7
 VCkDZfWztVG8ikgWDZlqigKmOT17qsKXXBP5q/lrRIISwnA5MmtZanbM8e4cWYf+OBxNZ0Cjctv
 hqCshq9v2VHg==
X-Received: by 2002:ac8:610b:0:b0:537:dea7:d3f8 with SMTP id
 d75a77b69052e-53fcbbed61bmr102504711cf.30.1793296520098; 
 Thu, 29 Oct 2026 10:55:20 -0700 (PDT)
X-Received: by 2002:ac8:610b:0:b0:537:dea7:d3f8 with SMTP id
 d75a77b69052e-53fcbbed61bmr102504301cf.30.1793296519478; 
 Thu, 29 Oct 2026 10:55:19 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5428c6d6569sm1934081cf.6.2026.10.29.10.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:55:18 -0700 (PDT)
Message-ID: <4a3a147c-7000-4de5-9a20-33f2ffb77bee@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:55:16 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: Honor Zama16b for Zalasr accesses
To: GavinQin <qinzhengxiang@foxmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261024120211.236223-1-qinzhengxiang@foxmail.com>
 <tencent_BF29702C3097A727E3F9206043AE923DB207@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_BF29702C3097A727E3F9206043AE923DB207@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3MCBTYWx0ZWRfXxFhbqKRtcKT0
 HRrLbxzg2zbp1v3fF57a7m+s6KU4vtynDYaRnQyleJv3EQpt4a3qOqPPgxf5h4Em+dR2rrw20Le
 NXnQ7XVWOOUxlOCdSdSaqk9f57TiHZSkjMEKRXzfKZNQT+vXadHqm8Ml20dM7heI6vC/GErQM9p
 IK5saOcoMel2WMerZfxcm6SPjP/ue3XseeyObnkJZhjuEpHwlfmQ4y1Jazl6ysLlQl6usu2Imm1
 3PsND2bqjhz4Bpi3SAzT4R20uPl7fTzwBwjdkyLC1RhW9vGgL7tZ7hPxqJlwUQONw0QvrNaVggd
 EzLzk+TotJ2t3oQWm4MiTDkJ9OSl0VVvmLzgBhiBdJaQ3Te0uq50k1qmlmoXZV1q37Il2GvUO4w
 Qn7q+mBF59gJho2AUa1cwxBcCmg9z7WS78azsp6bgd2+djCa1yP+CUwMswmrnfM+r2GAVCk4ZNk
 zY28PQhdZ31DDaKnCUQ==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae38889 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=bDN84i_9AAAA:8 a=EUspDBNiAAAA:8 a=rLo9y_UmEUpFpIU9TWgA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3MCBTYWx0ZWRfXzCfVD3zcjCUq
 PZRnq/0SDmfqlj3fd22sG0KnneDmGyXqMgSVfQI6hfRNQFGDzBsa/8HiRNMBocqJnLRwKlG3PMb
 U3yMMbW4TPBIFirnmwV+NMu4siILbY8=
X-Proofpoint-ORIG-GUID: vFID_0YfbQayiddA0asHsrKZWOUlC8QJ
X-Proofpoint-GUID: vFID_0YfbQayiddA0asHsrKZWOUlC8QJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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



On 10/24/2026 9:02 AM, GavinQin wrote:
> Zalasr loads and stores unconditionally request MO_ALIGN. Adding
> MO_ATOM_WITHIN16 therefore does not relax their natural alignment
> requirement when Zama16b is enabled.
> 
> Select MO_ATOM_WITHIN16 when Zama16b is enabled and retain MO_ALIGN
> otherwise. Preserve the existing acquire and release barriers.
> 
> Signed-off-by: GavinQin <qinzhengxiang@foxmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


Also, this patch, when applied with the other 2 previous patches, fixes:


https://gitlab.com/qemu-project/qemu/-/work_items/4101


So I believe this patch needs a tag:


Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4101



Thanks,
Daniel



>   target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> index 79b0b2c63b..5bbd06a346 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> @@ -29,8 +29,12 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
>           return false;
>       }
>   
> -    memop |= MO_ALIGN | ctx->mo_endianness;
> -    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
> +    memop |= ctx->mo_endianness;
> +    if (ctx->cfg_ptr->ext_zama16b) {
> +        memop |= MO_ATOM_WITHIN16;
> +    } else {
> +        memop |= MO_ALIGN;
> +    }
>   
>       tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
>       gen_set_gpr(ctx, a->rd, dest);
> @@ -79,8 +83,12 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
>           return false;
>       }
>   
> -    memop |= MO_ALIGN | ctx->mo_endianness;
> -    memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
> +    memop |= ctx->mo_endianness;
> +    if (ctx->cfg_ptr->ext_zama16b) {
> +        memop |= MO_ATOM_WITHIN16;
> +    } else {
> +        memop |= MO_ALIGN;
> +    }
>   
>       /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
>       tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);


