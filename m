Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBA7F5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEt3y-0004Lp-RX; Mon, 20 Apr 2026 14:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEt3w-0004Kt-NP
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:09:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wEt3u-0005WI-RC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:09:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KBVd5Z3212116
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L4OTL4OIVzpPO1af0z9xun02aPvq7ohVlQ8cg8/FPSc=; b=lQ85HbR9NT4l5V9v
 ezwH4cwI71vvddMntFAqhFjqOS0VWWxyTM/agBYvImlfHlDBr+jDyJjk6J2Wv/W5
 Nzu3+eDROHxANNbvdsTbyZlbGeAvPzDqizmact2arT+PFec+IyDTd6gXYeV0wGrp
 2LmGuGBBWwQJo/MsCvGPgwRckLUjvNPT9hoGCjvcyeFTyZ1gPDez2K9wgaam7ftP
 IWgQZNbLbkV3W9IBZfgux7IwZ3rFth7oVMOJp9628wziIXcAXA4sKBI067mKd5aX
 EqtxhpLgXdwgZoBXsGFuNexO8d0dih1hdspjCYijsMAg1k7X4qpLB1T71t2Y9Dm9
 rPUYwg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfcfjq3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:09:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c66fdd4aeso4780553c88.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776708572; x=1777313372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L4OTL4OIVzpPO1af0z9xun02aPvq7ohVlQ8cg8/FPSc=;
 b=gG+if7PgWmb/b11GNbwC5bXetwWits+pzh64C40ew+PW6FZ3DpxY0FFV6u/gB1y0J+
 Xp4v2AGD/6HbHhDQS4EILDjQo5rndMpd9YElVfWIEjO8++PadiXyFocNVqfJnn5FVyQY
 sY8yfncSQhHfbT2aZyumVK5jFE4rpdW0XNmeWe9us6CwpfnvYS+TvEYMBfEL4j4bEUu4
 HgsSaDpLNfU61dYuHMAYjwiSvJt16GJKkOYxR14+x6U8el8Sfq6dd0/7yavSUoTDiN9A
 1IcYbsyXpXALszvjBF/6aJl67OKPHbeIRxA235fvIWqgw8b7eVWiwIZwNq63tZAo3lER
 UIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776708572; x=1777313372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L4OTL4OIVzpPO1af0z9xun02aPvq7ohVlQ8cg8/FPSc=;
 b=qbEyGMZ1l0H1dMmlg62aR5jYEW9ka0X4Vi3kNTcic1GyUMxI81wSCnqIpJXUCK5tiH
 jTdttUlg6QfEVP3RBWA4lokqK8TSANghT421oaZTRD56RWl3UPZN84XpSDT9Ti9qJLcg
 hp6ANL22OvzzAknaFEmrVNSlMIv7rcWqL1Nb5hmyn+pK/UbJbVFOgxZujyN8ANVo1BOd
 QLBrgwe3ratymRGq7YFgNK4Afrsj9qPYKnYc1jDEy16OKJndzz4kMwO7ErL4jV6Hq7vY
 NcjUw1KhnE4WHFjGlMjMaDjmGqgWZyZ5eOkZQ9m1KhvyY5so/0S41jc5ADT6+mBpIS5/
 rZCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MPMnAdRFnQtuXTHw7dCEeKY/RsTvRdGJ2CycCW+qqzt/Y2Q6UG0toBrjW0l6b3EnN5CRForsk6n5g@nongnu.org
X-Gm-Message-State: AOJu0Yy3Tfagzg6hrn4fOjRL13Y7QeeQWvNm7goPK4ewPp3U6zJo0dro
 tdn07eULKCVYTgG0Ylbw9ztoemRJ3Ex4TCodSc/6zSliOvNXbFKoNrvMG28KCqSWQRB6DAoJUej
 +/ktZqwGMEsivggIoVSXezORCsTzvbJm9NJ6QLybtBuhgEhjQGP0X24TW4g==
X-Gm-Gg: AeBDiesVL5JBf0iocmtMMDklVXrVjM6cO9KRqeJuJj4L7uG5yGaWSBUxWAfXwJ6hQmg
 xxgasML/Xwh6iW1mjvu1AiaWdKD2PBIla/6nQiqZGYSKK68QHecDzr50JAz2HBhlaVhWvBeejpG
 IXyO7B3FAvTqgMOmw1N+vFpP8B3TNLf7BbeytBDBux3ZPZICXYvTRP0WBALwwpaTbUxZduRu+Xp
 r8G5xkCrpfzDpppy5SlWEY7rK3SOmARpo/NoX/OW5ST/bQ68+RkSJZdvZpltSAqgK0WKXLNHlKz
 V6KdznNWVM5VfusiwkeOBsKSHbsRw11c4z3lBgJWT+8wVWuWo7wiZJvbORycqT7VMfIwjJEwPLa
 Oo2NdFkSz6zCONx0ktlXq99BtWUvLktdcpNepIvjv/Q8E8G5Wz0v55VJux03W6oIOVMb0dfc6NE
 dXeEDI/cs55cPkzbDuiY6dIECF
