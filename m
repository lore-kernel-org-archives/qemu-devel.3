Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8363AC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp8aW-0002zk-GM; Mon, 03 Mar 2025 11:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tp8aU-0002yz-RM
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:24:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tp8aS-0006J4-Hc
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:24:14 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523ALRFH032039
 for <qemu-devel@nongnu.org>; Mon, 3 Mar 2025 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Te33mmApNpZ6cPLKn537QD7zd23EFPbrsbm31GuGRAM=; b=E4U3Bf2iQWfxbcL8
 Y8NTeBKtZKIUV7y5BYJ+FJGLAII45AO7S79EyAxAcUCeXMMYkhJh52InXeMrqbDm
 OHa62ti+xW93prWUJ0fNDLIePaetrG5QO4K2cFnzJvd0kO6nsApDpgWoYORH6Z/e
 OtCqRqv2Fj8QYjGHgwVF45Am+UtsQ88808w9pQlXhQjVtObDkYm4xRLsrzaLW3NY
 6VOWXd/PFfHHx9AWi/MfEkpffZYg+FAXXrdP4lJXDufac3zLJRE2F67saAd5lIU5
 yMrbc1htQ0zJ3aACgG7OL510uZdofn1vAlK3egocMIDpsPptnJe4S4IDGpwGqwxy
 27MW+w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95wg29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 16:24:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-474f079562dso25252791cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 08:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741019048; x=1741623848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Te33mmApNpZ6cPLKn537QD7zd23EFPbrsbm31GuGRAM=;
 b=P6a1hBRE35pVBWh1axKZBRG1C8q5zO/PzvNHQZ9H0bD8GGqt7rRQthE0+Z0P7Pn26m
 zoOHrIOdmSKAHzn3+/Ar+2xBONXBUE6g8oUqRje+2Oitd+/6t0ZXBGOnYomCXEXlaPdX
 Lc4/Z3DXn7rR79sQ5oBQ2euekFHkqXoL6I7A2UT+iQFbJe6PQlyhyvuAY3IxwPvepU1s
 QRpurSuABHHLZOzb5W4gWFZQ/GBDcvAvc4T3dDcUBLdhTqRV100lQXWaZST5Bj+3EE0U
 Z1O23BxuFpLVhWxnQx1S5Sf71o5/rbL+mQZz4umpBGJm729I5egto/y1DHW9fqND9CSJ
 6xFw==
X-Gm-Message-State: AOJu0YxIOqxHQ7lf97/65zvbXsrICGRWT4VdpeoBD7z0HjbpYlglBGld
 wWLtoBAJvFLv2HnQQjrIVC19+/dR1MX9hYR7C2Mf0QFLpYg1g4ooPNVpHf1vHxOWVLUx1dw4mJa
 nghtpljSUc0XNDt4qpFfqr5i72RHpdeBUmoPq2Y0kDEhRGkBGaaVHSy8qlEsL8Q==
X-Gm-Gg: ASbGncueH8t+sJ1s996VVhbm738zMue+X7NkOvKG+vLCMl6Q8Esktqo9wiFLJyj74HW
 /s0L5ftjvqMa6EIT5g7lnX6zA73XoBnYKJH93lpIwZfiWf5MlC6mdsxAbgUfHB3zViVTjiclLJR
 XJeHHpiQ4wsdjozuvnKKT64OMXCan5EZPtGTWSr1pvbXUelanhH8OFdj02WFPM6NuNs+ZfepS+n
 6OFBeQZDRfr9oRqxEInqZcl7w6ikakbWCDaTIuNeyqxY4xmt9BPF5xW3dAcz23dgN81f377MidY
 y/XPD8KG5TH/X5l70OyyesSJi+cMfi5Q1T/NUunJSf6Ay2elLwdiUxQbED6U3ZmCWJncHOXxMJk
 gAmwmYgJ9PiuDCwtf
X-Received: by 2002:a05:622a:24f:b0:474:fb6a:d0c with SMTP id
 d75a77b69052e-474fb6a1082mr144171cf.48.1741019047629; 
 Mon, 03 Mar 2025 08:24:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqAKRXVofXHqqzM9SRVPZJHDV6SjkwIdVAO8M8icY50hiBMAC9aHvSMXfth+3KhIg1vht7AA==
X-Received: by 2002:a05:622a:24f:b0:474:fb6a:d0c with SMTP id
 d75a77b69052e-474fb6a1082mr143721cf.48.1741019047143; 
 Mon, 03 Mar 2025 08:24:07 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-474dff66dbasm18080791cf.53.2025.03.03.08.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 08:24:06 -0800 (PST)
