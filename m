Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4181FC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7go-0001OU-Ke; Thu, 20 Aug 2026 14:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7gm-0001O2-Mk
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:40:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7gk-0002un-M1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:40:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJ8Y3352074
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 73IU29ftdhiABPNvcB57G3sg4zSdlwf2CiPJMgciVwY=; b=SPnZV4sFyEHuuCwN
 6JcXRbJGWMA8OIss+4GwArt3MXhpASE0KCYk0QO9n67HChPvVcNwQu3chh281kHZ
 /uvQ9P7xAWCtEaK3qR5xjwBVqyLT7xo08JoSv1ylXlfoZtUXeiEp79moUwJ1Tf3V
 bcgTHi0+D2SsCGmClQsSuXcqu3nIg7Ge+wUJafubEZW97yoV2kbT/Ym/HJ/OODN/
 qwSxGI0dfdhZN4yMzOTZPYfMPMw1CuKF4HePatJwhAjfkHRouCO065q2fXjAcNm/
 6dm+5jCk8w5ooev2Y3p26w1+wyh4TAH9eKcZ8hwbGdY0tBLJKjgxAMF9QbRBFjXn
 kA1qTw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8aa2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:40:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso144737a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787251228; x=1787856028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=73IU29ftdhiABPNvcB57G3sg4zSdlwf2CiPJMgciVwY=;
 b=ggHwW8zFqxsVpKCG+UnR6QIW/hnjKoqUnmGu36fuMGHwwO3D81Dy68eSKbXbJ5Nu2q
 Vcfsy4eaboKs0MVHYOcDrheD0PX7/sjQVDwjprzM8IfbOZF8SQPAYYR1bmX8sXhasTfN
 6TZ5xDZMrs+Sls/3+4p92nppEyN0+Vu/7mTLoR+gewcvn9RM51zbggf/ijtSdbd7vqki
 WRuTihM77he1a43Y5X228jlZJIL4gV6GCQvKowt+3DMB1c7eEpxYEhi+uBK4MHWyOxbJ
 caN/xbje9pkIdRugeWWwWkP4awlJ5hB8syB79IO+rL8SHDbu+6gHCr3B6Ph50QZLx5Sx
 0JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251228; x=1787856028;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=73IU29ftdhiABPNvcB57G3sg4zSdlwf2CiPJMgciVwY=;
 b=Xau8HyHC4OXNc6L5FmmWtsJQqMH3YKAahqg9G4nCNg1g75ypT9sJ6oqE679aJttCGC
 Dry55EmwX3K4XEQ2sx2Y2OJfv8RTUyOuC6tK2nVdQyhh91sPSbviXVYbpDpmWWsb/o/I
 VL2xgMMXrl31Gc0ozVCTqCL+iph14Fl6l5ctN9V9P1OircHSHV1an2IWR4Pwziaff3sC
 a8WxBU2F8EjOG/ssvfP6LjnnHeJeD7Aae8Iq0/dXX0w0HbziU5QSMM/bbaQ7UHOnPNah
 A5PIGUnJ9cuNY+hpU1PtMobIwMJrjvwUr6ztYpOPIWCHw1FKUJEehp1UVp4IDDcblxHI
 QySA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhNZVxVFHkmvw32DkyFwhFUD1oGZh2W9AvIxlKlxW5YBg7B6HvLki2PNO5K5laqCV3ZNPCm5GPmjKW@nongnu.org
X-Gm-Message-State: AFuF++kslWO70JdeWgWjjbJpu3hgpgXKpeTNpXGwsBiD1BP4HJMv7sLt
 ZRO7v/gYb5Ro0sds+SanifTlHTSA4z+Zu+f4plI6zBvO0X2g5GolCUYTUQ0AvEjcL0L9YSiS1fk
 hvdBKm7V3KCSqEurVX0fxB1RS1i8sTkvnFoYzigejLtFyhT+WU+995EBJoH8fkVVLag==
X-Gm-Gg: AR+sD13WWjE7tDsjUob7plHdTBDijoWqwa5YlOSxsUWkrSJvqZk9aJ8z2n2128tWvp4
 1Z/I9rnwfqZoDjx2eDvFBzV0uciXrjS9mXLQMRAYltdTVlmTlMrhUGQ2b4zYL46PspkpvOwP47F
 WtTGCb6AK6P8PLgaVhcXdG+xjbKfmW7dTXcRB85eSG7x9V2esKxCiYIfpwSZjWseQmEobVdVVAy
 XhnT370NOYSd9rYuDgRt1Dcrv/GNbSfp96IDufqZFzWRNWaPYAtobffRvdl8lFt0mjW6BWdGJ8Z
 eOobTvDgjlDtINSunS/84ytDhidc34cN7BsS0+oxQ9tuw7E8dZA+MHqIum68A7BThppLinzIWgB
 d9v8k4dg+Sh77G07b8rJsqvhKMOY+7xVHjUv8N+iSd9BaVtoYij3S62pnuFBxvJO4Ly43
