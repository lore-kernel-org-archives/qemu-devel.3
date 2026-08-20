Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683E9C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8Vc-0006oE-V8; Thu, 20 Aug 2026 15:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx8Va-0006o5-Jy
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:33:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx8VX-0003dH-DW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:33:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJ4Iu3795505
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 szN4rngyn/NYtdWDxrMoJ7WcHUNChL9Z/LArlNiqJW4=; b=WG92eWBgFJXoNkBx
 1qVRgwWdytKhJEw/7mOgDCA1/5cXPjcbIoWUaRHcq4tsaRtH440aRDmAUC9IclRq
 BXAsGRmnxIItDgElAYCEsSK61OOOr5uZH8vXGiUnmKrEiUjs1CCJos8MOyos2ppr
 drYHbT2GE+5nwObEfNJxxTgu40y0qCXjQF+qD6jilhBIBYKWYZ5zyo4z/iZymNQ4
 B7zdAyN0VhPepc7vs1KhojqikBhG+iZ/ZaDrV4B5nEP4lTfjGFVDNs9HHydHW/ML
 hE7twfaFtaCeUXixn5yTcJiSTQG7iWhjSK6ycTvmVZlpIEOdgAjAK5oMyQ8t5AwN
 wzQ2/A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbvay5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:32:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso3121915ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787254372; x=1787859172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=szN4rngyn/NYtdWDxrMoJ7WcHUNChL9Z/LArlNiqJW4=;
 b=N9SZaGcdRnXNjADj/FIryYW/4c5ayXjfj+LoY0nKgzov5DnPV9s4F2lNDo7+D9Sc+c
 nJXCsPLiMXzIc30DL3qRlnGabCspttYVLTYUAKAvIiK0loha1hl35VEx35K/hCtLdci5
 tJ1I67NBKOXR1gmge0qpA55V8rMWO6fawtGKIr6lfLoNY4514F1DEzQ8SPmxxSEaNcp9
 ZrOZe5fyQxwC/BywO/9WFxLbE0gOjwyxh2kPt9+iGiC0usQlrzpuVUdpJf7819tp1ksL
 rAx2PhenktuhrXPw9BjVeGTOOLhYZetqlgUvN/h3bGIGiX9QPkyKIyYk6dv85bre07vy
 fpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787254372; x=1787859172;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=szN4rngyn/NYtdWDxrMoJ7WcHUNChL9Z/LArlNiqJW4=;
 b=InUmejCVvioqu/uTTFPYEvcMTaVL3GB0EI/QcKg2JSbvUWkmskkgnrNWzG/CNDpGuk
 JdrosR2lRlzCwCYJG86hGWkEohqt02dsipBvSQWPnIF/93pUmtMrfWuXAcP+wYHbfdYy
 IAjmq2cJ7RPZWVPsPMBOtrMv8B98dVUdUFgVJgE3muYhr715S3cuph28nqgxoJFckbhA
 cqkU1Bj+AvIGUzGyhshhs2bV059t9JeIb/5bp2LiY/T8A5k68y2yR00QoLhUi8leCU0R
 JoP2zqMOwmtvVTn21mgIZ9r+MLWoiicgutiB+lje0qTFSDw1dD+hgtTVRJFe78+z8y0Y
 lqGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4ivKxsw+oKktbg8BvcrEFW/Kp6V6QV3Ybzl3bgsdLWRLcsA/ZlZ0wxLk9EIADIaG22F07lFtktQiw@nongnu.org
X-Gm-Message-State: AOJu0YwXq6gXnXN5+NwsTVvynOKwUUOLz8lpNKl2kxwFQhjwrV50m8Tj
 MLmwlHq9SGS+Ok+gcmuvLmYbG8wZFiIzFPZH2/UWpMiJwIEHCtmm7/uLl/2bWLMnhl1W/ei7Vev
 KX+WrMCPKuyE4U5bh36P9WuNRlnaB4cmfgyPXmw5O/0MaBIw/ThlVp/Gvew==
