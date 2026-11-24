Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A4606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c2Fx8r6Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WxrQSpZB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVwpJ-0005EW-7u; Tue, 24 Nov 2026 15:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVwpA-0005Dm-TC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:09:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVwp6-00006X-MC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:09:08 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIY6Kn1651277
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FsgptUl2orm+jVcDMsiCkABRUL8z8xxWoJLLFSjUEUs=; b=c2Fx8r6Q+XxT4Vdm
 USV+YgdDD/QhOL+pyxzKTVbunvFG7vLUOhrL+N4t7v5To+z7idlAcVoE6PAY/+AF
 H9PDsLNWgF75lMhdDRKkyj2b5OKVx/bIcfYcMyQs0LPtf9s/1WOgXU/dsxBD3Cd0
 Rtx3txTf7qNJTJkHGFnrhp5dfq8idDBo+ohXf0dgmOGsGmWPZuwNOEb/fj1/E2bt
 twDMrz6hG0BFryg4QqkwLu62Dv3UcDSHnENMfmScwUXMFwfBhW172eCbSY16Jgx0
 0ee1ZDEIcVwz1jJfCd8DX5FeFdrF2YOjRdVh01agoLBt2gphowMiQSyFNtnYojuE
 PjqD1w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rpkt3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:09:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d32f54d21so100442231cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795550942; x=1796155742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FsgptUl2orm+jVcDMsiCkABRUL8z8xxWoJLLFSjUEUs=;
 b=WxrQSpZBNqSQpzdpvtmRuKrHMaLfjLmuJsX16EdBe3SmQRcyaYiUchG09THfD+5XpK
 Br7aA0vi0+wb9G29hP5SJZfmPhQESfMDGsLGVCZTmCSY7L8ZPhKTaHrGM5FSC4y5CfJG
 xQOx8DF8ma/1gDvGV2ZEu+PyZ0hstdMrwwD8b6+a81oLJC4RR7sz3wyZir7ARDjvRLge
 2UMTiyTr7W0tN1UUCIUD5EWm01SSD9NLv4Vd0rm/WbgDBhEUpItwEx5Gs3Z3zMreICi6
 y1RkQC+z+IgtzTL6wgw2usTtCRyo+yqwctroXektf82ONERluVI5mLSxfOp/u0zSYjB1
 2ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795550942; x=1796155742;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FsgptUl2orm+jVcDMsiCkABRUL8z8xxWoJLLFSjUEUs=;
 b=DEveiJXVIHNQyQYrx00/UwdgzoL4t+VVtCNDPyPcWZiToUy+A3teCsdAxnTle1lzzd
 ZufYUx79UAos414LFNF6D6oGxwWcUB1+Hksk7J4xyI0cGnUY+K0geCOrHx55GoIdit7Q
 KQmZ/QDL8k78mcCa9D0Fl66dHu3WbchENHlP3JKbb3rnPrAaT9xsUDRYbfwHJZN0XR1K
 cbLqp20uujM06wl+IeOjpQYDln1VlZExI5NXLSPsi6er4CrAS3tiXSCUpGwTS8mg9Buo
 hHVPpuoK/oNU6Z+8O2SEy699hujHzezctt0lUOQMFrx13HuqTvcEpJPRGstrCtjgc5zH
 iUAA==
X-Forwarded-Encrypted: i=1;
 AL+hErEOx+VHlLL5Df69FAnysChZL8tFlP55XU7/bXp/gD+onVdnO+IC3QJAmO+PrOvEN4w42RbXN/6aS6MR@nongnu.org
X-Gm-Message-State: APuU4Z9ylQVjVluellzxU3Mc0+mkAlX/q93FrL4xSPbEDrG7uDdOAUEL
 wVJeLb0RYrYH7qw/KUoDkofDN1D2n8HfslLlxBIN3nbWqmOgRB1K7hUM7KWaQwZEikb/c5qgB+L
 qymYV6O88DFDUi4nJ185BekLjNJPhCLcwpLs0q1nLmfrEodvAf4AaDqWsRQ==
