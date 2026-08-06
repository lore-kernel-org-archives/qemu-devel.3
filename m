Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A43FC5AC7A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws5GV-0006Zw-03; Thu, 06 Aug 2026 17:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1ws5GS-0006ZZ-RE
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:04:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1ws5GR-0001rm-3p
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:04:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676L13mv2802262
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 21:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qGvnrUROuEwsFda9jNhqtRXGaewA6xz04z0ommV+Gkg=; b=ogb2lLnuqHkKpW06
 7ogTj0aJ+cAIE5XESekUgPds38bVH0lhPDJ/E6gbunecYD/dKryxmlZlTnS2sqqm
 +hxwx2fFxV0fUxD1U1PPhL+SfU3rwYuDfbzFvBQk+EUqNmvCSQ6y+cumgkmAOBoe
 /P7UH9qHx1LnVczmeYRxMs0drIJxWZwa4RPUgLCh33Ah2IwvfLSp50MRcKUidAGX
 rDA6odCJXeKJrcTdUU9GhCP2AYnJiRVNeW4c097sNlXidmGnsLEbD4BexaTV2mO/
 ZXnjxBxqem9Gp8nRsrptGyITUoU8pg8vxWMdrP7LiNNe4I0Slm1NpcnA9nKdoYgi
 mdIWIA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hrr4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 21:04:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4f27f49bso212293685a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786050269; x=1786655069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qGvnrUROuEwsFda9jNhqtRXGaewA6xz04z0ommV+Gkg=;
 b=cS75skOT7bF6Xdhxc6xBz1Hs9g3sztNqRyN9FlCDiFTmnqokYyFK8oS7woTKT1E7CJ
 kFNbMN/2q9UoPNOTfLzorMBlMZMJUhWCwWl1zS/IqKn1Zgm4EJPt9jH0/CmO5rpqsQQp
 NKOhdQETdygvFd8REJ1yU293TGrDlLjMfRdhuHzGrvq7wN+UwSYzV/tkZemyn3s9Liff
 sC14yxp2hqIE8T1TlWgXZvXJYUJu/M6PG6FDzV4DC1zjMhze6xovIseevUftCRcn0LAc
 Fs0E2xaEkboatKTednKdTwJY6HtaX4mMAaSFnsM8gF7NNnEy9KIvrux+tzxNJ3bIhvmC
 hbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050269; x=1786655069;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qGvnrUROuEwsFda9jNhqtRXGaewA6xz04z0ommV+Gkg=;
 b=QjJTMtjTSDUY11F5+4ZFnXGrdqe/79qg4ndyq53sskq/HbqKgljhTFwb9iJazu9NJq
 3k56/gOkCqxseQSSE3AmFn5ThqmLkT59UK9Mu0bn9adoHovMWbX/1CELnde4CRhY5+/C
 xplE1BvPyWhPxmb++YdDLf8LGJBxVdbqIXSpbyv//oMAIyZ/BqFrfD5qAg0AFxltFnTf
 PwnqTkrAGvHtGZdcqQt/tp9IYAzNMl8UQJDn28kbuRxCy/vyuLfx0vg03IN7PNMsPmNJ
 l1P09nVoPgQGqEhWlSlm0y0H6hqBwQHTJWqkxNbsuT/BazMN4sQJo7myS5/gv/UX794y
 I+qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLi+24fNIP+wE2GpcF+1bx1xv/8rSmMvvS99OpqyPpOkU2v/Sau/+kynIi5lbpEE9sII8JAiWdjxI6@nongnu.org
X-Gm-Message-State: AOJu0YzG8HDKeQtAe637igpdU+MOgHisrX05ppUjmERv0/yftJZTUnvd
 9KFUOY3+aF/mkfCyt7vSAKuO2wnbM6fHk5tgPCLv5Z2HSIWGhpLN7yfpxaDzdyXRsoSPRLVU/51
 fd8uIY1LCpvWfb5DbyDK8iqSeEpccErfj449T8Zl19UVbE2CcABczjnH9lQ==
X-Gm-Gg: AR+sD114IjjauwNzlsMT2pLdmh3IehDVSNSGL9i9mRJy2mh2EmzeQaQWBBMGw2Th6+t
 rna2hr7R3hJGlQgVOySy9ljpliuB5hfS9sdjM3sEcLPOBWw62+YePuVe83jKpPOLCQkz3y3TyDB
 sBEGCT6iGiufkhr3Pvbyud0nQ6BPsTZARSGDRv/oXKPxA3tKip/aLOehQ7Qq2UnmcqIGs+Y4JT+
 27+LqnOfSIr2n+h3zQhXkMDfqLIy6hgQhJateAmN94RyET66ZK/BYZqcYucZp0bUY3BkWRjtT+K
 WrtSdBzM5SEHlC2nqQG2zYQlYF9NLYo6IjYZ936rw7c41Vep7bNjm6JnubL1GsrCKeuf/AiL3nd
 r+0us9C6gjC0TKjopxmxjCTaF4luHTQCpQNLD
X-Received: by 2002:a05:620a:a70a:b0:930:b068:8c03 with SMTP id
 af79cd13be357-936492686c9mr1688761385a.34.1786050268617; 
 Thu, 06 Aug 2026 14:04:28 -0700 (PDT)