X-Received: by 2002:a17:90b:558b:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-395c33371a9mr1240784a91.2.1787251228032; 
 Thu, 20 Aug 2026 11:40:28 -0700 (PDT)
X-Received: by 2002:a17:90b:558b:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-395c33371a9mr1240688a91.2.1787251227522; 
 Thu, 20 Aug 2026 11:40:27 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bec30f49sm16880745eec.0.2026.08.20.11.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:40:26 -0700 (PDT)
Message-ID: <51289d66-1d42-4f7d-a1e0-652150f45a78@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/hexagon: align exceptions for user/sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfXzsXGi8UeIR1e
 Gn5UceFSdzPZL+cAstAp7+5geWhne8W5oCqXASs2sijD7UzFoLxlHPiQZC8jNpmx4/5pkIsoE7U
 cgOPb4ZCpzibEb19S8SeRr6dr2THsJ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfX/ih70p9sYIag
 fqABjHRXPJ0xq944GDZLO7XEThgaVeq008LeWT04vhXJQqt9dXZaGl2LV3r2RSFRLDP9/8A+up8
 4DIAEYILwk34kvaHChNEljOVcT7yYgtuevXxnWOqgvV2G+SByzaoUZ88bFfo5VzbEOgRpYLnOXB
 gFA1jMPZX+/A+raR72G7xTkfgVCNIIWT2H1LhFeXG78rX3XzrsPIZyNz8WTGazqXa6Ry/S6371W
 5OMKS5M2Bap+IcPcEZHJ/xV2hGbdkftlBNwrvv5qQHTJQH00nMtN3sNr8WqC8QsKqjDnWgpy7t5
 KxbXzoHVV/IcfCVoQfFFfmRLwIpSdeAfYM9yWWinOr7ioOpoovrD3N51gnU7kUqhRWYBAUeWHD5
 CFXfQW+/YprpkyjkF6KEcPVByEvEnEFp1MQpj3ImDSc1WXCSTj8fHCfPxlyoM6Jat26hGpx40/h
 zQ8aowA8FTLMxLTQN5A==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a874a1d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-GzpjuVJtetGDGsFWMwA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: QVpO0Vnf-eteACqJ5TDMXR1t1bJr7Naq
X-Proofpoint-ORIG-GUID: QVpO0Vnf-eteACqJ5TDMXR1t1bJr7Naq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> System mode reports an exception as cs->exception_index = HEX_EVENT_* plus
> env->cause_code = HEX_CAUSE_*, but translated code in user mode put the cause
> code straight into exception_index, so cpu_loop() was decoding both forms.
> gen_exception_decode_fail() and the misaligned-PC check used the raw form
> unconditionally, so in system mode the cause code was misread as an event
> number.
> 
> Use the {event, cause} everywhere and drop the duplicated cases
> from cpu_loop(), which fixes HEX_CAUSE_PRIV_USER_NO_SINSN and
> HEX_CAUSE_PRIV_USER_NO_GINSN.  The misaligned PC is no longer zeroed
> on its way out either, so it reaches the signal frame as si_addr instead
> of whatever r31 held.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h    |  2 +-
>  linux-user/hexagon/cpu_loop.c | 30 +++++++++++-------------------
>  target/hexagon/cpu.c          |  3 ++-
>  target/hexagon/translate.c    | 27 +++++++++------------------
>  4 files changed, 23 insertions(+), 39 deletions(-)
> 
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 3c5773e2c73..00de2b0d2ec 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -330,7 +330,7 @@ extern TCGv_i32 hex_t_sreg[NUM_SREGS];
>  #endif
>  
>  
> -void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
> +void hex_gen_exception_end_tb(DisasContext *ctx, int cause);
>  
>  void process_store(DisasContext *ctx, int slot_num);
>  
> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
> index d7f73439dbc..e4ef97a1184 100644
> --- a/linux-user/hexagon/cpu_loop.c
> +++ b/linux-user/hexagon/cpu_loop.c
> @@ -66,21 +66,22 @@ void cpu_loop(CPUHexagonState *env)
>              case HEX_CAUSE_FETCH_NO_UPAGE:
>              case HEX_CAUSE_PRIV_NO_UREAD:
>              case HEX_CAUSE_PRIV_NO_UWRITE:
> -            force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
> -                    env->gpr[HEX_REG_PC]);
> -
> -            break;
> +                force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
> +                                env->gpr[HEX_REG_PC]);
> +                break;
>              case HEX_CAUSE_PRIV_USER_NO_GINSN:
>              case HEX_CAUSE_PRIV_USER_NO_SINSN:
>              case HEX_CAUSE_INVALID_PACKET:
> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
> -                    env->gpr[HEX_REG_PC]);
> -            break;
> +            case HEX_CAUSE_REG_WRITE_CONFLICT:
> +                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
> +                                env->gpr[HEX_REG_PC]);
> +                break;
>              case HEX_CAUSE_MISALIGNED_LOAD:
>              case HEX_CAUSE_MISALIGNED_STORE:
> -            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
> -                    env->gpr[HEX_REG_PC]);
> -            break;
> +            case HEX_CAUSE_PC_NOT_ALIGNED:
> +                force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
> +                                env->gpr[HEX_REG_PC]);
> +                break;
>              default:
>                  EXCP_DUMP(env, "\nqemu: unhandled CPU precise exception "
>                      "cause code 0x%x - aborting\n",
> @@ -88,15 +89,6 @@ void cpu_loop(CPUHexagonState *env)
>                  exit(EXIT_FAILURE);
>              }
>              break;
> -        case HEX_CAUSE_PC_NOT_ALIGNED:
> -            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
> -                            env->gpr[HEX_REG_R31]);
> -            break;
> -        case HEX_CAUSE_INVALID_PACKET:
> -        case HEX_CAUSE_REG_WRITE_CONFLICT:
> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
> -                            env->gpr[HEX_REG_PC]);
> -            break;
>          case EXCP_ATOMIC:
>              cpu_exec_step_atomic(cs);
>              break;
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 7067e5b70f7..0bbefc2fb87 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -323,7 +323,8 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
>          hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>      }
>      if (pc & PCALIGN_MASK) {
> -        hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
> +        env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
> +        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc);
>      }
>  
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 06a8159d283..5cfa60ca302 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -73,8 +73,8 @@ TCGv hex_vstore_pending[VSTORES_MAX];
>  #ifndef CONFIG_USER_ONLY
>  TCGv_i32 hex_greg[NUM_GREGS];
>  TCGv_i32 hex_t_sreg[NUM_SREGS];
> -TCGv_i32 hex_cause_code;
>  #endif
> +static TCGv_i32 hex_cause_code;
>

