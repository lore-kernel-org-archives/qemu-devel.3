Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BB7C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyThw-0007uX-8W; Mon, 24 Aug 2026 08:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyThu-0007th-1m
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:23:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyThs-0006qY-33
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:23:17 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMUw12372285
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z12nJpW5tZkFnWy5mZgtJ0R0vHsGEO/Ls+4LvllGM30=; b=XUTDGFDzEQLVtXt5
 wbCWKTz6rwwzzwrDXwxgimtMOI0bXh7OrPwbk0FBW34ouWE/ctwlm3lezdmE1z1i
 4UKRZumCEl4mov/s71RRPWJJws/pWWpMiY+FtoqA+UZSP44xPAsefZ1XGZtnU8R1
 R7cly48ru05iFs8oXlqkCdR4Kly0Fz8shI0eL/YjZ0NtMjXcQP1w+CbRiRqCqO2g
 JIzKiv9HhtOJDf9KmBcbbA6A2zCaCQQv/+JU2PNs2dT78x7r75AAqlkUeOHUSQ1U
 mivLU8teN7oid61fAAjbpfl+ZUHyHgO+2XTukRESyYpIQhuL1uCDqveteqns5GZ4
 igXMDQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdshjke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:23:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so35931831cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787574192; x=1788178992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z12nJpW5tZkFnWy5mZgtJ0R0vHsGEO/Ls+4LvllGM30=;
 b=Pbiwci4rvXGme3znUHAvZaS2CUh5IgtM+B+IqBsFDO+A+IYC3ca1ZG2rAz/YSGgd8Y
 3nkKJZ+q6VJtDKRSD3MMm4LNGS5ieQje94DcKoQkAT/+WzrOmzlZPirJZVVQCmExcvKL
 lLdK4oKEhCmRfVlPfdLzmiIApdqRdIB6ilAS+3PTNfaNDPuskXMOUWzM8rt2pEcjEHyM
 fas0AsQ/jf3vNyh5y82s9ICXmGBA3+32MHwlTKsQabqxD3+4PSVI1pr6mlqV/5+sM51t
 u4mli1mdPSIjnqhc8SYrYWYUB6eo+3yn2ZDKFPqtEbcgFrm5FyXQNhR6e9fn1Vwz3JGM
 5Naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787574192; x=1788178992;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z12nJpW5tZkFnWy5mZgtJ0R0vHsGEO/Ls+4LvllGM30=;
 b=hEW7XwRIyPKhCD0PGoVh5v+ZLoBGw3t7m7o+EMctCQmQZbyQFzXPRA34MX9jBhPy/m
 C9iVZdRopP/o/TP45G79UdM9bEebrMFCW19nPmljjv4gTPhlbWgWXD870rGbyUcZC9j7
 B4T0GzuYDNHoqAWJnWgf+EsllRRPsSYHYUnhEhSImFejExJmZ+ta00mqzdZE95zHFgqf
 Evrfu5h9L2/DdAe2VrOvZ/Fpk8zkGsQ/jIvP+mUd+ZTNHBi3lMl8CmERZUocRXOSd7BO
 e1qe+awj8OfWWarnLTrK9P8O9gTKGMs2QYugf4OYKigXRucyuzHCOud/9BadMpIQJQnX
 PUxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3CUgG8pL/r/pRsSGf4dEWhlLhDDCef9TjOaiIjsPSDVxlAiC+RrWNm1Ailmcok1EfTd8mSu/lJu7b@nongnu.org
X-Gm-Message-State: AFuF++nPZj6PUiv2N6q5rBUMRsBvbZrw7/B6aCH5D198hwBUXDjrD3Cj
 9wxBOmHnLLKN7uWEzX7jd/c4MppW4yszBlywP/nZi2jcGgtCWxlqFvnG0+1BW3GN58kxuGBeD0t
 4FgeODwiQUE31juGivGUm6H+iUYshttQcBVfvKM6vfWZPNAPe3qsLn//boQ==
