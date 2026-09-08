Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCD8C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tpj-0004yd-5w; Tue, 08 Sep 2026 07:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3tpc-0004xm-HL
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:17:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3tpZ-0004X7-NG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:17:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688ADYGV2678263
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 11:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z3gBqr1tMwecJrW86FDsov3Ol6f0JFD/I2ppVgB1cIA=; b=ec32S8yewFuZ/L5F
 NXR9SoCfJq2wteuhFCqMI00IVidYxHkl3pYcL3f/gSqMxeFYi+4Wgq9F/09bi3u9
 Fn2UqF8IBfoKnX1m/R3wlB9fMPpj0zNipqPUiasOHINiqcr4TnqctbZkNKiiOufM
 xWjpDb839ONWceikBhEyotMuvbVe5IIYYhPLe6zgTqwhmJxNEVcoI9owcZsXRRPv
 vpLQCYyiQasH4bj84OLzj6B3WZbGnB+R38Uv/rBnGh6XLT6NBPm6gz4ualIQDwvm
 WuFhwiAkUxCfMSiyqWKBerg1nQoXdstG08TrnxuNiddGJE0Mko0V8F3Vi/2lKg0U
 GJAoHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwk5t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 11:17:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-938153538caso691382185a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788866254; x=1789471054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z3gBqr1tMwecJrW86FDsov3Ol6f0JFD/I2ppVgB1cIA=;
 b=Ew9QqGH+wvKZYlZgek6tXh2dKkR54kAplX1cDV6s3Ud/J5qCl+NlW3I5zOu0UbEXEH
 siYuvLPwuTLkp8HqTXZVYwqZR6ktySujSLoqbVC1xQ9o5/YuqdrxUQxA5VyMxiCGfEbu
 oq3gFuBwyf1P424iOzr97VSwuz6JlT5hCqVhr3HK8JzH3tQjWyXDCAYMCR/swMx8JabA
 JHZC2YBZDYOHxDGGW9VOgWPx/UwPN+gSuCZMRBQ+ao9NaNgJQrCPuQ9wmhtaNm9SxmFz
 R1UpFUJ6bS7vCBHYcfdk3c+jdfT1VZtpZUXZ/yjqMk7Qz+21dqISkP9ZDA884Am9o2Pd
 d95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788866254; x=1789471054;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z3gBqr1tMwecJrW86FDsov3Ol6f0JFD/I2ppVgB1cIA=;
 b=UJKZqldPINQrifKmO2dLf9MEhmw6oG24pJKQYurgHHPtEaNdE/MjSwC6rZTXq+4cxp
 sk54W+ykGNL2xr+CvRW+MhExsO910HREy2YZB9uEqRt1ToXZGEi/Kxqz4Z0gulkpnkeQ
 i/ESdOasyy1WPYERJl/Di3a4JMjV+JwQyZJ8Nt9FhViTx6Hc4dRhBlTAjx2Iq8j6W4G0
 uqR44/5NC1QW3HeqlmjLApoO75LY+UFfwAejoa3PCiOJkvYXdv3vojsF3Oh8Idly4JO0
 vQMqPnvLjE7cqV6hxJG3XUjmKgGgbw7DpdM1S1Ns98QRNUqtGq7rTAEqy0yPXHDpjHYi
 cuzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkB8sSeCNoRUM2oubmKRThNnUY5HOS42tWEOMt9flJvUdn9I6ZK4tm7PdZxDPEnXqpN3hTRQSJWDZ3@nongnu.org
X-Gm-Message-State: AFuF++kAc50s+jblFcpDnfS0egdJeFOCu77P+peTQpn93iWBKaYSHPmJ
 TONHE6DMi2fWLmA2Neso0kH9/v1yzbhPuL/JBeloAGHpqgpJKRa9NQNGD8lJzxutVTtj35ilO3X
 oDmV/NhUiUVyZKAfDfO++dTYfxgf63Op5d+0Q+YMTBxL1ozbjn7RXyu816Q==
X-Gm-Gg: AYBFou3H/C6G+JIvTfvq9FARXYatn7gSkwCeC6QpVo89nZHUhFHswhFcoI+hxolaUHn
 ox2BwZBt6kVlkveGFUk5CunvdzT5FG1EBBTCL1c2e6wfDaIyVem+D0deec3siajTGZrOTWR8npj
 bQk0nsjLskLF0xU7RenrUACjxDeUjeqehlMuV8SDZXtEKj16hbkEYpNBAAMAeJIFfSmgODG1r0M
 8B6s+Yn7Mn8lqx+y+yCKf5h9NCEDOi7vXRUHxQJ7tjLb4f+en9IKAFbNUKNaihILWOgljyjEbpC
 YtB/PNz4iBsklHYvlNn2rAiTI1zTa+GBHNf6mG8W13tnFuJNV3ZKf9aLJD58oz9H3kRxLx3CYPW
 xc190ORxxKQBfpwBznFl3ZRCmMUwOluZ136hx
