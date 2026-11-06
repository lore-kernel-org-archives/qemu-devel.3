Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A6606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PRlNcz9P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J9UBjCrg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQyr-0000mo-23; Fri, 06 Nov 2026 15:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPQyk-0000lr-Ud
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:56:07 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPQyi-0001xb-Vq
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:56:06 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JN5BU1292156
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 20:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eNodzx5ivHIvstWtIie+8wRwD24gij93W4EhdknFzBg=; b=PRlNcz9PkX5MWITh
 XLpKpp/LIFS7ICsPIl7PxSt9kf98t4XJkPB4htyBFoJnAlp8ekItgzhV4xeOPfng
 ZYfEQwqYVTbtedeb5OVpVMru5bB81jXihjpNy/A0xmrQO+xK6g3cOujme/crfYaS
 g9lmojXlJn+34I0msGyYmGP2boSBSrc+e3FlMwZZPxm3a6hyP4Kk/BSbVOiin7ev
 vz0kbH1H74oo4R12gqMCvz8ZxH6iswwUO0WjZxOiv9Y/uW11HPgswsahfWQIkFO/
 LI5QLjRllEfTSCIZO2MMUXUgDVbX+q+w8VUiSRB+QdJI3WOubNo/gduh/VpRT4Cx
 3tiQQg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsn0e0a65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 20:56:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53661e036a2so20921561cf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793998562; x=1794603362; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eNodzx5ivHIvstWtIie+8wRwD24gij93W4EhdknFzBg=;
 b=J9UBjCrgV8ejelBBMyslkMjtr+3NcvGEfyqJd5oL3pQE1nMlE2hifzQIZXHKh4tATm
 bmdScbQP9179cMh9ERtCXeR7hSxqLXFA4MiQdpwTjBXuogzivKIwMr1aNW/usWuPbb08
 /wheH5MrggQYt55RMkaZb3uj1PkBxjFhNZuNW6M/o59Z5VKkAzfcEG+JOCjIGWYFxEBj
 CJthCmfv94kwuCrDRY6xxUPq/IgPUcItAQ9f4WCOI2GPN4gf9JTfp5sUz4EkZf+z183s
 QFXJ69PsB0oxOtAyf8AoR1Oy20Ac6N1alw8r70RLYSvj8+5T4zDN0tbQf2nO4j+LrElz
 7w+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793998562; x=1794603362;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eNodzx5ivHIvstWtIie+8wRwD24gij93W4EhdknFzBg=;
 b=bxtUN5M28iGOi0W5NhQiGq8hmtRh8PUXfb/2TNmQCu2qHreMwE4RL05ATVvH4Qi8+5
 pE/SB89c1M66R7cA+S+sy/7s8yDtOYXVjxso+Qgxwo6Jy8pH/c8lb5lhT7uRPy2y10rN
 StInUrNWUFG5kMfizzS5OToFTWHbM/wMZI7Fp8t10uxjMsRxoY+tnJn7FdbRxEpKmhCq
 pfnkpYzXGvKzs7IDc3XAPRaL7fHIxMqLBgSpc9ftuPlz2J9oKWZG6sRd6t++IjWQVpFN
 WDD2RBZ0nxriO5HLFjc3fETi3dmhsI8gGzHSCjY86ckKJJxeDh917ydeZQuClQAiRU3L
 KW8A==
X-Gm-Message-State: APuU4Z9xS4eboAAiLKlnAL39MMYdx7lhR2qCG2NEUc3fF4FrEmvURtlt
 bRuZKX5BM4yi6W9fDglS4zHjAhqCXgF8Uv8aqjec2OSUS+/J3xJesEQafkkqVtnfi8WYP4LFWkC
 7n2Wok9hqyqIHQrPihepVOOGmgC7rGtC1kW3q90raN+1HwnEBM7tCEUa9kA==
X-Gm-Gg: AYBFou2HH4OZG6458MKn+vUasnJ5Ks/2OUyHTdbYu7Ac/kM15rbthoeBYFD2lI/0edF
 QJMIKNySBsWbwVZTjms3+QViqfx76mE1C/R/ncV9qkqtSd2Hh2BCbsLQ+n3AQM7W8wsjzKn/5Uj
 aoJ9m5jPC7197E2k6idHyTYgEZkv687mYIXbAgvUPFotfK5E1m86jdAUu13p8Pw8bc7N0eh0ru4
 eLLXZuc3MRzeN1xse6qIL15f2Z+JtcTn+QyU2QbvBTU6KK7sLMfzu+8I1AIYf/NyDgJzso+X37i
 vRz2JoyZWvwsCvLWymAO0bf8tBVWF1/gI8je453oVv3NAyzPMqxOQ1Vqv06ipDDyIQSa7XhgT27
 T07ekM7wA03ST/UZShjVp46WC6MBj4FqHUGp5CtJ9LKvQDsxvSIzKe4+PUvNgg2RgdrUM2ea8P5
 QECLpFN2LN
