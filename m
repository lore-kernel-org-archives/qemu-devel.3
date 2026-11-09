Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0EF60A2603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lw3qeh8v;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYCIISgh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVWb-0003kA-Q0; Mon, 09 Nov 2026 14:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVVt-0003Es-7q
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:58:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVVp-00047s-FP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:58:44 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9JgXGM1831470
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N4OpwGmd1FE4n/ZBaoLFvgDbFDPAKq76y+dCHmGCx1Y=; b=lw3qeh8v4hCgVUZr
 6BXalgrER/g2unwk64DSL1SROacV8mn+OFVQGITBjAKYYMHO8/6JmfLbGb5Oa889
 VXIul19PeFFMwg+fh4ymQbPJ4ySyc3Mnft3+uDPwmNZsOznU/pmXe2k4lnxbCOz1
 CIjNlQ8L5Wo6yOwjyP6QdjcG8CcWcW2Qh9DF+mvLfQGoMSxFB73d7AiINfCmwzlG
 MI/W77vQs9IKvsZGR/cLm9y7m05ImqR1jL2NBRcbjJLVqWdeJRlr3t0dETZaxT7m
 o7IIgM2InbGpRBORWJMn1PMP7X6icyPqjMwPHxsgbna4aDQPQgq6P8SpJBNUFMzO
 MxtLOw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg01pn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:58:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91ebc622dc8so34867126d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254320; x=1794859120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N4OpwGmd1FE4n/ZBaoLFvgDbFDPAKq76y+dCHmGCx1Y=;
 b=LYCIISghGOEZj+gW9xPEcE59Re/aujCEf+k+R/GBQvIr6n9gYukMB6NdACAmhgfbMW
 5CTvU6j43hlUrGVuzIDizknDZgjdrMPsSXYBUi42h77R7bzlYST6l7agh9YwyX7JnTv/
 YGfSNlHp4VgpbDpSJRqL7it2tAnLVTajM30P+czQGVcJ45fgUw4xMTT3s/3ekkkd3IES
 yq34H8ucx8rPP9AlvokNzWjNja82b2JX7SXWPmr1WFHcXCdxGuxD+6AvoxgDKWbGt9+d
 ycAyEY0GTDa6RfA1mNpYZiFsHoRloCxXApNmBoVjk7ZZrVEQHALHxsQ5ooEmIRf8YaUL
 DsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254320; x=1794859120;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N4OpwGmd1FE4n/ZBaoLFvgDbFDPAKq76y+dCHmGCx1Y=;
 b=LNyyxZHyV1eQ7CXW4aikmmlg5nC/mwLWqALVDtFztMNtW7UtybnepzKHpM5Wy9Rev6
 7fGdRTiCOAho0TCsm9oqgfIeEXT3X2UDcUV7bVgUb79wgvDlq2x5FwRxcGUIXTRdSw9t
 4QPx6rPJnguMiHJfnviXioOGztDF6T6+1U8IyOroqG7c05+l5XebZ4uPZfA79JR64d4u
 dQIANpnWyj80a9btkQUu3C8HO8PDa/fBmxBrWXXEh47ifloydMXeYBxtd2wRl+0jHx4Q
 OvQcfn79MyveKOLeMZQ6HWnoX7XoG/9tDoPLOn9GPk5RBA8jcT9in4prZASUmns2mmck
 mSrw==
X-Forwarded-Encrypted: i=1;
 AL+hErHf8pcgEeJCHLh10YL+6ht9jn+MS2Nfi9E8fxH6Rd+vz5MhxF6ou+om0/AqacvGzEfpQoKQL5+keH/t@nongnu.org
X-Gm-Message-State: APuU4Z85SUgXe6BjJ+KGitMUt8AMS9xHiff1EkFVehfUAIaEOC5kJxGB
 62lRaZBOoc8u8Lh1HL9jtAeDTu0oGRy7UXcNZ3if6xDKGHy7nRfh7Mq6ub7PLIZKCtT1d4x7U4q
 aBpz+daw8OUo8WopzNFRz02EnhhcFfHCgQhRJjIhznQveCA5jIzf67ZsTHA==
