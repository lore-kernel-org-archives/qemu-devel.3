Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A02606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S7qvIfJp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g4cdZDUs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVunw-0002e8-8k; Tue, 24 Nov 2026 12:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVunr-0002bt-Qq
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:59:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVunq-00055w-35
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:59:39 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFLJbl3267071
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 17:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ML/8hshu4nEYDM2tGHUINSs3pW/CtZf4uPLYEFqB2rA=; b=S7qvIfJpNLHVdF4S
 UwTO773f6bf+zJ8uzxTd8Bnrj2sHXeDy8wRKKcAMgonCPZBxuiV2IjPMx/2XQU5j
 6Lc6wh8aOAsPlQaYEomzReuMqHyDQ+6Wcq5iq0euiwVrIdEblwI/Y7l95rgt9by/
 54VWI7C4EY4DRf2Yeko4d/dIk2Xl1MDnYNNSEd7RxYxldNb4Mive3s0GoWthOTHv
 2qT6agFLeWaaa2xc3OajbkV+uqUAszV0tfZvUPWTub/sOjruse4KRUsjw/TMFnQR
 y0OzjGX7h3lg/UWG5ua1tHk9gCE/V7kZoG74JI/KAp81Bc2a1CRTLsDKGfw9UZuG
 LWAtig==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7smgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 17:59:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d322fbso693323185a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795543174; x=1796147974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ML/8hshu4nEYDM2tGHUINSs3pW/CtZf4uPLYEFqB2rA=;
 b=g4cdZDUshJ8w8n/JKPC3kYWeM5zc8HZZrxg7DaHKkoQQDiIfK5ruQ24lsrz2BgxqZL
 RXBUC9eO5JuI3fJA9huVCfG/qsRx2YEWgjPOjL/NvOWOwq+g728JO0K7mVWEMQD94Hkq
 4NMjBzqTR399xlpabH0BGdDAoabk6QbA6xGPELEfrfRp3rrOq3kMTXoXPuGJ/LbjHEgv
 O9wmFO+LFUQL7WS9M0vzk6JXMsumBc/F/S/R8NSh5G3uQgVZTC/AFmpV48nCAwqqlOI1
 zaP8YBcusF5JiNzq/EFYCCCZx2EgeSliue3mHz/0L125ZcKHLLGrWn41bLeF8OfietDd
 i4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543174; x=1796147974;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ML/8hshu4nEYDM2tGHUINSs3pW/CtZf4uPLYEFqB2rA=;
 b=HnVSSy2rR9BVhUC7Y2+UBgwUkGb6gJwy7dmXyKNB6Db4T94tVThr1qyxxyvaFEwQxr
 sKyt0VOLQh6rEp0oLDceyE1LXZiY+yiQYhZWIY+Qu5jy9IOzmcuI+7hMlx+0IwTB+a4b
 f5qruZqMdy0Y5ZAw8whlGRSrrFnFyedYQpL4PSOuEwFcemcy60SIjdKRL4Ef4zvJfjJE
 9KQ3zOwckcDM7MMkXIGbeMEuWI68WeG1s568ehQFNFaInuxDbJsB+qhEQjZ9GPOXt4OL
 9J4o+Hylw5HnpBde0xqP++2DpY2JkGb7vdsWPZ6WNYrg6qk+mq09h5pwfBXZICIFR9za
 edvA==
X-Forwarded-Encrypted: i=1;
 AL+hErELKjy2JnkvbJJIAM6tdUabZQWPGc4bcv4tOeHFl0Tw7ErLRiSL+5ZUlnirAVkwU0aOwU/u8J8SE5cL@nongnu.org
X-Gm-Message-State: APuU4Z/V1DoIl9g9Ya2AMmIKBzEoZJriyXKuYd+ACcUyA8RWSAzsumyt
 RAMLWNcI65mcp8HiIwaNsnmebvWTx94+N2q6U0iltB6NX4VZUKzv76hDGaRj/OK4Oq7eWmlkBFk
 wTi1wK97SVniYWB9yZcVQW2rlen8fKZU2JaAaUNK7oQljdLG3FuwhwQpp4Q==
