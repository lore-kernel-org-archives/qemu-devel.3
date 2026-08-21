Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD778C5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxSFj-0005YH-CL; Fri, 21 Aug 2026 12:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxSFh-0005Y9-G2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:37:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxSFf-0007jh-Ap
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:37:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LFmLSR2323013
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q0JDowejZZ3R0HAOOc86ODYbAWCWKVODMyRAdIRSwws=; b=CzYCV1gXgc/+t1bx
 HrDrQiDCAs2dxrDqdgAveEkxyDrNlCJrJJKsq8OqgIJEBV9Xu7wzftZK8BE0Ry4F
 aKDRD9LFPjuNRDA4h/wMh5GOz7xlnRBEI30KLyvwXTxFlXlVrM4c1MO46TQ6nDgT
 0o3HgXba+zeVU8vY3WOle2RMqKSSNOXVN5nf0gDwVAc1pio0gFtXWN7VwU4DKnOf
 sN8B1RqGeJ8JtbJi5osHgutrd1wfNtEE12UG9jNsHrrW012rL3tIXUAMyIaF8NKi
 cAxmzD93zNSkWEvx0xZDUK+PVB7R9aRsNGUcfZvbkrH4ddMYzgH5SP7c9RD739N5
 Gr81ow==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fbwapq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:37:53 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e3d575d6eso1936307b3a.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787330272; x=1787935072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q0JDowejZZ3R0HAOOc86ODYbAWCWKVODMyRAdIRSwws=;
 b=a993nYdHOIvslxIu/Fg87l8D1RnTIVA7TKLQm47dUEXPArPFaTgpZiVlHGNzQYQOzr
 foEI+0KBqdPfFQTwWKzINlvFSrLyv1bOFTaJPv5EGSJPkdfdYAyANhjO81vyNS6WYzuR
 urof6dvS1junYI4Xp/m89suKVHFxHDobVycV7Pad2GMp5DGIzrhd+mUiTy7jknfRrf4F
 VEaSDlFwvAvIOUKK35mfMu3d/9DIDjLgNUueJvKL2ElQJCPO4ZKFi/unOWhcStP6QGst
 rYz9eNZ07a1BvRhRBqQ5clEaUpsLb7djY9ZgUKoxvP84TtH/2oNKtHBTDsraU2xJMmub
 7Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787330272; x=1787935072;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q0JDowejZZ3R0HAOOc86ODYbAWCWKVODMyRAdIRSwws=;
 b=qwmwQLF0XfX5By3K4WeCRmE144Lf3CWXCo46ECjPtqflYFW2u13SZzFFur+DTBc0FV
 9T4HjxUfoLqDEwCphhfZW5PeabY3XmM28rmkfozcxLE6W2Sh8uoHAFoyAxLeZpCTxvpu
 h4NE7Y+0eYpnqrtu+rHVednz/ZwGmQxuWjz1/ugerIGXxqSwjCAVYD+KplreVAjggexz
 jTe1TXemXR1+iDc5sbnJ2xCXPnB5sCjNMzSVpa7u8rUC8fMo6OxKIRbJw5OVdpsW+EBF
 c0CGeNV3zIXpfKHs3SijLBminzKZq073t/pyglOZKECPYf79RKiqB4T5ImvNL5Ec9Nyv
 gwcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBJCFjE9SiKoQRymeV4xNnl2h4EqZOeTJ1uQKgKjjTnMYnaHWI9i2tKXsB/x3tAl2S/j6w5MGcp6Jm@nongnu.org
X-Gm-Message-State: AFuF++ldnLKnHa3Xc2KXcYqrDNGcSocwLerdTnWWJM06t1LEnxOJCYYo
 VdvFFed7IgdmqCl32n/2aXGBPOAJX2c/ij0o/UN6BwqaXn+cmaqNOlT+3OElG/IFL8e8tJfE0U/
 S56kpWjDP59RF9bIiblFu+E5D8W5w3s3J/XZ6xB42TGUsXaeUC8dyoT2dHg==