X-Received: by 2002:a05:620a:bce:b0:939:993e:bffb with SMTP id
 af79cd13be357-939993ec19amr2109931585a.22.1788866253712; 
 Tue, 08 Sep 2026 04:17:33 -0700 (PDT)
X-Received: by 2002:a05:620a:bce:b0:939:993e:bffb with SMTP id
 af79cd13be357-939993ec19amr2109924785a.22.1788866253091; 
 Tue, 08 Sep 2026 04:17:33 -0700 (PDT)
Received: from [192.168.15.12] ([177.214.151.199])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb2fd82sm1109544985a.17.2026.09.08.04.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 04:17:32 -0700 (PDT)
Message-ID: <61be29dd-2aab-4d7e-b199-10aa49b82418@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 08:17:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix RV32 fixed counter accesses
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260905092810.660-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905092810.660-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9feece cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=lJrVL2S40hk4Skp227i47g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=CterQ15v7jWwiqUy-LwA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEyMCBTYWx0ZWRfX1eifOIiSsxhO
 9d0+FThEQzC1bdECJ6cb4NzOPaCqL60AWR9gIaYdBC/1DJd7GABhMoR9DZBhP6DGReswZHxMkyE
 8/0d2jhWBVc96Og4cpqFzXxPR4JPizk3it2ZYDFlZvh8R+jXS7WgLyf3w5RbOHwaBEPe5h++59N
 GOcfdPXHtqmnzi2FsZOYHFa34PREFTwa3VKMhYziTQGVlqIojJWOrmrjs6mbXXKbvGyWgaLl19o
 SPvnlmpi0TLnnpUdvIGexjfd9udrWrZGWHJ3k8StAJhwoc0jUbafq8j8Bu/lGxFajAk+7qhGGSr
 Xxg291LoQnUY/P/YYkbzfA1PFlYu6Ab4/9mysOQZOmW8nyVFsDAfWjQlk0TyJhIHC19Sx+0f2U9
 ibIexBXdw1IsRkK/6mJb/n8i2p+M5IxcaoreVJp3/48/vSuC8OoHFt/I32AC6lod9wDKXtTkW3b
 kqDkR4Fj1pM1aJ/Df2A==
