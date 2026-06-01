Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAE7CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8HD-0001mB-Ao; Mon, 01 Jun 2026 15:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8H6-0001hd-3I
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:26:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8H3-0006pi-9u
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:26:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651F0fpL3563558
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L3kNwGDGDT74Fl4S/QLiIgDVh0smOV0I0VigqOxInpY=; b=KmN+hzEgnkCEvxTo
 dVTLbPRZoyHsIg93QGSTiCIT461hHFNt4wvfYjqbN6uVxDdASL5viyM3WGYjt4x9
 PyxOI1hg7dukrXxahvi08T+WXGcyW2Q4C4QWKGtvc1mrMSqlyk9UH3f4WTEj4gA6
 yhyCq0Q03WmBFrLpFIc7Gd2kseAAxpcPB2zRuZlgi6h95vH0eTPvlAlV4B++g4tw
 MmU8a/eWbnXD845WnAG/IiPSgoHVz45woJZHPDW8STIWexQsp6sujynf93M2QWEZ
 ng+W+klOQF6zUCT7jMyNruw0vm9yn3I2rFm2eeQNjbV8v9kSqxAYdHuvd7uXoeBR
 N/rEQw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6rxtrtj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:26:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137dd5100c7so2879639c88.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780341967; x=1780946767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L3kNwGDGDT74Fl4S/QLiIgDVh0smOV0I0VigqOxInpY=;
 b=ZDKGqirMB7NecyjMBrAV/gEWQRupV5GxF7HSmso3tXyMUDEWljM45qBFC7gVvqJWOh
 zZI24SwuMoYk9KDAkrJwGRlvkJzN+0+NfcTP7DufKMvJiDdWMH8esqhFLQKDSnBdA3Uf
 /E0cWZ+KcpO7K/wWs/bt8fkV1CWHZwVaHefi5oK6J7+3qOCbtgz4qEdws+AlpENdXKbN
 kfgqhmykHC1vu7Oe8HFzJc9mFIl0paHcXGOXGkuA0Q7RXzY9pSnC//beT2MHnM1kJKOB
 02X+blh7PrGEjy3bGwUpH2aVwu2ZTt8Orc/lI5ltQu9IN5CeTWxnt64UWva16MNPyim8
 wiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780341967; x=1780946767;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L3kNwGDGDT74Fl4S/QLiIgDVh0smOV0I0VigqOxInpY=;
 b=tDIvRLaziwmXSp3TAe+KpIh5c3OEHYjArA929AL91HHCG/XrNjXcnL7ZEgbDUSRKqG
 oJAW/AO6PpyAZitwRYuGMvKexcLPuHzpYdvVCxwH/jrtFWWqVH0HaFlP/GWyuMQrWrji
 N4iRq4HRcSeYtqhqKpx9/H27DzTlW63xv7moIGffynZKUT2t3qBDbjaYsejNW7OfuXKK
 pjliY6gf0603mQz4L/+oWmPAlhe7LpYL9Gr/UutPgzWs6DbIXPvSssn/2FjJWOMWKzZH
 bOd1JdgxL+Jh8ISbKbpM5U9YX3kYQf5jEXZ0iMw6R5KIi7FlZnQnwhoYWykO6IHD4tmC
 EQtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9t/uyvRd9KgZoqVQ4bXVUh9IG4g71jx/dg7HGHSr6sFRRZVECsKdkeuKHeCRtEcF8E/Q1cyZPQ5DvF@nongnu.org
X-Gm-Message-State: AOJu0YzEvPkV2NyaW+XZxEqrHcYItEJrfg93S2BSVMIPecaByZw7kYv9
 5oNIil9IR4wR2qMgFUWDlHlDqNHOolCpql3hiJlm8VI1jzA+MsTr62gNzocRcZiIs2f7l6xV+GU
 Ab1+cUwWM5rZ1LYiMH5KWf1FwkkZG35fk5bJ2r6bZAcaYZsBbpHd7svZy5g==