X-Gm-Gg: AZFdTZcP5FBUnqrI/FcBRr5jk60ktq1SL+DEE3pxmW0l57VXB9RLU32qbQIo1rAtM/t
 fUbwY54a9rpbPrNxeMHrnpltoFPtu00YWulA3KmU6P81npdyDEhVX2wyyb+RKNYWJnxBgXLn/7A
 TZJkgx4stCC4g+27UZtdOeJHi3dm+1R73R98ZYXBI+tecWyqWLOX6/KHgE7I5H76ITaGQqUGO/v
 IiQynVawePiBkVPUyOjntoXtILuW3QELL8rgl7eEp0I6s4qFkvf4j6QFHxFe+Jt9LIE9X37YMsJ
 ny76FkEG3g6Rr+BnpUuIYmlYAnjwNjenevUAIlmrWIZTZuQf3lfV5iitnKaWK5UV47lNEUu9/4U
 TAoG6OR9cE7IOH26led2TgjgB5rCkUSG2W528v33zc/0iwzRzPw2Gn67BDdouvp5s7QVmxi2IGN
 a+nK7zv03g
X-Received: by 2002:a05:622a:13ca:b0:55c:9b4f:f358 with SMTP id
 d75a77b69052e-55d76939a33mr291186061cf.6.1795550942526; 
 Tue, 24 Nov 2026 12:09:02 -0800 (PST)
X-Received: by 2002:a05:622a:13ca:b0:55c:9b4f:f358 with SMTP id
 d75a77b69052e-55d76939a33mr291185581cf.6.1795550942035; 
 Tue, 24 Nov 2026 12:09:02 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d78807b5fsm134371221cf.6.2026.11.24.12.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 12:09:01 -0800 (PST)
Message-ID: <b1247c2f-bd06-4b68-adeb-f8b7954d20d0@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:08:58 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: add support for the hcontext CSR
To: "b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com"
 <b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cosmos.xu@synclite.com" <cosmos.xu@synclite.com>,
 "qemu-security@nongnu.org" <qemu-security@nongnu.org>,
 "antikostya2@gmail.com" <antikostya2@gmail.com>
References: <> <335b83ef-aec7-4345-a95c-6eb669d48a66@outlook.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <335b83ef-aec7-4345-a95c-6eb669d48a66@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3OSBTYWx0ZWRfX0TjrqeiyjXDE
 Ym/+Yc0nkvGMAmDeO64MomPGIX4/MfGHHo1DZejZbm1uW/gI+Qp07rNvP/G+VZjpu9OYag6lqOf
 6LBWsINfx2cV/R5cVdsGDNfKfpLIVjlspyaKrGKaZmajuQQcuSlrmxlsCxSltlzlJfJZyPLZOr2
 ynANVZ2WrXJj6tWnQ0UYfTWK2nopr4MTYbyeP6XsmW7nq1J6elFDRy4jv0pV3L2Y7xbb/yxLQ1j
 WjfJvjFABxaxALgQlBYEbI068lB9KQbSW/CY9o+TP3d0y8FAHGEqTjRDM4mGzvLFe9YfUfByZGi
 Cg6QJeRYgziTEX7Qp7ePNfi6rnqw38Z+YPFmyyTrEq+u306TTEmn489dy6cexCFXnoTKC1My9+w
 d96JjTkbKx4PqRFzMlJrd0iRfVE3HekPzfyDBCQS+6oIgwgieXvTBEDsuuEbWudU5+OFmMIYjuM
 QzRC5t4hPoC0q05yEcw==
X-Proofpoint-GUID: j57uCLVvjCHPqRLFZVJTDsRiSmL1QWzV
X-Authority-Analysis: v=2.4 cv=MvbHeGae c=1 sm=1 tr=0 ts=6b05eedf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ID6ng7r3AAAA:8 a=UqCG9HQmAAAA:8 a=5ejufT2_47bKy-sqV6gA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3OSBTYWx0ZWRfX3k2u30hdNPCO
 rCBdeVRkWYhKK91jJcxNK+enQ6NhxxDJ8mft59Bhueu5rGiyx4yccmyTS1I66LXzmeoeFCnj4Cz
 702r8bFi/IYwUYuQkaC+mOhC99cGBzo=
X-Proofpoint-ORIG-GUID: j57uCLVvjCHPqRLFZVJTDsRiSmL1QWzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240079
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

Hello,