X-Gm-Gg: AZFdTZdBxwynfriNV5F04AnlaIbSJTMzRr/9dJ0nfFG6nBce+7nn4WDxqrCP34yjcmj
 u2lfEcfqFXPu4c6tX3xvE7L23BK3W61pZnXx7CUbAboAf4SFNomO+37n+HO4Ui0PTar39zZW2xH
 gq0FYWbOKSPuClASlUBRHtRaCSr+Cp5rocBEThYUMVHeLttp6u4R6KRXyjEKVp7Pq5/2ZKnrxtS
 pAsVPkS0T+Zf0prLz1amEXr1RM+XVLz9QB30/GWQEv/uVBTzHwEyF+q2i7B+qTFFd8zwmxwTqN2
 LTVXiwxkSQJo/Mq8BULWNT3xPkE5SOAKunBRUL0XgisZFOQU43UQIS0zjnzkP4T0RQtT7qEPSKE
 XzdW0R41AkQRwnoKWPeJI1Xgw8EVyB7f37VmZfPkeetdS26bFQGExhZh7ANj+q8MqFIVbIurKlm
 3Dd5i2M3Qn
X-Received: by 2002:a05:620a:4110:b0:939:b099:d52f with SMTP id
 af79cd13be357-949ba95dc6amr2632233885a.20.1795543173738; 
 Tue, 24 Nov 2026 09:59:33 -0800 (PST)
X-Received: by 2002:a05:620a:4110:b0:939:b099:d52f with SMTP id
 af79cd13be357-949ba95dc6amr2632230885a.20.1795543173248; 
 Tue, 24 Nov 2026 09:59:33 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb4481c2sm1086855385a.43.2026.11.24.09.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 09:59:32 -0800 (PST)
Message-ID: <ef774904-314a-46b0-8a97-27f759996cfa@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 14:59:29 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: Rely on cached TB flags in
 riscv_get_tb_cpu_state
To: SeungJu Cheon <suunj1331@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261119164438.193579-1-suunj1331@gmail.com>
 <20261119164438.193579-4-suunj1331@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261119164438.193579-4-suunj1331@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MCBTYWx0ZWRfX7SNWi9Y65qXP
 e37c6B3+0Wr5NSXKMKZuykYyt3mT86De4Wj93cVa3JNy3t0lCY5GaCEnBJQDoMC5qlCvTorOioZ
 RyxuohQgBusbVm+l+QVIFaTK6Tiyd54=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b05d086 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ag8o3q2mgML2VJ5gx9QA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MCBTYWx0ZWRfX6F9sitnwFh5K
 1cVozNHcK2cQx4u7ZxI+6zyuVdrj1BJNFfghf1shViyzdC4mUxEnx8o2vCzM+fqDtsgRFB4QM8m
 zSw3qxe9RfroGJc43cTm0RLzk0ae0OQONNPh1mQQktGmbILTabjr+j21V3y7AtnAil6agpaYyL8
 TtEMsBOF1u88YaGGtjlku9ngP+0yW3kbJYA69HXYcKMyweTdP++reqnLhG8CZdvONSpPq/9ctY6
 m9lRnWmKV/34mdreAh5ZzXetKwObz6I5jc9SjvEa1k4+XSkSgu4c8sjiTdZNKkA1bVtarLt9uRD
 Uf9l7AIz6j8JhMu4VZwETl8SebMKbr18Y+1UQfAJlAELIN9zwJroo2AzffP3iijIYnwPRNXn9cZ
 zU30dVTc7tvmqcRpPfDGkkMsJCgZasLsOY/wqng0UEPB8OXUjbSVTaKvP65Ac4mN/KchEalc81L
 MyxbjeK3kV96L/OaZnQ==
X-Proofpoint-ORIG-GUID: Ig2S_5ZpGcn1L3LCQYPbFE-TVNcVl4y1
X-Proofpoint-GUID: Ig2S_5ZpGcn1L3LCQYPbFE-TVNcVl4y1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240070
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



