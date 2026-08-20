Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A165C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx82F-0004lg-9z; Thu, 20 Aug 2026 15:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx82C-0004lX-Dp
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:02:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wx829-0004h3-Hr
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:02:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJZ5J3009939
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f2cy/yIUeOxPrGYiMjmsF5W2TFj62AxceP5sNlxncuc=; b=mvqOMPgMAlQRiG5r
 DkZ6W3kyG4ZuHzn/eiV7XSlE7usyLzqq6NUaAGR92W3j5ehf2NMtOEKSlSkBvCqf
 sdjs6htrTPTKRcnu7Gn7QDiy2M+KDMyORFf1q6HlZU6VF/dL0R663udEyXOujjja
 ruF4lL1HQybVGW/1K3A0h+ncxO/gPBDOKNEZ1wl6XmhKHKiP2RlDm5HLf0KtrTuC
 MBh7VRrYytlT+RfBgXg6OlCmRfjFa6H1RN0ogIuv4Y20rwxYIBkVgLSwAHpFO5TY
 LW7polpUexOzHwMMZ0F3zizbuBsOKu5LdshD/x7wFDiL+cBxj1SQSy8Ltnbf7wXC
 8DG/IA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x05ttsb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:02:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52cd0374265so2623911cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787252553; x=1787857353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f2cy/yIUeOxPrGYiMjmsF5W2TFj62AxceP5sNlxncuc=;
 b=FxnAplD0GsMcD4qGkdSMlQdB6x/gIbGiemzsadSHUQkKo1dX3yNrUGJQ9QgDHAlITM
 5LVaMx0VRLR3eZ6IPf88XH4sOObKEKDVZlTjTVKcPJSujzAUoTjNrkNXoc+YLc3yOBbT
 1/h52pq+doFqsnzx3CU3fxwFPvzaE9Cd66JXWwOSq9k6ltF3do+xaKtimRclBGnOwoLX
 HkST7zQG5BddIXXSC8NPIT6HDpS/n7FQpYC213JTKsGOhND2/WWkvKoyQelnr6b6WxJC
 ONehf6zGybJSqx+dNf9LwW8Z7X6jLIoASd5MLO4zRtFhhM0XqWlBJ1QAQb2eGArFgnQh
 qKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252553; x=1787857353;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f2cy/yIUeOxPrGYiMjmsF5W2TFj62AxceP5sNlxncuc=;
 b=FKjLxqhbJVQ11kv6DymxVVazySWr/BksIpkcwxLWA4HumoTOwiILQYq34QVjI0ikMM
 ADN9D8ekVc6HHMyA6ZWiFOkeagh7Iqjgekb8PR5+FCV020vVRpBU4EgkktILJgYAkxnE
 wnmh1nXmof+MMx7KvwvjDS/fbqdT0IBgJmDZ47o6+EsfPsu6PgZa/gyJfHAHGwL4qSaN
 GyIIw87MyvT46zciw1vu7bunfE01N3SfPaFUaj7TG8gPzb3fjFD9Gl3Bh8TOose6Q9Ms
 QF7aUqlZTBVqg8SGzMq7cCHEPS+MSctRKnPnN2fQU2iQA627B2TIla8Kwsdm+uON5E5O
 jRtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNSlC0o4vWGjzhiWgp43w2CYcq+NoFlUpyLZchcSIa/H/7U/WKM2RDSESz2cEhkJasItc/CiBl1Mr4@nongnu.org
X-Gm-Message-State: AOJu0Yxr1pPnGPFbGvBR4Sh5Sx156Pjm1fhD8kYEzY3iHMMP+boemIt1
 PgPNVeEaiSg9UzaHIjo7XJxTsaAZLIBPx1+l4aFByzQtUxrwfgEhRGxFmx9E8XqNBQMYv9cBNQN
 5U4AaXjffDqGS8mSTl8OljCfSiqwhlEvfzO8TxcaRtk3jsFcWvmgj1zF17Q==