Shouldn't this be part of CPUState?
What if multiple cpus trigger an exception at the same time?

>  static const char * const hexagon_prednames[] = {
>    "p0", "p1", "p2", "p3"
> @@ -128,19 +128,14 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
>      return offset;
>  }
>  
> -static void gen_exception(int excp, uint32_t PC)
> +static void gen_precise_exception(int cause, uint32_t PC)
>  {
> -    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp),
> +    tcg_gen_movi_i32(hex_cause_code, cause);
> +    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
>                                 tcg_constant_i32(PC));
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static inline void gen_precise_exception(int excp, uint32_t PC)
> -{
> -    tcg_gen_movi_i32(hex_cause_code, excp);
> -    gen_exception(HEX_EVENT_PRECISE, PC);
> -}
> -
>  static void gen_pcycle_counters(DisasContext *ctx)
>  {
>      if (ctx->pcycle_enabled) {
> @@ -224,14 +219,10 @@ static void gen_end_tb(DisasContext *ctx)
>      ctx->base.is_jmp = DISAS_NORETURN;
>  }
>  
> -void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
> +void hex_gen_exception_end_tb(DisasContext *ctx, int cause)
>  {
>      gen_exec_counters(ctx);
> -#ifdef CONFIG_USER_ONLY
> -    gen_exception(excp, ctx->pkt.pc);
> -#else
> -    gen_precise_exception(excp, ctx->pkt.pc);
> -#endif
> +    gen_precise_exception(cause, ctx->pkt.pc);
>      ctx->base.is_jmp = DISAS_NORETURN;
>  }
>  
> @@ -239,13 +230,13 @@ void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
>   * Generate exception for decode failures. Unlike gen_exception_end_tb,
>   * this is used when decode fails before ctx->next_PC is initialized.
>   */
> -static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int excp)
> +static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int cause)
>  {
>      target_ulong fail_pc = ctx->base.pc_next + nwords * sizeof(uint32_t);
>  
>      gen_exec_counters(ctx);
>      tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], fail_pc);
> -    gen_exception(excp, fail_pc);
> +    gen_precise_exception(cause, fail_pc);
>      ctx->base.is_jmp = DISAS_NORETURN;
>      ctx->base.pc_next = fail_pc;
>  }
> @@ -1361,9 +1352,9 @@ void hexagon_translate_init(void)
>          offsetof(CPUHexagonState, llsc_val), "llsc_val");
>      hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
>          offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
> -#ifndef CONFIG_USER_ONLY
>      hex_cause_code = tcg_global_mem_new_i32(tcg_env,
>          offsetof(CPUHexagonState, cause_code), "cause_code");
> +#ifndef CONFIG_USER_ONLY
>      hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
>          offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
>  #endif