X-Received: by 2002:a05:622a:5447:b0:545:de78:a6f0 with SMTP id
 d75a77b69052e-54e1426ad0emr61057051cf.41.1793998562083; 
 Fri, 06 Nov 2026 12:56:02 -0800 (PST)
X-Received: by 2002:a05:622a:5447:b0:545:de78:a6f0 with SMTP id
 d75a77b69052e-54e1426ad0emr61056761cf.41.1793998561579; 
 Fri, 06 Nov 2026 12:56:01 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea6ac8d02sm28503986d6.42.2026.11.06.12.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 12:55:59 -0800 (PST)
Message-ID: <3dcd33f2-41c5-4dce-b6e2-a50934a7829d@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 17:55:53 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] target/riscv: Add Sspesa extension and sample
 CSRs
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261029131011.3715081-1-mayuresh.chitale@oss.qualcomm.com>
 <20261029131011.3715081-2-mayuresh.chitale@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029131011.3715081-2-mayuresh.chitale@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2CPs4Nx80AxpB7Og60RmwKFUVpMUGm5k
X-Authority-Analysis: v=2.4 cv=ffA4WEQF c=1 sm=1 tr=0 ts=6aee3ee2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=OZFbZ_V87LrXgIFjrWgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MyBTYWx0ZWRfX2Pla+DJvcuM6
 SkLH/9829uqEDhEzifxQXmxvgJBj9OXWZQlSVioVg0Qa+UTVib0lG5pCHkpowIwO7f8rqaabvA6
 m0zC6v5atDNBkoG0HA+Jr7LCrgt2SKFyXAIvmMoA1A9xepxmp9Nd9uwQVaWAsCKFiERcm+CaN2n
 NifbK4+vcJp0iLbYznkz7N5Vz3XVndmfeKgAa9qSqnJGkeur1oiejocw5cW6DR4L7Csl0F6bnuN
 F/NbmuRObNXf2GVkzfgJ2V6DAGettx+kHJYzleAV3gm8TaAbSAaLJil7ESsupzfILcDkt9JfnnM
 ZY0l73ZRtzGIrmxkHa/vG6JUDzdplUXvSWroylCvOMn4iPc5rmkxpB84V1TvxYf079ie9ijlNg8
 gPOynwqK6nXspjsCnNYfBBln/C7G3zOFxHi/gxdo8wOyLUluWFoHjdIIfUGUOMU6ufCzvtcxS3B
 EMztw56E3p1yCvs/Atg==