X-Gm-Gg: Acq92OEaHN4i/rtcVCG/wpsoQ5pY6o93UrNRPOtZitZi6szfOoHNnlohnD/3a9XUcUu
 JMiZC1dAlZRsTtqw/ZiIwo0U8XGjhsLhX/723qdobukQfoum03kx+KIUiX2cy1aauW7VcIlrxNi
 Ehl1tkWAKacyFUUduDVC7a5hqiwHSg3V1bOO+WaH4jlSrg0y5b3kAt7lye7PMan83pB1QWXFkP3
 bU2C/LzFGgIfsMydtYa+Bb1LcfRRZAKUkmLy69btuOqCnN1+Rc4aZ0w1ryi92QYJLhhcDV9KVfD
 wz11Gw+0Lc53Nhpnb+mqH/aU99QY8UmqbDsQrc8+cvtOIxSWoFXotKLICzVgZorb8N3OueFMsMe
 Ho+i206wyuTHXJCecTJPXnGKwUazp+DsAcboPK05nehyvwUQVt6m2b/1LN6KeP3bVxAD7CUYz6b
 LuznMhuyzYdhNYorvqWFxQEBjQ
X-Received: by 2002:a05:7022:f91:b0:134:dfd0:9760 with SMTP id
 a92af1059eb24-137d3bf3b74mr5458487c88.5.1780341966418; 
 Mon, 01 Jun 2026 12:26:06 -0700 (PDT)
X-Received: by 2002:a05:7022:f91:b0:134:dfd0:9760 with SMTP id
 a92af1059eb24-137d3bf3b74mr5458465c88.5.1780341965734; 
 Mon, 01 Jun 2026 12:26:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c7fd47sm8035184c88.14.2026.06.01.12.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 12:26:04 -0700 (PDT)
Message-ID: <5423d944-1bbf-47a5-87c2-d711a9ff2aa8@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:26:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/28] target/hexagon: Add next_PC, {s,g}reg writes
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-22-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529215806.608770-22-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QIFfM_2qGNPE6sHDr893It2xr-BWxYjf
X-Authority-Analysis: v=2.4 cv=dsfrzVg4 c=1 sm=1 tr=0 ts=6a1ddccf cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Mgk8c5t6W8WsDp-O0L8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE4OSBTYWx0ZWRfX3L1Evf0da1Ri
 46MwAe4qXAQH0dAwP204jsVYKz7z7OXLmd73xmAurFJ9DSa3TrOs5LUd5FPB35OUJmHxfgJYyLk
 xx5db2l5LOMIFwKFNdF8dUxA91jPnWtnkmQqIVewey1XO/LZGh1LfGWh/veduEPvMih88JUhBbh
 u8qk4d2gTIglJMkq57+qoBvYK5gDOFtfKMJAHteMVkEUTcOL4erQk7H5jYDqNU3CkRpvQ5ATwtJ
 ITt7ygEzSLO9GWR5jImcjz0Zo6wYuBVTBdHzg7LDoTHV1r5a9l/ziSKubCUddu1F6PbtZwWsR2U
 I2JaST77T8KsbpFEmZ0mKL3mbERp63fGqoFPC2CSC7Iy6J2l9s7nxYmxdOC3wG+XWuEIUEuku5q
 ujBxI4iFUkHN+zt7sTB4xxvl4LMQ6ZSEva4wGpzLkhLQL4Tg391RD4v67ATcd98u+ATlQbawcIw
 hcbYxw7sdJukSkG9Lyg==
X-Proofpoint-ORIG-GUID: QIFfM_2qGNPE6sHDr893It2xr-BWxYjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010189
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