On 11/20/2026 7:18 AM, Arseniy Semenov wrote:
> 
> Implement the hcontext register described in
> "The RISC-V Debug Specification" Version 1.0. The hcontext CSR is
> accessible from H and M mode, gated by the Smstateen HSCONTXT bit.
> 
> Changes from v1:
> - The Smstateen HSCONTXT check is now only applied when the access is
>     made from HS-mode, as required by the Sdtrig spec.
> 
> Signed-off-by: Arseniy Semenov <ar.semenov@outlook.com>
> ---
> This series adds emulation support for the hypervisor context (hcontext)
> register, as specified in "The RISC-V Debug Specification" Version 1.0.
> 
> The hcontext CSR (0x6a8) is a read/write register accessible from H and M
> mode, whose value is derived from the mcontext register.  Accesses are
> gated behind the Smstateen HSCONTXT enable bit and writes are masked to
> the xlen-dependent width defined by the spec.
> 
> No behaviour change occurs when the H extension is not enabled.
> ---
>     diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>     index 3579789a1f..bfa10afca8 100644
>     --- a/target/riscv/cpu_bits.h
>     +++ b/target/riscv/cpu_bits.h
>     @@ -456,6 +456,7 @@
>      #define CSR_MNSTATUS        0x744
>      
>      /* Debug/Trace Registers (shared with Debug Mode) */
>     +#define CSR_HCONTEXT        0x6a8
>      #define CSR_TSELECT         0x7a0
>      #define CSR_TDATA1          0x7a1
>      #define CSR_TDATA2          0x7a2
>     diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
>     index 063590f56a..e817b8383e 100644
>     --- a/target/riscv/tcg/csr.c
>     +++ b/target/riscv/tcg/csr.c
>     @@ -814,6 +814,16 @@ static RISCVException debug(CPURISCVState *env, int csrno)
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>      
>     +static RISCVException hmode_debug(CPURISCVState *env, int csrno)
>     +{
>     +    if (riscv_has_ext(env, RVH) &&
>     +        (riscv_cpu_cfg(env)->debug || riscv_cpu_cfg(env)->ext_sdtrig)) {
>     +        return RISCV_EXCP_NONE;
>     +    }

I don't think we want a check for cfg->debug here.  hcontext is a CSR from Debug
Spec 1.0, aka a Sdtrig CSR.  cfg->debug is the legacy 0.13 support that predates
the Sdtrig spec.  We have a documentation about it here:

https://www.qemu.org/docs/master/specs/riscv-debug.html

We should remove the cfg->debug check and verify only RVH && ext_sdtrig.  Thanks,

Daniel


>     +
>     +    return RISCV_EXCP_ILLEGAL_INST;
>     +}
>     +
>      static RISCVException rnmi(CPURISCVState *env, int csrno)
>      {
>          RISCVCPU *cpu = env_archcpu(env);
>     @@ -5703,6 +5713,52 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
>          return RISCV_EXCP_NONE;
>      }
>      
>     +/*
>     + * Returns true if we are in HS-mode, the only mode where the
>     + * Smstateen HSCONTXT bit gates access to the hcontext CSR.  M-mode
>     + * and Debug mode must have access regardless of Smstateen.
>     + */
>     +static bool hmode_hcontext_smstateen(CPURISCVState *env)
>     +{
>     +    return riscv_has_ext(env, RVH) && env->priv == PRV_S &&
>     +           !env->virt_enabled;
>     +}
>     +
>     +static RISCVException read_hcontext(CPURISCVState *env, int csrno,
>     +                                    target_ulong *val)
>     +{
>     +    RISCVException ret;
>     +
>     +    if (hmode_hcontext_smstateen(env)) {
>     +        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);
>     +        if (ret != RISCV_EXCP_NONE) {
>     +            return ret;
>     +        }
>     +    }
>     +
>     +    *val = env->mcontext;
>     +
>     +    return RISCV_EXCP_NONE;
>     +}
>     +
>     +static RISCVException write_hcontext(CPURISCVState *env, int csrno,
>     +                                     target_ulong val, uintptr_t ra)
>     +{
>     +    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
>     +    target_ulong mask = rv32 ? MCONTEXT32_HCONTEXT : MCONTEXT64_HCONTEXT;
>     +
>     +    if (hmode_hcontext_smstateen(env)) {
>     +        RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);
>     +        if (ret != RISCV_EXCP_NONE) {
>     +            return ret;
>     +        }
>     +    }
>     +
>     +    env->mcontext = val & mask;
>     +
>     +    return RISCV_EXCP_NONE;
>     +}
>     +
>      static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
>                                           target_ulong *val)
>      {
>     @@ -6620,6 +6676,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>          [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
>          [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
>          [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
>     +    [CSR_HCONTEXT]  =  { "hcontext", hmode_debug,
>     +                         read_hcontext, write_hcontext },
>      #if !defined(CONFIG_USER_ONLY)
>          [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
>          [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
> ---
> base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414
> change-id: 20261019-hcontext-e8e8f54989a4
> 
> Best regards,
> --
> Arseniy Semenov <ar.semenov@outlook.com>