On 11/19/2026 1:44 PM, SeungJu Cheon wrote:
> Use the cached TB flags and VLMAX on each lookup. Compare the current
> vl with vlmax_cached when setting VL_EQ_VLMAX, since fault-only-first
> loads can reduce vl without triggering a cache rebuild.
> 
> With CONFIG_DEBUG_TCG, recompute the cached values on each lookup.
> If they differ, report the cached and recomputed values and abort.
> 
> The profile below is from a Linux boot and power-off on an RV64 virt
> machine with one vCPU pinned to a host core. The table shows perf self
> overhead in the vCPU thread. The profiles contain 57,013 samples before
> and 47,942 after; percentages are relative to each profile.
> 
>    Symbol                       Before    After
>    riscv_get_tb_cpu_state       16.54%    6.78%
>    helper_lookup_tb_ptr         11.30%   12.59%
>    riscv_pm_get_pmm              1.89%    0.09%
>    riscv_env_mmu_index           1.62%    0.18%
>    riscv_cpu_virt_mem_enabled    1.45%    0.09%
>    riscv_rebuild_tb_flags            -    0.67%
> 
> riscv_rebuild_tb_flags does not exist before this series. The share
> of helper_lookup_tb_ptr rises because the total shrinks; its sample
> count falls from about 6,440 to about 6,040.
> 
> Median boot time fell from 5.69 s to 4.81 s (-15.5%) over five runs
> per binary, alternating between the two binaries.
> 
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/tcg-cpu.c | 35 +++++++++++++++++++++++++----------
>   1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a8e744bc26..22c8eafbc7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -100,11 +100,13 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
>   }
>   
>   /*
> - * Compute the TB flags that depend only on state changed through CSR
> - * writes, traps, privilege changes and vsetvl.  For now the result is
> - * fed straight back to riscv_get_tb_cpu_state(), which adds the bits
> - * that translated code changes between two lookups -- FS/VS dirtying,
> - * elp, vstart, and vl, which fault-only-first loads shrink.
> + * Most TB flags depend only on state that changes through CSR writes,
> + * traps, privilege changes and vsetvl, so compute them once at those
> + * points and keep them in env (see riscv_rebuild_tb_flags() callers).
> + * This mirrors arm_rebuild_hflags().  The bits that translated code
> + * changes directly between two lookups -- FS/VS dirtying, elp, vstart,
> + * and vl, which fault-only-first loads shrink -- are added by
> + * riscv_get_tb_cpu_state() on each lookup.
>    */
>   static void riscv_compute_tb_flags(CPURISCVState *env, uint32_t *pflags,
>                                      uint64_t *pext_flags, uint32_t *pvlmax)
> @@ -195,16 +197,29 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       CPURISCVState *env = cpu_env(cs);
>       RISCVCPU *cpu = env_archcpu(env);
>       RISCVExtStatus fs, vs;
> -    uint32_t flags, vlmax;
> -    uint64_t ext_flags;
> -
> -    riscv_compute_tb_flags(env, &flags, &ext_flags, &vlmax);
> +    uint32_t flags = env->tb_flags_cached;
> +    uint64_t ext_flags = env->ext_tb_flags_cached;
> +
> +#ifdef CONFIG_DEBUG_TCG
> +    {
> +        uint32_t f, v;
> +        uint64_t e;
> +
> +        /* Catch a state change that did not rebuild the cached flags. */
> +        riscv_compute_tb_flags(env, &f, &e, &v);
> +        if (f != flags || e != ext_flags || v != env->vlmax_cached) {
> +            cpu_abort(cs, "stale TB flags: cached %08x/%016" PRIx64 "/%u, "
> +                      "recomputed %08x/%016" PRIx64 "/%u\n",
> +                      flags, ext_flags, env->vlmax_cached, f, e, v);
> +        }
> +    }
> +#endif
>   
>       if (cpu->cfg.ext_zve32x) {
>           bool vstart_eq_zero = env->vstart == 0;
>   
>           flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX,
> -                           vstart_eq_zero && env->vl == vlmax);
> +                           vstart_eq_zero && env->vl == env->vlmax_cached);
>           flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, vstart_eq_zero);
>       }
>   


