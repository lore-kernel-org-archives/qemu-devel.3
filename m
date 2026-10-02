Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6732ACA5FCE
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 01:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCRla-0008Fm-AB; Thu, 01 Oct 2026 21:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCRlL-0008FC-U4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 21:08:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCRlI-0002f1-6P
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 21:08:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691NEipV2601685
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 01:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oh7Ig0jmYsyrRX7xcFXylSS3HXWbFKdRY8aReDTC6SY=; b=MHj/ajaAd9ahmOXP
 1FF7JIWnZDJ593q3WkCx10iDSsampDwyjLPfzNMl0Xvi+NFDFjcXlyJ9lurXGhK5
 xa02IX3qRjUDpvXsVdcyoIQvL7nkAhDmU7R/hYH+YMz9WXXlY/UjBKCL9k2g0yvD
 fVLlPceadavHiypLIEJoHIMi/cvr7ZVmG8Q+L9Nx7dfOfGHpX5NZoOxRcjzyfPil
 xBCcmbtY2NviSr/SrYZZIVcTlfyUmRL5AdIIPK6OyiYu9DMierbKtRKeNJ26E/Bc
 CQ1w7nRCgMQ4B2J/0KAoUf+0wX2MYBLQilMuSwX9e8m/OQiB/rWY5dgh/t4lpvHF
 UrfDmw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1vxe96kh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 01:08:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a3f673221so1892694285a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 18:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790903309; x=1791508109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oh7Ig0jmYsyrRX7xcFXylSS3HXWbFKdRY8aReDTC6SY=;
 b=K7OX8dktFstdYyWNYymssHGOLlv9n58pYBlPX6hvXXLtly/S6jKDFWYJXCDvE57eAb
 v/Dxe6Jb3x96F2VxzcItqYvUTEJkRLa3ebDTPdTHpDMwzuZMVIkuN4/ZpTCD7aoDomyR
 bXOmtWUhpK/2r7xbS333tDFFpofFoKZi5I+7nshHWnWt0bSdIEL62vhkYtgvxaHMW8ST
 cE9N0UStGSGOlBsITPiNmAEPy+BobqcJNBWM6rBY0mP863L9IFMUzwr6l7xXvlnm8ktp
 9DAoQTg4AJxeUK3E4WDNNTvmDeHsaP+tU9wBGHofhbgvhQ66qWmASolg7rCp0OATM1Qd
 zUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790903309; x=1791508109;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oh7Ig0jmYsyrRX7xcFXylSS3HXWbFKdRY8aReDTC6SY=;
 b=W7oCi7TbeY0qpyDkNdJ0HZJJaedJnibRiputp6oCAHAp0tHLuw0e2/vQ9ae/YxkBfV
 LJ5zhjrAdeiSbAry00CxU75CJxvigoCns/eJrAzgag7EJVDaKbhr0UFYaGV0H42wfz77
 pjVPJJ6F7T0zaoU+/kEcZ8fiHSGD8kxYQakWbusaBywpwHZ/uZIpmxA/+eivxQs+i5cN
 OJcax1tiEnzOLYGDUxSMY7UIThrJrcSYJubbC6lbybhLwG4TtKlfG9kuZpj8pv8YOklO
 e+sf7CN1U6EDESw1iKGieb+6wGZ7MWNnUr9R1eoXvvEVxLmypNk0Kf3ETtQnEia/t2e1
 uhmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBydwtRrPmw8rLz/CkjZDYpHadJNzXgpskbl714gjQjoFCh4ODEJy/IumzgTKBHmRRRkdnriiUg12JgU@nongnu.org
X-Gm-Message-State: AFuF++mHMWlY6/zuoIC7mlfwkS3AVWcPgEpZ7rkGFaXUvVBfEBHTQ2Be
 c/p6NYJ2tkpdhhM0ts+WJtNkCLSybrpR3+bp1xC2cWT/jMWZmGiKXGugmr/WGug1tRrtfwGVYbl
 LxoJ+Wla7PcURm50cYi6tTtI3SYxzZjiNpyLwQQx72pUelvxTDHwk+AuIxw==
