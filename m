Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72780CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYMN-0007bX-NA; Tue, 29 Sep 2026 09:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBYML-0007b8-Ci
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:59:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBYMI-0006ty-NN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:59:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCvsZx3300548
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 13:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3Y5Ii+80fULqTZyuKAyPwpAl
 OtT+TqBCaW9BytV+lgg=; b=QbgFCSC32RyvFbrs9MQz9Ssf9KmA6cU4Gx13DqOu
 LgKdInu0PzRDqbRvwLtAA7N7lbcm9awsUAQbTD//Am/MQJJXZfActktQ+ArGk/j9
 vq6ukiXTriLu5Wsnt/4aOXEXtSlp6MNxfHK8051XrYetsc+Vd11k9ZL+wdSS6j+o
 wooOk68ezrmRhhhuj4AZuurKxsDijrW4ukpmEbf13xMUpBLbJfBIuzool4DmczMV
 cBLd5oc4FZSdnHXTI4ie3Sfo9MfnDIMv2aasrGIHSxm6XoI3j0jbQjJoFiy+/ECa
 CJO6PucdOppf/78acklTRtLFD6QOy5YTYnREz4kJD+hvoQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx09ud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 13:58:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso805930585a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790690336; x=1791295136; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3Y5Ii+80fULqTZyuKAyPwpAlOtT+TqBCaW9BytV+lgg=;
 b=e03d0FE7neK9ABnL9t2awDRNaxt9yWDtf1rpfo6IgFJd7Ew/hr0d9Hbsl5jFvGW2WF
 0Yn3Cw2Wui/6P6Rblu0Cp0Go+tuWnOERLMOvBMTF7zbORSuOcDlWK8B0HbeMnD2FNtxb
 kF+F4J/v/QuAlIwnJlAsHxRioDU7lzqvFkiRoc2AIjGNBqgSi/lgN9bEBxr+OYrU3Sg5
 mM3qPOO1y8quz9nOwbAxKUVN4vLmB+TfmedRXpt/YRFvob3qkbG1OVbIFiehj5nyg8Bx
 ut/8+kJELFmwMF8nsFCJemulQ+QojWQBFY6i56fHpso/aMfkHfUcYGUu4pah+Thv7Wd6
 RQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690336; x=1791295136;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Y5Ii+80fULqTZyuKAyPwpAlOtT+TqBCaW9BytV+lgg=;
 b=UgOFoj9unZH4c6Tw2HAr0SiAjTO62WJGoOa2p6py633WFk1oMwxvKqOceVoOqszQvh
 +p8J7qvRfCa8KVMcOls3uPwTwW5j9b16anuvqdxgPMVAPpGSI51c/tgpsVdUYhpGm65z
 VeHdmuEKUqPgyjDYyMCyHxzUkOIxJnEwWNWNQjQCPUoQjFU1wP2c2QKTQn//UHn6paz1
 1D+HszRsSoTP8dLn0aFQpWT954S5CvEdRw31gWXzoecSN0EWCl1VnHMG+2fpXixXxkzQ
 lC0vFRRUrRrl0dUrVtBKbolU1RnWt8FioAuHgBbaQyocg4R5zehfiR10HpdairL/+qA4
 eoiA==
X-Gm-Message-State: AFuF++kTtoKl2Lq9V7V9dz4oYk9kmvdvxR/viAnVql/KIadG00xksISz
 fErtCRdXGlMJPn8hBgLzF+WbGYBTDhcs5vzles5NlZSPAE2FJOyBWN+hzU5v/DA2MB0HRqeh/1A
 n5ubsqrARvuYIVK7qudpeN9JMElxhnG+Wv2HjiF5CWQBej/00Q6i6cLKTIA==