X-Gm-Gg: AR+sD1391r0au/poMFkhkvWCLGwvv4EF89cHxmK+EX+/52RYxG3GTmdJmaJWNSCo+K+
 SPPjIvvfSqWg6IV+CqTJ9k92hG1Xn5fD+XJpv9KJBzVpJUbe1AXf2eQXyQzyAsExHfc66jGlUK5
 3YiB/AYUMfkm7vNAQ0T1meeO2VQEqwqy69vC539Tj4Avre/+3pHWJz0ObjD0KsCz6NYgkngm4ye
 iQhfqmxpCXj183jc42fnr/HStKIxd/IC5HEmkC0dh/iSAsuHEwXEOnZS/H6Ae7JkqIozVY4sT6O
 VbdMvmRJcciQXCM4zXBnXZ5EYsBYlumjtO6Txds/NRdi/7S+mcCj2vvB5K/EhnhgugAODcWsGT2
 ayXMpRQIjKwzd92ZDJqYvl+rxx707vF517WAl
X-Received: by 2002:a05:622a:481a:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-52df5a5167amr270931071cf.31.1787574192094; 
 Mon, 24 Aug 2026 05:23:12 -0700 (PDT)
X-Received: by 2002:a05:622a:481a:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-52df5a5167amr270930161cf.31.1787574191556; 
 Mon, 24 Aug 2026 05:23:11 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c2faba20sm12192381fa.20.2026.08.24.05.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:23:10 -0700 (PDT)
