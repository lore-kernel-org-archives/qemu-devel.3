Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D541AC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yu-0004Pg-Hy; Thu, 20 Aug 2026 12:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx5yi-0004IK-7Z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx5yg-0005VW-8b
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KG6wA9281905
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H64/1nUw/7lLCPh0dZyI8ywBjU05RRXPc4Wjk2rvsDE=; b=PPSwovRks9nHl+Oy
 +S+kf16dQZXayBATpnmwAyglXyeRPQ9cFSdH2E2DgmVKDL2S5kUqtePvmYJMcJea
 XVq66n0Gq59ZXp8EhLm6hO7mb5YTqpZuIdznGxe/bqGTZEEazi3Qe3cXqSR0NCeX
 xFZdjV5F/gLXXaGvkRkfUUSOwJY4LUV23kXn+XVGChQX5OiTq4QWctfoN0eoxadk
 DPSt0Nc5K9ggLbFP8WZYYCDFaG+u2Hsy0Y+0hCy3I97r1EEBiej9/h9wdRBPw73W
 kDuZ9yZU2vOfw+GztF5qkym36MQ2+xfWaoYewu50YJfiD1HIPwpKuMCkjJ5JerUK
 b8m6JA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgca39x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:50:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930b571432fso131780685a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787244651; x=1787849451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H64/1nUw/7lLCPh0dZyI8ywBjU05RRXPc4Wjk2rvsDE=;
 b=h9bSyTf487yLmqKLh+IlkzC9hVq0HjeuU00XnZVF9utmkr08ULog34YUlWdyY45gTc
 yiDz5QID7NJl6dHsNu85OXul8FIEi6a4k0P1MJUyNS5dydi1eTnSyRwiix1Ta7paNUV/
 4Br6Il20/7AaK+bHO5nNkk8sUxIaxFc57JBeqiMVPtU01iGnVGA19rVgCPzLoejdd0rS
 IWwBURkHEmL42mZ9X4HtJktmUCawpfpyNz6LFcVpB1QvdOlLGgrKaDbvrUscRS/mJvmY
 nNzdLoWdeWLWk3THmI/lqRr3Be1gC0wYxNfxnE/6EuJH/L14LSScN8gjvdOqBzc4Eu9M
 ir/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244651; x=1787849451;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H64/1nUw/7lLCPh0dZyI8ywBjU05RRXPc4Wjk2rvsDE=;
 b=fwPLMY2phkVkO7uBeeiIwG8ksrEKmst938csdI+MWRwPF1M3IC1LdK3Js/2VEU3blj
 kRGacAEOi6mYx1OytkWjGoykyOOiWw4m/mcJyITYmiM7k39JsRIJICuhKXq8HN0Z58DV
 RUHzXvkkClLmZgpIxeIV6uYb4afpNeUJaECiijrcgwe8hMttRSGIOe5TGockzuoGo8fG
 6moNuTtcI4IzQUqRJbfHEaiLJXJSugETax5Sf0g5HRlmSVTaD745HAOgdPgzEIyO3vG7
 JEUEVnCX1I/1SllSOOde/HKvJPFNNBr8wrep7VUP2MXQOGjd6MxaDEdsEcByaAwm1HUM
 PYKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMfOG7s7WlHvU5HAKYCMXHRkiwY7oHNlPaK69v2RXcGF559qzXYZ59lvuzz/QkJB3nksnm3ZYpkSOv@nongnu.org
X-Gm-Message-State: AOJu0YwkhIkuJnBxPRSNdK05PgskHPiSqXmMEW6a2r5ISsyWuyt+0y6u
 Y7BnPFusBjmpR4sqJgxOLubi/KqvKR9F7PaZzGmVxYWHcIJ3n2xl/CAIIBNCueFMk8zUaFYpN6u
 kzGKKWfuErCnv3xvWMSC5daKL/8ks/2sJlZVS1axNcTYngigXff6cp9AeSw==
X-Gm-Gg: AR+sD12VCfvnIMs7n+OLBuHlQpV+Tu2woezg2GkAk5jHnWKmj9GkrGMHe67HMF0+tc2
 PgjXng9DzBOWtNGJbAz79Ga7bI2M1puntpvkcW01XVNaoIKp7SmUdLYH7ENrcTo4h5pXQHv6Lxh
 6pHadYhpA27q4SJGrZvBu1RvxzA9z2a6qe2AO2eO3ipQW2LCMX0BUYZI6C9G5ZS2XIoSAOe8ZOI
 My+LTdTXygqU1RI0FceQy8DUtY3wb8ynlQZ08QTkKCZn6CMTZJJg5Eta1W//giySE+zC1ncpi2p
 b13mYMNeHkEG3v6zAlp1qlB1fkStpuyPxjIKTii+RrUmBYvVtMpMPzzoeparpgAsAW2LB0v7CNC
 CqII4qggvDHhFhSqPtDTNEiU=
X-Received: by 2002:a05:620a:3194:b0:936:e374:9ea with SMTP id
 af79cd13be357-9372849f778mr785726885a.14.1787244651448; 
 Thu, 20 Aug 2026 09:50:51 -0700 (PDT)
X-Received: by 2002:a05:620a:3194:b0:936:e374:9ea with SMTP id
 af79cd13be357-9372849f778mr785719685a.14.1787244650832; 
 Thu, 20 Aug 2026 09:50:50 -0700 (PDT)