On 5/29/2026 2:57 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h |  2 +-
>  target/hexagon/translate.c | 77 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 74 insertions(+), 5 deletions(-)
> 
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index fea88cb2db7..0a7f37d5842 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -46,7 +46,7 @@ typedef struct DisasContext {
>      int greg_log_idx;
>      int sreg_log[SREG_WRITES_MAX];
>      int sreg_log_idx;
> -    TCGv_i32 t_sreg_new_value[NUM_SREGS];
> +    TCGv_i32 t_sreg_new_value[HEX_SREG_GLB_START];
>      TCGv_i32 greg_new_value[NUM_GREGS];
>  #endif
>      int preg_log[PRED_WRITES_MAX];
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 35e90362880..325c1a9e8fb 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -545,6 +545,10 @@ static void gen_start_packet(DisasContext *ctx)
>      ctx->reg_log_idx = 0;
>      bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
>      bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
> +#ifndef CONFIG_USER_ONLY
> +    ctx->greg_log_idx = 0;
> +    ctx->sreg_log_idx = 0;
> +#endif
>      ctx->preg_log_idx = 0;
>      bitmap_zero(ctx->pregs_written, NUM_PREGS);
>      ctx->future_vregs_idx = 0;
> @@ -577,6 +581,25 @@ static void gen_start_packet(DisasContext *ctx)
>       * gen phase, so clear it again.
>       */
>      bitmap_zero(ctx->pregs_written, NUM_PREGS);
> +#ifndef CONFIG_USER_ONLY
> +    for (i = 0; i < HEX_SREG_GLB_START; i++) {
> +        ctx->t_sreg_new_value[i] = NULL;
> +    }
> +    for (i = 0; i < ctx->sreg_log_idx; i++) {
> +        int reg_num = ctx->sreg_log[i];
> +        if (reg_num < HEX_SREG_GLB_START &&
> +            (ctx->need_commit || reg_num == HEX_SREG_SSR)) {
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
>      /* Initialize the runtime state for packet semantics */
>      if (need_slot_cancelled(&ctx->pkt)) {
> @@ -734,6 +757,50 @@ static void gen_reg_writes(DisasContext *ctx)
>      }
>  }
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
> +        } else if ((reg_num == HEX_SREG_STID) ||
> +                   (reg_num == HEX_SREG_IMASK) ||
> +                   (reg_num == HEX_SREG_IPENDAD)) {
> +            if (ctx->need_commit && reg_num < HEX_SREG_GLB_START) {
> +                tcg_gen_mov_tl(hex_t_sreg[reg_num],
> +                               ctx->t_sreg_new_value[reg_num]);
> +            }
> +            gen_helper_pending_interrupt(tcg_env);
> +        } else if ((reg_num == HEX_SREG_BESTWAIT) ||
> +                   (reg_num == HEX_SREG_SCHEDCFG)) {
> +            gen_helper_resched(tcg_env);
> +        } else if (ctx->need_commit && reg_num < HEX_SREG_GLB_START) {
> +            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
> +        }
> +    }
> +}
> +#endif
> +
>  static void gen_pred_writes(DisasContext *ctx)
>  {
>      /* Early exit if not needed or the log is empty */
> @@ -1030,6 +1097,10 @@ static void gen_commit_packet(DisasContext *ctx)
>      process_store_log(ctx);
>  
>      gen_reg_writes(ctx);
> +#if !defined(CONFIG_USER_ONLY)

ifndef

> +    gen_greg_writes(ctx);
> +    gen_sreg_writes(ctx);
> +#endif
>      gen_pred_writes(ctx);
>      if (ctx->pkt.pkt_has_hvx) {
>          gen_commit_hvx(ctx);
> @@ -1242,6 +1313,8 @@ void hexagon_translate_init(void)
>      hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
>          offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>  #ifndef CONFIG_USER_ONLY
> +    hex_cause_code = tcg_global_mem_new_i32(tcg_env,
> +        offsetof(CPUHexagonState, cause_code), "cause_code");
>      hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
>          offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
>  #endif
> @@ -1282,8 +1355,4 @@ void hexagon_translate_init(void)
>              offsetof(CPUHexagonState, vstore_pending[i]),
>              vstore_pending_names[i]);
>      }
> -#ifndef CONFIG_USER_ONLY
> -    hex_cause_code = tcg_global_mem_new(tcg_env,
> -        offsetof(CPUHexagonState, cause_code), "cause_code");
> -#endif
>  }

In general, we should use sized tcg op instead of rely on *_tl, but it
can be cleaned up later.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