X-Received: by 2002:a05:620a:a70a:b0:930:b068:8c03 with SMTP id
 af79cd13be357-936492686c9mr1688752185a.34.1786050267970; 
 Thu, 06 Aug 2026 14:04:27 -0700 (PDT)
Received: from [192.168.68.103] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a5662d5sm491124485a.35.2026.08.06.14.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 14:04:27 -0700 (PDT)
Message-ID: <5c644bcd-fe57-42cc-9206-df9c5b49da26@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 18:04:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: Add cfg property for SiFive int8 matmul
 extensions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260721122034.1567146-1-max.chou@sifive.com>
 <20260721122034.1567146-2-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260721122034.1567146-2-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX/ji9oBAlDviQ
 6oj0ANjVbhWH4j1TggOU4XhJdCC+bCjpZtWNDpCs1OEkKiK4mUJGtRjv0H3CA0k1iWQKDVjyPyg
 ntW/aEVpdwJ/Pny6XagH+OB/oTIpxv8=
X-Authority-Analysis: v=2.4 cv=PK0/P/qC c=1 sm=1 tr=0 ts=6a74f6dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=JLpZLuN2F1KTlYp6rPoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX4A5NDN+Cz32Y
 dAX5NJ9+i0U2FiPgnENvIXHq5sa08FDXjjYK+VfXJFRKZFcVf+MC0cOaFnvApde+9OU0jsSmetO
 sJua0DzeutPrnB0CVI2IHa+qfxZcGpxcIWXF6pVThKW2C+SOsbqB000xDziv5UXNnHSxtuvF828
 F3RUJRzCfnzH1PlRBqWjt36qU5mcwLcETYRi7JW1VOJ5dxP/X2o1wfTXFdQgtHarHS7o0xGhTus
 Xi75ZFOyDBKMJvi6v4d8ykMZy2C3RaQe9FjXJu//JZea82KGWA2i4wmbX+lGakTHEMpnivBFDFG
 0CR9PdPDA756cDlgCjfNCMfKadONOE60Gi2uNYMXqoamOqHgZa/FcfbZaUWWOm/Vvfmyqemvt0m
 8Ukz9BvU04Nv1+31NbgBNAxrN0xaL6kvNh0h2eQN7y4LI8jedDUfCOKsEtHApZKd58dpDmmbcbR
 HzW3gd1697WYqhcBBBQ==
X-Proofpoint-GUID: aS4xNq0AghBnaRRi4BbC55bHlTSf-pJB
X-Proofpoint-ORIG-GUID: aS4xNq0AghBnaRRi4BbC55bHlTSf-pJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060163
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



On 7/21/2026 9:20 AM, Max Chou wrote:
> Add the CPU config properties for SiFive's custom int8 matrix
> multiply vector extensions:
> 
> - Xsfvqmaccdod: 2x8x2 int8 matrix-multiply-accumulate operations
> - Xsfvqmaccqoq: 4x8x4 int8 matrix-multiply-accumulate operations
> 
> All instructions of these extensions require the Zve32x extension
> to be present whenever either extension is enabled. Validate this
> in riscv_cpu_validate_vendor_ext() alongside the existing vector
> extension validation in riscv_cpu_validate_set_extensions().
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c                |  2 ++
>   target/riscv/cpu_cfg_fields.h.inc |  2 ++
>   target/riscv/tcg/tcg-cpu.c        | 16 ++++++++++++++++
>   3 files changed, 20 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a82e6563b..e643d7c7af 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -298,6 +298,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
>       ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
>       ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
> +    ISA_EXT_DATA_ENTRY(xsfvqmaccdod, PRIV_VERSION_1_13_0, ext_xsfvqmaccdod),
> +    ISA_EXT_DATA_ENTRY(xsfvqmaccqoq, PRIV_VERSION_1_13_0, ext_xsfvqmaccqoq),
>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>       ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>       ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 9eb47af0a7..73448fab5e 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -156,6 +156,8 @@ BOOL_FIELD(ext_xmipscbop)
>   BOOL_FIELD(ext_xmipscmov)
>   BOOL_FIELD(ext_xmipslsp)
>   BOOL_FIELD(ext_xlrbr)
> +BOOL_FIELD(ext_xsfvqmaccdod)
> +BOOL_FIELD(ext_xsfvqmaccqoq)
>   
>   BOOL_FIELD(big_endian)
>   BOOL_FIELD(mmu)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4af5cd9c73..c90023a212 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -417,6 +417,16 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>       }
>   }
>   
> +static void riscv_cpu_validate_vendor_ext(RISCVCPU *cpu, Error **errp)
> +{
> +    if ((cpu->cfg.ext_xsfvqmaccdod || cpu->cfg.ext_xsfvqmaccqoq) &&
> +        !cpu->cfg.ext_zve32x) {
> +        error_setg(errp, "Xsfvqmaccdod/Xsfvqmaccqoq extensions require "
> +                         "Zve32x extension");
> +        return;
> +    }
> +}
> +
>   static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>   {
>       CPURISCVState *env = &cpu->env;
> @@ -794,6 +804,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    riscv_cpu_validate_vendor_ext(cpu, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>       if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
>           error_setg(errp, "svukte is not supported for RV32");
>           return;