X-Gm-Gg: AR+sD13yKdrw7TXCyy+rBUy/WWF2xZPg3UKryxejapKu5Rh3VnnbZhMhL6h0+g4gkkk
 39SXbVGM3yDbur6AlWIqeD820ijzEFCPrD4iVFNO+Aam7CVmGu/rzPVfo9A4qbHhPZcJyeXvlQS
 lIJqqzzClNgQ+boZ6jC8aAPhDfCYfFL3SmNRuGsUNe/3IhplLx+JJRYwMW7J9en05WnvyGws3qi
 Ft7X1Na6l9tFrrZ9jcQjEVyxKcLhyQiRjjxrDLkx3rZOKA5kZFXShlpx3nMvY5g9Zh5H8EagPdl
 JetFmOtOnIsxnGqkWUg+uViBz8KAwTD+iUb678xkcy2qCMl4fl811RBASyHtuS5+7mId0bs6897
 LdXI8A2srstIcBTGs+6vXo/iWKXupuoikAIdXImHSmtST0UwMIelm3UjBnSIjSOpS+75k
X-Received: by 2002:a05:6a00:988:b0:848:6f5c:a327 with SMTP id
 d2e1a72fcca58-851fa04cd54mr10466600b3a.15.1787330272399; 
 Fri, 21 Aug 2026 09:37:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:988:b0:848:6f5c:a327 with SMTP id
 d2e1a72fcca58-851fa04cd54mr10466546b3a.15.1787330271950; 
 Fri, 21 Aug 2026 09:37:51 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3389a37sm3163113b3a.15.2026.08.21.09.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 09:37:51 -0700 (PDT)
Message-ID: <dc805d66-fdf2-48be-a643-295ece2d2acf@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 09:37:52 -0700
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzMCBTYWx0ZWRfXw9I7Jx98W9jH
 zVcB4VF4V446xMhDl//xeOXs2uGwRBuE3MhkkgH7kK8ryOsHwyTE7gye0ld2Hr6JwLFxVP1uZsl
 v8lpwcZIHcXc9bBd3TwnoIx+76kUsRc=
X-Proofpoint-ORIG-GUID: EnhLehF572xa0CZ2wfgdTMMMBNQta9Qs
X-Authority-Analysis: v=2.4 cv=L9AtheT8 c=1 sm=1 tr=0 ts=6a887ee1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=YqW66GmFy2uuvQRNjT0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzMCBTYWx0ZWRfX44bmR3ez11hm
 HX+MRpJEzaDGUXL+PXHVFySmxQo7nTLOikgVmWuGwgRgIzwC0IRGAJJbMwI+4ShZglufvMCYftw
 sE8bkNyK09LPd5ru5mi8qHKvtykMHjbWZscPoTM6Ypy5L0cx/qraLsmRgayEYpauwDOknkjLcED
 DzqO9CsX5hHugd7pULjf4PCXQXDJj26aRhAbhtwH+jmyHjFnuYkG7JKhUHWoaorWKH0LzrxOI4D
 lC4lLMKwzk7/mS1aFV8eKJqy+6QvuqBReXmE4ioN/5SX6QdwpF8h4/BUVjKvrAfRu/oLqv69ElY
 rhqF3ECk5gtkFCmghWP0Oe52D4i9l/kmjwC8XXD1x5/4SKbbGjIuxD86fDm4+SSfugxYufrhKFo
 Ts9TIHtom42gh5OBtla/Nzd9BnKtQsIMMnEdwzXeHFZ7/55fYf5a4HltkqLMSkxFeNcOtb0HcWf
 rchDWN7T2jnuhtFrhHQ==
X-Proofpoint-GUID: EnhLehF572xa0CZ2wfgdTMMMBNQta9Qs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Thinking twice about it, please note that this is true only for
qemu-user (when tb_gen_code runs with mmap_lock), or qemu-system without
MTTCG, which is what we have at the moment.

However, using qemu-system with MTTCG, translation can happen
concurrently, and those variables should be part of DisasContext instead.

Regards,
Pierrick