X-Proofpoint-ORIG-GUID: K8tZlkdEG57-hog6kglReeNA15URAqwV
X-Proofpoint-GUID: K8tZlkdEG57-hog6kglReeNA15URAqwV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEyMCBTYWx0ZWRfX3jminKm70VQ8
 jZRUk+rQ1f0oyQGIr4W+kJxy45GZqlPFVrq5EEDBNNth3/DsmQUjJmz1Q3CbBIk0aD+tUVnLhz/
 PR3cUaHhCmcMhK/ktBltE5dbMtuJDLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080120
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/5/2026 6:28 AM, Zephyr Li wrote:
> Since commit cfc96df65e01, riscv_pmu_ctr_get_fixed_counters_val()
> returns the complete 64-bit fixed-counter value. The RV32 counter
> access paths, however, still perform parts of the offset calculation
> on separately extracted 32-bit halves.
> 
> In particular, riscv_pmu_write_ctrh() deposits the low 32 bits of the
> complete fixed-counter value into the high half of mhpmcounter_prev.
> riscv_pmu_read_ctr() also subtracts a 32-bit half of the previous value
> from the complete 64-bit fixed-counter value. Consequently, writes to
> mcycleh can be lost and carries between the low and high halves are not
> handled correctly.
> 
> Keep the fixed-counter offset calculation entirely in 64 bits. Before
> a running counter is partially written, materialize its current
> architectural value and reset the fixed-counter baseline. On reads,
> calculate the complete 64-bit counter value before extracting the half
> requested by RV32.
> 
> Add an RV32 system TCG test for high-half writes, low-to-high carry, and
> preserving the carried high half across a subsequent low-half write.
> 
> Fixes: cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4219
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/csr.c                    | 32 ++++++++--------
>   tests/tcg/riscv64/Makefile.softmmu-target | 12 ++++++
>   tests/tcg/riscv64/test-mcycle-rv32.S      | 45 +++++++++++++++++++++++
>   3 files changed, 74 insertions(+), 15 deletions(-)
>   create mode 100644 tests/tcg/riscv64/test-mcycle-rv32.S
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 002f7e69c1..ffdd5c4aa6 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1337,23 +1337,23 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
>       int deposit_size = rv32 ? 32 : 64;
>       uint64_t ctr;
>   
> -    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> -                                         0, deposit_size, val);
> -
>       if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
>           (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>            riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
>           ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> -        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
> -                                              0, deposit_size, ctr);
> +        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
> +        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                             0, deposit_size, val);
> +        counter->mhpmcounter_prev = ctr;
>           if (ctr_idx > 2) {
>               riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
>           }
>        } else {
> +        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                             0, deposit_size, val);
>           /* Other counters can keep incrementing from the given value */
>           counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
>                                                 0, deposit_size, val);
> -
>       }
>   
>       return RISCV_EXCP_NONE;
> @@ -1363,20 +1363,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
>                                             uint32_t ctr_idx)
>   {
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> -    uint64_t ctrh;
> +    uint64_t ctr;
>   
> -    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> -                                         32, 32, val);
>       if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
>           (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>            riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> -        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> -        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
> -                                              32, 32, ctrh);
> +        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> +        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
> +        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                             32, 32, val);
> +        counter->mhpmcounter_prev = ctr;
>           if (ctr_idx > 2) {
>               riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
>           }
>       } else {
> +        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                             32, 32, val);
>           counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
>                                                 32, 32, val);
>       }
> @@ -1407,12 +1409,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>       bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
>       int start = upper_half ? 32 : 0;
>       int length = rv32 ? 32 : 64;
> -    uint64_t ctr_prev, ctr_val;
> +    uint64_t ctr_val;
>   
>       /* Ensure upper_half is only set for XLEN == 32 */
>       g_assert(rv32 || !upper_half);
>   
> -    ctr_prev = extract64(counter->mhpmcounter_prev, start, length);
>       ctr_val  = extract64(counter->mhpmcounter_val, start, length);
>   
>       if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
> @@ -1431,7 +1432,8 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>           uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
> -                                                             ctr_prev + ctr_val;
> +                        counter->mhpmcounter_prev +
> +                        counter->mhpmcounter_val;
>           *val = extract64(cntr, start, length);
>       } else {
>           *val = ctr_val;
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 6a219c306c..15c7371acd 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -28,6 +28,18 @@ EXTRA_RUNS += run-test-minstret-ecall
>   run-test-minstret-ecall: test-minstret-ecall
>   	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
>   
> +RV32_CFLAGS = -march=rv32im_zicsr -mabi=ilp32
> +CLEANFILES += test-mcycle-rv32
> +
> +test-mcycle-rv32: test-mcycle-rv32.S $(LINK_SCRIPT)
> +	$(CC) $(CFLAGS) $(RV32_CFLAGS) $< -Wa,--noexecstack -c -o $@.o
> +	$(LD) -m elf32lriscv $(LDFLAGS) $@.o -o $@
> +
> +EXTRA_RUNS += run-test-mcycle-rv32
> +run-test-mcycle-rv32: test-mcycle-rv32
> +	$(call run-test, $<, \
> +	  $(QEMU) -cpu rv32 -icount shift=1 $(QEMU_OPTS)$<)
> +
>   EXTRA_RUNS += run-plugin-doubletrap
>   run-plugin-doubletrap: doubletrap
>   	$(call run-test, $<, \
> diff --git a/tests/tcg/riscv64/test-mcycle-rv32.S b/tests/tcg/riscv64/test-mcycle-rv32.S
> new file mode 100644
> index 0000000000..189d1e13a2
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-mcycle-rv32.S
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +
> +	.text
> +	.global	_start
> +_start:
> +	/* Exercise writes while mcycle is running. */
> +	csrw	mcountinhibit, zero
> +	csrw	mcycle, zero
> +
> +	/* A write to the high half must be immediately observable. */
> +	li	s0, 0x1234ffff
> +	csrw	mcycleh, s0
> +	csrr	t0, mcycleh
> +	bne	t0, s0, fail
> +
> +	/* Check carry from the low half into the high half. */
> +	li	s0, 0x12345678
> +	csrw	mcycleh, s0
> +	li	t0, 0xfffffff0
> +	csrw	mcycle, t0
> +	.rept	32
> +	nop
> +	.endr
> +	csrr	t0, mcycleh
> +	addi	s0, s0, 1
> +	bne	t0, s0, fail
> +
> +	/* A low-half write must preserve the carried high half. */
> +	li	t0, 0x22222222
> +	csrw	mcycle, t0
> +	csrr	t0, mcycleh
> +	bne	t0, s0, fail
> +
> +	li	t0, 0x100000
> +	li	t1, 0x5555	/* FINISHER_PASS */
> +	sw	t1, 0(t0)
> +	j	.
> +
> +fail:
> +	li	t0, 0x100000
> +	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
> +	sw	t1, 0(t0)
> +	j	.