X-Gm-Gg: AR+sD11d1TVf9D6lU1DGFUc1ZOeoKC7AHPa3aQpGEi2K5+D1STWPP2x/ci9A8zGqD97
 xV3YoWDBaRj1Cw/OihbeU2VgcHZZoiUBB65qMEgrOzn1AVe8DuU99O2huNc1IawiNF4yz/zve6F
 zJgfznOXt4m4mweqoGygZSYGQuOjG2eyh0fudr7vTs+apXNe7AlKhTlgnETrEQrJj0dzOQ2ePb5
 amtDpN9ZxHkCIAaRgNr+IhzPaZuCXjhqLQ7V7qYiOLQ+OHp/iimxMK3Qa/vTtWwsc/dmUsz4zqn
 XDzHgJk+i38DUtStcYcLf8xHB5aMn+rcO3hJl4UGhd/Pzl8SIi7JNQf1WRcqOXpSJCtfAnkclfX
 ggpZdGv5lC6CIE+JNNS2cB85qKoU2X2kdC6fPkKmetnXMQB8gOb9/H0RBT0KSjnRh
X-Received: by 2002:a05:622a:98c:b0:519:b5ef:7fdd with SMTP id
 d75a77b69052e-52df565e78emr6925211cf.6.1787252553047; 
 Thu, 20 Aug 2026 12:02:33 -0700 (PDT)
X-Received: by 2002:a05:622a:98c:b0:519:b5ef:7fdd with SMTP id
 d75a77b69052e-52df565e78emr6920181cf.6.1787252551002; 
 Thu, 20 Aug 2026 12:02:31 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52dd857b8b5sm36709791cf.6.2026.08.20.12.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 12:02:29 -0700 (PDT)
Message-ID: <6a6549ed-24b4-4e18-a3a8-0fe1239404d3@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 14:02:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/hexagon: align exceptions for user/sysemu
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-2-brian.cain@oss.qualcomm.com>
 <51289d66-1d42-4f7d-a1e0-652150f45a78@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <51289d66-1d42-4f7d-a1e0-652150f45a78@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5OMvFn0bLGSeU52FcksrYnlEurWc4-XR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfX3GsBuD7w0REH
 WFegKPYSxXsDEu+kb+UNknRg9B4TO/jq3X3tkvNxuvII/FxeAK8k3T7+sCt5SqFqoZaWOqCjwzj
 VtsratXBavaSm6Jz6uEFe494SWYOaNf8UAuwmHe+xfIv/MZqpNXu+ev4HTJ5MvxnieDifS+mp5O
 6DLFkwpSnVPG7F5dSQGpvgnV1tUklWuNtDpRCMhjpV5xFM6vkGMi0LjKyLCaYAiwZsskGXM0DIY
 qp6Gok6ECQCdQ9OXHkmzp7bcp5z+jD0vNS2teES6J6dTIs1HtOA6smlyheYQYl/JIH2qjKBSDqH
 t9DlW4FZrAKwwL93w8s8SidOKg1S/nTxaT7/EK7FluJ9JJKCsQI9KqiaCOJXW8JOggYbBkU4gpw
 RRLL3PIHKTF0ayy9gQvmxa+/X5qHsiFm4qMM+U+7hpKqgC4HExoSxisvOhfljCQpiepEymVHGFm
 mZXC0XI7l3c9ZfuyDXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfX2sYqrG0z4HYA
 blRt1kcFNHJZdbCR5LrlRqKnm2PWIFbU96UfMTruIXwfim/Kw7jF+mYB9UjRF8URCCDdgY5hzlk
 802lHsvN7J/M59xxH/c93qlimWCLr+Y=
