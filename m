Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ED8CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVD5A-0003Ic-An; Thu, 04 Jun 2026 14:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVD50-0003G0-LA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 14:46:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVD4z-0005Qb-0n
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 14:46:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654EgCFT140669
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 18:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5Z90JxGA2J2Cg/jStNjAioFf
 q+A+pJAGttKcxd4114U=; b=GZCyszeh6fX2L9Lm339A2YlvcfTm6jl/fKJHG9FZ
 xVGabVtxguwM8it1u9inOwJV/QC7dUY/z+IlEyOhBHW6fYMGciTrRbJfAymAQ3zo
 t30yGtVsLVFRtChR1GzgrEcHoDICrCbnfTfifaliI+JJOpy2ZNfzPi3CbSA+FfmT
 A28UcOVTXVO5uyQO3r1/YWagb9bPZ/IEpacQjgQCWNeilyWIEBWIekmtf27wEcJx
 KfnPjxeWKQRgSh5ZLVkI2wc3rI5PcSvmmPF6JKoNnS49u3nV4OyK9TpwEruD1FKf
 i15v9l2nTvBUOWI+i/NNfxpBajDdJBn4IgUAT3fGbrkkZA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejyenc50j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 18:46:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304e4636205so425383eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780598764; x=1781203564; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5Z90JxGA2J2Cg/jStNjAioFfq+A+pJAGttKcxd4114U=;
 b=fEosVnZ15mJ3FaiA1wT45cYlgkjxqFLh5/rXYvnfKMxAClZ4th0mrOiQ9Ig65SSb36
 MItdnSAjKQmIc9vfIEnJjYVbQQ2KHfPFtmkcp4jCHxaSofMmETlDlkLgCmqu/bQGcHCC
 A4BhdZKnmjKMQ2RQmq3tEh3NzLHND7k76CrRGDVg3ib6YJ2UfKUzHWMt1QtFEVQB/S9A
 qv76ZGKyk89a2ph+bR1iRtbxjkWICJXiYYBD66E4eXpcKFR7yqQHkvXp0pcjZ1l9fhaT
 eZjwZc/eRVjXKVBMJ/NUlfdLawzwCUt9mXj3CdVQ1TvNvnDdu4v/Tl0jxa0SNRymc2Ln
 2GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780598764; x=1781203564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Z90JxGA2J2Cg/jStNjAioFfq+A+pJAGttKcxd4114U=;
 b=PWadAuEXv7QyYblOBH8/ZKM2rrs0APe/pPjvwaYUg4zkiLQZXNu6DkhVRcfUloey41
 Hy2UcL6Rb3FxuYpOlwaZREsvND/eSQj/Y8cwCr34lCK1j0WtbNYHuxMbkzfkCrLn6VwX
 tu92CJW4qcJrm6uYxvDzBM3EsnDnZ64BHX2tywjw0v2qKVzWi9Smy2DJab71DwXVznqi
 yhStzrVIXI41uztmvzScrfFviL0tPEouHvFNB7BBnd0dvPM5HF+JiFPU9f0Y7vvBhcP1
 wcCHlCtcRykV9t9ZyVQ6Y8F15UmXYJJED4g2BpWUj4/yFAxv0wWnN4NYsC8OMmbz2/ea
 hMUw==
X-Gm-Message-State: AOJu0YzW/hywK25GzDGpTT+NlpWxDoDm1ALGaarxqDVOPFpeXtwAC+Z8
 57IK2ywnL926NjmwdSbBuhs3V6MOjrKUh5MPWfhbi9ElbxbE22kQEkYb9F9M1xr4nStI6Kn6jFq
 gv7lWGcnYHFt7EIIRcetcrPkpcZbBHavQMkspjVviiyozdzaHPhd9fpOV1Q==
