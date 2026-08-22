Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A29C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 15:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxnvt-0008EM-TE; Sat, 22 Aug 2026 11:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxnvr-00086P-W4
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 11:46:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxnvp-0000v0-PM
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 11:46:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67MEMrWL271779
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 15:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hdkrukVplczf+qUrbB1CAYIbbpNtVXNCObpY8c2q260=; b=hlRh5uVqfvNMeyS8
 DhJTUM2P4QymgJdTiH4zVBma73D5k0iq/rA0fBGJAcFySihBwbOj6Bu35uSxiYyb
 5Mzt13SUAUFSBO3RCCaF7n1FQnx4pXt8X8nsddfcWEm4D5uj022DEMX/mVmNRt+m
 4sRqF7dp9nBWQxz0b6oqRpXAwcoKV7dnAtOsZgofHhvxhSWJEf9VBBBf/OiNLYw8
 f406/+A3nWINN+NltmsEYHYY15epO3NI387bjC7ssrZBII2BTyHhmkid/ifWaOw0
 dE4ad5jUKU5fuJLaakpWLFrFtsiCaccGaju8U6gUt6xbJOtNFAv4fhr5cmxxwdkS
 L5nkPw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g744qsh1r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 15:46:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494cce712so230197885a.3
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787413609; x=1788018409; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hdkrukVplczf+qUrbB1CAYIbbpNtVXNCObpY8c2q260=;
 b=QLVqa7VZQtv9+Creb8ZbnITOrX5gRZCozTJQk6ji80R2qXrKRPYOw5gGI1bqLDcSBu
 al74N8ZQmF9+2iMCaiUSDXnODMOCInbH+WbXBEscSRAR/ZNZoH6SrZghYcExzlrf4ENt
 mjfKaN25cP7iAU5dn/zv59kxe0rbPO91qrIeQ/zmxgnNtyN/GoUHm91xZqasjMUF6MN1
 INQB9cRm2hB47C15nTFNFxsb6iA2jck6HYidtfDs5Vf/BdvEIO4vc0MuarwLEHchCd7T
 CrmfnxutP3GfEZCHZ5IiBGIt8VjFiiMC7hItwKAbsylbgwEX9dikuJ7p5pkgyoCMtAXN
 Fysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787413609; x=1788018409;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hdkrukVplczf+qUrbB1CAYIbbpNtVXNCObpY8c2q260=;
 b=cCnk84O3trki44cwKSlkZ66GbsD8QoiGFEIwYaijHaeNqHJ9tyU0gphTKO6Ozy0B6T
 aN8pLUitfsfe6IK6AWUOtP97ImJlce4PpRfi+eXESbZfGZeE0aq5pvLbj1COUn/3C5iK
 jbUMnEfsDTiAPf6f+Q64XauAHrCGERsofS0A3NPflPESmsC5r0HLP+XJg1wVEWUfRzeg
 ygsy8Z9WDUJjBPlf5le3BrXPhOlsOGVjcyEq3xgv0siw8p8KyCRG1B9b8sdm5830hAHO
 tHaEVW5MFSAZknxDsUSRkC4OqoxLMLqdY9P/Qryu/WbX72s0jASD7tGTMyWpCNggNqt5
 ssKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL1iWUmV/Ei/FIu61DbK4kDCFpd7DW2HnuYOeZiahbLRy4cMdYHglSHClwVf4QuXmRHwzRSFtN+smL@nongnu.org
X-Gm-Message-State: AFuF++mac08ISBdT7khCyHneOwF3C2SvlV4PnfzREAIzHHwzfJg+ziuc
 1QYcRT/4P96333TvNZNjuobxhYq8/Wbfpm4lfZXQZpA08oEDxU7bQym2pEFGnrdbuC/5IxjQKio
 Sx4Hu61ERfUAEtoPyNFFrwHlZz/nUMt43kgBpLUkq8RXKEaD2csB2x3mqtg==
X-Gm-Gg: AR+sD10jYpqZeQC7rH0etZGpBGiLMDNXKS0QBcqQdiWz1sqgBrGwMeRHwWwxMInquU+
 yy6LuRslbAOxhM8qQsEfJZfZEmNCADVyUjo5oh6Aurjrfe8qgoeZgXPxfoTm4AYkj3aYu0hGe4F
 ySmp+j8jaA18X1c41ptxBqifjjTb2UUxB28NrCDAuHVKEg5FclsKTTbrEWIqAEIwDNwoeHhZ7gm
 Mh2mLSD2ID3umISvJIg3vM1UpC2wsUlTNd90HFaaWONVfdDRrc9A9gudNCOc6Ym7RUGOtYWKL3Z
 tResakpK9q3vGUR5iG2sWsvMS90xjAsGswArPbvpVkVO6foQDfxT9cgmNl+nfsooi/TjwcUR+wX
 7shbXeXCTZGkXBuVi5Hzzb1pq4/oz
X-Received: by 2002:a05:620a:2616:b0:92e:6c15:24cd with SMTP id
 af79cd13be357-9373946f89emr1363930285a.15.1787413608874; 
 Sat, 22 Aug 2026 08:46:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2616:b0:92e:6c15:24cd with SMTP id
 af79cd13be357-9373946f89emr1363923985a.15.1787413608314; 
 Sat, 22 Aug 2026 08:46:48 -0700 (PDT)