X-Received: by 2002:a05:701b:290b:b0:12c:873f:eb8a with SMTP id
 a92af1059eb24-12c873feed6mr1922315c88.3.1776708571508; 
 Mon, 20 Apr 2026 11:09:31 -0700 (PDT)
X-Received: by 2002:a05:701b:290b:b0:12c:873f:eb8a with SMTP id
 a92af1059eb24-12c873feed6mr1922288c88.3.1776708570823; 
 Mon, 20 Apr 2026 11:09:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a20eb5sm19495516c88.14.2026.04.20.11.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 11:09:30 -0700 (PDT)
Message-ID: <224f0f75-9a8f-4cdf-b3ff-aae810bd6688@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:09:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/28] target/hexagon: Add next_PC, {s,g}reg writes
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
 <20260408041953.1899532-22-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260408041953.1899532-22-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NSBTYWx0ZWRfXxexg1kcJxdjt
 UFaDEejwVKhkMa9IT/xlRbscG36iaoNvbi6aoEYN4kjDk4JNZwoHWzR647RHaTnHgt/Hnq65ez4
 ESvsU8gBsbS+dJvrDdJvI8dLwBchDTWC+l3JGb4Gj47hXu+wPxU02El2Vtsu/bn2rl3PNzRoyYs
 1p7Ms/QrgnhmBAeezYg4YfE54KSljtuAc4AOBfZdQ94Dh/2rnSpuOu2ra+2Ap5DMSGW9maKGJ3j
 D+azyk22Gqzf/njzaU3MNJh/0pl58q8I7Whp4IPjT3BaHrWXWmiGRaBj6251sX4Z5TkuGkBMJAy
 hq7Kq2vHlmy8Xtg0zn1hClkOxhVdlN/tXysH9jCwkgef0cmsgoPoIe7A64dWYtwJOk5pAOwojbk
 9seqvH6RYtk8mw6Vi5ORu9/tM3TVG1+yZv+b+2VtyH6AcfG0QuRtql7tNvsg9+x9ZZEz+369yVK
 t1tdK2wOCUhfceXV/5g==