X-Gm-Gg: Acq92OFtv+oAUoJtVd9NSvYDpwoz3kkGEClIzoTkLKbFBqx4C//S56VieO6PGgFSR1b
 7Aef61PmAwBo8G+OP8dxtdd3nhvkcPNRWUG3Lsik4ND4mjD5nNjet4OJNB5onaRuDDxXTEi43IH
 Byk0SjSFohnE4G0Nh2GO8M1BXjtkcQ2QpW7zf+zFKZpuTTpHIesSaSAJYkvouPvWJFsQDiOmF/S
 FXHWwv2scR2WqAqdlEdFICsWYdkuTVIbxYmrZa/v3P1++vleHNNzsnBTXdoeGfVq/j/yn0At7jJ
 kLSSho5eI6BEdLU7yMTNIPYR8xpwjh75mzfNZEqPhppYTbWWL1mnTL+7UzTNwXryKpOq0wv6K3l
 DRWoM9NHEwYfJayqV+DGxwJ5qiSld03bTMtadpYupLQ==
X-Received: by 2002:a05:7300:df49:b0:304:d75b:f5f4 with SMTP id
 5a478bee46e88-3077b1e192cmr874eec.16.1780598764099; 
 Thu, 04 Jun 2026 11:46:04 -0700 (PDT)
X-Received: by 2002:a05:7300:df49:b0:304:d75b:f5f4 with SMTP id
 5a478bee46e88-3077b1e192cmr849eec.16.1780598763517; 
 Thu, 04 Jun 2026 11:46:03 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df191d0sm8442479eec.21.2026.06.04.11.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 11:46:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:46:01 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
Message-ID: <6kmy2hoeph24psgn5cdtkb56djgtlth42itwgetcbcoesxi4im@275pvrh4qjhu>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JaSMa0KV c=1 sm=1 tr=0 ts=6a21c7ed cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=V1jnuoLLAAAA:20 a=uTRCLKPYAAAA:8 a=EUspDBNiAAAA:8 a=_IAod1NrByNiMFFobFoA:9
 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=T-agBWn15iSmxapsA1lH:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: Erj8FjDNa4o08rovxFg1ExIVR3YGHt2z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE4MyBTYWx0ZWRfXwsNSubRO9T6r
 NTsgeCVjwPE/YTn0d8YfehHTQs2WNZMDM8gVc5HALFjOKUp3qFHZ/vS/k6+YLCtby++yo6JjK0Y
 /D0hKjtyT7mO4t1+X83f456aUgHoBfEctEMZqBarxrfmI0LLtAALBuOhepTtQrDBHBBN/obAdRo
 A6gmgfOpB5pytx4pDjW0MkkHS2g9XmGP9bqfuD3TSyU2F/Mvv0gRoZUs78L6G9wUeLzS7v5ppAm
 8HftR0z6a6KuBXdOST3Cl+Kf3AQ1SFiiCfVzd+QPZW9EXie2LuiY00RlNIegNEYbWIj/b+QTbWX
 x6KHXz6rTn+VKuu9UR0Zj012jkYDQr613dk091i5Qm9kBtl/u6hJb92pH09UOuUCW3OZml5esXQ
 RW7f+fwXPRGdbsliq8PBb+MRc5F3Sx+kGVNny/lZ16Z2wqZFNKLtmq72jOiIIaeQzmv/rkpyOjd
 0HHDHuNH32mAi90Q5yQ==
X-Proofpoint-GUID: Erj8FjDNa4o08rovxFg1ExIVR3YGHt2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040183
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 04, 2026 at 06:52:41AM -0300, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
> 
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
> 
> This patch provides a new "riscv-server-ref" CPU to go along with the
> future "riscv-server-ref" board.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> 
> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 30dcdcfaae..a150acd151 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -42,6 +42,7 @@
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3f0f931335..c4a5a7f1cb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3315,6 +3315,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  #endif
>      ),
>  
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> +        .misa_mxl_max = MXL_RV64,
> +        .profile = &RVA23S64,
> +
> +        .cfg.ext_zkr = true,
> +        .cfg.ext_svadu = true,

Svadu isn't required. It's only a 'SHOULD' in the spec. We should remove
it.

What about Sdtrig, Ssccfg, Ssstrict, Ssaia?

Thanks,
drew

> +        .cfg.ext_sdext = true,
> +
> +        .cfg.max_satp_mode = VM_1_10_SV48,
> +    ),
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode = VM_1_10_SV57,
> -- 
> 2.43.0
> 

