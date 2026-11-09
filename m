Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56323606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lsmy5xQH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G5EqggHm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWAp-0001oe-I9; Mon, 09 Nov 2026 15:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWAo-0001nR-4H
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:41:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWAm-0000ET-26
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:41:01 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH5Fg1525221
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kDey5YuYlCH6b3s/EDsMNFyySCAuMWQUrurRBOM11iA=; b=Lsmy5xQHQ9T1600y
 IFFZHK1VP5zrkIdWxctt90ilwtBKEvs1hnFkNczFm/Y9Ah/epRBYWsVbcn1RDXqh
 akLE/404j/RWbItDj65bgecBE+dIOrPhvUGgVJ0Qy6S5CVXt27G+qFlLHnf1wO1O
 Cn+3PhbwmFqgkH+DmYhsD9QO+/vtX8TocJr6+rCx9PzSPdBGf0b1cIOWy5hctdxs
 VX7rK2e2h2xgDULgzEMoJ45mqkkOa6ykdl1YflFkFBS+EssEd0+psmAgGCRFNGXl
 qhyag3UqeHdGt9W2NFuWTHxSnLrDTyzAc0fDsy00nRrCHPAMMPcSmCqOqXOrKWcH
 6jiiyg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx81dw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:40:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91eacf20364so26788436d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256858; x=1794861658; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kDey5YuYlCH6b3s/EDsMNFyySCAuMWQUrurRBOM11iA=;
 b=G5EqggHmxk8MAfKLUuAy1J37JaEsbMV6X5DG3dj72wIWfqMzRKA7WqETUA0Nayu5t+
 O2lyNjBRYdhzn5ccPj+5l3NHDdjo48aldGUo5/uAm6LuB4fzmniXug7Jr7CM6qBd+kG8
 oVBv68gVipOxnkqJsjSIqZymMsa3QVuOXpl2LQnH8cjTI19J7gSL1sK7w20VEdTUUWCs
 zrg5Mi7/aKfdyyJd3rYbodrRg+PODhGSbS6TkmA5ZRcEjLFkZlsX4JD5B/1F4pvU6sfp
 mciJBi4AKWqAO7kw6rd+C1kCX99xhUZx64UuxHqsrlizZHz/EXZHO4Ncc9hejVzUoKA/
 8aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256858; x=1794861658;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kDey5YuYlCH6b3s/EDsMNFyySCAuMWQUrurRBOM11iA=;
 b=Z/uftfLYMr4EDLjZauoFp54zyK8k/BZawbn21zMCnrTPN2f4sHcpHJWu/V9BCJipKU
 z5uggPb4GaNHi/0DNpOU/COwLWy3JhgQLni7RA7X7DCSjOx4F2W6A8E9F2xMCfzRh2cs
 JgSjUoYlQz7mPkMk0JSQ/QVwfjzYVujDLTM7XevsBTljh2X3c2yT+lYT8YsPmnS5kEpf
 bZvALdkAaJxPC+C/x/fKXG5DFrRTmrennq7Z03F6DbeCDr0GRWbnSRDs7v9iSRr9DXDE
 bbI1G3FdSpQIdNdJ1D7FB56si65mFfUdeH2KHQFrEKt72e4iWmQ0axne3/FapBvrAVBu
 keYw==
X-Forwarded-Encrypted: i=1;
 AL+hErGQyz1j7xll8/OStqX2+vORz0PbCob8H4X1MtoSR55wFXMTe8g9/EPuqQPWE4ZtzVBT1vf70kNrO5qp@nongnu.org
X-Gm-Message-State: APuU4Z89CfshGQepyGkGOv00NFz4oU2lViP3nDWmEXXxSiUJEFZQS0O/
 nLXCCZa+sH5Rj42BkOOW5fsuGGMjCjSNJy6niRHfJoJd/82MlsEhA9L9xxw57ziZfiybQ7TLM0L
 aiSKIK60Z2n3Izg361OyqF6H6k5YxZZtYYRUeGzndczj/YfgPwN1qA4b+Ww==
X-Gm-Gg: AYBFou04/4n4O2hMp5bcm6Gk1E8zM4rl24y5Y2NN/o3n7zEza2K6lvATXSNoJj7O0zs
 Pjd7g158u020sSAqHweNJaMEghJt1aHddR7sAGLllxmHPecgaJ+pL56PuQkFDP/fnG2Cqs2GsVW
 n7RXYPzsN6nmchtB92rO9Xt3Q242SLNdt4pXUQix30mAD12mCuBKA5igR3oESvJB8SxjXcCjfvr
 EkfWdd21WK6NeBcFgibkkqNMcRXUZG5xBQwk1v12J5+VACG6ewMiljWRzEaQLru0GH6j7QTj+hD
 7g+ZomMtRj1B4sb1Jb839Ny1OfaUiCKaIjIAIrI4c3VzbiuotIxEhgjzcMNFIHq7WjDn4J8vlZJ
 cQi/pytW7oPhEGL8AQp8RFRDb3NRdlCWLvQNqxicHQsn83wziRhLKRIIYb5DbDhuZzl3EJB/X+y
 iF2LzjxbPW