X-Authority-Analysis: v=2.4 cv=VfPH+lp9 c=1 sm=1 tr=0 ts=6a874f49 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1DsuZKhHXManSbp0az4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 5OMvFn0bLGSeU52FcksrYnlEurWc4-XR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 8/20/2026 1:40 PM, Pierrick Bouvier wrote:
> On 8/18/2026 6:31 PM, Brian Cain wrote:
>> System mode reports an exception as cs->exception_index = HEX_EVENT_* plus
>> env->cause_code = HEX_CAUSE_*, but translated code in user mode put the cause
>> code straight into exception_index, so cpu_loop() was decoding both forms.
>> gen_exception_decode_fail() and the misaligned-PC check used the raw form
>> unconditionally, so in system mode the cause code was misread as an event
>> number.
>>
>> Use the {event, cause} everywhere and drop the duplicated cases
>> from cpu_loop(), which fixes HEX_CAUSE_PRIV_USER_NO_SINSN and
>> HEX_CAUSE_PRIV_USER_NO_GINSN.  The misaligned PC is no longer zeroed
>> on its way out either, so it reaches the signal frame as si_addr instead
>> of whatever r31 held.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/translate.h    |  2 +-
>>   linux-user/hexagon/cpu_loop.c | 30 +++++++++++-------------------
>>   target/hexagon/cpu.c          |  3 ++-
>>   target/hexagon/translate.c    | 27 +++++++++------------------
>>   4 files changed, 23 insertions(+), 39 deletions(-)
>>
>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
>> index 3c5773e2c73..00de2b0d2ec 100644
>> --- a/target/hexagon/translate.h
>> +++ b/target/hexagon/translate.h
>> @@ -330,7 +330,7 @@ extern TCGv_i32 hex_t_sreg[NUM_SREGS];
>>   #endif
>>   
>>   
>> -void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
>> +void hex_gen_exception_end_tb(DisasContext *ctx, int cause);
>>   
>>   void process_store(DisasContext *ctx, int slot_num);
>>   
>> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
>> index d7f73439dbc..e4ef97a1184 100644
>> --- a/linux-user/hexagon/cpu_loop.c
>> +++ b/linux-user/hexagon/cpu_loop.c
>> @@ -66,21 +66,22 @@ void cpu_loop(CPUHexagonState *env)
>>               case HEX_CAUSE_FETCH_NO_UPAGE:
>>               case HEX_CAUSE_PRIV_NO_UREAD:
>>               case HEX_CAUSE_PRIV_NO_UWRITE:
>> -            force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
>> -                    env->gpr[HEX_REG_PC]);
>> -
>> -            break;
>> +                force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
>> +                                env->gpr[HEX_REG_PC]);
>> +                break;
>>               case HEX_CAUSE_PRIV_USER_NO_GINSN:
>>               case HEX_CAUSE_PRIV_USER_NO_SINSN:
>>               case HEX_CAUSE_INVALID_PACKET:
>> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>> -                    env->gpr[HEX_REG_PC]);
>> -            break;
>> +            case HEX_CAUSE_REG_WRITE_CONFLICT:
>> +                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>> +                                env->gpr[HEX_REG_PC]);
>> +                break;
>>               case HEX_CAUSE_MISALIGNED_LOAD:
>>               case HEX_CAUSE_MISALIGNED_STORE:
>> -            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>> -                    env->gpr[HEX_REG_PC]);
>> -            break;
>> +            case HEX_CAUSE_PC_NOT_ALIGNED:
>> +                force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>> +                                env->gpr[HEX_REG_PC]);
>> +                break;
>>               default:
>>                   EXCP_DUMP(env, "\nqemu: unhandled CPU precise exception "
>>                       "cause code 0x%x - aborting\n",
>> @@ -88,15 +89,6 @@ void cpu_loop(CPUHexagonState *env)
>>                   exit(EXIT_FAILURE);
>>               }
>>               break;
>> -        case HEX_CAUSE_PC_NOT_ALIGNED:
>> -            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>> -                            env->gpr[HEX_REG_R31]);
>> -            break;
>> -        case HEX_CAUSE_INVALID_PACKET:
>> -        case HEX_CAUSE_REG_WRITE_CONFLICT:
>> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>> -                            env->gpr[HEX_REG_PC]);
>> -            break;
>>           case EXCP_ATOMIC:
>>               cpu_exec_step_atomic(cs);
>>               break;
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 7067e5b70f7..0bbefc2fb87 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -323,7 +323,8 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
>>           hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>>       }
>>       if (pc & PCALIGN_MASK) {
>> -        hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
>> +        env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
>> +        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc);
>>       }
>>   
>>   #ifndef CONFIG_USER_ONLY
>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
>> index 06a8159d283..5cfa60ca302 100644
>> --- a/target/hexagon/translate.c
>> +++ b/target/hexagon/translate.c
>> @@ -73,8 +73,8 @@ TCGv hex_vstore_pending[VSTORES_MAX];
>>   #ifndef CONFIG_USER_ONLY
>>   TCGv_i32 hex_greg[NUM_GREGS];
>>   TCGv_i32 hex_t_sreg[NUM_SREGS];
>> -TCGv_i32 hex_cause_code;
>>   #endif
>> +static TCGv_i32 hex_cause_code;
>>
> Shouldn't this be part of CPUState?
> What if multiple cpus trigger an exception at the same time?

