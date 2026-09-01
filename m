Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C745BC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Vcx-0005aM-P7; Tue, 01 Sep 2026 17:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1Vcv-0005ZC-KT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:02:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1Vcs-0003IJ-1i
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:02:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KT9P23108193
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 21:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2TIkADdDYKGeGeVyxhzr754GGDvPdN4I3ngKzOkJs+w=; b=Nagn54dlDYHDZVRn
 OazyWPEyQIuSAfdv8DhzBfFpC/ETi8A87VBa6qQy1UwZM5RdLv+L/nCmANGjD3nG
 ZRfOAcllYbl0qCq2ZFlCPZ1hy0syy/KVGjX5izk1MZktDRabvUnTKVmDx5DqQ/uL
 7xViKkLmMdAiT9iws9fbOHoN5JJPYXzvQuK+k8t7y4PmRECCsGy7MDGJpryFZ7zp
 h+QPSsj8BX36UKLh+x8hgbankuQOggBeGmb4yqckT52FLIydTrumUjs8rF2wWxd6
 Lhzi1xI3zHv9P21DHFiWbvctagWn5ntdF4jIRQun0Lq/UBMn2lSyV33vclrD2iJy
 jSYt6Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wp9cd4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:02:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90cc934fe9eso7138596d6.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788296554; x=1788901354; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2TIkADdDYKGeGeVyxhzr754GGDvPdN4I3ngKzOkJs+w=;
 b=eKOcvrYR5v3mzmgc3zXKSBgTl/DXGUz+du3oK+u3Nv4/cIKvEMppk1eLd5nhxzHATx
 ePczU3KOi+aORJPejTUq6GT/C9pCEBD71iSHCazAydgUyj7iLUwnVwWYp49f37w/ysqn
 38KV8GOfuEy4bhpmkOkhvUWa3MSVUpdmJGW1shS6ySXzOKpqIw6K7KVQaJDeo9DFm4DW
 ckqOdbG9UlFF0oIGdS7WJ8Gdv7uThnRk0hNP30BcN9drKCmUpy1AfLym5NAeMIJpX/BV
 YEk6KrAfazAgT0YNPexRBkjHkuqJgrtH+D3uPo58RYUBeYCZOqVQdkrceB9K7oJFy63L
 dYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788296554; x=1788901354;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2TIkADdDYKGeGeVyxhzr754GGDvPdN4I3ngKzOkJs+w=;
 b=iqCvwxf0AXavp+h3Bu6gNWsr+argO62bYD7tWhDAfotmupgS6LZ35T+Tm+xN5Ma2CN
 eyULoDHk2X8t3LVXHMWnnx0aRsl2HacrdGspDBWLbyTHkUuxEjDmJgUUzWRJo9GCTU19
 SkPKdkoYPNjXKhdRKSPGQrFR/qZt5tnPW5rvXiKuWWYpCNFaMeLThgDyxjzj4GH1aBX6
 xH8ax6hCyijgZI0TJSm125cRcOyoMIcOEQnFOzPpAjvRV1lyk6S1Uzue+8nySOxZTUyi
 TdGjYUW2dHtTpGlJMlUdMBCBESSEOGRMcGQnWYht4wkcrtvFxAXGYlyZin28JreLHc3J
 aaMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw81U+4ojuA3kBCBJFcsFUfAZw3Ufcc6AfnoU7RPdr1QOEseNnYv/Z1IkbmW5y8IQPihP2d3s8u5yw2@nongnu.org
X-Gm-Message-State: AFuF++m9zrv0wIQ3hynmJHTupXi43eqdyepNpc2LjAcW0oO7w2GOxI6K
 NJC3hQkf5gUTxLm4T9v0OrU/lCStxoWZNQMRQdgHkYdylNfracN+7dePHxZNPk4bl1bapxWVmyE
 JOm8/TeVYLctYYsq3WoL7rLuH4iBCRRlYPpqWTvgdeqtoHrVqWQ9mhMp67Q==
X-Gm-Gg: AYBFou1Q8mcn8PncKLHxCOI8tPYapOm6o22xB1I+NozXUixcyr3I0pqoLP+mMeczBB+
 Ml1hjBFseF9nnjidNeuoYL4qXLiTuLXRGZTdM9UIGauHlfm3TyYVpMfi/zuX9+y1a5mfUgVK8PS
 ZguGBsZ2x3GaCvxyuf/uYqo9QFXHpBROv8/r8BIvy97ho2FqIS10nGhRPxIHmNepmQUFeVJ4nnw
 QbXgmFQPSceOBDh4plW0GLkp+nz5aYaCZmitOuTgbjeR0Hru2CHzI7jbtxWfXg53zmgpdVo4r7/
 i/8feTlOxlqJqiTxPP/o1nul5OD41LLfo8lQL5pTpakN90UQasuJBJp4zQozfMkITmXKQ/+pLcN
 JnBnlbSGQrCJuZ+uwJILY9oi7pmJ1ziZuU2mE