Received: from [100.68.222.250] ([12.252.7.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93749d95aecsm141731685a.29.2026.08.22.08.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2026 08:46:47 -0700 (PDT)
Message-ID: <b505808e-e703-4d8d-99ec-35713179e33a@oss.qualcomm.com>
Date: Sat, 22 Aug 2026 10:46:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/hexagon: align exceptions for user/sysemu
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-2-brian.cain@oss.qualcomm.com>
 <51289d66-1d42-4f7d-a1e0-652150f45a78@oss.qualcomm.com>
 <6a6549ed-24b4-4e18-a3a8-0fe1239404d3@oss.qualcomm.com>
 <dc805d66-fdf2-48be-a643-295ece2d2acf@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <dc805d66-fdf2-48be-a643-295ece2d2acf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DT0tGvHngWkXpdWaR6RAqAGyFuM6BV2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDEzMSBTYWx0ZWRfX6u+rSxP4gFbD
 NgwRYOoBT/lKDMyb+d80xS/MD06jPIbFK69waIMoOtPhP2vpQz3Qvt1U/gSR8X4xMiS/25oJALC
 k333e8x67B8sf+ejMSV2tycEWmKsUktHvnFiAO5JPuwuDhOvAkq30fbzaBFQq6owmf+iWnlS7OD
 Nx2qDEOe2G2SU+LGa+dA1Qn/c/tYU95AMK7a8SjuYh+AsBXnv1gN0zlBB+NmPti3MIzSYSmYpw7
 ox5KGm3XvnNrhft1Eq2hD+J3KKr1PnYM/FMKPyh+yxkGUkt0tjAl8AqZ5Ac3ky2DIJ0x3yQp+1h
 dU6+ZBrKm84ZgdGb25oaeXNYUT7G1wpmF2lea4dXXze8gM45fZ+BGeI3FD7KgF/9LB34BLVjckv
 9ckJPIF9kBgryBwVdNZLlefC9AJ1Nx5/Eh4McMTPtQkQgNYWDGsiK+xWsslkrJCbus032/A1FfF
 WW5goYlbd7Uldcqm85A==
X-Proofpoint-GUID: DT0tGvHngWkXpdWaR6RAqAGyFuM6BV2k
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDEzMSBTYWx0ZWRfXyMIt5ee8En2L
 nbeOEufReorc0AVRCeVC94RXdtpv2fJmOA9wn1m6AJg4ZjsugpLFVhqHK2Sm2u6yAylOONFrLLD
 j1vn2BygC8XeaakJkgpqzfdfQUboCLM=
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a89c469 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=kDiSab31uyKP0veRcQS/NA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=AKTlK5qtcUhdPyiWI7gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220131
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


On 8/21/2026 11:37 AM, Pierrick Bouvier wrote:
> On 8/20/2026 12:02 PM, Brian Cain wrote:
>> On 8/20/2026 1:40 PM, Pierrick Bouvier wrote:
>>> On 8/18/2026 6:31 PM, Brian Cain wrote:
>>>> System mode reports an exception as cs->exception_index = HEX_EVENT_*
>>>> plus
>>>> env->cause_code = HEX_CAUSE_*, but translated code in user mode put
>>>> the cause
>>>> code straight into exception_index, so cpu_loop() was decoding both
>>>> forms.
>>>> gen_exception_decode_fail() and the misaligned-PC check used the raw
>>>> form
>>>> unconditionally, so in system mode the cause code was misread as an
>>>> event
>>>> number.
>>>>
>>>> Use the {event, cause} everywhere and drop the duplicated cases
>>>> from cpu_loop(), which fixes HEX_CAUSE_PRIV_USER_NO_SINSN and
>>>> HEX_CAUSE_PRIV_USER_NO_GINSN.  The misaligned PC is no longer zeroed
>>>> on its way out either, so it reaches the signal frame as si_addr instead
>>>> of whatever r31 held.
>>>>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>    target/hexagon/translate.h    |  2 +-
>>>>    linux-user/hexagon/cpu_loop.c | 30 +++++++++++-------------------
>>>>    target/hexagon/cpu.c          |  3 ++-
>>>>    target/hexagon/translate.c    | 27 +++++++++------------------
>>>>    4 files changed, 23 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
>>>> index 3c5773e2c73..00de2b0d2ec 100644
>>>> --- a/target/hexagon/translate.h
>>>> +++ b/target/hexagon/translate.h
>>>> @@ -330,7 +330,7 @@ extern TCGv_i32 hex_t_sreg[NUM_SREGS];
>>>>    #endif
>>>>      -void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
>>>> +void hex_gen_exception_end_tb(DisasContext *ctx, int cause);
>>>>      void process_store(DisasContext *ctx, int slot_num);
>>>>    diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/
>>>> cpu_loop.c
>>>> index d7f73439dbc..e4ef97a1184 100644
>>>> --- a/linux-user/hexagon/cpu_loop.c
>>>> +++ b/linux-user/hexagon/cpu_loop.c
>>>> @@ -66,21 +66,22 @@ void cpu_loop(CPUHexagonState *env)
>>>>                case HEX_CAUSE_FETCH_NO_UPAGE:
>>>>                case HEX_CAUSE_PRIV_NO_UREAD:
>>>>                case HEX_CAUSE_PRIV_NO_UWRITE:
>>>> -            force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
>>>> -                    env->gpr[HEX_REG_PC]);
>>>> -
>>>> -            break;
>>>> +                force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
>>>> +                                env->gpr[HEX_REG_PC]);
>>>> +                break;
>>>>                case HEX_CAUSE_PRIV_USER_NO_GINSN:
>>>>                case HEX_CAUSE_PRIV_USER_NO_SINSN:
>>>>                case HEX_CAUSE_INVALID_PACKET:
>>>> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>>>> -                    env->gpr[HEX_REG_PC]);
>>>> -            break;
>>>> +            case HEX_CAUSE_REG_WRITE_CONFLICT:
>>>> +                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>>>> +                                env->gpr[HEX_REG_PC]);
>>>> +                break;
>>>>                case HEX_CAUSE_MISALIGNED_LOAD:
>>>>                case HEX_CAUSE_MISALIGNED_STORE:
>>>> -            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>>>> -                    env->gpr[HEX_REG_PC]);
>>>> -            break;
>>>> +            case HEX_CAUSE_PC_NOT_ALIGNED:
>>>> +                force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>>>> +                                env->gpr[HEX_REG_PC]);
>>>> +                break;
>>>>                default:
>>>>                    EXCP_DUMP(env, "\nqemu: unhandled CPU precise
>>>> exception "
>>>>                        "cause code 0x%x - aborting\n",
>>>> @@ -88,15 +89,6 @@ void cpu_loop(CPUHexagonState *env)
>>>>                    exit(EXIT_FAILURE);
>>>>                }
>>>>                break;
>>>> -        case HEX_CAUSE_PC_NOT_ALIGNED:
>>>> -            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
>>>> -                            env->gpr[HEX_REG_R31]);
>>>> -            break;
>>>> -        case HEX_CAUSE_INVALID_PACKET:
>>>> -        case HEX_CAUSE_REG_WRITE_CONFLICT:
>>>> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>>>> -                            env->gpr[HEX_REG_PC]);
>>>> -            break;
>>>>            case EXCP_ATOMIC:
>>>>                cpu_exec_step_atomic(cs);
>>>>                break;
>>>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>>>> index 7067e5b70f7..0bbefc2fb87 100644
>>>> --- a/target/hexagon/cpu.c
>>>> +++ b/target/hexagon/cpu.c
>>>> @@ -323,7 +323,8 @@ static TCGTBCPUState
>>>> hexagon_get_tb_cpu_state(CPUState *cs)
>>>>            hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>>>>        }
>>>>        if (pc & PCALIGN_MASK) {
>>>> -        hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
>>>> +        env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
>>>> +        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc);
>>>>        }
>>>>      #ifndef CONFIG_USER_ONLY
>>>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
>>>> index 06a8159d283..5cfa60ca302 100644
>>>> --- a/target/hexagon/translate.c
>>>> +++ b/target/hexagon/translate.c
>>>> @@ -73,8 +73,8 @@ TCGv hex_vstore_pending[VSTORES_MAX];
>>>>    #ifndef CONFIG_USER_ONLY
>>>>    TCGv_i32 hex_greg[NUM_GREGS];
>>>>    TCGv_i32 hex_t_sreg[NUM_SREGS];
>>>> -TCGv_i32 hex_cause_code;
>>>>    #endif
>>>> +static TCGv_i32 hex_cause_code;
>>>>
>>> Shouldn't this be part of CPUState?
>>> What if multiple cpus trigger an exception at the same time?
>> The cause_code is part of CPUState.  This TCGv is a reference to that
>> state member for use with translation. We take advantage of the single-
>> threaded nature of translation with all of these file-global TCGv values.
>>
> Thinking twice about it, please note that this is true only for
> qemu-user (when tb_gen_code runs with mmap_lock), or qemu-system without
> MTTCG, which is what we have at the moment.


I had intended to claim that it was the case that translation was 
single-threaded even in MTTCG.  But I see now that I was mistaken about 
that.

I arrived at this belief somewhat backwards, I guess - the file-scope 
TCGv's used by other architectures who do support MTTCG already, and our 
results using file-scope TCGv's on qemu-system-hexagon with MTTCG in a 
downstream fork.

But after digging a bit I think it's still safe/appropriate to have 
file-scope TCGv's concurrently accessed by multiple translation 
threads.  Because they are merely a reference to the state data and not 
the data itself.  The state data is modified by the TCG instructions 
generated by translation.  The TCGv - the reference itself - is probably 
immutable, meaning it couldn't be made to refer to anything else.  Or 
certainly shouldn't.


> However, using qemu-system with MTTCG, translation can happen
> concurrently, and those variables should be part of DisasContext instead.
>
> Regards,
> Pierrick