Message-ID: <c4cf2ff9-09db-42f3-9672-257f35ce4836@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:23:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] target/riscv: Add Sspesa extension and sample CSRs
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260817160321.3313698-1-mayuresh.chitale@oss.qualcomm.com>
 <20260817160321.3313698-2-mayuresh.chitale@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260817160321.3313698-2-mayuresh.chitale@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aWoP3xR0eEuc3IqqtbPoJVMSaHVHBgLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwNCBTYWx0ZWRfX3ClsCw3O/cru
 /w3KFGsxBwT5Qh5GAZCRHzp5jwdTdafXP5wSAAMjs35QCrmIcqgKsWyLjLvbt70k9jctcwPwfS/
 Kp+aOgGjyjQUco8HQC0fL1INv79UYahvx8vRListZnGGyzkiOKH1jB+9lcDOhBuzXw7W37he/0k
 +8hnSAmCeK0/lV9e8Gu0ObPKwYywJahxjjlohvXSNxzr03K1/w+CJsnZ93smg1EN8lr30oGgDT5
 1ek2B/qcRxO6Jv4ZTiQ9F5HIwdEKnaG6iiyrxKWxppbKTbPNBXAGIq5HZ+3BPS5K1PEiovu7TuI
 4xDJoGwIUMMQxrlPUdJ6R5wxsConJGhAHLp9V7FgzhJ3EumHRzhe2PWRCLyH18zwMZmW7lQkNyg
 XnkoKx1q/83WlOOtQLOytZhtc8C3uqUCnt3YyKIGmEmTtIbGleyHSYk8RS6u/ToH+2B9dGyvOby
 N0ZqAUsdmGe5ugfyY2w==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c37b0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rGHe9hKdlJMoL7tw7QoA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: aWoP3xR0eEuc3IqqtbPoJVMSaHVHBgLO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwNCBTYWx0ZWRfX4CXlo9p6VViw
 Tde+odv17g61p44NsypUJrGsMskX1esRP7rNzuDfijrGo90srMVpcMvbWDjGfWdt1SxKqAI92QJ
 YOWfC/Zcu07S5wosbdC5oJDtAkJAGDk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240104
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/17/2026 1:03 PM, Mayuresh Chitale wrote:
> Add initial support for the Sspesa (Precise Event Sample Attribution)
> extension from the RISC-V Performance Event Sampling specification.
> 
> Added the 'sspesa' and ssplcofi CPU properties, and the shpmspc and
> shpmsdata CSRs.
> 
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c                | 13 ++++++-
>   target/riscv/cpu.h                |  4 +++
>   target/riscv/cpu_bits.h           |  7 ++++
>   target/riscv/cpu_cfg_fields.h.inc |  2 ++
>   target/riscv/tcg/csr.c            | 59 +++++++++++++++++++++++++++++--
>   5 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a82e6563b..f936cdeb68 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -278,6 +278,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>       ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>       ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
> +    ISA_EXT_DATA_ENTRY(sspesa, PRIV_VERSION_1_12_0, ext_sspesa),
> +    ISA_EXT_DATA_ENTRY(ssplcofi, PRIV_VERSION_1_12_0, ext_ssplcofi),
>       ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
>       ISA_INTERNAL_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
>       ISA_INTERNAL_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -2800,6 +2802,15 @@ static RISCVCPUImpliedExtsRule SSSTATEEN_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule SSPESA_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_sspesa),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_ssplcofi),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvfbfa),
>       .implied_multi_exts = {
> @@ -2829,7 +2840,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>       &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
>       &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
> -    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
> +    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED, &SSPESA_IMPLIED,
>       NULL
>   };
>   
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c9dfa7daff..fe56a6afd1 100644
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
> index 3f146a43fe..d3afc9cada 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -601,6 +601,13 @@
>   
>   #define CSR_SCOUNTOVF       0xda0
>   
> + /* Temporary addresses for Sspesa (Precise Event Sample Attribution) CSRs. */
> +#define CSR_SHPMSPC         0x5d0
> +#define CSR_SHPMSDATA       0x5d1
> +
> +/* shpmsdata fields */
> +#define SHPMSDATA_CNTRID    0x1f
> +
>   /* Crypto Extension */
>   #define CSR_SEED            0x015
>   
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 9eb47af0a7..05e0162b76 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -110,6 +110,8 @@ BOOL_FIELD(ext_ssaia)
>   BOOL_FIELD(ext_smctr)
>   BOOL_FIELD(ext_ssctr)
>   BOOL_FIELD(ext_sscofpmf)
> +BOOL_FIELD(ext_sspesa)
> +BOOL_FIELD(ext_ssplcofi)
>   BOOL_FIELD(ext_smepmp)
>   BOOL_FIELD(ext_smrnmi)
>   BOOL_FIELD(ext_ssnpm)
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index eb823b16b5..ea49d28aae 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -276,6 +276,28 @@ static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
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
> @@ -1672,6 +1694,34 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
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
> +    env->shpmsdata = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException read_time(CPURISCVState *env, int csrno,
>                                   target_ulong *val)
>   {
> @@ -3220,7 +3270,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
>           mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
> +                ((cfg->ext_smcdeleg || cfg->ext_sspesa) ? MENVCFG_CDE : 0) |
>                   (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
>                   (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>   
> @@ -3272,7 +3322,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>       uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                       (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>                       (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> -                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
> +                    ((cfg->ext_smcdeleg || cfg->ext_sspesa) ? MENVCFG_CDE : 0) |
>                       (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>       uint64_t valh = (uint64_t)val << 32;
>       bool stce_changed = false;
> @@ -6771,6 +6821,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                                write_mhpmcounterh                         },
>       [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
>                                .min_priv_ver = PRIV_VERSION_1_12_0 },
> +    [CSR_SHPMSPC]        = { "shpmspc",   sspesa, read_shpmspc, write_shpmspc,
> +                             .min_priv_ver = PRIV_VERSION_1_12_0 },
> +    [CSR_SHPMSDATA]      = { "shpmsdata", sspesa, read_shpmsdata,
> +                             write_shpmsdata,
> +                             .min_priv_ver = PRIV_VERSION_1_12_0 },
>   
>   #endif /* !CONFIG_USER_ONLY */
>   };