X-Gm-Gg: AYBFou1so+bAar7BR13uGG8ynWuHek1OOApB+x2cHHUKeuUguwSGkE07s83EI54OsDF
 5ybgL7UoNpyj4+gqQcSha/P80Q7udhcm0RwgmYpCQGY4P32chlptlB7Dk88eDS3+KXKd4eDD6ra
 cDU3J85tLXV3nutu70olpf9LLsWUmaKhDgDR23L4qwRTxg9RxeeD/0EsrzSlJ/pU57ycX5F5OhW
 EkSpFFnYr6AKUprp/YttJZ3JgT990SUMHhtbwCZhtHlK+uVfXjorh7RW6zIQ//FWJZVpYoCB5Dw
 kW0lQamfuaWdD6yN5GgL9/PBHW0Q3fLwWVxtzcsqMDseFn6unPLrAhhswtWrI2vaZ+u2tOHa+Nk
 fr+5XmK7j7N/alu8hiq+qvoDzvvbZopbLbDM/IegzVGaxEc38cp9auGgJ3hR12Hr1
X-Received: by 2002:a05:620a:6485:b0:93c:6976:e3a2 with SMTP id
 af79cd13be357-93c6976e5acmr1601314185a.26.1790690336299; 
 Tue, 29 Sep 2026 06:58:56 -0700 (PDT)
X-Received: by 2002:a05:620a:6485:b0:93c:6976:e3a2 with SMTP id
 af79cd13be357-93c6976e5acmr1601306585a.26.1790690335593; 
 Tue, 29 Sep 2026 06:58:55 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2bf3c6ba9dsm495517166b.13.2026.09.29.06.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 06:58:54 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------4qsCPBlIjokv8Lvb9R1kQJzb"
Message-ID: <6dd8756a-bf35-41da-8a4a-147c70174064@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 08:58:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/hexagon: pass the packet PC to the
 k0lock/tlblock helpers
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260915154502.4106597-1-brian.cain@oss.qualcomm.com>
 <20260915154502.4106597-2-brian.cain@oss.qualcomm.com>
 <CAATN3NqXpi1bdZXHT2=imVdOPE=7d5cbr45MtAeci=iRgWoYLg@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAATN3NqXpi1bdZXHT2=imVdOPE=7d5cbr45MtAeci=iRgWoYLg@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NSBTYWx0ZWRfX7ZSPScb9jBAT
 YHMh41H3PfRSqdACm47I8fkWiCQ2/5ZY4fU1OURgMWdPzIIaMfF1llYxgC09e0D25iFKy/lwmA3
 yhUOFqTAUx8srTWGLcn9Tc8kUknl191qOy3TEA9G9kN/TsPkuBYiFDUbxHLxzgbBEG+eiWO9Qn6
 wHl+JVjXLOmx4XUo3a2RKgK5FOFMYIM+3DGcSysKMCtg3nWQWMXxaS9pGiNA4GMSS6rFFlJJ+mI
 e530mU9Ftiruz20COey3S/7LTpnBE1x5Ei/sgaDw+CyufUBiL4mmcUOuHV7yB8GXcO20BF8YSJj
 Zlq31xpxc1k1B/eJV6lA3KBzN62BxSHG+xiS7fEq6Gv5VXD7QyzP4Vr03vll6mDOmq3vQwR+NJC
 vmtL9l1kVwWtRdm6yyOHW5ZlnvZurtz8AZrU+rWSvWSeB+29DY4G3y8tamP9pcdvNTvI+4vuc1P
 sZPfXHhnAz7pS4grUiQ==
X-Proofpoint-ORIG-GUID: i_8WxrYv6WoSSubaF7tOZhNxuopm8uAf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NSBTYWx0ZWRfX9mxpzfYHXPFl
 +NvBou/Q0M1b7oa1D3GRyp40UIiG1MmRLGVQkRB8E4/Mho3CyQ0g8gLzEG8UO0zKvM0Y8tOeweO
 Vy1kZq3sVpZDLeacKMDQ7hkpu9wynps=