X-Gm-Gg: AYBFou1byhUGUGMa4q6i7ZYLF6QmpVhc9hGZcAZiIE97jUbZ77OoqJLW/OF6nmmfs42
 ocT0KGtaSRLojLh9tOihLZIQYcCwGwj6uRbB3FLkF44zpwiVHpWajEpO/GDIKnG6iAPnmPXXqDr
 PNaUugIYC8lvAwaBfGgCxNXlBPyqMZt8fIkrre5Aa5n3qg5Z35PlA02290XRUWf/lK+avMQO43c
 N1h0Fp7qCsR/dH6FOKvh9stn87J5i0PsTuNY2JSbIwfFmPijw7qibj/VtZI2GAS/LuhjzUoeSEo
 a93Ps+iszQWAVi/zgF+HI+VkRU9lPDHbHBcBz/89tBIztRWMSCZaGdN3bjdYTBybELZm6yh4TGm
 1lZM+XQXPvdPnhMbhb0vLcRcqIDs0CPj9wA==
X-Received: by 2002:a05:620a:172a:b0:93d:f7bb:2cd8 with SMTP id
 af79cd13be357-93df7bb3159mr32613985a.0.1790903308603; 
 Thu, 01 Oct 2026 18:08:28 -0700 (PDT)
X-Received: by 2002:a05:620a:172a:b0:93d:f7bb:2cd8 with SMTP id
 af79cd13be357-93df7bb3159mr32609185a.0.1790903307914; 
 Thu, 01 Oct 2026 18:08:27 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca297e84sm91635185a.37.2026.10.01.18.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 18:08:26 -0700 (PDT)
Message-ID: <cb5715a2-0f2a-4b66-8dd0-5d8c2fb2f7da@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 22:08:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "linux-user/riscv: invalidate reservations after
 stores"
To: alistair23@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Rick <rick@sloservers.com>
References: <20261001232119.1765494-1-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001232119.1765494-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fdc4WEQF c=1 sm=1 tr=0 ts=6abf040d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=F-tV29oOAAAA:8 a=EUspDBNiAAAA:8
 a=CzpUCRikuoTYL3dqSJYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=xVlTc564ipvMDusKsbsT:22 a=Y2dezMJzicAI2PZykhZh:22
X-Proofpoint-GUID: 93f8gXTknXBZR3YBU8L-yTocuE0MsA4o
X-Proofpoint-ORIG-GUID: 93f8gXTknXBZR3YBU8L-yTocuE0MsA4o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAwNCBTYWx0ZWRfXxpxDSse6Bak2
 6G6w3FHvrjlpCwO/syaR+9N4rTY6fOee7rYG/cOsFG6QbCd8/8Zh6ZYy0ok++g7aS4Ojs1XvTHT
 SqL0n62G/kOh1/M02ge4R+nLwRnksZnWQeBR4REv2zreKtKldNBIe8s87vNL1aRt3wTEl7Cwp95
 FqMSy4tn6KIq8OjCu1EINoRXi37gkEjmHvz/kJWadtvoIRx8dn2Bt8A5iTERiRDy08iDG/Ryk/u
 9E0evK5eRBixooTUGr7tlrI4skVoj8Jvpw0upqo8M9yENW9IQTQoixLZX2f/dmSfO4otQx2wmls
 u4an8RdoYvmdDhnYm/HB6T2OkDnNF5rO67g8VMBB4YQmfu3WLZWLce6rybV0EmyjmBkr1sdEGDG
 T1XKt/nu/0W2OyA/31d4Eu5Ki7pYetUGPHJsLU8oJHcRaVvjAZ5czNw6YfzH5zE6x/9dIibHyxq
 0gkt+pppX2z0aM2HSdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAwNCBTYWx0ZWRfXzLntcBsD+Oi6
 HZQY+I17mPLpexRBOTu0GtPOmo+SEdljDLYferclsyPiu6UinTLUYG/zyKNeFEkbPFGxqer7kg3
 NkThL1pddF49vlaGtNEZHS0p215w72I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_05,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020004
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