X-Proofpoint-ORIG-GUID: SkmpCSabwC5mmktsS-AiAUhsJRKw2w35
X-Proofpoint-GUID: SkmpCSabwC5mmktsS-AiAUhsJRKw2w35
X-Authority-Analysis: v=2.4 cv=L+ItheT8 c=1 sm=1 tr=0 ts=69e66bdc cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=zavLksu8pf8x-MWB8G8A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200175
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/7/2026 9:19 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/translate.h |  2 +-
>   target/hexagon/translate.c | 87 ++++++++++++++++++++++++++++++++++++--
>   2 files changed, 84 insertions(+), 5 deletions(-)
> 
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 82b327312ec..d5ea296ff26 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -45,7 +45,7 @@ typedef struct DisasContext {
>       int greg_log_idx;
>       int sreg_log[SREG_WRITES_MAX];
>       int sreg_log_idx;
> -    TCGv_i32 t_sreg_new_value[NUM_SREGS];
> +    TCGv_i32 t_sreg_new_value[HEX_SREG_GLB_START];
>       TCGv_i32 greg_new_value[NUM_GREGS];
>   #endif
>       int preg_log[PRED_WRITES_MAX];
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 6bba135f692..a42fd771f29 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -552,6 +552,10 @@ static void gen_start_packet(DisasContext *ctx)
>       ctx->reg_log_idx = 0;
>       bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
>       bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
> +#ifndef CONFIG_USER_ONLY
> +    ctx->greg_log_idx = 0;
> +    ctx->sreg_log_idx = 0;
> +#endif
>       ctx->preg_log_idx = 0;
>       bitmap_zero(ctx->pregs_written, NUM_PREGS);
>       ctx->future_vregs_idx = 0;
> @@ -584,6 +588,24 @@ static void gen_start_packet(DisasContext *ctx)
>        * gen phase, so clear it again.
>        */
>       bitmap_zero(ctx->pregs_written, NUM_PREGS);
> +#ifndef CONFIG_USER_ONLY
> +    for (i = 0; i < HEX_SREG_GLB_START; i++) {
> +        ctx->t_sreg_new_value[i] = NULL;
> +    }
> +    for (i = 0; i < ctx->sreg_log_idx; i++) {
> +        int reg_num = ctx->sreg_log[i];
> +        if (reg_num < HEX_SREG_GLB_START) {
> +            ctx->t_sreg_new_value[reg_num] = tcg_temp_new();
> +        }
> +    }
> +    for (i = 0; i < NUM_GREGS; i++) {
> +        ctx->greg_new_value[i] = NULL;
> +    }
> +    for (i = 0; i < ctx->greg_log_idx; i++) {
> +        int reg_num = ctx->greg_log[i];
> +        ctx->greg_new_value[reg_num] = tcg_temp_new();
> +    }
> +#endif
>   
>       /* Initialize the runtime state for packet semantics */
>       if (need_slot_cancelled(pkt)) {
> @@ -743,6 +765,61 @@ static void gen_reg_writes(DisasContext *ctx)
>       }
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static void gen_greg_writes(DisasContext *ctx)
> +{
> +    int i;
> +
> +    for (i = 0; i < ctx->greg_log_idx; i++) {
> +        int reg_num = ctx->greg_log[i];
> +
> +        tcg_gen_mov_tl(hex_greg[reg_num], ctx->greg_new_value[reg_num]);
> +    }
> +}
> +
> +
> +static void gen_sreg_writes(DisasContext *ctx)
> +{
> +    int i;
> +
> +    TCGv_i32 old_reg = tcg_temp_new_i32();
> +    for (i = 0; i < ctx->sreg_log_idx; i++) {
> +        int reg_num = ctx->sreg_log[i];
> +
> +        if (reg_num == HEX_SREG_SSR) {
> +            tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
> +            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
> +            gen_helper_modify_ssr(tcg_env, ctx->t_sreg_new_value[reg_num],
> +                                  old_reg);
> +            /* This can change processor state, so end the TB */
> +            ctx->base.is_jmp = DISAS_NORETURN;
> +            continue;
> +        } else if ((reg_num == HEX_SREG_STID) ||
> +                   (reg_num == HEX_SREG_IMASK) ||
> +                   (reg_num == HEX_SREG_IPENDAD)) {
> +            if (reg_num < HEX_SREG_GLB_START) {
> +                tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
> +                tcg_gen_mov_tl(hex_t_sreg[reg_num],
> +                               ctx->t_sreg_new_value[reg_num]);
> +            }
> +            /* This can change the interrupt state, so end the TB */
> +            gen_helper_pending_interrupt(tcg_env);
> +            ctx->base.is_jmp = DISAS_NORETURN;
> +            continue;
> +        } else if ((reg_num == HEX_SREG_BESTWAIT) ||
> +                   (reg_num == HEX_SREG_SCHEDCFG)) {
> +            /* This can trigger resched interrupt, so end the TB */
> +            gen_helper_resched(tcg_env);
> +            ctx->base.is_jmp = DISAS_NORETURN;
> +        }
> +
> +        if (reg_num < HEX_SREG_GLB_START) {
> +            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
> +        }
> +    }
> +}
> +#endif
> +
>   static void gen_pred_writes(DisasContext *ctx)
>   {
>       /* Early exit if not needed or the log is empty */
> @@ -1044,6 +1121,10 @@ static void gen_commit_packet(DisasContext *ctx)
>       process_store_log(ctx);
>   
>       gen_reg_writes(ctx);
> +#if !defined(CONFIG_USER_ONLY)
> +    gen_greg_writes(ctx);
> +    gen_sreg_writes(ctx);
> +#endif
>       gen_pred_writes(ctx);
>       if (pkt->pkt_has_hvx) {
>           gen_commit_hvx(ctx);
> @@ -1256,6 +1337,8 @@ void hexagon_translate_init(void)
>       hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
>           offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>   #ifndef CONFIG_USER_ONLY
> +    hex_cause_code = tcg_global_mem_new_i32(tcg_env,
> +        offsetof(CPUHexagonState, cause_code), "cause_code");
>       hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
>           offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
>   #endif
> @@ -1296,8 +1379,4 @@ void hexagon_translate_init(void)
>               offsetof(CPUHexagonState, vstore_pending[i]),
>               vstore_pending_names[i]);
>       }
> -#ifndef CONFIG_USER_ONLY
> -    hex_cause_code = tcg_global_mem_new(tcg_env,
> -        offsetof(CPUHexagonState, cause_code), "cause_code");
> -#endif
>   }

Use tcg_gen_mov_i32 instead of tcg_gen_mov_tl?