Received: from [10.111.143.150] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784b3sm134318275e9.3.2026.08.20.09.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:50:50 -0700 (PDT)
Message-ID: <fb2425af-9f89-4413-a31e-1f22fd42d869@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 18:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/13] cpus: Add const-qualified CPU environment
 accessors
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-10-philmd@oss.qualcomm.com>
 <0b70e3cc-e14f-4737-b265-c7d12898169a@linaro.org>
 <854739cc-1275-4324-aaea-576f0a504172@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <854739cc-1275-4324-aaea-576f0a504172@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a87306c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=3SCseZUizC4PB6VshvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: uJfOXYkgKxksL1VznZbROdIJSQSoqKkL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfX79ACtVW7WT64
 YUIUSwOJZ3WcXi2cTXbj/G2JMAia6FDUdRtyhR6wXTPSg1GKeeGmUKd/vGk5Uf9QXBdzT8jv3cZ
 7JXil2CW7Zq4krX5WrWWUsu56q7uOOBZkl2tvfpAxrsTAMdqmUUIcc0DFNmeX+hkRMoJFF0ve4t
 bxrufSpjBdBGRAaApBTTQr+Stse5NvFPycj0EeHPTGQuBNFxsYIug3TkZbEr6ZIsOgwh8nhfC/9
 DFYuHrUqDdq9Ku/03AI95CwLWaTGEylrcewfsTYumGpM/3+VhG1KqYMPqi+8p444X6AxlVSasCy
 nalKmUJ9wsX6PJLCysjMpcVbjMggKSAJQHQM022we7176GOC8S57VgwylX66U+XTnIcIsTWEF1A
 zXGQwdh6jJSECEmWEyWEKTK/70X3MAfnjEFrqGDm+afF5QekU0hGe7fcd9NTDq548fnbW9lPDME
 bKusJLsiN4FTxq+1U0A==
X-Proofpoint-GUID: uJfOXYkgKxksL1VznZbROdIJSQSoqKkL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfXxXVAk61j9JLO
 2CW3mF5B2STXH/r1Mw9mOv/Z7WgBXyb6qlQ9Z8S3pRDYyG0P440poJavMS5tkBTrHDVcoBxPCxh
 3nSBA+3rLofC5KJGqOQUZYfprxNVwfY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200127
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-08-20 18:24, Philippe Mathieu-Daudé wrote:
> On 2026-08-20 17:21, Richard Henderson wrote:
>> On 8/20/26 03:47, Philippe Mathieu-Daudé wrote:
>>> Introduce const-qualified variants of cpu_env() and
>>> env_archcpu(), to safely access CPU architecture
>>> state when it should not be modified.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>   include/exec/cpu-common.h | 11 +++++++++++
>>>   include/hw/core/cpu.h     |  6 ++++++
>>>   2 files changed, 17 insertions(+)
>>>
>>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>>> index 6594f7fa1be..f3a3799f451 100644
>>> --- a/include/exec/cpu-common.h
>>> +++ b/include/exec/cpu-common.h
>>> @@ -79,6 +79,17 @@ static inline bool cpu_loop_exit_requested(const 
>>> CPUState *cpu)
>>>   }
>>>   #endif /* CONFIG_TCG */
>>> +/**
>>> + * env_archcpu_const(env)
>>> + * @env: The architecture environment (const).
>>> + *
>>> + * Return the const ArchCPU associated with the environment.
>>> + */
>>> +static inline const ArchCPU *env_archcpu_const(const CPUArchState *env)
>>> +{
>>> +    return (const void *)env - sizeof(CPUState);
>>> +}
>>> +
>>>   /**
>>>    * env_archcpu(env)
>>>    * @env: The architecture environment
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>> index 81af7b9ee1a..59f777f3f15 100644
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -594,6 +594,12 @@ struct CPUState {
>>>   QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
>>>                     sizeof(CPUState) - sizeof(CPUNegativeOffsetState));
>>> +static inline const CPUArchState *cpu_env_const(const CPUState *cpu)
>>> +{
>>> +    /* We validate that CPUArchState follows CPUState in cpu- 
>>> target.c */
>>> +    return (const CPUArchState *)(cpu + 1);
>>> +}
>>> +
>>>   static inline CPUArchState *cpu_env(CPUState *cpu)
>>>   {
>>>       /* We validate that CPUArchState follows CPUState in cpu- 
>>> target.c */
>>
>> I wonder if we can use _Generic to make this automatic, rather than 
>> have to choose between two different function names.
> Eh clever :) This seems to work:
> 
>    #define env_archcpu_(p) _Generic(*(p), \
>                                CPUArchState: (void *)p, \
>                                const CPUArchState: (const void *)p)

Actually simpler and even well readable:

-- >8 --
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6594f7fa1b..d67d008236 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -85,21 +85,11 @@ static inline bool cpu_loop_exit_requested(const 
CPUState *cpu)
   *
   * Return the ArchCPU associated with the environment.
   */
-static inline ArchCPU *env_archcpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
-/**
- * env_cpu_const(env)
- * @env: The architecture environment
- *
- * Return the CPUState associated with the environment.
- */
-static inline const CPUState *env_cpu_const(const CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
+#define env_archcpu(env) _Generic(*(env), \
+            CPUArchState: \
+                (ArchCPU *)((void *)env - sizeof(CPUState)), \
+            const CPUArchState: \
+                (const ArchCPU *)((const void *)env - sizeof(CPUState)))

  /**
   * env_cpu(env)
@@ -107,9 +97,10 @@ static inline const CPUState *env_cpu_const(const 
CPUArchState *env)
   *
   * Return the CPUState associated with the environment.
   */
-static inline CPUState *env_cpu(CPUArchState *env)
-{
-    return (CPUState *)env_cpu_const(env);
-}
+#define env_cpu(env) _Generic(*(env), \
+            CPUArchState: \
+                (CPUState *)((void *)env - sizeof(CPUState)), \
+            const CPUArchState: \
+                (const CPUState *)((const void *)env - sizeof(CPUState)))

  #endif /* CPU_COMMON_H */
---