X-Gm-Gg: AYBFou1+i3FlsyFUP8zbR5JDpREDxTWv75G04jumcGcZ8uTEY/W8sWNCfiFCJsG4XJO
 1ED/zIG5xndQwWFbY2KLNzR+bsF1Se3fxFvxWMR4A5PSJhy/W70aAIBgVVEJShrlBj9r/Xn0Q0l
 T507G+cTSBJ2XxgnP4woRQPOVYUl8Z258oAGUkO/L42W+lDOcNZ881Qo9qgu4tI+3JAgwdqR6NF
 MP/EgEIJlRCxKLO5xo8yrNWx/l1vG7j9T1tDvolZKMkYa2WtXZm0g6TbkQS8x5yZPoOmsRbt1tx
 gP8jNgSGTegnaJ4yqd/3THXRiHiJPy1aFPKMKqAcNupXtfQIU59Qz9PnLt95EzRWuIqYoXkKp3D
 /b3d4JHu433q8sQu18258L3qSEUx9gYSrHEuwD5kyellaf/cLsiodNBVDnYiq2+LwvP2jwnNwcB
 APdAklFLmj
X-Received: by 2002:a05:6214:3d8d:b0:91b:8059:5037 with SMTP id
 6a1803df08f44-91eef7d7aa1mr13751356d6.32.1794254319715; 
 Mon, 09 Nov 2026 11:58:39 -0800 (PST)
X-Received: by 2002:a05:6214:3d8d:b0:91b:8059:5037 with SMTP id
 6a1803df08f44-91eef7d7aa1mr13750996d6.32.1794254319154; 
 Mon, 09 Nov 2026 11:58:39 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04b1390sm3820116d6.14.2026.11.09.11.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:58:38 -0800 (PST)
Message-ID: <3c2be837-b68e-4455-80a1-914438f5cae1@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:58:35 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/38] target/riscv: Add Zvqwdota16i cpu property
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
 <20261104194155.679241-9-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-9-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfXyR1pEY+8tPk/
 1HfJvPqAXTtJtJn6P/GttiP/gziHhO/2CZ8HNz+3UXSi+6UePn4Nx35Hssvjsx939hIPk0/fAwp
 fYvrB2Qlgh7n+C9JN+dUxUVpz/wYMPW9M6+IloHNdiGzUeIIIbT3wpHTHcdnngxgtycDcKhAG2P
 +fGYmQFJ2Y4R/rKq0STUc7/0qnXd8vLo8WvoySw4MhucJM/ZAcc7O51bNUCQwol6g4rmHFL1Yev
 PqTtsAFYbsQJyk0MnCSv3LUjmluFVeCMGzQsBRQc1lBWTKByOHJDlIdZuVp3vf/lPljDI2cbjT3
 kSP+0MNU3Y+NDMary3FzyMaO+APdt0Qm2TL2MbkI0T7eZiGPUueUj/vZ2m+CRz8NTIJYtGXuODb
 XKvpZtAGd4gx26pfI60zJTn1JtAlOI5NcEG89srdRjioIbWMFlmcqa+RQNfWs6WrysiCtevtkIH
 78EPqDFZuBUFssFT68w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX0G2J9SDCHsp3
 VbgOOHCGj7ZjNeJejovNommzM5IAxet0jOp+lBHJAdLMJmQfqxbHdAoJEydYJPU07QgpTJqr8p6
 eh+CWWO6X2QFOSc8OuhRZAfb/qUtKSs=
X-Proofpoint-GUID: _swu4f02G2Y5gpBw4WCULchDiozqYSA7
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af225f0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=ZQACqZGsbTNtLU7ID3cA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: _swu4f02G2Y5gpBw4WCULchDiozqYSA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090078
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add CPU configuration property of Zvqwdota16i extension which depends on
> the Zve64x extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c                | 2 ++
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/tcg/tcg-cpu.c        | 5 +++++
>   target/riscv/tcg/vector_helper.c  | 4 +++-
>   4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 08b14782451..7873e67c053 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -250,6 +250,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>       ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota16i, PRIV_VERSION_1_13_0,
> +                                    ext_zvqwdota16i),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota8i, PRIV_VERSION_1_13_0,
>                                       ext_zvqwdota8i),
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 0c08d688ac1..8bac69a17f7 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>   BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvqwdota16i)
>   BOOL_FIELD(ext_zvqwdota8i)
>   BOOL_FIELD(ext_sdext)
>   BOOL_FIELD(ext_sdtrig)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1c51ea94489..54749125acf 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -696,6 +696,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvqwdota16i && !cpu->cfg.ext_zve64x) {
> +        error_setg(errp, "Zvqwdota16i extension depends on Zve64x extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 6abcf522648..6d79fb5d299 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       target_ulong reserved = 0;
>   
>       if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>           riscv_cpu_cfg(env)->ext_zvqwdota8i) {
>           reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                              xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> @@ -93,7 +94,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                           cpu->cfg.ext_zvqwdota8i);
>           break;
>       case MO_16:
> -        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvqwdota16i);
>           break;
>       default:
>           break;


