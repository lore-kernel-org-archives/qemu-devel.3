Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB0606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IxOn5QpS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UUu3175q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVu2f-0000pk-U4; Tue, 24 Nov 2026 12:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVu2c-0000op-BH
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:10:50 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVu2Z-0002ja-QR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:10:50 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFtmeQ1684103
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 17:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YFmi0fcOQGbXqb/f+q/R7L095F6Bauo8YNwVGD20A+w=; b=IxOn5QpSETpoUpCh
 GnN8zNlNbdXLKEA58Ycmyi54tjByfAlt7G0R1ZiVofVfwhLrOHMK0VcnObmBRlk2
 CNFbj+H7zFqpzRf+p2Zzlj3cK0F+LOSl3LqZ9M6IxKIYgRdMlOZwuGCnVSq6dQ1M
 pSqrfY+yZBBDwWpYZ/PsaoiajbEGLI7zz6x7+ZpD8sF9hPn3TWonchoEn12+vRkO
 H/zfTKpOfH+TOY1T3+kN95PxQENv5Rfofj2wp55mbNj1Y9XijP2I0Zs85Pxc/txj
 XTezNYbHb+Sa4RnE006k9084VptZzih3EX4QoeMkDBsPTxkV99RRpzVRyr7I6COL
 Cs3AwA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dnggbfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 17:10:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9210ad74fdeso84778556d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795540245; x=1796145045; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YFmi0fcOQGbXqb/f+q/R7L095F6Bauo8YNwVGD20A+w=;
 b=UUu3175qky0YDYA5SNSTOEnFbe6+S6wixBXdWEbc6pXosWQqYWzlDY0AoHcRwqDB35
 AFYxBPltD4/KW2KvJ/PtKT/7ui5YcKD+AaOC0i5BPOwwrqc79gh9Ey/GnlXzGXRnD6OD
 6DK/wRh908/DuNbNdm2uUBag9gjKAANwkMzf5WucEXbbq7umInFGtPmy4bxwU148w4fF
 MsVQ9oGC1+1TAGS9pTkWJ1ntiFstMFeMnQQsJPDhTX0jTtW8oMzBbjFJVEROfi17IIpW
 vhjCGEyYf2YQvxTG/uMBQElZTedsHRH1lnJsKwqp8gWM7B3hY0neEg+1OgA+17omH6Q3
 tNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795540245; x=1796145045;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YFmi0fcOQGbXqb/f+q/R7L095F6Bauo8YNwVGD20A+w=;
 b=oV28qAACTKVon5kwd9jRNUyPLnSn0RcqdCKg36xqkL6cPn1OZt+q8ICwlFhOnJEF9p
 nzjdKrkSt7+SXGGerVw475+dGNnvs7wZBCtSI6pTMV86RKOWOhWAfpASEwJT2jgKDA9c
 7wm8LF3D7RpmbS9J48tlRN7yvNKlJZfCFgoU77A+grkPqvQXX/CielpIh9LvhBbMcls0
 ch8LZSwwSBYS4MaqeW5RZh6OSDVO5EFzmXuKVJIUvxI1d7e6H8T1cyQhhCF7dYi97mwB
 LRAL/zDLA4HW3e9GAgYfodYucG1yRTAp4X+AQ2UaMpaLTCaTmTBoM8mjJmDbXVGr7LQY
 MMBg==
X-Forwarded-Encrypted: i=1;
 AL+hErFF0+gkmVqt/ZkTk4qoPAiaMrXJHV/n9PYgJcDQoY5qoQ6q0YT5ctHRcOEjcs3+QhFxG5Zu0jw5yXz9@nongnu.org
X-Gm-Message-State: APuU4Z/c7/9AWXaGmGMI9LNyLdx94dbnGSPOad6EWaHB1rMz+SzdjbGH
 ilzje7gaSsZr/N0RTufJQStrab+QF29H2q6MbhqMwNrNJPImNb2bI144X5Dc5am6YYTdDatR1Ci
 75R4qaJ484fYiW2N/ebrFN1I6e9yGQieQLK0uKmYu8O7lVzUdfqam51QMxQ==