X-Received: by 2002:ad4:596f:0:b0:91b:5d3b:4aca with SMTP id
 6a1803df08f44-91eef8cf6e6mr12978066d6.51.1794256858070; 
 Mon, 09 Nov 2026 12:40:58 -0800 (PST)
X-Received: by 2002:ad4:596f:0:b0:91b:5d3b:4aca with SMTP id
 6a1803df08f44-91eef8cf6e6mr12977736d6.51.1794256857417; 
 Mon, 09 Nov 2026 12:40:57 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef03161dasm4779476d6.6.2026.11.09.12.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:40:56 -0800 (PST)
Message-ID: <ef7d2a6f-4a1e-406f-af31-db64dcd60c69@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:40:53 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 28/38] target/riscv: rvv: Implement Zvfwbdota16bf
 instruction
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
 <20261104194155.679241-29-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-29-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af22fda cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=owuLqVZQPyryOtm3G_gA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: kGa-fqlMVQJpQgMtkrUSe-jT2rPm-_8_
X-Proofpoint-ORIG-GUID: kGa-fqlMVQJpQgMtkrUSe-jT2rPm-_8_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX14BmVgf8+Cw1
 C/kHA5fTiNdijHag6Nqc07pcxOtJ2EU7P1zG+mx/PLdLMoGXcsahkFAjDI4TiCqOgSAc7rT7sqh
 7/E94LkRnLjCP7qilVIyNYlKsRkeWcE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfXzSEd+B6RaCIx
 vCMuK6AaCx0i6qjhiKtN/sr47kXn2goHtPZ0mXEA4ZnL2k/E33DPQainbaYHXFuYycGZje3rIEK
 ZHFr5ggNPqDJJaf3+2vqkDwCnIK+9XrdjWFHFlteT3uNVr0g5dYyXEkH0SIe7sbFC97zJeOFx8g
 GjRbKMfjZmKOVr238/ARDDJYXoFxFGpnJupasGPcCi5jSo/5ZCnguI/c8iV6aPLAC2PGs8c2ri6
 8tyrmQ6W6ME6741rkZ/107zsxWWpRO++BQPilIQkQ9rSQDBB8SnBiNnMOlwzGoX2rwoLdD8abye
 6XG2v12jKIpi4bkQ//Z89BKtlkwK4I+HYMw6luZ5RZxeI7fB7jmkNS1LxoZZXuwd/GKAXAXMV5V
 LDYODycYHGP460oZqQChk+U42OFSzTWUFxeDUnJ0zitSAl4xqakTWILIEH4rOHPosuAGiI3FJH4
 j5TetXWGv8VDExerddw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> Implement the vfwbdota.vv instruction from the Zvfwbdota16bf