X-Received: by 2002:a05:6214:1c09:b0:90e:975c:7805 with SMTP id
 6a1803df08f44-90ebab701dbmr7441636d6.20.1788296554403; 
 Tue, 01 Sep 2026 14:02:34 -0700 (PDT)
X-Received: by 2002:a05:6214:1c09:b0:90e:975c:7805 with SMTP id
 6a1803df08f44-90ebab701dbmr7440716d6.20.1788296553945; 
 Tue, 01 Sep 2026 14:02:33 -0700 (PDT)
Received: from [192.168.68.101] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9eee7f12sm2614376d6.39.2026.09.01.14.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 14:02:33 -0700 (PDT)
Message-ID: <87af3207-dee2-48e2-bafd-f8e714c2d566@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 18:02:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] disas/riscv: Support vabs.v pseudo-instruction
To: Mingliang Liu <liumingliang.dev@bytedance.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com,
 chao.liu@processmission.com
References: <20260831133000.982059-1-liumingliang.dev@bytedance.com>
 <20260831133000.982059-3-liumingliang.dev@bytedance.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831133000.982059-3-liumingliang.dev@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a973d6b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=968KyxNXAAAA:8 a=EUspDBNiAAAA:8 a=oV8bDTWlGSPqd8E9x_IA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: Ac4oFOOTSwP9MmWFNDOdGEkFcF0txF7A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE4NCBTYWx0ZWRfX6Vc12swBFM37
 WszhbL1h/G2nH+C2MQOvlb0aAis9U9DU5H9SYVkDMHAb6lOaD+tNaZLHNnQALcHnetdhGApXeLZ
 CWXbb25laMDtbEwVvVBUQfsMlmYj2Kk=
X-Proofpoint-ORIG-GUID: Ac4oFOOTSwP9MmWFNDOdGEkFcF0txF7A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE4NCBTYWx0ZWRfX+q23hnULOcGg
 KvkAqTCjyS+nbFgpHT+oxmpo/L6aQf7dgi3HjEJKVOhlzK2s1USGaQrjWEjzgTor0W9V+wm5Mwh
 uWbpI1XlgL4txKvgpn5Nfbs9kvPziEBhkw2cmzYVFi4qu9AdC6vEBtpR/knB6+bf7JuqHRpSRmu
 YFa9KRi1SfHRe0671GK7YfXYd4SWzENuZWcgwbgGs87yMCQPUcyYINgJSkSqcoGDrXEsrm1SQ7T
 wE2Ea5mVi+rLpekztfblTXcckrGOMsNeRxv0fwEFzDjPLVUezPruRNufU9inO2tw3UatKBtv+ar
 xGQ5s6fgHNnPtEOtdEDNJSTQ6f+2HIBQ88CO071WuJEl5ltshmFoNKS7RKbkiQ1aDS3vOLfCyM5
 XJfcdJc2TdXlWL/nV8u/lZ1Rdcwo36NZzKQpQT7aXQsMiCLsAqgAh+Up/O6/UUhxr4EfaR1ELCQ
 gcAoAFfV36NEKDGpbWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010184
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/31/2026 10:29 AM, Mingliang Liu wrote:
> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   disas/riscv-op.c.inc | 3 ++-
>   disas/riscv.c        | 6 ++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 07b56f5d52..425473ee61 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -491,9 +491,10 @@ OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>   OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>   OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> -OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, rvcp_vabd_vx)
>   OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vabs_v, "vabs.v", rv_codec_illegal, rv_fmt_vd_vs2_vm)
>   OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
>   OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
>   OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index e0a8b3a756..2aecaaa25a 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -103,6 +103,7 @@ static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
>   static const rvc_constraint rvcc_ret[] = { rvc_rs1_eq_ra, rvc_end };
>   static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
>                                             rvc_end };
> +static const rvc_constraint rvcc_vabs_v[] = { rvc_rs1_eq_x0, rvc_end };
>   static const rvc_constraint rvcc_true[] = { rvc_end };
>   
>   /* pseudo-instruction metadata */
> @@ -242,6 +243,11 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
>       { },
>   };
>   
> +static const rv_comp_data rvcp_vabd_vx[] = {
> +    { &op_vabs_v, rvcc_vabs_v },
> +    { },
> +};
> +
>   /* Convert compressed insns into normal insns via pseudo expansion. */
>   #define DECOMP(X)  &(const rv_comp_data){ &X, rvcc_true }
>   