On 10/1/2026 8:21 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> This reverts commit 5089493e45d3be2bae9ffd2a22186f57b0cabe3f.
> 
> Rick reported that this patch results in large slowdowns when using
> multiple threads. The original patch serialises all stores, resulting in
> all vCPUs stopping for every store, which would explain the slowdown.
> 
> The results from Rick show
> 
> xz compressing 2 MB at -6, without and with the patch:
> 
>                   without patch    with patch
>     xz -T1        5 s              122 s   (identical output)
>     xz -T8        1 s              no output after 600 s
> 
> That is too large of an overhead, so let's revert this patch until a
> better solution is found.
> 
> Reported-by: Rick <rick@sloservers.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   linux-user/riscv/target_cpu.h                 |  2 -
>   target/riscv/cpu.h                            |  3 --
>   target/riscv/helper.h                         |  5 ---
>   target/riscv/cpu.c                            |  3 --
>   target/riscv/tcg/op_helper.c                  | 35 -----------------
>   target/riscv/tcg/translate.c                  | 38 -------------------
>   target/riscv/tcg/insn_trans/trans_rva.c.inc   | 24 ------------
>   target/riscv/tcg/insn_trans/trans_rvi.c.inc   | 11 ------
>   .../riscv/tcg/insn_trans/trans_rvzawrs.c.inc  |  3 --
>   9 files changed, 124 deletions(-)
> 
> diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
> index eff18b37ba..9c642367a3 100644
> --- a/linux-user/riscv/target_cpu.h
> +++ b/linux-user/riscv/target_cpu.h
> @@ -9,8 +9,6 @@ static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
>       }
>   
>       env->gpr[xA0] = 0;
> -    env->load_res = -1;
> -    env->load_res_size = 0;
>   }
>   
>   static inline void cpu_clone_regs_parent(CPURISCVState *env, unsigned flags)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8c8ffe94cd..c2138dbd4b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -264,9 +264,6 @@ struct CPUArchState {
>   
>       uint64_t pc;
>       uint64_t load_res;
> -#ifdef CONFIG_USER_ONLY
> -    uint64_t load_res_size;
> -#endif
>       uint64_t load_val;
>   
>       /* Floating-Point state */
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index aab92bf132..4fc2d3a155 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1357,8 +1357,3 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
>   
>   /* Zalrsc SC write probe */
>   DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
> -
> -#ifdef CONFIG_USER_ONLY
> -/* Invalidate reservations overlapping a completed linux-user store. */
> -DEF_HELPER_3(riscv_invalidate_reservations, void, env, tl, tl)
> -#endif
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index da4c1a090b..5fff9d745e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1084,9 +1084,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       env->xl = riscv_cpu_mxl(env);
>       cs->exception_index = RISCV_EXCP_NONE;
>       env->load_res = -1;
> -#ifdef CONFIG_USER_ONLY
> -    env->load_res_size = 0;
> -#endif
>       set_default_nan_mode(1, &env->fp_status);
>       /* Default NaN value: sign bit clear, frac msb set */
>       set_float_default_nan_pattern(0b01000000, &env->fp_status);
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index b67c7718db..3e94005d2b 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -19,9 +19,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#ifdef CONFIG_USER_ONLY
> -#include "qemu/rcu.h"
> -#endif
>   #include "cpu.h"
>   #include "target/riscv/tcg/csr.h"
>   #ifndef CONFIG_USER_ONLY
> @@ -301,38 +298,6 @@ void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
>       probe_write(env, addr, size, mmu_idx, ra);
>   }
>   
> -#ifdef CONFIG_USER_ONLY
> -
> -void helper_riscv_invalidate_reservations(CPURISCVState *env,
> -                                          target_ulong addr,
> -                                          target_ulong size)
> -{
> -    CPUState *cpu;
> -
> -    /* EXCP_ATOMIC keeps other guest harts out while this list is updated. */
> -    WITH_RCU_READ_LOCK_GUARD() {
> -        CPU_FOREACH(cpu) {
> -            CPURISCVState *other_env = cpu_env(cpu);
> -            target_ulong reservation = other_env->load_res;
> -            target_ulong reservation_size = other_env->load_res_size;
> -            bool overlap;
> -
> -            if (other_env == env || reservation == (target_ulong)-1) {
> -                continue;
> -            }
> -            overlap = reservation < addr
> -                ? addr - reservation < reservation_size
> -                : reservation - addr < size;
> -            if (overlap) {
> -                other_env->load_res = -1;
> -                other_env->load_res_size = 0;
> -            }
> -        }
> -    }
> -}
> -
> -#endif
> -
>   #ifndef CONFIG_USER_ONLY
>   
>   target_ulong helper_sret(CPURISCVState *env)
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index cce3b6dc72..9684dbe752 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -42,9 +42,6 @@ static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc;
>   static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
>   static TCGv_i32 cpu_vl, cpu_vstart;
>   static TCGv load_res;
> -#ifdef CONFIG_USER_ONLY
> -static TCGv load_res_size;
> -#endif
>   static TCGv load_val;
>   
>   /*
> @@ -1144,34 +1141,10 @@ static bool gen_unary_per_ol(DisasContext *ctx, arg_r2 *a, DisasExtend ext,
>       return gen_unary(ctx, a, ext, f_tl);
>   }
>   
> -#ifdef CONFIG_USER_ONLY
> -static bool gen_riscv_reservation_serialize(DisasContext *ctx)
> -{
> -    /* Keep the memory operation and reservation update in one guest step. */
> -    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> -        gen_helper_exit_atomic(tcg_env);
> -        ctx->base.is_jmp = DISAS_NORETURN;
> -        return false;
> -    }
> -    return true;
> -}
> -
> -static void gen_riscv_invalidate_reservations(TCGv addr, MemOp mop)
> -{
> -    gen_helper_riscv_invalidate_reservations(tcg_env, addr,
> -                                             tcg_constant_tl(memop_size(mop)));
> -}
> -#endif
> -
>   static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>                       void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
>                       MemOp mop)
>   {
> -#ifdef CONFIG_USER_ONLY
> -    if (!gen_riscv_reservation_serialize(ctx)) {
> -        return false;
> -    }
> -#endif
>       TCGv dest = dest_gpr(ctx, a->rd);
>       TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>       MemOp size = mop & MO_SIZE;
> @@ -1186,9 +1159,6 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       src1 = get_address(ctx, a->rs1, 0);
>       func(dest, src1, src2, ctx->mem_idx, mop);
> -#ifdef CONFIG_USER_ONLY
> -    gen_riscv_invalidate_reservations(src1, mop);
> -#endif
>   
>       gen_set_gpr(ctx, a->rd, dest);
>       return true;
> @@ -1512,10 +1482,6 @@ void riscv_translate_init(void)
>       size_t pc_offset     = offsetof(CPURISCVState, pc) + field_offset;
>       size_t res_offset    = offsetof(CPURISCVState, load_res) + field_offset;
>       size_t val_offset    = offsetof(CPURISCVState, load_val) + field_offset;
> -#ifdef CONFIG_USER_ONLY
> -    size_t res_size_offset = offsetof(CPURISCVState, load_res_size)
> -                             + field_offset;
> -#endif
>   
>       for (i = 1; i < 32; i++) {
>           cpu_gpr[i] = tcg_global_mem_new(tcg_env,
> @@ -1535,9 +1501,5 @@ void riscv_translate_init(void)
>       cpu_vl = tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
>       cpu_vstart = tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstart");
>       load_res = tcg_global_mem_new(tcg_env, res_offset, "load_res");
> -#ifdef CONFIG_USER_ONLY
> -    load_res_size = tcg_global_mem_new(tcg_env, res_size_offset,
> -                                       "load_res_size");
> -#endif
>       load_val = tcg_global_mem_new(tcg_env, val_offset, "load_val");
>   }
> diff --git a/target/riscv/tcg/insn_trans/trans_rva.c.inc b/target/riscv/tcg/insn_trans/trans_rva.c.inc
> index 248a8c60d7..44c1696fe4 100644
> --- a/target/riscv/tcg/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rva.c.inc
> @@ -32,11 +32,6 @@
>   
>   static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
>   {
> -#ifdef CONFIG_USER_ONLY
> -    if (!gen_riscv_reservation_serialize(ctx)) {
> -        return false;
> -    }
> -#endif
>       TCGv src1;
>   
>       mop |= MO_ALIGN;
> @@ -58,9 +53,6 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
>   
>       /* Put addr in load_res, data in load_val.  */
>       tcg_gen_mov_tl(load_res, src1);
> -#ifdef CONFIG_USER_ONLY
> -    tcg_gen_movi_tl(load_res_size, memop_size(mop));
> -#endif
>       gen_set_gpr(ctx, a->rd, load_val);
>   
>       return true;
> @@ -68,17 +60,9 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
>   
>   static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
>   {
> -#ifdef CONFIG_USER_ONLY
> -    if (!gen_riscv_reservation_serialize(ctx)) {
> -        return false;
> -    }
> -#endif
>       TCGv dest, src1, src2;
>       TCGLabel *l1 = gen_new_label();
>       TCGLabel *l2 = gen_new_label();
> -#ifdef CONFIG_USER_ONLY
> -    TCGLabel *l3 = gen_new_label();
> -#endif
>   
>       mop |= MO_ALIGN;
>       mop |= ctx->mo_endianness;
> @@ -95,11 +79,6 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
>       src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>       tcg_gen_atomic_cmpxchg_tl(dest, load_res, load_val, src2,
>                                 ctx->mem_idx, mop);
> -#ifdef CONFIG_USER_ONLY
> -    tcg_gen_brcond_tl(TCG_COND_NE, dest, load_val, l3);
> -    gen_riscv_invalidate_reservations(src1, mop);
> -    gen_set_label(l3);
> -#endif
>       tcg_gen_setcond_tl(TCG_COND_NE, dest, dest, load_val);
>       gen_set_gpr(ctx, a->rd, dest);
>       tcg_gen_br(l2);
> @@ -125,9 +104,6 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
>        * an SC to any address, in between an LR and SC pair.
>        */
>       tcg_gen_movi_tl(load_res, -1);
> -#ifdef CONFIG_USER_ONLY
> -    tcg_gen_movi_tl(load_res_size, 0);
> -#endif
>   
>       return true;
>   }
> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> index 40b4c9aa4a..cc1b5dbbad 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> @@ -489,9 +489,6 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
>       }
>   
>       tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
> -#ifdef CONFIG_USER_ONLY
> -    gen_riscv_invalidate_reservations(addr, memop);
> -#endif
>       return true;
>   }
>   
> @@ -521,19 +518,11 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>           }
>           tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
>       }
> -#ifdef CONFIG_USER_ONLY
> -    gen_riscv_invalidate_reservations(addrl, memop);
> -#endif
>       return true;
>   }
>   
>   static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>   {
> -#ifdef CONFIG_USER_ONLY
> -    if (!gen_riscv_reservation_serialize(ctx)) {
> -        return false;
> -    }
> -#endif
>       memop |= ctx->mo_endianness;
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
> index 1831bbcfc0..0eef033838 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
> @@ -32,9 +32,6 @@ static bool trans_wrs_sto(DisasContext *ctx, arg_wrs_sto *a)
>   
>       /* Clear the load reservation  (if any).  */
>       tcg_gen_movi_tl(load_res, -1);
> -#ifdef CONFIG_USER_ONLY
> -    tcg_gen_movi_tl(load_res_size, 0);
> -#endif
>   
>       gen_update_pc(ctx, ctx->cur_insn_len);
>       tcg_gen_exit_tb(NULL, 0);