X-Proofpoint-ORIG-GUID: 2CPs4Nx80AxpB7Og60RmwKFUVpMUGm5k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MyBTYWx0ZWRfXy3uXz6xnz/oT
 xwu1TnSvezNW0GPAvLT04T1IHBBA1q5mIJJ7R3TGIMGA+zJjMSD6eXeeaxFp6H34fnEieTg9Gd8
 uvjeFFXQCKq3y56BHM5xFslteUT8Blg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060083
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/2026 10:10 AM, Mayuresh Chitale wrote:
> Add initial support for the Sspesa (Precise Event Sample Attribution)
> extension from the RISC-V Performance Event Sampling specification.
> 
> Added the 'sspesa' and ssplcofi CPU properties, and the shpmspc and
> shpmsdata CSRs.
> 
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c                | 24 ++++++++++++++
>   target/riscv/cpu.h                |  4 +++
>   target/riscv/cpu_bits.h           | 12 +++++++
>   target/riscv/cpu_cfg_fields.h.inc |  2 ++
>   target/riscv/machine.c            | 20 +++++++++++
>   target/riscv/tcg/csr.c            | 55 +++++++++++++++++++++++++++++++
>   6 files changed, 117 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ae750f85c6..99a01ac412 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -282,6 +282,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>       ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>       ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
> +    ISA_EXT_DATA_ENTRY(sspesa, PRIV_VERSION_1_13_0, ext_sspesa),
> +    ISA_EXT_DATA_ENTRY(ssplcofi, PRIV_VERSION_1_13_0, ext_ssplcofi),
>       ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
>       ISA_INTERNAL_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
>       ISA_INTERNAL_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1070,6 +1072,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       }
>   
>       pmp_unlock_entries(env);
> +    env->shpmspc = 0;
> +    env->shpmsdata = 0;
>   #endif /* ifdef CONFIG_TCG */
>   #else
>       env->priv = PRV_U;
> @@ -2933,6 +2937,24 @@ static RISCVCPUImpliedExtsRule SSSTATEEN_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule SSPLCOFI_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_ssplcofi),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_sspesa),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule SSPESA_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_sspesa),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_sscofpmf),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvfbfa),
>       .implied_multi_exts = {
> @@ -3013,6 +3035,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &SSSTATEEN_IMPLIED,
>       &XSFVQMACCDOD_IMPLIED,
>       &XSFVQMACCQOQ_IMPLIED,
> +    &SSPESA_IMPLIED,
> +    &SSPLCOFI_IMPLIED,
>       NULL
>   };
>   
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 49a1186bdb..afd893e3a8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -470,6 +470,10 @@ struct CPUArchState {
>       uint64_t sscratch;
>       uint64_t mscratch;
>   
> +    /* Sspesa CSRs */
> +    target_ulong shpmspc;
> +    target_ulong shpmsdata;
> +
>       /* Sstc CSRs */
>       uint64_t stimecmp;
>   
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 3579789a1f..61258ce6e1 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -634,6 +634,18 @@
>   
>   #define CSR_SCOUNTOVF       0xda0
>   
> + /* Temporary addresses for Sspesa (Precise Event Sample Attribution) CSRs. */
> +#define CSR_SHPMSPC         0x5d0
> +#define CSR_SHPMSDATA       0x5d1
> +
> +/* shpmsdata fields */
> +#define SHPMSDATA_CNTRID    0x1f
> +#define SHPMSDATA_MODE      0x60
> +#define SHPMSDATA_V         0x80
> +#define SHPMSDATA_MODE_U    0x00
> +#define SHPMSDATA_MODE_S    0x20
> +#define SHPMSDATA_VALID_MASK (SHPMSDATA_CNTRID | SHPMSDATA_MODE | SHPMSDATA_V)
> +
>   /* Crypto Extension */
>   #define CSR_SEED            0x015
>   
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index bcff8f55f1..6e67c6f739 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -112,6 +112,8 @@ BOOL_FIELD(ext_ssaia)
>   BOOL_FIELD(ext_smctr)
>   BOOL_FIELD(ext_ssctr)
>   BOOL_FIELD(ext_sscofpmf)
> +BOOL_FIELD(ext_sspesa)
> +BOOL_FIELD(ext_ssplcofi)
>   BOOL_FIELD(ext_smepmp)
>   BOOL_FIELD(ext_smrnmi)
>   BOOL_FIELD(ext_ssnpm)
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0de06e9588..6e20ad0591 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -475,6 +475,25 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
>       }
>   };
>   
> +static bool sspesa_needed(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +
> +    return cpu->cfg.ext_sspesa;
> +}
> +
> +static const VMStateDescription vmstate_sspesa = {
> +    .name = "cpu/sspesa",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = sspesa_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINTTL(env.shpmspc, RISCVCPU),
> +        VMSTATE_UINTTL(env.shpmsdata, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static bool jvt_needed(void *opaque)
>   {
>       RISCVCPU *cpu = opaque;
> @@ -653,6 +672,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_elp,
>           &vmstate_ssp,
>           &vmstate_ctr,
> +        &vmstate_sspesa,
>           &vmstate_sstc,
>           &vmstate_mseccfg,
>           &vmstate_sdext,
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 063590f56a..c9b5b54c97 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -279,6 +279,28 @@ static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException sspesa(CPURISCVState *env, int csrno)
> +{
> +    bool menvcfg_cde;
> +
> +    if (!riscv_cpu_cfg(env)->ext_sspesa) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    if (env->priv == PRV_M) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    menvcfg_cde = get_field(env->menvcfg, MENVCFG_CDE);
> +    /* Access to shpmspc/shpmsdata from VS-mode always causes a fault */
> +    if (env->virt_enabled) {
> +        return menvcfg_cde ? RISCV_EXCP_VIRT_INSTRUCTION_FAULT :
> +                             RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return menvcfg_cde ? RISCV_EXCP_NONE : RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>   static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
>   {
>       if (riscv_cpu_mxl(env) != MXL_RV32) {
> @@ -1677,6 +1699,34 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException read_shpmspc(CPURISCVState *env, int csrno,
> +                                   target_ulong *val)
> +{
> +    *val = env->shpmspc;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_shpmspc(CPURISCVState *env, int csrno,
> +                                    target_ulong val, uintptr_t ra)
> +{
> +    env->shpmspc = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_shpmsdata(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
> +{
> +    *val = env->shpmsdata;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_shpmsdata(CPURISCVState *env, int csrno,
> +                                      target_ulong val, uintptr_t ra)
> +{
> +    env->shpmsdata = val & SHPMSDATA_VALID_MASK;
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException read_time(CPURISCVState *env, int csrno,
>                                   target_ulong *val)
>   {
> @@ -6978,6 +7028,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                                write_mhpmcounterh                         },
>       [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
>                                .min_priv_ver = PRIV_VERSION_1_12_0 },
> +    [CSR_SHPMSPC]        = { "shpmspc",   sspesa, read_shpmspc, write_shpmspc,
> +                             .min_priv_ver = PRIV_VERSION_1_13_0 },
> +    [CSR_SHPMSDATA]      = { "shpmsdata", sspesa, read_shpmsdata,
> +                             write_shpmsdata,
> +                             .min_priv_ver = PRIV_VERSION_1_13_0 },
>   
>   #endif /* !CONFIG_USER_ONLY */
>   };