X-Gm-Gg: AZFdTZcucS1QE2aYtwzigmpOB+9KuPnUlrW6LEwNlHsSmp2S+A6WmU0bsN1JmU2/pRM
 STIvhVp3+87NJXxp/Lz1z04ILyMAdZ/syjKGup8V7W/xpPDbYBjnfQopdCkyfCMulcdVCJpyP8y
 5QADig9PFs5t4Lth+axh3bnnGjrmhA6bCMydavc7LbvGz8wCHStzdP0cKgmP3Eb0qfVGUKXX2bu
 p5OztaeC/W8x/mT9PXmtdaJd/wOTrDraO0+Xveofjn5Nrdk6lxOnv9nY7/pxL9ewiK+ELtiUD37
 duCF0xMOjxOykK8tvZ/MrHQLKA7w3XKYBZhtYhoCV0eG1u/ZuYyZ/FE1AWQi/kwqltO9rfXA8xg
 HDf0CvLjWb6thU7wQEePw7Oc7PFqqsMhglmZrbros1HTeQhKMrAqMmcjCjLf2sKC1yzDMEISEpj
 ArynPe+V47
X-Received: by 2002:a05:6214:3a84:b0:921:3171:b604 with SMTP id
 6a1803df08f44-92134b48c88mr260646616d6.54.1795540244329; 
 Tue, 24 Nov 2026 09:10:44 -0800 (PST)
X-Received: by 2002:a05:6214:3a84:b0:921:3171:b604 with SMTP id
 6a1803df08f44-92134b48c88mr260645526d6.54.1795540243587; 
 Tue, 24 Nov 2026 09:10:43 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349cdfbasm140183066d6.17.2026.11.24.09.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 09:10:43 -0800 (PST)
Message-ID: <a7c3c466-25e1-4324-b32c-83c58940ace7@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 14:10:39 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv: Split out riscv_compute_tb_flags
To: SeungJu Cheon <suunj1331@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261119164438.193579-1-suunj1331@gmail.com>
 <20261119164438.193579-2-suunj1331@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261119164438.193579-2-suunj1331@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NyBTYWx0ZWRfX4DTZnCGpemx0
 ZYWd5Ae1Dgzu0uPQ7KRImzQoWoYnraLDpoJroaMIs5iTX2ey1eulD+1paaIumUiNHQa8RWbOOZ+
 fu7Xem7J6nX/Norp8lGL2Fx24eupJSw=
X-Proofpoint-ORIG-GUID: qqhK5MYoax-DsOB3bZGBMRLd4xC8TtjQ
X-Proofpoint-GUID: qqhK5MYoax-DsOB3bZGBMRLd4xC8TtjQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NyBTYWx0ZWRfX3DvVpI1euwIo
 onXLEyPShfvBRjiTCi3C7u4PcdbLYCChspWj+DMoB/91SAVqPd1+JazQPWdVu0/9RZHPp+o1Zkx
 uRnxnf9wX5YrdHtY/Asm2A8rW3wt44lbXhZheX1zyhw9ffZSG1caq84zf9DnpHIjo/vOeSIoMCu
 +paEQT3WROCvr7/PKn3kLn1w55pMRkeH/Xcs7HftlImGvqjgC5O7Fou6H9KZ00DtBWmARGexmRA
 bxpPugBkXyq6ETMmeajF/diAyrovLxCnBDz7o+xG2q6pitSNgm6WrIjMm0+95WmqGI2ucwjqF6B
 XMGIKsykqKL8ifpnmJeQ1GceqsjXrf2EZDpYV3vj0s0yfvVhZBruF6anCCEubY+Zgah00ueX/wF
 AI4Q/cuubblnNWfNK+tAjBQUHneNlN4+bKhvBsRIZeZ6Px2Vmz1JjWQX+nis7DVbWvZ3+1r4pEN
 C4/XdI1+VgTmNCPRAGg==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b05c515 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=P59yoAlMZRhNRrukf9sA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/2026 1:44 PM, SeungJu Cheon wrote:
> Move the computation of TB flags derived from state that changes on
> CSR writes, traps, privilege changes and vsetvl into
> riscv_compute_tb_flags(). Continue to read FS/VS, elp, vstart and vl
> in riscv_get_tb_cpu_state(), since they can change between lookups.
> 
> The lookup calls the new helper directly, preserving the TB flag
> values. The helper returns UINT32_MAX when maxsz is below the 8-byte
> gvec minimum, so the vl comparison leaves VL_EQ_VLMAX clear in the
> same cases as the previous maxsz >= 8 check.
> 
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/tcg-cpu.c | 101 +++++++++++++++++++++++++------------
>   1 file changed, 69 insertions(+), 32 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5834ec1524..5c5d8fcb94 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -99,13 +99,20 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
>       return riscv_env_mmu_index(cpu_env(cs), ifetch);
>   }
>   
> -static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
> +/*
> + * Compute the TB flags that depend only on state changed through CSR
> + * writes, traps, privilege changes and vsetvl.  For now the result is
> + * fed straight back to riscv_get_tb_cpu_state(), which adds the bits
> + * that translated code changes between two lookups -- FS/VS dirtying,
> + * elp, vstart, and vl, which fault-only-first loads shrink.
> + */
> +static void riscv_compute_tb_flags(CPURISCVState *env, uint32_t *pflags,
> +                                   uint64_t *pext_flags, uint32_t *pvlmax)
>   {
> -    CPURISCVState *env = cpu_env(cs);
>       RISCVCPU *cpu = env_archcpu(env);
> -    RISCVExtStatus fs, vs;
>       uint32_t flags = 0;
>       uint64_t ext_flags = 0;
> +    uint32_t vlmax_cached = UINT32_MAX;
>       bool pm_signext = riscv_cpu_virt_mem_enabled(env, false);
>   
>       if (cpu->cfg.ext_zve32x) {
> @@ -124,49 +131,93 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>           uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
>           uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
>           uint32_t maxsz = vlmax << vsew;
> -        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
> -                           (maxsz >= 8);
> +
> +        /* vl is compared per lookup: fault-only-first loads shrink it. */
> +        vlmax_cached = maxsz >= 8 ? vlmax : UINT32_MAX;
>           flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
>           flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
>           flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
>                              FIELD_EX64(env->vtype, VTYPE, VLMUL));
> -        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
>           flags = FIELD_DP32(flags, TB_FLAGS, VTA,
>                              FIELD_EX64(env->vtype, VTYPE, VTA));
>           flags = FIELD_DP32(flags, TB_FLAGS, VMA,
>                              FIELD_EX64(env->vtype, VTYPE, VMA));
> -        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
>           ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt);
>       } else {
>           flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
>       }
>   
>       if (cpu_get_fcfien(env)) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
> +    }
> +
> +    if (cpu_get_bcfien(env)) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
> +    }
> +
> +#ifndef CONFIG_USER_ONLY
> +    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
> +    flags |= riscv_env_mmu_index(env, 0);
> +
> +    if (env->virt_enabled) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
> +    }
> +
> +    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
> +        && !icount_enabled()) {
> +        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
> +    }
> +#endif
> +
> +    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
> +    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
> +    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
> +    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
> +
> +    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
> +    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
> +                           mo_endian_env(env) == MO_BE);
> +
> +    *pflags = flags;
> +    *pext_flags = ext_flags;
> +    *pvlmax = vlmax_cached;
> +}
> +
> +static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
> +{
> +    CPURISCVState *env = cpu_env(cs);
> +    RISCVCPU *cpu = env_archcpu(env);
> +    RISCVExtStatus fs, vs;
> +    uint32_t flags, vlmax;
> +    uint64_t ext_flags;
> +
> +    riscv_compute_tb_flags(env, &flags, &ext_flags, &vlmax);
> +
> +    if (cpu->cfg.ext_zve32x) {
> +        bool vstart_eq_zero = env->vstart == 0;
> +
> +        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX,
> +                           vstart_eq_zero && env->vl == vlmax);
> +        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, vstart_eq_zero);
> +    }
> +
> +    if (FIELD_EX32(flags, TB_FLAGS, FCFI_ENABLED)) {
>           /*
>            * For Forward CFI, only the expectation of a lpad at
>            * the start of the block is tracked via env->elp. env->elp
>            * is turned on during jalr translation.
>            */
>           flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
> -        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
> -    }
> -
> -    if (cpu_get_bcfien(env)) {
> -        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
>       }
>   
>   #ifdef CONFIG_USER_ONLY
>       fs = EXT_STATUS_DIRTY;
>       vs = EXT_STATUS_DIRTY;
>   #else
> -    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
> -
> -    flags |= riscv_env_mmu_index(env, 0);
>       fs = get_field(env->mstatus, MSTATUS_FS);
>       vs = get_field(env->mstatus, MSTATUS_VS);
>   
>       if (env->virt_enabled) {
> -        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
>           /*
>            * Merge DISABLED and !DIRTY states using MIN.
>            * We will set both fields when dirtying.
> @@ -181,27 +232,13 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>                ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>       }
>   
> -    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
> -        && !icount_enabled()) {
> -        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
> +    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
> +        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
>       }
>   #endif
>   
>       flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
>       flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
> -    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
> -    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
> -    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
> -    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
> -
> -    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
> -    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
> -                           mo_endian_env(env) == MO_BE);
> -#ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
> -        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
> -    }
> -#endif
>   
>       return (TCGTBCPUState){
>           .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,