Message-ID: <3329ec67-3bf3-425d-b15c-ba77cd8bcd30@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 10:24:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CkURP8PRkjSGZJCwddN2Bxbuh79nfW3R
X-Proofpoint-GUID: CkURP8PRkjSGZJCwddN2Bxbuh79nfW3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=805 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030125
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2/28/2025 11:28 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/sys_macros.h |   8 +--
>   target/hexagon/op_helper.c  | 104 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 108 insertions(+), 4 deletions(-)
>
> diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
> index 3c4c3c7aa5..e5dc1ce0ab 100644
> --- a/target/hexagon/sys_macros.h
> +++ b/target/hexagon/sys_macros.h
> @@ -143,11 +143,11 @@
>   #define fDCINVIDX(REG)
>   #define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing to do in qemu */
>   
> -#define fSET_TLB_LOCK()       g_assert_not_reached()
> -#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
> +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
> +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
>   
> -#define fSET_K0_LOCK()        g_assert_not_reached()
> -#define fCLEAR_K0_LOCK()      g_assert_not_reached()
> +#define fSET_K0_LOCK()        hex_k0_lock(env);
> +#define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
>   
>   #define fTLB_IDXMASK(INDEX) \
>       ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)->num_tlbs)) - 1))
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 702c3dd3c6..f3b14fbf58 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1184,6 +1184,110 @@ void HELPER(modify_ssr)(CPUHexagonState *env, uint32_t new, uint32_t old)
>       BQL_LOCK_GUARD();
>       hexagon_modify_ssr(env, new, old);
>   }
> +
> +static void hex_k0_lock(CPUHexagonState *env)
> +{
> +    BQL_LOCK_GUARD();
> +    g_assert((env->k0_lock_count == 0) || (env->k0_lock_count == 1));
> +
> +    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
> +    if (GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg)) {
> +        if (env->k0_lock_state == HEX_LOCK_QUEUED) {
> +            env->next_PC += 4;
> +            env->k0_lock_count++;
> +            env->k0_lock_state = HEX_LOCK_OWNER;
> +            SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
> +            return;
> +        }
> +        if (env->k0_lock_state == HEX_LOCK_OWNER) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Double k0lock at PC: 0x%x, thread may hang\n",
> +                          env->next_PC);
> +            env->next_PC += 4;
> +            CPUState *cs = env_cpu(env);
> +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +            return;
> +        }
> +        env->k0_lock_state = HEX_LOCK_WAITING;
> +        CPUState *cs = env_cpu(env);
> +        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +    } else {
> +        env->next_PC += 4;
> +        env->k0_lock_count++;
> +        env->k0_lock_state = HEX_LOCK_OWNER;
> +        SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
> +    }
> +
> +}

This was discussed previously at 
https://lore.kernel.org/qemu-devel/CH3PR02MB102479550F96F09E0C9D50BA7B87B2@CH3PR02MB10247.namprd02.prod.outlook.com/

We have taken some but not all of the suggestions from then.  One of our 
concerns is regarding an architectural requirement for "fairness" with 
regards to picking the hardware thread to be selected to pass the lock 
to.  If we unleash the thundering herd, does this just mean that the 
fairness is dependent on the host scheduler design / configuration?

Also - I note that we didn't take the suggestions regarding 
cpu_loop_exit / cpu_loop_exit_restore.  That was an oversight, the next 
revision will include that update.

> +
> +static void hex_k0_unlock(CPUHexagonState *env)
> +{
> +    BQL_LOCK_GUARD();
> +    g_assert((env->k0_lock_count == 0) || (env->k0_lock_count == 1));
> +
> +    /* Nothing to do if the k0 isn't locked by this thread */
> +    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
> +    if ((GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg) == 0) ||
> +        (env->k0_lock_state != HEX_LOCK_OWNER)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "thread %d attempted to unlock k0 without having the "
> +                      "lock, k0_lock state = %d, syscfg:k0 = %d\n",
> +                      env->threadId, env->k0_lock_state,
> +                      GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg));
> +        g_assert(env->k0_lock_state != HEX_LOCK_WAITING);
> +        return;
> +    }
> +
> +    env->k0_lock_count--;
> +    env->k0_lock_state = HEX_LOCK_UNLOCKED;
> +    SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 0);
> +
> +    /* Look for a thread to unlock */
> +    unsigned int this_threadId = env->threadId;
> +    CPUHexagonState *unlock_thread = NULL;
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        CPUHexagonState *thread = cpu_env(cs);
> +
> +        /*
> +         * The hardware implements round-robin fairness, so we look for threads
> +         * starting at env->threadId + 1 and incrementing modulo the number of
> +         * threads.
> +         *
> +         * To implement this, we check if thread is a earlier in the modulo
> +         * sequence than unlock_thread.
> +         *     if unlock thread is higher than this thread
> +         *         thread must be between this thread and unlock_thread
> +         *     else
> +         *         thread higher than this thread is ahead of unlock_thread
> +         *         thread must be lower then unlock thread
> +         */
> +        if (thread->k0_lock_state == HEX_LOCK_WAITING) {
> +            if (!unlock_thread) {
> +                unlock_thread = thread;
> +            } else if (unlock_thread->threadId > this_threadId) {
> +                if (this_threadId < thread->threadId &&
> +                    thread->threadId < unlock_thread->threadId) {
> +                    unlock_thread = thread;
> +                }
> +            } else {
> +                if (thread->threadId > this_threadId) {
> +                    unlock_thread = thread;
> +                }
> +                if (thread->threadId < unlock_thread->threadId) {
> +                    unlock_thread = thread;
> +                }
> +            }
> +        }
> +    }
> +    if (unlock_thread) {
> +        cs = env_cpu(unlock_thread);
> +        unlock_thread->k0_lock_state = HEX_LOCK_QUEUED;
> +        SET_SYSCFG_FIELD(unlock_thread, SYSCFG_K0LOCK, 1);
> +        cpu_interrupt(cs, CPU_INTERRUPT_K0_UNLOCK);
> +    }
> +
> +}
>   #endif
>   
>   