> extension.
> This instruction performs a batched dot-product operation on BF16
> vectors, accumulating into FP32
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/helper.h                       |  2 +
>   target/riscv/insn32.decode                  |  3 ++
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 52 +++++++++++++++++++
>   target/riscv/tcg/vector_helper.c            | 55 +++++++++++++++++++++
>   4 files changed, 112 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 84571a999f4..1f2dfd6d557 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1395,6 +1395,8 @@ DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>   
>   /* Zvfwdota16bf - BF16 Dot Product */
>   DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
> +/* Zvfwbdota16bf - BF16 Batched Dot Product */
> +DEF_HELPER_7(vfwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
>   
>   /* Zvfqwdota8f - OCP FP8 Dot Product */
>   DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 8a06547a570..00ed64b73fd 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1105,6 +1105,9 @@ vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
>   # *** Zvfwdota16bf BF16 Dot-Product Extension ***
>   vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
>   
> +# *** Zvfwbdota16bf BF16 Batched Dot-Product Extension ***
> +vfwbdota_vv 101100 . ..... ..... 001 ..... 1110111 @r_vm
> +
>   # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
>   vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
>   vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 650affc045b..d4678171ac5 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4365,3 +4365,55 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
>   
>   GEN_ZVBDOTA_INT_TRANS(vqwbdotau_vv, vext_vqwbdota_check)
>   GEN_ZVBDOTA_INT_TRANS(vqwbdotas_vv, vext_vqwbdota_check)
> +
> +/* Zvfwbdota16bf BF16 Batched Dot-Product Extension */
> +static bool vext_vfwbdota_check(DisasContext *s, arg_rmrr * a)
> +{
> +    int32_t sew = s->sew;
> +    int32_t vd_eew = sew + 1;
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvbdota_base_check(s, a, vd_eew) &&
> +           (s->cfg_ptr->ext_zvfwbdota16bf && s->sew == MO_16 && s->altfmt == 1);
> +}
> +
> +#define GEN_ZVBDOTA_FP_TRANS(NAME, CHECK, EEW_VD)                       \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr * a)                 \
> +{                                                                       \
> +    if (CHECK(s, a)) {                                                  \
> +        TCGv_ptr dest, src1, src2, mask;                                \
> +        TCGv_i32 ci, desc;                                              \
> +        uint32_t data = 0;                                              \
> +        uint32_t vlenb = s->cfg_ptr->vlenb;                             \
> +        int32_t vd_emul = MAX(0, EEW_VD + 3 - ctzl(vlenb));             \
> +                                                                        \
> +        gen_set_rm(s, RISCV_FRM_DYN);                                   \
> +                                                                        \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
> +        data = FIELD_DP32(data, VDATA, LMUL, vd_emul);                  \
> +        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
> +        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
> +        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
> +                                                                        \
> +        dest = tcg_temp_new_ptr();                                      \
> +        mask = tcg_temp_new_ptr();                                      \
> +        src1 = tcg_temp_new_ptr();                                      \
> +        src2 = tcg_temp_new_ptr();                                      \
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
> +                                          s->cfg_ptr->vlenb, data));    \
> +        ci = tcg_constant_i32((a->rs2 & 0x7) << 3);                     \
> +                                                                        \
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
> +        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));           \
> +        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2 & ~0x7));    \
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
> +                                                                        \
> +        gen_helper_##NAME(dest, mask, src1, src2, ci, tcg_env, desc);   \
> +                                                                        \
> +        finalize_rvv_inst(s);                                           \
> +                                                                        \
> +        return true;                                                    \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
> +GEN_ZVBDOTA_FP_TRANS(vfwbdota_vv, vext_vfwbdota_check, MO_32)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 873adf4d7a6..51170625aad 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6201,3 +6201,58 @@ GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_b, 32, 8, uint8_t, H4, H1)
>   GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_b, 32, 8, int8_t, H4, H1)
>   GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_h, 64, 16, uint16_t, H8, H2)
>   GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_h, 64, 16, int16_t, H8, H2)
> +
> +/*
> + * Zvfwbdota16bf: BF16 Batched Dot Product with Accumulation
> + */
> +void HELPER(vfwbdota_vv)(void *vd, void *v0, void *vs1, void *vs2, uint32_t ci,
> +                         CPURISCVState *env, uint32_t desc)
> +{
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    uint32_t vta = vext_vta(desc);
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);
> +    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
> +    uint32_t vd_emul = vext_lmul(desc);
> +    uint32_t log_esz = 2;
> +    uint32_t total_elems = (vlenb << vd_emul) >> log_esz;
> +    uint32_t vlmax = vlenb >> MO_16;
> +    uint32_t n, k;
> +    bfloat16 *a_vec, *b_vec;
> +    float32 acc, dot_result;
> +
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
> +    a_vec = g_new0(bfloat16, vlmax);
> +    b_vec = g_new0(bfloat16, vlmax);

Same g_autofree comment from a previous patch.  With that changed:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


> +
> +    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
> +    for (n = 0; n < 8; n++) {
> +        if (!vm && !vext_elem_mask(v0, ci + n)) {
> +            continue;
> +        }
> +
> +        for (k = 0; k < vl; k++) {
> +            a_vec[k] = *((bfloat16 *)vs2 + n * vlmax + H2(k));
> +            b_vec[k] = *((bfloat16 *)vs1 + H2(k));
> +        }
> +
> +        dot_result = rvbna_dot_bfloat16_bfloat16(a_vec, b_vec, vlmax,
> +                                                 &env->fp_status);
> +        acc = *((float32 *)vd + H4(ci + n));
> +        *((float32 *)vd + H4(ci + n)) = rvbna_final_f32_add(dot_result, acc,
> +                                                            &env->fp_status);
> +    }
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +
> +    g_free(a_vec);
> +    g_free(b_vec);
> +
> +    env->vstart = 0;
> +
> +    if (ci + 8 < total_elems) {
> +        if (vta_all_1s) {
> +            vext_set_elems_1s(vd, vta, (ci + 8) * 4, total_elems * 4);
> +        }
> +    }
> +}