X-Gm-Gg: AR+sD10QdFINvpFS8ck6wfuIQyAn+2A88CAozWZfA/jnOtZUjkjeOJhyXD7DVW3Z2xx
 iJgCxKCxydlpibiYjJ7YJhdRAoUwyJ5KkLTNDnteUuX6HYyfhcbAe/2ALXOlZTXGdhVH95LrOaC
 Vxiw0fUE7bqxGqOdeqK4vxgjW7uWYuVB1hbEdN2/OYavKIcq5R6QFTszsouhJJUyUebGqD5BkX1
 0Zr7TrsZ8Fs2DImgogOxrXFiY/YZhfZRl5uiwqfzTYy6xWSGZXTOjMqdyW+Hz8v71jGe/ZuRMtg
 A9WL8xNVZLbjATtoZouO2b4VtPSlIcXJBMhI/z4P1vj9ZBTvGyRILxqun7Piiaa0SLfEhDobQ7a
 H/XIfYQKTx08b2jfCb9BZ+FIroeOY3ShbmKDIV0sRGfR5PcBsqTE7QFmnte5NTrkVEdTw
X-Received: by 2002:a05:6a20:d74c:b0:3c3:b57b:645e with SMTP id
 adf61e73a8af0-3cd2fe23ae8mr1670665637.5.1787254372343; 
 Thu, 20 Aug 2026 12:32:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:d74c:b0:3c3:b57b:645e with SMTP id
 adf61e73a8af0-3cd2fe23ae8mr1670560637.5.1787254371830; 
 Thu, 20 Aug 2026 12:32:51 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327c946293dsm13232066eec.22.2026.08.20.12.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 12:32:51 -0700 (PDT)
Message-ID: <db21bc30-5925-4a27-a0ee-7e0f2786a045@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:32:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/hexagon: align exceptions for user/sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-2-brian.cain@oss.qualcomm.com>
 <51289d66-1d42-4f7d-a1e0-652150f45a78@oss.qualcomm.com>
 <6a6549ed-24b4-4e18-a3a8-0fe1239404d3@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6a6549ed-24b4-4e18-a3a8-0fe1239404d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a875665 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=PV1KrYjIgSgoWSFuOVsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0NyBTYWx0ZWRfXywF6/SZSR5X6
 RWvWk8ySFYghBZZNZ6cuOEAMqIIDB2KeQuPDszKjfzL6UL+QPQVCbBCc0Dfmm+he7iqyjDT2TMZ
 Xx7QOeSaUYArUN/wfdmL+IK1pxlp8NqkJ//hmCXi920JW+EYBEHEk6E78fhoUHEt1W/kkSrqq1N
 p2O0lPvijOZmFQz4+JSVZ+Xmttpwb/1ijS8jWV1YRrFQnhAwVaJ+z8FzWPiToPsn/z6JRQkxvsC
 O8mB+l+ryXhYuG18yAvY7DPWCuzSgEAQWm6voSeaBDuo+sXg1eH/Wkp8KMHvTkIOWs/7aUK/FdJ
 iFKWARygNeNfShfL9esgNxgIRYeIYqiH/5Zkk2PvBXOoshxzzKoSAxLSkptXQP6u9ebkxVYTlqc
 nj69P9yiIv2DI2zZwFeFIuPkO7vgmbyNrI/Bq4FOuA7tLLWPQ4BkwYDhAZd35aRuJrqbwgJYhRl
 85WN723dqBFWXJ3k/Rg==
X-Proofpoint-GUID: FumfM5VEZqBOhp8b6ZpTaSJwgi81h35A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0NyBTYWx0ZWRfX2w7PlU02qutQ
 TcV/FTbtdS16jOD85FJHI+8GEw0eSOTS6GOe+VD2KjE/+W5gFKUaBvnalgDstykaaGRjhKPek7u
 HCACl8aWByoUvJh5Kfak/DWPOHrpXDQ=
X-Proofpoint-ORIG-GUID: FumfM5VEZqBOhp8b6ZpTaSJwgi81h35A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200147
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