The cause_code is part of CPUState.  This TCGv is a reference to that 
state member for use with translation. We take advantage of the 
single-threaded nature of translation with all of these file-global TCGv 
values.


>
>>   static const char * const hexagon_prednames[] = {
>>     "p0", "p1", "p2", "p3"
>> @@ -128,19 +128,14 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
>>       return offset;
>>   }
>>   
>> -static void gen_exception(int excp, uint32_t PC)
>> +static void gen_precise_exception(int cause, uint32_t PC)
>>   {
>> -    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp),
>> +    tcg_gen_movi_i32(hex_cause_code, cause);
>> +    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
>>                                  tcg_constant_i32(PC));
>>   }
>>   
>>   #ifndef CONFIG_USER_ONLY
>> -static inline void gen_precise_exception(int excp, uint32_t PC)
>> -{
>> -    tcg_gen_movi_i32(hex_cause_code, excp);
>> -    gen_exception(HEX_EVENT_PRECISE, PC);
>> -}
>> -
>>   static void gen_pcycle_counters(DisasContext *ctx)
>>   {
>>       if (ctx->pcycle_enabled) {
>> @@ -224,14 +219,10 @@ static void gen_end_tb(DisasContext *ctx)
>>       ctx->base.is_jmp = DISAS_NORETURN;
>>   }
>>   
>> -void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
>> +void hex_gen_exception_end_tb(DisasContext *ctx, int cause)
>>   {
>>       gen_exec_counters(ctx);
>> -#ifdef CONFIG_USER_ONLY
>> -    gen_exception(excp, ctx->pkt.pc);
>> -#else
>> -    gen_precise_exception(excp, ctx->pkt.pc);
>> -#endif
>> +    gen_precise_exception(cause, ctx->pkt.pc);
>>       ctx->base.is_jmp = DISAS_NORETURN;
>>   }
>>   
>> @@ -239,13 +230,13 @@ void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
>>    * Generate exception for decode failures. Unlike gen_exception_end_tb,
>>    * this is used when decode fails before ctx->next_PC is initialized.
>>    */
>> -static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int excp)
>> +static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int cause)
>>   {
>>       target_ulong fail_pc = ctx->base.pc_next + nwords * sizeof(uint32_t);
>>   
>>       gen_exec_counters(ctx);
>>       tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], fail_pc);
>> -    gen_exception(excp, fail_pc);
>> +    gen_precise_exception(cause, fail_pc);
>>       ctx->base.is_jmp = DISAS_NORETURN;
>>       ctx->base.pc_next = fail_pc;
>>   }
>> @@ -1361,9 +1352,9 @@ void hexagon_translate_init(void)
>>           offsetof(CPUHexagonState, llsc_val), "llsc_val");
>>       hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
>>           offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>> -#ifndef CONFIG_USER_ONLY
>>       hex_cause_code = tcg_global_mem_new_i32(tcg_env,
>>           offsetof(CPUHexagonState, cause_code), "cause_code");
>> +#ifndef CONFIG_USER_ONLY
>>       hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
>>           offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
>>   #endif