X-Proofpoint-GUID: i_8WxrYv6WoSSubaF7tOZhNxuopm8uAf
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abbc421 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=Szx_A0s4Xi7u7ULoDEYA:9 a=o0aUlFK8qyHEWF3p:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8 a=liaze_oV84OatLUvXOYA:9
 a=fyLPuZnDFeSJqnw5:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290055
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------4qsCPBlIjokv8Lvb9R1kQJzb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/15/2026 6:42 PM, Taylor Simpson wrote:
>
>
> On Tue, Sep 15, 2026 at 9:45 AM Brian Cain 
> <brian.cain@oss.qualcomm.com> wrote:
>
>     Hand the k0lock/tlblock helpers the packet PC as a constant instead
>     of relying on next_PC's opcode-dependent staging.
>
>
> The word "helpers" isn't entirely accurate.  The QEMU helpers already 
> take PC as an argument.
> This patch adds the PC argument to the implementation functions 
> hex_tlb_lock/hex_k0_lock called from the respective helpers.
> See my comment below on hex_common.py.

Thanks for the feedback.  I'll work on a follow up series to address the 
issues you raised in this one.


>
>     Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>     ---
>      target/hexagon/hex_mmu.h     |  9 +++++----
>      target/hexagon/sys_macros.h  |  4 ++--
>      target/hexagon/hex_mmu.c     | 15 ++++++++-------
>      target/hexagon/op_helper.c   | 15 ++++++++-------
>      target/hexagon/hex_common.py |  6 +++++-
>      5 files changed, 28 insertions(+), 21 deletions(-)
>
>     diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
>     index 56b2c4a89d0..4eaf15c4996 100644
>     --- a/target/hexagon/hex_mmu.h
>     +++ b/target/hexagon/hex_mmu.h
>     @@ -17,12 +17,13 @@ extern uint32_t hex_tlb_lookup(CPUHexagonState
>     *env, uint32_t ssr, uint32_t VA);
>      extern void hex_mmu_on(CPUHexagonState *env);
>      extern void hex_mmu_off(CPUHexagonState *env);
>      extern void hex_mmu_mode_change(CPUHexagonState *env);
>     -extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
>     -                               MMUAccessType access_type, hwaddr
>     *PA, int *prot,
>     -                               uint64_t *size, int32_t *excp, int
>     mmu_idx);
>     +extern bool hex_tlb_find_match(CPUHexagonState *env, target_ulong VA,
>     +                               MMUAccessType access_type,
>     +                               hwaddr *PA, int *prot, uint64_t *size,
>     +                               int32_t *excp, int mmu_idx);
>
>
> Why is this change included in this patch?
>
>      extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t
>     entry,
>                                       uint64_t index);
>     -extern void hex_tlb_lock(CPUHexagonState *env);
>     +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);
>      extern void hex_tlb_unlock(CPUHexagonState *env);
>      void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
>      #endif
>     diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
>     index a5b9b7f2592..72179d49ab3 100644
>     --- a/target/hexagon/sys_macros.h
>     +++ b/target/hexagon/sys_macros.h
>     @@ -145,10 +145,10 @@
>      #define fDCINVIDX(REG)
>      #define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing to do
>     in qemu */
>
>     -#define fSET_TLB_LOCK()       hex_tlb_lock(env);
>     +#define fSET_TLB_LOCK()       hex_tlb_lock(env, PC);
>      #define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
>
>     -#define fSET_K0_LOCK()        hex_k0_lock(env);
>     +#define fSET_K0_LOCK()        hex_k0_lock(env, PC);
>      #define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
>
>      #define fTLB_IDXMASK(INDEX) \
>     diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
>     index d6ee7c40798..d7acaae5ac8 100644
>     --- a/target/hexagon/hex_mmu.c
>     +++ b/target/hexagon/hex_mmu.c
>     @@ -156,7 +156,7 @@ static inline void print_thread_states(const
>     char *str)
>          }
>      }
>
>     -void hex_tlb_lock(CPUHexagonState *env)
>     +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)
>      {
>          qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: " TARGET_FMT_ld "\n",
>                        env->threadId);
>     @@ -170,7 +170,6 @@ void hex_tlb_lock(CPUHexagonState *env)
>          uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
>          if (tlb_lock) {
>              if (env->tlb_lock_state == HEX_LOCK_QUEUED) {
>     -            env->next_PC += 4;
>                  env->tlb_lock_count++;
>                  env->tlb_lock_state = HEX_LOCK_OWNER;
>                  SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
>     @@ -178,19 +177,21 @@ void hex_tlb_lock(CPUHexagonState *env)
>              }
>              if (env->tlb_lock_state == HEX_LOCK_OWNER) {
>                  qemu_log_mask(CPU_LOG_MMU | LOG_GUEST_ERROR,
>     -                          "Double tlblock at PC: 0x%" PRIx32
>     -                          ", thread may hang\n",
>     -                          env->next_PC);
>     -            env->next_PC += 4;
>     +                          "Double tlblock at PC: 0x%x, thread may
>     hang\n", PC);
>
>
> Don't use %x, use TARGET_FMT_lx.
>
>                  CPUState *cs = env_cpu(env);
>                  cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>                  return;
>              }
>              env->tlb_lock_state = HEX_LOCK_WAITING;
>     +        /*
>     +         * next_PC has already been advanced past this packet. 
>     Rewind it
>     +         * so that the thread re-executes the tlblock when it is
>     woken by
>     +         * the thread that releases the lock.
>     +         */
>     +        env->next_PC = PC;
>              CPUState *cs = env_cpu(env);
>              cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>          } else {
>     -        env->next_PC += 4;
>              env->tlb_lock_count++;
>              env->tlb_lock_state = HEX_LOCK_OWNER;
>              SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
>     diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>     index 0d08ac77361..07ba639449c 100644
>     --- a/target/hexagon/op_helper.c
>     +++ b/target/hexagon/op_helper.c
>     @@ -1278,7 +1278,7 @@ void HELPER(modify_ssr)(CPUHexagonState
>     *env, uint32_t new, uint32_t old)
>          hexagon_modify_ssr(env, new, old);
>      }
>
>     -static void hex_k0_lock(CPUHexagonState *env)
>     +static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)
>      {
>          HexagonCPU *cpu = env_archcpu(env);
>          CPUState *cs = env_cpu(env);
>     @@ -1292,7 +1292,6 @@ static void hex_k0_lock(CPUHexagonState *env)
>                                     env->threadId) : 0;
>          if (GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg)) {
>              if (env->k0_lock_state == HEX_LOCK_QUEUED) {
>     -            env->next_PC += 4;
>                  env->k0_lock_count++;
>                  env->k0_lock_state = HEX_LOCK_OWNER;
>                  SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
>     @@ -1300,19 +1299,21 @@ static void hex_k0_lock(CPUHexagonState *env)
>              }
>              if (env->k0_lock_state == HEX_LOCK_OWNER) {
>                  qemu_log_mask(LOG_GUEST_ERROR,
>     -                          "Double k0lock at PC: 0x%" PRIx32
>     -                          ", thread may hang\n",
>     -                          env->next_PC);
>     -            env->next_PC += 4;
>     +                          "Double k0lock at PC: 0x%x, thread may
>     hang\n", PC);
>
>
> Don't use %x, use TARGET_FMT_lx.
>
>                  cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>                  cpu_loop_exit(cs);
>                  return;
>              }
>              env->k0_lock_state = HEX_LOCK_WAITING;
>     +        /*
>     +         * next_PC has already been advanced past this packet. 
>     Rewind it
>     +         * so that the thread re-executes the k0lock when it is
>     woken by
>     +         * the thread that releases the lock.
>     +         */
>     +        env->next_PC = PC;
>              cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>              cpu_loop_exit(cs);
>          } else {
>     -        env->next_PC += 4;
>              env->k0_lock_count++;
>              env->k0_lock_state = HEX_LOCK_OWNER;
>              SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
>     diff --git a/target/hexagon/hex_common.py
>     b/target/hexagon/hex_common.py
>     index c180c19b092..1bd31f76a4f 100755
>     --- a/target/hexagon/hex_common.py
>     +++ b/target/hexagon/hex_common.py
>     @@ -284,7 +284,11 @@ def need_ea(tag):
>
>
>      def need_PC(tag):
>     -    return "A_IMPLICIT_READS_PC" in attribdict[tag]
>     +    return (
>     +        "A_IMPLICIT_READS_PC" in attribdict[tag]
>     +        or tag == "Y2_k0lock"
>     +        or tag == "Y2_tlblock"
>     +    )
>
>
> This isn't needed.  These 2 opcodes already have A_IMPLICIT_READS_PC set.
> Look for fSET_K0_LOCK and fSET_TLB_LOCK in calculate_attribs in 
> hex_common.py.
>
> Thanks,
> Taylor
>
--------------4qsCPBlIjokv8Lvb9R1kQJzb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/15/2026 6:42 PM, Taylor Simpson
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAATN3NqXpi1bdZXHT2=imVdOPE=7d5cbr45MtAeci=iRgWoYLg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Tue, Sep 15, 2026 at
            9:45 AM Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hand
            the k0lock/tlblock helpers the packet PC as a constant
            instead<br>
            of relying on next_PC's opcode-dependent staging.<br>
          </blockquote>
          <div><br>
          </div>
          <div>The word "helpers" isn't entirely accurate.  The QEMU
            helpers already take PC as an argument.</div>
          <div>This patch adds the PC argument to the implementation
            functions hex_tlb_lock/hex_k0_lock called from the
            respective helpers.</div>
          <div>See my comment below on hex_common.py.</div>
          <div> </div>
        </div>
      </div>
    </blockquote>
    <p>Thanks for the feedback.  I'll work on a follow up series to
      address the issues you raised in this one.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAATN3NqXpi1bdZXHT2=imVdOPE=7d5cbr45MtAeci=iRgWoYLg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <br>
            Signed-off-by: Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;<br>
            ---<br>
             target/hexagon/hex_mmu.h     |  9 +++++----<br>
             target/hexagon/sys_macros.h  |  4 ++--<br>
             target/hexagon/hex_mmu.c     | 15 ++++++++-------<br>
             target/hexagon/op_helper.c   | 15 ++++++++-------<br>
             target/hexagon/hex_common.py |  6 +++++-<br>
             5 files changed, 28 insertions(+), 21 deletions(-)<br>
            <br>
            diff --git a/target/hexagon/hex_mmu.h
            b/target/hexagon/hex_mmu.h<br>
            index 56b2c4a89d0..4eaf15c4996 100644<br>
            --- a/target/hexagon/hex_mmu.h<br>
            +++ b/target/hexagon/hex_mmu.h<br>
            @@ -17,12 +17,13 @@ extern uint32_t
            hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t
            VA);<br>
             extern void hex_mmu_on(CPUHexagonState *env);<br>
             extern void hex_mmu_off(CPUHexagonState *env);<br>
             extern void hex_mmu_mode_change(CPUHexagonState *env);<br>
            -extern bool hex_tlb_find_match(CPUHexagonState *env,
            uint32_t VA,<br>
            -                               MMUAccessType access_type,
            hwaddr *PA, int *prot,<br>
            -                               uint64_t *size, int32_t
            *excp, int mmu_idx);<br>
            +extern bool hex_tlb_find_match(CPUHexagonState *env,
            target_ulong VA,<br>
            +                               MMUAccessType access_type,<br>
            +                               hwaddr *PA, int *prot,
            uint64_t *size,<br>
            +                               int32_t *excp, int mmu_idx);<br>
          </blockquote>
          <div><br>
          </div>
          <div>Why is this change included in this patch?</div>
          <div> </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
             extern int hex_tlb_check_overlap(CPUHexagonState *env,
            uint64_t entry,<br>
                                              uint64_t index);<br>
            -extern void hex_tlb_lock(CPUHexagonState *env);<br>
            +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong
            PC);<br>
             extern void hex_tlb_unlock(CPUHexagonState *env);<br>
             void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);<br>
             #endif<br>
            diff --git a/target/hexagon/sys_macros.h
            b/target/hexagon/sys_macros.h<br>
            index a5b9b7f2592..72179d49ab3 100644<br>
            --- a/target/hexagon/sys_macros.h<br>
            +++ b/target/hexagon/sys_macros.h<br>
            @@ -145,10 +145,10 @@<br>
             #define fDCINVIDX(REG)<br>
             #define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing
            to do in qemu */<br>
            <br>
            -#define fSET_TLB_LOCK()       hex_tlb_lock(env);<br>
            +#define fSET_TLB_LOCK()       hex_tlb_lock(env, PC);<br>
             #define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);<br>
            <br>
            -#define fSET_K0_LOCK()        hex_k0_lock(env);<br>
            +#define fSET_K0_LOCK()        hex_k0_lock(env, PC);<br>
             #define fCLEAR_K0_LOCK()      hex_k0_unlock(env);<br>
            <br>
             #define fTLB_IDXMASK(INDEX) \<br>
            diff --git a/target/hexagon/hex_mmu.c
            b/target/hexagon/hex_mmu.c<br>
            index d6ee7c40798..d7acaae5ac8 100644<br>
            --- a/target/hexagon/hex_mmu.c<br>
            +++ b/target/hexagon/hex_mmu.c<br>
            @@ -156,7 +156,7 @@ static inline void
            print_thread_states(const char *str)<br>
                 }<br>
             }<br>
            <br>
            -void hex_tlb_lock(CPUHexagonState *env)<br>
            +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)<br>
             {<br>
                 qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: "
            TARGET_FMT_ld "\n",<br>
                               env-&gt;threadId);<br>
            @@ -170,7 +170,6 @@ void hex_tlb_lock(CPUHexagonState *env)<br>
                 uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK,
            syscfg);<br>
                 if (tlb_lock) {<br>
                     if (env-&gt;tlb_lock_state == HEX_LOCK_QUEUED) {<br>
            -            env-&gt;next_PC += 4;<br>
                         env-&gt;tlb_lock_count++;<br>
                         env-&gt;tlb_lock_state = HEX_LOCK_OWNER;<br>
                         SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);<br>
            @@ -178,19 +177,21 @@ void hex_tlb_lock(CPUHexagonState
            *env)<br>
                     }<br>
                     if (env-&gt;tlb_lock_state == HEX_LOCK_OWNER) {<br>
                         qemu_log_mask(CPU_LOG_MMU | LOG_GUEST_ERROR,<br>
            -                          "Double tlblock at PC: 0x%"
            PRIx32<br>
            -                          ", thread may hang\n",<br>
            -                          env-&gt;next_PC);<br>
            -            env-&gt;next_PC += 4;<br>
            +                          "Double tlblock at PC: 0x%x,
            thread may hang\n", PC);<br>
          </blockquote>
          <div><br>
          </div>
          <div>Don't use %x, use TARGET_FMT_lx.</div>
          <div> </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                         CPUState *cs = env_cpu(env);<br>
                         cpu_interrupt(cs, CPU_INTERRUPT_HALT);<br>
                         return;<br>
                     }<br>
                     env-&gt;tlb_lock_state = HEX_LOCK_WAITING;<br>
            +        /*<br>
            +         * next_PC has already been advanced past this
            packet.  Rewind it<br>
            +         * so that the thread re-executes the tlblock when
            it is woken by<br>
            +         * the thread that releases the lock.<br>
            +         */<br>
            +        env-&gt;next_PC = PC;<br>
                     CPUState *cs = env_cpu(env);<br>
                     cpu_interrupt(cs, CPU_INTERRUPT_HALT);<br>
                 } else {<br>
            -        env-&gt;next_PC += 4;<br>
                     env-&gt;tlb_lock_count++;<br>
                     env-&gt;tlb_lock_state = HEX_LOCK_OWNER;<br>
                     SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);<br>
            diff --git a/target/hexagon/op_helper.c
            b/target/hexagon/op_helper.c<br>
            index 0d08ac77361..07ba639449c 100644<br>
            --- a/target/hexagon/op_helper.c<br>
            +++ b/target/hexagon/op_helper.c<br>
            @@ -1278,7 +1278,7 @@ void
            HELPER(modify_ssr)(CPUHexagonState *env, uint32_t new,
            uint32_t old)<br>
                 hexagon_modify_ssr(env, new, old);<br>
             }<br>
            <br>
            -static void hex_k0_lock(CPUHexagonState *env)<br>
            +static void hex_k0_lock(CPUHexagonState *env, target_ulong
            PC)<br>
             {<br>
                 HexagonCPU *cpu = env_archcpu(env);<br>
                 CPUState *cs = env_cpu(env);<br>
            @@ -1292,7 +1292,6 @@ static void
            hex_k0_lock(CPUHexagonState *env)<br>
                                            env-&gt;threadId) : 0;<br>
                 if (GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg)) {<br>
                     if (env-&gt;k0_lock_state == HEX_LOCK_QUEUED) {<br>
            -            env-&gt;next_PC += 4;<br>
                         env-&gt;k0_lock_count++;<br>
                         env-&gt;k0_lock_state = HEX_LOCK_OWNER;<br>
                         SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);<br>
            @@ -1300,19 +1299,21 @@ static void
            hex_k0_lock(CPUHexagonState *env)<br>
                     }<br>
                     if (env-&gt;k0_lock_state == HEX_LOCK_OWNER) {<br>
                         qemu_log_mask(LOG_GUEST_ERROR,<br>
            -                          "Double k0lock at PC: 0x%" PRIx32<br>
            -                          ", thread may hang\n",<br>
            -                          env-&gt;next_PC);<br>
            -            env-&gt;next_PC += 4;<br>
            +                          "Double k0lock at PC: 0x%x,
            thread may hang\n", PC);<br>
          </blockquote>
          <div><br>
          </div>
          <div>Don't use %x, use TARGET_FMT_lx.</div>
          <div> </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                         cpu_interrupt(cs, CPU_INTERRUPT_HALT);<br>
                         cpu_loop_exit(cs);<br>
                         return;<br>
                     }<br>
                     env-&gt;k0_lock_state = HEX_LOCK_WAITING;<br>
            +        /*<br>
            +         * next_PC has already been advanced past this
            packet.  Rewind it<br>
            +         * so that the thread re-executes the k0lock when
            it is woken by<br>
            +         * the thread that releases the lock.<br>
            +         */<br>
            +        env-&gt;next_PC = PC;<br>
                     cpu_interrupt(cs, CPU_INTERRUPT_HALT);<br>
                     cpu_loop_exit(cs);<br>
                 } else {<br>
            -        env-&gt;next_PC += 4;<br>
                     env-&gt;k0_lock_count++;<br>
                     env-&gt;k0_lock_state = HEX_LOCK_OWNER;<br>
                     SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);<br>
            diff --git a/target/hexagon/hex_common.py
            b/target/hexagon/hex_common.py<br>
            index c180c19b092..1bd31f76a4f 100755<br>
            --- a/target/hexagon/hex_common.py<br>
            +++ b/target/hexagon/hex_common.py<br>
            @@ -284,7 +284,11 @@ def need_ea(tag):<br>
            <br>
            <br>
             def need_PC(tag):<br>
            -    return "A_IMPLICIT_READS_PC" in attribdict[tag]<br>
            +    return (<br>
            +        "A_IMPLICIT_READS_PC" in attribdict[tag]<br>
            +        or tag == "Y2_k0lock"<br>
            +        or tag == "Y2_tlblock"<br>
            +    )<br>
          </blockquote>
          <div><br>
          </div>
          <div>This isn't needed.  These 2 opcodes already have
            A_IMPLICIT_READS_PC set.</div>
          <div>Look for fSET_K0_LOCK and fSET_TLB_LOCK in
            calculate_attribs in hex_common.py.</div>
          <div> </div>
          <div><br>
          </div>
          <div>Thanks,</div>
          <div>Taylor</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------4qsCPBlIjokv8Lvb9R1kQJzb--