On 8/20/2026 12:02 PM, Brian Cain wrote:
> 
> On 8/20/2026 1:40 PM, Pierrick Bouvier wrote:
>> On 8/18/2026 6:31 PM, Brian Cain wrote:
>>> System mode reports an exception as cs->exception_index = HEX_EVENT_*
>>> plus
>>> env->cause_code = HEX_CAUSE_*, but translated code in user mode put
>>> the cause
>>> code straight into exception_index, so cpu_loop() was decoding both
>>> forms.
>>> gen_exception_decode_fail() and the misaligned-PC check used the raw
>>> form
>>> unconditionally, so in system mode the cause code was misread as an
>>> event
>>> number.
>>>
>>> Use the {event, cause} everywhere and drop the duplicated cases
>>> from cpu_loop(), which fixes HEX_CAUSE_PRIV_USER_NO_SINSN and
>>> HEX_CAUSE_PRIV_USER_NO_GINSN.  The misaligned PC is no longer zeroed
>>> on its way out either, so it reaches the signal frame as si_addr instead
>>> of whatever r31 held.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/translate.h    |  2 +-
>>>   linux-user/hexagon/cpu_loop.c | 30 +++++++++++-------------------
>>>   target/hexagon/cpu.c          |  3 ++-
>>>   target/hexagon/translate.c    | 27 +++++++++------------------
>>>   4 files changed, 23 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
>>> index 3c5773e2c73..00de2b0d2ec 100644
>>> --- a/target/hexagon/translate.h
>>> +++ b/target/hexagon/translate.h
>>> @@ -330,7 +330,7 @@ extern TCGv_i32 hex_t_sreg[NUM_SREGS];
>>>   #endif
>>>     -void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
>>> +void hex_gen_exception_end_tb(DisasContext *ctx, int cause);
>>>     void process_store(DisasContext *ctx, int slot_num);
>>>   diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/
>>> cpu_loop.c
>>> index d7f73439dbc..e4ef97a1184 100644
>>> --- a/linux-user/hexagon/cpu_loop.c
>>> +++ b/linux-user/hexagon/cpu_loop.c
>>> @@ -66,21 +66,22 @@ void cpu_loop(CPUHexagonState *env)
>>>               case HEX_CAUSE_FETCH_NO_UPAGE:
>>>               case HEX_CAUSE_PRIV_NO_UREAD:
>>>               case HEX_CAUSE_PRIV_NO_UWRITE:
>>> -            force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
>>> -                    env->gpr[HEX_REG_PC]);
>>> -
>>> -            break;
>>> +                force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
>>> +                                env->gpr[HEX_REG_PC]);
>>> +                break;
>>>               case HEX_CAUSE_PRIV_USER_NO_GINSN:
>>>               case HEX_CAUSE_PRIV_USER_NO_SINSN:
>>>               case HEX_CAUSE_INVALID_PACKET:
>>> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>>> -                    env->gpr[HEX_REG_PC]);
>>> -            break;
>>> +            case HEX_CAUSE_REG_WRITE_CONFLICT:
>>> +                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>>> +                                env->gpr[HEX_REG_PC]);
>>> +                break;
>>>               case HEX_CAUSE_MISALIGNED_LOAD:
>>>               case HEX_CAUSE_MISALIGNED_STORE:
>>> -            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>>> -                    env->gpr[HEX_REG_PC]);
>>> -            break;
>>> +            case HEX_CAUSE_PC_NOT_ALIGNED:
>>> +                force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>>> +                                env->gpr[HEX_REG_PC]);
>>> +                break;
>>>               default:
>>>                   EXCP_DUMP(env, "\nqemu: unhandled CPU precise
>>> exception "
>>>                       "cause code 0x%x - aborting\n",
>>> @@ -88,15 +89,6 @@ void cpu_loop(CPUHexagonState *env)
>>>                   exit(EXIT_FAILURE);
>>>               }
>>>               break;
>>> -        case HEX_CAUSE_PC_NOT_ALIGNED:
>>> -            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>>> -                            env->gpr[HEX_REG_R31]);
>>> -            break;
>>> -        case HEX_CAUSE_INVALID_PACKET:
>>> -        case HEX_CAUSE_REG_WRITE_CONFLICT:
>>> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>>> -                            env->gpr[HEX_REG_PC]);
>>> -            break;
>>>           case EXCP_ATOMIC:
>>>               cpu_exec_step_atomic(cs);
>>>               break;
>>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>>> index 7067e5b70f7..0bbefc2fb87 100644
>>> --- a/target/hexagon/cpu.c
>>> +++ b/target/hexagon/cpu.c
>>> @@ -323,7 +323,8 @@ static TCGTBCPUState
>>> hexagon_get_tb_cpu_state(CPUState *cs)
>>>           hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>>>       }
>>>       if (pc & PCALIGN_MASK) {
>>> -        hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
>>> +        env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
>>> +        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc);
>>>       }
>>>     #ifndef CONFIG_USER_ONLY
>>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
>>> index 06a8159d283..5cfa60ca302 100644
>>> --- a/target/hexagon/translate.c
>>> +++ b/target/hexagon/translate.c
>>> @@ -73,8 +73,8 @@ TCGv hex_vstore_pending[VSTORES_MAX];
>>>   #ifndef CONFIG_USER_ONLY
>>>   TCGv_i32 hex_greg[NUM_GREGS];
>>>   TCGv_i32 hex_t_sreg[NUM_SREGS];
>>> -TCGv_i32 hex_cause_code;
>>>   #endif
>>> +static TCGv_i32 hex_cause_code;
>>>
>> Shouldn't this be part of CPUState?
>> What if multiple cpus trigger an exception at the same time?
> 
> The cause_code is part of CPUState.  This TCGv is a reference to that
> state member for use with translation. We take advantage of the single-
> threaded nature of translation with all of these file-global TCGv values.
> 
> 
>>
>>>   static const char * const hexagon_prednames[] = {
>>>     "p0", "p1", "p2", "p3"
>>> @@ -128,19 +128,14 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx,
>>> int regnum,
>>>       return offset;
>>>   }
>>>   -static void gen_exception(int excp, uint32_t PC)
>>> +static void gen_precise_exception(int cause, uint32_t PC)
>>>   {
>>> -    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp),
>>> +    tcg_gen_movi_i32(hex_cause_code, cause);
>>> +    gen_helper_raise_exception(tcg_env,
>>> tcg_constant_i32(HEX_EVENT_PRECISE),
>>>                                  tcg_constant_i32(PC));
>>>   }
>>>     #ifndef CONFIG_USER_ONLY
>>> -static inline void gen_precise_exception(int excp, uint32_t PC)
>>> -{
>>> -    tcg_gen_movi_i32(hex_cause_code, excp);
>>> -    gen_exception(HEX_EVENT_PRECISE, PC);
>>> -}
>>> -
>>>   static void gen_pcycle_counters(DisasContext *ctx)
>>>   {
>>>       if (ctx->pcycle_enabled) {
>>> @@ -224,14 +219,10 @@ static void gen_end_tb(DisasContext *ctx)
>>>       ctx->base.is_jmp = DISAS_NORETURN;
>>>   }
>>>   -void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
>>> +void hex_gen_exception_end_tb(DisasContext *ctx, int cause)
>>>   {
>>>       gen_exec_counters(ctx);
>>> -#ifdef CONFIG_USER_ONLY
>>> -    gen_exception(excp, ctx->pkt.pc);
>>> -#else
>>> -    gen_precise_exception(excp, ctx->pkt.pc);
>>> -#endif
>>> +    gen_precise_exception(cause, ctx->pkt.pc);
>>>       ctx->base.is_jmp = DISAS_NORETURN;
>>>   }
>>>   @@ -239,13 +230,13 @@ void hex_gen_exception_end_tb(DisasContext
>>> *ctx, int excp)
>>>    * Generate exception for decode failures. Unlike
>>> gen_exception_end_tb,
>>>    * this is used when decode fails before ctx->next_PC is initialized.
>>>    */
>>> -static void gen_exception_decode_fail(DisasContext *ctx, int nwords,
>>> int excp)
>>> +static void gen_exception_decode_fail(DisasContext *ctx, int nwords,
>>> int cause)
>>>   {
>>>       target_ulong fail_pc = ctx->base.pc_next + nwords *
>>> sizeof(uint32_t);
>>>         gen_exec_counters(ctx);
>>>       tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], fail_pc);
>>> -    gen_exception(excp, fail_pc);
>>> +    gen_precise_exception(cause, fail_pc);
>>>       ctx->base.is_jmp = DISAS_NORETURN;
>>>       ctx->base.pc_next = fail_pc;
>>>   }
>>> @@ -1361,9 +1352,9 @@ void hexagon_translate_init(void)
>>>           offsetof(CPUHexagonState, llsc_val), "llsc_val");
>>>       hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
>>>           offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>>> -#ifndef CONFIG_USER_ONLY
>>>       hex_cause_code = tcg_global_mem_new_i32(tcg_env,
>>>           offsetof(CPUHexagonState, cause_code), "cause_code");
>>> +#ifndef CONFIG_USER_ONLY
>>>       hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
>>>           offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
>>>   #endif

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


